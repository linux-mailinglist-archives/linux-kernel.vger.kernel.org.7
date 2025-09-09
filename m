Return-Path: <linux-kernel+bounces-807611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A01DB4A6D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC667543329
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334C628643C;
	Tue,  9 Sep 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIMiQiM4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDA27AC28
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408982; cv=none; b=N7G1mULd2rUK3F5BE8n6+reidq7hYlZhcul6d9Twgm8L3cVdj+SipOA8fchEAyOehMNVuE18zblz44+t11evEnNr+38vTPS2ANvrMm9sD/9xQbPT0RMUAVdy3HjlFW0PGpS5SiV9OnX5atPy/NaJMDHKlM5LG9qN4QV7L3AhWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408982; c=relaxed/simple;
	bh=BfSMT32n8LbS+11jMNdHgQlU0hJdFdNznDOWJ7noQqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeworXc1EdqwQAKBEFENvf3XI/wDqedlnkmYKEKFqBwesEXrdMKeLyMAPXrZWOQslZYqkTwTox4jZk3rriUU0eCArGhay/6XKpnCdJwMyHw5B7+WlOgWzzJA/yYbUeeWDiWv79tTNu3oHM84f1Y803Nc44lLpjyiBqwa9HmsqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIMiQiM4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7724df82cabso6101955b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408980; x=1758013780; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqPc2XyEx7hJaGX2RHm1jVlEm9h0J3/vXED5Ck3jL34=;
        b=nIMiQiM4gTzcfaxCmwLbMY7dIUgFZRihksc4R7D9TP2fhMBWKZVFOATtpXhh/jPCkP
         ADqpVuyeatFjzZsIUgVFsrzHwS5l9QHodJwcGvHUZOEm+rq+eUUPFhXFAVJZELhc6oma
         NTpx6M3A7OeJvg8o75AKPLwpkK8LA3826ImE8f0lJ66PXj6bfv0uchmjoE//mXalBP+o
         RXmy79w5L8TrhlszavAmZJTSqoN3Q2QvKLF0JA2HcY2S4oFy6X+VXJXt0J93+vt1OMaR
         0rXP55HLaJFtTR7e7FmFaPSgCdwH62jTwbCnLXYprAa4G4AnyfoW81Jyp8IG8uw7Kiuu
         swgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408980; x=1758013780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqPc2XyEx7hJaGX2RHm1jVlEm9h0J3/vXED5Ck3jL34=;
        b=uWZapow0l2DBLHzdTM9wWJ/zfjHY5ktmKgY2zi8I4zKo31WLsbCNIs/v7ZoEmvIqI0
         yOvYsE4XaVVVkVWXDrI6h/EyeKeOjNzcrK6ZY226oivtsfve4MRcMkhsI9TZy/HHbVaV
         K+/fLENjSd35g4ZNRrM3f7AeDlQIWIDckXOxKsMua9DmIHG8VEi19tLqewWB9Fm5z3Q3
         jEudCuP791ZZXqW1it+syT8UhCuaRDzS3yw/zd7+cf67QyF7iQ4UUt9rTstKCksdV07J
         qXFLU/eLFMDrpu6sZUfgCqL8abFG8kIQmvFLl4DZ+duDWZhB0HlSgCdob9JQzJ//qOcj
         9Izg==
X-Forwarded-Encrypted: i=1; AJvYcCXIwhlLQvCts+Jlsvc/tSt0K/pcyH/5cD0a9E08SujC0/4hpRoeeHaqiHDwP+1S5JCO7Q67LqFuU9D87ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQL7Wb54BumcgtNq7SLO9ICWYXltIk22ae4zs2BNyLwwOEJM8m
	K1g1RAs0YFih61snMDq0QMNTKIT23hw5bDz0KJtzFmsMvf53mK+Arufh
X-Gm-Gg: ASbGncvxjFXTzsuItJw8kUDxLNUgmgM3yjY9PMUDfr0U50J8wvg7OpQSyTm5z63S2xA
	dNZHluyGNuWnB9YUC+BUX6grFdFH/BvD/vIltk5t+Id5A0Vs+T2yjAHJRm0Q87trZeTDAEWiNrF
	3dD8Eh/U9p9NVw5ERIjAGBpZCFQjlzGuiQu9SXCyZtWPw3cngwbDbc2yDs7zQyXx4P3KDEQAnTu
	uMJbs8h01vgRufoO+9wX7qemAkz0a6f5YfTzTeEmy9yhzTIFuMODVpf70URy6Kkl7V8/5FFEQ6v
	2BSwvVgv6IweXKyKA+0cdWtCuJbsDV/Mry3L29pDDWEhWMNvM7AyKGAStFIrQwrdMhS6ZI4SKGp
	+Wmu8rwpN1YRAPKAwxYjqkCxnedbrPIGFqlTs9mK+q0ceIym1ubf6oLlyrFsQSGTqie51bqs=
X-Google-Smtp-Source: AGHT+IGLMvgR09TtpXV6LHI+sqDFZWwyxmCEyzU7IJEVMiPIwQK0Li50mUmwwWRucDIt6KYIn3TMog==
X-Received: by 2002:a05:6a00:2191:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-7742dd60109mr14646722b3a.4.1757408980074;
        Tue, 09 Sep 2025 02:09:40 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e4dcfsm1469549b3a.18.2025.09.09.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:09:39 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:09:35 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, austin.zheng@amd.com, jun.lei@amd.com,
	harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
	alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
	zaeem.mohamed@amd.com, wenjing.liu@amd.com, chiahsuan.chung@amd.com,
	Natanel.Roizenman@amd.com, Daniel.Sa@amd.com,
	jserv@ccns.ncku.edu.tw, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: Optimize reserved time candidates
 sorting using standard sort()
Message-ID: <aL/uz16tMybHTeYD@visitorckw-System-Product-Name>
References: <20250824182359.142050-1-visitorckw@gmail.com>
 <20250824182359.142050-2-visitorckw@gmail.com>
 <c28df8a2-9ec1-41d0-afe4-4ee047290d27@amd.com>
 <655a009a-0b69-4e11-949e-ff0f47b424d5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <655a009a-0b69-4e11-949e-ff0f47b424d5@amd.com>

On Mon, Sep 08, 2025 at 07:35:08PM +0200, Christian König wrote:
> On 08.09.25 19:05, Alex Hung wrote:
> > 
> > 
> > On 8/24/25 12:23, Kuan-Wei Chiu wrote:
> >> Replace the custom bubble sort used for sorting reserved time
> >> candidates in with the kernel's standard sort() helper. The previous
> >> code had O(N^2) time complexity, while the generic kernel sort runs in
> >> O(N log N). This improves efficiency and removes the need for a local
> >> sorting implementation, while keeping functionality unchanged.
> >>
> >> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >> ---
> >> Compile test only.
> >>
> >>   .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 23 +++++++++++--------
> >>   1 file changed, 13 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> >> index e763c8e45da8..2b13a5e88917 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> >> @@ -2,19 +2,21 @@
> >>   //
> >>   // Copyright 2024 Advanced Micro Devices, Inc.
> >>   +#include <linux/sort.h>
> >> +
> > 
> > Thanks for working on this, but this file is shared with another OS and it is not possible to replace sort function with Linux-only sort.
> 
> That's not a valid argument. Linux code must be solely written for Linux, you can't reject a valid patch because it breaks sharing code with other operating systems.
> 
Hi Alex and Christian,

Thanks for your feedback.
Based on the discussion, I plan to keep this patch in my v2.

Regards,
Kuan-Wei


