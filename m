Return-Path: <linux-kernel+bounces-825163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF18B8B274
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9EA820C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC52D373F;
	Fri, 19 Sep 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/+uNAoG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1402BE051
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311772; cv=none; b=AJQ+MasEI+r+6ivFNjm9/TeKfJLc8OHU86Q1kR211Dcctx2qWHhVGDrAQTMTTW3rLp3Q3i12SlEPmaK4r4MjlSk5lNEVXdwkqRcuqFFa816FwDKHkkUy4PnjmeU2b8D4X8ojZU4oztNRKKzzjcYuBGAGD9vS5T2v9ycBu0UFv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311772; c=relaxed/simple;
	bh=7GfH6C5wiLmUyC6hOllKgwd6MQScZUNtVuMgQL1+B/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LN1b1ukr2W2mPAd9YKQKy3LJkY9J01XZIKQvrggk+w4Hk/LBJ5C7fvl3uBcWovJmcqAgptgD2CIh2baYzlRlsikf+xkITHrQb8Gw4N7e376KB/V4TPA46JyzTrGE5J3dh2jMLLYJrRDfaPH5y9ZkT9zwoKP7ksq3hkooJK9frO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/+uNAoG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so22428675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311769; x=1758916569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+a51exDJ05DQw0D1EKhM9Qzy7OjGvcmwnul5yul+TtA=;
        b=k/+uNAoGEg6c9j0QE317hmlmi0HXBjVYBcnfwYz6hcX/vl1yXjR6uTcrqKcA2uPYuZ
         M/P5XlOTKf7oJj95os6ij9iHHRZ8Q3RfaTOIj50cYujESAqViLDnlx9Bx6PMTUKlYu5z
         orQciZs5msUu6pSGNn9Gwt6QjfVc1nBVjQHJyPx1mBkWfHXHB8vGteJt864c152s0NKC
         t17wtKbQFRQPIsVA6sQfxbiPKfOA3kpQKiqM1LVlJfBlMpWI71Vm4hQXGN6e6RRUvzZQ
         Zr29WFg0qxjUNoXcb82RsGVgbTY8GrnHD+NAA0az1vifkE6EbJMt0yz9aUCIFIivtlOE
         g9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311769; x=1758916569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a51exDJ05DQw0D1EKhM9Qzy7OjGvcmwnul5yul+TtA=;
        b=FuQnKqBNRqrq9i5J/wIbRqLcjswUKRNU32ro2MDAS8jIDEpPkHpTSfgbNO1BujKond
         gWuKmd7I79WD5lK41EDxNEC85R89rBzvNXa8jWKnpIdPca5FKsuMKf7wFCUa1WoktSW7
         zWjJGNdUlGWfmKTu8hJSWJn9fI/FD7CFVTiCfHnFSOASJCJCKxYsuRt033eHyhgNww09
         DjiQMHOtwPTpWmwVGALYCdMEusAflbiL+4tqnpce5chwjDZzJmxPkW+cFHJzGXHO8psp
         liwoOxPM9DzshrNo5tTQccsyAixtE1XO6ZWNDiOQgL6JPCiyApV3rV/OQvjpF8AlI7sl
         7YFA==
X-Forwarded-Encrypted: i=1; AJvYcCXRHkMNpXeD4Bzv29SOl3X/gr9NaKXOXpvH4JiZGhvcBysmKdhSVafOoz4nm1e5ym9g3toYt0AcB3vSx30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffbSuaxJbYx5I8oftioNvLC0tKXM9hdFScuPnIWp4waCoaU11
	o9+a8ibFp/Dcsr6DfzspTXSoxQd2xiCE8wzwnLoKdTE7pPajTqI5/28s
X-Gm-Gg: ASbGncu9k9S5888ldT8aRUnGMh3u/lZ0uvKlO1SAzG5QQyEUCC+miFSpmYCvZGHhgQR
	o1S1JHrY+MJ40vMDuV1LzIZQGlHjgjJmnuaLw/Q/DZE3DvdfOREdohsyI6qCUKu1oaDFwpRVI3a
	0b31itBwY7kNdaEYGD1H64OgRuzAWwfzitOiqC/J2HASK/Lwi23vYmsSo79VyJcTY3rtDlFmQmM
	klMGf4LsXmNAsNafLsZCDYcUacGda8nP0MPPstQ4S75JA8NU9eQWXGSnC18xwI8ZVkFo/bxnroV
	jA/+x0eMzO1cIFLSY4RbPSt09RmtaHvchd1qVSvv7b5T3LLb/sZYX9sO1lVUOhgiqMs3Nc1Y0oa
	Que1o04ZTFHnJydWgyQaUt+m6a9zbTZyAHg==
X-Google-Smtp-Source: AGHT+IGte2N8cUwiNYbPkgL94/w5J6QjZCyi/RHDhOuWcPDSkkP1WjlhIAYT29jvQk7VakWFiZj0jw==
X-Received: by 2002:a05:600c:c4b8:b0:45f:27de:cd22 with SMTP id 5b1f17b1804b1-467ea004619mr46781525e9.17.1758311768940;
        Fri, 19 Sep 2025 12:56:08 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm97025485e9.7.2025.09.19.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:56:08 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 1/6] staging: axis-fifo: add compatible strings for v4.2 and v4.3
Date: Fri, 19 Sep 2025 22:53:55 +0300
Message-ID: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is compatible with both v4.2 and v4.3 versions of the Xilinx
AXI4-Stream FIFO, so add compatible strings for them.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c   | 4 +++-
 drivers/staging/axis-fifo/axis-fifo.txt | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index e8aa632e0a31..bab2002628df 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -770,6 +770,8 @@ static void axis_fifo_remove(struct platform_device *pdev)
 
 static const struct of_device_id axis_fifo_of_match[] = {
 	{ .compatible = "xlnx,axi-fifo-mm-s-4.1", },
+	{ .compatible = "xlnx,axi-fifo-mm-s-4.2", },
+	{ .compatible = "xlnx,axi-fifo-mm-s-4.3", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, axis_fifo_of_match);
@@ -812,4 +814,4 @@ module_exit(axis_fifo_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jacob Feder <jacobsfeder@gmail.com>");
-MODULE_DESCRIPTION("Xilinx AXI-Stream FIFO v4.1 IP core driver");
+MODULE_DESCRIPTION("Xilinx AXI-Stream FIFO IP core driver");
diff --git a/drivers/staging/axis-fifo/axis-fifo.txt b/drivers/staging/axis-fifo/axis-fifo.txt
index 5828e1b8e822..413b81a53202 100644
--- a/drivers/staging/axis-fifo/axis-fifo.txt
+++ b/drivers/staging/axis-fifo/axis-fifo.txt
@@ -14,7 +14,10 @@ AXI4-Lite interface. DOES NOT support:
 	- AXI4 (non-lite)
 
 Required properties:
-- compatible: Should be "xlnx,axi-fifo-mm-s-4.1"
+- compatible: Should be one of:
+    "xlnx,axi-fifo-mm-s-4.1"
+    "xlnx,axi-fifo-mm-s-4.2"
+    "xlnx,axi-fifo-mm-s-4.3"
 - interrupt-names: Should be "interrupt"
 - interrupt-parent: Should be <&intc>
 - interrupts: Should contain interrupts lines.
-- 
2.50.0


