Return-Path: <linux-kernel+bounces-747182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C55B130BF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077EA7A288B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A15216E26;
	Sun, 27 Jul 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Dd17NR6r"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C321FF38
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634843; cv=none; b=lY38nbEAGMCovsWr8PDZHf3RUvYikY7KJySqFi9czVr2Gtb3PBrLXGp8zR+t4R6wz8g7um1frDIhdxSNxtUfU3iIm5lg8LAAuvU/PjKZMXtVTAr8YxGM3NKnLaHPB4bxaBGZKeTVTe40bAKRvCbqB6x/q7as7MKzARqV77iDpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634843; c=relaxed/simple;
	bh=I3xew8je8GRIx1/aB/St3V1iUJkyLvLXJlWO4o8KLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTw9x+cTQxyTT3IvUY9k0xl8zn/i63yFFqRXTCN9DlrxcIotT+giykZVC22agjlSPO+V7Beof5GmKba8urTTkLT7bR7zG3NIjbwsoQHVtdEE48XuZKEVnGktdaZ+PuR+SqwIakcYhxNn3TYN2cEMrLgRbx3wra1wPld3xku7PLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Dd17NR6r; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-749248d06faso3168835b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634841; x=1754239641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=Dd17NR6rV1ZIVAWBB6atZVuY38oYNDkrMEy1LwhxI++M2WG4OaM3iR05S1yLwDxSp0
         XTEHbzQ6X+eyBEEB4eXsDkw8qT2mNQxrx346RwdPpvq7JdoGhcuHQo1loPcS46uuZSRs
         6g2YEBV6xRCovuEoaOQ5AK2F/h16HfKtiHYeQI7mNY18tUWgQEub71mf8T9C6AbcuS5Z
         ai/iITIXxcSKHCq6qjfJa2eLo+MZgq359NeYtgPyAP6KS3Kgn1cEZtErP/iXp79mbgn1
         Iqs0Toyc0oqGHGQZtTVbIKbkDw0Pg0mviogl8TWhfHk/P2GUag9/k/1yACsgAEe+kniT
         uJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634841; x=1754239641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWYCKfy27tzmCzfyC4JZHP6ASajzBlmmh8Lqhq4+b6w=;
        b=Y8Ui85U4ltNsDTREoQyhkFX+ovU9QNMPotLYkkPV+TEDjV4d/p2PkzANv32Q1ZTZ5R
         XCpJGHrfSch5TuwXWoMbIyzqIgXoV1KP91fweTDSJzHS2mHso0HH9RdXj7E9Xpr53ZOS
         awh+y+6nR38447m3Zb2PoUMDvLi8xvq2dJ0VIb4SAlhXKEivPR9ZkEyMN2smwO/FJBKq
         GZC4Nb5WodE7Wwo7Mai+6BXHOALlhADfwWPedC4f/cEGQjO8FxnBFK62t4yWOKq7Qvnf
         GgYtcbDU8lGgGTFKWr3GBgGEhIDu2Tr8rwbdq9tkd3y6Fpa3PeRZ/Q7dv2Dc4U6EmJYE
         OETg==
X-Forwarded-Encrypted: i=1; AJvYcCWdyj7aeEvfm5AQDpRmJ77DA1RRn3qW9GAQMH3QKEZeoUllH/tXMMxcrGyvJsVS0LbXZXej2MfO6DyTTic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlwtyiOERQUlEcji1zeuJd9jAXXiyz5p335mzFUQ2/iwYWKvN
	ZuVzyykCEr7ak6pIkfl41y/70zKXT3ATaHN2WDD+9D4ul2Z1Jg0dGOoqCdsl3QNmbdQ=
X-Gm-Gg: ASbGnctfGExTlEf4YZNdM30l28JR2AQeLA5HBMcOrH+HXvblJOQnreom59RJv2UqjnF
	nJKW3rc+ifEfqAM000WA4dl4Cwh6aqFQh5Nm02sjqM58IDefa6wCr2Gu000D5q1BxY5YAjul6QQ
	298d1CPL/weSNQXpf/5sN4vPG3psF26ynkPKUUvRxLLkieLauFLnKUR9dk3C9ZFOcRYKr/qT/0u
	N9jDUvwaul7N5SP7HFPNiBNS3lSVJFP8BMQjKnk3Zu7OqZS3K9HMV9/htzTB76371Opqs79zZ3/
	K12qnBDWfTUA+XKUY4BhtbMCcv7mWnHN+hvHF5IodsxU4q+Dtx7D66gsM42BmaOb+jDNhoseBFP
	s9/IHGQ4e9SZRGGKmLw==
X-Google-Smtp-Source: AGHT+IFRol1JcpMwHBaIr/iN69m2fbS57Zw0c2c31BLpe0M2WVnu9P/3rtcV5uRwgswPSOGO4xpIVw==
X-Received: by 2002:a05:6a00:3c88:b0:74e:ac15:10ff with SMTP id d2e1a72fcca58-76332578505mr14337976b3a.4.1753634841498;
        Sun, 27 Jul 2025 09:47:21 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:20 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
Date: Mon, 28 Jul 2025 00:47:08 +0800
Message-Id: <20250727164709.96477-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727164709.96477-1-yizhou.tang@shopee.com>
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the last_issue and last_comp members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Therefore, eliminate the ambiguity here.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 30886d44f6cd..eb8037bae0bd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -85,8 +85,8 @@ struct rq_wb {
 	u64 sync_issue;
 	void *sync_cookie;
 
-	unsigned long last_issue;		/* last non-throttled issue */
-	unsigned long last_comp;		/* last non-throttled comp */
+	unsigned long last_issue;	/* issue time of last read rq */
+	unsigned long last_comp;	/* completion time of last read rq */
 	unsigned long min_lat_nsec;
 	struct rq_qos rqos;
 	struct rq_wait rq_wait[WBT_NUM_RWQ];
-- 
2.25.1


