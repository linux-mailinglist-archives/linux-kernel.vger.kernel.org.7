Return-Path: <linux-kernel+bounces-863675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70085BF8CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6D50298C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080B280329;
	Tue, 21 Oct 2025 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZKr41es"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97C274666
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079895; cv=none; b=HA7ynfBGN6i2syKuBV1Sa1i5rAOKFNQR8JWP26gzloDtHdYu75AeBGtWFKEAhzs7/CfohuoM/yGZWpNDBT+IFqKqsKIBfjVwU7gtV7Q6uizxwRYU2R3zCHxfyOXojg3+4aAMDuV53FuIBAqofyy964YUPiHlaabmxg/eSfTuU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079895; c=relaxed/simple;
	bh=hGOoKoNVTOW1YAQ23TcPbattFNEOGys+peL80o4wjno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXfkbVIZYrbsxNadlTH3VS3gkzB8VdqABG4YtH9uYHxB98Wf9AG0Gna6QHOCwQKc/O3KFNh+91Jf4J4oWxaA2ctUraRzR7H8qoF5+k9Dq1uIngRvNDBJIKLkJhcTJCOm47McrzKhD97Cm9HjktwRatnkzj3mpOWijEsV2M1yCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZKr41es; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a226a0798cso3989018b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079893; x=1761684693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aND1WBYr1CRE6IvHbMXsbKd4Y40zZjrhWpBDu/cAQsg=;
        b=PZKr41es1EEk8ysU8lHfB2FSAOIT0ppYBJcFLZ+ahfAJj5+BPHeFr9pwVQ+D1wIlAC
         AuwaLzIHdt/AP3s6BzePqEfLyCS+nm73YULdCIwhoHZxmXXm2qcsu+6HjsPuzqcWYraE
         c94/Kvnuplhtb5bdg+QUV5PQXdenZJCnIKeTMW/dV07K5k5QXg8tLl8z+bsqi0oqZA6W
         x150OTEaFNhMUfaoHXAIONbe5VCZ52oJC3SroNaC3OLXMhlr8YFkXtzGPdz3b0qnm42i
         hyZ8lqU9wOKHV6oBycHS+YBP5LV6pXO6GW58OzLmp4S2mNe9001h3G2o5anVVKzZpqZq
         pg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079893; x=1761684693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aND1WBYr1CRE6IvHbMXsbKd4Y40zZjrhWpBDu/cAQsg=;
        b=mDByN4W6tUqyQaLCBhxulkEPU1YBBRmc7HY8q9ZBLEwTHn0ISmOV3kZQ2MjbP5BcWY
         VeV0pXPl2jBU7k1FrPS3cUrAbzhcGeWRQ6Qif0LwJu8o3d0dftzbLgfyr61orqjkV8Bo
         8x+bwiMeghKwY62HTOgSRXnCylSdmqWwi2Uzk1FX8eX8SRRyiXXhRR88N3CWxQpuX8Wb
         a1lARamE0Gd8WH0cXwXFPELJRwF5eioHNjvzc6KUaEwGO5BqGsMi2Qs46cwLun3c9NXZ
         giCq/ivWi8YLSL8QQt6OkfwtlZ9ukYcQzb200lKDGB0QiCfaNwpMgmwkFYTWp0EJx/Co
         tqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0X2m8LBWgH91kIEqtAGKjkpZhUgerQxOHlPaXnMO6Cha1zqEzXCnvZhpx2uuk4wCVI4jU+tGStTE/OXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4aJssgih5zyz9CjtdKK0FAMv/pmekXcjLAzCCUQC0K1zgoYme
	8Fe94WZ44wc+as+XqVNLDHY0fks4h0wLKEup9ychQE1UE39gynIWAVhd
X-Gm-Gg: ASbGncuguxU4VBPtg2OaVciMexjDQyDHeYFu5BHUKGKZsUuKu7t2ga2IaepDJQLYz7s
	jEgDWjRpmtNf7/y6wUlXdZdZOLDT9QV99QnrqsxLfn6gz6GFiGPgQwixogB8Q56Jg0LpWGhnNZ5
	dn3qqhEhjgHvUOgVpR5VMyAiWb2wq4Cka2HctHPjtlWvMYjzddrx+5O/pvB5Sd+kLshjhk7Q+7/
	5UMxaW8Sr2b29h7Xgsnc9Hw20eRsDc/+9c+zW/044Oa1FXSKCU/oTklGoQzlF8HSgfphIIEqHnb
	llsj11or8M5h59rxvCJEVEuzfOj+1vWeEayewBgL7mJKA8jFmtl9ZLBoZBbZ7XTL0pJ8ZB7Z18Y
	YkIiRZJfofpT8pNaR/ZnecBJceP2mTbHpzEqtqV93HJ4I1tpYryAG3S6Ws9P8do28P1eCpcvx3T
	RZ1w==
X-Google-Smtp-Source: AGHT+IFiz6JVFNjBfcCoWvWwU1zq16wtIjJD8bjeNOjLDWeHZVY7aaCqf6ep2tUUfMTbTr2KjbLEDA==
X-Received: by 2002:a17:90b:4a50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-33bcf90e727mr27710604a91.33.1761079893386;
        Tue, 21 Oct 2025 13:51:33 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6bf3ebf68fsm7754339a12.6.2025.10.21.13.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:32 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 0/4] wifi: mac80211_hwsim: code cleanup patches
Date: Tue, 21 Oct 2025 20:50:22 +0000
Message-ID: <cover.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all open checkpatch errors for the mac80211_hwsim module.
Patches can be applied in any sequence.

Amol Dhamale (4):
  wifi: mac80211_hwsim: remove explicit initialization of statics to
    false
  wifi: mac80211_hwsim: fix coding style issue by adding whitespaces
  wifi: mac80211_hwsim: add sufficient parantheses to complex macro
  wifi: mac80211_hwsim: use more restrictive permissions on debugfs
    files

 drivers/net/wireless/virtual/mac80211_hwsim.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.43.0


