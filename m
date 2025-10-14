Return-Path: <linux-kernel+bounces-852958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24781BDA579
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F8584388
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9086A301001;
	Tue, 14 Oct 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsdQu+M0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314F301000
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454931; cv=none; b=bwyz02QicOkePtJs45kOe6Ljg054x9YzROEWVkiWBMYpd2U0g4fCpSobeX1G4wMa4N84ffSSWpIeLft25iO49onlPOSmFWQr1pFEPiUYlmz1nbtmIE/fjormg68foY+ezpoAmoTZgtFGwMrFRkBKLweawgQUqCN53E2ecIpriKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454931; c=relaxed/simple;
	bh=O4un/WoNhEAplHVosH+Aiv2Xzjf927LVhRMRZoUS6hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eItAyVyAcyCL95n+2WGhzh+jaCZH+vpSU7MXRgdwp+qYpuD6wTobxLpfVJub89WCc/vxM+9PTPY/z9DodxzICF1YlKwmI3Ft/+dnu4BnukGaw8PGGZhHa6zz+8biI3R8WaAPuWP2ICHrrORzE8eYLxMEO0iOlYoEmOiiunTEvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsdQu+M0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7800ff158d5so5144327b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454929; x=1761059729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiOXvz3p0iDVrGhzRlMs5DQgf7JeJiwBe95U5RWF0Dg=;
        b=CsdQu+M0CwjN9qg8/L8I08lcBBnKJc2FbbwgpePadFlqLBYwt83q2SnX0tHN7lKxYO
         AMW0C/Z3pagC5lmoaB+8qzE9rDx7UkaviSFrNN9iXnY1y955QRx++aQmGlzf9GQJGbAy
         tq7fgi/hKLB7jprkanLbGLe1oKS1yTmR26eYzcx8M6hXtLWbhzTl2rt3mq+BZBxaeDgU
         55fZ77ipyqYRTIm4gjtLa/sgE1MmcGXS79LGKfQ5ajhqF6nf04jtKBMDFYNdtK3TTTS6
         iKipjHwIzqPuqmWhiX6tqrNN1W3wn2FEod8+TrKbU5dTwYkuCB2t4X2hVJCcJrvpJ8co
         QjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454929; x=1761059729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiOXvz3p0iDVrGhzRlMs5DQgf7JeJiwBe95U5RWF0Dg=;
        b=oB0GvisiA1Mu6abdFwyAvr0u456Zbke+oFzmQHpHdiG40pOxsKzEZafL/VbeaKSFOp
         wLv1kDFnSF2lou5qnhyFjsDTwasCgnAtV4Pr0agpV87hZIEnhu6BqmQneNtAeE4r+j+/
         n5TCjV/BOV5nir+/3za4aD8PwtMrRQknbpmgnTSGTBIATT70V5T7iFf9eCtoCq1Fu529
         4d5HEF6GBnd7b/lC0u1Zv0iol0MCtoCCc/8QYPEvZrgJ06TvCWaJNyaL3PwoOKcAUjD+
         mebseh14FY633ix9kM+iCQqmkmtsgWEhOsqiXU9eNLDnKiT4f/euBWGHOhARWnshfehg
         sqxw==
X-Forwarded-Encrypted: i=1; AJvYcCXHZl6pGo7BEXq60pdKBTwwXnoY0EqAPkFBefodiMci3WOVrB/0QaRl1Hc+3v7o5+z4cmRPeNIllI/vQyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7HlNqAHNe69SzE0nz533vBvgPTqvOedFtvtUGZr8jiU8YtRh
	/wWYeg120tutWDPWQSuviIJSPnMkGX6T7F6bZjrkjp9mFdcVLjVmotmX
X-Gm-Gg: ASbGncuNeFx7BkuBoL/i65ebTeNJw5hpIC6c01s/+mxpsmDCmOWltiuKhy7KJ5N/52n
	OTZ1rsf+b/jyg7FPSb5Fz5LrlzMbrH7FIlE54eBnFwO2oWMPmijIxbuI0tj0JVx6CvJcpphHT+q
	s5xhJ6KH52+GWXuIajw1cfsQlcbXP5iGBJmoxovsjtAooYJYQPLwXN9bElLYGF31uxINTS6/JOl
	mfNdii+QSM3g7xgFJm0PcfqfUknMT3RxbBbGDA58Y9ARz+P6RAfEtUzeBCCuj1elLNb0D9Yq2bU
	tyvX4qDmwPn17yuxt2bw+xC9ecpPLbF9KpX+R8Vlh/NHDAncEun8YjntIDJZXSoRl90cUxbzCno
	vhHke4P4d2TsIOtBxBZAcJI9Rr5ZZI7Dd4pZBMeCnmmmoV65DOY9XEop9YNeMSJch
X-Google-Smtp-Source: AGHT+IEI0BVlTm9byP6/HRgTG7Oom2uwO7sMtrezChPyLSYd7pcFGMnXeS6UjCq7pllo5lsSGFSN9A==
X-Received: by 2002:a05:6a20:7351:b0:251:c33d:2783 with SMTP id adf61e73a8af0-32da813ce42mr33664357637.23.1760454928710;
        Tue, 14 Oct 2025 08:15:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b7411fcf0sm10258315a91.4.2025.10.14.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:15:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 14 Oct 2025 08:15:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Convert apm,xgene-slimpro-hwmon to
 DT schema
Message-ID: <afaddcb5-09dd-4a34-85b0-3c9ea8dacdc8@roeck-us.net>
References: <20251013213127.692373-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013213127.692373-1-robh@kernel.org>

On Mon, Oct 13, 2025 at 04:31:26PM -0500, Rob Herring (Arm) wrote:
> Convert APM X-Gene slimpro-hwmon binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

