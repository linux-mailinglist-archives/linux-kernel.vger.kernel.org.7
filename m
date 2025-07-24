Return-Path: <linux-kernel+bounces-743981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B74B10669
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66395A5BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBA2D541E;
	Thu, 24 Jul 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="efa1GnwA"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013047.outbound.protection.outlook.com [52.101.127.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1D2D46D8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349383; cv=fail; b=pcHc94AID1tfQSvAvFO8UombDKyo+uXEGDpq9g1HUp7f0EuhgNlrLVAu4fK2TM5F3Wx2W6xHordUqw0Gm8T3dfTirIGW4UlfkT62uXX4c3CSP8TmkQgi5DlMmZiezczwDXKmyc+dd54LTbGl7QrtC1sRwKJWtlS7LtZEzaNSCio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349383; c=relaxed/simple;
	bh=XA5jVrjesJJiREbbyUsYOS8sk6ZrN3oAi05tvF7TRwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YToPsEDznlbVEBnoaaC5UveUpBWiDmUQZ+3PxgsYxpcst3H6t9Ez1t4P/YuMLf9g5n7yr8MCVdbSTLzNhDqOx1UnYYVirnhxi02IHmYSc2E4tzr/JkZbrCT2C8Q40CAHfcuWyeTjwaHdYioyqY2nFPsp+k/zbyRgySupo8G//o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=efa1GnwA; arc=fail smtp.client-ip=52.101.127.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on3hleJJB6rjQv9X6NnYcw374MCgOIEEDBXSzbdTKbZH8T47xqt6/+wwMmhfCzOcGIMWQD/ui+NWySH7vGdaLUVIhfE4k40hDNGnrkLkPwB69GxddsRl/4XkoogdsLKPqg6DGv/nQhENWzzTxowZV11B1eBSISJP44P3GaR3eIdog06msIa1aXXrkQW1FDV3k9I1XABuxIfOY+N7at6Sb5HwmCERYmVBy1wX1lqITKlnqRd83vSI1jYWG0O7e1M8ExY6cluIDN55zmDCy6JDFjzVD+wcUMD78DHPBRlqOGK5tWWRP5wCY5ytTlwpVEsIK+tzstB7CbopuTwZqp/s1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbECc+BPpmfhRBiZiHcaZ0Wv/yapvE4MC3RqzKFGeXU=;
 b=Wi4KAwYd2zbQc8zu3pOQdfy73MtVN5WSwK/O/meVt5bc4suR5W5FMnpaYdMdWNor2HuNS4Xw6V6bAoD4yCrjT4EKZIuNu4cH6fyzdDFwqja2wOzgElS8TmSaR/goSvHeTa+PABsqfw9eU5TwiDFKhnyCphjZ9EuzZsJwUY05HJcx8Tgy++4s/AIOC/zPp7Ei3sG9Ssj4UX4t6xJpyOMDslNMRjnb6UTk3dhwp6ZETi8xX64YFiny//HEu+ZgG6NdWwcO9NlZTQZ7pmgHCFpy2O1b851NlU/LbdvmE/lSrxfIRdruzKNi5CU/VtgP4zdeNYH3sTQuwqtlc0YENouV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbECc+BPpmfhRBiZiHcaZ0Wv/yapvE4MC3RqzKFGeXU=;
 b=efa1GnwAfY9twbrk/UnCI1iqCyUw5i/oEsqtJpMYWi3QSGawJFcUpfZ8gzJxzx3Xt7n9cFPhyd8n4ko3SUw6tvdMqLVxt7lKm1Z4OnjVRB62WBdVL6AyDnx6ISjnRqlheRxakVFcLBRZ6Hs1fhBono6oEXMW5hk++7jIB9ALOMvoDzrBCuw8Bmvt6C1sIzhM1iBOlTfCuWTvMsJvETcMVRWJhfIBXKI1HB+fT1Bl7kZV3Qk+u8W1YRghjn1HLmZYabJmRIcBsdjpOd3Fu9zH3+VtCGZaFEqQ2ly3weV5JQdIb/AD3wnu2DYBmmZq8fB4OFrSK7nwNacThWtOcLKh5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYSPR06MB6675.apcprd06.prod.outlook.com (2603:1096:400:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 09:29:37 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 09:29:36 +0000
Message-ID: <40cb7d64-0b90-4561-8e10-06a808a2766a@vivo.com>
Date: Thu, 24 Jul 2025 17:29:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724084441.380404-1-link@vivo.com>
 <764c48ad-8869-4f69-898e-0a1c58684f7d@lucifer.local>
From: Huan Yang <link@vivo.com>
In-Reply-To: <764c48ad-8869-4f69-898e-0a1c58684f7d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYSPR06MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 98216632-556c-4166-8ee8-08ddca949b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzNhTjJKaFBWYzBjYUdPejRrWTB5bzl0QXhHeE41TmR4aGxhSWxvMlR5L2Rv?=
 =?utf-8?B?Q3VXMEZwTXBWVnFBYk9qWE82dkRPcVJzQWVKVkd6SElTVW5wVU1UOWVQRkds?=
 =?utf-8?B?Q3BRaTQ2cFNhL2h4MFZ4alBRTjNZYWdBQ3haUGladGN6dEF4YmFBbzVoTjBY?=
 =?utf-8?B?VU9SVXhDVDJuTERSakZ1RDNwRUlzUVNNR2hQalp0LytUSHZqWW8yZWozNEZq?=
 =?utf-8?B?ZDlydkJCSVRvTmZUTXVJZ3QxVnJmQk9ZMVh5eFhOT1RuUE9SOFB2aXVaZ3o1?=
 =?utf-8?B?dWlKWjJRblNKTFc3UkRKenZsaGFNK0JNdUFna2VUcUxtT2JMbmhtTU5tRVNM?=
 =?utf-8?B?SWVEbXRZTWRNNEhmLzI1QXFNM3VHZld4TnNaOE9YTHdTSkN0NWlCbVdERXBR?=
 =?utf-8?B?TndMUzV6QkNab1dXb01qZmJneXJMcy9wRjBPbEJ4b3ZLL1hzQTRsaVhWbEV0?=
 =?utf-8?B?YzhkRkZFbm1IZUpENkdaSkFiczVPdlpVMjFWcFBvRE1SQnB4akthOUYxOXpr?=
 =?utf-8?B?QjAzWWtJZDRIcm9tY3NoSmtQbUhpNXoxMkRQWUFiNzYrWFFNMS9pSjR4OUtl?=
 =?utf-8?B?WEIvMVZmb2VxM242d2tyZmNYVG5zQVRNSTBWY09BeUpNNDluZkkxK3dNZ29r?=
 =?utf-8?B?UitZRERjVVZhYm1PMGVMckVIdlNlT2lvOUhLcDNCWFdxSm5JOStCQlVFVXM1?=
 =?utf-8?B?OEdhajVPUWtrZkhGcU93Mjh3Um5aTDNQV0V2cXp2bDIrcFVMUDJsSTlNejhP?=
 =?utf-8?B?bUVKbWU5NlRRRkhQeHgyanhSRThMT1docjZDYnNiclhsOU5Mc0Y2RE45UnBV?=
 =?utf-8?B?MXhDaTJza2tCT2twcWsxSDVaOUlkb01VRG5ydFpOUTNObVVoMkpPekpBZEhU?=
 =?utf-8?B?RGtVSi85Yi8vSEhldWZubisvc2g2c3RUWVkrUlFWVnJ5UHR2eTJFTyt0SUpq?=
 =?utf-8?B?QmJJOVVyS25BeVVJZndzclZyYWJxM2QybVpqcmVMY0JGWFM5UDhaWkxTM0VC?=
 =?utf-8?B?cng4YWJYVEkwUWJ5SUJDNzJhZExFRVNyY1hCRUo2U2VPcXk3S3VqQUd1Mlhi?=
 =?utf-8?B?VnJHaDJkVlN1MndEd3VGMG9PbzNydXo3bkk3OVVUcUZITEZQbEk3elliUzMx?=
 =?utf-8?B?Tzh5K1A0cmQzbEtnVUZLaW1mT0xSQ3hhQUwvTTh0NHlBTGluZzJBS0JKajM1?=
 =?utf-8?B?eHFGYUNUUnNhMXFET0xSeVcxNUpMRytBdENDb0pOK25HZFpROTFaaU0vWElI?=
 =?utf-8?B?VEhSaGpIWVRyQnZ3T2RQSnJMM0NOdkNiRkFjS0NVOE81bGRZNGw2ZWR2QUdZ?=
 =?utf-8?B?QWFiRjh6bXoyNEpycVFGQnM1QTgwN1BJVERoMzVvVEJKUXJOOUttQks2cXpZ?=
 =?utf-8?B?am0rVnZIYkt6UVJLcmY5d2pRZDUraHZYeDRVV2ZrSWxoL2NXYmRYR0RMT2R2?=
 =?utf-8?B?N2hWTkIwM2psSGtwLzJuUW9UOEVINnZCZzNJQzJocHEvLzdERWkzNDV1TFRD?=
 =?utf-8?B?dzhJVHV1N29KTmIyQlZ4QUxXREJjRXdOWGlQTmlrTmhlWFVEdk83ZHRZS0ZX?=
 =?utf-8?B?a1ZZYjZqK0V2TzBCWldJVWJqM2VJUGRYNkJlem5lR2FGdXFPdGEvRGNMdmlQ?=
 =?utf-8?B?akZaT1hrSHFpdUFZeWZwQTRCRWpXbDhUYXk3TysxZkR2Uk1vR3EwRzFlN09L?=
 =?utf-8?B?cnJtcHplQ2ZCR1dCVzlDWlgyMEhMT0N2MElXUFUrMjN5eit0OFVUbXJ5UXNX?=
 =?utf-8?B?T3pQQllaTXFZcWJ6cU9ocmdmWmIzMlF1QTRoNWROOGIzUG9VNTdielkyWVZr?=
 =?utf-8?B?VVlKbHNHcHdTSHZ3TWVsWVFadmpSSjk0c2NjV1JwYW5Kako0d0VQNHh4Yk85?=
 =?utf-8?B?ejhUTnFBc3VJSm81dm5vUVZpWjdESERMTVliTGtGQzlCTEVCcTFRWlpzYlJ5?=
 =?utf-8?B?U25TaDkyMVV5aWJpQk9LcFJNWVZ5WTB5eTRubVJ0bzY4aGRCVHBhaUIwazkr?=
 =?utf-8?Q?fAq7jxhJslxEWBoHHRLeOZdl128Mdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVRIRUlMdHBSUzhjUFRtOTNkc3BFTHlaUTk5dmhrNDluaGFlSFAyWGxuYjBL?=
 =?utf-8?B?TGRScjJ5dXcyYVc5YTk0QVRyRFFsOTJ1aTRacUN6MmQ5N0I2SXluQk5lLzlj?=
 =?utf-8?B?RkNBbnRHb2k3TE0rSC83K2pOR3dxMGlxTG5ZemtPYnVCNXFja2U5NDhkakVN?=
 =?utf-8?B?dzZ5UXAvejkwTVVTWG1kdjhsR2xiZythSzNuNHIzZGkvMzRMcUw1MlRQSTV5?=
 =?utf-8?B?YnB0ZnF5TmN3bWJvNWxQMEhRMTJKUzZsNGlPRk0ycGxMSVFXQndiTUFRVHpL?=
 =?utf-8?B?UkpEUW5UYW16OWViTVJGTkRwZTlGdkpoOWtDMVdDYjBLMDNIWWVjZWlCSzMy?=
 =?utf-8?B?djBheGtWZmg4UWc0UHA4MjRjRDBsU2p5dHdsdkZ3N3duY3R4UnVXNVVrRFpu?=
 =?utf-8?B?akVyNXNuQ29hUkhZTXNjZmpmWUllRmp6NktZdG40Umc5dDJlQ0M1d0ZiTnNa?=
 =?utf-8?B?MlpSenpPNkhFRHZORkUvZnNzQ3AwWDFHUGgxYXFicWJvNm9JMG1Jb2VjSDNT?=
 =?utf-8?B?bjhkYkRZM29aWkxUUEpQc0lBNlJpZnlzc1JQbHBINFNJbmcySWZ0eXlxazNu?=
 =?utf-8?B?cGhSR0tVdHlLZmFOV21RaVRBWHNYT3hlT01idU44MVNOcjdSaFY3QWl1ZlFE?=
 =?utf-8?B?elR2emJ0ZkxKbW83anZXVXNqSUdVMkx0WUp6c1BnUWorU05QaXQyMFp4Y3RZ?=
 =?utf-8?B?TVVnSFF4ZkcrSGpWZFR2ZitOd0NNRGhTbTFuSWZkZHFWRTRCaDZVd0xvd0lM?=
 =?utf-8?B?VW1nWjRBNmV6bzN0QXFlazlKK0svZENZYWRWc2RvanorL09iZkpSSlV6cDhy?=
 =?utf-8?B?dW5qYmV3OVUxekI3ODBObXludHcwTkRQVnFzOUZDOGdCMXI0Y1lXK21EMGdI?=
 =?utf-8?B?Nlh0RUNFaVcwQ1A0aWlzSDJ1Mlh6bnZrTThwL214TTEzZUVZMi9WOGZLWEEr?=
 =?utf-8?B?TkZ6WHRqOWNac1A3S0U1dmJjWVE4MmZXcUlKVmRNMTVVbHlPc3hVOW1ra0lI?=
 =?utf-8?B?NWpYNEN0TExkbDZVbFFuZWhYUUI2U3RWaTJTTzNnNUV5QjFqbWM4V0FVOFZV?=
 =?utf-8?B?amdDTC9kdThxRy9WK3BvTmJDQTcwb05jaDhPMCtud3BhdzNxWm0rTFRMUk1l?=
 =?utf-8?B?cEkrT2V2MFlwYUhxQlJsRzV6ZUFHaENRb241L0lXQ0RObGdqdnhFdFhqanFh?=
 =?utf-8?B?VmFnb2pBUzdTU2JZWVBjQXZRb3N2SjVkOHJlM2UvRnlYN1B1RmEyNG9BMnVY?=
 =?utf-8?B?NWZqOXN5aXBCS3ptNjQ2REFHb3pjMldmdjBmRUhqUC9lVU1DcytKVkZZNzdi?=
 =?utf-8?B?QnNZcXJ0YjJNWkNiZlU5TXJwNlVCUWs5ckVPYmJuNjNNZWpndXhyckZBalVT?=
 =?utf-8?B?MUM2RTh1SHVGenZidEVSSjQ3dGhCa2xFaGorZW12UXdhT0JDNTg0eEs1MEpk?=
 =?utf-8?B?UzBtb25KaHRySnZ1Q2tzdjZEcUU1TlQ3NUVTOThzcElMT3hydjlXTVgvMzNC?=
 =?utf-8?B?cGw5S2ZXVXdmT0Y5MWdwMXFEWXE0NmJ6UEFZOUN1ZkUxMmxDeEZDcEthTnJs?=
 =?utf-8?B?aGc4L0Y2d1E2UGkvREZFTzFKTkIyaDFMdjNjZnUwaGd4a3JUaWZCTEFEWTEz?=
 =?utf-8?B?bWx4VXo1UWNkU0FnME44c1NLSFJhNklOckpCL2RzQytjb29TWG16TEV2eEVr?=
 =?utf-8?B?dWtHT0l1Z1RuQkY5eEdvQzBCVHQ0aXplUXBsbERUVVZEeFNOQnJsUllhdDBC?=
 =?utf-8?B?MWZ3OGdUbnFjZEV3Rk1uZCszbzFQNjZCZlRuRElZZ3NOc21XWmtHVXYza2lE?=
 =?utf-8?B?VHlaSEZUeE1RbkpScWo2T09qQjVITlVPV2c3MnRoUWs5Z3JOcE5oQytRR1Vr?=
 =?utf-8?B?OWtYeGppdG4zWXFzUlNPYnB3QXZLYXN0RmZ6QzdhZGs2TzM4Z0lTZmdPZDd3?=
 =?utf-8?B?NndsanNVT3BCQ3g4d2ZQR2dNTEgrMkI4TlFjeTFSTzM4aGJaSlpVSlRNUXpq?=
 =?utf-8?B?WkNLLzdDdFRMMWFQdkFzY3c4VjJzdkpVNmxlcFBHVnJuc2tuQitRSGE0U1JY?=
 =?utf-8?B?MHlqMFJQZmVYS3I4dWROcHhkTENNWDZyYlcyTytkSWdsUVdkWFo5V2lxQ2ZD?=
 =?utf-8?Q?24Q/8j/56eZx0TRY+todNHh8u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98216632-556c-4166-8ee8-08ddca949b57
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:29:36.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BjIMyeaVKxcZ+Sh2i0jVN4NwI+rgQ5hINpeu/S/+tnwSxYhBvgJjKjjCD51/XnCKDir8DlQkEGLAcIUS800qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6675


在 2025/7/24 17:15, Lorenzo Stoakes 写道:
> NAK. This series is completely un-upstreamable in any form.
>
> David has responded to you already, but to underline.
>
> The lesson here is that you really ought to discuss things with people in
> the subsystem you are changing in advance of spending a lot of time doing
> work like this which you intend to upstream.

Yes, this is a very useful lesson.:)

In the future, when I have ideas in this area, I will bring them up for 
discussion first, especially when

they involve folios or pages.

>
> On Thu, Jul 24, 2025 at 04:44:28PM +0800, Huan Yang wrote:
>> Summary
>> ==
>> This patchset reuses page_type to store migrate entry count during the
>> period from migrate entry setup to removal, enabling accelerated VMA
>> traversal when removing migrate entries, following a similar principle to
>> early termination when folio is unmapped in try_to_migrate.
>>
>> In my self-constructed test scenario, the migration time can be reduced
>> from over 150+ms to around 30+ms, achieving nearly a 70% performance
>> improvement. Additionally, the flame graph shows that the proportion of
>> remove_migration_ptes can be reduced from 80%+ to 60%+.
> This sounds completely contrived. I don't even know if you have a use case
> here.

The test case I provided does have an amplified effect, but the 
optimization it demonstrates is real. It's just that when scaled up to 
the system level, the effect becomes difficult to observe.

>
>> Notice: migrate entry specifically refers to migrate PTE entry, as large
>> folio are not supported page type and 0 mapcount reuse.
>>
>> Principle
>> ==
>> When a page removes all PTEs in try_to_migrate and sets up a migrate PTE
>> entry, we can determine whether the traversal of remaining VMAs can be
>> terminated early by checking if mapcount is zero. This optimization
>> helps improve performance during migration.
>>
>> However, when removing migrate PTE entries and setting up PTEs for the
>> destination folio in remove_migration_ptes, there is no such information
>> available to assist in deciding whether the traversal of remaining VMAs
>> can be ended early. Therefore, it is necessary to traversal all VMAs
>> associated with this folio.
>>
>> In reality, when a folio is fully unmapped and before all migrate PTE
>> entries are removed, the mapcount will always be zero. Since page_type
>> and mapcount share a union, and referring to folio_mapcount, we can
>> reuse page_type to record the number of migrate PTE entries of the
>> current folio in the system as long as it's not a large folio. This
>> reuse does not affect calls to folio_mapcount, which will always return
>> zero.
> OK so - if you ever find yourself thinking this way, please stop. We are in
> the midst of fundamentally changing how folios and pages work.
>
> There is absolutely ZERO room for reusing arbitrary fields in this way. Any
> series that attempts to do this will be rejected.
>
> Again, I must say - if you had raised this ahead of time we could have
> saved you some effort.
>
>> Therefore, we can set the folio's page_type to PGTY_mgt_entry when
>> try_to_migrate completes, the folio is already unmapped, and it's not a
>> large folio. The remaining 24 bits can then be used to record the number
>> of migrate PTE entries generated by try_to_migrate.
> I mean there's so much wrong here. The future is large folios. Making some
> fundamental change that relies on not-large folio is a mistake. 24
> bits... I mean no.
Thanks, I understand it.
>
>> Then, in remove_migration_ptes, when the nr_mgt_entry count drops to
>> zero, we can terminate the VMA traversal early.
>>
>> It's important to note that we need to initialize the folio's page_type
>> to PGTY_mgt_entry and set the migrate entry count only while holding the
>> rmap walk lock.This is because during the lock period, we can prevent
>> new VMA fork (which would increase migrate entries) and VMA unmap
>> (which would decrease migrate entries).
> No, no no. NO.
>
> You are not introducing new locking complexity for this.
>
> I could go on, but there's no point.
>
> This series is not upstreamable, NAK.
>

