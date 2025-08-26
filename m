Return-Path: <linux-kernel+bounces-787225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108EAB37331
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BBA1BA6B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16AB30CD92;
	Tue, 26 Aug 2025 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ1gMsyf"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905237D5BD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236846; cv=none; b=eXNIz3eFfnqEBWKkFDOVVpN7PFMa+L2YBvJgDxnqE4qVwlwqmvIluQyM7QGKzpY4yzmpSu59OACXW6SJM058dfvZ3ipnhkdnJTRUuD/sra5wKdlU6wp3Q9CgKewkpZIjVDSrtkhzq+sTf2Ax7YFHCSK6c5QviRNYufir1Ls839o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236846; c=relaxed/simple;
	bh=I3YlcR743UmBO/A5EEOfxkHhiTlsZGKfV4Y4DnxMy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtLIM1IkOdeT26q8lJ098wmBLTL7jefDnKvuCc7wQR5ha1kcvQDn591/T6AQmK0yI81icbjiHa29/L3q51EVAOG6vcB6DUyLG8G9cXnnLxmzw1FV8yZqXtn8c3OuTSModBm3+x91zOc/f7N6r77W5Q3OsIwiz5Z11TrELw4ABEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ1gMsyf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so230911b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236844; x=1756841644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgrS4RlDzmuPVEoYRuL5n3FdVX6RzYDiuXN16UyzzCo=;
        b=PJ1gMsyfHX4/J4XqlauKwVb8AeY5Z2NeCOLKFRKzn9scYqcdv84FZ/PVRfD11gMcqh
         5MvlleOXndX/H/ch+3hhcBydQj5oOk6Vw9U4FWV4wbx4lwCbraJGPEaKBxnFiKf3PL18
         +G2HcKNMNf2X6H/AuYEBLI4+CQoP8Iqcg9y0JBgr9ErwN3QOvt3IbMvIYjnRPMDipUcV
         CoC+8tr9NVvIjiX7xwqomZvw2zGTSnJnR64Doz6GIWlfmKfzHHMNdef6uiCFl17DsUc9
         EBDpY2nEPRrx8Cxl/pYENgtWar7TgdTGtCkP3AKWThqTxOs4YBVt2Ne2XOCusF5hiLSQ
         fg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236844; x=1756841644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgrS4RlDzmuPVEoYRuL5n3FdVX6RzYDiuXN16UyzzCo=;
        b=ECrXZO6K66i2A3RPEMyVzr8CHjibUopDrIAHMTLbuU5QZc09TAJSxXnYm2F8x31bBT
         O7QyCIrZJbbxrUDwQ1eLCsRdNNakqI9PHIpnc6rnupmLvcpYXdlx6twgCp356xS/XzWq
         CZgfP5b4OlL8M4/dB5MSBtBVZIYtB0ac10qHu67SGIGrfaRiiy5/lB6CkG7gSKoeK50M
         qIKMgK9OlW5naChSUzM0lH1cTncJkhaE9gSichxq3EnJH9OeGR4SIHFkkquawX/BresR
         UKGADpvjINdNxNQsXDo63Z2Crsw11Exv9R/ssLbxZhyTKFVz8reGH2EWfW2u6gCozC4k
         i1qg==
X-Gm-Message-State: AOJu0YxYIqtSSmQO/E/g98GcyPmA5zuAsEUWib1ca1KpV83H+6IPNUGi
	uJJnkCtu6JOb3maHbZne9h4pgwV3DOlQiU+GmmuunvAMfu6IrOcTSriTS90rvg==
X-Gm-Gg: ASbGncu5KyKyMg23HHEHAeTxOJUQ5SUOukhfoAYP+z8wnCBiRkXDceDpqBnplTqLTwU
	SfIZVhovQZcGH3Gk+MZk8v3eC9Y5quRMh2x+WFvyKou3qaBiNCiaz89gbnA2oYDA9nLst5JM6x9
	16tZf7+S/uewzV+nnH5ko8vEppIqRzIStGNrObjAoKgmLyDntD+QnomZnHeC+tiuaiUMzWyIA4i
	kvZ2U/WBTEd9ge9RozZES1OzJYXikXg6xbzWB2yvX8QbDQUWv3oY8cCJrcY+5bVFcTpA86vz7cC
	NLarFunBxNrGNLEM8/mxTUCHZ0u2tslvuTBbqJSpc8H8rVKUro1k6r1HDMpshiTplArcxhQ+06i
	HcVTCZguOLzM87woASuFwiIVqpeTFc6GcwtnBYA2WS1xYjZFSx+gk4A==
X-Google-Smtp-Source: AGHT+IH/E8LX9DdP14eamZ2LRF4BG3tJOFJ+GpntOt1nypltTCHQQ8wSzlJBqbosmyTo6axuqcj0Nw==
X-Received: by 2002:a05:6a20:a12c:b0:240:d246:dacc with SMTP id adf61e73a8af0-2438fad3083mr3720822637.10.1756236843741;
        Tue, 26 Aug 2025 12:34:03 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm8054053b3a.59.2025.08.26.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:34:02 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 7/7] virtio_balloon: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 12:32:58 -0700
Message-ID: <20250826193258.902608-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826193258.902608-1-vishal.moola@gmail.com>
References: <20250826193258.902608-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index eae65136cdfb..d4e6865ce355 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 		page = balloon_page_pop(&vb->free_page_list);
 		if (!page)
 			break;
-		free_pages((unsigned long)page_address(page),
-			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 	}
 	vb->num_free_page_blocks -= num_returned;
 	spin_unlock_irq(&vb->free_page_list_lock);
-- 
2.51.0


