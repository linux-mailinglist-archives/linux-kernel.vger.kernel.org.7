Return-Path: <linux-kernel+bounces-895694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28955C4EAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E90194FCF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4B32D7EC;
	Tue, 11 Nov 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KnEMl/VL"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673228FFF6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873201; cv=fail; b=PM7daHTuCPUcnXOhVstA5zpRae+NP9+y6R30qcFdduKLBe17OgoZLFjFCOJvgLs+qTnRbbb4OZkJGJt8cQ/WolsYho5K7o7mEJcX42rJaDwqPOqtq1iB/rfFu1jum6ltudsJx4LBLuMOJFoIb82bXkifxYwZILMlhT7AxpKEqlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873201; c=relaxed/simple;
	bh=Ezo+O51tBdxatAed/fDOBLXqOzWa7pWnCGauUDpEM0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uUfzQkorZlRlcVjp5fplTU89RRjx4H2qrw8ngN5Pa32QOUz8Pd6J0vrfx5n8qrPJWDh5R60wyxYOEBZGkUy0V+FQgoLtnzhju4ZVTxyCHxwKzV8FKmpmM9AezM1ycRWwj4QlHv8jJUop7qLxJmOIe3+6mjb7eEtb8xEsFbAdwyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KnEMl/VL; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftTCGIEiu/NI+KKBkxyIOrMtwzNONS1J9p/QZVfWfUdIfi8BzPEdD+Ze9TDyv5lr0zU1mcas5LhQpTk5aX8YGz88Wd++Zk05iC/oFZMGFHBEefMyfkDwEccJTMSyGXPtHESR7nhaJSZlQpuEa04Bs498MFLehK13V7vugSuJZ2HPLRYzCrIS918ntsHhq/36ArNmUiosYikmC4IUHPjR1M5ylOyhltFEVaKnvxZruWsxUUpdKxIfvNbp8ssl7UKKyPMuDKMVfdzGzhshXOk6peDE7Kr6LvsODIQJl/GD7tX2S1P9aYL0oeF/fBl0Mw63m0m5ePOt4RmK4dArQlsHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpIqhfUpfIPNfPoxmUjdoTeErdA76kCPGpgoQw9gJVg=;
 b=bKNb0+t4gcmw6ydJmXTYQ4WhwhqF5huOcCfvbabg5W29V3bCLhBwolrrPzbA1229ZZaJQtTbVp25TRUhmjSyF57twkvWwAzu/SCB6Qdyo3HnKkmlVEV9OKsuzSWe7aRmYwurjpqEtn9OMOHeGlSXJFZa+biCLbxo3mdnCNty2EeJvVFohMWsuBZpreioPHsGWtSbqS41eGF/b1Apakz3YquB9vXXy4anjL68Mf0uQJL90lsAxLsOpuBnl+bbtu2IoIu7vXziXtfb+Ug3v3DL6SXj65HODbks6vMh0OEzqj+Dd8BCBO88Hw9P9xp4UA1jDzDU5NLVc3MQKZ/Hw6v4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpIqhfUpfIPNfPoxmUjdoTeErdA76kCPGpgoQw9gJVg=;
 b=KnEMl/VL/GPZM2NOjCpxqIYhS1dnpea1FWRvOkcjies0nOeLPV85O52ATt9eaY0hxenFnJ9Kh+4BO2ECQWX7PK/765ohj9imnI446OfQzDeGx1TQ0sF4QF8s0jVz66UW/Wb6Z0+bKy5KKIFc00MfBwvyDWlFUxjJHfbkbHw0Y3I=
Received: from PH8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:510:2d1::22)
 by MW6PR10MB7591.namprd10.prod.outlook.com (2603:10b6:303:249::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:59:55 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::d6) by PH8PR22CA0011.outlook.office365.com
 (2603:10b6:510:2d1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 14:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 14:59:53 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 08:59:51 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 08:59:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 08:59:51 -0600
Received: from [10.249.139.123] ([10.249.139.123])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABExnq21113931;
	Tue, 11 Nov 2025 08:59:50 -0600
Message-ID: <85fb83a9-6d8c-4c9d-8c78-2d3f5d473ea2@ti.com>
Date: Tue, 11 Nov 2025 20:29:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/pci/controller/cadence/pci-j721e.c:648:undefined
 reference to `cdns_pcie_host_disable'
To: Manivannan Sadhasivam <mani@kernel.org>
CC: kernel test robot <lkp@intel.com>, Chen Wang <unicorn_wang@outlook.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>
References: <202511111705.MZ7ls8Hm-lkp@intel.com>
 <h4yvzfhpd7exv2o2oxed7ocobn5zpwmtvzoxffj4rqsiq2dqfr@sobzxhwa5c23>
 <cc48c040dac2edc27b453bc482d62309cea25c06.camel@ti.com>
 <znkojajaxfudm3xn43ed4my5fcwyszv4gxajnizonqu3pf5t6g@bph3av5mzmg7>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <znkojajaxfudm3xn43ed4my5fcwyszv4gxajnizonqu3pf5t6g@bph3av5mzmg7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MW6PR10MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 4924d3ba-8477-4084-e0cf-08de2132f8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|32650700017|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVVSZ21RSFRvV3BJN0kzVWlvRkk1d2VZNzZMK3hWMXhzQ21nZkJpU0ZQREhq?=
 =?utf-8?B?NFVkZHR6ZGtDMkpCeGFMdmtyR2VHSER5WVplb2dHcFZrLzhuK0RxTG00RG9W?=
 =?utf-8?B?MTl4Z1lrOC9sWXBtYW5pWFo1ZkxWalUvdzcwc1Z1aWlSMGxVMHI5N1dZdytU?=
 =?utf-8?B?cmF4NGFyTzNnUWhNOW1IU2hvMXkxc3VncVk1bERvV3JjNTg0Z1Bwa1hoSlk0?=
 =?utf-8?B?R25zLzNreUoxbGlpSEJmTHNxWS8xSTZuNWpCcFlaRnc5azJLa3h0Slh0OVlS?=
 =?utf-8?B?cHZ6L2trRzFwY3ZMZFlrSlRmaWJOL2VHM3NJWlc1MXJESS93dEFVcEhHU2Vr?=
 =?utf-8?B?dlZyNGFKSFhCSFNzY0JodTZGeUl2b1RSWnF0cEJFc040Rm5IS1kraS9zU3FH?=
 =?utf-8?B?NHE3U240RGtUWFJackJBd2NIQWluSmszbXg1amp5TDZsMDlVdjdFODdVdm16?=
 =?utf-8?B?MFJSdVRlbUFnMi9zVkw0c0hvWDRiWEcxZXJEYitqS01EcUE3eWJMZy9lZnY1?=
 =?utf-8?B?L2xiaXFQblBvakF2V1c4cmovUnA3TUUwN0FvVERzV0phV2VvWWN6ZldNMXdO?=
 =?utf-8?B?TzdJWDBZTXNHbUhvN0VOZ3RtTG5kS0NpdCsvRlNvSGlKN21rdEZ2SXB0OVpO?=
 =?utf-8?B?VW4vNmRaT3RqTUU3WFliMzVQNTBZa1EyN0RtOWc2VG4zWlJrOENFa1dIQTZm?=
 =?utf-8?B?d2Y2eHhUSk44L3pRRGVoMHZ6dlhncWZGalFNWmFFak9mbFNXK1dwZzd6YUl4?=
 =?utf-8?B?ekt3YnMzMCtiVzAvRjlFOHRFeEYvRlMra20zWlJaN1FpK1NDN0xRRU8ya05X?=
 =?utf-8?B?aS83SmFCZzVSaWNUY3FHRHdWZmJpTFUzd1oyS2hQK1pEQzUyaFN5UGZhMFlK?=
 =?utf-8?B?cUlFQ3JYWUdpbDVjSmwySkFOQi9GcDdpdVgrMFhsdzN4RDdQQmM0VXkyTDdw?=
 =?utf-8?B?U2doelptWmpwMnMzSXJ2dHdBTGtaTzExd1B5UStzYkVqRldLV1dzdHdiS2Vy?=
 =?utf-8?B?NDhtQU13RW1uNUJjL2xKNVJEMDE0b3JmZjlyUkoyblBwSzRCM1Q3VEZyMC9G?=
 =?utf-8?B?cXU2MXU4TVRIVEhMM0NjYTdXdVpDNVZxM0FjV1FSajVkd0xFb2JiZGhrNzRS?=
 =?utf-8?B?WmVLbG1taVQ4alYrbjRpM2U0c3l6R3lVUzdsdS9kdnMzTUUzWmk5RTZEVDVD?=
 =?utf-8?B?V0htakwvMEs4Z1FaMzJ2ZFJLNGFCbEhKQUJ2eTVJbDhiR0IvWGQyblNNL2xI?=
 =?utf-8?B?RUtsakZKc1hRUGxXb0tlWC9JKzhpQVB1MGM3M2VRN050UklLZ3JjbmRUZ2ph?=
 =?utf-8?B?VmVZTEg3SDFxb0RSK01QRHNFUituUE13UWM2RFBobHNIbmptTWVMeVd6dW9w?=
 =?utf-8?B?akZDM1ZzMUFnc0FnZ1hTcFJPVWVNVlNpcW1DUGdZZkFtaUpxL0NiTUxBcFBH?=
 =?utf-8?B?RXoybVBVY1hxQkYrUDJhN0tlelF1OG4wQzBBZFBGaEtteVNrRW4rM1VnSmd5?=
 =?utf-8?B?TmxaTk9YY3Q5cFZaZURpRGQxME4xRHVCQ2xCNmdMSENqRjV4RWZFS0ErTFZm?=
 =?utf-8?B?ODdkYUhtR0ovVUhiS2xMMmd3R3VjNlBKUmZJYTNld1IwQ0xaaFcyRWduN0Nn?=
 =?utf-8?B?M0x1YVhkZURuSCtLRktSS3FvckkxWWVKMTFZQkthbWRFanhvMVo0OWc2Rlhh?=
 =?utf-8?B?UlQrd0o3SjdjTVJ2dWFQWXdmQ1RBeWx1Q2g3WDIybURxdFNMMWdsQ2dyS2l6?=
 =?utf-8?B?b2piWVNxNHVDN1VaYmR3L1FpOFVWRUFPWGNIZlMwWloyVjlsSEYyQmFkTC9V?=
 =?utf-8?B?RklTV0ltT0xFTlJvL3FjcWJQNDFEOWNSOXl3amQySDZnSEJPUEwxYkJWNFZl?=
 =?utf-8?B?MG16K2c4djBNT1hlSTF3Mkl1Q1VzcThMTzI4Vy9BSnU2TFdnYXRSZ3RCTUhU?=
 =?utf-8?B?ajBCN1RWSjFsL2E4SjVsTm1qYWhOdllnOFBiZmNtcDR6RkJnRk1EWHUvVmg5?=
 =?utf-8?B?WUJSaEozTGo2bHMyOWNDc0I2QzA2NzgwaHR3NGh1ZjQ0ckRaOUswalhhUkhz?=
 =?utf-8?B?bXQvVk9DS2ozdWVPZUZvamtUU3NoS29EN0IySSsyQzd3dnJXZnBqZHNWQXVZ?=
 =?utf-8?Q?0O0o=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(32650700017)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:59:53.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4924d3ba-8477-4084-e0cf-08de2132f8c7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7591

On 11/11/25 7:39 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 11, 2025 at 05:09:25PM +0530, Siddharth Vadapalli wrote:
>> On Tue, 2025-11-11 at 16:24 +0530, Manivannan Sadhasivam wrote:
>>
>> Hello Mani,
>>
>>> + Siddharth
>>
>> Thank you for notifying me of this.
>>
>>>
>>> On Tue, Nov 11, 2025 at 05:28:54PM +0800, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8
>>>> commit: 1c72774df028429836eec3394212f2921bb830fc PCI: sg2042: Add Sophgo SG2042 PCIe driver
>>>> date:   8 weeks ago
>>>> config: loongarch-randconfig-r113-20251110 (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/config)
>>>> compiler: loongarch64-linux-gcc (GCC) 15.1.0
>>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511111705.MZ7ls8Hm-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp@intel.com/
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>     loongarch64-linux-ld: drivers/pci/controller/cadence/pci-j721e.o: in function `j721e_pcie_remove':
>>>>>> drivers/pci/controller/cadence/pci-j721e.c:648:(.text+0x83c): undefined reference to `cdns_pcie_host_disable'
>>>>
>>>
>>>  From .config:
>>>
>>> CONFIG_PCIE_CADENCE=y
>>> CONFIG_PCIE_CADENCE_HOST=m
>>> CONFIG_PCIE_CADENCE_EP=y
>>> CONFIG_PCIE_CADENCE_PLAT=y
>>> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
>>> CONFIG_PCIE_CADENCE_PLAT_EP=y
>>> CONFIG_PCIE_SG2042_HOST=m
>>> CONFIG_PCI_J721E=y
>>> # CONFIG_PCI_J721E_HOST is not set
>>> CONFIG_PCI_J721E_EP=y
>>>
>>> PCI_J721E selects PCIE_CADENCE_HOST only if PCI_J721E_HOST is selected,
>>> otherwise, it will not select it. This will take care of the dependency between
>>> PCI_J721E and PCIE_CADENCE_{HOST/EP}.
>>>
>>> But if PCIE_CADENCE_HOST is selected as a module by other drivers like,
>>> CONFIG_PCIE_SG2042_HOST=m, then if PCI_J721E is selected as a built-in using
>>> CONFIG_PCI_J721E_EP=y, it results in this build error as the built-in driver
>>> becomes dependent on a symbol from a loadable module.
>>
>> While I don't deny the build error associated with the above config, it is
>> an invalid config in the sense that the Glue drivers for two different
>> devices are being enabled. This seems to be a generic issue wherein
>> multiple drivers tend to depend on a library/common driver. How is it
>> handled in such cases?
> 
> AFAIK, the common library should be built-in to avoid issues like this.

Ok. If that is the usual approach then I have no objections to it.

> 
>> Is there a notion of reordering configs to ensure that such build errors
>> are avoided?
>>
>> If PCI_J721E_EP was selected as 'y' before 'PCI_SG2042_HOST' being selected
>> as 'm', it would have resulted in 'PCIE_CADENCE_EP' being selected as 'y'
>> and this won't cause a build error even with 'PCI_SG2042_HOST' selected as
>> 'm'.
>>
>>>
>>> I guess, we should force PCIE_CADENCE_{HOST/EP} to be 'bool' as it is getting
>>> selected by multiple drivers.
>>
>> This will defeat the purpose of the series that enabled loadable module
>> support for the pci-j721e.c driver and the pcie-cadence-host/ep.c drivers.
>>
> 
> Your 'pci-j721e.c' can still be a loadable module, only the common library will
> be built-in, which is not that bad.

Yes, this will work.

Please let me know if you want me to post the patch to update 
CONFIG_PCIE_CADENCE_{EP/HOST} to a bool.

Regards,
Siddharth.

