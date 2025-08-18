Return-Path: <linux-kernel+bounces-773216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F5B29CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C7518A484E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1669304BDA;
	Mon, 18 Aug 2025 08:51:09 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA903002DE;
	Mon, 18 Aug 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507069; cv=none; b=X+/yybqP3OgCCuk0tcS+tDWlLHzTM3pEk0wA2A9vGeSTAt1+5YGJFdKvnaUu1tgQbVcVM0N/83IvnIEs8L88+IiwRYjh9YFQG0DOxwOBi8IkQ58LTZxaGn3KYd8J4AoiNfqbMnmAO9jFr3WQQ3RpBmu4ZSSzamgvrVir3i53AJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507069; c=relaxed/simple;
	bh=/g9PHUGI4DtEkgecaZtNdKZ2AKE74F9mkVJJ/CE5MBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx1G6+RXxxWTTWJmWwVeD1iOiNKBXsdueHfVse99XexanYpVoqr/GTLoOLtpY0vDVgAJf9SzEZpq6JfhqibSDG1TIBwfBr9coBmYajpkezNYmWGs6R0DBdKIOewiYEVQsBVT5VRUn5j/XLM4bZ9NbjtMXJ5ZtC94nUfHNZyvtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c55FY6wKBz9sW0;
	Mon, 18 Aug 2025 10:18:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMU1reJG0jOi; Mon, 18 Aug 2025 10:18:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c55FY69pzz9sVx;
	Mon, 18 Aug 2025 10:18:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BD3768B764;
	Mon, 18 Aug 2025 10:18:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id E2DQQggsZVWb; Mon, 18 Aug 2025 10:18:25 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8617A8B763;
	Mon, 18 Aug 2025 10:18:25 +0200 (CEST)
Message-ID: <384e2b94-186f-436c-aa69-3cc41a38552c@csgroup.eu>
Date: Mon, 18 Aug 2025 10:18:25 +0200
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
 <20250814094502.4b350b3e@bootlin.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250814094502.4b350b3e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/08/2025 à 09:45, Herve Codina a écrit :
> On Tue, 12 Aug 2025 12:50:56 +0200
> Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> To reduce complexity of interrupt handling in following patch, ensure
>> audio channels are configured in the same order as timeslots on the
>> TDM bus. If we need a given ordering of audio sources in the audio
>> frame, it is possible to re-order codecs on the TDM bus, no need to
>> mix up timeslots in channels.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v2: New
>> ---
>>   sound/soc/fsl/fsl_qmc_audio.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
>> index 5614a8b909edf..0be29ccc1ff7b 100644
>> --- a/sound/soc/fsl/fsl_qmc_audio.c
>> +++ b/sound/soc/fsl/fsl_qmc_audio.c
>> @@ -791,12 +791,17 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
>>   			       struct qmc_dai *qmc_dai,
>>   			       struct snd_soc_dai_driver *qmc_soc_dai_driver)
>>   {
>> +	struct qmc_chan_ts_info ts_info;
>>   	struct qmc_chan_info info;
>>   	unsigned long rx_fs_rate;
>>   	unsigned long tx_fs_rate;
>> +	int prev_last_rx_ts = 0;
>> +	int prev_last_tx_ts = 0;
>>   	unsigned int nb_tx_ts;
>>   	unsigned int nb_rx_ts;
>>   	unsigned int i;
>> +	int last_rx_ts;
>> +	int last_tx_ts;
>>   	int count;
>>   	u32 val;
>>   	int ret;
>> @@ -879,6 +884,30 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
>>   				return -EINVAL;
>>   			}
>>   		}
>> +
>> +		ret = qmc_chan_get_ts_info(qmc_dai->qmc_chans[i], &ts_info);
> 
> qmc_chan_get_ts_info() need a struct qmc_chan as first parameter
> 
> qmc_dai->qmc_chans[i].qmc_chan instead of qmc_dai->qmc_chans[i].
> 
> The use of qmc_dai->qmc_chans[i] without .qmc_chan have to be done on patch 4 (cleanup patch).

Fixed in v3

Thanks
Christophe

