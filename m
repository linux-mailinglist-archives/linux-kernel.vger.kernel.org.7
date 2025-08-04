Return-Path: <linux-kernel+bounces-755387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC2B1A5CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0581889CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180B218AB0;
	Mon,  4 Aug 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydjVxAO7"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422FF1482E8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321035; cv=none; b=FqRFRxvpl6sVmnDmePhaz620w0Ce5fpf1oMoKOodmOjdXK8zxr1GggpVGiDi/hKasq66FDX4N4/hv8SIG980ypXmFnpj7CmoKAJ8OA7hfQ3gZjfGgc+Sy7DcTPd01mQNz8NC9jXeqV8AinRbywNGverkZdYyZK7avdV6b+iKfLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321035; c=relaxed/simple;
	bh=hCeHk3aE6ootFLVJoGzxwwBLJxtlIdiyu3o971XPdVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odifXwjolwOIVguC8heT8NeZJZibacMWPjMT0Plcm7Kmc7NI3Yk5cO+5o2DIij/CBsF1+4xw/W0LMm3MXxMjqTWathzsAKMRfCuSyCT0f+QvD6GHeHjbtbAoTnpddVk2Vp6widR29BqHfx8RniXWdxYG9GhFZarRefzp/p3pWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydjVxAO7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso3098932f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321031; x=1754925831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLy4vActlsUsvb3hzmhRMLenAGPaPRA1jS0A7qzzewk=;
        b=ydjVxAO7bNjyepPhTv9yykAIa5fZ2BQP3Z3SPWcf+qd2WTkqcNL4/GeEZoXywA6mSV
         mipXAELtCXr9P+xVD8MEjc1LwXRTenO3GU88DqNZLT5vlyN1z2NQUdq/GjOAc6gQ6vIN
         tt4MN3LRF+zPlFJd+JW7T+HnvTDLjjxGkC1mvFaUMFbjXwaafQzJFIRQ5UF6DzFllD5D
         gQFU2YNPR8r7o8A5Ny2JTSR1xOwfTSUwx4vPFS/bdAGgygMsZK0P+NrHyM2AlHPzr4C4
         6CNX3O/Niqgo9YGexXzCdCviregHhzC3qtdKZrRDOlpkZPoXi9teBq9sLyNCxwhBiE95
         mrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321031; x=1754925831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLy4vActlsUsvb3hzmhRMLenAGPaPRA1jS0A7qzzewk=;
        b=cvFoFCN9n++k87Oy76l4rv7mcDeybGd9IdstlVgaodUyu4HB3ShNoEiRbtCKKtV7Ed
         DAgku5txLwVx80qwW2MZeg10FJ/3AM9ZjUBahsEIB7aKOU47TB9solNKaZ7o0z0dhaPP
         JIcLkCLh+wHp9LREKMZlLWepJbgUHrMHfNDhkAGkx9qtd1J7LFKN1KS9Qo9sE3deR02U
         oI/ZADSGUBnQPOtFCIeJwJixaudUKXyX+H0IfsC7ZZY1n+ymUrvrXCItiftbcjVXijJY
         4OglofTKaAIDxXHZ8N+novTifokekgKN8tW97oupEj1ViTZUSUl2a0ozSn1e6muTaoUC
         kmzA==
X-Forwarded-Encrypted: i=1; AJvYcCVZmBKCeyOaASPeNFqu5def6FPrjiSybWIunMZh9uQZGNExcA8VBZ3kiSbQ+aAgpr34bTNIR8/Go1qthTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfcKiZoV5NvIdj69co9P+MUou0/ZGcWWl8YspjIJlNtDLTIdi
	rYNS17L7A0MZz9F0Fe7u+jvNI2L9a11wySiB9lnhnBLElq/rPvM5ZpDixkAhgvhhgyHjHTrx3We
	hfyHv
X-Gm-Gg: ASbGncsvKCE38hADZDErOdfjZBGHpkkjHN0yqtmIm8QJKuP3ZzdSp53GEsKKgeWmGca
	f3+zDVqPgBtnSnwT4QHuiwAuq766mDGdMCuAIYXJ43iInhi0KlLyeITRKXRz6QKxfflxRq/yBSE
	z7a6JgQYoD/7xTX15Hnf3auwNnH6Wk1VUKwbMkHu2120nw4VUfpFwVY366+2cL1dpnWLUx1GPIh
	HMkJuixGlhOoamiC1CWKkSrgIhWHILaPLV2/X0vsicrlRpnb8fOsjy3IhE261EYf6llirqX6asf
	pn5GGo0Hi8gKaZXF3sDbuWpHSi1IP/s0wxFIZGrJVlGI/qqEZT+0aLxjAT80opfMSvzf/56XLYQ
	PMoYKksGIqeVZsbX1JcnhQLm9tZTq9EpjGr/tOaD3WWKGDNK1
X-Google-Smtp-Source: AGHT+IG2FhxJu/kj4a38RvBsflxlhQ8vhYxh4TPtwAoSbUcEq47jE8BaJMqZDZK/2l0DpQLW+KT6xA==
X-Received: by 2002:a5d:5f89:0:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b8d95ab0c8mr7812331f8f.29.1754321031412;
        Mon, 04 Aug 2025 08:23:51 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:50 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 00/20] Add support for the NXP automotive S32G PIT
Date: Mon,  4 Aug 2025 17:23:18 +0200
Message-ID: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G platform has a couple of Programable Interrupt Timer
(PIT). This timer is the same IP as the one found on the Vybrid Family
platform. The main difference is there are multiple instances of this
timer on the S32G.

Before bringing the support for the S32G in the driver, a
pre-requesite must be accomplished to support multiple instances of
the timer in the driver. While at it, take also the opportunity to
clean up the code and make it consistent with the NXP STM timer which
looks similar to the PIT.

The two changes fix the raw_(readl|writel) usage where it is replaced
by readl|writel. In order to compile test the changes, the Kconfig
COMPILE_TEST option is added.

The other changes encapsulate more the codes into self-explanatory
functions, allow to pass the per instance information as parameters to
functions and use different names for the timers in order to be able
to distinguish them.

The last two changes provide the DT bindings and the S32G specific
changes to support multiple instances.

Changelog:
  - v3:
    - Fixed checkpatch warnings (two false positives for 18/20) (Ghennadi Procopciuc)
    - Call irq_dispose_mapping on failure (Ghennadi Procopciuc)
    - Free irq when the init fails (Ghennadi Procopciuc)
  - v2:
    - Added a cover letter (Ghennadi Procopciuc)
    - Fixed typo in descriptions (Ghennadi Procopciuc)
    - Clarified comment about channel usage (Ghennadi Procopciuc)
    - Added a description for the bindings (Rob Herring)
    - Initialized sched_clock global variable (Ghennadi Procopciuc)
    - Changed type for the 'cpu' parameter s/int/unsigned int/ (Ghennadi Procopciuc)
    - Fixed wrong bitwise negation when reading the counter (Ghennadi Procopciuc)
    - Changed type s/int/u32/ for writel (Ghennadi Procopciuc)
    - Clarified changelog with S32G support (Ghennadi Procopciuc)

  - v1: Initial post

Daniel Lezcano (20):
  clocksource/drivers/vf-pit: Replace raw_readl/writel to reald/writel
  clocksource/drivers/vf-pit: Add COMPILE_TEST option
  clocksource/drivers/vf-pit: Set the scene for multiple timers
  clocksource/drivers/vf-pit: Rework the base address usage
  clocksource/drivers/vf-pit: Pass the cpu number as parameter
  clocksource/drivers/vf-pit: Encapsulate the initialization of the
    cycles_per_jiffy
  clocksource/drivers/vf-pit: Allocate the struct timer at init time
  clocksource/drivers/vf-pit: Convert raw values to BIT macros
  clocksource/drivers/vf-pit: Register the clocksource from the driver
  clocksource/drivers/vf-pit: Encapsulate the macros
  clocksource/drivers/vf-pit: Encapsulate the PTLCVAL macro
  clocksource/drivers/vf-pit: Use the node name for the interrupt and
    timer names
  clocksource/drivers/vf-pit: Encapsulate clocksource enable / disable
  clocksource/drivers/vf-pit: Enable and disable module on error
  clocksource/drivers/vf-pit: Encapsulate set counter function
  clocksource/drivers/vf-pit: Consolidate calls to pit_*_disable/enable
  clocksource/drivers/vf-pit: Unify the function name for irq ack
  clocksource/drivers/vf-pit: Rename the VF PIT to NXP PIT
  dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3
  clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support

 .../bindings/timer/fsl,vf610-pit.yaml         |   9 +-
 drivers/clocksource/Kconfig                   |   9 +-
 drivers/clocksource/Makefile                  |   2 +-
 drivers/clocksource/timer-nxp-pit.c           | 382 ++++++++++++++++++
 drivers/clocksource/timer-vf-pit.c            | 194 ---------
 5 files changed, 396 insertions(+), 200 deletions(-)
 create mode 100644 drivers/clocksource/timer-nxp-pit.c
 delete mode 100644 drivers/clocksource/timer-vf-pit.c

-- 
2.43.0


