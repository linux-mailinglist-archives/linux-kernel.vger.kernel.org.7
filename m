Return-Path: <linux-kernel+bounces-742220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACDB0EED4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB36AA0788
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E54289817;
	Wed, 23 Jul 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmISql3C"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B82276036;
	Wed, 23 Jul 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264432; cv=none; b=MvRVGaGzROeDKHK0dlXVtHvrWwrIDyreZYADOIMND3F8RxTKJnstJXFQ/BXqXn/eerWM6avrgJtp363PKwLsfqh9g4QYmbwUr6zGaAy8B/52Y0NhlhY54/As/8JbsqqWepMewZCEd5x4cHhRWNFj/WGQOTZpc35b6LaW3qQ0Ynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264432; c=relaxed/simple;
	bh=t2/w6xlnqLOYPB4OTfx8oTatGXUEHAIKRrDBlB2Z/Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4T2tS0mK8dyi5Vt4Y5+8THQuvXlQ+SHh1UW457rkOtxmhSJBx1dbcb6nBg6UstSBoEYYIbo6fWGBFA/AbzxdtBWn9hj+StHa6XVx52x1KE2bZk8LWhNA31g3Lqe67iKzkkG+GNKkZ9Oxp5dusmxiFnOyMObRmxxFKwzuXinlzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmISql3C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so49797375e9.3;
        Wed, 23 Jul 2025 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753264428; x=1753869228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ye4p2iW6iL7aR7iE9gTvKTq4CWuN94sAbCzmmHDSAYs=;
        b=NmISql3CaKWUcLn4mnL5dItuS88RMEPQH2FO/19+OmYE10XBbgwF4mOpvpY+cTOpZz
         KJRicKUTVfBAGZqb3vCoRENzR3VVMTGgxw+cfEJCTbpC7L5MMb4sSYR9uAWDcAFcC+Un
         JKudpV0OJk77i+GQ98yVNr+yAPyi5mNe9X5Rp3z1gDdl4ihJWMeUFznaVcWrJ6FMog2k
         yEAGX0hDhum0jrt6FaGPI6o9+fhXuj41zUJEpqtNKc7iTo0/Xa8I/vuUT9/i5od81Xue
         YpFibgMgVI8jABz6Rc9hK6fLfiSMRjfpYSjj9QM5gx/hVr0WX0aG5txhsg8gp4yJZ1kR
         i66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264428; x=1753869228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ye4p2iW6iL7aR7iE9gTvKTq4CWuN94sAbCzmmHDSAYs=;
        b=xGNIQNvdqj/qH7zhw1AMIfXl6cS/tsKAx06aqdaCRIhqgOoyJfN8FkIHnD2HTlGSYc
         yy5YAJ5Dshpy7t/JUGcXGoKFxJelueYtsvAvapkywPHQh9nRYF1irXJtYISlBwGPLGGp
         r2CnyAbgN07of+1Ozo2Q9dM+9gmjkpTLG5T5rCzuEAMHmn0RKMjOAeF/1YnuUu1wUyxb
         jQ3Rr3czpsatoSw5zwXFRTP5vCp2s/68seWcigXAEIqmIgq3BhyM9Sn+ZxY4d/+Shryv
         4tUhmNmNTc1iT85xcrOFzdBmhC7/BgLZmhytV72PsmSYFMaZvsQxMoOG+XpHR9hrB4SO
         0zIw==
X-Forwarded-Encrypted: i=1; AJvYcCWieNfaoyexo0KqePLjnjUuouNMlK1ffgVXywTmde4fw2tiaMMatIWpcfyPFM1mD2kOqiee9VnP/xoLVbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Z8t3yEjRPCT90YUs0UjU5AGMB6BfQp+3STzEIBdKFcX1V2cd
	C+O+zJvL4IK9eX6RFKagrSWoGDqx7HtmHNNkOTxfiS96WQ28OJxvb8+W
X-Gm-Gg: ASbGnctf5buyMcudgASMne0qKzKWOLIjnf3VtkfmOgWKo+9f+WjVR4wTXtpgZG2myEP
	3UoDk1Os4BfD2bmE7NwqAZKhVJRg6E9Xqb1NVWm3xPs8G3nR1FPilpMmtsVru0diEWeHRj8GP7y
	W4Sw5XxOK+UiydJqPOtfqcqspXQEm41KligcD51uNjoyfAl+aU+ZUmCLoWM5LBP84NZrZu0jN5I
	lyShCpw9Yt4ih36xAhkKxNJ9mNz34CkeQJnkjCNXUlayue/XJDnK3JLsXZl4p9vh3xJmhWGgCLN
	ERaWt6Lii48YlDzfy7HRuqYmiyxnBSFNXl3knKUfE7qVT3gt/wNvF1PtRdXStIt4tcpDldE4uVj
	OVdNgfuTPPQPQwDkVrKRe
X-Google-Smtp-Source: AGHT+IHhr6maHryXz36lI6T/2OR7TSp4Zt59BMddnWzWMSB7a61uDHoY7ikxmy0vRQMI0jzI6GOLzg==
X-Received: by 2002:a05:600c:c0d2:20b0:442:dc6f:7a21 with SMTP id 5b1f17b1804b1-4586a49249emr9298835e9.3.1753264427953;
        Wed, 23 Jul 2025 02:53:47 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4586918c706sm17504175e9.12.2025.07.23.02.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:53:47 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Justin Chen <justin.chen@broadcom.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mailbox: bcm74110: Fix spelling mistake "braodcom" -> "broadcom"
Date: Wed, 23 Jul 2025 10:53:15 +0100
Message-ID: <20250723095315.3999463-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the author's email address. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mailbox/bcm74110-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm74110-mailbox.c b/drivers/mailbox/bcm74110-mailbox.c
index 0680be8dc18f..469409d6d3bc 100644
--- a/drivers/mailbox/bcm74110-mailbox.c
+++ b/drivers/mailbox/bcm74110-mailbox.c
@@ -651,6 +651,6 @@ static struct platform_driver bcm74110_mbox_driver = {
 };
 module_platform_driver(bcm74110_mbox_driver);
 
-MODULE_AUTHOR("Justin Chen <justin.chen@braodcom.com>");
+MODULE_AUTHOR("Justin Chen <justin.chen@broadcom.com>");
 MODULE_DESCRIPTION("BCM74110 mailbox driver");
 MODULE_LICENSE("GPL");
-- 
2.50.0


