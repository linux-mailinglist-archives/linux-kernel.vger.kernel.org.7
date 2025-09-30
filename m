Return-Path: <linux-kernel+bounces-837777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B507FBAD2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B70F1C7678
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE33043CC;
	Tue, 30 Sep 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaCz3Iom"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17E303A32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242194; cv=none; b=exE4SHrGAer88qX6RaBmWPdYZdmx5jUYuKQZlhwiO/o/KFKwLqCnxZ4wUhRx7Nl6DEa9MzxHaFg6BFjS0g05DWZrbAaxnMBRHpuaVv3a5zPPKxTe+AuMLegDOFi7IXWut548uv1V6U4sf9a8jJkLDXmOrLJd4Jp/jcd5Ba4/OmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242194; c=relaxed/simple;
	bh=RVn1Y7CUJwx3eNPVEiu6A51ryxvfn843eX3o/eMwsLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdYhfBqp1h9LUPpDKGHxwyUHpnsRcDKzb6XVG7eHdp0jRMghVithjc27xTb3kBCXsLnUO1ABUmMhgeL6ERIAWmkWXimizkwVtHUugXQWU/7vnDaRmRnTQt/mnf/d4dVeCEhg2FBhxeic3fQeD488hKhizF1S1gWhKr+d27dDTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eaCz3Iom; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBnMDE014639
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PCoEmaeNR1CQ408nB7pwWG6+U1aaMDJRP47t2kBBg6w=; b=eaCz3Iomj0yPqZ7q
	HYjg1zD8PNOaIK0wgZo6lhdjAqEC0o6pigA90iQx1+JZYyJ6DUABNAmzd20Y9Jj8
	S7k2n9PDhQ6kTrTq2I/+7avdXa/wYyrfbPEXGGhp+Ftu2PPHtuSGfQxYV8IW+kGn
	7SFCIB5bgLJhqZ7snConY/5ltTC4vzjQkCGIj0z8pPtmrSFvRI39K0TBMhKMx2G5
	Hn9sFTgyrt7zkZiDbY9VDWed3GfvC4NNmmgl0MzbZrBE78flkm8L5vDpKP4RH405
	FlSwW5fHpy+ag2i9poKVtsWU03Ii1id7hOVf2oQA1C9uUdBP/Jldbb+a6oRnRDw/
	AfH32g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr17e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:23:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so9372481a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242191; x=1759846991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCoEmaeNR1CQ408nB7pwWG6+U1aaMDJRP47t2kBBg6w=;
        b=dFPNRhyp5wcvUWhwZMvVe/yn3TFe/rh7dzLbbnD37rPgxLKxCD9YGC01Mj9Z/aDo4X
         Z3r/RVbFDU/v2zfY3x5v5dvsNF1EHgsOFHOulKdC83CMFXAf6j2RTPWcj3n6FTjoq2FZ
         82TJa9fpxxXyL25YlqQd6n4ac6zws/2pDP8+7iuQN46NUsF/M374YazvJqm0rRkgdpGl
         Psu8Zaf/Hp58QGJWsIESeYIoJVyLOqNw46dNj0llAhc0E8973wp7A7DmML2MnwSI6h4V
         xhtXKuW8MgTbmVzpBRfC4RNfQW1u+2fRV+Y+ERnZ5/u3HO/UVVrwVlKfksuoB6jMKC3F
         BgCw==
X-Forwarded-Encrypted: i=1; AJvYcCVkeYwn8umiSzhaT1tFcE85rIZXaWz9Z4qnruqh8WlqNoS9OcniWusWE9Qhplj16t7W8e69nPnYPXRkx2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyCos0BW2LBO5ir9ip8pqlQ988VDmXHOVHtXBCR687uwrWV4e4
	ZD1fzTewNafkq+9nILTdt/YwW1SVFjDdusaCAinkCI+mZVCtN+VtrPiLKdLTTu/XA70A5p0PiWp
	OK6imV3XR/meyZbcdr/qZeHJcbJnYnABHULhEnBrGhBK7jEN5bSM7lPmQtOrECeC+9oH6z0L9Rn
	q8Im1LnfXAsQfcQXZ47mUTVud1uUOxsgiHSNNmyLUpjg==
X-Gm-Gg: ASbGncsCk5EUYiHf26JxCCWLlBudFLNBHIMi67doFzPgilP0RrWuASFmesVsmVRk2xs
	NT4SCAW836994pR+m9/cZctYwRxtqxXLSwX511QvJt2dBg+AoWnA1YzIhku/gnHp72Qj/yh1BGD
	sR4J/fqZWn0MUlc05C3ezc3L9NkWljoo525meiRH36gWmm6cD0bMMRaEBUQ+0=
X-Received: by 2002:a17:90b:1347:b0:330:6edd:9cf with SMTP id 98e67ed59e1d1-3342a2b0f1fmr22671394a91.22.1759242190820;
        Tue, 30 Sep 2025 07:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzb25ExFEcqNL2JTIBvO7jYPWKzbGJdh+trj0QxoYd4yATaY5jEOtcnTkr/l1fj2D9IMQTydqQPESJBbvdJLc=
X-Received: by 2002:a17:90b:1347:b0:330:6edd:9cf with SMTP id
 98e67ed59e1d1-3342a2b0f1fmr22671322a91.22.1759242190186; Tue, 30 Sep 2025
 07:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v2-15-8e1533a58d2d@oss.qualcomm.com> <tsh4w4paux3g772ynjcbjx3ntz6ynqx2ucd273yz3ncscxihjk@dwwjbcqyheuo>
In-Reply-To: <tsh4w4paux3g772ynjcbjx3ntz6ynqx2ucd273yz3ncscxihjk@dwwjbcqyheuo>
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 19:52:59 +0530
X-Gm-Features: AS18NWDHg7DGICX2lVp5x-v_No7K2LhwMINF4nyiPyA8aZivXeot0lqk7bF6EQg
Message-ID: <CADhhZXY8t7fnSiq7g2dsAE+aQ3AvO5_0k0Ft2_12pMhOjoirGg@mail.gmail.com>
Subject: Re: [PATCH v2 15/24] arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _G5T5v0n7pfbPyrDDxjErxah0nX2bDAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXyZXZGyHffIzx
 1bzTb5sH2Wr026DOusppz6EbBCqJ4jy8Q1+D26K1J+WWDhYTQSpT4WUR2lNPTqOfX4UGA7ebXRF
 Y6ZINSa/FKasl92tcWDzGBcCsJ4FktReJvXlaTntcA2wEwSAk/PpiLhDSQnsABfX/HP6AN611T8
 l7geuJ8T/MS5umhg0rsox419PPhCd5UGvlCSW9Q7ifHrOSLvh/WUuFd3fUWIrWyFeezC3YeRt1x
 mgCfLYAQu66OiZ6tinFUQSwOjA7jNYwM5zu2zsPKaphyyluNMbMdqs27hQcWgCRDrfb2YvUHP4u
 i5W64F5+AaqlIzmribsAZ3edNQvUZSOeGv4zRWDFWiyLdNnEVZOSVZzIgJjHy7SNrtiHxsZqr31
 7w07Kd/NVc8UbTCiIN9V8G6sGei8gg==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dbe7cf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=42uetSTeVEhJ1EzdpwsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _G5T5v0n7pfbPyrDDxjErxah0nX2bDAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

Hi Abel,

On Thu, Sep 25, 2025 at 1:45=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> On 25-09-25 11:58:21, Pankaj Patil wrote:
> > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> >
> > Include all the PMICs present on the Glymur board into
> > the glymur CRD DTS file.
> >
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/glymur-crd.dts    |  1 +
> >  arch/arm64/boot/dts/qcom/glymur-pmics.dtsi | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/=
dts/qcom/glymur-crd.dts
> > index e89b81dcb4f47b78307fa3ab6831657cf6491c89..97f6eedd7222368f5cbfdd0=
2e9c4d87261d7f19a 100644
> > --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > @@ -6,6 +6,7 @@
> >  /dts-v1/;
> >
> >  #include "glymur.dtsi"
> > +#include "glymur-pmics.dtsi"
> >  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >
> >  / {
> > diff --git a/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi b/arch/arm64/bo=
ot/dts/qcom/glymur-pmics.dtsi
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..59dcfb67a203a7c57640603=
7377fc9fbdce51a97
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/glymur-pmics.dtsi
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#define PMH0110_F_E0 0x5
> > +#define PMH0110_H_E0 0x7
> > +#define PMH0104_I_E0 0x8
> > +#define PMH0104_J_E0 0x9
>
> These haven't been used anywhere.
>
> Maybe you meant to define the ones suffixed with _SID, like so:
>
> #define PMH0110_F_E0_SID       5
> #define PMH0110_H_E0_SID       7
> #define PMH0104_I_E0_SID       8
> #define PMH0104_J_E0_SID       9
>
> and without the '0x' as you will get a build warning about it.
>
> > +
> > +#define PMH0110_F_E1 0x5
> > +#define PMH0104_L_E1 0xb
>
> and here is an even bigger issue. If you define it with '0x' prefix, then=
 you
> get the warning, but if you drop the '0x' prefix it will fail to build.
>
> I'm sorry to point this out, but this hasn't been properly tested.

Sorry it seems this somehow got overlooked in testing and compilation also
passed ( without _SID) so it went unnoticed. Will take care to correct this=
 in
next version. Thanks for your help in identifying this.

>
> Thanks for the patch though!

Regards,
Kamal

