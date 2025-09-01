Return-Path: <linux-kernel+bounces-795019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB9B3EBE8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F832008F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE32E6CDF;
	Mon,  1 Sep 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFWu2fmi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6B2E6CA3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742980; cv=none; b=unjBed3NfvckCd6r3jZGhOU5ZwXFWFJItZylG9etJBK87aMUOeof5yhwD/WvTeY7uQxFZDZtTwuRP4axF9oe4Ck2HKxLqwEJ9ux8UwR0dzimnzXt3pywmAI7/a1qnmCY2jBDJ36gVLOzzAEalSGh1ej36e9/XlFs5+yPo7bvwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742980; c=relaxed/simple;
	bh=zuH01+UpwPD6uQfjMhilATGk1akMpM0cfutCtijrf20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RojDcZ6sffuBbiVazLvLPaRaPixBpP/SvKEx6az2lJlxPgVXFula0RQHO+LZPfpuXDovRmnS5kD1ymrWG8uZh6XBolzBlKbK2vlRu0wTN0qv2PiiwHXCfocqMcuRj470Ebw3wqe+YMF6Ui60lWub1qVx8UzjTu/Prp+Rgwz0rfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFWu2fmi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756742978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qUxQDVOQO7QvM97v0jkL71CCIdvm08KWkYVR9FcGA/c=;
	b=AFWu2fmiZLrCpLDgjniyIx4hEgZjo4bMa6tfivAdfaa+YdZTSANnS+4592uklTymMJmf67
	v7IgWL8XoTzeCzNx7SHEWncgKU7gIccBVE+r8UKha//+3UqxPwmfTv6K6bzS31FOVheUpW
	GbWa7Vt/qUALdJZkt50uDmEtOM6a2y8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-oC4NBYB7MDiC4X4rj4Tlig-1; Mon, 01 Sep 2025 12:09:37 -0400
X-MC-Unique: oC4NBYB7MDiC4X4rj4Tlig-1
X-Mimecast-MFC-AGG-ID: oC4NBYB7MDiC4X4rj4Tlig_1756742976
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfd87a763so46598336d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756742975; x=1757347775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUxQDVOQO7QvM97v0jkL71CCIdvm08KWkYVR9FcGA/c=;
        b=iWPnLLy3wRirhHnf0GZiSd9IMNKgcceIfmYZNa0Rg8Slom5haTHVaDPLXTp9zK7ljT
         +Q8zXNVzDm1pOMeqK3gQFQSUIeo1l0GITRgyE9DQ13RgW1H4nd/4YC7EMVSvxQMYlg7G
         bEx86eRbPnqTY41UDLkvUF8451t9jp53q/66TH9b/Cv3sekRee5sC6be3gfpdMl8cEZJ
         FIdJP+znCo52vBITm6+QWmtCGkjmIOlcws4kwS2ZX8Ph8sZFa4KQQaIGBQTvtFGyMkTY
         E7YaBiQJL+XI1S/ynl/WRah/YmXGthsUiYNqHgKUl123XRPPfGO+KZ1RO9RVafzwqScp
         rpEQ==
X-Gm-Message-State: AOJu0YyhgZmyGczDHlXd34Y1sRaNEAWSUclBl44Pdk+lnadRPaermPDV
	xQH2gYCBwyLIO3/8ykxPOl1epvLtXaQMBqTzuE78wKm77FsR+m3ip3C9f9wpahuplwgtH6eH5WC
	9+I5qbu/FvE4ri53pmhnm5YT/IFRoOBlxMN77C0YSRY46JsylsPHEf5Tp/sxpUDeQBUDWolyAXq
	WQt3eDWj+VxyQwIVtygxVkietxVhTOG+ucu9Uxv4EVkx7GsHWbpg==
X-Gm-Gg: ASbGncvOaq3sqHTmRYSNbpPuLh3dCllNYrse1gQIuvvEWMrIde8huk73Kflmx1d6CPC
	yNqmbIKz4ZFE3iokK8fAHTN50wVZnY9KDCNBs4QcPWttRT/TWGz0xvjlPX/8vCRdMaPT6AGk/Hg
	TgrZWGA1wmE8KXrWHMudyd9VrVEx/W4qnIsX6M4NXvzKBbzNVQKsrRqOkFA8cad/sBGSIstkIk1
	vJNQQ76/XiazpVeb5pnkfiYxxd7lQSkOI6sAwcoIGFFXhG+T7UdN/xko3ilw8X7fqUDpS2pyZwJ
	elkUtn5ENhFa4VzyCiv/SqfDiECyXiNV6tJJsflbbDojzyzSIcbfXKmM9Ho3pUdSaIOHaf9Ia27
	+e4Pmfh+udx2Fc6xuNVUoLKvagKJE+mnUfGx3XPzO9wkSwhbHMiLGvVotrR0SPZv9V1xe
X-Received: by 2002:ad4:5746:0:b0:70d:b541:8084 with SMTP id 6a1803df08f44-70fac89260bmr97925786d6.34.1756742975477;
        Mon, 01 Sep 2025 09:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI1Ixvv9KmfyodssHHyS8ameq0QtvIfGvGQZk2Ge7kf/hycu1G7Hr2lBrFcKsR5VeRyQhoZw==
X-Received: by 2002:ad4:5746:0:b0:70d:b541:8084 with SMTP id 6a1803df08f44-70fac89260bmr97925146d6.34.1756742974841;
        Mon, 01 Sep 2025 09:09:34 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb26484eesm41516466d6.33.2025.09.01.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:09:34 -0700 (PDT)
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
Subject: [PATCH v8 0/7] TDX host: kexec/kdump support
Date: Mon,  1 Sep 2025 18:09:23 +0200
Message-ID: <20250901160930.1785244-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kexec() support and TDX host are muturally exclusive in the
Kconfig.  This series adds the TDX host kexec support so that they can
be both enabled in Kconfig.

With this series, the user can kexec (including crash kdump) to the new
kernel at any time regardless of whether TDX has been enabled in the
first kernel.  One limitation is if the first kernel has ever enabled
TDX, for now the second kernel cannot use TDX.  This is the future work
in my TODO list.

This series should go in through the tip tree.

Thanks,

Paolo

v7->v8: stub out the new code when kexec is not enabled in the kernel.
	Of course even the smallest code change is subject to bikeshedding,
	and I chose my preferred color for the bikeshed.  But it's pastel
	green and I'm sure you'll agree that it's beautiful.


Kai Huang (7):
  x86/kexec: Consolidate relocate_kernel() function parameters
  x86/sme: Use percpu boolean to control WBINVD during kexec
  x86/virt/tdx: Mark memory cache state incoherent when making SEAMCALL
  x86/kexec: Disable kexec/kdump on platforms with TDX partial write
    erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency
  x86/virt/tdx: Update the kexec section in the TDX documentation
  KVM: TDX: Explicitly do WBINVD when no more TDX SEAMCALLs

 Documentation/arch/x86/tdx.rst       | 14 ++++-----
 arch/x86/Kconfig                     |  1 -
 arch/x86/include/asm/kexec.h         | 12 ++++++--
 arch/x86/include/asm/processor.h     |  2 ++
 arch/x86/include/asm/tdx.h           | 31 +++++++++++++++++++-
 arch/x86/kernel/cpu/amd.c            | 17 +++++++++++
 arch/x86/kernel/machine_kexec_64.c   | 44 ++++++++++++++++++++++------
 arch/x86/kernel/process.c            | 24 +++++++--------
 arch/x86/kernel/relocate_kernel_64.S | 36 +++++++++++++++--------
 arch/x86/kvm/vmx/tdx.c               | 10 +++++++
 arch/x86/virt/vmx/tdx/tdx.c          | 23 +++++++++++++--
 11 files changed, 167 insertions(+), 47 deletions(-)

-- 
2.51.0


