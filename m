Return-Path: <linux-kernel+bounces-891651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A499EC43292
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30EDB4E73F3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA225B69F;
	Sat,  8 Nov 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g68LzhRt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iUoUnMU7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04E195FE8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624091; cv=none; b=hDlgOe0zNAInI0BnOblT8LTCBhLNnWVXuR1AY4Aj3BsKM6lrxB1/Is5rFcEzf41OnafkKMcxYSduq6D3hnsqoAyKrUFAIBkHepry5mh0Yf+7Mkb7hdpb4ifYUeLVzuWZMkPOpT2SS/sYsezz+W0mGDivUxnm61YmdYB530hjtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624091; c=relaxed/simple;
	bh=8AtMYJ5TBcJV6ZqE2nZp4MZjEGY6MVYzWwV8mtEFQqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9FnX2RubwzcI4JvgNd+x3m5QPLy9Qtvw3Pze9wKF4hGXtdCRGisEIAy3sYaTtw4gOa5yAFjMayGaOqsfLGaenUYOvmF60T9JYzzdK4j8xOVHoz9iUiETecJGbVQzEyCF/9goAGVnWAXl707+kzfJjChSU6+H9+dRX2Uvq+JnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g68LzhRt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iUoUnMU7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A88PoIv1247209
	for <linux-kernel@vger.kernel.org>; Sat, 8 Nov 2025 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oKNhA/wnZK5tHj2oJkGCMVi7
	EZ71nQgfta75KSMGCxQ=; b=g68LzhRtyWGyfImi5Zkj3mqRSw6GB6co+LrfxJMX
	X91jKT7rJJFJG6d0QvJ5GZ/K7ZEVahc3F7JGqEYQWTQcAZn26XjZ6xVGUoExfQUy
	oRCpQG5yqHtaxeYNIfz1T0mQf+J0Ofrs1gyXnXfgSyQorVpBmoT79cguC/3RNysI
	z4HNru0DlCJbdM5fFbwq7TNgUKAIn21nN0WBbEGOA+Q2FnqYdHr5qcPCUrMR2BYA
	mEkGUC4bp0FTP9ZsB1ECV2NAILg7/6d+Gtuqartl4j8WlH8Vbdf13L00Ip4AHgE1
	ydtj1nqLDPamLFdz6zTkUhudYJfrjwpF1yBQbzOGwPFUuw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y56rwrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 17:48:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed74ab4172so52964321cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762624089; x=1763228889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKNhA/wnZK5tHj2oJkGCMVi7EZ71nQgfta75KSMGCxQ=;
        b=iUoUnMU75uBHKmEbeBYL+Ay+SE/pybWnoILFvRZDwlVx+c/XhdpGtRKjYEs58zDFUv
         pjJuTRsN8M0lhQJGQ3QWg+THQiyao+ClY2oEfwyJSzZDZLWjlj5CfFHsOn/JiXlQFVPS
         OMdHZ1qMPJteylqT/gPPyn+KuKSPHqHjpU5XAy6448L/MuymWvNe7anOuNlljX7xkiLZ
         Fq9B0imwpdL2RK9UeqbYurGBXi5W3uEOZ+LqHkajgthp/lITTn3euWGkj+iX45YVR7fM
         nWxYLI6mLu6zDtVISX9b57Eo3ZYOgc9qhMpJeT5UpEHglepJUEim0RzkQatyqeAC0x8J
         5zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624089; x=1763228889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKNhA/wnZK5tHj2oJkGCMVi7EZ71nQgfta75KSMGCxQ=;
        b=SovRCbN9sHUWhfGKX5YKXSobwlMRCM98vrb01oypnB0+OEUSbPeVsBscGAqnwr0el7
         yDFMGXORnfmkO28SCRSJa1UmQZ72Atr1tl0nJbiOt17lqni60Y+gj8S5QZAbmWnGLN9B
         EwTTE3D76Z4nK7a7z0G0OqmJvvrJnUZ4oxDpMleDPwcpzL+Cd6JftRhz6429ofjJaLYj
         5Hnm3koblwQIsnRDm+3RtqHGzLQ+P+hnf4qZcYslF6cYVVWoEZdo8Nda/lf12/Q5fIoc
         TH3G4yPd473GQ5PvO1ebqnSjL0okG2oKhJmLKm1qEYwWmk+8Rr1XkF+MM/dyAwxOdBqu
         XeGg==
X-Forwarded-Encrypted: i=1; AJvYcCXtVSrXTtDblXUPgWFn7p91sbrBX7Zio888HbchLeZw82BLI1GGcxR9XsUEUuFW4dKEUU/HhvJ0NuPJ1UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuoo6cpIcrNbP716NOPJnlpW1Fw3Aeg4eMhFhoT//vgxRdlCV0
	M2daORM+nYTLmvjzBJ3cAs5CWwRYxdD2cym7tUEiWboos567+ZsAG8PnWIfN3waSSE4SOqIPKBJ
	rZ9EUDDqokBVK0dMsDiA+plW+SuPvOg7Wa8Pr/yuvHtGG2klRBSnQneRHL+Dht4MwhkM=
X-Gm-Gg: ASbGncs/h2Xza7T258N44CRAwXxrvMPVe8hSgsKlvXoIcVO+98rj/tUJzL+nC8G8xLm
	PYgneY5Sunbn7kXfWaq5UByZgF+FNiqlhfnKq6XqRnqlKoYNG+tiwd+wEUz438Ig0fVByMibz7E
	hUhfJPhj6EIOEm0l7FYTkyjdm+tRyuGI24s3aPKM8WTITtkjW1qhUfMWt30d4mI3RtyFInZx8Vd
	p3rsKNje1TMJaTSJSqceHbMXlZtC5bsBoQptpED4EXIZehzgJZBxqqdlodmTPwpQLRv+4CGynS4
	u0Tyh0BzeLIAy+0Pg84Gj7WIMTpUJzp7wVsqMYE/2TtBDUu69t43S6bkMKIWSkkLp68561DT6X/
	hDJYr4MWCS2H75e0I4y4wOXE7BejMJULOC0QC47qWlXFV4AcrZ76kOFf3cY7ufBryPt/ml+YQ+5
	Aa2FteIkhx7Piy
X-Received: by 2002:a05:622a:130a:b0:4eb:9f37:9df0 with SMTP id d75a77b69052e-4eda4f09bebmr39398571cf.35.1762624088803;
        Sat, 08 Nov 2025 09:48:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIsSrvfAIAazMR3+R4mtJZyAwKCCj0ixIasuIj+5F2b3mDr+MWrB7+JvGQoEoO6wGCxfnb4Q==
X-Received: by 2002:a05:622a:130a:b0:4eb:9f37:9df0 with SMTP id d75a77b69052e-4eda4f09bebmr39398301cf.35.1762624088398;
        Sat, 08 Nov 2025 09:48:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019cc5sm2334971e87.27.2025.11.08.09.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:48:07 -0800 (PST)
Date: Sat, 8 Nov 2025 19:48:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] interconnect: qcom: sm6350: enable QoS configuration
Message-ID: <7anacd4dajb56nsr25mjjd72deiezzzqxewhrrayo7btl5nf3i@43pqifo2pwd3>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-4-8275e5fc3f61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-sm6350-icc-qos-v1-4-8275e5fc3f61@fairphone.com>
X-Proofpoint-GUID: ORLkCOeVF_-kjrl_DAc58JvHhtc6YGy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NCBTYWx0ZWRfX7vLaA9M57Asy
 26oCj1PWHCuTptcWdsxNYOOS7lxF6v4M1THHtNgiBGuSM/Ca/BJh23EiZWgCklWy6Ey0LlYfVfa
 mjsaGlRH67llxB5D8yBYFtHuRDHTKYNOCPDHYMu/5QB8q68nzI9ECzG5058xkcYGncO5xW6dfY/
 Vj/ey5qE/lUF+EpEfx1TF0SEEvDRfeRR0LSYUckixhPKP74o2VdAlZtnfRAeS5if5ekyyXuzQvK
 YkjkU4Lds4vcxKC6WUqLlq0BwpF6OVLoiIF/OA1GOwfKbmCRasxdFCM8FIPbD6+v5xWH76s3Uxr
 8h3vYXSHnZ8BMSysEJ012vOiE737zD6sSE2tA5pzqfVi8el4Zj2VPMRGVt36V0rrXhTgw+Qfhlp
 xliAnLJURwk4Dldj+GvUD8UJ5mXDbA==
X-Authority-Analysis: v=2.4 cv=V8xwEOni c=1 sm=1 tr=0 ts=690f8259 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=nyvGelbgox2M8jkpOYMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: ORLkCOeVF_-kjrl_DAc58JvHhtc6YGy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080144

On Fri, Nov 07, 2025 at 05:08:50PM +0100, Luca Weiss wrote:
> Enable QoS configuration for master ports with predefined values for
> priority and urgency forwarding.
> 
> While this does require some "clocks" to be specified in devicetree to
> work correctly, thanks to ".qos_requires_clocks = true," this is
> backwards compatible with old DT as QoS programming will be skipped for
> aggre1_noc and aggre2_noc when clocks are not provided.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/interconnect/qcom/sm6350.c | 288 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 288 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

