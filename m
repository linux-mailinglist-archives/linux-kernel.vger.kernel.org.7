Return-Path: <linux-kernel+bounces-866946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA890C01212
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7760E359ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B53231353B;
	Thu, 23 Oct 2025 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="bbtY+p9Q"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9729A9E9
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222500; cv=none; b=VfBs09QbngxVDn2DGi22vGJpLApGuR8xrI5wzfw4miuy3lMDYSXQjjD0lkLBdOaLZ0bKdRlJHu5CJZMrFZEpJrBJLkab8nehAEqRjhvuOzMTrMcEqTGzlRsVvJRtQN3d8kSE3roS8/g6bOCrFK6cokY6Lkino5hD5D/ht0H2XK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222500; c=relaxed/simple;
	bh=NRuEiGlR1P7yV/PP+dLzB7hBSKXtU0GCDSnidNKRMNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7sRgFUPIDuRGaLqSfOUE7FqT60dsczGVwdojgcOZSI5ROThy1K0KQbBJ8WlJxvRw8OjQZQO9YLSpDv6YAX+KtLfYTfP6bmf+NF5YtUKRTEGZaI20nYpG9U1m5zEJVEd6qayjkuHtdYaUKaaVEjudAhpvaugtEixkHT842tkgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=bbtY+p9Q; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7815092cd0bso9094567b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761222498; x=1761827298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRuEiGlR1P7yV/PP+dLzB7hBSKXtU0GCDSnidNKRMNs=;
        b=bbtY+p9Qq5lccw1lrW2Zhz115uH37ukbn9sKwqBv8MLeogoWgB7AadXOH7agN4VapP
         OYxBz6EUx/xth5Rv4tDLM6Z0vVB7dg9Jz6S+Y/tiyFhsszcz6972jlPI73ht/Zq9AcdA
         NM6tnVh2aUC0gHFjuM36ZeOK1V2lbZ6fGtvza71MpQs6rTFaslITLCdv6zbqz5FwVIJS
         +cfE4uh1LOIjBec5xhX5kave/wi1N/6fcRqr1hpDRvdSk9ZkBwA7diE8LJJD3Yi+uxdR
         zyUw2OUwHs2fDoSllsdJht0snufbZr1OJZnJ1jf2+D0O6ctH74vMPabmDgS2ioHm0/Cn
         D0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761222498; x=1761827298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRuEiGlR1P7yV/PP+dLzB7hBSKXtU0GCDSnidNKRMNs=;
        b=Fy/zk4nV2h5AjnxxsgY/nHvyCw9IgC+BTBDZBCVDVAgonF5HSc7Jpx+WAMTMFcKc3I
         EKAIsm/ERcVxw8UGIOoYcSR9+nB1nAm6PLNi1tzWz9JHG1z7C+/Ge9iFkU3VSy0ZvZf3
         tIDvWeRGCGpWjDyKMpY/2A9m5OjNT4R+6FIaJ4g0MtgnwNPL/mAt7yOu4ctjdPeyCtCR
         JAiCgrUVFXKm0IMVBLMbC/0keH0jsD6AzjjpXd+yUjq459Z8n0r+ZqVAyVnIqg6qAAIs
         MEX/51dXKyVtb8G2P6UUsD/yuHfgUXJXwOYIrgv5co1dn6Wsbki9MCJfNPr0hOO+aoOS
         w85A==
X-Forwarded-Encrypted: i=1; AJvYcCU2qmTAN8h7B9jrIC+B+/omg1rIeMTpNZmQSa1J3yGUooRK5GuVCqUY8gcY77sYYSby/yymNhppfQBdcTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWP7+bePs9RwJenk87FPDcaLHdPl0/x2DpdV4Hqbe97aMlvOzI
	D3E6VaZzMKe3fJN4OGqY4MfP0oPLslx5/IhYy/1rXBZHPTpmCuuTMrHQpQMq+ZWJH7uNJliNHq7
	t0afG0excXFOlLlfQUy+e77FWiey7tRMdaKthXvwqbA==
X-Gm-Gg: ASbGncsbvZld7N4VGKAnB8w+KNiykC9GKpf2SkeMdZC+Yn6iHMPQ8bjX+HXFnIdKTcz
	UphzcHi3plfUYMRaWLDrXX970xj4lvQe5j3UcYexBQkO5lZf9jgpU//vhO5z+GOE2bfL5hnCq8b
	Vs2kwuFdKuqYVteyRwy2oihcmbxmaQAe7l9FJklYhSCEPMeES0wisEUse9x0wDl3ltwHhjwdhh/
	1VqnKnnwKXly5mVvKOtOOZhUSgw3zhs8AUdOBAwrQZeN7mXbdgn3Dajjy4MfX50UwCHBLHU
X-Google-Smtp-Source: AGHT+IHPdOwhOaGe9iCo/jmJBjE5mGyJmdeKgFJXCNxjw25XlX18zDCJznwpoZz2/B7vt5wZIicUgZEuvLAzx18kSkA=
X-Received: by 2002:a05:690c:600f:b0:721:6b2e:a08a with SMTP id
 00721157ae682-7836d2d6737mr364106547b3.37.1761222498021; Thu, 23 Oct 2025
 05:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io> <aPeZ_4bano8JJigk@strlen.de>
 <aPghQ2-QVkeNgib1@calendula> <aPi8h_Ervgips4X4@strlen.de> <CANhDHd_iPWgSuxi-6EVWE2HVbFUKqfuGoo-p_vcZgNst=RSqCA@mail.gmail.com>
In-Reply-To: <CANhDHd_iPWgSuxi-6EVWE2HVbFUKqfuGoo-p_vcZgNst=RSqCA@mail.gmail.com>
From: Andrii Melnychenko <a.melnychenko@vyos.io>
Date: Thu, 23 Oct 2025 14:28:06 +0200
X-Gm-Features: AS18NWCPma5wE5y2xe9JBDWGT4k5clLS_A4FnlSPmz2JjrF1PCHSnh_T4kzSeHM
Message-ID: <CANhDHd_xhYxWOzGxmumnUk1f6gSWZYCahg0so+AzOE3i12bL9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I've taken a look at the `nat_ftp` test from nftables. It actually
passes fine, I've tried to modify the test, add IPv4 and force
PASV/PORT mode - everything works.
Currently, I'm studying the difference between NFT rulesets.
Primarily, I'm testing on 2 kernels: 6.6.108 and 6.14.0-33.


On Wed, Oct 22, 2025 at 3:01=E2=80=AFPM Andrii Melnychenko
<a.melnychenko@vyos.io> wrote:
>
> Hi all,
>
> > BTW, this fixes DNAT case, but SNAT case is still broken because flag
> > is set at a later stage, right?
>
> I've checked SNAT with the "PORT" FTP command - didn't reproduce the bug.
> I assume that `nft_nat_eval()` -> `nf_nat_setup_info()` sets up seqadj
> for the SNAT case.



--=20

Andrii Melnychenko

Phone +1 844 980 2188

Email a.melnychenko@vyos.io

Website vyos.io

linkedin.com/company/vyos

vyosofficial

x.com/vyos_dev

reddit.com/r/vyos/

youtube.com/@VyOSPlatform

Subscribe to Our Blog Keep up with VyOS

