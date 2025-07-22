Return-Path: <linux-kernel+bounces-740079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DEAB0CF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04687176A57
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711701E5B71;
	Tue, 22 Jul 2025 01:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="d/mxqrVu"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1001DFE0B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149209; cv=none; b=AfJImu5t6cdxe8uVSsB7Ig1gEvZszYLnEBDu7HU4jV5Rv9wmc6gHcgTM6yKzkoRnwegXolyLQx/w1tBHqnnSUz6pCm5qJU4qZt/splDDDJIP+jG2uvuD+zEg5CJg2uqxpxkmjzGYe+/+qBokOZGaDvhGfuRaWp8ny5mPbcBK8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149209; c=relaxed/simple;
	bh=7Eifg3KSSA5Jt2qx/3hzXf0HaiUdAumge8P2aIN3a9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7JY1FrwzDGWQdTYAiJQa0TMp25Gx5OU9c+AOX70Eqkn3R6NHrvSj+At4fS2dUUtSJYoAi5VXBy/GP9/ul2Prz+unNnZnXuSyE946Qo5G3YWcjxlLCHsRnfBwsoGRzpaCZ6UGaL3Ye9yH2PhItw1gakRJ3Tyjq6EGeidl40TTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=d/mxqrVu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4436393b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753149208; x=1753754008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rHylqCjx1w2oDPs7/xM2Riq8NSJ9PhhkdUN4+cutX8=;
        b=d/mxqrVuV/nJGiDTPI4uKTSBnYtBuGqiWTEBw/GpcyLGTr9ymVkBt0rr+BZcmMvC5w
         MiwwRwJH150Mq2n7/tX0XePIdYryksrd/NJcspM1iuf/lSQRP2vqozqIhjRl1tyR3pEz
         gdJ9xefFjurGdpWo1lPzPDUIF4VJTOzjXNr2gUkg+Ok7ubHv9UzIzkqrzQ+B7wpx/h+R
         R8hsoh4dZg/HjfiBvX28JGz68nq161pz1jCHiFHorhNxEoBKQF9OG4J2LYPPmFsJ0RfW
         sJJ8WlH+kuXrNtjMbX0WBwCbltsIEa/o2Zt3zoFl1vf10XntK/qW5J9kKp5qzer3QwjN
         nZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753149208; x=1753754008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rHylqCjx1w2oDPs7/xM2Riq8NSJ9PhhkdUN4+cutX8=;
        b=QcM4+Q8H6QawfVVMV7LK3bkzAYAeHDWO/f7+8Q4Hy4oV2UHj6xvu8iLWOW/cVKUGZ4
         nmHDlvg4TtE3rf9ahs47ekpwHFWiUPx1vWE9VkcxxVueSWdTeFlkcWoNTHz2OSbpy8jM
         z2D61PJUaSqNoVunj9KPEsHEA/J9XGkuoqx4l+o44djJiRKvmlrgAhjc5/kwIv1TJI3X
         sLizFSdgGXtdNqbFhxcgTARCSb5COWiPlCz8lXrNsRmxc2UkVRQhLiNmeC28bBhr7lp1
         dX8Nk/m/DpFVhy/hBHgaRSwWuzF4Qbulp97Pg5wxeyJFrueLRoNeK7al/4/jI1RbGdSD
         xeFg==
X-Forwarded-Encrypted: i=1; AJvYcCVR55KkAwOb+EZQWtrcsSyOWhyzoreKiP2Mco9ONJSWH2onq9c70q+3zmzCNbC6lKSEUSm/tfWllKmhwbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSppl15oP0XvrC05lBPZL+ZleuO1pGxoZLVCGcrL2pa9/K7M6r
	GtPIth2Ek6lX02tEwUi2JFm5IDsIm8qtTaLEL6Dt367l5p/jZQLpj/iPVwDZsIuFebPyUZB0EY0
	FImS4WL5xjQ==
X-Gm-Gg: ASbGncucYiP53abIKXJbTUgcJ2vnKUIWF0Qy+KOUkT8BksE2nGhTNV38IyfHAgzzBFX
	2HQKGEVb/cqZTXI5/mhP6NkpL2UK7Va8HnwqPjUy/DaL91TURc16t6EfAwHzS7c6hDpbY0tmEW/
	x2d84bRkVu+XVxXGWh26Is8LOTd2b99J60gom3uycrRnwsmwloBjL5l2CMdGzbpb7JJ0YevmOSv
	28XZYE40tt3EoioDs64i5g6CzQaod/joY/r95eh9yMbADA8rDtKlMThmZs90qQUOu4ZOgv82QZk
	DotFtDS6CbV9Mo0HDOiavcLtI31zCk6HfSySIFGbTpi+MENORF5iTyVApR9H/nHENr0YtoNL34m
	R5+jQmet7y0ww7ZK/EwLVGIuBZkhjdQVWdydcqy4ANUAxBhYTiA==
X-Google-Smtp-Source: AGHT+IE6DV4AnVW0+4Gsag1rZoVLI3l8Jq88LM8p0J3ZdDdDROI+eXGNgt3ap9Wn8cOMjGOum41DxA==
X-Received: by 2002:a05:6a00:2e0d:b0:740:67aa:94ab with SMTP id d2e1a72fcca58-758462d74b4mr25646084b3a.0.1753149207483;
        Mon, 21 Jul 2025 18:53:27 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe62d9fsm6017441a12.1.2025.07.21.18.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:53:27 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
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
Subject: [PATCH v6 4/4] drm: docs: Update task from drm TODO list
Date: Mon, 21 Jul 2025 19:53:11 -0600
Message-ID: <20250722015313.561966-5-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722015313.561966-1-me@brighamcampbell.com>
References: <20250722015313.561966-1-me@brighamcampbell.com>
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
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
2.50.1


