Return-Path: <linux-kernel+bounces-744350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4BB10B74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CF1887123
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FF2D9EE3;
	Thu, 24 Jul 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NE3dcdpY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C52D94B2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363918; cv=none; b=uirvhxQsXxyJGMhTMW85KRH3lOeJx8Pu+XTyb2sIof3GJYa9knXLY4dww4KuHYTPNlLAc9dJTd4mjijzxwyj+sWgfW1rIX6YGeWdGx6ijQikHZkpbQqA5DLHRmPzLPXQ+drLkFoRhUVvm+rjH3Rpq8nEutpoRhACCsMJOYiFxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363918; c=relaxed/simple;
	bh=F1kkTJWWATnergb0steCpxPDq7lIJ4ptvm6nISdTbfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H421btghOWyEJZK28dPMUFHGUP94sbgG3VvVMdTSEkXwMW8j3hdI/6wFYTdAdmNW2386VS4rc48GyT6YrwmFeruKXZNW8+GSO0KO64Ve9iv2ZoVNgNnesyAySDy57ughSE+47+T/9WDOZ9dIZVlglLxVLqUsvJe4b9HMHcnsDWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NE3dcdpY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9J1Gd022078
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGZqYstjALDPorUsHq3fkuHRnZDG0CR7bEzEh3y+/kc=; b=NE3dcdpYcFvCY/4d
	zcXa91WKG2/+pNf7gofKhRcFTKw5OBPLCrnaZ3+8toODsHaJ49lWL87WUbAMbJBn
	AK7gO2vvjMf/wA6/MOv5grvjCH/6HPBtktQrrKKi1leRRv5F9QTS+/zs5eb7ZZlV
	VGsqPmcfcBOLkFHxLa1qoZDCuk62DUwpaA7Bw72K4df6gRM+iUYgE3tC49C5+VX0
	yP9R+VrtYLS8pb5pigkDnWl6PscaX/Uhz65sXRIqEbK+z2TrcCAR2VUoIH0AHEaH
	+905GNAXOLNufxJ+S8alB2MQQTd3FcoaozUj2+lLon2sRUIRm/95t87jJ38qfAAI
	We+lAA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48313kkha4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:31:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70717059030so876286d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363915; x=1753968715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGZqYstjALDPorUsHq3fkuHRnZDG0CR7bEzEh3y+/kc=;
        b=lLNlWmGQN31LQbAyeVQXoVfWJeg9VM1iCrpfXOqQUtEbJ2vdd0ss4aHoiLVDbTOwYa
         GAMR9/ptC9qXCKDVsTDnPG2Wp+B0VDex+QDcFO8+scJAX06f7FAm6hov8e8Q9r0lJok8
         woztPECgCy16COcVQKRmwk3Fm4wMjmDC+aaB/zpzhiHHU0mCHk2ESOdl5wlwFDJuBw/6
         ncL/tyUKFmT/lMZu5frekHDfI3rF9RcgHxTf39WtU85V9KV21QNwQ+pO6fYyNUNOqoax
         6y0c/BKXvT8K6a8+RJxhhNO5a8QLMJX+unmOjC+OIomFaapN/A8mciTGw/KG8padJ7OD
         KIRA==
X-Forwarded-Encrypted: i=1; AJvYcCU2qMtyQOmnFh+5ykcqx6t+0OlxmGItxuCWm1Og+NdpnFy+a4Mr4OvoSgmY3kj1yTlPk/ObZXn8dx13120=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuznra1j05WknhMm+2QySXYMd1HZ9POWJJ+O23wOxOyOSQnmnc
	VnDVlGIKCizEFQ7bLHs77EdR1PcCELShWyT33cMOsNJMxuJCsN5CxYvgzMa+l3tFZ7vkTfOVO0a
	ZlSSFV9ILWAaODHxL2Wjd3YCWWgDFGtLVFyMiQGJHe+wGdN3rvQIol5nPqhZHPUCy8aE=
X-Gm-Gg: ASbGncsU6SdTbRPD5BgIdLrBolEKpW+etjCyFvVmmUKL6fVo0/8T6xmFU5R2qnmLB2K
	+3vyzHH6XyzGnVOvtNITGiOITNQqfqWcYrPqztExUeMk0MjUeHR2MLlyvVN96aB4dqPm75/tqmf
	ebCy/XI7xfRqhrM/U9N4gHvcF6ijRdTej0k2T5UwsQVolQYNcCXUby+aBMRb0GiHXtWsTemI17g
	3UqfnIkEVzU+0Wjt5v9hNk08lcG26ffqyRLsevSDsKmVXxCB3r/pb3rxFH1QCJhcEpdJnpOreOT
	+W7+2nbUt1udaO+CbxLheVab76eSH/m3qqIZPlhfCTzeHeMsvZ4rVDLEssr0/RHnwX8GtNyE0Ma
	q1SK0g9zBuSRATAME+A==
X-Received: by 2002:a05:620a:a49b:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e62a1ea577mr372423685a.12.1753363914577;
        Thu, 24 Jul 2025 06:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1LI4SXtUDns1xFXr2pxNw4p8OV1O+xy0f8RV7nH2RnjoV1/Q0cvExqriBQrt6rTZtA+N2DQ==
X-Received: by 2002:a05:620a:a49b:b0:7e6:2435:b6a4 with SMTP id af79cd13be357-7e62a1ea577mr372420385a.12.1753363913957;
        Thu, 24 Jul 2025 06:31:53 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0f72fasm862314a12.24.2025.07.24.06.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 06:31:52 -0700 (PDT)
Message-ID: <276b7977-45d9-4b37-a4f5-1c65802ac267@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:31:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom: remove unused qcom controller driver
To: srinivas.kandagatla@oss.qualcomm.com, srini@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724132808.101351-1-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwMiBTYWx0ZWRfX3UVC+tgHrYio
 jHp08XciL9+MaMxISi3Vj7qrlVaQgFgDubOmlGvliojyaVr1/lYelIBIhXzsgQj4yMy6A4ukVIg
 sHua8h5tff6Na/E+fZsBJGTB3zvTy6ARIYFjT/8G5dlJcEhg/Sk1UIBnn6Od9bxm5YRsby9IJFS
 nIap0LXeDWUeVj+O5w0hSTKJT+7K0F7VXTYr7x5+70/T0pB/UQLka3usP7Ut6IcLePBIL6FiUZD
 UtVoeUo2K3/LXjs4VbFYMIIC4zEoYymLQL4M0Pn9/2C0ZMP/+9TlTs7mY12fD3Ob/HMDvxT77Um
 +xdu1qhXGvFf8wvtbjmeYWcbt1q+oAhIuZU3FCYNziyAD7Iyg6Wu8R2aJnNPygwDVwm/B/PlIAH
 45Fo/MWZ09lPmJW1I8Lo9prAoeemIgCn9glcnMMPBP7f3m99gAn3L+GyFoKbuF5ljfcHuQee
X-Proofpoint-ORIG-GUID: UupRJSe89soUzDCBS6RKBkny0fv2j2L1
X-Proofpoint-GUID: UupRJSe89soUzDCBS6RKBkny0fv2j2L1
X-Authority-Analysis: v=2.4 cv=C/TpyRP+ c=1 sm=1 tr=0 ts=688235cb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-nCjNjGlNwJnK1JuTs0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=807 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240102

On 7/24/25 3:28 PM, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> Qcom Slimbus controller driver is totally unused and dead code, there is
> no point in keeping this driver in the kernel without users.
> 
> This patch removes the driver along with device tree bindings.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

I *thiiink* this is apq806x code, with 8974 adopting the new hw.

+Dmitry, does you computer history museum require this driver?

Konrad

