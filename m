Return-Path: <linux-kernel+bounces-801552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E5BB44687
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26104584134
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEAD2727F2;
	Thu,  4 Sep 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlg3M5QX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD71E7C03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014642; cv=none; b=ubHTzxax/3lTXvrtngdZeCeo8JdZuVS8Rm7dfML5A3R6PgucOw0WonTQFrstahML/U7gulKpmfk+E//rqFOTBKyga7ZH1jtMcLWgvaxx7qHzZlVIDTX0VciMHFzW9u+rJDQWHWR3T3lritHsz1XBgwiCYWD9vv64ici7KvF1Xrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014642; c=relaxed/simple;
	bh=1zQV/s94K5+h1YGZQMxFS9OiOGoj2u4JLZMij034Jf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fko5x1m40MpDGvBAH9TMI8PMVZWm3JvP47N5zGXDFlxMd0/xAc3rHyLK0PJLsor3rC/mkjsZYOhv/4GQqNErGMII12vwgu5Jd07dOJuXkDyCGOQkydCzoOlNH4P6i4faXMkXr41GMl2dxKrF3RGAq8z1o7DIix+O7ahvpYNEPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlg3M5QX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JAUWk012111
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 19:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=McF2iXJTB0tw0p4n9n5WkRjm
	CGCLSHcRJu0PgH1a76w=; b=jlg3M5QXeLWp6cVDKBdqs6MOn5pkhdF00WH6DkWT
	hHmjLm8bkq10x6uamdNnRlTgwxF+viCZ3Huv5/2qTt82Fr2AiOWVDnLdSWD0U20d
	l3N2s6AQvK0U7i2ayG5jxamGjaqqKzRxxAX1V77hhS1lGpy8kB2vOm7+u2nwKdLP
	dY3nZYSxG5/aI9ghuT81Nr5pTiGdhcmFVTM3Ltiq/3Sn6K7tQLWpMN3gxhhoE7Fu
	rxt8nm/FQTVy00djexljCwo3be0iqspg+bn0c/7WhVei4VDHAT+c0UzAy6jwBKB6
	B4NkLGp/mR4Hcg+7Gg2CQZaEeYKyZejXI61LeW81UoHwKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj550d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 19:37:18 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4f738792b0so1722926a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014638; x=1757619438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McF2iXJTB0tw0p4n9n5WkRjmCGCLSHcRJu0PgH1a76w=;
        b=MGPUZ5EoFnbgywiILXLZ+Q/iBUbq9d5m5Hqe5dV0EaQFpvZEtgk9wcxv7g2sEy0MzB
         Yv3Jtbm1MpcHtPK10cY25N/W+G3lI9PiPx/Nex20+4rga2XD24mM6050JIaoFyFvzv2R
         oeEQEU+az/aJS1MTSom5Ub9GraDp7jYJ0e02Oq75o2XlMxVyP+AnO0748LC8AefvEY0X
         lqFPiFbmRz+6aFybl/3nN6sdAkioN4vbJX/DBqWH6/4V5xHmDdVQ8O4aZSVxZmEObAeV
         7HAE6qOgT4OA/lXuqcw28s99OVId4uvoBwRzopF9SyaiDF/KddmUNwPEADC4Jirl0hss
         q3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXo/6MpxnTfAl0ChsVsNMwYWcgf03FYhL4tbzOmAaEJ3c8OUlyT4Pv7KazmkA5HIUuzOy71kOWYSfvLVjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOK8I8CQw6CKP7m4WAFMwxqtk0sGamd1MZnDgnOFm5f5E4B0P
	AQpO/MuUiCR5s+Xq47fhtp6RA635WUTT/iAGahYSl7R33mWxPw6EjbSMrQO2EKtO2yp3/qL2+Rl
	BnFJQnbNBfGPF+gDo5796hefBxflyeVqFQIe5FoeVKL941SmjWmVTX2hK+KvMSsHmn3o=
X-Gm-Gg: ASbGncvjEnN5Mgf89vhVBOF87mz5rBLV7BwjqvPkI3sdKGjzlmS3YeJiMPmOhqShPUG
	oLIV5jFdKuFUjFg7jWfCrSNhscvLTsA756n/K6IGBecirnnFADM0jt7J/ILnQMRqfRUUp96dPXm
	CELpUCuWgT4IvF6bi+SibfS4OH8GNFDYeJfwzHUxDHvMvc3iHMQ4smy1ycK3MvfbRx6DQGRluHV
	yrNE++eyN/wCwrTIbo3/WK2MasXyxrd8KCoVnXxuqGY6LQRaU+PzzA2pDgfWrj48hJWsacg/bm2
	mwv2cSePMTqhsJ/X4gId5AFpGKraO2ONUlXLZLeMyPttyPp5AwoyUxLdcnEfSBTJWTxT
X-Received: by 2002:a17:903:ac3:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-24ce9b57ba6mr14192405ad.50.1757014637694;
        Thu, 04 Sep 2025 12:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8wfQGHYpfVwabKJx2d0rjdTjkyrNxzu2OZBEviz2cswh6mp15XKTFFB6XMS1SDaXgiS2CFg==
X-Received: by 2002:a17:903:ac3:b0:24c:a269:b6d7 with SMTP id d9443c01a7336-24ce9b57ba6mr14192115ad.50.1757014637195;
        Thu, 04 Sep 2025 12:37:17 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd655823sm20856515ad.114.2025.09.04.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:37:16 -0700 (PDT)
Date: Fri, 5 Sep 2025 01:07:10 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
 <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX7Y51ofIkNIPU
 8xnD46AW8MGFV7iq/8noPJNg0118byiGgJP9bfKBR9Ryw4uorosKRzNf8Oixv2dJyh785AuleYB
 d8thluNMMSH+0VXbGs7Ye/vZmMw3XpU+KJXdUuAAC8sYQWgHhLsIGlhNhPaORMOQO8E41BrHIxl
 JMMyNkb/dSQKX2swlF4NEKdRYzOBligfyJTXXrVSAyuQYXdnvY2z48ifeId3xLa1LXu8QtE0EUZ
 3KUZQO4pjx9mWRuyOJP8z0Ow8C8hVSWbp6kbQ7mwsvWwLXRIXrED+w8Sd4LC/KvtyqVs8nIrCKi
 HczA4ZxNgkk+wn5z2ZIBiIqc/W44G2mq1lX/uMUEpoZ+ZiipFdXXL+bS56ksDWTBqVj8X1EziNi
 i2PHaY3c
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b9ea6e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IAxE5SYkeMM4qmkgMe8A:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: a4X_Cf1FLsEOh-iy10iSA64zmu-33HFm
X-Proofpoint-ORIG-GUID: a4X_Cf1FLsEOh-iy10iSA64zmu-33HFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On Thu, Sep 04, 2025 at 07:43:27PM +0300, Dmitry Baryshkov wrote:
> On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> > Add the compatible for 256Kb EEPROM from Giantec.
> 
> Why? Don't describe the change, describe the reason for the change.
> 

Let me know if this properly describe the reason:

---
dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C

The gt24c256c is another 24c256 compatible EEPROM, and does not
follow the generic name matching, so add a separate compatible for it.
This ensures accurate device-tree representation and enables proper
kernel support for systems using this part.
---

> > 
> > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > index 0ac68646c077..50af7ccf6e21 100644
> > --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > @@ -143,6 +143,7 @@ properties:
> >            - const: atmel,24c128
> >        - items:
> >            - enum:
> > +              - giantec,gt24c256c
> >                - puya,p24c256c
> >            - const: atmel,24c256
> >        - items:
> > 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
Regards,
Wasim

