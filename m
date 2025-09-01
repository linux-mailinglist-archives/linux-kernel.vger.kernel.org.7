Return-Path: <linux-kernel+bounces-794215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE9B3DE76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71261A80A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E730E84E;
	Mon,  1 Sep 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JnGw+/ee"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977130E824
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718754; cv=none; b=uFasaZSQWvJuOgIZlNYr5gtEmf/u5bz+c+p2Y1PFnPDyiB7Uj+6yF4yJpuyj86CnJnPA6qNPphDUIhK3L7lneZpY5oREg2sYBJk6QFkgeZbXiPpOIe0KBCI5gsI2yktGZn15aPBITlbBIPXXxf1EbBhD3q0kFYfoXkaY44gSbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718754; c=relaxed/simple;
	bh=OfCtjCeji5QTOGG0VnIXm2TGKggGPa1xLAugRo6trh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KML2pO51xd6jqYDQHCtjPpGrR9gWcpPa6GjoLvcIwzQbdADk+8E1QreRBfhmhkzZuyMX6rOE4TToxsKnpPHktO1lWgbOf8JjSXVkXLu4y/GbCCfzu6ir0+4egUuJeqtZ/6PfQOIC8DP+i8xFYleZGS82TL40x3nOT/m9vPpn9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JnGw+/ee; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b869d3560so14743895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756718751; x=1757323551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoiamaT9JgY6KY01GFvVf/2Zvff95izr/pO7afYWIxE=;
        b=JnGw+/eeT9GOAAeHN9/ae99UtpMGA1AcUnwwTneMkhnQt1+oXLIpOSRp54WqmkbqC5
         3lzw2lXOW1pSQIbB7UTNTkyDEIbRo8RsalkemR52eYRkxz9GFc6cs2VD5FoHxj4C400K
         o4wjLYmuh1IMd3MTa/ubtwoc2Dq6MI5WtZMmphSVmM91eFXnAypWmq7ANFhOc3pgZkN+
         FGpoR0N8MG7VuR3et3aokjWMnyyRvawmjSLFST7TmXJegx40U5s3rV8cZE/wlh5nz4M8
         MrVg0oHLuNnFUQTNcuMLPoF6DgB56RdI3wgeHQmvJasY3SDHtAkrJM81pHXv5AAHsQss
         4FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718751; x=1757323551;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoiamaT9JgY6KY01GFvVf/2Zvff95izr/pO7afYWIxE=;
        b=p2bOzrWbH/z5KJQzqvR2K2AbsmQTpcIQ26oaiSCAhN+Mh87hT6LRYeF981tO6HoR80
         +/FHGlXkleb5E5Pl0PwyhdlxiR0hLMjnYG9yWTFBHiBw/dugsfWTXv5i/40U/lFNDYpa
         gXxmcXko4XDH3CugkdvXDoXyTsrj7GjZic/QdjDtSJs21Sd786UWqPowCnyJguoW8E2n
         tnFj2QnLP5qFHlQMFpSrDn1YmnGA0UpxnIzpe1GapEOB3BZZ+IH0BRdKJkbilDEJw8t5
         lb4MLFmxt0fuMMnsbbOnd7nfBRC/I7bCIrRbiHKk6V/bmCH6hClVWRA9DFapipqswqBW
         PryA==
X-Forwarded-Encrypted: i=1; AJvYcCUlS4gGEb44tUxyNH6+zAR8oGM6CZCRUPytIDE0oTJ+P+35lX9YDp7aOjdo5pmlf2jXhXDhuk3Aeh2Ok+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFiWYCfqGF9dO6cZkGjA/ln+2kZoMD2YEkvJek/A9WDHb2584
	rvJ8Qqup+joS4/aLj8tA6r/DYVRvbEndgNv8O0Zo0hfMI0PEuouQT3Tdpw4Q1qStpYg=
X-Gm-Gg: ASbGncvB/DqoL904NRuzbQJ3JiG4QGIHgkSIaSlH+6cKPY9hXY76T/+dwLj+PjDAUyQ
	xTor5cveLbNn/8Ex+j1wr64shDmoiQwfuWU/fG55bsAdUH9oUArjcI7r4YP8TSw84JGySQNfBDb
	TjePDJ3+LGcHQTZGfUwVvn+LJZadil2HPY4Y2185Q75DMHFrjSEjhE/LITgryVh9oXOi2Wx4UVr
	znKvLth/xk/8tKC0r3GLyn9tQVtMXY4Ayk/9I6y1OZZZAhl+T0+PDCK2GvbnGZfCbv89HJ6TnF0
	1G9Momxd1uWVOLJdYE7msLrklMht13LW1eZo4j+bihRdN9l1P+6kSubAi6JyDD/YFMwgAMfAbRH
	4+ubaBRyRqiyP069vgB8FCFseWvklZ8E3nSehKp0oKb/p8ogppwL3gg==
X-Google-Smtp-Source: AGHT+IHNrzuP8R939dOcQ5k1bvyvLjPnEFrrxO3rCXhWWgMPt73dhcOA1D6sgVuJ+j5Ee6BINIieYw==
X-Received: by 2002:a05:600c:1553:b0:45b:7608:3ca1 with SMTP id 5b1f17b1804b1-45b8c90299fmr23355035e9.23.1756718750673;
        Mon, 01 Sep 2025 02:25:50 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d520eada16sm5713645f8f.41.2025.09.01.02.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:25:50 -0700 (PDT)
Message-ID: <bc8a9fe6-5563-4873-a524-cda92ac1334c@suse.com>
Date: Mon, 1 Sep 2025 11:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] module: signing: Use pr_err for signature
 rejection
To: Jinchao Wang <wangjinchao600@gmail.com>
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-2-wangjinchao600@gmail.com>
Content-Language: en-US
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829084927.156676-2-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 10:49 AM, Jinchao Wang wrote:
> Make module signature rejection messages more visible by using pr_err
> instead of pr_notice.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

