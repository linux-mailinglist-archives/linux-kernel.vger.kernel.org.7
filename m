Return-Path: <linux-kernel+bounces-822822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E877B84BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F912542BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F9308F1E;
	Thu, 18 Sep 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBVjKobh"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A822F74F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200948; cv=none; b=Cp+tgsKvWGE3U8FQX7unST7mxs3ZVdzEFIrumqzO51NYyUF/Sxc/Na8MMUpNFo2KZhg09tAnXFudJjKt+D0IFh8b/mmVZDFQFCD/rasTdQLbYr6gcdDFSJxRgVuiWTCj7VY46tSsn59zghzEMYTPOH+JxlQrmzExsvAiYtPtJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200948; c=relaxed/simple;
	bh=Er3PMf9myoYkBBJYaU3UkkQkMikHnD13qA99bQyqK9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8zHahjmiKSO5QAC5y1kca7Jkp1CJAxyt/EyH6+7WMG99r/xkausq9xSe6QJOHAKpcA/ksbqvLflxgD5vv2ekw8s75aNred8kLOUpnC9ZHzCHoJ9hEYTf9FnbA6r9utL1CU9BjQ6MBd0w3oRYle4BIlI0JOh639v3kgBWSDzBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBVjKobh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso630647a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200946; x=1758805746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icTj2uj2ry4O8N7yW/r057ziDGK4JT3A+zWVTttAeYo=;
        b=bBVjKobhlYKQqf4ZfLBLO7kMyOePOF8WdNgpQf+uJAUr8W157EVFb03uY+Fhn0iM7a
         XqxIjOcUqu8wTttTav3VYi9TLse7s91GUbQwX7D0DsYIinYS9NijPoZqXpxv86XpdsIY
         gAUiRE/KKLA4NQUpWaaaYFz9vL5l4H2it9ZWtzD7W5nMqcXS07zCI5xTKaW5cnnMtD2l
         ErPI2rhrz4DzCm5u8ByAubgqDjHRNG2abILk6rpxH9uUPvjDjpBLRkjdgrSxoXsKVHnY
         bIx+y9aeugeBm6wg1hVrCZt2MfoiYmM56V+UD8Q+RRieY2y+admPZoWw8rFfJsz1k3N3
         +LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200946; x=1758805746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icTj2uj2ry4O8N7yW/r057ziDGK4JT3A+zWVTttAeYo=;
        b=S5fRk2XyMh8v1XJe2HG3SA8mCs1AorNgdDUZVmqCu/Lqgf4qrp6qTMpcMnhFrHg8F/
         hIMmRnkV8B8qC8eIa6vUXh/bu3yFy8Qo2abmz9hl1Ls9/TknDQxTltqkwoVzzvsVDTBm
         NEYWhPb126REtI3vriZ4Or4QBhaO1jINwx/bAmgnWfmZArxvEmrHxnYHTUvRdwiALxvD
         L8qpEUU4wSxB8uo0+Cucb1SW7ISk0oNvLnbrLtIJEb9rgkCIpwfhGgj2N1x0AgKy1n5/
         hr6Die7jNxsGIW4axGrVVxyqAG4W+LdaJaotRxrse8XVwGIvX7ttoqoUybqRFgJynrWU
         15nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKbYLYSqbMPSUlSp3fT0TE50B7kLVLSiGMa9XQmyqrMCfIYES4g1/Xdr1Do+c1ZGJAZHzcgTTs8yvBFmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkT2+nE5rYc0PHvsCLlI5cwubKwrzWJyKZnTwHwP+f3uI/73v
	2lbde0+towNGmbkM1E+/UvQvk5CDnzIHAfBxJdko8R0BHn0FVk86WZiS
X-Gm-Gg: ASbGncvkHx6K0PjQROTV6Pu5naLl9UZSfMSDgBe6CmEJ+tuvkIyKk61XlTpnY5iPu5j
	bRxzRreK488b4K4D5nz9I5dAM7CZqNo7JX7VQeI8g1YLYFZq/dFCs1+baTDFfqwEhPc1aFEFvVr
	Uxp830Vl0e54/fYHHg/hkwGiYpFi/fKrk9zqXdG4cesLdxesRAh1EbeQn+TiUf3/fhoYx522BfD
	V9cGERrTE6B2iFI8ZsenyDjz5aLfHpfzAEeeKiaWUVSxaFl552PILxv4TQfKUXKajOgbwqNC1yR
	V9FxRqTBkFV+xJnMgZ8SJJLLgZShOCVuzpMWHR+iQ8XBhLlkDpGF7v7vjIiDhx6KUZZ4IpioNsU
	nHQPXJl/hmqnFWviTyE5PL+7PN4x8dYqPtrnrT5RqFq1uuUXlmq6P
X-Google-Smtp-Source: AGHT+IHlRbybGNvUsZOnopBgfd/M/RrtXbziezoYWYdRaUySLI3fVUiSR65r4mduFiNJCSPyZ5WVSw==
X-Received: by 2002:a17:902:dad1:b0:24a:f79e:e5dd with SMTP id d9443c01a7336-268138fdecemr78106405ad.37.1758200945682;
        Thu, 18 Sep 2025 06:09:05 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d788sm25878695ad.127.2025.09.18.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:09:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: Check kcalloc_node() when allocating interrupter array in xhci_mem_init()
Date: Thu, 18 Sep 2025 21:08:38 +0800
Message-ID: <20250918130838.3551270-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcalloc_node() may fail. When the interrupter array allocation returns
NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
and in cleanup paths), leading to a potential NULL pointer dereference.

Check the allocation and bail out to the existing fail path to avoid
the NULL dereference.

Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/host/xhci-mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d698095fc88d..da257856e864 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		       "Allocating primary event ring");
 	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
 					  flags, dev_to_node(dev));
-
+	if (!xhci->interrupters)
+		goto fail;
 	ir = xhci_alloc_interrupter(xhci, 0, flags);
 	if (!ir)
 		goto fail;
-- 
2.43.0


