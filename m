Return-Path: <linux-kernel+bounces-895926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BBC4F473
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D74EF773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017A3A1CE1;
	Tue, 11 Nov 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9gWrBzg"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DF3A79DB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882641; cv=none; b=O+2QBURwWcE6pr8IKhXD71UdGoVg/EspFsHJF/2J1uvPhswTCJ3rm7+9SZl8L8ca6IiEYzgDLeHXiNyXavjRafuq4XkwI8OZWKq/Mqrx7M3L06z4Fvj6XUyvZFN8lVTyp+F/Zbny5XQfX3DA7VwZqhiYDsUt49VEK14WO63lgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882641; c=relaxed/simple;
	bh=v4utIXrGPO0sA7nXHFb3vZKgGk5MC1ei180wMa/JNNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCYJuEkc4knggO5CmW0ijpozy5x641QBTm+/szK6bMztxyO+WDLmnbUeG9rGi0kyDc4CJLQ9XWcML1vtQPMojoZ8EIbOMpZILswqkuPTLUlDBDPeg56AytzLrmPkiXgliEEaAZg504bIpxhSwVG9/2FH7QFcgeOPsQMiOryuTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9gWrBzg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso3747449b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762882638; x=1763487438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92lvhA1uO0aM+xNDx/dzqlukLaPSJhYkX2A5buR2l8s=;
        b=R9gWrBzgsbRuIbwXLDkn/F4rnio3vDczk9qU92fX9u/rtnME2+aPyvtki878y59vgS
         SCz6ZBJORxnFbJuy81JRztV1nl8NTrZznzidZOB2Q5xaSoEMJR2xChv1X5TEuoEIkZfW
         /nlpzZ6/2UNOyW+DbycI4vOKlgkhnowZG6W3zVmEkqxqUTjoWOreK7Pvv9j5a4oyspBv
         GLKGiPcsxp5sdADY3mYEjdZD6LmR5pG/i3INREAo4LyWyJb8pq9Til+wdCtc9sYtgWf2
         OiKKgrG1AZ6at/IgPsOYaeNNIbOvE0iRXnohJXKy0E/xEbBzPzmJf9Hb7O9KUzXtz0Dr
         Dfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882638; x=1763487438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92lvhA1uO0aM+xNDx/dzqlukLaPSJhYkX2A5buR2l8s=;
        b=MxNnN87n8tO42kYpVL34MKyzir1PwJqCttVyAmCgCQ7h4+W1AEgQDEZO40YcwPNpmF
         lS8xPy647C7kJ7lR4FKq5GqvpyAvHHrwo/86vOdr6oFZq240hnjVdxj4WmlEgW1BkvUN
         9hH/ry4cO364AXkO0hquCLPbPcRN18pjcbIi9rvzTFf3VMUzlA6L7d7DoAZsI10KVFMS
         AkzLCdPL6v3MNnALMJniIWGBS5Q0C4IkHdn3QIZ+YsEm3Gr2sNpbd1qcfp2BfbtoCv1a
         7qSY5YR8dRA8/FG5mVnxLVAmJ5nhkwN6rjd8l4GuOin2/KkKRtUsVcPNpC9pXIpkRm+Y
         utxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5UiYwy8LwiT5rkAwdcE4cW7ZRdl5Qu4yCJT7PDrsHdneUFGuX92LLEFP3JQZU5Q59VwK+gfp4Ul6QwYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnO6nrCrHJzbAb2MklAf4V7Uoeq99cZL5c4Nx9kiM+gOZw3lKv
	7m6IWJ5AjS0ZTeuFTAa3OYMTBXtC3YLKSRNdj689uBYy6QJ4QF80UVto
X-Gm-Gg: ASbGncssooRjHQ9ARRdfvRwVv1utsUu4Rk7RMFiyORlmi/plCcXlvVnPFblbm+80fwV
	JYf9habIAY43OSlkSR/CVcWGw76uYFHhfVgHuRyhsVCwZ5bNa3KciI38TEnuGBVzg4rGNtz5d39
	ZdMag6AfTaOqmBHj5/k9hCyHRBmvY60yzWtgHiQyvJ3m+wD3mt5tP3dw5MBJ6UvGTjw0C5MdP81
	MA9no00afa8VJx7yuui03NYRtXufzcIAoO4HmPwtIc6FQdeSnrUMGQkrtYUD/6cn9RKAczoODxp
	/F6k2xxE0CeA4jUM1U3pC9u3sidWgmrlnmhgt5zmZvtgIRq7KlfF7hdO80qQXuteqcgRxY3clKn
	UxmpqhXL0A0Hy3FHLE5KP9HkdzNvmbMlzbrqfYbCLaCDpWOgPfEl38rV9MYWajdvJ9diFxt9k3W
	ikkA3kXMCvF01/FEbIwycGQQ==
X-Google-Smtp-Source: AGHT+IH2iWBeq3D6E9p+kun3mwKnF/bmIBXmiiPCVLGSR1deRp8cx5W3pTb+DFeUYrzkmVeK4pOdrA==
X-Received: by 2002:a17:902:e78d:b0:297:ef11:b504 with SMTP id d9443c01a7336-2984ed9ed53mr1427775ad.24.1762882637468;
        Tue, 11 Nov 2025 09:37:17 -0800 (PST)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf10c9sm3162625ad.38.2025.11.11.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:37:17 -0800 (PST)
From: Jiaming Zhang <r772577952@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kory.maincent@bootlin.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v4 1/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Wed, 12 Nov 2025 01:36:52 +0800
Message-Id: <20251111173652.749159-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111173652.749159-1-r772577952@gmail.com>
References: <20251103171557.3c5123cc@kernel.org>
 <20251111173652.749159-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool tsconfig Netlink path can trigger a null pointer
dereference. A call chain such as:

  tsconfig_prepare_data() ->
  dev_get_hwtstamp_phylib() ->
  vlan_hwtstamp_get() ->
  generic_hwtstamp_get_lower() ->
  generic_hwtstamp_ioctl_lower()

results in generic_hwtstamp_ioctl_lower() being called with
kernel_cfg->ifr as NULL.

The generic_hwtstamp_ioctl_lower() function does not expect a
NULL ifr and dereferences it, leading to a system crash.

Fix this by adding a NULL check for kernel_cfg->ifr in
generic_hwtstamp_ioctl_lower(). If ifr is NULL, return -EINVAL.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Closes: https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev/T/#mf5df538e21753e3045de98f25aa18d948be07df3

Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 net/core/dev_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..8bb71a10dba0 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -443,6 +443,9 @@ static int generic_hwtstamp_ioctl_lower(struct net_device *dev, int cmd,
 	struct ifreq ifrr;
 	int err;
 
+	if (!kernel_cfg->ifr)
+		return -EINVAL;
+
 	strscpy_pad(ifrr.ifr_name, dev->name, IFNAMSIZ);
 	ifrr.ifr_ifru = kernel_cfg->ifr->ifr_ifru;
 
-- 
2.34.1


