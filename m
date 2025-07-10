Return-Path: <linux-kernel+bounces-726102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31EB00830
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692651899F38
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65F2EFD84;
	Thu, 10 Jul 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da+pZsT5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233882EF2A5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163695; cv=none; b=mcXerPaC8h01UlGw36GcSdvo30aRO3M7XlaYyyELbLIrDUvy2h54cThCFe3mrj/Oj6X7K0eDvF67morq86OFDv72tr/4ydpKENDr9iXJvZoYMujH/VLqDgUO8umW8MOkbgEGUiBPCOq0DCawSbeWmuJZH/hz8axCGisdfQfL2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163695; c=relaxed/simple;
	bh=fKrbnjnqlbXKGKlsruK+qB8Kg9daZJZ+BBb5bsrBbyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXFVRae71NGCK9U++lVYFSJk8584/XpjV6emU615r6B0J7Le3KZdgMq+tk6IMAUuRLSq6KDpigbqcTCjZTFgb8xmTq3p3RTSIbmQFgRbUcDEbH6O8P7kPKt57xYb5V2OklBEuaPDDphMo6Y3WaJ7myUFmdTFvLbufrzssPCAj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da+pZsT5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBVtIjzgSdM7j9vfNKuudokyDuXNQpoH5us+QUAZFLc=;
	b=da+pZsT5Up90WvRye4v/8XdZShLSui2ICXFMSLLzS5MUtm1/75x2dROtlEzQjg9XgVsMsm
	2y8XON5arzXYfhU7OShp/UIykkEKRWpipcg4tDSBRtXJWM476MKQZEZidEQbvMMwNKBySG
	DNjlzNtI99f7CzvzHp9cnfHTq/ezjd8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-_ZCsXBMhMy-qqFVnGGEpvw-1; Thu, 10 Jul 2025 12:08:12 -0400
X-MC-Unique: _ZCsXBMhMy-qqFVnGGEpvw-1
X-Mimecast-MFC-AGG-ID: _ZCsXBMhMy-qqFVnGGEpvw_1752163691
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fd3aeb2825so36441826d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163691; x=1752768491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBVtIjzgSdM7j9vfNKuudokyDuXNQpoH5us+QUAZFLc=;
        b=vDaWJ0OxH69riQSSmPcb1BBn7WMtfciW+sSfS3b/ppItYui0451VcOrzBqs9WsDTRK
         HyxH+9i7clMx4q0YuPcqdIzm7Rvz8VRFvhCC8Rx4E/J/2zq/NRvzOqgLnN8rVdakl3XK
         N1XnexOE5cBCqjBU3uMtRhV9P0tz2/8smRlVdq0tuIe0006/Kw3XVAQ+tq6H4GeSXroY
         /OmYpRCz89FulP/wDr9PyD8EetGH+HYV82gt7ojF9/LvZtFvcQetQulzm83Dly12cOGL
         ojxnpWnus1wPuXM8t2NsH++5mD6grnfmnBf4pVTqKB1iDwKMnnWP8NhThVPBcwtyorjv
         LeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFlUTeBeKbKj2YDR3TxiPGv482XfkfTcXnUwjuDPyrQRp4djK/5G/wg/18K5w/QXBrfpDANsEeVAZeWCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwxrlGqx2cafCPx7Pc3B+hWpJ4aa5mzNZPr1j2qQuDhLZBnz1
	kSBAR205nDE3HYw2FhqMvZi5kaX5CMaigLm09i6IN2luZelmb8JQLyPbkIzdgmJhGHp+xJPX4QW
	5sQOVtXFQeeZa7FHGmPr3gtCXwRwwfduHwoo+3SMMXergEbiKy+rEh7hHySOFEWefAw==
X-Gm-Gg: ASbGnctkJhfcGm3tevfHvGwuYJH15qsEipgrjy6OUSLGa6YLtLv5JpwtnwTH3XKfVdi
	l6uEXo908CbauaPsGj93Y4/yjtXphC+SbzjBKcvBy3swYtHS3b0gR3BDYma4hy3GAi7pVhFOTm9
	prCmf3RJt/qE9EEMaeidmZnHTvs4vj8pBNSG1kl3L8MqWp+0mjxCArGCjukL/Rcq0Ln2syhnQNC
	E6AwKq48Mpe7UYv1Eo0F8FCMQNK0w/W8zQFm+GA/S2Qr7gvoa1SPs1w85K9zbw9r4mGdRBK+nn+
	0iNrKebJJ67+yuRbsT0VO6u4GnhLwAqNGNFYf3ir4hVzjag2/naUVJwdWJcF
X-Received: by 2002:a05:6214:29ee:b0:702:d7e2:88b7 with SMTP id 6a1803df08f44-70494e7190bmr52729296d6.6.1752163691410;
        Thu, 10 Jul 2025 09:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6DKE/B6Jz/oJiRJgLwGjr9+CDT2KUQYMq69PGQL2Cpo9Zo4B0GowYF0QAn7rhBvA9uVWDKQ==
X-Received: by 2002:a05:6214:29ee:b0:702:d7e2:88b7 with SMTP id 6a1803df08f44-70494e7190bmr52728706d6.6.1752163690776;
        Thu, 10 Jul 2025 09:08:10 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:09 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:11 -0400
Subject: [PATCH 1/9] phy: freescale: phy-fsl-samsung-hdmi: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-1-0ff274055e42@redhat.com>
References: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
In-Reply-To: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1978;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=fKrbnjnqlbXKGKlsruK+qB8Kg9daZJZ+BBb5bsrBbyI=;
 b=KjDWEK+2W/Nntn7kgVA1LXI5UW998Hy2QzJ7T12w24jbptJPTQ20Hu1na1UrDrlq2m/ybtKHR
 1nSX6rsyHP1DjtYMF4VJcw2r9wmw7SB7c7PmH5QSepXY2pM+05ltjYv
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 191c282246d96e3f6c5a8d17abe078892882bf44..d010fec15671d33cc363af79e9f1c3f26ecb3464 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -570,17 +570,20 @@ const struct phy_config *fsl_samsung_hdmi_phy_find_settings(struct fsl_samsung_h
 	return fract_div_phy;
 }
 
-static long fsl_samsung_hdmi_phy_clk_round_rate(struct clk_hw *hw,
-						unsigned long rate, unsigned long *parent_rate)
+static int fsl_samsung_hdmi_phy_clk_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
 {
 	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
-	const struct phy_config *target_settings = fsl_samsung_hdmi_phy_find_settings(phy, rate);
+	const struct phy_config *target_settings = fsl_samsung_hdmi_phy_find_settings(phy,
+										      req->rate);
 
 	if (target_settings == NULL)
 		return -EINVAL;
 
 	dev_dbg(phy->dev, "round_rate, closest rate = %u\n", target_settings->pixclk);
-	return target_settings->pixclk;
+	req->rate = target_settings->pixclk;
+
+	return 0;
 }
 
 static int fsl_samsung_hdmi_phy_clk_set_rate(struct clk_hw *hw,
@@ -599,7 +602,7 @@ static int fsl_samsung_hdmi_phy_clk_set_rate(struct clk_hw *hw,
 
 static const struct clk_ops phy_clk_ops = {
 	.recalc_rate = phy_clk_recalc_rate,
-	.round_rate = fsl_samsung_hdmi_phy_clk_round_rate,
+	.determine_rate = fsl_samsung_hdmi_phy_clk_determine_rate,
 	.set_rate = fsl_samsung_hdmi_phy_clk_set_rate,
 };
 

-- 
2.50.0


