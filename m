Return-Path: <linux-kernel+bounces-732520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81EB0680A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4744E566410
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BF2BEC5F;
	Tue, 15 Jul 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX/tETIh"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503E28727E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612521; cv=none; b=TAecLU6lwOdxbMbp2Tikfei99fj6Vn4wjNSLXi6a9b32JVuD5F2Qf41y7IRemuBMRqX/+EtpyPsYPMHWBo9tr5VTGDxbzIDG4Fi0itRe6RmDFoqJ9VTeWQkA3r0SYNPo7bXwopq/MGxlfHE1Scet+OxMBIBZENodz999Lywd9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612521; c=relaxed/simple;
	bh=47VhQcUDqziKE04rpmSy9jicRXf8EGqjBWvmCyCjpnY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Sf85AqF9So1RO+s3dEjNSMOjsGbB1FjCPyvvO/CvH0D+yXUeXI6oy3pYu0h1kRusxjoxGfWTiI37zYxX6WpknNHQ5PI2LEca7U5ksalrXIvMa0HY08XsR1jgZH+eoCAk6qbDMQt3OWzozIIJpuyArjCnxAjFNSdxVOMQlW8Ewuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bX/tETIh; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e87c86845d9so4403894276.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752612518; x=1753217318; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FTTKwFRyrhD6+ykU2GdsaP5SBuru1chdmpkgyExGgG0=;
        b=bX/tETIhHd0SNssZv9P8sMeXenpssu/LPdnL5C+0LQxtRjYsS3ErNK+Llr0ybRTevI
         FmEQRdpK/E35k2lAjf6uCbWELjLUp+M73+za7yDpuedHE9JPDS+/EJEKO/VwGEukhKrJ
         hdeR6JbbCClck5zNOUMuG9cEu77C1xiu9zr+UxmqFyKRrlu7z7np4iCt43XbPPFazYiT
         nROHKVWUFRM+3sqOM8JQd5MYcTBrPvq6qV6JHGc2IV59SjZjQLt24Y51xn68VGd8Kfxr
         6Nyr08dBpr72EhrUpay+r6RE4ck8/cx0tsS79MBIzLYg1ZSHHAl/ecpc12Ot4VaOfke4
         MuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612518; x=1753217318;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTTKwFRyrhD6+ykU2GdsaP5SBuru1chdmpkgyExGgG0=;
        b=ug2QZ68dJnwRqJ757Ea5zQcdDNLZHf1hUhWv6lGS53GsAFMpA2+E99wSINFhjAfy+O
         1Cd5ojbLOwXTTkEujyxLpzgL+QVr3exwfLHwPWDLDd5NfNE1/82ocwM1aN+dGwSpwryj
         cN37HKj4RfD5DklHRdSuXv4AshJeCdSBHfFVhnGKWMaxbCsXLLmJZhzV44Cd9TmMSA50
         ETeob83JcTkDw9uiI+ROhON7pRMKb7WAbOG6oeZLUIq1bQo4fYslEBaHl8W7EKhiNRCq
         VwhEmKnsQ2ZuvYvoK2eLE+vDQ4oa4kxyyUnfRjpy4xN6e2RJPA6dnaEXvVz+FOVN3ICA
         1ZSg==
X-Forwarded-Encrypted: i=1; AJvYcCUA3Kf8oxJnA6ivdrCeZjlq3gXGBsHS18gXEJHQ7YNS66iKrtgXQugodCv7NT3vulYKn4bS/wMV/Sn+Dho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPAaz3pZ9dZN2YProWztsU8FMGMo4RE5OzFwSZMA6DvdxZjF4
	k4gNfyP9ycOf+BOAgg34Vi8d5PezGg50Z6Cytn+WYsaFyuZGtfbaSAUsz0Z3reih6A==
X-Gm-Gg: ASbGncuCZIVSa/23ncWz1qju5LTt7VD/c5q+rYPlFXsB5Y1jeojUPkgkvuOlSf00Va9
	jpjEs7J/rOJmquIu2BqTPMTCublBNz8pkiMvoLT6Jt6AhqraNGYI2f4G3ggjEaH7rq9BX8wlUdP
	fpsigCxUlQdswZgNT4M/SxSBpmtwT6lpEiRqiCaerT+LrLTVl68CAsUbkiINoOuqjVY/vPmsfdq
	ZBbXnxhqP92TRR7WeTBVykyt7m6FpK+vLOhnbuoiHtHHVlMXDwxxYYS1rH1oBLHDSSps6zVcmWv
	yYajRdMZOZHs+8qN9gYEhDUCfU3isQ0I6eDgJVOL1DW8xHOGfUjat5omwrW7X+r3lS0hUC/nLlu
	w7QtDJyS3mP7yYxDUiC1McmapyNMQE1J6wi3W0ZWX+JgWPQnCBRjYALDC7jSdxygXip4QWsyCDU
	L53UH/FCA=
X-Google-Smtp-Source: AGHT+IHOSAtY659G5+exp7yCZF33W8srGQeyL3j/oH2/gamsU+onlzAGHnDWaxqTroAYTbNdtvu8Gw==
X-Received: by 2002:a05:690c:600a:b0:70e:18c0:dac5 with SMTP id 00721157ae682-71834fd4cffmr12050927b3.10.1752612517888;
        Tue, 15 Jul 2025 13:48:37 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71823fedc2dsm5402727b3.95.2025.07.15.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:48:36 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:48:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH mm-new] mm: optimize lru_note_cost() by adding
 lru_note_cost_unlock_irq() fix
Message-ID: <dbf9352a-1ed9-a021-c0c7-9309ac73e174@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Delete the comment from above the deleted spin_lock_irq(): it was all to
justify the first iteration's spin_lock_irq(), none suitable for moving
down to where the parent's spin_lock_irq() is now done.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Thank you all for the warm reception! Sorry, I missed this deletion.

 mm/swap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 37053f222a6e..3632dd061beb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -259,13 +259,6 @@ void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
 	for (;;) {
 		unsigned long lrusize;
 
-		/*
-		 * Hold lruvec->lru_lock is safe here, since
-		 * 1) The pinned lruvec in reclaim, or
-		 * 2) From a pre-LRU page during refault (which also holds the
-		 *    rcu lock, so would be safe even if the page was on the LRU
-		 *    and could move simultaneously to a new lruvec).
-		 */
 		/* Record cost event */
 		if (file)
 			lruvec->file_cost += cost;
-- 
2.43.0

