Return-Path: <linux-kernel+bounces-814067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E8B54EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814027C65ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745830C37C;
	Fri, 12 Sep 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTgoGUyB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DB305077
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682624; cv=none; b=ZQJOKrZBjpEOmQf0hnbHFKhWmaqqeOLXeR/ub0rW4IZEGdQvSKnUwnXdiHT0S+edjPaBhS31F4r5fD1nKJscKoerd3fgWC9itTfJMEIvRdU2bxkjWgI0bUHDT7UczKGFaE1ABFgNlhITruCLSeDHI0BePB0r+u3yD2AVhSHQhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682624; c=relaxed/simple;
	bh=XxEsZ9QOT0wQkWJJQFHlMg2enGMiE5WFQwRa1OzgxBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ9iuSmwdLDclrGPNZDJn/Xj+79lblsIOOEJgV3uPh1XrHN/+6Tc74BtE82QMh6kTT39MvNpage7Ps0Gcb1hTATqgLvibyV6b4I1a2tpXAV1bWG0DB353pBIeL/CKvBneI4ekeOg98oruN/nxBJ9ldVIG+nBqOefbE6ecXSF/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTgoGUyB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fike023969
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3ZuuUGQBOUzotJ0AURfxJazlW1Inl9eU+TFGm3oovUI=; b=ZTgoGUyBjEMZFNQS
	/v1ug3l5ayfZ1NUAmXaqbuY/xD8fsKCCWQ0bT1IeV2x72MHekl0IE9wgfbMOQfYu
	PKmfc1OXQ5Dy3Tfq3lcU+c+aeCX5BZ5kz9fHrcU1MPBRC/QIwylIufxCD7WdDoRg
	NIKnojqdjmx22J22MjbE61ihhSA28a021AMeMIlDQ3PnVInDAwsudSQ77O+rdiFZ
	bk7Q5OIkJ4QXOn4YELmUyaTppAUmL1gj+6oNSmPI4w1r24tKj4h4bI3BYARzbn9a
	7d+PxUh6qcwpH1CDKXLBsMznRjTfQl+woNoZyoPH3E7hZGQiKhSxGfgZWVz4n1Pw
	GBfN9Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2ftx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:10:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b600d0a59bso6529731cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682621; x=1758287421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZuuUGQBOUzotJ0AURfxJazlW1Inl9eU+TFGm3oovUI=;
        b=UtR4udNwuUMOAcxHhoklw8SeuGk6obYpQCfGLjBV09SXrvrQVM3ZgAVW6tL0ex74P5
         ijmdYa+aloOecATb2WzKDEupBlQUaQoGjugoMsT605J2DjWMrYflYhaR1Ny+93AhvFhj
         5L16QZtTYZZeM8Ul6b55Tov+cX8wDaYUGlcteDauHp8OMj/NqChvJbkK3Ez10Bsfp2Ww
         Mqi7cOHGgaVszFzIdYDlejhkK3FHztN5rwqQ3irA08LHLPWKjnM5whXSc5l97rVDxRD4
         jeatwnnaEWaBV8EguhqN0ZtbDJYoNJDZt+Kb6vdWBqbvqddNquq7Dn4RdaEkkljDYmKy
         j/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVzYF7FbDEiNFSOkIRWmkbYZ13hr8q/wulBaPqpuRFqdplIRkzgLMY2wcqx48BT72Ygp2WguobdSDJJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkgg/DexWVYvp0Jf+NFheCakXU+kAWYtlGmEChHVXlGqIIIiJI
	70v5k8ssp1nhRW8OkbOxX9CL0yLZDG7B92yn0+Abf9h7WmoNNIWDPdvUq3Epv6DtOY3qHHWCwzy
	oEHdb3GSVTFFc2ZLI5cLULb78O0ZCWrDXfGig6wI1LDlLhDEdQI2EKz31wPRiH59VuvE=
X-Gm-Gg: ASbGncsKNq9+tPC6bkwoyFzXa4u0s2p/1EDg4iVU2zcnHpkwucyuIG1MtNWsO2tZrAe
	29pBSbYNJfkGZjeU5vksob/On4CuPjwgqPybEkopYeFqZU60bIe0uFyC/82jpQ1UKxDrAhtxW9/
	1iTSeah1yuNqcm//YK6cyXG/LT73ZyJF4v+cezW+f9KrRz6ioLUQWndyzS2yyEyMn4YaKdzLYVx
	c7nVZykzNbm8j6B2DKQkxLHzLZldIpngvtQrhVz23wMl3he2Th2AYoHhYYTxGzwTPhszBpSIHsO
	Lhn+2CbThAicCPKXsYgJOCHQoSY2z8xxyLvVu2wZclG7EgqobOjmLaq4FHnE1x/TkNvMcUJWmlT
	ZM13+sdAWmE4bFtd7ka3qfw==
X-Received: by 2002:ac8:5806:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4b77cfe5dadmr25023711cf.7.1757682619546;
        Fri, 12 Sep 2025 06:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtUQ0IdF43jy/a13JRBEqJFoXoR7rc4LuhuJEDHtu/h6Dyxy/yIzIQdCwYyyFQseAWi/7u1Q==
X-Received: by 2002:ac8:5806:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4b77cfe5dadmr25023131cf.7.1757682618785;
        Fri, 12 Sep 2025 06:10:18 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334ed29sm364920566b.107.2025.09.12.06.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:10:18 -0700 (PDT)
Message-ID: <b51e1230-d366-4d0f-adc8-fac01b5de655@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 15:10:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Drop aggre{1,2}_noc QOS
 clocks on Herobrine
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        cros-qcom-dts-watchers@chromium.org,
        Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Douglas Anderson <dianders@chromium.org>, devicetree@vger.kernel.org
References: <20250825155557.v2.1.I018984907c1e6322cf4710bd1ce805580ed33261@changeid>
 <20250825155557.v2.2.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
 <90b13660-1844-4701-8e63-7fde2f093db0@oss.qualcomm.com>
 <aMMcNn82AmSavJYf@google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aMMcNn82AmSavJYf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c41bbd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=JMB2q793TmbAW5wj82IA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: FlMzbhg5Ytnz5V3FROj_BunTP8R_qEfG
X-Proofpoint-GUID: FlMzbhg5Ytnz5V3FROj_BunTP8R_qEfG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXyJTOtuNM9AFc
 zpe2ss6B2if+epl4dJ0cfmM7lPcRmu9dyftVQncnctOvOaspVH3cm88Iw2InJJPbAtrOUaAQGEF
 Wyz/B9iid5SGsO2JbifTGR9OP3Nt81+47Rth+qFDtNPPJn3cFrfYIDZRiL2GauejXGpwLkoYd3d
 lKxjcApd6zIXys+bLTz7NIA6ETuujk+eDxMfqsHh7WjrS+DH1f3tU689xeGedxGvtqe1bBjYzJA
 ZhpI5TrXtMxdbcc/t4odq9eLBoVAm8M/KAi0IVp17vviQwBQyCzQ2yq6yW0T09bil0IcVV8MWm6
 4u+PmX8JQPLxqm0AK5+to7UWhoFzLx6TeS/tHgkD1jGuXDNcN9XiZHsI9vGqFtn68LZurmbkxXs
 viAxHYr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

On 9/11/25 9:00 PM, Brian Norris wrote:
> Hi Konrad,
> 
> On Tue, Sep 02, 2025 at 02:02:15PM +0200, Konrad Dybcio wrote:
>> On 8/26/25 12:55 AM, Brian Norris wrote:
>>> Ever since these two commits
>>>
>>>   fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
>>>   2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")
>>>
>>> Herobrine systems fail to boot due to crashes like the following:
>>>
>>> [    0.243171] Kernel panic - not syncing: Asynchronous SError Interrupt
>>> [    0.243173] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0 #1 c5464041cff584ced692726af2c4400fa2bde1db
>>> [    0.243178] Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
>>> [    0.243180] Call trace:
>>> [    0.243182]  dump_backtrace+0x104/0x128
>>> [    0.243194]  show_stack+0x24/0x38
>>> [    0.243202]  __dump_stack+0x28/0x38
>>> [    0.243208]  dump_stack_lvl+0x28/0xb8
>>> [    0.243211]  dump_stack+0x18/0x30
>>> [    0.243215]  panic+0x134/0x340
>>> [    0.243219]  nmi_panic+0x48/0x98
>>> [    0.243227]  arm64_serror_panic+0x6c/0x80
>>> [    0.243245]  arm64_is_fatal_ras_serror+0xd8/0xe0
>>> [    0.243261]  do_serror+0x5c/0xa8
>>> [    0.243265]  el1h_64_error_handler+0x34/0x48
>>> [    0.243272]  el1h_64_error+0x7c/0x80
>>> [    0.243285]  regmap_mmio_read+0x5c/0xc0
>>> [    0.243289]  _regmap_bus_reg_read+0x78/0xf8
>>> [    0.243296]  regmap_update_bits_base+0xec/0x3a8
>>> [    0.243300]  qcom_icc_rpmh_probe+0x2d4/0x490
>>> [    0.243308]  platform_probe+0xb4/0xe0
>>> [...]
>>>
>>> Specifically, they fail in qcom_icc_set_qos() when trying to write the
>>> QoS settings for qhm_qup1. Several of the previous nodes (qhm_qspi,
>>> qhm_qup0, ...) seem to configure without crashing.
>>>
>>> We suspect that the TZ firmware on these devices does not expose QoS
>>> regions to Linux. The right solution here might involve deleting both
>>> 'clocks' and 'reg', but 'reg' would cause more problems. Linux is
>>> already OK with a missing 'clocks', since pre-2b5004956aff DTBs need to
>>> be supported, so we go with an easier solution.
>>
>> Just to make sure I'm reading this right - the clocks enable just fine,
>> but it's the writes to the QoS settings that trigger the hang?
> 
> Yes.
> 
>> Any chance skipping qhm_qup1 specifically makes things better?
> 
> Yes, it seems so. Or specifically, this diff:
> 
> --- a/drivers/interconnect/qcom/sc7280.c
> +++ b/drivers/interconnect/qcom/sc7280.c
> @@ -52,12 +52,6 @@ static struct qcom_icc_node qhm_qup1 = {
>  	.id = SC7280_MASTER_QUP_1,
>  	.channels = 1,
>  	.buswidth = 4,
> -	.qosbox = &(const struct qcom_icc_qosbox) {
> -		.num_ports = 1,
> -		.port_offsets = { 0x8000 },
> -		.prio = 2,
> -		.urg_fwd = 0,
> -	},
>  	.num_links = 1,
>  	.links = { SC7280_SLAVE_A1NOC_SNOC },
>  };

As I attempt to find a board that would boot with your sw stack,
could I ask you to check if commenting any of the three writes in

drivers/interconnect/qcom/icc-rpmh.c : qcom_icc_set_qos()

specifically causes the crash?

FWIW they're supposed to be independent so you don't have to test
all possible combinations

Konrad

> 
>> Could you please share your exact software version (which I assume is really
>> just the version of TF-A in this case) so I can try and reproduce it?
> 
> I'm not much of an expert on the makeup of QCOM firmware, but reading my
> firmware logs, that'd be:
> 
>   coreboot-v1.9308_26_0.0.22-32067-g641732a20a
> 
> and
> 
>   BL31: v2.8(debug):v2.8-776-g0223d1576
> 
> IIUC, the latter points to TF-A hash:
> 
>   0223d15764ed Merge "feat(docs): allow verbose build" into integration
> 
> Brian

