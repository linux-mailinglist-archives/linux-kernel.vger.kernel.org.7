Return-Path: <linux-kernel+bounces-636157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52890AAC6E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A0C7A5941
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095EF281355;
	Tue,  6 May 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B4gFtCFY"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EA1F5849
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539309; cv=none; b=DWVw011fII7xLKUkTl+KPqckwE4ONKiEwekFoWZoz4s0PYVzTJ9Wh/NqspI+FsXarhqBQ7iBx9vsa6c0M9fGj2ekyvyCbpLgYbAMFCZjqSqqH3IbBGAbynqupNQKR3x+ZM2p3/Nnj3Q7LR3ykMGG1SIj6FpGTvowbhhjbftppqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539309; c=relaxed/simple;
	bh=QRGdlD65eNsYAPwAC1S3BaioH7MmJ5frZWnduOm9Nfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W63c1l5wlcxTl5SPg93/cJdnjcMRvCVkHrB6/udK2v8Zh4kCh/Jw6KGMPuK/gxQg6/Kuuldun4PuTNxSHHmFwngVen3PEEe5ofAogHjENAIZKVFpwAZDWiAN1TAFyYgG4aUVv3uCSWpyGuvgcoAEXuPCA7VjRmf1AJcyu8TKjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B4gFtCFY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d940c7ea71so30460675ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539307; x=1747144107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouux5tEC0r8GlXcTXcTxPnn6FWgykiMGJ+EUBiPslWE=;
        b=B4gFtCFYiTgeMUBkGtyWoAKMQatG2Ju8gQgQoJ+wPPAkKzzPGiVSqEv9B4ZuYBcnyl
         MHRQba5+0o0+zN1nGMhZ/L5CuUjzSOHQtgS58d8I4rp31DhbamWwUxcFT+iDamxb0ug/
         kFn9sLKPFhIhMh7akn9XyOlRikLUERfMV+AcpORKLoDUfEFqNdjHi8U0eYUU+62E1CUU
         USAFx0SCNbwxB7V/Oa3Bh11GZlanc13zDXEan1qBvNRCpgAaG/TVxB6sx11Nn5aNYWtV
         ucXIQSveMBsOu6xs7xcaFb28+rO0iNHDCcOwxQT8AUsuXC3Atx6D9wdmJgDe5lM+wcFV
         r56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539307; x=1747144107;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouux5tEC0r8GlXcTXcTxPnn6FWgykiMGJ+EUBiPslWE=;
        b=fvutT0kBAr4rRrQQoWuztPqLpId77vOoyJvulyCedUBixRHi8DMFRErsXyuwHXtJHx
         zvZDqcmYowFGP3HYrKo4scA35Znw+i/ot4TIFUKLvUDxP11FuPFZS4iRoMl5lA4y3+b3
         qPfeoMTcSXXdUZrweeVHiZHLWuGD4AxdOXEO496rxSHp31i8bUdkyrU1A10g6r3YXbvf
         4JCSQMUVFPsKUtDDlF6j6jTv/NAalBrSV8s5nEUPmNgEu9BXiKTSMfIPzm05AOIW7ev+
         WDAZCDIH2pYPA48yxI+ncO0iXDBhcn0uIn6e4KFPvXnpORR3bLWINwqDECHKLd+wPubo
         D7ww==
X-Forwarded-Encrypted: i=1; AJvYcCWaLXBeuRa7qs9TYLLDK0ZXOKOKRzY163QbsokVBbqXH9AE9a3DMRt89uGpXztL7RkdxHvrvqJ8hQFS1yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+hzLaAzmgJ77lGuQOZO8T0BJ+ZOMkai9hbqPanBhOJxCJ6dd
	cUFTEXUe9l4H3uXNM+M6lh+jvewk26yhPx1KbVhzBsgHd3+wy4qgrvGwbkDRv1o=
X-Gm-Gg: ASbGncssx3578KjnVJFXTs5m7KCQ9mxTY1uCsGHQT/qOk/NiFZNDylDKnCYtOyIVYaL
	2YEm6oY0AnUlZeJCfefMPg6VHcg2COX2GAPfeh2pBRrPQq8onjE40YR+OpYRxsJEkBEmvo02NR0
	lsRtQn7TDJyvD98tXLBsxbq4yTStyISAp6aXa84Gzq9VvvCKibfu/QKvSnJnmGFx1OqiU6fzTX1
	WeIoGFM9kaOrG9SuhYc1w8ZF6DbJev7BtY1IWI8m3ut6AF3r4k5oYWqf88SExdQSirBnYbnTCzI
	h2kVJpVM58rAsMsWzesxT4Pm8vzNFWo=
X-Google-Smtp-Source: AGHT+IFS6y2zyC+HSLyH0EZxcFlNsQhUlPmnmGKHIPFidATO98ChCD+1NzFKCLy5UGcU5KTMMpWodw==
X-Received: by 2002:a05:6e02:1fcd:b0:3d8:1fe7:4439 with SMTP id e9e14a558f8ab-3da6cdeedc4mr29148175ab.17.1746539307017;
        Tue, 06 May 2025 06:48:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f58be3sm25930915ab.58.2025.05.06.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:48:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, kbusch@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250506061756.2970934-1-yukuai1@huaweicloud.com>
References: <20250506061756.2970934-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3 for-6.16/block 0/3] brd: discard bugfix
Message-Id: <174653930584.1466231.14181176515309477509.b4-ty@kernel.dk>
Date: Tue, 06 May 2025 07:48:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 06 May 2025 14:17:53 +0800, Yu Kuai wrote:
> changes in v3:
>  - rebase on the top of for-6.16/block
>  - add comments in patch 1 about NULL page.
> 
> changes in v2:
>  - rebase on the top of the other patchset:
>  https://lore.kernel.org/all/20250421072641.1311040-1-hch@lst.de/
>  - merge top 2 patches from v1 into one patch;
>  - add reviewed-by for patch 2,3
> 
> [...]

Applied, thanks!

[1/3] brd: protect page with rcu
      commit: 0e8acffc1be10d53e909b3aa43831d6c2d25a579
[2/3] brd: fix aligned_sector from brd_do_discard()
      commit: d4099f8893b057ad7e8d61df76bdeaf807ebd679
[3/3] brd: fix discard end sector
      commit: a26a339a654b9403f0ee1004f1db4c2b2a355460

Best regards,
-- 
Jens Axboe




