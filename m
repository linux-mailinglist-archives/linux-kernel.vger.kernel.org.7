Return-Path: <linux-kernel+bounces-888275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9AC3A63E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478ED3AA79B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776172E8B6C;
	Thu,  6 Nov 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz51hmGF"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9E2DA774
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426175; cv=none; b=aF6W3BtAGnagO9wSRWpr9ivO6ZrKXdRUI0qDTN1+1hv9dlOv3qQhI1z46MNwbXlD4lEwAZQjKxuXGBIEYqywnRgLUoOhR3843GxqHmtF6V1OyzB3wVDNV7D0kMildeaobDqcebfS0/5084yEIzGIADYlwPQ9LMuYxB1d/7gCNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426175; c=relaxed/simple;
	bh=LVJmw8Znzsk4JC1Z4uTOd7PG1aNTT/KMtESz3mfcO0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hV1bsAQOVeR9qE342mnobtSaTbuy3ENgTuuNPPEv1X7OCBzekdpRP36yjIVoPrer8ZW9JHVE7f6oVLxdAeybyw7VLDa6IigkU/2vdY4Ya+qh2gVG1Okp6cWbzhsrEgfIUMFeUU2QPHtp64FdTSF4XnsuY4MfK8S9mDPsR1YLwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz51hmGF; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso842270b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762426173; x=1763030973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEdCoMYcdGEjbdHJV0gJG7pdiA99fRZM/09SLOS+hH8=;
        b=Jz51hmGFxwm6OGZgnfeFO5ULqnUt39LHh1+OqSq8zmSFNzdwKsF2dNh+DoOf+WSsVA
         J3+VBNbH44D4B7wavINJJW3+W8p0MR88ouY7i3CmDpRLUdjnNU9vYa2CNqnARQYwVt27
         K2myOHurRtGxUl0U9Qb9JRcvwrbiLhayjQMJXKBljjCoiZxyvnop/eqlMeG+WNtrA/wf
         EG0/QFWV5pcZDiuamR2ITZIgqacaNoDmBNA6xDwd2o2bweig2Hab3BdkpAvv8Ka9auqX
         O1tr2WYokriUbebqyAsQfzT+F0EmG/tUAvNBp67aXZKWnx2qpDmZGBddKVbohdd7w2Vx
         lRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426173; x=1763030973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEdCoMYcdGEjbdHJV0gJG7pdiA99fRZM/09SLOS+hH8=;
        b=DEeeuV+bE54FYGqLRYoOSFi68cE/ErEhBGBD6U722lGn8DCLhXBZVufLgYE6+HEGx0
         9vyfJ1OBBIas/9AH2QwBhV+kyZn/723Nrnl/QR5BsMNv7bMD6wYl1JVi5XnLQJCWHagu
         SF+RQcjP8tOYEnGLVzAwX7GSXcK/WuovoB1mYn1IBIyU+tkZhamcSsT16fvEe7SYEfbL
         v9KilcfozYvS34tpqMRn5Kyrt680jG4ICq8AIrNGyUp5UmEM3dmCjoc5EP4NQHRyrf2e
         Veq23BsFtt/GStBQfXQG91blNYHvOjiuAFmmtmW54v5/mQTGvKc/iQsdR4NdtQIk5/Tg
         8o6A==
X-Gm-Message-State: AOJu0YyNiw3LGMtSnwfweUNjWRs6r+K6atq3/T+3X5LSxAbNPrtBq0o4
	sx3gV5BahYhsBqCu/9ltuh2NFKtaUsx/5hJTI1uLa2i+Xd70Zf2Hu83G
X-Gm-Gg: ASbGncsmJZSxtx5kU0N7ImPXKcS4EPn8kZzJGRvHQBkBZp8+Z5Ole4Jq2MTMhwgPjx9
	j0ccdT9ueXLyuTl45/mLKHoBn8VLjdsV8Tr5vRGOsnh3QC+8YFLOO29mWK4bx/Hvtorfh/78YwS
	G1ayjAqMwBdz1Z0lSWoB0biwIT3u2i77gWogQrdGmTndXNhHGjM5mQ/p1AcUr+ooWGT5Q2Lg94Q
	DvGlskvci6+lBVHV7Je4UaPdbuc38gc03bhmfg3VRbfgPjbdnzeXnsLTUignpurD75Zb4F/rHzd
	xBpb6afol81/emSLUu+me+7bLbkcX37qGyK2HGvRliCigoRBzEsn5eGJS7pIRV9wySSN/yH1o3D
	tfX+ht9LiOTWvFJD+Z5IMvQZyYbV++imD/8bGsbvkD2Zg2oia35IB9kmfDQeI/OM8dqGOMW63/x
	pF0m+aSQzV5aPuVBLG0WM=
X-Google-Smtp-Source: AGHT+IEtViQepAYL7wHG7yVriIANhlLuj2N596fkhQw4o6rhnkDNFPyu2Q90vL6GWm/MKnzkOWTSPg==
X-Received: by 2002:a05:6a20:918b:b0:347:8414:da90 with SMTP id adf61e73a8af0-34f80c9ebb2mr8516805637.0.1762426172835;
        Thu, 06 Nov 2025 02:49:32 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm2148457a12.2.2025.11.06.02.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:49:32 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Date: Thu,  6 Nov 2025 16:19:17 +0530
Message-ID: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
triggers following warning:

mremap_test.c:1035:31: warning: pointer comparison always evaluates to
false [-Wtautological-compare]
 1035 |                 if (addr + c.dest_alignment < addr) {
      |                                             ^

typecasting 'addr' to 'unsigned long long' to fix pointer comparison.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/mm/mremap_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index a95c0663a011..5ae0400176af 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -1032,7 +1032,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Don't destroy existing mappings unless expected to overlap */
 	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
 		/* Check for unsigned overflow */
-		if (addr + c.dest_alignment < addr) {
+		if ((unsigned long long) addr + c.dest_alignment < (unsigned long long) addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
 			goto clean_up_src;
--
2.51.0


