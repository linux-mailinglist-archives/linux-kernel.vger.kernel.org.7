Return-Path: <linux-kernel+bounces-870136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8323AC0A03E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D133B9BAC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4935D3093BF;
	Sat, 25 Oct 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+lU7eff"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F332DEA7E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426443; cv=none; b=dFyU7JtlQeVaZoTQqwALkzrkPbAX8v8m64vJjQ+KvKWslykvp3sYevlXYztrY3/VPR0rK8Un7M2V27a72X8WA8YquZssKM2MGOcXITg9ZwLPB2vvKk+Xl+qBEEtIkQ7sd+OKQoXDtq19PQXkHpkVv0mUJVBK3WNeKfnvdDKaxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426443; c=relaxed/simple;
	bh=Pe1PrzSHPHaE+mLJAWnnsnfkBcy0LdZurJIR6tCO3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6d7TSPLnG2TvycNQwiaH3ivoSbbWbnAYJ8vTENzpwz62A9uEfkqu67Vd/E5KkbjCdPDSmyzoP/N1Sjr/KxNhWlmClUaiZlLEKQx76nOINAXCe0Hi6KC5cLNEVq9cJ3n8UG0RDRA0u1MUBjK6hrj8+iUpYHl6vPDX9DnEzDplUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+lU7eff; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592f22b1e49so3028635e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426440; x=1762031240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr/0QMDYvE37cYblYgLUhzeK18fGuMqZbjJmBm3dTtg=;
        b=W+lU7effMFIsJJruJaLSy38csvEEmtmgfg/h6mMLrJnSkK4fxmPk2IplAkb7NPQWBl
         UVFa2Ji5niaweATGqZ1TcUZGoOZSYfAtZHbLg5atJhP4vr4wTyZ6YRiuquiYSx8yKAbn
         i75bNqp9ODNYixAkXNV3HzI405NPE66a8IDdpNIwaxGwyL/tDJC3ky1H4wMEqId0Ji/T
         MyxcOLvBDliT2GjjAe5K3e5+lyTg3nLI2+IZKz3mFFj64XjhrD6iKbEHslVSVHMUc9ZC
         3ZuTGSf+fUYwUANxWKM/QUMNqEIv83VtBV/P2dA+k+enwEuHLP0yyxFj4hqd00QIFDdn
         pn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426440; x=1762031240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr/0QMDYvE37cYblYgLUhzeK18fGuMqZbjJmBm3dTtg=;
        b=tvDd5iLecPlq2fC5CYhO6UlHxzBVRDNcBo6dbsRgGdUqWXqitL3bAJdaFMPD2DNEFP
         s0uZttDfLjpHrF8xn+85SODiV6F2Sm+2kUsMerSb1+Ip9K9poNKgsgK6e4NA/JHKBtd+
         hTux4gb5IkY8+AiLeVnaQvh1OBTwkWA7rzjQYvYU2WeU9Rn6FlnRkLzbVDbn71LomJBh
         wJO10A5CsrOB8Z6hnOVW24vIykMT/rQcq8usAB8nzGuH6rmprBeiA+LFkQ0lBiiAySiU
         RLMXAlEpnHTz/z7YE5IlK+xWnnj6wFffYzCOUO+vFyB6On/XhMkTCwutIVp2fQqRuE1F
         +p/w==
X-Forwarded-Encrypted: i=1; AJvYcCUo7R022DAaIt/IFO5TTCk+NEqfKW4zMf+gdL2+VpMgs9cVTd6mZEW9yWWt9NvT+14rKJhhe/W13y2hzdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxh7fpv7mR7js4kcQtSpgwD1oMyYsC/p0Ry8BlQOnleRJw9Tg
	rhTqtUGVz801lqY8QDBOWjc3u1+cc0JzN9GtordMIKnuCMKiphdsJQZc
X-Gm-Gg: ASbGnct0OtMeX1Wu9cz3zTyFnfG4UE9LKol1t8konvMRDIp8A6RCgbnMLfJD9AGYxmC
	ncXkwIUGREqe/FllWySHK+YiCGdehbe87KAFNuLT8xJ6awEKvGqiohnf0Od/CvsN+bD9AUeANRS
	fVJMsGMAnrvVLA4vBeyzltl+HNBXUaUWREUhmM8+w92PKvYuzjmZB+YmJnbrvNPOIGgPpLlwpFV
	WJYziomK7SONhpBzwKxV+kkCqAQOG9dVBc/rAMvs4r7N7o+qCBh+l9omYewrVIieG7GNvMd1fm/
	Dzx8VTzNdCPLvd0N8dhcJTxgw7CM/AXztFv83Doq2gSeZbpqlWuDY1EwMWtB/lTaB5oqClIItiZ
	UVKx/BTcC6Hfsul5WQkl0WXvDBoChWyX0cn5vihdCAUItjH3KiffJaw0vtkUgr28LPsVFZJn04K
	AVoWhLDwEIHnih
X-Google-Smtp-Source: AGHT+IFkPXpISal+SMJSZTatfdL2HnDeo/R8Opajfidd3Uztyq4QO9Zc4xlbr5bSdzNAFjn8IbTUKw==
X-Received: by 2002:a05:6512:3405:b0:591:c898:e82b with SMTP id 2adb3069b0e04-591d84cf8d6mr11261129e87.8.1761426439955;
        Sat, 25 Oct 2025 14:07:19 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:19 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 5/9] riscv: csr: define vector registers elements
Date: Sun, 26 Oct 2025 00:06:38 +0300
Message-ID: <20251025210655.43099-6-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025210655.43099-1-geomatsi@gmail.com>
References: <20251025210655.43099-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define masks and shifts for vector csr registers according
to the RVV spec 1.0.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/include/asm/csr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..4f55dcf86627 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -444,6 +444,17 @@
 #define CSR_VTYPE		0xc21
 #define CSR_VLENB		0xc22
 
+#define VTYPE_VLMUL		_AC(7, UL)
+#define VTYPE_VLMUL_FRAC	_AC(4, UL)
+#define VTYPE_VSEW_SHIFT	3
+#define VTYPE_VSEW		(_AC(7, UL) << VTYPE_VSEW_SHIFT)
+#define VTYPE_VTA_SHIFT		6
+#define VTYPE_VTA		(_AC(1, UL) << VTYPE_VTA_SHIFT)
+#define VTYPE_VMA_SHIFT		7
+#define VTYPE_VMA		(_AC(1, UL) << VTYPE_VMA_SHIFT)
+#define VTYPE_VILL_SHIFT	(__riscv_xlen - 1)
+#define VTYPE_VILL		(_AC(1, UL) << VTYPE_VILL_SHIFT)
+
 /* Scalar Crypto Extension - Entropy */
 #define CSR_SEED		0x015
 #define SEED_OPST_MASK		_AC(0xC0000000, UL)
-- 
2.51.0


