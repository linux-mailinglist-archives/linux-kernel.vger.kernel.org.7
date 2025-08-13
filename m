Return-Path: <linux-kernel+bounces-765972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10541B240B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE5F1AA4771
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528E2BF01E;
	Wed, 13 Aug 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiDz8xCV"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCB271443
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064289; cv=none; b=EmuCLjjTLtBCBcUuzFhTc/6rNQ6KCjHBz52EstTgx/uqxPxqoaZFnoV5ukTkFZWjbh7WA8XtyiTe/IifSivSUihtO2f1UfoCiNBE8c1NlU+BJW1Qdd3NJlwl7E8eZ/+vGJXV7GHX6hX8jgwJtbA2TbcZGGrbMyit4TO4T3MniAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064289; c=relaxed/simple;
	bh=lRxuv0qt4ISYZ4d5L7KaHZ2U9/6/GI12h89YfeucWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MBiNmNMDjA63dfDJmMsUal9Ct+XM73qbfECsOjOwK7hhYgWfaHa21URR8VDb0c5ZbFqD+ZPoZYSBuQUqxvFvr1mMG8lAVXnYASo+RE6D9rrd8vzFeB5+Mk3f0y1CkYmvMcp6ePfs1M93mIQmGGE0OcsZE+wbleZkoVa2F4bbVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GiDz8xCV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so2952009f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755064286; x=1755669086; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrOyWBFP21dohGWxqS5PR6ISwURTsFLfxT85phMfX+M=;
        b=GiDz8xCVMi8EzbvXUojwrgp6kG6UCDdTvwMHFpQSsLJz/56aL0JGV0SVL5+89HndKb
         Z+TISc/MK81S0vzzd23LBvIvnvss5KtFOb5CrG/C2KvfRQn7vHDXScw9SItB5n009SEI
         s7/8hTNvvjhu59BM1+U8d2YbxJDIai6fPcReKFBtLeSR0Lt3sHrffDciq2PeMlqDXLIO
         kKW4stgiBU1YO2jxAs3EzXmHj9kO381dJotJOMz7zwYlyrYbTFlbS+W/n/B8dVUWhlRI
         iZZC/BFtGtEe+gpdLF7/+b34NaQK+2U5/YmzF0wSFYMNF/E51YsnrKiPOxIg7G/tOsld
         fmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755064286; x=1755669086;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrOyWBFP21dohGWxqS5PR6ISwURTsFLfxT85phMfX+M=;
        b=XsOj/gnZWe3qpeDinjwGxJ0ZISVFu/cSQgp4QXOfryVouiYUgzpw7Xq4eBg9n6HOvU
         8ti2viQ5sPt/soRDsfQDs89alXPuJImqmnP5JfnkE9fkNPGZGMENSOyC0Ywk9qlycwvC
         45BBx+Kjfi4w5Mc2D2Ww6fyv3dOJ5PppuO3bM3kfbl6sFB90mmB299DCZr6TtDfOkQcZ
         utYEc4q69bY+PESIRw5kqDu2iZFhaMFo3yxSLt9O+GSxiJ7OUt/v8w5CImNXoo1xyHrq
         UM7PHjyshcKOeVce+tCrj41S0nZCKV/gRlvR8nL7vKLy6VaKuvQ0Ie1VlBYx78UIKdC4
         FG8A==
X-Forwarded-Encrypted: i=1; AJvYcCWStNAW4oa6YVL7uGRnMqWj58DkaEOz4V5M4rG4mjgvXjfr68Mk702+hpBR3FoBYo0+ixeYlJFWbsAPKGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLQV1jXB8dW3T4nN48BKpxGWadcGPFE7QWkOuQunbyNbqP1iY
	aJZPn/mOImjPyOgvpUnJo01LvPOm2qWHUfAOGdTc2jZkTEzGkgZudbO/E4+35P16Ic3rE0r4nyG
	ldiVT
X-Gm-Gg: ASbGncutJuAmRSdzzjPnfFYSfCuky3a/LPAbHxSE51XhnX2+xTstN2hV8JkjsrqUitG
	dTsitOPq/nx7f5raR3+G4gQbfvefl+PIxwxVCKCLs+wCcyGGTj+foATk7f3o1uTzBvrxOxtVd8b
	ApgpbTnjzITspgsruXlNvyinn49goMyRoenYk8KMw6gF4gMuksf2WsFeXbHRQh8NBp0DY5E/t/G
	qOif7KnmjPGJqihZdgCxtbDPKO87O4hPLpXnPxW8jFiz6DQ/idmE16IQsESY81KmbbafnuqfJfG
	bQqij6T2mwHr/fxW3VfMRnJLwnS1ohfu8KTY5uW2Bf/Gq4Yo+rTaC6xNo2lbTYsZcG1v1JTmnP3
	VttjKc0xjxwBcVOvMfL/kboIihjs=
X-Google-Smtp-Source: AGHT+IFcKTFkpLXaLpQ8IyxiEG4h8H2fKINbMz/aPudLtlvebYChChfIWNlq56NuIvASiyNpkDoFVA==
X-Received: by 2002:a05:6000:4282:b0:3b9:15d7:8fd3 with SMTP id ffacd0b85a97d-3b917e37cf7mr963552f8f.16.1755064286473;
        Tue, 12 Aug 2025 22:51:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e0bfc79fsm35965508f8f.56.2025.08.12.22.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 22:51:26 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:51:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lars Poeschel <poeschel@lemonage.de>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Aleksandr Mishin <amishin@t-argos.ru>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] nfc: pn533: Delete an unnecessary check
Message-ID: <aJwn2ox5g9WsD2Vx@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "rc" variable is set like this:

	if (IS_ERR(resp)) {
		rc = PTR_ERR(resp);

We know that "rc" is negative so there is no need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nfc/pn533/pn533.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 14661249c690..2b043a9f9533 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1412,11 +1412,9 @@ static int pn533_autopoll_complete(struct pn533 *dev, void *arg,
 			if (dev->poll_mod_count != 0)
 				return rc;
 			goto stop_poll;
-		} else if (rc < 0) {
-			nfc_err(dev->dev,
-				"Error %d when running autopoll\n", rc);
-			goto stop_poll;
 		}
+		nfc_err(dev->dev, "Error %d when running autopoll\n", rc);
+		goto stop_poll;
 	}
 
 	nbtg = resp->data[0];
@@ -1505,11 +1503,9 @@ static int pn533_poll_complete(struct pn533 *dev, void *arg,
 			if (dev->poll_mod_count != 0)
 				return rc;
 			goto stop_poll;
-		} else if (rc < 0) {
-			nfc_err(dev->dev,
-				"Error %d when running poll\n", rc);
-			goto stop_poll;
 		}
+		nfc_err(dev->dev, "Error %d when running poll\n", rc);
+		goto stop_poll;
 	}
 
 	cur_mod = dev->poll_mod_active[dev->poll_mod_curr];
-- 
2.47.2


