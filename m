Return-Path: <linux-kernel+bounces-871451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE273C0D551
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DBD421C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD023002AD;
	Mon, 27 Oct 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4vGQqBH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9A1D90DF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565816; cv=fail; b=E5aAjDClhVxSireUNo5kAVCY5YDFb5RUyQdq2xqS0OqwzQugvk/tygrpkNjuOAqwbQhBT5AEWaKjgsOTl/aFZsp5h0fscPpMFOb08VIfOGhaupy4w+h5mVO6fakO+UbItdJyHigKc56nEte2avHjGLz+2zCIaqDoAnuPsvXmyDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565816; c=relaxed/simple;
	bh=fLYRpit8/LbseAwPeNqAz0ZJHiB3J/0+oGZPfBiNH08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYE277t08QWS8BvxISsFrNDIueqbNzHcuHmFYy/fI37XnoNA2hAN+m465iJNtdAxV/qakNqjGzQ6OdN32k9hwNoqVCTDfVD3+3XqbBX5tJ/nqmybfASEjh31CWqYvcoarKteW6ra6RP14u4YLzcE91Lb1fV35yV6nnWuauMc7Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4vGQqBH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761565814; x=1793101814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fLYRpit8/LbseAwPeNqAz0ZJHiB3J/0+oGZPfBiNH08=;
  b=J4vGQqBHYqDFIckAkys6FdnaoVFaGWDRJkR0iD8pdV+9ViagJZMnf45d
   UUX2YVzcn73D/Y5nmXHDT1p+ne/kCmEsmIrGRdVlodYpplleLclKqg++Z
   s8H4nTop8A9byWtdl3NxpkuhU6JOJkZPQy/dQruhB49vwNA1M9H0y2k4O
   dtU5oZGIzUCV+NvfGUBDZ1dG/3pmBSI04s0JrNxypDxFMvdt85W0DzLn0
   SMG/XOtYA66dL4niY8FlXKclr4DxStvK9mi2v4rhPf5RufGpMD5b4Ni7n
   N4Fn07P6Dn3DaTF9In5Tuma1bigA7q/MkaI9Lg8s9gCjqZTcWLHYSyfkz
   A==;
X-CSE-ConnectionGUID: 7K9b80yiT8+GZac8wxr7MA==
X-CSE-MsgGUID: uW9AeMQDTSyLNg8h0OSx5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63734729"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63734729"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:14 -0700
X-CSE-ConnectionGUID: CDps2aF3TKqzjifiFtDf0Q==
X-CSE-MsgGUID: rNN6E9kzRr++NdXp269xHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="189063090"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 04:50:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 04:50:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 04:50:13 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 04:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnyremXxbS1+gpL3fapK4jg55JKLCg1Y09+I6axEH6Qb9XyXDkMVGKY8WNVKBmiiIcfmUzSEWi72mgCxp7INoYN2NpCv38FfioBHG69ubaxlB97TM+FQA/CI0SZmL+LYTnYziThbWq7P48kcYthxaSKFJjzUvqGqHZO/YlUEHyK4eKKIF7CqscjozIRzY/4Q1bkTi3zqPBVY1kvEjLkFWJkGe4ct6rJ8OljjzROerXqRCkIgzksZeJXF2p4w23PTfbI/ShSGeLJL0fvzPlLPsJYvBMldp1DxCdyd+1fbO6Zw0nRno2rqGMnMQktzY3XwZ2o3fhwnsH+BqYtrE1N0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLYRpit8/LbseAwPeNqAz0ZJHiB3J/0+oGZPfBiNH08=;
 b=Y2QiFKekvgF7UQ3AAjiT4vARgkOJ9xJC39aONHOJwaM9AlY04EgFjNKIKqEkjWrZBIShb2FDaQ3nrUfUL/Rc61BsMxTN9SCq2+gkZbPNv0Lm2QBhFsbnltLb3z47+d4z18Bs6KWsQY4kONf+u+oEgqra8phZtSCxBp9wJqwEicJMPHBxh5l/ldksedgyzSyrNcPLBjTiZhsceyEKTVqGbqspr8Hs2M9inc9ldILN8vvjbT5bEU2gbuPyjBYSWtGGAJBBzdiIyJnIkjTi4Synu+Vi2qwMbvvdZCG2tM2qKN4ON2Zdxu1zTryWAyJVyXv7zEwaSNhiuhDnG/DNRZipbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:50:11 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:50:11 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/1] mei: Remove redundant pm_runtime_mark_last_busy()
 calls
Thread-Topic: [PATCH 1/1] mei: Remove redundant pm_runtime_mark_last_busy()
 calls
Thread-Index: AQHcRzam/E2y17SVPECr0RO8LbHBH7TV4Jbw
Date: Mon, 27 Oct 2025 11:50:11 +0000
Message-ID: <CY5PR11MB6366BAD25DE80FCE1ED53405EDFCA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20251027114118.390775-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20251027114118.390775-1-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|MN0PR11MB5986:EE_
x-ms-office365-filtering-correlation-id: 45b2bf7e-22d2-40d9-cfdd-08de154efbf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZVZ0MzFKNjVHMVhscnBEbmFtekdoM1RTVXVVNnNVbmVYNXFjRmdKTE9zR1NC?=
 =?utf-8?B?ditha1NNR1hmTmNqUHM1UzI5aDQ0Vy93L245ZlpzOWhqTCsrYllzNmVIZlg2?=
 =?utf-8?B?VUpOeTN3Y3BNbkFDTkFVaXdENDJwRnpRbFU4aDliVW1CN3h3bFk5b1F3UUU0?=
 =?utf-8?B?YUpqWExrajc4WWhGRTV0Q01FUUloZHRVWTZZUDBSbmNlM3JlQ0cxeTdVQ2wz?=
 =?utf-8?B?Y0NSRjB2amtXNVJycUNPZFloU1AwNVZSTGdhaXhjS3NQS2xueTBUdnBQSWNN?=
 =?utf-8?B?SFdTUjUxeEN2UXhPaFRSYlZvZUlrRDFqckZwbVMrUGRhM0lBcCtUaktVcjNi?=
 =?utf-8?B?R0pYT1VyMUtwbjR2aVdacmpQTXVWbWhSWXQ3djJOSTNXUXJHYUliOUt5SS9J?=
 =?utf-8?B?dEZuaGdNTlZUQjRJaW9sTnpEaHB0c0hrU3JJQkZJYnN4RHd0dmtqdkxtQXYx?=
 =?utf-8?B?c1FmNHE1aWJ3dGQ0aldxdWJXUHYxMy9uVCtnRkptQUpzemsrVXcwdGtCRFhj?=
 =?utf-8?B?WkZzMktYUkx1REY0NW9yQjFQMVhTMVR1Z2xYQVlEZlhIVStwTnlCanBoVWR5?=
 =?utf-8?B?emR2SDA3NmZ4YXRUNEE0RXNmd0NRZjcyVmxsTTcvaXVBam5lcitYUlNXUDhG?=
 =?utf-8?B?M21reWdwdDZleUMzTDdpWlVBRG5KWHp4UFMxQkNsZmorNDlvVExaUnZuMzdJ?=
 =?utf-8?B?djJtYkVBbzNXN256RHRqV2tGd0xOMkRPNjYvcUt4RWlpNFRRWlRlbVJaczVa?=
 =?utf-8?B?YzVrMmZCYldaTmhObWs5TlZJVlh5d2JKRDFIWndiN29OdFY0eksxbzQ5RTRk?=
 =?utf-8?B?aURmMlV1eVNjWnRCekZFU1VZcCsrMSsyUXExbzh0ZzNuUDRpa0xteW10cXNk?=
 =?utf-8?B?R3RXWUhsU2lsZUVDUStHRTR2TGp5M0tqWjlvdHoxME94VVR2NDlEWW5HT0NB?=
 =?utf-8?B?TmM2YWpGQlN1V0VqdFBCVC80L3hsWlM2YWhEOVlvL1R2Y1lsMXBaNnV1UDdS?=
 =?utf-8?B?amt2a0E3WC8xOGFvWTRvYmlEQ2crTXAreWc3YUFUekEwb0ttVlRnWUZ2Uk1K?=
 =?utf-8?B?cTRuYytPNTN4VlUydFRiQlRnUXlMaWNmamFuc2JxREtwMVd6ZVlYbVFtcStz?=
 =?utf-8?B?NVBZbUc2bWlWVnBUYmtsTVVVdFp2bFZhYmRWZUtmRFZOazEyRkpia3R1WVVo?=
 =?utf-8?B?Y1pPQVNoR3F5c1lvMCtMdGRBZkJPVC9KejkwNU83WE80Y29QUi9Jby9WWmFt?=
 =?utf-8?B?UHFjaUFCOGdrZFpZQ2JqYk5lUDM2T3hLcHg1ZktsSnJoQVZZdWl4SUJ1dW0r?=
 =?utf-8?B?UDNBcWIwQ3FENS8yd1VNbi96cUdyR3dFN2R2VG5Xbi9FTWY1NTlFYmp0M3c5?=
 =?utf-8?B?SlVtQWFMWDRwKzlIR01HaWpGZ2ZzdFRPYVMxRC80cUM5d2ZZUGZST0dPOGFJ?=
 =?utf-8?B?NnVmUTNaanZWSlBVVlZyRUxvMWtGdkM0bDAwQUp2NnJVbG5JZFpoZ2VRVmJa?=
 =?utf-8?B?bHVQMVpNNWJnMU5SWVEvQVhranAzQTQzd0RTU29xSVpjd255OTQycXYvdUVi?=
 =?utf-8?B?Uk5vMVJvUHNCTVRxMjRZcGNTZTBCQkc4dENzU0xiWUI1Sk8zeUdhOG1lSHdZ?=
 =?utf-8?B?NE1qaVN5dFZOU1VwTHBlSXg2dHR6M0d3dVFqeEdPcHlaUW9pR1RzWEQxblJI?=
 =?utf-8?B?VVM2blI0SlNhSk5uUDRlSnRXTCs3bVlFT29ZWFhJUW5SZWpwV2JZZVVhVWRO?=
 =?utf-8?B?cXAzZHA2c1JneVhXREVhR21XRHR1azkvTnZTUUF1bkdqd0ZoTFNkQy8xVDBk?=
 =?utf-8?B?d2huS3E4UzJDWmlxVkRTM1krVXhYT0JvQThDVWVlNGdwYjV5aTZWekV5RFZV?=
 =?utf-8?B?S3Y3WWpnN3dINTl4ZHBlaVVJVVFGSnVDRlE2UGt2Wm1vREhpWlhBRVhvbnc4?=
 =?utf-8?B?TjkxVUpDcjkvNDU5SytsZGhQYm9kbHJlV0thYXQwakoxWGUxdjMzeVlLMktw?=
 =?utf-8?B?RmRseitiUDVNZWdaTW9wUENXMVZ1Vk9CMnVtNVIzTmFPQ3ZNRFFCajNCV2dH?=
 =?utf-8?Q?aR6ose?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFFCQW5KdmFiY2l1SmVSeDJVQ0JVYXhZQ2psWHBUT1VTS2tiUXhwUFJEbWpr?=
 =?utf-8?B?M1ppQkNYR0tlTnErb1lkelpOZnViMGtYaUZHbnZaRGFtNlJocGVvUkpsdjdE?=
 =?utf-8?B?UGd6NHlCeXlJV090clFrR2YzNTd4RU56Z21TMVkxMkIvZHg3Q0E0U2pVZEhH?=
 =?utf-8?B?R2xZQWtKZTlTcXZ4RE9QY3lPQXJVZGtsNGI5L3JhWTBTREdYZ21yWTk5eTZY?=
 =?utf-8?B?RTdreG4vL29EcnJYR3g0cVJOVFFUWTUxV2dlN09rN0VEb0lJUDB0K01TR1Mx?=
 =?utf-8?B?c0tVMncvRmVMTDNBTkQyUlFMbml0eGFrSU5Lbi96YlhyVFdpSGpuVDBta3Vr?=
 =?utf-8?B?QnRjdkdVTVovaGVoaXNvcG1FSmdXaTRtQ0tUcHRPSUxPcyt1TjFSWDB6aDNJ?=
 =?utf-8?B?QzVSaVV3OWNnaXFuckFERXJEOUJvNlV1S3JvcUVWYWpxOVZWZFJoTG13VEJp?=
 =?utf-8?B?ZWltQTBCS2xPUElpbXZ4c3kyZFVud2h6Q01tNU1YVW5YWnZEUS9WUGE2TEwy?=
 =?utf-8?B?d2hoaU5jbThadzMwZzBBcjVQWkREL21zTFU1SUJkRVRjSlFmNVRQNmJHR0Zi?=
 =?utf-8?B?elFybXhnWmltTjV2eVVxdi9SSmIzeFJVTTRzazloa1Q5WkpqMGlzeXRsaTY4?=
 =?utf-8?B?eXg5a084cnpMdkMzN2pMUzZCenRkQzlRZ0VwRTNFNDhJZnRSQkdHVS9MR2c5?=
 =?utf-8?B?TllUaHpGUGpPUE1JSkVaZWNBV2RPOGJES2k3K3Z5cUwxQTlTYU5SRXlieWZP?=
 =?utf-8?B?RTJLbXhKTTdjbm5WcFRhekdBbzY1djZvbXVEL2RZU25rV1NuenJKbHkvRzMy?=
 =?utf-8?B?d0oyQ3hUV2FMMkNNa1ljb3lzRDdxYlZIdDRQWmhoamZXUFN0VmhVTklyNG1M?=
 =?utf-8?B?MVZGRzV0TU8wREs2c251UVlzQkhJQjZ1cFNNckhtbElwcmw2b045WVhsejRo?=
 =?utf-8?B?c0E1dnlOOVB2SzJnSGhLcXd1Z0d4QVRYekRQNG9OcCtKcmVwSWZRZ2NnSU5Y?=
 =?utf-8?B?TGxmNVJNMWVNblhCaW1uUitFNnhOLy8veW11eEtFMzdBWjc5ZzBqanNYd1ZL?=
 =?utf-8?B?QUUrT3NiTENCRWhRcDJNV3paK0NqUUdqTlNNMWlsV1F0dCtmK1JzQ296UWJw?=
 =?utf-8?B?Z0Y5Ump2bVRMckdHK0U2UUdRM2t1T3M3b0hFTGErK2VRZGtWbjhtSTNyYTNB?=
 =?utf-8?B?WWhjMlF2Y0RBTTBuUTZhK3RwU0h2UzNFVmgxUUZ2NjAwUWlvUHRUdEtMYjZo?=
 =?utf-8?B?eGVqeXZhK2FVRGh6WDlONGlrc2liR04xMXlSSXFHa3ovQ3RBSUYvQTZ6Ly9H?=
 =?utf-8?B?VGo0TG9NeDVrOVU2bXdKZTNDaGdHZEllN3N5YWFrc1MrM0V0cmZneEtJay9F?=
 =?utf-8?B?UXcwa3ltR25zTmZGTHZJN3BMbENvV2pTVjA5bFV1L2RmMEJ6NTBWUHV1bkhC?=
 =?utf-8?B?bWlQMlp6MytsT2NaMEFxZjdqa25DUHAwZVJEbUlKNjRTQmErN1l0L09qRTIw?=
 =?utf-8?B?eHFwbkJzQUNlQS85eHdUdXZXdnVIR2tpZHhqMElVNFRXWGlPb1RnRjhZbGpr?=
 =?utf-8?B?bGVNRHYvWFVZUGZ4eTl2ejlqVEIwUytqKzJzQ1lGTnNmV1c3WUltaXVHMEZp?=
 =?utf-8?B?cDNzbWhKVUxmZXhSUGxBUVgzVkMxVENSeDdKd2Vvb1h0N0wyWTVmK3JDVEM1?=
 =?utf-8?B?aU1DVWk1cktPMm9TeUV0dmpoWSttdkxlZ0NUbUV6OTE3VEpiaXB0YzFzb0E2?=
 =?utf-8?B?N2szSmtwa0tDcG9CTzBPQTE2aDZ4T1oya21MR2o0MmovNFJzSTZjcEM5dXp5?=
 =?utf-8?B?SVNjMCttdTJvOW50OWlVa3k4WnR4RDk4QmVoYUlrRnpPMVV0TG0wYlhLTTBP?=
 =?utf-8?B?SDdvdHFsdXQ0ZndxSU96Ui9JeTVzNDY4M1FnbXJUS3ZmdDB1VXpycmtkMFMv?=
 =?utf-8?B?L0JRTmo4RW9uSzBmWU9xaHBnckd1aWIxMGw4NXVvem84L2d0Q0NackVTbStn?=
 =?utf-8?B?MVhmM2huQVFxTkxYT0FxR0wyNE1sNzFjSXVMUEh6UER3eWN0ekJpNkFLVS81?=
 =?utf-8?B?UXNRMmVOOVZmQUJ2M1hnYzdmd084UzFFRlV3bG1aRzFkZktYTFpGclNENGFy?=
 =?utf-8?B?c0ZFYUk4UG1jZ00wUkNOWXMwRXRxMU5DRjMvWVd2L3pQTkJ1ZjRCeW9MMjV6?=
 =?utf-8?B?R0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2bf7e-22d2-40d9-cfdd-08de154efbf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 11:50:11.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQJXyG0gJgwBrC64DhiER77hBCKGVo+UwgA4PbpybOZ7bMWqF3J/n2ttJ4WHJkBemGcwZ5LLFrW3/zBqoX3EAF0EUrosl1LiiD6imIaadKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggMS8xXSBtZWk6IFJlbW92ZSByZWR1bmRhbnQgcG1fcnVudGltZV9t
YXJrX2xhc3RfYnVzeSgpDQo+IGNhbGxzDQo+IA0KPiBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVu
ZCgpLCBwbV9ydW50aW1lX3B1dF9zeW5jX2F1dG9zdXNwZW5kKCksDQo+IHBtX3J1bnRpbWVfYXV0
b3N1c3BlbmQoKSBhbmQgcG1fcmVxdWVzdF9hdXRvc3VzcGVuZCgpIG5vdyBpbmNsdWRlIGENCj4g
Y2FsbA0KPiB0byBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KCkuIFJlbW92ZSB0aGUgbm93LXJl
ZHVudGFudCBleHBsaWNpdCBjYWxsIHRvDQo+IHBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koKS4N
Cj4gDQoNCkFja2VkLWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50
ZWwuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IFNha2FyaSBBaWx1cyA8c2FrYXJpLmFpbHVzQGxp
bnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jICAgIHwg
MTQgKystLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMgfCAgMiAt
LQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvY2xpZW50LmMgYi9kcml2ZXJzL21p
c2MvbWVpL2NsaWVudC5jDQo+IGluZGV4IDE1OWU4Yjg0MTU2NC4uNWRjNjY1NTE1MjYzIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jDQo+ICsrKyBiL2RyaXZlcnMvbWlz
Yy9tZWkvY2xpZW50LmMNCj4gQEAgLTcwOSw3ICs3MDksNiBAQCB2b2lkIG1laV9ob3N0X2NsaWVu
dF9pbml0KHN0cnVjdCBtZWlfZGV2aWNlICpkZXYpDQo+IA0KPiAgCXNjaGVkdWxlX3dvcmsoJmRl
di0+YnVzX3Jlc2Nhbl93b3JrKTsNCj4gDQo+IC0JcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShk
ZXYtPnBhcmVudCk7DQo+ICAJZGV2X2RiZygmZGV2LT5kZXYsICJycG06IGF1dG9zdXNwZW5kXG4i
KTsNCj4gIAlwbV9yZXF1ZXN0X2F1dG9zdXNwZW5kKGRldi0+cGFyZW50KTsNCj4gIH0NCj4gQEAg
LTk5MSw3ICs5OTAsNiBAQCBpbnQgbWVpX2NsX2Rpc2Nvbm5lY3Qoc3RydWN0IG1laV9jbCAqY2wp
DQo+ICAJcmV0cyA9IF9fbWVpX2NsX2Rpc2Nvbm5lY3QoY2wpOw0KPiANCj4gIAljbF9kYmcoZGV2
LCBjbCwgInJwbTogYXV0b3N1c3BlbmRcbiIpOw0KPiAtCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1
c3koZGV2LT5wYXJlbnQpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldi0+cGFy
ZW50KTsNCj4gDQo+ICAJcmV0dXJuIHJldHM7DQo+IEBAIC0xMTY3LDcgKzExNjUsNiBAQCBpbnQg
bWVpX2NsX2Nvbm5lY3Qoc3RydWN0IG1laV9jbCAqY2wsIHN0cnVjdA0KPiBtZWlfbWVfY2xpZW50
ICptZV9jbCwNCj4gIAlyZXRzID0gY2wtPnN0YXR1czsNCj4gIG91dDoNCj4gIAljbF9kYmcoZGV2
LCBjbCwgInJwbTogYXV0b3N1c3BlbmRcbiIpOw0KPiAtCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1
c3koZGV2LT5wYXJlbnQpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldi0+cGFy
ZW50KTsNCj4gDQo+ICAJbWVpX2lvX2NiX2ZyZWUoY2IpOw0KPiBAQCAtMTU1NCw3ICsxNTUxLDYg
QEAgaW50IG1laV9jbF9ub3RpZnlfcmVxdWVzdChzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gDQo+ICBv
dXQ6DQo+ICAJY2xfZGJnKGRldiwgY2wsICJycG06IGF1dG9zdXNwZW5kXG4iKTsNCj4gLQlwbV9y
dW50aW1lX21hcmtfbGFzdF9idXN5KGRldi0+cGFyZW50KTsNCj4gIAlwbV9ydW50aW1lX3B1dF9h
dXRvc3VzcGVuZChkZXYtPnBhcmVudCk7DQo+IA0KPiAgCW1laV9pb19jYl9mcmVlKGNiKTsNCj4g
QEAgLTE3MDIsNyArMTY5OCw2IEBAIGludCBtZWlfY2xfcmVhZF9zdGFydChzdHJ1Y3QgbWVpX2Ns
ICpjbCwgc2l6ZV90DQo+IGxlbmd0aCwgY29uc3Qgc3RydWN0IGZpbGUgKmZwKQ0KPiANCj4gIG91
dDoNCj4gIAljbF9kYmcoZGV2LCBjbCwgInJwbTogYXV0b3N1c3BlbmRcbiIpOw0KPiAtCXBtX3J1
bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5wYXJlbnQpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X2F1
dG9zdXNwZW5kKGRldi0+cGFyZW50KTsNCj4gIG5vcnRwbToNCj4gIAlpZiAocmV0cykNCj4gQEAg
LTIwOTIsNyArMjA4Nyw2IEBAIHNzaXplX3QgbWVpX2NsX3dyaXRlKHN0cnVjdCBtZWlfY2wgKmNs
LCBzdHJ1Y3QNCj4gbWVpX2NsX2NiICpjYiwgdW5zaWduZWQgbG9uZyB0aW1lDQo+ICAJcmV0cyA9
IGJ1Zl9sZW47DQo+ICBlcnI6DQo+ICAJY2xfZGJnKGRldiwgY2wsICJycG06IGF1dG9zdXNwZW5k
XG4iKTsNCj4gLQlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldi0+cGFyZW50KTsNCj4gIAlw
bV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChkZXYtPnBhcmVudCk7DQo+ICBmcmVlOg0KPiAgCW1l
aV9pb19jYl9mcmVlKGNiKTsNCj4gQEAgLTIxMTYsMTIgKzIxMTAsMTAgQEAgdm9pZCBtZWlfY2xf
Y29tcGxldGUoc3RydWN0IG1laV9jbCAqY2wsIHN0cnVjdA0KPiBtZWlfY2xfY2IgKmNiKQ0KPiAg
CWNhc2UgTUVJX0ZPUF9XUklURToNCj4gIAkJbWVpX3R4X2NiX2RlcXVldWUoY2IpOw0KPiAgCQlj
bC0+d3JpdGluZ19zdGF0ZSA9IE1FSV9XUklURV9DT01QTEVURTsNCj4gLQkJaWYgKHdhaXRxdWV1
ZV9hY3RpdmUoJmNsLT50eF93YWl0KSkgew0KPiArCQlpZiAod2FpdHF1ZXVlX2FjdGl2ZSgmY2wt
PnR4X3dhaXQpKQ0KPiAgCQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZjbC0+dHhfd2FpdCk7DQo+
IC0JCX0gZWxzZSB7DQo+IC0JCQlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRldi0+cGFyZW50
KTsNCj4gKwkJZWxzZQ0KPiAgCQkJcG1fcmVxdWVzdF9hdXRvc3VzcGVuZChkZXYtPnBhcmVudCk7
DQo+IC0JCX0NCj4gIAkJYnJlYWs7DQo+IA0KPiAgCWNhc2UgTUVJX0ZPUF9SRUFEOg0KPiBAQCAt
MjM2Niw3ICsyMzU4LDYgQEAgaW50IG1laV9jbF9kbWFfYWxsb2NfYW5kX21hcChzdHJ1Y3QgbWVp
X2NsICpjbCwNCj4gY29uc3Qgc3RydWN0IGZpbGUgKmZwLA0KPiAgCQltZWlfY2xfZG1hX2ZyZWUo
Y2wpOw0KPiANCj4gIAljbF9kYmcoZGV2LCBjbCwgInJwbTogYXV0b3N1c3BlbmRcbiIpOw0KPiAt
CXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5wYXJlbnQpOw0KPiAgCXBtX3J1bnRpbWVf
cHV0X2F1dG9zdXNwZW5kKGRldi0+cGFyZW50KTsNCj4gDQo+ICAJbWVpX2lvX2NiX2ZyZWUoY2Ip
Ow0KPiBAQCAtMjQ0NCw3ICsyNDM1LDYgQEAgaW50IG1laV9jbF9kbWFfdW5tYXAoc3RydWN0IG1l
aV9jbCAqY2wsIGNvbnN0DQo+IHN0cnVjdCBmaWxlICpmcCkNCj4gIAkJbWVpX2NsX2RtYV9mcmVl
KGNsKTsNCj4gIG91dDoNCj4gIAljbF9kYmcoZGV2LCBjbCwgInJwbTogYXV0b3N1c3BlbmRcbiIp
Ow0KPiAtCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5wYXJlbnQpOw0KPiAgCXBtX3J1
bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGRldi0+cGFyZW50KTsNCj4gDQo+ICAJbWVpX2lvX2NiX2Zy
ZWUoY2IpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9pbnRlcnJ1cHQuYyBiL2Ry
aXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMNCj4gaW5kZXggM2FhNjZiNmIwZDM2Li4zZjIxMDQx
M2ZkMzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMNCj4gKysr
IGIvZHJpdmVycy9taXNjL21laS9pbnRlcnJ1cHQuYw0KPiBAQCAtMjI5LDcgKzIyOSw2IEBAIHN0
YXRpYyBpbnQgbWVpX2NsX2lycV9yZWFkX21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gIAkJY2xf
ZGJnKGRldiwgY2wsICJjb21wbGV0ZWQgcmVhZCBsZW5ndGggPSAlenVcbiIsIGNiLT5idWZfaWR4
KTsNCj4gIAkJbGlzdF9tb3ZlX3RhaWwoJmNiLT5saXN0LCBjbXBsX2xpc3QpOw0KPiAgCX0gZWxz
ZSB7DQo+IC0JCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5wYXJlbnQpOw0KPiAgCQlw
bV9yZXF1ZXN0X2F1dG9zdXNwZW5kKGRldi0+cGFyZW50KTsNCj4gIAl9DQo+IA0KPiBAQCAtMzEw
LDcgKzMwOSw2IEBAIHN0YXRpYyBpbnQgbWVpX2NsX2lycV9yZWFkKHN0cnVjdCBtZWlfY2wgKmNs
LCBzdHJ1Y3QNCj4gbWVpX2NsX2NiICpjYiwNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+IA0K
PiAtCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGV2LT5wYXJlbnQpOw0KPiAgCXBtX3JlcXVl
c3RfYXV0b3N1c3BlbmQoZGV2LT5wYXJlbnQpOw0KPiANCj4gIAlsaXN0X21vdmVfdGFpbCgmY2It
Pmxpc3QsICZjbC0+cmRfcGVuZGluZyk7DQo+IC0tDQo+IDIuNDcuMw0KDQo=

