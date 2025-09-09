Return-Path: <linux-kernel+bounces-808327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C3B4FE49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA815E3B87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C8343D80;
	Tue,  9 Sep 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmkohRjE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F2343D9E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425830; cv=none; b=JZUs044HCVTv/6NxYScOTPFWNtB8n2D9FZYNDXAsMVzU/DJqZ7scBaPf4nm/NfWadc08+JveDPIVGXMPwBflXvOKigSdiQkISjI0iztfoP+sVV4qe594cJMMLyVMIhxhhdD0G3BMjxGz8kc1CJTSii8yzUnLbAHZkx+4gcxL4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425830; c=relaxed/simple;
	bh=hsZggDEeH8ea/RYTI72euQq5F/ES4plUX2WIsYwseKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrl3ngdlqQB9s+NrhAJ+9Z5tUTgul+K9EScUx/U4muayxEUjbZf7tS5yS6zXmUsT7bmB1pMYGxLH8CukW7UoT9wQdxkOOEi+uJ83zVP2l1B0I/4wi4VueXFx5TcyUMF5BkVd8WJTvjROKOKqEyuzTbgFeo04qNVibrttYrpVU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmkohRjE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LRSl032181
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 13:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BoF4YU4Z1GVybjwUeS7Z/uv8
	axVlwSxe5xZqCYbacGo=; b=AmkohRjE5AerN3V7+IS0IkKqt3vukuuR39Wh1yLP
	9p8ZlK0JVwMz6b8Kes5HVfP5itfI++KuiVekBLInWumZ1kETe3w/NVYfW9v/LXht
	ObwR9dYfrr+OjrgPQItL1kVHnbnG+tWDsViFUycjPII4ARtpYbmhMq3f9gWzSO4R
	MIWQAIj9UgU+NeE5DgYrUFo3rtalUU4lWBxVHFlmrfcrFF12DrXzpyLtcL79z1yR
	VpSi99e4E/wMKBjjeM4nADw7dudoIitZIu2C9L1xUyjxQQZ1sewlRrY62TlzpA0m
	/8N+FL1Ak4j/5TPX/P4r+d2dEvlSJL6ykkISAorhIfUKdA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m098t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:50:28 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-720408622e2so119257626d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425827; x=1758030627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoF4YU4Z1GVybjwUeS7Z/uv8axVlwSxe5xZqCYbacGo=;
        b=ZuRHsBANHxXZxBI8xJJFiizQvhCCt2u1CAXUCp0tg+Jiepb7g0roCtPNuhl6hAJR/4
         eaXipAAMzEH1cYBE1Swd0KVcNuEHE2cDKV9NmAxtWTAHGxn8RUz93+xCXCwfKOmrJxSo
         qDCtYMGlcLrUuATQXaMn7FQk9Kr8JWQvoT0sONgr1QCjIJo4PjdaMw26MtBxXc5teifL
         /qoIxPlB7yo5JzflycnzVst7kB/ONOdsFMj6YVf9UKaEP0WVHWz2RUD+JN7A/yGwKqEF
         DQQGrwzAcKLAYFP15kH9VUs0bmdBM3rQkbT4CUyDEbSJ2MmLmZdCFZIxMZiUJRSGobpA
         eEqg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ekrSwWfvE+azNHYubkDrNkLYksBF2p2yt94Jm3G/ZC+mWEfM50lVFHOHo27eNuQL4+rfgMjMr+gFF+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHPs3pVM3ygzzX7cEa/ODUOp5PU4c/hgTY5eITWB8aWlGY2kU
	lgxrsCvonr5OGWelQ5wfAV245BTclm3SoqCIbEiI9FXPTa63ozZa0GB2qbTXdXqYWLgRpiiSrp4
	/Bz9Q7yquAYitYsstasE7YFRXSxjOOYdAz+c5W/6t0/XiRro+F0i6l35d7OkU6sk6ey8=
X-Gm-Gg: ASbGnctlIPXWs7XC5fQaZ6z9jI5SADNsLovkNrMhk4CAkaKMEXIkb6gTC+n96u3NR0/
	+zYhArNIRQNlyBMsUDwOUaWh2peDpZEHnohfcsupttfFz79N6JDu3ASji37jQCR1mXR7M/1P5Jo
	4eOw8VCkMeCmQ6BP1Ji4G4arXAqtwQajvFJU56olUfj3ciePS0V114Ka58KGwpzE7fsdyTLGX0n
	uWGMeuHizkWt4OyxT1XXyfr2lF/zuC6GcJj1VYDDj2SQzDrZZw+JSeHF+AtLyOSLlekT3hiXWGF
	i3FgJZFsd7WbV2LyKW6wbSPuN99WHDErMrM8TY7pUdE5d9Yj9s/cUaCl3VPKc4wAP61EcgODY2G
	bSsn+2r9AFHmxiRxke+rGmckPSgRWrzMYSoXoLJUetnfrhkMFfiwH
X-Received: by 2002:a05:6214:2349:b0:70d:fa79:badd with SMTP id 6a1803df08f44-73921a43c65mr116264646d6.1.1757425826894;
        Tue, 09 Sep 2025 06:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/4AThO6Ll+SaMNV72t1DSQpSQ2NXEUj0ahvpr2YyKNkF66qrI5AK9cWuDnKGSXBYMcoEMbQ==
X-Received: by 2002:a05:6214:2349:b0:70d:fa79:badd with SMTP id 6a1803df08f44-73921a43c65mr116264156d6.1.1757425826207;
        Tue, 09 Sep 2025 06:50:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c503d7sm39294991fa.11.2025.09.09.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:50:25 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:50:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingweiz@qti.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add bindings for QCS615
 talos evk board
Message-ID: <33ldjudketkyledzp473bwal4jmrigozjjwqtqlrmrkjmh5sze@ak4cusfossus>
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909125255.1124824-1-tessolveupstream@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX92Y/Xd3hvSQc
 UjSga17EWXENyA+W4mhGsSZP1pPOgw5DaJG9KqX5e+Xti5FQAAzPIb0fY7hN4Fkh7ZTatQazEUr
 TG9+h8Kc5fdK9D2ANXiOWYfN3/s6+cBu7Rcd7/LfmIBBSmq6PNxfu4YcxP3FjJjk+WVVh2zJqIj
 9RRaI6zQFSvPYNJiQF2Aypx2QVeKLQzvs9ozO4jyWod103IyQAMid8Rg3PXreZrQjlnBkEuoLOH
 HBMCRX5PmvwF6Evu0WzsoE3Qva7tSg+qahCUjrEsjw3XLMyK/76s8/+HE3Gs2Nk3iHfpAmVBRh0
 4h8HJvGFdS2Xz6O6JQ1ttIup2+yS9+pF7rbvW0gl8Hy1a7snbxD0ShifpG8J0MnjhzDwwQY2MSs
 SSnfq0kv
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c030a4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=CwtUJbH0faq6zwYj85AA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: eTR8PypVoNuBXj4KE4444Up0z7_Hdp2s
X-Proofpoint-ORIG-GUID: eTR8PypVoNuBXj4KE4444Up0z7_Hdp2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Tue, Sep 09, 2025 at 06:22:54PM +0530, Sudarshan Shetty wrote:
> This adds binding support for the QCS615-based talos evk SMARC platform.
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 03a7d3c92ecd..a5dbe6af68ac 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -952,6 +952,12 @@ properties:
>            - const: qcom,qcs615
>            - const: qcom,sm6150
>  
> +      - items:
> +          - enum:
> +              - qcom,qcs615-iq-615-evk

Should it follow the recent example and be named "qcom,talos-evk" ?

> +          - const: qcom,qcs615
> +          - const: qcom,sm6150
> +
>        - items:
>            - enum:
>                - qcom,sa8155p-adp
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

