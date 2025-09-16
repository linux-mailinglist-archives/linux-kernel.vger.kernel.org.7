Return-Path: <linux-kernel+bounces-818564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D1B5936A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CD1BC5BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F76304BC8;
	Tue, 16 Sep 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oD6gwrt7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB76302CA2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018167; cv=none; b=CqsmoIi4UE9wF9mSpz/IWAKsTnJMzc0gWzUHD33sAJUDa1U/5WSosys/zTrLx8r919tyGB85/r/VQYNod/ugoBFQ0BRale4zGaCGn0xvAu1YYrdXp3pyNCvG2eR4iUL7XuUgGVe2eonjBvl7SrFw0wtzUIM0Tsq9w/j+lFJjf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018167; c=relaxed/simple;
	bh=LzZojb8/MP/ud/lu3eiFwzOTg0vcJ9FUBYQHsGJbXuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKu+zFTO1G1f24OwvHpGS8H6HFWsQ7A1qEXG2YcoGsvv5y5YEKejzoQuSaOrzlm0K0qj9uRijf36CkX8O8Rvt11s8qd0tfdC2sSKBomZHLkX5Po6ZpXJLvtTka0BzwljsCm9QJ2/Pxq/5EYrOQaja+mJ6PWnPojTNFDU6sxtc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oD6gwrt7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pkAp010790
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dsUOBXT5fPZdjovhyA0wRCif
	VQsPU7vYwfY5SFsZzbo=; b=oD6gwrt7ciUJllEv81O9W7uKYMyG/zXIQnn6C1OG
	cY40DALBKYR5oWNLzLIHdoRJaoio5HW2upCbuR9IQaVQB6FBE07CA7AL7JWS0xIP
	5FZM/24W6bQB4b6Qccb53Nmw0JxexMzmBSafkcOKvXaDOwJseDpFNb38qrvAtvtl
	6B3VwIAyPmIlsTBQU9StRYXs2ZcZoOcYtRWBPQppRv2KFGTeYelqvMYlfkXxWYRk
	vHFjJ/n2f5+dikPZdYooBZyeoZHas2qU8HU8V32XCGtjy3TzzDejvsLEidZnpUoE
	2wa9JQKkrNqLjLeZZX4orM6xbOo6pkkD4zRsoWBEZTP8WA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snra64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:22:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-81b8d38504fso1833901285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018164; x=1758622964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsUOBXT5fPZdjovhyA0wRCifVQsPU7vYwfY5SFsZzbo=;
        b=Vs0BizzHADsMLL62JGV9G/fbP0WSWpIdu5gJt1gIPGuxZeLX6yGwwA37m98IuZTWew
         zGlX07BzORDxnv9X9qV8GLtwhOsQljz3SYQ6zzB9lh4s+CeUWOcdp9eEDXbaMVBD0kV5
         mccS59/aMTPWOKpg9QWXBQu1gDvCAqpJjqoHCJ0xDdiDoSTIsjmvqUYufkmhOWXWZrFx
         gXJucHLwddZql2i1wsnJThm0D92MNjy0SNvLogyWj3EgOIm4HQQjkEmtewXzc7aWpYgY
         RKzi8zJUOtFsoErXSJPM07iXuNZzi5PixfNtqogXYsIqk77PJwJBDjhVWboGoz+hLyE7
         yxPg==
X-Forwarded-Encrypted: i=1; AJvYcCXEAwDX0dTeXd3+FTa6tm32rw0//NAFkOgM0iqkAhPdWzPgpfHd5eUtyoHkfKGvuRfuJOMnedhLzIPnqYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTddOwUaWS9Pa5HvHJvza618XmoHZ7fMDdstott5znh0MnCEda
	BkXbAx8tce2uc+9+fuSBITP8ghcCX43MW3POe2fTI8PzAO5I+ceyg8xHgOhQQq/vrbBjBUWFn3e
	4sf+e81nq9zpF9WVBuJl1P5VGfASvtLVhJ+EfSWybgdjSto0CMtK/vWgeqRIA5Hx8x4U=
X-Gm-Gg: ASbGnct/Jy2puqJpFi6g0uOqUlmVnt93yPpag8MXIzcIDs+Q10lOlSPNnzCae70Dlyz
	+p3nTG3fiGDwR9cjt+h3s2PKa358p41CqaFpRKJwQF6HrgndchfWpKe8fgIa71XmnT677CZNgOy
	ZoZ1vIewfhjmJPtfLvJ7AXMNH9Ckr05Ff++VMl1J/8NXfyDai6N7yWSw6SklrSOrutkyaKVIpGo
	lnVnWKrHGT8SNQl6zPGe+kgZxe+1MIAK18Jvom8D2vh3qsEeVNqFntAC0eewwLbtXYWu/mZlaKS
	uRy/JBXKWueqXI+GEh1gc3hdp3hna0AP//r6o+2wuDnAgIS7CGBzmzHDLEiKUVQk/4f2tyl6Jsz
	u5hi4hZyOyMYac7LV2Mfad3vlN23UgptE85QwXXTuuth5pXVtpO4a
X-Received: by 2002:ac8:7d0f:0:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4b77d043018mr173775341cf.31.1758018163953;
        Tue, 16 Sep 2025 03:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmt1N76y524zCMYAdzsEX4rsQJe+HhKzBcwZrhZwRUGHsN/sSmGe8IqeLhMm02zuV2vMtz1w==
X-Received: by 2002:ac8:7d0f:0:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4b77d043018mr173774961cf.31.1758018163402;
        Tue, 16 Sep 2025 03:22:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65a31cf5sm4237309e87.137.2025.09.16.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:22:42 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:22:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v2] dt-bindings: display/msm: dp-controller: Add SM6150
Message-ID: <5sg43rsun33i6bm3vz7io7yx2p4m7bmk5bnrnjg6u3zrulyofs@gyxtnfs4gvhz>
References: <20250916-add-dp-controller-support-for-sm6150-v2-1-e466da9bb77d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-add-dp-controller-support-for-sm6150-v2-1-e466da9bb77d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c93a75 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hSxh5nLx1FgLBnIhuNEA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: RpCH61qvgfvdFGBCEyqhWsVKVYMWARzC
X-Proofpoint-GUID: RpCH61qvgfvdFGBCEyqhWsVKVYMWARzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX42PMSB/rURY1
 SlHLPsYWoTdM//jYtWBTz34RfqdGqBq9JO9gzyV2D5xGIhGASbpO1oK+igbW9V4ZqbqcK5xfW4s
 ewxsYhcuF2RERl65DX3AL7ZCrJSMUJZf9EAp9z7daKIYQWAfxzSLvPZ/eiqjO/xJU2Xz2bkHTMo
 OgXDe4s8YU2sZFsmKO8I6CWcuueXb/PLoXcMChsA9ASWh+iLgcL2gaFhsoyVvUMqlsHjF7AfdvU
 N7U6IuqmeKjS6gqRiDiLjyjuV/EDalTU6HUCtbj74B955daWQf2VnbXVSz6AzwYA1jVocvJ/EIk
 v2gbSVD5t5rdgGG0JrhYQNKtxKRHeoGVylDMARfm/ZsmkV3xIbJlcOjz090WEvABJsH91fHLq9Y
 +BehwIU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Tue, Sep 16, 2025 at 03:31:35PM +0800, Xiangxu Yin wrote:
> Add DisplayPort controller binding for Qualcomm SM6150 SoC.
> 'qcom,sm6150-dp' uses the same controller IP as 'qcom,sm8150-dp'.
> Declare 'qcom,sm6150-dp' as a fallback compatible to 'qcom-sm8350-dp'
> for consistency with existing bindings and to ensure correct matching and
> future clarity.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
> This series splits the SM6150 dp-controller definition from the
> '[v3] Add DisplayPort support for QCS615 platform' series and rebases
> 'dt-bindings: msm/dp: Add support for 4 pixel streams'.
> 
> The devicetree modification for DisplayPort on SM6150 will be provided
> in a future patch.
> ---
> Changes in v2:
> - Update commit message and binding with fallback configuration. [Dmitry]
> - Drop driver patch since SM6150 is declared as a fallback to 'qcom-sm8350-dp'.
> - Link to v1: https://lore.kernel.org/r/20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index aeb4e4f36044a0ff1e78ad47b867e232b21df509..82481519005a1b038a351aa358b9266239d0e8a9 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -46,6 +46,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,sar2130p-dp
> +              - qcom,sm6150-dp


In the review to the previos iteration I think I was a bit explicit:
"qcom,sm6150-dp", "qcom,sm8150-dp", "qcom-sm8350-dp". You seemed to
agree to it. Now you didn't implemet that. Why?

>                - qcom,sm7150-dp
>                - qcom,sm8150-dp
>                - qcom,sm8250-dp
> 
> ---
> base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> change-id: 20250916-add-dp-controller-support-for-sm6150-525ac2ed8c86
> 
> Best regards,
> -- 
> Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

