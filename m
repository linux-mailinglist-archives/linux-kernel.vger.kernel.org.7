Return-Path: <linux-kernel+bounces-834131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FE2BA3F47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F171C01CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A92F60C0;
	Fri, 26 Sep 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iYM5KcYW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228AC19C553
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894724; cv=none; b=j2BA/8bSmm4dABDL08EAz7C85Io98a8ccARAiHwFzFMYrpYoqNpXLN7aFGWFNV8Kk7BZlxAkTUdoHdWFwxNF1m1hCDKdojbjF8QadkxdrfHzWpnxz0ofVrJAqzCooERPBqh/9pxrv/9BkThDLTGt+wmbjBvau5w+p9r2x8ZPVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894724; c=relaxed/simple;
	bh=1/AcT3Bc5vPs/LPilkpfToUOPoo+e1GCVcKYXLiJ3/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nW8ltGFVlcYrft4I89EsDScuXHkyBOdtdrDwY2Do1CrIXX806EvCgz74LoTsj3qQUW4aFvIDtoAN+RAMVgSTW9+l8UR0SVJaJjVPwgyWcZScg4piyUUJ66pT1RHWTu/4fyzRykRNLZiJwuKPuvw2ccaK6c8QvELcixWIxUVZQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iYM5KcYW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77dedf198d4so2817958b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758894722; x=1759499522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7jp8yLZxEobbpETqyfchAwVX2BSGTy6SZoafcKNw1g=;
        b=iYM5KcYWq1rw95VdkS3Grtnvv+decUgb5KXAijwT86y5yfJeSFXUBgVz72Yx20BaOg
         TPk0dv0NgW0odF65Rrh1vUNcofyVNM2m35tx0Y9lvOj7pGgnR+cfpIY6gDzPi9QTUXsq
         osmhIVlM0a0AEan7xRml9Jl6qwAw+P2GkJt6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894722; x=1759499522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7jp8yLZxEobbpETqyfchAwVX2BSGTy6SZoafcKNw1g=;
        b=fh6WMOKH9f58HcGmbyguabziVB2wpppM0q0c4DoutDDO/3TjoZQCte8xu2XmaIgoYv
         edRv5hMCFSTXNinnWlZd+WNTWRt0+iRlCOXCEwi7WAzwu3+5bJsssZyG30mGSTRtuKT6
         Up0oa2JTKjV6vkwJ62NBHyH1QDayG7NY1ArqyjHzY+5uFDVRiqDkAfv6yTf67mUNdeVB
         9ruQcONmpOG4amlltjlOnqtXDYmBScAXRm/bX1fjYKvkTaHF7yg6RNXY8UmiuHsPgQUv
         4iwDDROtM8+EdAFoodBEkpjj5ACpsEBXappoZQBjgs3IeiEeGUVhK+k1jMNYjTiCEOoQ
         pCmw==
X-Forwarded-Encrypted: i=1; AJvYcCW7EecQdqb9NWwVu23fRmWXoulVZKnGZHeDlWB3eFmFqvg73kWLUYPF9sWx/5LdDR2yMSoNzfAf8nH+Kac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU67xeNZUhOAMKX9QtLhCBWtXZ7yFsJ2z4KuNlxyt7u70lwUfm
	2Ajbe7KUFL5WeXerxxol4+7M2198Bp7Sq/Sn6cR8b1o4q9aKlbAlaW9PyBbyYadBBQ==
X-Gm-Gg: ASbGncu+j2f2pduvuNr8UELL59vcFvRUnl8k4eVUv931njew4fOm9PyAw+TgVn8eKf0
	qlocRkSeqDSiCsS1PSZ++ORbU671/rD9evvIYx6ssV9spmk6t/f4DPMiUrOAQ2ri4FSLzHucRN3
	+b0jHzNYrgh2xxiupRULlhPB376ivz1JiICdR2o+6vgOJqTR6xPWksqSnT1YtqxYFxiCUoHbCRE
	opzOXNbk7kQpiF3dHqiePu6agfdVrOurg71zYZwtjMkyA/ekpHt6pBGQbo+LA6jzyJtLq5xiFpo
	OnOu/I6a+lxV1lcEhX1LccYPYwnVa3U+PrQwedBJw5eeXyaqqZNkWVHgpVwp8z52yq5VaGMBnxX
	eXhJx0sGcCFyG+Jw/gx3m6Q==
X-Google-Smtp-Source: AGHT+IHkScieu2EQ5+BzeIwXjQ+6+pWTvDLXaL7ksD8U1FVF/quB9UFR7FpLBLPhA3BlkAgBp75jfQ==
X-Received: by 2002:a17:90a:be0b:b0:332:8133:b377 with SMTP id 98e67ed59e1d1-3342a280378mr8184201a91.15.1758894722418;
        Fri, 26 Sep 2025 06:52:02 -0700 (PDT)
Received: from dmaluka1.corp.google.com ([2a00:79e0:a:200:f83f:a8ff:c4f3:beb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-334352935d3sm2657143a91.3.2025.09.26.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:52:02 -0700 (PDT)
From: Dmytro Maluka <dmaluka@chromium.org>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Grzegorz Jaszczyk <jaszczyk@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Tomasz Nowicki <tnowicki@google.com>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH] KVM: x86/mmu: Skip MMIO SPTE invalidation if enable_mmio_caching=0
Date: Fri, 26 Sep 2025 15:51:39 +0200
Message-ID: <20250926135139.1597781-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If MMIO caching is disabled, there are no MMIO SPTEs to invalidate, so
the costly zapping of all pages is unnecessary even in the unlikely case
when the MMIO generation number has wrapped.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..bad613e8fa95 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7339,6 +7339,9 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 {
 	WARN_ON_ONCE(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS);
 
+	if (!enable_mmio_caching)
+		return;
+
 	gen &= MMIO_SPTE_GEN_MASK;
 
 	/*
-- 
2.51.0.536.g15c5d4f767-goog


