Return-Path: <linux-kernel+bounces-728967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8698B02FD2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672873BB07D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D881E51EB;
	Sun, 13 Jul 2025 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7hkrAmt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D811AC44D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394765; cv=none; b=IvLgaegjmI3aT0lKS2f1eoK4oYS15r5WPY6sjhVdmSjFBvqMyRugfEkpeon+G1qHGQcl/5exQc10+yaVF/VfgaQYc/DGX9Xadpd73Pi9+yMlEMuIgePveKvVUm4xZaR2s6FeyYvTzdEE7CENN2Nn0s6nHj4rvqNwyVuOL6Hg7uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394765; c=relaxed/simple;
	bh=ygYuN2TTNL2SM/3Pw9NF1EZYs4Jmwm183kP3gMiksRs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLV7W+ZfP48I/CSuDJJsQmnROZzw2so/1FSwKfsXsORRWUM/RrRyUzQqXN47uIdFLwYyryOvREYYTghYWbBQYSV2OsA55MsXo+h1rh/GOyt92J6rS1W0Hgq7xeL1xOiir/LLmVsDYnjQuuWSWpKsbmE78bieKs8ZAeoVdyCyonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7hkrAmt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56D5Jb0a005109
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jvVyW4KQM51jowUkrrNklb/y
	GAEEPyAbTimsRfsNU0I=; b=o7hkrAmtc9G/UYbo+0ybUftp2vIyXp9rMQE4bEUC
	ftGXDVsM+zZrCtIVZGGsbEK5aCY1QJZGZBabNqx8lwbpZWvWaQdMYUvl6dWAyujU
	nSrh+eD6k5q0B+8vExwKLhW4Bswc1X/oew6MwVZIDchM/i5qE01VwcjNHKA8ZLXT
	WUXLXIfyqJYZ0KqbDF9kdw6XKTCN7ijd3NKrAtkNq9Atu1MndkaRw+w0HuDCc56a
	1QjiLsrKi9/rBOq+SEAGI4nn4CR57NKyInrs34d4NWEQ+2r4M0FvzE42WxwFLDMt
	SYzwbDP5sNnJBRm9+VLZ+F8M4iw/ojKrYLRZELF58/HgDw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfh9re6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:19:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e1b7fe85b1so108648785a.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394755; x=1752999555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvVyW4KQM51jowUkrrNklb/yGAEEPyAbTimsRfsNU0I=;
        b=ocIvfDzeHqSiSz+yQf+BZVRlGpufVoNxrrMB1EFfrU9ROJORdxriKU/3YLhVwBjtHF
         Xs+JIsRNRco36nT1znBSyq+gq4oF84Li5t7e8XosTyzCXWUgJPqf76c3xvwKkhPovbUl
         AzUkFWU53rO9EouDjsC7kkfpBUFWmJm837rpo64iI7Li0p2y5RvNA2IhUICkxny233xD
         gKxP7+Pw7dIbA0JjYDhPEkzKP3+2V+NhmYT/hWnOA8TEqqZap4M3AhSC4cN22+ZkHXug
         G/JVKebg1gCk52KmQ9Iiu3QmjeVHJggycfF75HJlO734bBEX47ZU0XBi3wVqHaPUe+/8
         ruMA==
X-Forwarded-Encrypted: i=1; AJvYcCUeilQ5bY6CT+teEvT9LTWtweUcU4iC1yimoEMqqY34CM7QM5RN8QagpHiQe17eedn/jr4XS3Psyv69QMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQSYCaVs2YJpz+fFmHPUFhXNBexpO4GRRec64x40EfSM7qhCig
	mVoMBBaRRaAxgi8JXZE+zUf4GSJLPbAokV01Ph5//18jmKa1B5f+KkeW3IhyvREdwH5oobMklOk
	Uj1tTUX3pwpXiYoc8nk6J3vVnj7IshDtd5PIgPl19kxuepvUTWYtK7xkWGjKi2+Z5BRg=
X-Gm-Gg: ASbGncuIBySq36ZVJaTIvag2vKXkgnddguUkTUahGEFnA1Qbwebo8392HxF6Ozrlv1G
	fDDm8JTDvBvLUc9BQZ+W2josyW/5T9V6IRONmVQw3PWUQ5vnY6iCnUJp6MEPf8au4ohcv32E96J
	Dv802PLct2u+9bZkyywXC7cKTIYEjzdA9qkXqkPDdSny0zg/dTQRoBlTEOUTbrHkaNzpcFilwhi
	eASjhvjB9sOwgFHLjvBacnOn9jbebawrOfkRLYhwy5zjvCtkjNGJdQlaTN8wIvhfInJ3c+HVcwL
	NItQOxROp1SM7QiBLLgyrQQK+weTCYq5iojThd642yY1+2hIaeaAsNwvYExBvL6RrYhGP/ylZS4
	=
X-Received: by 2002:a05:620a:4056:b0:7db:94e6:4929 with SMTP id af79cd13be357-7de050a6b69mr1148779685a.20.1752394755301;
        Sun, 13 Jul 2025 01:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXMY4Nu22oS4iMPfYBCmtTx31uTknxbB52WB2wjHLaXr79YWw1L0N7FvVH1enfsTZncgitA==
X-Received: by 2002:a05:620a:4056:b0:7db:94e6:4929 with SMTP id af79cd13be357-7de050a6b69mr1148776985a.20.1752394754876;
        Sun, 13 Jul 2025 01:19:14 -0700 (PDT)
Received: from trex (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d758sm9002937f8f.49.2025.07.13.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:19:14 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Sun, 13 Jul 2025 10:19:12 +0200
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>, krzk+dt@kernel.org,
        bryan.odonoghue@linaro.org, quic_vgarodia@quicinc.com,
        mchehab@kernel.org, robh@kernel.org, conor+dt@kernel.org,
        konradybcio@kernel.org, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] media: venus: core: Add qcm2290 DT compatible and
 resource data
Message-ID: <aHNsAP6Q6mvc6jX6@trex>
References: <20250626135931.700937-1-jorge.ramirez@oss.qualcomm.com>
 <20250626135931.700937-5-jorge.ramirez@oss.qualcomm.com>
 <ded874b1-715d-a7a7-fd0d-3b98fd5fd029@quicinc.com>
 <aGuOzdCu5UmKDF94@trex>
 <30cf5c9f-6c9c-4cae-adec-81fa090a3eb5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30cf5c9f-6c9c-4cae-adec-81fa090a3eb5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: _21y_MxdePv3JMVoGoftloK6KgKiVV0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDA1NCBTYWx0ZWRfXyr5izW+d88Jq
 CMrevsIgdlMk528kvq1CxAiZ0s2z6ln75azwRVj5GSRRHFnda5uhg4oN/NbAV/a/W74u2iipBKX
 wZpmTylbYHuI7a6LDbRWYhuvUa8cLvagts7+RZnMCVhGdsUvISXhCMctuqR4OKmcymm8fF91rfm
 h8gyeJMX8FCVZaeSQPLxkIY2MUHEjCuQD70jhzv1yDENl9iIVHmNccYWzty7zo83T6ZwtEHIL6c
 KSNWF67xlWIeZeTItPf6RVbNvIvSHk75erqggX1b3Tch7dY/o0iB40vSLcD3Gx4EFxUFPIzzlK4
 q2ctyPuYRGGFc5QM4misjLwnAp7avsFEZYzoHGuOLzicY2kfoWB5ZCB8/P+CprHQw3M4z9HEYW1
 sznIm7ZRi7ePdf0hNlrMJUItH4391Ijilo+wr+EUHmbZvHj9PwQMp+WZVIhHgFW61zbV4Vby
X-Proofpoint-GUID: _21y_MxdePv3JMVoGoftloK6KgKiVV0t
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=68736c04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=xq3W2uTSAAAA:8 a=EUspDBNiAAAA:8
 a=DVtxpjqVNlKwMNJ2E7kA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=P5L7wpMTXyg1GfFA3Gwx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507130054

On 07/07/25 11:19:33, Konrad Dybcio wrote:
> On 7/7/25 11:09 AM, Jorge Ramirez wrote:
> > On 27/06/25 18:46:10, Dikshita Agarwal wrote:
> >>
> >>
> >> On 6/26/2025 7:29 PM, Jorge Ramirez-Ortiz wrote:
> >>> Add a qcm2290 compatible binding to the venus core.
> >>>
> >>> Video encoding support is not exposed until the relevant hardware
> >>> capabilities are enabled.
> >>>
> >>> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> >>> ---
> >>>  drivers/media/platform/qcom/venus/core.c | 39 ++++++++++++++++++++++++
> >>>  1 file changed, 39 insertions(+)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> >>> index 736ef53d988d..f1f211ca1ce2 100644
> >>> --- a/drivers/media/platform/qcom/venus/core.c
> >>> +++ b/drivers/media/platform/qcom/venus/core.c
> >>> @@ -1062,6 +1062,44 @@ static const struct venus_resources sc7280_res = {
> >>>  	.enc_nodename = "video-encoder",
> >>>  };
> >>>  
> >>> +static const struct freq_tbl qcm2290_freq_table[] = {
> >>> +	{ 352800, 240000000 },	/* 1920x1088 @ 30 + 1280x720 @ 30 */
> >>> +	{ 244800, 133000000 },	/* 1920x1088 @ 30 */
> >>> +};
> >>> +
> >> fix this corner.
> > 
> > ok, will wait for Vikash to confirm the other ones.
> 
> Actually you can get rid of it now, I think:
> 
> https://git.linuxtv.org/media.git/commit/?id=b179234b5e59013f8772da17b273f463f9720bdd
> 
> Konrad

yes, thanks!

