Return-Path: <linux-kernel+bounces-726241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 193B0B009F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A2D7B86E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6122F1FE1;
	Thu, 10 Jul 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC6WmB+/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3E2F19A2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168578; cv=none; b=uW+TQdEmamKwzBiGQVcoKMpQjdfMS+F8xMVPLxpSZpe0IV6hWDwIpPzNX2rEpiq6k7+ZWl9p8qM01dC2tOwcGA7Oxs4vl8OPJ+5an9rk9Alr8G4hx+wmSSTlwgUK3aEdtc+4pacIVdRa231ILlWwBYJ1o317/YoZXLFWUxwwG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168578; c=relaxed/simple;
	bh=JZJ1+WJ/h3efuGneP0YgJygZeG2phhVYgmqVgPTnIt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmmYVEts+KVtICpckpGJfiUZ5QTP0CeYlKb9LS2vPcLoJtWCgpM6X4koTVYYU4Qr80c+iLU2K2g+V8Eqsk+ts+bj/S5JMqIj2j5zWLRE0+hgb1FsyFtaXDtBlM+bgnIlgrg0Rp/+5OWRBRunnXPtr6k0UUAIf5K+t70NH2hTf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WC6WmB+/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752168575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe7AYsdrV/kF5/kI8EQ2lMYSEAkXKU5aMhqdhL269CA=;
	b=WC6WmB+/FAAl8EnkOUuRYih+5ltE4eid3FSfvcF21R1UB1DbFEIL2n/sUqQ1rTsEvRfZP4
	28ppQD7/AzpSN7fZFTpmwIbLi/wMXI23Ftm+dXE09kmkA8zGU1AZl/B0xNa/nZwGz0P8st
	WpftOP5Oj7UXCtdxTYEaz37/6CmJHvY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-cnZu7R0JN1GHUxfXMB4PGQ-1; Thu, 10 Jul 2025 13:29:33 -0400
X-MC-Unique: cnZu7R0JN1GHUxfXMB4PGQ-1
X-Mimecast-MFC-AGG-ID: cnZu7R0JN1GHUxfXMB4PGQ_1752168573
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c790dc38b4so236813885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168573; x=1752773373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe7AYsdrV/kF5/kI8EQ2lMYSEAkXKU5aMhqdhL269CA=;
        b=DexVLCNqH/QMldUn2uwas7Ec73oN9szgJkBssZLV6n++4MnJacpWrac2xGNLbh13M4
         who/GzeGj9YAWAyMVg/kodDsNvPOgaa9QDrLCu5ktTlvVPwd9pS4RJd7EQs7smmf4NA8
         zB6xfasUVn0G13LyKOs2ehCc06WIlMH+3PU1tQE+rtcYxx/Y9ZJAmcDO43AjlU7fTRuB
         +ik/rrLnRxvyGClfLwRAn/rMT26sWiSB++oW65ApyCJhzeHxdAQFxW1zhdEmZq0KLvuM
         TW8xLnkmtIBTflHBdBD0Z46IS2hDg4scDlUhqCzaGm3D5D/aHGKmP9f/8yZSqx+e1LkW
         0dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/F2srWRuZQQWS4dHW+VY+RRvsskVt3rV3UQ2w+MBQVC2g0A6FQHDjZRpoHHBmFaAlieUkiZsZvFhqzjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kE7A07yK54Tp3C1Jg0QcPpwrkPoPqK3oTE2wKopFaeDuKjnE
	gMbkqEZVm+fW9nlPkcbKObO1j+Llgre/I0CYcTWMj2g5rIHeCK2fraC+GAvJ5+lRnN0kOqh1yv6
	FAp7LgJH6JFJv/qvrZssL39dfabSN6bKd8hy6y5X6Q48+udHCO20cWS3KQu95Lro//g==
X-Gm-Gg: ASbGncuoAiGWXOYaunOgeLlnx114rTgUZUq07ZA5Vb//l0dVQVnTCExoRjd+F/Fkv+7
	YsvEmGC2uz99kvPt2SOOXiUZdWyJCcMaqFxjqxZrC/R+SX4osKsjic3gUzqPLKTsHUfE0OtWAFs
	A6QU8cuou5rfCwQb86BYTSNluq/kFH0T/wlPPdNl11ruS/VAwzi6OU70y8lu+96v7NWBeqfI5D0
	38ORZQSLtlyVBF8+O/CK1rtJfXCT/z+oqZ6zVSZPvObnihz5+smYQdsxMDivbA7ORZ6zcvmff7v
	0TihM/CGXDG+zOWAIvIzTV08ZibeGqST6PN55k6DxciUu1aVyeBhoQNXrHyX
X-Received: by 2002:a05:620a:d86:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7dc99b9fb23mr599761185a.24.1752168572944;
        Thu, 10 Jul 2025 10:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhRh9pfM/NitNwmW4n5qnDy+EKx3DFE0OvpWeLo2yStURg5EFVw7RwMJth9qEJz3UaelbN5g==
X-Received: by 2002:a05:620a:d86:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7dc99b9fb23mr599756485a.24.1752168572453;
        Thu, 10 Jul 2025 10:29:32 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde806297sm117728785a.82.2025.07.10.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:29:30 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:29:09 -0400
Subject: [PATCH 4/4] media: platform: ti: omap3isp: isp: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-media-clk-round-rate-v1-4-a9617b061741@redhat.com>
References: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
In-Reply-To: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752168561; l=1494;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=JZJ1+WJ/h3efuGneP0YgJygZeG2phhVYgmqVgPTnIt8=;
 b=IyVbdUFtcuct3Se/7hbBiD4hUtLpQsL7G6BJmAUM3J6DE+u8YyGb5VRphLQ8BCsaYSemq5qGd
 lLPMEca2SwAD8r0Y8bX6CpLtJ7cKtgGRRz1mRHT2x9a4Z7brFi7V1+5
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/media/platform/ti/omap3isp/isp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index f51cf6119e978a3a33939bd83c2e676a43ca2c6d..8ac2bdcdf87b1fa0ad1b064cbeb7f1e7519973fd 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -240,11 +240,11 @@ static u32 isp_xclk_calc_divider(unsigned long *rate, unsigned long parent_rate)
 	return divider;
 }
 
-static long isp_xclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *parent_rate)
+static int isp_xclk_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
 {
-	isp_xclk_calc_divider(&rate, *parent_rate);
-	return rate;
+	isp_xclk_calc_divider(&req->rate, req->best_parent_rate);
+	return 0;
 }
 
 static int isp_xclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -275,7 +275,7 @@ static const struct clk_ops isp_xclk_ops = {
 	.enable = isp_xclk_enable,
 	.disable = isp_xclk_disable,
 	.recalc_rate = isp_xclk_recalc_rate,
-	.round_rate = isp_xclk_round_rate,
+	.determine_rate = isp_xclk_determine_rate,
 	.set_rate = isp_xclk_set_rate,
 };
 

-- 
2.50.0


