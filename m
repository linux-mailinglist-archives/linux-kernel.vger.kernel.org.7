Return-Path: <linux-kernel+bounces-895569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B9C4E4E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053F93B1BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCF305E09;
	Tue, 11 Nov 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RGJgSrwU"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D252F7ABA;
	Tue, 11 Nov 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869913; cv=fail; b=BI1uOSG8tC9jApGhL1YD6/tmIrN4Gs0pvZHdFDun/FPt1/09UNIb25dRf30mGXzFslSuql3wDD3hUXOJxknted7KIQpYLev3DEkINFMvQH0opCvXcNqxcbrXsieCcoTpSF/+mxuGio031djZG25fGvw/ZdPDRt1rRLRM1ht18S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869913; c=relaxed/simple;
	bh=u/MSfj2FwGb9vT7AVb9qLVF6OoRYMIEl6i/AUBhGM3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mZjrL2hHDqu46ySvI1FLcaXKO3pb0+kG/5Rb6XU8EbhJQZBeGgY4wgBTNr/i8S7BIFgeMoIRJVHhIzXD8Br+8o8kQCYKPp77af2Gnq8p5rhSy6yfF6VSbVhoNT7vx1nL/FqOdpakdaPE4tOE9sXcR6e3VVgrHq9y8deBgYzbCc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RGJgSrwU; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilBmPaQ499S6bzhJ5JvtNYfNVTu9B90S/SvKmMQjz3jJXVk6Zj+tmYxvTpEsvpJ2PryWcpVn2IQuxtUoZhuxwL+18J9UVLLibz2RKV6KAu7ua2YQSksyRhljxFGY2dXH0WbYiRmXZy2+rb/2uXrUz+O+RHTA+JhjdJ1BEhzuZ3+abplUesTcWXQFuNx4evpZlz5qO4RdKDYw/ieESf/jMyT+jd5GhUSKBR1PZguaggQ5HtCvP7bQE4EAdI7cdgVmx2lyLbM/XQOyjJokFGKEB52c8yAMbOVN7BXKf4EtvT8MlY1hY4nhm0F0iQX7v4yuNckbpT4K8hAuPduGuJTecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SX89cgTyop9Hper2/LdMewSbOEIih4+JzUOYBUj98Y=;
 b=dsMvgO8b/56nR6x+sKNcHLnpha58cM3DlxmyCNJR2CSSnGMe/j2xTfqz8UEszUeaYCLqeklV9uWLBzdjMv2iYiWQq6t8SBQCWNHMsHk3MUWJNPMYzopn6OwObHIbTQJ6VasNXaqD6OoIC2w1Qstt5fvk9b8HZD077xzfUi0ZVuV100xwGuBUg5P3svHt6fLrcptVGeHbOVAKWue3uSg4VsUoMGOgoRrQD349tnIk+ZclvfS3U7bkp+cSItCiIBEfAKp0NWQkLDqBqMyfD2Rn84KWVE+Gp40zwme7RyCFJTqMNPrgEwf/9zkYpgJ0uno6uh0oN72TXXtGs52wlhobaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SX89cgTyop9Hper2/LdMewSbOEIih4+JzUOYBUj98Y=;
 b=RGJgSrwUkTojTf5fj/CDbiCqRYZsp85Fs3ExCXOUPQpigtVsgSD1om2HQS9K6z4LRgWEtEhBZsacSfnDIRLapG6HFWlZnXk9n/GKVvUePgBVXU0da72gJFUwIhmgkKQ63IphKnb+T3p1EKSJbayIyL7xU/9rR4MfpZE0iACnDwk=
Received: from SJ0PR13CA0227.namprd13.prod.outlook.com (2603:10b6:a03:2c1::22)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:05:05 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::cf) by SJ0PR13CA0227.outlook.office365.com
 (2603:10b6:a03:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 14:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 14:05:03 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 08:05:00 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 08:04:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 08:04:59 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABE4t2s1015636;
	Tue, 11 Nov 2025 08:04:56 -0600
Message-ID: <173b8b67-b077-4ec6-8bd6-1683ad28e2dc@ti.com>
Date: Tue, 11 Nov 2025 19:33:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add Aquila AM69 Support
To: Francesco Dolcini <francesco@dolcini.it>
CC: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Parth Pancholi
	<parth.pancholi@toradex.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Emanuele
 Ghidoli" <emanuele.ghidoli@toradex.com>, Ernest Van Hoecke
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
 <e1b2a13d-fab0-47f1-aae3-f2661c94d54a@ti.com>
 <20251110094716.GA7356@francesco-nb>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20251110094716.GA7356@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|DM6PR10MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a94032-a0ba-43be-89ed-08de212b4f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVlER2JFdDFXMnoybSt2Z3VtUy9XTFd3NlE4b2hOb1c5eE9KdFpkMmZiK0NB?=
 =?utf-8?B?SlhlQ0dKVVRtcE1RRGJKMEJuSnIzMFUzVXA1eTZjOXhJYS9yYmlRNEc3L3k0?=
 =?utf-8?B?Uk0wQlV6amRwVCs5RFZ1b1A4ZUViUWlCMjVwY2lrTlR3OXd1eWxIVXVKSmFH?=
 =?utf-8?B?NitCUjJnYnh5TGxwR0VGVWxocFFaSUlsdEhEb0RXVzNYbjNicmltSXVqUndS?=
 =?utf-8?B?V3N0M0paMG4xK0dNMWh4bGZwSnhXS2hicS95bkhkbmVvSFA2cUNWOWJMdENu?=
 =?utf-8?B?TFB2YjlOZ0RPMjRCWVJ1N3Z3ZE93Wlhmbm43bDc1VXhXbytnZzk3OEdQT2FK?=
 =?utf-8?B?M1ZLNDh2RlVxVmkxNnJuK3MwNmNnMXgrNlQ3WGlidGRJamx5eEpNYlg3Q0FG?=
 =?utf-8?B?VzRRYkVOMWhzYUxWbDJrWmluNi80c2twRmJzalN3bjdyNVFDd2x2KzMyME1Q?=
 =?utf-8?B?bDdIeGxtTlBjV2QvbkVwVzFVZTRMVXUrbVBHRklBV2JndjZqUmhQRWl2WjFq?=
 =?utf-8?B?RlBZckliWEpiamJ5WElPZU5ISDRDQ2VuU09YSkFjdFd2UG1FYzdQY2ZDc2Ur?=
 =?utf-8?B?b2tGUG5lZ3lRc3hLZE8zOXNBcWY5SEpvYjRoOXBTc0ZzYmIxU1ZiUm1iQkly?=
 =?utf-8?B?eFVVMTQwSDN4UGo0MHltbXFBek5mYnI3SHkxVGJSVE1hUitmY3NvOUZtYXZH?=
 =?utf-8?B?UjRKc1dMMG9laGMyb2YxZUt4M2p1eGtuenFIMmhGdFRCR0tHY0xHT3ZuZ2R3?=
 =?utf-8?B?bk9Hb0FFekl6V0g1Zm01WkdVVklybGdQNTd1ajc4RzN1N0haT1hqTE13YjRH?=
 =?utf-8?B?N1haMDRKUGhVU0Z1cDBnY2sxdllWS01abEhCb00vOTZac1BlczlqWGdCUDJj?=
 =?utf-8?B?cjVnSTdJNGJnV2J5TTR4SVJ3Y0d3RFJvK3U1eGIvSis1a05Gc1VZWURKM2ZS?=
 =?utf-8?B?Z2oxcnlpN3pwMXlwc28wMHF6MXJIbXd1b0t3bnhIWlF0TXJ0ekl0aDhidHRt?=
 =?utf-8?B?VWl3R3htdE1QVWpCUDBwalYwWFFlQUd1bzJSMVJLSkttdldleU5JT3psOXhQ?=
 =?utf-8?B?NTA5YnVVenJBVDRWb0I2eUVYM1pHVzJjdnlkRjFrUlk3N2s1MkxnUUl3WXVS?=
 =?utf-8?B?NENHaE1ISkFWUytlSU9iRzNXZkdSRzFIYjk1UlFWa1lpTlMrSGpTMDRWUnhr?=
 =?utf-8?B?WldtaUcxN1pQSDNFa2ZPOU9jdDFMWFoxUExrZVA0WnhFd2pkWVFnMkswUUxq?=
 =?utf-8?B?QnVoalZUVllqM3hIS1VZbVNTOUpQS1Z1MGhwL2pmL1VRczB6VWFIc2VKZVZ1?=
 =?utf-8?B?b1JPN1ZaSzNtRWNySEZ5Ly9KR0VMZ3locFQ2VFJtTFlKbFF0ZTl1ZEpTcW90?=
 =?utf-8?B?ZjJZc0VaWlRrc21qVXlNS0dsRXZBbjRLSVYzSDRPUWYxNVNyUVFWTmQ3UkhI?=
 =?utf-8?B?b1llMHMzNmlaRU04K2NXZERaS3ZiQVgyS3BEdFZNUFRYMXlXTXRqdFlDL3dv?=
 =?utf-8?B?cjdWejRuMHFyaXg2V1RieFpRelV6K2poek51TVcwVVJmU2M2UTdjU3RhMm5Q?=
 =?utf-8?B?SUkrb1RsQUVIcEU0SHpyUFdvTGxpSkJGUTU0TzBpenNyRWhoMzFvbmdBRGNr?=
 =?utf-8?B?NnJIaHZ0M0VSUzVWNkFpckQrTU1pNzNrNkJtYlhOcDBMNE5nUmphZzdBcWlH?=
 =?utf-8?B?NTZlTE91YVd5WGJBRmY1ZWNFbnVJTFQxUDlPS2ppQ05xbGw0bjdvaFY1bGNh?=
 =?utf-8?B?THRpRFY0cmNGaUZaRzBhZ0JxSDdsZWZrdktOUTdXb2NQOXkreUdFS1lhajhD?=
 =?utf-8?B?NW82bko2T3lvVG5LQnNabVl4TzZTNEFKODlMeVJnSG5mWGtBTlhGK09ubnJs?=
 =?utf-8?B?UFNVY1FoQXptMTRXUU5nMjNsanlPOTZ6bnd6UnVhcnR3ZHd6VmVUMkxoL2pR?=
 =?utf-8?B?b28wZkdJa3hBaklWZWdjWEpBVFFJQmNBb0RrNWZVdDNjVnlSVytTS21kaVNi?=
 =?utf-8?B?eWZNcExOVUhRQS91c1VPWXdZckt5UnN6Tm9aV0pTaUZmS0Y2cmYyR3dDNlBD?=
 =?utf-8?B?eC9qZ2ZRZDZTMHM2WHZCVGVpdk1pN0hLc21leWZhZ1kyR3pMWGhsbHNYS2JF?=
 =?utf-8?Q?Pjok=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:05:03.4709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a94032-a0ba-43be-89ed-08de212b4f92
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332



On 10/11/25 15:17, Francesco Dolcini wrote:
> Hi Vignesh,
> 
> On Mon, Nov 10, 2025 at 10:06:58AM +0530, Vignesh Raghavendra wrote:
>> On 06/11/25 15:49, Francesco Dolcini wrote:
>>>>> Yes, known. Is this an issue?
>>>>>
>>>>> This node must be disabled, no matter what is present in any included
>>>>> dtsi file, it's a deliberate decision.
>>>>>
>>>>> This dtsi file describes a SoM, the used pins/functions are defined on
>>>>> the pinout, but this node cannot be enabled unless the SoM is mated with
>>>>> a carrier board that is exposing it.
>>>> Same as my point above, you shouldn't enable nodes that are not used
>>>> or have anything attached. The SoM only has some edge connectors so
>>>> it should not be enabled at the SoM level, that we seem to agree, but
>>>> the carrier board doesn't connect those lines to anything either. They
>>>> just run to a pin header with nothing attached, how is that header
>>>> any different than the pins on the edge of the SoM?
>>> You are commenting something unrelated here, or I am not understanding
>>> you.
>>>
>>> You commented that the status = "disabled" is redundant. We both agree
>>> that this node needs to be disabled in the SoM dtsi, and it is already
>>> like that.
>>>
>>> I would prefer to keep the redundant "disabled", because I see value on
>>> not having to rely on what is done on any included dtsi, where the
>>> original node is defined. 
>>
>>
>> One can always reverse compile the DTB to see if a node is enabled or not.
> 
> Sure. My reason for having it explicitly disabled here is not to have to
> depend on anything that is happening on the included dtsi on this
> regard, given that we really want those disabled in the SoM.
> 
> See for example https://lore.kernel.org/all/20251015111344.3639415-1-s-vadapalli@ti.com/
> where you can see that our verdin am62 was not impacted by this change
> at all. 
> 
> To me this is just a benefit, without any drawback.
> 
>>> I see this as a common pattern in multiple
>>> dts/dtsi file and is what I would prefer to have (and I do not see any
>>> kind of maintenance  overhead on having it nor this being in conflict
>>> with dts-coding-style.rst).
>>
>> I cannot seem to find any precedence to such a pattern (adding status =
>> "disabled" for nodes that are already disabled at SoC level dtsi.) Could
>> you point me to some?
> 
> Just a couple of examples, you can easily find more if needed
> 
>   k3-am62-verdin.dtsi:&main_spi1
>   nxp/imx/imx6qdl-phytec-phycore-som.dtsi:&fec
> 
> 
>>> Vignesh, Nishanth, what is your expectation on this redundant
>>> `status = "disabled"` property?
>>> 	
>>
>> Assuming such pattern exists, please add a note in the commit message in
>> the next version.
> 
> With that said, it's a small thing, if you prefer me to change it just
> let me know and I'll send a v2 with this changed.
> 
> Vignesh: do you prefer a v2 with a mention in the commit message on the
> `disabled` node, or that I just get rid of those? Anything else that you
> spotted on this patch and that should be changed?
> 

Please send v2 with line added in commit message.

PS: I fully except someone to send a patch cleaning up all the double
disables without knowing the background :)


> Francesco
> 

-- 
Regards
Vignesh
https://ti.com/opensource


