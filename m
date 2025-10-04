Return-Path: <linux-kernel+bounces-841958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA6BB89E2
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A12A4A3405
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0C22157B;
	Sat,  4 Oct 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SHs/b3Gh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F471DFDAB
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759558700; cv=none; b=jjjHo1wKk8nZpMcDl7GRH9JRR5dpjMPq6I2qJETBDHQo+/UIJoebitr64D3hhuIETs8AQBXmIsADNKK9MwKLfYRflnMPHqvshK4jwoPIcvEdu3htg2ty2XvWU/4q+jXXOTbETf4hcKGDrH4IiI5mMAsn/0Ca3df++8QSArFQO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759558700; c=relaxed/simple;
	bh=31XWcry7gNMJMBFj5xXJAolY8j1SpoyiZ5JC83YhKwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT4M7yyuwaHr3UW95GnJqriJxY2Hjkij7CmojG83rgVJrHLyTMwqHy1SnaRMOiN0Q9HN3oHTki2nJIAUpmdQiOyzoVknQZMFEmnli0RBRDW2iSSnqH+4yxZnJUtLYwJ8traVro39yvDM1PKMek3EcGz58nPseIOkx7H7IAhRLeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SHs/b3Gh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5943PY4b024731
	for <linux-kernel@vger.kernel.org>; Sat, 4 Oct 2025 06:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qBBjEdaHMll6uf1tUYCMqnSa
	V10k6JLabN7CElpyVZY=; b=SHs/b3GhoPVU69KMdKMUFj8FrlJEJxFn1F1FcUw1
	ox6ciOhNcxI0exwOkWebzcYY21bZi9BO9OUIR0lk1rYwfW0u+HkHsq8kPgmRPNcv
	xjXhtS1hh+TNFpjRYtGoEZ5lHFbORk8NmDr+/aexehj9dQNVGlf5N0zy25w3EUNG
	oZxOxftFNniV6jkiLy+aXtipmwkemtcL2nLJM1I6qdKQ47UQza7Gley2Xoa8HP8L
	QOIKnkV53vpdLJDZseA/ae2A3eEszxUpQqrrOdqaoO6R7+Zr2JvPZoCYkzQnWNF2
	TM3JJWkMPQHCEA11sYIlO/VpATbjwaM0XdmKqc8zvVC8Cg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu08jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 06:18:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ddc5a484c9so76247161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759558696; x=1760163496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBBjEdaHMll6uf1tUYCMqnSaV10k6JLabN7CElpyVZY=;
        b=oi2kT5AobW+jRUt0sOFWggfvAcMsYzStdHKJzMXGT691Ef3io01lGoOZbuzA0sDbOv
         jJHq+SzthOKopW5J8C1VzC7kHyIfTivADqdLzOwxA+lQXAPrbXW4JUSkl1zXFYADOu7M
         VI7XyKcRRNA+VXKwfAKjckTjCDZbVuKQHlxsGFuDaE+MVZJlV83WfYnpyuddNf4RzM1z
         4BWWOJaSjbIviDqIno29U9rFfK7s0trsbBarwkIyKW6Nb0hy344JXlJr8h8HoIjJF8kC
         SY8lYgCPe8IDfyfqj39b61fLHbElXO9KGVHROYewqvT9kj+joqVUkEa4WGWaIi6XbTjG
         L/pw==
X-Forwarded-Encrypted: i=1; AJvYcCUOnhu40X/gd9StemTLcGtXIUdGgYNXwvuD+5aWXEB8TmgZJcUBa6VIu8lwmVuP7+URFil9lnwLbxAebEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSR2hJqwkEZhCuM76b32oQXqu0lUUYDGT/ZOuZxUdSmzV94Rk
	io6Di/Fsy3DdV769S9d867M9gRUDL454TbtqAbvowG+FAYiZY++QYX6a0Sp0NmjUSz3llP9XaSn
	TiuOZf+TZrGm+w6TqS7awXvvMO/1EGHWfn4t4D9sFSuukHHIRpw2vPHbh1oIngailIjU=
X-Gm-Gg: ASbGncv7EJnVLClTzUqPIuQijMEYbVBrZ32yW//SR68r7o4jQ8oir59I6wgSyR345ct
	99OMwbaKJWQ5iyC1aenEDidAcbvy/de+NXX+165mLb6UNmMrgp0gxxzHyED329qOJ2nBEeQp2UM
	YmMjZe/Dj3Vo+and31gbFHcm1Xtvu4m3fXzWuNfLKTYIFC0VmK87uQpJDV2xB++R4/H5S6OQKLY
	E1+aXo2dtV/SFuFPmtvOeQjsOwkzwfbv0Ahrkh9XzcquiTdrG5aw2BBLlHPYg4+CYJE8/tIbOC8
	3bHHjy0+6Adv09H1d/fW/b0Z6UWqaui3I6xcVqVCorAwijntuLmwgm0k6haF4pxTCOkfqhQYPfK
	j/eB5yWO+yG6OFOhy4GlkCEvMtTA85sETdizxoqYBOGd7lGHheapXhddyAg==
X-Received: by 2002:a05:622a:58e:b0:4b7:a92d:3d99 with SMTP id d75a77b69052e-4e576a469a0mr74836351cf.1.1759558695968;
        Fri, 03 Oct 2025 23:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRpdIygFcf6KTn5/QEqqXWhnCJScGwKcv5Z0AXlIF9fllAXu6mj2WemBQzEzvWqJKCmZoO4A==
X-Received: by 2002:a05:622a:58e:b0:4b7:a92d:3d99 with SMTP id d75a77b69052e-4e576a469a0mr74836211cf.1.1759558695552;
        Fri, 03 Oct 2025 23:18:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124378sm2558329e87.11.2025.10.03.23.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:18:13 -0700 (PDT)
Date: Sat, 4 Oct 2025 09:18:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcm6490-shift-otter: Use correct
 compatible for audiocc
Message-ID: <iwyoaxo53kz5b7kyz5gxme5ywtn22ho7vsrl7tsvw7uogzjz55@oeekjknm6qew>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
 <20250930-sc7280-dts-misc-v1-4-5a45923ef705@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-sc7280-dts-misc-v1-4-5a45923ef705@fairphone.com>
X-Proofpoint-ORIG-GUID: tvop4LUkpxWt05jSZisjWmpJoY70YOHA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX3Xd7YumIs4rt
 EPYcAIvxo+AiktZLWLiOqn+Z4L8Fh9TPH8ICMba3KAn9Ygc4SKXTlyaRWZXVUcMNZ3eIxi4r+LK
 wCMNLG9+l5PZHyQSF1ZVAxBk1lYjgR7EmVXv1YMlzT5d5dR7QGuihEgOUVBodnFlGJcFVASjk7Z
 bB4H39mrkt8TDvyqdRu2W0jCEH0JMsyPbKT+dqbpteOebM5n68ck+ZUDmhCdW24W95OMRL2Zhmx
 nL1M1wLkffwarw+pIkMVVDsIJm8i3Bcu88xGS39cD+QBxgFNChyIPQ5oyQFnmgGZ3x2D448mnFS
 lb+NpmpaNVsGocG5oULwPBs2ZxI8plSeOX21l2G4tIhdliiZ37+Hg06gJdWCVIhJuJSQ22L/BLy
 xIabfYvyYlRXVH7TtNiWqdY29Q5omQ==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e0bc28 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=ZWl6vx9Q9smWLlo6MzwA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: tvop4LUkpxWt05jSZisjWmpJoY70YOHA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On Tue, Sep 30, 2025 at 03:57:04PM +0200, Luca Weiss wrote:
> Use the correct compatible for this phone with standard Qualcomm
> firmware and remove references to power-domains from a 'reserved' node.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

