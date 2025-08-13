Return-Path: <linux-kernel+bounces-766069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7DB241DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A452D164D26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12152D836D;
	Wed, 13 Aug 2025 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIhgwH/V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462C2D6632
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067781; cv=none; b=HwCF+XNBVIcjJ2vv++7Z46RUZ8sZA+W2izSRSrC5udmj0WfHKJRM4Y9Kmg4Vi22pLsEwutc/TTZcH5j2XBooXUU8TiFatgXWpi50i5JsOFtiG+6J/rPTh1cTBjtXswA2IpKK9EAM3iuSbq8F3GyB/GfI4V51/VYL8i7mBVi2z9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067781; c=relaxed/simple;
	bh=qyRQ1ln1JbMp75hJ0kDu7mG5tuW+40UemEalqrMf0ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPSGfkw8R9CPd7rg2VeEm5eV69SMT7tjVV2pQEGBizf5AlnpsFZousMdbxxGZBolPtOT084qDgQ08BrYTJIntA+XukyN/eg7RFKAmPACuZG3pXX0cQe3dWQyWkJ2lPX3uVsxY/7cP0PCYg/xM00pCyCKGBgVoOY0Li1siuIPdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIhgwH/V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mIlY008686
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HR9/XxlfJFSa5gaZ2/cVDFyshE0iTajAntKn4VZZZrQ=; b=SIhgwH/V4QenCM4C
	xkBnXsx5YwItCzp4+3qOIaosjjx5m5HxecLBrZkkJ1sms73AuEnejMljT6Yaz7Hz
	Jffl9h4V0In5Hw+OlEW3RiViJB4NDSYnE2Zdx7zOvOkOFnING5ZxHkNipJw2EE48
	VcFqHqekYQ5UmaTY2jFZf6DWazmFkkqx1d3NUdUsalfPqAbno8lzY4v9I65AqVA1
	dWAQVsQLg6QtDV+6pvSnyjBEJk5XVg5dy/NCIuhGVVvot6HHGAajLzkgN/vq8lpG
	f7pztSiJ4gs1HDfMHY6FBdme3PCFfNyqqzOThu5lCkfixN2BGNJph9CsUbDdXkf8
	F3DKUQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4erhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:49:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-240b9c0bddcso60454285ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067775; x=1755672575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR9/XxlfJFSa5gaZ2/cVDFyshE0iTajAntKn4VZZZrQ=;
        b=pmzGotFhjvfTcQa4S+lSOAeFse3eY+1s5sCjhixGWXmgZsuMVBGvADgkdk8nyy13j0
         bEjGikrQrEzB/uaDKXDxvd5leKYVmduTOZ1lqUz56a2SxrCeBjaSp2nb+McgfDJWBD9f
         OSe+OQMabevb+4CxdCLKb5NilI+WAStEUX38M2btJHt13TiVicuNDCpwrpBwrFUnJkC0
         hNuyw0tcprTKCeRU3HBXSe9PiW04zCBNkiYzNYQdsg03bBsdkgMvoDCHlRVNa2Tbh4yc
         iZ4CGWyIPVEfCRXq3DvPazvy4pITpOtiHGtyYsB2NNMzxHy3efGsBNp3FeNORTR5Fe6E
         Dmbg==
X-Forwarded-Encrypted: i=1; AJvYcCXlxIsdIRirhttOUyz0OG3/lBzOJxOzXU0USgG5TJzfrlj2lljxP5wzhNsUgRJ7C4cS2UV6xw5/gIR7N1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rc72IsD/i6h4DCn4tH0FZiefuOBfYBbQuyaeIB08nIfPH1E9
	IGque4e5D34vdl4H5XXmh9CzlYDYD5IoVBBI+QFG8etXL7QUMpPUyGE4iXxR0jQriU8m7k1IHky
	7LFK+VjCPnrOgFHjO+J0yh2rQCwCkPrub2EQXCSP+R/+TulYvt1VpoLgYprB6YHKy8So=
X-Gm-Gg: ASbGncuFdpyic6yWKbNGTgTgMOetj9+VlIFJqao9ofWamq+OPh6PnDPBpB39cTxYakg
	Hyv7KPFrLMM4x1w28veoo55J62UgEQiUzslLB51teIsvAiA5Q/cs6WxaSQQ9l/CDNhXT6Rk78gf
	5RT5HZt16LkI2in4SFz9zfLv55LrnGnbKuAKjTPVeK2zawYy5ZoHaraCdpACD9jaiD2+HpMRgiL
	yb5jK0Nr5QLQq9HcR+BzibvsGZmnr47Dd2jor3j31w5IXXBk1Cagfn3Cq8DDC6B40eKv33PzDVh
	iWRuuT3CLQ6InbcxHZjoya9GfBARZxsHOSizl1ujQOQweBTyZWMlssSMnT7y3ViR4HWxRP0=
X-Received: by 2002:a17:902:f64f:b0:234:d431:ec6e with SMTP id d9443c01a7336-2430d0dc1c7mr30707475ad.3.1755067775108;
        Tue, 12 Aug 2025 23:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIOmylEZgOC3s9pxN/xlV3S8avBhHKj9sbZhpAlOD8ga+zYpIHqDLQaDRG92qcXGtFmX4+6Q==
X-Received: by 2002:a17:902:f64f:b0:234:d431:ec6e with SMTP id d9443c01a7336-2430d0dc1c7mr30707175ad.3.1755067774613;
        Tue, 12 Aug 2025 23:49:34 -0700 (PDT)
Received: from [10.92.180.108] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24300f8ca2asm33500375ad.141.2025.08.12.23.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 23:49:34 -0700 (PDT)
Message-ID: <38a8afb8-01f9-46a8-ac87-be1e4ab53136@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:19:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] usb: xhci: plat: Facilitate using autosuspend for
 xhci plat devices
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
 <20250812055542.1588528-4-krishna.kurapati@oss.qualcomm.com>
 <CAL411-qmWLJ9vYTc+NHFYymsJ27ryge88nTc71NAnzDa7TrExg@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <CAL411-qmWLJ9vYTc+NHFYymsJ27ryge88nTc71NAnzDa7TrExg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 81w84vOo1kLL4er1ltXrESHws4FmzzfF
X-Proofpoint-ORIG-GUID: 81w84vOo1kLL4er1ltXrESHws4FmzzfF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXwyoV8dki3rQu
 Zv0TgmSGWqcHMPLyIsNOHyNHaX2EEtuTqsd3c+7ET+bsYhazcg2JUfWfJBXIWBGD0dD3DYmZaLq
 i6Z/d747v1vVI6BUFJfA8KQoRLASV0uhFLDSe/Q6CqRtX5Qv+MxMFtVhjA4N5RXnpXN6NfEWrNf
 07bvDt7PQOJw/cN8wsumt14LmKnaYmmZCAipwWAoH2WLti9e7vBRMRSPXvoKxYNnNwUGK92GjXx
 v2/nvq7bzKbQwk78M4nxfX/IHqdQ1iXdrtoHN88BlhZHWd2WhYPoUh60wR8Ho7YsmcYOmzMllqB
 kiYlrV1yHBZb9ul+nd/ICMHW4izLEEden/tWk/3q7ho8ad/cs92LjMceIcKGnylZPBq7MQJ/27M
 DbrAQXUv
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689c3580 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iitwNcAuny6OrRLJqDIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068



On 8/13/2025 11:46 AM, Peter Chen wrote:
> On Tue, Aug 12, 2025 at 1:58 PM Krishna Kurapati
> <krishna.kurapati@oss.qualcomm.com> wrote:
>>
>> Allow autosuspend to be used by xhci plat device. For Qualcomm SoCs,
>> when in host mode, it is intended that the controller goes to suspend
>> state to save power and wait for interrupts from connected peripheral
>> to wake it up. This is particularly used in cases where a HID or Audio
>> device is connected. In such scenarios, the usb controller can enter
>> auto suspend and resume action after getting interrupts from the
>> connected device.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   drivers/usb/host/xhci-plat.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 5eb51797de32..dd57ffedcaa2 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -171,6 +171,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>>                  return ret;
>>
>>          pm_runtime_set_active(&pdev->dev);
>> +       pm_runtime_use_autosuspend(&pdev->dev);
>>          pm_runtime_enable(&pdev->dev);
>>          pm_runtime_get_noresume(&pdev->dev);
>>
> 
> There is an xhci quirk XHCI_DEFAULT_PM_RUNTIME_ALLOW for it, try to use it.
> 

Hi Peter,

I see it being used only in xhci-pci.c.

In xhci-plat, I intended to only allow usage of autosuspend and let 
userspace decide whether to use it or not (echo (auto or on) > control).

Hence I only did use_autosuspend() instead of doing runtime_allow.

Regards,
Krishna,

