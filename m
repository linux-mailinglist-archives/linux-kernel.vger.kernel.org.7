Return-Path: <linux-kernel+bounces-735268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E2B08D07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D209E1C2214A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458312C159C;
	Thu, 17 Jul 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FyNRj3O9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CA221FB1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755680; cv=none; b=XbdMVgbr+FZJ8JpFuHeT8Uu3gQpEMhBxc6jp+DDUriOWd7uwAccWzolk5ITNqcRYNuGtXvg2UblkfLfkBTgE7zLV7fhL7h9dy9bqSGY7F3tzQi7BrvFGw87HbV7l6TvPivna1mETeC4lOSMNPKdqygSG7pMrSQEe/WIiKoDuztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755680; c=relaxed/simple;
	bh=tvj54Ugf9mCR0aycZ49cLKLbPEjNF1NK4UB9hQk7Bts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ray/wPTjXpdbIE9EWpv6cQrgm1++uHvDipn/vi6RL/5ydIYvoNqSfEzi5fgffAVaPcQBzq0taTa90IXJ2v5g3Usr5NQNfa9PPvETiyn7kdGBhnuKWA4bgDjm58Lr443mbssHmEjrWVqSCypvu4kKqE2c46WADjAvr4n0IlNVaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FyNRj3O9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBUxNr032206
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g0EtSnDYQ0MstT4xX/sUazSxxFTRJ/EGgAkOJJTf0zs=; b=FyNRj3O9OFjjwKMo
	Hg+RGVB1j87S4XjL1Zkpx0Te87MmkxQC5PYxhrJLa4gXvpNCzNzOtUZbFQ8slvFa
	RPjj50JoYPl7s9P+hZeUna65UhlpynBzvLUYrL4M0uQRZdOfF15Pg7XB8DRy4p7k
	1iZscRFyCBuMTrNaKhqOK4MfWpMMnIZfJxoAfQu/aXApEbxjTmlYAmAcCy7UdTct
	xJ5iXtOOvK+CKlYb7YbNpWfxEdO8Qzvmf4aAj3H+xON9ayfBRjQdQa0Nf22t2urL
	2Y7vQMuLdm7/U+adTDw1Z6rMtpQRtblWgYANYejWE4+5c8W/kFTYQfA4gaPwZ/so
	2X3FUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug387re8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:34:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7406bfa1so1883781cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755674; x=1753360474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0EtSnDYQ0MstT4xX/sUazSxxFTRJ/EGgAkOJJTf0zs=;
        b=eCfwhUdN+e9uiwtT5s1107RYtnI908kVDPqqPPMpHhJEPQLyx6kwXZgvnLa7dYZe0d
         cQ0N6ufD1nFEPv7gbaZYBY3VE0hy82RICtQ2AxNHlt19/WInhMr70kyTC1cYmsIEadPr
         GDrE81oXy/2VSE2dZhovgwImQRZCxzZ3vNBuAMo8otu+yrILoDicPymlIaKYXKNXH1Jl
         wSKDvFiGQqoYm7mCwry0czIzC9DFuppEn+J0gVc8cOC+EMMY8TGUWlH+tVTzSzfD+Te+
         napBs2i/M+fpHiq78lMm5oXOmqwGzTL4cKjHYkFxqBgsw941mZFS5I79WqIiPp2pwMmz
         zNbA==
X-Gm-Message-State: AOJu0Ywwc/JDkKEYz9Cz35LF2pvHxDTjZZsreu71NeGJwCzIZmSIcnQF
	IQVhkWehED9meiy3aGuaYiPPsQt5BA9+GCQWy2yEhWcvKkbbwq4srexmZREF/kDv+MC+a/xkcJh
	zqd+rAsNtEoetW70F2Fx34YQcevINmYN6npeijighzknyFUCkg5DcSoPs+hTKbJF+uEY=
X-Gm-Gg: ASbGncvf5kcyR4pQA7JudV4J1/T3cXxIu0rhERKoO3vKHGC9/GSeth4moS99eDynlU5
	1QyfKr9r52J5j3c4qSvyUO3+ry5yh7r7jyCF6PLL8jz8P97hHbjg4tebIdzGjlfuVS238G8Voy1
	3SfFPuL5vWokoFsBQ8MUw4WEDbezaUrJKMcAuO7RzrBz92mAsWB3G++tvkfpr1KUwl4XJEv26dm
	BThUgvanY76LqUdg3GTZUA77y9uq5TksVdtqm2YXHFl5P4sS7VJ90+Z3cmJGvQYbNnvYvsgdrJR
	kE/3b/VTHCwR1ekoUZ1HBVbNx5jBEU4YxmmvvNSuNYA4qqqWyFFx0x6gy/pWK0iz3MT8VNqA39X
	mxMF0EfBMaOE79vQyTXNK
X-Received: by 2002:ac8:7f15:0:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4ab909bb071mr40839181cf.2.1752755674145;
        Thu, 17 Jul 2025 05:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1Ii4oHRT/NNq7i3cIAv6HUe9Cyd9qkoWu/kf/j1oMAf1VxpLFX0jnaIsgTckfm+2dKO8vGw==
X-Received: by 2002:ac8:7f15:0:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4ab909bb071mr40838971cf.2.1752755673678;
        Thu, 17 Jul 2025 05:34:33 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645fdsm1368246366b.97.2025.07.17.05.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:34:33 -0700 (PDT)
Message-ID: <11eafa2f-ce53-4df2-9193-dd6fcbab9bda@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 14:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] media: qcom: camss: Add sa8775p camss TPG support
To: Wenmeng Liu <quic_wenmliu@quicinc.com>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250717-lemans_tpg-v2-0-a2538659349c@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-lemans_tpg-v2-0-a2538659349c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMCBTYWx0ZWRfX0JvhtBKAWPhq
 XqGMGfo1iK6IrsvIKachUBmoPPuZ78leRxD1AUUOKG2cIC0eVmTlqkLPF+s7+3gNSlHYboQJ/rU
 UtmsytHKOgXyDpy61jTPQfzA0JHu8mw416Jiseyo7iw5OcTodqqxANYudOQ+uBYYplFvO9FDlF2
 Bp6KwyM3Z8imMh49AsDcMURgC3Fb1xudjKkmLZ9+llr5ctpDZIKgUJXb2+0U+3GdUZsl1hJPni5
 DCo97AVFp1Jb4rDwnghFGghR6LIqQbIspevi/7JFcDM4qS6L83Ot88PLOdmxSXpFM3KIqHrEvl/
 90GxzHgRnb7IecVJAuOvr0QmylVDLjocVBN/17dWsXUQQYy3NnOS5CqdGQKdWWwYD/rTlYu6UU3
 awn6MTYgv7FSn/6cmJz/Wx1LSbnllTBsBoM+yzkvcxegEQAvgEoUB8f/ZrfsBPJ/lZoFgu5Q
X-Proofpoint-GUID: 100ss7bbGLImdAGPS2_sTW88k88K58yp
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=6878edda cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=kyHrPkqWk3caiwKyUVsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 100ss7bbGLImdAGPS2_sTW88k88K58yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170110

On 7/17/25 5:20 AM, Wenmeng Liu wrote:
> SA8775P is a Qualcomm SoC. This series adds driver changes to
> bring up the TPG interfaces in SA8775P.
> 
> We have tested this on qcs9100-ride board with 'Test Pattern Generator'.
> Unlike CSID TPG, this TPG can be seen as a combination of CSIPHY and sensor.
> 
> Tested with following commands:
> - media-ctl --reset
> - media-ctl -V '"msm_tpg0":0[fmt:SRGGB10/4608x2592 field:none]'
> - media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
> - media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
> - media-ctl -l '"msm_tpg0":1->"msm_csid0":0[1]'
> - media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> - v4l2-ctl -d /dev/v4l-subdev4 -c test_pattern=9
> - yavta -B capture-mplane -n 5 -f SRGGB10P -s 4608x2592 /dev/video0
>   --capture=7
> 
> Dependencies:
> https://lore.kernel.org/all/20250711131134.215382-1-quic_vikramsa@quicinc.com/
> 
> Changes in v2:
> - rebase tpg changes based on new versions of sa8775p and qcs8300 camss patches
> - Link to v1: https://lore.kernel.org/all/20250211-sa8775p_tpg-v1-0-3f76c5f8431f@quicinc.com/
> 
> Signed-off-by: Wenmeng Liu <quic_wenmliu@quicinc.com>
> ---

I got a patch for qcs8300 in my inbox too, that depens on this series..
Can you coalesce them together, in case you send v(n+1)?

Konrad

