Return-Path: <linux-kernel+bounces-863470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD7BF7E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E37C3B422E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1F34C151;
	Tue, 21 Oct 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne9DUyQi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2C34B692
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067933; cv=none; b=neg8tPdJifX3CT9PSx1V7Zh3Ow7FbbDcrqqoNtJHXseH5MWqTwjRZZqfwCOycoyG61rLQzEOQnZ3KQM0X7An0t9CCCtMYufiOtPEMgZev9r16TDEmo3thOVgIIp+vBcooTezTJ8c6ED90v0XAowz4QLhL96Of8xxRtrwV7dqfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067933; c=relaxed/simple;
	bh=Z6X3mqZcPYraf2DVQKy1+mGtHY5lO4bJYnXE5CeEFvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCFjmNeeEUkmDkYq/CQjL8gK0x8qMnC1NADMxqWSzF6SQ5SdPP25JH7XvH2H/1eqGZ98j2BANaqwqI2oE/BhxqanDYzbLO6lr7g0/vnpiBfOFqkcTxwuyT59ul6mXRVTxFMYvSwwdw2e5si9pHB+1GADn8bsF4SRshckkKdlgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne9DUyQi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d3540a43fso62112085ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067931; x=1761672731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ+zArbjDCMGCO6Bvb9dufDVd7PF4/gLdFb+sRMsH6U=;
        b=Ne9DUyQi6jQQJwWvr4DrlTjDDf1bFrIXEOf1fa225G4PlaxZmJZWTVQJngmFQ6GDpN
         BUa6Z6RPQHPTecOOxP5BSLVNvS7rRSljLdFMMbqHjG4u/x/Dg+WiFQQjmIqFPfGJwLgV
         4D4SO3XuuwAn+8zu1a5j86P5ea287pVTUbMWfntenWAuj6ESrPj7SIJOzlu3jyKgFcMn
         Yh7jQo0wfvYUdwNvDwHG0shHbi/+S3AQ6sVkMLaAD/n+UY8c9mAWxWjDuuIqhYvpyAu1
         TQmunr7oCRfmwvE6ghPBcnmmuFjtQxf2lSmkYNZFEkFFeI0oyRrZlVzNn/Ko53d8jE5P
         eG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067931; x=1761672731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ+zArbjDCMGCO6Bvb9dufDVd7PF4/gLdFb+sRMsH6U=;
        b=qCywQIfKpCuv8cVDHTLpd4F/qyHXTLbCFVvKwm/btYh7JiJK4MAp6y/NboSMFuQHLr
         ntGiJNddeYx/S9CxmiHilxx6QpvXayR+/HTwixP82yPGQoa318vxPqtgQ4hdueAdmXoy
         18KZzL8UImvJuagiGUeus1WfaQsp5CoDbMltFgj7Kp0JYiVzclhqWucfth7mcrHMzxde
         8swfx2swjwQ4Zirr1HXm4Wi/mw9wOTW4wfuk2ahhZ093sAYD2ghGvwAMF+O3etTuhTSv
         n1kFTkvP/aIQmlRC2CAdVxO+A9/gdGjwMKNATbbRdkikzCxHgHLlJKL8n8akHHj5x+zr
         d8pA==
X-Forwarded-Encrypted: i=1; AJvYcCWPrD3mxIr6Ii3PkQ+u1POXHmu3wKhaiX4KczqMdjGYCAON93sZ3ZMxNGDNgWRVmKG1aje076CzR59Z12w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QtV9CTZkKh/zJLDPu9qNQsOx8RbP5fYOwoLGwUMMutuO0uD0
	VPO8t60uePxPxrZHcM22HMoM9GcYUR80DTvbq271ZeoGkCc0xXaNe/oEs9bYQa3c4Mo=
X-Gm-Gg: ASbGnct1M9KfXG/SQW/4p6FvyI2yXgKP1im8BJbp3OE58IilrasfY8ZYKLQyKa7IdxF
	sx3khrcfO68F96vGTM7/bFpSTFI2Fp4VwUOIkHwXzrCJ3xUfq+OgSXbGbmLyT9YynHRwHZYf5e0
	CkWFArbXGqjDV37b4PP+KoiaaKq9CTehCB6e9WYmOh3jZCyzkoTQLSm0/smiiMYp6e/6s99gs5T
	iFQ8jsSf+hzsdIfokuRx9SqEB/+kbeUz3Z6xC1MDkzco9/Pg65cFoe0WEuV4gFdjZYbggRVp/Da
	vqUUVoBz8HN4/9orQXw1jMzy+ipIScABppSQEpI38rsSv6A/usHfAfF048Yv07B4hDrqC3gobYr
	N1xYvTyOq1l1QuunGuJG5K6VOX2IM5W461UXnbLu0LWPjPrlLESRCYkWbHsVyZWAdmbPclWS6SS
	zZz2mUNMPewRcBsA==
X-Google-Smtp-Source: AGHT+IHBTh8hb/ic48yiyeOWMvVLJaZLWfjl5/Ft3cSUM4e+h+FFQOTWZmBhfmoXN8HdMJnPfxcabQ==
X-Received: by 2002:a17:902:c950:b0:292:fc65:3584 with SMTP id d9443c01a7336-292fc6538acmr13530505ad.50.1761067930650;
        Tue, 21 Oct 2025 10:32:10 -0700 (PDT)
Received: from 192.168.1.4 ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b346aasm10941006a12.20.2025.10.21.10.32.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 10:32:10 -0700 (PDT)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v2 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Wed, 22 Oct 2025 00:31:59 +0700
Message-Id: <20251021173200.7908-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submitting v2 since while linting v1 I moved the ntp definition in the
wrong place. Apologies for the noise.

Link to v1: https://lore.kernel.org/netdev/20251021135913.5253-1-alessandro.d@gmail.com/T/#u

Changes since v1:
 * advance next_to_process after accessing the current descriptor

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: 49d34f3dd8519581030547eb7543a62f9ab5fa08
-- 
2.43.0


