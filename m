Return-Path: <linux-kernel+bounces-817875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8EB587E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CFD1AA7E61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63BE2DA76A;
	Mon, 15 Sep 2025 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KEAGgYt8"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA61286D60
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977091; cv=none; b=GmXsTaEA/k7/253eBAkLstEO0RZmMv+9hMAFSDUGXymix2s24t2tLF/aDSNEhICsS8VHwO8osyW6FP2OnxIJ0gINT2Y5cfDV3sYygmRI3OHD4ZpshXmWKkIkw2gdx5PorapmffJaW672ItNG8TwEaOQ0E5qyTKocnkc89y5PU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977091; c=relaxed/simple;
	bh=wrK0nRI1OFbp71bXaT4X7O+VxQvKh8LBne/yxp6bWq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt6hAEHkwf35zbWZrZdHlxMTF4yDpQT9kKA5ejTM1kH0zFNLllNkuVBCWS0YjdEIkgCMwWMs+3nhh+OeWcjXiYGdrOVi8129F4wi64IIaNYVFGq1YlKfmhxKBHecT0sMye8hsL8wHrIdRWOUr432ipOMSFt0i7lPtWvIegCw08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KEAGgYt8; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74be52f5447so1871286a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757977088; x=1758581888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kB/Wi+cRe7K/Xl4jkmaNXOwfB7KCAKUI6vYOHIxWVl4=;
        b=KEAGgYt8X10JnmMsTHB6p0wyqh8oaZfbiQj00LhEO/YlLPOcNvkEeV7a3tJbpObZSG
         JL5R3qjyVo5pvdmRULzN3TdK50LwaDJQKBPePMEOPo0RoMoLiSrEPdyt5t85tkscY8ok
         Z1YHhG9Av55bBimcNiCXwQFpyJHcpVp3QoCE2cIxFpy2c3IT8dHawYeR9SatdTcPhBmV
         jcu34QTeZW4oRB0NBzdibGmiVHJzfiCFXkZFtNryO7y7IrPSefYFiQLpAKXYXErJrVQ6
         H96vBhBvC8mu/PI4uoBUasTB4NFJdQQ2Xov1lyUmhDzN9gTCM6E4kM0C2fpo52dVXelJ
         Dt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977088; x=1758581888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kB/Wi+cRe7K/Xl4jkmaNXOwfB7KCAKUI6vYOHIxWVl4=;
        b=deIj3/v13K2fFJkADjupPyRuUH8FH9Q6//oOuinCT7iT9M4m4ZOuzuJODBBuG+/AFY
         5GMPtBiPjyBtCL7F80K/8qYsWfVhPrGLt32m7ZTSbNyrwmPZBL5q2WjY3XmDMDKNAXo1
         VB7YJw24lplUgGJMfkST5Sg29Zal/e4/E1oNL8DAKzzxU8kuQpfsiqpLeYENMZdPjJP8
         SnNZJQlalVtsQL7RGitbObQa2HTV3sFSVCX3EhsFTGvMFkWB5QR2APU+xKOLGrd7xdfe
         jPAeUW/Xlw0jVQRMrkkdz7e024mQZmUdbe8MmAmnJAS0T2VsrVnWo04Zrefvd1DWZMBX
         hhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaJibZvqBnq/gxajG+wBsG9k/1Wq2NgN9tj31hfjRpGDggkTwuHn/TjYDd5tmtbOzYCpMwPC12/oxZMUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySQJfKtha6zna0Ce1l97u2Q1IpZpjBeqjMZi1hiYIMip8o4+5k
	yJfngwTcONnOFq6RjjcX6sMnStX+Ddc2DNElHJXqvLEBoN/A9gZfQ5Id56xt/1FH7JY=
X-Gm-Gg: ASbGncsRRZDh7XMYqrhjckDzflOxej0iklLwuGvFB+qslFDrOOd9Mu2aVxgiTEkUEjO
	wjdwcQGAMyawcxf8CLR428SZ/ENOZzD2HzpIuRDLohLKJpxJiB65IyDzHVLypad8trBXbmurAMR
	4biKKLq1qCU2TeD+490wWH5aQ/5jE1UnlmNQorZdD4q9yCVEjcK5GBJE/Fs9Em6UIHwxTPOhLxm
	aIqKIVXjjeQxpodlw85oT4ourTDycUeltU3zWhEbuCekgLQHo/xPRaXsUeoyvcyGAyp3KStxd0u
	Dh3jhc1Sf092r2+VpceRAZaJcYgyl05CbmTjzNmOzgT5SV/wdAgydDSZcQioDcoMRS8CUOf6NMN
	5jixaZzw=
X-Google-Smtp-Source: AGHT+IGSUOqb+ed31/428rqH5N5OvGqFxlxhfX8elAayaMc3UDw7hqxF226u18IdPmrznlxbRNVzmA==
X-Received: by 2002:a05:6830:6adf:b0:745:9dc8:8dfd with SMTP id 46e09a7af769-7535638abb1mr9759182a34.35.1757977088588;
        Mon, 15 Sep 2025 15:58:08 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986c872sm3180269a34.15.2025.09.15.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:58:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyI98-00000004Yk1-1O1R;
	Mon, 15 Sep 2025 19:58:06 -0300
Date: Mon, 15 Sep 2025 19:58:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	robin.murphy@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 3/7] iommu: Add verisilicon IOMMU driver
Message-ID: <20250915225806.GM882933@ziepe.ca>
References: <20250911155720.180465-1-benjamin.gaignard@collabora.com>
 <20250911155720.180465-4-benjamin.gaignard@collabora.com>
 <vrngq76nnms3jyl5hnxqnkimjc6kil66o6fdyqn5vm3fpovmja@cfynipjw7ktp>
 <694b9ba15cd67f41a38f4a65a3811f035cf8e99d.camel@collabora.com>
 <rt6nvgazcl6mvyy4iuut3n7irf72t7rex2iwabbkuxp7cdvez5@2nanenqgxjdy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rt6nvgazcl6mvyy4iuut3n7irf72t7rex2iwabbkuxp7cdvez5@2nanenqgxjdy>

On Sat, Sep 13, 2025 at 07:58:04AM +0200, Jörg Rödel wrote:
> [Adding Will back to Cc]
> 
> On Fri, Sep 12, 2025 at 01:37:11PM -0400, Nicolas Dufresne wrote:
> > To me this rejection isn't about Benjamin's driver, all iommu seems to look
> > alike, so anyone else that would have sent new driver would have face the same
> > issue.
> 
> This is about ignoring comments from one of the IOMMU maintainers. I am not
> going to merge a driver with open comments/objections[1] from Will (and a few
> others), so resolve this with him and get his Ack.

I would strongly object to trying to share map_pages, unmap_pages,
iova_to_phys, free and other iommu pt related functions in some
limited way instead of helping on the much more complete iommu pt
work. Which is what I said to Will, but for some reason he suggested
it anyhow.

Sorry, but it doesn't make sense to complain about duplication in
drivers and then not help advance one of the biggest projects to
actually concretely and comprehensively address that duplication.

Jason

