Return-Path: <linux-kernel+bounces-875323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB1BC18AED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5053AF013
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D742519CD05;
	Wed, 29 Oct 2025 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx1eLcC7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B22E975A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722606; cv=none; b=XNPiYyDKAutq+J+w8dh0ShkXHP9LIgjbdnev/Z1R9YIZ9qfhOLPVr8haZzJcOHTUnA88kMwsj4vsU59ub3w/9IzJW73iIuEmavZe6wPPIH7keEMJbKILSHt/Xyxc5Qf825OuN9wWoD0z93+p3ruQBCEp4cJT/mDKovNlgE7wpAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722606; c=relaxed/simple;
	bh=dc28hu2rjOtj0l/fFM7XCV5UFXk5eJgGGGyZl91ori8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZhVBH30ORfJ6S1QCpKMI6RSrsT2Eu/iU1VNrupjgCB61C3QKEhBpRnvB5QyhLqQximPmrS+hAAheXthU6qpwhmlp4QMc3TFgvG2/GZjq0STFZVSVKo36/zIE+0XI4IArrfkaboWdilO5z9I4LJDQyF7xGiaICceDVhlp8KiA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx1eLcC7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso5983266b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722604; x=1762327404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7WzjBbcIkMp9vE4EpjCxo/Q8IBE8WxTrpS4XkHUl5o=;
        b=hx1eLcC7V1ma5NG2HYEX07nT9LLUQ7Ah0944PimsrSNirC+9sbO2HpY3xlvBgq+VfT
         UyvMgHJ6mDlSvvGab7fbJh/r+jwHacqJIW3jOhG3de79xoIqP19JdPE7xB9Rr0pQBV3l
         er08ysjn+LBcttIxV6s+nGlOWzScxTGsUnuLlGOOUMfBEP0bvAwVRl/5A7/lUXSA6iS9
         c37b3NMBsC8iaXJ0dDQhKno2xx52giSUQVqAz8FxHfzvNlzhtP7uRRPvv+/IvOKa6HqX
         dCrlYuq1r76QuTMILgDSCD2Qm+dmund4seGHkqxY2zBZ1vdIRNP2gS7hzXw5QKKBsHM4
         EIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722604; x=1762327404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7WzjBbcIkMp9vE4EpjCxo/Q8IBE8WxTrpS4XkHUl5o=;
        b=jYA6kFn5PR6YizY7K4fPWw7ajneUYvfNSyjyJyaE8pV6PMKX4OJVyc85d3Imv0dAB4
         qLCpvOwOcD+aIDdDxSMzQGLNSW0a/31PxWI8Dc6cu8QBQs70zkGI5ac6wc3jNAifnpy2
         +8/hwP55CtBm07ujrk+22HqK/1lZXlnbhfoQT4V6P6JBKC7EW1Nw3UlDDlRAncCscqNv
         Q0ECNF8Dcf3xJNUjtJIwnRTSuJjrh4VhJDfiGEKhM0X2qxoM8ccOjKXtRniQWtwzjOrn
         fGH4o52kwQh6TtWS2kYKpUZ+x3ttyyPg3KPrk7cwG5td6FFxPEu8CxoGsrKtGVpsdHSQ
         vdWw==
X-Forwarded-Encrypted: i=1; AJvYcCWFEykMkY3QGv6uLOjV0rcOVhsIoPleIJEw9kf+76GSRs01TTZEf6RikJKM4UZRS3rz5ANr/IfMF1ms7zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+LVKZbRHiJOni0ztW6Rkedf2iXbEaQHP31KIV/bGBz0xJx3D
	6Erru2/1rD+HbynOZusgvoXB0Q8tMuzPgqI2trEn1MOn5YqnccHqtvtv
X-Gm-Gg: ASbGnctcNe5zlzMrxX5MN0V2XDjhiOFUBE1X/6cUIeZpDEkyPXCRYCEcFWYD2TnfhAd
	jE2gMeHY5yiRfYRpjaDEhJd6zBKEHVOVstIxv2mQyX7+AugfdaMbn3FIpdhQk6lME8HDQQosIAE
	yqLmOV6vUNE/n0XqDJ+eqP8MPDrTUv0WT2O+Dx/4VaQPtATufnd0FiSUMmAE+AfrEuGe+TvjaoM
	y/UIPnzCf//mrAq7/rDlg8g+Tf9hpX4bWw42BgVtW9uPU2OK6f2aP36EoGEB/HXKivqRF53G93I
	aPaNtN0SmvLcJCgX2zBfJ3rqzFrwbhzdpJIqnMhCPaaTQY1MP7r6jLy5w4oAK/5Yhb+OxCfjY7L
	YYGqenS5owKHmZbqd5YmJAqkDdKD82jWgAGCve/jfuX0EpauM3Ex3oiPmZX/u8Kg+yC4346fCaW
	iIYhj3j4BRzBDyOOGWDkIvwg==
X-Google-Smtp-Source: AGHT+IFyoTqxEaHdHcYwG2j5PoXFVoRtIyJkYmXJKSPfYslsy5ZMiSdta/UGyBhYN4fJfCWD+fCbVA==
X-Received: by 2002:a05:6300:218c:b0:341:6c8a:5218 with SMTP id adf61e73a8af0-34655401460mr2197446637.56.1761722603774;
        Wed, 29 Oct 2025 00:23:23 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm13021005a12.5.2025.10.29.00.23.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:23:23 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	CK Hu <ck.hu@mediatek.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: Fix device node reference leak in mtk_dp_dt_parse()
Date: Wed, 29 Oct 2025 15:23:06 +0800
Message-Id: <20251029072307.10955-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function mtk_dp_dt_parse() calls of_graph_get_endpoint_by_regs()
to get the endpoint device node, but fails to call of_node_put() to release
the reference when the function returns. This results in a device node
reference leak.

Fix this by adding the missing of_node_put() call before returning from
the function.

Found via static analysis and code review.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index bef6eeb30d3e..b0b1e158600f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2087,6 +2087,7 @@ static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 	endpoint = of_graph_get_endpoint_by_regs(pdev->dev.of_node, 1, -1);
 	len = of_property_count_elems_of_size(endpoint,
 					      "data-lanes", sizeof(u32));
+	of_node_put(endpoint);
 	if (len < 0 || len > 4 || len == 3) {
 		dev_err(dev, "invalid data lane size: %d\n", len);
 		return -EINVAL;
-- 
2.39.5 (Apple Git-154)


