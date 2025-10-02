Return-Path: <linux-kernel+bounces-839808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73FBB2783
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 06:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F513B4C42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 04:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E712DC772;
	Thu,  2 Oct 2025 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmS+2Auk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1F2DC335
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759377833; cv=none; b=P8UZj6eDrVAtk/R0Nh1aA1652BVHYbJvf4iNxgOfvwvGR9t0arIrDY61ZWP0U87P4e4oWm27h8CCHf0XUww2dlzlFTxi9xNwDLYEqQz6W6aHS4ADAJL4sWIBut6JiY+RtsZzSMayR89xKyN0tS9eKM2z5R/wnV3mPUWujfk2EIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759377833; c=relaxed/simple;
	bh=+kpouLBH3+i3L9bCw5lRcIZ8dux1NxH241oSpMjEftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfceW+Z1SJUT/4YfcSnUjWC9TXc+517D5mwJwSWuvFCLISCboMrQGZhgeWWLb77QbtNdL5b0Wy1YuW4Tx+3bgVEQC6CVrTAzV/miEd4jAzy0xVu4c8QlnTn4cyHHPf6hN/bgnrlcWtXWTacQD3F+bQr2vGgB1qb9fNAosAMKVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nmS+2Auk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcAvY023589
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 04:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vDEXMrZyI5DjkHRHF3nr0kxs
	P51hoP/2gaSxVHUCc9Q=; b=nmS+2AukrkY+m+RurA3EtNGV2FGFou88PLYeG8bd
	AfyL6ZpDTBu/diSPVJvZE1BEXGNnGJLOvtpsZv8GZ8pTFDnpUINPxRmOwfFyJrXn
	3Ek6K7RqFgWZNLxs/DHyicv0O2B3IuTMkBxc06bHGKgLFwCnXv2d/8J4lkvSbFW3
	IrqpgfXHmYvAX0s6i1a9jnWHDR2EwTL8q3mEzsm02SM2l0NIapiXMOsW00tUusmm
	QfljbzctBgRPieRVRT1+p35OaphTZD95sfOvkyWzk6KuicYA6LYNi1/XiF9Qn+KT
	mA76i/QDwh2Pv588pcYn58+SyMTz38C+51aOBgGG8eVcHw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a66n2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:03:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d9ec6e592bso11478901cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 21:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759377830; x=1759982630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDEXMrZyI5DjkHRHF3nr0kxsP51hoP/2gaSxVHUCc9Q=;
        b=jwtqmkA2xZpy5GXKN80cEKhp6GonuQwCqFny3VFjigZSaogWzSrbUdSLFyfceEDfW2
         HTqIreOwIkgLWXUwUGIYUl5xJC4lS2jR7aMP65gvcjsWn2sIj2VArEQrsjPXJlOgRjzJ
         /wXBzvs7t+0h7/xVbafics71mtDtKLDXv6VmpfANjivkmRHCatlf8W/CgJ80zEb+dS0C
         XCBpIRoKTB0jEgHP3DSpph32sTxFH77wBVUvxLYcuw7pK8cntG2sMcdD5az+Xu4tyOMB
         PUgaid6qDKYFc1Wt3F6xhB2x2gRVq/sw4Mj/4hPlk7tpgkYSsJHIYOx7Hc2eg1Z4o8kQ
         aLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5SNeODO4nABsLe7wgjUmijK2p6GJPwJ/58ikQIRbe+tyT8MPH5XyMO5sPiBcnRpfL4l2/UFMmfpx2lgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhPgfrTlGExxGspgp/SPDGd2Oo0l0vpTk0GmFI/H8nglztS+R
	yZm8L9gYSb3GDUrEwkQ0r7zzVkvkCFFYFfiDkgkMJ56oGDpG7N+ffgAAgvNsMl9SRI1OcMCAStA
	kcCC8DlUKFhZ/87fqe9cBzCSV9nhq1mhEvkAT+X1Hx/5EATa0Qr14fsn4AXP4R9API/M=
X-Gm-Gg: ASbGncsuz/gV6cjk/o6uJc26+WqcQbUHZEWoNK7qI1jKX5qiPP412/H1Ik5W89voYLQ
	73X6d/+T8ZBb1WYfObCySlBVxyYeH6IveytA2PnJ56PwVBekKJ4g9oOyixxKhm3OqtwjMF4RZWy
	T6tmpyYqwG2e7zPJxH7HK8TdCyCutR4Z/UZvH+p5KluDmnrVzMPdPoHoM3YpAHAcYM/MOxFDBm8
	G6BQiDyszCPFvFP/Q1LuanKCzQszOs5k6mMfvOY3CjvBgX8jTpWXW5jsnnBhnNjPE4CsJiqrsx5
	hgeTdgHxMIVflcAqIGF+72dZ+qLqH5kWTcq0QRIxaPVzfpm5g2s4aa+N5mXZLyhJ1qxicaNw8IS
	jdR3zoI1CZVmIKTYp+JdfpMDKV99HwBU2gVcjz4G199Ki9BMdKgksZWLHyA==
X-Received: by 2002:ac8:5fd1:0:b0:4bd:3e4b:ba5e with SMTP id d75a77b69052e-4e41dc7e96cmr73704391cf.48.1759377829762;
        Wed, 01 Oct 2025 21:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdRnA3NDBk05T82OdZV3hs33TJ4DX6PASBWRlUSILv290R6xNtY8dpoH23pG+GAI9V2WH+nw==
X-Received: by 2002:ac8:5fd1:0:b0:4bd:3e4b:ba5e with SMTP id d75a77b69052e-4e41dc7e96cmr73704141cf.48.1759377829292;
        Wed, 01 Oct 2025 21:03:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d3dbsm441304e87.65.2025.10.01.21.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 21:03:48 -0700 (PDT)
Date: Thu, 2 Oct 2025 07:03:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: qcm6490-fairphone-fp5: Use correct
 compatible for audiocc
Message-ID: <r2spjuu6yaz25ujrr6q5xli6dwjh4fh7vhx52ldsprbibxgcji@rhbhwupqhciw>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
 <20250930-sc7280-dts-misc-v1-3-5a45923ef705@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-sc7280-dts-misc-v1-3-5a45923ef705@fairphone.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68ddf9a6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=ZWl6vx9Q9smWLlo6MzwA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: iuNmKZ5JjYuXNcZmHw3Xe2aRhauI5hfY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX0PjFzQc6xnoA
 pBzaCm/ymp7Pbr57tiLBJoI/TbO3gPexKfWbjkWQipI7/gXGQwhy6nGMNsNZirY+MgsjLxskncH
 wHNlZ6wUbE3n6iSvdTHxn5Wfi/gDDWcBNy3fg7TLiFY/bQpLNW4YSfWED8gFbXuo9FGJxshV9us
 efMLN0fSgbPJqzhFhbIOU9y+3KZkmhGwy27S5oqIJvDri1+coo8AxnXWg4/pKlpHoRd8DSNwB2V
 vm0lY9jQgTlNXmx+hjqZZ2Uuy1Cj9ovgYRPxXWQU7T//8O16c8nkxIPAomduahpYyOPr/IjsikS
 /nJ6SmFX6EA9I0uREWdgeKvfPSAN0MHGuRlhXbZ/veDglBcgae62AIqLevxaaFFEeVTqi/JzvHB
 bWq8+ZyE5QLYo6jEfr2sQVLZWOZGLw==
X-Proofpoint-ORIG-GUID: iuNmKZ5JjYuXNcZmHw3Xe2aRhauI5hfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Tue, Sep 30, 2025 at 03:57:03PM +0200, Luca Weiss wrote:
> Use the correct compatible for this phone with standard Qualcomm
> firmware and remove references to power-domains from a 'reserved' node.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

