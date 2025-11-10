Return-Path: <linux-kernel+bounces-892775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C0C45CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EBA14F1279
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A74302154;
	Mon, 10 Nov 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="CA5Fh0kY"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5A2FF66A;
	Mon, 10 Nov 2025 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768633; cv=fail; b=WnCZMCHd1DHveStFHi5PM509u72NnyISYcs6zO3YTyTbfaODy/9a+HSGZGYONSVGYU2VpLt45ySG+GamJOdRfi+ac9xSwZS2NY0zFtpmAChEydtlUuMdnikElWLeTMQeJ45AgieGOQ9oiuPPaZ6eai477Yq8R0V2LupZECliZz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768633; c=relaxed/simple;
	bh=EvEs/dRvIFj3rXkj48nl98zqK+WTxDNEY6LwGwtAjXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbs3NqoexwcracXbojIbJDHTkRWAId5jeg0z23Y8nZxea5BPAmUVtIRTygQNgLkNjbeLzdwmVLpJHOz53A2S+nnE52MiUZ1Z/14zpadHVYYglXUiIT8GEw01v2CU2ppZe3rEAqqMvPBA9CZUPJxQbFWh1WnCcTiFoUg/ZohEqgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=CA5Fh0kY; arc=fail smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 5AA8544M2505453; Mon, 10 Nov 2025 17:05:05 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=yuji2.ishikawa@toshiba.co.jp;s=
	key1.smx;t=1762761863;x=1763971463;bh=EvEs/dRvIFj3rXkj48nl98zqK+WTxDNEY6LwGwt
	AjXA=;b=CA5Fh0kYuBy/y+eaq/EPOoQQr69ZOvJIV+rgm1cGd+Zm+pCDpyXNjq4btUUzfM9vCzIYy
	Hgtj3hPWCrD1dDD5lOMV4fqDQA242CLW+++wrTIpM1Lh1gON7ilhkpc1y/FuhxK0d+JqDzL/I8IHS
	MMF3OMEHwXNfVJiOHdaAG4dOmPxwrSX1HziExwyVMiz72+dg/t5c2BxRdPlimKDIqR2GicRqDqPq/
	GCfHueIpTBS2KSr3pQNAfjR7fXh/pMHfuOexLKaPRSznXzS8UmKX4S51yNTHfiSHK4BUD9Dbn0IZD
	r+FCuiaDEV4+h/CqIyHHgGn1H/+1BPWI36dZkev9dA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5AA84MCA3190371; Mon, 10 Nov 2025 17:04:22 +0900
X-Iguazu-Qid: 2rWgP4I4zPxHezkgHV
X-Iguazu-QSIG: v=2; s=0; t=1762761862; q=2rWgP4I4zPxHezkgHV; m=w1KF5cedOA9wdJgYypjixlJeelFdLP6n6THjGslb8IU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d4hyX3T8vz1xnc; Mon, 10 Nov 2025 17:04:20 +0900 (JST)
X-SA-MID: 55598262
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUQZHxcr/Tpy0J/8bFrwusWWiUYZojXzy7Mc9xxs3JV9+i/LCIVFIgXf+CbCfKkTHpQ/IiM9Ek0K9XdgTlhP8kHBjKLxfjoja3yj5NiJ/3NbvswJwyQhx3cS4Ojmxz7BpOjh9RVGoyTx8/QeUF8YZ4XM4+tgxUJaQJxpPp5Kap+LlfZl0SJUjEWbMWAwFqLz2i1c+pdj/ZWKQuBgENJOXwBOpKlobbVnoEUWBPkkObpKh0ya+cFP74QoW0PWaCTlV+nBOroZqdiKckEEQ6LW0EYoJSuEh2Rfg0eklAIX6gjX+S9dUMw4BlxnGWuM+Io9ZUcBd99solz4ewoETyAk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvEs/dRvIFj3rXkj48nl98zqK+WTxDNEY6LwGwtAjXA=;
 b=FF2lkHEnEH//nwRxF9PSqtYcFBvLInrWBaL1HB3h63dN4EFlvWpIt67w/zNc8CMzN1009x2OVxXkxFTH4BP/Sj99oqPpMB4syll2w8uD/v97MlOKH5APlvIb6xKYpItWuPPrUACJRG3e1HHMVDIK9a2Y7QqdN3EqJ9cfPL9mJoh/oViEguQ8rSFzWhEo6cMoPU4YecY+zGdzy/cKBtkdlPXSWJZm20/TegZYgrvpA2hMA4alvAtW/v6oiUHjWgaW/T9DgRnsIGlKeqRP0bf4kxeWX7TMHK7Y9tmE55kU0Fcv9g/gLvDTaxdxg2MDlAFqXSOeN+KY6iUUL/H93YJDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <yuji2.ishikawa@toshiba.co.jp>
To: <krzk@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nobuhiro.iwamatsu.x90@mail.toshiba>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: clock: Add identifiers for VIIF on
 Toshiba Visconti TMPV770x SoC
Thread-Topic: [PATCH v2 1/2] dt-bindings: clock: Add identifiers for VIIF on
 Toshiba Visconti TMPV770x SoC
Thread-Index: AQHcSJs924CTpRxk10OO3qAHm4o3QbTYrCKAgBLxxbA=
Date: Mon, 10 Nov 2025 07:59:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB998221A506B2FDAE11E653DD92CEA@TY3PR01MB9982.jpnprd01.prod.outlook.com>
References: <20251029061344.451222-1-yuji2.ishikawa@toshiba.co.jp>
 <20251029061344.451222-2-yuji2.ishikawa@toshiba.co.jp>
 <068e8e8e-2968-44e8-8769-be0dfe1409c2@kernel.org>
In-Reply-To: <068e8e8e-2968-44e8-8769-be0dfe1409c2@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9982:EE_|TY7PR01MB14554:EE_
x-ms-office365-filtering-correlation-id: 482bfea3-044c-43cd-126e-08de202f0ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZS9pelpscFpKRGF3ZlZqU0RXMGs4L0djOGNoQi9HRnRnUE90Z1U5bC9ySGpp?=
 =?utf-8?B?VHJ5em1ZOGVMci9Oay9vUW1JRFBVOWRUOWZqM1k5Q0pONnNMM1MxYXcrWmU2?=
 =?utf-8?B?NFpZY1p2R1V1b0ptWVNXejFBZ1dPRURESWR2UWxnbGh4ZVJRQWV2TSs5VDZT?=
 =?utf-8?B?ZnhWaTUwNzhpN2tWQkpJc3N0QmYrenZHdFpSaE12Yk5DNGNNVWh1MklJL2dl?=
 =?utf-8?B?eXJWZVd3SDhCZmh6NE5aY0lCM2JVOEMveERsamJaYS9GNkZlVWdxaEZjMURy?=
 =?utf-8?B?M2xqSFZ1U1Z3Wi9hbGR5Z2VHaE13SFV2RXhRVnRBSFg2Y1ZkTVVVbkh2SzdU?=
 =?utf-8?B?RjBxaFFVSmhCcWxJOGRSY1dzSUVaWkJ6N2Y1czIvWFFRcFpPMXRGWXpDb3gz?=
 =?utf-8?B?OUdZb2FTWVdnbk1CRnBhQXJDd1FmL1EyZ3VHanNNVnpCVXp3N3ZKZ01PdVNh?=
 =?utf-8?B?cWQyS2owMTdsa2pWZS9zYTNMaWZvQVBIMkZVbVh2TmFRanRLdFNEWFY2T3pr?=
 =?utf-8?B?NWRrQWdQNXJ1QWlmRUFOaG5xQmx4c1B0NVhwY0ZHbGFvdlhFZzlDWWtFbUpY?=
 =?utf-8?B?S3poMjZKcWZQeEFHQlprUFJwUDBhWUlEUUF5aHNnV1N4YUZJajRpZXJRWDZk?=
 =?utf-8?B?cFdaTm44VlVGK1IvTWFWemQxMzVkMmIycFpHYURUNlM0eENPZ0pJT083dmoz?=
 =?utf-8?B?MjhtUXNLQUc5L1FCN0tSL0hrRTZZYkRPYmtGc0ZCSElBQjYvV3huaExGZFVl?=
 =?utf-8?B?ZGVsMTRwbDluaE5TZXJXMm9QU3BEMjl3T3VjdElwVWxJNG1IRUhRZ0lZMTMr?=
 =?utf-8?B?NW5UaFl0NjI0MlV5b2ZtclB3eitGc1JJUDVUT2VrSW14T0s0WDJNY1A2RGhh?=
 =?utf-8?B?VnVSbGdCK3ExaitsTHVDOUdGY0dhRVNYZWJlTG5lbkI2amF1WGpSdWI5T01C?=
 =?utf-8?B?UFVFSHVjb3FnMkRpd2NGV0RCSTNUY1Vwcnd5N3RINW5XdS9Sak5MMGxhZ1cy?=
 =?utf-8?B?Z0xOVklxQXRacmtaSmtvYmpHZnBwSDByalAwdi9RQnFzOTlwZ2h3cU43eHR6?=
 =?utf-8?B?ZWFaanF2eGFzVGRKVnZpWlFibFpvUWR0N0hZazZRQlB0YkNLT28vMk10NFU3?=
 =?utf-8?B?cTJZaVBzSmc2dk9LZmdRUVRvNlJDYzdKKzJEU0dZVyt2Qnd5UWw1WHpxTHdK?=
 =?utf-8?B?NXNGOEtqL0VNTkRLR0w5c1h6eXllYWllMGlZU3F1djhycnJnbDMvZXo2S1pD?=
 =?utf-8?B?OUIxWkNSdFJCNnVrVy9aZ3o4Mkh2a3BRa0hlT1BPaFphSWF1OFh1VWlOMGZO?=
 =?utf-8?B?eG41Q2RDbmVlTDB4RmszbjRITVVVcGlQa1MxR2NXSXhnRGtQUHNsSm9jZGhJ?=
 =?utf-8?B?cEhmMEFuSm55MTNyaWRWbVlBcWJYd1U1NWs1RlFGSzM4aWxWMXQyeGZjUmtM?=
 =?utf-8?B?MEJTSkJxV1NJSFVHSWViR09CVU1aeGxOc3VJTkl1Sjh1cjI1M2hDQ3JzMitw?=
 =?utf-8?B?UWIzdzhIczFTZ0VUbXU2OWlMbTRyajZXblpLQTQzTG90b1hnb3hOOXhpQmpw?=
 =?utf-8?B?VHRHOThweithNmxYWDRwbVpIelRyZzlaYmhQZXMrdFFGMTRUZzJ5UHNKNHE1?=
 =?utf-8?B?dTlaMVc3NHVYWnR0WXcraEFBODFGM2ZPMEZDNDlMQzVpYWpzNzc4NVV3a3Vy?=
 =?utf-8?B?SFJISFZuWEpFMlhoZ2VveWVTc3JnNWc1RmNwL2x1K1Ywb2dxczhha2VrZDI3?=
 =?utf-8?B?QWFCN28xTW5sRWxWMkFDdUREbmtsNzdsYWdkTWsrMGgzRGRGR2F0Y1Q0a2h5?=
 =?utf-8?B?TkxoSWoxU21PbjZhSDBYUzczTVdYbUl2cjU3NzJVZ0xJeGMrbDJFdSsxbkJq?=
 =?utf-8?B?NFZYR0xHYjdqcjl5d1I2VTFwa0F2RFU4ZlZZUW9oNTE3L3FYeGcweUNPVWxp?=
 =?utf-8?B?MHBSQ2Y0bjVoa29NQUU2TEU1Z21aV2d4am16WEdpZXVWSU9SVjAwRnFPMi9i?=
 =?utf-8?B?STBXS1dTWHlZWHAxQVhwZmhEb1lGOEdWZXB3bTZlemN0UG9hYThKNzJ0ZHZo?=
 =?utf-8?Q?qx42hR?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9982.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V3ZzalptZlpORmFJQ0t4ZEpNQ0hoaVI2cVZ4RGJyZ3VuaEpBNXlpcjArSExx?=
 =?utf-8?B?SDhwTzM0WVRPenRIOWFrMnR0UUprcVZkK2tiZlRRTlRiODh5WVBQVjVibDly?=
 =?utf-8?B?UzFYd0VCZVZydWRUU0Z2ZmwxR2JpN2pvN0dOakNtTjJqM0ZxSUh0bWR0eGpk?=
 =?utf-8?B?TFZDd1NDcWxMa2RMbWZzek5uN3RER3JwSmExR1hwVEVzTmJzMkFSMDNHM2M5?=
 =?utf-8?B?Y1RFSGNWMmFSZWJBSU1SZW5vUzhkUzdtTERienczZEQvNTZ1R0xDTzBKNWVD?=
 =?utf-8?B?T20yQnMxZnpvQTRya3VVZFdSZGtiMGszdXBFUTl0dzY0VzJ3dE82bWVlQlI4?=
 =?utf-8?B?Y3NmRVJDdzNRQ1krbzdFRjVqSm5SdkZVbFg3QURVVlNNbEcrd2Zaa0dWeHVx?=
 =?utf-8?B?TGJFdFNTeTd4bUUxR3RzRFo1bkVwSVBNYnhJWTFVRFRid1Vvc2FaYnd6WTVL?=
 =?utf-8?B?V1ZRSmFENVFjcGNNc1JIM09kUXBGejNNM2k0N2xxL2oybUtNZngxeXQ2b3JZ?=
 =?utf-8?B?UUtpRVRxZ3poMXg2UFV2UVJnNjZtR3JSZU04WXk4Y0k5TDd0RDdVVFR5ZHFp?=
 =?utf-8?B?UEg5U0diTDlLK2Q2SHpEWTRSNDNDMG5KWlhLYS9KSGs4Ylk5TzhTWjVlM1RM?=
 =?utf-8?B?cUFiS3Q1dElWaGhKczlHWHM5MnIxNjRmM0JpSlA4aFd6ZGxVdklQdVN5NktG?=
 =?utf-8?B?T0E2a1VOMW9ONjFKMDJzc0xYNVIvZjZzbXZwd3lodnRNdEhXY2FOZHNCSmZU?=
 =?utf-8?B?S1N3dHBoSElRaXhLaVpxWGc3SXI1Y295Y0k0Y0ZnRHEvNG9tN3Y1ZFpwMk9z?=
 =?utf-8?B?RkdKTDRZZVJmNDJxcC9nZHI1UnR1NTBVSU82T1hxVGQwYzd1djA5eUxOblRO?=
 =?utf-8?B?U0FTWDN6UlVLK0M1K25ka2xIQXQxSnpaMDVmUEtIS01UR0tKZC83MFpsSjNx?=
 =?utf-8?B?cWtPaDNCOFNoL2FGeWlmdU9Bc29nZkM0WnQ4dlJ5UlZ4SzR1N1VmM29YR2dI?=
 =?utf-8?B?RndmNXRUWHNNbGxRV0VJUEhaOC8vTDhrWjdqRm1iU3hsYXN1Z1dIZXdWS1FR?=
 =?utf-8?B?d2xIRWtGNHQ5VkpncjB6YXdhZWhMeEhucjlDMFNjU0dTOEorUnJYVDVlemFs?=
 =?utf-8?B?RHQ1TTFMR252N2ZOMi9BRFFDMUNpM0pMZ3FJbGxjQThWSzB3U3BPS0xtTU1l?=
 =?utf-8?B?OHcvdHhFVFVQcGovaXlCc2thdDl0U05nVTlneUJZZDZXUGovSEJDQzQvcldk?=
 =?utf-8?B?SEVDWXJNUlJuOHR2R2xnV2EyRWtVS0owaGgyTTkrOHArT2dsSHdtd0M2OTUy?=
 =?utf-8?B?M0NsT0o5U01vcWI1VzZlOXRNTUE2eGg0ak5kRmVFOTM3elFwYjdha2N1bDli?=
 =?utf-8?B?ZFVoVDJCeTdHNzVyUSsrOTUwa0ZONHgvV0tYbnZQWis3NVB2Z1ZNOFdJVlkx?=
 =?utf-8?B?Y0N0b3ptVW1uNmhOZnJPSWd0QzU3TEtCU3dZMEVSYTVKcTFJZDJZREtxU0Yr?=
 =?utf-8?B?NWRvZW9UOURaM2plKzlzUnRNTmJYQ0lnTzUvN1hCeU96c0VMZVJkWGtyeiti?=
 =?utf-8?B?eUFZeDRiUXUxN1BLc2xtUWJ5UXR2dmx4NkxKT0h5UjlFcGJPcEZnSHdtYzhh?=
 =?utf-8?B?enBHWWZ0OE96ME9CRExRbzc1SmlFbGhNTVN3SmFyakRUYmQ3dTlkNDZWT1d4?=
 =?utf-8?B?Q05wOUtvTW9QVUJ2ejJFK2RpbENIWmNQeHZuaW5pU29TV2xPblZaTCtpTlli?=
 =?utf-8?B?Zkg1S3o3SnhYVjMydUZ0VzJYVEtOb2l1RXVzWGdNWTgwR2lSRXN4ckpxZ01U?=
 =?utf-8?B?bnk3U2JSMkltK2IxMGtyZzk2NXhuTzhUNW1STkpkWk9rbHZ1Z3NjRVYyRTJu?=
 =?utf-8?B?c0s3RUJFc0l1YXg3WWZUak9ENkJDVUpZMjcyR3RLQ0d6NXlHSEhmR1pWNVBJ?=
 =?utf-8?B?SkVKSHRrMnZYQjhrS3JTd1BncmtQU21oNWlMV05mQzRlOUdrb05nTjZvZ21z?=
 =?utf-8?B?QnNnUkVsSURDRUNGKzhDVHRVZmlxU0VCZ1EvS2Fna1lUeG5lSWJYVmloT0lh?=
 =?utf-8?B?UVVsUkg3a3NvMFo2SWJqc1g0ZDJVemN5VWF1RE83U253Sy8zY0M5TkM4S3p5?=
 =?utf-8?B?bjZ0dTlGTmJld2hXcWhvLzRLbk55NHJCQWw4cEpqVU9uM2FWc1JiQ3RaU210?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9982.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482bfea3-044c-43cd-126e-08de202f0ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 07:59:15.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DzhqOQuXbFGU3b5sTogmtLPg/8HeKoM/dVsAx4AbW6g9b1gWNMzty5H79pUdW/Cfyft/QoXnci62qC8ffAnwfZAmIwVpWR0rSAaQR8jFOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14554

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyOSwgMjAyNSAz
OjM5IFBNDQo+IFRvOiBpc2hpa2F3YSB5dWppKOefs+W3nSDmgqDlj7gg4pah77yh77yp77yk77yj
4peL77yl77yh6ZaLKQ0KPiA8eXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcD47IE1pY2hhZWwg
VHVycXVldHRlDQo+IDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZCA8c2Jv
eWRAa2VybmVsLm9yZz47IGl3YW1hdHN1DQo+IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk
77yp77y077yj4peL77yj77yw77y0KQ0KPiA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9z
aGliYT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5l
bC5vcmc+OyBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBDYzogbGlu
dXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZ3M6IGNsb2Nr
OiBBZGQgaWRlbnRpZmllcnMgZm9yIFZJSUYgb24NCj4gVG9zaGliYSBWaXNjb250aSBUTVBWNzcw
eCBTb0MNCj4gDQo+IE9uIDI5LzEwLzIwMjUgMDc6MTMsIFl1amkgSXNoaWthd2Egd3JvdGU6DQo+
ID4gQWRkIGNsb2NrIGFuZCByZXNldCBpZGVudGlmaWVycyBmb3IgdGhlIFZpZGVvIElucHV0IElu
dGVyZmFjZS4NCj4gPiBUaGVzZSBpZGVudGlmaWVycyBzdXBwb3J0IHR3byBpbnN0YW5jZXM6IFZJ
SUYwIGFuZCBWSUlGMS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1amkgSXNoaWthd2EgPHl1
amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlbG9nIHYyOg0K
PiA+IC0gRG8gbm90IG1vZGlmeSBleGlzdGluZyBpZGVudGlmaWVycyB0byBhdm9pZCBicmVha2lu
ZyBBQkkuDQo+ID4gICBLZWVwIGV4aXN0aW5nIGlkZW50ZmllcnMgZm9yIFZJSUYwLg0KPiA+ICAg
SW50cm9kdWNlIG5ldyBpZGVuZmlmaWVycyBmb3IgVklJRjEsIGZvbGxvd2luZyB0aGUgc2FtZSBu
YW1pbmcNCj4gY29udmVudGlvbnMuDQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3Mv
Y2xvY2svdG9zaGliYSx0bXB2NzcweC5oIHwgMTUgKysrKysrKysrKysrKy0tDQo+ID4gaW5jbHVk
ZS9kdC1iaW5kaW5ncy9yZXNldC90b3NoaWJhLHRtcHY3NzB4LmggfCAxMCArKysrKysrKystDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3Rvc2hpYmEsdG1w
djc3MHguaA0KPiA+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay90b3NoaWJhLHRtcHY3NzB4
LmgNCj4gPiBpbmRleCA1ZmNlNzEzMDAuLmZmNGVmMWJlNSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3Rvc2hpYmEsdG1wdjc3MHguaA0KPiA+ICsrKyBiL2luY2x1
ZGUvZHQtYmluZGluZ3MvY2xvY2svdG9zaGliYSx0bXB2NzcweC5oDQo+ID4gQEAgLTE0MSw3ICsx
NDEsMTAgQEANCj4gPiAgI2RlZmluZSBUTVBWNzcwWF9DTEtfUElSRUZDTEsJCTEyNA0KPiA+ICAj
ZGVmaW5lIFRNUFY3NzBYX0NMS19TQlVTCQkxMjUNCj4gPiAgI2RlZmluZSBUTVBWNzcwWF9DTEtf
QlVTTENLCQkxMjYNCj4gPiAtI2RlZmluZSBUTVBWNzcwWF9OUl9DTEsJCQkxMjcNCj4gDQo+IFlv
dSBjYW5ub3QgY2hhbmdlIGl0LCBhcyBleHBsYWluZWQgbGFzdCB0aW1lLiBJZiB0aGlzIGlzIG5v
dCBhbiBBQkksIHRoZW4gaW4NCj4gc2VwYXJhdGUgcGF0Y2ggZHJvcCBpdCAoc2VlIGV4YW1wbGVz
IGluIHRoZSBoaXN0b3J5IGZvciBTYW1zdW5nLCBOWFAgYW5kDQo+IHByb2JhYmx5IG1hbnkgbW9y
ZSBTb0NzKS4NCg0KSSB1bmRlcnN0YW5kIFRNUFY3NzBYX05SX0NMSyBhbmQgb3RoZXJzIGNhbiBu
b3QgYmUgY2hhbmdlZC4NCkknbGwgbWFrZSBhIHNlcGFyYXRlIHBhdGNoc2V0IHRvIGRyb3AgdGhl
bS4NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpSZWdhcmRzLA0KWXVqaSBJc2hp
a2F3YQ0K


