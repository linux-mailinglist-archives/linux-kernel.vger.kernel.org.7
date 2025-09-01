Return-Path: <linux-kernel+bounces-795025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A9B3EBF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADFA1736DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5372EC0A7;
	Mon,  1 Sep 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJBD4gII"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683C2E6CA3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743009; cv=none; b=EqXwyeTzpZCWcAAGnp74NlkQ1v8B1DwQlzT1zv8e1q2rwUNTph1Oc9IqIhKgsIOpmpFjc9zFXqedPJx6USgWkuhww62jIvZ5rkbSiKXQZeez7NGHWh8EoGkXBpu/H/r1MnTVDo0mPrLboHUqvQ6oZCYjpIhONy93USYV4bKeM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743009; c=relaxed/simple;
	bh=j6vAFM4b+QjRpby8SIZgqTZ2iRbpFgSXYQUKj1TwaXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIVeo/2fNVMP1D/1KMeq09T8Sa4ZrbFbyHGciO4WG178pSMw66S8kWrjjHK1CXTfvI/3bu3pxsyN2hcay+9FazcQ7s/CNX7uSepAbfkSkEBMRYj7qYMgGa9/7k3jN8cPiy5TvE/wOiDBUDBZztnjh81nWMxDUMM5TbZWFoDeyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJBD4gII; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756743006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dtdq00SxSPn8DNlbTBMbLDu8kopEQRB52XTmsM+6vew=;
	b=GJBD4gIIcgxs+eYtWCDkjb2qIPyjc/RzEU7VF4FNOsmBPizlZcKDiGkehFqkCk3dKfqzgn
	ZxMNwi8k0xJD0WTn52K6zm2pkyyLE7ybPqMhig77uzjDzAbyyDK0AQf73Eocc7fXwzm4wg
	jpsPakbksN3ZScVRlXJQmt/7spgvRvY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-RObLf88QMsSqecvAPs8a5g-1; Mon, 01 Sep 2025 12:10:05 -0400
X-MC-Unique: RObLf88QMsSqecvAPs8a5g-1
X-Mimecast-MFC-AGG-ID: RObLf88QMsSqecvAPs8a5g_1756743004
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70f9ef271a4so52269806d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743004; x=1757347804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dtdq00SxSPn8DNlbTBMbLDu8kopEQRB52XTmsM+6vew=;
        b=QP6JCC5Ya4I9JIP2SKERdG0yRQgTyjrPYeDK51pEHMX5C4PGOW31VWGvAJf6Vl4ZkD
         5U7gzdgUegCjuGLitLFSheUSIN3UBG4rkQxzUkptD6116TW4XvYT5BBxDFc8QEhabVhf
         F73j5Kc3MHeptPpYCXplBDQ4brIMcV3OwGnCiaYJWTOhOaYog2mhjE9reFL8qMtDlCUm
         6o5DP+4uCdbUiASIxP08z75pPDYa2bZjOxBz1Ni0FAWudKMUB3V6KIbJf9daBQ4H+cC9
         9N/joARuNLZoU9yA3QypFYUzEEQ/Iz1GmP8e4WNdUFNyFN+q866MCRruJiLddzT8mpMd
         MLUg==
X-Gm-Message-State: AOJu0YyHreU3BXTf9D9CiKzBJjeEeVFrpG643QrbumB1FV4cPlKD3wN/
	Oo+cUw7oCTK538H/uoYpxY9UMzFCfSjVf+qgtA2buGMxSlJAigCoMbxo+l6SgyMiMCQ5QEt5rz/
	X7Wl/8tkSTOytaAFhNb6fW4aYfjS/m9ShTjKjijLlHN/F1vaLBYR0e8b5B1NvzgVh868i8fe9Cx
	1g3O/35YR+hdqKPwV4Bc7njCF69NZp4+DxsZfTwHxU+SlLKyPFLA==
X-Gm-Gg: ASbGncsCvzKPwaxWFsEvqfM8eRnwy2h1Ytw1tbnvDV/LqJfFdToBByhWr4PZZ0xeV9j
	kpozJ1BEm0YRug5UMzsI/zPHVx1zvtNpCzm6QiMAh6AEQuxV6WCUDwQLinMLrCXzlT4oTLERFOq
	k/HBhCHET1bcRPTLEJFZ90DbJVzNPxhwfjnCF9vu4CHNuScdEZqbRtc3iwWzFzgNranPf50lL24
	DKtQcndxAGo7W86puGW9tYw86GBSsvFEdxoJu23nLrcVeESJkwRxdYmzAGVXXIW9KFysvVe0lbW
	dsEEAbP792sYgMQzzFh2OyyaGK7Tt4/oW0G3boQvT6H0uoHhDiUXVY2+WWVpP60StlbUzIMNeWW
	DjLPoB97cgn+t8IA/Dr4Zq7AxcI5DVBvVXKtnDLipsuiW/z5MQflFerQDZUnvjQbw5caM
X-Received: by 2002:ad4:55f0:0:b0:70f:abbb:609a with SMTP id 6a1803df08f44-70fabbb65f3mr84998806d6.19.1756743003657;
        Mon, 01 Sep 2025 09:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ZhmrDjiVHmX4k410H1KEfDTJpsrmWdSsgPge/0tAl2l7w6yZq46ZoMj1qfypUN8EaSKecw==
X-Received: by 2002:ad4:55f0:0:b0:70f:abbb:609a with SMTP id 6a1803df08f44-70fabbb65f3mr84997956d6.19.1756743002916;
        Mon, 01 Sep 2025 09:10:02 -0700 (PDT)
Received: from [10.201.49.111] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb2837f9esm41837066d6.48.2025.09.01.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:10:02 -0700 (PDT)
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
Subject: [PATCH 6/7] x86/virt/tdx: Update the kexec section in the TDX documentation
Date: Mon,  1 Sep 2025 18:09:29 +0200
Message-ID: <20250901160930.1785244-7-pbonzini@redhat.com>
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

TDX host kernel now supports kexec/kdump.  Update the documentation to
reflect that.

Opportunistically, remove the parentheses in "Kexec()" and move this
section under the "Erratum" section because the updated "Kexec" section
now refers to that erratum.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/arch/x86/tdx.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index 719043cd8b46..61670e7df2f7 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -142,13 +142,6 @@ but depends on the BIOS to behave correctly.
 Note TDX works with CPU logical online/offline, thus the kernel still
 allows to offline logical CPU and online it again.
 
-Kexec()
-~~~~~~~
-
-TDX host support currently lacks the ability to handle kexec.  For
-simplicity only one of them can be enabled in the Kconfig.  This will be
-fixed in the future.
-
 Erratum
 ~~~~~~~
 
@@ -171,6 +164,13 @@ If the platform has such erratum, the kernel prints additional message in
 machine check handler to tell user the machine check may be caused by
 kernel bug on TDX private memory.
 
+Kexec
+~~~~~~~
+
+Currently kexec doesn't work on the TDX platforms with the aforementioned
+erratum.  It fails when loading the kexec kernel image.  Otherwise it
+works normally.
+
 Interaction vs S3 and deeper states
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.51.0


