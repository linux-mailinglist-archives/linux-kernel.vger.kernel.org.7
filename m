Return-Path: <linux-kernel+bounces-732549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C72B06877
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CD216EAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621772C15AC;
	Tue, 15 Jul 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Ocr53KH2"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D82C15A0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614486; cv=none; b=hVyAR7ODwEL7f8PZtom8BKrDzK38HaCJbXeO/MxhWxt7o2LcN6xWzFt1we1MFUm0dwNHa0VHX9lymqWatnV8T/vv43zwT1RBYQOKj5r5nKkD+khhfKLywmCRn+Z/ql9n/9gjIr3kNNufT02oxEEPjfyWagPiT0ZcFcxo/2/6Wj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614486; c=relaxed/simple;
	bh=Xn5sfXJVyFCUmKpUctTY6XjcSY6L7rDfuoGzFEZ3rIg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SzesqJ4YeMu0XgXuo7ZQMbpcs5IfyoT7R5HsWxowU+u6r/Tpgy20YCOsIAkNCQhOkegcYsTOt/kxIL9CxbdgpXLvQ3ylN4x4r0Prn86UQ2r95Ytz0kClvgd8U9OMWj9omNqYemFWZTeXKfb6kr9qzO6FPyk+wmT5we9YLZX74Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Ocr53KH2; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so4266538f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1752614483; x=1753219283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ppm5sGysExi3sq4lorbjoMJOii7mZlPYAA9BWJ5r3TA=;
        b=Ocr53KH2aov+NWi7tieRoerwDH2hoDi3Pgf4KaRWEIScp0sNqWF7bDVzydrp/rdfgh
         RnqkMIVJI1fk1NXphbuv92KXU/10REXrgqVqe4N9oxqrFXJ8mXUSeLoM25gxom8MuPzy
         ADruHBA4r88rDcw3VKLJ363FvM2ixI1vEBEAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614483; x=1753219283;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ppm5sGysExi3sq4lorbjoMJOii7mZlPYAA9BWJ5r3TA=;
        b=TLp9lC74GjYjM5Sq+B735wgQEy/RSCdeGrXUtJq90q3YSrS4wv230UkkxI1s2ZxeOj
         L2pvVG+LmpAKwamCPF1uMxjmOztwi4aoCsPqSEvxe65fR3WOIhkg5MR/XM1Btg+WYusr
         fp1DFJRO2oWZvIzoy2nCRITz/xeYoV4KgsudXMqf4Q+mk1Ys3CTu5clv2PO87zrU/axL
         vHvggV2BgX9oCEtBISvMa4qefqvj4BbchmONKh1r4+2WJFsSswg3qOcJJZ0doPwTVjS0
         c7KcscdNBgPsTSH3ZR6+vkp5LxM+S7o+rEnbe2oP9bHF8B5lZT9gjI5TWqJoygGHIKsu
         nstw==
X-Forwarded-Encrypted: i=1; AJvYcCXBtiW1DkX29YfTrjBmgyNIIgFAm4kBGZAjhcSeYLMrCLZeHwk9K1U+QxggF8JW7PMViLCsfokP6OG8++E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4D77o7snWIpSXGmR7XTPkv3RAsF3Vo2hvx85og2rfp0IMoIX
	irvGcYkn9irfRKYKyLHIyQo6pGaK0KRoHV09Uds54HOPQONAvZm4pN4Me5kIrSvuD70=
X-Gm-Gg: ASbGncuU+CvqKW4DKo1gGVZsvoX3iGP043fR8Lf17nd1XoicjxyBELT193Sh41hQrbZ
	jZJb490MqJPc9sMNvFt6H9WwQXVX7+sUSGW5Sck1oVq/havh6lpfP0EoEtH0ChMi6ydsnwCooJT
	PibDsJRVWFcx9Vt68K+9u+W06VoVotuUJaozpKwONROe1Qwv+P8MPPn6H+RtLDba9PH09ymRQND
	Eei7Dfql9Qs2Gvq1LdfL0abBPVxJHqH/dQoj6o0zEzG2UWWposRmyS0crfGCzuupbbP/h7tceVL
	5Lyrb0W5emUG52iGfvYQdJicR3KZV4PCeS01xc4DNk4Kj/PdbNQvsTWQMBdCQj/WUNm+ay0QFH7
	DB7+mfbuRMkoBCqkW9AtStr0766JOhSjtt8S3cwnSZro/uFYrO4Mm4WRdo4v/CSIKcxQe
X-Google-Smtp-Source: AGHT+IEj8+pSzZBBrVJbdtKW+lmHwLR/QBZ+AT6lYZRu74xiogpHpM3WO9d5D7LAgQdk5WE/KsmqUA==
X-Received: by 2002:a05:6000:2484:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b60e51c90emr57193f8f.30.1752614483128;
        Tue, 15 Jul 2025 14:21:23 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d76fsm16377962f8f.64.2025.07.15.14.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 14:21:22 -0700 (PDT)
Message-ID: <927f2b0a-7e64-40f2-9773-cba9b1d328a5@citrix.com>
Date: Tue, 15 Jul 2025 22:21:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: khaliidcaliy@gmail.com
Cc: ardb@kernel.org, bp@alien8.de, brgerst@gmail.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, tglx@linutronix.de, ubizjak@gmail.com, x86@kernel.org
References: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> diff
> <https://lore.kernel.org/lkml/20250715181709.1040-1-khaliidcaliy@gmail.com/#iZ31arch:x86:kernel:head_64.S>
> --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S index
> 4390a28f7dad..dfb5390e5c9a 100644 --- a/arch/x86/kernel/head_64.S +++
> b/arch/x86/kernel/head_64.S @@ -222,12 +222,9 @@
> SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)  
>  	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
>  	btsl	$X86_CR4_PSE_BIT, %ecx
> - movq %rcx, %cr4 - - /* - * Set CR4.PGE to re-enable global
> translations. - */ + /* Set CR4.PGE to re-enable global translations. */  	btsl	$X86_CR4_PGE_BIT, %ecx
> +  	movq	%rcx, %cr4

The comments are at best misleading, but you've broken the TLB flush
being performed which depends on the double write.

This logic is intentionally performing a write with CR4.PGE=0 followed
by one with CR4.PGE=1 to flush all global mappings.

~Andrew

