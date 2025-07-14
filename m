Return-Path: <linux-kernel+bounces-730099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19381B04030
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8384A2D48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFDD239E90;
	Mon, 14 Jul 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV8my4X+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF61EEE0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500139; cv=none; b=b2n0cP1Ay2HqVRDC+FbJfsu1e6hJi6hINCX8E1IzIuYRzh4hWEeLyUm6Suo6X+5CsUFhSsOdjbKWyJNScLI6moLKC5VvOsKXdCzJs1Cwx6rfSQVl1FjFp4gtmF61xG0GnlhnZP+vn/e+hvF/JIdvTRUFdoX5w4aPXEK5adbVxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500139; c=relaxed/simple;
	bh=HX4HnZdbWWDzZBqTqjJWzyyZPowezPsUzhrBA2nh7tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shLSNZATfj/rWCzMyO7Qs14U7b8SYuKMplPnnAgIeyyAK9NLyR0P38fMft2p/1XlDrOFsYKEF7XVXhtn9Xw+xIPl6KK3a8QtEs5ObF9G3mb2FomttidrGXyIzmOFAdz2wXZ9cfJwUrwTjUkhnA3h9RP74qoC4tt0+zwQKxMpsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oV8my4X+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Ydd8013389
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9gtciRivL0hGQareYH+vHwh7auBC4PlZk5kqwLmKt2Y=; b=oV8my4X+12wuX5uR
	Udx9SzVvGQHxEPOCcn2P1pfhrowKYZziUEfTONNfGei7ecJYe/Hg8DgH2YKRK7i/
	5ZTFc1GkJMltahkqOYF/AcJPUQ+XVrZbQyqZVEuLFOeCg3jkDK3HrA0VyIBjG0so
	wlgZvgET0+/IyvndXjEEYXzNg936K147ZI0CXx2iQo7NoekKsHl0emfjai36fA6A
	/r44tTb/R19Wc1SgL7VLMjoL8zaCSQeoVHTQJrr8QOcAYIFkcEr8Fzm/Nzikx6Io
	i6DBsR/NCjhKgKRip06/bWp3UlXYB71acxBfW/h1itLnJLtTFVT7s8LaBJErDRf3
	iRn2/w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxavtuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:35:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7de3c682919so57282685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752500134; x=1753104934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gtciRivL0hGQareYH+vHwh7auBC4PlZk5kqwLmKt2Y=;
        b=FrNL4nzrYs7VlxI0CrPQYwM2pPdZ2wOGSn669fpG6PY2pH54WbqbqKXuThvUAfyts7
         RNiazuWeg+CghbyFK4cKdKwyEYk1Ia10yZePcKdH9oKbBj7Xyh1PNpqyu74wbEKp7e8o
         pSjjOJcK28BCyfFJ+2kg+/dMq7s8BmGIAQpkzWMT9UIsGHrl/fEC5GUHv1V26dltwtzo
         pFUiDud8uD2T1OAGmLBD4WLm715pvYNF+DJECNP3qjQjQFEkaCSwVS+3pcAckPXXSUfk
         +uJeiE72U+BlMtQcx0fcv3/xcJaZEwPMUrM/Z+iyHJ+nSu0pOFeKFCT96XJWuPYr4QkJ
         wo+w==
X-Forwarded-Encrypted: i=1; AJvYcCWL1/8/bKoS49QS7/41cZvxDahWj9uaibAkajCA2x9yz/FtUfKMqP7JWoGL7k2+E5UP+5eZtMiwI92eCqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbztr3IVGtNRZwW9Q4Jd7v68tdnWR3V2YVMBE1nCU81ddKSlxU
	JEvTarprFsX8P2zGCRkQ33MvD8Lno3DkY6oEAUKQcZxuiV3kvRpXqEe8cyqwfDk+IigbX//wH9c
	9Xdr/OylN1gT7d4KFFGkFuvYQT+avE2N8KCCNyQZFARgvkn5pcdEIJr+id0qPl/lwbe0=
X-Gm-Gg: ASbGncsSTssLyGAyCUkZ0+1+/hSheafzjmAeld4fjIs4d1ypP9OWQW/b0toKHOxhSw0
	x3KIbj9bFtFlq3gGbnrLPIU9T8uSHNTlJXWIMMV75JrpZCM+qwIxh7XEhDuooQZZj58IYtssPAV
	jGM2BjxVypWRDEOD5pdAU3tgw1yezE5om+0Q4aHSzihF1rPUwpyxTVbYhCFRibN0YcMP62xOjj5
	9t3Wwll0yMvwT1nODwf3dFL0ogZsElngvuE20negSbSVTmgudOFzLXvPir6Y/sZCTDqjYqmaD94
	HZ3qaPCePD+kd14UC7JYfA9WMrks7E0S/mXThAFjUsaj34z82QYzSKBpUWHYnongTRQT3T6/7Bb
	fODa86NmvgOLbEVoSpThd
X-Received: by 2002:a05:620a:1a8a:b0:7e2:5349:7da1 with SMTP id af79cd13be357-7e253497f18mr211080385a.7.1752500133858;
        Mon, 14 Jul 2025 06:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHynt7mhZ223fLPVn7qb0shx37lKSNxcN3cADg/ymdAnLcvmVC6uNozrBQ1FGGm20vv8uErVA==
X-Received: by 2002:a05:620a:1a8a:b0:7e2:5349:7da1 with SMTP id af79cd13be357-7e253497f18mr211077885a.7.1752500133246;
        Mon, 14 Jul 2025 06:35:33 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90b09sm814711366b.25.2025.07.14.06.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 06:35:32 -0700 (PDT)
Message-ID: <301542db-2e0d-48ff-94d0-09acaa603ace@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 15:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: Add support for Dell Inspiron
 7441 / Latitude 7455
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250706205723.9790-2-val@packett.cool>
 <20250706205723.9790-5-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250706205723.9790-5-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E8rSm3ZJpltqpa5mwkkhFw0RTwZZ3Vht
X-Proofpoint-ORIG-GUID: E8rSm3ZJpltqpa5mwkkhFw0RTwZZ3Vht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4MCBTYWx0ZWRfX4sQ90FNehkXH
 reh39VdTwaCIyM+QU0MdPN373FYXdjr+dfle/ssPjwDj1SO37dfWil6iQatClvyTuBAYnqHtN3Q
 b25tm/0Cv1jpiXV1GHNSX4ZXFBZRulEDFQ5cPkmhey51sJZKxoM69MPObYvAIBYyCvd1Ok9ViTT
 9Kb161034MfrY4gVRjpiwVOiV9/ugmey5d1P7909s97V7ocn8tzIYj0j2oZwprVMiBYGcS1RMv6
 z8mRlnEzVHws7Gimu6jtzWvpP37cb7DDzu9v3eVa/zQvhMFmDJb5n54foLfuxAClnt6vPAw2hmL
 HLqwZYFJ5lCTnnKMz02tNEH2+4VHYTAX584UnDpOrTTLLFSWofBLwlgW+c/9yD9rEkHnaHqUahs
 J+0yM8Hu8RRSl9L2qBF7hVmSblSeQq8y4TCN16+fvTt2lm/ePx4wzKosx/gt4jOZQle0dLyr
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687507a6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=vswN9AVew7ZQbwbRgEAA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140080

On 7/6/25 10:50 PM, Val Packett wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Add device trees for both SKUs of the X1E80100 Thena laptop:
> - Dell Latitude 7455
> - Dell Inspiron 14 Plus 7441
> 
> Works:
> - Wi-Fi (WCN7850 hw2.0)
> - Bluetooth
> - USB Type-C x2 (with DP alt mode)
> - USB Type-A
> - USB Fingerprint reader
> - eDP Display (with brightness)
> - NVMe
> - SDHC (microSD slot)
> - Keyboard
> - Touchpad
> - Touchscreen
> - Audio (4 Speakers, 2 DMICs, Combo Jack)
> - Battery
> 
> Not included:
> - Camera
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Co-developed-by: Val Packett <val@packett.cool>
> Signed-off-by: Val Packett <val@packett.cool>
> ---

[...]

> +	wcd938x: audio-codec {
> +		compatible = "qcom,wcd9385-codec";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;

Please do:

property-n
property-names

consistently

[...]

> +&usb_mp_dwc3 {
> +	phys = <&usb_mp_hsphy0>, <&usb_mp_qmpphy0>;
> +	phy-names = "usb2-0", "usb3-0";
> +};

Let's not override this, so that the driver can still put the
remaining ones to sleep cleanly

Konrad

