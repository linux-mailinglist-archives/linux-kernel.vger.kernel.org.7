Return-Path: <linux-kernel+bounces-835918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5784CBA8579
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659203ABE84
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16EE260568;
	Mon, 29 Sep 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abWVC+oi"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4225CC64
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132612; cv=none; b=PK/Cdb8f3aYGgzcIvtxAhhDCxEc4j7MQ7igy8bzbDKiq02/ZGixlKLp8har5pJWlczLJC1yB1uVHj2VSCy0x/PxnQjiw4BohLIURZFu+OCYwZ8dbHp6+6jBgf+eaZk8SXOCAszm0iElDMxiCCtFFDYZAqgCULv4AW1ayMqmU4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132612; c=relaxed/simple;
	bh=h+btU/06FxrCE0fKR+iLH1QhbcgKx3UJO4wJhGrFibE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxFIWMA8YA4l/ADEkvDb/TJ/4L4GxAnObRvBqBtJHZ23gFaX5o4W0nfkkelZborNLSWOCjBHMEHDhylwRagBL09LBtrHDs+vE3h2Ut7M18h5t8o/c329T71ZDmzAzVXoCPxBk0nBcAv2MKvtmolBlcml9dwhbg7+hqFvW2QUF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abWVC+oi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5506b28c98so2947884a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759132610; x=1759737410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDEdpB8zoJ5Ds6qklOPF4t9lxpIQ0+5rCmFrPNlgPiY=;
        b=abWVC+oif83mtvZcHsTnnhgwM0s+mvcKIoKxoqrWBL8XwFHTXiME8AaamOmY3tPzJb
         EDQWY5ltLwUHSDGhCUtF0OwFERBOMTYm7BkXltsROUkrLr2Xory65lIOYFEphp/nqpp0
         EzjN6Um9xaGnBGY8dOriEgjnNNYW8vfQMAMMCU8iQLe+X+BcR2bdg7T8CqI22/yE+VlZ
         QZqFjqK67R+qG39LX6EySfEtdm+XJ4/02Jrc+bmO86M6+YGZEPrXzVZzZEhRdrIXurIg
         ODNFfvHv4LvQf15ztZ5NGDle3dz9OI6hUq6lvjhhj15jdHjzGLLLCRJF3kx8qrUcjoJg
         Yhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132610; x=1759737410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDEdpB8zoJ5Ds6qklOPF4t9lxpIQ0+5rCmFrPNlgPiY=;
        b=R4ZhfVoAcxrKwtKMU8VkvJ1JwcQUH4MEz55w7PzBy7FQIp4uITaxcoTPPAPGQyg277
         6qZwPfLVLS2YoWkYSVS7JkOgOfDhwA9PsWG3ApNntos6szrMd9rWSO+L1IMCBqhLa4zd
         7fz4Vs98xXADYWgo+x7uRKGc4fm1hwmq8aLbzuQL50bneGnv3GoG3Z4590sCkDRQFbOP
         XiN0uW/r8BjXvHjlB33+P6VkPcDNsj3JM2gSQqEYQIGBvisCIZio34NDUopsfvdN9tU5
         XHGSD1Rd1YQyV3xREVDkBSg7LCRR6h657GetbuBmBZABocMz1XmwL+j5lIYsY6dkVIy0
         f8mA==
X-Forwarded-Encrypted: i=1; AJvYcCVxJ0caBv63Chq8g0sgAMITZaGqeu/QXADucU4oXru/RNvi6Oqm5SnlYM641o0Ais1+5YeUDZQw2loRgBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzan4pHdMHDKjo9UMbELpxxTL22TcWwDPl6t9BohhM4BN4TLC
	sMqbsGYi1f8LFlpY9io8Zem00ImFCJcqtukui6PEOiIsE9vlqzRLPD6K
X-Gm-Gg: ASbGncv7sNiftWEde/eN3HeqLtlY9szQKq4kLKhkdB6fZMBoIGuUZk7L2WP61l/qgDC
	VytBlkNC8WodhPRKoThBtIg1hAQ2lFCAyuRgDRZqucDdAUu/YeUYTTEr3MNbLiC0gpdcqOZyd+j
	E+c5ZEPt+zrYfqUoVaA+tp/U6hnSTU+NqV3XTrQrs0HdsaiJGMusDwGT/tDmCKzo2efubNUUG1P
	4vS1PDCTrEBHzPqpYgpXJmyJW95AM/UXUOfWy+jtkzd85qnvyiHzTch8bkrToEwstd4ck9AtC8F
	G1heC1UbOQgDfltQK6eCPI2CfRRrQMhrj10o1c7zkM83PLkKiU527SCcJOeRgBKhIGIBvCNPsEg
	PPUSFr1bZIIMm7kBHWaNY4Wrv64ajEQOsfPrPiL7Xffj8+dORNewZf4n82p6p+wqzynqxd1jAGx
	aJ1uukkqHpjAiXmA==
X-Google-Smtp-Source: AGHT+IGRomaNwogJ4YJeLyfoYJL9WLvFP1cUCEllVYkQzMrcgYurGjV4rDtcFdnkKfabY0A66dSoWw==
X-Received: by 2002:a17:90b:1fce:b0:32d:17ce:49de with SMTP id 98e67ed59e1d1-3342a2497d5mr15967819a91.4.1759132609962;
        Mon, 29 Sep 2025 00:56:49 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:10a6:37a8:772f:4db1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-336bfcfc8c3sm2071443a91.11.2025.09.29.00.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:56:49 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:  [PATCH] bcachefs: Fix deadlocks between fallocate and readahead
Date: Mon, 29 Sep 2025 13:26:43 +0530
Message-ID: <20250929075644.338686-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


I found that bchfs_fallocate() only evicts pagecache when FALLOC_FL_ZERO_RANGE is set:

if (mode & FALLOC_FL_ZERO_RANGE) {
    ret = bch2_truncate_folios(inode, offset, end);
    truncate_pagecache_range(&inode->v, offset, end - 1);
}

So basic fallocate (mode=0 or just KEEP_SIZE) doesn't evict pages and shouldn't need pagecache_block_get().

Should the fix be to only acquire pagecache_block_get() for modes that actually evict (ZERO_RANGE, PUNCH_HOLE, INSERT/COLLAPSE)?


