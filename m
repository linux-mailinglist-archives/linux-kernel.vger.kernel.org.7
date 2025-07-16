Return-Path: <linux-kernel+bounces-733711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE27B0781F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E904A4C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88227253B4C;
	Wed, 16 Jul 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yxd1+z9F"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FA26A0A7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676209; cv=none; b=J1nzMZ7Yusywfbsw33T0REOq39Qfwi7e4ScPXDeVQ4Z86GpqHuWoShQZelj3R3oFA3sbqriukBFDByDvINnvL1J2yxGL3CvBK2ffFzepJt8faopqSX4ic4zjY2uQWSSr6rrYg36IFZUozSOzMNJPh4Z1qZUFg8Ca3Cmx3TCiD5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676209; c=relaxed/simple;
	bh=/fySb6zX4m+9WPPxh2LDL48r4LjPg+Qsne8ngkjNZMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9SPMG9tCnPrcJVE3eD4dSdFQcwWSAuU4fHF6jtvWsyP5pLoeLZbkqMmZDbIHFpAma8ADsSyM4FgTPxny/+09P4qii0uFhmoxbrj+QbZvr63/0wIZ7UfLQ+ifAr/hCS131G7cVTdZ9XVAIW0aEOO0pozKTG7NdszgK2LXyd3olE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yxd1+z9F; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df303e45d3so21019955ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752676206; x=1753281006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Uojjm6fcLZ+mUddp83QrZxw9M8qmMMJaZaJ4O0EjFU=;
        b=Yxd1+z9Fr2E2ck7ymxSz5K8tZjj5M/ei9VR94p6SkHhUKNVWZNMqJuPs+vI2B40VGJ
         l6PqybHStKmJtJT+oEJbI5bXjH+kNCAg7/JdZeE8cqQfBUMSm5xgNA3fPF6EDxjHUHA0
         OvMW+b4bLHwSxz99aKwLzqr3T6226TUk1qYBC7WA4eR4+xs/nyaqRRiyOxIqIsxHge9e
         tu+27qTxx79YYvXabBPGyHoJiEdNAkySiV4dihaPykMYcqRd9Kf3hwVYm8xf31wovPK9
         abDmU9Ep9jeIMj88/Mq6Xx5sA0isZJVdseiG8miX4aHdRWZIibzdzG6Us+zcZqjInkYt
         nRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676206; x=1753281006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uojjm6fcLZ+mUddp83QrZxw9M8qmMMJaZaJ4O0EjFU=;
        b=bTErkeWOkF46niVRHeGfBkDsnSFPvsXxjuCVlRM45v2Ez2CjDAH3BS4/ywn5uRbgro
         jKIoI3PTulbftVdtMbNd9SkK4NwHQxJbRKODYNZ1c5dSkQ0lilcEIgmYS1oe0epo6WMJ
         NbLkzoJWjm3nxKxsbZueZmJCuiHGhxrTy2HVLB01n2DpXuSFxw9NdxuEGens05f2rBmm
         OQyypHN3rCc7VyNOtuermQ1wtX8XYkcBI44+wFhpMa39DwohOfxILgsDwXEKnvTuplIY
         K97Vgy+k5ov9lF0MvgC+weAxwJr7TZtg22F8bIAKxT+hp2EBazauDfq656mUVv6RG/TR
         +8hg==
X-Forwarded-Encrypted: i=1; AJvYcCUhMODupKP9JHxqkuJJVuUPdeH4oOytkUmJmuOwP70Mz8K9sAhdelAGxOFuubkRq33OV7vQ0rXiV5gEMjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxh9ClLPszS+cMZXkhKcdEcK1QaqdazAlr0MNeEZtf3yZ6b65e
	9oKObhHLWF4Q5MwhCaN2pAudD4Glm/LlGCheka2Zu2CBmceDAcYDOyikeciaomhgN0M=
X-Gm-Gg: ASbGncv2s6ZD4JivHPAlXebmpFSfjf1s98Ta9fKKVLyjY8JexEfAqaTBuTLC3Z54K+4
	1ZZLCUQoH+698z8gZucq8oGSe/sL/jBNy67cOz8Fbt6HP3rMOj7qOPdih/hIo++eJ9jGQZJ77EF
	tVpRw+CFu5K5OQQvbWELR4vIMfOZWmwnQy1P3qqUbMR0rZRptX/QcGfmK9vD7Oq00vnPRQBgx9h
	IfUfN71dQ+UH1dT1AnjN0FftJsEio60JggbjHs5S5eO6cyFaHTuJU5Hf7HXZNpc9K4IszUlWWjQ
	Cqq92qZZ4QhDdxfCOBmGOEX47w0jU50w4qpk0npCMc2nveAzH1GuCdI3mTLSLUdwmCP1+4/pgjM
	/mUCqKJq0OJ8w1IGhXkU=
X-Google-Smtp-Source: AGHT+IH+jLRGEsW4dtjrdZr5d6r5MlS0/wxSW+OlnfF/Bx4B5TKy4HEdvsg+u/BOVaab0R+9o6M71g==
X-Received: by 2002:a05:6e02:4508:20b0:3df:4046:93a9 with SMTP id e9e14a558f8ab-3e282300e22mr24807975ab.5.1752676205462;
        Wed, 16 Jul 2025 07:30:05 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556973079sm3091349173.63.2025.07.16.07.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:30:04 -0700 (PDT)
Message-ID: <9df85c99-4f2d-4d12-875f-ce68e781c107@kernel.dk>
Date: Wed, 16 Jul 2025 08:30:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH liburing v2 0/3] Bring back `CONFIG_HAVE_MEMFD_CREATE` to
 fix Android build error
To: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 io-uring Mailing List <io-uring@vger.kernel.org>
References: <20250716004402.3902648-1-alviro.iskandar@gnuweeb.org>
 <3b28fddb-2171-4f2f-9729-0c0ed14d20cc@kernel.dk>
 <CAOG64qO1S+hd+cgabQn6uYMPGAMm7V-FRmm6btytZE270bEebA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOG64qO1S+hd+cgabQn6uYMPGAMm7V-FRmm6btytZE270bEebA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 8:28 AM, Alviro Iskandar Setiawan wrote:
> On Wed, Jul 16, 2025 at 7:41?PM Jens Axboe wrote:
>> For patch 1, maybe just bring back the configure test and not bother
>> with a revert style commit? There is nothing in test/ that uses
>> memfd_create, so there's no point bringing it back in there.
> 
> Ah yea. That'd be easier. I'll copy the configure part instead of
> modifying the git revert result ?

Exactly, just make it that single patch.

>> IOW, patch 2 can be dropped, as it's really just dropping bits
>> that patch 1 re-added for some reason.
>>
>> All that's needed is to add it to the examples/ helpers. If it's
>> needed for test/ later, then it can get added at that time.
>>
>> All of that to say, I'd just add the configure bit and the examples/
>> helper in a single patch and not worry about test/ at all.
> 
> Understandable. I'll send a v3 revision shortly.

Thanks!

-- 
Jens Axboe

