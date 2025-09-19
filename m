Return-Path: <linux-kernel+bounces-824145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1CB88358
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEE51C86DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451812D94AF;
	Fri, 19 Sep 2025 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ILMwbVmv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AF92D6E7F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267473; cv=none; b=qEQrBQPZN1hnl3U5QLsCeMMxkvldlC19pg017voM/6xUhvv4sqxXnVNfzNL7YMb9TzQSd49dXrJAxW+e7mwiLfB3y2dDoXfN8SBUq1qgMnRZ8Tv9v5xO5BcNKP8+AIHv/JS+4DnMFnCe2fEVcYv0OFb7cwyWMe/p2OhoISOzeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267473; c=relaxed/simple;
	bh=+YpuvhJCI/yShT1rtWNvOFpxGI7l/ehsFRhKIaNPItU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rysCvEEMee3Xpdudaet25WA0SqhF4+ch9LOjq3p8aHov6vwA3tu7+7j/S3iloVosc6d9JzsweBLpd9ls3i5HF1W98MArbhYTHWwKCmLL2OkTL7uuspYBjT2UYDTnEaHuT1dkDacgualJ5ZVpyw2qhhc2bsJVctXdIySCZu+e8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ILMwbVmv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-777ea9fa8fdso1865121b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758267470; x=1758872270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=ILMwbVmvePhwb63VcL6xWvyq86V2LqZ5vXnadEgJSykWDZwrQbtAnlaKSLd3nA6aMV
         jjV2urD+9mkl06Sa4OQeeh7HWIPO0kMaFmaEAXwdo2FOU60uZ4RIqvqs0I8QlAOBoBxT
         9axFeZevbtti6CXIFJ0keSVca9dPy7hVEEoe1iHCa5009KqC2o7FtDiXeVWQUJOJUvZb
         Lt1y55GTQZmmN1H8cm3gYunoYcwbpSViiSdjlmuPTwSpG+TvAmJzVz6zuk9aIX2gMFCj
         0auPMTS8G7O/CtzigwFHBUHWa9W30oulwiCRzilvQtvO3eJtrZtv0yciY/YDCRyhwVpk
         dTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758267470; x=1758872270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcpuRb5Zady/Ndj7TK1NVXuo7wdyupAjCmRtQU7qg78=;
        b=ZEFffa28RYOtkyEmDHgCegMXhEzm8JnRbeStBMfroC7KNY0eL2Dx3ejqLZmGY68Lzq
         Th8TpA/zg/PUVAgF4hdmaiGn/jT+E0CNvuIxFX6YtH3rkxsiViilEiLuW2aZfWLWEbW4
         AAk0JQWOO/3YNC9gU456g2ktwpDPkMEjyyVN8At3d/6Mj3v/VYTdbA6GvR3W9eHVV5JA
         ADk+b7iuY4LiMPX5cN1h9HDMq6fFZn5ImQRRHW/mDuHF1rIIuT/nSp4HBbTznjHLIy4G
         eQ6PGOUZItmM4nJG/qCRlATktNCFmnNnOlCsoXWZSDUJgu4z+ukXAbnuNqaNtcPdbCKf
         NxWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2DSjBoByTICiuyKenrl7YMNHFn+i3NJ+VMX1vr9k+wVKHB/qQVEFO80p5xXYz6hv7Jhsu7+YTuutnitQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5q20EreW8QkOoxrAtTaGdTCJJUIPvBCAd/rgRiOPV09oRlGN
	5340Zv42ljmhBMmWFeQOfZQBrFlE9P1FzIgjnLXKU1Oc4bfDjYz0YJqC1Go503AJXRA=
X-Gm-Gg: ASbGncvaVd5MJEClkTdVnHMTDHReSjGCZv8ELeh9X5Mcu/NZTQLsLYCwMTtSZSCidF/
	2p6TXKnWXe1NZrn8vXwXRfgIoUUyw42guPezcltgtJukm63k+2y51AV4UCYYQHy61x68BlH7Qtc
	r2fF3wisJWPsUTzyt0RZyW5ryAgLrVIj3Azs1jqBh+OzM8Y2DOtHxJrtlYIndxRXuCwHqg/vQ/K
	GQigc3F8yuXA48KR8nlu4pRLBsUWRxJ2bEDoLzrx133w682GYjQbnSxgf2D0tAawEGvhZWHBM8o
	MBCCn+7OX03SUT+J6xQpz3Bf/ble5hRUbtItEdy+oT7ur/k5rvdRtqho6z2/whg5n1I+NytxtUg
	Zfkc95ynftpdtbgtTTr2g//Er3oT5J6FcqBI5Exw/pNGiyP+k7oWUv9AFb4Qzg7D2zYW9cvTb6u
	EOU8IbkXsacWIz1GvhElhCxXELVS1EXe2/M7oWdWbR3w==
X-Google-Smtp-Source: AGHT+IEgACB1Se8zkEhUh/liD5ZfRMe2E7bZVsNaOovjpda2dN5kxeT40rB2jna9QVBQYl1FDLn0SQ==
X-Received: by 2002:a05:6a20:258e:b0:248:f6f1:200a with SMTP id adf61e73a8af0-2844b5ca29cmr7654865637.1.1758267470068;
        Fri, 19 Sep 2025 00:37:50 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b550fd7ebc7sm2679096a12.19.2025.09.19.00.37.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 00:37:49 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: corbet@lwn.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	will@kernel.org,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	mark.rutland@arm.com,
	parri.andrea@gmail.com,
	ajones@ventanamicro.com,
	brs@rivosinc.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 2/8] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Fri, 19 Sep 2025 15:37:08 +0800
Message-ID: <20250919073714.83063-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919073714.83063-1-luxu.kernel@bytedance.com>
References: <20250919073714.83063-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zalasr ISA extension

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf534..100fe53fb0731 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -242,6 +242,11 @@ properties:
             is supported as ratified at commit 5059e0ca641c ("update to
             ratified") of the riscv-zacas.
 
+        - const: zalasr
+          description: |
+            The standard Zalasr extension for load-acquire/store-release as frozen
+            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
         - const: zalrsc
           description: |
             The standard Zalrsc extension for load-reserved/store-conditional as
-- 
2.20.1


