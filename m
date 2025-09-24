Return-Path: <linux-kernel+bounces-830058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA7EB98951
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698F01B20BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EE027BF80;
	Wed, 24 Sep 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKQXgiFp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39E7262E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699726; cv=none; b=jvMN7R7p6HmGjxDHWHT6nRlmKt7HbFAaYiZqES3N0fVHRmlF99n3lIvp74KDDDeGlOn2Cb0RsgVVq6BztyQeAykVceVR4jmNGs3hxtjs3CPtVfHsf+TCGUbUQArcpnoGXaD9sIHslFiUjhI+eM/uqFKX1ReEYCMX9h+BYPC+wJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699726; c=relaxed/simple;
	bh=s22C2XkvtqXbgWCggQzklD/42otLP53lpOCy5Alg7+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sd2wXiKopMvI64ogV01ZmzwhSm1Cid193q8J97nXPBsY6Tu2/W2uwdZ8HGl6kVldy8DiXtm3CPx0p4CFQ6N66fRZURjTC3HQoTUOedqgiHTdOJz/VhJHXDq6hb1Bi8nH7X1G3MEHX/zwaV8AaaLc0ogp/cWswiqDMOlssU/uZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKQXgiFp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758699723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iP4CgsS/C0dxL3gWclMrWG9rP/QiQu1MTT4mBV3Urc=;
	b=hKQXgiFpOh+GLqDmK00cvNa7tjcfV6akgjbxsXjcm0bL0ZXpuzoqmoXaVfv8ndSctEbsbO
	uKLf5l//JllBe8NV5V4Vo7peJKS2l10a9ZuPBNNdxYmo857PKhGIgctaNwmDEJ5DJnRlYa
	LdZ4egFr6gNiEyoymQg4OpDSHdPzH40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-zA1U8-C8OWWB5tFt-4kszA-1; Wed, 24 Sep 2025 03:42:01 -0400
X-MC-Unique: zA1U8-C8OWWB5tFt-4kszA-1
X-Mimecast-MFC-AGG-ID: zA1U8-C8OWWB5tFt-4kszA_1758699720
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de07b831dso45741865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699720; x=1759304520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iP4CgsS/C0dxL3gWclMrWG9rP/QiQu1MTT4mBV3Urc=;
        b=S0hy/H3kWZdnX6kr5VbFjC7lg5R1m57UG0OJB+bNsj9BQJ2gtV8vl9638S4W89Ga+2
         foaCpcvoekkebP3JpCd6KT3KPr/EX06lb1eg1GDUU2d783ob/2Tbhg0FaCk/olYiwUiq
         6BueiI5qQCAIbBc2fwGJItgSMsv4ammOpzUXpp7gM3vDGAdADodwuPMYEHypMRqYJh/0
         ACn+HXrWcfx8qZHMstn36NbzxnIoz8RmUpSUR3arCr2ElN68lzLdJF08s7z1ly0ObUc6
         uIcgFAwWAE2RFy8f75qZNkN5CGU3LwhxKoRF6+sZ5wQt4ZJBvohll1/QGH43JOrIke17
         t1UA==
X-Forwarded-Encrypted: i=1; AJvYcCWzh0q/jF/XZ/uTFRxgMfOG9OqxCVJo6EWGyG5qaLdSDv83Mz+FDnAWYACRSep7eiblLAjqD/24M/6+398=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfz5HtmF3sJvh7/ZXJBu5HNEBn4OMSlRiYq3Ha3VuadunUUK9z
	E7BrWfwRyB0GgcBmKaLhmNbn/7flbTpHSgcPVH2Q7qQZYD2vZBJuHkPGwiYZTufWgtVdZMXeU9s
	288scirFtyg2bUsxGmmEUSZjY4nFjIbMV5GM059Zkrg0pLE88mbuuZwLxHEf3mwEp0A==
X-Gm-Gg: ASbGncuZS+Lnt9fCC8LLvwmrsYziq4i/IzpWLdyvobkEmOWyauTsWoLc7Mq/8cdShLl
	8pAuGNMC3riLmED+9MJFcVw0rc18r6K5aqrScm0nTyj07YfDr6pIDLV5kuKBHvqyQOv1A4X/4K5
	WrCOyaVXHvCoAypE8g3zhcqAhl5UzEH0od0ZQyNCS5tJof8pWU0y7Qrc4ogL4UEXDRmUjBENShu
	XX9jGbdAlWzPEjOgIi0kOVSioKuKlZ2S02pOvvZXoOe/9EowKfVRpj8khb7aew8IncLcjBIxzjg
	jGUvhYpklxIfVAHq82UMkrx2WAyIbonDK9A=
X-Received: by 2002:a05:600c:3547:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e1dacf6edmr50676295e9.20.1758699720374;
        Wed, 24 Sep 2025 00:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBaH8Qcz+geVHLVmG1y55L66i7iUAa9TF2rE/T5FQj6JWkFbMfTzOEnJtYBSrJWjTl6QSAhw==
X-Received: by 2002:a05:600c:3547:b0:46e:1d8d:cfa2 with SMTP id 5b1f17b1804b1-46e1dacf6edmr50676015e9.20.1758699719977;
        Wed, 24 Sep 2025 00:41:59 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40bd194c0bdsm1287994f8f.61.2025.09.24.00.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:41:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:41:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924034112-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>

On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > patch series, the associated netdev queue is stopped before this happens.
> > > This allows the connected qdisc to function correctly as reported by [1]
> > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > the theoretical performance differs only slightly:
> >
> >
> > About this whole approach.
> > What if userspace is not consuming packets?
> > Won't the watchdog warnings appear?
> > Is it safe to allow userspace to block a tx queue
> > indefinitely?
> 
> I think it's safe as it's a userspace device, there's no way to
> guarantee the userspace can process the packet in time (so no watchdog
> for TUN).
> 
> Thanks

Hmm. Anyway, I guess if we ever want to enable timeout for tun,
we can worry about it then. Does not need to block this patchset.

> >
> > --
> > MST
> >


