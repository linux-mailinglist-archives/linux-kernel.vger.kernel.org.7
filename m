Return-Path: <linux-kernel+bounces-835849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B4BA8314
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 985394E14ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3AF2BF00A;
	Mon, 29 Sep 2025 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYIpQ+/q"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CAE2C236D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128661; cv=none; b=FkubyixUWmQBluTDHe7XGlhKxO14nxrvPCDYWeJ+Bbz+473eilOrxO69hCL2F5iWX3JzdXjOKSDbq2fqk/ryVsSL9/O/FcXMloE6fdeRhwk3Rq+BjxTNGH5k8qfIUagao9HtVsXnvqU+dljLkBJoi2y2yaTbIXok4ckrKd3HI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128661; c=relaxed/simple;
	bh=hlBg88LfZ7H7EOnBcqiE2fUhnBsLoaYZcovb0B3orxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djtfYdaifPr97fSNjeJmZH0/NFDeMJrc8uv0Kn9tk1K8Sw0+gNjoY5IZdWg1WticoxXihMST/ohPP7GG1MA9FmPfNUjSJtRSqs94KE7PbSUlkFnqGNHzoeDRSSC9z4eYYfIH+pPQVr4PXy6OREOCYoEUDThkXNhwi6r2SO+/cIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYIpQ+/q; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4dd7233b407so35334331cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128659; x=1759733459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4JMHaL/3qlwAM3Nlr5OLy2kZvghpJrKREkBmQxw/Ls=;
        b=dYIpQ+/q/7GB3LOl5HmxgOyCIGxRCaCrDQZmy2R0e2+vzQn0yZBrx6FvnkY47sx7TY
         8+QDXutPsfcsm0bIy/Dzh/hfJer2zFVKLo0BtP2CisWO/HjMjRTNg5pcWcvs79mtkQnA
         Xg4DeLfGIrx5yadtYTl4431l8sT/3PEFZChSH/AfFJujrnGMYLZCOG+6DO0Vn6AHmwxk
         czhJ3Nb0NIKyB3X9XUZZgnuo5ReiHESCGPLtZibQylUOgtfAoNHBb6KMx7PVEHxX2iMW
         iEH7bQQxqaZd2r9wSNQmD6b1+fUriNrfIygYdMbE/jBcwmJWPNvI87X2y7NYf0HBs7Ga
         34FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128659; x=1759733459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4JMHaL/3qlwAM3Nlr5OLy2kZvghpJrKREkBmQxw/Ls=;
        b=ewX32vFFNS+H++BUmliICpWgvu19zljOvwp4L5ryR1aU+lgFZlo3ez2di9HzP9vJpy
         iPJysAD/3he/eqC0aYi/dh+m2R3r7Okig3+1SZkwdQ5+dUWOG4MQx9qxgFAdlCTtDne/
         okJKeCbyleTJoBvy331xXCEghAoED6IjlA1bfbf/GEDOQh02qhV1p0Ybl0JmzViTShU+
         KVyDRwMd61sZINvrXZJzgiID0gOS/E9jIBegICUW6awSe9D4V+ZXGv3IuCJKzWiimKmu
         M+Y2xjMAsJ0sMfudLMGIrRpBOr5AZb/wjfJi1QXdC5UO0vyyj8lHgdmLqlMvXHZoBP4g
         +Fhw==
X-Forwarded-Encrypted: i=1; AJvYcCXeu7THTKAqv6NiWkX52l03cvswzYbFP53VSyQFFYfmDqE8ApEFDQtMKN15KbUF3BiuWonxxA3rEFM9dGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBovaVRF2kFpaaxfX13KYLanPp1njDVZOkHCMymoZz9TT2sjQ
	nzBz9CvAea2GuNP13ora6OiAta6tc0H6Pjxi3rSNqS6ERdz34ZGclTIG
X-Gm-Gg: ASbGncs+RLdeC4bYNhBw5Rxu4QCgUJgF0W6KDA3zc7qdOhT4aXCwbohsdgq4WsAbFLj
	+J6de4Cg7BpihGdjWfDtkGMDdnKKXxf2JfsFMGpuDMhvW/TL095oCf5TUUGuJee2nBLudsUvj2x
	U8PaStLrabpZ3G+o/1dzHGOq7EICFYNO0qsBElql9UN4tQB3DeKv8UnSUe3wtO2ZCDwuaVy3dfJ
	2paygZYn3VNndb8xwNBEZkMNvMz4tMzVQgIGbQBiXfx9/qwoPDfrdhq3wiNf0M7Kd8/goAeuku4
	xGmnIedWnM3pJPEwqRxL5suhpZNWpYFclsUegUR7qGJ6aFKwHKjeiulQxOUV8hVl0lr19Gm3CjZ
	PD0kwz+qPHqLbxLYyBKvKWcekwbIR+DBwyB+kD+hkJzDOtBkP+Uc=
X-Google-Smtp-Source: AGHT+IFrlukycj2XG7B/juAeJ1Nwg/8icH4BSqgTZCKc8FYlYRVX1WVmUtczR3TgVBZ+nHu95Vqjcg==
X-Received: by 2002:a05:622a:4e0b:b0:4b7:ad88:45f9 with SMTP id d75a77b69052e-4da4744f7a3mr228793711cf.7.1759128659246;
        Sun, 28 Sep 2025 23:50:59 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:58 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 14/15] staging: rtl8723bs: place constant on right side of comparison
Date: Mon, 29 Sep 2025 06:49:59 +0000
Message-Id: <20250929065000.1010848-15-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder comparison to place the constant on the right side, in
conformance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 741c7dc83873..d9483594afdd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -776,9 +776,10 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roam(adapter) != 0) {
 					if (rtw_dec_to_roam(adapter) == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter,
-								&pmlmepriv->assoc_ssid, 1, NULL, 0)
-					) {
+					    rtw_sitesurvey_cmd(adapter,
+							       &pmlmepriv->assoc_ssid,
+							       1,
+							       NULL, 0) != _SUCCESS) {
 						rtw_set_to_roam(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
-- 
2.39.5


