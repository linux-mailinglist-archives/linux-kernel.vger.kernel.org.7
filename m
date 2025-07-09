Return-Path: <linux-kernel+bounces-722599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD2EAFDCB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB175540357
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B9137750;
	Wed,  9 Jul 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mhBtdZma"
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E680BEC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752023021; cv=fail; b=kiCl7RMhi2Hc8uQdndzzfEdZcCAW/92ud9/0YJldRI5ODUmoh/FKzTN5qm9RkFAjjr+M7kAuApKbP3aqfWQkSXhn/TyTYnIZQ8e3empFKALiuKU1E/1XDwf5eKrMy88xRAtNmFY0QaV4b8EadT9owq81wPafpFCXF6g7lWBZ7js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752023021; c=relaxed/simple;
	bh=J7z/8hpHvNvrjnjB56ziTcx1iZ8ZOAk5GoWRErl3NxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6zmKoPrFWPmAqo5u+SEwr3aqlrHTLRMiWJddmOAMX11+DpnIQYK9+MrFrcyTOvZX0lIPvoWNYpdHKxG8NwyYLHeu+1pCKyp4folhOThpeezXUAl3s4fYy9UuTjQ5StygF54c/YOqeju4u7vnYRCaffqhxBJT95H1iAzOBbdmGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mhBtdZma; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752023019; x=1783559019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J7z/8hpHvNvrjnjB56ziTcx1iZ8ZOAk5GoWRErl3NxE=;
  b=mhBtdZmaM+5FtZ7MfbhrWRxeYFSF47vY84qsm7KffTFgQBVisergBso8
   FkCJ67x8KUMDBhayAI/FCSoQGXM0SB8RI2BDjcMk1opKR+6NhxUhnt/aW
   H5fqXQtXIJdvB00UnlmO3MfegSGUuIFAXUvfO8zkB9SS75abdu9htmSbu
   AKt9RuLSBsUbOeE+Jz5ZNYnXQMI4fd3G94JpprQWqEw5kusBf+XiLC5sN
   WsINvFHg3ZPOjIVZWK27UcTbMUdOT998rTSxQxjTLk4Ef/xrHoTw+Pr13
   HNRFAXL2iJNG1/ULQ8r99uMKNdh+soZ3s4xfGqyPcWosFVymp428zilK5
   Q==;
X-CSE-ConnectionGUID: L9PAUnAQTyu2mjRJj8Xbww==
X-CSE-MsgGUID: cw944nbuTn29vV+fN9kIog==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="73963504"
X-IronPort-AV: E=Sophos;i="6.16,298,1744038000"; 
   d="scan'208";a="73963504"
Received: from mail-japaneastazon11011067.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.67])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 10:03:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aF2KIb5PciW2y6Mj2Y3tML6BSG3jEWKrggSEE6Lz+q6nLJIvKjxestMYEIFB1xuqzBpIjwUOhEChEF65BJeKzizz0Rw1A9kYg6+K0JJBdB4uRLY8mkJvv2u/G3n7DOGcrerhIwJsEaVXXAYN9noT207qI5Ea01zCrDw8jQk/tT6VdK4BNKbE9gbkfP5QXSg7/7w15GKqddPd0Wgin26A0zgygsiFQanFnOL2/zC95QMWcOlMoJliQRShZNkXe0IDEUHP2MXWo65LUWRoKzNZ8NByGsT+tEJvU4Hg7zjmA5kdu1V2TRkq/qz7xVKINIQg9LwEYlemNM6PLWVP6hoAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7z/8hpHvNvrjnjB56ziTcx1iZ8ZOAk5GoWRErl3NxE=;
 b=yX/BYRCIld3VVx3ElqrF/Tvks4qIUbNAC9lDSGF6UTDeQ25dhKEwYuTOxolMiYXsYMK9l7OufBaS2wCKtoE3SIImkYNWZg78EGVgs08sasy6SYza5J8BR2fqGsoqsmBDlkvefAsNR4Jxa8+EzaDgfvYZ+RQMnvS5hrJl+QZAwIGJiY2wNKYqmr9tvE7tEZspz9MrzThUQl6C23KSm7X1tL6lv4qH3ap2VNXY+MoaFyQpbMEvx+qSrLy/jng1LYrtqTU2jFo5ywPNdIycWP8JbjL/5iiFIz2KAu8WTt39vkXli9XxCNwFFwiqSA6anMqdXhz1QetONLwXAP8TEtG0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com (2603:1096:604:3a3::6)
 by TYCPR01MB7090.jpnprd01.prod.outlook.com (2603:1096:400:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 01:03:28 +0000
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0]) by OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 01:03:28 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
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
Thread-Index:
 AQHb5XbVZg4Ev2RiYUGAscIFS7XkjbQa/WiAgAyC+G6AABQ7gIAABeW1gABA0oCAACZPEIABDf+A
Date: Wed, 9 Jul 2025 01:03:28 +0000
Message-ID: <459ebad2-3fde-4ee4-84b9-6e1e158632ca@fujitsu.com>
References: <20250625021352.2291544-1-lizhijian@fujitsu.com>
 <e71873b6-78ac-4555-a6a5-e9b5fb3f9112@fujitsu.com>
 <87tt3nxz4x.fsf@DESKTOP-5N7EMDA>
 <ef637fe1-436e-4003-86fb-47f651433f7b@fujitsu.com>
 <87zfdfwg8h.fsf@DESKTOP-5N7EMDA>
 <4f98ce21-39da-410b-bec0-2b6f240e550e@fujitsu.com>
 <87wm8jukkp.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87wm8jukkp.fsf@DESKTOP-5N7EMDA>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14468:EE_|TYCPR01MB7090:EE_
x-ms-office365-filtering-correlation-id: 8ee1d5ec-0959-43d3-bde6-08ddbe846a47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWs3Um1tRiswWnkxWWVMQXNQaVRwdkY3TU5QVzZBajBSUERpQUJtZ0toVW9V?=
 =?utf-8?B?K2lRUjlwOUszeWl1aVNFYkVoblpzcVk0b3dTOThoaDBxcnhBaThCZDgyN2Jl?=
 =?utf-8?B?cVBtNm9jRHlDK0ZaZEZPOGplcTlGek9yLzk1eUhDMWVwNi9pYytKMXpmVmx5?=
 =?utf-8?B?WEgzc21XTm1yMDF6b3N4ZUFlbXdaNTdraUg1Ujl6aUdtWTlYNTRmdzcrWm9m?=
 =?utf-8?B?eHR1cWNPNmRXaVFCM3FuakxmOWwrOWV3TTduVllNajZYOWczeFlqbmtCUTYw?=
 =?utf-8?B?blJ1ODdBRFQ5ZHBNM3YyU0tFd2x1K2RQNE1KQlg2WG9kTjBqT05zTnNyb1VJ?=
 =?utf-8?B?ajUwQU9UZ09TNkJZN0lieCthMWFoZnhFUWtNY0xiM2lqV2FBMExwWjRSbXNX?=
 =?utf-8?B?M2xVbGM3QzIvWk1hNDFFT1pOZkNJVVkxZWMyK3pJc0J6S3kxZmNhMzJSYlZW?=
 =?utf-8?B?bDY5Z2pqUExiUFFXWXNsc2ZGNDhESm01OXZOVDl2VjlVVEhiU3BpMm4zd3ky?=
 =?utf-8?B?cnpTUlVxVFg2MkpNUy9Qd01NZjA5YjhNMUZ4TVg3cWFZa3hZSjJEQmxPRDNo?=
 =?utf-8?B?ZCthLzZMWVN5V2FCSUYyeWxOUEJvSTIzeWdGM1lYd3d3Ukc3Z0tJaXNYaTcv?=
 =?utf-8?B?U2pPQ1p1L2RGcUx3QjZyaUNDTytnZnYycW01R0I1cGxIMUZQb1daMWU2M1ds?=
 =?utf-8?B?Z3RDc0IrUUtKSDVwZFZoV2NXT3oxWlpCcy9adFpPNVJaOFo3bGdCcmkzY1dB?=
 =?utf-8?B?ZzdHVFBjUXF0dUF5ek11c3ZCZFdzYWIwemdtV09OenorL3Ywbk5CRUtwOFlw?=
 =?utf-8?B?MEdkVzVMQkxhN1lBcmx1VWtSZXVYY3YwRWl6clBXbG1CWlpuMnFwRm55cG1S?=
 =?utf-8?B?MzNzK1M4dXRxY25BZ0ZEWjBJeWhaS2R2Smp4dlMwdmpGSFpjejl6a2JNYVFh?=
 =?utf-8?B?UWhjdXREbyswQU9HMDdpZGpLU2RiSFJtWVpOWCs0N0d5LzVBQmg0Mi85WDgx?=
 =?utf-8?B?Y0VSNDRnNkhFSDRia3V5dUxFOW4vMFluM0t2QjI4VE90WDM2Nk9RZGdwQU8z?=
 =?utf-8?B?cHlQVEtXZTVSSENMb2Ixelp4MWEzOCtSeXpvenUzaVNWTG1ONUo3K2VoK1RT?=
 =?utf-8?B?Wi9XUGFDYW8wRGVoMVErQURsYWFtNHMxZzF6d1FGOTRuNndJZ2ZSSG5vUU81?=
 =?utf-8?B?QVk1RytsV3VpZi9RZm8rRlBhNmdUdW5rVXkvZnYyVFVMWk13ZDR3L3JPYUFl?=
 =?utf-8?B?VU0ra3AxWjhKWVZNQVFLeHNSTHdyajdDcWtKMXNib3BURVhqbXJSTllhSVI0?=
 =?utf-8?B?Q3R0dE5TOHpIN1Q4ZkNCTzFPaVBTSWNQK2ZqSTl1ZFpCMXpaNGJUdGZaZFBm?=
 =?utf-8?B?a1ZOZlBka1lUZ1hmOFk1Ym0vZzBYL0l3Nk15T0s1YVlrZFR1SG05Uy9QN0pQ?=
 =?utf-8?B?ZTZRajBDUG8za09IdS9JT3NnRnBia2dIN215L3ozT3U3M0tRdDg1V2RtaEp2?=
 =?utf-8?B?R00xMDN0cmxvSzlld0lHalA0TlYrdkRCYi9WU3lOMkgveWhFT29EUHlicmRZ?=
 =?utf-8?B?T3BNam1PeWY2Wlh1dU5rVjBOM3lDRlJCWXlLTm1XMWVGdnhEZW9wa0U5SzAz?=
 =?utf-8?B?MlNhdjlabXN4WkduRFl1Z0pENzVuNzIzazJNSEp5RGxTZWI1enJOUm1MdkNs?=
 =?utf-8?B?bmJmTTh3T2EzYXFXNEJEVDduK1IxQnJmVGs0YmJKSmdTVVpZUXVJYU10czRY?=
 =?utf-8?B?SzAvaS96VG5jM2hkVDFhZkNWN05ieTRteklhTXZkTkRLQWVHbHp0cG5MV3FU?=
 =?utf-8?B?eFhQUittdmw0YncvKzFndVA1d1pXNW1aT1ZkVkZ4ZUVNQkpPZWNMOS9HdFNv?=
 =?utf-8?B?QUpDOXljMWZ6d2RzQlpPNnNwWTVhRXhJVUh6UzlwR08rQnpubVp0c0x1SXhZ?=
 =?utf-8?B?bTUvc2gwRlQzNEJ4a3lkUG1HZmNWM1NoakhFcjIxQXdzUGMxbmZpTkV5YTE4?=
 =?utf-8?B?RDdLSzVrUGd0MWxKL0puV1hOTGh3ZGNrWkg3L2ZRN0ZkQStXZW9HZHd5V0w1?=
 =?utf-8?B?UFFGSUUxT3ZIZmRBU0JwRkdYUTBFVVpNNmNMZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14468.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3F4VWJ2MnlMQmxwdzJXVnhvTHFtQkROWXNBS1VFL1pyeG9NRUM3dHpOQlRp?=
 =?utf-8?B?NmNzSVRvRUVPakZwaGVKSFlvMFJMRXhaUURWZlk5RlBrdzRTR0xrdXoxUTBI?=
 =?utf-8?B?blB0Y2c2T0VBbW5yckxZbytLZXo1YjQxMXF4NTVwaG92TlZVTzNXVUJadGY3?=
 =?utf-8?B?S0RWMWxHZjRCZHlDQmw0YlB2Mmh5OXJIcUVETWNxcGN6K25yUFRjSEJubnBy?=
 =?utf-8?B?UlNGb3dWUkFsWldJa1pLZUlyQ2Q4am42RnQvaldFeHM1M0VZTXptSjdlUUZU?=
 =?utf-8?B?R2hSdGRxTkVkL1N1Sy93NFhUNWVMNzYyeWs1eUVrdHRDcHdWU2J5ZTlYclQ2?=
 =?utf-8?B?MUc2dnFzSm9GdVE2YVYzQnovTnNNSCt6bndKWGMrZXpBVC90aHZrVG1iNGRP?=
 =?utf-8?B?V0tIaHV3OTNuc3lUbFZDMXE2M2VzSExYMTNVeCttdU1vMVUwYnB2WFA5bndj?=
 =?utf-8?B?LzBhR2NZMks2OUl6NGFUT3ViVW45TFMreWgzQ1htbmtQNi8vaU45YmhhVDgv?=
 =?utf-8?B?RHZLVFpKWjVHdHZjRTBMM2l1aHV5YzV0K0k5aUl6YnhmVnlScUc1clVqeVh0?=
 =?utf-8?B?TlgxWTM1SzY4VVl2ZmtJdG1XQ0hOdjFNSEE3QlIvQWgrZ2tFdGx3VXpMNFY0?=
 =?utf-8?B?SGlSWkNFYVpkUmo2em1Ya3ZYdXplMUhSaHNyMkNhSUp6NFFpV3l2eFd0NEw1?=
 =?utf-8?B?R2RMT1dzTCtScGtRSWhzd1FBME1uSTdSNHBHRU5PdTZ2MnlIbVRka2FicTNK?=
 =?utf-8?B?clNMNEJYdkgzNEpwZWJJbzVNTlpQckFmUkFFa0RJRmFoenUwZ1pRbWRYZ1Z2?=
 =?utf-8?B?NW1NWm0zd3FCS21QZEFZaG5VeTVZSm9VcSs5RjM3UVpUb294U3VqODFSVUNN?=
 =?utf-8?B?RktOS1pBOTd3THZBRUJrb3JzcjZPSnRrdGVGQWtURHlkaWhhUjY4Qkc0S1F4?=
 =?utf-8?B?THc1TEhMczVBVVVLZTFpK1liT2J5eW9Nbm9XQnNPNW8zNW1UTUFLMzNQMmFs?=
 =?utf-8?B?NkpxYmp3L2ZTODRMeUhXZ1JQMi9qZEFRTGJvdDJYTDUwYkl3MnQ2L2tiaG5o?=
 =?utf-8?B?c05jQ0gzV01mdXYzeSszZEJwSlJtREI4WFhodUhwRHYwMkJ3WCtqMzAyZkxy?=
 =?utf-8?B?NFZXd1dWQW8wdXRGeEEzNDR2cTAweG5DRkttT3JhdmVsMmJndERHQ3Q3c2VO?=
 =?utf-8?B?QjNsZi9pZlFXQ1R1QmJxQ1NUSXhRMHBad0ZHNCtXSkcyVlJRRzdMSkpka2pG?=
 =?utf-8?B?c3VpNW44SXIwNWFHWnBUeVNHZ3hEWE4xOEIvY05GY2ZpcnRtQUF3S2wzdUV3?=
 =?utf-8?B?elVPdmE0UHA1T3RKU1krdEx3QVc2RmNESGtwKzFEdFVNekx0NTcycWFuRThj?=
 =?utf-8?B?amhIcTkxMTlhcXNBTStpRVM1d1lReGpQc0Y4VFB4NWd3bVN0UW9yMjNwN1gx?=
 =?utf-8?B?dUpiaVZ6by9zSmkxejNid3RaNDFjVmRabjV5aVI5am05akx1andvYmVGNDRV?=
 =?utf-8?B?ZnhnZ2FCVTNDZGcvR0FxSmJzUWRmcmJIRStDK0EwL0w1MVhzaUc2cXlRcmlR?=
 =?utf-8?B?ZUkrd3VhM0RhWUh1TzJkMVlMdGRFVnhUM25uQ0lGKzJhTmpsZ0dHMDZDMTM0?=
 =?utf-8?B?UlNsQVhISnNCbFV4QmJQRWZqNFVacE1XY3YxMG5zZDMvc09FL1ZHVTN3M3ZE?=
 =?utf-8?B?Ym9SYzFMYll1c1BZTDlpMDZ0YUxMVXk0TTlPTjZ2d2xtNDEweU5jSGdSdTNN?=
 =?utf-8?B?MTY3T1orL0p6RlByKzRtTHUrRzAvbnpndnY5S2IvcXJzbnkxajUveitxNVBz?=
 =?utf-8?B?SXMwVjZadmhkWGdidCthYWxBYURUeXRZanByRks3ZjIrUFp2QzdCQXdiemtM?=
 =?utf-8?B?Ri96WjIrRkw3TE0zQmQ2MStXdmRQaWRMQktqdDlCR1VnYzFqb1RSVUlKL0dK?=
 =?utf-8?B?Z2ZtODBRUjVxeW1MYkhzeHllRTFydlNhNkRZekZZc082V1NwYVpEWTZ1Sjh2?=
 =?utf-8?B?anhKNHlUNzQ2R252TldBTlRqUlN2bDVPK24rWmhFU0hwaEkrQ3B3ZDg3L2pK?=
 =?utf-8?B?dHBUdzJFRFR3aXd2c2NNTktjaTIyV0Y2clpjeUMybnR2MGlsRFdET2VMZ3hN?=
 =?utf-8?B?T3k3aHVJTXlJcm9NWWxkQ2YrMVg5VVVWVlY5WlpZVVBFSmQ1TjgyQWo5Yms0?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FDF317BEED4004986B6D56DA3506068@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O7C7TnleQTNFgDXRRZbvm7zTGc7lYqFFtfIzttSTOP2++gxOgVlV/rmdkJ8APcpNdia+5K6f+4sdY9JRD876iizbpYu1y2HU8X5TAuV3fnOrB9AEoy24NVnXevqRQsOV3jzs+OU0O5h1eQcCp2CytrINX7+qC5RQTOqYki/mgy7JJPXwYpoWRX6YYEMQ3DsHB/J6vveytLJnfginPinkrxrr8LR0UTL4eyCLQME9rvIxV6aseYj5X3oeTG/l9dpeg0dLoQa0oBxgJds8P8cYITo/kiz1ssSg+K5RHQbQE+m68U9IMdWfeY/67erX+yitaUJ7gKqIMdg4R6KimomvOLXaRItetkcJUlwW/nvh8ky8j9YI8D6R3tdijR4VY9BG/AfWA/OYD982Kv7rBFUmweYsi/6nphYesQBcsUeT58yFWO4i+KHY0qMEeMYMzrk7oUo2qZPD7c1l9o/wtBXos7rNszWM+lspXcB1xxB/41p9VfKhCWyaTa3ZGmZr//3g5tuWZFBQAhUAPlFd/eW8n58kJhwCxp9mBnHDnoS0Xi2w74gRN/Z8gnuOLYWqe2gP0OYe5N6Qt1WRsCAzkzeAAzra4jb33wWSgrW5BejVdo86D96TQ2Kg6snetZ8WL2WI
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee1d5ec-0959-43d3-bde6-08ddbe846a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 01:03:28.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWG9jncxrEWZ8GMsU9SAgTGEh9VCKTWBHGEVDEcAXGqpqF6LU70MNS2Fhw979pfzOoUugtPxIdXCMZBv7J9kow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7090

DQoNCk9uIDA4LzA3LzIwMjUgMTY6NTYsIEh1YW5nLCBZaW5nIHdyb3RlOg0KPiAiWmhpamlhbiBM
aSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+PiBPbiAw
OC8wNy8yMDI1IDEwOjQ3LCBIdWFuZywgWWluZyB3cm90ZToNCj4+PiAiWmhpamlhbiBMaSAoRnVq
aXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiBPbiAwOC8w
Ny8yMDI1IDA5OjE0LCBIdWFuZywgWWluZyB3cm90ZToNCj4+Pj4+ICJaaGlqaWFuIExpIChGdWpp
dHN1KSIgPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JpdGVzOg0KPj4+Pj4NCj4+Pj4+PiBIaSwN
Cj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gT24gMjUvMDYvMjAyNSAxMDoxMywgTGkgWmhpamlhbiB3
cm90ZToNCj4+Pj4+Pj4gVjI6DQo+Pj4+Pj4+IEZpeCBjb21waWxpbmcgZXJyb3IgIyBSZXBvcnRl
ZCBieSBMS1ANCj4+Pj4+Pj4NCj4+Pj4+Pj4gQXMgWWluZyBzdWdnZXN0ZWQsIHdlIG5lZWQgdG8g
YXNzZXNzIHdoZXRoZXIgdGhpcyBjaGFuZ2UgY2F1c2VzIHJlZ3Jlc3Npb24uDQo+Pj4+Pj4+IEhv
d2V2ZXIsIGNvbnNpZGVyaW5nIHRoZSBzdHJpbmdlbnQgY29uZGl0aW9ucyB0aGlzIHBhdGNoIGlu
dm9sdmVzLA0KPj4+Pj4+PiBwcm9wZXJseSBldmFsdWF0aW5nIGl0IG1heSBiZSBjaGFsbGVuZ2lu
ZywgYXMgdGhlIG91dGNvbWVzIGRlcGVuZCBvbiB5b3VyDQo+Pj4+Pj4+IHBlcnNwZWN0aXZlLiBN
dWNoIGxpa2UgaW4gYSB6ZXJvLXN1bSBnYW1lLCBpZiBzb21lb25lIGJlbmVmaXRzLCBhbm90aGVy
DQo+Pj4+Pj4+IG1pZ2h0IGxvc2UuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IElmIHRoZXJlIGFyZSBzdWJz
ZXF1ZW50IHJlc3VsdHMsIEkgd2lsbCB1cGRhdGUgdGhlbSBoZXJlLg0KPj4+Pj4+DQo+Pj4+Pj4g
SSByYW4gbWVtaG9nICsgcG1iZW5jaCB0byBldmFsdWF0ZSB0aGUgaW1wYWN0IG9mIHRoZSBwYXRj
aCgzIHJ1bnMgWzFdIGZvciBlYWNoIGtlcm5lbCkuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGUgcmVzdWx0
cyBzaG93IGFuIGFwcHJveGltYXRlIDQlIHBlcmZvcm1hbmNlIGluY3JlYXNlIGluIHBtYmVuY2gg
YWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaC4NCj4+Pj4+Pg0KPj4+Pj4+IEF2ZXJhZ2UgICAgIHBt
YmVuY2gtYWNjZXNzICAgICAgICAgICAgbWF4LXByb21vdGlvbi1yYXRlDQo+Pj4+Pj4gQmVmb3Jl
OiAgICAgNzk1NjgwNSBwYWdlcy9zZWMgICAgICAgICAgICAgICAgMTY4MzAxIHBhZ2VzL3NlYw0K
Pj4+Pj4+IEFmdGVyOiAgICAgIDgzMTM2NjYgcGFnZXMvc2VjICgrNC40JSkgICAgICAgIDIwNzE0
OSBwYWdlcy9zZWMNCj4+Pj4+DQo+Pj4+PiBJdCdzIGhhcmQgZm9yIG1lIHRvIHVuZGVyc3RhbmQg
d2h5IHBlcmZvcm1hbmNlIGluY3JlYXNlcyBiZWNhdXNlIG9mDQo+Pj4+PiBoaWdoZXIgcHJvbW90
aW9uIHJhdGUsIHdoaWxlIHRoZSBleHBlY3RlZCBiZWhhdmlvciBpcyBtb3JlIHByb21vdGlvbg0K
Pj4+Pj4gcmF0ZSBsaW1pdGluZy4NCj4+Pj4NCj4+Pj4gR29vZCBxdWVzdGlvbi4NCj4+Pj4NCj4+
Pj4gQWJvdmUgbWF4LXByb21vdGlvbi1yYXRlIG1lYW5zIHRoZSBtYXhpbXVtIHJhdGUgZHVyaW5n
IHRoZSBXSE9MRSBwbWJlbmNoIHBlcmlvZCB3aGljaA0KPj4+PiBjYW4gbm90IGluZGljYXRlIHRo
ZSB0b3RhbCBwcm9tb3RlZCBwYWdlcy4NCj4+Pj4NCj4+Pj4gQWxsb3cgbWUgdG8gcHJlc2VudCBl
YWNoIHNhbXBsZSBbMF0gcmVjb3JkZWQgcGVyIHNlY29uZCBkdXJpbmcgdGhlIHBtYmVuY2ggZHVy
YXRpb24sIGFzIGV4ZW1wbGlmaWVkIGJlbG93Og0KPj4+Pg0KPj4+Pg0KPj4+PiAgICAgICAgICAg
ICAgICB8ICAgICAgIEFGVEVSICAgICAgICAgICAgIHxWUyB8ICAgICAgICAgICBCRUZPUkUgICAg
ICAgfA0KPj4+PiAtLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4+PiB8IFRpbWVzdGFtcCB8ICBwZ3Byb20vcyAgIHwg
IHBnZGVtL3MgIHwgICB8ICBwZ3Byb20vcyAgfCAgcGdkZW0vcyAgfA0KPj4+PiB8LS0tLS0tLS0t
LS18LS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS18LS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0t
fA0KPj4+PiB8ICAgICAxICAgICB8ICAgMTIyOTc3ICAgIHwgICAgIDAgICAgIHwgICB8ICAgMTIz
MDUxICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgICAyICAgICB8ICAgNTAxNzEgICAgIHwgICAg
IDAgICAgIHwgICB8ICAgNTAxNTkgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgICAzICAgICB8
ICAgICAxOCAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAyOCAgICAgfCAgICAgMCAgICAgfA0K
Pj4+PiB8ICAgICA0ICAgICB8ICAgMTY2NDcgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAg
ICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgICA1ICAgICB8IDIwNzE0OS41ICAgIHwgICAgIDAg
ICAgIHwgICB8ICAgNzg4OTUgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgICA2ICAgICB8IDE5
MzQxMSAgICAgIHwgMTYxNTIxICAgIHwgICB8ICAxNjgzMDEgICAgfCAgIDg3MDIgICAgfA0KPj4+
PiB8ICAgICA3ICAgICB8ICA1MjQ2NCAgICAgIHwgIDUzOTg5ICAgIHwgICB8ICAgNDIyOTQgICAg
fCAgMzkxMDggICAgfA0KPj4+PiB8ICAgICA4ICAgICB8ICAgNTEzMyAgICAgIHwgICAyNjI3ICAg
IHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgICA5ICAgICB8ICAgICAy
NCAgICAgIHwgICAgIDggICAgIHwgICB8ICAgMzg3NSAgICAgfCAgIDYyMTMgICAgfA0KPj4+PiB8
ICAgIDEwICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICA0NTUxMyAgICAgfCAg
NDMyNjAgICAgfA0KPj4+PiB8ICAgIDExICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwg
ICB8ICAzNjYwMCAgICAgfCAgNDQ5ODIgICAgfA0KPj4+PiB8ICAgIDEyICAgICB8ICAgICAwICAg
ICAgIHwgICAgIDAgICAgIHwgICB8ICAyMTA5MSAgICAgfCAgMTE2MzEgICAgfA0KPj4+PiB8ICAg
IDEzICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAxMjI3NiAgICAgfCAgMTA3
MTkgICAgfA0KPj4+PiB8ICAgIDE0ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8
IDE0OTY5OSAgICAgfCAxNDk0MDAgICAgfA0KPj4+PiB8ICAgIDE1ICAgICB8ICAgICAwICAgICAg
IHwgICAgIDAgICAgIHwgICB8ICAgNDAyNiAgICAgfCAgIDQ5MzMgICAgfA0KPj4+PiB8ICAgIDE2
ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgMzc4MCAgICAgfCAgICAgMCAg
ICAgfA0KPj4+PiB8ICAgIDE3ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAg
ICAyICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDE4ICAgICB8ICAgICAwICAgICAgIHwg
ICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDE5ICAg
ICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAg
fA0KPj4+PiB8ICAgIDIwICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAw
ICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDIxICAgICB8ICAgICAwICAgICAgIHwgICAg
IDAgICAgIHwgICB8ICAgIDYyICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDIyICAgICB8
ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgMjAxNiAgICAgfCAgICAgMCAgICAgfA0K
Pj4+PiB8ICAgIDIzICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAg
ICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDI0ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAg
ICAgIHwgICB8ICAgIDYyICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDI1ICAgICB8ICAg
ODMwOCAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAxICAgICAgfCAgICAgMCAgICAgfA0KPj4+
PiB8ICAgIDI2ICAgICB8ICAgMjIwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAg
fCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDI3ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAg
IHwgICB8ICAxOTk1LjA1ICAgfCAgICAgMCAgICAgfA0KPj4+PiB8ICAgIDI4ICAgICB8ICAgICAw
ICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAxICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiB8
ICAgIDI5ICAgICB8ICAgNTc5MSAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAg
ICAgMCAgICAgfA0KPj4+PiB8ICAgIDMwICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwg
ICB8ICAgIDYyICAgICAgfCAgICAgMCAgICAgfA0KPj4+PiAtLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4+PiB8ICAg
dG90YWwgICB8IDY2MjMxMy41ICAgIHwgMjE4MTQ1ICAgIHwgICB8IDc0Mzc4OS4wNSAgfCAzMTg5
NDggICAgfA0KPj4+PiB8ICAgIG1heCAgICB8IDIwNzE0OS41ICAgIHwgMTYxNTIxICAgIHwgICB8
ICAxNjgzMDEgICAgfCAxNDk0MDAgICAgfA0KPj4+PiAtLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPj4+PiB8ICAgcG1i
ZW5jaCB8ICAgICAgICA4NDE2MjUwICAgICAgICAgIHxWUyB8ICAgICAgICA4MDc5NTAwICAgICAg
ICAgfA0KPj4+Pg0KPj4+Pg0KPj4+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlIGhpZ2hlciBw
bWJlbmNoIHNjb3JlcyBhcHBsaWVkLXBhdGNoIG1heSBiZSBhdHRyaWJ1dGVkIHRvDQo+Pj4+IGEg
cmVkdWN0aW9uIGluIHRoZSB0b3RhbCBudW1iZXIgb2YgcHJvbW90ZWQgcGFnZXMgaW4gdGhlIGVu
dGlyZSBwbWJlbmNoIGV4ZWN1dGlvbiBwZXJpb2QuDQo+Pj4+IChTaW1pbGFyIGNpcmN1bXN0YW5j
ZXMgd2VyZSBvYnNlcnZlZCBpbiB0aGUgcmVzdWx0cyBvZiBvdGhlciB0ZXN0cyBjb25kdWN0ZWQp
DQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IFswXQ0KPj4+PiBiZWZvcmU6DQo+Pj4+IGh0dHBzOi8v
Z2l0aHViLmNvbS96aGlqaWFubGk4OC9taXNjL2Jsb2IvbWFpbi8yMDI1MDYyNy9wcm9tb3Rpb24t
ZXZhbHVhdGlvbi93aXRob3V0LXBhdGNoL3BtYmVuY2gtMTc1MDk4ODg2Mi5sb2cNCj4+Pj4gaHR0
cHM6Ly9naXRodWIuY29tL3poaWppYW5saTg4L21pc2MvYmxvYi9tYWluLzIwMjUwNjI3L3Byb21v
dGlvbi1ldmFsdWF0aW9uL3dpdGhvdXQtcGF0Y2gvc2FyLTE3NTA5ODg4NjIubG9nDQo+Pj4+IGFm
dGVyOg0KPj4+PiBodHRwczovL2dpdGh1Yi5jb20vemhpamlhbmxpODgvbWlzYy9ibG9iL21haW4v
MjAyNTA2MjcvcHJvbW90aW9uLWV2YWx1YXRpb24vd2l0aC1wYXRjaC9wbWJlbmNoLTE3NTA5ODgy
OTEubG9nDQo+Pj4+IGh0dHBzOi8vZ2l0aHViLmNvbS96aGlqaWFubGk4OC9taXNjL2Jsb2IvbWFp
bi8yMDI1MDYyNy9wcm9tb3Rpb24tZXZhbHVhdGlvbi93aXRoLXBhdGNoL3Nhci0xNzUwOTg4Mjkx
LmxvZw0KPj4+Pg0KPj4+DQo+Pj4gQ2hlY2sgdGhlIHVzYWdlIG9mIFBHUFJPTU9URV9DQU5ESURB
VEUgYWdhaW4uICBJdCBpcyB1c2VkIG5vdCBvbmx5IGJ5DQo+Pj4gcmF0ZSBsaW1pdGluZywgYnV0
IGFsc28gcHJvbW90aW9uIHRocmVzaG9sZCBhZGp1c3RtZW50LCBwbGVhc2UgdGFrZSBhDQo+Pj4g
bG9vayBhdCBudW1hX3Byb21vdGlvbl9hZGp1c3RfdGhyZXNob2xkKCkuICBXaGljaCBtYXkgaGF2
ZSBsYXJnZXINCj4+PiBpbmZsdWVuY2Ugb24gcGVyZm9ybWFuY2UuDQo+Pj4NCj4+PiBBZnRlciBj
aGVja2luZyB0aGUgdGhyZXNob2xkIGFkanVzdG1lbnQgY29kZSwgSSB0aGluayB0aGUgY2hhbmdl
cyBpbg0KPj4+IHRoaXMgcGF0Y2ggbWF5IGNvbmZ1c2UgdGhyZXNob2xkIGFkanVzdG1lbnQuDQo+
Pg0KPj4NCj4+IEluZGVlZCwgSSBtaXN1bmRlcnN0b29kIHRoZSBjb21tZW50IGluIHRoZSBwcmV2
aW91cyBjb2RlOg0KPj4gLyogd29ya2xvYWQgY2hhbmdlZCwgcmVzZXQgaG90IHRocmVzaG9sZCAq
Ly4NCj4+DQo+PiBPcmlnaW5hbGx5LCB0aGlzIGxvZ2ljIG9ubHkgcmVzZXQgdGhlIHRocmVzaG9s
ZCBmb3IgdGhlIGN1cnJlbnQgaW50ZXJ2YWwuDQo+PiBGb3IgdGhlIG5leHQgY3ljbGUgKDYwIHNl
Y29uZHMgYnkgZGVmYXVsdCksIHRoZSB0aHJlc2hvbGQgaXMNCj4+IHJlLWV2YWx1YXRlZCBiYXNl
ZCBvbiB0aGUgaGlzdG9yaWNhbCBQR1BST01PVEVfQ0FORElEQVRFIGNvdW50cy4NCj4+IFRoZXJl
Zm9yZSwgdGhlIGN1cnJlbnQgY2hhbmdlIG1heSBhZmZlY3QgdGhyZXNob2xkIGFkanVzdG1lbnQg
aW4gc3Vic2VxdWVudCBjeWNsZXMuDQo+Pg0KPj4NCj4+IERvIHlvdSB0aGluayB0aGVyZSdzIHN0
aWxsIGEgY2FzZSB0byBwdXNoIGZvciB0aGlzIHBhdGNoPw0KPj4NCj4+IEZvciBleGFtcGxlLCBi
eSBjb2xsZWN0aW5nIG1vcmUgZGF0YSB3aXRoIGxvbmdlciBwbWJlbmNoIHJ1bnMgKG92ZXIgdHdv
IHRocmVzaG9sZCBjeWNsZXMpLA0KPj4gb3IgZXhwbGljaXRseSBjb21wZW5zYXRpbmcgbmJwX3Js
X25yX2NhbmQgYW5kIG5icF90aF9ucl9jYW5kIHRvIG1haW50YWluIGV4aXN0aW5nDQo+PiBiZWhh
dmlvciBmb3IgYm90aCB0aGUgcmF0ZSBsaW1pdCBhbmQgdGhyZXNob2xkIGxvZ2ljPyBzb21ldGhp
bmcgbGlrZToNCj4+DQo+PiBpZiAocGdkYXRfZnJlZV9zcGFjZV9lbm91Z2gocGdkYXQpKSB7DQo+
PiAgICAgICAvKiB3b3JrbG9hZCBjaGFuZ2VkLCByZXNldCBob3QgdGhyZXNob2xkICovDQo+PiAg
ICAgICBwZ2RhdC0+bmJwX3RocmVzaG9sZCA9IDA7DQo+PiAgICAgICANCj4+ICAgICAgIG1vZF9u
b2RlX3BhZ2Vfc3RhdGUocGdkYXQsIFBHUFJPTU9URV9DQU5ESURBVEUsIG5yKTsNCj4+ICAgICAg
IC8vIGNvbXBlbnNhdGlvbiBmb3IgcmF0ZSBsaW1pdCBhbmQgdGhyZXNob2xkDQo+PiAgICAgICBw
Z2RhdC0+bmJwX3JsX25yX2NhbmQgKz0gbnI7DQo+PiAgICAgICBwZ2RhdC0+bmJwX3RoX25yX2Nh
bmQgKz0gbnI7DQo+PiAgICAgICANCj4+ICAgICAgIHJldHVybiB0cnVlOw0KPj4gfQ0KPiANCj4g
SSBkb24ndCB0aGluayB0aGF0IGl0J3MgbmVjZXNzYXJ5IHRvIG1ha2UgdGhlIGFsZ29yaXRobSBo
YXJkZXIgdG8gYmUNCj4gdW5kZXJzdG9vZC4NCg0KQWxsIHJpZ2h0LA0KDQo+IA0KPiBJZiB5b3Ug
dGhpbmsgdGhhdCB0aGUgb3JpZ2luYWwgc3RhdCByZWFsbHkgbWFrZXMgcGVvcGxlIGNvbmZ1c2lu
ZywgSQ0KPiBndWVzcyB0aGF0IHdlIGNhbiBhZGQgYSBuZXcgc3RhdCAoc2F5IFBHUFJPTU9URV9D
QU5ESURBVEVfT1RIRVIpLg0KDQpBY3R1YWxseSwgSSBwZXJzb25hbGx5IGRvbid0IGxpa2UgdG8g
aW50cm9kdWNlIGEgbmV3IHN0YXQgZm9yIHRoaXMgY2FzZS4NCkFueXdheSwgd2Ugd2lsbCBmdXJ0
aGVyIGRpc2N1c3MgdGhpcyBhcHByb2FjaCBpbnRlcm5hbGx5IGZpcnN0Lg0KDQpUaGFuayB5b3Ug
IQ0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IA0KPiAtLS0NCj4gQmVzdCBSZWdhcmRzLA0KPiBI
dWFuZywgWWluZw==

