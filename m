Return-Path: <linux-kernel+bounces-753668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39126B1862B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573527B9353
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2521C1DF755;
	Fri,  1 Aug 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFBv7MO8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284919C556
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067822; cv=none; b=CMyRCIebBktxb6Xpzuhzj2bAKYGjuJiVyPjfrc4E/6SSzgdRZJTRRTSaEXsF6z3mZiHJE1Ka/jMSihowFOdAfOSVFbFS2Op3K5Y+UlxWM80q6rOwbe9vrXHzSNLDQyKX1nSlVD0K8d9gr0sVmzyIiVguJmPMyhzE1KuQK2UmzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067822; c=relaxed/simple;
	bh=nCQxiJoszU8ksOrhF3/w351OjygrjbbqU1ObSybD2RY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A27cy0bsuzrxKSOiLlwSUMFwC26N4X5c85JYf7jHc2RQgJq8Egl7Vwqrjb+0FhUVgG7CtHueCel1BdzaGJHJR025eCM441sJaUEEXQCNwDt8Q+VgRL2zj839sHaZzjVnMXt8i2nsiGASgr/6gdag32jGNpShzyW07Ax8UxyW3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFBv7MO8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4560d176f97so12197805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754067818; x=1754672618; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8Idzcjcrmg19teuU7qWglO1ohyMC29kZ4c9xikiJd8=;
        b=fFBv7MO8DM8RD48Bddnrzh2oxr+ZmOKyuxIUb+aD+BeljgnBqLLg2UxXuouQB+aZkm
         5ZQmHN1C9HYfIfqjRlAHCyoYhCQrRzRgqnGCafbnnbwqKIEDnFKyNFkirumOU1n/edMy
         i3I7xthmIvCA6eM/s/nqPDe+ixoGoIxOKrIMaoEcK0pdOZtkrBT9rSOe50ssOXPqDigl
         nMBlfk5KQQmgAHVRagxcMQumqd8XEI96/fsVL7a5rq+XWIkNcE37/vyxTWpSOfoU2TbE
         9cs1+vUvFIiI5Vam67kXFxRyQLDDXT9rxFZMBoJbikZ/+++Tsic5jFYOSdw4EhPyjNLq
         H0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067818; x=1754672618;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8Idzcjcrmg19teuU7qWglO1ohyMC29kZ4c9xikiJd8=;
        b=MOnyDkPzWR6VeD+zha2qvvl8wZRWtg1Md5P2mQV97Zj8mMAV55Fy1kydYZgBAKoAro
         jiH0ghKalVGmyh1hR4FrE4HfhoU7VBQaaLW+JIAJ72QvzkccPZrwyCX5qhcEWqyqKD8x
         mUEGHCnG9ehLnfmp3mJ/iA1UBLqvzRLsAxn2gUeH/JIRTntjD11tBJffdb5Un7ynLoqi
         84UVpJEeauyNFJUPDFJVAjSKlPe3+lLS7qKK+ibhXYa+3cDevWRhRSz1hc+eIkiNUods
         520lQ1RPp1e179gj0ukQy0YmbwGoKBDy0QaXLYXShEx3qI6gxW0yru4qM3HeIBGfWRqm
         +nqA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZdA3GiUQGq+K6GhdRMmb4utoedBCRiglAsFIYoGRMOPVFVFycGVtLRwJrvZYyCbSftBBMYNbsvcZMls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZjyDVxKOmHgtrXItCsEibtOBcvlk4ng4ECSiv500F+W/DJAV
	dqFrPLK8Zb+O6jPt3ANpaa2QJWSUCjZAzy/d00OUuNU7oM2Y/5O+/+CajTTgSw3mhxA=
X-Gm-Gg: ASbGncsxNgxsxeRBbUn1rnud1+uT/VKDlANnG57pYcBYWzLUF1ekMnteXVa7+nJYZkh
	54jTrUxF0pnGjnQpfWzk3znoijFNvUsZIbH/y0vm9YYcjFFDbzixZSP/JfgveqdtaYjUnBDfeFy
	aJvJ2w648L+f78XsmhCSMFUYx3ue85ryRzN5UC5jwYo4S5XwwU0XejnBQJV/sARjxb9/7VXPFxN
	O+XBdGteIlMlyrl6v/ko2T02X9/WnHa9S53VyqsI8zjEZV8fLB/vSYluK7kipfFxwmf2Ky5V+wi
	5MQFUtd2c/y5bPrWSVsqK9HUfTG38wo2dmxWIYzb2j9D9hdFZh3A3Z/0tCRrew6ZpurH9Vs+SA/
	wYdw4wCjVEY78z3HmWrxzWa+A7a1/bcXe1rzHxxqJKX8=
X-Google-Smtp-Source: AGHT+IF4SZA4+gvm+qE0CvIZzsjptGyk828yA5KPOKH5NCsTm42x7LDrAlCkH3FYaw1k6NNDuh4ctA==
X-Received: by 2002:a05:600c:35c1:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-458b69ca289mr446125e9.7.1754067818139;
        Fri, 01 Aug 2025 10:03:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf5638sm71554525e9.4.2025.08.01.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:03:37 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:03:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] misc: pci_endpoint_test: Fix array underflow in
 pci_endpoint_test_ioctl()
Message-ID: <aIzzZ4vc6ZrmM9rI@suswa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
added NO_BAR (-1) to the pci_barno enum which, in practical terms,
changes the enum from an unsigned int to a signed int.  If the user
passes a negative number in pci_endpoint_test_ioctl() then it results in
an array underflow in pci_endpoint_test_bar().

Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Update the commit message to mention the commit which adds the
    NO_BAR.

 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1c156a3f845e..f935175d8bf5 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -937,7 +937,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
-		if (bar > BAR_5)
+		if (bar <= NO_BAR || bar > BAR_5)
 			goto ret;
 		if (is_am654_pci_dev(pdev) && bar == BAR_0)
 			goto ret;
-- 
2.47.2


