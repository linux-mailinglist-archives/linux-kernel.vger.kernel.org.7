Return-Path: <linux-kernel+bounces-750764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3262B160CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BE3566B14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860D298994;
	Wed, 30 Jul 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n88pAn9A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1DA296155
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880118; cv=none; b=iI/Tee8jckXE2tS3Erita1F9OzUx+zFkAU9mVyoMZxHrjcQqUCdKindpAu1NAO83rLRzglKDuuitrJ8h1joFBFJDoEo8O2OoOGK4C9ZYSfRMaJmgZLuv/to229Uye+FA+dDpmSz0Jg3g7Pqrf2bb7yfntN80yWJrzp1sAaVh+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880118; c=relaxed/simple;
	bh=IcwJxjGaUBs19PI+lV/YEtHO4tM8mpf5SsPGKdXjFsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG8ej9wJThB5qDmKmOs+bipu6BupqJ99Vp24mCzofc4XVTZtkPfWsLofweeqXL2UKW43IkvJkTrxFvpXSqhqjC+RbAHE73v73y4nytvK9jb97CXS86RxiLKfYXmN3m+f3K0Meeep94FcTehy28mnFEt8H4aGk+ABhQ3as60BcJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n88pAn9A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbBkU012755
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iisB83FXZI4F5QXhoqp7ipsU6/LoD+KKvHx3mOfRmCA=; b=n88pAn9AFVyF+/AO
	CAxtSYZSKMdeJcLofbK5pr6fSTiWeaqdc124dFcpO+QnUzyTrMYd52Y6nO6uMLWs
	gZ2PUzW7iywdrJhJMBDj0z91kJO1UJY6L5HJd9Wl/4KF1DxLJahGA+d7dwWyRJ27
	gjQKYncf9dGYv+bwW0MH/jGQxcXy+x+uZJzQobpcusZIKYzAavoFam56tOLI9AKQ
	7acLZJPOCtwx9QX7Qy1S1867bc8bUf6sAN7u5zrhi+KushZ1+G/UtkhIiiLnUp5P
	v6KfFwRdrjmBunj3SBQRR7yWjROIVQKlUdDElkwsEag0W5Iq2yzZhvYdY7UNP8Hn
	zyiq7A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm3pbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:55:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073674bc2aso3384026d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880115; x=1754484915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iisB83FXZI4F5QXhoqp7ipsU6/LoD+KKvHx3mOfRmCA=;
        b=dADt3wrwGo3aTf+sjYz577tigp/9DR6quFiSMABVEl86h9u+8v8X4Iro5pHdIm41U7
         DwKs9slrvuvHy9BX0WwPqyDpHK06KgTvMrxbHUmcz3qDW/f8XqgL8gAkdNtB2x+IA9gl
         CCedifIKTZ9bWfevcpafrscU0KjbU56Vmo7VTyOLgeKbHH7eiPPQK8wWW89PEIkQraX/
         4v0fZugwr2IaJ0ctUSl8EJissP19q5546AuEf9g2siiEUmVYmE4NmSS79arjrr9NrI8U
         +gz1sKrDoYQ5nWq9t21OROwShgeS7GIlBnrLMo3je4J1m2A7kWJqnUHOrz/xhdOc5VPo
         Uvug==
X-Forwarded-Encrypted: i=1; AJvYcCUOh2vHXq8WCg+6bn8ALnNMJzIzzyt9GlaP6PLBm4YKD9DjnV4d6pJlSysD/DR7m8hEBkpVcvLr6zqeoeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDMRav0CkVlTEEGFSv9KPzyUL2gr2o+cOuNuCvTsPXw63wT6F
	8S34HqYDMfCGLfSbuJNUOjr/yaUbAA5LXpUEvXAsW9uoPp95guPlwBBF1CU1hdzcGN4ruQVWNLz
	sR97vEcGjuK7IVxn2Bm1az/GU+94gES7cam0toIqjZExhRpFwILYaCyVZms2CkxzsZGc=
X-Gm-Gg: ASbGncuSThhuQJ7P6UMvDfqHk2sfc+PSO30FB/VcCgaiZPphzJ0qNaHGIYEEv4qnSE3
	uTMXH9L63QwmflZ+WG92hNfIxeQ6TbTu9oKQCdv1WXM/SYAQqJ08dJl91xMTWIoVnFGnM4hYFKG
	J0UzELz238zsJeCwsTgdXis0J95vr2y+HaXzM7kX7YiGpQv+XKdXwm92U2NSeTCkGsEvpShK9vp
	raDq0U2olzdZtQ6s8kM5uUhhv2Pm2EwvLeUmnnjbOlpiNBUQ2tALEp+sEBaczOFzahIYNDBv/xt
	QglRPCLO/V7KzFUXJyX9K1fYrR4fH5yng4S1PciXQ6z57HzOIRhfG7FxKWI6iSsoHj7s0Nj87mE
	WKFjD2375eUwADpHlrA==
X-Received: by 2002:a05:620a:7017:b0:7df:d668:22ff with SMTP id af79cd13be357-7e66ef8c17bmr195813385a.4.1753880114717;
        Wed, 30 Jul 2025 05:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoyY3D0wsO5SLEh90EjUNCQ22vc89hWUifUn//akyEBL9q7sBkSC+N4U7QQomA6VAv1Ej6iw==
X-Received: by 2002:a05:620a:7017:b0:7df:d668:22ff with SMTP id af79cd13be357-7e66ef8c17bmr195811685a.4.1753880114339;
        Wed, 30 Jul 2025 05:55:14 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a183csm744196666b.50.2025.07.30.05.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:55:13 -0700 (PDT)
Message-ID: <2ca6af52-af35-4968-888f-390eee8b3bc3@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: qcs8300-ride: Enable Display
 Port
To: Yongxing Mou <quic_yongmou@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250730-dts_qcs8300-v4-0-5e2dd12ddf6d@quicinc.com>
 <20250730-dts_qcs8300-v4-2-5e2dd12ddf6d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730-dts_qcs8300-v4-2-5e2dd12ddf6d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688a1633 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=QYiTujBYGv1OOWMMav4A:9 a=QEXdDO2ut3YA:10 a=5XHQ0vS7sDUA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MiBTYWx0ZWRfX4KEXx5k7gDiT
 J4aMqHHKxWxb3IqkxvXvo6RQjrLyK3pkuKJdkjLOGXGlN6LDnpzbDx8Cbqk8fOkeqBgrm6s7/ni
 pilBTRx4wM7jggZPSjZ4xG0+QhAOnzHxM3ExEZdzI5O/AyUlN9+JYGVnpoQJKimWSm7cXjb0T35
 bdo9//NEQoZ5w7zi4pkXXcU1SE/QVWpXmT9N6GF3iHjTYCY6RrQ0NNPFsXky3vOxbqW+ZKQ+BkR
 hw5s621KlowZ1ysoW1AHEXK6oI2WwlhlQOwTtLOtcEWz1yUcNewv9xvyjrJNX+k1yAHo6LEfgph
 /Zy5BOkqpwM3xipRTUO8uzZj+SzpRnz5Lp8I1iIf0TRf/vLxrS8FzUTwVq6oqDHzWUnmg0Ioenu
 CgRGGQuUL7IeRtNctCdAg8WpY2QBVGqUodXqJ/kdAuiLN4AbLkKqcN/VDbASYrSb9jApF3vM
X-Proofpoint-ORIG-GUID: eNjfTjCW3Qfx8xV9A6zEO6u0DLvSsQec
X-Proofpoint-GUID: eNjfTjCW3Qfx8xV9A6zEO6u0DLvSsQec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300092

On 7/30/25 11:49 AM, Yongxing Mou wrote:
> Enable DPTX0 along with their corresponding PHYs for
> qcs8300-ride platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---

[...]

>  &tlmm {
> +	dp_hot_plug_det: dp-hot-plug-det-state {
> +		pins = "gpio94";

Please sort TLMM entries by the pin index

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

lgtm otherwise

Konrad

