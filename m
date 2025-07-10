Return-Path: <linux-kernel+bounces-726106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063BB00832
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BFB488528
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC752F004D;
	Thu, 10 Jul 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au7AW1rk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E772F0048
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163703; cv=none; b=PeEedc6uEV2v4KCccWzwhE47b7WKjggu5hST/J7w8dvxJhdMSguMNx5oZH6zD6Ugle4wrJAcdiLtFt3o/ElfyEMuTutiTaC2HDmYA/hpTVF5cOuErHfWVw/Wey1l8QweVvhvFQHK5jqErZcpL0M+9QVvYhuwND1fIguqEG1PDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163703; c=relaxed/simple;
	bh=DwS1eyPB/neaQufQvNJoTsoU5XhXKJIB7F14A2pZwIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTdojb0d9dTYAVPSnM6QKNjpR/8FCp9PqYMYQMvty9VJ00A0eVM+4ASquGyxhDCpFVqxkfZ13C0LNBPnojjNU/xU93KGf9Ix3MoIU46gvaZ52IGcK/VaCULkjFDYmn40srldtNVMgygFKatPsQmW7b+LI/u+0BF4n2NpJBKfKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=au7AW1rk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4I0PFIaMBaCPYEhsVGTxsNMaZSF2zv8K67vNW2wzfuw=;
	b=au7AW1rkUNG7VYbBZzDv+/zHuPheSmsvojPwptr2bBl7uclV4AQDIIZz1yPD3BlYlhHaae
	d8Jwi5fxW89u1mmji7JiCxK/8fTN7/P3HUkptJg/bp1Nk0y2O0tC4Qq7HygycatkBxAo75
	cim/DZ1Z7agyUQvbAb3qcqKzgRFf/2s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-479nqEUDOSyfFt5HuCiTLQ-1; Thu, 10 Jul 2025 12:08:19 -0400
X-MC-Unique: 479nqEUDOSyfFt5HuCiTLQ-1
X-Mimecast-MFC-AGG-ID: 479nqEUDOSyfFt5HuCiTLQ_1752163699
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ff81086f57so13527036d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163699; x=1752768499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I0PFIaMBaCPYEhsVGTxsNMaZSF2zv8K67vNW2wzfuw=;
        b=H7MDk0FnagyacqQLxa6xPLEoqtHFwUI3v0+19gTgbZ1TSxcPPN9inCjpivWJNssvjs
         EYaFdeitOpCi9T7KVVtjuWkb2OytFbj4zfIERNnp5T7PK5I9CcKe2C2Fpv7R/+PAmnRN
         JHwoYS2MwMD904Es2Z80GE/azELS+nKPq/VgXanILnsdiqHcGKDB3cM6/Z0t+dMk1unJ
         LD51fm4xyAj3KTEycw6WXGpNJSKCgbdFRWeoOcTNQo/Gz3eDKk922cVv6edFVHlgOzpv
         wuFZ0Snvq+IPlq5Yl1EPgx41PqK0kvjjv60epZawYlF+c+C4nlFjC6ahWG7K46ZD04px
         GcMg==
X-Forwarded-Encrypted: i=1; AJvYcCVxvJ3b4aUN0TAmNnWj60W3Qr98p4A30siADXr0aEYjwZubLTJFfnD3E8n1OLahhbF4pm0MPAb3UFMyvIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFgXD6bzVbi1kyiBpgGOQ1e/eZ1QuVzEaTVF+tJvpwy/Hc1ETY
	+ojAFhtwOZvXYq2yo9XUuLAEwb5SDnfX7SOek08kONtUjVA9OYkyQ/eNq1spPNEBRdrGQ55mDZu
	jWDjnfXWf54uSlj0MT0SECRokgtCMgXaTC1SY0c8Cvw5oAFuoPl0D1sAe5KUB3jpSVA==
X-Gm-Gg: ASbGncs7eenKtj2558zxNR1eMFvr2DmLpMkW5NsPGuWJq/XMPD0mqON2NYID5p46Cun
	+1QOx/Q11K3TwG97oy2yvkIwOoVleTS90+lsPgbCbrR137rivtavoOYTvFUWW7DtWtw0fkLCRWq
	pJFZzBr7TEQLPjF8KQpIBXKRrM/Hg88sHV6HBGaFRrZjyZW/GzmW+eY0Cy9TWAck40e52vzfJLA
	gC0Q6mTARrSskOlNCLyIpXqn3CQ0pIXB9utVdERjzhNJ6O7O9tweZHMj8r6i0GmJgjFfUJa8fop
	QMD9qiEusjBsobXhn1bvHQ+pW5arCzI9eCtmHU3eVfrXmuE3hPvmzFwa6GWz
X-Received: by 2002:a05:6214:4a84:b0:704:8aaa:319b with SMTP id 6a1803df08f44-70497fab6f5mr54886776d6.7.1752163698890;
        Thu, 10 Jul 2025 09:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPjEiUWwXCCHctPequGjvxsmcP2oTYR8PP+05MEZihcEYQLxAz0y6yXBwiYJgaIGBkfIQAEQ==
X-Received: by 2002:a05:6214:4a84:b0:704:8aaa:319b with SMTP id 6a1803df08f44-70497fab6f5mr54885916d6.7.1752163698330;
        Thu, 10 Jul 2025 09:08:18 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:17 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:14 -0400
Subject: [PATCH 4/9] phy: mediatek: phy-mtk-hdmi-mt8195: convert from
 round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-4-0ff274055e42@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1601;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=DwS1eyPB/neaQufQvNJoTsoU5XhXKJIB7F14A2pZwIo=;
 b=4cPcXNvbK3LJUngty9/hS4Cci5iNskdrVCzBboRgMF/vVZq4JO3qCRcMs3ZcshnLpFzqFvn2A
 ZJ4lm2QjCh4CBdhbHz6OimHjO2IugpTJTJVBSFGBISv7EeMJ0RGydsb
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index b38f3ae26b3f3d8c9e73b43d86510acf6cedb471..1426a2db984d53b91125b18f7725738c44f19555 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -418,13 +418,13 @@ static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return mtk_hdmi_pll_calc(hdmi_phy, hw, rate, parent_rate);
 }
 
-static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 
-	hdmi_phy->pll_rate = rate;
-	return rate;
+	hdmi_phy->pll_rate = req->rate;
+	return 0;
 }
 
 static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
@@ -439,7 +439,7 @@ static const struct clk_ops mtk_hdmi_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
-	.round_rate = mtk_hdmi_pll_round_rate,
+	.determine_rate = mtk_hdmi_pll_determine_rate,
 	.recalc_rate = mtk_hdmi_pll_recalc_rate,
 };
 

-- 
2.50.0


