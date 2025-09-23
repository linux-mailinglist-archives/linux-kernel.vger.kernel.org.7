Return-Path: <linux-kernel+bounces-829138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B93DB965EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6123322289
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08665274B5E;
	Tue, 23 Sep 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjAuTydV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75BC26A0DD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638404; cv=none; b=khLL1gxRwXm5EHYwFnWvEW27X7EBRLbPlsZyHZkuFAzrc7sj8L4UUISl3ard0l+m240kkbZKqDUlXcM5khVcyxITHBRzNfIQ47uP2pac6AxwKf8ViqS/ZefWZu9oypW62RgYmUHo7yx8jscAo8c4zE5Ee+sLSaNSdxBgF8OjC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638404; c=relaxed/simple;
	bh=cKxFZ1V9JkbMvlvajDHPLZ47CwL2tRpgNY6Q+YW/aF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBD6yTGx1qAVXHGfpLzwm4LlFOfAgo542uOqfxd+6YxfyAAj/uDpAqPt91Mzuhj9q9zGz3wIzc4Ip8yDJxS0LdiynawXCg0s2RoQ5x7MrPuWpiSvRU/VbbzeUYho3ec0OLGzrjFK18R38nSxK69EfhBGyeenmqYoR1Ehj5tYdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjAuTydV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbj/S0aRmzh4H+OIrc3SDD0aZUBHX/EMobfhnl53kHo=;
	b=RjAuTydVuvdRY22wetfAMweZwabsVoq7lPbayqsLe4itQsYagQTDnlI+pIP+6KgD+SFMmJ
	yokiZPY3jx5HNceJ1gu04y0PxulnDuFG54IRZSMB34sRbeeLZOv27tWocTaR/K7TrxPQlV
	mfNKHVauVdwo1M3aFgYhIjhpDn62ioM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-RW6Nd_f8NviBqVBCzNrNGw-1; Tue, 23 Sep 2025 10:39:59 -0400
X-MC-Unique: RW6Nd_f8NviBqVBCzNrNGw-1
X-Mimecast-MFC-AGG-ID: RW6Nd_f8NviBqVBCzNrNGw_1758638399
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8502939d0f6so250917985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638399; x=1759243199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbj/S0aRmzh4H+OIrc3SDD0aZUBHX/EMobfhnl53kHo=;
        b=PQwdJb8O1tAHgXl+yJReDPcrnPtLGo8CQcSuGjM1Ido9wju9vHuPJhRgBEVP7xuC7Z
         YFErQq9HjuAGvwPnC+ZXh1kemtKHN9xjcx65+86kPmqcocrVRHR4b/FdpkP6l95lFh7/
         FwDoDjQ23kI1m+Ae9/LBli0iKrcGULKfgos3OkJAFfipJdkL1X+km33VBTpvDtwPhcYm
         DvbtWZ2RbEYhmp4siv0Vy1zqkh1NOcFt4Att4gC9j5PYWe5B0Iabk+Rpj1UHeEu1zTaJ
         uWBW1T9rlCk0fQVPPwr5fKV/NW/T/To8crLd6j+vCIDCCVkxlPI012tGEYdwJmAjSrW9
         lJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXSI0TQ0avpJNTP8/omvHmsTThMPVCjGzYFXlT7S1FcHJ45HM5G0i4I776TfU5VUm5h+oBcofcEZruWnUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4V4k+vf8F8qwaE7vQTlT7EplDH1wA2gIxjA9SIt3FxKJRKUyH
	JXyQEFploEIj2epvL0cGGJQZsmsU7QNF8DDfKM9P8PDQrWuP/+8FfwjTABvlZwzjSQpRhcpI2mu
	XdBeVp3hI1QOUY96fsZTWMMATT6DraWtGJ1fbsAlh8A1qPPjbOHAI2TmRlzmY1SAooA==
X-Gm-Gg: ASbGncuYYApuMBvaJbWdmjPAuth0UIUJs7S2o7yrIPO9+FELkF1z1MvqYoi6PdTD6ra
	sNt2ABpjMaYlG3CYmLCLWnykOQ55IUZjNyBPVpPCED2PIwf8OAXu4pqe0zFV6km0Zl9PxXu1Mqw
	nMcBZqW65FA/a2JaMXGLL36TzPhX7xsI5X8FOEx7I0yROtn0tQ4RF4N7LQtboJjTbwPQybfDTAz
	n+OsE2EbS7kTmmI1SjK8IqEQkUUZbZwwZTVmBmvw8XLTkFs6U7tLXY2oTIPfBKGB26M4Pc0Alma
	bY50dfHHkBFgfFRMJykO3DbH1ZnbcGcMYjqx6k2xF1wxWjzPnRW+xkZGyhBAsIWdqw6v1IUrtau
	N05QODRmSxPwjegpTClR7ISAX7OKUYCIMW8E5ySo=
X-Received: by 2002:a05:620a:29c4:b0:82b:7a80:e48a with SMTP id af79cd13be357-851b634daedmr251399685a.24.1758638398626;
        Tue, 23 Sep 2025 07:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkgaHgsa3dAnSghMgykCefgHSWKnQmgpmqmcnFrZsNTEAFjdJhOXkXgMBQKiKbRdGNJDtlSQ==
X-Received: by 2002:a05:620a:29c4:b0:82b:7a80:e48a with SMTP id af79cd13be357-851b634daedmr251395985a.24.1758638398130;
        Tue, 23 Sep 2025 07:39:58 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:39:57 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:22 -0400
Subject: [PATCH RFC v4 03/12] clk: test: introduce clk_dummy_div for a mock
 divider
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-3-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=cKxFZ1V9JkbMvlvajDHPLZ47CwL2tRpgNY6Q+YW/aF8=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubdSfu+BVmmykusC/m7o5639rzjv8RT2I0TLZPu7aB
 4tcE7PlHaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEykg4Xhv09Y6ua9e74b7dv9
 spTVMuTANluXe6ZNC2ZOmupvWntPUp2R4U3vYoHW2Suv6lqpGSfOFSr/qKqyqftUWfvSEiY/qZT
 lXAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

This is used to mock up a divider in the clk kunit tests.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 372dd289a7ba148a0725ea0643342ccda7196216..e1f72fcede1df1d486744b171728231ec8fa8836 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -137,6 +137,50 @@ static const struct clk_ops clk_dummy_single_parent_ops = {
 	.get_parent = clk_dummy_single_get_parent,
 };
 
+// 4 ought to be enough for anybody
+#define CLK_DUMMY_DIV_WIDTH 4
+#define CLK_DUMMY_DIV_FLAGS (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST)
+
+struct clk_dummy_div {
+	struct clk_hw hw;
+	unsigned int div;
+};
+
+static unsigned long clk_dummy_div_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct clk_dummy_div *div = container_of(hw, struct clk_dummy_div, hw);
+
+	return divider_recalc_rate(hw, parent_rate, div->div, NULL,
+				   CLK_DUMMY_DIV_FLAGS, CLK_DUMMY_DIV_WIDTH);
+}
+
+static int clk_dummy_div_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && req->best_parent_rate < req->rate)
+		return -EINVAL;
+
+	return divider_determine_rate(hw, req, NULL, CLK_DUMMY_DIV_WIDTH, CLK_DUMMY_DIV_FLAGS);
+}
+
+static int clk_dummy_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_dummy_div *div = container_of(hw, struct clk_dummy_div, hw);
+
+	div->div = divider_get_val(rate, parent_rate, NULL, CLK_DUMMY_DIV_WIDTH,
+				   CLK_DUMMY_DIV_FLAGS);
+
+	return 0;
+}
+
+static const struct clk_ops clk_dummy_div_ops = {
+	.recalc_rate = clk_dummy_div_recalc_rate,
+	.determine_rate = clk_dummy_div_determine_rate,
+	.set_rate = clk_dummy_div_set_rate,
+};
+
 struct clk_multiple_parent_ctx {
 	struct clk_dummy_context parents_ctx[2];
 	struct clk_hw hw;

-- 
2.51.0


