Return-Path: <linux-kernel+bounces-737678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDD0B0AF45
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722A67ADB5F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D7E221555;
	Sat, 19 Jul 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hw1+m4VL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B832E3716
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752919843; cv=none; b=U4iVrN5p0BN7Ycmidvci7g+SxAn6b2goIlCf1uAgBxOl+CDpxtxzcFEOKlcdALdVHpaVP9ObPkgwHJYxbf3xt9Riz7reNi+d0viOS7zY1DliTwQwqzYhSlmRzomjQmyOMBdM9A5PS+6PENddjzAJoz6tVddD1TXER1WwGjh43LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752919843; c=relaxed/simple;
	bh=utSiTo4TMlu1YfqS+7TeWM6t3lr6x4U04C1TJbKXAXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfwZwPNkCZGEK3yEavoZvhcem02mlv5GrxeQvARPb3QdPLsk2Z5yQqQvI5kNT2FJ0muHsKJikhSQzULOigwgObnFgqLvSsp8LzoakXY0jsiTLFXDsFj86j4okqSpWLpbtViVsple2tbWniyrDKUdYgsSS9Jkrf1+JtA1rlB7WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hw1+m4VL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J7cOJh010238
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TafuwAxxAyRiy+2/X0fzDvpZ
	2vsF3PkzwIbwp+jnjII=; b=hw1+m4VLVuD0e4CoSTymezjhl6AWgsWf1pNtk4AY
	U1K80C2wzZjo8noZRIfas6+lfQ637xNsXbRZeBocrsrllGTWV9Br0LAf1xBbVBUy
	PUE19KxYLcmWhk32a2Qc2Y53SertSD6D4BNMsjITJdApvVkJVsltCSpsGGqSWrB7
	3mdaEOIxattHgNuDICKPyX5znHcYDT/viO7bFQSOw90GDklQNT4UD4DdDJDz/9SI
	5vdjFmaq8nKyZGMSMKtcbPxMuD8JZKDj+2x6GJj3dCzxXxkWXdlltcDBy8OGVUIW
	khlDxvEAcDsUUjBQZriEMMncEeanG07+7oUnaEY3IVcsnw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044d8fje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:10:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fab979413fso52226266d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752919840; x=1753524640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TafuwAxxAyRiy+2/X0fzDvpZ2vsF3PkzwIbwp+jnjII=;
        b=dbog9VznS6rmtAE/QphE7fIEwMhGB6J8oTirKNVJjjeinZrW10cOeKqU5at9fBxDtd
         XejrVODBZ4HnsllgWQYuMac7NNf4R76RgPeKcM0+/XXREoNTLuPgduSW9BEuN1QWNKT5
         lWhZftNxFkElXJLoeujood2xFXVIwpEjuRgIt8Q/Ux3Y3zSGvh43h7UtT9A8AsL0nByA
         vUtXR/OrIsBJWgdY8o1m7Othrq3bXBL6L61aH7LOmBQetdmrcuyIl1k7cyLJgb8WV5hS
         6VgRlwEU4EEEYdoY4pGg7yPuHwDmWALewbgcnrh+a5mpI3w2pQedEhKUwTY0aBQZRIym
         nfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQA07KtYgP3kFAPcQlHYBtdDlP0ofUUSy9jscnDNz3RekqbKeCDmMTCsJh8w+T2D/rjudY2kYASrHrXJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4Z62HkQvBGogPDCe8Y2nAktZSZnNZT0AwMLPZJimbwE0dD+g
	7RaLsG6XFksWkRk4LxC+PPxmRktCscbqIFUjfc4qcz/Aya477SnzIHuDqjSvn6GG1YABaxuvjIv
	mmrBC96Ns5+4swZtq3P9oDCO9FacYV5cs/Pi9SCA4ebRhFqxoOoOyYIKcplwk8sCv+OM=
X-Gm-Gg: ASbGncvTC8wyYnQF0LjDUQKsIn6lF4Aw25ZRR5FRjlRDUgv8mVpBhkZoEUnr4evzS1f
	iOflBtMZQ+8GW1JS59F2BoHVojJ1+XzeXUqbMUWJvCuhsm13HWhCR4JM9GalHISAK3G0iklvAKA
	S3iFmn7vU1mEtc3FCUi3Cyz3qSxeefRaHarnZCht/wKXr2aq79K1fmq2oCL87Kd0W5D4dEO3/sO
	kiueIs7UxBicy8ZpNOAn1t9O+ap1coLSPmhso5017C98WcNjbjxCPh1oa0kr7AcCeVrVhGZ1tW1
	84iyCbuQ9GFVIYO5zlgPDAl3OWai7h5zB6P+ivqLxLZrcKgnGpUV4Ht2P2wCaiBh4n+aX7T0mRk
	/PjV3JEAtg+ELkfiqROSGNztMex9YEgLD8W8WYc9i4AlkDgC6z0NJ
X-Received: by 2002:a05:6214:194c:b0:702:d3c8:5e1e with SMTP id 6a1803df08f44-704f66ed6c9mr162269806d6.0.1752919840441;
        Sat, 19 Jul 2025 03:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjU49TfyfGJdjzjVGo9vGtcZ/GmenE/HIfg0nrHe2DmMSEvyBaNgStXQurxKK8QsOHT7hXg==
X-Received: by 2002:a05:6214:194c:b0:702:d3c8:5e1e with SMTP id 6a1803df08f44-704f66ed6c9mr162269446d6.0.1752919839979;
        Sat, 19 Jul 2025 03:10:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac93fsm660086e87.73.2025.07.19.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:10:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:10:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Disable USB SS bus instances
 in park mode
Message-ID: <px4wsemq2jvt4si33xquy3wzv7fdi6ywp66gutn6wcfdipwyr7@3ofcjfwfoxys>
References: <20250708-topic-2290_usb-v1-1-661e70a63339@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-topic-2290_usb-v1-1-661e70a63339@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687b6f21 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=esWAiSMzqJ-acQ4o4ZkA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Z5PhHtWDI69_l2Xu3aLWRyyyVAQdcj4G
X-Proofpoint-ORIG-GUID: Z5PhHtWDI69_l2Xu3aLWRyyyVAQdcj4G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwMCBTYWx0ZWRfX4lE+u///eahQ
 t6u3GQcI3tAClVpUKvmt/Ln8GPrHhbf09pFxPhWTuUOj9/uBiYZzmfhY/Pzc8ephMwJQOO3Vwx0
 jQi4nTPkctZcCT9UjRkVuA6pvul5aWXXC0vVsLFbFNFcBcoKK0BzcgM0Lo2Iov30RRR+jzIKDd0
 mFnvtWY6CfUhnjHSTRafcfj1lL7mU8sHetPEUhLWoNu59GiXUQLXa9eGPLo+1NLeq6FO2ISg912
 mAZLP59Y6F3jXblvgezqO7HVBhNenKRIZvnMofzm8SWPc8376JlRe21WFHQOJoTLz9vPG65qJvr
 6wVT9jhGGrrls1ivDyhLrNFp2fwwUjBewRe0K9/XueoueZc8voX0LnV+Oc48Isj01hG5T0jBBp9
 S7ibK+tJnzrIzv1QR+NLkeDyb5OA+bE+lbN6YinEATXBzQtIlsIHiyfbQFldBTn9uidcGBYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190100

On Tue, Jul 08, 2025 at 12:28:42PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> 2290 was found in the field to also require this quirk, as long &
> high-bandwidth workloads (e.g. USB ethernet) are consistently able to
> crash the controller otherwise.
> 
> The same change has been made for a number of SoCs in [1], but QCM2290
> somehow escaped the list (even though the very closely related SM6115
> was there).
> 
> Upon a controller crash, the log would read:
> 
> xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
> xhci-hcd.12.auto: xHCI host controller not responding, assume dead
> xhci-hcd.12.auto: HC died; cleaning up
> 
> Add snps,parkmode-disable-ss-quirk to the DWC3 instance in order to
> prevent the aforementioned breakage.
> 
> [1] https://lore.kernel.org/all/20240704152848.3380602-1-quic_kriskura@quicinc.com/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Fixes: a64a0192b70c ("arm64: dts: qcom: Add initial QCM2290 device tree")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

