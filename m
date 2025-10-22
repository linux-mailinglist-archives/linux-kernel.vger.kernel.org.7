Return-Path: <linux-kernel+bounces-865633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C0BFDA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23633B01C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8212D8774;
	Wed, 22 Oct 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onm42/E2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4A2D7DF6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154840; cv=none; b=eqXO0IyAYunuHSfKRx0mRK/Pzf7y8pshX2O6rHsOuJJxSdPlvqGQoj4sbfHVWSDxcuKijj9AABMuMsIszhZncPjy9wuiouRdUsh4LjWRwGbfOLK/f2Bw1ZOwn66hYSw8SkrZuUb3R7MUsDw2Ux+8gyJyNdxzOR4QE9o/3s2jW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154840; c=relaxed/simple;
	bh=oCR56LMNxbJLVPpG2Gxtqc3kBZKa3X3HExddSDRVgK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBbNTRIptXvG6bd0/rr5TcWJ9UyoPDSZeuVG28hpyD1TEy9Nbl1LacMm8PgGReqfIqsQyrtPBU1kfz2msOWm0v/LLg4Egwyx5w9dPV7aM0FJuSAnxsybNlezp2I4y1/fVhCwBhrBIE7bGbPYIhh9M8Zzc45KPbPQtGs3xfje9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Onm42/E2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42844985499so511548f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154837; x=1761759637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgD0EgpQ1bwVIze+M9LiD/EeIFj+v/rXiYxks5RmUv4=;
        b=Onm42/E2WAA2X5zZc8PppDnA95yZwMbtpY1ZbVP0wQQLjLj7hr0CpCQIYvnfsWRheY
         lxSxR9FrjDdebES6CU7ItS/pi2AowBTxs46onppnlSnY9n9M05T1p7hj3PMtAUm8cIYJ
         zIrXOLnvYewJGtpZP9cViO0P65/DrOsozKARRzZuE7eI/cTpBbU2wKghG3vdy24FBoZF
         t2e/fPWj5vLUaJk9qpRRkUj8m1vhmFtnesFuhtu2LhOk5N1Tk4eH2avCu6+od5bEu2/w
         MNZHqDxXgv6iia996rZ7oPvdDRxI98HGYvw12oCeAMVcUe77P+CdwOPmRkt5mNU5in/A
         OJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154837; x=1761759637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgD0EgpQ1bwVIze+M9LiD/EeIFj+v/rXiYxks5RmUv4=;
        b=pBwLxzT+5EBdz9714yuvh3Gs+6NqXodhhOJ2qs8LPMfJVtPZnUQwYietzxYl4K+Fqm
         8u9N8qv6rZmeUo3Z+G7e7L3pGggGdMDo8VhhjclcT29gswqdmuk1zdLlNqL2tGxiU4TV
         cdVIN4cYNAdg9ZT+jQvfJ2x9lJysWPJgE2EnRTfzJRlUSQAMyZ1aPKmSPJA+fhe/8wD7
         8DKvs5sPuKwAa2/XlVNZUkAXLimuuZgnTZjpUqlOZ+bxorGlBGH5HoJyEINlEVmiSkHR
         4SR43uxxrN1c/F533pw7JjU+ImvOLAsCINdznJWr2L14CsQVDy8xFEmRo5at/DS6VuAS
         KkHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxCzFyF+HTigQZZqkaRjS6kjfDgTEQltDa3PByr0DWuWPJMdFPESBqf9AsES30uBpv/KpFZJajFDtIEgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2kBp9GOXI+0dnQExD4Aa5flVtvVyF2H3QtBYJJo81/Pky0A7
	F8D2H6aRS/fVQT92Dy9XYsry+iV4HTKEZmRxM7rSRVj8uiVFa/z51HYt
X-Gm-Gg: ASbGncuP83/vAkGkvgMVU8WpkEmQxOg9Z/ULJ/8XImADfev5eN9tH2gV1pURjNIgAKS
	UEp/ICkj5sza8HDV7SF+/hpBR6tAgszWoheXUrkpqCHNV13nwD70PFOZMVPP6RUgK5OXhvxVxtL
	4IGqs+yj8RgQWnT+rSYyd1LRi7ykMh9IlUIpXvSzj8T7xoVT/dkTj4/zCiRkS5ntLmcG2yU+ECJ
	Qk9tcDZQUyqtDayCpksZkBshycA2Wpl7PTW51jAAOHH2C4NZ2DcdWI65cUppLzdemX0h9DAga4z
	1ue1hmEv4BILmTY/z2selvInXTfymChVosjI0rclTXuhpuwdIOanqpsu+bvxd/IP7O/2FrdyuRT
	Q85bmEvHwMNWM1odJz3H9gdwJX1Koulsx1XzkjakHeXrGhQTIKDpX3uS/Ebkt+yBCAYCWdrfQsq
	bwUtlf
X-Google-Smtp-Source: AGHT+IGo0Rt1P+fnF95QCjRY9TTnpGTG3b3OqZamIFsM0FWgRiah419XNsZpM4zjKsCv8BLdL6naAw==
X-Received: by 2002:a05:600c:1e8b:b0:46e:36f9:c57e with SMTP id 5b1f17b1804b1-47494305991mr35917595e9.5.1761154836724;
        Wed, 22 Oct 2025 10:40:36 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:47::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm43661225e9.0.2025.10.22.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:40:36 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 22 Oct 2025 10:39:57 -0700
Subject: [PATCH net v2 1/2] netconsole: Fix race condition in between
 reader and writer of userdata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-netconsole-fix-race-v2-1-337241338079@meta.com>
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
In-Reply-To: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The update_userdata() function constructs the complete userdata string
in nt->extradata_complete and updates nt->userdata_length. This data
is then read by write_msg() and write_ext_msg() when sending netconsole
messages. However, update_userdata() was not holding target_list_lock
during this process, allowing concurrent message transmission to read
partially updated userdata.

This race condition could result in netconsole messages containing
incomplete or inconsistent userdata - for example, reading the old
userdata_length with new extradata_complete content, or vice versa,
leading to truncated or corrupted output.

Fix this by acquiring target_list_lock with spin_lock_irqsave() before
updating extradata_complete and userdata_length, and releasing it after
both fields are fully updated. This ensures that readers see a
consistent view of the userdata, preventing corruption during concurrent
access.

The fix aligns with the existing locking pattern used throughout the
netconsole code, where target_list_lock protects access to target
fields including buf[] and msgcounter that are accessed during message
transmission.

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..1f9cf6b12dfc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,6 +888,9 @@ static void update_userdata(struct netconsole_target *nt)
 {
 	int complete_idx = 0, child_count = 0;
 	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&target_list_lock, flags);
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
@@ -918,6 +921,8 @@ static void update_userdata(struct netconsole_target *nt)
 	}
 	nt->userdata_length = strnlen(nt->extradata_complete,
 				      sizeof(nt->extradata_complete));
+
+	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,

-- 
2.47.3


