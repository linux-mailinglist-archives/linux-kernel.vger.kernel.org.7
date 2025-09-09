Return-Path: <linux-kernel+bounces-807564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A7B4A63A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2291C241F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF22773C9;
	Tue,  9 Sep 2025 08:58:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA34275AFE;
	Tue,  9 Sep 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408307; cv=none; b=GEOMxmCb7/55mMUL/9x5A4Vm5kAbtcib5gSPlYt91/qkejm8/8frMThSRUDKAT1QncGVFQ7muSTRx0Z39i6eDzUy2KXZx2IBeXSDnTz7XWKwvfrfDpYg14ZYkc3K/Xa7rGRKV4NcyeFe0jxpr8Zu2rcCKC5ZFkaZE1eYs1nqKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408307; c=relaxed/simple;
	bh=7l3LSyW/dszeN+8436Ru+Gt/JPA/DJ9sw5nh3KFAMvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTJ38o6qi8Gy2tDn2m0mKKb5vwI89Jufj0BmBYZsYiA/VM9Le7rRmTBmUx+rbjXcZa9/BoTQG6cA2GYS9ut4X8h28AnK8ic4S6GvCy7j7g8Qt2GWAwJaNLjqPISukbGaEoFkLQed5KDz4WvnCvmq5B6Qm9QOqtQW3W9j/J1tmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C4CC15A1;
	Tue,  9 Sep 2025 01:58:16 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C48493F63F;
	Tue,  9 Sep 2025 01:58:20 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:58:13 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250909-excellent-unbiased-seriema-8d619f@sudeepholla>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
 <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
 <PAXPR04MB845929E7106141E785A32387880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250909040159.GC20475@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909040159.GC20475@nxa18884-linux.ap.freescale.net>

On Tue, Sep 09, 2025 at 12:01:59PM +0800, Peng Fan wrote:
> Hi Sudeep,
> 
> On Mon, Sep 08, 2025 at 11:51:02AM +0000, Peng Fan wrote:
> >Hi Sudeep,
> >
> >> Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting
> >> syslog of MISC protocol
> >[...]
> >> > +};
> >> > +
> >> 
> >> Much better now. But I am still thinking if this must go to the
> >> document to make sure it remains ABI and firmware can't reorder the
> >> as we might have no way to deal with that. That's the reason I was
> >> asking for raw dump so that you need not put all these details in the
> >> spec/document.
> >
> >Let me check with firmware owner whether they would include this
> >into i.MX SM spec or not. 
> >If no, raw dump would be the choice.
> 
> I checked with firmware owner, this should be using raw dump.
> The layout would be changed for new platforms.
> 
> Since this is raw dump, I think debugfs might be preferred.
>

It can be sysfs, but it can be just one single 4K dump, no more details
from the kernel than just raw bytes.

-- 
Regards,
Sudeep

