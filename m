Return-Path: <linux-kernel+bounces-762814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB651B20B20
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22627A9F77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46AE214A79;
	Mon, 11 Aug 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1ARCmCOw"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE821019C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920909; cv=none; b=hTB3ROmMGIJT2Cz5Tvp5/4T6VeHlzvSWJ758K9aq6g3XRXjQizHS+3Lu6xikfQgspre/u2IHD7raHYaxO0CZrayvDLtQhaoB/y57kDxpdziCstSsMpfZBPa6XYDgXTwGjX7LS8tX3qVuDhB+glU5DZ7MjaiVslsbn7wQLSM3bwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920909; c=relaxed/simple;
	bh=XBb6UToKAx2wcDx3fR5U/UqfyEBiYBSF/8BSiUStg+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FZgCt1KkDTahUAEn9aljJhWYWLobDmviPQner27Lyl/qa1bYqqf7ISXhWqY2BIb/chLSEyEi17CUZjk4Xd+z4Xecje+vlIZ11QJnT2an7gkvnT5OOLujcWhHnqcsluwubiZKmbHvbzP4vYXSvzwHqC5WaFVUUQjQZRzRnVGeSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1ARCmCOw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b428dd79d46so2824410a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920904; x=1755525704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjBs1p0/NbPjLuntxkjIdS1sRnWoFU1tGonDHNXLht0=;
        b=1ARCmCOw0UrnpCQRZclZlaRjB8va6tDROM3rcEU2n+q7FhgVbul1WbtgwgK1Okketg
         HLaVKjsb4PERW//FDb34JQzvQKOWUVLPSmhPm6KPY2ja1liqcGyaP6eskiIhrAXt6Xft
         sei6A2ggtoW2SanrODZqw4c0aibrDT/6mMu8VX+UibRAhDXQgzZid775wdCj+a+7sJd6
         hQPeI4Ymqm9aCRFYy9f5by2AzshirU6W44s3Ole/B9Ba54L7hTucaiXPe3eYequYj4Dt
         jZvDZT7PpCFH8gAmZO2+7Zq1/OjUeP+uwcBo3WpDt/KwqwkG6d5qO9vpMnmR2KVsfZOk
         3E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920904; x=1755525704;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjBs1p0/NbPjLuntxkjIdS1sRnWoFU1tGonDHNXLht0=;
        b=xIHBwuLBqDLHMUtY02jEw0Ck7ndiAmyBEX3rG/TYvtVaBdFufVhaKgKtRD1+v5Nudn
         //Imuf6RP0/Q8GRhIeMmuh55DUDyhQXOEGYZm4lPv8rP20gghl4XLhvZ6YVF9JmlASOy
         JCkSlpV2Klz2Ih2KNM3LwDde/vRC4Q+UHCFCaCOLr0HreEFkov7xvPIDgI4U5zZpJzs8
         5UJ58Hcz/R42KF9pDvzB99x4mPjPBF2QBpYiAiacWiVcXEKWEauioi36xFu8Q2OQ8t0k
         X7Dlg3jHav+leY5Ltn/qfdOCU8vDlMGkxSw+m78o5RUP0gT5zBEANqOT/tREjC2gIkMZ
         S2wA==
X-Forwarded-Encrypted: i=1; AJvYcCWwl+sZChoH74JdVP7rI/EYRj+RuUyizPLyjO95GLpqbbccScYq4FXRwwLUjSN+bCdvNWnBV5jAv7ZLziw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BkfMsBC/tWOv/3KwKDKmPfZg3Wt9HGCHkexCVhxoO4JKKro2
	b2vQ/8iKKzudt7IzwbqY2eh+Ls5HnmwJInr/H85NeUpNixPpyPMmlevQv5IpE1yKjUP03XHu1VC
	AKtre
X-Gm-Gg: ASbGncvF3uYjEQxDKktLa8CCbkWiZFaI2jFijV2MUKxZY8rWqVNK1sutTpYj8XgyIaf
	4OZYFDHP3WN+gHbJ/fc2taW++u44JwgKptGaDTCWhVr0/+nNbOte8DVe7VJiSa9jIM4HK7F38jI
	4pcT/+/CEWJX/LXzxILkZfr7NQE8e301URlxgaMgiyZRlXB/No0L80bReappQ4q9vcD7XVKTOQU
	5w5sLYeo71u517dglPGto36yJeAP91O3s08lcKXG08m4AfU09GKJBcLXfqeF/kIScGDZ6ShrYVv
	ym99DTOouWERpIQuHCXTEYQZY9C+ScJV3flpASr4wDMCw+pcfwatzdyyZRdAMulvqLVuDWk4gnt
	ZbNUOdQmeWDw59W8=
X-Google-Smtp-Source: AGHT+IEG+EPunzjJanJtxibmBqQfuE/BD/BPsLCfQHcWyKgSOYhhNJuA2U7Xhq6QKFdDKZa7AnFtAQ==
X-Received: by 2002:a17:90b:2544:b0:31f:42e8:a899 with SMTP id 98e67ed59e1d1-32183a0132emr17806156a91.13.1754920903742;
        Mon, 11 Aug 2025 07:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
In-Reply-To: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
References: <20250605103852.23029-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: Remove the open-coded page pool
Message-Id: <175492090268.697940.16894165700096915187.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Thu, 05 Jun 2025 12:38:52 +0200, Christoph Böhmwalder wrote:
> If the network stack keeps a reference for too long, DRBD keeps
> references on a higher number of pages as a consequence.
> 
> Fix all that by no longer relying on page reference counts dropping to
> an expected value. Instead, DRBD gives up its reference and lets the
> system handle everything else. While at it, remove the open-coded
> custom page pool mechanism and use the page_pool included in the
> kernel.
> 
> [...]

Applied, thanks!

[1/1] drbd: Remove the open-coded page pool
      commit: d5dd409812eca084e68208926bb629c8f708651f

Best regards,
-- 
Jens Axboe




