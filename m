Return-Path: <linux-kernel+bounces-862931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B6BF68E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268664652A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970D33343C;
	Tue, 21 Oct 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdutdWs1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852A280CE5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051096; cv=fail; b=Nn1M8z5WDCCXmRmJ936zBtAiQ0EHErpDWIso74NtqHsE8qotbeVtvqjwNCeZCWDEb1PPp7NqkME2pAeWPNjuOVLrpi8dBcS087+h0fxRkgAhEL6AyPgyYlvO7brEplMEZWpL69c4rMQVkiIN2LQbkAaBjpRGJrLmW02NLl14FfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051096; c=relaxed/simple;
	bh=yNav58Gr6+zOcE+it/iV4PoFVWkfUJOQaz4T2wkS9KM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeIV9TSKP0aEBhUWzKvvo2JizInVbDp0dRt/dLcBmgAFAw1+IZfJYbDuF+CKZDtQU/622iNQulH+VdvUZWPR2fxbZMOQWQr3ICJikrY5h66XCkcUCnwfvwPtf3x56nfkOddb3AGfoMDfzgmtpSxqVtWH55INzOFQMxMGFlgAXV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdutdWs1; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761051094; x=1792587094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNav58Gr6+zOcE+it/iV4PoFVWkfUJOQaz4T2wkS9KM=;
  b=PdutdWs1jJ2Nd++T3b9eoGMWPyQ2EZgv4vrdKXNOvCEw2QWoMTzVUiXC
   lMr/nzzl85sBorC7QOz+20JtnGjL0lotQDcPw+l/A0oU7B1u4xRSOXb/T
   1dm6qvSR1t/CRc5PUKvEd8aW8yyqKldg93PJbwnWaFfFGQDN2pctLs4GX
   tOD2sIEk5wRVCksvzBbB1SbD07uz1H9aM/UWakiluQfHe0jC18/Ftg9lR
   W/MER2IsZNiB70ifg2PDqO4DIjV8cqaUUudVbXqW/f6d4KzTdXQ2FGyq2
   xPp7ug3E6+NwJS7QbtAuEKxCgqJQnIIddxC27Gkqc2BO3H7pMhjeSOo7y
   Q==;
X-CSE-ConnectionGUID: Mu83ky2XQX+8H1fmj2HAFQ==
X-CSE-MsgGUID: 36JPTrvFTt2A1p6DjY70SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80612791"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="80612791"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:51:34 -0700
X-CSE-ConnectionGUID: N6Z9PxbCQ7mODDzvoarNGA==
X-CSE-MsgGUID: ZJ7+cKezQteDGgWqAkOOsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="187620040"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:51:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 05:51:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 05:51:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 05:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxA6H9yhY2NPUrc5jk1wI19JJnAeK0nVlJdw2BNdzG4aNUr64fuGbV9/30Nn++SLbwediMHM71X04fPRIIc+qcMDR0OkLfHrzMRv+SVkvn8G2qa9fkrI1EEm0KQP2QCEoqXnSydQeE5AVKj7uMZVT5p3Xl5MqvcW+d09gSNnJkFSS0ez00HJomkC1PCL9nIaTgyx9NdaT0mK3YaqlEyxKUCUytKx9GzZR2eMumXMnZpFXY8okuBXsFR129F6QtgsH8kFOFdksHBhMzb0Ta40v0K175ScH1FUK5ExmAebuOo8CcduDXQqI80qTXcBYlHMKrakjGLQEwMAAQYS3VHp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNav58Gr6+zOcE+it/iV4PoFVWkfUJOQaz4T2wkS9KM=;
 b=GonTXIO5XQRMSWDh9uNO7Nje9iyzp+ysXkz+abukAmqYVegr1RLyX1sVcdzSzj7xQOLv3J5Jjj/ARTaLCTd84JDr0QtGLuYMadx7Tl+R6K/FaMFKNd40OjtatwkVZVV8BBzP+porecVkHrMNgS85m4qfVmNfNGvasbQeyau0K4gegywWXfnXMVk+SAUxePkTjmzPk1R5cDmeJsK3rCKVXKVCiSeuo16mUPBdQCh5SdqpwXAPz+/7M1hzjemfRm2HgU/Un1nuQhiJKD2MbRgbM0HcGC4wgpE3E5tNL0uJYFXLAOTQjcGC2NP12BbEubYFhDwntMmMM8S6CYRlbRbzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA3PR11MB9374.namprd11.prod.outlook.com (2603:10b6:208:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 12:51:30 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 12:51:30 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Abliyev,
 Reuven" <reuven.abliyev@intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>
Subject: RE: [PATCH] mtd: intel-dg: wake card on operations
Thread-Topic: [PATCH] mtd: intel-dg: wake card on operations
Thread-Index: AQHcQQvroNhSaCIfh0abEtSYk7POBrTK0Q8AgAAAQwCAAY4gcA==
Date: Tue, 21 Oct 2025 12:51:30 +0000
Message-ID: <CY5PR11MB6366D892E7B6FDB112751306EDF2A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20251019150145.3228079-1-alexander.usyskin@intel.com>
 <aPYKRvCenwnrFXcb@ashevche-desk.local> <aPYKfhTDF5kXulz9@ashevche-desk.local>
In-Reply-To: <aPYKfhTDF5kXulz9@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA3PR11MB9374:EE_
x-ms-office365-filtering-correlation-id: 20af1f6b-fc2d-456f-31ed-08de10a08e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WnY1RStFenZSWVRMcVhTWGNVc1pDbTRiaFNyY3ZOSEhxVHVFNkR5ejRWY3FO?=
 =?utf-8?B?dFh3MTRUTjdESkJWZG5KUUk1cE9JeXFrNGVWbVVIU3FGdUhNUUl6c29KREpj?=
 =?utf-8?B?Kzk0b1Q1eTVmNExTNnFXNzNGakRmV0gxTjVhaUtlMEZPeGlBdm1iVFNQbG1O?=
 =?utf-8?B?bUY1SzcwZFltc2hIQmNRclJsTEhsQUd6Kyt0Ui9Yek9ZWDc0N0Jjcm1ibUUv?=
 =?utf-8?B?RUhESlk4dnE5V2VGR1hodS9HdVowZ0lyWENhY2krdHAvS3I4dG83ZWtsTDlw?=
 =?utf-8?B?THQ5OUR1ZEY4SkFOd0NrNGc0WEJQbnhOVFAxQlI1SEhmdU1lVXlHYUxyci9k?=
 =?utf-8?B?UzlDdjhtYVZXRm9iN3k1cEpJb0FFVkhzdkZOdU1CVXpCc2FiaUtocGswOFJQ?=
 =?utf-8?B?ZkVvU0dTOEJZMkdpY09TN1F2b1I3ZlZwT0JzV1dQd2VuZkpNb1NxS2hiek5k?=
 =?utf-8?B?b0tHUXBXOWlFblFQeVBWcHpROVpBb1pYUDZ0ZloxSVlKNGk1U1poOHNiekpK?=
 =?utf-8?B?VkZpV1ZBTzBuN2tUZ3JvNFNEaE1mQmtjNDBlc2tmQXY3WXZETkNpcmxvSlBq?=
 =?utf-8?B?L0JuSG5GTVB4TzZOc1k2d0F6SWE3YXRHZ1JKb2pGSFNIZnhycDd6MUdCMEZN?=
 =?utf-8?B?MmlBQU9sS3pOcTVLUzJJQlFWeDlacU1qdzVEdTZuY0E3UUpvOVNpOE9NWHlX?=
 =?utf-8?B?NnA3Z0paMFBpNklJbVNaQ0tlejRFbkhkcGdaaHNoQmRCVHdJVS9vYTluQWVu?=
 =?utf-8?B?OTRYekk4K2M5VEdTRytiYVB4dkZEQmVnL3FTcGZoenFUYTRVSWJaWGhhWFJU?=
 =?utf-8?B?Y2tRck5qYUQ3UGpqdjRPSmcrdFlLNkw4ZVNiNGErcG04bkJuN01mRUJEWE5n?=
 =?utf-8?B?RFp6NXd1dTk4Wk9MUWNnMTNXNDBrdzU4VGZYaTMwMTVNV2Ivd1J2KzVDNmE5?=
 =?utf-8?B?eis4MiswTDRTUzZ6Uk4wRm5YczlhOVk1WERxM3JTdGV4TkIrbHZscjJOcExV?=
 =?utf-8?B?VktrclNIWlowa2U2ZE1KamZPeGhtZTBqVzZwRjhmNFBKVzlUWjlHa3pCTGFP?=
 =?utf-8?B?YnBaaFNWQnBFbTdNdlZtR2lHZjNxUGZRQ2kxU1VkNjZydndwYzU5THZ0a25S?=
 =?utf-8?B?Zm1adWQ2ZFBaSW9maU1qKzluQTlxbGxhRHBGdFlmVDJLQkprMXVzOGpKci9p?=
 =?utf-8?B?ODlhaTVWQjVNWjJKRHdNajFINmVUeXhZYzRNY2F6MXNqTnBXRnlzNUg0N2pF?=
 =?utf-8?B?WkJscktKMURZYW9kcldzZ2w5WERpbHFWUEhiS2tpeEZRZlYvUDlyQjBsY2lx?=
 =?utf-8?B?M0M5anA0cWl1a09nTDJ5MGpONDg1eUhjcXA5MUFYZ2FyYytxU1loZVlHMkhE?=
 =?utf-8?B?TSszOTkvQXpwWm9aOFRQNDFUdzMrUGc1dkU0NUpPaytKVitqMmh3UWRqS1Z4?=
 =?utf-8?B?ZmtSUUcwb1RTTHlibmZYUUVrbUVCZjVBRGdNMEFheldRVDV2eWpsbU1YU0Z3?=
 =?utf-8?B?VCsySnljNmROYlpqSUQ3SStqODZyc1lPa0dHRm9tdVY3aWdFK1NWZG5lTlRM?=
 =?utf-8?B?Q3BKQnFlekhtRVJXUVdPbG45VFhvSDFPY1FTekxXWVRoMUxQVHh4S2xZRStM?=
 =?utf-8?B?VGFiSThQUUIvT2RuSWhiS2tDV3ZRWmRJbTRhY0t1K1pLT3RKNVhjalhlSWJl?=
 =?utf-8?B?OVkxQThnQVVHeE0vRVloOFdoWjI5eUFZdzZSOGM0OHNpcXVmMVlLcHNBMjRS?=
 =?utf-8?B?dWNzMWNSNEs2TUREWGtmUXpaeHZNMFRVeXFaeDlVZURVbURsMDNTdWJtUTBV?=
 =?utf-8?B?eXBRdk9uTm5ZVVNZS2xVazA1TnZPOU9jYzllc1hqcnNFMy92LzRmdUtpVitp?=
 =?utf-8?B?QnhXdVpwWUt2RFNNSW1JYmh1QS9OdERTNnhjL0wxaGlZOU1PRzRYWk1jRE9F?=
 =?utf-8?B?Y2hhMjZkcmpjTjE4MkhqYlYxYTlYdFprcjRIR3pmRkU0Y0RpSVR1WWh0MEZQ?=
 =?utf-8?B?S3lUL1pubjIyalFvZUhBb2tWU3B6c2d2Z2FHSG42YlNiSXBSd2pobFI3MUVm?=
 =?utf-8?Q?dfx52y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlNkUnlQRlRoT0NlcFRlU0ZGckJ1a0tvNWh2N09yWUVaeXJwUlM1aXhrU2Jn?=
 =?utf-8?B?QlBldmdKQ3BlR2QvQUtoNVJQMjRtRXIybkFCQnVCdGJMc05HRUx3cVBpZHJx?=
 =?utf-8?B?RDRyYjdQRzVYRXJ2alBDUXlETGFVa0VBMnBBZGRBRTdFcFErN2ZZWXFuTm5F?=
 =?utf-8?B?TEJkZSs1NDZiMEcvODdJZ1o2c0dqVHNTdWliMWxibVZ0Yk5nS2czVGQ1Q1px?=
 =?utf-8?B?ZVdBYkcyYTBrdXBkNXNvMHZzOHFSWEZubXQ1ZUFnTUtIRkdBZUY0L0Q2Y1d6?=
 =?utf-8?B?VUZHdHpTdGd2MzhTc1hDVTc3bGpvSElXbmtER2xYMTVINTVxMVZaampXMVVC?=
 =?utf-8?B?MzBXdVBjcWl4SGRUNXFpRWE2NHp1S204eDhQRTVVaDU1NGszR3doazVjaDhz?=
 =?utf-8?B?cWYxY0JPVVgvNEkyeTJmRUd4QklOYmF0bTZiZW50RnA5UWRUUnR1bWRpZXZX?=
 =?utf-8?B?dlhiRTdYSnhtb3JqdkVpcDB0QjBSMWNEaTg1UEpKSVR5WlZoek03VDFnVU1L?=
 =?utf-8?B?cEZRZEh3UWk3ZHJuZ0xiSWhuSGJkMlgzZG5VWTQxZnM5TVl1TS95Ly82akNo?=
 =?utf-8?B?c1ZDbTFaNDNCQ0FFdGhlaWR3V0VXZUdNZGpEZ0VzUzJLNVFUaU0xVUp1aksw?=
 =?utf-8?B?NkpJbUp0SzZ6L3pZTDBqNWdjRlNQQjdEOHJxak1RYk1JcHNzVGM4VjY1WlRm?=
 =?utf-8?B?emJtUzE0SElzSjhNV1YyaDBkSkNaOVZZSGpsaXhneUZ3QWxHWlJJVXZNQ2Fl?=
 =?utf-8?B?Yy92ME9URFVpSTFlb3JKb1FXdlpScjc4eUZ2SDh5YmsxcEgvU1NUWHA1aDVO?=
 =?utf-8?B?Qk04ZXlUd29aYllrc01uTmdpWnNLSTVyRUExaDdxRzFYajg0aGxNZGhPZlFV?=
 =?utf-8?B?eXIvbHJjU2RMV1pqamZITUlFeGN3L3dMMWRKUHBnZ2ExNE5ReHVuTEx2MHFD?=
 =?utf-8?B?Z0xGUU53TkFjNFBKbnR6ME9VMlhUZVROSUZWNS9RQTdjYWp1YytmRmNjeDBp?=
 =?utf-8?B?Tkp3M2xWNzhzMnRxelVSaGFVakgzTzVtNjlJUVdyZ0F5ekh0VGpDbnllc0FC?=
 =?utf-8?B?Um5KbFdZVFc3RmZ0Tkk5c1dlOFVRRjZENnVla3dGb0JsdEh3dkFLV0FJTmwv?=
 =?utf-8?B?TDFPbjMzQXpmUVh2SktLZW9vc1ZuUmV1QkU4d2hOdWxiTTE3RDlHeE5QeEV0?=
 =?utf-8?B?SnZ0RlFxUmZXMWs3R29wR2wrM0k4SFl2RWRUY1IzaXFiQjZlSEdEL0NLUThU?=
 =?utf-8?B?QXBEVlYxMmloV3FGS2YyK3M3dWt5N0JGRkZURlU4dVh5bzl2LzFzMnFjTnJa?=
 =?utf-8?B?ZWtpanFBSEt2OThKM3ZXdnh1OGgveUxFL05mZmpLVTYvN3huL0l2dCtTNXpR?=
 =?utf-8?B?UmV5V0ZCcFA4OXoyelhEWkZhcnAwKzZzV1pNVlg1aFhlaFExL0hOUGJpamEv?=
 =?utf-8?B?dm80UUFpL1lJVnFPTGpqSkFZTWZIMlYrZWpVT01peElCbFg0ak93MFVFQ2kr?=
 =?utf-8?B?aFVBb01IcHZlSnNJTHUxM2lwYnF2UXduY1BHTURhYjhwaTBiSVF3amMrVDE3?=
 =?utf-8?B?TXBqT1RrakxXeHJnKzNsWEx6cVZSZ0o3UG5aT3NKajc3MnF3RGpaR0RwWnl1?=
 =?utf-8?B?c2VOanBSZ29GSjFhMXVNM3ZFdlJaeVQzQ1R0V0hZTkoyQ1BRSWZkaWRuR09F?=
 =?utf-8?B?aXFqK1JzN0kyTmhBN3ZPOU9ySFdYb1c4MkEzOFBiR3BQWXhRN2VyNzRYejJ0?=
 =?utf-8?B?LzRiblRHTFROaThOUWtPQUFqOU5BaGM4MGVYRi8xaU9POHdPejZmZmJycUI4?=
 =?utf-8?B?WE5QemhYWCtCMm4rZG01Q1BidU9oZlRqdjFGSDB1RVZjRU1kZFJOZVBIQzl1?=
 =?utf-8?B?Mlk5SW05MHNSNmhCa3crd0ZDVzVGNlp6VU9pL1FLZGJ4cWcyNTllTTVPRWJ1?=
 =?utf-8?B?Nm1FRHFaTXUrRGxWU3RrSy9ZZFFQeTVheFNZc05vS3hvMTVQb1hFTW5tTmx6?=
 =?utf-8?B?REUrZlVsemFpSmticGRValpNRlplZDVQT2hjc1BmQ2ErUk9VVzNPYm1uU2lu?=
 =?utf-8?B?Z2IxQ3RDM0tESmFNZHdMaEdPRjV4SGFVVXdKWDV0em5zUlVkZDJDUTUvQ0FF?=
 =?utf-8?B?K21zaC9vQnRuWWRmZkNMdWh4SjVsb1JJUWJEU2dKRi9ycllDMS9NTFhnMmRr?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20af1f6b-fc2d-456f-31ed-08de10a08e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 12:51:30.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqdbun7qo3hr5eKDw8cnfHD8ZbPugxSmg7xqDGZ3+RDIgOC7wv/U/xeHGuW1JRrYAho+4QtA36CnWHK3haPm+dth8Fe12A+3VkeJXtWt5ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9374
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBtdGQ6IGludGVsLWRnOiB3YWtlIGNhcmQgb24gb3BlcmF0
aW9ucw0KPiANCj4gT24gTW9uLCBPY3QgMjAsIDIwMjUgYXQgMDE6MDk6MTBQTSArMDMwMCwgQW5k
eSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIFN1biwgT2N0IDE5LCAyMDI1IGF0IDA2OjAxOjQ1
UE0gKzAzMDAsIEFsZXhhbmRlciBVc3lza2luIHdyb3RlOg0KPiA+ID4gRW5hYmxlIHJ1bnRpbWUg
UE0gaW4gbXRkIGRyaXZlciB0byBub3RpZnkgcGFyZW50IGdyYXBoaWNzIGRyaXZlcg0KPiA+ID4g
dGhhdCB3aG9sZSBjYXJkIHNob3VsZCBiZSBrZXB0IGF3YWtlIHdoaWxlIG52bSBvcGVyYXRpb25z
IGFyZQ0KPiA+ID4gcGVyZm9ybWVkIHRocm91Z2ggdGhpcyBkcml2ZXIuDQo+IA0KPiBBaCwgYW5k
IHBlcmhhcHMgYSBiaXQgZWxhYm9yYXRpb24gd2h5IGdyYXBoaWNzIGNhcmQgbmVlZHMgdGhhdD8N
Cj4gDQpUaGUgbWVtb3J5IHBvd2VyIHdpbGwgYmUgY3V0IHdoZW4gd2hvbGUgY2FyZCBpcyBwb3dl
cmVkIGRvd24uDQpJbnRlbCBERyBjYXJkIGRvZXMgbm90IGhhdmUgc2VwYXJhdGUgcG93ZXIgY29u
dHJvbCBmb3IgcGVyc2lzdGVudCBtZW1vcnkuDQpXaWxsIGFkZCB0aGlzIGluIHYyLg0KDQo+IC4u
Lg0KPiANCj4gPiA+ICsJcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShudm0tPmRldik7DQo+ID4g
PiArCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKG52bS0+ZGV2KTsNCj4gPg0KPiA+IFBsZWFz
ZSwgZHJvcCB0aGUgc2Vjb25kIChkdXBsaWNhdGUpIGNhbGwuDQoNCk1pc3NlZCB0aGUgcGF0Y2gg
d2hlcmUgcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQgaW5jbHVkZXMgcG1fcnVudGltZV9tYXJr
X2xhc3RfYnVzeS4NCldpbGwgdXBkYXRlIGluIFYyLCB0aHgNCg0KPiANCj4gLi4uDQo+IA0KPiA+
ID4gKwlkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKGRldmljZSk7DQo+ID4NCj4gPiBQbGVhc2UsIGp1
c3RpZnkgd2h5IHRoaXMgY29kZSBpcyBnb29kIHdpdGhvdXQgZXJyb3IgY2hlY2tpbmcuIEJlZm9y
ZSBkb2luZw0KPiB0aGF0DQo+ID4gdGhpbmsgZm9yIGEgbW9tZW50IGZvciB0aGUgY2FzZXMgd2hl
biBkZXZtXyooKSBtaWdodCBiZSBkZXZlbG9wZWQgaW4gdGhlDQo+IGZ1dHVyZQ0KPiA+IGFuZCBy
ZXR1cm4gc29tZXRoaW5nIGludGVyZXN0aW5nIChpZiBub3QgeWV0KS4NCj4gDQoNCldlIHNob3Vs
ZCBub3QgZmFpbCB0aGUgcHJvYmUgYmVjYXVzZSBvZiBydW50aW1lICBwbSBlbmFibGVtZW50IGZh
aWx1cmUsIEkgc3VwcG9zZS4NClRoZXJlIGFyZSBvdGhlciB3YXlzIHRvIGtlZXAgY2FyZCBhd2Fr
ZS4NClRoZSBwbV9ydW50aW1lXyogZnVuY3Rpb25zIHdvcmsgd2l0aG91dCBydW50aW1lX2VuYWJs
ZSBidXQgaGF2ZSBubyBlZmZlY3QuDQpUaHVzLCB3ZSBjYW4gaWdub3JlIGZhaWx1cmUgaGVyZS4N
Cg0KPiAuLi4NCj4gDQo+ID4gPiAgZXJyOg0KPiA+ID4gKwlwbV9ydW50aW1lX3B1dChkZXZpY2Up
Ow0KPiA+ID4gK2Vycl9ub3JwbToNCj4gPiA+ICAJa3JlZl9wdXQoJm52bS0+cmVmY250LCBpbnRl
bF9kZ19udm1fcmVsZWFzZSk7DQo+ID4gPiAgCXJldHVybiByZXQ7DQo+ID4NCj4gPiBNaXhpbmcg
ZGV2bSB3aXRoIG5vbi1kZXZtIHVzdWFsbHkgbGVhZCB0byBoYXJkIHRvIGNhdGNoIGJ1Z3MgaW4g
dGhlIGVycm9yDQo+IHBhdGhzDQo+ID4gLyByZW1vdmUgc3RhZ2VzIHdpdGggb3JkZXJpbmcgb2Yg
Y2xlYW5pbmcgcmVzb3VyY2VzIHVwLg0KPiANCg0KSSBzZWUgdGhhdCB0aGlzIHBhdHRlcm4gaXMg
cmVhc29uYWJseSBjb21tb24gaW4gZHJpdmVycy4NClRoZXJlIGNhbid0IGJlIGRldm0gd3JhcHBl
cnMgZm9yIHBtX3J1bnRpbWVfZ2V0L3B1dCBhbmQgdGhlc2UgZnVuY3Rpb25zIHdvcmtzDQpyZWdh
cmRsZXNzIG9mIGVuYWJsZSBzdGF0dXMuDQoNCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+
IEFuZHkgU2hldmNoZW5rbw0KPiANCg0KLSAtIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=

