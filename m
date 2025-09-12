Return-Path: <linux-kernel+bounces-813679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54EDB5493F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737791753FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683862E9748;
	Fri, 12 Sep 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws/VFMWy"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C092E093F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672057; cv=none; b=VW4sOp28kxV4e0Fyql+B9kUTiBa5YiCD1vJCkcCHdZlyvq0Fqi9s3CfapVY+hh3hnUpvLTIO8Yg/iXAeezl9TUa7r4P3WTMM9pi14fYSLh4h6i8LHrtbKgo7//bDfP/E88ELmunz1ClYp8mb1loZe7B3Jd8SsTo1d8V24JmsRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672057; c=relaxed/simple;
	bh=WzgTnbK9tuNFXaklXyWAZeptvHxNrHodKB3ayQnobdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/BirYwj0fyyyWuAXJwVDM4v6Qfch5qlLHnb+bI1ww9AYKD95uAZrfI5lLmspcTRlJbCZhizKGNyftYkI8MGPSTUmmzo1b0G2gvk2pc0af8FuqhgRjbXBg4C2V9aWqD6Xz6ESZ6TEnpd5HVTQQ0sN0d5Vb47Djv6GoGBiO7/M1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws/VFMWy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso12152595e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672054; x=1758276854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PQcDKC/bECgYhflDmBq/roZDN26g7PlEyIKs1aCH60=;
        b=Ws/VFMWyKXeKQ7SgMMLcgYcrpuKZzHD1Fw4Kl9rgqiE2evOHbNKfgytvA87cFo0B5H
         Qoh7NYTFiWZpeZVS8EX65bYU8QOSX0NVRhIaW4RcUUwCIKuviT2plVrzwk5Mf/VQdnb1
         qO/ZqBI8/USRCfNik7RHK80/76te3JgFHbMqHbuK1mP9tbwf1IBiBq9oAs/B8TTP78UV
         Z2GlQd9djlH7Fk7iCJO5eI+CgFoHxJyDQR21cpvnlTHalw9JElEt1wn/QGDx11RJWOO1
         uvaTx7JacXHQ+lkBZ3kGqf71lvihet+9guu/zBCfYF7kd0mM2eQ20qPsT51Z+fvp4xjU
         d+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672054; x=1758276854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PQcDKC/bECgYhflDmBq/roZDN26g7PlEyIKs1aCH60=;
        b=o5PtMZXWjkRCDN84cKQCFfPrs7UWgmHJb9DknN1j/bKjWbvkUjCtUd0GxrHQsq03XM
         QnUl4uS3+gAZ6qrNspA4XqPHGyl6UrcSM843CBrxNK0Is+FFz6X0pX2Zr27Cy0rw6TeE
         uKkMhuraQEa5SuILJWgiygSv99+LWS5cdkoppjXKvNwcEVzIierqwBkBel3mDejqITV3
         bY5LFUosaQjpuS2YocCfsUbGc44KbHlTj7CrpIIyAjL8OtnuRfoukUp8un1plhTko0Cb
         v6paj9FWM1aaXaZNpkUiycz5PYs/eeFLkOuhfVy61G6Nj7PPEEF6Wlz4dYS0WuYgM9rW
         tpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvO/LCk9kAtthEkIMVNdwq7og0wfj8p++r8jVQzxdsqG7c7OREdssjtUlJPMfXxCtZlBxf7tPevNNCQ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCswlWfKmPNmM4AlgxMwaY9WkOFTjZ+0eqUF8uTC0ahJknMj4
	idJiZ+qeg5cazAQjjWwCIkdJ1Tg9aISXRLX3EIMWrA3pme7QaBscz00j/leOhA==
X-Gm-Gg: ASbGnct5yMlvBx2wp3Qj5b+elKIbtgGjm6OL7eoUqKxXfXHmuwwZfiXzf0TGWhCw6A3
	K3+SjWY38Mt/TLIycMIGOZ8iVfyhs+ZMO6PEy4hz/aqBKr30ZG0RcLVVIx+/dbAa75ayIOgZwrt
	kTNKdzXha4hxGNf36AkFXJ+tQ6hVp2/bmSE1kp+rz5hZsCpHVF6oKTZfzsJpyRPZMEbUAV4BxMn
	TBO1ghftsFpP8WNf2u7jyeo8U4/2gI1IuvxoB7mqtiMzQGfw5Ie7SzSuaV3XqC/mmyuFrOBimec
	BJGV78UxRJFwaaQE5U00QkRGJZRj3zYQdfi4j6bXDralmjan4zNF4yZhYQv6MRv4+TWWv6aue89
	I7802QGxsKnE1G8w8aCtN76CdLiV1GF5+vGWUiYNv51cV
X-Google-Smtp-Source: AGHT+IH/9UK+74KXPTnSJovBBUuqH7Dh59JphBjwKJfV2cuUIv0/SQm8MsDxBuEOK1XB9vm/BVZEhw==
X-Received: by 2002:a05:600c:2249:b0:45d:e54b:fa0c with SMTP id 5b1f17b1804b1-45f2121431amr20057115e9.17.1757672054181;
        Fri, 12 Sep 2025 03:14:14 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm56542395e9.9.2025.09.12.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:14:13 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: gshahrouzi@gmail.com,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] staging: axis-fifo: flush RX FIFO on read errors
Date: Fri, 12 Sep 2025 13:13:22 +0300
Message-ID: <20250912101322.1282507-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912101322.1282507-1-ovidiu.panait.oss@gmail.com>
References: <20250912101322.1282507-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flush stale data from the RX FIFO in case of errors, to avoid reading
old data when new packets arrive.

Commit c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for
user errors") removed full FIFO resets from the read error paths, which
fixed potential TX data losses, but introduced this RX issue.

Fixes: c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for user errors")
Cc: stable@vger.kernel.org
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c47c6a022402..2c8e25a8c657 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -230,6 +230,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 	}
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
+	words_available = bytes_available / sizeof(u32);
 	if (!bytes_available) {
 		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
@@ -240,7 +241,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
 		ret = -EINVAL;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
 	if (bytes_available % sizeof(u32)) {
@@ -249,11 +250,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
-		goto end_unlock;
+		goto err_flush_rx;
 	}
 
-	words_available = bytes_available / sizeof(u32);
-
 	/* read data into an intermediate buffer, copying the contents
 	 * to userspace when the buffer is full
 	 */
@@ -265,18 +264,23 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 			tmp_buf[i] = ioread32(fifo->base_addr +
 					      XLLF_RDFD_OFFSET);
 		}
+		words_available -= copy;
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
 			ret = -EFAULT;
-			goto end_unlock;
+			goto err_flush_rx;
 		}
 
 		copied += copy;
-		words_available -= copy;
 	}
+	mutex_unlock(&fifo->read_lock);
+
+	return bytes_available;
 
-	ret = bytes_available;
+err_flush_rx:
+	while (words_available--)
+		ioread32(fifo->base_addr + XLLF_RDFD_OFFSET);
 
 end_unlock:
 	mutex_unlock(&fifo->read_lock);
-- 
2.50.0


