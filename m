Return-Path: <linux-kernel+bounces-877834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A29ACC1F23F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 285BC34CC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5FF33A02D;
	Thu, 30 Oct 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bC4frffJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iRgZWjnH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404517A318
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814590; cv=none; b=ZNIRitiBhshA/rWzaP8zND8yyGQFY4ki0mbrxlKJlsIclRfIkb9uYCu8HAeBMRwqpsmY7JhHpmaOVORjIh8J8yvxcLFQ3vP92sv7aFZKkeW5AaLEj4vJzWCDRxPZ8d0p2JRuV2oC9qc1FVuiGztf3CKV/68RM1q+6/ASZE4+0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814590; c=relaxed/simple;
	bh=mQ9SPQWqJ9nb33h02PdJR2O/iR/fjBb+NSX63MuC+Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T+MRmw9Rn6f2k0usvF+XwXn23uuKPoOqBT9Sx2mchNDY9wLIqyC0S1CNvTNe/sBcscuXZZZLs/+Nw6fKv/cCWbLGSS4hkVddv1M782SqcyJwqtdwUGttzImWZHnpNdpt4kptMXkn3ezncObwgEYMEMRBqfj4hgkBMVs8JsaijkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bC4frffJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iRgZWjnH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7hQW81578496
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mQ9SPQWqJ9nb33h02PdJR2O/iR/fjBb+NSX63MuC+Qg=; b=bC4frffJ3qnz/8aW
	5tm0i9yNhLCn6Bd2MctK+hw8vdvpkI7Py2Jpn0uOuUKtn2HrSHWWf04PaAJQUAhD
	Fdlof2MtUXmuZy0l/Hs/5DzR8bXrF0ZARgfHNk5FA9jrf8+4oSntrtDVk7iDia1m
	GuH1/YFX3YMsjcw5uweBklyByKn+do/8KPo8svh0fglLqFalakha1GCF8Adkzuxs
	Bst/49nVq1TH3hvHxvZ78guLDGrSY5/gEw/VrREJF9JwmBLNjdOBOeDhE/+OW8QP
	Ae/47RtgJ/BqmxCobMHoETMs3w13sNzSOtS0UFSWdAwDgT8CW6Ks+Xwh/V+7qXw4
	+oX9Ow==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjehq97-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:56:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87ff7511178so2468846d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761814587; x=1762419387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQ9SPQWqJ9nb33h02PdJR2O/iR/fjBb+NSX63MuC+Qg=;
        b=iRgZWjnH4Lxcmyq/Me09Aim+1r/Hnpu8Fj9W0NksuVbw+q843ZO6oVBgqZpr8IJ/ML
         GGtZX8axL7l33VqVKVRae/qyrg/WF2KIa+Al+g68eEb5aPP0X4Fwuwc0a+V6CV6NgjVW
         5lOla+GU6TkKDFvPly/X3+9v/N61pbnX25ijL5RF23CPANfQeU7dpgwkvfdFQRmUSz1R
         ve6GpVJNaGpHkB6z11NIBjo68vJMnolfTtNFuXlgAp5f6k4tNzgv5l1v7okxubzV3O89
         tkiOq+P4iFn3CUkPAA1TkPuduMHCgj7zEfKX9F0to56PIKBAwdAZQnqKMX107zbKEkl2
         9h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814587; x=1762419387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ9SPQWqJ9nb33h02PdJR2O/iR/fjBb+NSX63MuC+Qg=;
        b=O3D3nhAhUywSzfIUae8rKR0c5YPXSNK5ITccp6piSd3ua0OwmuqtjONv5ty1O2HBpP
         L2o/+YnF5KU8ZmSH6FUDWXxlZMNY2ojMIrS8fAMoBmB2fQpNg46EM+a9d8IWkCG4xotj
         qhRK7R3nW9CXWL5kcMJhe1mKNAC/HhEv8jjCzfifRFDRcei6+NCcToJFcI6lpEbVCkgG
         mEi6PkMtOxa/bVkC3H3/SuYk7QyrV7OC3zBqJ/7hH+kJ4OzNhZ1cfpdJ/McaCzjtdd4R
         0fnUs0BgLbE3Hc3mprhrHSIan52m2jNO1t0vPOPtfZAGUA9Gs8k57EIvFktaA/7cBibZ
         hFnw==
X-Forwarded-Encrypted: i=1; AJvYcCWxsN0/eIj1fMNT7pAAHw114ZOwLT3fk1Z1X8oXotqq3dYPMCYDVcZw7Ivvqz1EAxwcGNg/ZbsmK4zjtyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMqrZMkciX6t8pDUM4dwQ7RNJvCEcxI3Uft2js5TFdQu+7jmZ
	fzdO+0rSPC6KcMoTMxBBA+AaPlwuJFd7KExSkXOwd/0ApFoYt6cpLaIFmZm5EumnRcrvV9wkF44
	kpF/wNuZdETNvORxWnPKDyIV+H+5LvJjMt9UyKSVElKrmpR+YiZUjc/F9Pw4izrkO9X8=
X-Gm-Gg: ASbGncsTEMf767RxK3ZkxJtpZa/02vI9Fh5JU+RfffJJPGWSOa3pyOXMPy5Fgk4posA
	ctuh7w7OkIRu5d07XVVa4YcPdQXl6KeTgmHkneNU6/7EhSdii82OM+rrT0nPWj8X458133/Zvna
	gDdIIdEAPn+fG7t22Rd2nBpf1QvjBHOn8Tqesbi7TM5wU3/56WWPhMTSEjOQ1akJ6h03bvylBDp
	cJ+W09b1O3427Nqgf9FCCK3f+8d8Pk2dBsSvV0o2DmPUEOHUrE0br9bLIYvo82OJjR5ts0++60V
	1IDodAlbmfQ7jez55hLV/u6TiEFidLBSrz71jE5yMyr8sn1Es4PLV7CGUatRh4zcsFvAX500y4E
	65/0jKRbZUh30IdkRTbvGloggE8GJLGcYDdftOWNtJv9ZAUs4s3yJumNx
X-Received: by 2002:a05:622a:1909:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4ed15b4bc7amr53127381cf.3.1761814587395;
        Thu, 30 Oct 2025 01:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHiDuxaYh7vyo+gohvs335rda5TGL4pOK0lbfpdxVaIF/d/DHkaNxZ3rX/BWO6ssfKQEPATA==
X-Received: by 2002:a05:622a:1909:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4ed15b4bc7amr53127311cf.3.1761814586877;
        Thu, 30 Oct 2025 01:56:26 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b705877106csm155603566b.14.2025.10.30.01.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:56:26 -0700 (PDT)
Message-ID: <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 09:56:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251029133323.24565-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hy27JHXpnIonar78a0rtGZQSGgb-waC1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3MiBTYWx0ZWRfXwgbx6nzzuO6G
 vuC7Sdx9AKDjTA/8BJG0b1KkSO0GvnkBeYaijyeZNPhQp5ekMp5nZ+VpIJO0QtZo9CH+zQFbG95
 vqEcsJpn/OsewbHdEO0vjkTgIx42B+Z9oeyPONcc+CpvODMHdElgsIyMiGV3aQBnpfbYv+OY0Ip
 KMoMwNnGVYIlppWna0NpChv6JxxGuxwZAAuGpGk8x01wX1YzlhvOB+ICkCenk5EuS1Em2O0AIZ4
 Rwzj0ksVziALmmOcEO17THUmkpNBhUrPAmLudsV8wy5Oy9//K5HxVfHuoIg33O56cx8jSWnwRHE
 goZahOiA/g8Vgv681Fu68gV7KCi77hyfipw54PISb9dgqd3VR2fnp48RfJeQKnXcObgJq1eQnjo
 I7hOq4aRG9UIKgg2cJoDhiKTmzD6Kg==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=6903283c cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dsqsQVcYGt_M5tzRwdAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: hy27JHXpnIonar78a0rtGZQSGgb-waC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300072

On 10/29/25 2:33 PM, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID.

Oh this is (the unpleasant kind of ) interesting.. Is there any sort
of uboot/kernel tree for these machines available?

Konrad

