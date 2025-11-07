Return-Path: <linux-kernel+bounces-891134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27FC41EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F104E3C24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F33016FB;
	Fri,  7 Nov 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RSSVXxRU"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232963009CB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762556892; cv=fail; b=o6o3N0W5YUfk08f50aaTYuuHwvz9t/92kz+3Rwuxx4RCqOUS2bpyUBVd183Yf9xj1re4PELMcco6CQDWzJQC9535ePLoCqG7vCuncEj4m2EKWGTUcQIyLRg0dK8P+tBPB97OhJb7ksiKc4ZW4YVjkcocxnmk5hizF4QmV+9zSIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762556892; c=relaxed/simple;
	bh=+w+ZBiaP+4/le4S5UzZ9w0seNNZ1zsXejW3hrKaabvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfXf0ZNcmnQppkuLFTV29x28oLWO7Lj1lU0K//tFE4tIEqY1Jddu4VsEgmwPpuc0PeFIcevXKvrMsnsD6LAbOwZCExcahH8qf4H+PXdxe04xKJDFEr/nfsze9mMLtnsLixYqZRPk8VG7TBpuPfiwldeyqmLZAakMJvavZBS39P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RSSVXxRU; arc=fail smtp.client-ip=52.101.61.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUVac0lbE8QGIw7dNWf73zIDdt0cb3inCd6YkS+5bTYapGJk6RFkRyouHJIhV2z2cGbVU7kHzPyhze193gWFQJyZEW8kjMtj1O6AKSeRQjCZj4h8EDn1WVtnuOuOK5kqu276Jfj5XAzSWCOH6rbnz5UvKjXaULCsAp7588tdzf6/ouuQfvOrneBKcIPuVi5pBJ3PVmjxhKtbd3qI40LSn9VDA4mSBrgd+czeIOAFOvlbVTxkZr7ZH8Rpmig7CDzx/p/WdS84X4WVQ76f21GYD8IboiTViy64EXBgZ9iIWttYgEUGCobJmBMIWyuq0dZcbzsjute5L+vn8r7Z043jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqTcIJk2cwk254kf0yf5ubfR7XknyWT1db8Wnf3WqrM=;
 b=rm/ZMkDUqsHNX2rBzGbdm26dGWmt0nFFm1bE19rlw1koixjFYUuXVYfDLZvwGBeZcKn9f6J962X7joBTqEzobrBOcPpp6jE+FMzUy204NzE/4SUV+DXbIEQ1jLvnSUtFg+xunejItk0ShZBn3H2fCPWrfZSJTyAAluF1AwvTcaDw86TwX2efSZ7p4SB8cUGQqv9pS1uagyRYmBKGucDU6NJrzPzQ80OxR86qxqKVWPg2ChEf69NWtabDRfjIXMo4I/TyB3D9x0x0FxPVkG7hvpnTBiVAiTH9LfmacTnSciASKQr9YiysiTjK0j3t+HLFS7QpQUr+xZKiNvzhnJm9vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqTcIJk2cwk254kf0yf5ubfR7XknyWT1db8Wnf3WqrM=;
 b=RSSVXxRUSP/5hfLjO6vXIrAzGyeWb3Zn3EDIWFawHJTxof6TZG16P/975Dw8RwkyrvLNlQa47NPhbwAUnP8M9GmRnCA7ltCaT9JLBWx+Joc0r2MFHF7G77+oWaX1Yv+ZZBuAVRK3jkUfUJj6srUBV7fLJPIcfcitvK+mruIaui8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by SJ0PR12MB6928.namprd12.prod.outlook.com
 (2603:10b6:a03:47a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 23:08:06 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::e4da:dfce:19e5:6405]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::e4da:dfce:19e5:6405%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 23:08:06 +0000
Message-ID: <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
Date: Fri, 7 Nov 2025 17:08:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, babu.moger@amd.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:806:6f::28) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 127ec639-f958-4f6f-b412-08de1e528275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlNjVUdNMHZ1MHlsQ2M0a2Y2eDVPdHRMVWJVbG5mN1h3UUJQQTBJeVc5L29N?=
 =?utf-8?B?L20yTkpvZ3Q4RElpTk9HSkhJV05PaGFKcm54NjdzV0RTemllZk50TzU4NzRy?=
 =?utf-8?B?K3psRzFab3JoRFlYa09JTXlrbzJZSlF1R2JJUkpoK2FhS0JFa0h2QlNNYVFE?=
 =?utf-8?B?eWhac045TkF2RVZuT2I1NHEvSVNnbkQ2a0sySTlwQXVlUWNCN0NiRkRLTnZi?=
 =?utf-8?B?cjl4azM5Z2FLaFdlYjN6TENsUTQrUXI3ZTZxU05qd0NpTHNPZjcwUHVvd2pX?=
 =?utf-8?B?ZFNrR2FpNnA3U21Jb2NSWThhKzl5Q1NCaFBLNEx0R1FZTXhwdENLYTZCQmlC?=
 =?utf-8?B?T29qUFN2Zk51U2pFaS9wWGFtMEVJRytmekdKdys5bGtGQmFHVk16SGZBdStr?=
 =?utf-8?B?RUV5MjU3aGd1bVo4RWhZVHJUQ0wyY0lTY3VlNkZYcjY1Z2IxN25GS0tsMERn?=
 =?utf-8?B?aDZCMlg5dmN6VUdkSmh5TGlETUNMbEdDWW9hOEp3V3NkU0EwQUVXTnFWNElI?=
 =?utf-8?B?aXhyV2UrQ2JidlRISGhsNUdEV3pvTXFwdzE0aDZvR2lzdW5ucEE3RjFWK2Mx?=
 =?utf-8?B?aG1ObzZIcm1sZS9qSWJqUEh4MEd6SmN4bEdlalRrcjRwRCt2KzBxVzVqSEo2?=
 =?utf-8?B?RmUrT21NRkZPMWlBOGQ2RWVOZVIzcVVYdnBieDJ4djJIUUgwQnplK3RCTTdQ?=
 =?utf-8?B?aGFmTW5kMkNzSDBqYTRESzl4L2JadkhoVWR1RUp6KzVyRG9Tb2IwMzN3NS9v?=
 =?utf-8?B?YWJWYkpCcGxIaWpZOEJXUzhyUmY4OEF0Z1c4NXlHSG4zNVR1TjVucTJBQW9F?=
 =?utf-8?B?eHVrTk5LNU1aMGN1Z0NyYlgraW5GbFdXMnZ3MlFDTnIwR1JEK1RQQUJFNDFY?=
 =?utf-8?B?emE1YUhYQk1PZWJQSVpsYmVKcVY5YzV0SWIwbm1iYnJQM09EREdZaURpWUJQ?=
 =?utf-8?B?NWdISkdwQjV3WWVta1RpTmVyWVcyaDIvai9GaE9kMEo4cWZiWXNMc3N3dEJo?=
 =?utf-8?B?WVV1dFZIVkhRRmhOK1ZqVTc4WlFjUS90ajF1b2JIWGFrZThYUEM3REJ6YVRa?=
 =?utf-8?B?N2NuaGRlWUFZWmxRZUNvNDgwV3p4T1BndE4vTjlMNXlpYnZFTG1JbXhLRU9D?=
 =?utf-8?B?ZGJiSWNIRFQzYTNaWDJtSmpwYndtRGNqNUl2R3haN3FibXlrWlBKajJoa1ZJ?=
 =?utf-8?B?eDI4MGR2OGpvOEhJdTh1ZXFnUmVGc3AvSzVFM1YrU2llQm01VFFBK2FIR2Q1?=
 =?utf-8?B?MGhOb1Yyd1Ezd2lUbkJXa0Jyak9malhYNmIrTC9vdWp0Vi9wUlZSNXhvcGhs?=
 =?utf-8?B?dUR2T3JlZ3dOUlZ4N2NRMS9YcWdQS0JnRVZtdFZMSnBuMEE2K1I2aVBKVkF5?=
 =?utf-8?B?UldaQTZnNDJ4c1FnNWdERUxCTWlJVFJkU2V0dVNZRUVzUFNaSWVmZktYYUFp?=
 =?utf-8?B?UTE5NDJIdnltcHJCMWxzYmhTMGk2K2JXOGdIdWREYXhQeEE4d01oMTNWcGFx?=
 =?utf-8?B?NmpyMW9QNHhqS1VNam9BYUdpL0RoOUV6QlJBekE2RmcyNE4wRCtER3lMVkU3?=
 =?utf-8?B?a05SekhhWlVCMHhUTGlPdFZiM0NzLzRmL1dNb25ZUlFCeEh0NFNCZ1RFYW9k?=
 =?utf-8?B?OExVeEd1WnBlMTNFZVQyeDZMdllWS3VoRzFYSjFJWXJjMHVBRzNwWnh5S1FT?=
 =?utf-8?B?c3M2MGVQZVV4czIyVWhlQVdURXlmUVhDWHdkaXV3M3k4eVNnUlFNZ2VGd2Qx?=
 =?utf-8?B?S05CMHd2WXZZTGVEMitBQVJkYmFJMGR6UU44Z1JZd0plVHMvWXYwYnhSazJs?=
 =?utf-8?B?c20zY0Q3NjdnbndZWWttVktPeThCVVF5UTdQbXpJdk9Cb09lcU9iUUtiYzJH?=
 =?utf-8?B?UGttb1RQTUV2b2FFY3UxWjlZTWk2emQzUG8xdFg5QS9IUXFZazBEUDg0Rjdr?=
 =?utf-8?Q?FQIDPs63XTFYAEo5YVd7jn51Z0a6rsAY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1RVUE5uU3UzUGwvTFdWMzdkbVVlT3FzeTY1a05uYUVhVHlESDZ2UDIxTDZY?=
 =?utf-8?B?UkZMeHl6RjlKaERqOHZxbkF0OGtUbDA2eGVEb2xqWnlPd25Tb1BrY251dW9K?=
 =?utf-8?B?VDFZUzBDZy9nb3RzOHlXTTZDdzd3d01EUXNHUVBWSFBZRkkwWVZnUklqS0Fq?=
 =?utf-8?B?cmZsd1JIZ0VFdHdGSEhPTUk2Q2JjTzdVWSt0cE1xMlFaQTdzNjk4eHV6amU2?=
 =?utf-8?B?dnEvOFA5MzAvamhTSzBwR0xaUldHSTRiS0dvamxhNm8ycjBBR2tZcy9ZNTh3?=
 =?utf-8?B?aXR4RlhnSy9NL2JSUXc1MVoxbmhKWS9seXc5Rlk3dzJRbm5UL1ZLTW1tMzJV?=
 =?utf-8?B?U0tDbkhFTWRMTXkzWDVJOXQ1ZDNhcmJxc2V2VnRuZVRwcmU5OUNZWFFQcklC?=
 =?utf-8?B?OE5OWmVsWHdQWGdzT2IvaVE3bmpEd3JJL0sxTTlBcmRtbWpDZ2RmV2FFNms0?=
 =?utf-8?B?bWRQZVhNVVpVWWxTWWZrK3R5Qk5IeCtCaElZS3ZTMlErRExBZWVsN2kvT1RX?=
 =?utf-8?B?MTZ3NDFKejVJdEVCVm1RQUovK3pVd2doR3I2SGJIcksvcmpHTlBGV3EyQVJl?=
 =?utf-8?B?YmwzWG1oSmY1OCt2bGE4VG82WFhwZjVQQ2dMTGt5bzRlaDJ3djhrZnRBS09G?=
 =?utf-8?B?a3BjNFNBM3JDRDFYQzU5SnN6YVQvNURHVS9NMWZuZnZEdjE2b2cwSU02R2tx?=
 =?utf-8?B?eUNJYjlzeGN2Q2hUQTQ1VlFHUEMySjBERGJSN3pQMUdPQjlYMnVNY09pN2pq?=
 =?utf-8?B?RlBSei9xUzl1enB1Y2tnNDRzVVQ4Skd5MXNkSWRXMEZwVGJKaEtPUGNRdVNn?=
 =?utf-8?B?ZDJsbGQ5RXo0djR0ZlZ4Zm4rSjEvWmp4THJGMVZVV1FPQ0pQejhaN0N1RnZP?=
 =?utf-8?B?UkpLS2JOK2JPb3BLVUlNbEJkWDNBbDY3Zk1xQk1TbHJMRGlobFluMEVLdEM5?=
 =?utf-8?B?cE1nN281MVprUFd4MmY2TURDVC9uT3RMYlVCall5bExWZFRUSUhMRTJQbzhO?=
 =?utf-8?B?QU0vcUtMTDdqWnFFcnN3RFNBR013V3plaDhpdXg5dVdOSUxxVmx0Y0RQTkJi?=
 =?utf-8?B?RGNjVjYvRzNHcTVuSEJkRFl5dDhob1U2cFdTYndoM0padVo2MFFSMUhHbUw1?=
 =?utf-8?B?d1dOVC9ld1poSkdPUUNidi9RMGY2YXN5dlA3WFdVYWs3cEthay9PZUJtSU5a?=
 =?utf-8?B?aUFUcHR0RmdFdFlDTll2T2pJbi8zVklqNnBFR0ticmhZNHlZSVArMzRXMXF6?=
 =?utf-8?B?dXVZRS9pSHgwRktxSTY4K2RnK1JSNXd6SlRUaEVxK3pJQjNFOWZPNkRJVjU0?=
 =?utf-8?B?dnkrTnpmUm8wMndXRFJKb2x3Kzh2VUJ5OGViRVVaRy9Sd3B4Vi9zSms0Mlpi?=
 =?utf-8?B?S29XUnBEbzVteVJTOUozT0doaTVFRklZc0QzaFpwcGs5WXJ1bjVXVkh4dWJh?=
 =?utf-8?B?bGptVUNtMCtTTWdKdE8vdENRZkM4Sk1rdUFHcHY3Zk5OUHBjb0NsTWltRndU?=
 =?utf-8?B?ZkRJMTJlWjNKZWw0ZWZPL1REQytES0FpaFg4UkJVTEtsODlEQUNqb3RaVzJy?=
 =?utf-8?B?clFRdlBtKzZJdEpvVXJvVURDcER4VDk3Q0tXZTIxWkpPdmZYMXdpZHc4clZW?=
 =?utf-8?B?SEtQaVh5eXFoalpYclh0N25ZK291SXhOQ0x4NE5BajRTSkZFRVkzYzIrVUhx?=
 =?utf-8?B?ZSs5S2JkY0hBM1Y5NTNnMUVha0lGZzFBYUUvaFNWQjJyekZNUVFGblpmVEZE?=
 =?utf-8?B?cW1WY2J6d1cwUUZSVEoyZ1dpNjVDSW1DcDdsL3hIdUY1U2E3NGJSL3pEYUJI?=
 =?utf-8?B?a3AwVDF3Mm9FL0JES1dscTVQcFZKVnBKbTVqUXFPR0FQVEN4MkNJdUEzOXdl?=
 =?utf-8?B?QlJxSGZmQ3JWcW5QeEppcFZoTVpqTXc4QWxMeDlrWi9GSCs1MjdIeWZnbjda?=
 =?utf-8?B?M0Y0VnRBZmxLdGpzU01VNkhoR0w2SEk0bk94ekE5UnhGR1lxSEhtOE1HSnV5?=
 =?utf-8?B?YXphUWl4OFhIVVltRDZkN0FGcHFoYU9iM0xNQWRORXpFUzJOVzlCWU9FbXZZ?=
 =?utf-8?B?MTFFVmtsWXNjeWRBT3VhaTBNUndLc09zcEpyWnR1UkhsbWk2WkJBRFZtREdj?=
 =?utf-8?Q?OQ3HCkq4he4bJ6SvLzYnqnyHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127ec639-f958-4f6f-b412-08de1e528275
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 23:08:06.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eOHirxsSBLFudLqjJYCOqcTi1zu9hqo4t9GIfIzJ4tGOvKV7168YEeVMUlcS9AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928



On 11/7/2025 4:25 PM, Aaron Tomlin wrote:
> On Fri, Nov 07, 2025 at 04:02:39PM -0600, Moger, Babu wrote:
>> Hi Aaron,
>>
>> Thanks for trying the patches.
> 
> Hi Babu,
> 
> Thank you very much for taking the time to review the patch and for
> pointing out the efficiency of the existing interface. You are correct that
> option [1], echo "0=0;1=0" > io_alloc_cbm, is also accomplished with a
> single system call.
> 
> However, the primary justification for introducing "io_alloc_min_cbm_all"
> lies in abstraction and the knowledge burden placed upon the user, not the
> system call count.
> 
> To successfully execute option [1], the user is required to have advanced
> knowledge of the system's current cache topology and capabilities:
> 
>      Domain ID Knowledge: The user must know every active Domain ID (e.g.,
>                           0, 1, 2, etc.) that supports the resource and
>                           manually enumerate them in the write string. If a
>                           domain is missed, it will not be reset.
> 
>      Minimal CBM Knowledge: The user must know the minimal supported number
>                             of consecutive bits that constitute a "cleared"
>                             state for each domain. While this is often 0,
>                             relying on this is not architecture-aware.
> 
> The new interface, is designed to abstract this complexity entirely. Also,
> applies the hardware's guaranteed minimum supported CBM (based on
> r->cache.min_cbm_bits) to each domain automatically.
> 
> This unified approach provides a robust and efficient mechanism to
> guarantee a full, architecture-aware reset across all domains, eliminating
> the need for userspace to parse the topology and construct a complex,
> domain-specific input string.
> 
> Please let me know if this clarifies the motivation.
> 

No, I don’t agree with introducing this new interface.

These settings are intended to be modified only by system 
administrators, not general users.

Administrators are already expected to have complete knowledge of the 
hardware and corresponding configuration details. They also typically 
rely on benchmark data to determine appropriate settings.

Additionally, this approach is not consistent with our existing CBM 
setting model.

Thanks
Babu


