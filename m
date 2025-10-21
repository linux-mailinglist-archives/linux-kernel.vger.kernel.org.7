Return-Path: <linux-kernel+bounces-863404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B000BF7CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4AF74ED8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA8B34A770;
	Tue, 21 Oct 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNRc5cnX"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D67347BDF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065707; cv=none; b=DqLccU4HwwdGSrTatgoiDTRqcmA2PnWgYVHhZQ94h9GvT5wiCJ7koaEn3rbrT71nIoxUPrajf9vUgOJy1B8rJpG3iyHLErq0XuKoQeAkRJ3w2/FTwp56eu2mP50dqQMaayD0G9W3SrxMoRw1pYlmc7UjyBlGg8MKALezuAu4htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065707; c=relaxed/simple;
	bh=MD15u5LqqmayWloxdzFGq0sNLTBc1b1Ii0ATLOQcv8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qhNFx56vWnC3sWUk0pfIgMI0ZYu2QROFSaicsY+E2pwhv8pNXnXhkM5eZDejfO5bzfTiGVTMZjJl22p3Fnxs6ArtYB3BIajsr4r+lCff/6cN4bwqB8U4GvdrNkNIu9Bf53iykdpwmcidTuZBRFxum53pkj+6CGM1JmPUEIocock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNRc5cnX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso46578f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761065704; x=1761670504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn9OLNMyl8gChDp28IqA1MLvsXpL32JwaHFC00xTtCc=;
        b=NNRc5cnXLfbWheS5JvW+1vO5mWwePGxYnLtn01PAfA8vOtmQgEH3BXpgbYE8SclLYk
         8a4pbZfjxmSgujPZLxwhP4zb96V/v8PsjkxYq1YdTF7DUAnudpRCWr0wK4tJOu59Hc0G
         09WR0FfLVoRl0GkpwNk+vbcDMiSEGpRwRZ84fgxqepsGR4WGySjqrbof4L8qqRsutft4
         ndac/Fn9/YZEYqqiLSXOskn3N0ca1MHiHvZOZQMHxqqE+zgiIlcm5aQMd4QGEx7qktQH
         g1opwS5cWzwg2yrN7pyEQq5CR+69rPX0HDQBjYnXAISKd8JS4rrhIh0DjmEPMDfGXccI
         dy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065704; x=1761670504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn9OLNMyl8gChDp28IqA1MLvsXpL32JwaHFC00xTtCc=;
        b=I/ywBxrQTR7LcKQ5gFxeLDzUFctuD3lxl1gIZ5g6293NMVOsn55/skHu+f1YIlHAJx
         UCbUPzzeU2QElDQNe6NGuKsgN4R6fn7UHAZu1dC6XVrCtdq2rVLyFmVE3by0C4xg4Gdt
         +WCSufVbpjaCEV1EI8/Riv/ftXLT69Axfvbto3qHctrJUw4dN1aqjtTsShD31A4NqlJ2
         wajwzsjzY+0JWjZlGqEDquc0PfjRZo1MJ+BLi5rvmCtjeYx4jNMKMzEJNKptgP9L0p6l
         er11JJ4i66Ynrl32NU+sFCxeNGMCvioZgu9Uzr7xMqdotoUm8ywefTGI9uvxVjEE0bLV
         gp2w==
X-Forwarded-Encrypted: i=1; AJvYcCXbIjA64x5sZXf2dh6YnOLDksI5Ggkb9docOI5B22DWZm2e21FI4G9uY6wLY/bb2yQ5dEoUQmVGJwElX9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SkFzPRZnt4fpjZZmzKqLb/wU4tvaJo0Pyf7P1pypH1YVs86D
	RA+PsAjwhgFrYYee+Ww2aBDwMyPGbiaSrHJWpDJ4WgpXU4tl47VCH2mb
X-Gm-Gg: ASbGncsk5Y7w0ERmjwVG8AVzEHLOB5KXqWC17yu6N/mi9fgKz8AuN4bsl8IbdtnqMe7
	y+wkupYOLozv3NiKUzY1P9lnkblUyeIbLGq+yT6kJIWaM0isgwpVtwRKWOjxwyHCO1vb8Vp2qkq
	7QRmYKgTI1Q1XIiEbT/evyndo/P3FWARIAqpP2p2wAgW80kEy0zgzWBP2MdkEhsBdBabGZwYTNA
	LtGmasAMm6dGHkgCkrQVCTK+eSJqMMV+X+Czwv8a3ubfF1GFvU/cqz3KJieBppldE6C03dQ9Q/s
	m4yrASWcFEVLLtTDajFwfHTqidxoHq/wSa9vO3FmyOdCZeEofFmgmg1D2FLxytWbZH4tAXWGtu0
	5XS1UhP4Nypehh1vcfEevlB/jYDCSD44U5l4rCVhM9Z1gu4+6/gABoF6qbR6ocMcpM61ZS9MG/G
	8HN4Pg+Uyg79tWOxUAaU+iOXnqJDptxnrlE2fhiEscObiqewU7+15imc0BbETa/pYib+SZWg==
X-Google-Smtp-Source: AGHT+IFB8n84f69J64AkWR9VGuZDwOZaYOeLxR1PP9RJZ4VLcpx4xH2b3szKu1AMRcrRkxak/JLlHg==
X-Received: by 2002:a5d:5847:0:b0:3dc:1473:17fb with SMTP id ffacd0b85a97d-428531c8828mr255369f8f.20.1761065704306;
        Tue, 21 Oct 2025 09:55:04 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm1649005e9.3.2025.10.21.09.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:55:04 -0700 (PDT)
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
Subject: [PATCH] selftest: net: prevent use of uninitialized variable
Date: Tue, 21 Oct 2025 18:54:33 +0200
Message-ID: <20251021165451.32984-1-alessandro.zanni87@gmail.com>
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
 tools/testing/selftests/net/netlink-dumps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
index 7618ebe528a4..8ebb8b1b9c5c 100644
--- a/tools/testing/selftests/net/netlink-dumps.c
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -112,7 +112,7 @@ static const struct {
 TEST(dump_extack)
 {
 	int netlink_sock;
-	int i, cnt, ret;
+	int i, cnt, ret = 0;
 	char buf[8192];
 	int one = 1;
 	ssize_t n;
-- 
2.43.0


