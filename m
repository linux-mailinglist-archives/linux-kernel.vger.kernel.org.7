Return-Path: <linux-kernel+bounces-798808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED2B42339
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B9F1A86E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55433101D5;
	Wed,  3 Sep 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UI7NxD6+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AC302CB3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908701; cv=none; b=TWQ3GGGMIJCpl5NlePFR8E2ayJL6Np8lFhvzt17F1L3WxbOUTRuy1VNwaizCQeAw7VgFetd9aszWjSNKaRM1W4iVvKu98+3dZSRxVZcx6YHEDelMRaxzjE0RAeTVn2+2KTQBryRX5l1PJCBA9ezdpFwa6ehyhX7t2x6H9YqInPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908701; c=relaxed/simple;
	bh=54Lc1RXv/PBEmC75zaShg0TPfNoapxkuBuXgBpJtgrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TF4ScpEG9FtmdD8GFomKvrQZgmJ9PsPnaGZY0e+m6fdOGg2UQmm1DPIBUSNKsmiUUR7i0ylz0TYXGq99vP+PiE3klbN9jyyiDtl8y+5ngQqq+kTAlnd6Ni/ljO/Njkjjj5NsehP3MO0Z6WEMIsi7mkULTnpxytRfSDGTyzLOZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UI7NxD6+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx2dT019832
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 14:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VKt6Z8VLaY/h+/FgT4fSGVZAXoNNB+wOFS858h7LM8s=; b=UI7NxD6+b5dQPj4z
	tfnnrWIbZm9enboL1VOsEm5GbZh5HSotJIpQAduMFTQKRabvNErA5E6BhLoPb3wr
	kurthkE+W53N5/J1hs+IkryVrboDEe6OOKgb9ivrIrFN2653a45kItfax6kKCwwZ
	nMRulRK/Uv2rmIYBJmOuH6S5IgzR6kHlHNPmsMks+Wu6CKA48mz0uK2YKehp7CDi
	1BBlygpBw8AH2+pL23x5fWfJxn3B6yRqwnPVLCuTYdRlcZe5LvKCChiXKphS5FHO
	Lyp2PhQy+ycNsRMHvYeZj+dOuMrT12sS4F9AI/yWsYiaHZBsiX3c60RBibIUaEay
	VXc0rQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk93rkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:11:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ab0409d3eso66896115ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908698; x=1757513498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKt6Z8VLaY/h+/FgT4fSGVZAXoNNB+wOFS858h7LM8s=;
        b=kwltWFoz1HcYBiX9AmH9ICOAhmdlS9VekVnsmKQMfnmGbtJ9fvrmHKNTsZIryxv8S+
         VEv+unlk6L3GXVWr/hRiZXaxwUCH3aPTmXTFJM/VG4ovytqcWYn+qDiLYpnLR/vSEOsd
         ekEwwcQXEA+uM7mnt9JdGV0c4J+wCB4RDqeqyLXVeL3KmxlhyNjFAfKBg2U4IeOI4Ldy
         WPE+M5aKYwmZhBpndiigs4k39qCUls0T+E7QAYDo0k74EOBXlxAYqki64MPxUt2vwmpd
         Fd5a+/EAUh2SckH8ofVUFfTMOiZmnYJXpPKZPd9ZkoDklCeX/XtVpLGCsYhqsMSWIGUp
         0W6w==
X-Forwarded-Encrypted: i=1; AJvYcCVTdqDlHZ2vCOpQj8JJWb5jTTBCB5Gf27N9uLaeOU9K6yxtP31Xcf+8j92bD3Q8HjUvpKm/s2wYjJfvjnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJIsf6rKC8cvUKGg8YPLxy+LCgDZJe+0pfBd3lHOdTawPoep/
	Eb1Lds9fPKpHkazHVRbG3VQlFesKtH0BgC7cK3dD4ihbNCQXyytoor2Piwp1COacfAW1dGVdziy
	amkUnhwJzxvmSBJ/xjmqdEaWTH88H50/JA9jOBlM9mTghY4DHPWDyk26gBL39TiUqO9A=
X-Gm-Gg: ASbGncvOdRDIyQVqDT3MBX6KjbDDi9lmvnKYcDzEJ/rICWNTDj9Zlp8b1eTMyvoyLba
	iBL0EJu9N67SvJOBYdcaxZHmjQUWtYgO+nBGMGCXbBF2egqLw8RxkvzfbkjcZcTMyExwsPH701v
	1W/Zz44kOHF9PZa+AIrWOIcwi/LILr19zf1wYp5xs+M251kpIQcb0Rk68tBN6qRKAoyGuzfbD3p
	+EGAg3Tx2j2L14+KN/yLc/M4JlAqRi3QJ3dkgv2TVdQLpWMYxHOv9ALK+KaP4xVl17bhhCj+hZ4
	envh/N6aEjNhhZwW3NZhjWj1GKf30Ud1xD8J9FX7tkjpxNzmjP/WQI4abuYbQjIHFBtW
X-Received: by 2002:a17:902:ecc6:b0:248:b25d:ff2d with SMTP id d9443c01a7336-24944aed41cmr168244265ad.51.1756908697659;
        Wed, 03 Sep 2025 07:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrZ0WnATdGYKq8rRd8dEeFNrnZJqF1v6pwJmwYvviuTiAB83wW4C624CECHuieCtwMHoA9Gg==
X-Received: by 2002:a17:902:ecc6:b0:248:b25d:ff2d with SMTP id d9443c01a7336-24944aed41cmr168243725ad.51.1756908697060;
        Wed, 03 Sep 2025 07:11:37 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705ba8sm165003015ad.6.2025.09.03.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:11:36 -0700 (PDT)
Date: Wed, 3 Sep 2025 19:41:30 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Message-ID: <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
X-Proofpoint-GUID: 8OItFD98C21NvkhFafCBWgq3ZPpfKin-
X-Proofpoint-ORIG-GUID: 8OItFD98C21NvkhFafCBWgq3ZPpfKin-
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b84c9a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=TzToQ3Czpl6He3JBl-AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX5ExvRYKM0WqO
 Bed35/CvLfGHkCvE1DwEfth2eJjRD0YfzXZuRPxLMgxDCJ5g6ZD7XwmC9VNfzPFbZ8Y9NOQD2/7
 arFr8rRaj1aON1avNKgOiW6zOWzK5vj420haFgAqrya4BqGulr3LJ748XTJx8gXt2AruZL8MOVd
 wdW+9gAXjpI3azu/WOey1A2MOYZG8gfVjKg2ecjHxoj9scUSJ8dFlD+OFXGkIZJV764a5hp4zxn
 RS3+EHezzHUsECSMNwQz1P6JCF+Xg19XkMkyhWO48QAmp7XvYfk5Of+8QZYLzV8gZoPOHtDrBmU
 RdHPH1BUql9H73FN4Rn8jyDaPQZpn2ORMWPnJRiqE/68bezM/iSUUc8D98gcyKvD8rocT0U08jS
 ZfKXqvml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > From: Monish Chunara <quic_mchunara@quicinc.com>
> > 
> > Define the nvmem layout on the EEPROM connected via I2C to enable
> > structured storage and access to board-specific configuration data,
> > such as MAC addresses for Ethernet.
> 
> The commit subject should emphasize the introduction of the EEPROM
> itself, with the layout being a minor detail, yet the description of
> its use which you provided is important and welcome
> 

Thanks, Konrad, for pointing this out. I’ll update it in the next
series.

> Konrad

-- 
Regards,
Wasim

