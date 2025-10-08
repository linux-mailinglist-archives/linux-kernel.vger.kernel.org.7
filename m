Return-Path: <linux-kernel+bounces-845145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A15BC3B20
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624193BAD1A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD42F549E;
	Wed,  8 Oct 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oT/VQP0T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FC2F5483
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908746; cv=none; b=MsuIDkel6JMlSFKHbW9bUMWrJwfMocvNVt5T2GMkXRRvy1pQ94/rP+A9M/H5x0VRnlAdEdelAeAEy3CZRoKrhUbHi3XZRoRYl3VvV4EifNhMQHZyyOTVsy5gC+X6j45fzaarI5Isp3ngPegGmgWM195boayj+IFN0FMhsp7Z2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908746; c=relaxed/simple;
	bh=jh6UkzNl+DTGeEljlKIF+q1+nI6R4/qrb27HHLhQs5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjoDwtXQMhCNK1Zkp4I9rVtZ3t6OFU8gjxLLU0/ABiC/YF69ejLoDx50awCGGnjVGM/+bhl3YEaCVnc92PjQ4k8fHXbSkgZc3C38HCJUpV2Gp+R1RnjUAxSxYgCgUG1arJUKZ4LAfW88yZWvzjaYdJVqa3ui3ni6Bol1GLjMZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oT/VQP0T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803mWm006236
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 07:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O1fzCvC/mud0h6/8oCdHHnGn9nJk3gPg86nsBkzf1MU=; b=oT/VQP0TxHLlenzZ
	sxjW96377A7DqNd7g94GUx7psR/7d4zqeSikYWua+iiO0FKEktbzd0zqsvT+Dyno
	XD8JyyHH5B1h1EN8PLvOrDayuZMhZIqZL4wvmBxCuQfxMggFL5kk+gkz7zoF/RlI
	u+xuMwR2sX9ZG5TMgKxRNvTY4yfeZ7D5TJ3kuSr9c0Iz0r4CKYmt/20yGVqBrMHx
	rjDseX2xMGsVP3DnugXiqQQ2ANr9INPrJ+nswWL6m2yteriDlgh/rUEnJr3kb32x
	WzgPaFqXwfErGkzyt4iTq//UR0gthgxUB0jwFp2NqkkxGdwHPLLawdhIOD73RQdB
	6hYj7A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy71nsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:32:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eeb9730d9so72195265ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908742; x=1760513542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1fzCvC/mud0h6/8oCdHHnGn9nJk3gPg86nsBkzf1MU=;
        b=otVDUx/0UugM2k97AuuBzYsSBSi1+pgUVfq5dYiLuPSiiAoHLno3TuoxbEtvQN44Vr
         YOy6ojPHWBFcCtSQyrxT2W8OY1vqqqaOjEKQ2YPc8YaElIAUsfde4TYPXvhQVWKCWzB2
         Kg9Kyh6MJYxv4hF8E4/8zd4ExVAXvaE9DgpSVi4bGlJq5TAANx/H0lE5vi7BACXvsSm1
         o0t0h5WiOeSIaUtCnTEj+zAzDzDMSieOn4L19oXHvrUBua6JJ3voaloiinPy9SOQfCp3
         vsDefswShIc6sHvIr4mXp8eedJPeRqxO2y4JSOUQuX7D9nSEB6+oT0Nev/gtjIPkySAn
         HQfw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZYtwCTeSoB8PqTdQEADbdy+QgC3+/nZ1eK59b7iGBv/FFq6Upf53OqOcflvS/PKI3KwI59Ivz5gDR7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc8fIDk6sKRAlBVFG85qWFJzVMdAKgrkbp6/ihD+6R74SpxLc
	9wtv8YCrz0TUqkOBcLdpGbyPkdsw20NHI42mpmouL9sNau1vNp+tYBgKjeOKuzpUIpM4II5aQkC
	PRmg2d1rTYzDY5BvAE7EaFVcyh/ETmsyz9DoggYITf/cOBmJIxxCsmNq+QeOB3GemuC4=
X-Gm-Gg: ASbGnctiIiR1z06gmy5zAQuR+L02LaRc6kyoyGDXFzacStaI5IFEj/iANpEl1dOp4iv
	iH9zmrwj5OGInc1vcXHkqyabhC1gFKwo0RwfOvVUAX+hGbixBgPP8KBSBqeQNx1ujq1b84tbLvd
	fKhPD1o88CIsPgj0smpXbLTvema6AqHhHVwhmDaKWwGsZcWmc9oZBxnBityuhOs3Hr7qBjCZyXN
	d9mOBSC8DB8ktsoiCqt0jLN2GMfVC2TsfRWvCuLqebT5zNaHArNgN0RHD+3V4flZ+gubHNw1myn
	EWclARpbp1NCjF1nrrPcZGY7u5DrtdS0xT3+37kAwWNRGyGLo0/+XNvE1Oc1J0eHKjC4jhX/
X-Received: by 2002:a17:903:acb:b0:24b:270e:56cb with SMTP id d9443c01a7336-2902739b362mr32998295ad.27.1759908741558;
        Wed, 08 Oct 2025 00:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF8UQO63P5sJR771oG/+zCEQf8tTNKYiSviO1HlgbxCHP0JCB4Md6bptNeqiLM2cManUuPuQ==
X-Received: by 2002:a17:903:acb:b0:24b:270e:56cb with SMTP id d9443c01a7336-2902739b362mr32997755ad.27.1759908740874;
        Wed, 08 Oct 2025 00:32:20 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51395229sm2215138a91.17.2025.10.08.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:32:20 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:02:14 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] arm64: dts: qcom: Add EL2 overlay for Lemans
Message-ID: <20251008073214.kcanrljguox2vtzq@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-12-de841623af3c@oss.qualcomm.com>
 <yef5jtmcfuks2w2sngxr4a4htihxx4xidsgwpro6wckbfvmvvn@jfr3dlsdf5vm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yef5jtmcfuks2w2sngxr4a4htihxx4xidsgwpro6wckbfvmvvn@jfr3dlsdf5vm>
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e61387 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=3fz2ViL2mOl_e04HJqEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=eSe6kog-UzkA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rwmer-b_FKnsKHuJ8U9xaQQ6F5FfixQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX/ZTy6p1/KYqV
 NxrzdU/1gat1LFuMwSySDp7bbe9bOKaEs36gUGrou6r8SrnIWnys3lDd74e5hsoqyQR3GGjXmxg
 md9DBd5XNsXxUOjZTgz1GSu9/b49/f0TWCGg5XRwsxSZaVeNlDC4ODy1lDh4fMbnaVBKi8nbH2B
 /gd9Gzj1y+T204vugUTN6FvlF+GlyrXVc+vclCqKPem78vafkqG9DaFkpt+LQyJ1ci91K/wTMSx
 2lLr6L2CBJ9FGaW4tISrgMI5NXfToYkgEF0xlUtgDb0YvIhlIb9pLkcB1Gz5DrghXeY5kC1FHM3
 mpv+rITp3sdxT+piwbKQQOycqYEOB/seMInn6NwP8SFxtF/HyNkTgz0icvoUdlTyRqFz1AVQ/Nc
 kXz+i5Wl/jN16DF+6M+4YQQ6MShB7w==
X-Proofpoint-ORIG-GUID: rwmer-b_FKnsKHuJ8U9xaQQ6F5FfixQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On Tue, Oct 07, 2025 at 02:55:04PM -0700, Manivannan Sadhasivam wrote:
> On Tue, Oct 07, 2025 at 10:18:57PM +0530, Mukesh Ojha wrote:
> > All the Lemans IOT variants boards are using Gunyah hypervisor which
> > means that, so far, Linux-based OS could only boot in EL1 on those
> > devices.  However, it is possible for us to boot Linux at EL2 on these
> > devices [1].
> > 
> > When running under Gunyah, remote processor firmware IOMMU streams is
> > controlled by the Gunyah however when Linux take ownership of it in EL2,
> > It need to configure it properly to use remote processor.
> > 
> > Add a EL2-specific DT overlay and apply it to Lemans IOT variant
> > devices to create -el2.dtb for each of them alongside "normal" dtb.
> > 
> > [1]
> > https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile        |  7 +++++-
> >  arch/arm64/boot/dts/qcom/lemans-el2.dtso | 41 ++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 296688f7cb26..e2eb6c4f8e25 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -35,6 +35,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
> >  lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
> >  
> >  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-camera-csi1-imx577.dtb
> > +lemans-evk-el2-dtbs := lemans-evk.dtb lemans-el2.dtbo
> > +dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk-el2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= monaco-evk.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8216-samsung-fortuna3g.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
> > @@ -136,7 +138,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-vision-mezzanine.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8300-ride.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qcs8550-aim300-aiot.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb
> > -dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb
> > +qcs9100-ride-el2-dtbs := qcs9100-ride.dtb lemans-el2.dtbo
> > +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride.dtb qcs9100-ride-el2.dtb
> > +qcs9100-ride-r3-el2-dtbs := qcs9100-ride-r3.dtb lemans-el2.dtbo
> > +dtb-$(CONFIG_ARCH_QCOM)	+= qcs9100-ride-r3.dtb qcs9100-ride-r3-el2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/lemans-el2.dtso b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
> > new file mode 100644
> > index 000000000000..582b0a3a291a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/lemans-el2.dtso
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +/*
> > + * Lemans specific modifications required to boot in EL2.
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&iris {
> > +	/* TODO: Add video-firmware iommus to start IRIS from EL2 */
> 
> So the missing 'iommus' property is the only blocker to enable IRIS?

Yes, but this would require some changes in the driver as well to create
a platform device for the firmware and IOMMU domain, and to attach the
firmware device to the domain.

There was some discussion around this in v2[1], where I added support
for video. However, the change involved hooking into the video-firmware
property, which was used for Venus.  There were concerns[2] about following
the same approach for Iris, and due to that, we have dropped video
support for now.  However, an RFC has been posted from our side to
handle such scenarios[3], as of now unclear about the direction for
Iris.


[1] https://lore.kernel.org/lkml/aKooCFoV3ZYwOMRx@linaro.org/

[2] https://lore.kernel.org/lkml/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/

[3] https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/

[4] https://lore.kernel.org/lkml/4a32bbec-2baf-4210-a7c1-1ddcd45d30c8@oss.qualcomm.com/
> 
> - Mani
> 
> > +	status = "disabled";
> > +};
> > +
> > +/*
> > + * When running under Gunyah, remote processor firmware IOMMU streams is
> > + * controlled by the Gunyah however when we take ownership of it in EL2,
> > + * we need to configure it properly to use remote processor.
> > + */
> > +&remoteproc_adsp {
> > +	iommus = <&apps_smmu 0x3000 0x0>;
> > +};
> > +
> > +&remoteproc_cdsp0 {
> > +	iommus = <&apps_smmu 0x21c0 0x0400>;
> > +};
> > +
> > +&remoteproc_cdsp1 {
> > +	iommus = <&apps_smmu 0x29c0 0x0400>;
> > +};
> > +
> > +&remoteproc_gpdsp0 {
> > +       iommus = <&apps_smmu 0x38a0 0x0>;
> > +};
> > +
> > +&remoteproc_gpdsp1 {
> > +       iommus = <&apps_smmu 0x38c0 0x0>;
> > +};
> > 
> > -- 
> > 2.50.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
-Mukesh Ojha

