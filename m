Return-Path: <linux-kernel+bounces-814682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB000B5573B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B1F5C5EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED835690D;
	Fri, 12 Sep 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv8bvXwn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FB350D49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706854; cv=none; b=QXgpg4i/9R4evSKbE5aFs5qNu8rWN3199pElGbNgtCKQ2vOF5dTs4YoDNb3OYdHpS6G3qT0d5Wj2bKuAKXXf7BPGBznLcv6sB5bCtobkZd9w2cSoZ/S1odHXyPlNIVf4LhLBU9hHT/Vhy8FAQUc5eStXNulxB2GrkW6lgiu+nwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706854; c=relaxed/simple;
	bh=wyOfA9Z4qZjfSNCnN1Zoeu2Ob0/D/ATgwmgGwmRhB+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwnGzbaMdiIOC7bFaYDtTIXEAXuDP9ySaxDYmf/eRTKKiKUtXy/z0CkcMOG/f4uX6vJBnzGSYVsTqyadZVJFtYtLA53zNkJpv5Jek0O1GzK20oue8PEF79szjkDIJ/eSKHojnsmlJ0IsYdsZAkK1c35gcaxKaOB57i3kNyUrJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv8bvXwn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso23917675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706851; x=1758311651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL67JfuuY9SGdztk1CnmGmCEi73VTYHhsmgmXTv98L4=;
        b=mv8bvXwnZbyDXMRxWeCJ6EOm6yfmLYsAFxTw1/nSFFIJJOoMOt8QL01FLf0lkQCp/1
         bocDdq1cWziNX3nbLYu8uF41JaasPlg28rnnxI/cT8whJg/dG7RUmheUjpf1XWCXo0+R
         Mwny2WT6MHWWf3hKVbCKj3xpgSpmrKMPuTrYYqEA8BNQKbeIP8KXL5ECZ2k7k9z2PtpM
         BollAa46Kx4aUnkbrJ8Q1l8YNtI0Kwe6xyBmsx7AZrvjmiicXERzpkevFZnhcrXogfYF
         y7mn+7eJxgo2P+71/VkIlW5kZ8TgLHP+ycAKNo6qpAtopJDuVazvReGXQO8xgX4h7Q3E
         e5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706851; x=1758311651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL67JfuuY9SGdztk1CnmGmCEi73VTYHhsmgmXTv98L4=;
        b=KOt4KkPk77nKYPnN01HqZQsl3E28huVTeRFO0FDqEwoysEkVDnrJU4Tnk8+NW531dp
         vCQF3hsdgnbtBxMlH3KKUE9nKyHHOlVcM5iV8DRDGEaegkEYCsfRlj2N4GNr9gnpKMbl
         tEmqBqbcsRs4F+w4WwUX8aZhKEcQVn5KBY2pfSrgQQQzy+5Rq1YCBL2shJWpFH95DsvC
         P4+KDB2XAKHU43FLp4fnq5w1Sd4mv9iMd55/gFly92gD6Y6aPCK8gYJoOSbgjDot3qTj
         f3FfrRSNfMqqSjxBAN9STLjxPcJkCiU4pi110jiI4NgAX3nyTBrKP6PovxsJVlLSvcyZ
         HHdw==
X-Forwarded-Encrypted: i=1; AJvYcCVdEbzDTmXGHK/ymf5Ub1I0NXkv43aQ07ePiqRiMm/41D59CHQiN3ghNlPySuAiNw0KyBIuEVvOJ54JJEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoK9MNGEWyQ4cU1wXBGVuDQco0DLW7LSgSfe6IwxKJxYCRcJKz
	Cw1JL/BzDictl/Fn4jRR0lbD3HneOSLy9KFVHsjiB1R1vW1sswW84q7Z
X-Gm-Gg: ASbGncsvWpCJGB+5IFo9Sv0Lwx0z+Pn2uAbJ3bImgpG9kbWXRnfIAlDUqOl5fsKppVe
	vRq6WAbVu/F5JabfqNHTnLhej8IktaOIhnDKQ1581wZ17wOtVVMwF7AxiWappgqTNaoPAPEE+GA
	grVIdCNbCzwqwCnGtEhNmd3iaXxfnKJOE1y+gh7ubsNuf/fVUEh0R4jpgdhqmRKpb7sYd9e/AEb
	Vm+l8Yysu+N2bchCMpVhzNPgz1NCaE/Dur66qWm3id3AqEMe94RwTPFuEcZyQ0mFJHdGspAYpTs
	JIeSKlMsw2B/OR04ssVuy2a64IWwi1G050hrVtK1NQlx2XfGPvWD3XCeRH342iyC+GizhljhFJJ
	KQ/L++aoX0tM4S/GYiQDGhGGBunJdQ40gsDCjdkf5R/yPFntK8WsA2rM8Zy6ypXqz7eynU5Er
X-Google-Smtp-Source: AGHT+IHnxAVngHZQRsePAFq7iynBLmIa8Fg7O2Z7VTvuVafjtGYamzNuY+ON6/+Ls16YAqNHgZJRXg==
X-Received: by 2002:a05:600c:350d:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45f211c9c3bmr39664915e9.3.1757706851085;
        Fri, 12 Sep 2025 12:54:11 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:10 -0700 (PDT)
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
Subject: [PATCH 6.1 13/15] selftests: net: genetlink: add large family ID resolution test
Date: Fri, 12 Sep 2025 22:53:36 +0300
Message-Id: <20250912195339.20635-14-yana2bsh@gmail.com>
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

Add test case for resolving family IDs of large Generic Netlink families
(those with 199+ multicast groups):

1. Tests that standard genl_ctrl_resolve() may fail due to:
   - Response size exceeding single message limit
   - Implementation expecting single response

2. Verifies custom my_genl_ctrl_resolve() works by:
   - Using dump mechanism to collect all responses
   - Properly handling multi-message replies
   - Correctly identifying target family

The test validates that large families can be reliably resolved despite
kernel message size limitations.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index 0a05402caa20..361840aae918 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -1142,6 +1142,43 @@ TEST(genl_ctrl_policy)
 	nl_socket_free(ctrl_sock);
 }
 
+/**
+ * TEST(resolve_large_family_id) - Tests resolution of family ID for
+ * LARGE_GENL Generic Netlink family
+ *
+ * Validates special handling required for families with many multicast groups (199+):
+ * 1. Standard genl_ctrl_resolve() fails due to message size limitations
+ * 2. Custom my_genl_ctrl_resolve() succeeds by using dump mechanism
+ *
+ * Background:
+ * - Kernel successfully registers large families
+ * - Standard resolution fails because:
+ *   * Response doesn't fit in single message
+ *   * genl_ctrl_resolve() expects single response
+ * - Custom solution works by:
+ *   * Using dump request to get all messages
+ *   * Searching for target family in callback
+ *
+ * Verification:
+ * 1. Custom resolver returns valid ID (> 0)
+ * 2. Standard resolver either fails or succeeds (platform-dependent)
+ */
+
+TEST(resolve_large_family_id)
+{
+	int family_id;
+	int no_family_id;
+
+	/* Test custom resolver */
+	family_id = my_genl_ctrl_resolve(LARGE_GENL_FAMILY_NAME);
+	EXPECT_TRUE(family_id > 0);
+
+	/* Test standard resolver (may fail) */
+	no_family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
+					 LARGE_GENL_FAMILY_NAME);
+	EXPECT_TRUE(no_family_id > 0);
+}
+
 /**
  * TEST(capture_end) - Terminates Netlink traffic monitoring session
  *
-- 
2.34.1


