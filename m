Return-Path: <linux-kernel+bounces-829140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0CB9661E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D53481FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8A2E2DDC;
	Tue, 23 Sep 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaF63Ecm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC42E2286
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638410; cv=none; b=WwpFgAHJSgu3CwnS4NDCY9r68hcyrPjym8T69Yv80HIn5K4lHhaDvOjjyp9z7BbWJAUntg8hJkStXL/dOqEJVsEZPGKxCZMUBbZ/rgSHXuQNVYqh+cl1qW3o2ey+vf+HZmSIiB/Y5dI22dPNdR0yDyy1aOY85SuF5lE34VuAAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638410; c=relaxed/simple;
	bh=pFcsx99BIvhSJs9EZjHposR2YHdvSFZidHEyknZiq+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkUjT5YiRbwKqhSCXglPq2q64W2ehq6wE9So3IuAM3r0S+4g8ecSBU5hzAVA0ha2pogIQLYYysJbV9ecSCriOGZFBvo23BmNUEXf5iosq8Tcklp5CXfNMRMZrWPqZtiLZ1eH79UZDlvDn9NT5DDTtOVI+9vIIBfnGwyyfZ/eKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaF63Ecm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9GRgIWzFYj7dDBWP7AZSAac6SnS5DXh5UVkU8dbhRY=;
	b=EaF63Ecm5mcWFDOvt5aUyaXBWWFXxTnFm3J5G597UKlNy64JWIf75XUzt/E1EFEb7v2zFk
	R08cWChZ3RJxtMw7FDGcGphBkK/Ui0IoLUexaTyRpiJnLFBWaRleBl56L4wGzOMpGBNeqj
	8Um9jlsW/IL1voxF1BGo1NUQ1nWZAm8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-MCuku5MaO5Wgb78sdDMXXA-1; Tue, 23 Sep 2025 10:40:04 -0400
X-MC-Unique: MCuku5MaO5Wgb78sdDMXXA-1
X-Mimecast-MFC-AGG-ID: MCuku5MaO5Wgb78sdDMXXA_1758638404
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-816a52d9a6bso690548385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638404; x=1759243204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9GRgIWzFYj7dDBWP7AZSAac6SnS5DXh5UVkU8dbhRY=;
        b=mPWASOG8f9t9S86ZAoCEr95SQafYCCbAoN8G/t0klDzKR5QoIc8zmlQTlueMAMAYVV
         MyxWmbBaRTEFaY22xiacicEthCGljFKV8BRViS+4oa7dXwUHJZSonzg0TRHG1i03x+eZ
         R8nnhn73tj4C9ej79Hr4LkVEry9/ww4Aef3LNxX8PJRxQ7eaj7UbbKTrLhQt5xGJdsoP
         CNht0zGTtHU1/1BVECebujwND/B3ZheN14v12ivkAdQ8COrSY8PzSBgC6PXHVypZQ2m9
         mOuoPU0JEGRallaAw/Wt/pIAiE7B77Evu3roaJ26qUHVLwp1O0PzxGJCTNNAdtBL/Qdj
         pwCw==
X-Forwarded-Encrypted: i=1; AJvYcCWHZKXWqYnDJxBzWNXLoSA+QMpeeuK4wPWApQxqkSDkMCvlM3+JOy6uIOlu6SP+eKnPh91dWZqmBEGEhyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQ7JII2G5jmnqJ03uquZslV1w/9bUMP88BCnYced3D49oRoEW
	9Xkw18B97IKT2C1wJhcOyV9K9GQaiGC2qlSAvXLWvLTZ2h0BrQS8kskmW43DoL+8O5YBAFFdJtX
	4dwXSwXNHCCY40ICUjjgbZ9iJOnnBFHuhXQtHb505YbqJRuDhRjZ8KztFiLsH8WtBAA==
X-Gm-Gg: ASbGncsNLeGYcahy0W++rmIoipYxxOwy0wFo9AKUen0DWxZ9i9fEeHNlK38kudVuVc7
	QY0PbSxfBq9bm0iuQsUbb0DqwbiWsJ6TkpiXMuKTCBEevjgmH3Oq1DehnQXahi4R3NjsoW3CLzC
	lsxbanqzBEtsqC7N9I28x4hvXfefm2T+W1qr+RrIqnkwLpj0i1yI/VRw1y+1+G837PduqEy5e+6
	XqNRVJh4+/MObmlpLbZrWLasRTi0gENaYyucJiM0cPomKpHAdQPGv/dyMMlFa8/X4eShXl4Mu6u
	imstmmK4QNOZLVldffi+e+4pHO0EpYPwA4CO5Geayxo5M410AW1xfUDlpW5RTSHySPe/YIpELhX
	hMlUi7IYZm1YWatYLgvDEjtuAj8G/d12cQokfccU=
X-Received: by 2002:a05:620a:2893:b0:849:a372:24dd with SMTP id af79cd13be357-851724be79cmr315043085a.58.1758638404294;
        Tue, 23 Sep 2025 07:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB1IVa4PYBoaIhw9LnlRHxc9bCRkENFx/qDelC+j1q0D87GHSENwmL4JOuTI63o0roDkoNIA==
X-Received: by 2002:a05:620a:2893:b0:849:a372:24dd with SMTP id af79cd13be357-851724be79cmr315038985a.58.1758638403658;
        Tue, 23 Sep 2025 07:40:03 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:40:02 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:24 -0400
Subject: [PATCH RFC v4 05/12] clk: test: introduce clk_dummy_gate for a
 mock gate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-5-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=pFcsx99BIvhSJs9EZjHposR2YHdvSFZidHEyknZiq+Y=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubdRX8HNayV7rWPh6F3dtv+xR1zDb26FZK3vvbOiy5
 ouTnGjRUcrCIMbFICumyLIk16ggInWV7b07miwwc1iZQIYwcHEKwEQ0vzIyTIn91u717/Zus7S2
 9FulzUv5fcQYC75fvT1beMV/32UFGYwMT80s0+27gvmuVftwXFXeGnz7dO2XbI8p/hqTtpfO31T
 PAAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

This is used to mock up a gate in the clk kunit tests.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 1aca266f9922beb7d81124c07d21b2a3d700dc5c..e798ee0591b5db6a7728eda20dcab167245a9834 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -181,6 +181,40 @@ static const struct clk_ops clk_dummy_div_ops = {
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
2.51.0


