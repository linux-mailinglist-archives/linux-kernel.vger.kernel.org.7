Return-Path: <linux-kernel+bounces-868438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95EC05342
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63D95502C18
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956C7306B0F;
	Fri, 24 Oct 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7XW+Trt"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37B2FC86C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295792; cv=none; b=qFwCQLagEsFPWaqfWc/cFzJ6SHEmlFwyLzDEqfVkQMvUGZhlONxhyGimqp37qJ1tSPwwFDpXN77u2AOIWL+a3O91FiviOgSbwC7QJabSn62Xkv5/yEtaq5+EnfYL7n0pjW87vUTt0HAr2M9FOSlk6Xf6r6uI6mu3H5eUyXSEtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295792; c=relaxed/simple;
	bh=7CMLhsyi8RHC5Gc+82TW2aO/QzGgNNTW8Gr54I7T15c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FE0NBfxTK27vHeUtWNE9vph3BlPKtP7trDevdaf8wUg5xetXTbwI/F33PmTxttPbSZkll26IzqrM/L7sB3eAHwwwDq2z7csWz1BDcIkXZjkEhe4bo8gyUkW4YiTei0i3/my4R7JTGAu1H40oNARHU9AoDwQaw3rQOnb4S9yJBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7XW+Trt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so1217812b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295790; x=1761900590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=be9DCKrTHpiIryaMvL91sMS8lgrWVR8oTSh04xQEuZc=;
        b=B7XW+TrtpXGBxRU2KNAfAi/KSExowrbCC206bH4Asx+bPR1/mwtcGvncAOl99sSA+s
         gLT1TpTAnqElejP2yVtjXOIRtN/2PXPCiiEe+FSn3WoRnkAAtMH2tQEMcbib2im6ydcT
         PZuwKP0eeDbgPvCnP9tyR6YP+RZBlrhXnQGmjNonrZeSAZ4LTeXaKHZccfqiF/2g8Yiz
         DMPgpq/yVjSXX5K7YHc2iEyNC05BOIHo6Bx2XYEYsyFH9c1icrskilhYvGKR9GTtLxOG
         21+73XdgSN/Hve5KxXk3p8/IvG+PbRUedF5dxRZhbvc+PdYL8+OYFdsbv6l9vNpXEXlK
         WYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295790; x=1761900590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be9DCKrTHpiIryaMvL91sMS8lgrWVR8oTSh04xQEuZc=;
        b=CI3u003Mni66ai8oJ+lgiLdMjHO8sZWNpF4QUFY7/fKWYtWq/vtBv+Djux2w4gmzeA
         wfP4zu05b6hoclsR81uRictCNY9UyMJNoQlbSGeFAzEVUk4aWD55cMqm0fO6zffQSL+V
         tUMt+t0EYrfQXi+1C8GEdKqZDx6+JH0UocAV8YsT1T9VeRwOIZ7bjEba9lPmlRWtEZ7T
         EifnyEZtOIy7WEmc3gUy7AIZj7lIDLirYmCSc9zVYzGU8DON5wbA3A/CRhCtj14ZbNd/
         dtVC+b/9vBa2jTLl1AxNgDOUUSgBn6K1gnZ6VdHGdlC8lwjQWrEm1zLCHtbYpvvXNUau
         HluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl12qj9yc0ybDaUOmPnx+B+Rvr3ddHTRdAcYKu1OWFccJginYthSr2/QSLVZ8bVv8Mh0vHgSmUiqfgmOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JdW1WHyMVCbu8+q5h5R2hXmXzRR+yqF21qDOH5okNJ8hR8Go
	Rl6T+b3tQqziEI1Sisr+lQFv/UFH+ejY/67vripes7+7Zx4rIFOvZ0fM
X-Gm-Gg: ASbGncuyK3cti4zXgfqttfXRDehjUmrqotaBNlxPWBRJYZn190CG8h0dEJw1tmasDA5
	gmlWNofjem3rKgGchGCFf07FLtUdCAtWN1CKahBLS9pthCiRWt7zLPy/4SHH4j0/zs4s0/roGH2
	x5vyQl0HKUgrrXuU+Di9JG7yDDgsjx74oSJtCa20JLUXJLeQyll6Y+Ko69Lqjf6a+6w8+pyUOmG
	vjWvMJ+XGnJB8ReO6RK7I9JRf3ZN5HbtWBpxnP46uvhhT5FwzVFXQlKwnsSzzRnDW0K0+PTIWxx
	/EfMBSTexk1pJuvoyCDRaZGIuMiMWF2HAN9ln086BCLKa0Bs1m8IEf+FtHbMEcHPBSVT/wcQPWT
	C2A/OgjIC8yWYGqN9GBj33rzkuJQC8ipHp+EZNciVBoMbKigVOOFsl2O/qudGXlX5hEkn3m2mIA
	Rt8xofFF0=
X-Google-Smtp-Source: AGHT+IErebRAdRvYuPVFvY/KrwtCyAozZVkTU4P0prhGSo763KhyXweOzp7RjW6bXalnbbU1d8GxVw==
X-Received: by 2002:a17:903:3d0b:b0:290:ccec:fea3 with SMTP id d9443c01a7336-290ccecffb1mr335960345ad.42.1761295789977;
        Fri, 24 Oct 2025 01:49:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2578bfsm48029025ad.112.2025.10.24.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:49:49 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: yt921x: Fix missing type casting to u64
Date: Fri, 24 Oct 2025 16:49:13 +0800
Message-ID: <20251024084918.1353031-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..8baed8107512 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -699,7 +699,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			if (val < (u32)val)
 				/* overflow */
 				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
+			val &= ~(u64)U32_MAX;
 			val |= val0;
 		} else {
 			res = yt921x_reg_read(priv, reg + 4, &val1);
-- 
2.51.0


