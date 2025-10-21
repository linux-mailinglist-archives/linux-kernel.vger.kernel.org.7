Return-Path: <linux-kernel+bounces-862214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1FBF4B24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF664621C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408AA25E44E;
	Tue, 21 Oct 2025 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkkJsVvK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03D1B808
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027711; cv=none; b=MefYwBdP9C5ihCeBkxQrMg1AV4Z7X+lJcinyWr5hJN+D22p70/0YsWOgefIIeZ/WZqwzYNrrYSfUzHVs+6vH77wXCZXnriPqmOTzEWl/elgdcJ4oI/AqCCko/X1ESGjDeuz57aSU+od/GBm3e+zIW4EHd+Xqpu1XE4s+xZq9Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027711; c=relaxed/simple;
	bh=dZkozO8XQpdvjUFyuS+7gnOquHi4UayCDzsqXQhtNTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YBUR/wY+CrbHPziNDM8EjQIrDdInHCflVaMnNziUnSc/lnjjfVqddFP2vb1QPef2odg0gTtdJORJJLg2vDDVymt3bSDq+ROqRtOsbAl59ti/xk9ir0e6dc9mBHug3nCClYmZyewfHPK9cY9Jkr6PuCzzTu9uUvEaYKnWQ+fbAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkkJsVvK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290a33bfea6so6961615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761027709; x=1761632509; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQlJPMwH7nXKBtlf8BayDPI5AZLW0pym1gUfIZRSMBg=;
        b=bkkJsVvKdR/rIwtEKElyk4tkPoGo6sqyo/cl1+TmwRdmg5kwkL6//oFq6uznK7+yyM
         9LDctKkgekmjmlSds0JW0GVT4LffEQfdDUHxpb03nFrZ2gAHp+CH7EKEZhQnq94ZnFTC
         PJbN+trSGn03bx8yXTFWdB33FcQzKEQAeER/SFiEv510kMP2FoBc2BbGrEb9E/UThcI8
         wdA8f5+3wy4f2F6l37LZvoHISrW01RXi90MPTz1Ii62cxv4oAIb85WMnxEMO3yvFjyi4
         BIVzGmnMeBqwalFj8O5VEC/4SzlXZvLdsuP2TW4tNTvjDNfKdpPdUHwZPiz5UvrMx4sW
         H4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761027709; x=1761632509;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQlJPMwH7nXKBtlf8BayDPI5AZLW0pym1gUfIZRSMBg=;
        b=emaZSrw7bzVQrY/uO9BrCrb97wunQVlxVEQ3TNXZpRtGb8Z6BnY8yS9YJ7LMo0mhBR
         5W3eORYYQh9mT0X/7R/WPgsX1Q/KpQSqI3p1LEsM67nMT1jP6fu6KpEO4AgtEdq8nkY6
         MtxVsWsfBMXdPJjfrywt5GX1Q1B3farIyVEeQePFJ5CY+RVfwWb5fM3e3yqcopfMHT4+
         5kDxVoNi8hAcw32i0yamZaOQgYn7GPsLEXBy6uPE7WyRBMUjTt0tdOOj4dsm+rgyD4BC
         9WhlSCWU3nzm16Tx/kmw56rG1XFudLOIHBwKIccv+abuAdMG7YnDZjbdy9WjR23TB9+P
         dlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbjLkSy2pIUNrtvty/7pGjEl9WCVAB9a0gGFFOObZmN5PU12oOcK1nAC6SZPRD3gDo/V0hV/5hfH7WbJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfCOMthOwIroQ3S1A5LrzS9N+ms25ejk941VxKgDzoFP+k5fx
	rxQUuV740beQ/L/QNMhEGI2E3vXfKZjaWiL4TYxySmK2rDeg02B/bB/9E8sdZzrE
X-Gm-Gg: ASbGncslLwzvMX/UFUbmtIOMcvfnkpVXJl+zdPc32Qyw/kyt+4rS16b8ZqrWqyyPZTI
	O/dy/BSgFD9I9LR8QBA9n3ScW4bxyVZmCXk7twa+258Ef8v6WNsauYS4fXI2FFj7NNoCkg8HRao
	ZA2ITagx+3rl4a1LCuatJ1BtFrGZF7+xk0zzZyv7UAbi5kJ/WtT6sQKcrE+5WJbtdyQuO16X1Hs
	PxeJV6+D72RGS+gcaUkif/M/18OZVha0P/gfnj/uBlhLeQbr1dun3zPqUembnWCbUqP/+EpyjHP
	O0naFwtLhBClE0HSnS0mBDMmbMBaFS5lB9nPJk+1R5XuNJy8MvyxrsIFMsMyzTxMjJu1Lf7Sj08
	UoFcrilPjYcfefzn4Kn7q8HruZrvT+DFLBcXIhWvp/g3cWc1fn6dEdsMFdDjonheT30f2TiUUtb
	PCWhdlMVyGOBlG9GZLJLHg9ucIHWlwwp8y33QKuS2EXfD8db486b7G
X-Google-Smtp-Source: AGHT+IFnYKU1IWC3pFF4gig1+6sBxnYeOxYc6mKh5U5SUBS7wKSrjBE45ao1Z4z/gFoNYWrq+4Y5Ag==
X-Received: by 2002:a17:902:cecb:b0:258:a3a1:9aa5 with SMTP id d9443c01a7336-290c9ae1a2emr116032215ad.0.1761027709371;
        Mon, 20 Oct 2025 23:21:49 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:c8fb:fb07:ee78:675f:132b:f68f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd7675sm99312855ad.26.2025.10.20.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 23:21:48 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Tue, 21 Oct 2025 11:51:42 +0530
Subject: [PATCH] drivers: block: rnbd: Handle generic ERR_PTR returns
 safely in find_and_get_or_create_sess()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-rnbd_fix-v1-1-71559ee26e2b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHUm92gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyND3aK8pJT4tMwKXcskE3OLtCRTIxMDYyWg8oKiVKAw2Kjo2NpaAAu
 FoCdaAAAA
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761027705; l=1897;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=dZkozO8XQpdvjUFyuS+7gnOquHi4UayCDzsqXQhtNTM=;
 b=8QUpn5dec1JVYKDwU5Xa1XxbcjpL/7KR847ZaE/4RWlNjTTdoPSifgcOluNBdI7zuQwTPonq4
 Lg9bICQrhrcCzpXhzvyxmrDrJeId3eud/lrfZjDvtA7HsqesYfvmus+
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix the issue detected by the smatch tool.
drivers/block/rnbd/rnbd-clt.c:1241 find_and_get_or_create_sess()
error: 'sess' dereferencing possible ERR_PTR()

find_and_get_or_create_sess() only checks for ERR_PTR(-ENOMEM) after
calling find_or_create_sess(). In other encoded failures, the code
may dereference the error pointer when accessing sess->nr_poll_queues,
resulting ina kernel oops.

By preserving the existing -ENOMEM behaviour and log unexpected
errors to assist in debugging. This change eliminates a potential
invalid pointer dereference without altering the function's logic
or intenet.

Tested by compiling using smatch tool.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 drivers/block/rnbd/rnbd-clt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index f1409e54010a..57ca694210b9 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1236,9 +1236,14 @@ find_and_get_or_create_sess(const char *sessname,
 	struct rtrs_clt_ops rtrs_ops;
 
 	sess = find_or_create_sess(sessname, &first);
-	if (sess == ERR_PTR(-ENOMEM)) {
-		return ERR_PTR(-ENOMEM);
-	} else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_poll_queues)) {
+	if (IS_ERR(sess)) {
+		err = PTR_ERR(sess);
+		if (err != -ENOMEM)
+			pr_warn("rndb: find_or_create_sess(%s) failed with %d\n",
+				sessname, err);
+		return ERR_PTR(err);
+	}
+	if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_poll_queues)) {
 		/*
 		 * A device MUST have its own session to use the polling-mode.
 		 * It must fail to map new device with the same session.

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251021-rnbd_fix-9b478fb52403

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


