Return-Path: <linux-kernel+bounces-758631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7DAB1D1DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F55C1889031
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731881F63C1;
	Thu,  7 Aug 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqrs9qkh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1C1DF73A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754543401; cv=none; b=qPvihvSheVdLIQDwXbK1zHmPMKIdpR3utVUYwjfN7Gsdv5mw0dVtrHDRdb5RZUYcL1V2Kz2JtgeI/nuOD9UCGc12L15UI/jkux5UntjAOOjk914qhmgcOV/JvB7hitGCpDY0rxkKicI8IkWcOC7hYRXsDo//5vDfcJlESwNm6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754543401; c=relaxed/simple;
	bh=Tlr/AsUjBkz+xny+/rpFl7o+Ey8YWX6po2IM+lvkxEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBcTVs34CK4Y0JV9GRRVx9bcq8LwBsUR7TNwcIs6cUfvnNCgXXpEN95cZA8Hi2dOTb3uiadEQGbEydlpuNEQ4NBqMWBB86stz4W5twNMdKllec4KbMKj7ZVQ5TtzNWDfyiw9Watxkbz8iUzOlfZjEFcGsu7Yf6bQEgnBTDeOv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqrs9qkh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57724cuk019692
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 05:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bmXjPpDHd0Cgpzu9CL46gO7J
	+euneT5LSuqRLfgfzJA=; b=aqrs9qkhORFhgqiUNUP0pYhKt1VB6oMXbtys+wIJ
	lllsaCtVARHRehkk2xlv/zI5+koVePpz1iNe+b2INzZibBh7Yi7rE/W7pjymGhR7
	olOL9jaES0sYiNoNsYhRTjye27XU/mHsU5fhF7dRyn0dkcHHIhRCoJrUaPVv7qb/
	tBhJGP+3QysAA9t6Kf1KVZdqSLrMWD+pb/tsoIbJdXvKYlEBGlIP7iGNNxnLE1UA
	pIqUSY5LiyjCS8JsZSwEqXI9TEezGgVPisDefxobZ0i3s846grVh7fBJ5dJhaGCW
	P7MKmhrcytNa2AbShQ8+93IFOZJRLiCohcH8Pl5/C9esvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy6w22s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:09:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so1124688a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 22:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754543399; x=1755148199;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmXjPpDHd0Cgpzu9CL46gO7J+euneT5LSuqRLfgfzJA=;
        b=fkHBa4bASAK1/D/JLuIKNm12XEiL12tamWsj/cXXW0RtqE3j97iDtcNaLt4CS9AV0V
         uVS8ZPUFXpIaF7WxNlUtjfPaAYEE454+toSjyeEzodwVCIgTL6BmwpzC+vJxepS354DI
         Y0etrlJ7mAdMTl1eQ9KGQED004cptABqK6OJ9F6MXWZzmsHzbeoAvH/5pJMxrARMWadk
         SrCB0YZGfC/aAh1UIV3i1PTHjhys89pLsSpy4zsjghVg4ECOzew+Fb83w77iPEtfAxr3
         q/ZlRKWdfNBoVCrdkUO7kQfJxb0W/DbcU577mUgHkIR3kFzbmP4jgq/7CA/tnF8o9nRg
         DaXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRlt3FeyGLJF/haEuqhPefqXGwoZ0kjx4v+mVOSlK5ws4NdaNGcgxIiGynEWMuIiRsh8me8FdiLMRBmUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ai9IYaeuiRv/J+3m/4m7mVcV3MF05lV3CetBGgPVAeMCC8lO
	JReXIc+JbWTN23nU9r0QgR34uAjtcs3ST0UKCzDuVsB+bfDUw6hzQQFgY/DjiH9E0Lfxig3zasS
	Sa08qZLES/1n0Elu7TQjEQxX6EXIJuFSwfJpsYmI+9/TJETSO8f9WmqZ1SFZg49RE4po=
X-Gm-Gg: ASbGnctxOQozaMdzaPxIYZdlwp+QhBi4eQ5Aw5s7NYSWvhBoA3Hbxslc3qcT0nPQXEK
	k/TIZVP1KIGAFMK1yEaE1fc+vOf4D4Mwc5Zz9+zstoQSMKp6xXIa+6VV3pNrdumnhoCjHTvcZ+Y
	H/5V1vNzJHAXviuoa3ZCIeZQzqLPvr5XzE/EHA1xr5PRjHhupd+WxgW46aJUDR1x1aX+mSN40te
	NtmYIWp7o/mRZBqENjYJL+lrdicz3QOxBc2ZV8lSOcfVpQaFjdcDDjEkYie9uRhLD4Tj/I/aby2
	3eWLfk3xago4z/6pGG/EpuQfJhrCFaxbuYxCJGiB6qr8kLMdzPVZ62lZXLCi00PeviU=
X-Received: by 2002:a17:90b:5101:b0:31f:3c3:947c with SMTP id 98e67ed59e1d1-32166c2af67mr7690682a91.10.1754543398719;
        Wed, 06 Aug 2025 22:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47kar2q36LtbPQN4NmJWmgREGO2dRSmwYDlKD0mRi6OR7+kX7FHIYLR3UKacYjpT+SbKlfg==
X-Received: by 2002:a17:90b:5101:b0:31f:3c3:947c with SMTP id 98e67ed59e1d1-32166c2af67mr7690645a91.10.1754543398204;
        Wed, 06 Aug 2025 22:09:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b77f33asm14674650a12.5.2025.08.06.22.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:09:57 -0700 (PDT)
Date: Thu, 7 Aug 2025 10:39:50 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: qcom: mdt_loader: Fix check
 mdt_header_valid()
Message-ID: <20250807050950.n76f4vtndgjnujbo@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20250806172531.1865088-1-mukesh.ojha@oss.qualcomm.com>
 <wgpgwf2yq4awig5cztgkgm32h6zjtqzv4irpxd277gwjydofzu@f3zb6t4iyahc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wgpgwf2yq4awig5cztgkgm32h6zjtqzv4irpxd277gwjydofzu@f3zb6t4iyahc>
X-Proofpoint-ORIG-GUID: 1ggEJx6gwKs-P2orH0rY5lBAnGW9PmJi
X-Proofpoint-GUID: 1ggEJx6gwKs-P2orH0rY5lBAnGW9PmJi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXxc3g3+fxffyl
 m2Ddi8xkw8rLiS31/r0q8txUPxg8kiXMAMIP0wBnwqM4mnZYa5r13Sz8MaPEGj2krAO7sfdAXEE
 dnAKHfTgwogIQ9cFbRGTdzOnLECl6/AC0iozeCqQCZ20R+MM8Y/ssSZzycOLySXFOguM1vUoL1s
 JPtJF0DnmMqtvmsHRt5OtsWVhIEM+pD/rZ4XpszIkeLAk2WYXvmRcXSvUFl5VwhHRQA4GBstB3U
 1ZDOIbDDaaVbdw240vefWBxmy1zhwAqHKwTEidxVsMQ3qI0h7ZMNMoCNYRsczmCY+rzvrjXnj3A
 hL1at1/7/Fn+BwH39VHnBtrNlS7SACq1ZAIWUAhY8/wUDV37RUZXSHKGHURhIQJth131XxfxQb/
 ej8UQF7T
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=68943527 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=OaSFCp3QGDZU0s8We4QA:9
 a=CjuIK1q_8ugA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 03:01:45PM -0700, Bjorn Andersson wrote:
> On Wed, Aug 06, 2025 at 10:55:28PM +0530, Mukesh Ojha wrote:
> > Firmware binaries may lack section headers, in which case
> > the e_shentsize field in the ELF header can be zero.
> > 
> > Update mdt_header_valid() to correctly handle this scenario
> > by adjusting the validation logic accordingly.
> > 
> 
> As I replied earlier today on v1 (probably after you sent this), I've
> applied the patch I sent out earlier for this problem.

Sure, thank you.

-Mukesh

