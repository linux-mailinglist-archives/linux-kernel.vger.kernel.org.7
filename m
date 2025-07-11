Return-Path: <linux-kernel+bounces-728362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DDB02764
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266421C856F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22795222591;
	Fri, 11 Jul 2025 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f/T4QJ2A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035B1F5852
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275192; cv=none; b=B5X1l1+9HKTyDlwXd1+ZEtuuOBCy1zWmkVyXpYxytYsDEcV+RkJo0Wm71WLFbkAp28q5gpqDQjqBk3WjVz5bUF6avTo2AOmbtzdHn0fHUaZXgURbuYeBF86ux759Qtyq0fuizOGI2yR9icjcexdElP5Mis164K+Q86CqA53vzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275192; c=relaxed/simple;
	bh=ftb8jDPRJLRD/D3esyee2T7DhrNjtEME0Bi6Xns0gjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HV4A0yYs37jt7ngo9cchxRhCOpOdcRn7x7XLWtyO80rKziB2B2a3sWgzmJodZjSn79O+1XmUq7xj3YP4s/UiKZambk029mPodGjD69Z+5kWGMSOX4cKFpiOF4BNvIyfqpUmw7Bd8EUQsXwB4kErZ5lNKHzoNkBOxl4KSwyQl+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f/T4QJ2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BLglqn021884
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eRi2bFv99W7KvrolTDuk12d65vjZCVs5GiO7uLokh1E=; b=f/T4QJ2AYCB++mb/
	QH3dwnIXdNSUSFPElOYu4mwQ0sIDZUUZK/L5TsGgeZLTGZsGhhg+QSquy+Pdz6RE
	XLCRrcb7iwb3EvR7lUxjBZ6OP0UfrXDVssUa9UlS8+7wz4mx2ngtj+M6kZYUdpYs
	mzvWi9ESdGA0M31LyYLYVRYPrUqrNFQr3Q9IxmC5t1LzqWBTEJGc6PESwOOgni9Q
	3eksdv8bW529+M3oy2EFXWTslCOMGWP/q8HaEyT5GB68TpN174vwSHVMWCcqYyBJ
	gbEiIcpa5Ju02oeVtt/FfSD5Zy3jHzGqSs+VbHwjihBb/wwROboKTS6O3+qN2K0K
	MPOkHQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b1b3p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:06:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so4319467a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752275188; x=1752879988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRi2bFv99W7KvrolTDuk12d65vjZCVs5GiO7uLokh1E=;
        b=vRwjbh/K4KBykDChP7tHtEKC1yEU2Vcx7t7ATnAh50CYKnRS4p6L8+l1z6+7MHVSq5
         irPUpJv1SRdGd69Lx24iHExwDdWbmzFZqmBgrf5rU8YbvrdLavY9g5lB3P3pf5J0Eoln
         l7i/uJfafXB1aDgKrCQIsgpcBK8F7UyH+IHMQQp3XhBNteC+uZg3pPLgXTl92S9CdgZb
         YrS6ygNacQABn5iKbmwKh8dXgSOBkhMxYuK8khlH+pSqg83HgYRAX1kZHZeJn/sfQ/Gp
         3W/WA5VSgX7Zf4DoQfM2HWB6g8ZpsiyWkRs3ZU9lv6ThNNPyE7wipZG1c5J1sMvPbJW1
         32/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDWZAyzPPIDx9J2FIuSsELp5+WylO34iC9taqpECHZ+97dtjmSkzvGncY1I8YzJtY0GF0hlw/wBAPdOKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyekm9SbVYFP1zpUf6Va7bw2yRh2mtWp88oJIqQ8Z6Td/v6rtB8
	iFPglig6c33BUsT+TOf5v1SsmkFHGfMJCdht06jpnbGzwn9iEzz/K5l+UD2QN/Zv5p4ooxObGNO
	oBsEUEZPeN8sfKvzYtDqPwvNuBvwi2+/O/D7CxzFBYKOjuuiLkY2yFD63FHk//4P0LjU=
X-Gm-Gg: ASbGncuwBu6qCAmui4r5IDYmNiqFKXSnoXpfTUc/3TPHraASn6g/3CO0ZIwfLRr931m
	hX4i35Qzca21qaITv6mQ9S+R8I7zonrcsCc2kRZDnTcwWOujUF4OR40DAfht8vWkyfzxKLxRbqa
	mm4LMF1ECFw+X/JPmJnjx/xBdmhMIsoIpSA8ykWVR4KzW0ecaAuQeEjqoETCrjF01WcmXmDcLjf
	jhnByli5HsU0K6j8RuxR9FKZYBdg3Vx4cmUDY0oa9ZS/0d0D6xsdoHbManYtb9jw21Kmu9aD4ba
	xujPoiiHUiDnurFNUcmPZk4ygmOIrxylFK6kvcAn2zthtxW2P/RoY6cQybkNomsp0htw
X-Received: by 2002:a17:90b:558f:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31c4f5af641mr6697006a91.28.1752275188341;
        Fri, 11 Jul 2025 16:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOA57b5bd6nFUs/a3OF0BCONNKttUzt98H1lAvER5erkT45XFhKpR098tx16zYR8pMEwH+3w==
X-Received: by 2002:a17:90b:558f:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31c4f5af641mr6696957a91.28.1752275187781;
        Fri, 11 Jul 2025 16:06:27 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.227.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb62ef8sm5955644a91.37.2025.07.11.16.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:06:27 -0700 (PDT)
Message-ID: <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 04:36:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711213602.GA2307197@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250711213602.GA2307197@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=687198f5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=4nqOr+EkFiuPl9GB/B4vcQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6PMv1mg6ifOMqnheZnAA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3NSBTYWx0ZWRfX9vU5WL9g629l
 EejslUE83E38tzKDEx9jtCd1zsi98AxIAsOqe/0DE2HNIWCuc9DX+MH3K2W07glNantc93EpR2I
 YXhtpYwCDcBeE8Tq/BhwVijcAe9d8BapF+ZO/4DcnwHrQmJiOKqKHs8Bes10w9K0aRtNrLF4z22
 Y+bocWUmkpxpjBgo1RxTz/D+zorpXWYmHNc23xXfQeyWQB9oiHuz5Xwv+6SR1YG/V/vaRF1cI/8
 7DVvt6fkqXqgVQWAcHW/yUp8UrIu87iESPyfzMEgiXI6rXFQqaIwjhm+/RDHJ0uAUdCt0h1PiLv
 J7IHpXzmUfTewREgzN1q2Unj6mps4ziLV2fo99M0lG/SmASTEOjVPmiklZraaHYlswhxq+a1/FF
 gZQg2qfwotpoDDoE4IGvDdJJZXspfDdsjaQt5f9aKa01oIgHVbQOLVUou0CLlBo1SqyImHGv
X-Proofpoint-GUID: 3WHTGYt-eTzPsm7zkc91zPSTwYfnyy7j
X-Proofpoint-ORIG-GUID: 3WHTGYt-eTzPsm7zkc91zPSTwYfnyy7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110175



On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru wrote:
>> If the driver wants to move to higher data rate/speed than the current data
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
>> In case of PCIe switch, if there is a request to change target speed for a
>> downstream port then no need to call these function ops as these are
>> outside the scope of the controller drivers.
> 
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
> 
> No need to repeat the entire comment.  s/.././
> 
> These pointers feel awfully specific for being in struct
> pci_host_bridge, since we only need them for a questionable QCOM
> controller.  I think this needs to be pushed down into qcom somehow as
> some kind of quirk.
> 
Currently these are needed by QCOM controllers, but it may also needed
by other controllers may also need these for updating ICC votes, any
system level votes, clock frequencies etc.
QCOM controllers is also doing one extra step in these functions to
disable and enable ASPM only as it cannot link speed change support
with ASPM enabled.

- Krishna Chaitanya.
>> +	 */
>> +	void (*post_link_speed_change)(struct pci_host_bridge *bridge,
>> +				       struct pci_dev *dev, int speed);

