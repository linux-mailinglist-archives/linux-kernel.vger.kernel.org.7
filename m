Return-Path: <linux-kernel+bounces-843508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C969BBF9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F088F3C29E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F82525F99B;
	Mon,  6 Oct 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI1Inr+F"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357C7266582
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787657; cv=none; b=L4ZQ4xC2R4G0MtX8L+/4AU7qUCmJzbmXEoDguosbGDZiUoiBRz6ZemLSYuHnQxw3wP7816hPNXO4MWVi+UznwZ86lWea+mClxPnk6rQ9mnD5rrY+GlfCPonXj62X16uDr42KBxEJE/xQ1XTPjorUj04AKUkKVGae81/NUwL/VTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787657; c=relaxed/simple;
	bh=TN8DVVtOI0uVF0pVf3w3bAdjS3386PQdWfU2VmCuHTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezUMfUwn/VWB9WdvgnOYP4qa8eDtGnqRN69TVwhRCyq1x26Mgo0McQ5o7gYEUhHHHmTpvd9BX8+3U2W3dnKkEGgYRNwXAKOg6nOBof+6ZnoBsfSs6cD3/l1Z2dinMeMA6Mi1Jq++/sEihtvU/i8kgRlvBgf/TEaRWIBboFdZSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI1Inr+F; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-85ed0a1b35dso445529785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787655; x=1760392455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2sIp4WFShfr4eCKdCALf03P/N949F7OBVMFA66z5UM=;
        b=JI1Inr+Fb9nlMSCVFZ4/9Gey825jgXgglAzX22S4ifTSYWMVEU0qXc4VT31hy8e71f
         BycTkvF5rPHtBomz/W8EdVlP3X0zrKqUEk0Z3j19yyYSXfzilbFJIUYgSZzmgvVct95C
         tDejA5TTLg2dW64jPh3sutopQznh+/7dGdCHJzQOcfsbOCtNOjCmG9L5lLgPamtSRF9y
         NdsnGR5EtJX9ac8UiBWkrxo3BGiIGBtTXdlJLdylMmCacFSrvifkqwVlqM0qoXerUIsI
         zZhvQge3J9FkMT4cc/jfvkmBJ7clSJaHlDK0DkUPCfdmCDi8FiM/dBKxVyi5xba1bCjG
         4aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787655; x=1760392455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2sIp4WFShfr4eCKdCALf03P/N949F7OBVMFA66z5UM=;
        b=sUorQV6/hY56cNb9VPw9x28QCZnrXARpHPAyxepmkwBsSC5j5yssFhRDa1rMSZoNkw
         pMjOiBVFXKLwu7h2czAmVWPVvAKosunerhf3vdvq6InKzDJYg69mFu3QrBLAeBenOulm
         w9vNLxoHgnlbPDAGr1tT8mNt4q647fmLBp+hU1vJvr3zPE61N7KP3NgVTMZH4Xp/tuxI
         Mqfo+1Tl9yrmrflo9TCakTHvn063xRL6FMew1Z+MD1XVmffU0i05c0wn1pbG34zF4tA+
         9C8Sm2XHxzVzr2o3RFVscYF8g1obmNaR7kmL7JZPEEHR3M33R2lxHwz/C/26peTqD892
         N03A==
X-Forwarded-Encrypted: i=1; AJvYcCU/sd+vwXRxDZ0m56iFoWr5s4XjHQEGePDieuvZMNd+gSmfQiRcNhrLMVktw/amGP8zqeMA4THy7WHCaz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvfaHvhO56YaoINhoTxUWz8u+9Sfn/B7r8K67Ywb2eyLfLU1O
	rPP7f95Td58cUScAQXUMrIUkiibOBMiVxoG9WbtbI9NlVXg+wmFHEVkJ
X-Gm-Gg: ASbGncsLSDTX4XbQEMAbr0Qb+Pen/dQqMcj/dqwhdwP6lKsE/hVMlB5AFpfbzyxBM+U
	oG7Qu2kD3CdYsTEgDmR4jMSUC5DK3gIwG95T97fCt07mGe8kmGeomN5lJ32OTyfez/KMeMPOp1R
	49XmKFWQsqGLOJbX4wLWiC+H9jjU3GNQGc4oCnWE0ZVr2tJutNjf9kn5NpzAA79CvxCmI07xQES
	8EVNc7k5NgvW2NgVBKUj1WAGPQfoS5arlRe5ytO0K9b2LkG/VuFIeoIkDn4KE2pd/IRrtXA03q9
	VWdJ3RNvAcbYgaT8gvEQYyQX3gmdvfsAKSv6MpO81bX5dPudZEBGkOI86GLCyMXkg38BQFc0Tn6
	nU2K1RPdKkKSkaplONNqniE82wObUTXKG46wDAsN4clUf6BbE
X-Google-Smtp-Source: AGHT+IFqsWVnCpjYKU1itjoK+0G07oo7F31f4A0dLj7qpRKOEEW3bL5j0OvrFQf9Ro4ztA0Q1cj6GQ==
X-Received: by 2002:a05:620a:40d1:b0:85e:adef:a774 with SMTP id af79cd13be357-87a390f16b8mr1404131885a.82.1759787654780;
        Mon, 06 Oct 2025 14:54:14 -0700 (PDT)
Received: from fr.lan ([81.200.23.195])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-87771129478sm1314168585a.1.2025.10.06.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 14:54:14 -0700 (PDT)
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Iwona Winiarska <iwona.winiarska@intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 1/3] peci: cpu: add Intel Emerald Rapids support
Date: Tue,  7 Oct 2025 00:53:19 +0300
Message-ID: <20251006215321.5036-2-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251006215321.5036-1-fr0st61te@gmail.com>
References: <20251006215321.5036-1-fr0st61te@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for detection of Intel Emerald Rapids processor based on
CPU model.

Emerald Rapids Xeon processors with the model set to
INTEL_EMERALDRAPIDS_X. The data field for this entry is "emr".

Tested the patch series with AST2600 BMC with 5S Intel Emerald Rapids
processors & verified by reading cpu & dimm temperature which matches
host sensor values from lmsensors.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 drivers/peci/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index 2dac8ba82787..fbccc1d1b637 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -321,6 +321,10 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
 		.x86_vfm = INTEL_SAPPHIRERAPIDS_X,
 		.data	= "spr",
 	},
+	{ /* Emerald Rapids Xeon */
+		.x86_vfm  = INTEL_EMERALDRAPIDS_X,
+		.data  = "emr",
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(peci, peci_cpu_device_ids);
-- 
2.49.0


