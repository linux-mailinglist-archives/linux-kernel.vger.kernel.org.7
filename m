Return-Path: <linux-kernel+bounces-896490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F7C5084E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5923B2EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350802DE70D;
	Wed, 12 Nov 2025 04:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnioBE+9"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D672D7397
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921706; cv=none; b=BH3p2WP+tJTgN94ldF+Fy6tBuUV6jKcWYHn//3uLVgdkTm3CZxBInRuTGAFdAv5WF4OhPQCh5sNebDecpfcVxWIJ9iDaYsEejR4sis/J05nSo+gKioU0qFDLPizZNoysITy2Enb/pm0UJX/utou5UU5BPJIVEZ4mihHmsc+U8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921706; c=relaxed/simple;
	bh=zP/NG7w1+KArs879n8cQJzWDunWwyIPS5O4paM2aWv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBplq8p6Utj/LleCXt58VQEjNYPMdD+1jzosXZE/qvDpj4G1cWgfC1tUvcf1PT/ksWV9slrPrP+qPJqyGNnndB74b2OvN70kKXxMUUHSS7KDBZmuf1xJCTANJasB7PQDIT6k+DebxdANqLpW3FMQgAjUi4GaXlSL50Kui3/9ATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnioBE+9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3437af8444cso375143a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921704; x=1763526504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=MnioBE+9RluMS451pD6BCq/wgG9AjNRfLpn3OOC6f+TMcIvVk0/QKxcdwKXZ5j7RKz
         IXGk9ZbS6MQqb9+Q81yvkIDMcbyhlvmJ02GAISA3RgQEnsK2hwieOmHZ7PrHm69r2btP
         yXEfqYVr75TfX3tmLmgKCecYybtptcijEuAJSv6IqQht7VDsqfO3cRwzoepmlQOLABf+
         +ZhOBP9Vh5VakngdMhP1UU/Cl7dkDRWmY30DOJNsNoaUSBYebRGgVB7iLLQL+hvtsYW0
         sf+PRnXJpRZ5XKtr1Vcdchvbs4fQVAzOBCj13NbgEzR9m3buyp6iuyW2IJqEA2t/2e9Z
         Y5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921704; x=1763526504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkGiIciWDidvQkbZlkaOibwVplEAw58SDT70kiDe31U=;
        b=esLz07GMbM5mGhWevk2mCLdWuxRqNu4ZnqDhCmNdfwHOW0hfA16EE0oAWdTX1c/qmc
         hjUmnpIrrq9yR7X2g7txg3RU/zfvLe6zNeeEZSJoKkKhTDVMdUtreIcEXF7Sr1mRpeOL
         FBwleskBuGaz9tIBGPjLrzzKefEZxVE46/F7+LDUsl44Bn8jLibZCQ4UVaHPFQniHKg3
         asT6/abl3dWvQQ3z7tPsHuXYwWc88QrWzO1hklraCzNXw71EV8nrChutThW/toymQ2SM
         1LdZHDcyPapaLsiTVm5SJSw3j9hodH/JBQTwZZTJOmJ6RIN0dt+Eu+ss8Y7I7pONkHXM
         pr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDY9NGy40bXBegA7cXFvqtP6DPE4XOIr0GaGFGdg6FJNjlXutQE+ii6odFF9i92fnf6CcboxzqRjdyikM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCrxY52+DmBe06mvGzccWXivG+cuA99TRqHhWqdGOZWD5TnXe
	+eGHjhX+m7WqCfZ0CF+KPTyCpBjy3+qPPjBc7tjKfc2wXeOFqW7PJbL4
X-Gm-Gg: ASbGncvzOxVLxIlvY+yUh6KardpayDWua1urkXcJ72Bi32rEQgxteWMhbgjtrpl7tUJ
	0zHARQ9i9p6EfZ1Zg1gShYWFNV8VZg56UUDHFQcUKD8e0pwd00V/uK40JEDuGPwFXQaaQwEmHxl
	EOJcckBzhmXgtkM9EDnoTFKqn+GiQ8is9EQTbz/uli0fC84KaId6PD+mNXh2eDis7k1HNR0oqAq
	yF78jeD5LaNNwNiO9DQTJ4PUMwaRUU7Urqc7JWRDQX2YPzlB0aBz9B6xqnIXlv4oLH/FIithprG
	rsEEMfz2qeCOR4PenbZqB04/rocR+iMqLbHwBvYLTsx2/W2h5Y8KnB2a0IGgBjjKnKxDqs6wN95
	Bx0QY4zFIQT9LrFUkZQieNQ2NrS4lGaGDBbBLTvZZ5l7A7NS01X1NK31lTwbBPeOGyI13fXYgHL
	GLdCX+CLt/JvbnGY0lGeBSwxX37tlleN3kSoKh3sX69YltF7JlfEGPHM6/7F0Of9VxEmHmyxnyU
	vCfYumKXA==
X-Google-Smtp-Source: AGHT+IFz599JMY+HbLZlN+Y4HCQji4lI/mnZmgyLfcZAZDfwLpsK/Yd65k0yw0c8AJv/WsCEFQFd3Q==
X-Received: by 2002:a17:90b:4b89:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-343dde81845mr1915818a91.18.1762921704526;
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:24 -0800 (PST)
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
Subject: [PATCH v5 3/6] net/handshake: Ensure the request is destructed on completion
Date: Wed, 12 Nov 2025 14:27:17 +1000
Message-ID: <20251112042720.3695972-4-alistair.francis@wdc.com>
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
v5:
 - No change
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
2.51.1


