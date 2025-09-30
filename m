Return-Path: <linux-kernel+bounces-837981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7055BAE2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32A67A36C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269230CB25;
	Tue, 30 Sep 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEWFjHsg"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE52FBE16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253082; cv=none; b=KlZvfEDBDn4KPpGEDy2GlQLuZbocaC+xaECqLU8yWH/qdhu2QlZjbztQGMkAEebUgh0Uw5+w7lBxZa6BYtM14nq3HQzPeXAEdccV9i6WQRnJcDD4+qym0kmHFyLcx/PwRNr0l8RKcOieRGBockhO2PdJVCwywos38ZZZqhzX6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253082; c=relaxed/simple;
	bh=uejollmX6UdW6EW80SMay1PeJ9j4GJBM65xwi4SUhUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tEH5hdpSg+ZUeh8Pv6T7+kRSrBh18Kfje5dAHUsZID85ejZu2xvWdRhRt8LUblLHYWsYNrdpujQFAXMuqLBMkzOy2WGe81KvBto2UgBIfiYAjWGhQrFZpm0ekb5GmJDvSFFGjRx+mo7qhAJYKO9b0KUx5mQXYae9Z/KX/Vv9rrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZEWFjHsg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42421b1514fso696396f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759253079; x=1759857879; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvVNpnk1em0RkZX+LraDKpmhOFpQMHJx3+utgoN6HFU=;
        b=ZEWFjHsgEVl/Tb2SsJRIFTFV/cnWfUhbR18Noj6IJOej8dCyGTPn1X/aUztRoF2/3+
         vMjVCVIkwzG6m7xMGmYDTFGZ8RHTPWepAIU/JlqJ41zkujaNUxImpqNFy1AVbcfLOJId
         /rcCs4mBZrRb/PQahnkliCqiTtozr2kWx02r/zW4WhDK4ss5B1fj6cCD3Tu498wXZG1A
         gKLvXXEFGpsAAtYB4VQWR3YZ5ttowHuutq4j4s7Rhyl52EYHKaq1Cqt4Y8hHtR7PSA0C
         lfFpfXsJta99QBcwa1EX8fLjopsE+iiOzsM/5Vk3keL8U9BvMdZ4Kxm0zPRVUsPdMfUp
         GhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253079; x=1759857879;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvVNpnk1em0RkZX+LraDKpmhOFpQMHJx3+utgoN6HFU=;
        b=jH3ylSFWD7aP6sUJgKgsb96R4s3lYKRSKKLDe/IEXxkkQ4lz/FYOntVe2AiWqscMpy
         Z1JAOYGyRFREOAB9OSnsZ99BA51nGolzGFeJIqkmvYmoBCyfALn+2xKa1GxFfuH4eHb0
         NxZ4HxUe77QU64oviPWiQo4Ei2AhZchImD2S7Qzux54lWz7LtCe0LGuMH9Rz0ttGS5TW
         LdeOtyKFaqFGXX1fnKHNnvcjqjSYfLoZrhbHW59zg7Hmvf8rOD+APHO/K71aALFKrYxx
         7hNTQT4U+csvxMASgjhlBKoIi803TpfIuPyAeYcMicNzHyXmXEfAb7q3NdMVz0igbi0N
         cWWw==
X-Forwarded-Encrypted: i=1; AJvYcCVoN7QYaGqQFNSJIfPDMj+7BJjPobOTUv6Lv/E+NXdnYRB2mQ7yZn3cV8MA0ZAq9CnnCuKJzzBwUW/WjoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylrg9osE48ZzzX7r04x2KmrBAa/4a9rShsvZx2zAdIa0m0fBXs
	GEdtaXmaQ70xxpVS8ykEFNWSmQzlZzCfgcv5Fu2JaXAogc1/F6HzKaUhiKQQEY6Sf/E=
X-Gm-Gg: ASbGncvjivUCcLRXMNSZ+ft2OuxGGXVE+2norv545ARG3HJF4JygQ3frPXog4F7iUjJ
	KG4pxZTVgM8cHYkhWRS0BmIqao1InO9NbGRvpyRII7bZDkc0a1/543p4cI5C1O7mT+pUHK+yhb6
	9cXzEI5OFpuR3Lvf1YA6kuThPBHCKecFc7wRkkGSFt/p/fyjfN4ixsNIRv68wa90m1SMJPmuUo8
	9VSjyKIOXfyTzj5+qe9i8L17SObcn0BD7meR9AbuCbMj91sWIc5N0/FWyTpGssQKdvkSbO2AQNk
	8rZ5RVIwQCIbpUYMZ3cdVgLx/qgd9z3EPotVMWaZQEdUVfjFsbOnQrvQrELwXoBWvysdpHKOLiZ
	mPUqbOSKXb08OTsLgjJqt6LZZc32+5XdOx2dlxezyzzLIaVhPnrVWHsGDSFc=
X-Google-Smtp-Source: AGHT+IGglgxN2Hhmv9KmUP8JA/GwoSDh33Ava4t+rFkJLhqrQMU1IiSGuBGFF+USzQgFE5I07APBdA==
X-Received: by 2002:a05:6000:220b:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-425577ecaa5mr439876f8f.2.1759253079123;
        Tue, 30 Sep 2025 10:24:39 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:248:54ff:fe20:c34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603161sm23914123f8f.35.2025.09.30.10.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Sep 2025 18:24:37 +0100
Message-Id: <DD6B62STZOTG.L12V3DGNDZUZ@linaro.org>
Cc: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aiqun.yu@oss.qualcomm.com>,
 <tingwei.zhang@oss.qualcomm.com>, <trilok.soni@oss.qualcomm.com>,
 <yijie.yang@oss.qualcomm.com>
Subject: Re: [PATCH 07/20] arm64: dts: qcom: kaanapali: Add remoteprocs for
 Kaanapali SoC
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Jingyi Wang" <jingyi.wang@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.20.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-7-3fdbc4b9e1b1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-7-3fdbc4b9e1b1@oss.qualcomm.com>

On Thu Sep 25, 2025 at 1:17 AM BST, Jingyi Wang wrote:
> Add remoteproc PAS loader for ADSP, CDSP, MPSS and SoCCP with
> its SMP2P and fastrpc nodes.
>
> Written with help from Kumari Pallavi(added fastrpc).

Co-developed-by tag then maybe?

Also I don't see this name in email addresses.

> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 484 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 484 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dt=
s/qcom/kaanapali.dtsi
> index 08ab267bf9a7..c3b38fd851c5 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -438,6 +438,121 @@ rmtfs_mem: rmtfs@d7c00000 {
>  		};
>  	};

[...]

> +		remoteproc_adsp: remoteproc@6800000 {
> +			compatible =3D "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
> +			reg =3D <0x0 0x06800000 0x0 0x10000>;
> +
> +			interrupts-extended =3D <&pdc 6 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names =3D "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack",
> +					  "shutdown-ack";
> +
> +			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names =3D "xo";
> +
> +			interconnects =3D <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_AL=
WAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> +
> +			power-domains =3D <&rpmhpd RPMHPD_LCX>,
> +					<&rpmhpd RPMHPD_LMX>;
> +			power-domain-names =3D "lcx",
> +					     "lmx";
> +
> +			memory-region =3D <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
> +
> +			qcom,qmp =3D <&aoss_qmp>;
> +
> +			qcom,smem-states =3D <&smp2p_adsp_out 0>;
> +			qcom,smem-state-names =3D "stop";
> +
> +			status =3D "disabled";
> +
> +			remoteproc_adsp_glink: glink-edge {
> +				interrupts-extended =3D <&ipcc IPCC_MPROC_LPASS
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +
> +				mboxes =3D <&ipcc IPCC_MPROC_LPASS
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				qcom,remote-pid =3D <2>;
> +
> +				label =3D "lpass";
> +
> +				fastrpc {
> +					compatible =3D "qcom,fastrpc";
> +					qcom,glink-channels =3D "fastrpcglink-apps-dsp";
> +					label =3D "adsp";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +
> +					compute-cb@3 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <3>;
> +
> +						iommus =3D <&apps_smmu 0x1003 0x80>,
> +							 <&apps_smmu 0x1043 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <4>;
> +
> +						iommus =3D <&apps_smmu 0x1004 0x80>,
> +							 <&apps_smmu 0x1044 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <5>;
> +
> +						iommus =3D <&apps_smmu 0x1005 0x80>,
> +							 <&apps_smmu 0x1045 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@6 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <6>;
> +
> +						iommus =3D <&apps_smmu 0x1006 0x80>,
> +							 <&apps_smmu 0x1046 0x20>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@7 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <7>;
> +
> +						iommus =3D <&apps_smmu 0x1007 0x40>,
> +							 <&apps_smmu 0x1067 0x0>,
> +							 <&apps_smmu 0x1087 0x0>;
> +						dma-coherent;
> +					};
> +				};
> +			};
> +		};

Fastrpc nodes here. Was this tested? If yes, then how?
Or was it just copied from somewhere from downstream?

The same questions basically go for cdsp fastrpc too.


[..]

> +				label =3D "cdsp";
> +
> +				fastrpc {
> +					compatible =3D "qcom,fastrpc";
> +					qcom,glink-channels =3D "fastrpcglink-apps-dsp";
> +					label =3D "cdsp";
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +
> +					compute-cb@1 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <1>;
> +						iommus =3D <&apps_smmu 0x19c1 0x0>,
> +							 <&apps_smmu 0x1961 0x0>,
> +							 <&apps_smmu 0x0c21 0x0>,
> +							 <&apps_smmu 0x0c01 0x40>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@2 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <2>;
> +						iommus =3D <&apps_smmu 0x1962 0x0>,
> +							 <&apps_smmu 0x0c02 0x20>,
> +							 <&apps_smmu 0x0c42 0x0>,
> +							 <&apps_smmu 0x19c2 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@3 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <3>;
> +						iommus =3D <&apps_smmu 0x1963 0x0>,
> +							 <&apps_smmu 0x0c23 0x0>,
> +							 <&apps_smmu 0x0c03 0x40>,
> +							 <&apps_smmu 0x19c3 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@4 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <4>;
> +						iommus =3D <&apps_smmu 0x1964 0x0>,
> +							 <&apps_smmu 0x0c44 0x0>,
> +							 <&apps_smmu 0x0c04 0x20>,
> +							 <&apps_smmu 0x19c4 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@5 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <5>;
> +						iommus =3D <&apps_smmu 0x1965 0x0>,
> +							 <&apps_smmu 0x0c45 0x0>,
> +							 <&apps_smmu 0x0c05 0x20>,
> +							 <&apps_smmu 0x19c5 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@6 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <6>;
> +						iommus =3D <&apps_smmu 0x1966 0x0>,
> +							 <&apps_smmu 0x0c06 0x20>,
> +							 <&apps_smmu 0x0c46 0x0>,
> +							 <&apps_smmu 0x19c6 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@7 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <7>;
> +						iommus =3D <&apps_smmu 0x1967 0x0>,
> +							 <&apps_smmu 0x0c27 0x0>,
> +							 <&apps_smmu 0x0c07 0x40>,
> +							 <&apps_smmu 0x19c7 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@8 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <8>;
> +						iommus =3D <&apps_smmu 0x1968 0x0>,
> +							 <&apps_smmu 0x0c08 0x20>,
> +							 <&apps_smmu 0x0c48 0x0>,
> +							 <&apps_smmu 0x19c8 0x0>;
> +						dma-coherent;
> +					};
> +
> +					/* note: secure cb9 in downstream */
> +
> +					compute-cb@12 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <12>;
> +						iommus =3D <&apps_smmu 0x196c 0x0>,
> +							 <&apps_smmu 0x0c2c 0x00>,
> +							 <&apps_smmu 0x0c0c 0x40>,
> +							 <&apps_smmu 0x19cc 0x0>;
> +						dma-coherent;
> +					};
> +
> +					compute-cb@13 {
> +						compatible =3D "qcom,fastrpc-compute-cb";
> +						reg =3D <13>;
> +						iommus =3D <&apps_smmu 0x196d 0x0>,
> +							 <&apps_smmu 0x0c0d 0x40>,
> +							 <&apps_smmu 0x0c2e 0x0>,
> +							 <&apps_smmu 0x0c2d 0x0>,
> +							 <&apps_smmu 0x19cd 0x0>;
> +						dma-coherent;
> +					};
> +				};
> +			};
> +		};
> +

Best regards,
Alexey


