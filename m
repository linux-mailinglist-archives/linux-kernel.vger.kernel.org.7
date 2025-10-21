Return-Path: <linux-kernel+bounces-863678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B124CBF8CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D04ED5042C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A49285CB4;
	Tue, 21 Oct 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMEQRAHp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5C285C96
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079916; cv=none; b=UOlKFOA0pShqzKeafcxmTJTRwnJN2llrAytJQtJG0ti8Dqi71fs112gOOM93pCbBRzjKf9bCR2H/eXA1bToZku/V5stpcJVBshwgA6x6+DYjrCyvgK2s1+z8cXe1aN2IefIUV4YtGHvNnaHhF/6DwlrShVaYMoc3/FnwgugZPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079916; c=relaxed/simple;
	bh=UveeWbonEBzHOsedwEkyFhZXsXP8dHRyWcqRFSsd9is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulGENnYaBaLUNW7KHmg7LteOuCLNRiCj2MEKLln6M5V6kETi56aywIH7k7qiloZrfy/l32MrR4XE6AaZX+USxUwu9DvD1eKKD2tSaS6n9SOCMSVhDtpzbbM+tCRs+kc7uEmpY2xf1Fi7tEGof4cYY8k/vXkaU8w0gI9cf4os07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMEQRAHp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e074dso71849405ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079914; x=1761684714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lftas2ddDSmWmb+YGuwk3FBQVOltsQH5UlJvrmZ5q6U=;
        b=VMEQRAHp5d0MUi9apIanWr8EFTh9XMrXLK7jbqYnZt+v3idOmVv80UtivRn0Ef3YQv
         SUe5dg1cRPtxO/vb2ean9LiL7kmS9ev6TPezIKdJWVqSnS0yK7dEYJa/L6oK8dy5MLfx
         6g1HM9Cx/cg4qvgDkv3J7XVtYQvVEDPWIkVE9oq33liB1gYON1IFTa96Df8cCnjB+HJu
         2WUaxI9b9rrYwluKaSDtzd0zV74pj1sJh9ucqZ7quSUZQuUFyjtM0g5A6/S+K4o+fXjb
         9+k3JsHAttpayl+R4SdxMVYtpuLWGU/8pYo+pqaIUey74jqgQ/AN7SK1fi52woH+FVs3
         5ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079914; x=1761684714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lftas2ddDSmWmb+YGuwk3FBQVOltsQH5UlJvrmZ5q6U=;
        b=RH6N57CkXyjWQ+zlyBJLgjfeFIfSyRzqEW99ro1MTwuwEvx38kNig5RcYr7kJcAoAa
         ITyLra5qNDu6jPrpUELXCXhfXB+wK0TQ1SPtKSTRAjc0vPoEapT9zRoulHaPI4HtOP3n
         Ce9slYLJ5PTyHS3EFwmTVGS80HOxKUPgY1S3vh8hdB1Ngu/rdNwlIS27QYnb+cudx68T
         l8laXFKDbrEl1vJC1/OVAJGIOSE12qAB/kxAX2nUAlFE4dl63WvKjO2yY68m6z9v5wUc
         pidHVVaDMutU1uLNmvcSdtyoM1KYmvChXISMlPksEfgGI6EiAF0Li762YrYaV1tpgwcN
         ZPqw==
X-Forwarded-Encrypted: i=1; AJvYcCWPX3NBeIFGY35AMm4ZrzZU/CremtzNx+2yCeW3HBTR9fW/ixJ34hC9smVvF54XJA1rm5pfu3nhquvk3mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/qfaVDwvBEhYWhZpHYxDncl6TeXmP1OxKOMDJ64G2WimmgXM
	/mXax6JESCPXs6zUNYypqRRKQRVEFnQ6wg0r3zO9Y9DuLb5kQwbQ+4zt
X-Gm-Gg: ASbGncttj/GDXlGS7jcr0n5fGj3v3XkK9LnvDWuPjPvIOjOLfNVq9S/nqpLpzj8c/PD
	RFOkue8/KcidlBzWWTf8nbHMLkfkeo4M5bUixQcRlcIQNfhzJVp+oj5cfSPx2m40VMx9eevQgqA
	WyFJ2Hy6m9GCf4y6f0BxOG4FwWWOuoD7p1LSRB9k7KxBRNdI7VQfv2FX1UCxeBVFP9yVhzVoHrr
	TQ0atTVJY320JkSyjipJxV9uiOSNAU5Hs++155yABBQWaR2CRcfcblO6Tx0TFv4GWsYmeLeGJ1g
	8ocoIyMlho/RAz5jc+OYDGjOuJoVCfHdNvDRmvL2wmDbkN/flYrRkF0xT+kNVXPcN9LCE7Mqspy
	eEdsdgfqvH3WqX5l2Pu2UvBuKQ6w2IYSu7TEfmkbYV1X8i4ZEAOdgnPl2JNOrrVzPaLqjhCIAR4
	MqFTzCNLjD6eGO
X-Google-Smtp-Source: AGHT+IEfhRm0UFYKNj6H7qrDGgiGnDijmQN5E6l3vSDSR8fMiI77xk4Co+Iyyb2wZMvFpNiuKZWgVg==
X-Received: by 2002:a17:902:f610:b0:261:1521:17a8 with SMTP id d9443c01a7336-290c9ca6b06mr233478265ad.16.1761079914034;
        Tue, 21 Oct 2025 13:51:54 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc795sm118283815ad.30.2025.10.21.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:53 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 3/4] wifi: mac80211_hwsim: add sufficient parantheses to complex macro
Date: Tue, 21 Oct 2025 20:50:25 +0000
Message-ID: <719536080163f4b8ecb9af6ebbb7af8304fe3401.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 51c0582e3b77..e62d4a98671f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5357,10 +5357,10 @@ static const u8 iftypes_ext_capa_ap[] = {
 };
 
 #define MAC80211_HWSIM_MLD_CAPA_OPS				\
-	FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
-			 IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME) | \
-	FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS, \
-			 IEEE80211_MLD_MAX_NUM_LINKS - 1)
+	((FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP, \
+			 IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_SAME)) | \
+	(FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS, \
+			 IEEE80211_MLD_MAX_NUM_LINKS - 1)))
 
 static const struct wiphy_iftype_ext_capab mac80211_hwsim_iftypes_ext_capa[] = {
 	{
-- 
2.43.0


