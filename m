Return-Path: <linux-kernel+bounces-839263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF6BB1335
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EA4164EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6992848AC;
	Wed,  1 Oct 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kQzgfdmI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C6615CD7E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334499; cv=none; b=Fhy2AnjHPtlKToXDcgNs9Oz9yNr5HqpyjudpDlHrs4lrx4VxoK+dZLrki5c98JVgL5XqhF5IYULCb+BU1nyA+mn4LdZ7p7Wu4C468OAD59unKkWfeqO3DDFk3CFtvsF6Jm84vKJS+UsC6Lw2we5o0vpRcddW3k3hZE3BSO3mZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334499; c=relaxed/simple;
	bh=QScjIjS+08rOjpmvtHUriwdOvh5yhFq6mIStf39uLrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBEheEIdv0B4MEGRmE80ifUwEWC5OMzOvmrNaXgMZASbnKaBJiJDH3WirMZxNEia8HABcP9yXfijRfIu6XWAtCj1MIyeRsnqjwTx/bUFiDHMjxeI2cSpmk+HPXQ0ggTQKJ5bitcBrnUA8IzPJDN3D/A92G8vlGoLfzWxX7Jtkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kQzgfdmI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2681660d604so69423365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759334497; x=1759939297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6IkusvJFATMVxIHkG8s4UMo8zcL0KjEQKMfxIzPfU=;
        b=kQzgfdmI/f3Y1t9TODLCuBB9eDykGno4pJtp/odOKmQfFllcGX+59lOTSlDiYxq/I8
         5/KN5e+V9PY5ukN1z3Nwg5cEyNMaNXDPQeaPfI0i8rtdEM2sUNe/frYQtU4bn5OnNpmg
         ww9TQ6OhH+WmNqUaAmUHHU/nCl7J2MvQCc471kA+w+rSxSz+GBhYC50p6GGXXeMkVa5+
         6BmkqHM4wI+evrqzOnKx6FtCFt8Se/xGQwqRqsv+/BqUIon9LU82S7o5D9jbnOiHWlC6
         VZ65RziyTaDfyigL/cyCmQ+wc6FyIjYbwrrI+MmQkFJz9q1Z2SpODqK950Z7j6G6bTXV
         h9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334497; x=1759939297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH6IkusvJFATMVxIHkG8s4UMo8zcL0KjEQKMfxIzPfU=;
        b=hoUXd0CWC7sxrT6fNmEOy7dqDOHGaj5qeTUjh3+7XuD7dMOi5GIPa5BcTjezjHGhHG
         KcBoInvj0OJLUEDiKlPUrX6V79McAufYYgUzvp5XDfQKZRYeOj/L6AQ/qkrHTbHJxDW9
         FaXdXMUZJdl1oUkWvvK/kkejWZ2BIQkwj9asKShsdIt+Q8qtyS5YG5/M1qdZO1ZKXsvT
         lhQcWi1LCFxYbZotVqga1kXSdPKPJLMvRdLB78GQ+XlhDwtYHcu0Yzq6mumHWccVqBgp
         BD08LVf188vzwrBZAF3djkaPFi0Ki5a1u2vFbc4TPJBG/UHgKBN+BBttbQ4poh9aLYkG
         R84Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjdOPXUOfHkujSk6ZgoYgBmyQhoLL9XwFQ0q8ODd05mI7H/MHnU8ugiZoi2Wlpp3pfb7ajLRxXZJfjVXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthgZ18hDAJ3fLNJ2zpP5mhJoGHdKgKcsGyk+h8rHWTNECDjJZ
	Vn+pAa3YYjDj/s5wszKzzko/W6UJgxjWNh9NVORVUsnelmwvShqILNB0SdS9vA+Gcz8=
X-Gm-Gg: ASbGnctmPhfDuZ5FDIi7nlkxqu5cNsmgoTo3tWYEjHYUF+4Ftk16rLP5dkJKEq92a0t
	WzkbYF4AkB5S66Fa3BleSg+x4nRj7dqSpf4FFvYOCjoXBntv/6iAQW8O9vw1P+O6L99v+Cm4Oo1
	oNMFoIchPGoue/m0Nlw++F8imSD6cTVF6c0jqV7pt2m5EBdl3KFfU+1omJk3h7aTWxHm5RuAP/u
	C/+gLzi5ucgu6GECLVu96dx7nK25aG0FXZuI2rfIKCHDVuytBnMGNZIum/6Jv2sYqYN5/MwhqBn
	8RRb+4TfHAUB/fxpB9+nUUhm2t1owbi/upWKQ+1XTvGjUxcHD0X03nY6I/6F5TdniZm7gWwALnK
	a8iGDZWN8zB7eMBky9lk3
X-Google-Smtp-Source: AGHT+IExwHPQDdMmrUmU/Gt9OCBOCpSUvUeFlozS00WZfFCFEsNWqjNIoRXAmCYpPytPWPAcbS0LDQ==
X-Received: by 2002:a17:902:db01:b0:26d:d860:3db1 with SMTP id d9443c01a7336-28e7f329234mr51251095ad.24.1759334494849;
        Wed, 01 Oct 2025 09:01:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d24fdsm196895ad.93.2025.10.01.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:01:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3zGm-0000000D4Pi-2l7S;
	Wed, 01 Oct 2025 13:01:32 -0300
Date: Wed, 1 Oct 2025 13:01:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20251001160132.GX2695987@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <aNzxWZlWmQMokLd_@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNzxWZlWmQMokLd_@hovoldconsulting.com>

On Wed, Oct 01, 2025 at 11:16:09AM +0200, Johan Hovold wrote:

> This seems to be more a case of developers not reading documentation and
> copying implementations from existing drivers.

IMHO the drivers are mis-using of_xlate, it shouldn't be looking up
drvdata at all.
 
> > IDK if it is worth fixing like this, or if more effort should be put
> > to make the drivers use of_xlate properly - the arm smmu drivers show
> > the only way to use it..
> 
> As Robin pointed out, those drivers just drop the reference as they
> should (even if I'd drop the reference after looking up the driver
> data).

So I wrote the series to clean this up and drop the calls to
of_find_device_by_node() and so on.

I left dart, exynos, msm and omap as-is, so I suggest you trim this
series to only those drivers and rely on my version to fix the rest.

Jason

