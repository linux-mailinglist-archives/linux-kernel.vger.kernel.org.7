Return-Path: <linux-kernel+bounces-765064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA52B22ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9F87ACCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4872F5321;
	Tue, 12 Aug 2025 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvnQTDYA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB12F5305
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009664; cv=none; b=NJzo/LdkflUtubanvd6A9ojPtRlB0cvZ769+bS+I9snTiSwVYoAKxy55Spx3pdAQhIUPvXFS/ItSaErTWaQCWSi84zeIAChIeqgQw25jY77sxvyiCWgvvCG1ZNPUrditWsXGPHaAzYxU6WuTP77YmFwL6lFCHNd47NL4/bytqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009664; c=relaxed/simple;
	bh=sXw8h0lALjsD5VKwkwWy/O2FfwzxhOoSuFOjrsFYzhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLiqU6H9HB+SsCQlWRcAcYQ2w8Rm86avxcKJ72qKcWxlvLYzq3OuVgPdbbQjpMirM7FzhVlczp7ayn1068zmANTx6XBkurFZfLjaPgDuiC3+utTO6XpMp2kR4sIpxutgOi2zgQhjbjLT0qgN9t6LSZHMopaFffxdMf+1bKXl29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvnQTDYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1Rzrz4pTd6XDm1us2+sKdj8djgo5S2Rno1TtobaTIk=;
	b=YvnQTDYAiG6GKZETtpe0AXfr2bLyntg0IsJTDPp0XL/0s0A53Sq1zDTeJ4RoEX4JN6zOvA
	NSSCrwKKepk0TgrXdQzv+rKTUfVgb99RzCGOVe4/ddVTVI3jEF78EBfGOFfCkCxwRcdg/x
	rsSyd1WkKZ6QEuCgiHbymj5wzdhnNhk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-f2_zrTvwOXqauvWDeDUtZw-1; Tue, 12 Aug 2025 10:41:00 -0400
X-MC-Unique: f2_zrTvwOXqauvWDeDUtZw-1
X-Mimecast-MFC-AGG-ID: f2_zrTvwOXqauvWDeDUtZw_1755009660
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b081b2a94cso183602241cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009659; x=1755614459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Rzrz4pTd6XDm1us2+sKdj8djgo5S2Rno1TtobaTIk=;
        b=B1DjC8vmSApOHCl2aw5D5ssOPBOyzPJLpRoEdb02yFkFmidiPfaMG2oi3D4Mbp5PB/
         0X71ehG0lbDwnKYOu3CNdYSEL06xkotF5rs3GR+OId2vAIHOfu+g9KIdnix19eY8X+pY
         kmTBnHnOGIPut/ObmF05i1OwcgHYWqhLGPzk2YT7OvB9Ony25LPEcuYnaxZx2AmgK4Nd
         elLqXnM65zhomJ1h3MVUnGWmtPD9SvgLIcjaEjew4kQu14SfegPNEdkiPSnwFKa858Zu
         +ftC7Mw0QgFDT1KIud4bz0osa/I0ZD7gAWkbrkGKQzVXvitvgzgd7SIPlSu4kyRhu4Ft
         IGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXlSiYdiRkb97UjHjEG/MZZ7BR8dDAP2p2QEUKRAIPahgHae/AXMjt3dnRazWzdD5VG0SxIFVND28iaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoN0SBuhTBgiyihhvBgn1/Py9AvibO5EoSTVmMV/Gem15bLae
	n2rfARwBkTAuAbVL31U8hheDgv3/3pLhAlmb2tkq2+2suApN3bIXEdDE4q/bVXdAg6Pi0M4PaZ/
	q3mDoFBOhBgY3kKsTIVrhAPupctEF+2akNMsg22hzw9ck+Y1a+aIuaQsvqu/QAWrf3/cBG7uRUz
	8XNmpP+eIh+1nNSaHWd8qrHATpnfr9quo6DCeZm0NMn6ZvHxdyfdk=
X-Gm-Gg: ASbGncv9HXRuuAuuDDPnttKgdEik3ohYF314C0NYyl5rU/fvYrdkluuYi6c750dZLEy
	NmwcLlH47cWn6bbmRoqsYlycjqbHMiRRrZvbPe7JAZ+h8S3tQZUc3U0gGEN42w4SCQ18ZCwDdKQ
	pnMowiT+G+Hxyk+VUIvUKNYa5p13XQNB5EL+HtaseN+smdhzr+NMnop9PocejyBn5TivkSiDN0p
	j/NDl8HD7evFoni0JHupv98KkONY/dzKi0MdKgpfENKgzqPWmlEFpVRqdgT/Jf8hOpV2ibOxbfF
	VLVvaLspoy5uH5+RjRFRaXtt/Cm44y48rWZMxdysPlG2G18wqNZ2hbWVRx8Fl04FywZIAi+n+wV
	9GA==
X-Received: by 2002:ac8:5a50:0:b0:4b0:658e:bd88 with SMTP id d75a77b69052e-4b0ecba2f11mr64091431cf.7.1755009659267;
        Tue, 12 Aug 2025 07:40:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFyDPYRrKn9oCmhsWvHECMNxAjJDrMvLAlZG03rhl03ybjGnMZl+gPzAxGBHO4A/Oa0MKNJw==
X-Received: by 2002:ac8:5a50:0:b0:4b0:658e:bd88 with SMTP id d75a77b69052e-4b0ecba2f11mr64090861cf.7.1755009658805;
        Tue, 12 Aug 2025 07:40:58 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:40:56 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 12 Aug 2025 10:40:33 -0400
Subject: [PATCH v3 3/9] clk: test: introduce clk_dummy_div for a mock
 divider
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-tests-docs-v3-3-054aed58dcd3@redhat.com>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=1985;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=sXw8h0lALjsD5VKwkwWy/O2FfwzxhOoSuFOjrsFYzhQ=;
 b=gACoo/bgoeAjMP5T4HlHRzvTtPX3bFCCeOj+ESgvfN4r2olnMmu6i0I/No579AFXVqJEsZ8jj
 ULumme+QsH6Dn0S/m70MzjIRjTxzoowfL91FY3Dq6nHPbvp1GgpPOtJ
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This is used to mock up a divider in the clk kunit tests.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index fafa736ca32144a2feae75a8d641abca3162d42d..61668fcd7203c4cef9f22b8c0c5bb5a50d331f53 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -137,6 +137,48 @@ static const struct clk_ops clk_dummy_single_parent_ops = {
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
+static long clk_dummy_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	return divider_round_rate(hw, rate, parent_rate, NULL,
+				  CLK_DUMMY_DIV_WIDTH, CLK_DUMMY_DIV_FLAGS);
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
+	.round_rate = clk_dummy_div_round_rate,
+	.set_rate = clk_dummy_div_set_rate,
+};
+
 struct clk_multiple_parent_ctx {
 	struct clk_dummy_context parents_ctx[2];
 	struct clk_hw hw;

-- 
2.50.1


