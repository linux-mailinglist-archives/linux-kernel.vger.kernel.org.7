Return-Path: <linux-kernel+bounces-898114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D665AC54630
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5286D346A70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6902BE7B6;
	Wed, 12 Nov 2025 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/WRnWFW"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9119F137
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978419; cv=none; b=krYypkfzTuULGagFEjGAWbZIXA3hT5Z9vagobAqClOgfaMbPmW77QGnI3EWRpqwCtZQCoPP8PBYprIQZ2reZiogL0uE66FOlED+QiBGHrOHVYOrTU+0Fp7QJcVim18/l20IfEYbbtWk2lOHVWadrSpq1iVkvalCR0rHaZGpCZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978419; c=relaxed/simple;
	bh=7OpbfbJTDoF2lSeL8JxLl5pSRv5Udk+mhhoKn/NRqV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok6u+Nea0GeJ2tD0Sw6v3ZlnCavRNTYlpVGLCMuvbnS7gH8GL88xJbqLdKK9hXv9+x/XaS3LPJ2ApGAD13o8g5lJr4C3hqKDjQ2AOGYIv6ywx5fn6IaY7xIzGcT6Eh6IABPSd9szxG6eFEy8B4RHllW9OXqGgsPQJSp9k4efxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/WRnWFW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so24294a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978417; x=1763583217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEnCcyn20grhq9FQbq7ZypXotvEYNCiIdOYGNMkBNrM=;
        b=N/WRnWFWVhmnlhCYrOoBq7jr8QuDWHQUJSVnKx8M139twZ5ktHh4rs4xMyVdXLvNVT
         Txrdl0SGceqiufxg6Gdam8dyciL0ow+1mc2FW5HZwHg5N/OXjQqX1IIVT2mL8F4D7aWb
         2tnR4qP5Yu1PSUJzVDIECBtZTAj4g9n9VRWvXAIiJM2KF7S3I2a7cSz4/oxIoTj01UIX
         4jk+hTiUqF46YGqFqhQHEOlqLNZsmTBZpD1cUb4fgiXXKANF2fav49HWYa3sPUh/rT26
         Q6VpxZ6KaPKTSMzMnm1eNbI8ySKDgcyt7W03ePwbgZlf3BYoxYKqkP0479c+R+3SjDSY
         azCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978417; x=1763583217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEnCcyn20grhq9FQbq7ZypXotvEYNCiIdOYGNMkBNrM=;
        b=jnN+KCfkjYIYtPG9xS1pzmepSF7gicI69c0JiVvt/gBzXkiMrQiUfwgosKQ7iF5/wD
         hVYYCfmXqa+jJd22oZi8ABrBFdwRB7mrvw+3l66vjUF+bQUVqadcBO05/pGLEUItdHfa
         OlNNsIJmVoi0rTUHjU/BCRP0bTJcHsHxcH6r24zs4oXRljFIjAl3jvNpQImk0EwCJjq6
         7fFQaWCn98WP+fBxXfYSgd3XbK6KPNLtto/u9+/Z10qMGCEoZOU35BguUXJ/5+DTGbeN
         xDREsk9lw1FdG/yUujL4/kIM5PlSBp0ObM3YpLxhN1JCcxiEZrDQ74aw0ofC7bIlI0rd
         rRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUfdgRUGFpu4rKocLc4+JwQH3IjYQpM36s6uRD61cE6Rhsj7S/gntjwL7S1onKRuoFyZjHp0D8yL19UELg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAAMhhc51ykQwKm/hfJ+uNh7ggM53R58YFQlTTQzql+T0tW9n
	WZ2QjVcy9Nm+EDxApR6MzO0syJqZmkGRWsZs0gJMVwSi6eY1v1dmWgdi
X-Gm-Gg: ASbGncvUhUsN9TDbupsedtkoG/bWEmA/PieX7NWaHme0evDRfYgk1H8NSqUkfSecw7r
	0isHdSD4nN52jSjX3hl9EzquOKB+Av19cC3weUKhgNaYDrtlXsYBoF/zhPdBVxE58uuMQqTxbwI
	Hzi+wxxylfKOKAw7LGwVUhrec1sQO5CCbB2c1llSLgB7Hv25FrrVGTR83ytNnIPvoFZdgkS+Zxo
	DNOnEEysHULHhw57v4m519e9yRmFYG/snGrSwh/aJjI0UGfL7VaZiUIgoJxuw8W65yhIalp4tBI
	x8sj7f355wVtcUGiqUgtYmEnmtu/hMTZ7F3cfG3/z/78oXu5H3css0M4wm0+d23u9BMDsFeZBHc
	uSgr4nvPZmLY7CH9ST2+wdoEDW1HQsgcQs7dykulqaJOUEtBjvdvvIrmMcgH1W9QB1Ed2jVFa7J
	od3dm7SWWUkVDi
X-Google-Smtp-Source: AGHT+IF2e0Z9qSykfZsEZ45SSppVY6cM1szbGS+Fu+IeCdq2h7xLoE73yVG5z5KjZM2jI4DB8M3Kdw==
X-Received: by 2002:a17:903:90f:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-2984ee1df02mr52346215ad.53.1762978416891;
        Wed, 12 Nov 2025 12:13:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346ffsm179175ad.9.2025.11.12.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:13:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Nov 2025 12:13:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jeff Lin <jefflin994697@gmail.com>
Cc: jdelvare@suse.com, Mariel.Tinaco@analog.com,
	andriy.shevchenko@linux.intel.com,
	cedricjustine.encarnacion@analog.com, chiang.brian@inventec.com,
	grantpeltier93@gmail.com, gregkh@linuxfoundation.org,
	jbrunet@baylibre.com, johnerasmusmari.geronimo@analog.com,
	kimseer.paller@analog.com, krzysztof.kozlowski@linaro.org,
	leo.yang.sy0@gmail.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, ninad@linux.ibm.com,
	nuno.sa@analog.com, peterz@infradead.org, thorsten.blum@linux.dev,
	tzungbi@kernel.org, william@wkennington.com
Subject: Re: [PATCH v2] drivers/hwmon/pmbus: Add support for raa229141 in
 isl68137
Message-ID: <afcb3018-7fd9-4099-a443-2ba6b6513986@roeck-us.net>
References: <20251106104519.2014853-1-jefflin994697@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106104519.2014853-1-jefflin994697@gmail.com>

On Thu, Nov 06, 2025 at 06:45:19PM +0800, Jeff Lin wrote:
> The RAA229141A is a digital dual output multiphase (X+Y ≤ 12) PWM
> controller designed to be compliant with Intel VR13, VR13.HC, VR14 and
> VR14.Cloud specifications, targeting VCORE and auxiliary rails.
> 
> The RAA229141A supports the Intel SVID interface along with PMBus V1.3
> specifications, making it ideal for controlling the microprocessor core and
> system rails in Intel VR13, VR13.HC, VR14 and VR14.Cloud platforms.
> 
> Signed-off-by: Jeff Lin <jefflin994697@gmail.com>
> ---
> v1 -> v2:
> - Modify subject and description for the requirements

Subject should have been "hwmon/pmbus: (isl68137) Add support for raa229141"

On a side note, you were asked _not_ to resend unless asked to do so.

Never mind, I updated the subject and applied the patch.

Thanks,
Guenter

