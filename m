Return-Path: <linux-kernel+bounces-826186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B06B8DC8F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC317A878
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B350248F47;
	Sun, 21 Sep 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jiGuu+k+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C240282EB
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758462150; cv=none; b=pTuULtPRl5TD4c5Frrt5LWC6mMhP8qH9uPGbliJyn4NxsUt1o2yY2keIOBaURQ2X106E8FtJ9u6QRNDLHyjMKN0yp9kcZCzf9enqYmGrxnzfyUxlo9fK23z6nfsl6eEgHt25OzxT2kIH8gICAYsQieQp90R8/61hpZ05n/pAAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758462150; c=relaxed/simple;
	bh=P1m9m6X7raH53exBEgl1dSftxYvXtfQPuUKA+FGcWJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctj0O4BjJXgU3TElpghihUqijOajNIYjPisxyFQ+N3iMc/1TCqhV91U6woonttozCdK4NRjhz9aRdi2Inx/pHvO++/WO31jj3q9AgPO4A3GdhR/0Tt0QnXDLdKTFfE+1BbMRpoyOBR5O1gWhk0ciS/zt5wj/uVAHZCd6k79FilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jiGuu+k+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LCgUV5016869
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8fbZ8AUpdSZTGf7eQiIgMqXI
	ZYleKr5ODhbUFzT6EXc=; b=jiGuu+k+texJvrRXTRJ6E/bblgHDWUjW1QVgjrwg
	SfmDYMW44LEQO7SZwZm8yQVoI13ioB/phuMiUXK4AUQdpTFy3QB4D9JEvTbEyMBH
	Gn1nQRCHxXGtBPrKhnvDwfey4kXdgK+fsn2RzeSNbGhshZt4qJ92kYulprxmn61m
	Knv5vqLft+d2pTeSIEyAlXk/B09HaGyz+Gm35cjXusKX2oJZGr2MoZby0dOgWiVQ
	AN2qE6aavGBLvOtfCee9hogEUbPem1as14gl4MMhEA0ICTi8NmqmFJ63k1uO+t4E
	P5PmVCRoRRJccKaJYMGTlEK2oRpXR8Y9fm399BhfykkX8w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mbv27gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:42:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5d58d226cso78639951cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758462147; x=1759066947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fbZ8AUpdSZTGf7eQiIgMqXIZYleKr5ODhbUFzT6EXc=;
        b=KhXqjX/XbetcK85uqQ2vSU/SYV0ojS+GTdzj9wTPH30uEj67q82ENxkbuvwg7f4oRc
         7ZI2azREFaSFgB1RGNv1f79CSb8lkgUPLTVeqtUoDeUeoG67TVCaU2Si3FFxrlKndkIu
         fD2dFWhpvOkxC3r7usol9mLm492S01rphFv4D1YRcZOISikgvaDWn9j6ev3jU/qS8BOU
         mK7hX/1EHbTLvr9XvGBVut1l2dAZXYw4YEqYbSuhhjoYEw8bokaqJD0uRMFfk7kEU7LH
         fWHBsyoJDiEnJfNoEv3qFS3IeJDJv6/6TzSF27sJQ2HaP0r33w3ZVJ0UW1TYMDsUXsPd
         iwcA==
X-Forwarded-Encrypted: i=1; AJvYcCUavUCfDlwrQEhACJ6wA1E4M59fITyzg7cthBdQCibErJcuewownNtsmq4W5s3n/qiamhj+WGetyRFS++c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOq1k6C+rIAVraG2030WKzA8Yze0tEL/sfEyX4r8zGMc4zBgw
	ATGn0AlRLUQirJm0/dwCUGUUPhCYUYWMrmn0jdQUbzQfeoxGKoiX5+3oaTWRpDlbKXrnUJJaKu9
	RMK/w57y2sil7QYSrWFCASIvZYFL+6stHnjiSJXyTsT3qX1nvrVyjkdn4KMRPZx0TUHM=
X-Gm-Gg: ASbGnctwJumu81Q4OpsYhDt+rIN8D6gzUMwM8xY6EQQFIBddjSHiZ+ZjSZIYRSq7yrE
	AmsfIXP7vV7q4A08BJQC8cbMZ65G4QNCE0zvFynqxKIpBvv/kfYbN1nQ44v7njuVm7CkjI4RmTe
	HOfv+rnYXvdHD0ZnT8Ab/Om6R3J2WkuGCPdk+6EpVVIHhlVUVPVF4I5G1fJz69FBlPcr7mbGLfo
	aWdVJm5PHgC4nwOx8lRaI9av5ty3ODUxj/lkWaKoQyXFpReuUts8RgXC56bcDyk1fXb6Xr0Z5DF
	zr4T2sizqOmmzZLp0B3uo/07Spm2IVN5KO36yPzvwp7YPWxCS8xYWUIWKVoj6ZDtr7A4837Tkbx
	ezswqkbu1QXF6clyp4TDLxmQYTc9fiOvfuWml6XxfDTVAcgD3r00f
X-Received: by 2002:ac8:5d0b:0:b0:4b7:a71f:5819 with SMTP id d75a77b69052e-4c074075e01mr132048681cf.38.1758462147390;
        Sun, 21 Sep 2025 06:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ7Q9Xe0lR9Xj9tnIcryF9l+1mpr8zgHCX8Mvs3/dsJgHI/XKaercYfK+VaNnsZz4Oy15W+Q==
X-Received: by 2002:ac8:5d0b:0:b0:4b7:a71f:5819 with SMTP id d75a77b69052e-4c074075e01mr132048351cf.38.1758462146925;
        Sun, 21 Sep 2025 06:42:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a8f56471sm23012031fa.42.2025.09.21.06.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:42:24 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:42:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, Max Shevchenko <wctrl@proton.me>,
        Rudraksha Gupta <guptarud@gmail.com>, Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: dts: qcom: msm8960: add I2C nodes for gsbi1
 and gsbi8
Message-ID: <vanz6ktal4lx2v7d74u4ac7jzxjahnxy2l45yg36il7evgaw3q@hbszkjgfrkct>
References: <20250921-msm8960-reorder-v2-0-26c478366d21@smankusors.com>
 <20250921-msm8960-reorder-v2-4-26c478366d21@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-msm8960-reorder-v2-4-26c478366d21@smankusors.com>
X-Authority-Analysis: v=2.4 cv=ZcAdNtVA c=1 sm=1 tr=0 ts=68d000c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=t1JXzLs-izEPKbqAoeQA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: h7yEXA9w_GxwgBrlwreus0IHIRSD-F8-
X-Proofpoint-GUID: h7yEXA9w_GxwgBrlwreus0IHIRSD-F8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMSBTYWx0ZWRfX8Ne+rtheUBAL
 zHUsHYd1zjUr8Pz3W5FmkITPHTwsLBIOpemTubdgrnWsvYv8SSNt+tu1e1caG3ddxLh/hJAwfxO
 2uwY0C8ZWWpFdr0BAMswPHw3R/E/odp/TBicvs5/XNdVvqJVbSYI2QqURpb5AJM32vMUBr09ZaK
 hrhro9X5K83oVc0Ab+5ne8uVZv/S2HL2a8Ce3+7QULMFh9zYtJMZHZxdf9zRDiRl3AvmEQ5WpT7
 bDoSe3CVwiX9PJiOezI6r3PXus2pM1yMYigzCUsPMKakx9CSUjh4K843O1grJU4KWEH8qqFzu47
 EMM4XaY2a6zp6CCRsCJo1oRdXLELwW5HNqFZw07FTrlOoKO614c9Ck1R7BytHg2Hic8j31ryMpf
 C/4sByiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200031

On Sun, Sep 21, 2025 at 03:08:12AM +0000, Antony Kurniawan Soemardi wrote:
> These are present on msm8960 and are required for devices such as the
> Casio G'zOne, which has NFC wired to gsbi1 and audio amplifier wired to
> gsbi8.
> 
> The nodes are added disabled by default.
> 
> Co-developed-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 70 ++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

