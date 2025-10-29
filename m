Return-Path: <linux-kernel+bounces-877191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEFC1D655
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58E7F4E24D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F03161AD;
	Wed, 29 Oct 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCYmfsCb"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1D3161A5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772432; cv=none; b=lD3yn0cRnV6goL0rDlh2LeRS0l1TaiobRGxsuV1um+3XjBw+D38F9vNj83fu8bQHiMS5nZ6meMlUacb8ecKoRpaws6U1FG+ZMvOc4F7L6ao2U9XVFiBK5VwWBwGnirs4dmsllEdj3tSEStQNW1K69Z7r3VyG3dgnsF0yn0vhU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772432; c=relaxed/simple;
	bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxuKgU2zhFHdDGrmDPZnULaM4Jsk6/D0+O1NPc7uloXK5ptep3NGDq1Ri62T9HGdsgHEN2AxThGq/AhCX7gj8o4wV9dJCbo/1fVuhWOMyGGmZbVmXLfOEYeJGT53k/71g6xfMbVYjAw0TjKlP94UUR4RR1bfsNx3gRMkO+dN1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCYmfsCb; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso2201413e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761772429; x=1762377229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
        b=nCYmfsCbMA9NzQaa64kEC4baExLRtapT8fdvk0MH1d4zIRtbMvV0rLZ/ptvT0vq5CH
         +HkkqrBp5hoG9mo4GWeyy0x7qGtAdVpMS8K3dMJpsG8R4Gt+JjDASlsjGYQqmymIoVyT
         A6Sryrmiwb5pfkfJp9gETz5OEwTM4FvK/RviWFqKH+bjnkpz5JWpDmMTDjF4RehWZFUL
         PWQrbsWOFTWFRGCylRTz4MVqnJZ/baSDn+D5saaFFFU3XmtfX799iUDrSmrCGfm9+ds4
         P9T3r0jAjxlhY13vVHr/97QV9jAZlnFLnIVoGydDVThAbYOXAg19krfWu3pizUwtsxj8
         vr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772429; x=1762377229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkVL2yw/xHlwVM5DiMfV/wkuCa8mgAwcpgYx81B7GM=;
        b=pq7/1TxggrQ3ZXfa3Qr9RdkaflYaV+5lGYFRppLzmHYtkh+8PvaGxyTqrQ35xqrQ4h
         /h3c5ObZp4QZvS+oPn9JBnkCQ5xGUExeZ5k57kU83krw0XRjNc4qJ6rfgtsx/plCNP8y
         e4M/g9cYtZbf8DoI6d6uuTq2bwG0knLVvIx7orIvzkxB1nkBojuhY+rG9CnardxCJ7LN
         BTb7DDcx5zYTSDLpD3hhV21dAJZnAxYm587JB/MNIKEoXVtn9t/p+J9clgTjNnKz0M7D
         zMcAmUn0/H8RV22OYuE/4d/CcQqufRsVf2GQVIAYabBjNn6Kj6Iyji4xVo9JDj6v77fQ
         rbgg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkSAgtt2HDiEgpUM1NJErGzCWFmtMUXen5WP058TOEggSQ9nmir3YKdyJZBpGaO5jFehtWG5xPW5sa8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vBq75aB2XekIjOBT1n6Qkctbd/QjYzgTu4jU51IGq+X6RjAm
	3APwY+gLL3OwdmDIYtgQlsvLvRlu4nQPQJt5kE27soHm4lojG02RpB39idivCkwDU+OuO3V6YOO
	/+dGq1Reo6SkKykflMDqWLbUjM/3JoZuUkV3rTVhc
X-Gm-Gg: ASbGncsx0DMt8rpKgmPR+Dy8z4u/QsSDrLJoRcHLRK4Agew8gLS/68EtR3E+IDpOrFd
	JQjNaRe/AweuzXzkYZVG4qfhGnnVdIdfL+MPS3S9bWv2X42gX3PwFCGsU+Y++nRseUoMD8fvTdg
	4HDYk+jvx6ziAqNDkXsHgEw5jSaVVD7N7gErfqGxmhEae5t2FDov8hTAoCASKFlFIdrPc4DTl72
	IT9APTUfqhSvazzjf49hoHvjVw/af1lbRXEBirft7esIF8zVHziq86vNU2IjbqnA5gobhvmXLdM
	aayrNQ==
X-Google-Smtp-Source: AGHT+IHZQoB9yL+ldFaXMM1bMXJiwccZfdn7OWdIICrdEFPtCJ4NB2qUJ+qk4p2BEZhWEpH+XIXLyp9M3uzoemzEy4A=
X-Received: by 2002:a05:6512:3ca2:b0:58b:75:8fc6 with SMTP id
 2adb3069b0e04-59416d8ce02mr294670e87.19.1761772428439; Wed, 29 Oct 2025
 14:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
 <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
In-Reply-To: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 29 Oct 2025 14:13:20 -0700
X-Gm-Features: AWmQ_bnOObc6BWBaYvrzlZGN0Gzs0AQqmxe0DWfFCoP14pNjDRBJcsWZpskW2fo
Message-ID: <CALzav=frK48c1=nsbVJ4EvqqOqr33pUArP4G17su0hxOYveALw@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:13=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> Simplified uAPI Proposal
> The simplest uAPI would look like this:
> IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
> LIVEUPDATE_IOCTL_CREATE_SESSION
> LIVEUPDATE_IOCTL_RETRIEVE_SESSION

> - If everything succeeds, the session becomes an empty "outgoing"
> session. It can then be closed and discarded or reused for the next
> live update by preserving new FDs into it.

I think it would be useful to cleanly separate incoming and outgoing
sessions. The only way to get an outgoing session is with
LIVEUPDATE_IOCTL_CREATE_SESSION. Incoming sessions can be retrieved
with LIVEUPDATE_IOCTL_RETRIEVE_SESSION.

It is fine and expected for incoming and outgoing sessions to have the
same name. But they are different sessions. This way, the kernel can
easily keep track of incoming and outgoing sessions separately, and
there is not need to "transition" and session from incoming to
outgoing.

