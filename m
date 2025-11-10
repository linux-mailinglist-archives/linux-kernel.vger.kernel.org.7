Return-Path: <linux-kernel+bounces-892995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675DC464E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EBC34EBB9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057E30C605;
	Mon, 10 Nov 2025 11:32:56 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023073.outbound.protection.outlook.com [52.101.127.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD83081CD;
	Mon, 10 Nov 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774375; cv=fail; b=Y68h91Uuz/sPxDnWtePnGG4saV/yrtiwfXgXPSEHzKEV5h9heJPaVtmg5xv+ly3BpYKdpHZAIVsC5G/Rx2vj9+qUykv9wQQvKp/O43nGMHXzdab8IfJ2pOmihaiN1Pomz4tzpGJBQTFoKoXBgVI+bxu50fD/Zrc8bS+OhpTd/w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774375; c=relaxed/simple;
	bh=DQxn2A7JddA91LCX0HuTw6C6JAwam4nOR1zzfnisE10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QusU+crc4sAKgOO64A02OX+6mnTV6jYIZOLbkx3ExvpctbbHf+j1imNKUD7c3+7PT2fdoUIuNqgHGZZLO9rIdSvuSQd+AgQxqShdDG+YkBEPrDyWzuH+wZcUjsrhpaprfSf5wktsuYGv/5vEyFBg9OQlTfUMZXUlcDYovbh3Lno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHf5qIuraX+jU3dBXyPP3AcKpw7Ey29Fp25jin8I4AHQngge6o33iN68Loh5xflb+ftcFlcf8I7xWkh3b3zwlqrUFvMeT5OgjyPFlYhhoV3XYTaNybQ7A7S/O6Hos2geNAShJ4CMHwZsENuzUAc+L68nnFXYOTfP7EjlQqA2GUKGJrjjwPEmHc05tGQ+lsVWv8vLNgmWxMS7lH7xc/SxLgT2VDBN0dmfeLX/iAVkNO8/XK4KdlwsanAgl0fCf/AYtpY7NojkAussMFbRByklOtIAV9amLUE2Djd8jJRlaFmNiDlYt8fsPvubEhn4OySn98iWZRnZh5UqR2q9JDXD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQxn2A7JddA91LCX0HuTw6C6JAwam4nOR1zzfnisE10=;
 b=LWv5ocyxMx7BUaIJSi5LKOf+tww2Xiy17AtygvVJ1avhUOWOUtxUIqeyKBIDi6YTGoF2NljgJAY/mDr7sGYQ/+NghQf+4Etk6WnzynqXYCJdGuIMy4JZUz0zXQG/NzjS3HYiOD8ijqdwGX6DIGKDlSJGSSejFzvtP4PzzK55TmaABWfVJNiQxoSCY0CKB28eN7olwSh2+DTxzK+CPHTCwctMd+7b6SLMsz2XFNMrQJarg81y77sbG9I5QkvxYqMfpMT+AD19r/tceeTbne9tBva1XVk+YY7WhCPQfeQnOp3xKxfYHb6xxVRj82kWxS1zuhG9HcLsf6Ti5PB2D5RsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by TY0PR06MB5127.apcprd06.prod.outlook.com (2603:1096:400:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:32:48 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:32:48 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCAyLzNdIFJlc2V0OiBjaXg6IGFkZCBz?=
 =?utf-8?Q?upport_for_cix_sky1_resets?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMi8zXSBSZXNldDogY2l4OiBhZGQgc3VwcG9ydCBm?=
 =?utf-8?Q?or_cix_sky1_resets?=
Thread-Index: AQHcT5f6k32l2FqOtEO23efN98Wr37TmznKAgAS3HTCAAEPDAIAAAIrA
Date: Mon, 10 Nov 2025 11:32:48 +0000
Message-ID:
 <PUZPR06MB588726F24E6193ADD6CF224CEFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
 <20251107033819.587712-3-gary.yang@cixtech.com>
 <69efdb9a-c03a-42f4-a78e-18c8a2b29322@kernel.org>
 <PUZPR06MB58875805D441AF3213189979EFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
 <38e8e068-d06b-41f0-9cae-5dfdf0fcce6f@kernel.org>
In-Reply-To: <38e8e068-d06b-41f0-9cae-5dfdf0fcce6f@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|TY0PR06MB5127:EE_
x-ms-office365-filtering-correlation-id: 60107a40-4f02-48ca-d9f4-08de204ce030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZE4yRlcvcDMxUGpyVnkwUGxCOGFnY2tuVUUrR0Z5d1pHSWpsT1VCc0Y4SlhJ?=
 =?utf-8?B?TWRSNzZLZk50SzU4SzFYQU9vSnBndFpTcitPbzN4emwwNmR6czFJU2RhWlNG?=
 =?utf-8?B?QkZrOHMvVDc5OEx5NG1XaURJc29xT2VicTc5ZlRRY2RkcENEcldPWFZPU2lV?=
 =?utf-8?B?aHNDMUp4dnlVdW5uOHBPcU4zU1QyR2hQaWtzNWJwbGxHcTNEWTNJeWZlTFNy?=
 =?utf-8?B?YnI3SDBXTVluU0xkZlhzd1hrdTd0c1NFMFVRKzJFR0ttLzUxSlJiRU80T2ls?=
 =?utf-8?B?STh4OUdUcitLMmltNFdMMTB0K2lOVFBwMjZnNVJrU2M2bzhjSUw1Vy93d0pz?=
 =?utf-8?B?T3doSUNlY1JHeVVoM1NJbDA5ZTYxMzU0aW53TDVwY0RHTmx5OExNdk4wWC9o?=
 =?utf-8?B?YnhzemsrSGg5ZlZ4ZDJCK1JkSy85L1pkaUhEcDNZUjdtL3ZVeXg5ODN2K2dk?=
 =?utf-8?B?WEplTUwvaEVRTXRuQjNlVURmVUJYSjRrRlE3K3lFZmhGSmNtcGN0ZktSWU9W?=
 =?utf-8?B?OTBuQ0dCaTRPd3o3S3BLbkM3QjhwcW4rZ1NsdVBPMDdjK2RUV2VjZXJ1Y3My?=
 =?utf-8?B?R2lLNUNuUHQ3YThKV1hFSU9PNUZ5ZVBORHI4YzRLWXlaSDhIZnA2YlhtRTNS?=
 =?utf-8?B?T0xUV3JHVWNCZmhYZ1pHSXBnU3FoMFFSTWxLTlNGOHY0OEFZdDRJS2d3RlRZ?=
 =?utf-8?B?bDg5ZktYKzlwR2lFMjduK2F1QVJwVlQ3emtxWmZKak5XcG1UQTF0QmxSaU5S?=
 =?utf-8?B?V1FnS2xzdWo1TXVTbjhGcEtMb1pGM1ZpRUwyajN6YUtIcUc4N0FjRHEvVHdJ?=
 =?utf-8?B?VEYxeS9vcFlJVEt0a1dEWVhhTHZQMEpJT3VSTUM0SEhhK2UwMTBuRUFkZngr?=
 =?utf-8?B?STltWVg4ZUJrK1ZuaDdKR1gzbU1XZXlpaDFXSlVlLzlLb25XdTlERWdYa0FU?=
 =?utf-8?B?eDR1UlZ6bWxVL0oralcvemJPeVRmaFNMUTJuTE1nVlVsdXJpR1FnK0lUdHVT?=
 =?utf-8?B?K3E0WVFpMWVOVlY4Tis2QndIL0crNUphNWdQcVRkY0xDaVZpcWcvVTZpUVJN?=
 =?utf-8?B?RUJxZGNUSEJoOEFQa2taYmoyRkdyMi9XOXR4a0M4dXdMQlhsQ00raXZ3R2lD?=
 =?utf-8?B?OVc5NjJNajhEcFNQZE9wbHJSVjdWTXo1NXNYRElKWExNVlJjc3JJMHBNdlVk?=
 =?utf-8?B?N09yME9FeDNLeHpZNUZxYm5zaStaR2NWbEVERU8zNWVVUVdGeElONXViSTF5?=
 =?utf-8?B?RkUwSXR2UkRHQ1F5aFlTaWxwelRGU0p0V2QxcUhKUlQzNnFPWGtPK0NFaExq?=
 =?utf-8?B?UmdkMVBlcnFWSndWekF6L0prdzlza1I5akwwL3N1cU8rSGdWZHpTS0VLWUE4?=
 =?utf-8?B?U0ROd01sc0poZEMvU2ZmUnhjLzFRZmR5ZDlHajdNSFhBeDY4TTd6dlFQZzdO?=
 =?utf-8?B?Q1VldnhHaWhTQ2YxZmdtZ3pmRVNQU1N6Q1FVS2hkYmNEb3lXQno3OE1RaTNB?=
 =?utf-8?B?ZUUvbnE3NGZwVG9XaDF3RG1FakFGQk4zVkM5UkxIUmZYUDhPZDNQRkZUUWN2?=
 =?utf-8?B?cWRqcS85cGREVDVOdS9IWU9lN1VJVTJJRVAxVGI4VlVsSU5TejBOUkxlem5W?=
 =?utf-8?B?clY0Y2YwZHRSOGVsQXpSOWd0VlY2aVVORmJmNC9tS3poSVNjYzlCb01CVEdn?=
 =?utf-8?B?MEZJYWkxbGFJcGdEdjhTMHpEN3d5bkQ2dWtOcThobk5VL0R2WlpTckNhTHRw?=
 =?utf-8?B?bE91cDNXa2s5bmZ1dmtZbmcxRmRIQ0xVc2xZbk9BZHQ2K0tNdWR5Skg2clBl?=
 =?utf-8?B?SXZSK2M2c1VJZXQ3aXdVODIzbE9PRVl6L2xmVXFoeCtEeWd1MFZQc3NuMDUv?=
 =?utf-8?B?UnVMQThwUUNmcUR0aHpDa09CV2tZb3lva2V3OVl6dStESVJJK3VheGpvczN4?=
 =?utf-8?B?WFBCbkgvS0VHYTIydldHNDdEb2VEK2tTaEoyUDF0LzN5RElJYmlrQzFCL05m?=
 =?utf-8?B?dDA3cTBLZVlCZW1tNWk2MHFpMGdsYWhjY3FNWWJqWWx1bkhHUGdJMEFMR1gr?=
 =?utf-8?Q?SKcG6l?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OW1QcExySE1qaXNobmlSWHdhUWdWRXVBek5wREQxdDdvVjV2Q08zUDliemUy?=
 =?utf-8?B?KytCSlFUbmxPakEvSHVsVFdmTHRQUVR3c1ZFYVYxNG9PdDVXWGVzbnpGaklR?=
 =?utf-8?B?SStBUmpJcXA2VDUzU29iRGV2YllYRU52MEhoeEhFV2I3LzNOV1RpcktVWERs?=
 =?utf-8?B?eWI5UGhHMXVlK25raEFSMFBHdi9zNk4yUE11RVpUV2tLbnFMM0FrMUFXR1JH?=
 =?utf-8?B?ZC8yRnhSQXZ4cWlkTCtIV0lIUmlWTklMYmFOVWYxc2FFa3VDR3lPSjJIZGVw?=
 =?utf-8?B?SWVIZm9mVE1zMkM1V0t0V3RPYVNCSjRtY1dTRERBcDVmekJUTlRNNzJURXBh?=
 =?utf-8?B?QTR1d2FGQUpIc3A1RmZSdFZkNWowaUpJYjRjbHN2U0QrWVUwQ0p0b0FlMUhZ?=
 =?utf-8?B?azdxS0FOaG5KVFljNEYxMHNhMmFpbkhSSGE4a20xeTh1ck5uSll2QkNyT2dm?=
 =?utf-8?B?SnN2NWl1NEhaNEt1aU1LYmNDYWRyeXJ6L20vbHNlYlNkVHptRzVzMHJIM2Mv?=
 =?utf-8?B?ZUVDaHVWLzZZa2RRalR0QzNJT0VSUEtPdjBjeHBNQ3NvU3lmdmozT2c1dUlL?=
 =?utf-8?B?K010b1hod1dHTVdlNm5pdlkybDJYUGQ5dlNqaTE2bXVIWklsUkdyTHl1dytB?=
 =?utf-8?B?VkRPQUNsL3QzaDdpcTRITXpidGpOTkJKcmIyK0YyV2hZa1NHNjlEcTlYckNH?=
 =?utf-8?B?MG5mc0xUbXJLQWRadEZjQ0JvWFFoV0FxblNmRTdOTDdlb0t6MFJVbnVDS09V?=
 =?utf-8?B?bk5Ha29CeFdzalliWDFSZ2tGZndSbVVvdmZhbk9weXpRMDZiY2Z2WkFrK3A5?=
 =?utf-8?B?WEFlYVp2TzViWUNzelNaQzA4a1ZlS1d6dFVvSm5URkxuUnp1WFNoRVZ2b3hV?=
 =?utf-8?B?Wno3T3JHTHBPQVlOYTBEa2NZYi9lc281SDV1VnQ3Qit6bHd6K0FzaHFGRE1s?=
 =?utf-8?B?dnRZT21lUTBXRHNMMG9wbVhYemc2WlNNMDRQdWRJRFBVOG90STVrTWJ6TjU4?=
 =?utf-8?B?WC9QdUxFYTFic3BUenE5aGhRaExia2o0WS8ySGthcWhJeDE2Mk01SWtMY0xU?=
 =?utf-8?B?SWo1VkFkVUdlMWRxdi9aVGF0WmlrYVMrcllDcXJ3VC8wS2txWVovdC9kaGZT?=
 =?utf-8?B?YVliNklweHlBVG9xdTNzbEFVTzVZNGxBYnJBbGJTa0lXaGNNL3pFRmFkdHNZ?=
 =?utf-8?B?TWVBNEFReWw0ZUdhOFZGcUJDdkZnTjYvSTJpcnFWa0plcTJEbmVyY2ZEckx0?=
 =?utf-8?B?ZFFQYzRXdEs1d3dSSEJkaVRwWCtnUkFWZjJZZnlFUDFqYi9KZWFjUitSVEpy?=
 =?utf-8?B?TzQ2SjdQcENHaTl2Y3ZQbHVsaTlOWGo2WnQrelErTmp3T0ljUlFCS2IwVG4w?=
 =?utf-8?B?cUdCMEdOd1dKaVJiSmY3VWdjelNkQWtKT3FwL3IxenQ1NHVzazMrdDVUU24z?=
 =?utf-8?B?QjlKRG1wMG03eitpbktOREJmTE1pMXRFd2lSUElXVTYvbTlFdjB0WVdwS0cx?=
 =?utf-8?B?NkhVT05uZ2ZDc2hzQWNTc2czdlRpNnk0SlJYaHVCQVU3MEpCUU9kRWdUNkhB?=
 =?utf-8?B?MmJ6RG8xMEF3THdWRnpGTGdJS1lTTDNPZXp5cE1PNk91RG9tamVhaHJQYlQw?=
 =?utf-8?B?U3QydHZldnYzejh5WXVncittNEU1MWwzaHhLb1ZGQXBMdGNnYURYUVBMS1R6?=
 =?utf-8?B?dENzZVZtRHRkRWtrZ3lLL3ppMm9acHZZVE5saDBrNUxCK3Y3aThvSVNPUTBY?=
 =?utf-8?B?MXl4QmZXbldvNmxYdDZFVTN6blRxYUlCbGZaMU1hMVVtci9JZkluenE3cVlJ?=
 =?utf-8?B?QXRjSlFlL1RjblU5NGNnYkx5c005aUxGbmp3dUFhUW8vWis1aWhCTDRPVmUw?=
 =?utf-8?B?MHN6ZVVmRlMxVWhic1V3UkNYR1JXOTZjOUlXaGZsQ254TExBMHFoNjJib3Bv?=
 =?utf-8?B?aHhvWXVIa0h0VENDbzJlRUdZYU9lYjVKa21IVWJBQTY4SCtqdWE5LzJRY0FZ?=
 =?utf-8?B?dkRRU1RGRWo0TWNmNm5PL1hldUN6dHVycVZHR01zUjJRZDF6Wjg1QUEyVEFX?=
 =?utf-8?B?NmM1UTdwYlRiMVg2UHFXTm0xaUVaU1F1RTRGWDRrSXN4NWVhR1AwZkh1ZGVa?=
 =?utf-8?Q?/6Hu5Vp6RKaM3ER9/QDU7ntdA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5887.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60107a40-4f02-48ca-d9f4-08de204ce030
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 11:32:48.3858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ux7LkOULhVPeSod79zo4eixuLAor7GTcYfRv9xPJ3BPC2dU39r6g2qt1e3bkzp4ADbLo8+EVgOm4bddM0/fOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5127

SGkga3J6eXN6dG9mOg0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAy
NeW5tDEx5pyIMTDml6UgMTk6MjINCj4g5pS25Lu25Lq6OiBHYXJ5IFlhbmcgPGdhcnkueWFuZ0Bj
aXh0ZWNoLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7DQo+IHJvYmhAa2VybmVsLm9yZzsg
a3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnDQo+IOaKhOmAgTogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY2l4LWtlcm5lbC11cHN0cmVhbQ0K
PiA8Y2l4LWtlcm5lbC11cHN0cmVhbUBjaXh0ZWNoLmNvbT4NCj4g5Li76aKYOiBSZTog5Zue5aSN
OiBbUEFUQ0ggMi8zXSBSZXNldDogY2l4OiBhZGQgc3VwcG9ydCBmb3IgY2l4IHNreTEgcmVzZXRz
DQo+IA0KPiBFWFRFUk5BTCBFTUFJTA0KPiANCj4gT24gMTAvMTEvMjAyNSAxMjoxOCwgR2FyeSBZ
YW5nIHdyb3RlOg0KPiA+Pg0KPiA+Pj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNr
eTFfcmVzZXRfZHJpdmVyID0gew0KPiA+Pj4gKyAgICAgLnByb2JlICA9IHNreTFfcmVzZXRfcHJv
YmUsDQo+ID4+PiArICAgICAuZHJpdmVyID0gew0KPiA+Pj4gKyAgICAgICAgICAgICAubmFtZSAg
ICAgICAgICAgPSBLQlVJTERfTU9ETkFNRSwNCj4gPj4+ICsgICAgICAgICAgICAgLm9mX21hdGNo
X3RhYmxlID0gc2t5MV9yZXNldF9kdF9pZHMsDQo+ID4+PiArICAgICB9LA0KPiA+Pj4gK307DQo+
ID4+PiArc3RhdGljIGludCBfX2luaXQgcmVzZXRfc2t5MV9pbml0KHZvaWQpIHsNCj4gPj4+ICsg
ICAgIHJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnNreTFfcmVzZXRfZHJpdmVyKTsN
Cj4gPj4+ICt9DQo+ID4+PiArc3Vic3lzX2luaXRjYWxsKHJlc2V0X3NreTFfaW5pdCk7DQo+ID4+
DQo+ID4+IFRoaXMgc2hvdWxkIGJlIHJhdGhlciBqdXN0IG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIu
IERvZXMgbm90IGxvb2sgbGlrZQ0KPiA+PiBwYXJ0IG9mIHN1YnN5c3RlbSwgYnV0IGxvb2tzIGxp
a2UgcmVndWxhciBkcml2ZXIuDQo+ID4+DQo+ID4NCj4gPiBTb21lIG1vZHVsZXMgZGVwZW5kIHJl
c2V0IG1vZHVsZS4gV2hlbiBib290IHN5c3RlbSwgdGhlc2UgbW9kdWxlcw0KPiBjYW4ndCBwcm9i
ZSBiZWZvcmUgcmVnaXN0ZXIgcmVzZXQuDQo+IA0KPiBXaGljaCBtb2R1bGVzPyBZb3Ugc3RhdGVt
ZW50IGlzIHNvIGltcHJlY2lzZSB0aGF0IG15IG9ubHkgYW5zd2VyIGlzOg0KPiBzb3JyeSwgZGVm
ZXJyZWQgcHJvYmUgaXMgb2xkIHRoaW5nIG5vdyBhbmQgZXZlcnlvbmUgc2hvdWxkIHVzZSBpdC4N
Cj4gDQo+ID4gVG8gbWFrZSB0aGVzZSBtb2R1bGVzIHByb2JlIGVhcmxpZXIsIHdlIHVzZSBzdWJz
eXNfaW5pdGNhbGwoKSB0bw0KPiA+IGluc3RlYWQgb2YgbW9kdWxlX3BsYXRmb3JtX2RyaXZlcigp
LiBEbyB5b3UgaGF2ZSBiZXR0ZXIgc3VnZ2VzdGlvbnM/DQo+IA0KPiBMb29rIGhvdyBkZWZlcnJl
ZCBwcm9iZSB3b3Jrcy4NCj4gDQoNClllcywgeW91J3JlIHJpZ2h0LiBCdXQgZGVmZXJyZWQgcHJv
YmUgbmVlZHMgdG8gdGFrZSBtb3JlIHRpbWUgb24gYm9vdGluZy4NClRvIG1ha2UgdGhlIGJvb3Qg
ZmFzdGVyLCBiZXR0ZXIgZXhwZXJpZW5jZXMsIHdlIGhhdmUgdG8gdXNlIHN1YnN5c19pbml0Y2Fs
bCgpDQoNCkJlc3Qgd2lzaGVzDQpHYXJ5DQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg==

