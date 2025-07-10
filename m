Return-Path: <linux-kernel+bounces-725706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E392B002AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CFE3A517C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831825FA3B;
	Thu, 10 Jul 2025 12:57:38 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E1944F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152258; cv=none; b=kA+US/NCAA2niFDrHVoM6H6PRROwfzx4FYCDP4Ziw+UCb5hzPg60hZgNAprA9ow4XbqCDoBt+Yyk5WdYWa2DbYKJ4NDjhvcCH2bPvzrRfmJcvwSIh6wvd934a253r+wLrdFzJM3Fz5TV2pq6hBWwLo9Vw0XUu8+2GZp4fx9S8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152258; c=relaxed/simple;
	bh=aZXwepTMm1SjtaRRE6w1PAlyV06drJpdNhaXFbURQAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SuR0HtsZH8c5C5eec+nSGPG9sMV+AYrrm+owpyNNVGraB0NI36aeuY3J155tCohzD+pYSO8Mr4+46dz9zWH9OeKOcxmlv9micUn7xhMfjwpvGqozNU9YQk8o1VoWYcZYcj1k68F+ZILgj/S9yhQcbf1Bkca9JClQ2Gqe9sxUEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb5ec407b1so166420466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752152254; x=1752757054;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T1UqcynHtFUXc4FYXURNMvle/T+fvFMB6mekqNHT30=;
        b=sk5mh1+dSKbkFHNJEvOB/KJ/Pvbqd8NlFXM/h8+uhZJka+e6HVIppXk/zlQCp8Dyv3
         EGT+NzEIPN2bvV5DlymbPs6CVN+NM82tQryQSFvj1hlaN44OkHuzNhmADxhgQ5K0SIGl
         L9V+jjUOYlVZj/xf6+wmLaH5BWMn3oCUnltWzK+PRzCP8c0m9pwlq0lzHL8zoHtYX3Vl
         CZAeLu38HKZP5ghReQeRGwfJ1oQBNvMhLHYaTo0LvnSMbo1xoDV2aD0xmRXUY6CB71cM
         MGCkhl+yN1oLIKks7iEHykDWYIpjDlLpJ0RP3hQKzQDYJnyxupbOVlrb3GWgVkU0MSzF
         CCuA==
X-Forwarded-Encrypted: i=1; AJvYcCVi1glhXs5bxb+doHiChyraLAHHzG19xDW4pATQBxBGH6lyrfKxgU+RzwdhDPW1suqDrbg/cslJx18f70k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/NmdzC1xjZJW6LUK+Gsef4Le6ruuJgBZk8NrIknLulhhnXF8h
	lm8ksRElJyy2B4zAK36ZnozseUAJZ8vlaJTrZ5zEQXRKmvAvZwcoQwaW
X-Gm-Gg: ASbGncu8FZRAFFRIu3/8HsUu1OttMue4UQtu0g9r2DMB/+5dKXV5WVa01P0mbxJ1xok
	S32JVC3Ivt8J+jCXfz0QYVOIYFsib0VANmuiGiq2uIZag9STnKMXMEDgZF3OlP6lbj4aGrULLiN
	Kxq0dfFIbU6djZadKq6YH73SLgaeI1roVw4/1hh67DZAt4fVOUQeHEdFh4wxIvwMGFXBOlaDqtB
	DOBIr3QEFF0nJGFqHjTMdC+JA0gZyiNRzx81rmgSJfhT77bEPynw80JV1tlZ8jYXRLl98A4H4KO
	H7ez+PKB5pMX2ug3nMF9rQdoiuZ2eaIfLH1aiA/OO4hccF87kFxp
X-Google-Smtp-Source: AGHT+IFx2GBiW2dFdLmLTmCtIWGb9kwIB+roe209Q1FBkVTtAkwn+/3L/ntAoRMiPZr2z+G5ZNq1jA==
X-Received: by 2002:a17:906:d7d0:b0:ad5:27f5:7183 with SMTP id a640c23a62f3a-ae6e124f672mr396710566b.39.1752152254217;
        Thu, 10 Jul 2025 05:57:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e3a8csm127271066b.154.2025.07.10.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:57:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 10 Jul 2025 05:57:26 -0700
Subject: [PATCH] ipmi: Use dev_warn_ratelimited() for incorrect message
 warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-ipmi_ratelimit-v1-1-6d417015ebe9@debian.org>
X-B4-Tracking: v=1; b=H4sIALW4b2gC/x3M7QaAMBQG4Fs53t+NLWbsVpJMneqlL1sS6d6j5
 wKeB0UztSDKg6wXC/cNUVwl6Oe0TWo4IApqW3sbnDU8VnY5nbpw5WmCujR6F2zvAyrBkXXk/Yd
 N+74fRYaHumAAAAA=
X-Change-ID: 20250710-ipmi_ratelimit-7e1af5170c57
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=leitao@debian.org;
 h=from:subject:message-id; bh=aZXwepTMm1SjtaRRE6w1PAlyV06drJpdNhaXFbURQAQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBob7i8mMcbWKBbQRzsMwGo3MdO4dyywHAJpylNN
 o7BmZJCsXCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaG+4vAAKCRA1o5Of/Hh3
 baijD/9DqFY5fctNGRrjrpvXXBZid/tDZ7qSnF2Ch6x8EnVgi+6AS65tjNJ41F3PiH1NH0fGbuC
 9RtEg2V0x69CYd9hw9/NsmlHfOB3Z2NNdrARms0xTfUfQ4eQDolJgda+XXsOQAIIfIAKPSZwJQG
 BkpuNptNnd3MegSZ9hTaNekVen5JPJcPtPUERqqhDboHV/jSELNfeAaA48zg5mZnpRpWpqJMTJY
 oomoL51qQPZno/tdr3WEDvasDviSTx8v3TiVB5P2hJPRllrFiiPXHC285HqX4sKWR7FsmWnukV6
 /HBlv4qV2mtjFPyXG22sBhseCsbVXNSRUNjOVU3iqSp1nDvoyXdq10goeDoxll/n2zfBdsowiJG
 x2r5FRX6GZjjGgeMJZGnU+ywbi7XVJz4m7liP5mnPhQtoTUsG1kYuaBgWT8UErh+XmnBFd8SEXh
 8HiSTKqIxpOuTdnISflyMBkdjQ/2CZ4Zm7GPalB7TJ7PKaTFpnC2g47XX8Vf1vahtErr41p4LUp
 h/4Xe5RopIfIXg3WzdQu31Fwie1ObbGhEQF7SeepB/zvRl7GohkZmtvLd8V7uZLolCnGI0rMscl
 o+Vr3OckFLU1iHJ5dY+GxXcGEBBYgDCCa0oWo8ifjG+HNCZOrU5sEofU/PmlK7wgbbRaEojBJQK
 54Tf5EmHX+rSj5A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

During BMC firmware upgrades on live systems, the ipmi_msghandler
generates excessive "BMC returned incorrect response" warnings
while the BMC is temporarily offline. This can flood system logs
in large deployments.

Replace dev_warn() with dev_warn_ratelimited() to throttle these
warnings and prevent log spam during BMC maintenance operations.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 064944ae9fdc3..8e9050f99e9ef 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4607,10 +4607,10 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 		 * The NetFN and Command in the response is not even
 		 * marginally correct.
 		 */
-		dev_warn(intf->si_dev,
-			 "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
-			 (msg->data[0] >> 2) | 1, msg->data[1],
-			 msg->rsp[0] >> 2, msg->rsp[1]);
+		dev_warn_ratelimited(intf->si_dev,
+				     "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
+				     (msg->data[0] >> 2) | 1, msg->data[1],
+				     msg->rsp[0] >> 2, msg->rsp[1]);
 
 		goto return_unspecified;
 	}

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250710-ipmi_ratelimit-7e1af5170c57

Best regards,
--  
Breno Leitao <leitao@debian.org>


