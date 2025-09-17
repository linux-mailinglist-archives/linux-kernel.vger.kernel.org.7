Return-Path: <linux-kernel+bounces-820462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB18B7E86A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C7C1BC71E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDABC35FC0F;
	Wed, 17 Sep 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD3gcOEv"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9FC285077
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104314; cv=none; b=mKIC/9VGD33e8OgJeA8ijLH5ws5bU+e8FT1sitYiXl8bj+6gbISPe1Mg15txy2zpOJgE4taoBiPyGifbc/d8+nppw6rq90SHj2VCAAwTacim7X1ZxJluPl3mitdT4CqLvrQKDWK9ukG98Ngfi0W6uLU+PhrcdiZBbwjrbgdptcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104314; c=relaxed/simple;
	bh=5/1gkiTNtLbu/XmxGojO/4FdNXtINVTfkfsGsdU/dPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOtoXkaBi6f/AsMJQRZYWXPhYbOcwAft+meCwD5UYF8zxW2CXBmQqmjtUI4DuURbNlkH6ga8Qk3HB0XRxsqhOyxtePfsQFEC14y/du6MHcz+7Zhr5geuOZqHB1ZkgZUWulidc6JxhTLyHNW0SG9rmBEux74g9CIIZamLW4MmzhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD3gcOEv; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so3821999a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104312; x=1758709112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZgFdo56U5Rjwn/0fXd6egZkLqMBUY9dg2lSu0VhJvc=;
        b=CD3gcOEvcdOkJmuChNFoBgTJ+gnosQ2aQu2b3+CdKBSS/IdDYIYf4oKjtAuRJP6ruh
         6OpHdkVCGMUdRabwGZDsEt4zHYb8i9BvV0zxhVkpjdlSbiYYzg7XxUszFDG/i+w7lKXz
         DGupQlDQ3r3wLGTMdmusMUx0xAXMQtvrLepPu6g45u4AT6T7NEIlYkUe8ppb0oiC+wgB
         9K1PO7ZU5xwthaA+ebtspAxf4Wm+K5r1xRgqyVhpe/OSa0iP5pFfLCon1pzq491HsxtR
         iNwbFOViN/Vis3a1a2iLfbN4UgkbrVnvVrXUSiSb3Y/qoe0+5ajr//oprvXf5m5UCTr2
         ilNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104312; x=1758709112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZgFdo56U5Rjwn/0fXd6egZkLqMBUY9dg2lSu0VhJvc=;
        b=mYt1ama3Ci2Yzd2WtHghTIsEfA6KI2vYfPtgcm01CmUkAqcl7j7gMRmldR9F/v9du5
         WpVHVxpFyI5lImKw6BWcmBd1ZjCt0ORy8ICVTavyl8n7ke84SOzYMnfEsY+ToGSPfmFo
         T4RVy+w9QGvGgd2qPLs1QJUmnMVV+x8rCuIc2Npt4O7T+cstsKhekWyL8jpVGevnEVQt
         AYRXa3ew0R8ZHCmUxDRD0OPr4oWe6Y6M38rEtIKu3RG4PiggKuG8NBryv9ZOset/2h5X
         3OjpqVNUcaWbyN6SQh3qNgFOBx3/2TcZkG4qtoXoIO6jfQD+ETT8pR7bAuJPIM1PnBBt
         AYsg==
X-Forwarded-Encrypted: i=1; AJvYcCV6RcN4QasK+A52IgWYlhu75UI6XfMdsR1Y1GSLlDmPb43YVKgXb4U8vuSQ9262ZL6Ay22mt9W5aqzikAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2+pDe0m80RZD/FYBFWKGCuazBl6kKJ25toDO2a0Ls6Ckxkj3
	xRv04FORjqeC4yPXxqllyVLmaE85erMH5hxw9qj71uXZxQ2yKQQCBG3L
X-Gm-Gg: ASbGncsRR8Z+34YvVgH0uWg7lGPLOU+eDj8HuzfaoVS+ST8lVpfiOAZOSTvQl6g6oZR
	4EcwOtWtn7RDoP76imw1QhrsQkKKhkRq6PbI6cxkY1CwVsFjn/W5IJ+4O3Q0Zd+NSwcSS3xU0Sa
	ERkwe9u/R8U6UMbkqeHMlImxYFl/MReAdfGAeyE8mjuwYhGUL1Wo+9jOkI8Z/frv/b5tPV6B/eG
	jf8XKmBEy68PFIly4HAPeFxuG0gOsnzF3TpBUEreVQJzRJ2o5geRCwMZJou6KeIGW9Ig/8msM1C
	8ZU5TgoOXAgoVlobNv21W1rjx1lu8apFeAROzNdKnFtzFakvamj0c8Wq1Qg0VqEhgUz39GqBRDY
	U4CV97aKm1EmiZfHi9Lk+RffzG375N+ln6amrfcOyFTV88T8vWi/XhTHxicvQ1sbGbrwxTvs2gz
	4C75/25BavQkLHTNHpDf27H54vAJx3ruoB3crT
X-Google-Smtp-Source: AGHT+IF3QgCkXxslVB6+8cU4cYQ7hXjdu0fR318XHFqwWXVd5FRKAeNtm0+mTEJzK5nwiVQMB620Aw==
X-Received: by 2002:a17:903:3585:b0:264:1afd:82e6 with SMTP id d9443c01a7336-26813cfb4fbmr18125285ad.53.1758104312186;
        Wed, 17 Sep 2025 03:18:32 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:31 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 0/4] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Wed, 17 Sep 2025 18:18:21 +0800
Message-ID: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

follow-up: https://lore.kernel.org/all/3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.camel@codeconstruct.com.au/

v1
  - Patch 0001 - add new line between the child nodes
  - Patch 0002 - use power-monitor instead of power-sensor
  - Patch 0003 - dd sq52206 power monitor device
  - Patch 0004 - dd retimer sgpio

Base: tags/v6.17-rc3-39-g07d9df80082b

Peter Yin (4):
  ARM: dts: aspeed: harma: add new line between the child nodes
  ARM: dts: aspeed: harma: use power-monitor instead of power-sensor
  ARM: dts: aspeed: harma: add sq52206 power monitor device
  ARM: dts: aspeed: harma: add retimer sgpio

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 59 +++++++++++--------
 1 file changed, 36 insertions(+), 23 deletions(-)

-- 
2.43.0


