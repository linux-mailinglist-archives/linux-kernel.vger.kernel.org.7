Return-Path: <linux-kernel+bounces-834706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BFFBA5542
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C1A7A1E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E973296BAB;
	Fri, 26 Sep 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cog++oYc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BB1E8337
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925731; cv=none; b=a8h0n+WL/okOrStumro5QlRkMo4wdZd7OXD/AldSYPB7LoIV9Y1b1Igkv4P9HbzcEI5Ra5AVXcsu2BqjKFkTkKJF2ZPmzAtWaV9M+ihRvS8U+E5LGeHM7sk+xpyo7ioS7yCHzn8aJbTAUj2vXo9d0wewMFED3XV1YeMK81mM0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925731; c=relaxed/simple;
	bh=C8N1f9UQxgYnwPhQiHttxBqUF67ClxX0z43nYhB+AT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmgUIXZQvGwk7x3kdHL+Tb9Mre/uk4GwTupfA8aAmJlSehZsnl9ELRTQQUN2G5znR/jUT/u9QjY/JtoIVRKb9bFcIFdipjBvgJQxvh3rRiCGg1fIYC0ymyXsA43KpDLeK1us5yQJy68AhU43NUPR58iUQ4P6Fzm9crZarE+u9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cog++oYc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWp6Y017378
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MRd4LCd4GH7g/51mFAw6JfnX
	VcEmlPTkPoanPe5h3Qs=; b=Cog++oYctCGSML4DQ9CepK3CbQKraJJREoPOW7L+
	P6nlebop8i2Gg+Z7NpvB9XoecTqbAR4SNPm07NSxFoMdIxzCl7TJ+LIekC7v1bZQ
	C7Xn3fy9Aol3FlBf49Rs2fcDIGMvXtoZslAd/y2ozIHeVkrUJQQac8+lDKktKw++
	VRgw0L96p3NZ9wm67DkAwhXpMmfIFbFaymnDt2BKk1Ke1K6YJC+1oP+J5sADDrth
	dVm+1s1mNdaQ8FvyqhV9/GwKiSQQoIqsRoIHAedZWFbOTgsX980W620J7wlezL1C
	RrXFAidsptbUW0z0H2hTj3ssLTq/IiejHp3vTDA/zZjEOQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49dt3g9kva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:28:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ddc5a484c9so27451061cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758925728; x=1759530528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRd4LCd4GH7g/51mFAw6JfnXVcEmlPTkPoanPe5h3Qs=;
        b=FEZpLXkWYHtk08ElACOl6mtFEcopg2qvLx7Znn3am5x9F9B++S0UGB+v7Uh+YLO4Zo
         Rexy7kcOiiJRLq31FDlbX+nTG3YcnrJQcEwFXFfEafPUOLITAwLG1nAs9dJYReAvsLL0
         vYlFnM2zzIcZWiw0MlPZ//Tx1oHtvlTV2rNJJOfBPhJ/uB1HaJ6ZXAARwYonYQtzeU9F
         6JZQyX3KXqS3G9eIyGqHHbtNHe4DPr3Vd8iKUieMbMrwBtevZ1loy3br0UuGcKLdvlhu
         VfIvqzDwnK4cNrXt+bZK9RIN12ze3WsrwRwqXjjkVNCA9j4hEDkyovJO5quwIW57NeKd
         c5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV0l2tR3GjMxhdfP/U2wvNsxwgETNpRqEK/TrlZqlybg92uiSGnEKKjWztciumMlgHQgPRVy9MgJi3MLbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Nji2J3LAaS9fpbKYSbhOSg6CdGCNz6+K9+gDI6hTsgRVVWwk
	1CpA6CZnCGCD26SzKOEFpaOZpMzIWBys6Tbkihc19VAwU54g7isaN3ysHbFYObqV6kUmGTwpdEJ
	KXw8DrcRuDi5h3RGEsvISzIfHyr/wZaT8wly/y2IStcTadMbYAkhqGWH+nlFRQpwIPOg=
X-Gm-Gg: ASbGncuAaIT+W2yPxj/Kz8wVLW1gf7azccQifGA3+PIkG6WTUenmax284/iGveEBwlR
	YcdGz/oIqLQwLhfRna4QZeu9DrP4JIYUT/rd/OUTyIxqvBq4mLYfiYLcL6am7WffDGKk4qNZLq9
	Vy4SBYRMYdvUPMpsM/x3OB+i7L/hLq8SXCLtlpfj2a/KnMxBmQm8aJueO5enN97uWYdKMMchQxJ
	N/bLSi+HJ9CUnWO0k9XZ5c9+oi5pdlzQDvNJt2cSWcKCSqNZSxpCrWKJ5hHS7kz4bLKhjbNyJRO
	tmuuoNFNUrvvFD5AJPdrvFLQ+NZCmICVjooxGlszgGJyMaF0OhCZ9OFxnU1C5kr9/WPnpzArdYH
	ylgsahZVLImBR0UI5J1yTLMF5deSO18c+fv5aM//kCOA05nedJRH6
X-Received: by 2002:a05:622a:a956:10b0:4b4:8dfb:33c3 with SMTP id d75a77b69052e-4dae3c29955mr91598291cf.59.1758925728043;
        Fri, 26 Sep 2025 15:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECT+nuGAx7AybGioU3MTy0w4rerMEkx4bs7/aNnHMDuso1+UFEquoAeyhJO8yc6dvhGeykNw==
X-Received: by 2002:a05:622a:a956:10b0:4b4:8dfb:33c3 with SMTP id d75a77b69052e-4dae3c29955mr91597971cf.59.1758925727541;
        Fri, 26 Sep 2025 15:28:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430dd5sm2149171e87.24.2025.09.26.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:28:45 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:28:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v7 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY
 config and DP mode support
Message-ID: <yuklvnhgq3q5ddeakv3pmt4iq7jaw6csccpzamxfgcdcwguy5g@t5or6bzrwwoc>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
 <20250926-add-displayport-support-for-qcs615-platform-v7-12-dc5edaac6c2b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-12-dc5edaac6c2b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=df6NHHXe c=1 sm=1 tr=0 ts=68d713a0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hsSiBWVQevx2fRdbtS8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 9_DBrnggP-QgwHoQI8QOCL51-TJD_BaI
X-Proofpoint-GUID: 9_DBrnggP-QgwHoQI8QOCL51-TJD_BaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwNiBTYWx0ZWRfX5DoLgit+5rAN
 LzhEOpMYZxFN3xtkbQl7OV7tSF7LEYbEgkKRgtnmoqFHTCYi/76wT73znb672+idPdHn/Ze+hM6
 bhOxhTVWttqcl2WQTgB1CExEaXr2H/JUS+BN5UCOUSsla+iX38FJJYdcm2vNgWW7I19DUeyb3eS
 Bf1py4PJHn9SHbie0VJcEUCHgnJtmpu03n1AcExgNmI6RNzidF9jZtJ6erV5Tf91QgZFMGIP5SI
 LJnPYKnZNyQ/QHYFuxL9c54zGxZXtr9GKlC+G/GlyGDxNcTtdw9mNCS0n0+PfKb+f1EE+1v++RP
 gfRqzmc7QXtog9TusWWcILcJ7/wTm6xnjFrpf03Mq5LSn+sRi9V47rt5GaT5FnZuXj+V6Dt2d44
 /mIu4ZArqxIklqqiFJT5ZKT0Z5daWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260106

On Fri, Sep 26, 2025 at 03:25:48PM +0800, Xiangxu Yin wrote:
> Add QCS615-specific configuration for USB/DP PHY, including DP init
> routines, voltage swing tables, and platform data. Add compatible
> "qcs615-qmp-usb3-dp-phy".
> 
> Note: SW_PORTSELECT handling for orientation flip is not implemented
> due to QCS615 fixed-orientation design and non-standard lane mapping.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 413 +++++++++++++++++++++++++++++++
>  1 file changed, 413 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

