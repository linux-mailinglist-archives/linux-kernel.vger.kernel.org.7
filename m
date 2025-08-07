Return-Path: <linux-kernel+bounces-759231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3740B1DAB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C162E169912
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C02638AF;
	Thu,  7 Aug 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exD0yFXl"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844941993B7;
	Thu,  7 Aug 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580250; cv=none; b=qRvxZWn1vdWf70DvS5wWKtFB+zRR4RkTPI53aKpkl7E7QJygUjjnIOte7/+czV6ai163ABdBPXYBdKREO78AIxi9gP4mhf/QGTShn1PG3Lwrv/ni/3g18X0yAEs3EkhUzithewiUXItTpsblUN3pIh1ZrowyZV+22NknJRq706E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580250; c=relaxed/simple;
	bh=k+zjVqNK6IpFaIdpP99gdR7KFIejjFIdgN3WjT8KTls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhGYszZjMcnSMzC6ICh7C0esuSWsv6DQIantx8fUs7QYrSOhljrfiqkkv4WdfU9HESpjLbtSaz2e/7L8JFhbtoK4Z9LNkRkCDABT/m852eSRpJGpTCUsIoLSSMoVLRts7fOCcuO7QXmZQtOeEhWlxsFXSpL34gvhs3X8Dmxf4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exD0yFXl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2400f746440so8715105ad.2;
        Thu, 07 Aug 2025 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580248; x=1755185048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+QGSUNmqnrccosw4m2fT3iSYiKZuCt6rUjz3z0Gujdg=;
        b=exD0yFXlZ06TY188jf8uDqHDEm8q+g8FOevWVDIuliGoragk659XZ4DR5TVMOT8fML
         tqkpPtE8KSWC73Tq/H5JIPoSltEqQz2CHMcjROAwOk3VnGs8aEl0pqADL9cL5XB3JTLv
         f7J8bA1dndfoL2fmBwtsZxCShZuNvfvXzagA9+MUcOhIFrFZL/IAqjg8R3yK+U7f8GxC
         vo6qTCYw4SxSJozg+hAKm7tIaxVmoOg9Z7k3fUcmK8FVW6zm7JSTQKbsMyv+k9zxWEGI
         ygvUvJtXS5R9M+Juf9modiHlqsHhUmHoPyvcyVb88n8Hzg2FYuf+V4iFYGaLKiPrbUZS
         sWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580248; x=1755185048;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QGSUNmqnrccosw4m2fT3iSYiKZuCt6rUjz3z0Gujdg=;
        b=GpRfqlfwqvVEs2STil7rnMfr7qlv6sYENrvhsznpSwk+FOULpsUpBY10Hxk6DEt8V7
         cF9WGLddOTKeKmG+IxnF5WufcxK0NGFgOLpmBYWwPbpDYHSBgrdPy8q1Ea6rixVou77O
         MAQ52Xf0S7Hgh9QNUf4teNKPaFmAOzhSsiL/IKMY6iPhshegpEyECsBdJkEc8RAu5jXV
         GFpJ7pkmchnEqLwD7mjxXyPE/lJA5wupOOd77yyCAmQhw1i6jnXIXRx+SKtS9llqtoez
         DzELkri3l21h3QHVChd19ZLiZdUC655eM4NvArwYK9/zk11qwktxJOhoCMTUYw9jpTzP
         nHwg==
X-Forwarded-Encrypted: i=1; AJvYcCVqTg+RJ90h+RgDPxyEhZcJDnZw/NuGUZSj/5dp4lzG+yyPD2vEGTYO6JQ7vjioZB0ZrGdPEOx5RgWLv+CE@vger.kernel.org, AJvYcCWAvDBRaKQDcEr0YnkqhDPs1H53tmMBa4T0hXy6/hFLZcXkq5KCUfp0mEy4vF0kwtg5ptBKeTvr/AAV@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4/7nAUBcwYBzo/GHpdaK9iUIIBiIrTaVEQ5mx4DbGAFAeKXQ
	rGCKopZsdPIrciRMyhW537FE30MfY3KgilMo2hSF/+xwU+1WMMxNU5UB
X-Gm-Gg: ASbGnctidR1FbRidWLjrNN5TU10vifvhgf8/KkNAzk3pfzenh9wN5xrZwZu/Eb9JVjp
	s9z3XeBfcVypQ9TK8US1oe+w8iFxTGMWAvT2PS9J4tAlgwtd6A4gHHHEV1im8ZMxx5HcS+jiOeu
	lG9oiFsJv4bv2vVeJDQEXD9Rp/FuWUcqlaCqTP4gLN/DtkSCkVlB3iqisPSBEIuXMBfSxCzg5qj
	IA5uaFaWpGqnqD5UqBSP6cm+NRdthCxuY9CnfgKVd3Wnegw5oyS36Ew47fqXebSuPKM9PP947j2
	a8v30FcNy5ZAL+mrxLBxXAJKQS9op4Pw6e/O5STDyuxfAQ2DOAyB2hxmH+TXrVoV+kFj2YreJPl
	3ctNK3FJUNiNOK/3lwPRTF3yXC3LNV8Fo1+ZIznD810ULnTy8pivVw2jCnhSGmeDg7sQ62HsWji
	gYrFlRGg==
X-Google-Smtp-Source: AGHT+IEthTIgDF2dPn+C/6toUmPAco5BDAGi2NToxRPwvbHKKRXsFdxrwMuVF+pq0yI7tV4ccZs0EQ==
X-Received: by 2002:a17:902:fc48:b0:240:fc:abd7 with SMTP id d9443c01a7336-2429f4ae2aemr126613285ad.31.1754580247407;
        Thu, 07 Aug 2025 08:24:07 -0700 (PDT)
Received: from [192.168.0.29] (static-158-13-61-95.ipcom.comunitel.net. [95.61.13.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7562sm187340375ad.24.2025.08.07.08.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 08:24:06 -0700 (PDT)
Message-ID: <e0cf50c6-39cc-4b15-8aad-53821b5ae28e@gmail.com>
Date: Thu, 7 Aug 2025 17:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: mt8189: Add bindings for MM &
 APU & INFRA IOMMU
To: zhengnan chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250807095756.11840-1-zhengnan.chen@mediatek.com>
 <20250807095756.11840-2-zhengnan.chen@mediatek.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250807095756.11840-2-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2025 11:57, zhengnan chen wrote:
> From: "zhengnan chen" <zhengnan.chen@mediatek.com>
> 
> There are three iommu in total, namely MM_IOMMU, APU_IOMMU, INFRA_IOMMU,
> Add bindings for them.
> 
> Signed-off-by: zhengnan chen <zhengnan.chen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/iommu/mediatek,iommu.yaml        |   7 +
>   .../memory/mediatek,mt8189-memory-port.h      | 283 ++++++++++++++++++
>   2 files changed, 290 insertions(+)
>   create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 75750c64157c..32ca618c08dc 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -82,6 +82,9 @@ properties:
>             - mediatek,mt8188-iommu-vdo        # generation two
>             - mediatek,mt8188-iommu-vpp        # generation two
>             - mediatek,mt8188-iommu-infra      # generation two
> +          - mediatek,mt8189-iommu-apu        # generation two
> +          - mediatek,mt8189-iommu-infra      # generation two
> +          - mediatek,mt8189-iommu-mm         # generation two
>             - mediatek,mt8192-m4u  # generation two
>             - mediatek,mt8195-iommu-vdo        # generation two
>             - mediatek,mt8195-iommu-vpp        # generation two
> @@ -128,6 +131,7 @@ properties:
>         This is the mtk_m4u_id according to the HW. Specifies the mtk_m4u_id as
>         defined in
>         dt-binding/memory/mediatek,mt8188-memory-port.h for mt8188,
> +      dt-binding/memory/mediatek,mt8189-memory-port.h for mt8189,
>         dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
>         dt-binding/memory/mt2712-larb-port.h for mt2712,
>         dt-binding/memory/mt6779-larb-port.h for mt6779,
> @@ -164,6 +168,7 @@ allOf:
>                 - mediatek,mt8186-iommu-mm
>                 - mediatek,mt8188-iommu-vdo
>                 - mediatek,mt8188-iommu-vpp
> +              - mediatek,mt8189-iommu-mm
>                 - mediatek,mt8192-m4u
>                 - mediatek,mt8195-iommu-vdo
>                 - mediatek,mt8195-iommu-vpp
> @@ -180,6 +185,7 @@ allOf:
>               - mediatek,mt8186-iommu-mm
>               - mediatek,mt8188-iommu-vdo
>               - mediatek,mt8188-iommu-vpp
> +            - mediatek,mt8189-iommu-mm
>               - mediatek,mt8192-m4u
>               - mediatek,mt8195-iommu-vdo
>               - mediatek,mt8195-iommu-vpp
> @@ -208,6 +214,7 @@ allOf:
>               contains:
>                 enum:
>                   - mediatek,mt8188-iommu-infra
> +                - mediatek,mt8189-iommu-infra
>                   - mediatek,mt8195-iommu-infra
>   
>       then:
> diff --git a/include/dt-bindings/memory/mediatek,mt8189-memory-port.h b/include/dt-bindings/memory/mediatek,mt8189-memory-port.h
> new file mode 100644
> index 000000000000..849fead3d0f7
> --- /dev/null
> +++ b/include/dt-bindings/memory/mediatek,mt8189-memory-port.h
> @@ -0,0 +1,283 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Zhengnan chen <zhengnan.chen@mediatek.com>
> + */
> +#ifndef _DT_BINDINGS_MEMORY_MEDIATEK_MT8189_MEMORY_PORT_H_
> +#define _DT_BINDINGS_MEMORY_MEDIATEK_MT8189_MEMORY_PORT_H_
> +
> +#include <dt-bindings/memory/mtk-memory-port.h>
> +
> +#define SMI_L0_ID		(0)
> +#define SMI_L1_ID		(1)
> +#define SMI_L2_ID		(2)
> +#define SMI_L4_ID		(3)
> +#define SMI_L7_ID		(4)
> +#define SMI_L9_ID		(5)
> +#define SMI_L11_ID		(6)
> +#define SMI_L13_ID		(7)
> +#define SMI_L14_ID		(8)
> +#define SMI_L16_ID		(9)
> +#define SMI_L17_ID		(10)
> +#define SMI_L19_ID		(11)
> +#define SMI_L20_ID		(12)
> +
> +/*
> + * MM IOMMU supports 16GB dma address. We separate it to four ranges:
> + * 0 ~ 4G; 4G ~ 8G; 8G ~ 12G; 12G ~ 16G, we could adjust these masters
> + * locate in anyone region. BUT:
> + * a) Make sure all the ports inside a larb are in one range.
> + * b) The iova of any master can NOT cross the 4G/8G/12G boundary.
> + *
> + * This is the suggested mapping in this SoC:
> + *
> + * modules		dma-address-region	larbs-ports
> + * disp/mdp		0 ~ 4G			larb0/1/2
> + * vcodec		4G ~ 8G                 larb4/7
> + * imgsys/cam/ipesys	8G ~ 12G                the other larbs.
> + * N/A			12G ~ 16G
> + */
> +
> +/* Larb0 -- disp */
> +#define M4U_L0_P0_DISP_OVL0_4L_HDR		MTK_M4U_ID(SMI_L0_ID, 0)
> +#define M4U_L0_P1_DISP_OVL0_4L_RDMA0		MTK_M4U_ID(SMI_L0_ID, 1)
> +#define M4U_L0_P2_DISP_OVL1_4L_RDMA1		MTK_M4U_ID(SMI_L0_ID, 2)
> +#define M4U_L0_P3_DISP_OVL0_4L_RDMA2		MTK_M4U_ID(SMI_L0_ID, 3)
> +#define M4U_L0_P4_DISP_OVL1_4L_RDMA3		MTK_M4U_ID(SMI_L0_ID, 4)
> +#define M4U_L0_P5_DISP_RDMA0			MTK_M4U_ID(SMI_L0_ID, 5)
> +#define M4U_L0_P6_DISP_WDMA0			MTK_M4U_ID(SMI_L0_ID, 6)
> +#define M4U_L0_P7_DISP_FAKE_ENG0		MTK_M4U_ID(SMI_L0_ID, 7)
> +
> +/* Larb1 -- disp */
> +#define M4U_L1_P0_DISP_OVL1_4L_HDR		MTK_M4U_ID(SMI_L1_ID, 0)
> +#define M4U_L1_P1_DISP_OVL1_4L_RDMA0		MTK_M4U_ID(SMI_L1_ID, 1)
> +#define M4U_L1_P2_DISP_OVL0_4L_RDMA1		MTK_M4U_ID(SMI_L1_ID, 2)
> +#define M4U_L1_P3_DISP_OVL1_4L_RDMA2		MTK_M4U_ID(SMI_L1_ID, 3)
> +#define M4U_L1_P4_DISP_OVL0_4L_RDMA3		MTK_M4U_ID(SMI_L1_ID, 4)
> +#define M4U_L1_P5_DISP_RDMA1			MTK_M4U_ID(SMI_L1_ID, 5)
> +#define M4U_L1_P6_DISP_WDMA1			MTK_M4U_ID(SMI_L1_ID, 6)
> +#define M4U_L1_P7_DISP_FAKE_ENG1		MTK_M4U_ID(SMI_L1_ID, 7)
> +
> +/* Larb2 -- mmlsys(mdp) */
> +#define M4U_L2_P0_MDP_RDMA0			MTK_M4U_ID(SMI_L2_ID, 0)
> +#define M4U_L2_P1_MDP_RDMA1			MTK_M4U_ID(SMI_L2_ID, 1)
> +#define M4U_L2_P2_MDP_WROT0			MTK_M4U_ID(SMI_L2_ID, 2)
> +#define M4U_L2_P3_MDP_WROT1			MTK_M4U_ID(SMI_L2_ID, 3)
> +#define M4U_L2_P4_MDP_DUMMY0			MTK_M4U_ID(SMI_L2_ID, 4)
> +#define M4U_L2_P5_MDP_DUMMY1			MTK_M4U_ID(SMI_L2_ID, 5)
> +#define M4U_L2_P6_MDP_RDMA2			MTK_M4U_ID(SMI_L2_ID, 6)
> +#define M4U_L2_P7_MDP_RDMA3			MTK_M4U_ID(SMI_L2_ID, 7)
> +#define M4U_L2_P8_MDP_WROT2			MTK_M4U_ID(SMI_L2_ID, 8)
> +#define M4U_L2_P9_MDP_WROT3			MTK_M4U_ID(SMI_L2_ID, 9)
> +#define M4U_L2_P10_DISP_FAKE0			MTK_M4U_ID(SMI_L2_ID, 10)
> +
> +/* Larb3: null */
> +
> +/* Larb4 -- vdec */
> +#define M4U_L4_P0_HW_VDEC_MC_EXT		MTK_M4U_ID(SMI_L4_ID, 0)
> +#define M4U_L4_P1_HW_VDEC_UFO_EXT		MTK_M4U_ID(SMI_L4_ID, 1)
> +#define M4U_L4_P2_HW_VDEC_PP_EXT		MTK_M4U_ID(SMI_L4_ID, 2)
> +#define M4U_L4_P3_HW_VDEC_PRED_RD_EXT		MTK_M4U_ID(SMI_L4_ID, 3)
> +#define M4U_L4_P4_HW_VDEC_PRED_WR_EXT		MTK_M4U_ID(SMI_L4_ID, 4)
> +#define M4U_L4_P5_HW_VDEC_PPWRAP_EXT		MTK_M4U_ID(SMI_L4_ID, 5)
> +#define M4U_L4_P6_HW_VDEC_TILE_EXT		MTK_M4U_ID(SMI_L4_ID, 6)
> +#define M4U_L4_P7_HW_VDEC_VLD_EXT		MTK_M4U_ID(SMI_L4_ID, 7)
> +#define M4U_L4_P8_HW_VDEC_VLD2_EXT		MTK_M4U_ID(SMI_L4_ID, 8)
> +#define M4U_L4_P9_HW_VDEC_AVC_MV_EXT		MTK_M4U_ID(SMI_L4_ID, 9)
> +#define M4U_L4_P10_HW_VDEC_RG_CTRL_DMA_EXT	MTK_M4U_ID(SMI_L4_ID, 10)
> +#define M4U_L4_P11_HW_VDEC_UFO_ENC_EXT		MTK_M4U_ID(SMI_L4_ID, 11)
> +
> +/* Larb5: null */
> +
> +/* Larb6: null */
> +
> +/* Larb7 -- venc */
> +#define M4U_L7_P0_VENC_RCPU			MTK_M4U_ID(SMI_L7_ID, 0)
> +#define M4U_L7_P1_VENC_REC			MTK_M4U_ID(SMI_L7_ID, 1)
> +#define M4U_L7_P2_VENC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 2)
> +#define M4U_L7_P3_VENC_SV_COMV			MTK_M4U_ID(SMI_L7_ID, 3)
> +#define M4U_L7_P4_VENC_RD_COMV			MTK_M4U_ID(SMI_L7_ID, 4)
> +#define M4U_L7_P5_JPGENC_Y_RDMA			MTK_M4U_ID(SMI_L7_ID, 5)
> +#define M4U_L7_P6_JPGENC_C_RDMA			MTK_M4U_ID(SMI_L7_ID, 6)
> +#define M4U_L7_P7_JPGENC_Q_RDMA			MTK_M4U_ID(SMI_L7_ID, 7)
> +#define M4U_L7_P8_VENC_SUB_W_LUMA		MTK_M4U_ID(SMI_L7_ID, 8)
> +#define M4U_L7_P9_JPGENC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 9)
> +#define M4U_L7_P10_VENC_CUR_LUMA		MTK_M4U_ID(SMI_L7_ID, 10)
> +#define M4U_L7_P11_VENC_CUR_CHROMA		MTK_M4U_ID(SMI_L7_ID, 11)
> +#define M4U_L7_P12_VENC_REF_LUMA		MTK_M4U_ID(SMI_L7_ID, 12)
> +#define M4U_L7_P13_VENC_REF_CHROMA		MTK_M4U_ID(SMI_L7_ID, 13)
> +#define M4U_L7_P14_VENC_SUB_R_LUMA		MTK_M4U_ID(SMI_L7_ID, 14)
> +#define M4U_L7_P15_JPGDEC_WDMA			MTK_M4U_ID(SMI_L7_ID, 15)
> +#define M4U_L7_P16_JPGDEC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 16)
> +#define M4U_L7_P17_JPGDEC_HUFF_OFFSET		MTK_M4U_ID(SMI_L7_ID, 17)
> +
> +/* Larb8: null */
> +
> +/* Larb9 --imgsys */
> +#define M4U_L9_P0_IMGI_D1			MTK_M4U_ID(SMI_L9_ID, 0)
> +#define M4U_L9_P1_IMGBI_D1			MTK_M4U_ID(SMI_L9_ID, 1)
> +#define M4U_L9_P2_DMGI_D1			MTK_M4U_ID(SMI_L9_ID, 2)
> +#define M4U_L9_P3_DEPI_D1			MTK_M4U_ID(SMI_L9_ID, 3)
> +#define M4U_L9_P4_LCE_D1			MTK_M4U_ID(SMI_L9_ID, 4)
> +#define M4U_L9_P5_SMTI_D1			MTK_M4U_ID(SMI_L9_ID, 5)
> +#define M4U_L9_P6_SMTO_D2			MTK_M4U_ID(SMI_L9_ID, 6)
> +#define M4U_L9_P7_SMTO_D1			MTK_M4U_ID(SMI_L9_ID, 7)
> +#define M4U_L9_P8_CRZO_D1			MTK_M4U_ID(SMI_L9_ID, 8)
> +#define M4U_L9_P9_IMG3O_D1			MTK_M4U_ID(SMI_L9_ID, 9)
> +#define M4U_L9_P10_VIPI_D1			MTK_M4U_ID(SMI_L9_ID, 10)
> +#define M4U_L9_P11_SMTI_D5			MTK_M4U_ID(SMI_L9_ID, 11)
> +#define M4U_L9_P12_TIMGO_D1			MTK_M4U_ID(SMI_L9_ID, 12)
> +#define M4U_L9_P13_UFBC_W0			MTK_M4U_ID(SMI_L9_ID, 13)
> +#define M4U_L9_P14_UFBC_R0			MTK_M4U_ID(SMI_L9_ID, 14)
> +#define M4U_L9_P15_WPE_RDMA1			MTK_M4U_ID(SMI_L9_ID, 15)
> +#define M4U_L9_P16_WPE_RDMA0			MTK_M4U_ID(SMI_L9_ID, 16)
> +#define M4U_L9_P17_WPE_WDMA			MTK_M4U_ID(SMI_L9_ID, 17)
> +#define M4U_L9_P18_MFB_RDMA0			MTK_M4U_ID(SMI_L9_ID, 18)
> +#define M4U_L9_P19_MFB_RDMA1			MTK_M4U_ID(SMI_L9_ID, 19)
> +#define M4U_L9_P20_MFB_RDMA2			MTK_M4U_ID(SMI_L9_ID, 20)
> +#define M4U_L9_P21_MFB_RDMA3			MTK_M4U_ID(SMI_L9_ID, 21)
> +#define M4U_L9_P22_MFB_RDMA4			MTK_M4U_ID(SMI_L9_ID, 22)
> +#define M4U_L9_P23_MFB_RDMA5			MTK_M4U_ID(SMI_L9_ID, 23)
> +#define M4U_L9_P24_MFB_WDMA0			MTK_M4U_ID(SMI_L9_ID, 24)
> +#define M4U_L9_P25_MFB_WDMA1			MTK_M4U_ID(SMI_L9_ID, 25)
> +#define M4U_L9_P26_RESERVE6			MTK_M4U_ID(SMI_L9_ID, 26)
> +#define M4U_L9_P27_RESERVE7			MTK_M4U_ID(SMI_L9_ID, 27)
> +#define M4U_L9_P28_RESERVE8			MTK_M4U_ID(SMI_L9_ID, 28)
> +
> +/* Larb10: null */
> +
> +/* Larb11 -- imgsys */
> +#define M4U_L11_P0_IMGI_D1			MTK_M4U_ID(SMI_L11_ID, 0)
> +#define M4U_L11_P1_IMGBI_D1			MTK_M4U_ID(SMI_L11_ID, 1)
> +#define M4U_L11_P2_DMGI_D1			MTK_M4U_ID(SMI_L11_ID, 2)
> +#define M4U_L11_P3_DEPI_D1			MTK_M4U_ID(SMI_L11_ID, 3)
> +#define M4U_L11_P4_LCE_D1			MTK_M4U_ID(SMI_L11_ID, 4)
> +#define M4U_L11_P5_SMTI_D1			MTK_M4U_ID(SMI_L11_ID, 5)
> +#define M4U_L11_P6_SMTO_D2			MTK_M4U_ID(SMI_L11_ID, 6)
> +#define M4U_L11_P7_SMTO_D1			MTK_M4U_ID(SMI_L11_ID, 7)
> +#define M4U_L11_P8_CRZO_D1			MTK_M4U_ID(SMI_L11_ID, 8)
> +#define M4U_L11_P9_IMG3O_D1			MTK_M4U_ID(SMI_L11_ID, 9)
> +#define M4U_L11_P10_VIPI_D1			MTK_M4U_ID(SMI_L11_ID, 10)
> +#define M4U_L11_P11_SMTI_D5			MTK_M4U_ID(SMI_L11_ID, 11)
> +#define M4U_L11_P12_TIMGO_D1			MTK_M4U_ID(SMI_L11_ID, 12)
> +#define M4U_L11_P13_UFBC_W0			MTK_M4U_ID(SMI_L11_ID, 13)
> +#define M4U_L11_P14_UFBC_R0			MTK_M4U_ID(SMI_L11_ID, 14)
> +#define M4U_L11_P15_WPE_RDMA1			MTK_M4U_ID(SMI_L11_ID, 15)
> +#define M4U_L11_P16_WPE_RDMA0			MTK_M4U_ID(SMI_L11_ID, 16)
> +#define M4U_L11_P17_WPE_WDMA			MTK_M4U_ID(SMI_L11_ID, 17)
> +#define M4U_L11_P18_MFB_RDMA0			MTK_M4U_ID(SMI_L11_ID, 18)
> +#define M4U_L11_P19_MFB_RDMA1			MTK_M4U_ID(SMI_L11_ID, 19)
> +#define M4U_L11_P20_MFB_RDMA2			MTK_M4U_ID(SMI_L11_ID, 20)
> +#define M4U_L11_P21_MFB_RDMA3			MTK_M4U_ID(SMI_L11_ID, 21)
> +#define M4U_L11_P22_MFB_RDMA4			MTK_M4U_ID(SMI_L11_ID, 22)
> +#define M4U_L11_P23_MFB_RDMA5			MTK_M4U_ID(SMI_L11_ID, 23)
> +#define M4U_L11_P24_MFB_WDMA0			MTK_M4U_ID(SMI_L11_ID, 24)
> +#define M4U_L11_P25_MFB_WDMA1			MTK_M4U_ID(SMI_L11_ID, 25)
> +#define M4U_L11_P26_RESERVE6			MTK_M4U_ID(SMI_L11_ID, 26)
> +#define M4U_L11_P27_RESERVE7			MTK_M4U_ID(SMI_L11_ID, 27)
> +#define M4U_L11_P28_RESERVE8			MTK_M4U_ID(SMI_L11_ID, 28)
> +
> +/* Larb12: null */
> +
> +/* Larb13 -- cam */
> +#define M4U_L13_P0_MRAWI			MTK_M4U_ID(SMI_L13_ID, 0)
> +#define M4U_L13_P1_MRAWO_0			MTK_M4U_ID(SMI_L13_ID, 1)
> +#define M4U_L13_P2_MRAWO_1			MTK_M4U_ID(SMI_L13_ID, 2)
> +#define M4U_L13_P3_CAMSV_1			MTK_M4U_ID(SMI_L13_ID, 3)
> +#define M4U_L13_P4_CAMSV_2			MTK_M4U_ID(SMI_L13_ID, 4)
> +#define M4U_L13_P5_CAMSV_3			MTK_M4U_ID(SMI_L13_ID, 5)
> +#define M4U_L13_P6_CAMSV_4			MTK_M4U_ID(SMI_L13_ID, 6)
> +#define M4U_L13_P7_CAMSV_5			MTK_M4U_ID(SMI_L13_ID, 7)
> +#define M4U_L13_P8_CAMSV_6			MTK_M4U_ID(SMI_L13_ID, 8)
> +#define M4U_L13_P9_CCUI				MTK_M4U_ID(SMI_L13_ID, 9)
> +#define M4U_L13_P10_CCUO			MTK_M4U_ID(SMI_L13_ID, 10)
> +#define M4U_L13_P11_FAKE			MTK_M4U_ID(SMI_L13_ID, 11)
> +#define M4U_L13_P12_PDAI_0			MTK_M4U_ID(SMI_L13_ID, 12)
> +#define M4U_L13_P13_PDAI_1			MTK_M4U_ID(SMI_L13_ID, 13)
> +#define M4U_L13_P14_PDAO			MTK_M4U_ID(SMI_L13_ID, 14)
> +
> +/* Larb14 -- cam */
> +#define M4U_L14_P0_RESERVE			MTK_M4U_ID(SMI_L14_ID, 0)
> +#define M4U_L14_P1_RESERVE			MTK_M4U_ID(SMI_L14_ID, 1)
> +#define M4U_L14_P2_RESERVE			MTK_M4U_ID(SMI_L14_ID, 2)
> +#define M4U_L14_P3_CAMSV_0			MTK_M4U_ID(SMI_L14_ID, 3)
> +#define M4U_L14_P4_CCUI				MTK_M4U_ID(SMI_L14_ID, 4)
> +#define M4U_L14_P5_CCUO				MTK_M4U_ID(SMI_L14_ID, 5)
> +#define M4U_L14_P6_CAMSV_7			MTK_M4U_ID(SMI_L14_ID, 6)
> +#define M4U_L14_P7_CAMSV_8			MTK_M4U_ID(SMI_L14_ID, 7)
> +#define M4U_L14_P8_CAMSV_9			MTK_M4U_ID(SMI_L14_ID, 8)
> +#define M4U_L14_P9_CAMSV_10			MTK_M4U_ID(SMI_L14_ID, 9)
> +
> +/* Larb15: null */
> +
> +/* Larb16 -- cam */
> +#define M4U_L16_P0_IMGO_R1_A			MTK_M4U_ID(SMI_L16_ID, 0)
> +#define M4U_L16_P1_RRZO_R1_A			MTK_M4U_ID(SMI_L16_ID, 1)
> +#define M4U_L16_P2_CQI_R1_A			MTK_M4U_ID(SMI_L16_ID, 2)
> +#define M4U_L16_P3_BPCI_R1_A			MTK_M4U_ID(SMI_L16_ID, 3)
> +#define M4U_L16_P4_YUVO_R1_A			MTK_M4U_ID(SMI_L16_ID, 4)
> +#define M4U_L16_P5_UFDI_R2_A			MTK_M4U_ID(SMI_L16_ID, 5)
> +#define M4U_L16_P6_RAWI_R2_A			MTK_M4U_ID(SMI_L16_ID, 6)
> +#define M4U_L16_P7_RAWI_R3_A			MTK_M4U_ID(SMI_L16_ID, 7)
> +#define M4U_L16_P8_AAO_R1_A			MTK_M4U_ID(SMI_L16_ID, 8)
> +#define M4U_L16_P9_AFO_R1_A			MTK_M4U_ID(SMI_L16_ID, 9)
> +#define M4U_L16_P10_FLKO_R1_A			MTK_M4U_ID(SMI_L16_ID, 10)
> +#define M4U_L16_P11_LCESO_R1_A			MTK_M4U_ID(SMI_L16_ID, 11)
> +#define M4U_L16_P12_CRZO_R1_A			MTK_M4U_ID(SMI_L16_ID, 12)
> +#define M4U_L16_P13_LTMSO_R1_A			MTK_M4U_ID(SMI_L16_ID, 13)
> +#define M4U_L16_P14_RSSO_R1_A			MTK_M4U_ID(SMI_L16_ID, 14)
> +#define M4U_L16_P15_AAHO_R1_A			MTK_M4U_ID(SMI_L16_ID, 15)
> +#define M4U_L16_P16_LSCI_R1_A			MTK_M4U_ID(SMI_L16_ID, 16)
> +
> +/* Larb17 -- cam */
> +#define M4U_L17_P0_IMGO_R1_B			MTK_M4U_ID(SMI_L17_ID, 0)
> +#define M4U_L17_P1_RRZO_R1_B			MTK_M4U_ID(SMI_L17_ID, 1)
> +#define M4U_L17_P2_CQI_R1_B			MTK_M4U_ID(SMI_L17_ID, 2)
> +#define M4U_L17_P3_BPCI_R1_B			MTK_M4U_ID(SMI_L17_ID, 3)
> +#define M4U_L17_P4_YUVO_R1_B			MTK_M4U_ID(SMI_L17_ID, 4)
> +#define M4U_L17_P5_UFDI_R2_B			MTK_M4U_ID(SMI_L17_ID, 5)
> +#define M4U_L17_P6_RAWI_R2_B			MTK_M4U_ID(SMI_L17_ID, 6)
> +#define M4U_L17_P7_RAWI_R3_B			MTK_M4U_ID(SMI_L17_ID, 7)
> +#define M4U_L17_P8_AAO_R1_B			MTK_M4U_ID(SMI_L17_ID, 8)
> +#define M4U_L17_P9_AFO_R1_B			MTK_M4U_ID(SMI_L17_ID, 9)
> +#define M4U_L17_P10_FLKO_R1_B			MTK_M4U_ID(SMI_L17_ID, 10)
> +#define M4U_L17_P11_LCESO_R1_B			MTK_M4U_ID(SMI_L17_ID, 11)
> +#define M4U_L17_P12_CRZO_R1_B			MTK_M4U_ID(SMI_L17_ID, 12)
> +#define M4U_L17_P13_LTMSO_R1_B			MTK_M4U_ID(SMI_L17_ID, 13)
> +#define M4U_L17_P14_RSSO_R1_B			MTK_M4U_ID(SMI_L17_ID, 14)
> +#define M4U_L17_P15_AAHO_R1_B			MTK_M4U_ID(SMI_L17_ID, 15)
> +#define M4U_L17_P16_LSCI_R1_B			MTK_M4U_ID(SMI_L17_ID, 16)
> +
> +/* Larb19 -- ipesys */
> +#define M4U_L19_P0_DVS_RDMA			MTK_M4U_ID(SMI_L19_ID, 0)
> +#define M4U_L19_P1_DVS_WDMA			MTK_M4U_ID(SMI_L19_ID, 1)
> +#define M4U_L19_P2_DVP_RDMA			MTK_M4U_ID(SMI_L19_ID, 2)
> +#define M4U_L19_P3_DVP_WDMA			MTK_M4U_ID(SMI_L19_ID, 3)
> +
> +/* Larb20 -- ipesys */
> +#define M4U_L20_P0_FDVT_RDA_0			MTK_M4U_ID(SMI_L20_ID, 0)
> +#define M4U_L20_P1_FDVT_RDB_0			MTK_M4U_ID(SMI_L20_ID, 1)
> +#define M4U_L20_P2_FDVT_WRA_0			MTK_M4U_ID(SMI_L20_ID, 2)
> +#define M4U_L20_P3_FDVT_WRB_0			MTK_M4U_ID(SMI_L20_ID, 3)
> +#define M4U_L20_P4_RSC_RDMA			MTK_M4U_ID(SMI_L20_ID, 4)
> +#define M4U_L20_P5_RSC_WDMA			MTK_M4U_ID(SMI_L20_ID, 5)
> +
> +/* fake larb21 for gce */
> +#define M4U_L21_GCE_DM				MTK_M4U_ID(21, 0)
> +#define M4U_L21_GCE_MM				MTK_M4U_ID(21, 1)
> +
> +/* fake larb & port for svp and dual svp and wfd */
> +#define M4U_PORT_SVP_HEAP			MTK_M4U_ID(22, 0)
> +#define M4U_PORT_DUAL_SVP_HEAP			MTK_M4U_ID(22, 1)
> +#define M4U_PORT_WFD_HEAP			MTK_M4U_ID(22, 2)
> +
> +/* fake larb0 for apu */
> +#define M4U_L0_APU_DATA				MTK_M4U_ID(0, 0)
> +#define M4U_L0_APU_CODE				MTK_M4U_ID(0, 1)
> +#define M4U_L0_APU_SECURE			MTK_M4U_ID(0, 2)
> +#define M4U_L0_APU_VLM				MTK_M4U_ID(0, 3)
> +
> +/* infra/peri */
> +#define IFR_IOMMU_PORT_PCIE_0			MTK_IFAIOMMU_PERI_ID(0, 26)
> +
> +#endif


