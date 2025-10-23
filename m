Return-Path: <linux-kernel+bounces-866500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3508BFFEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E53AB08A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770F2FE575;
	Thu, 23 Oct 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z9EtBMWu"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8352F7AAF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208201; cv=none; b=W/6Vfm8DRFgSblYjwbo80Eh50IQEfn2r0ASIk+IY7sK5LXXKTtNwfk1+ns3x1+56Qzy3oBOPJIwzOd9AlUmOaiMU2ewiwIJA0Y18qFhBS0nEbLsrRguWwc7rSDK//CrllmkXnA3TvQfSEgacKo9KmwyOQX/+MviGzKvuztT+WxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208201; c=relaxed/simple;
	bh=RVOGLO4SU6Ag9PiMozB+SId9BXOCoH5S3lwExhVdiQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAOB9Za6CpXrSxtE1tFMNMFbAy2/DzJ0JIPU2I+0K0/tGHrshsHRZ+LNPuAYvEYQu2P4JcIoeIQwYFDb1Q6Xk7450YmQX1DSD4DZA+YGxanA3T0TnBz4qXYRcAWL3+LEzljwowah62vuF4xztIreb8W/gqQuPuCskh63s7AYT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z9EtBMWu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2BD464E41298;
	Thu, 23 Oct 2025 08:29:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3BE86062C;
	Thu, 23 Oct 2025 08:29:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA200102F245F;
	Thu, 23 Oct 2025 10:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761208190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=r9GcjNdKx0l5qe7F9q2vo9g6zEhRHjHM5Fp6gH11pEQ=;
	b=Z9EtBMWuXLdFsMpNL5Is/fGSdVkHMoU8On73jz/5/ppGCGeFA/s+BGs5fNBndHP/oE871A
	Kwf77bbihCJTwF2SHIIloFW/npmFuSEW9T1aNCmWFlVk2urveiGjvVxKBzjOcUb1FuPTjc
	N1UZY1+fzrl69/hREa0jTum9igth/ny1umb8LP1B7v+4PWW18Pc8iVnihuAgBElu6Zckg7
	ZpqK34HeP6g3pp37DftoKuVKZpL/yre5EvwGMsncIEtc8X6Q9BvAHc+tTTVlK7g3aJqFTy
	SL91odbrCbiLSoeyIKOUWZKhCaCe0ibxcolKfL2yT5j0H6Q1Gqr/UAJmto0eBA==
Message-ID: <ac505a82-1a01-4c1d-8f9b-826133a07ecf@bootlin.com>
Date: Thu, 23 Oct 2025 10:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-3-maxime.chevallier@bootlin.com>
 <20251017182358.42f76387@kernel.org>
 <d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
 <20251020180309.5e283d90@kernel.org>
 <911372f3-d941-44a8-bec2-dcc1c14d53dd@bootlin.com>
 <20251021160221.4021a302@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251021160221.4021a302@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 22/10/2025 01:02, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 10:02:01 +0200 Maxime Chevallier wrote:
>> Let me know if you need more clarifications on this
> 
> The explanation was excellent, thank you. I wonder why it's designed
> in such an odd way, instead of just having current_time with some
> extra/fractional bits not visible in the timestamp. Sigh.
> 
> In any case, I don't feel strongly but it definitely seems to me like
> the crucial distinction here is not the precision of the timestamp but
> whether the user intends to dial the frequency.

Yes indeed. I don't have a clear view on wether this is something unique
to stmmac or if this is common enough to justify using the tsconfig API.

As we discuss this, I would tend to think devlink is the way, as this
all boils down to how this particular HW works. Moreover, if we use a
dedicated hwprov qualifier, where do we make it sit in the current
hierarchy (precise > approx) that's used for the TS source selection ?

Maxime

