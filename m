Return-Path: <linux-kernel+bounces-881997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE1C2968F
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B08F3AED6B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2419004A;
	Sun,  2 Nov 2025 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhgEr3rr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GTaUZbHm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035991E3DDB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115694; cv=none; b=TZpxx/S21azoHyqnFv3Yf6H23qyzY0cFZ9lsjuD2Qbch6HSwucINJtbWMAJiF0vqccd8qoFLek9h9AsSX7sg+YIwEJc2esYZ1vzk1dPN2xI0iB18q0FMesRFNctJ/7eepxVTN9bTEN3TACDKYSMpae+SAGrVBQtPVd92AGZUrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115694; c=relaxed/simple;
	bh=VgeAkwCeejVu8BwItTn14xHraSVbXgTX+41/0xFrTfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu0oCJxpFOmDfurGI84fJ58kLkgZsIMdNPh51ALSsi7chnRt1JQ/3Ajmu5JOnbzGXu+eOlY5vXgxFPcjyC4T21dO490YCbWyPLzostEYBMgwX4RjDdGDV09mKYicUaLZXNDCnufzoeX+kGEdfrY95/3xvZ3gk6twoYenY5LKieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XhgEr3rr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GTaUZbHm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2JjcjZ1011564
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 20:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V0zYBSXV1Wbg4ICGuc9vdNuB
	b2yaOaIQEkc4Ki3XvtI=; b=XhgEr3rrjGfOuQ7J0vfAD6Ig5+P65q7kiNW3VD1x
	KF35EfjXmuNk+bdd5Be/km3q4s0LIcnlDoE6oYP9r2pMtZZ4N0JPtLLTdJBUUUne
	TUPZTV6S2gW7v6iUhcvW6ZMVA3IEXbJP0iMqPQWlPu94T8goer/L3K1BZcRatq7c
	RLzG7mQyYcSzELOB6hJtxXBWhD+rxXPI2IOcVSfC9ZzTAk7CWJpdQbZcFcU2cs93
	LlaZm17CYn9hTaZCVa/5pZC0h1CRhqYaaxYWNNgzvCNpPticmfW4YrLN4tQAJdGV
	b5vLpp7S0Wbq59HAj4VNxT2judjMReVlHKiKfLeaqaAqZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ayfakcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 20:34:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4eba90c163cso78152281cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762115691; x=1762720491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0zYBSXV1Wbg4ICGuc9vdNuBb2yaOaIQEkc4Ki3XvtI=;
        b=GTaUZbHmLf19lKTo5Skg8iyub8HFhcjk1o7MSzl1SlFy5HXiJFPVJWShqrrcZXX7n3
         R1GcUSehIzJOzwFf4hA1+A0af9UctuIY8b26WpwvQz4y+a1HjjK4URFIyiPDjjnnlfa9
         EHDB7BK/4tXJyhPMCFvig/cYS4vFyVjRXT1URoaYYYTPPmzh3bW+6jDtqti1sQatNGAZ
         BBKaR96FDeVWRm6O92VPSbV/lwDqiXsZc3TRFHiTEUR/bUv8J19jhKRXsWmkeYTz43E5
         zFim0cK8mrv5PC74n3qa5/yYhoGA49D6Xth984e5/HkSGMgDPFvw9LIB5gO7CzaYVdxD
         OCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762115691; x=1762720491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0zYBSXV1Wbg4ICGuc9vdNuBb2yaOaIQEkc4Ki3XvtI=;
        b=QWkwBuJIquTPxpEQieelY0wUE7075cFZ91Hq5sqKdyE+AEsjuZX35TtHuaK/aWbezu
         cE06VD+kb//yUP7DcjI7ktt6dq83MQ128ju3ikotN3YBRiLj17tkwaHZ/hts8R2Eqhw3
         zByfQCZq3XbRaf6tM/N3a5k9fPo1UXRJXTWA9kWX/p+9JM3h9FlQAqz7ut5HJHX3Dzsg
         zRljodE2VvZiyvjAr6wSEoxYytyWfjR10JhSjDGQpSu7sV8cOFyRkBrSTbkv4543eejx
         7Qg0opjXC+1xJZN1vSgI3H8tQBqOTk/8xDKt0Zn8ZbAMGdViiC5aDwDlaW0gzW1etwpE
         ZulA==
X-Forwarded-Encrypted: i=1; AJvYcCUh8xTJmS3JSwv9sBzx54fzdYWRvODF61I/OXrFHX3oOJg85cv6uDrH0HACGpSHdFrMS+0lDCL2vebUf2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsx+rdhwQhtB+3ElsYWhO/CMvYoK+0mkfqr2tSYjPwQlvjoq7w
	54h9mQxskDeBqxc9a7AK3uGRHQAlSTvPnsihXKBCESUNJXpPjPGnBcpk+eqYeIZNzkRe6Ewq+dS
	M7GUHCpupTBmIixgEPiSPEVSjeFozKc30J0Ur5kWz9KcG/mnMFpjCls5rMBK+FX0XRUM=
X-Gm-Gg: ASbGncv2150FrpcGSQe4FSzSM3ycRwmxCFqhbw3w3W+I2PuG5ynWCI/+9rFlhc8+Wyp
	Q/ZpKxfWo+Bu/h1jNUiH4BWT9hx+TxPaKHO46gNE0l3oMAIF05GbdBIXy//fwoI8JVD+inB//UD
	kofhIp6NvsX2w50g7feUEPDiWoKwDdThLS20RwsAEWqlVZeUrGo4Ak8REcVU3nBKtqlEO1MeEdg
	32lo4A1+/9C8NBzb9dZPNnOXzIUkgCvQ6liH4mv6kMxU8A84Zbs3bzVlmWZVTR+WRl88JcwHdW/
	RA30LfxaO0sRUudm9V/ip1ssROoJo/W2BCqH4V02LW/glXuGe+eB8f//Bx20OCpucmFYpWv2do7
	P6JD5ANcOhD+4Mx2FI7zyZ6GrwYtTshEWDC4bD4K3wPCTFqzKhlk2nL+Pl3KJYe3VphJ3xessFm
	dDXHyr0+RXHiL5
X-Received: by 2002:ac8:5f94:0:b0:4e8:b2df:fe1f with SMTP id d75a77b69052e-4ed30df33aemr149576831cf.28.1762115691161;
        Sun, 02 Nov 2025 12:34:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYpwKRMbJOanwKK0p/tiAo/hMX92pwn4wJIyK+wbQmMbP7tOcp7BMR6Opqokznp0/88XtYqg==
X-Received: by 2002:ac8:5f94:0:b0:4e8:b2df:fe1f with SMTP id d75a77b69052e-4ed30df33aemr149576471cf.28.1762115690706;
        Sun, 02 Nov 2025 12:34:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc07fsm2295200e87.89.2025.11.02.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:34:49 -0800 (PST)
Date: Sun, 2 Nov 2025 22:34:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: maud_spierings@hotmail.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/bridge: simple: add the Parade PS185HDM
 DP-to-HDMI bridge
Message-ID: <76xhcyzdaka3fuocrr7nz3b4gsyqlgeloellp25t4cidy27yqz@hjqyp6k5ap57>
References: <20251101-asus_usbc_dp-v1-0-9fd4eb9935e8@hotmail.com>
 <20251101-asus_usbc_dp-v1-2-9fd4eb9935e8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101-asus_usbc_dp-v1-2-9fd4eb9935e8@hotmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE5MCBTYWx0ZWRfX10UJU1VXN/9K
 4FWDJStnESIJt25aqmL+4FmQXuyyLpfHdqUaVKLKQhMKABXK0qcgFov3fnNY7EPkvjFVFQtlilm
 72lhnM59rSbuRbXrNvgiXb043AwftcqLnTMzsONfE62mOTHmg9WBppLYGT4qE3IOWUso1fnvbmK
 Y6hB503C2/O0huHmOjrnMQRkjmAOFDxO8ghegcf9YwjCHFymEg4lFQvM4rNKxoRhPfwfTI/IkOi
 uDefpe1UTdNwDLljZFXenF2FAd0gyl3ORH3kOAii7Lr/C6xv4rj5qu0fJkBYpUpR2S1vDBhnS0W
 toxIW2awmDrnkDINXmj1eLM5DINp94gYYLQel44/uPGc0v7kNYwOfhLvY7SU2MvN0k+pbqLiBKS
 BYI4tubhW4sJdtDeffqmwvAtjXcYXA==
X-Authority-Analysis: v=2.4 cv=Scj6t/Ru c=1 sm=1 tr=0 ts=6907c06c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=69EAbJreAAAA:8 a=EUspDBNiAAAA:8 a=DjrArkTPs9SnCZ0heLIA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: v77MqiYaTBYGFemMDK6X1TCrJQaRBx6p
X-Proofpoint-ORIG-GUID: v77MqiYaTBYGFemMDK6X1TCrJQaRBx6p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020190

On Sat, Nov 01, 2025 at 01:54:13PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> The Parade PS185HDM is a transparent Displayport to HDMI bridge.
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

