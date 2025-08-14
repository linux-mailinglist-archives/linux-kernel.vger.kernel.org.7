Return-Path: <linux-kernel+bounces-769568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8890DB2706E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845DF5A3F14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095D273810;
	Thu, 14 Aug 2025 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="svHurz2P"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4497244662
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204916; cv=none; b=jrbN9a0syAa4y7Z3iizkaowXx4AT2yGRKS3GB+FjJEAzXjv1hHNU9Glu3RVLhRolBiy1o+Gzbvt/fpuxrBTpcf8MdNPmDxF92dn2AWW9uIHWxtrQozWv+wwvmTzB41VR5OFu1f7Wn1VWJ9+I+zA9teQAxmw9ch6cnlTKrNVDqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204916; c=relaxed/simple;
	bh=c15i7N/nHlctlKIhfbueGZzSOzwJXM0VEKrLTLzVMFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1xAupOLR2PuxjaqINTdYIyOiLORbUNa0T2dF/J5cD/5nU4fwMLIqCDwHx7NvX6nRgX9g5I/RBwDLVnBHFR0LpmSmKU56sJMnyhUO7qlQXAjPa3w7ZzMObGTYMvlWxPrT65WFUYykc2k7LEbBp/oot2oHRqGwSpA6JOk6nc+HB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=svHurz2P; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30ccea8a199so1414149fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755204913; x=1755809713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Lw1CQk3OPOq0zllcKBx/nVguWCpRXrFP9xKbQEaC04=;
        b=svHurz2PGwVSp14Zl00YZ+PBw6vB+3kYKsQMDFPjR/g32lCuxgDpG0Zk4q4y3wvO4s
         eESBMa53EmsaEpVQL4zbV2wzwdzsWSvT1/BVP6PF3G+a9G22wbYCFpKAboxwEpGZ/WYI
         vKKlfHIXDYnTlU1ximIDhnSpvMwlXlxycP5Am4N96E2kKF+piCS2IeN7vfTQ2QKN0FSb
         EyaIvyVHZKXVIiAjLLcF0Fb+g/5Yp9NBdsfB02kOLSPoXcap5rqdWgOFDReTMeYFPzXR
         ASF8Z0Pewqc6pemEXU1Bl48j/tRR58+hYoUF1BsoOsw97DyxQX8cv0nEMLf5l1S2fj/9
         Fddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204913; x=1755809713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lw1CQk3OPOq0zllcKBx/nVguWCpRXrFP9xKbQEaC04=;
        b=ioTwnZlefjeqTxJ2zLKhtyAhDc9g25IVEj5GpsIYOaIRSU4/TN0LmbkspzeNJew3P6
         jB/apxeu6UrFHlSKgGryOViWgrSxv7n1DL6tqBgWG0t7hlq2BMxYm+a+K3NwVur2+5UY
         0iCt4dTEr7YT8YGeIx3jFxW1oVlKSEd2m36wO7s7AbOsXs1BSVKtiTEkBJJ1UsSAIGzM
         orJyGW9uQOUOitgzWwdKOblfh96hqWMtBzNX2OPdG+GNHKBWoR/STZBMJVWg15NnB+Tb
         kSt8VOEvsXGNIpvcc/YFur7sq6g92nI3ZOFIimH1K0zf/5RBrlrkIRFqJyY4/FlDMeyQ
         +w0g==
X-Forwarded-Encrypted: i=1; AJvYcCWCJnIWqhhMjcYGuTmy6+KYHxOmfutAjZx59/PE57H4jdR1/Ej8QFrHqGDYPXh7DwuHZnMmzyF2lyliDSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaP4yTmJTxIt1abnazXWmQOdqckwqE+3VWaMsNblEhcwfdjTa
	5VI8F18ILK8uRI4kqF1mjaR7UkHNHrfvaqUySWQTXR3o/SjIydOK7guXNhZ33UCX3vQ=
X-Gm-Gg: ASbGnculD9bnaTWTY40n5iWWnuYTdfeGCrXf/EwlhngBCmjJaKIDLAFcO8qenTD4y4d
	6VRP0UEjgyxPkVhLkzCFzYCaTPFqZHwQt85Xlf/wA2/p2LhJYGJfb1hipi+/czJfKGOqpIOvfAc
	6LYQAU1LBk0JKaJQOXTnvfjpQ8QX136gmddPsaU4H6j43cMUBM4nYXUEu+NX9/fasGk2N1JjL7k
	ypmQURo4NiFq1xynTiYhtbstpWiiv2YUHCp9ba2ovzmwZmGHGHPQNEpiLPLGP14AOU4QfVOWaG8
	d5Cg3X1wy22D0EtvnF9LpBNzda57J4QCMIjMWXOj6G4aWEozBKfvsUT8bCyrZsvXpw9G+tX4jSx
	dxLYziWAjoXNtNdPoj9qAuBme864Ey630C2K7E9DnjrUzuyktdhoi8OY0VKtByluGvdOrcU+UdY
	EpqW+/kcR/Hw==
X-Google-Smtp-Source: AGHT+IE5YbjZs2djBXKIUErUo7BXp2zMu/SzcdDO7ZnF6dPRtxmnztErim872SLpP49Q3QZx++e6ng==
X-Received: by 2002:a05:6870:548e:b0:2ff:94d7:b006 with SMTP id 586e51a60fabf-30cd0e61eb4mr3135219fac.13.1755204912792;
        Thu, 14 Aug 2025 13:55:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30cd018da90sm905636fac.32.2025.08.14.13.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:55:12 -0700 (PDT)
Message-ID: <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
Date: Thu, 14 Aug 2025 15:55:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 5:00 PM, Sean Anderson wrote:
> From: David Lechner <dlechner@baylibre.com>
> 
> Add a spi-buses property to the spi-peripheral-props binding to allow
> specifying the SPI bus or buses that a peripheral is connected to in
> cases where the SPI controller has more than one physical SPI bus.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
the subject line to `spi: dt-bindings:` on the next revision.


