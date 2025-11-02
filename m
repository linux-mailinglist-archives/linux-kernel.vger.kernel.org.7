Return-Path: <linux-kernel+bounces-881725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF21C28D08
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB34F188FA8D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615926CE37;
	Sun,  2 Nov 2025 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiWCd0hz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF451A9F86
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078093; cv=none; b=Rr7ednEC4phwo0W2AxYTCCaJWES18lNtaKITv7xMZlOSV1LcZJGZQB1ZysXFYnS9j/0xIRKxAaPVSHXUx1OgjfgaRIhO6HEXsSZ6BParj592GahAwhZqFRstnSXDMeQNUyJ1rxHMk3acRHP/EmW4XV+QwLgQnw4fdxsoVv8xLQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078093; c=relaxed/simple;
	bh=wXuc2UT9CuddcG0oxar/aqtPtcAO08squo1ytkyonAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVniksNIj2xmAOPxRjwXIblPrVdV33hszr91/BltJH6gbI4r+Z2Otg4qi86DOGmIDVUVJrquXFOFVgyFpYzpxA+budLR8uQtcZwJtyVsihcOOTFk9L+EBVKYkeFlTUVHQQM3qO2x+s+WXecn4Ujne9XmAc4A20cGjB+F+QGxVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiWCd0hz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64091c2e520so1976221a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 02:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762078089; x=1762682889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuPuOipH4chf+0MLazXdxhlsluowLstIXfKlMSv4oE8=;
        b=HiWCd0hzf9nn3GNseVGulZ6bX2Fd92GPj679KMvHexI1a1Z/W2XKCuKkB/thnFafkH
         PLAISV50lozBnF8savhbGqaDy5fGWQCdsuSLR9leq0OglH4EkpO3KPrpW4XtZ0LmE1qu
         fvgjbjWqnVziLaIYlIe/v0ZSgjEvxtHVzau0FVUD+z1tNgPQjSNO0u6Y/kgn/FghR+r/
         jq0cRmU9C0/aqXxIgqk3uvjcgcSsacw8brv3GfMBLHyt8X07oE+cruciRjR5ysmP3EKO
         fsiAP+nR3pjzLh4HP+6XwrlvVuzQrNncnrJrheN7tNBOW3724xrr1+zr0vVRHejSy1wV
         fBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078089; x=1762682889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuPuOipH4chf+0MLazXdxhlsluowLstIXfKlMSv4oE8=;
        b=v5V3Y68P/HuAL8R8/kmFauqgyOi2Kd8iQkeOeZhAIEBah/kh1u1iWW4CI66aC63k21
         OVHLx4AdKL7sThrevs0nn1r0uYwLrOdXcCgf+cPsXszzj2gim/DlGP6WaAXxUdq/x1S0
         zKZ7P2RhzHZa6d2jLoQex85U03zsg+oBQehkA91kQ9AwP0/jGRASnewGVpFdU8vjnHlu
         jBJbSfGxsW6k8YxSz43TLOW7893BSO/6XSYvQApNiiZmGrgrSCVGjjlPSQDUvx+zeWwB
         pFAdElR2cwlSZF2M6V0NmWuNPF0I4Amu7hfEReunNbxJBNbJ1XMkPDHTn/jlLIULut5+
         os4g==
X-Forwarded-Encrypted: i=1; AJvYcCUplx3BkKyGtS8s0fSz/rjIgv6rziBtJht1mi9a1bEUQH/1aQMuRLH7+YL13XYbpkEqWRlZCO219QLoxHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRLMFaYSXvqsIn3rsXo5PfG2KhWq5iIHRiv1tjECF3oioZJyf
	mBQ40OsLm9xyoXmRm8pxViLYV9IK9YSRZcrjdfkqbxdpHI3jEO3MczI6
X-Gm-Gg: ASbGncu+shk+H9Uxr0rtUlB5pF0RwrrqTT7IdGaEm4fKYQb39iq6Rm6awAwMZVEkWsP
	9NkIwCPVKml4ozOP1tjILRmLtkniVgOKVJYKhb1q6zobuDXGhisRtXQMJZ12b/s+WsiAq1NrNa3
	Ngh7B5LHerh4bMXlJZeYdTwwxSO6mXfkSmPNesFVqDtav48IsDmW4B63671Ur2XJjXcqlQ/ZNJk
	Bb7bMP9/zVW4yDJgJrBTKvgZo9srjGiQhAROZ9fU7tcjqovMc5CJ0kDskrtyMC7vMxmCaDOQ953
	Olzp0lu7mi7/Bfoz7i585g+GrBILUJJLS13CSk5zNEuYDD/JZqDlwSlGmkX+F/CEuuWwfmwCUoz
	rydc8Zd9e0xk5Vt6Q4X4+4WTJZRN9mYDNXPE6XZ5zyi+pb991jcV0sUwyChjH8jt76bWrbMDQzs
	tfkcIXyEPdcESPbudfPoRNL1WH694Gibf2OldF7JXXKT0pTBDbkiWJu3vPG8hYYzIkOMc=
X-Google-Smtp-Source: AGHT+IHM0dXW1VRWqhRiVfcoEs6GQopp4oyXYkqGercKeVItyykRTOO9GHk+xGm71DB98UvYkBTNpw==
X-Received: by 2002:a17:907:ea7:b0:b6d:2d0b:1ec2 with SMTP id a640c23a62f3a-b70708315e8mr915496066b.54.1762078088750;
        Sun, 02 Nov 2025 02:08:08 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a92c9sm703313766b.22.2025.11.02.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:08 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: dsa: b53: minor fdb related fixes
Date: Sun,  2 Nov 2025 11:07:55 +0100
Message-ID: <20251102100758.28352-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While investigating and fixing/implenting proper ARL support for
bcm63xx, I encountered multiple minor issues in the current ARL
implementation:

* The ARL multicast support was not properly enabled for older chips,
  and instead a potentially reserved bit was toggled.
* While traversing the ARL table, "Search done" triggered one final
  entry which will be invalid for 4 ARL bin chips, and failed to stop
  the search on chips with only one result register.
* For chips where we have only one result register, we only traversed at
  most half the maximum entries.

I also had a fix for IVL_SVL_SELECT which is only valid for some chips,
but since this would only have an effect for !vlan_enabled, and we
always have that enabled, it isn't really worth fixing (and rather drop
the !vlan_enabled paths).

Jonas Gorski (3):
  net: dsa: b53: fix enabling ip multicast
  net: dsa: b53: stop reading ARL entries if search is done
  net: dsa: b53: properly bound ARL searches for < 4 ARL bin chips

 drivers/net/dsa/b53/b53_common.c | 15 +++++++++------
 drivers/net/dsa/b53/b53_regs.h   |  3 +--
 2 files changed, 10 insertions(+), 8 deletions(-)


base-commit: d7d2fcf7ae31471b4e08b7e448b8fd0ec2e06a1b
-- 
2.43.0


