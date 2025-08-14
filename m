Return-Path: <linux-kernel+bounces-768436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE3B2610E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE6C584E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4172F746B;
	Thu, 14 Aug 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c4iccqO0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E42EAB9C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163710; cv=none; b=BsA9n/1nLNfoGspGQXcXm2IXQ7Ie1zVn6r/CNUxnyhlwoImF4zb4Urwx9fUh44c4wQelJ3MHOvN3Ic3K7k986H2pg07SSuly53ZptBvrPd7taeH/spj1Yyj/j6TnXDkcKFtlQT1S+tO/UWIs7ZyyrOj3nxZLZ7GKTSgPohPXGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163710; c=relaxed/simple;
	bh=+pvfW+LwHle+znxirRSbw12fp/VImxYQ5f/K16iAEBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+EthMEWKB2ULkKFqRcz0A+hP7Eq8FlycxTvClt0keIDPT/Fu+ArZpyTpoVUT1fqVi1+JQV5LYUus7r5vbBs3fNNBuBeI7aRw9K65OoJxlTSwClEp+fVTJMb2FFpiO8PUVHQI+s+YRAEQB13TzZhUCVFQL6mSFT17+CSYkqXPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c4iccqO0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9SDWq023950
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=O076QscBlfaSz8F8rEYXMUKe
	ydobwM2fUce6AJi5pU0=; b=c4iccqO0EpYkH9FlIOWuAAX4vE+ax/m/JH/fRlbb
	t9eJgwcJ+5InT7JIM2Txed7ag9OTSWtkpyrYw2cv5tr4C/Bj9nMemtKdTxly7w+G
	6xJsDYtZVXn4de0Ch6I6PiCvND/NVK6cVDFb/14nB+Hdijs+xNpcWfBRkTb6xFWy
	DB6Tfjz9+fpsrvF74b9+m+n2saOGXxjoOZI5lXpy5vmAaPAUYirCnvg9IWUZvHT4
	b+VazyBmbJAXOKNh+PwVcEj6816hGiMib3v2UH3n/dk72oVu23tc/sqGvg+JlcXH
	9+5aBS/XHa6jg8uZARpyzPpdOoorP6E953G4MUM4yzL3sA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rut0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:28:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109acac47so20949791cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163707; x=1755768507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O076QscBlfaSz8F8rEYXMUKeydobwM2fUce6AJi5pU0=;
        b=wnlKWie7Qu7mBpiP+wZtxvZIszg2ZxjVgqe9TmOD7oW6O+iSFF7P1k6VszhcYPDgbU
         pE9defsZeSrZ7+Tcbn+8V9esGl10ycK1Y3MA4OQgiG/vsEogbbkkQKQPEaWgOQcl2rMW
         LTDXm7k9cLfCqxd5o8Pkf22v/voZxDBtXY8SCTeet0g16HvovjAoS9pm7kPPz3MvrLfL
         Hw2z1ypZPYpnxAggt4p4BTk23pMDKdxSthF/Yk6T5tSDFkR2vialwNk9Hp1MpJrJaY/B
         fLiZrPiKBDhKimyN70DytROb0NJZovY2KkovYIE+56+ZqFWiyIvR7doEp6sGNLOUyK08
         NQLw==
X-Forwarded-Encrypted: i=1; AJvYcCV36m3acuUWnyqY6oicOIxsw9C6A3nGF2qTA+SU2ItWPx2MKkiR4cw0fDo9j4NVT3GkFCD+hqQQyED9R2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4Ts2BPZ6jkk1+vluQW8nH9ptHSuWb3EKIbccxbAmUqaycb9w
	ee5kKCiB+BrXVN5B6C3SY0w/e50Rwy+GSJvqVbea6uAbq3gKVa+zUiOWKBVo/TbmOWes/O+mM88
	dcXJ3B4deMT5a5+hZ6cZv0j7/sEPnWQwYZrQT4jdiUu/MF7OOR3LUobbz4ItCpsA40gw=
X-Gm-Gg: ASbGncvcuj94GNdbu+S+AH36v29YqWfE1RnnVulaoZogbhHdV2Ou4T4Lg4gB8y3QFVe
	6z4xO2Z3jPgPxEajexfGX6ZXZ6pq+y7qUn3m4ty1fCJQCpCU+FIHf7lSc28S8DdZK5z7jCftlrb
	ZT/Dj/cPOJc+7JnXlruSBCLklyLTlmpPDkBPSK7v/dd3B1yqG9Ma9psQ3iWPLHESrhxuFPU4AkC
	Gs57zOftjzMdUosOqfL+fZj7jBBXL/0hZU7bnk3AC8iwQEO0g4JSerHjo0kfWmRdz6AVzTapW01
	bGVkNcXPbfi8aFYSELL/sYZfXNxPoMVktWxHN+OeuIcPPnwCR33/guXbOeGE690pPUcqamY1jps
	px+Owt9/reAYrVwbzd8atg0Qe6mIEW1ceD1Fi6HAID7xgpAmkiBqN
X-Received: by 2002:ac8:588d:0:b0:4b0:7989:13db with SMTP id d75a77b69052e-4b10c5ed878mr20121381cf.58.1755163706766;
        Thu, 14 Aug 2025 02:28:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3MUHvm6rtSa8l/GeGn7RYGTzj4ND9ReLlHxxvcNHQJymdlM1Mf9CYxBThDHTsoL8aM4maXg==
X-Received: by 2002:ac8:588d:0:b0:4b0:7989:13db with SMTP id d75a77b69052e-4b10c5ed878mr20121041cf.58.1755163706254;
        Thu, 14 Aug 2025 02:28:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ad021sm5649676e87.74.2025.08.14.02.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:28:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:28:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v2 32/38] drm/msm: add support for non-blocking commits
Message-ID: <vns2bbpekccowbu3ahg4cnvhrbfk3yc2tvu7o4n45gpn2tpybp@w6gmsve76erp>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-32-a54d8902a23d@quicinc.com>
 <rznsg4feyxanhvggxtebilg3ukbcrv3xgi4f2ijadjqaeqfelo@ogib4gythj7d>
 <a8458790-b4d8-4165-bd6f-00497a9d0457@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8458790-b4d8-4165-bd6f-00497a9d0457@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX6320+HZMt3bO
 6Zhz8Kt8B6VB+Bzpb5jaLl1JgW60o6JOqP/kW5bZ4ALRCmDUNdBKrsiZuwFYs8AK9kVkdRXGYgA
 q1Hd1MOmCGXVrE5qYWWSqpdjpQZjNnhDftd6G4wqvRXdcgWE/PEYDHVX+4BRjdDo+Q6a7fPjCGi
 K2dxgOlCYDN8pWSVZbGr3BcqyPSG3q76hjzPUFCeJ5Hcwm+rk7+yQncriqRttTiLVCh1bdaPQVu
 qoaN5U9xXPHvKYteQ9a/WuiZjQrMRpFlDj3uYNyhpDxaFTXyysjRH/nfxs0Yv0zRsqxyjXK9l06
 +AHDoPsnwoddDIZ/7+/W70d0XOVVBtOfmLjHV2NfgnwhJ1BPXZC3ROA5LqNpKE0qUVEitn6OkbE
 u03aapUu
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689dac3c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Z7gkRSVo2wHhsan7cAUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: KS12FvR_qquYPA18RwgUgMgVRHXtmC2U
X-Proofpoint-GUID: KS12FvR_qquYPA18RwgUgMgVRHXtmC2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On Thu, Aug 14, 2025 at 04:54:16PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/6/9 22:50, Dmitry Baryshkov wrote:
> > On Mon, Jun 09, 2025 at 08:21:51PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Hook up the mst framework APIs with atomic_commit_setup() and
> > > atomic_commit_tail() APIs to handle non-blocking commits.
> > 
> > Were non-blocking commits not supported before this patch?
> > 
> This patch only work for MST case. and for SST case, i'm not sure.  I see
> commit_tail() called drm_atomic_helper_wait_for_dependencies() in DRM
> codes.. Hopefully this can answer your question.

This should be a part of the commit message.

> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/msm_atomic.c | 3 +++
> > >   drivers/gpu/drm/msm/msm_kms.c    | 2 ++
> > >   2 files changed, 5 insertions(+)
> > > 
> > 
> 

-- 
With best wishes
Dmitry

