Return-Path: <linux-kernel+bounces-694882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071CCAE11C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 05:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4731A3BE956
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441F1DED4C;
	Fri, 20 Jun 2025 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bo6RUVHE"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFFA1E835D
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 03:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389862; cv=none; b=PbKp3xuMeEmOsgISngmBR2RHQNAiItUIuIhuynPLZQU33pwHNaTQHs+7ZI7wpHRJ/w96esq3TZZuJOsxLiQwsfySKhypEcfoGTA/R0VhnG5XGXfNZqEq6rX20KHYuS0TGiW6kq+Pj1o0EnpEEcB4SmVzf3qGwAVfmNzNj2rKklM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389862; c=relaxed/simple;
	bh=SYK+UWbrGNX3UbkkR8jkQm/pIxA9wBivQLpXpvCwK4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrX5kUIPbQgLvbAFZWHlwmi7Zi8nawg7XiPLnqaX+K0Owe/R8R6qno4VLKdZo0HkpQ6ujxVDRc6NK0R1Oo6lY/CtebhCMYCgvcBzDo0rgN8KmdpS104l431mOPgOKOqb0elRenneluElxw69nnhuF0O7k9ql3YsYHXfBhGuRtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bo6RUVHE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747fc7506d4so990674b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 20:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750389859; x=1750994659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2YzMDv78WPG5/xYOI3b72eSmmaa1xBCqOTfcIeZ+L0=;
        b=bo6RUVHEWj/aNYwXo+exHdKMyNT9eaDfbshbnp7uwMLRiI5XUuL7N+OocSQAKHCmEJ
         5KtGZk0WCGgOovC3XQucCpXaq9pz6/NIY8+6dEyZj920Wku6UgRflxnj1YDImZ9dSCqV
         gBj5W8q4LEzod2CAgqQbi/iWh02ImbWvos7FqcqBpEXp2xevp1EitbZXfBx0BtJI24Dx
         WT9T8zsKHA3bDO9Ebo3fyPMIZW0O8Vzi6Mq6U1eD4IK8WL39rzjfsw3yHlsS6Z29PnqM
         r67c0z0f91pBiCriqyqPbg4Gs+TOY+M258LLJvMEmWnAF8f1EV4jQGgSY35cFfaVjodr
         GS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750389859; x=1750994659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2YzMDv78WPG5/xYOI3b72eSmmaa1xBCqOTfcIeZ+L0=;
        b=V27F/IDMA93BPsMHbJ9TFq7XqR4KnHs4sWlgp9K0gZQxS9CX7g0qysmmGTv9ydzygc
         0cfEECkT2CIjFrDuCHyBp2MIaMuDLaZ/ih7ST1PDcZ2NsYNOwI7iK6VmJjLMAmipt/Qb
         VnRU7U7GTrK5rQBn+nOWJvL9jDk+SKnei9FHLth5+1yXDpoXkl9dIXKnmOSPbA30v2pa
         AxXoUg8+rucrPMqr4qy61P38L1I3FG2WJDvKsh5vQHB5ky0Egdi6wOJwJpf8XklX5n5w
         9R4utMaWR2CcfE41hAXtIXlSZN0bUUPICY6gk4HNjAmkuE+2IunW1k/NnkGEjVNyp45W
         BCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDyxH84jF2jy+G1qDhvJPbPHudhCxVoKyODC55HeAgUJqq5JJaCJKuXgy5HdsOUN3iRB6jOV645oUH+bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNW9m8+0e7ndvTj6FWz/UlOBm+HhN5HGgB/6XFU9+LgNw8xr5s
	sxTgkPqqrSgawdwasqpSZzR0gpY5qit9fr7UUGKs80Xg94iyG+aa5/H88Gv/rzyu87E=
X-Gm-Gg: ASbGncuv5fUwsJy8ENg8OOER/5W55g67tpus1XUO3/uawhORNxdKKHibywW8D2xZZRa
	sMG9IBYNbWJMSI+s+ekxrcAAWPmZsP/E8cFiP6WFCktfGztUnyN7Ggza8g9DreDRO0jFTn6vvMb
	HyVCOzM+oPmdichbJ9sL9fs2FKljmisv2M++VdGMQ3rHMUD0YCjpU20IAyBVvs3rsLXnxlI1gD7
	0V3OzLtt0roc9FKzAdzLuUAlhIiOfoa0a7ss/XOuLIvQTmeCendu6oL5HDDQnVx9XuY9prVKKaV
	5ZXXqTkeRtBI4L3adRvNxM332CcZnzff3KoTGJtlesrFT/tUW/13Uo5T7eMAPws58oLzSHoDWzV
	t32QpHtbgtwU3
X-Google-Smtp-Source: AGHT+IGXeKmUfFbuX8aA0TnmPyTEPtqZ2Lj0/H9EkIAI3yrkuvUIjWM6dz6wmIwtNCHRZ1tMl1fTIg==
X-Received: by 2002:a05:6a20:6a23:b0:1f5:7007:9eb8 with SMTP id adf61e73a8af0-22026e94585mr1952273637.16.1750389858932;
        Thu, 19 Jun 2025 20:24:18 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12423e3sm490565a12.47.2025.06.19.20.24.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 20:24:18 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com,
	jgg@ziepe.ca,
	david@redhat.com
Cc: peterx@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lizhe.67@bytedance.com
Subject: [PATCH v5 3/3] vfio/type1: optimize vfio_unpin_pages_remote() for large folio
Date: Fri, 20 Jun 2025 11:23:44 +0800
Message-ID: <20250620032344.13382-4-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620032344.13382-1-lizhe.67@bytedance.com>
References: <20250620032344.13382-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

When vfio_unpin_pages_remote() is called with a range of addresses that
includes large folios, the function currently performs individual
put_pfn() operations for each page. This can lead to significant
performance overheads, especially when dealing with large ranges of pages.

It would be very rare for reserved PFNs and non reserved will to be mixed
within the same range. So this patch utilizes the has_rsvd variable
introduced in the previous patch to determine whether batch put_pfn()
operations can be performed. Moreover, compared to put_pfn(),
unpin_user_page_range_dirty_lock() is capable of handling large folio
scenarios more efficiently.

The performance test results, based on v6.15, for completing the 16G VFIO
IOMMU DMA unmapping, obtained through unit test[1] with slight
modifications[2], are as follows.

Base(v6.15):
./vfio-pci-mem-dma-map 0000:03:00.0 16
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.047 s (338.6 GB/s)
VFIO UNMAP DMA in 0.138 s (116.2 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.280 s (57.2 GB/s)
VFIO UNMAP DMA in 0.312 s (51.3 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.052 s (308.3 GB/s)
VFIO UNMAP DMA in 0.139 s (115.1 GB/s)

Map[3] + This patchset:
------- AVERAGE (MADV_HUGEPAGE) --------
VFIO MAP DMA in 0.028 s (563.9 GB/s)
VFIO UNMAP DMA in 0.049 s (325.1 GB/s)
------- AVERAGE (MAP_POPULATE) --------
VFIO MAP DMA in 0.292 s (54.7 GB/s)
VFIO UNMAP DMA in 0.292 s (54.9 GB/s)
------- AVERAGE (HUGETLBFS) --------
VFIO MAP DMA in 0.033 s (491.3 GB/s)
VFIO UNMAP DMA in 0.049 s (323.9 GB/s)

For large folio, we achieve an approximate 64% performance improvement
in the VFIO UNMAP DMA item. For small folios, the performance test
results appear to show no significant changes.

[1]: https://github.com/awilliam/tests/blob/vfio-pci-mem-dma-map/vfio-pci-mem-dma-map.c
[2]: https://lore.kernel.org/all/20250610031013.98556-1-lizhe.67@bytedance.com/
[3]: https://lore.kernel.org/all/20250529064947.38433-1-lizhe.67@bytedance.com/

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 drivers/vfio/vfio_iommu_type1.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 8827e315e3d8..88a54b44df5b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -806,17 +806,29 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	return pinned;
 }
 
+static inline void put_valid_unreserved_pfns(unsigned long start_pfn,
+		unsigned long npage, int prot)
+{
+	unpin_user_page_range_dirty_lock(pfn_to_page(start_pfn), npage,
+					 prot & IOMMU_WRITE);
+}
+
 static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 				    unsigned long pfn, unsigned long npage,
 				    bool do_accounting)
 {
 	long unlocked = 0, locked = vpfn_pages(dma, iova, npage);
-	long i;
 
-	for (i = 0; i < npage; i++)
-		if (put_pfn(pfn++, dma->prot))
-			unlocked++;
+	if (dma->has_rsvd) {
+		long i;
 
+		for (i = 0; i < npage; i++)
+			if (put_pfn(pfn++, dma->prot))
+				unlocked++;
+	} else {
+		put_valid_unreserved_pfns(pfn, npage, dma->prot);
+		unlocked = npage;
+	}
 	if (do_accounting)
 		vfio_lock_acct(dma, locked - unlocked, true);
 
-- 
2.20.1


