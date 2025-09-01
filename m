Return-Path: <linux-kernel+bounces-795173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 406ABB3EDCF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0721A87C73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C691DF99C;
	Mon,  1 Sep 2025 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="F+EpI+DQ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BAF2E6CA7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751200; cv=none; b=suIeib+l9hCiy/6Mi7qANkPIYngFSbnySoK39OJCkRcgfNRBF/XR7ujU3xxWVGoHEi51fhwJvVR7oK1MLS1WuvEqvQL8x9MOackVfDkUlc+CZrFJ+St6EGh2u6RM3piH0kZur30GiH1Q6AD0bHLvgPkcH2URmsPGfTfU5r5RW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751200; c=relaxed/simple;
	bh=LTbvZM3Kw1maTRkpihD4PkS80y37mnxf1DtnXg90eKE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rDyVgt3gD4DiUtkRoqKEaJnwdHupx5e7aleg92y+cIQMhgyzAh4dtx03GXWXeubBa7yHP6sYL59d1twYWisliTnzz2Py7WD5kJZ4hKLC2ZgCvu+qVSSOtAVJQ6MLBGjoj9c4cV9DJMmUlMei3W06tEGnFxC5RxKKyV2jqJASrkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=F+EpI+DQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b7d485173so29060615e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1756751197; x=1757355997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iN9B3+6C8JrOXlxnEu0HrM8pbn1Nojn+c9BHooNKrdg=;
        b=F+EpI+DQzJ4/qIp706vgYYFyWpIjtwrAHK6PjOIwjUiEGF/RvLoOdDgVfsty0+w8tm
         mAV68bEENZvkeaXbyNx84l/0sXD1q5DUtHiic7BvfTyP33uuYMDQP7sayOYKA9mD57CY
         Q/PI0r5uBk3BB5myGCrW4dFj88POCdRwwLdDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756751197; x=1757355997;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN9B3+6C8JrOXlxnEu0HrM8pbn1Nojn+c9BHooNKrdg=;
        b=fIjXmmvOA6AFXsdCdJSjptCAnpo71NY9QK28zK6GG7ZeT5P3UjlxcHr8dqUvHTRyMV
         ia99ZAPubAKcuf2abu7TxH5GmRG2djhN/rdVL5JA49yTd6HIPJqYeFrZtzJA1DriAhZI
         0+A/y28rzdfszeXXavGv4eMGBEfiGf5rFdPPMVpIyzuiWPhKuBfPHauXVcAHvg7HRUO0
         P1W1xQyyI9kiaI6KiSEQgGXuAl0z1ad+vAfELMcIvc+FIxv8lwwwxlBB0AHjiRO9yU8g
         siEWmwmPEheibGTMU2rWGShZ8OdE2xGL75MZzVeWHAFfRWFTbkts9BqQTq8frGtv73/o
         7BRw==
X-Forwarded-Encrypted: i=1; AJvYcCVidQzqR3AKT9a/3rKQkjyssoRdXZV4bogdPAMdtjMkhySh8nmurN8e0qG40kR7Gg7AjMaYu5Gsv7WZUpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAutvm/AhevngcNKnU+p7wLLs3UONLfJApwRtBKmRgl/T+De4c
	7I67eDjx1NkhDqkcwvLey9SkRNubRu15tiT8ynC5UESDeVgO68K5PnSdfLmks+9FAOs=
X-Gm-Gg: ASbGncuMzAOoTcsic6KDuMGyMlvv8MiU4vSkbH3K017AG+HeRUkCgTMlA/aN57a63bf
	2QkPcyNoQtuhjnZSuj+M16LPQFX+Ui2C2LecH6HmZPf8HnacQIiX8rd8a+G7C/9dJolDAAVosab
	1TOHw0U8xyn1GbLT9CsF7PmcuYBhwChtAtJvwm/wRKZDlMwX8ghh0tfbZGS/8o9GzVKho/RKZoF
	6KE8oJoiqi3SPE/+Tn23lSwNRmlEbwBfQ1LJcvWFpnREHOX+TsOJec59cFGqcHy5nUEtrUdMoQF
	FMaeIXBPeMQUJ6SSC1UL8xX5m77T8FrUT2/Sh4gBKSWEjNBUqLsLUUgRh+IutHT2lO1b0XEOPSr
	O6tOm8XV3p1Um58QvfH3zuLoO0IsOW+x/2Q5Z/caRXhMibhmwHxgfb0ULOSzJL7duqXatkhJGwB
	1FRU0=
X-Google-Smtp-Source: AGHT+IGFs0ReUZCc4r1CEEwRmYwS/xLtLuWOn+K6V9PGPBqTLb76YdE2p9t9kwFad3a59n2zsBjiyw==
X-Received: by 2002:a05:600c:190b:b0:45b:89af:d09 with SMTP id 5b1f17b1804b1-45b89af0fcemr60213125e9.17.1756751197215;
        Mon, 01 Sep 2025 11:26:37 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6ee66bddsm249116975e9.0.2025.09.01.11.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 11:26:36 -0700 (PDT)
Message-ID: <15270685-c5e0-40f6-91ff-87ff57fdd4d4@citrix.com>
Date: Mon, 1 Sep 2025 19:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: samuele@cerea.dev
Cc: bp@alien8.de, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
References: <20250901162527.18247-2-samuele@cerea.dev>
Subject: Re: [PATCH v2] x86/traps: Handle trap flag when instruction is
 emulated
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250901162527.18247-2-samuele@cerea.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Simulate the trap flag (TF) behavior when the kernel emulates UIMP
> instructions and iopl instructions.

You'll want to do this for CPUID too when CPUID Faulting is active.

> diff
> <https://lore.kernel.org/lkml/20250901162527.18247-2-samuele@cerea.dev/#iZ31arch:x86:kernel:traps.c>
> --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c index
> 36354b470590..bea28473866b 100644 --- a/arch/x86/kernel/traps.c +++
> b/arch/x86/kernel/traps.c
> @@ -705,6 +718,7 @@ static bool fixup_iopl_exception(struct pt_regs
> *regs)  	}
>  
>  	regs->ip += 1;
> + emulate_trap_flag(regs);  	return true;
>  }
>  

There's a fun bug in fixup_iopl_exception() which you're turning from
latent to real.

Not all STI/CLI instructions are 1 byte long.  If they have a redundant
prefix, the old logic would simply brute-force through the instruction 1
prefix byte at a time.

But now, you'll generate SIGTRAP in the middle of the instruction.

~Andrew

