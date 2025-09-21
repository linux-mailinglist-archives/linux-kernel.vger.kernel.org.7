Return-Path: <linux-kernel+bounces-826335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF993B8E36C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843C317E2AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5F241139;
	Sun, 21 Sep 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfIY586U"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3819CC37
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480028; cv=none; b=WNGxglZu0pfe454vcPEp8426L209J65MZb+Gaw9HzV22k0B3nIi78GFtBZyN2vvDTqEppW9Qegwy50DMA+RK1Jh9rjnHbFKBkVihI9GoYGcc6sAfdnTeWrP5tYge7Ic3FIfNs706JXJPYpK6F9H2xVa3zdBmg9+kSwtZA7Dfrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480028; c=relaxed/simple;
	bh=5z6F54TPmn+MomJgT0ZdZhQGhmjNqbgLAOKBnU38yRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYRfcJsTJeCkylnl6gO9YE4qN/2mWuHzGot22xDLE38Tei8dnX4TE7/FMShxFeclitRgK6aMeaH0z0jHZoIR3WoFboSe5G8yoYTL0PSsLFB9cPyI9wciT/rrwzhGftf4Ut0gaxeuKDBSQE9bmCGPnzq4gIHLpS3Qz5lUFCvfoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfIY586U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-267facf9b58so26673725ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758480026; x=1759084826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wLzqxcgnYwT4Poz7HHxN7qrlVYSiEgUKNZgrhHxkio=;
        b=PfIY586UzySlnmw54lqcuURSDSQ2yAOwJsCrmG8Xs02LeT/grzztG3xlW/MstsLwvM
         /BJYlbOwHFt9EXAuGGay+s8/gqFmr6FqNiMcpDWuZSMSihN0xoVckjbh2zVbSSHytL+o
         toeWSKD2AwBEv9R9wLnZqjZco9/ggJfUaYG3+otUlOvR9NrkVVn6Iid/LPoIp/wboGmT
         GqrAZwKHy8OTq3VqyiE6AURHZQPA09QbZPb+LKS2CxGLtclsZDnQC/EURiYM/iQOmnN+
         xa2kZOMS5AX9v0Jb8J92o/yPp5cUuCIWcrif0rJWcG6OuNHI1kYh7VNEOVH3DdSL7SHz
         HO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758480026; x=1759084826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wLzqxcgnYwT4Poz7HHxN7qrlVYSiEgUKNZgrhHxkio=;
        b=D+HgfQr+SoQy96KTBky3M7/XK9SXVMTUFmIV1lrDGCTMV5MSsxoHM00ZBIUmTJzI/0
         TyVRQEt5X3eK4ZLeD3jJz2s3UGIJQbYfte2SNmtfs9HZuXln+JN27VgWu/rUJ7z70K/n
         /+RsaVHk7USH/QEcriipOMr/bB0Iz2wU4C+Pb7k1WPvlM7lg2hklpuYa+f6L66RI6GaE
         Srz1EplVEgnMlo9hB8YwuqgDWb10TU4+2sA+vC857bce4MWubcoGrL0M1VXkR8GREhEZ
         vhmfxcPV77o+CPUYpKwrSN9RChwDTwSxCK/DbfjlD0g+cYdd1Q8k8VEfWzR6EQG2CJgF
         145g==
X-Forwarded-Encrypted: i=1; AJvYcCWZwQ3i2pxdHnHQjLIdM8MMnP8lkbf6iZSUqo3HabV5pYuRWDYqWsvIjwGfk681cfmOsMlDkK6yg1PNA3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJ1csgeMaYQpDiyn+R0hRvekqDtIkSkZC5Iimf5jltvKWuOAD
	PHzK3WbVvLP0gYcWSybmxvB7OKPXExXUGTpKCwDXq6a4xGkzo01Et6vZ
X-Gm-Gg: ASbGncsZ5te8mqrFUK594Oulc5npxXcxkj4n+zXHQUMiFl4SMmeFNWuDiALj8NOTkd8
	9jXvKlKhzHF7sAKKTf+wcbC3uuYXScbiz1mi1v8/P810Ns+cZbv0tPYHeRY5HnFlAyUVgxYtVV3
	KK5XIEtcXpj33kViPIpg7SYBJEAmac0zDr8NFAJ1qq4P52ZaK7GobeK1cPsWtNYs0dgtWFh28mg
	qmQJJbdnoM3gdIvTt68ETGGNFwfipV4ZrJgzOZSyYS4kO1jnTSjaQ3ddYfuK28YeQv4Snt0cO+0
	BIaI7Ixj0lWYqgPdOlu7HtX5TMp5csw2A6mcO8r574UxRUy84xi377RLChhLQSC5HT9FphccqIo
	dtSl/0SgIbzEeJAWDUrrYpYV819GI
X-Google-Smtp-Source: AGHT+IEtWuYCyhgsDqIGrs0SVKnauGGAW7P33Isy0rJGQr/jYIj+u9i1Vy91MNpDnJyerCFmD/lfjA==
X-Received: by 2002:a17:902:f612:b0:276:305b:14a7 with SMTP id d9443c01a7336-276305b1691mr23964445ad.33.1758480026625;
        Sun, 21 Sep 2025 11:40:26 -0700 (PDT)
Received: from fedora ([45.116.149.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcbesm111053795ad.88.2025.09.21.11.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:40:26 -0700 (PDT)
From: rtapadia730@gmail.com
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jessica.zhang@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH 4/4] drm/todo: remove todo entry for deprecated mipi_dsi_*_write_seq()
Date: Mon, 22 Sep 2025 00:07:24 +0530
Message-ID: <20250921183720.237761-8-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921183720.237761-2-rtapadia730@gmail.com>
References: <20250921183720.237761-2-rtapadia730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

The todo entry about transitioning from mipi_dsi_*_write_seq() is
completed.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---
 Documentation/gpu/todo.rst | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index be8637da3fe9..76afb8a784e3 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -497,24 +497,6 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Intermediate
 
-Transition away from using mipi_dsi_*_write_seq()
--------------------------------------------------
-
-The macros mipi_dsi_generic_write_seq() and mipi_dsi_dcs_write_seq() are
-non-intuitive because, if there are errors, they return out of the *caller's*
-function. We should move all callers to use mipi_dsi_generic_write_seq_multi()
-and mipi_dsi_dcs_write_seq_multi() macros instead.
-
-Once all callers are transitioned, the macros and the functions that they call,
-mipi_dsi_generic_write_chatty() and mipi_dsi_dcs_write_buffer_chatty(), can
-probably be removed. Alternatively, if people feel like the _multi() variants
-are overkill for some use cases, we could keep the mipi_dsi_*_write_seq()
-variants but change them not to return out of the caller.
-
-Contact: Douglas Anderson <dianders@chromium.org>
-
-Level: Starter
-
 Remove devm_drm_put_bridge()
 ----------------------------
 
-- 
2.51.0


