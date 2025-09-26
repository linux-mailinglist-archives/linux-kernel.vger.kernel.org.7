Return-Path: <linux-kernel+bounces-834231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5302BA43B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5701888D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4323241AAC;
	Fri, 26 Sep 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDvCQmow"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE283CC7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897190; cv=none; b=bOyAJGyQIxw9u+1fzKT0l8Hw7qKTDvhwXccevfBaLVv65DfM6gKnhGitVTUKWG268E0Tec6gYlZ7/EPECDc8Ky/HLZxiw+8TVsvsUsL0+Ks3mom2GucMDKEBGp/zmdVhrBTCS+loA5+urMFSfhlxKd3baiZwQJ3kNIeVwRK+8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897190; c=relaxed/simple;
	bh=zyzn3ZcezAK9aa7VZIAtRCcKzdP/B8eYrPAfL36Gs6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tl+FwQMxOcAWNem2pEt5JujTBDiBBcWn4tcNep72asVmlJrbweSwjuUchhvmECfNA01nqT3J38PYaJ8IgE3sKZ/SmM/wxG8sjr0HYeFuiu0oWsb4FqqfCRdnJUYgVcL3LhWC9ndSjvFxfBg/LXntbhRSBzI4iEn/LzbMToFngYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDvCQmow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758897187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOJaLah4ePiQxdQez6Be1i94MUmLOsj+O0iioPNAuew=;
	b=UDvCQmowGIy04KgX+NLZrLe5aIbTMxbzl9bykPp3ktMbFfaDJgt+sVfZ9CGKyLbl3CFLif
	+JG9cl84kP8wPZADPGCTlXyXHrQSmcmRb6c3DKdKwKDDAH+WiQt0Jfqg/Vg0eeTRT9Hdu6
	doqsOkmsnvlo4fTOzjUtl+8FPbSWG2E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-a2Ube48ZMpipeaQ0RNWPxg-1; Fri, 26 Sep 2025 10:33:06 -0400
X-MC-Unique: a2Ube48ZMpipeaQ0RNWPxg-1
X-Mimecast-MFC-AGG-ID: a2Ube48ZMpipeaQ0RNWPxg_1758897184
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b25f63db20bso393237766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758897184; x=1759501984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOJaLah4ePiQxdQez6Be1i94MUmLOsj+O0iioPNAuew=;
        b=p6p7V99AZoaltzksZp+ZkVw0oefrmPE+z1gCo5wjL5ahjs/IXYznHDg7bEww774YdL
         a3hynWJTvQd3SdPGMQIFkOsUFvLmPVujLqPK7zz6urAF550C/CM2RqXYo/SeV/KVHw7V
         t1rxSjZ4u/LABnrk3ntnc4QpKGOhBJ4Qbeije3PyeLqZxKKjA+rG3uAIo0rDVNJeLMoA
         zXqcNT9Mh7lFzmlx6CB62HP+7xieviSKvRwvEKsCIH1nzPuVcZVrMgNM4ZLoWsjUoufz
         MS05tqdS3yo24KW+ejKiO8IRoEwXBTJdgt32CO3YpC6bAJoTHGOwtPoG7LF8Ls4NLuZA
         8BlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHmIaiYIijOiVT2rSdUNILuxvd8CwOfHW0np+a+mygF1AyVCwmddJTN9YBcoPqPtzpcAugBMxhPQH+qqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/EUTloBU0N63NEjXDhkvxaZ5WcnVC2te5w+9ztislhS0ePcu
	qJ5GR7FHlwhTMpB+xEmXRsgVeZclWD14Xg864ts97xHTJ6FJs/gsvi6VZEnJencwb1im0l8ZF90
	slioWlma5HCu7/DRwV7S2vp58Dky7mWEJiCGPKpAbAKJxnPBAWSHV73a8HK16hvvPnP4NOGtWNn
	a2qyQyceiokTE5/DtZZjrAPvvABPECgbadGdHRveRA
X-Gm-Gg: ASbGncsVE0E1MJ2Bu+ijG11YfVpborhdijFpGDY8K0Inlf2LvK7eq7woJjy3L7Ik818
	HmKGScgJNnqAqoATaJLWhA1VtLoN+FkjJ/XT6d6Sym/p6o9dXzip8dklWrPHYkBwQEB8omfHKCi
	zHYZ2PzoNBY/rCW9MYdunZ
X-Received: by 2002:a17:907:93c7:b0:b07:e348:8278 with SMTP id a640c23a62f3a-b354d73f016mr505472666b.25.1758897183976;
        Fri, 26 Sep 2025 07:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESo+itkF3w4Rk3YxWgiaRXreqg0X/y6Z1uD9ARYPdkidf9i+Pmr8YhdRDy8sGsq6sp96MKGBRKUhp9lPqQJf8=
X-Received: by 2002:a17:907:93c7:b0:b07:e348:8278 with SMTP id
 a640c23a62f3a-b354d73f016mr505471066b.25.1758897183586; Fri, 26 Sep 2025
 07:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757034919.git.ipravdin.official@gmail.com> <164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
In-Reply-To: <164ffc2ec8edacaf1295789dad82a07817b6263d.1757034919.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Sep 2025 16:32:52 +0200
X-Gm-Features: AS18NWCTGFAnet0Nl0vdl1CmepDisUb588HKCFc7aZTYKNqaEC4lLhouSKrNNuM
Message-ID: <CAP4=nvRPXq=_WterXhaxk1ZwDSPwkJbVJP0L+ze-Cjw1foqK+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rtla: fix buffer overflow in actions_parse
To: rostedt@goodmis.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Steven,

po 8. 9. 2025 v 4:06 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:
>
>     *** buffer overflow detected ***: terminated
>     timeout: the monitored command dumped core
>
> The result of running `sudo make check` is
>
>     tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
>       Failed tests:  3, 13-22
>     Files=3D3, Tests=3D34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.6=
3 cusr
>     27.96 csys =3D 55.67 CPU)
>     Result: FAIL
>
> Fix buffer overflow in actions_parse to avoid this error. After this
> change, the tests results are
>
>     tests/hwnoise.t ... ok
>     tests/osnoise.t ... ok
>     tests/timerlat.t .. ok
>     All tests successful.
>     Files=3D3, Tests=3D34, 186 wallclock secs ( 0.06 usr  0.01 sys + 41.1=
0 cusr
>     44.38 csys =3D 85.55 CPU)
>     Result: PASS
>
> Fixes: 6ea082b171e0 ("rtla/timerlat: Add action on threshold feature")
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> Reviewed-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/actions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Could you take this simple fix? (Might require tweaking the starting
letter "fix" -> "Fix", I don't care that much about it, but as you
said, tracing requires capital letters there :) )

The rest of the patchset conflicts with [1] but this one doesn't and
is also more important.

[1] https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=3D=
999703

Tomas


