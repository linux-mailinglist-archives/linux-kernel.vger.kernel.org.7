Return-Path: <linux-kernel+bounces-822137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F2B831D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD04E057A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18902D7D35;
	Thu, 18 Sep 2025 06:20:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245027B357;
	Thu, 18 Sep 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176438; cv=none; b=kptzeGi7YXOpdsuM52DEj76JpHYPXIrPhLbSdKrwFO9ax0iF4P8pVKIYNMY26gU8IsKyaFvSs0ulodRYoW6yAasYcfKdHLqSusjABTrADcq84AZtthnFxZ3F5hsxVtz5ov2YkKa4+G7t+PhJeX7VvOqtGydffvN7UhwZJx8N5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176438; c=relaxed/simple;
	bh=UtKz5/IYin2NYot8gke7h0Z7q9s5XgcbUcnm7u+9bcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvJrRbcR6Dh3RJQCCZLZm4olzjggdnpWjWG9twXalQcBj24QnYxg0oyk+GPLSSqkLDEystfP8fMueqAUNhQFqBCw1P1WPKlO4t1Chd0PJmg0yWLrhs1g4whUC2j5xJd4GA20jGUEXZ5PxbGO7PK31LmmFCWrBxFZGW8TKthTxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cS4zq5Xdlz9sg0;
	Thu, 18 Sep 2025 08:12:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FbE0_hDQWI6h; Thu, 18 Sep 2025 08:12:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cS4zq4ZMvz9sfy;
	Thu, 18 Sep 2025 08:12:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 88BFD8B76C;
	Thu, 18 Sep 2025 08:12:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wUtKhrQoSrmI; Thu, 18 Sep 2025 08:12:23 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C07208B767;
	Thu, 18 Sep 2025 08:12:22 +0200 (CEST)
Message-ID: <3d20d3ec-2f52-4cac-9c5c-fd2141a12a0b@csgroup.eu>
Date: Thu, 18 Sep 2025 08:12:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] ASoC: fsl: fsl_qmc_audio: Reduce amount of
 interrupts
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, linux-sound@vger.kernel.org,
 Qiang Zhao <qiang.zhao@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>
References: <cover.1755504428.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <cover.1755504428.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark, Liam,

Le 18/08/2025 à 10:19, Christophe Leroy a écrit :
> This series reduces significantly the amount of interrupts on
> fsl_qmc_audio device.

I can't see this series in linux-next.

I see in patchwork [1] that this series still has status 'NEW' but also 
state 'archived'.

What is the way forward to get it applied for v6.18 ?

Thanks
Christophe

[1] 
https://patchwork.kernel.org/project/alsa-devel/patch/f0c5260651822e8003daf11c7a76921796517152.1755504428.git.christophe.leroy@csgroup.eu/

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


