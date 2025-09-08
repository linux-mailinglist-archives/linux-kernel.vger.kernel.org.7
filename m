Return-Path: <linux-kernel+bounces-805134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29DB48466
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33607A788D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB12E267D;
	Mon,  8 Sep 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaMv7fDV"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651D2E1C7C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314014; cv=none; b=AV/p4I6IUjZcmMWZVPTAVi08256z2slUZN+JZFE07zR3AlCmKIyTP8rF6MFc9ach5IUPB4oE3A6IF8+w5Vc+IuEQi8eN0RV9XoU0WpaWwagw6ed3fFVQwjLx9Po6X29WgrAmSYbSKVHiEgJMlX/SUTSxY+6CQonKZhVvW7RGfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314014; c=relaxed/simple;
	bh=CP+/lHUyOhzacsa5A544WPCWdSbkurijzlD2Tul0wzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CouZIO/Z9obBA4K4x/DGDK8juQQkGPL8BXZs9yVyVA5LOWaTzEw44RkBhH1d1dHOFIYNqtM6RbUtWLoY7mgYZ9edV/RVsxzoUP2dw+tRPm5lHoevYxAs6ngqVd+QsW1orGdaY59YxqGerwErjAYVuA8TWf+o/JMIuQLNyqknCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HaMv7fDV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so2614250a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757314013; x=1757918813; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tqKjKM+4UJsj2XqpsktSnw3L/nKXUi786mbz4PmkzFc=;
        b=HaMv7fDVXzAsPqtH1IlvApBSLvQvGOfTGyLLHAWHO2s9fXb6Iv2ipnbb9RogfIJ3yT
         bfw0gmriXPv2HefsdvhdEriZC8ZvrmPfD+j9Eg8TSd/rFTu/xL3A3OTbB4CGWqCL9NfZ
         LDQwE9fG39WVjXy8MdFmc8mi/E1pZDxHC4R5gGfeC7SwMhmOcunOJjFztS8BQZLuE+HC
         eVjMaAH6WY3JF0b2az9pkC+uJQI+pzUx4hTFPDpEZY098BpIhChS9V50FW14uQidOgL3
         0l98PNypmnVy/U7NO3ZpjVhoMkY77R/F+qhi/pp8GVYTMuE8D8a9gGeUIb0XZr2FiBIp
         i19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757314013; x=1757918813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqKjKM+4UJsj2XqpsktSnw3L/nKXUi786mbz4PmkzFc=;
        b=DMLlQR1NcPlp0IRgdA85DHfmOr863wakPLPDqE8xA07t8jr/vGAHehS70xCb3rnrWI
         rHuueK4jurrn/iqtzN+lwjq5PoJukfzS5TpaEokbBl3MKVWGXq7SIhdHhqXZubg7tprz
         ow5sNZEy5kHCnicsMqb72ASBgbX2GxveUwAD7JjicLT7KunH2A6FCkG5foIZN8W3/dxR
         556ZF0Oe64waJvlKYeKM9H82gpOJIgUZcRe880SmCPpPnw8daNy3vcWPpppDyXphnIY0
         tKVqeWyB2ZZFa9/O8NUkAGS+iMG9B/BscELwoBMWcVjOPKI2DoHPTppLdDrHR6wx9Ktg
         mbFw==
X-Forwarded-Encrypted: i=1; AJvYcCVm/7E+iFw3VI6GQk/4gqfi0VXTVNLwX6eL0iHIXP33p+O+8IM3IgGxb+4wakRwy4kx2OfSPTtGO0EjwGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEv3SLDAqH6q2/XPB5clGyPl5TNHjz6QF9LUNTKscGWOBiJcqZ
	8WNJT/PnvrqfXXIO278XhIdCvEWJJhgTLzOYkmI8osohdTVgznbS+t/98LKSXDAjzFs=
X-Gm-Gg: ASbGnct+56M3T3r0uxSpxZWtS6aYDhLUHsZ5eIbo8GtXa0IKqqLELmuKrgVUkd49DID
	6nX5+3mvE7JtOlIJuBtGpCkc5KMu7dYpwreWN9L4dxxE5tdaHbVn8msl39C0siqKO9LwCdT/baJ
	S9XybmTwt/v2gmAdOBLmYcI6nmWdhZSSGTc2/hwZ0+6b494P9C1lsFZJfNBUbJZny3Tg8y9UbCK
	cOSsh46YwoRzcsh425/rtOBW14ccY7lzNO6wRKsGWKNfKX31iz0mbqRAHWNh4zpJwHCQgN5XUr5
	v+x6LJdQgkdcYMUBLtei2rmIMMH9PD7ZPOPBgbkHigOjAbmdjlcyGdnq5CQfmtxTQLgb9khk1bR
	qDKK5AIx9USr8vK0g01NmY0M0
X-Google-Smtp-Source: AGHT+IGnLi/7AQXGknu49zTuLAwa3+GWl9/KYrdHWk9gv2snN+aXOGF0bL7+PQn094hEzNARFFZkBg==
X-Received: by 2002:a17:90b:2790:b0:32b:95b9:3eb0 with SMTP id 98e67ed59e1d1-32d43dfeba4mr10034880a91.0.1757314012692;
        Sun, 07 Sep 2025 23:46:52 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ae414sm25109366a12.33.2025.09.07.23.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 23:46:52 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:16:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] cpufreq: Make cpufreq_frequency_table_verify()
 internal
Message-ID: <20250908064649.5kk44m5ihdspyair@vireshk-i7>
References: <20250904032210.92978-1-zhangzihuan@kylinos.cn>
 <20250904032210.92978-4-zhangzihuan@kylinos.cn>
 <20250904044557.tde36hekoeuhnsci@vireshk-i7>
 <cec3bcea-4c75-4869-b9b8-efd3412a1e17@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cec3bcea-4c75-4869-b9b8-efd3412a1e17@kylinos.cn>

On 04-09-25, 13:34, Zihuan Zhang wrote:
> Thanks for pointing this out, Viresh.
> 
> You are correct — with the current changes, if
> cpufreq_generic_frequency_table_verify() fails, we no longer return
> an error in these drivers. For drivers that lack a frequency table,
> they can still operate, which is why I wasn’t sure whether returning
> an error is strictly necessary.
> 
> I would appreciate your advice here: should we preserve the old
> behavior and return an error on failure, or is it acceptable for
> drivers without a table to continue without it?

I looked at the code again, and it feels like the current code is
doing the right thing right now and making the suggested changes will
only make it less readable. The two function have different purpose
and it looks better if the callers call them explicitly.

So, I would suggest dropping patches 2 and 3.

-- 
viresh

