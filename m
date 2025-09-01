Return-Path: <linux-kernel+bounces-795031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BFDB3EC04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55043440412
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288362EC0BE;
	Mon,  1 Sep 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONnVdTJq"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC362DF147;
	Mon,  1 Sep 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756743136; cv=none; b=PIhntbM8RcC4NZTHNA1JTdKonvln4z2M/GEu/zAEWEZdsValehpFIhJbn+6x/+ze0VnDP0RfYAYaj02tqZ3DOctiLWTDwlQUbNOYrgOdkjEB9Cqa8N0tEiimhtY5CtqOLJTjboZvZ9sjkKMGpmfHGltmx2FmNDW+cWVt98C8EQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756743136; c=relaxed/simple;
	bh=wBVV8lCyWpzak5Ahq0TyAHZqwjZBUNzGkG5CgU5NEkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTihPiRq8RVnT+GE6kcpF5Ya1rf4YmWzaEuBNoZpXbHWo6Y6ha7DwaH5dAAwxJMmWs98jXQxntZAPE56gJOjaMK9O91qUT4oRozQz7cDoK1DjR1FaD9EnRiT/afefu25JeVdhSTRNfvjdo1QMGrbbb8JIhZsrjWXgyzABy0bt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONnVdTJq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so1107688e87.1;
        Mon, 01 Sep 2025 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756743133; x=1757347933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvGFPcLRQG7NDdcutxPYCIPA441LFKGMfIhq/xAeHWw=;
        b=ONnVdTJq9U05GTUhk1DxChkvzqChtdrFUrDGKoKd5RQLFB334oWyPHNqjzpe017xwG
         H8gmbZTVCfJ6RfUYEwol75/q1LQbbFPqh60ri3YWMP4gy+Exqg3Zyp5u7V90RnCNoeyj
         uCZkVChqEsEoTlQB1jJJupZ+GwFvXVHlUlQB604exIefQY14xuPgwJIgnX4xO/cZgeGW
         BsKSCGbLmtug09yy1ObF85NwsnF2pKF6pZ3HucIpSq+5+tn+cCUCcGmtSgfCnH/AcC17
         G5WXGGkt/9595n1xn2tMGXxCKOoKneAJywLoCxWzdHs2Xtj1jcybBd94gEnsF/egNL4U
         aeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756743133; x=1757347933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvGFPcLRQG7NDdcutxPYCIPA441LFKGMfIhq/xAeHWw=;
        b=LSt0Yh8YbXAU1RY089fiWVZHDP1R6q4DflijuRQ1IqjUsoz5XNh92yT+c5FSZeUv6H
         /vwdF98rcTG8o8hwVfuyFnrX0XLshvJrDcLcogaGhh0fc7dCZLdBzDNU0UbiEVx7ZCp0
         /jh+ZnMisj5MwRSuk8xXkfYz3OrH3ydod0he1WzQii0cyLelBE1h0WChit6bn1tIsym6
         Jxf2dnRA38NKI5zWT7pgWXjqoUxrzzgCXYco4tTQB3ihJVdQWtKZOUYY80dQcthvznZD
         gjfN5SVokp3HA7S6QB5D8XQbXwns6WH7kHxzDWtVyFHUyVTCjth9BdvvnpMoxlU/V9c0
         kAIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrpbC57nuvex/QC34ICTtMFbWDL3GnB4GWoYGCLXG4DmqygkTvslG2d2VgEV++co1YWVJBYhRrhQ==@vger.kernel.org, AJvYcCVgsJ1YwRtcEeyqKBwXavV92h+Hr81i7CjTMEv7gbTBqNX/rEWcliHMFmUCC2QunNhpXRQLdNFjVPdggKW9@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6iAczuWvlS2lqpjPWkahomLV25gCGYEvFZ7sURt1JJUh8NP/
	PGBQl4Hao1EdRR5KEZcsEWEX6Rdv8TQigMRmaHI3inqOCOzxl5SIc26Q
X-Gm-Gg: ASbGncuZeTJvq6jwoSHco2w6dhq+mFoDCwAycoiAQj3su5aAWDiJeDNc7Uh4St2cPCv
	Uht3Y4iHjhYUEqZEgfUMY4gnVidEY3gAm4nMB1QIa0vN5bN8LS4lvK8kH82UCPLUqfm6xq8e/h6
	MnyE7lKzDkrP2yJ5U1lZKneCHXNt7WRvZqq9+fD8+iyB2b3wEG08UL92QlK55YJYde/p4kG+j4E
	+xbiMiqsv/t05nkRq3zDNmM44jw/BIL/gOg806iP+DLnXwztd4qI3zt5RTmMqziuqEk0gAEKOHw
	50bRla+k4AV8ILTmj1e3yWEZQev0dVqC+JkPLL7VT3q49tuKHoAoPlzGUACmUIYEkZErV3XaGrS
	DxxgJac2Ck+1oCzeYdEChtKJkaHkALdiU+0FQGzxXSBi7T0mqmAEa
X-Google-Smtp-Source: AGHT+IHiwUTnaB7EPGGt0HbzOzE4Bp/CJPYgR1UiGBYb4q+hoCwWA9Bw5YVLHvDVa+uK0xVrCHrHcg==
X-Received: by 2002:a05:6512:b88:b0:55f:699b:98f8 with SMTP id 2adb3069b0e04-55f7089be9bmr2590042e87.12.1756743132572;
        Mon, 01 Sep 2025 09:12:12 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([88.201.206.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6771b237sm3028827e87.54.2025.09.01.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 09:12:12 -0700 (PDT)
From: Artem Shimko <artyom.shimko@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Artem Shimko <artyom.shimko@gmail.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firmware: arm_scmi: add missing spinlock documentation
Date: Mon,  1 Sep 2025 19:12:04 +0300
Message-ID: <20250901161207.2501078-3-artyom.shimko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901161207.2501078-1-artyom.shimko@gmail.com>
References: <y>
 <20250901161207.2501078-1-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a missing comment for xfer_lock spinlock in struct scmi_xfers_info.
The spinlock protects access to the xfer buffers and transfer allocation
mechanism, preventing race conditions in concurrent access scenarios.

Signed-off-by: Artem Shimko <artyom.shimko@gmail.com>
---
 drivers/firmware/arm_scmi/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bd56a877fdfc..6828392152f4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -76,6 +76,7 @@ static struct dentry *scmi_top_dentry;
  */
 struct scmi_xfers_info {
 	unsigned long *xfer_alloc_table;
+	/* Protects access to the xfer buffers */
 	spinlock_t xfer_lock;
 	int max_msg;
 	struct hlist_head free_xfers;
-- 
2.43.0


