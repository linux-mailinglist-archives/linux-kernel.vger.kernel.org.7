Return-Path: <linux-kernel+bounces-870942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C1C0C0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9E33B9DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678702DC34B;
	Mon, 27 Oct 2025 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwQIx+zL"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F32D9EF2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548940; cv=none; b=kfK4jKRjviH2WRyz5bqr8NuadM6dPigTMsmxk98BntzfPNaQbcD9sHwl4Eh2M2HGQEcQpWDghJL/C+4xlNxjF+N14YHbxZYfv+JguJpwxeNYAKXyh0slyKsthxd2qEcec0J2fSBkCDNyyXfOQPEDkOj0aD4ITI56qPd+FhdrVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548940; c=relaxed/simple;
	bh=HQvYDUNf198EKKAxVvh+ZSxI78/Ij69G0JiG7PtT5fU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QQI9feHWWdZ9fpimJqHCG28rXFBmEPP4H7gFruF/X8POFl/yS/317N46xflZ+I72t74Y69KX4XGTa04Yhywol2cQcjJv5U/YERdJnd1+STIraTSVl6gB6uBGa+XBHYDBB5G/7YWaUyn8nuCAsON7oon9R3dVkyEFGfksvQD9COw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PwQIx+zL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427091cd4fdso2439312f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761548936; x=1762153736; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VCn7I67W0lot093gUV4e8FUZ2HcsegXwgZoOoSOv7c=;
        b=PwQIx+zLauUHHEW8zaqrUsBUrTClf76jPTZtESzTKlGd6SmI/lyTRiWjV2aq3XKLt1
         2e7HGVUgC0PA3jC4M57VHP5eMsac2tYnF2mbEkIQS+CN8H6Evhu/db3eYOEaK1pZX+Nt
         Q2LoEgS4uSMYYQqBCyfjdjKP2qdeiCip/s3jQFLKOKeZNGSvBu0f9r9DPtfypLbOxp8k
         zs2K0U/DIxoetHY+/1B3jsN4anL/+kf1wEx7E7vl5I/uA4xXEfbvhkzMB/qmMFIT1tH/
         Tizc9iafVA9a/QAsbkTCxMmyKP85rO5AGKvjAAQKmT75q9Z52DAmxHhTs1S8Xjw4NzYq
         LuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761548936; x=1762153736;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VCn7I67W0lot093gUV4e8FUZ2HcsegXwgZoOoSOv7c=;
        b=dY1TYkIpCVdKk0Yx0bd92SdKlYj/WS5+TyZEl+sb4u3SZ/bBscQksRv5il6V7ke3eC
         u62gH4/orU+Bp00o1lUu1NsITb3YyU23q7ChDQbDZnkpqQTpgkhBcmRe7xBD4Y6ucuCI
         uRq0IIDQGUDZAoLuvWhpcmnfsDqNcRPjYoYCT/WBGx6RL85V5ClBJEX9NRi0+5nj7GYP
         fh1zURlSrD/CaXvg3nMLRhaoNELhxaZmDwwSAHDxin67/ZdIPEHD9tEatJc5vO6gRNjG
         SUpOUnDevZMxyzLDdRD8uK5wQU07IX9S8gaPn7C57L6Er0zWUNc/RVbhDNRll6SiFL2n
         MaIg==
X-Forwarded-Encrypted: i=1; AJvYcCWCQZBD6vRgypLapW9Z8PwA1zpCDCBaZqzINVxrOgqclZqm+sb7WMIPf6vwSIm5Agce5bhzJKFRQcCeRy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcH1FITK5PEBWCQryOtwrok1gYMVOQ5m2IlSqFSZPPEL/uWqGJ
	MRGS2ueoYx875EF6i4ZFOYliiMb1wDxjmuJ2DJae4vAM7ROUN+wVO2WqVl7BuVw39TM=
X-Gm-Gg: ASbGnctWqU1U4kQlyg16wvoU25C/UtHolw58lZgWS0gADD0szOyI77KN/bnhkUieiYG
	/U+q/OdG0lJCV7z9V/sOB2vlygLKATjShrQCngQ1gbOiHW10s9S+kWyZw/3PXJ2NUzoq80siv7o
	eJ+d5gAJ+JadcuDn0ydVKi6CP8mgAsR6gyLApZeqE8uya5FSP3gnKEUgnG1YtZoNGw92QfSmD12
	FuzkxY7CwLvpLPN+53rCnbYkiAAPzWkvP4kHevCxrVrktt4an4zcRMJ4rVIPbafhWi5J0P9F2yZ
	qQXZ6YPMehtyDef5Fs1D6t9D9K7uOluJTEPFZheANddzOyeslh8P9wHuNSYw9oszjkI3OPcmBYY
	aO29EqvyPn4TOhmgwZPneNlFH2ZOcUNs3ZSTymUC2gu0xZ+OTHbFlGqadi1lVgsfo60PYHVhvaE
	Uwi4uEd2DQ+ABi9M5l
X-Google-Smtp-Source: AGHT+IGoQx8B5H77NlYFS00H5yXNOz5JUZs/694lcXu0yPBw3rKGoC7GgPX+DZXHN83AY89E6HX4rA==
X-Received: by 2002:a5d:5f82:0:b0:3ec:db87:e8fa with SMTP id ffacd0b85a97d-42704d768b6mr25913703f8f.26.1761548935732;
        Mon, 27 Oct 2025 00:08:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952e3201sm12634747f8f.47.2025.10.27.00.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 00:08:55 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:08:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] remoteproc: mtk_scp: change the snprintf() checking
Message-ID: <aP8agyKj73bLZrTQ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The snprintf() calls here work but they have several minor style issues:

1) It uses ARRAY_SIZE() which is the number of elements in an array.
   Since were talking about char that works, but it's more common to
   use sizeof() which is the number of bytes.
2) The printf format is "%1d".  The "1" ensures we always print at
   least 1 character but since numbers all have at least 1 digit this
   can be removed.
3) The kernel implementation of snprintf() cannot return negative error
   codes.  Also these particular calls to snprintf() can't return zero
   and the code to handle that zero return is sort of questionable.
4) In the current kernel the only "core_id" we print is "0" but if it
   was more than 9 then the output would be truncated so GCC complains.
   Add an "a >= sizeof(scp_fw_file)" check for output which is too long.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: The v1 introduced a W=1 warning because of the truncation issue.
    It's a false positive because GCC assumes that "core_id" can be
    every possible value of int but actually it can only be zero.  And
    also generally, in the kernel, truncating is fine and it is fine
    here too.

    But let's use that as an opportunity to do more cleanups.

 drivers/remoteproc/mtk_scp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 10e3f9eb8cd2..db8fd045468d 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1127,11 +1127,11 @@ static const char *scp_get_default_fw_path(struct device *dev, int core_id)
 		return ERR_PTR(-EINVAL);
 
 	if (core_id >= 0)
-		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);
+		ret = snprintf(scp_fw_file, sizeof(scp_fw_file), "scp_c%d", core_id);
 	else
-		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
-	if (ret <= 0)
-		return ERR_PTR(ret);
+		ret = snprintf(scp_fw_file, sizeof(scp_fw_file), "scp");
+	if (ret >= sizeof(scp_fw_file))
+		return ERR_PTR(-ENAMETOOLONG);
 
 	/* Not using strchr here, as strlen of a const gets optimized by compiler */
 	soc = &compatible[strlen("mediatek,")];
-- 
2.51.0


