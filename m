Return-Path: <linux-kernel+bounces-830981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9984B9B11E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E505168037
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741A2D97AA;
	Wed, 24 Sep 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fKtTnbE5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EF1A23A0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735164; cv=none; b=RL5kH1nLiAA89FyNl2SFOC6JiDsT33Csd8XHBGu2sBBtzAuAkyqUIq0kCFSsX5AvF7LsCRyEykTZDSs64ND7Kl8cqVpwpFOKjC9jYrSuSIUFvBHn95Zqza+qhh1SYIaBd79q6Rwp2ht1DMlhQhcVFEMBfwjCRbZKTVmnx6CeMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735164; c=relaxed/simple;
	bh=LK7FuHWulSuZBSrOktpH5cJe+KfysFVveMNzVDwwTAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuxkeLQRyJ3l1xkQYkUMFEyVfAn3hwF7nivPHlqtUlptGMnLwCkOr1w8OPsplGM+t+iGpE3Uu7xxeamxAr3U1dsib2GjdUzr+Jkfj1n59XmE4lMOAxASEQcHxcrd306TucSsuWJWxMfnJqBT4mTlhy7+98TIp3DbF5inR4xfGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fKtTnbE5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCeT8m016436
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1Z5b3FyW91Ev7pON5LFlZ546
	L5v5xS6NyxTMHjxie3I=; b=fKtTnbE591uJeV6EPt54V98sX958FJNXQWP33iuL
	HMU173kjpyld6tP3iTkRIJyCAP1zz8iQDe/ezaCSD10W+5qKUClmYBhe6oGrtvpF
	naq7PEMxvsHSpfHdU01TKMyOqH1AVbKDsqD/J4W855HlH8YMuMG8BwgBVwgpT6O9
	MmHoDGQAZQSNf8XRyqBSWC64YleMV2hYgb4N/B7IdLrHsm3vL1Ub2vW3zAg/d0qp
	C3GTwzqhHYCrXx+9LvZrBxmKQ91kIvuNrN/C4q3DV1gAFIu4kNunNpSob3Ktx6ET
	FPYO6NiVh8+Zbb4mAdVKg6qlAq79jaQaxOO1rCn8R1F7Yg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyh29v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:32:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581953b8so387945ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758735161; x=1759339961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Z5b3FyW91Ev7pON5LFlZ546L5v5xS6NyxTMHjxie3I=;
        b=I27+j5Qh2tdLGOdLhK7kooOb+S7JNKlgGgl5n0DrlRg99sSiJUUCUAUgW2ybhd726t
         3Xm1BtnbsTZbk27zHFDbxS6PXytuFXLT64wB51Vpa+NtQgmdBsQrl263ribJQj6ijKt+
         Ezh4Dg0U1enB/gZ/Mz9BDEp0osm2pqx1spfKvQ+q2TtfWiPU9SohMFSGtdgzlRlDpJSu
         gISwhvxcdSqHIRCGma/J7QDEziFk2aDQvP+A8+ySVfCTdh7v9eHW6Ap24jJKNf2XcwQ+
         Ccbm1ehViuIfqkGyy582qVqFkUzCiYl05cz0VqHmWwJNn9njvoWESOnhd3QawbO2sow0
         Rnyw==
X-Forwarded-Encrypted: i=1; AJvYcCXJhmzi/taL62eO3K0MRMzCFa3D14UukQ8W6J7BP5wmV8ye8MAKXy8xr+pcLABgsnzCOCquqarfuyfB3lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9O6xejJXI0Q441NZPGcDX/BwHQ5lytvwRAs6Q7XaAp6EJPdb
	x7nMbBDVHyNyLNj1ZltRKKAFJprARd/YiKcDFr9YOrGPvpFHeyk+0+L2ERzLEzouoZ6sEGEjy5R
	OhQKJ7lJB2STMxNnkMKIf79Ze/rtyMVgnnaX5r0A/JAe9gT5djvgDoFbpcqXKPbgKG5UF2Rhcs5
	9vN6RP6f/1twIuAcAhRRHErMoH029gBQkh4cpdFpmAjw==
X-Gm-Gg: ASbGncvhFcy+X4lnl3D2N9R9JjmOVCYAM2ODItUm1uajQ9VymYHhBh2ujbIqxipx+ic
	r5adgPigbIG+qMBCuVzc7iaRrcZiryiiMAUyOEWwYIepP4mHm8+DAV8z+PAYg+OevWRnjkjOx/A
	SqUtnDt4vX4g47pbaGimuYVMZnXaEYbgIggrszsYtXzzT5IWP16uEkkg==
X-Received: by 2002:a17:903:32ce:b0:26b:3aab:f6bf with SMTP id d9443c01a7336-27ed4ac311dmr5754765ad.42.1758735160872;
        Wed, 24 Sep 2025 10:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVFoc+/aSgSKbGAREv44isgr8a+oJ1tMP5eoC7Beox5ftIIQN4N8Cm8Ud1RQbDvEzYZH2wRrzwwOkyntCwtL0=
X-Received: by 2002:a17:903:32ce:b0:26b:3aab:f6bf with SMTP id
 d9443c01a7336-27ed4ac311dmr5754505ad.42.1758735160426; Wed, 24 Sep 2025
 10:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com> <eec9a046-2742-4b7f-86ac-ef11dae19aee@oss.qualcomm.com>
In-Reply-To: <eec9a046-2742-4b7f-86ac-ef11dae19aee@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 20:32:28 +0300
X-Gm-Features: AS18NWDEujWGHc1CUohsolkmSSOR_zn4Ju2H3zwxDzlrpwz3Mtyqx9QBAuAE8wk
Message-ID: <CAO9ioeWJh6fkDYT-Y6O4mJHN3CpVw-D0nygvA0TsgHGqXpLq-w@mail.gmail.com>
Subject: Re: [PATCH 00/14] arm64: dts: qcom: add refgen regulators where applicable
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d42b39 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=EUspDBNiAAAA:8 a=v75zDIhsPqNLugsjS6wA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: IGGOrx1prrQ02IbEP8cJQ34tndqScU-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfX1kzcZWTtvod7
 skVzmdzHXBrAIZT8q5SC7KYVsK+ToVRlWWfEVEoZzS1+iJUwgF//ASMv9dTLO4fY8yR6lcKzl+H
 0z2Q7Zem9jA6phgOo8kIlLXUFcab98bHlbTuHHWooSfPHBrTttWBOAGvAkjNJEZChXjpjEY5ths
 52Izk9XTHQpR1GyqJUjff9qhzXYAdgyTmsTRFAVg5xpFKpsLUgvO4Uim8fmr1zFTk9ya0khWKm1
 SgsndKf0DzOEUugknzV9zxCV4eAlLFMbqlCxMS75bW4fLCYL41b1u6rl3c5rNylB8+Z6uMVf96U
 AWjZ+lOk/rPGKCs61YqhDt93zNXCVJoVbSDLV+iUjr5Meh/aw/N0cg6wlKvjkmgipgPBkLobCMw
 mfwtOau/
X-Proofpoint-ORIG-GUID: IGGOrx1prrQ02IbEP8cJQ34tndqScU-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

On Wed, 24 Sept 2025 at 13:13, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/21/25 9:09 AM, Dmitry Baryshkov wrote:
> > On several Qualcomm platforms the DSI internally is using the refgen
> > regulator. Document the regulator for the SDM670, Lemans and QCS8300
> > platforms. Add corresponding device nodes and link them as a supply to
> > the DSI node.
>
> It's likely that all PHY-ish hardware uses REFGEN, so please make
> extra sure your patches won't kill DP/USB/camera

As far as I understand, DP and USB cast their votes directly in HW.
For camera... I don't know. Do we need an extra vote?



-- 
With best wishes
Dmitry

