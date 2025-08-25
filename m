Return-Path: <linux-kernel+bounces-784039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C0B335D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C260C3A84B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2E127605A;
	Mon, 25 Aug 2025 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXdeTOYP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4581DED64
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756100437; cv=none; b=qZFXULY2YL9xfse9bo94fY3V0bV5XumO7/W8fm8fqbOOM+iGdVIxlMeEnE5GBc+6HIJRWY1Oo/oWx83WU0aELl2+aC6kEdR4EjLBUZcG5aTDiIwJf2NaspEdSEB6QTRp1sDovZmhoJZ67hji8o9mjGsKM0cnqmkBM/6SZRnv5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756100437; c=relaxed/simple;
	bh=GWJkno7UH1EmP0ghaeExjRxfS6IMqGgi2ZFXNxROOgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvdI3j62gyyuWLedvRbYDqWGo8HMuLLcTYdBENLQZDX8Gsz01cLf0PskW0XpuLiXjlkwsNcTaKMRfgU0m2ToPlScoSLOrweF8k8E2Txf+TgRgkAOGxC7Mm2tZcbtWAl4sU5AwQWwuMdtdb2Ga9dRAFZg6TA0BMyXkeB4y9vK1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXdeTOYP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OAUGBJ015139
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8a+TtvwZG10ZUAyJp5QPl4t7/OgCTRNElkzgAj0FVsA=; b=WXdeTOYPq2nMdvno
	pdMQ/ShNbNshVifZRInAm5XNVFrRXvdc43NXspfjU5/MKx964zbcXs9zq4Ajx/wT
	F0xUXNt5rRoEO1Q9Ip7NGJo9YWCWqf0mnUkOUXmsYf0NHVCFVfZK/06hkp8Agmp5
	LUX8QUgGatpmyUxfijXwZkbP853pdP3u1v4qp0Y39u/aM3lUunum8uRctjHYg+Nr
	CNhvgzQIXYT8B7t2q7zQMHZfMEddQpgFFffYxNHiF5TD+aF6lb3WLN8Wuz3rnOLI
	GR3mojXR0V6hZqx8Ll7yC5+n9wUvT+CT5x6YDm7lHRYRq2dlK4L6/46DY1XOnbz6
	wSuO/g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w2ky5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:40:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-324fbd47789so3403527a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 22:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756100434; x=1756705234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8a+TtvwZG10ZUAyJp5QPl4t7/OgCTRNElkzgAj0FVsA=;
        b=JjTJAAkZ5xP8R63AeX1ky4Gl6QKl/0XsdXuGQ/gRO3FvjV158ysVt/YnVMQScEo7Te
         sKEAt4OB7teO5Q3nLgn0PXQiBZWWDJsANM71wg07vBBulfhpZHqbNyhZWNM9H0GDh37V
         PtbdbL5oRxkPi2I2QJPCVRxvXF10O2uladTCcuffv73yjn5kNnFM7n/LPefcJt8m/gqG
         LvHA/mW8Zn43LJxat5/3+izJ8KChHAzFroMJ9OQC77wc77M4g4AfFPhZqzetDw5YivBV
         fAi/wC2glyZuG7K6W1IIXaxE431FlrXTOrzcdIYlto75reEviIvUX1tO9ANRH64T0lkB
         eSGw==
X-Forwarded-Encrypted: i=1; AJvYcCXF1ajFoLXPQ3ZE8HQ9RE7Lo4iVKV6oUVn52YjOxjrfeeMKhq9BEddjol6D85ok/XKwsK3F0ZdW1fAmrjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMzsQjFQ0YfLpq4tTrw/UKKVIfZdweTxd9fNtxKjzZVTwk6S+
	Z6aLBcJZLzHToenOWpWOsotGKpdWZ8/Y8irLeZDBRFEGTbHRVOAOkEZVXGQmKRv8dJeqG71zGbv
	eKzx3W1ZtXF1HlkkXzvg0RgZTl8POmioAhLY3pzW7F5RXbmlP9RB7SJjXRZiy4rUK/7I=
X-Gm-Gg: ASbGncvXxVgj9kgdXoMoqtFdlX6ubn0kG1gPTR8GZBjBEmBt7DO81S/ndDwtzjMVD3v
	hZp5XjVf6eBdd+9elOG2ZBrV2/EopkZ19A7B+QSEyQAN2Por3v8AzsvKQT+vs+X7kyHVsZ8GNfp
	1oZIkR1ZDwZTE36UyFrBBaEEuMAw3oZnSa5EGcMPbdr7lB41UAvHN612wHIxuBjnI9zbcyfRQxO
	Abb+7eSc2ZTppagISsIUykeOTmocFfl5yoNxkElmQtoddiB7H/XjswymvVL4ys0YUjCywSWmPO6
	+G5W4wHTUcVGUOBkgmAkM9wjwzi5eqQbf+UfzcGTOZaoyOcR+vVFyB06ScHKswtplzzs3z/j/w=
	=
X-Received: by 2002:a17:90b:1b4c:b0:324:e6d7:6daa with SMTP id 98e67ed59e1d1-32515e0ed9bmr14080783a91.0.1756100433693;
        Sun, 24 Aug 2025 22:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhgaMin5seYJHkfrlytGzFCnZxybYHYMcFaVpDKc9LsysyD3YbO70n6HcNcaQfiZnvmdMbVw==
X-Received: by 2002:a17:90b:1b4c:b0:324:e6d7:6daa with SMTP id 98e67ed59e1d1-32515e0ed9bmr14080743a91.0.1756100433067;
        Sun, 24 Aug 2025 22:40:33 -0700 (PDT)
Received: from [10.218.1.199] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa6e27esm5847724a91.25.2025.08.24.22.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 22:40:32 -0700 (PDT)
Message-ID: <d121952e-4662-4651-9398-3a5446a2281c@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:10:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] usb: xhci: plat: Facilitate using autosuspend for
 xhci plat devices
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
 <20250812055542.1588528-4-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20250812055542.1588528-4-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68abf752 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=nnkCm9v0YjVGcTDIYNYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX1LLLRU3qhxCL
 o4i1zH+avwe91KFK3DdywAHqLk+Ai6u+KNhu9a8/coQRRcdHhRMBolVVRsqxzMkvRi3AifIiVMn
 Ty6fQHNvkpxHlJJvUJV8SgzXOkxW8LWteamdbmLsvlmIMIUVRn82FNj//zGpssCQT/VZ6t1Nan+
 KLuio+XknQj8nBJ0sYHlmZ5LBzCV0KDIhg06L/vGCt6xnD62ScBGIS1yEJ3GznqMHLvJc4qjCdk
 nLxjIbFzBgkinUMWsHjXAhhfbKROZNRGT3sPIkGf7ojrxJ3yLiNKN4z4R2ZXbAoYdNRUv9pZid/
 MRyBLPAJ1f3IUTjM8x3V6L/d+7oFa1Ym0zA1Rq0S8cJw3ka6RhFjrX6x0/G8lXxxdXyCdz3hxqw
 JblKS6E7
X-Proofpoint-GUID: bVQM3kAy1viwxROy_UdBJRTnRDfmcw0F
X-Proofpoint-ORIG-GUID: bVQM3kAy1viwxROy_UdBJRTnRDfmcw0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/12/2025 11:25 AM, Krishna Kurapati wrote:
> Allow autosuspend to be used by xhci plat device. For Qualcomm SoCs,
> when in host mode, it is intended that the controller goes to suspend
> state to save power and wait for interrupts from connected peripheral
> to wake it up. This is particularly used in cases where a HID or Audio
> device is connected. In such scenarios, the usb controller can enter
> auto suspend and resume action after getting interrupts from the
> connected device.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>   drivers/usb/host/xhci-plat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 5eb51797de32..dd57ffedcaa2 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -171,6 +171,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>   		return ret;
>   
>   	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   	pm_runtime_get_noresume(&pdev->dev);
>   

Hi Mathias,

  Can you help provide your review on this patch.

Regards,
Krishna,

