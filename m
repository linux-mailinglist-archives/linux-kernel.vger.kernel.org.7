Return-Path: <linux-kernel+bounces-836793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96637BAA934
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5F33BF105
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E57124E4AF;
	Mon, 29 Sep 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DpIgItuA"
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA2257459
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176429; cv=none; b=c1QH2XMFJoZzFPZR090vEuY1a9CsAOpKrxXv3IvsOIbBt2cbXTjvztMwxIykZpZIu6HpkX3uUaZDAFZEdPk/p42Q1KY8Wv4BJz6wOIaynAQMfC8KEfVCxacOjXhjBBGrUbI0iNrp7drEYXTgUwKHYdgGT/8AniauOLIdfuOZp4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176429; c=relaxed/simple;
	bh=twWts/BBJvvdpMllhwwy0sPWeHXBhThVVr0F+f1kI8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rG/mK3cgQrhtygega7XeQLr/8FfUxSivHZjGxhdQToJkUMAsO4W+lLey+yltEL0GceZkioHc0Rb3bxG9HH5Qm3mrRSQhbU3VcL8J9Pm23xGjwfGsoOJP4ThoG2R5nMsoDIQ2ygHHYL01+gAbEP+yXRMdz0VwJpOcvdsHpfGXPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DpIgItuA; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-64439bef307so497698eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176427; x=1759781227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqovZHXYm5Oo5CU4XtE9N0uxOF2JJp5QxUlgkpF6rV8=;
        b=ZMrmI/FyahuHBAsK++EfywnZYoHfMpy8UinSjAyF1x1HvstIovTlMzQZsoLGXtUUlc
         iY8NrIyb5MXOscv0KD6rxNLfuZ8JW51p1iZQHX+Oh2VG3jg4BUJYz2tO0wKITY/ZyKBJ
         ZiyN3J5KyB0LMehgT2HWYMq/1MMrX0wVi2gTnGsdFenUFPttrO6hb6bBcmdTXf4HiAu4
         Uy6HBbK9HU+OzyVevBnpiGp0TvCOVq+z5NB59ktiLABEeptcaHybm2QgTdnyUhkyJiSD
         C6zG+p0ZF+wHi/1LGJ5Bes3a4k/c4/QyuuCF5aPsJ6aMRctPMFJAFClgPEupkExcg/yd
         8qrg==
X-Forwarded-Encrypted: i=1; AJvYcCVLYpPK+eOiiL+tiXn6sD/lyLeWXn1LNeBIlfqKovzQJON6bVsO6uMfunwFT/+gN4xYjLGhLtvvofKBSIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKlH/RPWzSL/TncXqKArZRRNaLiIKHzOfGBbrJv3zw1aefJXO
	+smdz4Cp6yKZKThL1WNWlftL2Kh8cBQDvygg3aYpAmCVz+3+PqfJEvJhKfABaFw0qaRBLuze2PE
	GPcQ8bgOvk1ti8/RuEDbwbyucB9/qMcdAqmqRaxwlysWNJYg6JH952jiWJ8kso7WR3bJqi2s/x8
	q+NlvHsP9U5GqCnAn9g0jY2S9jUGwd8/57flXV1uEktXORpp0IRnpWf0Z2u/ZECltd1S+A20Jmk
	Mnz33NxBThJ9nFn
X-Gm-Gg: ASbGncs5VtW9C93cMhHIXn93S8LpUi5+FrWJKS2Iw7LniOcW0+VTDhNpA7uVnkuvDdl
	I7R8ppqi7z3cPiQ68cwl+mX1h7dG/w5DYX57VMu7/7iKdpYhJfr6Zt1OS9Gy4RsDH09q8BUVcsQ
	t8bXE42t45bXF5FlIVi9dkqMx3Kqf6IdbtfmxWbcOU4N1qWabEeiTLNUW8uE2WmYH22Ft2zT6fR
	1lzkcl5HXf0s9Z5R/4nGbb6PsgEXA074xYVHJkjTcqWawqhvEj9ivuG/JzM9YwRyidFoLyOunbL
	4v3Qmecx8EJBO5pYggKSLdQQ6x143Q0wejewlXH7/wdwl5qwsaz52TrYdIL2jJl0rz7ZBDHFxU9
	aLHn2PGn9nVJm86LSr8a9
X-Google-Smtp-Source: AGHT+IHoz9lPkhfApMM8Eg2cfmlyVsrF7ULPF0qUb3kU9NBUL/jawwOT4yuKbVtYjsMbLIojh3KZuv4R5pgo
X-Received: by 2002:a05:6820:220f:b0:624:f051:dcd9 with SMTP id 006d021491bc7-63a299e8384mr8130876eaf.0.1759176427286;
        Mon, 29 Sep 2025 13:07:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-63b1f673255sm394731eaf.5.2025.09.29.13.07.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 13:07:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b554fdd710bso3620464a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759176425; x=1759781225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqovZHXYm5Oo5CU4XtE9N0uxOF2JJp5QxUlgkpF6rV8=;
        b=DpIgItuA/K8nC/n9G2Y3rf47n/R8vg7U4qrfGbDMZmVlbJjiNw7uMarM4gY6rp4NG9
         zK0sPELYbsEYMJyg4yBdwavUBshzwX+1jEwRjbl39tIz6INlI28igHpSwgT08D+NOhHu
         4e0UuzmXGTnH8bLxL2M+cZ9rkQKAHs2Yna33M=
X-Forwarded-Encrypted: i=1; AJvYcCVNvDrHGq5NcKnLXDpGmSa/DKSHFO4YIlga3N64y1yj/5rMcu4s0XHpcoyCJxAqk81V+LG8pUEMvi9K2PQ=@vger.kernel.org
X-Received: by 2002:a17:90b:1c81:b0:334:29f0:a7e4 with SMTP id 98e67ed59e1d1-3342a2bf175mr20116985a91.21.1759176425630;
        Mon, 29 Sep 2025 13:07:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:334:29f0:a7e4 with SMTP id 98e67ed59e1d1-3342a2bf175mr20116976a91.21.1759176425253;
        Mon, 29 Sep 2025 13:07:05 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838735194sm2121479a91.22.2025.09.29.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:07:04 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: hwlock: support for brcmstb-hwspinlock
Date: Mon, 29 Sep 2025 16:06:25 -0400
Message-Id: <20250929200628.3699525-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
References: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
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


