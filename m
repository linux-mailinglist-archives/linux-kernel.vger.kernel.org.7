Return-Path: <linux-kernel+bounces-748447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F6B1416F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DAE3A7A49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CF127464A;
	Mon, 28 Jul 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G9nJLyxR"
Received: from outbound.mail.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933F1E5B60
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725115; cv=fail; b=HsjKx17ioKyJl7/xNu+F4B1EpzmZptXB1Oh3ELgK0rDo4Dr2Nts2Pz4gEVQaYQgA2VChZ/rRX+q0W9Ej4vU5eUBXT01EBK5j3Gne05t/dYrnYqEE4W4yxYHFJ/RZ/cvwZA1LjYpL95LVOiw5VHk5eeq4b0El5IOnQSPZGp1ro6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725115; c=relaxed/simple;
	bh=H97AIEZ1T7+XYZjyUkKW9EHYi8Ob7iYWdJSw8BFFMrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lHEdwr++G5LGrb6xkju6ZELLTN+iHlmB7z2scwId7iMzlnQuLOm47xqi86SI4asF2F+R+wqg4kNvShBbxh7Sq0UKtJa+ASdMW02n1padSZLOFdXHkBaqOJRQafCJEjpbqlnlc5VW5Eo96kSiocF7PYXV1FgkPbSeE68FnKspmso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G9nJLyxR; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkFxUqzwh/wdCOemRXL6WW9fr7Tyakkz46FB4XCuQcBbfR48QBo1zgld3MpO4D7xtsJmG9plH+F8yUH1J9FMnS+tWjgD8DeUdDgx7mVp4nUU21bWPPpCRr+uzi6EkzdNfBfQ8yYUkz8qDRr7RvUCBNv5GzvQdVB66hvNLmjKECPPJIUzQ8rliy493fE8OsDymdHBfVyh7sPVoFGO7phRkcBdQWWCfYI58wxe4pf9wo3sHxmmLQlyh8DLLpdVZYfQpJN4NsGvb1TKDQmXbTx8JZhfGe4B2B5zt0a/9FKawuXn1XQ811mrLgC45UtjUASpmFraeFUJ/yB1IYE3N2e0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H97AIEZ1T7+XYZjyUkKW9EHYi8Ob7iYWdJSw8BFFMrw=;
 b=rtSr8dmkdByBCsk5wh3i5AL5L6Q8BDv2UMi/1BEevXsWejRt55gmWCe9KKCVYDMg0tMwjcu35OyxfApJVP1qUEc5uePCzvINBFImouk++fanjnHHsfJkPt5hhS2zc+CXiQ2ajgWsHKjRDSkUoGneDFc7aEIi6EKlCu+fi8qLBXMKrWeJxIsyAkTSf51WK3eScWNM6n7fmsP+eUJ9kh1RXLL6ipS0P7J6Nu76EV7I6wK2l3+KgF5aFxXyVS7d5xMhKlBH0Arkz3TtGZjeFUqJCjKAB2MSgw3aKl7AMDOKuFK9un5ftGlxAatSmKi6CQ3dqp75qDd9sD5j0YRydQ9rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H97AIEZ1T7+XYZjyUkKW9EHYi8Ob7iYWdJSw8BFFMrw=;
 b=G9nJLyxRtRfWWgqoGoE1z6urQ0UrjUHT9U5S6r1sqik42GI65e8hk/6G/9ek9esqdEu47nS+DTSiuO7gcY9ODna2kw5UJivWIFKchXuAQXbkc65s0MVOPNOOyCzKyR9NVbJ8P2kO5qgM3/hf8aj4gkDmFuMqXZ3kdF3T6SyHFzd9jXrtmJ2wINzPHvzwoRbNi2Bqnl3ovuDwPRn8PTRd2wF2jhrPmHx7YJka95AaA3AlSGiktPXWSG67z04wDPSbic/vZMzr8d5S+DjHEKuix3A9QoccmVY23R+RNLMZjLRDT5/E7b6d0LXZAlDq/lgWyT4FheOCzC9K23PxRGbJhw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 17:51:48 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 17:51:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH] nvme: Fix typos
Thread-Topic: [PATCH] nvme: Fix typos
Thread-Index: AQHb/BBef9S4buvEgUa9jy9kD65wgbRH2HMA
Date: Mon, 28 Jul 2025 17:51:48 +0000
Message-ID: <39947536-f953-46fd-a63b-6cb616cebe59@nvidia.com>
References: <20250723202801.2909506-1-helgaas@kernel.org>
In-Reply-To: <20250723202801.2909506-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4296:EE_
x-ms-office365-filtering-correlation-id: 4eb59800-2617-4e22-2ac0-08ddcdff6d0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3JzLzdLa0ZyZktyNHBva21oVE9pWElnYjBLTFR4RU5vVUhpb2JXUmFsQ0Fm?=
 =?utf-8?B?UXR0UkR0aHlldWxxTnpLMEVxVXdqZUJZaUdOZFJ6ckE5ak5PMFVlK0loS3I0?=
 =?utf-8?B?dFA2aGk5MmtHUG9xWnVLbFI0SlFTL1FlTEYxbmN6ZStGaVpKN0pZU1pHUWRD?=
 =?utf-8?B?UDRMM2c3ZThYRzVDM1ZHRzFCeVdkNG1xTWNqUCtYRWpWWmYwUDBVRkJ5WFRZ?=
 =?utf-8?B?bXBBUFBybmk0enllcDlEeW5SUTJnWURiWEQrVFkycnVMdUlYLy9ld3FORnha?=
 =?utf-8?B?bVJWY1Q5LzNERktKSWRya1diSDdlS3pHM1V0RUhac0hTUDBMYzdXeUdwOHl3?=
 =?utf-8?B?R25kajFxeCtiam8yZTljSEsxT1pvMTFlWWZEYjFwYU9USHpJd1M3MWJHenVB?=
 =?utf-8?B?N3IxY0oxZEJGV2ZuckZpMlBLb3JtbGUxUXJYMmtnQWJUU2JCK1FzTDB2ZkpJ?=
 =?utf-8?B?enNiK2xTcy9DeGhybElRSWt3dVZtOU5pR3J5dGlmVC9OWldiRGZGLzRYa2x5?=
 =?utf-8?B?SjdRWURoMWluWCtXaVJIbDJjUWd2cENZaDRVQWh6WFRHMldKbXBFcnBqaU9h?=
 =?utf-8?B?TnZ3OFJqam5qNW1WZjZ2akpsZyt6Uy90Qzg3KzVFSHlwR0YwMEJiWEY5Mk50?=
 =?utf-8?B?T3ltdWlha2VvMW9pMGNqOXdaVkx0ajYvejNiTXFKYzhpYVlja1BOUUZWdHdL?=
 =?utf-8?B?cW5hQ3dPcmZ4ZmkrUnk1MEloWkNsOXBGM0JlU0ROb2VORER4SnRlTTI4bmI2?=
 =?utf-8?B?TURBaktwQlJLS3ZocDVyMnRROW9abkVSNlo0c0o4cUx5dkJpTW51U2xZRjAr?=
 =?utf-8?B?SEVlS0xuRkdxRTdhZG84ckprckxQUElJeFJhY09HOGExSi96aHFMS1I1WHJV?=
 =?utf-8?B?Y1NndExjb1B5M3M5emdNV0hhbWhaS0NSK0dhRjZxbXF0OE51RVA3UlQ5dmx6?=
 =?utf-8?B?UVArVlRQNlVsT2w2MktsNWZubUU2L0sxOENJWTN6UjVHNExkUWYvRWMrb1Q3?=
 =?utf-8?B?cFFOWFdXNDNWY3J5U3M4YTA3dVRySWVSNE43R24xcHc0OXJSenNDd2pmdG5Y?=
 =?utf-8?B?bjRJSmFLd0FDaWNjYUFMMjJnSWFMeG9EelhpUGVhUFYyeDBRUGNuZGdoZU5n?=
 =?utf-8?B?cmx2TWRiWnpuaVBzR2hvZ3BSTnk3NXNNc0F4SXVDaGpjR1luTzBuQnlLV21q?=
 =?utf-8?B?dzZYQlA0OEpvU2VqTHl4eG9mWDJLdCsxcFpFdkNiQmVzWG53MEFBSTZLRWdm?=
 =?utf-8?B?dnd4T1JlTlNUZkV6VHRGQjFsaW56THR5dExYNE16Q1U2VkQ2T01xVDlzT2Y2?=
 =?utf-8?B?MXdMb0lEaERoMWRkTHlRRmdLMjlDOU5jdlU0NklYVzk1aVlUazlPdnVDajNU?=
 =?utf-8?B?d1hSa09EdnE5RG9zQnUzenVFQU93eGZ4VitPay82ZlhKQ2hubGd6QllGV1Jv?=
 =?utf-8?B?ZC9uek9jTml1WjhBRzVURTkrMWFOaFJQZ2tEekpOeUZtdVZNdnBuaGZkTFNo?=
 =?utf-8?B?V3BFcG4waHdSZHYzMnlsVjA2MTkrbXR1Sng1N3VKWm5pMVJqMDRpaytPZDZL?=
 =?utf-8?B?TWxGOUxXTTBuemtLT25UbmVWdjBZNmpncFVvb3FyTTllV1BoUXF4NWo3Ky85?=
 =?utf-8?B?cU16cFN5OUVwQXlCb25EUGNKVFRQRVEvTUdoNHBMWGxoTCs3SXJFZVRwWTFn?=
 =?utf-8?B?aGc2cy8zdmpsV0lIdndYaHFrL3NUZGRjazlzVXBIWTF2T2Z0ZHh2K0xIZUFz?=
 =?utf-8?B?eFMzUU1SWWpsUkJMckJxWTBlQ1hjMEJEWGgveXhncVRFMklFdFF6RDNFQW1L?=
 =?utf-8?B?d0xhbTJPL3NabXhZaThEdlRsMkxlRUNUakJRbDI2cHNOUmRmOEhoZzhNbWFU?=
 =?utf-8?B?WUtJUlRoNVc4bTk1bk83dm9lTS93SStLejRZUlBZN0FoR21SM2g3MU90V00y?=
 =?utf-8?B?ZWdONHoxMEY4Yk4zUUlPWDJldzFzS0d6Wk1TSExVc1YrTUxFUEVmZEJoZG9O?=
 =?utf-8?B?L0tHQndGb0J3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHBnWEZLem5ydUhZd2hoQTdwTnRLWHpwZVI4cmQvVVJlRU9YL2ZIdjdROFQr?=
 =?utf-8?B?eTVLVncyM2hiWHJhWUMxenVjWDF2aU4ycm9uK2crVXJFQmtndTZzMGx1WjlL?=
 =?utf-8?B?NFRkcC80WmQzRGJqcWhkOFllKzNQNVdGWnNvWEJzNDRJenczYVZxc2puL0V6?=
 =?utf-8?B?d2JmVTlLRkl6cUkrcjRsa01paG44VHZRdXUvTFlrVzR3YVRlc1crT2o5cHEr?=
 =?utf-8?B?aWhJWDRteXZMdWFXczA0ZTZRS0RuVzhaSHNIOUJpb1NLQWNQanNmZzVxbFNj?=
 =?utf-8?B?R01lWUxLUlpuR1FrUDNpREJ2N1BBNVBPcytZRXczUzYrR21hRFUrMGt4dmlv?=
 =?utf-8?B?T0IreXdvRjRhV2R4eXJNTGljb3VTdlhLcFhzS2VCZm5ZU1NxeWp3VU5ubkJN?=
 =?utf-8?B?bmc0Nk1UcFNicjloQUNXbWhrOFNrdHhFYmtZNWtCZSthOVZTNEdBdzk5TXdl?=
 =?utf-8?B?TWRzdHIyMEQrSjlmMXgwTXBmRTIzSlVkWmNIQm1PNmszS3hsL3EzSDJVMStY?=
 =?utf-8?B?bnlkMDNkT3U0d3lxd2VnVzZzWTdWY3A4Q1hrRjF5bVN1QXJRQktVTHJtU3hS?=
 =?utf-8?B?QWhVQktNZGJxU0ZKa2JvbnZ3TXlkcEY0bW1ZU3h2QXFRSlNUWm1sc2lCL0pn?=
 =?utf-8?B?OEhpdktjcGtjd3RWZUpQUUMzUWswdXVzWjNxK01DZEtXVnRaZmh1b0hSb0tM?=
 =?utf-8?B?SDlld3loekZYZHlrdWx4VmtKb3oyMmdkb0RNL1phUkFYTzZUN1FrS2k0TW1Y?=
 =?utf-8?B?ZExFODFwSGNMSVJjemZDWlQ1NnhDaER6UGxjOGQvYjFhd3FNTE10R0c5bzgy?=
 =?utf-8?B?TnRLdUhlUXlVbGZsZldscUdzdTZQYlJKdmlTNS91RzhLbXhvNTJEMXk1L1dE?=
 =?utf-8?B?K0tZVUVIQjNLMkhOcHg3NlVXL0hIZWtsK1dSUHNHR1F1U1E0VE5ncU5idzBu?=
 =?utf-8?B?QzJuZVBPK0FFMW1yTGkwK0RkR250Z0VjTG1CQmZKVW81NTYvcWNmTUhubmtx?=
 =?utf-8?B?bnNOQmxaK2hyamtZdlNBdnNPWllUeWNaMnU2TTBwUmw4dGp4RndzSUF2a0JW?=
 =?utf-8?B?NEE0RzRWNTlGU2N1Mjd3K3ZZSUROZUNweXR3ektZUkIyNTloSHVMcFRuNkJw?=
 =?utf-8?B?eG1Ba0VxN1BNZ1hPTkl4MFBoWmRlb0QrWjg1Z3U3UWw2aENMR1ZNWERmcmls?=
 =?utf-8?B?ZkF4b2g4cE41TWU2YWg1eGZ4Z3FpZE9SU1dZYXh1WXdkZDBPQ1pDUVZ1RlNy?=
 =?utf-8?B?U0cxK3NOaWZ6eVFLT2NJd0ppZ1pQazBUN1lnTnEybmk2TEt2dTFJTEpoaGNR?=
 =?utf-8?B?V3BxbkJvRHBYejgvcU9RV0owbHdTaWJ1TGtVQnB0aEZ1YmJpdW1wY3A0WHN6?=
 =?utf-8?B?ejBLRGJOTVFoMy9rQWhXeFJKejYvYldQdCtTRDdIZXBXK2Y2YnQwS3lvazNO?=
 =?utf-8?B?b21hbzNwOGk2TUJpWFBhTW9CKy9sRzNtUFFWZnBhRmhZZE9HbGJzMjBMMmZM?=
 =?utf-8?B?dWR0Qkp6U1dBc0hqQk9QOHN4NCtjK3FpOS9YV3pQZEoxdmZGcXp0cEtXdFJw?=
 =?utf-8?B?RlU0eEtaSDFPaEx5MVJTcXNUS09RcVNCRDZ2NGZwcUdQZ0pFelN1NTQ4aS9Z?=
 =?utf-8?B?TVIwU1k2RUdzZk91akUzOGE3SEFud0xybDdFZ2ltSm5FUU9RZSs0NEdOeng2?=
 =?utf-8?B?aWhqdzl3ckJJZXpmaFZidlIwU3duREZ5VU5tb2hYUGg4OVBGR3ZaWTFDSFNj?=
 =?utf-8?B?dDlCSzJiTW04eE55TGI1VWxBMTZRVlJEMXRWdnczV2xIbFNCWGtyVnloUlk2?=
 =?utf-8?B?Ty90Z2hRdkJGMzRRekxGS0NLMkdZdTJWMjN5VlJReHY4Uzh0Y0ptV2lKUVQ5?=
 =?utf-8?B?SndRUkRUamh3dmptellCNDFiSG9Mai92b1ZBTUU1VlU2aFg3NWs1V1NUbEUr?=
 =?utf-8?B?Z2JPR1hjWnNqM1o0TzdRcEFDdC9WL3VSckJ1ekt4cGlZc2R4TXFpRVhVWjVw?=
 =?utf-8?B?QW9VMElueXgrVVVlNzhIRkt5NDJFLzRJdHlUa1VoZk1WVkZPaFhKd3FqU3RC?=
 =?utf-8?B?YUdTbDRzRnlRcjl0SXNlcDAzWWNuSThXYjZ3cjErSTN1WXkzeVR3aEhzMGZv?=
 =?utf-8?Q?JDpHYN89sGgf1ol9B8lBAnrbL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BA6F83B5F4B5E4DB20216126D8F4F1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb59800-2617-4e22-2ac0-08ddcdff6d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 17:51:48.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ut/HkiLOywa4o8edOCmCDAyvRX0fU53C+4mb+ot1thWd/CUmB24/rdpQbMQYoF3lLz6tB02EAjOM3Ov7JHVfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296

T24gNy8yMy8yNSAxMzoyNywgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gRnJvbTogQmpvcm4gSGVs
Z2FhczxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPg0KPiBGaXggdHlwb3MgaW4gY29tbWVudHMuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IEJqb3JuIEhlbGdhYXM8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCg0K
TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==

