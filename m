Return-Path: <linux-kernel+bounces-871808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75BC0E5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A585D34E801
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7983307AFA;
	Mon, 27 Oct 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qSfZZecy"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148F1E32D6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574778; cv=fail; b=G7YxukUPl32nB3aXD+9LSJkAEQiOMvsyNM6CFJrT6BaZBDim1z6eY35TZinEFMPSB83dJ3Q4HEP/wYCBSrSPf/EbFXxfqZXNf9g/CZnQDHO4ZdJngCAQZ8ACCP8HI2NkuYkjOoFfiN7SajHlUWrBFDFfSYwm9+hyeyu/TSsXpGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574778; c=relaxed/simple;
	bh=+OWImzs6MZJv2sVIPg5IqNV5yS+ZL2qNwwsACWXebRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IOzGU9BOpJjCl+VuaO85bC2UsdgCIBLHk+ewZZZOTSwf22cg3qpJ0A7gFnCnpfgd4q/mREtAFuAsvbMBPmo79Cf1ADfnLxWJ37xgBasB2dcUo/qxwEWw0EOiyn5PpZzjoZDeHoS08BEv1gbZd5zTpKtMjFGW2oQJ8nsorKlLXmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qSfZZecy; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWf2nTqEI6zrNINhjik7BPQ7uGHtYHmkECActp8h3GE3Fo439hAbjGNeDFsP2GQdb1RMJiKLMaWh2Sh61/zXxlIcu+HvnJ94VkmZwJv1lCQX7UD2PPDTiGFSlH0it1dRCvhj9aVzaV7EdAeTUW/udwPzFF+VUOnKRN6/2qqOz+dE03o5n3uAH/qCIaxFZ5iTAULgM6zlBob7nX27/469X8gIpF6tsgBMr+INPHK05H7TB43X1QRmVJagKH0PC0xUYw79+0HqyNb63siNMhY90kH/AlexUJMzu2kRVK3J+liNTO7BiNP5Q48Sl6BygwndcfxdGxUE5ZhZANSvn7zeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OWImzs6MZJv2sVIPg5IqNV5yS+ZL2qNwwsACWXebRg=;
 b=G7MiNet2kkcyec8//eALAPT//qvDm+BH9+8XcN75nM2oY+E9Hz19+KQ0Sp6f6iyL9+QKWLhNlnLrJlKV9vuXEPVrq3OUyOpP70OsEQ574oGnBrdrr/KeUdzSYXhRiBUn6K3U3BB41BbXZeuUoNA2czBaNVPuP7aaQcyMbsGHT61Bw5LOsZE8iScSUv/oOSz0AMJQ1j6mImYXBaJrQQ9Yqt0UgCESz+Anhb3fUantw7GskuzGKGxpXAGEgwYz53+v5P4pUp9XkEoUiyXzGI+INXUZspHwmAnDQyMTVgc2spdhQYJGUCzOA/hY4I5Ckkuy/us1TgmP70/K+QMxhjmQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OWImzs6MZJv2sVIPg5IqNV5yS+ZL2qNwwsACWXebRg=;
 b=qSfZZecy4ahnWAwkDOa0bJUrSRwCT+0BdKhTFHevLCqTd8Vy6lSA979Fc/s+DR6NWlGADpyRrpoc/0sQrDAsZQmLBvTE3nfqCf891BeWY7M+6MpxA5RGdDVxy0ARb0A684MZubnhhVEXqQG70H9Zpps0iYpzmu2kA7pjtfQZmX4=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:19:34 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:19:33 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Topic: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Index: AQHcPb/dNJRwYJelJ0iZ+pcOgQN837TDNq5ggBK5IwCAACi5EA==
Date: Mon, 27 Oct 2025 14:19:33 +0000
Message-ID:
 <LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
In-Reply-To: <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-27T14:00:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH8PR12MB7159:EE_
x-ms-office365-filtering-correlation-id: c8e77809-969f-416c-17dc-08de1563da19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTljNlVCc3ZPR2NJbUZCRVBYZHZqYnpqL2ZkSW1WR0lRNzNZdWlPL3ZSWE9S?=
 =?utf-8?B?UEtrRzhkZEFQL0JMbTJGQ3lYY0VrVzc2NjVzSW9IV3g2ekFrVXk1cGFQbFJw?=
 =?utf-8?B?c0Y1aFcyWmpwS0YwOVJ4S3ozWTlkT1h2c3pUT2VUMm1kU3BmQ0dvRzNDbXhF?=
 =?utf-8?B?KzhTbVV6LzB5S0liNkw3Y2lhLzhGenY3b0pTalNQNGk1UUJ0Y1JDUmF5aGZZ?=
 =?utf-8?B?QUpJRnlOOGxDaGFmSkNraXRIaUZoMTcxNXVZZWlZdXpBbGV4OStKUU12d05D?=
 =?utf-8?B?K0k3dm80clkxTUZOWlp5eVlQVi9iQTV2N3d3VlpMK2RyUG1QT2V4V3JwblBh?=
 =?utf-8?B?N1NVeGZTTTJMS1RFWm5kSmZUN1FTazBFSDMxeU92THJJLzlTcjJDK2d4a3ZZ?=
 =?utf-8?B?Ri9hTE5PcFRQcmt5aXJhSUY4TTRLVmttYVU3U0h3eU85TVBwUTdyT1JMT2o0?=
 =?utf-8?B?Q2NrbEZMTHBlOCs1ektyakl6VmJUNm5wb1NETEFvOEtlaFN4VXVGZjRFMU8x?=
 =?utf-8?B?QUY1aU1OZjlkWkkxdEdOWCs4cnRRL2VTQWdKTUdtQlpQSUxKR0o4YkR6VC92?=
 =?utf-8?B?VHVVdWlOMzdvKy9sK2RVdDlrV2dhS283UTQ0OXB2MUQrVlZkdFBEOWsremdH?=
 =?utf-8?B?TUtxVzN2RDVOdXNWdkZRMTlBdWtuVTdEUTNyUzBUZGlZbnhGdnVPcjg5bkNB?=
 =?utf-8?B?T3UxdnFMcVVpVExRTTJUcEN4RzJqQTh5UU5NNjJUbW0yOEVzUVFyZkFFNEZ5?=
 =?utf-8?B?eUd0dEc0UGNJMFh4cFFRZmVmcXhUdlMrV1NYdWZrR2VyTzFGeWcrUTNyalQ2?=
 =?utf-8?B?S21tQ1BxOThkejN1TDdBdk9EMStCcTdQYWg1eUkwTEZDTHZ0MVFLK09KUUVw?=
 =?utf-8?B?Rml0UlIwS0xJMVE0ZWNJQStrRnpzWWx3SHZOUkdMYlJSTk12SXM3REtTcDZ4?=
 =?utf-8?B?T0JFR2FpczNNaGFZT3N1bWpYVDF6YkVUeTdWOXZkbXRqWVRsaVJ2SG5VYVZv?=
 =?utf-8?B?M2RKb250bHlYMS9BNWJyWGlyZ2VpSFVnb3IyZXBEQysza2hnNDNTYTlJcnlU?=
 =?utf-8?B?dSs5WUhRODlQSVk2Z24rRU9MTFM5elFQc2dxcEMwNGF3MzJkeWtiRWtXU1ht?=
 =?utf-8?B?STFjbE9QcjB3SjZNMHFzK1RSZW5MQVFxMnNPM2xlT2tKYmdYcU82RFdxU05o?=
 =?utf-8?B?Z3grVFozeEQrUzFqaE8yajhHMVhKemM2bGJYekh2dmg1UnBrT3d3NXlEc2ps?=
 =?utf-8?B?TmJsSW04bjA3YXgwaXlVNXpEeUZrRnprVklreSszdzg5akZUblE1Q3R5MGJt?=
 =?utf-8?B?RGxlMzFPNUFMRWl5dE1OSFZBTU9LVTQ5ZmJSZ0hNRzl5U1NhdmFtajZQbWw2?=
 =?utf-8?B?NmlPRGNqVnpldVBxeloyY09BM1lITnlra1R2b25qaDdlSmUyOHRQUHZZTUxw?=
 =?utf-8?B?d0pKMnM0SUo3VDBGOXU5RnZxVlZyNHlTMkJrNTQzeVRlNlVVbGwrK3IybU9q?=
 =?utf-8?B?MGNWRkJKWEhpVks5VWNtOGo5T1VCSWR4b2oyRVJPaTZyUDM5SlJZanovRWc4?=
 =?utf-8?B?bWRwSk83MzcrMGpUcmcrVFNrSGR1ZFZyMkYzb3RCQit5YWJLWUhjM3poOVhw?=
 =?utf-8?B?VmJaWE9aODJCT1N4UlQ0Ni9RRHlxbWkrQ3pKQzVuWkpZZ0lnTVp3L1hRN0tC?=
 =?utf-8?B?T1IyOW8zZHlwMmJJWmdtdGlLaFd4dExlTkhtY3R0OWxnOW8xSHhwbklRbERx?=
 =?utf-8?B?dllSQmF6eWdSQ0EvR01vVzY4OWdoamxpTTlvODdFSWpsUXJXZEUwUEtaS0Jl?=
 =?utf-8?B?RGw5Y3NtZmVyd1lGNjMybVQ1ZGxBY3BQSEtZQjMrWmZoVVZLZktrWDQyK1Bz?=
 =?utf-8?B?MUQrN052QVN2cXRHblg0Y1ordW5mSC9XQjhPZnJDZWltRys5NTRGRTl2RXNX?=
 =?utf-8?B?VUlwRkNLTU1rbXJJNzBLcEFxeERJWExST0lkTHp1UFo4bDFjMy9rZDNkOVRI?=
 =?utf-8?B?QUdKbXc1MGVpVDJCUGNrNEhTSGFnNHZWZ2JaQnZHaXBETndLaUNwK2wrT3Fq?=
 =?utf-8?B?UEo0M3Z4QWpFN1hDUjhlbXJnV2JHMjBXOFVJZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N01IVVljdjU2WmtDak1sSlJVNmZwZXBwd0JDOFJvQzNXSUIyMVlZaXZnbEY4?=
 =?utf-8?B?K2loU2licVdUbGlZN1hUN2VkSE9uSmFrTjlkb0JKaXVqaUFrQ3dzOUhyQU0z?=
 =?utf-8?B?N2xPdFRQZnNuRnJCY3JzWFAycEtEYlIyeXJFUlZ3MzJCcEw0VGp2enRMc0VK?=
 =?utf-8?B?bTVzWWRoTTJmZk9abXFFOU5MRUhxMTdqNnJjbGFoK3dDdHVrUEtjcThFSEN6?=
 =?utf-8?B?MVNpZnZzMEJjTnlDdFFjbFFVb2p3a0NGNzZhUjZaMXkvc0NTOFhUaDE2a3dT?=
 =?utf-8?B?a2YzZ3FrN0Q5ck92b3BrRHp5TnAybGU2TGVCdE1ETUNjakRMbXBkclN2aGxT?=
 =?utf-8?B?VWZWM09nVmdqN3V2VSt2WGM4bHdTTnhRRkwwUFJkNHZzQlVXejFGWnRtc0xB?=
 =?utf-8?B?SUxpcWZ3eVlMSnhzeDJ2NjhJT1JFa3dBaVNvTmdrOTlhd2hQWGsvMzc2VVpu?=
 =?utf-8?B?MzdaRWFKYjFJbm5nYnRNSDdoY3ZkM2h3RXVhUkhwSDdPTndndlFPVEc3ZmJ1?=
 =?utf-8?B?S0JXK0RVNEVrZUNxbUdmeUtxWDgyNGQ3ZEE2a2ZZbFlpUThpenpDc2VhMlY0?=
 =?utf-8?B?aklxQVRQdWVqYWFDVWZsaThVNXNEQlB3N1BVV3BKemhiazhPcHRMWFBZbkty?=
 =?utf-8?B?OWczeUJVTHh5eEZ6em4xQ0VLcUJmanFldUpaWUc0blZmR1ptUDY3cW9sTjJR?=
 =?utf-8?B?R2kzSDdIMTU2QUt6dWRBektheXlmbzJPejJpaHpSc2tRQmNmbm1wd0plRXE0?=
 =?utf-8?B?TmNXRjFlYVdORStsRytLUUxVdlZkbkZ4Y3UrR1luWWczUjE3akZCK0dQTE5h?=
 =?utf-8?B?aUVaNzVqdTJwUHVVM2hmb2VYWnZSazV1VnlEOFNjRHhoM09RY0hGcG1GME82?=
 =?utf-8?B?NTZpTXIveXFCNDljanhva1d4S2xnRG5zVFhNNitQbURzcXRVVXhTZEMzeThI?=
 =?utf-8?B?b3k2c1lLUnVhNllDbkhzYTdKTFlwYlJJSTZsaUpvL0E3VmFINmlvN1hraldj?=
 =?utf-8?B?ck9VM1NZT1MrRS9pMWtqSUNCWGt5TFJGU0RWMnNjUDFOWjJLNTFzOTVhZG43?=
 =?utf-8?B?bGhPSEtHY1NTYk13Q0VDb1NhcEpYTklTZTJEaUhrdnByK2J1MlBmOTl0eUZj?=
 =?utf-8?B?S1p5dHFyQ3FMczcvTGpQZ2MwRW5OS0xtOWg2N1NJMHN0Z3NiQnRqWUJVWkJ4?=
 =?utf-8?B?d1lHRzBzODFjNjROQktqWWhRalNXYVJtdXV3MkxuVE5rOHhFVThaZ0V0bGlX?=
 =?utf-8?B?dzFMeS9YZWJmZHBrSC8zUFZaVXRuQ1RGL3paOWk5WXdOamI1cmszT3ZYOGZn?=
 =?utf-8?B?dzV3Qlk2VlRmYXpXcW1oRVdyUndmaFFmRjZMbTRtc1RkaUd5Zmg0N3Z5cDk0?=
 =?utf-8?B?UkhWSjRBTGowbTJBN1FTS2xXN09yTFFpOWIzWHY0dUpJYUhMRUMrU1FlTVFq?=
 =?utf-8?B?SldmMmdudysrZXBxejdFeUxvYXVHbDdCU2hjTTlScldDWnFtbS8vMDEybllp?=
 =?utf-8?B?REY2b1lROXViWjF4R1Q3bU83UFlUYS90SzduMkxVbHhrUndqQ2lNWnRsaTg1?=
 =?utf-8?B?anRBU25CcHFWSUhiWklnUUpnMFVPTHM5ZlE2TFFxeFk4bkh5WkFlay9pYTE1?=
 =?utf-8?B?Zk9vU0dqdllJTzdxMHZpVFhuZmpzeFJRV1hCS0NvdEtSaU8rNVVSN2RISnBy?=
 =?utf-8?B?MkZvTHJnL29pVFM5Q2Vld3VEcGcwSmpiNldjRkhVWTNMMnhnV3FsU21mV1g3?=
 =?utf-8?B?YmdDd1JNc0toZ05QN1BvSUVjN0x5Y3ZNNDNaK2c0N1I5a1ZPM2FaaHo2OEF4?=
 =?utf-8?B?eGJVZlFlK0tSQWY4VW01NFVyMXV3endPaGxhSWxrQnpQRExtbG80MWZOTysz?=
 =?utf-8?B?dzc5S3YxUytoSUE4UEdCQmhFdE43TFdub1I5akRWbFF4aGRnampWelJ5U3Fp?=
 =?utf-8?B?c0RaSEp3eGpvU2kxdUVzU0RZdGNvKzV6NittemZkd1lYRk1tU3dKZlpPVklr?=
 =?utf-8?B?N2NRUnorYlVrQm1BRCtndE1uYWZYWHFWVlY4UVVETGJpVjlFMHZ5d1BvM1dK?=
 =?utf-8?B?Y2drejNDNG1CUTMrZklZRWdZUGFwNTdtNkwvc2ZqUHF2WlRaVDFnRnp4VmtL?=
 =?utf-8?Q?A8mM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e77809-969f-416c-17dc-08de1563da19
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 14:19:33.8173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qpz8yBhJXulpFiFuvwkMbEesATq0oKRD/YjgtnjGbce8yqPfCY8eKQdk0mErFvAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjcsIDIwMjUg
NjozNSBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBKdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+Ow0KPiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtl
cm5lbC5vcmc+OyBQYXdhbg0KPiBHdXB0YSA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwu
Y29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+Ow0KPiBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZp
bg0KPiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5j
b20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAzNC81
Nl0geDg2L2FsdGVybmF0aXZlOiBTYXZlIG9sZCBieXRlcyBmb3IgYWx0ZXJuYXRpdmVzDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTAvMTUvMjUgMTY6NDUsIEthcGxh
biwgRGF2aWQgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+PiBGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+ID4+IFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciAxNSwgMjAyNSA1OjM4IEFNDQo+ID4+IFRvOiBLYXBsYW4sIERh
dmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT47IFRob21hcyBHbGVpeG5lcg0KPiA+PiA8dGdseEBs
aW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+OyBQZXRlciBaaWps
c3RyYQ0KPiA+PiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBKb3NoIFBvaW1ib2V1ZiA8anBvaW1i
b2VAa2VybmVsLm9yZz47IFBhd2FuDQo+IEd1cHRhDQo+ID4+IDxwYXdhbi5rdW1hci5ndXB0YUBs
aW51eC5pbnRlbC5jb20+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47DQo+IERhdmUN
Cj4gPj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9y
ZzsgSCAuIFBldGVyIEFudmluDQo+ID4+IDxocGFAenl0b3IuY29tPg0KPiA+PiBDYzogQWxleGFu
ZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT47IEJvcmlzIE9zdHJvdnNreQ0KPiA+PiA8Ym9yaXMu
b3N0cm92c2t5QG9yYWNsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+
IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDM0LzU2XSB4ODYvYWx0ZXJuYXRpdmU6IFNhdmUgb2xk
IGJ5dGVzIGZvciBhbHRlcm5hdGl2ZXMNCj4gPj4NCj4gPj4gT24gMTMuMTAuMjUgMTY6MzQsIERh
dmlkIEthcGxhbiB3cm90ZToNCj4gPj4+IFNhdmUgdGhlIGV4aXN0aW5nIGluc3RydWN0aW9uIGJ5
dGVzIGF0IGVhY2ggYWx0ZXJuYXRpdmUgc2l0ZSB3aGVuIHBhdGNoaW5nLg0KPiA+Pj4gVGhpcyBp
cyBvbmx5IGRvbmUgdGhlIGZpcnN0IHRpbWUsIGFuZCB0aGVzZSB3aWxsIGJlIHVzZWQgbGF0ZXIg
dG8gaGVscA0KPiA+Pj4gcmVzdG9yZSB0aGUgY29kZSBiYWNrIHRvIGl0cyBvcmlnaW5hbCBmb3Jt
Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEthcGxhbiA8ZGF2aWQua2FwbGFu
QGFtZC5jb20+DQo+ID4+DQo+ID4+IEluc3RlYWQgb2Ygc2F2aW5nIHRoZSBvcmlnaW5hbCBpbnN0
cnVjdGlvbnMgYXQgcnVudGltZSwgd2h5IGRvbid0IHlvdQ0KPiA+PiBleHBhbmQgc3RydWN0IGFs
dF9pbnN0ciB0byBoYXZlIGFuIGFkZGl0aW9uYWwgb2Zmc2V0IHRvIGEgc2F2ZWQgY29weQ0KPiA+
PiBvZiB0aGUgb3JpZ2luYWwgaW5zdHJ1Y3Rpb24sIGxvY2F0ZWQgaW4gLmFsdGluc3RyX3JlcGxh
Y2VtZW50Pw0KPiA+Pg0KPiA+PiBUaGUgbmV3IGZpZWxkIHNob3VsZCBiZSBndWFyZGVkIHdpdGgg
I2lmZGVmIENPTkZJR19EWU5BTUlDX01JVElHQVRJT05TLA0KPiA+PiBvZiBjb3Vyc2UsIGxpa2Ug
dGhlIGFkZGVkIGhhbmRsaW5nIGluIHRoZSBBTFRFUk5BVElWRSgpIG1hY3Jvcy4NCj4gPj4NCj4g
Pg0KPiA+IFRoYXQncyBhbiBpbnRlcmVzdGluZyBpZGVhLCBJIHRoaW5rIHRoYXQgY291bGQgd29y
ay4gIFRoYXQgd291bGQgbWFrZSB0aGUga2VybmVsDQo+IGltYWdlIG9uIGRpc2sgKHNsaWdodGx5
KSBsYXJnZXIgdGhvdWdoLCBhcyB0aGUgb3JpZ2luYWwgYnl0ZXMgd2lsbCBlc3NlbnRpYWxseSBi
ZQ0KPiBkdXBsaWNhdGVkIChhdCB0aGUgb3JpZ2luYWwgbG9jYXRpb24gYW5kIGluIC5hbHRpbnN0
cl9yZXBsYWNlbWVudCkuICBJJ20gbm90IHN1cmUgd2hpY2gNCj4gaXMgdGhlIGJldHRlciB0cmFk
ZS1vZmYgKGtlcm5lbCBpbWFnZSBieXRlcyBvbiBkaXNrIHZzIHJ1bnRpbWUgbWVtb3J5IHVzYWdl
KS4NCj4gQWx0aG91Z2ggSSB0aGluayB3ZSdyZSB0YWxraW5nIGFib3V0IGEgcmVsYXRpdmVseSBz
bWFsbCBhbW91bnQgb2YgbWVtb3J5IHJlZ2FyZGxlc3MuDQo+IE1vc3Qgb2YgdGhlIHJ1bnRpbWUg
b3ZlcmhlYWQgb2YgZHluYW1pYyBtaXRpZ2F0aW9ucyBjb21lcyBmcm9tIHJlbWVtYmVyaW5nIHRo
ZQ0KPiBjYWxsIHNpdGVzL3JldHVybnMuDQo+DQo+IEl0J3Mgbm90IGp1c3QgYWJvdXQgbWVtb3J5
IHVzYWdlIHBlci1zZSBidXQgYWxzbyBtZW1vcnkgcHJlc3N1cmUgZnJvbQ0KPiBhbGxvY2F0aW9u
IGFuZCB0aGUgcmVzdWx0aW5nIGZyYWdtZW50YXRpb24sIHRob3VnaCBJJ2QgdGhpbmsgdGhhdA0K
PiBtYWpvcml0eSBvZiB0aGUgYWxsb2NhdGlvbiB3aWxsIGZpdCBpbnRvIGttYWxsb2MtMzIgYnVj
a2V0LCBzdGlsbCBoYXZpbmcNCj4gdGhlbSBhcyBwYXJ0IG9mIHRoZSBrZXJuZWwgaW1hZ2UgZWxp
bWluYXRlcyB0aGUgYWRkaXRpb25hbCBhbGxvY3MuDQoNCkkgc2VlLiAgSnVzdCB0byB1bmRlcnN0
YW5kLCB0aGUgaXNzdWUgaXMgbW9yZSB3aXRoIHRoZSBudW1lcm91cyBzbWFsbCBhbGxvY2F0aW9u
cyByaWdodD8gKHRoYXQgaXMgdGhlIGttYWxsb2MgYXQgZWFjaCBhbHRfc2l0ZSkgIEFuZCBsZXNz
IGFib3V0IHRoZSBzaW5nbGUgbGFyZ2UgYWxsb2NhdGlvbiBvZiB0aGUgYXJyYXk/DQoNCkknbSBq
dXN0IHRoaW5raW5nIGFib3V0IHRoZSByZXRwb2xpbmVfc2l0ZSBoYW5kbGluZyB0b28uICBUaGF0
IG9uZSBhbHNvIGhhcyBhIGxhcmdlIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBhcnJheSwgYWx0aG91
Z2ggaXQgZG9lcyBub3QgaGF2ZSBudW1lcm91cyBzbWFsbCBhbGxvY2F0aW9ucyBiZWNhdXNlIHRo
ZSBzaXplIG9mIGVhY2ggaW5zdHJ1Y3Rpb24gaXMgY29uc3RyYWluZWQgdG8gYXQgbW9zdCA2IGJ5
dGVzLg0KDQpUaGFua3MNCi0tRGF2aWQgS2FwbGFuDQoNCg0K

