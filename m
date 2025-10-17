Return-Path: <linux-kernel+bounces-858374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C0BEAA79
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151FF9648DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A024DCF6;
	Fri, 17 Oct 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM0z0+6u"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242A215F7D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717071; cv=none; b=kIIiRul9UYH7dkfuAn6JPiBEx0DReQ2t5xfAgjcjiXJVl1XtZE+p+/GFy3TDadFURNd2DnUelwZSa1WY+7pMMeFs9DmovfGxAsOLmJsPNJh0yYfGHwB8CZHjpFD0cZTO54hj5p/GUCFrHlqN2hPhY8XG4DuhQtV/g+wJRBiEFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717071; c=relaxed/simple;
	bh=/SfKCCgas8Y073ZiKa6F35G3uPziVF59ejNVoSX4/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JTW5gYZVDtwtPxEjRAtJF+E0LtNqWEWnqoxlthrLWW6DC/1S8p4CHeFtFyzYqjyxd/pKIE3qIxedVYGmhTBlcMLI6qJfCwS58gXK3EiSAo8LmcHdhQ7/TpMHTM2d74Iv5tTB78STxc23dnY1P5j7Ud/BDw27dsSNaer9XKsGR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UM0z0+6u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1826037f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760717068; x=1761321868; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XA1CkPbtaxpNOtSPg4ZNDO0+nr3/dCGqWcDsk880cQ=;
        b=UM0z0+6uW7WszkIoYZlG0bEa/Y4lv6+uSd4upghmoECxO0ylsWXwzlzYQA3mML+HIK
         bNc3o1Ki0LsH/tQ7tgafz/L8p7IANUE5aWvk3mHC5v8aQ4QBCM3p3qJOfmJ4H7wFx4MR
         BN7od/D5Gd19zkbHb4CP3cjfVgcgoRg+RKU8IChwKN6WtMu5PP6OauRKlmY30COhVKpt
         XeRy2GKWeWFU53ej2sz0vcV7tcPZgG0uLAtjhZpm15kgbb9UTd/STXOx7m+9VfWChmrq
         mAqopbwhahig4wYZTmrwH2df++DAMd58vVEfq4zUgDtXqiJFx83+/caK1QtETardviKr
         JNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717068; x=1761321868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XA1CkPbtaxpNOtSPg4ZNDO0+nr3/dCGqWcDsk880cQ=;
        b=OdnAPREGUy0nyWABDCgVr+AS4bRK+oHjdYtwXuV/7UAcYchxOEO8e/l10GhTG2/q36
         sV4HcuxWoSiMLB0bwQN4IUTB3ToQ69KmFCXiDUlHveuLax0PwdQeXP8WiKQwzxBNTgp7
         ALN17KerjxDbIBEMccbQZvL/XY/Yx/5I/Ll7GBUcuatQaXtUsYAHYLlpTydimYYLoeb1
         XOwg4zgqxpTYSKWY8UqgDT7RWu4uvtPV63YwZvMmrooaEYKp0iBsACtMxzOSbZ/74PR2
         JDtYUuoRlm/QrCzl2pd4EWs7pQ3jgYjvPPYLPK0zUi1KPKS15VD8+jLMX9VFiNf73rR3
         8S2g==
X-Forwarded-Encrypted: i=1; AJvYcCXOSeJmAnNfZLlxVrPmzq4goSlZKErv2afHMjHqOws/pkx4DxJv28m9EnN3pcwogH3748quMrcDEYythGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtwFvKZyK3PRBGFvr960zst2EuaYiDbSq71OugeeAxNKAFthz
	l0Oh4hSVu8Vcm2Jw2jpNPtDMnyjSzhhkBj1WMZyFPrlFE4VtXwejmdqRb2J8RWUOfR3ZkdQ90s3
	tKxkq
X-Gm-Gg: ASbGncunaHkkuyBqbjugmb7qCgi1Hzvua9AcyUDq/+ML2CMs4Kdfce0ejMudY/AxBEk
	03/SZJUKxpJGekOW7+nd/P252rrVosdMpAg2HUWWv5BT6CS9nmPtRqB2yaW3w0YCthwHwVSRt9V
	3oYsdcpbwXrpAuSbbDHaS5NPI7bX2N5+tmyepNLX/25Gx7sRfWWVfCUR7Ro307MW5DZc0VG9ta6
	eqHHKjrWSodp2p1aM86Vh3rrE+WXzXvXKJPiOhmdT/T5ZrpP26/++E9nYjr4HBN7MNDP71YeHNo
	FZxzJN8eRFW4mZOQTf9RceYxKvmgZWRrlyHRcQ1dthpVEiRy3s0HQJLaI4IoXUNRdAzcMGGwATP
	GSwKHxqem0R8cBxs5HjNDVZch0ZQAE8YjZmtVZUpcHarKsNQKkwk9BwbXlityBi/SMPyK0Rzkbt
	cWW2N0rm2Jxz/Z/ipz
X-Google-Smtp-Source: AGHT+IG35xafSuQ5BPv2Fera9k8oHJR8EziSTLu7op3KCmIHoxM7gv1y6xtU5v4UpxQZ0+clT41dcQ==
X-Received: by 2002:a05:6000:4604:b0:427:6eb:8499 with SMTP id ffacd0b85a97d-42706eb84acmr1802064f8f.24.1760717068025;
        Fri, 17 Oct 2025 09:04:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e8141sm40851309f8f.48.2025.10.17.09.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:04:27 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:04:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, Andrew Davis <afd@ti.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] phy: ti: gmii-sel: Add a sanity check on the phy_id
Message-ID: <aPJpB-QI8FMpFGOk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "phy_id" comes from the device tree so it's going to be correct.
But static checkers sometimes complain when we have an upper bounds
check with no lower bounds check.  Also it's a bit unusual that the
lowest valid number is 1 instead of 0 so adding a check could
potentially help someone.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 50adabb867cb..6cfe2538d15b 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -341,7 +341,7 @@ static struct phy *phy_gmii_sel_of_xlate(struct device *dev,
 	if (priv->soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
 	    args->args_count < 2)
 		return ERR_PTR(-EINVAL);
-	if (phy_id > priv->num_ports)
+	if (phy_id < 1 || phy_id > priv->num_ports)
 		return ERR_PTR(-EINVAL);
 	if (phy_id != priv->if_phys[phy_id - 1].id)
 		return ERR_PTR(-EINVAL);
-- 
2.51.0


