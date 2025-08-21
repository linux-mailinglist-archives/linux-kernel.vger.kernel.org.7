Return-Path: <linux-kernel+bounces-779745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA982B2F812
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE621CC37ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A538B19E97B;
	Thu, 21 Aug 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlJCwPyH"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BE19D8A7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779577; cv=none; b=jUeoMYjE4Y9RjxmRm/VwLMwy921WCNCt6TRRu7nsjrBhfXVF3K5/qwyOQwj66fjY5G4HsAKSpyJzFf2fG2bmXSlmdhLasFrcOdDMuAuka9NnO0eKxNp+1pZ8JP4UT7Avqq5lieqnp0wXdyW9ujcxD6m7ArNYjaDFv3B/qa9Vrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779577; c=relaxed/simple;
	bh=ocQ3d5j9vIq4dGBBuOr8WswQdXME9A/E4gyt+hUQqp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fl2LPm+k3ET6HbZvYqsEFP32KX7SdVMHL625aA0qrwd53rp3MM5XF882EwjSC8d/LrAHfHmO2ofVP7wa7lBo6SrVL3t/YerHl8RPpPUm5y7I6OZsJgBvzDtFwSNm0/4y1ExxZVroCEW/FR16TKZl6FfMlrR8vwlFPMct72eotQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LlJCwPyH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3bea24519c0so991983f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755779574; x=1756384374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdIRAKr2cN8G91t8BLxjz7Gzji0/85KCNwhJJjiYkCg=;
        b=LlJCwPyH7wQd7hGdjBPPo9QpbeOqt6GOUinJqkXNvJrdyvYw+tzGITSaJy+a2cURXP
         OuXCCFUh9SXzjyjv3ky9IY/HFZlVj2tPyWQ4uuFZgCry/Al31k8WTAY/lAUPJO9W1Kvo
         tX/pgcycrK0qmi9bgAbjSwsWTMHZLF1VKuOA7NYh3GvzmPGe3yYhlLG7rKWdOdrkapLW
         aJaokVdsat/5G25fiZyfZHBPPBF5FL18tb7UGokIzj8hTbYQCD8cVlOR9cwkI4HBqV5U
         pqBn81D7s2PeU0W2GNBw9HC+YbQ+vZJza9IT5bq53I7FHeLSJa7+UghKqAC2lmZs2kqv
         EhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779574; x=1756384374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdIRAKr2cN8G91t8BLxjz7Gzji0/85KCNwhJJjiYkCg=;
        b=E3MX+O3Cu/wS7HiNphqcvU0QVa6xh6cFCVH5NR4bd6Ksp+U9wQ0+2WoD804X3ogm1t
         yyCGjbikLjss6WAenM2ZqMcEvI2hOp15LqV+8KqLN/UgjNP/ekyzQN4FecWYTDNoubcf
         tCzJBNCqP2gFhoTXq/aUGwmeuTXwGzcGKXwmzQyzNB8xLcceOr1rpPIzt2AKqaIo734c
         mMASfwu13IcGkqSBe1DoWqk9tsXnmdpiBLsbMNpa0ttrF3WJDOT28K9ZE3HZVw8fQujt
         oRDYL5Rn4aUme+g216E9OLXS+hZ0nq+Bgt6leiTNBS7VsaLJnDpcwXQxgZ3tyMG//+rx
         Errw==
X-Forwarded-Encrypted: i=1; AJvYcCVNSvMfRT1F0lqMZUO4Ycv701DMBbKS7aKVyn7dHruycjq/s1+UsCtexzhXwESpnW8lwIuzLdGrT3gG4oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGo0eSSKwrymNG4X1ijf/0cSXxWibOeksO1v5dv/3g5zh+Eao
	YqDHpzT6SWXwJ+Maly3xE07gFRz96bI4vMzzzuw8Du1Oeu79fY3UEDJYmY5myRPK4iM=
X-Gm-Gg: ASbGnctba57jrNFQYfvgsukhVxabRPWvJi7gj/2Muh4evZSHP9XACBMqQgqDElejLDT
	c99Pu0BxHcEJYcZSY4i2/pGt80iE4PmDsmlXcIO6XzgfjHAJKFsZn2lbFe9Qd+MCOdUjSkNWHfi
	eR7yupmlRg16ZZEFYUIQmwIJ4Hr+yZdHUkn/ZhbjCxOQy361qbwcsssUM1x2KBzsQRI3wW0NWk3
	YJNU4a03B3oHF5a3PzFXIwP1tvV76cUT10+aBui/+lAX0FoQrVrTFwzf694lRR1gJAiGAnuj5Sp
	NRzUKJkmU0DRUFhyagZZZu0zvKT28Go9JpQZ/+JcmfeGcX+YITqB0tYCXsrfp6IML/tNwZp3C4S
	5tgqHfehMY8Kvn0wwhgdVpZ0kQMfSAfzUC037VQ==
X-Google-Smtp-Source: AGHT+IGLOFZokM+L1YFBETmJ+c1HGUrKFAr5zBcd3i6pzbkvpmwIxEYCoRLXatleLwvbvzJVH4ODSg==
X-Received: by 2002:adf:9b97:0:b0:3b7:94ad:ef50 with SMTP id ffacd0b85a97d-3c4b4256c02mr1669280f8f.2.1755779573600;
        Thu, 21 Aug 2025 05:32:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077788df7sm11530384f8f.48.2025.08.21.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:32:53 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:32:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricky Wu <ricky_wu@realtek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Avri Altman <avri.altman@sandisk.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: rtsx_usb_sdmmc: Fix uninitialized variable issue
Message-ID: <aKcR8QD81TjVqIhl@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If rtsx_usb_get_card_status() fails then "val" isn't initialized.
Move the use of "val" until after the error checking.

Fixes: d2e6fb2c31a0 ("misc: rtsx: usb card reader: add OCP support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index e1ed39c657c3..70bd21084b97 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -785,13 +785,13 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 
 	mutex_unlock(&ucr->dev_mutex);
 
-	/* get OCP status */
-	host->ocp_stat = (val >> 4) & 0x03;
-
 	/* Treat failed detection as non-exist */
 	if (err)
 		goto no_card;
 
+	/* get OCP status */
+	host->ocp_stat = (val >> 4) & 0x03;
+
 	if (val & SD_CD) {
 		host->card_exist = true;
 		return 1;
-- 
2.47.2


