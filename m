Return-Path: <linux-kernel+bounces-835843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37944BA8305
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63431C0B67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079A2BEFE3;
	Mon, 29 Sep 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0CI1XDS"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B702C11CD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128649; cv=none; b=qsGoHyuzsana9vU5+gHlBPMI1cL69kJ0Enj6APg/VYq/VIDkMDJq1kHaxT9/vQHDUdCbAg+pZ5eLzXokFMfiOpV1f/QS+j20PsZcEVR9b1eH/hPn/aAA/cIz3AsO9j7s2DeT41IhITRUl4rHKXw9CvpHn/tSe1VwJ2BWUfNaKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128649; c=relaxed/simple;
	bh=ZIDFMuE4M5pN3hNXaXhKSfNWI42Rb3epwAfW5TFj8CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSU1trNI66sMwGAcfavHDjGCNQoNu8sy3wyPqA9s+tiG8Fl8GWnVquIpg3MdG/JgQTSdtTrl4wYhmOQuf3BPdF773kI7Kqqp9fYkJDsjmQx7ZQDLz7y9rX7MywHf8NHRT97cXiOm1Ui7dWm1t2AROiWNLdw62M1o3jxSAhtoWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0CI1XDS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-84827ef386aso266417485a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128646; x=1759733446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75NYRUjzu7V9uiI556WCEEmql3MK5Ygx3IijVaMkk7Y=;
        b=b0CI1XDSxbmlr/64jqmEcRu2OAiXwPJSTeSFX+BiIV6bK4CbJAdPYC2RwIhIPu75kS
         Rxjr3Vr6Eu2KggXaDQaBVXcCS0IuJprey/t8vt8UdErJarTsJmpPpHhAELnu9kbNArWG
         hC48VFx1vMKmbV9UeqRU+uWTIYBKFzK7FuexJW4KI7Fq552LHzGTDU0o4/i9kjxu8z7q
         cZbynkCht3HLUccF+tt17LFz3XiZ+ltv7pV2FAByiz4q/pUcLgl35GeFQSMqMMNKXapp
         +VWH0MZOA1Vg/TKmqoJQ1R0G1xVnwkR7GeHFpylpFLgdpRQMg6O5yo6Cv1+IccVyb5j7
         52yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128646; x=1759733446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75NYRUjzu7V9uiI556WCEEmql3MK5Ygx3IijVaMkk7Y=;
        b=GPWIZibgazlVgOH18W2o6E1+50raAMqDViwFGLeBSzIBpLf46ILr1jV/5sR3KrBzJR
         UG4Tes3posUX9aOW8mwpvnH6yFhi+mnLBg3Suz2y/1PgO4LuDrH6ECNremu9TgMaN260
         t+I3F02CZEwwUOFuZiWNK1K9Zqy5qntbFDIpZa0H9ZQYy3nhlTWfrEaSvAeVqJ6guHDZ
         WJcpyDhiW7B8lr9Cx1ZZdmm33disvmGQ11xofr5hAI3TPlc5H8UPnKodyIkAVZLWbdK8
         e2E7kohw9m7ET5G0WmC6+g61sli65rVG8N1Tflis5bwmUJMpLnWjElWypGa9A/Pq4eZf
         CUHw==
X-Forwarded-Encrypted: i=1; AJvYcCXkbAQaAnXFH45PwsA1LTssM+UmKpH/cLl6yDIeBKVvo7Zv9xZlXt5MYDu9rmtLgJVVNw8SSMSdLjBbH+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyre+Yg912AwQjkSzLVYUhFdw+N4944s6G0ZMx4NgLdihSk8LHa
	PxpCuEzPLcZhIWPfu1QAgs/qAjrL2ANke/mpRcGJ5FKoTuRXm9kmvC6P
X-Gm-Gg: ASbGnctTN4zLrr7Up2Is0F127d+qrAZpaTb1qu9s+sQ0Xs55ffnHfFtw0mNShqTuFji
	KWrlD/t2bZQriR6czWUiFIVyDhti5ES1/BQShG9owzktBUcnpajPAdjh6cYv0Nnz1i9ULHQFyca
	5hTTN/J5RMj3Zy0l2nZ9sa4uxHvbkg1NXlsIhj6GY58hNU7OlZ45iZzj0/BaAZmEVeelw30E669
	jgu8mCyFI63jo+1UrTmYkEduvZy3rKI1oUYc+Cs98zXVynRpY5bb6p12ApX7o1PCjSa6LFf76tP
	2on8WdofRdLrFq3Xgr8sBqRJDkDtSkdduYuMNWDGOmtKbSGNKZz4ZFvzEwqQW8eARPDQNeqXXxs
	vznQvz5ruYe5655ZlkIdue9rwK2U2ZjRvJmsRyuEa7+roXR3pNFWJebhRylRBjrehZFA4/lo7
X-Google-Smtp-Source: AGHT+IETBXJT9TSZrRNQtwiykHOuZOUkMcuhaG49sOTr4axYPf3sExOFa2JBQHhSe896Y/AgSfSP4A==
X-Received: by 2002:a05:622a:480b:b0:4b7:aff5:e8c2 with SMTP id d75a77b69052e-4da4bbe4440mr188684981cf.58.1759128646578;
        Sun, 28 Sep 2025 23:50:46 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:45 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 08/15] staging: rtl8723bs: remove space before semicolon
Date: Mon, 29 Sep 2025 06:49:53 +0000
Message-Id: <20250929065000.1010848-9-vivek.balachandhar@gmail.com>
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

Remove unnecessary space before semicolon

Drop the extra space before a semicolon to comply with kernel
coding style. This change affects a single line.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ab626c88e7dd..d05ff073af2d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2236,7 +2236,7 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 	struct	wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
 
 	/*  adhoc no 802.1x */
-	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0) ;
+	pdev_network->privacy = (psecuritypriv->dot11PrivacyAlgrthm > 0 ? 1 : 0);
 
 	pdev_network->rssi = 0;
 
-- 
2.39.5


