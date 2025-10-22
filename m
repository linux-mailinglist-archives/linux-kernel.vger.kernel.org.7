Return-Path: <linux-kernel+bounces-864779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC9BBFB88A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DD93AB4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC682472A8;
	Wed, 22 Oct 2025 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M749U/6R"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D82777FC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131052; cv=none; b=GwiWXgRO2ociTtje91bTyZb39CkQJEsnKBZcRiiSxZuZ44J/CfAuWN0gtRC4ryVi/ft8ViUCxCVw7YARlmKjomBNVnyAfoypqC8bQtg58xJmWFkk2x3LgNe+i+tn3v2iBU4fXneCF7CjiGqipyUpl+79ovdkhjU+jyjmtl65BNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131052; c=relaxed/simple;
	bh=IjzKzFr+djM5tXl7O91fV0Q0tMbyfuKgPsnKyaR44gk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kd8l8jm+tR7oXzJfQoHoO7F7n8ec0eIk24+NTaEMdcne3uskMbsdg9N10UWjGkDixZ17IRvrmiFw4qZdyHRtG09IpWT75faJ3i76Uapiqv9rGv2/9KgLugCvEIGtT58Obw1ZTfz3gUhMc0Omkvcy+3WFrE8VqaoU6KU+SkQrIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M749U/6R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so22183285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131047; x=1761735847; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60d4FN8I12bjhkv2m/h29YuwY/zOYE0TJa+JTgDeqZ8=;
        b=M749U/6RF2IqviR6sR7eqE8393ny1m5RAN1TdtYvj/G11aiiBHqrqWuqQvRGTzsIja
         0UBEVYL6794zOAxHI/b6/o25zgVG/1K38AB5Jkdgm7CJETqDv90BIe0QH+3ClLde4c9I
         Z0LbZ+PifIjs+UglkZvNbKqsfg+b3fgM4blHpWidfXrolD+VqMXxjULQ2P1tx8wq2436
         ywdcX14Ody3s8tG+HLicZS/FpQ+lV6nK4BIcLUb2kTpT4YIC7skFDX5ugnsaZKsOO3GO
         HSQWw6ATyLTQbxN3PTYB6MP5HJ/fDo0oZ3c5anFYRFojHyqfv7u94bDvha1CzbTMUil5
         tk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131047; x=1761735847;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60d4FN8I12bjhkv2m/h29YuwY/zOYE0TJa+JTgDeqZ8=;
        b=QF65U6lizrkL301VMrdJcNJwNvBaoGuZKFhNAGfkOtWzS72NO2HS5fQpc8bqVJLhZn
         w9yTjhGZfhPRciidse7pNDkijNoDmXGX/28M8uFa5rY8SwyXrcq3TRe/Ln9DYOlCZjCs
         JfIIu6aKbiFDUr5pU0QBZMup2RqBLg9RBEFf1F4AQhS1lOdO+THbgs//9/zd1ylui1SS
         FFhxRImMMTmxy5PYEiJXh32gtF0pR8gnaVu8quyGwzXt6VAFM8arJS7XkUPrOMWZ8UMH
         2HRTaPkpDRzgClRDzXaPpPkWeIv98h4F+MMcPkDagvyw3URPPSr+0TPwe+N2GNrabBMz
         zdqA==
X-Forwarded-Encrypted: i=1; AJvYcCUg+Z0j02EimX5ru5A9jq+UWGtFmFaHZyFKtAEiGRI+jHadmQ5zT3BB7d3P2oU186zTESp4xik7gwfaO9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbjcgsViFdoyTFIn3/m7ezcw4nlnyBQ6DVz3J9qpA9f/qbjpV
	0023qMxGZbgnk+LmeY/+nhRyTIn3qeLv/tRbUEo7lV21TV2F+orDmLKumVnLQK9LGfs=
X-Gm-Gg: ASbGnctbh7b5Ud6cFBx69SnCIrwcr81PmugD1f536l50wqVEtiAFasbJMRtL71xDtVe
	PsAkD1ieTXOeFkPKxPoAUsLWUoKJohWqjMvijy0rHg23UjtxY0Dbkn9qMIvE6txrfHzHk8nzSCo
	26vfK/oyai1c+YatlOnwqo1i1f6jdfYlrFWEkwnsJTXO+AU0DWjLTbGjAndbTXlWFe8OuxeY0MV
	ZC/40/kSO41EDgwMS1D6diB3P8nAe+jjIVqKiQuF7vZRZ1Ptmcxfm55p0Y7DP3bM+Eg/vbYZNli
	C9TnlsKFzj1dDowOf5fEr1GyEKNVHtfJs68lFSSYzAzOKaqxaq3MmsnGuO8fAg5BFelp5/e75Y/
	v0JKyWwlG6AoHagAb7zOO8vRwPrMA0c+MBmDkoRHz1zxx3+jVXH7fqPyHVaM0ljIXgs+UqsH45n
	zvkKHOnOvDFqKkAYTZBGDaCiuQII8=
X-Google-Smtp-Source: AGHT+IGVxOZg/SGvzQXDgSR7/+Whdk7ScvRjRe/N1IbTeIwwfj/PV9uPXXlolfy5kHmMZfmv0uyAbQ==
X-Received: by 2002:a05:600c:4e8e:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-4711786c702mr178910745e9.2.1761131047078;
        Wed, 22 Oct 2025 04:04:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c427c3casm38721405e9.4.2025.10.22.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:04:06 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amd/ras: Fix memory corruption in
 ras_core_convert_timestamp_to_time()
Message-ID: <aPi6I5z5oenppEuu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The div64_u64_rem() function takes a u64 as a remainder.  Passing an int
pointer to it will result in memory corruption.  Change
"remaining_seconds" from int to u64.

Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 01122b55c98a..d8a004878a64 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -67,9 +67,10 @@ int ras_core_convert_timestamp_to_time(struct ras_core_context *ras_core,
 	int seconds_per_day = 24 * 60 * 60;
 	int seconds_per_hour = 60 * 60;
 	int seconds_per_minute = 60;
-	int days, remaining_seconds;
+	uint64_t remaining_seconds;
+	int days;
 
-	days = div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&remaining_seconds);
+	days = div64_u64_rem(timestamp, seconds_per_day, &remaining_seconds);
 
 	/* utc_timestamp follows the Unix epoch */
 	year = 1970;
-- 
2.51.0


