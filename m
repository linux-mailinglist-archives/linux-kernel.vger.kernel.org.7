Return-Path: <linux-kernel+bounces-839356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E1ABB1782
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C4E3C0F03
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC622D47FE;
	Wed,  1 Oct 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NM9DTKVC"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA52D46A7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342647; cv=none; b=dYQ+xH2B8EXsBVhLIeNwX/GsSHt8Et8moeEgZgRmjzqX9SuiNTmAzMTU8dIdA9Vfi5kvj++Bg6GnpxO++YBuw5fIjIjo2xzoK7FyCiWYtejHQYvWNqThvXFaH+wczVUb1FshpzQwQnt1zXAtecSWauwbZEI0NcunfHjYhASPH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342647; c=relaxed/simple;
	bh=twWts/BBJvvdpMllhwwy0sPWeHXBhThVVr0F+f1kI8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOrhNh0EP4X3cWn5OksIk+wkBejiowrOSQfXKzmRG4ULUQn4MXus4UP/p6wF9NNGldAWLvqu49nhWmVe0EnhoAuMtTG9/7FhKLEpddhcvgxvLqt0b94PZ37YuqQf5ccLxRgpo8DjqgHwoQYX/i11kgm3pPVAcfy5Roo1+DU+JTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NM9DTKVC; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-4259247208aso1006845ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342645; x=1759947445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqovZHXYm5Oo5CU4XtE9N0uxOF2JJp5QxUlgkpF6rV8=;
        b=CckCkcl9RJMyx92zZiSQzCGXPYJ6jian9RuLNuWwNsOLanypwNbRHXS8GUCCcBynpl
         BqZCjT2rXxQzUtjLsgHVjWrzNIATloK7mMmwjdJDHAXR7lTco66IqboOtjvrFaKHx/We
         6gBLwDLjI59LFtLoZjyfqi457h4XCo0kiwXUsoRiZi2NCX08gIeIT67eBmgWF9t7vkDw
         yRUlXgf7kd6zBkpbemn+FGq4ox9YN0vITOzox2caws8s8Blx8Jplk3WmeFhEs8L0Mfyd
         hzCftuku4zsmX43rWvq94V1FMs79IMI8Rtji+KVIsSby2MeB8YJgeEwJmq4/viGJ/Dzr
         jUSw==
X-Forwarded-Encrypted: i=1; AJvYcCXL02l4EgoCexOYLsYpb1o6xMA7eskezApUevoStU/rLz2bq0UXIbK2+mBkjcxgPEt68+/Rw/6fMdMEz9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsFyACpQtP1NSC8vQ5hI5qkU+BvWN3400QKEuVbc+/xVW+L96
	lChDYXFqweXzJ8rVCx5yfmRQvfjDFvTuhmsuW3L3ew6KYgZwkrsih6BCYR+aiGGdGaYhIZdoty1
	n2gz9tfaHF9PxWG9C59U+/2eE0aPZABPw/UBMYacZpycMU6hhe+WBinWgs9fErj7RgW1+s79DGR
	qtDEE+z4AURiGiUh0BWDqlRJ13qO7f6hiCEcXCW3V/hWJANYWoKu1XrPbignj2i8ZI/4RkCGO85
	UPnh7Rm+xL/Mu2v
X-Gm-Gg: ASbGnctEYkWs9kUcREGJnuG3gMewovpFY2YtXTM2VruAGsmcJuOcDoUxwWm/Z2ylXMc
	85v8p/z/JKs6HsglojNP+zNOpKMOMbJOaFAZzXrmwtze5Uae+fvwr2xvuvEmIBFuShGMSHwl5M/
	h2T+8ut/ilZYQCNQlwdVcAEOrujsJGwOtMJ5MHFXOzbzLe9p4iA7XmEnr8KAcV+ogE+R0qdJVGM
	fXPSqi1HRkNmjjJkxWwS8C/EkjIMHiylVKuR+fjFK7mhZ7fFz3VNOYIt88nCn2BTUq4WvUiL3zi
	y68LCOfSy5JHDISWX3HuqVjlgyDQiJntpMyNJ9YcRrex+AUbogQqnx5QCKgm18M3TnvqByWir3V
	qxHo02KRtm13Zw7u3qoQ7Ir8CGJDdNJfldOV9yHfwQvpGCR3utB1rvNYFBZLKKyIZJj3AGBlG9i
	VHvWvD
X-Google-Smtp-Source: AGHT+IENrGQakbRwfM8D6zHz/ytYD0m6B+vLNN4d9ZZrXhJl3TK6JnySAXLTniJoYuz8gATRlLngQrXZS36o
X-Received: by 2002:a05:6e02:178f:b0:429:6c5a:61df with SMTP id e9e14a558f8ab-42d816011edmr65219385ab.3.1759342645180;
        Wed, 01 Oct 2025 11:17:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42d8b279832sm244565ab.21.2025.10.01.11.17.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Oct 2025 11:17:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d602229d20so2995301cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759342644; x=1759947444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqovZHXYm5Oo5CU4XtE9N0uxOF2JJp5QxUlgkpF6rV8=;
        b=NM9DTKVC3uORx0VjAAs4aCB9j3rmQAfnn1bZlsb1kHYVsCPf341aWBgPWSAIm2j+m/
         GPX5R8bux9KxGbyuSMzCJm/cBLsV0tdlOoi5Y/Ag4a7j4vEAKvC03ldn0mQqc49rEaKT
         KfX8k5VCZvUvkU/I8BvsUu3KaAcNjoPGHTpN0=
X-Forwarded-Encrypted: i=1; AJvYcCVqlfK3Az1ScfBM3HEQQmakqhHX1xqNeBo0kjLZgSnH7FlNbyprTOwyF4mCOqk1Llq3uwo1NxupxWySmwo=@vger.kernel.org
X-Received: by 2002:a05:622a:258e:b0:4df:3960:a963 with SMTP id d75a77b69052e-4e41c923deemr68250481cf.7.1759342644369;
        Wed, 01 Oct 2025 11:17:24 -0700 (PDT)
X-Received: by 2002:a05:622a:258e:b0:4df:3960:a963 with SMTP id d75a77b69052e-4e41c923deemr68249741cf.7.1759342643640;
        Wed, 01 Oct 2025 11:17:23 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e78cfsm3847671cf.27.2025.10.01.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:17:23 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: peng.fan@oss.nxp.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 1/3] dt-bindings: hwlock:  Adding brcmstb-hwspinlock support
Date: Wed,  1 Oct 2025 14:16:39 -0400
Message-Id: <20251001181641.1561472-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001181641.1561472-1-kamal.dasu@broadcom.com>
References: <20251001181641.1561472-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Adding brcmstb-hwspinlock bindings.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
new file mode 100644
index 000000000000..f45399b4fe0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/brcm,brcmstb-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom settop Hardware Spinlock
+
+maintainers:
+  - Kamal Dasu <kamal.dasu@broadcom.com>
+
+properties:
+  compatible:
+    const: brcm,brcmstb-hwspinlock
+
+  "#hwlock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#hwlock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hwlock@8404038 {
+        compatible = "brcm,brcmstb-hwspinlock";
+        reg = <0x8404038 0x40>;
+        #hwlock-cells = <1>;
+    };
+
-- 
2.34.1


