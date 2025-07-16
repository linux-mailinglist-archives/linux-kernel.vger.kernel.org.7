Return-Path: <linux-kernel+bounces-733977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA20B07B79
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44774188447A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E4290D95;
	Wed, 16 Jul 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lSRb5Itj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E728B401
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684470; cv=none; b=Tt9DUd358sCbbBi7XxZ5Q7RnvviEKBrCxFwwUpnIV0Ht1FnDjl0EEDALolTgB90DDXSZLl6FZlrivNDepP370wWGysivvdpxyTDQrJPxzREmKN4Wdji0lITyfIy2cCyJmZnDJElPK+7VA6JGkt2u2gvTzZwwULCSAVw9FQfLtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684470; c=relaxed/simple;
	bh=KyfZXJ1BXnhap1nQD8idPegu23pZnjayNIe42nGLmi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND9Zfk1RwPKFggs9mPOKbMKHQ2sH3hgP7IOSHBWkKHZ4cmy0Grv9AF4DOqeAdaid7UmtYMRc0X2w82iidRZmenoCboGmSUHuDqinCtZthbyM2s8pT+G24h35dwPOouZ0kLkXtZ1whbgq7ubAVe4FOhFpjkZ304YQZFEVcQqlXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lSRb5Itj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235ea292956so299665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752684464; x=1753289264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=io4H3bGs2Do8eEWfILE3wMRoqcXTJo/vwsNg6GEKpl4=;
        b=lSRb5ItjWBRSuOMJu3+dDwa3FeqrAGLTxTsUNgcLqYSjp5pXz/vrD+NH1Id3IVKS2G
         AHZZvj8jj+KFshO+if3GOJMg44wpAeor/jTgc3gHniiLT8UxFVwNQMNUBNmOeR/EJTn7
         npRhmyMU/Q6GAK3o1GEHbm7JjJpCWJKcfBPs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684464; x=1753289264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io4H3bGs2Do8eEWfILE3wMRoqcXTJo/vwsNg6GEKpl4=;
        b=il3RJWbSTdQ73mB2SrDNEvjN/piJorGfsBi8x5Q7sYZBnWFaAYylqs5ulGyNgxOt8x
         16Tvw0eo9/K03KQhucdT4BtYyRAM1kNXJNP+21M0HbduyMhcW1ppx+VyJxQVl+vcMZOF
         eqHdPMMTFkc1dZUlcpSuyd+dDzZCuo03miqjEBN+OHWfrwvdC0jVKiX0MqdHHugKJWwL
         8YoPJgEzDxU7LKrYPUZHgYq3Mq0MMaTVIzoBYPzgiBn8ukQjrdR1cN1DUh/o+trgXEzm
         N40h34j4vAoDErKd6De2NQtyg7De0tXA1nrPFuYZagkTKcdq60qB4SaQQZ1jOQpsCLAl
         CPag==
X-Forwarded-Encrypted: i=1; AJvYcCUXghGu64NuVD+EQ9Lo4+XFRmoORKpdYaC0rA41kfz7vAUb8vlxgBwkkcjLEgSPaDETb6zLMhObT1Ghd+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVQUj0BK/nCXThPInA+LWs1rXjdt6TTnD5SFsIFppl5ga03Of
	YEkj6b/8QezSiEmonC2TZDf5FNyvDSnuOJpvskvWiq5MDCQdhXAfsL7WCxyF0ojGtg==
X-Gm-Gg: ASbGncsOTksRO2/kBD3qJ83+MjJ8whcSvo5EVy/p2Aiudjza3oOeqgvoFKpOhuFQdrx
	wvKWlRAVdWFwlfg01FpB1xSDlrZuap+yO5SP0pdjIsGk3kF07HcJQwhRryDC3Az5NPPk2Bpuftf
	BIfvmAlm1HDZr9WWpH9CYD2ZYLql1bppxucQkcyk2miA/LoV4KmMgof3LbARcuQGd5PQoBeOW8e
	aF/W/gONvsGvL4BynSKF2+ETIJepn/ubqu7mZJBD6FeoFKsP+9mKvJovJoEKaXEwFPingikIuCA
	arzdmbmg8AyVm0WkepuR7zGPNnL7/jSagaHKgJRFPifYrnH7EMMKoNeBRshbuF6N8QteKhoxStC
	h6Ov6InjKjN2b0Di3AdJqbgueKpQIpKw885XbNiqo6ghl0ADk8Gi0Oo8zz89L
X-Google-Smtp-Source: AGHT+IGNR7LutD6oNMe7hCEpNCiuXGBoISy3Dj8Mz9hZcfftgOIlNzGtyTzjgHi2yMdAXezmb77Wuw==
X-Received: by 2002:a17:902:f64b:b0:234:f4da:7eeb with SMTP id d9443c01a7336-23e25684637mr47153465ad.7.1752684464248;
        Wed, 16 Jul 2025 09:47:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:17f8:90f2:a7bc:b439])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de42853c0sm126598165ad.28.2025.07.16.09.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:47:43 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:47:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <aHfXrT_rU0JAjnVD@google.com>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
 <aHbGax-7CiRmnKs7@google.com>
 <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>

On Wed, Jul 16, 2025 at 09:27:55PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 02:21:47PM GMT, Brian Norris wrote:
> > OTOH, I also see that part of my change is not really doing quite what I
> > thought it was -- so far, I think there may be some kind of resource
> > leak (kobj ref), since I'm not seeing pci_release_host_bridge_dev()
> > called when I think it should be. If I perform cleanup in
> > pci_free_host_bridge() instead, then I do indeed see
> > of_platform_device_destroy() tear things down the way I expect.
> > 
> 
> Oh, that's bad! Which controller it is? I played with making the pcie-qcom
> driver modular and I unloaded/loaded multiple times, but never saw any
> refcount warning (I really hope if there was any leak, it would've tripped over
> during insmod).

I'm still trying to tease this apart, and I'm not sure when I'll have
plenty of time to get further on this. I'm also primarily using a
non-upstream DWC-based driver, which isn't really ready to be published.
I also have some systems that use
drivers/pci/controller/pcie-rockchip-host.c and are fully
upstream-supported, so I'll see if I can replicate my observations
there.

But I think there are at least two problems:

(1) I'm adding code to bridge->dev.release(). release() is only called
    when the device's refcount drops to zero. And child devices hold a
    refcount on their parent (the bridge). So, I have a circular
    refcount, if there were any pwrctrl children present.

    I think this is easily solved by moving the child destruction to
    pci_free_host_bridge() instead.

(2) Even after resolving 1, I'm seeing pci_free_host_bridge() exit with
    a bridge->dev.kboj.kref refcount of 1 in some cases. I don't yet
    have an explanation of that one.

IIUC, this kind of error would be considered a leak, but crucially, I
also don't think it would produce any kind of refcount warning or other
error. It's "just" a device that has been removed (a la, device_del()),
but still has some client holding a reference count (i.e., not enough
put_device()).

Brian

