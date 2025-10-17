Return-Path: <linux-kernel+bounces-857238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8DBBE649F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272B1407B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7530EF75;
	Fri, 17 Oct 2025 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VllHUtkz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF630E0E3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675026; cv=none; b=uR4mzWaeIcPwgLuVwGeTUlShAMIsm/CQ7m6WNip/quWNcTmul993gSsJ6WdqGBjCWT1pGUhJx1GhdaLeQRRvN8Py3CXBpNx1IVbDTT2nw0h3jZXz7yKvlOYA3u8IUPlUoIYgfVlfkjFcqLWKEtz0lKCqJGXVme8UrTKytxDLj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675026; c=relaxed/simple;
	bh=37YeEv3sX+mmDjcIQ5fmoI0jB8MoKSf0MBI8d/gZIrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsWuZ/LJ7JJQrpncDWer6oQbS97AF5hC13Vt403QXXlUE/oEgy0+UYPxdniQpVIxmJ3mcdaZ4qKldNEOE34JdvEwV0P0JEUaQ+59LHFc/n53o6LKXdaJNgyBL4QS8bTo9hQVyCz/S+Oy5DfHzlizm02nVdpjDnNwMeMptRoeeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VllHUtkz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269af38418aso15271055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675024; x=1761279824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=VllHUtkzMpkUXDvPypYbSO7h4bOUgAdTvvSKA0faHZYqPsXz3wQX/CK2IaTCL9+7jc
         3y7IrDez1pdZREPnV45jiEcl0FXjMh3E8OdTG7Gw5Iu9bAryYuxNucYUQWFpNDOATIo/
         5KVTpWnIioxUCqHO2oPvEaBixWNCGtfGrhyoa9mjqZQaOxjQybUYkzRAqeBUNkqYzcRK
         XiRAHrUxXPKXFE7J/OSXNDyXNn7SobMth4W5M3eGKfKTlmk8nXIsTShtpgS/wX26O5yu
         V/mVww6ON1msCEYb/3cODPaOOPlFJSc/QiLTiVOzeSuJxboqBXAWYIpVWgVGGJxbFmJK
         AV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675024; x=1761279824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhR6OqlULE14euOr7SOeJPbIcbHzF9rdhJ80nFJJwb0=;
        b=hUwCOWBUtpaMs78EZMsobgdJJ/HGH3ZjKjDWEieD0ydVUyciupVSdNMBzotcxqL+TA
         LJqj7IjfOlao0uzwqpReIkn3JkbL3wVg2E8WlIo5ORTT4+Kj1A7Z2VlaRLNbJuCclA1c
         28Stam+bKadwAd1MsbUkBtNhvGDYrCjSwqxIKBvWEccR0oiq7E1NZmjK92qQ6jDbJCIi
         pDIk9WLT94427WF6o5Sk3FVKs8osAFhN/Y1D670IHCwBCTng73pveFm3jCfEHBYCM8NN
         m5i17QEBPPz8vXnCP7CQCtQohUBhiM30K1yUHHUHs8knwUJWcUW4mCNT1rk1CWDXRICL
         i5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj5dzOFleMycNebxl+CuRlS0b+pXItF59f6CXRNxi2fCdJDyuCv4oC3yj1KtkClt/8RLmrAFjMNw2saek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAn8d9fBm9MSlSGz8xnTrgBk8KxocKdUBITVpi/b5EYEXm5Hu
	NA9TdWLwYdShB0Qano36TiXKQDVaj7uXccBMClCcEsMDysxY8F7Dz+zi
X-Gm-Gg: ASbGncuhiR9HRDyks8Vu+nZhzLRbFxX/g6ozQvtFqPJpqiTMJjGsvq6SL2dNZGDGO07
	55VFtcNqN6FSJXc3V6GvC+oSSCg+ORvuh4kSoWWnonkGfs3an6UzBLP3798Yr8J0ZIKeO6H2Y+0
	z81diIQtfUx2zvQxqrgI4m5bnIOQJYj+F1HqsNUEgEHVK1vzLavvjYK+BR0sdGxAuYQLZdro6k5
	Z84NaT5ehTmktbj5Dq61KJYNZp/X0u8ch0ckyB3Wkf3GST7HwbKQWTDLLCTehygvUcYKToEi5qh
	ihCHsfVeWbdV6ekM/bvUfuSyi3cTK+YIViUZclqMwyVCqhQPnsk/LZnYQGKf6OHsQP+gSMgRlbz
	pZlMcdMFYrElSm7n0YJEtQq/DOLd4OXCslavlgtzxMR+If+95+KMjAvaZaRkYvWy71s0qpnz1pL
	jMDR648EMaqhAAr9Ppu4ZUMYwd5Au8tMbYagHMC2y0HgVhW4yABUTzcILNCIV6iBymW1Wcq+Aeq
	kdFiSNS1Sa5pjnP/39y
X-Google-Smtp-Source: AGHT+IFs1j5KeQPUYHknhxmr73Cz8lIn7tiQ+fRQndA5W23hoDMgcJ9Yk8+rVDxwb74P5c6XfgnCZQ==
X-Received: by 2002:a17:903:b90:b0:269:9a7a:9a43 with SMTP id d9443c01a7336-290c9c89fdfmr20658745ad.10.1760675024212;
        Thu, 16 Oct 2025 21:23:44 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:43 -0700 (PDT)
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
Subject: [PATCH v4 2/7] net/handshake: Define handshake_sk_destruct_req
Date: Fri, 17 Oct 2025 14:23:07 +1000
Message-ID: <20251017042312.1271322-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017042312.1271322-1-alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
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
2.51.0


