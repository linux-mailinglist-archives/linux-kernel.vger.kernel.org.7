Return-Path: <linux-kernel+bounces-875422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CDCC18FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646581C81FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE83195EF;
	Wed, 29 Oct 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="RgmAvGzM"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB121FF3B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725496; cv=none; b=I8thqHhI3fxarmdcIoRSoIP+d421ey9FB1GfVNkoSO7O+3hDT9fonlyKovLk9qfCQcBunDNB2ooL2Do9EojxndGCNrMv9mpj9h8RtGbt/oe7MCmW67Vp2JYtBIxy1Wz9+v3teBF7Tzo2RpZ7K+Yb3FHNDHE5jfkKtxKK5v+CQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725496; c=relaxed/simple;
	bh=xJP1n/a3C3nYIbNTN0ASn7af/rI7B9UEFbfidJwADik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M/N222C4ypPNg9ObOv/bwa3q56xptlxIykzd4gvXTZwdkmtIXapL1Fjgulm8+TU3iOlx7PKujInOknsce2os4v9/rhwt+yogqFXMElKkrM1QNZxb4uNKOTdm2V2dZ+h1Ta0510tBKJK1ZSgpcdNUs2dswnstF8U801NgqGxL4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=RgmAvGzM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so6375590a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761725494; x=1762330294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPNxLxt9UFuIm8EyMGboZ19yWXNZhoYOkYVl+88dGJ8=;
        b=RgmAvGzMOccwjoGOZAu1oR9wp3SpZooIJqhUjEXJpo6iz+BfcQP1zQME7rwD6X/UK8
         W1rDLDfD0gDnFcvuTXOpQLttfArWpkZwz0H2yQYxuwBcQKuT5T5SRc2B7clSa67C5IVv
         zbfohogqtckOPMceR4xFEbNw8ZZsCUh9RbQGMk4a/NiYIYpFQN754uYfq3KvuQzTzW90
         /itcT0WB3iYlEPnkU4n83UJtxvqdhcLenZcYJGAbLpuDOn/jFO02hFWcD8DqRQoN4RHR
         L2rEkpAH5BGE8ZTO2Q1EIPttbp4aKfjTTaE7NnCuru8UVDyZhZIAPRMs4/ZItftvtHNb
         HALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725494; x=1762330294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPNxLxt9UFuIm8EyMGboZ19yWXNZhoYOkYVl+88dGJ8=;
        b=fK8tX74azUKkkCo5ib7ixAV+AAN2r2uU4QCN/o9oFb9CFwnTjukM1oSH3FUVeoR5DR
         DoAe/SgBL3icJ5+LhaSV6HZHjM28RIhHbzFNSJGJDmwsV2DrOIhHZk12ohQya0tOkfGN
         VvNA/E+/Ugk/0Sq4tHXwKuO6pgOur+oms6SRCAyiRAUyuuF8cc+Dk+fI10npYtZkMGDS
         RHJd/ES5Ko8j4xh2TjM/JGU5f9TdNOj9c3tO5FC9noQdG73MtTcYERbHLQCB+Qt7n3q3
         kMczFtTet4iAS9OEFCveChf+WNu5O6gzoIqGSa2TVyIQ9tO7PxbQhwiUcfstRW2Sva4z
         yRVA==
X-Gm-Message-State: AOJu0Yw2nwXT3FeMmsmVGUHpd8fcUH+Wgt4CZ9xG0blyegV9rGC5AC8N
	zvECKUwNQJZzqqANDS7aG5LMIVLIH/XwAuoNUFYAgtLlXC+2v8KgYMQZAZqmmdgHKhDWbMEMi+M
	L5tjnpv7t5Q==
X-Gm-Gg: ASbGncuzuyzfbMWH6JKomA0PrCUSZEBC8kns0h6UjeSGPEl8mZLdqvFB9sJosW12J0u
	H6dsNU3F28jRXoSeBFxou5yB1ALdJYrxiQALXetioagXFmrOY53XFiFd9CUJLFB1CIw5oUNioGY
	q+J3TPe+Nr76jd4W/0vHMppvbupPcqoHX3DQKihBgAUxsyoTFxdXmWLQjx+PvO96Q0LsQaUnj4w
	WuQBCla1DmD05Pn8TXfts/d/9h3WbL+1W64/rC+CrlEPX+ppI/T5ndL5M1apeY5XQ0GAHo22mQn
	xdPlR5uOObg/Q4/8xCB4ILbb5d3ZpDOUiGbdpAQcaHAgQ6/xb7mAENDaNuOmYIhRtf/2LIxsLBN
	TSgjnLXagf8J/q/YrYD/KN4xRSDszrrlqhAxtYCY+PsS2xMEVST8qj2HOs+jJRlwaD/yqbhH0Ir
	yqFctu0TBiMcOoc9BfEqH6nVpK6YD2tVqUR3KX4+lzAwJ5sGvZjY4rRYXL0FWpc95NcXCqAY9I8
	qz90qcipmy9w3SrpzTVKYkS
X-Google-Smtp-Source: AGHT+IEMzPuQ84Yst9JnKoJdLmf5H7SKCpoyZzuKbvoGK7sUDl7n6fuflS9kU+3WtdCFpWiOXbuokQ==
X-Received: by 2002:a17:902:e809:b0:290:9332:eebd with SMTP id d9443c01a7336-294dee0e654mr24011855ad.10.1761725494261;
        Wed, 29 Oct 2025 01:11:34 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm143988155ad.49.2025.10.29.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:11:33 -0700 (PDT)
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
	jazhan@google.com
Subject: [PATCH v1 2/2] drm/panel-edp: Modify LQ116M1JW10 panel's bpc to 6
Date: Wed, 29 Oct 2025 16:10:48 +0800
Message-Id: <20251029081048.162374-3-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The link training is failed when bpc value is 8.
It sure seems like the panel simply doesn't like 8bpp,
Changing the bpc to 6 allows link training to succeed.

The 8bpc log shows that link training failed.
6bpc
----
rate_mhz: 1620
valid rates: 30
bit_rate_khz: 2399760, dp_rate_mhz: 1500, ti_sn_bridge_calc_min_dp_rate_idx return: 1

8bpc
----
rate_mhz: 2160
valid rates: 30
bit_rate_khz: 3199680, dp_rate_mhz: 2000, ti_sn_bridge_calc_min_dp_rate_idx return: 2
Link training failed, link is off.
Disable the PLL if we failed.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index da3e8f223ec3..13755168cd75 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2094,7 +2094,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
-	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
+	EDP_PANEL_ENTRY3('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10", 6),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ134Z1"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
 
-- 
2.25.1


