Return-Path: <linux-kernel+bounces-828872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA83B95B61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A84416A32F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A6322541;
	Tue, 23 Sep 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TEIq1Xdz"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CA32254F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627699; cv=none; b=Wk/flE7LymAdP5UD9kuw7P3P76DyAVd1G+OEQ9VTOs1RQMbcT/nw7zSgzCO5h5mFcL5D7fzp5tPuHDZQmZs0JgbsonpJ3EhPbQKg+NVvfn+tC2Fltg9Vy2m77m4Kx7MsZfjFsMxX2xZAP1E208N0z3PRWUB606OFotVyZVA4uUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627699; c=relaxed/simple;
	bh=ni/iW7lHvCETYsNLqM+6mrbh0nHcxoeJh6ppyyodxBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFwdcNOB4pH5hsqLQj5Iy40riq6dNTnK/1/pZmZ1ex4PskNTGJbKsLu/EEvYOyIVEg6tpZamuMgD3OaBuW79FuRYAHM2LoCikEjlPu8C9+S2KzAIOROraJ3BC8tbAH900AiqSKNuyPLK/M60xH4xS6KT3NUjwqb1ZYEUsDQRxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TEIq1Xdz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07d4d24d09so924772866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758627696; x=1759232496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWyQsVT69lCH4BbHgJw8BTZrGLVn1LISbLgsWJksB2o=;
        b=TEIq1XdzVLF77z4gEHT1fsE3L4HBLibKdBczYVqWf8T4vAHkEzOUNQjoQZK+RJg0yP
         BpcHI5HcNeNYru8NWnvpNQkJhRncO+2RjpcDMaxB80XlX1jgspldXmJvH1VF8sFR6lI/
         xjqwyIhDhAFf4QuygwRPeJ5PhlzRkcrMSymlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758627696; x=1759232496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWyQsVT69lCH4BbHgJw8BTZrGLVn1LISbLgsWJksB2o=;
        b=JbgGhPltthjEKTbrvXYLmZNfrqpDM97X2ox0+DpxJfcAWp1bkNwHM60d60G45O+zUG
         cX2g27QOefOLYVyscdEhk3M67Thq17fiSEUTdaS5EFXWLCnqOCg1UZg0Jf7ulFnzga/S
         7Mb+I0a1KQRLMfpLzeL4Le/mNG5RzswQwD+eSKGP4Tj7TEH/Ln4WfIXexD3zSbmMBltU
         un8+b8Ut0k+KhIrWLLA5DTSmyjEkt3DUg3oIVBAdm2rZF/CJjxKcoX8n/DYdcGSfZ3C+
         1IHULc4M8g1Mv0kBDg2zcmg72AZgm9yLARqu+dA3I9f/W2FO6lLcT+eUMaJpeNynLW3Y
         ETtA==
X-Forwarded-Encrypted: i=1; AJvYcCVluZFDlWD0/tmH5YlDAlsje6IM7D0j+qHB24792JIOGQhA5gR9DuqFou6XSWm4x7cU3G/TeWCOt4r9is8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/3V2toa082LJmhT9c2wLAQa+a1euj55simkwDNdm0obj8tnh
	j0w6ejj0gQuyJ3zXsBo+jK/a61O9fWfJ+CIeV1IviPgxvldlj1QdnRXLX5qUJT9f6btpWidZrVe
	WLS6moOlHOd3q0WfnuoYdH8sWag+gIE/2csL4wJAP
X-Gm-Gg: ASbGncuQYlHUjnz4wlQca1ujNOhdnC4/jlsLat4ULF7h/KU9XJf8Nzb2sIAP3wiwt4F
	5JhCMLYkvJ8+aRBPkThJhhtaiJFYkYFxroH0/OlbKAvuOUCUZmJ2zVSXFUNvTCNTydjL6orU1Px
	59JDM0V6k8tFdbf/6rHuHy77JXD+eMGDFjryFwbwDiQuoqmp7XzyLYqJjzFaX4KSnTkGItz7Ume
	eEe/w==
X-Google-Smtp-Source: AGHT+IGrdWASkDi0uzKstAS6gCO+IkX+beb6qDtQM/pHo/U2gJML4F/8n8aKHXSqRtEtzuVCYsCIm2sq6lJUE+SBu9U=
X-Received: by 2002:a17:907:3cc7:b0:aff:17b1:dde1 with SMTP id
 a640c23a62f3a-b3027262102mr225357866b.1.1758627696464; Tue, 23 Sep 2025
 04:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922224835.1918759-1-sjg@chromium.org> <20250922224835.1918759-5-sjg@chromium.org>
 <c02f08cc-0613-4e57-886f-9d49803cea00@infradead.org>
In-Reply-To: <c02f08cc-0613-4e57-886f-9d49803cea00@infradead.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Sep 2025 05:41:25 -0600
X-Gm-Features: AS18NWB4EKjOIEuMPIXmxBf8Tvh6v8BvbRz0KdMc1wY4lFgjkq_tIGSsRb9Mi1A
Message-ID: <CAFLszTjZX4raMaxG0mk1Tbborh8=ZBJWSCxAL_=4H-G1fQ6f-Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kbuild: Allow adding modules into the FIT ramdisk
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Schier <nicolas@fjasle.eu>, 
	Tom Rini <trini@konsulko.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	=?UTF-8?B?SiAuIE5ldXNjaMOkZmVy?= <j.ne@posteo.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Han Shen <shenhan@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Rong Xu <xur@google.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Randy,

On Mon, 22 Sept 2025 at 17:08, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 9/22/25 3:48 PM, Simon Glass wrote:
> > Support 'make image.fit FIT_MODULES=1' to put all the modules into a
> > ramdisk image within the FIT.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > ---
>
> Regarding $subject, a comment in scripts/make_fit.py says:
>
>   Note that this tool does not yet support adding a ramdisk / initrd.
>
> Is the comment incorrect or are you changing that feature here?

I am changing it (in patch 2 of this series).

Regards,
Simon

>
> Thanks.
>
> >
> > (no changes since v1)
> >
> >  scripts/Makefile.lib | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 1d581ba5df66..2e880d9b4706 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -398,9 +398,15 @@ MAKE_FIT := $(srctree)/scripts/make_fit.py
> >  # Use this to override the compression algorithm
> >  FIT_COMPRESSION ?= gzip
> >
> > +# Set this to 1 to include an initrd with all the kernel modules
> > +FIT_MODULES ?= 0
> > +ifeq ($(FIT_MODULES),1)
> > +EXTRA := -B $(objtree) -m
> > +endif
> > +
> >  quiet_cmd_fit = FIT     $@
> >        cmd_fit = $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
> > -             --name '$(UIMAGE_NAME)' \
> > +             --name '$(UIMAGE_NAME)' $(EXTRA) \
> >               $(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
> >               $(if $(FIT_DECOMPOSE_DTBS),--decompose-dtbs) \
> >               --compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
>
> --
> ~Randy
>

