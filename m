Return-Path: <linux-kernel+bounces-850509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B7BD304C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6759D3A4158
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92622727F8;
	Mon, 13 Oct 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Palj9H/Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B55262FCB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359074; cv=none; b=tyxwPWogVcV76tdKknnm+qP5ez6ePi9Ej1fqozyFk4X7ncnIbq8CjUeKD37CT7NBLMu3vovBwKGeJaZuUDXG2FUySOE69848NwDt3GGF0rCVWNFuezkOs+9A7tUQ02nj+3YPPXY505X2PteD+YFvuHt3beobV3t7wOPJmxRxeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359074; c=relaxed/simple;
	bh=aZGRCaEQAskD8nIjNVaot/fSIqSTel0rYFtYU6crRRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLMozoZBIzivxyhZQw05cP7vny9KldxKEkZGPWF7J1H1VIZqiAz5HvqHeAO7Kwdv6VUd6gdAqMJcxtNcjejnPxSJ5RTG1gURNPJl/A5NeuiI+w38lt8156UdK9TQhoMMIF2ljw6NPDocqpx7MNEEbn6McoAbuSUa4rOV3k86NyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Palj9H/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DB1dst017986
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UTXiDHZxjE5lYanBLZzc3WtP
	FhwD6zEyaiJPl3VCc+c=; b=Palj9H/ZHdSeQ9v8BmEGpcpToPtdkFkW8L9foVqF
	ma0Q1ih6Vl4BSwmHNHJip8SFxWjaPUnPkijbB4VH1suCrIPjty4Yc84bssgGeMkz
	YlcM7rGi7pTcoviN/WtNMDuncdFFQxwPk2wXEBMC2ddryPuWkzM/LoaqKh1gZds+
	Txq97tHGJjSZ4ihmFmyr+fYQUucuLypOmod2sd4WiKuelVCEp5Iyje9EZmhFaDsJ
	kREEkvjwGMCOFsY0eqoBnH0uZ3NvHxfrtABxbZozsX7wIGrFq8zrtlZet1NUdQWF
	3WoD985IMAHdfy6W+Br7NDrmgdCYGfBoBF8QKOC2Gwighg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk4hma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:37:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-827061b4ca9so2055466985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359070; x=1760963870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTXiDHZxjE5lYanBLZzc3WtPFhwD6zEyaiJPl3VCc+c=;
        b=GJhRG4n37ETvU+rKMKbJf2cofwJDO1iwC9D0doSWfNut/fHQuZbwqGxyrElFChTfBG
         gq/x+Oiz+mIpJYlGxRLUopSb1QWFft/dnG9ZiyQ4T/KcZUiBJvIVnjj8ZtbbeqZmfDHU
         WMpvw+Btcfdg9gJdWrV2vEeN5RJsGMpH7agKvKETh2UkeCuOt4aV17aDDtxss56d31uA
         lhoJ8jfJSNPgZyffDyMzdfkAy9GEUA6+lEDuIl1PyZM8FBKWLvxuli5v3SX7B5n4aDUo
         vKvEtIynqB6UE9wONTOfbGFdNMEiBFjF1cop2FiMBkWY4oxdemj3pP61p69AifHTLegv
         9C1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2SV0i2GEM0nS8AnYKV0ee/qlsQ7N/SV3lWqIAS+OdSsFXa/n4l/YimnyBqVL8b+Od+hwbWsfb1JB4or0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuS5r7kIWEzj4nolxbkZHNO5J1BCGMLnJgWp13YlO/TQUM3qJ
	daD+4TU02eAtlsWf8gDz2dq7aTciAD3F0eGuYfyrd3GqhAGGnA9KzIb1SnPGMIVQMi6RXyDVAgI
	UoXtAQ8PlS97uv/N507tDgHFImkuDM0tNYI1u4u93csNryZpbGeXhJB/HJRXquHDSMQ0=
X-Gm-Gg: ASbGncsmEnoge8gP4oDH1CpQj36Lp5i1oAhv4fTeBpalsEmSqLqE0mqoU6eiQz4g1Xf
	Y5ikP3Gw0lKI3hdWO9QcejJ4hR52xtV+CLjF9MYpap+T9N59p/APFDiPw6hOwvJan/H01EjrSRE
	BJUfjXEb1hBQAifcJGXIr/cXiS9yP6qkrU/tIiRBHts13MXwjhGwaQGlZKwyYbtcv7hykO4zG72
	Od8dpiqXz0SG4SMi3kbflZTsbeEhKimyzLO+K0k2hJZoql+6dT3cil0T9VNPqAKns+AsBBhEQ4D
	zIL2d+1thAGTADGBWLHBM4wv5gsFf43HiAxwzFCfHFNGWd/fPb1T4XDQXRl0Ut7K7dgCgYZqOth
	cUYxaLdV4WBBE7sK8pE8CjRUCi520mZtYMSixg0nw1ysT/OIv6cUV
X-Received: by 2002:a05:622a:189f:b0:4e7:28c4:3367 with SMTP id d75a77b69052e-4e728c43476mr38351831cf.82.1760359070271;
        Mon, 13 Oct 2025 05:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWOjldqO3QYpUkgEWR+chHtoaSrhdJCEvdufVafxS4s9vy3NHcZihffXxkbgVUGrgtKFOT7Q==
X-Received: by 2002:a05:622a:189f:b0:4e7:28c4:3367 with SMTP id d75a77b69052e-4e728c43476mr38351181cf.82.1760359069747;
        Mon, 13 Oct 2025 05:37:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908857792dsm4079248e87.105.2025.10.13.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:37:48 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:37:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom-edp: Add edp ref clk for
 sa8775p
Message-ID: <xofvrsdi2s37qefp2fr6av67c5nokvlw3jm6w3nznphm3x223f@yyatwo5cur6u>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
 <20251013104806.6599-2-quic_riteshk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013104806.6599-2-quic_riteshk@quicinc.com>
X-Proofpoint-ORIG-GUID: XW3DWV-8GblDFYQuOrfbOY6NUW5LQ5cd
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ecf29f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=1RwfRIOwSLSNpsoXFEwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XW3DWV-8GblDFYQuOrfbOY6NUW5LQ5cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5Tc2o5IlVgUZ
 O9HatQNs03ykHuEjW1myGeqJCslIXTrS8O/6T6EdIOy38rpqtsellAk9KRHzPz6MED2XGFZhMwd
 0MlZTVqVHV4X3+myi/BF50TAiPkDIt1ir3xmvBH47fzQyLSwCW9KtNY279+akRI1Rs2TBY55Anp
 hxCvqgkdUVr2qPCFJD+x0WiFaIrLmUfdH7A0pE0K2kqFon7IyS5BotCKMKoCo/LTctWM01Rggx7
 7UZJvZpeZsHFrflzhQSEHqtcAnMp/+dxZESwXKgalri9L5EZaVSoBhcqZDdDD5dm3x9130ig+Hx
 WqlhcbqbI0qegdLDMUi2od6OSVDdtFLafhgrw8bbpcPlGKeVr/LViv0svdM9ABaf5s7h8GSjeFS
 CSMzqyIREgWwMbJZMlwbtNklPqN9uQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Mon, Oct 13, 2025 at 04:18:04PM +0530, Ritesh Kumar wrote:
> Add edp reference clock for sa8775p edp phy.

eDP, PHY.

I'd probably ask to squash both DT binding patches together, but this
might cause cross-subsystem merge issues. I'll leave this to DT
maintainers discretion, whether to require a non-warning-adding patch or
two patches with warnings in the middle of the series.

> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index bfc4d75f50ff..b0e4015596de 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -73,6 +73,7 @@ allOf:
>          compatible:
>            enum:
>              - qcom,x1e80100-dp-phy
> +            - qcom,sa8775p-edp-phy
>      then:
>        properties:
>          clocks:
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

