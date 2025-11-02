Return-Path: <linux-kernel+bounces-882086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D2C29949
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 00:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DB38344495
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 23:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E191494CC;
	Sun,  2 Nov 2025 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUkjDt9R"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8302F5E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124518; cv=none; b=owAbUmExCx+YLTygJ9DKskMCVMnKrLcH3GavAcERpS0tKn4NM2UtBCUeFz2RGGWGOKvqgbT8tA34JDj4bsM0HeNIZwVZPlUfxfq2gb8vOameChiIP91Ae/T+S6Btan85EdEbCH7HpBOWtgQsXIpEbWntSiunTprlNO/NPky5p5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124518; c=relaxed/simple;
	bh=GfVeVjIlMgPT+UemYVUldkkWYQW4Y6aC+ZVdDKwyYkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rj/PreT2XmoJlrUXI057gYkN8E7moYDcO9q5Gkrx2eQchLZe5sG8BcW6Aw3Kv/lKBNm8sQAx6g3E961Ieb6nuHpKMRr/EaWG2a+hCsmN5TN8w+ZvOW9hG6lGOn8QN3PWXzfklCtf20gwCdldeiAGIxUC+lwiOBSbQaIaptZIMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUkjDt9R; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3d1e68f7a6cso2403571fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 15:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762124516; x=1762729316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZdylP5ZHtnXQ+DVmn1YWZdzLTkE7lGMQKzASiLTEus=;
        b=MUkjDt9RbHjVyAkU5gXQuS9G/kixy+7cvULzbNsDNBuAcHAzLiu4AO+3SNwVMRVX92
         ErLxSGl3o0hf5l2sJ5OKu7n2i0xA+xNCasGd/1StB/o1U3MA7YIW6AlXaONjfQJpG60u
         PyWh0NJ7Gqfdisoe/IT+BfSLkL1SYcNCqYNWbLTT0JCfruDtmiWFVwQDveGDm6pba3VX
         2PHcoES3rPDupapC6A0H/+iC/XGggZMVYFkZ3IXmzOiEi/9UeWU3dIO4dtTIVOUrXGQn
         0SXEyg2FgakqojF4b1anlzEy8aAqp+dyzfgdsoyJwQ+pN4/XdyBW3MuZldzb2aJvIpoH
         359g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762124516; x=1762729316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZdylP5ZHtnXQ+DVmn1YWZdzLTkE7lGMQKzASiLTEus=;
        b=IVpNmH9u32xUn/29fDdbX1pPSAsFa+MZHUbS+wuqamxpPxb7S6lnteon2N+DLjysch
         yV8IkaAFaxlVUaH0Hcx/+L2HBVirK1qLrpQG4PatFTYfERiMoxkzaS8OhFbKJfwbuIDY
         MPeBjWH8gen4hn4uBAechRoSXnfDKRYMKx/NZb4Ks5GHp3FkuFICbhquaT9vFZDy/QW+
         fpNfb0PXvbZjVH6r59Yi2XiZ0hSpJ/r4UuLNudFGL4nUylYUNkMTGT5D/PpURMeXm0eY
         mQLJH0OHfYFxzlm0+0FSwGjkgfJTvTg2Ie1fKWSjcQHRXEGQ6Hgdsl6Zw8afKkyREH6+
         RQlw==
X-Forwarded-Encrypted: i=1; AJvYcCVcPXLhgs4FRYnaN8hyTrJhZkjTZ82xGszWeoC7rK5BwWfLccMkvJdsstjEyrjumACsrS+tmV/YOPUGPek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjiQS9yFJaHijaO4egXl+Ts+hGMYblnC/4teWPjmCJZUDqamP
	Fo042Mb2ZpkFP/bWJ9pIX4nFskOCgMPyFZm8CBOCtBYgSZCByM02TBcI
X-Gm-Gg: ASbGnctToIBVV7uoFlGyc6i41uQNck0sP9s6wUtJREslKfLMyuHqhrYKoTbMC9xxA0A
	1sDcN4HKdBccncgMCdYgHdb4lbOQesGws4Gwjb8OfGsGw9/0ZIg8xXz97/MylaQRV3kMUW+pQux
	ajfLqserjR3rMv0gGrZcTMpDCnqB09LRn3Z/gXSgkc84gB1qUJFdgGYkxyo1VtwsyjFHUjiG3Xx
	kP7Mi4H3VqQjIYZ97dNrSMP8XNtFjOT4oTFPfpV4lgnog+Gta6rJUn8Mkp6kivRSvrWX0pJPkx8
	RB7zTN1yQ7lQlRWnxiXpFG34vhcJsNFSVHR4j3WS03v0k/DJSCAqekFkJJf6g290kMK/y5hRzUk
	XNAc4BJRY8kQgB0SjPb9vOmRDTupO+rZK8/sQeNKwsKQeZt45UJrB9pceGTe/vkQ4aHzhH4QqeU
	xCJpYzI1rTvUK1SmAslPlocnJXpEPWIAQ=
X-Google-Smtp-Source: AGHT+IHxfEHo5U2Vd+PbcXp5r4xXTkBS84lXTZLCP09zNu4A/UZWHNNp54bKGFACytoMbouth6qfew==
X-Received: by 2002:a05:6871:8012:b0:3d3:ba60:ee19 with SMTP id 586e51a60fabf-3dacc9e2d35mr5145141fac.42.1762124516282;
        Sun, 02 Nov 2025 15:01:56 -0800 (PST)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dd9a924727sm1210628fac.15.2025.11.02.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 15:01:55 -0800 (PST)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: avoid chained assignment in setcolreg()
Date: Mon,  3 Nov 2025 00:01:39 +0100
Message-Id: <20251102230139.1720-2-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102230139.1720-1-cristiandelgobbo87@gmail.com>
References: <20251102230139.1720-1-cristiandelgobbo87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the chained assignment of red/green/blue with a temporary
variable and braces. This keeps behavior identical while improving
readability and satisfying checkpatch.

No functional change intended.

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9740f2705679..fecd7457e615 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -537,8 +537,13 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 		return -EINVAL;
 	}
 
-	if (info->var.grayscale)
-		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+	if (info->var.grayscale) {
+		int lum = (red * 77 + green * 151 + blue * 28) >> 8;
+
+		red = lum;
+		green = lum;
+		blue = lum;
+	}
 
 	if (var->bits_per_pixel == 8 &&
 	    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
-- 
2.34.1


