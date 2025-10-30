Return-Path: <linux-kernel+bounces-877863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7AC1F359
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F1A03427D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E79341678;
	Thu, 30 Oct 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="srrV5rM8"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012012.outbound.protection.outlook.com [52.102.136.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50A341AA0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815559; cv=fail; b=LorENTn2DRmxpelibCLPPSz6blpxiN72H/2CRjI3l9jBr9rPNHQ0xHzPij+C+hNsiGU9wnz/cqq62q8ZQhLHvL4J+FXj+8ZI/3dAtzcWzfwQwTsnw6e1hepRequflwucBf+hjABRRghZpSL+V4BMWxpmOLtoi8hFS08nEbx+IIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815559; c=relaxed/simple;
	bh=2eF31DMdkQ+E9kCUsVymveiVZ67ncbpWyUdZKgcsxcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qtuBgaB9J5fbL7kpQlnHvk4gQflhaWrbT8yZpzx5JKtIU+ISs2DlsQUmT4qmkDL7L+Y+Oo8z5QgASdoIiwzngRJoZLhuEpdeQUbSaxHryu5B+nwUS60Diy7Vboog4ftz9WAijBVWPh8Gaw7NWCYG4TY0uzJbOONtSbz3qs5gcHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=srrV5rM8; arc=fail smtp.client-ip=52.102.136.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6kzoxGFoIcS6rVWuAhc+Nphtyl/FT+IF1kTKorB4fClwC93M2j+G3/8JUsf2oGn2FASa/R2g++S9/THXT/9D1+gy1ZqS4Uy2AMImUEWo5MjRlRFtwXhvwLSp65opQgnijPKq4lLdYdPrn2k/Ef6tvjY3yFZoKITiORHb9zgOb1j2hnnI2TqTOzNMH4rdD0QltJp+JJpzXiNytxs5faHAQKTzygTEuaFm/HSwE2PqwKzevBj538tWTTlw7SuwPc+BLmnLyPpMxGlQp93XYTP7/R/8VmK6EngndEucToak7Lr70PfkkF7tdedxOQ2QeTaaOL39MeV3nU2J+JTeNxsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBgIpCorgg6gTdvVgEptXqZYqllESIQp72nYJmjHGmI=;
 b=ViU9Qzs1vof1wSettf8Kw6lfcVl9CRTk+gFdVi6DQ4RN9meeXTLqiqby4zPBscgGJKhKBvraNV1ExhLti//klplQ0cdKcVRzSBOk8LzT9lIP26W3F2rMcvqt6sKlxAuKQaJNB3gPXpq+RFcJGQ2ERhWvOVo+17nXKnGfnqMginA/emWU0wZLY5uPyY++TbAvF0phT4C5Ffpy5Trb8/NK+tiZAmF9Z+wjoxxJ9iKBk76YUlk53mqdoE6K76BEr2OjnnDtVtwYFr4CIXfLiIFSlT34iEK6E487T6Xu3CkasK365OkIL8pnJLK6xVLKtM1ergtHuEzb5amUI/0ZceVklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBgIpCorgg6gTdvVgEptXqZYqllESIQp72nYJmjHGmI=;
 b=srrV5rM8EpqOUeFk0T4biLGLHtYPiK/Okuqk6aZKovSEl+J359GdUcHDB3p6aseBFZi/XagkZ/3KzLKKHQn/X6HWmtZWT6bUWP8Fq40AUo1UkpNruLsQzXp5gd/5Zq7bPwmEduf1kCcGtMO1KVYxAPKc+UXFWNPwP7HQ86Jew7A=
Received: from BYAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:c0::30)
 by CH3PR10MB7986.namprd10.prod.outlook.com (2603:10b6:610:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 09:12:32 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:c0:cafe::c0) by BYAPR05CA0017.outlook.office365.com
 (2603:10b6:a03:c0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 09:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 09:12:30 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 04:12:29 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 04:12:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 04:12:29 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59U9CQH91889942;
	Thu, 30 Oct 2025 04:12:27 -0500
Message-ID: <eef22cd5-c474-4144-af95-e306b701975d@ti.com>
Date: Thu, 30 Oct 2025 14:42:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
To: Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, <jassisinghbrar@gmail.com>,
	<linux-kernel@vger.kernel.org>, <hiagofranco@gmail.com>, <u-kumar1@ti.com>
References: <20251022102015.1345696-1-b-padhi@ti.com>
 <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
 <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
 <d8662d13-40bd-053b-6761-1a0ff7404782@ti.com>
 <abec6709-b9ef-4f33-afbd-eeb69a07b941@ti.com>
 <da788554-1962-4fca-8318-278e9224af59@ti.com>
 <20251030085912.GA19297@francesco-nb>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20251030085912.GA19297@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|CH3PR10MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 768705c6-79c8-4077-9964-08de17947488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGY0bHk5K3VTMW4yc1NncCtiMUpQQ0NDcEtOV1VnK01yVHpjRTVJWkVneC9t?=
 =?utf-8?B?RjJSbHNWK21vS2pIZDNXbWp0Vk1OU2JwOEd5eTRzcktFc2NlSUwrNVBVZFQ1?=
 =?utf-8?B?MHpVbXhwa2piRG1McStEZVdFTGdtcjJ2YU82ektjV21QU3JQcnZCa0hISU1C?=
 =?utf-8?B?ekFsSURaVHloclgyakYyVWJ1ZWV1UjVNS1duaVl2RDJzbytZSzN2SDNBaGNI?=
 =?utf-8?B?WTBGZjM5d3ZHY3lKZW1ybmQ1ek5OSSt2cmgrd3Rxa2F0N1ZBSjBxaWhQK1Rw?=
 =?utf-8?B?Y0VZYmRwNkFPNEcwQXBWM1U0VGtkckpRdW5jNkJTUnNFcmlJQUU2THBUVWFz?=
 =?utf-8?B?Nk1ialB1dXNlSFVtZHpZZ04vNkpGWmx5N0wzZk9UWEtCMjE1ZnVLS3NsZno0?=
 =?utf-8?B?M1lObG1adGtOcmY4RU1LNTZHNTVOWGNkdkRlcFhkbG9zTUU1eUI3c29HNjlU?=
 =?utf-8?B?d2NZVjJjVExFWnBNdzBmOFZpcDFUZ09ibHRoUysxNDlUUEpZU0tGTTBmazJS?=
 =?utf-8?B?RHo2dDBMSFhMdkdIdjJyV1RMNzlub05GNkZtazJrcG9xRWpESHp5cUVFcDcv?=
 =?utf-8?B?QVhaR3UwbjRsVTJBRU8wS04ycDRiUERXUXdJRW9Odk1uTEZJY0Y4OXNGVExS?=
 =?utf-8?B?WHpOSmp6WFo4Vyt4cFJKVDM0ZU96a0paQlNqck0zRW9hZE9KbHBLdWFNTWJG?=
 =?utf-8?B?dnpQWE45Rkdpam0raVVGN0gzbkNwMkZsbm5ZdWE4RGRUQk5jc014UC9BWG4r?=
 =?utf-8?B?bU1PNDdOWEQzVUNjdk5DWGhpZllOWTM0bTYza0pJMENiUEk5NG50NWpobDZl?=
 =?utf-8?B?S2EvSStPeEVWdUx3UzhzQzEwbGMzMURqQkQyeDQzdnE1cDJwT3hVV0JyNUI3?=
 =?utf-8?B?dkJZUFpDV1o1UTF0SVJHS3pUTzlNMmV0VGtFWnY3N1NWbVNHaTZxYlVuSGZ6?=
 =?utf-8?B?bEI0YjJNajBValVyckdiMVdvRjdHS0RYMXpkUXk5cU5GSnZHVnlWVUZRTHNh?=
 =?utf-8?B?OVNWM0x4emsydkl0MWlzblhwZEttTDdCVDhQVUY4d281MzNKMnVmY1Y5TC8r?=
 =?utf-8?B?b0RqQTgvbWhYZlJNNE1pODMrVUNnK0c4UUNteWo3YW1YZG9RS0RMN2Uxbjc0?=
 =?utf-8?B?SUNKRWc5OHZzU0ROMUdKOXNzR1lESW1yM0k0ZEVFWjN5ZHNCWEpiTnprS2RZ?=
 =?utf-8?B?TW02WXIyaG5ITzhKd2wwUWtpK0orMjdjUFVTL0UxbjRaZWRsY01kYUF1U01E?=
 =?utf-8?B?S1lQbElDdXBxNnRTRzNWbUlrbnREOTJHR1BWR3ZLdHZ2WEMyeSt3bkNmc25X?=
 =?utf-8?B?V2VuL084am9WV0FsVUpMWHBHMTJ4QldqVEl1MVE3cDBRYlZaQ1JCSE4welQ0?=
 =?utf-8?B?bzZJazdJdUN5eVZUTEs3bllodHlBWThFQWhsUUw0RVZrWVJNNi83SzhDT1U5?=
 =?utf-8?B?M3R0ZEVMMldSc3lwRk1rSC9qVkZwSE40Nnd5NGF2ZmEwZ29HWEk1b2w2QlA4?=
 =?utf-8?B?dCt5UFE0dGdkbVZkWVN6ZmNLUVJrZWgzU200QnFoRlpVYk9XamFYdzFYalNJ?=
 =?utf-8?B?d2pIN0FWL2ttSkdQckh2VHpwMVI2ei9pZkMvc1EwQ3lpUVVvV0d5SDZVRTJk?=
 =?utf-8?B?ekhUM2trZ1U0V3lyOCtRK2QzZkg4RXIydm5idmJXTnlkcVgwZm40amh0T1Uv?=
 =?utf-8?B?dmgxODZiS0NwcXJVby9VMmJSMm9JZGVIbDVZZENuUzdydzBubS84ZUlOTVlD?=
 =?utf-8?B?ZEtHOWZqVEEzVVlqOVhLS3c0eDdvOFVwVEhvRktUQS9ESktjLzA4ejNTTUsy?=
 =?utf-8?B?akhieGRXUjRYbGVQeVdsbHI4aXhHc1J3RG1PWHE2bTlBeHUrcU9uc2pUMHFs?=
 =?utf-8?B?elNTRzZ1b2VSQ2g1YVB4aThxQm5aNnpzWDFVcVZycFdmd0RJd083aU5KQTIz?=
 =?utf-8?B?emZVZU44UVh0L3FRcmVNUmdDbVEyc3c3U0VaR2k5bWZMUit1N0tCSGU4c1h2?=
 =?utf-8?B?aGhwci9vakFpNzA4NStOQ0phY0dLUHFCV0VYNmgzRnFQVzNkZy9IcGRxNVhz?=
 =?utf-8?B?VFdZRUJTanI1MUdqRGFGbWV5STQzNlBieUlvcGFPRFdoaUwvSUxEMFpRK0Vq?=
 =?utf-8?Q?JCPI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(34020700016)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:12:30.9685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768705c6-79c8-4077-9964-08de17947488
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7986


On 30/10/25 14:29, Francesco Dolcini wrote:
> On Fri, Oct 24, 2025 at 09:08:09AM -0500, Andrew Davis wrote:
>> On 10/23/25 11:48 PM, Beleswar Prasad Padhi wrote:
>>> Hi Hari,
>>>
>>> On 23/10/25 22:48, Hari Nagalla wrote:
>>>> On 10/22/25 23:38, Beleswar Prasad Padhi wrote:
>>> Hmm, this was how it was until 2016 when commit
>>> 9f0cee984a25 ("mailbox/omap: check for any unread
>>> messages during suspend") was added. Do you
>>> suggest reverting 9f0cee984a25? Hope it doesn't
>>> break any existing usecases for OMAP platforms.
>> Checking for unread messages during suspend is still correct,
>> what we then do when we find them is the open question. We can:
>>
>>  * Not suspend (current situation)
>>  * Suspend anyway, deleting them but with a warning
> I would propose that we improve the current patch and just add a
> dev_warn when there are unread messages.


For systems which have FIFOs firewalled, this flushing
will result in exception. So we can't go with this.

>
> Andrew?
>
>>  * Save and restore them
> As of now our platforms (Toradex) are broken because of the changes in
> this series https://lore.kernel.org/all/20250908142826.1828676-1-b-padhi@ti.com/
> (now in mainline), and I would love to get it fixed sooner than later.


I've been working on this, and will send a DT patch
today to limit the num-fifos for each cluster.

Thanks,
Beleswar


