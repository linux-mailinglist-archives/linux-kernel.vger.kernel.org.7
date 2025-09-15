Return-Path: <linux-kernel+bounces-815958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C1BB56D72
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2099177AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0734F1BC9E2;
	Mon, 15 Sep 2025 00:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="InJyrGx7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054201A316E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896498; cv=none; b=McAopFO+fU8Pv0EhAl+3MvXY4pMVChh5CWs3TnQ/nhN/bN/gZxXAeDJ94Dr07W1lIiwgHal16oeXE0B5tVRlW0Et5wNKP1j5HSEhaGKuvGmzdmqCnmdgndhJWecboINCNxK3Ud7RnUF4ho3k1ONyHGj/jJHnoU7UKT9+dQfzYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896498; c=relaxed/simple;
	bh=Ap6BvAu67TPOd/kk2f3cFFCFX5r8s8b09wUwhreYot4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ5sU9HbICFpgfrzbv8XvFeVufLb2SWagPbxBBQ2v+QMB2K+P26G32ul8fon0RIHuJDblU75rwbZ2r0ADxySBfPvBIsZfYs+NhtrvGFZHuID46X8GFohTdvOfKd1KeAECaBUmWDLQlA+IkexGW2npdLMMPg/SArAHp04bR8j2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=InJyrGx7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMnaho010704
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lGewii8KU16KWNh30RwGnFP7
	62rCSny6t/W4YZ9CFUM=; b=InJyrGx7hsia05YukjgpX0Kjo736Trmhb+FKJ3Jw
	eu7YlLQ7erqwWnii0FRAqhmLRU2XTGI9atIEoqYRaz7LBzwMT8vjEijf/lfL3G8H
	r5HOG+8LeuiygPpnTRE4Ep+7Kq8VUTEX2QI+SVBI5Gh/1mPh/RBSSSvqQ6zhgc6Z
	5QQwxuMPdV7uKQlrkJVxoL+oXi70N7NdSwD3lhtKI9aISHpXmM03kE1d3tb/wkYV
	aDfJq7wg1VSQSYbwEskUJcQTErASM3r1q/0XRJ24TOUXF4lNTjozdLuVMEc7z4Pv
	6ebPMBCdfonWmQrVC2kQzruXgGb6XLrQHPFz2fe7UJOUHw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yxkb0qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b793b04fe0so29182481cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757896494; x=1758501294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGewii8KU16KWNh30RwGnFP762rCSny6t/W4YZ9CFUM=;
        b=aaHDQxidQFe3RXWj2KsbBAAMx7Qd+necHYDTqFQs/9KvBgLMS7Sku6rfWn4rewlwPr
         8X2sk5ZW0CwKenBNPUDtz1rPaf0WhhH0CVbrMamCut3XdmCBFBjztZwwjesA8ZFoviHy
         KQMSYWHewljD32OrrQ6b3r3o5nnI85QYkt1ZaFmyDvJ9MzX+G9fAgGmQjFgFX6B6NMxG
         8rpZaOPcLP3D92a9BvzzEm1963C90fwyCmEZZTlPFr0DcnTjKapwCpL8FQzP3cJlN1ZW
         uRsTmzjcumKZmvkHHCMbOtNmbYT/QrMg7LcMs9Q/PrFf9SY/idCs5CqNCcoiGex33hoh
         RbYA==
X-Forwarded-Encrypted: i=1; AJvYcCWKaYjEQsfXMdhxiXiQN1RY4JoeVoet22EixNOemZ3x57sL+Cxb9FDpqqkMwkmrc2dvXpQqU1ntsueEyT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ5X80o0RRms5Fo3VAmledNGKFatT7m+VIp0JsW8Uri1ZU6gNl
	sTA79jEV+so3CdNBdZx+1w9UJ1zyFoUVuCkf5sVDkzjQ0v6Tm0nbrR5PQ1vOZwnnSn5x0xbII2+
	Jtuk2TSADLGD2U17LlArNkiATcu268GbmqwGMGJqRAfwX4z0A0FFO3Di6IVljVvqA/3rXAl046w
	I=
X-Gm-Gg: ASbGnctqYlum/sekWzM4s4mLkoSael4wKjf3JbA428C6wRENL6wDu3h2VsueCRXMh7r
	c2eQFbEqgsTVqt6xqoLJR2uSWCpofW3V2GBShaAYSfOL4REtaM2DIeSS02RJDlqy41XPo1D/CP1
	n68PcRMIs5XqjB7kuMcdq7MI2Jf+o36HTxQvqkAFC2xI18D5BHtPiAYBIEcFIryAeQBH14FBrUN
	FQiDTyyfgOFl+k/PPsmygSCc0OaYK5iO/XasYfHm6WgX9qDGk2Z2MT/KgKKDXnLkyHFmyCtYWV+
	vyrAyUOrSA6LqiSnfFNgP9gGb4rh2yKShnLIo7M410iNe0A5WRL/qMMWvnkLifUh6FmHL4eKC/A
	myViGnSiUR7K+nBcmC8eay9P/RONLA3s5xEN0RFJjk9Giqnrfj1VX
X-Received: by 2002:a05:622a:424b:b0:4b7:9972:1d80 with SMTP id d75a77b69052e-4b79beb2e36mr41318351cf.59.1757896494587;
        Sun, 14 Sep 2025 17:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK17MhvQUFlGwF5rLwpdOVGDSuvWgdkehTixyi7M88M9ljpaUk6U27iQhobiT/FdRmhff5SQ==
X-Received: by 2002:a05:622a:424b:b0:4b7:9972:1d80 with SMTP id d75a77b69052e-4b79beb2e36mr41318201cf.59.1757896494167;
        Sun, 14 Sep 2025 17:34:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c014ca6sm25669561fa.61.2025.09.14.17.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:34:53 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:34:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sdm845-lg-common: Add
 chassis-type
Message-ID: <ywzzmigvtlimmnhhk7pw4vjzbyqx4v2o33g75nmowg6t67kxgb@ptwjrg5i2zgs>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-9-23b4b7790dce@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913-judyln-dts-v1-9-23b4b7790dce@postmarketos.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyMiBTYWx0ZWRfX3CxOsbZan+tb
 VZf1X5jonx0M3ZS0qaH86fjjm8Eo5e28I9N4iByFa030i7eghK9QwzfnJq4EoQi15QrsX0wjRnV
 uJ+NVvETG3/qkFyMukpcylxQ3MNHlQ9wxyRcihq1YkknxOs/y/tHXPCtGba/3Abzbz5NxLUTj+F
 pQmvI3J109U8jSkHYA/QOcsXh9gRFsEkNa5Ycx19ywPUZ7dXhWtPpo4Txzm0SG2Mb3wA3kywZSf
 kF3RP8Wkxuix6VHmjGA6jf53xLHIlBR3Vmka4gaRamJDlU1XffyOkVLL04D4xmu0vXuwRRiPqfo
 XyeBE1f5NVkSXckHiXSo8KwojPEKHjDN7G2SGER+OU9kOg9MpMMMMHbv1H1852Z0P0bk9mGtxWK
 ffGu2w+p
X-Proofpoint-ORIG-GUID: WV1KQwAs4ZCNbUghk9CWuUPV8hdMzPyH
X-Authority-Analysis: v=2.4 cv=KfjSsRYD c=1 sm=1 tr=0 ts=68c75f2f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8 a=xpcYJZ5K4HInNErYrfIA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: WV1KQwAs4ZCNbUghk9CWuUPV8hdMzPyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130022

On Sat, Sep 13, 2025 at 04:56:42PM -0700, Paul Sajna wrote:
> The sdm845-lg devices are all phones, therefore handset chassis
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

