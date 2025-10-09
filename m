Return-Path: <linux-kernel+bounces-847192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DFBCA369
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0317E3E430D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032F22652D;
	Thu,  9 Oct 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SES6ftUS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A622422E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028102; cv=none; b=k87orcyxS+myluVw9IK0pYIVtn1jy23uxh8Xc33ThTBB/OS7Eblm2Di9fr8y4H9GXUPV6NvKfg47JJDhAQFh5xLFYRsyCLZBz7Zf2ZMOVZ2fO1xinj0anQAQiYs+kxkgHdlxZaQuaTsFWvkw49juIhMTtJ32Uxq3xXksbupx8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028102; c=relaxed/simple;
	bh=nzppNACxKDmFbDUZaZy58p+ZQlSwVTMP3w08jfJr890=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRSjm6El5T09DHbeYhxmn9E/RahU3xrSDL1ML+JO6zVUn8PqpnT+X8TuSqN55bAYZKmR38h2tJrzGckLpukWq3jMqVavhJjSwTy1ANYbUAox9T6QgL+37Bz2l5mIqaV8eQYx8bykMhL/xnNVim+g2+PJIonuwCAE+dfkTHlymnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SES6ftUS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GZUoj031740
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 16:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jVIjAUCQHFumxYlbLBQFJgYn
	ACBUPAyS6FDjWwEKeyw=; b=SES6ftUS2cpNn/RLEQZ8oSpChoXMgwIR20TPlyyg
	j2F6SbMWlr8w3uvwrhSTene8nsS7VbS5ACRmg4xc3TPn1p/qILgq1OOMoxg7pv6I
	e0Yp9Kt52MUiwceCEp9ZXVo99B39atezPtLJrhP6g4bbae0MgT9+we5Fm8BKeNP1
	KVmZSrY8JnaW2mhM+rRXXq+56l/R55swSNbvGiAKxoZXlC5YlpJKViu2SmPr6cCH
	KPkYROGi+b1acBoZ/FWnsWmEnT2w9VQ21JlSbDJNfyJqtUcWT01qsqIQgCKQW6RD
	QyUIcKcXyUMoLaQd5p98ZC0Nq0S/pfleOM3AZ2DyoRIiZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49p9m0skqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 16:41:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e574e01ed8so37127301cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028099; x=1760632899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVIjAUCQHFumxYlbLBQFJgYnACBUPAyS6FDjWwEKeyw=;
        b=OL9xdhw7ppkhbLY8Rl/U7YV5TsfLCqPfEBgrS2/thglAsvw48trrtgww0zWPYdWsC0
         URtNbULHpBJ7h6liSuoI68+4D+6DxCW8odM8xGHs3J9Psyoj5nhCON53JLMj9DBi4VpQ
         bSSrQgx9DVe7HF8mf+JmZsQDilGXxN2kqA5YkrNRFeaWNj/+tUuGuy+rmqj0kNvZZ0zy
         jSg8lZRS7mYm0ZAywRHtnJUaLLmjkt8XTzs0KDz9xz4uBf4VmKybD301u6zNO0ij6h4n
         dqsSNa8RJ0txOSwvmn3nfVI50ljhOUa/Rdzrg2OBBz18JKfz9nlvZnkRI8mNDHCu53YG
         7sKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2OnrnbAj7Zy+luJIUjvAKeXpSnFRARDdvA/FXQDuDWNS5hT76Uj95Kcx2TNF91EkMYBzci/bf09RPK2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZpdmuAydMbr3ngTlhc21aJ8VUb7CBWE66ea5BB/1ZjI0mRQr
	IQyBokVugVYg7MvHpbuKTM/hZJVNrn44yBJiLeWzllpLXBQ0Gb850MLbuDOVs62wMOXkod0LYQb
	XtCrYShZmfatX03W99eKBvl1zJMkfNqWR/pX9ar2hmRFgdtIl1gfIWAo5G2XsaQsm+Wk=
X-Gm-Gg: ASbGnctBHFXGQ+BqgPTe4YnLw0wVvvRw6u+fmQTPJfjLuBlTBcwnGs/oeWYFdV5mTjJ
	6CF7xnd9XcpUQsP9bxDgdMGbpQry/gptHTjeNo15evwPjg2WTPR7eJwcAGih6DtdQAM6muFUyqF
	fzb73XbphXPgZ0ISDudtoKyP2xZDlE6RBkjLCYsBJoq/xvP4+7JHz4dX5dRNsgzsYh8mJ7mC4iQ
	xPsol8mcJ6wWVd87P7Z4T5brt7XW37Hz6FEgMGZa4LYShDblWmGkKfDRpsyb+tMNOjJqaMmX2V9
	yHhNwvzOwhTZphlfGXLaDr4tVWnibXWxMEi6In68TogK+Rh1UTvsQRf1533LxQSv9J+OKNA2lLW
	7qp8BOeEnvga4iKRK/MBbsXlnr0lvsnpIuA5SKpt+aZGO/6bg6ep+Gb3jGQ==
X-Received: by 2002:ac8:5e0c:0:b0:4cc:48c0:adfb with SMTP id d75a77b69052e-4e6eacb414cmr111994371cf.9.1760028099297;
        Thu, 09 Oct 2025 09:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoXKMV291WSm9uUShb9Y84qPGluLOJeWKWrLLXfJieCpTOfOgB5kBVupedt2mzmmaaiI0w4A==
X-Received: by 2002:ac8:5e0c:0:b0:4cc:48c0:adfb with SMTP id d75a77b69052e-4e6eacb414cmr111993991cf.9.1760028098856;
        Thu, 09 Oct 2025 09:41:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3a1a4ccsm29241261fa.27.2025.10.09.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:41:38 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:41:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wojciech Slenska <wojciech.slenska@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Add uart1 and uart5 nodes
Message-ID: <icm4q5hsalaknszjhtlgii4xf7z2xa5ygjifdhsbu7neid3gth@ow7bflgphver>
References: <20251009090858.32911-1-wojciech.slenska@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009090858.32911-1-wojciech.slenska@gmail.com>
X-Authority-Analysis: v=2.4 cv=a/U9NESF c=1 sm=1 tr=0 ts=68e7e5c4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=biNn-n-MkuPdZtkuIrsA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Q1LYZLYXEF3YwdZgNLGaw_ICRU98etcc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA0NyBTYWx0ZWRfX/plZYlvztJIp
 do7hr0yDTVghvvPAnsQv1hiiP3DV69xLeofRtPOE/ptT/INlsORU4evUMITLgzHkb3K2Q55nrpU
 pimKaZiOlyQYw9RtTTkcGJ7X+qPeHjmrMHan44n0uUWZy266MVrexudzf4wS8ShmZ4doUcb9IGX
 UULonQ/Ce0DsrT8bksE/Q95gkVMvWobVVt0Ht1k2zOpuXYc/W5vBPQeC5SCzBC87ekI4L+UpEs+
 BPy1AlUxqGcxqgFb9poOzMp27AlSYS5EQalpbDN2WynCQi6SOrplg+wXxU0l207K5NfHS3yDIsf
 E6bnaKKjG5qevmy4K6HLXacMV3W70hrCiNJkaY/Qh68tln2jy4d8k0pslfSO2DgscX0/oybggBB
 BIayd9ki4FZmnIfVQ3U1m5e6ImoMoA==
X-Proofpoint-ORIG-GUID: Q1LYZLYXEF3YwdZgNLGaw_ICRU98etcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090047

On Thu, Oct 09, 2025 at 11:08:58AM +0200, Wojciech Slenska wrote:
> Add nodes to support uart1 and uart5.
> 
> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

