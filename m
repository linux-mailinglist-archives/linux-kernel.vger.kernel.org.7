Return-Path: <linux-kernel+bounces-778926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DAB2ECCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81592A239BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA12D7813;
	Thu, 21 Aug 2025 04:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3Dw/nm7"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464B2505AF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750567; cv=none; b=sHMjDx2cxGMYpUlkHkeiRh2FncwBnnrJgwMoVi84TWosgr83g4ZnghuPuLp0HWTAkAqvFSzhBSH7RU4x2Rz2SdXWi4kJcSiQhAdCP/YxwErFFm2GojD/AE2UVbRDEl6IcMblLkCgSLR6l2cL+VelHn9xYuaJ+BsuwA0se9BxHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750567; c=relaxed/simple;
	bh=CNyH3iLKYyXM2PucLKJJexKys2GtwF+RYJ7BGDIxHvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LvP3XxGAuKD29h0H3fA+4oBMMFw1HzCWkJmaQnTRRCzmBLnFHwBxpBIeIL1YAvmh1gdVsVyBSTcWugC8lH6aIkXJlA+vQxds5uCQiywIt12jyhgbXqsst9QVi3H2CkO3QIgtfa4guZTMPf28W+9nH5r0YAxODyiYj2DlTTkMpYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3Dw/nm7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266b700cso1374805a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750566; x=1756355366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBEsUjopqWPQAb2i5kfB0Dt1bw+I4tk4XbZtWvO+5Q0=;
        b=v3Dw/nm7XhpT2vIgkIS+HxkDU0KefU4c71Ml2M79+EhZW8l+R99SMV7nyzREXe8FR9
         dZGOKABFzriGUxoW2+Vg7g4z/DPgiL1YLkZjCKIBgKz6OZdx6dMf+kq90qCCUK2eoeHG
         O7NQR9Upxd8ZYBokBOevCTCo2cuzJBd+An3w8ntIZqwBqNfjrFxw9lOFaB1YJ/Bn45Ji
         rFQ89z1gRfEYesyeO3r2VKpk/mFU1xAW64uE29J08sdQY+VQMMTUX09juWdWgvJPN+l6
         cWGC2JOIPAcjJEWQKdHF279kJfoj3QQtjI9khoN6emTXHP4ZET7TqvKi0j8r/8eevl/V
         GFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750566; x=1756355366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBEsUjopqWPQAb2i5kfB0Dt1bw+I4tk4XbZtWvO+5Q0=;
        b=raIRC6NtV1kZi+LQnCA+Xgm1h0Lx5IxCV4aIrvjeBjzXzoD5eKkQNnLsopirVXl6Fc
         M3WB/V5XFieltRfXNJ77OCIxWCzqcIEtbNd4EzR3E9NUPqzSmnqb8HbskUOT2b6Eyu/N
         JLPBYGl+ssZL7iEl4vtYiiwrphKpfoESsMzRFOVjPC1qr6rG+DmEbtMtE+9Zw2f4hima
         BL6Ck5kyp5VovxupE3u3P5h5l/ff7733tN/94G0+ZNLhBWcwLjQeJfWN0M36b2GhGlCa
         bRToCcTijJt85xTwucARWXhU74/pW7+nNw9JNsZtFFFwM9SEDHnppDaxVCBS50RVtvfb
         f9GQ==
X-Gm-Message-State: AOJu0YwBkPso0JITeAEj96Uk0NT+VIXhYlHe4RTTOhTnlaSDHnUCPDs5
	C6AzyrX68wiqoHcfE/kXpZscNUHD9NzJ9D/Y7K9dioPu3gfeIHWs+vewTyLG/7rxL/rW3PL1b+O
	TgQ==
X-Google-Smtp-Source: AGHT+IFYWwfWRedCl4TaEHt8DsZOpI9aKhsO1LVwtOPR4LokBo0OPUYbdS7T4gGWHlqrRzQ2RYeoQBN9pA==
X-Received: from pjbqx8.prod.google.com ([2002:a17:90b:3e48:b0:321:b354:6b5c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c7:b0:312:1ae9:152b
 with SMTP id 98e67ed59e1d1-324ed114c90mr1478574a91.23.1755750565556; Wed, 20
 Aug 2025 21:29:25 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:28:54 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-2-sagis@google.com>
Subject: [PATCH v9 01/19] KVM: selftests: Include overflow.h instead of
 redefining is_signed_type()
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

Redefinition of is_signed_type() causes compilation warning for tests
which use kselftest_harness. Replace the definition with linux/overflow.h

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995..a580a0d33c65 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <linux/overflow.h>
 #include <linux/unistd.h>
 #include <poll.h>
 #include <stdbool.h>
@@ -751,8 +752,6 @@
 	for (; _metadata->trigger; _metadata->trigger = \
 			__bail(_assert, _metadata))
 
-#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
-
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
-- 
2.51.0.rc1.193.gad69d77794-goog


