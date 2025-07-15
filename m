Return-Path: <linux-kernel+bounces-732618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74941B06994
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A487AD46B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215B02D3732;
	Tue, 15 Jul 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKPEwoBd"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201B2C324F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620388; cv=none; b=s55OHwflJh6q5wE8walRSG50Ni+TuKL0R3qbelYQ6fkrPa5zbukpQh9j1LenIqp99KGQ0YAYi1f+e32TNQ6fBv2OJC0Je9+Xj9dmW9DMIEV+oqXJQnFM+Yls7MJFlkR8GGVeKjzPdQA2Dga0BF4EhhhOLFHB4llJnkpyXR0vdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620388; c=relaxed/simple;
	bh=ZW+wto4d4xM8WCNkguom32Y0IH7jAjN9Rw7cTLBj1l0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ac/McIUtfD0zglFVz1LRW5QeYLM3733yOyCjZa/gog/mPMzJVquMmUSSwXw/U3G4Kj4quib31Xz+ixUy98Hn+X6G4KupS0X2e5DObqFVPyWRhu/q5SkR8CVepzvdaFdHmv78ubtBHpR5I951V19Q3cmuc1+pH6ka3ZOjXfJamHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jKPEwoBd; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e57de73b8so211051a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620386; x=1753225186; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFDftDinGJeWeNvMt3z+fTzSOMnuJXF888WFq+QttdM=;
        b=jKPEwoBd29unWcHKre1NeVr4NF+frN5o3/wJvS2q5MmwmJlcigrPm/iTu9AE70RB2l
         UtKNdjWkDGpGLZ+aqlJ+6HZOfRyC1pgeHki6M55H7b1/f9q5U1vkxZaVlJB804EcxIZn
         K24ok7DDbt6nHyXMd6JNkpXnIsU+I0rer2tCvTxeFblZ+PIq4JZaLZiJwb4cZb3+eN1m
         /x2RWSJUTAtQvyyzuMMHFEKJcGgCxMhQGrd1zRMi6V6LIXj9H02IZBinTsqOc4wwvpfH
         twgizSDnVswRU2hYLtYB9b2dEXICUlKBRn2QwaC2p9rJEQqYvKXnLdp4ci7T06hBw9Mr
         XkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620386; x=1753225186;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFDftDinGJeWeNvMt3z+fTzSOMnuJXF888WFq+QttdM=;
        b=ga088wwEvCdMn+s5CdLnRrkIqDxKJT1vv2ENHVX+Kv32Pw8ZqSXTJCG2QJeb2wSH/O
         gjgtG1J5U1HyeJ29DahFFeZ3b48V1aPPNS/7HVIOUQmfqPypioyV8xylwLGobgK3yZhD
         uQ05Icx2RojLnLp/om8cy7lFAvbqVKWMgRHHLVmTbzXv0jznAqwOSeuRtwdF1GsNsSTR
         RHd/ejozykSWZmuj8vFCdp6Op3kVK5gL2LvIreGLgU3mBZPKPPZD0u6kI/7FeGLYq2qW
         xkllpxJ+srtaFse1bhJriK1kmUvbesA5TS+xLiR+Slpy6J7/MVjLuvZD9nFIN5axRmyw
         TZww==
X-Forwarded-Encrypted: i=1; AJvYcCWUkIOcr3RM8Z8WgSOz09l6E8CYlQ5XficQeybA+ZAMkREtimXkEXRoP8AYpt0c3yg1SxnONjuzO84yZiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHWyAYU/0jmNfuDpLvS4MvKRPLj718tzfG0NeSfl/uNxzDoLf
	QSTnIlr6epPXAujfrN2ZAYxUa1OO7xPgTL/4Qm3ef2CN/Cmsc6TUvKP2tx8rUwFnMuU=
X-Gm-Gg: ASbGncuOkTC1NUq75BWob8YjlmVqROD3VJ0Tt7mEgdcL5N82ZfRQnfwoSDjN21Q1BY4
	8S9do6V/g0XMBxqoqdFuXCpR3P9JDDNgXEfS6QjLaGW3dIyCklUt26qdAvgxSb4rP9zobzsYcUJ
	CD9StL3MoDMLh5lJC9RH5/ROff2j1ghYTUFcv/SY1/7nw5EVGK45dN4OvNuB5C0T5xyT/i43cts
	mcOPWbuCqgCJMY+bzdjWHTOx4K2yrYFiQ6wOcZLRVWa2WvXDhW20luQBCCUgm85Outq/Q0AObgR
	Q+WfJulGrRVuszfKaJkB7QbJSPmUzKzIbMvgv5clj+7Gbm5eFh8PEm3HD9gUcLveeJlXCHMHxzN
	V70y4Czi+2tvLNt/tJKLjXq8u8FO5
X-Google-Smtp-Source: AGHT+IFowfVX3G4HjzfwSYl1lhCis63CfINpQgLZSZ3TnKOciDf8Pn3iqvnmzXQdfCjFJtdK0DYWAw==
X-Received: by 2002:a05:6830:98:b0:73a:8a05:cd3d with SMTP id 46e09a7af769-73e5734d2c2mr3545805a34.0.1752620386019;
        Tue, 15 Jul 2025 15:59:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e541c3a6fsm1022866a34.57.2025.07.15.15.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:59:45 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:59:44 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/xe: Fix a NULL vs IS_ERR() bug in
 xe_i2c_register_adapter()
Message-ID: <65825d00-81ab-4665-af51-4fff6786a250@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The fwnode_create_software_node() function returns error pointers.  It
never returns NULL.  Update the checks to match.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xe/xe_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index db9c0340be5c..1f19718db559 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -96,8 +96,8 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	int ret;
 
 	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
-	if (!fwnode)
-		return -ENOMEM;
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
 
 	/*
 	 * Not using platform_device_register_full() here because we don't have
-- 
2.47.2


