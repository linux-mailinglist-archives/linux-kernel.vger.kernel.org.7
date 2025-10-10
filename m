Return-Path: <linux-kernel+bounces-848188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B4BCCD88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489A04073B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81C11F63FF;
	Fri, 10 Oct 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FW0zvEkd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF762882AC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760098431; cv=none; b=PvEz0Dm2Fwk8yTSO92Dp2gv+OG91ryRCB70mKcrSFXaqEG/F8d5sZOlGP/MPEYTGROoWOeJqORX1GSBel//p78/t+0f/EJdc8apLU/JXOw6+gF3KsJ0Crd5dwaxHeocO3dtq7xMr4JjrSrfNO8vqwQuegE0L8BCVxePYhEHKOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760098431; c=relaxed/simple;
	bh=rxWiAxIXHzbrmd3br4/YLWJ51Z0MVMPkhu9pkUdyqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMlj3mm52gYZnP0gt5NKG9oUWvD+Syc2eaKjQKtYPkv2+Nx4Q+t/ooyiHqeLsqU9eyERc9mIHBJ0BD1r604Tzre2TzOGumQ+bfrpZIqBZHbuJbv+w05Xtw96AWmMBk7L/4xNE0QqzOFdgri0JKkO0+eYqZfVsUWioHWh1jpuU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FW0zvEkd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6XIxb026135
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tDGkN8gOyAUIi0W6Qk/6uKP+
	29WhStUz1lGf70zr7LI=; b=FW0zvEkdrGR6fLL1VNaa0Ke4/S58VjpnFy/Kggz3
	m0R2Z5UiIJP0yFfM9tooiIgbaygbn6pclWEF5wKA/cYymCeLkouuV47ZP49EQDn3
	MKgynj9gVAEpmY6F1Wa/WqmOzCBcfPcYTqEuhTkmFZmEtnVXyGXyXCpCaPOWObC2
	prG4dKEa86+id88uWtZWeqzWgp4dOzBpb5KRm2VZLiNZo/kNrNpJt4Bo9e0FqN85
	m6GKOEBcpoerIQkdlOQ4UvE5RUmy0VH/npNn/yfJL2DMvh+j3TRd+NRmxWFBUUMH
	spWeELgtljCjPxb9cCxJlEfu+9l+BHXFcn6GcUvYLUh1PQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ne9xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:13:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-82968fe9e8cso748091885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760098427; x=1760703227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDGkN8gOyAUIi0W6Qk/6uKP+29WhStUz1lGf70zr7LI=;
        b=mmaj95+QURqDZ385V5TfYaw2VIu6Zm30vomnaxCf0UT2IkMqUB9B3z7vJNSq/p4/Vs
         akb4qlWe8DbUK+jWtZSuRb17yaDrRecGjEYuti+pPDvbdBlroCr56sjRH5QbXeJJXybi
         L493fz6W/hcYfAO8Jaevcc8wsiDvW1UoRW2hh7NzceFfJgOhx6dIs/UsRIs2cKyG1yGZ
         fyBsHl4gR1HHLdWphGdvSBfiJ5WfoJ1awbPhP3FgnjlzNp+ZC5PJYbyY5wZHoQU293aS
         mPVjwF38tYMzW22qJ13Jeg976F8QdaJnTPtc6UsJAeHC5Y/uAZnFrIpnchHjPyU+Pjn1
         XUsA==
X-Forwarded-Encrypted: i=1; AJvYcCUHdQBchDBviWTWUaVL3v1JU092qDZz1TUYOfggNVvr0DfGXuqBUMU0csicQ9hZCCptPulx9q6uRsLaM5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OHazWeVBq47kpyieejTP0i6xpqrrcKvGsrIBw2T4nHWnwf9u
	n8lT0sTvZXSSvSOzjwxl3TTWNryJyJwE11833l5vMpuOrGzvDlSi2Gfmkb3lcOqruV4Y6Zx49r/
	Ka1lnflbVfrDT0Qpv42DXTEC3oKqzUPAUouTjr95vvVu7MrFCVHjnYMGVJEYKlI+Vrko=
X-Gm-Gg: ASbGnctpxJuj/ibKi31Pc/6lVSeHs71p2KHTKe8CQm17j10XRXDcZMwuoCHOpo9fwWG
	FNLPADKaJkiF0XkdP2uG0U9Cl3GfYTU6w6brJi+YWh1/sUN4eT5ZDfvlvohjBv4Sov2IxBelW4F
	oRHpYEtbLUmc1kTNg/agmKcOmnp6Dh3kPpVQqhSu8Xt2CJ9OL/EXTzAc2I519xxbdCTHeikOpN/
	lXNNgOd6+/2GIni4tYJvVt6+cKaUwCyVlZwRj4+W7et6AhZExvhN1g4koxA7Htgtjk343ffVE0X
	zyIBP6SGiAbf5fjtoK2/h62UdGZbLc6P66PTtlis6CXXk5CXzW54JWWT1ef1p+Q7OuFZqYr7+UC
	ywR3bclM+mBuyQMCD5AYTNqD0pLEt0ji5TkdAO9XW9c3dqvtzP1sg
X-Received: by 2002:a05:620a:6914:b0:860:e823:887d with SMTP id af79cd13be357-88352babc71mr1604020985a.71.1760098427487;
        Fri, 10 Oct 2025 05:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIYquGU+XwuvL90RE/f9ot7wHpbrXD7C12uhmjFXxkL3ZITSKCYzHrvKgGNCTsDraRmvROag==
X-Received: by 2002:a05:620a:6914:b0:860:e823:887d with SMTP id af79cd13be357-88352babc71mr1604014285a.71.1760098426894;
        Fri, 10 Oct 2025 05:13:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea11ed5sm5786541fa.35.2025.10.10.05.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:13:46 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:13:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Add QCS615 Talos EVK
 SMARC platform
Message-ID: <rrlpi7lr7u3tqskw75hp236rgzkdsspczk6ezhxnslvub3d454@jkczfe5ytegk>
References: <qq4aak33bn3mqxd2edu6zgkkshby63mmitg7zqkly2rj4c2lh7@4s7sndb7e2jr>
 <20251010114745.1897293-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010114745.1897293-1-tessolveupstream@gmail.com>
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e8f87c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=cO8QargF1s2uRlvNBuYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: FS1FvM5wCKw7LR1He4S0gaN_bZN54R8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6NSFSGCDmvt6
 4mcK6A4YoTWEpCwczafk3C554yH+AdWo2gT0Q1G1/QZ2mijbu8h6P1dUXbFcbVh/do3VpR/iRVp
 gG0vx64Sq9pYpdFBLoft2AZyNQxMbhCalFx0Zu9SJSdML1ITJiAxVx8NNR3swfJ2f2tfWpBSr52
 hdx2Mr0UTGhsCoME8PwgdYV9mCSnuqWJszJ5pkhCtO6yBbL5jNe75N/5V238WMtORmtSAP4FbsD
 3OhP3C8QnM9w94s0zveh6kVIi7uejINtfBw+Z58DR8aMy4IfLJDj8+5Z79uqZ4ATsRUCc54SixX
 cVkdBEw/2l2Rwyh4PBhm5eEGPjlQh9raFRawffL3HE0otvABWlbk9W0AohA1LfVW6hVMGorN70K
 vjSkHO4gA3xJsl4G0pmIoUgHhC+8Bg==
X-Proofpoint-GUID: FS1FvM5wCKw7LR1He4S0gaN_bZN54R8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Fri, Oct 10, 2025 at 05:17:44PM +0530, Sudarshan Shetty wrote:
> Add binding support for the QCS615-based Talos EVK SMARC platform.
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Please don't send new versions of your series as a response to a
previous iteration. Always start a new thread for each iteration,
otherwise some of the tools (and developers) might get confused.

> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 0a3222d6f368..a323be3d2ba2 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -862,6 +862,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,qcs615-ride
> +              - qcom,talos-evk
>            - const: qcom,qcs615
>            - const: qcom,sm6150
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

