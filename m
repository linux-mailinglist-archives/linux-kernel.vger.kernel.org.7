Return-Path: <linux-kernel+bounces-864736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992CBFB6CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE041A04B81
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0A2EC0A9;
	Wed, 22 Oct 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UhmDuNmL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E6299923
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129283; cv=none; b=oAtRi8h9Z90uq49IaIYuhesqYwKana1EzUE0AV06Nf/iMbkxxy/7rjFHcJpfw7AdLj+H+z8aG4LgWcd/NK/qoSIrzacVhf891HsZrCsOaYik996YEx8ZphyXujUuEDwk35ALwD1FuFsRgEH4N4zEiLB6FCiLbqciUJa+a/AGx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129283; c=relaxed/simple;
	bh=QpMNfT7FmfE9DJjiA0JFNPgcEP1z3UGq7yfCQDkFKVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0BFlZCiDrrmT/zGqnAXnMqgN2bFh4Y8c5QT2ZYj21twDKtZIuy6m/ALh5UofRKstgc8IhM1eK+38lDjNmiSMrHXJo/k2ryDB/R5f3x1ZNLJ2sCtvV1bYDzJqA50BvPT/qnqROZN4Ion1AZpKdW8t/dDJoK7d9AD9/2B9H+GtJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UhmDuNmL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAQBcH005242
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ey36IRL4isg0/uNf3V/qgF/w
	XSf+ypTyipvXiTiDYHg=; b=UhmDuNmLfkLoPHPCiTu0KGf5/uMGk6H/V+wkb8DH
	xfeaUFz97MZMEsZBsRlgiYG+wZi29raAPyU0udr8HIAkUkgZvdWJt7N+u95ZiSmx
	HDd8We4o+GwUDoRbjnSpp9wYo5D6/7oADQ6Bhklq5/qZgWPrZKo8VHQgyPVlsqsV
	K8UJ+t81txXg9EUuk5PPSLcQQw3ycYlKWQ8stgVRHq0vh8SYu7UE9q9KwehH4yHD
	aoUt7ObmnqqOU5BJeOfU1icpEyehZrwlyoXlXe9alGpVYVsOVrVVtOOkyKoczBPs
	k+5tEYHUevZZ4FQK1myt5ARguRA2lJP9iS8RJk0UO7INPg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfm8nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:34:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a387d01bso38466791cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761129280; x=1761734080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ey36IRL4isg0/uNf3V/qgF/wXSf+ypTyipvXiTiDYHg=;
        b=KlI1fSudDjWoXBo2KmXTPKJoz4TFNNiLtDvQ0W+eNYD7DrNlFHaOieJq+RaJBy30yw
         hB1c2Q1e8EGOjdKQ4sgSWQSc2ytZ4FRQWRYIRABGBI7hJtdrCeWDeZYkTKK1fnZSdluO
         hcC7ZWfmCrjIjY9fa6jglFtz4LHYRNjuDfKLxInaKlrZE4Z+Fs6wbw7J7eqKUaPHeKIu
         NYKEZ+VisRULXXDCawlmTMRfWaNLKeD6BgL5s1Fu8Gju2N88Qa3gRG8A+Ie5SwHr38pm
         rKhvpkAwzwD4aJCvN1JZuldvr5ouuRssyvGuhL9cJB7j6aYyH7/DMDQXbImoSCHxOj5v
         DxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGG1bdWcGV4vUetfpuHUdDc0wjFIhSz9xPz+LZfLe0crsTm6Iug4RzoasY22kzNUDmR06akNOoLkujZdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23EPX3OY8RxlnOx569sQ/VxQ6G/ti08q9np+KDJJGz9Cxsskz
	IHX0jJaZVmy59upDESsDTteXgPcrCaVksRC/SqvgcoGExUoUNwPl0uLYG1xCXvPpvGMnQLt7Wfa
	xCpbLWoenAotV9izmI6+J77aUXXaUKVd1oKnYNfqJ7Ahq7EWYJuCAqstj8SqOFE6IPps=
X-Gm-Gg: ASbGncvkt1hi8krOQL3fyiV+VM9uJrnuTkp8qscGYM69OmMKBOUiGNfDmMmJJS5gP9k
	m6rJWKWQvOXGDNU7DhzdhuJSSSfpOqMyIXLbFpQJBznzympIWqL6g3YugutIl+8bZmZzJcz1YQf
	dDrSdHjWiX4cqyxXu0DxFestm7iufBvwKgpx6F3wHo1dgf2IcExQuV6cmt6Uxy4q2lU/LqYIgWP
	RH8aS3zcHLE62eQmcOF7N59AY6KrtEB0K0uZi42PAIAa3PumAIiFEmHEWnej5+SIS+atrs9zqIM
	/SRVTlmW4Bi2ai/f7ZHmIEwSuR3dnrExEQo/7xTPlDUQ+87OCfZswHR+AzINS/b4Y8Hf2iiQ7AX
	A5VEZXvJZa7103VvWQVQIkOgCzI83dJcGPwRW19r8ZlwmYjAle3qfqx23yVA6h+Ijr5u0IhYHnG
	O0e6zQ+blgRPo=
X-Received: by 2002:a05:622a:3cc:b0:4e8:a8be:5857 with SMTP id d75a77b69052e-4e8a8be5e94mr171268961cf.55.1761129280262;
        Wed, 22 Oct 2025 03:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQLkTKu9y3Ou0mi+Djx6Gq6aJaXaybifcjUti0v+lLVcSxUR5WWEF0kxHzawkEmfJY+aBmeg==
X-Received: by 2002:a05:622a:3cc:b0:4e8:a8be:5857 with SMTP id d75a77b69052e-4e8a8be5e94mr171268571cf.55.1761129279594;
        Wed, 22 Oct 2025 03:34:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def26992sm4554093e87.103.2025.10.22.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:34:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:34:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] ASoC: qcom: x1e80100: Add Dell XPS13 9345 support
Message-ID: <sihiwhcdra2kviuago7r6gnm6b4goqcpjgt43loen5alk4atze@mhklkp2hz5y6>
References: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
 <20251021-dell-xps13-9345-enable-audio-v1-2-6f3f6bbd977b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-dell-xps13-9345-enable-audio-v1-2-6f3f6bbd977b@linaro.org>
X-Proofpoint-ORIG-GUID: OI1qKehYD0FSvc8iwjRWLEDfoKYjC2_b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfXyQ38IUI5HGiO
 N2d7Lvw3lBYMiaedJXbXcrjTorI4KEO9efU4CkxcCthM2ztxRmEdt0xq4EYAqqSzsaRPP08/qiw
 bBZQtS3ExRiaJx2IkMVe9DC7Dw6zLbs8CNcHXszuJcxEVfPHfMPkGQavqYhadYE6gT4CNMSr0Qv
 uNp6Q4bKLSv5Cb168nBDQpdQfsWUfgfrUn8XvyB21VA9iI7UsD8gX9e/tDi+qeNWE6995l+rZJE
 sOM3opazTLzgC6il3YmMgOKjAwK0sHSpwzm/o698yrtxeue75brlmYKxpA6QT308QUjDM2VXS9o
 hfXNAFt3Y/h79G3P2gI7P57Sbg3lUm8gWOXua60Vg7tOTGxNn5DUkXvXJ+6QaOTZjwygFYqhExz
 d2GLX2O/VuQ0ACnHW4DDVcJzrMcdqw==
X-Proofpoint-GUID: OI1qKehYD0FSvc8iwjRWLEDfoKYjC2_b
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f8b341 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=7aqP5zvjfKpTuSzq1rEA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027

On Tue, Oct 21, 2025 at 04:50:45PM +0300, Abel Vesa wrote:
> On Dell XPS13 9345, the PCM channels are mapped starting with right
> hand side instead of left. So in order to support this, we need to
> hardcode the mapping and tie it up to a dedicated board compatible.
> 
> So define a match data that brings the mapping as well, for the XPS 13,
> while the rest of the boards will fallback to use the mapping based
> on number of channels.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  sound/soc/qcom/x1e80100.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
> index 444f2162889f7d9d4b6b06bddc980d8a15dd988b..e21cf534b2ac3875b694f381f260164acb2e3ae4 100644
> --- a/sound/soc/qcom/x1e80100.c
> +++ b/sound/soc/qcom/x1e80100.c
> @@ -15,10 +15,17 @@
>  #include "qdsp6/q6dsp-common.h"
>  #include "sdw.h"
>  
> +struct x1e80100_snd_cfg {
> +	const char *driver_name;
> +	const unsigned int *channels_map;
> +	int channels_num;
> +};
> +
>  struct x1e80100_snd_data {
>  	bool stream_prepared[AFE_PORT_MAX];
>  	struct snd_soc_card *card;
>  	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
> +	const struct x1e80100_snd_cfg *cfg;
>  	struct snd_soc_jack jack;
>  	struct snd_soc_jack dp_jack[8];
>  	bool jack_setup;
> @@ -95,8 +102,16 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
>  	return qcom_snd_sdw_hw_params(substream, params, &data->sruntime[cpu_dai->id]);
>  }
>  
> -static int x1e80100_snd_hw_map_channels(unsigned int *ch_map, int num)
> +static int x1e80100_snd_hw_map_channels(struct x1e80100_snd_data *data,
> +					unsigned int *ch_map, int num)
>  {
> +	if (data->cfg->channels_map) {
> +		for (int i = 0; i < data->cfg->channels_num; i++)
> +			ch_map[i] = data->cfg->channels_map[i];
> +
> +		return 0;
> +	}

Why by default the driver remaps channels depending on the usecase, but
for XPS we use a static map?

> +
>  	switch (num) {
>  	case 1:
>  		ch_map[0] = PCM_CHANNEL_FC;

-- 
With best wishes
Dmitry

