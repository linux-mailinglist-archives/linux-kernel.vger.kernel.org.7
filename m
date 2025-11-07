Return-Path: <linux-kernel+bounces-889751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54236C3E69B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFEC188B2C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD3288522;
	Fri,  7 Nov 2025 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFlwnPFC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D72773DE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488683; cv=none; b=iUMGpzzAtiw9eBi3ICxawHX1nk1n4utJ9uv/y7yGVcKQ6Po2RNZBdJODW0BNjzOrq7Gz3vizreInR7o95TFzmnZZNj+/1iUjpLSYv2OWbEERTMkUQtoShrmJL5iPSXOL0+y4e1xzkbOUl2XW+xbmmy9wp9BrgbvEQ6WFKKeVt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488683; c=relaxed/simple;
	bh=4Zk8MXXmDdkOu+U1cEM8A5GphCzC0fyVF7jnwu8pbKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFa7scmvbgj5dOcTQyVGwGl6PGjcYv7V5FNeqBYOHH9Jx6PpmkpDXyw5tUtIILruab5niYZux5/BXUnP7QZzgZ0T6ixvota5QBSx3SM5T3iBAhyGIQZ2b2eVLxfdTe8CiZwRIMvKTN/0MwfyEJ15By6/gOPiOzUnyB7Q44z4+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFlwnPFC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so311780b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762488682; x=1763093482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UB1bXzlzFcUbuTT9ZaXIDznGKcuL53MySKJi6hY373E=;
        b=BFlwnPFCfWpHAefcmfDFQCZSfkKhL6HEXSxhCM6yEP0ZyCH1D/9lJxi9nn6HqA3trM
         HS783KCxnHZGzc7XTGOXag9Qkvor4MJklnZwUGfOcw04HEiVtRPvHv1blIOR69RY2HjW
         Hrd/dUyWLZqruRWuiqfVoXlYvFXvvp1jNjJc2Yx4paYcEVF/5K359v8HQPREXKCGpebl
         OCG44XnvJTvhvldL2WOzFpGHZKfJbg0KLQR6+rFQDFtD2oEDsNzHyb2pLRLQINNI2MYu
         +P5NYSmC0QAQlgRHwdYEgEtezn86rkth3RqJpcnYFdT2IBhGsAaZQsT3ICEENySUjsQN
         YoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762488682; x=1763093482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB1bXzlzFcUbuTT9ZaXIDznGKcuL53MySKJi6hY373E=;
        b=fqU6UJtl9cP1twfrfmaY9f5otD3ylgKwLtKfDmhRHMJ2+hRmOshh84YWTTikmJcUfL
         6fE8DP+uebFyFWPgMQXUjOUdiImYbUOTe+O3N9r2TdfxIwzzhADZ4R+wSxHEp+ubNgW6
         ng0Eb24KlbKmIshWEZexTECWk+MKRocXh+sNp3sZ6J+1jwomG7KR2DfWVSPJ71Uyu+K4
         fVLdOCAtkSQw1gRBAfo12g/P2mWNwdBMrk4jpYVsgQddsxCrHf3Ue7dmuESNW6vXI460
         II9/fk/l1n+pxz9EHUh7Fx9i57K0xIp4B9aZOAMpLXnLx409o/nmLgihdjuKzCYPrAGH
         X9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVaDPz3PZdSDDEePQEpVWGDTQEmDtDEahkUMqJwH5oSJN+j8CAHlt7Ukhn5GyxtQZ2T7Ztx+ICnYbYhBXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3PIDeDrZFXVFe+a6YeLCxYQSsPGR49wRKe/7B+f70ZYZRfBD
	mxY06EUSBykguq28v1peaEHrb+Koomr2E8B68b92XJwsOg8gA96q4Sgj
X-Gm-Gg: ASbGncv/SZ2TWZcdvckWuCYE+bskVdqMSQeSLWgljOWaJtCnnW8yefEjz1/4eo0VYkk
	dYTfdyWXm9OB8EeTM/+sJG88ogxY+tiCql9F28pTky0UertQPSHT/BWOU5uv7ZPozUJ/xW2N5zd
	SbUI+QkHlIHlB6+UpZI7XI13nVnzhbwC4b69nFBR+pAgMQM720hcbXPjE4J6Y2TkPnGa+zU6ByI
	PGt5uWHM5Du9H5iB68jsnfRAx6IS8e0m9bS27ih2Dgmz4y+0W9tqBNtAKIvqBVHWFpZJfY1q5nz
	W87bAkqCiSJ8OAowqcdiBCom2e3BHcfyAckGvZFhz9eW/isIjrEiMIoywOzckZbur/RePuENmgc
	M1Yb+6n9ON7QFs0mBxpcRysq307pxDzxMhoUs2Wvf6ODjiAnjDaH8xbK1UL5MU/+j4S4VadG4ck
	DtH/+bsy9dvZwaYa0Q
X-Google-Smtp-Source: AGHT+IFTBdtjUvs97i0n6PZZPCRYPFFLtE+1ia2eL7OO1k3lvWBqZorflY6YekXtzcFlMjotdUuR/A==
X-Received: by 2002:a05:6a00:896:b0:7ab:75fc:f8bc with SMTP id d2e1a72fcca58-7b0bb81fc9amr2493970b3a.1.1762488681758;
        Thu, 06 Nov 2025 20:11:21 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c08ee9sm1289384b3a.21.2025.11.06.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:11:21 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
Date: Fri,  7 Nov 2025 04:10:02 +0000
Message-Id: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use of uninitialized memory in hex_byte_pack()
via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
If the LS_NLA_TYPE_DGID attribute is missing, 'gid' remains
uninitialized before being used in pr_info(), leading to a
KMSAN uninit-value report.

Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65..4c602fcae12f 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -99,7 +99,7 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
 static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
 {
 	const struct nlattr *head, *curr;
-	union ib_gid gid;
+	union ib_gid gid = {};
 	struct addr_req *req;
 	int len, rem;
 	int found = 0;
-- 
2.34.1


