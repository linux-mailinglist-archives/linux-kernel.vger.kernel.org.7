Return-Path: <linux-kernel+bounces-865678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE63BFDBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4692C18838AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337602E7F20;
	Wed, 22 Oct 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="O89bbgzk"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD0C2E282B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155769; cv=none; b=esJeqqn5pUXimLUZ6q+RJkQYLpn/BrXIRLXc6fVSAYqDpRy/WfYo7OxnycGIC45Dyo0tTxqgdvylP2YMsFjajqDkcvO98hwBi0ols6DVWyXOO78gNmLg9tBKnSMhGRHU/UucS1pLyAU0GzhHRyQmNldQ0giQ41A8MpWYKz+u/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155769; c=relaxed/simple;
	bh=3xRYUBDDYcWZ1R6AjXhlN/VoYyKv3hiCMW/JAJ0Ffu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSnMUjeuAQp33X2EibRz/IBtPJ/uQbk3BOyMt3hPjzjjF5YVGEgJqTrKHIhuCgLcmfWO3UKlfkcPLLBMirbLRcjNgIb6lr+FLUJS+dGgKlpd3zpK8bibIZov6DAbhW4zXNPPeP2TVLr9Pa4UMDBoQUimUF9f8SOzlf/ZGGiEnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=O89bbgzk; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so9559881a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761155764; x=1761760564; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aotiF7n+LY0a04odjKDOhsnUBTKQ7dsULgwZhNcVPQI=;
        b=O89bbgzkJHlmfmowZxqbceLVXT97PirbsT0eWHJDT4dqdaSBJa/3dWuNaYNeNIu2Iy
         RSV+zQUwu4nicSA30Rk3jyMXPUJhbx4azSMHAJ/3MsAraQY9WsMv3NMOvx1wqZkqztVQ
         Kb9fYxNp6gERgS9a8axcP5IoDmJctOYF2V1Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155764; x=1761760564;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aotiF7n+LY0a04odjKDOhsnUBTKQ7dsULgwZhNcVPQI=;
        b=b7QQ+cJwxO20qhwJkzkQNOojo+91kun+fNJHRzQxBKOFi/9Qi8FShcgJ7seNYqyMyN
         eN8bq1/xSgDolBwNGsHxiZEukLZ8yVjoyrjSscNQtPNDfqcE4/Lpx6kCAESQblLGXB7y
         Mb9/mqeR5pf3lPA6CiOgJLNLzJ2LFLq+kBY/jJ2iAu/5lzSV/XBlkr6HL68RoeiC8E29
         /1bjXJjlQd8nMFrzff+qyFvpGyyWGA4WvWGlK0lXejMHivdM1PUs2f72JM306lHofwx/
         C6sfFn0prER3eyhkS+PQiFmybLd2KpRyIekCybqj2UMYMOVx8ukP2eB/hUeINfIjOHwI
         Ktbg==
X-Gm-Message-State: AOJu0Yz0qqGYWn2Nl7ukoURw1xVBbXDE9ybmyt+DBRiJgz9oewwVFlvK
	A9xTdKlqAah0Sc5x7Uc1p6cysQlD9/G7tFN8zXruyvG+HNVe7nilIM19NSSqHnp8zq5lK85lqdb
	u0j7bWqPJS3iT/na6T97SZKm8i8qlorwmnHRuNFj3JYfdM+4TAj6p8Ioo
X-Gm-Gg: ASbGncvBVhcfaVHIBp7Yz+rowul7hGllib3Edik/Hd4U96iMW7D7QY66xW+q9KN+2wN
	FSaPHhjJyNC/0BI4s+QNFyWvyei0WgXM7XjxkeRS3jTnUxJERJTFtzrtnAYn/q6RyRjfI1Mj+a0
	xsLz6CmPmzGTTOtm+F7W+ByscOhNPKXVWbv4jGMtN6QDuxYXq6fre7QGSRjx/Jjip9vJhgV+e7z
	KPzcW95gJaa6wMBTpQCQMZuWn0yWnf6m/EbbBSsUvFvEtCNdtvfzbMMLtHG0WPU+TfWAdyYs5Dn
	1PtG397oeX/GFMr5UO2NhQpTUWTUgIeVIoCITudpLd8AQ5166MfsCLGTQMGOXYzDSaJaYlr6w5e
	cZEq99zKuyobIQeWs8S0j63eZ0S4Q/4zChJ4BBH7DDqY5ExBbBVA5F3dbZW9Xc5Y+OrNbdtchki
	Mrnq0lkhy5OL9FnUsblD/socn1pDmi/OUqg0JbRprBN5O6Nwwb6VYRT4wBkI8d98Wwm097sr6YW
	cE=
X-Google-Smtp-Source: AGHT+IFHSNbfLRxbCfK6cZ5Zk9weuJLzmoKjJV1ASSyKtChLrNSYoPX2YtglTx3SUALJqh8i2Bc5VA==
X-Received: by 2002:a17:90b:5386:b0:32e:9281:7c7b with SMTP id 98e67ed59e1d1-33bcf85da05mr22891436a91.3.1761155763688;
        Wed, 22 Oct 2025 10:56:03 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:e15:111c:b0e5:c724])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2652sm3214815a91.18.2025.10.22.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:56:03 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	biancaa2210329@ssn.edu.in,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] Subject: [PATCH v2] pcmcia/parport_cs: fix probe function syntax and error handling
Date: Wed, 22 Oct 2025 23:25:56 +0530
Message-ID: <20251022175556.62141-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202510222115.WBPLEBsN-lkp@intel.com>
References: <202510222115.WBPLEBsN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

This patch fixes compilation errors and warnings in the parport_config
function of the pcmcia/parport_cs driver.

- Correct misplaced braces and missing failed label
- Use the 'info' variable properly to avoid unused variable warnings
- Ensure consistent indentation and logical error handling flow

This is a follow-up fix patch addressing build errors reported by kernel test
robot on top of my previous patch:

https://lore.kernel.org/all/202510222115.WBPLEBsN-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 drivers/parport/parport_cs.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index c6d3f2ee03f7..d2bcfad08870 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -141,45 +141,45 @@ static int parport_config(struct pcmcia_device *link)
     dev_dbg(&link->dev, "parport_config\n");
 
     if (epp_mode)
-	    link->config_index |= FORCE_EPP_MODE;
+        link->config_index |= FORCE_EPP_MODE;
 
     ret = pcmcia_loop_config(link, parport_config_check, NULL);
     if (ret)
-	    goto failed;
+        goto failed;
 
     if (!link->irq)
-	    goto failed;
+        goto failed;
+
     ret = pcmcia_enable_device(link);
     if (ret)
-	    goto failed;
+        goto failed;
 
     p = parport_pc_probe_port(link->resource[0]->start,
-			      link->resource[1]->start,
-			      link->irq, PARPORT_DMA_NONE,
-			      &link->dev, IRQF_SHARED);
+                             link->resource[1]->start,
+                             link->irq, PARPORT_DMA_NONE,
+                             &link->dev, IRQF_SHARED);
     if (!p) {
         dev_err(&link->dev,
-            "parport_pc_probe_port() failed at 0x%03x, irq %u\n",
-            (unsigned int)link->resource[0]->start, link->irq);
+                "parport_pc_probe_port() failed at 0x%03x, irq %u\n",
+                (unsigned int)link->resource[0]->start, link->irq);
         goto failed;
-    }   
-
     }
 
     p->modes |= PARPORT_MODE_PCSPP;
     if (epp_mode)
-	p->modes |= PARPORT_MODE_TRISTATE | PARPORT_MODE_EPP;
+        p->modes |= PARPORT_MODE_TRISTATE | PARPORT_MODE_EPP;
     info->ndev = 1;
     info->port = p;
 
     return 0;
 
 failed:
-	parport_cs_release(link);
-	kfree(link->priv);
+    parport_cs_release(link);
+    kfree(link->priv);
     link->priv = NULL;
-	return -ENODEV;
-} /* parport_config */
+    return -ENODEV;
+}
+ /* parport_config */
 
 static void parport_cs_release(struct pcmcia_device *link)
 {
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

