Return-Path: <linux-kernel+bounces-823068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7DB856E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B037BCD63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C1311C2A;
	Thu, 18 Sep 2025 15:01:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B930FC35
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207690; cv=none; b=SSptEZ8pfuWDzUiKFSEqEFyJMqdDTO9CEPS+K84EUs/tUg0+q7v+OSu5KIAd7+NKX7XIwzZQQ32r995bLwVQ/JfzkmPH175oYqxgdaN41woTBzXE7GjzXve5iElhTzIX8bXa9zu/d5RK0QEL8x8TYQKaBc25LJIzioVaBweC1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207690; c=relaxed/simple;
	bh=dMgnUT9SN0xWEnTD5CB7F2sIRMIdRNv8a528sPnHBx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/a7YQDb1Ethfe4o0+Q6sBFkToLSxbgrBmJ4JkULW+QxeuRhtfzqBQ4Yici019NipPRCjjKhGLzkoRu237caRN/F0tLUjcv1WZEx3JJ1K9nH7/lRx0GsM6lDCvB9Bu1/mteH3vJ/vOEh/vyY7yCHX3lkGpZk4YSdYcjGR1WZHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uzG88-0007Qj-74; Thu, 18 Sep 2025 17:01:04 +0200
Message-ID: <09ffce72-e826-4126-8761-13efc689dee7@pengutronix.de>
Date: Thu, 18 Sep 2025 17:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: add Protonic PRT8ML board
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, David Jander <david@protonic.nl>,
 Lucas Stach <l.stach@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
 <20250918-imx8mp-prt8ml-v2-3-3d84b4fe53de@pengutronix.de>
 <0f520191-7d9f-4800-a41e-a623b9335c9d@lunn.ch>
From: Jonas Rebmann <jre@pengutronix.de>
Content-Language: en-US
In-Reply-To: <0f520191-7d9f-4800-a41e-a623b9335c9d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Andrew,

On 2025-09-18 16:18, Andrew Lunn wrote:
>>   - Onboard T1 ethernet (10BASE-T1L+PoDL, 100BASE-T1+PoDL, 1000BASE-T1)
> 
> Are these PHYs connected to the switch? It just seems odd you have a
> switch with only one port connected to the outside world.

yes, the 10BASE-T1L+PoDL and 100BASE-T1+PoDL are. We didn't get to test
them, so I removed them from the devicetree.

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

