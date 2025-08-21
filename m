Return-Path: <linux-kernel+bounces-780578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014CB3050C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A38B1C21FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B905037429A;
	Thu, 21 Aug 2025 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR/oSPSg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF415372889
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806906; cv=none; b=ewu9Pz9b4w6free2XdjCziylOkyCp2+rFO5w3E4EOKHpN1F5RWRL3Ka08RgL6Sl40KonhMdo31Q8m3reGa0llpSBsIAatEzqVVQ8YEH44P2U4d8Kr6an06zVTqW2pqUanGI8B+eQV0jnoutd5onqjRw+GoW5WDZ/XUXzyKLgFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806906; c=relaxed/simple;
	bh=sP22NtXAK7RUwr0f+hWxIzaLt9EECIyrZ2EEKfR5Am4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/lUuxtPTRNdvT2o5N09yWOfs4br44byvRKxrTzDrPGzfZOQydJVIR4ourpp115SCTgYVFghdfG/ON4VHhRSVoEY6H7T+laAUt2ZoGULLvRwtWqjXLYPoCXC9o2KuyuhqUIhbH6eQ95pa7uHOBASDynq9Ls/5hSlh1qG/7MRvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iR/oSPSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4ogAvLOK+AKMqlHwhkjmyVbS/4gGgmBykcdwEFmjg=;
	b=iR/oSPSgotn3w7gSZ8IN65NugEH7zKymwEGExo73kIyx4LvVBZOIOc/ya0c0PEjV6+4A3E
	Od/E1wJsSFywd4SfXXGIU7VWbOiP9y6Hd/5K3vin39dj7b2jDVC8PdKpp+bppsJZVTmIQB
	O8IAiquQYtXosa19I2ZbFoxbK696qzU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-4o-iB3qQMBODGL9Q1ajDUQ-1; Thu, 21 Aug 2025 16:08:21 -0400
X-MC-Unique: 4o-iB3qQMBODGL9Q1ajDUQ-1
X-Mimecast-MFC-AGG-ID: 4o-iB3qQMBODGL9Q1ajDUQ_1755806901
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b4d6f3ab0so8382845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806900; x=1756411700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5m4ogAvLOK+AKMqlHwhkjmyVbS/4gGgmBykcdwEFmjg=;
        b=Vc0GzzPKpFeOaJyRYcniI2fm7P2PZmmYwO21+RPBmO344xUzGi5+ujPu3iLEIaqATL
         zqYv9Fa+KZ5j+VwtEWKbvVyAmgV1ddHhlu0En0eg5dXsD6W//+ks+JI9Y2kYETWmRAh1
         X2NmS5oMjB2QCEcIb/jJc60SxNGrnGRzErIPKDWC0DUJL1AWZYY35WmEy3s7ZHJ0LYDV
         sDb5tyF1jT8tuab3r6xOi4K27P+8ka2B311cpMqCY0R+UaIt7kEF+RWFvZg1MRn+aZmT
         YDgm5H7y8ovspRyOv/Q9qeDci3oaTselZ/yuPRD0wKjdrUaIrfR3fqBtFACKOIwDYxzZ
         PKsQ==
X-Gm-Message-State: AOJu0YwarxGKkpe3XJnAuJfIcqnoG+99r5ChflDZz+J9i9EoAKbZakas
	qlqoVQBok0KkB6bU3SQFO9GlvBUfxh3oUdlF0j3OvlD2FLWh/6IWauHOtT00LFK2f7+/85vn7Ut
	0RKdk3fkJf9+05gF/zyraQLpyen6qiZLTA97l0/oZHYZ5RmgZhjHek4ZWCMwC4+Meot4lSOKuzz
	FRuSTV4W9Q9t2RzC+bjVoGwz+j4ikxsLQqkyYGKcJvCxZzFTtJ
X-Gm-Gg: ASbGncsGAsQUF+2GiSsTlOZ/9KCByN1WyjO/8KSo+NBy0YLb788x8JTJ2HOnWRCv1gE
	5Xk2YFFvz3ZTphrmgd65yuEq/hac3/wQMJZbEBnDbnpn0Uu9ARwi5PDvMZGC49/2/FtiQUgyxxA
	kyFwndi9ok3TPo0yQd1gKmCJGCKEUmUTFH/Nh6oCexu07lj+THthzXc6lPuGpOvfLkiVDobfSpj
	pSE4m7idCFkUQwGaXKgcnHXsY9eN98hsKFX1VYjhTUSUcUOACot5xNe024qxqzaqVTCsLE+VZn8
	LagtACt4u4VU+5bt/ehuKT+W2x3nnqBstvPsU7FaqWhc3lIWfGSLRm3GzpwLi1UhRWSLqxrNZa9
	mZsU+rCpwyfZQhFwne8A58g==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b51f2fe8dmr510605e9.2.1755806900482;
        Thu, 21 Aug 2025 13:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpV2b3uhR/IYbmrTMgtg0gx1wkF4+JdBDenNBBSMhYf9nynPUCNMa8PTADPxo4/liFiw6TqA==
X-Received: by 2002:a05:600d:15a:10b0:458:bc3f:6a77 with SMTP id 5b1f17b1804b1-45b51f2fe8dmr509915e9.2.1755806899756;
        Thu, 21 Aug 2025 13:08:19 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c07487986fsm13999227f8f.1.2025.08.21.13.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:19 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: [PATCH RFC 26/35] mspro_block: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:52 +0200
Message-ID: <20250821200701.1329277-27-david@redhat.com>
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

Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/memstick/core/mspro_block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index c9853d887d282..985cfca3f6944 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -560,8 +560,7 @@ static int h_mspro_block_transfer_data(struct memstick_dev *card,
 		t_offset += msb->current_page * msb->page_size;
 
 		sg_set_page(&t_sg,
-			    nth_page(sg_page(&(msb->req_sg[msb->current_seg])),
-				     t_offset >> PAGE_SHIFT),
+			    sg_page(&(msb->req_sg[msb->current_seg])) + t_offset / PAGE_SIZE,
 			    msb->page_size, offset_in_page(t_offset));
 
 		memstick_init_req_sg(*mrq, msb->data_dir == READ
-- 
2.50.1


