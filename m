Return-Path: <linux-kernel+bounces-778100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF9B2E169
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A283AB47C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16512E2289;
	Wed, 20 Aug 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBofuw0D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFCC2C08BD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704369; cv=none; b=cgvaFwsl6YITbykZYYjJUlCFe4ynBtnlucH84tq1yzosaYhvMjb0dYYW63jg80BRFP2tnFOSiDf7ZIAKsrVt9D5244Uac4cA3l2NVRqRtd+Zd3C/5ywv2uNJM4FDtUG/jIj53yp4FSaSi2iUvhSnBj9IkF3i/mWZYxn7Ys0Fcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704369; c=relaxed/simple;
	bh=IvLuAMbGF6xQLJ5ql1gfNtRz2g8mFIjX7Hgkp/4O3c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2aADNVZW9KecaOm9oS2TLXTcT4dTkdAY3GnyOmu4FbrwYDW0E4i4VoXQj5Cz1WAQHk4SIgUwWyuc6HhbNfSf0+kaAIc84XONd/VyuVqqhv9uFPiFAKt4XHQqUqoF7uIHLI4C+r3xF77cXG2eaGlWiwDloN4fDvWZqWDKTYKwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBofuw0D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755704366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6SizlEr7nZ6f2rcrTKtvoIk4ZQIE1Em8ZxlkzA4Pua4=;
	b=FBofuw0DxeevQOg6SfzihCBZHJSeLzbojguLRdoy+qx4519UyHs4rcmbEsRAnD/T1bIhWd
	vQUrr0Dmjf5T/UjJSaIRLYm0kZhTbHF4EZgQsjYU7d2XMeKZpxZpXBXjfTkrrd4GpYM8b4
	AaroGYDFNPhodeibnZZngvhlZRMWET4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-bVwcThNCPO6BuVQYEh0cxA-1; Wed, 20 Aug 2025 11:39:24 -0400
X-MC-Unique: bVwcThNCPO6BuVQYEh0cxA-1
X-Mimecast-MFC-AGG-ID: bVwcThNCPO6BuVQYEh0cxA_1755704364
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso25446855e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704364; x=1756309164;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SizlEr7nZ6f2rcrTKtvoIk4ZQIE1Em8ZxlkzA4Pua4=;
        b=Ej8L36ts6oro+tPxDMWaWfbS79f2WH7cQo3KeukVFJVTlNIBijFxJgK3wNBEnTDWxF
         53hStn0vS3Dhz0xKjQSaZtyk79zcjQObemJgEg8u5DDiS80aw3wN1dgbbuBOKONpV6q5
         cqG7n8oJ14C/KtpzI3ddn8VwE6/qRcHYyKH/MEEBLnq7fJLA4Jp0ta57JQL7L6BV2QBQ
         l3oOonKDy3Y7isvs1CqBHGZw+YPYOMJ4EZzfkL4IDQlgn4dvPfLHaZaqbYBO5af/9gAL
         oeQlDYwn6uycB0PyhWozbY+6LJe3QhzqK8pyI2AWVYj6JdCyhWeH4gwruLzPvnb5A3OF
         W9vA==
X-Forwarded-Encrypted: i=1; AJvYcCXvon294pLR2D9jmFghJSHK1KZ9S9+3dcLgTlbIjlZHqpouj6bHM2ZaTypCiUfJdDicip35GKh9pzj+q2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73M3OmK88juZAjT5yto4/keJmTEN0d20u131R5CopmMcwkq3I
	m+dEXdmO8WChH2kqN/EF/OoJkQdTtFgCUyJ7GLp8H81ed5lo82o6vRLCQi/kV32I/rQDpY7feHB
	Qjrof6UNvIjqDtXy7vNJ5C/VDGHwf/xvp+VuPPFmsRiPe0l2N4CPqLEFLeBkk7U0c4g==
X-Gm-Gg: ASbGncuKMLM+U8rnmnnWHJBw+FCrR3uKue0idmMoHuMlAlwkmCpyffeGSl1CYYtqDE3
	JUxu5VmJkiStDc+rXGPTYHqvm8G9wP20WiS4xHAqLPAPKzvVfznPkVaYo25NBHuvsZcFPlWujy/
	DKU9UcxSCvl1Q3oJFahNRinvnDr6ZdzcEhSZfuCl6hS7F9NRt1Ht6G4jLK4h3GgBmC3qPR2qat4
	f7MmahSRzZ3O2vq77b2G3epazjn4zMEO5Wxx43PECDzO22ZX+O3k//rNUjUNuLXHFCMcWBN/hDD
	0Ul6K7zQqCNnxeUsW4WRpiFJvLOhf4H5ahY+viLx
X-Received: by 2002:a05:600c:1c97:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-45b4a301211mr16172735e9.1.1755704363574;
        Wed, 20 Aug 2025 08:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbSZXWmjc6XjJWl1vE3O4XmhwNTrMEzlnncfnE2y34isrIF83ExbTktBudNvVEvNkbA2zAw==
X-Received: by 2002:a05:600c:1c97:b0:458:bc58:850c with SMTP id 5b1f17b1804b1-45b4a301211mr16172415e9.1.1755704363119;
        Wed, 20 Aug 2025 08:39:23 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.169.94])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b47c8e98dsm40212765e9.14.2025.08.20.08.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 08:39:22 -0700 (PDT)
Message-ID: <42009813-2a68-4147-b863-5a3f5ef7b85d@redhat.com>
Date: Wed, 20 Aug 2025 17:39:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] KVM: TDX: Explicitly do WBINVD when no more TDX
 SEAMCALLs
To: "Huang, Kai" <kai.huang@intel.com>, "seanjc@google.com"
 <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 "Hansen, Dave" <dave.hansen@intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "sagis@google.com" <sagis@google.com>, "Chen, Farrah"
 <farrah.chen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
 "Gao, Chao" <chao.gao@intel.com>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>
References: <cover.1755126788.git.kai.huang@intel.com>
 <d8993692714829a2b1671412cdd684781c43d54a.1755126788.git.kai.huang@intel.com>
 <aJ3qhtzwHIRPrLK7@google.com>
 <ebd8132d5c0d4b1994802028a2bef01bd45e62a2.camel@intel.com>
 <aJ4kWcuyNIpCnaXE@google.com>
 <d2e33db367b503dde2f342de3cedb3b8fa29cc42.camel@intel.com>
 <aJ5vz33PCCqtScJa@google.com>
 <f5101cfa773a5dd89dd40ff9023024f4782b8123.camel@intel.com>
 <acbcfc16-6ccc-4aa8-8975-b33caf36b65f@redhat.com>
 <a418f9758b5817c70f7345c59111b9e78c0deede.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <a418f9758b5817c70f7345c59111b9e78c0deede.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 23:53, Huang, Kai wrote:
> If we want to test CONFIG_KEXEC_CORE in tdx_cpu_flush_cache_for_kexec(),
> then it would be a little bit weird that why we don't test it in other
> places, e.g., when setting up the boolean.  Testing it in all places would
> make the code unnecessarily long and harder to read.

I agree about not checking everywhere.  But I think this is a good
compromise too if v6 is not acceptable as is (and as far as I am
concerned, it would be):

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e9a213582f03..913199b1954b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -217,7 +217,6 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, u64 level, u64 *ext_err1, u6
  u64 tdh_phymem_cache_wb(bool resume);
  u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
  u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
-void tdx_cpu_flush_cache(void);
  #else
  static inline void tdx_init(void) { }
  static inline int tdx_cpu_enable(void) { return -ENODEV; }
@@ -225,8 +224,13 @@ static inline int tdx_enable(void)  { return -ENODEV; }
  static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
  static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
  static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
-static inline void tdx_cpu_flush_cache(void) { }
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
index 93477233baae..376d49ef4472 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -453,7 +453,7 @@ void tdx_disable_virtualization_cpu(void)
  	 * remote CPUs to stop them.  Doing WBINVD in stop_this_cpu()
  	 * could potentially increase the possibility of the "race".
  	 */
-	tdx_cpu_flush_cache();
+	tdx_cpu_flush_cache_for_kexec();
  }
  
  #define TDX_SEAMCALL_RETRIES 10000
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c26e2e07ff6b..cd2a36dbbfc5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1871,7 +1871,8 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
  }
  EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
  
-void tdx_cpu_flush_cache(void)
+#ifdef CONFIG_KEXEC_CORE
+void tdx_cpu_flush_cache_for_kexec(void)
  {
  	lockdep_assert_preemption_disabled();
  
@@ -1881,4 +1881,5 @@ void tdx_cpu_flush_cache(void)
  	wbinvd();
  	this_cpu_write(cache_state_incoherent, false);
  }
-EXPORT_SYMBOL_GPL(tdx_cpu_flush_cache);
+EXPORT_SYMBOL_GPL(tdx_cpu_flush_cache_for_kexec);
+#endif


It solves pretty much all the objections that Sean had, in one fell
swoop.  The name clearly references kexec, it's stubbed out if not
in use, and it's not anymore unnecessarily under CONFIG_INTEL_TDX_HOST.

Paolo


