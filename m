Return-Path: <linux-kernel+bounces-677047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9876DAD1532
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40CA3AA5B5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jun 2025 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356C257426;
	Sun,  8 Jun 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaWPNtPY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D941EBA14
	for <linux-kernel@vger.kernel.org>; Sun,  8 Jun 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749421214; cv=none; b=JOWtfrsC9f2lQxrDQBu9HtFuC+hed/hh1DDfq5oA4A7ns6aHy8KWfuuBzu36ycVd4HTsR1/gStKPN/5Es+y/im5WI1+IGNCeF8Q8xE/KQVTiE8+mmH4jlvz1zUYLJLmc4FL5+F3rsEsn4RVKNJWD55mwC2wjyTfqRyF0ON8dOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749421214; c=relaxed/simple;
	bh=yEf+NriiR59T2ewH40HxJe8FZfjLCDHU1IW4iIwMUTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IosT0oui/phMFZGDmPcRKZoLF2dKt6CmU8Cf5P8BdIpZt1Cc9l+KO2O7ZC6hPGH2g1eQEZbEA+a73l0soLfsK7rfTVeEM3upXaecXTSDbBM4I+NclJLmTDhODUIEB0PCi6mk3/TrsiwMZ4csQ/vZJ/P2jzv/csCi7NOOtzu4rhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GaWPNtPY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558MGlAT013805
	for <linux-kernel@vger.kernel.org>; Sun, 8 Jun 2025 22:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	otRYK5DhPTOrJ6DwnOhZEoLtC/uLkxnrwdiO2++9uBs=; b=GaWPNtPYreiJXhJr
	F14/sJJ+4jOrTiuZFE2ltYhaiVeFuucJiL4Qq9mYpj4gTJYzrsdYuEm8rD9grlGB
	3W1gTGUVO2F6zstBsp0qJrIZy4WnSnTI8ryUWZCe/TKsf02vKVFuqFD7EGxbO5aR
	lsje9y2aZdTch5rYZITzH9jNOLdYn8mTQ/hk96JRv3baDNzBm6siOp6tuDCw0JfU
	vLllMFDkf4mzbmoUPHvs8jMlSqVnyx+lN1FxB//ZBu/LjIiqEe3IacBq3thhzgkJ
	vW4MMuc9URd1NGEx0cvb29ciKw27nMiiDayB7quWdtiQD6XhQ9/wWmCEuphZVWLg
	IR5eOw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgxm85c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 08 Jun 2025 22:20:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so2246998a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jun 2025 15:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749421210; x=1750026010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otRYK5DhPTOrJ6DwnOhZEoLtC/uLkxnrwdiO2++9uBs=;
        b=qJ0XMG4bUxJVbJu9nqkMAGKpLCYrP2MdpC7Q1qX1EQRM3sTc3rHmGdecx34HHQZlI+
         e8t5PUkuJF7tekHd5rRUFWAX9AnYRTlEQueRun7gC+o07+8xr6bPFMbUFmdmiqC7mtsR
         4aHiqi+XEJQh5FzytUPiaaHfYY6UUz9bx+s2u18a01s6ptT/1KqLKMVDpjIMKqosvbXM
         Uw6jQQXUgxZQUCo/Ak9bJFuhiWbc18zb/8iGUIH8mrx3zYX383O8Y+I6Wtc3Ys/IWDr2
         cPMB8DQrjgBxsTjrglSm7e+lpExfreGG/Mah+v5I3aN/CxpFiwnCOZ1PV5slg9ViT2mC
         g0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnBNgtp5mFIQ48JO42j/Hp/i7rX/56F7QAjfIkbt2oJTqBzoBRdzxw0GdV/3bGjiI2nAzc54lczEBheGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wUcKQ9zrWFXgkNHePZGem8yFLgwmt3vduXRl7wkHqAtVrdpa
	lgoj5X9OBMC7cdv0KZdqzR8w/RJkGm4cUSXYXKT0jWO2CCimS+rM70+u4GM444oHx+JH6XKZqox
	T9QyRw4h0M0mLYSh3ILujv/PdVbfmGpf44EJKCHQFNPe6R5pSws5p9dYUuUhfQWK/Dv+VwdkQ30
	YNewDMMhCWXajPH8S0wEnSkZO4TI5fpj8ehNFj/SovmQ==
X-Gm-Gg: ASbGncuOTyuwL33eyisOVgmtcu2moqS+GvuQddVybDYTTWA1qxkepQepZyzSfamub97
	206JjDFwTY8Rexdp883q3B/R6dE6D/LN7fmegorwuFa5wm3m2LdCMfiaxrddyDmZYAyL32X4Tcf
	Nbq+Htx9w=
X-Received: by 2002:a17:90b:554d:b0:311:c5d9:2c79 with SMTP id 98e67ed59e1d1-31346c50561mr13829944a91.21.1749421209852;
        Sun, 08 Jun 2025 15:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPaBHGagiPXUXVNnIDh9yqYM2ox50KJABQkfzbYsQuROfydBSrCGaYwKv/0lBGz9hykJwQ8JGCSB+8fVGYsq0=
X-Received: by 2002:a17:90b:554d:b0:311:c5d9:2c79 with SMTP id
 98e67ed59e1d1-31346c50561mr13829913a91.21.1749421209437; Sun, 08 Jun 2025
 15:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607-x1p-adreno-v1-0-a8ea80f3b18b@oss.qualcomm.com>
 <20250607-x1p-adreno-v1-3-a8ea80f3b18b@oss.qualcomm.com> <wayrour74vlli27xrtxi2ff2v7q7ye2yknmk2mjpur5ry5gruv@hhh2mdb6lw2i>
 <CACSVV03X5EyAb5yCPDn1ot8vOFV_dKG7f6+yO5t9srr31AiUKw@mail.gmail.com>
 <rwjc7zkitubi6cdre5a7owmo76nopavkgifvvn6yq2mv2hrth4@bhwbodchd2gx>
 <CACSVV03mNkELWDB_uxdjEa5GeWZUY=42O8QG4qTrg6zquT1Bgw@mail.gmail.com>
 <42a69fa4-48ac-4a2f-a2ff-b4e1fe3a228a@oss.qualcomm.com> <dbbcc6b5-0d7d-440e-97e6-07b430d4f657@quicinc.com>
In-Reply-To: <dbbcc6b5-0d7d-440e-97e6-07b430d4f657@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 9 Jun 2025 01:19:58 +0300
X-Gm-Features: AX0GCFsSqVwr2GlCWKHyocv8W7CX1h3HA_b64ptWgi1iY9nS-_m-38QpEi89xUQ
Message-ID: <CAO9ioeXu5D6iG-Y4vJyrckj1DaZvjO7pMJTY4J16M-fW_p6rrg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add GPU support to X1P42100 SoC
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: rob.clark@oss.qualcomm.com, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: G1H0hqvoY2oyH-TU0XSjmC9dM37QhecM
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=68460c9b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=uWswUMS8ohN5UvJPIxQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: G1H0hqvoY2oyH-TU0XSjmC9dM37QhecM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDE4MiBTYWx0ZWRfX32Y92lXP7nOY
 5HCGaBtJXRy+Mau1Aw7b1FCxX5rxqDxYv+jLhi3XaGSAk8JykIALBMcijo0bgy/YjhPM1Ahvi11
 srG58/k2n9Lbaz+usGmbxlP4X6EzD3TvcY7cjO1swCMPUo3bICwD8NQYkdqI5MEgdzWV6n7yYNS
 RUbi6tznsmMqro6PQNNSBar4CnA9PzmC9kNX7sQHFbKzY6tcSwePGJk2gPjMWAKX98PJ4ZLtfR+
 0hnCgtJMg8D2D9ammP5K4FSzzI1ZmanrBzRFmSB3YQZVe/j4jsHhagXhhnzCT+8K3NDPJcOI91/
 p1jWD2ypcZlUIfGIrv1uy7CV6To32EdS+lRvf59mKCpKT2YG12eFDmovXNUF8Kc2mYlmHwZ+eRQ
 sjaakthWvjcl+uEjV4s8yc9a9SHTKhaoA+0vBhsVUGu6In0ZclyPZvdAOJm8LePXhxTTKSJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506080182

On Sun, 8 Jun 2025 at 23:18, Akhil P Oommen <quic_akhilpo@quicinc.com> wrot=
e:
>
> On 6/8/2025 8:52 PM, Dmitry Baryshkov wrote:
> > On 08/06/2025 18:20, Rob Clark wrote:
> >> On Sun, Jun 8, 2025 at 8:09=E2=80=AFAM Dmitry Baryshkov
> >> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>>
> >>> On Sun, Jun 08, 2025 at 07:10:11AM -0700, Rob Clark wrote:
> >>>> On Sat, Jun 7, 2025 at 1:17=E2=80=AFPM Dmitry Baryshkov
> >>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >>>>>
> >>>>> On Sat, Jun 07, 2025 at 07:45:01PM +0530, Akhil P Oommen wrote:
> >>>>>> X1P42100 SoC has a new GPU called Adreno X1-45 which is a smaller
> >>>>>> version of Adreno X1-85 GPU. Describe this new GPU and also add
> >>>>>> the secure gpu firmware path that should used for X1P42100 CRD.
> >>>>>>
> >>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >>>>>> ---
> >>>>>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi    |   7 ++
> >>>>>>   arch/arm64/boot/dts/qcom/x1p42100-crd.dts |   4 +
> >>>>>>   arch/arm64/boot/dts/qcom/x1p42100.dtsi    | 121 ++++++++++++++++
> >>>>>> +++++++++++++-
> >>>>>>   3 files changed, 131 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/
> >>>>>> boot/dts/qcom/x1e80100.dtsi
> >>>>>> index
> >>>>>> a8eb4c5fe99fe6dd49af200a738b6476d87279b2..558d7d387d7710770244fcc9=
01f461384dd9b0d4 100644
> >>>>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>>> @@ -8245,6 +8245,13 @@ sbsa_watchdog: watchdog@1c840000 {
> >>>>>>                        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HI=
GH>;
> >>>>>>                };
> >>>>>>
> >>>>>> +             qfprom: efuse@221c8000 {
> >>>>>> +                     compatible =3D "qcom,x1e80100-qfprom",
> >>>>>> "qcom,qfprom";
> >>>>>> +                     reg =3D <0 0x221c8000 0 0x1000>;
> >>>>>> +                     #address-cells =3D <1>;
> >>>>>> +                     #size-cells =3D <1>;
> >>>>>> +             };
> >>>>>> +
> >>>>>>                pmu@24091000 {
> >>>>>>                        compatible =3D "qcom,x1e80100-llcc-bwmon",
> >>>>>> "qcom,sc7280-llcc-bwmon";
> >>>>>>                        reg =3D <0 0x24091000 0 0x1000>;
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/x1p42100-crd.dts b/arch/
> >>>>>> arm64/boot/dts/qcom/x1p42100-crd.dts
> >>>>>> index
> >>>>>> cf07860a63e97c388909fb5721ae7b9729b6c586..cf999c2cf8d4e0af83078253=
fd39ece3a0c26a49 100644
> >>>>>> --- a/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/x1p42100-crd.dts
> >>>>>> @@ -15,3 +15,7 @@ / {
> >>>>>>        model =3D "Qualcomm Technologies, Inc. X1P42100 CRD";
> >>>>>>        compatible =3D "qcom,x1p42100-crd", "qcom,x1p42100";
> >>>>>>   };
> >>>>>> +
> >>>>>> +&gpu_zap_shader {
> >>>>>> +     firmware-name =3D "qcom/x1p42100/gen71500_zap.mbn";
> >>>>>> +};
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/
> >>>>>> boot/dts/qcom/x1p42100.dtsi
> >>>>>> index
> >>>>>> 27f479010bc330eb6445269a1c46bf78ec6f1bd4..5ed461ed5cca271d43647888=
aa6eacac3de2ac9d 100644
> >>>>>> --- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
> >>>>>> @@ -17,15 +17,134 @@
> >>>>>>   /delete-node/ &cpu_pd9;
> >>>>>>   /delete-node/ &cpu_pd10;
> >>>>>>   /delete-node/ &cpu_pd11;
> >>>>>> +/delete-node/ &gpu_opp_table;
> >>>>>>   /delete-node/ &pcie3_phy;
> >>>>>>
> >>>>>>   &gcc {
> >>>>>>        compatible =3D "qcom,x1p42100-gcc", "qcom,x1e80100-gcc";
> >>>>>>   };
> >>>>>>
> >>>>>> -/* The GPU is physically different and will be brought up later *=
/
> >>>>>> +&gmu {
> >>>>>> +     /delete-property/ compatible;
> >>>>>> +     compatible =3D "qcom,adreno-gmu-x145.0", "qcom,adreno-gmu";
> >>>>>> +};
> >>>>>> +
> >>>>>> +&qfprom {
> >>>>>> +     gpu_speed_bin: gpu_speed_bin@119 {
> >>>>>> +             reg =3D <0x119 0x2>;
> >>>>>> +             bits =3D <7 9>;
> >>>>>> +     };
> >>>>>> +};
> >>>>>> +
> >>>>>>   &gpu {
> >>>>>>        /delete-property/ compatible;
> >>>>>
> >>>>> I think, you can drop this line.
>
> I wasn't sure about this and I thought it was harmless to delete it.
> Anyway, I will remove the "delete" from both GPU and GMU nodes.

You can always run fdtdump on the compiled file and check the contents.

>
> >>>>>
> >>>>>> +
> >>>>>> +     compatible =3D "qcom,adreno-43030c00", "qcom,adreno";
> >>>>>> +
> >>>>>> +     nvmem-cells =3D <&gpu_speed_bin>;
> >>>>>> +     nvmem-cell-names =3D "speed_bin";
> >>>>>> +
> >>>>>> +     gpu_opp_table: opp-table {
> >>>>>> +             compatible =3D "operating-points-v2-adreno",
> >>>>>> "operating-points-v2";
> >>>>>> +
> >>>>>> +             opp-1400000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <1400000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L4=
>;
> >>>>>> +                     opp-peak-kBps =3D <16500000>;
> >>>>>> +                     qcom,opp-acd-level =3D <0xa8295ffd>;
> >>>>>> +                     opp-supported-hw =3D <0x3>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-1250000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <1250000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L3=
>;
> >>>>>> +                     opp-peak-kBps =3D <16500000>;
> >>>>>> +                     qcom,opp-acd-level =3D <0x882a5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0x7>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-1107000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <1107000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO_L1=
>;
> >>>>>> +                     opp-peak-kBps =3D <16500000>;
> >>>>>> +                     qcom,opp-acd-level =3D <0x882a5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0xf>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-1014000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <1014000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_TURBO>;
> >>>>>> +                     opp-peak-kBps =3D <14398438>;
> >>>>>> +                     qcom,opp-acd-level =3D <0xa82a5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0xf>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-940000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <940000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_NOM_L1>;
> >>>>>> +                     opp-peak-kBps =3D <14398438>;
> >>>>>> +                     qcom,opp-acd-level =3D <0xa82a5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0xf>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-825000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <825000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_NOM>;
> >>>>>> +                     opp-peak-kBps =3D <12449219>;
> >>>>>> +                     qcom,opp-acd-level =3D <0x882b5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0xf>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-720000000 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <720000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L2>;
> >>>>>> +                     opp-peak-kBps =3D <10687500>;
> >>>>>> +                     qcom,opp-acd-level =3D <0xa82c5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0xf>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             opp-666000000-0 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <666000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
> >>>>>> +                     opp-peak-kBps =3D <8171875>;
> >>>>>> +                     qcom,opp-acd-level =3D <0xa82d5ffd>;
> >>>>>> +                     opp-supported-hw =3D <0xf>;
> >>>>>> +             };
> >>>>>> +
> >>>>>> +             /* Only applicable for SKUs which has 666Mhz as Fmax=
 */
> >>>>>> +             opp-666000000-1 {
> >>>>>> +                     opp-hz =3D /bits/ 64 <666000000>;
> >>>>>> +                     opp-level =3D <RPMH_REGULATOR_LEVEL_SVS_L1>;
> >>>>>> +                     opp-peak-kBps =3D <16500000>;
> >>>>>
> >>>>> This looks odd, why is it so high?
> >>>>
> >>>> You want max bandwidth on max opp
> >>>
> >>> Yes, but can it actually sustain / provide this BW?
> >>>
> >>
> >> I'd have to trust Akhil on that one, but I have no reason to believe
> >> otherwise.  Just pointing out we've done analogous things elsewhere
> >> (for ex, cpu bw for sc7180-lite.dtsi)
>
> Window's GPU KMD seems to vote Max bandwidth for this SKU, so I think
> this is fine. Our GPUs from last few generations can easily saturate DDR
> with the right usecase.


Ack


--=20
With best wishes
Dmitry

