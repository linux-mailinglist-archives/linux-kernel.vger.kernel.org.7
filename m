Return-Path: <linux-kernel+bounces-798057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92492B418FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520EB3B9277
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CC2DF132;
	Wed,  3 Sep 2025 08:46:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535726A1D8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889199; cv=none; b=GgKuN1orA1MP8TNblp6ed442jsEgLva2BkQB5PT2dNlBOicr8d1gHFxavg3QNGknA4k2UsnGHeYSJ3Fdw1NqT+b5zhSimnMHm9EBR9HHGOHE2Qh+oKly3FZHG4ojQ84pbWd4RWsioVBQk44ivYKvLf6GUNxxFkJPZIab0mZIVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889199; c=relaxed/simple;
	bh=yTFJjzqMU9ZzFUybZd6hkNW7zE/eIZgW+25kCR/mtpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwlNSieOyDFhx/1c0khxG16ONBFg6lxsGpzX/DQYRdje3sLQrvcpOw9SRhapD8V52+B8m17GlUf3R9njMurTtr7BuZq1lf1IIzplViWaTOAyct79aqc+XqHz6GBwZR21V3NS8O2QJmauhlnShc+YO4ZeGBcQizJcGb+zfrZiSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1utj8M-0004jB-AR; Wed, 03 Sep 2025 10:46:26 +0200
Message-ID: <5e993e2a-a0bf-45cc-8d95-75cfc1575a41@pengutronix.de>
Date: Wed, 3 Sep 2025 10:46:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 Csaba Buday <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
 <fa7e2cef-5242-4f3b-84ea-d77b959f6bdb@pengutronix.de>
 <c85a94ee-59e1-47d6-8200-813bb434caf2@prolan.hu>
 <1bf75411-4a51-4103-b314-a8a7253bafca@pengutronix.de>
 <57518c46-2e92-4689-80a3-ae4c99b9fc32@prolan.hu>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Language: en-US, de-DE, de-BE
In-Reply-To: <57518c46-2e92-4689-80a3-ae4c99b9fc32@prolan.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On 9/3/25 9:57 AM, Csókás Bence wrote:
> On 2025. 09. 03. 9:50, Ahmad Fatoum wrote:
>> On 03.09.25 09:43, Csókás Bence wrote:
>>> [1] https://lore.kernel.org/lkml/20250709133222.48802-4-
>>> buday.csaba@prolan.hu/
>>
>> Is this mainline yet?
> 
> Unfortunately, no. It apparently still needs some polish.

So you are trading one breakage for another here. This needs to be spelt
out along with rationale.

Alternatively, see my suggestion in the reply to Csaba.

Cheers,
Ahmad



> 
> Bence
> 
> 

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


