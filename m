Return-Path: <linux-kernel+bounces-836348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239ACBA96F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F68188D013
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24329308F31;
	Mon, 29 Sep 2025 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Um2IoDtZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710C1FBC91
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153964; cv=fail; b=ppgq2grYKCujy0JJYCd3mFzHK4zrNImZ3F5mtPp0/B7QjKyBUp/zaPypWAJ2FlMvmlRo0B4he/MVa93fS1MxId1qxHBctQVRxc7S17oxjeH6RyAfnu8CdC2FQuZ9wEk3rDnJdeCN4+rERWAEtygJuv33cA6Hppd/o281GZrDTfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153964; c=relaxed/simple;
	bh=seOZtQrYkS1EoGU9wyuDV2Yab7S1+IakbOb58l149rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0Ld5FxF+fOk7OxEG/dRj8pSt9xUmod7YJmPHtY52zQdWvDdCNw8s/NyDMcVFiy8YeXDWw1oyG5qEB3AGB2CBydyISHhomX1rFjuBHf7YMOWf3fkLg1YJ7l9KjvFFa/SOoI5JAEro0zRZ1+9a0pt3UAZXGrv/hro7qRyCHvqTEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Um2IoDtZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759153962; x=1790689962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=seOZtQrYkS1EoGU9wyuDV2Yab7S1+IakbOb58l149rQ=;
  b=Um2IoDtZME9wasaLZni/J6NcXAQSW3iwe1uKpHBHXu7+/yAw9clCgR/i
   0Y8Ho7gVzu32Vd2MfLSH3rrlcjJVVXCqXWyLgFOz0PSf//nQKLUx/HjRo
   sXg9ZrJu+a1oQ49deODZZTywAhD8uoy+hJHW/kzFGFU/i5F+Q+ypbhDvY
   y/bWNFg9sruYxMwW6nWz+gyQUYNOQwTBvC+brBIsRbmup736+JliQPw4T
   3aQida+2cXN0r6kXB9Y1ll9fQdJXwqsSCiPNMxsoGKXMYla+TIQ4RRkpa
   Fb5hQH8VeUGj7IhvhWpqfEgFWsqJmkXS+VhI4dNJ2Cersx8qK+HXDC83e
   w==;
X-CSE-ConnectionGUID: Dk/tfyrVSiWXJKXlUCOREA==
X-CSE-MsgGUID: KQ8dE6DyTLWJpjp2wiLZ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65030263"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="65030263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:52:29 -0700
X-CSE-ConnectionGUID: QyGYsgh3QUOjqQ6dsao/2w==
X-CSE-MsgGUID: SjrICWxxRTGg0k8XF5EnNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182534149"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:52:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:52:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:52:27 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDj/IGb3bWhpZtM4us6yAY9PLTdw8zDnMm4ONKsOqpWxDW56bZGIwojTY4hFtLI3Hu2be9j7YXIdEEIuh1zKBn6XxaLSZ6rW7qIaxOVJfiHHkqA/QTiJpDlfZ6HlX4G0WclsdSdVyz4PKzyD09+JvQUQFIJr0W1189J14/YdyIt42QSWsW43viyuQOh5fFRlz2djmPNVMFFfPXwGDYBgMoGF7wLHD2LuJ7gRlMiaKun8ySr5B/ZhHo98NQRx67MiTP4CrLSI1IIAlMXc/mGK4y0wOztrrIYweg9SXcphHbWD/kcwBE2QtgyGG9ZlNAO7WsBjRqmysyIwtG6o8O9tTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seOZtQrYkS1EoGU9wyuDV2Yab7S1+IakbOb58l149rQ=;
 b=UWz8zmp+DnwuykZFFYCClvAb3PZH2t3qYU6vYX0zWHqfNfeVUaDsT+lm8pu0uz4djOLfCHMAFmlIzhYYwg1f6t2VjhZniw5lxiRB8oiR4Qcl8JbcOSUjkiFy4yX4J+pN9H7emtwmQ1oCkLl7HdAYs1Dy43cZGkYYCU5/G9lj0Y9S6Ca0Zqtl5KXi+I4WCSemyZSUu6cA9JukN30o5VEL+1kDqdxAUdhMYGMI50VlE0bUSlnN0FZbiNZX4RK6YmlS40HSbysMD/sfsuNbNYeqTx2Uu90wZIiDHc0J9b8AX6CgkMr3LuHb3ZNad5VZCmQv+k4r2KiusWjeMzt/Qfilzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:52:24 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%5]) with mapi id 15.20.9094.021; Mon, 29 Sep 2025
 13:52:24 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: David Hildenbrand <david@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "ziy@nvidia.com" <ziy@nvidia.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "npache@redhat.com" <npache@redhat.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "baohua@kernel.org" <baohua@kernel.org>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andrew
 Zaborowski" <andrew.zaborowski@intel.com>
Subject: RE: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Thread-Topic: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Thread-Index: AQHcMChLk4bOL1ruf0K10LKRmZ1XGrSpxpUAgABjD/A=
Date: Mon, 29 Sep 2025 13:52:24 +0000
Message-ID: <SA1PR11MB71303A772356C994DB932077891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <8ef5e3fd-2ee8-453a-b8ae-584e3d606aa4@redhat.com>
In-Reply-To: <8ef5e3fd-2ee8-453a-b8ae-584e3d606aa4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|IA1PR11MB7295:EE_
x-ms-office365-filtering-correlation-id: 0b8a0891-292d-4d60-6a3f-08ddff5f6b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHI0WXYweWJXOE02eGxDUENoV3JaN3JPZHpFaUxkb0hmRVRybGF0ckUzRkhs?=
 =?utf-8?B?TWpSQUx1MGp2alJkMFNnR2RwVzh0WkxMaG1iT2VsTWY1QUpRVkd0VFlDckl4?=
 =?utf-8?B?cXk2UzNmcjlGN3FUdldEWkxwcmxsUjg3bGF6THlIc0pFeVJKZ3J4dmh1Zi9B?=
 =?utf-8?B?dHhPSlZjWU43a3ZKR1F6UG01SFJZMjYvOXg5NGFoMHBCRi9NSml0QXpKVUhF?=
 =?utf-8?B?NXJHSGJRb2J0NFduQVd4ZDBzT25xdWNKaGZEa2pyeXRyeFBleE5hZ2VmWGN5?=
 =?utf-8?B?b1Z4czMwcFc3bjNQblVUSDh5STRBV1k2N1UxWUs1cUY3c3d4Z1BnZnl3Ulgy?=
 =?utf-8?B?YzBRcU5Vc05rci9udFdKWWVaQS9DUDBWa1FQcEVJOHRjazBOZFU3eDlMQzhR?=
 =?utf-8?B?N05UWnpnZUVBSnZObGY0SVJIVFluaisxSXBQRGpOSno5Q0lMdUwraVNlOEs3?=
 =?utf-8?B?Y21mc3lOdC9ET2wxN1NFemorbmg2c1dWeUNQNzlPNXlkb0hIY0NNekhEeC9E?=
 =?utf-8?B?VXp6cFpVS2VBWGF5TTNZZ3ZUUjFqUEFOSmEwZHljeGszQWJrekFNN0Nrbnp3?=
 =?utf-8?B?VUtoN3NzS3dZY2xnM3Qzc1FNbTRFc2VVK203bnU5a0hhVHBXTmo2bGdiaHY3?=
 =?utf-8?B?dXFiQ2FCSmYzbWp5aXBsOTUyczk4Q3J0VXRTNks0V2YvZzU0QnF2eW9yNHJY?=
 =?utf-8?B?L0lpTzVUMXZiWHk3Y0w1aUNIY2Z5bklsOG1zTmRTT29vbHd5SHlLdWs1V3JM?=
 =?utf-8?B?Rzh2S0owU2JKRmt6RHRvMnFURjlDQW1LdTk3WWpvbFdUbEd2QUdtbllENUlj?=
 =?utf-8?B?MkpWUEhIelZGR1lnVTJia1B6UUh0NUw1SkdhakQzM1hwalNQMlowSi9XWWdy?=
 =?utf-8?B?eVRlSzFoS01lWXlSMGpBeEVyU1BEUzlNSTJjOURXU0l6WWZwMVM2OVhHa285?=
 =?utf-8?B?c2hoZklpZ1gzdkNtU1lYcTFXWmZHQ0k1L0trZHhKSksxSXc1RnR2enpNazBp?=
 =?utf-8?B?UFpwQVhNalhqTHdIV2E0UjZjWnJ2d0FFR3BkTWhPeFJaZ1czR1NFbkxNcjlQ?=
 =?utf-8?B?R3ZOYy9najdkLzdIRmFTTU55UjRpZ0NVKzVoYXNUT3E3WXNiTTBjZG14cHRq?=
 =?utf-8?B?WWdiYnZEWGpKdWgzdWhrN1RET2JsNWRCdWxTL2xCa1ZoZTNVSVV4ajZkYTlu?=
 =?utf-8?B?Wng4WitON3p6ZE1EZVcyNW9FeWpGNkhBOElzbmsyWGh6Qi85VzlUdWczSWtP?=
 =?utf-8?B?cm9TbnBQRzdNSDFkZmtLc1BJclRoRjhONHc1NlZBc3hxblFhMGNQZkloNTFU?=
 =?utf-8?B?NlpGdnJUUSt6Y3ZsOUNQc0JKaDgxYnlPcDdYbE1qRUVMMWRiaXhlRUxITzFB?=
 =?utf-8?B?c1lmMkFjSEs1cThmNHZRb1hIMzdrTDZNVER6ZkZ1bFZ2ZXNqUWtSQUFOTTJh?=
 =?utf-8?B?MXdhS2NFRzVQWVVncU1scnVmTi9xdndGZUZXemFmVWlTVVdBb2doYkRKZk9q?=
 =?utf-8?B?VGNYUlpzZ056YTJwM1pyVE4rMXJQZXFNcVZaOXF0blVETzdTTW5YY3hiYnh6?=
 =?utf-8?B?YjFoa0ZDU2dBcC9QWExiM2tSci9xNzN6NlRSTHRiQU9HaWxBUVpoTmFYY0tj?=
 =?utf-8?B?bnQyREQzRzUwdnZCaDd5c3p4ZHlVRytHbHdSQ1F4VW5OMmNTMGtWS1VGbEg2?=
 =?utf-8?B?aEZPMHVLcm54bk9hM2kzeURUUkJtbEM4aHgyc09uWjJYWEJTazlvS2hxRzZD?=
 =?utf-8?B?bWc5NTJCRnBiTFZMZlh0by9tY1dzTGlkdCszMDVaYzRIb1BZOXl5Q0VUN3Zz?=
 =?utf-8?B?VG5VOHd1TUJlZllDellrdk9za0Q1dTlsU0Z1RUh2RFdlL2VwY2ZVMkN3enpF?=
 =?utf-8?B?WC9BM3hMWUNMck9MWEdJMU53U1VTc2NaNWlGZWRoWDlTL2xSQlJqRm5XdnFH?=
 =?utf-8?B?MUl2cnBuSHk5WU5OZGVvUzMwSjNnKzVsUU1EUlh0bzlyRUJ1SS9YQkE5NjZt?=
 =?utf-8?B?VHhvYlVvT216M0tnbXk4OGpUN2c0MmpLYy9GTzE1ZHhJa0orMDNCcm1RejNm?=
 =?utf-8?Q?YHcdHi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk4vWnVpaExHSkJMNStGamE2QW9NNHFMQTM3TFpNaDIzalhwMmUycmJTZ001?=
 =?utf-8?B?djFPdzkxMndlSDVaSUwrK2lYK0wrYys4d3I2cW5RcWhtb3lOVGZ0akt0VzEy?=
 =?utf-8?B?dlpCVTBaK3UzUzVpVUcxcGlPdzNkdDFVMXJlVzF0Rnc4MlU1UTNmSk8vTGw0?=
 =?utf-8?B?SWlQcVRJRkIzQjlDN1BwdE01OW9kaVR3VHZUcW05a0JUeU9KR0EvbGxBU0k1?=
 =?utf-8?B?aG9udFpCM1BWdXovYjFSZ2ptbVhodzVMZHJyL2pWUVhoSFMzVTJZUUtrcmVT?=
 =?utf-8?B?Zy9kaEc1ZnZhVzhpRHRxcDJUUlUyUmVaS3ZLK251c0NEQ0FEZjljWVdsWTUx?=
 =?utf-8?B?R0lzMCtLbHRlbS9PNGl2eFhzZm9kdmJpbWsyV2VweVBVelM3OE5zckJ0ekU2?=
 =?utf-8?B?NFpBOFV6bXdiaU5EV2NHVDF4ZXE1VDgyMS9zVWVSYkVjcVZ0YVR0dUNyWFBy?=
 =?utf-8?B?QXM0aG1rMVF2WTdJYWVlbXV0R1pKMVR4TVllbzdUN3Q1aTV1R2JyM1U1MVFL?=
 =?utf-8?B?QUtTbDdjaitEWG0xVGtYSmsvdW9DcjJzV2hlUFRzcTVPMUlWSURFQmJzYVB3?=
 =?utf-8?B?Qms3UFVzaUVqMEtsbGxJVXdjaXltamZEZTZ2RGFjL3ZrMXFJNFljWjcrRWF1?=
 =?utf-8?B?WDJ3VFVWNDkrOGROM2pQM1JWTGVrdjFoM2plekpNekM2OHY5OEg2NEVCcHVu?=
 =?utf-8?B?TkQwN2M1YXhibFJ5cy9RV2Q0eFdPOVV1UDY5S3VDTGlzQ2pTTGlVMUlkd2Ft?=
 =?utf-8?B?YkZFbVFTa0ZPak41cnNrUjN1dlVDaUdZY3VDS3lucFFjNjZ3NzJuWnIwWVdF?=
 =?utf-8?B?ZmRDTzYyOElpYWdzdHZzei8vN2ZaVGFjWEVQN0FlcFF1SDcxd3lmTStxZldo?=
 =?utf-8?B?ZWFRa1duVzhxOWpyTVJUR21lRHJtNTRMOUVnS3NqdGEzVEg3TUhXTTdhQXZm?=
 =?utf-8?B?TUk1N0M3V3NKTXhxUzFwVmJTbVd4dzAreTlhMWJKd2l3Mi9SUjRGaFlTWFMz?=
 =?utf-8?B?N3Y3Rjd0L25pbGZqZmJVUU13c2NxOGlVUHllTGNRbFUvVzlDWExhOVgveGE0?=
 =?utf-8?B?bVBQTHVyNlVVVVZBM2p5UlRWYjB0bVVmMHNkemdHQ3NPUEF3WWNBeG5wb0Nn?=
 =?utf-8?B?MzY4YVdnNjh5a2lndGM2WVhaWlFIKzQvLzJ3UVNhOGFWS0lUeTllcVhiaCtL?=
 =?utf-8?B?VElNTGlHQitBRFBYaHRyZlhEUXpDcTlqaVQ2QWpaS09yQzhYZzB6OGtsUXBs?=
 =?utf-8?B?NmxpOUFYUWZ6ajBkZ3lVcnhWbGRRQXU0VkdyaE9WY0pkR3pYMUNRUWF3bk1P?=
 =?utf-8?B?VFVtTG1od3pMLzIyWGxlLzY5TERmZis0T1ZzYWllMHA3SjBSRnJUaUxJMzRs?=
 =?utf-8?B?TDU5d2hwTXNBNVNqQXp3Q0laT2NmdFpNK0VuVkNIZkJBa3Nzd2xKV01SSHlC?=
 =?utf-8?B?dW9FbDU0U3JrSVNxKytqS1YvYkErbmd1dHdiZFRmdEE1T3N2VlVuSEpaamxS?=
 =?utf-8?B?OHJndjdndTVja3dFYmJzdVRsVE9VNWQ3OUpBd2l4Q0dwQ2d0SHljeHNxNnJL?=
 =?utf-8?B?VVdVVHErNjcyZmNtMzQ0MmtXSHZXdHdzVVdsOFlqUVgxb2hiVW8wcGlyL04z?=
 =?utf-8?B?R0J1WWtINkR4VlZBUUo5blJiZTdPcGV2b0lKanRwRHNGbW50dGczb1NiaXV0?=
 =?utf-8?B?RGt5Y1pmdWVnZnBJdEMwL1RSdVU2VituVHhrWHQ2L0hJaWRIYlpOVUNnMEJK?=
 =?utf-8?B?UU00SVh5Rm52L3l4RHduRGtoTUhIdE50UFNhaVM0c0FsbzQwS011b29HVkNN?=
 =?utf-8?B?eldNWnZUVENBemRZT0RlbWtuaThjN2F0TTI2N1ZreXBiMTNRcm16TnhyS3lz?=
 =?utf-8?B?bmhuWExpZ1VqQ2loRXkxZittM3hwWWcyQVRDNjl5Wld1aGRGZVJwcW1jVHBr?=
 =?utf-8?B?aXl1R3ovRXRibWFZaEFFbEovUVZyc1A1RjhSdVNQMlAyWWIzMjFPWnZQSUdB?=
 =?utf-8?B?RDFPRVUyMkc3UXlVOUJwV2ZoaU9vMk5tVmFmeVRFTTF1N3B0dFRwVFJoRUhM?=
 =?utf-8?B?UUF3Snp1REpvekNOekZDVVZMU200ajQwMHBhNUxWTlNmclBZOHE0MnhVd3Nh?=
 =?utf-8?Q?T4QqGX6may670PrTxP/tGpKeD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8a0891-292d-4d60-6a3f-08ddff5f6b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 13:52:24.5040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p72wmwT9uC/5NGwbmm+nPznUt+2v6NHXoh7RmKDP1N09KW2CWcSX60WOeOKLXQgIt2vfuJxHh7SCFUoss5gJPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

SGkgRGF2aWQsDQoNCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+
DQo+IFsuLi5dDQo+ID4gLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ICsrKyBiL21tL21l
bW9yeS1mYWlsdXJlLmMNCj4gPiBAQCAtMjM1MSw4ICsyMzUxLDEwIEBAIGludCBtZW1vcnlfZmFp
bHVyZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKQ0KPiA+ICAgCQkgKiBvdGhlcndpc2Ug
aXQgbWF5IHJhY2Ugd2l0aCBUSFAgc3BsaXQuDQo+ID4gICAJCSAqIEFuZCB0aGUgZmxhZyBjYW4n
dCBiZSBzZXQgaW4gZ2V0X2h3cG9pc29uX3BhZ2UoKSBzaW5jZQ0KPiA+ICAgCQkgKiBpdCBpcyBj
YWxsZWQgYnkgc29mdCBvZmZsaW5lIHRvbyBhbmQgaXQgaXMganVzdCBjYWxsZWQNCj4gPiAtCQkg
KiBmb3IgIU1GX0NPVU5UX0lOQ1JFQVNFRC4gIFNvIGhlcmUgc2VlbXMgdG8gYmUgdGhlIGJlc3QN
Cj4gPiAtCQkgKiBwbGFjZS4NCj4gPiArCQkgKiBmb3IgIU1GX0NPVU5UX0lOQ1JFQVNFRC4NCj4g
PiArCQkgKiBJdCBhbHNvIHRlbGxzIHNwbGl0X2h1Z2VfcGFnZSgpIHRvIG5vdCBib3RoZXIgdXNp
bmcNCj4gPiArCQkgKiB0aGUgc2hhcmVkIHplcm9wYWdlIC0tIHRoZSBhbGwtemVyb3MgY2hlY2sg
d291bGQNCj4gPiArCQkgKiBjb25zdW1lIHRoZSBwb2lzb24uICBTbyBoZXJlIHNlZW1zIHRvIGJl
IHRoZSBiZXN0IHBsYWNlLg0KPiA+ICAgCQkgKg0KPiA+ICAgCQkgKiBEb24ndCBuZWVkIGNhcmUg
YWJvdXQgdGhlIGFib3ZlIGVycm9yIGhhbmRsaW5nIHBhdGhzIGZvcg0KPiA+ICAgCQkgKiBnZXRf
aHdwb2lzb25fcGFnZSgpIHNpbmNlIHRoZXkgaGFuZGxlIGVpdGhlciBmcmVlIHBhZ2UNCj4gDQo+
IEhtLCBJIHdvbmRlciBpZiB3ZSBzaG91bGQgYWN0dWFsbHkgY2hlY2sgaW4NCj4gdHJ5X3RvX21h
cF91bnVzZWRfdG9femVyb3BhZ2UoKSB3aGV0aGVyIHRoZSBwYWdlIGhhcyB0aGUgaHdwb2lzb24g
ZmxhZw0KPiBzZXQuIE5vdGhpbmcgd3Jvbmcgd2l0aCBzY2FubmluZyBub24tYWZmZWN0ZWQgcGFn
ZXMuDQo+IA0KDQpHb29kIHBvaW50IGFib3V0IGNvbnRpbnVpbmcgdG8gc2NhbiBub24tYWZmZWN0
ZWQgcGFnZXMgZm9yIHBvc3NpYmxlIHplcm9wYWdlIG1hcHBpbmcuDQoNCj4gSW4gdGhwX3VuZGVy
dXNlZCgpIHdlIHNob3VsZCBqdXN0IHNraXAgdGhlIGZvbGlvIGVudGlyZWx5IEkgZ3Vlc3MsIHNv
IGtlZXAgaXQNCj4gc2ltcGxlLg0KPiANCj4gU28gd2hhdCBhYm91dCBzb21ldGhpbmcgbGlrZSB0
aGlzOg0KPiANCj4gZGlmZiAtLWdpdCBhL21tL2h1Z2VfbWVtb3J5LmMgYi9tbS9odWdlX21lbW9y
eS5jIGluZGV4DQo+IDljMzhhOTVlOWYwOTEuLmQ0MTA5ZmQ3ZmExZjIgMTAwNjQ0DQo+IC0tLSBh
L21tL2h1Z2VfbWVtb3J5LmMNCj4gKysrIGIvbW0vaHVnZV9tZW1vcnkuYw0KPiBAQCAtNDEyMSw2
ICs0MTIxLDkgQEAgc3RhdGljIGJvb2wgdGhwX3VuZGVydXNlZChzdHJ1Y3QgZm9saW8gKmZvbGlv
KQ0KPiAgICAgICAgICBpZiAoa2h1Z2VwYWdlZF9tYXhfcHRlc19ub25lID09IEhQQUdFX1BNRF9O
UiAtIDEpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiANCj4gKyAgICAgICBm
b2xpb19jb250YWluX2h3cG9pc29uZWRfcGFnZShmb2xpbykNCg0KVHlwbyBoZXJlIPCfmIo/DQoN
CmlmIChmb2xpb19jb250YWluX2h3cG9pc29uZWRfcGFnZShmb2xpbykpDQoNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gKw0KPiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgZm9s
aW9fbnJfcGFnZXMoZm9saW8pOyBpKyspIHsNCj4gICAgICAgICAgICAgICAgICBrYWRkciA9IGtt
YXBfbG9jYWxfZm9saW8oZm9saW8sIGkgKiBQQUdFX1NJWkUpOw0KPiAgICAgICAgICAgICAgICAg
IGlmICghbWVtY2hyX2ludihrYWRkciwgMCwgUEFHRV9TSVpFKSkgeyBkaWZmIC0tZ2l0IGEvbW0v
bWlncmF0ZS5jDQo+IGIvbW0vbWlncmF0ZS5jIGluZGV4IDllNWVmMzljZTczYWYuLjM5M2ZjMmZm
Yzk2ZTUgMTAwNjQ0DQo+IC0tLSBhL21tL21pZ3JhdGUuYw0KPiArKysgYi9tbS9taWdyYXRlLmMN
Cj4gQEAgLTMwNSw4ICszMDUsOSBAQCBzdGF0aWMgYm9vbCB0cnlfdG9fbWFwX3VudXNlZF90b196
ZXJvcGFnZShzdHJ1Y3QNCj4gcGFnZV92bWFfbWFwcGVkX3dhbGsgKnB2bXcsDQo+ICAgICAgICAg
IHB0ZV90IG5ld3B0ZTsNCj4gICAgICAgICAgdm9pZCAqYWRkcjsNCj4gDQo+IC0gICAgICAgaWYg
KFBhZ2VDb21wb3VuZChwYWdlKSkNCj4gKyAgICAgICBpZiAoUGFnZUNvbXBvdW5kKHBhZ2UpIHx8
IFBhZ2VIV1BvaXNvbihwYWdlKSkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ICsNCj4gICAgICAgICAgVk1fQlVHX09OX1BBR0UoIVBhZ2VBbm9uKHBhZ2UpLCBwYWdlKTsNCj4g
ICAgICAgICAgVk1fQlVHX09OX1BBR0UoIVBhZ2VMb2NrZWQocGFnZSksIHBhZ2UpOw0KPiAgICAg
ICAgICBWTV9CVUdfT05fUEFHRShwdGVfcHJlc2VudChwdGVwX2dldChwdm13LT5wdGUpKSwgcGFn
ZSk7DQo+DQoNCkkgdGVzdGVkIHRoaXMgZGlmZiBhbmQgaXQgd29ya3Mgd2VsbC4NCklmIHRoZXJl
IGFyZSBubyBvYmplY3Rpb25zLCBJJ2xsIHVzZSB0aGlzIGRpZmYgZm9yIHYyLg0KDQpUaGFua3Mg
RGF2aWQuDQoNCi1RaXV4dSANCiANCg==

