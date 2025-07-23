Return-Path: <linux-kernel+bounces-742505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FFFB0F28F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53724547E82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11C2E7160;
	Wed, 23 Jul 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDinBmuR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD226E712
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275075; cv=none; b=aaVIeSQsjqbm+sz/g7UkcAvZior+/Kt+Y8dvsoS3Moi23ys3dlL41+9+iqGy5YDNY+fVFjcIy+Uuhr0D/isZ4QhERHRqQDKCzM+AHv3pXeKUDaKfqcHLUlfSr8C1mLV4aLTz+rh7WQWjbywKt6Tnaw+M0jZ/TvuYfppLGCPTNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275075; c=relaxed/simple;
	bh=irsV9FvgKnX6e/zN2HFo2i6k5xtyMkY6IvJrcT1VaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSIPy2hX4REsDlm5eDKPkxbc1V/0EIlsIgVdPIJwnrHN/ALkfihPUwlHnZjnMQ/yBX4vcO7sSf0bLy/x7uoDwVbvcpzWm3JjX39PRx6V9QjMm0+1rfnPw6tYKKLQPEzwOQPFINzHahYmnUTV1i4LxKQmU1a0OSKVdAuwGWTtIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDinBmuR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9PBsg013172
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NlfFWNr1gSSRPt5bMOhvfRkXF20NFj8tEIaK0raN8ek=; b=dDinBmuRNisA5rNB
	XgMKeEw5GdSGxEr4JXPZufn/J56dDaC09T/WtKAaClRF9MIJVU9pGxwZuLw7qHx8
	ZHLt3VK82SfyOBmrni0/ZizBueHvWbOPK67NJPIb/wgWIM6PgbSEVNcKwHg8Ikk7
	X0MaPDkHZS9LX66AAOmfl+TpmevMdaBDmzpthHF1Av8FOMnI7D2Pu+1n7yQYwas9
	y7jXcP05ZuBw8oP5YEAt1GTBjcNn9iC3jIGuTmMLhiX+fXqgdYzNaeMo3pTiH7G1
	Qrgpxn8ZxlvYFTzU2WHOSnM25vW4DlvjUgFYhULGw4XAbkeLinLKbLv5Xa79p0gA
	US7m4A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hu68u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:51:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e33e133f42so32419885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275070; x=1753879870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlfFWNr1gSSRPt5bMOhvfRkXF20NFj8tEIaK0raN8ek=;
        b=NLfPAm4nCOgv7Odxvh8T98vZd/h2tE5j+4LjkOSmJCmhBdadSueMKe6aHwd3V2D/vW
         QGyNUIzHh+i5WR5PcpY7BGtD5D2fvnxMJoxW0HQy8DRpUSiooHduFtp54vH4O5MvxTdb
         1PoaWuFKexj/0EEAV6VfYDueP3FInSqACUOEcLWv8lo8PpQuQYeBULJiQaEhmR7RVFzc
         Z2+s6y8kOXd3jeFs1nNceOHQ/WGq+fnu5kKxYxNCnCH48H9dqoFJq9yDCwEnN00/3IAn
         lcXg40u+W9CWlsI23t5Au/MMCRMYLvy8qpEgkugXqMwmGQWrfGu5YLikwqhQgHeOfSJP
         ESAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH6+Uv1x+98d3sk/nuwNgberGC0WzzE/e0hsWqOJ5UEKTeQMwHl+Ti6iXd+J9g52UkSJaCFbjEJxb7Bqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrn6fwTb+h3xH0RNdCCOFYSnUVkQmbxoDCOfyMfKaFn/QSQoR8
	SZEv/gnIMd2Lr+Rorr86oYTdr3gz9ESJKvphyYJk3xpVtqw8OoOIMBd5tNooixneL6J1DVetgik
	uk5T3967Ot2RCO78onZNMyuTVd57ERVYRp8GZ/22KoixeiyvykCAax2QpNUW45wsPL974HX9oyr
	Q=
X-Gm-Gg: ASbGncteUsKjkSrPOv5eITZPZeNAGWSsvxgws2ur0qIMhx7YmEa1PvQcZ02BUWkvd9t
	wGY3INWifbAR7BbUako/whEo8waa7E3biGg+QVuGUdoan2j2trWJBeSr7Y8OAn6HNoH5CDKgbOp
	OVtU9wH4YafsnMAhDtOIE6JpnoYzMLQ7rFsYOjzNUX8k6qFKermFE6GpcBdXGb7wEjt9Ra8hkg8
	6Uo99JA1DPKMbO0WiPGS9SA9SgSkWbNNS3wt/yr05leJ4ymwVZ1tqEQ6UKFMQOLWF4giB6agYgd
	0VDNYX8wyUHvAR+g7/HEjy/iXc+PItNNL+Qs/OBgEbSV9Muv6AZSqK1nbdJh3RhZvp5VE9RBqbx
	GG3Wjo0auWob+RA0p2g==
X-Received: by 2002:a05:6214:c2f:b0:706:c5eb:9b5e with SMTP id 6a1803df08f44-70700638cb8mr17930276d6.7.1753275069685;
        Wed, 23 Jul 2025 05:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5cFZGvvUDm1Gyr3QcLnUy4HpdRyf2Pph18NiIjxKW/XL6y8cizNodgiBEKYQU+iXlSkj/wQ==
X-Received: by 2002:a05:6214:c2f:b0:706:c5eb:9b5e with SMTP id 6a1803df08f44-70700638cb8mr17930076d6.7.1753275069154;
        Wed, 23 Jul 2025 05:51:09 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad7967sm1039883066b.144.2025.07.23.05.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 05:51:08 -0700 (PDT)
Message-ID: <ba37a9c9-3fd3-46fc-8d72-e57be45fc562@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 14:51:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] bus: mhi: host: pci_generic: Remove MHI driver and
 ensure graceful device recovery
To: Vivek Pernamitta <quic_vpernami@quicinc.com>, Vivek.Pernamitta@quicinc.com,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250710-sriov_vdev_next-20250630-v2-0-4bd862b822e8@quicinc.com>
 <20250710-sriov_vdev_next-20250630-v2-3-4bd862b822e8@quicinc.com>
 <68f18f09-913d-4ef9-bd13-ad32c1d5f8ca@oss.qualcomm.com>
 <43424518-e73c-4136-bb0c-d4cb30062d7b@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <43424518-e73c-4136-bb0c-d4cb30062d7b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=6880dabe cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=ICarcIS45CnasG25CU0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEwOSBTYWx0ZWRfX7EVVAuS6BPBy
 MQZ54frvLNLKGAoThkDxpEsoAJbNDnNBUDloqNHiWPHQv4Di5M3DP4oVQ7E4nXUnqp9CyGHPd4F
 1J2+Ty5o9Zn9MiKyL0z4t9RakyksHbB+o/O7qiFC+isj9YgS/vCRFIiHsyn20BDMsGlYpKY6FgT
 bOb+k4LqL4px2pDmUDEwYRkONZ2OM7BV5e0FNCf3AGImFzWMILI24dPpWLSBSddKcgZTyq0sCu5
 zYhGCdyW9V4/a8bnUyi30b7wsRxqRoBqo+nWABRQ74W275owCgvERtF01C9gX+4lI0tAjj9Ovm+
 VLht4JAydnQYYLVisBU9AlYTuB1V2zMUlUrkatN85rKTnf7KKiCeY0x2niFDlES6sSGv24CRpm8
 baw9XK7/HZKPIrJGy1HzFW/HAgJLc5W2kiGBkd3FrKwh+u4oUmtD0Sdol73pUYwF7wfC7dTY
X-Proofpoint-GUID: LOFQOXlxoxGG4hsNkRtR-5-9TlqrQpR1
X-Proofpoint-ORIG-GUID: LOFQOXlxoxGG4hsNkRtR-5-9TlqrQpR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230109

On 7/23/25 2:11 PM, Vivek Pernamitta wrote:
> 
> 
> On 7/10/2025 6:12 PM, Konrad Dybcio wrote:
>> On 7/10/25 10:58 AM, Vivek.Pernamitta@quicinc.com wrote:
>>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>>
>>> When the MHI driver is removed from the host side, it is crucial to ensure
>>> graceful recovery of the device. To achieve this, the host driver will
>>> perform the following steps:
>>>
>>> 1. Disable SRIOV for any SRIOV-enabled devices on the Physical Function.
>>> 2. Perform a SOC_RESET on Physical Function (PF).
>>>
>>> Disabling SRIOV ensures that all virtual functions are properly shut down,
>>> preventing any potential issues during the reset process. Performing
>>> SOC_RESET on each physical function guarantees that the device is fully
>>> reset and ready for subsequent operations.
>>>
>>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>> ---

[...]

>> It seems rather unlikely that out off all MHI devices, only QDU100
>> needs this quirk when working under SR-IOV
> The reset_on_driver_unbind flag has been explicitly added for the QDU100
> device. While other devices might enter RAMDUMP mode and wait when a SOC
> reset is issued, the QDU100 device will pass through without entering
> RAMDUMP mode

Rather inconveniently, this is not something that you mentioned in
the commit message.. Especially in the middle of a series that focuses
on enabling SR-IOV which suggests it's strictly related to virtualization,
making it difficult or impossible to understand the problem that this
patch is actually solving.

Please rewrite the commit message.

Konrad

