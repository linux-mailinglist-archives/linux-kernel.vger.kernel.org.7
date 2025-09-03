Return-Path: <linux-kernel+bounces-797564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E2B411F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0EE7AA83C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7A41DE3A5;
	Wed,  3 Sep 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sCbpSSaM"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9632F77E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862983; cv=none; b=DcxRyRY+WJ/UfkPBLRgL2nUvvmZY0Ip43g6DCCfninBj1X/y5PjAsNknNbJAeZjiB753/Kb8e+XzNxbkivkmAilmXiAs6H8yuhgKuyLAWyMfC92kWRm4orcWgedaM7QxyXEpEnpaJKhShGXifFlxVLxwkQUD9IG7nB7xkAp+7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862983; c=relaxed/simple;
	bh=yxbGDAlXwXjHJB2FQ1wC208jWYk7GPk4kAGOyTurXpE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fX00ILTBHBZ9NsIXoahNxB5pjUhfn/JSYqGCaWlMkKfCURdTf8a/yrFRPMnUkewSEiC8oT5gKoGXWmNUrmHBLr8kneqDj/FNpXYNAblE2LNsmmWB+F79gy0TCctzJf1E82eQwQJlF1yHUNCMq3O4T9ak6xRaOtgm6BTNJLxnaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sCbpSSaM; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88735894d29so115722139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862981; x=1757467781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kNWPwo3RZPYSGaYOavlf6Vybs1SrH7ZAcibW3DYXOzM=;
        b=sCbpSSaML244KUVxszfjTcwMFVrofyME/lKJaKA8NdDEBbXyXaJmiWGf7NgFpU4hEh
         WesPZ9mEce9BInok6EY4A4aVbaUEbAKGlE8MblXjfklUTmK6GGTEW54RPZCt6EkmOZMA
         +B/JPk936jJFia+le/xJBeAjv0EA0IfKvyPZXI4ST5zeqb+bX3kvwcGUJolMlXGwSVLq
         4GxEqo4yIwT1aZ+1kDZ47n3fFxoEfSQCJy0eyrsDuxRDJhBlcma4IMpPs3Iaf9i7udOQ
         5TKmQ+jHFlcZKGdJqLyqiBMVPHyoxsCywPonCOZCtkH54QXEU1bK9+ONb36O+ZEXz2r+
         rFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862981; x=1757467781;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNWPwo3RZPYSGaYOavlf6Vybs1SrH7ZAcibW3DYXOzM=;
        b=DfzmfvnZ6whg/m4D09zlP5ghfz9OnKDrE1EPlObauaHr8DHgSQcopctX1Ww6HGv+8K
         s7ZWm1Pql5K0u9wwnuUvnagEFiEy0MtR8oMT5gjnOAdIWzvCwm+HR8a00rCt86YHWc+g
         Nae8Dt3cb044xW67v7YuqRFwfQTS7g3Bh6fLfjWhh4QFr2MUi3hQv01vY4U9Jd9cVJgE
         dhxD96V2sizdRdLgxk+F+nc8pvktxUTVOfiZqpp+exmb47eMZOIpIZLXoS8hjlz64psl
         hLZqKwadPnwRVWaVRndf+CwzYnKug2aye8SYM+O8DRLgFDZVBVnqvHRElE2vtUjR7BlE
         1kLA==
X-Gm-Message-State: AOJu0Yym2kyPx+8mZLLGPj9Auft61FlalVsBjaLuwO8rFMm/lfz6+AMt
	vVycsKrh9k7ZMQGyEokW/FO5uQfZ9rZyAopJDq+t6SP9o3rh3oiJS9G5KvJzyy+N5+AyPC8YpKp
	FD2Ax
X-Gm-Gg: ASbGncuwh6/cKlrsVPaiMDDSLWzEkdYxdwt7UpBHU+8AtTvIIya0y1ZztgVKSBOEJ/v
	JnYtnTmAoTsAbDIJrEiGNSfLYuPFzOUIPNQXIThFz0SatdNW1fQdhE3ntap/dIZHIppW2BWuROk
	K77c0mGo/+/yBkNuyyK6bqEWlaxh4v41l7nk6ndHC6gCcWYvAfx9yK8xLDnAWIuhen53/V3WbrM
	0qRiuw5JC3tqloCvueykfw2sEnmQw2fDlqfPfTnmfNhAFbw0Dmiw3FNZCxhMdlqO73KoJgCO3De
	ApoxXqCw9+NadeoOgFlq+snch3sr5osBZ/6Lk2fHvmg2CdJmEIUMLd3ZfqNowBt7TivfLy9nDla
	7aFKr8bYbiUQf+MHfg+KeToZZHLTrQQ7/uutd78xOc7X0bbqZrmYfhjJ/
X-Google-Smtp-Source: AGHT+IEnXagptIiPkX7lrTMbLPm1CmNREiLLSSP7NfTiNONIFc50ojPgq3mmYLevYpubRVrxVZ+DKA==
X-Received: by 2002:a05:6e02:1a4a:b0:3f1:b54f:5cf2 with SMTP id e9e14a558f8ab-3f3ffda698cmr249146535ab.2.1756862981051;
        Tue, 02 Sep 2025 18:29:41 -0700 (PDT)
Received: from [10.11.35.62] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f3ab9c9sm3466418173.76.2025.09.02.18.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 18:29:40 -0700 (PDT)
Message-ID: <0be5cd99-9b0d-494a-8648-d767e06eb02d@kernel.dk>
Date: Tue, 2 Sep 2025 19:29:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] io_uring: avoid uring_lock for
 IORING_SETUP_SINGLE_ISSUER
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-kernel@vger.kernel.org
References: <20250902220803.1932692-1-csander@purestorage.com>
 <97fbbd68-cdd1-49fa-82d3-e3714ca70eeb@kernel.dk>
Content-Language: en-US
In-Reply-To: <97fbbd68-cdd1-49fa-82d3-e3714ca70eeb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 7:28 PM, Jens Axboe wrote:
> On 9/2/25 4:07 PM, Caleb Sander Mateos wrote:
>> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
>> an io_uring doesn't actually enable any additional optimizations (aside
>> from being a requirement for IORING_SETUP_DEFER_TASKRUN).
> 
> Indeed. It was supposed to enable future optimizations, but they
> didn't quite materialize.
> 
>> This series leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only
>> one task submits SQEs to skip taking the uring_lock mutex in the
>> submission and task work paths.
> 
> Interesting, would indeed be great to kill the lock/unlock for each
> submit and local work run. I'll take a closer look at this tomorrow.

I just noticed that you forgot to CC io-uring@vger.kernel.org on
this posting. Would you mind re-sending and doing that? LKML isn't
really useful, for anything really, the key list to CC is the
io_uring one.

-- 
Jens Axboe


