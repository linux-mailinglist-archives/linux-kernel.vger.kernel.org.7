Return-Path: <linux-kernel+bounces-747753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9F8B137AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F53BB2A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F4525393E;
	Mon, 28 Jul 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5V8P7It"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C892512FF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695605; cv=none; b=PBY/F9CSx/NbLk2FoO9IruJefPH/BXq4FtLtf9fwM+6r/nTnsPDhFM/g9mznKE0S3yUI5tXHuXOfZMWLSFYpe6EIbU5LXeL78tW44Z//bgD/UnQpDHIFu0M2Aw+CSES0xYXcX5K+ZGacVP7hc051xMc9tOmoA2eGvowyn4z54Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695605; c=relaxed/simple;
	bh=QiOeBrAIdjrellCMOaNYCha7F5wS46M1LiivABH2puc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE9nhrXDDpCPWB8EwZNbHYU/eGVGY16PdXnZceuT5IwDcDph8AduDgB/5Wxt6bPir1YaZgpwxIMwoQGT/15Mz/+5zWET5QMzST9HfSR76ymGUP6JF2fjzbwAT7kQINFUoYmSSsxfAGwn0hyzYipNW6j+hMUQ3bzA/W9e9iBQaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5V8P7It; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rWsx008526
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oFB3vG6oMDSksw+IqlEzE+5W
	vTvnqjVwd3/y/mOq5Y4=; b=T5V8P7It8OhjF0CIKXRDa6KThqdnW/9ojBQXNTKg
	w55P/G0u/d6gHVqyWSpcirmZyfECTukbdy6anyJecWkpIjq0cS09/b8hIzXcq+FD
	mKG4hWT2gyZVTHavL+UPeQi0UunHhIMvYcuEYfrvIXxid8v8ePZv7/npSq9pxVYP
	OWduBbOYfpHLh1VUIRT51TMIPM/1ZNLCRPmNe+LUQTw1/of0x4WF4OH3n2iV8UUu
	LZ56X43pLPiv0sd8fEGIMKIsZZ20xws++qwU3NHGSyKxLKuVB/SC5ATuE/tKh0lh
	/4gx8s7V07QX1r1MmBtdhq68S53D4ck4mV7KHi0a+xCnTg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk40pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:40:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e347b1a6c7so1155704985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695602; x=1754300402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFB3vG6oMDSksw+IqlEzE+5WvTvnqjVwd3/y/mOq5Y4=;
        b=XwESnaLN1SkSX2yPJe8RzsZtbo+zzaKUtCJ/ngX80L1HBAaVZ8/FAMfUva0GlM6c4Q
         gruXPOVpqshXGgNBqbU/yW5Q21fGNnB78PXFAe5Hgwb/oNkZ00mpQE2587lOI5utnnRN
         73TEllS0QNu2WLAcTERtUZU43GO0U+d6gaD7MjZElbjJwJURpsaokQwklBgN3TJp68Tq
         +RryGkUvwGa+CT9InBjVoy0aFQHmiTF3B8oGo1Nldh3vmncz0NZKtyWNRetMQ0AHzZua
         yh8an/MtpU7ztZPzsnRNhMLwSiCrKpUMGWmVSUbjsKb8kmaaOiAw6e89oIhj6cvv6Ldx
         3OYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSujZzxn3JlLJkuSMrX/B7hZ7FzPLAKq59mWYKg0QatRTdAJ5LBTpQ+YOGmISWtRuhGlhzNBqoUo+oFGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaVwXar8RW+L0lt1+dNouWHnPH2Pm5/wZK1SWKqy/N/9G0HZz7
	ua4GdYsqOw5mjdMgbKnQCWJ2lv0Nw8hUmbqdzYlb2wAEUGSCg3kgQXXQrK1dzeKgrgH13IxM2wr
	P5xFqfQBnnh581hfPZZuCg1SomaLqiU3gnOYKBrnn3m74kvHkvNic6rjX5GtKyrdrhz0=
X-Gm-Gg: ASbGncueXKKa1RSq06d10SeLOfcdIsunrPAH9MGI341veTfB4NxesBz8+ludGoz8obM
	m9QE7za34Z5qpBIEP2i0O1XAVE4mluexDWppCMehEK7YVWmOjrpUcZaTLYtEqfialkR1prygR2J
	YBXwdpczbLBEROtS/H570YkVd925uyKrPZb533WRSQr8AtG8XnSZ6Q5Jw8jXTxV65eEeDTbrFEn
	p8KS2nPacn1OHwZ3GWLWxGgQ8EUN/nkunzYl/MA9uYDELD7MIFJebl4FRWszk7ESIMHfAX3Gew4
	BjslDD3HGgo2RDVHN0KjP/CZsRoq1MtuZrmH4xY3J6qldVe8WTN4BZ1ysdIIpw03x8pP33jC1xh
	GU0w1/6MfXmtVxACXE4AYbIBGoYCMjkzNdjqnNcvYH0zAxcc2EmP5
X-Received: by 2002:a05:620a:d87:b0:7e0:2c05:6b9f with SMTP id af79cd13be357-7e63bf84f20mr1494157885a.16.1753695602138;
        Mon, 28 Jul 2025 02:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh9YvZXA5UIvwUmMAvvJ/c4paHn9tAvNskBJAWiyrfPCKv85m6T5ST1rY+bjPyFBgbZApBiw==
X-Received: by 2002:a05:620a:d87:b0:7e0:2c05:6b9f with SMTP id af79cd13be357-7e63bf84f20mr1494154585a.16.1753695601548;
        Mon, 28 Jul 2025 02:40:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4278c27sm10815401fa.76.2025.07.28.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:40:00 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:39:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        bryan.odonoghue@linaro.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        mchehab@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <gr63jb6yoovm52l6a3h53scnhgkg7xoda6lond26dduy6seg3o@knyd7qavg7yj>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
 <20250715204749.2189875-6-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715204749.2189875-6-jorge.ramirez@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68874573 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=fNMmvbdrdlD2suN_VgQA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: rIe6SbrUTrzxCC-kp_ubb9u9j-RkA-Ua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2OSBTYWx0ZWRfX7DXGCAIg7l5x
 oCIY/Af5V3FL3tWaCBnHpA9toiAwFF1h55pPy7iLqxnBKAe9wHX8kRcjCfenIDfTQVQpgFIR5Dm
 WfBeTyOG0X87uVJsvtGDSLcRwdrB2LH9bAxsrG9HDEEnt8LZO0B6sBW99TxYOwrZ5D09UotN4Cp
 /j/8zaefeydznO3EIY00HmRibZoUr//YlkZYW1iCXQos2PI8XUMzb7oZPnvKoYJAQEpP2a7dQfD
 1zN9c9OT8AK/VJ9MHHkkEFxj+pl0xN8fg3KfFTt5CPhJruxmC6iPD8ixLUMQX2aLiuUljVHN4as
 GEw7nmFucv2pGFSbSaji1EKsDaalv9kU2DzdoelGiPtZp7W9Fa+ZdZ7SliszYYWQwjrI61wj5uN
 /7mvYkY31iXGY9vpmAz/nJHn4O/W67wHipiv+GRsmgQBk6MAf/tlKP5DCtmD2e7Zdhu3lw1F
X-Proofpoint-ORIG-GUID: rIe6SbrUTrzxCC-kp_ubb9u9j-RkA-Ua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280069

On Tue, Jul 15, 2025 at 10:47:47PM +0200, Jorge Ramirez-Ortiz wrote:
> Add a qcm2290 compatible binding to the Cenus core.

Nit: Venus.

> 
> The maximum concurrency is video decode at 1920x1080 (FullHD) with video
> encode at 1280x720 (HD).
> 
> The encoder is not available to firmware versions below 6.0.54 due to an
> internal requirement for secure buffers.
> 
> The bandwidth tables incorporate a conservative safety margin to ensure
> stability under peak DDR and interconnect load conditions.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 51 ++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

-- 
With best wishes
Dmitry

