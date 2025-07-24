Return-Path: <linux-kernel+bounces-744636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD140B10F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA67BAC1D36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008C2E8E0C;
	Thu, 24 Jul 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="iBWYiLY/"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CB1DF244
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373336; cv=none; b=s2l+dAqHf21u49jbBMxd93I4dvICmdyqf25Eq05BSDb/Wow2CjeR6Dxh7RORxVvPPpnNytaCg6VmtikccAkpOR1VdqUHa2YFXN5z+hihuLT9RiEvCUe+b8+gg4gvs/oezOWYtCgd8aV5jhZnwfIYigKCGYiQ6hfSEwAPtWjl8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373336; c=relaxed/simple;
	bh=PBtZjclGvWMG1gSoG68HfxNQCP8AO1bqgt1liPtj8Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WrDbWVmwNzXSdGRFoiZZbmSSJGqS2ZyTKbDejMsNSXCNso4rv5BWj/0YjE8SIMKhI+aI+MQ1vkh8KygADZFXcBZ1W8cB3b6g9h8vBz43yyyPxZfuypn+4sWn8EQkNP4QZcfmBZXNm/0tgXmAQiIaypoGK0uv0HoVdiPAkZnzOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=iBWYiLY/; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id A8AB510147F3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:38:43 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in A8AB510147F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753373323; bh=PBtZjclGvWMG1gSoG68HfxNQCP8AO1bqgt1liPtj8Yw=;
	h=Date:From:To:Cc:Subject:From;
	b=iBWYiLY/W/6ZuNiPRi27fx74KBIjT0gON3Vv0Q4u3pU14SpIcmOr6LDWC5bVNiu8o
	 jq25sBZqtcrXlZynUfOdzubyXDOKbmkgYkRAUMzYwQy7tu11WwkJxZlT5/PFPKAx6c
	 +pB6hGdlQGpXFN99NlBtM9FIaPdAy2s93lxukMW4=
Received: (qmail 25085 invoked by uid 510); 24 Jul 2025 21:38:43 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.901129 secs; 24 Jul 2025 21:38:43 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 24 Jul 2025 21:38:39 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id E929F3414E6;
	Thu, 24 Jul 2025 21:38:38 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id B38B91E813B7;
	Thu, 24 Jul 2025 21:38:38 +0530 (IST)
Date: Thu, 24 Jul 2025 21:38:32 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	asrivats@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] drm: panel: orisetech: improve error handling during probe
Message-ID: <aIJagJ/RnhSCtb2t@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use dev_err_probe() helper as directed by core driver model to handle
driver probe error. Use standard helper defined at drivers/base/core.c
to maintain code consistency.

Inspired by,
commit a787e5400a1ce ("driver core: add device probe log helper")

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/gpu/drm/panel/panel-orisetech-ota5601a.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
index fc87f61d4400..e971d1536654 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
@@ -277,11 +277,8 @@ static int ota5601a_probe(struct spi_device *spi)
 		       DRM_MODE_CONNECTOR_DPI);
 
 	err = drm_panel_of_backlight(&panel->drm_panel);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get backlight handle\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Failed to get backlight handle\n");
 
 	drm_panel_add(&panel->drm_panel);
 
-- 
2.34.1


