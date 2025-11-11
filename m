Return-Path: <linux-kernel+bounces-895182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32518C4D242
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFFD189E6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF53502AC;
	Tue, 11 Nov 2025 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddEgJPr4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V8iUZUDv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7AA34F255
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857886; cv=none; b=XwNrBq6yDxcLNrvIMgF5JMMkG2PSVT65h7dk65cnE90Qhv2kN4+KU3GZxKo4NWv09JgWXbs8qGOXp8V5EaHizeM+MdOAsVsNDhGqjNJ/JyXtsbYZQBVy/giz0GNRU6QzwJYED5LyDPz7eKMQvxhnN7SWV8r038xoxjYwIR+Ppio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857886; c=relaxed/simple;
	bh=l4qzGLhBtZKVvPYErMopQnMHCiy48JJYZt1HwzSfHkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIWw9MuKHOXKdw596A9WbmuuA+hX8QyGkGqnBAlS/9ULvBX+1/hdyJi2XpSn5v7j837C3VtMH04o/PvRpmNtSPI5TpS5wudxpUP+y5MR9+QgmGqYOG3BJnUcKnuGrAR4+ee57ukf3lM1TEn4bzttqul4n++WijYBthaWVpCp/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddEgJPr4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V8iUZUDv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB4CFFw4166636
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+gJidX2jSCTw9eZSYR/rAxIe
	j1PUV2obwbP3TFa0zzM=; b=ddEgJPr4+Li/XCH84jYJ1+ok/h+JR9UGWG5P9mkv
	Urou+0Sajpsw7p08VbkUZ5OBHU/xZNEWI/mjR3rPcSTCjb4VWz0iz8/vj5vCSI07
	NrYxKT8YpyO/GewDTXt6sR/4Khn2q875EZ50t0QhCc0WWuCxQ9hypZS+YKsuyau7
	cl/+ptGvmEsa7JJ1pWGh0+b8rEjWOwNcyZxoyjXeYBMqcS96sC0i5Cb7iNOxVUWJ
	kujpsruh4eIw26qmjxXL7LvwrrBbynND0gnBIgm6SAR4mKRorgGP4X9fsCbp+Kli
	ZXvv8O+sIAkRIAlowtI8DVlxLjXV15mo8oZKT9SaOf81mw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abm4a2n9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:44:43 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-880501dcc67so16313126d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762857882; x=1763462682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gJidX2jSCTw9eZSYR/rAxIej1PUV2obwbP3TFa0zzM=;
        b=V8iUZUDvbu/G+Vzelf8nDTcIuZZkDkZP/MlnViMta84DQrc91/y1+3ksJMMzF85i4a
         ZiOnejyG+JKbrfsKFfqJS7NRLQyt4Nx4M55RQokp0DkRAYv9fy3Rh3w1uHQykGVaQXNP
         q8RkoOqqUupgY8NfyobjXAwrXLlim42J/Y7CgiTHTHMUyhlg+irsQd+4I41m9PWhqXap
         V81g8aWBJUypzGgfk+M45a/l2CXMd3Iq2WiW6NEup7uUhcvHywkWyiaIBX4LrHIv7/7O
         hsc9DMJ3PWVXnZMMFEW5jZdeVJzNpcc+SHx6+dbl2vHLKuhmkycV+fXVzKT1EIbIFkBi
         G0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857882; x=1763462682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gJidX2jSCTw9eZSYR/rAxIej1PUV2obwbP3TFa0zzM=;
        b=SCNJB+dVxcmrLSzWEixNPdv2LePdm3DhdMOeCuTP4rHJ6DlCgzBS/tHvdW82qsnpBJ
         6JCqL/STUMKAc6/PAn/feIuZF1qZ3ZquAU4apez/1O4gtwMm9Dm7Ub7kp2azdyfxfITY
         rmOyeUJCzJenUemqWzZvH9qwNZAAgYwo4SZU51+s5mU7iNGrz3wI9f8dzTKDWYZ65Gld
         p7OsVOZMe5JVqcWGslSLQBcggkrB2ldUhZpJf9vEET9pwRgBFH6x0b2ppfV8E3PuImcy
         GUGmghoWT76gD0v2paHlIZ+xcsemzhcq7x0Ge7FJ6hr1zJK7sCzRHHxU4nVa7bjxJ6Ql
         U+fg==
X-Forwarded-Encrypted: i=1; AJvYcCWPd1TZNyiNDTK0oxtL9AxHk/7WZ467E8Lmf3iLWK6iGWXPP24GGjaHCDisg3P5ajdUWPUz4WIrDCv6wBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaotUu628ad+/0gSeQLXgstt4z0BuVswT/9SexRzezovn8k9Mz
	YRHItkRR7Q4dLIMxTdhCTOjJCPoZOrBAxyp/IDL2PzJ0Rdm2IPTVYC3kugoMrESgwGyE4rERMvw
	14/7Sm/lvWlQepC7Idn8wtNMWOf8D774wOESc9YuxT6AGmMDjZpL0r8T4WbSmurrH4wE=
X-Gm-Gg: ASbGnctOMeuWeJyiZKs1PrEbzxckT7kER/Ux7Es2WnpBVpC85x1vopNPBP9FayuUViv
	EJ6MdASNyBCcihg6KBqNYwDOTqJWZ3IZNsfo6TPw2WVWBM3HRlGDgjGJvOW81Vd1o+vJwPhGBHW
	UCILrYUB8Qd34dUOQhn6M0R4jlLSkOq281pMuJajCuICLQP+rPCp+1bsNbl8qoOkg36YZO3k9ep
	5Av7+EqsQom0qnBcRIYi/0+WbqWRSZz4NY+WG5//Djtxhg8SbFQEvnLr1jBp/fx/tlKvB2w3cO4
	PtnbMf9khzRdySrhpfAdaLGF60x1L+d5Djh699buNtzKTE4WY2Q/CciiVa2bSQQG9+3W9g0Uu7x
	x5y5ATQfrTCvP9WpnyHkeP5Lpctjv451AweatzpIvxELVzcnjSvsjbAlB95wXQ40lW7mAsHXiy4
	AzIj61IBnV1u+Z
X-Received: by 2002:ad4:5d4e:0:b0:882:42e6:171a with SMTP id 6a1803df08f44-88242e619damr150475636d6.29.1762857882610;
        Tue, 11 Nov 2025 02:44:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAM+mG75Loc7VIPw8+rq7J3/vIHcL1Ua0krlGhv88BOq+sMjlUEwkZCEO/qmQc1KkRImTrhg==
X-Received: by 2002:ad4:5d4e:0:b0:882:42e6:171a with SMTP id 6a1803df08f44-88242e619damr150475456d6.29.1762857882152;
        Tue, 11 Nov 2025 02:44:42 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd168sm41817181fa.33.2025.11.11.02.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:44:41 -0800 (PST)
Date: Tue, 11 Nov 2025 12:44:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 0/6] Add support for Clock controllers for Kaanapali
Message-ID: <cl25p2tnh4stqxyaxfbuob2iaxb6f2nc6exvcobhpcrs77it4c@n3d4afm226fn>
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
X-Proofpoint-GUID: ToMNCsdUifNjcMkqQERTGU_dsxxuEiq2
X-Authority-Analysis: v=2.4 cv=G6kR0tk5 c=1 sm=1 tr=0 ts=6913139b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=nWbYhlpG0vUMga3LwYgA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: ToMNCsdUifNjcMkqQERTGU_dsxxuEiq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA4NCBTYWx0ZWRfX7LOPrbvayKTy
 muhh80PbJyF5sjuGmfcLI9nYKupqwutpDhLJIGnB/4peLCSugeD7Nv0V2vmxG3xk6TduRDO/yt7
 Fjj4z1888KNp1lCFcPrQYyZwM/cebRJd7k5H6HUc2zt52ubprTBVSlvXFtdmutakia6+lp5JWj6
 9bbmoJpbJxrQgYwZf0x+j2KaXy35Ch5iEeVjhsEttLd079nLsmTRKWg+vZkVqDiQ6H5fwhpnG5o
 igWoTtfShgklv+NjCj6d9rFZpwfD8zPcPmtUDMPKaks2+P97PzPXYDfQiQuQwnTmI/k7lbdPwub
 WBhdXeCRaK9yoINmTfTGpxwzgcbq6XcIDqqbntNHULcCxn5BptY8K++q0wGPoQOvrjovgj43RHo
 KFvYNq5CyuRGuK0fVrehSESoR6xD6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110084

On Thu, Oct 30, 2025 at 04:39:03PM +0530, Taniya Das wrote:
> Add support for Global clock controller(GCC), TCSR and the RPMH clock
> controller for the Qualcomm Kaanapali SoC.
> 
> Kaanapali(Snapdragon SoC from Qualcomm):
> https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-elite-gen-5
> 
> Changes in v2:
>   - Update the commit message for all dt-bindings to incorporate
>     "SoC/platform" inplace of drivers [Krzysztof]
>   - Add RB tag from [Krzysztof] for dt-bindings
>   - Split the TCSRCC to a new driver instead of reusing the SM8750
>     driver with offset updates [Dmitry]
>   - Update the new RPMH clocks to use 'clkN' convention [Dmitry]

This didn't happen

>   - Add RB tag from [Dmitry] for GCC
>   - This series does not have any strict PLL code dependencies [Bjorn], thus
>     drop them and will be added in the Multimedia clock controller
>     series. Drop the following patches.
> 	- Update the PLL support for cal_l
> 	- Add support for controlling Pongo EKO_T PLL
> 	- Add support for controlling Rivian PLL
>   - Link to v1: https://lore.kernel.org/lkml/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---
> Taniya Das (6):
>       dt-bindings: clock: qcom-rpmhcc: Add RPMHCC for Kaanapali
>       dt-bindings: clock: qcom: Document the Kaanapali TCSR Clock Controller
>       dt-bindings: clock: qcom: Add Kaanapali Global clock controller
>       clk: qcom: rpmh: Add support for Kaanapali rpmh clocks
>       clk: qcom: Add TCSR clock driver for Kaanapali
>       clk: qcom: Add support for Global clock controller on Kaanapali
> 
>  .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
>  .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
>  .../devicetree/bindings/clock/qcom,sm8750-gcc.yaml |    8 +-
>  drivers/clk/qcom/Kconfig                           |   17 +
>  drivers/clk/qcom/Makefile                          |    2 +
>  drivers/clk/qcom/clk-rpmh.c                        |   42 +
>  drivers/clk/qcom/gcc-kaanapali.c                   | 3541 ++++++++++++++++++++
>  drivers/clk/qcom/tcsrcc-kaanapali.c                |  141 +
>  include/dt-bindings/clock/qcom,kaanapali-gcc.h     |  241 ++
>  9 files changed, 3992 insertions(+), 2 deletions(-)
> ---
> base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
> change-id: 20251027-gcc_kaanapali-v2-901def0e1a52
> 
> Best regards,
> -- 
> Taniya Das <taniya.das@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

