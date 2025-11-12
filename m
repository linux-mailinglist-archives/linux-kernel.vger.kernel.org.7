Return-Path: <linux-kernel+bounces-896888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A08C516E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2F4189F8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5D2F90EA;
	Wed, 12 Nov 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mw6t/RvO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZAurFEf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF82FE568
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940606; cv=none; b=OfbwsfqOi6yAGj7TquUhIVtRjgCp6ZOl1nYOVxsKhuyeM1d64YcH1B4/qpAkpf2pcAC8SxXKD0TAgYOM29ear15gMizmx7FrEXmFLVWP2uLs4IEvCx3MIyRQtUV6rd7QfOQ2OPvNUk3mMDLgPiI+YLmNR5VcyPnMi0FjuFTZ+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940606; c=relaxed/simple;
	bh=x9HZDMX3Zl7CIXyTCe51Kaaysc210oZGR++rzbzttjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWoVSkKJCLlumkETGjn8u55fQm5xMsH5RDtXgHY5Y8EYM+6G0+VzaVy+KJlgDFx5UpEdelAYL87kH5u6yQrC4d01Omq1/LAhC5GpXL5dTN74sqC+OatgmAJAFN0exB5nDJx1HMPs2sS99xp9N+cxrnK8r5xTderUm+0u3CHTH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mw6t/RvO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZAurFEf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9XnCg4077097
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LP0rQwhtBnPbXDJLLh9Cb7GUk7T1lPnHvrnhjlBK9gk=; b=mw6t/RvOzawLe/O7
	jAaHOnYA86/+4455aXIAk3wk5pIXd9CPeqaqhzPOkjVd7nvagTiMlJS3L2v5CLAE
	hsB5REIrLL952+Qizg25AnjYyfzR3w6Rje+XDXF+Vxp34FkVVM+tnXXdMBecmoyR
	HKdFSzB8LwByF4LNE/OcEIKbO9TK1aj6ezf6xGTUFckHl3wkXYsyrSAcIYdSIH6A
	KfqY4sq3KKZSrSQrTnFNYFQ/P3tigo77ofhIxsNZz1EP4wbqBB02+rMoievKdhUN
	56K5OsWXlSezcx9adFwde7mf3b238ffq/cL9k9jlwvqHH3AqiCGMAfTAizcU5bLa
	FNYYVg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acguahb34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:43:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6317be8cso2058021cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762940354; x=1763545154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP0rQwhtBnPbXDJLLh9Cb7GUk7T1lPnHvrnhjlBK9gk=;
        b=QZAurFEfbI1AuhF0F5UZhJu9oTJX8EhqstrRbHAvGSiI6pRJJV1rncj0qI0cUUWGDM
         DUAZaXcC0UjxsE6E/toelxgy02WjlpUagrp1gtwGA1N9rtcLAL2ACtvojEoFYPgsjwBQ
         WJDFMEZGuKix35VBu6Ii4aZJ+J9K4RvwJHVRprLN//9CjXiIzcNC6hJn4JvgmRpAYajU
         1S42WIZlFRGzGC26I/YNpFQ/ECEuZe3JaVagoKZ/qsZ0755mCFrSmVj4bS9CVc7AD1JY
         JdwtxmDv9MIK5zmDvBBwME9GBLTqR9ycLwMqoA4vEoSv0RwngDiLlZ3B47U3KrDSoNmQ
         yJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940354; x=1763545154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LP0rQwhtBnPbXDJLLh9Cb7GUk7T1lPnHvrnhjlBK9gk=;
        b=JsmqZSV6Zl2dx28z8RpV2YqUudB6rX6U4IIKLBc+AA78Mvp4gZYRU416FG5iIpCxIA
         x0qs9gpn7sqK7V4kvsoPU/ZDpBsAxty39EQVreurPc1/39Wqa2jA3v/7JwWtqrW4lmdg
         PmARFaLopnkTtw5GNGYWs7xuTfycg8Qvn/EMcdTz6Azer5AgPiJhJuclYxMoeRfNPdsh
         SW56nCUKIcvJOBRI3uUylFQ4Csi1UHZA6jsVujNCFy1HxFtBFZjOc5NV6TwlH9SHiklj
         65/M0Sjo5c8pvJvNpHQXhSRoNzr0wWsFHKaXGrIKRMTGgBaRj3pDahH1kXIsViV1Dp2S
         vKSg==
X-Forwarded-Encrypted: i=1; AJvYcCUfShPatYanX7a5pyiaSjNnqmVxIXi5HXlRbGohT10NWDwPSBcrHns4zjCl1EpRlc+0LYDcvpUgKcDj650=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyMP4ZI4951Tn6Au7UTYnQCG+c2CwLtnBB4xK/2OsNnsQqRQI
	OHXOO47iucxOiJQ0Lnwl6aosA2fRt1UD5+UcE+x1ml1KpD6H6NwoMy+UHxlwmje03vM7JYTD0Ac
	Ma+MrBmQBTR5vktVHD4xPQX4GWwbf4gkXaBnxoimlH295pSuj1vIPQX7ZIwRWqrB95vM=
X-Gm-Gg: ASbGncs1VlGVzW+kaGVVC7AHNP+zAqcUKR2sPZGO5IrFQOBI6zt56kkSgiPnW29b3ey
	lS3OC9UG6uENGyCOGIgfxWoaDq7Oik04ezJLVslIIfw6Kv2ni2Qi7xpdp3ZS4N1rfOblEhKtcep
	XRgOpTt+faONabCr6fKO0srDSgGA7JDxZrgiUX+h+nSiOftV9Vi0YqiX78ferVPvhlWao2KgqKH
	jbYQzEo2M0GIsBddc0lQpJEFEbNhVrSc/yCknlVaNA7eb+Hbvwp6PLLpJP9uVZnleRhgOHJbcY/
	D84V/n1X1eOLNMNN001DxoACzzeumWi9NkgxNRKLRGQPlAfTCZA75AIol3uulf0jhRV9ZwM2XaP
	RqL8poor3SvjhnFjVrWAhVI/1OSz/rgEjR0CMS/MQTpP/7PmL8zBjuEGa
X-Received: by 2002:ac8:5dc7:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4eddbc9b895mr18101711cf.4.1762940354063;
        Wed, 12 Nov 2025 01:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCn/jV7wFdg3W1AVfUFL8B7J0xd9T8o01wXhaCJP9H2hJuRKsMlSsXgVFBDzEZebZV6pBNAA==
X-Received: by 2002:ac8:5dc7:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4eddbc9b895mr18101571cf.4.1762940353655;
        Wed, 12 Nov 2025 01:39:13 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea8csm1551575466b.8.2025.11.12.01.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:39:12 -0800 (PST)
Message-ID: <db7ca9cc-46e7-4edf-8419-eb03782c2346@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: hamoa-iot-evk: Add backlight support
 for eDP panel
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
References: <20251112-hamoa_dvt_backlight-v3-1-f35b44af7fc4@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112-hamoa_dvt_backlight-v3-1-f35b44af7fc4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YTTDyVZ2eVBRnuldxN4a9033PQWIoge8
X-Authority-Analysis: v=2.4 cv=ao2/yCZV c=1 sm=1 tr=0 ts=691456bc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=nPG1Do-yNho4o320QkMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YTTDyVZ2eVBRnuldxN4a9033PQWIoge8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3NyBTYWx0ZWRfX2r9VnMsSJ77g
 Wj3qu2W//j1eE02bJmiuJC+pmdpc4v1ubM5n0ejxGdPlR8yEG+CynaJg7fqZ9RaVaf+fAcGBda7
 VLmAMwX/0sen0ND8YRQXIya2OfRA6ZJMYdpy5iMaC8+pqOZbLU8hBIqdE7d1I0YY3kMXNkON+1u
 QDq7EnRkOSPfxe+YBJp//2gJX3TU+YW3XYqUSJzcNcCPQcjMNlR15II661dLd0L5bRRR9aJsZzL
 OHjCOi7FCOmzE5Y7EjRWfC0aYW9OhPaU0Bf98cKYRwyz/vziGZHJpDl9NeKJOvdL4cgSVrH4VqR
 0QOBmmYKE8JkFwhl6a/1PzzfCDq8OMMTiRAPM+03Dst0rATlQXroLfc7lVilMXM1m+DQf8l/RUG
 phJJ01goPHNHw1ftaf+CHnZ4Pit58g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120077

On 11/12/25 5:21 AM, Yongxing Mou wrote:
> The backlight on the Hamoa IoT EVK is controlled through a PWM signal.
> Aligned with other x1e80100-based platforms: the PWM signal is controlled
> by PMK8550, and the backlight enable signal is handled by PMC8380.
> 
> Describe the backlight device and connect it to the eDP panel to allow
> for brightness control.
> 
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

