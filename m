Return-Path: <linux-kernel+bounces-811149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE9B524F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4C2443E19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7E18DB0D;
	Thu, 11 Sep 2025 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HG3VRjGj"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24528F49
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757550249; cv=none; b=YhMAXzkBKI8SnN7V6gSAjevcrjl/4nkxECspRGvRIduIAw8u9AiYHr5fgb0PRH9iybU7UENLh5xREvkPZCQA0KYnUD3Sif4UCKeD1W6q8Fq+omsf+8MusBDAFfsqFDpGjfvlQeMD3ZKUmcquEav4Nmd4Y81Wc3EgeY5LfXQtUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757550249; c=relaxed/simple;
	bh=qUdeIgHd1H/gRzOkRxjDb083t96xp1CDvpLuyVz7iCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K9bcgfo723o2+lYWY+7xzgRNOWW+BQD82XrNsfqJxQyJ0uBjjjJVMBLo3jUEI39qttGdFCHdf9Lp3ALURpeebY3Ek9MF6yeqVLqh9f4Q680+LMBAFn/wtl+Gm+WypZVOE8vAXTQVNUoy54PjzfBq3mndK90p+vPJ3hVAmQoiyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HG3VRjGj; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3fe48646d40so6691205ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757550246; x=1758155046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqQF9ujtoYtNLZ3rwwE148hM4Ro9xnZ4FQwRMaFPQTI=;
        b=HG3VRjGjfTQ1pdJ8AC+iaDKdAHagZ5L++24d4JJlSePTBnTS/JlIwws0we3wKmiZJS
         0MTqgk1yc1DYpb9XShumTDBoQNKGzA62AjZn9NrK1QVWcTelsu4D2rbYv59YhJ1SKt9j
         +R7s7n7595uszBq0LyJG6BicKc8Wv46rGMijMUEDeEtLsxdPfDNQU57MJC/LvCXTBKIg
         TDcqxBIDjcxPj8zdTA9pKKYah301iX29qXo7z694af2yTtnNMTibjAFShoUXKvRkfySK
         3fc6MRbtB/hWBuk5sEXaVNz3XjaHxX1XktuJuhzaCJTWxjCHz0X9KTN95pckpLnNaFeB
         UHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757550246; x=1758155046;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqQF9ujtoYtNLZ3rwwE148hM4Ro9xnZ4FQwRMaFPQTI=;
        b=YzGuYcK2vadU/8SOU3+Kx3CNjxGrmkpVBrsD4VhpsQCAGtMX0Ma7eQtv5MhE4NyvRk
         KghGcLs7NpCxyY4gVNAJbDKflKS3WAYMi/cPGoYrTufTJJtmR0doXrg5aacWclSkrgLj
         kmEiGafUIKT/flklnVEdCGKgzVkwngT65n7JJ4HdtNuUzXfoHUlVDFeVA4f7nCEdpr6I
         olVvN/daGuuLIVTUJUdRixsOCaHI5DrDpjmLRLbjH9udQPW6XbjFIs84jVOpiy9/RWe5
         S5opsAg7ezfzCEcUfVkyGBErEZyrGIKMHkZbfDc2limQqIclEaIs/cBr4PtPO2/gL1As
         cJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUrAJnDl0VayQKy4SGTc55LtTk67dvBcqi9b/LOUG59NkuzoEnMiR2VoxugexbTRwaI1mqHXspjpSk0hyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCpSRBda4ZwXodd4yisVzkZY7+l6od27mke+EmBVcRa1zMzx+
	7m3PmzbgZr6KOQm76o4kLOaef8kE9z3gUXeB5mKNkvGau40R8jSO0gfBI8vDtzDTHBsTmodblda
	wT915
X-Gm-Gg: ASbGncsD522hIj+QfGDFrWQ4TQGKotRV3AsVuGwIQB3cGKDAQuVuIkso6BtkIC8eRSc
	rhXjSCJCuXXe9J80puPIsxws4G3545c6kBCYIlae1HuyGH3D0qwepUOMhqblaPZBxGA4gf2bmUm
	7X0dF1kHj0yvI2zUOpYR5QE3CvP8gRHulSocCBJg0cQtxrJVqC2kVeQUsjWCgdAwKGQFwyLU8Lt
	ZL8IxErIOH5V178VzIcng0Lhb1KTJo4qYnppoG4wuNCo503FJtmaDRPAVeNZhEWJTCMb3kMfXo+
	KRXI8R+VAZ6cyhbCebgs1Qw+YmXvZwTogYZgfxxiW+ub8EOB72NAAQq1KFHdTBAwMpmIrMxM
X-Google-Smtp-Source: AGHT+IHOpts6PVtb95Al/bNQQ1qhB8ljPd6T6n47gEgj2bnO6EB5y7aCVxDcocz/y27CAZKkBJJjjA==
X-Received: by 2002:a5d:9496:0:b0:887:56c3:e6d8 with SMTP id ca18e2360f4ac-88ec3362a7emr225090439f.8.1757550246549;
        Wed, 10 Sep 2025 17:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.129.100])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88f2f0f9a03sm5557039f.17.2025.09.10.17.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 17:24:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
 Li Nan <linan122@huawei.com>, Nathan Chancellor <nathan@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250910-llbitmap-fix-64-div-for-32-bit-v1-1-453a5c8e3e00@kernel.org>
References: <20250910-llbitmap-fix-64-div-for-32-bit-v1-1-453a5c8e3e00@kernel.org>
Subject: Re: [PATCH] md/md-llbitmap: Use DIV_ROUND_UP_SECTOR_T
Message-Id: <175755023939.60476.3963353529532795428.b4-ty@kernel.dk>
Date: Wed, 10 Sep 2025 18:23:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 10 Sep 2025 13:47:26 -0700, Nathan Chancellor wrote:
> When building for 32-bit platforms, there are several link (if builtin)
> or modpost (if a module) errors due to dividends of type 'sector_t' in
> DIV_ROUND_UP:
> 
>   arm-linux-gnueabi-ld: drivers/md/md-llbitmap.o: in function `llbitmap_resize':
>   drivers/md/md-llbitmap.c:1017:(.text+0xae8): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: drivers/md/md-llbitmap.c:1020:(.text+0xb10): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: drivers/md/md-llbitmap.o: in function `llbitmap_end_discard':
>   drivers/md/md-llbitmap.c:1114:(.text+0xf14): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: drivers/md/md-llbitmap.o: in function `llbitmap_start_discard':
>   drivers/md/md-llbitmap.c:1097:(.text+0x1808): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: drivers/md/md-llbitmap.o: in function `llbitmap_read_sb':
>   drivers/md/md-llbitmap.c:867:(.text+0x2080): undefined reference to `__aeabi_uldivmod'
>   arm-linux-gnueabi-ld: drivers/md/md-llbitmap.o:drivers/md/md-llbitmap.c:895: more undefined references to `__aeabi_uldivmod' follow
> 
> [...]

Applied, thanks!

[1/1] md/md-llbitmap: Use DIV_ROUND_UP_SECTOR_T
      commit: 7935b843ce2184164f41c3b5c64e9f52994306f4

Best regards,
-- 
Jens Axboe




