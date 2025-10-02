Return-Path: <linux-kernel+bounces-840117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2647BB393C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DFA1889389
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C73090E8;
	Thu,  2 Oct 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="v3hWiZ0d"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDF2F3C07
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400147; cv=none; b=rqThXDlE12poT6sqjjZQUgAxbheXxG1PwAFCOFnLtfx3nKUqvL7/CPLCQdegotTQhT2F3u/nixNPA8oFo34YRQ8Q/Mgn3hh6wxUlDuJDmLIHHwe5bJz6uFShqaVLQ4jpLXskolcn72vyqjWPScQ0iKDTxCFvrQXH4QitcgK89cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400147; c=relaxed/simple;
	bh=66oeXJMJEulwZj/KIhNOzY5gGBvviXDjo7ZUMMncbtw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uVafSFkfMwHVs+SpLXSC/dyrdZCjpg7kIpvuuQgznVMuJNfqEgIx14RohPkrdp6de32l/9HH7YxzRefd9/176jDM9V4V3vNsPdebpSmJ0CyUsvl0w5IWTICrt6HnXHBXmTAcWIxjsbETg1NQGNxZMN+NW70e8l3x3Jfkvae019s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=v3hWiZ0d; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so1786469a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759400144; x=1760004944; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPlLSMsE7jtu9vfSrQUVTA10X9VUfgXuBWRPCu4XK9E=;
        b=v3hWiZ0dBTe0BCjfiyl6e3HMtCzGyrb5Vvj+Db1NCgnrVriMMx9lkQc2MftgQCXFGp
         80kDQQFWg6f9IcKLmfxU6NPNSKSEE/n3XTGU6MQ6yXFohNxRoyAmpNizdOj+hqhTlRMz
         XHeQYvXKWoF8JCJHR4NRGgphDZ5V5+NMWivnLosGhA9HYCvVEHxsp++PvM+S563RASMD
         HooIJ4gMfGcbM4OeVbwJRF54by8bd5RmJqc0OdAm02Bm4PbU4iDMTzbvPw68GSV8Cp1S
         s226aIxaDRWmJCQ4nU5/tFrbYtkOX1uVGw7ygvVuTwmgj0vEPK0B0QkV6yRU7pWlcGC/
         WXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759400144; x=1760004944;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPlLSMsE7jtu9vfSrQUVTA10X9VUfgXuBWRPCu4XK9E=;
        b=rWu3LWt+37/O1D7qO1kNq8nvfsj3j+Tl1zLoqyvk7fZWcDxa1V1s4V+D+Db0AKTYX0
         3jLzQCvxZtG8QIfdwBq+AXpqA/STc7ph3p9RYu+aQXv7tkscsJ2hg4H4gxmyrj20Btsp
         iAPYOq6YwlvuoKTc7SY1jG7fxa4mkx3RmR/VtG5es3ZAqGKIC/KQoFt8zrYzoH1o6GzA
         03cCfmTjUBE/ehvvFlhlcP98kdUi4MHlj7UEl8GuOuLMZvHkdSWO1MCbMgRv3Xdf5qIR
         xHTQZV2STybbqztK/5iCAUYxEeAW4bgJS/gKsyVKkvy/4SwADxDDuA5uCjwZq/Zc33oF
         V1wg==
X-Forwarded-Encrypted: i=1; AJvYcCXYTbOCdDWfPtDq0r2Bwx3+88+mmpH0I1b1mrnW5tx9ZzgBA6UKBSZM8S9C0xIwXfa68cN8IEGYmYyRY0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/v0Ezi37RrrjtNoBOFxl1l/GMHQXYYDuKZu42T9QMDGl6CrQa
	3CO5ymU4GDbcKrO/NlmimDEuS2iEkbAmaxAyZrG8kNZRnG2i0Asqo4k9aQ7hzed1iFQ=
X-Gm-Gg: ASbGncvqQUqLmzrAzFhQh81+0f1wJsEYgcFuldkJpj5edRORkU/UpKk6yyh5LrZm6+x
	c/fFwgQb4iNLgcBpgGBN93gDUZJcCT/5baSTZVnRsCyR2oY3wea9Z8Eloufvj00Q8uFRk4Fo9e/
	TMRrEPEbawI1LEmDuhosRyd2aj2i1xiMe0d+Q4BgDFFb5FZ+Wz30jx4YAv9NvqaJuHYH+a8L0wG
	CyyS5LzDO5+9ISIBLiQHZYxbn5y1q9KEu5hoXggxQEPOSEb9tpuJKDv6PpknoTS6+u4X+wh1Fc3
	7TtMWokGUTiM6FE1DnUvE+7JAKZhCu7R+XB4jZXMtkTrTs7JfYAhpNwDhltNFi+Axz2BshYdW92
	AgrZdsw/H9OCTdlFLP82Uwshve+jNWySDxIEpcBDowlxAQMgc/WYocKpZSy4DHGbWaTz9izN2e+
	EIfeuSDuunqhGRqCnO29M8OI313A7I
X-Google-Smtp-Source: AGHT+IFeiokypzBNV3MdgOJgTGlXOrZ2BNMjOleFZQU75JeHB4nqA/43V4SqkrvtRZ97TXcmn9ISAQ==
X-Received: by 2002:a17:907:6d0b:b0:b3e:b226:5bb0 with SMTP id a640c23a62f3a-b46e8b85fe2mr871981166b.42.1759400144353;
        Thu, 02 Oct 2025 03:15:44 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm174862366b.36.2025.10.02.03.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:15:44 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Subject: [PATCH 0/4] Add support for Dongwoon Anatech DW9800K driver
Date: Thu, 02 Oct 2025 12:15:32 +0200
Message-Id: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRQ3mgC/0XMQQ7CIBCF4auQWYthiFjgKqYLClNl0VahoknTu
 0vbhcv/Je9bIFOKlMGyBRKVmOM01sATA/9w4514DLVBCqmEQc3Dx2gheEixUOJKo1A+XIwiAfX
 zTNTH7+7d2qMTvd6VnY/xr1q2m40wm9mg4dppLSX1Hju0RW5e5zJxPw1DnC0r1zM20K7rDyRbh
 fS2AAAA
X-Change-ID: 20250918-dw9800-driver-58105cd495e0
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759400143; l=1571;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=66oeXJMJEulwZj/KIhNOzY5gGBvviXDjo7ZUMMncbtw=;
 b=EgraaFNjoNIULDbNYyc3vYi1LctddRH4XQidFUC15RQuotgGw4RXcCVy9oN7iNJdi5eU46qR6
 GVGLxDbMVrJCkyPw6xXs3XyI5Xt5vyMXnjLAI9egOCr8Sc097BPyxgL
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add devicetree bindings and driver support for the DW9800K VCM driver.

The driver code is added to the preexistent dw9719 driver, which has
similar functions and method order, but different register sets.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
Griffin Kroah-Hartman (4):
      dt-bindings: media: i2c: dw9719: Document DW9800K
      media: i2c: dw9719: Add DW9800K support
      arm64: dts: qcom: qcm6490-fairphone-fp5: Enable CCI pull-up
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam actuator

 .../devicetree/bindings/media/i2c/dongwoon,dw9719.yaml  |  1 +
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts      | 11 +++++++++++
 drivers/media/i2c/dw9719.c                              | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)
---
base-commit: 6063257da111c7639d020c5f15bfb37fb839d8b6
change-id: 20250918-dw9800-driver-58105cd495e0
prerequisite-change-id: 20250709-dw9719-8a8822efc1b1:v2
prerequisite-patch-id: 5a1b6083c0f5df1421cfe6952dac44d9ddb7fb07
prerequisite-patch-id: db5f49e91aaf521fa487994765b4107f543531d6
prerequisite-patch-id: 76bfa65d3ff23fc827790b0868bc34655cfa93fe
prerequisite-patch-id: b76d61c90bdbf20f437d2fe438d54e707621e953
prerequisite-patch-id: 46fc09662693e6a51bb89ab4d0914265c74bc3bb
prerequisite-patch-id: 4e0012f76dd03d5653ba185a8ccc59017a1b90d1
prerequisite-patch-id: a618641cd4b7cde40825fa0d4201b6c27e74266d
prerequisite-patch-id: 8b43ff7e81258cc7624800e4bf645458a0f05380

Best regards,
-- 
Griffin Kroah-Hartman <griffin.kroah@fairphone.com>


