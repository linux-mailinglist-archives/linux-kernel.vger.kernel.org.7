Return-Path: <linux-kernel+bounces-842308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4ABB9791
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22F644E4110
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC2B28852E;
	Sun,  5 Oct 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="NkDSbIBL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C02877E7
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759671185; cv=none; b=tsm3FdjYEosCbOhT5QXM6VmqjQrqXmjeOJHuhfW8vqar++aPwejzVb0/Bj/HvIQzMmIotu0c3AR1NUnbklFVxvLS5++eEXgNHy3KMQOcMfn7Ws9+DtF1Bxk/Py9k1QyVIPtu/gVF/iOh/qbnIk0r2mqsjuYm8SKTronCqyb7UDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759671185; c=relaxed/simple;
	bh=cyiVJg25k0NX9LYEhmvn4MG3tINMYaQdcfMOvJz+5Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3csM97I+f1evm8ImCtvlp4NTfBF7JCXxa5p8Dv5bV0WxYL2hnkqvNHFxf4CLtrAw7GNI2Q274VzzypkV3MrU8xfU76NOviqt1AJIzxvpZTyJgDw45pEfcmwRxBJtUfjPD0rk2LvA8mptk0VNJvXIBKmp+YeunQTK8BtW3OOjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=NkDSbIBL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee12807d97so3225767f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759671182; x=1760275982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DM1GAlirByGXSQF70Ag8YLw+oeiWY9AvHShiftQ9JDA=;
        b=NkDSbIBLYidb57T4DijAiMheV2F+mz/kbrv1v8a3Uj1zrkWlBEe/zuOniFhO+p6KmN
         jUjPZBBtVPTDbk3FPQv/wMfe9vFRAjPDWqfooV40i5Bi7zi1ElgtmrO4P4s7Da6Lpw9m
         NELfiyf8V7cG+YujMUXoXK73kepQeS+lk7aFQAWUYHuhqm6AhAaSTDCdzlKGBmCVGRZL
         Tib9hiU8Zc/dJFMMuSQ2aFJvCbq2XTT0qEjWRMuo2BHAMj6Lx96Qyl+ejmRBRGZGnG1d
         qfJRGKRQeetczoGk8SqapfBg5hm2PJsKzn+Fjw8hi3TQAqOeGsm4qg7uGKrCjupR2AE+
         lXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759671182; x=1760275982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DM1GAlirByGXSQF70Ag8YLw+oeiWY9AvHShiftQ9JDA=;
        b=d47E1OSrzDHx2dy+i9nEnefh+BKyiC5c+JQCoiKz62djQCQToogVpfDA0CzXz262w3
         GxwJ025SnTdUz6BeS1Qv6pvg2sGGyKThDok8lmm18onTJlLibhZS6PaDMp6H1PR5VKnO
         AhOkN+w55BKn8kPTbKr5qvriBYM0YLbCfipaxYNoHMQx7k0qBC7HXaZPKIy8b3duzG7c
         L+tImWd8ViUZa6CCL8/pmF5Kk/7EwtZ8zaXOce8lcTqhQY6kcsMvAFUmu9/yUiwaLb1l
         OsHkUXZsF/20j/MwGcJQl8JHwPKzYuhqODm/5LSr1ZkDoZIJ65HEasA3QscIznTnvh9I
         MNWg==
X-Forwarded-Encrypted: i=1; AJvYcCWgrJNd4LpUkevHv8KaqiVI4c+TX46H4LAeBB1GTrBn7hCSesYxRYHfAe6Rto2eTyAbcPYo8uyw+O9RthQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jctsNhUz2e2EnPjGofKqlsRj0D3JcMzkVtKPIRk6Fkvn8y8l
	+qng03ZR8LSMOaSwxICRjX2bZMaOu4IpvFDUydvWiYNI3sHVv3+lmvIyoDMMQTL/MmfQxXTDnKo
	WQkZtwD9SnA==
X-Gm-Gg: ASbGncuPM5O0KTBGUHq6EIqZJoJue5x7QPTKLJZEHfpv/wMgm0Rk39ZoO/n/sWSN6Tg
	LFv1EsrPRQ2ci796RhypWgx2z3IOHMbAJ+fqTlF8frV0bxwyEIL0HyzM9XmjdvDd6A4PC/6jaNA
	ILkh/WQQ4GodvzMKofQz22E8nnKtHkjm8v7O4LUClOfb6LqkvXPp9PNBcE82OqAGuiHQ5WmyuLm
	eN0fqNCF31yWqgctjnz2QXDn8HeO15fcuK+jW0262vKTmxCENfVHkD8mdnIOtffErx+LSboF6bT
	ydY1itDJ6R1qjlCfv9z45J9M6I8tSMPW7sjW8AZmWl9nJAtI29RkcYlwPusM+3AD5kzuXf4kITw
	67vO+IgO4kPNlXnFAazZky2ngqFhtENUfrJmQ+wJiX9fOxmCqtuTgWnD/kGuTlgec
X-Google-Smtp-Source: AGHT+IHCiJZkw14XZXnMA6yB5yBnUdpiT4anaRQQoQvPUVPZHpciGWzVWIcLIG5jgBP/EmLvZqWpKA==
X-Received: by 2002:a05:6000:481e:b0:425:7c3c:82cf with SMTP id ffacd0b85a97d-4257c3c8349mr414378f8f.11.1759671181696;
        Sun, 05 Oct 2025 06:33:01 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:33bb:4d0:68e8:89b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4cc3sm16459730f8f.55.2025.10.05.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 06:33:01 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com,
	hverkuil@xs4all.nl,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
Subject: [PATCH v5 0/2] Pinefeat cef168 lens control board driver
Date: Sun,  5 Oct 2025 14:32:26 +0100
Message-Id: <20251005133228.62704-1-asmirnou@pinefeat.co.uk>
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

Changes in v5:
 - rebased onto the latest master branch;

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

Link to v4: https://lore.kernel.org/all/20250830111500.53169-1-asmirnou@pinefeat.co.uk/
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


base-commit: 6093a688a07da07808f0122f9aa2a3eed250d853
-- 
2.34.1


