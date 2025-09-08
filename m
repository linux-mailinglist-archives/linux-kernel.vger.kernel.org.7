Return-Path: <linux-kernel+bounces-806011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91660B490B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BF8179BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C7B30C63D;
	Mon,  8 Sep 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DXKYmbX2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349830B506
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340441; cv=none; b=jHqYoAXKI6XXxh3tu5NQ3E6BOUX0kFGcUmzxEwS715HaWT0xAYnIyWo6AgrjcFgGwN8Qmqo/dZwHv7bUCVW2PgpUQbEqIpJy51r/H3jpVKr+xAkBjkX7dCGsVteWVYxJfyvOnDRidNMbuH+68qFFLsVzhJqsnqyUbzf9K4xNISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340441; c=relaxed/simple;
	bh=aYfXtDS9nTGzq1iLtLPltpzgzJrU4XNIpK/2iOHPR8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a5ndL81Pimt8CWfbVw50GB57td3WePtZc6AEgxbOilI5j0eWixFg1++edlxo6yl9mJMgvXlwSMQJaJYqTgdv/iYxsCD2+zllSVBZIfD2Nq4xrr9up661lBFJlOHrTfxaklo1An9LIf0rs59C6yQD/ayuNPTgYlwzWqcTEMVK2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DXKYmbX2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cdd95c422so24219565ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757340439; x=1757945239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXnmGqVzM+KWf5lbuMCIdLr1YvWgFnaAhFpjEUGxu4=;
        b=DXKYmbX2sMxccmQgp68DwexLk24qF5Cjumxno8U9HQ+F7F4mjkfd6tAS3Iwrk+8nhK
         62vTt78cFb4R7uRduTlJSntXn3lRUlweRqW71B7eFn0VgwPzbJuq9PLeQz6fm3cy4WhS
         tGwtUhZQSwTW6upWk9liYdeQmX46nrws5H5PArckigSSmI150/G0t+R9tTBILbb+ttB+
         BRHmto0hI/THGx6l4H5TIgZn1c8qrf8PAvinOyNaYeR+5zuROPTyeXVFp2rT0z1BZDM7
         LCCw3oE3JAB4oHUV5CypkbQccHwE6TE3DdOY94gNzU8rb9ITUEn6R8/OK9adjFldUOco
         Ud8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340439; x=1757945239;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTXnmGqVzM+KWf5lbuMCIdLr1YvWgFnaAhFpjEUGxu4=;
        b=B+18Lpjo7U5twc5m4O/u4g9H/WWiCtmP5HY5XjkZi1GZh2llRV32+ZLtHDFzIiArrN
         wGde8HTu74fRjwwuUWJeRkP77TbNyGWbKzNm4HljnM06ycJr2z9w22hVgTVkdBamnIYr
         IcQ6CUtBEETI1Jkfbi4i413fMnVu51lCFcuFA3IWdpozUXGIqEqb99hYNaEwkKjEfpSN
         /LuNX0vRsbzPuHNB3GmOTZgpiO+uqEQBy7nE6I3Ed4krnQ3UvWMsdy6VWnpx3EHKVs9l
         eVZKiV2mMvc9RDX/gsARUzhElwlK89t9PlMIYtWjV3HMIM+t6eB2heHKdbeTNsXiDSwR
         Dx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWum3fmNQTm23GWz96tc22iwnCCmx+xj80C66zbypduQTIYwWa3CqVeB2SrAuH3MTLCizjyf4DN8n6Uwag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHP8bb41s47cm85CZZeeau7FDRIGVe7z7j4vB6EFoI9k1ikge
	2xQWXu1h7fRp53bcDV60lMgzcM9N20DnHX4/JVJoXvVfEsArjqxKMP/alkmAdXDgheM=
X-Gm-Gg: ASbGncuKKlDJcdqeoAB9fUKjtA5GtsMn8bD4IU3etnGNF8xHS67bjCDiM7XkV7KjoRL
	LEOF05gT//XNKR5pGCpWZrkKYk5XR7qVCfsY4gvHECi49xNoCCJfOhCYkad7Yi3nDtRkIjwolpO
	8zmuN5y8MrXu1hDrzD4bvjAap9tkJzEWkix4Dq8ihYXengKg4XDO9lLL1nAxkzi+fVhHOiIiuEd
	rKaDcyEKNXUgUOjJhqsmeb2qp/7qcqfoAx9tnarVNNt8Fuju3u5pkK5+1EJnCR/eJbc0MAXOhWx
	4OIBeLUIP1uxMd3i1YBJd4/CdXRXb0zMxhC7O/yyGOdkeVjiIsJka2pDL5S9+HXy4GVOsILqLSl
	NQd0cI4Ex9Opcf4st7J8BRJBmYA==
X-Google-Smtp-Source: AGHT+IEml+sIqWPnOXtVuJ9P9UFE/5M1k7fHXlQGs35EvdbJZOrAOZfeow0XgRPZlzYuNO/4srpyeQ==
X-Received: by 2002:a17:902:f550:b0:24c:be1f:c204 with SMTP id d9443c01a7336-2516f04e1a7mr102871665ad.22.1757340438598;
        Mon, 08 Sep 2025 07:07:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm154811625ad.83.2025.09.08.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:07:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: dlemoal@kernel.org, shinichiro.kawasaki@wdc.com, 
 johannes.thumshirn@wdc.com, kch@nvidia.com, zhengqixing@huawei.com, 
 willy@infradead.org, namcao@linutronix.de, vincent.fu@samsung.com, 
 Genjian <zhanggenjian@126.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Genjian Zhang <zhanggenjian@kylinos.cn>
In-Reply-To: <20250815090732.1813343-1-zhanggenjian@126.com>
References: <20250815090732.1813343-1-zhanggenjian@126.com>
Subject: Re: [PATCH v2] null_blk: Fix the description of the cache_size
 module argument
Message-Id: <175734043756.530489.9271318781482423583.b4-ty@kernel.dk>
Date: Mon, 08 Sep 2025 08:07:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 15 Aug 2025 17:07:32 +0800, Genjian wrote:
> When executing modinfo null_blk, there is an error in the description
> of module parameter mbps, and the output information of cache_size is
> incomplete.The output of modinfo before and after applying this patch
> is as follows:
> 
> Before:
> [...]
> parm:           cache_size:ulong
> [...]
> parm:           mbps:Cache size in MiB for memory-backed device.
> 		Default: 0 (none) (uint)
> [...]
> 
> [...]

Applied, thanks!

[1/1] null_blk: Fix the description of the cache_size module argument
      commit: 7942b226e6b84df13b46b76c01d3b6e07a1b349e

Best regards,
-- 
Jens Axboe




