Return-Path: <linux-kernel+bounces-874722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63886C16EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84BFB4FD4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA53563D8;
	Tue, 28 Oct 2025 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pllzVKH6"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78F350A2F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686464; cv=none; b=GxtYhY5X8/vmIZOoDx8kiUDmIo11Rh+o1U78VKXPpKsuurfeKxxjjHHHO3EGrWVMywDut8kduF7YyY35FZHfs2nPWwjC+lDPVBAmuSXhizehvWX44mzZPKF7J8q0T6794s8nIo2O8fWUUeSqR/iYPDr4ILXe9oknsjg/PbW9nCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686464; c=relaxed/simple;
	bh=xgvBeAilvuR1wMxMA2IgvQnx8mA6bQkEXXA41ECFhcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1wkBXJZ3q/Ff4k3epgK4fWYr8XfJ50AM1q+9zIGBAj+Ookb+3BJ317IxoP5eIZOOwQpJdnWlQt2woSIwTPbGSP2ukXt+83OvOZqOOAi8QQWasNBNqQx5P0xlQIRr3R+muMQYHNWLQKiRWSLOS/v3eRYlbYpbsAATAIgA/CXJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pllzVKH6; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-940f9efd090so2079310639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686462; x=1762291262; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwnkeaw5xTHA537xvr1qbvrkFbFprtxqChvd3RhJpBM=;
        b=pllzVKH6+E9xifzxMJoOSM30piruYsMfOEnGGHvTZ5eIodgIXAtD8Gy7D1vzTKFRZJ
         xURUwI0sLUxClhmVXPQCX8a5TvGgh68BPiq0yHc1E0S2JhLjXzCKX8ldwJ3DGxB595wO
         1T2rU5Odr8A2XTRCY+Z/M8B2n3CJp+Euo+KTgGwg0yTcjEgsEtKWFWgu/vI5nyW4o9wJ
         /wvgq/kKgDluSyUiBTvBdYwaOM6HkemRToDwR4BnSfpqwTAcHk43+iR72u9wE7GdgNwM
         XIBRaxOIqGbKwJ1yp/lkpBvW0aKNh9FwnfefvUO+5pfIQBD6xvZxeddC3++KmiQRqU+b
         kq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686462; x=1762291262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwnkeaw5xTHA537xvr1qbvrkFbFprtxqChvd3RhJpBM=;
        b=xAVIWu+GGluVnGfBi0BaffYK/5CxXqv9zRg/pl0jNng30cG22FvqzM3Ees8ZNWzPUr
         Papz25t/LMsMw3PPnwjN+e4DHvXMC3iQtgVtmm4K5w0ktPdCJ9SES7gmkHWVU/vf9Npa
         fRBTToZtNk0w/JlaLQcQFWv25WYL3Tj4OtEtMVILwguEYqiH2wbhzJthDnwb3tW6VVL5
         TVfo/vPUqnoou8aWwv9we6GAZti0EeJXAQDZZ5OzPvXnJy6YfBUVd1mEWTHdUlrFAT99
         fENtHZIpBgFjTJ10xz8CCTWTmIAQR19lrmAsjhrSrQxLQ9dNaIGy8ldZj6+Ar7Wzp0d5
         tcng==
X-Gm-Message-State: AOJu0YyacBJN5Rym9WiUANPx2Pcdp/qrAdSTx+ekqxJTSV+Elv0FxtgD
	IlgiCEc7UJsHYaUewv2zL+2v1rO8RwnW3Po6cEUEbUMJ0bKCXYg3ja3SZArv9H828357ckJiTVj
	Z2w==
X-Google-Smtp-Source: AGHT+IEN3PgPSnkwVy0W1+8Dw44bu1h3INTGMoIy4zBd51QD+vZlneDPokuppUvG2xB3FVMgGelzQJssJg==
X-Received: from iobel10.prod.google.com ([2002:a05:6602:3e8a:b0:936:faee:15c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:14ce:b0:93e:7883:89a6
 with SMTP id ca18e2360f4ac-945c98a8aa9mr141227139f.16.1761686462162; Tue, 28
 Oct 2025 14:21:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:33 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-8-sagis@google.com>
Subject: [PATCH v12 07/23] KVM: selftests: Add kbuild definitons
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
2.51.1.851.g4ebd6896fd-goog


