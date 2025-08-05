Return-Path: <linux-kernel+bounces-756865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEECB1BA88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991E4184DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2273129A333;
	Tue,  5 Aug 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MLpJF1VW"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2110.outbound.protection.outlook.com [40.107.236.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55D2E36F6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420369; cv=fail; b=O7SNgexYLG9wM+cTF/gPUvfC9tFKYknXwSo+PLsUWTJQptXWtjjTP1GRPg1369l3QnRZiNM7OaThifwhjhi1LixKo37SBfs1Bp7AeMQR7crQZXvMCG0YwZRyJLDTLHRK7ap4/s2bArbBg5RvT1+exQ3C97wskbUReYbXYYrZAAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420369; c=relaxed/simple;
	bh=W+K3AAhN7X89SKXjz5/FM8qTC71KCKk6f+QM/GH7+14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUu6qeU49mud8TmS3pHJjuVCi57YVJjF5KcBz40TT9QR3+4g5j8tzCBIW3TkxNr2E6C5URoQGTMOHMuKtJ/CEZIKHLEtrX1kD/suOiUYDJ8q+3iwoBjzjqLuvN8HoK4DDdbzMCMkHaqzVwj4ttmwGxbfeo1gM5zlPL1nbnvuy/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MLpJF1VW; arc=fail smtp.client-ip=40.107.236.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPOh7LTfJ25Q0oi/KZ7EDa9UCpLjjrdMkwbejiyvjw94PavXTxAM8YtPDC0IPxJ/LUFY+OAR2uK9cQ72WQPWPwkvoRMqA3y7pz3UrxwGXuL0+uu+09YcLEVryAKet91PdebSNtJuRJg6DXy3YkgtS505AVjGRFwWK2xbltiaPA4gYQhOV/nqAbThyILGrqH07HObP2sOs66He7p4bKoauEWgu1AU1RwFAztFfSPh1zy4VDPz+m/kpxeiJNlL54/GwqXoieV7fjqphqiN5WZvWeSu9DzvEKtX0x62S3k5AF8PfXqU4m4rMD/J5M3po1mLsSEqZGhrNp7gBZzD/8ZFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzaT/rP9wAwGB2V856PEXxEArksTiWec0lLrcAeqelo=;
 b=pxnaay0Jr7FvFAUET9y3Sf0d2g4yKJHJh6yNzKjL4Ec/kHTKCSINhwc3s7PtjsjuzUhfoiIZWyckurkfYlnrLmzKuzXxQ+2YBExhehl3DYP/Q/s/lbVpxKg58jeBdXvk9UDMhEcgDSZTAiOtsdiwghVu2nFfM/0INoyWwjtN+ZVp2yAuc8hy69Niq3cV4UGI0YI7MKAWu7P+LzccozlnuaJvK0wd7o4cHfDiaTy2RSw848ZJpRMlB1BHsX8V7dALIiNDb4y7FUsLo95YtPtNUPD5Qm+/RkSmgxdwx735byCZjlX8izc48/r42+K/2scCKvG48mHZCBA6K7V1C/KTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzaT/rP9wAwGB2V856PEXxEArksTiWec0lLrcAeqelo=;
 b=MLpJF1VWMTmPiJm9P/CQ5FVUj9urScWBYXhkI2JYDpdCSNHoXV1pVrYAF44HrakA66IciTDNlOBeqLH2pDRLS6XCZvSI7wNenyLZguoqJ5oU5l6DZlNkHUlHImIsi0HrIC0AFp2mHJzlQT2g7gfTpHQ6bLeykNIlTaa0KQizTtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ0PR01MB6461.prod.exchangelabs.com (2603:10b6:a03:295::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Tue, 5 Aug 2025 18:59:21 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:59:21 +0000
Message-ID: <d7072748-8bf4-46c9-86da-ee698e494288@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 11:59:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: mm: split linear mapping if BBML2 is not
 supported on secondary CPUs
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-5-yang@os.amperecomputing.com>
 <737dd4f2-c48b-449d-bb37-2f7ee0eb8fcd@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <737dd4f2-c48b-449d-bb37-2f7ee0eb8fcd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR22CA0089.namprd22.prod.outlook.com
 (2603:10b6:930:65::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ0PR01MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: db670fb6-a999-46d1-2ef4-08ddd4522fb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qzd2N2Q2YWdaL1V5YW9PQ2pNVkdDL3UxalFiSmlhM1BzRDRWT3UxTGdhbkND?=
 =?utf-8?B?OUlYNHlLZVhVck5uWFhEaitKVW1NenRHTFEyVUhIa2NqeWZRcHB1RUdnWXpi?=
 =?utf-8?B?N3FaWTdMUkNqYmZOSlRZcWpmQU5kYkQxMHRYVlkxdzBncE9nbkFFTFVXVm43?=
 =?utf-8?B?Ym01Q0tFYldEbnlaekZiMEtzbGtKSDRnbEJIVzRYQ3ZNa0J6N2xBK1FLVWIy?=
 =?utf-8?B?UStoTGttTm5ZUVBzTVJkTjBtQms0bERqdVRncDR0YmN3cUs0MXNqVEVLby83?=
 =?utf-8?B?djVkbFJRRC9iL3M3dUhtZS8zSWtkWjA0cDZFZVNmdDZmTThYZXJienJPZ1cr?=
 =?utf-8?B?WTVIZHo5RE5UWlp6V005SDNDTlJoVEtWWGdjZFVZMWRGUjhMZnZpOWowWWtE?=
 =?utf-8?B?cHBKR2Y1b08zYmYwN3F3RTlpbk9STTdnM2d1d25vUjRPMVpFSjJ4azlkaHh5?=
 =?utf-8?B?L2x0bUVheVpmUzBxYVRjS0ZWdmZubWkzZkhMMUZxM2UwcGw5aWlkZWl0Wnk3?=
 =?utf-8?B?ZzRMSnE3MEVlK3J4S21qNkdTS2VlZlFPOTUxVGw4Wlg4ckhDdG12Rmpmb2tx?=
 =?utf-8?B?K1BUS213QnhoMWdWU0JWcmZoK3hvQzJES1pZeFJvUEZjVit3S1BSd0tqd0Q1?=
 =?utf-8?B?QTFyN3NIMVZjV0VhelBwMnlqNU0vM0dmdlBjME1wc01ESmNjUklPcW5Dc0hR?=
 =?utf-8?B?ZXdBdGRDNFdjamtMZnpJUU1zVlltbDQ0T3p2RllzQnh0U1VpejJRa2VuUldu?=
 =?utf-8?B?QmVWcjZrbE8rY0s3dGR2UU9GbTVpKy9acVNYcU51RFE3TXVONnF4dm5PMW9C?=
 =?utf-8?B?WG5QOTdSRkdBWkJiWHJPNGF1b1BYNHRSaW9zaDVFalA4ZzNtNUJzQkJ6S01D?=
 =?utf-8?B?TURKeXVIZEN2dGZYQzdOb0ZzTU5JMkNTY3phMGEvL3BOUGhVZXgyMm1ibnFv?=
 =?utf-8?B?dGhZV3hEY1JydkQrZkNvVVh1R3hCdm9hMmE5eTdIMUthdmJYMVFSWWpkcXBI?=
 =?utf-8?B?NnVucFd6cEw3Z2RjOUk3R1R2QUhYbHBHVEt6NklaY0xlZDhIUm13eFJXWk13?=
 =?utf-8?B?N2JROWVkNHBpeW4yR1VIT3ZlTkxMWmpmeGNlMVNRSlJvbkgydUEvbGhVek1q?=
 =?utf-8?B?SXc0cXczKzVBOFJTaG5sV1R1QUg5VUs5TDhpODdGUDJSZTlwZWprN3B0REQz?=
 =?utf-8?B?clRXVUpMR2NZbFlrR1pWSFJ2a0lvcTNraFdlclFwWWtFV3BhVGtpYVNTOEdG?=
 =?utf-8?B?M2JmSlpoR3YzUVlqNHVTUWx5UEpFK2ZDdy8vNEdiSi9EZjZJYzJTN3M0ZVA2?=
 =?utf-8?B?MHBLci91L29LMkdQMVNSM3BSRTY1T0NlemgyeHR5dHlQYThScEpKUk9ZYlFu?=
 =?utf-8?B?Ly81K1FDMDBHM1BIcWIvTlRzUDdNTzJuRmZkU1oxaUg3SDM0TWFjTnJqNTNO?=
 =?utf-8?B?MEs4QVdiOThwRW5uNVRRUEtEQzFiUm9IK0hiNlNuQ01oRjJFWGkrYkxaa3N5?=
 =?utf-8?B?K1VJeGFWZVBMcE91M3NFSDJ2VjNjZ2VWQjB5YisycWlyeWxMLzdGY3JHRS9s?=
 =?utf-8?B?VVRkNk8rNS9mTERGNkVKK1FwL2doQ0tFdG5QcFpqMGJBaSs3WFF6ZmJPL2Zk?=
 =?utf-8?B?UnhEbG1OVndMRUtQd0RJN1RZUzZZTndDb21yOE1GdXdxM2svOTlEQkdVVVZr?=
 =?utf-8?B?NlJHb2ZrcXk5VTE2S2JMQ3ViMGhKZ2xJV1NMVWRoTVNZdWdaS0VhakpjaHRn?=
 =?utf-8?B?bTYvMDl1VWoyb1YxQ0RDa0VYb1VjNVo2YUxNZDd3aVcrTVRVYVVUQzhjOHhm?=
 =?utf-8?B?emhqTkl0aVMrUjFGajltOWE2ZFRmWnY4OHA1WVFJazUzRlZhMnc3NStkZGhm?=
 =?utf-8?B?Ti9kV29FMER2SXNLL0t2RlVuQnNqUEZPSnZrOVdnWCsrWklaZUNSWWdjZ1lS?=
 =?utf-8?Q?UcJNBF5pNWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUQwd2s1aVVxZUlNdmJzSkNMcnhzbEpaNVE5bXR1SnhYOXpPRWJBbGw5TE1R?=
 =?utf-8?B?YXFvQ2lWTXBCcG1oNVEwY3RRaEdXZUVUY3FQZTYyU01pRTR2OGV1eThuVWxt?=
 =?utf-8?B?azZ3OHRoMmRRcEErQ3ByVHRJeExYQXczRmxBTnVTdXBDVzc3L0E4allkOVo4?=
 =?utf-8?B?OENKaW9EYXhVMis3YVczRzAyTFZ5aHp3bVo2UU9aVjJGRmkvWkttN3lleU03?=
 =?utf-8?B?dlJ3b3d3b3FzaWRIVndObGJJckZxalNBcGkvaDFzSXpjVHp6aFBFMDBxcnZ6?=
 =?utf-8?B?bG40WVNEbmZ3OHUzU1ordjFBeHdmSkxPY29OMmxZNWUvV242TFRzN3dxenRy?=
 =?utf-8?B?WEM3VEkwa01iL20xVzRmUy9lUzhpT0xYN2lqS0c3b1Bkb0R6anZTdUVkblk5?=
 =?utf-8?B?SHI4a3VLeWRtSnJaazlZVWpRelAvVTdjQnl0c2NyMGo3UXlwc2J0cXZlTmZi?=
 =?utf-8?B?V2FQSjZVWDJHMUpKMHpVWVFtSm1LWWdwdFg3RGRJakM2S00yL0NQaW85N2ha?=
 =?utf-8?B?a1ZvZUNibkU3Zk00SnNHd2U3dUwyVCt6R3hPUlVJNUk2Z0hjL1ZoQkZzSVE4?=
 =?utf-8?B?TGdncUFXTU8veG5aL2hjenV0L3A1Tlp0V3NDUkE5OXRQOFdhMWxWZWRTbks0?=
 =?utf-8?B?NTVTWFpQcS95LytNcWpGK3JWTCtScEVlMFRJMTZsSXNvRDczSUJZbG5YVWl0?=
 =?utf-8?B?Q1NxeUZkYUF4cTVEOTM2bThidDl5dFVuMWFPREl5QVRNMVJUNVNsWVRkTVRk?=
 =?utf-8?B?M1JBNWR4WWtWejlYNjRFNmZCQ3JqbDlxVlhXdUtaWnBaU2pZdWp2Qnd2NTZx?=
 =?utf-8?B?NVljR09vRWk0SWFtS2VJUC9KVkc2NXZhVmp0ZXkrSExiOERYcW5RZGlkYzFw?=
 =?utf-8?B?ZXRQM0tocFdaYUVXRzN5cnhWblFLMk5CN05ldjRMUkx1Z0ZJNGJteVpiMytu?=
 =?utf-8?B?K2NGTVNqRzBmbmtTT3VlVy9KcFZxajdtamV4RmUwQ3h5cmorUDc0eUZlSDQw?=
 =?utf-8?B?QWl3LzJMcW9oa05GMm1KWmxpRmY0UmZvYUpMM0hhTTc5VXBMWWo1RHllc0c1?=
 =?utf-8?B?SENaZGNYK2w0NmlGWXR5VC9DRVFnTEJDY1JrZ1AvaisrbExGaURXNjM4NUl0?=
 =?utf-8?B?bkhpWkpiQkNsN2tRc3dCdVllOE5pbGlRSGdIV0krSE1JWWNzcWNRNmVvMkN1?=
 =?utf-8?B?dzZyUkVhVHpZMHVhdy9hZUNtUTJhM0M3ZWpDZDMyemVqTDNQeTdJc3U0WmFV?=
 =?utf-8?B?ZHh6eFFIYUZnTnE1WXR6N3pjQXhydjJqUHpmMkhwcnA3Y2VHOG05NDNSNGha?=
 =?utf-8?B?eTh3SnJTRjVlZDJxdzgyN3Z3bTZ3OHZjMDRSWXhqZE9HT2NzcHhIQzBaTWpC?=
 =?utf-8?B?QjIvN3ZZdHFtV0pQR2pNbU9VNXk1RmlFaFhKUFVwOThoOHExVkdueDVLN2Qx?=
 =?utf-8?B?ZHFlRWNsZUdlVS9YNlkwUWxBVDdDSzY4ZFJHSDIxVWVGdTJnbS9JcjdZb0px?=
 =?utf-8?B?Tkx4MUxqU25iV08vSkIxeUlnVkkwamhnS3BSTmJvMllBTTZrbXcrMkFpVmVo?=
 =?utf-8?B?L1lzZHBQSWJhME16eDRqQUdXV3grT0pyMXRGY0c4V0tHVFNKejkydDh4ZTM3?=
 =?utf-8?B?OGo2VVpPUUZ1ZkhTVm13TVBXNXMvQlZtT1BZdzJDVnpySUVUT0dIaUNsTkUv?=
 =?utf-8?B?eC9WaUdwMWlEcTZjOG92MkZoRGJsNVJjS0xhWmVNemZyTFlSVVVGemZlQWFu?=
 =?utf-8?B?V2Q1TWoyUm9sRWJzNjBCZ3I3eVBPeEg3YklMd2pYZEFyaUFlYmdsQ2V2cnhO?=
 =?utf-8?B?UmdhRXFmLzYwZVh0V092TVZNUXVvSjQ5NTNvQjg4NFh1c3VjVENVcmE4YkZH?=
 =?utf-8?B?ZG9DMjNnRmhxd2d5Z29RS0pqVmI1RkxCZUl6RENYN1VOcXFqQjQ5U202M1lB?=
 =?utf-8?B?OUQ4T2ZMSGtRdGhSVE0vaE5uQ3NqM3NLVyt0RTdHZjBYaHZobHNaNkRkNFBR?=
 =?utf-8?B?RVNDMEJxSVNsTWxSbkNwRnV0UThmL1BhWFJ2dm56OWYyTVEzeEZhVHJVbVNB?=
 =?utf-8?B?MjNabWpBcHgvQ2xKbmw5WXJFWHVyWkxEVnphdjUyUHJndURHeXgzSUg2UDJG?=
 =?utf-8?B?ZkhYb09QYXcySnRreVlKcExEMXB3QzRuQVZUNzY2WitIZEFDckxrWFRRVVhs?=
 =?utf-8?Q?Lth0H1HaSIIfTyxKiHFeNKE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db670fb6-a999-46d1-2ef4-08ddd4522fb2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:59:21.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyzuoLtyM985NIiXcwgphrRyYCwre6D7tT8+kkaQmRMMVkXqsenwjHcnPp0ob6dGZyVyX7MnL2b1P1YklaHVWSOPEq3Y6P6a7kcG+LjMFXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6461



On 8/1/25 9:14 AM, Ryan Roberts wrote:
> On 24/07/2025 23:11, Yang Shi wrote:
>> The kernel linear mapping is painted in very early stage of system boot.
>> The cpufeature has not been finalized yet at this point.  So the linear
>> mapping is determined by the capability of boot CPU.  If the boot CPU
>> supports BBML2, large block mapping will be used for linear mapping.
>>
>> But the secondary CPUs may not support BBML2, so repaint the linear mapping
>> if large block mapping is used and the secondary CPUs don't support BBML2
>> once cpufeature is finalized on all CPUs.
>>
>> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
>> same BBML2 capability with the boot CPU, repainting the linear mapping
>> is not needed.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/mmu.h   |   6 +-
>>   arch/arm64/kernel/cpufeature.c |   8 ++
>>   arch/arm64/mm/mmu.c            | 173 +++++++++++++++++++++++++++------
>>   arch/arm64/mm/pageattr.c       |   2 +-
>>   arch/arm64/mm/proc.S           |  57 ++++++++---
>>   5 files changed, 196 insertions(+), 50 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 57f4b25e6f33..9bf50e8897e2 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -56,6 +56,8 @@ typedef struct {
>>    */
>>   #define ASID(mm)	(atomic64_read(&(mm)->context.id) & 0xffff)
>>   
>> +extern bool linear_map_requires_bbml2;
>> +
>>   static inline bool arm64_kernel_unmapped_at_el0(void)
>>   {
>>   	return alternative_has_cap_unlikely(ARM64_UNMAP_KERNEL_AT_EL0);
>> @@ -71,7 +73,9 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>>   			       pgprot_t prot, bool page_mappings_only);
>>   extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>>   extern void mark_linear_text_alias_ro(void);
>> -extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end);
>> +extern int split_kernel_pgtable_mapping(unsigned long start, unsigned long end,
>> +					unsigned int flags);
>> +extern int linear_map_split_to_ptes(void *__unused);
>>   
>>   /*
>>    * This check is triggered during the early boot before the cpufeature
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 1c96016a7a41..23c01d679c40 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -85,6 +85,7 @@
>>   #include <asm/insn.h>
>>   #include <asm/kvm_host.h>
>>   #include <asm/mmu_context.h>
>> +#include <asm/mmu.h>
>>   #include <asm/mte.h>
>>   #include <asm/hypervisor.h>
>>   #include <asm/processor.h>
>> @@ -2009,6 +2010,12 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>>   	return 0;
>>   }
>>   
>> +static void __init linear_map_maybe_split_to_ptes(void)
>> +{
>> +	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort())
>> +		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
>> +}
>> +
>>   static void __init kpti_install_ng_mappings(void)
>>   {
>>   	/* Check whether KPTI is going to be used */
>> @@ -3855,6 +3862,7 @@ void __init setup_system_features(void)
>>   {
>>   	setup_system_capabilities();
>>   
>> +	linear_map_maybe_split_to_ptes();
>>   	kpti_install_ng_mappings();
>>   
>>   	sve_setup();
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index f63b39613571..22f2d0869fdd 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -482,11 +482,11 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>>   
>>   #define INVALID_PHYS_ADDR	-1
>>   
> [...]
>
> I'll review the actual walker separately (I've run out of time today).
>
>
>>   
>> +extern u32 repaint_done;
>> +
>> +int __init linear_map_split_to_ptes(void *__unused)
>> +{
>> +	typedef void (repaint_wait_fn)(void);
>> +	extern repaint_wait_fn bbml2_wait_for_repainting;
>> +	repaint_wait_fn *wait_fn;
>> +
>> +	int cpu = smp_processor_id();
>> +
>> +	wait_fn = (void *)__pa_symbol(bbml2_wait_for_repainting);
>> +
>> +	/*
>> +	 * Repainting just can be run on CPU 0 because we just can be sure
>> +	 * CPU 0 supports BBML2.
>> +	 */
>> +	if (!cpu) {
>> +		phys_addr_t kernel_start = __pa_symbol(_stext);
>> +		phys_addr_t kernel_end = __pa_symbol(__init_begin);
>> +		phys_addr_t start, end;
>> +		unsigned long vstart, vend;
>> +		int flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>> +		u64 i;
>> +		int ret;
>> +
>> +		/*
>> +		 * Wait for all secondary CPUs get prepared for repainting
>> +		 * the linear mapping.
>> +		 */
>> +		smp_cond_load_acquire(&repaint_done, VAL == num_online_cpus());
> Is this correct? I would have thought the primary is waiting for the
> secondaries, so "VAL == num_online_cpus() - 1" ?

It is correct because repaint_done is initialized to 1.

>
>> +
>> +		memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>> +		/* Split the whole linear mapping */
>> +		for_each_mem_range(i, &start, &end) {
> I think I asked this in the last round; but I just want to double check;
> memblock is definitely still valid here and we are definitely going to get
> exactly the same regions out as we did in map_mem()? I wonder if it's possible
> between then and now that some other component has reserved some memory? In that
> case we wouldn't walk that region?

I think it is kept unchanged. The ptdump shows no block or cont mappings 
for linear mapping if I force repaint the page table.

>
> Perhaps it would be safer (and simpler) to just walk all of [PAGE_OFFSET,
> _stext) and [__init_begin, PAGE_END) and ignore the holes?

This may walk some holes, particularly for multiple sockets machines? It 
doesn't have correctness issue, but just not very efficient.

>
>> +			if (start >= end)
>> +				return -EINVAL;
>> +
>> +			vstart = __phys_to_virt(start);
>> +			vend = __phys_to_virt(end);
>> +			ret = split_kernel_pgtable_mapping(vstart, vend, flags);
>> +			if (ret)
>> +				panic("Failed to split linear mappings\n");
>> +
>> +			flush_tlb_kernel_range(vstart, vend);
>> +		}
>> +		memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>> +
>> +		/*
>> +		 * Relies on dsb in flush_tlb_kernel_range() to avoid
>> +		 * reordering before any page table split operations.
>> +		 */
>> +		WRITE_ONCE(repaint_done, 0);
>> +	} else {
>> +		/*
>> +		 * The secondary CPUs can't run in the same address space
>> +		 * with CPU 0 because accessing the linear mapping address
>> +		 * when CPU 0 is repainting it is not safe.
>> +		 *
>> +		 * Let the secondary CPUs run busy loop in idmap address
>> +		 * space when repainting is ongoing.
>> +		 */
>> +		cpu_install_idmap();
>> +		wait_fn();
>> +		cpu_uninstall_idmap();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   #ifdef CONFIG_KFENCE
>>   
>>   bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
>> @@ -1079,7 +1174,8 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
>>   		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
>>   
>>   static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
>> -	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
>> +	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
>> +	  bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
>>   
>>   static void __init create_idmap(void)
>>   {
>> @@ -1104,6 +1200,19 @@ static void __init create_idmap(void)
>>   			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>>   			       __phys_to_virt(ptep) - ptep);
>>   	}
>> +
>> +	/*
>> +	 * Setup idmap mapping for repaint_done flag.  It will be used if
>> +	 * repainting the linear mapping is needed later.
>> +	 */
>> +	if (linear_map_requires_bbml2) {
>> +		u64 pa = __pa_symbol(&repaint_done);
>> +		ptep = __pa_symbol(bbml2_ptes);
>> +
>> +		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
>> +			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>> +			       __phys_to_virt(ptep) - ptep);
>> +	}
>>   }
>>   
>>   void __init paging_init(void)
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 6566aa9d8abb..4471d7e510a1 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -140,7 +140,7 @@ static int update_range_prot(unsigned long start, unsigned long size,
>>   	data.set_mask = set_mask;
>>   	data.clear_mask = clear_mask;
>>   
>> -	ret = split_kernel_pgtable_mapping(start, start + size);
>> +	ret = split_kernel_pgtable_mapping(start, start + size, 0);
>>   	if (WARN_ON_ONCE(ret))
>>   		return ret;
>>   
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 80d470aa469d..f0f9c49a4466 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -239,6 +239,25 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
>>   	dsb	nshst
>>   	.endm
>>   
>> +	.macro wait_for_boot_cpu, tmp1, tmp2, tmp3, tmp4
>> +	/* Increment the flag to let the boot CPU know we're ready */
>> +1:	ldxr	\tmp3, [\tmp2]
>> +	add	\tmp3, \tmp3, #1
>> +	stxr	\tmp4, \tmp3, [\tmp2]
>> +	cbnz	\tmp4, 1b
>> +
>> +	/* Wait for the boot CPU to finish its job */
>> +	sevl
>> +1:	wfe
>> +	ldxr	\tmp3, [\tmp2]
>> +	cbnz	\tmp3, 1b
>> +
>> +	/* All done, act like nothing happened */
>> +	msr	ttbr1_el1, \tmp1
>> +	isb
>> +	ret
>> +	.endm
> You've defined the macro within "#ifdef CONFIG_UNMAP_KERNEL_AT_EL0" but then
> need to use it outside of that scope.
>
> But I don't think this needs to be a macro; I think it would be better as a
> function (as I suggested in the last round). Then the text only needs to appear
> once in the image and it can be used from both places (see below).
>
>> +
>>   /*
>>    * void __kpti_install_ng_mappings(int cpu, int num_secondaries, phys_addr_t temp_pgd,
>>    *				   unsigned long temp_pte_va)
>> @@ -416,29 +435,35 @@ alternative_else_nop_endif
>>   __idmap_kpti_secondary:
>>   	/* Uninstall swapper before surgery begins */
>>   	__idmap_cpu_set_reserved_ttbr1 x16, x17
>> +	wait_for_boot_cpu swapper_ttb, flag_ptr, w16, w17
>>   
>> -	/* Increment the flag to let the boot CPU we're ready */
>> -1:	ldxr	w16, [flag_ptr]
>> -	add	w16, w16, #1
>> -	stxr	w17, w16, [flag_ptr]
>> -	cbnz	w17, 1b
>> +	.unreq	swapper_ttb
>> +	.unreq	flag_ptr
>> +SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>> +	.popsection
>> +#endif
>>   
>> -	/* Wait for the boot CPU to finish messing around with swapper */
>> -	sevl
>> -1:	wfe
>> -	ldxr	w16, [flag_ptr]
>> -	cbnz	w16, 1b
>> +/*
>> + * Wait for repainting is done. Run on secondary CPUs
>> + * only.
>> + */
>> +	.pushsection	".data", "aw", %progbits
>> +SYM_DATA(repaint_done, .long 1)
>> +	.popsection
>>   
>> -	/* All done, act like nothing happened */
>> -	msr	ttbr1_el1, swapper_ttb
>> -	isb
>> -	ret
>> +	.pushsection ".idmap.text", "a"
>> +SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
>> +	swapper_ttb	.req	x0
>> +	flag_ptr	.req	x1
>> +	mrs     swapper_ttb, ttbr1_el1
>> +	adr_l   flag_ptr, repaint_done
>> +	__idmap_cpu_set_reserved_ttbr1 x16, x17
>> +	wait_for_boot_cpu swapper_ttb, flag_ptr, w16, w17
>>   
>>   	.unreq	swapper_ttb
>>   	.unreq	flag_ptr
>> -SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>> +SYM_FUNC_END(bbml2_wait_for_repainting)
>>   	.popsection
>> -#endif
> How about this instead?

Looks good to me.

Thanks,
Yang


>
> ---8<---
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 8c75965afc9e..a116b2b8ad59 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -416,8 +416,30 @@ alternative_else_nop_endif
>   __idmap_kpti_secondary:
>   	/* Uninstall swapper before surgery begins */
>   	__idmap_cpu_set_reserved_ttbr1 x16, x17
> +	b scondary_cpu_wait
> +
> +	.unreq	swapper_ttb
> +	.unreq	flag_ptr
> +SYM_FUNC_END(idmap_kpti_install_ng_mappings)
> +	.popsection
> +#endif
> +
> +	.pushsection	".data", "aw", %progbits
> +SYM_DATA(repaint_done, .long 1)
> +	.popsection
> +
> +	.pushsection ".idmap.text", "a"
> +SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
> +	/* Must be same registers as in idmap_kpti_install_ng_mappings */
> +	swapper_ttb	.req	x3
> +	flag_ptr	.req	x4
> +
> +	mrs     swapper_ttb, ttbr1_el1
> +	adr_l   flag_ptr, repaint_done
> +	__idmap_cpu_set_reserved_ttbr1 x16, x17
>
>   	/* Increment the flag to let the boot CPU we're ready */
> +scondary_cpu_wait:
>   1:	ldxr	w16, [flag_ptr]
>   	add	w16, w16, #1
>   	stxr	w17, w16, [flag_ptr]
> @@ -436,9 +458,8 @@ __idmap_kpti_secondary:
>
>   	.unreq	swapper_ttb
>   	.unreq	flag_ptr
> -SYM_FUNC_END(idmap_kpti_install_ng_mappings)
> +SYM_FUNC_END(bbml2_wait_for_repainting)
>   	.popsection
> -#endif
>
>   /*
>    *	__cpu_setup
> ---8<---
>
> Thanks,
> Ryan
>


