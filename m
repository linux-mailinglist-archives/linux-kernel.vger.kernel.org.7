Return-Path: <linux-kernel+bounces-724363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2DAFF1C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9121C801A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F70241664;
	Wed,  9 Jul 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cv4D78Ud"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961F218EA1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089135; cv=none; b=s4IAhhFzftOwQkIlr1dizANPJmvlAzP0X2BgWurCpuzEZRPIUi1uTp/ZY+3DHghrkfg7cEJvriWOEvEXQBu0CrykLSjvSlDw2E0f6aPVaUtEcAcEAiTBgvJtEaBeFpx7QrnM/C7nQG7VO5xvqGj7zaGexXmktwwknwMF2uu/zkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089135; c=relaxed/simple;
	bh=Czk5thyzfF1At6el/WvxrhoAQf01IpUl3TQKZoKmkrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5YWH01eZe3BVKLDeyD1CDgbBRxVWm5jjmrHOb4Qn73u9A6ESGRCClR60jVKaUhPSAFUWdA+bYHTD8z6mm7YfRQiADO91A1ibZv+V7yYllQtKHrDBhpBjb5lvZHwXXjiOn8YE6s/EEdofCLDgVNEmbhaBfYfbjw1qqE+ct/6xXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cv4D78Ud; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CorWZ031076
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 19:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LxJmEoIV/L+emefvsrdmnd313iEFnFzJl4/I7Di1mus=; b=cv4D78Ud1X3h/gCs
	qPMaz+TMm9VS3DqFYLrBAG6epgV7AnecF3VKdYafxnq96U7AvPb/Byy6ohPh8nKA
	dQgUz8NI44qwhmy5kw9rdwcNIzb+AFXLESYBSLjEfFsAJvyXIJYRAi2oz0AU0C+d
	ynxwrAJgUO1lRJZ3HjzWZ+nb/vWFjjv7WkEJp7jlNLznJzOs0pAUlS7aWrN0AFxh
	MXM6hd8lJsUfzK4/WJroEX9eLavgIqZLx8B1jpReiJPX1KiQk9sN/YBfw4/kv2Bl
	o6GMXRPVDe203Sar8X8p50i/mATIj3PkrixRVGhNjdBkaMmvJi8wUNbh+VsuV1+K
	DZmPmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg27gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 19:25:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d0979c176eso3702585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089131; x=1752693931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxJmEoIV/L+emefvsrdmnd313iEFnFzJl4/I7Di1mus=;
        b=A2Ey8fufGP4M1zR3s7flRhTvOFovyRkT+t3AdiETdbhlh681eqkQgIAdVbqRkRcRL6
         m1C6ARM2eEiPP1rav6Pew0lmL2RMCHBuZxG8YfJtZcglCVzwSbx0nEe+CUmeldEhi5CG
         jnFAeN362JsRhq/IIRtm4zR7ru6tW6s+SigfCqnTZ4+i3ufa5NGbapMVhVfds85jP1QE
         t9o6d9Ky0VqNk70Rv8S6H55VVyPB+CiPRhCWhXpeA4Oh7O5Hk16OFSTvl2dDZKAB692o
         fNu/qrm6D7pnqcwn83K90eDhzXwMPvRQ1U33Io9o+3FMeerA+WeVekqvJlgloWJF7Gqi
         mT7w==
X-Forwarded-Encrypted: i=1; AJvYcCWvAFhD1b69ZWyS7N1ZgLAk4rGkvlIrqIDvtMcJ+0h1eE4OwWFNkv3vIqGDtSY43QmOT1KQRjDtn+5w6n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAtlzvvAcbLsMrrhyBvCvH/ORXup95vYWv32gTbAdezPA+jdU
	Zqc9owRqcFyG8+Eo958vfetFi7VjW9Y3wYd+2xvTIwny8TBq96Ju6zSzksAzAGJrduVvRegMb0D
	6iwyrfLt1RyIvHaWgBECqaRpN67xLPT3XhznVMYbyeLNVDCoLbwtIH8uf+lSCY7INyQA=
X-Gm-Gg: ASbGncsB89RF1SaMYbpdA4CH8sratmCHNIpIzfbIhj1DpDQE/FCm1NhBNRD1KYPDdpM
	u47TD7on3kS15r4PARolCEbqgdw28+b1x8m+LfRsb4s00B+/La9kkSHWKGnDPWzopvn44fbLneP
	VZud84exzz3iJnbjbgm1BzigH1VE1mgKLTL+TCpyO9S+LP2sooJ7c5a5zVTGXLRhutNgHEM7bx7
	SpWszxABJQWGPz2MWVRj2XV8Euv7W9bjdQLpeXN5z9qhzSOl3XsdDbrS8Z809tuBg9LQbnn0pmZ
	5AHTABp9ZgFqy5Thmo8xXmNsdQc2t6RPbRQCMTQIYunV4cWQblcFCE+hpD4oKXgg9V62stLrCI1
	Qtxw=
X-Received: by 2002:a05:620a:4396:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7db8a26a97amr207083285a.13.1752089131432;
        Wed, 09 Jul 2025 12:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF0lD4eFqC8H6SYk9QlZhxremi9oqzguzRcKWuEh7z55IS83KvKx0SZBgDPwxIqBeKKCCbcQ==
X-Received: by 2002:a05:620a:4396:b0:7d4:5cdc:81e2 with SMTP id af79cd13be357-7db8a26a97amr207081385a.13.1752089131024;
        Wed, 09 Jul 2025 12:25:31 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b5e7c2sm1159545866b.148.2025.07.09.12.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 12:25:30 -0700 (PDT)
Message-ID: <f5ea9bc1-7617-4573-a10e-3499161a7819@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 21:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] misc: fastrpc: Cleanup the domain names
To: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250709054728.1272480-1-quic_lxu5@quicinc.com>
 <20250709054728.1272480-4-quic_lxu5@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709054728.1272480-4-quic_lxu5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686ec22c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=UMl6nZT6BRNR5OdSVxkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: M29Lpkidb8nnmxQknJHCrvzJm6AF-Y7t
X-Proofpoint-GUID: M29Lpkidb8nnmxQknJHCrvzJm6AF-Y7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3NCBTYWx0ZWRfXyLVNv/PZgVFX
 m0YTSBrVQzNgZE9I1g3k/BDcS1L/2sYC4hClVy9nPJWcAhk8BGi2exuB0kpNtl68jHZzOtEQVD+
 VXQdi4piQwH7+c7BWsqu5zMWjrHcvz+LaEQbt59jgfJFBqhbY4MsLT1kv4e5/z5Wkcc4kwJn8WY
 ikjxH1FuuyY1JgZZSzD+wnhVnOppdwUrRcp5V1od++rdTQeea0hMhgFOHRP06CTJhDwAIpuSapa
 eo965pDzatFcivnXce/ET8/UeKUoxRJR1R/XAB42llFgieBogUBMgwDW0tBplQ6oinyT3tHDgkw
 seQYlxIjH+dTNVnL3zsCXd6eVp4NscutOyZCyAJb2udzzmHm0oaugJdRJjz5P8TuR/6XucHSxeS
 ww0t2pJXo6TPTUa+IuS4CbIbkMETpPD0xIv70bkpUpI9Va8YgPNrj46GIqEtOnZ8dd4Rh860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090174

On 7/9/25 7:47 AM, Ling Xu wrote:
> Currently the domain ids are added for each instance of domains, this is
> totally not scalable approach. Clean this mess and create domain ids for
> only domains not its instances.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---

[...]

> @@ -2330,21 +2323,20 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
>  	case SDSP_DOMAIN_ID:
> -		/* Unsigned PD offloading is only supported on CDSP and CDSP1 */
> +		/* Unsigned PD offloading is only supported on CDSP */
>  		data->unsigned_support = false;
> -		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
> +		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
>  		if (err)
>  			goto err_free_data;
>  		break;
>  	case CDSP_DOMAIN_ID:
> -	case CDSP1_DOMAIN_ID:
>  		data->unsigned_support = true;
>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
> -		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
> +		err = fastrpc_device_register(rdev, data, true, domain);
>  		if (err)
>  			goto err_free_data;
>  
> -		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
> +		err = fastrpc_device_register(rdev, data, false, domain);
>  		if (err)
>  			goto err_deregister_fdev;
>  		break;

Taking a step back, do we realistically need these checks at all?
I would assume that there is a layer of security on the DSP side
that would disallow running code in unsigned PDs on e.g. the ADSP.

What happens if one skips them and attempts doing just that?

Konrad

