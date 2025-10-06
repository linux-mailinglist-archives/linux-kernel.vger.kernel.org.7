Return-Path: <linux-kernel+bounces-843048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 462A3BBE4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0238E4EEED5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83C2D4813;
	Mon,  6 Oct 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKXy9u4y"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF52D47F2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760001; cv=none; b=krg7qz00f7IbKusTpQSBrtANm0OyJKmZ3gyzuVggrCbQNQqbBJdYF5AOk75kRvoeoM9hvkdYlA6UN+nereZXmIh5I73QqocglZ7wAV+nhSRKiOCkphwb1aCqjKO+0t1n6WJ56LBltQe1b6hPJ5rxc/IQSH3c/qoFcr0e8UGCr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760001; c=relaxed/simple;
	bh=/+uULmCCTifnRtK9EyDkASe9q4mlZarEVGF0toEYVKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsWSb28rqZg4kXXu8F4Qlm9ClTwQEsv+rzdzy7hTsZMsVNswtze7oNbDta8omjLlA/TS2426Ji2/Z2itu4LVGw2gKSmtA6+HqcT8tYiggmoBmZWygKZNZbtt4Q5GLIR8Azoeg90SOP3t+TM2iK58lqX/9BRY0i9cnKPremuviMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKXy9u4y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78118e163e5so4764415b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760000; x=1760364800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYNqncL1pbkX5BlNCe5t6IJsqg4ck4854DVjD7R/zfI=;
        b=XKXy9u4yMjxWahzMw0D44oLPnASMKvTCm8LhRMVq2C/fWAQu6mYcI2HR9fel3Ds3A4
         e3W/N7Khp9kXiyHF/W3/53VoEKX0AUQabpGj6uGuW+UCRnuyUnynxejckza5x9KxXrj4
         eMJrbtCl5vQ5nUf/SpAuFdoDt2q/YnHOUNZ9oq1KlS1eWyRcKxj5uaamkDy9EtR0yfR+
         AtT5wIw/rdFl7OSZpTxIq+Fb0bHphlKccRkDE8ZF0UCDFbL64j7xbUcVJ+uuHffuKx9x
         XLamJYcXJYSHYq7XdYoPYPhJ0hU8Fyo06dGTdLJiHqEP5l3iWQLg0xvFKOzKm+IomPl1
         D63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760000; x=1760364800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYNqncL1pbkX5BlNCe5t6IJsqg4ck4854DVjD7R/zfI=;
        b=GPdci8XDMO+pcxTdz5mdzPiuy4vS3A52UzPWPvDx0nAqDxdRxCid3hNQMinBzKmUWN
         PibHPr3y0oWjZZCYyMZPScfmfZJ1gOlw8U4+GDflknZim/hZ7ICVJNMcCQtWdoooVGZs
         niyj1Myzb1xl3IP67fZEM8t0gGvOx6SfZQ4CZCFtbVow7I7DtLgdnmF+/N3dQ39Bb33r
         iJ/s7IX97hPz30VqAlDQRpum+T//iTVz/UeX7PeYC0C7T1ZZ6THcKslC1ESYTqKdhgd6
         Z1/pkxT3ORopHb79fPKHkvbn+h/H73YzmGBKwbyyURr8ZYp3FCptfM+MM7BrhOwRVWHR
         q6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBkB5/G+wV9YLEUwvYhPncfvpPgPPKVZzqH/8HDqSh0BxkGzEcX6BGZx6wmKn/vHYE7MHJXsRpeb6/byo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDqKhWQtjcF9UafGNhpPAzoiS+INuu5FEkspGZJs46RCNK2wG
	OjxteQvdhKGR7xXzKVMem6AuDaHWJNsGmeRGrHd3l5Oriv9ttIf+M5oN
X-Gm-Gg: ASbGncu3rwVHn9SJXWYX676VLK80qz788hjbtZizPZQUp0UPexoQDZXmfIY4KebEtGN
	nVDIQclGY+1qr8cWb7w9ShN8ugsxJztJcAbs0Fov9P++84PijWhrk4p1OOsy0Le+oHB4G6IAIn2
	npTi/NjCeDwlCyhbCXg6vCmrMfO2Cy8I3633mXW3+qCTTpvr0J3UW33wL1vjhEPgff/EQQBl6L9
	noWD0uHCTWCMyY1+Q0oUsaOF4IrGawvvcKzgFdG/sWGSPg/IzLGar+zry4SBncgHmNY2oIvLSNI
	gNlDNbpg/zucx7aqqH16SDD5MVZ7uxIeleIS7tg4VI1C0hxcSYqgm0xbUKJOjqOjTMT4s1Uh76m
	ShUdKp+3t2czGgGobSCHFK4t2nTQkLxhDnFqKMd4mrNQh2HX+kn3WDFsrlIL1DXXAEmez8nBE7N
	14FsuJ3kubnAwjHNH09VCCb12XM/Q=
X-Google-Smtp-Source: AGHT+IEPRB2b1AD/QZxok64lsH8ByJ1lFhBzYU52eoAFfWqs1FcK8vyfSV6QzsZHrEOmLe58UAsEbQ==
X-Received: by 2002:a05:6a20:1611:b0:263:57a:bb46 with SMTP id adf61e73a8af0-32b61c78378mr16152472637.13.1759759999595;
        Mon, 06 Oct 2025 07:13:19 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:da26:6519:741c:efcd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e50esm12666243b3a.62.2025.10.06.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:13:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: osalvador@suse.de,
	broonie@kernel.org
Cc: muchun.song@linux.dev,
	david@redhat.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hugetlbfs: skip PMD unsharing when shareable lock unavailable
Date: Mon,  6 Oct 2025 19:43:11 +0530
Message-ID: <20251006141311.23645-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Oscar,

I agree - checking __vma_shareable_lock() directly in __unmap_hugepage_range() 
is cleaner and simpler. I'll send v4 with that approach shortly.

Thanks for the feedback.

Best regards,
Deepanshu

