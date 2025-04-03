Return-Path: <linux-kernel+bounces-586069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B4A79AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 06:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9443B1E90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 04:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913021624E4;
	Thu,  3 Apr 2025 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="e6qV1GjV"
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874182E3387;
	Thu,  3 Apr 2025 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743654419; cv=fail; b=O7R7kBVCkd/8hKLcTmJPHeF4KaYX+fSevKPqOewYjMY2/o6rih7V0MzvnNJkS18gcWxDh2q8L4g2cESsLtVzjhF0B1/H13R43KD0reX+KUDMCRhdI7VYUPYyrVDvtxH3DQ6rRmbqUtOn0k+QnnYoku1khKDn9fhHArpvO6WgzI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743654419; c=relaxed/simple;
	bh=xhaBzqTyBKgS1TpUT7HWDFLsudYkQ/5hxdnR4phcXi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVo/aVcoccpWMjoo8049IVGkqJPK5UDHfkRlwYoDkDyQqcYmo7zVrw5Dsno5in0Mcw+fYF03lY29YBzWBjJC8Ss25dnusBo8eqvcRk5xjuXwxImoCa6nOPxNkodPrHLfMfTm3TeUC3iTeIBl/AQPN30aQU7DsoL4Ndc4Rqp+gSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=e6qV1GjV; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1743654417; x=1775190417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xhaBzqTyBKgS1TpUT7HWDFLsudYkQ/5hxdnR4phcXi0=;
  b=e6qV1GjVrObIyn86zV9dx0GlhemLJqeNSJ0FEG1GbET42HtSYwhUjXdD
   Xd2Dd49LQ6z7bYsP5mCZ50dZlvgKR6ln7sbw9/2vRXapJo2wD/i0InqQs
   l4uaZjtdpmQF+xqNrXPuUojJ090Vb6OAlURSo8TJBacyih+HN44mhncM4
   p+4lWiIWktkT1POHEe9xE038GmqOz8KibWQKagK38p9qhgp/0U5/ZRjQ4
   VHcz6sJnR4dS9o82FX8+6YcV1e/y1mmOjfXksxQg53g54UIPMWQpl0A1C
   el7e/CkqFEBUy+AQQ7kJaUrZKxRIDGvDkTK2idHqopHzoDKSm+ELIq2oC
   Q==;
X-CSE-ConnectionGUID: 0aFwr5E6QWSE2vChQ+5ZIw==
X-CSE-MsgGUID: +8HJgZQ4QsSBo2FDPjk67Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="151790584"
X-IronPort-AV: E=Sophos;i="6.15,184,1739804400"; 
   d="scan'208";a="151790584"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 13:25:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGqq5YujPqCb8mQxKln/rTB7k+8k+a9TVs87IUUMK5FKbhMjZLvr8lh9wAJySc80SDh5nhrIE7w7ylEXVyQCMdyqJ8yaAyQT6x1LqwYHFQEexsN8h2Gia2l9FbHg6jRDsnMQiQ9f48vEGMDxKMmSecSDkuR4A4H7+FFYCn5Lof/gHlByf/HKKw5X6utMOGTuIffGtg5TaOsaHaPBQzVmjm1IUO/D5m1U7hJs+tpV4rH0rGQMqOcAeEEqZPzkpOZaKrhTi/z+K+VHJs6gPwnfE37SkNyGMyRVvMi4e7tfJZfsp+/fZqNLZoqQtux/HmjZHzvKt8fj9TiGV2duxSe9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhaBzqTyBKgS1TpUT7HWDFLsudYkQ/5hxdnR4phcXi0=;
 b=esZAXepgxdVxBdDG82+TpUymD5OexhJDd1VUAkuylsXjY+p6ydFUq8SCjdNwCA8Vd7a3OeQqYVVpzeyQH9DrPyo4hz1eF8laQP/8KiLasml0pzMOtlX+2/ywJv0QOQLiIj5pOnxiyENOH4SzOMpJV7zbrldhSsS6UHp+/nDuTrIZYE86GujRe1v/1BPDpSC8zXeCiosZfkvcjjv2fu707ZKUbF0Af3bUvjxgzEMordhWXn2mGPhIyk4FFxM2y9LxweaLeQbx+WMo2l5dk2ihti4Ig0AGPGeasQGI9jNb5ATYtl3fJZtSiLmEnJF3ghoWjyvACwpiPGDt4affbZpnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com (2603:1096:604:2e2::9)
 by OS3PR01MB9513.jpnprd01.prod.outlook.com (2603:1096:604:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Thu, 3 Apr
 2025 04:25:35 +0000
Received: from OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::6569:be59:abd6:eb0]) by OS9PR01MB12421.jpnprd01.prod.outlook.com
 ([fe80::6569:be59:abd6:eb0%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 04:25:35 +0000
From: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Gregory Price
	<gourry@gourry.net>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: RE: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Topic: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Thread-Index: AQHbpCams2gd4qGNL0y/YUataQalUrORIo2AgAARj1A=
Date: Thu, 3 Apr 2025 04:25:34 +0000
Message-ID:
 <OS9PR01MB124214F1E05F7D27C50591AF590AE2@OS9PR01MB12421.jpnprd01.prod.outlook.com>
References: <20250402232552.999634-1-gourry@gourry.net>
 <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
In-Reply-To: <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9NmYzNDQ4ZGUtNmVmMC00NTg4LTk5NDgtZjdmNzVmMTk0?=
 =?utf-8?B?NTY3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDQtMDNUMDI6MTU6MDJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12421:EE_|OS3PR01MB9513:EE_
x-ms-office365-filtering-correlation-id: 1d588dce-5f3a-4cdc-9182-08dd7267941e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXV1SnN5bTRwWmtBa01welIyd1BpNTVlQzV2bllaSFhzRFhMa2xBbkM2QW02?=
 =?utf-8?B?K1BYV3R6Q01sb0JKK0w4YmpFMUNMTXZiUTFGWDI4OXhvRTVQVjJLdjNoWlp5?=
 =?utf-8?B?SzlBUk9PSXFmOXJrT1plemVVTjNzeC8vVlFIUVJVaXVCUWNMQVlzMVYxU1Av?=
 =?utf-8?B?WEJlWGszb0hFWkpwcnVja1JtNE1MdEtuS1k5ZHZib2pldVpGSWNKTC83NHhj?=
 =?utf-8?B?TlhVSSsyL05peGxxK1U1akg4Ni9pQTMveldkTlJUTjVxN0YycldWR3FwNWpS?=
 =?utf-8?B?MDdXMnFadWU0TmhSYTZKTnNRVjBVTG12V3lnamw0UkRrS1YyZEwrT2x2V04y?=
 =?utf-8?B?dmJYZlgreWhlNUcyMi9HY0JKV05iMzF4SmNwSVFzV2VrV21KL2FJV05Hd3Rz?=
 =?utf-8?B?ajJtQ1o1WG9OcWZjWDUzdkRxR3VPQnladSsxeTNFNERIb0psamI1ekswUEU0?=
 =?utf-8?B?TFA2VzhIQ2tWVkdXRHRpTU9GS2d5SWNEVzE5VUNXMWJ6SmRtd0NIZDdiT1Bi?=
 =?utf-8?B?UllERGNmVVE5YmVxSDVqYUZEMmZUTStlY0l6MkFxTzRRbVg3R29aRTdaUW5w?=
 =?utf-8?B?YmlXTk42ZHZLUlJER1R3OXMvREhHSmtoYzN2NHowWDdJR2VoTnM3a0toY3g3?=
 =?utf-8?B?dEdoY3Y3QklkOEljY0lQaXQ5M2JVOHJ4SEY3R3lHRW5PRkFFTndUZGFkNU9T?=
 =?utf-8?B?MzVXcVRzS2w5WTQ3MXZySEg4U2lrSVZUdHJKRDAyRmZSWnpUUm5uWW50alZH?=
 =?utf-8?B?emR2M1lrL01YS1FMbFJ5NjNySFdBaEh1WUFMV0JUUXc2ZzBCRUV1UytKeXZp?=
 =?utf-8?B?c1BRSktxR3lRT0R4Y3NWNjlGVnJjbFMzNTFiZ1RlSnE5ZjB3TUZtUHl1V0ti?=
 =?utf-8?B?UXA0M01rU056NWVSc04vRTRMS21JYXhTMU83RGVlZ0poNjdoTG4vOVZFUVdT?=
 =?utf-8?B?Y3ZwK3NjMko1cXBlL1ZsZEpUODlKOU5jbkJJbWRIaklkSExYcGpYc0hSeWFt?=
 =?utf-8?B?bEpoVFpHb2pzaVBkd2dNYk0xQUtLUFlFWWhZcUhLTlN4RHE4S1hIZlRSWGZq?=
 =?utf-8?B?Y00rWHZIZ1RkKzhXSmJONGE1a1IzUlJxWk0wRlNDaFJsalBhTjFYVDE3UCtB?=
 =?utf-8?B?RmZLZ2QweEgrMFBRQVpKN1p2cHNORFlFMytFT3BwRU4vMU5mLzI1ck1FQ0lU?=
 =?utf-8?B?TE9ZeTlJbTVqcmVTZm51N1p4MUVyTWVDZjlUaU80YjVmNW5NS3FTMXhjd2p6?=
 =?utf-8?B?Q3cwTUhsQ2pYanNKVFgzL3NnTUJOWDB0NUtQQi95RVdMUWZmdHRVSXA2T24w?=
 =?utf-8?B?YkZYcFY5Z0ZCRHF0Mjh1ei92TE1TWmZDVFlnZWFlTFAxek9ud3ovK1VjTFlm?=
 =?utf-8?B?UTBrSm5SQnhlRmEyYnpid25hbXI2NGlTbW03YUg4L2RHQUtRTExyWFI4U0o3?=
 =?utf-8?B?WUFFK1VZMWVnN2haemdUMmFvUGhNK0NrRlFQZTIwR1hvYWpheDQzcDBLeGRo?=
 =?utf-8?B?L25rNUxraTZYK0YzUUFZZm5DcmEzZlU0WmJlZFNWVi9VVzErcjdmS3JSYkNY?=
 =?utf-8?B?b09KUTQ3cUtzUTBVOCtHei9HUWh6UE8xTEYxa1VRb09WS1BnTXhrRERBNWFM?=
 =?utf-8?B?UjZkNW1BQzJVODRFUUpjV01pUU5iczV2Mk1kYnMxZHlxa1IrU1g1OGd6WFA2?=
 =?utf-8?B?bGVBNnhCRlhQTUd0RzB1MzZoZTVleVJIMWJPVU5SaWUrMjhpQmFBUCtyNkY2?=
 =?utf-8?B?ZmV5RUZuVkxLQThGSnhzWW9QWFNydDNMWVRLUTNLZ1hrMGNTdzNlMkZqRjFT?=
 =?utf-8?B?cnQvbmpxalE4RUQ0Zzg2NXU4MVFXdS95YUdkSmFMVXZTTjljZ3BzQVhvOU9N?=
 =?utf-8?B?YVBSVmNpQWJkejVSa1cwRk9UaGtldHRWTXhuamU5OFFSQ1EvTCs1K2d3VDEr?=
 =?utf-8?Q?xpk7w2ZyIDU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12421.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE5pMWU5dVpUUTBpclFxeEQzbGc5cXRGT2YzTEZqamlGWjlmTmRnd0YvUE8r?=
 =?utf-8?B?SmtwZENBOGJDUjlLL09qenNJSzhVeXpLUkw0c0UyZEtPOWFtT3V1WndiZ3h1?=
 =?utf-8?B?QlNRdEhVZjFPemhWM2lucDcvTlRuaTlDRUpXUjRYVXJtOVlHbjNRRDRCWDFF?=
 =?utf-8?B?Y2xHVDVJeW0vUkNwYzVod0ZrVVNzS3p6MWV0UFlLUHhLTlhob0ZDZnpoSFRs?=
 =?utf-8?B?d1BiZGFYeEVLREdiWWFSMG5rVTE2WXRZNkZqeXRNYUxYUXBjbWY1Um10QUlE?=
 =?utf-8?B?cGszM0pXWTM2K0Y2K29vOVA2TUNMOEZQT0o1Um0vaWxOWHFnQjAvU2prMFd0?=
 =?utf-8?B?YWJMVkdoeDA3bjB2RHVmbnpXOHpIMFZ6Z0E5a0tLSGRwUmhIaDBGSjBXNU9p?=
 =?utf-8?B?NEZTZ21MOEhnbTQ0K0hzNUJrc1dQUERONmd3RS9xSE9KVzZteXRJdkdaTU5y?=
 =?utf-8?B?QmxMdEh0cU5DLzZ1Q09rQm56RVdaQnRpRGJrVGJpbzR6Y3ppdTlIWFJkYmFp?=
 =?utf-8?B?aS9Gc2M1L2FQM0VDUUZaeHg5S0kvQ05qNlVtd21NL2VLamRSa0pEQk9oL3Rk?=
 =?utf-8?B?QlFLcU0xaXl2eU9jM3pUMjFvTDJLKzNGSW1ibmVjNFI4WmlyVkJaZ3RQeUVV?=
 =?utf-8?B?a3Zua0tlKzFJTUY4ZXhDc25LVWRmV2x5RDF3MkJqQ3J0bkVVZnBKYWJwUmI4?=
 =?utf-8?B?aXdCY0Q0WSsyRCtJV3E4cnZRamxQemZrakhCa0JWREdWanhMVHNzdFFTL3NL?=
 =?utf-8?B?SSt1YjN3SGhMTHBKMzFJb2FrM0dPMjUwNHJUcFVtOE03QzRQZ3RvcWtJWjl1?=
 =?utf-8?B?T2h5alJOcXpGWktOUkhKOVB6azRGMDZOekZQaTdDQUVDRThFSEgvMy9MZEp4?=
 =?utf-8?B?eG81YzNpUnpLbWJlS3E4Yit3aVFuTEhTWkxYWU55dWtxY3pWTHNvN1VpTUU2?=
 =?utf-8?B?KzByRXFmalViSHdQNzFhT0ZzeStoODhYaEVBQXpOdkt2aFBmVjFBb29XZkU3?=
 =?utf-8?B?VFRCaFRVbFBVVGVFQzlJTnNNRFY4Y3pwV3lMbDBkRnVuVlRmeWJKdHJUZFFJ?=
 =?utf-8?B?ZVFXbENXc1J2M1hYcDhaaDllWEV1UGVmTU9MZmRaUW8rd0VKMlp0Wjh2VlUz?=
 =?utf-8?B?NWJTZFNEUnQzaEFlcHllMVVBclRKZzR2Tmt2SGd6eEVpTzBWVkphWldZYmt6?=
 =?utf-8?B?cDdRTXpQSEdHSXkvNUZ3aVg5cFJnTy9XK1lTNFI1WExGT2RkR2lOQUpiZUFn?=
 =?utf-8?B?YVpmbVJVZ0ZCM3pyaUJUMHQ4S3diV21KOHdLNmNrbGY3NFVBc0Z6ZWRtTXRO?=
 =?utf-8?B?bjFEVStVeXh1Lzl0UEJic3p6MjYycE1VTHU5YUIvTlRFSDRQbmZPYXl4SFNZ?=
 =?utf-8?B?TGlPYXYrSldJSzJMYVNQTEdGL0k1OGk2aFFMK1I3dVdFTmFjYkFQZk1KK3c3?=
 =?utf-8?B?ZXBzUVhKemgvSExuQzExSUNRZEdOTEhWcSt6ZnU0KzdPcWlNT282SXZVUE9Z?=
 =?utf-8?B?QXNPTkJkMmE4b1R2ZDY4VnNXcUVXYWxnNUE2bzZ0ZFhxcGo4WDUyWGkvUWtI?=
 =?utf-8?B?Q1hJZHFVOWxySWNvQzgvZGRwOWdxaEdEcUtQbkNoVzA1MHBiY1VEQ204eXY1?=
 =?utf-8?B?T0wyZXg1WmxOdlE4TThCNDVlMFczU0lXVVU4WGJDWU5qTHlJTGZyZDk1ei8w?=
 =?utf-8?B?WTNiY1MrZTJtZVoxb0ZYRGJxbmhhbW1DbTFVOTdtelpoRE1MMlNrb0JIdGFF?=
 =?utf-8?B?SDRsUGpZU3RWY1k1a05DK0QySkpXZmlCLzQ2TExsUDREL1NQd0ZVLzgzUDNw?=
 =?utf-8?B?VXU1K1hyREo4aWVGa0V6aFhyL0xzRTdkUWU4L1h5TVhwamVObHhpUjJ3NXAx?=
 =?utf-8?B?emwzZUhkb21tV3B1cHhEUHk5ekJxWngreWtCbzFHZkhFdStNek1YM1p0YWxB?=
 =?utf-8?B?eVlXSHEwZ2xtRGZDbjM1b2NWZzZVMCtIeDllTm9lSkZ4M29XdHlOMkNVbmhX?=
 =?utf-8?B?ZU9BRHpvZUY1YzBTZ1VLdzJWWmlRT1ZDWU5xM1dhTHQ3Z1A3YzNpNUtpbU5t?=
 =?utf-8?B?bkJxUWpUek9vUit1NTUyZUltbHgyT2NZSGJsa1BsRElPMW1hd0RxRTBjYXJu?=
 =?utf-8?Q?m35iGxDEw7tOxHoYoUroYsX4N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OSnDdr8g5INImLDRaPhiwNwjtLZGtzLilU3g1x++8BhKdwkp6qpZs36B9M6ut/nPUcwHCJJljuZRKQVvwXpHhs88vOw6DBYPENx1bpFFB1uDvlTGweZ9A0Zaqct4CJmjIJL45Y0dKobsOfZGX3ssJVfmQ63I2adeY9QYsqtx1yi2MskNZd6IlSrupg0SP1lrW5qZiO+JR3Fvzs30w1XqblZBi4Tct97MFWWgXBHYkag912UhN++u2IigoI+yOwqHjFWvzZKhR3TzSq+iqVgmZxFwHEjWJkgRdz/xauOdlGXWFA4nN2zJXsAICM01/n1YYQbV3Xi5GwM+rNMHY6uzfQsI/ZHYsHATVK1tDWY9U0/Lw9/tEyPy7swxOPrhJF9tG6fiTWQK9hSJ5ITY5roXQN8fAPVaXM1FAcpI2/LYihOirfen30lFmVzCGWHJSNknzbSKKUy6rVexNmioNoyvCCL+9k/uWXdqXkDSX/ietmSOw4lQbBZ5In9mi460m0QvjNjSqLd8rEG7DKCRO3PtAv2W8LfTVs7xcP1tLePxY95M/JfLlqyVX96uIfV5JMkch+TszSMwpkEUn7H3eXMmDJnTFkB+aXkJ7O2V+r7YO5GHwdiEHr+X081oHonpg1+c
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12421.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d588dce-5f3a-4cdc-9182-08dd7267941e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 04:25:34.8182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0O1/KMBYJ1fkYXzztsiUFjo25Tk3FYqqZFe9lB4AUWy+TTSouVpCtj7UV8DxgGw/SthIDG1kYYUTHziUsq1tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9513

SGVsbG8sIEdyZWdvcnktc2FuLCBhbmQgZXZlcnlvbmUNCg0KPiBIaSBHcmVnb3J5IGFuZCBDWEwg
Y29tbXVuaXR5DQo+IENjIEdvdG8tc2FuDQo+IA0KPiBXb3csIG91ciBwbGF0Zm9ybSBoYXMgZW5j
b3VudGVyZWQgYSBzaW1pbGFyIGlzc3VlLCANCg0KWWVzLCBJIGFjdHVhbGx5IGVuY291bnRlcmVk
IHRoaXMgaXNzdWUuIFRoZSBlbmRwb2ludCBkZWNvZGVycyBzaG93IHRoZSBncmFudWxhcml0eSB2
YWx1ZSBhcyAxMDI0IGJ5dGVzLA0KYnV0IG90aGVyIGRlY29kZXJzIHNob3cgMjU2IGJ5dGVzLCB3
aGljaCBpcyB0aGUgZGVmYXVsdCB2YWx1ZSwgZXZlbiB3aGVuIHRoZSBpbnRlcmxlYXZlIHNldHRp
bmcgaXMgb25lLg0KDQpBcyBhIHJlc3VsdCwgdGhlIGVycm9yIG1lc3NhZ2UgdGhhdCB0aGlzIHBh
dGNoIGF2b2lkcyBhcHBlYXJlZCwgYW5kIGluaXRpYWxpemF0aW9uIGZhaWxlZCwgYXMgZGVzY3Jp
YmVkIGluIHRoZSBmb2xsb3dpbmcgZW1haWw6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1jeGwvT1NZUFIwMU1CNTM1MjVGRDY0QTlBRkJBRUVDMUUxOUEzOTAxMTJAT1NZUFIwMU1CNTM1
Mi5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tL1QvI204MTFiZGQ5M2JjYTM4ODdiNGMxNGEyYTIw
YjhmMjFhNzdkY2YyZWFlDQoNClNvLCBHcmVnb3J5J3MgcGF0Y2ggaXMgd2VsY29tZSBmb3IgbWUu
DQoNCj4gYW5kIEkgYW0gaW50ZW5kaW5nIHRvIGNvbnN1bHQgdGhlIGNvbW11bml0eSByZWdhcmRp
bmcgdGhpcyBtYXR0ZXIuDQo+IEkgZHJhZnRlZCBzaW1pbGFyIHBhdGNoIGxvY2FsbHksIGJ1dCBJ
IHdvbmRlciBpZiB3ZSBzaG91bGQgImlnbm9yZSIgdGhlIElHIG9yDQo+ICJwcm9ncmFtIiB0aGUg
SUcgdG8gdGhlIGRlY29kZXIuDQoNCkknbGwgdHJ5IHRvIHN1bW1hcml6ZSBMaS1zYW4ncyBxdWVz
dGlvbi4NCkRvZXMgYW55b25lIGtub3cgd2hhdCB3aWxsIGhhcHBlbiBpZiB0aGUgQ1hMIGRyaXZl
ciBkb2VzIG5vdCBwcm9ncmFtIHRoZSBJRyB2YWx1ZSB0byB0aGUgZGVjb2Rlcj8NCldpbGwgaXQg
d29yayBjb3JyZWN0bHkgd2l0aG91dCBhbnkgcHJvYmxlbXM/DQoNCk15IGluaXRpYWwgYXBwcm9h
Y2ggdG8gYXZvaWQgdGhpcyBwcm9ibGVtIHdhcyB0byAicHJvZ3JhbSIgdGhlIGRlY29kZXIsIGFz
IHNob3duIGJlbG93Lg0KVGhpcyBwYXRjaCBpcyBhIHZlcnkgZWFybHkgdHJpYWwgdmVyc2lvbiB0
byBhdm9pZCB0aGUgZXJyb3Igd2UgZW5jb3VudGVyZWQuDQpIb3dldmVyLCBMaS1zYW4ncyBjb25j
ZXJuIGlzIHRoYXQgdGhpcyBwYXRjaCB3cml0ZXMgdGhlIElHIHZhbHVlIHRvIHRoZSBkZWNvZGVy
cy4NCklzIHRoaXMgInByb2dyYW1taW5nLCIgYXMgc2hvd24gYmVsb3csIHVubmVjZXNzYXJ5Pw0K
LS0tDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9oZG0uYyBiL2RyaXZlcnMvY3hsL2Nv
cmUvaGRtLmMNCmluZGV4IDBmNjY2MTI5NzE1Mi4uNDZiOTMzY2M4YjlmIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9jeGwvY29yZS9oZG0uYw0KKysrIGIvZHJpdmVycy9jeGwvY29yZS9oZG0uYw0KQEAg
LTkzNyw2ICs5MzcsMTQgQEAgc3RhdGljIGludCBpbml0X2hkbV9kZWNvZGVyKHN0cnVjdCBjeGxf
cG9ydCAqcG9ydCwgc3RydWN0IGN4bF9kZWNvZGVyICpjeGxkLA0KICAgICAgICB9DQogICAgKHNu
aXApIA0KKw0KKyAgICAgICBpZiAoY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSAhPSAyNTYp
IHsgIA0KKyAgICAgICAgICAgICAgIHByX2luZm8oInktZ290bzogZm9yY2Ugc2V0IGlnPTI1Nlxu
Iik7DQorICAgICAgICAgICAgICAgY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSA9IDI1NjsN
CisgICAgICAgICAgICAgICB1MzJwX3JlcGxhY2VfYml0cygmY3RybCwgMCwgQ1hMX0hETV9ERUNP
REVSMF9DVFJMX0lHX01BU0spOyAgPC0tLS0tLS0gbWFrZSB0aGUgdmFsdWUgZnJvbSBpZw0KKyAg
ICAgICAgICAgICAgIHdyaXRlbChjdHJsLCBoZG0gKyBDWExfSERNX0RFQ09ERVIwX0NUUkxfT0ZG
U0VUKHdoaWNoKSk7IDwtLS0gICJwcm9ncmFtIiB0aGUgZGVjb2RlciBvZiBpZyB2YWx1ZQ0KKyAg
ICAgICB9DQorDQotLS0tDQoNClRoYW5rcywNCi0tLS0NCllhc3Vub3JpIEdvdG8NCg0KDQo+IA0K
PiBMZXQgbWUgcG9zdCB0aGUgbWFpbChxdWVzdGlvbikgZnJvbSBteSBkcmFmdHMgaW4geW91ciB0
aHJlYWQoSSBob3BlIHlvdSBJIGhvcGUNCj4geW91IHdvbid0IG1pbmQpLg0KPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBbUXVlc3Rpb25dIGdyYW51bGFyaXR5IGlz
IGEgZG9uJ3QgY2FyZSBpZiBub3QgaW50ZXJsZWF2aW5nPw0KPiBJIHNhdyB0aGlzIHNlbnRlbmNl
ICIgZ3JhbnVsYXJpdHkgaXMgYSBkb24ndCBjYXJlIGlmIG5vdCBpbnRlcmxlYXZpbmciIGluIHRo
aXMgcGF0Y2gNCj4gIltuZGN0bCBQQVRDSCAyLzZdIGN4bC9saXN0OiBBZGQgaW50ZXJsZWF2ZSBw
YXJhbWV0ZXJzIHRvIGRlY29kZXIgbGlzdGluZ3MiIFsxXQ0KPiANCj4gVGhpcyByZW1pbmRzIG1l
IHRoYXQgb3VyIHBsYXRmb3JtIHByb2dyYW1lZCBhbiB1bm1hdGNoZWQNCj4gaW50ZXJsZWF2ZV9n
cmFudWxhcml0eSBpbiBIRE0gZGVjb2RlcnMgYmV0d2VlbiBlbmRwb2ludCBhbmQgdGhlIGhvc3Qt
YnJpZGdlLA0KPiBzZWUgYmVsb3c6DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQ1hMICBSb290DQo+ICAgICAgICAgICAgICBDRk1XMCAgICAgICAgICAgLyAgICAgICAgICAg
XCAgICAgIENGTVcxDQo+ICAgICAgICAgICAgIGRlY29kZXIwLjAgICAgICAgICAgICAgICAgICAg
ICAgICBkZWNvZGVyMC4xDQo+ICAgICAgICAxMjggR2lCICAgICAgIElXOjEgIElHOjI1NiAgICAg
ICAgICAgSVc6MSAgSUc6MjU2ICAgICAgMTI4IEdpQg0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcICAgICAgICAgICAvDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
b3N0IEJyaWRnZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvICAgICAgICAgICBc
DQo+ICAgICAgICAgICAgICAgICAgICAgIGRlY29kZXI1LjAgICAgICAgICAgIGRlY29kZXI1LjEN
Cj4gICAgICAgICAgICAgICAgICAgSVc6MSAgSUc6MjU2ICAgICAgICAgICAgSVc6MSAgSUc6MjU2
DQo+IAkgICAgICAvICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAg
ICAgIEVuZHBvaW50OSAgICAgICAgICAgICAgICAgICAgICAgICAgIEVuZHBvaW50MTANCj4gICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiAgICAg
ICAgICAgZGVjb2RlcjkuMCAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlY29kZXIxMC4wDQo+
ICAgICAgICAgIElXOjEgSUc6MTAyNCAgICAgICAgICAgICAgICAgICAgICAgICAgSVc6MSBJRzox
MDI0DQo+IA0KPiBXaXRoIHRoaXMgc2V0dXAsIHRoZSBMaW51eCBrZXJuZWwgYXR0ZW1wdHMgdG8g
Y3JlYXRlIHJlZ2lvbnMgZm9yIEVuZHBvaW50OSBhbmQNCj4gRW5kcG9pbnQxMCBidXQgZmFpbHMg
YmVjYXVzZSB0aGUgZW5kcG9pbnQgZGVjb2RlcnPigJkgaW50ZXJsZWF2ZSBncmFudWxhcml0eQ0K
PiAoSUc9MTAyNCkgZG9lcyBub3QgbWF0Y2ggdGhlaXIgcGFyZW50IGRlY29kZXJz4oCZIElHICgy
NTYpLiBJZGVhbGx5LCB0aGUNCj4gZW5kcG9pbnQgZGVjb2RlcnMgYXJlIGV4cGVjdGVkIHRvIGJl
IGNvbmZpZ3VyZWQgZm9yIElHPTI1Ni4NCj4gDQo+IEN1cnJlbnRseSwgd2UgbGVhcm5lZCB0aGF0
IHdlIGhhdmUgb25seSBzcGVjaWFsIGhhbmRsaW5nIGZvciB0aGUgcm9vdCBkZWNvZGVycw0KPiBb
Ml1bM10uDQo+IA0KPiBNeSBxdWVzdGlvbiBhcmU6DQo+IFExOiB3aGV0aGVyICJncmFudWxhcml0
eSBpcyBhIGRvbid0IGNhcmUgaWYgbm90IGludGVybGVhdmluZyIgaXMgYXBwbGllZCB0byBhbGwg
SERNDQo+IGRlY29kZXJzKGluY2x1ZGluZyByb290IGRlY29kZXIgYW5kIEhETSBkZWNvZGVyKQ0K
PiANCj4gSW4gY3VycmVudCBjeGwgY2xpICwgaXQgd2lsbCBub3Qgc2hvdyBhbnkgaW50ZXJsZWF2
ZV9ncmFudWxhcml0eSBhdCBhbGwgd2hlbg0KPiB3YXlzPT0xKG5vLWludGVybGVhdmluZykgJCBj
eGwgbGlzdCAtUERFIHwgZ3JlcCBncmFudWxhcml0eSAgIyBzaG93IG5vdGhpbmcNCj4gd2hlbiB3
YXlzPT0xDQo+IA0KPiBQZXIgdGhlIENYTCBTcGVjIHIzLjENCj4gSUc6ICJUaGUgbnVtYmVyIG9m
IGNvbnNlY3V0aXZlIGJ5dGVzIHRoYXQgYXJlIGFzc2lnbmVkIHRvIGVhY2ggdGFyZ2V0IGluIHRo
ZQ0KPiBUYXJnZXQgTGlzdC4iDQo+IFEyOiBEb2VzIHRoaXMgaW1wbHkgYSBjb25maWd1cmF0aW9u
IHdoZXJlIHRoZSBudW1iZXIgb2Ygd2F5cz4xPw0KPiANCj4gUTM6IERvZXMgdGhlIElHIGFsc28g
cmVwcmVzZW50IHRoZSBkZXZpY2UncyBjYXBhYmlsaXRpZXM/IFdoZW4gcHJvZ3JhbW1pbmcsDQo+
IHNob3VsZCBvbmUgYWxzbyBjb25zaWRlciB3aGV0aGVyIHRoZSBkZXZpY2Ugc3VwcG9ydHMgaXQ/
DQo+IA0KPiANCj4gSWYgImdyYW51bGFyaXR5IGlzIGEgZG9uJ3QgY2FyZSBpZiBub3QgaW50ZXJs
ZWF2aW5nIiBpcyB0cnVlLCBob3cgYWJvdXQgYmVsb3cNCj4gY2hhbmdlcw0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMgYi9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lv
bi5jIGluZGV4DQo+IDc1Y2Q1ZGJiNDFlNC4uNjQ3ZmUyY2UxOGNhIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9u
LmMNCj4gQEAgLTE0MzUsNiArMTQzNSwxMSBAQCBzdGF0aWMgaW50IGN4bF9wb3J0X3NldHVwX3Rh
cmdldHMoc3RydWN0IGN4bF9wb3J0DQo+ICpwb3J0LA0KPiArICAgICAgICAgICAgICAgaWYgKGN4
bGQtPmludGVybGVhdmVfd2F5cyA9PSAxICYmDQo+IGN4bGQtPmludGVybGVhdmVfZ3JhbnVsYXJp
dHkgIT0gaWcpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY3hsZC0+aW50ZXJsZWF2ZV9n
cmFudWxhcml0eSA9IGlnOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAvKiBwcm9ncmFtIEhE
TSBkZWNvZGVyICovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIC4uLg0KPiArICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgIGlmIChjeGxkLT5pbnRlcmxlYXZlX3dheXMgIT0g
aXcgfHwNCj4gICAgICAgICAgICAgICAgICAgICAgY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0
eSAhPSBpZyB8fA0KPiAgICAgICAgICAgICAgICAgICAgICBjeGxkLT5ocGFfcmFuZ2Uuc3RhcnQg
IT0gcC0+cmVzLT5zdGFydCB8fA0KPiANCj4gDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzE2NTk3MzE4ODMwMC4xNTI4NTMyLjIyMjk4ODY4NTU1Mjk4Mjg3Mi5zdGdp
dEANCj4gZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbS8NCj4gWzJdDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8xNjU4NTM3NzY5MTcuMjQzMDU5Ni4xNjgyMzI2NDI2MjAxMDg0NDQ1OC5z
dGdpDQo+IHRAZHdpbGxpYTIteGZoLmpmLmludGVsLmNvbS8NCj4gWzNdDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8xNjk4MjQ4OTM0NzMuMTQwMzkzOC4xNjExMDkyNDI2Mjk4OTc3NDU4
Mi5zdGdpDQo+IHRAYmd0LTE0MDUxMC1ibTAzLmVuZy5zdGVsbHVzLmluLw0KPiANCj4gVGhhbmtz
DQo+IFpoaWppYW4NCj4gDQo+IE9uIDAzLzA0LzIwMjUgMDc6MjUsIEdyZWdvcnkgUHJpY2Ugd3Jv
dGU6DQo+ID4gV2hlbiB2YWxpZGF0aW5nIGRlY29kZXIgSVcvSUcgd2hlbiBzZXR0aW5nIHVwIHJl
Z2lvbnMsIHRoZSBncmFudWxhcml0eQ0KPiA+IGlzIGlycmVsZXZhbnQgd2hlbiBpdz0xIC0gYWxs
IGFjY2Vzc2VzIHdpbGwgYWx3YXlzIHJvdXRlIHRvIHRoZSBvbmx5DQo+ID4gdGFyZ2V0IGFueXdh
eSAtIHNvIGFsbCBpZyB2YWx1ZXMgYXJlICJjb3JyZWN0Ii4gTG9vc2VuIHRoZSByZXF1aXJlbWVu
dA0KPiA+IHRoYXQgYGlnID0gKHBhcmVudF9pdyAqIHBhcmVudF9pZylgIHdoZW4gaXc9MS4NCj4g
Pg0KPiA+IE9uIHNvbWUgWmVuNSBwbGF0Zm9ybXMsIHRoZSBwbGF0Zm9ybSBCSU9TIHNwZWNpZmll
cyBhIDI1Ni1ieXRlDQo+ID4gaW50ZXJsZWF2ZSBncmFudWxhcml0eSB3aW5kb3cgZm9yIGhvc3Qg
YnJpZGdlcyB3aGVuIHRoZXJlIGlzIG9ubHkgb25lDQo+ID4gdGFyZ2V0IGRvd25zdHJlYW0uICBU
aGlzIGxlYWRzIHRvIExpbnV4IHJlamVjdGluZyB0aGUgY29uZmlndXJhdGlvbiBvZg0KPiA+IGEg
cmVnaW9uIHdpdGggYSB4MiByb290IHdpdGggdHdvIHgxIGhvc3RicmlkZ2VzLg0KPiA+DQo+ID4g
RGVjb2RlciBQcm9ncmFtbWluZzoNCj4gPiAgICAgcm9vdCAtIGl3OjIgaWc6MjU2DQo+ID4gICAg
IGhiMSAgLSBpdzoxIGlnOjI1NiAgKExpbnV4IGV4cGVjdHMgNTEyKQ0KPiA+ICAgICBoYjIgIC0g
aXc6MSBpZzoyNTYgIChMaW51eCBleHBlY3RzIDUxMikNCj4gPiAgICAgZXAxICAtIGl3OjIgaWc6
MjU2DQo+ID4gICAgIGVwMiAgLSBpdzoyIGlnOjI1Ng0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgYWxs
b3dzIGFsbCBkZWNvZGVycyBkb3duc3RyZWFtIG9mIGEgcGFzc3Rocm91Z2ggZGVjb2RlciB0bw0K
PiA+IGFsc28gYmUgY29uZmlndXJlZCBhcyBwYXNzdGhyb3VnaCAoaXc6MSBpZzpYKSwgYnV0IHN0
aWxsIGRpc2FsbG93cw0KPiA+IGRvd25zdHJlYW0gZGVjb2RlcnMgZnJvbSBhcHBseWluZyBzdWJz
ZXF1ZW50IGludGVybGVhdmVzLg0KPiA+DQo+ID4gZS5nLiBpbiB0aGUgYWJvdmUgZXhhbXBsZSBp
ZiB0aGVyZSB3YXMgYW5vdGhlciBkZWNvZGVyIHNvdXRoIG9mIGhiMQ0KPiA+IGF0dGVtcHRpbmcg
dG8gaW50ZXJsZWF2ZSAyIGVuZHBvaW50cyAtIExpbnV4IHdvdWxkIGVuZm9yY2UgaGIxLmlnPTUx
Mg0KPiA+IGJlY2F1c2UgdGhlIHNvdXRoZXJuIGRlY29kZXIgd291bGQgaGF2ZSBpdzoyIGFuZCBy
ZXF1aXJlIGlnPXBpZypwaXcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHcmVnb3J5IFByaWNl
IDxnb3VycnlAZ291cnJ5Lm5ldD4NCj4gPiBSZXZpZXdlZC1ieTogRGF2ZSBKaWFuZyA8ZGF2ZS5q
aWFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5j
IHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2Ry
aXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMNCj4gPiBpbmRleCAwNGJjNmNhZDA5MmMuLmRlYzI2MmVh
ZGY5YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2N4bC9jb3JlL3JlZ2lvbi5jDQo+ID4gKysr
IGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYw0KPiA+IEBAIC0xNTUzLDcgKzE1NTMsNyBAQCBz
dGF0aWMgaW50IGN4bF9wb3J0X3NldHVwX3RhcmdldHMoc3RydWN0DQo+ID4gY3hsX3BvcnQgKnBv
cnQsDQo+ID4NCj4gPiAgIAlpZiAodGVzdF9iaXQoQ1hMX1JFR0lPTl9GX0FVVE8sICZjeGxyLT5m
bGFncykpIHsNCj4gPiAgIAkJaWYgKGN4bGQtPmludGVybGVhdmVfd2F5cyAhPSBpdyB8fA0KPiA+
IC0JCSAgICBjeGxkLT5pbnRlcmxlYXZlX2dyYW51bGFyaXR5ICE9IGlnIHx8DQo+ID4gKwkJICAg
IChpdyA+IDEgJiYgY3hsZC0+aW50ZXJsZWF2ZV9ncmFudWxhcml0eSAhPSBpZykgfHwNCj4gPiAg
IAkJICAgIGN4bGVkLT5zcGFfcmFuZ2Uuc3RhcnQgIT0gcC0+cmVzLT5zdGFydCB8fA0KPiA+ICAg
CQkgICAgY3hsZWQtPnNwYV9yYW5nZS5lbmQgIT0gcC0+cmVzLT5lbmQgfHwNCj4gPiAgIAkJICAg
ICgoY3hsZC0+ZmxhZ3MgJiBDWExfREVDT0RFUl9GX0VOQUJMRSkgPT0gMCkpIHsNCg==

