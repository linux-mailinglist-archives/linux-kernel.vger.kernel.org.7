Return-Path: <linux-kernel+bounces-810664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD3B51D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1942F174D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324E43375C9;
	Wed, 10 Sep 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cizFS0WC"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE632F776
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521395; cv=none; b=EhQIDBY29yTMhiyDHtlxdOEd91S2j1kWYq9veEzdJ0vWqJdp8mQlU2NZYQKnlSAqdt+5tNqI9xDQS1hFRo8m+RnaxDWo8U5B0Lkw5jyZsgy7+MCK5iZl/F/ZjwM8PYDvUf+GdKjSgooNOjK3uCiFd8BmMCYjUTHoTfKYPws85TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521395; c=relaxed/simple;
	bh=QV4qaVeduj/yREU+BcPgw7XZ6y4Ontzbperd5ZjM2FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maDZQ9FBjF2uQnXXPRFux3JdmU8SiMJRD+J/xTs+nhfaGy4JZ80ybgF4kGPdmGcfBLCFCY4IBmHyUh9piliVrJAj7GWoGI8kguOMwQpYtnDq67l+cBKqon+sFKvKHmU5Gj5yPmnZghw3pgeQnDjSLSUUUnLsXn47DqMISqW7Tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cizFS0WC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-723c971b63bso52959806d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757521392; x=1758126192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FwkMlW01VIxUYcm4CJlAUCNZh7Z+O+5WtmWOGwJI3A=;
        b=cizFS0WC8vRAcl0sPHOePwmP9NRrSK0I0cSA0sybqtf6Kk+TwyRYi5NoV9j5By68vX
         txqZjDzCNnLLtjUFgNbLZgMm2PIEjb3diY59e9Rv2MxBfEphYCDYW8MJWJd/Yvco04io
         asuKnCZBaDDJmwvrjjT+CLujnF7ef/g7piEI57c/hvpjvo1XIYz/xQ/MhiBFBhthL4JW
         y6OzRvwKT7STEOcg+M1UZj0/9eKXrcws622boCjDTg2QZkviUxWDyaW0lTu4mZU+l/St
         CYe1jb5r7dMSwcwy5Hbp9dF6KWf+TKAlk/WbJ2r7vHd6ks5+t/6u8rbwR1jJMJjRjM+o
         I8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521392; x=1758126192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FwkMlW01VIxUYcm4CJlAUCNZh7Z+O+5WtmWOGwJI3A=;
        b=lIAi+y8U3dJe1e8T8JvAnUQzJkdATOBC97GEjIzVohXl9ulaiXv66YEUhYDIKFb+WP
         Oeytp4wd5VfQzNfYoGhZVoBHK+qXRpHK3Niafgi3NuIV9TKUfAs+Y6KbWfZnHB981gOv
         YvsnocB7Tchcsrl1e+/0h3ZkbKK5lEb9UUoUgijh8TL1X0dGCaaM+QAhZVQxihDL4++f
         LyNq7drKFKOkguH6wi8r/XHqdeXtIoG9TGveVMvoadhElzRljrqZcPCNSiZQjsnoesyD
         lKKAa/RGg/h4J0eAkRmTCrQxR21ru0XH68H1b1AihIrWaLMT90rX3hth5iSOw8xh2z6t
         8vqg==
X-Forwarded-Encrypted: i=1; AJvYcCVwFEuNJAoTxT+tnLYtEhaOHf1QDJGF/P3MRoZ9vzhSIYgIiVTc4LwkGDqk+PdlfSuYGlq8oRkmC1uTU3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77Aurf6y2wAeeWuGmLZ1z+Xxl4U0BYLf9sgI4TNm7Q1SIqkwu
	YTfus+91g2Juxzy/brhCIWYyYKd/amM0UKENHLfIFY9AWVfRXRYveR2+FC2dFsxZB44=
X-Gm-Gg: ASbGncuaY3MXUSWVhTbw9Ch4R2oq/9Qo/rAlgJtNIiPseVJaiJ62Mpjj/DZHhoHN+yA
	ivZuZqhlLl69EthsvltF66lqB7Vw0UdkXxnY9Dhbrpo+/yXbvvHSMwsBkYEbkuRAJLlsu65ZZxN
	B1T4EQ2k8x5UE4gEWL70PJ13gglS8657ZkymJVbvDWslCQBo8Tv5L/e5YhDu8iMjLNBy2K/ImPp
	hpVBzeYeWLJay/nRNrK3pemRbRO2FY76Jr4bSWjaHeN+lZxRkBIHXajEunsW5s17V0RWheM50xK
	hypFPm6DYRSUFX+/KtSJJ8BzSkbSNBD1TfsPStWkjV7X8GtKbnfTnYDSAOUlZsSHN1zbs4Rq9DG
	T5r8p3vAnmWsgK5JAOeb612VJNDg/NG8mBwfdB9OMXCbbX1LEhQn6IxuZ2pCqtwlDEVZD
X-Google-Smtp-Source: AGHT+IHPGap2dCYWlJBOrKoIpqhzx0hg0+yPsTujjfLJBGMgHZWbcQURT6fJPbtpQWPkXIn9zn4B6A==
X-Received: by 2002:a05:6214:ca8:b0:747:b0b8:307 with SMTP id 6a1803df08f44-747b0b805a2mr108386976d6.26.1757521392357;
        Wed, 10 Sep 2025 09:23:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm150161886d6.54.2025.09.10.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:23:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwNbC-00000003tad-1XQm;
	Wed, 10 Sep 2025 13:23:10 -0300
Date: Wed, 10 Sep 2025 13:23:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Message-ID: <20250910162310.GF882933@ziepe.ca>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
 <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
 <aMGkaDoZpmOWUA_L@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGkaDoZpmOWUA_L@mini-arch>

On Wed, Sep 10, 2025 at 09:16:40AM -0700, Stanislav Fomichev wrote:

> > +   * - ``num_doorbells``
> > +     - driverinit
> > +     - This controls the number of channel doorbells used by the netdev. In all
> > +       cases, an additional doorbell is allocated and used for non-channel
> > +       communication (e.g. for PTP, HWS, etc.). Supported values are:
> > +       - 0: No channel-specific doorbells, use the global one for everything.
> > +       - [1, max_num_channels]: Spread netdev channels equally across these
> > +         doorbells.
> 
> Do you have any guidance on this number? Why would the user want
> `num_doorbells < num_doorbells` vs `num_doorbells == num_channels`?

I expect it to be common that most deployment should continue to use
the historical value of num_doorbells = 0.

Certain systems with troubled CPUs will need to increase this, I don't
know if we yet fully understand what values these CPUs will need.

Nor do I think I'm permitted to say what CPUs are troubled :\

> IOW, why not allocate the same number of doorbells as the number of
> channels and do it unconditionally without devlink param? Are extra
> doorbells causing any overhead in the non-contended case?

It has a cost that should be minimized to not harm the current
majority of users.

Jason

