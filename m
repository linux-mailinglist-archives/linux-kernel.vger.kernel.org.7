Return-Path: <linux-kernel+bounces-865145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD6BFC441
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1386A1A618A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9F34B422;
	Wed, 22 Oct 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hMrioFTT"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80B34AB18
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140778; cv=none; b=L2nEqsEDna4VqzKiociAfIRxRSCUA/oiwvEhfOqdj1NsVZHGixVtaVDoW/Fd8Ao6exjE/qHwGyhCfLN4Pxevxc7yaWws+n+FP5F9sf7bIX85loeFX27/t9++XGLBIkH5VXyaIyeWa1SJrsXcu5g7qCGC2n+AdNLB+D6Tcg8mpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140778; c=relaxed/simple;
	bh=yA2lWnYeOsGMIHc6VyQMkPT2YEEU6Yd6eVJPkXh8Tyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8vdwpcoY7C75Hd6LT3OFI4/KTmqo4wyxWK19HwhZyAeWPx/aleGRx/0/Saywx7isOHToGmEVkvs+uGbbLD2aVyulEZm99uMOIRJZOF9DuO19FwLConhXVfhugFzJ/5mCwLaqRdw9Qdo53+7KSBTSEnVyz/2q83QiOByzpa1O84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hMrioFTT; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso589181639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761140774; x=1761745574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMa8S3z385kl/4H9dQfYkDdJgEgDVCU2D6eCwoHGu/o=;
        b=hMrioFTTW1Y0wTK7/XdqDASYG7XFxQFuc9MrjO1lsqw05EEb+wTV36ANpIqJlR4Aqo
         YGo+TPR0Ly3GRSZYprFTvowj5MRQiBd23sAiOGYufjnNNyltzMFO0BkuX0Nvf/acZ6mo
         snEfoQ0P8kb+qsy+NnhDyMlZvcR5eOkaXcVCnyBVeH4+Zc7OJskDWLePNVFjxRkbd6tP
         YKKgToaITRQLfIoIbOii6Gkn25gFtWmpjzrskOShBTP0IzKU8KRCN3TiGgbPRYBbCGvh
         AKlfOfZ180XdOrX90gF91PDrKC1KAzBojYRDQETneoGFS5ZxO4MlW5fi2jMuf3bPOIhs
         29Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140774; x=1761745574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMa8S3z385kl/4H9dQfYkDdJgEgDVCU2D6eCwoHGu/o=;
        b=FeD15/OP7Kyli3JC0Jlb5NUQ71hqRv0TGPpjo7ldL8+b5QXD6GXuvlMsYuGBp5NUUz
         6CC2yaBbxBe0rWbfddZVH/GA/jAnB97aXh3HnahJYgV10U/6bnBJtD9paOoUNZwaOBhc
         DxVH65uUY7FbhN1DOuifOMIjqSGvTsBXAclASTYkxN5sDVdU/Jbvv4y4BOr7Q7nk+vbW
         dBBTQrBz2Sd/tSNXqFPaXzBQs+1pB9dM+TU4tnh5OVc1kVO9k1hZIf8s8a4EyVxHqm7y
         RcgHBeWl2N6tHEMbSl4viMnYDB1YzIvJgrTUpEQyG5op6++3X8v2IAH/L7el1VVneqJn
         SlIw==
X-Forwarded-Encrypted: i=1; AJvYcCW5yhlktrVK7hQaRRUjl4gI8QhoiOMkkgtuGC2tqcBuQFAwWKDyJ5jbwcp/SxhH0RAecU+YdwcIJPRbg28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTcseR1UwOyNEo0ejFykIvwS8UTPiFG6oDIr2ZJVbUFAaTosp
	Rxza6pwFrEbhVFPoO/kCQM50+Sry/DosXZHnvI85+KWcrPXmjixN54tWmGTHBJJU/BA=
X-Gm-Gg: ASbGncueqIfJlxmZ4tkXVojxgML8yroLvmCkFR15sequjTQeNlooicWiPKi2LUu17pX
	H8HNf+RKT132YvR92fldDujDI7illIvFFgYXxOa/eg7kDopZJAycl9O0h/5dYP8Icoywweb8YK/
	Bjxe4OIjxIkVK44wX9oQf8crnVcgdKgalvEtxupUepTXS8octt/GTLCrUxg5yUs3GLZD+tgcRUT
	7ACeenjsOMLtgdkO2rINXMItz9XudGraR+IalU4y+ToCFOHiCdiByGJhV4Rk2y5+6dhK6RkWVYb
	4d0a3zb4kMX2vCxXS3c5CuQbXhrV2qdqfptZtBFYV4UZbmAoYuTcxrQK3YMSVCEF8CaEUzdKIqF
	0jJcf9b1tUwuOhx0+560Sd0Kqn5dQOaZFXV1Jd4jv8/7jtpyP0zusYmCbbFDuAR72LLbh1pGC
X-Google-Smtp-Source: AGHT+IEfD6GtwrizjSnSJ/vma0lV9Pjo5jtl6uYqaNlzb2Hov9ADryiCCr909jA9XOYjXdKBJYINOw==
X-Received: by 2002:a05:6e02:156c:b0:430:acb1:e785 with SMTP id e9e14a558f8ab-430c5208dacmr295440795ab.6.1761140773944;
        Wed, 22 Oct 2025 06:46:13 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a8220sm55488655ab.25.2025.10.22.06.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:46:13 -0700 (PDT)
Message-ID: <e5f234a2-ef18-4a54-8436-f23f7490c9e4@kernel.dk>
Date: Wed, 22 Oct 2025 07:46:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] io_uring: Fix incorrect ordering of assinments of
 sqe and opcode
To: Colin Ian King <coking@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 io-uring@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022134431.8220-1-coking@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251022134431.8220-1-coking@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 7:44 AM, Colin Ian King wrote:
> Currently opcode is being assigned to a dereferenced pointer sqe before
> sqe is being assigned. It appears the order of these two assignments cs
> the wrong way around. Fix this by swapping the order of the assignments.

Fix for this has already been folded in.

-- 
Jens Axboe


