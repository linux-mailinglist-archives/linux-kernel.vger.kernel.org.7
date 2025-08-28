Return-Path: <linux-kernel+bounces-789713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E5B39985
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C73B9299
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E292701D1;
	Thu, 28 Aug 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Voa9vrjz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB626FD9D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376401; cv=none; b=di/KP9FWeFxsq/13gRcx7UT7PaN/C11CfzRTV5sxFqfrAITm38LjRhi9uG9GNPoVE22adn5kKMJHXt6VPvMtfbVmplW8qM4QeAlJI/3+hNwhxb3RXay2A3BiIh0W/RCQP+HsAg//vi36R49dsWPvB0NwNSHijVniaBDWKOXt1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376401; c=relaxed/simple;
	bh=C1DYH4kVeKuTMIZnOmx1ZxMHuw47TEaonNH+ssfuphc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUxyGklysbV+6up9shzLmghGnnbxkZzMt+ism7Ilm2aUT+Ko6kAGlVY3VmxTGoBeyzGRfISSLrvxih+Q3sryzEQWuMyBwM+d20QUjrFAlbugGTGWl/N9dj8OFczbkV0ZWpC2krYTC7uVfPDVo0ikAECe2nnejVXKBlQPg/g+6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Voa9vrjz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756376399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBAEoFNbmswFsnSxAIv1w+pBcSdXwLgSTS2jwoutXlw=;
	b=Voa9vrjzTwnIk1XnGe0lK5O7Py9HAgFReyjhQI8T2ENUvOwdCMAYApkR2u8qqCHwm/Lrga
	V0b52jm5rnnRZkuWWLsCFA6eM2mfUE0n542QTNDJRVdnSv5eW3Qu9LuQGiWr9odywSypQE
	sBqvdrMI8uPMDsJs2fltZeeNteUCdEA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-K0osWPgaPPSDpY-Ym5leeQ-1; Thu, 28 Aug 2025 06:19:57 -0400
X-MC-Unique: K0osWPgaPPSDpY-Ym5leeQ-1
X-Mimecast-MFC-AGG-ID: K0osWPgaPPSDpY-Ym5leeQ_1756376396
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so3674395e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376396; x=1756981196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBAEoFNbmswFsnSxAIv1w+pBcSdXwLgSTS2jwoutXlw=;
        b=pIcHQ0mKyUmwtSYAEZ+yTZRqeiyvNeukarYI9J9gA/I0i9IjzICxROIxNhRvFXOp4I
         e0xr67cnJqWlzBRKTCojG85hoxH4fqZSbBFilZgmmRPBTykJE/jFVxwBEfmUmRkaH1xH
         3ytp56xyEp1n6JOHf2ymO5USeQWrFig6llruckFiMuEeqYoHIRhhh/HTzHUK5q5fBii1
         hI+tTAZG8VPdy1ty4P2w3SG9nEW1QWuEfGT0hH0MDRbcRCtsjBgOyZR54tICPOSo597z
         324nKl9O8RZ9CCtFKaKvFlaRWC4b9SzgmGynVVmTy1Hudq5vJKv/tL0WUoUSHiGLnGXv
         K5zg==
X-Forwarded-Encrypted: i=1; AJvYcCU3VaphCPp1hXpxuc5CkwtAqLSRlAzrnv8/yYLiqQd6SolWuEWOGfJ2E/UsDkPV2V0WGIYiCIiT0oav43A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuhfOdj81kdvp80C3ggyXKT04dV4st3Kr0MoNh8cUOdN/433n
	WrFce6uOMotJeg911UQqtzzi6gZ9TzTRamS+lQFEkvKm7R0//4cTOeVn1xj92ByP1byxYC4p0zk
	5Tp3Mtv5TB1h0gEnMlVdBk4Go4+0TJZwwUT4drkz25JioOddP7OdAKIwgwNbi+tbGFA==
X-Gm-Gg: ASbGncttMo7KdFgctzhE1I3E9U+lSq7xIgN+cVp5coHRH8jdwZ+PX/mnzaZE3XU51Uf
	vvReKPFk9M6qae8U9Pqh/c3EpJuBUvvX337tkQbwGxm2cw5tDAJrSOfDeP/uzqZRespKxP1A6Yf
	4EuHEXUyDNCopDbXKd9E9usquW66R4UE3a5l3FxFIS8JnSM6MticxIArU9DNpA9D2LrkBquNmiN
	RWp5KSAnT7uQkgxInB7+pJtqoyjb7v5HEFAyZzpw6+qzlPS41lzl+u7eKRo+v+MA50IpNGasBBk
	jRiWLsDD187Xw/+ErcbDXooIIMps+xtN
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr169732945e9.32.1756376396482;
        Thu, 28 Aug 2025 03:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRzvWTBo2GxDcNnrIlhFHzO2y1QKjqd6ebF9+adqAAZUSWw06wXWnWxmDIghxndloNXqg0Zg==
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr169732795e9.32.1756376396123;
        Thu, 28 Aug 2025 03:19:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b79799c33sm26094735e9.5.2025.08.28.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:19:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:19:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250828061943-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044231-mutt-send-email-mst@kernel.org>
 <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>

On Mon, Aug 25, 2025 at 05:12:44PM +0800, Haixu Cui wrote:
> 
> On 8/21/2025 4:42 PM, Michael S. Tsirkin wrote:
> > On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
> > > Add virtio-spi.h header for virtio SPI.
> > > 
> > > Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> > > ---
> > >   MAINTAINERS                     |   5 +
> > >   include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
> > >   2 files changed, 190 insertions(+)
> > >   create mode 100644 include/uapi/linux/virtio_spi.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index daf520a13bdf..3e289677ca18 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -26760,6 +26760,11 @@ S:	Maintained
> > >   F:	include/uapi/linux/virtio_snd.h
> > >   F:	sound/virtio/*
> > > +VIRTIO SPI DRIVER
> > > +M:	Haixu Cui <quic_haixcui@quicinc.com>
> > > +S:	Maintained
> > > +F:	include/uapi/linux/virtio_spi.h
> > > +
> > 
> > I would add a mailing list:
> > 
> > virtualization@lists.linux-foundation.org
> > 
> > 
> 
> Hi Michael,
> 
> Thank you for the suggestion to add a mailing list to the MAINTAINERS entry.
> 
> I noticed that other VIRTIO drivers, such as VIRTIO BALLOON, are currently
> using virtualization@lists.linux.dev rather than
> virtualization@lists.linux-foundation.org.
> 
> Just to confirm—should I use virtualization@lists.linux.dev for consistency,
> or is virtualization@lists.linux-foundation.org the updated preferred list?
> 
> Appreciate your guidance!
> 
> Best regards,
> Haixu Cui


virtualization@lists.linux.dev

Same as others.


