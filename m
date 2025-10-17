Return-Path: <linux-kernel+bounces-857239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C81BE64AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA5D4ED040
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D230F809;
	Fri, 17 Oct 2025 04:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA3KMUJZ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1430F55E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760675032; cv=none; b=ghhQtRwfhTTa4WhqkC16o1zczE+Lx7lDoINeUEQbA2g7ijFSq6NbjhqDKuZdwv/I4PBKarVpv2WRs5u+lJEskz8STe5ZTSEz2LLh2HH92GnzUNcvUk8MJ8eSsrBNs6r65fkZc1T7adSgofzqs9YmWvJ+QIFk4Lre5nBh8aCt90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760675032; c=relaxed/simple;
	bh=qJIYSnU+HoRbvlx3ywhGBF4rw4sM63dPw5pKUX1ZIk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXx1yqbXzB7J9Y41VW9gfckLOqsN9xgcXcwaZKoylrNsWvmD9PAcJeugShpkg/Q+t6SNsgbi9GGyK/4zfjt2ND7NZRhoTYQnLsoCAWx42fLugiY1YKDBPpvmf9tE/prs5Ssgmhol8P5QWqg0JgQkRPWS8E50/+lZL5vVUYAUYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA3KMUJZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330b4739538so1352143a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760675030; x=1761279830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=;
        b=TA3KMUJZ3wdXrdHBGXOHDBRRCFsBGRv825EEWg5FMuQd7150NIItSQ0LksJfiXg9Jo
         z6eIrJH5vbhC3GhhETfjYPPVLb4kEfQS8GgDmWRGg534bRmpCsnZqN4g/Ux/PMul3vx0
         FGYHP1nfR6iMgK+IclnXv36uI6ruWqpaFHHXD2ndkI2ehG5l00snqaKwNrkRHnPhsYpl
         xgJdS8h+F/M5B/CXFLDZwAc+bfVHan1bWWltCsaSlC5KCgXY9XAoQ3qh7FIgRvwfiEc7
         rY/8z8JRA2oPBVOv57dPYHztfpn8MNnkfBU/KL4ZLnu1u9NQ9siG/q59po+ThuoSmTEC
         sG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760675030; x=1761279830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAkZgFdLzvs8Exsdja0IC6onWedwrzXxt2HCf6MfZEs=;
        b=I428hTyo6xErXZk8c8A4HA4ipUNHM8mtetYa9iDVB/kGqV0wXySuzYOfVLyLsn0D+o
         YU81chbBfBY5aB6TaqmW5uqc51IeVvoJAUnHoSiW1D66yz7j5hIXiQO/IezVtjBj9+Vr
         4qm5Gha4UPhwB8bolwDZuWfXdY3kkDSG4fleBedoTrATTAucgktMeOTYD5RefTHGFdoM
         kpivDUfn4Drcecy4n7Zl/Rlc/59P4uQsSMyXbKICNyH4WJ4rlEhaA9Ubx7L3B1KH1v1x
         HI109yu6sc0yzRFp8SjSIyaWXVlVlyfBrhWh+OXZOxB/M1eMzHbcCqtaMvhFwj84xE13
         HBCA==
X-Forwarded-Encrypted: i=1; AJvYcCUF1rmdPvPibBQP8+D1erY261s4m9wDp5TUAN15LoIQUUWcRm4BUCRjfVtEM69uK2g06TZdPq6Lx+hofdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjdu2eqyHSAZ2kbaoZ7sW62tdcCUi70HJwdOMSn/+SiwN/V78Q
	D34OnjP5WwGYXlhohiOSsfwuik21y+rd2cdMMs3IBXVzJDamzVqxKcre
X-Gm-Gg: ASbGncu4qRGxOV4gBCYODmtzoATuC4nE5zNdFxFZqAnQjZoaduIyRYfthwGjIibjggr
	8Cd374siqYglyNV6u9D6Y+MQCbSlB2flE+zN/WrA0xWVIYX/Wvr1u6E10/TE0GleUENNchReAsQ
	vZ5AeLK+dHKG/DyhTdmhEIln4FXrxtdUEJfNXN7LIzuE3be8g+80cQI8P/f43LacedUNi2Pz7Bq
	8dkDhoDSgmOIaIOW03J8zDLhoO8+04vI3DkAy6pehxlptV4iilIQKJuuu+P1/Vr/s6zeJC6NI/P
	15HZzQMzIrA9DthbrU1fZFWDLngcGXv7eBQdVqHhsqPA4VENRJWLgAT5MgU7mfVOVlZE7eYGq7z
	eGZxlCOzweCpp9sNcDZbiXwGkSFT+tQVzegwQ0O050Ju10xcYVR6EswEBYB/ldtABy6D98eK9PV
	zkNeIdgqIrkfNON9kzyxhscgS8aoR2zPDVuTqIcdJ3Z7NST39WEydyCu4IAOqvMT57CuEgiE7o2
	STOwR8mrvw0NCV5tWC2
X-Google-Smtp-Source: AGHT+IFfbNX2mTod+6zKsy5GzuQyZpJ35ah75bJLjAVf3giPURvKPzSrUXNdaNKl89D52wOXFUj7ww==
X-Received: by 2002:a17:90b:2ccc:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-33bcf8fa1fcmr2615932a91.19.1760675030324;
        Thu, 16 Oct 2025 21:23:50 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm245557a91.12.2025.10.16.21.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:23:49 -0700 (PDT)
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
Subject: [PATCH v4 3/7] net/handshake: Ensure the request is destructed on completion
Date: Fri, 17 Oct 2025 14:23:08 +1000
Message-ID: <20251017042312.1271322-4-alistair.francis@wdc.com>
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

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v4:
 - Improve description in commit message
v3:
 - New patch

 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 0d1c91c80478..194725a8aaca 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
 		/* Handshake request is no longer pending */
 		sock_put(sk);
 	}
+
+	handshake_sk_destruct_req(sk);
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
 
-- 
2.51.0


