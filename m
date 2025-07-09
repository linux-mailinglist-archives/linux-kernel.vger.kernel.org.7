Return-Path: <linux-kernel+bounces-723570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72FAFE898
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68DC7A8FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C08C2D9796;
	Wed,  9 Jul 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYy9mZxI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2912D7816
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062924; cv=none; b=ji6cwsnoyhZ/hnLf6UVGY0MV9HZ2HjGUnv4VqGFJVWywYTKE+oaar/bRXGP5bKhjALWApxSxVpRjlmyaqsckYSsO5utqLFN9Yj9cM9IpiyFWe24j9RAMnUv7lK8an3p7OMfiJE6NFO8j+w2eOgYLw62rYmBwePknTtPMHvfuWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062924; c=relaxed/simple;
	bh=WvdWGvOA7mruIfNqzDVZIul1sAUmObkrzYdqBVVnSkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6PY1UYUQq0K6alZ+J9iIOMPWGSxcBjcM0hebMK5vC+MobJl8H3LBMRdIjqpy8mpuzF67tMgqSFkf/fEVLbKAC6698Wy9nW8FgFzrrcDcDAUQo4cE6D/Ni9Se+u82OpW98054dWQBnFNprGjpKrey1nBm1oGf9b3PVsWBqHnqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYy9mZxI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697COLX030392
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 12:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xJxps7WNB224pVFYv2oMqbRsIVBO9JOpbY+yv27GphE=; b=AYy9mZxIh58Kztr2
	/nyu7ryxyZs3ZkzzL1Tto1oUAqNxxRmQI+RQHPxiT2r7Zr5AlTtVDwSNqbxWNOp/
	ZkUju/cFbgFcxwX7HMtIQR96qpM1Cppvsw1hhu+Cl1oKOHwYEA+S4ijP5YYFH0aV
	G2fTmMlWK4AYHGyeOVyli2VsrQML715tCjk9xzLUsK5m4mAEfiOtA1pZTxdSOgPw
	w7kfjfyuPuUhlxE5xxiPxToBxz8VjmkAqBH3GXwfy+nGh32lZeYOEoxW/JvekLyP
	6lb5f+6Ai6EGiN7IHDMEhOjJPfMZUKlyaI77gnjwzDZbOgXgPbJFbQp/LiHwbbFJ
	0zfa8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b11r26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:08:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235dd77d11fso52318745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062920; x=1752667720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJxps7WNB224pVFYv2oMqbRsIVBO9JOpbY+yv27GphE=;
        b=ut0c0WJczAn/TBBl9XaYJFKmpuMXN1g8ap8qCRynO7Tt+QIRf3qqtXSXTZx9q2lqhz
         KkOSPxXDfCO0gMOzarj1fyjP2QzcO8XvfnyEPIObtlhMmn9QvgR3j4rEBC7Rontbbdd9
         9h3aXsLV8G9R4ejP29+M3pG/SLlajuaKnigxKCtC18gluldMvQt+wb2W9+VhLZ30aC49
         FQ9euL5hJcmzUikR9ODl/h957BI6CzBAXHdciX4hCsnCj77xOQXKKReAWk2+VJT3XKQy
         SQDaHK+Lpxhi0SpnF9Lw5ECN+0wSj8hyN4u8t8nxu/bw9zJ4h67cav7SaR8ryyE5piCh
         OPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx2xy42QlpdtAw5esxhv8Rd12bmbLhAJMT6MpRK11sbiNkqXpkvlzSL17toumstFrAxR7dGcLx9axHXpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Tyfb/Ko1jx5PVqvGqkWNSwrCNi9oz1WMyn3RQbxtYaZ4OQWH
	wNm8EJg2B9OsA8qCkx9bu0prEwxksVfZhadRKl971kBI5lEUo8FfPRGGXSDeEKXpqhaq+RU9KBu
	zoOMubB0Q6rMmBxbWIqD11F5hjq/xiDOC+Us4LcUOK+PE7+Z93Uo0R9KdZrknQbXQiDg=
X-Gm-Gg: ASbGncuC5p2OrKliffM+bG9YA3KoKlHT83GcY5Q7eTFuCGMptq7J6lj6dxCbOK81wJ7
	EU80jOxK3/fNlvtFw2nup5mkMiY5p8+UrqXVMbDx+JbT929/jyrl4EYgzUcdkqqorO+TKY9g8y/
	xPa7uS8dRxbDyNrV5YlNhuRMgyc6r26qsEki/FTSo3DYXmdvxmeAghenDWDrzUcI6ot0guMcT4F
	KbQY8AUTthd0QzLe6G7C7m9TNGStwBeAN2M4tqh4dV1+lmXhpkz9ZcpWaGMNj10wf3lLMjpM+jp
	eV3R300cXE7HgbLoPgI1vj3Vto5RCl6WhpAZJ5mBt/QsnDhJRw4d
X-Received: by 2002:a17:902:ef47:b0:234:d7b2:2ab4 with SMTP id d9443c01a7336-23ddb1a0340mr37438845ad.17.1752062919983;
        Wed, 09 Jul 2025 05:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqtLZ+2Z/+gEvI3+1dVef7Kj2hVfOhPySi9l7Q95XTHCF49m6YWGP88DAjqKUR/2CZeBiXbQ==
X-Received: by 2002:a17:902:ef47:b0:234:d7b2:2ab4 with SMTP id d9443c01a7336-23ddb1a0340mr37438255ad.17.1752062919533;
        Wed, 09 Jul 2025 05:08:39 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bf51asm147826915ad.257.2025.07.09.05.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:08:39 -0700 (PDT)
Message-ID: <a5b8bbcf-f4ea-45bb-8a81-efc834eba233@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 17:38:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-2-3faa8fe92b05@qti.qualcomm.com>
 <fhi7q5mbe75xbfmff6k4qe5pe6xveya5dsfqkm6bqpz7rcn3vr@jyn4uxl2exp7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <fhi7q5mbe75xbfmff6k4qe5pe6xveya5dsfqkm6bqpz7rcn3vr@jyn4uxl2exp7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686e5bc8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=PjKuzrdxt0Go-pjIBLUA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEwOCBTYWx0ZWRfXzCJJm+feJWIz
 rp6E5bGG+G8kXF8t2r09es2Q3jFywVysSWVtzZ6ns9LENkSG9ruse4XMKEM68ohLpweExm1SIzm
 ydFlf7WS3DSYNh+LuRByMi+O0E2yV9x1y/6GpRQW4wy7Z0aAxsNDuyUjJX4LBdSwD0yBx5PDdkY
 sh0SxzGIKIbjCj05zKtXOOfUtM2DtjF+n1bdMADBWp9Azir75ZDP1Awp8dfywRDzdA0iMYYmAW+
 5b2ymLrqGV2MoW4VpCHt9XzbD1E0gclHxQIrL8eqGl6KmZTHTpZv710PJZuiPap4+a5nmCBx3Co
 s1GQwkoW7DXbo7bEPY9b6cvLC0kbR+PtO95rEboTOPB6OqcxKEeDvd182whXL/sK9DbXg7nWY18
 lq6ShmAav+dP8Xqy0VqPT+tlBi6J1ixNDd2ZTjp70PGMCYfHVBMfVsiZO3UMEGW9HcgV4UaM
X-Proofpoint-GUID: MgFaG8Ba3ZQBgsKDNa-N9bvVpLfON-bE
X-Proofpoint-ORIG-GUID: MgFaG8Ba3ZQBgsKDNa-N9bvVpLfON-bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090108



On 7/8/2025 9:55 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 04:21:23PM GMT, Krishna Chaitanya Chundru wrote:
>> If the driver wants to move to higher data rate/speed than the current data
> 
> s/driver/PCI client driver
> 
>> rate then the controller driver may need to change certain votes so that
>> link may come up at requested data rate/speed like QCOM PCIe controllers
>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>> link retraining is done controller drivers needs to adjust their votes
>> based on the final data rate.
>>
>> Some controllers also may need to update their bandwidth voting like
>> ICC BW votings etc.
>>
>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>> before & after the link re-train. There is no explicit locking mechanisms
>> as these are called by a single client Endpoint driver.
>>
> 
> What if client drivers of multiple endpoints connected to different RP of the
> same Host Bridge call this API? Won't you need locking?
> 
Yeah you are right, I will add locking in next patch.

- Krishna Chaitanya.
> - Mani
> 
>> In case of PCIe switch, if there is a request to change target speed for a
>> downstream port then no need to call these function ops as these are
>> outside the scope of the controller drivers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/pcie/bwctrl.c | 15 +++++++++++++++
>>   include/linux/pci.h       | 18 ++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>> index 36f939f23d34e8a3b25a2d1b9059e015f298ca94..dafb8d4f1cfba987e1ff08edfc7caba527f0c76b 100644
>> --- a/drivers/pci/pcie/bwctrl.c
>> +++ b/drivers/pci/pcie/bwctrl.c
>> @@ -140,6 +140,8 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
>>   int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   			  bool use_lt)
>>   {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
>> +	bool is_rootbus = pci_is_root_bus(port->bus);
>>   	struct pci_bus *bus = port->subordinate;
>>   	u16 target_speed;
>>   	int ret;
>> @@ -152,6 +154,16 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   
>>   	target_speed = pcie_bwctrl_select_speed(port, speed_req);
>>   
>> +	/*
>> +	 * The host bridge driver may need to be scaled for targeted speed
>> +	 * otherwise link might not come up at requested speed.
>> +	 */
>> +	if (is_rootbus && host->pre_link_speed_change) {
>> +		ret = host->pre_link_speed_change(host, port, target_speed);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
>>   		struct pcie_bwctrl_data *data = port->link_bwctrl;
>>   
>> @@ -176,6 +188,9 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>   	    !list_empty(&bus->devices))
>>   		ret = -EAGAIN;
>>   
>> +	if (bus && is_rootbus && host->post_link_speed_change)
>> +		host->post_link_speed_change(host, port, pci_bus_speed2lnkctl2(bus->cur_bus_speed));
>> +
>>   	return ret;
>>   }
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..1740bab514b0a9a61c027463a1fb154843312a22 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>   	void (*release_fn)(struct pci_host_bridge *);
>>   	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>   	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>> +	/*
>> +	 * Callback to the host bridge drivers to update ICC BW votes, clock
>> +	 * frequencies etc.. for the link re-train to come up in targeted speed.
>> +	 * These are intended to be called by devices directly attached to the
>> +	 * Root Port. These are called by a single client Endpoint driver, so
>> +	 * there is no need for explicit locking mechanisms.
>> +	 */
>> +	int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>> +				     struct pci_dev *dev, int speed);
>> +	/*
>> +	 * Callback to the host bridge drivers to adjust ICC BW votes, clock
>> +	 * frequencies etc.. to the updated speed after link re-train. These
>> +	 * are intended to be called by devices directly attached to the
>> +	 * Root Port. These are called by a single client Endpoint driver,
>> +	 * so there is no need for explicit locking mechanisms.
>> +	 */
>> +	void (*post_link_speed_change)(struct pci_host_bridge *bridge,
>> +				       struct pci_dev *dev, int speed);
>>   	void		*release_data;
>>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
>>
>> -- 
>> 2.34.1
>>
> 

