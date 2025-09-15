Return-Path: <linux-kernel+bounces-816699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40AAB5774E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BF63ACA69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D082FE05F;
	Mon, 15 Sep 2025 10:56:00 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402E2FB984
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933759; cv=none; b=Vp2liu71ioQuFpYRte7Pz9Mz08Sj5wmh9XmClux/GrinA52s5KMuPHqAzTdMZ4+xK9tU5LPh067JM2JZnT3YZABf7vgvzAtZVOVnaTIrZVPQM6P7hBdugpcaNjmIQugg/gb2wDNys7j9u6qW2r7+2gwq7aYYy9xVCHCkKXJdShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933759; c=relaxed/simple;
	bh=GEJSgsO5Z2xGs50BWLMifrD/+7zn62SbW5k2WUWfB+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf8L8m7ecv+w5LAUAcOEkB4PTOghyPJxcqE3d6WtoOp3nhxN6Aw/NUozLL3zF3nUfYunV9zZ3Kgs8OAfjITh2bvobOqFrDom/Wx1vCYixW7fLBQkUuegi7KOM8dDvDY+as6oO1dfAL2CzRNrxyF5MfweLrNWpz0i9/e+nIowQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042cc39551so677954866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933757; x=1758538557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojo6oKzvqX8/j4uhWlFtqoPQT5IbRZtxXM8tJo4BfVE=;
        b=BPLWDqsy1+XzyoFj+AhP5zy7sFqGXyRKCy54Hslv7Hxlffcxpsa4ONyLvuOnGXYK0i
         DiLnMpYzgIf288NNw2PL8XxoYWXQKTTa9NMk7R27N3dNkHa4MPAN8Ld//WN94JSyJVst
         REx/TpiWO/2O1rTILku6+omMQbQylVfxNc3kNhGl5hOOz3S8RoiBCRNIFoFtKApEgOpg
         miL2HQ8yHK/Qh8L8pmkL1Zxpa2+rPWToEmBeP4R2lJyBqqSTr2KlPJNOivN0PACAoBfo
         NQE8cMBiK6pCUjHJ0hoYVan6fJ/bdWDNrgSSCeJx13fsoPrU70xQ6cunr0cR4Fo0Bi/6
         TTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUUk4vV3zElBR8V1xr4KdMAW9ZuTqOQscuJ/wiFTC8FasTDOEXfQ13GESwcGdgT0ZCFWUV1Nv4ZXGCDsLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9z8uV50VfVuFcFIIg9FsUTXDjP7O9DND48SpXfP6RZdascTmy
	nUR/KfloadxnAZO6mXr3exme7mllFRWfSnrqJTKoac8yeRjhGskZJ3Yj
X-Gm-Gg: ASbGncs2GSdzr583F1qpkM9q4VsMH8R7XmlAtk9W4hFEErZuTvspk5TIK+6WRfvfAoJ
	hXpX2qXFsv2O0i5e4rvZAr4CtiA+XmaD4BExiHj/RJyTvr6FTn5vRenPlw6hueu6LeKnZXfcDe1
	2V2PN+GpjGh/9MWgrICt6MTfQ8Sn3FcpCi1ywpBXzwhc09KlPpClfV72lGnRO9rPSo7jfKw8qw3
	VjrjOK7JSeIbU/eQJ5EkhDXaRfKYzmrbW8GzNaqQORhXHQ+p0qCUgfV7tH07hDdIjWb5bzFdc6g
	b4vGWMB3hiw2FcR6XqF1cMG8tLWrdUwX2jP/FO0PQdyJ67VsQkZJmlXBN9w9TLpN3a5TxI2E85m
	wslDds26NTvFN8r8+1p1Pij0=
X-Google-Smtp-Source: AGHT+IF8ft3JrAFd5dlXi0U7soWJ7mf7bjTrn94XFIguC2L7TjKvuFQf7Q0Ve+zesz+ofCw1EhAFPQ==
X-Received: by 2002:a17:907:8689:b0:b04:84db:c83 with SMTP id a640c23a62f3a-b07c35ccf80mr1242336566b.27.1757933756489;
        Mon, 15 Sep 2025 03:55:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd601sm917014366b.60.2025.09.15.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:55:55 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:55:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>

Hello Lei,

On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> Hi Breno
> 
> This series of patches introduced a kernel panic bug. The tests are
> based on the linux-next commit [1]. I tried it a few times and found
> that if I didn't apply the current patch, the issue wouldn't be
> triggered. After applying the current patch, the probability of
> triggering the issue was 3/3.
> 
> Reproduced steps:
> 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 2. applied this series of patches
> 3. compile and install
> 4. reboot server(A kernel panic occurs at this step)

Thanks for the report. Let me try to reproduce it on my side.

Is this a physical machine, or, are you using a VM with the virtio change?

Thanks,
--breno

