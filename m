Return-Path: <linux-kernel+bounces-874734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A162C16F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F83B3A69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F035970A;
	Tue, 28 Oct 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBgOfSXk"
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02148358D1D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686475; cv=none; b=HxT5iyKTbrjYyZXHmVnpJrzM5pSOwsSdAL3et+KFnCXMtE0EqmQACsBXBCIGH/Bp7NV5MvbuICzjRJ0qnRDRGoRP43pcf0vw1ngBJl4ka020IElrCbCp20TINOOWsgeo/wxr9CwjelNivm1/h4Ip4rQuhES4JMIYrb68U/8WcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686475; c=relaxed/simple;
	bh=Z4cEH/EyFJtC+7YubXLF9stWj6X2tJBOoSAojvblL2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SOR3Dooc8JTEGb1X7MLjaBD186KeXvhHYTZ3NyB+aRBjG5LI9P2outesaKBl+aMprA7n3nUyvA/dM2xZOeCZK/EhphrkFjKHBbaCwwP599wNJql43EjPdw0th9zUt1QKQxU6MwTtGD/HzdlOgdO1BiaOcRrXdI/hNhfA3YmRLlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBgOfSXk; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-44db0bfbd96so741910b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686473; x=1762291273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tG66zI1+tyqk2y+i/GC8wCSgfETT28ZitF9FwVU9vh4=;
        b=RBgOfSXknObZks+7DWFnq7bbTk1tHiWSXMyvz62RxHxcmGnkY/FFM7JQogFf4JVWMT
         Dy8ko3kpnLlLw0wtKv6Q/23ZqYHAmQWqE1lIddp6VZ1lzposKCEy+j/7bK352AuplSzi
         Xv5mMpOP2VnFlTIeP0H8qRQz6v0inh5NkJm9dv9Hz4hmhTMwt1cJ+Ondm7RoOyX6g+23
         qZc7SQdxuJyeYm577Ryv+cnectIa6Zu8tcT+67bQOWYU2jmuYKGplYdpfsrAf2ggp2ot
         KV3N43Npc1m5WhmCGw4XcWL6pUhqEldDPIcuWoU5AbuqPFkbHD+wOt3CgHBfxdS/PtCG
         WpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686473; x=1762291273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tG66zI1+tyqk2y+i/GC8wCSgfETT28ZitF9FwVU9vh4=;
        b=WQsc4qOm0AoTAcJGGlKZPU1UNS/BRJoVV14I0aFezuvyOsK1wN0uG2Vla3T5flS4Cq
         cvObMBdEhPEnozLZ4usF2zASxjTFMBsjldOsXM/1miDzlOjk667KEPVLz4ZpAf87h/3i
         KYJSC7VVjbUawz6U/wkkQHQFZBB9HzfIpFZ5Q/BOyv+THHZQjbhvY7lf3jI9Xk6BojrD
         h2iNsfUGUwa4G7BbNtgtvrGYQd0HGxPmtst7ZO/GWq9ugRJ2P0ECxjGzTVatBMwMXgD1
         8oVQ96ROQUHV1hAj9HaEAXLNW8QxY5B3j6RNLRRFH9rke1arfB+9vpzLJruqt0HzFBae
         qSyg==
X-Gm-Message-State: AOJu0YwFvibG8A+DvJOMR7/YfpBDJkZtZqntnYkmsGotPwjwrcvtSGfq
	d4fVfIzXfoDA3NZrxaohUQA6eCrgRgnMy5e1CqsWCZRwcMT77PsdSGiqcnqKQ+InBg8JEsivsUQ
	LPg==
X-Google-Smtp-Source: AGHT+IEfjTcwiq0iGyeXz+L4N8OFRtJMWuG/A0eLPmPx9/8CzxaM1HhxaEpsbWAoy+R/iYIcBip4gWY4ZQ==
X-Received: from oibfc3.prod.google.com ([2002:a05:6808:2a83:b0:443:a4fe:d05c])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:2f1b:b0:44d:ad7e:384b
 with SMTP id 5614622812f47-44f7a458e56mr434238b6e.22.1761686473114; Tue, 28
 Oct 2025 14:21:13 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:45 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-20-sagis@google.com>
Subject: [PATCH v12 19/23] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
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

Call vm_tdx_finalize() as part of kvm_arch_vm_finalize_vcpus if this is
a TDX vm

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 17f5a381fe43..09cc75ae8d26 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1360,3 +1360,9 @@ bool kvm_arch_has_default_irqchip(void)
 {
 	return true;
 }
+
+void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
+{
+	if (is_tdx_vm(vm))
+		vm_tdx_finalize(vm);
+}
-- 
2.51.1.851.g4ebd6896fd-goog


