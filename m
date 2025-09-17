Return-Path: <linux-kernel+bounces-820270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB0B7D6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2C1C05C22
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B330C607;
	Wed, 17 Sep 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9wlBi/F"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117030C61B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098743; cv=none; b=O/YyTg+A0XfvKk2NsoWhlvMzRfVPTYwp7i1n2O4MmklGtJyJq+V+9TODP06a3HQ5srSDCiJY3/nfgUMiZ9RYO1iUpR0j1ultER/lPvbcKp96nv9nrAtONF/0VFb33LDkPauNn9PF+ucnW0NIva09OhUCJ5ij0rOoA6qJdKD8q1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098743; c=relaxed/simple;
	bh=6oSQoJYXy9kzZUXXsKvQNgIjw+FKm42ZDgUSNQ81kUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0k4x/05M/WZ0GvJ4kHDen98XMh0rvU6Mz2dohP+rZwB1VtyAaib4uX0kIiag+RSOTY7bfXecPGz2DD1S1vYFYzXfA5Fkfi88/aJQNoRt0NvVYKi3kibbahgNJIm9DmWeXyPUhiKYrSqTfd7/ZxMeugJyswVBXxrFrcu6M30Z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9wlBi/F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2570bf605b1so63979755ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758098741; x=1758703541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=er3gFl7t80h11A2nHITwY2f9Z7fB978uzRRnymZFcUE=;
        b=M9wlBi/FpO/Kjow/1WggP55N1brC6tQdJTOi9aYa7JJTGl8xeskuOOgjVfHrmLg+/s
         dv6EgfFhUGSFBcfOAT1A2i3a+ah0U/JF62GCNCIFAXL+dEqODm3d3AKslxQfqXxHpAPE
         68gs3B9Bnu2iyORL27EXSkVOxl1EbPrH4epiet57kWV1ePMaNRNc0UZzpJ4jXQUmRqnL
         UaulEKmwa5Cl9n4ghazysNf/1KJAt6zQy3IIydsFkP+zni7GR6riKYk2E22rBMGs0j1g
         DaP1MxIlsbpYHP3oW9j5boY+WKMCHbXR/XYX9vBT1+zkXk9jrzUMXR2YJWtu/ctnzb5H
         87aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098741; x=1758703541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er3gFl7t80h11A2nHITwY2f9Z7fB978uzRRnymZFcUE=;
        b=W2NXkf6UtXp5dY5a9+KkjQRzoXPypbwzclLizgKy2XD9hf1BnEm2Pxs5cw5qQlPfFe
         R/SY3dyTBBa2Iv5UB6Uox0vE8mR5CqOxtXy8R7bdDZbiHh/4qcFzUanaXA+M1Bcl4gmt
         wpHiOCe/2PIv+miMSlyNwTN+vHUFWhrkxmgCBw8ih+97nYirLCNNTch+Nhb7uiW0fvYv
         u9+yX9GIM23QBFI2aVoXMqCoRNfNYKTJSPLvEDyZcsy0D42v/RgYHZp46nodmUNXqRWk
         ba2aHo596GfnziQKWzqGDeZrVSjPlsr+jZKU4IAq8sm5m9WxQ102bLmz9mi/Y1FH/ClL
         gEgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/ZuM0XJ/mjdZQHrQ5310kWJbA54dfBfasNfUz6po/R2GOEd56CND3S6yOGqRrfPVfGQBxnykBTluSts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGQKonjWbVT0UuDNSZuLV/RGU3zxdnhsbZJJt4kvrDqem0jc1
	PjhGWs5HJdUhGy6wvIFPSDttn6hoUqyoC/+Mca0rHB3lnhbiZ335UaZl
X-Gm-Gg: ASbGncv2ohw1ob7uDSDwL/vcnRK7MPoxaI1ct0Mh5NmMeo+8B9XZV12cY7Fud/SIxdl
	buAOw6b+iW3FqOx4+q8oCVvBgBg4OUKRTsEqhxKsqOHfIL5cgTjjslTSUNuJPyXm6fGiZU1Lnm2
	/97Y2HWAYXf682xLutsgagBxM9kx/UGrRsHs/r4FWf8XIpJhx6WngVSA2l62yQU9cdY2MVJ55O9
	j6cl5ZLSFdqGMlzv1j/O7cv8npYv4FByKnxpKMFLGMuQ1S0IEX0lrlZjkq+j33jV6lQlGUsXiof
	ZwmDHUotxenYisJdjnqk78rbwxiHMi9O8Pn0sZbe+YSeCpomP5NjJIpKmWE5WZulAY87EKoGFyU
	EpT8nF1KqO5866DMgtEmX8zp9xlvI9ct5LU7R3RXWDBkT+m5WEUqjVHllcJu262om6NYi
X-Google-Smtp-Source: AGHT+IFMfFBVGxsXgshIcnGLbqap9aPS4k+g7Lx8SuIeyuVKI8d7KH80dJtO1YOvvV9NWfs0P0JNIQ==
X-Received: by 2002:a17:903:3c67:b0:25c:5bda:53a8 with SMTP id d9443c01a7336-268137f751dmr14664605ad.37.1758098741577;
        Wed, 17 Sep 2025 01:45:41 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-268012804b1sm16864895ad.106.2025.09.17.01.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 01:45:41 -0700 (PDT)
Message-ID: <215d67c4-af89-4757-aac4-20d2de659b64@gmail.com>
Date: Wed, 17 Sep 2025 17:45:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/21] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>, Akira Yokosawa <akiyks@gmail.com>
References: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
 <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 17:35:31 +0900, Akira Yokosawa wrote:
> So, I guess I have to NAK 06/21 as well.
  I meant                   10/21.

Sorry for the noise.

> 
> Regards,
> Akira
> 


