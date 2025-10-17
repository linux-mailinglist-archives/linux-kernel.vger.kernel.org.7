Return-Path: <linux-kernel+bounces-857272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B828BE660C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37DB3354711
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E030DD27;
	Fri, 17 Oct 2025 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9mLMLbe"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327330C623
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677945; cv=none; b=C2GB4kIlaUf6sh8b3pM2k+tFMyK5t6d5ahG2HA1R0cEcQNbni7GXxL4bgXj6l9nd/FcIvSwxX6mRzRJa2aIukGmb+M30eTrQqsfU+YGqRkTa1YKwJ020jJmyMtaUfsXofJSXxWfxIBB+vNH3sFLiuOw8aybsQxzvBGq0HeGG3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677945; c=relaxed/simple;
	bh=5HmFIvuXl7rh6yAE6mxlyEZLV01rbipPhieZ9YQXOVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR0NeRk/4BogWP4icQyfnw7s7nQtXwJWXolQ4clVLH8ZKOXSVripZSUvd5Z3k+rKwv4sJGthPW+0WCTQAkXEI5UAWpSFLW0uEoET1w8+rElQzLD3/His4aE1MHU6zECiiFdFhI6IxM1SAS1EmMgigFfk/mYNr1jrZzjc93rGx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9mLMLbe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33b8a8aa73bso1409887a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760677943; x=1761282743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx7gecJVM0B3tgHO4gvhQyUHfVpL0ObYiuUhv4Yc1KY=;
        b=M9mLMLbeWr7xnOX6OthqV/rw/MZ5y8YS8emPZAruZ6BM8cZTzhRLIIXG90XdF0wVlC
         Ez9aRG4953PI9U3TmLIwFV/cy6RGXZeZffa8BdpXucOqyTUS9KVDSME1H46Z1K938Lx+
         LtNwUOoENUf9Ftj/uDXgq0CYnfPsmupvVb6QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760677943; x=1761282743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx7gecJVM0B3tgHO4gvhQyUHfVpL0ObYiuUhv4Yc1KY=;
        b=tpK6wWApIX0qk5l5tVntycl0RHu+Xpp8V+9xtlG278O851zx0mynYyhaokI2BK+gSy
         ysxAsPqMPNAtIVR0rgAoku8phKDYBkIlyoPc/KOnvtptuJjaOdUX/cJTDH4tUwgj2f4N
         sreAkVAxXQstRAdzfFVUc3fChPLATJdZq8lXvOZwrygnwdxOEO8XbSCiOypGKVBPsrpS
         nZmyIm5OfpK15kt8V9k11xmNXyq9SqjzRpGdtqZTx/oeY2Q3x4ZQ39vDtIuKSWAQF//d
         xyPKU1aW6jZOHtku/h86AOdTca7eP5EN7H5b717Ya6wHGoK0xjd8/pcO2dybTnG1+vR7
         v6GA==
X-Forwarded-Encrypted: i=1; AJvYcCU8HDO7m4CgOnicQtfvtKrtsGqdUoXWVMbjvhc9ih5Ykaz2k7dIobONGSHtKHMJbuNWcA0xsM+2TIF7DmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZ8xHMCxr1ax227C7gWhft9T71k01ZYjmCcoDyTgOO33d7Hsd
	Oua5ClJ02kEtr6NmIun4Q43BCWrPVkJxQ13NhyXr/trXflHnOQL/OVNUHP9GkTv27g==
X-Gm-Gg: ASbGncvxjSJmtFAmGFB1zqL2ehmVAKTIYOehvhkGfu/PS4rCl8qrUwiVFwEmdiPTptZ
	9Xk1SfB/ebVvVv+r3v5IssTdHzfY/WPMZC83sWT4SHwb92uaPkzBjN24/rbPt2ekfH3DWMiVVGY
	ZOXKiwLGKKl6vuc2u1CsOLKu7pLXTfMt4TeSzVHnr/RnmfJ7Oo2kTaWv4hLI/sKwu6sMBoWQaQZ
	w6PNg/HK/hmKA9FeMKa0YJiC352rqmJfEArNABrO8yiA5FOXn09gbSPCM5/CK+jIdBpH2+ejdw7
	ZcTYjVIq/zz4wdRdj6CVesiFwNokAetZFuFVvgGXHgDAcE9042WxZr2So4L86GnDIawETPgBKzd
	ES94lLTsmimEt/jfUsM+s8JM9fDtCTuB+gsotQPxnO3reLrLXOh4WEH5wo2XcdCqFIOyU2VjlSJ
	TpJdVqouF3oFzsp9/EXU78QFHh
X-Google-Smtp-Source: AGHT+IHMSNNWjuMVf6ka4ZRAthIkCQkaS+3tfv60BOFg4hlZ3TU5YeQGrih/jnEx7KdcsWc9ynXdTw==
X-Received: by 2002:a17:90b:2d8f:b0:335:2eee:19dc with SMTP id 98e67ed59e1d1-33bcf8f94b6mr2535744a91.28.1760677943281;
        Thu, 16 Oct 2025 22:12:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd78dff7esm1409370a91.0.2025.10.16.22.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 22:12:22 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:12:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosry.ahmed@linux.dev" <yosry.ahmed@linux.dev>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>, 
	"sj@kernel.org" <sj@kernel.org>, "kasong@tencent.com" <kasong@tencent.com>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v12 14/23] crypto: iaa - IAA Batching for parallel
 compressions/decompressions.
Message-ID: <rbl5iuovk5xd2ed5ip4n6mkh5ad6d52ygkqlwbehu3rm6awkn6@tswgallufq4u>
References: <20250926033502.7486-1-kanchana.p.sridhar@intel.com>
 <20250926033502.7486-15-kanchana.p.sridhar@intel.com>
 <aPGXUxRZeYLO_CUo@gondor.apana.org.au>
 <PH7PR11MB8121C3BAD72D03573D6B4951C9F6A@PH7PR11MB8121.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB8121C3BAD72D03573D6B4951C9F6A@PH7PR11MB8121.namprd11.prod.outlook.com>

On (25/10/17 04:04), Sridhar, Kanchana P wrote:
> > What are these for?
> 
> Hi Herbert,
> 
> These are for non-crypto users such as zram.

I agree with Herbert, I'd keep zram out of this discussion for now.

