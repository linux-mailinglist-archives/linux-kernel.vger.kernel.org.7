Return-Path: <linux-kernel+bounces-832523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7BB9F91F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A66C3B50D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCFF2397AA;
	Thu, 25 Sep 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfMZnx4P"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55DB1946DA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806901; cv=none; b=dvHSg5ME2gr08GxNclE0Q16HM+R6+udsARRrfyEC6log2FEmDcIpaMvNqsHGA6jyf6hNKNOFXjGnv/lBsylnF9r/wfEoB2iJDiTA0poAF1KHjqnsq6QK3XJYFwCoUN+nR1MpYg7yGy5JfdgorPeD1QRumPw5yL0tdRPXcNf4Lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806901; c=relaxed/simple;
	bh=flAw5KKjXu42FlukgIcjdTtfBFEAB68+Z4z5lvAgfpE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eYAKipqwRlAzT+1cvikNefAQ/o0Oaj/Mv3cEycSSZqEQVjUfOEipo34SFeZ0PgR4zz+X2Hl/fCoVbB4C332vc7ZzhSEGsWgMtHtp3uJqgOr7GhLf3QsXUPXO9f8j8oWEAjc6YFBQXvmjgZcxU4STTNN+7Xs4gt7SRxWQEhMUGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kfMZnx4P; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so1178334f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806897; x=1759411697; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhZs0QbdJYRw6FSQz/b2p4quCXTn98S2BMBiWzLFh48=;
        b=kfMZnx4P99A4TvCSgt8C9naZK1lYcSYm8N3ZkFkGs9Nfi7o+r4PYy8N8/syHwh7h+z
         Qi8xFpGiqi0YcSRnUUmKFFBqxaNKdwxN6/fSTqXgaMyq3OxmQXlYb21BvHVD/hcc62al
         VZJwglDUcBq5LsgXRTt8U/4BY6dj7Mo5CYc9reOHSoPZDIvXeISQHW5rgwssPdM0l4ys
         U6N6hGPSxY1S/KaPDJCmq+88MvT8oVsjOUpMf4BRKAXau6dnI/qI9alfL7nNJD3+Kifw
         I5/Tb0NOfa0SOI2BEKkG3ttfD2tAKXAXbZfL2dKLmwH24hiwLIexeLWtQoD1QAPMkFVF
         Hfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806897; x=1759411697;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhZs0QbdJYRw6FSQz/b2p4quCXTn98S2BMBiWzLFh48=;
        b=pYh6OmTd6c6l/vxMR2/20L28pDPB+14rNtzgJcD3MDhKmd6Tw9iMo/S8AMs4tf/Q17
         bLWO/ZtwftcttK/qV4iE5aiN2Z5jyZdctg9pS0uhaJjoEYNYIVyvzo2H7ye3IAU5kTio
         b3+4Wtlb1iQSxb/oP6DGGqRXxHcwvpKxIbbH+3EKs6RLwcDLIdebyx9Tl2g7GTJzb5x9
         6VW1rjvl8jmXuAGMCJkjw7a1X0NQPllkvkSsjoymMwivJNvSSQl1c9MLrpPMEdRIaKkZ
         CVF7V8cEVJb/VOgDa7hvw532LrflaKFBiSp7/PL6b05Qu7738k0MWYFtHBupTYj4Oo7M
         VevQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzz0whkTAJUZRAo7u/JWha5smJ/0f6auGczj7U/eL5koj1aozA7A040aQ34WnPUmZ65Uw09yb4kzQej8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzJmkVNBLA6zXejvvY7ECk5Md1mxY7Fuev40Un5Niowr6+Pxm
	CkaFf6HLtgNWQxtwejFhJYHJ8FTjoXFCqYmfHNH/IHzsOQiei/csTECvD7fqBeVRX1g=
X-Gm-Gg: ASbGncvo63+YTZRLV2X2kF3dg4kvJGGHKsStCCRmE1UM9HD4fV21/7wm2d2vroMUJEs
	a9qx29VzG9QFKE/c86KtHGRxlYgulJADh+rYhSlx1UP+xcTSNJcpjqtk7mMdvjkXY29CWWL4MuP
	QQJ514jICfKh0VIL2RtOSCxlkQ09c86vncpzJkjXhiKRDu3wYImuBioeMpoGVvDs0cQrhLygamF
	LY8fczb7jFIhohRyi2lXzXnUojZEeZIf/VkeWWRZaYGVrxCE7oXkjh/3P1IKWIGWZlzRi1/IhN0
	1vNbMlYcOcMHpt6HUvk9tNKbn0RZMtY22IUFx6H/YMcWygcVdr5NOOgtJIo5UoimLTeCrqPB3G1
	bUgVOF58HdXJWs2fKHKxqJg9N0TiF
X-Google-Smtp-Source: AGHT+IE8huo9gSXYF3zbdT3uLvSy0gSrDiXlprLcEpyFX1ppWGNriITL3c4SgFMXRwSFCbcgfglmbg==
X-Received: by 2002:a5d:64e8:0:b0:3ff:17ac:a34b with SMTP id ffacd0b85a97d-40e499acbf7mr3135758f8f.42.1758806897199;
        Thu, 25 Sep 2025 06:28:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc7e2c6b3sm3257259f8f.54.2025.09.25.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:28:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <aNVDbcIQq4RmU_fl@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free() and
the caller, zl3073x_devlink_flash_update(), also calls that same free
function so it leads to a double free.  Delete the extra free.

Fixes: a1e891fe4ae8 ("dpll: zl3073x: Implement devlink flash callback")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
---
v2: Fix the commit message.  Words in wrong order == nonsense.

 drivers/dpll/zl3073x/devlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index f55d5309d4f9..ccc22332b346 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -167,7 +167,6 @@ zl3073x_devlink_flash_prepare(struct zl3073x_dev *zldev,
 		zl3073x_devlink_flash_notify(zldev,
 					     "Utility is missing in firmware",
 					     NULL, 0, 0);
-		zl3073x_fw_free(zlfw);
 		return -ENOEXEC;
 	}
 
-- 
2.51.0

