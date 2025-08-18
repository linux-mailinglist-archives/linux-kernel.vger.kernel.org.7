Return-Path: <linux-kernel+bounces-773217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30C4B29CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE422A2FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377E3093B8;
	Mon, 18 Aug 2025 08:51:13 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA63009F0;
	Mon, 18 Aug 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507073; cv=none; b=lsK5p1uRWqsTCWFH1lEDAkVybq0wg21Kz+GIQaNfT0vtUtVxe+9L21gL6rHr+eiHSol0pUzC5pQATLO0RxHEFRtRqF6C6xmsBkKpM2dLHOSA8BIKIvnwyoRCIyUS9K8THwMf9R8FfWePskrtWhFVWi/pzQEl797EirZK6a3Y3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507073; c=relaxed/simple;
	bh=1QL2C769mUKAFJfkINnZ0934nbClZgCaZhIhi9QNnUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACgfHDdIduir89l+OzUhoVyXhbnyXflsa3ctpb6Sz4KyMbJxknXNJg8IoS/fcdDtONBjVALA/JoikW6bYZ7G47FTaqS1HLQRS9rSaucQOJWxeULihr2IJoIYwzZsej6TvS6TMwazmLZsozoMvqvEfHOctQHbh38CLuTQft/zi+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c55Fx3PBzz9sW3;
	Mon, 18 Aug 2025 10:18:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vnj3VDrR4Hnq; Mon, 18 Aug 2025 10:18:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c55Fx2gYYz9sW1;
	Mon, 18 Aug 2025 10:18:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 465088B764;
	Mon, 18 Aug 2025 10:18:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id uRYqQBvN43Yy; Mon, 18 Aug 2025 10:18:45 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 137DE8B763;
	Mon, 18 Aug 2025 10:18:45 +0200 (CEST)
Message-ID: <aacc97c0-2cc6-4192-9b19-5234ccd93504@csgroup.eu>
Date: Mon, 18 Aug 2025 10:18:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ASoc: fsl: fsl_qmc_audio: Ensure audio channels
 are ordered in TDM bus
To: Herve Codina <herve.codina@bootlin.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <cover.1754993232.git.christophe.leroy@csgroup.eu>
 <8d01cf4599664188c92a515922d68c9834263384.1754993232.git.christophe.leroy@csgroup.eu>
 <20250813120657.1e93b16b@bootlin.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250813120657.1e93b16b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/08/2025 à 12:06, Herve Codina a écrit :
> Hi Christophe,
> 
> On Tue, 12 Aug 2025 12:50:56 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
> ...
> 
>> @@ -879,6 +884,30 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
>>   				return -EINVAL;
>>   			}
>>   		}
>> +
>> +		ret = qmc_chan_get_ts_info(qmc_dai->qmc_chans[i], &ts_info);
>> +		if (ret) {
>> +			dev_err(qmc_audio->dev, "dai %d get QMC %d channel TS info failed %d\n",
>> +				qmc_dai->id, i, ret);
>> +			return ret;
>> +		}
>> +
>> +		last_rx_ts = fls64(ts_info.rx_ts_mask);
>> +		last_tx_ts = fls64(ts_info.rx_ts_mask);
>                                                
> tx_ts_mask instead of rx_ts_mask for last_tx_ts.
> 

Fixed in v3

Thanks
Christophe

