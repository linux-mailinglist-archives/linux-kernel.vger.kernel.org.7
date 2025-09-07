Return-Path: <linux-kernel+bounces-804769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93ABB47CCC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE618897D8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C4298CC0;
	Sun,  7 Sep 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWS82qrt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927427726
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269032; cv=none; b=EYMdgnXmeg1UROOtegX7M0inViwL20YSMeJjaadHpjFUN/6HDIG7xvDE3raZl2sV03P203Rw8o4cZ6dJhjDzXNPcaRU225Dw/eVGesrJ1q5/Lrn01ivBIcIlg/HxEbnufB1t/FG2KgViOTwkC7npk/vZPPswUPMN7/IRbFS40VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269032; c=relaxed/simple;
	bh=vbtHhub+1RRGhMNNKtSKz9O92ySy744nqXoeDGy6E0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aplXcoBWB/Re8BuwmCXV1jLpSJ4QN7/7HKHhWJrOVeuQCDmca1Bli4jUl+33LtQiTWwiBkHI8Yro1KusgTwZm89/7OJWpYdMVO+zwGXA6P7zzno8RUwYBSFuXjurIHo69YJPGSJNSX9ApTrG390ZQtjB0g2dmIA1NxuB6JWDZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWS82qrt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587CuheG001450
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 18:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NDLERyrBM5HRP4ILzHp+zzgB071aFZ7GTm70hkKh5g=; b=NWS82qrtJeFA2HPZ
	bQD1rQzv+UQMNujdqQz7JYBC2dVeCb4dnnOLsJNy3lBffbGa4rm90D022Jo8zLb3
	Ets4DlqqkIZMpPCTlk2bWzQZfJxE5PyokQ+JVugUKL6ZIdsq9QI1yoQGiEYgPV20
	wsfHjhpxfU/K7cXdPKiccxjJgdoGWEEHN56bwFY2Ke8Jxzrhqvo2/ExrMwc1Hgjm
	pfatx95jPfSztrgYotH+dG+q3OfSmX3HjuH8/KjyWZw2eUlA+WhWhu1Q5P8hynny
	n10KL+pArN+yxmk1NkHDStt2BP+sw8mzPKjKDAZ/+kAZmMi/UdF4pJA72gwa/5ld
	4BJ5yQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vaetu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:17:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b52358ededbso148907a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757269028; x=1757873828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NDLERyrBM5HRP4ILzHp+zzgB071aFZ7GTm70hkKh5g=;
        b=oe98Divs9G4Ia/NVzisk3x3AkM2Fp39+ZmUYxzp1cooMqXtkCjf+tjMlU85oY14LY1
         SNAAq9Rgvs66KM0TsvLxOv+pcNK/tdUkK/w7HEbUclD/DN07KIqXmQjDnMBsSsW/Vg8E
         uVYFDV9E2Vkj0XNLxkySUuJl7+WLJXNMpJOiNAiu41neSn4msP4iqpUhz7TsdRVgTxL9
         /lEG2LgXE6vN41MnJ7tUGXco4MHDeXzoHgzt2SPOmBpt46pcXkk9FWweaydeWY7Myk9Y
         f2kRJpN3/vGyaaIKBk61ohgIK1MyBrkSCySnV8IvPVhLdLn461w8kl/piscK4lsB4wzO
         9v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX27pCdkdTt7O0qAJzVpAPxIERJa63JrVorgUbNiPe6+Hw1ff/jNrN463fGY+gezAQX+RREbAtSuRCyMU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/7Jjkg9jEgB9BuLfbPSc+y7/XnXzbLTjrb/iKdSWQrkYwEUV
	MweodOo8hkzu+l3ymECx2EEizsLPAaKkGq2Emo954Jodl1yowfjmMRD7Q9DioZky1uyKnhO9O42
	i4+BCKMQok3UtrTdjN2MNYJIwXk5/serFTA9lvNXVz4i7ZgQ0NZIEZ5oeHJNCaEOGwmw=
X-Gm-Gg: ASbGnctX9UkIbup3Hsn37ZWMgQ0qQdJP44RU7N/oS3nIj/XM/MorqvGcA9Er4Gss7Ud
	N6CXpcTgUReT5BupykR2ej0OlUeRkcG1hyCHHGNYk6lAWA1nvnuhiCHlMRF/DFVA0ovMU6w+pgu
	l2m+sRw05kEb1SiDVNd+ruWtxt961VmUndgJkzj6SOb1dK+RB1xBjzdkpx2d0g/n8BNBMkVivM1
	c1Dmgt9QqJUVZl8ZYCKMbiseHR0HJWCmNThqe361DaoE0BfsvWKHLzLlOFErccay9Mg/2KnneX5
	l9d5aFJtWhLBXgjS9B2Qcy2pqvIkoC+/BUX8tP+MWdori1emINd9C+c195Oh2s475CQA36ByFed
	h
X-Received: by 2002:a05:6a21:339e:b0:243:b965:1bb7 with SMTP id adf61e73a8af0-24e84106fbfmr14045677637.19.1757269028064;
        Sun, 07 Sep 2025 11:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmiwifL76sqQbEY3LiDyw2AeOOQnvkn/QsnsWQJ9UZt7VhCP2Z+H4cEozEV8K5eMihsIvelQ==
X-Received: by 2002:a05:6a21:339e:b0:243:b965:1bb7 with SMTP id adf61e73a8af0-24e84106fbfmr14045655637.19.1757269027564;
        Sun, 07 Sep 2025 11:17:07 -0700 (PDT)
Received: from [192.168.1.5] ([110.226.157.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd3096d1esm24027224a12.45.2025.09.07.11.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 11:17:07 -0700 (PDT)
Message-ID: <44378e83-b8e0-4bfa-a127-aafb0a12d798@oss.qualcomm.com>
Date: Sun, 7 Sep 2025 23:47:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] usb: dwc3: Modify role-switching QC drd usb
 controllers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
 <8629515f-5b2b-4e97-a998-05cd6eaa47cf@oss.qualcomm.com>
 <2025090734-plentiful-untracked-b7ab@gregkh>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <2025090734-plentiful-untracked-b7ab@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PIx26-VWw1d8d9FltbOg651gmCnSxrpa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfX2Yg/9SPyBk7e
 mUoJiWn+RDVL9/+D3Lj0rdQhNYsV/wLt3G5TQXl0vTIh9eHxJ+5v1e4gEMxhBgX4Zj/s2Pu2O23
 APeBvYttVKlUXpu6/Fl01Eu13GpblsmD/kTYPpKxZOsJ4SSN6aBohx5l0OfHaIMDALhAGfYwzdQ
 KHpWkvfWpKNbqBV/jBgp99MxJgoKpPajjGYItx1jHxs8m6VBV/eKEb8EGzHAKTt89dSaC8hjwmf
 ep7n8GCjDmrNY4TpHP7c4WHMUGd5BKBXhP9WDfy0ZCtd1m6xa+zElYgqdV1sJIt4G5ab8Wut5vP
 5iZzZv7p+FdYNHNehKwnCHwYb6rl9fYks9wL/uZyPEpn1BHq5h6i7FeJS8HO/KQHr6QYAAYPGnB
 5m1OzFxp
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68bdcc25 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=QqF/YZBt/wu8DCr+JvV0/w==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CGVWhDeSmqJaDp1pI4kA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: PIx26-VWw1d8d9FltbOg651gmCnSxrpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027



On 9/7/2025 1:41 PM, Greg Kroah-Hartman wrote:
> On Sun, Sep 07, 2025 at 01:18:51PM +0530, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 8/12/2025 11:25 AM, Krishna Kurapati wrote:
>>> Currently on QC targets, the conndone/disconnect events in device mode are
>>> generated by controller when software writes to QSCRATCH registers in qcom
>>> glue layer rather than the vbus line being routed to dwc3 core IP for it
>>> to recognize and generate these events. We need to set UTMI_OTG_VBUS_VALID
>>> bit of QSCRATCH_HS_PHY_CTRL register to generate a connection done event
>>> and clear it to generate a disconnect event during cable removal or mode
>>> switch is done
>>>
>>> When the disconnect is not generated upon cable removal, the "connected"
>>> flag of dwc3 is left marked as "true" and it blocks suspend routines and
>>> for that to happen upon cable removal, the cable disconnect notification
>>> from usb_role_switch to DWC3 core driver needs to reach DWC3 Qualcomm glue
>>> driver for it generate the event.
>>>
>>> Currently, the way DWC3 core and Qualcomm glue driver is designed, there
>>> is no mechanism through which the DWC3 core can notify the Qualcomm glue
>>> layer of any role changes which it receives from usb_role_switch. To
>>> register these glue callbacks at probe time, for enabling core to notify
>>> glue layer, the legacy Qualcomm driver has no way to find out when the
>>> child driver probe was successful since it does not check for the same
>>> during of_platform_populate.
>>>
>>> For flattened implementation of the glue driver, register callbacks for
>>> core to invoke and notify glue layer of role switch notifications.
>>>
>>> Set-Role and Run_stop notifier callbacks have been added to inform glue
>>> of changes in role and any modifications UDC might be performing on the
>>> controller. These callbacks allow us to modify qscratch accordingly and
>>> generate disconnect/connect events to facilitate suspend entry and proper
>>> enumeration.
>>>
>>> The series only allows autosuspend to be used but still relies on user
>>> enabling it from userspace (echo auto > a600000.usb/power/control).
>>>
>>
>> [...]
>>
>> Hi Greg,
>>
>>   The first two patches of this series are Acked and are independent of the
>> third patch. The first two patches include glue callbacks and suspend resume
>> for device mode for QC SoCs. The third patch is to enable auto-suspend for
>> xhci plat and hence independent of dwc3 patches.
>>
>>   If it is fine, can you take in the first two patches and I will resend the
>> third one if necessary after receiving review comments from Mathias.
> 
> Can you resend just the first two, as taking patches from a longer
> series is "hard" for my workflow, AND this series is not in my "to
> review" queue anymore due to the other comments on the patches that you
> don't want applied yet.
> 

Hi Greg,

  Thank you.

  Sent v5 [1] with just the acked patches. Will send the last patch 
later after it gets review comments.

[1]: 
https://lore.kernel.org/all/20250907181412.2174616-1-krishna.kurapati@oss.qualcomm.com/

Regards,
Krishna,

