Return-Path: <linux-kernel+bounces-660474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F6AC1E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171DCA40122
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F89286419;
	Fri, 23 May 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lLb47M0v"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013032.outbound.protection.outlook.com [40.107.44.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB9198A1A
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988160; cv=fail; b=OzU8Dq/j59YAWtrGZy7z/eTyMiVs5lJrjtEA5VK0BM6Lgg+t5C2xYu8LHZTIlM/ylb9w6qixSNPCAIetpd52LtNhGlKzk0bJ2c1H3vgVQDuxTdUwDiJlRmO7fIK7MWBe1vtI3EFFcnVD+PF57b/TH7LVivPoQCE4G8f6BhYMQPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988160; c=relaxed/simple;
	bh=ddfuejEN6Qt1tAbPnWIj3TGFX8PscmV/aUMQjC8ZpM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwpY1o2abc/P7DvU6SBQdYbmTVGYnZB5L3QnKjHMKIgEueOFkDWOEJgV4+PnLyjEmU9HwECCMGdseH7FEOHNiZ9pXKpJI5UEsGxb8NfCXK0M/V4D+gmOUlHM/SCdhXdRk7KaJ6D/zDVGDAavMRcX17grt98ZmCuQgDVyrTq7XJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lLb47M0v; arc=fail smtp.client-ip=40.107.44.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fULHz4/nifyqpKezuEmrdGyH+wV68KGU8CDQoTAF6sFagbvSQd6LCKijZPJXrvSBcXS28Zf0bYknD+c8v9P0pRW3BP6Y3jyzcPUNwyHtf4qlmiPgszQcbKau0wTi2MqpvurWS5ErNLMb+Nqd8YiSYWjUGYXX9mQEqeKtaRYlzPwDSdXMaPQXSH20ZCCmSfolnIUlD2wKWXNXVnyAh8vhI1e53l3+jOZIbJuSNN+Cfzw887oQLa4E9ffBH4fPU41Uxv8KdurCcpzHTgWKPz3FeFHLhOMFtXIQ9nw4x6Zrh17f5BMUVRibwbYEZENSjGVdV9o6lfBbOI9+0MwKndrSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddfuejEN6Qt1tAbPnWIj3TGFX8PscmV/aUMQjC8ZpM0=;
 b=mj82pTyiKLv+GtssVcfmGxHoU3EzHBRndL3guPuaqUQn4KgBjtL5zV4BEC/fzuDg9aHWlnbmNrq5h+yne3NipoYvC1+W9ogXnTF1j6MCBinRUVhn2UAvUFLBSgassWqBMoeTrcMaGn4bhxBzXb0YFVjY8USTwDhnAXwBm3Dvd4f/bS7ZTj1hOsl3BfqcbAHOdlifAHqIO/Y+Rak+Zw9UBx/o47HQ0XX1bKd2VRAt/nBGkFREfJC6obs6nN0hBxusshlgx6svq1MsuxuRGc81AYWQ2Q5cQx4BN8CKWqC+qAIbxbKW+1PNYV1TbROzOs6p76N+V68QXf3n6JZ1KSKRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddfuejEN6Qt1tAbPnWIj3TGFX8PscmV/aUMQjC8ZpM0=;
 b=lLb47M0vzjKOiFa1/iNzEx8e+11Nk3/XOwt81t+OuB7VJISGASuGRw0IzoYuDpLNGaAF81VwzZmo2C0ll+elX+42bevzoNJBbPcXGE6DqPxpRzJaFLTen8Fkxu8snzNY5RTXq+VvZc133DkEES+/EfGLDzhC5kzPbB+C6Sr7Jidog/GT15rwUQCOgIbHYB+GPdjVzZPdIpDPBlfi52kjnoqFcS+RgfbB8k/RsSz+s6g13mnvNOjosW+J52LsYG1EE+FAzAzUlvYUoRMcjOMO4ipZNVNFWQuLkkTFt393/FSfDT36OPseJz1cdKWZC8AMY7/OiTy0YbdJz8nbmipBNg==
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com (2603:1096:408::90e)
 by TY0PR06MB5660.apcprd06.prod.outlook.com (2603:1096:400:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 08:15:53 +0000
Received: from TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::a0e8:c3a8:8f3f:825c]) by TY1PPF33E28B4E6.apcprd06.prod.outlook.com
 ([fe80::a0e8:c3a8:8f3f:825c%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:15:53 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Chao Yu <chao@kernel.org>, Chunhai Guo <guochunhai@vivo.com>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix missing small discard in fstrim
Thread-Topic: [PATCH 2/2] f2fs: fix missing small discard in fstrim
Thread-Index: AQHbXPyFfMz9pllsAEKjnLK2f7mTm7PfWn0AgAFhV4A=
Date: Fri, 23 May 2025 08:15:53 +0000
Message-ID: <94da033b-1f8e-4509-8cd4-aaf9612a1365@vivo.com>
References: <20250102101310.580277-1-guochunhai@vivo.com>
 <20250102101310.580277-2-guochunhai@vivo.com>
 <e73ac805-b51e-4457-9f7d-7d3feaff32d8@kernel.org>
In-Reply-To: <e73ac805-b51e-4457-9f7d-7d3feaff32d8@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PPF33E28B4E6:EE_|TY0PR06MB5660:EE_
x-ms-office365-filtering-correlation-id: e82e59a6-5428-4807-9764-08dd99d2096f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MFhQSHM5S3Q2NkkwWE5pTXFtZVZGQVhwMTgrNlg1RElKRFBVbnc1WWlNVHlH?=
 =?utf-8?B?LzZNcUJkOVhQWEJpV0JUb1ppRENQcytBZjVYb21BYlRxZG5wZWVNaGxPclpm?=
 =?utf-8?B?S09xbHVvNDZkbEdIYW93SzQ2dEV3b3lCVy9rYXkyUHBhaTBCM3FLOWwzZHFq?=
 =?utf-8?B?UVFQenQrYlJxRVV1QjRUMGdmcEZKV1R5Y1FlczFCSnN3OEdWZzNtZ096amsx?=
 =?utf-8?B?Qm80c2FnOGxESndEUWp3V0czNno2cFk1V2ZwblNRVjB6dWFkZTY2N1dkbjBh?=
 =?utf-8?B?TXBQSDQ5cXZpR0paaFUzVW9Bdld6cWk0Y05xZXhrVU1uWm40aXppQm4rVXEz?=
 =?utf-8?B?OHRMdTJGUTQveVJ6SHFDeElONWJRajVjL3VHNGRKbVhxbGlrWXcwemNGMmVT?=
 =?utf-8?B?bjRFek00c0JJUlNMZWdyVk01VzhLb2xFT1V3Y1E3NlpvaVdtSzFjWmtTbmJM?=
 =?utf-8?B?NjNvdmdiTEZvcXp6MFdsSldFdlJEcU9ZK2JuQWlteDA5UmN0VnFNZ2RUQ1BB?=
 =?utf-8?B?OG5Ta1RBV3VDL09EdFdBQ08rT0RQaDJpVUFTVmF5a09lSmtRRzJoeHNMYWNG?=
 =?utf-8?B?eTlaeUJGa2tOS1Z0RGtFc2pLRmhuNmFpdy9OMENYQmdsb1RSZzE3YVZTOXhm?=
 =?utf-8?B?RDZsUEZUS3pZSC9vRVdhaExFTmZvdFFNdXZwZUd3bGt0SkUwSWM3ZmM1Nm1T?=
 =?utf-8?B?enJUUlhOdjZoamU1cmUxQU9DN3JaTnF4eVZSZmQrdDdRNnBQeDd0SjRreklt?=
 =?utf-8?B?dDU2Sll2VVRWZ0tjcVlNeWpNSGplOXpYRVFvcGlrZ2xTbmtOTWZGL0xHTWhZ?=
 =?utf-8?B?WTRTcU1NcnpGbk84VERCUjVhTVRlZHJ5OWIzYnBqRFd3a2xJeFlQODZ6SHFX?=
 =?utf-8?B?dmh2ZmF4dTNyOVllR2xXejUrRGo5ODFaOCtQYkpQVFprOTVCUGd3cXNzU0pB?=
 =?utf-8?B?RHFSSVRiZWdWMkRkY2lnUWN3aG0wRGcwdmpHN0x6eUlBeXI3NGwra0VzTWk2?=
 =?utf-8?B?UTlwRnphS2tHa3dyVitKSFpNdElUZmNnaHA4YlNIcjBoQmd2ek9qR2RyMXEr?=
 =?utf-8?B?QnJETkFUcWNUSU0wWE9ieTJJYXFwNkF1bXJaMDlVemlpWHFVTndPM3psUjBB?=
 =?utf-8?B?QjN2bU1hTlNNMGRkL2xrM2VCZkkvOEtKVkxBbEk4VEVoc0xoNFB4K1pvdzl6?=
 =?utf-8?B?eCtDa1paa1l3L3hBSExac09INERjRjFqWjlrNk1jU0VOOGdSQm9TR2o4UUQ1?=
 =?utf-8?B?RzQ4aUZMcmQ4eGdPN1ZJUERtT3VYSk1rYmJjVWc0NVNSRzgxaG9rS1Fjcnpo?=
 =?utf-8?B?T0dyb0dGdzh2dHhLMmJqRHZDZERwaFVnaFJQcVgzcnFpTE8yeXFEU3BiYm1Z?=
 =?utf-8?B?a3dQL3diZGpqR3FLb0p4eGVMMGtuVzVERkhWeXZCRVllbkMweHlTZXlMN21N?=
 =?utf-8?B?SC9iSnY1RmRKN2doQzNRN1crV2llQ2c1Wm1Wd3FXNkQ0dVp1WjJmQ0MvODUx?=
 =?utf-8?B?SEVZTWtVeWFnbHdHNDF3SmZvN1dwWGxWUzFKNjNkazkzeEZLVE1pYVdsNkl5?=
 =?utf-8?B?bGdHWGdRR0VKZFFNeVF6RDZ6eS9FbjlZbUpWTHcvbjBtN3RoRzhhRGRPUHUy?=
 =?utf-8?B?aVlxSEppdU5KRjVXaWs1NTZXMnU0TkhYTFlsRDhYdlhuMFl0ejlkdU8vb2wy?=
 =?utf-8?B?TitVTDlPTnBXekVqV1RmeUNGQmpaa3ZBaERUN2VUTXAvNDU0R0UvQ1ZQTWw0?=
 =?utf-8?B?dzRSbE9rQjJVSmIxd3IwbmUxbkkrZURpQlpWbkpaTGZweGRZMnhqRkRGK0Vw?=
 =?utf-8?B?d3pySmtTMnM2NjI4OWdBZVBSdGxQS3U5TElmRm00WjdhUnliZ3RXUWIxRHl3?=
 =?utf-8?B?YlUyRXh0MXh4TXk5R2RtWHlEbVdsUnpCTjIxb1pqTHNSSzlYb0tMTy9zUzcz?=
 =?utf-8?B?MURtOUlWL2QzenMvYTRveGRzV0JWQjBUdWpHeGFkREFpMUFOMG9mWlRXQUV1?=
 =?utf-8?Q?Z1Jy/PXFKblt+cCUgSfc9A0T1fcY1k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PPF33E28B4E6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YnJaZmhzMzMwMk9Md1FKQkhZZm1kV1BONGxUR1BGbkhyNURkYlpjcEhRQnRO?=
 =?utf-8?B?WWI3QWNSaU0xeVBHU01CUnJQL21pamUzN0dpUHBVSEozcGFLOWJPaE1kUHVv?=
 =?utf-8?B?M1ExWkR4QzBsM0MyallZd2gzRUZ2Z1dxUG9NNFF1cVFlSW1sdVhjNjgwNVlU?=
 =?utf-8?B?QkphUGJXUHB3NU1kWFlPaVp4OEliUUs2WktDc2Y2VWJVTTJBUW9BV3lLMTM2?=
 =?utf-8?B?WXI1OTlVbXBTbWR6L2ZtdmMxc2R5Ti9McnNVbmhOQzhleVh5UUhmRWtRdjRS?=
 =?utf-8?B?Ni9RVlpKemZPeFo4L1pEZ3dwL00vMS9jNDQ3VC9qUTFHcVFaSjJrV3dYYjFZ?=
 =?utf-8?B?RlVvZmF5MWluelFPUlROZGlZRjV6YkFxTXdyczZsYndRak1NYStDSHFUZWMy?=
 =?utf-8?B?aGx3ZU9mM1VjZ3ZtV01nK0NnR3VsM245TGIwN0RkR3JFUlFuWVBiK1gvR1c4?=
 =?utf-8?B?M3NkNGV6eGlNS0JUSDU3ZlYybHRlbzJXY2UrbnhhcHdoa3dlOThYd21xNzdi?=
 =?utf-8?B?cldkc255eEdhL0NEVGR1ZnIxdW1Pdk8yaEdkdTVVMi96eHcvYlF6MUJ0WEpm?=
 =?utf-8?B?RnU1ekNKRlpDSzZUR2xZcDFKb3BlOC9iamVYOWl5UzB5Ukhaem5sajZXQjFP?=
 =?utf-8?B?am1vQ2xCTlgrU0NuTGc0MG14ZWFWSkZYOCtYeW1xM3ZONk43K2RTYnZFRFdo?=
 =?utf-8?B?OU1CcStsSFl3WGJVcndYbXlGQXpjRnZJcXdmTXRXa3BibWlxNDJUQjE0ZXZD?=
 =?utf-8?B?WEFPdDhGdTRXTHhxSlNMN0YvanFXM2t1bE5mTmdwQWJSU0pXUHY5NFVWMkF3?=
 =?utf-8?B?QkJDa20zeU95bVlYSlR6WGtxcEVGMCt2NUV4Z3N5VTJRLzZRbWpVNkdxZ0Jv?=
 =?utf-8?B?VWw1QTVaUmM3Y3ZXUmRUUXpoajJ0dVFQRExUcW15enRlU1NyNFEyVnk4M0tl?=
 =?utf-8?B?ZzVvZzNMK2hFWE5SajFQcXZsanAxKzExOCtPVlZ1blFsbEpQSGs1T01zQm90?=
 =?utf-8?B?dTlhcEF4a2RwSkZxS2g3djgwZ3k3MmYzTlJ4a1FLYU1HQS9ObkhuWU1SclFC?=
 =?utf-8?B?K3RQQlgzTWRTNEZlWUVDRWNDQlBCMDFUckZLRG5DWkNWelJGU3MxYmZBR1Zt?=
 =?utf-8?B?NGZQbVNvQlZ6VW5Gc29IVHJRbmpvbXZyS2VCQVNIVWN4alhHeE4rTml1OWM3?=
 =?utf-8?B?YzJMUWNTOXBMU25MNXJGTXZkTnBlS3FNa3dXSzI0aTBuTnF5WDhGVnZyRWlw?=
 =?utf-8?B?SmxxQkEzbS9nWmNMdjNjVTdMZGpIQ1ByMUs0dlFONjF6SE9YbmxhVi9FVnFk?=
 =?utf-8?B?amdMcXRZVkZEUE05WTZLV1JNM2NrV3R3WitZeXpNbDNWRjVmcUFiVW1oNll5?=
 =?utf-8?B?VEs0c2NNdDZ3SzF1eEg1Yi9TRGVkSVJuaCtmNW43VVZRc05rczJpaStUN1Ft?=
 =?utf-8?B?N0dnRitBeDk0WEhaMVFlN2tFbXMrZUp5OTlHQitqdHZxK25EbGpDbEJIZG9o?=
 =?utf-8?B?b1VJU2tldWduY1FIQ0xJempobUU2K1dYVG5tK0kyNGlCZkNTOVd3WngwSnh3?=
 =?utf-8?B?dVRSWFNhRFRoZGxsRExzblA3eVRYbnRMS0tTc1htMGVZRmpaUU5FeEFXUWVE?=
 =?utf-8?B?L0g0TDNBb3E2V0JQRTE3WXZiV25ZN2lUV2RLR2NlbjFScGQzNFBRdnZqcGxi?=
 =?utf-8?B?K1pEampQbjdmcEh2WFd4Z2RuV2VSWmFvQnJ5Rk5FL0NnYWJmR3ovc2I4UUtQ?=
 =?utf-8?B?OTJkUXhVR3pjcnJDZXc5QlROdHFWUE5Bdi9RbFdwTS9sV2puWEYwVjJSL3Bx?=
 =?utf-8?B?YUVYbW45TUtKR2gyTERLWTVLbUJZaE5QMFpBWGxGdUlCb2R5aGNqc0pkT0xv?=
 =?utf-8?B?enBFNWg0V2cwUjY0WDBPZFVLNUZ6VWFvTWN2TVBoVmI1bzd0eFZpN3pHTkJ3?=
 =?utf-8?B?WGRkV3FGSkdpY2lZRTBTdFZSb0xYcS9vMGhQRFZpWlhKQVNKcyt6TmRWTVBz?=
 =?utf-8?B?NW92NHFTRnRnMGRmWGdrVVNUQzlIa0RoR292cXc4SFhlQnphNHBDcWlsQW1H?=
 =?utf-8?B?OW5ockt5bGFneEF6ZHZHZmdtTWd2blVISlRIZDlIV0JQa3c5VVpOTEpYVG9C?=
 =?utf-8?Q?GSmg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B00BF9C90D973640B79E17190ED42D26@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PPF33E28B4E6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82e59a6-5428-4807-9764-08dd99d2096f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:15:53.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBTU5LXeX2QkvqaX315d4x652XT/rM95BLcxHRJ+KERP1gfIH+/6M/GFU+/so4IYokLn7REKvjdgioQ4yNU3Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5660

5ZyoIDUvMjIvMjAyNSA3OjExIFBNLCBDaGFvIFl1IOWGmemBkzoNCj4gT24gMS8yLzI1IDE4OjEz
LCBDaHVuaGFpIEd1byB3cm90ZToNCj4+IElmIHVzZXJzcGFjZSBpc3N1ZXMgYW4gZnN0cmltIHdp
dGggYSByYW5nZSB0aGF0IGRvZXMgbm90IGluY2x1ZGUgYWxsDQo+PiBzZWdtZW50cyB3aXRoIHNt
YWxsIGRpc2NhcmRzLCB0aGVzZSBzZWdtZW50cyB3aWxsIGJlIHJldXNlZCB3aXRob3V0IGJlaW5n
DQo+PiBkaXNjYXJkZWQuIFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBpc3N1ZS4NCj4+IFRoaXMgcGF0
Y2ggaXMgc29tZXdoYXQgc2ltaWxhciB0byBjb21taXQgNjUwZDNjNGU1NmUxICgiZjJmczogZml4
IGEgbWlzc2luZw0KPj4gZGlzY2FyZCBwcmVmcmVlIHNlZ21lbnRzIikuDQo+IEkgZ3Vlc3MgaXQn
cyBiZXR0ZXIgdG8gdXBkYXRlIGNvbW1pdCBtZXNzYWdlIGFzIHdlIGRpc2N1c3NlZD8NCg0KT0su
IEkgd2lsbCB1cGRhdGUgdGhpcyBtZXNzYWdlLg0KDQo+DQo+PiBGaXhlczogZDdiYzI0ODRiOGQ0
ICgiZjJmczogZml4IHNtYWxsIGRpc2NhcmRzIG5vdCB0byBpc3N1ZSByZWR1bmRhbnRseSIpDQo+
PiBTaWduZWQtb2ZmLWJ5OiBDaHVuaGFpIEd1byA8Z3VvY2h1bmhhaUB2aXZvLmNvbT4NCj4+IC0t
LQ0KPj4gICBmcy9mMmZzL3NlZ21lbnQuYyB8IDEwICsrKysrKystLS0NCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZnMvZjJmcy9zZWdtZW50LmMgYi9mcy9mMmZzL3NlZ21lbnQuYw0KPj4gaW5kZXggOGZlOWY3
OTRiNTgxLi5hZjlhNjI1OTFjNDkgMTAwNjQ0DQo+PiAtLS0gYS9mcy9mMmZzL3NlZ21lbnQuYw0K
Pj4gKysrIGIvZnMvZjJmcy9zZWdtZW50LmMNCj4+IEBAIC00NTUyLDYgKzQ1NTIsOCBAQCB2b2lk
IGYyZnNfZmx1c2hfc2l0X2VudHJpZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBzdHJ1Y3Qg
Y3BfY29udHJvbCAqY3BjKQ0KPj4gICAJc3RydWN0IGxpc3RfaGVhZCAqaGVhZCA9ICZTTV9JKHNi
aSktPnNpdF9lbnRyeV9zZXQ7DQo+PiAgIAlib29sIHRvX2pvdXJuYWwgPSAhaXNfc2JpX2ZsYWdf
c2V0KHNiaSwgU0JJX0lTX1JFU0laRUZTKTsNCj4+ICAgCXN0cnVjdCBzZWdfZW50cnkgKnNlOw0K
Pj4gKwlib29sIGZvcmNlID0gKGNwYy0+cmVhc29uICYgQ1BfRElTQ0FSRCk7DQo+PiArCV9fdTY0
IHRyaW1fc3RhcnQgPSBjcGMtPnRyaW1fc3RhcnQ7DQo+PiAgIA0KPj4gICAJZG93bl93cml0ZSgm
c2l0X2ktPnNlbnRyeV9sb2NrKTsNCj4+ICAgDQo+PiBAQCAtNDYwOSw3ICs0NjExLDkgQEAgdm9p
ZCBmMmZzX2ZsdXNoX3NpdF9lbnRyaWVzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgc3RydWN0
IGNwX2NvbnRyb2wgKmNwYykNCj4+ICAgI2VuZGlmDQo+PiAgIA0KPj4gICAJCQkvKiBhZGQgZGlz
Y2FyZCBjYW5kaWRhdGVzICovDQo+PiAtCQkJaWYgKCEoY3BjLT5yZWFzb24gJiBDUF9ESVNDQVJE
KSkgew0KPj4gKwkJCWlmICghZm9yY2UgfHwgKGZvcmNlICYmDQo+IGlmICghZm9yY2UgfHwgKGYy
ZnNfcmVhbHRpbWVfZGlzY2FyZF9lbmFibGUoKSAmJg0KPiAJCShzZWdubyA8IHRyaW1fc3RhcnQg
fHwgc2Vnbm8gPiB0cmltX2VuZCkpKQ0KDQoNClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBv
dXQuIEl0IGluZGVlZCBsYWNrcyB0aGUgaGFuZGxpbmcgb2YgDQpyZWFsdGltZSBkaXNjYXJkLiBJ
IHdpbGwgc3VibWl0IGEgVjIgcGF0Y2ggdG8gYWRkcmVzcyBpdC4NCg0KVGhhbmtzLA0KDQo+DQo+
IFRoYW5rcywNCj4NCj4+ICsJCQkJCShzZWdubyA8IHRyaW1fc3RhcnQgfHwNCj4+ICsJCQkJCSBz
ZWdubyA+IGNwYy0+dHJpbV9lbmQpKSkgew0KPj4gICAJCQkJY3BjLT50cmltX3N0YXJ0ID0gc2Vn
bm87DQo+PiAgIAkJCQlhZGRfZGlzY2FyZF9hZGRycyhzYmksIGNwYywgZmFsc2UsIGZhbHNlKTsN
Cj4+ICAgCQkJfQ0KPj4gQEAgLTQ2NDksOCArNDY1Myw4IEBAIHZvaWQgZjJmc19mbHVzaF9zaXRf
ZW50cmllcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIHN0cnVjdCBjcF9jb250cm9sICpjcGMp
DQo+PiAgIAlmMmZzX2J1Z19vbihzYmksICFsaXN0X2VtcHR5KGhlYWQpKTsNCj4+ICAgCWYyZnNf
YnVnX29uKHNiaSwgc2l0X2ktPmRpcnR5X3NlbnRyaWVzKTsNCj4+ICAgb3V0Og0KPj4gLQlpZiAo
Y3BjLT5yZWFzb24gJiBDUF9ESVNDQVJEKSB7DQo+PiAtCQlfX3U2NCB0cmltX3N0YXJ0ID0gY3Bj
LT50cmltX3N0YXJ0Ow0KPj4gKwlpZiAoZm9yY2UpIHsNCj4+ICsJCWNwYy0+dHJpbV9zdGFydCA9
IHRyaW1fc3RhcnQ7DQo+PiAgIA0KPj4gICAJCWZvciAoOyBjcGMtPnRyaW1fc3RhcnQgPD0gY3Bj
LT50cmltX2VuZDsgY3BjLT50cmltX3N0YXJ0KyspDQo+PiAgIAkJCWFkZF9kaXNjYXJkX2FkZHJz
KHNiaSwgY3BjLCB0cnVlLCBmYWxzZSk7DQoNCg0K

