Return-Path: <linux-kernel+bounces-872754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD85C11F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3FAE4F9E42
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDE272816;
	Mon, 27 Oct 2025 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O0ZnotQy"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF226CE3A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606962; cv=none; b=V5I21d5rwcz7s+WRmQyATyAQ3cv9EQjNmzgmSyZ0aU60QZoQjelAJBasPq3smLadBB94UpSqylaCbrovhzXJ9N6I658JQyRgRx1oO0qR1qTRSUxMLQHfcH/2hJLQ4idtWoXc6WVM5vna8wrQSMEWqfImmEre5QNy9dz80Ii50A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606962; c=relaxed/simple;
	bh=gAIfAw7FHE4QOWioFeSg3uxKwCyW3lrxDjN8vVbJM3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkJCp7Ayhc/rMgwqFTEft66eEMM+O3JS+xDJp6PZaJhlLAckzNIILYdqBrrMWwEmv0aZkAaK06+VQZxBWRWBQjL2RzzT5xuDpU3Uzk4pmfjCDbZ/LhBB6awWKr3X854buRhc4k3ALjFh3GLpJepqyd0mzixO8FYOdCpRJTPBqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O0ZnotQy; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9379a062ca8so219439839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761606959; x=1762211759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoD5NoTKv8/h43qgG+wn3ax3ZabESD7UDlfS92Jz2nE=;
        b=O0ZnotQyZaU4jOM8fXo8wUQSY+vEfTLyNTZNl1G+TpHGVdExTBxxkAyxU9S79SSM2C
         9s4+7hBE6e94EaRObu5S21nRrXYDznDxDi3NBL3V3ckPApIdfLeACr7urr58bM7rEe5L
         hpzeyRiPumtTm8lm+Rlb4OrQDAXkAmbAIQqYaApC/vn4O8KaU9F25S4rhRx+aW622Qb+
         9txSzCTn7JoY45tvZ4NCXgNR+OPBV9WHrhlUF4txDGu73lFMQvZSDUID3poWVruttpAC
         sa0ZxYj9/GYNZwoCWT8uzPVIiXDvyf9n620Fz0fRu6ygKQf9k2HKhzrS2mZEPTdpGfr7
         cSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606959; x=1762211759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoD5NoTKv8/h43qgG+wn3ax3ZabESD7UDlfS92Jz2nE=;
        b=WIZspB+zfM1/bSk7p+jJ0g+Rmjn/hvAJfJGx7z8wwoGGP5RjcgZ/asCG4tUequK4Dm
         9qzufz2ru5XGiYNHnQ1QMNKgUpjMooSqtsHg13nmhFlP2lDdzELZuWPzBvvX1Pg7zN8m
         lvafbE7DFU+CHftmgrUt+RKm9gvsPeDdGfHpGrK5vvO+NTwXDjD4u5I/GuQC/pXBwvj7
         lh9fVn7HITbJeSFV8ntyh239g0d3sv23BXHogyk9BTDVHsju6E1qf9/+mhm+0qHFl4zV
         6JarPCdouxozS89G11zFpXGgz1BFg4NNBfGY6zZSjdKpbGuNbqXF4cP0RNZLYumU44Oh
         UZhw==
X-Forwarded-Encrypted: i=1; AJvYcCXL7NcSn17zVCEutzwOr8OJeiuy9vJQ1Kni2FA1xCmEoW/ywJUZCU4YHkCGj8VGD4wJrkjhGjzZTOMv4tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCGRtzpsLU1LiBTHLTsMvZdZbuH0K+CAnsPBqKhdnfsVDwzZT
	/L/JFX2u6Kd104IFXyVmAo3vQ6v12Qrkiobkx6WWLUDTDjbamrFUOjb3V3yUjahpBBs=
X-Gm-Gg: ASbGnctODC2k1k/be6H4pIhJMsMaQX5YuAHyJkOt5l3YQESdzytqr6cnUTppjqyNsBE
	Qj2+wiZMOfCzTXztr3SM7C8ZUIT76eFhUZ4CO9vi/YFDFI5bEDAuSCyxhP7ngcOctVuKcriNrad
	d5LwSXoXBLzCOOHUVwZP84XwX9tzAEu3VX5FfxLdznU2pND55gxgji9s7TmghheKlWB1+HBwl2y
	bXj4Ztt9mtHBrVA0r3uv6uCq9fRk0Nj9pr4r4sWUYSoHdpM9zkywhpKvUR4vlhyXhoJq/7KAtIl
	Rj9y+vP5lguNo+UcQ6XZE0xsUkUfjU3XXwW2WDZEL2YDk39bCY4JuGNGIDD81qFtz2dEymCWaba
	1fZvLA/BJN1OqaGe0JEaN5cdcLR+audfqG+sajwOFMdQlrKMkGcxnLm3os4Ng1uaWyxdll1Qfnk
	zr2iKxcl1J
X-Google-Smtp-Source: AGHT+IG8O/Rb5KDQPc+EVLzhz2IMYxYomee+7BaBo23iEOee6MwFM+DtI01ybszd0dn4gfVQ5tQfkA==
X-Received: by 2002:a05:6e02:2486:b0:42d:8b1c:5710 with SMTP id e9e14a558f8ab-4320f5fd34emr27167935ab.0.1761606959246;
        Mon, 27 Oct 2025 16:15:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f67dcb51sm35024605ab.7.2025.10.27.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:15:57 -0700 (PDT)
Message-ID: <e6fd5269-d6c0-4925-912a-7967313d991c@kernel.dk>
Date: Mon, 27 Oct 2025 17:15:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] INFO: task hung in io_uring_del_tctx_node
 (5)
To: Keith Busch <kbusch@kernel.org>
Cc: syzbot <syzbot+10a9b495f54a17b607a6@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68ffdf18.050a0220.3344a1.039e.GAE@google.com>
 <d0cd8a65-b565-4275-b87d-51d10e88069f@kernel.dk>
 <aP_48DOFFdm4kB7Q@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aP_48DOFFdm4kB7Q@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 4:57 PM, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:04:05PM -0600, Jens Axboe wrote:
>>
>> commit 1cba30bf9fdd6c982708f3587f609a30c370d889
>> Author: Keith Busch <kbusch@kernel.org>
>> Date:   Thu Oct 16 11:09:38 2025 -0700
>>
>>     io_uring: add support for IORING_SETUP_SQE_MIXED
>>
>> leaves fdinfo open up to being broken. Before, we had:
>>
>> sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
>>
>> as a cap for the loop, now you just have:
>>
>> while (sq_head < sq_tail) {
>>
>> which seems like a bad idea. It's also missing an sq_head increment if
>> we hit this condition:
> 
> This would have to mean the application did an invalid head ring-wrap,
> right?

Right, it's a malicious use case. But you always have to be able to deal
with those, it's not like broken hardware in that sense.

> Regardless, I messed up and the wrong thing will happen here in
> that case as well as the one you mentioned.

Yep I think so too, was more interested in your opinion on the patch :-)

-- 
Jens Axboe

