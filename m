Return-Path: <linux-kernel+bounces-743810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E803AB10389
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E1C1C25FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE51274B52;
	Thu, 24 Jul 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TmHormUZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55760274B5F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345812; cv=none; b=F6+tSGc7cRq/qKcEPD99xA3gWz4yOaeiJu0ZLFdGCwbZQklg7Rty1bVBvsM2Ru+csdODRbv7pftcyD1N5aq2iqOe+swsiuY+U7uxdAWNxhRNyhMeCjp+ujii/I4zcTv3kDVOFO7E9GO9NvEJsc2PuoNFjxfRAIzzed2qS2524cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345812; c=relaxed/simple;
	bh=HJ1q7SYvO/kv77mnITuBAFgcNAZ6IxgSZnDQS4kjSZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2mV8w64LW3k+oatnNxS/mF5Y72BPT8Ns0M8T8JkiCAotwKE+GQp9ntdNPI5QR3lt/kbeJ8aZT+gwMavqzglWnTLhyMAy5G3qIXKJKNx9FzyAv3pfH2Pb/CA+T26Qf0mQ1rUC1mzGfRsm8TH0sU20JgAbNzKlsR1uUepRKWhCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TmHormUZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so6302865ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345810; x=1753950610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilRkYBOzxNvuqeCrMQ/r0JNQnGrAnxcb64klMFAHePQ=;
        b=TmHormUZubrvTIME9vFMmVvRaAAgL8+G0xHCgzOhNawqW+rgI+aQGpau+6ogFv8zWP
         uxgofs8tQGRLYpYURvC+YYZiqdnDmpsQbp7WK5TVGA5Z0MBEwWfRwIZxUpcj1juY40Zg
         9ZUEIPdFq0hrBYAuTRggyjqRu1mwJ9cD15JeKIDjrqAyxDZBOAErrp71kRtoVmcpGx1N
         yw+SSyMdHAu3CiGMnAYha8WZSezZLK0BAVWVlaFpPktVTsQraedRXchYjLpNB3GQ3gE7
         BRJnV62xOSigkkuaZfWCsDvYwskjglrN2HfOLQbJ2lVOTtQmiFlhiG3KbufnsqOWCPJe
         uekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345811; x=1753950611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilRkYBOzxNvuqeCrMQ/r0JNQnGrAnxcb64klMFAHePQ=;
        b=tSaBRCE2RGbw/cnlYU+kgQsjmNnNUAnWHol81JmaKDrpwZPftBE6oGyqbo8VK3cuu+
         RINCrFxcHoaDeNp6wYP3QTi1REv4UFuCbA/EI88mNa8r3V2I/3HnlTpRdaI/PpFYFyTg
         lPsBfnoFDzfNOob/BA+UdMFhhyxLFiiQYhDw/zp+iOvjhuuaLiRflx3i+HRvroTu8Dlp
         EEhmcmJ4DZcUA/8ire5J2Rmt1K4knEO1zYbag2hugNR/k4BxT5KuRRI0dDXJZccCb/tQ
         o51nr6FoUvKbi2HUbOdsCVjhXmTbotXvBFRXgBVwOjkbIYsxMDIf8tH3z3GjmD9d3t11
         yOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUcLhalEYKjJfKSFWwW82J69k4kBfx8ZgVKU/EwWwxmWhxlwgWmh6LN+D5lB8HXs2QtrT7qaNlo8hnYxKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnW6EluZaogqfyLdANP1D1EI3JWulXRho4uUVIZBBeA6/2jYw0
	64DHrjA2atEsyDTEBf88nA+wPW9Vzq9/gUzXpVI/Rh0WcSSViQ1cRzpWh/yBy/8lhOE=
X-Gm-Gg: ASbGnctqENOH6cmhGZB+y81jWsOGfWS09gUHi/8L9+/ei5R9Gh/eTUdDRGMnais8jHN
	H1O428K8K4/1MlCcesS7F+C8RgspIgSDeOw3hokmpEhNwZo/MuCkw5+nsnMjTJcSarAYnyMn4/9
	XYwTwslZpJuSKtNH1mrUdQM9R4IG28LbgnJCIthRR6uTgrUohp2FNFMOsoR03e/fHJXdyeydjy+
	fnrNr2bw7SXwhJ8DzBHREmy76KQRGzKUF3mAVE5GWKAfHbPtSsdusAVtfSiYYHJ5I6YBwPAmFdW
	RWI3YbDEVqZYd8FaAb2DJ0dv5BcyVyJIe38vf+drb+b/CAZH4pJqRD5cC0YWn0/GGyZz7Acx7gS
	Y9ACnUNrqW/sGj4XlTw==
X-Google-Smtp-Source: AGHT+IHhH47l0wPWn4JZ/VaU0HvCzPt2Zvz0cwZdqZrO0EddG/gLhfEw0l9jTAIpMcxtc2WYAZuoyA==
X-Received: by 2002:a17:902:f64f:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23f9818d905mr87530275ad.16.1753345810656;
        Thu, 24 Jul 2025 01:30:10 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:09 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
Date: Thu, 24 Jul 2025 16:29:59 +0800
Message-Id: <20250724083001.362882-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724083001.362882-1-yizhou.tang@shopee.com>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
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


