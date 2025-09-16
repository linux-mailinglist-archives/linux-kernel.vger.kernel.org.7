Return-Path: <linux-kernel+bounces-818538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24498B59306
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FB57AFA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2232F99A8;
	Tue, 16 Sep 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdT9uVlZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAA2F8BFC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017460; cv=none; b=T95YVI0pZKf2PMN3jDgsrbSR0DIE1gpXLF2DxzJOua2rQwh4ZbNToMVidd4m8p3SDdCWuyQlA/Da1sPoKQwz530l1w68lJE7DAXwv0kyuAkbjUetmWpB4JdZ/Dk5TiLDGwsPrDC8IzBCuh48Ly5A056FHYufi3vyXPTVVOnunXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017460; c=relaxed/simple;
	bh=N5w9sGR83HmehQkzcyb3yU5XfW4ZSkbi04N9GlT0S40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUKehYnyES5bTUs/POlDHMmxqVNcQ0uOHgzBjsDjzsKI/51wJNh3kudXyzociQibo2TYSx7TUoNGxihevpbR5t042C6Jqso/ErvY1xInzACkU2grSZtA60Rkaz9Rq0iihuaj0lYP0fecj7yNEDuD15vpGVSdINu/F6JnegEjvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdT9uVlZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3ptG9001809
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+Hr4QdaTngAzxON61S7ZU7L2
	1S4tZidHsM1IVv627kU=; b=EdT9uVlZ2cSqy652445IPY2VKG5O2/fIqWkQbY4e
	KkbBdgx0z4eg53VGih4iSDA07ocV4pP9X1t4gXzceD6ep6A24sQ2ua4FCdElIqCd
	oI5p2NmlHN/7YxonShTpC2dVeBzzUpzdNDrQc6yWaYCiL/pW/Tp7Yrc0j7iCfZVJ
	4K4r9EitS3Fr8NK8SiUrltEZX5y3wwi7eneVDgsD+lwKy7GQ4hhYLjtFDn60yenp
	Ele1bvwS+CoqjkZ5ZLp3cZPlzzkSdXkZToPNd14yzmkXf7Bnm8AFmZgMQI/rYl6Z
	xtPgJbrdl2kX31QYTXazJ0h1vnoBfcN3Esnrtf+gAaHEzA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpyeqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:10:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5d58d226cso131943021cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017456; x=1758622256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hr4QdaTngAzxON61S7ZU7L21S4tZidHsM1IVv627kU=;
        b=L5T8gKGfKNWQKGMoNKsA+Xk3z4hW+NjWU6Op4uWTVQka/bxwEsuyKm25t9EhuxAef8
         4zEQgvIsWp6U8OaW+eQcbl4lF8NXI+ZshcIF3RYs7cbCVhRcTmmma9gqFzCiPnLV1zLb
         TP8C9Gg/LYSOAI9jxZdUPWIVvkXmzgofuBmrqwKCQbN7QT3eVFAetAV6HwjmFxwBo7FH
         F3+HAfeJlibCEkCCB1PYi8jcip/W+g7TqYD/DoVQMYMYwRAMdwgAmJB2hcbNGpbvoG7Y
         3XxBkgW24d2ufc8diiOFFkI/KZECdElQ2paRYi57IFuklo/2nx3WkeJAcag/6tU7GxTP
         0HIw==
X-Forwarded-Encrypted: i=1; AJvYcCUNHAqXelQWShXprl5qRSFRHhc5IV31jd7fUcWTBTdr8GOkYtVTvMrwDbE+3OxorifB1lm12vqJ6HcCNnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVbdzlThS3b78lY4GsJ8oG0Avsti7+//PvYl+R87cOBoSy9z8
	kI/n2foJDj2vAsk60yt33OjLJldN4pT3if0nWn3GuMO2W4EKfq1iHBXLU6bg+PYvzOneZ58kkk6
	qTIC6+fQWqUzT/2abb9ATXfOi/8vVuGtJS8q7e3abksA+IN8B/1f1e2QPKeaeboaPAUM=
X-Gm-Gg: ASbGncst1launhrCZC4yY43sTcNrw3RJIH401xU0AWOnMQXpmy+XiurHYJTdbLF0ArM
	BBWnmzwuc9scb7OqJR28TC+uS0jOBoVCLj9tFOb1qz8IE9ZOSs4Qt1cSxCN+J8jflIjXBNDFRb1
	jIWninTHqdosqe5Ysx8dopI1YWo7wvVVRWTonsNR7v60ml7AbsKzkQeMIAKJWBovLAY2CuYohqH
	oWezdxMeAr0YjV2O+F4z1ad1pPUZCLswv7IZg6KYcGlN63fRbN5ROPpn6sj0D1w39iT6uFe0rzu
	ee52puZiSRAy+V3vHaAZmaVvwnsvQGF4cuJ4BBVDCS9NNsFmCuH00G8Rl1jSPCQOdVnGEuwvTSE
	5y0ghZCj9yXBPVcIbfSCB3qHQ2KazDEzu5h241A7fAfB7lAsrOO4q
X-Received: by 2002:ac8:59c5:0:b0:4b4:8eb7:a45e with SMTP id d75a77b69052e-4b77cfd7c3bmr187846981cf.35.1758017456275;
        Tue, 16 Sep 2025 03:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYmRtvb+l0jlW/S7lOSeC4zeZd7f9A/J0FIqtj2p1keSF3dZBC3idnn20IpIn9AtMWbRfH7w==
X-Received: by 2002:ac8:59c5:0:b0:4b4:8eb7:a45e with SMTP id d75a77b69052e-4b77cfd7c3bmr187846561cf.35.1758017455741;
        Tue, 16 Sep 2025 03:10:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5d8c4783sm4320157e87.56.2025.09.16.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:10:54 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:10:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm6350: Add OPP table support to
 UFSHC
Message-ID: <tzdnkjnq55ea7u7wqjvn6kzaobau6blnambiass3y6wezqgshs@otgiuusykcrz>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-2-3600362cc52c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-sm6350-ufs-things-v1-2-3600362cc52c@fairphone.com>
X-Proofpoint-GUID: IwoMbx_Pt64Urtvj1slmiNXabdc_xJon
X-Proofpoint-ORIG-GUID: IwoMbx_Pt64Urtvj1slmiNXabdc_xJon
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c937b1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=m3AVSQT7pDQk2eD9g64A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX5aXAh3LUwTOq
 HTlPEN6xUnvmvbD6WvxhCyh1ECVokOv6p+KBc7PKa5otvWtNHCP8ABseErO7gvN4tn6zlvlM+Mm
 3FpgQdpl3kTraYBBVvRfGLLjPVAFDMdp7xJYouz9ILFOeoxNIKxVlfk8EN1+eo6qS+8bDIDTykY
 e6Hl3KH9EVxXVNGW6EtDpuzAJ0p5H51it4JzcbzazakvoEYa4AMk2x+o1sahxMG9ScUYw5+/cxa
 qta40fKwT42sHwtULjdHsWh2n0zuQuIrz+WUJR9Vqcfr0IFqyTU2C47RzA53wiUpXNYGN0297o/
 i7zyXSPB0/l813H4XsU4UeavWovMbgibXTSuaV9fbyel8GtRJ46XQ1jC8JIaMREcsL7VZ7hEQyH
 TqnRoUSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Fri, Mar 14, 2025 at 10:17:03AM +0100, Luca Weiss wrote:
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 42 +++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

