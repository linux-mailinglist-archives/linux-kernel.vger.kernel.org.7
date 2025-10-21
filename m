Return-Path: <linux-kernel+bounces-863598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179EBF8454
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9738654580A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359426F478;
	Tue, 21 Oct 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMgO+w8w"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEC225761
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075210; cv=none; b=XRBUemEUv6E8870IxClVcDTUa7W9aifuh6zuABJpWrFE2UeoGN1XSL0wSfw+rDCEDi7AtUjbQEIrEkNGW/1XK/O9dleAfGYBCAUATcLZFwl1XklBlPBVFFfcCP5n2Ch/DX3cCsIiadszIsWwFu4K/rLdGgXxDJ+lBpcy4YaTbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075210; c=relaxed/simple;
	bh=K1TU1UHrq0DQiKTAOIZPJwfZQj5ABx8dAaTeOx2uq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if8/xnEPuWTCZIne6iQfK73uWOPxs3BPoTRVyCiNZaDbhamMHHVRFiVWxcI8zMPvjqY5JMoPu2OGnvBQ/MP4vl86ESF882FT3D/5UeR3thd2HM6CfrdPknnGaBvKl6VPoc1TbqyHkC/Afj0OGkuXX8P7NK8wLnzJLjXWlpHW2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMgO+w8w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so5525065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075207; x=1761680007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFUK3/M2/OMRE/7w/JqieZkjZV+2HO5R7PJSBTyxlH0=;
        b=EMgO+w8woxr3D53Jss0PBhzKhR46ViW/unYaVj57OJ+NvGBHXke2Msw5fuB99RG2tl
         k8udkcEK6dg8HUdtkcxiDS2AnvfqnXJPR3gTSmJnHHG2EM/J99nYjWeFseKlYQf5t144
         hx+8XHJIOAHYy/xwVB9A/bFkXV6vy2ZDoy2Mj0SL1r6fl/NosqWq1yJN3PFO/GJpPl/h
         J+WAkXol1uTmINIus+3EBwecGSkwn5YDSh56qarKnrimA/ddeTPiZSZ73gJAxA5D5WYP
         oIz8cJ0D7SlDs9hzNXDOYYa1YOhuZWcXzU8/ZznVtwLBpu8JN1JchvqcXNrgD70GmVNR
         KpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075207; x=1761680007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFUK3/M2/OMRE/7w/JqieZkjZV+2HO5R7PJSBTyxlH0=;
        b=hSetEB0UEGX4LdotVDtPdRGEeyXb+iNlNpUq4N7ThTY5rq/IaPpQzqTlYmA5/3YOe+
         GglufRtMss2kL/aPZn7tKMRMmirQHt7KmHXCEER/D0TEkEHKqq5E4Anx52pnEF+vWVUn
         /aHNjxJYZ1CUFL4GKLqCTG3ux/LpgoZnggCEe6E9N8gNtLstoSFdhnxkE49zxGrcyan3
         WeKJ24OIKdJbbiMHumlAjPzoApaK3eaGGXrjLQrQwg1ZiMOKdeTajg2IN8w+TpBOKmM2
         jaVXfQSmhPEv3kIJ7YzrFt9MTlV27FbGY/D3ZrLjxr3+v2wH7kmZZZwSwjpg/ljQhlh6
         wJog==
X-Forwarded-Encrypted: i=1; AJvYcCU3MgpiTh/wtpHIkM2DvWLsd8So9FK0/LsZuJppvSGy2C0SclEHITXdwApxUTf9146yFYLfpEC8fcIAvLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGu1jcLkJjvX5luk3Y+1IwBnhvZxy3M420UvOuEvlZGLHbLNx
	yC5dK9cHK3Fsndkv0lK8MZ2XkOU6exrsO43vKWtnCj4NiZrmOLeMzMG4
X-Gm-Gg: ASbGncv5G93c+LtDRbL3fdIdqhP30NZHjpEkrLt9UxD+NZjSF5pw7+vUrbTc2hfnWJ2
	7GXi4BkLqHxVloD4XTuMhAzVXeP6IlbY1i94mCk8UP29MCiuZ8RGdN1fhPlVtYtLQ5kpReFzl4D
	2bYcDHiH1ymO104HF9vnNacIFw82GxwD3B+dOLwFKO0B6oIDSKpc35tzfINA6TUHqBuHIjzxLbc
	jn7AE6tC4dH4ESZo0hYW2wFct15ITUsyqMql6JSr1jG0PWv6MvDnqfkHWTaeWdMA71sLrARTYaN
	RlDBZA6fArVi36l+10gjdNJ0MtF1ciK0ccjsryZCza87Mt8jtKB20MFSNy3wF7BCHj6afucmi/t
	zLZNrCpwgut/eSAT7ffmYyEljD1O8Zbm1SzQagWCvyDOspiyOAGLqLzbLd+/alzjL4jD6JQQOOL
	w3P7cGQt71auFyeMCRmf8kjRB5tSNhkrEz
X-Google-Smtp-Source: AGHT+IH2bGg1MypnCbkNL1KvMQcoGo9pVkFOJRpGUB8Vak6PvFEbE3s2pNvi9PmCY/UqdtGimE4Phg==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr152001025e9.6.1761075206980;
        Tue, 21 Oct 2025 12:33:26 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm21327187f8f.36.2025.10.21.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:33:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/2] net: airoha: use device_set_node helper to setup GDM node
Date: Tue, 21 Oct 2025 21:33:11 +0200
Message-ID: <20251021193315.2192359-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021193315.2192359-1-ansuelsmth@gmail.com>
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use device_set_node helper to setup GDM node instead of manually setting
the dev.of_node to also fill the fwnode entry.

This is to address some API that use fwnode instead of of_node (for
example phylink_create)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8483ea02603e..ce6d13b10e27 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2904,7 +2904,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 			   NETIF_F_HW_TC;
 	dev->features |= dev->hw_features;
 	dev->vlan_features = dev->hw_features;
-	dev->dev.of_node = np;
+	device_set_node(&dev->dev, of_fwnode_handle(np));
 	dev->irq = qdma->irq_banks[0].irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
-- 
2.51.0


