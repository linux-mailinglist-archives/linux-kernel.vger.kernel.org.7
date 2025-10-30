Return-Path: <linux-kernel+bounces-878827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A05C218D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C5F1882788
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111B33EAEF;
	Thu, 30 Oct 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQZjQDcG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30801192B90
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846529; cv=none; b=APwiyq9VnRTrc4dSB9+BLGmyD7ra8rUX6AaXll0iKY23S/sJx7N6iLCLCUjf6fv9tamQ3fyk9IV8ehpxQuGUsBgvclZXkNkHik1BOFYD6gRQwHjWrIuq8Bl2yZ+NyvbaARH9SvGNPP9ayTudrlMq/prRuDFQXClWrwFnI3kmHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846529; c=relaxed/simple;
	bh=hvY2AMeEF+akSyY9xQ1EJHrpfTQa+amr5KHr3IBGL+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfY8u9g/jR/YlMrP9sf0fc/ixoyYqj4GdXQPvAtwQbIo3Ivmjziu4Tw9mxXJIJEXs3HUuy6001pK4Ue58fc/dTCzdPit4G/6naPxKBGRhO/CIIeWx+JbENAjtuEghlV7yiHrVYjwAsEIv+LXGnp1Ki4k0IvPRz+sXLV1QczZphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DQZjQDcG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d78062424so153987266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761846526; x=1762451326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rh3v1Ouyt2/LL0f3ahZVxJ6mw6N6zXyY0nD5+7NxUoI=;
        b=DQZjQDcGuTOKSLGYXJ3033Y4M5Jd3QS0jaUUYEFbAp3e4UxkdKtcELU0ZT9VUGJ6ap
         mHkEcRSvM15uT2F9zqUZFBfYKdAGaPeaiphEDsC0zzxtwATRFk7Vl0jqGzqJeaWIWBig
         ZiXOcp3arKHBLS8NrrVCtgFM1uNQy82eAKUsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846526; x=1762451326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rh3v1Ouyt2/LL0f3ahZVxJ6mw6N6zXyY0nD5+7NxUoI=;
        b=YCHgoIx2z7OoXF4myfqf7RPAUv5W4Uh8Qa+E31MUSse0Um54YZqko4vRSBSDXwNAzB
         lzYM8DgH31xCVivULfuSFOccqT/QyLjPpSBW7mbNQ1PnHdb4OLWBWTTOuT9cs/NwbmVn
         wd3g+4JX9M5ZetSNXcM1a0yd8wy2RO/LyrktSeJyKHj1OobD++xpoEmjNUhw2lT/1f3X
         0PwSnQirs3qDIar5nsBASXCBGlLl04/+zBvAREVsYbnA3+Unwh9/cgXJp7MyAQfJ50vA
         It5lmSslGM51jrnXey7hkwjaQZ4M9GIf58YkwLoAxO5kxMWVWqLwp/9oMntP8euQ00hU
         cqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY8BRcWWS5y8UBCVEFvDxnv86nODqIeNehJ9fxx0J2gT3HoofVMWLU7M0Wcyb1bvSXTshIoajokPI3Mnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mcnGAdkIJkWpCUIPg8hAKnrAIjWOu6Fw6SE7TWBikvesWSms
	a1l29XoPuEbwS5GaVNUhFpyyH3Gf7Z8nCvekENvxjkJbpDbofVIZ0DcIdK/0MlwcWzf3XimO7RY
	+LWaiQegcoaU0LJmAVZnOKResQRmtm7A+RLkVU6Cz
X-Gm-Gg: ASbGncthvMObyLHPaRuBaNDxWdmHhIQb/e1HYNA+VAWaM0bkhuZcqMguu32u92yc/rB
	acsXd1ISREQ0nKrduiZEjWWr7EBEZpM7sCADvP55pg8AESX5RBIce8loPZr/M6QWHqqIdrYjBkq
	pobWYlPvOlPPCM49PmxlI5lmRr+HH2nuXLZULUP4EODqjY84AZADRNro/XY/EVw+bgwK4QvQe6X
	K8Hi33eNvn3pQj3WVPURNtAknb1a9wEwchNGgiI4HrVFSwsZxr+55JnhD9i
X-Google-Smtp-Source: AGHT+IFqQURgiVVoko3shKC6Bba8izDNAkvb/wrfoTaAwLNWBZJOf02mJMQvX3esqCeLaHeNf9hngmACT/ffLDzYAUk=
X-Received: by 2002:a17:907:96a8:b0:b40:8954:a8bf with SMTP id
 a640c23a62f3a-b70700dc258mr41404966b.2.1761846526480; Thu, 30 Oct 2025
 10:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006230205.521341-1-sjg@chromium.org>
In-Reply-To: <20251006230205.521341-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Oct 2025 18:48:34 +0100
X-Gm-Features: AWmQ_blfeBNw3Xuud5_t8lUhFAGElC9C1cTXKbT5FkRt30uiLVTs4DdYWXfmWS4
Message-ID: <CAFLszTibSrTwhGaRZC5HF=UYnsdi8q0j9pyNbEL7jKSnYd6hBA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] scripts/make_fit: Support ramdisks and faster operations
To: linux-arm-kernel@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?B?SiAuIE5ldXNjaMOkZmVy?= <j.ne@posteo.net>, 
	Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Sterba <dsterba@suse.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Rong Xu <xur@google.com>, Will Deacon <will@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 7 Oct 2025 at 01:02, Simon Glass <sjg@chromium.org> wrote:
>
> This series updates 'make image.fit' to support adding a ramdisk to the
> FIT, either one provided as a parameter or one created from all the
> kernel modules.
>
> It also includes a few performance improvement, so that building a FIT
> from ~450MB of kernel/module/devicetree files only takes a few seconds
> on a modern machine.
>
> Changes in v4:
> - Provide the list of modules from the Makefile
> - Reduce verbosity (don't print every module filename)
> - Rename the Makefile variable from 'EXTRA' to 'MAKE_FIT_FLAGS'
> - Use an empty FIT_MODULES to disable the feature, instead of '0'
> - Make use of the 'modules' dependency to ensure modules are built
> - Pass the list of modules to the script
>
> Changes in v3:
> - Move the ramdisk chunk into the correct patch
> - Add a comment at the top of the file about the -r option
> - Count the ramdisk in the total files
> - Update the commit message
> - Update the commit message
> - Add a way to add built modules into the FIT
>
> Changes in v2:
> - Don't compress the ramdisk as it is already compressed
>
> Simon Glass (7):
>   scripts/make_fit: Speed up operation
>   scripts/make_fit: Support an initial ramdisk
>   scripts/make_fit: Move dtb processing into a function
>   scripts/make_fit: Provide a way to add built modules
>   kbuild: Allow adding modules into the FIT ramdisk
>   scripts/make_fit: Support a few more parallel compressors
>   scripts/make_fit: Compress dtbs in parallel
>
>  arch/arm64/boot/Makefile |   4 +
>  scripts/Makefile.lib     |  10 +-
>  scripts/make_fit.py      | 264 +++++++++++++++++++++++++++++++++------
>  3 files changed, 239 insertions(+), 39 deletions(-)
>

Are there any comments on this series?

> --
> 2.43.0
>
> base-commit: 4a71531471926e3c391665ee9c42f4e0295a4585
> branch: fita4

Regards,
Simon

