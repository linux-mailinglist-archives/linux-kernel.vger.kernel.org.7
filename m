Return-Path: <linux-kernel+bounces-759587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C46B1DFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3123E586559
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED4272E56;
	Thu,  7 Aug 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="r50Yn7lT"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81E26CE3E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608022; cv=none; b=finWKR1KhgbbwyRm67VJ6qY6WsvLh1qEUFnm4izDvOmM6QyrrvRa3wFsjG03xdeIrYr1XzX0NHCGzua7brY9LWJ+TbRncylSU1XKwYZhGi5S36i1ki3sfqu5a9jRHE0W5cTTOIrimYTmCBqQQDxj3bn7AoyAN74TBpumG6ivvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608022; c=relaxed/simple;
	bh=hBoiy5Njp8ZCJ/n7iWw83Ack4j7wdkAwaMdGJbcPmHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oODfPXs6n6drmRXwmZLoj6hPbDSoNOYNacwD+zZ9JPgys9tfRuRlEW7vT7H3hOvcSwxQsF/Tmzdrc4F3yql3iMv1wu0IGcgx7S+ShQ+njBS+NMxKBUIyUH5btyET/OFQGOJELVC0fCa6AF3qFSaXhjw5csFkzF1g7xQmh2x2rbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=r50Yn7lT; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-301a83477e5so1329041fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754608020; x=1755212820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTujPee3e+IrMHsfbNa64QplGpBbUeVdtGMoE8o/AV4=;
        b=r50Yn7lTvMrJ0c2j0FBlwBiSbeyKdi0DNvAAmp/g3KYqksT/rbHeXUonkHeZHCHnsE
         e2Zz+Cj5bMJVPfuRiCojpwUrYoWOiMb4PmTh+4QwJJxRclocejYv5WF21hHTN6NvUST5
         oTa2wGOpoYcdSWNnqyrDPvE0b67f89EILA5dJJmQDktgtUPhTZNdpcnFWQWUVg0I+uIK
         XChP4LsxbeoxAVQHNmMIQJoJBynQ+wUmpC8rQ7Ya27w1biC6S2AHzEC9OkxxXc9+Ab2+
         lxHhWUXo0va6v4YCOXF1kRNcTpmjSWgpFesRYeOGbo+z/JB7ut41QNdMt2NDO3SnBpb4
         26/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608020; x=1755212820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTujPee3e+IrMHsfbNa64QplGpBbUeVdtGMoE8o/AV4=;
        b=YpOf33jChM7hsorsEfvLKE37ZV6DY9SK7F7ZEIf0v9qGz7D4EV6Cxz7xaADD+xH8Mz
         NFrXNP274ETiZm7nAV7lDDRmUeQCnzoG72GzikFARrjB410ZXRCZ1Cp0/PqZg5YqEl8k
         9wR/nuQq7RaITs677XenEdwj8q2Mm22nCkwjeKEBLqq4fHmbQnXq43kYZNvmShu5J7Fn
         n8S4rlFcmW3YohC3bVjxiPSpEWIZuvD1v/rdHRS3X6D8KErELmYloXr552okaoyzNoJR
         NoibcRkwQQXKJJsx+iZD8LZPx7fe8phjXBzpm/4LyK8xXyIZoZH07tRO5CzVn9X2fWAZ
         cKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0k0V2+346TL3F4NDDXpw0aOGk4LDl4aT2IeEPs2HzJibjhrOzV6Mg6Jwa0Jm/Xb+9ucAlVYHfX358KeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LT1hZL5pi8OzpI8Eetc9TWfp8MbRTSLQUOavKe5vHhK2y4pq
	loSFnF0VFpx1arkIQTVRineMt1kmNtLfda9dLVyeag87SovYmkzCys6Id+6z6YXTCaM=
X-Gm-Gg: ASbGncsh0sw6MPQYu1m/0QvT8aLTZ2pqUytoTm3S1bon/6wMZY0oxSlIPkD6F+6LfUG
	/uKItYQyrnb8bYX0tnnRUKbbgeYdqjKEAWOpaPcAB27kmmU5isQfLYi+4kQA6rDZOOo5vIq4QUN
	8rczUAiQ1G2lFrkdRE+aKvsVRi/c03nt6BO/CzSzcbs26Ua0QSD35qTw/DqmrC84u/FRQ3RARoy
	B2JknSs/BN4heL0/lHULX9vAVLGJA+ygVFSThPf0Ae/roLk+uXkszJOELCKjYyK3EM7vc6F3AtN
	yuNwqkoeuIWySmzpiBClmZBAP4+6hX15SJs/1gLHoCZRSAIOou2FmDGtwsWWC21bNuCU9vILdAC
	3bFqY1SF3vStRv7Zb
X-Google-Smtp-Source: AGHT+IGqT8rMNHXs7hE7uZROM2POhObfELF4WRYLa0cBDDDUBtGQiu/oyg2rVykvWsU1gzaiXy+CSg==
X-Received: by 2002:a05:6870:15c8:b0:30b:a81d:b56 with SMTP id 586e51a60fabf-30c21397d31mr710798fac.38.1754608019939;
        Thu, 07 Aug 2025 16:06:59 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-74186d912e6sm4278144a34.29.2025.08.07.16.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 16:06:59 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 4/4] ipmi: Set a timer for maintenance mode
Date: Thu,  7 Aug 2025 18:02:35 -0500
Message-ID: <20250807230648.1112569-5-corey@minyard.net>
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

Now that maintenance mode rejects all messages, there's nothing to
run time timer.  Make sure the timer is running in maintenance mode.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 5ff35c473b50..786c71eb00f4 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -50,6 +50,8 @@ static void intf_free(struct kref *ref);
 static bool initialized;
 static bool drvregistered;
 
+static struct timer_list ipmi_timer;
+
 /* Numbers in this enumerator should be mapped to ipmi_panic_event_str */
 enum ipmi_panic_event_op {
 	IPMI_SEND_PANIC_EVENT_NONE,
@@ -1948,6 +1950,7 @@ static int i_ipmi_req_sysintf(struct ipmi_smi        *intf,
 				&& intf->maintenance_mode_state < newst) {
 			intf->maintenance_mode_state = newst;
 			maintenance_mode_update(intf);
+			mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 		}
 		spin_unlock_irqrestore(&intf->maintenance_mode_lock,
 				       flags);
@@ -5136,6 +5139,7 @@ static bool ipmi_timeout_handler(struct ipmi_smi *intf,
 			    && (intf->auto_maintenance_timeout <= 0)) {
 				intf->maintenance_mode_state =
 					IPMI_MAINTENANCE_MODE_STATE_OFF;
+				intf->auto_maintenance_timeout = 0;
 				maintenance_mode_update(intf);
 			}
 		}
@@ -5158,8 +5162,6 @@ static void ipmi_request_event(struct ipmi_smi *intf)
 		intf->handlers->request_events(intf->send_info);
 }
 
-static struct timer_list ipmi_timer;
-
 static atomic_t stop_operation;
 
 static void ipmi_timeout_work(struct work_struct *work)
@@ -5183,6 +5185,8 @@ static void ipmi_timeout_work(struct work_struct *work)
 			}
 			need_timer = true;
 		}
+		if (intf->maintenance_mode_state)
+			need_timer = true;
 
 		need_timer |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
 	}
-- 
2.43.0


