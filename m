Return-Path: <linux-kernel+bounces-886645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EAAC36341
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835C76226FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F54315D57;
	Wed,  5 Nov 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="bhcPEFwg"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021073.outbound.protection.outlook.com [52.101.70.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F36245008;
	Wed,  5 Nov 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354173; cv=fail; b=TC64IjttmppS6xyEWrMM34TLmI40pTmZPXOG7IId+moBxGd+BHaAhGmVJwEFtJYiZgD0Z1sOMFsGb+7dYLnpWOPCnqwbu+wn0YVSGkmXpIMCAyM1gac5op+A+qSp/k9EucMYv1GKao4z5Sb87XsuEtaZYuBD6k2uhFTs1G9zIWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354173; c=relaxed/simple;
	bh=MeRWW6B9qRz3mVpryUUDQC+lkP1DdM1l14/PeNjhlfY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=BpOO1GpcchbS37smW3a79ldeB5riNHk6yBEjA3ckdTDwLI0QvWIA6p0GSKDysfAKZFDb66pHwaESw93YaOy0Z9SZuxW2dZ+mVQNlyH1U+qU/X2V4fc1AgGZ1VEjkgYyxu0hOnWrfocdzULp++1UwlZzKgkb+N+esP03nfDu8vdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=bhcPEFwg; arc=fail smtp.client-ip=52.101.70.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxt9jtu+4hLxtnevngYJvx9sW7mLn4kNQleRvV847PNHOpqVKE9Cozl1kWOp7obYrEtL0vSlD00qjkj5jrcbky9zwpfd3GpLU593MyMKqltKeO4f8hEmQsycowWDeAwDCENYAg4tGHyy/ZlMPmxMqn95OeKkaAqiyuqxbbV7NNsdSB4gZmVqCSYjZp/N+gRYWHaUJchguGBBI3y8HLUYhpGXc4ClmtjOZTh52yt5xvS+1RbhN342gqU7sucjPc9Q2O2G0P7alP2shji+O9IfAbnxDy4TNpcci3q2LaSK9tsSQJOkEQhPZwKoBK7e/con+O7cyLUv9XpKcxoMGOAB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxpw7uGgnc+BXNc/9BM4K/Om2gfeBp8lpxWRriUEh78=;
 b=dpDGDRh2xEjF4de5BDwSLZYZnakos70qJ7urRaC6fYb1ra4krlq5B6xeRw6qrBma6FZP0WtdxkNDfbE98p5sBq8e8Y4hUgsxgku+4AGFa2/3jVdtOok+1suyOWpE/B6WPz9bNWt8Nut+Awp/XGBrxwHqFbHkxW4KCd9KV0Ta++Jawex/5Y0E1ijE5BNhU2oYOBJh4OP7OEUSwVOfnBThpbySBT7wxDSYN1+npvdC5o9gn7bnQgw7wm9czexvqbCvmwHtysFJS5SMRcDq1Epri6ox1g2Bke6vwEe6K5TJMndRuqFF8SKbn0Cx54eVvcd5BlKV9aOwnhDeTii1NyFR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxpw7uGgnc+BXNc/9BM4K/Om2gfeBp8lpxWRriUEh78=;
 b=bhcPEFwgpSmUoTwCZ20PM0WpWHJ0gWB/J+6NDvRrvTJY4Sv+m7dsuu92SMznxWHPkEkEZrJWtpgU6Ls4RtQLjiretU0v320FjIVGnRwhtXuBmPRnU8YAyJ3RThwf3uHkQKhhyhbqnNtR4DOZ/NmeqzEQgXkL41ladWORENqoYHr16BcmvaXjYf9VXWUmjt4niqVocnuxjL2KvdsmJ2EJzK8gXxAy8KcGDLq+o5J1YmLEW9Bz+LjXnWyvdwj0CgTacVjUAs902UNTzAyZBN2Wrq1Rr3krIvP4P4Fc4esgiIJXscZU7QxnBtteRB6bcWZkTbrXUbWOOnmb9ro0QkRFwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PA4PR06MB7215.eurprd06.prod.outlook.com (2603:10a6:102:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 14:49:25 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%2]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 14:49:25 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/2] mux: gpio: Add external mux enable gpio
Date: Wed, 05 Nov 2025 14:49:11 +0000
Message-Id: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOdjC2kC/x3MQQqDMBAF0KvIrDugoVmkVyldTJyvDtgoiS0B8
 e4NXb7NO6kgGwo9upMyvlZsSw3DraNxkTSDTZvJ9c73wXkWVUY9kJOs/P5URpK4gufdNh5DFB+
 hqvdArdgzJqv//vm6rh/G4AfCbgAAAA==
X-Change-ID: 20250925-add-external-mux-enable-gpio-c9ba5beddd49
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762354165; l=897;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=MeRWW6B9qRz3mVpryUUDQC+lkP1DdM1l14/PeNjhlfY=;
 b=/ebYzABb/UIUQvMrb6Mwf7lMWstfVFJgk6GB+Ym0i/tn5nGJZa2t1Cgvp4beMIsDf5WlMtDKh
 5YuhDEeX5vdCMOUcJBpdIHbNvUXYVWh01DKAjk9FClnrDHhZEECJYYR
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00003826.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:5) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PA4PR06MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4016a3-d06e-4a86-cd2a-08de1c7a83dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXRMVVZkR2NvN1YyVE0xaVora0xRdTRoMkRIZHJUcmhxaitQSkV5V0hqYXFh?=
 =?utf-8?B?cS9ETDhzWUVISTVVUFJURThvYTI4RS95SVBWU2N2OWxCeXRGMGpHTG42bmRy?=
 =?utf-8?B?RWphL0pRb1dwaW5JV25FT0ZCSFVKdjVHbWoxM05uVkVxZmxNaE15VG9ZSHFh?=
 =?utf-8?B?L0o5WnVzSWZQS0Jxd1N1UE9LZml4ellPZEo1MU11SjVmdmdxZ3lKVVQrQzlB?=
 =?utf-8?B?NlcwdG43cG1XTFdSUmQxQzhKN0RYSEpYdCtvZkZTdEFDTzVmQURvZ3VsMG9V?=
 =?utf-8?B?NkpaN29GdGc2Z0FpVk84RW5Ndkdvb3FkVVZrWEJPRndYZmFRUDV5K1Y5QmEv?=
 =?utf-8?B?RnNnT2lWVGplcDc5NS9CVWVvblRvYk1WcFRCN2h4dWVFdFRVRHJUTDRoVW9a?=
 =?utf-8?B?UWxVb2k2MFU4VVB3NDIrRGFDTlc3QVcxbEZUOUFFQ1p6SHAweXRzZ1VJK2Ur?=
 =?utf-8?B?QUtxcUYvOVd1bU5jNlNiSHJkZHlTOTN2OTVhUkJoRWpoNGhDeE1KN20rNFJu?=
 =?utf-8?B?NGFZMGdVMDZxWXhDNlJFRHcreGMvSUp1d1pEemhVMWtPaCs0RlBONUZUYU5l?=
 =?utf-8?B?MEFsRnI4eTNiV21WRmg2eUNjSHpwL2txakFLVFZBVzhwODM2TWNXNVRieE40?=
 =?utf-8?B?bDU4dDhsOEtoUnFSNUdrVnYrSEY1WDMyZDlxM3JlS3doQnFUODRwTUloU2Fz?=
 =?utf-8?B?a1ZSV0U3ejM1K2FXcCtERkJvaFVTckl4SzFQZitaQnBDYy9LRjNxRjdrcUZi?=
 =?utf-8?B?RWd0NVZ4YlRNenFLZ1dHaEVBNnFWYnI3QXpSeTlEc092TFVBNGlMMlUrRFVw?=
 =?utf-8?B?ZndBZEV6a3ZGSGMvN0YxZkUyYWR1QklmeDNUVDRMVHVyWEF4c1k3Ty9OUlBr?=
 =?utf-8?B?cmRleEdkZDNGQ0FLRVd1OG8zWE9STEJqNVcwQUhLVVZNbFhWTU5rWEh4WUE1?=
 =?utf-8?B?b0R1bE1ic1NkbmU2c1E2QlJPT2JrWVdVeDNaY2ZGcFVyWE1LNDlodXYzanh0?=
 =?utf-8?B?SXBibzcyaFlFSDVaUGp2RkVQYlc4OEdBWmppb2k0L3dZejRnck5pbGxDcVVk?=
 =?utf-8?B?Mm5VaU95S3duQzBJZFlVcXB4RjQxVERmNStMZ3Y3b0V3WTNFWGN5dUtadlhv?=
 =?utf-8?B?U2d5d2NRRzVSa2tnTjYwRE00ZHptRjJWZ0FnOXYvd2JnUU5MZW1UWGYxZ3BN?=
 =?utf-8?B?UGl3NjFhSDhDSWxPYWhud0J2V1NSQTYwWDBMVm9NZVk1cUlCVzVRb2tMaGMv?=
 =?utf-8?B?NWh2NlRaQjh5eTlacjUrY2ZJRWxnSEw5aWNTQ2F2dXJ3VlhodUtaeDZMUU5Q?=
 =?utf-8?B?MTBEYzQ5dkhFTDZESnZxay9kNlA1aTZmSFFMZWNieWkrVWNLRDdNQ082MjdR?=
 =?utf-8?B?RkxlbkVUNkFqS2tIdVpvQjJJSzlCaVljVmw4Mm9GV0xmODdCVVhLanBseGtG?=
 =?utf-8?B?KzhhSUc5dmRZWG45V0ZqUk9Wb1NNZFNvZUs2b3NVTytwaFhrbTd3RnBic292?=
 =?utf-8?B?ZzRkNzBQdS9DZUtRNHJYd05acFE2TjFHV0VlWnBNMEdFVnlxRDZVcVVDY2J3?=
 =?utf-8?B?YTB4NUdTWVY3by9uSllrdW9zTU1KR2xIV2gzNTBaN05pTDIramk1aW4wVkE0?=
 =?utf-8?B?VUJIaVZWWWpPTnFDSlZyb2g0RXVSd1U5SDV4WHRYYTdZOGdRUk1rRkRjeXB4?=
 =?utf-8?B?b0JPS3JmZVp6anZ5aUVvdmY5NndISmxwS3pQU0Q5TEVmQlhLdUI3TWQrN2pG?=
 =?utf-8?B?T3FqUHFEYmk5K25WWlkzTytFTjZKWUFIUWZXOHZLU2FuZFZEMlgrWDVOVHlY?=
 =?utf-8?B?WmkxMlBJYjg2c3ZMcDVWUGhhbDdpTk5OdnpTVTk4VjBFL0F5MDlaVDVJR0Rs?=
 =?utf-8?B?MjliSkZWZEM1bmJvZitMWmhNN2xsY3Q4Q0F5ZGRBWnlFeEJEZ0t2a1V6cE9r?=
 =?utf-8?B?NWxKazRTR0hHdHRlL3NWRXFjTVE3dFB3cGoyaEVRUDBYdDIxdzRCb3NzdlJ4?=
 =?utf-8?B?WkhweFlIMVBFNDdFbC9ZdlFtbWpKQytMdE4wcUgvOXY1ZDdLWnpURS8veU90?=
 =?utf-8?Q?4QVa8P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEw5Rks2WjVZdklIQWtuZzlsMXZaVlZLOHdlN3FkNHVUNUZYdlFNd1NHSE92?=
 =?utf-8?B?L3JLZTVuUGduTElURCsyRUVOV3phVWVLVG5HWEtZNHdoWm5CWmdDcjFDR0sx?=
 =?utf-8?B?WW9VUGVmQUp5Z1FDUytCMHN2SWFMNm44bzRjUU91U0pRb1lUd0kxSjdwUEtz?=
 =?utf-8?B?QW5vVHVRd3o4UHJUdDJmb3h3TnFaTWU1UVVOdWJHVlB6a05CUGN1VGtnem04?=
 =?utf-8?B?ZDg5aDJPOWc5L3IzaG10OUpoRjRYNVNGVzBxR1Z6ZmpCaXZTbEJMeUFSU2wx?=
 =?utf-8?B?akpTUTc3OTNzdlhQdjN1L01WTXE0V0NHNGNkY1ZLWDdhOXVEbmVpeGJXcXUx?=
 =?utf-8?B?ZlJQeWZTbXFHcG44em9aQ2xDK1RiWVdiZDRleE9BSVFhMGZkZnRzWTVtMGM3?=
 =?utf-8?B?aXlIdVE3WEhSOXFWOEcyUjU0RzhhQ2F5Z0p0SjJvQzR4WmppNVUzZGE5ZHJD?=
 =?utf-8?B?U0tNemluUGJWUnZRZ09RUjJiaTMrcnYrOTVodzJWNHI5OEZtODBwQ3Rzbmsx?=
 =?utf-8?B?bjFqRkh3K1BjdDN5VFN6RVBJb0JyVjNGMnFzZVNnVlFTd0JtdUtjWmh6Wi93?=
 =?utf-8?B?L1pVOS95L24zeHRTeGVZQ0tObDBOVGJrTk1leGd2NUNpaG5yZHdhbXpHRXVT?=
 =?utf-8?B?UUtWbjNJVnhhWWhNNnhhZ29WTVBkK1ZKSi9lT01BdGdGMElqZ2MwTkplWkMv?=
 =?utf-8?B?aW1rR0JUd0tWdHUxM3hIWGpmMkVGLzY0cTVuYVJmUjU5Y05NMXFZWTNiZDZT?=
 =?utf-8?B?K1lYWFRSb2hWd3ZNdDBldWdCZ3RTSVlYNERQOHg3QmN3dGRSVVlDRkppQmNw?=
 =?utf-8?B?V013Nk1pNTNDK0pwNisvY3BGa01kRFVQenV3K1FnUnZnOXoreFd3VlFvSWRo?=
 =?utf-8?B?NWxyVzV2VXY5VkgxdGl3bzR6blFXOVlyTWd1cVc0R2J1Q1pBT2s2NnZ6M1Iy?=
 =?utf-8?B?c2pQNUVxa2xCRkZBdlRJbmxnbFlRNVZWbDFvUENGWFZFOWNxd0FFSVY2anFD?=
 =?utf-8?B?QnpJNWxpYUtBOGUxMVZCOER1a0Y2UDJyakVXT0xjR3lhOFdzU0hJOWcwYnBP?=
 =?utf-8?B?V05VSkEzN1pGcFJ0SGwvSE5kdXR1SW9SYWZJRFZobXNEZXFCNHNsYnNEV0FF?=
 =?utf-8?B?U0NzZHF3NStqd0VJdG1iSHQyUXluZTN4VmxtbWc5OEdublF6SDkvTkdnekhh?=
 =?utf-8?B?dm5GcDRaV0xLditvUHFWU0hRb1ZSYWgzMm9YUVMrSVJxSGRPQ3VuYmxueDBY?=
 =?utf-8?B?ZzhTR01heVdvQmoyQjJBUHdFODVtOUVrM3ZESDFOWGdqd2VOQnJxUnNyQWxj?=
 =?utf-8?B?M1Jyd1RuMFhzc0FtSmFhbW1YVDFTZzg4MUZNR1E0cDNpUGxsSjJRN1BSME81?=
 =?utf-8?B?V01JRnM4Y0RCZTY5a29Rck5hV0Z0RXJwZ2YvQS8zVi9KVjVJQTl0S21ibjY5?=
 =?utf-8?B?RGRSR1JiekxwSWE2RnhNaGJJT1FTYmxPaEswdUIvTmxKYUhCem42Mmo3M3FQ?=
 =?utf-8?B?dWlXUTBBTTJVcEtpdGhuejNrU1g1RENITnhmMko4SGpWT3lTNjVrcXRRRGl6?=
 =?utf-8?B?eXMySmhWZ0NOeEt3TDRuZWZpNkplNkxiMG5KWTN5Mmt0UmdheVZPeVhkQzFL?=
 =?utf-8?B?K2ZPbGZPbUR2bXUzeFZaV2o5NWVjRnRSRmdIU09UNHR0Yk0xTmg0aXNXdzR2?=
 =?utf-8?B?N1FrY1hHb21LOHJLNTNxemwyWWtKZ2J3MUhXbzVWL1BBVWtGaUVFdklqYjN3?=
 =?utf-8?B?eVU3UFNlV0U5UnRkZGVtZXBaT2w2Z3I3Um1sNEVkWUNZVFZ0Um81UjAzTUZq?=
 =?utf-8?B?cFg0NW55UmY0b1JiSzVNZ1FzREZzb3Zzay9hOHdKSEdFY1JvYjMxeXdkbVpX?=
 =?utf-8?B?ck83R3Rqc3hRdy9CdUtDT1JTMFQwN0ZGK3Z3KzhYNlQyNDRsRHF6ZUYrUEpY?=
 =?utf-8?B?bGVRRmxXNWJNank4ek5CV2FralFMRUNBY0d2c0lUZjB0WHlZbkU0VTgxUjRB?=
 =?utf-8?B?aDJIRGpnSG1UTFFqR3d2bFFlWE9vMGF1U3pjZHFmdW93NXVyZDRodi8rS0pS?=
 =?utf-8?B?V09ValBjMUF6MysrZXM1WVQwdEpESDVIVElqYVRmNmpUVGtMek8vMld0ODM4?=
 =?utf-8?B?WDR1dGpoVjA5NnpidE9GRUxKVS8zNi9MeUFUYjQwcDRWVisrTFNVeldUSFpS?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4016a3-d06e-4a86-cd2a-08de1c7a83dd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:49:25.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66LEgLZmor+ZMQt7FYG/hHijZY2/iLHC7HTRX0R3pFFjZsgL1uV6jK0kBUgGCPL3RKKP/hrkZzwBqrbWr5ZZsN92QUvgu11QHaOJOViomRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7215

The output state of a mux might be misinterpreted
during transition from one state to another.
Using a dedicated optional gpio pin, the validity
of the mux state can be communicated to connected devices.
 
This series adds support for defining the optional
gpio pin for this purpose, along with documentation.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Tapio Reijonen (2):
      dt-bindings: mux: Add description for enable GPIO
      mux: gpio: Add external mux enable gpio

 .../devicetree/bindings/mux/gpio-mux.yaml          |  5 ++++
 drivers/mux/gpio.c                                 | 30 +++++++++++++++++-----
 2 files changed, 29 insertions(+), 6 deletions(-)
---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20250925-add-external-mux-enable-gpio-c9ba5beddd49

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>


