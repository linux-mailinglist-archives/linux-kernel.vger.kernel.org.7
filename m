Return-Path: <linux-kernel+bounces-761812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D59B1FEBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D79A189A0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90CC27781E;
	Mon, 11 Aug 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D1IIZlpQ"
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7897277007
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890835; cv=none; b=bnfcjDoNSvL63/54FkWaSt03XAU9IEgO+Dwrc7dPXJ31935FxGsjbwcUfg2KdRoC1bvNdEaBtPd3Vpkb0osRLaVfLP5y6IEMNHVrhNKey+K3M51etvxZhCy1Fo4RB18ahurj8wOzzCE7q0gewuBc7Un8u56u5q5r6rfM6478mSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890835; c=relaxed/simple;
	bh=X+DIeX+XsZPowEusZeMzAlLnoQlmyKNcBOTFUWpiNsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2ESqBwy7/UZVtZMzoabae134LC0vf6XAHXzxqNYgqBufLD/Pk2CTA7M0wp8IdHUzPS18/0vbRm0cANB/CVWrkFNqiQNffq1NADiFKHqlxnmUhMwLmBTKehfQR2Q1w4vtKwrw/k5UokcGukk8GagSQ3S83xpOGwvBswnuy0UPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D1IIZlpQ; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-719f5a141a3so27121677b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890833; x=1755495633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpH6x8rZ+rgBdQ7TOKJbwRYB5Ad7cxy49v5qCgwdE24=;
        b=DPrFpyABz95QkSsefVgDhSqDA1uI1y7NiWJ306wMB39g4isRN8t4gxz1EvgtwcJxJE
         ltfCMxa+8uaXYDr0yHcIcqeZ9JY0vudoNF+Gi4y3sjiCpcdEHfoYD4jaWq6uy4/7e8aj
         m4hNp+h97NLsk1N9zbGDVwXN5hjTOmQvupMU1Q8tzYigHbxPm+ATMV2VDTkTDfCBsf3E
         RsmJQSgcHWFwnvu9ZnnjkFoZrhImdKYr8Pol7kO9QWTXbZLu/iAIDVnS/EMFZgH44JNx
         MQscIEedWkvX3agnhl9brj5HQV58BFQXGOpVrkuXV2kSm6oSj1bOXUem8WMxtCYACT0n
         xzyA==
X-Forwarded-Encrypted: i=1; AJvYcCVa3My2z+zHxar++AGquv0DqQ9CFtAZ3ylBbHX5z4KKN3vXYsXp+wmAHbCFOSGVAmJWtMvLVLV2iU5zasA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7anxNQjHAz/q3we+WUYr14sPOIMlJWR7gNN0cLyci35gzN1Tu
	2f5Ou6O9e2TGrok45+WCo6zjcLqwsiV5+0sImAMwOaKRjWPtFZaOOnZ/j//ZZ0KS4OwUH8F3dJJ
	sre+pka4vHHO64W2q2nwTxP6Y4vWVdK9tBr6jk5it4N38vkb6GvTSj4O9uTEmMKJ39SDgC2S5DG
	Xnh2i527peaxNoAByWw3A54gaHp1lVdg2Dy6JEEqbs+6IfmWZpVcw0cXdjAby/9xTIdh3F/cjvJ
	btaHfO+f3IgT0XUm562JkAj2A==
X-Gm-Gg: ASbGncsPQPXw5eMVdY3qrWQgWzoONJR9JhDdh37IFVWriMTkFXZqIUKpDkaXcR3qy9P
	BoCP1FFOWFHdkGAK46wz5jyPe71M4AdenUAUs8LkYKbE75PMrZBv4BYmLU1ijewuAWUkbUry5SI
	QxPGAi9opRH87dZoCLLf2pmkrTEz1mY182iXaalhfevnEFYhwCJ/AIa2SlJTgR+egR2FtuU51rR
	ggM6SKClxlWn6PDlXowTORCjP5M9HSC28hftnBuClP8gHyksb23GHf3az9ciC0bPxgPub225Um7
	F31Ou34CD3VWu12kH8v9kyS+TzP6wecXuqxLMCLQ615P6wBLAseGQmlRi5CVa1n6uFEzdsObzX4
	mjIUGKLIJ8uO/gJLkBIxKEFGEZbfmI8ru4CzssJwjEf/riJW+h9crzfc0GscRhJaR4/hmusF55g
	oE2uVLUQ==
X-Google-Smtp-Source: AGHT+IFjXIwjKPbdIfYbYUP2U+adscFesfoRKd50pH+MQgnTwt/CLYf9ZH3Fv5LMLFE75RF79ENnOpjc/Ks3
X-Received: by 2002:a05:690c:61c9:b0:70c:ceba:16 with SMTP id 00721157ae682-71bdaf757f8mr214411717b3.17.1754890832769;
        Sun, 10 Aug 2025 22:40:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71b5a8619aesm13560047b3.51.2025.08.10.22.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:40:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70739ef4ab4so92214926d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890832; x=1755495632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpH6x8rZ+rgBdQ7TOKJbwRYB5Ad7cxy49v5qCgwdE24=;
        b=D1IIZlpQlus+l+dkaXItyCYWU4aOG5witaWtn0qdbzAZmqBF5bXnJZXtIXeDrEJUln
         /eNVk52WFqZeuDPafJYoPyzToqre8Pyhmmpq5CL5eEAxNDa0PowMyYr9WWkCQzljWr7I
         oWsFQ/Xi0wyAD/ZG9Q0CCrWim58Iw1kc3Ykl8=
X-Forwarded-Encrypted: i=1; AJvYcCXtpD8xa1icrtNtXU36o3cV1IVc8AKe+rb3yMCHIs6iWh21BE8u49ukpnYC7duABacvhMMDAjJwYhSRQA8=@vger.kernel.org
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154030656d6.8.1754890831936;
        Sun, 10 Aug 2025 22:40:31 -0700 (PDT)
X-Received: by 2002:ad4:5d63:0:b0:6fa:abd2:f2bb with SMTP id 6a1803df08f44-7099b97d506mr154030466d6.8.1754890831489;
        Sun, 10 Aug 2025 22:40:31 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm150544766d6.84.2025.08.10.22.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:40:31 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2 v5.10] dm rq: don't queue request to blk-mq during DM suspend
Date: Sun, 10 Aug 2025 22:27:02 -0700
Message-Id: <20250811052702.145189-3-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
References: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ming Lei <ming.lei@redhat.com>

commit b4459b11e84092658fa195a2587aff3b9637f0e7 upstream.

DM uses blk-mq's quiesce/unquiesce to stop/start device mapper queue.

But blk-mq's unquiesce may come from outside events, such as elevator
switch, updating nr_requests or others, and request may come during
suspend, so simply ask for blk-mq to requeue it.

Fixes one kernel panic issue when running updating nr_requests and
dm-mpath suspend/resume stress test.

Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/md/dm-rq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 7762bde40963..a6ea77432e34 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -490,6 +490,14 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct mapped_device *md = tio->md;
 	struct dm_target *ti = md->immutable_target;
 
+	/*
+	 * blk-mq's unquiesce may come from outside events, such as
+	 * elevator switch, updating nr_requests or others, and request may
+	 * come during suspend, so simply ask for blk-mq to requeue it.
+	 */
+	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags)))
+		return BLK_STS_RESOURCE;
+
 	if (unlikely(!ti)) {
 		int srcu_idx;
 		struct dm_table *map;
-- 
2.40.4


