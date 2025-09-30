Return-Path: <linux-kernel+bounces-838044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA39DBAE4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8619F3B1FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBBD1386C9;
	Tue, 30 Sep 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rgc8lNNB"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD62264AB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256561; cv=none; b=cH66AOtUX3RypwIWkl+NbXU0qnbpi3gF4IT9F1hBjMLQj9AJ4ax72Yx9hSnyEzVC5wzfhAZDiPmlvvMa970OjLn0lA9VwIHq+dRNvwtTs+zTf+9N5p+Art/8NZgrNzwkgFs9TJErO/cI3hOcWW8WzHQ880U90ZNkSRKoWDX6A7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256561; c=relaxed/simple;
	bh=im1LjyWmm7IGGRLU39cMjP8TMhteoUNMVyPehrlCbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa7jY8WSzBRpm4Dk0mGrn0n3PCSkir6AXoicfinneeSvhXcek/gkJskbsDQgvIquO6fOb4ZBLj/gNmKlFWIh6Ql5RG0MLT1X3gJUXxbGebwIsyNO99p5Tx/DLRqQXUy68I2yVvcTTd71/wIYfhtdrk772hLe9fiandGSfNNVO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rgc8lNNB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e2d2d764a3so8900971cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759256559; x=1759861359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otN24sD9ba0651HU7vyiOrWLd6JoFW5Z7voVaID++QE=;
        b=Rgc8lNNBFvS6avuD3CiPDmSnBZ5M3ipqgxcBYom/5/rHWxq0kS5qxnvwPqu4l/I8BO
         rXrsgjUboOaGISN71ioiOnTS0LwQWDFZyjWWTSQxRaj1xY14mJgaiwvUAKhpiQlUtkjK
         JT6gZwYAuWC1c32K2yAX+QVggQEXfOuLr+afYi3bFvZqHAcPLs7A/8qIkwdDF5E+/My0
         alEDKELPHq1DmVFzGiosK4E8lCa4IORa/Ml34m2Rg1YZKdJ0fAXXZpW6qbMx3foeNTr2
         LGzihb7RipvyoKyn/wv3YCsH8yNOQpxOGD+RuHQAH4DKNn2PjHu4NaGoFowrMeTtnep/
         0WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759256559; x=1759861359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otN24sD9ba0651HU7vyiOrWLd6JoFW5Z7voVaID++QE=;
        b=BhijOgvooMFHMkGAwqziJFdwQgyAYfn8AE3atf4gSUGkc3NfcQ1UzNRZaaPBrPauVZ
         w2CNeiiqwEajo84ijYTvf3KF9x0VrIJigWM0u9wA7H+3F1GJxnM+udkDZSpNbc1Y6HVL
         0YVjAiWaNCmnh2fTtX4DJd9pwfnI07VIYViVujNtlc6m+0sAXNaqp0tx3uC2POUyG86k
         IbSA3UbkSGfCb6q7vAHCfsYgBQW47KSp/mPPXoGEl3vsuu0UdCGO1snJhb1mt2Bavzjb
         AOsP43GmZ5rHaSTKMNNu6Vuq9uJfGTQ8R7fTZfKigjdzwJIqJMZ/8Nje+UU18Cq77qvW
         HCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ubXfTuqS0ZCsvNSwqs2pF+/R6mVna96gHiMMqGEzBVc0DcpxUGUPNtelhhxZdSTWkGpD1M4/4TxYdEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQK3FJ2c4OJA17e7oJtClFDmOrhwj+CW3IT5oqaJSH+qy8z4Ys
	Tdq82PLYqRKuwqsnnqN+K9CE2u6RUv6QQ0ccxXmX7WHUvgL9+/f1/T9QeMHsj+ywr2g=
X-Gm-Gg: ASbGnctNawN8AC943AdrhRVuNYEt3jPHueaHUd0+Cx5HYEO8JQjWmtUfO2GEf5YWJsq
	AePQ8vyDxFGS4/q88mQMTSAHvHtzFratxHcx/8jIxIAGGkVk2uQgLf9OnfhgDbiS3WWwD8ixNdU
	vI9JkzQY+zDM8PYqUxdnjHMxswQAQwryYjmyxDL1nRW61NcqIJFVvjH9/GqW1ig7PO3olSepSoT
	Rsj+65t/tywpsv1ZHPM2NSQQrYJL81KSg+rh/BpoR1x9W+ST8ykU56g8A9Y2MEOaiLZuG2ZIqAz
	WXVKWv1r6vLIxEu6dgph5ClgLnidmUeplD0tuvcbEaN9sL2cS/70AmQZ2mKpROCq3ZVnbNyRw0z
	cTcRzazdIgnmRUCQ/QqptwuDviyK5+6o=
X-Google-Smtp-Source: AGHT+IFdQ6HxqFf/rsGHSqMtw+RYaDUIz92vgbk3h3uGCuph8KkCY84Ws9PRWpUgzYwvFtXBvKPANA==
X-Received: by 2002:ad4:4eeb:0:b0:766:769e:8c8b with SMTP id 6a1803df08f44-873a78f2c46mr9259176d6.46.1759256558992;
        Tue, 30 Sep 2025 11:22:38 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8016e952d26sm98259256d6.59.2025.09.30.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:22:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3ezl-0000000CgRf-33ag;
	Tue, 30 Sep 2025 15:22:37 -0300
Date: Tue, 30 Sep 2025 15:22:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] amba/iommu: tegra: enable compile testing
Message-ID: <20250930182237.GT2695987@ziepe.ca>
References: <20250925153120.7129-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925153120.7129-1-johan@kernel.org>

On Thu, Sep 25, 2025 at 05:31:18PM +0200, Johan Hovold wrote:
> There seems to be nothing preventing us from enabling compile testing of
> the Tegra AHB and IOMMU drivers so enable that to increase build
> coverage.
> 
> Note that these could go in through separate trees, but compile testing
> of the IOMMU driver does depend on the AHB driver being enabled.

Nice!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

