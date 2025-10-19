Return-Path: <linux-kernel+bounces-859786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A627BEE922
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C57DD4E8C74
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333A92EC088;
	Sun, 19 Oct 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="feI+pIQ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946A2EBBB9
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889617; cv=none; b=GGsjmu99PFv3AGRPXGodmtsmsxdzMLT15G7e6gYteostqP41Buiuj6Hor6VS7lZGkpGS4FhB6pJ4Xjt7GBR5j6r1Q9eLnsisLpXKGtdVZ9n1xNUBXPWfpnloKhj3vnpadI+E1ofagF7U8m/ZI4qwbr2I5GytgAvctGyQARfu62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889617; c=relaxed/simple;
	bh=xzkqNwARdbLPvZgk1OAgS7gX8Y2Q8ThSI+Q8n9mJvko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql39RC6iTB24z+61/IqVUfZzaF/ujw+Numw48cailS3fcWNeo05rkQwYM4Cfz+7QCIMcZ/ENBW04XESfNC9ksOizChTQ/SI34oGiLpLSzfTghl2b5jd978wkoAH+J6O5oVdDv6Xd1Hm+nzpUkTYJTxIGsmcxNKWk6muy8KzlJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=feI+pIQ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JFtEiC031209
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pAnCrH43ey70zMSRTiR6RqBTO1JA+aVfzw+gy4a88is=; b=feI+pIQ3/fGt1CMW
	xD2FBpeiwuud94vB6kvK3eapY/ygA5ChHpQGrj2eUE9ybAlkpT/N3aXXNm8Vtjfh
	5EMztP3cxfAyqI5mL/IMxJPr0BmfBX/CvEd68Fuq14i+W4jMsoIykAK9fxbJYASz
	ZYCThos0pyHwgHsxOIblxv+g/GozptCjh5sv9U6Q69LPl+zK7N4tuqNY6HMqxPdj
	qGn7bnq1glwaA2uZ5rC8qLAhk6hA3rZYYK9SAjplX0vHN+KdzJDGakLC4Mh3HFHg
	OG3hp6mW1AZr0kNkalPZR7U48ZKdKcXd8s+kq8mtI+GEBPoWVkOXP6nC9PeLSe9U
	9hIfow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w07ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:00:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88fec61f826so1122571885a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760889614; x=1761494414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAnCrH43ey70zMSRTiR6RqBTO1JA+aVfzw+gy4a88is=;
        b=UXxk052z5GcVU7CIaC1psZ7LHOtucmLrGHf6axlOAbYSDFtqpzThHHjRRcKvMwigvA
         La94WX3TMy5iMn0WIQPr+2MCxiFIzreiRfxedum3tEAgw00Jn5JectWVi5eLooxxRM78
         8lDgMMcIzEc0QLFt5ZW10LbgemvyMcqm4MLYtcg1AsQSM4FuX05hfl2nqmxoOg2v27wj
         9re2cV7hFBYdCVHJbLP6Stp74y3+FndHN9xosAAGhwxamc7e2/OphdBOzXCtmdR6jaeO
         dW5EQFXl2CURhDwIlNX5rQrWU+9TPFCegtsx1gD0K6s3fuuoBfeYUYkS5yvbGXce4TjK
         ZLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvesy/6Zb/zbspL1BK73C7W0yOJ34cnhEe9Jd/nqLIFTBdOzFnB8jYOrrEqQaFbJRLZi+L4981gpyFZKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1ikFtoz99dQJTyQlEP1qm4xBydiYvwaQiSJ50vX5JDJTdnsw
	BoWhCK+7tXy1Qw0heJmJnP+m9x0mt//L8Ux3G6/mUJxLzzCPTEvnBU5nZ3YxZmYv3lfvHowT5np
	8ouc3cunSIdC2YhkXlUAw7uCLH34Jgd43a3tz2y7dx/j/iQ59hqQvRFh6HulMOG7naWw=
X-Gm-Gg: ASbGncv8geVGYaqIuxTmwg6hm6r19I7qU/A16luiI/yXznOVNkhMcCrK3TKT20o7M6n
	TmbA/LwS8dsZq02pyzVRbf0TR7CeFOM6Z/Wj90VDmRUPqQxKGdhIuceaptlqSrfON8w+bPSqGao
	a0AZ4aSHOAYQa2PWPR5X1Ho61vrQkUgXO2FWHOvCICYGaYZ/EaHy1a9bqch6do8ZIJAazRUF5eS
	CzKsSmyn3Q7XCfdtZukUAfEKdBDM6hrn2s+CVQ9+tYa54PnYyAqXBX3dWs0O6iRLjYQsKP3GNml
	f5Co0zsaz9/VlsOUqO4Gpvj1o7sFD3EmEWXQPtAXhnXXs2PvD8KY+jBMril322YL3WJNTZ1zio/
	4habHgIxQNyYbureq8+tcm9e0gGjO2njZuxVIAguMRm21f4pyOGPudp5aDw39+QiopGvh/ggNg7
	8cGov2QyBCZk8=
X-Received: by 2002:a05:622a:28b:b0:4e8:a54d:cce0 with SMTP id d75a77b69052e-4e8a54dcd87mr102910181cf.53.1760889613607;
        Sun, 19 Oct 2025 09:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCrJXyG7fI27LwTBfN2BGJKRA1ASFutxhuVWs+afd3DWD5EMMDTDstaSi4ip0vg9wyDkDPdw==
X-Received: by 2002:a05:622a:28b:b0:4e8:a54d:cce0 with SMTP id d75a77b69052e-4e8a54dcd87mr102909491cf.53.1760889613076;
        Sun, 19 Oct 2025 09:00:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def16b3csm1658498e87.72.2025.10.19.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 09:00:12 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:00:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nickolay Goppen <setotau@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
Subject: Re: [PATCH v2 3/3] remoteproc: qcom: pas: Add support for SDM660 CDSP
Message-ID: <nv2lsvuzrgoepr376gghk2klm7jqtmpcg6auairl6zzm2hks5s@z5kohfm6orn6>
References: <20251019-qcom-sdm660-cdsp-v2-0-0d3bcb468de0@mainlining.org>
 <20251019-qcom-sdm660-cdsp-v2-3-0d3bcb468de0@mainlining.org>
 <sasjgm6pua77syu5qjbr5zxl37jorvhs4dx75lbiqlisr5aq4h@zjxu4k2wcfye>
 <596771dc-1564-4f46-ac07-ac0e9c6c80ab@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <596771dc-1564-4f46-ac07-ac0e9c6c80ab@mainlining.org>
X-Proofpoint-ORIG-GUID: K_1BmigewfbDB1znYcfR8d8i2CQGkkW9
X-Proofpoint-GUID: K_1BmigewfbDB1znYcfR8d8i2CQGkkW9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX5n4dulYo74rt
 ywOL5CL6T0Di8ikNOW2a1DJfLYn2eNBS4oYlC/OY1WWAq2A+vimIHyU6V3GkbDP9KVbSkQX9WHV
 Eg3Ap7YNamJ8mM06VYbMcu4mLXGFVXuQzq/QDm2LmvWDDeBdy8htPp8PiwnLgOjtJ2K5sQC64tw
 zjhZip8HFfz1n2u5sBZzMFzHrB3JaB7ZqOfGK6AwLD3uGJTuhBVR/JQKdp2CvZbRnbikX34h7ae
 gC+7y+Qq8e0yRDo4mNwETHtMfmuG1DwWKGfG2dyHKC7Tj9Y3+k5zeD0HXVwQZHdzN+XQzIylom5
 3WHqwSvYwUBhnkHRRcpjQVJon1nVkX02v62TQ4j0kJeYMpCAm0ngEHdAN6MZ0vZVm678zf/W2mf
 7nfdh7tetmVn7qnVCxIZPnUF1GGTpA==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f50b0f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8
 a=JmBaj7UERdyy7ZS9UVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On Sun, Oct 19, 2025 at 06:38:01PM +0300, Nickolay Goppen wrote:
> 
> 19.10.2025 18:37, Dmitry Baryshkov пишет:
> > On Sun, Oct 19, 2025 at 05:20:21PM +0300, Nickolay Goppen wrote:
> > > Compute DSP in SDM660 is compatible with generic cdsp_resource_init
> > > descriptor.
> > > 
> > > Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
> > > ---
> > >   drivers/remoteproc/qcom_q6v5_pas.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # ifc6560
> > 
> > Please send DT patches too.
> I can send them separately

Yes, please

-- 
With best wishes
Dmitry

