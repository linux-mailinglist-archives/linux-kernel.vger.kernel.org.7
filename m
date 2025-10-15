Return-Path: <linux-kernel+bounces-853974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442DBDD319
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB66E4EB5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0832C026F;
	Wed, 15 Oct 2025 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GTGvq6sc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8E2BE041
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514456; cv=none; b=cC/zIOvu2o4YNKqDpuAt551wK37lsn+StcphzXB30peV4WjURFGkcubTKetMekGQ1jBGj6ZioFdMQUSAR4jXOOueBbDVKoVVCKicmNlLqVFf5Lzyx1ZkLlLwFUgfOKGQ8/PltOfLn6PIJxMvJyrl2U9nOxTP9Dp0shIq9ixsU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514456; c=relaxed/simple;
	bh=JBySYm7jCnLNR7S47OJWMx5tSg66aDYRas2A7H3BfRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2F/Pfu4Nm0aUBxc9G1AY1b4m8b3SDBopjFEVgwEo+6bOUiBCF3iZQi6TsMy5JSNQqiJVxuSv4SN/J3bUrY7F2ICHsDpQdbDtyFP2Vg0tL6aNOyPNQyk9rGU+lfmaBNm5x6fohfSuusOASgu1ZEUmQaLqJhCmCfgY32tmjCSKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTGvq6sc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sDBn014770
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3wzEuS4KgwUf/si4HCRP4Xjfg9FTP53VK8rld0Pt2hw=; b=GTGvq6sc6JxH0BRj
	ATrPrb5KfpdAAosrchw3H6kaMELoxGWp3yqbmmH/y8D0AjUvLOxzprSudsU1bZ+Q
	TxBCCCTKBjaI+EbGlJyNHNMwPGIDwH5Yq/0K58KY45PtKXZtRE0EtZUy/BiR9bdB
	7RfKDLwEGUEoLtyTJztloXRJp5obqdVQWiYMSUyr4qsnc+iyh27XpAyRk+n6bbBf
	i99KG671HDGIGK8V9oiQ+AFQo2ieOzwDQVXf+HCFcS/uAtIJR/bLuJCyUVulwGCF
	iWatMZCyif/690rRFP6oj6A8romXj3CPAjlRaWDSVFR1BzUDFyvbObTo1uhbBSub
	m8pakw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj3jms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:47:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee41e062cso141978925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514453; x=1761119253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wzEuS4KgwUf/si4HCRP4Xjfg9FTP53VK8rld0Pt2hw=;
        b=tuxtyZkUd0/s4pznGKmfunBA094/IWS36Sy4iRpomepYCS83vVKf0rBpSTR9XV8FwL
         XTorF5P9JjmmeM8iNCJGwHWW4Lwtk+sMZgQG5uHsKG+k6guFSjg/usEyvCCV6X4hmpqc
         dq8A0rW81OXpkGycLIQubKwfZmAiC75G25+dlVBt2YaPufrLC3Zr4HHUaZJYY20RfxGG
         r9lyX+usNdNQTeIAWE4MPvDT+bQOqzHUms4VCk/ejLJKgK/v9l+Rgy8PeP0Hh2DV4vr+
         TGwuqeZ//zDyGV5v1PN0dwI6B4qn9rp3+ZKBhxF3Ay/Y/FCs9nN2qs+Vh6Eh+NvflrJ3
         +T3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOGk+4WAU/mIJoAAvbQv9yAYqvc8314BLMJvuNINieisjrarZJn6puch1N6VrBJ/oARzgj6Y3cXFBz+6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8UDPSO2smutKIGiKx9YCInTbqh5lzIsSRXjD+PM4tNBZ7feq
	wirekVA3nP9cRFYbuRD6IBgC/OmbXrT7Lt/Nc4NfS8q/O/0B/LGHJ6TV3B01n26mJRrCqouWxBy
	IxwwcMZOJbS0QxsVQAcTG/Js3/Qpa/L+3sxaBIFYVKqEgDgEGtcwiJ60r/2kEB52yAYY=
X-Gm-Gg: ASbGncs/12HwBGgs4LViKmKrKneC01zJihVOXWMyAjGCF1D6O+FSiTVrpW7WydOlTWw
	BsRueXvuMVqOl8vWyflfquGQg1nWE/PQZF89UOsSL4hfxUOFgeHs25Gh0JjOc6uOhfqHmZ5scdc
	UUvbMgjYnJVqvdzFEsl3uwJEvnsNAjhi6Ks+SJvsIMHwkn+OGSk8mEvPor9niVYr5dJk+CKHGW2
	qxMWRAs+dtb4E/NKy2yWuFe3dat7L/3liJPKm4CW/8yLZaJoWhm0D+zt99il0cu76sRGO+FQsb2
	pnshuK0YkHpJMNlmpPsONMz1iefGIesyxLfZzFTJG+f05CGJO4avHshOJuiefAD3ctqY3kAjnA=
	=
X-Received: by 2002:a17:903:2343:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-29027290194mr277067335ad.4.1760514452621;
        Wed, 15 Oct 2025 00:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhzyOtK2t73BdHuEH9yQdQ6LRCYOnKx0D9BJpdqWj+pdvXaadxnVohWazYDT43ZnK/Q6nPCw==
X-Received: by 2002:a17:903:2343:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-29027290194mr277066685ad.4.1760514451980;
        Wed, 15 Oct 2025 00:47:31 -0700 (PDT)
Received: from [10.216.0.133] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm187706535ad.22.2025.10.15.00.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:47:31 -0700 (PDT)
Message-ID: <1bf62073-fae9-dd49-c908-193c06cdda84@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 13:17:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 07/14] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Content-Language: en-US
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-7-b98aedaa23ee@oss.qualcomm.com>
 <3978e740-0589-4872-8f2f-1162084d3818@quicinc.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <3978e740-0589-4872-8f2f-1162084d3818@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8bGNa1dV490R
 5Seh/6EoMXiJFw7UaeKz29LEoLfwZ54Yxf2fe0O4LnOXnT8YBaUwOV27vQXiyyDhqQ0Jm0Rz+KW
 eVwAy6GbpzEeyh7SGe1NvhujqLOpx2rFk9TG/L5FzAuKRSLy+OW+eDakFBz91rk8KSWUWFq0Il7
 ZafRsSHBCTtgpoK4D6BzCKXbbGE7J4PtjBA1dKG3zuCVfyU/DqBo7XmTCdCr08W1NcNvwFNJh32
 oTdnIpAan1rBquHoPFM00cphtDXouZGmhoZFJpQlTD+li99TY2E+3mO47cmYi7nG10Srm3xKPuR
 7ZH3vSkROjGsSWjyUIWjmMdlwAckLwRZ33ZfWc8oH73sZ6FiGvW6IHlRUbfKVCeBS9lXBqZwnRp
 S711m3vBTvII3Fs16brudVZ4a5kBhw==
X-Proofpoint-ORIG-GUID: PFzBJ-1vngeymIZC5x2g3r2Bu0oQGYPn
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ef5196 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=R8NOTgI61i89tWg-cvsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: PFzBJ-1vngeymIZC5x2g3r2Bu0oQGYPn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018



On 10/15/2025 12:25 PM, Pavan Kondeti wrote:
> On Wed, Oct 15, 2025 at 10:08:22AM +0530, Shivendra Pratap wrote:
>> +static int __init psci_init_vendor_reset(void)
>> +{
>> +	struct reboot_mode_driver *reboot;
>> +	struct device_node *psci_np;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	if (!psci_system_reset2_supported)
>> +		return -EINVAL;
>> +
>> +	psci_np = of_find_compatible_node(NULL, NULL, "arm,psci-1.0");
>> +	if (!psci_np)
>> +		return -ENODEV;
>> +
>> +	np = of_find_node_by_name(psci_np, "reboot-mode");
>> +	if (!np) {
>> +		of_node_put(psci_np);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = atomic_notifier_chain_register(&panic_notifier_list, &psci_panic_block);
>> +	if (ret)
>> +		goto err_notifier;
>> +
>> +	reboot = kzalloc(sizeof(*reboot), GFP_KERNEL);
>> +	if (!reboot) {
>> +		ret = -ENOMEM;
>> +		goto err_kzalloc;
>> +	}
>> +
>> +	reboot->write = psci_set_vendor_sys_reset2;
>> +	reboot->driver_name = "psci";
>> +
>> +	ret = reboot_mode_register(reboot, of_fwnode_handle(np));
>> +	if (ret)
>> +		goto err_register;
>> +
> 
> minor nit: np and psci_np reference must be dropped since we are done
> using it.

Ack. Sure. thanks. Will update this.

thanks,
Shivendra

