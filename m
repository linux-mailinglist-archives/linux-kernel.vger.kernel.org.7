Return-Path: <linux-kernel+bounces-747383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2070B13332
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCFE3B719A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499371FBCB1;
	Mon, 28 Jul 2025 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pWBW2dm2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pWBW2dm2"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF860DCF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671326; cv=fail; b=GpZakR4FEVNr+XdoOAFl8fzdZxw647XjrnatKaTRpsoLTbAPe7HDzgzwhxrzx6ozNeZfngZQOTI9S8KghQN9dtnDVXrA0Dn+u4UD0wXlQ1Ya2z3I/EBOq31Hu7SolGa5WsOTiCis8v8nz/32J2kFiOHU6aCi8K+9Iktlyrw/cnc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671326; c=relaxed/simple;
	bh=HyglkgFcKQv07fuH03l3t9uJ/RbRdYQufCMsVgUjbks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cDWWQOd/H6SJRbw09wMLLVUO80ycu8LCFtRkKwOBQzF68OhoKjEf7tzIkRQRl3lHDwgApA7wjnMV4cyBe5synictIRk8GKSn05otunf0y2CWaIoevGBiIqWOCKTPzWU0mV5kq3/dufVL1WPrUkdmNSaEnlgWwsvtx3Yo1benNis=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pWBW2dm2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pWBW2dm2; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZROjahNmM+T3kUNO48ZOCKtzWy1KRpzbA1baj8xX9dhirBohGdk2LxOtNh7+VNwz5uJxL53XjgEcLF42T5kORk/jHPqFRNmxyWM1Dmj+Iu9d5NMyKsXFtBxUscfMkMgDygYkWTfVzTzChfWnwaHaa1Om/FOuTxDUh426sN95+hz5A/gDbJD+0wv8RuyHZvBZ6aIvJeI4/tes2v4xDWFi3Yocn/PUpjc+VmvI7FEw0zYcNAKlIeBKYZqPVZeXCx9n56ox/HTm6Akw3oDECb/+HLwmWUyOZdfI0PVvqLCWR8lFw/UoUGxnmolQWMfdpJnAtQjXZoyAnOkAd+iwm7lnvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyglkgFcKQv07fuH03l3t9uJ/RbRdYQufCMsVgUjbks=;
 b=KSmtZGty5xbfX7a7Aip2acviDRu2NbWu137JfdOnbnaA/D9dZKdoAOgljsW/j2xyzTvd4NzhSX6ZTmXPxCJ1tTmdH5owwBUc5rxAeJS/F/a1J+YqBBrQ1g7A6auESfabmOAJ6FQdh0mHJq8G9KnxLPJrYZdnpnbYKh73VQ0cEESSm3FGp2ImluOi2IcMgnLtKmbnyoK+LYtuFLeOBDX+OrQz8qI/xv32RnJFr2bDDe4rNjTa40CV1/WnOMSCb1lcjQ7tObOn739r6KLnmrma6LTTXxLIqnINRQ70mvEoI4ovcV2NH70xS1BP5UTORmXACxORHM5gUEt8raq1dElgug==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyglkgFcKQv07fuH03l3t9uJ/RbRdYQufCMsVgUjbks=;
 b=pWBW2dm2vt1JJOWybmZJCXLEujV4q8mooAdDlwJq58q1g+TOGZn93B3fSjiBLSA4lB5Qspzka20gQ5gZdUUhYPjsK5Crc1JbmTIzL7vNqIv0CIVcs3YqXIkf0QZWVi8QQqBb1O/QQGnC0rjD5wZ0W0yB+gBMm0LtBYFMxw24OJI=
Received: from DU2PR04CA0208.eurprd04.prod.outlook.com (2603:10a6:10:28d::33)
 by AS4PR08MB7631.eurprd08.prod.outlook.com (2603:10a6:20b:4ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 02:55:17 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::f5) by DU2PR04CA0208.outlook.office365.com
 (2603:10a6:10:28d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 02:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Mon, 28 Jul 2025 02:55:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJpXUBzosoU8DYCdEeXcSM93iaAYAO4uMOqSt+hw0NVGG+VH7YXr8dHkQG6v/gEMBunZJ90L6iWd/CfMc71m2261KpCQAY6cYcy1GDheX/GdyqjZcGcHuKYKb4gBsJfayQsyOODjHB/3nfk2EqXw/nVLQXCBDazTveDvy9HCBqAxcrQA8a/97jbGuxrPyRVGo95j4h+4ZKLZmNrEwieJvTHLuUuN9fRduGyi5P+ZMcwB7VrcImoEZg010sadl8ni57YUhIrMidQf9V0cwz6Q66kEMAcTdNrDpU8teIFElevetz2MUg1CqOB12Tpzyd7yakpcmQSaW+gyTO/kJw/sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyglkgFcKQv07fuH03l3t9uJ/RbRdYQufCMsVgUjbks=;
 b=M4UiBOToxML9QTkZ6BJrm3j+eNevHCzqSdpBFJciR3/amxF1nJyMgDfd0qaBLhf4aceXW6cy7esZXuVW0CpYNj6aV++l4BOOcoEAZPShY9KuI2Ea8fmQRiCWRDKnOkXlLZlfy6fqgTD6cwZCFiD7N7L8iU+uxhAiyFSCJ8doz3IhdIHpS6DtBhqa2YDy4spCjmxSlzEHvsqa2b1X5LGcQPZyYrlBE9g07h1Z6+d4CEiJCVpmcjMJeQZv/Zneayl+g+KV1Y9zmubGVl0wUm/bUDu4AA247BpdC/8davw5eKEmvOS0vxDr0sUj/M/kdhXXhRRDayqHY9uP3dF5jcPuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyglkgFcKQv07fuH03l3t9uJ/RbRdYQufCMsVgUjbks=;
 b=pWBW2dm2vt1JJOWybmZJCXLEujV4q8mooAdDlwJq58q1g+TOGZn93B3fSjiBLSA4lB5Qspzka20gQ5gZdUUhYPjsK5Crc1JbmTIzL7vNqIv0CIVcs3YqXIkf0QZWVi8QQqBb1O/QQGnC0rjD5wZ0W0yB+gBMm0LtBYFMxw24OJI=
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com (2603:10a6:20b:605::22)
 by AS8PR08MB8247.eurprd08.prod.outlook.com (2603:10a6:20b:522::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Mon, 28 Jul
 2025 02:54:42 +0000
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::5de8:31fa:51f8:29e1]) by AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::5de8:31fa:51f8:29e1%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:54:42 +0000
From: Justin He <Justin.He@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node mapping
 to  reduce max_distance
Thread-Topic: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node
 mapping to  reduce max_distance
Thread-Index: AQHb+r8gfQL0R06fgEqHshXLBSLgJrQ9og8AgAk7zQA=
Date: Mon, 28 Jul 2025 02:54:42 +0000
Message-ID:
 <AS2PR08MB978689001CDED54ABD33FAF7F75AA@AS2PR08MB9786.eurprd08.prod.outlook.com>
References: <20250722041418.2024870-1-justin.he@arm.com>
 <2025072202-june-cable-d658@gregkh>
In-Reply-To: <2025072202-june-cable-d658@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS2PR08MB9786:EE_|AS8PR08MB8247:EE_|DB5PEPF00014B8E:EE_|AS4PR08MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd7ae7d-5ebc-470c-a63d-08ddcd822e9e
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?b09pQUsyNk0wUTFPNHlQOGpBcS9FTnlWejBuWkdWL0NaMzQybG50R1NQd0o0?=
 =?utf-8?B?eHlwODljeVQ4UTNXTGZnV0tGZFRrZjRQZ1BjV1lPR2c2czI2czdzYkhjOCtt?=
 =?utf-8?B?Qk12UEduUEhVamFDRjZUYTgzdW40akxWSDlBdjlud3g0K004WXhJdTkza2ZK?=
 =?utf-8?B?MUxHWGYyR21WQS81VDV1VE9pTUZQc0JkdHd6L0tWODNYbk1QYkxtdWJFRms0?=
 =?utf-8?B?REhCTUFGSFFnNnA0S1RwWmZ4c3kyamNldFlvdnNHRE5KdmdpV3RBUjRVMjRK?=
 =?utf-8?B?bnZnTlp2TkZnYUxGWWxEdVNGL25aWnBZbVFKT2ZlQlA3SXZ3VExMRmJiaEYw?=
 =?utf-8?B?WlJtOXJsVFdVR2JSY2lnamRqZU0yVkdUOFdEV2wxUHpnTDYzTGEvMUV1YWRw?=
 =?utf-8?B?RjEycmRQZVF5aE84cGdrNEIxS1J5T243R0xRZzRTWWoyM0dXZUhmeEtjOVZN?=
 =?utf-8?B?WlZVY3ptdk4zUWh5YTBrWVNubnNORTF5dDc2YVNGdFhkcWRBdGpNeWJBcWkz?=
 =?utf-8?B?aldESDFqa1IvbDRydHNkTE4rUlNHRzF4SS9nYWc4MDZEZVpqZzBVSGdqWFBi?=
 =?utf-8?B?RHR2NllIc3RsYmFvT2R3V0NpdnhkWTh5M01YMk05Y09aTDNnNHZVbUhqak1t?=
 =?utf-8?B?UUVXMXNqVmdXb2FiRys5WHNCWHQyUUtBRHM3Q01NQXlrU2xLT2RKTEdqblFt?=
 =?utf-8?B?WFo5RndwM1Q5dEhDeGJKQjZLNW9DY1dSSG9zcmVTTTNoT3U2VTZWNUFWL3Fk?=
 =?utf-8?B?clBHQmIrbnFGNWdPK2R6MDFTaFdhMTNPb0RVQnNCcGt4bGpPWERROFdSbkVM?=
 =?utf-8?B?M1J2Z3VxbmNUb3VxbVdLMVB6aGtIN2ljcXQwVTlpb21odzVINVlWRlhUbU9a?=
 =?utf-8?B?WFMzbWRNZVR2NnBabXFpNW9yTmlWUkZwRkt2NDdlOXBXWnFYWk8xZlc4MUdR?=
 =?utf-8?B?WGlSQlpFdzlnaXQ1Yld5UEMrNitsTU8rZnJLQkRIa3JXRzM1Q0d5cWVEU092?=
 =?utf-8?B?cFhoZFhOUWw1a3BYVDFhZDVBbmI1SjZtVHIxQ0R0MnpYR1ZVY3FZS0xmQzBB?=
 =?utf-8?B?NHcwWVRLRXpRQ296WDFWOHpBWk9VWDI4emNFejVPeFMvbTNaQjNEWWU5bjI0?=
 =?utf-8?B?RTM1ZEFWSlgweEZQR3dhb3U3N20yRmdHWWdqSTFuLzBjUTdTVFNoRGZNTHYx?=
 =?utf-8?B?bmRpVVJzRTRTbFpreXVDVkQ1VVFLZ09XZkJpcVd1MjJ4eGphQURSTktYMWxw?=
 =?utf-8?B?NFpYbDlSK09nMkU1cGNjRTQ4MlpxWm12Q2RIb3dzQUhUK0tiVjB6OHU2SUhI?=
 =?utf-8?B?cmQ1T25ZOVR2RnJQbVpiZjBtWkdzWlBUS3RMdHFBOWROMUN6ZzViMUVjaE9y?=
 =?utf-8?B?TmhFK0M2TVdjTmdEaFlGSmJYUU5pWXJaMnBxMG5EbjFDaDRSWlc5MVpBTzFZ?=
 =?utf-8?B?S1ErNjBYa0ZrMlJZUENpeDNCekxnNjQ5czBkYi9teWlQWkxDMHc1SFRNVGpN?=
 =?utf-8?B?M1dqcHB1UVUwZGovWE5PZXAyVFNRdklwRTRMMWZSVXI5VGtaemJCQVZBUFVp?=
 =?utf-8?B?d3YyUU5adHZKZFdTM0NvUzEwektJL3NndlNaQUVMUmRlNmYrNDA2NHczT0ZU?=
 =?utf-8?B?b0pGaGFlZ05kNEpUajJEUTBUZ01xQWkvS09wSDA1YnNjamY4RU9BQ0RsYUJn?=
 =?utf-8?B?VFNFMTUvRW9tbGczRFZySk9SOTZtdWhkVHA1Tkk4Wno3T0dXVDZSdUw5bGdK?=
 =?utf-8?B?bXErVUFBRXhjSGxWUHFGb0xTUlpqWHRuZTdldnJsQ204UloyWTFhWFJMOS81?=
 =?utf-8?B?QnZ5eHpjTVR0UzVOd2NEWjJLakdKMXgyZlU0VG84eGxVT3NqZnR2YktOZzkv?=
 =?utf-8?B?aTIxRE9UdjRlYlhiVStBc1lDbFN5ZDFndmh2ZW5Nbm5nenBpa21OME9ZMWI3?=
 =?utf-8?B?Ulk0eWI1NWUxRk5XdHJMeUpZa09GcVVudnVnZlpUTHhvTUxlRkdMY1lVRVNG?=
 =?utf-8?B?MWxMbzJuVGtnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9786.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8247
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b10a8aa4-2767-4fb5-9f5b-08ddcd8219ec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|376014|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azZHUTVSM2tSMnl5K1B6bGVsNUdZVENWa2I2ay91Wk1HUTVXb2xEdVl6MjNr?=
 =?utf-8?B?UFUwcUVRdDkyUVJIOFdwMktiSDdwVWNyWVg2U0hLbnZsNk9WTi85ZXZvbDNq?=
 =?utf-8?B?cmhSRlhvTW93Wnp4bm9ybnhMTU1ibnJDMUVxSjZMYzRvcUZHdWlSSURlZEN3?=
 =?utf-8?B?Q01RbVdoSEhJOThnWFN3UmE3dXQ5c1BrUjVzbC95NThtRGNrUGVDTWxSdElz?=
 =?utf-8?B?N1NuU2JsRVc3QzVxOUFSSEtDVW9lUkRNQ0k2cTI5emFxZkxQeUlydnlPY1k0?=
 =?utf-8?B?MmoxQjB2VURLL01YVDY1NWtwdUxlU3Joam4vbnBLbnhmQURDWFdja2pNaGZn?=
 =?utf-8?B?eE82Vk53NmhNQkJRd21TY3ZxaUxRajlpWERWSGhpWUxnbU9qR3ZCbVh5UGN1?=
 =?utf-8?B?NWxSV1J3SmtqdSswRDV2dWpsOUxkNXRXeEI4NEIyWDRDU0FzVjlFREYwdndj?=
 =?utf-8?B?QjdZalBMd28yelhBaGlPakNoSFBmMmFmYk9DZnVyZVZyZGVLeUdlQkxtV2dD?=
 =?utf-8?B?YnpvZVljVUFzWFBrWlJPNktnVGtWa0x6VFpxb202VkYrK0FlUXNST3NhU3F5?=
 =?utf-8?B?M1hzRlNYSGV1dzdDRUNaOGFjd0U3Q1Z1L0JWNkZ4NFlieUVHQVB2MGsraHRO?=
 =?utf-8?B?aGQ5QllKOEF5ajZqVkYzYTNjOWtzOFVOVG9xMm12ZExPZkFxVVorQkxmMjk0?=
 =?utf-8?B?YURCUkIybzJmM256ZTBETG83ZExjUE5yT3RkcHl0bENWV20vVXFDdEY0QlBP?=
 =?utf-8?B?cm9DSjVCMHhjRG9Sb0NLcUQyZ0pvVHhVV1VCR0N4aDkwTFpFb2Y4dUdsK2Ni?=
 =?utf-8?B?OWVJT1hpdVd6T2VPOHdQY0swNWJXMk9nd0xhV1ZpTG1VQWNiKzNWM2tXZUVH?=
 =?utf-8?B?cW81T2Fwd3ZKTjVkNG5BVGdrUnJpcXFreW0veUZ5RXV0M0JRU084R2ZFMFJa?=
 =?utf-8?B?MWRaZlRoN3FHaDM2cUZFSXNQVXpsS1NnMXlNZENkZU90WkYvWXhhdjczeFd3?=
 =?utf-8?B?czBJNGV5WElXYWp0c2hPczBxMjF4N3ZQOGo2K1ZkdUU1MVhPcHM4OU9lbEF5?=
 =?utf-8?B?MmVhOXM5T2FBdGxkUzNsa0dCUjBEeWY2OU5YYW1DTEJNN2RDTG5IUVg2dDdt?=
 =?utf-8?B?aHZTamdkand5ZEFvNDc0aThyVktYUGZsUFhWenZ2N2hlcTVWcnVYaC9Obkc2?=
 =?utf-8?B?bERXOTlOQk96Y3NzcmZoeFlSdlpnSXh2RXFEQldtK3ZDSy8yMnZxZklJQis5?=
 =?utf-8?B?bmhlVC9zb1JVUVk3amxyTkVzTFlwbUd2ZE8vQytpdWZXWmlqdnJSN1dGN01u?=
 =?utf-8?B?TDNNS3A0MjdNamMwRll1OVpHODdHSlR2QW96blBBT2tpUDljQTU0ZjI5TVhh?=
 =?utf-8?B?dmNZVEdTT0sraDh0d21pclJueFNGUU9tWFNQRVErMVdVWmUxbGpSZGNXS0Ru?=
 =?utf-8?B?cU83RnI2K3pvMTZzTkxjWWxiQ3g2aWRpcVFpMndpTXY3WElEWHQ0MWN6Mkk4?=
 =?utf-8?B?V2NLMDhKS2JmVUlFMlRZdVdhUFByWDBiNWtYS2QxNW5zblArOC8yZ3BrUjNu?=
 =?utf-8?B?QUNsT09rRFB4Um9KWnJhQXlqeG5VN0tncDZsUXUySFVjQkl6NVJRQU1Jc0Zq?=
 =?utf-8?B?NjJJajFEQTNYMGNlRGVjNEdQT25tSXRLMS81TG9kekkzVkJVM24yakVmM1Fp?=
 =?utf-8?B?UTJjc21neHA4OFU0N2d4VGJ3eFJHZkZsL3E0VWRrWTZtVkxPUG5JNkhGbDUw?=
 =?utf-8?B?L2JjbVJVejFrNERBeVpvV24rUys3OTNUMVpxbEJnb2Y2N2tsdGZNMDFzd1hL?=
 =?utf-8?B?K2ZvT3M4d3dJRll3Y0lPSzd3UjVuanU2aGJOMTJuRnE0eDdWOXc4Z3I0d3Y5?=
 =?utf-8?B?VUlLNzRaeDNJamJNd3FlM1ZGRGRWYkxvNkwvaiszc25tUUR5TGlMZ0tpbEgr?=
 =?utf-8?B?dkdNcWM5M0pEMFZtT3Q1U1d4bWhvaEliclI1VXowckdyN2NhcjlXZVFBcENG?=
 =?utf-8?B?dFF0QWRlbk1lTUJZYmxmTnRPejJNSGY3NEt3UmtPb3FaZDQ3cjVjZzdyWG12?=
 =?utf-8?Q?4k3h8p?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(376014)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:55:16.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd7ae7d-5ebc-470c-a63d-08ddcd822e9e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7631

SGkgR3JlZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdyZWcgS3Jv
YWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bHkgMjIsIDIwMjUgMTo0NSBQTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNv
bT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IERhbmlsbyBL
cnVtbXJpY2gNCj4gPGRha3JAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbW06IHBlcmNwdTogSW50cm9kdWNlIG5vcm1hbGl6
ZWQgQ1BVLXRvLU5VTUEgbm9kZQ0KPiBtYXBwaW5nIHRvIHJlZHVjZSBtYXhfZGlzdGFuY2UNCj4g
DQo+IE9uIFR1ZSwgSnVsIDIyLCAyMDI1IGF0IDA0OjE0OjE4QU0gKzAwMDAsIEppYSBIZSB3cm90
ZToNCj4gPiBwY3B1X2VtYmVkX2ZpcnN0X2NodW5rKCkgYWxsb2NhdGVzIHRoZSBmaXJzdCBwZXJj
cHUgY2h1bmsgdmlhDQo+ID4gcGNwdV9mY19hbGxvYygpIGFuZCB1c2VkIGFzLWlzIHdpdGhvdXQg
YmVpbmcgbWFwcGVkIGludG8gdm1hbGxvYyBhcmVhLg0KPiA+IE9uIE5VTUEgc3lzdGVtcywgdGhp
cyBjYW4gbGVhZCB0byBhIHNwYXJzZSBDUFUtPnVuaXQgbWFwcGluZywNCj4gPiByZXN1bHRpbmcg
aW4gYSBsYXJnZSBwaHlzaWNhbCBhZGRyZXNzIHNwYW4gKG1heF9kaXN0YW5jZSkgYW5kDQo+ID4g
ZXhjZXNzaXZlIHZtYWxsb2Mgc3BhY2UgcmVxdWlyZW1lbnRzLg0KPiANCj4gV2h5IGlzIHRoZSBz
dWJqZWN0IGxpbmUgIm1tOiBwZXJjcHU6IiB3aGVuIHRoaXMgaXMgZHJpdmVyLWNvcmUgY29kZT8N
Cj4gDQo+IEFuZCBpZiBpdCBpcyBtbSBjb2RlLCBwbGVhc2UgY2M6IHRoZSBtbSBtYWludGFpbmVy
cyBhbmQgbGlzdCBwbGVhc2UuDQo+IA0KT2ssIHRoYW5rcw0KDQo+ID4gRm9yIGV4YW1wbGUsIG9u
IGFuIGFybTY0IE4yIHNlcnZlciB3aXRoIDI1NiBDUFVzLCB0aGUgbWVtb3J5IGxheW91dA0KPiA+
IGluY2x1ZGVzOg0KPiA+IFsgICAgMC4wMDAwMDBdIE5VTUE6IE5PREVfREFUQSBbbWVtIDB4MTAw
ZmZmZmYwYjAwLTB4MTAwZmZmZmZmZmZmXQ0KPiA+IFsgICAgMC4wMDAwMDBdIE5VTUE6IE5PREVf
REFUQSBbbWVtIDB4NTAwZmZmZmYwYjAwLTB4NTAwZmZmZmZmZmZmXQ0KPiA+IFsgICAgMC4wMDAw
MDBdIE5VTUE6IE5PREVfREFUQSBbbWVtIDB4NjAwZmZmZmYwYjAwLTB4NjAwZmZmZmZmZmZmXQ0K
PiA+IFsgICAgMC4wMDAwMDBdIE5VTUE6IE5PREVfREFUQSBbbWVtIDB4NzAwZmZmZmJjYjAwLTB4
NzAwZmZmZmNiZmZmXQ0KPiA+DQo+ID4gV2l0aCB0aGUgZm9sbG93aW5nIE5VTUEgZGlzdGFuY2Ug
bWF0cml4Og0KPiA+IG5vZGUgZGlzdGFuY2VzOg0KPiA+IG5vZGUgICAwICAgMSAgIDIgICAzDQo+
ID4gICAwOiAgMTAgIDE2ICAyMiAgMjINCj4gPiAgIDE6ICAxNiAgMTAgIDIyICAyMg0KPiA+ICAg
MjogIDIyICAyMiAgMTAgIDE2DQo+ID4gICAzOiAgMjIgIDIyICAxNiAgMTANCj4gPg0KPiA+IElu
IHRoaXMgY29uZmlndXJhdGlvbiwgcGNwdV9lbWJlZF9maXJzdF9jaHVuaygpIGNvbXB1dGVzIGEg
bGFyZ2UNCj4gPiBtYXhfZGlzdGFuY2U6DQo+ID4gcGVyY3B1OiBtYXhfZGlzdGFuY2U9MHg1ZmZm
YmZhYzAwMDAgdG9vIGxhcmdlIGZvciB2bWFsbG9jIHNwYWNlDQo+ID4gMHg3YmZmNzAwMDAwMDAN
Cj4gPg0KPiA+IEFzIGEgcmVzdWx0LCB0aGUgYWxsb2NhdG9yIGZhbGxzIGJhY2sgdG8gcGNwdV9w
YWdlX2ZpcnN0X2NodW5rKCksDQo+ID4gd2hpY2ggdXNlcyBwYWdlLWJ5LXBhZ2UgYWxsb2NhdGlv
biB3aXRoIG5yX2dyb3VwcyA9IDEsIGxlYWRpbmcgdG8NCj4gPiBkZWdyYWRlZCBwZXJmb3JtYW5j
ZS4NCj4gDQo+IEJ1dCB0aGF0J3MgaW50ZW50aW9uYWwsIHlvdSBkb24ndCB3YW50IHRvIGdvIGFj
cm9zcyB0aGUgbm9kZXMsIHJpZ2h0Pw0KTXkgaW50ZW50aW9uIGlzIHRvIA0KPiANCj4gPiBUaGlz
IHBhdGNoIGludHJvZHVjZXMgYSBub3JtYWxpemVkIENQVS10by1OVU1BIG5vZGUgbWFwcGluZyB0
bw0KPiA+IG1pdGlnYXRlIHRoZSBpc3N1ZS4gRGlzdGFuY2VzIG9mIDEwIGFuZCAxNiBhcmUgdHJl
YXRlZCBhcyBsb2NhbA0KPiA+IChMT0NBTF9ESVNUQU5DRSksDQo+IA0KPiBXaHk/ICBXaGF0IGlz
IHRoaXMgZ29pbmcgdG8gbm93IGJyZWFrIG9uIHRob3NlIHN5c3RlbXMgdGhhdCBhc3N1bWVkIHRo
YXQNCj4gdGhvc2Ugd2VyZSBOT1QgbG9jYWw/DQpUaGUgbm9ybWFsaXphdGlvbiBvbmx5IGFmZmVj
dHMgcGVyY3B1IGFsbG9jYXRpb25zIC0gcG9zc2libHkgb25seSBkeW5hbWljIG9uZXMuIA0KT3Ro
ZXIgbWVjaGFuaXNtcywgc3VjaCBhcyBjcHVfdG9fbm9kZV9tYXAsIHJlbWFpbiB1bmFmZmVjdGVk
IGFuZCBjb250aW51ZQ0KdG8gZnVuY3Rpb24gYXMgYmVmb3JlIGluIHRob3NlIGNvbnRleHRzLg0K
DQo+IA0KPiA+IGFsbG93aW5nIENQVXMgZnJvbSBuZWFyYnkgbm9kZXMgdG8gYmUgZ3JvdXBlZCB0
b2dldGhlci4gQ29uc2VxdWVudGx5LA0KPiA+IG5yX2dyb3VwcyB3aWxsIGJlIDIgYW5kIHBjcHVf
ZmNfYWxsb2MoKSB1c2VzIHRoZSBub3JtYWxpemVkIG5vZGUgSUQgdG8NCj4gPiBhbGxvY2F0ZSBt
ZW1vcnkgZnJvbSBhIGNvbW1vbiBub2RlLg0KPiA+DQo+ID4gRm9yIGV4YW1wbGU6DQo+ID4gLSBj
cHUwIGJlbG9uZ3MgdG8gbm9kZSAwDQo+ID4gLSBjcHU2NCBiZWxvbmdzIHRvIG5vZGUgMQ0KPiA+
IEJvdGggQ1BVcyBhcmUgY29uc2lkZXJlZCBsb2NhbCBhbmQgd2lsbCBhbGxvY2F0ZSBtZW1vcnkg
ZnJvbSBub2RlIDAuDQo+ID4gVGhpcyBub3JtYWxpemF0aW9uIHJlZHVjZXMgbWF4X2Rpc3RhbmNl
Og0KPiA+IHBlcmNwdTogbWF4X2Rpc3RhbmNlPTB4NTAwMDAwMzgwMDAwLCB+NjQlIG9mIHZtYWxs
b2Mgc3BhY2UNCj4gPiAweDdiZmY3MDAwMDAwMA0KPiA+DQo+ID4gSW4gYWRkaXRpb24sIGFkZCBh
IGZsYWcgX25lZWRfbm9ybV8gdG8gaW5kaWNhdGUgdGhlIG5vcm1hbGl6YXRpb24gaXMNCj4gPiBu
ZWVkZWQgaWZmIHdoZW4gY3B1X3RvX25vcm1fbm9kZV9tYXBbXSBpcyBkaWZmZXJlbnQgZnJvbQ0K
PiBjcHVfdG9fbm9kZV9tYXBbXS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVz
dGluLmhlQGFybS5jb20+DQo+IA0KPiBJIHRoaW5rIHRoaXMgbmVlZHMgYSBsb3Qgb2YgdGVzdGlu
ZyBhbmQgdmVyaWZpY2F0aW9uIGFuZCBhY2tzIGZyb20gbWFpbnRhaW5lcnMgb2YNCj4gb3RoZXIg
YXJjaGVzIHRoYXQgY2FuIHNheSAidGhpcyBhbHNvIHdvcmtzIGZvciB1cyIgYmVmb3JlIHdlIGNh
biB0YWtlIGl0LCBhcyBpdA0KPiBoYXMgdGhlIHBvdGVudGlhbCB0byBtYWtlIG1ham9yIGNoYW5n
ZXMgdG8gc3lzdGVtcy4NCk9rLCB1bmRlcnN0b29kLg0KDQo+IA0KPiBXaGF0IGRpZCB5b3UgdGVz
dCB0aGlzIG9uPw0KPiANClRoaXMgd2FzIGNvbmR1Y3RlZCBvbiBhbiBBcm02NCBOMiBzZXJ2ZXIg
d2l0aCAyNTYgQ1BVcyBhbmQgNjQgR0Igb2YgbWVtb3J5Lg0KIChBcG9sb2dpZXMsIGJ1dCBJIGFt
IG5vdCBhdXRob3JpemVkIHRvIGRpc2Nsb3NlIHRoZSBleGFjdCBoYXJkd2FyZSBzcGVjaWZpY2F0
aW9ucy4pDQoNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jIHwgNDcNCj4g
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jIGIvZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5j
IGluZGV4DQo+ID4gYzk5ZjJhYjEwNWU1Li5mNzQ2ZDg4MjM5ZTkgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9iYXNlL2FyY2hfbnVtYS5jDQo+ID4gKysrIGIvZHJpdmVycy9iYXNlL2FyY2hfbnVt
YS5jDQo+ID4gQEAgLTE3LDYgKzE3LDggQEANCj4gPiAgI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5o
Pg0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgY3B1X3RvX25vZGVfbWFwW05SX0NQVVNdID0geyBbMCAu
Li4gTlJfQ1BVUy0xXSA9DQo+ID4gTlVNQV9OT19OT0RFIH07DQo+ID4gK3N0YXRpYyBpbnQgY3B1
X3RvX25vcm1fbm9kZV9tYXBbTlJfQ1BVU10gPSB7IFswIC4uLiBOUl9DUFVTLTFdID0NCj4gPiAr
TlVNQV9OT19OT0RFIH07IHN0YXRpYyBib29sIG5lZWRfbm9ybTsNCj4gDQo+IFNob3VsZG4ndCB0
aGVzZSBiZSBtYXJrZWQgX19pbml0ZGF0YSBhcyB5b3UgZG9uJ3QgdG91Y2ggdGhlbSBhZnRlcndh
cmQ/DQpZZXMNCg0KDQotLS0gDQpDaGVlcnMsDQpKdXN0aW4gSGUoSmlhIEhlKQ0KDQoNCg==

