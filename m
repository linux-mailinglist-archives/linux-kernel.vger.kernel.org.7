Return-Path: <linux-kernel+bounces-883217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F920C2CC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD274F7815
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE09314D03;
	Mon,  3 Nov 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p0rKVsVA"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964012820A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182986; cv=none; b=sYC9yALrf/CurFodczHIWF90bFhBx0JU4CYoSB+Q7yGIJJyhtFAS4pJX80u0DCf5mLvj+NyrLvP+m2STKJaiK7CvMxxbrX8qu873XJbHu3D5ZfS68NkGRysIE8WRQx28RMmT4UusbJvh8v0zntLsYtm8fCtU/LtU71D0Wme+l8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182986; c=relaxed/simple;
	bh=uZ6Xidk2wofrrLGL5yO0fX4qOEWi3KgiJ4NEzuIRHmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q5XCt+OB+WTETYCB1aY2586lzANRxHk4lEwQVBoPVDDyxtepfEsz3I52gU9PNIW4Q4oLqH+V0zAZHg7rPkO8oQocEzxVucMKIxA1bkHyvsKX9P1wzibnCx5r64/LT4I8ToQi0vz4ewAP6Y9skvtKIYLT8iJ1qCuxSRNjcTxW7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p0rKVsVA; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso463176339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762182982; x=1762787782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2VP5eHd4whSzt4tHMCcMt8UV6SGTODxfAS8gkq2xxo=;
        b=p0rKVsVA6tMM2Wcco74mup1BaHvdN7wZSflCnXPXGnFhq+TjFsFu+AC/AGxVIjtZKz
         3QSPsczErdCvk1NVTewuoNi6q1ttVVlmnVt4md4IhhMU6TqZQDvWNHBiO2ONJo02/PMm
         Wofw4/fpaIzblEHpuVNysIDev4BlmXdtb7UYLCYvU9HU9gJAz6pjHlqVOdygxMh3uQiK
         vC7Zm2qEHEnarcIQQVYqevRRZqSx4oL5mARHxykyqKyAB16FRkUeZ2NEBHybf3Vh6Gt1
         cwokRonR3de97fvOHXAjiOAArOvvPAbs8huMukDCM6LLMp4PwK1i9/id9Hc6RGwxjDk2
         nU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182982; x=1762787782;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2VP5eHd4whSzt4tHMCcMt8UV6SGTODxfAS8gkq2xxo=;
        b=POkwDd5gr3cK/L3DUXSLu69/HjpVGR0qHQKfuXzFCEsU5qG3dQn2PVKcxKZa6pZKtK
         vV0ZyhKjC92WIdJADfz6A6BWc8GSK+mcBAHaEI2MOp3F8Wssz7vIV2Eb6OHfNkIlT3rA
         F2PZtLT0jll43B/YuZdWb15ZWguvBgyS6lOAD/4EvQ5c/wKMmEn1VadIKNTm5wntNv+w
         6RmOnIiKzfleaqJuJJGXFSGspThoDKR10dFV243aUSpueqerFq6Y3jqENwZOOGXI67Nj
         IGRycE0iPGQOdtGL4m0o7lWzK+f7fuzW3kSM5wGXZbFstjuMtTczCcmdikoOXyqZ1tKK
         hJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFg8Kdx9jGfD+8hrKVKOxmTbxc+cCvL8li5mn7JHWIxiRajPXJRzIp/W8TYqO6Dk8ohuZRAD8Xf0eKu+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA2tKxNygMB+/bckYr6xy4ihzuc0o77/pbeB1DIbLDyw43jggs
	FMxPHveNP7gvghSFNaNcA8k6ZvE8E3VNG4Sf2z4YFhCR2FbQAIYrgnzJO565iYOC5FY=
X-Gm-Gg: ASbGncus/5hy2DIKlhGIZ+UCxvlcDX/Hv9z0Djv/iojZP5rno4Oj1h2WID7TE+4Zduv
	v6I2LWVKGjdXfHlNJM2HQ/lNbGVE0TnuGFwcSvAplqXpHcoG8eReJEIVJtKJHV0Sd9QICv4iwrK
	zUCyuGTZBuD881MDeXC9VZNZBcQHp1u70oTsW+kNHCxkqZ2mTUAsRL2eGCfSNsT6HTy3GRN5us3
	VnMsSGRAof/DhiZCIJpGSsjsX295rlX4c8AskdJTzCbfJE74YxWM2/bXgax+z8M7eUl51yqBgWd
	tgYKuGtjWAeGP3VHZMn5fMc9Txg2pDrtQXSNt4pdws5Vbd0N5+wEhNJkIUECqcm6FLxl9gmaVMV
	QAMlfWXtWA89UHYEVIvTPuACETW1DJ5gz8qOv1+F/XaEhTvsWH9JvGCn9kuF7NEjUSFs=
X-Google-Smtp-Source: AGHT+IEiDN1o+PM/1Z7sT1acon36b1aVtRVhw4Y/i/XVotDAKRdH4bIM1pLS9oCqfCdsagASs5k2KQ==
X-Received: by 2002:a92:ca0c:0:b0:433:3192:4aa with SMTP id e9e14a558f8ab-433319206abmr40241605ab.4.1762182982356;
        Mon, 03 Nov 2025 07:16:22 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d620sm261819173.8.2025.11.03.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:16:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, Shi Hao <i.shihao.999@gmail.com>
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
 drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251101054422.17045-1-i.shihao.999@gmail.com>
References: <20251101054422.17045-1-i.shihao.999@gmail.com>
Subject: Re: [PATCH] drbd: replace kmap() with kmap_local_page() in
 receiver path
Message-Id: <176218298119.720460.5302997686043809131.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:16:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 01 Nov 2025 11:14:22 +0530, Shi Hao wrote:
> Use kmap_local_page() instead of kmap() to avoid
> CPU contention.
> 
> kmap() uses a global set of mapping slots that can cause contention
> between multiple CPUs, while kmap_local_page() uses per-CPU slots
> eliminating this contention. It also ensures non-sleeping operation
> and provides better cache locality.
> 
> [...]

Applied, thanks!

[1/1] drbd: replace kmap() with kmap_local_page() in receiver path
      commit: 77220f6d18a22b0b5d73b5d2156609b0aa21a7c5

Best regards,
-- 
Jens Axboe




