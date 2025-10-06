Return-Path: <linux-kernel+bounces-843005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D86BBBE2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5997D4E80F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573A02D063D;
	Mon,  6 Oct 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pj+bBsVa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3992D061A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757177; cv=none; b=adQhhqAdhjoUMeLFxm6pS8gyEUkbEHvPXM7dz9tiSZuftc6oyqePb7uYEyVUHwKgnPNgJF/kLHNFbq/cM3AFyJSK+ghJ4On4eIsAbKPvzctC24QwUxZF32DBsEnfwYaQ1mnME3V6Z23SsaAhIEDl8cnfJYOwsrH8Tnfz0G+47g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757177; c=relaxed/simple;
	bh=MT9skSBafU/OO6TyPXQDKc8LwQvb8rKcFgEGPquoaCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suibK5xOVlKGBThhKmJXcy1R9jqqVyf5h8VOfE/xIh8thPL9aaBre/MeWth1VNHtCsD9+T22XqQZctZGqUYZIbJB7ORcbjZSlF/Foyjtyh+trTcv1WO/4dxWjrhvFqDliP8vbI53qIuyiPy1fSEWpseccXr8EgLmNWmOFol36kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pj+bBsVa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5962h2xD017143
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 13:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N6ypGwDaGlhrK6ZG0i30/Y0b
	yq9GzIhyKl5ZGLSoyg8=; b=Pj+bBsVa5wdki1EC9M/Y/T2PXX2Nn0MrZz3/MJFP
	8ODFOvriAzyVcNtwGjIvxQoANbtaKse6qUooemhy/RqvMcoUslVCM+t8L/OWc6Dk
	mmnsnplzFmw0sOWgV8BcYhtuuft4mJSAZaa6UuYU64Cxo1tA+thDg10WuD5DYA+D
	ShBBedvpkOc2BPIi+NeEohURSC9tA+lcQrRzqv9WMWeQSA/GX1NPpYKIgoy5uDD3
	9vEPi4hAYBCtRuP+C68uS+05T6wlMtNON68nwFlDo3Oo+uHQAs2GTU/iRnvckP8N
	Zc4rbShhk6MOqt5JINFdFsGlErCfHDN8WRItOpYM0WmWHA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49k6bfk2v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:26:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28bd8b3fa67so42775805ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757174; x=1760361974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6ypGwDaGlhrK6ZG0i30/Y0byq9GzIhyKl5ZGLSoyg8=;
        b=E4EpyNISaqZ+dTFeLe4zAMtO5XIIFGFM2sBpTYcKNTEFmtmhsxHgenOk5gQM4qqeTJ
         LgIV3nTtIFfYejWMCIb9aCZVy4AUb79Ogm5NDs9Yj7WHg43FfBrZSBVJkMi9nH+jRP55
         SeNx/gdQH28zgdet3lTgcqPWI3f1OUqJtKJUNuGPq2U5XWh5oohevbkSri1FZp4elzKx
         CRF9gRyQR1EyKD2BD/AYICD5vB/ZjHrVRuE7A0fihmynop2SU+5yrePXEa7MhqZyPjk7
         xHrG9uZ3LNQQY3W3gGbyMMhQiVy9rHtbme3DwB9PUCsj8zVGIKB4AC+Vf3cUIHC6Qv1X
         3DOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFeDoD0MZGZkXSSpwdUCcGy6z/RK/znrn3jW2X1LWRcU5pXr5wz/FTbc1tPqhBR8hdzTxBOAZowCeeTy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tXlqqeva/nQmv6ne0WbvAmgwUHLPe/aFB5Km3NZ/sS9qqE9G
	oRdbmTVZy/br9If+v0RUGLMzzrg9t9JIXRfi6havRIcDReoDXy0wpZ59nrbzOqjd5dVGO3ng3pa
	phVUQyDcn26z8/aCNU/o6JjoJ8J3CwCzY+dukZpYqscv6dl0VGmt6DY56OdGqXHyMslM=
X-Gm-Gg: ASbGnctSMbQPipq9AIHSz5AOWctXaDfhOW/TYZNMvmCXpSZmgmHEQCOWq8+TYjJ3SUv
	7JE2W4rGw58/cuxDSQktACt55HXuQN1xLgRbYQoM3D1WV6pcN/m/jbK61cEkct+Mgb0Od+816lt
	FxcxIcj9pv+94Xqzh7gO5veB17dxYGpl8hNiXa5QNTOzcb0vAi+eNbq06vWdXUnZQWD0zQ+i1W7
	So4cSV4MotEphK3hWwZ11tqqvwkIc5e2hrIVcZ6Gum0VcXVPia/Fpy5nhJjlWTutxNOgl25QGNH
	/I73nFi9k8sW0LtWCQEzj9HIKex8OdE3d19cH5tyBkBfi/dmg0Cpxx+1qw19ENZavNh6YI8wfej
	8eRE=
X-Received: by 2002:a17:903:fa7:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-28e9a546107mr157426345ad.12.1759757173863;
        Mon, 06 Oct 2025 06:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFCL9tEe0bUa/fsgaePc+hDb76CeL+9swiqptY7n40Bj6hjQm6jXL8R3obANVcrWL1Rq7DAw==
X-Received: by 2002:a17:903:fa7:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-28e9a546107mr157426005ad.12.1759757173382;
        Mon, 06 Oct 2025 06:26:13 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126ad9sm133655095ad.45.2025.10.06.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:26:13 -0700 (PDT)
Date: Mon, 6 Oct 2025 18:56:06 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        hrishabh.rajput@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] watchdog: Add driver for Gunyah Watchdog
Message-ID: <491de94c-e3c5-4f81-8e1a-82596413cede@quicinc.com>
References: <20251006-gunyah_watchdog-v2-1-b99d41d45450@oss.qualcomm.com>
 <3b901f9d-dbfa-4f93-a8d2-3e89bd9783c9@kernel.org>
 <a7633abf-0005-423b-b152-e8c70aa5c27a@quicinc.com>
 <b94d8ca3-af58-4a78-9a5a-12e3db0bf75f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94d8ca3-af58-4a78-9a5a-12e3db0bf75f@kernel.org>
X-Proofpoint-GUID: 3V8L3bH9NeFOfrf2YmeCvrK02k42-4_2
X-Proofpoint-ORIG-GUID: 3V8L3bH9NeFOfrf2YmeCvrK02k42-4_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDEzNSBTYWx0ZWRfX4r7LuHyl2Bbl
 n0+Ok1vn7NAvqxRGXKz4kak6t7DdanEIIlPnkDCvlMMvIsSVyEnxXpKRJoL0gbBEIUc64CoBfTu
 VJo8ugZatafe7A4du+FWxFi7oCeR5IHW+i65gEr5FzwmZCFkjt5vnCGrNvQX/gZKJjyPtq4m0Bq
 5qxTjT/XXPLnpkd14ivSTlB1Vd6QP3VZXEKpFWDn8gkbaZc6J3aoRKWNSVGc7ul/ZO36blRJZ6s
 Z71qT16a9PrRlc0JV07HqJchWOjs8gPnYhww9/fJW0fGEX/Op7A6mqXV2KKRlw5qa/X6nMiLaW4
 gyH0tieylnaUBs2a9+I6oX91o2/EcDOYt8F7Q1V8b1pwXbC/8AQ+bk2zTFTBmp5m6b1ITDCzQSO
 4pNwtcO4tCi86FqtabBVzyJAjzgFpA==
X-Authority-Analysis: v=2.4 cv=Hr572kTS c=1 sm=1 tr=0 ts=68e3c377 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=Jc37b2qoeXC1bbEKzk4A:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040135

On Mon, Oct 06, 2025 at 10:03:59PM +0900, Krzysztof Kozlowski wrote:
> On 06/10/2025 19:03, Pavan Kondeti wrote:
> > On Mon, Oct 06, 2025 at 05:56:42PM +0900, Krzysztof Kozlowski wrote:
> >> On 06/10/2025 16:37, Hrishabh Rajput via B4 Relay wrote:
> >>> +
> >>> +static int __init gunyah_wdt_init(void)
> >>> +{
> >>> +	struct arm_smccc_res res;
> >>> +	struct watchdog_device *wdd;
> >>> +	struct device_node *np;
> >>> +	int ret;
> >>> +
> >>> +	np = of_find_compatible_node(NULL, NULL, "qcom,kpss-wdt");
> >>> +	if (np) {
> >>> +		of_node_put(np);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	np = of_find_compatible_node(NULL, NULL, "arm,sbsa-gwdt");
> >>> +	if (np) {
> >>> +		of_node_put(np);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	ret = gunyah_wdt_call(GUNYAH_WDT_STATUS, 0, 0, &res);
> >>> +	if (ret)
> >>> +		return -ENODEV;
> >>
> >> No, your hypervisor driver (which you have) should start the module via
> >> adding platform/aux/something devices. Now you are running this on every
> >> machine, which is clearly wrong...
> >>
> > 
> > This is a good point. Thanks for bringing it up. We don't have a
> > hypervisor glue driver (yet!) that can add an aux device. Based on v1
> > feedback, we would like to be a standalone module that can self discover
> > gunyah hypercall interface.
> > 
> > Currently this driver depends on ARCH_QCOM || COMPILE_TEST. So,
> > technically this can be built and loaded on all non-Qualcomm machines.
> 
> 
> Not technically, but practically. We do not make single-platform kernels
> anymore, it's not 2010. Entire arm64 is multiarch.

Thanks, I understand that we build single kernel image that works across
machines. However, I wonder do all modules built say from
arch/arm64/configs/defconfig gets loaded? Usually, the modules
corresponding to drivers for which devices are registered (modalias
based) gets loaded, correct? In this case, we don't have a device, so
there may be an explicit rule to load this module. I totally get your
point on why it would be preferred to make this module active only on
QCOM platform.

> 
> > 
> > We can make the STATUS SMCC before looking for the other watchdog
> > devices and fail early.
> > 
> > Our Gunyah glue driver [1] do make SMCC call to establish that we
> > are actually a guest under Gunyah. Since our intention here is to
> > support watchdog on as many as platform as possible, it is better not to
> > tie this with glue driver and make it a stand alone and self discovery
> > module.
> 
> 
> I think you should have only one driver pinging for Gunyah, so glue
> driver or this. Not both. If you add such SMC here, then how do you
> determine the platform in the glue driver? Via DT? Then DT supersedes this.

The SMCC that this module would be using is specific to Gunyah watchdog
interface. So there is no real dependency w/ Gunyah glue driver. I
understand your point that there should not be two drivers probing the
watchdog.

> 
> > 
> > If this is not an acceptable solution (Please let us know), we can find other 
> > ways to limit it to only work on Qualcomm machines. For ex: Socinfo
> > platform device is added from SMEM driver which make it only probed on 
> > Qualcomm machines. We can look into this. 
> 
> 
> To me socinfo feels even better. That way only, really only qcom devices
> will execute this SMC.
> 

Ok, we will look into this.

Thanks,
Pavan

