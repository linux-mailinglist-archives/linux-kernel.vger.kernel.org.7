Return-Path: <linux-kernel+bounces-891267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F98C4249A
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC393B353D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD012BFC8F;
	Sat,  8 Nov 2025 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBmSx6VU"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546F2BE7CD;
	Sat,  8 Nov 2025 02:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568669; cv=fail; b=OkAK8bJ9wlSBnOcsuNqrsdqie1RUBYKR8L8gFSD1AR0G+VFHFQ5D9hI4fGfy/8S/1EOZtIkAlvjxcnlIXAuJYGY5B7Okg91XwyEsRMbmfaY3Tp9Zucok4UjU6YW7WGCNAIAlOXTokXE6Rh0z1zRPJ4Q1lNhlCGBaA3V24TLuQ+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568669; c=relaxed/simple;
	bh=Be46L1a4in2dntzwbEEoYGQaw7hjSDxTjTLGAOL9eek=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uiTwKaOG47svIRCEJ78Ji7dVKSHjX+VmYIqRsGt7UpQC5rcKyRNMTFSzTsi/QBoe6t2ctWagCuVtBeukumlZ+BAOlnjPqlpUvN7w5zA2sGxO6nHT2e8OyfKcRrXEF7LWuhFug2Rtm/D58qsUrBVUZgmf/L0SMXUuqXTguE/XXWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBmSx6VU; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFa9OHrMw26iq1Vf0ZN/CV2HRGn3MDj4FOb3YnzcnWKUr9vFQ55mbtlQC0YwRxYjUJKGumAGixLjW/9uLWpT/agO3jKtJV0tMmM6QfTEBXSM7eau0tKbsumfTeMiUvr31ifxfDHuZ+evnM/S4lqsRhxsAzDaCHziZVm5bZ7fZb/urV2DsAHPSViC4i8dT8pJzrKAWwIi78ZBHfPaF8Hn8CCneHr/8jDGAQnLEIEATQZLa+aAws/p6XxQ/H92xq/XoIB437noDzeO6NC+eEkD5cndM+cIJAcGoMj6xlf4ldMBreoLrmWkrqG2FPPLOP05OgGv69YDPgF0sGQDplixgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+oGofHLK6cwft5AVPzLl/T3zAbIgZ2buxX45oDcgIY=;
 b=x1cXIK7ukUQ4pndVmWXoQYC0gbx2inxX0F4ZquuxxKmHHI2KKb3GuoTG5l6DBGbJFxSOdK6/6DkDSpi1lZwbzn2Q7EGV8LMgY0P4fXCwv0z+qBCQyhrxXqmJhONONCnPpDeOsTKceclDHXJNo3oALB16IeI/1WaDqJFM+pMmZkNVKQfpIj08uGPOYEloqb2AHABw6Bz0J+mtgGSw5Uztey9TrSPe4R6sxM765kZT2rNneEFpon4dBxNscpuWevq/19FHH51bpsLRiQSHwoTX/K6pWK/z6srA9zQDmkRhQe/rvNudCH+rIBpPXlmA398nhyf9RvNRiuV9WPSfBlFNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+oGofHLK6cwft5AVPzLl/T3zAbIgZ2buxX45oDcgIY=;
 b=QBmSx6VUb7XRpoqxpUrzidwC/6LJwLS7ASTIfzz1vOMWn2Y1nsJYGOAlQmvSeT6sV53rqJ+NiD2N+uBg57Ai14LG8Bjy0lY6tCySnNc8UPFTsNj/e88B+Gb13dUHNmmnRv+s3f23gFdVLQnTC25h9r043hts+tDmtugYryHV+RbUqFAE1EIVbyr62xZBQ0OfAC6Etd+ntNtzF40ZadEO2Dd19GqJavRs1I2I3xkY3fWofM7wdZs0rdD8+ZwTszO9hmngGR8xJYl1l/VamJnLRDn1CVood1IzYS4V/8QUQ2I5xP6tfS2ZjckC3APSS4oq5Y/8j9AY+QYS44WZNZsSfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sat, 8 Nov
 2025 02:24:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 02:24:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sat, 08 Nov 2025 11:23:50 +0900
Subject: [PATCH FOR REFERENCE v4 4/4] gpu: nova-core: use BitInt for
 bitfields
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-bounded_ints-v4-4-c9342ac7ebd1@nvidia.com>
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
In-Reply-To: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCPR01CA0098.jpnprd01.prod.outlook.com
 (2603:1096:405:4::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: ef56f6e0-3ad4-426d-ea01-08de1e6deb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFRUTHhZTE1xMmpKaVcyaldLU1N5R0g4VktKYngybW56VW9uUDlOS0EzeDBm?=
 =?utf-8?B?YjdoQXd3YU9EUytuVFViV3ZTWG51WnFuL055REw1anEvd1pCNXNXejdmNm5U?=
 =?utf-8?B?TWVKZ1p6MGE3a1BiNUl1SG9mZ0VHZWRvTm5ya0RUUHltYm42M3dHVERla2JM?=
 =?utf-8?B?TEtyQzhUT0o1VjVmS1RSNGxPSDhFTTFPVDh2OUlPOForcjhSSTVUbjN5czNn?=
 =?utf-8?B?dVRVaEhZT3ZyT2VzMGYzUms4Zm9ycDRKVEY1NWZWRUo0b3kzYTlaZ29RWHdY?=
 =?utf-8?B?MllNaFJ5TVEvQURLQ0xCSnNmUlprRFJjTFlJbi9oSW1JaG50SnM4Vjg1akZh?=
 =?utf-8?B?T0xLZjNmeW83ZGg0ZlU5QUhSN3pqZFRUazlCL3d0dzZXT0hNQmQvTDlZNDRC?=
 =?utf-8?B?WjFpL0Q0eFg5RDVkTCtEODlFeE50Q0ZGbXhGOUVPMCthUDQrQStIbXlRemUz?=
 =?utf-8?B?elZUcThMTVJZTW1TdEIvWkkzeTU1NFIrZnBHSmJOcHNMbkIxV0pGN2ZhSWt4?=
 =?utf-8?B?OExtSGtBclNjZWF6bUxWWUNWUkpZUVhxYlYzNXhCMVVYQXBPU1plUVd3TllF?=
 =?utf-8?B?RlFTZ1UwSXZSbTVSQi9uWUhob1JqMmllVy9rc0tuODlKYk5rRUNydkUzSEI0?=
 =?utf-8?B?b2lGa2U0MGg3ZWFNUmszcW4zVW1Uc0ZMRnNXU3hha05TTUVBTU9XWk9zS2Yw?=
 =?utf-8?B?S29NNSt0Q3I4bGxXUXRJM1UrblE3dnRIRjhtbTFTU05sVHNveDIyNkxmUHpN?=
 =?utf-8?B?UVRjUTR4Z2puaUpoK1d2VnMrN0ZBN3JIaEtlS01qRHlrRk9oMmhwWWNnRW5J?=
 =?utf-8?B?MEdkVEM3WVU5cFhxYVA4bFgvNllLUU5yWkdiNWpldk03NGpXU3hicW5rSHpH?=
 =?utf-8?B?TFZ5NnpveExOam1admlRZUxwbG8xK1hVMXI1dVIxTFhpUGpJQmxMUHNIaUVu?=
 =?utf-8?B?R1hJK1FKWUpGTjdTYXk1VldoR1dhVmhUTk5zNFJCOWxMbzlyN0s2T3ZpWi9S?=
 =?utf-8?B?VDRob3JCK0ZrZFpJUDh5RUo2YnM3OTJOMnV0dElQT1lkZnFjcE5zS0NLWVAz?=
 =?utf-8?B?ZGlZS3V1NUpkOEN0ZmhXajAzeHZSdk5Za09JTDVob1dGVzNscjRVSCtpRlFn?=
 =?utf-8?B?ZXA0bUNqa3ZWeksrR1RZRy9FZnpwMnZBWVlyMkVxR0dYUkd1cVVTOEVzRWNP?=
 =?utf-8?B?NURzbmJEOTRhdGxnYlFKOWsxL29XbVBzaHl5N0VQTmVvWnVkNTE4S2dmazBR?=
 =?utf-8?B?NitGZGIvQjBmR05oZU0vNytqSDI3L1dLQjd5Yy94WG84K3MwbU5NY2ZWc1g1?=
 =?utf-8?B?RWRYZlZQVXZyVzl4NzFBaktNY2ZGQjNQK3RreUIya0JLRUkwVlVJdXB0NzI4?=
 =?utf-8?B?Wi9qRVZkc0tJMnZhOHRPVUdpZnBGVk0rbmhpV2htTzAySkswdHErdFRBcmtr?=
 =?utf-8?B?ekREV0tVVS9mcjdxQW1VbE1OWXFRd01nR1FQQmQ2WHRJU1FkWFc3T2QxU0lu?=
 =?utf-8?B?ODR6M2xhb2t0azQyYzJVcU5VQnp6TVBpZzFFaytFTkY1NnpKT1VyKzR1K1Rv?=
 =?utf-8?B?YVdRMW01SmdEQ1I5T0FJbXhQdXROM1dXZVFuVTVPTWhEZEdhTWZRZnpIMkkw?=
 =?utf-8?B?ZFBCN2p0emN6L3k5WUJnY3dyV1Zqa3VEaXVibUhhckcrY0MzMC91NUZpTlRk?=
 =?utf-8?B?MGFLYnV0UitpOVN1R3lzY3FZWkpXWGI4QXJ0bUhKREVBa3UyWG1xaE1hRlNv?=
 =?utf-8?B?aDIyU25QNEVuZDJMNWpoK0FpdVZub3JrT21UR3U0dzZLa25JL1U4ZlZmZ3FO?=
 =?utf-8?B?WDZUNFFXU0FMSGdSY21VdjROaG83TVl2QkFyOTRNeEcrWFJzdmg2emhpV2tn?=
 =?utf-8?B?Q1J1R0gwSm1BSms5T3EwWmczVTRPK0RJMXgybUUwcnhySWlIbEtHaDhXcVdH?=
 =?utf-8?B?UnBNM054OFZuS3hFQkdFamJHazJHR1RNRFVQZWsyVVVkZ2l3RCt4ZjRMQlpu?=
 =?utf-8?B?bVd6VGdrTjVqZ0RKVnFtcVEzTFQ2RTZ6Z3FtTnExTVB6MlNkK3NIMVIzN2g5?=
 =?utf-8?Q?w2OjeJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3NQZ1dzN3hZU3RaemtjUVdxbVVQU1ljYUJSdENvdlhONVJWSnYwazZQNE1p?=
 =?utf-8?B?MmpsaEE5N0FSQWlMWlVLd0FoalJSWGV6V215TVlHSVorQVQ1TEVzeTN4di8x?=
 =?utf-8?B?Y2dtdERQQVRVaFZnQUtDRFg2cjd4SFlSakY4blU3cHlGUFBwWjVBNVY1a2gr?=
 =?utf-8?B?aWdtRVViNkVIRGVvcmN0UXJlYU8wRk5FUE0wa2NoNFRCdTVWNitzd1BpRENl?=
 =?utf-8?B?c0xQQ2xhSm9zQTZ0cTM0ZkVDcVk2eUdGRkxCMkM3V0tHeHJLVkhUUWhwcUVX?=
 =?utf-8?B?cnV2ajJPeWJMdzUxZFVWdTl5L3JnTEVFVC85Y1pSSVhhZm8wMzkxdHBBWTVx?=
 =?utf-8?B?VUtQREowTVdmajdYYjllU1BLeFJ6U0dJTklrN3J2ZVNYNUlLZGcxV3NxS0to?=
 =?utf-8?B?YTV1dmlEY08xWXFqNWRjTkgxNVZwK0RGLzVmS2l0dDFKV0k2Y0xYaSttbUVv?=
 =?utf-8?B?NUZHTTlGSXUwQ2JWZWlMbW5yVkpBb2pzd2V0QjlVMHNKTTVpeGp2c1I3eG5j?=
 =?utf-8?B?eU1GdytsOTBjVndmN21aRXBCUDJwTlhaWmFSSFBnRkFNaHdmTmY3bFQ4bFFH?=
 =?utf-8?B?RjRBWkkvRitsTnNyNVhMU2JYOC9RQjFkaGpsRnB3OE5yL3d1N1R6Vzd4VU5o?=
 =?utf-8?B?SndidUxKenc1RzUzTnB0L3YrUXdNVW9LTGptYXp4RkNTQnJoTlUzd2V6K1dC?=
 =?utf-8?B?MmxMeTMwY09mL0Z5NmZ2QU9xM2xobk1qWElXRTBnbkh5cnpVK3ArZ0ZCdk8w?=
 =?utf-8?B?dFpWU1RrWVAzdVlIYVhZSXRPc29iYTRrelZwTklBbTM3UlBrams0OUlMSmxk?=
 =?utf-8?B?bnMwcjFCZjF3dFFXSzVYVWpjeWZJZW9RdUpSMkxXS1NiVnBWT29zNmkwQzc3?=
 =?utf-8?B?LzhFaXZ5aWZ1TmoxWUhVQ21FSVJUSmUzQmsxVk5zQ1NPTUdlMU5XUnEycDk5?=
 =?utf-8?B?YTlQOGJMOTVuSk1jZUhqZ1VCNUJGTjlHTTlIUzhhSURvTkhncE1qdXFEU0ZN?=
 =?utf-8?B?Sno1WlIrL3RjU3BmVThQTG1KZ201Kys1Vm12YUhhaHlCd1hreWtOV2wwYzlF?=
 =?utf-8?B?TGhiV1JtU3UyZkZyRU5Md0RpSytDK1NCWGhIUWFjNkdBMm9BcUZKMTRTajFD?=
 =?utf-8?B?ZWJNdTQzUDI4SEtRT1RsVmwreEFsOVdkWFVRY0pLSXpKMFUwUlQ1Q2tLdHFH?=
 =?utf-8?B?cmNQWnhHUlJsbXlWaS9KTTFwZHNhUHdvZEFuMXd6VGo3UnpBK2Y3NkFtRWpM?=
 =?utf-8?B?T2VwbmIyWld4bVRiRnJIc0lOUXUzWjUxTGc3TStqaUYzd1JaSEJJTmE3bnFv?=
 =?utf-8?B?L0gyWk95dEtqT29kTFF2Um01MGo3Sytoa2N5OWY1Z1JSQktqK3FpN1JLNGg5?=
 =?utf-8?B?NlRsdjBEeE5RNXpSN1hDUlFsWDVsNTB3eldXVU9mZkZ4cUZyQy9DaDJ2KzM0?=
 =?utf-8?B?QjB0enNPU2prSWNRRjF3N1RwYitmWnczdkdOKzdxZ3VvbXJZSW1ma3pJWito?=
 =?utf-8?B?R3pDcUdBZmNXMWYwVUtkQmYxcS95M2piRnpna3hUNDd1WEJSRDdCUURRVmN1?=
 =?utf-8?B?eWk5amtRWklpQVBVVmIxeW9iVFhGa2lCdFgwUUV3WTNmNFBhNDZEekdSbURq?=
 =?utf-8?B?U3VPNWZSZWMzN09jckR2YzRLV3laWkh4NUtqdFhiakNDcWNJbkZ0UnhYQjZl?=
 =?utf-8?B?bldIQ29hbHBSRm5teFNxcjJVaTdTNEdUWUdmSFhmbTMvQnVhVzhMK2c0SDVK?=
 =?utf-8?B?eldva2xhTW13bHhkMDZ2TkZDd05xNE5xNER2ZDBaTU5pVEk5Y2J2NC9XRGhq?=
 =?utf-8?B?ckpOV2crNDJOY0dFbU9TaVUveGdEbndNa1ZicUNBaStpelB0cnFnRzk4TTR2?=
 =?utf-8?B?aXR1eXZMT3FqWFJrZEdCT28xc1Z5VEw4Y0ErbVBJT1RxdTFRbUk1NHRFamhx?=
 =?utf-8?B?YUpHV1VmS3NlSno2eGFUejJRaHBGaGhhaGF4bTlSZkFVRERPZzRoTDdOemth?=
 =?utf-8?B?VjUwNHhaamR2a1ZCTW1XNGlFdmZQRDIvQUo2UnZtNld6cDdQOHQwRjBybThU?=
 =?utf-8?B?dkoxNzVVaENQMkgwajNXSmtWSXRZbDFNM0pqK09WYm90Mjh0UllPUjVTK1ph?=
 =?utf-8?B?anFLRkJkNzUwdG9YcHVqUERRbGxCL3IrMEZOd0FOVFVodGRWeWJCcGpCclR6?=
 =?utf-8?Q?t2p30lRDS4SYv2JYhpsSLa8cbI+xem6IvZWVs19SxrrY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef56f6e0-3ad4-426d-ea01-08de1e6deb77
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 02:24:18.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikZnHs4ViwNvFPPFJVWEmUzFkrqdlzgzVAZKsyIZUei3RPJmVj9pEkIgxjNVcyUd6H8JZEkNArr3Io2JXgIb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

Use BitInt with the bitfield!() and register!() macros and adapt the
nova-core code accordingly.

This makes it impossible to trim values when setting a register field,
because either the value of the field has been inferred at compile-time
to fit within the bounds of the field, or the user has been forced to
check at runtime that it does indeed fit.

The use of BitInt actually simplifies register fields definitions,
as they don't need an intermediate storage type (the "as ..." part of
fields definitions). Instead, the internal storage type for each field
is now the bounded integer of its width in bits, which can optionally be
converted to another type that implements `From`` or `TryFrom`` for that
bounded integer type.

This means that something like

  register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
      3:3     status_valid as bool,
      31:8    addr as u32,
  });

Now becomes

  register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
      3:3     status_valid => bool,
      31:8    addr,
  });

(here `status_valid` is infallibly converted to a bool for convenience
and to remain compatible with the previous semantics)

The field setter/getters are also simplified. If a field has no target
type, then its setter expects any type that implements `Into` to the
field's bounded integer type. Due to the many `From` implementations for
primitive types, this means that most calls can be left unchanged. If
the caller passes a value that is potentially larger than the field's
capacity, it must use the `try_` variant of the setter, which returns an
error if the value cannot be converted at runtime.

For fields that use `=>` to convert to another type, both setter and
getter are always infallible.

For fields that use `?=>` to fallibly convert to another type, only the
getter needs to be fallible as the setter always provide valid values by
design.

Outside of the register macro, the biggest changes occur in `falcon.rs`,
which defines many enums for fields - their conversion implementations
need to be changed from the original primitive type of the field to the
new corresponding bounded int type. Hopefully the TryFrom/Into derive
macros [1] can take care of implementing these, but it will need to be
adapted to support bounded integers... :/

But overall, I am rather happy at how simple it was to convert the whole
of nova-core to this.

Note: This RFC uses nova-core's register!() macro for practical
purposes, but the hope is to move this patch on top of the bitfield
macro after it is split out [2].

[1]
https://lore.kernel.org/rust-for-linux/cover.1755235180.git.y.j3ms.n@gmail.com/
[2]
https://lore.kernel.org/rust-for-linux/20251003154748.1687160-1-joelagnelf@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/bitfield.rs         | 366 ++++++++++++++++--------------
 drivers/gpu/nova-core/falcon.rs           | 145 ++++++------
 drivers/gpu/nova-core/falcon/hal/ga102.rs |   5 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs     |   9 +-
 drivers/gpu/nova-core/gpu.rs              |   9 +-
 drivers/gpu/nova-core/regs.rs             | 139 ++++++------
 6 files changed, 365 insertions(+), 308 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 16e143658c51..be4d54feb38c 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -19,21 +19,21 @@
 ///     Auto = 2,
 /// }
 ///
-/// impl TryFrom<u8> for Mode {
-///     type Error = u8;
-///     fn try_from(value: u8) -> Result<Self, Self::Error> {
-///         match value {
+/// impl TryFrom<Bounded<u32, 4>> for Mode {
+///     type Error = u32;
+///     fn try_from(value: Bounded<u32, 4>) -> Result<Self, Self::Error> {
+///         match *value {
 ///             0 => Ok(Mode::Low),
 ///             1 => Ok(Mode::High),
 ///             2 => Ok(Mode::Auto),
-///             _ => Err(value),
+///             value => Err(value),
 ///         }
 ///     }
 /// }
 ///
-/// impl From<Mode> for u8 {
-///     fn from(mode: Mode) -> u8 {
-///         mode as u8
+/// impl From<Mode> for Bounded<u32, 4> {
+///     fn from(mode: Mode) -> Bounded<u32, 4> {
+///         Bounded::from_expr(mode as u32)
 ///     }
 /// }
 ///
@@ -44,25 +44,29 @@
 ///     Active = 1,
 /// }
 ///
-/// impl From<bool> for State {
-///     fn from(value: bool) -> Self {
-///         if value { State::Active } else { State::Inactive }
+/// impl From<Bounded<u32, 1>> for State {
+///     fn from(value: Bounded<u32, 1>) -> Self {
+///         if bool::from(value) {
+///             State::Active
+///         } else {
+///             State::Inactive
+///         }
 ///     }
 /// }
 ///
-/// impl From<State> for bool {
-///     fn from(state: State) -> bool {
+/// impl From<State> for Bounded<u32, 1> {
+///     fn from(state: State) -> Bounded<u32, 1> {
 ///         match state {
-///             State::Inactive => false,
-///             State::Active => true,
+///             State::Inactive => false.into(),
+///             State::Active => true.into(),
 ///         }
 ///     }
 /// }
 ///
 /// bitfield! {
 ///     pub struct ControlReg(u32) {
-///         7:7 state as bool => State;
-///         3:0 mode as u8 ?=> Mode;
+///         7:7 state => State;
+///         3:0 mode ?=> Mode;
 ///     }
 /// }
 /// ```
@@ -112,12 +116,9 @@ fn from(val: $name) -> $storage {
         bitfield!(@fields_dispatcher $vis $name $storage { $($fields)* });
     };
 
-    // Captures the fields and passes them to all the implementers that require field information.
-    //
-    // Used to simplify the matching rules for implementers, so they don't need to match the entire
-    // complex fields rule even though they only make use of part of it.
+    // Dispatch fields depending on the syntax used.
     (@fields_dispatcher $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
+        $($hi:tt:$lo:tt $field:ident
             $(?=> $try_into_type:ty)?
             $(=> $into_type:ty)?
             $(, $comment:literal)?
@@ -125,173 +126,208 @@ fn from(val: $name) -> $storage {
         )*
     }
     ) => {
-        bitfield!(@field_accessors $vis $name $storage {
-            $(
-                $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-            ;
-            )*
-        });
-        bitfield!(@debug $name { $($field;)* });
-        bitfield!(@default $name { $($field;)* });
-    };
-
-    // Defines all the field getter/setter methods for `$name`.
-    (
-        @field_accessors $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
-            $(?=> $try_into_type:ty)?
-            $(=> $into_type:ty)?
-            $(, $comment:literal)?
-        ;
-        )*
-        }
-    ) => {
-        $(
-            bitfield!(@check_field_bounds $hi:$lo $field as $type);
-        )*
-
         #[allow(dead_code)]
         impl $name {
-            $(
-            bitfield!(@field_accessor $vis $name $storage, $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-                ;
-            );
-            )*
+        $(
+        bitfield!(@private_field_accessors $name $storage : $hi:$lo $field);
+        bitfield!(@public_field_accessors $vis $name $storage : $hi:$lo $field
+            $(?=> $try_into_type)?
+            $(=> $into_type)?
+            $(, $comment)?
+        );
+        )*
         }
+
+        bitfield!(@debug $name { $($field;)* });
+        bitfield!(@default $name { $($field;)* });
+
     };
 
-    // Boolean fields must have `$hi == $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert!(
-                $hi == $lo,
-                concat!("boolean field `", stringify!($field), "` covers more than one bit")
-            );
-        };
-    };
-
-    // Non-boolean fields must have `$hi >= $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as $type:tt) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert!(
-                $hi >= $lo,
-                concat!("field `", stringify!($field), "`'s MSB is smaller than its LSB")
-            );
-        };
-    };
-
-    // Catches fields defined as `bool` and convert them into a boolean value.
     (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f != 0) }
-            bool $into_type => $into_type $(, $comment)?;
-        );
-    };
-
-    // Shortcut for fields defined as `bool` without the `=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as bool => bool $(, $comment)?;
-        );
-    };
-
-    // Catches the `?=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            ?=> $try_into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$try_into_type>::try_from(f as $type) } $type $try_into_type =>
-            ::core::result::Result<
-                $try_into_type,
-                <$try_into_type as ::core::convert::TryFrom<$type>>::Error
-            >
-            $(, $comment)?;);
-    };
-
-    // Catches the `=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f as $type) } $type $into_type => $into_type $(, $comment)?;);
-    };
-
-    // Shortcut for non-boolean fields defined without the `=>` or `?=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as $type => $type $(, $comment)?;
-        );
-    };
-
-    // Generates the accessor methods for a single field.
-    (
-        @leaf_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident
-            { $process:expr } $prim_type:tt $to_type:ty => $res_type:ty $(, $comment:literal)?;
+        @private_field_accessors $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
     ) => {
         ::kernel::macros::paste!(
         const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
-        const [<$field:upper _MASK>]: $storage = {
-            // Generate mask for shifting
-            match ::core::mem::size_of::<$storage>() {
-                1 => ::kernel::bits::genmask_u8($lo..=$hi) as $storage,
-                2 => ::kernel::bits::genmask_u16($lo..=$hi) as $storage,
-                4 => ::kernel::bits::genmask_u32($lo..=$hi) as $storage,
-                8 => ::kernel::bits::genmask_u64($lo..=$hi) as $storage,
-                _ => ::kernel::build_error!("Unsupported storage type size")
-            }
-        };
+        const [<$field:upper _MASK>]: u32 = ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
         const [<$field:upper _SHIFT>]: u32 = $lo;
         );
 
+        ::kernel::macros::paste!(
+        fn [<$field _internal>](self) ->
+            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }> {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let field = ((self.0 & MASK) >> SHIFT);
+
+            ::kernel::num::Bounded::<$storage, { $hi + 1 - $lo }>::from_expr(field)
+        }
+
+        fn [<set_ $field _internal>](
+            mut self,
+            value: ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>,
+        ) -> Self
+        {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let value = (value.get() << SHIFT) & MASK;
+            self.0 = (self.0 & !MASK) | value;
+
+            self
+        }
+
+        fn [<try_set_ $field _internal>]<T>(
+            mut self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBounded<$storage, { $hi + 1 - $lo }>,
+        {
+            const MASK: u32 = $name::[<$field:upper _MASK>];
+            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
+
+            let value = (
+                value.try_into_bitint().ok_or(::kernel::error::code::EOVERFLOW)?.get() << SHIFT
+            ) & MASK;
+
+            self.0 = (self.0 & !MASK) | value;
+
+            Ok(self)
+        }
+        );
+    };
+
+    // Generates the public accessors for fields infallibly (`=>`) converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            => $into_type:ty $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
         $(
         #[doc="Returns the value of this field:"]
         #[doc=$comment]
         )?
         #[inline(always)]
-        $vis fn $field(self) -> $res_type {
-            ::kernel::macros::paste!(
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            );
-            let field = ((self.0 & MASK) >> SHIFT);
-
-            $process(field)
+        $vis fn $field(self) -> $into_type
+        {
+            self.[<$field _internal>]().into()
         }
 
-        ::kernel::macros::paste!(
         $(
         #[doc="Sets the value of this field:"]
         #[doc=$comment]
         )?
         #[inline(always)]
-        $vis fn [<set_ $field>](mut self, value: $to_type) -> Self {
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            let value = ($storage::from($prim_type::from(value)) << SHIFT) & MASK;
-            self.0 = (self.0 & !MASK) | value;
-
-            self
+        $vis fn [<set_ $field>](self, value: $into_type) -> Self
+        {
+            self.[<set_ $field _internal>](value.into())
         }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> $into_type {
+            Default::default()
+        }
+
+        );
+    };
+
+    // Generates the public accessors for fields fallibly (`?=>`) converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            ?=> $try_into_type:ty $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(
+        #[doc="Returns the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn $field(self) ->
+            Result<
+                $try_into_type,
+                <$try_into_type as ::core::convert::TryFrom<
+                    ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
+                >>::Error
+            >
+        {
+            self.[<$field _internal>]().try_into()
+        }
+
+        $(
+        #[doc="Sets the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<set_ $field>](self, value: $try_into_type) -> Self
+        {
+            self.[<set_ $field _internal>](value.into())
+        }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> $try_into_type {
+            Default::default()
+        }
+
+        );
+    };
+
+    // Generates the public accessors for fields not converted to a type.
+    (
+        @public_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+            $(, $comment:literal)?
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(
+        #[doc="Returns the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn $field(self) ->
+            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
+        {
+            self.[<$field _internal>]()
+        }
+
+        $(
+        #[doc="Sets the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<set_ $field>]<T>(
+            self,
+            value: T,
+        ) -> Self
+            where T: Into<::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>>,
+        {
+            self.[<set_ $field _internal>](value.into())
+        }
+
+        $(
+        #[doc="Attempts to set the value of this field:"]
+        #[doc=$comment]
+        )?
+        #[inline(always)]
+        $vis fn [<try_set_ $field>]<T>(
+            self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBounded<$storage, { $hi + 1 - $lo }>,
+        {
+            Ok(
+                self.[<set_ $field _internal>](
+                    value.try_into_bitint().ok_or(::kernel::error::code::EOVERFLOW)?
+                )
+            )
+        }
+
+        /// Private method, for use in the [`Default`] implementation.
+        fn [<$field _default>]() -> ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }> {
+            Default::default()
+        }
+
         );
     };
 
@@ -319,7 +355,7 @@ fn default() -> Self {
 
                 ::kernel::macros::paste!(
                 $(
-                value.[<set_ $field>](Default::default());
+                value.[<set_ $field>](Self::[<$field _default>]());
                 )*
                 );
 
diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index fe5b3256d972..f74770703c0f 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -10,6 +10,10 @@
     device,
     dma::DmaAddress,
     io::poll::read_poll_timeout,
+    num::{
+        self,
+        Bounded, //
+    },
     prelude::*,
     sync::aref::ARef,
     time::{
@@ -35,11 +39,14 @@
 pub(crate) mod sec2;
 
 // TODO[FPRI]: Replace with `ToPrimitive`.
-macro_rules! impl_from_enum_to_u8 {
-    ($enum_type:ty) => {
-        impl From<$enum_type> for u8 {
+macro_rules! impl_from_enum_to_bounded {
+    ($enum_type:ty, $length:literal) => {
+        impl<T> From<$enum_type> for Bounded<T, $length>
+        where
+            T: From<u8> + num::Integer,
+        {
             fn from(value: $enum_type) -> Self {
-                value as u8
+                Bounded::from_expr(T::from(value as u8))
             }
         }
     };
@@ -59,16 +66,20 @@ pub(crate) enum FalconCoreRev {
     Rev6 = 6,
     Rev7 = 7,
 }
-impl_from_enum_to_u8!(FalconCoreRev);
+impl_from_enum_to_bounded!(FalconCoreRev, 4);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRev {
+impl<T> TryFrom<Bounded<T, 4>> for FalconCoreRev
+where
+    T: num::Integer,
+    u8: From<Bounded<T, 4>>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
+    fn try_from(value: Bounded<T, 4>) -> Result<Self> {
         use FalconCoreRev::*;
 
-        let rev = match value {
+        let rev = match u8::from(value) {
             1 => Rev1,
             2 => Rev2,
             3 => Rev3,
@@ -94,24 +105,26 @@ pub(crate) enum FalconCoreRevSubversion {
     Subversion2 = 2,
     Subversion3 = 3,
 }
-impl_from_enum_to_u8!(FalconCoreRevSubversion);
+impl_from_enum_to_bounded!(FalconCoreRevSubversion, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRevSubversion {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
+impl<T> From<Bounded<T, 2>> for FalconCoreRevSubversion
+where
+    T: num::Integer,
+    u8: From<Bounded<T, 2>>,
+{
+    fn from(value: Bounded<T, 2>) -> Self {
         use FalconCoreRevSubversion::*;
 
-        let sub_version = match value & 0b11 {
+        match u8::from(value) {
             0 => Subversion0,
             1 => Subversion1,
             2 => Subversion2,
             3 => Subversion3,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sub_version)
+            // SAFETY: `value` comes from a 2-bit `Bounded`, and we just checked all possible
+            // values.
+            _ => unsafe { core::hint::unreachable_unchecked() },
+        }
     }
 }
 
@@ -138,16 +151,20 @@ pub(crate) enum FalconSecurityModel {
     /// Also known as High-Secure, Privilege Level 3 or PL3.
     Heavy = 3,
 }
-impl_from_enum_to_u8!(FalconSecurityModel);
+impl_from_enum_to_bounded!(FalconSecurityModel, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconSecurityModel {
+impl<T> TryFrom<Bounded<T, 2>> for FalconSecurityModel
+where
+    T: num::Integer,
+    u8: From<Bounded<T, 2>>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
+    fn try_from(value: Bounded<T, 2>) -> Result<Self> {
         use FalconSecurityModel::*;
 
-        let sec_model = match value {
+        let sec_model = match u8::from(value) {
             0 => None,
             2 => Light,
             3 => Heavy,
@@ -170,14 +187,18 @@ pub(crate) enum FalconModSelAlgo {
     #[default]
     Rsa3k = 1,
 }
-impl_from_enum_to_u8!(FalconModSelAlgo);
+impl_from_enum_to_bounded!(FalconModSelAlgo, 8);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconModSelAlgo {
+impl<T> TryFrom<Bounded<T, 8>> for FalconModSelAlgo
+where
+    T: num::Integer,
+    u8: From<Bounded<T, 8>>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: Bounded<T, 8>) -> Result<Self> {
+        match u8::from(value) {
             1 => Ok(FalconModSelAlgo::Rsa3k),
             _ => Err(EINVAL),
         }
@@ -192,14 +213,18 @@ pub(crate) enum DmaTrfCmdSize {
     #[default]
     Size256B = 0x6,
 }
-impl_from_enum_to_u8!(DmaTrfCmdSize);
+impl_from_enum_to_bounded!(DmaTrfCmdSize, 3);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for DmaTrfCmdSize {
+impl<T> TryFrom<Bounded<T, 3>> for DmaTrfCmdSize
+where
+    T: num::Integer,
+    u8: From<Bounded<T, 3>>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: Bounded<T, 3>) -> Result<Self> {
+        match u8::from(value) {
             0x6 => Ok(Self::Size256B),
             _ => Err(EINVAL),
         }
@@ -215,25 +240,20 @@ pub(crate) enum PeregrineCoreSelect {
     /// RISC-V core is active.
     Riscv = 1,
 }
+impl_from_enum_to_bounded!(PeregrineCoreSelect, 1);
 
-impl From<bool> for PeregrineCoreSelect {
-    fn from(value: bool) -> Self {
-        match value {
+impl<T> From<Bounded<T, 1>> for PeregrineCoreSelect
+where
+    T: num::Integer + Zeroable,
+{
+    fn from(value: Bounded<T, 1>) -> Self {
+        match bool::from(value) {
             false => PeregrineCoreSelect::Falcon,
             true => PeregrineCoreSelect::Riscv,
         }
     }
 }
 
-impl From<PeregrineCoreSelect> for bool {
-    fn from(value: PeregrineCoreSelect) -> Self {
-        match value {
-            PeregrineCoreSelect::Falcon => false,
-            PeregrineCoreSelect::Riscv => true,
-        }
-    }
-}
-
 /// Different types of memory present in a falcon core.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 pub(crate) enum FalconMem {
@@ -257,14 +277,18 @@ pub(crate) enum FalconFbifTarget {
     /// Non-coherent system memory (System DRAM).
     NoncoherentSysmem = 2,
 }
-impl_from_enum_to_u8!(FalconFbifTarget);
+impl_from_enum_to_bounded!(FalconFbifTarget, 2);
 
 // TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconFbifTarget {
+impl<T> TryFrom<Bounded<T, 2>> for FalconFbifTarget
+where
+    T: num::Integer,
+    u8: From<Bounded<T, 2>>,
+{
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        let res = match value {
+    fn try_from(value: Bounded<T, 2>) -> Result<Self> {
+        let res = match u8::from(value) {
             0 => Self::LocalFb,
             1 => Self::CoherentSysmem,
             2 => Self::NoncoherentSysmem,
@@ -284,26 +308,21 @@ pub(crate) enum FalconFbifMemType {
     /// Physical memory addresses.
     Physical = 1,
 }
+impl_from_enum_to_bounded!(FalconFbifMemType, 1);
 
 /// Conversion from a single-bit register field.
-impl From<bool> for FalconFbifMemType {
-    fn from(value: bool) -> Self {
-        match value {
+impl<T> From<Bounded<T, 1>> for FalconFbifMemType
+where
+    T: num::Integer + Zeroable,
+{
+    fn from(value: Bounded<T, 1>) -> Self {
+        match bool::from(value) {
             false => Self::Virtual,
             true => Self::Physical,
         }
     }
 }
 
-impl From<FalconFbifMemType> for bool {
-    fn from(value: FalconFbifMemType) -> Self {
-        match value {
-            FalconFbifMemType::Virtual => false,
-            FalconFbifMemType::Physical => true,
-        }
-    }
-}
-
 /// Type used to represent the `PFALCON` registers address base for a given falcon engine.
 pub(crate) struct PFalconBase(());
 
@@ -426,7 +445,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(u32::from(regs::NV_PMC_BOOT_0::read(bar)))
             .write(bar, &E::ID);
 
         Ok(())
@@ -495,20 +514,18 @@ fn dma_wr<F: FalconFirmware<Target = E>>(
             .set_base((dma_start >> 8) as u32)
             .write(bar, &E::ID);
         regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
-            // CAST: `as u16` is used on purpose since the remaining bits are guaranteed to fit
-            // within a `u16`.
-            .set_base((dma_start >> 40) as u16)
+            .try_set_base(dma_start >> 40)?
             .write(bar, &E::ID);
 
         let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::default()
             .set_size(DmaTrfCmdSize::Size256B)
             .set_imem(target_mem == FalconMem::Imem)
-            .set_sec(if sec { 1 } else { 0 });
+            .set_sec(sec);
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
             regs::NV_PFALCON_FALCON_DMATRFMOFFS::default()
-                .set_offs(load_offsets.dst_start + pos)
+                .try_set_offs(load_offsets.dst_start + pos)?
                 .write(bar, &E::ID);
             regs::NV_PFALCON_FALCON_DMATRFFBOFFS::default()
                 .set_offs(src_start + pos)
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 69a7a95cac16..72afbd9101cf 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -59,7 +59,7 @@ fn signature_reg_fuse_version_ga102(
 
     // `ucode_idx` is guaranteed to be in the range [0..15], making the `read` calls provable valid
     // at build-time.
-    let reg_fuse_version = if engine_id_mask & 0x0001 != 0 {
+    let reg_fuse_version: u16 = if engine_id_mask & 0x0001 != 0 {
         regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).data()
     } else if engine_id_mask & 0x0004 != 0 {
         regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx).data()
@@ -68,7 +68,8 @@ fn signature_reg_fuse_version_ga102(
     } else {
         dev_err!(dev, "unexpected engine_id_mask {:#x}", engine_id_mask);
         return Err(EINVAL);
-    };
+    }
+    .into();
 
     // TODO[NUMM]: replace with `last_set_bit` once it lands.
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index e0acc41aa7cd..acf46ad0dba1 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    num::Bounded,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -20,9 +23,7 @@ pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
 
 pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
     regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
-        // CAST: `as u32` is used on purpose since the remaining bits are guaranteed to fit within
-        // a `u32`.
-        .set_adr_63_40((addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI) as u32)
+        .set_adr_63_40(Bounded::from_expr(addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI).cast())
         .write(bar);
     regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
         // CAST: `as u32` is used on purpose since we want to strip the upper bits that have been
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 802e71e4f97d..faa1ab58b4fe 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,6 +4,7 @@
     device,
     devres::Devres,
     fmt,
+    num::Bounded,
     pci,
     prelude::*,
     sync::Arc, //
@@ -143,15 +144,15 @@ fn try_from(value: u8) -> Result<Self> {
 }
 
 pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
+    major: Bounded<u8, 4>,
+    minor: Bounded<u8, 4>,
 }
 
 impl Revision {
     fn from_boot0(boot0: regs::NV_PMC_BOOT_0) -> Self {
         Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
+            major: boot0.major_revision().cast(),
+            minor: boot0.minor_revision().cast(),
         }
     }
 }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 934003cab8a8..cb712c95b0bd 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -32,18 +32,19 @@
 // PMC
 
 register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
+    3:0     minor_revision, "Minor revision of the chip";
+    7:4     major_revision, "Major revision of the chip";
+    8:8     architecture_1, "MSB of the architecture";
+    23:20   implementation, "Implementation version of the architecture";
+    28:24   architecture_0, "Lower bits of the architecture";
 });
 
 impl NV_PMC_BOOT_0 {
     /// Combines `architecture_0` and `architecture_1` to obtain the architecture of the chip.
     pub(crate) fn architecture(self) -> Result<Architecture> {
         Architecture::try_from(
-            self.architecture_0() | (self.architecture_1() << Self::ARCHITECTURE_0_RANGE.len()),
+            u8::from(self.architecture_0())
+                | (u8::from(self.architecture_1()) << Self::ARCHITECTURE_0_RANGE.len()),
         )
     }
 
@@ -64,7 +65,7 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
 register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
     "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
+    31:16   frts_err_code;
 });
 
 // PFB
@@ -73,17 +74,17 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 // GPU to perform sysmembar operations (see `fb::SysmemFlush`).
 
 register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
+    31:0    adr_39_08;
 });
 
 register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
+    23:0    adr_63_40;
 });
 
 register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
+    3:0     lower_scale;
+    9:4     lower_mag;
+    30:30   ecc_mode_enabled => bool;
 });
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
@@ -102,7 +103,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 }
 
 register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
+    31:4    lo_val, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
 });
 
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
@@ -113,7 +114,7 @@ pub(crate) fn lower_bound(self) -> u64 {
 }
 
 register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
+    31:4    hi_val, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
 });
 
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
@@ -138,7 +139,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
           "Privilege level mask register" {
-    0:0     read_protection_level0 as bool, "Set after FWSEC lowers its protection level";
+    0:0     read_protection_level0 => bool, "Set after FWSEC lowers its protection level";
 });
 
 // OpenRM defines this as a register array, but doesn't specify its size and only uses its first
@@ -148,7 +149,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 register!(
     NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0],
     "Scratch group 05 register 0 used as GFW boot progress indicator" {
-        7:0    progress as u8, "Progress of GFW boot (0xff means completed)";
+        7:0    progress, "Progress of GFW boot (0xff means completed)";
     }
 );
 
@@ -160,13 +161,13 @@ pub(crate) fn completed(self) -> bool {
 }
 
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
-    31:0    value as u32;
+    31:0    value;
 });
 
 register!(
     NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
     "Scratch group 42 register used as framebuffer size" {
-        31:0    value as u32, "Usable framebuffer size, in megabytes";
+        31:0    value, "Usable framebuffer size, in megabytes";
     }
 );
 
@@ -180,8 +181,8 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PDISP
 
 register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
-    3:3     status_valid as bool, "Set if the `addr` field is valid";
-    31:8    addr as u32, "VGA workspace base address divided by 0x10000";
+    3:3     status_valid => bool, "Set if the `addr` field is valid";
+    31:8    addr, "VGA workspace base address divided by 0x10000";
 });
 
 impl NV_PDISP_VGA_WORKSPACE_BASE {
@@ -200,40 +201,40 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
 register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
+    15:0    data;
 });
 
 // PFALCON
 
 register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
-    4:4     halt as bool;
-    6:6     swgen0 as bool;
+    4:4     halt => bool;
+    6:6     swgen0 => bool;
 });
 
 register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
-    10:10   riscv as bool;
-    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is completed";
-    31:31   reset_ready as bool, "Signal indicating that reset is completed (GA102+)";
+    10:10   riscv => bool;
+    12:12   mem_scrubbing => bool, "Set to 0 after memory scrubbing is completed";
+    31:31   reset_ready => bool, "Signal indicating that reset is completed (GA102+)";
 });
 
 impl NV_PFALCON_FALCON_HWCFG2 {
@@ -244,101 +245,101 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 }
 
 register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
-    1:1     startcpu as bool;
-    4:4     halted as bool;
-    6:6     alias_en as bool;
+    1:1     startcpu => bool;
+    4:4     halted => bool;
+    6:6     alias_en => bool;
 });
 
 register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
-    0:0     require_ctx as bool;
-    1:1     dmem_scrubbing as bool;
-    2:2     imem_scrubbing as bool;
-    6:3     dmaq_num as u8;
-    7:7     secure_stat as bool;
+    0:0     require_ctx => bool;
+    1:1     dmem_scrubbing => bool;
+    2:2     imem_scrubbing => bool;
+    6:3     dmaq_num;
+    7:7     secure_stat => bool;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
-    31:0    base as u32;
+    31:0    base => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
-    23:0    offs as u32;
+    23:0    offs;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
-    0:0     full as bool;
-    1:1     idle as bool;
-    3:2     sec as u8;
-    4:4     imem as bool;
-    5:5     is_write as bool;
-    10:8    size as u8 ?=> DmaTrfCmdSize;
-    14:12   ctxdma as u8;
-    16:16   set_dmtag as u8;
+    0:0     full => bool;
+    1:1     idle => bool;
+    3:2     sec;
+    4:4     imem => bool;
+    5:5     is_write => bool;
+    10:8    size ?=> DmaTrfCmdSize;
+    14:12   ctxdma;
+    16:16   set_dmtag;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
-    31:0    offs as u32;
+    31:0    offs => u32;
 });
 
 register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
-    8:0     base as u16;
+    8:0     base;
 });
 
 register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
-    3:0     core_rev as u8 ?=> FalconCoreRev, "Core revision";
-    5:4     security_model as u8 ?=> FalconSecurityModel, "Security model";
-    7:6     core_rev_subversion as u8 ?=> FalconCoreRevSubversion, "Core revision subversion";
+    3:0     core_rev ?=> FalconCoreRev, "Core revision";
+    5:4     security_model ?=> FalconSecurityModel, "Security model";
+    7:6     core_rev_subversion => FalconCoreRevSubversion, "Core revision subversion";
 });
 
 register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
-    1:1     startcpu as bool;
+    1:1     startcpu => bool;
 });
 
 // Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the falcon
 // instance.
 register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
-    0:0     reset as bool;
+    0:0     reset => bool;
 });
 
 register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
-    1:0     target as u8 ?=> FalconFbifTarget;
-    2:2     mem_type as bool => FalconFbifMemType;
+    1:0     target ?=> FalconFbifTarget;
+    2:2     mem_type => FalconFbifMemType;
 });
 
 register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
-    7:7     allow_phys_no_ctx as bool;
+    7:7     allow_phys_no_ctx => bool;
 });
 
 /* PFALCON2 */
 
 register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
-    7:0     algo as u8 ?=> FalconModSelAlgo;
+    7:0     algo ?=> FalconModSelAlgo;
 });
 
 register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x00000198] {
-    7:0    ucode_id as u8;
+    7:0    ucode_id => u8;
 });
 
 register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 // OpenRM defines this as a register array, but doesn't specify its size and only uses its first
 // element. Be conservative until we know the actual size or need to use more registers.
 register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]] {
-    31:0    value as u32;
+    31:0    value => u32;
 });
 
 // PRISCV
 
 register!(NV_PRISCV_RISCV_BCR_CTRL @ PFalconBase[0x00001668] {
-    0:0     valid as bool;
-    4:4     core_select as bool => PeregrineCoreSelect;
-    8:8     br_fetch as bool;
+    0:0     valid => bool;
+    4:4     core_select => PeregrineCoreSelect;
+    8:8     br_fetch => bool;
 });
 
 // The modules below provide registers that are not identical on all supported chips. They should
@@ -348,7 +349,7 @@ pub(crate) mod gm107 {
     // FUSE
 
     register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
-        0:0     display_disabled as bool;
+        0:0     display_disabled => bool;
     });
 }
 
@@ -356,6 +357,6 @@ pub(crate) mod ga100 {
     // FUSE
 
     register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
-        0:0     display_disabled as bool;
+        0:0     display_disabled => bool;
     });
 }

-- 
2.51.2


