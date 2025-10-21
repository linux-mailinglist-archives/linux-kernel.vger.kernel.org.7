Return-Path: <linux-kernel+bounces-862585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED90BF5B09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D24E34FCFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069D328B68;
	Tue, 21 Oct 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9yWX3oW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE662EFDB7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041175; cv=none; b=oDOkIjIbW82E0LU0QLqBbhhBNxCizbomymRv2Afw1DJRWS7ny/xWVFJRP90lP08Ccie1vo3+iXCdb4kUQR6AMTSNUYjahs4K9oUZ8wNIumJ4B02/FmH2kcUnqWH82CEI+SB8GIrIl5dKq/X9mNit3xN3fUJSHoiRG03SHQRKFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041175; c=relaxed/simple;
	bh=Rlz15NwRFPQTBUDVi4l5FhQHO8GJgGPJzTN86dt50M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgTEYcWKJdVWkdKErFQG8YSlxHVFNopUK8Gwt1Pz/ZqoMmBJ2rJA4LrCdp58jedKtwmFuJtkETlqW3ilxXBk0IJ6khuMn+2LxhYcjx7krChz/uvJDnxkAJPzPdxEy91Jd19Uh74m5UeYXWfZ97pbWo9JQIk7R6A1isZ49XdoyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9yWX3oW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5MqLTGooWfwQQt8bVLn3RBEegrtdNGSt5bbFt4WvjM=;
	b=C9yWX3oWeTOr5o2m9V/DlqqAJvk2QSbEHJj3L/vkEUdorR9elnj89K+fEM6HZo6oc8ydi+
	m2xZH7oEWfOro9vPluow4OcjNQizmp2Ghwy3Zeu3AeUgO7uAalrh82T8FEbuK2MDfsxXQm
	VCg5yuXbk+wldI4Bv6DLF4cGB93RKZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-DuM2AmTOMPuAtAp0g30dZQ-1; Tue, 21 Oct 2025 06:06:11 -0400
X-MC-Unique: DuM2AmTOMPuAtAp0g30dZQ-1
X-Mimecast-MFC-AGG-ID: DuM2AmTOMPuAtAp0g30dZQ_1761041170
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso3106799f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041170; x=1761645970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5MqLTGooWfwQQt8bVLn3RBEegrtdNGSt5bbFt4WvjM=;
        b=W7Awnj0CDnVOFfi25GejyXw3FsTNwd6V+NTsz1R6l5WGUSZcTCWjThCFgVF2OfmZVt
         THlmBivphePz+xWRMFruv/T7cGiu8aL4fjjs33e4cpROjuK2eLCOSWRalB7r6FfQhidq
         G5bJ+g8L5fu086NKkZE6OcyIUyJgkRvMDLzV6nYpcxXDLVTGzQsdE4uCAsL884rXQ7RG
         kRP7Kj4QLou8DSGpMpZX0D5CWDVmIeEl7ulgaibhx+kckw1C38VLD8vW2AkcUQuPahEZ
         DC6Jbq/mVBrKP01UfpJodKBhI2cboGQ6hCrN7HiCIrrcOyhNP/OyZKlf72alW9SNF1qz
         dVLw==
X-Gm-Message-State: AOJu0YzJW/hbKZ3hAEpcwftBnZgo4pcU2cEhQJLaqG5bSYIHWEkkvKTU
	fHRyHTUwy1L8rgJDZXQyG1lwkQiHa0KizytiIZ7KukXQh/8w/enzwOlU6BQm5ZrlZ6TiKr/+YA4
	qxw2n1vyLZX65/z1jNV8a2w7s/hg3JlBjwRPsAR/zXD4dAQoxSerqTeZ7KfaWjetwC8Ea9KRTuM
	NI0jr34VBIfdhuhssy8R7PID9/O5DAqIOrGgrPEQGo/UKRoA==
X-Gm-Gg: ASbGnctIhehmmyyf1UetbAjks1XArlPSsv/HrU6S/s15PxECe6ga0kmYukMN0rcaTo5
	AzgXo6fDCJfi7XUcqgmxItDh3Q5kJHFl11FxQMiVnvAT3+25pwqwrXCLfw+X2IXEpHGbJFN/rX8
	3hXmtg047FfmXn5XyCtnO7Frz7lpO7WXsVMwNHCZAiutD7PJmMo7H8ygpIYFUJa7M2fGO22Q/K7
	lpzf0GaIzt8uFOsr9t+OPPcjNqamSCVBd90SBbTWWcfkrHiTorphXhPo8QMRMLzsE0NOErdYDT2
	7xgfPpyV4ThAtwesUVDBrdwDFLvcqdsees/WF1+BJ+KUH21fyWSWwtuDPUeRtCZZ5jybPGfUH23
	iKmvrnet61S09Hl/93SxWPWNJosalmMhdfjPnjoX5QB7YQaA1KOLDDIEM2KJw
X-Received: by 2002:a05:6000:4b08:b0:427:526:16a3 with SMTP id ffacd0b85a97d-4270526183emr13034338f8f.29.1761041170195;
        Tue, 21 Oct 2025 03:06:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdWAfWri+zwLuauv8PrjZF1aMCEwE+dY3BrO7HzQ43FnWYZr7+OQSBPRdaLGioAsiSvfA5Zg==
X-Received: by 2002:a05:6000:4b08:b0:427:526:16a3 with SMTP id ffacd0b85a97d-4270526183emr13034300f8f.29.1761041169744;
        Tue, 21 Oct 2025 03:06:09 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a1505sm19854508f8f.8.2025.10.21.03.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:06:09 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
Date: Tue, 21 Oct 2025 12:06:05 +0200
Message-ID: <20251021100606.148294-2-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021100606.148294-1-david@redhat.com>
References: <20251021100606.148294-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We always have to initialize the balloon_dev_info, even when compaction
is not configured in: otherwise the containing list and the lock are
left uninitialized.

Likely not many such configs exist in practice, but let's CC stable to
be sure.

This was found by code inspection.

Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 0823fa2da1516..688f5fa1c7245 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -550,7 +550,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 static void cmm_balloon_compaction_init(void)
 {
-	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.migratepage = cmm_migratepage;
 }
 #else /* CONFIG_BALLOON_COMPACTION */
@@ -572,6 +571,7 @@ static int cmm_init(void)
 	if (!firmware_has_feature(FW_FEATURE_CMO) && !simulate)
 		return -EOPNOTSUPP;
 
+	balloon_devinfo_init(&b_dev_info);
 	cmm_balloon_compaction_init();
 
 	rc = register_oom_notifier(&cmm_oom_nb);
-- 
2.51.0


