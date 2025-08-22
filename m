Return-Path: <linux-kernel+bounces-781570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713DB3143C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9383AE552B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175232F656E;
	Fri, 22 Aug 2025 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TRSmB/xr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF92EE5FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855610; cv=none; b=je2tQdHHwAgwmKWXwhAjNjh6E3/l0XQ7v7eEKV5sr7A/ug9pJya0rroaxoFxKmz9iLyEmF6VD3GsHmai8N/5GZ/y2byLdq/2smW3JIozyX+492ptEmaQ93RG/zDUDVb5u7NNeylclTUAbYnRTZXqNsmEtjHGf5xjwS2JG6Zt+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855610; c=relaxed/simple;
	bh=lIUkbswluaNGEOmoCj8P6as4N+Tbky1oBgaIwtQGQPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhHwvKmkPki4GGyqLe/Dmck/9AcenMeU366LCz9IQhwoidYOcoAEEVqED13YsZgccQS3bjGcn2nYu79KbXA1OmiAj+h9Z0estdu3FiUbiYnVZ2i+XWs8WH5uozb+mEkC09wDjS7GjyGMAK7n1w3GEY/Or1pw4CKJ/f9RXruDAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TRSmB/xr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UZso027464
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VV7HnwUdWb8prCBSAo17ohhZ
	8QKgiCBcGSc4d+rF/hM=; b=TRSmB/xrAXBqB4KJmfM/PN9j0xjMrJyvkDh8szGo
	nodzoV8yfW8YY3Zg1d0WqkKjIGc+lKmgFmT/qzCNHDHyIiBzIMz+a1RWN26Qlsgj
	0FPCOfm20ozp6AYTPV1l8kStgfSoVH92KtQ50oEJY9ttaGef+EtqL09OM4gc+A1Y
	WW35SJUa72OOzmYfD8bLdanWysEcMmaHlSTphSE3b6JaRg4TxxGdSVaxU92vJnlF
	2G/TDs1nE3w3LW8Wj3wVGbwUyIi/EoINOhWuJ1X90wEFtMPtbuW/QFJOkGamYN+3
	f+tgUaSsUS/IFqv4JUVdJo//ZsNmxABxS680fIIPmxFgPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298r51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:40:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b2a1344b36so33744651cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855607; x=1756460407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV7HnwUdWb8prCBSAo17ohhZ8QKgiCBcGSc4d+rF/hM=;
        b=MoTAdE8yOsAWuwvBWi5N7kT2h9lVXMYRlv4ec3ynkhkkptvV7yM7vz4Et0FA/l3GRe
         6IwxP9fXhyt+SToQMKvcR+lpIjC7ZeLFEAUVolqs9cQZYWdTshIFDWzvsNRG6pzeFKdC
         EjqIpqwwZSBsBJUbxhljJ9TEgYVC3sr/ogCmrlHR6A05RE5u3zyEzF5MC446e3xJPG5J
         5Zln8CFdb82aWawBXHyQs2YeyYGFOWGlyRIyy5WRi8YpU96JwSX/GIJuFmkOGnrCJxOE
         xCdxgdSTbD1jZSHvi095TsNJkVw5/hNgj9JwP8i8CNOHDxuoFAtDdbM5i1w/Aj6A0Ucv
         H0tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUserpaCW/pjLKTYBB8hYXm25DXhDgLP1YRzIuPdoA1lVA0diB8kidl1myOpSs0ckgdvZBcic3ocnNXzIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj022Uc7HnCPWm0sL2OlCL+YRwkqLkAQ8pDgQtQMuBF9JoJzPZ
	49UbK4HgeBtjXwLKvv26ecPbttshD5mVD1jA/DGoD0xcQhddPRXK8MV7lfozH6HPu+iO6icTTzL
	YS7jBIgsTIFJ5JbuhIoTnaY6L8s/rR8+viFsUE9es9SLs6aVEkDncuEBKpXur0MbwZk8=
X-Gm-Gg: ASbGncuayaCtkXbU8zfFu6zWkD74PPHHyji43fdIN3uWSKSTzStbq8n8WmnSIZ1/EbI
	1P6rkeyVXU0dCxDFKW4OQf8Upk9gf0WktNmc/9kku2qiHf9kfbc4iCs7m9IQEh15RfZhx+/P62C
	bkE4/moHaqorQr6/C7nBqvLipBBIVli62dXJoZ5oWG6HTRj5G58D4hf6LgGfRU3W1lSxo5prkDs
	owThLLHjBoSEyiiluHHboGedULKQpxw36OunPzj0/u0q04LFrHrDh2FRN4KN9Qkp+FYb5OHWLjX
	jQ16ci3/9mlTITPAYWTtQKoZaB73BJUzdGH+y82KeSfGlueJlXmZtTq7OwzpS26/rTAEaH69Fh1
	cK5LPj/ODxyliTo+XXvUUTLRhMnTuClcTUrJn45TxBlYY3TE7vvMC
X-Received: by 2002:a05:622a:189c:b0:4aa:9393:7b5b with SMTP id d75a77b69052e-4b2aab040a2mr25803291cf.41.1755855606666;
        Fri, 22 Aug 2025 02:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH53o6I0qmMpe1oyUujgaG5094XRKhCUXHnIq2XRcCeX9iOx8jJKUM9cGhJutqPObJLZCzwig==
X-Received: by 2002:a05:622a:189c:b0:4aa:9393:7b5b with SMTP id d75a77b69052e-4b2aab040a2mr25802981cf.41.1755855606100;
        Fri, 22 Aug 2025 02:40:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cc6a3sm3532145e87.102.2025.08.22.02.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:40:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:40:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 01/10] arm64: dts: qcom: x1e80100: Add pinctrl
 template for eDP0 HPD
Message-ID: <kpacd6jtwlf6nklisn4yboc7dp2vxwuo5udmqkyhuovbn6sfzp@o4bldflclwdu>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
 <20250822-x1e80100-add-edp-hpd-v2-1-6310176239a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-1-6310176239a6@linaro.org>
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a83af8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=A2_dyhv4GGI_orQju9gA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ncdzs-QTGTv_OllkA0ga9eFpSxm_t7tT
X-Proofpoint-GUID: ncdzs-QTGTv_OllkA0ga9eFpSxm_t7tT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3SOAMemC8oif
 At1Nqbx2BnXkPpZ7fHt/AgalkwmU79eTj2bkINIhJeZbWWaZxgMVPksC3n0OW0lB5ByEPOz3R+H
 /T2U9qSNtof2uwcaCmURaOBGddRbRhLzZGrmv6KosThtkAjaLUHQ/AngKPQPhBW4jUv3k5tVe8v
 PsiIO1F+50cRE6e4OMaJaOfO2mP/nVYBSGKofafYhoTPr+jsfJDxjQ1D2o3sD7WWLoT9E7cM7wu
 ZEbcLheDhamEjjNC8cvW85ppcyiSDEAaQ5am4AMz3apLW/XwgdA+yQ4FPSCm1HH2M/y657ulSeW
 p/xNedUKAYN9eV61bswC5NFcUY4bD3UMhZBU6bFZAhTUzWNivEwcG/Dr4f3Q//jIeQGp2Q6S7wq
 eCb3w62rcYfikLYXXXh3B6ncHYGwEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:28:52AM +0200, Stephan Gerhold wrote:
> At the moment, we indirectly rely on the boot firmware to set up the
> pinctrl for the eDP HPD line coming from the internal display. If the boot
> firmware does not configure the display (e.g. because a different display
> is selected for output in the UEFI settings), then the display fails to
> come up and there are several errors in the kernel log:
> 
>  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
>  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
>  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
>  ...
> 
> Add a new &edp0_hpd_default pinctrl template that can be used by boards to
> set up the eDP HPD pin correctly. All boards upstream so far need the same
> configuration; if a board needs a different configuration it can just avoid
> using this template and define a custom one in the board DT.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

