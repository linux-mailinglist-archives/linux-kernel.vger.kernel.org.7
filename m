Return-Path: <linux-kernel+bounces-832894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C015BA0B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFFE1C24F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4183093BF;
	Thu, 25 Sep 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nla+uNZ0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26C1E0DEA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818813; cv=none; b=JTunWs5kWuKTyM445py9g3LMOkKQsHqenqFIa0D/AXk4GPsFQdJCO3h446ZtX0fZVlRd6QxM/nYIW1Su9lU72iirkA+8457UxQaDFCwkweHxcnah8VIToNp56ivqAAaOTxFfilkimQZcbV33n4Orw+v8OMPTLLrIjcf6ql/7QL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818813; c=relaxed/simple;
	bh=Ut4RvekikEgx9yUNY/U/wvhXEdvVZ8Sh73ZinAayXyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZsND5PPIhRXk6P8hTVZRSAsZh0VriBX0T9tfVQaPDtsc98ElG/0g7CIiwkbqKH9N2G2m3L3EZIkIOs/oD9iFHSvtqB9UKQvC5czwk1v2szB2kXZ53MFy5jC2ATYYjE1lys7LuRRyVTOfrhAacO5dE5uTN2ew3Ko558/CgLMRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nla+uNZ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9jmDO002152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2mr004wkrEndbnMlZ/UZb115
	iZhGv6Os5vHVBivnlhQ=; b=Nla+uNZ0cAwtyLhYeCb524E9MHCXYM9e6vKSYssg
	h00wh6hgVI8O5P5VA+Q6zpoOJoF2b2Pq4TKMTZdu3wj6UPdqsTGoAsFtyN1tUDIl
	aFnvM12FVvwoMKDu7w9xfD6EZ/UIC/LzH1ODm4KrJkL1KUJUpFcTspPiy50zOjAf
	ucNYzYB51HYTpjvJOHDwP7Igqq+F24cBeocmZpVxXkqWWK8Zqzhtni/e4weWXUQg
	mgYQAkkcV/tf4QfPsP+ZgFGRv5tXhXhZ8tQK2utedbPtaWnucwNz4EJ1RItY4/0e
	/5pi8t2Sy4Z5TcftGEMV0sT9HALwGoCRPu7XyME220GkFg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98rvbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:46:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78e30eaca8eso34734296d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758818809; x=1759423609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mr004wkrEndbnMlZ/UZb115iZhGv6Os5vHVBivnlhQ=;
        b=XZAFI+x00c/iVWEMH9mLopmjb/66rdUfdHp+BSkNPDbVz8+qiX3/JjBT9fZfXGplEa
         IFjG85eRhldMtzB93Crjg9FrHEfHcFAlfezUv9t8UlnBDuBvQZQqnnNPpLjrFm8Rym46
         F0NPdeI1xPbN7Wp/weOTWG2hvLoojou6gvpeEeeTPn0WQ0hrQkbJQ/n6JmDKHxEHCpv/
         tOkdLLLcMKKE5gI+DMBro6PPuhIfgKwtSbCkahapIXXTgtSCKMHQN0KZofMaroPkyaE+
         HvWhCUz4jQRVmSXiG439LmB70+So4Uus9o25SfKFolJ9vYmQSpe8U51xBYtQem/9UYQY
         mszw==
X-Forwarded-Encrypted: i=1; AJvYcCWPM9BBGgT/zaeiCFP20S4bdDQTFYp1mevYWoQHPSSF3rTMG7b1myoHmOfTwXr6hnAvp+ViNGuP13afm9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMK1YhHFayeIV9hh0RHENj+gDj27QLVARZZTlrUTfD9Dve7oqZ
	F/CLPH2Xd9jy2OBCGSfOdqWgCURwE+zMc0aSMB9VqgZRvu9fJj6tA9QFAw5PEtDGEHIVpdFy3/M
	3rbSIedvM8kRi9cxxLT2WJZH8z14WIEh0ungKQnd1D4OeDa2c3vT9DIjI9xT8sUSmssS1SLRnQJ
	U=
X-Gm-Gg: ASbGncsx186YKYSNDmdXk+HZ89G4SB7NwRdmTwxDxBFtjsDP+QpZbkMj9n+ScYS/4ap
	1OJC6o8gXKTMFbGlLaVq0ax8kPmkWaW0xC4VuJEOl68eHPRLWB+NJJgsJZS7+twPmfIANJC2DAM
	Ly93rGiBAS7EXINsTGveuyRX6iLYWLCAF02mamZSE/Tk70Fw4+HoMKN0+dYRxAMvCFnIwhrazUw
	XBlrmLcVosHpdSM77yfqDg2D0E94RPGqVERlPpAYMHVNloTWxVNOMtq0gx+kH1jCGobLyKz5b9r
	OZp9qqVsZleq2ymi7pA4soVEPQ83dXKahdxgBNaguwPxpbXMY+U9jt+fR/LGr/IP5BxeclImFmS
	rCo9whCShLL4CZm+WakSP+rKZNqqrQ7PolY9pM32Tik2yay06lOzV
X-Received: by 2002:a05:6214:f0b:b0:7f5:b2b6:2a2f with SMTP id 6a1803df08f44-7fc45172872mr57824736d6.67.1758818808611;
        Thu, 25 Sep 2025 09:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnWdTJ1BPazbaxUFNG2IQvEM/rlZW2m4Nxzg29lTU9VFpjl04xTbrAF3WvRoPt9K+4sLpmQ==
X-Received: by 2002:a05:6214:f0b:b0:7f5:b2b6:2a2f with SMTP id 6a1803df08f44-7fc45172872mr57824246d6.67.1758818808045;
        Thu, 25 Sep 2025 09:46:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430e1dsm933170e87.2.2025.09.25.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:46:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 19:46:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: glymur-crd: Enable eDP display
 support
Message-ID: <p7btiavlbu3wqcq62j25vyv5reusdqenz7wtqr3zspywittdfl@iivegwoqfjk7>
References: <20250925-dts-qcom-glymur-crd-add-edp-v1-0-20233de3c1e2@linaro.org>
 <20250925-dts-qcom-glymur-crd-add-edp-v1-2-20233de3c1e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-dts-qcom-glymur-crd-add-edp-v1-2-20233de3c1e2@linaro.org>
X-Proofpoint-GUID: LKKzK_YHMp_bT0_YOm4JOj14Rg4TPsnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX0iwmYoI5OktX
 YomRfVdAEUoK56MZh8x0imQT0FuF9kBhXCa5Kw9xWTHX7mAJ3A935s+OMNTjrKUdzzmCSZHeF0k
 5z4z3YOTk9hub6DB5UYzxQ3Zq5NHYMflIJQOb0AnCER5cCsUiI8QwFDDqcAll8nAOS0pkNFXJYR
 0KtDqUOqxZ+PSiRXR739bgcr3rCo9G6qZLJKo3Z6Hlxjic66FURT3ovVSjLTf6eolZmDt0hL4hY
 LYmuvCPvNLkXk1lXRT/WNSJqa4a/MxSUhW9EvdNDcjk07tTQIyDn345mgGuIw267147ul9EuoUO
 ttrhd9rhpqj+DuTCDJT8hk4xmNMzOCIZTeBpZ+0l+sFXHFu+oFX1Rq6LvdUEL3QUcXKpRclvnpJ
 zrDtMu7Q
X-Proofpoint-ORIG-GUID: LKKzK_YHMp_bT0_YOm4JOj14Rg4TPsnl
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d571fa cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=3enfzX0syV1bCKBQ0NkA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On Thu, Sep 25, 2025 at 06:02:49PM +0300, Abel Vesa wrote:
> Enable the MDSS (Mobile Display SubSystem) along with the 3rd
> DisplayPort controller and its PHY in order to bring support
> for the panel on Glymur CRD platform. Also describe the voltage
> regulator needed by the eDP panel.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 76 +++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> @@ -536,6 +552,52 @@ vreg_l4h_e0_1p2: ldo4 {
>  	};
>  };
>  
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dp3 {
> +	/delete-property/ #sound-dai-cells;
> +
> +	status = "okay";
> +
> +	aux-bus {
> +		panel {
> +			compatible = "samsung,atna60cl01", "samsung,atna33xc20";
> +			enable-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
> +			power-supply = <&vreg_edp_3p3>;
> +
> +			pinctrl-0 = <&edp_bl_en>;
> +			pinctrl-names = "default";
> +
> +			port {
> +				edp_panel_in: endpoint {
> +					remote-endpoint = <&mdss_dp3_out>;
> +				};
> +			};
> +		};
> +	};
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss_dp3_out: endpoint {

Define the endpoint in the SoC DTSI and just reference it here.

> +				data-lanes = <0 1 2 3>;
> +				link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> +
> +				remote-endpoint = <&edp_panel_in>;
> +			};
> +		};
> +	};
> +};
> +

-- 
With best wishes
Dmitry

