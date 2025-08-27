Return-Path: <linux-kernel+bounces-787460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D8EB376C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19D53A2085
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6D1C84A6;
	Wed, 27 Aug 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ogvv1BvZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447811E487
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257580; cv=none; b=Hm3PJKG3AktMfNmdQxUDPlW1OGggvSI816mkBF8G7S77wtf/tDvp0o30decYOqP7WMAdwU+ruN2uKF9KnkGDWpUUAB4o7mn7EwVVmv4a8oRUYVZLwDmNDwcKXNf84phzUwlHuxb3DykcPDsS+mM9hlHZRByjKrqhRUmu25x7CHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257580; c=relaxed/simple;
	bh=IGCfstwo4XOc0xf+hWEIuk9cHwoPJ0osldUwqBU4B/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C258biM/x3alACFy5Xd5Ys6ex+47PV9XGRg84pI/40j3VGDiSmZjJ1T6YUIRreax1GkVnpqjEQSOwd4ZCYmyANwBbOiLZW3NitoK1hrzTlNz61jejH8Zv20rFW6CGycNCHjT0CQYj1a/CQVlSxVi3Q1blbFYtXAkd/r0n/x8Z90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ogvv1BvZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFg8J7032216
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xsfaAguD70cRUExIu/eQLUJc
	3R3/gmniu/91/era61k=; b=Ogvv1BvZzZ7kyjcMnQBqHm6GBk9L1iBxRpAU3B3i
	BPnKoef9dbBIOpHVNMHgwEHZVjAw4axS1zhgy5hcnhPpcp2Z0mEnfr5n13886/A7
	3oVF/8PwMXFOK2U43a0X0+UkkwhKNaCbClHRCGHEvI1wyT40DnOZ2p/vNJIvFvd7
	VC64J4KjVPQkDmjURXuFPvAxk0bm/dWTU5JxrK6GwPnx66uP7jEhi6KbvefBJg3D
	yKItGNJ9wHyPQhUrVpgXfZnSakjDMiumy1rE+FPfsn3i43NTL65zPHH60ZD3HVUv
	SXw5WZmK4CTDqFDkDiqNT9cw8kreDBnzOw7D/WYpYORtOw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfjv68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:19:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70de1a3cec7so3452976d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257576; x=1756862376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsfaAguD70cRUExIu/eQLUJc3R3/gmniu/91/era61k=;
        b=NFLhuP3/IMrJNX4HdaA/5A98ocwcbwhE+7oqsmHkVVD3yTJY9DI1A8jFSqkUrHopn5
         N0Abiu8nAYJ6qZf/hlh+AHsk7qu0lJ+ash6rGB8ooTibGdWORNoqjcAe2i5+EBohkuDd
         sJLOadj80+SoSh9DkQtOYkdnnCfxlaMid8zVaSjduprvt+WWfW1dcTdflts3MOk1o1Wk
         aKQ+7JKPCt+krrnFYVkVYYv1PuW1uDBYf7wVYVf8AsPtQkybbQJxMs7DG86tJ5wYUy7X
         iT0zspVs8i5EuMrtwIO6FfjsncC5DeZ5RYi2BwJRAs6cAnxxo4Wpcs7jDSjD9bd1XKhW
         zOGg==
X-Forwarded-Encrypted: i=1; AJvYcCVEoOuKsJrEqPW1pP0/QIqTUL9528xekAAk+8Nz26SioendWvF9AtUs2NPJDW+a7ubXqeWrYEv5KS9HoFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIuIzTYcAePQmvqsONC0uMr61VAONYDAjb30grNkFS+ALo+sC
	iVIUuFvw8Yzg3g1LY2l+cw7bpO6viG9ElXfqMzPwOeqZlCcnhPw4yxqaRyHlyj0A2rNmsMWw4HG
	JxlwfiWxqH+7EDA2prBtYd5FAOAfwkjl/kHBAjJXxE4qFq5skVJeNXKo7OrZjqpyWyJ0=
X-Gm-Gg: ASbGnctDOKLKU78W5ichGXyxLaKejMoqUpFJ1snNSaFAWwCyMIzg4lo3Iqh2wparDRl
	5XcIADB/kwX43Z98CcB1s3mw7V4YHndBpSvbWXGiX0xIL6Hy2tqbt3JF1Ay7VEtgsgmeaCMQhB+
	lugi/7jOHY3A1ABCaBtoM/m3JHbS5TrWxMNMD5Xy930yMVwy43SMCPDJ/pXt8mnO60b++rToZ0g
	hY0NSLGL2hzBPP7pZvr0+QGtcEZsQlmzhvniFPO9qQ5lyWqCZzgiP2+PUKU0mevwF/rFOEaZoe0
	znjEuyE3ToDG5dcTkLVETO8iV6IoZgE4z7nbHovf61Da8tMtOM2LusicpJ7gLvULVI6wORE/z5T
	/7CTgLpTB8ZbXh32EbxeY4N1aM4uZXgmRMsD+mgLKnRZXR1WY8o2p
X-Received: by 2002:ac8:5942:0:b0:4b2:9603:a4bd with SMTP id d75a77b69052e-4b2aaacf398mr219214701cf.45.1756257576211;
        Tue, 26 Aug 2025 18:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBIJX90L8EObhiLkdvR77pF3EwleHjpNvQLWAxyOYReDyxz2hOIAWEk7V784kNonw+M03DGQ==
X-Received: by 2002:ac8:5942:0:b0:4b2:9603:a4bd with SMTP id d75a77b69052e-4b2aaacf398mr219214431cf.45.1756257575696;
        Tue, 26 Aug 2025 18:19:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02229sm2578423e87.24.2025.08.26.18.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:19:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:19:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Message-ID: <lxcbfiiw5ierl7r6wmrmkhkyavhysddfb2ndg6ydawb32xs6ju@aq2jkmx4irrq>
References: <20250826-lemans-evk-bu-v1-0-08016e0d3ce5@oss.qualcomm.com>
 <20250826-lemans-evk-bu-v1-1-08016e0d3ce5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-lemans-evk-bu-v1-1-08016e0d3ce5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8FsbiJqCcIB8
 tjC86a6H8bomVrmiyYTxd4VCAHqgkS6kUZB67KZPLloLsEF1oPcdzKB+MwMoS+K67PpcdVKq4dH
 r6oGEVJ4+RAt9CoWmzHoFTI1PaMQ8PrbxAAGvBm6gC95qa4/bsGpc+vakrO8SjRm9NxkYVeppb2
 O/gcP2pmrguJfWjBrvrJuhG1PiFuruAOs0pGnnq3cnaKbpyvZqO/2bzrHknOPO7/GIg2LjdwO+i
 AsZLy7An6Pzvs6qUcTeQmn1YPOKbgyEEiiyg8DRg2H6JULa5PsJ+XAKVt9IinWazT3VnKH6Is39
 enIOlV6hy2BDsi1+LiVZoc4XIyAkJjZODWO2NsuJ6TZXdiRYIh95uBPfYXTtL5UCFXmEMPtZRhX
 9X7secgU
X-Proofpoint-GUID: -2nscRAOCkUI3jnVodxN4ujWgIuC85fb
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ae5d29 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=EhCOwLgeIwc9STI1HsMA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -2nscRAOCkUI3jnVodxN4ujWgIuC85fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Tue, Aug 26, 2025 at 11:51:00PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Add the MSM SDHCI compatible name to support both eMMC and SD card for
> Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
> compatible string matches existing Lemans-compatible formats without
> introducing a new naming convention.
> 
> The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 22d1f50c3fd1..fac5d21abb94 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -49,6 +49,7 @@ properties:
>                - qcom,qcs8300-sdhci
>                - qcom,qdu1000-sdhci
>                - qcom,sar2130p-sdhci
> +              - qcom,sa8775p-sdhci

8 < 'r'

>                - qcom,sc7180-sdhci
>                - qcom,sc7280-sdhci
>                - qcom,sc8280xp-sdhci
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

