Return-Path: <linux-kernel+bounces-817356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF10B5812B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99BB1884D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3A21B918;
	Mon, 15 Sep 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xzjd8Ew7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B514281ACA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950927; cv=none; b=i+1Q4jahkqCVUAQqaXMJoDOXsaB/ltoxll/gHNJwb5q9MrfYm7AUJduoPTw3/CkM6W3gtlvejnjH3sK64GfRX8rE+5357us2DbAAKlD/hrwGykbRt9liTZYJRY4wbeZGPYGQJP2gbHa59ePh1FwilqToQf+xXi+9+5DXK80uQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950927; c=relaxed/simple;
	bh=1e4bIOCBVdl+jeIf4XWL1Y/bbYePYVs545U3st/e9EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROcOM2OPgFraihuol/avOZxqsaqc23EUZtUISe5xgZu+o3oPLsQZk558WTaxs8tm9zGwIR+7g+aQTVfVMDZFJm/1riI2FkmeSTa0ZfSJFtXJqUTEpe1ZiDr1Hb0gXAR/pSfWkYoTPtn7gugD84RPePLvVsRHVx25EkHN6oEWFm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xzjd8Ew7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEBMwg031662
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Yld33n/hK15mRUGi2Q71KLZp
	QJLuSiRlG6PkHTx8TFc=; b=Xzjd8Ew7sSO3R2s3TIBuxL3z97OkcusbBPrfLpiM
	WqPEE8Ol2LKAG/pwy6OSr42q0diUHdrgfHeULnKp34/2sHksUUs320fSUDiJ79LE
	7NB14I4iMwtd4QMjGBFdNric8n+riFrmOP/aPuZjI8DltAQheoHdA8BK1fHkNmew
	Gl7m+0OQUu6oqfgX4+FXknYd0It+pUn2RQ8fRX3JhEPDrHllqSzwMADF+YypC6yB
	bZeUA6n+kK1V6zjVURbRX2IGSjI0qCpbxZTl97UaJzkrA3DanpVqHmRv8SH4b7Jb
	M3p/R3pLPU6dHGx6ciohHN45qHRekXi5eebKIipgLI0r6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma5j37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:42:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77618a8212cso2664006b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950923; x=1758555723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yld33n/hK15mRUGi2Q71KLZpQJLuSiRlG6PkHTx8TFc=;
        b=N4moge0zhA0SFHaDro/ZjEHCBiFHBLCe36xKd4wDr+JgAyLd8v86yslflrMCHpdgnq
         jsbCmtdDp1gOZ7xiTu9F8b0gPvyhqYOM9+xQX1AEuNFMnsKowQ3yjxgdJtdD3q7lVk+R
         UM+DeYeMdeo+Tbi4dCI7B0Pbrn3G0HkILN48PJZp/YCneJUKGc70wVSGUQVoHIr1IzCc
         TE0iLFkHPM9mim+jV3AOnEZ0c+qfdVShqC/Jao0wXIbpFCykAT4kTzq8RlmkQXRjH5in
         E0hCdIC10Wsi3eg8i5XIGa0a8SYea2C3c3ranhN3OQj2S7EZDFZE0o3WvvfmqNfCYrCT
         56Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6zd8pGEh6IsH0TdcggeFrumaw3L47slwOnLODVxUfbiYUEa2ue6tdBv2wWg0YwVwnZSGNdNTqTXxcyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnkLRkhuDYixBvC7ENUzuZi466ige5EL/OQalYFAG/fy0OIPMG
	aRaGagqY+QzFaxUmwn8/uNggV+Ss1qRvD0SlrLNqu7CFjtG9AQ/vKGwl15DRl4qq/L2ZPRT2+DS
	/UUj5+YbreGGDspvsmhfVYHWEWOv47+gGysRhjy7v8sZBvaUUY4S85c6qA39Hm7fRn5o=
X-Gm-Gg: ASbGncvuA+SEvNI9SYrPpuwirCYZmGbw5G3AJ+L7IZl1UsancLDm6/NU0cXtXNHNx60
	ZMKo/bb3qFDxcjQfkjcJd5IB/qkQeuQQ5Mo2JPZX91S7M6HfR2x6Q5Z3cQK6RnR4PggJN85MF3w
	MLwxyoSxbclRfdqPjKdrsMOFhZi/bCtalPDpTotTHL8D4Hmc6BBv6iH0jhtkIsVacZ1oDviHVZ3
	7BpBd5Dl41esWEeEjMHQ9gq22HVkHZCQAyiErUbMA86ofVd6gU9yu4utI9pX1/FWQG2mPKT2uiY
	ZN/J4gNH3p8QF64GXxUXA9OwqgwkECEXRsxczm9AuHJvobYEVTMJmg==
X-Received: by 2002:a05:6a20:a128:b0:25b:b4d0:1090 with SMTP id adf61e73a8af0-25d0a3e47a0mr24315572637.17.1757950923266;
        Mon, 15 Sep 2025 08:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtjFVP/FOMnmk7GocafR4hVVB8WkOx3tu07Yk9SEd1JMeAtFhjAi2UPwuAZVhkwKq2woilPg==
X-Received: by 2002:a05:6a20:a128:b0:25b:b4d0:1090 with SMTP id adf61e73a8af0-25d0a3e47a0mr24315541637.17.1757950922804;
        Mon, 15 Sep 2025 08:42:02 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b483sm12195692a12.30.2025.09.15.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:42:02 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:11:57 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qcom: qca808x: Add .get_rate_matching
 support
Message-ID: <aMgzxQQEUOijmafZ@oss.qualcomm.com>
References: <20250914-qca808x_rate_match-v1-1-0f9e6a331c3b@oss.qualcomm.com>
 <aMcFHGa1zNFyFUeh@shell.armlinux.org.uk>
 <aMfUiBe9gdEAuySZ@oss.qualcomm.com>
 <aMgCA13MhTnG80_V@shell.armlinux.org.uk>
 <aMgootkPQ/GcdiXX@oss.qualcomm.com>
 <aMgsiDS5tFeqJsKD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMgsiDS5tFeqJsKD@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX3TpfllTLb3yX
 c1Xo+d3sSWCtbj+4Sjj32uahi7JcCkycnO+fWT163OfTPKjoFfBa/65Tf0Uq7W/RtxGbOy+eBYM
 o7RL5aIRtaR8y63a4Hk6MFdA/eDmUD3mFkKJ3eZhDL3zejsqvXQWPk7glaozbMRHeEm0pAf8/UB
 vvSVgvVPd2ANEf/oX5YmlYJj5OVkjrXw0AANxu2hPWJsA+ZKXYefYT2eL211dcUPQs8WdRq4QP4
 taMgE4i16TIcdsLK8LDiagISR1Uw5H7mWFSNeDtuzooV/2T3MqGJYE+a8Od3l6NEqTFCase34NN
 6E/rjSwGtxoseuMQv5H+B3uwVWceeJIuwWau1NFUc+HA1Ch6V88oMtvWDITVuGRhy1YmcLNnCCj
 8AiVTxj1
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c833cc cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=tLy6ouFqhY7wmLPyIyMA:9
 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: Xt5X0SFf4Zpce_GVY-hDZG_SkZ5lAb2L
X-Proofpoint-GUID: Xt5X0SFf4Zpce_GVY-hDZG_SkZ5lAb2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Mon, Sep 15, 2025 at 04:11:04PM +0100, Russell King (Oracle) wrote:
> I'll try to post the stmmac PCS cleanup series in the coming few
> days, and it would be useful if you could give it whatever
> testing you can.

Sure, sounds good.

FWIW, I tested out a dirty version of the `.get_interfaces` change I
metioned before and could validate both 1G and 2.5G.

	Ayaan

