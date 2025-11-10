Return-Path: <linux-kernel+bounces-892955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C76CC4633F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E340F3A5CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C92E173B;
	Mon, 10 Nov 2025 11:18:54 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022075.outbound.protection.outlook.com [52.101.126.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69C2580E4;
	Mon, 10 Nov 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773533; cv=fail; b=b3r+bSgMhxuSXzDy9pS+XYM9RF84IwZZtjpqoA/12x3FCzBAfB9+WOH5vjy2IV2PmN3PTWabBB5P1dhdbf28zNMzjS5A3gHR/3BnOvyHiDqx21LyqRYkMzHHWFgaG3q4bOEtjFoJme5bbg1QHjsUJ28/XxjO2vQOHEiX5tbj3pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773533; c=relaxed/simple;
	bh=K4puhpyNWy4/TeTB7g5vrNX9KVCpeTxhhmb7ZPeMoOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rKxuwwM5CiV8uEJMuzmG0L+kvmHI9tjjqqqz5VUq+tvS5WQO2qSIhheJnJ2V+p7F6/ez9BGQ76kBCV6nGMVv5sFJEEtbpjf70X6+2fmLTQP5jpQ6cCov+wVSe8yZ4/uuqWaHZyJ0O9RTh8RNFF1Wox3Forzf4F/8L703dRAeRXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpue+/XqERCPn3SadswsZOip8r+wvNK25AZfVlmeZMn9jvJrdYlKxgsijQwKebPLGL0Ag8TQ3U/v5hJn0nWj4o9weUONWrFdfSzhav42KU+aP5xic2LpEYZRL60lAZ3NroFrbSt+d0GBZ6uiMbVylDOU0FQV/k7Fi0qpGYZdHxgRFNOBvakA1K0X6vC0Aejc8POK066SazXBJN923mzOzIvn8iAhTb3x7DldhYYbGkdbUkUUOg2Cn9qaPutYQNXRYYr2vsEj+wiD9Bore8xPfDa9K7+NBoMBFLGSFpzHdHIaqrgiLQJ6+O9r5+fa8ssZeQ4ZV6QfTKGT6QZdfWETAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4puhpyNWy4/TeTB7g5vrNX9KVCpeTxhhmb7ZPeMoOg=;
 b=JRm5o11XSjcLUl8s3r/bSirGTeYaI2Hx2BYKfERh1SaxzMLc3KqlENlBMHo8Bhm2vLVr4Au1f73bnWo4tWEq8pDeWyl6ZC+I6i2TzoGhwphe4xNt9cxr3PDltgZq0MCbFyAdPvx8xJtqhHXWFUVF5pu9lCaZ4XL48K78XmBjKPqstqQoYF12AOSQsd4aRL5mFZ26tscQBjj52qlnPMqgn/q/N2ZsFNkihnbNA7le3r2s7hezB3PtiMrEW6PGjp2iHuQhshLQlizhyvgL6b9gLQYFXy82N64iAaN6fvk+UDxrLyNbl1Xa9cSS2Mn8uLUTD9bBSalKazS9Lhdxmjv2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by TYZPR06MB6990.apcprd06.prod.outlook.com (2603:1096:405:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:18:46 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:18:46 +0000
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
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMi8zXSBSZXNldDogY2l4OiBhZGQgc3VwcG9ydCBm?=
 =?utf-8?Q?or_cix_sky1_resets?=
Thread-Topic: [PATCH 2/3] Reset: cix: add support for cix sky1 resets
Thread-Index: AQHcT5f6k32l2FqOtEO23efN98Wr37TmznKAgAS3HTA=
Date: Mon, 10 Nov 2025 11:18:46 +0000
Message-ID:
 <PUZPR06MB58875805D441AF3213189979EFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
 <20251107033819.587712-3-gary.yang@cixtech.com>
 <69efdb9a-c03a-42f4-a78e-18c8a2b29322@kernel.org>
In-Reply-To: <69efdb9a-c03a-42f4-a78e-18c8a2b29322@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|TYZPR06MB6990:EE_
x-ms-office365-filtering-correlation-id: 59aefb23-59ff-43d5-8846-08de204aea38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkgrSnRsTUhXbWtGR2d4Yk14aWU5Q2VScjdhcXVUbmozN3lLVTR3U01CZENW?=
 =?utf-8?B?d205QTVPY21NUTAzdURQRVhFTnZLa3B2c1dtL2gvWXJsanppZzNaU0tEdE9Z?=
 =?utf-8?B?QjczaFUvMXRqL3o5bWNTMUVJUW5DVG5nUCtmRjE0WWxzRWpKMTFQclZTdENx?=
 =?utf-8?B?UlFWYUExSTVkbWJlcnppZ3RDenIwU2g5amNjK29zcjFyWjJUcEg1alg1Y1p0?=
 =?utf-8?B?bUw3NFFoMlNla2U2a013b2FwUEdxUWFyc21ZWWt5YVpoYVJzWFpQVEJxYzVk?=
 =?utf-8?B?RnlVVDN1MmxUcHhSSkxKYWtnUkZDenpSU0xhZDJxYlA5dEtRQ3k0N0V6WUNj?=
 =?utf-8?B?c29TTURMN2owdzNvby9EUVhRK29XVjJJK3EvempraUxwOXlCVWlXUmJXMlBB?=
 =?utf-8?B?b0xkWjBhQzRRU3BNNGhpV3IybDF4blVEdjhONXhUaC9JWitSdlV3eHY1bndH?=
 =?utf-8?B?bVJBaVZ5RFVIMUw4bkN3bGdXOFpRb2EzRXoxdGVkUm52SzNuZlJ2L2NnKzRY?=
 =?utf-8?B?TU1wVFJFRXBqd3lzek1JaFJTMFZwQlYzZ0l3QnJ5K0ZVdEU0eVZOb1ljK0Fj?=
 =?utf-8?B?OEpDYmdVOEJZbi9lWkJyc3lKTDV3UE1tSXJPejVIQlAzVEJvUDlvS2NDNG5u?=
 =?utf-8?B?dlJiczRXdVJVeHZmdk85czJiV1Nrek12anNISHlpTXp0RmZCcVBmODNxY1RU?=
 =?utf-8?B?NmZSSEhtT1FzVlAzd29KcVdkb1BNdjZXTlUrL2pERjI2MitlZ1RvMmlTd3J6?=
 =?utf-8?B?WVBIWWlQejNMNEdDWmxYWDBPMzdwOForMHh0UWJKK2p6Qld5MHUrYWpmdDBV?=
 =?utf-8?B?cG1sK0FzTFBtVUh1L0szQXBUOUY2L3V2U2kzbjBVb2k0Y1hjMExkdnBoVlZv?=
 =?utf-8?B?Q1BaZTd0dnoySnQrUjZVcnkrR2x3d2lkNUpzd1VaeEswMlhKeHk4eFdyNDFq?=
 =?utf-8?B?ZDBCQmsvRUhPNXhaemQ2Y3NQQktMLzhZYXlPYmhDdGRzT0txcWdZL1FzL0xF?=
 =?utf-8?B?U2Fuc0Vrc1NOQWhaTVdPanJoWEJ4OFBIU2VOMnZRNVEwZnk0cnBlWm1ZOTVq?=
 =?utf-8?B?WGlyNCtURVpJMG85U0txT3lmK085SU5mQ3lqMkxadkRhMmIzZlNSYlJ0QjUy?=
 =?utf-8?B?OUF6cUNwY0hzQ3hudUNjdkpHWTVDTkt4THBWTFpHRkRLWDVpV2kraE9BTWpu?=
 =?utf-8?B?R1F0eitnZ2YvRkc4ZFdPMjlzbzJQSXJWaXozUkR6eTVKM09kTDJ3YlRPZWFD?=
 =?utf-8?B?ZTVpcEVYVWlVK1VKcFlYMCs5S1NSTURqNGM1K1pvcEN2WUpwNG1Ta3UxNmRk?=
 =?utf-8?B?U1dYdnBSZmNQZFh4SUk4MTVGdFQ2TzIrRU1RNWdINGp6aXhpdjlTazZJYlFv?=
 =?utf-8?B?MktidW90d3lJOTNQQ3BSZFgzc2NqMDZmZzNPd0Vidm5pMjFxTmtreXgzakMy?=
 =?utf-8?B?RERqekxkWHppS3hjZVFSK3RZRnBPbDdhUVJzMUNWa2FvRGxpb2laWm9zMHZI?=
 =?utf-8?B?NkpNcjdGS3FkeFNUYkhPbE5LR0QyM0RLYzZlRUtPQ1hFeEFSN0x3ZGx6MzRL?=
 =?utf-8?B?K0IxcFAxSHlRK1JuZjJEaElhYzZGYm1NM29LT2Z1NlUzRjltYjRTVmRMYjZY?=
 =?utf-8?B?b20ycFZoS2JvdnlXMHc3UnNHM1gyQjUxOVhRdC9KMWcyNWY4cjNVb0FxRk1v?=
 =?utf-8?B?cGJpZnFOek9rVm5vcHpGYngyeFV2eE9pcTUrdnE4QzBNSUIzcGFxODQ2VHcr?=
 =?utf-8?B?OFNma21PNFlldTgwcHR1aFNYam91YjRxcUJwSlBRZ0pRUk4vdkd6YVE0bUps?=
 =?utf-8?B?bmo3MHRVNFF1RXFUZEg3aVdMazhJYVR5akx1c2F3Sy91WEpLUlNGVWZSY1NQ?=
 =?utf-8?B?clVhVkl1MWNLUVZDeDJaRnJUYktJeXpjSk9yWERZODArT2NXcGtKajZ6bXpy?=
 =?utf-8?B?YnVvMFdHcmErQllXa0VEbWk1N1o5R2NMazRGR1o3Y1RFSnVaeGpjdnpWL2o5?=
 =?utf-8?B?VzRseXhHWlYyRittTUg2OExDaEFxdkNaVEtFN1JqbTd3b0IxRXN1SDlJUzRt?=
 =?utf-8?Q?Y+8g9I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkJ0ZE16Nm42aXhQTkNBbklOUS93STRnQ3NBZ0FmYU81NGRta1BjazB1Y3FJ?=
 =?utf-8?B?M0lSOTVWM3BUM3IyVzJkS3hqK1IzbmZSYkV4cFM3REFYTFgrRTRQamlPckxi?=
 =?utf-8?B?bkVkcmxrbW1VTm1sUVJsMll6QU5LN2w0bHczRStTV3BTcjYxQ3k3ZnZQUUZN?=
 =?utf-8?B?b3JFdVNJYzJKbXhiL2RmNHdWUzk1VE9JOU5lY3AvUWNWdk1Ha1VWWVlkWU1q?=
 =?utf-8?B?a2t2dEhuMEFHdTNqWis1eW9EckY1c09SVU5XWHFQMkFyZTVsb2NxQmtVQncr?=
 =?utf-8?B?cDNZemNIQjJCTWEyeXc1SDd0L0o3aVJrNVB5VWY5Y01lWmJiUnppZnVBcHpz?=
 =?utf-8?B?NCtlVzkvTWlVaEorbmxuSVN4cm1DWDlUVmdIbW5iMnFxY1ZLOXBvZkpEWTRW?=
 =?utf-8?B?SjFXeWNIQjVQK3lwS0N4S0NucjhETVB5K2NVWW9MT08yVnBlelA4UUJFL1ZV?=
 =?utf-8?B?WUNvVFFmS3BwTDNEcktxeDhvR2dwL1FsMkFOTE9IR2ZsT1dHVXd0MGtiQkxL?=
 =?utf-8?B?blZ1MTdJQTVtQ2VyM0ZPdzkxSnlsOUMzK3E3MUZzd1dqclNMMG0vajdEaUZw?=
 =?utf-8?B?em5kZ2xTYWlwK3dzNkJNNkpVM3BoSGorU2RDRStwZ2tWNGYzdVhUbUhKM0xq?=
 =?utf-8?B?eDhXdG95Z24wczdUYzRucExPdHYyamxTNVRJL0J3c25sQzdicExjMnJzenl0?=
 =?utf-8?B?bC9zY3QvbFh3cTJsRkxkQkE4cms0cmcvOEVMQjk2UmVUM0tNekdYbVlTdTJT?=
 =?utf-8?B?ZGZTZWhaMXNaTDcycGNGUVo0T1ZiYThlaG8zamF4RnlGcngvWWhtSjVYVFVK?=
 =?utf-8?B?UVFBWlY2MWh5ZEVhTWRjV3Jray95cFNRdk5WQ2xkTU5qQzVuLzNzTytRRzVr?=
 =?utf-8?B?akdQdHJNY0lIaGdLUURSNktrSTBnUVB3Y0lpQ3RCNnI5NTBpTkNmOVFIK2RF?=
 =?utf-8?B?ZGFOVXhieHI4QXJ6c091ZmRyMjZTYUdpbytqL0M0WEkyU1gzZkE0dDFUSlV2?=
 =?utf-8?B?R0FSZzFMRTlzcnkrUGRKa2dRVEFUMHh4ekkyKzJ5cFVYUVhvMGg3ZEdjc3Rl?=
 =?utf-8?B?ZG9vZ1h5aUpsK3RJMityOTl0azUzajROZzExbVFsY0IzbTZCcGNSOXdXTzJn?=
 =?utf-8?B?Y2Nya3YrQlYrTGx5TFZQTW81S2RRb1ZCcVhWTndiNGwydHhCYTU3K3M4ZWtt?=
 =?utf-8?B?SDdMMmYraVFnbGV3ZWZCay9uUENRL3htSjRWSzZxV1NaU1A0eVNBSitjZ2NG?=
 =?utf-8?B?VktTSzZtNG4vNEphNEc3SjJhVkc3dFpnNHJxL3hTUlFqZXROWlhMT0NNM0Er?=
 =?utf-8?B?RXZXb1FqVjFvWGh6SFFvZkRaZEVDd0VPTWhFenpXVVJZV0xUWUVNQnF1cEN6?=
 =?utf-8?B?OHZsbFVnajJmMGZSNVdLb1ZsNHRKTUk5cTY2M0VZbmdLSENOM1Y3VGZsai9V?=
 =?utf-8?B?VEovYW9aWGtiSENnZytwdFI4NHhpUWgwekNwZmtyK0ZrczJqakxEMDltamgw?=
 =?utf-8?B?QWVpSE9kbnRRRkZWeFJQOG1oOWhCb3pWZ1JKK2FyMmJVbGhNREhpUnUvQVFK?=
 =?utf-8?B?ek5yLytZK1M4NkVhYVlZUTM3YlVJbHpxY3BtNmFwQzZENHBkTVZwMFlsQnM0?=
 =?utf-8?B?eHR4OVRDQTFwWkJrNUxUdlBJTDNJdm80VHVwM0JqbzJqTzhmaVkwN2kvV0Zv?=
 =?utf-8?B?b09TQ3U4RlZoN1k4RnpTakVOTmFOb00zZmZ2cHFLVHhPTVNpQ0o4S29ueEpD?=
 =?utf-8?B?dFphSnZCdXFsZ1ZzL2s3ckpNOUhTdmR3UHdUVVI1endoQktuSXpyU1JnOUVU?=
 =?utf-8?B?a0ZSWTBleGUzay9pT2NYNVg3UUp4U25icVN0aEluRWM3NkFyV0podUk5dkFv?=
 =?utf-8?B?eERNNUNkbFFSRjdIRmdwT0JRWnRpSmVwVWM5a3NaTzlaclRkYkdBQkhsSU5H?=
 =?utf-8?B?RGc2L0tmajJmd3JXQ0N3ME1DVzBoemhHbkMwdjdSMlZHTlRlUG0wakVFbGVi?=
 =?utf-8?B?RXkyclp0ZlJqODQzMGQxT0ZBU1dZSnlwVDQ1cTR3TGUzVXplV3I0N1hjMjhk?=
 =?utf-8?B?UTVJaEhLYnZ5WW11RVpOdHZxM0x3TEpXc01Ibkh1dmhKUzhUOG9QS2xWRlo5?=
 =?utf-8?Q?XVJD7K23Fl5RbYKP06rto/gA/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aefb23-59ff-43d5-8846-08de204aea38
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 11:18:46.1878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BdNfN89cLCkHpJvbfR6RYx3APFRAKZhzSaOV1NQQMEnxxm0AjA5BfiA4JdSrkSJWv80HKA1n8w4tMUuDejOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6990

SGkgS3J6eXN6dG9mOg0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAy
NeW5tDEx5pyIN+aXpSAxNToxOQ0KPiDmlLbku7bkuro6IEdhcnkgWWFuZyA8Z2FyeS55YW5nQGNp
eHRlY2guY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gcm9iaEBrZXJuZWwub3JnOyBr
cnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmcNCj4g5oqE6YCBOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBjaXgta2VybmVsLXVwc3RyZWFtDQo+
IDxjaXgta2VybmVsLXVwc3RyZWFtQGNpeHRlY2guY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0gg
Mi8zXSBSZXNldDogY2l4OiBhZGQgc3VwcG9ydCBmb3IgY2l4IHNreTEgcmVzZXRzDQo+IA0KPiBF
WFRFUk5BTCBFTUFJTA0KPiANCj4gT24gMDcvMTEvMjAyNSAwNDozOCwgR2FyeSBZYW5nIHdyb3Rl
Og0KPiA+IFRoZXJlIGFyZSB0d28gcmVzZXQgY29udHJvbGxlcnMgb24gQ2l4IFNreTEgU29jLg0K
PiA+IE9uZSBpcyBsb2NhdGVkIGluIFMwIGRvbWFpbiwgYW5kIHRoZSBvdGhlciBpcyBsb2NhdGVk
IGluIFM1IGRvbWFpbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdhcnkgWWFuZyA8Z2FyeS55
YW5nQGNpeHRlY2guY29tPg0KPiANCj4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNo
aW5nIHRoZSBzdWJzeXN0ZW0uIFlvdSBjYW4gZ2V0IHRoZW0gZm9yDQo+IGV4YW1wbGUgd2l0aCBg
Z2l0IGxvZyAtLW9uZWxpbmUgLS0gRElSRUNUT1JZX09SX0ZJTEVgIG9uIHRoZSBkaXJlY3Rvcnkg
eW91cg0KPiBwYXRjaCBpcyB0b3VjaGluZy4gRm9yIGJpbmRpbmdzLCB0aGUgcHJlZmVycmVkIHN1
YmplY3RzIGFyZSBleHBsYWluZWQgaGVyZToNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2Mv
aHRtbC9sYXRlc3QvZGV2aWNldHJlZS9iaW5kaW5ncy9zdWJtaXR0aW5nLXBhdGNoDQo+IGVzLmh0
bWwjaS1mb3ItcGF0Y2gtc3VibWl0dGVycw0KPiANCj4gSXQgaXMgbm90ICJSZXNldDoiLiBNYXJr
IGNhcGl0YWxzLg0KPiANCg0KT0ssIFdlIHdpbGwgdXNlICJyZXNldDoiIGluc3RlYWQgb2YgaXQN
Cg0KPiA+IC0tLQ0KPiANCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kcml2ZXIgc2t5MV9yZXNldF9kcml2ZXIgPSB7DQo+ID4gKyAgICAgLnByb2JlICA9IHNreTFf
cmVzZXRfcHJvYmUsDQo+ID4gKyAgICAgLmRyaXZlciA9IHsNCj4gPiArICAgICAgICAgICAgIC5u
YW1lICAgICAgICAgICA9IEtCVUlMRF9NT0ROQU1FLA0KPiA+ICsgICAgICAgICAgICAgLm9mX21h
dGNoX3RhYmxlID0gc2t5MV9yZXNldF9kdF9pZHMsDQo+ID4gKyAgICAgfSwNCj4gPiArfTsNCj4g
PiArc3RhdGljIGludCBfX2luaXQgcmVzZXRfc2t5MV9pbml0KHZvaWQpIHsNCj4gPiArICAgICBy
ZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZza3kxX3Jlc2V0X2RyaXZlcik7DQo+ID4g
K30NCj4gPiArc3Vic3lzX2luaXRjYWxsKHJlc2V0X3NreTFfaW5pdCk7DQo+IA0KPiBUaGlzIHNo
b3VsZCBiZSByYXRoZXIganVzdCBtb2R1bGVfcGxhdGZvcm1fZHJpdmVyLiBEb2VzIG5vdCBsb29r
IGxpa2UgcGFydCBvZg0KPiBzdWJzeXN0ZW0sIGJ1dCBsb29rcyBsaWtlIHJlZ3VsYXIgZHJpdmVy
Lg0KPiANCg0KU29tZSBtb2R1bGVzIGRlcGVuZCByZXNldCBtb2R1bGUuIFdoZW4gYm9vdCBzeXN0
ZW0sIHRoZXNlIG1vZHVsZXMgY2FuJ3QgcHJvYmUgYmVmb3JlIHJlZ2lzdGVyIHJlc2V0Lg0KVG8g
bWFrZSB0aGVzZSBtb2R1bGVzIHByb2JlIGVhcmxpZXIsIHdlIHVzZSBzdWJzeXNfaW5pdGNhbGwo
KSB0byBpbnN0ZWFkIG9mIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIoKS4gRG8geW91DQpoYXZlIGJl
dHRlciBzdWdnZXN0aW9ucz8NCg0KQmVzdCB3aXNoZXMNCkdhcnkNCg0KPiA+ICsNCj4gPiArc3Rh
dGljIHZvaWQgX19leGl0IHJlc2V0X3NreTFfZXhpdCh2b2lkKSB7DQo+ID4gKyAgICAgcGxhdGZv
cm1fZHJpdmVyX3VucmVnaXN0ZXIoJnNreTFfcmVzZXRfZHJpdmVyKTsNCj4gPiArfQ0KPiA+ICtt
b2R1bGVfZXhpdChyZXNldF9za3kxX2V4aXQpOw0KPiANCj4gDQo+IA0KPiA+ICsNCj4gPiArTU9E
VUxFX0FVVEhPUigiSmVycnkgWmh1IDxqZXJyeS56aHVAY2l4dGVjaC5jb20+Iik7DQo+ID4gK01P
RFVMRV9ERVNDUklQVElPTigiQ2l4IFNreTEgcmVzZXQgZHJpdmVyIik7IE1PRFVMRV9MSUNFTlNF
KCJHUEwiKTsNCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

