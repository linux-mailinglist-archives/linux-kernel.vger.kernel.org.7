Return-Path: <linux-kernel+bounces-795026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592DB3EBF7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C6D17A87D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1720320A32;
	Mon,  1 Sep 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ni8Sbvzi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BD320A2F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743016; cv=none; b=FQ7KJKA51OxnaddncHLsdEJ84BQT0O6pRGCAL3s8DXZaBJsEZCiv1v+IV48Fbf+ImYcMLrzXwoQO9S6Q8QexPb8yFZw1Rxw8L8gyBhaQcE2DenVLCph+m9dqpbAq1ea2CA7VebgqDT80dFNvcymaPJ9sZhefQIwgxRaSVvhSa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743016; c=relaxed/simple;
	bh=Uo10WvJDZhKL6JBEoQLyO2D0kgnDiGHkYMbNhBPE5D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rIXv1r/yF29vtdzcvasX0AhGPjhMvjTWnBO4pt5R0pdXYyDLKYwKQjU2YEmPC84h/jcUvF0Ze1dtINgxDf5bEss3RgNg9639iswNmfOrneW8U9iZswOfif5dlIODY5BPhUSaG03x+K2f9eMqBAvPXrCkX+bN9gh0X3ubfwcgwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ni8Sbvzi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756743012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ay5gC/rJKyMKcqoVVau41lZbwoCz+kjLe1Ep7vUjxrI=;
	b=Ni8SbvzigbGyMJSLQk16IoJcqD0+rIMxxx6bLM5tvLc1VFmFMeqML4flzjvIMDySH9fHOu
	qWTIo0bFC2majc2D9dUnkoKzqML58/HQ4oepyxv66DzAvxMtoHgwvdUhUg80f57co3rWkt
	n4H4YmmqGOyotNEGpCfcNUsMzlKjYqo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-YG3oUaRHOZWiO0Swj90NdA-1; Mon, 01 Sep 2025 12:10:11 -0400
X-MC-Unique: YG3oUaRHOZWiO0Swj90NdA-1
X-Mimecast-MFC-AGG-ID: YG3oUaRHOZWiO0Swj90NdA_1756743009
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfd87a763so46602616d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743008; x=1757347808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay5gC/rJKyMKcqoVVau41lZbwoCz+kjLe1Ep7vUjxrI=;
        b=TQ2P0bOGdEC5qJysL3l13EuCs1GOERN6PF5fTg89FnKZaV38F8dXaMeTDgy9G40NW3
         eDMigY+N9oF5LHrzAw+oBrijtR9XhP7FcM2gHoJ/66pNSOlX7Mifq7IJ1yyR2UsQ9yns
         0wcDERu/I/XisvZHQ5a46Uw/naBHqNzuhL+qJsNNz1+sU6Ol3Pp01vpe2syCpbQj/weI
         28A+cVKv53SKQyjHtJniET4hz9e+ZGNCn9mZhAAvkdUH1uqnNzUvPNL5yjjl8X3qhjYo
         YeikIoVyVPANVDhmqwyZlocDTUAkOW45u8s9tXaEdMz4Q5a9XRcr4P2QXnGNmLtScBrS
         9DfQ==
X-Gm-Message-State: AOJu0YwQTtKuvfHr61Vy8sfmTtd/omnLC/Wbv0WQyExHY+cG8Eif9oVK
	P4qcGaY62M7AP2kZpaufecFOqtUCTtONAyhc6NppaachM/B7ma17ldqjHLJtkdxGvgdvDz6A1xW
	LyJxVtTTUOuU1luEMfk0SEY5or4m0LAebULNbqFq5/XHQYfQplxH2CHqWbxYFumPRoN/Ck+BhUl
	fpERWGQjwUv9x3u3Wya1VdHZRk6I+1ELYU3TVEau8C6rfvPP/KOw==
X-Gm-Gg: ASbGncs7P5P8y4x6Q8CsSPzIAy76kM0MqQJZsYmYPiAuwwRXa/zGfDBchT2zAV9hzIt
	otVN/+Ey6Db+QVd1sNGYOLkY3R4kRVRl/UUEovCPXvAkY1Ln+KqjeKoD0l8MarwZAYQWKDeYtFg
	Cp6e+lHUb0fdnIMqlxYybv2mcrfl+u7Bc1DbcgGHlwFX8JJqP2JEHcv7DTqX/V/0t3ez8U704XJ
	KOI/6ohdLdj6pTflh9gz/wd1p14xq5QTJtuktKw/u1KYUzPQeM+71kpyeNFaviMRdEDYDfoG/RK
	Ub4Dw4h/6UANiwfRojuvQHnrEjhC9uFhbRj1ya6mFTUD02swMX/7je5MaJVHn1r+CIdFZvBjtBi
	zv0fn16JtEdj/pxTpcyxjC84qokGXrUwQoiWOzVWEA0HsG326ARaO/kapniRsYshxnNwS
X-Received: by 2002:a05:6214:5195:b0:70f:5a6d:a253 with SMTP id 6a1803df08f44-70fac8db3c8mr75709036d6.49.1756743008454;
        Mon, 01 Sep 2025 09:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUuYwiXfYyBhb47Z0hN01SMvdEEJPNPj4R4dXKcCWUWWe/rDi3MWAMqA91oA+pVPmIsSEo7A==
X-Received: by 2002:a05:6214:5195:b0:70f:5a6d:a253 with SMTP id 6a1803df08f44-70fac8db3c8mr75708306d6.49.1756743007561;
        Mon, 01 Sep 2025 09:10:07 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb283781asm42015296d6.38.2025.09.01.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:10:06 -0700 (PDT)
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
Subject: [PATCH 7/7] KVM: TDX: Explicitly do WBINVD when no more TDX SEAMCALLs
Date: Mon,  1 Sep 2025 18:09:30 +0200
Message-ID: <20250901160930.1785244-8-pbonzini@redhat.com>
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

On TDX platforms, during kexec, the kernel needs to make sure there
are no dirty cachelines of TDX private memory before booting to the new
kernel to avoid silent memory corruption to the new kernel.

To do this, the kernel has a percpu boolean to indicate whether the
cache of a CPU may be in incoherent state.  During kexec, namely in
stop_this_cpu(), the kernel does WBINVD if that percpu boolean is true.
TDX turns on that percpu boolean on a CPU when the kernel does SEAMCALL,
Thus making sure the cache will be flushed during kexec.

However, kexec has a race condition that, while remaining extremely rare,
would be more likely in the presence of a relatively long operation such
as WBINVD.

In particular, the kexec-ing CPU invokes native_stop_other_cpus()
to stop all remote CPUs before booting to the new kernel.
native_stop_other_cpus() then sends a REBOOT vector IPI to remote CPUs
and waits for them to stop; if that times out, it also sends NMIs to the
still-alive CPUs and waits again for them to stop.  If the race happens,
kexec proceeds before all CPUs have processed the NMI and stopped[1],
and the system hangs.

But after tdx_disable_virtualization_cpu(), no more TDX activity
can happen on this cpu.  When kexec is enabled, flush the cache
explicitly at that point; this moves the WBINVD to an earlier stage than
stop_this_cpus(), avoiding a possibly lengthy operation at a time where
it could cause this race.

[1] https://lore.kernel.org/kvm/b963fcd60abe26c7ec5dc20b42f1a2ebbcc72397.1750934177.git.kai.huang@intel.com/

Signed-off-by: Kai Huang <kai.huang@intel.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
[Make the new function a stub for !CONFIG_KEXEC_CORE. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/tdx.h  |  6 ++++++
 arch/x86/kvm/vmx/tdx.c      | 10 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c178360c1fb1..6120461bd5ff 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -228,5 +228,11 @@ static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
+#ifdef CONFIG_KEXEC_CORE
+void tdx_cpu_flush_cache_for_kexec(void);
+#else
+static inline void tdx_cpu_flush_cache_for_kexec(void) { }
+#endif
+
 #endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f457b2e578b2..04b6d332c1af 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -423,6 +423,16 @@ void tdx_disable_virtualization_cpu(void)
 		tdx_flush_vp(&arg);
 	}
 	local_irq_restore(flags);
+
+	/*
+	 * Flush cache now if kexec is possible: this is necessary to avoid
+	 * having dirty private memory cachelines when the new kernel boots,
+	 * but WBINVD is a relatively expensive operation and doing it during
+	 * kexec can exacerbate races in native_stop_other_cpus().  Do it
+	 * now, since this is a safe moment and there is going to be no more
+	 * TDX activity on this CPU from this point on.
+	 */
+	tdx_cpu_flush_cache_for_kexec();
 }
 
 #define TDX_SEAMCALL_RETRIES 10000
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2abf53ed59c8..330b560313af 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1872,3 +1872,22 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
+
+#ifdef CONFIG_KEXEC_CORE
+void tdx_cpu_flush_cache_for_kexec(void)
+{
+	lockdep_assert_preemption_disabled();
+
+	if (!this_cpu_read(cache_state_incoherent))
+		return;
+
+	/*
+	 * Private memory cachelines need to be clean at the time of
+	 * kexec.  Write them back now, as the caller promises that
+	 * there should be no more SEAMCALLs on this CPU.
+	 */
+	wbinvd();
+	this_cpu_write(cache_state_incoherent, false);
+}
+EXPORT_SYMBOL_GPL(tdx_cpu_flush_cache_for_kexec);
+#endif
-- 
2.51.0


