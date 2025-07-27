Return-Path: <linux-kernel+bounces-747209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32CB130F9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED6F1897C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39E221F38;
	Sun, 27 Jul 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="HBXIkVOL"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77907221554
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638011; cv=none; b=D0+DBvAafxzobyh64m0WCzEQlJjBzyCAfsU+wC2gr2jnsr6MMgxcaT3y00aF5mK1+z0fkK7jBeUgy4WiTmC61RFROoZu/TUrc9rRl0ybH45F8HkJkmdU7iKSarg/PCfgcUFP7N3X6r2EZKCMHO5nOrr01RtTyI1O33jkBvatxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638011; c=relaxed/simple;
	bh=KNhhtUFnmbc3jeA4XTRDlg8RlDWWWyXCaaLU5CW08J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CV+6IGxv4/7NYbSoa4H9LxL7dT+MlFD+J6XvSajrixDCm7CyyOMul271XyMtl27Hp2nngFQ1XcAYv7ZUbL8+VDPivORkqWRuAmiVnmCcgRx6vHj1HKED/ouv03Vby+JywfNXEP8XXRI8Zaf9mAXVFjqsGngQ8GXWkmV+uzIoesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=HBXIkVOL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so622405a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753638009; x=1754242809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMN9tLLmpGB9BsvzAxacdUhrheIgM1fafrpYT+r6ug8=;
        b=HBXIkVOLtjtUpwXBmOYKmzEUHcoli01CSIyV9R6oh2CtyQ46idGKHOrajLn1NqAO7S
         Awxnr0zVpDGH8cihWpqzAQ5g+DT00d8EkKem3PlS2pxd+wsDfrL2N5a0KXfeRYjZw7om
         cE5nlPvWKv5CIKopKYBkspe6O//12l7m2UPQ60sFQVLNrNpEaRfJIyICs7ht0K8sN1E4
         inbyucLKw3hoPt8cEJ1L8gkERVD/d+u0nNRMX1OLggBIe4p95pFcvu1d+NZzbmDV82CG
         9V6eIkQ2AksVU/nT0AmzyWg2YqHREfQBja+yBdfosfMJYqEZIMH7acKnA6zzYt7rSGbz
         rR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753638009; x=1754242809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMN9tLLmpGB9BsvzAxacdUhrheIgM1fafrpYT+r6ug8=;
        b=lKFG9lopCVGVdYwxi6E5EsgGf2y1xY9e6+vos5zmGeTfIPAHMnq+t7jF8MhyA0D51u
         FtsKuLUUq5JhXJVZfvNp7LCS/vP8XX8/UTfdyelIi/H872r3dzdIRR90SCKn0Bnto75n
         vahHCnVlAIsbtYELVv8luOUBVeSAYxiTxgvsnGWQF1UBt6sz4LpBii8+QwGS+aFFcO7u
         dj371ggcZatxfsZq0COL3tTSMTkrPht/T0Xj30GSzxD73vE/GPo6/iYXbsTE9qpYDVma
         OnKv/IKaZhcCjhx4VTkJ1dCMJnC9l6R9o6f3DHnzmnZYer2AUwNSPgI0g0vqYU9ykShO
         5Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCW9mhWP4DV4zW1s8PeGrUykk2r6fXwK+vgGSzX7S7ktYDSV7+fVDcz5KvcOqVEKr3f1awSDQE+mmOfdHO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+bf59/jvdRXBAhyjz/suU8wgBZ9ACfVVgx+PAKy4YoQMACKx
	fCWbKjF69dYO50iKGuDi6NmGueh34OOCXBjw3bzLj0K0AOQ3i4UQ8uJE+4pcMHMe4po=
X-Gm-Gg: ASbGncuBLTSy0LJyeRZ8VclT3i5rMsur8wD0tBdmXTdHukR9EILi1cXhwpDJUiE76PF
	F9F35yIZvEVQTTkMtHQ2fCaLDMJ0unPDd/MxUJICIZGzVOJ8SjKHStXMBGl+TczXEF800VnfN4m
	SNrPdxa66LDmfyo0oSpT6ynfS6TR2sJzfO2L3v7EKC5k1PjbZunrd7No8XC865IItLST+JvEXJa
	n+A6NPHJaHSYjQzKgN8nbUzVBC8cfQ6CH8W8+ieIHWm/tz6UVhmHN0VVsvxUzTwppu6kSKq0ISO
	HaFlZeoEMVFpphjc2xZhmZekk1DYk+9N30T56UWPSZPS28hMLstfqsdVpfD/QFM+GAkpuJczBi1
	d+sBViupptAYfUdW8sA==
X-Google-Smtp-Source: AGHT+IH36yC+vHnoU4Z4vUJxS0IZMDN212CohrzNd9DyruXdE4iBYfZmjOck5EbifMxjx7SZfvixdA==
X-Received: by 2002:a17:90b:35cb:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-31e77a18514mr11484011a91.3.1753638008792;
        Sun, 27 Jul 2025 10:40:08 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8350b724sm3924224a91.23.2025.07.27.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:40:07 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH v3 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
Date: Mon, 28 Jul 2025 01:39:57 +0800
Message-Id: <20250727173959.160835-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727173959.160835-1-yizhou.tang@shopee.com>
References: <20250727173959.160835-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the sync_cookie and last_cookie members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Based on this, we can optimize wbt_done() by removing one if
condition check for non-throttled write requests.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-wbt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a50d4cd55f41..30886d44f6cd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -248,13 +248,14 @@ static void wbt_done(struct rq_qos *rqos, struct request *rq)
 	struct rq_wb *rwb = RQWB(rqos);
 
 	if (!wbt_is_tracked(rq)) {
-		if (rwb->sync_cookie == rq) {
-			rwb->sync_issue = 0;
-			rwb->sync_cookie = NULL;
-		}
+		if (wbt_is_read(rq)) {
+			if (rwb->sync_cookie == rq) {
+				rwb->sync_issue = 0;
+				rwb->sync_cookie = NULL;
+			}
 
-		if (wbt_is_read(rq))
 			wb_timestamp(rwb, &rwb->last_comp);
+		}
 	} else {
 		WARN_ON_ONCE(rq == rwb->sync_cookie);
 		__wbt_done(rqos, wbt_flags(rq));
-- 
2.25.1


