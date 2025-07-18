Return-Path: <linux-kernel+bounces-737128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39021B0A81B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B955179C74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7E2E6102;
	Fri, 18 Jul 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKGxqeDc"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC612E266E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854776; cv=none; b=LNlL8O4eco8HVRMT4fbFUXsuxwm2bgDlYNXLEYrK0O6KxJ9GuelN0qtFJq0IrGFVKW9MPhcTKm6IEck1a068i40Fp7XHteHLUoMNoDwU78mAODqUY51B/Y0ndGrLoyF/X2br4B6flnKFDQWBLf/v/6Qm7pnel7iNbsUH6DbDPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854776; c=relaxed/simple;
	bh=ST8lcJ+2yDbKpXgUqoVEvCsnKZ/+vATfwEWuT1/oEC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHZn5OUSVaVS8EZia0GYB3OiIx1EdrDIyErDOty+7pwYjRMRcYjtbJY6htIKPbojjjrb/HHMQtw/EKXV1zVsW65WoXrX5ZTWq5rsePTxXoqsSWpJ5UnueAt+p9T44W1s1PVB/Ko+4YyfkVvYcWmklco+F/auEV7/J2sX2ALQSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xKGxqeDc; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6159c26766fso1021319eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752854773; x=1753459573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/Q1Nu3K5LZZ1ceVlLq9+6xcxFVBX4qH4aUvmo3kZ28=;
        b=xKGxqeDcnBAvtDtPmvid5WykC5mC1K8JTlADGnqnGVwcEIGpmNVrqwwEWWBFekq6Or
         wJO28NV1uyBoXQeg/VUemHI0hfjdGrxo7YORl6iRBBT8dORydOfrZ11zSPmSCJS7m7US
         D21GmL3IZB+naYS7FrEbDWIUmh7gvr6+yvp7EkgYkh91jOZZxko1Gbbpx6I1Jz3Jz6vq
         tPv86GFzUu4ivijpMRo6ANsQC3FaVgm7mlnjMFtcXOXZGFmq+/01+rJI4lBhVgwP/Wej
         I3UJ4L97q45pTSj7WpbxinRkL+0jZ1cGJ2ilAEet9fJW/y2yF0+4zRVcc+1DU4KbWcn1
         ODVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752854773; x=1753459573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/Q1Nu3K5LZZ1ceVlLq9+6xcxFVBX4qH4aUvmo3kZ28=;
        b=BpRtCUgqey8fXM9dtYvkey5erC7HlcmX6cNbSY4Z+VMfAbyv/Y7JJEAuPhuMRMrrb3
         Nyo5LfC7MmoHKX/lqH3LNrO6iaR65TxbtXEL80Q+unhYyx6PDcde/RYvvkGfcJdaJkcs
         eJML8oOp6SrzOF0CPZ+eEAktA5mO+pnlXRw/EaH9P2plpYQGktb0HI37DnML4of/L8I3
         VTDmeuD9AMEYHM18lA1tWB6dvkr8qCe7n++uZN/kelxWR3NgkwC4nO1nMoPbHNMfepjB
         tCCp2p8suokpDdkvW14/nAKC77uQCTrZi+3ax4qDqaYLYEqlclOezqqNfpduiGBQNQSV
         mzDg==
X-Forwarded-Encrypted: i=1; AJvYcCUzzfX9UW7SHl7qxuQ7jZ/qiIzl+uJ2SxOFtgR0bXKSXQrEm33Y9mnnujNUxo8PN3RE7M6kR8BDsP4wXXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiG/BYrPSNq3ewjMWGeVCfadJnUDAvpEQCdgPlFF+slIc7HbI
	KP2iqS3+ezBmWwTjackdUY+E1FLwNgLqsznUAkJTR4lHJd+hwGz9qcwg7hAhCbvCYVD0CM4M4ho
	Cb/c/
X-Gm-Gg: ASbGncttcTmktovLuQeXYgvnW1K/NVC1uDK7mK0Yr0KNn+ht7RiimYRefy649YWa8tC
	1vYdtXhjmHYAHsAIk+RsjbxReHUjRF4hv3RJ+FZSAmImggdeqgBOmayLcwC1CvQOF1yCQi9GVLv
	ziC2FViIaCIBKZSZYwxvytoIeHF5JXQaSZJTMHXZIMuoskIPv7z4VJmzgraVtoZ/ZwajF2eTVHk
	oRIOaRvBvf8hZaP4b06iCtkc1akbQAGEwrpdktA/3i2RKaxFrpnS6kRu+z5AV5BNL5FfORVrC2p
	kvkpYuE+an0iP5V9skDe8FpLZa6ibNZiIbZWdY3cwVYDEn1wMqHu1yQBuM69gmStj6c8SGJsYMu
	laIjHAqK5fz/W/Q9uYMHUiy2y8ZAPTg==
X-Google-Smtp-Source: AGHT+IGeuPdqUEt/1o9qCSn3JuCLxLBD7G98jAwQVyZLgiGe8We//F5qCqqXh6NWoKStNnOYX7sQDw==
X-Received: by 2002:a05:6870:f603:b0:2ff:94d7:b006 with SMTP id 586e51a60fabf-2ffb2251036mr8483664fac.13.1752854773078;
        Fri, 18 Jul 2025 09:06:13 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e5d3:a824:1a57:fcaf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-301b01d2df8sm228752fac.31.2025.07.18.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:06:12 -0700 (PDT)
Date: Fri, 18 Jul 2025 19:06:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	llvm@lists.linux.dev
Subject: Re: [PATCH v10] staging: media: atomisp: fix indentation in aa, anr,
 and bh modules
Message-ID: <8f7db034-6b38-44c3-b841-ef4bc1db3973@suswa.mountain>
References: <20250718-new_atomisp-v10-1-54bdff660058@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-new_atomisp-v10-1-54bdff660058@gmail.com>

On Fri, Jul 18, 2025 at 11:02:14PM +0800, LiangCheng Wang wrote:
> Fix tab/space indentation and move a standalone kernel-doc
> comment of the 'strength' field of the struct ia_css_aa_config
> to the whole-structure one.
> Align with kernel coding style guidelines.

There are too many changes all at once and some of the changes are not
described in the commit message.

> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
> index 899d566234b9d3a35401666dcf0c7b1b80fd5b31..488807a161b9a6ba9ebc4a557221cd21bd1df108 100644
> --- a/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
> @@ -16,25 +16,21 @@ const struct ia_css_anr_config default_anr_config = {
>  		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,
>  		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,
>  		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,
> -		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4
> +		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,

No need to add a comma to this line.  The comma at the end of the line
is useful when we might add another element to an array.  But here the
length is fixed.

If someone were to add a comma here and it was new code, then that's
fine.  But I don't want to have to review a separate patch which only
adds a unnecessary comma.

>  	},
> -	{10, 20, 30}
> +	{ 10, 20, 30 },

Same here.  This comma serves no purpose.  We can't actually add
anything to this struct.  What would be actually helpful would be to
use designated initializers.

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
index 899d566234b9..3de7ebea3d6e 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c
@@ -11,14 +11,14 @@
 #include "ia_css_anr.host.h"
 
 const struct ia_css_anr_config default_anr_config = {
-	10,
-	{
+	.threshold = 10,
+	.thresholds = {
 		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,
 		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,
 		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4,
 		0, 3, 1, 2, 3, 6, 4, 5, 1, 4, 2, 3, 2, 5, 3, 4
 	},
-	{10, 20, 30}
+	.factors = {10, 20, 30},
 };
 
 void

I added a comma to the end of .factors because there is a 1% change we
will add a new member to the struct and it's the right thing to do.  I
was already changing that line, so I'm allowed to make tiny white space
changes like this.

But notice how I left off the comma after the numbers.  That array is a
fixed size and nothing can be added.  Leaving off the comma communicates
that.  Also there was no need to change that line.  It's unrelated to
using desgnated initializers.  If you added a comma, you would need to
send a separate patch for that with a commit message to describe and
justify it.  As a reviewer, I would need to go through the line
carefully and verify that none of the other numbers had been changed.

The commit message for the above patch would say, "Use a designated
initializer for default_anr_config.  It helps readability."  There would
be no need to mention that "I added a comma" to the end of the .factors
line because it's a minor thing that we're not really stressed about.

regards,
dan carpenter

