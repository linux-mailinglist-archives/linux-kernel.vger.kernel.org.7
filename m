Return-Path: <linux-kernel+bounces-773219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3771B29CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112A61964019
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D030BF79;
	Mon, 18 Aug 2025 08:51:24 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE830BF77;
	Mon, 18 Aug 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507083; cv=none; b=ggp3r1Iv40/XUq77k4iqfS/fxvV2tj+2wIRtQRvTXVEi9XKCjX2/NJTlns9UPhl/35OXE2uX13Dj4FUFCHtVT+GpWXwlQHfubatIvZjO2MnpdCDJHs2j29Nm7XZpwsebmN9a2IsVU143cq31VBXddZkBpL9issoPAgX2dS1DTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507083; c=relaxed/simple;
	bh=ptDCV0rtHBFUS77q/RY1rCVyHISAL+78Wg96fyrEU+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cz05XF6mcrBAtok/SNxouRuOKKOxb55G01/pgMpFVSe0gPXcgdcmmYkjIL7c3ExnpVc/xjEK332xZKcn77O4tKMFnImrHglykOwxdhoWTgfPQZu3ku0V3fizeb5FIZszlxQsy+IHfWbCJp/iAcTZJylgRDCt008/7FyhaiLmiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c55C50qHxz9sVk;
	Mon, 18 Aug 2025 10:16:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K5xAwfCwBfZs; Mon, 18 Aug 2025 10:16:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c55C46fb9z9sVf;
	Mon, 18 Aug 2025 10:16:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CB4FE8B764;
	Mon, 18 Aug 2025 10:16:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9jsli9on6cF7; Mon, 18 Aug 2025 10:16:16 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C15C8B763;
	Mon, 18 Aug 2025 10:16:16 +0200 (CEST)
Message-ID: <06c3012d-96f1-434a-af17-a1705eede7d6@csgroup.eu>
Date: Mon, 18 Aug 2025 10:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soc: fsl: qmc: Only set completion interrupt when
 needed
To: Herve Codina <herve.codina@bootlin.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <cover.1754993232.git.christophe.leroy@csgroup.eu>
 <badb68a85910e5e6f1094ef3b01805209ac21854.1754993232.git.christophe.leroy@csgroup.eu>
 <20250813120651.27dc8467@bootlin.com> <20250814093443.1506b49f@bootlin.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250814093443.1506b49f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hervé,

Le 14/08/2025 à 09:34, Herve Codina a écrit :
> Hi Christophe,
> 
> On Wed, 13 Aug 2025 12:06:51 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> 
>> Hi Christophe,
>>
>> On Tue, 12 Aug 2025 12:50:55 +0200
>> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>>
>>> When no post-completion processing is expected, don't waste time
>>> handling useless interrupts.
>>>
>>> Only set QMC_BD_[R/T]X_I when a completion function is passed in,
>>> and perform seamless completion on submit for interruptless buffers.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>> v2: Keep the UB flag to mark not completed buffers and seamlessly flag them as completed during next submit.
>>> ---
>>>   drivers/soc/fsl/qe/qmc.c | 44 ++++++++++++++++++++++++++++++----------
>>>   1 file changed, 33 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
>>> index 36c0ccc06151f..8f76b9a5e385d 100644
>>> --- a/drivers/soc/fsl/qe/qmc.c
>>> +++ b/drivers/soc/fsl/qe/qmc.c
>>> @@ -461,9 +461,16 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
>>>   
>>>   	ctrl = qmc_read16(&bd->cbd_sc);
>>>   	if (ctrl & (QMC_BD_TX_R | QMC_BD_TX_UB)) {
>>> -		/* We are full ... */
>>> -		ret = -EBUSY;
>>> -		goto end;
>>> +		if (!(ctrl & QMC_BD_TX_I) && bd == chan->txbd_done) {
>>> +			if (ctrl & QMC_BD_TX_W)
>>> +				chan->txbd_done = chan->txbds;
>>> +			else
>>> +				chan->txbd_done++;
>>> +		} else {
>>> +			/* We are full ... */
>>> +			ret = -EBUSY;
>>> +			goto end;
>>> +		}
>>>   	}
>>>   
>>>   	qmc_write16(&bd->cbd_datlen, length);
>>> @@ -475,6 +482,10 @@ int qmc_chan_write_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
>>>   
>>>   	/* Activate the descriptor */
>>>   	ctrl |= (QMC_BD_TX_R | QMC_BD_TX_UB);
>>> +	if (complete)
>>> +		ctrl |= QMC_BD_TX_I;
>>> +	else
>>> +		ctrl &= ~QMC_BD_TX_I;
>>>   	wmb(); /* Be sure to flush the descriptor before control update */
>>>   	qmc_write16(&bd->cbd_sc, ctrl);
>>>     
>>
>> You try to purge one descriptor for which the transfer is done but you do that
>> when you have no more free descriptors.
>>
>> You end up with all descriptor "used". I think a better way to do that is
>> to purge all "done" descriptor configured to work without interrupts until a
>> descriptor with interrupt is found.
> 
> I have looked again at your code and looking for a free descriptor only when it
> is needed is sufficient. You can forget my previous proposal.
> 
> Back to your code, I think you need to be sure that the descriptor you want to
> re-use is really available and so you need to check the 'R' bit to be sure
> that we are not with 'R' = 1 and 'UB' = 1 which means "BD is used, waiting for
> a transfer".
> 

Fixed in v3.

Thanks
Christophe

