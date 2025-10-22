Return-Path: <linux-kernel+bounces-865751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B9BFDEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D203A5CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433F34DCCE;
	Wed, 22 Oct 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3UA6Hud"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019734887B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158568; cv=none; b=WZ/3WNi9gDRAcT7A4VMeIWWnzuNiASLm1DnJz5QFTSHNG/tJoqWveWk6NG++R7N6415deRGtcXC6Fxska6YCTRdrQ3GJu+yMETQu0e3zPdM2KLvwDEBBC7zaS7DbjpKaLvfoLk1fL+UQ/UlgcNJjRLVa4JvGgmSNp8C4P+yBZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158568; c=relaxed/simple;
	bh=62Rd9Cj+tuLxEAc6371oplypJXVUPm0OX7f4j/blxSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0s477TIeCOuoDVlw9+/pEctIY1sKQ+6Mbp7v9IUPi6+fPxAJJ8skKMcKpECXTL4W4Y98q/be9n65SZ76uKs432wbRBsjLN6dtlmHV/Vku/VoCGCcAKnLcfI/f9fCjtHCsmJun3M3z62ZV16AhnxvzwYDYBLZT+d/24RL/0lqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3UA6Hud; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781251eec51so5699649b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761158566; x=1761763366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OaDPVD10QzAGywMTcZ8MVoJwwj1EgOUaXLk9q2JTmq8=;
        b=N3UA6HudxvgWUIjXDO4j629xlo21BLNMA9iQWqfn9FTqvB9BOksUxpongzUDqLZnD0
         jrusS04akv5oqzG7Mtl+xg2W110DRcUv8zXlFlEpwxI4DY1kNEUw2mMYx75qTEe7IeA0
         0ffNl38nW8yWQ3pVTvTZWczwVWFGrOBsrI1WQ5RJGhehUqS4WhxDZepbfTnTS+FKnVz1
         gd+BxuWQqX2aHeVZDhg6uaZsaZ1oKYRKfzsjJnDQNBsdgjmphmQDBnqhBWIQLyKeq6R+
         ijSRz8d+iBHJh6ZYaWP5ZxXEZ4t+YWWLNQml6fP7ZjRw5ya41xuiTLlTHJVx+74UIetA
         7LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158566; x=1761763366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaDPVD10QzAGywMTcZ8MVoJwwj1EgOUaXLk9q2JTmq8=;
        b=u6j/YCu2onDBadqQqnF4x0DfIr5xNR2DBA6HWzLXUorwniZGWuOmw8XynydltRRWNB
         hVLBvuG7Mm+O2g/1SFzfoCkB06NwwWQhOjpzV6Y4rCDzJslf0n1FelQVapNjrWkQEhJT
         h9AwJkRYcCKefUUDOeA0QAwy7grd3QqLBQSrqBJvMYi1h2v8n81WSwha6ah5IziUZWBS
         Rl2/9TGVVXro7KmKosBXWQ/ABglky/hCMENhFCSRRHoELNvZo/ccrC28l1NAMNGW/AUf
         1M7TfytT230BpeiMzJna945itPyuMZ0nWMeVPnsN0p6OjwYmrnpsnVr/jMied41kEeky
         XQxg==
X-Forwarded-Encrypted: i=1; AJvYcCVZtN8I3g/WgrRffMe3wkdjNNZWdzo15Z4bNX/jHaD99rUUkmIXaV+5a4b+L1B3Gg0YA0bXzzHLcXg98Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOczZj0j5cEDtYszQoPsFuJ0nsnA+yCb3lxbpwIK1ubUm9nmKc
	6CN32bU+utFub52y2y07pNUQMfi14Nl202fW2c3TT6ezAMcknE+78CnY
X-Gm-Gg: ASbGnctWhNRsdGhuK0uTVqfkJaaJa3DYDWqB7YdNuzyUSOvFXuAKpIp00OTZVcGzMwA
	WMCuTP2Ux8GvkS3EsnoE994fyvRjLKukssiTn9f2lNQLa3M8H7rJbuEunEI+CiQTFuVttIZIeBE
	XCppuU0dWQXXrl/jV/10csrFHQ31ctLuczpRpEoRcp392fb77N7O5C+N1jzaQkyR9yJows7ozxr
	iCpx3gzmlrg7CksDByiLQtwYrPNpWIhhVLI3q2dpbp217VpwInXoEaRoe7sLqYyP1vEU/OJookX
	cpnHuwW3gfLGEqKXlU4Et4LYYcePuuxpJrL1t5Ric99XQVnG1uZOexBJHXT/s4LpG4IhEP4vjFH
	7Q2Ae0TmOOdAsgfkGwp9hvvTuiZ953wQ/IpwK+lsvLlxZdflg9Za3cZoL7IayzAJ2nlJJ/1P0Yg
	5ksg==
X-Google-Smtp-Source: AGHT+IGEuNl7KxT0ZBg1REm9jtYV03SiCDzrf1MkAQZm9SCvvp7AAFvvgs3enN+dhrzrLl2aRLXWTg==
X-Received: by 2002:a05:6300:8052:b0:334:a916:8b4 with SMTP id adf61e73a8af0-334a9160985mr26107060637.8.1761158566294;
        Wed, 22 Oct 2025 11:42:46 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:bfa2:49f8:6793:8484:a709])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f7absm13489547a12.39.2025.10.22.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 11:42:46 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hpa@zytor.com,
	Shi Hao <i.shihao.999@gmail.com>,
	Smatch static checker <smatch@kernel.org>
Subject: [PATCH] _x86: intel: pt: fix potential null dereferences
Date: Thu, 23 Oct 2025 00:12:30 +0530
Message-ID: <20251022184230.124113-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add checks to prevent potential null dereferences of buf->stop_te
and buf->intr_te in pt_buffer_reset_markers function.

Smatch reported possible null dereferences of buf->stop_te and
buf->intr_te in the pt_buffer_reset_markers() and when i checked
both pointers were checked for null dereferences in earlier lines
however,after calling pt_topa_entry_for_page() where its return
value is NULL in certain conditions there were no checks for further
buf->stop_te and buf->intr_te uses which could potentially be null
dereferenced.

To avoid null dereference add checks after each pt_topa_entry_for_page()
call to safely handle null returns and also add checks where there was
direct dereference of the pointers.

Reported-by: Smatch static checker <smatch@kernel.org>
Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 arch/x86/events/intel/pt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e8cf29d2b10c..2b7d5d118b48 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1148,7 +1148,8 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	if (idx != buf->stop_pos) {
 		buf->stop_pos = idx;
 		buf->stop_te = pt_topa_entry_for_page(buf, idx);
-		buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
+		if (buf->stop_te)
+			buf->stop_te = pt_topa_prev_entry(buf, buf->stop_te);
 	}

 	wakeup = handle->wakeup >> PAGE_SHIFT;
@@ -1162,12 +1163,16 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	if (idx != buf->intr_pos) {
 		buf->intr_pos = idx;
 		buf->intr_te = pt_topa_entry_for_page(buf, idx);
-		buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
+		if (buf->intr_te)
+			buf->intr_te = pt_topa_prev_entry(buf, buf->intr_te);
 	}

-	buf->stop_te->stop = 1;
-	buf->stop_te->intr = 1;
-	buf->intr_te->intr = 1;
+	if (buf->stop_te) {
+		buf->stop_te->stop = 1;
+		buf->stop_te->intr = 1;
+	}
+	if (buf->intr_te)
+		buf->intr_te->intr = 1;

 	return 0;
 }
--
2.51.0


