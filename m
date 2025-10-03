Return-Path: <linux-kernel+bounces-840989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90923BB5E81
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C619C6236
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082F1F91F6;
	Fri,  3 Oct 2025 04:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkI1BWbA"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F701F4CA9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465941; cv=none; b=tcwZww+LPa8p8iSEGuLilo12rdV4ZitIzHMdl5tqkBgjudXKvqsrA7Uyfc+alYsLfCrYOofPzcscB9WHTig1Zyd867obEab2r2Tb6P8rGbuMgbe0V0okiwACa/403T1fxXoLYYqJHmkAqehLm+bLRWtET2fTVeetjFVNt7WccF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465941; c=relaxed/simple;
	bh=Z6w0x3oPOM6C3EiKqL/1mOmpceuMWimWzPhFuNGO/7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiZT6WrPiONJxcmtR9Txtn6Te2cR/P1XHe+x4CJ9NMW2YveNc97DTVU1MnXD8+v5qLLGsJWiNrTRYnqOiSsbiJfD35Kf2r41dYkhop6WzpFFJDOcBuiig82LwsWFh8LaLTQFcEgmCrR8o/qmju5tLvX2S94YgDNbIpcjvcEsGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkI1BWbA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so2159218a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465938; x=1760070738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=;
        b=ZkI1BWbAYYeCs965+UolecO0r7VtgGHULzfHhuUUNERxLeJJLX1pHS11sWPeUkfU24
         ozpWNjAOTltHmvJQTLHFw0FFUCek/aA8U+RqPdziox7PN6MC7LMcX8ZCuv61JfvQuSlj
         uXGHw5y2pSt+09zP1WguikSu83BQERTFgjCdk+v9h0UiQ+/ldx76eoDBrAdgu6E95VVo
         iydUyuRwzcs4pJ3rQ38/SJiJpFWYZsZ7V8tnfDZ/YpBlgMlYs73nbTcHliaorwXyRKBR
         2W3I0ZxfvuE+1jJtL0C9W4YhVucgCBmLn7LrDdMJW5c/Tbrv08sgOo8Wygg+EjDUIqSi
         xx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465938; x=1760070738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9morpPQKu8lXMrpuy/uDVQLBubkYtfu9D8D3JxjNjjM=;
        b=paTzdGjLsdJ8xT86ByxYfI6XOa7gooDayVpbH9o8J+3EeY75RGLjOlsLYy+KJYLLsq
         oh1abYsuHkoa8VJ0IO79HOF1mctfroL9OkqkydaIew6cylufuk23EoAA7NEoPuE14DV+
         HaVFjoIS/LlQWvKlNZ9g5/zR0C/CZEXm25ENCFoj/DWCtROSRjztlpliDN2OUpLM07lb
         8OqWYNZ9fU+tInqMNAp/K/ebLsvgR7wVslHEIMzt0xgXiLZJfzpb4VHYvWgHbH+OT8aA
         8wtWNmvMQTYxvvWj/g1kJ1J6L9QzWAzDmks/2mRdLUYGT4i9qLSn3zGti5uVygFXB/Ra
         YIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCoGpbEQh99SrO3v7KwQwc9y6dC/1tn3o4bJeufKfDjVbqkfD34PPycHque/zy7dTsb26Np53qNLHZm28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAG6JGmVmSufJhx+bAz6pm8gLnWu/lY7/HZQJ+7GdFGhFiV+DQ
	ZICcmb3rhr5qm+xj1qBBeGw1M8Q8PwmoNzl0qduv1cXlfKJNl6pJvx5H
X-Gm-Gg: ASbGncvme2qtXvFV0NMVYf28r3srRPR8RoYWvKGwV+FOOmkY3S5DDWx8xWHSd3Ymjdr
	G4v9RC0v4tTVUFGggL8h/vVCOZO8dPJ+Mj95UZNAoFG08W44EL9jUtQD9xVZrgejdTmNfLPa9uo
	ReGMdjH1szGlh+BLkTL0z31rboSEkLXqy3KSkizmXJevFWFa/8w/aKHBRowPIO9Z3Khp7TIwe1M
	81f/lg3zY7RorLyi+tXPEAJU3Gcai/dCX0dwlTnKrKcjt6mucebkDl+E7iMZg3zv3/Ht2aM1yVn
	cX8v+msfnkvLKGbX784RlJ1swQ0yZvmbIYQl/3wznT/ezWwMex4cFEVwMfetG64vu1LsiYOn3qO
	rtWE5I81qWZ+0hxQ/WbtwpKxMDnI93lW7vZJZDSYuDqe5vRDSbDXBH+7TcB40waev6L5Bs4RjkE
	mKSsmNlHh1Gwdj9Z1Az87bAUDUGXq/q53gZBR+jhC/lp57yrcMkkpL
X-Google-Smtp-Source: AGHT+IHs89hKTsl9/f/m+plS3Ev8/2NixvjRvxCPx92Pgo3FWsBpoEKCKAbX01MgtOEvv1xzIjE2Cw==
X-Received: by 2002:a17:90b:4b8b:b0:335:28ee:eebe with SMTP id 98e67ed59e1d1-339c279e977mr2022144a91.30.1759465938258;
        Thu, 02 Oct 2025 21:32:18 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:17 -0700 (PDT)
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
Subject: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
Date: Fri,  3 Oct 2025 14:31:33 +1000
Message-ID: <20251003043140.1341958-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003043140.1341958-1-alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
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
---
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


