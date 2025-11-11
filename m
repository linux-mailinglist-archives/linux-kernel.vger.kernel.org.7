Return-Path: <linux-kernel+bounces-894832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C7C4C317
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA8C534D6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D02D249E;
	Tue, 11 Nov 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frVdmIMX"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064192BEC2B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847647; cv=none; b=ZrwLoYZ1egSB5x3TIAHGX6UTvaLTujbMBX37MuOel0qjFbALuKDrSib17PUWPT3eJsLLHQD2ufFmU0vmSkDKobP9B/KAW6/3kFQZXKGN0t2Siys5fUefXOkS4/CAJfO31fzLRwyGuQu631MmqoQGJofLy3dQcLIyrZSbnN49fGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847647; c=relaxed/simple;
	bh=g/kDw/18tSSWQ9Kx38wjBzsydOcA5Jeo2nfGA2rTHm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1/0Z9TpPIU/rkkU0lIizrZC/FamqsXQ4qJCgHeHYtA7kXo1iPVyqREZ+y4hFkAvE8Sd9WcNbwA8H7jATa6Wx8VlR3V0U33s3JX3ZGW24kt21eK9QxHvTebjYp1xXRYCwp6YBVRyi/yVcA31gO8+UUF9OnqUnRy+rkP3TEQ0Drk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frVdmIMX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b70bee93dc4so531808166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762847644; x=1763452444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWxiFgPWe8+LIkfrDxG2sGu2Ldnu5/l6cTHEY3b2OoU=;
        b=frVdmIMXMrCo7RoRNYrx+DlJM7nLty65lJei6pY50cnVF6MGiLyxDIDQKKM4ZSi9pG
         mOPynX5LIHvs1+cqoBZ1Jld+40u3L2FlZtdtTI/6JdYgZKXZUaUzXn4NJhZaT5kSWn4e
         vLSK1LpydsJkFPbJZvD/76VGgQaVjmjYH6s8WDIz5vmhBQ3Sm6vUWyK4PLeMEoohpTo6
         aq8lVoNcL9Ur/DbHGderoAa3G52gwImiX3yEpRZDLgjpS/sGVcE3nava+uUX8yDD76rd
         zRD7Ea9rZgCpqhhc5XG4kXh0sTWalSao6bFt5Emqw8QNgSJp7nN9TatZ62xjHBcucOSm
         TFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762847644; x=1763452444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWxiFgPWe8+LIkfrDxG2sGu2Ldnu5/l6cTHEY3b2OoU=;
        b=cbObIaw2SB9+nxKa1wbPsO02ioe3jv0DYFjDLka/82f4swLBKVduBIEQ2vbfLd0fW6
         msAmbeQcm5T/ZQFA+cmuaOfphNnBbFUcT0ecXXP7bvoGVEA+u7FS5TwR0KmU/gbN01R/
         Qk9Nkl39FgvPtxaDa/JPHmVffcQagG4HKO7eDKIeWf5sA8ZlB9kBMiNEqbgUU1pTmiAx
         w8ECxVPrOA4mKdpU80q4jKRpAWuMGLoBfKFxBymjhHRaOnp+IDXeaUIX0SELRA9ySLiz
         gX/fEYh++uac35hj8jHUZD0T9MuhM4MP01TaBpmLwXAp8pa4fWjRgttJM2Vz34LYqG9A
         u2sg==
X-Forwarded-Encrypted: i=1; AJvYcCWpr/mmxMbAT7b7bUm4xFUgHTL4CNyIu9zKk3OITp2Km6GaF+hdVJzCeP23zzOVXlhAgkTT06SLGhDUkjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YytNTjh7dJgyCgFFFoPEBElS5jfZRuHBEVa1Re7oPWlUBo8DR82
	4aXZnxSJNOJ5ma2yQuAGs6Xu4BJ5+gSP4XOb9zMC5bRYfGerHGD4pC01
X-Gm-Gg: ASbGnctlhlaLmcWj2jEzhR+zTC+CbtWH1IvFwsAapRWlvNFRVRSWZ5oa7v354qamROf
	iHDM2Do1ntxzYcyHT/CgxLs+DaYL3iN7qI3mJrsK38YyoVeShr071l1L9iuo/P+L6yiqr3LDo5F
	MS06MlyPrIL07XFwJLFmhxw+yzeqAvDHYvHsv6RuQq2PATuA7UyqQToFhIjwhOkHkfVKgHLzRHH
	ijD0HkCSnXXV1mJDVVz+7udrYGMxVtBQ7WHsegG7tOgu2PFggtv9Kr50xEI3Jqp1Pe757HoYVe4
	xNOj4riNq+fKn6ams6Zq2qkmTcN840gtsPJV3pGBV0FpQTt9ubFqwY5nFdwliHEGB6amwE6dag1
	6EYPZ5J1OP2kLjZgGxebsEtDuoK5s2WVbeizBJK+UQMMDTL4dPhuthRNGAB1kHeainBAqLUvEmW
	/T2Mauq7+Yo80AKzTssw==
X-Google-Smtp-Source: AGHT+IHfaFKQwn5jKE5oPvGkP4u89zm7i+TracBV6Z2IqBEl2JimCzYleBpHixC3dk9w9WErI5G3qg==
X-Received: by 2002:a17:906:ee87:b0:b6d:4fe5:ead0 with SMTP id a640c23a62f3a-b72e028a487mr1185169966b.10.1762847643945;
        Mon, 10 Nov 2025 23:54:03 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm1294082566b.41.2025.11.10.23.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:54:03 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] i2c: designware-platdrv: handle reset control deassert error
Date: Tue, 11 Nov 2025 10:53:59 +0300
Message-ID: <20251111075400.2982270-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the error returned by reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Hi,

Resending this patch that seems to have been overlooked.
Thanks for your time.

Previous discussion: https://lore.kernel.org/all/c863512af9a13eb92bde7e0d383d4b4c81e5ce3e.camel@pengutronix.de/T/#t

--
Regards
Artem

 drivers/i2c/busses/i2c-designware-platdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 34d881572351..bfaedb851511 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -240,7 +240,9 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->rst))
 		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to acquire reset\n");
 
-	reset_control_deassert(dev->rst);
+	ret = reset_control_deassert(dev->rst);
+	if (ret)
+		return dev_err_probe(device, ret, "Failed to deassert reset\n");
 
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-- 
2.43.0


