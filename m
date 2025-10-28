Return-Path: <linux-kernel+bounces-874617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE462C16B43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C44744E7711
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99404350291;
	Tue, 28 Oct 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FzycHZfy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ms+iaDc/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5D27F736
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681610; cv=none; b=cSU/q+xxgdxbOKhaGU34bd83pCac5R0mFiS5BQvzezPqdEfKvoawS7uG3gDHvmxdHmTJ/gjGP0t/MX2N0xLTCfpl+QMtL0TP9Mt9gdkdPWS2EuFVVwIED42JGp3AgMQ77GCfuDgW7wUZaotTq7sdoVG62YI1hdIhVp/Y4sAIF9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681610; c=relaxed/simple;
	bh=3PXbwVmfbb8UXIQGow79HZxdvB9q0pyISYMOz45a6Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKrFR8SowUx8LTML4q0t95NrNYXUKVsUe2SZmUzaJhItzjoO7KKVNlaRzjOvzTxbBVaLsjnbyLLV7H2VOPHgC08k6NulOt1PFFw0X5mr7AgUGSvNJSRkdn4tv9sa6Dbp7Xx4npCt5e0txpDX9twzdTbt+emUUuY8+iSiKRBH2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FzycHZfy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ms+iaDc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlxjx2623272
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V4roZFbJyz4h3LTg3OYpA/rr
	jgxznf7XEnG0CMcM7Z4=; b=FzycHZfynrd35FGtx+2WJpQ3s9APtJZESicJKxHF
	2uKj3LpBadHCj8Yvf9aQjS39nZKVKdXwyFCYOhs1dlp/99lSNRgO5ymcNCFDTmT5
	hBy/FGHn0j/kppmpceiujkfCXT0cOCqh27p6jwpgl1IUzh+U7KjHBix7w/oRd6c+
	N/60sgCzSylbB2wtGCtuXzEQ0JmS0b8dC5/Hweg2UGZOZIfBG5JlE5wr9GNapDPw
	x4BkBC98mmhMpUIOEn9VUt6h2jFDD9WVMSt4F9hp4gn2IkE6jrVGA+sdg+o3AV4i
	zLj+yifHnwmsVJGB3QNsZvf/tK5vEADGvYEwj+yszjyFkg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a100wc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:00:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4eceefa36d0so104687201cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761681607; x=1762286407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4roZFbJyz4h3LTg3OYpA/rrjgxznf7XEnG0CMcM7Z4=;
        b=Ms+iaDc/99lgJ7L4PzEBi1l9E7s3Ba6R0h8YgYxUIYpdGaEPi78bV7TwtFFjqMeDYU
         9Lri2x40CWsonmTEJ2ee4Wu88r99x7I05nxLtVlxmva6V/XerRx7qpkkMGlBj0fY4x7D
         UbpkXr8O6RtwTwfdPs8bXfFtBoKPTHFjXloxabJNDppvDPiuKDDv7Xngc4CBvfwsXY3X
         TUZo1DZU8ikzvyl3vyazdGkWMDK6XBUP+wmWwjX19uJHhZTjsk+S1H9hTcFe8yzTpgGi
         ASpc1dWx8Rr7sWaQEnXBPoO1ni5mEyCN81g4BkYn3aTvTx42im8GpyirEAKZyweDIue8
         wT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681607; x=1762286407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4roZFbJyz4h3LTg3OYpA/rrjgxznf7XEnG0CMcM7Z4=;
        b=WbDmiNS1qXLVqO7VAWFlTpVn2L823WgT5aX/bK24zE3exsH3J5M6k2MeDbvNJfMik0
         TOJhb6P3Z9xYVEL6LNfv+nKne5qnT3fmvEi8JdxeBYFlP43mLratOZs0/OhCA9viv33j
         KXgXVoXaJMq8SsH6kvKy8tUWfCeM6AvQ2Tz2OncJq99t9Z4SUiffi+AlitQbrjWPm/Iy
         6TbzI/Crsmbj78LvvKn5VxZJ45ypmLJ4CQLeINTVfohGPAo9rjXU2rFEYttVnrnMzeCn
         xlv+PKJIhVNQIWXz882be/rLANal8/dfJTWC3lowlpBJkJP1gFI6KdH+BGf2cPkC5GsH
         g2cg==
X-Forwarded-Encrypted: i=1; AJvYcCVNwUABBQY6SMUTySZ8ocjZi6QxYd8tNA0tJNSpRDHEYS+RvLV6wu5F+AFtagpa0f8lM8nytgPtv2TAcbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIwn+A8CvzxOqdt16ZrIPsTOyuNzoEv6KnLzjo/MG1DPpSMJC
	xyFxBe4gOCwoUUEVovHpRk309f1ZptPJvbhX1o5o6+j8F3grlNsY7laSAJ46Zf7U33qCzuifKa3
	rEHECWSu07ulAZl7g1B3Yuah/EsfoytJSxgv9PH57sPGFq1LG8OP4FAY6siUB8D6crwc=
X-Gm-Gg: ASbGncsJzVQJS/WhqPTrtjiW9x/Z34VxUKtVp4xIQbrbRo1tWT0pDVp3VvWXKXbgLIy
	TMP0QPcprJkdvul/5emwTsdAqhArfodhk5kfDIZZOnSCKNEWdS+ooa95o4usjAqQlBFtgyMyCAQ
	K/5IpwOg+wSzxAduZ4KTMTHdF30Q8gAGEKnMuGAHS/5zoQ7x002+DAgF6vh5Ci8TBYF81AZOTzN
	OdpJ9YUrKKYqWXdZ5oe8STjr/WEczczf4gdVdavGf8nCyrI7Cqq0zj1wufgpgpHCbnnSW3u6rns
	4OJAAYQc3tFz8I4tDkzq3fv5i9BEF6G1jsbEGLP5YXg5sXQgThXVFWvrZAA6u6Ws4Htd30q1VX5
	mA86V82Bn4dNzeLBlENVOVMeRrQxh1qE+bXu773QrPKbR2Ue/x282ioz8cYSuNptU+Esm76to+h
	YotlhyzAmRHLpC
X-Received: by 2002:ac8:58c8:0:b0:4ed:68a:abba with SMTP id d75a77b69052e-4ed15b7dad0mr5278141cf.37.1761681607317;
        Tue, 28 Oct 2025 13:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW5aQI+Mi4P7TXLTknhsG3o08YzSTL6vg6PtZtW0JsBzmgyHQTV0m7A4A017Zn2nx/4LIdQA==
X-Received: by 2002:ac8:58c8:0:b0:4ed:68a:abba with SMTP id d75a77b69052e-4ed15b7dad0mr5277611cf.37.1761681606708;
        Tue, 28 Oct 2025 13:00:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5c33dsm3249487e87.53.2025.10.28.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 13:00:06 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:00:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: xiangxu.yin@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v6 2/4] dt-bindings: display: msm: sm6150-mdss: Fix
 example indentation and OPP values
Message-ID: <ggrtehmzg5bajbglcjhlf5jynhwqq6vztc2fqwxxgip2q3vmip@t72qcggza2or>
References: <20251024-add-displayport-support-to-qcs615-devicetree-v6-0-c4316975dd0e@oss.qualcomm.com>
 <20251024-add-displayport-support-to-qcs615-devicetree-v6-2-c4316975dd0e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-add-displayport-support-to-qcs615-devicetree-v6-2-c4316975dd0e@oss.qualcomm.com>
X-Proofpoint-GUID: L7VH6dQ5O0EOcqCpZUIQ6xR6wnyhgMfh
X-Proofpoint-ORIG-GUID: L7VH6dQ5O0EOcqCpZUIQ6xR6wnyhgMfh
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=690120c8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=oTxB0LKMmMN85w47ZbAA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2OCBTYWx0ZWRfX2R//KeClQWSC
 BGmUY8kbSnVDD7NpcLEWbeBb0hVliX85yXDz38QLgENd/9VcGARl4z+8j/RMYt5I8JZeJSrbi1e
 XDrdKwShRco7EXz+5/rC6ptcmabImUpBSX4UD36yCLC7x6ydlUPDVg6D1xsT7fPuDXeth+t3fa/
 spuTXKav0s6dcRJARmvgdtIAld4jch0EYJm28ATvK1OghfSKDaJ6P3oJ8Jcy0VVTeUiPpjObzxD
 iLvhft9PjTYQt142EVhNpheMZ0BAiwJRWnbLqAvWXI/3NkaQFKrsFV6nZ/SgRPqoMgIYQHBX0wn
 xTIeQB/EbfTCV0NOoFcOGPfIYF3BzQICZ3XIsiLZ9CZS7nAmOl1k54migSdLunz9+idiPAFrGdk
 DOHGvzbiRXNmqGxO7RK0gS3jF1Ebaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280168

On Fri, Oct 24, 2025 at 01:21:02PM +0800, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> - Adjusted indentation and added missing blank lines in the example.
> - Corrected OPP clock values to match actual DTS configuration.

See Documentation/process/submitting-patches.rst to check how to write
proper commit messages.

> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,sm6150-mdss.yaml     | 32 ++++++++++++----------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> index ba0dea2edea98cee0826cf38b3f33361666e004a..80183df71cd9288f652dc42afeae101e8edcbe65 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> @@ -140,35 +140,37 @@ examples:
>                  #size-cells = <0>;
>  
>                  port@0 {
> -                  reg = <0>;
> -                  dpu_intf0_out: endpoint {
> -                  };
> +                    reg = <0>;
> +
> +                    dpu_intf0_out: endpoint {
> +                    };
>                  };
>  
>                  port@1 {
> -                  reg = <1>;
> -                  dpu_intf1_out: endpoint {
> -                      remote-endpoint = <&mdss_dsi0_in>;
> -                  };
> +                    reg = <1>;
> +
> +                    dpu_intf1_out: endpoint {
> +                        remote-endpoint = <&mdss_dsi0_in>;
> +                    };
>                  };
>              };
>  
>              mdp_opp_table: opp-table {
>                  compatible = "operating-points-v2";
>  
> -                opp-19200000 {
> -                  opp-hz = /bits/ 64 <19200000>;
> -                  required-opps = <&rpmhpd_opp_low_svs>;
> +                opp-192000000 {

This is not necessary. This is just an example, so it doesn't matter,
which values are actually written here.

> +                    opp-hz = /bits/ 64 <192000000>;
> +                    required-opps = <&rpmhpd_opp_low_svs>;
>                  };
>  
> -                opp-25600000 {
> -                  opp-hz = /bits/ 64 <25600000>;
> -                  required-opps = <&rpmhpd_opp_svs>;
> +                opp-256000000 {
> +                    opp-hz = /bits/ 64 <256000000>;
> +                    required-opps = <&rpmhpd_opp_svs>;
>                  };
>  
>                  opp-307200000 {
> -                  opp-hz = /bits/ 64 <307200000>;
> -                  required-opps = <&rpmhpd_opp_nom>;
> +                    opp-hz = /bits/ 64 <307200000>;
> +                    required-opps = <&rpmhpd_opp_nom>;
>                  };
>              };
>          };
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry

