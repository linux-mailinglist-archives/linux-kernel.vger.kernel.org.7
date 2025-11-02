Return-Path: <linux-kernel+bounces-881790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F9C28ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D712D4E4FD9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340762D8DDF;
	Sun,  2 Nov 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/C/C8dR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355F25D209
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084770; cv=none; b=W66I+7TA0UrNeZBGXGdj+XVxNsrgRJ+ju/SX3Vho/VR9kSgROwQ3p1kjvYJSJwyPM2/MKsTXjbQybpinbmVPDQ2HNpVsOwpt3zU6S+2wFlyA/y1RrNV4udWtsCsvN4/pI55X76dnoy5a0FYQjWTr85G3cFuTZ+kLN7b1MgLFaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084770; c=relaxed/simple;
	bh=hpeBzxEihKqcYDLSraTGoETkRiM4IsrmvQC8etRPW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dCCccGr6On6rP6MeME8olpsLoUJqLLOjR7By8+91UT4MoUmxL6YdpSu7krcfv1wXBGFPwy7iag690//O5oNl7UUGOsMB6hKEZH3NQmDe01UuuQGvIxioVHE+seEvKEcml9/mdH0pE50yxElMt9yCuScGU2hvSEfHysgrmy0IsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/C/C8dR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429bccca1e8so1368893f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762084766; x=1762689566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnVbBOQKvp7iEa1IOf5Rt2UqmUysOa/t2FpZVE9J3gU=;
        b=T/C/C8dRW4W6oExi8DR7HFmE1aiP7WzZrToSTaPs/GBSZ9w5YPMs06yg4KzDW0lhij
         NZ2AhS0b2/O9puqFNPireXA60TrFzeXkfxdeya7W6MYZW0C5pS0Frbmzt4czUFY4jvRN
         G/6Yq0hJLd2adyk0AgbSFu8kUQ8sOqJMIIZPXWiTMHgmxQD4OBwjiLrAUIOJ2LVWD6PQ
         PrGvgf+H9sg6u+fKYAlNZceIqZCeBqqWD+9EE9y6KMVuSWLff3/6+3z5iGKXekzu6ihl
         p+ZXonpcjXPAZg+xPk3PEwcLnD7if0ZVaV7YpNxzzlOFgV8szorU5tA3ztfZnDIUgU5b
         Rpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762084766; x=1762689566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OnVbBOQKvp7iEa1IOf5Rt2UqmUysOa/t2FpZVE9J3gU=;
        b=GCeYHHjBWWzqz5XNfAogYjl9znCzCmLcv7MlKoaJcO0wXTXsXiqa8GDAeiwDJsNBc6
         HwHO0lIu4oAEQpipZ/uzTSHWsGw1gccjFWqShl46VGHPQPnAlVyLmwtqNlaHGrXZuXCe
         +XqItcwoFGJn46Ck4OJf8flW4R6Q/bxKyr83YGuMJEh65VW848Yuv923Cijzs0AMVFZu
         6lE2MAnZLoc4wLoeC1gOubWsPfQ+EqPBBeABlPPd5EymnkTznL8QmdKqCkXMPWiKSdC3
         BA9ofoVs5uLgssYB/fUq6pKLkMxW2IiXjdc8sPOiexpobLD44353L86XsMaVjjUgKwjm
         8z0g==
X-Forwarded-Encrypted: i=1; AJvYcCUG4BYTlzrm1yvaagVpxHc+Q0tGss4iLjZ0V8xuAQou6Y6Y/Kc1TWgX6Qj0XWyn60Lha6Fi43wi/s1RfLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcN7Co9beVvOYQsvLizrmZdG3w2HppsbxGgXK1sJ+ndrXCvNBu
	MJ8JyM9hxqBrL22M4/n66wTrpnyzpNZ+WGzJi2ymJk/gy4Tn8fS49N8grvKQEs1nh9E=
X-Gm-Gg: ASbGnctgzr1sWmkCuRxIrwg+sxLyeoBQTStSc6fO+/4cF3wGoW6+/7WVMh+dRj4AaRJ
	NHU33WXSgL1z/bmGaO1vLDWpYugy+UEB9e2DpENs4GMMxcMftlri7qKiEuhQk4/+SprRUUEfDzI
	PD7EeL35rQlgkLamwLrMp7uUs+y5J9DbB6pK2leWIRd/iDwwxKszC/QtfncMyqCrNFTJKAvFD34
	sMCjNT6uoodp3aYp3yYz43qTblZbowOBs2vFOA03Ydw8lUGBdftni+/mIUzGnEr/DbfautrGG+1
	5lsnbdEGspxss7+lTvv2fLeWYuXmOHEpKWHKqhZTK4+TT1jOmXqC2draVXC/JQoWShahpM6bqzY
	WpjusBaOeJkU2MyXFjnkROthK1h7pyf2iLn/o+Evxl8Bmv1+HS1yWZUluwF6FtVnMgg/657Mukp
	yYN2zDq0Rf6c/RWbtx
X-Google-Smtp-Source: AGHT+IFXAmD1Ur8kjRz+0QpWqdWQSLUUmNESuCE++DroKu7wDH1qhIW0Z9BCyFRWINAFWXSCUv0Xwg==
X-Received: by 2002:a05:6000:4382:b0:429:bd09:e7b6 with SMTP id ffacd0b85a97d-429bd67245dmr8378115f8f.10.1762084766143;
        Sun, 02 Nov 2025 03:59:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c1406a45sm13910629f8f.47.2025.11.02.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 03:59:25 -0800 (PST)
Date: Sun, 2 Nov 2025 14:59:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>, linaro-s32@linaro.org,
	NXP S32 Linux Team <s32@nxp.com>
Subject: [PATCH v2] mfd: syscon: return -EPROBE_DEFER if the syscon is not
 found
Message-ID: <aQdHmrchkmOr34r3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These days we can register syscons with of_syscon_register_regmap() so
when we can't find the syscon that probably means it hasn't been
registered yet.  Return -EPROBE_DEFER so the driver will try probing
again.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v2: In v1, I added a property to the syscon yaml file, but those changes
    were not welcomed or required.  The "syscon" compatible means "have
    Linux create a regmap for me" and my property meant the opposite
    so it was kind of pointless.  So don't do that.

    Link to v1.
    https://lore.kernel.org/all/cover.1761753288.git.dan.carpenter@linaro.org/

 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ae71a2710bed..e5d5def594f6 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -183,7 +183,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 		if (create_regmap)
 			syscon = of_syscon_register(np, check_res);
 		else
-			syscon = ERR_PTR(-EINVAL);
+			syscon = ERR_PTR(-EPROBE_DEFER);
 	}
 	mutex_unlock(&syscon_list_lock);
 
-- 
2.51.0


