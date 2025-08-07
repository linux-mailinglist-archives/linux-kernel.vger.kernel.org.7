Return-Path: <linux-kernel+bounces-759078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517DB1D826
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D218C6FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D6253939;
	Thu,  7 Aug 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="G1HJMqkJ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2F24728B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570569; cv=pass; b=PHFGYmAUDZpA60wk9j9giT/mfAIYx1+w+LsG8aASGfuv73o//kH+NFD/5dzuua/JUzbxUgDfZedWLzM9giGOaJN/FVJfl4xAkCfGHIWWFpqfTHmKnD1dqZV5H0dCSvxDSjyCr/U1/JtRMSHDJz28Rj261yMZ2qwX4g3WLlpc/84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570569; c=relaxed/simple;
	bh=Fzs5ob03Du07ZjnbHREKYT6GzJozWvS6+1TxUahEI2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLJgnzIunczKqsDhmybKu8Zk+NkV4rU7ukHp2HShqKU8XvJL7dwn7XgQJFozMzJIXVXpSVZ9WizZLtZ1g+Kj8ZciZQ1Tu+8cqlWXVdLAdRlRXv5j/bO3bsTe6EgPYxVGEqA9XiCaPaNutjdBdvTwi8NtCqPmtjPu71tYIQOfN3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b=G1HJMqkJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754570550; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=INTIVNFy+y6ACtpSfmyIAUV4uj9iNkR54fpHW6Wn2noJrF3ys7qbSoeSRHRJcHdZ5WUgnh4bl5Hh0zRYio56Czh84zbBai/SkWODn4B3qPD1r/ArS5CnIPZG65LL5XP0KI1g1eocoppwDpEzG0xSqtYyMTdytgfyPgvkkdGvflA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754570550; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NM4a5+r1f5+9t/J3suSz5fFORkb6R1GPJU+1Q1R1m1k=; 
	b=TTzLlTrS1wM+YXPm8t50wRnfwrSUJ3nLzfX2pN784gXEvY2tpGWq6yzRS4NeJwHTmxRNWPW3+9JGfWdcBZtxu33rdwfQ3vn5n6fX7otQnxkooHyiOTEEuUtjmLDshtSGTe8CqUcBa3RBUrzYpNwbhzZjbvKLQ8IYSeodpPBSYeI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
	dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754570550;
	s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NM4a5+r1f5+9t/J3suSz5fFORkb6R1GPJU+1Q1R1m1k=;
	b=G1HJMqkJWeSeRrlPAF+4JIDFqA+8QTsMlvHceos794ezAELKAcqtKgTfDMUBwJrh
	GDnM3pnmeuhF3ZL1kcXazQ/VzZn5RYVp+FFSrL366sMdBeH7MQ2VtMTykyyyIN4kw0e
	7fFAx64GWqb6FFTBcvnyGv+XXk8qFW30S5mVUcrU=
Received: by mx.zohomail.com with SMTPS id 1754570548791590.8650301403842;
	Thu, 7 Aug 2025 05:42:28 -0700 (PDT)
From: Igor Torrente <igor.torrente@collabora.com>
To: mst@redhat.com
Cc: sami.md.ko@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	dmitry.osipenko@collabora.com,
	Igor Torrente <igor.torrente@collabora.com>
Subject: [PATCH] Revert "virtio: reject shm region if length is zero"
Date: Thu,  7 Aug 2025 09:41:45 -0300
Message-ID: <20250807124145.81816-1-igor.torrente@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.

Signed-off-by: Igor Torrente <igor.torrente@collabora.com>
---
 include/linux/virtio_config.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b3e1d30c765b..169c7d367fac 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -329,8 +329,6 @@ static inline
 bool virtio_get_shm_region(struct virtio_device *vdev,
 			   struct virtio_shm_region *region, u8 id)
 {
-	if (!region->len)
-		return false;
 	if (!vdev->config->get_shm_region)
 		return false;
 	return vdev->config->get_shm_region(vdev, region, id);
-- 
2.49.0


