Return-Path: <linux-kernel+bounces-856888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96068BE5566
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7558B4F7CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711372DEA9B;
	Thu, 16 Oct 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJbWk0VY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D32DCBFA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645589; cv=none; b=Iuv41s9MhBn7QYT4K+YuRz+LzSH1pk4cT6tIW0mtQPX002l1GfzBkLmdUmRqJaErEyOXgmnKky/7aWVPS9YErSjgjkbmvOa4ZRo7UQEVqakioTesbtW3OPo7YALBr3UfuHmQNVJpfTCVfQzn0EJ/v+D6XiLLUl5/B9lsgy5QqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645589; c=relaxed/simple;
	bh=mOME36+8eQcGxhH4dlB6qH+29/zcbf4zo8g9Kx3M6/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDqQi7IdoR88Z+aG8XBZmGQQChWhQwf6a8KF61B4lBY00C6/HriHRSM1nrJ/EJ3KW7fuOlpwvU6Wnzkp3kTT1ZzKU3dRp1zbfD8pVYjCYKwPdtjJAt5qHzGgQFIcSWaCmKsUdPMEK+sw+6oTpISOzphqC/5ZOUIABUkSGxosOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJbWk0VY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GG7FMY004435
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EZQrGx2m2xHUIxdtUEMN1cB9
	SbmMCf28CGDq/t4r4js=; b=IJbWk0VYTEllwTRWe8pLZBWqeFQZD5Hgo8gLf494
	nwsIHDZIG7vexKXz9+8KCJ6jGY8LvUXuvBt0nlFwE8q4nvDEOLS9DArAQ7K6Mkwc
	bbJ2t9ZpTQ5PHfLBNfn5sqOAig2K7T3+oADnIBkO8m3zdc5QHwurMMXd5Jucg8Wn
	vUlfiv9TXv46n9nI5G+nSO2SW6S8UDGgPT6MomcSMrFKVVDFs1KL0qKsVzbb7ibl
	ahlhTkSME3vKK5kZTuIW74+ZRXUOrOCChggm4z7bNbKR3w0cmUHqdtqhFmIWEEK3
	79sN/Z/55ePVXP+i9BkSj32yAiBKxIjK/ouIJJkYexJuyg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1anx5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-827061b4ca9so334217885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645583; x=1761250383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZQrGx2m2xHUIxdtUEMN1cB9SbmMCf28CGDq/t4r4js=;
        b=VlmMkCKrrXje6Coj9DD5lqkMoXsSIjlRk1tD8l6gP68iiRLxSLBrKRQQ6FswlnqebK
         LC1hVe3oPikfJBFT99lvi3C6tMJrZj3O8c1d8kDzXcBASjWC8v4OouTXZuHTuaF+Yr7n
         oouJzkjMyo3m8LLfBcqfoyEKSMskDbACRCSCcylmvY4mym72Fp0aSPfQOcd4y8QFL6zK
         ZaltFYfVpsy3kDceMGB8TDY/Kvp/isN7pWwukW1LujmA8w5V0sf25hnAld2qcoJcs9MN
         ebHRd+UVmzNQEm1/c5LpvMXt1Fz0l3iC5cnqUAqhvp+gnhbmL1UBXXC3Itbvowz2hLga
         wVHg==
X-Forwarded-Encrypted: i=1; AJvYcCUmjrJiLkZTHvvmEhK7uBioZC2ufleElwiRQbW8NzbLLQLuKLMDjx/TfeZeNj5hzxXx+lZ9cW+W6jWknps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1fU4GtRnWkrKQNgHu4jJJDNk/LUeYWsSG5/eVou1QXyV29Y8
	H21EWfJEyosgiTWOscpAYUxnUFsiLizWVUewscwsCMYWXZw3j4igrExPEOAv4dt5ZqSfhl9rYBN
	2iiZCAT8stY8h7DLT7MRtatGW8ebdSdmFtuTQJi4C0KOEQpdB1ZkY0RVm19cRZq5wjPk=
X-Gm-Gg: ASbGnct6JLGpGMPLYxtHdcakVhAbTn/v+/23ImRNJBOtuyEtC4rLCOQv6hMk3QdjSX7
	xMOR2vjojGxYv8FfJCbhFE3HR3iJDewZJErPfpTGSUVUKE+w4Z1y1ARQUgWTUbXTFZ+UKI8sITE
	46EOJNJgH/raMKCirlq2bPbA5ixK1ILLVwg6fsrneV0iueRTqeqIubJQ+b9yZmg8SDBGRkoFEhZ
	yiC8eIEVbUbdKyFTjqzvqbXF4CXmfhV7Naw/0sGzgRq28P/VLyHn6wXfDQXAjAxXkB0PNrG+9O9
	PklVudXAVIF2MuL+Gt5KJpMVoR2o9xS8rbc71xmpuD1X96cR2UbAdAm1Rv7t1gaWu4ksOrIwkto
	Q8owTdofziENMVRW3uUtElR2/VWBoBcao7xMo5FFV6LTediQ74cqm9lZmvbbpXMnD8CcuoPYlAT
	UgkMXKG8qvCvY=
X-Received: by 2002:a05:622a:198e:b0:4c7:e39a:388b with SMTP id d75a77b69052e-4e89d357b64mr20224731cf.47.1760645583010;
        Thu, 16 Oct 2025 13:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNe0OiqXmb/bPK0O4iLCJSWLwLXN9liqFFAIqNAzYgpnDAi5RXwm5Sf4ucmJvR7g081xSpLQ==
X-Received: by 2002:a05:622a:198e:b0:4c7:e39a:388b with SMTP id d75a77b69052e-4e89d357b64mr20224331cf.47.1760645582578;
        Thu, 16 Oct 2025 13:13:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856381dsm7280357e87.80.2025.10.16.13.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:13:00 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:12:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: sdm845-oneplus: Group panel
 pinctrl
Message-ID: <bspiap2gflponimgt64ulkuyp6sfpzab22bx2v27tdg7m6dynl@c7p7eay3h6r6>
References: <20251016-s6e3fc2x01-v3-0-ce0f3566b903@ixit.cz>
 <20251016-s6e3fc2x01-v3-5-ce0f3566b903@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-s6e3fc2x01-v3-5-ce0f3566b903@ixit.cz>
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f151d0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=zJdh1BpShusDlwL3NFkA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: m1K1ZaaeIrKQPf39rEpjDgotO2W8Y_My
X-Proofpoint-ORIG-GUID: m1K1ZaaeIrKQPf39rEpjDgotO2W8Y_My
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX4vyYXggaITr/
 XncPzPwv92XmvD64H7O9f6ibfFgKv6Z6Ee7qGwgC2vM11Xgo4QHdVTwbAUJGIP22IiysOX6PTs/
 ws4U+YRpks7fH5EWaryM324ympy9oldLT3XI+VrjPYgz3BI/ifASiEH3hy8/NI5fRiyHD6U01xR
 l1v1pd3BYtmR/4+R+ls+Q+WBZJgFRQsVmnfXzda+7WpTaAiwysws6OHOIiwq27jbrfnhaVdos4O
 SATnzQUWKtPmHgf86aMWtJQEIot+zcDKHJ3rSw2yHfXOfwQZH5cTQ+MTvJQnH2/FpLDDOlsqwAD
 CNcYDSgYx+dhjWSymj+uXnPf0sRTfZRJIJMTXhupRuzeNRQE/tCFYdw5N7+nuOI7eMmaiA0B/jh
 kNN8BEwAYDy4MtKrWw19hdmpOMjdlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

On Thu, Oct 16, 2025 at 06:17:00PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> As these pins won't be used outside the group, let's group them.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 46 +++++++++++-----------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

