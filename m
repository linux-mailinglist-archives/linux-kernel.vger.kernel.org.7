Return-Path: <linux-kernel+bounces-780576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4386EB304FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5929B1755D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A94934DCE6;
	Thu, 21 Aug 2025 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRfBkWAe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534D35083D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806901; cv=none; b=ApK5pGNPOd1Tjc9OPuTtZDlriSwbl2xccALBAxw/OBpDR3rjDcB1tuszXETa41uAlRJjLO/D4DQKuhdnGraPYbpSUmc7tDsD+El6AwzS1bpdfVA1sIf7i6HYnoUauxnBcZ5LG4AHWSKV02/Pn/3cQq2EbVyNyzu03nkbpKRtpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806901; c=relaxed/simple;
	bh=o0B/aIsMAhafmNCelOfWp+ALdEBw0Dyti3dxNNba1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPHzc4A5t51XhikvOk1xPbp0rUkTVDODrtqtvF2T3Z601AtAWlv28W+pvtXoKj72ribpovaCG2QWEEqD+MYSWodcwLbnPqCfSfpF0Ye54FHeWVfl4+0IYnNPdYu3kXwHESsbw/bjZmKxYLbeti1+Z3u9bgm4dfBOC72s0yhfCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRfBkWAe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
	b=YRfBkWAeztOL1Q/SKT11ysj2K0fkgzFy4T9p1VCsn2hYwldVT+WCG/qOFuae39hBoXitjl
	2615ANOaT6SXZHc9usYxcLtHIP/MddL++5E1zeuZX5WlTJrgA6OKdmaR4MDwl5hXuVgErr
	mody1e/b18kv/G+NGAQs78nd6sckoLU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-s774A5zyOrqb8eiW74-0Rw-1; Thu, 21 Aug 2025 16:08:16 -0400
X-MC-Unique: s774A5zyOrqb8eiW74-0Rw-1
X-Mimecast-MFC-AGG-ID: s774A5zyOrqb8eiW74-0Rw_1755806895
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4117542so631252f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806894; x=1756411694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
        b=XTOP79gPxrWx76a9WNySpErtX3gifdHgPLQtt3uyKL5KicTBphNsH7Iiuj5N5tJorn
         lHXZ7CQ27ovUqFP+ezePwJPNwBc6bzjqJzP0k++jQp2zUGMnhkdXxLJk5AN324PlA+RD
         1DRrQXNxa4xWBTR3f4sh1xvApD1T7Gq924q7vbvtnxAagOhBbh+wU9ES/aEpZzcPN3Fb
         PbCrgWnUEVhEgCwXqueUk/9ZIWHKKdQw/PMFGTjKED8UkigPea805hBfPvDVP+qwyIPp
         Kqg6WM9UXPvROmVUf2nn4Tsg7WYygSMJsyJhbX1R+tSQ/joY2RrCVIA1ChdtEGimZFin
         XNnA==
X-Gm-Message-State: AOJu0YyE/qrsw3Yy+61OekZtF4dL/4hD+b/OxFMBiK7Y9cyTgW95/umh
	GF5CVNJ3QBDkzTg3xaE8SINqYoV4KN5+7KLbIDyHleTHaxZEhGOwfvFtWT5Ug53sUPYZ2G/Nki7
	3k3uYZkTDlwqWIrXBLnFbHhKXJrFS9uhGdUrR33t/ayAO/SQTx6Q+a1jXl6M6qEFMbFjPQOgF5K
	UvQz9oF7Me/L2yIt4HPCJ6MHH5lOoQ3LPRIUKmFSJf4QnU7ffz
X-Gm-Gg: ASbGncvjUK/0n6ysAUrtFSopMrzaX74Haz+CkNYQM5qy19IM8xM0xW33yxsRHjlR9RH
	3XbFXToZ2rizFxg+VeXrOgkYZi+3ljfpTpDPC+dVua85eibtjfeXUAzrpujJWYwUxQfuxCJb1XA
	9JBHJYVTQupPbOgugFQnUCmFtlkid7+gBbTTFtFSfX0h6jdiLaGvQ9kERZdoz+7lNhLBymS/I6L
	gLswoNv5VS2IlqyKjpbu6EP1yN9xEDukESM552Q+Kp0HrqqMcU4GIMXD1g261k8ti51qcAQB0tj
	OkWyPKzc0GABZfRYApfyN8wFG18g+TnT5z8TAoCbGPD0JovkgUz+dz5gnMRHod3/f7OQOhAsXlI
	+pm7MmPKZ4WUAq5Ll4J7HfA==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215869f8f.44.1755806894643;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrE9N2OTZOZSEOVxEUY9xhX4UsF8UOhI+5wOqBRpd/3VSIxUjVMLdiea20BiXkc+w3FSZ8A==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215789f8f.44.1755806894010;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074e38d65sm12982954f8f.27.2025.08.21.13.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:50 +0200
Message-ID: <20250821200701.1329277-25-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/ata/libata-sff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7fc407255eb46..9f5d0f9f6d686 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	offset = qc->cursg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SHIFT;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
@@ -631,7 +631,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
+		ata_pio_xfer(qc, page + 1, 0, count - split_len);
 	} else {
 		ata_pio_xfer(qc, page, offset, count);
 	}
@@ -751,7 +751,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	offset = sg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SIZE;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
-- 
2.50.1


