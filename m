Return-Path: <linux-kernel+bounces-747181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD6B130BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08C4177F35
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516F21FF36;
	Sun, 27 Jul 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="IziFUJru"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837621D3EF
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634841; cv=none; b=WdAEIdTXJyNIAb5ksLiyl1Ry3czrVfDp8oKCVkIGrzD6gtGyXivMaNnM2PmZA7bXhDjauaaNjATxSqxX2mKFFm9/F5DTrKyYQVbFjywMQvMezVaTS18CVQubaZnkKn2BUmjZpQ5Ud2KybcJN/sSnoBYfWZGdWP1NszmZwByF+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634841; c=relaxed/simple;
	bh=KNhhtUFnmbc3jeA4XTRDlg8RlDWWWyXCaaLU5CW08J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsYdhpMb8Txi1Bi8sJTn9QnwM8cPmRDpnxfM+VM1R7ZFdRPt2bffb0RvuuTa9cbv7qLkmjMjDzMBo9FC0O+cYLk7sjk21UmJhmNyiTIPoNqdVJH+//+GFdwEDX9G+LAZuOJzeSiloNDXfHJ2U8i4C1If7HLxnnjh4CXGZM7xGpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=IziFUJru; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3928059b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634838; x=1754239638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMN9tLLmpGB9BsvzAxacdUhrheIgM1fafrpYT+r6ug8=;
        b=IziFUJrurw2GIHdeNgOWBtIk5DAtdsO3jkSwrW6Bkhi6j2ZmTNF+BBLDSvh5vAv04j
         fPSGeG7qYXPsg3+xBlUHa9V7QNAlE3/ChTtffEheu12Ce/mqNn9jYupyZhEdarM1yYQd
         U34IXRJbtZsh+yw8aJ3Mo7GOjYZsez7AFTsS8/nPP3+bKrxufJr1vWiCXHFLqob9O3EF
         89xcqKXPECzQZQdwbTilgB+FW/Mnpb7ws/UEw1TWXUn0cEDYj0nIy3JIct85kruAq+4n
         19uCR8xekgGg3F8jiHCt8v9L0OE9ox1N6Re1RE2k3S8BjZqgvzs2+GbnBhx9R2aUymCZ
         qe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634838; x=1754239638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMN9tLLmpGB9BsvzAxacdUhrheIgM1fafrpYT+r6ug8=;
        b=NSa6S/t+2rpRCwuQYvUWdT2gss6pKYOZw1Kpmvq3GYkIsavN/CzOCdHhUCDcoiGhrl
         9I9blFck8hgqj+36BxEJ/pO5zW7hhX0Cy7InEK1cDjbJ+gOO7Gv4Q7MF/CXWFHF/sLUm
         ML41uVAwFugB0qHpNFCDirogkcRjVp7ihU6WcXTXD/tc2+E8S/lPCAJr3X3Fgy+K9ubU
         poVl5nYY3ir70yC0C2wTzqzLtIOA0UqXspKHY7PqwBtjV+iiUeBxar3QJYD6Wlg/iVsI
         VDsoi+RZt/ml3Lfd6dhXAEPM6LGZR9xIa7bxLXCF2RYjABGLLILT7a2elMiJpreObTZD
         ScLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgTFfmpg3wyIE6Zm8jkXUbN6AGnIc8SLhVghdsRR+jwtGrzPAGXSQMkTgy6EodoXTv0O0WRVy0AqN9kuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kk+GceBNaFSwQzPmdjIWUumQthlFmEUwjFWQ/sU6sGSuq0x6
	7cIe8WR6i4MuIzbpfMgKLwFzTzrYKY4nz5AcO83Pr8u0UJmwC+ZZw5AcZN8G0rd5GD8=
X-Gm-Gg: ASbGncsi2xvsKYi+blNUED1pgQ8h0l3P9KD69ZBcDaqJXFpdSkMwYjERMIi1Lwcpfce
	UC3HEekAu3EpxSb7DCaJPFDtMHyaGklb+4YZWdwU3ELM2HaToUK89WtUBfEy+ML/VftLnpXwHvO
	2MQEXWThWQg+HE6N8ED80HLSXqQ3z0Q33bnM0Nb9Dds9/wk6jBL2iD/uSbvvr0rZo0s1XahUnBG
	Bsq+EK7nMXS3xh+npsX/d5cLbjR6twQ1nC+XCchOtNcFPbtXVpDFYC5GXH/vyvtxlv2eeMivHDp
	6l3soBHdlvvclijQXOFcn16ouN+iZILypEdyzilXEA7rDwM7gBvM7Ir+uNvl592D394LuRqcydK
	7+uiwCIzSpwHqfUSDMQ==
X-Google-Smtp-Source: AGHT+IEF24zLRrvUbYzwpV5Zjh1HPgLaykm25/5HZNKSbJYH95HEaBtQmdE1+eWOfcS5Rglv3aoXiQ==
X-Received: by 2002:a05:6a00:bd85:b0:748:ed51:1305 with SMTP id d2e1a72fcca58-7633562970fmr12389282b3a.5.1753634838365;
        Sun, 27 Jul 2025 09:47:18 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:17 -0700 (PDT)
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
Subject: [PATCH v2 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
Date: Mon, 28 Jul 2025 00:47:07 +0800
Message-Id: <20250727164709.96477-2-yizhou.tang@shopee.com>
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


