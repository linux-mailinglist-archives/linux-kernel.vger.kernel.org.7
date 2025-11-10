Return-Path: <linux-kernel+bounces-893610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392AC47F56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4775B4A1DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F88277CAB;
	Mon, 10 Nov 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMEicDqX"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F687273810
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790911; cv=none; b=l8QQ2kuZid0YnV0fxKgSNcc3l2wioYKiNGvt8J4OS6eUO749BrppaTqZMcloZZ9TiUMh477pP3WZVCypvdeHujbw2+EOptMxRtAU/yOwnXRdPbMiqT9xeOE4zRc3kmibXziKWsaoW/AEA4v5oEfnw/SF43h9IlbzMpnm5xyWQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790911; c=relaxed/simple;
	bh=Is3rxH5JOhVRDhI5rEEZQV/eyVv9RIxbRTXL8wkaITA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSSLe0fkXXGHyxd8l157diJmeUt+ETxSVuDear/dc832gSqFynzF1CH2oPPgxPCGCEqeWYR3uZ+8AjetMJ6LCrtMxBvnOPVxa3R7wffxC5tvW7mxFRvcz01Rd9yxc+lKXgLAfeH7G56Y2eJLebJ4/WywLH2REn5qqotqLXGF3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMEicDqX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso2648770a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790909; x=1763395709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOEhLtmqwJvQkcukCJBLDCsQYr40AyxUB4yW9Ul+8kE=;
        b=HMEicDqX5v8u51OpjMn8WFBM6L8x5hsONbRjnVelIPTTuQjTVYpk92jNLKYavQ9MLc
         b1EUi6wkqDxyCo7LR2uOWUZAk9Y4YE+BOcWaKdFrwe3rDvw4uKYpsHqDK1sw828yPZSX
         Z9lnGoAm0Wyc93PC3t+/MwUc/jb3uryISIZHXZ13RTJqDnHEQNYubbsk+QPvb/Q8Y4Si
         6eWwksTFXthbZ/KYacluxxHrqOIEBg4WJMQlLN9ZItcJb9OPLtOSnLlMKu04aTmfrwLK
         vv7rr9GLaYYd+BB+XNPnnSmVMX/NDasay+UpGHaBEtzR3JcMuT/8FIME9acGFp6crwmA
         DC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790909; x=1763395709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOEhLtmqwJvQkcukCJBLDCsQYr40AyxUB4yW9Ul+8kE=;
        b=bFPVEIlAe9myFJCMDBOT8nWC2nXKB9hzhXRJVEifJ4mUv9qGlK9Aa0CzRvYw8twJkQ
         2ex3pL9Cu6thcVy+M6q/YgtY0DfcF6Ir8fBxMuzB92vyPdQdNmLzcu5y5sRZWXcR/QMa
         +qPRCHSzb1LZ2KShBXJo/VBl8qCX3HKJaP1wChcN5wVbi4wSIhDipvc2keCuqjXkJfsS
         ufNGTQZHIEUjJLzYMwC4xspAl1bxxY+YlLNKW9w1NeZpVywVX07I/MrmNb7E1irF2RDH
         JahVyv0iF1XbcPP7qZ5P0XCtfnrGPcnghzXj+UNC5i9Oq8bxR5GWUVNnqde6jyXK/Cc/
         mZsg==
X-Gm-Message-State: AOJu0YxWxADpyXypM+hZjRQESV2sMkRXODknYA40I9q30+GE6sxXFqtK
	DGy/VJAlIAhGIt4tV02WLAQ8fbQoCpo/K/+8eSDPJJiEApRGfXQdg7fIjngFwkJh
X-Gm-Gg: ASbGncu/NalhHdwaouIdNSQnx5wYnKknQsS8JCVavxJXWHxZA0TmpvHMtEcQv5kduZW
	ZGLx6k0QJJhDOpSyrfYBtulZZS972BhzUsRuUOHlkCZARkEYBRbBnIGVQxDJrgqejhK/laRqBTw
	LC2L6Z+oPJS0Mc4SWx6lJd5KownT9+lqp5KMhrTAWXwyc+DB44Ffsz+CyDM0GTwKjhxAmRsIt7K
	7joaqnmVLJfTUp1x9DTJyAOIzgdyWL1wJ9PM19d8JVqJ3Dd03P0MiMUKlz3KRdYO7sAELzZ4vB1
	NDbgPgBquc6Lni+/nY8+hQ2GlVXaCGfx9e/PE7dGOmGId1B1zHVItYBZWo7e7DEpCodZm8mUpg3
	m0FI3cvG98qbHubrks/dla+mLY3F2/Ebgyvi9/zibHwY/lPqJW24rPqaUGNcHOCeHBnN0Y/C/Ck
	xGTsub3l6K9ddDSe4ejhvhGPhnGG8p9d9v
X-Google-Smtp-Source: AGHT+IGbpvlwu0mFvO4GmuLGLk5VScWwk4yNl8IlzCTRJTodqydRninvxxmlMasYD57cf8OIMXGSCw==
X-Received: by 2002:a17:90b:2d48:b0:340:bc90:d9ad with SMTP id 98e67ed59e1d1-3436cb91d4cmr10482991a91.10.1762790908614;
        Mon, 10 Nov 2025 08:08:28 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34362f1f231sm9308893a91.10.2025.11.10.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:08:28 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/4] make vmalloc gfp flags usage more apparent
Date: Mon, 10 Nov 2025 08:04:53 -0800
Message-ID: <20251110160457.61791-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should do a better job at enforcing gfp flags for vmalloc. Right now, we
have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
supported flags. If a caller were to pass in an unsupported flag, we may
BUG, silently clear it, or completely ignore it.

If we are more proactive about enforcing gfp flags, we can making sure
callers know when they may be asking for unsupported behavior.

This patchset lets vmalloc control the incoming gfp flags, and cleans up
some hard to read gfp code.

---
Based on currnet mm-new. Linked rfc [1] and rfc v2[2] for convenience.

Changes from last rfc:
  - Collected review tags (Patches 1 & 4)
  - Add unlikely keyword to help the compiler
  - Replace pr_warn() with WARN(1)

RFC v2:
  - Whitelist supported gfp flags instead of blacklisting the unsupported
  - Move the flags check up to the only exported functions that accept
    flags:
	__vmalloc_noprof() and vmalloc_huge_node_prof()

[1] https://lore.kernel.org/linux-mm/20251030164330.44995-1-vishal.moola@gmail.com/
[2] https://lore.kernel.org/linux-mm/20251103190429.104747-1-vishal.moola@gmail.com/

Vishal Moola (Oracle) (4):
  mm/vmalloc: warn on invalid vmalloc gfp flags
  mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
  mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
  mm/vmalloc: cleanup gfp flag use in new_vmap_block()

 mm/vmalloc.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

-- 
2.51.1


