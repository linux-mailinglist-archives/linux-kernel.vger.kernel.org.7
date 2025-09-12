Return-Path: <linux-kernel+bounces-813468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD24B545D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B19AA5D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F7261B93;
	Fri, 12 Sep 2025 08:48:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11BE25F994
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666917; cv=none; b=JLEhZ5QRcC/prHv2A1yrMpPDV4ZQbt9CD0yg8Qnrcdh8CkP29Teha/G2IlKFpZlbrRDUwCREKnR5EE7BSUQH2VY0/bLBKsEFzGkzSLu86euuAudZH1QE3u82iv+nLDxcU+mxKclqGSD6Z3FD6Guxh3HP/OghcYDo4j1s37uqnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666917; c=relaxed/simple;
	bh=ac7H1NgflG1n6K7kgvvFu1xSxbx+PQbFL9LHTN8IDTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXSlk7YK1o1GXoeZbYG3SNCjw0FH2sZPF6HdhlShfNBvPn8AArN1uhbyEsffs+sEilqN2I5mYngC9U4T0fF0mKqG2/fYkGbtgGsghLMak8rbVvftPXj0fat0iiE55X/mDxfr6m46z9LXRuTES38yocLNKSv7+CTopNdC3KgExZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwzRy-0002c5-Ds; Fri, 12 Sep 2025 10:48:10 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwzRx-000u5j-3A;
	Fri, 12 Sep 2025 10:48:09 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwzRx-002xL0-2o;
	Fri, 12 Sep 2025 10:48:09 +0200
Date: Fri, 12 Sep 2025 10:48:09 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Message-ID: <20250912084809.e6atdywisk4ywlr6@pengutronix.de>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
 <20250912030223.GB5808@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912030223.GB5808@nxa18884-linux.ap.freescale.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On 25-09-12, Peng Fan wrote:
> Hi Marco,
> 
> On Thu, Sep 11, 2025 at 11:56:43PM +0200, Marco Felsch wrote:
> >Starting with i.MX8M* devices there are multiple spba-busses so we can't
> >just search the whole DT for the first spba-bus match and take it.
> >Instead we need to check for each device to which bus it belongs and
> >setup the spba_{start,end}_addr accordingly per sdma_channel.
> 
> Could you please explain a bit why it is per sdma_channel, not per sdma_engine?

Well first, the sdma-slave/user defines which SPBA bus is used.
Furthermore not all users have to be part of the same SPBA bus or be
part of a SPBA bus at all. E.g. the i.mx8mm.dtsi sdma1 engine is used
by uart4 (not part of a SPBA bus) and uart1/2/3 (part of the
spba-bus@30800000).

I know that the use-case: "The SDMA engine can serve for multiple users
which are not part of the same SPBA bus" is not yet used but having the
code in place makes the driver more future proof.

Therefore I think having the SPBA addresses per user is correct.

Regards,
  Marco

> As I understand, all the channels belong to a sdma engine should use same
> spba_{start,end}_addr.
> 
> Thanks,
> Peng
> 

