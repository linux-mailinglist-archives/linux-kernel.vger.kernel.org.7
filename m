Return-Path: <linux-kernel+bounces-732019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193AB06147
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746385A6C52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10D298CB6;
	Tue, 15 Jul 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uhj6iLb8"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27D24DD0C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588622; cv=none; b=rpWqsWadPmYnHhLsvx2cajJrOwUq4vMOdqNZMvyCJCGOlDu3leDwy0eooueJ8sCuqFz68eh9yWlWSeAizduWGpLNoRFsvJ9ne6ThFb9b/6HMlwDdKqsGM+ogYt0c3sypyjjMOHK1gUIdvVwQ78YpxSmQk85YCD1Sf3EA95TR9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588622; c=relaxed/simple;
	bh=+bManZoJ7DUc7PE7xd7pJIQtqW11gJZQd7GwUTQc7J0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tis9/1Av8nV4IQn6TZBt93/qL4WEvOCp0sgv0BZ7OA4jJXXKTSIVFe9l4ysa9gPqOP4uxEwquF5/BbP8YvNsqOAwT0RtXgoXJlqzcg7iUtUEzx8HuEmnYWLGp3h2Y1nN9gtLbNfajql+g1WTCoQ1KDugomd24BOGIXfNbMktj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uhj6iLb8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e058e82584so50079995ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752588619; x=1753193419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gz6M9A3kNVymngWUbjHxUUeWvWwN2Oe7xxlyyy1otJk=;
        b=uhj6iLb8jUGuO8NvGeCz6/X7zB+qHasRR5W6nO74xGZWuefIEdHWhFlM+zdo378KnG
         QemLJ9FwwbS3B178uWI0VUZfJP0Wf9qMe75XoltTbvBTz/YHaTSIBPPHnDEruTjYAeS+
         7A0HewDXbnlHIqURfXp5J8DdfK0gXZUoWu4xV5dRkV6uSYWTFJjvAybZTdKWb+ue+t41
         t3ljdq45hfdD5T2QkKHeCE80Gzc7IcVfj0Pu7d6rIoKV5v/ViHBN9ebxwElPwM0DoKoR
         cmsOAfKOmDmVrU99kJI/P664Lj7DI+TpZ+LhfQ8BgIQTywdOWjyXQKC4w8DQNA95Gz2C
         y+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588619; x=1753193419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gz6M9A3kNVymngWUbjHxUUeWvWwN2Oe7xxlyyy1otJk=;
        b=s2aSWEDItQPszR9gbs0lloShqG6NbS0oXZAqVeWOb0j/mKpY44mPUuIC1YNyORuqQw
         AZTu0MOgZDK5G/Ka3CUAg+qzEsi7tjSS+J3D4YhikYWvlmUmLCTrbbxNbstDOL76DlCA
         lF0TYghr5bjJax5dri+naU7GKso+kluwe+wZEHqFt2cNNWVozM/Tp5ZpiEmt3cACmAUD
         lORdQPi9idfC2F6+CFFt24OkrPn85FtlytF+SO3fBfDvNveIhI2OHC8B9IgZPt8LuhAV
         IgJWFtaM0TuitEFi3iHngm0+IVsBmp1dGfdSIQlGgc8HwEUYNmjzz+bVoMZUZKkJxgx6
         5fuA==
X-Gm-Message-State: AOJu0YwPO9Y8Wpx0w9K4Hk+WYyHBxeD1AIAskhuGauB+nzQqnaBboFFO
	0oQASW0pKziyoFX+mQt1tuGgMCDACTWqH1ufv+hZEcyPSkYS/49OnbL67SD/UNPl/VY=
X-Gm-Gg: ASbGncsUUhHaDtSUYCFVzTByUrJMK7WYzkBnovUJQ3bNKdFRXqhcXNqQHSjmt+hv5MJ
	jcBdgnyGLm8Mmv1ififQvsFKzrZBwaJUpn6IpBRj6OMSIEZTUhKfjC1GhmulfLEtDg2kO081rFe
	F34YmNE5UL8e6roLfDmN7zYcXvz+ZweFMN7PnfgCe7WzvLL9AplUVAvXYRd4X4cqSQG2cJogERV
	qCMCs9Yl/W1BBGINrDoh4O8nvlw6Ve7QQ3B2k/0j7FEwv7PiWNd0zfW2x9igvEN4udOqOKbQRFw
	Fx/6kwh5tOma2LPNbDrc2HuQqLCjSAEcpSoFOVxlIHI0pPxaOfswI+3j+WRbUUTX67taUsNhklY
	ceO6V9xThvKRP1A6GJLI=
X-Google-Smtp-Source: AGHT+IE1jSl0+Ol461G6fZrpoKwEDGHayubqoEeTwWls/gtKYdvp4zX/qFJoj8BP/4ShuOwARvbT3w==
X-Received: by 2002:a05:6e02:188b:b0:3dd:d189:6511 with SMTP id e9e14a558f8ab-3e2556d42ddmr182511335ab.21.1752588618466;
        Tue, 15 Jul 2025 07:10:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e276c97460sm7269955ab.70.2025.07.15.07.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:10:17 -0700 (PDT)
Message-ID: <4bc75566-9cb5-42ec-a6b7-16e04062e0c6@kernel.dk>
Date: Tue, 15 Jul 2025 08:10:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH liburing 1/3] Revert "test/io_uring_register: kill old
 memfd test"
To: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 io-uring Mailing List <io-uring@vger.kernel.org>,
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
 Ammar Faizi <ammarfaizi2@gnuweeb.org>
References: <20250715050629.1513826-1-alviro.iskandar@gnuweeb.org>
 <20250715050629.1513826-2-alviro.iskandar@gnuweeb.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250715050629.1513826-2-alviro.iskandar@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/25 11:06 PM, Alviro Iskandar Setiawan wrote:
> This reverts commit 732bf609b670631731765a585a68d14ed3fdc9b7.
> 
> Bring back `CONFIG_HAVE_MEMFD_CREATE` and the associated memfd test
> to resolve Android build failures caused by:
> 
>   93d3a7a70b4a ("examples/zcrx: udmabuf backed areas")
> 
> It added a call to `memfd_create()`, which is unavailable on some
> Android toolchains, leading to the following build error:
> 
> ```
>   zcrx.c:111:10: error: call to undeclared function 'memfd_create'; ISO C99 and \
>   later do not support implicit function declarations \
>   [-Wimplicit-function-declaration]
>     111 |         memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
>         |                 ^
> ```
> 
> This reversion is a preparation step for a proper fix by ensuring
> `memfd_create()` usage is guarded and portable. Issue #620 was
> initially unclear, but we now suspect it stemmed from improper
> compiler/linker flag combinations.

Maybe just bring back the configure parts? The test, as mentioned in
that commit, is pretty useless.

-- 
Jens Axboe


