Return-Path: <linux-kernel+bounces-765063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01DFB22B00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918373A5180
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8C2F4A1F;
	Tue, 12 Aug 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiKTcc1d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC52EF669
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009662; cv=none; b=TrF1jsFquc4Td1YJBvUx6Ns5CTKu7zyVmlpm//kjpvRa8pofb02kDieIrXYdf8eWhitcpStWpxNN3MFgIxld1gZBn+XThfgfyTErprnPKFzT8YNS7V97FoaCbOBZ29dOSbQNAbL9XcfaXuW/0ytjVLpWAvoA+TIH4euwEZol6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009662; c=relaxed/simple;
	bh=/B24jKgY1eYxf812cHNT9gVhTnmgGeQi+I8gZG7p4+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi717tVu2J75z7z0kb6lbCoCvCTCg5wyThyCK2BRLHoOcGhCj1/DJmugopRFgV9yaQ7xzwacQTos19oAr3AhZBX3zd7uFIna3C6wkAeSIJzXuENwuffRta2BmcWQArVv7+z+EqkKNc383eioUFFCecNq2A3MR9vWvy8BEU+ECcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiKTcc1d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0MgJDKWq9Y8z5RYInRU9bNJP9izytLfDXO0IEfDoiaw=;
	b=UiKTcc1d1HnE63sN5wZoBcBZWryTrN2buATO294bBPPkX+BXaWN3LfOLS1WwCYgsFpQ+10
	7znCB9XKsjhOEE2XyaPBLpd/BivnxwA7s3OtoEQIYIPoTlpgkC1jpE0VYnYuxS9ctLBecY
	qBChFh5pTVQ7sEwEt0SEMWWJo4mSLUw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-NW9TIsxcOwqhaxQGJkrvnQ-1; Tue, 12 Aug 2025 10:40:58 -0400
X-MC-Unique: NW9TIsxcOwqhaxQGJkrvnQ-1
X-Mimecast-MFC-AGG-ID: NW9TIsxcOwqhaxQGJkrvnQ_1755009658
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b0791a8e8dso155461591cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009657; x=1755614457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MgJDKWq9Y8z5RYInRU9bNJP9izytLfDXO0IEfDoiaw=;
        b=wBp8J+62XKfjlYU28aglz8+GHOPoULYC54eU4c12yRyoZf8usxPTUM8Dflh/EFEE+3
         HLvgkNKb7CMJLaOD7zmVekkmzvSIOCNXOl4HVm67+hhQBb73SbsCXRwMkeRFtfpBxz0J
         GFgIKivi+cGTPiFsr97vshZrNDg6gDK86ve08wzkwMBJjIsSbvHecRQzdUJcDMqyLSWG
         rH6RXCQXljzmUmnmMs1ToxieYbqlUSDbH/O3LuYBLJpQhZ40yHQ3Bbv3r1c1SYJoacgW
         lH7T09I37013v5VAmLLFoY1/Dt1T2a+LI/tmac2Ux6P2yNPSwZ5W5xI5Qgypblxcmsqp
         JIag==
X-Forwarded-Encrypted: i=1; AJvYcCXPKQWWWui5wkAdffhbV+TlX0Q33AfO579Kgc79wcayOCakp+9cWcjgjXZ+EQl128CFEVQSUfiYm9FsmDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44J7eqMTEII5NxjpoJGiUR3jOhhKDU/iovIhOe+KAF0tpf+4m
	61pLn3z11Hb33K5IAjAZuZOvDLJpv4nE9RXFoHJC02GVzORaCChtax9IM4p0jcN2p9Y0Tth9Xsn
	XpR6ierSG6IwQWqv5EfeQr7PAuqdLULS9QLJN4tqEesq5I7sLyKueKt67dgI8bwFd3p3+dL/Mzf
	VSognbgteD0lIYxAa/KBiz6KrTheXGXm+ZmI8yxBDQG7iPycpLVes=
X-Gm-Gg: ASbGncv+skkCGmV8hXgFWIXXGRYAQhh8Qm83tOrxAZKOuW6e0mDXd5zEIqdDIjzcDwH
	iIyLDX6/YRTiWwVPa4ePiUhKNiZs1Y9rDsfi+53wSFaW39NPdGqiaoDIWeGCNKs5ICu/E43dbYw
	1viU9LU2hbb8zFzz23OcUFEQh6RA7zXN7Ew4O29Gvaz/Ta/JM8OzpeYrrZnHeJ8LIpsiffj2JEk
	cL4FUnt0kjKMCEgeQuqgp9zqdTykMpg5vTeSt0ChHMIj2Rrvi9vdlUf4Mv3h7yxNEF9KAwnuzbo
	ul0tlj9hR6AZecG1DOSWtcSceya4hHjbX8/WkooTg8cYNWyMzggYBL4QnEdp9akzApocj5d5n+c
	ipw==
X-Received: by 2002:ac8:5a09:0:b0:4af:12b0:57aa with SMTP id d75a77b69052e-4b0aec6fcbfmr230729081cf.16.1755009656877;
        Tue, 12 Aug 2025 07:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU7fksXvEONgvnU54NAK/snQlmjlJVmymfi5lhPNVVxA94jUxwPuUrqRsgLCXWdiVxef3PwA==
X-Received: by 2002:ac8:5a09:0:b0:4af:12b0:57aa with SMTP id d75a77b69052e-4b0aec6fcbfmr230728541cf.16.1755009656228;
        Tue, 12 Aug 2025 07:40:56 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:40:52 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 12 Aug 2025 10:40:32 -0400
Subject: [PATCH v3 2/9] clk: test: introduce clk_dummy_rate_mhz()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-tests-docs-v3-2-054aed58dcd3@redhat.com>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=1196;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=/B24jKgY1eYxf812cHNT9gVhTnmgGeQi+I8gZG7p4+k=;
 b=Yw4rGAFhMHmhnXH7wLnB9dvYYoAVL5j+A7SIbu0eCs1NsVZ82Zj7a89QGc6B2urIhCODHr6bL
 FFF7iXoEBOfDGqrgVyFbIT1FDeTZoBfbiDNSypgylL5OWhHcl5ivR8I
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

Some of the mock tests care about the relationship between two
different rates to ensure that functionality in the clk core is
exercised when the parent rate is negotiated by using specific
rates. Introduce clk_dummy_rate_mhz() to improve readability.
Change the DUMMY_CLOCK_* rate constants over to use this.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a268d7b5d4cb28ec1f029f828c31107f8e130556..fafa736ca32144a2feae75a8d641abca3162d42d 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -21,9 +21,10 @@
 
 static const struct clk_ops empty_clk_ops = { };
 
-#define DUMMY_CLOCK_INIT_RATE	(42 * 1000 * 1000)
-#define DUMMY_CLOCK_RATE_1	(142 * 1000 * 1000)
-#define DUMMY_CLOCK_RATE_2	(242 * 1000 * 1000)
+#define clk_dummy_rate_mhz(rate)	((rate) * 1000 * 1000)
+#define DUMMY_CLOCK_INIT_RATE		clk_dummy_rate_mhz(42)
+#define DUMMY_CLOCK_RATE_1		clk_dummy_rate_mhz(142)
+#define DUMMY_CLOCK_RATE_2		clk_dummy_rate_mhz(242)
 
 struct clk_dummy_context {
 	struct clk_hw hw;

-- 
2.50.1


