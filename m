Return-Path: <linux-kernel+bounces-724247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E29AFF063
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D34B3A9720
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37985239561;
	Wed,  9 Jul 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnupimiL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB258224AFB
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084218; cv=none; b=A7EaPUJnjGuQLuuFtm1RvElD8bEmgdFn5eerF5xKJ9AcKq2TJvFWDMMZkYyB78C2MewlSQ8/vxHNZKn0NMGvePrsB7CUJAcXdU7nwT+ZDwXClQ5x6O0afQRtOWTZ6mx/SR6w+7dVYKDd/0bM8k6s2GbjOP909hiIPkORl6HD48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084218; c=relaxed/simple;
	bh=27TDKvCzp0syh0EGTxobI8FWbGxi4OXzg+TEq6GiL0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2a+SIIxYAZxU3jkp+3sDvBdvr6Z4BbqzGqjkgUIwHm9R/442ljIL5xKoMq7pdkFzXmFkjv0oA9CSzF6qEoWs4IKRMTV42LbmRwlGjwml6dten7uftTwF01BqW5c5GrAzedpFOGlQFs1D/C/o7tu2CIfnfv4j2IqF83Qjr7cmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnupimiL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Coidq030103
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 18:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2uc92O1GGv7emWG1TYEn9fypVsBaY5TnEeVaY/0T7/w=; b=KnupimiL4EZalts1
	9iEjxmVspLViNkxnTUsyCodjfZClzaw3RAAZ2hh6QRgRGnyn1GoKdQZidsvNJHYN
	Z7/VxAuaKpUtt74ZD+sV0H64fNlFc5S0Yd/FPiazPMl/e0V7hoqjbc5cJLu2kySp
	7XUXkBuvInznLXZjQPSYeQDgGitwILYrSCJRWt//urOBqwyfdi8imRlHHWnrtTBo
	MeSHWjhAulRW7flXAk5sA6yGYoCPCxRjjtv0S25CDHWIJ6+uRWzW4mTr47k5zDpu
	9GsTKJHcr+xuVJte38F/oNEiHARwn1Tmmpzc1opgSA8fRa0kksABdaEGanDNpou6
	KHMHmg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg20hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 18:03:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7dbce38d456so3086385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084215; x=1752689015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uc92O1GGv7emWG1TYEn9fypVsBaY5TnEeVaY/0T7/w=;
        b=ulcmP3uWQbCq9fVyrEFQPlX5p1Yta4TLCm6tb6e+ch7ekD+p6L4jBqYPBakXBMgHcd
         6GwbzwJKyce1/Vygf8IGdDeq7Tkhk84owcle4kbQXrFAyead4faY78PZYPwx+L2ZreeX
         5O3dSZRBZRo36zeHNGcCareUj7oJi1RQ371CVftUg8Z4GyQG5OiJzVR0cEK9JwvHjdlQ
         P2Ao6BMCQMSYImVeVn5hsxqPJe9JEByqgFeQ8eQpMm6AgBuAXkG563Z5FtJvypSwI1dC
         N5p66iCiTcw2Fo73donCaDjFMHL+hgRgElp8TlgfuJOicGbOw4el6U7sYjRRWeDl6MLF
         o8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgU4V/HihPItH0ejMuYJKNdOswukhbNnUsCRkxgzKrmIAtJXyGIn06OOy6iTkanGnn5Wsj9NhSdH7JsiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5emLDPpquN2/yBS5VCuOfCnSvA3lzd50v8WUQs5XIsFaw9re+
	tpQD4x5loNlMnCa0SFIgJlSm4JGz9IMX4ENpPeG6nqJjbx+ybK8fA9JmODyCYVGY+ipxEpbYvSr
	dlrLdHmC7X22FgXn+HkZ6gCeES84E46GtXw9729+N8T2oHKMQYCayAj4zQmuKocRsFxc=
X-Gm-Gg: ASbGncudy9bU0rL1Evq45P/WkcRMFtOFBY7U2XrTuIe+if9TrUEibcNS6sfWS9+beTn
	vj4/jzBMb0+4WYuLEvUL3PI9+EmftdkDcQ1nzbXrMwAycZXa6tqCoy+XKPuFM2LeiVFB1h+2mjn
	3mY91tGB0+3+sduIgudxgMACnjQTcS6dRjyH9GpRtfXokGgjtMeyQTcb4MP7fyyUafQ/4tCnUDs
	rNkNBGZml9vuXxceVaTPPXL0ZoHzs3cwDvlEyuefCAi1arM+m8J1ZUw4gT5svj/hfEt6If6UIGZ
	K2mfpSFo+T8OJS5XaH4C1RRAHi74R6MoiNVritkI2EQbe4GxKhwCkEcQ870ZJ0pqkBek6WfHQA+
	Q++M=
X-Received: by 2002:a05:622a:1491:b0:48a:80e5:72be with SMTP id d75a77b69052e-4a9e9db4837mr1964031cf.2.1752084214591;
        Wed, 09 Jul 2025 11:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT4JbzQDFlByDuD7hy/m9S00Zb2j1K9B+NMiIKO0svgqjP5RylRzZ8vUZfB5MYmmWt5DXtBg==
X-Received: by 2002:a05:622a:1491:b0:48a:80e5:72be with SMTP id d75a77b69052e-4a9e9db4837mr1963781cf.2.1752084214116;
        Wed, 09 Jul 2025 11:03:34 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c80c4sm8994918a12.75.2025.07.09.11.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:03:33 -0700 (PDT)
Message-ID: <68dfc6b7-1083-44dc-bdaf-4fc09e944671@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 20:03:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] pinctrl: qcom: mark the `gpio` and `egpio` pins
 function as non-strict functions
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-11-b6135149c0d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-11-b6135149c0d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686eaef8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=XSwnDwznb6xmaXktW1IA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HXvZ8eG1airZAsdlwEtloxtOdLprXlSx
X-Proofpoint-GUID: HXvZ8eG1airZAsdlwEtloxtOdLprXlSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2MyBTYWx0ZWRfX2n89sPbsSMgr
 LiA4A8ppbHikzwpOY6PuLZoGE8xNleeNlpboPg75lnOHZtxW78k2cxg4rgsd13FtjJzBEbpgWP6
 KsNriRVaxKZkyOsGJzo7dn11Jg+EI7H63XfFy8UD8kXpEw3DK9jS2aMQLGVdBXOBibyi6N75AUq
 I7JDzZEqmGdNpX9OWoeS84PaBOZYUuzqv2u5nf3peYlQZ/3usoMP2KfrJorTgTLItwed3d79y+k
 YLss7OzlxVGlHnO3pq/xRgQfl14ydBIfjSaKVwZ7Bubh7d1pX4F0boa8x+xIIEYKQtzRLxLmRZc
 TN8o/wUaRNYsWwKwXIlCusnAvVhuTrq+hPHerQiJY1LnlqFQImwlXM84TcU7E+yhTkbE537AyYq
 HhfrCgTKQM1/VjfSvBN6dOnjxzDY9/NVgpop6dmUNKORpTDu/mtceUK7zcUXCOBFkY4JUihR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=853 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090163

On 7/9/25 4:39 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Allow pins muxed to the "gpio" or "egpio" function to be requested as
> GPIOs even if pinmux_ops say the controller should be strict.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

heads up for +Luca, I'm not sure how your Milos addition will
stack up chronologically

Konrad

