Return-Path: <linux-kernel+bounces-775469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD1B2BF87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5315A2A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B11326D5D;
	Tue, 19 Aug 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEF34skC"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEAA322DB9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601041; cv=none; b=ovfO/owvNgn1sJHGEBx1ugqnwdHTRtnyrZkXKldKBmCF7zvSxb7LghGDgKvCcDeNkEcpZjj1zBpy5107FLEXA+ZiNsj3vTJb0O9EW1CM8gEHKPQurCivtRP8NPE0u9OFyRfEQegUO21VyuV2oWnYFWtajJ4N1aqInopTRqOFOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601041; c=relaxed/simple;
	bh=/h8vcXy6qR27gP1YZ8Yc6zSfsz6DAOWe2QXpuI2UdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVbUdiY5K9fv6eVD8GcSbQIYiGizWxd3tB5rxazF+WFgw6Txu7YeLXVhvvZrX9Mei1dEi7IBRBiSvbBR2DaBFdxFbiqrkMq0lEBdIBKezzQf81JEbEEzTaslXYWXPm/SstvWaxTDv0OgKGrViPeBbMTUkU4Maero2mxLK3F0r0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEF34skC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea79219so5859001b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755601038; x=1756205838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/h8vcXy6qR27gP1YZ8Yc6zSfsz6DAOWe2QXpuI2UdEs=;
        b=bEF34skCv8mu04MesU5+l/92RI5CvR33uks+BOCyGFbMFDK1oT1fN+DCF6BHdtn3VO
         xxbTLQHFdSBApJ3rioBX+tDjwOtTwVaSTCeMFwP/AV3eDO1zA6OSFdPHeA6qzKbWQsHV
         NZDteqU9xZABGA7D52qwDE9LJsmeEserb8opzbiXXmb23aJlsmJLPAtnHziEK4/of30J
         LIy4QAoIvMonpWNEX+nCVvkcimt4EJZts3kkXa1BpXMvDR23k/oCGe+jNGKDGGf4/4MU
         9BPloT/Yy3D8kTvaTRkIzUFY0EBJgszm8B5GiicLgWhE6Y2omvb8T3PFD5WkF0pxMKlF
         faMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601038; x=1756205838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/h8vcXy6qR27gP1YZ8Yc6zSfsz6DAOWe2QXpuI2UdEs=;
        b=pY4bpLqPB6vIBX6SJ3B3k/H2PIDQcYHYaS0mMALYzcfPGgMY0olnJI8irEVQWOPp68
         3M2z9ftousbTieSmi8Xf6pGG5wD/NJAve6kAwokqcppK9OVWGrazCBAyEkytJHvk+PHR
         I34vP8MNb2H9CQAofek4382UwLcvdS+83xQ8kCkUTrg0K4562Ier69QTz1WpVzWteIAc
         YIIaW9PXR0UIBnFLbQI/eDYBGvHk2DS8vhgo+jsYlY5TjqQTaLT+jMOLedJcLt8e7XOV
         WZC3c2cXeU4Go19DoLxtuLVr/waUoUCRrTfXwSLu0GmFERyrLEb7lBijKGODq9Fa4x6S
         z7GA==
X-Forwarded-Encrypted: i=1; AJvYcCWAS2BCIyxI/xZom1bZFfDKe4lY2eceORFQXrSR0e//bY727uqnjN6IScHNlkvRshMDeXK6AiZa0SJyvmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNHElFwlhFXBteLLwde9wIIHbf0I24uDnmrrUh4CpmoQFoli/
	QOxJ0DCuXtzv6inq802rfNugQTFGYGuHLn7InUAAd9Zq5R/b/RxgpBZ9
X-Gm-Gg: ASbGncvnhGpeold/LwWVw9gXHUooWdfECo410NowFqDdboYk/p+sX8XKg0EoG/JkBYl
	jOYii3x7dglw41XgTFHcGLh2KANe0t9D0NxN2ENUMrkQUejAO2+4NlKDf0TvSMn2FYIjoJHjjfC
	8wS5Ibmpjps//YzmU7dK/SnIa3bExctd6Bj3OZ28BkbDPG9LhWJyy12b6r/wE3cUmuFngh7lQOT
	eqd6hRjfeENRyYHec04GRMTtrr+XG8rVqdzOxVVVSnyi9IS4KZLHIPKmRmG21BOuP3AR7w25dTE
	/sc1BsFHVcthU+DxyLJzijsVamlQRkK/LpgQPp3h4/jBsQEj3GiOUDRKnjsFpXn6Ec1bhu9b7B8
	Xag6ruaJX19vKDmkyjQ==
X-Google-Smtp-Source: AGHT+IEHSyz6oaDA7K+RvMSncY8tbf2c7olIXCrk48S43s9RumALFVRcBntKKJA8rU+d1WXngphnug==
X-Received: by 2002:a05:6a00:929c:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-76e80eb487cmr2546976b3a.1.1755601038024;
        Tue, 19 Aug 2025 03:57:18 -0700 (PDT)
Received: from Terra ([2001:df0:b240:b5e:abe3:8cfd:3fd8:5d8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d130cfbsm2218152b3a.40.2025.08.19.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:57:17 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:27:12 +0530
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: tzimmermann@suse.de, michal.wajdeczko@intel.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	simona@ffwll.ch, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] drm: Replace the deprecated DRM_* logging macros in
 gem helper files
Message-ID: <aKRYiJec3VE7xo7J@Terra>
References: <f94151b4-893a-4758-a118-153076a20d3c@suse.de>
 <20250818192247.58322-1-krathul3152@gmail.com>
 <CAPZGEKyhn1LLZQ7z04_u6pjTf9Uqy+ycH4t7xYMRe5dDR9Vg2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPZGEKyhn1LLZQ7z04_u6pjTf9Uqy+ycH4t7xYMRe5dDR9Vg2Q@mail.gmail.com>

Sorry for the html attachments, I forgot to set the email to plain text
based.

