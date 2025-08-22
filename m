Return-Path: <linux-kernel+bounces-782497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3069B32146
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DE11D62B48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E6A3218C3;
	Fri, 22 Aug 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="ZzvyV4Hu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A83128AC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882657; cv=none; b=sNKWHoCP7VFVk28hKSPtkCaSCXRZt9Lk3s3k2aMX95p2uSmOa17MvPYY9iLsYHKbcMvCfWdSW3YSUiGnXRNNt8TJWF+DI/i/MKQ3EyuTzR2L01n6HMPmN46zyXDBkriC6ai2tM7v0WUXQ+ffvXtZfS3YSjRHFmSQ3Q5sttO5uIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882657; c=relaxed/simple;
	bh=FcS3lVango2lJ/7H1mnUAZSXYOc30orPYr2Ga4jvAh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dYjmkJ/W8Bmg5yZqFDH1wXM+vrHcMgp4yhuIwC17V84YPCIK0CshTSZRANlpJ5t587gZzIKViz69o3j/QHmxaV1BYkl1wE8SKH4x9kHQtD8X4fb6PxsM/NYip4q6yGEXZjeO5yig57zq0gl+Y4/ZLpHpFdz3sCIfe9W5MgPYqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=ZzvyV4Hu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c64123398cso345013f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755882653; x=1756487453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sB8nLNw7OUCAbqYw05qQ79tpzJtdnEdFbZCz5X3kyU=;
        b=ZzvyV4HuIkohWNFmLz+2MEKqft42wy0aluU+WbeWgNiaS2zLzCMXEgmaSaeS80pTvg
         s2WqTncN5Bh2NQt+VM91/i+qfEqXDRY7kBPQfRRzHrFVF2DLQzboc5Ccox8e21Gf1Q3O
         x3WPdLH2HXLtZG7eTCA4INGMhzHbgIV/R7ZFok7cy9DiYkfRAgPftSP1mb0OSxsLfSEw
         FhxtDbZBslvN1blk0vpgbTDrcBe6rLkvWhTvhHLEbo6P1WLKnSbDRAT5rNdKTMtGpsGJ
         LdOyrkmkklaFdnHUwSkMYY3SfonvFX/tdA4+4RMvNwodyXqJXVx3MMVPtH7hKFWLefFU
         L6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882653; x=1756487453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sB8nLNw7OUCAbqYw05qQ79tpzJtdnEdFbZCz5X3kyU=;
        b=Srmg+vGs3M0b1QdZl5qgRcOkzAOFjIJzpb8FGcnze2lGbZk5HKNe5Vh7m3uqDNkZil
         H+SIAEM24/by2dbH5dyusOxkoePH7HlJ7Ocaj8XrnvXCNYgewNmSEDQppEU/mxPJYVES
         H1f7G1wUceP0mOtF/Dm3YwPIiLTcZEzbyAev5tOLYWDFfok4vipE/wKWZXuxlYyfoFQo
         KAwg0DX6O3zaJm+lkYGMFQccDHEjSJYswped5fy8ZuQ61LLUfjUKLWfNjd3IDBeleiRS
         dlak1YsV1DbJbBTUSwcIP/qdC3eRSfXqsem5WPzIBl3j9QitvQ8DQEHs6ZH0yxGZ3Nqj
         olsw==
X-Forwarded-Encrypted: i=1; AJvYcCUwDx/FHS317ts/JyO3h8p4Yp0lwFwl2XTivPFV7vRijrGe0bONjrGuQjcQsc31PjmTNVg96GoyoG7BsxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjmIALgTrV0opAiOy6HtfmChjZH1StH7QCrokSygFbRwvt/rw
	tV6vUcsd9OOcKgihTD0+ODVN/niOLYh1G/dCZ29Y9QrjOi4oYS3y2xn5k3syeWuwuCI=
X-Gm-Gg: ASbGncs8JA6WlIdmj+3u1AQ4KrU4r2oUZiozC0yl+lOV71QASacCGcj5gTmsuXeqI9f
	k4hsxKxly1lnCVMjzVNW+ajEu8jUN8Kgvd9OcdMe5corxbRMGxPq1IcnH8LNPNex/OPUIKhVojA
	2I6dqchIRnNef9ZrfUS9AQkDJ2JGv/klOGgdy2XyoKUJ8RR9l23l6QU2zmvA85rQDEFLv5m4pQW
	FroXtOD5DYZsCVUjNkokoL0KgWN5Bfu0BL/GYLn+LaLqoVFGJuG7roiEbczUAhdJiVCpBMuyIr1
	CFDQperZ+a3hardrjjFfCyQwq9p1GlWS5BqQDDdBMC739QqxntRTb0Dq7kZX6YDet2Uo0HH7v+Q
	Nkzmf7TK6+oeZ5QTRZOMBvRmfcbwGpk7qyPrFgrN7
X-Google-Smtp-Source: AGHT+IGmQCo02uaOxqBVlYeS/KQ/EsgJf8zCN4ilwcnU/gzOWtAftv/rtJe77Qa04lzmMg3zuwnBJQ==
X-Received: by 2002:a05:6000:2081:b0:3b9:148b:e78 with SMTP id ffacd0b85a97d-3c5dcdfc385mr3193656f8f.53.1755882652889;
        Fri, 22 Aug 2025 10:10:52 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:c77a:e59e:20e0:4966])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70f237fefsm233780f8f.30.2025.08.22.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:10:52 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com,
	hverkuil@xs4all.nl,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <support@pinefeat.co.uk>
Subject: [PATCH v4 0/2] Pinefeat cef168 lens control board driver
Date: Fri, 22 Aug 2025 18:10:39 +0100
Message-Id: <20250822171041.7340-1-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Pinefeat adapter, which interfaces
Canon EF and EF-S lenses to non-Canon camera bodies. The cef168 circuit
control board provides an I2C interface for electronic focus and aperture
control. The driver integrates with the V4L2 sub-device API.

For more information about the product, see:
https://github.com/pinefeat/cef168

Changes in v4:
 - removed driver mention from the hardware documentation;
 - added named email in commit signed-off-by;
 - added select CRC8 in Kconfig;
 - removed header file;
 - moved variable declaration at the beginning of the function;
 - removed kerneldoc from structures;
 - removed control id check as the core handles this for us;
 - removed Power Management Runtime (pm_runtime_*) calls as redundant;
 - reserved v4l2 controls in linux header file;

Link to v3: https://lore.kernel.org/all/20250817130549.7766-1-support@pinefeat.co.uk/

Patches:
  dt-bindings: Pinefeat cef168 lens control board
  media: i2c: Pinefeat cef168 lens control board driver

 .../bindings/media/i2c/pinefeat,cef168.yaml   |  47 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/media/i2c/Kconfig                     |   9 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/cef168.c                    | 331 ++++++++++++++++++
 include/uapi/linux/v4l2-controls.h            |   6 +
 7 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
 create mode 100644 drivers/media/i2c/cef168.c


base-commit: 2b38afce25c4e1b8f943ff4f0a2b51d6c40f2ed2
-- 
2.34.1


