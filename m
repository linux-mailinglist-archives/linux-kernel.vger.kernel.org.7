Return-Path: <linux-kernel+bounces-831356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F6B9C715
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454081BC39AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8A288537;
	Wed, 24 Sep 2025 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrLRx5BJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC191D5CF2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755068; cv=none; b=H9rGmedSerkza+ZyiJf/YljXXwSfRTLrO7ECirs/jY3ecgSRsFvHW7NSVT3EirhXILaPxfQFnG5DNXR8j6o8U1kgsr7Wn1dI1+oSDxr2kArifwPWgiQTFORBa9XLvS1QNSrkD22kWqCKndSbosy5LqXXhAR8thzIqn90PpV7US4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755068; c=relaxed/simple;
	bh=PUMWr1KcbhmB/IOqYU14+Ove2tvnxcz4UzVWOTY2pAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4LdEOnQLyXjZnIWRe/yrUZrzmAXq3hcEzwYoCd68vx1vxuWIL0Pzdqt1Dn9mIet/bc/J+xfKBmQO2LwpcdMnirF62p3ZZFWVaS2DyPwUJND223f9ShUi8zdSU/eyr6wNoSAp9koMMJO5nuTFxXO+7Dr3i0ZG+Oq0vN56EpB0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrLRx5BJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b30ead58e0cso61636666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758755065; x=1759359865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnszhabCzVTZUNrenHHSvEHdol2FKszGcCj5sQfSnxE=;
        b=UrLRx5BJGBQ+LztwingaNwl/eEbPDYfCxN5BFbeySAnj7PRfHBdqI4nH9ckd50Q7Ou
         Fsd7ZitkKDvkXgsVmSXlKq1OXaSRaWyew2/9zVcEfkeInTmmWTa9Y3Zkuxf0zZ1Slf0A
         fAoN0QLwbZVBuTeRoSHoCj9rQRIA+GXDNTxRhuGOpvs4QdQLhmx+cUxasqlGFSySUX7U
         NXpOG5asC4rt78A6A/N+TJhYMo9UVQ36kXuChSrFwfxOLTbTIMHD6B5R3REJiZmvVDIO
         MhUj8AWSqACpEgDeX8BkbEfFgE4yCH5AYTIk+fLjzk6ls0A3z8oX4iq8oMSI2Cw17tzV
         YHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755065; x=1759359865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnszhabCzVTZUNrenHHSvEHdol2FKszGcCj5sQfSnxE=;
        b=trR6gtTWWL4Q1k4p/7oFBNzz8fgaLwatZ+b5IicCbGhB2R7gdpVD+mee/Qjucvn8ZV
         JoIkXHoFIcRz4JsWjE+Dea+otQ0J56/qK0DfzVDj89PQnC5AQKPQlWzZk2ee9T+ieBmF
         fS/9D0EDHEcY7IHV6PLsPhsl2GKRwUJeN1ji7s/LfwDqAOmT18ytfV2iOvFgLQsHLV9z
         g4tbOdecgDKoWOdMu4reO9iWpEUKJahLGltKSSGdhG0ZRddSuf1+yQwyZKmjubfDTYbp
         0OJCg28L2nygjoBNcTi++9aoA1nRp2ctinxhcbHnzEsUraPgCJ+QPD27qHFL8veKj0S7
         rDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtupsNTV8pVdmn3gTEiivyGyscLMgP5VEXw/wRf50GEPjyfFqYUkyi2vEVu+UanMB/nGG5sylUhcYvcyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipVkxWtoKR+f2ltmzgQQobsh15O6EEuMA6X1XkbE+XsF/3dlr
	QiBR1rvXjUV1om6UdXu45ge1ZOPJiX2CcrsuXGcP+ETI9GTKIB249XbW
X-Gm-Gg: ASbGncv7tdzDHuM9FZaIXX4zgVxzvFmYdlT30zWxvKuLR8mfTJWMJv3hiu0qL1lktGb
	W8IX33HdGdaBcr8zdtYfT30HcgBgzK7wWL5pTwS+JlRUuqRUmFInojfiQ9nQ4OZSScGaJN21BMG
	lCDFmRA3WdKy/y5j130waJKrdSHjuniR7kkUc5qnmCEhPempVdRt6fr+B2Ziq9Z9DNp6F54/v8A
	pHGvFg+GVqdrtTYdDkXw8YNXmrqCxkErfMu8f7hol4WMMs3+ha7Z5NaDkQeGq6GMdf3118NEzcZ
	wlxATxt2WzCHfn0/QKN2kuzGOG4YCF6rA9qiAn4aHCMY9RvDA4DEnxP4alH8cWS/0sA+w7/GI5i
	PHCqU10117QMvX0q70W17XwhdpAJj6QBUTv2iJnizg62eIe5ACZcEKPOimosSauJmXHOEKXn3/1
	dQxD7UHYIw9fz55Ec9
X-Google-Smtp-Source: AGHT+IEppvE3960x6XIR7URKU78EOKSYRIAcJdBEOqPrulJnmbx5gMilskPWXare99l4J1hqwdTmQw==
X-Received: by 2002:a17:907:6093:b0:b04:6a58:560b with SMTP id a640c23a62f3a-b34ba93ce11mr146872666b.39.1758755064614;
        Wed, 24 Sep 2025 16:04:24 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f772528sm34363266b.37.2025.09.24.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:04:24 -0700 (PDT)
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
Subject: [PATCH] selftest: net: Fix error message if empty variable
Date: Thu, 25 Sep 2025 01:04:07 +0200
Message-ID: <20250924230413.75246-1-alessandro.zanni87@gmail.com>
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

The issue can be reproduced with the command:
make kselftest TARGETS=net

It solves the error:
./tfo_passive.sh: line 98: [: -eq: unary operator expected

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 tools/testing/selftests/net/tfo_passive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
index 80bf11fdc046..2655931b2396 100755
--- a/tools/testing/selftests/net/tfo_passive.sh
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -95,7 +95,7 @@ wait
 res=$(cat $out_file)
 rm $out_file
 
-if [ $res -eq 0 ]; then
+if [ -n "$res" ] && [ $res -eq 0 ]; then
 	echo "got invalid NAPI ID from passive TFO socket"
 	cleanup_ns
 	exit 1
-- 
2.43.0


