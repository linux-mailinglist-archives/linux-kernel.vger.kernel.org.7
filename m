Return-Path: <linux-kernel+bounces-891744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C82C435DE
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DAE3B2F14
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2B288505;
	Sat,  8 Nov 2025 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Tq34V5OE"
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E3C26A0DD
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762642874; cv=none; b=nv/L6dVtuXRi//8y2ZG34PcMXGAsdGO+YauuuX09uEL6KNGWJKM6aoqeZVY5laAv6UF7VESNhwo7bbWBok+gUPtVKpGGCdPgYWYbaGFH4Z/WOkzOjvFm3yZHeplYu87tyoHeOpkIstzY0NIpR5pDw1U3GcdGO1ct9bWjqPFIivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762642874; c=relaxed/simple;
	bh=v7TGA+6QCVK8DbEC2CDrbNmhkXqca0cIDEJRGw+jHVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF509C53l/9Vv988AOzwWMO7K4sxUp783ehohxbU28i/NrhfrSYyyGA0UKMb96CWscmNR0OroI42l2MLOJ7Xy29AU27Y+A1Q2mQBMNwouLpOuW06vtmuHuIGwyGQL2raxfBApXs8Ar5s6FUm+EH1bZ81KqCRylw/tweUxz/UiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Tq34V5OE; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-470ff9b5820so1289745e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762642870; x=1763247670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RI1kzI7IRCwyOcrqW1kzUHyAYWD73+nYiTUVhp+Ekk=;
        b=Tq34V5OEihPpA3EhqlP62A3kvf7uv+mZveXShKfR8QcYwxCEKDVYSA9jgO1YCPLFRg
         oK6XejcXJf2t0Lj2q+FhMEDrGMW+5Mgw+C3xQW3x9O80qStlEGvZP2i8jMPMFHUtV6ev
         KWeOwBF/tUX/X5jfRWGBOmnd7cqr3QNRgIvEKbUKf0zBIOou5i5b49ZFABj6hsFLesTt
         LBD5c/4FRUZz1EGeEoV+WAUnvrZQcTdwOhoC8WIkZNR58sTRWQ2VaNDrYu3YgvpIUs0k
         yHn5x/f8fCDQKjU+VyvBZr1xc/UJQnyfg2yRloHXHve+kPunjg0q7TUo4odUs5wZl4fQ
         OJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762642870; x=1763247670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RI1kzI7IRCwyOcrqW1kzUHyAYWD73+nYiTUVhp+Ekk=;
        b=UW87Cz20YPHmTk6F4393BdNSZuVUrCsAeXUpuWGAI8YQvcvNPY5WeeunyzbJCo13DL
         PrF3z+cwdOVd+4Km7A1221LTb7WYkhBYwI96Hw1YE+JaJN8jHTtqw5m3IeudVpDdswo5
         mYyzXCzi/N/9VNjaWgj3JAZODiK3+fLhrtH/M9MilVS7GWGWne1a8H0wxtYJbrwPD4CJ
         SCzaxWWdmPtoLahCOU7CxbXSHg66kvq2SKLtog+HtQBSE8HXrX8FGNJxWYJBegvK6fRH
         kC23qkSniHHYIYeN7b8BP3ZUnoZnPiMX/Dgta16QHCDzpSsRR+KmfvntSMGahrXgZPGw
         akGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURh67ePsCERW+xkttsj3FVHEvO2URLmLYzUnVFKJYNeGV8hQsEMy2k8a0gA93QlVoyIWOrVAhvNu1JwLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjM+7HemAD53wVLW5/qXmGVBOLt0AI7SMSaiNlpef4xdry0Qj
	FLNWwbEg31MEX18fZm72btSAszwyYJEXuSnD/CiPLhByBtwY1ghYtcTK3//blBD81B5BG2Q/m/F
	dT2TmpY4FZtqtxzZSaJGd8/I8I9TapdSCLLYA
X-Gm-Gg: ASbGnct6OvgkRFpdnTwiO3n6y+WPiHE4AqS4t4u0iNIa1Lch/DMXJ1iVqRxTw+2V3ZU
	UY5cwNPs7wCvdn9Yp6BbafTY8gCPy8kl8wGJJwubAVewtyIjTM552IDDXo8uTwIfhlBCZi1ejCY
	jHQ5bLaSBE7RyOsLsOxsJCQe1MWx1ZUmc9Ioj3UDfUA0CGBSGPIUpqQPuALMJX+tDLXLcyBhE6I
	8lSA2Gly12I67epk6a3rYtXdtcD+gnN5Q5ATbKxgURnP3hQesCOYfu2N4jZo7lbWi8XqYPLSzC7
	eHZbDGNP0AGRcg42okUtC1IaAPDfw/Alb3xvmU4SaDW1BI5FU/1LFWRJEukPJUWqC7tUqEdgUjS
	tiYmRoN/NYN/n0hZKPClzOGdTT2OiqiM=
X-Google-Smtp-Source: AGHT+IHcxgVfwpzXfrUh/1XC3GR9TFTNVVnuZXFXWIUDCpd/RKokGzpROkYIeTRhbDAxmyKUUOVuVsE8we1S
X-Received: by 2002:a05:600c:46cc:b0:475:d7fe:87a5 with SMTP id 5b1f17b1804b1-4777329d164mr16143665e9.6.1762642870143;
        Sat, 08 Nov 2025 15:01:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4775cdf251esm8824525e9.12.2025.11.08.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:01:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D5E7F3401C3;
	Sat,  8 Nov 2025 16:01:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D403AE41BD7; Sat,  8 Nov 2025 16:01:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/2] zloop: use blk_rq_nr_phys_segments() instead of iterating bvecs
Date: Sat,  8 Nov 2025 16:01:01 -0700
Message-ID: <20251108230101.4187106-3-csander@purestorage.com>
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
 drivers/block/zloop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 92be9f0af00a..7883e56ed12a 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -368,11 +368,11 @@ static void zloop_rw(struct zloop_cmd *cmd)
 	struct req_iterator rq_iter;
 	struct zloop_zone *zone;
 	struct iov_iter iter;
 	struct bio_vec tmp;
 	sector_t zone_end;
-	int nr_bvec = 0;
+	unsigned short nr_bvec = blk_rq_nr_phys_segments(rq);
 	int ret;
 
 	atomic_set(&cmd->ref, 2);
 	cmd->sector = sector;
 	cmd->nr_sectors = nr_sectors;
@@ -435,13 +435,10 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		zone->wp += nr_sectors;
 		if (zone->wp == zone_end)
 			zone->cond = BLK_ZONE_COND_FULL;
 	}
 
-	rq_for_each_bvec(tmp, rq, rq_iter)
-		nr_bvec++;
-
 	if (rq->bio != rq->biotail) {
 		struct bio_vec *bvec;
 
 		cmd->bvec = kmalloc_array(nr_bvec, sizeof(*cmd->bvec), GFP_NOIO);
 		if (!cmd->bvec) {
-- 
2.45.2


