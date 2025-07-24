Return-Path: <linux-kernel+bounces-744202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0BB10967
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32232165787
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB1283FEF;
	Thu, 24 Jul 2025 11:42:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51612749E3;
	Thu, 24 Jul 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357364; cv=none; b=WTQunTzeXlrbnSEC6WGpdhCquhAdL1Ew6x8rl6mYBk721thgelAAM8YBB/5vp1VDO7gG3nCcOXwW+sraWmHzCN27p9DBOdkGMYY2knkIP19pcbf7bxU5xO6L+QUYIb7QAgS6B0Q/5i/ra7KCa3LgvXP7yBl43YimNs5qr3DsXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357364; c=relaxed/simple;
	bh=08rXtb1bGmmb3lubXUMvMXqJewJmp9l6hlxuRAONySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK9Z1+hAjolxuEBJzYrB50v0BNJH6AbDZCKH8lk6n21/eH9fNdQI/s1elRp1ruupr33I5BAUQ4F+/CIj2d2h3cvR9a+UHqgXf6QRLb950xusqO+XLf+139eanzurQwg1cn8q2o3sLu7phz9Vn4W1g2r6vTFtzJYP2CSaUFllR/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15F91A00;
	Thu, 24 Jul 2025 04:42:35 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B2313F66E;
	Thu, 24 Jul 2025 04:42:39 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:42:36 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: mathieu.poirier@linaro.org, Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <arm-scmi@vger.kernel.org>,
	"open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <imx@lists.linux.dev>,
	"moderated list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 RESEND] dt-bindings: firmware: imx95-scmi: Allow
 linux, code for protocol@81
Message-ID: <20250724-groovy-mosquito-of-witchcraft-6a1e6e@sudeepholla>
References: <20250718094723.3680482-1-peng.fan@nxp.com>
 <2793923.mvXUDI8C0e@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2793923.mvXUDI8C0e@steina-w>

On Thu, Jul 24, 2025 at 12:17:17PM +0200, Alexander Stein wrote:
> Hi,
> 
> Am Freitag, 18. Juli 2025, 11:47:22 CEST schrieb Peng Fan:
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > 
> > BBM protocol supports a single power button, supported by driver
> > imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
> > using linux,code. Add a reference to this schema and add linux,code as a
> > supported property.
> > 
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > Resend [1].
> > I not see a reason that why this patch could block i.MX95 remoteproc support[2].
> > But to speed up the work, I took Alexander's work and resend it. Hope this
> > could catch 6.17
> > 
> > [1]https://lore.kernel.org/imx/20250513-whimsical-almond-quoll-e3ad5b@sudeepholla/
> > [2]https://lore.kernel.org/linux-remoteproc/PAXPR04MB8459A0F330554EB69E990E048850A@PAXPR04MB8459.eurprd04.prod.outlook.com/T/#t
> 
> Thanks for resending, I lost track of this patch and though it as applied already.
> 

Sorry if I missed it. I would have assumed anything without code in the
series should go via DT tree directly. I can pick it up for v6.18 unless
Rob is OK to pick it up for v6.17(assuming it is not too late)

-- 
Regards,
Sudeep

