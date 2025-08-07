Return-Path: <linux-kernel+bounces-759584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889BB1DFB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FB63ADB3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F852620D5;
	Thu,  7 Aug 2025 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="AI/37xwD"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B811F8ACA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608017; cv=none; b=MPyp/AEQJZq8Ag3g4MbVgLN0pdRhtp/SL59Ju8taUjb9rlc0K/5izbb+JY4DRmlvMPaXs5Ftk1WpSsXdnUMzWxxeIBszJndMGkHHBL5Wu3leH69z6jM9aJ0S316ftGexeSo8/oCSMxO0u8j0kd08nmui9nov0UqEMcYaiZwax/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608017; c=relaxed/simple;
	bh=h5Q/7ze6bM3o1VsTwHnPbmRG9FXXEVNIXMucrQZmgYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSEVQlDEqY4SmwrcSMkClJ/jGJ2UcDlvN7pJlqoxjqi3t7jpr3+ZvnVuPQ7sSnzBoZk10PJcwbUMeQZe0fDu0yg1dRFnbvYbNwHcJGuUn9EZdKopkyht8Wrc6tlPMa7XujxHJhANGvJjWWKba4p9sahAnsDE7guAFk93fh0MdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=AI/37xwD; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7430e1fffe1so1077919a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754608015; x=1755212815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdSyWAAmgtvWxwCCBM2UNaIrykEqdMEI7qno43QP/C0=;
        b=AI/37xwDW07tLjktfEu/Mku2/IHEhL7VpP+qqRn/jzG8bH1rqoGZnD4WeCYXZWvLTx
         ZM2IKp6kBWvIX6zNYIIVXukV3mpWzusnV1zCtazQFSDf/cfOFzMTeR+9ErXO/RuLoMKT
         Ex9C0zzhfKK8SLFGndJfBs9LjOvzcnpAbD8HRW/h6M/ZlVX5ypghOu7ZR26Zy2KN/ekZ
         PgHrI3qKsGsyqRUldhvQzfUMILxSbFMt1Ospl6hIeCFuI8ozETQ9SSl3zieZv9BYZVmL
         CpCrvL9/xXglluoYnxvbd465rUrw7Zfhck6myZ3bnm5ZfgcoKv66ckITQ3kdR3ylu/jU
         yRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608015; x=1755212815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdSyWAAmgtvWxwCCBM2UNaIrykEqdMEI7qno43QP/C0=;
        b=VuTBClb0VwFJYRpAjzx71tVkw59DJ1pH/Ka7fias1TuHKCT8NAKb3I6B8ffXko/AeX
         pWWMXkr/0OYtznvTM6RRIti7fUWpcBohJBeM8ghpsAT9zY1Pg7+ZWejI2Dv/mci8oTk3
         OP4n8XzNvOTc0eS5VX1SNBezvAt3cDnUmO0qej1Ec+itfKcuSNrnQuWyW/M1LhBvyShL
         rl1i+yQt2yWCf9BS36Un4R43Rq7uzjz4cZvmEaTzX6kFtUGCOyI83jb1L3UkfvyUkvzd
         V+/Pbq8KYJAWmxGhk8BhfCjQsLnOMb277C8rfbX5mGXcaW91ObsV9oW3DHa70iHWweIY
         S9oA==
X-Forwarded-Encrypted: i=1; AJvYcCWDba47OkZM95CyO4fG4KEpkikXziK/hmOOVGQ1HjK3rIPkg+h8UV3Lgzd4IBrbnSyUC40wnB8HI8feNjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDwOPeLRRdwwA5gKd4mevX4vRFYap1yq4NV8OZVl+kaAZWPiB
	UOFKH0nQ1v4/1eUr4eT+L8Ggy+vbsH+iu3GxQhyVGIz3Mjk8Q/CbbkDRpFeKQNPZXE0=
X-Gm-Gg: ASbGncvVjFlmpaYP2yI622KLzrrc6ApBc1y7+95suwtiQPBqiHm+7U4KK3fvHw0gm2X
	VkqaVcCOJbBm/sxJ/oq3j9wfFoqBcb961WfywgTzz8HSDGYudOzMaaH4EoIa3YAHqq+LtitwEfq
	hdThM0On6HNW2XiRd2CuiXaj3OzTXjH83vH0Qs+JN8ADgN4imesfs0CO5gS98QdhLYeh40ijBb+
	n7wA8TkepydIcegK5/X0Mrlz+sGhFMDFJO1yxi5L1QkRvhLUA2MzpCzkrZ1o8mCkQoh9cNQWesg
	6M3wfmtQANKYmUpAU3KNqVydnDnFBW1pHaDaX98Ov/MMA5qW4oM3mRr+GM6N8KvLnmAPQ6XnGnY
	8d0UNyk47c9aV/cs/
X-Google-Smtp-Source: AGHT+IH7Y8AzaYShbuhS5vqbSZHUaQieOK8Cs1pHFVec6IaNCbe50DEYijiU0MeA9Ur94GZnE/WR2w==
X-Received: by 2002:a05:6830:60db:20b0:73e:9fea:f2bd with SMTP id 46e09a7af769-7432c92fcfcmr399306a34.26.1754608015042;
        Thu, 07 Aug 2025 16:06:55 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-74186ca9887sm4248915a34.4.2025.08.07.16.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 16:06:54 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 1/4] ipmi: Differentiate between reset and firmware update in maintenance
Date: Thu,  7 Aug 2025 18:02:32 -0500
Message-ID: <20250807230648.1112569-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807230648.1112569-1-corey@minyard.net>
References: <20250807230648.1112569-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows later changes to have different behaviour during a reset
verses a firmware update.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 42 ++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 8e9050f99e9e..f124c0b33db8 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -539,7 +539,11 @@ struct ipmi_smi {
 
 	/* For handling of maintenance mode. */
 	int maintenance_mode;
-	bool maintenance_mode_enable;
+
+#define IPMI_MAINTENANCE_MODE_STATE_OFF		0
+#define IPMI_MAINTENANCE_MODE_STATE_FIRMWARE	1
+#define IPMI_MAINTENANCE_MODE_STATE_RESET	2
+	int maintenance_mode_state;
 	int auto_maintenance_timeout;
 	spinlock_t maintenance_mode_lock; /* Used in a timer... */
 
@@ -1534,8 +1538,15 @@ EXPORT_SYMBOL(ipmi_get_maintenance_mode);
 static void maintenance_mode_update(struct ipmi_smi *intf)
 {
 	if (intf->handlers->set_maintenance_mode)
+		/*
+		 * Lower level drivers only care about firmware mode
+		 * as it affects their timing.  They don't care about
+		 * reset, which disables all commands for a while.
+		 */
 		intf->handlers->set_maintenance_mode(
-			intf->send_info, intf->maintenance_mode_enable);
+			intf->send_info,
+			(intf->maintenance_mode_state ==
+			 IPMI_MAINTENANCE_MODE_STATE_FIRMWARE));
 }
 
 int ipmi_set_maintenance_mode(struct ipmi_user *user, int mode)
@@ -1552,16 +1563,17 @@ int ipmi_set_maintenance_mode(struct ipmi_user *user, int mode)
 	if (intf->maintenance_mode != mode) {
 		switch (mode) {
 		case IPMI_MAINTENANCE_MODE_AUTO:
-			intf->maintenance_mode_enable
-				= (intf->auto_maintenance_timeout > 0);
+			/* Just leave it alone. */
 			break;
 
 		case IPMI_MAINTENANCE_MODE_OFF:
-			intf->maintenance_mode_enable = false;
+			intf->maintenance_mode_state =
+				IPMI_MAINTENANCE_MODE_STATE_OFF;
 			break;
 
 		case IPMI_MAINTENANCE_MODE_ON:
-			intf->maintenance_mode_enable = true;
+			intf->maintenance_mode_state =
+				IPMI_MAINTENANCE_MODE_STATE_FIRMWARE;
 			break;
 
 		default:
@@ -1922,13 +1934,18 @@ static int i_ipmi_req_sysintf(struct ipmi_smi        *intf,
 
 	if (is_maintenance_mode_cmd(msg)) {
 		unsigned long flags;
+		int newst;
+
+		if (msg->netfn == IPMI_NETFN_FIRMWARE_REQUEST)
+			newst = IPMI_MAINTENANCE_MODE_STATE_FIRMWARE;
+		else
+			newst = IPMI_MAINTENANCE_MODE_STATE_RESET;
 
 		spin_lock_irqsave(&intf->maintenance_mode_lock, flags);
-		intf->auto_maintenance_timeout
-			= maintenance_mode_timeout_ms;
+		intf->auto_maintenance_timeout = maintenance_mode_timeout_ms;
 		if (!intf->maintenance_mode
-		    && !intf->maintenance_mode_enable) {
-			intf->maintenance_mode_enable = true;
+				&& intf->maintenance_mode_state < newst) {
+			intf->maintenance_mode_state = newst;
 			maintenance_mode_update(intf);
 		}
 		spin_unlock_irqrestore(&intf->maintenance_mode_lock,
@@ -5083,7 +5100,8 @@ static bool ipmi_timeout_handler(struct ipmi_smi *intf,
 				-= timeout_period;
 			if (!intf->maintenance_mode
 			    && (intf->auto_maintenance_timeout <= 0)) {
-				intf->maintenance_mode_enable = false;
+				intf->maintenance_mode_state =
+					IPMI_MAINTENANCE_MODE_STATE_OFF;
 				maintenance_mode_update(intf);
 			}
 		}
@@ -5099,7 +5117,7 @@ static bool ipmi_timeout_handler(struct ipmi_smi *intf,
 static void ipmi_request_event(struct ipmi_smi *intf)
 {
 	/* No event requests when in maintenance mode. */
-	if (intf->maintenance_mode_enable)
+	if (intf->maintenance_mode_state)
 		return;
 
 	if (!intf->in_shutdown)
-- 
2.43.0


