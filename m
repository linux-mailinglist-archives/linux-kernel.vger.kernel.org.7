Return-Path: <linux-kernel+bounces-727676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8564B01DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C0C1C4347E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712382D97A7;
	Fri, 11 Jul 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="cGFMwfXV"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2312D77FA;
	Fri, 11 Jul 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241129; cv=fail; b=c7T9kUGOzD7NdNmMjo4al9z29x2iGtgkWZu7iqMOgNHEu79nEOw45QTkpltEx9jamMl4IBAL7yZIfuSUbgHBJx6a5rqZDhcR7ezXeBzjFCWuQp+DOW2DkfETPPK+TFlCiBg8fJzYCW2Cy2nTKZsajRcfo/Cd0CPhVBVwhAM1EbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241129; c=relaxed/simple;
	bh=LpihxFnZh/GBRg9nPct4ivRLcs4ASEp21tEjIRHW9lQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tvcgfdut0URq9lNa20c2rb7gkwjUqLloTVrw1SQq7xVtfvvhIah0b2z6QB3TPfUn9YPgoyYGuBQOnhdPYhM78I+5xMMHEd83hVcj2DkjCmwZHXvXYacJWe6FcBuD4AW5teegW0Fovs8D5tCsZ2gS2GSlNXzbe19KUHNWGHC7kyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=cGFMwfXV; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDaNFS008729;
	Fri, 11 Jul 2025 14:36:24 +0100
Received: from pnypr01cu001.outbound.protection.outlook.com (mail-centralindiaazon11020137.outbound.protection.outlook.com [52.101.225.137])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 47psctjcqp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 14:36:23 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCqvfYqcnDyotEYbd+k+tHHYFU+nmOwmMQA/RAkwgupSWuNp0MIZ7IgQeFp/SND0xMjgGhwTaPExCWXubOPquebbppsLEp+vMK2Tgm0Nie0bqLYbQy+RDZ9iOn3gZ17VvK8aZpnA9piXmfVx8PHFNol3sosmRsL/2y6jL9jWoj2bYIZ13IDNFXlTagUGPYI1iSwRNQWTShoM8xfVcGbFvHqi74GmdrKqo8eUfxZj/DkAjxfRKB7qthq04hym/fnvo3EEg42E1a3PXrxjpNlrlAcl/HZkUGblchMMD2Q+sowN6cSk1UgACVc9HaKK9m95qzJRLx5O4Ko+UiUdDRadcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpihxFnZh/GBRg9nPct4ivRLcs4ASEp21tEjIRHW9lQ=;
 b=MYaDYnAu9TuOVnCvUNlPLUm/w2SqpmMLzZHFNSUaKZJz8HwGEvPwBXYirdsBsuntFvZVFLnfgzR57zG3MkRsfIoo3d34C+DTuWm6rDjpyMCTYLC7V/g0BGDRW6uX1ku3NZrbL1uIvn2kS7d6XaK4x99Qy6sQqVTqEPVrdGjSt1eVK12Fnxh3HVVj1odFMfGmeHEHQsWpH6KONgBZ2FN8xjFyNuB+7DZuB4RWYDOUf8NYtfCFWCywXh2Ji9sjdVKDFE/GvbORyjz8n7PqglSwkP5L/TR2d1qhQpgTVuM97U1xBjE9NRSPyCYBa0buDhudA4ZOAnp2D1oOuUBEEY7gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpihxFnZh/GBRg9nPct4ivRLcs4ASEp21tEjIRHW9lQ=;
 b=cGFMwfXVwYjS8RX4iKzh0v17FP686QUog11s98aYlMLgfo2R7c0BnuOyzANwnPwgpkv6fBs4DdF1wc1zn+U9jLsFFmbmLWZaorxbK0mQ0ELeWeWVXz41ZUBse0CC8hX1xvCPjxrKWaIzkllgbufMxrcqU5a+xQsBFWc+Dm1dKKg=
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ab::16) by PN0PR01MB7862.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 13:36:18 +0000
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83]) by PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83%6]) with mapi id 15.20.8835.018; Fri, 11 Jul 2025
 13:36:18 +0000
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn
	<matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nikolaos
 Pasaloukos <nikolaos.pasaloukos@blaize.com>
Subject: [PATCH 1/2] arm64/dts/blaize: Enable Ethernet support for BLZP1600
Thread-Topic: [PATCH 1/2] arm64/dts/blaize: Enable Ethernet support for
 BLZP1600
Thread-Index: AQHb8mjIg5SeFvcA3UCuh7HDySKzkA==
Date: Fri, 11 Jul 2025 13:36:18 +0000
Message-ID:
 <20250711-kernel-upstreaming-add_network_support-v1-1-4a66a17c94b3@blaize.com>
References:
 <20250711-kernel-upstreaming-add_network_support-v1-0-4a66a17c94b3@blaize.com>
In-Reply-To:
 <20250711-kernel-upstreaming-add_network_support-v1-0-4a66a17c94b3@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNYPR01MB11172:EE_|PN0PR01MB7862:EE_
x-ms-office365-filtering-correlation-id: 958d4939-1802-4bcd-659c-08ddc07feabc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3pnZzAyMlNoQkxkRDE2UFJUcTFiSEtNM2ZwTjJsemZ2VENrZnJEd0RpNXFO?=
 =?utf-8?B?RzJnVlhUMEp3Q0tLOVltUG8zcS9KUVlKMDNJczdJV1hTTnNNeC82QW4zQ0NS?=
 =?utf-8?B?YXZTZXlQdDRiUW9aS2krN1NkRU42WWZjd0lQeFhLK1RmNlF1TGdkaW5RNjh4?=
 =?utf-8?B?WXBIWk5adXl2NmRDTTVzNUVob01lRC9La0FsOHArS1VIVnhBK3NzNE9MWkhW?=
 =?utf-8?B?NDZERUtIVjQ1K3lhWW1uYnFSZDJiaTFTTEYrcU5MSHZDQ09YU0ZuOWlzL1hG?=
 =?utf-8?B?RkRnbmJQeURMV2Q4VEY1QVhHOGM0Y2JDUEVqSXhQRXlzcU4vNStYeVpDbGJ1?=
 =?utf-8?B?NXlBdVlkZFZIZWQwY0lxRnp3Q0NiaXRVZU9EWkRIMkxTK3VTOTZoNzFXQURm?=
 =?utf-8?B?amFIZTBIU1lWcHZpS0Zxa0NaaDFnY2ZCa2pydW9MTjNWdXlOcGo3Nys1YzVr?=
 =?utf-8?B?UDVYMjUzbGV0U2FUZkgrcTBGaUZvY1VUTDJoNUJQRkVVbWthSzNEa0dKUWhN?=
 =?utf-8?B?WXZxY25rZFlOOVlMWkxUaGx2eDV1aTR5SERsVE1KK2pMc1hBd3BpQ1F3dWVp?=
 =?utf-8?B?WUxmZE8rUEVpalBuMUphcEQ5ekJuSTdKK3VkM0dPZlVyTlg2Yk5GOXZ5TkJx?=
 =?utf-8?B?Zjd5ckxwd3pMdlFJRHVPR0xGUklCOUJWOU1HLzVWYjJVRlQrL1o5eG5nc1ht?=
 =?utf-8?B?YTl4VmJVSVNKMXFjcWkxcDZINE5ndTBJRksyT2VnQTVXakMvT0FVRGZnaG0x?=
 =?utf-8?B?UDV6bDNqSWNmaEtpVHRYRzBwK0FxVUtnV0FZUkpUTXlnQmxTYkZld2RadXk1?=
 =?utf-8?B?TmN1SEc0eFBnUUgxdHNEbSsyZHoyS1lWRmxXMWk5WTdWRWRVR1ZyOGtMa3Nr?=
 =?utf-8?B?UFdQYzdwT1FTWFN6UmJVK3RQcGx1ZmhnRWZGbHdnaDlWUmtJTkpwVXR5OXFH?=
 =?utf-8?B?WDJLeWJ0L2gvMFhqQXJWNFdNNmg4QmNFZEJuZkVla1RYOVNXdGI4d3F4ekdH?=
 =?utf-8?B?MC94Ynd3T0NhelBock1Mc3JkN0dmbzc2cC9jS0JCVE8razBiZWZjM3hPeUFG?=
 =?utf-8?B?ZTlGeEQ1SnNTaTJwRGUrRXZCSEJLcGVqaVk5YUY3K3R0bkFlM2hNMnpLbGhY?=
 =?utf-8?B?bkRWOFRRRDBsbGZ1RlVKZmt6VTNhNXpQMStWVyt3Q1VPTGluZFEyZjdZMEdM?=
 =?utf-8?B?dEhwT2Fzamg5OWVIalZ4L3NoQ3ZXNXNMU3h1VkdtZ0hzYzR5N3RuMXVtcU81?=
 =?utf-8?B?ODdDUXA4NGhTZmU4TU9IRWM0R29oZVFvVlJpMjFHNHB5VHMzY2R3UU5tVlJ3?=
 =?utf-8?B?Wnp3d2FQRXpjZThlTWV0bHVKZGNLb1NFUkY4dGJzcDlIQ3FnV2xhOS9zZGVo?=
 =?utf-8?B?dlZkUkNNMkx4L25CMVVXeXRuZEY0YzI1VmNKZnlqdjRUdVJSb1AzcEpSaXoz?=
 =?utf-8?B?K09taWFwVlAydm9rblBoazA1TXNKNHVEbTRHNTRMcU92NVl6ZEZMWVBUM1Ri?=
 =?utf-8?B?ZzdZcFNIL1h4SjA1TGlUQlpXbENpWS8vbElibk8yR1ptbGFMVEdtaVc1OFhr?=
 =?utf-8?B?YkpnN001QVhCeFh5NnB3MFNXcFZiU1Vkak01azZ2Si9VOUpSVmhscnpjRTFX?=
 =?utf-8?B?ME1HR3Vsa211NzcwMnc3VW1SUG13SXNvNTBDQ0xVZ3RoY1VySGc3di9HeXlx?=
 =?utf-8?B?MGFlczVLdDJhU0xRb09vT0Q1Zytld2NZZUxSTmRxTlJhTHhyTXQ4cCt3L0R5?=
 =?utf-8?B?Y1BpMTI5VnNtUWJlTXVvM3VOR0FxcmRDYU9QTldveVRaeXBRektaYmgvT0J0?=
 =?utf-8?B?aWQxeHBRUEpQazluNXE5S2VtMmFuMkY4MWF3QjRmZlF4S3k0YkZPa2haU3lR?=
 =?utf-8?B?Y0YxSWhwRXl2R0hNdVJJaVRCSCtlbUd0QkwvcERTSnIzUjZRa0V2OFVYQWhB?=
 =?utf-8?B?a2QvTUZsZGprNXdLY0ZiWmJCdUVoaWR5Uks2VjlENjcwbWRFQnJTaU9WZUNu?=
 =?utf-8?Q?hAs2cdPFaS5K+KASvgzbOC8Toh6FxU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlU1NjB3U1p6dzkyeGZsb29HVktpMThCYkZKWUtCaTJlVjZNUW83QVVCbTdI?=
 =?utf-8?B?a2FFaEl6Q1N0QlZKTDVXeFNVSTVDZjF4bWdxQmRNL28vNU85T2ZaT0pPUmVy?=
 =?utf-8?B?YUh2UENldENDR0xJbEk5WGZiQjJYTUZnYmFKS1ZvaUNMbFFReWRWbDNkYis2?=
 =?utf-8?B?cGE5T2lDMlNmZ2EvZHhQUzV5bXNSZHVHNVRmMk1EbS92RVVySkpBL0NXTGth?=
 =?utf-8?B?WkRZeVBBSVBWaFFDKzBCUkxxYVJOZWRjb2RDbG9IM2pUU2tUdFZmaTNmZk1U?=
 =?utf-8?B?TklNRXFsUExnRDFlU3RjVHlrS2RiaG9hRDA0eEdrUk42OFdnRExHaUI5L3Qr?=
 =?utf-8?B?SDc4ZXdvcDZWMFhGY29mMmRnaVV3MTMwYVNKZHFSeTB0TXBycXNNWHZsOUdu?=
 =?utf-8?B?dkFOVmMxbFBZemQxWkJ2a29kNnFzaS9EZ3JkcWpxQ2E1M3UzUElpTzdkV0RE?=
 =?utf-8?B?ZGcyV1ZZaFUwb0FmWllTbC81aXB3T001Um5zcXhQOEZreE1KVWRvdmtCOXVu?=
 =?utf-8?B?NkdGVUpCK1IrcU5QV2tSVmNjZmZPTTRBc0pzMnZOV1RZK2wxbjNiY1ExUGdQ?=
 =?utf-8?B?ZkJZUFZ0aXpiL25tNjFPK0g5ekVUbCtiemVaamMxTHk2bkFFVjB0cXhFUnA4?=
 =?utf-8?B?Sk5TNHFmZVdmTVE2bUdOQUk1NWs0SmtoSGI5WFBDS0Y2d3RhRVBnUnVud2NW?=
 =?utf-8?B?LzN3ZTZENHJaeTd0cmlmbVgvVy9wRzlxcm1QdSt1aTI2RTFhSE5RRFY4c0NM?=
 =?utf-8?B?aEJHMUR1YzdQRUpoVlZXSDB1ZEl1YW53SU1BKzJRUGNuaWZFUWx5OU1tb1VS?=
 =?utf-8?B?Y0RodW5Bb243WnRGUXhDUEVmeEYrRExrUjcxZ0ZPZ1lhVmZGdkFxR3JUYkla?=
 =?utf-8?B?Q1pqcG16eHJCcTI4dm5CbXJBOFNVTjB5emtWSGVOOGd0N0FRd0xGMEZ1K2d2?=
 =?utf-8?B?aHNyMDVDZG10MFV5L1VXT2ptVHZaZU9jajBpU3Yxa1c5NUFaK2RCekl5RjZs?=
 =?utf-8?B?YUh5b2ZpK25GbEVWbkIzT0FUcWhsMlo5YkEzUnhpcnlnYzZ4VWVvNUpibkdi?=
 =?utf-8?B?bFVUdUhVSGRUQ0MvLzNBRm9lb21TRWtHU3hnL0I2b0wrcVZWbkxRU0hGdG1S?=
 =?utf-8?B?RTNjTnFkUXFwa2JCMS9saXF2a1lmTTB2YmRtZGVScG5MOTR3ME4rMmxIUlg5?=
 =?utf-8?B?TzBTRDNjOFV1WlkxZnNETURoVnVMV0dLSHA4eElRV3FiT3BvTkZ2RXZyVXVs?=
 =?utf-8?B?Y0JLb0pyOTBkRDRwYmQ1RjNINTF2NzRFQ243RkR5M3F5RUFaVTM1dkR5OE1n?=
 =?utf-8?B?K2F3YVNZdno1RGdEWEZLRThaU2g4RmNJaDQ0ZnJPTHhSTis0V3gzRVpEUGUy?=
 =?utf-8?B?QlVKK1g0RkU5UjZzTmNMalpjU2ZPQzdvT3JLTGxSWkRhWFlMa014dDc4cDEv?=
 =?utf-8?B?V1hzeDZoNEtEZUxzak9kYksyZS9yeEpyYlgwQjVPbVV4WEYvMzV5c0NpMDNn?=
 =?utf-8?B?ZGt2SXhVNHdTd20xcHZHNGlydnJ6WWxTN0NHTTB5R1BsbExIeUpYSitLc1V0?=
 =?utf-8?B?U25ybU13SndHdXl4ZSt3NVlvY2J0cjZYNEtZU2pzc1NVaUJiSnRQcGE0TmNZ?=
 =?utf-8?B?WVphMnorYlBVcHpDczg5UEF3RHV1b3ZtSEtIMHdWUE9KdGYvSUZmSEh6dGpN?=
 =?utf-8?B?eFBxYlJiSGpOaVVXWTgrdk1leFRjTHdSZTRKVWdkaThsZ0dGcER3MUVxQjkz?=
 =?utf-8?B?YUZiakZzYXRGRERYZ3owOUUwREhIM0pRbThidWFORXl0NUQ2WmhZVm1wSTIr?=
 =?utf-8?B?dktCUjYxVlVWZVV1RHYxK0VJK1B4TzltWnFFK1BvMlZTWi9rV1k1d2ZEdm1G?=
 =?utf-8?B?Nmw3RTlDQ3FEUFdiMTI0cVl6SGpBRFFCcU5aVjR3cEEyTGprOFlDdVBiN25r?=
 =?utf-8?B?bFA3bDFNb01NMVJUYVNtdWtDcU1RSUFGYzNqc0JRL1VZWjRtQWVtRDRQcEox?=
 =?utf-8?B?TTcvWGg2THVwQzUyVHNPTG9NdTlaWmo3S01lUFduNmZtZEFNbS9Wb2t3V3Iw?=
 =?utf-8?B?dHNQTWhzWFdySk12N0dINkh5MWdpbS9NcTVjT2Frekl1dS9Ob0drWm53Y0t0?=
 =?utf-8?B?NGxOM2Y5cjYyMldwalFsVzBpTlpGS0tGdGwxTU9tUTRKK25oaDB6Q2VIYkd0?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A6DE77642C3EF42A3E6C32115EAFA0B@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 958d4939-1802-4bcd-659c-08ddc07feabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:36:18.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jsItI1QJCzOAFldQLscpy5XpXOByFP80CrJUiYxG+zDssbMsDf6mRjeemNwV5A3zsjwK9xOI8jbx2Uy27ChVGvrTL1nfi9FWhplM7J/YD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7862
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDIwMSBTYWx0ZWRfXwVRYYmPJl1sw /GH2dBWxTGTnT1zTA4FDikyCMTopF1pl8Ou/zGTVwF801YxdmebInrxRpiSMoL8eDG7f6gNkOJG S1KYIOHXh2cqPG9xnZ/o8t/n1hbMGgw1TnzufMgde7oaBwx8CAJKO+bJrFH8gRn8cdLFX+5YraL
 tw6BPTm73+iFSr5ropVOdNq9thefZIirRrSd6RoaIk8khKl3HSkLIJaOUGiqguVGxi4lQn9Qsn0 ym7QRbQ1l6YX2+WTtKIuIl7WEuwpGHlefOnn7isHEo4QmEmpYJrxdh7KmZnSqanuyKCoiGqcDOp wvfyyU5zh0/rqwxzPRRmq3y2xo2nGP2yUOj3UWpoNwu0FhaWs17PnhZ6SUFe3ZI37sg0lxcFSLk modO+zj2
X-Proofpoint-ORIG-GUID: EIU2faBreUTAkyMLE70wd0tc0IRAhiP6
X-Proofpoint-GUID: EIU2faBreUTAkyMLE70wd0tc0IRAhiP6
X-Authority-Analysis: v=2.4 cv=MMVgmNZl c=1 sm=1 tr=0 ts=68711358 cx=c_pps a=oCCLDGIEOjCsJBocmZPjNA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=WQsBsLtPPbzHpxbNYyQA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: orgsafe

RW5hYmxlIHRoZSBTeW5vcHN5cyBnaWdhYml0IEV0aGVybmV0IGNvbnRyb2xsZXIgd2hpY2ggaXMg
YXZhaWxhYmxlDQpvbiB0aGUgQmxhaXplIEJMWlAxNjAwIFNvQy4NCg0KRHVlIHRvIHRoZSBTb0Mg
SVAgYmxvY2sgY29uZmlndXJhdGlvbiwgdGhlIG1heCBmcmFtZSBzaXplIGNhbm5vdA0KZXhjZWVk
IHRoZSAyMDMwIGJ5dGVzLg0KDQpTaWduZWQtb2ZmLWJ5OiBOaWtvbGFvcyBQYXNhbG91a29zIDxu
aWtvbGFvcy5wYXNhbG91a29zQGJsYWl6ZS5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRz
L2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAuZHRzaSB8IDIyICsrKysrKysrKysrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9ibGFpemUvYmxhaXplLWJsenAxNjAwLmR0c2kgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2JsYWl6ZS9ibGFpemUtYmx6cDE2MDAuZHRzaQ0KaW5kZXggNWE2Yzg4MmIyZjU3ZDU3
ZDMwNDg2OWRlZTg3N2M5OTZjYmFiYjcxMi4uODkwZjY3OGRkYmM0M2Y4NGNiM2NjMTZjOWQyYWY2
ZWRiNjM1MGVjYyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYmxhaXplL2JsYWl6
ZS1ibHpwMTYwMC5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2JsYWl6ZS9ibGFpemUt
Ymx6cDE2MDAuZHRzaQ0KQEAgLTIxMyw1ICsyMTMsMjcgQEAgYXJtX2NjNzEyOiBjcnlwdG9ANTUw
MDAwIHsNCiAJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNjcgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQogCQkJY2xvY2tzID0gPCZzY21pX2NsayA3PjsNCiAJCX07DQorDQorCQlnbWFjOiBldGhlcm5l
dEA2NDAwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAic25wcyxkd21hYyI7DQorCQkJcmVnID0gPDB4
NjQwMDAwIDB4ODAwMD47DQorCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE1IElSUV9UWVBFX0xF
VkVMX0hJR0g+Ow0KKwkJCWludGVycnVwdC1uYW1lcyA9ICJtYWNpcnEiOw0KKwkJCWNsb2NrcyA9
IDwmc2NtaV9jbGsgMjk+LCA8JnNjbWlfY2xrIDcxPjsNCisJCQljbG9jay1uYW1lcyA9ICJzdG1t
YWNldGgiLCAicGNsayI7DQorCQkJcmVzZXRzID0gPCZzY21pX3JzdCAyOT47DQorCQkJcmVzZXQt
bmFtZXMgPSAic3RtbWFjZXRoIjsNCisJCQlyeC1maWZvLWRlcHRoID0gPDQwOTY+Ow0KKwkJCXR4
LWZpZm8tZGVwdGggPSA8NDA5Nj47DQorCQkJbWF4LWZyYW1lLXNpemUgPSA8MjAzMD47ICAvKiBE
dWUgdG8gU29DIElQIGNvbmZpZ3VyYXRpb24gKi8NCisJCQlzbnBzLGF4aS1jb25maWcgPSA8JnN0
bW1hY19heGlfc2V0dXA+Ow0KKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQorDQorCQkJc3RtbWFj
X2F4aV9zZXR1cDogc3RtbWFjLWF4aS1jb25maWcgew0KKwkJCQlzbnBzLHdyX29zcl9sbXQgPSA8
MHhmPjsNCisJCQkJc25wcyxyZF9vc3JfbG10ID0gPDB4Zj47DQorCQkJCXNucHMsYmxlbiA9IDww
IDAgMCAwIDE2IDggND47DQorCQkJfTsNCisJCX07DQogCX07DQogfTsNCg0KLS0gDQoyLjQzLjAN
Cg0K

