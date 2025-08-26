Return-Path: <linux-kernel+bounces-787292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15BB37420
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD1D3646E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3A374270;
	Tue, 26 Aug 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTVzSWM3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96AC2D3A9E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241798; cv=none; b=ffntFesQI2fjeTUxyolgHf/+PIcJ07L39RKygsJzOUOgkQNnkVnNhL21cXNMJtivHw0D+rXnrukaSLYqtfOgwiUAJ7vPtVqKww4meacikDEevWTPCN05yHdRJkUJkBJMLd8WySCxGIKHlP5Fz8LOn1lFDxz2Q7Mfl0sQTKw3UGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241798; c=relaxed/simple;
	bh=I3YlcR743UmBO/A5EEOfxkHhiTlsZGKfV4Y4DnxMy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDrkw77eneT1XKuaN00YSDoFYCMfOxPoe0RvfZRJvd+JtSYqUJvKx3+iadFQaStYF+GTqEEMu0XEonf2zPjowaDAuSDYsQg2NsY4bqj6B/b9H7IrihwJyqqfEE7uzBCnLxPBzYUnusM8uZ8ZhEQwS8OoBjC+0bKt7wg1xbYjUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTVzSWM3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-770593ba164so2627040b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241796; x=1756846596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgrS4RlDzmuPVEoYRuL5n3FdVX6RzYDiuXN16UyzzCo=;
        b=dTVzSWM3Glsgo+xOjmq0C32He7qHq3aR7jn5j4VfSo/uIL6uEqCMqiycRmn58AQDfL
         nNP+199ESl4Gw9YdnY9FH4WgqZPcmve4WYRTiSNC0WMdjh4tmotToEa+Mgv7WqqfFPUl
         SyN5OR3emZ16144ehcgvfxQuBdKjDr43YVGFPAJ6NysFB4kAtdSHtQocHSALEGJVlqvH
         LCwOokyjpj+4p0iI1HjYVW1r0NUK5hJinKpCycKkfdbE/YCfjGBIOXvPQ4goPZ0QZJ+z
         /eqOvPv5vxeodKeJJVeEeUr5YwDMMVXwtwGBoV2WvVzTQYz21+bu0lg7x3vIR8uxYfVM
         cStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241796; x=1756846596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgrS4RlDzmuPVEoYRuL5n3FdVX6RzYDiuXN16UyzzCo=;
        b=wT2auomS8EqFNNQ7xR3yHC/TcIv0U9mF7yHpcpAaAXFC7QfshHAgAe1E/aZa/QFWY7
         NR027h1Y3ByDkYuSGOg7LzQrGD431bjwHNN3xTloqRYlOMC8O0A2jGTAsmJ3ziwYL2gO
         nn4Rjo3AyoyMUWE77L8QKxSBhna+E6NQ7wkJt9UouPzVYWnUS3tfKFTboSlnBXVCXoK+
         Da5o2Ztx6KjC1QXBiIoAGgUOTjEXWbbNz/sXimg1F+alec+Oxz3ZA5yHB8yQTRBThMqd
         xSCpuuo9h1ag8nLd53HYWqdVLrewd4HSwC1ovt0xRxIc3zYO7th5yQBe/19gZhKIn3rC
         gxvQ==
X-Gm-Message-State: AOJu0Yyd2vNYzDX67tLIOiR5VygcGQq3gtztnREqM6vFviYlTdxIaoLw
	notj+Rakebl51yebwR+wnMVyXyCRtAJ4RJMWLzK8nkfA/K3G/r3MSRFP
X-Gm-Gg: ASbGncvaCJtKX3YIVBfeYNHgzVMMQrfisWePEJlWLlJA0bsDEHE6gygP6OjXRhRkVLD
	9wQ4k/yh9nsc8WtJDKfae3w7LFPYsJvUOa1TA5tAUf8Mru+sFaP3ntlZxVqTopSdzAyTe51bfcR
	McIP+r0UOuSVYL5x6GMkKAK6QzzyGeG/yOoqNalIiMwuExZRw/SJW6a1Hl7X2flPSBL9DGvPX8t
	lqgoIuicGH6Wf+7NMaHhDIAbmgSmF7UhlHnu3MUb/aTrikaUNxBWCB8jCqC09l41Qe14BdHJqsU
	3+NkprEYmAMv1szVEhHilgY17kNDkgXef68ERQ7GMyYydr5JqL7r6uOV9nm143vJZHLOvBQqQoh
	QocT/5Lhu3goAogyoABD7EIW9d3mpwMndE9n3RVHVh03LkImrGkZYUQ==
X-Google-Smtp-Source: AGHT+IEbOPgwcWY4znAzk+xsxvGrwmBJQhhbWaA2d4cWZJEHNQJ6Rz2YR1r4+4mBHFS8WJ+nt+eFzQ==
X-Received: by 2002:a05:6a00:398a:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-7702f9d8ebamr18348240b3a.5.1756241796134;
        Tue, 26 Aug 2025 13:56:36 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-771e814cbccsm5817935b3a.35.2025.08.26.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:56:35 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 7/7] virtio_balloon: Stop calling page_address() in free_pages()
Date: Tue, 26 Aug 2025 13:56:17 -0700
Message-ID: <20250826205617.1032945-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826205617.1032945-1-vishal.moola@gmail.com>
References: <20250826205617.1032945-1-vishal.moola@gmail.com>
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


