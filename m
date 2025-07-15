Return-Path: <linux-kernel+bounces-732550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B47EFB0687A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60281AA1F52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F938265288;
	Tue, 15 Jul 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpfILPCq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E342C08CA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614493; cv=none; b=Sl2llD0iehD+iPdSn0kLC9QgQrQhvqn1L0V6a1RpnF3/zVf3Dl1XNe8ztXjqJh66xKqITj5JlwY5ETSDIIDI0z9D1YI+TwZtwTPyKqVXBPHhxsByOsXyEV8Vutif7i7cUtbYrWE4+NdkH96gtV79ucJZZhmNJnY3+R1ZcEF8qSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614493; c=relaxed/simple;
	bh=M54e0/ZlEEa2sNV99+CGjmRYbJUwlKNDtK0njJtoxjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VajmryLRZmyeok/ebcUfgLt3tIeA9pCL36klyZpgBImxmYqLbtYNZbs8oWq4kKfR8mN9DBMETk1wymlhQPAE3GSdKpQVDfmQRDIk5IMM6YV1gemIOPXeaQnUPRiEEvZ/k+UqpnTGXbWIuAmgBHHQvJcXUGnO62U6HBS2zmZk1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JpfILPCq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDLRJ024983
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wt6pHEnPgOMDtsvi/12SpMFQ
	uNhk9sWrVUUSDWC7ddc=; b=JpfILPCq6ysjgrUDKdpIOioRmg3rMyF0SEy+bnD5
	iackY1+USjZDifvl2zdbwfFSE9EALG+KcOiiL8iNqFaSHLf/DcU/aVyWbEft8qYr
	l5S2/kt2JgudNnUXWgAmvUQLGkXlvyNA5aTWF6vmJT9NAlnzKD/VsCMNReWG6Asl
	NwL5wvtV7q6Ikpoe77z+aZbO7lmIJf10ELXud7QXnF16jOSkjig9TF/Mvv4p7XPw
	LjYmmcLIJwExnC0fmYylCOjCGstJD3FjIkBdNE5xMeqG5hZ/+jo1CRqovvIgUSGg
	JpXMh5+QMb7FaheXg9GSjLN7Q9iZweZBL5/5aOhYMzW6AQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w58ymg5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:21:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-312df02acf5so199899a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614490; x=1753219290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wt6pHEnPgOMDtsvi/12SpMFQuNhk9sWrVUUSDWC7ddc=;
        b=ZWNjjBz4jvTy7lPOh02s5nrZzzGAXliQnBpCB21yEfKPlcuhZUKAaacjMJ+eg6WkRs
         NUKCvikG0L6ZXUM3IlTb11ZbrtVl/CN3DXOua287tyoXGRdv8vru6bmx8ZWly9RdFris
         myt96iMZuwS7lF1w21+sdaiEqRHgEaPFrpYys5ft2ARorCmwazVmcMI0qLejwclJRHky
         7/h7yfhyHzeVVGIWFzHPBdzBprx4lL5MfNT2OJZtFHnOYDNj15VWOq1St3a/I1/ZaHRV
         EJptTRcOJ/yDOGyrA1VFQOlTXB67SHVXXqYzYw9mtHrZQqN+xbldbWjzYF/Z1ssQo4Oe
         bW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCnvrq2L/r/s5YB/A78kvOPdVZz4ENdCoKEECvcGyCduVRFTco6EHE+VR7foPpAS9rkXigMb23P4S07TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/1TANgLWHR8DQFWVEo2AjWtxSLEsNRgJrKcwyX6WGM6EPWhS
	lNah21yeNmaDJ2hE9G2Sk933uTybXNl8w6uiNEZ6bLSf6YjqFVLRmvDJ2JwrSAq3tZlNuvE82U6
	2Yqg/wD89gXJhR8zW5oBxCzqKOflkmwaWuK0q70yL/1z9CQvsMKyOoT3NBcDbUq5P9VHteuZE15
	ejh/c4VAYWwuOalM43+VYI2rRiesktNqoiutpD6NMa1w==
X-Gm-Gg: ASbGncur4XmvO0JXOQmnM5hb2432tEAQgjres459TkHCjJ2nX7Z/2Emc77gcdC6/foe
	15NrBkmR2cxARauWnuoinGh/5L1ZeHOkmgtyrBL2GyFGogBDoM6ul4/QR4GD0h3Pkwo6lFzhqzY
	ytgUeotu5dal/W9/4M5Q==
X-Received: by 2002:a17:90b:582c:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-31c9e5d6787mr1112818a91.0.1752614489637;
        Tue, 15 Jul 2025 14:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE180B/nvub/VcLFKHUYlMuFfM+d+W1Yrk+Dl1vV6BZLqXAgmjk5x3JRwv1+EXCWv36y+/9gQXCwKTEXZuI6Tc=
X-Received: by 2002:a17:90b:582c:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-31c9e5d6787mr1112777a91.0.1752614489066; Tue, 15 Jul 2025
 14:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715185636.21758-1-me@adomerle.pw> <uvw7usijkllom6cox4fkhrxpckqf7gk65b4hn244hpmj62utyt@zlbxwwmj5t6u>
 <493da354-2c86-452b-b343-c9ecd3ff84e3@adomerle.pw>
In-Reply-To: <493da354-2c86-452b-b343-c9ecd3ff84e3@adomerle.pw>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 00:21:16 +0300
X-Gm-Features: Ac12FXwf4NBb2pWO6jqWH2XiOZVWEfDSrstKZQZ91qjRKAV9iJ1Qy-M0e_EZPFs
Message-ID: <CAO9ioeUtiYFLyTWHYdoy6P69jg77EbPv-f=i2dO=9dDB-UaHLQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8250-xiaomi-pipa: Drop nonexistent hardware
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luka Panio <lukapanio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5NyBTYWx0ZWRfX53hNuQdg4ART
 tfdU+nHu/NFMLa3FSFCYe5op34Zcu2+Udi1/9EYaOp+fK6xC42YxhSOMHlYUjs1XN/Zw7bs4y4U
 nb803Y6DXzCS20ePv30YR0tQPE4DscyugeYHmbkJUR18AU/1sHDvW5XM/Np5SC/Fn76q5HyhFgI
 dGrgEmguZzpFE6hnNzz6TBc7cNVQy6+1MvV9A9HwC6q3f+b7gcL73MeGi0TxBwWzuxztu2M5/r0
 O2taEt1e6YVzpBC/5SofgzhknhqFxH2TcL4Mzrmk6fr7+0Cg+jhb0Bans65z1EOMEghYLK1mUx/
 YimgHagqgxbHOTjDn4pwa2DNQ7pfOAXLZ5wlvS7/9aE09R3fPZcm4Sp53PTe/98Wc3FVoDWWpt/
 8Q0Ue5BdDu+k4kwwMSaN0fFjBiBqWnGEZoLNAuPOXQ1ESizSM9IXYEA7W/1S6NVCTH5PaD8o
X-Proofpoint-GUID: zzeTsWjqpJtHw-i0h6qXzO86s78YXUSC
X-Proofpoint-ORIG-GUID: zzeTsWjqpJtHw-i0h6qXzO86s78YXUSC
X-Authority-Analysis: v=2.4 cv=Or9Pyz/t c=1 sm=1 tr=0 ts=6876c65b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=NEAV23lmAAAA:8 a=9pW74NbYAAAA:8 a=mk2d8uPtwDXq42qNKiMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=67o8LzlnqLyy2xoPAWJp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150197

On Tue, 15 Jul 2025 at 22:37, Arseniy Velikanov <me@adomerle.pw> wrote:
>
>
> On 15.07.2025 23:22, Dmitry Baryshkov wrote:
> > On Tue, Jul 15, 2025 at 10:56:36PM +0400, Arseniy Velikanov wrote:
> >> PM8009 was erroneously added since this device doesn't actually have it.
> >> It triggers a big critical error at boot, so we're drop it.
> > Might it be that there are different SKUs?
> Well, while it's in dts, but it was disabled in the kernel config:
> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/pipa-t-oss/arch/arm64/configs/vendor/pipa_user_defconfig#L413
>
> Maybe they just forgot to remove it from dts (I still don't understand
> why it is displayed in i2cdetect though).

For PMIC you can check in
/sys/kernel/debug/soc/qcom_socinfo/pmic_model_array. For FG it's not
possible.

> >
> >> Also it looks like the fuel gauge is not connected to the battery,
> >> it reports nonsense info. Downstream kernel uses pmic fg.
> > Separate commit, please.
> >
> >> PMIC fuel-gauge driver uses mixed stats about dual-cell battery,
> >> so I combined it into one.
> >>
> >> Fixes: 264beb3cbd0d ("arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial device tree")
> >>
> >> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> > Please remove empty line between tags (i.e. between Fixes and SoB).
> >
> >> ---
> >>   .../boot/dts/qcom/sm8250-xiaomi-pipa.dts      | 95 +------------------
> >>   1 file changed, 5 insertions(+), 90 deletions(-)
> >>
> >
> ---
> Kind regards,
> Arseniy.
>


-- 
With best wishes
Dmitry

