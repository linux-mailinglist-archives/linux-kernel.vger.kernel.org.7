Return-Path: <linux-kernel+bounces-844191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D15BC1428
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB663BED0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1262DAFAA;
	Tue,  7 Oct 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOPdWDX0"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03961A9F8D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837704; cv=none; b=Mfx0Hl+OdhY2dtOL1NsZSI91rrU0D4/iNBYGOkYkWRCct2470BMXG28Qp20s4SSNNIpa7ukVMkEaratAk268+hc1hTCSwQTZIiUyYA9aZvyKtc3Fqp6S9QbsWt+wwVKjrcelY1B+/AYYLTKruxJadMLl/1iR6qEI7JptKfPbh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837704; c=relaxed/simple;
	bh=qn1EW8XbpUEPfshguM1UXlEigOcP6JmSX5ffhupl2KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlvHQ5jA17UTuNRJN+Lsg7yfWGwC1xwbQ7wHTIYnm+NOX6TcftJzhaUByAhiOqUzMuft1xxBtgz/v8ZYIorMZqB3Er+/qJhTZcUxiV9mTFIx0meSbkoPEXCvHs6dRuIy+LulvMfiB+1Y3xhm4XLRvO+h+WCrP2R5YBcTLNhTnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOPdWDX0; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7a9a2b27c44so4260601a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759837702; x=1760442502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qn1EW8XbpUEPfshguM1UXlEigOcP6JmSX5ffhupl2KI=;
        b=lOPdWDX0WbtmgZyYR3ZAC442KRaJ9f8+XDHTX2q+Ds8wuJ1ZcmUOkcJUPsGL/9/yc5
         o/np7vMmUxjrlHJ+VT1z4ar2sjlttndlxrxujz9eFuY9A9pUD9NQ7st95Ezhr7mrzafl
         ZIfLfeemho2FLWHM5TiA8d4YIGeeF64G2DIEFRvlhggKWhscq1/6GZcOE2WgefRG9x39
         3BsakDcyDfkrLE7m44CmWiwy8LAchcEN3wlECXLXXVxENIKaBM/40vfBMAkNkr48apTR
         DC4pITnuedKG5WoJYfe1QqnC6WRavd3tedoyUX7ALEOekMRGQUOr4HtcPOwkQPPSJQ4Q
         Zkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837702; x=1760442502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qn1EW8XbpUEPfshguM1UXlEigOcP6JmSX5ffhupl2KI=;
        b=ws2Njy27S3tPTotuM9RxjP2cSTJrYyVRcrwn78F7L3J4+H7oPwZYXg1zqKX9u3m76q
         rYmwEMnzKX8xkudxYHEnpQo7xU7QDvjBs3OqMQQNUgXTTjV8G2vmOyHCNUCAuYf1b3y+
         SyjN3rdv54eyBpGBKnle/6FQ0Qs/6+ALFGsxt+kXuTSmrPVDDuN6DG0OPRM8BolJygpb
         gP9EW1EaadAM82pD4ZGnFlW+3E2e1vfE50AVk0T+2V7Ke8ID66dUis21VskPzCwI4XVV
         6zj+kNBOQ42uBqkmuesP8svQs0lscgKBXSTaII8Gti6jRd1WSwgyFfYoztufdx/TU/jd
         QckQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1z4KehSV/WG6TootuN8ws1Mx9xxz+OR5l6Pch5WeiClNwcYBKVAC0J728y3FfIw2Lw+1qj83e+armpoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MJ17lvIywkv824OzQ3dEYovqL+KF4LHseMhsJosC+T1k0zdq
	7K0QlTRT3q7Gl1GRNUdGTof4K7BXOhMcWc5+U3q6kvWvSTGYyh/JIR+RwZwN7Kbzn3Rtwhez9fq
	+YZ2Du291QAd0bwvZDYTt9nszSkSZR1c=
X-Gm-Gg: ASbGncsMRJMCQbwEbJK7Md5tWv5VXD3Oo62U84VvQ6G0kzT0UO9gl7rccdhToG73WwZ
	/uKIBda5TjDf9Z/K7Kp6yz9tixLhccxK5ryuwzjhlq3KS5MazZyAsY5jqx5Qy2Bzu7ulAk4ZaZF
	4wnG7hawoqx+9CpfHq26x1gwI60e0OwpgJR828JdZoUsL3ZNKcy5fELrJZdyu6FANxop8LryWVQ
	RkpmwWzXv3Se+8x9d9cfmh6ihgHvbY=
X-Google-Smtp-Source: AGHT+IGzdzdpFSUrzKoYDyvEBwJHH32FA7vjyWVUyv8QE1FR5udDMdkDZFE6Jxz3jhiDr00fWFVT+sK+ST1PFVPIsB0=
X-Received: by 2002:a05:6830:108e:b0:746:d097:9342 with SMTP id
 46e09a7af769-7c02af24fb7mr1222015a34.7.1759837702013; Tue, 07 Oct 2025
 04:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003091304.3686-1-briansune@gmail.com> <20251007113305.1337-1-briansune@gmail.com>
 <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk>
In-Reply-To: <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 7 Oct 2025 19:48:11 +0800
X-Gm-Features: AS18NWA55n0Y3VNYOKtA1T-Ox8UcdKZlQuYosvTxXbChdMgthbuz1HcL_8xi9YI
Message-ID: <CAN7C2SCHirxurUA0n2VZKEEiYCt-NUKgspGFfZLNurHhACZkBQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 07:33:05PM +0800, Brian Sune wrote:
> > The original WM8978 codec driver did not set the BCLK (bit clock)
> > divider, which can cause audio clocks to be incorrect or unstable
> > depending on the sample rate and word length.
>
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Sorry for this action. But this patch is just a title fixe according
to previous comment.
Patch body is fully aligned to previous revision.

May I know what is the proper way to amend the title?

