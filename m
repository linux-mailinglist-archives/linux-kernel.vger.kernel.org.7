Return-Path: <linux-kernel+bounces-736288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC6B09B08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DB11AA6178
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DFA1E520A;
	Fri, 18 Jul 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pU2zU0EW"
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891DA930
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752818173; cv=fail; b=RuOz34SXbL0BQcurMY5ElKLwHYEsMabNx+DFnPi4YFVHimImj79y/GEJsIcavFJUXGkpxh5wkzLKbH6DqwKKq/5yK3rJlziuzed6g9aagZXenpLeiF+IsQu0UXOD+CmenykzN6VH+lntZxEkNoBqZ6DJN9DNLlkIdDcwaETfPMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752818173; c=relaxed/simple;
	bh=f5hUxuUS/SkrtvXtbyrwQ5RXif4UeKxunKWpyzcuDeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mU3QvctpFa45ASi/JiSTeLY5GnqmOuhJKDUXNkcdcTOmjXPI3wnyK4X8ztoMCFf5h4yXYVz0xMD0QL6n7rqda/zejonltZbTX5R0CMXr+v9g8knsupzw8FciZOMsGEFWF2LNhwrAkCpGhIKEjSdIeXC+d+QdGkoXxSDEe0mBRPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pU2zU0EW; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1752818171; x=1784354171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f5hUxuUS/SkrtvXtbyrwQ5RXif4UeKxunKWpyzcuDeU=;
  b=pU2zU0EWiEgvCXfBTsgnULYw1oI3qCWgiFbuo1sW1N44L9Frhz5r3+rA
   cjP3R0RIqKwhMZ2MMNawihnJXDmGJIWPg8qhxw43C+3F4dR6kHqDguRFX
   fP6HVauYtAvyw8FmLuDsSTrLpC2K0Yn6Iu3ffF/yU3AHQbMvF/Sa+APHO
   gBsAGTd/uvVQIlumUv2JDaacWi0lCjJwsboZMs8exnMiXBsqmjTiDH9YR
   L/v6YIC8jCjb6TZDHWhsaumekLZXH53KFVY37FFAWL4ZQddhqNvgssr0x
   ORtnAHC1TtOrnndWVGkgAbF/0+VwOB5UWIuIZrZTPkoKHdXJwrOCcQxul
   A==;
X-CSE-ConnectionGUID: eV/34xgSTBuyOTUAQPYMxw==
X-CSE-MsgGUID: rNrOY4AjT+KkBTRysCDqdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="161946388"
X-IronPort-AV: E=Sophos;i="6.16,320,1744038000"; 
   d="scan'208";a="161946388"
Received: from mail-japanwestazon11010040.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.40])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:54:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rurM06jfOFObECx4fbQhVPESo+s2qwJI/+Rjx4pBQ33CAtqXoL6k7B3g0MInM1Dtoq2buTVv/ySm2NpQQPkg7RHL3gwqU41jRdZRZyd7jRS4VfZsEMcSAMIfko17gF2eJS6dc9EfIRFomR+vO1jhQO1ujgr+Di+hYRhVXxexzVRZVpptSJ7X4F4OTJbX06gqrF5Rg/+OGOrgeJ1/RFFYS4tZJjk/rNtsYnU1Nqor3Pfshf9GJHnUul9qTmaRVP1OZkS3LcIgj9WOYq6tU91dqt8fg+s9SxCEEbYFb36ArlVoIAooiRCrug4MURajp1klZsXOu4JXPVmo9RqYc+DIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5hUxuUS/SkrtvXtbyrwQ5RXif4UeKxunKWpyzcuDeU=;
 b=n7KmfLnF1yOCzWL8wnKsvLBnvwc3GbvnJ1lH2SxHW3xzC6q3+NLbRCQRXasPtv/w57f8ITJSKXbHKd+x08XsjRmXmEzo+WGJrJH1AVI4/B7UQ4KYsEw4oFRKW6qoP7QPwHjKJmSBoRTqNk7tD0GlNcuZUUz5V+W0V5CotnHe+Q4R8i0AuMWz8C3HWp4rwKDA2yBMeTUqLrhuhQbVuLD/Kq9SN7k9RPpoekblV5DnyBU7ZRVj6lVOoPKdPqsE5xeEyDUJ6SUy5QmSV9eSf4mVcQ87Fxb7WZUGH31avVhxSHZIJNcAzP56jc5VrqTELtB8MEleVmgA7LuIjLdw/SwAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB5584.jpnprd01.prod.outlook.com (2603:1096:400:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 05:54:50 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 05:54:50 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Koba Ko' <kobak@nvidia.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>, Yury Norov <yury.norov@gmail.com>, Dave Martin
	<dave.martin@arm.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"peternewman@google.com" <peternewman@google.com>, Babu Moger
	<Babu.Moger@amd.com>, Borislav Petkov <bp@alien8.de>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Xin Hao <xhao@linux.alibaba.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	Ingo Molnar <mingo@redhat.com>, David Hildenbrand <david@redhat.com>, H Peter
 Anvin <hpa@zytor.com>, Rex Nie <rex.nie@jaguarmicro.com>, Jamie Iles
	<quic_jiles@quicinc.com>, "dfustini@baylibre.com" <dfustini@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2] fs/resctrl: Optimize code in rdt_get_tree()
Thread-Topic: [PATCH v2] fs/resctrl: Optimize code in rdt_get_tree()
Thread-Index: AQHb5LtdcAPFPuTTAEGVRyXWX8Y5JbQ3hcGw
Date: Fri, 18 Jul 2025 05:54:50 +0000
Message-ID:
 <OSZPR01MB879863D390CCAFA43858BBDC8B50A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250623075051.3610592-1-tan.shaopeng@jp.fujitsu.com>
 <f37b0dfa-ae59-4693-b10f-79868e093e80@nvidia.com>
In-Reply-To: <f37b0dfa-ae59-4693-b10f-79868e093e80@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTJmNjRmYTAtNDNlZS00NmM2LTk2NWMtZTNiODI0ZDQ1?=
 =?utf-8?B?NWY0O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDctMThUMDU6NDg6MzhaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7TVNJUF9MYWJlbF9hNzI5?=
 =?utf-8?B?NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfVGFnPTEwLCAzLCAw?=
 =?utf-8?Q?,_1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB5584:EE_
x-ms-office365-filtering-correlation-id: 2c04b27a-9b9b-4133-5c33-08ddc5bf9c3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODJKR0N4bHl3VlRBNkJ4UjBTcE9sNmFxQ2dFL3pxY2ljWVpZQksrTUpEa2RU?=
 =?utf-8?B?cG1GZFZPVU5wU0FDYVAweGtzT3dWNXZHck9RZGYzQ0dOd3p6UlhEc0RzcDhp?=
 =?utf-8?B?NTZJZlpCbzdUR0ZsMTV4QUNibDZJTjdEYnY4bmZoUjV1S2orZlFWK3c0eEtp?=
 =?utf-8?B?WDUzcm94RHc0dHp6d3N4REdJVHF5cnlxYWtJTzYzZzVSd3RjOWNFMGw1SHNa?=
 =?utf-8?B?eFdROXlFUm5zeG56TTRqZ3REeWU5ZU9DaVcrWlVmbEEra3JoWlJ5ZHJVdVpr?=
 =?utf-8?B?bWtqMmtNNktUa3B0L2w4RnI2a1NrNG9INHBKM090eGJHcEE5MG5uK0creldQ?=
 =?utf-8?B?S3E3Wm1RN2Q3Q0tpWjJjcDBBVnBqR1lZRTJ1OXJIS3o5YktNMWF3R0UySHBN?=
 =?utf-8?B?WHkydFQ1YlFmcnVPME5HNm9vd0ZiTThYTVpIKy83cWZXQ3I1MDNUM1dLdUg2?=
 =?utf-8?B?VllMbGpwNVRiQjZ2S0s3STBXV1MzM2F1a2JjQmkzVk9IYUEzdFVMTFhRUU9r?=
 =?utf-8?B?TjdqM1ZRSTVhUExQd1k0RWpSUnhHa3VYQ1cxamUwMFlML0llWnNHY0liYmE3?=
 =?utf-8?B?MC8vTHYzcHNMTFYwMTJxb0dSRmhuU2R5dG9hc0xUSHhjYUNXd3VLV3F4Q0RD?=
 =?utf-8?B?NU9NbFdWWUgwM0RDbGhySXRxK3p5aEllYXVuQkxabE02Mkg2Zk5lTWlLUjBJ?=
 =?utf-8?B?NmZ1N2JUNGhxQTlpRWVGc3JDZFR5Uk5LdS9uQUpoYUV2RTYwQTlzaXlnSUFW?=
 =?utf-8?B?RFVsYVpSL0N0OG1ibXJQTVg2WFZRWjBiNmlzUmlBRVhPTFQzdzRUMWYwZjRH?=
 =?utf-8?B?c0doWkVibWcvY2tFbVJZQmRzM01vZnhySURzeVpLa2haOXZON1FabVhsNVVS?=
 =?utf-8?B?b0FxZGc1bUFwQ3ErcmFoZHEvQlRCSkg5Tit5LzdNbEZqRU5jMkRCRzVuckt0?=
 =?utf-8?B?ekxGaXA2RGNKMUZWcGF2amczQnRMODBNSk1YMEE4SlNrbGEySWVqKy9MMUxv?=
 =?utf-8?B?VnpBbWdxZjFFSXBob1U0eXJZbis4SEp5VWpYQnBURlMrdnBPVTlTbDZEcVNP?=
 =?utf-8?B?K3lTdXUxR2VyN0JDNFpVMmJiMVUwT1l3RzF3MGxVVUdWTHk4WS80YmFWZ1FO?=
 =?utf-8?B?RWZuWnlmMEthMXNESUNXa1Q2eWl4c04zN2d2ZkJ0bkdhK2tHajc1aUZxSjQx?=
 =?utf-8?B?cHU0d2xqeXpsOGswZ3RUYUx5OE55bnRiQjd1ckJYMUlXbEE4ZTdLZG9xa3ZE?=
 =?utf-8?B?WitDNDFvZzdScmVlaWt3bzRsTzU1d0Z6UmQzcmNRbHFGUDVXVDdzVFBRa2ky?=
 =?utf-8?B?eHE5aHJWL3pkRlViUFlHU0hWeHdBMmRQVEk4Umtkdkp2TWNPeVdEMjVqWFRM?=
 =?utf-8?B?eDBLWm9CMmpxcHAvb2psb2dmOVhaZjVTMEpFU0VuK3VvTk5sZHBEYVF1MkZo?=
 =?utf-8?B?NVBnRTYzV1IrQVMrWmlGcTdyMVhNc0JkbzE0dEZlbFpSMEQ5T2pOSVBmb050?=
 =?utf-8?B?TDFhMzJNdHVWazZNeEhSbExpdGhuYldkWkpIS2lVaERKd2l6TGh0SEJsZWZy?=
 =?utf-8?B?Uld5bThBZmIzc3pvZm1mNHY1d3hyYmQxaVQ1bkNPRHRScndocExCV1o3KzY4?=
 =?utf-8?B?bHlIY1RkcWZualVhZ05aUnM2TFpEWDU1aVdyODJzYXA4Y09EWmU1ZWNsTXNr?=
 =?utf-8?B?Q3hHSXRBa3FreUFzczR2OXI4ODdYK05zeks3Nll3cGxUMVYxdTdPWEVTNFNj?=
 =?utf-8?B?Nlk3Ryt3ZGtwa3hmZm9WYnRQYnMyQ1cxZ0hJMlZ4VWYyMUxibktCdDBwQ0pn?=
 =?utf-8?B?TlZBSWhmQjQ4OS96RkdkeVRUcGloVkpQKzVhMXdqbGNjS01ZNlN5QjJiQ212?=
 =?utf-8?B?Z1NKbDlabG1FbVc2eTRocnBQV3lLdlNRYmYvMGlDaW10SUIwY2twRWRhZ0tW?=
 =?utf-8?B?b3F6bVJocHdZMVM5S0N5QUg3WURxUmxUWW8waE5BcDNrRFBpVURuYU0vNm51?=
 =?utf-8?B?YVhOdlFLL2JJTjljZkI5YjhRN1pHSkk5dWFBSmdFRFpCVUpVZHVQOUd0YjdW?=
 =?utf-8?Q?QiSI/V?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGZDend1aE5xdUVIQXhjWmtMV29rcGc3TUxlUWgwUGcwQUhwQS9HSTBDWU5o?=
 =?utf-8?B?VGdSUlRZbVE5SEhFZ3R6TEZRVUpHQThxOGJ3cnJnanJpcXBxQ3c2UW5FK3Fk?=
 =?utf-8?B?NWJwL2FJYTNUOUpDTFFUVVNqSWZIRkxUYVhxcDFIU0EraDhmeVFqUFNZaSsx?=
 =?utf-8?B?R1ZDdTRNK0g5Yk4wbldrY3VBMjNIak1jWHU5bVMrcE44YU5oajQrYWlpY25X?=
 =?utf-8?B?NHhCMGk2T0tnZzcyVUcrR1ZzZXcxZ283ajcxWlpxQ2FsTm5zTWtoQjVpbzZj?=
 =?utf-8?B?bC8rMWZLcWFpenkyU0J1OVdDZGxWcWgwb1h0UDlJTVEwbm9Nd3RoNXVNSmhM?=
 =?utf-8?B?WTJON1U3QkVCeHpSOERGYzhXRmt1ZjJaT3lYd1VLQ0RCMWR5WmFSd0U5RjVW?=
 =?utf-8?B?b0pxL1FSblNNNENRNE55RDdPZU5PQVdyNXpzVUVaVlpoM3hzaVBqM2E1cEFv?=
 =?utf-8?B?Tlo2WGxleUpoNmxZZE9LMW5sbFAyblZGQXNNaUcxa1Y0aHlRQW1XRmxMLy9a?=
 =?utf-8?B?STNjeDRwSDlOVjVVWjcvVTgyemhXTWo3c3h3VkZaMGExb0UwRXJGSEtEWkw2?=
 =?utf-8?B?MGIzUmx6ZEY4WHdVdWowQjM1SGhFd0hlZ2dkRjYwSndmd1l3eHA5VDNQSEpm?=
 =?utf-8?B?RDhFZ2pCRnF3ZFJ6dEJHRFdWMWIrZHZqaGdmT1BpdzAvbWNqVC9uKzZrb01Q?=
 =?utf-8?B?dnpHbDFLVzVEZW5ERHZUTC9wYXFEd2kzb1hqbXMzbm9hSldHRmVSa0lmRnZQ?=
 =?utf-8?B?dTk1dHMrTFhJb0NFNWxTUU1LMU5TMFBpMjNMTWNoMDJmOE44RlhhYzc3elF5?=
 =?utf-8?B?OWxXdU4rWERtY1U0TEtnUXVncDZkS25Rb3BxKy9DMnRERjN0WUJJUlE0VXoy?=
 =?utf-8?B?WEh4M3pMSVBWMk1pVnMraUhQZi8yakNqczZwcW1JejlQY092VFg1MTFMM0hC?=
 =?utf-8?B?a3NyVldHL2NJbldlVytoeFBJUldqWXFnem03djhBekdSWjU3WXBHQTNGNDlw?=
 =?utf-8?B?UVlwMVdUYUQralBxUVlwOVBWY0EreS9vSVk0SEdkTXR1WUZUV0tHTk5kYkY1?=
 =?utf-8?B?NFE0eTU3dUhqV0d1TzhqTW9hZmNUSkFDTVYxbEZTTjdTQWhPdjhVbjhmS3V6?=
 =?utf-8?B?NDZUb3NhTUhiQmE3d1NZWFBZTFZ4UmE1bmtKeno5UTdHbEZ1Tk15SngxdU5Y?=
 =?utf-8?B?Wis0TUZvRVRrTE0veHBnUjJtSWRwVDRMb0dWSEdHbi94S0VkbHdDRW9RNmo5?=
 =?utf-8?B?ZmtFVUlZdUd4dHJraFZscmhOVXVlbE9RVm9va2ljbVpOZ0NQZzR5enlEUkp5?=
 =?utf-8?B?My9iMjB2QzNlTzlFdWs2UjVMNFMycXlzWGZaUWpVNEtaZmc0TFdWRFlRelZZ?=
 =?utf-8?B?Nm4xWW1UeXVOamliOWdZd3Y0V3Q1QlExUkU5dXBZNXh3dEx1MTlReDRPUkxx?=
 =?utf-8?B?TzEwY21aSzQ0RlNQc0FEVU0rSXJyWkRtMXl3V1MveVdkbllTOGNST0hJbGtm?=
 =?utf-8?B?ZGRibU9NVnI5aGl4eVdIdnY3c3h0b3NIQnJtK2tHVmw0UUoyS1JmUHZ5VG9T?=
 =?utf-8?B?MjBobGQ5Z2ZLTWNPNEZqTWt5NDhlYVYzSisraFZ2SDVXWE9jd1hoSlJQR3Mv?=
 =?utf-8?B?alNXVGJIbTU0dW9pMG0xTnBHZFdza3BmVDhNdEhSa3N1RlJpSGhSNUltNWd2?=
 =?utf-8?B?blFSU2VRUEJXR3VwOHE4Wnd6L1l6T3U5Q0tYT2JyakJYRjd0bEJBVDlCS2E1?=
 =?utf-8?B?RnhmdHR1RTZBelU1ZlFRa2FLNkdsMStIRnJiU2JqbDB4c1VtTUhaK1Zscm4w?=
 =?utf-8?B?aU4wYkpVaDZDUi9JOUdWWEt5MU9CS2pmT1hOREVONkR4RHplYnJKdDJVRVpO?=
 =?utf-8?B?ZjNQdlJsMnBQbmZHWEpFK0c3K01ETmJJc25rdTVrdjl1bHhtR0ZPRGw4TmhV?=
 =?utf-8?B?U293SytXNi9XTkt5OHU3cmJnb0xMNDVJNW9oRWl0UWRiOVVSd20wVVJhSmVa?=
 =?utf-8?B?TkFjNE82MWkzcXkyRVI4M0JPbHF2dmhsUFY2RVE4WGxTd2FPelZaZ1BWSGJ1?=
 =?utf-8?B?L05MYU9sTVhnV3I0RmJtc0RncTdOY2pyVEdYaU44Mjl3VXlRZEpVMkp3dlZU?=
 =?utf-8?B?WGkxZURJTDlvN1ZycnNHSjBrek5zSUpVWWlTbnJwNWEwUTFPZEt3bEo5L20x?=
 =?utf-8?B?SVE9PQ==?=
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
	9UHrwncfT8klM+nX5sXSVi655pvxMgMmuaJHLtn/hRHoLG64hkPOF1JxBYfXcb4T8yLUPJV2L5zch+vGhHBKf978m5sqToeu0aTevlN6VvEE4YoMXLEXNfUkE61CImtn6/nwLLQe4Qu6VvnObezObvAN7IpEHfPfK4ouSwxXwNNxbCYpkjwqjdPuNSxXu6Hz+15nTHEpmsQhiHhJwv61zbVd8zhjsabossj7eos7d0j3g2c/ssVxZxWlXJjm6rLxNWa7GGJmypcP6k17K/++bzCF9r9ypmKnkr/sIH8kHbqSXzh5KS4spfUag/ywkupZeCaSAFvb9ony3iGRSh7W0YRRDpI+4kbDohgq+9IIIgGSp+goXwAR+K/9qbR9c5eDjPwtWJJ82+T+qnfzKTbXhmhjCJZZa0oAikWrae2T9dsNBTrAdn+oZCFvsiLxHMj9J81LIGZhmo5TZKXnsAejsvGB0xOn8MM06f8ilpbIN3NOIkU8v8UQMmcnHI9bzP4KILXnS3+pCirosk6TryzFTBOM2mh/TxOhNjjyubflqm3wO82u+UijO6yEo+7c1klFmwAcFvFuvQ8k0PdFTu8s/8ttefoVzhVqe/KRh8DRkvj8pCaFkXTnUDavQ+V7YCFt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c04b27a-9b9b-4133-5c33-08ddc5bf9c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 05:54:50.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pQzkHGSNS6O5b5HxhSjQhVRPOJYQdzJBcG92onu313TqiYa3Den4x3Jt1Aefz2kAacqHbwKEb/d8HhXbGC05W23vMBbdwtsze8eMxwWjk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5584

SGVsbG8gS29iYSBLbywNCg0KPiANCj4gVGhhbmtzDQo+IFJldmlld2VkLWJ5OiBLb2JhIEtvIDxr
b2Jha0BudmlkaWEuY29tPg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+IE9uIDYvMjMv
MjUgMTU6NTAsIFNoYW9wZW5nIFRhbiB3cm90ZToNCj4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+DQo+ID4NCj4gPiBzY2hlbWF0
YV9saXN0X2Rlc3Ryb3koKSBoYXMgdG8gYmUgY2FsbGVkIGlmIHNjaGVtYXRhX2xpc3RfY3JlYXRl
KCkgZmFpbHMuDQo+ID4NCj4gPiByZHRfZ2V0X3RyZWUoKSBjYWxscyBzY2hlbWF0YV9saXN0X2Rl
c3Ryb3koKSBpbiB0d28gZGlmZmVyZW50IHdheXM6DQo+ID4gZGlyZWN0bHkgaWYgc2NoZW1hdGFf
bGlzdF9jcmVhdGUoKSBpdHNlbGYgZmFpbHMgYW5kIG9uIHRoZSBleGl0IHBhdGgNCj4gPiB2aWEg
dGhlIG91dF9zY2hlbWF0YV9mcmVlIGdvdG8gbGFiZWwuDQo+ID4NCj4gPiBSZW1vdmUgc2NoZW1h
dGFfbGlzdF9kZXN0cm95KCkgY2FsbCBvbiBzY2hlbWF0YV9saXN0X2NyZWF0ZSgpIGZhaWx1cmUu
DQo+ID4gVXNlIGV4aXN0aW5nIG91dF9zY2hlbWF0YV9mcmVlIGdvdG8gbGFiZWwgaW5zdGVhZC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW9wZW5nIFRhbiA8dGFuLnNoYW9wZW5nQGpwLmZ1
aml0c3UuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSZWluZXR0ZSBDaGF0cmUgPHJlaW5ldHRlLmNo
YXRyZUBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEphbWVzIE1vcnNlIDxqYW1lcy5tb3Jz
ZUBhcm0uY29tPg0KPiA+IC0tLQ0KPiA+ICAgZnMvcmVzY3RybC9yZHRncm91cC5jIHwgNyArKy0t
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL3Jlc2N0cmwvcmR0Z3JvdXAuYyBiL2ZzL3Jlc2N0
cmwvcmR0Z3JvdXAuYyBpbmRleA0KPiA+IDc3ZDA4MjI5ZDg1NS4uNWYwYjdjZmExY2MyIDEwMDY0
NA0KPiA+IC0tLSBhL2ZzL3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+ICsrKyBiL2ZzL3Jlc2N0cmwv
cmR0Z3JvdXAuYw0KPiA+IEBAIC0yNjA4LDEwICsyNjA4LDggQEAgc3RhdGljIGludCByZHRfZ2V0
X3RyZWUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiA+ICAgICAgICAgICAgICAgICAgZ290byBv
dXRfcm9vdDsNCj4gPg0KPiA+ICAgICAgICAgIHJldCA9IHNjaGVtYXRhX2xpc3RfY3JlYXRlKCk7
DQo+ID4gLSAgICAgICBpZiAocmV0KSB7DQo+ID4gLSAgICAgICAgICAgICAgIHNjaGVtYXRhX2xp
c3RfZGVzdHJveSgpOw0KPiA+IC0gICAgICAgICAgICAgICBnb3RvIG91dF9jdHg7DQo+ID4gLSAg
ICAgICB9DQo+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIG91
dF9zY2hlbWF0YV9mcmVlOw0KPiA+DQo+ID4gICAgICAgICAgcmV0ID0gY2xvc2lkX2luaXQoKTsN
Cj4gPiAgICAgICAgICBpZiAocmV0KQ0KPiA+IEBAIC0yNjgzLDcgKzI2ODEsNiBAQCBzdGF0aWMg
aW50IHJkdF9nZXRfdHJlZShzdHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ID4gICAgICAgICAgY2xv
c2lkX2V4aXQoKTsNCj4gPiAgIG91dF9zY2hlbWF0YV9mcmVlOg0KPiA+ICAgICAgICAgIHNjaGVt
YXRhX2xpc3RfZGVzdHJveSgpOw0KPiA+IC1vdXRfY3R4Og0KPiA+ICAgICAgICAgIHJkdF9kaXNh
YmxlX2N0eCgpOw0KPiA+ICAgb3V0X3Jvb3Q6DQo+ID4gICAgICAgICAgcmR0Z3JvdXBfZGVzdHJv
eV9yb290KCk7DQo+ID4gLS0NCj4gPiAyLjQzLjUNCj4gPg0K

