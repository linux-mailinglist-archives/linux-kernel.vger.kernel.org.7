Return-Path: <linux-kernel+bounces-777660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37671B2DC60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08AC1C41256
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235892F1FDD;
	Wed, 20 Aug 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="SQkN8BFF"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A662E2DF1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692731; cv=none; b=BUk9n14pbB6koxf1RrOpEn5qHe2QvLp2BNw1w+VYcYenSswSCudTsjXD9wnx9/YquDrsMKGC787KsvcrJe2D9iS1yNGP4lwnXGeSIqoCv/fRZz5VtxZ1KOP2abNxoIwG8c/2+GMOsa4Cy++pTr+19fhC4fsveKmBVmBeVeo9mxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692731; c=relaxed/simple;
	bh=xUgpi/yU5v2YDFQpPE4JwiRi2DdyTbCUF82XELIQqVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ntr4keiKDIZvnMWOuW4ovYvtJeZPrO63OAq0hLUgkl5PnGnwAtCI+bkaiLtU8ST0MPnVo49C+KyuOebHdzK/ervg5msR6VaDGr7uLc2tqQXe1NRCfNJ7dUWNalGaz1SKu44qEHk2NCSVF7EHkobnh23cZC+nPJ3F3V37YdW/c4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=SQkN8BFF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b476cfc2660so316299a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1755692729; x=1756297529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx11J/6XEjmmJ7LOB55tZi1n3uqABTD9Wv6DRY/RJN4=;
        b=SQkN8BFFwJfC0QDIPBqhvebOsJJ+Pf1m+8XC1AJXqzVOZKkZWJxvVkghRE0asWsmi6
         1eWLOxC0RR14o7O/BjOqYAvht8smDLO5aRWiEpITza8bMaVRoFtO7CBh+EtKbtOIQuAw
         2Zs79ttXEsIyLG5BYuf4DRYK7FC7ovxRKU52g+FZFCHRpc8IDACgm6L6HgC6xT9bRehU
         W7G8JjZldQFJ7XN450BZ2BE3T9kcUDn19U0xQXbIUWTh50/6m7XuBH1VYjoB6A0PVR3m
         +OJxJz/kdbIW4CPXZFpcEbbE192nA82ExojesVKoV2kk3yP1JuMUDQMooabpE7N8byER
         CLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692729; x=1756297529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hx11J/6XEjmmJ7LOB55tZi1n3uqABTD9Wv6DRY/RJN4=;
        b=pVCXzv2lo/0w1mC6Q6+PfPbQjvNx9+8a2ze51F2x57biWBqKW+IoHer8aXnvpIExEf
         n26LxiqOUc4sKpONqqDfiKf5ClvH4eHx5UzRkh2y6chL+I+jZ/60nn7qnogGqc2pKoKy
         3EG/fYoCPyRqBMwv0tQtF7lQFIzJke2xJngCKMiUsVYv/48OO4OSL05TmBDUuu6SVlFp
         JZ2viaHO84FoKzN5xpeMMKO4/QkM2rkueOoxkJluOeejaexOk2rPw9bS976Oh40EHvfB
         DNzSmWzTNeAUntZrieWUXtDfLjqakzEJn7jNsQsfyT4L2BCYvK4GW5XhTvb/mlOVUaY3
         ag/w==
X-Forwarded-Encrypted: i=1; AJvYcCXHtLiz+Unm0xG2BON6zIcrPrjrxJxNmvs1wS97n/LhxF2jgjfoHvllVR6Aa2BnOioj7euJISvA8YuS4d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszBZuuzoQUB9C2JcUQzXlL3wgnVoopqBdwCRKODIQbpo+4Y/2
	o+FkEq9TKdmW/0NJdWOw6CKLoqKV7ehVSna125J+Zjp3bcy4yJjwsjLxyyNFyHZOPXA=
X-Gm-Gg: ASbGnctbOvGQJmTsJgESEy8BojP7dl4N2FvoI7xMvegMeAfypOgm3ufykd1TRlKvA8d
	d380uPVbb8zMDnyPvtrIQWpRUvfQjD+Nhf6Skg4x7JgxVxmGwHXKe+1Qo6eAxBgNulLFZ3aQPvU
	9jV/jU6SfT915AkZr80lIfFA588pqwxX58dF9dTbbWRVEg30tFOQBCN0+px52KzkKXsosUnQm+N
	ZZdYNuyEQccT7DR5VZUyjIQY9RDtnsHJZFXkWESYeEYm4CUNZs+UzW9Vk0Qnxr+Y0fPVryMSaPt
	lnCjmWwQmGsNYkWSkyWShWQYaBoyl7av2MeVCNZxj1Kl+FfmVO0LW6s+cDxlMgq/QCPZIVMNJiO
	u+uOLJyBScW8yGYNHd3iPgW3EiebjvqYaFIo00E8oKNMjJ8gkTNSv0nqQBldxNlfx432bsw==
X-Google-Smtp-Source: AGHT+IFS0/CNO8sJaiTLh+MwmPnTL5fkEo454inx3uj8dauJbbVA8ZR4IH2KqSHuflT3Voa/ZdsIbA==
X-Received: by 2002:a17:902:fc8e:b0:240:14f9:cf13 with SMTP id d9443c01a7336-245ef278ba4mr32765695ad.51.1755692729040;
        Wed, 20 Aug 2025 05:25:29 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c745dsm25450135ad.73.2025.08.20.05.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:25:28 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dianders@chromium.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/2] Add tc3408 bindings and timing
Date: Wed, 20 Aug 2025 20:25:18 +0800
Message-Id: <20250820122520.3356738-1-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tc3408 touch screen chip same as Elan eKTH6915 controller
has a reset gpio. The difference is that they have different
post_power_delay_ms.

According to the Parade TC3408 datasheet, the reset pin requires a
pull-down duration longer than 10 ms, therefore post_power_delay_ms
is set to 10. In addition, the chipset requires an initialization
time greater than 300 ms after reset, so post_gpio_reset_on_delay_ms
is configured as 300.

Changes in v2:
- PATCH 1/2: Drop redundant "bindings for" from subject
- PATCH 1/2: Improve description (describe hardware instead of bindings)
- PATCH 1/2: Drop "panel: true" property
- PATCH 1/2: Drop redundant description for reset-gpios
- PATCH 1/2: Use unevaluatedProperties: false instead of additionalProperties
- Link to v1: https://lore.kernel.org/all/20250819034852.1230264-1-yelangyan@huaqin.corp-partner.google.com/

Langyan Ye (2):
  dt-bindings: input: Add Parade TC3408 touchscreen controller
  HID: i2c-hid: elan: Add parade-tc3408 timing

 .../bindings/input/parade,tc3408.yaml         | 68 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         |  8 +++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml

-- 
2.34.1


