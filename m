Return-Path: <linux-kernel+bounces-840990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D73BB5E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A1E427A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478D6207A0C;
	Fri,  3 Oct 2025 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzEl4koh"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B482010EE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465946; cv=none; b=tfY8L6ytv7LW9eBYQvI7yfxzMOSVevRsX/kjfHM16fnLF95V1W4+NBdvAGgwR2cxOO5MvViVjMEiIHC9gWWKaRGVDA1XDAQLS8CoQt8Bmo4TVFw6+icul4d2H3yrOde66WiwlH1JL+2yeMM6KlakQi5oItCeGYeUynMxuHtUli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465946; c=relaxed/simple;
	bh=Bl1TRunIta5QQDe3lRPwonbH+J8i9iNM2VxNxK/XmSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf7KfD1yGc8ND4Cy+4MVHcftxZlHVuNC0jovSfDUqVdui62QtM4PYS/9JKyL8ymrs6ao2WC5VrW4C3AdkNePhPHmxKqh7vR0q8ibRO1hENjlmurWPU7HMtXtuTh8OswS0rONimlhL2CxjZkuCl7nEWFIIL0bc4dKSd4mWQrBCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzEl4koh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so1610062a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759465944; x=1760070744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=CzEl4kohMhiLGU72A5sArwP+L85QrX67hhJCG3zfczH5RdLXwJ0vzTKv8GqcLt/vu+
         1M3Aw781chc/cYYd/twjVhnvfx377c0fQo7ym4pFuL55xWQ+GxPGILVY1p1Q7YhqcI2n
         N53FYvgdCFEN2LLyxsaJJ7W7WQ55rWANY/ziMWRPFB7o7DiMbMaWx+kFVIWppCSpgMn9
         i11gloJmrGfnF656rGXnu19dPcCrSA8QFG9cc8iouylfpZZFrZlTSLx+ULenE+4rIrXR
         60LTItEVahVkLSp49+MPKEI7p995x4xnc4CGPdkhRULDj7et7w6cJc0yE1eqOa1FnIQM
         dqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759465944; x=1760070744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOV0qGYLCq+9ZQ//0z9A3z+3aG29/4P327MFfqw2xrc=;
        b=o8tKY2GRIrsOVsPX5QCU1WUKnaIydglFbrwe10u2I1FypHM1znw0wdjwFeYYAkJavG
         c9eMmKwiugSYVvMwQzRXaLkGZZt7LXwPs4u34nuKWvlNksaafWNJDt2k1wtxnogxSqSj
         u29taHH4OFw67qG92RPVbnlGFmz7qg/lbu2/LXlyulwRX3qMQ87TyAH5Ai1SYZCX1J94
         b2BxNA4qqtFeQ3c9Ntit6yOI//9zH0raF/YaHAikaRffVmwrVMySyhwiMmIDkdD/2xaA
         0yrjK3tfqAl4FJxIJYKUXsmzFbKs6W0JVg9BPhslRbVakRVS6EChixRdyRv8lc7vjgtj
         AyIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiWwn1UYcahVpGK4HUMNwRp5s0g4KKrjHKPkAUSpRAyl7aLw1L8jkIEUIsxJO9jFe3BoyVplW4dmW0w3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgnp8wmejuC2/L5z++mynwR1g0ayKmBUYgE43HT34qQZBTuMT
	Xg1RobShzWUOEuRgF6971SDqaICIMjvaEsadogXG+ebLx9NrgX43IXH2
X-Gm-Gg: ASbGnctdVWaKJ6IzQxzfPWUq3oPEOvUHtevulQHVPbAc0G2eN6/3XCkFi0fqBogSIdw
	V+WLUYG6fHXU1UcCJnR3xyB4ck6PNS1APLB2w1Jhz43bqhfBxyqxU/4aZiaX9hXWnO3uIW45jsP
	2EvSjGEfkZoocx6M+NCV6hxDsGQySMqDKQ930GLUq92L9Xmfb+lC6yFy1O/4QfSiqSpziyrpv17
	gXNs/z+SwJZs7kSsfD5otpV0/lJ9NcfwtEWGJ0Esd3MfE21xV7jJptOvku6/MePpyCLI4w1FLje
	v2KXWdPFOVJNsEEOpOYa4FGP7XMf/GfvSRvvbfVKlTlkOvLvE/UXCW7lxYRA9UejN3MxtUqLvwi
	+P/IjBC6Cj3aCFhjpMhjq6/rpnEZqHxlIwJWHTDnTHIz1VdDK6UL+dGRv5alJKcWxh1Ygw5JIqn
	nZ4yh6Dh0wdeeF65/Znc9gXnJJxSkhZr+ViXhm1HGKi21QTGNExTw/Bpdc6i31pBw=
X-Google-Smtp-Source: AGHT+IGCDoUIKtDX/52HGaffkclK+hmjaIJ+Bue+zX3dUNN6Q+cAazG3rbJtO5YII+rQ/2wJMc8/6A==
X-Received: by 2002:a17:90b:1d92:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-339c264f452mr2016481a91.0.1759465944489;
        Thu, 02 Oct 2025 21:32:24 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm6528233a91.23.2025.10.02.21.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 21:32:23 -0700 (PDT)
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
Subject: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
Date: Fri,  3 Oct 2025 14:31:34 +1000
Message-ID: <20251003043140.1341958-4-alistair.francis@wdc.com>
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

To avoid future handshake_req_hash_add() calls failing with EEXIST when
performing a KeyUpdate let's make sure the old request is destructed
as part of the completion.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
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


