Return-Path: <linux-kernel+bounces-740245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB4EB0D1CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1317B17DF35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0812B28C2D3;
	Tue, 22 Jul 2025 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="muJLib7n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1228A718
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753165512; cv=none; b=YHo9Y1O3sA8yvuj8The2cr2F3Y51QGrVH3fmAlaMBAKW3q6c33pg6VNTmi02bxurUOozx840rMrpRUkYpV2Avoy6jTyEkrwviLPue25zO1NzT3yBtme/Z2TD9Y1HQVw/AtS3vPqqX+4jYPm+DoNHTs2kaMFIm0kQupCMzJNRkvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753165512; c=relaxed/simple;
	bh=oJK0JmA0A1gXhX3avAQiLoakpxN5GJYgh6uOBn6ZZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUbIx4LXKc3Nt76wUPwg7zbbAd427mZS/ANT0mIlgrrnaIHwcuWCkpg/pbWWHAlxoXZMq6Y8G0rgWbMZ1WFz+6FGMmF/DkAB+jSu6RKFhv6hH7R82uJWh/CjbockPvdcqvMQJuOaHAIY4EbywHwTULzutS8EF/6JV4wf1+bKLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=muJLib7n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5Srp5015727
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yqILAblRLDHN6S0GRPwREGOQ
	6eJ0Uo/70xJXeUDARp8=; b=muJLib7nrme8p+VrsyysMmPObzBGMpDezUOhA+nb
	jWwtE5Rv5dI2q8pmgoqB3A0AvHoz7vBXKyaxe93sOI1zZCnS2A0k2GhMtjAL00ms
	2/I5PUqWoxj/PV53xOPBE2LfV9r8I0ACSGT0DohAQfq6gvas1ppuerIxU3gioq7A
	6P03EOfTwuMsiYSuZ5Kvk3nlocbwa2jWcupKJZZepvEEYemLKHLrFtEIOwCv03Iq
	dFHkFelGlzMlapEhaUUo7nji3IFs0zsvBk8Df1WVcnRsesMIyVoNIWHIksAjXKZ5
	NB9V/IvoSlSC4ePXL7auLLPlQw6wTalMGdS9MiP7d9n0zg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451g5ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:25:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e338e627f1so1564848085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753165508; x=1753770308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqILAblRLDHN6S0GRPwREGOQ6eJ0Uo/70xJXeUDARp8=;
        b=NAQhqjMKwAwrbRiomD0p9DDYdXaAa09NfodUDtiPegUGq+E1QFK6T5o1l2jp2ISUaD
         AYK4PxcE3ro5dlOiruT/vQNze7cA79zlBA2CwgrmKJFvAqzEkmp2WRWfITIvSmGLzZ7E
         aRYVHWpSkewyvqOcDmf/7qkS/VtSWiPi+UIco5ADXRMsv2srGe5wJISepkeNzVy1LuO2
         YWjln603EFvJzf58wvq2FwjLXpbghnppp2ueajuwUVEMB2zUXMGFafXfTW/xs2Jblza/
         iqAmI3hSV9QmDwIbDJILRUvdaqpFdfpz23BxiL98ycZrs7OducSOnpgPNngtUvOVYdHi
         SOLw==
X-Forwarded-Encrypted: i=1; AJvYcCXr24IICSjaEWFSUGrr7rcglNfrJlzI5XoIpKd7QE4DvT5bgk6BXRPycmY59X3ayVhdA7kOvLfa2AafAzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i7f48Z2lyx76MSPCfWmhKgIIGP5v5sItn4aEstWDeJ5flrnY
	MuHMkZoQKGzxtorUnXckA9vQBtOrw46qLiagUlZXyBhYRmNTy9BqQznOXpiuA6P2DUf8t79wS1c
	PYcI0aRxxuOpaBNxQFePUlRDhRt98XFGKeZcB3Ua5CHoXHTDuUGuZbR1JBZdeF6GZbiA=
X-Gm-Gg: ASbGncso1GK7aQyZ5UWtY3MbWAckEwY7aEVqNvPtJeFNO2o4iofXWeN4TlbxobswI6v
	/eZtkHFjO8ncogTIMSX3U2EUZ6J3CtOxI65zaSDEyTdLzJYVVhJoy/PZDEnlSfLAninDOCLsuhL
	m9SDc/gE9SuD72k+WQ2JTBGMGikrF47vHE6f7pAWBYoKXMtM01ndznjWhsq93VwaEii8LEnAMdY
	KjyoGooL8la71LjbnXV1UHfgXo/JQhAHE64HtaJAoUL3i2ny6swgloObruOF4SQx9Iz2ChXf9yb
	OhLAfVgtXqdbM58lC1SatnVYTillkL/qpc3E6loFARnmH4784X0BmIzy90JIBYLtAho5KcH57HV
	ud8l8DedSD9qA1mjQw6k1n2vuPT9ta1TYXxQnsfNnDUiIqVbMfRjo
X-Received: by 2002:a05:620a:7181:b0:7e6:243d:e3c with SMTP id af79cd13be357-7e6243d3139mr57442185a.35.1753165508314;
        Mon, 21 Jul 2025 23:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPEoufn0Hs+RA2zP7PfRn6yClVi2ckcXVyA/hATBGSEOgw2HzSTorcYIUcwTOrFP3AAai2Lw==
X-Received: by 2002:a05:620a:7181:b0:7e6:243d:e3c with SMTP id af79cd13be357-7e6243d3139mr57439185a.35.1753165507863;
        Mon, 21 Jul 2025 23:25:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4cd997fbsm7232e87.203.2025.07.21.23.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 23:25:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:25:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Mike Titpon <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH V3 1/1] arm64: dts: qcom: qcs8300: Add EPSS l3
 interconnect provider node and CPUCP OPP tables to scale DDR/L3
Message-ID: <l6lwso53m3roxggh2dy44iaebrlfxy34mpu66kjlknxig6y7ir@5eklfdr346ab>
References: <20250722055039.135140-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250722055039.135140-2-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722055039.135140-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687f2ec5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=tFNSTuR40NsBDPEYOFkA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rEsW_uR5tN2Mld3X-Zl0Hd7wQ7nbY8UW
X-Proofpoint-GUID: rEsW_uR5tN2Mld3X-Zl0Hd7wQ7nbY8UW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1MSBTYWx0ZWRfX8acswAcO4Vnf
 c5XobTkbirwq+Zk70q9dihZA1gSPABEx0+VIyuhDrK7S/G6VU2ItgiFKkg2lNcALBM8T0pVmYKh
 OfO7TTfZcUW8U9v51AeguKQorNy0XgpAZz9uxkzAs264Ap6R99y8M9O6B0N/DQJDUKQ51GFlfFs
 Xfe3NYOQYYLFqvGROQZziLpZG8obyPk1wX18SzwgkUq/3KwZvPAuJPaxjm/jM4tumE2d2O/8J7d
 lxjHlcsAu0YJCrFWbMz6i6yvhY1WhE6tPd2w5qduNfLVFmKZgU0HhZNHzBZ7hBstJzE1sFyu2Aw
 tBug4ntrSOZAoTp1BUoZZoy/EmOWb2wqx0dWf5DLtLMw7wAfDEULAQRtw89hG6kXc5h9gQIIlsj
 gk+siQxbsMcPHht6NPhh8psNHuxQZ1syBr1p+cC6gZaeao1A3XoENIByrnuQ1Pldj++UXV44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=987 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220051

On Tue, Jul 22, 2025 at 05:50:39AM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node and OPP tables
> required to scale DDR and L3 per freq-domain on QCS8300 platform.
> As QCS8300 and SA8775P SoCs have same EPSS hardware, added SA8775P
> compatible as fallback for QCS8300 EPSS device node.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Imran Shaik <quic_imrashai@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 301 ++++++++++++++++++++++++++
>  1 file changed, 301 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

