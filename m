Return-Path: <linux-kernel+bounces-789875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA8B39BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DE8986AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86130BBA6;
	Thu, 28 Aug 2025 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="eN8ahzb8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2097.outbound.protection.outlook.com [40.107.20.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB42D6E7C;
	Thu, 28 Aug 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381896; cv=fail; b=mrb2++Qsa5PiuZjCy80NHKgs9JQ4JWW9WmWfXjUJUJETiNUsnXfJzhkKc4Yw7m7lQJBan7WG0PYI5UHNcbWrlTm3TdKwBqDY0O8Gf717jMwcwEH+iEZj2UJjw686MEFmD2K35JG6HQbz5nFLMIRSfn1rpaTXJ9LUyzRJb2EMetg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381896; c=relaxed/simple;
	bh=9rAhLOQ6AzeLed6WT5HIevB0aNfrEhs8hCSFmEgGC8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sgaLW0G0RtsF9elalqLvGpvRRRr4NQ1YXQkJfi3q901hEyFI64U3XV+u0tALyIY0LrIjC0LpvIsj36bqie20Okk8agNv6wrAZl9NNVHrb1uDo3uiu0/g03hD0yjzUcOxcF0EGPPFVqrh0awx1u6yb10FZiM6Jxtw8zrSiBkU4Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=eN8ahzb8; arc=fail smtp.client-ip=40.107.20.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGJi781cjGpIocCfMRivLUd3W8gGOuqwh09lmk8M9cFp4OAqaj6Yj5WSDNSCEE0daiheLENvIBOn0oxYiU0uBH10473IFXgcLBuRlGW0qeFalc2WcfKpHxlyLYB6ahDliY90LY7OhzlHmK+FZzds0MVdkkPg908GswAKzM6RNwjpvD7Qr8KcfIAtraHqtq10M9SyujBoZLed1lQDOC7uXNRgp7eo5equ7YwAismouC9rMyVdB2AUb5mbFWhL9ZzhZ2ar9Xi2Zge2SHLyhtidJ53QIYz/0eiTtbbzt8pXRd0N1lvyu6CkqxnnDKPh4T7A+c4OytaUTouMDkg5FtO3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdWOYL/FyKxTdFBRCQdkZNhYX2tEzCuy9z6eoSmxPXU=;
 b=Ns7paH2Bz26vyIHwIoNObMsIqFtsTIEfV01xCJauFgz1xtsaU3dgYsMo/qD+dIIXv+gNkoSjE0KssO/qFV0OclEenPoAPuTs/IDCWtd3V61x2DgbaF7lRzPq7BZEOAqb3wPx9DNHON4Qs2Aq+FnLdxiSX+KLio97P4drMGOM72AA7rpaz/7984o1y9clVziV1Z8q/5JdIkFI/WUrCiC5INh3R/3psML40ji5tongIg1LSglBoaDk3Ymw+3LEUlwIyj/DZNMi2C84U5QagT5gFBv8EmslNwWwvc7/oaAFUiZ9GBB3YkKcPGoNa7loyBKBq76LBKhteUFEjKPsix+xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdWOYL/FyKxTdFBRCQdkZNhYX2tEzCuy9z6eoSmxPXU=;
 b=eN8ahzb8ErL7+mpP9wMPcvXVk/bnuaQmshpq6tQ/5wWahTBC3mNSIoKkzt9Ao2gGR1MN7NEcsZdkvKYFOgTr3TReOdEdOgN2Yqx/ic2IQVsz3Zy/9LWTB836TYL9uUVJ2p+McuLV92bVrYMg4+9wOFdSQ25ihN9IB4bd/2FCzEYGNLLiaQnGZQNCHIaiEK5eRAfgEwz2batGSy3Zw7uj6Zr9sf3SKv8rZvSbnv7xkr1u3SRFNAcu8jbePzUYb8d75PdFy65GitjbL7Q9Htvdb+BSgoJbpjWpnsCVSRzBKlYGESbUIL8T7dq0H7hc9j3nXFXJDNwGMkupbPus7tdxtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1682.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 11:51:30 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 11:51:30 +0000
Message-ID: <d838653c-618b-4778-bf2c-9517a80b7631@phytec.de>
Date: Thu, 28 Aug 2025 14:51:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/33] arm64: dts: ti: k3-am62-ti-ipc-firmware:
 Refactor IPC cfg into new dtsi
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com, jm@ti.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-31-b-padhi@ti.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250823160901.2177841-31-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0238.eurprd07.prod.outlook.com
 (2603:10a6:802:58::41) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1682:EE_
X-MS-Office365-Filtering-Correlation-Id: 735bd34b-488d-4e38-0481-08dde6293a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHQ4cVpTV1JzeWoyKzNRY0tBY3FZMlRYY0ZKcnlaeVBIM3JFNFJkcGRTcXdm?=
 =?utf-8?B?Z1pHcFNXVEhXTHRXUEdrYVRtYnA3cDRsMU92eXFtS2xlSVE1RmlmcDVWSmo3?=
 =?utf-8?B?QURIaytGRDZ0dGVsaWFjL0RrRnpKY0R5Z0lBNUVYZkdKTHVuOHRwSXhWLzBM?=
 =?utf-8?B?NlIzdENESVJXempqMVdNNmNUUjFhb3dJUUZTc1ZhZzdNVEVEU1JKVjRkNHZ4?=
 =?utf-8?B?Nkxrc0tkVDFMRDkwTXZnT01DS1lXak1OOXJCOWRNdUhuS201cWVLakp4MzBn?=
 =?utf-8?B?aUxXY2I1dzA2UXpSUDZhME9HVUtYMEwzWVQ4eWFyZTdqQ0ZLZFNNT2NyUERi?=
 =?utf-8?B?ZWVwUGdWYUNSNyt0Vkw2dWVVazJsMXNTZ0NLSzNNUDA4ODlEa2VIblRkMEdp?=
 =?utf-8?B?OXAvd0hJbTRkVjNjQ2pVQXFiaDgwUUtCY3hMYm5rcHNEeGxWcUZiTTA2WUIr?=
 =?utf-8?B?MGZpaXVKZW5YRXRnV2hyTjFjQjRvMEdFYktCTlh3TGg3UEtNMGh0UWNyMTl2?=
 =?utf-8?B?dkhVQ0l5NWVKaWFHY2pwZDFuVTNtU1FUNE9vOEpTZUJNWlcxOUM2UER5TEhw?=
 =?utf-8?B?aTArL2g2T2l1d3ZWay9RelgwMHBoa0RvMFBxRUVQeVpUV3dNYU9GRU4wZHRj?=
 =?utf-8?B?bHNyM2I3UkRHSS9xNVZEK1V3dXVsUnlaRjVvZTduQWxCSElCbTY4UFprSTFR?=
 =?utf-8?B?NlV2R2Q3YW0xN0lydDJDN0N1ZHlNbzNidlhqOUZKVm1jNndyNkJvSVJYd2ow?=
 =?utf-8?B?WlduSW5YYW9sTzR6R1hvc1JRRGttTkV6L2JUM2d6ZmNhaU1uNEN3Q2tQRld2?=
 =?utf-8?B?bDk2MDNMMHJ1Y1l2TU9JT0FsV2tGOCtkb0VvQWlkaWtPVzJDRW85N3V3YlhJ?=
 =?utf-8?B?ek1VeFBMdGlPLy9zSWRhRTJvQ1Y0R3V3MGVzeXpoc0dvMFN1ZlFVNGZyKzhQ?=
 =?utf-8?B?WXNYa1YrZlExNlpkeXNxZTh6cGQwbDkrbkFVTFIxNE9qaEp4YWJWQ0FkOTZj?=
 =?utf-8?B?QXdsbGlpZVBlN3RrcDFEN1FxZ3Y2U2ptUW00ckNGSG95WHQvMUN6eXczVDh1?=
 =?utf-8?B?TlY2bnRIcnRIZldsb0poWUlodWJzL09jenRyVGZnSCsrK0dENTVwNXlRNnc3?=
 =?utf-8?B?T1M0SUxSQUg5M1p3Z0E1ck9HdmV6bU8wdFN5UmlKOWhkUDE3N2daSlBRTWIr?=
 =?utf-8?B?Rnkxek5PSURiclB5YlJBcjNkZGwrRE9BRkZEcWJyeDRRMTA1cXNzbkpGNk02?=
 =?utf-8?B?WGhWb3J2aWV2ZDIwaElQU2ljZzlkY0ozbnMwTm5GcXhvOW03QmNKSzFxcXE4?=
 =?utf-8?B?VjJ1a2dLOW04TW50VTNwR0F5d2RrRjBDRzdyK0F0R2NEZWNRcVNraFJURzRv?=
 =?utf-8?B?dWEwWXN1TUQzcjdteDNRQ01iV3NSR0craDljTHNxeENGZEdJeExENGNPaC92?=
 =?utf-8?B?YjdXbEsrV3U2eCtnVE9qbU5vN2IvRjlpWlVyNEtqWG9DVCtFTUV6WUI0c3R3?=
 =?utf-8?B?cHczRnI1cXhZUVMxQXpMT0h5MitqUXBXY2E2WC9QTGUvZDU4K2kvT2tlazV6?=
 =?utf-8?B?Y0prNjZkaXEvaXM5WWdJajdFVmxydWVNM0hSY3M0Z2o1Q2FhQi9wbEdWNEhG?=
 =?utf-8?B?RnBaS0h6RDVxb0ErRENSN2ViWm5Fby83Ykppd3cyVmJTQVFZWWJwNmJ3U1dy?=
 =?utf-8?B?UUFRZWpueXhRR3lPazhpR0gxTjdUeFFqZDV2M0x0elNVVmpyS2d0dlBvbEty?=
 =?utf-8?B?VE9jYllsRGF2RG1OeEZkZkhaU3ltYmF6N0RmQjhBRG5vV3FXQ1dZNnRVNDdp?=
 =?utf-8?B?U0tBVFZoeDJIamwxMzQrcmRxck5HMk55eldtT0V6S2RhZ0NkQUVSL1dZbi9x?=
 =?utf-8?B?dlZndW91Um9pWnJXSDhsczl6NjRRYXNLSitQOHRwZ2J0b0hNTWo0TlhUTld4?=
 =?utf-8?Q?oyHV6SU4UuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXdHTDkxRzVSQmNNSzZjTlN3QzVrOVYzcTMydW1wVnVyVytmWG5JNGw5SEhL?=
 =?utf-8?B?cHJCU2hFWDBDQ0FjSFNCS25paWJvOHY2elBoTUhCeFRZVVpjYVVrTGdqZ1BD?=
 =?utf-8?B?OE8rOGJRM3NjbUQzanlxa09ROGFFdk1MbS9rdXBwMWlxbFhEVUhVY1IzcS9N?=
 =?utf-8?B?K3dDVGJXd0QyUDNwZnVkUTBxQVRQd2IydjRIL0JVdW1UdURaQmN2U1hNbEJQ?=
 =?utf-8?B?N2JuWWdzMHEzMjg5MU9mYlJKc0J0U0ZyK0lSUlN2ZXFhR2FiN0lTemdYZ1FW?=
 =?utf-8?B?cmVxWmpnaUovUmNXTi9Dd1NWYjR3V1QvMGdFRnU1cW5xd2c4enNBZllHOXZL?=
 =?utf-8?B?cmhqMkN4S3drSnVVTjNmc2lUWVZKbWVpZGR0c215ZTlrSlIyZWduR1ZuYXBh?=
 =?utf-8?B?NFZYaW1GQzU2VlIyLzE0TXF6QzI0cEcvQ1NXZDE2dElYVjBzaTQ5U1Y0WTVi?=
 =?utf-8?B?Zk1sQ2Z6eGR1OFF5V3dMdjV5c2kyaS9iUWl3YmtkeGdlbitUZGt3ckYxaEND?=
 =?utf-8?B?aHlNaytoWGhpN3llcUd0RlNPSmZicnQ1VUF2Wnl3bEk5Zk9pUEpqUUkvcHVM?=
 =?utf-8?B?VXYxRC8yd2R3eERXdXJ1dytnYWUwdmRHUkRIeVFVcDBacXZqc2Y2dk93RERs?=
 =?utf-8?B?RkNlT21LcmFTU0JNeDhMUWVISDM5Tjd0ZEoyWnlVdjZsU3dpL1luRm1IY3hT?=
 =?utf-8?B?NUIvOGdOU1Z5MEJnYWZVcllEQkhzcmFGUWZCUFozdEJLQ1JXb2lJdGpwRDEz?=
 =?utf-8?B?VExCM05sTmNMZ0Y3RTltbXN1UitEeCs1SjFlbS9UR2gvMVFwREsrRW1ENXdq?=
 =?utf-8?B?WjR3dEMvN3VtNUhDc3dTOGUvTlk5Tll1WnRDS3hFL0FWMnFRdnJNMTUyT0k4?=
 =?utf-8?B?TU1WSE11czE4cVlwMXJmTHZzSGFoT3c1MU9zV3d0bjlCNUc1aS83MXdLaFQr?=
 =?utf-8?B?czFkTjhsYi9MR0R4R1czMy9udk5XV0QvMnJHam5JRHVYdkdCc2lFQ1FuUm0w?=
 =?utf-8?B?bFg1TG41S1NoWGR6VjRqN3V0VlhIWjdXaG5jcEpQQWIvYXlCa3ZqNFk2Nmxv?=
 =?utf-8?B?dENYc2NDUE1tcDVTN3k5R0pJNXFESmpBU1o3a24yZm5YQ0hwU1VsekRxcEFP?=
 =?utf-8?B?aWorZG5mM2RCM3diZzZQOUNBbUhGR0xvMlFhMHpHRm9sdXloZlVqVy90S2Y4?=
 =?utf-8?B?RS9WY0MzYU04WGNob2xXUE9LMEUxeUs5d21sWWlNQUE2T1orUzF0THZlOHk5?=
 =?utf-8?B?SmR6c2FseC9lLzZyZXVEMjgrZXlNaUNpd25kWmYyWlRtR1N3MFRkUWQrSWpB?=
 =?utf-8?B?MHExaHR3YWp4ZkRkRnJlTDgrS0xUcWlnN0NBbnRCWjFSSWRrSWNSUm9VQjVL?=
 =?utf-8?B?NW41K2U5a1NKNDRhYzZvSnVSdnBlWmJpbUs0eTQzRjc1Z3pVMk5LTlVyS1Nv?=
 =?utf-8?B?dThIcHM1UFFuS01uM1RlWmkrbk1FT3pzNjlrMW43RUEySTFDT0ZQMWVvd3M3?=
 =?utf-8?B?enpNOFpaZGc0N0I5VTZ6QUF2WmFTRTlCMWZicjRnWGptaWZZanNqV1J4MFp0?=
 =?utf-8?B?QzB2RFVpbkROTlVuRmxvZGs0TDZWcXRPS3Q3WlZaeHg4OEgvcmpxcXNITm5l?=
 =?utf-8?B?NWFYOG8waXBxTHpzMXZHNDRROWFqSFVuZHJvYXNjYWlud1BPd3VoZXloUGRQ?=
 =?utf-8?B?NC8yWGloRkcvRit6cWV4Q3gxMS94ZGwwa0NCMERCc0tuQWVQQ3l1b3Zjczg2?=
 =?utf-8?B?eUhJQUlwNkpTWkczTHVlTjAwZDlBeTFCZlgweWtDTEs2aDNDQUFPa0p2eEh2?=
 =?utf-8?B?SElFQThHbXhZMWd3K29rVXNjL3hWVmJxekJmOW1zNHFjVTZ5S0kvVnNMY1ly?=
 =?utf-8?B?bHoxUGp2ZkdVaDIzODVxQ2FXYXQ5YmdZNEFFUzBBc3lKT2ZKa0lUc0E5UmRW?=
 =?utf-8?B?b1EyWXJSaGdBL3FYNnhtMVErUXlSTkRBR3hVRVBFSUFQaFdpd2ZIRHZxVE9z?=
 =?utf-8?B?WEpObDhvemYrK2FyWkZYV0ttNGJiZ01XN2RxaVNDTWRIdHZjVUUwSXZEVjdy?=
 =?utf-8?B?c2VTTUwwRUQyVzVIK1FmbnpoYkxLNHJJVUVuQUV0S05iMUJ3Z085RmhEN1Rp?=
 =?utf-8?Q?t+eHE3kjeT+yo1QhSyl44W1jJ?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 735bd34b-488d-4e38-0481-08dde6293a75
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:51:30.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YnUfz2WchVletpmxD8jTuC3qbLKVjs3jMnvHwedRdYwVnkIPoELN8kZFb5ENMQ/eax1+txMVeX01GpSGzm06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1682



On 8/23/25 7:08 PM, Beleswar Padhi wrote:
> The TI K3 AM62 SoCs have multiple programmable remote processors like
> R5F, M4F etc. The TI SDKs for AM62 SoCs offer sample firmwares which
> could be run on these cores to demonstrate an "echo" IPC test. Those
> firmware require certain memory carveouts to be reserved from system
> memory, timers to be reserved, and certain mailbox configurations for
> interrupt based messaging. These configurations could be different for a
> different firmware.
> 
> While DT is not meant for system configurations, at least refactor these
> configurations from board level DTS into a dtsi for now. This dtsi for
> TI IPC firmware is board-independent and can be applied to all boards
> from the same SoC Family. This gets rid of code duplication and allows
> more freedom for users developing custom firmware (or no firmware) to
> utilize system resources better; easily by swapping out this dtsi. To
> maintain backward compatibility, the dtsi is included in all boards.
> 

Reviewed-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am62x
Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am62x

> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v2: Changelog:
> 1. Re-ordered patch from [PATCH 22/33] to [PATCH v2 30/33].
> 
> Link to v1:
> https://lore.kernel.org/all/20250814223839.3256046-23-b-padhi@ti.com/
> 
>   .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 44 +---------------
>   .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 46 +---------------
>   .../boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi  | 52 +++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 34 +-----------
>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 46 +---------------
>   5 files changed, 59 insertions(+), 163 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> index dcd22ff487ec..34b2e8d6bf80 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> @@ -52,18 +52,6 @@ rtos_ipc_memory_region: ipc-memories@9c800000 {
>   			no-map;
>   		};
>   
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0x9cb00000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> -			no-map;
> -		};
> -
>   		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0x9da00000 0x00 0x100000>;
> @@ -245,20 +233,6 @@ cpsw3g_phy1: ethernet-phy@1 {
>   	};
>   };
>   
> -&mailbox0_cluster0 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 0>;
> -		ti,mbox-tx = <1 0 0>;
> -	};
> -
> -	mbox_r5_0: mbox-r5-0 {
> -		ti,mbox-rx = <2 0 0>;
> -		ti,mbox-tx = <3 0 0>;
> -	};
> -};
> -
>   &main_pktdma {
>   	bootph-all;
>   };
> @@ -364,13 +338,6 @@ i2c_som_rtc: rtc@52 {
>   	};
>   };
>   
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
>   &ospi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&ospi0_pins_default>;
> @@ -399,13 +366,4 @@ &sdhci0 {
>   	status = "okay";
>   };
>   
> -&wkup_r5fss0 {
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> -	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> -			<&wkup_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> +#include "k3-am62-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> index 729901b2ca10..e634abe9e8e6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
> @@ -54,18 +54,6 @@ linux,cma {
>   			linux,cma-default;
>   		};
>   
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0x9cb00000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> -			no-map;
> -		};
> -
>   		secure_tfa_ddr: tfa@9e780000 {
>   			reg = <0x00 0x9e780000 0x00 0x80000>;
>   			alignment = <0x1000>;
> @@ -298,20 +286,6 @@ &epwm2 {
>   	pinctrl-0 = <&epwm2_pins_default>;
>   };
>   
> -&mailbox0_cluster0 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 0>;
> -		ti,mbox-tx = <1 0 0>;
> -	};
> -
> -	mbox_r5_0: mbox-r5-0 {
> -		ti,mbox-rx = <2 0 0>;
> -		ti,mbox-tx = <3 0 0>;
> -	};
> -};
> -
>   &main_uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&main_uart0_pins_default>;
> @@ -362,24 +336,6 @@ &main_i2c2 {
>   	status = "okay";
>   };
>   
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0 {
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> -	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> -			<&wkup_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
>   &mcu_pmx0 {
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>   		pinctrl-single,pins = <
> @@ -543,3 +499,5 @@ ldo4_reg: ldo4 {
>   		};
>   	};
>   };
> +
> +#include "k3-am62-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
> new file mode 100644
> index 000000000000..9376ae91a17f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * Device Tree Source for enabling IPC using TI SDK firmware on AM62 SoCs
> + *
> + * Copyright (C) 2021-2025 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +&reserved_memory {
> +	mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0x9cb00000 0x00 0x100000>;
> +		no-map;
> +	};
> +
> +	mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> +		compatible = "shared-dma-pool";
> +		reg = <0x00 0x9cc00000 0x00 0xe00000>;
> +		no-map;
> +	};
> +};
> +
> +&mailbox0_cluster0 {
> +	status = "okay";
> +
> +	mbox_m4_0: mbox-m4-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +
> +	mbox_r5_0: mbox-r5-0 {
> +		ti,mbox-rx = <2 0 0>;
> +		ti,mbox-tx = <3 0 0>;
> +	};
> +};
> +
> +&mcu_m4fss {
> +	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> +	memory-region = <&mcu_m4fss_dma_memory_region>,
> +			<&mcu_m4fss_memory_region>;
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0 {
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +			<&wkup_r5fss0_core0_memory_region>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index fa2c1dc738d6..fd83dbc9f37b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -1334,38 +1334,6 @@ &main_i2c3 {
>   	status = "disabled";
>   };
>   
> -&mailbox0_cluster0 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 0>;
> -		ti,mbox-tx = <1 0 0>;
> -	};
> -
> -	mbox_r5_0: mbox-r5-0 {
> -		ti,mbox-rx = <2 0 0>;
> -		ti,mbox-tx = <3 0 0>;
> -	};
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0 {
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> -	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> -			<&wkup_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
>   /* Verdin CAN_1 */
>   &main_mcan0 {
>   	pinctrl-names = "default";
> @@ -1549,3 +1517,5 @@ &wkup_uart0 {
>   	pinctrl-0 = <&pinctrl_wkup_uart0>;
>   	status = "disabled";
>   };
> +
> +#include "k3-am62-ti-ipc-firmware.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 03b8e246d8c2..ec2685144558 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -58,18 +58,6 @@ linux,cma {
>   			linux,cma-default;
>   		};
>   
> -		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0x9cb00000 0x00 0x100000>;
> -			no-map;
> -		};
> -
> -		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x00 0x9cc00000 0x00 0xe00000>;
> -			no-map;
> -		};
> -
>   		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0x9da00000 0x00 0x100000>;
> @@ -477,38 +465,6 @@ cpsw3g_phy0: ethernet-phy@0 {
>   	};
>   };
>   
> -&mailbox0_cluster0 {
> -	status = "okay";
> -
> -	mbox_m4_0: mbox-m4-0 {
> -		ti,mbox-rx = <0 0 0>;
> -		ti,mbox-tx = <1 0 0>;
> -	};
> -
> -	mbox_r5_0: mbox-r5-0 {
> -		ti,mbox-rx = <2 0 0>;
> -		ti,mbox-tx = <3 0 0>;
> -	};
> -};
> -
> -&mcu_m4fss {
> -	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
> -	memory-region = <&mcu_m4fss_dma_memory_region>,
> -			<&mcu_m4fss_memory_region>;
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0 {
> -	status = "okay";
> -};
> -
> -&wkup_r5fss0_core0 {
> -	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
> -	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> -			<&wkup_r5fss0_core0_memory_region>;
> -	status = "okay";
> -};
> -
>   &usbss0 {
>   	bootph-all;
>   	status = "okay";
> @@ -601,3 +557,5 @@ &epwm1 {
>   	pinctrl-0 = <&main_epwm1_pins_default>;
>   	status = "okay";
>   };
> +
> +#include "k3-am62-ti-ipc-firmware.dtsi"


