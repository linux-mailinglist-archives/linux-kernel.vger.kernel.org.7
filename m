Return-Path: <linux-kernel+bounces-721308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7808AFC77F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9401BC3936
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82E266B65;
	Tue,  8 Jul 2025 09:52:04 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023137.outbound.protection.outlook.com [52.101.127.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92921FF51;
	Tue,  8 Jul 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751968324; cv=fail; b=FGeP95mca7lGeBjZYkseoC8mjL3rjXe6wvlXulBEUULu0oicxMPEHLvNB5CifWVbuxWW6ebAXWquFTqkze86qQ2JHwPvORm3sV2ywI+Ixcw79XCUfRij3LXvI+X4PsuFPR8DGK4av7bbPwgkeqSiUf3UHnyjedv2IXp64/RN6Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751968324; c=relaxed/simple;
	bh=VVaZlNF7lRmZGHMP9UxkW14za6TGGlE7/IdlrdpIrcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbtQHcPGYdYeZbpkmhw1w//f/WXGbsbFgZmmEcCI9zMCwnYVuqUt/KebyNB2NRUb7cVQlwdLRqBVST9oEAAUdzN0By+VERkeSFzuGb2KqcHmit5nZvPKUwDBT3rCpJSOlPbTTgT3aRquBfsXdDudEM9h0byxdxtTKVXf/TT5C5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEhx3cCP4ZxL3/y8Bi7q+zt8z3/o3+oZesN7aNHnqFc6DwyqNFJ+qqg3MLMdLN4LRsJiYBe0mA8mlSPwLosOBEgBtHw9O2HBohGyQwrOw4Ues1xMNwNsCRCj+VM4wJ1E1JCIkDXud+AgMq4BVvIHDKaIhOgzIjTay3My9N3PnnJKktNlQTJAhBBCzsImQT1ZbEhmwcJq4qUUZY33xefmmMsWiXl/WtVI1CU8b8zooh3a10zy9zn/i98jzMI9FCUFYAacjOOMg/XvXY3HGqXPggHYz0YHUkWGAtq/A/ws4cDbp7kmyhdcIAUMbp1AWkergNJDCs4hUiLfArjR0ByCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be1OVpHHhSE5GAg+9vrgJi/nIoens3SkLozlJyDnxO8=;
 b=xPUR9KJs/YGACa1mbsJUzCj3AssIS6ZxrAgfJV98Rq73kjNMN2chSwzCoZ0m7c5FK11v0tRi8U49PF/6MtUOEQw1Vek/Pun29H/CQUYtf/qLz7OA/fvjcmEK14DeOhSS32lIOaMuwJykWGxdI96Vj2EUa31TJ3fTZUP2S2nKSd5X2YR6Cokf6yt+KpEtU82cZTZVmVIz+isct6KAPZW4gyw6KMA+7aNWN3z0HIerD8sfPLJhsdkJ2aAgTSXf1dgWc2NpaEA0kFOtfI740RQZeR7e+SClJuoYtwJRnIjKG7NIyBQfJxCp5PArMZCR7igtIgLfUH3pa3wXX/esy434ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0138.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31b::13)
 by SEYPR06MB5085.apcprd06.prod.outlook.com (2603:1096:101:55::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 09:51:56 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:400:31b:cafe::1d) by TYCP286CA0138.outlook.office365.com
 (2603:1096:400:31b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 09:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 09:51:55 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6D1F844C3CB4;
	Tue,  8 Jul 2025 17:51:54 +0800 (CST)
Date: Tue, 8 Jul 2025 09:51:53 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Peter Chen <peter.chen@cixtech.com>, Rob Herring <robh@kernel.org>,
	krzk+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com, Marc Zyngier <maz@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kajetan Puchalski <kajetan.puchalski@arm.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Guomin Chen <Guomin.Chen@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
Message-ID: <aGzqOTHE0equy6m3@gchen>
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com>
 <64f39e94-7e88-49d0-8455-cd77d61d4fe2@app.fastmail.com>
 <CABb+yY1pzut-A9Xf117AoGMze2OevWKYrH5NtWBGFBhAMZky+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY1pzut-A9Xf117AoGMze2OevWKYrH5NtWBGFBhAMZky+A@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEYPR06MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: d07c6970-8955-4563-ce65-08ddbe0512f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekFTQWJjc082dHF3TE5VR204RXBpekxxKzU4aFp2V0EyQUdyOWhoRVZxTS9B?=
 =?utf-8?B?V3IxMkFieXlCbzBCaUdMWDBTbTQ4VXNsWUVSenI2TDhtS3I4WTdyazBsSWVh?=
 =?utf-8?B?N2tteVVuRkF0Vy9Ed0VZd0ZYTndsSjhiRkg2WnlzL1ZneUhGNGJTYytGMnh0?=
 =?utf-8?B?ZkljNzZlYzBhM2pTSG90NzlZR1RBVnhBWFVvZlE0ZHl0Uk1URVlxQWxaNG0w?=
 =?utf-8?B?YXU2MDVBNUlYSmhVa3hwdEdNbHl1bDlReHphb3k4Yms3QjRjWlpOcXZtR0Ew?=
 =?utf-8?B?YkZMcHIvSG5VbG4rTzJEbVhvZzRNWVA1eTJvOEhBVk5heDFmT0MvT05wc2Zs?=
 =?utf-8?B?UHkyRmdLM0dRbE12SEp5TDkwaXJudk41bXM3dmc5QUFxS0dnc0tTRnRSS2F0?=
 =?utf-8?B?S0VqK2ZSb1ZDcUk0RVc0OGFlU0lNQmJsUnhhd0xjeTgyNDlBMkdUWjB2ZVNk?=
 =?utf-8?B?TmRsSEJ2cEpvWWtBRkFNQ3pXWktyZkFaT3FUUndYTkx1RUYyZVYvYlBsYjZt?=
 =?utf-8?B?aElMSU5RMEt1bzZOZHMyR0djQTFZTVFrRy96bHVvdzZKU3pOYWFZNS9VRTRJ?=
 =?utf-8?B?Q1BCY24zSm9MbG5zN0xKZ1A5MmhHY25aVHBDRVRxakxmeHhiT2V0b2RoK2N6?=
 =?utf-8?B?SmVZL0NSZDQwajgrV1o1RjVqeE1ub3B3RWtqdWErTEpnSytWaXNCdGVxUGVV?=
 =?utf-8?B?VS91ODArSTIzQWZVVWQvM0FXSk94RkhBVkRJdXdXdDlHWjFCZnlyMm04ZkFR?=
 =?utf-8?B?QWlYdU5JeTJuR2wvOWJsNi9ucW9BYWVWRldtbHJNaVRiYVZ0c2hwTDJnbStX?=
 =?utf-8?B?S0RPMlErR29RaHpzTHljbHRxNjVWTXh4SWowRWxDYkZhUGkzdGFMTDBLRXFZ?=
 =?utf-8?B?UFZMYzhodjZJZFIrSWF1a3hQem5Ub01GSnJ1OGFQR3JlclY4VlhtV1htQXRR?=
 =?utf-8?B?Z3NDbnNKUWRpaXArK2ZzR25HZzZNc3RHVEVJN3B0WWRSZkhtcDJVSTBkWElZ?=
 =?utf-8?B?UUN0dmJvZDhNR3pZL2tNUExyb3EweXgvcTdFZm5XMlBFRVdTU01GcWwxampy?=
 =?utf-8?B?UDRmZEtUMXFXNm9rMVJxcW1UZVRqR0drTEc3WGNNRHo4RE5pUG80MnNYS0Ev?=
 =?utf-8?B?UkhBWjBNZWx5NFBDVUs3UDRlNFVzblZhaFRRTUhLd0QvMnRJZmFnTDZaY0JZ?=
 =?utf-8?B?WHQ3VlVtb2s5T3ROODk4aEJEbjlEdTVuQW1nNmkxekdoeVhWNEh0RGZDU2xB?=
 =?utf-8?B?RFNwQ3JyUkZONVhsVTNrZDJuRzJqU3ZrdEdTZTgrQVc5ZU5vWU9IbE1tVWM1?=
 =?utf-8?B?QkxNS2g1MzFnWlBpbVJqbDRJd0lHcDI0WVJlbUFPR1lUQStPV09XU3h1ZDVZ?=
 =?utf-8?B?OVNLYnczMkIyeE5MQlphaDNxS3I2Z0o2RVI3blMxVXYrNklhTzJEcm45Y0ln?=
 =?utf-8?B?d2RkUWtPcWNvL2pDVlJjZ0VNTUk2eEMwcGpiWHg0QUdnUy9CNkxwMER6NTRn?=
 =?utf-8?B?eU5iclJwQ1o3NDdwazdFRU96QzYxWmt3eHRFSW9SdVVsRmdid1J2T0ZWVVox?=
 =?utf-8?B?aXQrenJwazFBTklIQk9qQmtkNldobkZBckV5a2Rkbnp6QURPZDFLa29YZC9o?=
 =?utf-8?B?aWJGbGtLcnQyM3BVVmhybFcyOXFHblRxanUrUEVhc1BvL2lwaVhET0dJaHdL?=
 =?utf-8?B?dE5FVUptU2JQMmU2TStGeFhtNm9ZUlpLTW5HT1VHZTdJOEhDRm14STNINjYr?=
 =?utf-8?B?T2hGUUk3RUVuaERXSzlwM0dVeGVtc0ovbElCTG5JeWxNM2FmUWtIL2JiMlZU?=
 =?utf-8?B?U0ZubCtCYVVybGorNVpNUVh3bVQzalgzUGZBaXJRSW0wV0NLeDBJNmZyTmJ6?=
 =?utf-8?B?RDBhNjdkeGtBbm5JYkc0cEdpb0dyVTVGcHRkWU5FMU1RbDAzc0p3bWdJL3ZH?=
 =?utf-8?B?R0hvbXAwcGl2clNlQUc4aWhDUHF2NzBBM05SeDJaWnVET2NIK0pRMXVPWW42?=
 =?utf-8?B?aWZvL0hRRGtGTFNoelloY29MVVVtU2hmM0RYc3dyd3pLQ2MrZms1YXBqa2Na?=
 =?utf-8?Q?ogvaVn?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:51:55.6383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07c6970-8955-4563-ce65-08ddbe0512f0
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5085

On Fri, Jul 04, 2025 at 01:35:51PM -0500, Jassi Brar wrote:
> [Some people who received this message don't often get email from jassisinghbrar@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Fri, Jul 4, 2025 at 11:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Jun 9, 2025, at 05:16, Peter Chen wrote:
> > > From: Guomin Chen <Guomin.Chen@cixtech.com>
> > >
> > > The CIX mailbox controller, used in the Cix SoCs, like sky1.
> > > facilitates message transmission between multiple processors
> > > within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
> > > and others.
> > >
> > > Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> > > Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> > > Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> > > Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> > > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> >
> > This is the only driver holding up the merge of the CIX
> > platform, so I had a closer look myself.
> >
> Sorry I wasn't made aware of this. Also I normally let the drivers
> roast until second half
> hoping other platform folks find issues - I have reduced imposing my
> opinions on platform
> specific code because it is usually met with some sledge-hammer requirement.
> 
> >
> > The one thing that stuck out to me is the design of
> > having multiple types of mailbox in one driver, which
> > feels out of scope for a simple mailbox.
> >
> Yes, if not all modes are used currently, maybe drop unused ones.
> 
Hi Jassi Brar & Arnd Bergmann
Many thanks to both of you for your responses.

In the CIX platform, each mailbox controller is equipped with 11 channels,
categorized into four communication types: Doorbell, REG, FIFO, and FAST.

The Doorbell/REG transfer modes are used for the SCMI framework,
while the FIFO transfer mode is used for the remoteproc/rpmsg framework.
Currently, there are no clients using the FAST mode, but there may be in the future.

In the CIX Sky1 SoC, there are 4 pairs of mailbox controllers (since each
mailbox controller is unidirectional, 2 mailbox controllers are required
to establish a single bidirectional communication link, one for receiving
and one for transmitting):
 AP <--> PM (using Doorbell transfer mode),
 AP <--> SE (using REG transfer mode),
 AP <--> DSP (using FIFO transfer mode),
 AP <--> SensorHub (using FIFO transfer mode).

Since this patchset is only a minimal system that includes only the necessary
subsystems for booting, it contains only the SCMI clock client using Doorbell
mode. Other clients using different transfer modes are not included in this
patchset, but they will be added later.

Supporting multiple types of transfer modes is a feature of this driver
that leverages the hardware capabilities. We are not the only ones with
a relatively complex mailbox design; for example, the NXP mailbox driver
also supports multiple types of transfer modes.

Thanks
Guomin Chen
> 
> Thanks.

