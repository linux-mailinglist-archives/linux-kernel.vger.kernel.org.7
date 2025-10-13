Return-Path: <linux-kernel+bounces-849861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B885DBD11CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 784224E842D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBE264A8D;
	Mon, 13 Oct 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+UnEtxV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB434BA2B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320203; cv=none; b=aFDzVxN65vC3tq0UXz/FXCUppHeb978wAgj5JlUzu5M8zw9eCSJWTZED3Vj+UgjirAGHANduBvohQn2QwZHPIgGhrMj+gg9TX+5LEYnfhqFKXZmrMXmp41v3ZU6KcsiY6oTTIwaHfeJUYtiPrHKKA6y4FrnlvudAU70uda4mU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320203; c=relaxed/simple;
	bh=X4yqur+K0OFZ5UaCDYG6T7PEn8PzYW8RtOpRjG9eK78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq3LwXA3hP1+dT3pEM5ZZs+gG0HcCv6PbAqiOlk4n7Q9XBWTj8zDsMZ2MRSrmxMVSFxrOkZNfuntmZtYT0UXvcF+sRmbajzijWb1MwyrC2UEw2O1jQrqcoG17Pusmq9WTKLHYAijJ63NOPOQl3MK6jm22m5yWj2WIH5V/tThkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+UnEtxV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CMsksG010262
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nvhwqw+s5IRG5JJ9BC7K6h40VgHBm6MIFrG9gT1FsX4=; b=L+UnEtxVViFXXNyF
	LcL/vPe7PnmF86Ut4u6u+JjNaoY7cnV9LsCLKM1EgW3t1H0rCKJjxeL3wPb2JbqW
	WUNN+lV5gKCePVUmjZsl8nyc7EWq8vGyWCJXLTSwldxjQZwZg5VwW1Se72GQsWWu
	84vMbT1J1dR3dnl3fSn+rzlNeoIyRkDWi4cJkXPBvlbDoI8p7Q94kLIzan9v/efX
	sThxEzH4XDKvti/btHc3yYHToBBlXdmiC08yY/kXgz2WAZmbGJ4RtE4IR2NPKTw4
	guSiBefoQfynC+qLiBFtHiFF7ybQIjGJFm38NrYzwsoRjAMCjWM23ALAPsuZNtxF
	FofrxA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfby2wtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:50:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b60992e3b27so7385378a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320199; x=1760924999;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvhwqw+s5IRG5JJ9BC7K6h40VgHBm6MIFrG9gT1FsX4=;
        b=mb/mivyovQHhHZafiyCTvI4PszMSn6OI4M4cAXiUpUUXiilzJCcXOKJY+FtqUHbgRu
         l1y/MoB8A9ueVd/ng35R2tN126beG2Q2miYvaHFutQh71ML5+s/XTWOajcmYcMqze8wt
         4G01Uabth/kweV1UMYdAp3ViXXm49mKHbfBG2OmFcr74XZMSdZkcyExVKawNW45Wu3ud
         mh3w//eym431jtNn9gVeBIvjibb7NmyfRwNY5ieTo26CZShP5R9/bv3lfI93R5q8hqRJ
         T0iNvXU2e5UB4+TVu7yB233dnDeugJgiJ/DZSb889T8nDQywEgg5iKQnEWzLWeOHw5Zs
         NUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUA0koWL74JnLDDhFyplr/JZk0xE/lJ+J8fzZhG7kJhQwqgU8pHuzbhC09iA040yVzyCH9KVhwVuBI+Yi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5NG0+9HqwBSHnIxFqk5dqs/bGlI0LiEhQpJSePYG7amchv+X
	nON3NE21pUn0ZslqXK8Z3kCQXhmalHgRBOwrGBet6rW1zvbgKFq3JhnZAV5wQf8GMtByrtchMgk
	/UAsH+Aa7qHgW+JDxavjfjJ66xBmb4nd0BSrNd0K+P9zHnivXX6fM7cXzA4ad3jLi0aA=
X-Gm-Gg: ASbGncskvsoeyz1lRaXVm2Vq9wswvfgGeRtqms75vc0sDGS/AQdJyOWfFDejoUA696y
	CQyOxFSRQdzjSZKDXssmuv5ROcBPVm+9cT1PAHRiZ2PEEMynX7aZYLeJ6Lv1FB9W+3eBt5ZvTsz
	N/FsMz9sURvpSnMISlfSrVLFuyr4cKvAndtKYbpNgoIpkAzhEB5FKI8keKMUpbriIk89Sf0sxY6
	6X3h5HLC/BBNJu+7YOUggtRiPXfKxZa6nWE1iajzxTUTN7HaYKa3+uysu8gYTUlMUkupsFehf8R
	dwp57uAy35C3OK/h1A6s65PSYxE+HyBwWo/zhE+mYbxiSX2u6zZpF18RQX789OKtV/S6Oa/4cJ7
	e9hq7MyY9v4CNYbFxLLHH1bMmh6o5feYzq8CR
X-Received: by 2002:a05:6a20:7495:b0:2ae:fefc:feaf with SMTP id adf61e73a8af0-32da80bc78bmr26585549637.12.1760320199128;
        Sun, 12 Oct 2025 18:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNCl7StGWHFovArAL04kybTSuSFjARFdVOyCDRbeQYmRMBIohUKytVShRx9q0caXT0U2r/iw==
X-Received: by 2002:a05:6a20:7495:b0:2ae:fefc:feaf with SMTP id adf61e73a8af0-32da80bc78bmr26585526637.12.1760320198662;
        Sun, 12 Oct 2025 18:49:58 -0700 (PDT)
Received: from [10.133.33.61] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dc86a93sm9635684b3a.75.2025.10.12.18.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 18:49:58 -0700 (PDT)
Message-ID: <aa30f484-7269-4fb9-bdd2-8b7ab75061a9@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 09:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff: firmware
 crashed!
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        jamie@stimulussoft.com
References: <5aa2dae4-94ba-45cb-b138-bb40c89a85eb@molgen.mpg.de>
 <486e9f27-3b03-4317-a1fc-1bd92235db1c@molgen.mpg.de>
 <90a764d0-c230-43bb-b7e5-189544839f8d@quicinc.com>
 <e2e58098-4589-4ae4-bc38-6b009823b071@molgen.mpg.de>
 <82b9e966-5e12-4a13-98d4-0ffa88505f97@molgen.mpg.de>
 <d8145c41-1e61-454f-a343-be0a7239e36e@molgen.mpg.de>
 <8354f613-692e-4f6b-933c-3434a5ae90b2@oss.qualcomm.com>
 <e02b3b8b-78a3-41c7-864e-caba6f1a8c0b@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e02b3b8b-78a3-41c7-864e-caba6f1a8c0b@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX5Y5P2Ei6Oq7n
 jlEGW/rogk2nLiSQv0O0DNYNDdUGgZT5l8/xqjgsu4EmrA/mUvibeS9ezMz4ec0k7Ifg23uJo9y
 +9Ub+ZjR/yO4gQlnVGYXB9nqCwG55vtEYPsJN3dyzPOAUM5+ZHWsemV1jxakM5lYS6LBKhJ3Vjg
 IPkJZdXBpLOH3o/PQAdTqYVShhcD2lGsWLYGIjSHSdQogiv+ORjK5pbEKqXpXPwCigTFosDUNqE
 wCnRf5vc9rjS2C3k2fIELrAyrpWzdXNZIklKOc5djUO2UruUy2WfGFuH4JbL3Mlh/CyU79kngSl
 aT3CmUKvFjpKLX5l77rye44f3ERyEk5Arrbkiu39xLC5h1AyTzjCQ7NjnjnVZ8kDd9kgF+0gWf6
 lxXlBehkStD+7MIfWliIYQVA2RC56g==
X-Proofpoint-GUID: VdTRIktLp2pffg2Gdfyxc2e0-imDB3eh
X-Proofpoint-ORIG-GUID: VdTRIktLp2pffg2Gdfyxc2e0-imDB3eh
X-Authority-Analysis: v=2.4 cv=A+Bh/qWG c=1 sm=1 tr=0 ts=68ec5ac8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=UCfQCeL7Kw1fo_lLQ5AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/10/2025 9:12 PM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Am 21.07.25 um 05:21 schrieb Baochen Qiang:
> 
>> On 7/20/2025 4:43 PM, Paul Menzel wrote:
> 
>>> Am 14.05.25 um 10:08 schrieb Paul Menzel:
> 
> […]
> 
>>>> Were you or the firmware team able to pinpoint the problem, and
>>>> come up with a fix? Is there any logging I can enable to help
>>>> with debugging?
>>>
>>> It also happens with a Telekom Speedport Smart 3 (Arcadyan
>>> Corporation) router. The firmware crashed five more times since
>>> June. A reliable Wi-Fi connection would be really appreciated.
>>> Could you send me a debug firmware, so the firmware developers
>>> have it easier to fix it?
>>
>> Paul, we are working on getting legal approval on collecting
>> necessary information, such as firmware dump etc, from community.
>> Once done we will share guides to collect them to debug further.
> 
> I just wanted to know, if there was a conclusion yet.
> 

unfortunately, not yet

> 
> Kind regards,
> 
> Paul
> 
> 
> PS: I set debug_mask to 0xffffffff a while back, and it logged so much, that my old boot
> logs are gone from the systemd journal now. ;-)
> 
>     echo 0xffffffff | sudo tee /sys/module/ath10k_core/parameters/debug_mask
> 
> Any hint on what to set, when the crashes happen?

to collect core dump, you need to load ath10k with coredump_mask = 0x7

	modprobe ath10k coredump_mask = 0x7
	modprobe ath10k_pci

