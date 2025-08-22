Return-Path: <linux-kernel+bounces-781438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E0FB31271
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC57727B62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A12E92AA;
	Fri, 22 Aug 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="IcuICu2K"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20F393DEF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853141; cv=none; b=jy4ckHZwkJ3VOsdrJcnimW0LtLftiravbKc3UzZvTLmm9QEwINKZFtn46sKIRyKaqtiRAs1wIQ0IQQHUsXgq4aEDN80IfgVl83qzlzenisp7hzYi2GVqkgNZ8zwhrDS07W7yA4Aa8S0wHdxPAPUmMGmMh1SnLEn3YnMoZASZYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853141; c=relaxed/simple;
	bh=CxOmZJ44wTNd8Wkz7CX5jZhm4/5OaxBKTytzpVbUes0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QVjGsw2L91aZ+NMNrbMGbF5fVODpO4FoO1Q6TL47RwS8kw92TlJc/ZXZnHYRRCzGYGF2ewDnQRnjPyCFE/MKQm3KNjF9YeJPi2yof01bBcT13y+cikA7sO7HzmuVVqncVhnRbl9BmjLcXbaL/3cyFTsi2OvRcSHqzSGZ5g6FwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=IcuICu2K; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326df0e75so1609256a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1755853137; x=1756457937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6eP5hyP7BMhgNOqob1eKp8ahM+Hdu1LPbbt+URhUjs=;
        b=IcuICu2K+MfSUn5Lom8RN8uraRhQizjRVqa/uOlUHtaaK1NsFhY+2AXDGzcCiGNLGD
         g/DBO17aHFhpgS+12IGX5lCcjmdF1Y9Bbuy5khKxX7HoiZpcZrPwnqtJxdkqMVMH3v1n
         96Hsp4HdLm6Bsl0Mm/Cn8LyI7PwJ4drL9ocas3fH3Gnubf+3yby/S+uHVVmG+N3rh8AE
         t2GAJvbzI0jT65Xn3Kf8J6yGF+SRDPKT9xO8TWQazHJ3N4H6RQToeGb/VTH+OAdvZGTy
         KyTMBdbEgYh0UuzjxS74VOC3dIKLjAhX5Yr5a5O6dn6Lf8wyRaGyXbmwiHHWVsW39ZXr
         nNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755853137; x=1756457937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6eP5hyP7BMhgNOqob1eKp8ahM+Hdu1LPbbt+URhUjs=;
        b=Lp+BZ6h9r+vVeEJ6nwEXID49Rl287aEfYky28lqdRMnO/2M+PbRaOvB1Zw7FOxkO93
         jaK9/dmHdsB1Qj4DD4Iq4Js/ErNlNYrwzMr600eT5Tf5APukk/OXBgNWyr4J/nIBl5Nc
         D0/Iv1mow6wt2Ms8cqdr6tvuW7PpZzV3YVicpx/NG+Vh8Nbe1/9YQH2U22HAeFrMXcL1
         l0tapqAKHx+N9STCLDgXzjX13Q8xsJsEucwbqHTDrnPNRNzTHB4sxbN4uSD9hOoDMxFK
         DUbqaxC1Nan8734bqZ36TWhqS6RNvy8wi7zUnYvgG+u6IbQWiAjw3pEMSMhkLVlA0bIj
         /dmg==
X-Gm-Message-State: AOJu0YyIR7IR6YJtCZUTFZiicQuAG1SIej+ft28Z/hgqyg4JAdwGlIUn
	UE3uXOE2YOj+WeeCOJWXEWp15aiZThof+lnUkBebY2kGvvWjfk6KNGfOctPFJS+Sx5Y=
X-Gm-Gg: ASbGncvwzJX8ruPb3FpF2vX/oQuuH7ZfnKzR4FiRZu1HvS983T8KLfussy/VAruLsMO
	26G+QjZAIxGJBzQgarKu/tms3mzr+osY7ZkINydcclzYGJQIK2pz/nexdA4P9oAclyCzy4yjcdo
	/0yZdiAI9rj12rn2JMz5x7zec9aRcV0e5TM/RHK6s9C1QeGQLGmrDw+p2TBUKag9XxfwjPVJJXQ
	HzpisFW23ewLTCYS4syhyGf5rG3nFcn1M9LAVyEWRDrzOCwNqkNNKMaESZtflRcuVG8VkCHxgpG
	bSVJSesCDlF/c5bRC0flQQDDb63hwNk+M1TArgurM6u1gJV3d8/wdYkmljgjsuJKnD6EE3ZICn9
	tvZOMwIXNm4rVf5sA9p9+fu7DkfGF6IV4IjM2kOEl1bmQhNg=
X-Google-Smtp-Source: AGHT+IERyOUVne10gJem1JfuQ7KFT4WhO/IH8gz9FAQze1wgrWJ+kfK7p8B6waMPIOUI1Urs71Qp2A==
X-Received: by 2002:a17:90a:ec84:b0:31e:e88b:ee0d with SMTP id 98e67ed59e1d1-32515e456c6mr3307080a91.9.1755853137639;
        Fri, 22 Aug 2025 01:58:57 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:b533:3d0a:f701:887e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325129aa68fsm1948183a91.7.2025.08.22.01.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:58:57 -0700 (PDT)
From: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	"Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
Subject: btree: fix merge logic to use btree_last() return value
Date: Fri, 22 Aug 2025 16:58:51 +0800
Message-Id: <20250822085851.566303-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously btree_merge() called btree_last() only to test existence,
then performed an extra btree_lookup() to fetch the value. This patch
changes it to directly use the value returned by btree_last(), avoiding
redundant lookups and simplifying the merge loop.

Signed-off-by: Guan-Chun.Wu <409411716@gms.tku.edu.tw>
---
 lib/btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/btree.c b/lib/btree.c
index bb81d3393ac5..9c80c0c7bba8 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -653,9 +653,9 @@ int btree_merge(struct btree_head *target, struct btree_head *victim,
 	 * walks to remove a single object from the victim.
 	 */
 	for (;;) {
-		if (!btree_last(victim, geo, key))
+		val = btree_last(victim, geo, key);
+		if (!val)
 			break;
-		val = btree_lookup(victim, geo, key);
 		err = btree_insert(target, geo, key, val, gfp);
 		if (err)
 			return err;
-- 
2.34.1


