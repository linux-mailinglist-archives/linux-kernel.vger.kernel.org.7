Return-Path: <linux-kernel+bounces-801225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D82B4425E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E289B5A297A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658B2264BA;
	Thu,  4 Sep 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HDP/MGHN"
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB682EBB92
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002349; cv=none; b=orwUvFj9l7D+D+JvDd+HFDHtyBcI7ZTHEBTV89zYkZbzQ79b64kANp5uQrA3NdotVS+KxjAiYJy6y7Se76/BkEyvS/LbVTzXMYfpFDQd3Nxp3TGI6q4bK1fipQG+3dEWlEYYYtoVhUt0Ebelg0QYLdZ/aUy+8cninY0Z+z+wHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002349; c=relaxed/simple;
	bh=9FnvyBaQhgL217zbtYg3CJx4Xsf1/txFXu0ygWQeOfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epKKhzWZWjD/L1yJwItpcU9y2520GTLt1BkTTXk8sl+xHr3rJSa4BLIa1tGv0DRWUMoBNtukkM3UzM6DWKG7tKpWR270k5vtKSeUcr4az+Tpr9pifzVaz6NfCEU1Yznjxd29xAFtixfD+YcqlFeK/TcVJz503WXUv65ncp0ZNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HDP/MGHN; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-55f76d08836so217046e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757002346; x=1757607146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsxIwM3/sFeVcWsdnOzOxmcx7zHrThhqU6pbaZl6QQ0=;
        b=HDP/MGHNzM5uuWkLmO/MiwvzakhReddfXfV+xYctSUq9JpC53jv7JFDnWfkoM66Nir
         /lb/FR6rYZwwY/b/47IeenUTBcoN2zWzqKHak4Nb9fb3IEPd5ivRIAcWc0Vuklxe5bbH
         +RRAUG/kdSuyN9ilBVL9Hx3OYcpJ+xO2yoI44alIqw4mz1H9fxK8GaBD5PgkTviliIbT
         KgmDJ0TRVM9qyRFumgzG7RzqlxpOfL7a5SSIKCARNft0CWsQLllvjSuhFck8FsGuBkWZ
         HRBK1Dsf1XahgKTmcmVPgdnhdMeOjceGq8tp/IyTSx8z1PNpnb5bwgMKmaW/5iDoLpOb
         dHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002346; x=1757607146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsxIwM3/sFeVcWsdnOzOxmcx7zHrThhqU6pbaZl6QQ0=;
        b=ND2+Bq/mw6oO0Po2TWa4+5Vgl56eqAElNmcJROskEx+7FefXAzGe7AwvQhS4Ukptcg
         bMqUh5tSsgTkre9u1oZJxOO3L60lfpnQ7mrLKWpZ+/kfjLZyNjCS1T8FvmFUoXJ11KCc
         Af5SzAMTgm8Sxu1AB6agAYtBnHth2aUmSiKY9PyoJ4fnWYXDlapsJnx5clDi/4uOz9tI
         ghkG6JCo4FDpXL7+elkYBLxtrfyClhjwqH4+tTIVHkkp6h4xjNGJcxyIGm5qIK288XSs
         lJuK6bgU9sYq2up3HTz+jDdodFcOvp334oErzBFB+cCIojiPMQYvI7eGj7Klrprty9ZN
         XvVg==
X-Forwarded-Encrypted: i=1; AJvYcCWV24oXtE+Sus/+fQhmdoY8NjsOk3pF8UpDgPkwW0b9U4y/BGRiZZHz9tVFd5XjTlS8w9Cf1C0IEwYcKYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfTyPZnvvIMjFbFGRjF0s5QeCyz7c+r8l3xf294iMO8o8jTZ2H
	bg70aVQBfiIGIdZ0nDPkZIYh8fKh6qDOmch7Bu1Q+LWr2eciaeAx1SIoFg052fGhtQsAMxL8U7E
	fX5l4VyHdsMYsen/mf+7pBB3UDfXuUSawpgib5zlorw1a/LoLiT1P
X-Gm-Gg: ASbGncuyf5lyhaVNj1f0LaqiaNyWD1JjVLUhFOuFmpHGAK99VM5Zf17lykuliyVMlmO
	ZOty6vcde531XnQxR9S2MkaCs6I4pC8xYsmb2cFEGBY404Bs+yPYP/bTyPpRcIPboScG18WVqFe
	8Ohmxkqc7G9XaJesPnK2Ymo6PAPWjzaKMT/YXMdDXrcggq1i+ZL0J3txaWvAeoWx+cb4n3EiYZ6
	tmWFRcR9mZmvIdCfOmvhG/7xafUTqoJPt71oJ+npkTKoDLZmQ5MNfhuMdY1SWZjcwncok0Dbmyi
	Z8nVVxyjxNSBfIkdgxiYC/K6v89K7Af0iWxqqbXq3Ps3yS1ph12mmbL0Ig==
X-Google-Smtp-Source: AGHT+IHMiLSuXrxqntjfGGMbldL9ObUKGomVHhB/Q3Gky1ZLsT8NCICYAWZyHvIuOFfxm62c5xVvIsEoODyH
X-Received: by 2002:a05:6512:124a:b0:55c:d7d6:69ae with SMTP id 2adb3069b0e04-55f6b21e202mr3578815e87.10.1757002345650;
        Thu, 04 Sep 2025 09:12:25 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5608ad4d44dsm1002087e87.64.2025.09.04.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:12:25 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 11533340647;
	Thu,  4 Sep 2025 10:12:24 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 15EB6E41920; Thu,  4 Sep 2025 10:12:24 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] io_uring: remove WRITE_ONCE() in io_uring_create()
Date: Thu,  4 Sep 2025 10:12:22 -0600
Message-ID: <20250904161223.2600435-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to use WRITE_ONCE() to set ctx->submitter_task in
io_uring_create() since no other task can access the io_ring_ctx until a
file descriptor is associated with it. So use a normal assignment
instead of WRITE_ONCE().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6c07efac977c..20dfa5ef75dc 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3889,12 +3889,17 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		ret = -EFAULT;
 		goto err;
 	}
 
 	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER
-	    && !(ctx->flags & IORING_SETUP_R_DISABLED))
-		WRITE_ONCE(ctx->submitter_task, get_task_struct(current));
+	    && !(ctx->flags & IORING_SETUP_R_DISABLED)) {
+		/*
+		 * Unlike io_register_enable_rings(), don't need WRITE_ONCE()
+		 * since ctx isn't yet accessible from other tasks
+		 */
+		ctx->submitter_task = get_task_struct(current);
+	}
 
 	file = io_uring_get_file(ctx);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto err;
-- 
2.45.2


