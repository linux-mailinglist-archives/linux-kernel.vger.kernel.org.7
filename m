Return-Path: <linux-kernel+bounces-747622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D3FB135FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F9A3B7E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552F821D5B5;
	Mon, 28 Jul 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ENI/qWQm"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013062.outbound.protection.outlook.com [40.107.44.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7841E5B60
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689847; cv=fail; b=rNcnusTFVrS9Ba+o2ZG0zmaPfeqaEB4uo2lv0sau6irTXilj3j+erSYIHJIUYyb3O7l1+x6LyOMxe1b6AnIAM//Qxj/V7v1awI8QSG7LZi7atWgRkfpPU8Kbd/D/K3rTUOzgotvcmjHdkHyZ5w0ODOAPHPDWRhXz85kFxyMS0cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689847; c=relaxed/simple;
	bh=OeW3ELgzPPMNzA/S65OCEGMwoFU1nOW+YaE2k7Ip6xA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFsMsUgi7bVSrKGVCK9/YPNjGchwXhgfinVb15OG7HIt5Sm2hblZP1XhG3hVYtqMeuNm9pgOu6gWoSmx0WosCoHJ3VGyiSPsKrQHTz4ScTH2KNgRqTZFSTBRNctocwOm9fZRcvRC/i5zOOQBW/Z3xegYasYlhz6cbR04pcZ7mPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ENI/qWQm; arc=fail smtp.client-ip=40.107.44.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI9Shlk3Ln+ldwyRhKUAjSCKObnc6AWAVV9yD/Nkf3cks/q9KOen8wc25AEqL6zG+pIja6H/6ipV6JQ1Li+WLLgYUKYrguUwX4W3eL11U3uNLhQiFnt+SYAq5NsuKq8Dv09ftV886As2guMDE82dvqTA+hrXYmtlgDEMBLSBMX9Fzz3Zz8nH1dfySwysV/A/7kgi3LmPUz3ne3e1GloPE210nAx3+PA8OZIW+11IMAq/tIrBmR1dO4UdWjcxctq7+J7iPQi+K+SWVFRm+1/iVx4NbxpJuFBCb2SgLqTca5Ju1bF4qPwX63ckpDsjwKdaEMP37iNJfP36kSiJQBn8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5aqHN5ufwwbUWsWb9ve3PQ+yLeaORd6Tqcodbbqe50=;
 b=jREPRdJ5zs4cgkrZHCQrCv7Aay0G0uSPeECKkYs8/w/oZSatRP4zKoWcb+knczG32i7iRDhNbAV1Nn3Fcs8Xt7O9UafJC7b2Nkz7qSxTEhiFD9VJ2merOqVju1AXswzlLtQ4m/ZUPHziFL+2Bnax59O9OWWFhoYyprxunsGbPoyzG57LR+hH+hHPLsYNjf5McjwBVeE0rqBIjMYpfDHwkSnOsH5CBzdzO4eFr9WoSb5kZPvcq5HISTGWn7ue3VwA9tMUGxXekSv7Tuv/wplrjJ44THL+8Y2x7IQLRrlgdW8AdR947K3d08FPIcHSRa99hhQjcd9LfHtkAFqZGKVOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5aqHN5ufwwbUWsWb9ve3PQ+yLeaORd6Tqcodbbqe50=;
 b=ENI/qWQmLQYL6iaBHwMywOAJJHhKrvuQ51CMlsKA0fI3MUoFSV837S+bFJr7/S8olFaaG7aShMdPXyyCD7+eYSkOmDFsos/PnmGquxA/3aPBTMTAGtdHIr4I1GD/8ZwiBCwp+sFN013x0HsEHmDkKraSWsHSDtslZrl8hakwPqjNQ+VAiSnaZeNopbFlmcjjLt5uFanc37EZpPl5Ga5Ky6kKzMWLOxgTVvshbLpBZ02dCqG3KF9USs2AjQXr/17zYlQUDO/vFhqEbUmNv2SdfOWrSSQSNqUPxD+8ZIdfHueNSc12IsKp2KE8mylWG/z3jHytCA1ardnSOEx2Hdjy7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by SEZPR06MB7240.apcprd06.prod.outlook.com (2603:1096:101:22b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:03:59 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:03:58 +0000
Message-ID: <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
Date: Mon, 28 Jul 2025 16:03:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: axboe@kernel.dk, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|SEZPR06MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 1448eef5-9ce5-4c1a-7ce1-08ddcdad4d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHcwYmkyUUhMK1ZWNHhYSGdUYW1OMEhraEg4bmNWS0huMVlyY2JPOEZQSEMw?=
 =?utf-8?B?ejB2TTg5QW5UZzNOK2pTRDdORGhNV3RNQlZCdmRieFMrR3ZIMnN4T2FjVW1E?=
 =?utf-8?B?bU13cGNIQlFwU3NLN2pTQ3haakc4VzkxalBNSW9kU3ZhL1pCZ3ZFaG9OdFRj?=
 =?utf-8?B?MlYwblBob25QU3BDZnF6bW9wSDl3MDBLTi9HZ3BWMS9WNXYvNmt6c1pzWnpN?=
 =?utf-8?B?b3hUWnFMNVYrRzJQaTl2eWVHOW1qeFpRSU5lYzB4bkh2YlI1dURRVFVjWXpr?=
 =?utf-8?B?OUUzUmRQclBxUWtaWFRHMEQrTEZ2K3AyTy8zVVF1VTNBZmNHd25XWFI4QzBj?=
 =?utf-8?B?UUVaKzBKOFpwejRwNVhOQ2E2aXY1U2ZMd0Y2RHh0NUZOVGNSVjNubDFoTWNK?=
 =?utf-8?B?aDBMYXl3d29XR2RMQTlHTVJMbXpvVjlhbWh5d0N0VEdmSnVlbUNyY2tqUWFC?=
 =?utf-8?B?encvUXF1emRYWjRVL1Y5bWRoUTRxMUxiV0pUSnFPM3JLZ0VIa0I1ZHlqN0gy?=
 =?utf-8?B?Z20xSWhiNy85TW9lS1R6bWNQdGVTZkdGeXJWY0l4Yzg2dmRxNmlPTFVyS0Yz?=
 =?utf-8?B?NUgrdk5QSVExMG5UV3c1V0pXWTIvMnFWN2wveG1XMUhKNThYdXpRak1Ga2ZI?=
 =?utf-8?B?cUNmQmw3THl4WFdVYk5ZZTVnWGFBNnozSGlINU80QlY1SFM2Wnp4bGVZWS9u?=
 =?utf-8?B?aHNwSzJIZllZc0lVZFRBYWowbE5JZDZZWkg1ZzNqN0o4b0hhT1B6Rk9XN3BZ?=
 =?utf-8?B?UWdKVnpLcnl1K3hTQ0V3ekdhb2tuRHdqTU00cnhqaEE1M25JVHMzaitlVC9q?=
 =?utf-8?B?M1VxdFlsVkRzclByS2pJdzRVd3F5aHFCbkdXTnJSY1R0WklVbmgvNWxvU1NL?=
 =?utf-8?B?cEdzcmpTb1BKVXROTzQ5QUg4VU5QRzFTWXhjK3VjRnR2ODJqUmJrTlAvR3Y2?=
 =?utf-8?B?eC8yUlQwUDFZeDBvYy9GSGhaYmtraXM2bGMzUGIzU081azhBcWVwUzBQWmUy?=
 =?utf-8?B?aTgvYnZYZ3dkU3RqZ25EMGpVV3h0RzhsR09MSXBFZzNKQzdsWWNwc2FldVFs?=
 =?utf-8?B?Q2pPSElvR2ozbWFtS0pzc0NiMnMreFVjSiticlZCT29YcThMclo0RE5DaGQw?=
 =?utf-8?B?bWloV1dXVXRSOVREN1k2dlI1Mm41VHorZ0tPUHk1Si9PdlZLcW04Wm5rSzhC?=
 =?utf-8?B?WlQyYjM2akE5bkI5K0Y1RFpOVXdKY2xxYWcvUDl6M3k2a0prb2ZxekI5NmJP?=
 =?utf-8?B?SC9NTHlGbzZXbDZQNWxaYWkyT2x3OTBxbUt2QzZCM3lrQXY0UkNKUDNuUWh0?=
 =?utf-8?B?WHh4d0Jna05VTzdBWkppdG9pWWxEUUxYOTMzaHBaSWVXVUtvZm1ZQ0RRNDRu?=
 =?utf-8?B?ckJDcisrOFVEV3YvNmNidXcyVGVkUDQ0ZkE4UlZxMXRNZUkwN2ttalVBUUQw?=
 =?utf-8?B?Mng5elB6MFZObE1qeXdxWXVtdjZBWkNYZnZCM2lsN1FRdEhneFpLTldnQktz?=
 =?utf-8?B?RStEN2V6eU1JOGFJbk42Zmk4UnhqR0YyNmlNK0tSZVNBazR6dTdjc3JtSUVL?=
 =?utf-8?B?TkVNbk5FS1laWGIrSXlDYjhCdmQ4ZnMrQkNzQkhYTHZZUVEvTlBuWW9hZXZy?=
 =?utf-8?B?cUk0VG45aVJFaUVmR2hRVjd3dG9QZ253cUFEdVhzNG1QbmtwbzB3SWhOb3ow?=
 =?utf-8?B?aVF4dkF1Qy9saXdJUVo5cDMzVWgwbE9Md3Uzamk5bW5ESGltQjlXUmw4VktE?=
 =?utf-8?B?aXptb2lYUVVPRzJKV201U0YzTk52Qzl5MkpyZHNQZnBwYm1HZWNqSTdVU2ZL?=
 =?utf-8?Q?Wlmz1mFzV38W7FRH5esd6oWxYlgPTmBBfcGMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2xCL1gremNyL0Ftdkx1aFd2YlBjWHMrNGp2amp6eVhsM0tpMWVWZEdEWXFh?=
 =?utf-8?B?ZXRrTE5iZDZkYlZEaG5yN0tQemlnRVNPWERsUTBOUElZdTR6OEZEMFpaN2ZV?=
 =?utf-8?B?OHZURkx2aGVLWlVTbmJJWDNaS0l4Yko0czVGdytZMWRKMHVHNUdHRHJsRFdS?=
 =?utf-8?B?WDM1WTVvR3I4TklMejVzMlV6YzRWSHdyWjB0dzl2S3kyamJuUGExTFVIT1oy?=
 =?utf-8?B?cVZHd2lTR2IrNmQvWlJMTGVIbmEzRnJUTmJsMnpMLzhRU2JwMENnbzNNb09o?=
 =?utf-8?B?Yis1THVnOGtGaXg2b0x2dXhqbkNFVlpaeWZqb21jZzV5SWJNRTBBcEgzcVFa?=
 =?utf-8?B?VUVRcTRnUUpsOWJsa3JoWXI2UUNtYkM0T2ZPY1VzZVhsbGpoZ1YzMTJ5Sm94?=
 =?utf-8?B?N0E1eGZOcG5qZzA4dFBNcVdaR3RMY0NWVE5mcm1EV3o4Vm5ub2g1L2NkcUxx?=
 =?utf-8?B?R3A4K3VCZFZ0bHZ4TXRGUUt6N3AvQ2d0cGErY1RmbE9KYm9DM0U0RTlFWVpm?=
 =?utf-8?B?Y01ZOVVwWllrODRiU3prM2VaZk8ydUFEY0ZjUTRGL0NoMUU4S1c4V1ljbmJn?=
 =?utf-8?B?bUFYR1Jtdi96dVJ6dStWUUhSTTlSQ1dZaUROa3g3WHZGbjJ3MkFPYTJjVng2?=
 =?utf-8?B?blFrWjZaSFJ6ZVJjVmJwOWdWZE80dU5RR1ZiMXFoZnlNU00vcHhSSnZ6dEY5?=
 =?utf-8?B?Ympqd25kVDUyelB4L08rRmx1cGt6ZWswczVPcDRKOWFmeXFWQnNoL0NMc1hB?=
 =?utf-8?B?dFhUMEhGUlgyVlkweWtVS2M0ZGJXZjZZMkdxWDBFUWF0ZG5neXMzYVBxUW1s?=
 =?utf-8?B?bUtsZURyMUcyZ09WTnVXUkEvRkI2V1orSVN5aWJMOGlzMFdFdWpEY2R4a0ZK?=
 =?utf-8?B?QXkwQnpubU5sNkZjT1poNU1mYTVIYmVNb2xMRllGU2U4ZEFYN2lJbjdpK0gz?=
 =?utf-8?B?V3JZNVBkY21yV0h2bS84OXdCcmc5S3dwM3pJRUhrRWh2NjlqNTRaL2FnQlBZ?=
 =?utf-8?B?clh2ODhUNmNYS3Nvc0FkRlV4NFUrbGt0d3RIK1ZiWDZUdjk5SEQ0YytCZDlx?=
 =?utf-8?B?akFYSG5YZUIwZ2RrVko4Q0VLNUU0S3YrTnV3ZTJ4SHJLSTUxVmJCZVRZRVkw?=
 =?utf-8?B?UDZlNVJIUVhuZS9xbUdkN3dDT29nZ0tHK09aMk1JSGxyVW1OWERKM3gvN0Nu?=
 =?utf-8?B?NkUzbkt3N29uRE16U01aNHBqR25mWjE0MjNnQlZMc1hjUkRvbVg2OGZ5SVN5?=
 =?utf-8?B?TGhwZ3JRN0hYeTgwcmYrMzFOem9hUmhmNk9pMUZXckQwSm5wc1JIR3dld1Vy?=
 =?utf-8?B?Y2E2Z0FoSDNZWWl4SzFEWnArejVXZEx1eGNZZmZ6WlBFUi9QN1BLVmpQYk5N?=
 =?utf-8?B?UmRvY2pJL1pXZ0l1T21UbVllaHZVYjJxMjR6ajRtNnpoYWtiV0xXN1VQUTBx?=
 =?utf-8?B?YkxiK2V6ZnBPbGtkL3gxc1VLWE1VMjRNRkVRdHpoNi9kV2FVaGlxWWhCaFN4?=
 =?utf-8?B?ZDZpdDFBaVJ0ZDdEN2p0ZWJSYk0xVFpNaENhMnE4cWYyMFBESHQvWjRzTC9t?=
 =?utf-8?B?d0hHRmZWYUpFSXF3M0tEdHBWRUpvNnQyaUdvS2llcG4weTRkb2hmMEFFOEdR?=
 =?utf-8?B?TTRTSzdVT2ZIazJzVnVZUzgvaDkvODNuTk1rZko5VXZ1d0xScmUyL1UwN0dX?=
 =?utf-8?B?Z28vVlFBemlyVjg4MTQ4TUowbWRuZ3ZZZ1Q5RC9JeWNBQTZ1c1FFZkY4UlM1?=
 =?utf-8?B?dGJmbkVzTEpOQnhIUFJERVRZVFZlMnRBVmhyT1BpcGViQ1ZFTllMckVwQ2RR?=
 =?utf-8?B?azhrYVlWYkt4dXQzVm9jSmdzRjV5Q2l2MFhPQVRFSDZNanFLYjl1SUFZamVO?=
 =?utf-8?B?dmFoSWtFWUFhUDZUWTN2UjdBVnlTWWdoU3kxSGdDKzVvZ2V3Y3Q3dlpUT0Iy?=
 =?utf-8?B?eEd6K3RSTy9sOSsvMmpQNitIVUs5Y01uWEZTN3lqbjU5TkVxa0ZlanBHKzdp?=
 =?utf-8?B?VEZPSmNDcDdIblMvVVhtNFArZjRIcWl2WGhmeS9LZ1dLZU9zSndQWU9QWDBv?=
 =?utf-8?B?Wmp2Z2lqVVliWDJjTGs4dS91a1NWZ1N4bytxZno2T2RIdmVLK2VDdGtNWlgz?=
 =?utf-8?Q?sn3HRCJ/8+BvS945Zds3pr1qA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1448eef5-9ce5-4c1a-7ce1-08ddcdad4d99
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 08:03:57.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QafkMZYIsqPp0hwe3I+4J3PAzf7syGP0rcu7AwOuF/RIh9izI2fRdsSpWxGaYglHq5z30S5ZVbQV/loSIyydQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7240

在 2025/7/28 15:38, Chao Yu 写道:

> On 7/25/25 15:53, Qi Han wrote:
>> Jens has already completed the development of uncached buffered I/O
>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
> as Jen mentioned in below path, right?
>
> soft-irq
> - folio_end_writeback()
>   - filemap_end_dropbehind_write()
>    - filemap_end_dropbehind()
>     - folio_unmap_invalidate()
>      - lock i_lock
>
> Thanks,

That's how I understand it.

>> I have been testing a use case locally, which aligns with Jens' test
>> case [2]. In the read scenario, using uncached buffer I/O results in
>> more stable read performance and a lower load on the background memory
>> reclaim thread (kswapd). So let's enable uncached buffer I/O reads on
>> F2FS.
>>
>> Read test data without using uncached buffer I/O:
>> reading bs 32768, uncached 0
>>     1s: 1856MB/sec, MB=1856
>>     2s: 1907MB/sec, MB=3763
>>     3s: 1830MB/sec, MB=5594
>>     4s: 1745MB/sec, MB=7333
>>     5s: 1829MB/sec, MB=9162
>>     6s: 1903MB/sec, MB=11075
>>     7s: 1878MB/sec, MB=12942
>>     8s: 1763MB/sec, MB=14718
>>     9s: 1845MB/sec, MB=16549
>>    10s: 1915MB/sec, MB=18481
>>    11s: 1831MB/sec, MB=20295
>>    12s: 1750MB/sec, MB=22066
>>    13s: 1787MB/sec, MB=23832
>>    14s: 1913MB/sec, MB=25769
>>    15s: 1898MB/sec, MB=27668
>>    16s: 1795MB/sec, MB=29436
>>    17s: 1812MB/sec, MB=31248
>>    18s: 1890MB/sec, MB=33139
>>    19s: 1880MB/sec, MB=35020
>>    20s: 1754MB/sec, MB=36810
>>
>> 08:36:26      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
>> 08:36:27        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>> 08:36:28        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>> 08:36:29        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
>> 08:36:30        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
>> 08:36:31        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
>> 08:36:32        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
>> 08:36:33        0        93    0.00   75.00    0.00    0.00   75.00     7  kswapd0
>> 08:36:34        0        93    0.00   81.00    0.00    0.00   81.00     7  kswapd0
>> 08:36:35        0        93    0.00   54.00    0.00    1.00   54.00     2  kswapd0
>> 08:36:36        0        93    0.00   61.00    0.00    0.00   61.00     0  kswapd0
>> 08:36:37        0        93    0.00   68.00    0.00    0.00   68.00     7  kswapd0
>> 08:36:38        0        93    0.00   53.00    0.00    0.00   53.00     2  kswapd0
>> 08:36:39        0        93    0.00   82.00    0.00    0.00   82.00     7  kswapd0
>> 08:36:40        0        93    0.00   77.00    0.00    0.00   77.00     1  kswapd0
>> 08:36:41        0        93    0.00   74.00    0.00    1.00   74.00     7  kswapd0
>> 08:36:42        0        93    0.00   71.00    0.00    0.00   71.00     7  kswapd0
>> 08:36:43        0        93    0.00   78.00    0.00    0.00   78.00     7  kswapd0
>> 08:36:44        0        93    0.00   85.00    0.00    0.00   85.00     7  kswapd0
>> 08:36:45        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
>> 08:36:46        0        93    0.00   70.00    0.00    0.00   70.00     7  kswapd0
>> 08:36:47        0        93    0.00   78.00    0.00    1.00   78.00     2  kswapd0
>> 08:36:48        0        93    0.00   81.00    0.00    0.00   81.00     3  kswapd0
>> 08:36:49        0        93    0.00   54.00    0.00    0.00   54.00     7  kswapd0
>> 08:36:50        0        93    0.00   76.00    0.00    0.00   76.00     1  kswapd0
>> 08:36:51        0        93    0.00   75.00    0.00    0.00   75.00     0  kswapd0
>> 08:36:52        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
>> 08:36:53        0        93    0.00   61.00    0.00    1.00   61.00     7  kswapd0
>> 08:36:54        0        93    0.00   80.00    0.00    0.00   80.00     7  kswapd0
>> 08:36:55        0        93    0.00   64.00    0.00    0.00   64.00     7  kswapd0
>> 08:36:56        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
>> 08:36:57        0        93    0.00   26.00    0.00    0.00   26.00     2  kswapd0
>> 08:36:58        0        93    0.00   24.00    0.00    1.00   24.00     3  kswapd0
>> 08:36:59        0        93    0.00   22.00    0.00    1.00   22.00     3  kswapd0
>> 08:37:00        0        93    0.00   15.84    0.00    0.00   15.84     3  kswapd0
>> 08:37:01        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:37:02        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>
>> Read test data after using uncached buffer I/O:
>> reading bs 32768, uncached 1
>>     1s: 1863MB/sec, MB=1863
>>     2s: 1903MB/sec, MB=3766
>>     3s: 1860MB/sec, MB=5627
>>     4s: 1864MB/sec, MB=7491
>>     5s: 1860MB/sec, MB=9352
>>     6s: 1854MB/sec, MB=11206
>>     7s: 1874MB/sec, MB=13081
>>     8s: 1874MB/sec, MB=14943
>>     9s: 1840MB/sec, MB=16798
>>    10s: 1849MB/sec, MB=18647
>>    11s: 1863MB/sec, MB=20511
>>    12s: 1798MB/sec, MB=22310
>>    13s: 1897MB/sec, MB=24207
>>    14s: 1817MB/sec, MB=26025
>>    15s: 1893MB/sec, MB=27918
>>    16s: 1917MB/sec, MB=29836
>>    17s: 1863MB/sec, MB=31699
>>    18s: 1904MB/sec, MB=33604
>>    19s: 1894MB/sec, MB=35499
>>    20s: 1907MB/sec, MB=37407
>>
>> 08:38:00      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
>> 08:38:01        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:02        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:03        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:04        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:05        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:06        0        93    0.00    1.00    0.00    1.00    1.00     0  kswapd0
>> 08:38:07        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:08        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:09        0        93    0.00    1.00    0.00    0.00    1.00     1  kswapd0
>> 08:38:10        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>> 08:38:11        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>> 08:38:12        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>> 08:38:13        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>> 08:38:14        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
>> 08:38:15        0        93    0.00    3.00    0.00    0.00    3.00     0  kswapd0
>> 08:38:16        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:17        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:18        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:19        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:20        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:21        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:22        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
>> 08:38:23        0        93    0.00    3.00    0.00    0.00    3.00     4  kswapd0
>> 08:38:24        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:25        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
>> 08:38:26        0        93    0.00    4.00    0.00    0.00    4.00     3  kswapd0
>> 08:38:27        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:38:28        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:38:29        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:38:30        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:38:31        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:38:32        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>> 08:38:33        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
>>
>> [1]
>> https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m58520a94b46f543d82db3711453dfc7bb594b2b0
>>
>> [2]
>> https://pastebin.com/u8eCBzB5
>>
>> Signed-off-by: Qi Han <hanqi@vivo.com>
>> ---
>>   fs/f2fs/file.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 696131e655ed..d8da1fc2febf 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -5425,5 +5425,5 @@ const struct file_operations f2fs_file_operations = {
>>   	.splice_read	= f2fs_file_splice_read,
>>   	.splice_write	= iter_file_splice_write,
>>   	.fadvise	= f2fs_file_fadvise,
>> -	.fop_flags	= FOP_BUFFER_RASYNC,
>> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>>   };


