Return-Path: <linux-kernel+bounces-847491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949CBCAFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B1524F7DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08072820DB;
	Thu,  9 Oct 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcCuH4Iv"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319823E347
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046501; cv=none; b=U2rd+LXEFW8i1DqWg7ylfvUqbRApipa/uHd/+nb2yeE7QXwA5YoDqw/i3tk0t32waCHm3Zl4mqbm71euvy+cDRemna1tBbembwVRD1payJQkareAxNDM/nhGJsx+DYWXGhiSRpbLo72mXXIuy705vRPdZj2HP+H+Gl5i/zw5xI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046501; c=relaxed/simple;
	bh=2k32Os9eIrTe7QJPbw6wYOac9zaygttyiU+nsidokpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGZfxho3I/XEHFuAi0avNdlTa1iMC4RyDKQ5fc1/ELugemVLUbgTbejfYA71pcmMYI/olvarAgDaJl6e3PjdN6jHsgrxBg5Fj+isRhQEy5wztKS+vlwNKrf1o3TVag+m/oH4nKZDVN2odD58RGqNnhVhcZQ5vl4pvT/xvu7pY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcCuH4Iv; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4291359714eso12846545ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760046499; x=1760651299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/wlAhB0t7MJI1w6PibKEtk7MCGbcm49V87OzXgTCKs=;
        b=IcCuH4IvdnF9DkOn12SdHcYv7rO3/a3BYLPw6x3tfq/yNj19pUVPnAG6uCFWxNADjC
         BreWB8B/PyTcF8PjJI2gpL/DWxoJmFNzR11Z45of333aCVyLFF7NnzSMgLwbKD1eJ6L3
         6tZScAGH4NoH+Fqfv+fqheVApXnWR7pXklzuOZ7dfHKmVY9vhbspJ9Q8OLNzW3zRqu/p
         DGJF7hQKUFHAZiGpXDj3ouR9AifRIBQJN2eyEMA8jTJF3WYYDgodS43eUdd/VSmntE3b
         B/kr5AVuDEIdPr9nRiMKENJtokaFSunrdHtyy5zSXb9pXbqbZWymWfdl6nyt/iQP3QBq
         E9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046499; x=1760651299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/wlAhB0t7MJI1w6PibKEtk7MCGbcm49V87OzXgTCKs=;
        b=X8TFcaDq/FMKxyZGOo/dMcB303vw4kuwi/Pqg1KxQ4vqEsXd34HbRpKHyWo1pzYSfx
         oh3Gg8f4q5C/wwKh4/G8J97858STjwyxfvLmHauxNTLjbEAvq4UwOyxVuoc2x+iQFa1X
         6N7HZE8VM3tlYDarIEvnw9wlh/w+pYK7ygDkpZ/nZSaS1mxKr6k2tCPNwQEc3+w/AEWg
         GYgXM5Y5Ik7ONGGlGMJnJbAjv9xvjLmGJUdAEDm0njf8LNGRGLF3bMKIKXndwBTpKmf+
         opW2cAU32jiwuy2whfX69UPn4E+viA+cIjRnaqxZ/o3l0SPWTVWtfHxoEpiyjrg65UF7
         tahw==
X-Forwarded-Encrypted: i=1; AJvYcCVSutWHHZt4qZfup4X08XOLLsFOSpXIQMlAy3y669r7uDAztsDwCDCMN9VBqQiiQqSry3ZxVknz/tVljgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJ9tK3sYYSGO1zBClqsSG8XhdbZxtWQcaxt8M5rMlZkvoWG6Z
	GCULhTyIseDvjeuCz/SlDAvE74IFrpL46tGhb0P1JRS9eYihOA8Ygqzu
X-Gm-Gg: ASbGncvobkVoX3EKIaJeLk3lDmAQ0RvW5BJ5xdnM2MMxkjXLzlJWmVzsdBRWNfDLn/5
	mqG2C1kYmBWBbiMwlW23X+QjKbLVdGnAdurmHb0K7I2hhn4QOQ4rD2gEKAp00k6hAtaU45uiCAp
	JG7znSwHQk8HD5ufZ8AN1OUSOqotR7ds4mjHf8AFys4izFUlXyRief57JovrgAB01nCVZNPuHKJ
	yyPNnJCasKRTwVG6TIz0Vlrsj2aVXjrVk3FCB6UrzeVJ4h8JzaQyMsEbU2ykATaEmnC2JQ9qkmB
	5ILN37wDoS2nUNLDZeYCAp1ZvyTB3t0gA2jwKqQjEW9NPBKnYyjiR/njS6ZmqzssSCk1yqeeAmj
	lidEmvt8HxjqUpP2hTnmFLHOJEayZrAz0RQ2LNn6rWxmTt8cav0qHvYI=
X-Google-Smtp-Source: AGHT+IHXtiX23n0b9nObNHBVv/31QlIVfKtOm+fhzHEy/7QgrpvXeK05ovQm7WFtNIZMMKH37P+wAg==
X-Received: by 2002:a05:6e02:248f:b0:42f:8ae3:20c with SMTP id e9e14a558f8ab-42f8ae30b89mr82184375ab.19.1760046498601;
        Thu, 09 Oct 2025 14:48:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::5441])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f72109fdasm214388173.40.2025.10.09.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:48:18 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v2] NFS4: Fix state renewals missing after boot
Date: Thu,  9 Oct 2025 15:48:04 -0600
Message-ID: <20251009214810.966201-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008230935.738405-1-JPEWhacker@gmail.com>
References: <20251008230935.738405-1-JPEWhacker@gmail.com>
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
 fs/nfs/nfs4client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 6fddf43d729c..5998d6bd8a4f 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -222,6 +222,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
 	clp->cl_mvops = nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen = 1;
+	clp->cl_last_renewal = jiffies;
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
 #endif
-- 
2.51.0


