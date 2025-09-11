Return-Path: <linux-kernel+bounces-811916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C07B5300A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D648D1606D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AF7314B8A;
	Thu, 11 Sep 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aU6B+iof"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964D1A83F9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589669; cv=none; b=jLz5C6l9rePnnHeibidFECscgFNpgmF/WOnqeZdSuLOmP2gDJdgUe5YkAUTmjrH3u22dEqHO+b08+5wzS+uJQNikolCQFu6+MhBVralIwcFZ0DWcWqEBwczXoRT3h/0imXhvHZHi04xw0gZnq4JNpLZol6l7nNVHUcvsA6WKNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589669; c=relaxed/simple;
	bh=NR9ColaEp8pp+MDi+BdpeTN3bf0nrTUvX6PQQ5WUA/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDWCYnq3Tv0dDeu5FP1+IHMjpXLhxyGJTDp2YX2/oXdaDISH8OefI9WNeHoK3TPLFsoo/N3LtvXEWP2Pyg9E3vudohSrch5diV1BM2X1bovLVDoIEkY02u1ke4Vlc763joChzOqTwQfFPgAjaTXHM40BGSpF7mPKUdrzbcJy8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aU6B+iof; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-25634c5ebdeso5123225ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757589667; x=1758194467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVY1vKQIEXT8t/WKhvqXo/qXgJTq2qVTTi36FllHflw=;
        b=aU6B+iofyhJ7UZ0XGl3xLQFn6hdZn7+mazPXZ6JiuGjfQ0MzKjk9m17IFyt/iGOLDO
         8+mRJywySMS4Er9zTnTQSLsvbxTNOubWZgPYj9YZqlHXeI7TIIy9PfkGTqUzVl65FPJU
         bYt5YQYvBSEIINW5PTKgUhYJIBG7fLztk4g5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589667; x=1758194467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVY1vKQIEXT8t/WKhvqXo/qXgJTq2qVTTi36FllHflw=;
        b=axDVUuInwV/Yzu13pmRkiOI1s+ygkbESxF7WLGVZk13QyEqBZkRoO1fjhcdA9BXQqL
         AFYoCZJ0WqWdYYPVVkvBXfE/LL1aLz2MvwYSvpQim/O3UvJ0nLpwAzbirizrRseHJJVJ
         v9xBr+T1Nwn4Z+3a2EBt2MQm7vSlQBoignXsBUrlrxq/si/ll83a39gJ6ciC7023bkXE
         vamTYK7YGermdHZGcx8SIQTOoI5ZORFYvnMzmnkmoX5J6kWRnCYwxWSwssy4yhgj6dXD
         qvJknI4aG6WfJfK/HXW0Rci8ga2iS5p2gvy2D1boTqYrjXQr+/IeuEIKAyWFQI2M1Hwu
         deQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXVNsDHiq3smwYAGV0K7qO8xYHnKAAAHLazLFq40L8cNL73LXs7S5GgUBsIPoJkuzkfdj0c9fYwIz8mow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8a1lJTDkx+s/A4XuN4uXuzOlrUtvgD5a5K2VtcZ6s7G4TXXD
	bQdsBKsbvOWI6pxIm/MGQovBJubk7GgQSe6Y9qg40NiVobzfcdLvu4IMr3Wf1o9gEA==
X-Gm-Gg: ASbGncsn+soT+G0OlAepUt56yfArIM0YxbFY8YiRV+glvwmwJ1fAD53jRT04mG6tHKZ
	BYdRfZg2sMvIHa0RS0Jg51lXnBSGQTbnfyzY4TXJKnlM01dlFl3W11plzSbuEaM0TBCj9AJ9rUd
	R4u99Flutkyj0MYJWpGVbu+nUOTMPhhl9QPwv6z75lG06ZuG1Aq5tXn950cUXCHgKbI2rCzmphG
	5ezq8NfNmXub8EfdGQjt/dwKixiL29jiLjZJQrHe4CFKr0NXdRP5xBFWrGgTlIayy9L1Ac+mAvF
	A4spT2iQqyH9FDcU1Grh0B6rCXuQj6iYNK+GoCnmlfg2TPJfOBQ1C2/SSmojqfKRiXIHb5Cau6q
	8tWRDLfyyI6ZiMlPPwpkHuNaLyg0l2cD2FRBebq9mV+hZrOrU4TUMY+msjCi4bbV9jfrRXYy1gX
	UpbZ29Nhe2moY+DEDpFLk=
X-Google-Smtp-Source: AGHT+IGVYqzudMtnHrOEkbS6RmXPv8F+J1exKZWh11FdOLHldMMRIEyAHOkplwmjDYM8xR7w+eh+AA==
X-Received: by 2002:a17:902:e847:b0:250:c893:6cc1 with SMTP id d9443c01a7336-2516c8957d3mr201383595ad.8.1757589667592;
        Thu, 11 Sep 2025 04:21:07 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2a00:79e0:201d:8:af0d:1ce2:1c09:33c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6323774sm2348048a91.24.2025.09.11.04.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:21:07 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
	linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 1/2] driver core: Export device_link_flag_is_sync_state_only()
Date: Thu, 11 Sep 2025 19:16:02 +0800
Message-ID: <20250911112058.3610201-1-treapking@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export device_link_flag_is_sync_state_only() for future patches.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- New in v2

 drivers/base/core.c    | 3 ++-
 include/linux/device.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..cc6af9b0d59d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -287,10 +287,11 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 #define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
 				 DL_FLAG_CYCLE | \
 				 DL_FLAG_MANAGED)
-static inline bool device_link_flag_is_sync_state_only(u32 flags)
+bool device_link_flag_is_sync_state_only(u32 flags)
 {
 	return (flags & ~DL_MARKER_FLAGS) == DL_FLAG_SYNC_STATE_ONLY;
 }
+EXPORT_SYMBOL_GPL(device_link_flag_is_sync_state_only);
 
 /**
  * device_is_dependent - Check if one device depends on another one
diff --git a/include/linux/device.h b/include/linux/device.h
index 0470d19da7f2..e27d0bf7c43d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1197,6 +1197,7 @@ const char *dev_driver_string(const struct device *dev);
 struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
+bool device_link_flag_is_sync_state_only(u32 flags);
 void device_link_remove(void *consumer, struct device *supplier);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
-- 
2.51.0.384.g4c02a37b29-goog


