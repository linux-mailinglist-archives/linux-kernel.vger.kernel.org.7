Return-Path: <linux-kernel+bounces-798746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DCBB42265
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72BF1BA0234
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B11BD01D;
	Wed,  3 Sep 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="j/80TZBI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79022308F19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907296; cv=none; b=KBMqGZ4tLYFZ69rLLgJ4ykmOQjN4UgYX3JitoaCRdry6jygwiNpeY91w3ia2ywZ4sfrix1EvhvW23EZgWleZLd7oap+EPZTVAEskrvMFeXifODHvvyBeWmsSv9+H9QwVCJpbDN39mQaTGvD5vRt3WfgVHxiXAu65fah72i9Dg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907296; c=relaxed/simple;
	bh=wHSYdEndGYVsU4nyD1UO39BeJ41HSWWrWO3/X8oENnI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=s6YBvmTpocrsUEyPp6ExHgGOqysWP5+iqqXLQ2lgoEehmt3rjW18KE0NYoojJZCqq5ks0XShBSXtgGmVXvJ3ktVD1Ud2G/3Mvm2eKycIclupolwT7GARu/kcnKnwaQyMSNBUu1bwDy4rOoDcPKzeAuX9+xngAsdrskou9Ltg8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=j/80TZBI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:480e:e039:1d0b:c5ff:a9e2])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8F429C6D;
	Wed,  3 Sep 2025 15:47:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756907223;
	bh=wHSYdEndGYVsU4nyD1UO39BeJ41HSWWrWO3/X8oENnI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j/80TZBIS2ZgBtU2z7ngDSkl6Xqsr7xzKUvqOtwBn4fLRbLIAv/OAaMnCP5kjLf+d
	 mecrk4AEnkcwsQYiOg7rj/MqqMcn+gS2p0cN6uKWd0+Teq0EfCBa6cWFDXGUvVNIIX
	 71MiP5VLXJjCIqvxK2NjVm0JRXfY8wghQfeqdWZ4=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com> <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com> <20250827124016.GF5650@pendragon.ideasonboard.com> <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s> <8ed6519a-6e45-4793-b11b-7b63c1703d6e@gmx.net> <910dae68-0545-46fa-b41f-8e4fb32ed649@broadcom.com> <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com
To: Florian Fainelli <florian.fainelli@broadcom.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Wahren <wahrenst@gmx.net>, Umang Jain <uajain@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 03 Sep 2025 19:18:06 +0530
Message-ID: <175690728665.8095.6551736878574350999@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Florian, Stefan,

Quoting Stefan Wahren (2025-08-28 11:49:47)
> Hi Florian,
>=20
> Am 28.08.25 um 04:17 schrieb Florian Fainelli:
> >
> >
> > On 8/27/2025 12:05 PM, Stefan Wahren wrote:
> >> Hi,
> >>
> >> Am 27.08.25 um 16:33 schrieb Umang Jain:
> >>> On Wed, Aug 27, 2025 at 02:40:16PM +0200, Laurent Pinchart wrote:
> >>>> Hi Jai,
> >>>>
> >>>> Thank you for the patch.
> >>>>
> >>>> On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
> >>>>> From: Umang Jain <umang.jain@ideasonboard.com>
> >>>>>
> >>>>> Move the VCHIQ headers from drivers/staging/vc04_services/include to
> >>>>> include/linux/vchiq
> >>>>>
> >>>>> This is done so that they can be shared between the VCHIQ interface
> >>>>> (which is going to be de-staged in a subsequent commit from staging)
> >>>>> and the VCHIQ drivers left in the staging/vc04_services (namely
> >>>>> bcm2835-audio, bcm2835-camera).
> >>>>>
> >>>>> The include/linux/vchiq/ provides a central location to serve both
> >>>>> of these areas.
> >>>> Lots of SoC-specific headers are stored in include/linux/soc/$vendor=
/.
> >>>> This would be include/linux/soc/bcm/vchiq/ in this case. I'm also fi=
ne
> >>>> with include/linux/vchiq/ but other people may have a preference.
> >>> I agree with this point and I might have missed to notice the
> >>> include/linux/soc earlier. That's seems a better location to me since
> >>> it's actually broadcom-specific.
> >> I would expect that headers and source would be more related.
> >>
> >> For example:
> >>
> >> include/linux/soc/bcm
> >>
> >> drivers/soc/bcm/
> >
> > This is not Broadcom code, it is Raspberry Pi AFAICT, therefore, just=20
> > like drivers/firmware/raspberrypi.c, we would need some namespacing=20
> > here that reflects that, ideally.
> The VCHIQ code originally comes from Broadcom, but the current=20
> implementation has been adapted and tested for Raspberry Pi. I'm not=20
> against a Raspberry Pi specific namespace.

Thanks for the suggestions. For v2 I'll use:

include/linux/soc/raspberrypi
drivers/soc/raspberrypi

>=20
> Should this also apply to the DT bindings?
>=20
> Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
>=20
> Best regards
>=20

Thanks,
    Jai

