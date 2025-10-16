Return-Path: <linux-kernel+bounces-855410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC8BE1245
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F4724E260F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D71E00B4;
	Thu, 16 Oct 2025 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pi/UMMuQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771E4207F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576054; cv=none; b=Wzb80GbIRJ1+snekcXLjZbp9ha3wA3R02OLwaoOrub339bWS7P2K0grXG7q9ynX8rYlc81L5Wc2kRg3tjVnQjqNMGtbS6SQ8XALtCRk9d75Ttgkbl54PvnCSFBEewp/nIT1LJ0QXiRrbzNJdkGfuAJGMrWMbNKQaxMnEHihuMkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576054; c=relaxed/simple;
	bh=vH+a72EDIkUM9pwMm2kYQjHGx30x2K6yasIivY3TuA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssBKHIypvrUmlMozaFzGnaJCkPjC5bGV4J0fOqfPllAJqflOsDXuoYaozzxuv1DJfjK1BH0tACaV3mfG4BmJkbM5U9OQzMt3nofWkjL53oJa3PZTM1jRTDbEKNZ4v28N7OKQL4XuLcTxuQhSHKRw6UJ2cieKSXv+LG/ffUU3U1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pi/UMMuQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FJf8HK003457
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qxfHuhhNJmqQ3d2VcILRyWBJ
	+3hCsvxWDQcdnlZza2w=; b=Pi/UMMuQM0HH5U28kt3N3oS1QnqYS9nChIoRjx3X
	81IJc4RUt3O242I8hVDVSqBt2fUcWDCnjHGfznkpN0KIOvuXEbkAVO1U2fxOfzOu
	rZsuXVc50JxK3Asov3gyaqZOHY20nbstYGz3pRzBCf82DEoSPim8AvUuate4FJ0I
	MBqWJr1qDdZtQysP8JgU9/FXhQLKxtz9ardnMHcSE7YMifbXHfivXJ0g7hgSAnsH
	DnAb5lOWw+66vN5QbpwXuFcezlz3WOTjMi5xWVNnofoylmOOljSXHYMeZmxxa0/v
	AANJpogQdP/lpyRZ+AvOb/a2L6wMSA0KRIb9g7M2gC+LUg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8efe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:54:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-86835654255so103938185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760576050; x=1761180850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxfHuhhNJmqQ3d2VcILRyWBJ+3hCsvxWDQcdnlZza2w=;
        b=cnQ5iEisbF5IBWH45f6Jr1yZ166BcWgokBTd+4n2rg2QR8v95CQky3k/RbGKwiezXc
         cJhnmQOWTCrB7gSCjD3sSShwBRDKbcUj6d3V4I7HBCxUmTj1b6y3ch0sF/uMn7uR3fNg
         hsw5prNuYG67Oa6LHFFPPv4AyuxeLGiLkkOL/EKlVnGlMsmVbMJ8M/uSwywUm0EFoUKh
         IGfgwS4FXSMyXhPupr/G9tozboO+aAAVgJepRWaqb5/pGU2ouOlcsQ5f3+PytMngKEup
         SJCNeD4J87N0KlRJqQ4EORm2N0obUUvQ0w11rhBfUUDuy8QOcgHnzBxQc8JykdK7EN+c
         LQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCVYqn5nJVoowkX1U1Xh9q1kx8LzsBP/TFgAD4R9RFc5IPtx7BRg5PUjB7a1ZzZP81p7oq5F4askofvzeyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Jcmd46+fFxkMDikFkdtqeVlxh1Z8Ziwqsd+kHDi6Gq1u3cL9
	F27Cb5QwHRP7ACeKlI0l5mwJWBMTiV6mat73j8fZ3xfLEN3bGlWPxHMkPpfoSGm3PfjqeyQTQLq
	+bdOI1DWtFM+922PBi6gXkC6y8bGl141HLemoHblEzfRtj4aE34zOmye4Am0EYvbzciA=
X-Gm-Gg: ASbGnctEWvPNeoS0p7VfHdGA/IL2KnQHVRfPwm2eQTXUfAL84UP6ZZ3Vx1qZQssvc99
	xF1Rzl0aA2/Rs8GxIzyZMWPc7UDLLcdyvfmUdffBWWTZJ9oq/o0CAcqFSfF6d2NYrAIfPf6ITGQ
	PxzHKx+cF3JUXRlB15sUXzExIQwCYxbibVCcCVe3doEYd5YV2afCPMyvKZh601LxNeKtV8sKA2q
	A0BfzdAzJFtVt7LQFldVZeGALHCKp0A9ljOqlMg9HW0QqzUY0axANw4NNSTkUc0c52TEEjIsc+6
	xPv4tNGzG9kVa4MDgkHHv+B5ohIiwmoM8WoYNsCaV5GxVdYyzg0K9ZietWXciKSx0AXs1+r+ZnI
	rrkjq99v5xdu4npYrIiuDoCDPRcTsarF9G/3SYwyGynqJjdrlxFweU6X49i8GwA5ENLShVIOIvp
	4XkN5IVTn/kE4=
X-Received: by 2002:a05:620a:448b:b0:849:35:dbfa with SMTP id af79cd13be357-88353650dc5mr4012683385a.86.1760576049757;
        Wed, 15 Oct 2025 17:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGElMuGPAJN+DiUGo3XVaPROIJfyWOt2P2s41k10L760vcozXlWS2xA/eYrcc7Qr1TpeWYa+Q==
X-Received: by 2002:a05:620a:448b:b0:849:35:dbfa with SMTP id af79cd13be357-88353650dc5mr4012680885a.86.1760576049349;
        Wed, 15 Oct 2025 17:54:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088581d51sm6672261e87.118.2025.10.15.17.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:54:07 -0700 (PDT)
Date: Thu, 16 Oct 2025 03:54:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: prasad.kumpatla@oss.qualcomm.com
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/5] ASoC: dt-bindings: qcom: Add Kaanapali LPASS
 macro codecs
Message-ID: <6nyqz5fsqyqgtsqk6xxm4iorzoelhkgnghm5xczh6iamvmdfpa@2vff2lk6sq7e>
References: <20251015-knp-audio-v2-v3-0-e0e3e4167d87@oss.qualcomm.com>
 <20251015-knp-audio-v2-v3-5-e0e3e4167d87@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-knp-audio-v2-v3-5-e0e3e4167d87@oss.qualcomm.com>
X-Proofpoint-GUID: eSlUC1itrLrPl6mFI21gRWUmc4ikniTP
X-Proofpoint-ORIG-GUID: eSlUC1itrLrPl6mFI21gRWUmc4ikniTP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX2fsiJYzlZ7Ea
 Klmgme3rghfJqfjxfF+9S8PWNQarAuec/3uf6f7TyKPIW0DXRoXz8keulqi1JEkvOK9JLivDl9T
 aLjLRnrHqQFbBDa4j5GBar1u+HleVDV57jWzk1/kEmjKZ7YpvPKZDkw2X0gXanpBKA63zxiy06R
 X1URPX8VMRVniEyBkv/ulw0Yb68eJpvqMllGVxhDFp79mzMVC3rzn6Paeal5rw1dpNaC0hI1Xx3
 RE+ogE8uSWApvFrYqvOViHgXJ7dauaPpi2dSIu3sbRF1PmySX+kjzNRiwSsqw9GSNDkjc9xdPcB
 0d8PzN6l59wmeboy9L0TSZPJA7HFQnrncRHseN9G8retUTIzFPw//NFq3JfmOI4x5oADwSwVjNp
 RcIGmZ1bJuUXsmZ00cRHu/1G3IlA/g==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f04232 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=EgWSWpgtYvY55qVivvkA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

On Wed, Oct 15, 2025 at 01:27:19PM +0530, Prasad Kumpatla via B4 Relay wrote:
> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
> 
> Add bindings for Qualcomm Kaanapali (LPASS) RX, TX, VA and WSA
> macro codecs, which is likely compatible with earlier SM8550.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>

What does this serie of SoBs mean?

> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 1 +
>  Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 1 +
>  Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 1 +
>  Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml | 1 +
>  4 files changed, 4 insertions(+)
> 

-- 
With best wishes
Dmitry

