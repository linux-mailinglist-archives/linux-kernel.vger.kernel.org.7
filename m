Return-Path: <linux-kernel+bounces-762433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DDBB206AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F007A6AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C6267B02;
	Mon, 11 Aug 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xje/E3oF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9E13AD1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909754; cv=none; b=Fsd7z5gubfpNBQ8zFNJc9TvusuawNdETcMqQgk7eJrDNsCzVmUIi/tQrhjuY3jv14WS203eywuh5fcuZETRzVdxzjdXy4aBfLn/jdChbRMSvAFSemcUK+Pj3ppF0G4/uq/ON0gIkXpFIDLwroG5hEEadE940z4DJN6iC5bCK5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909754; c=relaxed/simple;
	bh=EDlgtCGTTiPDS26OgrMplbuhmJKWPHHmP5ixMDSjbRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnurtZ/4z+wJbgaK6DW9UAGyC92DlxkeRsAb2/TFPAFy0Uk5Mgv2g5BJ+r603JXTin1aaXvt7HiAiwcPjeEZPyR49flxGhc23B3dJR52e5dFyuFqkiVhl5LjFkKMG/aKbgGhS8uMfpmaSF/a7Cirn6pTlxKQiY9MINyVqGLcgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xje/E3oF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d8tL000598
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mfNS104sZvUDxiTcLFxI/nq7
	cWMQCwJ3YOUX3c0FHSE=; b=Xje/E3oFVs9vdnrDl6g8LqFPDlxxovzpfF3DtGBI
	coW9ZStep+39hJVXf+ZTRRDPVQc+mn8X7kWnebVhd8CjTVDZBAHrZnaEfH98mnbK
	wf6jDOPJqt79qf+zlxmYfxknmSPDPUnGciPjJ9rZHD1J4sILU7HGeZgVLOms208b
	6g9ssb7x3/DwraUbRMrq51yP/6MCKz19321gq3BepgXsmJGfBbJftNpspMBejuDb
	v+cRInn+48Qntb/EFUa2WL99GbJkm1n2zYXWDbRWa58/2GHHXRJbTngb6erwxXDy
	Zq5WhoBYHpcZGSK8aNKcbOCHVSTfoQKBRfaao4YmpA17oQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxq6v1x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:55:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4aedd0b5af9so85527661cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909751; x=1755514551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfNS104sZvUDxiTcLFxI/nq7cWMQCwJ3YOUX3c0FHSE=;
        b=ghBv08m3pRLh8kemVdRgi0VqK4739M9FUfOyARsx5QyTkifQBrBQk4fbKzt+p5bwEo
         HdW5UXHMzfHaiv0anAb1KuZrLN5YsnBTwndW0zntdHNm15IXc1/lnptXnWZs8T86xwLj
         X8tovLsGdoFjBS/66AMPoJ42dofHy62+uUHWRupKtkkRE6zQ5DGrfVMi3GQga6modLoS
         paLQ13NviSmUxVEg1VjcUoGHRQf86D4LdmjB0pGS7NQtT1VJ5wcKDzYdAREnnnDYmnH9
         W4EGaWi6/9N+wXvr21+pXZj3TGeJ1tPAN6fKsqFvt7zS3QaT2rEXoNpPOqPtdr38LZHK
         n92Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4OHWO11+Q9XKGaOcGZyCwb8JoLgiZ2cyx3fka5JL9Po++R3eZmpNyrZ5Svp0QaTdXF9/D9+GU2RFPwiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnE4TKl+QB2v8RUX35GLeHw71HJfZ0LmXdV0jG/DGkezQSI+v
	bu3/q+cZc0jG+wuwI7vLdSe/zpDaQjwZRTjFEm+smTGRODAetbSdrEPfIVJDTI2zQbNOO16TEMn
	YRxKTui1rKtYPzv4lddlGJZe1HKJnA7E61WqT6UcP0pzFmBprCm46a9nyu2v+pHuIj8I=
X-Gm-Gg: ASbGncsaOMuejND0HNrrXIUf2PZIhkXpdF+KGfo5Z1tHvTDzy6A9NaVCYs8Aid9imyO
	9FMUs6FI44wkE4mMCZ9Qg7aTvPsIhGEySbVkoojCP9JiAHQKBTYH+JEAckweDaPEL50sLVZj+4M
	cb8ZHdYqEg/TZ5jZ41OjQzE/04D1sKtALgdroAb5cZJNUxt1gwNnZr0bhwIxzJUkSXQcpblMBxh
	cvjLDaVfiF1ncEgvNIrpBHfP9TtCS6ITOQ0agevNTx5x5UuZE6xlwkSy5BrtgW8C/D1GU2IuJ9/
	qToocQjJAF83N63z1BNggYcVnXGYrrgiM4FfvTxRhKZkrc4tc1cMoiFDOjefsRYQffnvdrV9dxN
	YkWti6LhiP6SZvijQOieM/ecJExlIW6neZYestPS0DhDPB1r8yKNc
X-Received: by 2002:a05:6214:cc7:b0:707:63b8:3d46 with SMTP id 6a1803df08f44-7099a30512cmr137320356d6.30.1754909751177;
        Mon, 11 Aug 2025 03:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJGm+AQRrMZQkHwEUDLQJriTk9mSlKcg15YnclWYqXloRwI6zRHEDtZsJFogLVGniPGmspvg==
X-Received: by 2002:a05:6214:cc7:b0:707:63b8:3d46 with SMTP id 6a1803df08f44-7099a30512cmr137319866d6.30.1754909750630;
        Mon, 11 Aug 2025 03:55:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca334asm4229151e87.131.2025.08.11.03.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:55:49 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:55:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/6] phy: qcom: qmp-combo: register a typec mux to
 change the QMPPHY_MODE
Message-ID: <y4yiyokoo7fclwlpyhct4o7mt6swustuciigqnte5pruust26q@ryvuwpd6h4qm>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-5-43272d6eca92@oss.qualcomm.com>
 <ibrupwvn5frzb4vo3eukb7p7pzonaxwhygshz743wmyrbprkcq@xcpt4ryzvwqr>
 <619efc83-37f3-4b4e-b756-c53ecd2f6867@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619efc83-37f3-4b4e-b756-c53ecd2f6867@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyOCBTYWx0ZWRfX8mlert5hm2qn
 aSyJqZ5iojFcsV4ByJbMUq/YdMYs3J/bx9IPmhhgZ2ApWaLxT2YRJ78L0wudX4b1wADFCwaB9jq
 kuHlLj7X3grl0tIQor1zAtQrchei8HPo5+BeDJCZUdja8pDKOgkb5y0P6ieyus2ZG5Y/quTeaKs
 DPLtnazzO5J8+ESWfkjo9Cxx1xiS2AHjFxG7ht+nVLjgWDVue4fFQ8RDElyQVjAIYyqpV3ryY7T
 ZwiSIJ9QhkcEjJ0Xm/RxmldEaBuOsmn3y7Eq41i8fT1/oDfxe8MOAHKm5tHOzEeC/+MVUker0oL
 ecnAcD40CaS1Er7XvxxitVUZStJyTauKtKIbDHtNx7bWJ1dnhOUEtutLIQe4lllgPUxdEPuf2s9
 YvJNRlzn
X-Authority-Analysis: v=2.4 cv=QYhmvtbv c=1 sm=1 tr=0 ts=6899cc38 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mUy4j-dTXB4InB_98JkA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5sFuP93XKYQ2rfrcK8RumHxBLQHQ_16c
X-Proofpoint-ORIG-GUID: 5sFuP93XKYQ2rfrcK8RumHxBLQHQ_16c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090028

On Mon, Aug 11, 2025 at 12:37:00PM +0200, Konrad Dybcio wrote:
> On 8/9/25 10:13 AM, Dmitry Baryshkov wrote:
> > On Thu, Aug 07, 2025 at 06:33:23PM +0200, Konrad Dybcio wrote:
> >> From: Neil Armstrong <neil.armstrong@linaro.org>
> >>
> >> Register a typec mux in order to change the PHY mode on the Type-C
> >> mux events depending on the mode and the svid when in Altmode setup.
> >>
> >> The DisplayPort phy should be left enabled if is still powered on
> >> by the DRM DisplayPort controller, so bail out until the DisplayPort
> >> PHY is not powered off.
> >>
> >> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
> >> will be set in between of USB-Only, Combo and DisplayPort Only so
> >> this will leave enough time to the DRM DisplayPort controller to
> >> turn of the DisplayPort PHY.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> [konrad: renaming, rewording, bug fixes]
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> ---
> >>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 118 ++++++++++++++++++++++++++++--
> >>  1 file changed, 113 insertions(+), 5 deletions(-)
> >>
> >> +
> >> +	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
> >> +		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying switch\n");
> >> +		return 0;
> >> +	}
> > 
> > I can't say that I'm fully happy about it, nevertheless:
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> IIUC we'll be able to get rid of it after the dp rework?

Which one? The HPD? not really. My unhappiness is about the sync between
USB and DP. I'm unsure whether we need higher level of sync for
USB-or-DP PHYs.

-- 
With best wishes
Dmitry

