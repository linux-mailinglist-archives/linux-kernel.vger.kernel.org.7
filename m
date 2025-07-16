Return-Path: <linux-kernel+bounces-733860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E471B079E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CA43BD7D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558FC26E143;
	Wed, 16 Jul 2025 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkXgvXc0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCB19DFAB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679868; cv=none; b=jsUZ/KBxoGxMNwQ1q4pfkYI2jZxvAIV9sNgMxVR/u+P3lh8q15KXqvQOYYZ1oSA4QDPXlOJDWXX/74D+5blT65wFR6bDkW/mIsPMMebPKCfkt3xzejW9eUi6xTTriL/CKrF/AwLF4XvfULm4fY/sZ0AZ2Tbc5TWOaCe4PZOzbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679868; c=relaxed/simple;
	bh=/lLpKCl2c3s3b6IB1AXI7KNpiEuKvyHjh0OoPcKoN3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8VCMIzGjL4UKCsmvowjWRxtxwxHPqZL0WwwrKkws1YsdOm0cIIi+2oSNtLzBMsFAI4IgiuKPEM8T5E9T2Mprn0F3aQ7vMggOMmr7OEnSQeWJQaOoPQFK0grQKochBo3OkVwE0LKO9tvHCEl/O4Ad0jzQT5c09tchaPsiPK8/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LkXgvXc0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDgcw6026143
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WtJnIzqB+3SesANnG8pILja+
	egjdW8sjzapaUNf64Bw=; b=LkXgvXc0cWraNAW0XpxyqSgIAgFm4bNdFCbjtBuc
	OEHfT9UlCX89bvmSQGI7Do+V86qG/G1aZoSgaYRfK1sqUPafcfklNqAdryVzl5t6
	ZankvEAdlKLtLDg91s6T6BjUhoXSOCi8Yrf3ePbke0KK5zH2ULuvyfFeDPI6YF4J
	tEExAxtByeNqRk20E+g96BfW/TdhU5dXIgupneJTlannFT1xvw7ZKRmiJ3LB/EL2
	ypa4CMrNMCToIl/asi9sjZcx4SMBSbT7pyKv8Fc903ADV6n2UGPIm0tiFtj2+Bpp
	U4tzAkjmzeBk9Uf6GMt+u1xnBPaIjqHwGPTheeEZStkCTQ==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca5qsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:31:05 +0000 (GMT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so53472985ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679864; x=1753284664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtJnIzqB+3SesANnG8pILja+egjdW8sjzapaUNf64Bw=;
        b=oVglJqGaSRgJpFrBveSyxzi7f7LEm7FZeRfOIXP09IgKvPtL4KtHihCIN/KCJVBabs
         AFhI85sWJ+zs0DYPhJqU9aXN6UyCvwpoSwEXT8OwPVNcqSsz+z6XNF9gWMUEgabEZ81G
         MbP/1KGBIlMMHJNe5VuWGpX/7GelRJjSObuxZ07o6zIRfCM7mXjH0JsIAToOYNcWkot6
         VIgJ+oMtu9SP30HOKJDCDYWI2MrwkrDp7FEsb5mgu7kECbNIaCse+RFyj7agVLTLYjxE
         YNeWZMILRcAwFGFshm9I3QkrZ080bbud6hEXCkgqemWFG06GHgoke7t+S+YekEKVxC2H
         WF+A==
X-Forwarded-Encrypted: i=1; AJvYcCWYwd8pisYiYC/OKaPlE93QQtKxvJoBqT2ekjHlwMaPooyn6kBn/p1nPRvYh9apLNJy0LibiqIwOxHiQgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWf9EkHvLxA8TwkkCcZKV/hjVTZPlsac1Baz0vr1GDJWgoUwtT
	imcXh43UMR8dQC5u9BvsWeYgpPcVfx21PnYgSurgnHTq7+7FznHvfA7je05rYCduqqTJg17HjPz
	UewOl9yBayF7gD4UifsoU6N5HK7pS6PMwuvUk/2idreEtRjzsuLCMXe/WV1j4SWasxbY=
X-Gm-Gg: ASbGncuiW7FcQla9mVHJD2vEywLmcdgRkrBv7+T2/gwO89+7AEp21oJQdhWcdquTDrL
	TNscH5QmRhlRbZ3lrsj1f76uMkpGHKfssUw5nxFLrQXvjDgEjZfj8sy1tuC+cpg3L907lZcbYlV
	8RMeuAvyH5pBaNEOSUvVwkpqIfz2+O+4ERv8TWeJycwPB/ytap1UlMqnvyoflxO1eG6o5vDHFNf
	MJQj0xkz0y6ZtYQ11kveP5fhdvEEhajcuzZun72eLpEKAW01LJIRyTB0z4Cq51Qt6ltZCSJf+k4
	unG82ek4CgbZWqCEhZQvRLMC/FBSAUQr3KmJ2zwBWTyEEcckXw1Bhy6UzVAULlGhzkvtBZkO7pi
	M738TuVdaUhnT9bB6kNG66Z+xzPpHfom5mRcSMno14aT65CxxS6Vf
X-Received: by 2002:a05:6e02:4701:b0:3e1:5f8c:10e6 with SMTP id e9e14a558f8ab-3e2824455b8mr27612235ab.13.1752679864482;
        Wed, 16 Jul 2025 08:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUoHT+PB8kn2rb6kYrtzuZSZX2s+9VLncmPQvqc9jUsjfQu+TJIFGcQodWcjaEgjwNacwprQ==
X-Received: by 2002:a05:6e02:4701:b0:3e1:5f8c:10e6 with SMTP id e9e14a558f8ab-3e2824455b8mr27611855ab.13.1752679863975;
        Wed, 16 Jul 2025 08:31:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bcd76sm2667601e87.35.2025.07.16.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:31:02 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:31:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] misc: fastrpc: Remove kernel-side domain checks
 from capability ioctl
Message-ID: <b7xjjlrn2clktozk5uwipt7tdv7clwipmq4wono25ts2csrsil@wcsl3wfippcz>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-4-quic_lxu5@quicinc.com>
 <aepmtv6mxlzhpncwcwlmgfrb3m2c4xe2edl4y5qsnjpxmvivla@gwufrh37y473>
 <9075ba23-cf47-411a-a6a2-96f89114b14f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9075ba23-cf47-411a-a6a2-96f89114b14f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE0MCBTYWx0ZWRfX3e6Utzxo8GzT
 nbT41XAakE0dtXzn8mVY8uhqSTiGLXrE0DvEK4A7PQYoRjCtViKSNPXTVggHvfyoMBwpmkbrxVS
 IA2Kar2bQz9LckxlchRGwN8YzhJ5pfLGbgp1E0zzpmBmyC2mdKvsnpf+iYvzz3vmLk8fE91jsv9
 5K1lKe9M8Wv9kgV07SBecUYYerSj9TOetl/e7L9Jgm28CR6V+n3uTrHDoHQ8yngMWqRJIPX4Csb
 0bb5HSPYWIiwe3T6rrleDiFE32pOnnmyrX8AfQ0Xr1RrfwBMRAxR3NUWqXMJygwCPXc6reaU7+u
 3a1qDoSKUFSpWZaRSKRf5Iz/T3gGM10CTVdDcdbQndFKASd7JzmSJrQQSbd3nYEM6XgdkXJ5vQc
 O28P0YMu7dM8lJAyo4NENzAJj178sU2AxY0VPYRMpyGjCwB8VP/q+o7qllPgVYzBn+adjtPB
X-Proofpoint-GUID: qKS0FZRY9KAippo4nLneSMhheARO_MYd
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6877c5b9 cx=c_pps
 a=knIvlqb+BQeIC/0qDTJ88A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=SawCyeuA4rNlEbsMlaYA:9
 a=CjuIK1q_8ugA:10 a=8vIIu0IPYQVSORyX1RVL:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qKS0FZRY9KAippo4nLneSMhheARO_MYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=729 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160140

On Wed, Jul 16, 2025 at 05:21:20PM +0200, Konrad Dybcio wrote:
> On 7/16/25 5:00 PM, Dmitry Baryshkov wrote:
> > On Wed, Jul 16, 2025 at 06:58:34PM +0530, Ling Xu wrote:
> >> Domain ID in the uAPI is misleading. Remove checks and log messages
> >> related to 'domain' field in capability structure. Update UAPI to
> >> mark the field as unused.
> >>
> >> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> >> ---
> >>  drivers/misc/fastrpc.c      | 14 +-------------
> >>  include/uapi/misc/fastrpc.h |  2 +-
> >>  2 files changed, 2 insertions(+), 14 deletions(-)
> >>
> > 
> 
> Dmitry, your message is missing

Thanks!


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

