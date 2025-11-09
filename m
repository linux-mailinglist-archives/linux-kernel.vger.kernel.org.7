Return-Path: <linux-kernel+bounces-892202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06477C449B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65723AF05D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34826CE35;
	Sun,  9 Nov 2025 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAQl/BI2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC561CAA79
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729676; cv=none; b=Pd6eaeTg4TxibbtynL04jgLk+XqSTybk3/KRw9bS95XhYFTR3GVT5EuY4gIrN/sDu9f+GdyABmhB9OexLd/TFpK1KUVRWai/WRXjJiifq1jqZ1/D7mLkD9ROUOX2HRz5asKMijKbsP01luIR9okVTeJaF6lOxosYEw4a+uYKknQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729676; c=relaxed/simple;
	bh=BuwHo5ZmpvTmNr0PhPw3Ernaton9SxQYFTyUKQVk63g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qr+153T8xJX3pmNdllzVBilkGTPA5OesL+TAWbMGKB1IOZEtqX2GI7Xj7spvi3jTQJEcdrT3QRCdnOSVi4lgG8zjI0XIQsVCu/5zl3RfCzmZaZC+2NmHUIFv/a0/Y76+B3cs3qiDCACH8DLH+I5oyzwl/sGH8JxBKkA2i4BZhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAQl/BI2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477549b3082so21852925e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762729673; x=1763334473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCMMCjoEXFUYe2MDjK03jJx3LdwstXGzOtlqd/iP8s8=;
        b=hAQl/BI2iPBcQZnogk0cZCH0TaQmIf4sQl+Wzwb5nvQa9Ha2S2MbBeF0Bunsf344AI
         d3tOvhPtoX+hUrbm/FH1Jyuqx5dATzKiVl45LOLw/ookDx77wgHGoiUtxPlHvxHQ/hH5
         cBm7X9K19fbxJVYReO4Exa9EW6nA1LhjcGnaOhAQUoIDdkl3HbUEgqvNYY5Fb5knvnTp
         U38eDlg8R/6fkWH/8soqJM2FFVtHH9HKvs8I1N5q5BQfB5YFMN7lodROOKYKvonZq5X+
         qypdFHFOJut5HoiCm0BBaqHDpgyZEg054XiOXbV06fjS1YAh9otYMbvd2Fgkj6gruReD
         +W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729673; x=1763334473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCMMCjoEXFUYe2MDjK03jJx3LdwstXGzOtlqd/iP8s8=;
        b=TgM9awPt2aHmx8weXBAKjJzPGW/BZBgIbkV2Xbp6jOX0HDpincZY8URslgvUwKkj/q
         MUX0ttECIRzxtfyDpOxqHtfIEgk4OuJO13d1pz+MJaPguMB5ITnhXrCAdWyG6apSWzcl
         VV4NiEAanWq9rSTJkPojmqAJy/qVWLMYFfYVosd24TLWl9CairlSRzFZ2Uud3bL3+5/v
         96Dh1L6vZ5ZoSt63luAESi/MtUnoj4uw3h8yd4TaRhs9eFBsaYbyURbLRGPPIspFbsi2
         ArAD0YUMY/yCvLwGCxZ3x/i2eO/Ftgmoyao30Hza6jL29aGjPQTyptyOuLNWKUtrpxzN
         qSow==
X-Forwarded-Encrypted: i=1; AJvYcCVPMYmT1OiF2ueacNjiHHwEEGHwmc5QufMV/jp+TVGbWDy+hfcKDyzw/tJJndXpTMCkmQsvnxs12HQrtFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OHQg22wRLvKdNHoJ+OK1l2qtMwNEmOjxKezcsU43ovRpasWa
	68IAC3ElfqB6H1RL0yN0s826FrYsZd/kAMIIKT8FU4LG8v1kKHeb7Y+7
X-Gm-Gg: ASbGncuItkYm6rhAyLImBGu/wgts8dBcKRYfC42ijS6/dDrgfkAMg3/89+UIcKBaxDb
	XO+H78xRLS2A6WK0r3nDq7mOaoCcEoq4hsbqrjQscAZlldB8a5O4E37Yo1spl7AOSBtpe5SEIBb
	bSZ0qaVPn7cFIP+V/z6zaZAxah8oWnvFavz+I+EdysIK+zwJHRrQlpGPLXm1F555jH/EGWy+WRZ
	YOyDLO0Z+uNxBwFPPsl7sXbgXlBmWUbsUp4DG9zTeLfYWKc00d+JTWN9ITHBun0e4+nbc7/bARt
	wPW9tD0libNgCy/BR36sXMSRxezaYLg1ZElI5W5OuN3mEvduCCWaeVBiOvVGbAXu5egr5CFy9Lc
	E0RJsiA6McXQvr6aAlM0VnDQuZr+T8KTklPWU8W+Xe2is/54yW6Fy7tIlcBQRKoJpQsyRukHQ9s
	DmF4gLXGCWXOisyV7Vo8Q728fCQTcKrZylNZU6O0C5ljmCN+flsHTe
X-Google-Smtp-Source: AGHT+IFeUuhJ/HI1yjhyHvY42PoBnlAmpouFmJHj4zniIOvDgTnwoat2N/zoCuKJC5ThvO3LO7MkBw==
X-Received: by 2002:a05:600c:1e88:b0:477:7b9a:bb1b with SMTP id 5b1f17b1804b1-4777b9abc67mr20461515e9.32.1762729672572;
        Sun, 09 Nov 2025 15:07:52 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b30f1cc4esm9547806f8f.36.2025.11.09.15.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 15:07:52 -0800 (PST)
Date: Sun, 9 Nov 2025 23:07:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Huisong Li
 <lihuisong@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: therm: Use clamp_t to simplify int_to_short helper
Message-ID: <20251109230750.06ed6493@pumpkin>
In-Reply-To: <28C4DAF0-91B9-4175-AC2C-D3B5AC283439@linux.dev>
References: <20251109130000.406691-1-thorsten.blum@linux.dev>
	<20251109162056.0a9cbd52@pumpkin>
	<28C4DAF0-91B9-4175-AC2C-D3B5AC283439@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Nov 2025 21:30:00 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 9. Nov 2025, at 17:20, David Laight wrote:
> > On Sun,  9 Nov 2025 13:59:55 +0100
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >   
> >> Use clamp_t() instead of manually casting the return value.
> >> 
> >> Replace sprintf() with sysfs_emit() to improve sysfs show functions
> >> while we're at it.
> >> 
> >> ...
> >> +	/* Cast to short by eliminating out of range values */  
> >                  ^^^^^ no shorts here...  
> 
> It's even shorter than short. I didn't even notice...
> 
> >> +	return clamp_t(s8, i, MIN_TEMP, MAX_TEMP);  
> > 
> > That is just plain broken.
> > clamp_t() really shouldn't have been allowed to exist.
> > That is a typical example of how it gets misused.
> > (min_t() and max_t() get misused the same way.)
> > 
> > Think what happens when i is 256.
> > The code should just be:
> > 
> > 	return clamp(i, MIN_TEMP, MAX_TEMP);
> > 
> > No casts anywhere.  
> 
> Ok, yeah 256 would be 0 when cast to s8 even though it should be clamped
> to MAX_TEMP. Never thought about this side effect of clamp_t(). Will
> change it to just clamp() in v2, thanks!
> 
> > I'm not even sure the return type (s8) makes any sense.
> > It is quite likely that the code will be better if it is 'int'.
> > The fact that the domain in inside -128..127 doesn't mean that
> > the correct type for a variable isn't 'int'.  
> 
> The low and high temperatures (s8) are only written to the u8 array
> 'new_config_register' for which s8 seems fine. What made you think int
> might be better?

Because 's8' is promoted to 'int' whenever it is used.
And, because cpu registers are all 32/64bit (except on x86 and m68k),
the compiler has to mask the results of any arithmetic assigned to
an 's8' (or u8) local (which you want to be in a register) just in case
the value is out of range and needs the high bits discarding.

Now it might be that the current compilers track the values through
	th = clamp(temp, -128, 127);
so know that only the low 8 bits are significant and the high bits
can be left matching the sign.
But it is more likely to generate:
	reg_containing_th = clamp(temp, -128, 127) & 0xff;
then later when you have 'if (tl > th) ...' the compiler has
to generate code to sign extend both 8bit values to 32bits in order to
do a signed comparison.

So calculate the value as int (or long) and then assign it to the u8 array.

While it can make sense to use u8/s8/u16/s16 to save space in a structure
(the fields get read with either zero-extending or sign-extending memory
reads), using them for locals, function parameters or function return
values is very likely to generate additional instructions.

	David

> 
> Thanks,
> Thorsten
> 


