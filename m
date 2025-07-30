Return-Path: <linux-kernel+bounces-750072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B776B156FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7837418A4279
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977813774D;
	Wed, 30 Jul 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TedgXj/Y"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F39AD51;
	Wed, 30 Jul 2025 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839095; cv=none; b=OjSI1Hxz/5kRdnMD6HYTBpNbzLpNp57fUMXmHTau/TF5fU1Z4WaN4BqyCBa1HO2s/1bk4nDTMOZaCGcocwFOylNRTcPbgj4NKI+GeIqDj4pGokADRESGD4317vQ8oOxt22zlIC9s8VQcdVfAvhnvhSwvCKadaLAa74SEae8JpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839095; c=relaxed/simple;
	bh=WqqRjk5XkW8a1jmbZUBRt3xz48/ONJHOXIwysw7KMtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIWIw3a4hTIsbuJBtgLCwuvU2aEN2rpaPxG7LqhhtB7BMHTk24jLXF4aSEWPPFjijjj7qckGIIZiiiVvoV60kW2hKhhKvxGsbAc34B4KWG4PmNE+4ea/Yd+NCcm2n06cBy4GG2YJweIn+kiZURQa/bU7aG8Nu0F3bBLRs2EAYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TedgXj/Y; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313910f392dso4874641a91.2;
        Tue, 29 Jul 2025 18:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753839093; x=1754443893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UrA8Pubsfo9SGTRa/mc2g/Yhmu71br87xPthDf6gUo=;
        b=TedgXj/YmSWUKuIVfykiLBZSdhVusapiKs46wYPEFlONNkguh58qTObbzE+giIlfVM
         DgjB8/x2M2SQFsMMk5bpccxy9lpaih+TjLUSR5C4+1/dD6ktPnxfZM87PQ+wEkFVj9aX
         H5nSLcLjBFo2EP/Vc6/LLCnoQC3RNbuLrT9VRjC24nUK9u+31VgaJO3MF+gUauRIrHeA
         7eaGgIKbH6D2cgBcFrHp1kH8YbADwHRiVTWfRGeUI3HMuDZeZ85/zjGr6KYCWSMWGH0D
         5vaMvqUz2+vITAlQGlGwhhz/WbHeSIdz/DSA/kVyZLmldeyrovAGPH+IQ/C7/I/QG9TO
         ADgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753839093; x=1754443893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UrA8Pubsfo9SGTRa/mc2g/Yhmu71br87xPthDf6gUo=;
        b=dLWr2mOiIEgkOL+7bag8FNtU1pnnRjV0W2ksdcuogR5KJ+xXuzwy+TOPjvGGxoGSM2
         qdO5lPwzI7v6UV3z/J26f/tWNHTG16ImAPBKM+QZn55GuMyiLFPoKBTJq5FNYW02y8oq
         /jXjLXoF70IfsAGPr3zwe458pNmFxNJ3/pScqdT4zzFaeOcNvVHbv6XWfbCD2B+yYpd/
         6e1d9G7MpzAtZ4q143w0zG/OvALGkCrQfylOEmo7KNlDKCoA3jvtmdr1e409k3ZNfvAM
         OLX8J1rVbXI3HzVSxdqueQQjp2HlzEpP/SI3yKLiYFBlNg8V2KFPeB7oXXJ62vVHPDTB
         RLKA==
X-Forwarded-Encrypted: i=1; AJvYcCUtCGAt3YlnA700EQyJqZfDU5Q+fnHyNLexJzPTNY1NOPRuEBa/6heswVx1DeDqIeQbThNSoOvyDkpz@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQdS2ddz2oMLpPPf35LF8ymo5lx8V0ZmZ4eEtmVlUkOjE9yDt
	IA+U3aOzRx1iaBsbPXFq5f/vp2414lbhWYmH2Hl5OE+KXQDjGqtKpcDd
X-Gm-Gg: ASbGncvwLiG5aXrhee4kYkaSxhQkV334WiG2LC5+upKBvlVtvb1lcTFdJ8h8wKUJ9Ou
	TouhEWNhD6W8iHCWov8pEI7u8cy5csLB5Mi8CUTmDDvVRlL/BlyeC50KIBt9JU40cMwbNu9wMbI
	05HyvD3m3BSrzuqUj4urB4EQqILxps1y5xd09WzlxQr5sQCVDsnHYMddiXua1ac4CtGbZHE+l6e
	G8HPaj1Njc2qdjrfEc4zm6J7O2vxWTAcI9X0KZXav7qWOxAoXysz4m0+fgZs0bYJdkh7OzJUYaH
	6tiO2UR03Xg3Ujvc1etcAuyYD/weEyu6003wzVOYnDv8+DN5PfPNrJ6ItthpoJo1yIghpMBfuNE
	Hs3tSIX8Ga/7/HOlI3b9A0A==
X-Google-Smtp-Source: AGHT+IHwyzHMexFN9pgKHGI/ALGiA3cDa7lBc+dNIGFThmsCRva5DnrD0rUa2HV5osWj74jNlnOieg==
X-Received: by 2002:a17:90b:3c4f:b0:31f:e6e:7313 with SMTP id 98e67ed59e1d1-31f5dd6fd4cmr2138367a91.3.1753839092771;
        Tue, 29 Jul 2025 18:31:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc5383sm386714a91.15.2025.07.29.18.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 18:31:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E7C3D420A923; Wed, 30 Jul 2025 08:31:28 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Devicetree <devicetree@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jiang Jian <jiangjian@cdjrlc.com>,
	wangjianli <wangjianli@cdjrlc.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] of: Clarify OF device context in of_match_device() comment
Date: Wed, 30 Jul 2025 08:31:13 +0700
Message-ID: <20250730013113.11264-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=bagasdotme@gmail.com; h=from:subject; bh=WqqRjk5XkW8a1jmbZUBRt3xz48/ONJHOXIwysw7KMtQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmdJcpxu1UfbNjzrGbDTz7uQ9efPeQ74WzQtfK4s6D4v O+zN9j87ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBE1s9hZOg/ef/4m5VT7xd7 PmWWCbCSaJ+ScWRL3qxNCmWeVU+Xaz5m+B/76M+OxcffMDslXMmTkGB79O+6QLWmyrvpV+SZ+98 3T+IBAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Open Firmware abbreviation (OF) in of_match_device() comment is written
in lowercase instead, which is mistaken for prepositional word "of"
([1], [2], [3], [4]) duplicate.

Clarify the context.

Link: https://lore.kernel.org/all/CAL_JsqLypcBCOVZ8yYWK0J_xc2Vcr+ANrX_3v4vN55Srp4RknQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20220926185852.GA2581083-robh@kernel.org/ [2]
Link: https://lore.kernel.org/all/CAL_JsqL4GvgFYzGUfhW5pvm4wYGrFaj6gHOYZjnOMuk2zCz67w@mail.gmail.com/ [3]
Link: https://lore.kernel.org/all/20220627173825.GA2637590-robh@kernel.org/ [4]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/of/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index c80426510ec2c0..f7e75e5276677e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -17,8 +17,8 @@
 
 /**
  * of_match_device - Tell if a struct device matches an of_device_id list
- * @matches: array of of device match structures to search in
- * @dev: the of device structure to match against
+ * @matches: array of of_device_id match structures to search in
+ * @dev: the OF device structure to match against
  *
  * Used by a driver to check whether an platform_device present in the
  * system is in its list of supported devices.

base-commit: 0121898ec05fa4c1f566fc05c7e8b3caf0998f97
-- 
An old man doll... just what I always wanted! - Clara


