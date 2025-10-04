Return-Path: <linux-kernel+bounces-841930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B351DBB88D5
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4154C11D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F31E520E;
	Sat,  4 Oct 2025 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6IxCKE2"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3826290
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759547949; cv=none; b=dBoFUtimWbunJUP5XIzLNzcHwftVOmEsaJahN8delHL+uK+VM3E5QAFoQ128VnxatvrO/Di0CJo3nxpMxxXkGeyf7g2gKzXRC7wyZtkQBJu+7nAILCyo9qPuO0Zw9Iw0mhLL8MOY4pya+z566petzKt46GZY9VGxxwy7MaVO4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759547949; c=relaxed/simple;
	bh=qY/mQj4c4bApo77u9ZvJr9P1T39q2byVNNxEQpc35zs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u3hvH+gJGJVrXIA03Yn4XM8IXX0wlgmvFxrHx/jJPMDf8mXuQWMFwSZg87jkOg5ErxtdJNyTSrE0+gZMuKklzhNgfZzSdY9CBf198dzA3FIKSnpo5yGEpPTpyM9quy2NaPHMHzd1CqXBefIRhn69hP+2lbXhD+wG26Sfehbhbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6IxCKE2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so2805463a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759547948; x=1760152748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0f0fZbuAlYt0xeXxD/vlMHdXsuSwiOqxloUzhTU7h0=;
        b=G6IxCKE2TEoEE6SymrHIW6giwjlY+36xcShUxnD5TTz+BXIdeIPnD6gR8WYCuq+EFR
         FtUtg0w7vsXU7uwa00JP9jp6Ap6AICrp2r+37YCYcxJmQLQu9gbyltJPdke14O4eSSpp
         XfIABaCLwPUZ5LjdsxWIq7aU+62MXhHw/BS4wp6LmlD8/oBZXwnDJ08Y8WS/15zKCQ5A
         sPF6j3c2SVX/nz03WzGd1GlZ/z1SnmuhZzNNJjluG8vvBIR3eOtUwgN02NhT91fsELfm
         RTcT/zn9GsVFWIYxzi3s0XOZRS68ruuG1na6cMO99H0UIW5GbZIH7D1zteDcKLOGvbKP
         /z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759547948; x=1760152748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0f0fZbuAlYt0xeXxD/vlMHdXsuSwiOqxloUzhTU7h0=;
        b=XV7i/DwNxUnuS5bsfkok6mvcIyNfjyEKZJo/ZxGUVjuZpstQ9HoaZjV4tyPFLVFJC5
         XfaD/RBEl1MGm4j38VptQFIP/Uo0XRvPy/Kyx9lVMShLGTfJvmGWn0ZJnWIfeKnfpswD
         lAZQ7EXE0MH+kBghF1wZAAzN7C/N3UeQ751dH+fUHS14Lu0maR/Vtz9nDgK2e24Z/L47
         1ZtHp+9QbNEZs2fENiUKmkCB7ES9e7JE17Te3xMDNo4WmrIQKuTQFatZC5OAGEiMJy2H
         6uLNWhTHy1Zehw4lnwzVQgPTGcdSTrfyOl7RfKDb2kKE/GEEw8w/xAJJwUP1e2guNll+
         HZ4g==
X-Forwarded-Encrypted: i=1; AJvYcCUutoAkjFC2GAZQToEzV9+vA+gYCektYwsiYlpfEY9lITQ3+5nU01PTmadHfRNMQdepZ2Xf1qnWHnWEOKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKpAKR2qXq4QDhB/odZuqqpGmowkl+cNoW1op04iUY5cwJdEa
	Q4n7E9F2YVLaXnr9napUWeHyXFswx6G1ZbwvV30iyzsFWe8ZSsmBXlxUAFu1Lhd8yv0=
X-Gm-Gg: ASbGnctQlAhxEcMzg9mwiAF2FxEEXl+58Izq3vqx+sr3CVFx0SZcvkS1nFxfO4TZ2iQ
	dpDr326HORFHlcCAqxwrPRbe1tH2KdeVEkNEO8j6Yelsbq+CpyMcqzdM7QhvBXDAl1YLvCpplTX
	fOP2NLHL9wf8iJkkn912l7tVQ6N+8vtDVeTHIBagcMUcucQP566zhUriJHm/9Sfd0aIgM5fVo9y
	BN7CUbEOtrXFjHI2gt67Vf8FmCjskheCuht6/cAQFm9+UvI3CenYrRbR7jlkLMaTsybfm61WDUB
	UKgRG87XtrYz2fY1QDwvtoOMvNPts7uabMNaonT0MQSg5hnuq/d9XfXNFAh8sO4glcB4xMGJRey
	PT2QwY8Ue4kEKgW3+e7cDgDfbQR31mLMx2hZ/KbVewoOBNGn+K9Ay0svQ9UidBA==
X-Google-Smtp-Source: AGHT+IFHpHALD1sa8acPWIspep4hCEYuuObgcuOhGvCURHwQmbAKZkGTZZw7wpWCSvK4aIHv97bBPw==
X-Received: by 2002:a17:90b:4b06:b0:32e:a60d:93e2 with SMTP id 98e67ed59e1d1-339c275afafmr5941447a91.11.1759547947698;
        Fri, 03 Oct 2025 20:19:07 -0700 (PDT)
Received: from ryzoh.. ([2804:14c:5fc8:8033:c5aa:36f3:14cd:8995])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b02073d00sm6282924b3a.77.2025.10.03.20.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 20:19:07 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH] f2fs: use folio_nr_pages() instead of shift operation
Date: Sat,  4 Oct 2025 00:12:17 -0300
Message-Id: <20251004031217.50242-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_nr_pages() is a faster helper function to get the number of pages when
NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 46be7560548c..4467a6e7471c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2036,7 +2036,7 @@ static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio,
 								pgoff_t index)
 {
-	pgoff_t idx_in_folio = index % (1 << folio_order(folio));
+	pgoff_t idx_in_folio = index % folio_nr_pages(folio);
 
 	return (struct f2fs_super_block *)
 		(page_address(folio_page(folio, idx_in_folio)) +
-- 
2.39.5


