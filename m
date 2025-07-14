Return-Path: <linux-kernel+bounces-729989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C579CB03EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC416941E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF68248176;
	Mon, 14 Jul 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROHfuF0L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124C1E5018
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496343; cv=none; b=hF9iErAX4xHSuPdsI1DZwzKRYm9NElfKMr9kZSOyWR/zNBRaZ4p/jchwzJjk30zjU0vin6zP6dEpdTaqE1PY8FeSEtc9trweZd2zkQV+k+xFNRU8SQ19MgKyNJF5vh2QyuqyGO6zj8w/VEFQsaUeBicsX5lkp/SBiCXceIHdWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496343; c=relaxed/simple;
	bh=flFLNAWDk2urtyAkbTkLSFABCC4IEkAZoRUS6V2MQF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abSDUg6edujWP7avq84KaKTT+k0JhYipTR3iNgfS4xbaad7y5ybpHjCRnAagP95BWNRi19QIjwQdfRP6zRC4VEdVrQ3Hb5MikIP0tbaBGL7XfEberYj/PLwK/iFMMgYrfMgvaehV2aF0KZ5tPWAapjj+nTpshQZeC0N5Ej6rXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROHfuF0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9whu7023898
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7q2lysz52slfDvlR51XkXLPg
	9u1Mj3w8tjVs3VUtBXw=; b=ROHfuF0L2sw8STjmfZBWWQ047vDeEh3kZEyfIFJg
	JRluHY0SK41fUp23rFr6f8PrZ0MdFCyPVTSHaApr9ERSUQund++5gYloO8SVbOGI
	9dbAbWfwoVqhPJdJX6akFeMMir2dRIHIBVThzBR4yMgCLRJvkTOb4v6WGOXO/wcP
	7oEdMLlXwVqx2znScwvLXrULZPzIHF0Ka0qDjulLIMPyqOZA9q6ts2pfFWOzUIKD
	RQERtPerbQh2bA/Nu4ZMaQ+QpY+qTm8EzXrTK8p5Z7IMjUqiFoN6Ocryqf3Wm2vy
	HYQ671/j9a9ZLhzrUXmaZcaSVHiqeyNFkXgGeKrwl3Nm2g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu84kxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:32:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c7c30d8986so1255713685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496339; x=1753101139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q2lysz52slfDvlR51XkXLPg9u1Mj3w8tjVs3VUtBXw=;
        b=XOiZm5+w6FolMFq9QsZ7BHhe4yeVMzMyW7kMo9PML1EL5YFwp2nB2O2Ge9n/Eip8pU
         kPYmq43x3dSkwZBf3s91bGr8QY6/OXYTyGKowW5Qtd3/oxBDgQ1ZbK5OZadLARYd78p8
         sRQsBlTf3uAy89lQxAtzBjLdxCa9lrxznWsK9x75drKBloaVvrPEBNLvQ2hIF+soOXgf
         +xLoD0gNQ/aRCC4/CyYXJWfJFzhWG/2MifmOvmnsQvZZjwXA8tS/SqrXem9aloh6aR2K
         yUknHk8heXNsKYN4GOMO620FyOfuBWD8nmc1D+EP9gy0sPiAREVRi/EccfN1MEqRRlJZ
         tg0A==
X-Forwarded-Encrypted: i=1; AJvYcCU7Rg+yJKiPmfWFSrinI65yM1I5ub5tlHCuIkxuZ+dxR4Lft4DoArHqIfbA1K67PCD5AKSA3+n6IBqkSjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlxBv+8AiwTBrO0uRb7ttN4YTAw/dv3tpjrEdHNIbIDyuYWJPK
	jrry9FAPq3LYk4hS6+2Vpms8hT34pVJDlnBhqr/ykmTYsTClG7S5bPRAKQ0HWGkqxYbwQlUK2oG
	NQQnJD5apgzQ4qAkPhxhmpLaOYnJY5lqgkWCbxWfQUv3d7TutzWT+neJaTyCDNGi3EjQ=
X-Gm-Gg: ASbGncu5MzM7qKogJvWjK8GG93Rtj5O/f6Sg2aj73PfNgySIekiI5RONwFaLTu1PDc0
	yn+7rXeQ67eeSXxsgRidD5G8E0P+Tf8uoThgs7mfK1bC/XYnv/s/ekM5uQT9KI2mu8iQxpvquPO
	/sCp2R9TJuXcHLZLQpFVTaAwSP4jJSJ7WmIpFGXVVu1v+NW0xrjiDG0LBw5Yw5qAJYwBUjva9gh
	yyoB0EYRNx6IZHYX5MGt0XOooLC1AaP3HDvBDiVMfZY6o5FbyvVUwHeQ26hxyomG7F6XF3TJDbi
	quQ9aPvvoFCafDR/5f5XSQCtxsj/rxk8eHP5qhTs1gKODHH6L6mSe9MXeLltHAQtOLiAgHJJYlT
	stfwYlEB30Iue1UwbOHaYJnoCyCLM4hCMlc9E/tSVtHfRxYuVxr0s
X-Received: by 2002:a05:620a:414f:b0:7e3:2f19:deb1 with SMTP id af79cd13be357-7e32f19e3c9mr222596685a.33.1752496338631;
        Mon, 14 Jul 2025 05:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJHWSGVbWAfapT1Efo8CREUZ3rbnR+lvZ30NNYQVSM3Nje58DWmrPudsFI7Ni6msJCAqNm6w==
X-Received: by 2002:a05:620a:414f:b0:7e3:2f19:deb1 with SMTP id af79cd13be357-7e32f19e3c9mr222590185a.33.1752496338111;
        Mon, 14 Jul 2025 05:32:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab916bebsm15512601fa.105.2025.07.14.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:32:17 -0700 (PDT)
Date: Mon, 14 Jul 2025 15:32:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH v2 01/11] clk: qcom: common: Add support to register rcg
 dfs in qcom_cc_really_probe
Message-ID: <ovquneide5g4tpaqr5ptw7b3yr77u4hgzei6z6u7tieysbi62p@6vjbgzhjxd6u>
References: <20250704-sm7635-clocks-v2-0-9e47a7c0d47f@fairphone.com>
 <20250704-sm7635-clocks-v2-1-9e47a7c0d47f@fairphone.com>
 <64e27035-d124-470a-bc5b-66d254b6ff4f@quicinc.com>
 <DB7I1Q9TD02L.2A18QMRU7VXHD@fairphone.com>
 <b60d3297-8267-460f-9c4c-1519c511ac36@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60d3297-8267-460f-9c4c-1519c511ac36@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MyBTYWx0ZWRfXwIGTTQm4Gox3
 IdmhM3ergXQ1TnXZl+03wg9C3wKbE0rexvCtlEw5wn8cBlq+8QIASTM9O/BlLKOV1Divrjik7f/
 MV9+f6JYgb/VrWrONa9m+IlQ3hObrk9vMNxjk9N1R0NTi1X+NS9cOORXkBDhh8ZrS5VB6mF4XGg
 eEx7RaMQ6eH4JbkXKjIn2Y6k+Ui3mnX2M6DCB+geXqs1egCPTKQR/wYySOPMl1IeWHUYMzvl9HB
 QY6s30jmqosUX7fX34DrJmQzHtYQCkAsNkAUh+xr7m84kypKBW3pY/SCONqOUtd2uS2yQjztHs+
 7XEMc/tKk88dsr3/dlOheBSdEenoAqBhNGbBKX/AAHv4pEWU2xzinkqK486YINX/ymXlwfx0Up1
 bdUiop3Ubv++aMmuq1ymJEh3LG04vFo6lEd4fP5wtaLK+xvGDLXt4QNtJrafwadpH8XTGqqc
X-Proofpoint-ORIG-GUID: ZMTwDN4JuSAlREH-uEOTu6VPgVnwIVOF
X-Proofpoint-GUID: ZMTwDN4JuSAlREH-uEOTu6VPgVnwIVOF
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=6874f8d3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=tQVf4dIAefa0khsDELoA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140073

On Mon, Jul 14, 2025 at 04:34:39PM +0530, Jagadeesh Kona wrote:
> 
> 
> On 7/9/2025 5:18 PM, Luca Weiss wrote:
> > Hi Jagadeesh,
> > 
> > On Tue Jul 8, 2025 at 7:34 AM CEST, Jagadeesh Kona wrote:
> >>
> >>
> >> On 7/4/2025 12:46 PM, Luca Weiss wrote:
> >>> Add support to register the rcg dfs in qcom_cc_really_probe(). This
> >>> allows users to move the call from the probe function to static
> >>> properties.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >>>  drivers/clk/qcom/common.c | 8 ++++++++
> >>>  drivers/clk/qcom/common.h | 2 ++
> >>>  2 files changed, 10 insertions(+)

> >>> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> >>> index 0f4b2d40c65cf94de694226f63ca30f4181d0ce5..dbe7ebe5b8710fb03c1671ac9022e608a6aad35f 100644
> >>> --- a/drivers/clk/qcom/common.h
> >>> +++ b/drivers/clk/qcom/common.h
> >>> @@ -43,6 +43,8 @@ struct qcom_cc_desc {
> >>>  	size_t num_gdscs;
> >>>  	struct clk_hw **clk_hws;
> >>>  	size_t num_clk_hws;
> >>> +	const struct clk_rcg_dfs_data *dfs_rcgs;
> >>> +	size_t num_dfs_rcgs;
> >>
> >> Since all other probe configurations are added in qcom_cc_driver_data struct, it is better to
> >> add rcg dfs data also to qcom_cc_driver_data struct instead of qcom_cc_desc.
> > 
> > Dmitry suggested to use struct qcom_cc_desc:
> > https://lore.kernel.org/linux-arm-msm/w4eujq72uqflqpsqshc7zhu6lkc7owufep2g2rjacvzgj44vmf@auonp4ugbgow/
> > 
> > I personally don't have a preference.
> > 
> 
> Hi Luca, 
> 
> As other probe configurations like critical clock cbcrs & pll configurations are part of driver_data, it is better
> to include this DFS data also in driver_data.
> 
> Dmitry, I hope it is fine to move the above DFS data to qcom_cc_driver_data struct instead of qcom_cc_desc.

Yes, of course.


-- 
With best wishes
Dmitry

