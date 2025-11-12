Return-Path: <linux-kernel+bounces-896818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E9C51436
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC84B34DB55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D22FD7D8;
	Wed, 12 Nov 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvZfnM1r"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BC2F9998
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938310; cv=none; b=A9OgKE/OMBm61LPofPLW39dZTEojpUzgzEVWtS++4rqr9BtQrwzBXEeUzfj7rtsHZGM39xVE18PgDN+ZGaPM3iBcEjEtlOrbtHciVutm2b6grO8xu5h8kVOIo4IMLv0ZPwFy4mOkbKY7QBX7P4BkZYx3NPxTe/vHhIVaDnZEuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938310; c=relaxed/simple;
	bh=UjaEv8WTllVOjp2zrTZ7c9iuJ7T6Yqki2atcrwtghNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AY++C69sNGaNyTK11oGcqDAOoeAUSgdAL4u5aazW4/Z5PcXz5DeqeLDUEjb05cpq5xr2YxbzT2EUWB3L0yIz99UMbUiusM/nqJLgm7t+a7siua3/S5dTjM8s6+zxSDoZ0MvniC1WKwitdWstnTr9IL41sGAHT9lbcNoN9iIi7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bvZfnM1r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775895d69cso2987685e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762938307; x=1763543107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjaEv8WTllVOjp2zrTZ7c9iuJ7T6Yqki2atcrwtghNk=;
        b=bvZfnM1r6TGNZEc+NLKIWh6Y528SGhy2rfevQRXLl+3T8zubzDrcwefcG7VMaV6OBD
         lsBzX3fnbQfk9rxz5YjOQv9+YjSnp3HOggXt1TDUd4yRNu6sadcnsZEz8H+NK0v6uNPy
         7JHflRMLcK62I/Zv5w3Z51hgL9sR4NXdZ4Uu4iLN4+MhbxM3rip5Ju02TDot5ZAudnm0
         R4VYvgDsUoUU+anqx1DkQNuIi6gr3NuIjzMCFf0+jLm6c01/UXIsrGZorC81zpxjj0Ve
         kmyEcAVM1Wq9mfhCGHQoU9R25ml9CzIzctgHbkMWOpllSeEh0Y5aLwWdwWYb+DZHI3s/
         IYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938307; x=1763543107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjaEv8WTllVOjp2zrTZ7c9iuJ7T6Yqki2atcrwtghNk=;
        b=UwAw7GsucoOj85HYQFDcK+XQhBGmGaodU+yTK7HvXE+FwOzwuwSwBWwXskUYdv8JLg
         7ro7eXd493CWli+60oqhehcPsKsT5UppF+32/X4o0RNe270enrXBSKMpmR0b94hx65/Q
         szXto5+fi7yTipEvF1UNifi98KZ7JpeOIrKHBw6GsS6+244xqbBFty1MLuYrvgs5vXWc
         XyiHwqK9tGNda5HauZk1/pOrSyMjFGFgbeERgnVSWGKLEDvub+SetX5+dqySlAjOBH3K
         yvjway2wrLDp06i1+wiVzJEnMZPYS9ZKKBtNYg5ZWunXKho+zc9PJMgBSa0btxdq7MGM
         EohQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHKhyBdjFBOKP+0bspLo9yZVO7E175Xo4N6CN9RCH2xwUKNEJZvZcZ1Icx75p2gzKMSBpvOyWnpxbwFDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNFiupMfgYN0GpsowIvtEQkj0O6SjQEyKeoHF1nKWWQIN1de2
	YvuRQ+yDSsT9F5qOv6BcbTvArgkdSEnVHqc4+2n0nx5qRsJSEHwJ/LzmEQaKNJZjMzQ=
X-Gm-Gg: ASbGncvKCe8Rf81SaXkqqKcBJaQ+3t7KROHkzpJnmPivHseCtq22LnNKqoe15pzWaPm
	FsjoVmlgXhxMnfJCPohH16yL1AuuoxFMy7OBWsiZzGnr4J7VOjezzUFiFprOpIE8api+TT9eWJb
	k1ZFjUKlcQbNrPpKFVKJpdgUoiTtGdo9P6GzWAcnPN6xz2tRxhEwUjE8LJoev73uahvU4u+riOe
	5L+VvP4mIKXGzOk59dO51j19lmlvpAgjAFnbh6QRQRWN3ROAYyaFjZUnI2CxRDtBkHX+Igmk/m9
	3OhJ6AH6ino9TG+fqcfewEEMxm7mkl6JRAdDktjfaj8Bohol04kZKrroWPFOLTUgo5x78prVtar
	bpDMoUwtNeSB05Od5rEiBj0wLpkUqHMk21UawPMFIrgE3PM0V5qKhm9DZ9hhQjYsUFSSZcvMHy5
	exFGh+rCbFo5/ySobG
X-Google-Smtp-Source: AGHT+IFaZAuEWTwFLR51iHXsJE+bCjGRqn5WR46Rg3eXCp8SfPQgRrpAHKL6EvATHfPuewRU3oUExw==
X-Received: by 2002:a05:600c:3590:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-47787070651mr22036785e9.5.1762938306837;
        Wed, 12 Nov 2025 01:05:06 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63ba87sm33666226f8f.14.2025.11.12.01.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:05:06 -0800 (PST)
Message-ID: <7363d995-f96a-49f6-ab44-3e9581b59617@linaro.org>
Date: Wed, 12 Nov 2025 11:05:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mtd: spi-nor: micron-st: use SFDP of mt35xu512aba
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
 <20251112-nor-v3-3-20aaff727c7d@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251112-nor-v3-3-20aaff727c7d@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Wonderful, thanks!

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

