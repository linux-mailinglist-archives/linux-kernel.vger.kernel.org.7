Return-Path: <linux-kernel+bounces-720827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E587AFC0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EFA421457
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0C21FF2A;
	Tue,  8 Jul 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QLKdJOqO"
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1C21A95D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941693; cv=fail; b=pAcx8ahNP4dANO8O+Lr7aI9oJoU7RCUBCbWHPumiMZ6DkJ6yrVZ3pMc8diErJgMy9+fPENwohczQLx293RrV3Kyw8KMAu2p9QUXPKbJPpi80ohWHbF9pdrIBvskKDgPW55UbHJ4owKzaxBZyBxH85HiwvfIfS4pRXyvI9uZvtgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941693; c=relaxed/simple;
	bh=zGHqzGTH8xetMHloo/12dKt+peJQ2TEE/9uDcx8CFEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GksXvRwmltbxb5WzG3+YU8e2wt5Kwx6HOlIMFQ2GcBMqVtgXk5sYShjR5zp27bCaHw5RenUAvq5VP+XefgQR0Xv/8OELxFBR6zkEBqNQb6EnRmsH1oe62PBuZq+PaSDGZGyIVhGPAI/mRJ1sZWyeVYx03lKCX8uRpU6iU+m1VEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QLKdJOqO; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1751941692; x=1783477692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zGHqzGTH8xetMHloo/12dKt+peJQ2TEE/9uDcx8CFEQ=;
  b=QLKdJOqOGdoFZSWpRrWdwg6QqhHO72omKfHcaRVfP0MlSiBbZFvAL6AP
   kxPoRHIWNhqt1IS6jDRMn8u27rrZKl3H14YgB31y4385L81clVvjD275M
   HII5fwYuHp52bAYhkP3dBqU0RcUsm3AZC0Xfhxo4fJ9qi1i0JlMKOJ7lO
   b9T2lLnuk5VBZVCP8FR9vM+wPP8+hdWj1+22MClGJ68wyI1X9z+0h1LJl
   1tCjfbfPAAHC4qNTHg8aD1Jso4Y+q2Q/dJv6G+bIlp9gZFZcFBFrbbVtt
   xxcOTjHN6l+5mNfC41wiw5sj+kBj5ykIDRqB+EFG57VZZ8AjWIC7ba/AH
   A==;
X-CSE-ConnectionGUID: Izu9Bso1S0+jJKKbJCqU4w==
X-CSE-MsgGUID: URTs9/IsQtmjcHbkpng3Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="160336169"
X-IronPort-AV: E=Sophos;i="6.16,296,1744038000"; 
   d="scan'208";a="160336169"
Received: from mail-japaneastazon11011022.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.22])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 11:26:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKiG4FTYMIyC2CINBlvjkR4qD2GP5OFT7o4wss/XomvYsxqsW493+oWLiJz9HrbaLox5J4vd4l9l+Xhigs+ypEDK+aDMEa1bKOzdgy3qT9y7w3KI2/aN3KEb+x8gqGHuT6tJ8XU+JbO+6Ub0J5oa85SenuEF6cwhntZhju9L/Y2n7oOHAVnJYKMv3djTAVaahLYXp4OWY4F2BCZF6iypNuAdnYlwAheyJmToGrLexVUK1JcQDUekgAfCRhPKCqlJ4UCeoKp2/NexRWO/MosCvMlcJ8js5B8PDcV4k9p8IunL5pfxAN0BTWCizjPxnHwg89ty1LVZLkxsypFYotkKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGHqzGTH8xetMHloo/12dKt+peJQ2TEE/9uDcx8CFEQ=;
 b=h0ssQDT8zyX1hh48V539ZwGnzU4cwLaS9MvnnELLcd50g/SqqtmQ/fi3onuAKo2pQTNRl5+Eb8YYV5fvcdkkACWTqJrKWYrFrLvbYTzp4b7/FAUVF3o80WkWeSvD5PYD+gh5/DVJe7aRAz6ccjuOW21SlXkLpzqz/fvqrFUo+mo/VCiUqvge3bsEy9g7M0N+y0B8I4Im/kn4EpmdQubjwGzzfT99nEVFwn3WWXyyox5INZt/izYzqIKEF8cPX1NY9I0cbp4fB4ukYgmf7TQ+1UrahjssMN+RfqXy/vuRUAxej/c/fYV3irZesgmdD0I1Yrc/F5dlG5VY9dDmlxKNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com (2603:1096:604:3a3::6)
 by TYYPR01MB6959.jpnprd01.prod.outlook.com (2603:1096:400:d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 02:26:54 +0000
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0]) by OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 02:26:54 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "Huang, Ying"
	<ying.huang@intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH RFC v2] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 accounting
Thread-Topic: [PATCH RFC v2] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 accounting
Thread-Index: AQHb5XbVZg4Ev2RiYUGAscIFS7XkjbQa/WiAgAyC+G6AABQ7gA==
Date: Tue, 8 Jul 2025 02:26:54 +0000
Message-ID: <ef637fe1-436e-4003-86fb-47f651433f7b@fujitsu.com>
References: <20250625021352.2291544-1-lizhijian@fujitsu.com>
 <e71873b6-78ac-4555-a6a5-e9b5fb3f9112@fujitsu.com>
 <87tt3nxz4x.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87tt3nxz4x.fsf@DESKTOP-5N7EMDA>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14468:EE_|TYYPR01MB6959:EE_
x-ms-office365-filtering-correlation-id: ec8c2f9c-d655-4eb2-c9fb-08ddbdc6e7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXBMU1lVaDZmbllNTFN6enQ0M3hBZ0g5OVBzek9Zb0t6V0I1Q1A5K2VJYnNx?=
 =?utf-8?B?YWpFWk9hV3poY1RQMmY1c0hVQzRiMkUzRzZnNG1vMHJPZjBUTnJyemtPMDhH?=
 =?utf-8?B?Mi9hdzg4d2wybmpRNHpqZWZQeHoxaWUyMzNVN0haeXhIKzJlZ3h0VllWSTZ3?=
 =?utf-8?B?YTVreTFOZitRUHNOQnU0SFlUNlVSaXl1VnIzWERPbDUwWHc4UU5rWmhCZU1O?=
 =?utf-8?B?TkxFRTJQVk9ST2M0bDk4YjArMWJWSXJlV0ZjQzJZakEvRmZNZUZhTlY5S0d6?=
 =?utf-8?B?ODlSdkxsUHFmMGRlWTBjQVJ2WUYvT2dqdGx4dlR4UjZ6TTdLWXF0bklQemZh?=
 =?utf-8?B?KzhDN0lsYnZ6cytQVTNldnRMUXRXWm5qbVRKTWhxdTFna21INGxRZXFBU3Zq?=
 =?utf-8?B?K1phWlk4Yk11MzZYTkZnejF0cmJ1T3pyM2RjMHAvaUVITmw5L3IraWNpVFEw?=
 =?utf-8?B?anNOcHU3OHZ1TTBPNUFDUXpFVjQ5TFhkY2FLUUJpTmo0eDNLZ05NdmtJeUJ4?=
 =?utf-8?B?NjlrRHJONHNnVVIyVmRwV0l1ejFwblgyVjRXYUZxNE1BNm96NEc4dDBNb04v?=
 =?utf-8?B?aFl6QkxLZlo4U1F1bHQyMTdPZnFvYjBXMlQxQXpiMng4VE5OT0ZpeWMzSFJv?=
 =?utf-8?B?Nm00SEl5ZHRhNE85aTArbzl2WTdsTk9iSUc3SkxRTERyZjhsSVUrQ1puQ3do?=
 =?utf-8?B?VGtKcW5BbU9QL1ArV0JJNmZPV2N5SWovcEt4VlpXSUJNYy9adFBPWUlkMzFN?=
 =?utf-8?B?aEpYR3o1NGNjNWVKRUo3QVJUczUwQyszcFJLT0x6UFZCVldpQWIyODl6VmFQ?=
 =?utf-8?B?WnNnZCtZd3VnQm9CWWswWEpJd1JVOGZxbEticGpsYXRsV2o1bDV5L3Nka0NT?=
 =?utf-8?B?ejZkaHFUU3ZpYlBtL1k1cmpVcXQwbXVlUnFQYStWRDBnQXRxck9KRnVCZ0lj?=
 =?utf-8?B?cEZnRUpLWHdUU05CaUNwbEdicW5mMUNHQXhmYmJkQ2N5d09jVzF2T1pOM0tC?=
 =?utf-8?B?cVNld3NYS21wNzJyeVJMZzNwOUJJenpMSllhelN0VzZ4Wm1rODV4eE9MUDNI?=
 =?utf-8?B?UE0zandRdmFOTGRTaVhuaytId00vT0gzeHdPU0FYOUFYd3l3Z0dYWjBuV1J4?=
 =?utf-8?B?SVQ5bkRrYWtPNmFIbUVET2EvVXFQV3pQeERPS2Vqb2tOZlk1R3YvWUVNUFJw?=
 =?utf-8?B?Sk42SHlRdE4wUzYzd1pKS1FMUXZ6OWJwSUlzZkx3TG9IWSttbndJY0Y3aGJp?=
 =?utf-8?B?cVc0OHMyaTIzODZ6M0dRRStiWG0rOTEyNk1ESUdDUkYxVFZpcVlubFpwNlAx?=
 =?utf-8?B?aEJiaVA4a0I4WXNvNm1nRDRrb1NYMHNSRFArWUZsTVNqWkdzYVExZVhqT1Zi?=
 =?utf-8?B?cDVXamprZHpTK3c3RmtJZWtWNVVmVWc5TVcvV3oxK2tnMmV5SjZtQUpReWZW?=
 =?utf-8?B?WVRJSUpoOGNmYzZOcFRwYURCdkl5VWRBMXdWeTNWM2QzRzBmd3hLcFhWckE3?=
 =?utf-8?B?Ny9kRUE0anhUNEhmTTZNK2hrK3BTam5sRXUvYjFmdDZrR1phdkFWMk1GY1FK?=
 =?utf-8?B?Z0dkUTJHWVBNSXBVWUNrWHA3NlE2K3d1eloxdmg0dWxPb040Qll5MUtmdkUy?=
 =?utf-8?B?ZWpZemZNb0dLS1JIVzBpMFVSeU1jeE9mUTdtd3QxL3dSUS9tbnhIYWJOK2FW?=
 =?utf-8?B?eTVRdWZYWk1pekpaTWM3ZWVtV2x0SkE5SDFHYmpLLzBZWGRRcWJoNXg3a1l1?=
 =?utf-8?B?d3RFOHpmUVl1N2tDNFJqc3lYdVRqUXBCNG5oSFRHVTJHZ2FUVE4yUTYyUXRy?=
 =?utf-8?B?akxya3luTW5vVkVYWmNzWHhLWmxPYUxIWUFtSjcvVHhuNmxtMTdmR2RhR1h5?=
 =?utf-8?B?SzhFeU8yTG9FWFh2RVRXVDFGYk81eEVFQ3FxRTdwcjJIdXJuZk9PdkVIeXls?=
 =?utf-8?B?QWpzVzdoVldQS1Q3djR3Z1RsRmczUG5UNmxyZWwvbE9kRmJmU3I0NFBCL1N5?=
 =?utf-8?B?M0JaQ2s5VzZONzRVenVValZMTmhMVGdBcGZ2TCtqRVRBLzRwL2FzZVVMc25h?=
 =?utf-8?B?a1dsVnZ2OFoxL3N5cDg2MXZWa3psWkQyNWY2Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14468.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUJZcFJvdUU1ZURxSTlBV2E1SkhGemNuclVmTW05UzBEMUY4Uyt2RmtzM2pY?=
 =?utf-8?B?Tm5mQ0JUUlVtbkR5SkVlbW5yd3Z5TDZQMXlOdWYySDJJZXltU0wzdUExMzJG?=
 =?utf-8?B?MitUdGpEeXFRWTV6eWs0RTJmUVZ4bGpDRmhjL0l2c2ppRVJGK0ZRclRLeE83?=
 =?utf-8?B?ZVZDL01wemF2bTlkR0QwWVp0RXh3Ty9VT3IwS0hoTmh2VDlnN29xclJ1Y3F1?=
 =?utf-8?B?SFI5UGhMVlB2bkx2c2hYaUYrd2J0TVFEdFp1c0UydUc2SHA4UERQd2hOYy9a?=
 =?utf-8?B?eHVhaVArenI3MFU2Zzlucm9kRzMvaW4xSVhnQkRSNTFXaDlBSWwycWJnQ2ZR?=
 =?utf-8?B?c0wyRXBWaDBIbjZHWThjRGd1QXFxNlRFdmRNTEJSUWlBNHdXL2dkbUlya3FT?=
 =?utf-8?B?KzdDTUdrY2lFaGNIb0xkYVZid1lDOW05OWVuREpyVFFzK3pYMFg1NlYyQ2JW?=
 =?utf-8?B?QStTdjlmM3ppaFVZNnBCQVpNOWZWVk1tMzhGNStGQ1ZNUHkrL0lMK0JSU2ZZ?=
 =?utf-8?B?bStSZCtIZDlSWjk4a2ViT3kyRE5BcWNFN3hKRjNVWnp4a3pFRUZFcE9LT3d6?=
 =?utf-8?B?YlNWSG9NWkowNy8rd1lUMk0zVkZwZjZCS3l2Y21CSmluMWFHSS9wcCtEa0hm?=
 =?utf-8?B?eVBJUjBtMEFEdzZxcmcvK3crYm14bFNvSk1TNG5uYzI0NVNRcDJ5TVUvTXdm?=
 =?utf-8?B?Y0NDeDVpSXNqZGs4a3dCZ1JaZWFMcnZSL2RtRWl2UzRlVEpsZWJYR3BrMlBL?=
 =?utf-8?B?cGhiaEpvUjlHYWJBTGNGSjlDb0lpbkw4ckx6UVNEUWJOUzlHbnVQUVY5ckE2?=
 =?utf-8?B?eHlESlhZR1FGWm94VzRSMFR4RnNBVk84L2dtNFltUEUwV3hCVnhneGNtNlBa?=
 =?utf-8?B?RDF5N3pGeHd0MGdkMS8wRlFJUWFKTzNoNUd1RC9MeENyaTBLTU1LNDcrck5i?=
 =?utf-8?B?TWhHUXM4SkttM2dyWlNUd3lDWmtTQ3JMMjhRdFNzTGE5YlhxMGNGOVIyV3FJ?=
 =?utf-8?B?b3pYYkQrV1JBWlp1bFI1UmdET0h3cE1QcnR3Y1JGL0ROaDJpMWpRWTg1SEhG?=
 =?utf-8?B?QmFDZG9pemNrUHRMelpZRkExUUNBV0dhcStrU1RsMnphSTNQY3pTWHZQcmVI?=
 =?utf-8?B?QStmTzBoMVZSejcrM1BUd010TDcyRy81cy9TNUd3d05hVDZ1REJkYzFLS3JF?=
 =?utf-8?B?MDhRNXE1b3NHR3AvRDk4cmEwdzliQVQ2T0RsZG1uNHFCYWFkMXEwNlo2dDlU?=
 =?utf-8?B?M2Y3NFBibUlydDNId0hxQVVxd1NoR0lzMi9nZFV6REZkeXl3b0dpK3U5c29r?=
 =?utf-8?B?b2x0dWdESHJKd2FiSlFkeVFzRVlsdVJLNXNDd01YcERFYkxYTkp1am9qY0tn?=
 =?utf-8?B?TGlndGNZdUthb3BzSHBWWmNvdUUrS0NKZVdzbzFUU1MwaWdKSVdrQWFLdXdx?=
 =?utf-8?B?MWRTRVpTSmhoZTdIMkI0UmNSWUtyMURTMFBsVFNpZVRTSUVRRis5a2tKajdM?=
 =?utf-8?B?eExHVnRNVFM4OVA2azBhODJiWWoxdlo2RkFXdC85R21kVlRNUXNJWkxFOElK?=
 =?utf-8?B?aGF6SEU3c0tDb0RBWXdvVWlLalJIRDAxcmg3aTNqN1g1OGxSeVZqZ2RBUDVG?=
 =?utf-8?B?N1RVMGtIRmtrMVpGVlV6VloxMnJrczZVK1E3WnBzVGZ5OXM2dTVldWFZWWto?=
 =?utf-8?B?NG5OSng1TUVXOVFoeGltS09MVnFtTWNWWk1vYXBIYlRDd3g1LzVWYVhPYWdL?=
 =?utf-8?B?NUhnZkE5OU5aNnBqeEhqRjZESm5EaEJUVGhXTlROOVM5VHptbHFVL0FsZ2hN?=
 =?utf-8?B?am9Ya2FlTDUwdkJXN25LREl2QWNGKzFEdUZWNnVlamNRajFDclgrQUxMcUMv?=
 =?utf-8?B?TWlCVzVNc0d2dTl6NjZmOE05UDNNZ241QmVIZXRJbDNZVktqV1F5NFBQbVZM?=
 =?utf-8?B?eDVpODI2bTlyUGZ0eWx4MjIyTlVLMnllR1ZNWXEwYzZKL0tnNEJXWCt0MVhM?=
 =?utf-8?B?d1hOZWtXYkxIM2xaU0xYcnpaTUVOckxIVTBWaDNZSWNqdlp6ejFpMzVVQ3F2?=
 =?utf-8?B?dC96d2lNS1ZTRUZwL0hxLys2ckJ4Mm03T1RpMUpFQk1QWmFJRFFWbFNOOEhY?=
 =?utf-8?B?Skd0OGVFOEFTbm9mZkEzSnhYOUZNVU11VEpTcDRMTXRUNjloWjdISUNRZjdI?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFFB9BCE8BAD744C9D4A30B724F87C5B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+mIGSKYLEbdTFv/y9YBL5TxZmKHc3HygDirnsfdsliwrJoiTGjMrLmJOl/u0iS2yOQz2ODtANA5ePvRqbs1BFXScFRWVk/q2I45FZsKsxDx6zOhDq7g7TPi+VHdiafin8mQCHQqxIQHCRObRLGvPR2e1SOJVib9b2Oko/rgQLipuY3EbUqsE8NrMwfRYCfesu8IxnkQJIw9YsBuJmb2DOsaAn1VBtmbQAhz1Kmyn75l7+RTNxr3TNUosYhVkYyB2G36804/ildkY4p6ApLJRfvVzbP4mDVdFHeInE00YxTkEhDzLy2uqvKfH6EbKgLzBkR3O9GO6dZQW/es/+E5LArUqb+YA6aeDCx8fhg8Y9uFRab4Ruegea9OOPlpH4vPss7fM04ifDXcO7tf+/PrU78Guei0UPA0i2t59flvrYBX2CYEL87L0lwKj70ZNcYfC4ylgCjRkAs6aVdsuLMShX5TqQ875nRUwq8iQKvVD/1jhqsrcX3vaPp2f3fWtNB+6nKPnpigy51Yg/At4qm8xfbeEmSL6qJILtTFEkf9YVppR4exB5OOrUHc0KMsfB03wcSe2jVTQmyKEBqkT6uxmKGrt+kNa02EQfx6MGjZgcGAQq05LVXGd11MiypfQD9UQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8c2f9c-d655-4eb2-c9fb-08ddbdc6e7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 02:26:54.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAOTX8g6+EA2hKvaanzW25hRpActwE9l9Q24tORUyv2GarZkQ0ttOAKG4xO8fnJNbe8zYvU4edrm43KiXEjuMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6959

DQoNCk9uIDA4LzA3LzIwMjUgMDk6MTQsIEh1YW5nLCBZaW5nIHdyb3RlOg0KPiAiWmhpamlhbiBM
aSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+PiBIaSwN
Cj4+DQo+Pg0KPj4gT24gMjUvMDYvMjAyNSAxMDoxMywgTGkgWmhpamlhbiB3cm90ZToNCj4+PiBW
MjoNCj4+PiBGaXggY29tcGlsaW5nIGVycm9yICMgUmVwb3J0ZWQgYnkgTEtQDQo+Pj4NCj4+PiBB
cyBZaW5nIHN1Z2dlc3RlZCwgd2UgbmVlZCB0byBhc3Nlc3Mgd2hldGhlciB0aGlzIGNoYW5nZSBj
YXVzZXMgcmVncmVzc2lvbi4NCj4+PiBIb3dldmVyLCBjb25zaWRlcmluZyB0aGUgc3RyaW5nZW50
IGNvbmRpdGlvbnMgdGhpcyBwYXRjaCBpbnZvbHZlcywNCj4+PiBwcm9wZXJseSBldmFsdWF0aW5n
IGl0IG1heSBiZSBjaGFsbGVuZ2luZywgYXMgdGhlIG91dGNvbWVzIGRlcGVuZCBvbiB5b3VyDQo+
Pj4gcGVyc3BlY3RpdmUuIE11Y2ggbGlrZSBpbiBhIHplcm8tc3VtIGdhbWUsIGlmIHNvbWVvbmUg
YmVuZWZpdHMsIGFub3RoZXINCj4+PiBtaWdodCBsb3NlLg0KPj4+DQo+Pj4gSWYgdGhlcmUgYXJl
IHN1YnNlcXVlbnQgcmVzdWx0cywgSSB3aWxsIHVwZGF0ZSB0aGVtIGhlcmUuDQo+Pg0KPj4gSSBy
YW4gbWVtaG9nICsgcG1iZW5jaCB0byBldmFsdWF0ZSB0aGUgaW1wYWN0IG9mIHRoZSBwYXRjaCgz
IHJ1bnMgWzFdIGZvciBlYWNoIGtlcm5lbCkuDQo+Pg0KPj4gVGhlIHJlc3VsdHMgc2hvdyBhbiBh
cHByb3hpbWF0ZSA0JSBwZXJmb3JtYW5jZSBpbmNyZWFzZSBpbiBwbWJlbmNoIGFmdGVyIGFwcGx5
aW5nIHRoaXMgcGF0Y2guDQo+Pg0KPj4gQXZlcmFnZSAgICAgcG1iZW5jaC1hY2Nlc3MgICAgICAg
ICAgICBtYXgtcHJvbW90aW9uLXJhdGUNCj4+IEJlZm9yZTogICAgIDc5NTY4MDUgcGFnZXMvc2Vj
ICAgICAgICAgICAgICAgIDE2ODMwMSBwYWdlcy9zZWMNCj4+IEFmdGVyOiAgICAgIDgzMTM2NjYg
cGFnZXMvc2VjICgrNC40JSkgICAgICAgIDIwNzE0OSBwYWdlcy9zZWMNCj4gDQo+IEl0J3MgaGFy
ZCBmb3IgbWUgdG8gdW5kZXJzdGFuZCB3aHkgcGVyZm9ybWFuY2UgaW5jcmVhc2VzIGJlY2F1c2Ug
b2YNCj4gaGlnaGVyIHByb21vdGlvbiByYXRlLCB3aGlsZSB0aGUgZXhwZWN0ZWQgYmVoYXZpb3Ig
aXMgbW9yZSBwcm9tb3Rpb24NCj4gcmF0ZSBsaW1pdGluZy4NCg0KR29vZCBxdWVzdGlvbi4NCg0K
QWJvdmUgbWF4LXByb21vdGlvbi1yYXRlIG1lYW5zIHRoZSBtYXhpbXVtIHJhdGUgZHVyaW5nIHRo
ZSBXSE9MRSBwbWJlbmNoIHBlcmlvZCB3aGljaA0KY2FuIG5vdCBpbmRpY2F0ZSB0aGUgdG90YWwg
cHJvbW90ZWQgcGFnZXMuDQoNCkFsbG93IG1lIHRvIHByZXNlbnQgZWFjaCBzYW1wbGUgWzBdIHJl
Y29yZGVkIHBlciBzZWNvbmQgZHVyaW5nIHRoZSBwbWJlbmNoIGR1cmF0aW9uLCBhcyBleGVtcGxp
ZmllZCBiZWxvdzoNCg0KDQogICAgICAgICAgICAgfCAgICAgICBBRlRFUiAgICAgICAgICAgICB8
VlMgfCAgICAgICAgICAgQkVGT1JFICAgICAgIHwNCi0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQp8IFRpbWVzdGFtcCB8
ICBwZ3Byb20vcyAgIHwgIHBnZGVtL3MgIHwgICB8ICBwZ3Byb20vcyAgfCAgcGdkZW0vcyAgfA0K
fC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0tfC0tLS0tLS0tLS0tLXwt
LS0tLS0tLS0tLXwNCnwgICAgIDEgICAgIHwgICAxMjI5NzcgICAgfCAgICAgMCAgICAgfCAgIHwg
ICAxMjMwNTEgICB8ICAgICAwICAgICB8DQp8ICAgICAyICAgICB8ICAgNTAxNzEgICAgIHwgICAg
IDAgICAgIHwgICB8ICAgNTAxNTkgICAgfCAgICAgMCAgICAgfA0KfCAgICAgMyAgICAgfCAgICAg
MTggICAgICB8ICAgICAwICAgICB8ICAgfCAgICAgMjggICAgIHwgICAgIDAgICAgIHwNCnwgICAg
IDQgICAgIHwgICAxNjY0NyAgICAgfCAgICAgMCAgICAgfCAgIHwgICAgIDAgICAgICB8ICAgICAw
ICAgICB8DQp8ICAgICA1ICAgICB8IDIwNzE0OS41ICAgIHwgICAgIDAgICAgIHwgICB8ICAgNzg4
OTUgICAgfCAgICAgMCAgICAgfA0KfCAgICAgNiAgICAgfCAxOTM0MTEgICAgICB8IDE2MTUyMSAg
ICB8ICAgfCAgMTY4MzAxICAgIHwgICA4NzAyICAgIHwNCnwgICAgIDcgICAgIHwgIDUyNDY0ICAg
ICAgfCAgNTM5ODkgICAgfCAgIHwgICA0MjI5NCAgICB8ICAzOTEwOCAgICB8DQp8ICAgICA4ICAg
ICB8ICAgNTEzMyAgICAgIHwgICAyNjI3ICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAg
fA0KfCAgICAgOSAgICAgfCAgICAgMjQgICAgICB8ICAgICA4ICAgICB8ICAgfCAgIDM4NzUgICAg
IHwgICA2MjEzICAgIHwNCnwgICAgMTAgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAg
IHwgIDQ1NTEzICAgICB8ICA0MzI2MCAgICB8DQp8ICAgIDExICAgICB8ICAgICAwICAgICAgIHwg
ICAgIDAgICAgIHwgICB8ICAzNjYwMCAgICAgfCAgNDQ5ODIgICAgfA0KfCAgICAxMiAgICAgfCAg
ICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgMjEwOTEgICAgIHwgIDExNjMxICAgIHwNCnwg
ICAgMTMgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAgIHwgIDEyMjc2ICAgICB8ICAx
MDcxOSAgICB8DQp8ICAgIDE0ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8IDE0
OTY5OSAgICAgfCAxNDk0MDAgICAgfA0KfCAgICAxNSAgICAgfCAgICAgMCAgICAgICB8ICAgICAw
ICAgICB8ICAgfCAgIDQwMjYgICAgIHwgICA0OTMzICAgIHwNCnwgICAgMTYgICAgIHwgICAgIDAg
ICAgICAgfCAgICAgMCAgICAgfCAgIHwgICAzNzgwICAgICB8ICAgICAwICAgICB8DQp8ICAgIDE3
ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAyICAgICAgfCAgICAgMCAg
ICAgfA0KfCAgICAxOCAgICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgICAgMCAg
ICAgIHwgICAgIDAgICAgIHwNCnwgICAgMTkgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAg
fCAgIHwgICAgIDAgICAgICB8ICAgICAwICAgICB8DQp8ICAgIDIwICAgICB8ICAgICAwICAgICAg
IHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KfCAgICAyMSAgICAg
fCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgICA2MiAgICAgIHwgICAgIDAgICAgIHwN
CnwgICAgMjIgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAgIHwgICAyMDE2ICAgICB8
ICAgICAwICAgICB8DQp8ICAgIDIzICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8
ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KfCAgICAyNCAgICAgfCAgICAgMCAgICAgICB8ICAg
ICAwICAgICB8ICAgfCAgICA2MiAgICAgIHwgICAgIDAgICAgIHwNCnwgICAgMjUgICAgIHwgICA4
MzA4ICAgICAgfCAgICAgMCAgICAgfCAgIHwgICAgIDEgICAgICB8ICAgICAwICAgICB8DQp8ICAg
IDI2ICAgICB8ICAgMjIwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAg
MCAgICAgfA0KfCAgICAyNyAgICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgMTk5
NS4wNSAgIHwgICAgIDAgICAgIHwNCnwgICAgMjggICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAg
ICAgfCAgIHwgICAgIDEgICAgICB8ICAgICAwICAgICB8DQp8ICAgIDI5ICAgICB8ICAgNTc5MSAg
ICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KfCAgICAzMCAg
ICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgICA2MiAgICAgIHwgICAgIDAgICAg
IHwNCi0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS18DQp8ICAgdG90YWwgICB8IDY2MjMxMy41ICAgIHwgMjE4MTQ1ICAgIHwg
ICB8IDc0Mzc4OS4wNSAgfCAzMTg5NDggICAgfA0KfCAgICBtYXggICAgfCAyMDcxNDkuNSAgICB8
IDE2MTUyMSAgICB8ICAgfCAgMTY4MzAxICAgIHwgMTQ5NDAwICAgIHwNCi0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQp8
ICAgcG1iZW5jaCB8ICAgICAgICA4NDE2MjUwICAgICAgICAgIHxWUyB8ICAgICAgICA4MDc5NTAw
ICAgICAgICAgfA0KDQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgaGlnaGVyIHBtYmVuY2gg
c2NvcmVzIGFwcGxpZWQtcGF0Y2ggbWF5IGJlIGF0dHJpYnV0ZWQgdG8NCmEgcmVkdWN0aW9uIGlu
IHRoZSB0b3RhbCBudW1iZXIgb2YgcHJvbW90ZWQgcGFnZXMgaW4gdGhlIGVudGlyZSBwbWJlbmNo
IGV4ZWN1dGlvbiBwZXJpb2QuDQooU2ltaWxhciBjaXJjdW1zdGFuY2VzIHdlcmUgb2JzZXJ2ZWQg
aW4gdGhlIHJlc3VsdHMgb2Ygb3RoZXIgdGVzdHMgY29uZHVjdGVkKQ0KDQoNCg0KWzBdDQpiZWZv
cmU6DQpodHRwczovL2dpdGh1Yi5jb20vemhpamlhbmxpODgvbWlzYy9ibG9iL21haW4vMjAyNTA2
MjcvcHJvbW90aW9uLWV2YWx1YXRpb24vd2l0aG91dC1wYXRjaC9wbWJlbmNoLTE3NTA5ODg4NjIu
bG9nDQpodHRwczovL2dpdGh1Yi5jb20vemhpamlhbmxpODgvbWlzYy9ibG9iL21haW4vMjAyNTA2
MjcvcHJvbW90aW9uLWV2YWx1YXRpb24vd2l0aG91dC1wYXRjaC9zYXItMTc1MDk4ODg2Mi5sb2cN
CmFmdGVyOg0KaHR0cHM6Ly9naXRodWIuY29tL3poaWppYW5saTg4L21pc2MvYmxvYi9tYWluLzIw
MjUwNjI3L3Byb21vdGlvbi1ldmFsdWF0aW9uL3dpdGgtcGF0Y2gvcG1iZW5jaC0xNzUwOTg4Mjkx
LmxvZw0KaHR0cHM6Ly9naXRodWIuY29tL3poaWppYW5saTg4L21pc2MvYmxvYi9tYWluLzIwMjUw
NjI3L3Byb21vdGlvbi1ldmFsdWF0aW9uL3dpdGgtcGF0Y2gvc2FyLTE3NTA5ODgyOTEubG9nDQoN
Cg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gDQo+PiBUaGUgZGV0YWlsZWQgbG9ncyBhcmUgYXZhaWxh
YmxlIGF0IFsyXS4NCj4+DQo+PiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL3poaWppYW5saTg4L21p
c2MvYmxvYi9tYWluLzIwMjUwNjI3L3Byb21vdGlvbi1ldmFsdWF0aW9uL3JlcHJvZHVjZS5zaA0K
Pj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS96aGlqaWFubGk4OC9taXNjL3RyZWUvbWFpbi8yMDI1
MDYyNy9wcm9tb3Rpb24tZXZhbHVhdGlvbg0KPiANCj4gW3NuaXBdDQo+IA0KPiAtLS0NCj4gQmVz
dCBSZWdhcmRzLA0KPiBIdWFuZywgWWluZw==

