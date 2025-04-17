Return-Path: <linux-kernel+bounces-609302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B44A9204E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 16:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8939619E8254
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6842528EE;
	Thu, 17 Apr 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2hvLYvtj"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF21ACECB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901648; cv=none; b=rc2fINd2aXJQTzBeLRNKsyh38uMDJtex9Sn3kFzB3SD9MuWR0SLe06vbm8YiwhMHE71nZx2Sc18ZaCwD9B2EHSYZWmutj4m/jAX8Gp7IUo4L18ljvnMYTu7LLNbkX7xccMu990/Tht9XHmu/WlB8IFFurrFlRe0XTyWe2mYBzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901648; c=relaxed/simple;
	bh=y6Qdwi2fYnYO3ZDvo+FJR12z46j08PUlYp0fEVJVKJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1yarPYy+DMUf3SmjitqoJv6I2wzk7rTTUVaMc+ZDRtvIWQM+IH8GZr61YkXHRHeAXvNwafIpswMI6UOyrAJnIJPvDsOHZKAx6E10JvbMtj4Y8A0jzY6YsmJUfo/H5c+GtbXIutgDxo9UXY6+wKUobyAmMk0r3dkjWX8eWS+WFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2hvLYvtj; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4775ce8a4b0so13541291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744901645; x=1745506445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afIL/UiXUlFmHWbCDZq4bWploUK8mvFskJm951QNrQ8=;
        b=2hvLYvtjOBv8vXQJA0SPbdipUsOVKhtjTdU2m81yKA5oA9ku8/1Bfq370WyAHMbEFJ
         qo5h1hcx5CphXaXSumHjM03DM9JuoHU2Sil5cgNIgrQJf+l09ZKqONIp9EEqm0mBnr2g
         DZvHBmInvN5FXEy6UuDvsGR/w+JS/fpUdCcGmqi0ZGDXPOaHuN0yf7fUurN872jpm5bp
         hGi3KQOU7vlZk5cG1ZrbLP0ipJaLVyRR+b5aUlDb4ALOvQRzewFMAb5GLhUpSW1hEVTn
         hiaGl4YQ6NbCYjdgsZB9JqInnwMA1OExexMglt6xYn/Huwd5v1ESkQNoj/kizH8nMGXH
         80qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901645; x=1745506445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afIL/UiXUlFmHWbCDZq4bWploUK8mvFskJm951QNrQ8=;
        b=kmN7IrkO0EkItWd1ShtHk0tqJWmkJVzkmBYMCzjkkYgQ+otHzd+lLxg9mZeSE0gmae
         3q5QTkkbh2PsH4kndtp3ixkOtxjKrKGG9EpYZCU5NhF6BS+Bdn4OOoeniXIi61Z/vmk2
         pFydXFqM8gqVB/ii5EmTbgHYG01Il5r23ozeUR259EiHaQaNZM/JMCnpcFGbqGV/Nk5B
         ANYE/CpGz3hXCwfZEnAb1YCc0ip5+jbVyM8BZKfuKtHyEx9pbDrRG5SyvsOo2/FZRjsv
         1+G0VcphqAUrsiwmToBW0nYdr5OVL6y6fyieF6ZcJBzSC+aKG3sDT7KdJXZhaLpRS7Ds
         ES5A==
X-Forwarded-Encrypted: i=1; AJvYcCVcsvkz5D9N/R0a3V4kmoqNFDnS2aNatuoT3wTWYhH7xQmHmM2+Y7LQ88NcPCfSrsfoburS6i7kjYjxNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25IDz6DlrJtc4NemqcRrOYyEgx+csnEQMk0jy5FAJiq7oPf8S
	QgNLNlwp0rQMt9isXtOx8PJMJ0xNcB+w/bGLPdFUWz3H5m4+aqT9CgMNRWup6mI=
X-Gm-Gg: ASbGncsV9/4rtFSnncbZV1VZGgAB/NJdLrlmXp7M/yZxF/2dp2TKAWelTh680UtBgsi
	znibyFd+8LXsnPVKMNwhMRa/12E0V2k+B9NHc2hrrZ8qNvEWDo6gdZYQ6dVsGkZ2qbsoVktATNB
	G7PrNnzhL/cR5+0EcNND35fHmxN4yVeiDzeCDNhC7iRmjGhH5YT3UcCOwiCUNNilXjNQCUieFRA
	i2GOUVIq0/lxsUy75GFxFpw70XWja/dNdZCMXoYX55EAPEScc5j6B/YoociFcSCbBuVEqNX5GiT
	g/PNUIh5fKRlZsdEPJsuFznSsqeXvA3IvaMEAJk=
X-Google-Smtp-Source: AGHT+IEU+XimTfphBnwnpBz5KDBLi0B/ZA6zQlSXL2AwZKrTMTjVWTzfNzzazFeEPgvFvBFjvH48xw==
X-Received: by 2002:ac8:6711:0:b0:476:bb72:f429 with SMTP id d75a77b69052e-47ad8119d76mr76603021cf.42.1744901645475;
        Thu, 17 Apr 2025 07:54:05 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c3299esm49721cf.17.2025.04.17.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:54:04 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:54:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 05/28] mm: thp: replace folio_memcg() with
 folio_memcg_charged()
Message-ID: <20250417145403.GH780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-6-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-6-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:09AM +0800, Muchun Song wrote:
> folio_memcg_charged() is intended for use when the user is unconcerned
> about the returned memcg pointer. It is more efficient than folio_memcg().
> Therefore, replace folio_memcg() with folio_memcg_charged().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

