Return-Path: <linux-kernel+bounces-887089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91EC373EC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 914A34F54E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47987335BC6;
	Wed,  5 Nov 2025 18:02:09 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDCE22A4E5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365728; cv=none; b=NLYxiPuCcyxxLCaXNfRxQlVh4PSxDdgT5yrrRqvSuk5dd8fysyTzOpsVK+fe84Lh0ev53KXJ6X916v1PDumbFxkDrvdCRg8EscI2tx3gGW2e1OECg/mO2dKbPA0W/jHp76MpSUg+6bPL6z88ozyi8OgJoGM4YzMtKVUb9DSNC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365728; c=relaxed/simple;
	bh=ZCz78oYBUNpXkKPm0a72zBISeoFnkQXycqYmx2bxyls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QaeRDsoP5xHIxFMRC6vPR+P983ruqj6mQLqZBWaBXppyrJj1DKRcPecVvUK6bvgZ7cxTMnFUIgJrItZW7/0A9Q6smKOlreS+XZK1qcKDYm3QQQw9FT6bkiE37hTlTmnHUwAuy93Fj590mpJy85T4bEyhhWEESqYRd+H8au0vO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so82427a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365724; x=1762970524;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fL+rSJszqIArGclI8UPsPMoZGI0pFGQxPTA6Ca2pfc=;
        b=ZbVQIvizZuJ1IUZ2N/ok/LxjL/3HzqQsx7cauCv2WAVrsHqU0GbPHBYpJ4AB2TTY7V
         X/ho8GbrE2kBMONceqILpIqlq3Q1JmX/5nRhguiEhi/T1di06P3tVQLyaKseiSzPw86E
         DKZvWHtQQwAEqbJZDFYIdm9WVdMlgM8VtJKB3XgobAnLLe/LwkScLH54IxGYDzfd0EZL
         wi1+hVAr9j/dcAHlYihhp2AUiw8d4fPwv7TrFrsVPI2tCr3bVJhqB4fA61JItlToiein
         09croD3jD7pofWI359FWTdNvljks3bveZAXXZh0WkqqM0KOe+TxvmXXjBTKDmoJT8jeq
         v/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO8YT7nC4qzKGpOuMmTCTbkdk4qL/ksCY5y64WzZTjnZfoANrpV/QcmrdMJTSaB3ly/QgD/6Z/ofac478=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGPa4vAwz+RlIsX+GBHEU3B8Id9bjLhI7/DNTBkdAiL44jviT
	9BkPkyLU+sl6YU/lcVEHdUUfQNXLhoGx4gSOaNUgI/7DFg+Zno3NpHkT
X-Gm-Gg: ASbGncveM1bLTI/Ct9J8c74XyASZ695dbOpoBtKVXzJcPUrD8oL3hcLedA+7M1Ya0He
	EOdHU9xF60hEGyoxLr5ePsW1DVrJsP4SpNSOBP6o6kIDisnagpRfvTqiV4VPkVr2ynAlZ4iNpaM
	6m0GTBQpET9snNqHcOll48aoBRcmURE/7jjjmxQ1/MTyWgfbuwEcQYwLuVLvDq+Cvt5cu6s5Xgc
	xmfe+vJIPvnsdegU2JIt46zIm/ACUGiEV68JZPuPSVhxXpGCsI9NrsJcLcY1Ihctc9175Fiaz+1
	b5RGaMnaLYzhTFFazE2hpfbtf1x25LeYzNJRFKePNTQXMh6oCOcL8P4lwLuwtNqJLiqWghYbLY7
	zwHKSTtx3jsBvdYJcQlgw8RRKFSCopxeyN1jnhTYdJRI+6D3BiW0hS7Q1DFpphFEsiBJ6Kd/a6T
	aM
X-Google-Smtp-Source: AGHT+IFPpLyxiJ2jA48b2g0b5iiljfmiE/RQHvJs3mJa9f/KokkIB16zXrB0m8NjkuecZoQyODgbrw==
X-Received: by 2002:a05:6402:535a:10b0:634:ce70:7c5 with SMTP id 4fb4d7f45d1cf-64105a44a35mr3130066a12.17.1762365724263;
        Wed, 05 Nov 2025 10:02:04 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5cb52sm5163323a12.23.2025.11.05.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:02:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 05 Nov 2025 10:01:12 -0800
Subject: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
X-B4-Tracking: v=1; b=H4sIAOeQC2kC/x3MUQqDMAwG4KuE/9mCEQpbryJjzDbr8hJHKlIQ7
 y74HeA70MRVGhIdcNm16WpIxAMh/z5WJWhBIkzjFJnHGKp3V6vtvXOIUh5LfmaWXDAQ/i5f7fc
 2w2QLJn3D6zwvQ4XGMWcAAAA=
X-Change-ID: 20251105-grxrings_v1-5ed8bc9c1ecd
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Michael Chan <mchan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZCz78oYBUNpXkKPm0a72zBISeoFnkQXycqYmx2bxyls=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpC5EZV0lQIj+k/s+/cJjDZ/8ZbiQgdT+6GZQ2a
 NoH3ifxqnqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQuRGQAKCRA1o5Of/Hh3
 bVLxD/9m6nj1IbDolW/OPaVVcpr988VqO/mjmauVBlca7wGDS39rBcMGMS4F4dVvMSs38Iytbg2
 j/p5Plkh4/hbvahEEMrEvL+BsG+p4e/Lb/yj3mUqxSbqR3S69KlVFLupiaIXIo7jiFviztPl1nN
 MHavQWpDaewKFzouWequI27zzbItCAgV6t/1YwrypBkwAvb+4cbtCQbYyDJyYrkHMYDkdXERuTq
 B3RfWGGwleMN9SLW1egSxygRZqhfYI+EzkXRcrs4wcsM2kecd403pH5K5Z5wR5sNXg3jfxyxlsS
 BsOtyfleXgDlJJYunsC444v6oUi2H4mYKXQkUxQsROi1V5lUdrszUjOsZ7HyZPQBgz6sb08Dy8N
 VUAjMAsTUI+r9BWln5eZsbuUuHjn14Z7SbOK7DHbgMUEMIia5XhYOr7jyOIIA/Rm2L1Xw5RIutA
 HU3u+lTUAKExSzhvbcfizgwzm2M0wr5FW9ZSPoAUvoI4TJC7Dhkg73uwPtLPBxEec+qvlVy+2uN
 mMJBwv0WBzO6jyL2ocylNJfr9cn/U9WnU8a07+VbbUFuHbhN58UN92kex+ls6XhQUdU0ykXC3xl
 zvlW6RIfE97N8Uw+kfmtE6zBbDSL4GhveadiFxXKA1TnBJalHh+iuQT2VEpjGYnn9ErpYvzCnW2
 NRshta1ixFR+TEw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

Given that tg3_get_rxnfc() only handles ETHTOOL_GRXRINGS, then this
function becomes useless now, and it is removed.

This also fixes the behavior for devices without MSIX support.
Previously, the function would return -EOPNOTSUPP, but now it correctly
returns 1.

The functionality remains the same: return the current queue count
if the device is running, otherwise return the minimum of online
CPUs and TG3_RSS_MAX_NUM_QS.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
PS: This was compiled-tested only and NOT tested on a real hardware.
---
 drivers/net/ethernet/broadcom/tg3.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d78cafdb20949..fa58c3ffceb06 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12719,29 +12719,17 @@ static int tg3_get_sset_count(struct net_device *dev, int sset)
 	}
 }
 
-static int tg3_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-			 u32 *rules __always_unused)
+static u32 tg3_get_rx_ring_count(struct net_device *dev)
 {
 	struct tg3 *tp = netdev_priv(dev);
 
 	if (!tg3_flag(tp, SUPPORT_MSIX))
-		return -EOPNOTSUPP;
+		return 1;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		if (netif_running(tp->dev))
-			info->data = tp->rxq_cnt;
-		else {
-			info->data = num_online_cpus();
-			if (info->data > TG3_RSS_MAX_NUM_QS)
-				info->data = TG3_RSS_MAX_NUM_QS;
-		}
+	if (netif_running(tp->dev))
+		return tp->rxq_cnt;
 
-		return 0;
-
-	default:
-		return -EOPNOTSUPP;
-	}
+	return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);
 }
 
 static u32 tg3_get_rxfh_indir_size(struct net_device *dev)
@@ -14268,7 +14256,7 @@ static const struct ethtool_ops tg3_ethtool_ops = {
 	.get_coalesce		= tg3_get_coalesce,
 	.set_coalesce		= tg3_set_coalesce,
 	.get_sset_count		= tg3_get_sset_count,
-	.get_rxnfc		= tg3_get_rxnfc,
+	.get_rx_ring_count	= tg3_get_rx_ring_count,
 	.get_rxfh_indir_size    = tg3_get_rxfh_indir_size,
 	.get_rxfh		= tg3_get_rxfh,
 	.set_rxfh		= tg3_set_rxfh,

---
base-commit: 5d505fdf758ebf197e5e99277e7203b4aabaf367
change-id: 20251105-grxrings_v1-5ed8bc9c1ecd

Best regards,
--  
Breno Leitao <leitao@debian.org>


