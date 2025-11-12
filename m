Return-Path: <linux-kernel+bounces-898211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DD9C54968
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03AF24E20DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733A528031D;
	Wed, 12 Nov 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqFHfHRi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ks2m1cjc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D021CC62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982158; cv=none; b=amcNkp5ZSm0t+DeTHLOWSVTNapVxlJMkA7rZhOpxR4U9xXQoOdUtYHovyG5UexbzgoBRy+joBvBF9U09zoZYYS3h8/t4Jmb6veYrgzxtbruMOpJJUCsiNFeSKCibYD7EdWrs+aZnjwwYidinrk4B52coT2lZpGWro7iuKIZ39/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982158; c=relaxed/simple;
	bh=OZzRji3FYjqR6KceTKkg3Y+UG3edG0Wk3BrnNYUZsrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXu7yP+bfQkBML9FPRG3BABhHEfu5erfaYXlHO6gva3iPeP1pUvZJzznwOkj1F3GGZ1ld5vIPvHIqMeuuvLUvQjIYCzTiKRGaQfM9B+pbOl8pix8DXK1Ys6X8xXr1odARSDy80cTJja22JzMxfa3IWXJT/n9zHUPWppbPUFYSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FqFHfHRi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ks2m1cjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACHWpCI907905
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HGBWrs7DnHLfdEf2UIMKQOz4
	rRJ3a068v2CpxXJAmdU=; b=FqFHfHRiO1SI3v2yuxSfDK2ZL4TkYZ6invjXimWm
	AvP+g2SUor3kQCIbE7uLf7M/kstYiPI4umK0Ii3o0H5hin+63EOkIG9Uir80lpv/
	ky99GAGv0H1EuwiSbeADrbD5FflejhtgzCyE3YiIsmOwO8Op/R4SxnXXj7Pcp/Al
	v6B6miEaMdznNKFa0k9ELmM+gowFgFu0j13AY2WPjvvyBpWv1yo1gLNJAFBomJkx
	+2QsG6PiACDZ1EAtDIRepJ/Sq9YWn3vJd0cPXEtIsrRRnRuxE+Tag3oErr/WG1L8
	70WQbLc3F5PdlzJb+lb7raErXiGB3TIKU6AtJ5qj2O5tJg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqura2f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:15:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed74ab4172so2809271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762982155; x=1763586955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGBWrs7DnHLfdEf2UIMKQOz4rRJ3a068v2CpxXJAmdU=;
        b=Ks2m1cjcrtCXb8q1eAONTCUPPB7N+INnl+ODmtyN7alTZBToXOFZhWENhq2jBoTV8g
         2CWSlOXGjGvC/4yvmGqSD8PwcIHkvLftREt/REsdR6qRFoL59G6MgMUE9lt/4i8Jbx0a
         JqJYdAkYW0NCR/jeSW4801uWxokENeLWmbrM0lfE5Aa2veSLsbzukLPtpdIFlEH0m24i
         xoKvLyH5KpzRxsDGtTz2gauPATIXdBmRR5OX4je46aA/6gQQrsHUyWgcu6Pr0gIf6Z57
         4EpnFetjaotu31DaKfiBaVsTGYkSHsq+YP+yXn2JvJ/Uq76GrCKEBKXc/NEznfG/2Uil
         Jupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982155; x=1763586955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGBWrs7DnHLfdEf2UIMKQOz4rRJ3a068v2CpxXJAmdU=;
        b=uQVGqxQAd0XcrR3Tq1mnFE3fWwGJGJ8fRi2FXcA+uAvKouvlLvn5ObUwL/BTn/0SEd
         fxigFrZMU4bsP+vEdQHPlr49eVBNSV95ybBrZcQ0suanILEy7B5SK2hBGTDcoOvJg43U
         hNxD0zesbN6bcZRZ2R8cWPduWjI7cJWHW85PZFqTcUOLUJjbWuYmZ0aLGtvViqv9qi+h
         K247ullkkPXwmiBaH0IaG+n9KFVn3hRPNpahXNB6V5UbEEMHeSQO825cnMyOa+U5rhhZ
         0zdtuzSWbzPEs1gCsYoOEntv/qfoq8hu60ppFlE/XlyHfCpZdbw4MfFL5hJSc2zPzef9
         90cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw3iJKQ3EH5sRgrzl3UET0IcO/mHS8z/iTytlHld9ZZYk0D1KLH3QfKsyQ6y5c9C4BKb4iPJ3RKOyLKUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjI3NJsuiuRHmkI4JpdlToAg6bYgliqpIf8QjyvO8219dJk6C
	DuT/jAAKWbhy0Rz2p3dI9KFOwRVdoeLRDk7+pDuMv13pE+2kNm9jxeO1W9VOpqM5Jcn0FCGZI/s
	8TlajDvf2a7uS0U0bJf10iO2j/uwkhHZKBxf+ZygNPUwPaqjcHnkKZRoydu4t1Z1TtBg=
X-Gm-Gg: ASbGncuXSjLTDsBmO8FJeKxP6dp1UX5nEGi4is5lKpuiXheDHkgVzisdIHeA7OtKyoJ
	X73zmfY4PZWPux50JZpigxbSCCMRWfRmIcIEcoAyLlb/RmfykqIXdWz+dUGO4XFMq0WiWA63ixo
	mb+f/NDHUO/E2FPv+wkALwPGOWsNoyOMB+eNHbIBnExKIM2N0XYwTqs4kl6txn2WVgGAVq8juBa
	I+xstCSR4fRn18Fjo/T42A1DEIl3yavrqu+NyKy18F9reFgA7sXO/pw3XLBVKARXXJwPDQo9bbh
	4TE5ELZM7zcuk9KYMxgXCvPvy3VAbh3QK0uuEpWbEdHhNRLg8IS+X1UvTFAtkm11XUPXPLg540n
	upyQcxXYYb6elsc/DFp1D9Nk1X6hBjnDcv0/wQbwzpCB5f6TyDmHvBkUYY3wxNHU7TdSRMiXRct
	s3xEz+CDBg2QbD
X-Received: by 2002:ac8:5815:0:b0:4ed:b2da:9662 with SMTP id d75a77b69052e-4eddbe56a76mr66415031cf.70.1762982155537;
        Wed, 12 Nov 2025 13:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWqFy2kLgPWPVS/huXKoUFZ5R57hNEieCYdk97d1qbnfNL5pgKF8pzTG5alOHRPxvUi3yPcg==
X-Received: by 2002:ac8:5815:0:b0:4ed:b2da:9662 with SMTP id d75a77b69052e-4eddbe56a76mr66414771cf.70.1762982155063;
        Wed, 12 Nov 2025 13:15:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5957c50f627sm668161e87.26.2025.11.12.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:15:54 -0800 (PST)
Date: Wed, 12 Nov 2025 23:15:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, krishna.chundru@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: Add PCIe3 and PCIe5 support for
 HAMOA-IOT-SOM platform
Message-ID: <q6ztnuiouxvg7kpy6knrnwugusi72xfye6wf2pgfltugjwlbep@mxtt3vm7vx4i>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112090316.936187-2-ziyue.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MSBTYWx0ZWRfX86gteyapJ/Xe
 gSUm7mSoaJLwgI5lTnuR7ScNbn+H1YsewuxHLrbkc1URCA/C1l1e7d/4wf5Qm5wkvvNwNZm+FF8
 wNL/iOQ6d4Uie7mQTk44iKnWAoE9d3CHAT2XVHenRLJQzm/+qZ91ZQI5G0GE3rPtZ8tdNFt6pcq
 6h2GBZSWw5H35tgk7LPQD1NLBrOf4TZC65LamsO3okIKVAx7DjVVkraiDhD9BvKFARbFTdZtqZn
 2EAtTPde6AibqyrkEjgN/el0MoDlIvlrN7vUsI/4Emo7OOjqO25B4mjd2McbHVsygW2BGV9FDVd
 0Eaq+dlD4t0/X7rxfsIpHl8aMpqzn6D3I2z4VaXzy2Jnw268q6GWK8Lb2eBS8Fb/F7l/qAcWHCZ
 qJVLPjKZkq2zw5nSvWn3vSgEDvYmlA==
X-Proofpoint-GUID: x0j0fDHCpNwja2VG0QUxr3RPTOGSI09R
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=6914f90c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EhQ9wbuxbXqUBhoRm5MA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: x0j0fDHCpNwja2VG0QUxr3RPTOGSI09R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120171

On Wed, Nov 12, 2025 at 05:03:15PM +0800, Ziyue Zhang wrote:
> HAMOA IoT SOM requires PCIe3 and PCIe5 connectivity for SATA controller
> and SDX65.
> Add the required sideband signals (PERST#, WAKE#, CLKREQ#), pinctrl states
> and power supply properties in the device tree, which PCIe3 and PCIe5
> require.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 79 +++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

