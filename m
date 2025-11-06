Return-Path: <linux-kernel+bounces-888595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED01C3B4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6629F42401B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063832C945;
	Thu,  6 Nov 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O+hc2Eee"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE0319847;
	Thu,  6 Nov 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435973; cv=fail; b=memDBQCJPuKnifALYVYooRP39akaLIYHpyLycZv2X697jIi5NgKu10/nTSR+auXE162S1+K38xaJOO+1rVEaRNrEJbpwQxP8ENUHlBe0nLtKFJgZabyuul42+SrFVqX+TbVU5Gf3ITzGim9gfjbXJincgzwcygLunF4CELVNozQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435973; c=relaxed/simple;
	bh=D7MQsuPk8Sdmnsb/NQhljfHH/XYEm+3UAcqlw7uxGsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fmThC9knfQasbQn702akv22keQ668XKxH38SAY/qd4GJy0tnNFbYfMIrib2m6e7BZ4vIJtNFdZpzte4tOpwG3RlQeV6dkTPH7/tbdVO+zPDPpxT/aGTzi30CCdTMsg36kNyccdUnJLi6DoWcdODcYOYAsioCMKutNuI/vv5mrkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O+hc2Eee; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8F5BknjrXRvkMhmB4c9abjEvERLyIjJKAxQFPlIgSAUrRoc1PJGXSjQ9Islk8T6SudT20BtojhGfzYP+P30p1tfKIzFcXhyiOb0inbrTouQ1djcY8SyfPVJzWNYpWSwTdTtgN48WaWXQRMTtr6UbfvEiOgBoSdDmw4d9cnp4RicMAP6rT3jZB2N1X8fyjiPVoAk041/uh9CGh8EXmcjLPlE1/ZM/tVwpZ/QhRBJ/vLTxmQGRT9jrgZubGTx+sA/GcHrp/kh7+7aIuNRvCbkmkbgLS6W+Itl8Q2Q/oREp43Qptfy0Fw5mQkl76yJP+/7AL29WbCdxggQxxk127J9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyZQS/LAvIPJGv0J0eCeF7AHt5QC4UEFxwyQfmkPZSA=;
 b=IH3LA/SK0v36fj0yWtYBEk5hVZmSvwI98gRQohE0q2vS946c4D0QgR7bDsMWZmAgFGEAhtwYD2LvgM1JbXUTPlwTn8nWFx/RfVQ313pNX9T2tt4uo0uKqrtPT+MwhT8+x/Aa6xB/FQu28WAJ00V5QWPopfO5eGRue/ESRX9M+jqp3b6r1wLF1E65gPINEKosDbhvW4zDY4oN8OQXCA6r0h4JQEkhmG5mWVfwlVhLHwlZSVWFO8UBIGmQp5yPJIW6I5suIEqPfp4E4+FNspCGgMpzuodT61Sx5NxVmsz1JVuxh/YGaJeF1bqq6f3aFif0k/4qfGBz+JgpNkEZ6fy6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyZQS/LAvIPJGv0J0eCeF7AHt5QC4UEFxwyQfmkPZSA=;
 b=O+hc2EeeXtw3zvMc8LbbCgsdEqsITUPHt6rFETUMxJVmF0Rf8YF7MzA1vBLr92j4qJw7xovvUElw8WhlblkrVX5lmk90FXrPpfq7zs2+ON0iokhBMrO4AdTwB269HTRU2Matzll4KHUsHv/Oce05WXIiZYb1+F1z4MtvA65TVDY=
Received: from BL1PR13CA0117.namprd13.prod.outlook.com (2603:10b6:208:2b9::32)
 by BLAPR10MB4850.namprd10.prod.outlook.com (2603:10b6:208:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 13:32:46 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::8f) by BL1PR13CA0117.outlook.office365.com
 (2603:10b6:208:2b9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.8 via Frontend Transport; Thu, 6
 Nov 2025 13:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 13:32:46 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:32:45 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:32:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 07:32:45 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A6DWjv71332727;
	Thu, 6 Nov 2025 07:32:45 -0600
Message-ID: <be8040c0-76b1-46e3-bd89-841cbfa10c84@ti.com>
Date: Thu, 6 Nov 2025 07:32:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add Aquila AM69 Support
To: Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Parth
 Pancholi" <parth.pancholi@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>, Ernest Van Hoecke
	<ernest.vanhoecke@toradex.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
 <20251104145240.61219-2-francesco@dolcini.it>
 <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>
 <20251105115335.GA14157@francesco-nb>
 <7024f4b3-00a0-4618-8bf9-53e305fcc982@ti.com>
 <20251106101932.GA5975@francesco-nb>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251106101932.GA5975@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BLAPR10MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: b71b65c4-3558-422e-0c76-08de1d38f8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|34020700016|376014|82310400026|36860700013|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZKdHcyNXd6NWxzTkpqa2h0RzFSdlh1cXdpSTVnbXBEbndLMUhMRzdVUVBh?=
 =?utf-8?B?a0R3cHlYdE1lS1FOQ1hvdVVjNU44VHlaZ1VQNGtGVmhTUm00aTVhdXdGSjIr?=
 =?utf-8?B?VVNIRWpMazVlcFFSTlBKTlhFaWs4SW1TZ1pkYUlTUHZBZkkvNkhBS2pGTTRh?=
 =?utf-8?B?Qm1NS2l4dWFHNk51YTRtRklwUDJPdTJjTGtPMk1jMGE5Y2FRTStuTDhFTmln?=
 =?utf-8?B?b0VxTUFGUVNDQ3FNb00rbzNVdnM4MnRlYXhnakNKRml6cG40NUZhQlFUQVVC?=
 =?utf-8?B?KzhUV3FDdHlVWjhZVldlVkk5dzkvY0Rma1MvQzFJMEI2UGtDSW40ZThxdjVN?=
 =?utf-8?B?U3VqUitHWU10YjRlc0ZKQkZyb0dKTTNXSUtXUUI1ZkdZUTNLTmg3ZnRWdVN3?=
 =?utf-8?B?eDRLYy9McFpWMmd1eDdRTWNtQk8rcHN4THh4V0JMRHpiMXZ2Z2daaTZsNTlk?=
 =?utf-8?B?YkhsOU9PQmNVanNmWUJ0NkgwTFFwRXdRN2k2SExvV2lNMlJUT3BWL3BjblI4?=
 =?utf-8?B?RnJJNXBCeFlMN1N3MlpUMFEwNGd3T2lmeFBIMXBTN2RacHRVWEs4Wk1pMXdK?=
 =?utf-8?B?OFcxcW5YUkRVaEtLRVEvV29MSnlmcVNUZHFJOW1nTWtvYkdCQXZXanR0Smh6?=
 =?utf-8?B?VUpMUjVzZ3h1aVZRQjI4cy9WTFM3bUdUbXBQaVp3OG1hMVQvSFhWWU0rMzhW?=
 =?utf-8?B?U2t0NFlJRHdUendERDAwRVdjbGVOWldBTHVMUGMyODVtME1uQ3BrRnA4azdm?=
 =?utf-8?B?WDhCMis1dmJsb0pNbzRJekpuOHJoZTVjL1RtcDNOUXdERDNSV3E0OVNTN0hZ?=
 =?utf-8?B?WXN0cHYzaWxhcmxwVVUvS2tBeHAyZDNxUWZNc0lYN0ZzWWwxZGdBL1FqQ2k0?=
 =?utf-8?B?WW82YUhyMTFZRlFoalduVnhBWGZlUytrdExmWUVkZHVaeFdoaUR3b0x1Z2tp?=
 =?utf-8?B?OEtSRWVuTHFkYXFSSkhPOTgxSnIvN0RxMS9xYUUzbStrdjUwWG1lS0dRZzZZ?=
 =?utf-8?B?bHZScVdXRmxuaGxkRk93anZWRG9kNEtxdFJZcWVNcDFKL2pjUElZU1djY2d6?=
 =?utf-8?B?ZGFNdUVIK0RyT0xzMEpCT2tPS1R1NHYzYkpWT2Y2TFlmQjhHR1AxbGgwOXJp?=
 =?utf-8?B?WVNJbEpud0xPS1E1Y1BBSWVUTi9MbldQc0J4cFdkN0o3bmoyQ2pTTW9naVdN?=
 =?utf-8?B?TkhjaWVHenQvd0o5cFlzMFNrL0ZpNXZCVFA5eVg1TTBnWVl0ejhib0JYMzdV?=
 =?utf-8?B?WkJ1blczT3N1Qk1DT2FLcTRkMjI4amZUNUlHQm5ya1UvQ3RUdXNZTlUvQ2Fk?=
 =?utf-8?B?dm9IdUZLQmd5a3V4aDQrOFkzZm9QbHRrWmZ2aUYrUmdySHJiQ0NlYzZFaXZR?=
 =?utf-8?B?SXhmcTNneGhoYTNRTUx0YVZlYmpiL2x6eUJJWjA4RlNETHdOQUJ5ZlZFMi9r?=
 =?utf-8?B?MXFKWC94V3RNbGx4NnJFMnk0Y3B5VlB3cUVGWXJUdm91S09zN0t4UVA5WG1r?=
 =?utf-8?B?S1ZTRmVRREtFb250SnVPMjk2elNzbW0wMWhNd2NFcVNUdE8yck5VSDd1U3Zw?=
 =?utf-8?B?Vk4ydHVNMk43eHF0bFBNV3B2VmZ0a2YycCtvRVUzeVZsdmovVTNxZmN1YjlJ?=
 =?utf-8?B?VkozUWl4UCtJbnlJdy95QSsxcWNOWUtqWXl6MEQ5KzJ1SGhNQXRwdmhEL1hn?=
 =?utf-8?B?VmVkUk1ndjJheGFkd0JZS09qa1FEUGZSZ0s4WDEzcFNJb2FHdEk2dU1WSk95?=
 =?utf-8?B?SXYrdFFFbW4zRVJMUFFCUXUrdFdLa2hiMWMycDdxc1RRS05LbDR0MVN1Y0ZB?=
 =?utf-8?B?S3RjTjJGbllOYnhGS3hPZVl3NjlvRUwwRkdLMVZTQkJLOVdRSU4yREZqZ0lK?=
 =?utf-8?B?K2hJTDZhSFV1RGFwYmwvZldwUEdwT25CWlFEV2RsMlRXdXZXdlNVSDZvbVcv?=
 =?utf-8?B?Ukt4YXRSWjN0dGhJQms3NlhVRWl5Rm1rWkc3NWpOZFpjaktGUDU4VXNoYU1n?=
 =?utf-8?B?eTdGMnJqR0txZEVid1RMMFJsekxpeUl0WjNKcUdHT1QxTEIwWEJHam04Z1F3?=
 =?utf-8?B?cUV4bDUvSTY3anlTQk9kcEkwWU1FYTg5cFVKOXovZkovRGs4VDdrSzdlRDNT?=
 =?utf-8?Q?bjmU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(34020700016)(376014)(82310400026)(36860700013)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:32:46.4736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b71b65c4-3558-422e-0c76-08de1d38f8fe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4850

On 11/6/25 4:19 AM, Francesco Dolcini wrote:
> Hello Andrew,
> 
> On Wed, Nov 05, 2025 at 02:01:35PM -0600, Andrew Davis wrote:
>> On 11/5/25 5:53 AM, Francesco Dolcini wrote:
>>> On Tue, Nov 04, 2025 at 11:41:54AM -0600, Andrew Davis wrote:
>>>> On 11/4/25 8:52 AM, Francesco Dolcini wrote:
>>>>> From: Parth Pancholi <parth.pancholi@toradex.com>
>>>>>
>>>>> Add support for the Toradex Aquila AM69 and its Development Carrier
>>>>> Board.
>>>>>
>>>>> The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
>>>>> family and is designed for high-end embedded computing, featuring up to
>>>>> 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (3x
>>>>> Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
>>>>> interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, and
>>>>> a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
>>>>> Temperature Sensor, and optional TPM 2.0 module.
>>>>>
>>>>> Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
>>>>> Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
>>>>> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
>>>>> Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>>>>> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>>>>> Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>>>>> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
>>>>> Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>> Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>>> ---
>>>>>     arch/arm64/boot/dts/ti/Makefile               |    1 +
>>>>>     arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts |  576 ++++++
>>>>>     arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi    | 1840 +++++++++++++++++
>>>>>     3 files changed, 2417 insertions(+)
>>>>>     create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
>>>>>     create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>>>>> index 361248dcfff4..6ce652fe98fa 100644
>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
>>>>> @@ -153,6 +153,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
>>>>>     # Boards with J784s4 SoC
>>>>> +dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev.dtb
>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-pcie0-ep.dtbo
>>>>>     dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
>>>>> new file mode 100644
>>>>> index 000000000000..c7ce804eac70
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
>>>>> @@ -0,0 +1,576 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>>>> +/*
>>>>> + * Copyright (C) 2025 Toradex
>>>>> + *
>>>>> + * https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
>>>>> + * https://www.toradex.com/products/carrier-board/aquila-development-board-kit
>>>>> + */
>>>>> +
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include <dt-bindings/pwm/pwm.h>
>>>>> +#include "k3-am69-aquila.dtsi"
>>>>> +
>>>>
>>>> [...]
>>>>
>>>>> +/* Aquila SPI_2 */
>>>>> +&main_spi0 {
>>>>> +	status = "okay";
>>>>> +};
>>>>> +
>>>>> +/* Aquila SPI_1 */
>>>>> +&main_spi2 {
>>>>> +	status = "okay";
>>>>
>>>> Why enable this with nothing connected to it?
>>>
>>> It's a development carrier board, the SPI pins go to a pins header,
>>> accessible to the user, where anything can be hooked up for
>>> prototyping/testing.
>>>
>>
>> Sure, and when a device is attached to that pin header it will need
>> described in DT with a node for that attached device and in that
>> node/overlay is where you enable the nodes you make use of.
>>
>>> One use case would be to just bind this in userspace to spidev for some
>>> prototyping/testing.
>>>
>>
>> But you are not adding a spidev node here, you are attaching nothing
>> but enabling the node anyway.
> 
> The idea would be that you can bind the spidev driver from userspace,
> without having to change anything in the DT. For this to be possible the
> SPI node must be enabled.
> 
> My understanding is that this should be possible, and it's the suggested
> way to debug/prototype anything with spidev. If my understanding is not
> correct, I agree with you and there is no point in enabling this node.
> 
> 
>>>> [...]
>>>>
>>>>> +/* Aquila SPI_1 */
>>>>> +&main_spi2 {
>>>>> +	pinctrl-names = "default";
>>>>> +	pinctrl-0 = <&pinctrl_main_spi2>, <&pinctrl_main_spi2_cs0>;
>>>>> +	status = "disabled";
>>>>
>>>> This is already disabled by default in the SoC dtsi file.
>>>
>>> Yes, known. Is this an issue?
>>>
>>> This node must be disabled, no matter what is present in any included
>>> dtsi file, it's a deliberate decision.
>>>
>>> This dtsi file describes a SoM, the used pins/functions are defined on
>>> the pinout, but this node cannot be enabled unless the SoM is mated with
>>> a carrier board that is exposing it.
>>
>> Same as my point above, you shouldn't enable nodes that are not used
>> or have anything attached. The SoM only has some edge connectors so
>> it should not be enabled at the SoM level, that we seem to agree, but
>> the carrier board doesn't connect those lines to anything either. They
>> just run to a pin header with nothing attached, how is that header
>> any different than the pins on the edge of the SoM?
> 
> You are commenting something unrelated here, or I am not understanding
> you.

Yes this was a bit of a tangent to the comment above. The point here
was more on the pinmux, as a new carrier board might use these pins
for something other than SPI, the pinmuxing shouldn't be done at the
SoM dtsi level. Instead do it at the point the node is connected to
some hardware on the carrier board in its DTS.

> 
> You commented that the status = "disabled" is redundant. We both agree
> that this node needs to be disabled in the SoM dtsi, and it is already
> like that.
> 
> I would prefer to keep the redundant "disabled", because I see value on
> not having to rely on what is done on any included dtsi, where the
> original node is defined. I see this as a common pattern in multiple
> dts/dtsi file and is what I would prefer to have (and I do not see any
> kind of maintenance  overhead on having it nor this being in conflict
> with dts-coding-style.rst).
> 

We do make sure to disable nodes in base files that are incomplete and
only enable them at the time they become complete. But if you have a
strong preference for having this redundant status then I won't object.

Andrew

> Vignesh, Nishanth, what is your expectation on this redundant
> `status = "disabled"` property?
> 	
> Francesco
> 
> 
> 
>> Anyway, the right spot to enable would be when you bind a device to
>> the SPI, which it seems you do in overlays[0], so that would be were
>> you set status = "okay" and all the pinmux info for that SPI device
>> and carrier board combination.
>>
>> [0] https://developer.toradex.com/torizon/os-customization/use-cases/device-tree-overlays-on-torizon/#spidev


