Return-Path: <linux-kernel+bounces-821894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA65B8290C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC431BC74F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C222472AE;
	Thu, 18 Sep 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GYGiNpPg"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99E23C8A0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160240; cv=none; b=tMfSF6vIUbLU9BRUi3unUhs87Pk8+DZ07oghTYjF6NB7AWdlz66m2/n+Ej8FpUzSmWfQNML5ECMNle5bBt25WlEWvKZhkrSJH5BWisVyZNuHmKwew4nnhy5mtWikQZNnAKKS2P7qx3rYciWgVvZv77+EGbZiJRIhV80x6FKUnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160240; c=relaxed/simple;
	bh=ZPewgPLefZDXOWx69JxVHXK+Ssrm/2Gt5VEh56b2P2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuXmCN5zTKzXmrhFNIdO5GQJo5JfOPmY8VGRERocgQHIQ0Kojir3GIiKujxjxrygM6JJQHjsjRft+yQtfCwh1gUKk+PxCYoK2Gfn1UmU9cqNOsOusfaH8EKf+WvsMJRc7ZsNBOBnCviOzHlnE96VY+iv8k052Kz4qXzmw9MSRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GYGiNpPg; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-264e0729c4aso908845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160238; x=1758765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sujA/Mwj2kDqTmjgWypKS2wV8GGpmOhayMT/OiS8xA=;
        b=GYGiNpPgtrex3QY5hwSgKW3u/1UD2BdKyd0cr1dQWV5/f75xqbrPorzjl//1HYLSsB
         yTEqlp/KeGq4V5nm9olfiZscsa4cFrladH5eq/+gPlyonxO4WQQlJf6QRZvsA/lyr7gA
         BR8VQpXXDbgSqPYsMjX121ydJW9MKcZfWF13udN+/kkcU964kjqpRijtSieWGCV1vOEl
         lZJBcgjhV7HdIqVV8LB9CT/B6h4Rgnq86izF9/hrPPtIkAkRFaP4b4M+WSLuSrUZU+2U
         9C9JZ0mLa/nad+T8p50TVTfq0FDk38y8t0px6DpCSOTcQrBArEApFLTDGEmnD3clQCAK
         s7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160238; x=1758765038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sujA/Mwj2kDqTmjgWypKS2wV8GGpmOhayMT/OiS8xA=;
        b=IhmNwhui6gNvS45jUnxxf5GuV3lNbb4PYcYzr5ovXUtgwxIa7ZN1w55eJsoJf6zbNe
         /qArJN7GZ4HxzgIDqXH/828+RzmNDIYTbcVth4AW0xDsU0h01u4ctLI0rcmZ/cpOoNGd
         gU6pWRVWnO74wKlsT4pVTJaKWATgLz59qje/VIg+XygBjzFr9p23Fic6KvjEg/kGw+og
         k8LL+ui2yrbcLImdxfpLBUA7nzveiKBOHU2d1jq46CTf0TG9ZYpqRCtVFQf7Cdqq3iuO
         wvFp9bk9YD7RCtKcoZe06s2Wr3N245F3OpOWn8Xmre87X5drWyqwJl5DlE8u88eVNWY8
         DNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW964qdP/qhHfEdDOU6E75aO5bQ+NuQfBtIIV7RpbBWErNM2He+q++tn/zIa3CqIFQoRE2zgZ2BL9kxGno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPINqF0SwvPlaj4z9JHmOk4Lezl+tbjESYTqNiIdIyCtSKe5a
	g/Lf/U4sBxI0iz3GzizcQc3jJ9U6eDtik57VQdeib4DHy7tTqrSXuOBBvLqtCk++6XutFUqdxgT
	wRLMEG5kTGHNOR/YMrmd+KyXxHVhLtLfu8UT8
X-Gm-Gg: ASbGnctPz+vikDKd7O+cMTA7X9UdCUFtijN96Zd/WUgFrCRV6AEYeS/rDGiN6F/EFxn
	OhGbU3DNhtGvmeE3zuBoHFN8Jlt0h7yYngqftHjO8F127olEN6dTJDXqS2FPGiG+t0qdCouF+fY
	t8JBNOatP6kV00x+QzC1/d4tCQ6T57/eEu9pdl5lbn9+YSUfBid2GM87hdnd5xJ4rZDuyP5zylp
	T/Z9wNNB36kdxGhdNzX04YaJORtwsErO9AASQmHdsNNX74kYRxllmKk/RjT5evqlGfaBAD2nXE7
	zGg+hvKtmy8FNJoF4AQbCETe38/BmQ+riDDv+mWB9bXmhPLZ0xfUzVGwSfuksC3GBPjdrY46
X-Google-Smtp-Source: AGHT+IEfGwi5Uf/eDYuTDYKzX2zNObQ7fCQN1nE67W9r2agd/jqP5l+mN1MTQRTMObFyfNU2YBGdUgBoSlJ8
X-Received: by 2002:a17:903:1c3:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-26980e2dac9mr9818105ad.7.1758160238076;
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bbe62sm940235ad.66.2025.09.17.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6950E340325;
	Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 65ABEE41B42; Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 09/17] ublk: don't access ublk_queue in ublk_daemon_register_io_buf()
Date: Wed, 17 Sep 2025 19:49:45 -0600
Message-ID: <20250918014953.297897-10-csander@purestorage.com>
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
ublk_daemon_register_io_buf() is a frequent cache miss. Get the flags
from the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 751ec62655f8..266b46d40886 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2167,11 +2167,11 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	new_registered_buffers = io->task_registered_buffers + 1;
 	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
 		return ublk_register_io_buf(cmd, ub, ubq, io, index,
 					    issue_flags);
 
-	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
+	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
 	if (ret)
-- 
2.45.2


