Return-Path: <linux-kernel+bounces-801951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA510B44BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521FF5874BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E8326A08C;
	Fri,  5 Sep 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1Y1cIa6"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146822FE0F;
	Fri,  5 Sep 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041032; cv=none; b=TKYWRcn6kfKbGhUAvUx54HO5+4G5d8UUDDQA6IZ44JVCZxES+tse51jKHt+lIer4ot0f8yX7vlquq7uU/gWjdOBxtauxXVpttvy8CmGtPba11WVVHRRpCNuZILenFfqTq4po9qfjmQQWuCF5W7wV6bfcvndFiZem+MaHCAu/lfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041032; c=relaxed/simple;
	bh=HknTgbrAdHgJBy2bDD0bnPJ88CWUkFBS1l4ykngVqmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m89NLrmrO2BLceahkpp6JuSJyXWeeAMuvLXUZszHAIfzW/NuoCynxZvd/+1LD3h+3xJf01EW/dJhNoVAEV1doi70iKaJnBhZAyRde/w+DkeLj83fzzP355vE640sgxDXLnhoUQVc0kv05Y30CPgcMbeV9T+iU3jS5ONKs7g+q50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1Y1cIa6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so1502710a91.3;
        Thu, 04 Sep 2025 19:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041030; x=1757645830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+vEPXI04svoj/TPQoMDMvMjQE07Pe85gfjZdNXuHCs=;
        b=M1Y1cIa6l6sPaRRfYm2+Jtd+F1Fwb4d63Mu617EkLDrcuQB64qLeeALXWisgYq2I78
         O59GGQ/ytCX7hV5wr0IeVL1YIXnM1yfL9sxwMREwVySryBbEBMeXeHxEKSrYdQCdr2S4
         xFFoKAfay4HTK4awMUJl621CTiLfReqW33/og2HUBix/y/5ovPI/bQ28ya585qr09elx
         NKD4wlWra9uzxm1MvFky1wSIu45HUUpggkmN6bpzt65S8vDvzQjEbqmhvmmQwPE1sNKh
         ozkfx6Yrl0C4moSzxXNqGH2STP+AuVO6k63NbPtxdg5t+xxTmkBsYQzKpspcGbG4R/MI
         mR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041030; x=1757645830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+vEPXI04svoj/TPQoMDMvMjQE07Pe85gfjZdNXuHCs=;
        b=oqrpnZrVf71zbTdBtDfupyxAS4N8Wdyots4z0AkLiTN70u1gojT6dNSpm60rK2awLl
         5qLQo9YiZc1wYfoHjnhMot/YTFpCCCLjDoNd3YXqwCWiEEZyiUcIOfeoNx/GObPO/WHF
         kwkVj4Sl3RpdsuoyzpEJ4vtGaahzi578WcLUFEdHpdSaofwCO81X1H4YVBnPmrvVIawR
         SNs6xxIlXVOlhtqHv4JKthusnl6kiHVjmV5JVAQOi7HM/2IwpWlTidmhGClz0XgDU4gR
         cSgBqr3saLKO5wnaoPGR2nf0z/WQp+cYjc7i3mnbCTaOpRA35MLHyITZ0KQCd6Lng6Ds
         SfeA==
X-Forwarded-Encrypted: i=1; AJvYcCUGg7oL4pvnbk0F1Uh1PPPmLYE4w+vDfnnDb1k780EYEU79gdfiTTR7LrhCj96fh2kFuDlbQjm0FjiJ@vger.kernel.org, AJvYcCWQRSwLqHnXX2nriAX4xTihJ/pATwzvwC854nBZaWpTvj4uNHO8Pzs5pGwxdfkI+yXSwfs+CqfnDMcxuYyT@vger.kernel.org, AJvYcCWuYIBexhutbOW5Bk99PEhgonHVpdes7DMRsyCLWUWsTFlMq1CraXYmzKr/abexy7laqDu+i3MaBFlP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9f+AJ66vZM3PTCux9UZoDN7cP5pm0Ku9Lnhr7mMzs+cpUF1c
	GOow2/o5CTgptuvkjk2o9j1MqRPpCy3g1U37YPLS8JI0kKr6NYQDM6So
X-Gm-Gg: ASbGnct9pE3IUdp9lq0YY4b+gE9e1G2y8p4uVZ5ToDh/ujy/bFmNOwFcDFvSwa5Viij
	s/QHhQu169uyoFm4jc68WWrznpbc6YkkxTYSBgwl1AtOyrD2A6LHMbKB/TRs0MGglr1TKzBloHD
	nGIeEqtqx4RBz53mLzy+RBgV2611RN62qF0lBskrfkeEl3JibVEdvT5GtNanH7aB0TQR9OiP9+E
	qfwOnGa7YRSg02Y2So2mIkGnWvyHUygNaLkiQfz6kECPMvtMTC/J+YkyyLPKTTQjBX42zUrIdBA
	9CnPZSBepZjHLOsXLATtwLjFf5fU9q3RefIRKO2+P+aqJttYDSOXdAOwvUzAjBvIzbyU/WkP7DM
	d+HU3dED9wZUreVuGVUC4PA==
X-Google-Smtp-Source: AGHT+IFkmAyWcJVzJ2B7y3qrndQMgDDJvZm3A1yDr1lqvIEQmgIrw1QL0xkk2uepzv9vjXk3lvsWHQ==
X-Received: by 2002:a17:90b:5190:b0:321:6e1a:1b70 with SMTP id 98e67ed59e1d1-3281531fb79mr27225069a91.0.1757041030189;
        Thu, 04 Sep 2025 19:57:10 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:57:09 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 3/8] dt-bindings: clock: rk3368: Add SCLK_MIPIDSI_24M
Date: Fri,  5 Sep 2025 10:56:27 +0800
Message-Id: <20250905025632.222422-4-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a clock id for mipi dsi reference clock, mipi dsi node used it.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 include/dt-bindings/clock/rk3368-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index ebae3cbf8..b951e2906 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -72,6 +72,7 @@
 #define SCLK_SFC		126
 #define SCLK_MAC		127
 #define SCLK_MACREF_OUT		128
+#define SCLK_MIPIDSI_24M	129
 #define SCLK_TIMER10		133
 #define SCLK_TIMER11		134
 #define SCLK_TIMER12		135
-- 
2.39.5


