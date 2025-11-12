Return-Path: <linux-kernel+bounces-896489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D17FEC50827
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5703434BB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26C2DC322;
	Wed, 12 Nov 2025 04:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoE6Xg4Y"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431822D9798
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921700; cv=none; b=SGdp6ep7sO5YUqBC8JHgeRreRQLCSijb0wW7/JDUphAjHUtEuajUF86n3lHSZnnBMaoWxeVag76NsaSE7Y017x1lL4IclXgv8NbAgAC0TTnZKeh8y3cjni+hzqrq+3+vAj+MGxxDf38uhzH3M4sUepiIRFNMUo0TYn3uIv8nBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921700; c=relaxed/simple;
	bh=jaHChIsFwQccM67eVRPs/t3TxiMgA+k62NpjHrap2Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BF7zl94VsOzAFM/q82LMxlYdpTYhiRHumBRiL6xzw7CFOdEo+qwpT1LybgstRiAGoHGENr7Ji6+/Oi5/44xGIqwNaGQgzAd5GwwhVmViZWVadG3WdvcqV47HpE2qM1aip63OFVl7cpgphzBLPrWlikx5meguksWpzsettmg0vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoE6Xg4Y; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so362334a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921698; x=1763526498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=;
        b=HoE6Xg4YO3Umx5sJsEPhcNawAdjSYIbUpnrsed1+S0199rZk+FR1EoJ05G27zsSV1D
         UyShQv71scLUb6Vc9VZnQ4PA+aHxA8KOThr75eQAWCOfVsclvUyRnocbyLKQaION8e5i
         ugAw7DAisys+tRTUtRAZiFOWw2ebJSalNIYMUFgl81u9aMO6LnHJShoHh+a9MfKYhjNb
         /zq349rCkoAYeqx5jm4W1nZyNKhaMYEuIe7L9mjwiMWYNWT8VaTaLM5eeSDmk6ao3rHP
         5x8STq0+j7NmQOMOcRQsO/2zHwuq4CKefPlQ9zoasrzvYbna+nSTVgE6ExVuc7KNb7cX
         xgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921698; x=1763526498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfXE4RQsTo13oDtpS18/YqY50MP5ENyfIi78Z5opJm4=;
        b=Bk8uRcUz362MLiHpso69qcI1A1Z5HM5V86dQHYTlz0PI+Hy5C3RMis4YEhDUCQNheY
         AT/rRXL3J5WNXp5cXGMjDMWIIAoMI0w7lwAsp4GtE+lTpyPKkfdGvRNdr574hLREBViE
         orxKJEUTWgA8jixikyPxgEp8sCqe9BBPcNfNiJr4dOriKqsujil0u+5tX22JPSLyTIQv
         TpoSTWvF0egvbntr4xOaBUTJblypPVzYce4HXQZxfQ4Dc6wIVC6TZs0p+F+WlaplTZ9M
         5Uo4uE1GhNkZigMMvq0D/sCf1eEwbcwQiLwHwDcVdqGdej53shophCxlkm7Uyt2rdBgr
         JwbA==
X-Forwarded-Encrypted: i=1; AJvYcCVFXLHLAAlB3DxYoiv3grndG/HuW76xgWokBfniSXecvsjE4pMyEhkyQN/MO6yE2udgMBYgvT2ZT8CVpxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBdE4mLeWXkuwt6u3RMkvzCLQu+N+u4XvZQCb6HHHC+13vsrE
	tKobCEUohxgAOdri77OilIYgcnOindqdBKGgA6ed33JMZdNObeyBWEuYREm3IA==
X-Gm-Gg: ASbGncsdoSa7g0BRZTXIj5kP7rf7VHUNug2YIrwF9onjSU3TFFt8+EMllLf4rFpaNRZ
	AZy4UluMTLu7QUvp1sthvzi3nz23+O78lkbVDqF60IxsGvaA3Wuw0/mffvXVRmXpf/H567MaCSj
	wtdqKCaGpOlSVTm25MECv4rP3qy+bDyuKGY8s36EYy9Kg5+s0sQbi8I+7T6tfXpNr7D3kLZ29lZ
	2xPqx+tmWJFsvEoIF/OyLjGgi5rOrxQGShiU5qWHkFrIF69NANd34g7/yA/EwYUzxHKQSr3G7xB
	1w+ntjmaEBJIXVV7XeheORSisjjH9LagG40QfXTCrDxzjC0WRfxzK4shdkbY8yBQa8qDzS4cPmY
	v937Ww5wbRKSBkDPzb59BqA3PCyfdzSuwNG5d794Corm3zqB0xtrYrObVkwa9RTlgorKhUxIJZY
	1De+BPKXYhmOEWVCFYA/CHuw50nb0W0EN7JYCnMQemHiWHXeswjWUd/EN1Cf1wyGDLTrAtXSGjx
	svIaWEzAA==
X-Google-Smtp-Source: AGHT+IGasMEo2f3YSuRreEs/8zog7GQY45X0or6PmRJCkVtaVHjxXqWGnHYHC3SejrjGvw9vVcyiWQ==
X-Received: by 2002:a17:90a:fc50:b0:343:a631:28a8 with SMTP id 98e67ed59e1d1-343dded5123mr2073086a91.37.1762921698484;
        Tue, 11 Nov 2025 20:28:18 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:18 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
Date: Wed, 12 Nov 2025 14:27:16 +1000
Message-ID: <20251112042720.3695972-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Define a `handshake_sk_destruct_req()` function to allow the destruction
of the handshake req.

This is required to avoid hash conflicts when handshake_req_hash_add()
is called as part of submitting the KeyUpdate request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v5:
 - No change
v4:
 - No change
v3:
 - New patch

 net/handshake/request.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..0d1c91c80478 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
 		sk_destruct(sk);
 }
 
+/**
+ * handshake_sk_destruct_req - destroy an existing request
+ * @sk: socket on which there is an existing request
+ */
+static void handshake_sk_destruct_req(struct sock *sk)
+{
+	struct handshake_req *req;
+
+	req = handshake_req_hash_lookup(sk);
+	if (!req)
+		return;
+
+	trace_handshake_destruct(sock_net(sk), req, sk);
+	handshake_req_destroy(req);
+}
+
 /**
  * handshake_req_alloc - Allocate a handshake request
  * @proto: security protocol
-- 
2.51.1


