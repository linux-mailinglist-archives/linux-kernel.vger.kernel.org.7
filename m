Return-Path: <linux-kernel+bounces-890947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0FC416FB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613964E6D59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064530103F;
	Fri,  7 Nov 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PerZgW9/"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A73261B99
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543697; cv=none; b=MDrzaiLCi5AgqA24QXb9AzNKwTN6Kxn3wzc445zu0oasPrwiyFzwZA9S2A5oEzYay4IzJoB2CIDgXKZFCPPMCGZ14q+tB35fH8/qWt1YOArFePbz6rXdVbOl4tGNS4BzGCq6Qf0XV2CD7x21UW2YFfb3H8nvcD83pgZ9jg7qlnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543697; c=relaxed/simple;
	bh=/qs9Kz/VvTemB2KCsq7rLMRP35wSkzZZ5ATLF/F1kBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooF/c1Nuf1YN+s5BbimxXlsJlIM47OJVItRE8HBtAjVsy9nhesCumhlzJLxt8n1iWQtYiMg1a7WTtp66pAZuWTQ/NynHb4DhnxZkBq6zOfhbwnMAAHHuJmhbcYsqLlO2Aw97SIRpjTcg+YumfqzK1gTNOwwxrrRwPMedLk0JJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PerZgW9/; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63fc72db706so1138803d50.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543694; x=1763148494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCf0FGqMcc2XvdVlS3FupM0HnEo5ZlFgJ9AoqitPiqE=;
        b=PerZgW9/p5u1FPJKZePzEP74bWm7SVlTSXd7UNO3KOGXseTBch1TQkCK6w3tRDF0XE
         uL+kr/pOliP7wcRRzChnEviRmou9Cs98ffvtdjCBVJ1O0Aj59iCJPwR+N7rfGOVsPlNA
         IdhNlgyDoF+cM+L2bLmYwQvMlT2xHlsUV4OziczMuTLefpuKbe+VLMaEBi74/oVSCr1+
         43q/vi8f2O5BVhwcKWvMtBT25EUDHLxGn5w6Qrb3I+zGVFFJgVkL++q2xz/PTjOTbTdE
         vdZu5NSMq5pvfw13qo/Jax/80OePxzr7s9q6xMXeCORiaQ6DxLiAzexOSLE3cHivROiK
         xkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543694; x=1763148494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCf0FGqMcc2XvdVlS3FupM0HnEo5ZlFgJ9AoqitPiqE=;
        b=bDSXhO+7Q4ZZ6QqBxupaspAnvL6WM4wzXARAz38AE4IHjYuvZo7dnsqZ/6NUzVV3d5
         qQ/v2Si3xZ4Qi8HLhDnbBWsDa9liF5GKGHFlkhM6scd2RG1bkIsQeTUY5y6ubNxodNNa
         xFa7PwljQVTyZq5ibRB6DYIJI+/ez8poMbOEdTU+xV20WAo2aW0pkAyrJ88v+2Lvdi0c
         ERHHgIp817q4Kjs65raw6gL87Rd412LqqZPBr3CsawmzWecXbdqUp3S6i64yiKuE2Oaf
         th6UkhsyoJkzn1j3v9BFXeBIm78XFa+mxGy80q51i6JoPMn4/GV8G8sn19nqXS18n40U
         hhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUai9EPt/47Z52CyIWb6JH6GbYIy1mZoYYxM12NWMVKfqCEtbkyydd0cKa6WeHLTD56wYC+/RhNbmn/y6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTinDDxlpb+2J/3PzjrpwSKCai5KVcNWw5aNfsMH0O5l3AKt8V
	Ytw6XEQ/Q/SgpI0Pc/66SrcQgekLiD+GYN/ShYRV2JZ8ArKUv/ZdzIwOl7SujkqBdn7PNVhtobq
	kcjYqKgj8j3d/X4GdQu4oKLD40DAtYN4=
X-Gm-Gg: ASbGncsvJWJgjg/54obtRyoKxb5FHlIeg2CwMF9VYNBSzPIpB85yGOUtUKy6bMam5JC
	NMoYBmEhdQb2LOU9/uG5x8JX3orbdfU2JH9rpoAa20W5N+61rUqpe4PGCTBGNjBuYqGi6lSURdF
	Jt8eyx0SHFJ9VN6jEvJhX/8rraXvxKFJwo+yqNixJIMvSyXyxVhAyMRrby4NKKG/f67vZzNzvgu
	OcG6f3nzLXCpHPaUjkDGIFNIDw4T0Ah5jO/4uIlXq9UngO7rIXsV6aaS0i/XF1MDUlg3WAS+Q==
X-Google-Smtp-Source: AGHT+IGnVjpXRvKwFbJeYUFIsmZGICbvd8XOwNdFBtVZeWHz57+8G+PRDBNRvxza4sRwH5i/atri7E9kRv8uaEPanWE=
X-Received: by 2002:a05:690e:2513:20b0:63e:2598:54b0 with SMTP id
 956f58d0204a3-640d4552a35mr158109d50.26.1762543694431; Fri, 07 Nov 2025
 11:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106185938.6419-1-rosenp@gmail.com> <20251106185938.6419-3-rosenp@gmail.com>
 <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050>
In-Reply-To: <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 7 Nov 2025 11:28:03 -0800
X-Gm-Features: AWmQ_bly-VZuui2gAqiFKI3nncbBCd3kvQg9qbtpxUD3whaTwcIMolQF6u15KTI
Message-ID: <CAKxU2N8QHoQxb0ddUtMTtK6psL4gPPGSTwTf5X=7py22GXxkrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:30=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com>=
 wrote:
>
> On Thu, Nov 06, 2025 at 10:59:38AM -0800, Rosen Penev wrote:
> > Allow the buildbots to find compilation issues.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/fpga/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 311313f3b282..f2e2776acdd5 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
> >
> >  config FPGA_MGR_STRATIX10_SOC
> >       tristate "Intel Stratix10 SoC FPGA Manager"
> > -     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
> > +     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) || COM=
PILE_TEST
>
> I don't think it works without INTEL_STRATIX10_SERVICE, maybe:
>
>         depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
>         depends on INTEL_STRATIX10_SERVICE
>
> But INTEL_STRATIX10_SERVICE depends on HAVE_ARM_SMCCC, and they all
> require arch configurations...
Yeah I don't think INTEL_STRATIX10_SERVICE is needed for COMPILE_TEST.
>
> >       help
> >         FPGA manager driver support for the Intel Stratix10 SoC.
> >
> > --
> > 2.51.2
> >
> >

