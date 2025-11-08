Return-Path: <linux-kernel+bounces-891743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D6C435D8
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7779F188D06B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AED2848AD;
	Sat,  8 Nov 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Jo5KQ9mj"
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA022836C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642872; cv=none; b=ghxI3da/iG4swyIeCk8D4lOOXqkP+BpVNn/KDyDWIDy6byOUtjehGLeK8EEMlEPgytWdC8JaaSSVRnM1LYs1RbQRW2zI6JiRTbetTvQxbvx2U9VmdWhmX6cW2aUJ/BsuIyG3qD/6oqjx3GrpSz3odT7RsyjWVAMgQxfHtkTHK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642872; c=relaxed/simple;
	bh=g4ddBgla8YQdcKEudweh6zNN2rYBzDIa3qmJAJdcF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaojWVsMVdWQC7dZooRxbc7CZgfy6jDWDMlYGVoWPpOI5QjFga7F4vATBPqFXEZ8FOnRr+8SZOZanjGBST+o7BilE6gkacGedCSUrNtcSPfIFVdAMES1OL5E2GQC3uY8EQEz2sB/rIYpEL11BmlScvG9uz2mWyjbdpbd07EvbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Jo5KQ9mj; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-37a492d38e0so1262171fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762642869; x=1763247669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WVuCf9VQVlr+A9p95nOr8A77FSbZ2C8bh+iEVyLBwI=;
        b=Jo5KQ9mjrWkROXOpc+iIpMpaOZ3/m/DMk1TbuJj7xM+2zIEjgOSVtV4KOuFvNTNCeE
         UENVkG/dRlkFf8pQptGe3IBx6AQa6w3mDM7ouHj8hIw7vrXTUZ3dDPNuZqiIA2dm+PEd
         lMfWXFBjAZakv/wU029F8jfnyNQ4Si6f5uh98uK4LSaa0wrVR/4xy/s+1Ke5KmYJUkFT
         o1/GBXfLrYhselble9edRnk+BtOsHMbYVhDMogJD9mx1I+dtHmBaR+UCgzck94YI18QS
         2z9kCa5FYWUz7pa/IHC3L5rINPraZMg/tfydK/Q6m7nmQSVNZVmLV4wq61AdBDpb5QPq
         G0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642869; x=1763247669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WVuCf9VQVlr+A9p95nOr8A77FSbZ2C8bh+iEVyLBwI=;
        b=Z1rCVclhf1YUATFN9yhLd1DkIkidC2ZmQRPU3lbYSMUARJrsye3gRK7iBfpzaLLTL8
         qsWhIiAay/1LhTAf6jMm0rBgDMITdn+PzitjRUdc4JvnQ+qmso/1QD9tYUG+O2yLeo8e
         2S2Y1cdJXPMWMZjYLb5gMMQEr20ZTDePootQvtsaxi+4KVjVhzMpblCLMyQC+YtaF3Ca
         io1Ri8UTimdaW/MuUn4NYRW2W6+DQVUlgg7JoaiA2ikzmKH2v7gJxJkhHVbKsGXn2pmE
         zgPuf4cTf9iJbx572wA8pa2GwzTAZtglraKULHUslB8/Kr4ky8EdKT/jin3AaMvYHc6x
         HCfw==
X-Forwarded-Encrypted: i=1; AJvYcCUJvRFo5q1wdcF4xkrf2/s6ZDe8971MvllaWq/mRckMtJkcL+0diXxD1bcf8erZjBh77AR7aBoGTMBJr7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBk9DKGULtRNcYlNiYjgUCMpXOzDmHhjAnt74p1AJVaFHy2I/O
	f8tFy8G7Rc6jFQNwqBxzm/q19I8aGGOwwG+3ExMFZwZaZGFdFwxTZswIDHt/aTlrOjmYsYoRDlp
	yDXMjyyn2yFwDTmFLE3sp7MyUlb2LQFCU+jnMEEZ4ARzmIO0Rhngz
X-Gm-Gg: ASbGnct1p4Ef4O04I8FJgMiNDhQTMkw3S2vymSAN2EbHz9uBvy0FmpQOe547Afh5r7F
	v1KNnVKew3dfcEeaO15R70bHbH0tT4p6aCBl2OhKxTm52R5dBSTwZiCNY4uVVgbrscUUUA81mD0
	x98lk6/0423F2sba1KJKRBQ9cOKANui+JpcwRgXZiYhNgunB+JnD1kaOWVvej3SIiZHi3slgO7q
	ndSVbPOAr+pAxE+CVEQtAafT+sxZW68XUu9GckI9YCkLBSfcV/wuemBPHXTS42VRsR6uqZ83hUB
	n54bj4uGq8Rpyzc+Wpu3ToT/tjuhhCUSzFAtpdFaLDqoJRCOl0eOUiPOIK5LiTAPCEWzbaph49K
	ZVAs/OxukfEnCDZHJ
X-Google-Smtp-Source: AGHT+IEi0Gyq93gG1HUhWiqGcWqqJYy3lxU5f5qNsMzYHUTOHbtDZ+IHRkCB2VavnTbM6L9xIJZvppTQtWuf
X-Received: by 2002:a05:6512:3c8c:b0:594:2d0d:a3dc with SMTP id 2adb3069b0e04-5945f1dc4f9mr582180e87.6.1762642869025;
        Sat, 08 Nov 2025 15:01:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5944a39e420sm1385687e87.54.2025.11.08.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:01:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6A50234052C;
	Sat,  8 Nov 2025 16:01:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 68074E41BD7; Sat,  8 Nov 2025 16:01:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/2] loop: use blk_rq_nr_phys_segments() instead of iterating bvecs
Date: Sat,  8 Nov 2025 16:01:00 -0700
Message-ID: <20251108230101.4187106-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251108230101.4187106-1-csander@purestorage.com>
References: <20251108230101.4187106-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of bvecs can be obtained directly from struct request's
nr_phys_segments field via blk_rq_nr_phys_segments(), so use that
instead of iterating over the bvecs an extra time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/loop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13ce229d450c..8096478fad45 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -346,16 +346,13 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
 	unsigned int offset;
-	int nr_bvec = 0;
+	unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
 	int ret;
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
 		if (!bvec)
-- 
2.45.2


