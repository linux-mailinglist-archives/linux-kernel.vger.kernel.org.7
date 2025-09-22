Return-Path: <linux-kernel+bounces-827771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE73B92BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964ED2A4CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DE31A57F;
	Mon, 22 Sep 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYlRxL0N"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AF1E32CF;
	Mon, 22 Sep 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758568259; cv=fail; b=iy1O8/AR1xbygV7JX0LNSXZOSzi2ZxqtSOzcapW64BOG878S0j1Jex4LkuP6zpsKfaXHZ7W0HOdtLO4gh5+HWBLzOdiKc2yzijE5147iTp1iufpYMjV7lBuc4xTJEaHKQCboS9oNqGRkSU5zlWHmm3BewRr8JB78PqQ9c0uqBFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758568259; c=relaxed/simple;
	bh=ThJrZL/r09pYyHNf59iC9BV2wxfBog2+LDi3a0PvqkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MoSvqz2Ajwstw2a8RMoXUM9hxpgi3QwYT2xCM1HFRPEaL/cL405aeUxOP8hPQQu0IIQZNUC9wWhxLMloD8VJibtMKnkXhxphbzkz6DM9Kz3SUuBsghWlzyxdu6uviPop4J8RSijoDv+7XScS7wMIeb0yW7xnmVTZxL3R4wpRUCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PYlRxL0N; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP7o6Du0XV3HXHPjlxpGgwehpcvoRXpze0dug/B7wNJygrevxABLXbH2W8jgXP5/b9MtIszi157UO6vv/pUWN7hJ3oLGS9FL/c09oI4lrP8YpHEnKQ0h/JX4keGBYxzTsyIQxUx7coiDW/zUOmBPhrm+y4wwrm4ZZUh/mXZ9vDBSMFuZRkGLuwF+UgsouDAncnoUSAZh9sQVBZEA+N4/116sKlUztGpas9l/QoIeWZqiu5jqLwzly0kRo+1gombnBmTwhxPylfcGRjOgt1vyR9MYpYV1tNjuwkK0xmvRohV1Z0aS+qSVVIb7cGti3J8ey3lKdZE9QxpqlXb3lZrbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThJrZL/r09pYyHNf59iC9BV2wxfBog2+LDi3a0PvqkM=;
 b=srEf/G5BKAso2HOkJgbrU5QupOllDzmxEvLNBoVOGDjufBBuZVJKqYR8R35uOUQtCc4TVXMvbcdYqyr9T+sh1szRAmEVwPycnMqEJZeDjttDbBIG8wAisjC7a1HMI4J6gTJSu4bj0MrhKJtIOmrbZ+5ZezlUfK//vsxYYXalv77RLiRRf5LVpCua2AiXWCjnjl0LM2eMnVxqtbPEpdNSSFbFaAMP2hep16mfs4tPBC5ojK4how92MccvjtfQg2inRLF1I8Lgc6U9lX8hhbuiaH+v0Cl4a1BqVvb/yCtA0BWmooEgjKzLrcS1bDSsa6qaItLgJjRE8vlbhkUbkcZkVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThJrZL/r09pYyHNf59iC9BV2wxfBog2+LDi3a0PvqkM=;
 b=PYlRxL0NmBc3Sw5nkdlNXsy7RcwJc0Hci96uJlD+xm3i3KBzBTD46XtZFan12YuVh0AzlpKuXKjXOISaj49zkzaf2MVBDp7dciDcd+PDGIafsIMEsu+GHmoo0S8Mip4ap8cZDbSnmS2bD6ZbJ2C4ZI3T7oamEgrX7rsn4pC+tnE08QaZ/rhnyb6mDhiKnPSnMJaqhd/D7fmR018aZzPpHgY09rQa+wB+LfiNrB0f3yrR8hhoEZI1qmFNEVxCNb2jPohAmdF1oQJdcH9LfgiE3lQrRzGfS58Fma17UBkOKd/lBCVeKg0m7Z5oYeMeRarESYqfbJJYn1JRaM7jrdeYPw==
Received: from CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Mon, 22 Sep
 2025 19:10:53 +0000
Received: from CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056]) by CY5PR12MB6526.namprd12.prod.outlook.com
 ([fe80::d620:1806:4b87:6056%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 19:10:53 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Alistair Popple <apopple@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
CC: "lossin@kernel.org" <lossin@kernel.org>, "ojeda@kernel.org"
	<ojeda@kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Hubbard
	<jhubbard@nvidia.com>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"aliceryhl@google.com" <aliceryhl@google.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>
Subject: Re: [PATCH v2 07/10] gpu: nova-core: gsp: Create RM registry and
 sysinfo commands
Thread-Topic: [PATCH v2 07/10] gpu: nova-core: gsp: Create RM registry and
 sysinfo commands
Thread-Index: AQHcK7RsIIrl+YrTDEmIrany5za9zrSfkdEA
Date: Mon, 22 Sep 2025 19:10:52 +0000
Message-ID: <d87bff0c64fb2a549920354c8b09f764e145a492.camel@nvidia.com>
References: <20250922113026.3083103-1-apopple@nvidia.com>
	 <20250922113026.3083103-8-apopple@nvidia.com>
In-Reply-To: <20250922113026.3083103-8-apopple@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6526:EE_|PH7PR12MB7426:EE_
x-ms-office365-filtering-correlation-id: a4f82c77-34c3-4687-dd27-08ddfa0bc003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmxRcjRER1I5Vkx1blJDRVVxbWlLdkVFKzcyL3hHalJQZWZYcUFTblhEWVFM?=
 =?utf-8?B?N3V4WWUySHpjUVFueUpqTWhxbEZQWmFPZUhKMTdRYmFRWVgwZ0N3Zko1aW5m?=
 =?utf-8?B?SFNSQVF5RytnVy9UUXZlWmdKWmNpTlc2TDMxdnNBaGtGMURybTh1N2drRC9l?=
 =?utf-8?B?MmRHYjJMeEtJbTNRSUtjVFhIYlMzYm9sUTFXQVpFN2MwWk0vL2N0Q21MUkZS?=
 =?utf-8?B?M0I2a0xpOGZWc0JIejhTWGNEUVluZit6YW9hZ2dXNU04WkJSWmRtRjRuZ0hk?=
 =?utf-8?B?VjAxSkRraTZwajNUY2g2TzIxMHlsdTRpZEJZL2tJQWVJRkpxTnBVNFFmc2Zw?=
 =?utf-8?B?eDZlS2Zha1ZvZTV0aEhvaDhna0VwY3UvTVRKL0tzbXJpQjdIdlhLaytNY1gr?=
 =?utf-8?B?QnhTMVkxL3VrOW9SM1JJS3BLMWtpcGRYQWhGTGEwSTV6T1N2dys3SVVHVEgz?=
 =?utf-8?B?TnQ0d1ZtaWt6aCtaWGdCU29Hb0VibTltcWtwSUVLYU4wbmhVUytNbXRWRTJV?=
 =?utf-8?B?aFQ2Z01oKzdIYS9Za3R6VU5zcGdwUHZwQU9YUXNDNDJlRytTODhQOTZtTmF0?=
 =?utf-8?B?TE9aZmk2MWVDenhPQWpwRHJsQWsrRVpYVHlmdnV6b0JuTHZMUmorMngyYlls?=
 =?utf-8?B?WnROMEZhNFhnajk5MGlYWGpYQ092bFpiTm84STYrSDFIS084cXBBUW1iTkhu?=
 =?utf-8?B?Sm53U2NSSlVycmNLQWdkS21rQWFmcVRBVUZGWGJERDBJQ01TbDM2dkZPbmFr?=
 =?utf-8?B?M3FDeVM4RjJTano2azgvckZLYWJGTGhjYkJqcWxCT3FmTXJ5RmY2NzZFQUpm?=
 =?utf-8?B?WEF1OEFtTDd1VnY4a3ZiL0V3QWRCMGNUc3R5dGRuUU1MejdUS2dYN2MzdlFn?=
 =?utf-8?B?T0w2dVRDM0pXWlVCK054K2hJN2J6MGV6SHQzMkt4TkhZYTJzMlYydDRjcFRF?=
 =?utf-8?B?elZaS0dNUGdacGNwOU1GbjlXOWJUR09XUXB5cWNxNHBaRXUrcmFHbmhmc0xk?=
 =?utf-8?B?MFBXdnZ3amQ2bEdZbHFtenlmaTYwYjlaZFFsWkZka21paVN0VTNhZVQ2T2x4?=
 =?utf-8?B?SGE3Q2hBOVl3RVZabEl5UU5qRC9qZlZLY2JQeVcyemhWS0piZ29ZejRDWUZE?=
 =?utf-8?B?MFA0YU1BRzAvQUNNaUVOTW1CVTg5ZDBsUW5wS0Y0bnN1a3RJdzdzT283cmQx?=
 =?utf-8?B?VVh6ZEpLdlo5UnJTMDkzT3cySjkvOS90clc2SVFBTDJTWGRLeWxqTXBjZE9N?=
 =?utf-8?B?Z2ZuUTVONER5T2grZTdtL1lWcDlOcWxxUHhoM1Z6d3hzUVlTbklySmoyejI5?=
 =?utf-8?B?WVpnUzdMcEd3b0NyaHJXRkh5UjlFb0dpekUyeXRqa1lscGZJRHd3SXQ1ZE9Z?=
 =?utf-8?B?SlBjLzZBMUJsUXN2L2phcTNzUEpjWVlERHExUXgrL29vZjNtUzdoZTZUUmI0?=
 =?utf-8?B?QS8zRVFUSEE3diszTmg4WjU4OHBBNDRhL0tBcXpia2kyYjA3WVp1eVdBTmJC?=
 =?utf-8?B?d01LT0JPWjVsL05xVVQ5SXIrTVhPY3BySHZWcFhtRjFrcjZFQ2hHakliNmpR?=
 =?utf-8?B?L3JWbG9KQ1A2OWJlc2JBbXpZN1ZkbFRiSzA2TmpUZkRkNU5NdEtlSmVuOE9H?=
 =?utf-8?B?emRvM1hDOWszTDkwQ1VEYU5GQXpYL29ScSs4L2NucWFyL0h4UENDQ0RHeFk5?=
 =?utf-8?B?Nzl1cXBZSTB1dk93d1pnSTJQTmJJd05VYmtNNTdkWEkwS25wQmJxMkRXczZp?=
 =?utf-8?B?TDFMUFloZXJrUmRydnZ3WExnZnh6dUFOZ2NKSDdaWFpQbFY0cXhjV2R1MTZl?=
 =?utf-8?B?Rmc1Tnhpek5iSHZLMmFlaVFselJvZjhXWC9EamIwYjdYeTd5QkhlVFJjb1Bj?=
 =?utf-8?B?bk9ic1JrdFdYTFhVcERaT0I1dEM1Ny9aMGxycHhPSzJUdkpnL1BZUm9VQjJv?=
 =?utf-8?B?ZHArL0tkRG1CR0p2WnVYRDkvRFNzdnJCalNLUnVjb25XOTN4SXNTYXkxOHhm?=
 =?utf-8?Q?xQcC4HYkGJjiCIavAyy7kMEZiBqXv4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6526.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFFFL0FaejgxOGtnb2R4Q1lBeXpXUjZsRHFaSTdBYWY4cE9VLzJBc2RRMUJs?=
 =?utf-8?B?MW9pNHRqdGltRDh3MzJqUW1pc1cxRTRxY0dzZyt3cG5ncTUwYSsvWFl1WmtC?=
 =?utf-8?B?aXRyUzJLc2R2MDl5OTFoTWdDR1AyNmdjSnViZzNhRDRrSnhIZXpvam45OG9u?=
 =?utf-8?B?R2w3Tnk5eC80RWZtWnl1U1ZOQjZOSXRhRVB0V2xQaUhKTzVRN1VmZW5QSldI?=
 =?utf-8?B?bFd6dkFzc1VWTWpvalY3dSszKzhFVVlmRHd1aDZvT2REK3hYdnJBR25UUWRH?=
 =?utf-8?B?MkF4V1BjRzE5K0o1NlJSbldHRDc3M2JJeSsvZ1I2QTVwM0ZXUXdYQ2U5aU5k?=
 =?utf-8?B?Z1lzTW1SQXdRei9xNDI1Vzd5eldicFhmNnVWMmxLNG5FRFlCdWRKQjNnOXpO?=
 =?utf-8?B?WVVrK0toMG10UjhXc3pUU0lxbHB2WWhrMFp3QzJ0RWFreTBkaUdUeXBtU1Zh?=
 =?utf-8?B?QXJ0dFVOSU54L0hXbDVwUVQzSmR3NHlPWjB1dmFPMkk2YllvbGtBZlhHaGk2?=
 =?utf-8?B?OHlIOXdWY1Fob2JVV1FUUXRBOG0zeGovandTeWVFUEFPbll2by9wTVFTbjlH?=
 =?utf-8?B?TXZqMUFQelArSWg3eGlUR2NMRnIzRktwVlRNbUU0V0doNFJSeVpKVmJhKzEz?=
 =?utf-8?B?VUJkaTZYeTJDOWJvSzllczU2bTZtTUxEKzFYbThHZWtDZ2JkMk9ram9QMm8x?=
 =?utf-8?B?cEpneW5jUWpya3JuSkZ5azcvamtsU2FMb01ZY05HdmRtRjY3dU16K0lESmN1?=
 =?utf-8?B?YVdBVTNZdm9WSEpud1ZFbnhsSnhqVG1xSHU3WHlZZyt6b29BMkFOOWVLQVE2?=
 =?utf-8?B?c1BpRk9LYTBDbjd3YjQzTVpIZEVSUlFVS1BrZHJKOEdZNlgrK2NCNUtWUG5R?=
 =?utf-8?B?VEpuYitJdGZrSkZLRTJHcEhJQVQ3Tzg2dmRyOVZTQ3l6OHBDUnd1WDhiMGkv?=
 =?utf-8?B?NzRDM0VaWXBtRFIrWEgvc2pKK0dPMGMxekdqc2dkTU9nM2NsRkMvSzBsTGRk?=
 =?utf-8?B?dHduNTZiTlMxL3B5Zy9aWWUxVW5wMlRxUWlUTlFMS1A4cjczSTZPQjhWZ1Rl?=
 =?utf-8?B?Zi9MQVNlcmVHK2Z0WkR1dXhmcmxieGFIVE1MeUNwc3Q5TWNkNUM0Y0lGYkd6?=
 =?utf-8?B?TlF0V1BkRk1ZMm91WHB5aFlXWXpuNUFFN1Y0bnZGSzFLVE85QTZhN1NGQ0Ju?=
 =?utf-8?B?MTROM2ViUVZ3enJ5cmd5VHhuT0NST2JKNEloYXV2Nk5RY3VSamdlLzg4bnJt?=
 =?utf-8?B?bkdQWFp6dDBybmRFV1ZLY3I4cVluTDlKMkhsTFZXSkp6RVdjTnJLY0NxbHBO?=
 =?utf-8?B?UzBybEVRR2hRNVludXU5R0FqUmZhalpUR2ZkRmN2RnZkQnlVZld6SUEvV2Jq?=
 =?utf-8?B?dllBQjRIOFN1WGNBcVV5cDh0RU9BK1liUGRzOWdZTS8wTXYyMURZK2YwU0JM?=
 =?utf-8?B?cFJ5VDVMRnpoYUdJNVoydVdFb0hRcWROWVNTaC90T0ZFTGdhdXl1OVJrZisw?=
 =?utf-8?B?YnlIU0lrN01CNkZWb1NnZEZoZmJXQnpCUGgrck1PemZUV0lUN2JDdWdTdEJp?=
 =?utf-8?B?NHFURFdPSjE4QkJkSzlRRDEydjVPUksxRi9qN0RsaTIrdVBjU3N5b0FUcHdp?=
 =?utf-8?B?YWM0SnlEanBiMWQ3d2R4MTBJV3J2RTNSa2Uvd2hLNWZKR0h1U3FhUGgvbDJW?=
 =?utf-8?B?SmRzVkNoTVhsRUZ3OTNKdVVwZzdRWStOUDhKdnpLVVF6blM1TkRmU0l2ckZr?=
 =?utf-8?B?akV1WXEzSWxISnBZVnVXYzU4dHdPbm9sSU8xL3lkaHZZaFQxM1lFMm5UU0Nz?=
 =?utf-8?B?d2xMYXNlOFF3d25LTEFQa0U4a1NKN2QyMnhHOGVoQ0NOcG1Pd1RjWVRxVGRV?=
 =?utf-8?B?VURzeXRqOVJQaFM4SGpPdEZCeEpaNkZHYkJXZGd2WWFrT0IxclA3Yitqako0?=
 =?utf-8?B?WWZjdUNqaE50RHRnZzhhTDVKRjVmZjdSVldPS3U2K0hPS3YrWVQxMmNZQUZW?=
 =?utf-8?B?b2VvT0Z1OTVQSG5FSXg5d042dEZJN2N0UjNlYmJVcWdRYVJJVHM5T1ZyLzc2?=
 =?utf-8?B?cEQrUE15SzA2L1VSSnZjYkVRYzh5MU9OQ3VzNjhvUVBZOUI4dlBoMGtZMk1q?=
 =?utf-8?Q?6/egLpJ01JcWKPoJ5GTqf38jc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69A11DF411AA7F43AC2F879624681B9D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6526.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f82c77-34c3-4687-dd27-08ddfa0bc003
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 19:10:52.9422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3p44Be+aiXYJjPaggergE3J5bs06XHNNqFu1zGaFBBJRZWIOFFlo1WE8wrbPkdEC7+8+oBcV8qMk4y6ae4l90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426

T24gTW9uLCAyMDI1LTA5LTIyIGF0IDIxOjMwICsxMDAwLCBBbGlzdGFpciBQb3BwbGUgd3JvdGU6
CgoKPiArY29uc3QgR1NQX1JFR0lTVFJZX05VTV9FTlRSSUVTOiB1c2l6ZSA9IDI7Cj4gK3N0cnVj
dCBSZWdpc3RyeUVudHJ5IHsKPiArICAgIGtleTogJidzdGF0aWMgc3RyLAo+ICsgICAgdmFsdWU6
IHUzMiwKPiArfQoKUHJvYmFibHkgc2hvdWxkIGFkZCBhIGNvbW1lbnQgc2F5aW5nIHRoYXQgYWx0
aG91Z2ggR1NQLVJNIHRlY2huaWNhbGx5IHN1cHBvcnRzIHN0cmluZ3MgYXMgdmFsdWVzLCB3ZQpk
b24ndCBpbnRlbmQgdG8gdXNlIHRoYXQgZmVhdHVyZS4gIFlvdSBqdXN0IGhhdmUgUkVHSVNUUllf
VEFCTEVfRU5UUllfVFlQRV9EV09SRCBkZWZpbmVkIHdpdGhvdXQgYW55CmV4cGxhbmF0aW9uIHRo
YXQgdGhlcmUgYXJlIG90aGVyIGVudHJ5IHR5cGVzLiAgCgpNYXliZSBSRUdJU1RSWV9UQUJMRV9F
TlRSWV9UWVBFX0RXT1JEIHNob3VsZCBiZSBhbiBlbnVtIGluc3RlYWQgb2YgYSBjb25zdC4KCj4g
K3B1YihjcmF0ZSkgZm4gYnVpbGRfcmVnaXN0cnkoY21kcTogJm11dCBHc3BDbWRxLCBiYXI6ICZC
YXIwKSAtPiBSZXN1bHQgewo+ICvCoMKgwqAgbGV0IHJlZ2lzdHJ5ID0gUmVnaXN0cnlUYWJsZSB7
Cj4gK8KgwqDCoMKgwqDCoMKgIGVudHJpZXM6IFsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBS
ZWdpc3RyeUVudHJ5IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtleTogIlJN
U2VjQnVzUmVzZXRFbmFibGUiLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFs
dWU6IDEsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBSZWdpc3RyeUVudHJ5IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtl
eTogIlJNRm9yY2VQY2llQ29uZmlnU2F2ZSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2YWx1ZTogMSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9LAo+ICvCoMKgwqDCoMKg
wqDCoCBdLAo+ICvCoMKgwqAgfTsKCllvdSBtaWdodCB3YW50IHRvIGFkZCBhbm90aGVyIGZpZWxk
IHRvIFJlZ2lzdHJ5RW50cnkgdGhhdCBhZGRzIGRvY3VtZW50YXRpb24gZm9yIGVhY2ggb2YgdGhl
c2UKZmlsZXM/ICBOb3V2ZWF1IGRvY3VtZW50cyB0aGVtIGFzIGNvbW1lbnRzLgoKQWxzbywgeW91
J3JlIG1pc3NpbmcgUk1EZXZpZENoZWNrSWdub3JlLiAgU2VlCmh0dHBzOi8vbG9yZS1rZXJuZWwu
Z251d2VlYi5vcmcvbm91dmVhdS9jMzRjY2MyMy01NTUwLTRmMjYtYWY2Ni00Nzk3OWFmZDE5N2VA
a2VybmVsLm9yZy9ULwo=

