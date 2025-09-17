Return-Path: <linux-kernel+bounces-821338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31CB81063
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711042A456E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54B2EAD0C;
	Wed, 17 Sep 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiHXr1VS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F52224B04
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126599; cv=none; b=l/0+EcKVM219t5aDKQXWRWN2B1qMrmyql03Ur+TD2Aa7fW+o8yzo6nPc3e9h6bnVgbuHDIqewQDLDzJj7+brwe4JdxqU1ZdJXShX3MoWfMbVIpUAEjbmRZlfYZ/9EMSrQaqwclTgrQ88MWdGkl85vYGg5Kdmpp1hpa/nrPhSWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126599; c=relaxed/simple;
	bh=j/kIpr44aITpYwfRH5MGrbeYBzQDUseVMB6E+aFtzw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htzI4ThQtkTvN4fcQgcyacytpCbWoDdTVVhEv2/O6AtivQU199CGasW0OaKJwl6pK1IjDiLIjlYHNEsJDz4ha5ay6xLXKuLmetqHEHhZH1rOhNZytLYHw1WUPZGtyG1+pd1LxaEOqm6fzLN1UzBP9IDyafQIV7WjvgYkjajTb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiHXr1VS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HGTeJf010735
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPbliOpcCjIzayrMLkNw1FIe5VlXIVH9kvQijQYZm20=; b=ZiHXr1VSwLPkG2/M
	uN4aJnP3sUlNJHPGAh3ELOm4kQ4P2lX+AdVXRyMYk27T7PcAAhrVYwvHjtwZjgHF
	uhuOh6Vaga2zVy0qbAVoknjr2A8srxFLICJWEY8Az8eL8D26lVz1ipfyB/knPy+c
	Da0bx9l7qK2KqhohTPupv/taCjPhHh+M1NatXt3JMlxX+kA5Jm3XcYilL/PrlDlP
	9BYLM72CjrJBhFMpW4UwRBQNImIzZL4c+7a75wZVGjDypcZu0PitzLFjaTDDo8p/
	hxNDhMB4Xd2wobqCu7aH/QKoK07FdCpEX5kIu1EemxR72AIlYDL0IDdA+8s9lCkr
	CVrLBA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxu416-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:29:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77619bb3871so68806b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126595; x=1758731395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPbliOpcCjIzayrMLkNw1FIe5VlXIVH9kvQijQYZm20=;
        b=Rb8dWoOizs3E9X8Jm6shdCiSQmOXm1qvRKv4khxTYVr0MlXSfa3Eh/PqxLHDZ0TDyW
         vULeS+6NLNwooRM5h8E9wyXcyVInw2wa0z0oGIP4sxaiPruBCynrcGEJNKPGy1yetHJB
         +msF3Ykw3wfBh2Ydn7hQN08XxokRGCLM6NhVc6oSoEEiLcvTt8z8icoc/zbuNzbrnxiP
         QSGAa4YStBXi+kRTCEmLp+/jBREzKst2mV9SG2Gnh8EGJ+FdSiQsmiijoRv3F7xVo1/C
         WI0+JR2tH/cJ/O894t+9oeUEB/Oal1lTJAvzasi2D9O3YqU4SCxVXUyCwy1QFeEUfdNU
         g7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaZRvroLQ6RSiUlDz0PCctDmdFaDtYsIkmNckL0mlwZwv8ri6lZJ/mUQwTV0NJCsKUsq/MFmpKuZU0yY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBepLqhiS0CqFVEoGPS3WNMMYQV2gftcRwSk5qLa+bHzmIXKc
	ISjI97/uNrWywyKv/GhwTUg18hmRiHaW0n1ytZc+ID2+7rPqv9pdnqTosg75wyP9FqWikQPRaX+
	9Wx0YRngSwrqq1U18O2nrMztKKHKoQYXtgShWPnL/k4E4Exf/lRihFIpTDhXxSacL6uM=
X-Gm-Gg: ASbGnct0VK7CX3JNU7CBqNAMzgbMS/7v+4bHxJLhkP5sDLo2micu4rmqhOXIwBbtfcT
	5O84OBc4N06KHWsZ7erXmBvTpdulZVb2yPhGxSwTlGK90Y3OmzUD0dadtq7i2iwJUL2aIb6cHR5
	WnOvdI4t+A+PC7/zGjgpNAbdRHaL4E7zrmSA8Om9Ico21hq0Jcaa50dtQsWepIExqWAIks5EQHN
	Rf6+vgAw2dGj3ZHhyTGgAQvcDPoyZIp0mEDqyepFHiuBv7JMqThSHKO5Xxxtpgc37JVAq3HKgX8
	0pLwjzxXIQhUX3C77HKvXmtBDMq74czXeKwVANXz+M6Q3R5cGphAfwzu4e2PT4c=
X-Received: by 2002:a05:6a00:8d0:b0:776:1f45:904f with SMTP id d2e1a72fcca58-77bf9268104mr3162349b3a.28.1758126594827;
        Wed, 17 Sep 2025 09:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSAETCbSP3vIIE9VWiyL8Alz3IwaM2MYDhGvePBLrTzg5i1/2OcH9B9+r9HC87lkyc+hFW4Q==
X-Received: by 2002:a05:6a00:8d0:b0:776:1f45:904f with SMTP id d2e1a72fcca58-77bf9268104mr3162319b3a.28.1758126594363;
        Wed, 17 Sep 2025 09:29:54 -0700 (PDT)
Received: from [10.216.34.136] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b3603asm18872680b3a.84.2025.09.17.09.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:29:54 -0700 (PDT)
Message-ID: <3c56cd00-770f-019a-d93b-5ebaa6b9374d@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 21:59:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 02/10] power: reset: reboot-mode: Add device tree
 node-based registration
Content-Language: en-US
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
 <20250815-arm-psci-system_reset2-vendor-reboots-v14-2-37d29f59ac9a@oss.qualcomm.com>
 <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <in6bqvemnscvuxbumpxogxiiav7odmsc3iazktifninh6iqen7@qwhrhdidcx7y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9PNB4ms+Re5H
 M8kucezoBJSPywvpFjtfe0LcO1tVmIZWzljIdZwKSWcnACZv9JlS0A0gQj4BtlX9l8WMcje81Ry
 wfeqnxBl/oJzaqVTKYMnP6MsZjpFqpU4f0ALKnRCfTQYchHxMbJ56na3cvMifyKUcIslV/B80Z9
 iqxQBL139aC+Wu6RL61EUGNAMWSmAjmBv3rAUD/n3jEJranwhSEeJL9zuIenXRKcNbCSd/YgKEX
 h5bihZlszOO2YZMaNm3/Dc8IN92qvURa4CHZF5LOxE1mEGsS8wj+UkG3aylq1f3NkvNz8Ph97Qp
 eAGp01EPYpTaiOLO7mu+kVjaAV6zrZv580+dku6thomjH8xW5euobRIggD/ScGca1qTar1skhSg
 0m27h76w
X-Proofpoint-ORIG-GUID: jbThNhO8B7zwqHtlPz-_loZfMukGr80v
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cae203 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6ImPWgPuv615vBLeUzsA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: jbThNhO8B7zwqHtlPz-_loZfMukGr80v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 12:18 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 15, 2025 at 08:05:07PM +0530, Shivendra Pratap wrote:
>> The reboot-mode driver does not have a strict requirement for
>> device-based registration. It primarily uses the device's of_node
>> to read mode-<cmd> properties and the device pointer for logging.
>>
>> Remove the dependency on struct device and introduce support for
>> Device Tree (DT) node-based registration. This enables drivers
>> that are not associated with a struct device to leverage the
>> reboot-mode framework.
>>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
> 
> Please use fwnode instead of device_node, so that the same thing
> can be used with non DT setups, if that becomes necessary. Otherwise
> LGTM.

To be more clear on this, have one question: the current unmodified
design of reboot-mode is dt based:

struct device_node *np = reboot->dev->of_node;
and then parses the node using for_each_property_of_node(np, prop).

We want to refactor reboot-mode to support non-DT setups by adding
support for fwnode-based approach (struct fwnode_handle *fwnode)?

Can you please explain a bit? Some more details would be helpful to
make the change.

thanks,
Shivendra

