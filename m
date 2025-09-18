Return-Path: <linux-kernel+bounces-821897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22DB82924
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171041BC8D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2D256C7E;
	Thu, 18 Sep 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z0ueULhW"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A423C507
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160242; cv=none; b=jpGCjcJKs4gVIyHBHW1WBmR9+vRtIZt8zYMFe4J+8vX7ZkVw8S9pUQFDOUk5DgFsmTy1vMgYq1ZlXX8UgtIwJECPBaMYrIheoJlCPEU3JHiR99nwxtD0eQ7gqZ7AK2BOE2ukw/gdyGw/7SUf//lFmirU1+9wnK1+CRyWJm4cpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160242; c=relaxed/simple;
	bh=SxYD5WuHLRPoT/cs6wVVOR8hP8iZlHeIqgfFLbpvcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNap+mBgsKR65sAJRufQmB7/4UqiZwb+jWy1n1hZu85V5tpSoYzxMntLzpVqE030xbhB55WKqqLhM4WgTIsn+HbvgjiOSjzJknekL3sdj6FyjOAcoC4KyNOkr/ZOwEiC2LJVw+klDDmFpyznOVgTLJUmqw3g7txXXqA0Nsrij3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z0ueULhW; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-4240ff5652bso170425ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160238; x=1758765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHN5LrAZcA9wf+X46VWuoZMibI+SFl5Bk6BxNvNG8fQ=;
        b=Z0ueULhWplm7sJ2jk4hAVpBK2/dMWxuGipITS705kenj4lMxohAZQpFXOyIwvaVmKx
         2t+RmjXC/c3iUk1sLg4bmFgv0btgNLpb61+qfQp5B2ARXzjgVV7YDT5JIoOACOQ9o1HM
         kvn9m33SCegdXETp2Dr5heihU243+4CqbOn4RZW4csGFIfz63q7q1LNIQ8xxIFZEAL8D
         GNfFxCYsQTw096AM0U/17eU688UmSdXil2xaJ1oKqd2FcNzRBQlmE+BLaBtHIMBrqcZN
         zBFCM6DUQwElwpyacbhU0X7ip/PlYEOW+DbXBjpMn1M2JW8ZbP+GDtR1pOEc/D1H+8Oy
         2a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160238; x=1758765038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHN5LrAZcA9wf+X46VWuoZMibI+SFl5Bk6BxNvNG8fQ=;
        b=LZpL6qMneJ4LypWgLSS/pA/d2NJeEh+1NNcDLedkjldUOTAns4fTCNn0FaJ8za2INR
         pc8am0tX08HmNk5zRo/M+dHim2m4j5vC9jvyefWpI1y2I0coSyJVXjP6ebDJocjINKKh
         l9CbxMxFuUeOFIqCjZPRf3AfKQwC0cr6H2xMKbQWZBerhSglXEiZaJtoGw0CiR7jgaFF
         lXp73dPN0IoYlXPN9xtiGOf9ErUF1sueGsPiE1CzU3IoT9HCSjt1OmbB4wV61/TsHjB6
         znylAB1eih7I9O1fhiLT9PnniLW62A93Tu36rk79yBEwDOoBDjegoyDhqklpN7DqAhE3
         mLIw==
X-Forwarded-Encrypted: i=1; AJvYcCXDXbwSdMb5N8ULyZ3yKUl8mPLsiC+RWuQecD6kWdYIGHlatKcox/guI6HIrJHNufkm9+pEl4V44jGLH/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YwcHWtL2JOBghpvKaJ9hEosES7A7bo2F7hJSDjb7Y+bYc3Gc
	12/hB07MKOt4XHxd3UEmJ5K1uwURmPZbhQZwh0Urr9kKSu4MENVMDGciMUXGqD9U631LlMqaGPH
	eMJfUcGigtqCeNJsC5czorNvSNZosHsg8K0Ez
X-Gm-Gg: ASbGncsyC4NPpin64HAamXlZVL44NkpmqIEIBVWzFQwBGDibOhE5zgCw0mAlmes/zIZ
	OliqV4G7VQu7LmzZ6a3Brc2HtWJbBEaHZyAddTiTQphHCfG2SobQx5beYTXJG6axZHkY6qAZDUh
	GEGHxPo8HXTb9KHPV6iToXK37bzZoD8LpdzsSKUhNlJO4pvLcZSm7Wk1nUd8pZfiIVzqt4QPNHC
	3GtmZsUHN8UtmvQHXU9Ov9QurgJBF4j/BN9bdb3gxl0oV+I815V9HKu9G/V02BYjItjMl3dayrZ
	EI7ZUHRh/T4CrO/B4E9Ua36vlvBhe37kgqcBtH6F2fo89ei6awCt1i0bncboL11p/lGHXiqZ
X-Google-Smtp-Source: AGHT+IHg9ormGeHNVdb3lk5wKhpVB+m7oJDCUTFeC6NzfM31elgAomyyVQtn+PodMnXbWY3OkRmL+hjR4jJD
X-Received: by 2002:a05:6e02:178e:b0:415:8117:d417 with SMTP id e9e14a558f8ab-4241a563cf4mr22899405ab.7.1758160237761;
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4247353db28sm47175ab.32.2025.09.17.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 1E83E340508;
	Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 17A29E41B42; Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 08/17] ublk: don't access ublk_queue in ublk_register_io_buf()
Date: Wed, 17 Sep 2025 19:49:44 -0600
Message-ID: <20250918014953.297897-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_register_io_buf() is a frequent cache miss. Get the flags from the
ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb51f3f3cd33..751ec62655f8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2131,11 +2131,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct request *req;
 	int ret;
 
-	if (!ublk_support_zero_copy(ubq))
+	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
 	req = __ublk_check_and_get_req(ub, ubq, io, 0);
 	if (!req)
 		return -EINVAL;
-- 
2.45.2


