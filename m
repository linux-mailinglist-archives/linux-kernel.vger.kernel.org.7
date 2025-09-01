Return-Path: <linux-kernel+bounces-795024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0B4B3EBF3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329EB440DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66A320A04;
	Mon,  1 Sep 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx70m/eP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333012E6CA3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743003; cv=none; b=H7FiUN6RasOdlbY/APTF7kx5qSQaTTKb30q+dIMV8f+7LYinzSQfZD3cdylCkwQjm9YOxAevux7q8ZdHxGcbb/D3pmXXlFZjN4iZKz617gnRso2+wiNy1nVbZkHzVvoiD0NUhY0GEXujvRBlrFnBtNVxO7V+95cTg/ThhNzUDyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743003; c=relaxed/simple;
	bh=JGm5CCLptQwOuSwtvIdC2c2wUIwgPDkpfBMNALrs+Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1Y+aWKJPWjAjls9rF8AOHG+SWWpKp+26SIb4ltjGWBS15SeYvTK5RArKCnlcshDVG/sYKYJgFPhd8N+1SOC9piIrLGnoVxnoqv6m8c6HVZ10Qp6nh4INPy0BETRZCKqNn4EwbotZ1c53nEjbbWqfeTyUaaibhpxKUK7kNXm0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dx70m/eP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756743001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK4OUWj9KISSOnqHrSCdtAWi7t1NEdnZ5iAAINpO6Ag=;
	b=Dx70m/ePUiAMmCSRwEBSiGVYSXG38DbAXJc1fHeh289PPttbRELlk48dnY0CWvpJkCXw96
	42XRBkUsvTo/5sGYr0K+m4EulMS27Aaw2UilPzofA7j6RE+EWhOYBouFUk78PZsaEA0v/s
	0ulheogS6eTM918FHL1sFNn5IT6SF2E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hA1VLcFgMmqgl9z8rA1VQA-1; Mon, 01 Sep 2025 12:10:00 -0400
X-MC-Unique: hA1VLcFgMmqgl9z8rA1VQA-1
X-Mimecast-MFC-AGG-ID: hA1VLcFgMmqgl9z8rA1VQA_1756743000
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870614b86so1366461785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756742999; x=1757347799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK4OUWj9KISSOnqHrSCdtAWi7t1NEdnZ5iAAINpO6Ag=;
        b=SDIROgocVn7SZtD/tYJDecZYEKvx00zMR+MCSGOYEwecACZR74y2GZyxGd4qUBlJSo
         2Ts+EWLrB0XINzm2pG4PGpBetYWT0Bp2kQql2/ylgMoQK1LkjrBEaZhc0HB4t/pKNuh6
         uVVQNn8RnrxHZ8y68BMm511pc/lM+kbj3feDfYAJZN/R2YZCJ+Rm4zD6Oc8TDNL8V817
         vxPohZdFLBb6Zdze28usHn0YBhM6mGyLhk25pwNf+KbYNdORnJi8K17eMF3AV6LAeKvp
         V/aESgrgdYcVTlo9WM5FMrlchlya17j2zp6mgAPHKpqQk1k876FofLkwzSA2EBLb/6s2
         5nNg==
X-Gm-Message-State: AOJu0YzaTqqGm6GyZQMRsQ7J6tgM+0C7bI3SSy431ZMD+bItDby9g4q3
	z+oL2nYrwU1e6HmTlTjZV8xELseVKScmKndPKzuM1jir5RTvaeLgvA8YvmULPutHwg3jlgm4Cw+
	xfYm2d87PJ/xB3ZzODxLhjA0tadRVrob/a/KU7ejCF8tUzLb0htb9IbPi+C2BoKyIu3X8c9PvU+
	qVNW0rPwlQZkVstUA09pfgO4/YmPc257pmXEhnJYUavzhWn4hOIg==
X-Gm-Gg: ASbGncuyepwHlAS3GW+e7ktYn7ZelfuX4vIPS88Ff6TGsKwb2Qg851CGyMbBRAvICeb
	asbb7MirRFBwohos/uOnSiFYAmCNcc6jBRoPWZrq4rYgda7A8ZVra2t+W6ju/kAjqrVcYcKr0n6
	QIRj+2znX8YoVZWD9cDGVsyNj/io2ukw8hKPC2EJk9Xmtb5vlzxbMO930Pze5gTfrB+soeNTJOF
	r714jV2ObUJnUN5DTJ2EMoya0DdWlqsUN/yOLeRO4mjDIh2ShTKhF1FrqhrzG9zCXQfSFF6CvKk
	JJY6eek/oDfW0jyTSnvhbOZe/c7bbjjqwAni25zZZKMQ165l+IQPiQRHDBDxs0EQ/xQfibA7Rwl
	GXYO2v7BfRC1O/d2/11oGUbP1oOzDLqxVbL+BMtJbdCos2iZKAqbpJ2oM5JRky9HQ5v2q
X-Received: by 2002:a05:620a:44ca:b0:7f0:b17:cb6a with SMTP id af79cd13be357-7ff2b5a761emr961318785a.57.1756742998801;
        Mon, 01 Sep 2025 09:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWFuIM6z/6h3ooA05y4N+Coc7uXzQ+I+d1s24RIzvqtIGoYRX2aMLPreLhFfFBviPAkLZ8sA==
X-Received: by 2002:a05:620a:44ca:b0:7f0:b17:cb6a with SMTP id af79cd13be357-7ff2b5a761emr961312285a.57.1756742998331;
        Mon, 01 Sep 2025 09:09:58 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b54cc37sm61618191cf.12.2025.09.01.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:09:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	dwmw@amazon.co.uk,
	kai.huang@intel.com,
	seanjc@google.com,
	reinette.chatre@intel.com,
	isaku.yamahata@intel.com,
	dan.j.williams@intel.com,
	ashish.kalra@amd.com,
	nik.borisov@suse.com,
	chao.gao@intel.com,
	sagis@google.com,
	farrah.chen@intel.com
Subject: [PATCH 5/7] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Mon,  1 Sep 2025 18:09:28 +0200
Message-ID: <20250901160930.1785244-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901160930.1785244-1-pbonzini@redhat.com>
References: <20250901160930.1785244-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Huang <kai.huang@intel.com>

During kexec it is now guaranteed that all dirty cachelines of TDX
private memory are flushed before jumping to the new kernel.  The TDX
private memory from the old kernel will remain as TDX private memory in
the new kernel, but it is OK because kernel read/write to TDX private
memory will never cause machine check, except on the platforms with the
TDX partial write erratum, which has already been handled.

It is safe to allow kexec to work together with TDX now.  Remove the
!KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 348a193a3ede..217982814bd7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1895,7 +1895,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.51.0


