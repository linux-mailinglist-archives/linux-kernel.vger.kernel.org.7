Return-Path: <linux-kernel+bounces-869502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2665C08056
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBFF3BF1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45A2EFDB4;
	Fri, 24 Oct 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0VdsHCZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1BF229B2E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337192; cv=none; b=HRJDmgBjAL9r4o9pfN5MU9wm9d8JLoqMLs+iZWHoTkbRd4rG2CWiBQPEz1rXi7rotND5T9p+c4ZXhFythBKkU66ND/TJzRh+2TIJmfcSnOxC7EOA+Zscig6/csr6tc9AIivzBRvFjD9cviCcAkxEn1q9gqpdWNMoVVduOy4DrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337192; c=relaxed/simple;
	bh=+RHhii+jY9d8/ctuTLvU+Zz7XMoaS0T4paIu7a6dNwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKt1IXW6Rjw9Wg/UXOqt48qrfWhhmcwxTzettTkSawYv8Xe8iIu5A/jr2DIXlLRZn2RPaFbapcTVuYZHNUAlT5Wv4XH/mlI3uTaSbkGx6D/f0IRq6Xbh+FhsogrDYjUdvtmMVfpV1LslvHQf1raitNvVBkIHZFHcsqDRpVLcbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k0VdsHCZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471191ac79dso25303755e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761337189; x=1761941989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCy1zJ6sxY7XDksdN+ZfQfMEyEv9pQCKJ+rvcvU78wE=;
        b=k0VdsHCZrs+oe91bYbdYPb5P97QGYRhdBBZ7cJfRUcM4LuyVzkJjUiODND5nMqVskV
         IhY7iFfRrBYJipUIzdbV4l6jSDUuEdkvhv254IWPaqrxSG/XelHnInd0LVGtufm5lGvV
         5RbO/j9eVXVvnD7MxRDTMm6lZDoENKnfPpfhPP4Iw6AmtA0z5TJoSemwEf8j7aA3hRvb
         daxfLgVrIi6jcNmGJrMy3S73+NxV+LZg3lgQhaYmIwwggzVH8hCijDGMThvDspIMccMo
         W+0VeQvMgacaay/gH0rUdPd6J0zyq255S3Op9PeELp/XFyQZ3QzodGvirk8A2cmdKmJZ
         /1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337189; x=1761941989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCy1zJ6sxY7XDksdN+ZfQfMEyEv9pQCKJ+rvcvU78wE=;
        b=l8u82MnQd/O8oK2Ote6Isb795Hm0xs8gWltIf9k6J6wT5kFE7gBPKQyEluK4OfHwTu
         zQacIrx3/FzZgHSDcR+0+HKP3cD2cbjf/uT5JwrAj7iphEeoqA3747dJCz+PdpkNFdkW
         7NdJu9hWRJtavLQetuMjOm0iY0vfHkL4eUkGhjdEwYR5UHZi++D41KoiuJzEVebUBz7D
         HqZsbVNe/IWGwFUm26UKK97P/S6P2StpsxkiEL29prYBRqdDF478RxsA6A4W4VLxuTbi
         biig/sUE+gWthzT7vxroZPbeaYs+p1ykYEDYlzphwIFs0WKJw80cYVsbrngQKNAL/nIq
         67uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXelkGMfuKVfXWECmgYdcntVtwyegDtAZjBaQWSz9J5ow4ePjND24oxgCErEM8V5cl/9e/nXLjzWkni9IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0vX9aBrOUjU9QrFcEwr7xrWq41gC1iRvTkVIqS0pHxr9iyNH3
	Drg03IdPhhyNOVs3pZSdMpzLrO4f0og9YgDg+ykMlWSWTehNuzRLhoycGGkPDX8sXoU=
X-Gm-Gg: ASbGncs3FIns9tEG+lxHKuPm89NHKyd0PgFUhelIpgQ6ndK4++tj7wqyKEiQp0Yh1LI
	oMtDMEtSrdGLJaEKin0FIMlLCuzA2uePIQ2zFBEjH+xLqytPQycf/LDffFcZEJe+MXBBTkFThrI
	n8OFgt/mI8r2Q3P2Ms/maQOfdphpWMlR+QcWQbpco6yvqskw+pXf1dwVXGWDFfYD2KHqqwM1kD0
	80tTUpJ45HfWYgMw5F8tGwIYH/Rs6NrVX8xuqjivGd81FDeYiiR3UOSbWbt+c0EYQq2btN36rX8
	idmkNiuZI92j+9xu8hWsCUBt2uJyKgjYT99Gc+KgOrbJt9Ym8Ckw/Lm/Yb5FP9OuF3xxLbJtdA+
	SPE3EXJKcEftfCGrQaoKNcHQzYhe+70Hizv/MPUJDWOamZ8Duww4XUTvKyqbG4S4IRfY3HzlOpb
	ZqIL9XHh4=
X-Google-Smtp-Source: AGHT+IG6QzGaUz34lEPKz312/mkWIT0AABjVhY6oKHLl9C22iV9Fx/QpFe3UaLiPniDFo1+dMTxXZw==
X-Received: by 2002:a05:600c:4510:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-475d2ec5729mr31422505e9.23.1761337188441;
        Fri, 24 Oct 2025 13:19:48 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbe5381sm584965e9.0.2025.10.24.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:19:47 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:19:46 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: ucsi: Add support for orientation
Message-ID: <vbbz2jfisxnjiblasbtay5mnaphsio5qnjrqbxjztykdvgvxfl@sdicu53m3pil>
References: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>
 <2025101530-skeleton-able-6523@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101530-skeleton-able-6523@gregkh>

On 25-10-15 16:00:43, Greg Kroah-Hartman wrote:
> On Wed, Oct 15, 2025 at 04:50:36PM +0300, Abel Vesa wrote:
> > According to UCSI 2.0 specification, the orientation is
> > part of the connector status payload. So tie up the port
> > orientation.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 24 ++++++++++++++++++++++++
> >  drivers/usb/typec/ucsi/ucsi.h |  3 +++
> >  2 files changed, 27 insertions(+)
> 
> Why is this a "RFC"?  What is the request?
> 

My bad. Posted as an RFC since I wasn't sure if I tied the ucsi_orientation
correctly, meaning in all the right places.

Let me know if you want me to respin this as a proper patch.

