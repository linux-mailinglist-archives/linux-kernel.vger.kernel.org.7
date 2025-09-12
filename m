Return-Path: <linux-kernel+bounces-813989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6DCB54DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07F83BC441
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33A3019C5;
	Fri, 12 Sep 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isoXHVb9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342C2D9EFC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680087; cv=none; b=K/60hO9KWXbEyL6ofgFSfeZxe2H7ffww/x5VYzvi6+Pc2r77yn0OlrZYhWv/+o/sHSUnh+XSbCPXuicepwLYNv8cVBni+DlcSm4w1BXENiyufnihmcafEYxsK446MjC2a0KSck24YNufxtAQaqIW2sto0NCwebO2s4tkVTF1TO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680087; c=relaxed/simple;
	bh=iJsSVwqOcKJ+jvcqQulAE5UoFoAGbSHsV9vI7EwrTJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrTAktYFe5GHlt1i2s8tpLjqHap9EyZ1CbwCsODBRmml4y+fGalHTbmuH3KFIje7IR4yw3zWVffEcxFiTMq8+DmPRFugL3KAhAc2vFB8d7fj2ux6g9OVvqskWAQHdlw6mleXGjI3tC7cBwMBRHms0aSLe+JnG1zn7oKU8vXtKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isoXHVb9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fPAG012889
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFUuM/6CWr6E6Ua8sjPcJgSq1lagiIOIVJ2nUPnOckM=; b=isoXHVb9i2tKsBRJ
	TQm4lxsHWuFDL7n3ICfQNr262hzzQiEbEnirW7xfG/7AoV8ef1UK6Oc8txWnMXkA
	uxSc1ukeqFtUkLzScgVskQLkNub7tfNBboRwknb7MMknY+C1DYWtSTbt0mEKpO/Z
	PApWevCNI/ZjOkWlZL5uoMwBfZOKfYiXZNEWLsEPPeQf/9sKmO7E9cZr0ulIzkqC
	XQoQwgJPqog8flCd5Bhxp0fZwSS2vxDQs9v9x/lo2QEEa46wKaxYKXGXXfYfLna4
	UC+J23gHmjvSNYciHYAvf4nvezoEx3vG9Z2g2XJVajs19Z2ktEeWUwgdZDQ1C+Tw
	uJbHGw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqgbba9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:28:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b612061144so2064211cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680083; x=1758284883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFUuM/6CWr6E6Ua8sjPcJgSq1lagiIOIVJ2nUPnOckM=;
        b=REoMIgCpy3SJGjCKMmJJJuUjWT92a9acrPa2HotZDB/X2kZ2Ms3bPGGdH/sc1wYs1D
         EPM5k7VB+dRqHWO4/M83yo/T/tXC8h4p/8RpzfnkywrLVvnvFwNQnc1u/ztVD4aNxNW7
         x8Q6F9k/ODUl8godVbV/WSeG37+cObHplfdEUIxN/bkBLNPAGwnmEtKaPn5vT5/SpXIq
         KhMSywJ6Ie2x1q8Kgnbbd/1kQTcbWm/WeaeXsPd+UliiL7kPzGGizoYKfkVfmsYC8/Vv
         prg2fieCCNjYIs/ueNEhFl37UAZEyxCtagWhxiCQ91BgqaH2TTBQJg0jQ0SyiUB6LQd0
         QFNg==
X-Forwarded-Encrypted: i=1; AJvYcCWFBoT/nEV0P1WpSISDvacBG3TC1KMz2IoC/rq+LtpjtjnxrXoWvhlQU8WKA2DYCZpLJIcINop4kGWzi/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ60+JGpsu8g40GYFbATAnfZXsAi2DMCEi0Lg1S3wddxbiRCea
	2fh3HrxBR4diI0L3JIcrMvD3OysxgKAmfvOqB21x4ndxaN+FSlFE8UqXi7C+XD5dGqX13BFujBi
	z6quxQ7g09CuBa4Y/gkQveBmDBH+uv+LwS+oMbPLyAYWIugwnHam8dClR7yC7vl0yCe8=
X-Gm-Gg: ASbGncuwz4RvoL0162joHZak/conUqNyeYx+1sKkO+dlssgSxP9gqdfIAGdwfdLwSYP
	cLrntyRjeVyPVEOn6atRaPwl6pxjEmyVBv60l+I7YRH8LPCKJ0gR5sjmsAzUMWdqphhGfwp0nsR
	6D6EQZ6O0WchylQgvGiWitCxMmqlW6Vxh/UcCfmGgd3nfp7PxBGzK70wLqyaaUUSKKktZ/dV0+s
	/XxyDF7ArcDmULkQfW4kDMpdNkQjUP7wbVub8qc0NkopBk7CkK/hrj5JYhuDvqLicS/dVR/ohYC
	GD4bET+cUiCcU5Osq7vsdXXkv1p8uFW+wA2otX+GZ+te2g9x356nl0rUQtCHCd8/yqi6i0lF/Ug
	Y2Dbg+AHHmHQXLCgd0A3Zew==
X-Received: by 2002:a05:622a:1984:b0:4b5:dfdc:1f0c with SMTP id d75a77b69052e-4b77d06ecbemr20553761cf.12.1757680083140;
        Fri, 12 Sep 2025 05:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8QzuRduFlaCIEb8iFypsFpoHRpXBscWN+xA6q9Sfc+5OImw0a6uM7bXGrxC/zLDbpdQwBZg==
X-Received: by 2002:a05:622a:1984:b0:4b5:dfdc:1f0c with SMTP id d75a77b69052e-4b77d06ecbemr20553301cf.12.1757680082556;
        Fri, 12 Sep 2025 05:28:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm359239166b.67.2025.09.12.05.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:28:01 -0700 (PDT)
Message-ID: <cb2a5c93-0643-4c6b-a97f-b947c9aad32c@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 14:27:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3qkgDFYS_SzkDoLnMIlRpBRKaHEAlMy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX+eS30rMiUI8h
 p1MQ8GnnPeMvGBtJbDmbuymCL24pMiPl34z/0ar4C+AvLvnI3j8Z6agzazQB4Z8uXqsLAFuVr3/
 eU+mk+tSji8e6lGYRZacIqBiuyKGg8R13xqM4Oue7l1Nt8vMLkwnGGmBjzRjG3XOHxXpq6JX3kV
 CA6tTPJg/aS3tYUedI8hLN8on2to8NRU7z4fbro7FEtjWzDCCo6obFVyRRueJf/Ny1fRhpB3kSK
 1lVFWMN5cVUdNckeqdn9S+CMTasRAQcrRL+MjTpY6QNLMCcFFMbfG/3hFfR6J7AskhS8Mj0knyF
 fDeh6YgTFXfIymBdoX9J35TFnFQQiHZ4bimP46wQDv39vK+OqGua4AYCD17P6PdstYrsjWoZu1P
 Se6YKZbA
X-Proofpoint-GUID: 3qkgDFYS_SzkDoLnMIlRpBRKaHEAlMy7
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c411d4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=nUKbQzcQiuh6IjOItDgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/8/25 10:19 AM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

[...]

> +		perst-pins {
> +			pins = "gpio2";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};

Pulling down an active-low pin is a bad idea

Konrad

