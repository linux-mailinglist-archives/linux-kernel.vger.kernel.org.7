Return-Path: <linux-kernel+bounces-732332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10765B06535
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DE1189C218
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B160277008;
	Tue, 15 Jul 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HtSSWESm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E424272803
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600906; cv=none; b=LAGdIf7K15lbqpK2jLGxMBgVgMeSJcR0/Ms4YEIkQqO6ZebVsqn5psCw/YIkCK3MWdr2tHdJs+DacWajvLkMH9WKBjpRP3eOtwNTIUaBMC8O1psoYkbr2PXANT7AW7B700izot5/aoFsM/RNmeueQR2gnNDeu8/O5e0G+1gCM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600906; c=relaxed/simple;
	bh=2J8c2z5EXWGctgukrb93oHp2+Zfj54zLjUjpoTWXKbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8ftF9VLnNn/p9XeMJTl7F75DO2gXRntX7jNfh9+GCO2MwmSTJYFAkUFVirxIZnwKkFxLJtWisxgeHAUbaEaLgJxnvcfgymUFqjHInGzdBcJyNo2jW5D3OmBgl5GhkEjo2iC+Qm8uN38iU2DLWWn8C+14pHj33YYzT5VyqJPeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HtSSWESm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDP4e029618
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YwHMduJFVZ0XMQsQOdCu9rTr
	BXiDOqf57dZo0ADVf/k=; b=HtSSWESmR1v8aUvbmxFz2n7lv4gFQQKPmoVqHA/B
	INn32DeLsRf5fkKXgD8Ae2eet3yealk6LUaWq0zXbhU68ttL3LRbOUs2zi9WrE9/
	BE6OcAqfBGfnVef7n4cOSUHHj8x2RwS9kz5mM6ktfYrTIHh/QVm1Mz/N5DqHsmRS
	sW5YkTnZxb8Yb1s5jWyY3BVwMJyOGf6hol4Iip/9FYjYcHI0ha8mdGWinyNdxX8T
	Z9TgsfLgWSmJepkif1i/zHKYX4mJBXsmwO3vXAdTXdS/2RMAfgCUwIULweluiAQC
	INvCL10uUOkWDMrPXwAe72ATx4/BA56yOJVCCORFzx3V7A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb16en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:35:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33af599bcso142458285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600903; x=1753205703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwHMduJFVZ0XMQsQOdCu9rTrBXiDOqf57dZo0ADVf/k=;
        b=H8E8vzXtqmCiffCBm17Hy6rbBRgvi0lraYV9IIUsb79v7L2H1OkgG53GCGLHfMZVD7
         nthY6vZfBzYZJy5qELqT9May5or+kHubPW/byAKhmagLUKLa0upfJl7Iipe+bTJiLqv9
         TXpLZ/d2ssrLmkuXb3xFGvoaqnfL0v34sCCWz/srXb1Ljn4a9NAJu8cGcfvxXtVBK6Ln
         wjsUYmXMSlaKl/t5Bovnkph6MGjTTNy2tOPcpOw+b5+wNc4qiwOHnpCEYzK77yUnTAaw
         p4Sd/UbQ/s9SY7ohvUqWGLxhbg8fcw5oqryylF3gkWl1aZRkvy1lr0IHVy6ejSO39yeo
         L1SA==
X-Forwarded-Encrypted: i=1; AJvYcCWTls8p05RSnoQPCogBfgyD6zQCDpMaum3tdV5K1O8LADgQRwFUn3o7ahXCAQw41WVUlQ8SUxrlXAE8mA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQHJLtaYILY3+hc6o2ood4FGDFYC+ljE6Z1NH2L/LYGI0XbjR
	t2WfID2z7IQjF4Y6RR96SWCcrKFrlq0iKANbKgaLwLs4JspVf6BpYxTyHl9qA633+3P2Y4KrMt3
	UL7nd54fB6IGxfl77F6eicErZ9le9jBQLl6f/6JehYAuGIXCQ+YQYjZO11TaNHc/DaNP+Cn97s8
	U=
X-Gm-Gg: ASbGncsQFzUL05N6evzabOmWDN4TqYyAepYWqO+GdFzOlgX7Q/y2/Z7s+nrTt/wzpim
	yI1TTh26apBaSOK9RJNDDR+MIVl8rLPIiB8zdT/adtToLr4BRw8WjDty76Y7ZQQRcExKLZCMiyn
	WlGy1ZCoMz5cidKwl81wMcQBIXoAEu4DVCJr9wUQR0lUS6lHEzcGtEMGHGT66UHAjwd1AiCwtTl
	N+sBugTXkrMgcTB9wPCmTgVyh3gnsVCX7wiIEdvHlWB8Nwjtjo/JeWIQMR9pan55oMdu//9CMJE
	+5t+eAypMjsF+t0H38XLY+dnzT70YJuOcUwqG0SGJ4OdvtRftDTAT/UBaJ47D/y19yQyW99PKvZ
	1KZeQCN7sAHRNX2AmuU18IaQkwni+9dr/GnPgOuFMFicTqE68k8vZ
X-Received: by 2002:a05:620a:4513:b0:7e3:33af:c45a with SMTP id af79cd13be357-7e333afc5a9mr1078301485a.49.1752600902904;
        Tue, 15 Jul 2025 10:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkC/RAmmlrlOop2nd4cM+Qb/s+gLrKuUEGXd0Hyq1/Zw3CSYcbKVNpSB1ZGZ2gTFs/qFsWQ==
X-Received: by 2002:a05:620a:4513:b0:7e3:33af:c45a with SMTP id af79cd13be357-7e333afc5a9mr1078294185a.49.1752600902369;
        Tue, 15 Jul 2025 10:35:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8ed429sm19601101fa.85.2025.07.15.10.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 10:35:00 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:34:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 4/4] phy: qcom: phy-qcom-snps-eusb2: Update init
 sequence per HPG 1.0.2
Message-ID: <n3khphjtqwcfhzxbdici255in2cbceujp3jlrtkrqsd77jtftm@ggpa6eek2xna>
References: <20250715-sm7635-eusb-phy-v3-0-6c3224085eb6@fairphone.com>
 <20250715-sm7635-eusb-phy-v3-4-6c3224085eb6@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-sm7635-eusb-phy-v3-4-6c3224085eb6@fairphone.com>
X-Proofpoint-GUID: h26vqgDX_kF2DtgufHTRCwam1XvFWH0X
X-Proofpoint-ORIG-GUID: h26vqgDX_kF2DtgufHTRCwam1XvFWH0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE2MCBTYWx0ZWRfX0gpGQX8dBrVs
 jxaYOYKYJrHGcxzqZS6tGUghYFou2lqt2ORRnvLsYaVbhb710md2MXfvMQtqO9LKcDSq/sOlkfu
 EgmjezOVylny/kMHt458Z+Xw97Cf/s6Hnoed7DLOA0UCQNATHZcTVwfplQKyaBwLw8XIz31TMJE
 8hmSAuJQm2UEG1JgjB4sYSqkEVr7Y65r3PTlEsWGTh5fhW04BNl5sk2rsmX9zHoyWp5U+2ActCH
 TmvtC5fpz37S68LwT3wqxtBVYAON53h4yeqOCrcjfw5s1vxZ7gLsFTIRargsyifaKd8o59dzRZQ
 jh4qTQoUB0K2OjQ7qvZCh0kHhOCE9a0OuER2yTdJ49+u0RGPqgQJ1YUVldhpO87Qj7z8UgmSuTG
 1QwYzp91mQpR3jxqZe+lKCX+JgNnbFvId6ptgrvJCvVjrR/WJHCV/eZylrCB0tNTbVPHACHK
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68769148 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=xixfk-lNQEsWtM5knIAA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=907
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150160

On Tue, Jul 15, 2025 at 09:29:37AM +0200, Luca Weiss wrote:
> The eUSB2 HPG version 1.0.2 asks to clear bits [7:1] on all targets.
> Implement that change in the driver to follow.
> 
> See also https://lore.kernel.org/linux-arm-msm/7d073433-f254-4d75-a68b-d184f900294a@oss.qualcomm.com/
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/phy/phy-snps-eusb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

