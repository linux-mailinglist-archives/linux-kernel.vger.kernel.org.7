Return-Path: <linux-kernel+bounces-697786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03635AE38A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D0016867E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5622F755;
	Mon, 23 Jun 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXhgy8BI"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D422DA13
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668079; cv=none; b=rmzQxf8jh/rNbevlB86t1HynQ6CPN+O+l74IXOSTKdTIvC7vZaofP3SF7TfM4SXeR1waymDBB9R18fZsxJrte/C1gt1kET9Re+1fnbvVRuGriDudH7EkPkgHcF96e/ufckcWngGbiIa1T9FXN+34Ob+G++5s4xHLS7+i/2NmqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668079; c=relaxed/simple;
	bh=dK2/nk5Dk95inlWUhVxlyOVlxm1wOh6kKl2zKSksdrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGaDqSj7118WBbcfuRvOmKNxVuRyFA6PdjX0uYFXd3tg7lA+nGI+sRI0wSItMxzqY/791jh9WDTum0uRNx1y8qGBh7s6V4FAC8dTsVYpJ2kOUeZA1aQSaf0dmyd12otcgqTRUSoLzsY9AtXPR7mRLMmGSZSK3fwmjWJzhONUxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXhgy8BI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Jun 2025 01:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750668060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r16EnTRqICp2s4o/VmEbqOJZDlq1jQbD4/5SrPKHiGk=;
	b=vXhgy8BI2eQT3nYZFNPvge0v3pNI+5OHueB5YbHaYwCW+TT9AQHY0yJHWTYeBTTKK+bXVc
	oi5EsbsszqVgdBVJtFUje6uy4RYpnmR43FqwM9HnWzxpkObe9VzrsPqZmevtpEJmO2Wy/Y
	zdyKSvNt+gzmZ8O3Ny3eRiR0q/supVI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Ananta <rananta@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/4] KVM: arm64: Introduce attribute to control
 GICD_TYPER2.nASSGIcap
Message-ID: <aFkTDmj9u1ERnvHO@linux.dev>
References: <20250613155239.2029059-1-rananta@google.com>
 <20250613155239.2029059-4-rananta@google.com>
 <87frftfpg7.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frftfpg7.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 21, 2025 at 09:50:48AM +0100, Marc Zyngier wrote:
> On Fri, 13 Jun 2025 16:52:37 +0100, Raghavendra Rao Ananta <rananta@google.com> wrote:
> > @@ -683,8 +714,14 @@ static int vgic_v3_has_attr(struct kvm_device *dev,
> >  			return 0;
> >  		case KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES:
> >  			return 0;
> > +		default:
> > +			return -ENXIO;
> >  		}
> > +	case KVM_DEV_ARM_VGIC_GRP_FEATURES:
> > +		return attr->attr != KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap ?
> > +		       -ENXIO : 0;
> 
> Do we really want to advertise KVM_DEV_ARM_VGIC_FEATURE_nASSGIcap even
> when we don't have GICv4.1? This seems rather odd. My take on this API
> is that this should report whether the feature is configurable, making
> it backward compatible with older versions of KVM.

So this was because of me, as I wanted nASSGIcap to behave exactly like
the ID registers. I do think exposing the capability unconditionally is
useful, as otherwise there's no way to definitively say whether or not
the underlying platform supports GICv4.1.

KVM_HAS_DEVICE_ATTR can't be used alone for probing since old kernels
use GICv4.1 but don't expose the attribute.

Does that make sense?

Thanks,
Oliver

