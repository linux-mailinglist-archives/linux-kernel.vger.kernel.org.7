Return-Path: <linux-kernel+bounces-732748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CDAB06BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B94562C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C5A273D96;
	Wed, 16 Jul 2025 02:30:39 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023133.outbound.protection.outlook.com [40.107.44.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CC1C68F;
	Wed, 16 Jul 2025 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633038; cv=fail; b=opOTWT7rdPedu03cvfkJkzoCjivp88/9uwIdhu7t2S0rqAFCgE2q/VadwUqCa+v0ophyt93jd8N6nzj/hGdSCwcMhN1hDmZEJXQFHhKTRuCVyBu5QBF8YQ/6v5sNJTmE+cA41j9IXMhnGENHBGhrh0z+Z1I3/Wzm1qhTS4dYDeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633038; c=relaxed/simple;
	bh=85T9+C7Z5WXZfxLbyjpIiJL6V8+wuWbzGlARHER0Ksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/VopXB3V/02ayE+342zF25g4z/vZ8Rx8F82WjOCwSRmiuw4u8bDklB9+So7+vRdlYtjCkIjKqilBOHkIRorHoLJ2XUCrKIYUnKH3St9/6AwQqqksNkBOBF2I/qEm8XmiesjGcXEtvnVDTNBJlwIs3C86Y9+u1dyrEodrX1u+aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8W0s3VtBIM2lFQa6X2i8HnZs8RCVBqIkr+EOxF+Rc1Ug+F1SBkVpQC9Ozdcw3RCO1GVmN9k4hAClRJoUJ8a/bFrnIu5fRjlwg7bXBHWi54PM5jPMfW0EkLV0ewHuSHcxS001Jq3k4RJiFldYkVqpS4FkWecxvEed2//5l2+2h/ABvAW5qPJJjiHmGcI+3Stv7G9dbzuzik50txfADmTelNiQTjeYVaObYLP+AnnnqLgkaVRqx4x3nB/xctEJjsewo//eaVlO7mim02KEgKZtNmr3pwY69wbelnfC1b0iADDMgrevZSCYemsEBiLlQakCFTE4hc6hMj6QfhB1Xf2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Huvh4uPdumS1mwAla65bNxfHXTSVMDMLyZGIkEePI=;
 b=wtaM2JS6jci8BgTjwxqnP4llSf44FxOJuHuOBQ2NYK9XiOhvMmJEiugmG2fY/hY197I7QXTp08baP/BBS7P4KC/X/F+eGk3SEfmkvvIYnFEWEFKKoPYcVzBFhdRv9cm/UJin02eZ0WcjXFwGqASFc6weG4sOogcHU88bVwupnK9QD5/VN9NEzCeR93Fh6CIW7dYKTWXfYs2Ek1I7nuib+u7Q5jQtCgrp+nWr19Gz/PZ5UjoQclfaK+0cMzZEtYLpN7hyYD5vO6Rhi8BMO6rTC62bZ3Dx9NSs/PYWnK8CfjzIqSCVhUa9aqnyxrCIHQ4oCCYzZCNaO45480/a1cbvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:79::20)
 by SEZPR06MB7290.apcprd06.prod.outlook.com (2603:1096:101:24f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 16 Jul
 2025 02:30:30 +0000
Received: from TY2PEPF0000AB87.apcprd03.prod.outlook.com
 (2603:1096:405:79:cafe::f0) by TYCP286CA0372.outlook.office365.com
 (2603:1096:405:79::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 02:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB87.mail.protection.outlook.com (10.167.253.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 02:30:29 +0000
Received: from gchen (unknown [172.20.64.84])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6E14644C3CA1;
	Wed, 16 Jul 2025 10:30:28 +0800 (CST)
Date: Wed, 16 Jul 2025 02:28:57 +0000
From: Guomin chen <guomin.chen@cixtech.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, krzk+dt@kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Chen <peter.chen@cixtech.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Kajetan Puchalski <kajetan.puchalski@arm.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Gary Yang <gary.yang@cixtech.com>,
	Lihua Liu <Lihua.Liu@cixtech.com>
Subject: Re: [PATCH v9 5/9] mailbox: add CIX mailbox driver
Message-ID: <aHcOaas459jctIB2@gchen>
References: <20250609031627.1605851-1-peter.chen@cixtech.com>
 <20250609031627.1605851-6-peter.chen@cixtech.com>
 <CABb+yY17OOBx73655OhBp8At1b81w9M61zzGu4uhXcMTw4Q=Dw@mail.gmail.com>
 <aG0i75h32dWg/L2G@gchen>
 <CABb+yY2BmqiQ18hU+7C234UnY8n-8PH5VEoS7nH5Xq5O1krGhQ@mail.gmail.com>
 <6b5f38f7-0557-483b-9252-cfade7a24cf5@app.fastmail.com>
 <CABb+yY26R_DHQUhpg-xUR_Z7EnjdR_4LPai0M-vfFTAOZy=vvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY26R_DHQUhpg-xUR_Z7EnjdR_4LPai0M-vfFTAOZy=vvQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB87:EE_|SEZPR06MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 072ae2be-a65b-4d06-7d73-08ddc410bb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGV2YnRpTTltR0JoVVRHS240amJCS05WS25jSkRYQXJ2L0FBd2JDWFdNR21H?=
 =?utf-8?B?V1ZYQ1J6RFZtWUEyUWNUOHdoQ2lJTEFwbGl6SXZSOVllZmdQSTVMS2dMSHpk?=
 =?utf-8?B?WVlSODIyYXlPOHUxY0JMdklIcTczL3VxWFNuUUtQMVJXdnpyTWU1dGMxZ0Z3?=
 =?utf-8?B?QVVLcFlpV2JqZlR6ek9DNDRFRHBPOHM2M1lmbGtCRmdFUUVvcU1rUDBodDdt?=
 =?utf-8?B?VUkxbmJFeXRDeHUvdjN0bVdJV1Nhc2UyaEVOV0kxa2JFWTBQYjFLWDFud25G?=
 =?utf-8?B?TEFENXBrZVE0akxyOUZoWXhzR1l1N2w2WnZoZjMwZ21kQTAyaU93Y3NMYWRR?=
 =?utf-8?B?VkJSek1UaGVMSTJacWwzMXdXOGxRMmdKeS8zVUNJbVIzdEJJV0RYWlRSV3R5?=
 =?utf-8?B?MEF0Y0RuU3prQkJ0dXhyNVRpUTl5V09raTVJVUZzTlRtQ1crVCtYZkZ2Znhx?=
 =?utf-8?B?NVcvZkNQdzRoQkhTRkVMSmtvRGV3T0JjYisvUXRkazFtN21qRDF3SmdUK1ZS?=
 =?utf-8?B?Q1RaRU1oTTVrOEJZOXRFaWswdk4zZHlzYVZycXRVbjVrQlVpa2ZwL2loRzAv?=
 =?utf-8?B?a3FoMjhaWDcrQlB3M2o0Y3BUNU9hbThtR1paQzRrcmxvOG5LQmpsRS84Sk5W?=
 =?utf-8?B?RG40WkphblMzUGlVcTh5b0QxUG1FTEpCcEZoa1JpVEhXOWNGY1FDS0p0cllw?=
 =?utf-8?B?YVRJb0dkaTdhNEt3QmNJVVVPZEZzakpCSlZEVDYrakxjNDI2LzVldzJheDk0?=
 =?utf-8?B?Wk9RYjg2Y2hhd04rZEdod2RkR2RXK1FWV1lUdGU0ZVh4TElKaHREa29COWlF?=
 =?utf-8?B?MUF3ZUxUa1RqNmJHZFZlUVRodWdUQlE2NGVrTlUyWHZxRWNUOHB0RzUzVzU2?=
 =?utf-8?B?RXp2UVdnYmNpRHVaVWhTSVVoT1pIL1RWdURxd1pwN05ESnNvbEEwUFpadlhU?=
 =?utf-8?B?b1NwcjF1NGFsYVdzOGZyRFVLUjRHK3I3L25zUXorNHRZMWNUcVA1QXpGOUNY?=
 =?utf-8?B?UU5BUVdPY3hqWW0zVzNiNmxWZllwQXdUK0dVaU5COExtTlEzZ2xrUmd1OW8x?=
 =?utf-8?B?LzFHME1JL0ZiRXo4cFdIOEVKSm1DbmQ4bDVCZzVtOHFmcnpQdy8wMG03VWZy?=
 =?utf-8?B?b2EzN25VQlVPbTkya1FOOGcrYVZhQlh0VXhCVUdtQjZLZnhsVTJoN21lQmp6?=
 =?utf-8?B?T1ZHZ1lmc05zRUVQcms1ZnRScmtXRmJlN040STJhMGQ4ZWRCT0VOY2VxVHJK?=
 =?utf-8?B?U0JZZE5LUFlRRGdRUlZjVzloVURUcWUwK2R2OWROYlphMzdCSlRTUnIxVkJ3?=
 =?utf-8?B?a0IyeVNvM04wTldmQVA3V3o1OVAvTDAyUGhxV1lHUDRyZnE1Tld4ZHhBM3B2?=
 =?utf-8?B?dDhVTC9TUUlxZWZmb25SWmhscVE3enE5Y1lFdnZKdUlqTXZ4b0VQZTdxcUZo?=
 =?utf-8?B?OTFmZ1dxNGFqUlJVVVc3ZDA4dG5WSDlXK0NUdEUxZitWV3E1NjhsNXJCN2E5?=
 =?utf-8?B?RXZGSEdzT3NJa1RDMk9RUThrSzFqZzBITFl6dE1IUm9vcXg2S1lCWmFsWnpt?=
 =?utf-8?B?V0xtbUJoSXFtMXdyQzdreHFERHlPeFVRMWc2Q0oxMDRYaVFxdUlGdjVabXRx?=
 =?utf-8?B?L3lWL3BCcWRkdit5Ym1CNEVtb1Jsd0VOQmhPSmhNVDI3bXF0TTRpa2JtdC9s?=
 =?utf-8?B?QU9BVUx6TTNFTHVTNGtNM0VUazIrYXlQaWsrdDlseHRsTjZhVlpQVWszbnBj?=
 =?utf-8?B?cWJjYzNTeDRJQmJTRlpyeGR6Mk5pSzY3T0hRRWNNYnhCY1BnVmVkVmp0bzIw?=
 =?utf-8?B?UmxhdUo0SFhvRWFBL3VFdlN3Y3NlbkNNb3E3VUJjOXplU3o1WTdvem5hcDlV?=
 =?utf-8?B?eWxjL2UvUXkxcEZhLy9BUnU2QjZnQlZ4bWRORWxNc2FYRzNuMEFDdStjd1Rp?=
 =?utf-8?B?TXRZZlhuaXpLeEFNMzkreDAzM1lpNVU4RTNQMWxqSG5NOTNrdnVRRU8xbU1x?=
 =?utf-8?B?Mm1RbXNoT0prb2t4Nk5LZThDc3d4MGpDYlRLdEZBWVlPazRRc3ZNKytDQ1BN?=
 =?utf-8?Q?oi8aoD?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:30:29.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 072ae2be-a65b-4d06-7d73-08ddc410bb65
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB87.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7290

On Tue, Jul 15, 2025 at 05:11:01PM -0500, Jassi Brar wrote:
> [Some people who received this message don't often get email from jassisinghbrar@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> On Mon, Jul 14, 2025 at 10:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sun, Jul 13, 2025, at 19:00, Jassi Brar wrote:
> > > On Tue, Jul 8, 2025 at 8:54 AM Guomin chen <guomin.chen@cixtech.com> wrote:
> > > ....
> > >> > > +/* [0~7] Fast channel
> > >> > > + * [8] doorbell base channel
> > >> > > + * [9]fifo base channel
> > >> > > + * [10] register base channel
> > >> > > + */
> > >> > > +#define MBOX_FAST_IDX          7
> > >> > > +#define MBOX_DB_IDX            8
> > >> > > +#define MBOX_FIFO_IDX          9
> > >> > > +#define MBOX_REG_IDX           10
> > >> > > +#define CIX_MBOX_CHANS         11
> > >> > > +
> > >> > if it is not really a single controller owning different channels,
> > >> > maybe implement only what you currently use.
> > >> >
> > >> As mentioned in the previous email, a single controller can support
> > >> multiple different channels.
> > >>
> > > OK. I am not too worried about having all variants in one driver esp
> > > when it is manageable and share the code.
> > > Unless I am overlooking something. Arnd?
> >
> > My main worry here is that the types are all quite different: while
> > the doorbell and fast mailboxes are what a lot of other drivers have,
> > the FIFO mode does not seem to be a good fit for the mailbox subsystem
> > but instead looks like a more generic firmware interface with variable
> > length messages.
> >
> > For those, I think a higher-level driver with fixed data structures
> > passed through the hardware interface seems more appropriate.
> >
> Yes. But sometimes when the data structures of a protocol are not
> bigger than FIFO depth, the platform may choose to use the FIFO mode.
> I see it as platform dependent.
> 
> > Are there any other mailbox drivers that just use the mailbox to
> > tunnel variable-length messages?
> >
> From a quick look, Armada 37xx and Hi6220 have fifo though they fill
> them up fully for each transfer.
>
Yes, both Armada 37xx and Hi6220 support FIFO functionality, and they
fill the FIFO with each transfer. 

Since the cix mailbox hardware supports messages with a maximum length
of 128 bytes, different clients transmit messages of varying lengths,
such as the cix DSP using 8 bytes, the cix sensorhub using 12 bytes, etc. 

Therefore, the cix mailbox driver has been modified to support variable-
length messages of up to 128 bytes. This allows for more compact and 
flexible support of various clients.

Thanks
Guomin Chen

