Return-Path: <linux-kernel+bounces-793883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D0B3D99D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2EC17A15B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10449262815;
	Mon,  1 Sep 2025 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Cm7CbAli"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE925A352
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707164; cv=none; b=aMusxRHc/YjeoF8Uv4xNUZYjcdHtAtuY3l7wEYYynEi1RdDZeRQ9CC/nGoh23rIopbrvknKVfC4DK73A9YtEBf07UUDGnBaSu7voGlAdEN2gb/i4WKGTtAqMs2iJ9uxKx/2JDYccUsDMNKBwKv32UEcSR0PHW3YSJUSH2KrZw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707164; c=relaxed/simple;
	bh=Kq9jl4vepq88dsyIU2VEKpbj+G4VTiDnEL+OOcpmbxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkH4wcmdTSwn+9szlLTtbJKuw7Ts/WoxNBf1i6XnunZXw6cgRgna2nL2ByLJkor491LTvqPjk4S3wYmhF+KxlRBjk9tYL/m0LyxhiYU7AY0VjjZgS0DoTOcSOeg5FrmTxtg0SC89YPBrkrbwDTWjks+RJ3YhCgXu3yUoh7YTaUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Cm7CbAli; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cbfa1d820so7686168a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707161; x=1757311961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbQrHBJ8z81uwew1vi+7yRgIBMEBSVZY4WcnSS+Eg3g=;
        b=Cm7CbAliNonCa6z169d5KStQnRdncHUY16k9jsZcS7d4ijjlCQ74lLof2gNMXfA8bA
         fX4c+fsfng6fJvb22rSGRfDrUZ4q/BO4a9FdD47qZT4XLbpgtS9GWsqSdgnBabFShEvF
         +vy/1qRDV+yA41Ea13VriXMBg1fBw1qX52WAejjNoL8QnzII1K7TzCr2YEXWtAsziYkS
         EfcdGyczPxS+TzunwO1/2lmpIhu7VlkjMrlflE3kDTUSsaSSCdh9uhhwF5LzbgA1stkI
         pScfKBy7b7Sxj4zOwDA6VZgr4pXEPaV5e94EVyMqAPz55a65wFYuHlU92MyrnXh1mbXO
         rzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707161; x=1757311961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbQrHBJ8z81uwew1vi+7yRgIBMEBSVZY4WcnSS+Eg3g=;
        b=iQA7J7KSfyNF5yP3WXUSn9I5CF7mzVgm8ck/J+Cpdh8Woq9KaurbzAv3a6T/v9dzl7
         epvJ9hN0qlOsZi97Fu+EP5QHhJRKSNH7qth8yMi5ATZoloh1Ofen1c7PISdgtViwIqRR
         cmpGkuuZ6UG+S+TrnVi2o4JILU9v1K+MRLByfVXYKSpOGciOWKM5EpYrUP5PZV1EY+Bl
         bHbylCOTfIyz0pGOQZ5MmbCznp0Tma63FL+n/7XRcxLvA1hcjMe/CUo2bZ0E9HzyfTWv
         9DYS/g1LRqjmQ4Mgr2d7/HVloaMmfoZfuYQ3sF9+IrLiWisKds2Se+mRZCvmGaHT8XUe
         I0ig==
X-Forwarded-Encrypted: i=1; AJvYcCWtNkEhPcrKbUhY93JcCX6ud6IpKOie1UNcprRuiB9moHGS1TrIaaJKdVK9Q7BLk0Oq9jNGQyzUYzzb780=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCZ0JOfaRohtOHUKAoTygdGJHchaWaanxnK3wAudovU6Y0iyE
	0nLxdDT6NbwIxF0Zd0CuUyRkJYkCgBUL5HK9A1szOOEsep9QFi+VtkP34ZO9akBpAxQ=
X-Gm-Gg: ASbGncujADdFuX7J2QdzCrSNEGeZ9yfWCqAhy0M0Yztz3ybUr/GIw0lGmpUVJvvx+k+
	YD9bsKiH45mbwy0EQAJFSEtifhZeRScEEq7QmUztT9X+1KRloRI8zNGXGlzdKXP/FZMyakLFOOX
	d4Q+TJ7y14wLrn5JmzuTPhM/yY/XYXb1foV8y78qMP9bkMtM81dF53uwncx9clkXYC81/vRIMp0
	WOITriJIpeYm7j21z52edS0/N6HNs0VH27VCdx+9GLrb/07+d4SC064S0XVR/F8RiYlwB1Gw4NT
	B+mNPuq3hdejJV6JIZFDNySdTKPORdf6lRbDKPOv01VrAjvkWBJCsySmUA3Jmf/Acyd93Y8dW6z
	yKaX9wKxOzndj3iOBDz1HmApFaK2YSh+LnMAFtTl01Wm2IIJ/mmb8r/qNgqZ4oDADLgKxDepnI4
	4ji9+VHshxAjbboBHBfw2yIHrgjpqCS4kA
X-Google-Smtp-Source: AGHT+IGevVVFDwpib3Ih00RORrmBg3Bj8mRdXcMsGafDrizuqnKGumProyccpoS5DO5Ejs/3iaBZ7A==
X-Received: by 2002:a05:6402:3594:b0:61e:49dc:171f with SMTP id 4fb4d7f45d1cf-61e49dc176fmr2613262a12.1.1756707161042;
        Sun, 31 Aug 2025 23:12:41 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:40 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 09/12] mm/mm_types: add `const` to several pointer parameters
Date: Mon,  1 Sep 2025 08:12:20 +0200
Message-ID: <20250901061223.2939097-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..46e27ee14bcf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *const ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *const folio)
 {
 	return folio->private;
 }
-- 
2.47.2


