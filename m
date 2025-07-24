Return-Path: <linux-kernel+bounces-743811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC0CB1038C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC7E7AAF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83672274B57;
	Thu, 24 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="d4U4rZ4r"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846932750E9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345817; cv=none; b=c+S/9i1xwMXSrdvQcCE9bi3awHroTqPWgJWRZSAhZmZQbmm3Cg+4EWjVFSCpAQ9AWDYZBgXlQiQP0ovjoW9PlkkpTVNMoOG9Qtir8oBW3qI4t4xGXaayQWWA9pc541vYXjHr/MoAxb9sfUYJHVQ85yjOrYO0B9wEP2BcWJCND4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345817; c=relaxed/simple;
	bh=wX3hUu32u7lGHcNd7gLv9+3UgLhJdjlTWOAubBO5LyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCXkpjNV8d47uNuOPcKAlXo1h4WTBK5IanD34BBy2Uu7oKZcYMTqYU2uCGpqzD9VJhi93sABWyY0g//9hdaisWWwnjWXUBqyYuAMhR5xvpjop3xBXhrkMTRipu0FjlQ4gTrZYwT5ikTi15GCyAnHKbYNUBoHPVnfQRYzTJ/6Dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=d4U4rZ4r; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so741670a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345814; x=1753950614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQFZq13tOuleJXxHEz9Q8dIk2BEfa9yC4GGz5ESDHjA=;
        b=d4U4rZ4rFV4bEz9sixA6bcl+U0npTltPW6CZhsVs3J/Jo+SAkwr1O6AJ1dU7lT6zGB
         txr1h1PKu03J8XOoc6bnMgWsvylSbRUQzCq6dsEzquHv1cY0T5JuEytzpAM96rX37sZ3
         MsuN58y1Qhp9mcwDC+Qt/DmW8KH/KoTvhLovf5WOF81BtV1DaZjWrsRxWa/33X4QtxYT
         stIitOgBjvfatxm3WOSQtf8PI5wiiLuF0/d2feDNCnWW+bg0l5coa3Ufm18fSKEok4eH
         wfsA/zX05juInR+LdaDNKtNVmdzFM+nftleHDigNiP/LLyLNSpGQMTckPxDFjkkCgYpP
         1eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345814; x=1753950614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQFZq13tOuleJXxHEz9Q8dIk2BEfa9yC4GGz5ESDHjA=;
        b=RkfKXOlEa5g9E+onocN9eY32PdS40hb3CNMB+1hacVn72A4TRKogCz9xVHsWbD3Sgv
         jGDQLb+yErM73spbr/W0/87zUvQQnZmOd1foCW/vmPKMxESdASeHuYLZcyTiXWBpf/hH
         QbbKqEqfoMMVIzxgjjJkeXDzu5Bg2jF2ncK6QmgDeEPOkez9u0XNaz+uKE919gtv6CWH
         GwSKlklogk9BbaGjDEUbZZ11/LVZEYB0jG9AuiDV+3eI8lI6KjVo5XXlrABjQcvRoQHF
         TntWtPqFT5vMIO6GyjyLJCwlaFVlV+u+vcRtap1zduK+4q5CciJdgfKFjQIOzCaXPjs4
         9r0w==
X-Forwarded-Encrypted: i=1; AJvYcCUIztAQrTLjEfiiCsJm/aueEwf7oviX3cplQi4mnm8E/Pya5DLn2W57Z5dxbEmGhVWZ3GE+3Pz0LxmZcf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCrji8TsXuaHrW5y0OfVqvwxZ9OWesCBCPAMEqg+xZIs/VV7c
	IBCmUjrRyo0VX+JMcOIA2Clw6SdU/7BlRgpba9Z9lYVpT9l0nwzbTJgJDtnfYLX5uD8=
X-Gm-Gg: ASbGncuQgYahzTzCvUB8tbiNq4e5SLL/zFTt5VizO4mEFPe/5zRCgfuCNZ9FNmgx+LO
	74X9q/JTmSghamdzLZDVfBE5itxCfCNfjLQk/1PHxvusRL1HJYOpFz8EykJK3mFCUaxIlvdUuXd
	gJyyr6A0ujWHpOaPfnkw1/BniquX0yPT8FqUEYM8lwobMlrS4FsK2fjZcpxIuiumMaSeQXUTiHP
	HXvHXDvjrcwJVjV+oDIku2aWm3Za9YqRcgOm0NasjdTwRZihd3vV02Rhh5uCcK+o7cDmJVcEZ5j
	MLDWbCkJJznyKxse8WRcjlT55HcpUA2dpzKY91Gd/Exbrp9htOrAjJHTWc60M+pdzoXNSRqAudA
	K52Seang=
X-Google-Smtp-Source: AGHT+IGUlU8FNBEl8GSu8PYnsHMBzzSLnvCJOILYTMcEzWyLF/ddhbSopgXoLnuJrimSdJaMtZNChA==
X-Received: by 2002:a17:902:d48f:b0:236:7050:74af with SMTP id d9443c01a7336-23f98161975mr79953295ad.9.1753345813698;
        Thu, 24 Jul 2025 01:30:13 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:12 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 2/3] blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
Date: Thu, 24 Jul 2025 16:30:00 +0800
Message-Id: <20250724083001.362882-3-yizhou.tang@shopee.com>
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

In the current implementation, the last_issue and last_comp members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Therefore, eliminate the ambiguity here.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
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


