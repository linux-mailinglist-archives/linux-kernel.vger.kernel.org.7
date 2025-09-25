Return-Path: <linux-kernel+bounces-832275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C01B9EC9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5277B24E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7482FF141;
	Thu, 25 Sep 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f1OAnUTZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A82EAB6E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797006; cv=none; b=B20tb64YKCl20TH6N6Id6dkCsARclEslYjOpM+0zwd/vW/Baiskb4faYalqSfK97c9l9+0ljOd6v4MHL7CRpe92TrQbNgsQGPZ1ckj6JcWQbGNe3O67pxvyR3rY+5JZdzkY5lqyhYxfcJjPrtXb1xVbRubM+U6xP5eV9M0YJf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797006; c=relaxed/simple;
	bh=3cn448J5AE0qbdAmfGCuMMOHudJWRnefXkxO54l3c3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kproH6KpCst5uSgeXC1oqM4opypU9KRVS+YvYykMTenIWh/88YfN9nt/AYUnHJ0zfx4jxciLjeBRZdtGg+Itk8kQtyi7QIVfLjQD7P/3g4z1welLF7qdwZ6BCAv1kN2VDtD2ik/LC0zWOdBQaULWe4iaylZEuyT4hnumlIW1pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f1OAnUTZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9SNN0018026
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LyNgLzLMWc1Mnqx+dRpZQ1k73x+Ofm4U0A3bsduzpwc=; b=f1OAnUTZA5xmOQeD
	4I9UfW6m5EmZd1fnOykAdpPsmr/Vy/G8wk+ChzR6yz8Xknu4zpaawsnJL+e9GkX+
	7lK8ggPsRfflffJvU4OM5U+KIyJmtdFmYsM2/rqoCE6zRDblUKPQAZ7YqW79jeYu
	FR7psXdcy3PEtrPH58841naMaSLKVkYjj8GZjwy4lzHnjNV2BdkxTwcX+uChkswL
	4bjOWKMwgbqKlgJFPuNapscqf0yjPpUvW13o33uqPzpze40aCUQQzbWj6/CUZUo+
	/iACCAkZDg6azDvoLri0cMdhI0MOcPOAMxHo883uaFLkNtp87n3W/sUZY7R649NT
	sXmIGg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkbrfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:43:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b3ca5e94d3so1046441cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758797003; x=1759401803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyNgLzLMWc1Mnqx+dRpZQ1k73x+Ofm4U0A3bsduzpwc=;
        b=t9NLX/JSRJgCJRLEOTpuqIDQvIlM/TkieysBAEl/Q+J6a/LjWRple6jrJcWBsRbmI8
         4MdQjMpTUjYRY+6rej1D6mqVJA4e3W6J/HKipOSk7q/Wn5X0nHmNeJVk0+QXSBMNuHVS
         07h31jAs6/j0OgAAywV4SfiJjIJWPBubVqhMU50hQREqMNegBiaXXCdCp9DZV3Nmntba
         CF2r/2grKxW5nEzPxIMH7qR7iUZD8ZZK3J+OJzWAigkzzRtnI7u6Sa6bgNo7kcmfBCpC
         U0DGlFd0lTJ9adeVYNv5K1WcAnQeQ/uYlM70KQEK+964BdQuLdg78Hd4RDJW0cU1O8jR
         6jTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9k0+CyWuaS689MpTXSGDmdViAlcacpCFx2/eh7KguCWt7cQvQJRRCvyq+w5LclspJj2/1ONNovUCjSTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9WtnZ44s5ZSvMTZNSGOYrezQZ3TcyNHd8MJ54tPofcmV3ceUk
	IOQqczzxBId7+F9u5Swf0dEIOdQvG+fb/nvPPfNWA7xjJPqZtVJymttvmWKQpL6YZjzsoxluc8Y
	GP/9qwbNZa1Wqdlnxzv+1X4flN6LxJYr6cLrDoF1erGOnG+g+oGfm2v87VA5YH6Qgb64=
X-Gm-Gg: ASbGncssgvUtsAsiHBZhobKftoY6nzVNbwOyCDuwHFR+Nq1pAnJtG99E7czBjALjRyq
	kJyyEgCTxXefgiD2f6tJVwUZ2bqFc9/5naqu+vQDq3ZbBYjeqTjIQ85QMrf1wPDVPvtsljLtRC1
	qRf2Jge+5I4M4GJGMfU6esbQrckgHFKjpDOGIwU1Tbkc3I0o+Jvbw2TVl/JEB1K8Ha2N9ipATMX
	69L85AkoFNT3OGD8ndpV9fXurmid2LkKALN+4rOsKEf2lEkavGm4bgKYIVGGjkTLU6OqQBMqYBk
	FbbjiN92EhCURYktc4WXJwq9aXq9E8NTa8L0/ua1w+cmGkLqVdogjWkhrsrTVx8CQX/zovpwhj5
	Pts9DRqoK7/J6Chq6c+1/CA==
X-Received: by 2002:ac8:5d08:0:b0:4d7:9039:2e87 with SMTP id d75a77b69052e-4da47c063ffmr26594271cf.1.1758797002849;
        Thu, 25 Sep 2025 03:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRYUaRRp+tX2H+EUDkPQlbMlY0IAUeEcDN/SEG0LxWyKM6rOpzeC8AZaqcyLUwx8dK85q7Pw==
X-Received: by 2002:ac8:5d08:0:b0:4d7:9039:2e87 with SMTP id d75a77b69052e-4da47c063ffmr26594041cf.1.1758797002219;
        Thu, 25 Sep 2025 03:43:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a364ffa4sm1010479a12.17.2025.09.25.03.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:43:21 -0700 (PDT)
Message-ID: <bc866f21-9b41-43dc-b450-59a25d547b88@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GX0tL7LOeLyc_pexXMyDNkRk_EYUfIxP
X-Proofpoint-ORIG-GUID: GX0tL7LOeLyc_pexXMyDNkRk_EYUfIxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX9sFkqOFLvYk6
 CSmLINe7Y/8ikoqUeyNLdN5AZz+rgWjdr4E1qBw5rr3GdjpCEixqSsP7HJy0EmouWWVdgpOOifx
 F6LEtJ1QJ3GJwY2rEyK7QuyTNKxntC+lABkRpzIzVLFHdGNLcKOEPLqOB2MuOO1IWfL2iTINi6d
 JmkFsh7Rx9VePt7Mn46IOwzxlW+M+cpYUHIb1oiIu5vs6VgaM/5wRm3TRLHR4n6Q03vzbce7IdG
 /GHeVcrZhn28/OCx1jsZ7ir8J16oA9ghvqeNp8zWbPLr4BzwVveE7buRbP+U5T6BXQbjNn2oGfw
 bUvMBhi2EtK3LixV4nv3vn2Cpp0ZRbyO+R4ocWXQM/aW8sMWp8OdblPLf1H3pol13ZbbLNtAfM+
 71Xbnx/e
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d51ccb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=O8mQQSza-jboQJHTzfMA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/25/25 4:28 AM, Wesley Cheng wrote:
> For SuperSpeed USB to work properly, there is a set of HW settings that
> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
> these settings follow the latest settings mentioned in the HW programming
> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
> new ways to define certain registers, such as the replacement of TXA/RXA
> and TXB/RXB register sets.  This was replaced with the LALB register set.

[...]

> +	/* override hardware control for reset of qmp phy */
> +	if (pcs_aon && cfg->regs[QPHY_AON_TOGGLE_ENABLE])
> +		qphy_clrbits(pcs_aon, cfg->regs[QPHY_AON_TOGGLE_ENABLE], 0x1);

Clearing this field is going to prevent the PHY from ever going offline

The HPG says this should only be necessary for keeping the phy active
during MX retention (and the listed usecases are USB4 wakeup clock
generation via a respective _USB4 register and/or USB3 autonomous mode
operation), both of which are currently unsupported.

Are you sure it's necessary / desired?

Konrad

