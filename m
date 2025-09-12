Return-Path: <linux-kernel+bounces-814683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0951B55740
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A943B5FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1F35FC05;
	Fri, 12 Sep 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfp89k+a"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5E35A2AF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706858; cv=none; b=UNrMySsjUU7ru0JGp2ZPHA8bCiAghSNoxOsE8RyDN/szFp0M3126gjPlHjPggdRMo55CySmGrlmDVTNiyU5AOHB9Wu1p+7MpFtY37Fvu1lck53hh9jVzBNBNlTk3lC7ww+aCgr1EvKbIsYwTbDyQf9y5zWxFMBaePh84MX7RGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706858; c=relaxed/simple;
	bh=icbkvjvQJUFVCkaCJXhVHTgOSqoKQBetWKx3gQY2/kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ig4kase4jdaTMgLpCaCS/dBY3JmOH6nHlLe9CUw41u0XCmapo5PH4bYNP/77OyCdySKtjmccx+COQwjOEQrdP89ZDTKgZInEXNr4GnXj29e2h6xt81YHlVCP5qgFrgNWUj7gqBjZLNjB42bYBVGWzkbWzvVlhAgBFdJxsEgBsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfp89k+a; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3dad6252eacso1016463f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706854; x=1758311654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb9o+yLyjF+OaI0yOxAbCTZnd+38YkRAXuvGtFeqK84=;
        b=Nfp89k+az3mXppfv9w5wgN+4jCy1oi6QTALBueEqIjMUhJNjUrajkNJwFZ+uOyKGYi
         C4L0hSz4pPnDNyg/wqofjGGh1SdSEIOZFrgpjTtu2z0pMGliR0lWfb4zCNeKnFw/V+Mo
         PEGR7w+Q7zN54Iw498IuN8UHuY6Go1clnf2PshtIkWHZeUrb8SlXQhLIY2ON5+E6o1p6
         65V+NvUNgj78FCNpgtM2veRU3OKtgPKnSiEafjilUmakXuArzBf/G9Isc1C0T+mEUoLh
         h6FEcKTabTdiWAeVekhMJdzria00VWRuIY8nasVnLcfSdYp/Aw4qRjGKAiXkhkvWI/Lw
         Si+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706854; x=1758311654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb9o+yLyjF+OaI0yOxAbCTZnd+38YkRAXuvGtFeqK84=;
        b=ZG+EqW27L3YRo7Id7OJqPewOLOY5ydPYLsGOsGT9Fbs5y9dmSPDfEJ8dmxMwSDIcBv
         j3Dq7pG4D6RuqmZfDOOXf67N7C027RGEpltpPgX/U8HGtSHPxdsWpjM0IRP0fdy02Lu2
         5V0jopWEs3M5tYKwkJ5FUg2w+dNOz9CvQI1VkW9eUNo1KqNJFpanQwaRSsZdjbUYtg9N
         1dWhThn/171mxvQGM2X8WkpsEhz7A+kaRQv0jx2XaTXaSRTNmP0JxEMvPi+Hzhx7/LBV
         tEEMWvflpzDrVEhZ3m8VPRyRUlBwvCy6U7O5+cvandk5A1a8YoxAVzTu50jPQ6GLkIT+
         uSbA==
X-Forwarded-Encrypted: i=1; AJvYcCWHEAXpE6iUe42CArJC9rN1/wLoHAh0s/83WjAhCbMMflzrmvnfuAlz8UEHh98MittC7Fh55YZuW5rmiAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0yUYeeOpdD9N3eMPPhsJVw7cecxqaeDR/YCR6eXtrqmTR4fq
	dj63EN+8DT51kIaoz3NfrVtzhBhlx+eh4cN+GKgBr/NSYAM5gpQeHXzM
X-Gm-Gg: ASbGncvvcvnvGan0qZPiABwCdl4Vk74NVBhn8OrlCz8MpB5pq0Laclg+bPFw8cl2hOD
	3xaLxlwzCDPcwyW2JB+TPlfdoMVUFtoTYU12QPScsORxzQAVtrGJhniE5T+btpDCLW+tk5Fq8NZ
	CwE0RpTfubuk7TiZpW3W0Nc48X/79xaDXl8InmF3VRacA+2rcH7+l+PmD3/BJfnlSBlF/ijIHF6
	XV3QQn/DnptpVJ4h+IK3wSEi4hHJGz4qGAj1g+6Z2cGS5nxmctJcgJ38fYilX8X2zNm/atAzkZg
	9LQBUi/H/sa/aej0sNcZuqNp6Nz2jaiBXtSl4hW9DEEUs5pql6aNpOxxjU8zYa1WvqWWgHtmYQG
	D3SulVkTQJHYhWw0m6y3P8TvJ6aMWtdMHg/eUiy+FykRKi3vJwJwWtKHHvPTHug==
X-Google-Smtp-Source: AGHT+IGDemjaEgtgOCoyvvb4Rw0Ry/Drus7N9V4sjIQEOXHnP0EXYeoSrzatSrGttoH5W/PqCe+s8g==
X-Received: by 2002:a05:6000:4023:b0:3c9:3f46:70eb with SMTP id ffacd0b85a97d-3e7659f3b84mr3972483f8f.52.1757706854322;
        Fri, 12 Sep 2025 12:54:14 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:13 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 15/15] selftests: net: genetlink: fix expectation for large family resolution
Date: Fri, 12 Sep 2025 22:53:38 +0300
Message-Id: <20250912195339.20635-16-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correctly expect standard genl_ctrl_resolve() to fail for large families
with many multicast groups. While kernel handles large families correctly,
libnl's resolution fails due to message fragmentation:

- Responses exceed single message size (~32KB)
- Kernel fragments across multiple messages
- genl_ctrl_resolve() only processes first fragment
- Returns ENOMSG instead of family ID

Custom my_genl_ctrl_resolve() handles fragmentation correctly via dump
mechanism. Change EXPECT_TRUE(no_family_id > 0) to EXPECT_TRUE(no_family_id < 0)
to match actual behavior.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index a166f2c474b4..8a394991fe32 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -437,6 +437,7 @@ int validate_cb_ctrl(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	case CTRL_CMD_GETPOLICY:
+		;
 		struct ctrl_policy *exp =
 			&data_ctrl->expected_policy->policy[elem];
 		if (attrs[CTRL_ATTR_FAMILY_ID]) {
@@ -1485,7 +1486,7 @@ TEST(genl_ctrl_policy)
  *
  * Verification:
  * 1. Custom resolver returns valid ID (> 0)
- * 2. Standard resolver either fails or succeeds (platform-dependent)
+ * 2. Standard resolver fails
  */
 
 TEST(resolve_large_family_id)
@@ -1500,7 +1501,7 @@ TEST(resolve_large_family_id)
 	/* Test standard resolver (may fail) */
 	no_family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
 					 LARGE_GENL_FAMILY_NAME);
-	EXPECT_TRUE(no_family_id > 0);
+	EXPECT_TRUE(no_family_id < 0);
 }
 
 /**
-- 
2.34.1


