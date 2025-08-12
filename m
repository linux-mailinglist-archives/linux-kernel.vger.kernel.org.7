Return-Path: <linux-kernel+bounces-764607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2594B2250F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA881AA70AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345C2EBDD5;
	Tue, 12 Aug 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQxRcwv/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7822EBDE8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996122; cv=none; b=mF6f2LJUBKJHR2zELnRrPw7Hnm31QDTy2TXAhJofrlYpVNqqq64UnAjtBOZmQSqKaz1SwimpnVNHj4GlU9PXknaLrf5dArhkyuyH36Ee7az16RTCQpwb5UO1CrwUguqi6JVE5lwZ2kWMj2cj65WxOHPDermB2v55+0ch9XuiZ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996122; c=relaxed/simple;
	bh=Pj8Bgqn/mXPWbTZeeeQ/TfBZEKt2UzEfDdrBFxMjh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP4CtT1C2K1pGdtg2utVYgVoLEh4kOsxjIz6qH+nT3Yz+7yCs79Xnsn/8lk7FNM4/54+ApOnXHzt7Bwfpr+U0gaaajwxIK/t2efSVXvUrGeaxbehIwYbS9MpcruFllO76qcpC2vKtA1CJMgCyHT6Yo23Up2hQbAytYl6xlFghEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FQxRcwv/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5ZLKB018342
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0t0Mj4fJK1eduZrrGo955CBD
	djHdqYbc7uk+hDghtMI=; b=FQxRcwv/Jtq65zYoMJp1XXGg99XP5yZw44pjw5X4
	okbeZ3Wr3iwqmISso1e0lE0U6fkUucuxT4PQWUqchm2aZKu1BHsMppmg5ePGZJ/e
	3T/Xa+FSocO/y+idJUIKmHzkouxHiDEBL7H7s69grwHW9Sqj6kGd13A6E7jTXxms
	c9fXUr5iunJ+wgxQnfvmwtppHSMEvKfnV/lm9OLguD1foB6cEgJVZ2SJeOCJ5BFA
	5lwmW9IVkZoHEFHY9liXSqJONTJdZWGV0bCHfQCk1mIhUYkMtUS4JZjGwF6I5NVB
	fabFvDexyPnW1ZAJcqWplY2agMO31rmyvRTM7opr+gUdTA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g7stm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:55:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7075d48a15bso104650936d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754996119; x=1755600919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0t0Mj4fJK1eduZrrGo955CBDdjHdqYbc7uk+hDghtMI=;
        b=o2hl/fF4LbpqU1On8tUsZ81vt+dckDnkcltLGQgdunYWkB9e2uiG4zrK2664R3mm/S
         g8UIK+yj/QMCWkSwaZGKmljXRWoCu1ebPELPCRObttWECI/vK+zuaBiWLUZnRm6Qi8zC
         xaGzZu/e0RRV3l5fVnYX44TKLJgc0jKTJchBQgnjfkJxPuvv5OiHnxLHwgZdO1eiBDzd
         0ORFt/0YpvTGUtliNXfWfpql/MNAvk0h553lPj+QJvGXN408ACKGUoZ0VIcY+uRb6pP/
         nSUygk4Ol5rNdQCV2p9o6ZzhVyt8e/kjP4VUYaP2cZV5Z0ab+qm17GnpasZOEfPGtukC
         yd4w==
X-Forwarded-Encrypted: i=1; AJvYcCUW1XFoKihQZIZkRIxA4izjebLw6A5Y6oJoi7iQe6RO+3DSiwUf4TWAC7ilrKdfAqbHHoWaevwKduaFJBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/HQeHlZZ6eeGJFaLfkSn95OyG0dGLE7UVGmyP/7bgszLb5rV
	6Vn20gMkYI9rOoutl7UPmsvH5dpKtqKmrxmIXp7xNiuBQ8pHijL3uTvrtlUoylzvY/gplYrbWV8
	BwPLl7N+YRvysukJB04Wa5gLCjOG5DpEK3fJntlstwzeAcmeVYR6Kc0dukClexBr3S/Opmkny+t
	Q=
X-Gm-Gg: ASbGncvPkma0RKGrsf4UfW+qSLyok+uWzWBftMiQqYzP2bbPXMSVOwJCttuShf24uRh
	qKc7lC8ntVqF5GS0qw0lRJSsbwwsYq6DEAMk5RI+t88+53Sz+nSNysPvMIbaeCsvcZsewKTCDot
	DhM/cE9pkBD22JfF3L6VA8qk3JvIuPt+U1fP8SJN5d20i7AwvEZRRF3npB1Y0JyrhTZEc0jsmUj
	JJEVUoUz4r0bxltcck0QlkyxqYInXMUIeitPmj0H2Bc969bgiIU67IpSsvYZlvIN0q8cL45batE
	Du3BetVkrNzi6Wont+xKTgXLTeEyu7EFEl8f/9NeXOjrHmLT05Nzzsn33UlCSOZIedPjbIOQ3bv
	qnpSCRZE389FT7/syOtf9z80jaBOwKAHi53FwbKrxCZQl2f46NXSf
X-Received: by 2002:a05:6214:2aaf:b0:707:49ae:cd47 with SMTP id 6a1803df08f44-7099a332e69mr182468586d6.30.1754996118934;
        Tue, 12 Aug 2025 03:55:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdkhFnmwSU74jKtHq9bp9+uokwPAB0k/r84R0m1BGkqTHSLqHpUTQQ7XgYD2WVUetchlW7gw==
X-Received: by 2002:a05:6214:2aaf:b0:707:49ae:cd47 with SMTP id 6a1803df08f44-7099a332e69mr182468246d6.30.1754996118482;
        Tue, 12 Aug 2025 03:55:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cce15c5casm1342803e87.112.2025.08.12.03.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:55:16 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:55:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, mani@kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, agross@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] arm64: dts: qcom: sm8650: Enable MCQ support for
 UFS controller
Message-ID: <27qmlr3lie54lyigl5v434yzvbes5twy6zgtkqb52ycfh23vsp@zdg57ifh7kog>
References: <20250811143139.16422-1-quic_rdwivedi@quicinc.com>
 <20250811143139.16422-3-quic_rdwivedi@quicinc.com>
 <67aedb2a-3ccc-4440-b2ff-b3dbedf5e25c@kernel.org>
 <9ff100b4-a3a5-4364-8172-1ccb5566e50c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff100b4-a3a5-4364-8172-1ccb5566e50c@quicinc.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b1d98 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VZigEyOcwVUUxk4fBhcA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXw15bIahckwHt
 l2ZkaTrR7GrGsAFA5EGjCdEQBJpttnd7dyTTDus5XByU8w6u7OskkL+bb9+i7nkZ5/1ewI/fsRI
 WQlkO+Nx/Jt1YSZuIAWWbjQSiS9G0UlwUzx8J4U16uhd6b0aSfHZWb8+DN3LxAAsOuKPxdvEP6e
 mB+pjNYtdG7pewx6jDfy24jFRh6np/qHerhXkKjvlCiAdvKGlO9g3mTz9oCsqB3mQDqWlnG8skB
 6BxaoR8Q0QOU6BCRBQc7jKcNwugf8AwElNsSPMewZJNlIrxXTys6XKAmtDKaNm+VJar5l2lvhEO
 WYMdgYDP3grqyzl1ZZRinHiVRVOk3skUwER5keX96OLZx9egl9Sc2xe3DSA+wRU6dKE0qlAgJfu
 UHcGSiIL
X-Proofpoint-GUID: V4XEGnrapKb9ib28gibhQ_7Zm4afRoQ-
X-Proofpoint-ORIG-GUID: V4XEGnrapKb9ib28gibhQ_7Zm4afRoQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On Mon, Aug 11, 2025 at 10:24:29PM +0530, Ram Kumar Dwivedi wrote:
> 
> 
> On 11-Aug-25 8:13 PM, Krzysztof Kozlowski wrote:
> > On 11/08/2025 16:31, Ram Kumar Dwivedi wrote:
> >> Enable Multi-Circular Queue (MCQ) support for the UFS host controller
> >> on the Qualcomm SM8650 platform by updating the device tree node. This
> >> includes adding new register region for MCQ and specifying the MSI parent
> >> required for MCQ operation.
> >>
> >> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > Way you organize your patchset is confusing. Why DTS is in the middle?
> > It suggests dependency and this would be strong objection from me.
> 
> Hi Krzysztof,
> 
> My current patch submission order is as follows:
> 
> 1.DT binding
> 2.Device tree
> 3.Driver changes
> 
> Please let me know if you'd prefer to rearrange the order and place the driver patch in the middle.

THe recommended way is opposite:

- DT bindings
- Driver changes
- DT changes

This lets maintainers to pick up their parts with less troubles.

> 
> 
> Regards,
> Ram
> > 
> > Please read carefully writing bindings, submitting patches in DT and SoC
> > maintainer profile.
> > 
> > Best regards,
> > Krzysztof
> 

-- 
With best wishes
Dmitry

