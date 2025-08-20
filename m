Return-Path: <linux-kernel+bounces-778575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD29B2E799
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1D73A2920
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809D27145F;
	Wed, 20 Aug 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7Efk9kM"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF9280309
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725825; cv=none; b=bZuiOeBXTipMps/sthqKLATGrQFIEPZsbECAycgpRvaehfp+UbPglBYViFRaoN1aYEwfUdqfJQh65rmHBZric3dkuMO5U0orSpabxr65ADfDxZmy0bBQXALAwULl9v/Jm4mEo4fqLOS7sxZbvenCLl+pf049QZ6ZA11hJNDHCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725825; c=relaxed/simple;
	bh=rX8NR3yzy/yYliW9X3GW6javP/DPhTWkPSo8BSYXTCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txqixBpi82fGS4kUCSpd8wwKCzcuAybSNKBiyQL8MHaJ+GESRsevvAymVObuE9EAqmg5JZouJLF+dFsra2xjZoYE02PwoDN8e1wbONe5IRQOxs7rmwDsQPwdIAXX4mnDkpH9+0mocnkUd/YHps3XIf2Ub/L2vCV2any+GG/n62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7Efk9kM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b472da8ff0eso171873a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755725823; x=1756330623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ekBgLzgg87ypwyRRT8CO0YxWRgDJEzo49dyFTaIPP0c=;
        b=m7Efk9kMC4LXc4YQTT6dXpeopqRG0XGCkqvSn4p23knK/LcsTjfPijMMJQkRzwRzkj
         fSQso9B/K2C9pVnnRmMOyP813TT07F3ei8DIfF04BOEy+KnuoUvn1TF+pmi09b56f2fv
         +zIlU5C5+y+wTkyE66FHi7Qk+GcaZg1kwNeIuPWlBodz9pqVQP1nVMwo44qV+MeqTXa2
         HVecp6GTWMQyOk5HxkQldTlIHxOwtHJw8Tcon7uW41ShIRrxEmfZVxVTcttHbBEbMn+a
         DCNjrlh5SNhDZ9/xQb9uyxovulZ4w2e4BGec993KS1+fC3WbmSPdYt8raQU8KckNgISD
         YgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725823; x=1756330623;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekBgLzgg87ypwyRRT8CO0YxWRgDJEzo49dyFTaIPP0c=;
        b=jRqyYnjr8Es7o7zPnMFjxoSWHMExycm1G6J1dt7aYg0fK9NwFKBQ/Yl0dNMD2LhAY5
         xqfddJZMML29s1Yk0S4NseQCQPcUzl4BcGrahF/YoAIZ38IuDYKWCwdQdbBf1fyKzxfV
         dxX3gYS21X4dYW8BdZ7IfbOvq+fcWzWrdHdlYavb9wifopdu/aEj7QtYeKs0TBK2/0Cf
         AjXtBfm3MOa1U+WymNwpEtqgEIC44LMl5zZ+TC1rxWZizxFATptZlYxW/Lhgu+3XlAbr
         O1yoVwncEYDVkcdG1+tORSLWTnMchz99obuHQyoYgHgGz+dO+KV+BEVPkXxrl9Zr4dY3
         sGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbF5wTQRiD6RfdxJCpEF5uXxGpDCq/r4Q4b/C22+trXkask5+e6Tjo9A/Kv0+yRcDbaB6uSoGY7sF4dco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0d7+7VFUGloo5jPhgpKn1wNH4jreVZnw4EaSNI1W2+MVZElT
	1mraFFi6EJIqyDYc8L2d0SdplPV6zNuS9gj1MftNkwm+vS3+QsofMZj82WH9Bw==
X-Gm-Gg: ASbGncsfAVToVPFpPB8zxa+WGHZ2k68GMDLPWIJvPKCIg22dqzBir1++947CffOyhSY
	HsrW/wOW1fqU58rRoozOszFUoaiHH9n2Ls6YE+7gDBbPsqmyxi0f6gnXt9dfe1rpnxINag8GZHl
	Az25nszyYgDo8O57k7sny7z7pJmpBRqxattQV61FbSQiui4S016j6KpkS4sZha6Qmmyw0gQ3PVs
	uuBTyChyf9G4yQaofd++i/2qy78KJ7+zZ083Q3x2BB8tb4sr3Foo3ynK6g9aW44zmWIsRJTPoAV
	QowBPCr+SJFTsvv7fQOeNRXOdfJC14hcKlIorwIVqGGhP57soX6ups7ewbhgCK2glrWZm6UW5uV
	Pk52rH5mB7eCIeAmQQaHba8VP5JS3QceNAvuLCIcgL/b4JK1956irr2+lNmuJuelzn+0p2hOb71
	tNp/8jnA==
X-Google-Smtp-Source: AGHT+IFJBieLDm3tTMToXFhKXh+uAouVJTSVKHVKyBTjE532h7vmr1XNtk9PJgAufzO3Psq1wwyqXw==
X-Received: by 2002:a17:90b:5251:b0:31e:3f7f:d4b1 with SMTP id 98e67ed59e1d1-324ed139a7fmr392487a91.24.1755725822797;
        Wed, 20 Aug 2025 14:37:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e267d53asm3256418a91.26.2025.08.20.14.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 14:37:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <efe1d5b3-4288-4f44-bcb3-99326a75a473@roeck-us.net>
Date: Wed, 20 Aug 2025 14:37:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] genirq/test: Platform/architecture fixes
To: Brian Norris <briannorris@chromium.org>, David Gow <davidgow@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com
References: <20250818192800.621408-1-briannorris@chromium.org>
 <CABVgOSkUT_yYqBvk2-+OozKEBybj-07mcRAVECNYQiw+1P67eA@mail.gmail.com>
 <aKYEVTRhzbXvwlbD@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aKYEVTRhzbXvwlbD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/25 10:22, Brian Norris wrote:
> On Wed, Aug 20, 2025 at 03:00:34PM +0800, David Gow wrote:
>> Looks like __irq_alloc_descs() is returning -ENOMEM (as
>> irq_find_free_area() is returning 200 w/ nr_irqs == 200, and
>> CONFIG_SPARSE_IRQ=n).
> 
> Thanks for the insight. I bothered compiling my own qemu just so I can
> run m68k this time, and I can reproduce.
> 
> I wonder if I should make everything (CONFIG_IRQ_KUNIT_TEST) depend on
> CONFIG_SPARSE_IRQ, since it seems like arches like m68k can't enable
> SPARSE_IRQ, and they can't allocate new (fake) IRQs without it. That'd
> be a tweak to patch 4.
> 
> Or maybe just 'depends on !M68K', since architectures with higher
> NR_IRQS headroom may still work even without SPARSE_IRQ.
> 
>> But all of the other architectures I found worked okay, so this is at
>> least an improvement.
> 
> Thanks for the testing.
> 
I applied the series to my testing branch. I'll run a full test tonight and
report results tomorrow.

Guenter


