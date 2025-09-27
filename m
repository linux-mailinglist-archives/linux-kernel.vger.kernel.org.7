Return-Path: <linux-kernel+bounces-834968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F7BA5ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA52F4C0956
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009313B280;
	Sat, 27 Sep 2025 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a01VMscc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF0146A66
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975795; cv=none; b=agttp7IX9DOsOvAo7cQLII2DAQWdBj4GX6jSg01BRyo5hTuOLrMf1Gc7Yw4juRTKWJy+MaOOO7M9pZE+I6jcI1WQWusrNusNQglAKXflUrnceEzQ7TftEOSC5ed0w5O3V5bIe1QHVZn3xUGZpvUO5lFvbtS93WhIqE5z2hYwgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975795; c=relaxed/simple;
	bh=tEQnL8W16BktNpUVtLbw1mUzaFJqK1i2+vMuSRTj+yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqy4NLG6dJm57ZsDBWm9LNwcR7GeqJX29Ua/8ehwTcbwW2tBhdHrgHlyZf40HR1CVHV4yjIECYAvy4a7yky6CodSsVku/AmRmUg0HP4KAdYiIjw8aC+bl48yY4OJvJ6vTDVAc22kfZ6X1yAhShpOJFM9PbPVu+5YJnlYudfUHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a01VMscc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58RBSFpK030435
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tEQnL8W16BktNpUVtLbw1mUzaFJqK1i2+vMuSRTj+yk=; b=a01VMscciwbi+pAN
	e77+26oRg33yebQSbhgvPtsfMK/9ydh1rZeoTkyxnUPId7/hDL3F9An29h/Wkra0
	regJvyh9/elDRI7+vKwWFSUVod2jtXuYdqwdzv7OjkTwGUW6NQoLiJt6OQT+OeTG
	X1XZQja+TwfYBWvq7yObz5gxEfkYhAmIFtxWGGT1bJNbLZq11Jgu13Hq4yH2H8HC
	cfYpsclFEEdAZTxiwbWFOLM1e528xAf8Hm/ck4wt7Vjqq0negRqTy0tIIphbTMXS
	KBqhxk2+Ci4KM7p54Rl8DaHKXXlcoKzPuSP9YB8JOGLVVg/evLpkG46UgMeueBpg
	JmP9/g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8518qc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:23:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81d56cf8e68so1487866d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975792; x=1759580592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEQnL8W16BktNpUVtLbw1mUzaFJqK1i2+vMuSRTj+yk=;
        b=UbXNeyJ6RdXiruwBGPDfY4PxhTzVR7wvajEeBrj+191VLjccpLDF+7TWpSTwd0SxSF
         5ud4vndtzkMoPpXtd8RB+ATuLYac9h2Ef1GnE+91rVaoVyBZaTgG55QOFLLgGyCB9WNU
         WilTmONG8OvB0qAuSqxVqG3PIBXOl669SK87IlAqbqtDQ+JSoJEv/1Jsg3yo5sxinAIC
         d7eFjOvfsJlJEn8/uSylypLarb8V/APq/9OSuOvd7RN3wrnLVcZMUsmqkUMRmMdndJIW
         ZYCHplNRA3QSgx2f1LGxYhbSjs6gEMy7aOpU4TJGGIxHCiyUIT+18ZtTsP/+yhior3SM
         eoIA==
X-Forwarded-Encrypted: i=1; AJvYcCUX3xs6eYGbpmHwPpC25Pk10Jp0rJjUljh2otPQmqftnKjYDMxaWTXE6u8QJ29SeDan1nmt7YmEHW1cuAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuaBsmouLwrlzOfb6hpF1cTfP9NSEX7ur2CbYhmcRDFnm8slEF
	UbU+2S9Zq1DDkk3u0oyOalSsGZc5+lSfvCdG+uBiUrQJCnchwKNTmFyjA26oAyaD0lpq+YdJJXP
	vHcFvfF/J7UdL7dqoL7JQlZJD3oBz6I82nags4EcmLP3eMVktzN9wHaDkBThtdEYk8Y8=
X-Gm-Gg: ASbGncuStJUUO33o4b3m/zrXzfRyUQnzUEWuEDxoQ/8UA4yhImR12gqv3wL2Jz/qiV1
	Fcg9vlC7HPmjtv4fFbS9JOzz8e4Jk35TPwXsXg2VyzrsGR7H8MA7amLkyqD6oaXgmnfzyRw4Zk+
	8Eg4gS9VVm7xmw1TF+kIlt5RwgKoxzTBZzQGFaeL0FKc1Rng7iSVt5ni5LgR2AavDw/zh+yQAa9
	DsrzXq0JMA40FYOBpUYVa3AIRhIcc2NVrMs8zISDotbm9iSOk2MKltTe5bU3m34HtlZwbwpjWZs
	xZPaIF9XOu8PH6uweu8ZQOgso0xgMZL2B/ehFKbyKJ6Dh3sDIfgPVkcroyotLHJ6/h40QIfxlmA
	qMiG5y7KdlDD+BjUgqH6sGw==
X-Received: by 2002:a05:6214:4118:b0:734:4ca1:1da3 with SMTP id 6a1803df08f44-7fc45177beamr94137546d6.7.1758975791868;
        Sat, 27 Sep 2025 05:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdOlWd1gQfnVb9WrTWg308MwtnwbvHVNGmojxMzFvYHfgXbWu/S1dqssJ3dgyFbACwHn5Qlg==
X-Received: by 2002:a05:6214:4118:b0:734:4ca1:1da3 with SMTP id 6a1803df08f44-7fc45177beamr94137306d6.7.1758975791388;
        Sat, 27 Sep 2025 05:23:11 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3629584sm4335951a12.6.2025.09.27.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 05:23:10 -0700 (PDT)
Message-ID: <764bc5f3-4387-4462-87cc-d8787b1be0ce@oss.qualcomm.com>
Date: Sat, 27 Sep 2025 14:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: x1e80100-asus-zenbook-a14:
 Enable WiFi, Bluetooth
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20250926-zenbook-improvements-v2-0-c0b512ab6b57@vinarskis.com>
 <20250926-zenbook-improvements-v2-3-c0b512ab6b57@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250926-zenbook-improvements-v2-3-c0b512ab6b57@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68d7d731 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Wopnb8ls170qGKoNrAYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX3sH4T8tfWVp5
 bvhVfObnyEb/b1ZLHFMgEX1klRc/Vy9/ZGFuNWjH2n1qzVXhNlu7AmzFIWH5w2H7CY2vRDLqK4G
 BnY4WscRkpPe6nTciVL2bbLqajW01OonEN2PY7UfMfFfXhNehXCdcbUyNW1LGpQe9GrnN9Cgjdi
 ejt6Qvc5gN8Dn4QMv7FBpGdi11RVLX+FE1OwJk1aG7MJXd67UJheX99Mk+GivGEjbwPTIAxuo84
 +f9hhYGe8WX0ecdOvYa/mQ541yEjslwgWFaVkYl2UuSTfU4QGchdD4hjnE+tEzTp6E8ialcQF5y
 Ui9kS+s01e7ieokV8pu4bPlRz7zPf2e4HEVYykA+3u3cjAczprkIHD58Zkk5an3hfQD6/a4Uz01
 xUGJGpx4Ep9vwzrDdG6eum+nWFsz8Q==
X-Proofpoint-ORIG-GUID: zIXbKlendiBUccr8yio_CcI4VkrmPceH
X-Proofpoint-GUID: zIXbKlendiBUccr8yio_CcI4VkrmPceH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On 9/26/25 9:08 AM, Aleksandrs Vinarskis wrote:
> Unlike UX3407QA with ath11k, UX3407RA comes with ath12k. Definitions
> were not added during initial bringup due to lack of hardware to test

ath1xk is the name of the driver, WCNxyzabc123 is the preferred way
to refer to the hw, as that's the actual chip identifier

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

