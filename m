Return-Path: <linux-kernel+bounces-830182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB23B98FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73437B691E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF742D0626;
	Wed, 24 Sep 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f51+3z0u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72962BFC9B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704106; cv=none; b=QFbJc0khzsxDbXNLaOYYsw+xNqwu51jfM8gGEhbrRKRDb1KkGCmx2xcZoxdJ2KUhuLQKugsQMqeO80YyvWUvNLxifHR2/+OnvP8NIrobvxsZ+QUb2o0DNgU+NFv7bVO2+ZcOCTcMSPYPO2VOD9JGr47VMDZjWsNI6l0p4nUHcdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704106; c=relaxed/simple;
	bh=yC4F9BxKMD2tLjzPZNMkOfB70p02zY5u5wUAbNq4KtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF8fYlrWbekzMgtLimntfR0gEaXWA6leEvJVP/QcNwCvKp4P/zlRcT3ccQ0aTDCaXH/ydn4a8t6DG0eNWnPrwtVxgQyafSweG6+PiLL1Ag2aLrDQe9lkebMF7mkuQXb2QAamADpTCv5xtH1Q392u7cXq/rvfSYJ0oZ9hByZuk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f51+3z0u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758704104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeF4iLafWqiyYhAJj/z0HEWgGu1flHRP9T+bwNm7VOY=;
	b=f51+3z0u3/N772x74jH5ZCDOVuJiClexfcjkTftHEh6hoj2jyDPQqrBu0V0WRsS8OV9ZRo
	iQc3t/vpHtuuBO9qv9rYdn3md3nOHLWVPf86ZF384Em3fzL3QFEQAlAsgTfjwlsxlFz4r6
	s4W7oiZRv2BjGrJ1iM1nEcz6jE8wswE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-P155yuLBPF2bzU2jbGdWkQ-1; Wed, 24 Sep 2025 04:55:02 -0400
X-MC-Unique: P155yuLBPF2bzU2jbGdWkQ-1
X-Mimecast-MFC-AGG-ID: P155yuLBPF2bzU2jbGdWkQ_1758704101
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-632c9a9ceb1so3857053a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 01:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758704101; x=1759308901;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeF4iLafWqiyYhAJj/z0HEWgGu1flHRP9T+bwNm7VOY=;
        b=Ag98T+HidFjXlkLj/yXt9GbI7aVTZWBkfiCovNe236UQX9vK82u1AE9grdTC3SlHon
         HuxFkjeF5fQLLiz3wfftUzCIA49uEHcfA3rh1n7NR8j99Hq5iRCcHt2B4WxjAmCGp/L4
         E4kuAjBlYGFRBSRixkKPiaGZbtb7bh7Y0XdFrcRv+1J31yxfuej5fAaA3IkJ4mPhhJzu
         xE+vOLav9j9XPx0G6jbxgS5kgFTz3b08QCTMIUxuRM7tBNwTAcuuiZol/cwM35U5CPtw
         tPPVW8BIJcG53UKx5e99eUDYse86e2d9QJ7I5uzzA8bYN2S1S4tqtnZOJqcuWrgV7Slm
         Pjpg==
X-Forwarded-Encrypted: i=1; AJvYcCV+eIGCaKSLruJeIwROyjJLr4TVf8f9xwmp+LRw+WyGDzAysHtkO/R5SuT/Xjz9YhPhFnD1vM5qJenpNGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZYm5LWlV7R11jc3uQ+9ax+MJ9z69ELilcWi2K5K5xSntAMeg
	IstVc0FMy4nrqtViNLrkLa54Pnb2n10R8kuKTdl2tvBQX8txRt0kEvXbpKc450/RJvWF0LccWJc
	07/O5pp0qJAMV413CO5AO/zq6YGCIQZ3zYdbfweOR+20jmYGw5/Kv0lvodJhs2X8KiA==
X-Gm-Gg: ASbGncsMAZkvFFHObVmo8Pi61Bl+CZ2khur/LEoeIJG9oNyNlbYrL/xD5Nm9xC+7zBB
	NtMgCtU1Jl9QS47DeWZngyuhlGDT+wbgA/WHBuZVpjA4hL3L533oGW17Dw/TA0VQWKAeXHXvBTB
	qmqJ840IP9tprNKlzwVxBmC0aV1pw2rCU5loXZP6xl4jKHd02v+TGRlJ1sTb17Fj6+z4KZxPiXc
	6+PhF7ntS2uSAk3QewhxuD/29Op62/K5MYi61fruDGjIoukRpzkbxfwSyV3S/6ztF3DwSSt5UF9
	3rRHfSTI/m+G0ZujETgyY55tgBhQ
X-Received: by 2002:a05:6402:42d4:b0:634:66c8:9e6d with SMTP id 4fb4d7f45d1cf-63467a196c6mr5117521a12.35.1758704100853;
        Wed, 24 Sep 2025 01:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsvQzI/barPCHCcY3wmgFpimCqdL8DPZENn3l5dqczZHN9mqSB95iiRU7jvEjFsRYlUtc7jA==
X-Received: by 2002:a05:6402:42d4:b0:634:66c8:9e6d with SMTP id 4fb4d7f45d1cf-63467a196c6mr5117491a12.35.1758704100372;
        Wed, 24 Sep 2025 01:55:00 -0700 (PDT)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d03befsm12964100a12.2.2025.09.24.01.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:54:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:54:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924045430-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org>
 <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
 <20250924040915-mutt-send-email-mst@kernel.org>
 <CACGkMEtfbZv+6BYT-oph1r8HsFTL0dVxcfsEwC6T-OvHOA1Ciw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtfbZv+6BYT-oph1r8HsFTL0dVxcfsEwC6T-OvHOA1Ciw@mail.gmail.com>

On Wed, Sep 24, 2025 at 04:30:45PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 4:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 04:08:33PM +0800, Jason Wang wrote:
> > > On Wed, Sep 24, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > > > > On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > > > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > > > > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > > > > > patch series, the associated netdev queue is stopped before this happens.
> > > > > > > This allows the connected qdisc to function correctly as reported by [1]
> > > > > > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > > > > > the theoretical performance differs only slightly:
> > > > > >
> > > > > >
> > > > > > About this whole approach.
> > > > > > What if userspace is not consuming packets?
> > > > > > Won't the watchdog warnings appear?
> > > > > > Is it safe to allow userspace to block a tx queue
> > > > > > indefinitely?
> > > > >
> > > > > I think it's safe as it's a userspace device, there's no way to
> > > > > guarantee the userspace can process the packet in time (so no watchdog
> > > > > for TUN).
> > > > >
> > > > > Thanks
> > > >
> > > > Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> > > > we can worry about it then.
> > >
> > > The problem is that the skb is freed until userspace calls recvmsg(),
> > > so it would be tricky to implement a watchdog. (Or if we can do, we
> > > can do BQL as well).
> >
> > I thought the watchdog generally watches queues not individual skbs?
> 
> Yes, but only if ndo_tx_timeout is implemented.
> 
> I mean it would be tricky if we want to implement ndo_tx_timeout since
> we can't choose a good timeout.
> 
> Thanks

userspace could supply that, thinkably. anyway, we can worry
about that when we need that.

-- 
MST


