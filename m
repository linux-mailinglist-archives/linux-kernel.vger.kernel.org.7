Return-Path: <linux-kernel+bounces-879185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A38C227C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E4114F10D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A683370EA;
	Thu, 30 Oct 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="igCpRbFi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WsXX72MA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64732335564
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861464; cv=none; b=RrTOGQxjmeYQn64X3IKjWJRUGS4rxEtjZAbr8KwdXmTvH+qNO+dKiPaPbpuQcj6cLJfYLEZ0pgHQi2F5qwpXBVEG4ZBexWB9it49tCiu1xazvNN+9OZ4vdqyQx1cuOwZc3H6VxzTmPbbUfW57l+unDTr7lhdmQhuzqXigM+L/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861464; c=relaxed/simple;
	bh=VLfCFD+uvrBkmpJd/1V5M/PEUjAGoI3I7b5T8SfcbFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=erZKKAvQoDGGpavysLzIUH2fWuFiNZOpL9CxOuSe2TiCEODG94YZKfqhorfBsdKCvYNzaAyxh4cI495e+4QlJaByc5SqzvigKk9449/if30g7PjZpBEQC5Rta9uXUSC7VIY0wBiNOc2GT4gelNEbkjv0JRZhLXZiSzjX2vTDETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=igCpRbFi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WsXX72MA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULrMFC898088
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hbxlqnkWJKv72MnwB+3LG1JlDumthqKLFTiHBb/B/wc=; b=igCpRbFiLpUf0N/w
	Icz0TjWojhTRRO09YZ4ZKZy5sY1Y7fS/WxzVKImdxQW0DL6oUvgTx3btchE+sfTR
	vSp46K9xoDy5AEhsvgwgWmNn0nfTHplgbWXLmqPtSiBpL0f+yUIq5vNJ5x8OgeLW
	nhkBBizuOxkeftSp4aZYS8nBdLC2+kNRxU57r+KCvP9nwCWDRHf55FwIc1yhHq3q
	2wCbggK5oABqN6/p49jKODc943k9lSliNAh4ALQTRhRZpET3ziDK/IDEw24Z46MM
	SQmNRmv2y4oWgHhO2mEshkL0n5sjI12OO/PKW5J+mRTCgtPZPHXOBVOlHflMh/xn
	/NgPLw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb20070-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:57:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-286a252bfbfso36135035ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861461; x=1762466261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbxlqnkWJKv72MnwB+3LG1JlDumthqKLFTiHBb/B/wc=;
        b=WsXX72MAFhSeGgz25vlVOEGeGD4WmBxRqF02wJE/GS3c7UT3D++ufcJ8Z0IJml7iMm
         bD7mKDDEWfnQCyQ27Lylna3aDVhRgKvIP7GzZOuOYDd6/Ai+xOZ6zr/3gZ0ji3hiYEga
         u8292iBLveQaMDBq6MeS16KmkFa97irm7i2i24/4tJKv2LWbTfgprF487tsrzY7K8wk9
         TDYNm0v125KAbMj8T/A+fdI/OldV3iOQRjGQA2D+MDQiwx6taAPat/oUokkd9U+pS1gT
         QnbAru7u7umBDRg9z+DEv6eYVhN6DvBl7Y+0VkSYM+dw2JsWbgGDvTdivgbJRsn7Ihuj
         79Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861461; x=1762466261;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbxlqnkWJKv72MnwB+3LG1JlDumthqKLFTiHBb/B/wc=;
        b=NeJpDfJv1pI7fkgyIpvswBYY+R7502NlP1m43PKcMG4+nednE77vRvb3xM1yLA3nhU
         20gHodDEW53sgDAoUck9p+Mnqvr1BQM/O85NQGvOMQZAO5t9vXQ+V7Xqrg7PQSuJI4Jf
         53f5StHL9zZAawtFg89s/vVlvpTBEwns5O+IjkV6poc4UfeOMP9Y2lYParIkY9POcq0s
         qKrxirAjGbsqmbq4D8vQCXkcYKAjfFVE6gkrYv/8XDraBe7yxehgxdy4NxerPwCiMthG
         uziZdI7CnXufqSCzREhL/bT4goZoYrtBaKo4dobezU3Ewj951sWtzHCgzuyEMtHZ0BBD
         TjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+ldEKcgdsRfWTvKYD6Cxanex1g9b7MIwFh+WgHbrDeMtTcNEyu5a0IiA9XR5Ftyk20lNbHBTxps+knnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhB04DFw5CNLeMPs5am5iQxnLgBI910mWSaXMwwWZ35gmIxuLo
	jgOaWxC8hkHu2RKa2pukq8sQ/sShwQ8snd+Qp/B22wuPvubSZySCQdIaBbJk4vn93NSz4GozwZ6
	B0XkeibeFk7Fiohv6MTfpkj3AvLWrZp3XsHAQzsRliIroZAGWBt9enLY5SCh6TMqhlqI=
X-Gm-Gg: ASbGncvBS00WkStJWmO79kOAKHwRE30uatepKdUHQaZ5j5ZXObto5wagaCPY6f3R6zR
	z8LF4/muAofdBAb0uJGKVfPi2J2bsNSGAXUAqdVnsYGmA61yYGqImATy/14b9Lzg/5kA2WQpfdG
	WfItJv91Po0TvPeMlpY03vrKKD/QK01zvXMKUz4cnNTfYzNIXeL1tRsqe/D/XEBeBle/+t7LuqV
	ovvKsa22LtCrFLh30YkWDM64MHgbzoaK+PypBe/9OJjRzPpKRsyUEY+ft67PH+JJYDEp0ttAWfB
	Fs+PL1AGCh5hInYSkvq1PAj2fp4JtBtK9Qr0xMMqJp2DKudLllu6/rHG4HYNq+7o4Z93qsc51w5
	sTpW6rlS0S0KDsMVit/YP8h/rLpudSjLUe9I=
X-Received: by 2002:a17:903:38c5:b0:269:d978:7ec0 with SMTP id d9443c01a7336-2951a45a15emr18108565ad.28.1761861461224;
        Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZJ3rUOeLoZ5JdbU31KxAXQDa+g3r+fwNG5gM0aI6wgEv2sSZ9CXBSV2RLCpCXzMfrc1egw==
X-Received: by 2002:a17:903:38c5:b0:269:d978:7ec0 with SMTP id d9443c01a7336-2951a45a15emr18107955ad.28.1761861460134;
        Thu, 30 Oct 2025 14:57:40 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:39 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
References: <20251028170457.134608-1-nihaal@cse.iitm.ac.in>
Subject: Re: [PATCH] wifi: ath12k: fix potential memory leak in
 ath12k_wow_arp_ns_offload()
Message-Id: <176186145939.3489476.17111380584676068402.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=6903df56 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfX9+tgvIxkyhRe
 TfFybOqTHI6zRd9jHgCkbvvEa4MuplnEg6jrZgGNxjz+0w95/6O2vXY8WDWRDTwIECOXOAywkKU
 TJXLPsvNpTLzRynWwlPeNxunZg41J2/39JQNGl9XMQuJqwfifU14i008lzK4xAccCG2I5tCLXgF
 lHUO2GXBLrQlF6WTx6XffhBy7rPZ8/IWwfUg8DpEDpvJD1CL+ZGy/Nz4vDzEXkFJZM2ICYGm0ke
 KNRDtGv82ZytFX25nI20lwS9hhhNTJpBSczuE+QhHCmUF6Lzmh+tP0fE09cdJzWyAyWqnMv+u/w
 ePcpseDl55x7u1/R6JeN9jIdEebew2uxLoOcdtjY7+SywfHQWB7z5QDT1TqpxTo3Hb7XDwuaIUd
 Tb/lZc2uU7RilsHIRryqhS5/uMKL1g==
X-Proofpoint-GUID: lRxmdjwKu3gxEqjo_hsPmQhO3X76fMBi
X-Proofpoint-ORIG-GUID: lRxmdjwKu3gxEqjo_hsPmQhO3X76fMBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300186


On Tue, 28 Oct 2025 22:34:55 +0530, Abdun Nihaal wrote:
> When the call to ath12k_wmi_arp_ns_offload() fails, the temporary memory
> allocation for offload is not freed before returning. Fix that by
> freeing offload in the error path.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: fix potential memory leak in ath12k_wow_arp_ns_offload()
      commit: be5febd51c478bc8e24ad3480435f2754a403b14

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


