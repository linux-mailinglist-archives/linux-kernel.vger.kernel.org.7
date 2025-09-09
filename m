Return-Path: <linux-kernel+bounces-807501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2CB4A53B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E704E113F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964A241139;
	Tue,  9 Sep 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyuILiot"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DF23C8C5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406416; cv=none; b=D91N+N49Za8ZTuYxA3CLfGYhVFS+OzrW3dM7GGk2dGvcrsSbP/d2C/+7A04OBKVFTqcy74AAvJnL0CMemjJ5kdw44jVGbYlFnHvZYRbrGbW5DTrkLHLMssoFsEukCaza9G3SH+J9eJAR/nH/AsVp8yQr2HMkKHdsQsmQLxnlp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406416; c=relaxed/simple;
	bh=P1GM3phe3ykV/SamJ41sqJjVV33ZjMdPB56k+xQB1PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQH/qtafKkhZ7OuFiCw7ywG87g3CEzyoFWTAoLuHANTir6RjJGWcJJvExkqQ3XEPfBxKrm2y9nz5XrsGsAluPssUgfVP1R998ZqnIlQw9AA9n8Mm/YpRGFlO6bmwkb7bbaqjnx85ORolne/45YakXY7Q47V1Ok7mA0gzKHnhOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OyuILiot; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896SbUC027350
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dZ3qsIZRKMtmRP++MDCauSjBs0OndHKpMtXY+g98584=; b=OyuILiotbj8cEaWn
	s2F/Y5ZBVOVzC/IPMVdXFaZZQNzW3bNRbxcsVqs4pjeDfvfWbFFhirzGZ9dsVJ6c
	z0j5m0TdQRq5u2o6PxpAqBQlTtIITDwQ2DNzs+mb/2AFJYUxuiujI16iGRzr6RRE
	YP1OZ34LgzIannFM2L8ka7983hp/Mz9sY02fRtSdHr++WrS0kMEz3P7DOCwjZhA5
	dbCSG+aGbW8SkOdUY2zEKg5KW1uo0mjUPQAZvnhsgBNkfqNDGayUKXVJnLDO+rSH
	GexIcEPYlC6WcGHg5wA1ikBx/68Wn+OW/b8qzAo4kII3owTCarrNSzG1iwsysRN0
	0aJkcg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfybsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:26:54 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-71f2e7244c7so7089906d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406413; x=1758011213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ3qsIZRKMtmRP++MDCauSjBs0OndHKpMtXY+g98584=;
        b=s+J1HEN3CMtmAzhT3z1aCPYcwkWfA1ALefHCLomoQuuRryfsCb2wGZSgP3mFr9P3rg
         mhoJ4cuVuaX7WswoJ2ygl2cnC6ETI4E/N8kaXgmogr2amfFTEhUZEb0NxTEv7c7WhZzy
         Cv1OlCFtIf3h5Qmp/xUBkHh4LLCeedD2TVy3f9mCNK+fF1uEYvlKmfVq6TEfVZcZ27wk
         2QDK1xskd7aVdw8eCpc+K1nRW61NY3USEg2TFh7+i3VojM5KJ3UbKx/bSCt5hg509TBv
         DMGwq/7yP/Kb0Kg8bE+/Zi/3mPEcnnA2CHG0D+oE6e0x9yWScH+NpYvZ94QrAR4nrMQ8
         Q4BA==
X-Forwarded-Encrypted: i=1; AJvYcCVVwCUaCcScAOzyYwbvl65gu96a3T9zam/mqZSmJGAHs9TgHRIFoWJXaxLQDhOHs1fo8Drn4aOKU6UdcQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPpn4/dj78SWTk6FBuMCa4erUDtgu0uMibNa/EBwzaoP9Vdxf
	ezwFnwtMsxx6iedoujKdAWpElRzf4HDhPbYySmzwUIEdhPHjDQet14iWRcvEc/FY/5KHXAHS6lu
	uiJsTT7ZNjBbqkg5be7CNecSRbnCjnQw2ka2oyCPHhbLYVKOJ45mQFNF0ppWDqCsr9PI=
X-Gm-Gg: ASbGncvFnbO+FCUE2prdB2V32Bks199qMWvSXDdAuGX+T5nHEnV5QEOfZxJ3MSXzJ2s
	ln060iaMDkrCblAmb6fnP217Xlq/1R6MKIAS7JTjFrZ1lYQlUZSxYOH1M9FKjuZ5r3EvpGgRHRI
	0aPH+Yh0dT6kY94BwoECwK4lT9FqHn0DM+7LGGXQQyB9fg+qygpz7Wn4mygpnsxxdAeoxX5BvGw
	Y4/GGkJI/6VHP8SCKC+2xElaKBVusY3tsJmygd0ZXaY6XdE8sALo2/eST9gJeus6UgKQuNR6s0d
	4dBTItKfvRdjq68p2zM1sfzO5P/NzTYy9OwUpM+Hg48CkHxF741Q57QZHYAHpZnxBgpowP39aYU
	iHAjbrvsVyQlQVw6SqTyvYg==
X-Received: by 2002:a05:6214:2aa5:b0:734:4ca1:1da3 with SMTP id 6a1803df08f44-73946b9f476mr69425776d6.7.1757406412261;
        Tue, 09 Sep 2025 01:26:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGfWzUgli8sCKjybiZynjh0Hh9ipnr2D52Wv2AtFKxG9s4JCMp/u55EFix+07znAQjRv9wFA==
X-Received: by 2002:a05:6214:2aa5:b0:734:4ca1:1da3 with SMTP id 6a1803df08f44-73946b9f476mr69425626d6.7.1757406411355;
        Tue, 09 Sep 2025 01:26:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe9a0198sm847373a12.10.2025.09.09.01.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:26:50 -0700 (PDT)
Message-ID: <74d489a8-6a6c-4ee1-8b02-5ddbfbf64b8d@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 10:26:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] arm64: dts: qcom: x1e80100: add video node
To: YijieYang <yijie.yang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wangao Wang <quic_wangaow@quicinc.com>
References: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
 <20250909-hamoa_initial-v10-2-ec10057ffcd2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-hamoa_initial-v10-2-ec10057ffcd2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lsOhI37o0rGReFx919ugerxXctA9QEPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX1oAHNp5f5RY2
 P2kZpd5qgjHGH74gwic3MLAPxvOnmua0eI17tVQGBbQi47R79hjti6kHLj7Fl3inKhqtuoXZStR
 4Fy6lO5m0nQFJMFSlxstSQJbyWY+1lcxYFZiggBVrTYF6c5qbOTw0YTfmjQXHBFxPEeXkElVIxh
 18wuWyHgJq6HsvXNv5Uht3AICr2o/9R0dDoofTbrVH5HratrvcRRigbBq6FsY8AXkmv76+LX6i0
 SUNLMSd4iyDFIEILMkN+ccc5qlBNZvG9LcNY+l6o+yEi8HXS8kvdRq7Xy2pUfREYfkSfyLHdmaf
 qosSEjh9TG5Y8R0uZP+PJwPfBiKkOmrrYvBQSw7V9BJnZVsS2jKh0KJoYHglIfL65a0t5xS/ZYX
 eCVsrNFY
X-Proofpoint-GUID: lsOhI37o0rGReFx919ugerxXctA9QEPO
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bfe4ce cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=0N2-J2CQ4XjjJXqxovsA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/9/25 5:56 AM, YijieYang wrote:
> From: Wangao Wang <quic_wangaow@quicinc.com>
> 
> Add the IRIS video-codec node on X1E80100 platform to support video
> functionality.
> 
> Signed-off-by: Wangao Wang <quic_wangaow@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

