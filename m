Return-Path: <linux-kernel+bounces-886658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E43C362B9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F73D34ECE4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731932D0C2;
	Wed,  5 Nov 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXHWNnIG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ch1NkDJj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D92DC332
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354399; cv=none; b=qUmCQcyTYHHSYkOBUiqeKiuZL+8iQn/vUOc20N6+QU6yyUHn6JnYcoRmsEWQnKF1TZHMCsvPVYUk7Dts0KCdID01iC+yfUqiG16B084JMb5J2gBi/Q5EVrkFq14LisxS+zeF2cAODa/jQVdzTiXDUYHEDEKUfRsAygWKDxZ+CrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354399; c=relaxed/simple;
	bh=ZgLnTIpuw7iMUD2p5JgOQgzTNBsRCY7NK5SJrp0upI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKl7odoHhzTAtD6g8ro7lpw/0+J4xWfXyBx2rbWMemm6zLlUBjS46WeYa09rQPcwhhYtMA2wSf8+p1DWaOILL65Y+FPMAzSeIXEGBaXxx5HBoMIl8/8d+lm55YhjrFpmFsE02WLeVRgKSXkwzB3KL+ttKJbNQ2GlmuYRDJ51z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXHWNnIG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ch1NkDJj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5E8Wh1877029
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 14:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qb7H+O99MrRRnHa7puLi6iRhzA+Dw742C6iM4xdYqBk=; b=oXHWNnIG7ITEgmGn
	TnsVZcEWUaIdjH8wxjUZUPzqzDpGtcurQX0ttF1DXX45cH3CBjtbpU2gqwvZSoYF
	mxcn+2G2qJezWoNdwcLUrwUPk1E7Uyc1ugVTJcU0iY4xrDqsrhwb3hV491ncWlXw
	Y2slfrwjq7Acgw93IsYIjZGriJrKsacWlml2nkZGlpphTs93jP4fayvkPf6+1VZE
	2XjsNWBmLPABM74yq4fCVV8R3KG/KN5mf9L7ruSaBkK3e9mz6kvu7ehcFriZjCwW
	8WJ31XOo/FdpH7ZnrCrbrBXtQxdbBacS3MXWYlNfgBsmRNz2RY9+LlcpBvso6WNw
	U6iYlw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a88318417-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:53:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e89f4a502cso195268631cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762354396; x=1762959196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qb7H+O99MrRRnHa7puLi6iRhzA+Dw742C6iM4xdYqBk=;
        b=ch1NkDJjCsi/DjDbDmEcjCI3bJyNnWOn5TySmEh5th27LAAJZOCuSfPsOvIrxAOS0y
         TEzyXwwQegZzJ3rg15HCL8N3NX3t+VNGIEpt4vuu6G85u+8Mhln+cUqSc5Ovq5uBMLLP
         Av2K1bIkMd14FuEYz3a/3EogiwD7YbilaP33R8eFkS64pIS0W0mJivK090ABn3RJjPFD
         6cNaIfFDUvrXA1RLpIL89snNRNrWIpcDQcgNtQY6U0fq1XgjIHxkiUxjH1fD1Hu0r2TS
         XNP0bmHDOHwFakpdYtpZIzM+djULxYTrvT0hUX+6CEuN+u1jwSsvjyvsofFmqM75O/i4
         tYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354396; x=1762959196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb7H+O99MrRRnHa7puLi6iRhzA+Dw742C6iM4xdYqBk=;
        b=E+V0LZAnH7CkDianKYSnYVW1myUByVEicF0Kq9Pdo1ehtTMW7FDjsAxsUnSyIR0L+I
         05hHBzQ/28cBS1L4Vzjb+AjYbiBT73RmV7GwIJhW0Zge9hUhkvZeefioZPNSkXMsOHEv
         i145xCXVojmi9jc64o536f+vDAjY5GVqeMHcxK3TS76kre0/ugbpgJuuPlUbF3AWl+xm
         +rSkhZccBFR+SWLCJW9OBP6lzTQh4PifU4uc8TkojxriS5gp/FSjSzQ72b25THpeXqb+
         p5IEzS8f7lDkNpVpMmKWorhGKO4I7F9c3n+7/S4RufAZIR+GtNIg1s+qsRoAjmFbfsIO
         x05w==
X-Forwarded-Encrypted: i=1; AJvYcCVxEs9RyXlGPAxMj7ChmH1QkZHGp+PgyGP0S/Af+7Te/vFnn5m6D/8VHBytGFSDOI22Ii5Pzh/zFH7IShc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcqOkca+YEme/ET2BH+B0tdlGO+wKmTy7+ICRIpGxJo/XJiFs
	Vfn4bnTDQYrQ1BYx4QkkgqIR7wGhE/eSfMLstJgRmGhVCMxka5Xv0SRau3s3ZMwSFBmsjiXW0BP
	WJuGBPvBhx7j4ZBorWMcpen+9h4pu80Yqd8JpbIO13kGcxjvO0ckiLcs+MA5nOtzsC/s=
X-Gm-Gg: ASbGnctelDdgHxy2HILXHYNPLPSRwDhu2LWZDRYhX2XqZGQpDyj68hJ3AmR3P6vgc3n
	5NKKeqN3zdirk3oSUbVFRmRt3OBCdGwwZyy8bgTKy79LM48cJp8G++jguGMxiU9jl9mgk5Wnfmk
	3U6E6+ztsfZz2uaGkDVWTWh4+9K/ZJotlE43jjmzsiTWSeajzOrzwgQFJR15p7JaEsuduhDuEYB
	Ag5vF5sJWFmSblfxl7jqzCyN5TOe2F5cqRGV6BBjsugHI+pxkRtiOobGjtvq3zAVIyPfijxAOtS
	+dqPMhrELJ2U4OaqKMo/nJOivvFDzR0bxhpAzjj21dZoXXG4KKIDBqOcU0XPN93LcqrUmCoKrlH
	BnPjeya1lKO/3dxXevIHTGt4uckVWklp79OTON4tSTDGGHOAi2fN+SigcddpIWYrYXP8csE6F+H
	Kc0bZSDufoUYgV
X-Received: by 2002:a05:622a:2513:b0:4e8:b107:b213 with SMTP id d75a77b69052e-4ed7236e696mr46499441cf.32.1762354395613;
        Wed, 05 Nov 2025 06:53:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGErc0OJ9wz7u4BP3Imr6hGAsKunW4g+kcQcp6nzduMA3D1epXa8r0HbwLy2NVAJs9hmrDq2w==
X-Received: by 2002:a05:622a:2513:b0:4e8:b107:b213 with SMTP id d75a77b69052e-4ed7236e696mr46499181cf.32.1762354395098;
        Wed, 05 Nov 2025 06:53:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943437efdcsm1803773e87.13.2025.11.05.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:53:14 -0800 (PST)
Date: Wed, 5 Nov 2025 16:53:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tessolve Upstream <tessolveupstream@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Add Qualcomm Technologies, Inc. Talos EVK SMARC
 support
Message-ID: <7tk2hd5qursarvomuwe7yt574vmjixh23zz3iw6nzpzm6x7jlj@7q2vlik3t2h6>
References: <20251104125126.1006400-1-tessolveupstream@gmail.com>
 <xq4jidiffovpg3armhlzrzxloug4irumlycyyvmfaugajbtq4t@cutuj5736ayo>
 <58afe57b-68e8-4de3-841a-df3dbf04ee64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58afe57b-68e8-4de3-841a-df3dbf04ee64@gmail.com>
X-Proofpoint-ORIG-GUID: YNwd0eXnNcH3U6Le1zYVsiRXiStn3tNF
X-Proofpoint-GUID: YNwd0eXnNcH3U6Le1zYVsiRXiStn3tNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDExMyBTYWx0ZWRfX9HWCNq0QA7h6
 6RG7pQ8HdTg5uFp5j255YTeJzAuIwwlfdpi6/XfBjxOQT3d9pSAdAq6NJqWbXizn+x+Sy0t+O4N
 h7L8ElU0u8QdLtafPWkHsFTrFgH2N5FL14y7eFrgsghmXmPel1L3SxQJ6tm+l3J4KA6I7Yl+Bao
 rov2MqwOrdA8Z3zG4SsgLYB2pNk72YJjk2dEgEJuDZwu60pV6aaAwc9tnwo8eI+KA31SYaQ7lyb
 36+MrZcWcfEqrLOHDbbbfQzuLpNAslPVtm+Ii+zHa0Hv9KB0ascxUleLZ7Qxee1YU+cO49P7Xmm
 H1IWGnj4lM9gdHoRQemgL3llgp11LR7f54uPmaUDe5E0cUo8iTIzWGMcariF3utrS4z/QUTu/dw
 41eCvvOTliKcwnmiOLopu65CvWlJfA==
X-Authority-Analysis: v=2.4 cv=Mdhhep/f c=1 sm=1 tr=0 ts=690b64dc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wqqN0V02qe91zFPrGA8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050113

On Wed, Nov 05, 2025 at 06:27:42PM +0530, Tessolve Upstream wrote:
> 
> 
> On 05/11/25 06:35, Dmitry Baryshkov wrote:
> > On Tue, Nov 04, 2025 at 06:21:24PM +0530, Sudarshan Shetty wrote:
> >> Hi all,
> >>
> >> This patch series adds device tree binding and board support for the
> >> Qualcomm Technologies, Inc. Talos EVK SMARC platform based on the
> >> QCS615 SoC.
> >>
> >> The first patch introduces the DT binding entry for the Talos EVK
> >> SMARC board, and the second patch adds the corresponding DTS
> >> files for the platform.
> >>
> >> Note:
> >> USB(usb_1_dwc3) supports host-only mode based on the switch SW1 on
> >> the SoM, which is purely a hardware controlled as USB-ID and USB-VBUS
> >> is not connected the switching cannot be handled from SW.
> >> Hence from SW Host-only mode is supported on Linux boot up.
> >>
> >> Changes in v5:
> >>  - Updated commit message. (suggested by Krzysztof)
> >>  - Introduced generic node name for can, dp, hdmi-bridge. (suggested by
> >>    Krzysztof)
> >>  - Introduced talos-evk-cb.dtsi, which has common carrier board
> >>    interfaces.
> > 
> > Common between what?
> 
> Introduced talos-evk-cb.dtsi to define carrier board–specific interfaces
> common to both HDMI and LVDS top-level DTS variants.

Are those two different carrier boards? Is it a single carrier board
with mezzanines? With extension boards? With a DIP switch?

-- 
With best wishes
Dmitry

