Return-Path: <linux-kernel+bounces-891894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C2C43C52
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEE904E4F1A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C872DCBE2;
	Sun,  9 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSqDLK7q"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77042BEC4E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686379; cv=none; b=jzIIQ0Qt7TQgePOjgzD/rAqJ/rkyBZ3VKbDwe2eO+tZoJzycpmr07ICUjI4pExt8w0cOMVWaJWNKI9qAn6L9QycQ/8KwwcfO31cB2u3WzZ//RnpOoWr/I87hAoXJWxn4odpIevBUPZPZonfd4lmc+LO7Gwk4+RhOlqN3SG16PO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686379; c=relaxed/simple;
	bh=0a6Z9vm59vHUX3M3EDlQdpNuJbepNNHLaFpEBjgVj1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tAPCGoFFMcsiR9zd56oTK6/B0FeG0GOezEq/vf9kBDidUo7j6eoY4fcTT27Repmw/NsASLQm4SS2KmjYVIfGDgpLIB93VT0rZTlx+JYNQdvupF9CUC9aLjfdXd7oYm64a+XA6W3N800JQ9Qd984PvOJcr9swwL1PY77DRdHcOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSqDLK7q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b312a086eso404992f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686376; x=1763291176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=PSqDLK7q+7+x9cpznSyDTJYm/t3Yj7KXUS4bZcNOwy1Z9zFvLA6GgVQynuuveJrA8I
         8viCBBc9foVP7X4unSNMkfnnvKdwq8EfGv2P3HANFP+UffL5knxtRgkoZdbFykK3KK9b
         zFIIUjkdIgwCdgr7n5PXqs7TZn6ZxS0X5SOhQZ8eB5YfUkmj7Sv+jK27/1kH9ltqPRfM
         d88jd1laeyzm5CeXpfSU1sX+fUbg14UpE8zl1hRABqbP0llFUdhakHIOPxwq6QbLcSOQ
         dElBK4fdGwJAix8+ohmIurRoOSaF37ZAFS5reVyrfy6Zr46t5oQ8peozu/0fTeCeAKs/
         Y38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686376; x=1763291176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMuZ/D7eDR+K5SfJd8pIttc4xM0fYqKI56Vw1YxCazE=;
        b=m8hETppBCvfGJDuSyL4XpAn3S1P6wwPvdA7VUM4+StrepXBoylrQH4M73IF6COdOF/
         +eZLZ0sx9Bi7vRmeoead8cQFYtrOOIDu0Lj7pSKEOhUhLXf9QKUSO7DT/A3mLYlY6klN
         ryfNCZJ+rmrHHve5N9LOPHOi8xGvjvpSFs7dJTVX0BdGCF0Rp/qWDMbRiWG1MB3WOhn4
         eeV9Ahm5tq+xmMpaoxGTh/w1z5krq7eYFwl3ipCcDhN/k98uqYS1AZ29E4sJF3tqLrT9
         vBu9RFjkqOs4fmnlhNYSzw8Tt0VzS9dnQAB47JhwB7I6r4CyTN5Mi6OIEuxkXAY7gjUh
         p0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRc+1DEngYEI+hIb9YWMCWtDCITv9xtTtMPReKgd4hMg/vMbemfNLr5Nxx1Padbm7HrZ7I5DB5zZAd+A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/dyI6zoIT0OOGfM81As85DfnFhJI+ztDQzKT/BY/bQlhNPd/
	ivjW1jtnpuj91+11QFVYD1AsFofC4z6SqJbbgsT0sGt6oL6YlT2m6Q98
X-Gm-Gg: ASbGnctwlCwGt4Evb+VMJOeDCGRkjfykDv2okQiBSKluYuD3etRwFbLsrgTCvDcC2r2
	1u67Rt/VzSI9keFkq6V/Rq1VEIHxZ9qKTL31Pe43bU+jOyMHbJ/xjcf7wzCl15nDFfWi6EXFU4R
	dIQgeqP/9FCR9nmICR58t5M5qGtOdhB5fUmfbxhL7m34KtNWudvR1V7CVgTxHXckHnvx2gGWWqG
	rQk9SRhhNeMtKjJN4Hv4wTvoZ2AGRd70rL1R1wSUXWZQ7NuZWiAfRB9kw+P3aSKJ8KokRm3odOq
	gquyYEFEAvcOGWwMyk4j1spQXAhS6Zc1pYXbhw5eAnBaOYQG3o+gkSbvY1id7oW5nIJc+2iFEl+
	bHP2NiyxY86FqnsZ87wlw0CHQaCNB2SFrrnhaXMJTFvHLvOXl2o6FRNb2WrbKhaW/7I0MLgP2I2
	zx10AXf6eOLKJv5C0=
X-Google-Smtp-Source: AGHT+IHFhjADorg/ZR5107ihIL53sgAhlpAdhqkAU05FL/iFU41EOoPQsS82Rvhk2qa66vEBuFTWSA==
X-Received: by 2002:a05:6000:2f86:b0:42b:2a41:f2e with SMTP id ffacd0b85a97d-42b2dbefcfcmr3776049f8f.23.1762686375742;
        Sun, 09 Nov 2025 03:06:15 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:15 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:51 +0000
Subject: [PATCH net-next v3 1/6] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-1-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=748;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Po4s941eMErBwuDFYeqR/VDMArYoBzjcjN8/MMT+h9s=;
 b=Dob/xrKXJfj0d4xZnl+MCY/sthJswm5B+vonAmQ2jJUC40wOI+WQMq9EY9UZP0OdSo/OqAzvi
 sGBHZfFAmgpACXKkgVcqacoh5HiO2KkyE2FaVqEAiOjeUmhl2PYJVn7
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..7a7eba041e23 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -117,6 +117,11 @@ enum sysdata_feature {
 	SYSDATA_MSGID = BIT(3),
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.51.2


