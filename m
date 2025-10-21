Return-Path: <linux-kernel+bounces-863757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C970BF9098
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ED614E2A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB152701DA;
	Tue, 21 Oct 2025 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jucQht9f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599626980F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085415; cv=none; b=dK2xHFNzJWCzT6VmYxRQ+hjSqnA115gB+naWVNlHUVcZQKiBnLTsTb9gwHfwW/aqmwMVyzscotnrURCzaFt8jI3ZQN6qdgE1kIaTezzFto6iStN9DnXH/qYcAx91cte9QbwUGkdeZSoiALDXAkMeSrYWpicJSI1xnfETgAEtV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085415; c=relaxed/simple;
	bh=JG8VnzKAlVBeNewJNVx/R4Vpy6m514jw7etJwb/UZBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUM1aA0HkvjhwwQyT4ZAszot6xJfBjPEmbQQtgcF0dQOED6U9SRz6Mvc1BUKlM6h4hoF8YHkqLSQ8aT/ZhPgwX04IkWrOVQ+tCeX9J8zjICqk3xZL1mi3Us0c7Zp+cjvk0NwAq2A2jhWlUZwaTpy1vqmFOBldR0Uu4UEZVVTcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jucQht9f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LExRIQ031321
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wus8JmgsAXWjUXMzjJav1jMo11aQP1duPwm7k9b+OGk=; b=jucQht9fxH7TNG6l
	+JcPAynAkJjRiz6DaEvBRDm8BVHqUC4sB/R9yrfcQW7H1xrJRz/Ka6n0mC+DPdHL
	6GPCNnypF6/DZpbpFwqGUEJPIvKD7HQs7WCg+i1M4S/Y0QWetTXJRq7VO8qdVYc2
	hfIONCQIFA8O1pCK5t6JObseyfKWf0qKSJt1Q79Fog0LZMkUBSJ/aU0sexTra3++
	IM7iXNK11lZnNfH6LsHF6fg4pkgHi8mQMzeGZ1OwJyPskfxJZp7An1ItCdExa5Sn
	3JPgYBmLdPQHeQ/gV5pi01JaCXI+oszVZw4xmq6Pn6qR3LjHBulNZ9GcRkZvNjNx
	aBAk8A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42ka80s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:23:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so13666101cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085411; x=1761690211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wus8JmgsAXWjUXMzjJav1jMo11aQP1duPwm7k9b+OGk=;
        b=P/iFgyND3fPfRWNRKvUX+nQJoHuN1RpUSaStjnvomqkFMhyKeioJqFCDKxZYCWMPuf
         q10ullluUvM7xumrvQnE66bdytzY1ejbOnKkrKYIJRfvcTxogeK75hn10RFo/bUYUyC0
         VYMFPGss1Vz8uZr9KEP5LoFh11AqsR6uI/abt1V7OmyYBE7MndlhV7pHb+ORDOA3Qqda
         iq7jvU37eD63fvkTsr/c7uoSmWu1JtjncWkL4IcaaFpAxUqAgbHgaOXDPM+MHTI2Ew/p
         XUWAyNbj+Q+sz4zwSywKzJxKX2eucLUwX6XFAzAlfBITCFRljUwG9mBXx+LGWeMW9Pc0
         LQhg==
X-Forwarded-Encrypted: i=1; AJvYcCW5vI/Bc/f1oHGHi8Hw7jkn3tsdNkmtOAhQLHidPt/i13GWiWEr6Fr60xcd/Vc8hwTyrf9fYgC0kdKtOW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFRDGqO94JNrkKaO1dVCH6e2H9T/KJeMbHB3oiIdeW55URHOTN
	Z9k/WhVbNzsPZHA20rNWtfmUVYlcmAZC/rpdrxEhUJM9UVnNrf+L2vUFKLwvodCVxVIuHl66NVv
	4/+/51/F+pEEQEbDBexhDa6GKhmbZMuHJQuR+drvVdA2DXMN6mQiQsAhG0dcwYASeneA=
X-Gm-Gg: ASbGncvWQeI/D35VYHD6dKPWMoSy9FmBLwBTzhHhackjOiNsf2yCDZLQ+ZZl6a1AMQJ
	7bRgzTl1m4mZYZik/NEpK1FvyWuB7vZh9ZCwIA6HWhdkJpFWM8EmauhBIzRBlusWh2IKu5jU1o5
	KGAw0VcChm+gJz75XUmZNUx86oSv+q+G8MytwQgISnL+jby2QSohHBZswy1MvvDLDOZ6BUq5pKn
	aEP9jMKMlgDZY366QeXwbP+4sqi/GoBxIa8tVQ5oOQWaxzuoYcTZmfkhUhQi12O4m5td4GnSGSi
	Enqn4wnn52JVjmTLnDOC2em4i/GaCUr3LSngrcAAMPDSTAQ57dgrMaiyut2id28jKeWR8+6QcL2
	36mtUpUoCDjoZ+9pUdwpbOOtraYa6MgaYJ3hQ/1E3LLmLqG+W0EpOp7PFhwSiE+vpOZfhn32UDi
	9OZ9WM7bLLmpo=
X-Received: by 2002:a05:622a:143:b0:4e8:9ca2:b9ea with SMTP id d75a77b69052e-4e89d3a34aamr229968911cf.56.1761085411220;
        Tue, 21 Oct 2025 15:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOGuRhdenAEHOiCX30SHoTS/93sxx8PeGMSCJmiucdiQyyxiccNMJ5ybqVzLO5AnNLs2GDBQ==
X-Received: by 2002:a05:622a:143:b0:4e8:9ca2:b9ea with SMTP id d75a77b69052e-4e89d3a34aamr229968691cf.56.1761085410769;
        Tue, 21 Oct 2025 15:23:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def167fesm4034740e87.74.2025.10.21.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:23:28 -0700 (PDT)
Date: Wed, 22 Oct 2025 01:23:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] regulator: rpmh-regulator: Fix PMIC5 BOB bypass
 mode handling
Message-ID: <on4zcfs5qdaekc7teo2iq6vpw7o2mp6yiqjkbznxo7wcxgutj3@nb35f55fkugv>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022-add-rpmh-read-support-v2-1-5c7a8e4df601@oss.qualcomm.com>
X-Proofpoint-GUID: lGTbC0J-PCC8zZS1lUJ-ukT18cfBibKE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXyo5TU67VeOtT
 u3m5MfZ9JyAHFP+TOO714qtSPT3D/+5UxrnwX/uzNDJuXDOAJcVUg3kf67lj8Jz7grGnYsdkbG4
 56y/weYsfZGHvR+0ZPJ47VjDNxbRFf+1g0cnXWdVRd3cI7wekf+d0dwXG8dvLeVG6DwpEAA5uCl
 pS0buNdKbZ8t3Nte0FiHo3N/w9fpgtpYlsk4fJLLEk5AhQRfFaefOawi1tKUxIEcVtBRX0UR3gO
 0bcc9zV2vup1eSbhfYG580UlqolJTewgugZSpxlmAulWsTzIkq073U3TS67IHXQ6w0wWJjLDoed
 ddNu1VqaIxrHLGzzcCgNVSFWyR2ARLU0wOO49ptSIV7ktF/XcYqnnSHydKRfv8TRua1GHsCqbva
 NskUDqJYWItJzcQkGmuCJazQhnDliA==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f807e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=vkhBuKkrFEIrFZnKDE8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: lGTbC0J-PCC8zZS1lUJ-ukT18cfBibKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On Wed, Oct 22, 2025 at 02:38:53AM +0530, Kamal Wadhwa wrote:
> Currently, when `rpmh_regulator_set_mode_bypass()` helper function
> is called to set bypass mode, it sends PMIC4's BOB bypass mode
> value for even if its a PMIC5 BOB.

The universe will end, the Sun will explode and Ragnarök will be upon
us. Please describe the issue, why sending bypass value is bad.

> 
> To fix this, introduce new hw_data parameters:
>  - `bypass_supported` to check if bypass is supported.
>  - `pmic_bypass_mode` to store bypass mode value.
> 
> Use these 2 parameters to send correct PMIC bypass mode that
> corresponds to PMIC4/5 BOB regulators from the helper function.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 0a561f1d94523bf479f48e8c2062f79cf64f5b5f..947fb5241233c92eaeda974b1b64d227d5946a59 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -111,6 +111,9 @@ static const struct resource_name_formats vreg_rsc_name_lookup[NUM_REGULATOR_TYP
>   * @hpm_min_load_uA:		Minimum load current in microamps that requires
>   *				high power mode (HPM) operation.  This is used
>   *				for LDO hardware type regulators only.
> + * @pmic_bypass_mode:		The PMIC bypass mode value. This is only
> + *				used if bypass_supported == true.
> + * @bypass_supported:		Indicates if bypass mode is supported
>   * @pmic_mode_map:		Array indexed by regulator framework mode
>   *				containing PMIC hardware modes.  Must be large
>   *				enough to index all framework modes supported
> @@ -125,6 +128,8 @@ struct rpmh_vreg_hw_data {
>  	int					n_linear_ranges;
>  	int					n_voltages;
>  	int					hpm_min_load_uA;
> +	int					pmic_bypass_mode;
> +	bool					bypass_supported;
>  	const int				*pmic_mode_map;
>  	unsigned int			      (*of_map_mode)(unsigned int mode);
>  };
> @@ -310,10 +315,13 @@ static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
>  	if (pmic_mode < 0)
>  		return pmic_mode;
>  
> -	if (bypassed)
> -		cmd.data = PMIC4_BOB_MODE_PASS;
> -	else
> +	if (bypassed) {
> +		if(!vreg->hw_data->bypass_supported)
> +			return -EINVAL;

This is redundant, the regulators which don't support bypass should not
be using rpmh_regulator_vrm_bypass_ops.

> +		cmd.data = vreg->hw_data->pmic_bypass_mode;
> +	} else {
>  		cmd.data = pmic_mode;
> +	}

Can we extend pmic_mode_map to include the value for bypass?

>  
>  	return rpmh_regulator_send_request(vreg, &cmd, true);
>  }
> @@ -767,6 +775,8 @@ static const struct rpmh_vreg_hw_data pmic4_bob = {
>  	},
>  	.n_linear_ranges = 1,
>  	.n_voltages = 84,
> +	.bypass_supported = true,
> +	.pmic_bypass_mode = PMIC4_BOB_MODE_PASS,
>  	.pmic_mode_map = pmic_mode_map_pmic4_bob,
>  	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
>  };
> @@ -975,6 +985,8 @@ static const struct rpmh_vreg_hw_data pmic5_bob = {
>  	},
>  	.n_linear_ranges = 1,
>  	.n_voltages = 32,
> +	.bypass_supported = true,
> +	.pmic_bypass_mode = PMIC5_BOB_MODE_PASS,
>  	.pmic_mode_map = pmic_mode_map_pmic5_bob,
>  	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
>  };
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

