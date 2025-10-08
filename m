Return-Path: <linux-kernel+bounces-846037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD24BC6D64
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 01:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9E6406A77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 23:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C02C158E;
	Wed,  8 Oct 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKAg/AxV"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBC199FB0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759964987; cv=none; b=Wyd8RyzrZwV6l2pUI/vjF4WmSGUv9fII/rD6zN+M+sW1YFKaF9E1I+hdylOVZFt2SuKzpmqrkkeoSxbUkdaBvnkQ6QbG9gURZkKWnDpuiEiSvqzSi5cZLZwxWyzSnAbGLgKxS/VNsGAPROK5DibRw6kbT2LcLG0mTFtTbxkyH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759964987; c=relaxed/simple;
	bh=FhRAN7vu1DLulCz3OzV9i06+tfU1UMryaWd3DwW2cjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aO9jVaZ4YrL1c7QKk0ZeFgdcPslcbKm+u/DSmrc8i42wlVot5E3GDAbp1ZPTxCuogYb0SB/ecv8cwqzGu3SH7eyTTm+BkRdx22wkdf3T7z64SOYUnlrlwaIKrlSe613vv9BdfPXJT25HUW864DJ4GAYxFWxtS7M9uY/I67CvlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKAg/AxV; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7a9a2b27c44so335839a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759964985; x=1760569785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T2bFk4SSl7P/0ekUqn9nNLfjSUxmhesNwRFAlv+rls=;
        b=YKAg/AxV2WYAczW/G5JvqtS0MnDUvhMRHqC1QzqpNR0DGzf+Sv7HcgxE/4VMQb+Y6F
         y0W60WGiZ6OD1kcwGW4v2CY2Aa1RQpmeWFgpMvz6uMxc0/T0N4JLGiLmcE4iOr6047T3
         KenOO+jSpCrwpwqOdvJu2mMhLHCMZEL7J7b+qocZUjZY3PupZ2HvfX0/27cZOygZ/2vS
         hyY7qgcbozlKG+KWsNJaTlGRchb6y29HUtg45eSCgwcE/3W0ioKb8CyJyzC/KyUz04EA
         ahm70wLLpwbU80psru7sTzk6ih6WVYz+rPuIBKEVwvacclKk1H4Sbcw5kmjwxmAABUzC
         F8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759964985; x=1760569785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T2bFk4SSl7P/0ekUqn9nNLfjSUxmhesNwRFAlv+rls=;
        b=kxRrCidld1FnmvHxgvOmIbIENJV57IOCY3yp3YmGZJFEYLv0G+yCmV+zIdoY6kzEAo
         S1LAWGjJM9cUesTEG1K0ToPHpF1jgtn4keH95Ri+KcFvMrVXVW2YPzMRSA0eP3ZKDKnp
         iOROscn7b1FdjouK/thSQ3CYEFVMF61qtXn6dmjLcttFdldL66nsyKzQbSc5HyO8QML4
         XUuVhE3SJ6DRqdtdTr/lkh5WaiqM+PfiJV+2nVInTg4/Ug6Dlnx0sfm98msFjSEeF+AR
         4pina/SXRilD6v8UL6AM5DdhnbeaVbNstjZzsXdaAK0v5GzJfY5tUfO43Cl0t/dSzp2l
         GB9g==
X-Forwarded-Encrypted: i=1; AJvYcCXWayRzUxt4nW1Y4xIEcVQuAqiVc442alq0D4AsCBnL3l6eLDaPq6RmnSuraW6whdIstE0U1C9VRyFr2dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZf1p5Akf0C0QXEEYQhFSqRBpcXh+naq3wkJWaI6o2wI8bsGUq
	RHLBtGGzPI0gmQ8VddXnNhhVvKw+jjvBduqDyC9NZrgQESe8YsIkBV8y
X-Gm-Gg: ASbGncsKR+yX/y01Z+JcPiHJ6yHQh+j7/0dhegY/RaqBBpTzyM5DXYHp448YIlwSNng
	VBUrpvkheNNEuDggaI/BYVpHTLgwLXweS3JLQhzE/Ki7lk8Vw4IKpF/SYm4JCgBzoUYVW2dXkwt
	DJ4/I4XScpfdXaZZ3p0TR73ttWE9TxyXqGuaX9tu54kTAnGMXzY4VcVmcE/9PjxvYTdRfc8L7R2
	XieO4guOFTXHweF/XWxgzEGJg3MP2VoFupog7wV6IF3xGEZcU0RtlYUHSb+eqBjg5/pAoYWVvlF
	/f4Vgan3IVugHRoEBh+99kV2Ne5JCgjL34lvXNub+ODHbomepXTUZU4zbOcT06yCGlvGeKP6ME2
	XNkzhqi6U8IIokSehAe5DLHdV7L7jqAFGi/XJkFNgj98dUAo5l+WDopxkV4hQg7z0SQ==
X-Google-Smtp-Source: AGHT+IGuTD1Noi9gIw4Wpud6moX/5kvZZcFur+/n3JxzjhZHmEaAEI6X9bG5JPTdzLylCvnEazTFyQ==
X-Received: by 2002:a05:6830:6103:b0:799:bdea:348e with SMTP id 46e09a7af769-7c0dfefa6c4mr2850635a34.16.1759964985123;
        Wed, 08 Oct 2025 16:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::5dba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcf8f1sm6141426a34.11.2025.10.08.16.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 16:09:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH] NFS: Fix state renewals missing after boot
Date: Wed,  8 Oct 2025 17:09:22 -0600
Message-ID: <20251008230935.738405-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

Since the last renewal time was initialized to 0 and jiffies start
counting at -5 minutes, any clients connected in the first 5 minutes
after a reboot would have their renewal timer set to a very long
interval. If the connection was idle, this would result in the client
state timing out on the server and the next call to the server would
return NFS4ERR_BADSESSION.

Fix this by initializing the last renewal time to the current jiffies
instead of 0.

Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
---
 fs/nfs/client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4e3dcc157a83..96cdfeb26a90 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -181,6 +181,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
+	clp->cl_last_renewal = jiffies;
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
-- 
2.51.0


