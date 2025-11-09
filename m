Return-Path: <linux-kernel+bounces-891895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D2C43C6D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 12:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A78E3B35E3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B02DEA6E;
	Sun,  9 Nov 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJFs75lf"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A272DCBFA
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686382; cv=none; b=Jt9hvYVTc7Yyu9FQ0FCfdOUS/AORW4TP27KU54iVpqDFYqf0P9xLAeCQjP765ByheLsM1/JQco3XVBUorL7OjtIaKTp1xPi301MMpx1KZCEVkHMKl1qJIJOXUTUQh0WyprSntqfpzmJqT5p2/S+axXErQOT7qYgM2JQvoptp11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686382; c=relaxed/simple;
	bh=Sl57n5h3qnQFQNcmwKkS4S8dI3DCYu3TXVSej6Ds+H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fWvrxj5xpcKhsQyafgMccxlmTWpB0rd5uYAKYPe0QsFGH5leimcOMbfs480m33aVgNjY8p4r9Bijcqjk+V+I9X5bUwLHhIYZhXlPiPJDmYWG5yicrWh/z7ojr+d+3s+JCD9FvaNpC2up24JUVz+XG24ZQ/avlPu/wRQgwx4357g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJFs75lf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b387483bbso183159f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686379; x=1763291179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85FBK1N7968Zf3zmy7BJUL2wfVMtCnOsN9wdrJDgfgc=;
        b=hJFs75lfTSw6dZ9ude0fkIzdZfEXfXOneUe+NdXfnS/ZG1l21Ppofl+AXJUrdPKvwo
         nEr3PTun0Kkmvrh//hhyJBanf2bPN8xIVyrWQVTitZk1Nv3bTMN/MyUuTcLlt3vK63yU
         RajnY7mQJv7TYrE4tIHcqo/wsl/58Nhuba+RQQDYC5LuVd1wO1TOS7o00VZBKz64eyoG
         /vsY79s9uO9y5FZK0+F6FPRjZI7zcoZWR39/BTgVAjUVR6XqgFqreSkmdMIM9Oa3lRd0
         Da1vT1dZNJFtw1v55W5X7YQc1X3vpR+yLVHwvMuISCQPqqgLGlsF0KrLvMVFyxQoLObF
         l1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686379; x=1763291179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85FBK1N7968Zf3zmy7BJUL2wfVMtCnOsN9wdrJDgfgc=;
        b=SdY+hkCTnmypuVhEqAkVL8y/p956PO6LuKds2zi6DqUKtDnG3Lyf4X8PNYvzjAXrcs
         YDODQbdo90ICFu/cSvvAjZHAH39IghAJdN7AF5V779aUFEw1Z0mU6+I+Ef7oc1mdqTqN
         Qrn1hu95s8Fhqy4CEwQl+XaMglGlRcnffYC8lLu+Pn2qDQg4SRueV30WKqwroa4aZ7dJ
         G1S34praNZzIY+FAVv3NqxVBq0XvcywzEEkrHKy838yW2iM6uifidnCOb9f8jlQG8cda
         w7axTB+jy5LVbEes8wyjeOcmkVQk4Z0GhjQ+Uc/T147ZqT9YxkLbj5tzDKnWT1gCDomD
         AcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE/M/zhQwpRzs6ltSko6Kz/aXfnK0OTxlPl4sRpSiAocfw/GWEQcfvteLYfEfOx+PT7gXWl/yofsfg/xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyylptFWEEd4cyJSdJ+1C/q2KoVG9vCZykl8GmWlY3xcw5UY162
	0m3ZFmeoUhxfYYqB7AQDLZsMwOwFUpp+6KGmL9Nh63fwYcTOovzLcpyv
X-Gm-Gg: ASbGnctazPzKZX1upJCUhBkpOPw2+NtH6yQm7yZidsdV9ikXK3MhpKqLd3Ms8pV5xNc
	i4csfsfqL2QNde7H4iES7v0CnknlTH7eQfbmV2dqTJiS4vaa1Zwol3Ek1t5r3MG7kejyJA1dIRe
	WAMZ6c+/QveVZnWiYDIEOeThBxkqauGx1o5bwrJrgkPQ54s8hw4TKAU7WOMt2JV6jt8aSlAVeKK
	rtexPPKy7e4u05O1kGhJZvAQU0f31jKEqcrPFHfWisEZxWbwSUFax9RGjASPSitfORWp6ZfGLbd
	Cd1VR+hflHw4VEJjnkZ6gLqjdTvECGZtlCX4KIf3Se9PFCSckz1NNMxpjvwbjYpN7JeO5FSgXp9
	izhdgIM4iayMmoLwD8WdVzOHg46C/jozTIDxX8hyx4thKYYO9JKCjFk4QLgYuZgbccNHLyP+dzg
	yzUI4x
X-Google-Smtp-Source: AGHT+IHFIeiuJChm/jLLid7Ik0+NY4IPeqhmAps90p1OjDHbjatYqMo8FhZ3+4mJG2x/qi9W+hfY8A==
X-Received: by 2002:a05:6000:2912:b0:42b:3ace:63cc with SMTP id ffacd0b85a97d-42b3ace6596mr20172f8f.35.1762686379085;
        Sun, 09 Nov 2025 03:06:19 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:18 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:53 +0000
Subject: [PATCH net-next v3 3/6] netconsole: add STATE_DEACTIVATED to track
 targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-3-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=2028;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=C8sdELlfliWx0wFIHhmVjWXm2jGpSIoVSQHcSClL97Y=;
 b=VosP6vA0UGMteFuPJJrdAB8s4fo0qd1/JQ+Q+l3P3elVqVgg7+IR5SyFib/tuF7ioDch2jzq2
 PLd4XS9fShgDELOMFlnJkQ5b97MLBXZXZgrG/Qc6y8rZBZr0oy34OK2
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.
Mark the device that is down due to  NETDEV_UNREGISTER as
STATE_DEACTIVATED, this, should be the same as STATE_DISABLED from
a code perspective.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2d15f7ab7235..5a374e6d178d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -120,6 +120,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -575,6 +576,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1461,7 +1470,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->state = STATE_DISABLED;
+				nt->state = STATE_DEACTIVATED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}

-- 
2.51.2


