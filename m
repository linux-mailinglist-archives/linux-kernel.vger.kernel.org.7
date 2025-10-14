Return-Path: <linux-kernel+bounces-852187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC9ABD8646
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC4064F7172
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F82C11F0;
	Tue, 14 Oct 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vju3B45/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366172877CB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433559; cv=none; b=LOHbH+8eIk7rngCqiDT1oJDDAdlJl/As40i1ZkNYteYP68QMMcWu1+si52eM1lxbhlCltS4/xub1zFhi9rZUSwtDj1I43rkMf1ie4pSCW/AHdVNzuV1lT8bdsxvos3lixH4WN0wgoWeOJYY0v4UvM4B0mZbCOt6IC2SvLd6SWyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433559; c=relaxed/simple;
	bh=KCXqlj2/eMDCK2VlI2slSyknIFjdtmFTDQyXloiv5ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me2e6/cFR0JYs+qooBrMYez71TXrBKJDTf2mA4x1LnfrKPp8w3zDdOuzQk9015vBfGKpFFUu5GV8hMRsEgLERKK1quaSJIsU4Gmb1zuNbBYUugfMozGb+ZYfTcteVH1x1PuS3tlE/1qWMdN27o3Z1yUzMe6edJfpOqQmyvdfhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vju3B45/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87OGG021173
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/M4+9qjbR0xmZ9AUGWwlamLg
	Bh7AibV8Qv6wfylCGO0=; b=Vju3B45/mSf52hBqT0GENjluUCDiOtbOR2hShHAR
	BcJk1V4XprO6TdfMxVoQMolPrcpWikbRccTF2XTe/aPr9dkq10/7H6n3b1n8X4NF
	fFkCyHEKD1v3gwT9UVs0LNGGqc/uySAoxA71KPKW80lOwiEJT6ydGQv4aOLGbbgA
	ideY2iQsyPOj9sDoQt4yZvoLWbLAEIl+or1dOB/8T2NVGhoNfeQLSDpOlEEQYhHs
	rcatz2WUT+eM9xAbkiJzlJNwXlwekkWTNvuCCoRwFLAaIFdIBCuPr5ntVPQ8Xb5a
	PCSfkuykNjcai38qTdQkegbwlpPr10Mj5xeSIHzRYWAkCQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwj65q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:19:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-854bec86266so2370727685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433555; x=1761038355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M4+9qjbR0xmZ9AUGWwlamLgBh7AibV8Qv6wfylCGO0=;
        b=rXCeFpLvnTewqm1emL/nzCloNRbyTJ6tZnAW/EsQFfePi8neOfjr1GTo+DH+JyPFT4
         TtFXOvmNgWzEp9XSdnnI2BLZ/madxPnY8dyL+21gRnB3zQAku+cssQg1tf3uTTklQR7f
         wKBXHvDfEDkRH53ILhPHPTLH7H6Ldh6NrVWZpgSyDmmtiG99cZrS2cTFWC97QmyczdLZ
         9Lh+cl6qDX2n+FwgNk7AYmzjZqwDhNur0U+yAqcWj4TSNcDLnU4GorjE8CT9OQykc2t/
         JI617TcSA7XoJvv5sk97vg74lRSgCB2iLelYUHSa412vSl1hoQQ0l0jnR/tgsjXZYSWH
         /L6w==
X-Forwarded-Encrypted: i=1; AJvYcCX0gGvm7CPqADHfiv2XQScHGSkR/Dkl5YbZjSR/htFc8brIHYpnd0ZH9vrGE/dVrRbM5VIp2wmyg+44q6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTd9by7Vq/iJpB3ld9wTBmHuraNdr7aMERNy1jFXQjHqgZBfQ2
	GncCU5mnqsQcBLgzlu7lYv3zQzHF3l+GJYyb/94l6KrxjaQ/8cB2CSaNVZ9WrbesbyM8G3yXXT3
	KJ0GqFTd6e4jGArajQ1SnFNuJjrZOPQQPoRtibUt98pm1MoS8eEo8e+UIkLUi1qdqSvU=
X-Gm-Gg: ASbGnctLlSZ2Qgh8sGFPO18vcx+H+DUB/tkDCx1hkaohpuXpFQP2Kt2/Ew+nKOw1CkQ
	wjcet7Y4m/YZWJpcAiQjAk0qPoEO3/7qUNAQr85Hu8BYPb5HweCTkTqZVK83Ommle5miBsLYbyv
	tz/C7LOc2Tl6uAv5ysptwNr0QmRIOvsvtpPsRBZyiWKKW5Ulssgorxas/BndFaGwwNZ7heUPQgA
	TQJj6Z+XlGu2f3mmErpkhacwMSJT5g0H9SOm74DmMn3F5uM8BG4msYuXPbPAaoI3sbZB0lBzxMN
	sl8DR+1UIo/a2JpuTVp5eeSwen8nltHTMcPh4KGmXbcFSFUeRMjIEWBpic5pL+O2pMyMx4u0eTc
	OpHj+ICf1my2U77NKXcY4bs7uiCOC0nh0Y7vSq7utcLrhrycvfX+j
X-Received: by 2002:a05:620a:2a0b:b0:86f:b068:32c2 with SMTP id af79cd13be357-88352ba768amr3441609785a.65.1760433555018;
        Tue, 14 Oct 2025 02:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ0Bdv9ZRjNQZJ2bun3sNcAh/K42pzla7s+n3DhqMnWjW0vg5zZPO+f31pSNhVt7Buy9t+Hg==
X-Received: by 2002:a05:620a:2a0b:b0:86f:b068:32c2 with SMTP id af79cd13be357-88352ba768amr3441607285a.65.1760433554567;
        Tue, 14 Oct 2025 02:19:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea11d19sm39716781fa.37.2025.10.14.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:19:13 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:19:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: qcs8300: add Display Serial
 Interface device nodes
Message-ID: <v6cvbds3fsbf7ebfi33mpkrgbrrb4oxubgpshzjn4o75j2jzcn@nnaenoukfu2n>
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-7-quic_amakhija@quicinc.com>
 <fsqytqhe72bgmloyzm6khoprq6bysf52ufz6oi6epos7uadyho@wg4rxs6f2xyl>
 <374098ea-23f1-4d1a-8f70-313a7e384f8d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374098ea-23f1-4d1a-8f70-313a7e384f8d@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX7Z7pXBgQxNOX
 07VeXlKEZ8OU9UKBPMeKZot+ooQjb/xZ9fjiFulARVtcayEsl8zlWddGcPKfOsX3L0s+LU6OUpf
 TTe24bxtUPgrKK4lVS7ERquv2jrRmlRkmN6TYE9TjifjinHUjOsDTzir4sq6IGg9cmIXrvvk6Dr
 HlojxCiAQJI5YttV3zsC9U+hoGG20WRIMXuXLOMj793x6mbAcq36tCb+zNd+nP1QFXMVqHRh9ne
 cLOjd0gqqpCwdZ2LIeD5VfwkJFdrN0b2PhZlReGmmGahxnfPMP3Hwzuy/kdfyR3rlg9gKDeA7oU
 a6IP2ru2MzG9MYAwLxisOw3hOYAkccyImfEAHhjeHoAhhNhV3fF3BzlRUjF9l18RpXjXCBcRzS2
 MhBEpJ152SxMp5JNxeIJ+ZPXZxlpZg==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ee1594 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KBoXMGrBdGQ6yHO1rqoA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Z6lWzdh_Lex_l18KkuUW228AmN6D9hIe
X-Proofpoint-ORIG-GUID: Z6lWzdh_Lex_l18KkuUW228AmN6D9hIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

On Tue, Oct 14, 2025 at 11:54:31AM +0530, Ayushi Makhija wrote:
> On 10/6/2025 3:44 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 06, 2025 at 07:09:23AM +0530, Ayushi Makhija wrote:
> >> Add device tree nodes for the DSI0 controller with their corresponding
> >> PHY found on Qualcomm QCS8300 SoC.
> >>
> >> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 98 ++++++++++++++++++++++++++-
> >>  1 file changed, 97 insertions(+), 1 deletion(-)
> >>
> >> +
> >> +				mdss_dsi_opp_table: opp-table {
> >> +					compatible = "operating-points-v2";
> >> +
> >> +					opp-358000000 {
> >> +						opp-hz = /bits/ 64 <358000000>;
> >> +						required-opps = <&rpmhpd_opp_svs_l1>;
> >> +					};
> > 
> > Does it really support only a single freq?
> > 
> 
> Hi Dmitry, yes it support only single opp frequency, I got this information from ipcat sw for monaco, similar
> we have used for LeMans.
> 

Thanks for the confirmation.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

