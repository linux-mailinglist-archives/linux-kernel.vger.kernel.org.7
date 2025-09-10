Return-Path: <linux-kernel+bounces-809763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB7B511BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE98216BD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79AF310621;
	Wed, 10 Sep 2025 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gEF7w8yg"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4734C2AE99;
	Wed, 10 Sep 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493878; cv=none; b=FeiqWMDZbZEjDmz48w+ZjQ9bJYW498EL6hd7PmB8XRqK8GdpC9OYLSzMghQnjTMwYjCEbh81lu5yAMEuxlY5hQY2zFpiRezfdddzOZQx1J0oE0gE/0W4TJcjGNtEc5R8ZIjLCDMasb8cPu7N+H5fUWgdDKKbgIRER8fcCyMDQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493878; c=relaxed/simple;
	bh=hpz41grSZgUpOdZSDvGHF3rBgqGglK7gcLfkEeaB+OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7a0AHhQ3a2zyOMz+LlPBhkk2C2RJK8lsWb49wo/02ZaIb9Jq779NCMR/29CKR8cXKrBNcn6FESmWS8hqtaoXFwdbJT/J7eaHC/1fuY6ZA7Cp4wxeqbvQ1YKsYGJM4bQCspMlFDmP4c7saj6QMYU9ccweD9Ep9QJiP/YAZdXoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gEF7w8yg; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=jupNrTs3JMwOvq+fnMPXFS8hLrrLD5lrJLhDJBoxSEs=;
	b=gEF7w8yg+1iuLMmCraMdsagAWxzGsodzN3SjBWGYTGKuazSL3IiqlmafGSKxv2
	U04fsQYvnREEFhAy67GKLLdbYWIAIKqTwYpMuNzO9sK8C/wpK7/DiNu7eRkl0OVh
	Onuc4N9A7sHAluvCbYd4gNNnsgrIdrKZBvVoxugTjtQgI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3P987OsFoZf5EBA--.43160S3;
	Wed, 10 Sep 2025 16:43:41 +0800 (CST)
Date: Wed, 10 Sep 2025 16:43:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	mathieu.poirier@linaro.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <arm-scmi@vger.kernel.org>,
	"open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <imx@lists.linux.dev>,
	"moderated list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH V2 RESEND] dt-bindings: firmware: imx95-scmi: Allow
 linux,code for protocol@81
Message-ID: <aME6O29QxvU_PcRx@dragon>
References: <20250718094723.3680482-1-peng.fan@nxp.com>
 <20250825082154.GA26152@nxa18884-linux.ap.freescale.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825082154.GA26152@nxa18884-linux.ap.freescale.net>
X-CM-TRANSID:Mc8vCgD3P987OsFoZf5EBA--.43160S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw45GF1UZrWrGr47CrykXwb_yoWfJrc_CF
	WxJr9ruw4agw4Ik3WrtrW3urnrK3y8XF1DXr1Ygr1fXFnxArZ8Z3ZxA34rAw17ZaykXFZ7
	W3Z0qF409FyDujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUfMaUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCwLEZWjBF1101wAAso

On Mon, Aug 25, 2025 at 04:21:54PM +0800, Peng Fan wrote:
> Hi Sudeep, Shawn
> 
> On Fri, Jul 18, 2025 at 05:47:22PM +0800, Peng Fan wrote:
> >From: Alexander Stein <alexander.stein@ew.tq-group.com>
> >
> >BBM protocol supports a single power button, supported by driver
> >imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
> >using linux,code. Add a reference to this schema and add linux,code as a
> >supported property.
> >
> >Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >---
> 
> Not sure which tree this patch should be landed in. But would you please
> pick it up?

I do not see the patch in next-20250910, nor reply from Sudeep
indicating it's been applied, so I just picked it up.

Shawn


