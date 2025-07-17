Return-Path: <linux-kernel+bounces-735650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C0B09216
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA18D587B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E392FD882;
	Thu, 17 Jul 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="if6D8a1g"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EE2FD599
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770507; cv=none; b=oCJWZlnBcG1lh3eAFEtb6ITZ+6aE+MQone3PVhgSAQNc2+BNcNrRveedtUyHRdc407CSNuOXRIsyatd2W5Qq8/0J2txsLiC+6JB4uwqN7wBB0ioEsLXaFb3dml75ii2KErqTzkZyyzIMWW3Q/+069ZQ6pF8ef/7rHmW24ZQ0GAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770507; c=relaxed/simple;
	bh=7Eifg3KSSA5Jt2qx/3hzXf0HaiUdAumge8P2aIN3a9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8vDXJ4YSc/BJSrXJbbpAXRTiC7piVh+inA5CF+/9Fd/zWKDFTd6eKEYoyx3yIEnJqIdsUwBBNaFIMNbIl8yBSIiLGlT7/W89wJT1iBYpc1QBBKqQga9G/wfU9TcA1jjHwbgLWOO3ElSaix5pVs7B4vElwTGbiPC5BAu5pEoDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=if6D8a1g; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7481600130eso1596354b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752770505; x=1753375305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rHylqCjx1w2oDPs7/xM2Riq8NSJ9PhhkdUN4+cutX8=;
        b=if6D8a1gGyEUOtJ8l2uYCWsiyyKsNSl+YqtpTUMMmzyycSnOVza6Z8eLkBqKBN6/b9
         zCOx09Ew/HXJXBAipKIicZwKlS/oT4gU4owPhrTGQ8wYppHhNEr6fWvyGkgc0wYwMQTj
         mrBdqA+iXNuhmidoybQfhTERr2xczFSZW1yjVpb3Vey0FZsQiq2aFZuMrhWyVj2hqWMU
         Ks9yzlHOU8omBDH7Pb8zXigM2KTeayMHcKoY1kF8JFageEfj/KkYSe8/VSZVx/8zZ2/U
         FD/mylIO1Pj+FKnOJOXsn7kkWRXo8qsisJtCayt+oYk7qP/X1Zsgzee7HfDZekO6WXzE
         6VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770505; x=1753375305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rHylqCjx1w2oDPs7/xM2Riq8NSJ9PhhkdUN4+cutX8=;
        b=ZMWNeY2KMKPdAWQ3JMArPkZUAaLGWo+FCteii0z+vh79ssw4paFW9rnFnm5F5wxKin
         dcocEBq9W9P3P2fWo1VjXDCQNg3DCYbuPx+E/XE2yqnrgCQRzPF6pV7V+4lxyAjkfK5F
         yWWa1hTE4EXLItFyJLDvgqZnBOFt8tqzNSEA1JXZMrrI2N7GwIwBjhPQhup+ZERBN4Jx
         1JfZjihsPWPO6ywAWQKChQey9FM5pBiz8MdJrggtL7fdBAJHyaNQFAbtSuU3cP+WnI7E
         D2xtrdHLP8fDFVjPfL3NzUeOJbBMAfOeYC6q16p6mh9+e1piMVooVPfmdLzKvg2ZZI0V
         H4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXHVO4v0oSpag4Zh8zCO29Ik9VW6do/uELO3O6X4vKNuzAhhCKHgm/E4Rr3bvSKZFQqWD/X4tHyevSGLAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6LqGonqDS8LnNMHTRewX7GeA2LMaEwa4rGxbu5Vzt46Yombz
	pkW8sz3hKDGkXJExVovPbZx/bspdgiOZ83KDw/MrWTBNS7XREmQ6J9Lhz0n5aevgvSw=
X-Gm-Gg: ASbGnctfGwgKW+Hsnsg2YbyNmoxzBw1LdPbHqQW730M7XifvwBwoJDnqvV7qpOaD354
	HdB3Ir2OfPrzfN9atNj2Upq+3NQjuU4G8WIkeLch3k3y1yFKVnDJfBrh0SHZBc72HDVmxjVOMR1
	d561ElCz8o6dtke8CiGul+cj/LqD9KxsTw4trMOD8cEIvCeIjcQAmjoAvK8BefIXZlHmma9+quV
	+lRizQ9p/FDIE+q22e/UlmSz5cLfum+0WyuUtonUvRYZ2CgJFUQXHZOmw0+uyL9HpcndCMUtoPO
	3gl+6/fH9W51+njQ3f7pDbjdxvXvYlAd+0rfW3g4SeOQmERY57uUYAvcq1yoosUiIUtrNbDV63v
	x3cuYNr8PL13a8WwwcbReI0Q3CiAPEW5BCVngnAWoRQMs4nnLfw==
X-Google-Smtp-Source: AGHT+IHrQlGV1Z7kY2qfK70zL4oggkzABvGWlF/G0WdpxXkZbFgRb1/eSGO9ppbowS9YeBigJnqdWA==
X-Received: by 2002:a17:90b:4985:b0:312:25dd:1c99 with SMTP id 98e67ed59e1d1-31c9f45e1d0mr10064867a91.19.1752770505309;
        Thu, 17 Jul 2025 09:41:45 -0700 (PDT)
Received: from mystery-machine.tail542cf.ts.net ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf7e8ae4sm1821750a91.24.2025.07.17.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:41:44 -0700 (PDT)
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
Subject: [PATCH v4 4/4] drm: docs: Update task from drm TODO list
Date: Thu, 17 Jul 2025 10:40:52 -0600
Message-ID: <20250717164053.284969-5-me@brighamcampbell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717164053.284969-1-me@brighamcampbell.com>
References: <20250717164053.284969-1-me@brighamcampbell.com>
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


