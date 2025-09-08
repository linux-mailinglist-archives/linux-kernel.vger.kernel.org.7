Return-Path: <linux-kernel+bounces-806045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8585BB49145
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4115B3B6B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F7309F1E;
	Mon,  8 Sep 2025 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XdaW+D0X"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575BF1D63E4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341355; cv=none; b=on48eLEdILe5tb1TInHM7OWpqtpM1stdYO2DfoKmA04mhxzhK6Kci+c+wZJ4Y9lEzfn29LcpaRljiuI5VjVbjLHQgdJjdJX2LL9MHrCH9klQoMolBqBn4ch8jtASxmT+i92Gvb6Ptw8KdEgCsFeNI7ERe+Uq7oQ6lPspO+YHumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341355; c=relaxed/simple;
	bh=gk1ToXqLVfFHyrhWVBDKXmQcXtkR/eVynveNUsyE22g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D8g38a4SK9AgUeSCX/LytX2D/VfWhhmYUjdju1fW4hztHu99yg60N/DDTm+H6Z3aoLsr2ElBdervU/CDZjnvSz2MHHoeIg75gihdGyZO7jOsWgGHeKUIhG8GGkcd6CNZeEvBFjnG4ZQ1LPtw3vg9nz2SW68SbMY4JYPYSv0RWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XdaW+D0X; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24c89867a17so43001885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757341353; x=1757946153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrVD792Ek2sgQfwhqN9PhoMMPfdppvwqZK5xGEitoko=;
        b=XdaW+D0Xz0SAkxhCv6BaXxx9xY4dpBeMisoO1hCObKrbBtQVGV+fLwKc50FxFCIt5c
         eW2AVcWNH2oC0gAAhxqYS5ABBX8w/5xZ+y1b/9KqfdoUw+G4sdvaF35QpsCaPRsgHMpl
         N9nh/q50fUaA8cipHwMIwwg1MvdoEU8WC+bWJk2/ZfadDr/FaAx1yLHS8KO6p+1H871B
         fGx6wfc3DKVGEzo+Jz3O9umRHmj74dczSdqTW5Io9R7eT6DP7LDm7gq1GDRWzL1qTCcc
         xcAE4M0/LtxZuLJYEGQUOS55iL5W0cShel64uELBbXhqHLahK2gywGYCEYV8s4j881BF
         q7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341353; x=1757946153;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrVD792Ek2sgQfwhqN9PhoMMPfdppvwqZK5xGEitoko=;
        b=tPcmNb2Z9N+5jUcrBb3N/82PT1ZZGuVdqUXSBJ1RVEbe3zEl+qrWz10hY9OVggbbO1
         +qZvjO0ya2miAiKhPskRWYWGv8jGOC7vbfPuKCVZSJV25oSvfJ6hS8gKbdrmnxfH1c0Y
         TuP3hyo8ODDPNK66Di9CHqyyCjlgrwEoGUhUW//9j0tcCaM6ixMjqQKNyi7AB4NcAeG6
         QGyBZ95iJ6y7cj5ZuB3ywiOAHWCZ4C/AY2kkfVOcjmfPyktUTMJnhfMOFvR7IgUrXi0f
         AbD819msMRrMm7etTe8tdIrPeMLs1het8R63jSqoFTSogFWd7Wl4Qhd3u+oifp42BWQ3
         fn6w==
X-Forwarded-Encrypted: i=1; AJvYcCXFRtn3kWWcRvALBNoS9TBgU+8oxLURE8Xm25cco1v9yNBAtwT9TZP2dQyYjczHkRd6E8xLeaQJiPYrKAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+ShgjBTuRKt4SRjdpVwyFnE5/6jsW52qxZm0Kb4kU449yhR5
	C8zr92DYNTcDtTnEm9MzBPggsCupSoIlTMLzc5Gcv8HCILnLK9+DrKopEpi+paVu29E82Op1aM1
	VpTL2
X-Gm-Gg: ASbGncu3Gl56zhtVePxuy4iT4aas2btkuMpq9QieKfhlhAvz7Wsz5NSTFE5tBPB/yJT
	a7MeZCnELlYW759k135V0HmyQk7pKaR8Vf6xQFkcNC9m0qZPsyXV3y4YWNP/vALBld62+bPyiEi
	7Mrf12ZVt8Chvf0NVeWeQ64bj3HDqQOnwJjkQSsWFhAmH8zqTvqrKOuulEwsd/Iu/BxAhpfEbFe
	lmGR0Q5u/7iEAe6aRTq08LR/vk5g/WHaxVdbZjPvwHljpMfZKRb3m1uWckUD7QPOSfdvEUpaOQR
	Hza8tLZ+0ElbdeSaJgzh4MOLVomBifLhJOiDgY5s/we5ZirrqqY0/hP88yX+f8arDYQudQoNO3a
	SPcOF/Szx1QsYl6QRRWHzSXGoSA==
X-Google-Smtp-Source: AGHT+IHGxLKpvVKAbv0Afa6m356ddtcVCdDITBH1IV2TsqY9fFZ958JktDTLLt5K1bQmXfFDf9f0Lw==
X-Received: by 2002:a17:903:19ee:b0:24c:bdf5:d74b with SMTP id d9443c01a7336-2516dfcd7c5mr112932595ad.19.1757341353623;
        Mon, 08 Sep 2025 07:22:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ced7ea5ccsm96723125ad.111.2025.09.08.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:22:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905101817.392834-2-thorsten.blum@linux.dev>
References: <20250905101817.392834-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] io_uring: Replace kzalloc() + copy_from_user() with
 memdup_user()
Message-Id: <175734135265.533336.3277901531044251712.b4-ty@kernel.dk>
Date: Mon, 08 Sep 2025 08:22:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 05 Sep 2025 12:18:17 +0200, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify io_probe().
> 
> No functional changes intended.
> 
> 

Applied, thanks!

[1/1] io_uring: Replace kzalloc() + copy_from_user() with memdup_user()
      commit: 7b0604d77a41192316347618cce1d9c795613adb

Best regards,
-- 
Jens Axboe




