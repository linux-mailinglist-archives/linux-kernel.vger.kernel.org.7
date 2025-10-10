Return-Path: <linux-kernel+bounces-848436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892FBCDC5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A10542F90
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798C2F90DC;
	Fri, 10 Oct 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRGmmmwy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EC2F83DB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109309; cv=none; b=NtFjrEz1G7c1RR0mnyQP1Us9Bq5i9Kf4r0Z7OsNNYilAVBackJ4Qfi2A2IlZXwewapT3sdP1vSPPyDaeFxCM5EWYkeJSLEnU67KR6etrBxRQMFaeY+7H+Yt2TPgb4mf6J+WpjVyqaeZRHCn6sq/wFq3aX8+DV1jtyafTaoFbNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109309; c=relaxed/simple;
	bh=rODvI7V59ljrj50mNeNRchQt/hB8lmPZOaakB/PpIO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r35gqB2+jUNMyL+N8Hi2zzg2Kc0V61dsxpONg/WXoxUF8rux25AKFi0vdGSjpxqTpjW4ctFMnkgcgcjTNAsLaFRz3fEhoq/zJq/GReYy1Bb7wH/cNjJE9DZvXIkUGYeqVH6APanBVUSU+UypC37UJ7dMOZ/P926vjBe291Qdow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRGmmmwy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782bfd0a977so1962285b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760109307; x=1760714107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku7ytx/v2Q4TA+VLykkrqqJQyrV884GCo3tZKDi5IH8=;
        b=VRGmmmwyE1henoUTeLWhWGJG+3sbxhproDR2pWEzQN4DZcDlIcJQJmFw02oicoLFdu
         wK2jBg2R2w8kFGzB2IzgZaErfyfoo9JBUFZPH5MM5RFR3S7jmlpcbZwmmsISNqhJmblt
         JnnU+947yE+mhsDNnAkC+AkV9/gl2mOSiPis9h4gQBCOid185h82lnEKBA7xwngPhIC6
         qmqK+c1UOcY4HiKr5LqvO72yZ4EE58pOPoscW7XDy4jGQwKkuZ9MGcZK47kacV6iw32q
         JQzF9J2ksK7Gb4OFuWCH+AzP/xciY9aal6ojxZ/xLsJin58mEpAifJ5hSjbWpNX70C92
         L7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760109307; x=1760714107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku7ytx/v2Q4TA+VLykkrqqJQyrV884GCo3tZKDi5IH8=;
        b=UImgWM+SmWPf8VQnXw1VbLHaD5XGEQ78jP7ArsEMcFXsS1x6N6LdOWSWkkJTGtMco/
         rKv674RnKR7O+9sL8re3jqrCuoPm9lqXNn3GT9BJctUDXJeohK8P+XM5nRCg9js7QHNp
         5QNW9GogT2jk7Q1RhQ332PFnzaBgeIUR86gnMZCyWkxOtyRScPk9is73we9NWVG1X/I1
         V5QIOlOOdWKMOA+zABZrWkQgfnM3sdpKp3ODpDst4/GJDIvj2chd2ZhFIC7QQre4+55m
         GHt61SbBTH82f4d0aHPh2wfHwCs9UEW4iacYCS5S/kFh0BZYPiCH8yhChIPygJSivXZr
         xcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSxtQI0KOleWUHlMg9AOzV1F6zB2YTqEW2RxmbCgjYuL8vr6JGXaJzFc7ghwnLllEUSmIhNRSuvvhgrK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+FLD370NkPOpHQIfwz2KdBuO2702TPOLaRg9UT7Lmk0zMLVv
	sRZnxlwe+uHw6OmUhAORFuNtW9pX435xCrdIzITCbrFywUX5x01ia7xH
X-Gm-Gg: ASbGncvXgkESobUN9HlTv5uhiefl2mgEAFSwVJP2osrNOV40VYMd401uMD7rdL1rsjL
	BcHjAnJz93pVymTZ44WFeXlJ5wS+njfd337J/Ls+MqvUcrlelwrM7kkbnOmknaMmLph8h8ZJdoB
	+ADXOoiephUAMontZK1W1kuO5b9vIZEygE13FKij1b5Pzxu6yizEKqhTXmoUlGbx5dt9iyKbjH5
	YTO/PmV1vcJL60aFb6pNt796Vqw+b21BCL5oGJsttQ4ytHrlkpVHasyLV1WsYgxoGmySucJzMKB
	D6c4IkwnYQeA0Tb7eJgbnVq3Q0zcJGAsWGXyy9a1rGhtuCHNg8F+W0tEmTBrjJwEXjytROv0yoy
	8TQ4olbS1MCVVQNehE2wWTHMxqK2oUje2VFGWj7JBzQeD5XSHHrzxnxrsHg32ty3lOklfUn1k30
	Jq3Cxh2BD1ZWh0Azxl
X-Google-Smtp-Source: AGHT+IF+CkE3KtT6ionDkSipExdfGDISvekrXKi2WT6S/RtLOjkVq23qdW0ISl/zTZg3zmduaAV6eQ==
X-Received: by 2002:a05:6a00:2e92:b0:77f:1ef8:8acb with SMTP id d2e1a72fcca58-79385ed596bmr15180309b3a.13.1760109306603;
        Fri, 10 Oct 2025 08:15:06 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e134fsm3270685b3a.58.2025.10.10.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:15:06 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: quic_mdtipton@quicinc.com,
	jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] interconnect: debugfs: Fix incorrect error handling for NULL path
Date: Fri, 10 Oct 2025 23:14:47 +0800
Message-Id: <20251010151447.2289779-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The icc_commit_set() function, used by the debugfs interface, checks
the validity of the global cur_path pointer using IS_ERR_OR_NULL().
However, in the specific case where cur_path is NULL, while
IS_ERR_OR_NULL(NULL) correctly evaluates to true, the subsequent call
to PTR_ERR(NULL) returns 0.

This causes the function to return a success code (0) instead of an
error, misleading the user into believing their bandwidth request was
successfully committed when, in fact, no operation was performed.

Fix this by adding an explicit check to return -EINVAL if cur_path is
NULL. This prevents silent failures and ensures that an invalid
operational sequence is immediately and clearly reported as an error.

Fixes: 770c69f037c1 ("interconnect: Add debugfs test client")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/interconnect/debugfs-client.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect/debugfs-client.c
index bc3fd8a7b9eb..778deeb4a7e8 100644
--- a/drivers/interconnect/debugfs-client.c
+++ b/drivers/interconnect/debugfs-client.c
@@ -117,7 +117,12 @@ static int icc_commit_set(void *data, u64 val)
 
 	mutex_lock(&debugfs_lock);
 
-	if (IS_ERR_OR_NULL(cur_path)) {
+	if (!cur_path) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (IS_ERR(cur_path)) {
 		ret = PTR_ERR(cur_path);
 		goto out;
 	}
-- 
2.34.1


