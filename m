Return-Path: <linux-kernel+bounces-748537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F3AB14260
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02441639AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678B2777E8;
	Mon, 28 Jul 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBeWgu04"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B1213E85
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729609; cv=none; b=PbqmiCQQSkoPZqtlf9d0XIq/TVXnSl1yYjL4vLB8ZBWt336mFKC69Yp4gXQ0H/+/PWYiavWjIqu+lhirnkX320VzdaAqYC1zzOGCC5/zcmcUUvPie+C7k5A7UwX6BZSnPTUCQxxdmHPt0tU4yTi28mAjRz3oYlMzrNE0TFTKnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729609; c=relaxed/simple;
	bh=LGz/ZoTzA5bo9S44uSa6bOv0het7fwc3NSzYxwmA4IM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX/B/MJO7JP/LqItcXBvdaqm6BhIlW656o36Mx6+1SCxUvP/S7mFiFhzh3lfgj6KyzN0OG4p/Tn2URGPJSd2W3tdG9rQjVshBx2rNUU83DkUglhTzrGHwy3WyDJe04taFVIsVxj2+FNv0ar8ERN6C3zz/Tx0M1gYkzVZgcpgPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBeWgu04; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78776fb25so969536f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753729606; x=1754334406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9ks2kpmPeZtcWNP2Lgi72dkAO0lk17F6rdbasigZfU=;
        b=IBeWgu04Q8VtMwDXVRWy2ttWd8g9w32VVRWmjHrN3su64YsZgVSla/2f7RvMxMRpWZ
         /Uvo6nRZQ7CefynFvWO8+f9SVUtwHaqLHUpDpZiwCgudZj1TBC7vrArGHvaCUHrn/HBm
         bUcqaRbRr9B519PG26Bc3UWR0mcakyIAjV+u6r9onBly3j+wIVXpksh/FxjhV3ZRzubr
         fZ9HLzzf+HpM2C6TcTm+E0DC2CiyqF4SD2KkrNZPB/3KE/bGebZvcxTqdfs94nU0AqKo
         9h9Peq+ISjIfnI1DPMMetxJDYkTEPDr7sLkamqtP48aMVDpocyMCwufi0pH48ASFqBXQ
         PTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729606; x=1754334406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9ks2kpmPeZtcWNP2Lgi72dkAO0lk17F6rdbasigZfU=;
        b=kHSbgU6GcmPPolokZPsFwnb47AGbaNaUvn+olaKvv8+zQblj+pxY2QmuCGYPI8oIhb
         UNU1s0j6E6p/mfJfe6FGOzlpp7tHGxtRrwVkMk1e+5YoSMRb2eA+d6VFN3v0hMATMvvr
         LEsFD6lX6UYte3Utgl/oku/CRyfsPNUn5gjISySqoKkADDPAf26Vly8QR4yJqa4t336g
         TSYwEFHZw8WYpfqkYG1cd+u2ywB5FCs5Lzzfmg6itk21DzcLAFCGARK/+0PPBkxeTg3A
         nphhk5gQyGd9st8uwS6tZp7/7u2J6gIHgIKns7mXDf52NGaNiD+Lvp+goAyVdV9kq33h
         hXsA==
X-Forwarded-Encrypted: i=1; AJvYcCVO5fwTIDmbm6cE/eNOJVZvJ0kGPRz1GXS5Xpowrh1ncugQMCHLT0rUYEbVlRXu9yFYMbH8yENXj3wPHI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0NruWkqp4FUK3FeDYju1G2g2v2XeyGFMJhnxMaTONIav9cL8
	k0xF0hnssB5iDyIrROlVOtncjEFmOoPZ9z4gI5YZH8PJ+azf8xV3FzbS
X-Gm-Gg: ASbGncs2hNQ5pufXrF1MmfcOz56MimMesCj8WXnGrzRh5/Bzbko4qTsmjg7dmE9rBWC
	pai+xOO9XnBSC7siW9myGw8ZZGU9KzAQ5Hmtk5RUg0pbbN93uCe+gGJF9jMn+C6NQ6Yil9aVHO/
	RPIkDXYeMKVMbwMX3940ywzvmCEm+61IdVQA0HkytS0BVDDI6bNKaNPJNLLzKBLYiLTCT0QDJtv
	lEyLJDCcQyGGrVAwN5yV3zCoMRsskKqdR+/b60ufnSA4knfiCbELGVhl8l0BMowMb5SBkakrAJF
	hBkV1pNXKx5uqsR2HYAU2hMZR9OLMQ8DPlR85Mu4O1cScWAXUbqCLwQ2kLFpVGBjBn3gIFxDS3Y
	KJFfRvY6wfj/73kRmzNldRFVnHmSqcc3htCKlBskupix1GRXvTTQjzPm5E64M5NmrLUd0V+c=
X-Google-Smtp-Source: AGHT+IH5l3FIXCNSbqNXYGbxRDY21Z3t/HXE+tSKLQfpWGY/mCGFW12t+b4qQgUfLMDU+5AMXMWa+Q==
X-Received: by 2002:a05:6000:4a1b:b0:3b7:78c8:93b5 with SMTP id ffacd0b85a97d-3b778c897e7mr8944732f8f.47.1753729605853;
        Mon, 28 Jul 2025 12:06:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c64fsm9331868f8f.60.2025.07.28.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 12:06:45 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:06:44 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Niko Nikolov <nikolay.niko.nikolov@gmail.com>, shuah@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tsc: Replace do_div() with div64_u64()/div64_ul()
Message-ID: <20250728200644.3bcc1f3e@pumpkin>
In-Reply-To: <c6eb6734-93d3-4a59-8869-49ecc438fff9@linuxfoundation.org>
References: <20250724215339.11390-1-nikolay.niko.nikolov@gmail.com>
	<c6eb6734-93d3-4a59-8869-49ecc438fff9@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 16:32:43 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 7/24/25 15:53, Niko Nikolov wrote:
> > Replace do_div() with the recommended division helpers to avoid
> > truncation and follow kernel best practices, as flagged by static
> > analysis.  
> 
> You are making more changes than what change log indicates.
> 
> > 
> > ./arch/x86/kernel/tsc.c:409:1-7:
> > WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> > ./arch/x86/kernel/tsc.c:492:1-7:
> > WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.
> > ./arch/x86/kernel/tsc.c:831:2-8:
> > WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead.  
> 
> It is hard to see where you are addressing the above warnings with all
> the other changes.
> 
> Also you don't have the right reviewers cc'ed

And the change is entirely broken...

	David

> 
> > 
> > Signed-off-by: Niko Nikolov <nikolay.niko.nikolov@gmail.com>
> > ---
> >   arch/x86/kernel/tsc.c | 185 +++++++++++++++++++++---------------------
> >   1 file changed, 91 insertions(+), 94 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 87e749106dda..96f40759340e 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -34,13 +34,13 @@
> >   #include <asm/uv/uv.h>
> >   #include <asm/sev.h>
> >   
> > -unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
> > +unsigned int __read_mostly cpu_khz; /* TSC clocks / usec, not used here */
> >   EXPORT_SYMBOL(cpu_khz);
> >   
> >   unsigned int __read_mostly tsc_khz;
> >   EXPORT_SYMBOL(tsc_khz);
> >   
> > -#define KHZ	1000
> > +#define KHZ 1000  
> 
> What changed here?
> 
> >   
> >   /*
> >    * TSC can be unstable due to cpufreq or due to unsynced TSCs
> > @@ -55,13 +55,13 @@ int tsc_clocksource_reliable;
> >   static int __read_mostly tsc_force_recalibrate;
> >   
> >   static struct clocksource_base art_base_clk = {
> > -	.id    = CSID_X86_ART,
> > +	.id = CSID_X86_ART,  
> 
> Tabs removed? Why?
> 
> >   };
> >   static bool have_art;
> >     
> 
> Same questions for the rest of the format changes.
> 
> thanks,
> -- Shuah
> 


