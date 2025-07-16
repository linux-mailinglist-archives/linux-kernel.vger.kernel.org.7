Return-Path: <linux-kernel+bounces-734252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DBB07EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECFE16EEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB42D46AD;
	Wed, 16 Jul 2025 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YWG6DjvT"
Received: from sonic311-21.consmr.mail.sg3.yahoo.com (sonic311-21.consmr.mail.sg3.yahoo.com [106.10.244.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFFC2D1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698044; cv=none; b=sr+f7/rAtFnt5dbReZNtXf5WRmigb3Gsui82Pe/3KN6wMmm9yZ77vFRI/MoFRk0hyWvxXjBWkoLsZus90pSytOlsqapff4R/jcbzTRZu/EWs5EtCWCVMDqwo7UxFHRrDcixIr+X4xwaXkK6mT+F8mWMyBXD38u1mbZH2o/HeHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698044; c=relaxed/simple;
	bh=Jjf04ylop5U+a10qGcMbcucN7XqJczKEFJI/DCJMJzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=UoU6WdjnYhxwPW3z3Fjvt+xBolDlxrmt2EOVZrqyQZ5NdDIT8oAClqdNl+1gu8BPvD03fEfRZoxCNq3qUD3UqJwvKEess2xbrlLRZwMSDCs7SfQ6ap4w5K7QcnG2AuvMDRGkQkkGqliCdZ2zNLpGRXz2A5eb6fzELkX9Rb6A7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YWG6DjvT; arc=none smtp.client-ip=106.10.244.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752698040; bh=OEFAEz/+4pDWbItrpxD27vn6vT/LAF+wBo7eq5wNL80=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=YWG6DjvT/3sFFL3KUxzYICZxccRno+LnLMGa6wJ8APt5i7Ty8XOnnFEezImNdhGNo1/kwVzf58ZkSs+EiQtrllF7MqYoSfKg2huL0eo71W1bxeDtG6yOdIOs3QduwZVYqW2vEkY1a5hGoGVRAENllNdHt1dGR3PnXnWD4O/DX2jaWx6tTTt9po32SCNCDSgIwupgiGFM80hAyezpU9LQmNQPf6EYT7IHlzYqY7DBbKE+eYqKzB7uXL5WiSuACFCRA6pFA8ab3n0HzwuNhtz5w0ubSWag+7KHNjZF1ikQ3xWm6BnQKRaaqwnfC5fQSb/Oz09xQIysxV8PDAdyg0tYoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752698040; bh=I532PsxnaV4K59AH6BLihScDenRymPD7UtfulPjDnRi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rTFVdjVzceJHTyteBIdla86mQYhu4ai6wa8dPDfXxUjVJf8mERYV9iZ3LadIHmdIk5rcWME72GN8TvctPagyuHIXCY82qT8l8V9hkOur/QLuMZujggz5PrMMzS0WkcQS0YZuiklSK16/FUp5gOnbHI/JCCRwiSEo7XQq/F165wpc0STY/5UH/WEWqtxDCBKmn5otNkLN7J87utYM3XXQng/2Q5yAtLUVuq9+qvafjUuwLXwbJKnOc9gkfYDNNKyBu14F5c7Iv8z7zhC/VNjBiWjSkU3OmVm3MoF5uiOO3vF7rJ5lj5x3NmAGdr0j2eRV5Mtue+rtz+JtcL2po0lq9g==
X-YMail-OSG: 2opWEMUVM1lGbozH9.hAxN5SVx9WbZd2n1tFDDlQ3Jxk_jcHvK5kVqRdVbJ.Ium
 QlRQw0NZzzxMuv_XW666t5DUfzxJdei2vePfUxGSRc3Gpt.YxZgwvsFIXKzDjOhX.XVQmb74.T1e
 Dfvx5np9yDNurpvyIZxKUhzGKz_i0ICYVnEfOlXWq3AvwWP57csK_JJdcqGjmkGp5XSlsH9US6uN
 U90_2WPuBjleeomGhWPTz70Gq8wfbCDLO8NCoPYtZFb0u.n15pXJKc9kbe84cisyT1umZK.x9JfB
 jxzRdwG59BnzQCRoydEG9KQZKzamBPMzsnmPcb2aqoWQ6IU0cBZsizWZemm.cJpCThYswWvfacd0
 3Xi5_6em3tcs6_gDfxeHW7f7yAObEieyFz3.fA4rbCmTxBbOtlD4zJmLUaXFRSfRhLlD7UeikfOv
 U4G5ydPD4HrIksJXtufxT5hWUY.Gr8HraFWq8JjcwK_364LBzMdNpvBEwp_uL9E8R0YdCkIoZHlO
 Q6_y7BTowpMKqX8nPKNFga0GD9sOz90FzZqe8ol8AoFl8fHeDMr2g9MLtkgwXxHFeTYIp1Ah7fIH
 Yc8ATyFs8YkJ.8cHjmA3IYSXmtpzwMosP4nDWsOiHmG7MXLArbzeyh1JGAHsJiTDfqMRVUQrbrzr
 abRGnfqnjGDgPzfXgXhruICTAlxaMjRmbQNAa94tOHFo8dAMoEg1ZfLmPS46hMD3N0Zz54DiLdY.
 aIiGLILc63IstVThBn1NPMvrEy_p4AOAc8PxgeZAC30x5.XNjGzxa1bgkRlT54GPDtTVFGwKZw5K
 q3l8eLyapv1zgw6kkDWjcdRzfRLoSf7TJRIl_Lg.y9e7BVN0qhmlEQDl8tQBVf61NgzW577I0wx4
 ljd_kt0_ldJh5PHUdnsWoXt2838Pn1Pk_FWt74ibelWb3qQMADGQlbA_IqSY0a.q1PB4PyRciY0W
 R.w2e5ahAKoxhyPlOURgDa_UFE5lFjn8yPbgVnqlcbI.wl00noswOlRyhFGYojOy0yj.IMre.kc4
 .86KNKJIYAqZJ.13iVfkbGaiCWpFriGubBgL.D.Q3ziLo66wbV5E6BmGgMRp_JtNzianQVtGa2TH
 vtI.eoEjJkC.ips1jTfvMB3fhk5lRHmjGWrGWSxlsAgI8vfv4HEnjpwylbGZ4p70ELT8IXfS1FC6
 fUlmBmd95WswQzhlbT00BW.sVNlzKrDYGFuChLu7OLqNaPO_8FV5crS.Jqtz45d.OIz68PvcVcyO
 8HD1V6uNL.EW6vQxMc3qSHxDE9wd80FoGk6Xf48pvvEfUbhbjITG0NebDF7.MbFvIMdPqO02wmYZ
 z4F5ZQj.XHa5d8BSzNs3s04jyN7fv51bPJunltF3UHZ.4k4UCG4GylMm3FD.Zxt0p9nSf7Z_Xeh6
 p2_Kheaea1S9FwlyrROLiAG_.ZP2vplU19hPAEIbKTHGv2d5ygikzOMHXDBJq0uSC6DelrSefiH2
 1a9O004SUXCluG2cAs5jFkLYomtyZxALjbP7bYLj2L.lxWMT56NZ0kzDvLfYclfeoxT1XuYNKJcm
 _7K3b.u2UMvpqHFg0Q6TljvbKEZYuCGGQZD7LsQZ6ll9BETaW2G3s8Ompx317v4zjltwFIGF3r_j
 PerJPVThjkYFsBj2ObCCf9K9v4aPpC9qAiBs4CnJJyZA7aZHrrD__R6NB31yf7eD.rotaBQSzYlL
 CjHEFuStT53Z1V7dTKBL0A7V3CBRnbpDNLyr.Y_UimuY9W7bmbneMLD3QB8e.1yxJyqyq.Li1jQo
 _ZPqNH5ZAG.bceg9aUKKuK4uKtBRTXn1Fn1fta0YGm6twnDFemNKOhsOhrix_URoZjZFq0EJOTJl
 hB5VGbLuclrdLBORGznh.4huJu2L5PlqI3cZbOsJJ.jMakNKEKrt4M3_Obxwmx7R0NbTkvB_V5uV
 RWDPMKtYEDM1vM5.YuDiufmaCWgNmicbUjiEmr0sqf2Dma0kbeG0pjN7v5A8zgkdZxvJDb9PhGge
 8uBp9bktKcnhmjrGfL83xc7qDdPCJTkuYB59xb_A2m6HApq.nuuaQ0ww4on7Ihy_qhvOMJN1Qpvy
 gwknbQ7QTmsrMbhHHIWnFd3vLLAFK0o0OzChndJznrHO3T1Jn_sr6fsIZdOMnuWNIEDW7IJB.haG
 e2HQqUxuxfQt8iGW7nMIIYgDsBGEFyI_shWjq22V4ZNxwnngZZR9gqxhVsMayhfMcOApOwRlD_Fz
 69cVFszy3XEJ30.iGJBJATLCa7qN94yebmWztdoBTznR501ST4wDGsH.H5V9jpzlk.E49TZS8iSV
 BNvRqnzoo1tg-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 4685dbdc-3e7a-486d-bc86-377fa78c6e34
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.sg3.yahoo.com with HTTP; Wed, 16 Jul 2025 20:34:00 +0000
Received: by hermes--production-ne1-9495dc4d7-dbtfw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8c52d90f4f34e062d1d4f8f556dd2c9;
          Wed, 16 Jul 2025 19:53:22 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	gupt21@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	stable@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 6.1] HID: mcp2221: Set driver data before I2C adapter add
Date: Wed, 16 Jul 2025 14:53:13 -0500
Message-ID: <20250716195316.176786-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250716195316.176786-1-sumanth.gavini.ref@yahoo.com>

The process of adding an I2C adapter can invoke I2C accesses on that new
adapter (see i2c_detect()).

Ensure we have set the adapter's driver data to avoid null pointer
dereferences in the xfer functions during the adapter add.

This has been noted in the past and the same fix proposed but not
completed. See:
https://lore.kernel.org/lkml/ef597e73-ed71-168e-52af-0d19b03734ac@vigem.de/

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index de52e9f7bb8c..9973545c1c4b 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -873,12 +873,12 @@ static int mcp2221_probe(struct hid_device *hdev,
 			"MCP2221 usb-i2c bridge on hidraw%d",
 			((struct hidraw *)hdev->hidraw)->minor);
 
+	i2c_set_adapdata(&mcp->adapter, mcp);
 	ret = i2c_add_adapter(&mcp->adapter);
 	if (ret) {
 		hid_err(hdev, "can't add usb-i2c adapter: %d\n", ret);
 		goto err_i2c;
 	}
-	i2c_set_adapdata(&mcp->adapter, mcp);
 
 	/* Setup GPIO chip */
 	mcp->gc = devm_kzalloc(&hdev->dev, sizeof(*mcp->gc), GFP_KERNEL);
-- 
2.43.0


