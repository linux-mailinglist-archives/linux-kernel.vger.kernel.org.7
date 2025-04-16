Return-Path: <linux-kernel+bounces-606224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF80A8ACA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 02:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EFB189E3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195421A7044;
	Wed, 16 Apr 2025 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbY2oVLM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60D1A2643
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763161; cv=none; b=qx9DVzceYlmzh4hCSWwuQ1B1e2RtF8ZsNt6yX75zUZV6xRh2UIZnsrQLmw/tUSkTgkMl2R5t97TDBFyzXyY3ZLEEMG8v1NGjsMV8pQkksuvkHG3TYlgWRJC/unBmqXEUIyJ0ayJFDLFdWooLmeQsQRMw7Z7LCTlLVLVEFam+wEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763161; c=relaxed/simple;
	bh=rAQB06qNKaTpCQ5F1V2P860tIuKiVC0zxgSe13IoRek=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U3g6L3Z7Wh88jupN+hU/v209j7A93jsqawaUPuEJsogiFmfpuc0Xv/ZQCSJKvQDd6AyynNr05e+26E5QUtRb5gHsg0SvccFj0Z7iXJqwbZeAv8WbP8FOn0X4bzu86pUbRXgKAFVaTTXX9NmvoDXpNq0MzBu3RcPXKOx1sIWOyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbY2oVLM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744763158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6VRzsCXdjsEm2LcwvX2WIfWWs2J/juCRAQ9Ar72ntks=;
	b=RbY2oVLMjWeYn/WoEQyccp/8ynj/g5TWnh7Ukq/G2KsVWgWjPuCWzYOGgTO6UYhewyEbJ0
	zp9WXFKGJIyanzmYozckgbMCSn6UxbboqwHgTjtxNEbVzjkIFGAJYstlNtUfuu6KaJZsSF
	epf0TS136FZC5lXvndtGABpNRA3BTyQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-41e5qrCiPtW36mNL1R4woA-1; Tue,
 15 Apr 2025 20:25:52 -0400
X-MC-Unique: 41e5qrCiPtW36mNL1R4woA-1
X-Mimecast-MFC-AGG-ID: 41e5qrCiPtW36mNL1R4woA_1744763150
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50FE8180025B;
	Wed, 16 Apr 2025 00:25:50 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 686BB180B489;
	Wed, 16 Apr 2025 00:25:47 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/3] KVM: x86: allow DEBUGCTL.DEBUGCTLMSR_FREEZE_IN_SMM passthrough
Date: Tue, 15 Apr 2025 20:25:43 -0400
Message-Id: <20250416002546.3300893-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently KVM allows the guest to set IA32_DEBUGCTL to whatever value=0D
the guest wants, only capped by a bitmask of allowed bits=0D
=0D
(except in the nested entry where KVM apparently doesn't even check=0D
this set of allowed bits - this patch series also fixes that)=0D
=0D
However some IA32_DEBUGCTL bits can be useful for the host, e.g the=0D
IA32_DEBUGCTL.DEBUGCTLMSR_FREEZE_IN_SMM which isolates the PMU from=0D
the influence of the host's SMM.=0D
=0D
Reshuffle some of the code to allow (currently only this bit) to be passed=
=0D
though from its host value to the guest.=0D
=0D
Note that host value of this bit can be toggled by writing 0 or 1 to=0D
/sys/devices/cpu/freeze_on_smi=0D
=0D
This was tested on a Intel(R) Xeon(R) Silver 4410Y with KVM unit tests and=
=0D
kvm selftests running in parallel with tight loop writing to IO port 0xB2=0D
which on this machine generates #SMIs.=0D
=0D
SMI generation was also verified also by reading the MSR 0x34 which=0D
shows the current count of #SMIs received.=0D
=0D
Despite the flood of #SMIs, the tests survived with this patch applied.=0D
=0D
Best regards,=0D
     Maxim Levitsky=0D
=0D
Maxim Levitsky (3):=0D
  x86: KVM: VMX: Wrap GUEST_IA32_DEBUGCTL read/write with access=0D
    functions=0D
  x86: KVM: VMX: cache guest written value of MSR_IA32_DEBUGCTL=0D
  x86: KVM: VMX: preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while in the=0D
    guest mode=0D
=0D
 arch/x86/kvm/svm/svm.c       |  2 +=0D
 arch/x86/kvm/vmx/nested.c    | 15 +++++--=0D
 arch/x86/kvm/vmx/pmu_intel.c |  9 ++--=0D
 arch/x86/kvm/vmx/vmx.c       | 87 +++++++++++++++++++++++++++---------=0D
 arch/x86/kvm/vmx/vmx.h       |  4 ++=0D
 arch/x86/kvm/x86.c           |  2 -=0D
 6 files changed, 89 insertions(+), 30 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D


