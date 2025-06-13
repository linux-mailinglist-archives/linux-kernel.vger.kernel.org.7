Return-Path: <linux-kernel+bounces-686024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D0AD9210
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFD43BF903
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD380223DC1;
	Fri, 13 Jun 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPQISV+l"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4A21421C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829969; cv=none; b=c9oNrFPQ1lwMJeV9kc79CnZW/stKRrcYafxWxk9Jb3PdVDtZv1xstWpZXqoWAgKHaCo8Q3/5jJ4psUTXuEqO59DV8KXpvtb7lIjp3/O/dwFSwQOGvaWenaeQiOG2dxUR3vwFiDg1pjCw5PqLmmdqXHgzyXnsPuK3OVaJ/rGrTm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829969; c=relaxed/simple;
	bh=eXRtX/UUgQvo3bBh+4EiHeDAuA119SvPlV2LgJLgsjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nZTzi9EUlaws/Fw/HhaGu0TfoykTtpK3s8rwjn3E1bokws9wgsRBK+6I9PWnrCn00WnRlJ16gAeMdcptFofG2P8fLmn/E6C9yeIMCl1x55wxFJ/sm/Y2Umj2D5QZ1oNVYPeQJbHYwoxYob3bX/V9VR+4OQ9Uzq4+XaYQkenUCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPQISV+l; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72c7d6a53easo1970496a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749829966; x=1750434766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1K2XaU3tNN3z0G/Brd+aKIcwvKoH6QYgKOpK8mTmcUQ=;
        b=YPQISV+lMf46y5Yq0z476aTT2q6PqOxH5jStvfs11XErOdi3staJ7lc1GS1sKJAX1d
         dj9Y7vnjmiHnAPZcHGjFGTc//XhMmy/y5qiWqoRKhHlYx6lzS/cE/tsQ+WyRE05rLKxU
         J028scfHNl1Vun/uySVEhxTfGwxYRXj3xUiGtJF+FTHIyB+QWwtAq4J/ORwcWLQYUHLR
         qzbpBdDDmCgVBkLZvboK33ZBdZomnM2MgxB1Yksv24UjQb9E8z8ayQxMBYvmZi5I1Pur
         JSzp+wAu85VIfgUyjxI25kGgrRYgGcj924MjsGS6OQh//wGtq27ncoIkHQe5Vm2Qwynu
         xB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829966; x=1750434766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K2XaU3tNN3z0G/Brd+aKIcwvKoH6QYgKOpK8mTmcUQ=;
        b=McaUdO85vw+opNnKWhAhz/y27wNT8wnzY6MBAzWF7VAbaAmiwPHcdCpKcPpyh12j3g
         ed7D+tf3DR+XryXTzJMuzwYCmXQ6BMX+V5RFui7/iSI3xP1Hs1v0MS0lzyu75BaeVfzf
         3T6SI9pE6ZMKmoxzwaM/YN26ayAuuzWljkd0BXykWZDKOqCfe9eiB/fpJE9ui6Wurs7M
         O3HdOPHuyXbQahuY6DRQa9v1x4OKsK/If6+MHAeRh/eJEC+JCobuG0AIZyJPEAutC9Af
         DojGX51ZCriGpuh8hDwBK2l+wVQmieytiyD/1CtFNRArT4omygGIVKK92Cle91NZaum3
         Q9+g==
X-Forwarded-Encrypted: i=1; AJvYcCUMdh6zZdvxNtWfZuZTwaTTovvriuqfblYm6EllXVu48iI/qkVTjZZdYFOCa79VfWuWFB06Yzz8P+PvmoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9nEJdezD3rTnuifBRUVN/nT4IOHciczZ+HgYze1+16O8VrsN
	NNbLsH/pemiZs+A709ys6R3lsoJALO/cI8ma7v7ebGq8+VWX6oM//gTR0W2/zEskYBnxlcN0JoP
	bAlK2vVoZ7Q==
X-Google-Smtp-Source: AGHT+IHFbGJBseK+0NlITWxhqlLkXWlDYICLQM+zu92+pohfxizATwmXWeCDlmWgZ4GDVI5eahezZ/DYLRTe
X-Received: from otbbu4.prod.google.com ([2002:a05:6830:d04:b0:72b:8185:e90e])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:210d:b0:72b:9d5e:9456
 with SMTP id 46e09a7af769-73a36367352mr186163a34.13.1749829966723; Fri, 13
 Jun 2025 08:52:46 -0700 (PDT)
Date: Fri, 13 Jun 2025 15:52:38 +0000
In-Reply-To: <20250613155239.2029059-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613155239.2029059-1-rananta@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613155239.2029059-5-rananta@google.com>
Subject: [PATCH v3 4/4] KVM: arm64: selftests: Add test for nASSGIcap attribute
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend vgic_init to test the nASSGIcap attribute, asserting that it is
configurable (within reason) prior to initializing the VGIC.
Additionally, check that userspace cannot set the attribute after the
VGIC has been initialized.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/arm64/vgic_init.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/vgic_init.c b/tools/testing/selftests/kvm/arm64/vgic_init.c
index b3b5fb0ff0a9..aaecba432dbc 100644
--- a/tools/testing/selftests/kvm/arm64/vgic_init.c
+++ b/tools/testing/selftests/kvm/arm64/vgic_init.c
@@ -675,6 +675,46 @@ static void test_v3_its_region(void)
 	vm_gic_destroy(&v);
 }
 
+static void test_v3_nassgicap(void)
+{
+	struct kvm_vcpu *vcpus[NR_VCPUS];
+	struct vm_gic vm;
+	__u8 nassgicap;
+	int ret;
+
+	vm = vm_gic_create_with_vcpus(KVM_DEV_TYPE_ARM_VGIC_V3, NR_VCPUS, vcpus);
+	TEST_REQUIRE(!__kvm_has_device_attr(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_FEATURES,
+					    KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap));
+
+	kvm_device_attr_get(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_FEATURES,
+			    KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap, &nassgicap);
+	if (!nassgicap) {
+		nassgicap = true;
+		ret = __kvm_device_attr_set(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_FEATURES,
+					    KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap, &nassgicap);
+		TEST_ASSERT(ret && errno == EINVAL,
+			    "Enabled nASSGIcap even though it's unavailable");
+	} else {
+		nassgicap = false;
+		kvm_device_attr_set(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_FEATURES,
+				    KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap, &nassgicap);
+
+		nassgicap = true;
+		kvm_device_attr_set(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_FEATURES,
+				    KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap, &nassgicap);
+	}
+
+	kvm_device_attr_set(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+			    KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
+
+	ret = __kvm_device_attr_set(vm.gic_fd, KVM_DEV_ARM_VGIC_GRP_FEATURES,
+				    KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap, &nassgicap);
+	TEST_ASSERT(ret && errno == EBUSY,
+		    "Configured nASSGIcap after initializing the VGIC");
+
+	vm_gic_destroy(&vm);
+}
+
 /*
  * Returns 0 if it's possible to create GIC device of a given type (V2 or V3).
  */
@@ -730,6 +770,7 @@ void run_tests(uint32_t gic_dev_type)
 		test_v3_last_bit_single_rdist();
 		test_v3_redist_ipa_range_check_at_vcpu_run();
 		test_v3_its_region();
+		test_v3_nassgicap();
 	}
 }
 
-- 
2.50.0.rc2.692.g299adb8693-goog


