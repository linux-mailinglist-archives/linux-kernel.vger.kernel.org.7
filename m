Return-Path: <linux-kernel+bounces-871752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5DC0E362
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BD0188C1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A08305E10;
	Mon, 27 Oct 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ul9a9Cer"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F897611E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573589; cv=fail; b=A5MSSDTgqYW9sK0vlShy6jZbpKGtudD5ATFvtFWCBsk1oFJAmLtVaC96gGwZOXBhhKH17Crzq2rnvtRUtFT8oVXrnkpywjW9Zzl8tqWLp7wi1dHR+bfn3YwYvAc5+fEjUIShrZEafRjDiX4sSAvl3LB05qLhxQGhUunGn0/7UtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573589; c=relaxed/simple;
	bh=GBbUtypdYkWmSxKIChzgE5s8SxtcW5lQyTe7Qd9BaUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=momO8DNMQO1XJFOtnb3FaYWdL7Kybs9rfgSnAAWh/qduvc6Jfob3MOt/T012emhT8fr6dC2Dq3gXIIOiEN84YwCte4lCF22gtzabnNzbii6qaRom4jimA7A7yo1aOv0M461cHk6S6WmJNCpLCBRBV3l82EfR7BKFuvUx7wmkUJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ul9a9Cer; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRPrmbrjLmOkLbrdLRbEgU8HQOaoX71VnVOp+BXyLy5TUSDykHpgVbx9W5Bu3A7EhOmbyFyOfkofrSm7cgADtVWQFr5aoN4XjL4qdNHfMy3PpDT/kviKEIVw3i/C9jizGqZPGGH2y/Di+AV2O00YVqsTSWYPIqxqnYmL4DIyUhwtxh24qQDPi5zSy9q5Ao0VndTqWELvROZkGWU3rZCtRYRf4YjrOw2gUPPafEcNq/7Xbx+/YlMUs4d4738NNHrajtolp2bZXcaXMYx7I82tzWppcSE7qNSn0tdAc0MoG5B/18n9xlDrHTQ52JvotGXPDtL02vZLpetOOiwIfa7i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBbUtypdYkWmSxKIChzgE5s8SxtcW5lQyTe7Qd9BaUI=;
 b=f+F9IA5YbvCiqG4f2d93h1uHVTr31ST9yxENa65JBakucKeFqPzEC3O4eA4GyCE7XatJiMf+VnR+aMOVAfHc5eDI0b25pfw6sjUUTFhBQyUR67POXmlGOnsn1KNHLClfBaaxftDKwoDBZ8ssFmVoyV3M18D2y0viIG0ACww/lDTq+kiwjDEBULQg8JXfG+cpa4EAT96FOQrPHBt6p5SETFbm+4IrBJYn9hQv+2OZHMcNZh+TOm/ntjpEKyl7ai6ipdm7JPXCY0rg5TU/MTreD9ecx/ERqDpORuLC3uVs3MnhO22EAS8T2TFVShokzm6JsBcjPBerj2WGTmGlQxooXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBbUtypdYkWmSxKIChzgE5s8SxtcW5lQyTe7Qd9BaUI=;
 b=Ul9a9Cerd+LGO8v9DZPpfpMRYvAC7WnUGXMXruN5ip3wuFwtBX/P0LSJdGzJGy3w5T8oyHyFbEIDDuNZJmNUSs+O8zKwgdi+2yu85tOkvp9yiXW53XoHlq1Zjp+Vj3IMChsYoR99EwCw0nfXi0o/ZDkrRGrgpv13kHHU5yh02kk=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Mon, 27 Oct
 2025 13:59:44 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:59:44 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 53/56] drivers/cpu: Re-patch mitigations through sysfs
Thread-Topic: [RFC PATCH 53/56] drivers/cpu: Re-patch mitigations through
 sysfs
Thread-Index: AQHcRzzEFXHpwog8QUCrEWaju8dbRLTWBN7g
Date: Mon, 27 Oct 2025 13:59:44 +0000
Message-ID:
 <LV3PR12MB9265F32424F982EEAF542A9D94FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-54-david.kaplan@amd.com>
 <5044f670-2706-4d92-a00e-50c5d60208d1@suse.com>
In-Reply-To: <5044f670-2706-4d92-a00e-50c5d60208d1@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-27T13:57:45.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH7PR12MB6785:EE_
x-ms-office365-filtering-correlation-id: ce48e683-70ba-474f-e4f5-08de1561151f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?a3J1dW5iTE82cTQwZURrSjJOUk0yM0hESmlBYjZkdjV3a1NxR2hkL0xuaWhk?=
 =?utf-8?B?TlNVMDFYRTBDUThYSlhmZkhqSTl0bHNHUGw2dmdpUlVBR1R4U0lGQVhtS2dL?=
 =?utf-8?B?QWVMQkwrQjdTRldmZHA0QldrR0tTNG9tRGU3ckFzeXk0cU5HUlAwY3c1N25u?=
 =?utf-8?B?V1llcU1pNmRoKzI0SGdLY3M0MGZxVGhmUS9jQ0xLQmdIT1RqTnJBa0NOZFl6?=
 =?utf-8?B?SUZYWnVjZjJscng4bTZkeG5xQ2poZG5LK2ZRN1U0c3BpbmlzUFA5MzZRZU8v?=
 =?utf-8?B?R0hYd3g4cHhqOWtDdjloeEFHZy9oSmh5bC9COVRqVHlxTkl2dnJETFpkMlIr?=
 =?utf-8?B?ZjZwTzRYMmhQY2tUQXd6RTUyQVZQN2lHSS9qTVJYcnpjdUFsRnplMkZ3VXlt?=
 =?utf-8?B?UHRqZDJYVEVjMVNqeDBFemV4VWRQSm1adWJHbXVJMVFpSUM2MlZoRGFSRkEw?=
 =?utf-8?B?SUpaQ2RlWVQwRlZNOE9ZL09vQm43TGRQZW9kTUI3MWFMZGc0Z1E3UE1QK2Ja?=
 =?utf-8?B?TnZhNzRnd3dWSWdGaHhYdW9uMVJLUmdkdjk1SHZxcHVwL0hqUklWWU91d2Rp?=
 =?utf-8?B?TkZ2bjUxZ3YxU1Zqbm9KZ3F1UlJoSks0SnpUWjFwREYxcitkU2RJZHZlYkpu?=
 =?utf-8?B?Rm9IU0E2Qnk4RHY5SkZrUTZaZS83WVgvYmFsZzBySWpDdCtlM1VtbHlwUno1?=
 =?utf-8?B?RStUNWZ3dFdhajJmVHFPR3oxaGJFQ2Yvd1lwSU1NOWVkTmRmMHB6L1dzZDI3?=
 =?utf-8?B?RUxYSThLWVZMcWJWeXAzT2JtSGVGMWdHeE5ITUtWakxOVWJTdlVVRVRjT1p3?=
 =?utf-8?B?R21JOVRzWjk2cDJYb3VCQWRod2wxMnFUTHBlaWh0V3pJcm81cGd0TXd0aG9x?=
 =?utf-8?B?MXhQdzVTVWtvRXE2aFhyY09telZTRnlCWHNGNU5yNDIvWWhUS2dEanZ4M1R3?=
 =?utf-8?B?ejVTTUxSbWQ4WG14cG1mUk9nNmlRaE1kd0FsaGFSRHNPMWhaMGh3TW9jZU42?=
 =?utf-8?B?WU9STlFLTHA2K3RMZ2hnSGlYalRjNHh4Y3dFMEx0VWp1bTlLeDlNV0RYSkhp?=
 =?utf-8?B?dmpuMm5mNjZIYWVDd3ZiYTZnWjk5elhKcjdNQlJremxaQ2RxOU44RHlrQzJs?=
 =?utf-8?B?ckRuRHBuWkIzYncvM05PckdyYTdtQWFFQXdVTHBEUmRDV0UvWGZvTlpKWDR6?=
 =?utf-8?B?bkJEK0h3ZFFXYXpwRHVJZHZER3NHamVzMVVkZkt3cG9wZkwyOWNGTTVOMW12?=
 =?utf-8?B?cmxrMlBFWXpOOXJCcjNMSlZzYVA4WlNsUlJtS0RvM1BiTnJpRHpWb2pVSDhE?=
 =?utf-8?B?NHFTeXdmdHdmaEE1aVA5WUg1dUpCckRMQXp4dXd0UWVlVkhUdVQySkNkV3Bx?=
 =?utf-8?B?M0tJUXV2MklpNDc1aEtJWHdkUEtqK0txeXdoMXMrUHB5c2M4VHZpV0RXaWly?=
 =?utf-8?B?bHFTSEwxR2xhWmZIL2NpTTU1VVZoUjIzRitrbnRNYWsvT2hDRG5qdFRFTFZz?=
 =?utf-8?B?bmMwNjBnZGpYWHA4NWhRQktqNERkV3lic0k3a3FaanoxL1lZV0hhSjdBUEpS?=
 =?utf-8?B?U0lzTC9wZzJKd2NXeExXbWlhejVIbWhhaUVNNUkrNktnK3pSTHh6ckdWdEdZ?=
 =?utf-8?B?KzNUY2d6VUVCTjU1R1dIN29TU2E2cWVHNW9uYWE3UVNiQitPVUpKS3RiT1hC?=
 =?utf-8?B?VlhaVU90R0k1NEtMQnNhdHZkeFJHUHBXY3l6alJjS1FVRjdxZ2tiYkNkdTZo?=
 =?utf-8?B?SmxScWhVY1JIeGIvZXBKSnNkMmpCalRrYk1XQm80QllUNUh5OVBpdW9zMEZ1?=
 =?utf-8?B?MzNvbFdIRVdObHhtcnl6VTY5eE0vOUgvS0wwYmFNWEd0Ry9ZZDdwSFVsc25m?=
 =?utf-8?B?cVVGMkFIeE9tdzNTRWpSV01rUzBaMlMzcWR5WGFuYUJRNWZUWS9BUlhIblI2?=
 =?utf-8?B?emNqaUZkNExVVVFyTFdCNFZ5cHllZkF4M2N6dlNPOG10YktXZElqVFYzSG9E?=
 =?utf-8?B?LzB2QWNiYVFuOFlpV0JYakNMNHJncVlITzVpWkRNdkZ6T0JycWN2N2l0RXpB?=
 =?utf-8?B?MmpiSXZhZzJEYUMzZjZoZEgrUDlzeTRTZUY3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnBJcm9tUWRqMHpmZHN3b2dEeWczQTVhczY4VS9HRFV1c0NOcEVQWWhhSllt?=
 =?utf-8?B?a2N1T1l2MWp6bGtTWlhzUnZOdS9EamJyYk9HclJwaHcyQjJUWnNZVDNsUHdR?=
 =?utf-8?B?dm1ZWTNPZ0ZoV3E4U1AvSVFjcFB1bkZidy9lQW9zcER1OFdzNXdqSjY4dTFq?=
 =?utf-8?B?TnA3NGY0QkFQWG9KYnJmY0ZHRURDd2FpVUxQcm85ai84VkQwQjJuVXZFMzZD?=
 =?utf-8?B?SzdiTzVpYnNsaWswSUE0VVJPR1BiVEpROXJ2QnpyenI4QjFyLzdsbStmNXhE?=
 =?utf-8?B?Z1VUVmF1MkpyZE9TN3NMZHpVMXdtM0M4YmdxSllNTFQ5dTMvVkprOE5Vdnlu?=
 =?utf-8?B?dFhzMzZ0Ti9qbmZod3d3cjJYazNRaUpVM0NPZWpiTFhJU2lGUDNOYXlLUTls?=
 =?utf-8?B?U2VaZ3RNbkJqU3NmbmZocVVCQmVYUjUwT0VNeFQ5aTdxZ2tFNWJVQnQwMHFi?=
 =?utf-8?B?ZEFDTENSWVRxZThHKzVRbmNGUS9KZFRSVk1kWnBneGxId2dxT2VDUkNaZnVC?=
 =?utf-8?B?YkJMU0xZdGowbXYrdHNBSGhoZS9CQ2JCMlhMdHpRM1NYSWVNWndqQ3h6VGI3?=
 =?utf-8?B?bFgvT0ZSV3lVRytzbm01YTRtOXhTdHJVYUQwQTc4YmdtUlhxaUI1cUc1SXFW?=
 =?utf-8?B?dmdCYm41TC9kVGh2bTJPRFRyaGZFMVpLWUZ2akFDdHdLSDlRZHBlM0dkbXRS?=
 =?utf-8?B?S2RwOTAvU2xIVmhpMlNaeGpJRFVUWFRRUGRyNXdqM210ZmFTVnZsNklVa1lV?=
 =?utf-8?B?V1NPd1FEMUtLeXhhUEZvdk1rTldvd3dkZWZZNmkycDJuM2Erc3dOY1NFV1dl?=
 =?utf-8?B?M2hFSGtUUVNlaXJiOG5uOEx2bTErN21wNlI1TGxNNjBjQ1pJbGFXNS9QSGJ0?=
 =?utf-8?B?UUdUT05XejNHbFR5clRtbWpPTEZuay9Ydk1hVVlaNkZFSU41d1NGa1JLWXla?=
 =?utf-8?B?b21HWlVpQWl0bFFFdWl6RUpBYzZKSlRMOXF5WmFXWjg5a1FSRHFkVXduRUxo?=
 =?utf-8?B?a1RrS0dQdlBQOVhnbFRPaUt0TDQxdU50UjZtTGt5dGlLNytoRUFnam9ZeG9w?=
 =?utf-8?B?R2EyZ1Y1Q0tTOGordDNwL3BGZm80Ynp3RnJ6L3pJSFNSQXhsMUt4YzZlQ1Yy?=
 =?utf-8?B?RWpnTUdwMzRmZFFMM0lJRXFpWHJQVDJGb1IxcjdqN213dExmNGR3TENsczlz?=
 =?utf-8?B?U0VQcVNVTmhQTHdxOUxxLzVIdm5nT3crNjhFRFpRTDlURXFEaDhGbFNJL3dy?=
 =?utf-8?B?RE5BYTUwMndoS3ZYTndhQXNHd25TK0pDMHhKQTllZ3ZHR1A5SkxGd0RXVkRs?=
 =?utf-8?B?RFNvYnZkV1dIWC9iV1RCeFNQQUMzU0hsc3hoQVdSb0RXRWQ4Q2hlZlJhNlI5?=
 =?utf-8?B?TmxFZDJJd1dvSHZNZ2VKTVE4TGQ2MW1mN1RHb1FmWWlVc2VKVStRa08rT0Rz?=
 =?utf-8?B?cVFXd09KWmprdmVpeHpIVkRBYkFrVnQ5VkZlYzQwZ21lc21TOVZkK2JYR0E3?=
 =?utf-8?B?Nkt0TVloRm1hQU9yMnE5OW5YN1pER1pIblVVczdFekcva0ZhR1I2ODBDaURn?=
 =?utf-8?B?djJoOGZ1ci9HZkpMVUlGQXZKWUYxOGMwcTNEdzliOUkzbExLV3ZmcW5SSFdL?=
 =?utf-8?B?ZHBWS0NCa0t4TUV5TGNMVElSdlNSUytNK2JyTW9veE9wa1VBeGZRN1FnaE9X?=
 =?utf-8?B?eEJyTCtMeENtWEtNbDNHemdid3FVdThhM3JraG5sdFlOblQ5eHUyU2g4c08y?=
 =?utf-8?B?MVZ4L01wQnYyOWw5Z3FzVXdCWEZQM3JxM1loczRFdEovS25ubHJRaTJoWWlG?=
 =?utf-8?B?QVhwUmxHaHR0amxyVlNnUVVQVE1TV1FoT1JyN0RteHo2RjRSWTV6ZGRxL3pP?=
 =?utf-8?B?RlFTNjlHRWxUK2tRQlhVcWJZNVA4a0hocTBzTDBNeUF4bk5DU2VhQnJLazhE?=
 =?utf-8?B?V2ZVTkJ5UDBWS2luZEI3WHNodFp1WjZ0T3lRbHBsNnlLMS9LR1VCc1lNb0NO?=
 =?utf-8?B?MkphQnpNWlIvdUVJckdmS3pMc204OGNpZk5HRnhQc3drdkdMSGJSb2JFTVJN?=
 =?utf-8?B?TE9oWXRDQStlNkx3bmJYblprUklBL21uSjI4MVVhdENudXVCTEliRlByaWo3?=
 =?utf-8?Q?RDi0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce48e683-70ba-474f-e4f5-08de1561151f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 13:59:44.2991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3AG2XE38l+DAXqws0OaKb6CIFsKfFT1WHLFBK6MynPEoS2Afm3+TfLmzXT8MAD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjcsIDIwMjUg
NzoyNSBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBUaG9t
YXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQYXdhbiBHdXB0YQ0KPiA8cGF3YW4u
a3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtl
cm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IEFsZXhh
bmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCA1My81Nl0gZHJpdmVycy9jcHU6IFJlLXBhdGNoIG1pdGlnYXRp
b25zIHRocm91Z2ggc3lzZnMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQg
ZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5p
bmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBP
biAxMC8xMy8yNSAxNzozNCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IENyZWF0ZSBhIG5ldyBm
aWxlIGF0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L21pdGlnYXRpb25zIHRoYXQgcHJpbnRzIHRo
ZQ0KPiA+IGN1cnJlbnQgc2V0IG9mIG1pdGlnYXRpb24gb3B0aW9ucyBhbmQgY2FuIGJlIHdyaXR0
ZW4gdG8gaW4gb3JkZXIgdG8NCj4gPiByZS1zZWxlY3QgbWl0aWdhdGlvbnMuDQo+ID4NCj4gPiBP
bmx5IG9wdGlvbnMgcmVsYXRlZCB0byBtaXRpZ2F0aW9ucyBhcmUgaGFuZGxlZCwgd2l0aCB0aGUg
ZmlsZSBpbml0aWFsbHkNCj4gPiByZXR1cm5pbmcgdGhlIHJlbGV2YW50IG9wdGlvbnMgZnJvbSB0
aGUgY29tbWFuZCBsaW5lLiAgV2hlbiB0aGUgZmlsZSBpcw0KPiA+IHdyaXR0ZW4sIGFueSBleGlz
dGluZyBzZWxlY3Rpb25zIGFyZSBkaXNjYXJkZWQgYW5kIHRoZSBuZXcgb3B0aW9ucyBhcmUNCj4g
PiBldmFsdWF0ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBLYXBsYW4gPGRhdmlk
LmthcGxhbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL0FCSS90ZXN0aW5nL3N5c2ZzLWRl
dmljZXMtc3lzdGVtLWNwdSAgICAgIHwgICA4ICsrDQo+ID4gICBkcml2ZXJzL2Jhc2UvY3B1LmMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMTMgKysrKysrKysrKysrKysrKysrDQo+ID4g
ICBpbmNsdWRlL2xpbnV4L2NwdS5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKw0K
PiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMjQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+DQo+IDxzbmlw
Pg0KPg0KPiA+ICsNCj4gPiArc3NpemVfdCBjcHVfc2hvd19taXRpZ2F0aW9uX29wdGlvbnMoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZQ0KPiAqYXR0ciwgY2hhciAq
YnVmKTsNCj4gPiArc3NpemVfdCBjcHVfc2hvd19taXRpZ2F0aW9uX29wdGlvbnMoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZQ0KPiAqYXR0ciwgY2hhciAqYnVmKQ0K
Pg0KPiBNYWtlIGl0IHN0YXRpYw0KPg0KPiA+ICt7DQo+ID4gKyAgICAgcmV0dXJuIHN5c2ZzX2Vt
aXQoYnVmLCBzYXZlZF9vcHRzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3NpemVfdCBjcHVfd3Jp
dGVfbWl0aWdhdGlvbl9vcHRpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3Vu
dCk7DQo+ID4gKw0KPiA+ICt2b2lkIF9fd2VhayBjcHVfcHJlcGFyZV9yZXBhdGNoX2FsdGVybmF0
aXZlcyh2b2lkKQ0KPiA+ICt7DQo+ID4gK30NCj4gPiArDQo+ID4gK3ZvaWQgX193ZWFrIGNwdV91
cGRhdGVfYWx0ZXJuYXRpdmVzKHZvaWQpDQo+ID4gK3sNCj4gPiArfQ0KPiA+ICsNCj4gPiArdm9p
ZCBfX3dlYWsgY3B1X3NlbGVjdF9taXRpZ2F0aW9ucyh2b2lkKQ0KPiA+ICt7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3NzaXplX3QgY3B1X3dyaXRlX21pdGlnYXRpb25fb3B0aW9ucyhzdHJ1Y3QgZGV2
aWNlICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+IERpdHRvDQo+DQo+IDxzbmlwPg0KDQpBY2ss
IHRoYW5rcw0KDQotLURhdmlkIEthcGxhbg0K

