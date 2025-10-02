Return-Path: <linux-kernel+bounces-840064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C3BB3722
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9CD3AA3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB5D2F9D9E;
	Thu,  2 Oct 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwFimQOK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B2263C9E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396929; cv=none; b=byjPKrZJQezZFD55/HkhpMPkMJetymDOZVLCWPN7gT//Pi5JA9yBHS1cq6Zq134N145HRnB15DP+I8jaHC1DaCqTjubjHMne11QixhFMzi05D0V2/6CRft+hgpspvQKirU2Y8LFEJaqv9jarWaqA0sYlMuooZdp+Ggr2lfv4UFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396929; c=relaxed/simple;
	bh=RwJ/fL5zF2OPAeV0jJQgHpmjyKSmTI6qIZSDxJIJrhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SM997BZRejxKAx2n734B6Q3cDsc9VziD1GQgAmd7NFzvR5ZhBn2oTH+zM305+604BAGb4xqXF7my0V4/dn1SO2PMrGNoWmapvaB5rdL1KncwzpZ84gnaVZyZ8+01Beu1Rm/u/8YYl6gLdSP1C4KI1rdFq4nXMDMaewEGsg8B+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwFimQOK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36453927ffaso7618461fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396926; x=1760001726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc18GZtrHqzSr/pDa9pzm2Av3OH9+j+09Y6i3Vb76QM=;
        b=TwFimQOKFfnVDr61JjiZeJmHr28KI62IRkFAYRTXghdn3sGXDUi5+JY1ksrGNzhh7D
         IH8919pVHykH6EoipEdVN1CWgffUFrqT7wyQfRI1u7XEj7k3yH0iM6aP0BcJ/otDrZu/
         T60Xvuw8ktv4ANrmyXm09T1xSh3Pgghj2h9RXNl+ki3K775UZOQ9Tmz+xRsTOslTm0KH
         puX4/e1fbIYI48SUFI2Wt3ug5B7kiodkdZfaJzQyny1G5dxmLYqlp237/MPhUTn7XoKO
         5nxiAwMJCQ1KEXNxFRNHiIi4kQteGaxYjeQ3haqITVGlVVblf/dT8NI0K4NxQLjSGiuR
         o+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396926; x=1760001726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc18GZtrHqzSr/pDa9pzm2Av3OH9+j+09Y6i3Vb76QM=;
        b=WqfYsjUobtsASwzOwo7zsMSnPkXYHZZgSKEKWmbtFFQQ+kW09HDYgH79clVQ9jfOFj
         xE1RxVsWMkTqV4yWQZ5Ok+0/xETvS5nvRA3BDJFXrKt1mOXksbpETjfzfp1vfoil3aj5
         F4ijU/EFeGzAbgsPOs+KXKGAVPBG+7gz6e8RPJcPbn6/7XKBQUklEFr5Z9Db9MCQlK6C
         vx/29ol4yxXl4GW4cHTYlVVtQs35ljprDd9Xx2tsGo1FJjj0wvFg2QYtPYsSZMi/agkw
         XQI4/WAfBwwU01+A+95K510cPXvSwn5QUL2ePPwZvQbzPnRmhIrSkwj86GZSjXNDr16o
         BaEg==
X-Forwarded-Encrypted: i=1; AJvYcCWcYO9ENsM3nkm1wJCUtchmtUni8k6c28yST/Iu3nLbfpZj3vUpf9wYGjItD/VKb9AIZXDLqwnN0s8jDZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXLYXdFS+0PO9S8V3aL5HttbP9m4y2kxUvHXsIQ21Ec7s3G+5
	NBGwtQEeCq9KfcjHvi9RlCIpVWizsScGcbFBa4Wcxhy3rDe36weZMOUB
X-Gm-Gg: ASbGncu8Ks7XkZg9GfB8rEuKRlB05ibVnHKpQSnay520jXjrAAyFecn5hyiQUhutafV
	niRsk92Go017TBzq/5qlk2zeTDNDLoTBQfGqY57v+n8xLc5vsNmEIJ9Nez5t7uCPEze8DTLobeV
	7Z+HwojMEQ0wxiDBgvpd/90mkjsxH4VsfSdSqUBg+9Yu6EQws5/h1Hew36zD4rvcCWVNvAdqyV5
	d82PWsodlERv5frznivu57ykO6RlnAKdDPVGtGSXSIgJ7FXOu2RtTYnfWLbaG7Y86snxx/k3z5U
	ApMI91IrewcZSY45iTM7MHM7+uRu+opLdaspD6flAT2OhrxcREb4PxZYPHeAC2czmMgFYsEsPBV
	p8Z7+dkaJUpmG/D2vXs8GrD1TNH1Rz6np8VzT4SkyEwGoDBFA1Vf+tkyoa0viOQfJFHk72S/49y
	VGmJ3mN/dW8ZhUQggnLc8VxbFTDc8u6WUGmRWMBqUx
X-Google-Smtp-Source: AGHT+IE8i0+6YbCw8yKaxx00ipzKZM5vQ/ktJ4J5ogZF04+s2uzUegs2HA0XBU3rhglvN15ySQRqxg==
X-Received: by 2002:a05:651c:512:b0:372:96c1:b276 with SMTP id 38308e7fff4ca-373a74d5c50mr19350441fa.45.1759396925877;
        Thu, 02 Oct 2025 02:22:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba44455dsm5531951fa.39.2025.10.02.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:22:05 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] nvme: target: fix error checking in nvmet_fc_schedule_delete_assoc()
Date: Thu,  2 Oct 2025 12:22:01 +0300
Message-ID: <20251002092202.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The nvmet_fc_tgtport_get() function may return an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/nvme/target/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 337ee1cb09ae..68a416a92bfc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1110,8 +1110,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
-	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (nvmet_fc_tgtport_get(assoc->tgtport))
+		queue_work(nvmet_wq, &assoc->del_work);
 }
 
 static bool
-- 
2.43.0


