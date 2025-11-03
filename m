Return-Path: <linux-kernel+bounces-883580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B91C2DCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681B418992B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD861F4188;
	Mon,  3 Nov 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9YMFhA6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC1BA45
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196688; cv=none; b=AJPZ2EV97UCUfOhPCG5sXuZGSIwfVpdrt1ta41Sx6ee3/xK/zgOpVFB9rrDy1nUk9XpJQ36FHNqb4AEXuuzX3QB7ef05PeRMkX+0MDQzgAFRJDURhpFja5QnSh7DQ7qholu/QYQDEW6chzE4bgBLeETl3SYQuVME1RpmBDFkss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196688; c=relaxed/simple;
	bh=0K6bWy8vqPUR3W33OJDfPQDBqn3uLVqCV9mgvI8cApo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx8w01ssN5JINEQ7AyKDlBJWtyv+dh3wQlBPRLGLIVk4dXvmvN6b3KyInRfcW1aRnMuvdN8ACKDzYBcAgrH63k9F2n+cGEZ9yD7ptbPEp9DfMWWg/D3Ag488ndpyzsU0XPm9QoQHsICiHgGyi53K5Brw+ElJszZRjPw0A0xQUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9YMFhA6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso45208425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196685; x=1762801485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBDhTH8Dpf9cuoXB2xWuzVQKuw3fUYOK39L3KZEHT70=;
        b=K9YMFhA625XmbYTAd31DiTNZRC+xsibGnPNhczciwDKaSv1G2Nv5PpMN49phsXjMIN
         2DwbDvN12a0WRE80vOmbymVFVQgsqLtuqRI1CZRFLrbP3NRLuSupdmQ9R00hQuNkQn4l
         J+SSTPtoznK26YTxlfcu9aw+kfGGzziYqDpnBsxW4uVN5iLx0VEJGjBxjbDYXfqp+vBI
         Ifx4+cGJS/CPtOgfl+2UlMjOzatzlelGq71lxvj1JbTAWBWn+xvHjW4oyxv2mKEITG4d
         dL+hRmFq9k7+B8X5q8LVbLzSpxgjzSkmA8hZo7UnhUFAIiTTwnkDZrqzkmrHg942GLcL
         wBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196685; x=1762801485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBDhTH8Dpf9cuoXB2xWuzVQKuw3fUYOK39L3KZEHT70=;
        b=XSZJuKy0eNZIq2oQZcmWBpk74UdgpfyMlbTyFzJ2afDQ8DoebgxdkUH4mEblUaLXDf
         NT5QxmddZKsqv3QeyX0telLzjzGvI9InXvme0e5mwEM94u8W7MwiQP+7R0zIrMAuqrvJ
         V1hulo1GHfHdyHPwU6PIChq+nFO/RGKr4TPO0JZ8xQ9DRqqiMasyquFnqVLpCW5GLOK0
         JI4/k0v7XEVN4FF8bcj3fNQwa+xIb8oYS1ekmGlxJwutTdl0VVYTnPTQuZ+zXvIdyu33
         g9SrrKAeUnGAF5Ycukl92/dznsW8GmepMJ19qwnmuBVYh++B8fG5KiQqfbE+iXQWQS2e
         zG4w==
X-Gm-Message-State: AOJu0YysPtZWD8d29BogwnATuBMydkEf9kaZZ/CMoTOqcM8FxJDLXSrX
	aw6dT2areEXf2YjMeOnM9LChINbfSanXsamRbfvqfbRNx/6a2pzZ7Jx9sgafCBjj
X-Gm-Gg: ASbGnctX/zOHzNDGKncDRno6VAYe3X5LOqy72ltOUeAtlVj0faZGz3YkB31nhr1VGzM
	cEa9g9WKQ7EIkw6WK3hGiYKMiS9GzH1jOiRupU94Z+EKmqpVHd6qtmRGcT69FFpTeV4m+B84+De
	PosLwWo5Nrsei6Zz0emuCJrE2y1umpBX02aOPyFy+vMlsyt4KpxTt780Mn7ItdHPOGwGqSxRR1s
	3YjA1hiIeFw5IQZgrDzhYwjnIAh1nc448H/4YYjbqy8fjx7JlgJ6Iii7HHka8BAs/KecMAH4i4J
	jVufzoUPb8OGSL3MEdFzX+URXXKZ5+nR39fRdPfaP3CbIzDDJx3mExiNHOsCc8EhOCBYdJYVzK2
	Fhn1dthNJaWGNfKneK2L7OiE2oWLHg5gG66nohESxCsFYzkQjlmJALoSUDZ5U0foJeUVrQjmMZx
	euD224pkMi0/taGtlqGqnlZk8bB5B4Z+vkwyCQH0T2N5+kRtQymcg=
X-Google-Smtp-Source: AGHT+IH+LrObL5vnPyR4BBqTxomK7H6lOIKtzmQXyJTsFQUzpJ9S6dbTZH4skwIU/n70FgNhhlhOrA==
X-Received: by 2002:a05:600c:6389:b0:475:de05:6611 with SMTP id 5b1f17b1804b1-47730793c68mr134898565e9.7.1762196684751;
        Mon, 03 Nov 2025 11:04:44 -0800 (PST)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc192ac4sm327407f8f.17.2025.11.03.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:04:44 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH v2 4/4] mm/vmalloc: cleanup gfp flag use in new_vmap_block()
Date: Mon,  3 Nov 2025 11:04:29 -0800
Message-ID: <20251103190429.104747-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103190429.104747-1-vishal.moola@gmail.com>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only caller, vb_alloc(), passes GFP_KERNEL into new_vmap_block()
which is a subset of GFP_RECLAIM_MASK. Since there's no reason to use
this mask here, remove it.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ced77fc65ce3..e6cca6219e48 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2699,8 +2699,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 	node = numa_node_id();
 
-	vb = kmalloc_node(sizeof(struct vmap_block),
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	vb = kmalloc_node(sizeof(struct vmap_block), gfp_mask, node);
 	if (unlikely(!vb))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.1


