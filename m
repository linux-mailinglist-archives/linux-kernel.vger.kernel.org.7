Return-Path: <linux-kernel+bounces-859836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA0BEEB89
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633883A296D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB02EBB8C;
	Sun, 19 Oct 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQBMYkwm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E4219A8D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898930; cv=none; b=lgnOY5chYmWWvsOJXaJZjwkut7wt1KntMQ3FtevgzIUTvMw2EwsMJcgdEUPl7if0g+MlbUp9h26EeN7soe93lCQIz3yrR/skeBcZuhqMkfHNigAviAC9RyWvkLRmM2qlbd2fs85vSWVt4Uni0Wo4ufSYEbGxbeVQhf+cqcl+LNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898930; c=relaxed/simple;
	bh=xqB47To3mQeORWIHCfp6oFWavgkGL2Yi/RMlz/BiE9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGxFVRl2qIbZNWhz9MQs25m9QovIPYwpzUX7eFVTX1n3TSy3MeUp2jablp63zj3VEmuHMtreeMd5lamIldTSNhZkSVQJtfZwiHr8b5RkYZFiP1pdWeFv4XI9FuiKu8ikFNIoR7I8nt+OWELbySkKAZicd/fgVVD4i8VfzCPxcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQBMYkwm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290a33bfea6so4588345ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760898928; x=1761503728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRfOoLkKKIZ1P08u43a+VdAcQJSYKDXjEt4i3GhWSy8=;
        b=EQBMYkwm0/iMQXUmb3yphsH6690OV/3a95qLVnF4GkuqPED1xGYEwIL41GQVSzDtUn
         piHNH7c8rh3g8BtXFndfhkYo2mC3BwO+dwACg60Op2unqcG55aw+IkNq6SsvhTa+mQG2
         Sz0dO0GSa5hQFW3g1z8nQvN97XwP7IRk17fjQvUkZnfeNZvkmKlqP87PgTyvazi8x1j6
         ULz4zpxiDXIMvd7xsDt+l7u0TK63E9Gvs9MCVNnqZ04lNQVKfZe/ida3/5E1s2p+RqfO
         nq3l5ygSBDqYoC8jku6TZ6Po0TI9XVlWgcvbRFuYozCijWLc/+TO9EThj32dDBxFQzXD
         jyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898928; x=1761503728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRfOoLkKKIZ1P08u43a+VdAcQJSYKDXjEt4i3GhWSy8=;
        b=wS7h+kvYPVVPqFS9ze7hGL4IoZYHsHA2MtzoLBMx3VkW7AHLCK+HfFhlgilECU4ra5
         PC4L8vKt2AKl9c9b85SJcwLEIfce3ln61kb2zm8pUdXgRyIWwb1pd0oD+MLoXGJo7dPW
         cMJ1adDxS6ncMdGmAH1DvlPzQLTqQQ8k56H7XGcpnx5JjC3wwc5boji12H7eOfDqPC2a
         W6Q7jml2AtSnHMT7cuP0v9gighooEH8DyWkuinYzV5XINLTvWFe18oLXNW74TPlsuVvc
         +M+UDr3sdLRMSyyv32CmdltHst2xov9Kxd52KXsunGaTvaXVoz38qJdtYeOHJauETX+Z
         HGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4wdOhGFz0TSM0dqUX0gmSk/ETSCVG5xeLvaZTlZuySKua6XgOxSYdNBM8IAKMRLoQwXmL81qI+qUg8B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOrJt7H0oFpjKifgtQZbKklHKPP/ljNUc/a7JPhqjgqjBALpB
	EDGtYp28402L4UuIuGVyjexRE+AsOyOGxwiGp8rTf9f3VRDIM8dJ29o1xApCr3sSxRY=
X-Gm-Gg: ASbGncu31D8Q4iGqI9Qb1OJNv0Q73iQHWg/e+WMQiQZhLiNaE/d6HmVpKRP1CGzaVJ3
	Ivt6UDoAuXZh6bP7ZhWjj6u2rTCiYcyurmZ07rN8E54MwRHYOkY7Nw9/aw+0Jl69w2617eSu4N7
	PN820G6G6/sEqhveV/2VCIkoGH9kRWgAz4vB7zvIBfMSW0AtitCOFFNufTLiUiQXGVdysBFJ1GV
	Yj8JMo6uthpAT7UQhWC4lNNEfxA8ttNz+FC6trkdQGC4KAXmJTGIYE+pkisASwQmpkA/EVe25yc
	50iTZDWSjzVJSrMIH5gN4RTLSz8CJWnwoRZyqq9qUezPex0gWEyNDc0v5a+ZB8jo8yCguZJtdn/
	Mi+7C230tjp9E6548koz5tloBA/Djhd8mqvfT62+dA4za/MhWrtTICsPJdikGcHSuqJXddcjWw5
	x8NG5dhexp9g==
X-Google-Smtp-Source: AGHT+IEBr/+KS4HtviMuGoC1wIJRCMADPtQbZ3CNlH5yqb2pJ0Un5KgzQq3dwYcp0NYpYolDK9OUyw==
X-Received: by 2002:a17:903:8c3:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-290c9d2debcmr73367365ad.4.1760898928335;
        Sun, 19 Oct 2025 11:35:28 -0700 (PDT)
Received: from sulfur-sorcerer.. ([2409:40d4:154:dd90:39bc:ea42:d3d:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fde15sm58785055ad.84.2025.10.19.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 11:35:27 -0700 (PDT)
From: PIYUSH CHOUDHARY <mercmerc961@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	PIYUSH CHOUDHARY <mercmerc961@gmail.com>
Subject: [PATCH] video: fb: Fix typo in comment
Date: Mon, 20 Oct 2025 00:05:08 +0530
Message-ID: <20251019183508.20804-1-mercmerc961@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo: "verical" -> "vertical" in macro description

Signed-off-by: PIYUSH CHOUDHARY <mercmerc961@gmail.com>
---
 include/uapi/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index cde8f173f566..22acaaec7b1c 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -319,7 +319,7 @@ enum {
 #define FB_VBLANK_HAVE_VCOUNT	0x020	/* the vcount field is valid */
 #define FB_VBLANK_HAVE_HCOUNT	0x040	/* the hcount field is valid */
 #define FB_VBLANK_VSYNCING	0x080	/* currently in a vsync */
-#define FB_VBLANK_HAVE_VSYNC	0x100	/* verical syncs can be detected */
+#define FB_VBLANK_HAVE_VSYNC	0x100	/* vertical syncs can be detected */
 
 struct fb_vblank {
 	__u32 flags;			/* FB_VBLANK flags */
-- 
2.43.0


