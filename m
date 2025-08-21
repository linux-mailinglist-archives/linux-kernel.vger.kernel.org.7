Return-Path: <linux-kernel+bounces-778932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3AB2ECD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F78A23143
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D052E9EAC;
	Thu, 21 Aug 2025 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2C72277"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185072E8E0D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750577; cv=none; b=XW5XK/38As9eHSoKcvwllv+3JK5+xkrNrluspay2UQxwm2sYJacLXm8sUOC37MV1Azr99s+iMHHqdUj6e10IjGPne0NyIt+nh6uhyvH3dHZ3Oory/ieOfLBBScP3ae4GWnyZkZ2GB76mrY7zSvWflnv7cg5eVCpXHJB4PAly8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750577; c=relaxed/simple;
	bh=vURJuaTJgpJrNoJtPEWt6WiaWS4FRfHo+2y+TWkm0fY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mvbuj1U7Ol/tFGHXYEVmc5B92YFN4LK1xpFg/KHmB/0E/ebYZR7ZW09dwjaa6SeG0NYls4rTdBKidFJS+yzsUn4fzahGcdJk8m/eE0shj+t4txgJUIizh9EWHy6IGefhzE/ddwJEIWfRG873RAnB9mP93bA8ovTtQ31mJDS1FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2C72277; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e7ef21d52so1361386b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750574; x=1756355374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHTIOBYSzMnE6EOZqw7vJKgl7xxjhcrY2TbGVLNzD4g=;
        b=V2C72277vkf/x+Ezh412qvmFQc8r/81Jmo52XfaMNV24hwbnnyk82h70KTSJ0b9sCI
         BZQyxWNNNZfGej4Tvi5IzTrfE0/mIC1utn/W9IcybBdFWT6ceieYKsR8uWfBRzq7EbK4
         m0RGdE40KsPCWsjozVXcVVabGhhUw2rBMD8k4vUVQ3NeHtD0zP5gCOebrSS+3I4k8qDe
         2koPoYxWuUYQTH5n+0VN6Gc9HU9kWvg+lodvSdeX2kxq8Rdy18QEdsqWrHTBN4H7Ydmv
         l0m2I63GHQsKPw2f07yLb+KpJG12UA+JwFuzDyVKiOsXgH9vmC77LGQ7zxTh6jGQogOx
         JMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750574; x=1756355374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHTIOBYSzMnE6EOZqw7vJKgl7xxjhcrY2TbGVLNzD4g=;
        b=cmLLaTRfkWmjbm9uRu9gOQBVESreJX6vLdiFLsLBKuORoCDCEYPp6VwZ4pSTT9U8SS
         16xI5N/iIiN1Pn1Ou8s0iBj8XpQiZ/fUMR3Ma3bDAqvcktlC004BDshZwETENf8Jy3NB
         y/ulVynpS0RfhwC2oehx1uU+WKg8e9dRMpNVFCnp1YwCIMWaS57SZLZc5/WwIKqOA2wm
         k4bULuXYTMKDsnl7Di755j4i+ktumIGXikhVSkkljPPZoS9fLukeqThxwrBq+/MuolOf
         IR6KFfiQ9pZyyJEaZjWh8Fwn3u8t5gnvn+72tySlXj5LERczfJQg5POCkU8lQuvUp6tt
         kGwg==
X-Gm-Message-State: AOJu0YwQeSNGmMaTZBTEysS0ZgpUDcFx7uuyKf2liZaSqTPq9nNwQoSK
	ImjDFBfmc2g1WbuwHOVT3hHt8l60ZcRb/mA9Y6awyOCRXM2SBvr8CAYrE9Q0MKIPF5df/KCvAfk
	1og==
X-Google-Smtp-Source: AGHT+IEogHLnsU59K+YhiS8GmhysBJljBZUNk59MXmsUmcznnLFTw8hp+ugeBcYKsTqkVN1vpDAhUqwJkw==
X-Received: from pjbta12.prod.google.com ([2002:a17:90b:4ecc:b0:311:c197:70a4])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2446:b0:243:78a:82b3
 with SMTP id adf61e73a8af0-24330ae0a9cmr1475818637.59.1755750574463; Wed, 20
 Aug 2025 21:29:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:00 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-8-sagis@google.com>
Subject: [PATCH v9 07/19] KVM: selftests: Add kbuild definitons
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add kbuild.h that can be used by files under tools/

Definitions are taken from the original definitions at
include/linux/kbuild.h

This is needed to expose values from c code to assembly code.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/include/linux/kbuild.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tools/include/linux/kbuild.h

diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
new file mode 100644
index 000000000000..62e20ba9380e
--- /dev/null
+++ b/tools/include/linux/kbuild.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TOOLS_LINUX_KBUILD_H
+#define __TOOLS_LINUX_KBUILD_H
+
+#include <stddef.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
+
+#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem))
+
+#define COMMENT(x) \
+	asm volatile("\n.ascii \"->#" x "\"")
+
+#endif /* __TOOLS_LINUX_KBUILD_H */
-- 
2.51.0.rc1.193.gad69d77794-goog


