Return-Path: <linux-kernel+bounces-871438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0EC0D461
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2B034F5E45
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C72FE05B;
	Mon, 27 Oct 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDTsJKTw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604D2FDC35
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565612; cv=none; b=tu1FDHtkWwwEExn2XdwCOroMjwsHBHrV0IWV8vQNYphABEn2c6uvJf2N2PG7uAHUWdBzgZCIgF9FefO+N6+FParxrCqXhuj5MsE4FbIIfC3Tjfxwhzm3lm4VxaAOAN6qe2Y+kOml5ZpduSzAD9bjsXmzB5Si4bNhH3w5NmUQtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565612; c=relaxed/simple;
	bh=sLSDLFIycjwi5DUJiwWXROI9mVj8Cx9y+PjBFCqILz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pvf3LtBxyBimP2VQ34vcuMAYeM5COLybZ8JFmX/0uxjknI/0PFIVfcrjOI/3wiUYz5hMCeEsZWBe7u9Ox0kutVIuOHZp/cUHgIBmPAqZyJlYoIWmTdkLwNKo+0+Nl3SRjUSJRCKFVTYVep9xNdvrtdIgDDIKTy0Bqr6wIw76Bgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDTsJKTw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RBJhF82546709
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7FbXOdWgkLEaT/XePs73VoA0pwHdHNIszOesKkyl1U=; b=pDTsJKTw80qZEM4p
	msAQKifurwKK/WOXlgyv38815ZJUFoANG8Cc8zqw/J+YarWrJfnTp3vA/wlE+A0p
	vxFIIzrevW1+Q3N8+INrtIbl3oGmhjApl7fnxMqiLXtignZxraQMijGnn1xBmgRd
	K+5HiITBbY/e91hsmmExAvMDyRJ0GoFjf9oi95UO4YthG2NkFYr5DK44uAe9QiEo
	bjjXeAdbSqWXc6KFaeY0eCPSGTa9JfgX++5gWB7GDZWKbAgpbPAQ3Bb45YiqPhMC
	kIw2mhqLE5ilRvWgLO15oscsRYYkcYCFyRForsqBfTwpGtws0tUVM0TA4J5nESaj
	DaP4Dw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2g23x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:46:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1d388a94so13772846d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565609; x=1762170409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7FbXOdWgkLEaT/XePs73VoA0pwHdHNIszOesKkyl1U=;
        b=AqohdLF8hmYLiujnNtnHkjI/znxAa4zhWTga40aQM5YNJ80gCsk51UA/gRXex0woi9
         WjKXoVCgTpoYtIwDu8wCogp0CLjelkC66OiUVxZK3rOAAXnVU7JFcx7lIj0bIJTSqSVx
         YaJSSTlStU+eLNvF+9pflEPY5acGB6K+PqqW2dZhwoxxq0MxAIERZ5e8fe+cgg2vkwcf
         Sa1zeFKT5LXSZ7WXrsHvQr5SzQw4WcTSDnbH+OvhII5EGnQGBRWwI9gr7cF1rmLyTZqX
         HxD/9dGORa2GM8Yz1a1XBjo/+7rTrmDZrZW7IYyCgeXVm6f4cAhZvGPf3DL5S+627Lzm
         K81Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/hNWr9ZEYohoSdTmAeUTKIdxGeTbI0/H8pXOhjo8DlWagDY5pIXNWekoOEK+DXE0f22XFRkF3aNgeGog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU55FKVC93EpBvr3jgeNOHMvYifrf/ryDZhUSvrjbaAgxTonra
	GIiw5NY9nIG21Ufxv3tRUvoymwu993OeRCDaNMGloCa6OnVA0l28K4o9c7fnT3Pg8L1bhCO3but
	l155PRq+dyJxXOVfDzorGQzavuZsVDH0H3gY4yZzlek/2fahi8HOHL+fsPazne0OodOU=
X-Gm-Gg: ASbGncs7UmWx3Ug7lF+5P569dwTf+xfW4E1ZbI3EMCTbReADvC6BUxYIse1Kdn1YpJT
	kgOVT20HCkV1AK+IHCz3wRCVmC+NHuOl9fnQ6+9M11Ww9ZXYJpBqPki1nkbRWBxfIvKdediyAnG
	EyO7Kg1Lyzq3iJW64ASoMla31dtbwn7fh06yWFLeFIteY2563rZGA5ZvgHxYtky55l38SfzDSqD
	K42gwpMTfiS+5HeXkOTjSd85xyb/2ibw9V7iY9hrAqe9KXT3nqyD6tWDlrhYnOIDqJk6cTFM49x
	fZ8AUcWreTvxABfKS1WCwx1WZGp2kilNTQQVJH8UhZWEjCLilZIeg4BXT/lz9Njbtsv1EBINHSW
	qgFPsmS16nuy3ouY+d7cYBiNIGBInRIZcwL0s9FdJ7AI8hZc0FhIXqin6
X-Received: by 2002:ad4:5b87:0:b0:801:2595:d05d with SMTP id 6a1803df08f44-87de7138a5dmr193035446d6.3.1761565608825;
        Mon, 27 Oct 2025 04:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcow6r/0jMtGxR59KvnFS4Y/c0woofpjI9qJZXXjOHBNMXUDWc9LAIdY1pVDEfhj9Vve0PMw==
X-Received: by 2002:ad4:5b87:0:b0:801:2595:d05d with SMTP id 6a1803df08f44-87de7138a5dmr193035246d6.3.1761565608298;
        Mon, 27 Oct 2025 04:46:48 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8ceeaffasm671391966b.45.2025.10.27.04.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:46:47 -0700 (PDT)
Message-ID: <22ad48ac-e054-4f2f-a5a5-8047266ff4cc@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 12:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Modify USB controller nodes for USB on X1E80100
To: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>,
        Val Packett <val@packett.cool>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20251014022121.1850871-1-krishna.kurapati@oss.qualcomm.com>
 <d0c18094-7234-450d-bd9c-e9f545de31e2@packett.cool>
 <81367b57-f60c-48a6-8a59-7e160c312686@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <81367b57-f60c-48a6-8a59-7e160c312686@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XuP2_UHKMzoW_PbSAl-aME1WJg3jC3D9
X-Proofpoint-GUID: XuP2_UHKMzoW_PbSAl-aME1WJg3jC3D9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOSBTYWx0ZWRfX/1X0YozFUe9b
 BxYNqf/c5YpbMLA6c2Dw7yBPLBfwfBjMNDXuKxYTiDrM0kClKmMhvZ5llbP8uk+1ed1EdE5wsvx
 U55twtcod+jtOdzvPb4cZXLTyfpYY/uhSw0lg6w5CWSRQI4HCh0zNM1itE6ilrijCpBMGo0I/+G
 H/9VMz8MCv3wszqMas97pB+R5nlcke9fdb/r6JNcxIsUvWpDXYYOYbe1WLgJDdZw3EUk4wYwWNW
 /axRiO0nzsVqkFEkDzRxrpDjPsVw5qxBQpCYkdVablM+aeMEBU0XcnWYmYY+yArBvj+UWWSyzV7
 7lJzTfEhycC39RzYCqVBX/lvoFEC3U4umeyS+cN0TQ2A+6TY6fAeFO2wAFCZ6YZApJih8t71SSS
 sxAqLTVqTbQ7vnml+QQrl304Vo3Afg==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=68ff5ba9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pqnWh8UqMPAkMZ0kC3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270109

On 10/19/25 1:35 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 10/14/2025 2:30 PM, Val Packett wrote:
>> Hi,
>>
>> On 10/13/25 11:21 PM, Krishna Kurapati wrote:
>>> This series aims to flatten usb dt nodes and use latest bindings.
>>> While at it, fix a compile time warning on the HS only controller node.
>>>
>>> Tests done:
>>> 1. On CRD, verified host mode operation of the 3 exposed Type-C ports
>>> and enumeration of the Goodix fingerprint sensor on the multiport
>>> usb controller.
>>>
>>> 2. Modified the dr_mode to otg for the first 3 controllers and
>>> verified role switching and device mode operation on the 3 exposed
>>> Type-C ports.
>>>
>>> HS only controller was not tested on any platform.
>>
>> have you tested suspend-resume?
>>
>> The flattened dwc driver seems to break it for me on Latitude 7455, upon trying to resume the screen never comes back up and the system just reboots from zero in a couple seconds instead.
>>
>> I've looked at the code and I couldn't find the cause so far, but it is fine with the legacy driver and not fine with this one :(
>>
> 
> Hi Val,
> 
>  Thanks for reporting this. I did test runtime suspend resume on all 3 typec ports as mentioned. But I didn't check system suspend case.
> 
>  I will try to reproduce the issue, fix it and then resend the patches.

I can repro on the CRD..

It's the USB3_0 host that causes the issue

Removing the clk_bulk_disable_unprepare() call in dwc3_qcom_suspend()
helps..

Konrad

