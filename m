Return-Path: <linux-kernel+bounces-808341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED61B4FE83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308CF4E3926
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31501B4236;
	Tue,  9 Sep 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ozu9A2xC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEA219301
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426420; cv=none; b=XQ0a3G+lyPt3ACC7Qc61hYWH6EJJ//pvf+YiSEwrvoYUNG8bfCEh65m1efIVykwwHlKr1EKFg2yxxxj/X/Yme7PcnmUGIlNEWOxDumcCtH39xquPRU29KMYxBLVIOjEh0RAjxCq1o++T2rZtHOnDTwjcO+KQX29AELkcfpTD8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426420; c=relaxed/simple;
	bh=LYg9kkS3/eGoksJYpWuzYpEAsLarJctZuZ4l+/3X2/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDxO/D1niSLFPjwfPqDQnuqKaWYBsDCcld9+dRKgmx+mqtkxf5o38d0nv+/sQf31aCEAuv4cfDL0rFNmUsNemgCUB4OUfTUuhmMf0qgoDg6ZMXPg3KopN8AQSL1U6uOJ0g+Bjjy2Zlk6P3Gpa0RSLKupIQCyR4CVyXyDlpfjvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ozu9A2xC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LSgr032319
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=RaiuPSwScN1So+PWSJmzhuha
	k5hJv4sAaqtK90ZKdho=; b=Ozu9A2xCN38svH8qQO4SH/IbWO1Epuis5xzMXswO
	7+b4Wp9gy/wGuogKEFs87voIPlwJVd0wXF8+bnwLOW/I3Ks9Prh22YEbJIVUIAHL
	N8QTVvITH4REGAKtK35pU2W2ZoxekQj9I+jaJgMePRWmduvBnOMU+wocHN/C8Yj1
	MLgwrGIVV6d6dL055W0O5xQl8yeF9fMRf6hiDIy7825PHCt/6w/QCbBVvLPLeB9b
	+jnlsT14oC3tLtqMo2i2rQYASzN/Sdo+VuU+EzyFwvzZt8x612zYU79rIot1vNV7
	L+RyeDK7Yflrvkz9S90eUKUZ/EmjxngYyeVDN3XfRnwNYg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m0abh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:00:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7296c012ec9so58283796d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426405; x=1758031205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaiuPSwScN1So+PWSJmzhuhak5hJv4sAaqtK90ZKdho=;
        b=Uun5gS6asVGOyzsE6YB2swjGuvWJ7W1z3wD38s1j23lSzdeSESD446eYEGtNRyJADv
         Syzb0g4P0qRsCAt1S6PuUlWCuOZCeudqKcRuth5Uoesoa/rrn79wP9X3yzs4Uw6Q2vPx
         PF1QoJZk/aEqpywZxzsUGl5LrqoeR/R5UwZ6dtWRyiSzmygk0iTqHT6qWZuiQjIDsMX8
         CPVPjLKpDzBNV6LXBhFDqZA6WpshvMXlXpCI2PHeYrzOV8Y7cxnQ3/WLn5KwRIQq+rfH
         WJQCgVXZPfzNCl9vvs7ZWQOkQbM1n0ZYKCpCTn0GBvuI81cWrfnQZ8hTQ9UQEAjG2QtS
         8Z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+aYwd0DUu/W2ChFZnV3G+9lxGGujWC5j5b7Xt04/x3Ql+9ffO47xr6Rd3/vVlzGpvJoxtTM9MKSXWEIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1iLY836XWTm1IS3+IdZfZVWfh1HgWbw2Gz9aXE0xWCzOphoe
	kqUOSKa3zdqB/eLXIdagtCEYdVhfdtsF/rZ+6yEG+Rv46sSJ2NKC8z0Tk3IKHUzCDhu9Stpdp2K
	LP4O+mD0DQRoICCirccRlI4438SI8lhVccjO0szA4+UjGAi3uE14TqVUR+Bf9v0TPC8g=
X-Gm-Gg: ASbGncuUg0pgxNVmK4OBZJ7ImZC4NPWvcIAsVhIXsDnCX3tOhMQ5U6aY+aJVlk3Bt96
	91a6g7B+jqWHCQ8fGwKwbRqgwqBI10Ef51lYhsD9FRNrLOoO79TuUTT24MQpGGXIZ2d5o1AKov8
	lKabKERnZDSlVAaASfmiae8OS3N20tQ3HZK4vohDBp2pHdCXnjw9/3Tped95zLqinaUkPa1w8B0
	3r7mPZgRqaryUOC6DEx163HjX0OGbnl/pyhGaMjvh3kwpp9+w+esJ9dqtB8opQovh6reYGnZGsX
	X1ko7TQ5/GagCvO+ZjyDgt36NURFCP3+CL1T1fQZ1w3Z8y05ZVKR32G3C5sbCihXTmf/Kf3cSfo
	8PkupHjiyF74DvmOugYXxNZnehweo4KiNTUKhJtzrM44abuPk6xEG
X-Received: by 2002:a05:6214:e85:b0:758:2117:887a with SMTP id 6a1803df08f44-75821179a69mr16533326d6.58.1757426405038;
        Tue, 09 Sep 2025 07:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj1Ux9j67rzf37hWL5A8Jozn7wOidkUvzvPy9tqT1pZirgwULyxpmO/uSUwFeT3zwLe1DRvg==
X-Received: by 2002:a05:6214:e85:b0:758:2117:887a with SMTP id 6a1803df08f44-75821179a69mr16532636d6.58.1757426404347;
        Tue, 09 Sep 2025 07:00:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c4246b7sm546172e87.13.2025.09.09.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:00:03 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:00:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikram Sharma <quic_vikramsa@quicinc.com>
Cc: bryan.odonoghue@linaro.org, mchehab@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
        cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_svankada@quicinc.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: media: camss: Add qcs8300 supplies
 binding
Message-ID: <ez5d76piv6srwceueajokplx73xj6xtgvyqgtbpjkdtoo7ijgt@7xn3uxzdcgvy>
References: <20250909114241.840842-1-quic_vikramsa@quicinc.com>
 <20250909114241.840842-5-quic_vikramsa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909114241.840842-5-quic_vikramsa@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX5isKXXbOWM61
 AfrSjARXc/NSahqhNETAxXMVhC36lsbz5x1lWhB6pM4vQbTggmDPwvzednaiskXur7b/GxbR46R
 o0djm11r0ZZaFePt7aBfC96bjm5w11MdH7d24tUX20doxss/v/ARkpvLQAfF37Uxho1JDv+35kZ
 2p6UaA1++PKEz7vK7PXY79fcZmg9Zt2uD7L/bf2ydHoplilwlyiKmaQ52+LZ8AU+kzRya2/Z6wx
 tIO1Se6x0+FsX5rKG9Xq89VeovP+KYMwBpvIFKRTfLLK2XApa+PuXgH8bIRshmN00LpFBSTSbff
 +9TIl//x14nu80SRliMeq/227Qvni2NQ+rqk5XhnBXejuYcyeXDEbrKsLQwgv6AAJnyWaUfP9Re
 ZutI0m7U
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c032f1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=vE47tFul03BpYyIIO6YA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JqyODfoDnoqz7lu41pCbfjNsOyZKdaUj
X-Proofpoint-ORIG-GUID: JqyODfoDnoqz7lu41pCbfjNsOyZKdaUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Tue, Sep 09, 2025 at 05:12:41PM +0530, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> 
> Add vdda-phy-supply and vdda-pll-supply to the qcom,qcs8300-camss binding.

Don't describe patch contents.

> 
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>  .../bindings/media/qcom,qcs8300-camss.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
> index 80a4540a22dc..559db6d67f06 100644
> --- a/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,qcs8300-camss.yaml
> @@ -120,6 +120,14 @@ properties:
>      items:
>        - const: top
>  
> +  vdda-phy-supply:
> +    description:
> +      Phandle to a regulator supply to PHY core block.
> +
> +  vdda-pll-supply:
> +    description:
> +      Phandle to 1.8V regulator supply to PHY refclk pll block.
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> @@ -158,6 +166,8 @@ required:
>    - interconnect-names
>    - iommus
>    - power-domains
> +  - vdda-phy-supply
> +  - vdda-pll-supply
>    - power-domain-names
>    - ports
>  
> @@ -328,6 +338,9 @@ examples:
>              power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
>              power-domain-names = "top";
>  
> +            vdda-phy-supply = <&vreg_l4a_0p88>;
> +            vdda-pll-supply = <&vreg_l1c_1p2>;
> +
>              ports {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

