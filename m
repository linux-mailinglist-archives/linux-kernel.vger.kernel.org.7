Return-Path: <linux-kernel+bounces-804552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D968B47972
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357093BDF80
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705491F09B6;
	Sun,  7 Sep 2025 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DK7c1+/D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F71DE4CA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757231342; cv=none; b=CoU/Flksl+1r+Rdg+hiOhUZ3/xDAYwToPbAJBI+GpD62MLeodiklKaE5WIay9rgXNg5ROJHecjcxKF3nUd9wHLPr3MDc12+hldIVqPwSzAEB7p+QGaKlbmcIN2tfDA2r5lGx2fThOEa4fIGUp3J3Omhv1lrBaVGP2sf6Q4rsEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757231342; c=relaxed/simple;
	bh=nxI40rlnam6HbzAHjZd8YIVn/eK8GG2pX7sF1gqOIbo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gf+5KB77mheylzH7SYu5tKdZ5BLgZHP5L6+4jrqN5Su7AC0XbhvQLq1xahr7dyiAHo431pKrm3pDd1k3uJJpIq3QrIFBcbeOUvjhO3n5YK6imVH/lAN7U9B1aZNE7VSsAy2c53yBXJIbN1hrtRIk3G6Hl70qkRmJLVH+4uXg1TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DK7c1+/D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58759q0u004335
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 07:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tM8Kn4n614wQg2YKxsv53ibFCudlxkku7IMM847nKlU=; b=DK7c1+/D9+PSj2k4
	/lcvCOHJ+x/bwgv0WhPEluhBwIgVkbxltkJsrNjOo1ZuGFiPF/n9FoP3bn8YzpUM
	EEDksaaavPA0yWNEsjZEpZUaOrgH76BWysahVZgRsJYlA5ew6R3myREy0l/eSJid
	jOmLX93y9hrrqYqRiKRP/vaTiiyxTS0ZlwSeLPei9TpmKqe6CBsy79cUHGCsO0U4
	HhJ+leCvJo5buKj9oTtV/9Bz5RLMFFimLIUlwWbDvPMkbC+fSn3DWTSBaJKz+vN6
	YKz3VuE+PLBdnSRuWNJFjVWd1rWS9BM8vS32hMSUxc2mvevn9NvqIf4aGCYtG6u8
	2Jqg9w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapa12t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 07:48:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso3669209b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 00:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757231338; x=1757836138;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tM8Kn4n614wQg2YKxsv53ibFCudlxkku7IMM847nKlU=;
        b=eMPHa3f7hkLpDJg5DhFyHCJf/DTZhJUfJfszBd1XxyXEaLz5aJaMUniFZZkKSDOyvB
         cmxXOHCptB9FQdDNNFJ3Fxk5DbkdWVyADpba0LDeNSslTPs3/ULgSIw7bq+wsn6RYfxI
         +vs0xXYQtdORgLnSPH1x3pU33fvxEhhZy+0VWomoTNCeKr02BeFAzHYECkP36K2y4nGi
         PGPEOgr5w3d9aH3l/CvUbkWMGZK/PUNrITz42xr3aceQY2oJfxvQ/GswI3Kl4YAM1hP3
         PM2iCI7fKy50xqATYXcsn9TlgKfrNriG1B+WUZe7U/kTX2mXyvdjfBH58u6ULU2npCVC
         g5/w==
X-Forwarded-Encrypted: i=1; AJvYcCUUVaB9kQ9q3/m2XAecOE1TBLRclAsxzf3MoQTpZRDM78bMqai/eh5EVn0cBaw0ZlMNgINqWECT4Kl04VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYoxEa8zpbmwkDbMUwDejYZMssQSB+VjP9d6+4MEx9d2ZBZLTT
	h+1YXkdI57tKDJWOeGenAiT11TtGeQFabYkcPPhpmTkzQjJ7ldORYWwULU5LpOoKxjnelHVrXu7
	ll5FBnp4GWSpcMYv/Bq/iWIWHZx+IP3r9JB5VIPid9oKnP01MmgimVOsY2/DUWoZeXws=
X-Gm-Gg: ASbGncusxFMuOQRPkYzij5ZLBRIB5winNAS4UPO+0Z4CBsDlW8TQYoAEjORFdwiGVBr
	zJgLNQjkjVDryOiOJB91cFgNzQ9RlW9Lz+kKjS6TncWtMCULPTDKUZqymxZch0Ac8z3BccUitmp
	gdvNQlL9KNccqC0fWQcSxvJSQ48KBpaEd0vfoS/J7pdgKj12ymtOaLu9VMZyObMiphAq2J2X8bI
	t1Ew9KN6QflMhjVVyCfW8A15iKgR/VQo/uG+jPXzXMiCD3MlEPnXyk6t2pD8BaJKHUZE+wrEar2
	f0nYEnYcx+X9k0VYIZKMHZO6sBs6LA5XEMYZg5Qq4DiWzCow4tK1cYo0sIpf8mE5zhEtE/S8QQg
	=
X-Received: by 2002:a05:6a00:2d11:b0:772:4226:13b2 with SMTP id d2e1a72fcca58-7742de3d197mr5598435b3a.25.1757231338219;
        Sun, 07 Sep 2025 00:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagOn8roHxtiWoCLKvTeJK51NmNBIuqt3cUlMv9RNn3RUZKAgW+Y+9pJ8HpJ+lhrArADzsRQ==
X-Received: by 2002:a05:6a00:2d11:b0:772:4226:13b2 with SMTP id d2e1a72fcca58-7742de3d197mr5598407b3a.25.1757231337644;
        Sun, 07 Sep 2025 00:48:57 -0700 (PDT)
Received: from [192.168.1.5] ([171.61.218.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726a3fbb32sm16223639b3a.53.2025.09.07.00.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 00:48:57 -0700 (PDT)
Message-ID: <8629515f-5b2b-4e97-a998-05cd6eaa47cf@oss.qualcomm.com>
Date: Sun, 7 Sep 2025 13:18:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] usb: dwc3: Modify role-switching QC drd usb
 controllers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bd38eb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=s7TrmFAphNST82y/Lp2JMw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=W4KyHXEzquRlCSQaOQEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GXfETeUDQdDqP1ek5GH57ZYRMZesWH9f
X-Proofpoint-ORIG-GUID: GXfETeUDQdDqP1ek5GH57ZYRMZesWH9f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX4C6+11FGE1qa
 MkwpDDPevFbM4W/IZ05ewcxQCvNDh/y2xu71YgGPKKG53DtKR65SBlkDq9J071Ilrre1C0w0Oii
 uddT4FLxRBJfssuednly0YfV58M8fMk8Hr/kpXaTPko/kRk+nhBsWxG61KYgoMW4QOtMA+8pdqh
 vzwNPDmJiEiTGH0ZPVAAYtjMAJxfc5c9egsM9cZRXNSAF9uEjaUjtaVbEZVSmkSOcG1Nb1Ti+wc
 WD64iT3MBE8lSIJP6VTMtW8teQTAvY7q4JHHNyGMphHiCanJexHXxxx30dgMImfmw9qP4B8iikd
 AqF2aJVL0v5/B2yVd5422ReiFdstpPtEUjZpiq+t+hJUyFem0sBUDa1t84HJDl2GMMkcYB2RcYN
 uoL6sXVA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000



On 8/12/2025 11:25 AM, Krishna Kurapati wrote:
> Currently on QC targets, the conndone/disconnect events in device mode are
> generated by controller when software writes to QSCRATCH registers in qcom
> glue layer rather than the vbus line being routed to dwc3 core IP for it
> to recognize and generate these events. We need to set UTMI_OTG_VBUS_VALID
> bit of QSCRATCH_HS_PHY_CTRL register to generate a connection done event
> and clear it to generate a disconnect event during cable removal or mode
> switch is done
> 
> When the disconnect is not generated upon cable removal, the "connected"
> flag of dwc3 is left marked as "true" and it blocks suspend routines and
> for that to happen upon cable removal, the cable disconnect notification
> from usb_role_switch to DWC3 core driver needs to reach DWC3 Qualcomm glue
> driver for it generate the event.
> 
> Currently, the way DWC3 core and Qualcomm glue driver is designed, there
> is no mechanism through which the DWC3 core can notify the Qualcomm glue
> layer of any role changes which it receives from usb_role_switch. To
> register these glue callbacks at probe time, for enabling core to notify
> glue layer, the legacy Qualcomm driver has no way to find out when the
> child driver probe was successful since it does not check for the same
> during of_platform_populate.
> 
> For flattened implementation of the glue driver, register callbacks for
> core to invoke and notify glue layer of role switch notifications.
> 
> Set-Role and Run_stop notifier callbacks have been added to inform glue
> of changes in role and any modifications UDC might be performing on the
> controller. These callbacks allow us to modify qscratch accordingly and
> generate disconnect/connect events to facilitate suspend entry and proper
> enumeration.
> 
> The series only allows autosuspend to be used but still relies on user
> enabling it from userspace (echo auto > a600000.usb/power/control).
> 

[...]

Hi Greg,

  The first two patches of this series are Acked and are independent of 
the third patch. The first two patches include glue callbacks and 
suspend resume for device mode for QC SoCs. The third patch is to enable 
auto-suspend for xhci plat and hence independent of dwc3 patches.

  If it is fine, can you take in the first two patches and I will resend 
the third one if necessary after receiving review comments from Mathias.

Regards,
Krishna,

> Changes in v4:
> Fixed function names in comments in core.h (Thinh).
> Fixed nitpicks in dwc3-qcom mentioned by Konrad.
> 
> Link to v3:
> https://lore.kernel.org/all/20250806095828.1582917-1-krishna.kurapati@oss.qualcomm.com/
> 
> Changes in v3:
> Removal of extcon functionality has been moved out of this series.
> Addressed coding style comments from Thinh.
> Instead of adding notifier and enabling autosuspend for xhci, it has been
> done in xhci-plat.c
> 
> Link to v2:
> https://lore.kernel.org/all/20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com/
> 
> Changes in v2:
> Rebased on top of usb-next.
> Removed glue's extcon handling and made use of in-core handling.
> 
> Link to v1:
> https://lore.kernel.org/all/20231017131851.8299-1-quic_kriskura@quicinc.com/
> 
> 
> Krishna Kurapati (3):
>    usb: dwc3: core: Introduce glue callbacks for flattened
>      implementations
>    usb: dwc3: qcom: Implement glue callbacks to facilitate runtime
>      suspend
>    usb: xhci: plat: Facilitate using autosuspend for xhci plat devices
> 
>   drivers/usb/dwc3/core.c      |  1 +
>   drivers/usb/dwc3/core.h      | 26 ++++++++++++
>   drivers/usb/dwc3/drd.c       |  1 +
>   drivers/usb/dwc3/dwc3-qcom.c | 78 +++++++++++++++++++++++++++++++-----
>   drivers/usb/dwc3/gadget.c    |  1 +
>   drivers/usb/host/xhci-plat.c |  1 +
>   6 files changed, 98 insertions(+), 10 deletions(-)
> 


