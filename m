Return-Path: <linux-kernel+bounces-753415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DFB18291
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48FF7B1EC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382426B2B0;
	Fri,  1 Aug 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGIq5nlO"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306372580FF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055292; cv=none; b=OjC/p0kfekAOlbg4G7RwnzawBPyrwRx/gQ+Fi/oWPQ5V1yK0fva3fcvnKm9vBVsCs72TAMxG0JsFS5YidS5AViwMS55iSs6jIR4MGRwCFPSJTCdV9a+sDtzOW+jQrerYLwR82EojChZxn2sDGapLJVoZla6GSsb7iPpie/Oep98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055292; c=relaxed/simple;
	bh=B6dkp/BBDmEeyjf+/PEcpn9dFT32NaecIIHFog8H+Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qe6mOdWftyNz8nmMnOfoUUy/uUlmyZopF21keHIH9MVOIM10aodUhGaIxbUFSHq4iqZulqiqCKGtRD/F92Z3qJCjXqP1emtXRk1iyU5GK063uaZR0XkayluDa8qyRtqYEZtsNx2BM4JL0KEXEP9QkEbXvA0WVDhNkJNbwDfoHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGIq5nlO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so21488255e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754055289; x=1754660089; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91nE9pIukFXGqv89yf8nL8EO399drb1w4wsJvfUDGbI=;
        b=jGIq5nlOTqTHOeTMmdnAdUm4MVBgOjeeSwxDrSwiJuuEnQw0SFXoWxSXZgLZ8YwVOh
         Vtga69wUhbQly/+rJNXs+En0o40ERdPqLOdtIigc96ifZfsbh1Xc/GHquQJyCUGLhMYd
         A/1PQzcw+T4axYTWoFfMyH349K6HcM92jFxqims74R2XzFo31NQ2R3PS/92VT0xgb4om
         TNJMMddMSpVplI+ShJRS2B0c8WDz7ckA6fnppjZWCZX46Dv3a4YIKhN4a8x7H2e2WNfn
         oIU1GE1aRxcHfxbc7xqB1vTM8ndW1lDWkXzjY1aMvj35NWPDeZVI/L1JIKEvVhAtYPh6
         gwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055289; x=1754660089;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91nE9pIukFXGqv89yf8nL8EO399drb1w4wsJvfUDGbI=;
        b=jCvRKk9tceBN7nCb6jlWnwpYnhCbZIA68NNXKHd0G1R1ZAzlSui0/yvHmB3X3v79uE
         zXkF7Dww1e/SmQ++RL9+k88AQJ2ZC291lSAQsUfxnpDDVRn8abE9ubcArsM3pukADxoA
         0Fb8wfUj3IVwPBO9UR0oiHB3RjTkO/BpFCLY4iiYPUmm1dRMMAWZW6bVlsR+Wh96nHxs
         jgDREnfGYhCYCXm3dcKq6VqFdVnxVE722Aw6GWK3COYv7JLFgnYCsSoI86MRwiZZ6Yv2
         Am0w6u3HyeEV1fzb4xPdeakNUY/wAqUm+r7AF0Gag3mvUdTwGNQgGjV4Q5P/IqEcwUDH
         GLrg==
X-Forwarded-Encrypted: i=1; AJvYcCW7AFTw4+DKWu+eYF6qMIICow7hjAKhNYO4x9dNl4EKGqrih0c6MDDkACCuz4Oo2fBlQ7VWg2PINrivtGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5785J/aLExINFQ7kUO+aFcBWcsLboRhZdSjb9Yo9j30wjF2GO
	qjZTA7qrnOaT4pe+Gb4CXGIDuCY2QnRan6ox4VzpW/T+ozz5EzZt0v+o2jbwjO9wRRY=
X-Gm-Gg: ASbGncsx0lU/Z35nRwLDNRFpAoGeKiO62YXLJAkWN24++Q9/kfohWsPZHNUCE+Kqc27
	Up7gVCA2+8hRDtI6Ug+HIruXvYPfuST3gfoJhUipvZgDQZTPSaV0frQYQ4d8sMERQur2fZ51Y02
	sJRA0FajKk76imyJHSaJ5togyOQS5G+NR+iK0trsseO4mhIUtHQFnLnA4T5Ez/VKWe5tlj29+Ke
	GmXW/dOTsY1fXj4BCIWTcSbZPsgHY+m6uyDjXK/7JkHpEj9Sju2lMurDsTrTZjf0eZKzQU8wAQJ
	hi5gqcAzGEALoaL68u7YGyVvnKP9SobZv5LszMcoBV2RrD/Tzbjde77bjeYC/X8cpjFXGfAN+jp
	UURaduGEBw4amDnIcKrQwtdQW62Xi9JMlCmf5kQ==
X-Google-Smtp-Source: AGHT+IGINVe5hDq+30CQhj/n/29dWvuH5Attb1DwC+ibJDto9n7Mzc5Zl/21ZMrbaLLxn/fjg1KzyA==
X-Received: by 2002:a05:600c:1388:b0:456:25e7:bed with SMTP id 5b1f17b1804b1-4589af5ba2fmr100886665e9.14.1754055289518;
        Fri, 01 Aug 2025 06:34:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458b4a6635asm1093675e9.29.2025.08.01.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:34:49 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:34:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR() check
 in pci_epf_write_msi_msg()
Message-ID: <aIzCdV8jyBeql-Oa@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pci_epc_get() function returns error pointers.  It never returns NULL.
Update the check to match.

Fixes: 1c3b002c6bf6 ("PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/endpoint/pci-ep-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 9ca89cbfec15..1b58357b905f 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -24,7 +24,7 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct pci_epf *epf;
 
 	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
-	if (!epc)
+	if (IS_ERR(epc))
 		return;
 
 	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
-- 
2.47.2


