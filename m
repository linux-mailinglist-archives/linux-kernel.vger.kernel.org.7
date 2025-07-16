Return-Path: <linux-kernel+bounces-734185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8516B07E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E53518936EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895B2D9ED5;
	Wed, 16 Jul 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILw2fl73"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296A2877CD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694714; cv=none; b=uP0vvI/q8EA6gMvUkvLVjCL9Gjiiz70QMUHUSfeDGjLByH/g7F3D1Kes40ByqAGzMJ6VPtROLI3DxjrJw6vRB8InCe16LoYic2OEoYGyUNFDuG9Csn47hpVuUwNMpYa4bz+zZdCsWZF9bLrHa1r7v+OG9WJpmg07eYOL7WLLm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694714; c=relaxed/simple;
	bh=qBZKX2956ukvORxdELqOdgFCeXzBVdKSn4mzJh4Mluw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XdUAqKZvduxD253t7UDARso9VGPeisTTPZHwMB0kIii6YU/ohIGvrMsXHL3PIjteWHUTw7n26exL6cVtJlkmFw6U9Fxg1OGiZ4VBXIbSmTHp7Kvi4v2kKaV9O0LXzf8ozGuf3Ua2EEQ02Jfhgg8cJXoU1tsxBCE4GH2haU7MQW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ILw2fl73; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c27166ab3so179240a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752694712; x=1753299512; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FDBRSUyUWWqwGhcMioNN7CsL8+ZBOGwwYv007xVH3I=;
        b=ILw2fl73KH6qgLrxDttggQz9vvHPxvSPvkWzGnlQc3c2tK83IMRvfjIi0Wa4rMmtRC
         XvJjSTbIR1f/gydT7aOn4TYmSZAjSQ/0tMnGse1T1afFseztxjzdes99ZzEgPVrf34r/
         5pLuMFgPdTWxNhBO+U8AKUUz8ogZtzo+Bp9+hyCMy+i49LapbUl0sKyc8VVzh5IlurmF
         sRIHuuMlCmRUyZbMs1mXiaNV4NZRCQ8N124sHtxkQvG8DbZadG4vA+0Tfcot/yvRfazq
         En8bn8WzLE0Ouo6A35v3kI0C5NcFU1h5sGTt9wdKt2Gt/Pn4MJXPtDnva4e0EN4+V/yC
         mZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752694712; x=1753299512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FDBRSUyUWWqwGhcMioNN7CsL8+ZBOGwwYv007xVH3I=;
        b=V3PMcaVe94L5e2GQrDOm/KCYmzYIYb11I/YHJq2V7dVuWnYw2Frlrps10XDNr6gLds
         pWUUV3rX1ytAW3TLH59XKijdkfR8wdtckJAdRyxStvk75v10jolITsfYJvtwpVn11RbQ
         H8Qltdw4lGcbLWck3K4ei6thZYYmSvTQxyybqWHHopjfbNsZGN151gphHY/v0oezgLS3
         qq8Rp1ulszx+RlR12KqU7CPOf1P/vNbqhPuUqAYybAZO4uaRHzU+ooeaK8yq9kiOCs62
         O1oXxd0/3UIgGETGRxITdJFcIxOQs5s5NUqGgqoJzuZyXjweI1fpXVZk1wIoPIlNhRsH
         ZrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOR4bqS88TmLE1eTtl9OhrKIJrfPKZ/IJ2Fe8PwUgahqrEB0JzD8VCDuRPpGZKRo7kuRy6P0kIAbAMb3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SuzmNvXCMMvvOQVGAAG0nPGvTXaRCKW6ezfZfd1QvBuOHGQU
	YSy4bkVA01wec8pBhrnwJh9XDCFbJdqiQXJi8IhznibbezPCpdaeTD1fRGZ0+/368sc=
X-Gm-Gg: ASbGncvXkBl/DWcgJwQxxXa2aHO/5hefP4NSIa+zCBinodI8MyZHbJwwdML0Fhg1aUe
	svl8CWMGwWybu1sIH5qDEy7TB2osFkmZGPR+GnkjzPRF/pfhMGXdEVS+5+i30lC0pOBZPXkJoSd
	8OA0SBAKPUDalE+xXsGsmJ08Hhr8bjVTL+HNjXtIxVL4sM830OuH6C3po7KRGJRCZ2ZGpwVRtoB
	y+cSbKcE47XiT6rvuuD/QN1JybFRQOdWca5O6H4hgy0y8Yak6fs+JmMSDqfP7e5AhSXWqL5NB2y
	6IgYeXqhFxUz7UE/TvOUi1pdeqiTFybxYuw3qTpz5HlUnzjXfGEVuQf0LtOc7j+t3DXRaprOlDH
	8QJKGHWH8SwyGBP3yMBQJbAK19ihWYHnzB7hSXRyc
X-Google-Smtp-Source: AGHT+IFDI6CVXcKUhCo8LLXFkhb8W7llthuk++X+kRQ27Rn5k1+Mxpsptg2j4SfLdKCLpbJB6uge2w==
X-Received: by 2002:a05:6830:3495:b0:727:3439:5bdf with SMTP id 46e09a7af769-73e665e298amr3267794a34.13.1752694712246;
        Wed, 16 Jul 2025 12:38:32 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf12a4bb8sm3235273a34.45.2025.07.16.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:38:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:38:30 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] coresight: Fix a NULL vs IS_ERR() bug in probe
Message-ID: <7bd9fae8-a15f-412a-8800-ce47acf0b5ce@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap_resource() function returns error pointers on error.
It never returns NULL.  Update the error checking to match.

Fixes: 26e20622a8ae ("coresight: add coresight Trace Network On Chip driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tnoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index 0e4164707eea..d542df46ea39 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -183,8 +183,8 @@ static int trace_noc_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_set_drvdata(dev, drvdata);
 
 	drvdata->base = devm_ioremap_resource(dev, &adev->res);
-	if (!drvdata->base)
-		return -ENOMEM;
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
 	spin_lock_init(&drvdata->spinlock);
 
-- 
2.47.2


