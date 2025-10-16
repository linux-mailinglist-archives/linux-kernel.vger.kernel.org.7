Return-Path: <linux-kernel+bounces-856578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0C0BE4890
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3535621AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C9E32D7F7;
	Thu, 16 Oct 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuvOvNYd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCE32AABB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631415; cv=none; b=bCy5ecGejC+dSBVFAUgAvo5IOHL/nIdZLxAM++quHJ1j6Zhw5g08tfGVGy8O7tprHQaA7Su/iw9al9YfclrPR4AHXxDgNw8t+cRVclH02Eu9adMU1IF1uxBKTBHHTQkMEJ8vX3PmbFjoWz/OYhAZ9Wne2rtizTu2LuZi09D48Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631415; c=relaxed/simple;
	bh=I1J3S6x5LiLW/zyWZ87aQm6praqo1qBzZH7S+vE3aU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqYDLpcc7k3gYSSXgdwvHqWSait3E2L/YaItBy7m01DYHcilZKovxxpI7HPLIJ/5UIDB9meWEEBddcDaHiwo9OkUyeId7e6H9yxTAay/SW5SUeit/+YjMszpudwVZQ6BB+OzOtRXf5sgiZ6rIVNqlTvQKb77mxbTLjBSWL6YO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuvOvNYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36wLOxtnUtAVE2o+a4sL0tiiKKSB5B5mwGz4ZRb7cv4=;
	b=RuvOvNYdTLnqYqmoyGKNVVavvbI7TktPkLgKK4s6viBjFXRFGANi58X/Cxd35agsvOX1Lk
	rLTYWO1mJyqym5V2Y1TJf16MXfyrvkrua18PXLoLIACK88wLWuWDsOaufXqBqEEJ+3qiEF
	4eFYy0CkG0WEqRDT1LFYGAXNJEVc4PA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-rdkUf9u9NCK57jdcZGAkyA-1; Thu, 16 Oct 2025 12:16:51 -0400
X-MC-Unique: rdkUf9u9NCK57jdcZGAkyA-1
X-Mimecast-MFC-AGG-ID: rdkUf9u9NCK57jdcZGAkyA_1760631411
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1558a74aso40074986d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631411; x=1761236211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36wLOxtnUtAVE2o+a4sL0tiiKKSB5B5mwGz4ZRb7cv4=;
        b=qVnijQGLi0YuPcuKR377oNrXZiBQxpR0CPkqGDm/SVttgWLD1LyhIcSfJ2y843oVxl
         aqUBbseNc6A+a0z6Pne72NETmvbzyQaCNH0tNSanSGWGArYlvM1vwPRPO7HBb4m3Amtc
         uNkMQxTnNUxiE/hR7O6PNt6lv9WrWxX9fr5BOV9oI/5CFTdatv8SRt/4YlHjZOLe9ack
         jgvfl/cFvU19v8McYNedj9WiWyZYAuTDP94q1Qb//lLE8Rq9PLTlEnfFkty4QukDBJA3
         gJOZKAVM1MnqNRHyriuXEf7yZn3TDFrtHCa+7zc+7zYSET3Fi5uxsi9DxxtagNoTsbaA
         fTPg==
X-Forwarded-Encrypted: i=1; AJvYcCVwQnPp7UQUAOYql+I/p2wQUYU9cI/3FXvpargWYLVyL/cbccAMjTgyGudnp93E+g7AHK3ZkHnwf/Vuyhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PAt5tFVX9h/u1QRYiIYX7jacy50HknMBkhSErbcGo/OId7rW
	dp4do3ZQcoT4N7wCe1RRhi9gbYaYNxb1xY5pZpiltbkPi5E7JzZo88eCzgH2CYiSyqvc5qeBzJt
	xDPQbSu9w04H6vJKAltpJQSJVG5QiooaQ0rPauCxhk6A1nr+Mx19HijV30NeuiBLxKw==
X-Gm-Gg: ASbGnctVBa+CCbrHdzfqofr6LYiDLW7eIkjGt3yMqqIANhvOfPE10SV1HDWNgsbludx
	0C2ZcSafCLnRfn7EGsJg9AKt3PEoo17U/VFKZeM1NuYfI1fQAklrbvXzxZBzsMRQTXxvrsJJdYF
	qicmOi4oFVFeW6KjtSsfKYv3z05puukkfrTI0/yRXuJYOgHQT+mEb4bjr/pbiJn/QvsP4fq6++g
	rm6cvl5VhoT2XdL4FzMA80OagncY5ifrC1Uq3v4n1qSysXUWAdtgmu2oR0r8d9iLJZxxG/QxpTO
	RTmISZa+1kaZ8xJTmGyNU3hVnobPUr13ylIhP3fWt2VnB4fOktUB5E4L2spTyL+CF/nsSD6aQvI
	iUDBd5Q4T4UCWal2/3LplYfgeaYgUsl6SP/FatZEKV6BfU6lpSUZAQvoNCCqygV41yQF1JA==
X-Received: by 2002:ad4:576e:0:b0:812:dc64:e8fb with SMTP id 6a1803df08f44-87c2055e0f1mr11220696d6.3.1760631411255;
        Thu, 16 Oct 2025 09:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2H4hqxbPAz78vUyuVxepWRoN/7lFlbe1nAViv5z5DCNPAXcja8zNCahwq2KBdmRw44i1b6w==
X-Received: by 2002:ad4:576e:0:b0:812:dc64:e8fb with SMTP id 6a1803df08f44-87c2055e0f1mr11220206d6.3.1760631410751;
        Thu, 16 Oct 2025 09:16:50 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0128c9d8sm44068466d6.33.2025.10.16.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:16:48 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 16 Oct 2025 12:16:29 -0400
Subject: [PATCH RESEND 4/4] media: platform: ti: omap3isp: isp: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-media-clk-round-rate-resend-v1-4-446c522fdaaf@redhat.com>
References: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
In-Reply-To: <20251016-media-clk-round-rate-resend-v1-0-446c522fdaaf@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=I1J3S6x5LiLW/zyWZ87aQm6praqo1qBzZH7S+vE3aU8=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDI+SqWZf/X6Vm73eU9DzfVsPYnraWE1XSySZzb8F5xoY
 rktkXlnRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABMxs2Zk6I1g+qq60NS5suG8
 wfeKlfo1s4O9T//Tc5+zKK/wF/9+S0aGTQqnuNcodYtsesUwpWW2WUbR1Kc/bltnPZ093TDF/XU
 6FwA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

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
2.51.0


