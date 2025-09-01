Return-Path: <linux-kernel+bounces-795023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161ECB3EBF0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFEF202397
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB093064A0;
	Mon,  1 Sep 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1COYYbn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE653064AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742999; cv=none; b=fDRI0wnKT1JRhwIn05V4TLOeowI/4hahRrpu5VyTYZJhTbu52haLfqK89iawddilcJCyjDm6zopKnUZ053vVDBhmrAhh8o0NNATpCTVvu+YUD6Ps+x4U/qdDbpwzjCExB0d9YXl0/EQCIymbEUDCwJWdEEDpQYXXltOsoAnCpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742999; c=relaxed/simple;
	bh=Q3PKDbHD38isJx3I8Ber0baejrO6TVXVWQsXQu3Gx6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWEgI2VpjyQtHf/7V4rRVQIIdmD4ucNc/cgmmNRKs2F6Wr3C5HwB99Ar9ljP/CBxbPRlYEKxTX2WgvvX9B7srvUNnPXRU9DsiccY3Uas2yJY1yKuIg5SDY91YqFi6lXei5GJfqwYpAmCSd+QqjB8hzJT6siXFOJuXL9bCsyZd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1COYYbn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756742996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUjmNo6Stszk1jMfX7esmLkjaDgZtcc668a9zyeu+wg=;
	b=J1COYYbnQbOmL8Z+2KKLVbZMq36JM3Ot6Mrr/QLEZDNqYhxpYS74BxSkrl0be5A3FQp/Uw
	c0Ryavm9JNkV5DTf/XhVdpoatl3Hl2S54DMkNfkn8Wkf/hIBPJBi+wwkqGiRNmhvP5hKS8
	vxnZwPiewEVKSuTXJG0S+/jeAOKfgTA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-iCDlmBNNPRul0qNg695MGw-1; Mon, 01 Sep 2025 12:09:55 -0400
X-MC-Unique: iCDlmBNNPRul0qNg695MGw-1
X-Mimecast-MFC-AGG-ID: iCDlmBNNPRul0qNg695MGw_1756742995
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b311db2c76so10972271cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756742994; x=1757347794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUjmNo6Stszk1jMfX7esmLkjaDgZtcc668a9zyeu+wg=;
        b=C1lBTALZb6xyz2lT8W+itftU8VWqoEKlyS94xAlGSzgL8lNKwp1RxpO60XLlzye6zm
         f0gpfZI1Ff2CtfUx0Ehf1hUR3TYm+9MqW68D/lhRGFHN8CghRxxyPPDpE0YgoSmGfLdA
         Y0gGNKuZdy34+4M5qhatl9ivzuwqaPiX0ioZkisolYnR6ztJYSZnu7Yj54TH/ZtrvTgq
         AkqQfEV+Z4VAwgu65ZN72b908LpoRQ0WYaSgwL2/tLKYroEdL9JUo28g2FxecX7o4n+P
         nh6gJ2Xbyo+VlvnvSKkEQPRg1j1jQZLLo807m+65M+AbxdTRDF7DCnVbCF/vOuyDdj2F
         /uDw==
X-Gm-Message-State: AOJu0YyCpopypHjZagOEjLX5vK6GC/AwUJkXe9xr3jXoV1qfRNeodl0U
	5rEaghsb83fhOaFkPh5spvMIHbOLsvozFdH42hBIPCMEdtz3w7q051hw4iGtpufviIDvWEB1w7J
	H4V+TZfCy+F4zqwAMZqFuDsgAw4TobUdXs/xwDIELG5sd0Rk23nVCzcr6YGMtsJ7k4mhmiQvToi
	B/l8H18faHY8U+kZablZLpbycuGCoNUwmlN8TghoEVJVhzYavNWA==
X-Gm-Gg: ASbGncuNGkjHscteaEHL32ltPyBSr2LymAoH/cbDGJlvmFh7ZM/iqbyKWi+J1Ysgq4s
	S9/2x1WxcZdNyokjcOiWFB8MYnMEx7bYrHWMgJJMlgUIDb2iUJ4GId2Q2KdRjHVSf28aW8fPgck
	6B8ayXZF4PF/67Iw/9sN3nV0J220Xi2f9Ujjple+AGBMn36pYn4OyMMW79FgrWH1uedHYfPjnfb
	j0Jkx+WRknfsRsU+7GW+hKkYzJ5dR4PyYeEAbWtvG2S2w8+lKyzg+0oN8e+c9opaesSI5HDTnFS
	IVp8Pf4NgIxWv+XrxWazJy8WWvKI27/Z6AKC9o09tmEHUlLOms7HLPWHP5L2SJoHHOw+FZ2nT0z
	SpUxRh/YvctnMPtkPapnpgTu6Ot5jqaWB9JcpnfG2DzKy9JIBiZin/fX8vD8YkCOIo/UY
X-Received: by 2002:a05:622a:2cb:b0:4b3:d28:c96 with SMTP id d75a77b69052e-4b31d7f062emr105567981cf.13.1756742994202;
        Mon, 01 Sep 2025 09:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0H+Me2WNr8OP1G6r+ikLDYpI0KnL49DOiTcekuqb2wap6IvnGdRHVwSMHQzA8c3JlD+sHkA==
X-Received: by 2002:a05:622a:2cb:b0:4b3:d28:c96 with SMTP id d75a77b69052e-4b31d7f062emr105567311cf.13.1756742993721;
        Mon, 01 Sep 2025 09:09:53 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1643ac5esm681629485a.68.2025.09.01.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:09:53 -0700 (PDT)
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
	farrah.chen@intel.com,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH 4/7] x86/kexec: Disable kexec/kdump on platforms with TDX partial write erratum
Date: Mon,  1 Sep 2025 18:09:27 +0200
Message-ID: <20250901160930.1785244-5-pbonzini@redhat.com>
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

Some early TDX-capable platforms have an erratum: A kernel partial
write (a write transaction of less than cacheline lands at memory
controller) to TDX private memory poisons that memory, and a subsequent
read triggers a machine check.

On those platforms, the old kernel must reset TDX private memory before
jumping to the new kernel, otherwise the new kernel may see unexpected
machine check.  Currently the kernel doesn't track which page is a TDX
private page.  For simplicity just fail kexec/kdump for those platforms.

Leverage the existing machine_kexec_prepare() to fail kexec/kdump by
adding the check of the presence of the TDX erratum (which is only
checked for if the kernel is built with TDX host support).  This rejects
kexec/kdump when the kernel is loading the kexec/kdump kernel image.

The alternative is to reject kexec/kdump when the kernel is jumping to
the new kernel.  But for kexec this requires adding a new check (e.g.,
arch_kexec_allowed()) in the common code to fail kernel_kexec() at early
stage.  Kdump (crash_kexec()) needs similar check, but it's hard to
justify because crash_kexec() is not supposed to abort.

It's feasible to further relax this limitation, i.e., only fail kexec
when TDX is actually enabled by the kernel.  But this is still a half
measure compared to resetting TDX private memory so just do the simplest
thing for now.

The impact to userspace is the users will get an error when loading the
kexec/kdump kernel image:

  kexec_load failed: Operation not supported

This might be confusing to the users, thus also print the reason in the
dmesg:

  [..] kexec: Not allowed on platform with tdx_pw_mce bug.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 34c303a92eaf..201137b98fb8 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -347,6 +347,22 @@ int machine_kexec_prepare(struct kimage *image)
 	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	int result;
 
+	/*
+	 * Some early TDX-capable platforms have an erratum.  A kernel
+	 * partial write (a write transaction of less than cacheline
+	 * lands at memory controller) to TDX private memory poisons that
+	 * memory, and a subsequent read triggers a machine check.
+	 *
+	 * On those platforms the old kernel must reset TDX private
+	 * memory before jumping to the new kernel otherwise the new
+	 * kernel may see unexpected machine check.  For simplicity
+	 * just fail kexec/kdump on those platforms.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE)) {
+		pr_info_once("Not allowed on platform with tdx_pw_mce bug\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Setup the identity mapped 64bit page table */
 	result = init_pgtable(image, __pa(control_page));
 	if (result)
-- 
2.51.0


