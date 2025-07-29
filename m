Return-Path: <linux-kernel+bounces-749802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED5B15309
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0421B188CC98
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1A294A1B;
	Tue, 29 Jul 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liRajZk4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD99220680
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814515; cv=none; b=PC0+DxR2dvcF180zhVpgnAFxtc7rHqkiqbMgaaRMwzBXSp6On0u7hYP1y7Pb7H4hAYvH/Q18GSVnPhV+AVAalLAmlF/q9oeGdkRwzxinNtlYz3L4/R6ahSvq2mdRN8zxvWcGXaMgUOrw2N6fj8UKOlH8NK3NnWMW+TCDZhvSURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814515; c=relaxed/simple;
	bh=OLJu0tRgWMGogDhx5yC+Z6XY4CaNTHBb2w9jkEQIuFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz/OuBODvpSQzliY7XklwAmhSO5+2oowOW4eVI+GE1Mx0fnTgPsSqKG8zYfCPaUr5aEWqYfo8uvO5BXjXZ1w/6/aW5ewUODMb7wzW97jLsmg/W8j6HC9XBUyErO21cB3sLJqecBPUmEnWRnYISQWD/lbJDFgegg1KanNBPozX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liRajZk4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24009eeb2a7so25155555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753814513; x=1754419313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyUmaoOW/TeUnouFmP1gQf8eJnWKJIICpRMN4U7cKns=;
        b=liRajZk4TFcRw3JuCiWQhss+LUlNSCZJslT3GonYwY3A3ioscCMP8SdkLfiqCcgg4E
         fK/GJvoP6Lwf827eqjBbPH+UunOPzlXgvkSI9kXEu5gJBtUIRJ77hC6vCoufDuIFWhPy
         zFc17M0Cu371FuHtO6BxAA8S6ldhBcglcDdQa35K3XrGtqLesWEofsXKHyBURcmPZzKC
         q2mO6ayp2DXVXhrA0oo5F9c/ArQXe7fCV98pvmrDgn+Clsj2hkn5e+qGnErmaZ+CYWJt
         0w5Gk3Y1yHRuvqeChhP+VBlckfAtyeowMe7qJ52lou4eigAbph3fGFDbBReF9roxsozQ
         DSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753814513; x=1754419313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyUmaoOW/TeUnouFmP1gQf8eJnWKJIICpRMN4U7cKns=;
        b=vQBGKX0r2f4aTLGCywVtGQ8GdulnwUcN1Dxgz2+xNG7p7BvE0GmM2pQwMEU8pZOYam
         U8NCWnF4sLISClm/WKldDtF1nfRHn9c/vBEaLs4Oc3zFS7gPH5McK6q6inuuoWHvVbrP
         8N3ZiLbLucMasyz7pXnSRIK6LLvXWBtsImDzi1y8bhWQgM2In2Nfm6E0yg1l6wSoCWXK
         KC1Xgc3xDKx1ZxDnOO5n7qKVRQlvN54kXxXcsiDxhaYX0y1eK+vAhcO5w3nYlE2WqW2w
         L94ovECrpq6oV+WlVHAh3CsO4+yrssgID2Ro4J/sSt+F+0bOaVXoG7x1Y4PuGuQC12w8
         8JRA==
X-Gm-Message-State: AOJu0YyCXFv8nveU9QhCXVD2Dy2Xda3C5eNibIt1iGUVWxhhGZKx0kaE
	59/wPZkS75H3GZHT9MpgAZEgp0pODGzCImrL7Qg3zoge/MCGbDZoBgF2o8Mieg==
X-Gm-Gg: ASbGncuUyocjieoa910lcTStL0dJMNFo0bDSR1d/ptc9CTyjNgwTK7ICn6Tpy809t6x
	BM6idqOtDSLUjZEi/u91LhIU1iQMTu8pws9SLuySnZdZeydQyzbY4jKuvKz2n8xyIV3bdrrB63Q
	ejRwq68OzhEOA0dvpBCWJ4iGszRT0gzehR96nUGfGeSH7PWSYgtmqA2LBhjdXV6HHNDSlFyIrac
	VFZT1dYTImsH/hVpS+YA2sBqptjL8eXgyODoZdChsJ/qJp9zgXesX7I3MyaNJv4Kps477ws4fmm
	MSKk8NxorptVdSUsFrTAudifbGxbHQUq7lB7wzcKT7O8sdTC10QjNeV0PsMRLLxc8DYqNvmy9WC
	OVJz7hvtNorVbJRk/YjX+0Q==
X-Google-Smtp-Source: AGHT+IHZGIxLTjq9IkuLEfyrAPTn2VpTvnpuFp5z4Cus9PUVpQUwXdP65wYaYgPoZ4rh8sHe++MWog==
X-Received: by 2002:a17:903:a8b:b0:23f:cd4d:a91a with SMTP id d9443c01a7336-24096b03d9amr4580845ad.30.1753814513183;
        Tue, 29 Jul 2025 11:41:53 -0700 (PDT)
Received: from fedora ([200.111.160.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24058561dc6sm32658925ad.108.2025.07.29.11.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:41:52 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/misc/sgi-gru: Fix typo 'tranfer' -> 'transfer'
Date: Tue, 29 Jul 2025 14:41:52 -0400
Message-ID: <20250729184152.160693-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 3557d78ee..e9b4e9336 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -304,7 +304,7 @@ static void gru_flush_cache_cbe(struct gru_control_block_extended *cbe)
 /*
  * Preload the TLB with entries that may be required. Currently, preloading
  * is implemented only for BCOPY. Preload  <tlb_preload_count> pages OR to
- * the end of the bcopy tranfer, whichever is smaller.
+ * the end of the bcopy transfer, whichever is smaller.
  */
 static void gru_preload_tlb(struct gru_state *gru,
 			struct gru_thread_state *gts, int atomic,
-- 
2.50.1


