Return-Path: <linux-kernel+bounces-832524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2417AB9F928
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FA8177ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41098239591;
	Thu, 25 Sep 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR3y7+40"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7C233D9C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806924; cv=none; b=lbYX67kOerK3ea/tuxw8FC4rfqLv9MxXUyn5Pc5uMOGeSQ3MXrzPmYTVlr/YVFD+CyOOxcV2O4muBsec8yjo94PbL74K1uwWCm1B118nxJRfnU1CA63lHexCkQiMXNrRufOOIlNwvJaY4PobGApFmYeHkhKYxVsPKDwpAd2w30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806924; c=relaxed/simple;
	bh=WNzxPrFin73Lh2ypAKh0zFTGhRAVwxDD1dobdQ9kdBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPZbI5zGpUJfECaymtWo3OpyRK7YnnkMWVlcmg6OEFFWLeDMWweJ3eV9bHpxFIyMnUtG7lqljkB9hHpViwCQM6ioD2B224ZCfN6gIEORmCTLW5vOK8LqW3VQtoEadSEVLo96VOXuHxm7hMpSv7+6seo3cLOjw+wVpnfDw1gNyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR3y7+40; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so1877602a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806921; x=1759411721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIjBW0HGJ1nhvOGLp1W0sfAHAgMMEq0zVvUkf/NQa8k=;
        b=AR3y7+40bS4vLrdByw6VpDa3ZXTdOXtstO/0xWrva5oNUBYV5ZtTRdRvK1RlMecLX3
         /UgFk5Et6I/DGiI2jid3F+kvfNLBuY5laGTMPcojrOY16dToUiCWmakcyffT2hLJjWTa
         Tmt5IiUL843rxtWTgMZiRBoQsTtNzbOC5Ccp+qrbB7SPObD5uR0ago8OyTXOjmL0C72i
         OE8laPZApuUHi7fVlbTlWCUvxH+FrC40VjtKViWGK7DI/k+K0H4Cd1bSGli7zft8kK1B
         XWiTx+DXqGgxOMY7fUt5nZM1tpPBhxEvmH5RcCASSaIO3Flzx1uRDG8v6weWbvScX3aD
         WzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806921; x=1759411721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIjBW0HGJ1nhvOGLp1W0sfAHAgMMEq0zVvUkf/NQa8k=;
        b=h2FSgU+hUBz+3XudHcArUwweDaodZb4ZGHIVQAkjuUoQcB+BaL11nY+jOwmThUVYhC
         bs5XBRdlvfpsbw4grrg0bKeXm4VWNa8hy9jxaiyyrvRYLnE/6TgakCnqEjO4/Fm21WaH
         PJs+Po3DiDH0QQIhfc2NAznRes819iYmkB9EqCdSuH5B8X6Qn/LuUerTE7OTS35UO16Z
         EfnUy2sGtF+zXafb8/PUHwJ8mglUHsF9+IdWXZM6/Pr5aMZ7G//Td0lIszUxZ1SNbPyw
         L2pcmYdCMSWs/KDpc+o0qvUcHfaV/OQqks6ZRZsGLVD4RNCL5Uad+MDyjuKXLWtg5AjO
         izPw==
X-Forwarded-Encrypted: i=1; AJvYcCUUa1ctttKeS8cPNwiRc229LocZVXUL0g2nRydrG5cgtl4npX8HNWqqzu/BBFoASvgcJNYf1denC9fdGEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqzvnGKs/sObW7d6GjmEx102Q2VqQ8WIWEPBHcEcMHV7a/cIZ
	NDx7JR82vygmvqVIMrJG6SDkOHJKG6VE9vsaS+O5qn591wOpc2i10SnK
X-Gm-Gg: ASbGnctUB/eGcuspAsARaovMxkPSmDnuwsWPiWd0si9thOnWfc4dHuWdZeR7yqcg366
	rAjg8jMQ4EvCw8j2gE01SERUd6JnHmlRnLVuejMDZ7nRlcKKYMg5yfYny+IMUXLvXg+rmnDSzmm
	ToNTSgMcM2546giLu2gGysKW9VCyySbA3TWuM4KqlQ0M4R17VCgY5PNehQrvpbNtxdu74/1DI8D
	5s4Y4cOEfqMC3B4/oOGfJKVJzRcn3y28Z+s35x5pHTPzh7omPOmG3JYMD7YD0FlZnbAB43yfTqm
	5f4fjXVNyo7wlkR3qKtm2owiKZIUGHOi+yCEU2b4deLL1ra2ihHE+szIMEp8/a5U89yr1ac8KT2
	PArgVCRQxuj8lHNoWQ9ghJCTWh09O1QBnYLwpdNeoLKOGE0M2j4VB7aD3sGZhHPgJLiA/YZYOmi
	3+xvynXQ==
X-Google-Smtp-Source: AGHT+IE3bLNJPUzSKiXc9lkzEM/Izf2jTetxO9oV5D9S6+ZprF/oHUQ3nKipbH/bpNZu/lVBwAtFEQ==
X-Received: by 2002:a05:6402:348b:b0:62f:32c7:6c2b with SMTP id 4fb4d7f45d1cf-6349f9fad7emr2672620a12.11.1758806921247;
        Thu, 25 Sep 2025 06:28:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b02d8asm1185354a12.44.2025.09.25.06.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:40 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest: net: Fix error message if empty variable
Date: Thu, 25 Sep 2025 15:28:23 +0200
Message-ID: <20250925132832.9828-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix to avoid cases where the `res` shell variable is
empty in script comparisons.
The comparison has been modified into string comparison to
handle other possible values the variable could assume.

The issue can be reproduced with the command:
make kselftest TARGETS=net

It solves the error:
./tfo_passive.sh: line 98: [: -eq: unary operator expected

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: edit condition to handle strings

 tools/testing/selftests/net/tfo_passive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
index 80bf11fdc046..a4550511830a 100755
--- a/tools/testing/selftests/net/tfo_passive.sh
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -95,7 +95,7 @@ wait
 res=$(cat $out_file)
 rm $out_file
 
-if [ $res -eq 0 ]; then
+if [ "$res" = "0" ]; then
 	echo "got invalid NAPI ID from passive TFO socket"
 	cleanup_ns
 	exit 1
-- 
2.43.0


