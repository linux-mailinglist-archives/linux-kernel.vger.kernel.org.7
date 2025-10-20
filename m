Return-Path: <linux-kernel+bounces-860803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB902BF0FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0821C403987
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8E2B9B9;
	Mon, 20 Oct 2025 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k1lm7zi8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E342AE8D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961756; cv=none; b=c5raC0eA/CvFgsb1RQgAu9LEATGHX2S9FKqQXtPz60Smq6h9hFqcFaED+whoSQceqLhw7+oZC/WHXsBUx/e+3SfisdBWv8WVae0R7hXnTn9UqSeaClXdvHvEl7P9bLJT7HD6OFaty8F2RWvvE2hJhe3T6BSXpy7NAF5xSL+i0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961756; c=relaxed/simple;
	bh=PH78YdDSnzwxCHJgRiRybJMbpOqlc4brc9B+cBQ8knI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4Y1XXFSvss/+Lk6CWriYN08gRkDp0txV9XgAv6opK96izC9ClLnaP0YlmU+RTwcXlzw2tG4GL1Qm8MtcEACbJKrXJr72DZx2RszvJU96+Mnw7/47syvvhKdLQLA2TWyQ+64jFVFY+HMQyBkhLywTO02JZn9Vh5ibnXTi6aT4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k1lm7zi8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBbnkV001945
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oIG694y6bAFJewqTAATkKo0qZg41tPW6hp12LV4gekY=; b=k1lm7zi8ubgptaZY
	JLhGvPqwvs/nB1B4ubs+IFCzETjhma39eF1OCc2WY/KcVz6r3GvJ2pxxjAbjm4mk
	OQhmVq+YAjWp4/u1P5ACrVZKjEyfRzHMdtu1WuA9Y92FHgT1Th1UOikmKCZD455P
	URQ0G2SN+nGvuCZVFR1PPzPoQR5W9lVLiLGzkdCOKcaQJxK2uBbzwkUgXjC+jxxX
	vlz7dtOdNRjkYDrNhN2Qdz5Ww1oQePNQLl1MMDz/Sqz3njU64D/OQfmyXYp7OkC3
	K3rxaxGBtSpzXyr1obmn2sALFFWEdiUMapm/OS1jB57Q5jYt6zLlkPwTQlLSdHuO
	mbDXkA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv4kpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:02:33 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5562b30f35aso243119e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961753; x=1761566553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIG694y6bAFJewqTAATkKo0qZg41tPW6hp12LV4gekY=;
        b=Z+JdnmwEfhhCqqy0yF2LaUA81VStCTj+RzoTUHr7EzZNmHDxBatAVxU7v5UdfxtvIX
         hA+TYEmBE/YKuKi6J3762jG2d2UomjM+baL8yTeO5j+N9woVDHnljDYy66L6s+a8KkAu
         45dq/eor372S/6c4wFqdH2fyCXQ0QVSKbkusPAAhnx207Ucd068xZ9PMQcDHRNEQJO3O
         sMG/ied27JWM0MqCceFBGGpA3xkH5UQchOYKzz4omKxwxDx5PL+bw6+WXVGFPQ0iyBCi
         p75kuvoIZzRiDw/PJ31ylIP9vi1DZ08Fq67eT+6IL6hFx9RAhaby2d7SHxJY4U9rwy/O
         PRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4BMiIfjwdO/951+e4+K5RwetkhpPwgI5mIyH1szyBnIDGhDX5JyV2iz+2YCwES2v+mtXqaNePjKrPcHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpKPhcXqShoggBIaAOU1vxHQzVfzs5RC9s2jzGCqPvoAHbRXX
	DLUWrrvGOL9upHYtRV3Bd9/HNq9B2/dFeMMRtfGnG5j2I/N15fq8paUVaz4wsvEG9Ys5nrVArg3
	2crAiOhPzJ83qyTxw0YKfeAA5W2mfR+txxldvgbprE8oNdWihxZpYK1IIUIyS5TMeWL+vpmTN47
	g=
X-Gm-Gg: ASbGncv6UGPZY4ad7KbR+PtRDe7mB972sVsPWBRvo3OGL7obvTs/iQ1araB8F7WStra
	GbbdmuQwYfEHhrnC24Hz9KecFXYWO9v+jUSWdUB5LkW/hbuDtvyujheYksVJQBM1/ksZw6SDkqF
	Q6N35325KgFDP1ZkBQbFNEfr3Y7Byo7FOPwe+B8lxOpOrRRVUqjUEgoPLBPoGttldXrM9wrlg66
	/Ud0bLVILQakpzeLUhS2sWOkK9P+i/xbtUC0YLN/Wxll5mfib2isXlqGuVXqCdfa9PW/8TFOCZl
	JwEJD2NZJ6/ljl7+yjmn4WQKjVrykJDwqU5EyUJGqoHfNsgsHYjSDUGtDrGVsdJw1D5O0jQ6wm8
	srlz69uIcHzGpGJZG49vK3UQENTxPscbcm80FYQYbDgmmSWHYFu+2UnW8
X-Received: by 2002:a05:6122:3293:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-5564ee8267amr1600193e0c.2.1760961752961;
        Mon, 20 Oct 2025 05:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExb3d7wrCskvILwjadrYZ35oU1mcZoo+ieMX1KAj9vst3Hy1cKTiA0tq+qNgeFvEo1O8fu3Q==
X-Received: by 2002:a05:6122:3293:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-5564ee8267amr1600161e0c.2.1760961752579;
        Mon, 20 Oct 2025 05:02:32 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036b2bsm790493166b.49.2025.10.20.05.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:02:31 -0700 (PDT)
Message-ID: <41c63020-9226-45d9-979d-429b7299da41@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:02:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: qcom: msm8974pro-htc-m8: add status LEDs
To: Alexandre Messier <alex@me.ssier.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-1-53d7ab3594e7@me.ssier.org>
 <6c791f05-70e7-49c9-a3ce-50fb82b0c894@oss.qualcomm.com>
 <fef52764-3092-4375-b9c7-793d85adc102@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fef52764-3092-4375-b9c7-793d85adc102@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5XG9sALxFChpVnIQXDHe6kfHPEQH-xj5
X-Proofpoint-GUID: 5XG9sALxFChpVnIQXDHe6kfHPEQH-xj5
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f624d9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8poMKPHdAAAA:8 a=glctJ2XmOvm0yIQHyQsA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=fyZPtLC9JlAwSkJ5-iUD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX1pLH971YIC39
 9BCs8b3/lRsPRL/+c627vC32z5kUpFsZwvOAj5KSBwWwMmeCCM2r9LfMTFrSlUd4gD7961ENC8L
 q2LOg7kkUrWqFD6wGZXA7SmURzIRE5dvszIm6N+sh5A15JqMTLZeNc8UZOa7taLbTARd0cW+CsK
 QCEddEJ8Jf5B88cvQ4BQXqsEev3qnvwIKCJL8KrANQwkKUTAVpWfaIEfb9me4g0JQLEjNsU2UNE
 8Ciq2aNmcFSm3+Fgncv4jnOFQA77ZrQktqPyfbGyMmj5kfIFoolqi3m1yhs2CbnJGy0KoDgdsEy
 IIY/xaXtOCyek0Aic+KqQUbEUTIDPczKIgkHDZHtAVPI1zRpa9XUxqsotct4VAxoWqeia3Hjcqi
 dA7BbKp/Lm6045gMLR75X0kttBgMgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On 10/12/25 8:03 AM, Alexandre Messier wrote:
> On 2025-10-07 06:03, Konrad Dybcio wrote:
>> On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
>>> From: Alexandre Messier <alex@me.ssier.org>
>>>
>>> Add support for the notification LEDs on the HTC One M8.
>>>
>>> Two LEDs are available, one amber and one green.
>>
>> Do they form a single notification led, or are they supposed
>> to act separately?
> 
> Good point, I had to check the phone user manual to confirm. Indeed, it is
> referred to as a one logical notification LED. It also mentions the color can
> be either green or orange, it does not mention using the combined color of
> the two LEDs.
> 
> So I would say they are supposed to act separately.
> 
> Hope this answers your question, and let me know if more details are needed.
> 
> BTW: I will be sending a V2 to update the color name, since the user
> manual says the color is orange, not amber.

Let's describe it as a single LED then:

multi-led {
        color = <LED_COLOR_ID_MULTI>; // notice it's not RGB
        function = LED_FUNCTION_STATUS;

        #address-cells = <1>;
        #size-cells = <0>;

        led@6 {
                reg = <6>;
                color = <LED_COLOR_ID_GREEN>;
        };

        led@7 {
                reg = <7>;
                color = <LED_COLOR_ID_ORANGE>;
        };
};

+ Pavel the LED maintainer, please take a look if you think it makes sense

Konrad

