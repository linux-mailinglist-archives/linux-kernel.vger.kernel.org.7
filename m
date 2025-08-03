Return-Path: <linux-kernel+bounces-754483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A9B194D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E21A1718D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8D1E9B3F;
	Sun,  3 Aug 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iVrpSb8N"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5842914A4DB
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754247936; cv=none; b=UrW1sWn7Mn0rxifbsKUSqFmSKod406Bt1PzC5poPSCGP0mQc4MGOjKjGqy+SkvLxOe+0/naComM5M24hryE5m7hvPLzLKa40qmB2RKFMzWdamrIUOg8rb+jujblhds5yq1xqC0byGfijoDV1r1DOMlJoaBkxIjM6NSJvs/Tn5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754247936; c=relaxed/simple;
	bh=BwBmtnv/BpaSXrA8JVdt3hc6pH4difSzYPixxu8akJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThKEZQ3Qc/iB7XMqjzotuaBYjYF5d2dcLEz3MdbxFzmOhk/DoEC8r3NxgCgNjlphFscJHaS3neZl/nIpK3wW+gWwhoTi/5YXEVvEOFWUh7XMs9fnDwjA85qWo8YdIOKR1xG0S/TPKwYdXSvnomcII4DmJRDy3Uw58iYzhbYepoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iVrpSb8N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45994a72356so5997695e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754247932; x=1754852732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up9M/4hUY4Zre3/HEDOm7wwnikDuaJtzpmpnD4b0pVk=;
        b=iVrpSb8N8MvN6nWxkBBV1RyLLt/msq6AZbGDDPSm37ZtoB5X1Bj1S+IrFJY/5BjQ0A
         xXsIYPB9dWjJdoYXeam88pybWUWBM2yz+zCZak/Fk7QJ/S6voaML2hky/y6ROPYcDWNV
         XNTzLnSlJwXbpVXUGXdH/3pzLtUJ63B0Q7uljQ81vqwoZSqKHgB0cFDD4AcfDD2DkUG8
         wLykUpqvlH7Hyzx7P67dC51qpWeBBok4N5Dsgtn2qVG1sBTttn4sSjl+YdOn0x+D8vge
         BbEvf29AkYXFqIhZO7taAJITyAhJNXcD6Q4JNizTELfjztDB4I57o8r13ito31pCRX/t
         UX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754247932; x=1754852732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up9M/4hUY4Zre3/HEDOm7wwnikDuaJtzpmpnD4b0pVk=;
        b=PQh7hMwE4RD/MVgkNpEiwfKpcROzBcAoGj60JCG7ituIlrPzwInla3QtA6xEdB1pvJ
         o5WTULnFSvNpiBv+nhBF+rBlKMinjw45Xt0gF042aFLQmmNPgacE+p4gbsV/2w1nmSsE
         qmapLiYAL+CVnRb8OxuDRS//hKE1p37tkZDbTdBrupnveVsRE0uJIP9tsRLJnLOF+rTS
         5YtHKO2GRdSmVZUjlr5lFo51XJCUEKqQjSidk6EVwLIHdBWW6746Z+hTU3o74PpYdYU8
         MXDQS1pdvW/7jN8E9OHXulzhmP7SZiW1K0SyhwJVUQMTdGsV39UTn5b/1woOBwXkTjTj
         bezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNgxHf1oS0hnG8aMUe9+QI8udaDHQehZktP2dNftDkAWKybYbj72SOZ+dmMGv8rh5ZQea76oxanvSjJWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOIGIy3AbKEe3hhPtvwNoFlufcNUdZcU+elUERUmXwhnVL9A6
	n7zpb4FrTcI1cjkDMNnfV69MTxoV54e9DAo4WJVefagUckktJVB4BEH4GgaItpso1bg=
X-Gm-Gg: ASbGncsFqrJ8E4ojZHi02ORq0i86MbxBPjlIvNs+kkspr5oau+BvylYxFnMbMiRlwX6
	OXPJh0K6wmXQvCfQMoH1o2Z6lpI7B3QXig3Bk2v48Hl2z6RHomNK/iCIKJLcuId1eP70ikewzcJ
	6v55leAVnZwBedsANQoA4XpCywoBsP+U7W/W92ADjEMpgTeLlcfJZZSmD7bcwHnMBT4V6McdxZA
	RGnEPekBL27waGWUIS4gvECGejJlPNvwv7LflhCfvfdDvEtcp49NnWZTQiby1k7J141zYVpu2eL
	hrSQS/XXL5u1V+pty0iphipPm1dy8qoLLIUhtv/i2rgEKdhseIJqB2XaBvMMG4yYSJDs6TiYfCH
	mhZZuRjXGGZGfJIfzS2i69T6I03o4uKJCxb0z81x0s0jIcPDMC/ncHHN0H34Ym+h+kOsY5Cb6Wf
	irvWZYWA==
X-Google-Smtp-Source: AGHT+IEZ0V8vkr0azlFyjnANX82PwFUs8FOonbF7UBmw34xohUJLsmAV3egOIPJEYGsTVHJlXcZaDg==
X-Received: by 2002:a05:600c:1f88:b0:456:189e:223a with SMTP id 5b1f17b1804b1-458b5f0ac7amr52599785e9.10.1754247931531;
        Sun, 03 Aug 2025 12:05:31 -0700 (PDT)
Received: from brgl-pocket.. (2a02-8440-f501-a968-a175-e139-72e5-a366.rev.sfr.net. [2a02:8440:f501:a968:a175:e139:72e5:a366])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm12948486f8f.47.2025.08.03.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 12:05:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	davem@davemloft.net,
	asmaa@nvidia.com,
	David Thompson <davthompson@nvidia.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shravan Kumar Ramani <shravankr@nvidia.com>
Subject: Re: [PATCH v4] gpio-mlxbf2: use platform_get_irq_optional()
Date: Sun,  3 Aug 2025 21:05:24 +0200
Message-ID: <175424788066.7115.11334819523801488773.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728144619.29894-1-davthompson@nvidia.com>
References: <20250728144619.29894-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 28 Jul 2025 10:46:19 -0400, David Thompson wrote:
> The gpio-mlxbf2 driver interfaces with four GPIO controllers,
> device instances 0-3. There are two IRQ resources shared between
> the four controllers, and they are found in the ACPI table for
> instances 0 and 3. The driver should not use platform_get_irq(),
> otherwise this error is logged when probing instances 1 and 2:
>   mlxbf2_gpio MLNXBF22:01: error -ENXIO: IRQ index 0 not found
> 
> [...]

Subject should have been: "gpio: mlxbf2: ..."

Applied, thanks!

[1/1] gpio-mlxbf2: use platform_get_irq_optional()
      https://git.kernel.org/brgl/linux/c/63c7bc53a35e785accdc2ceab8f72d94501931ab

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

