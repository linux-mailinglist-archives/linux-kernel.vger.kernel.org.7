Return-Path: <linux-kernel+bounces-790971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D6B3B086
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3397A1C81854
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B01C2DB2;
	Fri, 29 Aug 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8f3T+u6"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109311494C2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431061; cv=none; b=mdd+v+LR4bOV0G8ftvDsDXU/R7IAX5H529e1RT6ripCkrqsfQ3okdQLPGQy4txHGDLYB0acVLKUzS1a4eR5vdDjPoYAcEU9GGB3Jz/ThIdo3sV41XhuaHa4QM2VqS6o4dMWxQWPT4ml25HE5G7azQDJhNne0SB8cmxHHSRrum1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431061; c=relaxed/simple;
	bh=wFobh2ikRNoFGCtqUBAYK6BEm5r28M7qwkKY1uAIfJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFx/K5SjiDt70r1S8vPyBvycpKTALhW0pE41OeA4Oi/9Xro8oTUMhKOwSth4FhOhz5/ABZWrR29ij65++0vczrBIHHxI9ghemSFO3xR4DwLOvPU9cv2lBXXil4QvGEa9kOXWssqadImq6mNKOZpEkXOotgVF3LGAF/oCZpYWD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8f3T+u6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e09f58so1642859a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756431059; x=1757035859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5etRR+Xxyc8+k96JgNEfZBUH5eJcJpsRvKz1dcHOpK0=;
        b=O8f3T+u6wT0rBLLU4zJgrU7xC2AUgT4SaL88OGErREujr/JQciwZH5zAXT3nyVDkfj
         z0WjM4oOqsYw54WoQ2BwTEaCch9VjwM1LZLzFitcuC98XbckIY2pQsf2FHVVPv9w87b4
         2L/8Zl6fd//u0olN/52hf3bLiYRilVEeRB93eX9AVALQaz1ULPZcE9S2mADg3dURxa+G
         fuip8abuyBjwvBhYEoQtuUUh9gl25Fe1UZBePkO+F85vooz9mH7ivHylh3j4kpIBC7d/
         2XVtfmjdtC2TuyQWRSGxrWjKlImUCFBBGDiu+78T8Zgc0mXvAv9zAGw+qhwtJ9MeMiF4
         I8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431059; x=1757035859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5etRR+Xxyc8+k96JgNEfZBUH5eJcJpsRvKz1dcHOpK0=;
        b=lIg8LemtXPU7dYElkj92+PXHgatNWZ+tgpt9GA8twCDkoyqMDPW+1C5NotSfyF35Ld
         EPs6tYgc2sNFIVtlEeDXCD/zRJi4wqbxt58PDV3O1kkcVn4tWRu+3DBh2SPVeBhOqD5A
         a0i3m7+ISupU0Yir1/WVHMDl5mt148uqHur8DpSdxujjPCWBQwEYPIeFk2RrxwX3nHyD
         70cdKjIDWuu6FBtrs+AcSSg5iMazGCBKUqdb686kG28hrWN16aHeuyuJYyUBqbjgVha9
         1BXFTimDin7ZxCMFpmAJnZuxDiDgQYozv1+r32wEN6u37XSVwjxZZ2I8/+qK13bV04fx
         QJ4Q==
X-Gm-Message-State: AOJu0YzGaFZPdam1CapCf0PfzWhyABaJXoqznllD1AM5yYqBHunM9WV7
	K2nMRS9hjH8WRKt5XuSie4Nbjh4xH/0utcUMUngd/7eMYAaV02X5wNaS
X-Gm-Gg: ASbGncvIKwM7weNKfT7Kpg/AixsQTleffUGI8u7f4iV4vNSIQLF4WzIxlha/thBMzg/
	L9W4IwRt/bNAA6wCseOWBp1jL1V5lKzqjeUPdkqCvWRF89Q9JcdoiLLN8BDvHV2CxhxPqCqbRvK
	/+j3UT8P9R0sHWSLYpUpAVmBwwYWebLmPKzXx/goEtOdbwlWOCT/EoXJemQCZ+mnXa7xUHToyI5
	j2T2YHD2bY3jt54wtcMb+JoDlY15WfqC6YttubUjqsZHfuY18dAWZhcLfKI79lERoMC9j41pbG6
	L1s5Dz/C2nKOQ3yzqG1+fnyrbh0CTM8uxM19TaSR6zc9oU3Tq9i3UxRVXwQEuddh63c/eiGex/S
	S/dO84TuAZeAeNywj3filjiXVYK0Y4QWieYxlTSn46hU=
X-Google-Smtp-Source: AGHT+IHaUGcnHpI3Tb8ey2qTcE938zK7xyB70jNRuczFvR15ztQtKULyRR4KJVA7JcIhXZpJ+n0yBA==
X-Received: by 2002:a17:90b:1350:b0:311:ea13:2e70 with SMTP id 98e67ed59e1d1-32515ef813fmr31446558a91.14.1756431059257;
        Thu, 28 Aug 2025 18:30:59 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:500:7a9f:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327daeec552sm959977a91.27.2025.08.28.18.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 18:30:58 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [RESEND PATCH v2 0/2] i3c: master: svc: improve IBI handling
Date: Fri, 29 Aug 2025 09:30:51 +0800
Message-Id: <20250829013053.3562853-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve IBI handling to prevent certain error conditions.

Stanley Chu (2):
  i3c: master: svc: Use manual response for IBI events
  i3c: master: svc: Recycle unused IBI slot

 drivers/i3c/master/svc-i3c-master.c | 31 ++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

-- 
2.34.1


