Return-Path: <linux-kernel+bounces-865940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A5BFE607
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C03719C0DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F13081BA;
	Wed, 22 Oct 2025 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4UrDUtl"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB9306482
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170897; cv=none; b=YHXoc3KCggJNTbVLn5/kK4DDIeMwznGVRog2bKZYcC8uGHZq59bFoWRmeZgs3pRwTNudOteScIUi/VWfmwfrCjd1tleEDiTSS+y2sl2l4fjCzciO/xqzFfdnjubbGwHodj0jayQqzpfxfW2ecCCExxq1zlxNnTWMtErl4xvb7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170897; c=relaxed/simple;
	bh=hgK4ZyjIlpLLpNf4A/qHlbcpqbD01T3yYuUDE1RHxFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQi2cyjPiIcPoaGaJ9JpY1j4QczlGmKuAacagheRmwdawEZhIqC5bpT5GKv0p6ngy2SeJy6fxxopPnu0ZIK2LzoPXnulxcfN0mfG1dXyeRZF0jWpDe7Y9lkx2pfg6zbjMZxAaMxVuyHzNAK1hZacVn5Ns3+3vn2cbSAm2trhtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4UrDUtl; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7832691f86cso1130337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170894; x=1761775694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cljSmvm7imXLVfH8+LGI0uPDnsbUZPSnwmJJbFS4AAA=;
        b=O4UrDUtlU1lljBpVfGtFXJF6SLMAvyxo93awKg1eyxyGFADo8N0FKFqv1WmiYtQZYu
         L4WBkNrAY7lWn59BC9DepDNPGHknMLDyOnwaI7TiTbjl8fTlqbE6LvkVKRbWxQ6JCRIV
         keteJBm+jxr9jXDimF1yO2000329guAUQDFq7QQlHNS5jajJ3bmhC9l0HodYa2ab2J1W
         ud6UA4UXQU5wD29FUZuyS7eIj5M3K99vNFP2PD/pvt4hYnRbEjNN0sLAlTAG0cn6fsqk
         ovgsDna2+qeszS3NXdhJrei/Gvt+O8EbIZ6bKdlDj5GS10tf/Bd0dZz/b+7wCMjLYOFu
         VJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170894; x=1761775694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cljSmvm7imXLVfH8+LGI0uPDnsbUZPSnwmJJbFS4AAA=;
        b=MAFWB8eLlIPkhSCCh4xxbv5O8SJHaY/eWBJdMVGT+VStq1hrGeCANKB4HQ28YUpy8s
         pF/RoaDt4EobPohzEm7N3apizXXVtr+Xost3ZPj5rW8tU0w/yGf+Q0a5/9fg40+futxC
         99io8UChnAB8uCsfGGp0av6cW7SVVKRvLGiyvhFwkm3toohusN6eKzY+XY5cjLdWvUtz
         1A1W0INOjyIoOz0323kkMEwnThToIQaPk3wmQeCndYW7vD+IoMcaOKidqwcA5G/R5dRa
         MzKaA4nXzRERVJrtO666Huy3dWqWZ5utI7ZjptRV9decw0M8ehZFRm7y+vyKPuND2KxV
         pXkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9mIG8rjK5ICz0lKNo6ZhNig/BlEXiIUt1zWY+OJL0dsQCBCHU3/rfbmBuLba64KsMmvtTsWfFLrW0NeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6cNNdLdbKtVsO+RNeEixkAFtgwYZBMQ8iDvLiSJAd/m4z+Kq
	yZ2ZCa4GfqDY1SOFJfUFZaGJB1RHFPI8Lrnn0QRY9Q/AtgnNtNpIQHx/
X-Gm-Gg: ASbGncsJbaPQQhK6yjGBWN3JhJlKz7dY2RUf24X3NtklNahwazCdL/Brk6pRCyYfoC6
	0ZqhMJZTaUvuB3rDF4UNCbIKuFrHtTSPfQsJzlHi1wwFKszle9toMUaYGEJMqqmZaTF8a5w9qFR
	Gz6ZbbbQQ26BSV9k5lKGXwjWRszKM1TKzNSIkKMZZWOxKA0oUALkq1yy2RvZfF+wOKmSaXObCbN
	/mNke8agZPSGbBRZ1pBXR566r7Kjtvwh8IIQcQCCdpoPcGilndAyHUOG0cjG7tKxNWx1npde+/w
	zFZM4C9gbdMpd2v7I+7/X+EeSYIooIHqlVg4w6iNd3y+LMcQFc2Uqk1nP6dU0VBcPsTcsILh8GJ
	Id3nkJMwdTtJB+Azvup+yvPa+rKvVndoYdqzrXmdihZVHPv/nnQOYLEk24Dx76e7GTUN1G+Bu4t
	4P4jE1/X39HmCH2NzlH9/8
X-Google-Smtp-Source: AGHT+IG5DaDz89NnOFYH9AOfsG7HIpnA6jy+K4yFRLLQv4tWHTS94dl5py683yKDSVSPEsJZaroYgg==
X-Received: by 2002:a05:690c:46c9:b0:729:62ec:9185 with SMTP id 00721157ae682-7836d664f75mr195039327b3.39.1761170894044;
        Wed, 22 Oct 2025 15:08:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6c5974sm1212257b3.30.2025.10.22.15.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:08:13 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH 2/3] efi/libstub: Fix page table access in 5-level to 4-level paging transition
Date: Wed, 22 Oct 2025 23:06:26 +0100
Message-ID: <20251022220755.1026144-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022220755.1026144-1-usamaarif642@gmail.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3
and applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on
  x86_64 includes not just the physical address but also flags Bits
  above the physical address width of the system (i.e. above
  __PHYSICAL_MASK_SHIFT) are also not masked.
- The pgd value is masked by PAGE_SIZE which doesn't take into account
  the higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:
- read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption bit
  and extracting only the physical address portion.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).

Fixes: cb1c9e02b0c1 ("x86/efistub: Perform 4/5 level paging switch from the stub")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 drivers/firmware/efi/libstub/x86-5lvl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index f1c5fb45d5f7c..34b72da457487 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -81,8 +81,11 @@ void efi_5level_switch(void)
 		new_cr3 = memset(pgt, 0, PAGE_SIZE);
 		new_cr3[0] = (u64)cr3 | _PAGE_TABLE_NOENC;
 	} else {
+		pgd_t *pgdp;
+
+		pgdp = (pgd_t *)read_cr3_pa();
 		/* take the new root table pointer from the current entry #0 */
-		new_cr3 = (u64 *)(cr3[0] & PAGE_MASK);
+		new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
 
 		/* copy the new root table if it is not 32-bit addressable */
 		if ((u64)new_cr3 > U32_MAX)
-- 
2.47.3


