Return-Path: <linux-kernel+bounces-842813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7ABBDAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29321888E40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A350227B94;
	Mon,  6 Oct 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JdN4RMaS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JdN4RMaS"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F74223DF6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746065; cv=fail; b=lfqeiAOs5PRNWqIZ9+zJJPay308v8kWFYtoP+8/5SHDrF9UFEnoIVAYwglR9W/jsXz8dq2y17g/HmJ431PQuQQxVKMQcQzsmRq1IGJQs8H90jQ17efKkXXxq060A0l991OTGjPzwODWzzX57z9Ca9eZ2jWWRmAthxgzh3YttE/U=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746065; c=relaxed/simple;
	bh=kaHfMz+uZLdULegOtNbe3P6wiwdNZxm4prUS1RXNu5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwsPudkgyW44Lif7i/5sL5rGYlwd8hbQeZE81iQcUxSlgs48u7wGIhISlT56ayX/J/45xekQ1UhDose31c5JAbsoe6L2yRjeLZib04zz/jaEmfWDCZh8FvF7YhejkRUz7qAnh16QJzsP0NHN5PSv2tF8P9zxO9ty+jQXNmeM5qs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JdN4RMaS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JdN4RMaS; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XlplJDIU4yGFlcsnlDnBIfV1rj9br7eMH00idZVCbzHh+0/Drhi20WJZV562xejKlrhF+8Az4HFdSh/B3ltMLgASJ3DLq/Cb8WZyFRiQgAU3rIDU/eeL4lnMxEWbrPrY5XzyamGSazI2uTgd8jPXbrhCJecuZtmoIcfLoP9t3xFR0D10+w5alxkezyaGIENiagzi8PpqnG8W6qstt09O/GeF7v7A3KmH/Ca6hRSDgM0PhuZOMM0Npu+jzcO1YgtIT76nWDgGl5RumkbOJdMZTL58FcXtfk0kAXOLf5mN7TCl2MTaUsYWBEJhbtk4TuD9RX0jACUEI8MdrTfIL+QFhA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+/vyv/yoA3RB3nzpG64f65uaUzanLf280b8MMkXEjg=;
 b=UpJHMsiJhY2MiY1U+MVeSSEnpENfsbahYlUdWMocip1NNCmA/vJ6UTpYiRCIvZM/qVUjXieiNvgQJQNg7UMFQtQKSafGffO1GqAlDekMqj9LMqHM1r3jQR05mnBSem+xFGHOMZenRwMFzwScqvAqk/+oo0d2io/W8JbHIplufQTa9T+i6HwT99fLTQiGUZDOpTRFuu6wWTePEyS1YsokFR250GoOhSY37xU+WS6vgx1OUJNRKapyR8PXZFymuC8oYGYgBAihOcUZZLFV5eHZE+OXg4k98/AmA2zWdKjzxQQ1k9rsEftqLO0A8F4NC08Soo9IZLtjdZn50WuWly2JyQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+/vyv/yoA3RB3nzpG64f65uaUzanLf280b8MMkXEjg=;
 b=JdN4RMaS2I3MW62yqHksm24KfgrNHysOANbbhram9e6l1AlMsh4cVWN11ykLXU6oiv0TJga11q9Z2EtSr3KyDxPVp8QAxeJkItrtY3+9XELI4O6Y8D52C1VKurhArLWFloGedL9L4PEK8HdjBU1aIAk8WCpr5sr0IIEYbnjqhgY=
Received: from PAZP264CA0107.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::17)
 by PAWPR08MB11437.eurprd08.prod.outlook.com (2603:10a6:102:511::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:20:55 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fb:cafe::e1) by PAZP264CA0107.outlook.office365.com
 (2603:10a6:102:1fb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Mon,
 6 Oct 2025 10:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.3 via
 Frontend Transport; Mon, 6 Oct 2025 10:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ7kv1DxRlvtdPp9s1n9ytwmtsi3wUdf6xwQRrgbXkfN5Cw+d1br5HdaBAfyPKySALiJ6y+yo3HWHxqcU6v6YQVmQdfb+sOmzSBtgb8WCMw4sb6N9eMT4GVrCpxguSRfsp9WDatWRQMSWQpWNWRI6rsYJdoRLqlc2rU3c6MQAgykTktnYlgtHFXTg5IaImPw03zfLW0XYrb5w68yfOAndXwwZBLdL5Y0v6bepQ6cHynFP/QGwXRODHIPNGEPIPxnEP/iQ72uq4tCuc0YujPtqcabdHCaq7wWTm8Nccs9kML7AikQP9eL8psXqHqbdeP2Nc/r/VOLXeThNr46MS8PJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+/vyv/yoA3RB3nzpG64f65uaUzanLf280b8MMkXEjg=;
 b=y6eG4sBw2xvyawoam54EA3CcUiR886wOwvfaoRuIJgOOIRNs9Jr33KbjpUoWRssFIm8OV/GSuZide8iuQGCBfNujz5P5g0SEULkl39owj+BczCDAZeTlnCcy0plTQAR5x8+J5ewNGgqZezg2T/mhbzU5act7N3dkfogVYimW98Gdbg39bOAzBkv47XibGlKQg95HEsGIJXQEWtxWkEiccxFNgSD4qa8ZjY1TewO1kmqCYSj1Vhjy2vR33vaqj7pf69AQs35ZTpTa/cj6maO+yVICTzj+a2sfWiXzhYGdpbhyln05tBflfrMcUDf5F2SSTT2xSzQZE2P9NfeTBThxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+/vyv/yoA3RB3nzpG64f65uaUzanLf280b8MMkXEjg=;
 b=JdN4RMaS2I3MW62yqHksm24KfgrNHysOANbbhram9e6l1AlMsh4cVWN11ykLXU6oiv0TJga11q9Z2EtSr3KyDxPVp8QAxeJkItrtY3+9XELI4O6Y8D52C1VKurhArLWFloGedL9L4PEK8HdjBU1aIAk8WCpr5sr0IIEYbnjqhgY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB6522.eurprd08.prod.outlook.com (2603:10a6:10:250::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:20:15 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::4ce3:fe44:41cb:c70%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:20:14 +0000
Message-ID: <93fab42a-c9d7-4660-98f8-38e6f532182c@arm.com>
Date: Mon, 6 Oct 2025 12:20:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
To: Pingfan Liu <piliu@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
 <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::22) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB6522:EE_|AM4PEPF00025F95:EE_|PAWPR08MB11437:EE_
X-MS-Office365-Filtering-Correlation-Id: f553d2fd-ff0a-4bc7-bc8c-08de04c20767
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MFA3Wm96MkhKdWhGdWpRcjh2d3hZeWw4TzdwbkRKR3M1aVFzUDlzV29mYzFu?=
 =?utf-8?B?eWJ2RDlMVlBiTXZ1RVZEL3NGbWRjR3gyODVCWmlYNmdhNTdKemN4SFA5ZUl0?=
 =?utf-8?B?MEpxOTJhRXo5TVJ2NVFXMEZBaS9JcmhLSThQQUp5QTN3NXdYa0M3U2krN1Qz?=
 =?utf-8?B?K0JCL2RIREVtVEcySVYzNU5kRll4T2MraGZUOTNGa1lOL1BNY1Z4dU52QXNQ?=
 =?utf-8?B?LzhsYXpPdTRJOWY1ODhRcmsrc0VRSFJkQXEzM3p6c2NrYUtqb3c4Qnc3VEhG?=
 =?utf-8?B?OG93dkppcTd2QnE2bS9ncHF2d2xXd2p2L2VqTklGUE1vb3E5TW1YUVNEeTdX?=
 =?utf-8?B?SnRPOU9lZVY2aVlsWFFyWnlOd2o0ZmFDYno1V0gvRlBpR2tFaFJnZ3ZuaTcv?=
 =?utf-8?B?ak1haVdhODkxOUw0NUNFVlR5OUVyaG9FODZVVzl4bjg3OWFKWWQvYUI3YlpU?=
 =?utf-8?B?T0x1SVdZdW11WnFjYnhXM2kvWUt1ZnVnNlErRXZ2WHhnVVFTNlBBVklnOU5p?=
 =?utf-8?B?TkZsVUtpZXlrVkdQSkRBc1A3Skp2MEhPcXJROGh1M09TSlljc0NrYWpvMGVt?=
 =?utf-8?B?UzFHNk5QUkNHOUxXWWl3RXdkbytYTzYvMnI3dVpnN3FRZXMyZy9hWVQyVlZk?=
 =?utf-8?B?eE5YS0hKMHZicEFoQitlZ3JHekdyYk9ZR2lvVzg3eDNwOTl4N2NMTk1NeWpu?=
 =?utf-8?B?QVhNM2NwWmlLTStPajRVR1BYWFFVTXpZb2xMTEZkdjVwMFFYbEQyNjBJb0Zm?=
 =?utf-8?B?czZZUXA3dW1NR0J0b0FJT0NTN1FyOFVEWS9CdThIYjAwOTJrNzBZRHNnRzlt?=
 =?utf-8?B?REpza29kdVB3ZGZqaythSXBUbzE2UlFHWi8xTVd1MGl0Y1I2VXdWbHpvNmNn?=
 =?utf-8?B?VHNCK1lOTCtjeGhGajBFMi83VHBJdDd3Q1UyNyt5ZkxtNHhvL2J5b1lKem91?=
 =?utf-8?B?cU5RTzNwR0NNek9ZdnRFbW9KTWJWaXBybU5WeWg3YzM2S0RSM0tGVldyNjVz?=
 =?utf-8?B?bFRxVlBKOW1sQ0JxNm0xT1EvRTJ5MXRZSHpqWWdJZ3J3NlNnZVRPekpqbmpu?=
 =?utf-8?B?VGFlM3FCUmpiOTQ3M2FKdlpmb1ZrREZBTlprR0xGUU5Kc1cwVEt3NUVTU3Nj?=
 =?utf-8?B?SXlnV0ZZUWRkMWZmZUpFblA5ajFQbDA5aVo5cTNzd2dPTjNFbUJwaWJLbUxr?=
 =?utf-8?B?UUhoLzdYUlFORVRZWVhsL2tyMHo5R2ZNQTBXd3RlZzZ3ZC9keU80T2x1dGIz?=
 =?utf-8?B?SVNRdGxGV0tMQ1NzNWFNa1ByYVFLNm03Q2k5VzhlYlBEYS9qTEgxeTZDMXUx?=
 =?utf-8?B?akJMNUM4a1RvZE5PWkNzekZVVVloQXFqdFlDYTZORkVRaWJ1d3FCdTdHMUI4?=
 =?utf-8?B?VDhtZ09ROVJsNG5aSWJwL25oOWtGRXVTaHpVZjdBQzBKQTljT2lrU0syek4y?=
 =?utf-8?B?Z2JPZUFGUC9GbVQ1Y0hSV3lLNUlwKzRtbTVVdnlDczBxem9FNCt1TFpCUnNx?=
 =?utf-8?B?dTh5cDA4QUYrd0hHTjdCdm91OXR3SDZxWnNXWDAxcUl3RFN6YVZVNmxPdmlC?=
 =?utf-8?B?MkpMak44SjlNR3ZlaVRLanRkUjQvSFcySXkvS205bUlmc2Q4dE5XKy9HTm5m?=
 =?utf-8?B?Qm9BZitYTDgvaXdocERtM1dxejhIN3VZLzVwcWZHbkVWUm1FTy9TQUJ4MVpE?=
 =?utf-8?B?byt6V01DUDR0YzVKQzhzM0YxUjBtbW5FRnlST2FWejZ2ZjQrZWE1Rnd0bERH?=
 =?utf-8?B?SUpWMFVtdHgza1VZVmhJOEVLVHNsS1c4TEdhV0hGMmlRaTVhZTd1TXYvbzl4?=
 =?utf-8?B?Y2phRUl3OEdLY1A0MUR0WTdXQ3VUbWZwNG5uRmFEMGRVNVVIYk1CK3NBeGJB?=
 =?utf-8?B?YUFSRnRGU2ExY0o2dHVJajdVSHQ2ZGNMdmVBZ3dvNXpKeXAxdEgyclRuUCsr?=
 =?utf-8?Q?I2axgx1ojrM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6522
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ca102d1f-ea9e-4a3d-4863-08de04c1f0a8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|36860700013|376014|7416014|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNRUHMvUjFWQThSa1pnY2FkMFdReFN1Z2Rwb2s2Zlhibmk2bnFwVFRZMldE?=
 =?utf-8?B?NG1Jb1dwZG5XY3JMbUhqdUl1YmhKWFpxMGVUVmR0Ym8vYVRyNkJKS1pVcGFW?=
 =?utf-8?B?V0ZBUzNxQ3hINUt0MDZGR3RGSmlia0haeEt5bzBnNDNoT09LWFUzb2VwM0Zz?=
 =?utf-8?B?NmQzRXdBK2hLSXpWMGJUcUpiNWVONnp1bC9xdm44Ti9zMWpBSXRnUHZyQS9R?=
 =?utf-8?B?VzB4Rm5scGtLYmRjQktnNmxIY3VmTkowVWV5RktMaVpSSkd6NXNzSXcxOTQz?=
 =?utf-8?B?SDVPWDdMa1REeHFkR25xZmxJMVFrTEhMNSt3WnEvMTdHYmRjMTZFWTdBV0d1?=
 =?utf-8?B?N1gzdUJoQ0x3d0VZZlppajl4d2xQaXdTdlZvdXp0RjVFMG8rc0cvVTY2U3dC?=
 =?utf-8?B?TFhNbnM0c3dlK3YrM29OTkEyY29YTVpzaDdMb1pvWFBhYm9sNE1IcysvdjlE?=
 =?utf-8?B?UWk0dkMzMXRYMFRqS05oZkRaY3FMSzFWbmJDQkhNeFZNVnRnYXBmSmZEQTY3?=
 =?utf-8?B?TTNjc1FsSmhSa2lieGlYR1Z4ckxSWVhPalhSdUlBWXdVb0lzUk9tQjNHandZ?=
 =?utf-8?B?UC9YZnduVk1haDhxVStsZ2xYbG9wS0ZMajkycU92TjU5ZjRnNENMYUlDa01v?=
 =?utf-8?B?QktETzVuNkpqUDBlbzArSGNWWFdRU2R4S1FvSjltY2pENGhMeE91ZytKajdx?=
 =?utf-8?B?NHI5M3RGMUtzQ2tSZ2ZlTTkvS0c0NWlIQ2tFeTVxVW15cGdwQ2pxdDFiVXdl?=
 =?utf-8?B?anZMT3VIYi9haUxhZS82WDJhMkVmUUVTQ3JGSWdtcUVvZEF4dExwS2JEYk5S?=
 =?utf-8?B?VjNtdXV0NFBCSlMvUjZpY2ZJVk02WlMzbkZDZ1ZvUzljTkVkRE5jNWtwZ1ZX?=
 =?utf-8?B?MXViRnZaaWplK3pPWWhuUkhtMkFDR1ZCRzJDSVB3bDBLSDgvU0ZzcXJZdEhG?=
 =?utf-8?B?RGhyc1JGaW9lRDQwRXlXR0c4K0VWL3IrakhGaVhVNEhEcGgxclFUd2djWVhr?=
 =?utf-8?B?WlB3YlRJeC9tRzFGSlhGT2FNMW9hUE5WWEVzZFRQbmVZR2dxTkNad2JFL1ph?=
 =?utf-8?B?RXNKNUpvdStWb3lBcXZadmlwY1VhWUl4elhYa2tmVVZlTHFtLzg2Z0tuSlcy?=
 =?utf-8?B?YXl3Tm82bHZLNEw4ODRETlhucXg1aDJQdS91clRUMXZJOUJTRkR4cVE5S3ZN?=
 =?utf-8?B?WUVETjlrZ3hZamlIUENMZ1ZDb2ZlUmo0OVlyQkNjbDJBRW1aQ0huSGJMcE02?=
 =?utf-8?B?OFRKeW5rZk5IdXNVU1pFenpKMHBxNDY1Njc0VG1nVVlnZ0dLK2ViY0JUWTJm?=
 =?utf-8?B?ZEdpNERDR0pFV2FjSmo0d3VGVU5oQ1NqOXNUM1hVOTVkai90WVlwK05uNkZR?=
 =?utf-8?B?UUFvVXE5Mm9ZeWdBQ1JwakFFSDVpMjhRYUF2R3hpS3Y2emJYb0llUHVPMnhv?=
 =?utf-8?B?K0cwUzZlV1FNSmd0aW5ocGJMUzIzSmlabkFvT1FOM3M1QWpsc3VCQVFUQjRh?=
 =?utf-8?B?S0FnTHZ2NzlxdkxuenhBdmlsblZHc2F4L3NzYXIwemtpdUtFdUJuYWk0YW51?=
 =?utf-8?B?cDBXRmdBRUxqVG5hWVdMRXlDRTZKamhxOHpqSzd6MzM3dUtXQTNqOHNlV0lD?=
 =?utf-8?B?cThUNDJ2b1F3aHFzcU80VUR5VlJjOW43VXBWUnN3L1JFekhCMFBYU3hCNFNH?=
 =?utf-8?B?U0pkL1ZSellxMG5ZbkY5NVlTU1NCTzMzc2ZKaTErK2hvSzFMdU0vUDFwU0Jq?=
 =?utf-8?B?NEo4ZEVOV3JnM3pTUjA0NGlNUUtmdmppazVTcGJ1QmN2V0dlS01nVUxBRElk?=
 =?utf-8?B?aGtXWGlma3Z6ODlrUkNKQXV5VjFzT3pFZTlDQTdvVjZ3UHVNZ2RJamVzeUZB?=
 =?utf-8?B?NzV1UmV0T2hVMlNIU2wwd1VjNWQxSmdSejhGMmxLSkQ5N081b3BZSHlrVkpF?=
 =?utf-8?B?MWNsNGNIVU8waDY0UEQxZTBNQTNHdlVZVmdxaHdNOFRzaFlmdU0rV3JIZjJD?=
 =?utf-8?B?czNxTTc3VWJIbFRGZ1JzNk5HSGZWZmtMY1RjTm4zaGxxbFhFSzFQSWdHU0xK?=
 =?utf-8?Q?6+Z8rN?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(7416014)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:20:52.6588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f553d2fd-ff0a-4bc7-bc8c-08de04c20767
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11437


On 9/30/25 11:04, Peter Zijlstra wrote:
> On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
>
>> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
>> tasks (like schedutil [1]). IIUC that is how it is thought to behave
>> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
>> it is not "transparent" from a bandwidth tracking point of view.
>>
>> 1 - https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
>> 2 - https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198
> Right, I remember that hack. Bit sad its spreading, but this CPPC thing
> is very much like the schedutil one, so might as well do that I suppose.
>
IIUC, the sugov thread was switched to deadline to allow frequency updates
when deadline tasks start to run. I.e. there should be no point updating 
the
freq. after the deadline task finished running, cf [1] and [2]

The CPPC FIE worker should not require to run that quickly as it seems to be
more like a freq. maintenance work (the call comes from the sched tick)

sched_tick()
\-arch_scale_freq_tick() / topology_scale_freq_tick()
   \-set_freq_scale() / cppc_scale_freq_tick()
     \-irq_work_queue()


[1] https://lore.kernel.org/all/20171204102325.5110-3-juri.lelli@redhat.com/
[2] https://lore.kernel.org/all/20171204102325.5110-1-juri.lelli@redhat.com/
"""
  o 03/08      it's a temporary solution to make possible (on ARM) to change

               frequency for DEADLINE tasks (that would possibly delay 
the SCHED_FIFO
               worker kthread); proper solution would be to be able to 
issue frequency
               transition from an atomic ctx
"""





