Return-Path: <linux-kernel+bounces-867770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34921C03743
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C935B921
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61754276050;
	Thu, 23 Oct 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPTBPTQi"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8A25D1F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252847; cv=none; b=ZfO/5kGQbUsH5PUIh0jH0BwBFSfK+WG+y/K9mmOkoexv1ZHhlQcSv0KnJyvrgFsW/QFUhrMHJuUKVPww7WdEm5f1T26EwBM/poNvH+p0jf99pjNkkm19DqYAzP0RviqX9b36TiZmoQRCpgNaHEdi0Oa8hCLTtIeG/Xe51qhgfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252847; c=relaxed/simple;
	bh=hklffgyYK4VMFsD0CdS9XrqoU+fsq1a2y3wTFz4L+Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKwl35cLoDm0bPBgPXZu3eZmop+NIyJMxT42qq1yNvdCjdQMV3TE4GNITOGp227iZQE2grWw+nAblNL/vyY34pAifeu64IZr6e6ZQ24POBQR1xja0Oc0EcGrdsKUVVxtlLdueeIS9cKYmXdtvADSB7Kda1Z/TaUw78t0W/QawJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPTBPTQi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1131865f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252844; x=1761857644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcTYeshnmr2jeZu3uYGRDZUvk+BEhVzCgVA2Gfj5vu8=;
        b=XPTBPTQiS3KAtT2nBIuEMxUpB+mGeaoUnLN2NolR0ku26czbPRyR/orFs3oUBi6PCc
         8qCz32Z9H3gG8QKSuR42x2SGmyLhCcfl8MlfTwbXAEnAdn2lKyQtton8WxQiac9Dzg2q
         2FccvBUJzgvDNtc0AatZlLJ3ZgIbOEChIjzh5B1d4J3IR3A77GFBSs21GHQHCe6L7HYe
         yTx98ms0AL73kzx/cq4CtTLu95gMShBFhOwwyKKD+hjDJ/IskAj1ERlQjgX7/g78tPHj
         qeDo73mDNre1sitSZlYqxYWUfGArvqAHK1iYuk+as6laYhmaZsEHPTLRAtXmF9gB6N2P
         DLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252844; x=1761857644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcTYeshnmr2jeZu3uYGRDZUvk+BEhVzCgVA2Gfj5vu8=;
        b=ZaINF4JPXwlNZXmPRiuhV4gq5fBv3Ld0CWoF1cjGFt5M/4qAw7DoK4PzHIyy34om/8
         ze28WN2mYGetiksfV9+inYQ2za3Sk1nEkB2sEw7O0edWQXZe1FnZG1Yc0s6cYs/+ymMx
         R1jBBTNoF6lWh7DCkubLM3rviyowEAhRsLubCLwhiKfPqmniS4igooFwk2cEeGR4jO8E
         uA3M2eKVROVOccGk7AbfNiF6cxO82RFJ2ROcKtsBb/aK4ZryJUfFuXFUriv3eS9Qy8D1
         vaqlnGPqpAJtjbbVVPvo0Kv2Kom+dL/ZkpzCUznJB5uruxYSYNybQW4uEJF0PvxID4C2
         qU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlaD+opGUyABlOleW4CUZ1e0kFfWSnfBg+HBeZqQbB+58udEQJQDliTMSJY5xtIsY05O2HcRBNcFdsQm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DXuEJkdw/sKw4cOWGOIApzZF3MTdiMxt9l20BqhlrUZdWiMs
	6SES1lPTyGyJY8/EKELh3ohVnJQzWbi+NidSbAdvQy6l0atnc/dRvQPlraVMpAHkhgo=
X-Gm-Gg: ASbGncsVwuiA1Iumug6VNvzbDb6937KzmAmDsqtC/43AMVzRJ+tcSUl2lDwLEwSMeNd
	GbRWClvybdySprBB0Lo2094EStT/hu2NEM6pcK+oTGdWKegRgc1usAB+o5+5cKu09IyfMMMjO1o
	p6DMsp0oZEISyigfqRUUwqcxJ5O/GF1dD6v8yJbm/H12aP2sIuYFtPiykh8N7btLZkKAKwZJc+p
	qiH65q2dqIjB34FQVGjeOlacpeKhGONMR9sTF0n2SglqVm4pFMeC5uAn+H0SdY1TO9EUg8DzXF4
	JvnDyO56gmEVslmG38KN+8jF+qMas6zTd9I1vMk7wA3Yay5lSpYOO3Zcqvc0G8NUZDvQ+rZA1qb
	EsbxPDu5nI1lRm7MDxhcqaRCpQ/ZKVtk9aJRl7YDLfTP46i4cX2/MA/cySLwlbz+47KPRIKJ9k3
	hBdn76wUptPb3WgGph49TxrF6z7B6+dzBgUDVIBFX/MXPE+3P3m+1yqDJJUuuceQhzIboNmD23
X-Google-Smtp-Source: AGHT+IGNcYfvgrEtyv7m+Z6cYdS9youXfDFaSCxmdJXoMuPMDUIma4zmYzmszUwxmllhSMsx0bTfvA==
X-Received: by 2002:a05:6000:26d1:b0:408:d453:e40c with SMTP id ffacd0b85a97d-42704d8efa0mr18802626f8f.25.1761252843821;
        Thu, 23 Oct 2025 13:54:03 -0700 (PDT)
Received: from alessandro-pc.station (net-93-70-84-238.cust.vodafonedsl.it. [93.70.84.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm5658143f8f.30.2025.10.23.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:54:03 -0700 (PDT)
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
Subject: [PATCH v2] selftest: net: prevent use of uninitialized variable
Date: Thu, 23 Oct 2025 22:53:52 +0200
Message-ID: <20251023205354.28249-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix to avoid the usage of the `ret` variable uninitialized in the
following macro expansions.

It solves the following warning:

In file included from netlink-dumps.c:21:
netlink-dumps.c: In function ‘dump_extack’:
../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
  788 |                         intmax_t  __exp_print = (intmax_t)__exp; \
      |                                   ^~~~~~~~~~~
../kselftest_harness.h:631:9: note: in expansion of macro ‘__EXPECT’
  631 |         __EXPECT(expected, #expected, seen, #seen, ==, 0)
      |         ^~~~~~~~
netlink-dumps.c:169:9: note: in expansion of macro ‘EXPECT_EQ’
  169 |         EXPECT_EQ(ret, FOUND_EXTACK);
      |         ^~~~~~~~~

The issue can be reproduced, building the tests, with the command:
make -C tools/testing/selftests TARGETS=net

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: applied the reverse christmas tree order

 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..7de360c029c6 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -111,8 +111,8 @@ static const struct {
 
 TEST(dump_extack)
 {
+	int i, cnt, ret = 0;
 	int netlink_sock;
-	int i, cnt, ret;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


