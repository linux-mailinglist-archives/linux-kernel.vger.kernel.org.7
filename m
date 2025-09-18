Return-Path: <linux-kernel+bounces-823321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA47B861E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECCC1C87DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDA254B19;
	Thu, 18 Sep 2025 16:51:15 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2441253950;
	Thu, 18 Sep 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214274; cv=none; b=aX3aKbFdrTWuN7kCQ1PLGU8HNjcMw5twmmH612+nnknt3Pk67CBKn00D7ZexA9yiQIwehE3is1V70DhpbRgRCYJ9R+meY/9JAYm+tYX2pcwaGztI6baxO8osMFSwUPGxlkxszofj8CFunMDvAAaX54la1P9XdSzg77HDRz7rETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214274; c=relaxed/simple;
	bh=3oi2Fyer5JQ3csQkRU60W6rqMzYZfb6AwwPPr74UVVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph4qV3rweLgaRJAxPgLMAsbp5PXpLJXxHuQMDFpXSTaUmi4CevqgON2LInLs6xzcfebGuxsBUiqLvvmVcmhDU1FD+UCuTCzJ8Ahq5pbH07vuxIFD54E6ca8T1f7Q2EOKcCYixD2wNtq8sTUpaMHGqc+suSq9Fls8vJGyER8WjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cSLsR0SvSz9sgS;
	Thu, 18 Sep 2025 18:37:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c-Hjp8AA_eSf; Thu, 18 Sep 2025 18:37:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cSLsQ6Hsnz9sgR;
	Thu, 18 Sep 2025 18:37:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C0B908B776;
	Thu, 18 Sep 2025 18:37:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OohEcxeSfQe1; Thu, 18 Sep 2025 18:37:46 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EFF928B767;
	Thu, 18 Sep 2025 18:37:45 +0200 (CEST)
Message-ID: <bad14e16-0d1c-411a-8b3d-89d8df05b9b5@csgroup.eu>
Date: Thu, 18 Sep 2025 18:37:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/4] ASoC: fsl: fsl_qmc_audio: Reduce amount of
 interrupts
To: Herve Codina <herve.codina@bootlin.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <cover.1758209158.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <cover.1758209158.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2025 à 17:34, Christophe Leroy a écrit :
> This is a RESEND of v3 sent one month ago, see:
> https://lore.kernel.org/all/cover.1754993232.git.christophe.leroy@csgroup.eu/

Sorry for the noise, v3 was 
https://lore.kernel.org/all/cover.1755504428.git.christophe.leroy@csgroup.eu/
The resent is correct though, only this reference in the cover is wrong.

Christophe

> 
> This series reduces significantly the amount of interrupts on
> fsl_qmc_audio device.
> 
> Patches 1 and 2 are preparatory patches.
> Patch 3 is the main change
> Patch 4 is a cleanup which is enabled by previous patch
> 
> Changes in v3:
> - Properly check the buffer descriptor is unused (Patch 1, comment from Herve Codina)
> - Fixed copy/paste error (patch 2, comment from Herve Codina)
> - Fixed build failure (patch 2, comment from Herve Codina and Test robot)
> 
> Changes in v2:
> - Don't remove UB bit (Patch 1, comment from Herve Codina)
> - Make sure audio channels are ordered on TDM bus (Patch 2, new patch, comment from Herve Codina)
> - Drop struct qmc_dai_chan  (patch 4, new patch)
> 
> Backgroup (copied from patch 3):
> 
> In non-interleaved mode, several QMC channels are used in sync.
> More details can be found in commit 188d9cae5438 ("ASoC: fsl:
> fsl_qmc_audio: Add support for non-interleaved mode.")
> At the time being, an interrupt is requested on each channel to
> perform capture/playback completion, allthough the completion is
> really performed only once all channels have completed their work.
> 
> This leads to a lot more interrupts than really needed. Looking at
> /proc/interrupts shows ~3800 interrupts per second when using
> 4 capture and 4 playback devices with 5ms periods while
> only 1600 (200 x 4 + 200 x 4) periods are processed during one second.
> 
> The QMC channels work in sync, the one started first is the one
> finishing first and the one started last is the one finishing last,
> so when the last one finishes it is guaranteed that the other ones are
> finished as well. Therefore only request completion processing on the
> last QMC channel.
> 
> On my board with the above exemple, on a kernel started with
> 'threadirqs' option, the QMC irq thread uses 16% CPU time with this
> patch while it uses 26% CPU time without this patch.
> 
> Christophe Leroy (4):
>    soc: fsl: qmc: Only set completion interrupt when needed
>    ASoc: fsl: fsl_qmc_audio: Ensure audio channels are ordered in TDM bus
>    ASoC: fsl: fsl_qmc_audio: Only request completion on last channel
>    ASoc: fsl: fsl_qmc_audio: Drop struct qmc_dai_chan
> 
>   drivers/soc/fsl/qe/qmc.c      |  44 +++++++++---
>   sound/soc/fsl/fsl_qmc_audio.c | 125 +++++++++++++++-------------------
>   2 files changed, 87 insertions(+), 82 deletions(-)
> 


