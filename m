Return-Path: <linux-kernel+bounces-849969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46A0BD17E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179B23A83D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC02DE1F0;
	Mon, 13 Oct 2025 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="DWd87h/Q"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021109.outbound.protection.outlook.com [52.101.70.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956BCA6B;
	Mon, 13 Oct 2025 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334345; cv=fail; b=StjIrdOnciWgDKouVURnF9GavM2Ox/rw0BVVMs5w86roehixCKlvcOodVonsoW8XIuc2pE0gUVyA93pDEdj19pgP7unhJis3NzNdEVe3+Qo0PuGbYISGLKQultdsm5txjzPYv4Y9aoHB0n9Xjs0tI9h4SDQKEyvbBiW1SfuMA9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334345; c=relaxed/simple;
	bh=iHTal00p2c55nOy5vPZMcmMjbISb7YxbpqpdFFJbBGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fjl/TjZqHjMtqDIthI3zOHHJ7OKVWiOqlPUh0uZIZ6wjgvx07SvDxr73jg5mUMREfEh5yAQpvjTs7KJ8amAuU/M4gwydZyezr9bUIGgne2f9kqmIqIRn80wtNqFoTEB3oGe6hmeYvSHrq5VIodaCnN1HtBYA5GFQmzC2IYl+lQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=DWd87h/Q; arc=fail smtp.client-ip=52.101.70.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlVPVkjkNdsFHRs1828W6j8LIga6cimJJjKKIv8KM9Ar6QOUTbqSzPFGqXtG40OwI6DtstPjOgL8D3gcQFBUYxjfqxFlnfM7miujZvjTHYhb2DCZsfbCjj9pQLMhDB1RJGmnmqk+DzTZVlFWx/ffjwuWGKLJUImdKCSokUCCgIG+sNQAlnIXkz/YiUCC7eGFWEtyWdbAWljoTEzogoGfwVGlQygmc7SeJyeRuNPf/OouUT/rNHBuX+2k1Q1sWGdDN1FsUXWRmhNSM7GPfvwZbDJzKFzg782wBMhEHqh/k7fhkDmy2+1gx/ZoB/ZFjFkZ+yr0NRZD77AxIZE2ml9uPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHTal00p2c55nOy5vPZMcmMjbISb7YxbpqpdFFJbBGI=;
 b=KdWA9wxKSRPxjk7+VRphrdYzpuVfMXVBv18yxJY/Tx8HcgpH2UJ2kTjxXiFN3w/G7rnf7OR+hECCg8MiQQMUrnC4k91qkWyyRs92a1GKU7Mh5ys+0/fAnhdDnKbbVH9O4aVftdg3KLv9zHxgp7glBrIorXAFdbR0pPul2lgtMbrvZTE39+dMPYrG3fS13OpB5bBD5d49mQeL9+MnrxmxTc5ZmM/iV5m/GOHazte/4LXY8lKAe42BTLShR5rUYmWWE5lAz6XHqu9R+aVmUw1OHC6ALnw9C4/rHUQG4jWtbJHBsZYA9sKf66RNz98pDmg2hNW1YUW7u+hmFVJqdfMkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHTal00p2c55nOy5vPZMcmMjbISb7YxbpqpdFFJbBGI=;
 b=DWd87h/Qmw5V0o/WnRuwCSCzKaBQJR/pvM/9nrk4fR+CPii8r8eihI9bgBCgu3soq1TKFZE3QGi6CJE3ELHDXEVHsFqtk9DbNdWQtBVPV+cbU/oFVRFqsS4MIfw+MX2raKG7sOtrba79UPu8d607517dbGftM4C69mHUPohD+NR6//9L59u5IhUgE3owAhH8ibnq5nKhuUZqA7te2O+zzfDKtOpbn1jFDEzS96ORmWlDcc3EDvmziiXSFGEd3y9t3P4KNwEYWM2xHawwmSxrvrLXxgaR3aEALbOtmnf5V46xi1xiKNyZ8Qt83tKK8BY+JFdZsB8J4d/iMlCO0fwfRQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by MRVP195MB2708.EURP195.PROD.OUTLOOK.COM (2603:10a6:501:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:45:37 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:45:37 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
	<upstream@lists.phytec.de>
Subject: Re: [PATCH v3 1/4] arm64: dts: im8mp-phy{board,core}: update license
 and copyright
Thread-Topic: [PATCH v3 1/4] arm64: dts: im8mp-phy{board,core}: update license
 and copyright
Thread-Index: AQHcMs+xiJbF0y+YdU+wzqyMliyopbS8+jAAgAKpYAA=
Date: Mon, 13 Oct 2025 05:45:37 +0000
Message-ID: <6dc4634cc5edd10a3e04c624a936c3905fc7e415.camel@phytec.de>
References:
 <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
	 <20251001-imx8mp-pollux-display-overlays-v3-1-87f843f6bed6@phytec.de>
	 <20251011130650.GB20642@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20251011130650.GB20642@nxa18884-linux.ap.freescale.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|MRVP195MB2708:EE_
x-ms-office365-filtering-correlation-id: 270e106d-b5ae-43d5-c1fa-08de0a1bbc4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eldQRTNwc1IyZXAxek0rQ1JIa3JVbHNKRGxGSHRFRkFPMk4vOERNUWowcnJt?=
 =?utf-8?B?RG5TVGpwdG94dHlvaXhsY0NXa0JkMlc4ZmtrWXR4bmQzemdWRWtSMW5uMFQv?=
 =?utf-8?B?WmFBbUpadmNqQ0hPMDFJN2c1eHIyb3FjS0Y0Yk1QalRmN0JPRUFvKzA2SGkx?=
 =?utf-8?B?U0pmNnNMTmlpR01RRVZiRXd0d1poOTIxR0M0WndaRElKSFBKN0dJUi9wNVJC?=
 =?utf-8?B?RUYvME5XbGdmTy9JWmZwdk1FRHJYS0YxeDJMYWpORUwvRGVaL3d4VjgwRmdU?=
 =?utf-8?B?RWE2bjZSaDZYelZwVVhJTDN5QnBMQ0NuejdqRkxlUjRtUjV3SENpTldGSUp6?=
 =?utf-8?B?Vjg0MStTbGVCRWFoMzdnWFpGbjJ1NjR6ZkM1VVoyQm1LMG5IOC9oVGJQd3Fo?=
 =?utf-8?B?aUswTHhoMGYxRTBzNnd3c3VtWk10MklOclVHY1VjWnV5SFpMbkQ2anAwY0lY?=
 =?utf-8?B?U0hITHBycW9Bc3VOS2E2cWNYMlhWdGJhRnFUd2JnY1M5ZVIvVE1CdHJVYUFV?=
 =?utf-8?B?Tjc4SXQ3WFdoSWxrR2VTNGJRSXd6NG9IL2ZTZVh4U3ZyVStyakNrUGZkYnF1?=
 =?utf-8?B?UzNZYUNyQldtRHpxRjMyNjJ0UkZMWFZacEYxV1hTOHVqTzVkNS93NC9nVnll?=
 =?utf-8?B?c1RyYVc3ZFIxWjFzZHk1VmJ0dFlUYVpBRFdjL1NLb3A3SXR3TzF6QmZxTnBJ?=
 =?utf-8?B?dFhGZXFKcmthUFlTNGFKdW1lWnRnMURSZEFLY3c2SzBRU2haMy9Ibm0ySDl3?=
 =?utf-8?B?aTlFTi9mMEVhd3YwdWNIN0xzNDdpQlRvK0FRM1RpWDd1RWc3ZnlzNm1TZmpi?=
 =?utf-8?B?VFdTbG5TejFWdnNmMnVWUHFaNGdZREIrUEhwbFd4U0hKaWMwNUlVY1ZTSk9C?=
 =?utf-8?B?Sm1qV2MydHJWVUZzWGJOSGs1QW5IUWtSQzhsU0FCWE43ZVhtMDA3OUp3TUtR?=
 =?utf-8?B?alduSnRmclFHOXBLMEhnMzNiL0p5SUx1aFVUVmF2ZXZLYkFHTDNNWjhlV3hL?=
 =?utf-8?B?UFNqbnlaOVlINktEdUxxVTVKcWdmc3B3TXdxMjg5M2xIeHlEbUlSeG5Xb1oz?=
 =?utf-8?B?VE0ySklFUXEzVG0xZFh3WDJpSktaVkN3cHN0VXF3c2lUaG9HU0ViYjNjemtE?=
 =?utf-8?B?MGYya0RpeG5qNlhDaHpIelJsdkVBTVNjVDFTWDBzU1N2Y2l2NnJFYkVTeE8v?=
 =?utf-8?B?bDNsSmpzRDE4dms1WGl3UGdSNVBCbk5Vdjk2VXZ1ZUIwTmQ1R01ERXN1Y1JW?=
 =?utf-8?B?dFJCMExGbzVmbGFQbHJwWFpZTHUvVHZnb3djOVVMSEdDajFvdUpLR2NDektr?=
 =?utf-8?B?WVRoM1R0MGlvUTNHbGNNdkZqaVB0WDF2Nm9aVXpCaUFWc0doZERUa2dHcmp3?=
 =?utf-8?B?V1lncTNKL0xvVERJTTZQeVhRQkJObk84UC84Y2hwdkI4VlpCNE4yWW5QekpZ?=
 =?utf-8?B?YU1YVDN5bVhva1FFQUQwaDBURysxUEhJN3ViRFBzQnBtN2I0WSsxVkdRMlJi?=
 =?utf-8?B?VmVkYnJIVVJLblYzOVArUHpRREVYYUxzR1VUZVlwQUpHMjYxdFUyS2Q1YjBv?=
 =?utf-8?B?VUxGK2ovcm15VTg3YzRnMzVIRzB3bnhNQzBBOE1oSkRRTkRHYmV1Uk9IVHRO?=
 =?utf-8?B?MXNxZXhJNUJHSjB4N3phcVpXM0FvblR3cDNydGRaNnlmLys1UWVjRFc5NHpV?=
 =?utf-8?B?VnQrTSt3WHI1UEk1VUVjZmdoaHNCbzVXbjBKZVVmWHcxM29TZkNESVJRcFBO?=
 =?utf-8?B?MmNsb2tQc2pta21DNCtFNUQzNWVSNVVGeHNPai8xbTBwdVhJWkVTVlI1TkIx?=
 =?utf-8?B?Y3hWbmxSUmZ5U0F0N3lCSVB6UHkyZlhoT0FCQXZNb053a0NlMlBDMXF4blA2?=
 =?utf-8?B?eVgvNmJQV3poRWRSSFpwMFFFTjRDTzl2UWE4MFBMN01GanZUL1BkT2tzeXl4?=
 =?utf-8?B?cERYcFhmTWhrQm1ORVpNdlpNSC9yaG5jd1pDeVhOVUFTZGlIbDZoblh4VG9T?=
 =?utf-8?B?TnU5WXByNXBkdzVwS3VyQUQ3K1ZkYXp6bW0yUFdRMFdnZk01VTNtMWtIVWpl?=
 =?utf-8?Q?d/goe6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nk5FaUlmVytVK1cxR3dvL0ozSnV0N1NvSXY3cjhIa3Z0YzZRNGNEMmxoZW9Z?=
 =?utf-8?B?STA4b0ZmZk10R0xKYVY2OHl1YThabVdtVGF6aXBsbGtXMkFubmNMZ0ZFNFdD?=
 =?utf-8?B?b1picGg4NGl4ZTFPRlcrVkZRL05ReVRyekxoLzJJdGU4SWIzN0NpQU0xRWRC?=
 =?utf-8?B?Wk02M0NueW9pTDQ1VnN1V2Z2VVhwR2RnSjhwRUNMNkpLRWdRVm01bXVPWUdq?=
 =?utf-8?B?U1lkTXZCTFFKRnZBM2ZDb0VUbUtvWEQxUTRYams1TjJrMHJEbytybkNkNWov?=
 =?utf-8?B?OG9RWGcwZWRnM3E3Y0JwU3Bab2JoQmJUak1nMy9EQUJwSTErNDhNbTFNZ21i?=
 =?utf-8?B?VXg3SjVpRmhtV3RvczRkMkdSWDNZMjRsZUt0ekRuQk91Nnc1Z3BxOG1uK0Rz?=
 =?utf-8?B?ZlNqYUhqWldnQVo4enpxUmZ0NUlZU0UydHd6MFVTQXdsckNlRkEvWU5ndnFU?=
 =?utf-8?B?ZFoxcW9uMjJMZHZ6OXZZRjNlclBoYUFrRDQrWmtodTkxNUlDaFEyUjdhSW1r?=
 =?utf-8?B?bllXRzR3eHdqdTE2MU9pK0ZMbTQrOS9OREcydU9hOG04RVp6OGhwbGRVSTlv?=
 =?utf-8?B?UVVXc1BFRmxXTXJPZ2EvTzBzendDOEdUZnY5Z2Z3VkUvaXAwVkREVndOaXZm?=
 =?utf-8?B?WnhZUmZDL2NFYTZhWXNnajBSc0g2b1YvY3RlT28xVTBoOXF1S1RLNXJKSnZY?=
 =?utf-8?B?N1VNbHVocU03REN5dVVwUmlQZU5zV0ZpWGdsdDliZjBzUWVFQjNveTQzSi9x?=
 =?utf-8?B?WHBnMXIwcVhyaG9LM05JRHJ3ZHpvZjRTM0lHd1F6L1JCZC8wT3lNR05qYU5n?=
 =?utf-8?B?RWc5dWlmVHo5SU13a0RkdDlvZm5qQUVPUXpxS0VZUVA2SEMvR3dNS29NdVVx?=
 =?utf-8?B?TFdYVnc4Y1hFMVQxOERoWFNVYWwyVkdvckppSTl5enNkUThGSTdEOW9hdXZJ?=
 =?utf-8?B?b3dIRHMrMUY1UUUxRmloUG5GRVlPOHRUM3Rwam44WFZJSlk5UDFzUkVxUkRM?=
 =?utf-8?B?UDlJMmpLZU9wQXZCNmNNSURBbW94SXk3T3p6ZjhnMzlUQ0R5Z3FjMGRnR1pB?=
 =?utf-8?B?Y0IwVE4zTk8wM3NxSCt3NVZ0T1o5NmNDRXZLeWllVEFBM1M2VjJjNGtRaS9G?=
 =?utf-8?B?VnMyTXNsdHlsdUVsdnNidW1wQUQxZEorRzJjb2M1b21YeFpodTV4SXE3aFRF?=
 =?utf-8?B?VzZUZTNLTytHb2JnUy9tSU1YK1RBeEFuLzhsTW9XVkoyQW44bnNVWDZoc05W?=
 =?utf-8?B?cmdXTktsUkFJOTc0U0M2ZnM2aHQ4dmc2cW82VUhsc3pHc2piMFJkZHJhR0dl?=
 =?utf-8?B?dWFYU3VjRmVMY1I2TnhRMU93UlJZcXJseDFtcUdHQUpTbmtWTndwbGFZMmNV?=
 =?utf-8?B?ekQvWDRsZ0UzSHNkWjNXMlpwZmVtOC81WXZqaHBGR0tOY1hZeTZOTGNtMEla?=
 =?utf-8?B?bDRlRWQ4S0syZ2NCZEZNVWlsdzk4S0RUZWpCcGVsSVhrcFd0ek1uY2ZYN3k4?=
 =?utf-8?B?d2FVU0kzdUpVVTgzVnk1NVRxWEVOOEpleVZQcUlsbVl6SGswZGZBZjJkMGRM?=
 =?utf-8?B?WUZneWJ1Z3BoVEcyVDZWRndINW5lN2l4RitpNW5ZMWg5eDFFWHBQd2JIaUFa?=
 =?utf-8?B?cEFkRDIvRDhGSjdBeUNIaTU2NGx1WVdzWVZYcGh2WHBSUzZqc1BpeTJYdkhx?=
 =?utf-8?B?b1RVQWxYaUZTam5GWlNVZWhUWkVhRmt2MUZQUTFoQWF1M1Y5blJjdUhXTHFH?=
 =?utf-8?B?dWtSZC9GY0ZxYTBmTE5qRzRHelkzNkpBMlVWdjZycjlOUkZwVkpSVUZqWC9D?=
 =?utf-8?B?MTBjd3VyU2JHZ2RCRWZLVlh5MnJSRm9mVFViSEhJcXowVkwwVDBXWkFTcUY1?=
 =?utf-8?B?N0crUXkyclhLZCtlbFhvMTVnMW5GVHZMblpSdzdZdWZDcnlGMVM5QnlSanNU?=
 =?utf-8?B?LzRHejYyWldlb2J6WmIxMFdlRWFXdTJVOFpzOTVVdXZmWFozRFFNa0Q4aXds?=
 =?utf-8?B?ME1QT0tzd1dsWTgvTzM5SnVpRGh5cFRCWndRZWRlMGZtd1Bkd292bVNBTnFZ?=
 =?utf-8?B?aE9ZbFZoVGlKOENZWSs4MHZMZmlxaWhDTnBTOUxoUXkxUlBMV3pBZ2JVcmtm?=
 =?utf-8?Q?qkUo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <384D69DB2DD2524C8B33A009A538B709@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 270e106d-b5ae-43d5-c1fa-08de0a1bbc4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 05:45:37.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKT7mQzsPNLgwyfzr9gizLFScw3r6az/jikL3rdrxehrr4/1ALNoq0S1hWtunYF4c3uXNL/d9p3zt1iqCA1/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRVP195MB2708

QW0gU2Ftc3RhZywgZGVtIDExLjEwLjIwMjUgdW0gMjE6MDYgKzA4MDAgc2NocmllYiBQZW5nIEZh
bjoKPiBPbiBXZWQsIE9jdCAwMSwgMjAyNSBhdCAwMjozMzo1MVBNICswMjAwLCBZYW5uaWMgTW9v
ZyB3cm90ZToKPiA+IFVwZGF0ZSBDb3B5cmlnaHQgeWVhciBhbmQgY2hhbmdlIGxpY2Vuc2UgZnJv
bSBHUEwtMi4wIHRvCj4gPiBHUEwtMi4wLW9yLWxhdGVyIE9SIE1JVC4gVXNlIHN5bnRheCBhcyBk
ZWZpbmVkIGluIHRoZSBTUERYIHN0YW5kYXJkLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5u
aWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4KPiA+IC0tLQo+ID4gYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGsuZHRzIHwgNCArKy0tCj4gPiBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1zb20uZHRzacKgwqDC
oMKgwqDCoMKgIHwgNCArKy0tCj4gPiAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLmR0cwo+ID4gYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5kdHMKPiA+IGlu
ZGV4Cj4gPiA0MzYxNTIzMDg2NDIyNzBjMzIwZTNhZTNiMjFiOWU0NmI5MjNjMDQzLi42MTEwYzZh
NDg0ZDNmMGI0MjdhZDM3MmUxYmQxNjA2M2QxCj4gPiBjZTE2NWYgMTAwNjQ0Cj4gPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay5k
dHMKPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2Fy
ZC1wb2xsdXgtcmRrLmR0cwo+ID4gQEAgLTEsNiArMSw2IEBACj4gPiAtLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAKPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlciBPUiBNSVQKPiAKPiA+IC8qCj4gPiAtICogQ29weXJpZ2h0IChDKSAyMDIw
IFBIWVRFQyBNZXNzdGVjaG5payBHbWJICj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1IFBIWVRF
QyBNZXNzdGVjaG5payBHbWJICj4gCj4gSXMgdGhpcyBleHBlY3RlZD8gSW4gbm9ybWFsIGNhc2Us
IHRoaXMgbWlnaHQgYmUgIjIwMjAsIDIwMjUiLgoKTm8sIGl0IHdhcyBhbiBlcnJvciBieSBtZS4K
Cj4gCj4gQlRXOiBZb3UgbWF5IGFsc28gbmVlZCB0byBjb2xsZWN0IEEtYiBmcm9tIGNvbnRyaWJ1
dG9ycyB0aGF0IGlzIG5vdCBpbiBwaHl0ZWMuCgpHb3QgaXQsIHRoYW5rcy4KCllhbm5pYwoKPiAK
PiBSZWdhcmRzCj4gUGVuZwo=

