Return-Path: <linux-kernel+bounces-880934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC7C26E75
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E66B1A25F06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9986329C62;
	Fri, 31 Oct 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BHzRCFab"
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAB328B48
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942881; cv=none; b=dV+5n4tjL0EnyFa+hPxPsoSSRigvOodCOM+EEnzWFUmAcVV2IDk3iT1AK+2gZwDR71rE/Pa/QyWaEdnfULtzikXbg9l1sBhvWTihf9z2gh07CFLKTO87RGdz1QhBd3pREGQLXunFn95XMaMu+xvgjh2FNImW+c7AXoE8RQt1q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942881; c=relaxed/simple;
	bh=C6whxhY2k5fPAXSikyioIezH+fO5txoMclXOMXtXotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNPsc7ZisvEenqwlciST82ql2GNeS8zbKzmAP212OxnJJW1UiF+ltgAVHOEt/T5s52LXsLOJtN2tsxrccDm48jN4hSCOdL9eOvzRkxYhhzW5PS/vH18WrFE8RXklmeAQCpEtlLiILsmX3H1D931UNIQd6RUJWExq9tcrBvJh0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BHzRCFab; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-378ee1aebfdso4143191fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942878; x=1762547678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=BHzRCFabhiAWethpTxaoampQf4oPL+XouXKbBZxEG8mFL1FqS0EF9jpZN9UQ9wgzoK
         OZNRYic/S9lVXkZF+GytR7vTTrI/3+WOcb/nhJ1KpaRHfMaDUXuvOe0ncwLthQxgJWHK
         802pT0+3ovV/QNVTFvhTCms70QWPuaIXoyqkOTKNz4gSCc7BDLIReCo5noxgqf6fFK8f
         heqDvTywyL84V7XzxDYd9n/Jr+jrKlZ2YFR7+8ssV13ZkpSYevogr+pV+0FNNDU1zb86
         PkTWXQisezVYIfpyBCDOeYp2of0/y/mE2LfKODuUTdZQVDVjER8KDWxli54z8W9rrP7C
         hQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942878; x=1762547678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=YWF0rZ/fZHIKHsWvGJ9wXk3q0MPcaT1ToatiRBUFIZFaDAUfVJNHe7CB3Oy0QGjoBt
         KhMYZ7WwemL2URAPQOqYTBXCVuxzeYsfAqE0WuoZm72ENBU9WCQnEK5sL4kiSXVDw2MP
         uVYm0EYry4INllAeWF9SrRyMJyliiWKbqwOqlspo5wTKax9bz8ouizX2UlCU1JlXHx31
         gAhf2rrDMIlboyKDN4hG55OD+qhU9FAVubGC3slSTSF/wZ8oFzKBagia5j5ixP9PwVB1
         Z4venzp79EG10LPFJbJg1kk0CMI9o7raTPxOVHFkiPw47HrKPczTcl5NLbwcUslLMwt5
         nZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjd4/tKQ4ZozYRWVjFl738EqeqrRsTZ5Uz5bWfmRdslDu4nmNnuI4OJ6AutkFrIRUbZVc+JzV2xtVIi0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwPJOwM2HSVtCMTO5twBN96w4iXfOwaQMW1RGmC7J/Fpi3EAQ
	FVDrvesQHjzFGKW76RnliptwuIWPh/DWUDDEhUm/oZLkPI8X3BhT3sozkZU+Owr4WPuXRRugvwt
	BSaN8svBS0UTWXjMvZQj5y5Lu8BObfXMX1kdSLzOkM79ITw7SiJll
X-Gm-Gg: ASbGncsLSddzuYc3ymYdhKQVodAdL9QdBoynC5dUBpv1bMktC60niYi8Q2CuxwesioK
	LV/sZcnkzWnziuNMZRC/sYxn6XvsTTgP17eLVlG1DIUOZpANNbEct0veSZqsNRJdDkrC2rzN5Ya
	BiXcwhIMSdS09Ws4jx5a8Sfgbb/xcJenxjS4MqxJLUCbVQNBIbl31pbVZhL4k7yp6UBQLZ6cPQR
	yrsZTrKv18cc4f5t9yJb05YEe5MXt7etlvHNgDEwbHguCLjisS0X1zpWuucDzKRleAUf3BGtMiy
	OV3qJxMcSI4GTwtYE1uCWyjgyi5j6AhOwXRt8zyxxcIJd17UqLnryRgUvC2h1lVRI3u8BLOIoKk
	k2ApstYdEC8XtOWgA
X-Google-Smtp-Source: AGHT+IFkklfQMtwtYHctUmXUj84xAbmvWB5viNqygwZDDgD7B4MpJ/ProRXWufuferuOhixNh09lD4F7KOks
X-Received: by 2002:a05:6512:4025:b0:55f:6637:78f with SMTP id 2adb3069b0e04-5941d5539bdmr914999e87.9.1761942877597;
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f5b5c33sm282549e87.37.2025.10.31.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DFCEB341B91;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DA9BEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 1/3] io_uring: only call io_should_terminate_tw() once for ctx
Date: Fri, 31 Oct 2025 14:34:28 -0600
Message-ID: <20251031203430.3886957-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_fallback_req_func() calls io_should_terminate_tw() on each req's ctx.
But since the reqs all come from the ctx's fallback_llist, req->ctx will
be ctx for all of the reqs. Therefore, compute ts.cancel as
io_should_terminate_tw(ctx) just once, outside the loop.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93a1cc2bf383..4e6676ac4662 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -287,14 +287,13 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_kiocb *req, *tmp;
 	struct io_tw_state ts = {};
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
-		ts.cancel = io_should_terminate_tw(req->ctx);
+	ts.cancel = io_should_terminate_tw(ctx);
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
 		req->io_task_work.func(req, ts);
-	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.45.2


