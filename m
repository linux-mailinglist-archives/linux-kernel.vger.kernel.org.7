Return-Path: <linux-kernel+bounces-753646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DDB185E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9AE173EA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C591A23A0;
	Fri,  1 Aug 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b="E6MJ8S+6"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023095.outbound.protection.outlook.com [40.107.162.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1523AD;
	Fri,  1 Aug 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066427; cv=fail; b=Vvbj7Pn+qyYADalew4Y5UoW5kHnzmH96HGBZHeo+ir4Slf1nQrHxZo1+eonZn8usO9Mmgd73nkO6XxUybnkaejSlwcOUAbm3WZ+wUSCN2mejo0uJD2hTw9L7L0+964oaUyEZUG7vAV6MrBdeqezfAeWNR154UxSOMXzr1o8159U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066427; c=relaxed/simple;
	bh=G9Bv7d5F+cZvW6UiXV5kfe8n5+PScH/FYohgn7iPPIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RHdbftUaccF+Ssdo2zDSdSxqRD5KB7dv69WHHgx8g6PejaVceA0F3AT6Lj+M8e4JPDap80C/9cWExJnCGogX9jGb+aECqUUIv/LjA4X3bJIz+4TujJVbnyzA4k12sZVM30p2uAwXOolmRbNnGnkLsrTr8IB2kL3m4caQF3AIOeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com; spf=pass smtp.mailfrom=htecgroup.com; dkim=pass (2048-bit key) header.d=htecgroup.com header.i=@htecgroup.com header.b=E6MJ8S+6; arc=fail smtp.client-ip=40.107.162.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clO2JBBWW8sI3YoMr10Lnpk9iXFz7gNlZIwYIUp0G8JLnO2xOcp02AbcI20Z6RwuIVGCEFHueBXxYuYcq9sx3o/bO++O5tNycuv7MPj3nHyB8LTpn+B+zBhuphSFb5oZcQeF3GS8YOi0T2ey9GmjYpz36HATYKhSgQHOXHjOz7awkmL+e2/pHb3x4Y0jEAS7/BUghu+ccIaGd3O/WMOSdrv3w+CVM0CSJUEhzBuqomCC6YICprS1KzIOxCqC++K7s+R77GRUlmGau52oUSMz5cUDzJJ5GGr1o+tn9axR8Skvqq+5B24Q1gkOx8OYSPjaVHwdLrsDnrZtq8hGyyz5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Bv7d5F+cZvW6UiXV5kfe8n5+PScH/FYohgn7iPPIY=;
 b=oP1KWOQG6WRnn/+CB8AaECIM3SVkK9vjOy56uw4hv4FNmib9/nsGzfLvdHglsz2iRdYfJcjHM6JDd2gS0XVYJE5cX+JeA45HqFrRwt8No/KkT7XTwe3nZTNIKWvCNANZrZD1n6dFnlFiU1HRx7eUC9IdnnJYq5UgJmMAwLbfRLFhChAYByR9IF3L7EFAHMnlfX9ukU1UqDE9yCMIHcptoQBv3WNi9oIPVsRZTjG00oIUXQmJLOksl5aNqkIl1JwySVCyFgqXHjRkWbmK9JMCpANrMn88IqjbIj4FDkxyYBiRuWPSV8cEV67d5fMcGTfrVQF6xwNHsbf73OsXoWBXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Bv7d5F+cZvW6UiXV5kfe8n5+PScH/FYohgn7iPPIY=;
 b=E6MJ8S+6g47uJq756mjR+oioC2lNRImlixC2M+IkgSMRlfEESWGcVF2xxhyKQv6KtjZyMCHo9lga2QNDfAwKMMsDZsvJWed0MpHeau91gKeJcct6JNl4w5Z4UUDEw/NFLlVFfvBQ6GV3lOSCS7R/W+TEGr13CQ0AYEcoR7Jojt4VX87yz5pVwT2+WegDg3iRdTagiB4oMS2b5H9iR7KjJMYwlRK7CYD+dKR8k2fkBjBNC7MztVYQkGCB2F+UX2FulnAc4cS0oMqvqr2wtkTQibwLlaoR7+m2YfncHhcmwaYuQDvS2j2jQythrl4QvZn+U8as5K5uVQHEFk6zzNgFKw==
Received: from DB8PR09MB3260.eurprd09.prod.outlook.com (2603:10a6:10:105::13)
 by VI2PR09MB7587.eurprd09.prod.outlook.com (2603:10a6:800:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Fri, 1 Aug
 2025 16:40:20 +0000
Received: from DB8PR09MB3260.eurprd09.prod.outlook.com
 ([fe80::cad0:cb5b:959d:f7f]) by DB8PR09MB3260.eurprd09.prod.outlook.com
 ([fe80::cad0:cb5b:959d:f7f%5]) with mapi id 15.20.8964.025; Fri, 1 Aug 2025
 16:40:20 +0000
From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
To: "alex@ghiti.fr" <alex@ghiti.fr>
CC: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, "alexghiti@rivosinc.com"
	<alexghiti@rivosinc.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"arikalo@gmail.com" <arikalo@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "conor@kernel.org" <conor@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Djordje Todorovic
	<Djordje.Todorovic@htecgroup.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "palmer@sifive.com"
	<palmer@sifive.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"robh@kernel.org" <robh@kernel.org>, "rvishwanathan@mips.com"
	<rvishwanathan@mips.com>
Subject: Re: [PATCH v5 0/7] riscv: Add support for xmipsexectl
Thread-Topic: [PATCH v5 0/7] riscv: Add support for xmipsexectl
Thread-Index: AQHb/K7tkDwiiq5leEWJO9Opl35sf7RMRvSAgAHFmIA=
Date: Fri, 1 Aug 2025 16:40:20 +0000
Message-ID: <5b200571-7a91-4e01-95c9-dc50ebc40d58@htecgroup.com>
References: <cf49b59f-d39c-4757-a453-6d3c8a09d1ce@ghiti.fr>
In-Reply-To: <cf49b59f-d39c-4757-a453-6d3c8a09d1ce@ghiti.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB3260:EE_|VI2PR09MB7587:EE_
x-ms-office365-filtering-correlation-id: 1bb837fa-100a-4550-e4f8-08ddd11a1aa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0MvaWlTNFNGd1NoTUlQWUd3RUhJU2VqWm9WTjdRMU9rcjdtOHIzb0Zmc0ti?=
 =?utf-8?B?ZWp4Z0pGb0tNSGlBZStCMlZDeUdoazJKWlYzTEhPd1RTMk1TYzFWd0hVd1Rp?=
 =?utf-8?B?blovd0VTYytkNlYyZnBvREZqZzlXYnBrMVBmWEVrdGl4WWdlOThXbmtDbDNu?=
 =?utf-8?B?WEFFaUxPeFNxREd3Q3BDQ1lPRG5RYm55TXRObFF3VVN5M2ZWdVNOYy9WcDly?=
 =?utf-8?B?RmQvVXd2dG9xZGdqZlRtTThpZnArNzJaMG41WThLSDluQzMzWjZZRFlUaUhC?=
 =?utf-8?B?bnMrTk5vb0I1Rkt3RzBQRXJhcmhIemRkNHZKcU1sSUlWMXBqdWU1bWdlazNH?=
 =?utf-8?B?UVlLNjViR1pZNnBITDFpaVBqa1ZpWG91bkRwdHQ1L1FRRDk1RlpBSlNTY3hW?=
 =?utf-8?B?RitEUXVLay9yV3hPZ1NJdWJxMS9qa1BIaDNnRkMwMEpMdGVrNHZ3VFdlSHdD?=
 =?utf-8?B?d2FPRzUydHZSeTJQY05QaTJXdm51eXZZVWx3MCtzNWg3Y2dBZ3JXdTY4RUxT?=
 =?utf-8?B?OGYwRy9ZelJwOXpIQ0NWUTQrVXpETGwwSG5zd2MwczY0b3BjWnJVb2NXZ000?=
 =?utf-8?B?ckx6UEUwTUJ3MUc5TTBhRUdLeGtIUVNiY0h5VXZzcU4yZ21KMzl5SC9JaVNw?=
 =?utf-8?B?YWZ6YzVydk1PWFg2WmI3Q1UxRWVXU1BDWURMN0xZYm9BVmNzeExBM0dvL0Yr?=
 =?utf-8?B?QnRJa1FhdFdwT2pzTkJXOG81RUVaaWpQc1RNaGNZNzFjbjh1cWU5VkJUWklt?=
 =?utf-8?B?eFRaUE1kMW5XN29KaTliZnorekZZVlZIZGhVWU5xZWRISlByd2lzZlFQQW1k?=
 =?utf-8?B?ck1KREJxNk9haU9oWHJxazQ0NFlxYzZkKzhHZ0tkYjgxeFZaRkFvWC9sc3RG?=
 =?utf-8?B?NkJHaVJPV1Zmb3RuN3R2RkQ1VXNrWFZFRVNCWXNnZWJOeUovNHdmL1FTaGxq?=
 =?utf-8?B?TjB2ellHK2h6c1hzRnRrcUlpK3U3c0xCWVZDZjMwS2NhVDdrL3V2T2p1aEpH?=
 =?utf-8?B?c1hmNEF0enlPUENCRlpIaXRPdDRxUkU4RmQ0Z0ZMeGZibXR5ejVsaVVDNlpy?=
 =?utf-8?B?eVJHZXZuTXJVR0ZlMTFZWDVFUFpYWlZESC81YXdlUkFyYy9qcFJNZ2FVckFz?=
 =?utf-8?B?Vy9GRC9xMVFWOWNBTjdPbUJNTXZZUklOTzJhaEJPWGZ2ejBrQWhtWkpvd056?=
 =?utf-8?B?RFpLeUFid3R2c1JtanJjUC9wTkg3M1VXUnlHbkJub29hZGNuN0o3Wk9janNh?=
 =?utf-8?B?enJnTTZiVHVvQzRVeDd0eVJZalJWUFoxN3ZqTW4yOWdRd2MwT3c4QU5Mcm5W?=
 =?utf-8?B?ekVmOEZETjhnVTVtaU5zNktRT1Y0aXduNmp1bzZRZVJXMzJhOFlGTWFVRmtL?=
 =?utf-8?B?RHA3enlhYkRTaE54cWRGYmRSK3czTXRySno3WEJ6K0cwYVVuYjNhNm5nUUdW?=
 =?utf-8?B?YnZqc1dYUlF4ZG1FN0hrbnpBTjhHUDVZRVBzMGZGR1MrT3lCOGRwaTkwM0h4?=
 =?utf-8?B?ZXV3aUp4dWZxcVJGTkFSbTJuMjB1cTZiNnh5TTQvZGRNVTl5WW5wNkEzUVI0?=
 =?utf-8?B?Y2VpM3N3K3VGcTdRVWcrWmdmWkFBR24wZmQ5WUVsNjFWRUw5RWttL3YyeGVE?=
 =?utf-8?B?U3FOZk9HTy91VjRpeGNzWllTUlh2RE1ERUUwMFFuZ2pXb0xuOEhsSWhGY2hy?=
 =?utf-8?B?ald0RTQ0MzkwVjVra29Kb045YWdwMHJ3OGloU2wyQWhidEh1V3dGR054NEVs?=
 =?utf-8?B?cjcrUEFCSmVGY3Z4NU53ZVlwWUw4cWFDUVRiWkdvYmpHSGRsYWNBMk1nL0dD?=
 =?utf-8?B?RnlrZUJNQ0M5SkwwU011SG4yc1ZjOHVRV0xNbmR3dW1pT2hDSS9pSnB3MVZY?=
 =?utf-8?B?eiszazl5Q083enZpQnpMTXlxcFFMcGloYVdvQVZXZkk5WGpvSnJjSnVLTGdv?=
 =?utf-8?B?REg3L2UrMU04M0FyLzlJai96Vy9RVXA1cnEzdFlSMjg3Y2xBVVlYbU1CVzV4?=
 =?utf-8?Q?4Zbx7fvtomIUw4GIZDwyVoOrPO3pa0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR09MB3260.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1B2WFBVNG9vTnpIeVlmYnc4NlMxRnE0eHBNSHlKM0cyRmJsc3BrTExUL0Zl?=
 =?utf-8?B?L3BZdFMwRU5nRnRZN2JYeWJuVUs0V0VYV0Nwa05mYlp3eTFaTFlTTytCNlJo?=
 =?utf-8?B?ckRHM3ZiWGxVSlVCWCsxc3ExUDY2TmQyQ0pTQXlMOWI3eGxjelpjb3djRTVP?=
 =?utf-8?B?aXV6UFJlVno0Mk5RY3YxRTlGeFp1MVJpa2JvMFFzeU11SmZDZkF4aGxLbTRN?=
 =?utf-8?B?cmlWZFEyS25TQTFxcStIQXBocmxoK09BV1pWbFM3dktCQjRONjg2YUNtYzFE?=
 =?utf-8?B?QTB2NmNObVdSNURyUHlsT0pmbFozR2tDZXd3RHdVTzFxY0FYejJncFZpdS9U?=
 =?utf-8?B?Qm0rdHE0UlV6VDZxTi91U3FHdmhodTZhVkdLNCtJUHhDVDJtNmFWTDhHVUhJ?=
 =?utf-8?B?MTNuZlFIdy9TTDluYjVvT0xJTlBNUGJ2MHkweDFka0NjZG5VdnVWU0Jwd2ZK?=
 =?utf-8?B?YVFGaFVTdFEzb0FxeDZqcTFmb2pKakx2dDB1enZjNncvNWxONlQ5N0lBcjFX?=
 =?utf-8?B?aU4yZ256L1dzaDloT0o2NTRJT0cxRjBKT2czM096NlU5WjlvNXd5ZFZlaytR?=
 =?utf-8?B?azlsekNBOENmT2NDNitDOGJIQVVMRHVENUZXK0tuZ3pOUGhNeTFDdVpWUndP?=
 =?utf-8?B?QWFCT0V6NXp2TFlFVzJWaUUyRGtlUTFxaU5RRkxxZGRzZjNtSTgzRWI5TzhK?=
 =?utf-8?B?Zzc5a3grR29WcTBOSVZOUUdhajJGVzJ1VDVMQkRmZjkzYnU0NUdsdGFxR1BV?=
 =?utf-8?B?ZjI1MGVJVk90YWlzNm9qNGo1Q2RvcTJ3NkI4MU1FV3MwbXovRStpM2U2SlAy?=
 =?utf-8?B?RDh0K2FQVWlpNkFvRm5sc0VaQUtMcTJnak9zaHVKYjVtVTlmS3QxbGtnNU5J?=
 =?utf-8?B?TzdMYU1iV29WcTBsOW1DcTBUVlVrc3VFY1lNdXBVN2EySkdpN1JGR25ncFVX?=
 =?utf-8?B?UjdtaE1nblVuZnQxQTNyWStCN2pMZ1k3LzNzSXcxaTFqd1hJTHdqSGZRMCtz?=
 =?utf-8?B?ajhzWURqdjhnVHFWb3NtMXNkaGJjZWhSUVlveUUzV0RVaTZROWFiN3pKM0lN?=
 =?utf-8?B?R2pWNEJ2azRWWTJ1c0xOZi80S1FmSXhpRjk4NTllbnl0bzE0RE0yRFhjSEFt?=
 =?utf-8?B?WnZxUFJ4TVVPVC9tRUhCT1NXeUZaRS9qTUxQVHRjc3MzeVZoanhyRWx1cEJv?=
 =?utf-8?B?QTErVHVsRlM4QWxaaWlDK0U3MTNnYWQ4MFNZbHhpSWQvNytQVzdBKzZKbFZX?=
 =?utf-8?B?aHN6TkVaTDhtdk4ySkdXb2dHeXloV1VvaGUvTkd4cDMvVkt4SC8vb3FQY0lZ?=
 =?utf-8?B?YmJDNFdJMm1pQTY4Y3BJSWhDRFlRcHozK3puWWhyVzhoV0dTOWJZTU9CRXIw?=
 =?utf-8?B?bUpKbjdqNDN1bjd1WTVadStJSjRrWVBIQ2ZkNk5VbU1KcG5BWUVWUkE0anhi?=
 =?utf-8?B?Rzg4Nk03Szk1WmtIUUowWjhHYUNheFVVL1pzNVQ4b2ZoakhLSWZycmdzaDVi?=
 =?utf-8?B?Yy84Ym1Wa1JaS0hzSlV0cDBPUm9ucWhvNWJtWW1qckZoREtSeU40aUVIWlJQ?=
 =?utf-8?B?dDhPTXpLMlhPcXJ0Y3dFT1RDZTRGS2V0amp2eWZLWjRYZklLNThpRFg0Y3Nx?=
 =?utf-8?B?L0tKS1laU2t6emJqaW5lbHoyL1ZmbkorM2NRRkFiK1BPbUNvdDBSRi9TTHg1?=
 =?utf-8?B?ckdZbThEVlAyZ2ROU0dvaTNXYUdOMkw2Mk01ZDk0YnpyNnprQ2Y4Ri9ycVJr?=
 =?utf-8?B?UlVmQ3A1Q0dnWHlKMzhBVGt6dUVLbklSbUtOR1h0Wis4T3hrUFJSWmpFdzU0?=
 =?utf-8?B?WXgwWnFDN1FieHd0Nk5qWmlGNEdWMXMxcjh3aVJldEw5NHRWUDJDMkZoTWVH?=
 =?utf-8?B?Z2w1dHZWczk5b09CcXNMQ1oyNW1lL0NDakxoOGdnbjhnd0JXZWlFNVFyYmhi?=
 =?utf-8?B?Q1hEVXdoZDJiZUs3d3U5MC9Pai80MzBPekpHTTIyYXNLTjZVSStOdGtoUkxT?=
 =?utf-8?B?V0gxQU5qTU1Va2FxVWt0QkJqY1dDZlhpYzFkVWJ6MHpxRzBlRUtlMG1ZRGV4?=
 =?utf-8?B?ZHl1OFpCNyswTFpJM2lYTXd4THhLTVNreG5FTk1kbVZ2WW9xbUo4M1ptZS9T?=
 =?utf-8?B?N3BVcVRkd204SG5DYnF6ek52eFJTREtSbTRSazJ5UTBmMk4rUGw4WGhpNlJF?=
 =?utf-8?Q?us2HLAL5XLJzQEwT2YtSavI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3FA59EA58D46D49B4AF19B0C721BF71@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB3260.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb837fa-100a-4550-e4f8-08ddd11a1aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 16:40:20.2694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bE1dmAmFq7b1GVRQ4S5wAzGGhq7BzbU+2aGHoTvXzjG+Shid/j1kr4PehsgKzux8xk3h5PNm0YlkjVPtLAM30mD3rp3o82XlVScg9LZVKEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7587

T24gNy8zMS8yNSAxNTozNiwgQWxleGFuZHJlIEdoaXRpIHdyb3RlOg0KDQo+IEhpIEFsZWtzYSwN
Cj4NCj4gT24gNy8yNC8yNSAxNzoyMywgQWxla3NhIFBhdW5vdmljIHZpYSBCNCBSZWxheSB3cm90
ZToNCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIHhtaXBzZXhlY3Rs
IHZlbmRvciBleHRlbnNpb24uDQo+PiBBIG5ldyBoYXJkd2FyZSBwcm9iZSBrZXkgaGFzIGFsc28g
YmVlbiBhZGRlZCB0byBhbGxvdyB1c2Vyc3BhY2UgdG8gcHJvYmUgZm9yIE1JUFMgdmVuZG9yIGV4
dGVuc2lvbnMuDQo+Pg0KPj4gQWRkaXRpb25hbGx5LCBzaW5jZSB0aGUgc3RhbmRhcmQgWmloaW50
cGF1c2UgUEFVU0UgaW5zdHJ1Y3Rpb24gZW5jb2RpbmcgaXMgbm90IHN1cHBvcnRlZCBvbiBzb21l
IE1JUFMgQ1BVcywNCj4+IGFuIGVycmF0YSB3YXMgaW1wbGVtZW50ZWQgZm9yIHJlcGxhY2luZyB0
aGlzIGluc3RydWN0aW9uIHdpdGggdGhlIHhtaXBzZXhlY3RsIE1JUFMuUEFVU0UgYWx0ZXJuYXRp
dmUgZW5jb2RpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWxla3NhIFBhdW5vdmljIDxhbGVr
c2EucGF1bm92aWNAaHRlY2dyb3VwLmNvbT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2NToNCj4+
IC0gQWRkIE1JUFMuSUhCIGFuZCBNSVBTLkVIQiBpbnN0cnVjdGlvbnMNCj4+IC0gUmViYXNlIG9u
IGFsZXgtZm9yLW5leHQNCj4+IC0gQWRkcmVzcyBvdGhlciBzbWFsbGVyIGNvbW1lbnRzIHBvaW50
ZWQgb3V0IGJ5IEFsZXhhbmRyZQ0KPj4gLSBMaW5rIHRvIHY0OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUwNjI1LXA4NzAwLXBhdXNlLXY0LTAtNmM3ZGQ3Zjg1NzU2QGh0ZWNncm91cC5j
b20NCj4+DQo+PiBUaGlzIGlzIGEgY29udGludWF0aW9uIG9mIGEgcHJldmlvdXMgc2VyaWVzLCB3
aGljaCBkaWQgbm90IGltcGxlbWVudCB0aGUgZnVsbA0KPj4geG1pcHNleGVjdGwgdmVuZG9yIGV4
dGVuc2lvbi4gVGhlIHRpdGxlIHdhcyB1cGRhdGVkIGFjY29yZGluZ2x5Lg0KPj4NCj4+IENoYW5n
ZXMgaW4gdjQ6DQo+PiAtIEFkZCBzdXBwb3J0IGZvciB0aGUgeG1pcHNleGVjdGwgdmVuZG9yIGV4
dGVuc2lvbg0KPj4gLSBSZW1vdmUgdGhlIGlmZGVmL2Vsc2UgZnJvbSBlcnJhdGFfbGlzdC5oDQo+
PiAtIFJlcGxhY2UgdGhlIGlmZGVmL2Vsc2Ugd2l0aCBhIGh3cHJvYmUgY2FsbCBpbiB0aGUgdXNl
cnNwYWNlIGNvZGUuDQo+Pg0KPj4gTGluayB0byB2MzoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXJpc2N2LzIwMjUwMTI5MTMxNzAzLjczMzA5OC0xLWFyaWthbG9AZ21haWwuY29t
Lw0KPj4NCj4+IC0tLQ0KPj4gQWxla3NhIFBhdW5vdmljICg2KToNCj4+IMKgwqDCoMKgwqDCoCBk
dC1iaW5kaW5nczogcmlzY3Y6IEFkZCB4bWlwc2V4ZWN0bCBJU0EgZXh0ZW5zaW9uIGRlc2NyaXB0
aW9uDQo+PiDCoMKgwqDCoMKgwqAgcmlzY3Y6IEFkZCB4bWlwc2V4ZWN0bCBhcyBhIHZlbmRvciBl
eHRlbnNpb24NCj4+IMKgwqDCoMKgwqDCoCByaXNjdjogQWRkIHhtaXBzZXhlY3RsIGluc3RydWN0
aW9ucw0KPj4gwqDCoMKgwqDCoMKgIHJpc2N2OiBod3Byb2JlOiBBZGQgTUlQUyB2ZW5kb3IgZXh0
ZW5zaW9uIHByb2JpbmcNCj4+IMKgwqDCoMKgwqDCoCByaXNjdjogaHdwcm9iZTogRG9jdW1lbnQg
TUlQUyB4bWlwc2V4ZWN0bCB2ZW5kb3IgZXh0ZW5zaW9uDQo+PiDCoMKgwqDCoMKgwqAgcmlzY3Y6
IEFkZCB0b29scyBzdXBwb3J0IGZvciB4bWlwc2V4ZWN0bA0KPj4NCj4+IERqb3JkamUgVG9kb3Jv
dmljICgxKToNCj4+IMKgwqDCoMKgwqDCoCByaXNjdjogZXJyYXRhOiBGaXggdGhlIFBBVVNFIE9w
Y29kZSBmb3IgTUlQUyBQODcwMA0KPj4NCj4+IMKgIERvY3VtZW50YXRpb24vYXJjaC9yaXNjdi9o
d3Byb2JlLnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrDQo+PiDCoCAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9leHRlbnNpb25zLnlhbWzCoMKgwqDCoMKgIHzC
oCA2ICsrDQo+PiDCoCBhcmNoL3Jpc2N2L0tjb25maWcuZXJyYXRhwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMyArKysrKysrKw0KPj4gwqAgYXJj
aC9yaXNjdi9LY29uZmlnLnZlbmRvcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKysNCj4+IMKgIGFyY2gvcmlzY3YvZXJyYXRhL01ha2Vm
aWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
ICsNCj4+IMKgIGFyY2gvcmlzY3YvZXJyYXRhL21pcHMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNSArKw0KPj4gwqAgYXJjaC9yaXNjdi9lcnJhdGEv
bWlwcy9lcnJhdGEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNjcg
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gwqAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hbHRl
cm5hdGl2ZS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArDQo+PiDCoCBhcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL2NtcHhjaGcuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMyArLQ0KPj4gwqAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lcnJhdGFfbGlz
dC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEzICsrKystDQo+PiDCoCBhcmNoL3Jp
c2N2L2luY2x1ZGUvYXNtL2VycmF0YV9saXN0X3ZlbmRvcnMuaMKgwqDCoMKgwqDCoCB8wqAgNSAr
Kw0KPj4gwqAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9od3Byb2JlLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKy0NCj4+IMKgIGFyY2gvcmlzY3YvaW5jbHVkZS9h
c20vdmRzby9wcm9jZXNzb3IuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKy0NCj4+IMKg
IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmVuZG9yX2V4dGVuc2lvbnMvbWlwcy5owqDCoMKgIHwg
MzcgKysrKysrKysrKysrDQo+PiDCoCAuLi4vaW5jbHVkZS9hc20vdmVuZG9yX2V4dGVuc2lvbnMv
bWlwc19od3Byb2JlLmjCoMKgIHwgMjIgKysrKysrKw0KPj4gwqAgYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS92ZW5kb3JpZF9saXN0LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4g
wqAgYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkvYXNtL2h3cHJvYmUuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxICsNCj4+IMKgIGFyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS92ZW5k
b3IvbWlwcy5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsNCj4+IMKgIGFyY2gvcmlzY3Yva2Vy
bmVsL2FsdGVybmF0aXZlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgNSArKw0KPj4gwqAgYXJjaC9yaXNjdi9rZXJuZWwvc3lzX2h3cHJvYmUuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrDQo+PiDCoCBhcmNoL3Jpc2N2L2tl
cm5lbC92ZW5kb3JfZXh0ZW5zaW9ucy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCAr
KysrDQo+PiDCoCBhcmNoL3Jpc2N2L2tlcm5lbC92ZW5kb3JfZXh0ZW5zaW9ucy9NYWtlZmlsZcKg
wqDCoMKgwqDCoCB8wqAgMiArDQo+PiDCoCBhcmNoL3Jpc2N2L2tlcm5lbC92ZW5kb3JfZXh0ZW5z
aW9ucy9taXBzLmPCoMKgwqDCoMKgwqDCoMKgIHwgMjIgKysrKysrKw0KPj4gwqAgYXJjaC9yaXNj
di9rZXJuZWwvdmVuZG9yX2V4dGVuc2lvbnMvbWlwc19od3Byb2JlLmMgfCAyMyArKysrKysrKw0K
Pj4gwqAgYXJjaC9yaXNjdi9tbS9pbml0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4gwqAgdG9vbHMvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS92ZHNvL3Byb2Nlc3Nvci5owqDCoMKgwqDCoCB8IDI3ICsrKysrLS0t
LQ0KPj4gwqAgMjYgZmlsZXMgY2hhbmdlZCwgMjk4IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9u
cygtKQ0KPj4gLS0tDQo+PiBiYXNlLWNvbW1pdDogYjZhNGJhZTJmMTYxNjI4NzY4NDIxMjdkNzUw
N2RhZDg0ZTQwNGY4Zg0KPj4gY2hhbmdlLWlkOiAyMDI1MDQyNC1wODcwMC1wYXVzZS1kY2I2NDk5
NjhlMjQNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+DQo+DQo+IFRoYW5rcyBmb3IgdGhlIHY1LCBJ
J2xsIHRha2UgdGhhdCBmb3IgNi4xNy4NCg0KSGkgQWxleGFuZHJlLA0KDQpUaGFuayB5b3Ugb25j
ZSBhZ2FpbiBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIHJldmlldyB0aGUgc2VyaWVzLg0KDQpCZXN0
IHJlZ2FyZHMsDQoNCkFsZWtzYQ0KDQo+DQo+IFRoYW5rcywNCj4NCj4gQWxleA0KPg0K

