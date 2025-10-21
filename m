Return-Path: <linux-kernel+bounces-863651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31ABF8B43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1D21357A66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7227B331;
	Tue, 21 Oct 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hBV30zSU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D35229B2A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078121; cv=none; b=Cs2IWeEIrisrdzJsuNOi7+xhv/p18XOhBc5Kn/0r28y2TMEfF6fjH0pI5DGyiqCIP74o8YtWzVHveD4P84F4kF5T1MFgONFWu7mEY/G/jA4/0GjkcjzzzATYXcVMxwObrQgfHI0TlpjJMP7dnt19+oqCEqr7yAGzcez44iQzE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078121; c=relaxed/simple;
	bh=mEZXhTwzQ6zamixvVZuTYhTDWMuXgP7sdkSYV/2gvAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHNNJuEVK19kExyXGYuXBZtpa3+Pn67vlycrWxN9pQtco6WQytVaAJtCx7F/QgMZpChIDae/HTYvJqqMQ4WgJ5Jdan4oB5FMwbRUuz/7VdbxbmEPlYr5V3PO6p3W1H5ySBe/PZbHRQRvQgcKymrrmxjsYLmjRS8PJRzLFQ+3yRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hBV30zSU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEpk3I010753
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eM8vsS1Fj2EgGJzHKnEsypCDm1Za4pqWpIHUVJFKPDk=; b=hBV30zSUakfpmIbx
	5/HlyYtqhz4d70KQwHniE9dhqdldMs7St0cNT5qfSmx2HxK13EMW5fCQxDSgD88Q
	OOdJGLedLJTLrD/8ROvetPWsHmS7HeV2S4Z8HRrfmE2ZHZlyO1KLbUQ3obTsssQe
	troOM3BUgjUE9n2KPS1duTW1OD1HjVG1xM+YCxUg7qLUH43SvreytEOiauMjrU6z
	NXg8eKiZwKhZAvsajQbOpSP2tTLz8jsoM21Xsa3xvePZJtSeCb6Jnjc1i0yto6t9
	i2Q6bZtmzR9XWvTXbzsc6LpfYcuvZkk5n+UBZp4FgJ2lHNTVFDhXl1Tx6zH83pbB
	3OWN5Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtgevc3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:21:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8bb76ee59so9395011cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761078117; x=1761682917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM8vsS1Fj2EgGJzHKnEsypCDm1Za4pqWpIHUVJFKPDk=;
        b=esz23lVQc5K69+/l7RxYy3rc9pgCB09yaAOUJBe/vA0C5JjR/zGamwrATC87GybM2C
         hjkARc8UGvhuoVD90hRmjX0xAkW78jXsdufFLXJeAJAOSydVgbWk84QKDwbwRN2rVfJG
         +ZnTnP4+X5btspyNfFmrUwFoFKegZ3yHz8RH2wXDclqBFHmgAK0Dk9kYYewW5mddbc73
         AatN2dqtf2OjlWLvLJC96SYhnuiH3KxZ7wbnGo7LlILfx71YUTipXjwyquhBqorVJvxp
         Gl5OZkFWezuCGGAn92qFZnLzdc7wqMCL931Ua99rFy1FaR49ZqGl9ZLWxor57YMeueRU
         7P6w==
X-Forwarded-Encrypted: i=1; AJvYcCVJa7M9W0+GMMWCRSa0a0o3can6j3MQxahGeIc6VOZH6V8ERBBzJ/lErpGL5urT0RGhSgNTVz8JrML5aKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLT6mDUN8P76DLjjVG6JliNtey+JSuPUj7QA5SExCmrDE0Fii
	4dtf+snpCKYt2CXbBUPf8FPYXUSze64Pw0MM9Y3FLE3RKr+R9Ae7TvUwsnJSJOraXjhRqq6yaZR
	LCT9sYRjbJ4rkKSspP9UP6qDzQYdmRJD2JPnfK1MBsPc/wzHMDSKjev6kpyiS4aYI/Jk=
X-Gm-Gg: ASbGncvJyYl595ZKEBpstJefjahFscJxkd8YUINiuHlJsIt4AwhsoupcsLhTVVPDZh7
	NZUIH4qnX29xEzVgpZFrVpl2X+Fe8nmYWOTS2vARrHEKZ+qiJg3pcLU58MJVKPxqwHxZhJq1k1r
	A/FZHE5HoiBA05ZSqyRJ08OUAMODvFIQhCNd6T9iswQ6DhoIWIEF+cbDwkb+Kys7WKAMA3GmZlH
	OCMTX9jUZEOW28v78wArsKhJ/KGizMS98/gaxXIitwr2gnkuqr5KRziF3RB0YwNQ9nA5VACZLDN
	AY0gBS19Wpr3AAUzwxzvBmGsonRay2iG0rP50fynU4C5UnLu8k0NoQwS19vrRsfiC/OjwKvJn9o
	T9o2rx6WHBuepJwwZEfZLlN3nJg==
X-Received: by 2002:ac8:5d56:0:b0:4e8:9a7d:90eb with SMTP id d75a77b69052e-4e8c1ab2c39mr118226771cf.38.1761078117505;
        Tue, 21 Oct 2025 13:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHixFYbK42Dq8yGad0erFEwbVWJxy1epl4bH074jwzXpoHLLA1EBx5YyFLZLspcYCGSJAFyvA==
X-Received: by 2002:ac8:5d56:0:b0:4e8:9a7d:90eb with SMTP id d75a77b69052e-4e8c1ab2c39mr118226431cf.38.1761078116987;
        Tue, 21 Oct 2025 13:21:56 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c56sm22096646f8f.18.2025.10.21.13.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 13:21:55 -0700 (PDT)
Message-ID: <29d6d523-020a-4eb3-80da-b83e7797d2a2@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 21:21:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] ASoC: qcom: x1e80100: Add sound card support for
 Dell XPS13 9345
To: Abel Vesa <abel.vesa@linaro.org>, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251021-dell-xps13-9345-enable-audio-v1-0-6f3f6bbd977b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CZLadDDFg0uvW6dUk3Ecgml40t-g2Me7
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f7eb66 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=5VL5Wpq1lgPoopIZa9UA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CZLadDDFg0uvW6dUk3Ecgml40t-g2Me7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfXyxTarZEgT/6u
 K8LaWyjIy87CV/4oHKuNDGzXbS7/nQZXmFkeQJCl0LDtTF+S6KBnA012vRPCShQ9byCHE5QgPk+
 1i28pMK6V0My8MKuclRAWnY8oZ0dNe4+D/bIDvEjAgX96PHx+KVheiIBPsaNXiHrU5pg9JrjkTH
 cle8IgRPGyBfby7ldKrYNJAQCqhAQ5qLbgr/iqb8+te2ec1SVfhOdJt0Od4PX9Tt0CF/QmqNJtq
 pwGbxVxXL74BXtcWTd5QCs1g9cKamfJnmBBP29SBF5glY/DuRedgy3JZLwpMzVc0hHYIJ18btwP
 Xv+xk1oCdy+QjUXE6CRo88GrilmCUekNWKBuuSdp8hzQq34QHQgB4UxqNhhSyEuYi6aNunuZKcP
 TiNp8gzLEJvZb+JoIu5UEXPNsDJyBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154

Thanks Abel for sending this one out.

On 10/21/25 2:50 PM, Abel Vesa wrote:
> The current X Elite driver for sound card is mapping the channels from
> left to right on all X Elite based laptops. The Dell XPS13 9345 seems to
> be the one-off when the speakers/tweeters are mapped starting from right
> to left.
> 
> So rework the driver to bring in a swapped mapping for 4 channels setups
> and use it with the dedicated XPS13 compatible.
> 
> The devicetree node is included for proof-of-concept purposes.
> 
> Sending this as an RFC since it probably will need more discussion
> before settling on the approach on how to handle this properly on future
> devices.
We have few options here, one is the way that you have done, other way
is to add a mixer control in the machine driver which should allow xps
ucm to select correct channel map.
This should also allow bit more flexibility incase any other machines
have different wiring of tweeters and main speakers.

--srini

> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Abel Vesa (2):
>       ASoC: dt-bindings: qcom,sm8250: Add Dell XPS13 9345 sound card
>       ASoC: qcom: x1e80100: Add Dell XPS13 9345 support
> 
> Sibi Sankar (1):
>       arm64: dts: qcom: x1e80100-dell-xps13-9345: Add Left/Right Speakers and Tweeter
> 
>  .../devicetree/bindings/sound/qcom,sm8250.yaml     |   1 +
>  .../boot/dts/qcom/x1e80100-dell-xps13-9345.dts     | 139 +++++++++++++++++++++
>  sound/soc/qcom/x1e80100.c                          |  49 +++++++-
>  3 files changed, 184 insertions(+), 5 deletions(-)
> ---
> base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
> change-id: 20251021-dell-xps13-9345-enable-audio-799bfbd7e7ed
> 
> Best regards,


