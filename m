Return-Path: <linux-kernel+bounces-764596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D538CB224DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC967AA84B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF32EBBBF;
	Tue, 12 Aug 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hrv37DW9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681C2EBBBE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995648; cv=none; b=g1YHNnvDDjN0SRsIFh0ZInBTVWtrNbMoQwYcIg06Q/tudSjxVZPBQy57DlTgx15g+ccv2a0EGlAIFZAl5FqOXkZjEyS7T1H4zq/k5tqyO+SjzydVh4R+eY+clHeFnXCuZJI23TMhKHMpadaBQmVI8cTkHs7NxmsYP38kmQw7SZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995648; c=relaxed/simple;
	bh=sYTpAoO/MJfpiYDH6SWgKI0yKgXfgoJi9HXPhQ8RgTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+2CikUIhYuxvXvDPYvx6WMtxnX5pk1ve88GnMfPljzcCIvDA9Whw0dteiw2+ksgc6tu3qK6UZo1/Tl+zLwKMn5cbVguqao61SXWCI9tTZrzW6tW+HjR5uW8UPGAySujyXSsrU5MiThk94D+3SvtUeSEMOmF13yqko2X6pr1e2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hrv37DW9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5v2Jp024342
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RU1xZ70LjWvBJQnp/8lCapPy
	QOMTXLUhP/W47Evy9Mo=; b=Hrv37DW9RQ6UcgdqWqj0o9uXJIGdXqi1SHW9fsd4
	VxK9COfNxSXiI7byxo77E8B7qbV73TD9s78TDHU80taq40iBpSQbTA8xrzAwhuYx
	g9t4nJ/J3Bzvg1arfSLx+8Sh6kje/gKM70jB5d2OAKwdyLcmWF9jKlWPMWAK3uln
	GCgWWUjPnaoDimv1SvuDvPp+9S+2TQHjTrgQ8obFOatGmKrlg/A+xEXkpw0OGEXG
	ZNsrUnajxdm/UTAQlJE5scyZ6kzL8eQv2vEjRDc76S/xojedMc/EethweQ3EdwKD
	1BkyDhRvX9THWWABsZdLHCM8Swr/eEbwRNG691n0xKBnOQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4bt7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:47:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af117ffc70so135496921cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754995645; x=1755600445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU1xZ70LjWvBJQnp/8lCapPyQOMTXLUhP/W47Evy9Mo=;
        b=m9gGjlhOEr9pJWO5Rkix166YZWCoQBdpJ5aKPNu3u5r31b8hp1YwbhD5x76IyoES/o
         10MujH6KlPmj0QA0TWZPtmM9qZ5XtubvW6QUfyLTbnfLDYDKCm9klFBP74dXTUSylgg7
         visKGZJBIIy5yom1rIVsKK9uSdELrALjvEBJS9dt/G8wnwGK59TvL2LFKA0M6vj61ovd
         58P0F/jFDXtwHxGTb3hoeHkkfOMLWE0RPGtNh/H+kCqjwbu8k1pwbtr56zsC19ReEFqp
         1fNkM4BvPOfW5W41rijWITcteJYxEVr1hlQ7FE6BjA137cNWBnq0vCwH7k8tHEdPd7uB
         Ctjg==
X-Forwarded-Encrypted: i=1; AJvYcCX8LVR5RndnFhZKRWmspsOHy1MTSYd7H13fdxi9/T9jRSwy6EDJARIigryQMQ0vQupsuKyUOe7CNmZKYVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7nTZ4LlI2lOupDI3w5SXt2/IKgeMjZKVApkU1Vu4XYKOFTo6
	tVMQ8KOf9cuPN+bZHVo9iNhNjUzUza8JA9vGD7JLcc7ERJQuaekBjVm4z6TdepeKfavWxbpIcNF
	PcrhBTZ8eNzot1YI4m7XKsq4pu8Xq5+EqacZ5huHB/T3cdkCrrnUCUl6TiO+zOofWac0=
X-Gm-Gg: ASbGncsKFECfuA9XfLAbWG2+zkHfcTw/5NY4a15M9dJWUOua/MDB2gKs2l8ExLnG8o5
	IXE0wS8o+T7nGGLLfO+6bNbcm8IS5QawtT6MrqAYo75Zg1HNHLvx0QLYjZTQfGgGp4Tk45SfXT6
	6HlS8gxuzo+msP9J/wswG+lliJ7zF4N+V84dMQh8PkiOabCy3hyi8gHQMBqdeaB50ks3rZX7K45
	qfeCLIbP0ah8+NqAE34OXLM/Kf4xu0jNhvMpH+uuSLkMelOAnOpQ9jx0Im/gZHpCS/mrHWZbGVW
	4hGL2YXhIJiX+3stxW5LX/Ym3VLU7sJx7/YRCPWlFQRsaZmJJewP+0WptPHqzXb0Y45dyJki+zl
	Jjv9u8riKvzuH3qHENWW22ISceZsXlW5gNldl3Oc/N1Ga8Uyx9Qlk
X-Received: by 2002:a05:6214:1bcb:b0:709:8742:e46e with SMTP id 6a1803df08f44-709d5e2b82emr47219686d6.45.1754995645154;
        Tue, 12 Aug 2025 03:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW+hMss4BNMWWtYqw382EqZbNCNytLhvrUCld9+J5C9taVzj5C5lLEdsNdKRSjAhJWUdrW8w==
X-Received: by 2002:a05:6214:1bcb:b0:709:8742:e46e with SMTP id 6a1803df08f44-709d5e2b82emr47219336d6.45.1754995644651;
        Tue, 12 Aug 2025 03:47:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388d46besm43432691fa.48.2025.08.12.03.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:47:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:47:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Describe the first PCIe
 controller and PHY
Message-ID: <bfaoko5ztiaouuhpi62jgmz23rjcabskksxarncg7dietu7bz2@coat42ztyzsy>
References: <20250811-sc7280-pcie0-v1-1-6093e5b208f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-sc7280-pcie0-v1-1-6093e5b208f9@oss.qualcomm.com>
X-Proofpoint-GUID: emDg3N1bd6FswiFFbvsQUsE2tPisRkoq
X-Proofpoint-ORIG-GUID: emDg3N1bd6FswiFFbvsQUsE2tPisRkoq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX95sqRHMery4g
 BtHnYIe6X+Cq63ZjNzdsZmCU4z4XcaO3wBAYBxdtMpAA4zWvnS6/qXs7yzi3yxKN1CZtGnpzz3J
 r7cJJ6IwUzI5qHNfRZjyUBSCyVOMDZ7t934OdwN3qA79/DiDjHU1ls4ZVIcRTEV2QGXViXWQdwF
 qqPl5sOdS8hUo6tLq9wAPLZKPnXhKx4vVFZiThzUp9KtlsIqFUlBWUtIB93MJXXqQJBthDRLLJC
 j9cdAwbJynPpJbP5wis8S/xXvuKl/q1Fy0yWqp2E5TwEAkjI5BDmKNdc6qvNJ8t61L0I8ohcmUl
 0Br77vTvsomkASYg93razAbVnPWuGKjpWkSdSF/feQLL/GApOLvo1jtYPBvTfEkSUU8oQDoQ9NX
 sTdygDuW
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b1bbe cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=V2r1pZe0Pjlh-QoW75YA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Mon, Aug 11, 2025 at 10:16:29PM -0500, Bjorn Andersson wrote:
> Only one PCIe controller has been described so far, but the SC7280 has
> two controllers/phys. Describe the second one as well.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 134 +++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

