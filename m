Return-Path: <linux-kernel+bounces-765066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0309B22B02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA983B7D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967A62F5464;
	Tue, 12 Aug 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtGnWt8T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6FE2F5339
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009669; cv=none; b=jLGWZVUNZtZ/+azhaayLCtZTrlNXjxpVuRi0rmMfkjzY9sn6wLGzvtWRIXi6i2ZsSz/vIKDceDz0BN7pOI8j/uVR7y0hSanDisOiQKRkIeQHyWr2wY5AKUHdmbN8yAnYWuMa+qQ6eGxVDR0fIks52hA8HdZWT/nKUANx9eN4CSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009669; c=relaxed/simple;
	bh=MFLVZ+yeJ3JAQq9jIrj7tqI1NByGzFkDdqRG5Pz4Yng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdFZSoY0rVpZPCc/5lIWR67S0Cqq2H/uqx+jqgQdqLtKERdGi+gfDVR6w1CTYNaKZkdIrPAKal3M+hClSzvrCUo92b3amfa3Ft9GktlwYR1ClnlJhgZWo6tI5GBiOlBcgBHrqYmVvMWBGPqg1ISOhhidIhqJiPaFSYEoSZKAc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtGnWt8T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wE6NHRrDkQn4sVKYNdpJhFrtlcFNAwhtQnV3IlAyyI=;
	b=YtGnWt8TptoxGFtAXvIIUif5g1+oYcNTvEGRyP1okoyP2drXKXQIURupY4wXAucO/34TjA
	58LxUY9Jzhl6IccKu395oOSt0J6xAle8ezDxetVoAX4MpT36XMcEg5l2eHCV+ZScDGJsTu
	2ghirYE350H9ZIjCy8qZIe4Qj8UXY60=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-xLq7OamyOw-N7mZha85qdw-1; Tue, 12 Aug 2025 10:41:05 -0400
X-MC-Unique: xLq7OamyOw-N7mZha85qdw-1
X-Mimecast-MFC-AGG-ID: xLq7OamyOw-N7mZha85qdw_1755009665
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8106a41e7so1293964985a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009663; x=1755614463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wE6NHRrDkQn4sVKYNdpJhFrtlcFNAwhtQnV3IlAyyI=;
        b=CdIl1UKpL18LhF+Oii3v/P5BcR7uAPCdfMIIeQ1g+M/1VDk3OtrBTNeX1zsho76F2O
         ZX4isjHRz5RnE3t57bFVvHk/xdc3/+50jHiPTEFPFXVrVBmdy4Ff6K1Sr1fmAFHVD9ln
         la4vTpJxNXuLPZZnyiFBCHJawGnPaZUtGPD0yWpQ5WOlPwJ1TBRtdWXyLeG5kbvHfagp
         TP28BsZ01Xk8SbRWiAtzLiM4rItZ3bUySPlWVvFvLc0biuDgpDfCv2NJW5m6g0gs+EAa
         e8uXafTMDP5PdxYxmRAytB+q4p5XX1WLs0DSb/pxRTxLu8wdlWpRJR2KMPjCKvnLpfz2
         o2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX43de037ETWzPzWxguLs007I6IvQEuYbILL1UNIlS02ABMldVjzUQGtx07TzLHb6OASB65tm8PvAXU9aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnIzMt0lATDUQNfXCzL8BcxXXHpwrSc8zCEAWKGKCXKGBC268
	tz+I7EV7Ge2jseqvonDSXWvnvVu6Xdti6klqt5TKKvwBWex3p4QM9j9h7aRXhrCFr9QdpSxY/j5
	gdbAi1Eu6st/JXis+jL3bOrmj+M2AH3RtSfNjQSdA5zUkIoY+vKKcx1q+D02EqTkJiqHVulB2tZ
	BFveCsilwCNL7Y/uaC5CbsanFvckBfwOFK7usgD+enl/5XvHdnJ7E=
X-Gm-Gg: ASbGncsgUI4E79T9Y+1/ZypMoGg5/9gb060kMKE2RCdqzhzXxd/r+nVQu1U6REeNkfK
	HM8Xhko4ehZHtUdmoH81T0P1hh3lrcJsUdzCrZw5dhgtcl4cqSx8ITAjo14bTzHdR6ynSxBF6Y4
	RyZy/wuleCxvY9hKmxTuWwJR31AdzyV9+hGgopHRHoQDwb2bwdAyqYFnjsBGMar5DGlll6W1ksU
	nijj+PWwncu9nvTvs/ZGoi1dzsSSr1NAgOP8/NC6iPTj6tKyXM1hA8SFdfItfVxQL21Ye4PjIBg
	BanZY8o681vR7oYM/RXcQuM8Z2OgeMXe7TaFE8n/QHDXRmJu+V4xLLGeaz63dzLvqRowG5cQcUD
	vRg==
X-Received: by 2002:a05:622a:1a10:b0:4b0:6614:c9be with SMTP id d75a77b69052e-4b0aec6ef7fmr226999131cf.13.1755009662613;
        Tue, 12 Aug 2025 07:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPhFWqsHYdye4fhYgxU7Z/OBL4dYd4TfOrpBNX+RzTHcwwigU+evSDB6boon7iaBHTtU6/RA==
X-Received: by 2002:a05:622a:1a10:b0:4b0:6614:c9be with SMTP id d75a77b69052e-4b0aec6ef7fmr226998471cf.13.1755009661921;
        Tue, 12 Aug 2025 07:41:01 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:41:00 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 12 Aug 2025 10:40:35 -0400
Subject: [PATCH v3 5/9] clk: test: introduce clk_dummy_gate for a mock gate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-tests-docs-v3-5-054aed58dcd3@redhat.com>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=1504;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=MFLVZ+yeJ3JAQq9jIrj7tqI1NByGzFkDdqRG5Pz4Yng=;
 b=gdadZaM7KZ2cp6knrICzyw3XBzm3p2TfaqPaFy1xwzCTRQTXMLfKFoR74lWGK8lkiUEjPJszt
 LgZM09eso3gAS9UCCtZKczcQ4WLmN7oZam75+gDfyVIROoL1wBSstjb
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This is used to mock up a gate in the clk kunit tests.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 81095fd80b270c1fd5e73e90a2f36da0071d10a4..9ed887551cd9b4926075d85b30b6cdfc8d307ea6 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -179,6 +179,40 @@ static const struct clk_ops clk_dummy_div_ops = {
 	.set_rate = clk_dummy_div_set_rate,
 };
 
+struct clk_dummy_gate {
+	struct clk_hw hw;
+	bool enabled;
+};
+
+static int clk_dummy_gate_enable(struct clk_hw *hw)
+{
+	struct clk_dummy_gate *gate = container_of(hw, struct clk_dummy_gate, hw);
+
+	gate->enabled = true;
+
+	return 0;
+}
+
+static void clk_dummy_gate_disable(struct clk_hw *hw)
+{
+	struct clk_dummy_gate *gate = container_of(hw, struct clk_dummy_gate, hw);
+
+	gate->enabled = false;
+}
+
+static int clk_dummy_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_dummy_gate *gate = container_of(hw, struct clk_dummy_gate, hw);
+
+	return gate->enabled;
+}
+
+static const struct clk_ops clk_dummy_gate_ops = {
+	.enable = clk_dummy_gate_enable,
+	.disable = clk_dummy_gate_disable,
+	.is_enabled = clk_dummy_gate_is_enabled,
+};
+
 struct clk_multiple_parent_ctx {
 	struct clk_dummy_context parents_ctx[2];
 	struct clk_hw hw;

-- 
2.50.1


