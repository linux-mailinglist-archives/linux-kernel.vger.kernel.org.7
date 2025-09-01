Return-Path: <linux-kernel+bounces-794651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A61B3E4BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241233B717C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32D266565;
	Mon,  1 Sep 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJJ+Uohe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683B188715
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733059; cv=fail; b=VpTOoMSqCe/FkbFi0B4vZ8PqzcoEK1I/B6VV2XAqkYgTNncKqEirzlZbcAUL0XfVNI7xF87giwfWCIVTQ+E52UZIJa6BEiq7tSDFhr1+JPvDHJ84POoEXLKCK05zl9C4lIwQ61pV73BJoD08V4X5WjkEtfksohUSMbeZhJa0grY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733059; c=relaxed/simple;
	bh=ZypT7/+5vbJI7eAHQBTpf/CqEwyl8kUrwH/XDC2Dz4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7aLD/X8zvmBXqoLxOTGxkhNo69/Kb17v61Cs+C3HI52khcT+T9qoOkzRE6ZoPIlQ3xNf6I5P83nYuHQVOwLBi1ct52eLjueVifZETNqe2sYFwZAZTB6EN3hFJW73xYtZIMhd6ySpfobLVVtbV9yOZ3P7ze1/8dPQRFrYm5vcIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJJ+Uohe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756733058; x=1788269058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZypT7/+5vbJI7eAHQBTpf/CqEwyl8kUrwH/XDC2Dz4A=;
  b=LJJ+Uohe48rqfFNaTqiktT29AMPQsMPWYQS127Dqc5swnV59Vfc9LuOS
   ejquNXh9eAbRxvwzrEhZ1Db18f1kfFU1Rfc/7pvrzsswSLls6e4fGhuSF
   BWUHkbtn5+7Z5a+k6ZUNFEVHQUv0egKX7i2wQLEfOeRHL2Ib4mcS4Vr/a
   zEMImqrYeKF4X+K15AhOiXfnRtnsQqVc8I8GJCfLJswMJNY/qwpthY2GF
   ZXhOxM8iD9Mgi35Jk+dp+w1T3Dy21rcaJqUVchbAkePKzxKDTAb/5oI5j
   4WqrRBKXRtQxiYc5Dvw15PIylQkz0NqOie/CAimWbAIMA6CuS5SPvCA+S
   g==;
X-CSE-ConnectionGUID: jJqRhLVPQ8O5z/YBevE6PQ==
X-CSE-MsgGUID: WQpHujF/RUm5zD2wKtAVAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62824478"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62824478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 06:24:14 -0700
X-CSE-ConnectionGUID: PmA/DYmdQR6Xm4JWiYI+/g==
X-CSE-MsgGUID: mTh6ECsMSU+QSen1UZRdog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175390791"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 06:24:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 06:24:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 06:24:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 06:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4m/S7ISvdlBMjZfERZ7FzcmoOqsA9Z6TH9N3pArFEVz9Yh9Hb7VeabSbwVH6H3ew3qO0NeH3kRX+4uQI73Q744t4SE6y4zs1S5cuQ37RR+GJeEuqFdoRoz84E+y05/ejGA2FrMZOqyM9gv8OIENTR0R8g3bVNiDXJqYVBU24z57Yv8okYjYYfjBWKibjT6+p9CL7A4cUzEL8okyI87thca353O+6tH74XOQuW/OAC1TptqpT3fHRd7glLoNaY/AlWOH1aI5ppnxvbuV4Raaa1JgsA69uYBXhWqLfcXgIJMsKejPKTPE++58kPQr52FWqCBBoe2bgr4O/HYkC6lZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZypT7/+5vbJI7eAHQBTpf/CqEwyl8kUrwH/XDC2Dz4A=;
 b=DRN+dZI7hzqUO/YK6HTLmnysr8CkqVSKKrtQ9cyXtafrj2936diOsyj7BPojdxqiLrgHexVrcDDINVl4RSnk1fJEAsoQ49112Jqq1QBa301bxRcKdWdi55lLofbzKyFsEWByHZvU9vnqIkve8L3sg3ydz6+Qy6+VVfSoJXtJUbvJpGRMx5dKitnrI6lRe1EWdbbm559jZPELpJERfMb/poF1SbM+vTTWn3wk8EdG4NreZRGS3Zo3BLO4pY1jbuJHgSbNoFSL1Dc5SP0GvpMSluk6avgSAOs9GuhIhPzLm6ggfFZOgiAArQLKUlb2Amg9+vAajvZUAUl+2Jsmaqz0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6)
 by MW3PR11MB4634.namprd11.prod.outlook.com (2603:10b6:303:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 13:24:09 +0000
Received: from BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff]) by BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 13:24:09 +0000
From: "Deng, Pan" <pan.deng@intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li,
 Tianyou" <tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@kernel.org" <mingo@kernel.org>, Chen Yu <yu.chen.surf@gmail.com>
Subject: RE: [PATCH 1/4] sched/rt: Optimize cpupri_vec layout to mitigate
 cache line contention
Thread-Topic: [PATCH 1/4] sched/rt: Optimize cpupri_vec layout to mitigate
 cache line contention
Thread-Index: AQHb7ucytWqOfDwXIEuCBTuUF/MckrR+H52AgACJ14A=
Date: Mon, 1 Sep 2025 13:24:09 +0000
Message-ID: <BL1PR11MB600349514E682268F50921699607A@BL1PR11MB6003.namprd11.prod.outlook.com>
References: <cover.1751852370.git.pan.deng@intel.com>
 <c3fa01bed2f875293ac65425c75a322e8e70e1d3.1751852370.git.pan.deng@intel.com>
 <a17428e9-0221-44ff-8a10-6cf93a00c172@intel.com>
In-Reply-To: <a17428e9-0221-44ff-8a10-6cf93a00c172@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB6003:EE_|MW3PR11MB4634:EE_
x-ms-office365-filtering-correlation-id: d06baed2-28d1-4699-30dd-08dde95ad551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eEJWVERPNGJDWHFpUERZalVNYzJPSHk5NGtQR2lVdHhFYm1kTHBGQlBNSjNK?=
 =?utf-8?B?bWdkV3R4ZElFZ0I2Y1drdDJvdzJ0RldVcTZOQlVGbGtpdTU5NkRtQjNsSVpG?=
 =?utf-8?B?bDZtRHF5aGJnUXl6SHNteVJMMUN1S1JtUkRrMzlJUUNvTnMxRTFhWitWdzZB?=
 =?utf-8?B?Y0ZuK0NVVHM5S2JOWERXMXZiWjQxUTd1dDJVaWVSRng0ZU1BVW1rdDJRY0g0?=
 =?utf-8?B?WGVidFVYci92V2ZHOXFQSzE3VUpneWt5QTRFdFczTE9TU0F4MlZKeGhEUFB2?=
 =?utf-8?B?MDJpcnFUbi9iSjRLQVhidXlqL0Z0VXdUVWs2YzJzbGJsV04zOTV0elg0MWtV?=
 =?utf-8?B?WWJBV0VkNUFOUVcvVkRHR0pyTkcxeHlEdGZNdVp5cmdiUEh5bUUxOVNoYU5R?=
 =?utf-8?B?NkRvQ0dkcGNHdVN2M0J0SFpPWFphT09mS05ZTWRNc0VrUlJnZzU4UkZzOXZ5?=
 =?utf-8?B?R0pkZEZrZ1dubHNLVldhaDNPcSttdisxN21qbFI4cnNrRnl6THdIT1Y0R3ZV?=
 =?utf-8?B?ZWFUUTlIZ1R1d3NtcXRwSXRlQnVGZnRuMm9GaGpDRlk3SHI2SXVSZmNHTmMr?=
 =?utf-8?B?a2ZxdVNWNlRWVjdvRDNjM2g3YzM5Szl2UU9JK0JEb2tJYXFaT0tEdUF4ajF3?=
 =?utf-8?B?U3dleGMzRnp1b3ZvVmpaNEJRN2E0N3dYbVg5bXJVbVY4Q2F0eVpJcVdlQy94?=
 =?utf-8?B?V3BuK0N1YkE1WDN0OHNxWGkva3JGT1FvOFhlR1B4YmpJM0dvVi9sd1JrMlZu?=
 =?utf-8?B?Y24vaFluVmIweFptYWR4WlV5Y2w5djIrK1NueDh2OVppRnF6RzhDak9GS3l4?=
 =?utf-8?B?eHJtUSs4Q1FYNS8va1YvbG12cC9VTnFaNGdFRDJ4TmFzb3RWd0x6WlJsSlJD?=
 =?utf-8?B?dzlGL3FnUHFqdkdzajBFYnBOLzZWbThhOTlReUxZck0zcEo4Z0taeEU1VWZM?=
 =?utf-8?B?cUlQVmFNSWJ1clN6d2M4aWNUNjkxYlhtelREMlMwaFhzS25mSnIreVhtRVdr?=
 =?utf-8?B?NkdqZnFwekJIemRIMWVZbFVpaW9vWnE4STNaaHVxbk85ZkVLdDNpQVUvcnY2?=
 =?utf-8?B?TXN5WHhzZFk3UGNNaEVGdDFldjFQSlZVelU2a2RqK1J2SnZMZFJtR1dLbXFS?=
 =?utf-8?B?NFRPVGpYenFEWUE1dHdvQnhGY1ltTkh4ZnFWVjlHdm40TmNqL1h3d1I0ZkFF?=
 =?utf-8?B?TmJabkZ6UW00bkZTSi80VU05M1BvcDRPa0ZqRFh6UTEwTXpEWkY2cHJoTmFl?=
 =?utf-8?B?YVZhM3RTNUFDbEpFSDVIR3k1Z1FvSk5YYWl2eWpBNGRTNUtNQjdVRG1nalBr?=
 =?utf-8?B?dGVIQjZlRUw5a0dRV1hoTy9nTTViUFViYnBVdDhDZkxWNnJrK2FBSzh4SlND?=
 =?utf-8?B?RE9IaDJ1WVBvTWtwZ0I5a3hObHN5TXk4YXQzbVZDTG9uNU5jWXNwV0RPZ3BW?=
 =?utf-8?B?TFRuTVNseEMxTWRoSEpJTDhqUDBrMGtUVEZxVkNxL0ovRkF3bXpoQ2lLN3NP?=
 =?utf-8?B?VEhJcFFaWExIL0Zvemo2YzNPYUFUZVE3Vlo0MlB6VGRlOW1KTzc1WGYzVTFk?=
 =?utf-8?B?UlN3TGlORnNsN09hckc0SjZGdnFjNDBQYVdSRjhwd3l4bERtSzc0MXp5S3hl?=
 =?utf-8?B?MWJ0WjI0RGNWSmFua3B0eG9DVDFpTzQ0eVJWN3RQODRlZmZkSkRhTGxkNDF3?=
 =?utf-8?B?M0htc2o4MHNnbkFDVjhEWUZOVjJXMXJkWVl3cTUweCtnb1VuQmN5Sk5aMVRq?=
 =?utf-8?B?d2UxTnY0dW1ZejBlQmF1T1BUTjltalppK0xaZDYyRHYyWFJtRlNGOE9JMnZ3?=
 =?utf-8?B?dklGRlVyK1ViMFZQMFhtNmhIakx5RXZ5K3dkdE85R3Q5TERXTXlSL1hPUU51?=
 =?utf-8?B?dUdtU2NCYUF3bGRlTElZTGpiT2kzNVdJR1ZzZ01IUHdCSzFNTFdOMnlicXlZ?=
 =?utf-8?B?SWJFNC9ydmFub0hubDBYb0ZLK2QrNTE3OTZQUlBmRGFHbmVpSzh5YmVpUVpT?=
 =?utf-8?Q?n/YRoRO2Ffk+AGxWelGGWF+WERWl0c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB6003.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjR2TzdNU29LL3o4d3ZwOThMaE5OckIyOWp4YklqMWh3M0VWS2VWVUNleFpn?=
 =?utf-8?B?WmtabytTSktRNXVxTUhJVndpSnJUd3JaRUwyOXowWUpNQklmcWpEK2FqTURK?=
 =?utf-8?B?ckFiaVE4ckJLVGQxdnhwS3M5aTM4Y045bVl2SDhkL1RXU3dhNFZYdk1uWFVa?=
 =?utf-8?B?RTdGazVVakZpRS9HcWZaN1BRdi82YmhxNzFVc09kN3lENm9LMGgyaVFuTUFB?=
 =?utf-8?B?b3lzMUNRcldWQTBuK2dWSlQ5K1VuVk9ibVJMNzNCTEhLWVNVOVpxdktQM3RZ?=
 =?utf-8?B?QXlPcTlFbEx1MGxiTjh1MUlwTU9aTHZzVEc5WEl4VzhkZFlJenhEaXZBMFB6?=
 =?utf-8?B?eWFMdmxVSWQvMUc2WHI3S0N6SmlVUUp0dEoveE1KeXhNU09OakxxNjJrZ3VJ?=
 =?utf-8?B?RVV6dzdyU3lRS0MySk0zNFBEVkp3K2RrZHpsYjcvUkNkTjhRMTdmbTZGWGtG?=
 =?utf-8?B?QjlPSDlNOVhQK0FoazErdXZKenBXYTkwZXExSmtnengvOUtvcVg5V25HNE96?=
 =?utf-8?B?NGNZMSsyUzBIU2htTjBvaDkxZkhzay83MjVqbG1sakk5V3pOV2pjNlpHaWpZ?=
 =?utf-8?B?RTkxaVQ0TUU5dDU5bmpmWWp3TU1ucEhVb3BIMTJlQ0VOa3JJSnhCS2M3bGdD?=
 =?utf-8?B?NWxzZkN0Z1QvK3M2MDkxWXdjcERna0dlN1psZkZOL2hBQjg2VVRwMktNSVFM?=
 =?utf-8?B?bUYxUTVkUXBGcUlRSHR1QnlPMzM2OHZTTUQyVk1sbUR1Y29HSHQwU1MvUy9Z?=
 =?utf-8?B?RWlTUGVnaWoxQ042cFZ3WTdsNlBBVGNuWms3STZpQStKN25Hc0VTcVFTeTJO?=
 =?utf-8?B?cDcrSVkwRmw4QmJ3WWhlVGF3dUcrZ25uNU8rUmUwSnBWaU9NUkkxeTNUeGtY?=
 =?utf-8?B?aVhpMVdadU5ZZ09IeHVHRG5ScE5mVk9ycVdXN3QvMkI5K1gxQXlKQVFJVm1F?=
 =?utf-8?B?WUcxT2ZhUTRPOWtKeURkQmltSFpnM1lVd1p3dlpSQitSQTl5SFRjZkRiR0Iv?=
 =?utf-8?B?SHQ3aFpiVFYrcnlneVJCaEQ3TkJVK0FyOSs4QzJJZFg0QmdxS3k5Zy8zclJX?=
 =?utf-8?B?U1dtaTUxNC94dFZKc3BxS1hVRWlHVitPSGJTaUJOenVvM0hSdDFhQy8vZSt1?=
 =?utf-8?B?ZmNOU1dsNExaQ3dpL0ZZbEI2WWVkSERIR2hqYThsblhOalNHSlk1dXV3YjJ2?=
 =?utf-8?B?blVRQldBRktxb1ZNYlVoM1NxZWJneHA3MFVvSG1iVlQvcXd4M01VUXZDYWZI?=
 =?utf-8?B?MThlNUtvRUMxK1dYcmpVK3JiTDBEdHBJOUlVODFYZFpPMHJSUzEvbjJ0OTJS?=
 =?utf-8?B?bjJvTmMreUJtbTdjRXRWclVPVG9wMURvT09ydkxEMnBkZXQxT1hpLzNqUmh5?=
 =?utf-8?B?MlZ2ZXUzV3hOSVpvNCsrMW1IenM1NUUydmhGZm1sdCtvcEJVRUhBOWJqcVdN?=
 =?utf-8?B?dXZxQ2kzS0lXTGh4U0M1VE4xTis4bVRDdEZXQ1ZPMjR0eTRuOUg4YU84ZFFX?=
 =?utf-8?B?TUJlaXVEMnd6aEI4VzhraTk3V3B2ZDgyTEVTc2lhbHIrS1hpa3NOWlhSdEsy?=
 =?utf-8?B?TTIrQzJ2b1F1dGI5bzlTcUpuUWRrOEM4R1VTaFhCTjcxQ29vRHlxbi9nUldt?=
 =?utf-8?B?cVJESmc1KzJJWVVvbXV2Y1ZkTzh3NGpRNGY0cEtEekhIYzJlK01JYUJnT1ov?=
 =?utf-8?B?MGRNL3Q2RmhmazNTQk05K3VwVERuZ21qY0NRWFlJd3pPaVVlMVJ1amdqK3dI?=
 =?utf-8?B?Zlh2N1RNTWh3akFac3RkcWlmaHZnNCs2TXZDa2kvUWcrYytRNk96dFB4Sis2?=
 =?utf-8?B?TkR0UzRLeUEvWVlMajVFL1V2czdSZ2E3cnp1aEk1SFoyZElRUFZQOUp4QW5k?=
 =?utf-8?B?dy9jK2wyYnUxY3RweEtXVko5L1ZKRGRveG5qVjJZdVp0K0RERjkwRklIYnp3?=
 =?utf-8?B?bisrc0VBbm84dXJWNm5lMVR0dlF3Qy9maXdhT2V6YXg1MmhPMUh6V1d2elp2?=
 =?utf-8?B?M0pFOWNWLzhxVit2UmpKZVIwTjdlSVNEZHdxKzRZOGZyS3NsRkorenlDTzll?=
 =?utf-8?B?eTdXNGt3RjkvMFdSTW5OWGQ1Y3JnZ2o5aWFOT1liWk5DanQxUklTUHAxNjhl?=
 =?utf-8?Q?k+gmT3LkY4KcnAQknTKDbui8R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB6003.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06baed2-28d1-4699-30dd-08dde95ad551
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 13:24:09.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /V1iAGpHITZGC9HAtEutVsDS8g0p9uMrb1Aro9ufAEl7/HUyYeoTQyQOu/2x2cQlBH1hV37o/vk6W9vOfYfZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4634
X-OriginatorOrg: intel.com

VGhhbmtzIFl1LCB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2guDQoNCkJlc3QgUmVnYXJkcw0KUGFuDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbiwgWXUgQyA8eXUuYy5j
aGVuQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMSwgMjAyNSAxOjEwIFBN
DQo+IFRvOiBEZW5nLCBQYW4gPHBhbi5kZW5nQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IExpLCBUaWFueW91IDx0aWFueW91LmxpQGludGVsLmNvbT47DQo+
IHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgbWluZ29A
a2VybmVsLm9yZzsgQ2hlbiBZdQ0KPiA8eXUuY2hlbi5zdXJmQGdtYWlsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzRdIHNjaGVkL3J0OiBPcHRpbWl6ZSBjcHVwcmlfdmVjIGxheW91dCB0
byBtaXRpZ2F0ZSBjYWNoZQ0KPiBsaW5lIGNvbnRlbnRpb24NCj4gDQo+IE9uIDcvNy8yMDI1IDEw
OjM1IEFNLCBQYW4gRGVuZyB3cm90ZToNCj4gPiBXaGVuIHJ1bm5pbmcgYSBtdWx0aS1pbnN0YW5j
ZSBGRm1wZWcgd29ya2xvYWQgb24gYW4gSENDIHN5c3RlbSwNCj4gc2lnbmlmaWNhbnQNCj4gPiBj
YWNoZSBsaW5lIGNvbnRlbnRpb24gaXMgb2JzZXJ2ZWQgYXJvdW5kIGBjcHVwcmlfdmVjLT5jb3Vu
dGAgYW5kIGBtYXNrYCBpbg0KPiA+IHN0cnVjdCByb290X2RvbWFpbi4NCj4gPg0KPiANCj4gW2l0
IHNlZW1zIHRoYXQgbXkgbGFzdCByZXBseSBkaWQgbm90IG1ha2UgaXQgdG8gdGhlIGxrbWxdW3Nu
aXBdDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY3B1cHJpLmggYi9rZXJuZWwv
c2NoZWQvY3B1cHJpLmgNCj4gPiBpbmRleCBkNmNiYTAwMjAwNjQuLjI0NWIwZmE2MjZiZSAxMDA2
NDQNCj4gPiAtLS0gYS9rZXJuZWwvc2NoZWQvY3B1cHJpLmgNCj4gPiArKysgYi9rZXJuZWwvc2No
ZWQvY3B1cHJpLmgNCj4gPiBAQCAtOSw3ICs5LDcgQEANCj4gPg0KPiA+ICAgc3RydWN0IGNwdXBy
aV92ZWMgew0KPiA+ICAgCWF0b21pY190CQljb3VudDsNCj4gPiAtCWNwdW1hc2tfdmFyX3QJCW1h
c2s7DQo+ID4gKwljcHVtYXNrX3Zhcl90CQltYXNrCV9fX19jYWNoZWxpbmVfYWxpZ25lZDsNCj4g
DQo+IEp1c3QgY3VyaW91cywgc2luY2UgdGhpcyBpcyB0byBhdm9pZCBjYWNoZSBjb250ZW50aW9u
IGFtb25nIENQVXMsDQo+IGlzIGl0IGJldHRlciB0byB1c2UgX19fX2NhY2hlbGluZV9hbGlnbmVk
X2luX3NtcCwgc28gdGhlIHNpbmdsZQ0KPiBDUFUgc3lzdGVtIGlzIG5vdCBpbXBhY3RlZC4NCj4g
DQo+IHRoYW5rcywNCj4gQ2hlbnl1PiAgIH07DQo+ID4NCj4gPiAgIHN0cnVjdCBjcHVwcmkgew0K

