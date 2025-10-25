Return-Path: <linux-kernel+bounces-869773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3DC08B38
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA081B2513F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 05:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C7223DC1;
	Sat, 25 Oct 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU3j+7ET"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD05C96
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761369372; cv=none; b=tyGmtGF4RGelsBn3D78wit5i007jMArrk1N030+QVkD8dxJkZg2yE17R6j8RqSVehmuw2XRloOTnG5tDA2e/Mz9+2HyPAe+SkRebejuynAJIUVRz5lV/CLlYfEybzBhiO+3h/hHonNHhYpjQPXJ6aEbF3TB6AOHg4+rqBiYAu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761369372; c=relaxed/simple;
	bh=n3Y+AcN/I881f5Cyv0rcUjEkJzVPX7TxD3E/j95volA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSt9wClqFU9hwYDmT4HGwQbDUIh+6kRrDJ6FFjHqfIzlM2pmmW3/ktiQgCCe86JGKdBD7d03LIdD3vWgZWS9K0hfbj0fbQlZvlE9ZHN1vhy2lnV0iOEYPrw09xMR8FM493LUG+4NNJXSDfcvRr2qb3BDj81lJBEOaIXa3/i1TMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU3j+7ET; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so5361180a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761369369; x=1761974169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apaAoIq51aRtrkFWbmPU/2WaEbN9gRF7gSr6IfYPHi8=;
        b=JU3j+7ET09LfzkDeo+C95SEee/p+pO28pfNZ1+hPVibtBMVnDRS+6URIIKLDOo1U4o
         bJm68VDzWcr6QE4WLYClWoTl+yC9JMDuXBq7EukiTXwgCQFVJSqPWEbK5KV56PDnDpGT
         YaevZgwuGHSo13Gj7aZFA+iFhHAUSKXeCjkVo3Ji/1c4h7NMNrAwBzgVcGgkZsopECa1
         qKFtPqHYo81fGICKhuC/OA4fhcrIpZXAvG+zYHw4av6xHNl8c9wh6CmAZcfP1oO3pmBy
         bvqO/gbmvSSGP/IGnvMZZ6J1Ow0EE85V6Sb91yAG6dd3kWDszEfv30TvRIPeNY+2LjHg
         Uinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761369369; x=1761974169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apaAoIq51aRtrkFWbmPU/2WaEbN9gRF7gSr6IfYPHi8=;
        b=CRGeEMxlFCzNGkjfjZc9JximGicvqxPC++uJQBLQxse5G9d+pVC+wT3iMjgZuxLO62
         wXsMzgliEKqEGmjRbL71XRJuifIPmfbfZnvCwIDqv8kPzpYofRSw8cB7K+w2l8g6vGG0
         +HjpSRXWQ7knU5maGy0wvz2yQZijOCaEGO6DO+KswiT+TX+JVTz8sXORGGuAdR0KHjgn
         7mSraX3EfI6MZE4Dhgg7ZlgTLYpYupUUe9UUsQZtdIxl/6GbDqkxEExC4Z07SWs884ds
         BIPgb+Uu12ZLyeye33wPfUnwxpZmhbHyuDdzGpzIFX6HThzmgMKx4+TeoGPtly5FBHgZ
         6sYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYSmFCgT2ZYwL+XqRHCgKwE6qjqNtBxh0xX23aXEeA+28+ckRGHIl4usavZexQ/NMB1JBvjUvwF/QsS8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8uHJaNG37rDGYMFalLsqlB+LB8mduG3O/ZOzDHRGiiP8U650W
	RMmmId45VQ1k3eapqQm8OdUkZm6zx0yxXQuLu2C9dCqr44RwdhTkNdio
X-Gm-Gg: ASbGncuwMG5xIsNaYUc5yEkcU+ObwTXaW77TSkppF/aEKt9PMPIiEkFCR4ssvD/SSHU
	UhrysY24EWUqjjvTSogqoUO6q0qJNG6r9jzI4eHu2XGtkevnf6KDB1h+E3p9i1CVmh/LyBgL9P1
	+T+KiCGZeTQWcUM0ibgh4x1nfsD+7VabV8csZ4GqxDNbZkAJfB0/Jh3YdsEeFr/PbFARxYXshRU
	ag56eigKlC6ZzDmTTRoObqEl0WkmWFDdfvI3Br+puTA0slkJfpLph22GrZ9oB+snn3TWzs52Nkg
	uHLqpZjsjTxd98e9cwse6MO1GLvV3QsdVk1X+fIcQZLioDYAkdKP1TyxuMhurpJjgZfLUE2q1HC
	JXZoR3FlNIX4rQxLI2wjjqQNvnAFreud83EtDd1dyyXlOIO1q6YoDnlrm/i3o9uVfeo+pxuWa7B
	EX
X-Google-Smtp-Source: AGHT+IHfK/YxWnxAyIXIhhMhxrwpBPWIhtUQlBAlwL0IaxEpVGMgxfc2H8XED61ydnCh6Xfhe0uFJA==
X-Received: by 2002:a05:6402:2111:b0:639:fb11:9935 with SMTP id 4fb4d7f45d1cf-63e60084063mr4098867a12.4.1761369368832;
        Fri, 24 Oct 2025 22:16:08 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7efb9fa6sm826566a12.31.2025.10.24.22.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 22:16:08 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	andriy.shevchenko@linux.intel.com,
	chetan.kumar@mediatek.com,
	chris.feng@mediatek.com,
	hua.yang@mediatek.com,
	len.brown@intel.com,
	liang.lu@mediatek.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	regressions@lists.linux.dev,
	stable@kernel.org,
	ting.wang@mediatek.com
Subject: Re: [REGRESSION][BISECTED] "Wakeup event detected during hibernation" on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup events during hibernation")
Date: Sat, 25 Oct 2025 08:15:55 +0300
Message-ID: <20251025051555.422427-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021125446.4384-1-safinaskar@gmail.com>
References: <20251021125446.4384-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin <safinaskar@gmail.com>:
> This is "dmesg --level=debug+" on v6.18-rc2-with-1796f808e4bb-reverted:
> 
> https://zerobin.net/?0459f6411446622d#8i0Ifo6o68By3+UlYUr2t2KL7YLXsKEXrkfszpE77Rw=

This log contains WARNING. It is caused by unrelated bug, which is reproducible
both on real hardware and in Qemu. I reported it here:
https://lore.kernel.org/regressions/20251025050812.421905-1-safinaskar@gmail.com/

-- 
Askar Safin

