Return-Path: <linux-kernel+bounces-882652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A62C2B0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42BDB4EFA6A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420812FDC4E;
	Mon,  3 Nov 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Awt/n8xn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWuM/tjU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65D2F1FD2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165623; cv=none; b=B1rogX1jRFsh+MvaQM5esGhza3pTLG85iSV8sLLEqhfBAOHNHHGPIKSyS8Fb+UkElM7eN61uoL4+1HrI7jCndpjQUwuJP43J3HXDaPBu72nQnytvcuFdlRXrDgL3veeWkZNI2iYbvkS6+KWwdwPphpx16ScMHMlE+rPgSJc/Obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165623; c=relaxed/simple;
	bh=n/Dfft/MAkeAB+6BxFfne2SteaQNeer8smjNH/DpQD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZGpx8j9BKncvvTqZYZBvkergZjr8csycU0op8HgZRHedZP3zfoJioRDuQCRGYwdqIwa83pWGKgdH2zCeHEDPESHp7XrmGSfNSkgmB4PtHEuePV0lHYXHY6Cp/NU+jo2zj9ERhyobn8CFtCW1xsUFnfdxjarel4h6DKovLYKOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Awt/n8xn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWuM/tjU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A33DV4h1941283
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 10:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+ExXMRu1mMBxr2BM0QujC4WN
	ANkt0a9quwn/HsTTCII=; b=Awt/n8xniE5vEt+sy82mhhUmWPzymUejLDAHYNcZ
	871c60PRKC1rpQuTARESsZAmA5pdYGo8n0xchntGAH///ELPIxGDadk9ZTRRCeB6
	0tbItCrMoHn+qtGzHtMyO1KCLYvLpZNcgCKGpVmXbBAtSqTHDMPSJPcPZ0khQW2m
	YC0G0enjkSQqlSkuO180//+u/F/epiSZ7d+LppJknNQDG/yT8aoZPXxxQeAE4H0v
	jSp1HmYUPB7BMEd/A5vBFBNlPT+ImcnD0WDu/7i55ssjLo3xTcdr8GuLofjZogDo
	1+1oz5dm3cEH2ws3aO9Z79FmJDFtD+XgoL+xbdHn6v4KrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6m9w958y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:26:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2955f0b8895so15137895ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762165618; x=1762770418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ExXMRu1mMBxr2BM0QujC4WNANkt0a9quwn/HsTTCII=;
        b=fWuM/tjU/TzJHSGZGKmB89KqEp3Pl8109qlUj7vTJjHQTJxP+VKLacvoH1I8d20Qhk
         AS2cBA+pa1yhO6leQ3/tZbfeecniYG0MIDEf9l0D0hOOfxTULBvDcSJpcrHhcpV2Cz+Q
         5wGFTV+4lq/zxTTXLuOz4wxkepQ8Ab6XFC762eu6yZDwl2bv0nqaT0udfoDT1EJSDycC
         WqZypob0HwwlrbFno2pTfV0/7Aha76x2sGsbmeQI0xy7kS8k0gZiRyEvDADoTkIVL8dW
         +b9/zY2ZwPJJKES7BnxcbmNODJLq9nRcJeAtob5jKKMPkUiByNqYoLRL1fRLMgm4TGs7
         PqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165618; x=1762770418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ExXMRu1mMBxr2BM0QujC4WNANkt0a9quwn/HsTTCII=;
        b=uNbp+++j6F4tAOtoylkZzN8zuM89+cvvH2j2FxHCBwcgq0tWkzTDtPVlRluw+Pq+5J
         uHa0m5C8ONTacpYhyFFHxzXAahzl3qLX9xyFervQjWJTKOxFraTtxzMp+aHhzbh9puCo
         ubZQc6/Dc43HQsQ8cmJvJXDDv8ejgxQK8+qMs+QYm/IKHhM96X1wNVNIzIy2msWk4SXE
         jlHEhMGHVgDiImD6vJrCElZ4BzAspr9ETocvt+WEG1N4lAKC/E4DBkwEebhlRoB0XVWN
         HPHcRtO8+c7dyVNZy5R6QXe1OWpsC/RusvGcl5JtQCm6arFZdJGcfQOh2qzoepPuJnQA
         CS5w==
X-Forwarded-Encrypted: i=1; AJvYcCUzKgVwLV//8R+Kwqmuz+T84t+DfL1yQ//su/nH/2GSl+RpSQCkV3STABwPzDDYoSyL2rM0Bv/VzABstwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXpumYdHyJdEONRe8fDbIeX/cG/X2RUvc3WhhJHHLE4AcPyPH/
	U1OyV+i8wszSpGh8CIaRW+HbzkEDgYgiulRVg0NPq7DZjM+fmrXtelmELM3wzKfcpyTXsuhnJpc
	4R/cjxhrrSKzPNzcTfvEWb9eMEN/kD31RFRpRvPYCG64Ra7DuqLKCs53+1Rxjx/RuKBU=
X-Gm-Gg: ASbGncsUIXdpUhNmsTu4O4lp5jJYQaDBeAycH09pDS1d2EDBD0oGN3TtEfkaLLqqXAg
	Xj69D+UPnh73jvgHsnPCjA0fcEDzkdBoKMd+Bnk+z4WW/K9uiv1azFo7p1wVMAimI4WSQUfZXnd
	QsRzKYEjgyhC1BNeNLX0lljqblidNAnXZPYptMxNtqVylu1fs7fAMzntG1iMYdcWIA1riuX6Qan
	LmDAN6G3G2DqV9TooSnA07KULQI3aWH5GNv/KyuekRlRb7Y5B5u06DIXdrHKDpM7GdrCizYiQyx
	YBW74hSJm6MOM4Ts6IYp/o80ZmDcEi0XB01GLfaNQqPC2b6KmmejgHw77Ntm+0Ja9vedtTpiMEB
	6U5hgFC8R8m2h3fNBy+qE5Xdurr2Cjv9TzPYiKtYYcaWdYvDP9yjLy2Fcsoqo
X-Received: by 2002:a17:902:e891:b0:283:f19a:bffe with SMTP id d9443c01a7336-29517c139f8mr136573955ad.7.1762165618010;
        Mon, 03 Nov 2025 02:26:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHl8PzNdvmAfsI85/AXd34oe/oVyT+QEtcLTRH7dCtBcoW6SW29TRgha7wJLskZuOl2a19XA==
X-Received: by 2002:a17:902:e891:b0:283:f19a:bffe with SMTP id d9443c01a7336-29517c139f8mr136573725ad.7.1762165617472;
        Mon, 03 Nov 2025 02:26:57 -0800 (PST)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526870fb4sm113687675ad.15.2025.11.03.02.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:26:56 -0800 (PST)
Date: Mon, 3 Nov 2025 15:56:51 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
Message-ID: <20251103102651.ywxi7lqljsmjg7an@hu-kamalw-hyd.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
 <09b2ee28-ee2b-46a8-b273-110fb0b4d8a7@oss.qualcomm.com>
 <064d2a33-22e7-446e-9831-a390510698cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064d2a33-22e7-446e-9831-a390510698cc@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P7Q3RyAu c=1 sm=1 tr=0 ts=69088373 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Bu4QGwSr4GsGjTdf-dQA:9 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 9MNmg97UQbewC1P1RqrAHkgowCjtmMEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NSBTYWx0ZWRfXy2y2JiG/2zNO
 baiofRgw81xSOPkXdalTBG8lsrdzVraQRhzk24WbWiD7oxNu03VQi3av0aXLH+31BwXBGgi3Kc+
 T9zoKEjrIiwJaakkT/1NJQgxqkNOAb+n6BMI3Gpf4iJefItjj7NV7RPc40UbkAvvPRS0zPnNZGO
 sz6h+3CoymT+/DuBDtjqGJHYcHP8nrc4D20fAdsg/EogNCofKswsidZybU6A9kusYBCFrLEYYmw
 UXe+G9Cr8jdZv3h6Tbth87XhhEzDAx7lRGGxM0+ZlDGq/WfIhdDjhdspUUwwuqw4cbTUJCaGXD4
 KfNsQ8iMD19HAXwbIv0SuRr7sKQMs2Qe3fJ7/mRjsdtLr8ibi9In2ohuQWC54glkXr2iCebtXHh
 17EoibxDbneqEG3VC1nXqDoAm3V1mw==
X-Proofpoint-ORIG-GUID: 9MNmg97UQbewC1P1RqrAHkgowCjtmMEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030095

On Wed, Oct 08, 2025 at 05:25:39PM +0530, Pankaj Patil wrote:
> On 9/25/2025 4:02 PM, Konrad Dybcio wrote:
> > On 9/25/25 8:32 AM, Pankaj Patil wrote:
> >> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >>
> >> Add the pmic glink node with connectors.
> >>
> >> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 28 ++++++++++++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> >> index b04c0ed28468620673237fffb4013adacc7ef7ba..3f94bdf8b3ccfdff182005d67b8b3f84f956a430 100644
> >> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> >> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> >> @@ -79,6 +79,34 @@ key-volume-up {
> >>  			wakeup-source;
> >>  		};
> >>  	};
> >> +
> >> +	pmic-glink {
> >> +		compatible = "qcom,sm8550-pmic-glink",
> > You *must* include a glymur compatible
> >
> >> +			     "qcom,pmic-glink";
> > Are you sure this is still compatible with 8550 after this
> > series landed?
> >
> > https://lore.kernel.org/linux-arm-msm/20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com/

Sorry for late reply, earlier when we were sending this series our understanding
was that we only need to support for usb shell, and anyway the device was on the
debug board so this feature(battery/charging) was not tested.

However, after testing i found that the power supplies are getting registered
properly however the data is not coming as expected. we are working to fix this
internally from the firmware guys.

Is it ok to just enable the UCSI (usb shell) and enable the battery feature
later?

> >
> > Konrad
> 
> I'll check and add a glymur compatible in next revision

NOTE: glymur dt bindings with the compatible change has been posted.
https://lore.kernel.org/all/20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com/

> 

