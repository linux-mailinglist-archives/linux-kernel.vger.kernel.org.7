Return-Path: <linux-kernel+bounces-856113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF43BE31D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 759434E6EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477B3195F0;
	Thu, 16 Oct 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FNpcupEy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FNpcupEy"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EA421C9F9
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614712; cv=fail; b=HyOS8h/lzkcZ17gcdaLNodHGmsRtOSf9qNpetDauVbfv2H1P7xIyj1g8A+Jsvwliz0hGbPuvxyIkOUr7kc3jbRj3pCs0kzCBxzGCUal0C8tToDL+XaBjiVa7XpGKDulDdhieqzTXQJpLFt5h2OAUb2W6HQT+fssOHc1NBNoOIGA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614712; c=relaxed/simple;
	bh=q63IGPIg27+b+H933TQpCK0dJhzK1b87MenZcX4TDIY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+aOXdx2g1NVXZdbNhOq7GECaHv2Tczdp3/UW2OXeoYjnSs3yGqBAj+AATRFbom1Q9sbYbYg4vsnWp/VZ7Edu6jLmOUW5SCioTJoMl3sK9tUhCy9BetO+X73TtLKk6pa30SbrAKw4WeHlHmRMGpjWYW5cYEgnEFMm8fAHBToZbw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FNpcupEy; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FNpcupEy; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RxJhlAmf871CmwfDQOTdCdNX13HANfO/Dd1Cm8lMozRJI5gzcwAlE4dU52M5wNW3MK1Gh43AA1h+38UOnbTEMenIPHoFnZtR/TwGAu7DDiiEiI3vxEp2SO7aBW5/XGFLkYXbUmI9c6PrNzoWF4m0cnHkvzvxr54799vQWo3dw9OfIzNeDb3VWWB2PeMoBgve6qskC8QpkDMLXozlryazCtbXN8lpRWUvHVpWDeUWq4nB5+TxNPWuwuSUoGE9sCRXEAkrg86sJDgs3oELz/UuCKLU9xOELQCmVFnF7nfcyFCODTriKxKCISbh1zcvHkOfznKbZLlyDSROcI5KF8Xr5w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L492EMOn3+XxfZY0py74c4uuBtL2Onkx4z9IFrP1pxk=;
 b=TnqnykLB/u9IUysCkPfH8ohKN7+rvzUx213jZ5E9/nNu6BP4dKkqMkGNY2Jxu2oQ3PvAfgL40vXRciLpl4NpPnQO8NXDa55sNkjw+N7TGpRqYJNGx09sz/uZh+kkJRl85KdPGkwMwPlcP98HsXSlvcs7gPOxLtxVO7szOQ5argYCp0SXCiNzL+RhwdVQUd4iUaWx2+55cUND1VVZdThNIzO46Ej+6mfEic1YVS2NT8QX2oqusksx8hBrkxdz47EjTSQTsK1WKObqSQViGTga1e/7dpdToGF2Sty3nWyeNcMId3aQ8es6uHDGFP/QmUkCysNHSa8H8GFu5vehMYiW8A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L492EMOn3+XxfZY0py74c4uuBtL2Onkx4z9IFrP1pxk=;
 b=FNpcupEyZqeiMxk1oIuNxicWtwRvPJCJ+CYGsreksTLXtx62u3qPzaeKy48Kot7cjtCYIZ4sbNF9i1QS1lp7pfsM5GidKUJLc21ruVyJ99fAwxsVzic5Y0NRahN9P6HdktgUwFOnWWFh/oGuR83lty1IlTFQYE2jXonBqkS4cjk=
Received: from DU2PR04CA0211.eurprd04.prod.outlook.com (2603:10a6:10:2b1::6)
 by AM9PR08MB5924.eurprd08.prod.outlook.com (2603:10a6:20b:282::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 11:38:23 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6f) by DU2PR04CA0211.outlook.office365.com
 (2603:10a6:10:2b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 11:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 11:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBpTKgvwLX3wm6RvzzkLELSqz8YKvxiTGdnirea3vx2P3wDpSfmIF41yssnsftW/QQvfnjXKE+4zVXDm3cQcCPFPfIUvni0DrpnsKdXhpX7/m8L8cbLzjZPaJPJR03SO1zliL5Xw3CqpEItiopZbHxbza7UJs39hoea7EYfIBTJJIGGAIbv+erDXCqUv3O0Z3rA3JAablx0YHsuYBxK+C+LkGdXxqhjVMbntNSBsytlbPBq6bUyIT3Ywbb6A01UfcFZ38weP0QjPLOGvnE2qVq12eVH0DoREHC2UqI0/h0RFXpAarCc7/LFJml6NkFiaUvdLR9kbyB/ceT1Box+B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L492EMOn3+XxfZY0py74c4uuBtL2Onkx4z9IFrP1pxk=;
 b=ZjI8Z32JaHEcEr2tyzU/Mx6m8TfIeUAXMk6KWP4HXR/1U+05LU941R77eXpabyKAwZ0RiVccwMRbzP9oNLDtVB3qDhK1CZmHfMlpmoQOX63VJHoMLnGHGaALtV/xQZ+1a9uM2pFzZoOP72tvgcPQsfNoergvd9hzBelhFaHzIPuZfrdzhBqjud06TEFIzS70ovLv/6xSWjwDMnb8NFPLD+6hoqDsI8+A0U77Q4QDydg0KkfibqQHna+GEDmGU3khmcH4SKgm1XXBYOOH042vtL3ojgyxdD3Tpz4JV/7R4OP9ZvsoPpzUclJPVvNRPJvvGU4zH/OKnfqxCH3BFoLyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L492EMOn3+XxfZY0py74c4uuBtL2Onkx4z9IFrP1pxk=;
 b=FNpcupEyZqeiMxk1oIuNxicWtwRvPJCJ+CYGsreksTLXtx62u3qPzaeKy48Kot7cjtCYIZ4sbNF9i1QS1lp7pfsM5GidKUJLc21ruVyJ99fAwxsVzic5Y0NRahN9P6HdktgUwFOnWWFh/oGuR83lty1IlTFQYE2jXonBqkS4cjk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 11:37:47 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 11:37:46 +0000
Message-ID: <454c61fc-0771-4800-b075-02591bab79b1@arm.com>
Date: Thu, 16 Oct 2025 13:37:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Juri Lelli <juri.lelli@redhat.com>, Pingfan Liu <piliu@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
 <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com>
 <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
 <3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com>
 <CAF+s44Tv1n0b1GSghSPP3xDPK4qzbzc629XMB9btzXuKgfKvcA@mail.gmail.com>
 <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://pierre.gondois%40arm.com@outlook.office365.com/Sent
In-Reply-To: <aO9q9EJbUw0QqbXv@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAWPR08MB9996:EE_|DB1PEPF00050A00:EE_|AM9PR08MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bdb1ba-8c80-4950-59b6-08de0ca88375
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?N1VxWUQxSjR6UDNRdVpQTi9VM0VIRmNwTGVNd0s3eDIwTGJmVmd3aXYwMnpH?=
 =?utf-8?B?THdSTml5RmZxOWpNRGxmN3ZPeGl5dVZmdVMyN25sK05MYmJVdTR0R21FUDdi?=
 =?utf-8?B?WTdHNWxHaGxzQ1ozS1VFOG9QZGN6V2xuckM4djhQbG9UTkZOWjFGSXQ3NjJw?=
 =?utf-8?B?Q0k5UmxoKzBIZUNkV0VlTmp4SXZ4NzlpV1VhUWNKWVZnUzg1M0NQaW1yQmJG?=
 =?utf-8?B?THZ2WHluRmw4Qy9Qc2ZNMjc0MGVvdGdPSW14akVoQzVmb0o4NmJMKy9oNmhN?=
 =?utf-8?B?K0tnTEloN3A2QlMxTVZYUzdmWjhPNjF0YnNBem56V2RJZk1MNUFidmM5a1pk?=
 =?utf-8?B?QUY2eU5yWWgzVk45Yjh4MlllUk9ZRngxNXVtR2djNXVQeUU3OGdqRkRMTFRE?=
 =?utf-8?B?bHorbkRtL2wzZG55KzAxWUtPaEZUZzZEV3Zzb01ITlhrRmg4WWY0WUV4R1h2?=
 =?utf-8?B?NUViQXlhNk11U00rQjgzVEJ2T3FoY2RHY0kzaUVPeDE1WFF3cFI2T1dNVTBp?=
 =?utf-8?B?WWFIRVo2WUpiNitVUjZpUWE0eXJRV2hKOUtvVDRIVjBPcjdzbG4yWWlwL3BX?=
 =?utf-8?B?MWdmMit0WnpsUWlEQkdhMS9Gcm9uQS9DRTQzRlhvTlVFVktTWmc3YzdSU1pI?=
 =?utf-8?B?Ritib29IeGJXMitxSlVXdWJ4dnczMlFjUGs3U21lbGtGYk1QMjBzVENSUFZN?=
 =?utf-8?B?MnRvZ204WmJCRGl1ODBzVXR6eVhmWDVHWDN5L2FiQ3o4SVdSY091cDF3SHcr?=
 =?utf-8?B?RU02L1hXL1NSVCtBVnF6NHA1dEZyN2wvUVpBcjlxK2pxTVpIMk4xQnJQMGVB?=
 =?utf-8?B?dURzb1hJaVBnRE0wbDJ3UE9ydXY4MUNYRDN5aW96T3RreThsdkxEVURQRlJZ?=
 =?utf-8?B?eFdNKytwTW9MOW40T0hnejdUdXNvZVZ1Z1BPSzFISm1ydFZmWkF6WGhIbGF3?=
 =?utf-8?B?MlZGQXgraVVNd1ZhQjhlbk5iTjV0ekwxdHViQUorUEs1WG1JQUVUTFBnV0d2?=
 =?utf-8?B?NnFIdHBxOXdZdFJaWFd1dXdvSjBYeWh5WHdDME1tWWVKdzZ0WjVJYlNtN3lZ?=
 =?utf-8?B?SmtDZnBzcy9xMCtBT0tPSEFaYXp5alZrTlhNUnBPK25BTDN2WUloaGZKNElj?=
 =?utf-8?B?cWxnbW9weXd5Z0lSeU14NVBmcEpSS05iNlI2OG5TN1A1TEJzR2FaYWtIekx6?=
 =?utf-8?B?WGJzQ2grYTQ2RmVNVzQwZEdCZFhwMldsdkcwbFhxRlFhUFlCeW5EYk9JemJM?=
 =?utf-8?B?Y09tUFB5KzVpbUVuMHRleVNuZEh4QnR5b1RQb0xvSXd5RkFLY3ZXMDVWWGlF?=
 =?utf-8?B?cW0vN2dhM09HbEVpUnFyMWtzM2tmT003ZlFXTUw3RkQ4cEc5dXMvU2hFNEly?=
 =?utf-8?B?VE1GTmdpRlpSeVh0STdyUXpNdGQzNFlJOGVaTTk2MjhlOTI0cVIvSlVNNVJv?=
 =?utf-8?B?cmtLa1ltM09TT21YZllJb3AyRFljMm4wWjg2c0VsT0FTVEFQRFRyWjNPUC9B?=
 =?utf-8?B?aHpFdW45bHdXSFJrYXdEU1lQelJLTVB4SGsvdUtoQVZOMU1XYTRRcHMzTlRB?=
 =?utf-8?B?KzlyVzZDR2NDby9ZMjk0M3RVNGZpaVIxNHRocENlN0xHZHk3YjUxcWJVWThn?=
 =?utf-8?B?TXdCUUdQZHNhc1VnVys5b09zS2oyd3FnbTFFUXhTOHlPRk1xQ3NYMTRCcUx3?=
 =?utf-8?B?bnJhb2grYjRUZ0tubEMya1U5YS9TRGJsckdZV1Fjczc3a09mZkRtdERWcTYy?=
 =?utf-8?B?RDFjVUZCWnQ0MFNiSk9OUWsyWm5XVTBqWlBhTHJyT3Q4UmlrYjM5cUtFSmZB?=
 =?utf-8?B?N2syUFFJdjVNc2tNYUtyUzEzTzNZcVVkYzBCUmh0b1NaSTR0UUVPTTFkMWc5?=
 =?utf-8?B?UjVvQXlxMjRVVXQ4V3MydjRHSVdycnJha2VvV21FRXY0TjNMM0xrVUFSbE4v?=
 =?utf-8?Q?03kZoMB8kNg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9996
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6f8259df-1ce9-4924-c160-08de0ca86d84
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|14060799003|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NThxN1l1UzhtMmJNZ0JHN0xJUW9lNXd2a0dUTk93cXI1a1VDMEtCUit5VkJs?=
 =?utf-8?B?emQxQ2JDMVlSakhNc0hCRzgzYkJxTE1haFo4TWQzelYya0NEbk9NaFg0NVV4?=
 =?utf-8?B?ZnZJL2NMU2xzQzNPRDJWU09ZQ3JCcGFhbWNidVBMUjA0Y1RDTnV2VWY1cFFR?=
 =?utf-8?B?QWRZNEJEZUgwdDlEdWI3R1JIbUNFVzhCajNIbldTbE1ZUitZMi9YSVJ6eGhT?=
 =?utf-8?B?aDdQaFN0Y2hLM0VuczJ5cEtvVDBXVVdsQVVyTWhsK05MMkdIZzhjWjVHd0F2?=
 =?utf-8?B?Z25HNUZzQUczNEVGY0UxaGtIY0F4TjdvMzdEUFByd0tiSmo3TDV1UUo5SUJs?=
 =?utf-8?B?QWVPM3lLZ0dIaFdzd1VEMkJyT0NOZW5KM1ZhUjYwcU4zUjNjZGlGSW02RmZP?=
 =?utf-8?B?K0VtRG5ZTlh2Z2JPYk9weG5yOThsSXBkOE92QWJYeVBPd3VSMC9pRWtjOWdy?=
 =?utf-8?B?cHFRL0xKWm5sUTR1d2J1UmNlcjlPbUdJZVZTQ2FsQzcvU3BlQklQQWpNdUx6?=
 =?utf-8?B?SFlaOXBjWEJ5cGJrenVSYUdGS0lNQkw4Ynp1aExIemx3NzhHZnhsZW11UXZn?=
 =?utf-8?B?QXVSQ0hKQmRzUkp2YlJVRWdQVGd0aFM1bElQdDYwK3RQUHM1MS9RTzdsaWtp?=
 =?utf-8?B?MnNDRVdFRGdqNEI0MHpoT2txa0I3MVlndGFSSVk5UzdFVFBIQkhHWjFtMTJj?=
 =?utf-8?B?cUJDQUdnOWtZRFdTLzJCNURqckdvd0xSckIrQnRmcEU4OXFId3dRTW1NSWZq?=
 =?utf-8?B?cTJqV2VYcExSSU9SVUdTK21KRWJzTlJiUUxObVMxeTF0VnYzS1ExOXJJTGJW?=
 =?utf-8?B?VXFOT1U4ZU5lVW05NVpvV3BabFBsMzBkWGdlWTFRRWtNZmxFV1A2bFFubEhs?=
 =?utf-8?B?aDlQdjlMRHlPc0p3cG9KQ2RRbTBCNzZ1RFBMaDI0MElHYm9IRjYzNThxS25V?=
 =?utf-8?B?K24wYXlkVjA0ZGRqbEdxdEtmTExIWWsvUUJPaXNHWVgybEJ0T0hsbjZ4U01J?=
 =?utf-8?B?M0xpK1pTZW9KOWU4WDg5SVJPbk50cTN5dFNoNG8raHlBWklzUjFkV1Vac1h4?=
 =?utf-8?B?OUc5LzNFZy9waVFqRXoyYlIzcGxlcXpEbWpzcWViUVVwc3puczltaWErck5j?=
 =?utf-8?B?QmltWUduWUxlMjJoTlQrQVpPU3kwUm1KQ3EvT2ltVkRzdzlpdkQxbitiNXIx?=
 =?utf-8?B?ZW5Sd2VRdHR4aHlGMlM3Y2lrOFFEQ0ZsbFFyYjFpRFdZeFpEajQyZ2gyNkp4?=
 =?utf-8?B?aVJuRHdHdWNUMTNRR29vWDNNZmhYRjRFclJyTXBWVDVJQ3pyMTdDU09uQVJU?=
 =?utf-8?B?VVFwTWpOanBXMjBFK3RwbC8yWDFxS1FzWTkzU09oMkpKVWZvMWFDRHQ3VHRV?=
 =?utf-8?B?SkMzaXZKL3crajVMRGRVSzgxdE5tclI0MWpkTWRsRnpoWTdaanlibGZybVZu?=
 =?utf-8?B?T1JRdDEyMDB6OUllUnBaQlVkNmZXb0pweUxzVmRDdWVvWHcrS1dDN2Y2UnRT?=
 =?utf-8?B?d2w4aTBBRFpNWHl0UUhWa21CSURiTEVPOTFCMXd6Wks5ZnJkV0ZNbm5iMHRR?=
 =?utf-8?B?eE9pRkdFdlVOWWpGOWZlbkdhdE5WVDErMDFNNXJoaDg1YlhMbTlSaGVMWjlY?=
 =?utf-8?B?aWFxSnI0elF2Z09oRmxmaEwycGZvTXRoRFExaks5OFpZcS96d2grVTUzcmEx?=
 =?utf-8?B?bFU3eXdteGEvak5UVWlHWmMrMkFmNi9tL3JOWWRUV1VRUzNHWVRRc2pJZFJZ?=
 =?utf-8?B?bWM2VHlUNWdMMkx0KzhEaDlxRTMwRTkyRjRQenhwYmRXbDFBY0VDeG1CM25v?=
 =?utf-8?B?ZHlxYjRGSXorNjhVUDBVeEkxbFV3VjlncnpHSHhabHJISFd6ZEt6S3kxaGxx?=
 =?utf-8?B?K3B3a2hkcCs3WFhxYWV4bHhzc280ZC8xYU9oUENsUDg3K1lLbGhqb3l4c0E4?=
 =?utf-8?B?YUVYTEI1czNqY2d5ekFXbHFYdUtOZlVNRXNIQkdzWWhLaHNWaWVuOWRrbGp5?=
 =?utf-8?B?TzkwUTBBT1JJYUM4Y3BhZ1d3ZnpKeEF3Z0FrTFNYQ08xQmI2M3ZXaXc0WnFt?=
 =?utf-8?Q?o39m08?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(14060799003)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 11:38:23.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bdb1ba-8c80-4950-59b6-08de0ca88375
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5924


On 10/15/25 11:35, Juri Lelli wrote:
> On 14/10/25 21:09, Pingfan Liu wrote:
>> Hi Pierre,
>>
>> Thanks for sharing your perspective.
>>
>> On Sat, Oct 11, 2025 at 12:26 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>
>>> On 10/6/25 14:12, Juri Lelli wrote:
>>>> On 06/10/25 12:13, Pierre Gondois wrote:
>>>>> On 9/30/25 11:04, Peter Zijlstra wrote:
>>>>>> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
>>>>>>
>>>>>>> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
>>>>>>> tasks (like schedutil [1]). IIUC that is how it is thought to behave
>>>>>>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
>>>>>>> it is not "transparent" from a bandwidth tracking point of view.
>>>>>>>
>>>>>>> 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
>>>>>>> 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198
>>>>>> Right, I remember that hack. Bit sad its spreading, but this CPPC thing
>>>>>> is very much like the schedutil one, so might as well do that I suppose.
>>>>> IIUC, the sugov thread was switched to deadline to allow frequency updates
>>>>> when deadline tasks start to run. I.e. there should be no point updating the
>>>>> freq. after the deadline task finished running, cf [1] and [2]
>>>>>
>>>>> The CPPC FIE worker should not require to run that quickly as it seems to be
>>>>> more like a freq. maintenance work (the call comes from the sched tick)
>>>>>
>>>>> sched_tick()
>>>>> \-arch_scale_freq_tick() / topology_scale_freq_tick()
>>>>>     \-set_freq_scale() / cppc_scale_freq_tick()
>>>>>       \-irq_work_queue()
>>>> OK, but how much bandwidth is enough for it (on different platforms)?
>>>> Also, I am not sure the worker follows cpusets/root domain changes.
>>>>
>>>>
>>> To share some additional information, I could to reproduce the issue by
>>> creating as many deadline tasks with a huge bandwidth that the platform
>>> allows it:
>>> chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
>>>
>>> Then kexec to another kernel. The available bandwidth of the root domain
>>> gradually decreases with the number of CPUs unplugged.
>>> At some point, there is not enough bandwidth and an overflow is detected.
>>> (Same call stack as in the original message).
> I seem to agree with Pingfan below, kexec (kernel crash?) is a case
> where all guarantees are out of the window anyway, so really no point in
> keeping track of bandwidth and failing hotplug. Guess we should be
> adding an ad-hoc check/bail for this case.

Yes right

>>> So I'm not sure this is really related to the cppc_fie thread.
>>> I think it's more related to checking the available bandwidth in a context
>>> which is not appropriate. The deadline bandwidth might lack when the
>>> platform
>>> is reset, but this should not be that important.
>>>
>> I think there are two independent issues.
>>
>> In your experiment, as CPUs are hot-removed one by one, at some point
>> the hot-removal will fail due to insufficient DL bandwidth. There
>> should be a warning message to inform users about what's happening,
>> and users can then remove some DL tasks to continue the CPU
>> hot-removal.
>>
>> Meanwhile, in the kexec case, this checking can be skipped since the
>> system cannot roll back to a working state anyway

Yes right, I meant that:
-
when using kexec, the kernel crashes
-
when manually unplugging CPUs with:
`echo 0 > /sys/devices/system/cpu/cpuX/online`
The kernel returns `write error: Device or resource busy` at some point 
to prevent
from reducing the DL bandwidth too much.

------

I  could not reproduce the issue you reported initially. I am using 
a radxa orion o6
which has a cppc_fie worker.

AFAIU it should not be possible to add/remove bandwidth to the 
def_root_domain.
During kexec, the following is happening to all CPUs:
\-dl_bw_manage(dl_bw_req_deactivate, cpu)
   \- // Check if there is enough bandwidth
\-dl_clear_root_domain_cpu(cpu)
   \- // Recompute the available bandwidth based on the remaining CPUs

So I'm not sure to understand why accounting some bandwidth to the 
def_root_domain
is problematic in practice as the def_root_domain seems to have some DL 
bandwidth.

IIUC the problem seems to be that for some reason there is not enough 
bandwidth in the
def_root_domain aswell, which triggers the bandwidth overflow detection.

>>
>> Thanks,
>>
>> Pingfan
>>> ---
>>>
>>> Question:
>>> Since the cppc_fie worker doesn't have the SCHED_FLAG_SUGOV flag,
>>> is this comment actually correct ?
>>> /*
>>>    * Fake (unused) bandwidth; workaround to "fix"
>>>    * priority inheritance.
>>>    */
>>>
>>> ---
>>>
>>> On a non-deadline related topic, the CPPC drivers creates a cppc_fie
>>> worker in
>>> case the CPPC counters to estimate the current frequency are in PCC
>>> channels.
>>> Accessing these channels requires to go through sleeping sections,
>>> that's why a worker is used.
>>>
>>> However, CPPC counters might be accessed through FFH, which doesn't go
>>> through
>>> sleeping sections. In such case, the cppc_fie worker is never used and never
>>> removed, so it would be nice to remote it.
>>>
>

