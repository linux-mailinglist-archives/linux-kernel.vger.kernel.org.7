Return-Path: <linux-kernel+bounces-756238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE5B1B1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927AB3BEDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0D121B9CD;
	Tue,  5 Aug 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aws6MzIz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20E2580CF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388156; cv=none; b=NcBvnt7h58f6csRILW7YPdUczyQLi39SmTXuVxqHnN36N/hxkuhKSA13eUjfP4ZFJATLhClEwPTKatwjoU1ELLsG+fBSXQ1vL07bxjIX7YCGYSxl2+MZ4ZCbg8ZkLV/OoR9vO2C+UuWJdNqhFsE+PNYjVEoHBBVhFDPogFnnPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388156; c=relaxed/simple;
	bh=UQfs52X08rztvnVgM1FhOc9rwkKBAgP7cDsq7fD2YqE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URISrLB69PzgeyFFRGoBZdsP9cnPVT/HCYjOSDvyLwsVzhpDIfFsnzrApN69fuwk4uErdRcf1SBddjO4zrxk7Rgf93XlWdd0VxmIj8iL3DMKRT4AivkSh5A+USm8weCsFTqna0h5JEnL/NRsSkYAbpoD/m7Q85nD2IpeNnC3XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aws6MzIz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5758CaHk017590
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 10:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=r/pN5KRlZzw8ea1w7A8SZKyE
	RmRggaLryPkCmJYXwUw=; b=aws6MzIzuClxtzyT+DV1mLZr8MtAqM43ffErt9jO
	P5+Iq1ORKuAVfbvL6oEr2wCTRHr94eHd6ZetIutgGZfXz6NuVKuuGOzF1lv+xLr5
	DmV6Tso/7PobpC2PVv2uTDaNXVc8iNhckyrNje/pwS7gUr2+daXTePw5skS1Com5
	xily5cnuaJE9zVaAGN+PIg2Vmz+mmaMkluKCwyVq0LfR/6erQlMYwp5JVyH4qx8x
	T65XuLQ4OUpu5EdOBfaJzIDgIIdVALeyf/Aa/0a2no5Wl1pYLOQ/dwLrljlfMxKy
	owXj0TicAY8rQJzehffzgKb/15IYxibEAehUWyWG5sHblg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rr8tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:02:32 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-88dce37c52bso2760607241.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388152; x=1754992952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/pN5KRlZzw8ea1w7A8SZKyERmRggaLryPkCmJYXwUw=;
        b=GbFM2ZrRC9gIq3qPdMIelQ4DWcWB3G7GiFjRMQWdRzcx/gk258zEk86xkqv0X3mjyE
         Q/FnaW8WzKh/IF0aaaaDLROVEoUJPX46Nz9Rh3puFQSLwODNQwv5qtfp4YDpSO3skAtM
         on7yylBdayqEyYa5dl8Q9vTtbzeI+FzGq14Qmi9IHZy77dWQqfn9YJyZmup8P5CmLgWz
         siUwC3cvtdrNfuCEpQv0xqOaycKZ5IMUzO9gs7PcidV64OYscStNWByaM6b/TzAJ+V7+
         g0LuaS31ejU0LwhBTrLO1Rz9fhJ6kVZYk8b7F1XFdxVSH5XFCAK4oImWJZebb09gjpaN
         lnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNaIzptlE0GGXIG2ho/yD146QQHEiXW/0qVfWgb1YVAFiq/rkg73oz7e4zInhPhQSEfbHaiybdTEebm5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EuVckAmIZjR/xVSTbFnEPxOue4t9eawsZeMwBIuN/UmPcQ4U
	pT7iI2tmLdK64lzttVXGJtovakV8QrlhNhHgNZfIFkO66G1fc+jGZi3JOw9HrPWBQqDAauECz/7
	Y7gCwnnD4Rkp+0ydeE6l5bRCOnLgfF34eKsNSNdZ8JOF1dJ8NE1xq+5oI93tA6wSgdO8=
X-Gm-Gg: ASbGnct2C0t5Zbk+F/BoMWWq5tXADGipvdymn6mv4Ekn9crfQ5iivKMqEHj6bn9pVPz
	HF/WQG+mOdUzsro6rwboJBY0br2uWdFX5YIXSKFTzBS/QHHUeSDiLa2rQNbGzJysO/Dxm3wwEyM
	yWbKulhxWBapF7+M/ybOarQylCiJQFLd7mm5cw451HacpBOvyeGN/8mlUmU++W1NIgJVa2nzxMh
	vLpIJ3LJjex5nDC/ppWCUh2aAbRGHdb7Iolh8Su4cbHlCBHfpS1XPjPhwKKj0yVTgNaNM8/YCvm
	MyEmcq09a28KiGmdeAVaw3H+oIygoZTNRqi9M8eHTj2qzSdw/swy3FnCvu7y41GyKevzKg==
X-Received: by 2002:a05:6102:a53:b0:4e4:5ed0:19b2 with SMTP id ada2fe7eead31-4fdc2243659mr5411382137.9.1754388152103;
        Tue, 05 Aug 2025 03:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLQKUVXH95EUZeQRDU0eF0Ohtf/ON/jVpxNZP2FzfGcVyv6l60sKTLIkYICkYA8jVIdaoEjA==
X-Received: by 2002:a05:6102:a53:b0:4e4:5ed0:19b2 with SMTP id ada2fe7eead31-4fdc2243659mr5411335137.9.1754388151721;
        Tue, 05 Aug 2025 03:02:31 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c470102sm18416825f8f.53.2025.08.05.03.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:02:31 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 5 Aug 2025 12:02:29 +0200
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org, mchehab@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/7] media: venus: Define minimum valid firmware
 version
Message-ID: <aJHWtaLung8Ubdh8@trex>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
 <20250805064430.782201-3-jorge.ramirez@oss.qualcomm.com>
 <a5c292ec-e59b-49f0-9681-a990128cbdfe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c292ec-e59b-49f0-9681-a990128cbdfe@linaro.org>
X-Proofpoint-ORIG-GUID: 4yM-XiSz1rJbmagDnPRJyhQs8k_1XawS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3MyBTYWx0ZWRfX0tjwpHbrU/9d
 ZsX+AwB1FLaBmAmocu+7kF3+ofRUqdYhSTWpUh6cWYJRh+4mz97SEs8glEw6zxerFIz/8WfPHHl
 pgF5XTHm+CyjnUu2LqAONnv8Iv0N4Ztw+NxLjSGdIGQsEWKtDXcpAaGRY3mDdTEO8pwkwM2Ipw5
 Tc8CPDzKYrnCAaLb0r1kDzg6ZAOxZObc/xzmTSaf+2OHpxXaVe2JDzwfso38HczOpSfAQqD21vC
 /771iPot3RYmqeVRv2EqOLu9ZB86zJFREFSM0zekmSV99m5WnMx37Z6AyheTrAMDPqhOVLIp01n
 oDw5nwZ4/+y9LtUeipXO9e5uDLVSVgOiAlUPi65SYSlP1h4AgoiFe/IQrv+ViaGE4620AopJAL1
 XqT52FZvv8NihCnLkWiNweAPb7+UehRctHwQW6nyjux8Qraewmm7E+hsxP2Lx+7LstjymN2C
X-Proofpoint-GUID: 4yM-XiSz1rJbmagDnPRJyhQs8k_1XawS
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6891d6b9 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=GmUu7VV6tgk2skhn_1sA:9
 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=954 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050073

On 05/08/25 09:29:55, Bryan O'Donoghue wrote:
> On 05/08/2025 07:44, Jorge Ramirez-Ortiz wrote:
> > +	if (!is_fw_rev_or_newer(core, ver->major, ver->minor, ver->rev))
> > +		return -EINVAL;
> > +
> 
> This is the sort of error case that deserves a kernel log.
> 
> dev_err(dev, "Firmware version %d.%d < minimum version %d.%d\n, etc);
> 
> If I were to try booting venus with an old/unsupported I wouldn't know why
> the probe was failing.

ok

> 
> ---
> bod

