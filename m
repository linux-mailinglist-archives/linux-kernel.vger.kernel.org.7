Return-Path: <linux-kernel+bounces-730847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D19B04ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92841AA0061
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEF9278E79;
	Mon, 14 Jul 2025 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAIskzLJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137E278E6A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532825; cv=none; b=FC2VM0Tis509leZcssohB+qucaJLLuX+kMBx/3cTPCIwnK9/mdXr7lv1YdDjKxxOcuMzwi8yA7DRBtYQjQLdzZOFGxjkMyMA+4WfogTJT14DgqvyNkzd78f1Mh0c47DlgQKklclfWXgBUPl2wlD/DPuHB4nbZpDOhM4dJZI9gh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532825; c=relaxed/simple;
	bh=4h5qlwpeesyHN/FRt2ZtRRGwEAs4CU5jNL3eU0tHdm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ2pSLi+asFW9ZvKQgve/vDn23NKVR08dqgZnJwsefZTkguctNqZiTor8+we/kF1+VkkjX9uHh/ytoYC0MLfB1ItNChv7uBIsxoTPBO4MOt8U2HU1bwcyN2dbaNQj9ZOgn7HIvP/dNyxWhqbiyLtNcN2UxnJthx/AvJUqXmS7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAIskzLJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGGkoO005616
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yjSwbo76oRHzxnrqM3sUTeEv
	V+WSiuNA1qDRjRRLBOw=; b=RAIskzLJfeqGTk8Y5KGy1lzHZlBjDQv76CdUyhVq
	8DbTbSHio1vEHXy4ivnLB9uYSngwhb5L8VAQDAxbV+t6VvCeXRkmf4kZGE3GS1y4
	3prAq5BUDHTKDWFJ6P7rLw7CdA5TbbCDsuMCHu5qhVBIj1UAkO2LnQ4vjjLNn7na
	mNvc9G7CNirOYJZ6eauSta3ixtg3Im4CjBioKCIkkG323zDdrCMCWuQ6+CWe/UDz
	fJfMp0gOhTzDxsoPgc1CJX0Gk1iz9BgC0IjxpIziQFR6bzdDef+UTu9W1xbH2PAY
	YIDk2FIMVxjnA3u3vNeo3loYNODWHDuZJtt/h+d71GL8YA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ygvet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:40:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e269587d8eso276699585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532822; x=1753137622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjSwbo76oRHzxnrqM3sUTeEvV+WSiuNA1qDRjRRLBOw=;
        b=Yv6f5YUK10DGolJvFjvKdyHLZKnKVRzSGNL7YEXunQCUDyTL2FRKqjFHj8tuXTJdgL
         xgUr7ZVPhacducP4qyJ+hi59gmC57MfimJvNVzWrmfZzMSlvDUh5oOzBJhCf3Jfcsay1
         /YMYQ71YQ+2EyY9FfVtYRZbv1ciyRGLwew/OulAXApnW6e7eA/WrMDQvbOOL/oBhDhMA
         o5lCIlMFC3dnpIoH2S6sRDNaZvl9xQRcuIMihptJCwX5sUBYm0kFKucstPppxoL/9a3W
         +33SjgJTmRdscV8gRy49wM3ubPv3YvpvuU8+Q17orUAEXxDkZeXjUG0Y5Q+DwWaxKkBv
         7PEg==
X-Forwarded-Encrypted: i=1; AJvYcCVdR/7zk8FKDj1fwCg1+R1/vT5umIsvhzno1WWNtHZ5OEXU06lcU0VY2bAj89oGDBIdo7jcvtpS1okfm0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPqGgEX8Gu71ZMYs3sFfoN0rubE8xVUqeoOGOJWqaqZ2/UDlL
	A/2rpMIisI+cTBFP14nSl9XlvSOFZYIDMeWrusPhso18+i7pN8u8jyxUPEI6bfNwk79emj02RpG
	jf4vtfDPlO5VmBy/6RDcMwZDDfcAEBA5yhYo0o3e3lhYsuskWGJmteGYsmCq7uAu3nXo=
X-Gm-Gg: ASbGncu1sJWXc5d7THgEDx9zZVkZD5dLN/JB8pupJR2yu/evikqxr56/a0h2jXcw5L0
	OKz9H6bWDrakmZSZ7L68lu/xStpvWzPOsrgukNT5MjxGRogKmn/zCAkqBYNp5ZJ5JtWFNVKPflG
	3rPT09Vz7zzVQGuJpg/iSrU34FRDlij5DMKt2GhtMCFCYQFqE9YVga2IuKtShUqHTFFaqQtCklh
	E8EEePa1X6vM+N7q+9z+32Wm4N4tF/0h//TQDnDP7WiR3c/xqUwdeOHjWrNbKS8K4PA6UGGf3qf
	9d631PT/Yt4yG+qvL5nxisj1vs9fIMteW1yH3jZnQItb0ANgYh4XWHNBrH0dygl3zgQiprqElB3
	Y5j6oZXKbipY3ZSdIFOoEHNhIJt3X5d0BF0XEdb1rpL7Mb9VD83l3
X-Received: by 2002:a05:620a:40c9:b0:7d5:d065:5473 with SMTP id af79cd13be357-7ddebc95009mr2146589285a.37.1752532821540;
        Mon, 14 Jul 2025 15:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa0HRa/hfK6x/NEBmsxm/cQ5Kjrt7W4P1iVcEqAb7PlaCTrfUqNMH3CjK1pQSOrmvZybaOZw==
X-Received: by 2002:a05:620a:40c9:b0:7d5:d065:5473 with SMTP id af79cd13be357-7ddebc95009mr2146585685a.37.1752532820961;
        Mon, 14 Jul 2025 15:40:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7ea2easm2085007e87.66.2025.07.14.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:40:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 01:40:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shashank Maurya <quic_ssmaurya@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs9075-iq-9075-evk: Enable Display
 Port
Message-ID: <fibzazcqx5rhdrsuz24hdasribdxllsj5cclq4pe3wd4mpqiqe@qr3fzc72wbuj>
References: <20250711-enable-iq9-dp-v1-1-6d381e105473@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-enable-iq9-dp-v1-1-6d381e105473@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX+fgADCLm2g9M
 M5obxOxXUD70PUuXR3apW5Iv0pkm5NGPXW1ZnHZQKoaDQ0X2WmMnZw5D6ImLuvxlcUnIrJ97AJh
 YbjS1oBV00YExrp/IyJCDV4JtjnQPSoaGxYlHqimS+9yW1hyW28VOmQySX/Fp4a/gqS/DfU2LZ6
 ohIvb6PuSsyuKpSlFld+2zww4bq1saWiIfy3wRb6MiONtHBCSOBmr/kYuOAbDq/ZZ8kskVaLoav
 oFRDUYptN8yY9wOqcv5zR+DDpGqGVmbu1RW9hLy4h4v45W35qGPxhUj0p32Ninas/W6d5j1phLq
 RwuoDj8bPmAoEJFR+MoC46fEAwUHPzFk0u6rkd3fe8uB+vdrptltjBmtCFU8Eyrrc9y1M2wdRTa
 I5TWFgblUKCff8XFpOBJWIErXdFCEAmH31pliqUiwIQSXTaz6feT/PNp59AA7//o5MgWqY7n
X-Proofpoint-GUID: cVk-3dbvugfgBAdapdn_o_y70hTMEzpU
X-Proofpoint-ORIG-GUID: cVk-3dbvugfgBAdapdn_o_y70hTMEzpU
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=68758756 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=QGU9b-9ATRnlJsYRrdYA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=834 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140159

On Fri, Jul 11, 2025 at 09:13:47PM +0530, Prahlad Valluru wrote:
> From: Shashank Maurya <quic_ssmaurya@quicinc.com>
> 
> Enable DPTX0 and DPTX1 along with their corresponding PHYs for
> qcs9075-iq-9075-evk platform.

Please add corresponding dp-connector devices.

> 
> Signed-off-by: Shashank Maurya <quic_ssmaurya@quicinc.com>
> Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs9075-iq-9075-evk.dts | 52 ++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
-- 
With best wishes
Dmitry

