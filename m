Return-Path: <linux-kernel+bounces-862503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E1CBF5794
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FEC24FEB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831732ABC3;
	Tue, 21 Oct 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ElFhweFm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F13328B6F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038489; cv=none; b=CQg6yBSSYT553b0EFNU5Z5gFFx84GTIyc6wrc4nxZToUgGxLNb+n20nvg3vXICOq8DqgfIAgc/VBYBkZcEt2qp/oJongvQQRg/W98x1FZKkQcVl5dpN8tbo2LaePU7WCUBHs69Pxi9OuadYyafs3MO2aGHAEy2NzvOKacHcZJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038489; c=relaxed/simple;
	bh=XXyJCZos3E5ZJqBBG7b3ddkaP/DlVDtAoN+XRNfrIp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQvjb4RFb0s4m+XPtyql4C1SIM84OJBnsQrAvojx4Yx2H+05LiWFv5Xk9b+5kfIwKiFXtE1shJXNBgyYLGI2TKaOV9vHSxLO+bYauJ3IjbgdaQ0L6ndUhYh9DM0L8G7kXKQEJbB/2yoORuDrFmNZM1W8KEpW85xDA/wU+G1w5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ElFhweFm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8QrWw012723
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gM/ZFUlqNXs7NYCf8GTtAnW2dYUWBUEVXo+NQBumrNY=; b=ElFhweFmjfDLfmwJ
	ZAKEDXDfnB2UiRONMrZewn/p/kBB0kCLkfnkq1ZZBygh614q9VOWUixRSkkFeGmK
	K0T4CkEmFIR4Xt4T5KVkjybeDDOWAcEOFQ7N/NIoYPeVNL35lVG0dHK+5Ae5tqT0
	XMujJEWffqnEaqlzpitU8RzRgRbWHVSlBlr1RletMpxUuMNTVEYwD2etcOa0FxDt
	gyAaWXI2yVbCSnvgY3F5X0afsM2jCRxWFSe34ZFzP6k3JCytnku7BZpfjQjLoc2I
	cKFiYR6uVyEPW/gFHIALtoby40qj15O3Iaf6QPqXm+mxFwzHRXpmLIOWTBpOo1+f
	32WCmg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtgetcuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-891d8184bebso1024855585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038486; x=1761643286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gM/ZFUlqNXs7NYCf8GTtAnW2dYUWBUEVXo+NQBumrNY=;
        b=angNuo5l0pBiVI1lfUgRFWKyxE9YZiblcQQzqWrpH4kDgqkPqK9hEnidqJDkqpekFM
         IbQou2fzOrU8uiBx4ot2Lhniq8I4SeeVu4KDVQs8EqTTAgqUH8ENG+gAvUyV5nTGl5Ir
         6iNLcofK+t4PBGm5nI9ziGFpDgB76Sd+pThPYxkvziFaVZpMsQtYzi5vQKRZ1AlO3sdb
         SIv84yPjlGo+Y/N0sMtIykQ+vJr1eXFyULcvgAxmHLvjKxndtBe2PfHJaU24a/idYARR
         V6Je7MmqMkKluFmDjCgdqr2eyhtZAOdQRvJLp1hEfFJ3O730jhPiZNTeetN6/W1moS+O
         rUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68yZ0O1Q1ea9knQCCsdOHnD++k6XclO/icCr0x+FDrRfnQZHbpYWSHvRQjR+XUmQ9PrG1gqfKe5O82GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFRU4M3TF9M1dqP3kWEorKz1/4VNdmeGGi7lyfl9P1U3L5r+v
	QEIY4+iBpbGx43OGhoP4FKPsBW7RrWjVA1rXXHMGnGgiuPf7qb5kJCoht5zZAK317zoMyWnecjn
	TBUPK4p1G0v6f35oEGmPs/BSBJZ604OIllsIY7CJrO9zpoW5+TTfEJOjo+Grbg4XQUeA=
X-Gm-Gg: ASbGncvNBHkDHGdoQiTXpm9D0lgv9pUoJ6lecdtjr2IqX5zXvepMbou7WU/p+8APkQ3
	J6lN3ALfojybmWvwarwmSscQnXIvZG7m6TrTH3YmlS/6mLX8C4h9QIuyhjQRUsiehKSjEyWneP6
	FyV2XEol/b+ogZJfd4vtsQcVLe5uRSbfDuJd4DilYMi2eigv3C80lHjoJNOAk/86xVpCKxKslda
	15Pu2JM9fSKU6S1ojb0B/K8aDIdOZyBJswVYysoBWWE5k1/VhhSFv1mQ5/GBomjCisI2YqVazUy
	R8qU5LzPS+RDQ0zLbNpU+j3wVkybhzbtv2pcJmhzn4jyCDqhX6F2g6ysmMAjSAyWiui+tD2X+7P
	4ofT9LQhNjIwbrf+HUQURBBupSg==
X-Received: by 2002:a05:622a:1187:b0:4e8:a93b:b353 with SMTP id d75a77b69052e-4e8a93bc07dmr147144121cf.48.1761038486099;
        Tue, 21 Oct 2025 02:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrDJ7MVOlGdWV6qgW7hGvqATfKI0pCC2IiKaQg0Pa1Y23hpThIJvP6/JrxmDldH+C/K+XQ9w==
X-Received: by 2002:a05:622a:1187:b0:4e8:a93b:b353 with SMTP id d75a77b69052e-4e8a93bc07dmr147143851cf.48.1761038485432;
        Tue, 21 Oct 2025 02:21:25 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5a102fsm19507546f8f.1.2025.10.21.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:21:24 -0700 (PDT)
Message-ID: <f8b85e89-c546-4bcf-bc95-d109d453bfb1@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 10:21:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] ASoC: qcom: q6asm: handle the responses after closing
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Alexey Klimov <alexey.klimov@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-6-srinivas.kandagatla@oss.qualcomm.com>
 <DDN83LOTCUIP.5O05FBN02AZB@linaro.org>
 <7c0dad34-cb4c-4912-9406-2e559b91142a@oss.qualcomm.com>
 <60a48dfb-e266-425d-8cfb-574c637f5e9d@oss.qualcomm.com>
 <97afc64d-b384-4edb-9665-a5d654c19771@oss.qualcomm.com>
 <168c9cee-5f5b-4c45-82bd-45c911da4dd4@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <168c9cee-5f5b-4c45-82bd-45c911da4dd4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XeAsbqyfQj3uJ0gipk4ReBZjlGzKLAzh
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f75097 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XcquBd1hRxT_OMCIArQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: XeAsbqyfQj3uJ0gipk4ReBZjlGzKLAzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfX+C+ZaKRhClYR
 OqBCSSm9ItE/Nn3UaGd9bKJVZE59j4jhIss1rZATBn8ncTEd1FuevWArDSyskUdzp+aqaJeXZc+
 Yfd4osN7Yb1+cMA3DvdznlS2u+EItMC4PUmaylLVOr7OfXR1aX40yjdnKfxvB9/x33baBWjeXlq
 SMNqbG7qZG5GW58ZMsLIF5l2cU5SjCOWe5ua6znOBBsl8FxGx3ss8GbELN54ua5xWHEDX5HS6CY
 gfMwIVnED4s9XKzSlpUkI2FOV2yDI1yY4eTsPWa2SkHLRqEJRLKT0HA6yTw6nan1LwjFWbGea+Z
 0zAqEKNPhI0g4tmgQFxUuFA3A4uL1XBfkcKpGpT+5JegzMGn1fTYbaHfJbHJE2BmoI2hnTpZS6n
 NvVLk0f47DPQHwqIqqOwbDDRI9POuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154



On 10/21/25 10:12 AM, Konrad Dybcio wrote:
> On 10/20/25 4:42 PM, Srinivas Kandagatla wrote:
>> On 10/20/25 3:39 PM, Konrad Dybcio wrote:
>>> On 10/20/25 4:37 PM, Srinivas Kandagatla wrote:
>>>> On 10/20/25 3:35 PM, Alexey Klimov wrote:
>>>>> On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
>>>>>> For record path, multiple read requests are queued to dsp in advance.
>>>>>> However when data stream is closed, the pending read requests are rejected
>>>>>> by the dsp and a response is sent to the driver, this case is not handled
>>>>>> in the driver resulting in errors like below
>>>>>>
>>>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>>> q6asm-dai ab00000.remoteproc:glink-edge:apr:service@7:dais: command[0x10dac] not expecting rsp
>>>>>>
>>>>>> This is same for both write and eos.
>>>>>>
>>>>>> Fix this by allowing ASM_DATA_CMD_READ_V2, ASM_DATA_CMD_EOS and
>>>>>> ASM_DATA_CMD_WRITE_V2 as expected response.
>>>>>>
>>>>>> Reported-by: Martino Facchin <m.facchin@arduino.cc>
>>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>>>>
>>>>> I was also reporting this error months ago.
>>>>> Thanks for fixing this.
>>>>>
>>>>> FWIW there is also DSP timeout error on Audioreach-based platforms.
>>>> there should be only one for SPF get state command.
>>>>
>>>> qcom-apm gprsvc:service:2:1: CMD timeout for [1001021] opcode
>>>>
>>>> This is expected as we are checking for DSP readiness and it will
>>>> timeout if the dsp is not ready.
>>>
>>> Can we make the UX better by adding "bool timeout_expected" in the
>>> path that we "want" it to fail?
>> its not that we want it to fail, its just that we might fail, if we send
>> the command too early.
> 
> I came up with this to potentially work around it, but it seems a little
> heavy-handed to avoid a single line in dmesg..
> 
Yes it is. simple thing to do is wait for few ms before requesting for
SPF ready status, that should do that trick.

--srini

> 
> diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
> index 2365424a9b42..a39e717cb4e0 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.c
> +++ b/sound/soc/qcom/qdsp6/audioreach.c
> @@ -552,7 +552,7 @@ EXPORT_SYMBOL_GPL(audioreach_alloc_graph_pkt);
>  int audioreach_send_cmd_sync(struct device *dev, gpr_device_t *gdev,
>                              struct gpr_ibasic_rsp_result_t *result, struct mutex *cmd_lock,
>                              gpr_port_t *port, wait_queue_head_t *cmd_wait,
> -                            struct gpr_pkt *pkt, uint32_t rsp_opcode)
> +                            struct gpr_pkt *pkt, uint32_t rsp_opcode, bool silent_timeout)
>  {
>  
>         struct gpr_hdr *hdr = &pkt->hdr;
> @@ -579,7 +579,10 @@ int audioreach_send_cmd_sync(struct device *dev, gpr_device_t *gdev,
>                 rc = wait_event_timeout(*cmd_wait, (result->opcode == hdr->opcode), 5 * HZ);
>  
>         if (!rc) {
> -               dev_err(dev, "CMD timeout for [%x] opcode\n", hdr->opcode);
> +               if (silent_timeout)
> +                       dev_dbg(dev, "CMD timeout for [%x] opcode\n", hdr->opcode);
> +               else
> +                       dev_err(dev, "CMD timeout for [%x] opcode\n", hdr->opcode);
>                 rc = -ETIMEDOUT;
>         } else if (result->status > 0) {
>                 dev_err(dev, "DSP returned error[%x] %x\n", hdr->opcode, result->status);
> @@ -600,7 +603,7 @@ int audioreach_graph_send_cmd_sync(struct q6apm_graph *graph, struct gpr_pkt *pk
>  {
>  
>         return audioreach_send_cmd_sync(graph->dev, NULL,  &graph->result, &graph->lock,
> -                                       graph->port, &graph->cmd_wait, pkt, rsp_opcode);
> +                                       graph->port, &graph->cmd_wait, pkt, rsp_opcode, false);
>  }
>  EXPORT_SYMBOL_GPL(audioreach_graph_send_cmd_sync);
>  
> diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
> index d1b60b36468a..55ce1e367cda 100644
> --- a/sound/soc/qcom/qdsp6/audioreach.h
> +++ b/sound/soc/qcom/qdsp6/audioreach.h
> @@ -805,7 +805,7 @@ int audioreach_map_memory_regions(struct q6apm_graph *graph,
>                                   bool is_contiguous);
>  int audioreach_send_cmd_sync(struct device *dev, gpr_device_t *gdev, struct gpr_ibasic_rsp_result_t *result,
>                              struct mutex *cmd_lock, gpr_port_t *port, wait_queue_head_t *cmd_wait,
> -                            struct gpr_pkt *pkt, uint32_t rsp_opcode);
> +                            struct gpr_pkt *pkt, uint32_t rsp_opcode, bool silent_timeout);
>  int audioreach_graph_send_cmd_sync(struct q6apm_graph *graph, struct gpr_pkt *pkt,
>                                    uint32_t rsp_opcode);
>  int audioreach_set_media_format(struct q6apm_graph *graph,
> diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
> index 0e667a7eb546..f96c0ae20eb2 100644
> --- a/sound/soc/qcom/qdsp6/q6apm.c
> +++ b/sound/soc/qcom/qdsp6/q6apm.c
> @@ -34,7 +34,16 @@ int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt, uint32_t rsp_opc
>         gpr_device_t *gdev = apm->gdev;
>  
>         return audioreach_send_cmd_sync(&gdev->dev, gdev, &apm->result, &apm->lock,
> -                                       NULL, &apm->wait, pkt, rsp_opcode);
> +                                       NULL, &apm->wait, pkt, rsp_opcode, false);
> +}
> +
> +static int q6apm_send_cmd_sync_may_timeout(struct q6apm *apm, struct gpr_pkt *pkt,
> +                                          uint32_t rsp_opcode)
> +{
> +       gpr_device_t *gdev = apm->gdev;
> +
> +       return audioreach_send_cmd_sync(&gdev->dev, gdev, &apm->result, &apm->lock,
> +                                       NULL, &apm->wait, pkt, rsp_opcode, true);
>  }
>  
>  static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm, uint32_t graph_id)
> @@ -154,7 +163,7 @@ static int q6apm_get_apm_state(struct q6apm *apm)
>         if (IS_ERR(pkt))
>                 return PTR_ERR(pkt);
>  
> -       q6apm_send_cmd_sync(apm, pkt, APM_CMD_RSP_GET_SPF_STATE);
> +       q6apm_send_cmd_sync_may_timeout(apm, pkt, APM_CMD_RSP_GET_SPF_STATE);
>  
>         kfree(pkt);
>  
> diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
> index 81554d202658..7b71d6dfc993 100644
> --- a/sound/soc/qcom/qdsp6/q6prm.c
> +++ b/sound/soc/qcom/qdsp6/q6prm.c
> @@ -52,7 +52,7 @@ struct prm_cmd_release_rsc {
>  static int q6prm_send_cmd_sync(struct q6prm *prm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
>  {
>         return audioreach_send_cmd_sync(prm->dev, prm->gdev, &prm->result, &prm->lock,
> -                                       NULL, &prm->wait, pkt, rsp_opcode);
> +                                       NULL, &prm->wait, pkt, rsp_opcode, false);
>  }
>  
>  static int q6prm_set_hw_core_req(struct device *dev, uint32_t hw_block_id, bool enable)
> 
> Konrad
-


