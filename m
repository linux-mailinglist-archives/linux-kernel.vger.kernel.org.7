Return-Path: <linux-kernel+bounces-840077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA366BB3791
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DB73C27D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AADA2FFDEB;
	Thu,  2 Oct 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="onyGy9W7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC082F1FF1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397829; cv=none; b=FEjvFrxD6EHcIIWB40jTiGa1QyQMKjw90m1BONZdcHtfpCMp2yd3pzFXOJ7065BqBVutOxvJB8ymzsQ9VOlEUIRA2lkfWyE1BqgffX/YWkOR0TJMygvBJ/QbEJc/hr+VgW4wI7j/sHEOPxwpHOd2Y4urcDxD1EHLpmNoIdzoxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397829; c=relaxed/simple;
	bh=dvC5aj7x6LVVGqVL6TWGGwvsTPpa+pvgVq2m9BKUMe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSdAijPRHRk/BV3uAa/kV2fpFcGKqSOLGlesI5yB7zOOx4iqlyrCoF0ieBW/4/AgoLkh2uLgODlIUZan/MRsvCkYZZoWk08R8AiUc05ErA+vEa1pMH22dA7o/BjCnPgp7bA6R7N+noEwwwr0Q6faM05+lxO/I0Y9aAk9gH9gde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=onyGy9W7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59299Jpg012289
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 09:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3s3Qu466iD6u/7eQr/tGTVs0AQ4z16vZcusQilCroYY=; b=onyGy9W7e/rJQStL
	PzsnFvHp0TjBRQpTzbqblUo/aHdg3VlWQlDENMLelgTgdxuRODer3IBAd2Mh7Iwi
	BFlApNVqeWAXqi7ibjGmH3cM8sliDqANrect+O3BMKzvRjBEUi/11yGp7Uu3u4/J
	ju8TZfxLDbqNPyzJxREL+bTx2J6snJTetrFzY1FPJ478D9Ecs5unP6PIkLh3Uepj
	82IyercvLdYkTo0Eqoiinwxr9qjRmLuPo9E+gWH10hBjPtIJu8/xecFfSkz1U144
	BlA2bzAfAa5IxUtN7N7SHg9tmANq363UiZCqjetybP1WgPObo5VxG2vLFmY1myxn
	hhI2JQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80tyhtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:37:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-826b30ed087so2107866d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397826; x=1760002626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3s3Qu466iD6u/7eQr/tGTVs0AQ4z16vZcusQilCroYY=;
        b=qqCYtYSN0PexVubYTpHXS6CZl+yhji4gBN5R+kKloDU2aE21nm3Y5Dx9apOtMWlH6Q
         nfRz3mBilvHOROO3XlGjVflVJ7vvzMt50lCgHKVnS8WT974ZaTiS5qSViPBAHctlVHlY
         3BBhXREhIaNbnENKam1ICJbDA9KoP2AYZzc8dsgYYjL46fBDUJlNr6JmBMOlHLpm1M3v
         JFPPthSr0P4zDXFJclnVFpGIe3xZ85iE35DM3V+Ue769YMCzXtBHgLvlVemtqErDigec
         GsvxoVKvHjldxpmgebqdMiP1PpmTq0PzJLzOftHLR9mWHNkcC8artnemZX6oGH47Gioi
         KtmA==
X-Forwarded-Encrypted: i=1; AJvYcCUVHEucYmJoayE9hserbbsvX7LIGRD9QeecZGUSuPxwATOd8h/BWaLSfbHqImaXvPp097O0EIwdZW6O08U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TWM5gEQUrNt/vISgz5eo5yX6gK3vCuiLNOsJ0EmKMZlUCQ2c
	//T4uzzl8SHHq8BwHOLbq+yIlhVZnZQcbfGwYFEIvnvFyTBNlmazqnLur8g4iCsgsJF7aZ9VV5I
	KVUJVI+cIzFYCL6gewAYMvvGZuzbhMhtzYQhtEcuOXB+NEixjam5L9cWIsNs0Z9iRSxI=
X-Gm-Gg: ASbGncvocuOtO1zt4ETXIcylAjGfkTJ2NsKNHmtqdxdRDXeaUovJPXBd7dJmcUwIRFt
	7fYyo+ZXq42gPc6t59Hz6PwDDR8K0mFnecJjmw38nTADUdx/XKSE4bmjPX52BsMMajSaQCqY4uZ
	VkJiUlivup8OxiNAcuwdbX2jdcf7fMNse8ks3dx2G0gGk5eQUiIU+EB6ol22K1VQHEvHCXcGCJm
	Gm2FCtoTxj8a2R0lHqahoO88GJQGazs/gPLqhi43dBkVnQ4wX/xPZzCviv8YTp2jjuRzULZ+JzJ
	mJEND+93C6pAfhZTV60xJivthujEk3FEceGBBp6CuFd75TYH1D8kgJROfr9HWo+Vd71NokIC+nw
	kd+i7fb/O3TtJp5tpfV3g5MQG9g0=
X-Received: by 2002:a05:6214:5184:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-873a5b356a2mr60282396d6.6.1759397826342;
        Thu, 02 Oct 2025 02:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErl72Ov8A6h6hpFWJYLw4FLn8Y45zGs4EHrpv/AiJf6QoFNUh1bWYskfoORIRZsVZrC/1sFw==
X-Received: by 2002:a05:6214:5184:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-873a5b356a2mr60282166d6.6.1759397825670;
        Thu, 02 Oct 2025 02:37:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111f1fsm1501744a12.36.2025.10.02.02.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 02:37:04 -0700 (PDT)
Message-ID: <7661d9d9-eca3-4708-8162-960df0d7f6c7@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 11:37:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-7-b14cf9e9a928@postmarketos.org>
 <f58493a9-6def-4610-9c3e-d6a877dc23d3@oss.qualcomm.com>
 <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX5gBmcjOQsRTB
 7U2hZYjtSAyNZ585H1mknWEU4WQjm8EojMbiH9XjKFslpTb4Fw8NECAf5MA/WL7B2vN9kmu8+Q+
 +OuzEWTzCeT5VdDvWMCJZpLNgyBm2G+qzjfYEkZ7LSgUMkcNGFZIpG2qukPs3pL6ncWpAHEZTTw
 sxhxvNYvTZzS0UyOPFTMuMAjheu+i40FR4Cmv+0x1k0BBXGahf6fPYUL4L3YhjbWjFiku6GpXIp
 Kzc5BIdtetyAI4yidRjI8KxHTaUDkP89yA05mn69TOVSoltKLbFR+tcjGTQNP4oN3iiAoZ5Bf44
 7VDnLHbHWxl6voms9up61CNRqSh6lUTVHKh09ickudCPlM8dWbquUX77ShSG/0oUus2bAeKmCBq
 EHuc+eXRiRB6G1rLpMO0odMqXxaP2Q==
X-Proofpoint-GUID: gTgl261Ti_piedzUb5UtCJSIcCcxWZIl
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68de47c3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=hUOHGeh7YKFiNrxugmEA:9
 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: gTgl261Ti_piedzUb5UtCJSIcCcxWZIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029

On 10/2/25 6:51 AM, Paul Sajna wrote:
> October 1, 2025 at 9:14 AM, "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com mailto:konrad.dybcio@oss.qualcomm.com?to=%22Konrad%20Dybcio%22%20%3Ckonrad.dybcio%40oss.qualcomm.com%3E > wrote
> 
> 
>>
>> As the dt-checker points out, there is no such property
>>
>> If your wi-fi works regardless of that, you probably don't need
>> to set the one you intended to
>>
>> Konrad
>>
> 
> Perhaps this only exists in the postmarketos tree, but it definitely exists, and doesn't work without it. I'll remove it for upstreaming for now but hopefully someone sorts that out. upstream.

So you didn't test the tree you sent? :/

fwiw

drivers/net/wireless/ath/ath10k/snoc.c:
	qcom,snoc-host-cap-8bit-quirk

Konrad

