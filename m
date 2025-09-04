Return-Path: <linux-kernel+bounces-800751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F8B43B93
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347397C45D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CD2ED17B;
	Thu,  4 Sep 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JN3bF89Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5B2EA480
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988899; cv=none; b=IfC6CcHkW5VR+y2H1rJbzII9jlyHmRcnhmmdaH1z7Fjehjbtoihi4JyO/khxXZuvSni+P2GXuag4/VFCTzLR2KpHWXlvy4QO5+GwMeJPpEVtav7lvQIbCo8pBPEzJzWo4oG7swA5ZpGhAGC23vRiuE1fKI/+REEfjOqqRtdR+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988899; c=relaxed/simple;
	bh=iZ1yconFgP4SU+f/2nEV3Iq/VVfOyxDTTCJZle5egt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJgurUcOgheM777KqNmCgPLhWdmL+4Yz423/u1qwBs3wegdF5jybEsgYEFE1wB+EBSar4LaPq/4JX0T1LJSciQTZsfRlMCBhRFvpzzFGra+KYrNmhzh6nF5u7ZuA/sIAwr9ma9waTTkP/oXkK/pERBCFT0IcsJQplozLVxT5Jk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JN3bF89Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X6FQ013960
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 12:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cTkNPIlvtexAzRNVdxPe6P4Vsr6y+Ml/PHeKH4/6EBc=; b=JN3bF89Z0/kGEe74
	+d+OkDoXnmO7Pt1aqyPMYxptJs630LQsAAxVl7AGY58FHfo0+PgzoTBBdVlKBItm
	FOBXShPAWqxRb24FQZbr+YIa5SrT2/ljBq+xbJYxoXxCMcgOkrd2g+qlMBEErR35
	rEn6JDu3kbXZgOQPe92kx4drtyKt7XyrVoTOAzlDgo4M9yze1D68n7ivrpEpbzDO
	odHfTAUQd1hYws9+5ERImSeOQOJzLdJRAlPZPd73P6sddwMH6Rya5yvyBJZ5BEi+
	GZaqaJ1mjmS5jES+/e82FjacbksNdUjEfwjJ+ie14HajZDhzTG12TNKDYcFsqstZ
	Q5LRqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv7kb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:28:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b307e1bef2so2434751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756988896; x=1757593696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTkNPIlvtexAzRNVdxPe6P4Vsr6y+Ml/PHeKH4/6EBc=;
        b=J10K8qhCfNYTD7Otc3pGVdZKlTQuRvPIjGNUaSquEg++7+ZXLXd5aEeysMRFzwWCn2
         IOgUFNcANUftvjNAxIG08DGXSFAgRsDoIPL4FoIyjAeDGeHbBBuIzFXRRGhOs3wKpFm6
         0Qo8/po6c4nzx+onIwUd3ATTAAZi7gEUdANibdjKFdWtudlkl3V6fYq/m/T2YqC+7dK2
         YNwheIawPk+6cEuc15k7Vzv9jP+TJ2IKWQJHMuycWF1s57YZP+YlcPfB8lz7VPLWBT22
         CdfsGQZPkOAzYJdFb+G7m74cOlLEOFab5muzh4laJ3ajvFzhjDnsckD5n8HQQW/uHG+c
         9QPg==
X-Forwarded-Encrypted: i=1; AJvYcCXk7oTjA2y9QDOfl1gWsPQ0duktbJpWd4uYUw9bVz7Pgtf1Peo2rvpkFsy2fRJ9OvLVMh11xlofp4YlACQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUf55uZUodplQFgKfN1dNeYiS4KwKDL9KGMaPIBMxoMZnQT4Uv
	8pF8walUc1Y1XZpXYRYMb4RL8o3GQHfDAhoTZT+xbKXj6uOxeAYDrrE/Dxw5tcbp1OvFfRB1P1w
	keuqj9y3nA6t9+wygAkv0YgHO5hn5t+YMRKYfqTg6WYAiGUKfxybPbd0/zsf7CERUwXs=
X-Gm-Gg: ASbGnct9DVekp2ILwvQPnfNeSPITlqe+KjWOGKYkTgG+v6p/lohdY7jvAOACj60EAdn
	b5f/7jW9U6WIE4HPig8RMxjMZzRuBYVaUrJh8m8o+Gqa68dKpTihVraGFXdPqTDR3v5W2G24go0
	78qOskI+28BRNWuaHG56t7L3IXCdLMgLOSNRj5LlnvCb+Ea9583H5+my8l/YE4J0AofaLblyQ6M
	a6Gm+vVVyMv3G+J990hCdVdqWRWnux+f+XAqigwW7rAV7SN9doAvijtBbIxQbvn3MJLw/DG/0zc
	P+bocmHW9CBIZiXWLFll/IFZMOrddWdufJMC5RrkudzjbMQ8W2VM+0DnJG+QueEcK4ZwcWuT/bs
	Ffqcbdu+JaN85nlri95z8qw==
X-Received: by 2002:a05:622a:5817:b0:4b3:4b14:b421 with SMTP id d75a77b69052e-4b34b14bacemr76922051cf.10.1756988896038;
        Thu, 04 Sep 2025 05:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKNLr2UG0L6qxbC6a5kcKv9i9FUtalfXAqyO8H2z7P9qA2jLyWbD9ZRvkUjs8xg0e9iD5JmA==
X-Received: by 2002:a05:622a:5817:b0:4b3:4b14:b421 with SMTP id d75a77b69052e-4b34b14bacemr76921691cf.10.1756988895551;
        Thu, 04 Sep 2025 05:28:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc52ade4sm14078747a12.45.2025.09.04.05.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:28:14 -0700 (PDT)
Message-ID: <105b3ce5-8934-444c-8cdf-e338af3e3552@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 14:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/8] arm64: dts: qcom: qcs6490-rb3gen2: Add WSA8830
 speakers amplifier
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250903151337.1037246-6-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903151337.1037246-6-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX4IFCHMJdxhJS
 Np0zumJXdZnT7WMV1FTQf7S+SAmFEH84PkUiE1knI3sLuniurUBnPOYozGi+/y3jrliFvno3y1s
 2MxvrrT1326uQRIoc0UsS2TZtoo+QAZbT+ZbmWS+/vlikChXnxd6k0wrFlh45DLsNBVViG1DTVS
 0LS3w/atNEb5EjU8bHyT5WCBNCk5wJ+lATP7wl1WjE1vFvjtVBsPkyMpe22sg8eDvGWTsW4bP4T
 jsbFSddNiEoH5/CJDpndQBoo8B0DclgVl7/eoh1RTtuPfaeZ/EwyDHneOMY9Mr6g0TRrwHvRc3u
 pyE9p9QfGziujUAJdPJYdryUIBSIXuR9uOzXig8lXvb32roOrsUMKS4a4g47ubQMfYGM3CTK3AN
 XxjI4k53
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b985e1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=MRceF3MI-pe3xWiB1lEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DYTBr35liz-OzTIjIcMz8E2uWaUIUTym
X-Proofpoint-GUID: DYTBr35liz-OzTIjIcMz8E2uWaUIUTym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/3/25 5:13 PM, Mohammad Rafi Shaik wrote:
> Add nodes for WSA8830 speakers amplifier on qcs6490-rb3gen2 board.
> 
> Enable lpass_wsa and lpass_va macros along with pinctrl settings
> for audio.
> 
> Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

