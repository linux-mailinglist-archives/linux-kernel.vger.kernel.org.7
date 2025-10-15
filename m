Return-Path: <linux-kernel+bounces-855017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E37BDFF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D21B19C525F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1933002D3;
	Wed, 15 Oct 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJC9uVrH"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450202FFDC8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550656; cv=none; b=MeIZI8Qy5lW5IDnvgPnZ2LxYdB20ikU9u1cBbMRRrY+l5w/o+NkOl6Sdo4vXx8SQDZv1maANC0JnhiQtdLjlVYn9DNs93pDr3VlR5A+bOprZeA6SeR6HOmApdMWuwyXYEEUolHDrYvFd++PXpBP9g9p+Ix8/I/FUJJc4S6W5sG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550656; c=relaxed/simple;
	bh=G+GmyNT8Wh1+hnhGM2xaT9LaTyErSMogCRBV9oGyBc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+FutWFzFEF1OBaBo4CDQCuKWkYwidKUfcpfyaPVEpBu7IzG1u5U+oIiwpJqC0vNcCCHKgeXpXtOWNEZYj16Zn9Z2LFb8YyCSFR6TId/jGKhvfnaBrjWIV5IB8glY6r9GhHCdB76LvnfhLhNxAAjN9taqJdDNWQObkqv8ZIiLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJC9uVrH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-793021f348fso6427801b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550654; x=1761155454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhhd94uikYZ0M57TCKhsGF3XmQPdd62RUy7Czm1T+JY=;
        b=kJC9uVrHo1zivPd0rqvjTtABXzCQvzyN67XxUwY+CW6COYfXQVN7zf5YgNmfXZnVzq
         pT9eZ86X2bb59A3bDgUWyaFJNFDvuPm0mZJf1gcplXoF407+LIxgd5eFcF6tUKmoFWPR
         xZjkVX3lGy5rrEEHXQJqMPQzm1w34WgGGGZINB+7M4swbA16m8uOXG5CaiTaONHCglFx
         Mm4hkNYwsH5me4rxSxXDTzNzxzbIubsv0rfIi1aR0auVPDwwIMN0CEftwl9h7E+2Hmdp
         PN6Gt8web0Ji+YpZG9EXwnwULozbxnIHiJoBTkRkLSA4M2o/8AFMvvZr//N750GUoF+1
         RZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550654; x=1761155454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bhhd94uikYZ0M57TCKhsGF3XmQPdd62RUy7Czm1T+JY=;
        b=VKclcsQtBd9zWLxZQc/gPpwDQPIDQXf6mT4SbIoCY7wT1wqV6YrKjieivUttJ6g3bE
         bxhrx526XC139IJSZS8ogjNSGQJwtzByYHp6BUUkDxJ9bT6jKGEzWaDQstFQt1vHKuuF
         Anze1EmnS9G5lbzgh7lbiRGc71jo6l+e4WwEBP5zSbiyhgE5qCjv+CTpe4xzhJhY/gVL
         0qTe1u/PmeMPWs6q/B7xOVBdxA8gE+iPlC6JmmrrY6Do5xbOEegILfApcoh1PGafhoDw
         u2Vw2JcRh59oF4KqY6gkDX7yGMMJoV/kjJCRxCJC4lYUF7n2ghIHyRl8NXNfl+9waKuF
         dY1g==
X-Forwarded-Encrypted: i=1; AJvYcCXDEsmpeMAsFANFnbxAN5akZa3tYKciPqrEkZDAfLWjkoJNbbN1eNItBgKoOdRmSUuZntGw+jvg/kyQJ9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnFfeRKLNehtjXz63OpXiWhmXt/owJlcm3cBWbXFbFCDwAkvs
	AJiAOUQYqFFgDubrTGRMCDeEbivsGKeS7VyOSzDJ2G7Jtq6pAfvldn8p
X-Gm-Gg: ASbGnculI/nKqXD6k43Yv6l8IUE9tNcZJlCYkIpFNrSug+o0AVSfJmsduBJt53ZbED/
	VpodVMIkdS0ieykoHg16Fs5rD9jvcwY9LPch6WvJxOqzAspNKRx7Abd1lulzitQBNyR8/hLJZ3r
	eBapNbKZxZTXBzVWLCggLJmiGRNckAKsqVYNN0LlSAR2eJmGX5/oQvcmGctXDXAr2Z59S7mvWak
	W53MPCta7rUIwJqDxtZWxOPx6lWQITF0cOoz8kWErmIJ5VTnbXhZhtntqFhCDbJcDmn4B7fMRAH
	q6Zkf+vgdj/K9I3vyQsSOj73vMcQRLpy9uh41c+giRGdY2O04s0IDTpBlXbaagyxzFx5HIO3hC+
	8j2xQcApKrhM7gUhOWPjF0cnwgQad2KGt65PrYWvVRvtpr2KSV1Yf5P2BhECyrQQ=
X-Google-Smtp-Source: AGHT+IEarAggh1iZ8jsVCPzM3oT+9cjTgRfUuCh+BSAmgke/WR8EXgzmjltOTGkP9T9W3tY5eKi9wg==
X-Received: by 2002:a17:90b:1b07:b0:330:4604:3ae8 with SMTP id 98e67ed59e1d1-33b513b3887mr35836227a91.21.1760550654433;
        Wed, 15 Oct 2025 10:50:54 -0700 (PDT)
Received: from muxbit.. ([2401:4900:1cba:d8c2:3f55:be8f:65f9:7af1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba86b9f13sm11728a91.15.2025.10.15.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:50:53 -0700 (PDT)
From: Manish Kumar <manish1588@gmail.com>
To: akpm@linux-foundation.org
Cc: vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Manish Kumar <manish1588@gmail.com>
Subject: [PATCH] mm/page_isolation: clarify FIXME around shrink_slab() in memory hotplug
Date: Wed, 15 Oct 2025 23:20:41 +0530
Message-ID: <20251015175041.40408-1-manish1588@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing FIXME comment notes that memory hotplug doesn't invoke
shrink_slab() directly. This patch adds context explaining that this is
an intentional design choice to avoid recursion or deadlocks in the
memory reclaim path, as slab shrinking is handled by vmscan.

Signed-off-by: Manish Kumar <manish1588@gmail.com>
---
 mm/page_isolation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b2fc5266e3d2..2ca20c3f0a97 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -176,10 +176,16 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 
 	/*
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
-	 * We just check MOVABLE pages.
+	 *
+	 * This is an intentional limitation: invoking shrink_slab() from a
+	 * hotplug path can cause reclaim recursion or deadlock if the normal
+	 * memory reclaim (vmscan) path is already active. Slab shrinking is
+	 * handled by the vmscan reclaim code under normal operation, so hotplug
+	 * avoids direct calls into shrink_slab() to prevent reentrancy issues.
+	 *
+	 * We therefore only check MOVABLE pages here.
 	 *
 	 * Pass the intersection of [start_pfn, end_pfn) and the page's pageblock
-	 * to avoid redundant checks.
 	 */
 	check_unmovable_start = max(page_to_pfn(page), start_pfn);
 	check_unmovable_end = min(pageblock_end_pfn(page_to_pfn(page)),
-- 
2.43.0


