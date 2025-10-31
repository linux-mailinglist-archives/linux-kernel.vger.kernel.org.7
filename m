Return-Path: <linux-kernel+bounces-879740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B056C23DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40E2188F08C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE29303C87;
	Fri, 31 Oct 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J0pIiH9Z"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23C2EA72A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900106; cv=none; b=Pj0Mq+ER3bVCguAvNpujo+mgLYsAXwVvSVsGQ2VoVJCg3Q7Qki18+cBRQGZjrNHafsibBKSy+CGhS84q9uwy1FoEuoY1kI4Xrb00l+YjI30T8oKUp5Zo1UWUatIhP8cI31wuJ19pl92kyukKBFaWXEVILT7Ppjm7e3xoIyXr2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900106; c=relaxed/simple;
	bh=q7F646AzdYc76OTBCsP9t3pDfnvuW4UFLdlFD6HwKxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNqfZPJvJaQHyRfbAvMMCisDkDV8vEpr2w9x21ZEArQSJOYDGYDAvcLYWk8PbwYwiPAvBoCBiD/RvT3JbQ6bxXq1X7alKT2DsGzeQUu9LzDUBYKCi+Lildg+pAiyluszEeNxFvOh1FSeg6R6hjNmf3b5yeO/97lXKkR+5oCI5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=J0pIiH9Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2951e58fa43so1069865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761900104; x=1762504904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hrqrHmQlBw4QJPx8h9w/0Rntf7sgvlCyYtGGSssQKQ=;
        b=J0pIiH9Zns5a9giqqyT+bqBh5h6gpFTWOahr5LqanRAml6RR6j4Xe8nuaeVXuadGvm
         TWRPNcarXt64HYgSnN8F/73Go5uymsfHqutRx5YQcCUYefbs/ClG/TgKIq4bPZjDV/17
         NJTo6QRJVjHBuXByYRtiMN0rMMA73aFox5BXe9oHki7TXyUVcM5TtAxsVEoL0iUvKy9Q
         deILWhvKH5t6C1WiWJb6MmJXez/yThalOVUCP7QwGVnvIsL7oXRoqSUEt4i3IFvWx107
         7Oeit/gv0azpS+u5GsCb4gVA1AD9i9IAxKMJfyguUqba/o7h7X0uEnm4AIjoutUYoEuu
         gl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900104; x=1762504904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hrqrHmQlBw4QJPx8h9w/0Rntf7sgvlCyYtGGSssQKQ=;
        b=NlZdLTowK6iguuihzlUFPx9+aXnIyS2aO5QLl2ZGbyC76UP/v/P/0ylzH+VNKoQqUe
         3UD92ztxa9covgdzHLCq2BVsORKqGr9HlCho3kSkjV6PD+QA01u6h7G0HO42RvmZ+ZOh
         gM4V8Gd49QzGwl899/fftJvlQ7kWZ4g4rpDeU/yk7WFmsuNZFhEGXrLktZkwx0Vl8Xy9
         cjptxoOaX9H6RzMJdstE1GXxRUMwleHeC/mCQVjrd7ejyz2GChGt01mWF6usEZ2UNHTy
         HuPs0s7P5nDD+cC9ATFy/YJDtPhXAJieUnOfu04yZQUx4VO9aSAhFhFee1AEG9p9RNjM
         rg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm64WjJ3rBq84/khszA9Nh2v5X7kzYoYEX7iKHuzmsu9+5ugpovffPYtQQ5wB5UcLRHni6PC4PDr0lWEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHEeNuSS/FGKl5JVcNI+H8CaQqyBsojCC7OIH5EEqMeziYJkJJ
	tNsFmInI3f83twlgHwUq4R8z5G4s5jqJUsRN0ltjBt5R/i8q0SC/J2OdUZpcBXDJ6g==
X-Gm-Gg: ASbGncuFiNNDZ4kHk6gtGaTyEuJ+7MWCotgRX8XNGFMXFMokaFSrSSrKoHGciF5dJtI
	E1W6hXX4f9D7RSCp4tEQEF5ENwP/StNHvQQsrGpQwuTRc5rYhV9cBz/SpAZ6WALENwRPbdOQCZE
	iTmeYtFu/XAxSDMphSPtjlPiJU3Jcd73XAJHSbwHOKUOEWyM27qyD94BFLyByNL04PrDNVLoWRu
	YGSR20C3QVq3Sd/E0UEowoD0mFViaVvL7U4Ax8SRTCFW4mSIPVrT2I3ODi1qOh7muMq+US8meeh
	WTNLtkuRdblHawgWTG9227nkSf2Nu30Yuz75ND3rllszUv54rqkW3lswOij09ZKq1214bz0sedz
	GHlca/KwNoUXqLq66J7hUUNEXXMw0Jq2E1lzz5/rzUB73Wy2Bo4yxWfcWtUF+5SZYus93pIZ+eo
	/9DHOUxI7FscnOTF3Wq6TCInkC/vatH2lgo5EyzbuZaiJFkfM=
X-Google-Smtp-Source: AGHT+IHV+akqMcvywb+3Zt1mSlS+9NiogDpHMm8+bQv2d+CTnogKsWMGLQBpDjl5fxPEL0XtSkMFeA==
X-Received: by 2002:a17:902:c412:b0:264:cda8:7fd3 with SMTP id d9443c01a7336-2951a46d112mr24811375ad.6.1761900103678;
        Fri, 31 Oct 2025 01:41:43 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm15333505ad.84.2025.10.31.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:41:43 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com
Cc: robh@kernel.org,
	krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v3 1/2] dt-bindings: firmware: Add binding for SMBIOS /chosen properties
Date: Fri, 31 Oct 2025 01:41:00 -0700
Message-ID: <20251031084101.701159-2-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031084101.701159-1-adriana@arista.com>
References: <20251022114527.618908-1-adriana@arista.com>
 <20251031084101.701159-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adriana Nicolae <adriana@arista.com>

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
 .../bindings/firmware/linux,smbios-table.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml

diff --git a/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
new file mode 100644
index 000000000000..b78d8ec6025f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2025 Arista Networks
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/linux,smbios-table.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Memory location for SMBIOS table 
+
+description: |
+  This property is used in the /chosen node to pass the physical address
+  of SMBIOS (System Management BIOS) or DMI (Desktop Management Interface)
+  tables from firmware to the kernel. This is typically used on non-EFI
+  platforms like ARM/ARM64.
+  
+maintainers:
+  - Adriana Nicolae <adriana@arista.com>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  linux,smbios3-table:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description:
+      The 64-bit physical address of the SMBIOSv3 entry point structure.
+
+additionalProperties: true
-- 
2.51.0


