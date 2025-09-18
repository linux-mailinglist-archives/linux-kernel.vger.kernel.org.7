Return-Path: <linux-kernel+bounces-821887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFEB828E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CD358784C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F223C8C7;
	Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kj0VVmWx"
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0291224AEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160238; cv=none; b=jDKBOgc2Sp118/JH99aLg4h/xgiC9krWWjZP4ghDwVAG38dtJ3knTsEJu8DAhFl3iqbfBTu/FXk9oaHuVeDCNoNAb9MCzWXaU17ZIhf1gSJiNcNpdBqfES1qiK74dHWk0DTbQp1m3bNAQakktiyrQ3dBq7UynzYs5/AfVuyFD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160238; c=relaxed/simple;
	bh=JZ7WeEWAd1kWAVhMIzhhWXd+cCffqQi8fUXv/IWzAcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLS2k/yUzEDzD2bFWqH5ZhmZx5Nhg5lClejSg97EBHZepebkm0T51Llg4XUyhvio0qhScjWDDvm7+gDzlGzCCOk2WfWTeiMR0/LQsa+2e2L+gZsPNS5H+HjFHyyESgk46Au59icGykN7X+yE0LohKU9k47NcisAg4jNhJWKXw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kj0VVmWx; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-829716c5293so11305785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160234; x=1758765034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm609mzNTyYSUqGencYamb949uYiGedbBCUE+WH6KPU=;
        b=Kj0VVmWxjVgManHyQfrwCbwfVSttvDoApACYghz79TbU8fM98kSz6lJULsVRXOaZ3b
         YjFnNc/6GkujNhfA0anQ6kiwP39J9U0XxUwii2YeyeI/gN03ZyzNnMwtZ8kQOzCIph5H
         2nVOEO6UhaIlwSMgyipcG2w/12DJwpto1R/PrIBTMm3iIRJrKiVsyxRhhKZ2Vvq51N8A
         QeIERQBNtA/HpSm5R3SrfoIvtrXXLfSFUiXWFLqqzPnQPHBNswPAle2xNiK2KS/I6urA
         ZxyVm0wF93DOMS4GNrE9Rw6KU+hgZoGRnGPEbELmKfkzjCdyMPeegmsS+b5dUOTv2vQ7
         +6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160234; x=1758765034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm609mzNTyYSUqGencYamb949uYiGedbBCUE+WH6KPU=;
        b=mS/6KGAr7lFt8nMlOUc5hG85v92ZYSMSVOgLynJdSLR5rBmI6/JW3R4weSxxqja3q8
         bwSCJxJFTZ0/zzFHqMJqlVN86FtVjl1+PnLU2+dyv5fdHlFH9K1yhg6dTZVUusFv8bti
         vyqnaojDisHebvy+zkT/kZLiEEen2bMG/ZZu4Giv7idJnkLJjJVGGSc4hb9zHUC2i/yW
         DiEHpyi6bJsJeGye8YMiautk7UzorGJkhx5lRHL8eZDIaKdu2+Nr9rGVri8LCxQ2880Y
         H/f1x2oqwWVQ8FL0haHBRsc7k1h4jhT0bw8ieyhmCmOttRKKE/Yr6bv3pDyZrC4S+GbX
         1E6g==
X-Forwarded-Encrypted: i=1; AJvYcCVrkwKA8CBBhGkVPteXpTqOEEBoJPqDFNrzcemV4uL0KN7Ac+wjS9MZpdiy3u7KT6CYHXW+4AG3SOQgXCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xnvtMICuSsNoQo+YlBFtXTHSGdD2wkPo2/YQuUlC58zLIF43
	uWJMOeNxKlCloDiwSS48+c1QbytfeiheejJDS3wTeRkRgmSboRerrc0lHDkwa0ktKTEbqsWv8Hn
	Een6A1Xu6qkw1pLgEytepodClSjxMUn9m77lGpptTN05iZ727ZyOr
X-Gm-Gg: ASbGnctap0e5d/Gjpe5msVj85RcY+Xdh4JcZtwAihuXd30rorO3JlABHE3UtzCrKwCJ
	6wwHL0yE/IeM+4nKSdnup4/nScYUKPEiWq3LswjqeNQonqMOlLxz20X/ZbfMWRf/d9/bjwJIAI8
	rpBJr/lYOwyFpLipMpjiv2CEa6hMkuE9wAuVFRlp39b0N5oD7C3zRi9UTf0sYTh6TF1N34EcMsK
	btHI5sQvmZs47q/j0SYZSUEf+Ts3IyYFEU/pbLARcliMWsPEUadIlZyK0NYkX2B+PG/nIEf6YcJ
	SrUu8G7ktdPtzWeR2JleROfk+8H7uT4pajbiNstSGgeZedemPD0LdMokdQ==
X-Google-Smtp-Source: AGHT+IFmQ0KaH+u8epoMwh3aIK0YZmepufL4TwiNbT5S06XDLaPCdbBhz4ar/7SSxBpTz1Uuyu5XuJnEw/2A
X-Received: by 2002:ad4:55ce:0:b0:78f:baa:5712 with SMTP id 6a1803df08f44-78f0baa59bbmr21116976d6.1.1758160234441;
        Wed, 17 Sep 2025 18:50:34 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79350777108sm749816d6.34.2025.09.17.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:34 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C1B9D340325;
	Wed, 17 Sep 2025 19:50:33 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BC335E41B42; Wed, 17 Sep 2025 19:50:33 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 01/17] ublk: remove ubq check in ublk_check_and_get_req()
Date: Wed, 17 Sep 2025 19:49:37 -0600
Message-ID: <20250918014953.297897-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_get_queue() never returns a NULL pointer, so there's no need to
check its return value in ublk_check_and_get_req(). Drop the check.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index aa64f530d5e9..9f2db91af481 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2493,13 +2493,10 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 
 	if (q_id >= ub->dev_info.nr_hw_queues)
 		return ERR_PTR(-EINVAL);
 
 	ubq = ublk_get_queue(ub, q_id);
-	if (!ubq)
-		return ERR_PTR(-EINVAL);
-
 	if (!ublk_support_user_copy(ubq))
 		return ERR_PTR(-EACCES);
 
 	if (tag >= ubq->q_depth)
 		return ERR_PTR(-EINVAL);
-- 
2.45.2


