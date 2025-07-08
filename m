Return-Path: <linux-kernel+bounces-721065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C820CAFC450
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61B91888886
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973A29C340;
	Tue,  8 Jul 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="afr9Ntr4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8929B233
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960355; cv=none; b=k3sy+XmJ6ctAxaDSQud4ZDKIYRU9MpM79OwomsAW3ckq6u+M5vASxmInUrwLbQpzSMNBshbFVhHNJPwoSdjPtYg0j1ngraQIeNRf9ZbigBAQBYmRAL77dDWZ8JjpR4NdIGDPtqDsvI/W4cH8GNP/RABHU+Pvd3z2jbckdcZo+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960355; c=relaxed/simple;
	bh=NXVzBmkzjs0qIwDBa1nvJlJYPXA8UdnEYWrKccWXZxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWE8Yf6uDBH9QlK2xz+Yin72pWrZgRYouoOC+ySa8IXM3xx5LGlDpHywmIobwjHtndaNrSE3YaWuXCGX5/fFrqRU5uoKmFqDhDKMRC3E8XHDgcuMj/sPT1zjmWJFiQIIKKwCrnlD72IkzyhNO+7LASU8vZ+ZjvgQZoxYniGz2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=afr9Ntr4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73972a54919so3537471b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1751960353; x=1752565153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRg4Q6pPPZIs4EHGk7HynlZtava7RS7MLv1CsBp8mUo=;
        b=afr9Ntr4TK7U2N1oafv7kWoRViw1SfgGaa+3z0FpQJ1JukdwTKbtb+u3S/w918LhcK
         VanL/Y2R5Zgopd6fybcSOwPV3x4hq0fjX81gAwqmA+aYXU7v2fVa79BSdn1XZQK/KqRc
         2DHHad4HSvqer7FQeKFZPErH7RKs+1UcGklRcaDr4xp6XWSy/tmPA89m93J5L1ExmYPZ
         p41G85aidGT/dr2I24ya/Trl1a9tO/OE9oe8KCfbaRYS32zOGzDW/36IuAvvs3RKg5sS
         8+jgZSuCDy1ZSsgRWFtC1kdp4kZZZaQWPrbRFTbAXK/WVgoYjOlGdS0XhCjKN6p9+1qn
         AMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960353; x=1752565153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRg4Q6pPPZIs4EHGk7HynlZtava7RS7MLv1CsBp8mUo=;
        b=WIH4W/zWDQmivV9hrQflAINIrPnk5Qf2jLT2VjzuG9GgacC7SfNpftto7iPIgC5N/c
         exxwoov7wlpnjkiCMsnGldG4kIA7yfN2Bo3bXoUvN+oE55Lf4GLSRnKfnLdqRR4soLxA
         BqlIWwBbv3pOgjUSuSl0vtW4IigVRLQtZrn1KHr1Tg90hEqvMYkTP6beZQNV/hHrssSP
         /yJm3UuzUARxZvD+7JkvoLGNkb6BGOQHnGatrTD38xetASBOxE4xr3H75zOTN5A1EeB9
         HvH0bg9Zr4fs7c3HUp1NJXfGRlrbIBdUJGn03z1OPNgm8Yr4iTYbCjWSZyJyx/+TeEKo
         8jLw==
X-Forwarded-Encrypted: i=1; AJvYcCXzEDODUgWWLqWXgr+gdjyQDGqpjkhyYyhRWSQpe4ZKuRtD96R/rjzH+usMTbecnA1y9bMKnXZBbeUugzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxg2nslG2rJlbhbOfy18pswDJNd0nOS0tzpQYuo2GH2lwvikWq
	zcP8mlE3GlSaftgK/bLolTm4eJG7zkRy1WjJsLb18/0zDqWjFI4/vqwu6qqBa3L9rWs=
X-Gm-Gg: ASbGncuU08gsLx8aBoAMIigkJ+prfwBjm4bKBrYLVMcdQyubSFjpr/JyNVeGwEYbq3W
	PX0opISTn2GkvX5lAoNeZfQ8ij5YESI2RZkIFL/aVN0jQvUsUOkLaiKPkAF00IVRW5ars6gwV72
	ccJmgzslrPUId2YtlRyYlAzXbBnUj9Xi78MSy8jtcRHihwklZ6sqrX+8r1OR58S2zUZaaUUADw0
	ou2Us9eb6uzbBGhsXmNt4yRZyKBs8tUoUPrWfCHhNhmVtj/WHetFXS7R3770srHdeNvb3efmkPo
	gjKv64wYKKlaFFDvc7tgDCXBzKcLIhL2E4kNFTDRmrhOnhbSApIPJYGWPcqgVC3Kl5MNZSRVWOP
	zDFEOjmutRu7WnOfNu971xoAX1tOG
X-Google-Smtp-Source: AGHT+IEnB2D8Zt2lhCwV3+7VTxWI7MKuZHKxw4k42U2GFJK7fV9zJULR3jSg0DBPKK8gXEtouNDbPQ==
X-Received: by 2002:a05:6a21:204:b0:226:d189:bbd9 with SMTP id adf61e73a8af0-226d189bc3amr13874192637.18.1751960352969;
        Tue, 08 Jul 2025 00:39:12 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a540bsm11633523b3a.140.2025.07.08.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:39:12 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v2 3/3] drm: docs: Update task from drm TODO list
Date: Tue,  8 Jul 2025 01:39:00 -0600
Message-ID: <20250708073901.90027-4-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708073901.90027-1-me@brighamcampbell.com>
References: <20250708073901.90027-1-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update TODO item from drm documentation to contain more applicable
information regarding the removal of deprecated MIPI DSI functions and
no longer reference functions which have already been removed from the
kernel.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 Documentation/gpu/todo.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index be8637da3fe9..92db80793bba 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -497,19 +497,19 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Intermediate
 
-Transition away from using mipi_dsi_*_write_seq()
--------------------------------------------------
+Transition away from using deprecated MIPI DSI functions
+--------------------------------------------------------
 
-The macros mipi_dsi_generic_write_seq() and mipi_dsi_dcs_write_seq() are
-non-intuitive because, if there are errors, they return out of the *caller's*
-function. We should move all callers to use mipi_dsi_generic_write_seq_multi()
-and mipi_dsi_dcs_write_seq_multi() macros instead.
+There are many functions defined in ``drm_mipi_dsi.c`` which have been
+deprecated. Each deprecated function was deprecated in favor of its `multi`
+variant (e.g. `mipi_dsi_generic_write()` and `mipi_dsi_generic_write_multi()`).
+The `multi` variant of a function includes improved error handling and logic
+which makes it more convenient to make several calls in a row, as most MIPI
+drivers do.
 
-Once all callers are transitioned, the macros and the functions that they call,
-mipi_dsi_generic_write_chatty() and mipi_dsi_dcs_write_buffer_chatty(), can
-probably be removed. Alternatively, if people feel like the _multi() variants
-are overkill for some use cases, we could keep the mipi_dsi_*_write_seq()
-variants but change them not to return out of the caller.
+Drivers should be updated to use undeprecated functions. Once all usages of the
+deprecated MIPI DSI functions have been removed, their definitions may be
+removed from ``drm_mipi_dsi.c``.
 
 Contact: Douglas Anderson <dianders@chromium.org>
 
-- 
2.49.0


