Return-Path: <linux-kernel+bounces-756140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51816B1B076
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988207AA323
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7D243376;
	Tue,  5 Aug 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzpP7tM7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F31C84B8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383890; cv=none; b=AtunTHOO7Hq5Detf+afJQcqT+n/AGPHmSq99n+oQ0J8I+Sj2qKCaNXQvPt8ssQ3JXOtFSZh2swYZJsBNjB05D/IK7HC4TZx2Ux7CevTHCVVpGCifZQOCkdTgMxixPUdbkIrsEdyJl4oMAAlBUuvOr0/pVNWf43+MVTcCEhvGWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383890; c=relaxed/simple;
	bh=W2/8DOBGCkCweOZmAfazNZ528kr0kjo5Kf2R0152eco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KKuE3zKjSXqaT/Xrua4Q4v0fgHDXyuhnwOYfkWXYPgvpgayJOd87r1p+MQ+4ZsTchom+LBWrNNa8DgKs5JDXvQAYD8p3jBSbzFNcALYBkghlXP9ifTqBnenqBO3Z083m0LSHGsc38bSY5yvF1s0CRjSjkdszmyt2X7GW1CkHsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzpP7tM7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76858e9e48aso3897841b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754383888; x=1754988688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTyUNY7DkPk6giF7bQ8oyIphr5083kUpV0hMxYtsqp0=;
        b=KzpP7tM7TuP34WTOAtgdPzkJAkkq7T5NSwud3BMEK0N9zT7CPeykHEUppvpE9f7U6u
         BoaWrmgALzgzYRaAAihuvk66wFJjMv9VR6X+l1ovcxho92h33b5vAr4b3TLlAAyP+EiP
         mL1vv04AV95rVx3gJ6kvadD8AD8Rnd/ZHvSeZfpoIg28JEkRuYxyhrgS8mGxQccVlq2R
         Kj+L3tTTGAsoZBKKFTtPFi43c+oOrMeTuItHMg8PCi2SSCDQH/s9jvWCeQJemg8t+5K/
         3o3MnvE5uy2Dk6zCAMqWlQbL8XeeEhzn9rGdXxES29QIHiOalAHsdTyZbY63pG+dTD2M
         ISQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383888; x=1754988688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTyUNY7DkPk6giF7bQ8oyIphr5083kUpV0hMxYtsqp0=;
        b=Wjjxd41U9bdDjE3fSBnTDi5/w+gl8mya9kSRf0n+yrmWYHEh9YtVk1ad8fM7WXy4nt
         j8bBau4QVXp/1shasg1CfX/bh/1MwOdp7DoycmEakcyy/gXeAr1e5xaoohOENsr+CwqH
         7q3ATDabY/RzZE+W2rB/v58/gRubzojvDdad4l4eUPjrAB5xaxTSJ77V9Wk46M7oCon/
         xi7twG2DBNiNqb/vwOIaomMG2wcVvvL47wSFlPUO5dV8BOAKCzhMJX8c0jWM1HnXINhr
         il7ZBlq0FPSMuem6dZ2pGjag4a/4Q1kfkSpUY4iEerB3JdzK+Pqh0pVFhygjhItAK00A
         XeJw==
X-Forwarded-Encrypted: i=1; AJvYcCVpObnjVoKMsusHKnDXokVCTFzKqfbhWSiINVN/wauYSeVFW4eA2DxBJG8j1EK2tTGOjm6nR4Rk21MbXP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIALBilFX6RU2xETXWI77EgPUh+B8zPKWSeoT1veHVxN3nmf7
	oQfv0IR6tetLYcvoXtk59tXsNnqccb3mTgzjZwqHdSVCT9kOfHvGsllLdrRaU3HRPmU=
X-Gm-Gg: ASbGncsbcGx00/wdxQETOVqrX/+yJwO8fyfjMFl2+vHD8RlV4/jN5riziQqS2efrhzP
	xM8lyjL2UZMczjsxM65p46MyM0uczk/mGy1W7wgDnWiL7/P0skimLcnozndJZZHu4vcM6lh0jf3
	YNaEOjBxULCepRS3/3nCFTmC6g2NNOE50ckWpYgUA2Ja2A6P515k/3urA6tUUjD+H7m0hd48Hou
	VZhEu4okykBF6jbbTJuteO27oR2jMNBa0K9+t1PLxTMbRA0Y1+uvzmeFn+hCvrZ23ZOYG5IHgZQ
	IPlGS8u0Z925hAS8R8LPnnhe/exXhKYZwnBLmgfTD287DOhkFYItbIfmLc4EilBkspE3ZaJjsRK
	TWIyojFkYixT7YJkRoT6DcdrCt02VdRvWRBWx4QwU/oFM0yhSIy4skLqo8WqmxqGFnRnBVK5okB
	ocBtqQ8Hw=
X-Google-Smtp-Source: AGHT+IFX0CBsQxCnjnp9iFnMUtyP6VCztAqH/RJ/WSaTnNKx6VuGiUz2vo/HXm+TGSqcjJwYZHScUQ==
X-Received: by 2002:a05:6a20:938c:b0:240:1a3a:d7bc with SMTP id adf61e73a8af0-2401a3ada52mr6210239637.3.1754383888430;
        Tue, 05 Aug 2025 01:51:28 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-195-113.dynamic-ip.hinet.net. [220.143.195.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef5970sm126691715ad.20.2025.08.05.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:51:28 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Liam.Howlett@oracle.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Feng Tang <feng.79.tang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] mm: Correct misleading comment on mmap_lock field in mm_struct
Date: Tue,  5 Aug 2025 16:47:26 +0800
Message-Id: <20250805084726.2054-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

The comment previously described the offset of mmap_lock as 0x120 (hex),
which is misleading. The correct value is 120 (decimal), and using '0x120'
could confuse readers trying to understand why the count and owner fields
reside in separate cachelines.

This change also removes an unnecessary space for improved formatting.

Fixes: 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ec273b06691..ec90bbf22e2b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1027,9 +1027,9 @@ struct mm_struct {
 					     */
 		/*
 		 * With some kernel config, the current mmap_lock's offset
-		 * inside 'mm_struct' is at 0x120, which is very optimal, as
+		 * inside 'mm_struct' is at 120, which is very optimal, as
 		 * its two hot fields 'count' and 'owner' sit in 2 different
-		 * cachelines,  and when mmap_lock is highly contended, both
+		 * cachelines, and when mmap_lock is highly contended, both
 		 * of the 2 fields will be accessed frequently, current layout
 		 * will help to reduce cache bouncing.
 		 *
-- 
2.34.1


