Return-Path: <linux-kernel+bounces-808952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F302B506C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908AC1BC0C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705435A2AE;
	Tue,  9 Sep 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xam9H3Fa"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000F18FDBE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448896; cv=none; b=rIt2dhDhWtPWx0vlRTBUL60gqdV7iDMgf+f+RGQCI7vln25PsLxLoiobHRSL39gUdOHG7dnDtrZWewZfxf9xnVE/w3R6rjojLoY/iR5FgVUPwISQY76k0d6APZBchgGRjDRLj+sgzjpM42K0oltH8TMa9dAZPFfUr6a5HRBVPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448896; c=relaxed/simple;
	bh=ZOuaHMKfR8Zy1i8FE///Vr4P10CU9jcZA16m5SKQQQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoD7IbwpjkAXxFdeC5u3jPtFTX3xDliWaRxQFGRjdmq2EZcQ8tNeKOu43znqxTwoXn1FX1A3d+qwmU9Zw0lDJGMYaA27q6XVMFYqafG8MR5phbFg7ICMT6JtO395uy1KSX+d4nYBw/f3/v4JTPyrASLN4hhuUjBdzgCI+8Iagfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xam9H3Fa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-251fc032d1fso40008635ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757448894; x=1758053694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ1ukxZBrHz0fiIU3WpENCsazmLFih83mtFDbzGAzqs=;
        b=Xam9H3FaWh6ZFPPvjbKYmeQFjjB0j6L/CqsZJP8Oy+NKxQIqYPbEGLR3a3KaJOMDJ+
         pJpE+nvvJcLolgBAQKnt3yvWZaLAbgeL+2x/jF/bzeMjyb1NDWciond6n4rgH/jchBjS
         Y+pjMq8b4wqGCKFmMiXEmVDW2j0NCh/t36jyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448894; x=1758053694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ1ukxZBrHz0fiIU3WpENCsazmLFih83mtFDbzGAzqs=;
        b=kbwbj95mYPBWTnn29GoqzSzzjDEnGn0ikyXI6shatmxNPtOpAXxkJrdHwTNxexHsfi
         1L2Bp7Ww1LD5l3/SSf6UW5bxbRfSbmAfuuAQr/wuAiv/lCFA7ih6lO7oVxJ5sQku4Klp
         /fdouAVk02wRjL601VrSpF8BntYUSQj3lFSdWbbJ4AfS5UcCrZfIgkWVa9npT4nY/R06
         h+A5jIl9NuZJmV2BvsZDUyDDI7srd3ztFxPTUjwkgsXIOo4ak0wx3zWgdyhjc+TCmxRX
         +EQEMOHlqM9O0bJgwgmC4AdE9nhRRulBg3eQI3k1DiqB5z1K0eoI+jRSNphMW2aPUY7y
         T6jg==
X-Gm-Message-State: AOJu0YyimiLBzWyWQpTYXG9bxACnUsxzlEH+P3H2ib3Nu5Gq/AdaEZDN
	lSMpIRgyzbtqlqStCKegMMFWnQ4gLbqnNmtuqfRFNbQ3MjeQv+RuXMZCPoLyT84YJO17aNtqnEC
	GWSc=
X-Gm-Gg: ASbGncszK6VyxaTrNqiXy7W/zAmGiiHKMBFc6cnvcup1Ta+N7YOX4N3VwpylcuRcEPV
	iWljtOzUamQrW+BA0mUI1UvSAIi3j47+H+onu2rIaAALC414QHcCzfct3KiTkdZYTpt3xS9gs6k
	K30B7KhJ5a/BfumZQ2PsQuRPM7vY72XhtnTbhvwXt3sskYpaGSCL99WQQcjxGF8NzSAmLt4TR5c
	h+PjbXqIWyVxObUPzwopmzarPQJiu3yLD7hVy796HktQtmO4GXasgpHXTW5LrWivAAfOPMK8FmI
	xLsH1WZitRZwfts2MWvSEphcQnHFtcuKQCGH6xwkqrSYRLBXspehwLivB+krFu6DdOl8OJeiQJB
	7mjdDWbi83LP59QXdMNx03hRA2DW+DsiPweFUI+4OH5Jhlwb6p39zKoPkHQSh
X-Google-Smtp-Source: AGHT+IFEleK9CYT5OprURH4ClV01NhslkBf07R1vis/dfiqBOF2RSxBhZBCjvJDlnuv1Znedibnn6g==
X-Received: by 2002:a17:902:e78b:b0:246:bcf4:c82d with SMTP id d9443c01a7336-2517285be28mr152752915ad.52.1757448893884;
        Tue, 09 Sep 2025 13:14:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e1f7:9c44:893a:3857])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25a27422eb0sm6162145ad.22.2025.09.09.13.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 13:14:53 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mm: vm_event_item: Explicit #include for THREAD_SIZE
Date: Tue,  9 Sep 2025 13:13:57 -0700
Message-ID: <20250909201419.827638-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This header uses THREAD_SIZE, which is provided by the thread_info.h
header but is not included in this header. Depending on the #include
ordering in other files, this can produce preprocessor errors.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 include/linux/vm_event_item.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 9e15a088ba38..92f80b4d69a6 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -2,6 +2,8 @@
 #ifndef VM_EVENT_ITEM_H_INCLUDED
 #define VM_EVENT_ITEM_H_INCLUDED
 
+#include <linux/thread_info.h>
+
 #ifdef CONFIG_ZONE_DMA
 #define DMA_ZONE(xx) xx##_DMA,
 #else
-- 
2.51.0.384.g4c02a37b29-goog


