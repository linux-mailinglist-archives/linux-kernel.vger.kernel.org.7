Return-Path: <linux-kernel+bounces-744849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741CB1118F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E211EAA7963
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D519F2EA462;
	Thu, 24 Jul 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBsbV6iW"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCF221555
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385013; cv=none; b=BIh5NqxekLC6YX2WPGxd49EDc89yGo1eezROCkFvIq4vsO8mOjJctZqqwFk9RjvELUzQjq5U2ompHaeJtQF44JrPAPspfwXLwgC7HTM3ffIXUo+TP7Q3CjnMa/xUJb09RjgXd9dUZs3xmjwWaLqbdlpBr3qoajrMYuDfia2rtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385013; c=relaxed/simple;
	bh=Wl/MVrfadxWCvbcWuLboGbrjuXmRyvy0BBIFUzsNgX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkNOQxFIsXgwJe3Vx1wWWNBIPO8aF4WvhsO7a2IvlUH7B8t4tTsyybe3RwTJlVr5pUiazi74T3RFXVpMNRJNP55CtXdqaNvhNlSAv7oqguauTHgM2ZjPKFUbYbUnnZ1bUFbZwlvvzHCzKKOXMF0PAzI2PqhvePkwq/Yzf+6eFwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBsbV6iW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso2664413a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753385009; x=1753989809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjrrUXAL6KpzkIM6/6atzGF3H/f1YResH0MiZx9rdi0=;
        b=XBsbV6iW95FKbseVw35GndJOOFey7Wbu5mEOhk1PwBJg+EQjtlmstmkXIQkuKPA4/9
         F8KUXhVOhcXWL0+fhN1qZj0qbh6RcsLRtZiltpLHqwj9dJrTVRSqCQh/d5CpW1xyQXJ7
         213P+SO9tBy0HS+AF1E15z5EfUH3MWqlC5qq8XEhU8fSsIqNmf4G5zozzuG07BysDrRj
         txJq7UJ9F+YNN1HcrVHOiOjE+93DtrD8oJlfmEVvp9iv1TmC2CLP5Z6f8zC1tIbyRf3y
         /QWquYt8dWAfqhghXHb5dGjXKo/+jYQG5N0/Nx3XTFSZzjX31BNNqm7IYl2RlFTY/jUX
         Yt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753385009; x=1753989809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjrrUXAL6KpzkIM6/6atzGF3H/f1YResH0MiZx9rdi0=;
        b=TAHFyfRDQiRgYNZ4ZIQU1bdtB5KDB774hCiCI39clwG2B5L7Ti5DRB2VuxyUcIif0Y
         O+kqEIDkN9LcEH4xQ54X85ZnhiLRcX1YZFXHKEwQ8VQQts+//SgQSsvoXL5iAjOuPnZn
         P674Xho4kXdFkk9kTVKtYrFRA2allOpJolDLE4Qj0ve8coF3eoBNazV5YvH80lY4KASs
         +fqThVSoLNvqHODA2RLSmiuSdxXoLvuFqDpuqAhXOurqG9Cy0evsHwx553UcUCU6fSuy
         1MCR9FGmG/JmCHvja3L5RWEtnArEN8+K6bgyun1RGI3ihd8QHzF3O2PtYTBXp92ryuhF
         iKRg==
X-Forwarded-Encrypted: i=1; AJvYcCUlno7OHi5s3EnvvWFV24R8J4tKlGX2cBORFLS4StSCUdq5tbENV0wNpqe6UWtNJJe+of7yxK+C7ymVtbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkwYjZYMVDriDXAg0kO4HfVX4vfy0+sQPrE4st+9HzVK9WuaS
	KSnIN+bGRI+xjzeAxDVP0QV13oqfMpy3R8eDX4/makC1ssnNC9fYVMmcqSpyFA==
X-Gm-Gg: ASbGncuCBM1OgwfTYVg9mFk225mLKazAWOsKC6FxC1+pWOC2GD1z4V4/vVGFqz9kLzT
	M9TFdLK/cxJ06OxiXqalxTAMTq6V2jdMKvHuSgf8yPjIW6BRSZzjb/vvLHSJb6RIzx/+acq9R83
	krwjyLJ2+EJVMPaE+fjLzA3bxE+NS0WXNv03M+OfFbwKZu2aGk8j5EA0RMjC/DTx/Q2w9gSg9g7
	6K58BufNtVvAfHy0flRQk+z3LTz2FNRUtpWIpn6rFJLbuH7JBe79K45u+ONyibHfL0da158WM7g
	r6wMH8As16j67WkkJNEbLP2A91rl2WO0RxsJcxVxv57Xg6JZ6M/+mVrm9a+ZZyjFG6F/C3WIscF
	PykzG3a6nvhe06TkpREDI+ntj9OE3ezQnN1t1axHli3RmSe7YiBp6KAAkuTXehOVxs24lo9ZFid
	hwi5V6qQ==
X-Google-Smtp-Source: AGHT+IFc2z3KY2WsKxoGa58pXpWWO6lA3PIPKIetHzV+uzHC4ZKznczYmr5VepT2G+/L75iREA8ZsA==
X-Received: by 2002:a05:6402:42c9:b0:612:a996:5cfe with SMTP id 4fb4d7f45d1cf-6149b5b01d5mr6939759a12.31.1753385009110;
        Thu, 24 Jul 2025 12:23:29 -0700 (PDT)
Received: from PC01.localdomain (094190205166.static.ipv4.heldenvannu.net. [94.190.205.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd31a0c1sm1155516a12.47.2025.07.24.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:23:27 -0700 (PDT)
From: Bruce Qin <bqn9090@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bqn9090@gmail.com
Subject: [PATCH v2] staging: rtl8723bs: fix if-statement alignment and line continuation in rtw_ap.c
Date: Thu, 24 Jul 2025 21:23:24 +0200
Message-ID: <20250724192324.19893-1-bqn9090@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025072409-promoter-shame-8105@gregkh>
References: <2025072409-promoter-shame-8105@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes several style issues in a multiline if-statement:

- Moved '&&' to the end of the previous line to follow logical continuation style
- Fixed indentation to align with the opening parenthesis of the expression
- Avoided ending a line with an open parenthesis '('
- Moved closing ')' to the end of the last expression line (as suggested by the maintainer)

These changes improve readability and conform to Linux kernel coding conventions.
No functional changes.

Signed-off-by: Bruce Qin <bqn9090@gmail.com>
---
Changes in v2:
- Moved closing ')' to the previous line as suggested by Greg Kroah-Hartman.
- Thanks for the review and feedback!

 drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 383a6f7c06f4..c652e0cd35f3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -258,11 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
 			/* avoid running out of xmitframe */
-			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
-				&& padapter->xmitpriv.free_xmitframe_cnt < ((
-					NR_XMITFRAME / pstapriv->asoc_list_cnt
-				) / 2)
-			)
+			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
+			    padapter->xmitpriv.free_xmitframe_cnt <
+					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2))
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-- 
2.43.0


