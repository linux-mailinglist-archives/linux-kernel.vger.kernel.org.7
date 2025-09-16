Return-Path: <linux-kernel+bounces-819114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A8B59BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD54E3A651D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8921CC59;
	Tue, 16 Sep 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlyuVcXr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35423AB8F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035288; cv=none; b=PBOSrdEV9ZQO0ItknKhz+Hy3/Sq/lp2RXfsAC7Ek+3NcRRXJy1CpEOagC6mudoRWdQ5HLKrtLvxZZ7bI+T4Jv0gzXnGiHnubns14Q0nKqB7WnJ9cMSuxnO3TzpgwvKefMchRBH6z6LPCq8ieP4QXh+7T6+V/FrG5cqPY5xgsIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035288; c=relaxed/simple;
	bh=+/iokOMthEBqZY0nc3dCTFOtJ9aBIskV8eLPLw7WHO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLvp4WFz/GiPckHni618icrsWDP5miikbRXYsxOpqa3C/o39lSiJXWwaQlIxYJVIFblWwJb6Xj++Eg4UXpY7Gwwph/fHpNyt+antnzbuV5S2SsftRJ+akGsKLEsuAprKkI8gLAwnCCCNK/a7ErTijncAxVCbpjU2ztD2U0JEN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlyuVcXr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9tHpH007954
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MPO+d98w+3iOJ7r1VX7ngwgK
	hIE+yDWZLLAhoG1dbAg=; b=nlyuVcXrJnUzhyRVPM1B6Sphd+3+fE2FQG7VCLXF
	NYYrAzC4DyDkngeC2PxazuxgS5kUV/sJpQRiR/m3oB4DNFXSBxoX2XSsLdeMaWFa
	lCFyRt4SyfsSyoaJyStpK1E9u8n9DtGJNjPhBl/UinzqrQC1UxE1YP/9llNTL6WF
	itkb3xCrZcjvmwJECZQyxDPtluvoXSM7+CXTUiHh5figsW/4YeWQEgL91vkPFVq/
	ITYzGCxBw9OKqI1EhCZ7bQpQNa8OR5KqeyaYD6JGUJHTaRSd7jB5AocqD/oj9bGW
	aTZnb0BxbfpjEdaCzaU6/CBLx2LhDFeoD/YAVha8T4YtuA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4y95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:08:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b62de0167aso140901401cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035284; x=1758640084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPO+d98w+3iOJ7r1VX7ngwgKhIE+yDWZLLAhoG1dbAg=;
        b=iAxhKMIUwLMvQObyVOdIf9n57VX/9ax1PPftOkextDMIj2cIdMg1Wj1L7X4DpVteIa
         qBDblk9Y+qGlj7098nbsG4TqbU4eUMwuDXUCZnEdYCS+RQedSGpbJOVeGWkHjMYRT5pN
         R3K1RkuKW7gJYsDt7pC2O3FvW7NlrpjKdgAX6FXcXd/jkydodahkAF4L4Zn9u4h6hYUX
         VKQ/toylqxTo8J1EGDNKk6RG2yQ6D2KLaJrQ0R/6ECQgGuKk8MTM0O6JzkHOHvoE+ZXB
         wUP40ZVoxQCawsBlrOfDgj1ujhKwawLz4oI2eHGbZlSebHIGNJR6BS2AatK1xjDg2fh7
         Do0w==
X-Forwarded-Encrypted: i=1; AJvYcCV3n1dh5Gy0uU8w3nmO5J4TmXmQGq0HGF6NaOzxnZK7l+O8a8UkZ1Ls4N3RSUg/djHLGXkytRtjxPl/gEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywnqA5nwh2UQmX8YEIbdAIVKpPv7uUfgbpnj/xi5cLMSkcmAu
	wqLr1jmYfcFJ8QJZ7gBgn9SkraTL6Lr12vFGlipY1tyy3hJOckh6fzPOozKPjKrCihlmVUngpxb
	DTQPTzF1Hr48iHiQ+L8Zg8VGCe8c/wo9hQJ1f90td9rXj61kDyO/qog83dKUpyZuNwSo=
X-Gm-Gg: ASbGncs4oSAWVJbM0ln9cVKRO8zN5Wur30aGi9iakzWShn61fTRb+zjLNlYVlVuQklm
	N3+v9G7Gye0uCduNL4mni6RVdxFLDz3mqdPSwD0qp88uOm7BvZnlNAg9+6HjJ29SOdqinWfIHhY
	yPvbrXLFdNZ776H7g7gcej88sczIwLV+OfIeVQ/Nyo5DIATiUeTAid34q+n6nSsjgmi93jC0EdL
	6zHdAF1gaOVu0y8tjsZ+v6Nacc+109VQ4ArE3Dh6qzGIKQpxsV+UrkUT9zmf7dsA4RD/xkpwRDm
	jX5aCwITKQV79csF+muP5WPsHX8tzi1uec2qpVfEYxiEoBALUuYBQiEz0/NRPMeY3jkxr16iIPS
	Qqv9ZkH+RBPOBrNM/NasJKGa8iOI4xidqWT10ZcCq2WDMgEgveEYd
X-Received: by 2002:a05:622a:1a8b:b0:4b5:781c:883b with SMTP id d75a77b69052e-4b77d111997mr260538721cf.73.1758035283716;
        Tue, 16 Sep 2025 08:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrACAfwl8ZeXemoXPckpMD2j5mK+zZ9+PVxetZdWKuYlRe0KBFSwXVAvO+6fqdZftYcLUzBQ==
X-Received: by 2002:a05:622a:1a8b:b0:4b5:781c:883b with SMTP id d75a77b69052e-4b77d111997mr260537811cf.73.1758035283070;
        Tue, 16 Sep 2025 08:08:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e651919d1sm4559897e87.126.2025.09.16.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:08:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:08:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jishnu.prakash@oss.qualcomm.com
Subject: Re: [PATCH v2 2/4] dt-bindings: rpmh-regulator: Update pmic-id
 property description
Message-ID: <6oyrycnarpfpsguinbxur7bjltpvlhyhowzktetqk52zeabvf4@6fn7pnw7aehh>
References: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
 <20250916-glymur-rpmh-regulator-driver-v2-2-c6593ff9b4be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v2-2-c6593ff9b4be@oss.qualcomm.com>
X-Proofpoint-GUID: xw14B2hPL2ZVVzNY8yAZeO5is2zfIJdK
X-Proofpoint-ORIG-GUID: xw14B2hPL2ZVVzNY8yAZeO5is2zfIJdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX/WO97UQaqNMX
 PO5ov4SEHmqD0uoZJ2TXZwaDFINBU63luiAQChsw59WLcbYKuf1Y+5bBdCqbk4Gej9Lis6ZUsys
 qdJXaqGpuyRayHYMoLtyX/TEriGgoNmTkAASd2C2INNYYrzOEnMfYVK8Ok08ybXcwPXJ/sdFXAC
 C+wKieyqnYZv//NG2Ejsag5zwNZBT4sBuQIbZ9E4AfRG41vrYrFK9Hryev+VgzqbaIPYt2+zgj+
 Il9x4Nk8W4He0P5cbAL2gDKIKgelHsY8WoXQTmwEg8kQRqfhj+J4H+GHR/vOEILTYT1krwgu6eg
 oGmggDSninS7wUTRMc8oNVZVqblty42fZD43yMBw/mDCTROzWJb+Q8idCMMeLPX28HhN5BCRnQf
 KP0JRd/M
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c97d55 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KtqaayFS73-macfLQeYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On Tue, Sep 16, 2025 at 06:28:53PM +0530, Kamal Wadhwa wrote:
> The `pmic-id` property previously accepted a single lowercase alphabet
> in the range [a-n]. However, on new targets such as Glymur, the
> property uses a new format: `[A-N]_E[0-3]`, where `[A-N]` represents
> the PMIC ID and `[0-3]` represents the BUS ID.

You are sstating that the property uses a different format. Instead you
should write that on these platforms there are multiple SPMI bus in use,
so pmic-id needs to specify both PMIC 'letter' and bus ID. The proposed
format follows the cmd-db format.

> 
> Update the property description to reflect this new pattern format,
> matching the updated driver implementation.
> 
> Note - Old format [a-n] is still valid and will work for existing
> targets.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> index 40e57b10ebbebeff130871b6d978df64111b6f29..40ddc64577e78b5c0dbb7b4e8893a08e8b37c92e 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> @@ -108,7 +108,7 @@ properties:
>          RPMh resource name suffix used for the regulators found
>          on this PMIC.
>      $ref: /schemas/types.yaml#/definitions/string
> -    enum: [a, b, c, d, e, f, g, h, i, j, k, l, m, n]
> +    pattern: "^[a-n]|[A-N]_E[0-3]+$"
>  
>    qcom,always-wait-for-ack:
>      description: |
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

