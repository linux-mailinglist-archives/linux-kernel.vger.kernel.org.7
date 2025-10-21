Return-Path: <linux-kernel+bounces-862586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEEBF5B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46B555015A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67F32B9A3;
	Tue, 21 Oct 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHD2EcBL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA230E0F5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041177; cv=none; b=A7fP26IQVDEp/Yrvo+rcCyBGuFM501dLtS/aU+t+i6RnI2B/7jZ1lNtuBa7kcdmDGzlrPc2Eb9bA8keG6zRvbmwhpB02N5xcx+Xr2jvouy4E8+OT6retOsYBIaTFQvfPC8oUPYHuOfb5N02OdkEZORhMV50gfkPicZE47EL42GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041177; c=relaxed/simple;
	bh=JHx3RzN7ekZXT5s/kmXgxoDVrb+4PO8Z4TdtKCJjRPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZcpWCCabjjr3dwCFNfDm+lpHJzU25b9cBXryQzQc0PQwFMWxQ/DMdQjHnLbGLSkUf2lbePOzFeQzpJdHnmP6eRCiQi68I46lxUtPLiAidD2r9N0Zf08geXfDBCyozFEsOQXsATgNRwTO/Mn+yT5JQW8VbS+IeFB0qrmoEKnkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHD2EcBL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcIk1u1LFpf3b4C6lDAgUzkv/HVOGHxfz0isd+tTMcE=;
	b=GHD2EcBL5DYwLQpWsIUoVtBijP/98cWjT+JfinI++4QZXaYjefJlrv/3rSwtiN6hFzbClB
	sC5FI4ytTH8WkIL2kAvQVyBIv7vrZIFXVtvE8R7nWayB2Aph7AWQnZbFsvfZfKwoGuw4I6
	QA/90cD1Xq97q3z5XWFYpCvBE38uQuQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-v465gXGhNOq1d3oZtsfg_w-1; Tue, 21 Oct 2025 06:06:13 -0400
X-MC-Unique: v465gXGhNOq1d3oZtsfg_w-1
X-Mimecast-MFC-AGG-ID: v465gXGhNOq1d3oZtsfg_w_1761041172
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47111dc7c35so37341975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041172; x=1761645972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcIk1u1LFpf3b4C6lDAgUzkv/HVOGHxfz0isd+tTMcE=;
        b=EvbxkuMWG61gG+mcr/S9be+sGfysxJJmtnd6Hvxxi1YLCzYGfPjO/vnrCIbI3EouI0
         4VPTXUmv8xp+vmAKqfnnuLlCpgi8h3DmFldTrkifF/ehHNXxxY7u0FnoJDnar0yEnPmx
         djuiBV8oNC+pmroGtxghWcw84EvXkTisr7PmBe2PcJtUaM+QJkmvtDUr42OoUeVRg+X0
         z+Z0isJPK6bLQFUiU6RL30pSfFnIf2dzkd7n2Gnfo/ACxjQOkdULNTQC/y+GXUycAx3S
         jUHMwdwi/u9RVlsmqFDASEDIlSYUNjCrIQhfzmFANlzhBQOP0kCnP17oBWKIFck+5PKH
         5FoQ==
X-Gm-Message-State: AOJu0YwhGukmXzxKKoCf8zlJrMm95ykBTdHOwlC9dflhl7Rn4l0O04qQ
	dw0kz8lrrWm3Ttlbb07UoKRaAq7nDdzwGAiBpZTiPkr0rrTWFxHabzUnI3pGLJz3Zs8fdMrWTj7
	ybCt/tZH/rTfvUDvwDAzSLADlgUXgpZ4H8+DR0ztM+JJfcBFldmiUADx0xnsU15bgJPmpDixCpq
	7LfrdDH8yYX88Iw2bVpq0ryjC4pKkEqveJLF67GVXsxhf9PA==
X-Gm-Gg: ASbGncsHOx4aFSjAJdscWXx4uFZiN9j4GbB1NUS64GYABqDdHZJIAKZuNk4qwawKV9T
	wU/C7wdJfkpzmG1iphqBs9ljpLZonBFBPvsQXkZc0XAxZWpU0yZQTFjEda/Oqx4L+U/AWblbYkV
	NbltLVNHxogrRAvBk0xfMU+0s2g6mtYY0JN5jOefBmzfdhXJBj3M+tlFaQH83Wso1HJm55cu6VS
	/2gYAzQnznqLo7YQzpoIgWOPmnphruUQSTux4UKnBzzmBAIt3cNG/j2ei9BsvZa3tFQh/hhZETj
	lCZ2BuR9LDrkS5Bjo5J4SI/beFgaiMbgFJLSvgQntpbSrwBreic6wZVH+6DU2gDPu9EH4KKAHaF
	BpAsCvbFbbUxCjlKs9Hxm4vysgGA5oc6hjlPW/a6EOgCQoSr4CgWq1sASinkN
X-Received: by 2002:a05:600c:8214:b0:46e:2d8a:d1a1 with SMTP id 5b1f17b1804b1-4711787c09fmr119128045e9.10.1761041172049;
        Tue, 21 Oct 2025 03:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF73SD0i6hnV9Jjn1RH+PBFk3w9kuXlrYaFhYZPnbx3J0Nn0xcYgxIdbLFvh84woZnc9xYOlQ==
X-Received: by 2002:a05:600c:8214:b0:46e:2d8a:d1a1 with SMTP id 5b1f17b1804b1-4711787c09fmr119127665e9.10.1761041171514;
        Tue, 21 Oct 2025 03:06:11 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496c2c9dasm13567195e9.4.2025.10.21.03.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:06:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Tue, 21 Oct 2025 12:06:06 +0200
Message-ID: <20251021100606.148294-3-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021100606.148294-1-david@redhat.com>
References: <20251021100606.148294-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's properly adjust BALLOON_MIGRATE like the other drivers.

Note that the INFLATE/DEFLATE events are triggered from the core when
enqueueing/dequeueing pages.

Not completely sure whether really is stable material, but the fix is
trivial so let's just CC stable.

This was found by code inspection.

Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 688f5fa1c7245..310dab4bc8679 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -532,6 +532,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
-- 
2.51.0


