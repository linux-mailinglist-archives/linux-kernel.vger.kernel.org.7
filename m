Return-Path: <linux-kernel+bounces-771306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848DB2855E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773D1BA1902
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F463176F3;
	Fri, 15 Aug 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwjlMjk7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A4E2F9C3D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279980; cv=fail; b=DTHCqaNpvbTEe6D+2gi8KE3eUnYq+kT/aL+QkHS3DrZsef0phtf+OQMMtDH4JyzM3XbjTA54x0qnmT361qXrO8zL6WzhHT0TUuIcywMFw+do6z/bPsvPmfwa/HFvU3Pey3qNbh0PwwbQG4BH/AEvK6/4TgkXIETZTRM+yUiQhZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279980; c=relaxed/simple;
	bh=/NHSXut69k6YQbDZgO4XRtC/h0SBmyGWYT3AaS2NceE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OwrFwIsrSYadCSf4enSVpwSsMEPLl2i9F52ZXpygmY5dPBXrXxl+FmXMZB4dSwTv3LspXlo3FeMwJ5QbyBpe3VNSYR0B2eqHRFpHNRqKAeGhRjo4YED+rKCk9d5jlUm2OVDXpMr5LOq80fWOdmIe1Ztf6hQVaQe3b2XBzXQV3b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwjlMjk7; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755279979; x=1786815979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/NHSXut69k6YQbDZgO4XRtC/h0SBmyGWYT3AaS2NceE=;
  b=jwjlMjk7xSqgqjSv5Jfms8GCVbQAZ9ffRS/wqa2EEEBeU/y0mgLbkiaQ
   cuOFNnjXuRlwNOs7O12pfrklZUcYfP9ZkH/UkhNbwnL6su8AWp03+MlVM
   gBuv/dMKmCpaq2cI2tPfy6QlxVSRdefylejiV2COEkNKqatxjmoSVK0vx
   G9UvimLoKdLMLTLXM+SLX/OqPqNcKL4Z223A07vKO56j+YworZQUJrhIH
   E3qRBTTU2K2fp4YcbbSl7B21kXvN/2LF7ZWbqtOB6Gt/7u/082zPnEitg
   Hmpp27baJeSVqfxIgz+DKM6gtt6R5y06I//rTRsVvLUGMtGzD+zcUbLcT
   g==;
X-CSE-ConnectionGUID: RiAvzmtdR/mV17E7S6R0SQ==
X-CSE-MsgGUID: XmwEEdonQRe/rwuEoxFLAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="61236583"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="61236583"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:46:17 -0700
X-CSE-ConnectionGUID: /clhpoqVTWSL630KSiHWnQ==
X-CSE-MsgGUID: VOQdEl7/TdCvG4fM2ZKr1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167310739"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 10:46:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 10:46:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 10:46:16 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.81)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 10:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfRSOcS6V3sYOO5kVqulRw6dleOzI328Ij3YSiCkeyG99rCeWhuz4KFxfZ4BXl8iUptWKwA+5+KQ9KeDWbZ1eUnjbPTQImRvQNB8XTB2if9pbbH5XToOwginLbrOol5AqwMl2GykFLzgOvSG9t3zdT0diuAzPp2zTv8hR4I0WmQtj+khAIaVFgMY2CNu/X96WWMB/ypmWOMd1n/mDOi8znh3v/7VNKMXMiDqDXSGNXVBO4TJk0IMLL+1mBKpLjB+An+At2DXijaqVPdbes+d8jdm4vJwZ2M/L70ckDdWybgqbOGc7nV4GbbkX3rge6KdIhWcV2B5AtYomd6vWZbBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NHSXut69k6YQbDZgO4XRtC/h0SBmyGWYT3AaS2NceE=;
 b=DRoSmqBgP6zhKjbPJbPDcKGxbemWx1X/kckIkDD5KjzmzALulkgExkI8ONYyfUGQ1Jaazepv3nmN2NhRLfNnm4osMcOMLuiGwuDwddj+z0FI+Vl/+XeTUnYExt6aFT1nvFi4u3kIeVhKX4PYlBuorcmO09qDJPghsOPQPOflXgld+4ttbdWV639DRK4aMF0iKEvVUpF7/5GJh31qt2FNIG3osrnn6jq/i2jaw60YMfhJbr+rsUdfZKM2Gsd/ZAGBMtdVyHl2UhQmHR0DRtAMssK+Y0awXZdpxGIc48tpoOuuonVGho+dck1ZS3EdtGNLMSo4lQmIOH7WG7Jctj1g/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 17:46:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 17:46:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "oleg@redhat.com" <oleg@redhat.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "broonie@kernel.org"
	<broonie@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Topic: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Thread-Index: AQHcDQSAsgd3KMgRVUK3LV4xePzdnLRiYLSAgAFCR4CAAEOtgIAACeoAgAAOYIA=
Date: Fri, 15 Aug 2025 17:46:13 +0000
Message-ID: <e802f42ac5d6cf4f5ac5e5693357efa67b2af85e.camel@intel.com>
References: <20250814101435.GA17362@redhat.com>
	 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
	 <20250815121702.GB11549@redhat.com>
	 <cf6441dca8fe5d7c568d01e43adf715e9a35a9ba.camel@intel.com>
	 <20250815165445.GJ11549@redhat.com>
In-Reply-To: <20250815165445.GJ11549@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM3PR11MB8713:EE_
x-ms-office365-filtering-correlation-id: 59531704-038a-4a43-bd5e-08dddc23a0ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SHVWYjBIdEJUR1lMU3F5a1pGQ09IN1Z3S1AyU0UybHJBclpMdG9JTW5ibGQ1?=
 =?utf-8?B?TERaK1kvZkVlMENBQWpZcUxsSlhCVVo1ekNTYXFaVlFFbWRqSFNhZ0JrTzMv?=
 =?utf-8?B?VTI1R0xXY0E5ZXIxTTFMdXcyZms4aDFvV1d6TS9ubGg3VEFTMnVtcHMzQmI2?=
 =?utf-8?B?N0E0OFZnN0IycVVWT1NVbm5KWDJOUjVrRE5xVDhJQlloS1BPTFRqYU9CSjMw?=
 =?utf-8?B?WnArZEtHdEt1Vk92eXgzcDJBbkpMcHZxS25GcUpQc0FZUVhyeXFwdDc1Rlh6?=
 =?utf-8?B?WkNnanBhbng4MXdOT0phd2cvazIrSGdJSkVUUmRWcllvTWVwclNoQ3daT2FM?=
 =?utf-8?B?ZHFER2ExcE1YY3U2M0hFZlF5cDAvM0RCdlRnbDRQTkIyZW1TenJoTDQvMVBW?=
 =?utf-8?B?dFJYYStHMWhYVDlROVMxd2ZyeXJLMUhiaFpMQ2ZvWUd6REZ2NUd6bTJ2UGp4?=
 =?utf-8?B?M05INi8wNUV1STFDSmhXb2pmd29BUXZDSHFKdm51NEhjZjZOdUJYMUtOczFP?=
 =?utf-8?B?THpLZUYvSHg1RzZRUE9Md3BhOHZSM3JacVVoK3Nvc24rWDNUZVkzV0RJb09s?=
 =?utf-8?B?SXdNdjRjS3hTUUh1ZWZFVlNwbklVN2VxTTIvZ3VoUVNjUHRyWUdzNTlzYU5U?=
 =?utf-8?B?NW54eGxqYnVIc0hneU5FMHBYYUJWL1d1Ui9BYVd2L0tsbkp6Sm1VbnpKaUkr?=
 =?utf-8?B?SkpFaU1idUFJUXVlZWZjQkVDOXpDSC9vNFNEdUdwY0ZsNjloZHM4N3JIZ2Ur?=
 =?utf-8?B?aWZPeUYvQjBYeTBObFdXQ3JBUVlMbGtsMGNoY3g5cE9kVTk3QTkyOW1ncjl0?=
 =?utf-8?B?NHdaenFCNFhoU25GVmdUK1lqZTJjT04yT3JQMC93K1ZqdFlteHU0d2pUc1A3?=
 =?utf-8?B?QUlZMXVzYzBtMHZJK0pzNFhoRzhtN0FvNGFDZkVYbnlFNWcxZmRUeVJnUjBI?=
 =?utf-8?B?anNaWnNKbmZURlhrelErVDdNWVdMOExqYVJJQUo4VklrYnJsSG0rYWdTaFNl?=
 =?utf-8?B?QmswUDZrdFlleE5BUG45L2JPdzQvaVh1Vnl4aG0xWU44bTcwK2cyUDJNTlFJ?=
 =?utf-8?B?OUhvZ3ZGeGIrSjZoVGtFTy8xWUZZbklRN05YWVUxcWZKa3BlZGc4THFLamJX?=
 =?utf-8?B?L3hNSkF0Uyt0RjJqMGtaNUplSmJid2M1L2t0cUhsaEU2R2Q0czNUMlJDSGZl?=
 =?utf-8?B?TVpVT0xKSHc5UWkzbGxiYkJLNGdoV3lHazh6THZuVGFtZ21Wc1Q4Y2lwTmxt?=
 =?utf-8?B?TDArUWhWSE1QRk10a3duVUtMQTk4V0oyeG5DSWVlbWQvNzU3djVoWjhRRWI2?=
 =?utf-8?B?V1owaGRtRWl5di90ZnNmWFJFVGtkUFlac1VKNEhRck9LRXM5cmRLVFozcDly?=
 =?utf-8?B?UUFYbGpmTndwemlHNmdyUEF5SkFsRVkyWjhjYjBQOWdSWThlWjhpZEZ0bzZx?=
 =?utf-8?B?NEk3YjdpUmlLcTVUbVB2UG9LRWNRbXE0ZC9NWDU2VVpNa3liQ1QxeGZML3Y5?=
 =?utf-8?B?aHVoUVFHcEFndWhuR2JWYXZTeXlIOVdDWDdLaWdydXVLT0NLR3JRUDhkd3BO?=
 =?utf-8?B?MDhzUmtWbU9kQXMzVWhTamJLZkJqYkNNUmMvdG1xdUlsV3FrTEt6UVV4ak4w?=
 =?utf-8?B?Q3VmRjNKZ0pNVHE5b3dhWDU0WEp6RXQvYk0rU1VYZzhlQkZ0azhsK1RTRDIz?=
 =?utf-8?B?cnhrSU8yUmljK1A1SjdXMW8rUzArbUtqOG1SUkVHRVJXNzd6T21IWFAraFgy?=
 =?utf-8?B?ckpmSGVLYUVqczRuWUVFK3VCRnMyVVBHUFJ1WlIzcDZrdTJHTm04T1BXRm5t?=
 =?utf-8?B?cE1xTWhJd1I0M1A4RDZ2Uml3VzBQVDJhQlcwcG1OWWEvbThiR0pCV3p5c2xq?=
 =?utf-8?B?ekdWUHRXcnU5WUttYVpUdzI0L3R0bmN3OEREYVdoWUV6TnJBZlBiQkdDcGx5?=
 =?utf-8?B?ckQxZ0ZPLzNOUHFGYmsyMEVuZUk2QWgvUXc0QTVHSnNJRURkU0RZZzRjSWM2?=
 =?utf-8?Q?jjMyQN/seUBLMhIEmBtbXIrMmYVDrU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekJzWGsyMU9pNkVIQktkdWszQ1RDbmIrbFZza25nelVWY1hXRXp1ZUd0ck9R?=
 =?utf-8?B?emF4R01uZ0VWb3cyRDhuazdEVDcwMkROTVUraVpNaFI3QXUyeWRCU2hLOVpE?=
 =?utf-8?B?engwU1Y5Vkd3S2c0WWNtdUwwYjUwaUlsdzZoUHFyQ0M1UStjTGc4NWUzN3cz?=
 =?utf-8?B?OFYyOHM5U2R1VmJNSTVabWZtVDhoQzBUVDFZcERGalZ4UVJwVzB5Wk90bHlo?=
 =?utf-8?B?RFYyQUdwSjhIRUM1dTJlS2lQbUtmMUF1a1ZqeitMTCtmNHBvRUZ0UmExbWpi?=
 =?utf-8?B?c3hGb0VacUZCRXhwbkRsQVlPOFl3ZTgzMk1qYWhEcERtQmtyV2VSY3pyVDdX?=
 =?utf-8?B?T3YzbTF4a3pCak03cmozRXlHUGM4MzlFTjg1L0hrMjNXRUpUcTVtaVB3ekVD?=
 =?utf-8?B?czRyUW1ncFNRSlllOFViMzJGWnE1anFKdU1XMVdveE5Rc1UzNWx4ZmZHZmZE?=
 =?utf-8?B?UnJocXBzVU9UL1A1VFVCb2pIcmM1bHgxenBUWk03Tjlib28zVmFUUjN3eHBZ?=
 =?utf-8?B?eFlKbDRkR1FNbDZ0SVBPRWE4Y05wMFczNGFLN3ZmSk1MRERDMmFhSExEZkUv?=
 =?utf-8?B?UFhLOEp6R1Buck9aSnN6VlNZRTZ3TjRRdGJHNThaSFhXOVE0OU41NS8rWi92?=
 =?utf-8?B?czBwS1RIcCt1REkxeFE5Q25McWR0YWh3M2FPeTJmOUd5UlorS3RpT1llQUc1?=
 =?utf-8?B?UC9LN04yQzI2MjU1ZnFITGQ1Ui9vRVhKbFhlM1NJSFZYQ0pNbDM5ZHFsQzFz?=
 =?utf-8?B?T0REUUQ1eFFHcFNvRFhFMHA0Uk5ldTZYZmpZeFB0aUtTb3ovZ0N1Y3l2TkVy?=
 =?utf-8?B?ZWVrZFNBOHowMVVYa2lvK2F0d0c4aHNkUFR1QUF1Y3RKNk01WGg0MVI4NGwv?=
 =?utf-8?B?MFhSTjBBR0wyUnFaRVNHL2ZIY2o4MWdsbVNSWUVsaGtZNTlReWFmZ0w4VlZY?=
 =?utf-8?B?Y0tpdmdaV21RQUxtb0lBdm9FeTZKeTNOSWc4Q0hkQThVMHFkTEF6YThSRVJi?=
 =?utf-8?B?NnBTbzV0U3N1UnBYZWtjeCtldkg2aTdmSm5TZzFmaHd4SmhEOVhiVjJiWE5M?=
 =?utf-8?B?UExZZGVpVGJRSGlZYWdwRXhsZi9hbFRaNGkxa1NKL3R5aERjajAvelQveHIz?=
 =?utf-8?B?aWtJdnVmUXRrNVAyamNneFpRcVdweWozYjA5UWc2b1RkOGFyaU03SGZoa2pB?=
 =?utf-8?B?bytnbXBtOVBwNG5TN2sycGJHeWZqYkhQM2RTVUdQU2loTS9mek41aU1Pb0JL?=
 =?utf-8?B?a0hYMHhNWU5nQTMvZFprTnFRWStoQ0RoUk0vbkdKU1lMNG1XckdjT2tJV2pw?=
 =?utf-8?B?SDloVGsybUZkMlRWR0JBcXlyVlh0TEJ0a2ZPYkh1QmpvZmNrcFhVTTBZeUhT?=
 =?utf-8?B?a3NidTVaZ0FBdForVHpHMlJudzNnUXVGbFB6cDBtQ2ZCaFV3WTdVdytQOHJJ?=
 =?utf-8?B?YkhOV3JOTHp6TEJHa0xYdGlobTZZSVRFQUp1dTYxQ0JaNEtJSlVuT0lMZ1VO?=
 =?utf-8?B?VC9zWXJWSGk4K0ZtY3g3cHdyZ3F4MXNSZzByV3RuRk1PNk5vUWFidklydjBa?=
 =?utf-8?B?OXVnZnBoSkdRRllyOWlmMVdqYi92NGlndkg3VldCbHNkL0R0TUVWR0pnR05h?=
 =?utf-8?B?bFhjTEFYUU9MOGNMTnd0N3IwYVFPTzA0Y01kQWdCME44R01qMGFON0RKcHFI?=
 =?utf-8?B?OGxGMWlDMUtxcFVEM0VTY3VvdDNRUCtBSTk3dHlWSFJ1dkNVdVFLem1yaXp4?=
 =?utf-8?B?a1d3bk5PeENTNXNIZnhjaXVQczdFTi8yT24wR0U2dVA1MU5ES3R5Mk9xWDU3?=
 =?utf-8?B?Y1M1bHdMSHo3T1U4QUl5ek5IaC8zMng2QXozU3hYWVR1VjZRYXdJaFIxWEtL?=
 =?utf-8?B?WjBycEtrbmV4dmNVKzZBLzJEcU5JSWhlNlFGZUNLTWFhN2h6OW1YUis5dHJq?=
 =?utf-8?B?MG8zZzNkVG8xaUx1Uzgrai9BSDhBazIramVlNkUxcCt5dko4ZVNhSS82UE1D?=
 =?utf-8?B?Z0FoYjZxeDFwRG5QY016SVc5U3pWemxqYUQxdGl3bjNZRHFad01JVXBtZEZX?=
 =?utf-8?B?WjJSV2ZscmxoNWdnVEpta0NIdWtyUHRhbDJVUkRzRG5Vems2dlA0Z0lZWnhp?=
 =?utf-8?B?UVhRSC81a3EyRVdob05qNTUxcHJyS2pHczExQmNlRGFZOG8vWi9wUThlTTVE?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6A9461E67D19D4A8617C7F8D788C1B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59531704-038a-4a43-bd5e-08dddc23a0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 17:46:13.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTeZhtJRZuxuC6XSwyUqqvYmLHDLDZQzxL+GBqrm5TaYsMzOv2yXAK1I/rFcLLK1opKRg/hCkX1HeHvurvTuyu0D9/fWehatN2zvbx8xanA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA4LTE1IGF0IDE4OjU0ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiA+IFNvIHdoYXQgYXJlIHdlIHRyeWluZyB0byBkbyBmb3IgUEZfVVNFUl9XT1JLRVI/IFByZXZl
bnQgdGhlbSBmcm9tIHdhc3RpbmcgYQ0KPiA+IFZNQQ0KPiA+IHdpdGggYW4gdW51c2VkIHNoYWRv
dyBzdGFjaz8gT3Igc2V0IFBGX1VTRVJfV09SS0VSJ3MgYXNpZGUgZnJvbSB0aGUgbG9naWMNCj4g
PiB0aGF0DQo+ID4gaXMgYWJvdXQgbW9yZSB0aGFuIHByb3RlY3RpbmcgdGhlIGluZGl2aWR1YWwg
dGhyZWFkIGluIHRoZSBwcm9jZXNzPw0KPiANCj4gTGV0IG1lIHF1b3RlIG15IGFuc3dlciB0byBN
YXJrOg0KPiANCj4gCVRoZSBmYWN0IHRoYXQgYSBrZXJuZWwgdGhyZWFkIGNhbiBoYXZlIHRoZSBw
b2ludGxlc3MgQVJDSF9TSFNUS19TSFNUSw0KPiBpcw0KPiAJdGhlIG9ubHkgcmVhc29uIEkga25v
dyB3aHkgeDg2X3Rhc2tfZnB1KFBGX1VTRVJfV09SS0VSKSBoYXMgdG8gd29yay4NCg0KTWF5YmUg
eW91IGNhbiBleHBsYWluIHRoZSBleGFjdCBmYWlsdXJlIG1vZGUgaGVyZT8gQVJDSF9TSFNUS19T
SFNUSyBpc24ndCBwYXJ0DQpvZiB0aGUgRlBVIGluZnJhc3RydWN0dXJlLCBzbyBtYXliZSB5b3Ug
Y2FuIGV4cGxhaW4gaG93IHRoZXJlIGlzIHNvbWUgY2FzY2FkZS4NCg0KPiANCj4gCUknZCBsaWtl
IHRvIG1ha2UgdGhpcyBsb2dpYyBjb25zaXN0ZW50IHdpdGggUEZfS1RIUkVBRCwgYW5kIGluIHRo
ZQ0KPiBsb25nZXINCj4gCXRlcm0gY2hhbmdlIHRoZSB4ODYgRlBVIGNvZGUgc28gdGhhdCB0aGUg
a2VybmVsIHRocmVhZHMgY2FuIHJ1bg0KPiB3aXRob3V0DQo+IAl3aXRob3V0ICJzdHJ1Y3QgZnB1
IiBhdHRhY2hlZCB0byB0YXNrX3N0cnVjdC4NCg0KRm9yIFBGX1VTRVJfV09SS0VSIGl0IHN0aWxs
IGhhcyBhY2Nlc3MgdG8gdGhlIHVzZXIgTU0sIHJpZ2h0PyBTaG91bGRuJ3QgaXQNCmluaGVyaXQg
UEtSVSBmcm9tIHRoZSBwYXJlbnQ/DQoNClN0b3AgbWUgaWYgSSdtIHRlbGxpbmcgeW91IHNvbWV0
aGluZyB5b3UgYWxyZWFkeSBrbm93Li4uIEZvciBiZXR0ZXIgb3Igd29yc2UsDQp0aGUgeDg2IEZQ
VSBzdGF0ZSBoYXMgZ3Jvd24gZnJvbSB0aGUgY2xhc3NpYyAiZXh0cmEgbWF0aCByZWdpc3RlcnMi
LCB0byBpbmNsdWRlDQpvdGhlciB0aGluZ3MgbGlrZSBQS1JVIGFuZCBzdXBlcnZpc29yIHN0YXRl
LiBTdXBlcnZpc29yIHN0YXRlIGNvbnRyb2xzIG90aGVyDQp0aHJlYWQgc3BlY2lmaWMgc3RhdGUg
dGhhdCAqb25seSogdGhlIGtlcm5lbCBpcyBzdXBwb3NlZCB0byBoYXZlIGNvbXBsZXRlIGFjY2Vz
cw0KdG8uIFNvbWUgb2YgdGhlIHhmZWF0dXJlcyBhcmUgZXZlbiBhYm91dCBzYXZpbmcgYW5kIHJl
c3RvcmluZyBzdGF0ZSB0aGF0ICpvbmx5Kg0KYWZmZWN0cyB0aGUga2VybmVsLiBTbyBJIHRoaW5r
IGVhY2ggeGZlYXR1cmUgbmVlZHMgdG8gYmUgZXZhbHVhdGVkLCBhbmQgdGhleSBhcmUNCmFsbCBh
bm5veWluZ2x5IGRpZmZlcmVudC4gSSB0aGluayBMQlIgd29ya3MgaW4gdGhlIGtlcm5lbCB0b28/
DQoNCj4gDQo+IEFuZCBhZ2FpbiwgcGxlYXNlIHNlZQ0KPiANCj4gCVdhcm5pbmcgZnJvbSB4ODZf
dGFza19mcHUoKQ0KPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FKVnVaWmdZakVNeGlV
WXFAbHktd29ya3N0YXRpb24vDQo+IA0KPiAJUEZfVVNFUl9XT1JLRVJzIGFuZCBzaGFkb3cgc3Rh
Y2sNCj4gCWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgxMzE2MjgyNC5HQTE1MjM0
QHJlZGhhdC5jb20vDQo+IA0KPiBhbmQgNi82IGluIHRoaXMgc2VyaWVzLg0KDQpJIGtpbmQgb2Yg
dGhpbmsgaXQgd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZSBmb3IgeW91IHRvIGV4cGxhaW4gbW9y
ZSBhYm91dCB3aGF0DQp5b3UgYXJlIHRyeWluZyB0byBkby4gSSd2ZSByZWFkIHRocmVlIHRoaW5n
czoNCiAtIFByZXZlbnQgd2FzdGluZyBhIHNoc3RrIFZNQSAod2hpY2ggRGF2ZSBzdWdnZXN0ZWQg
bWF5YmUgd2Fzbid0IHdvcnRoIGl0KQ0KIC0gUHJldmVudCBpc3N1ZSBhcm91bmQgdXBkYXRlX2Zw
dV9zaHN0aygpLCB3aGljaCBJJ20gbm90IHN1cmUgaXMgYW4gaXNzdWUNCiAtIFByZXZlbnQgcHRy
YWNlIGZyb20gc2V0dGluZyBGUFUgc3RhdGUgb24gdXNlciB3b3JrZXJzIGJlY2F1c2UgaXQgY2F1
c2VkDQpwcm9ibGVtcyAoZGV0YWlscyB1bmNsZWFyKSwgYnkgY2hhbmdpbmcgdGhlIEZQVSBkZXNp
Z24gaW4gYSB3YXkgdGhhdCBhcHBhcmVudGx5DQpoYXMgaW1wYWN0cyBhY3Jvc3MgRlBVLXVzaW5n
IGZlYXR1cmVzICh1bmNsZWFyIHdoeSB0aGlzIGlzIHRoZSBiZXN0IHdheSB0bw0KcHJldmVudCBp
dCkNCg0KVEJILCBiYXNlZCBvbiBteSBjdXJyZW50IHVuZGVyc3RhbmRpbmcsIGFsbCB0aHJlZSBz
b3VuZCBkdWJpb3VzIHRvIG1lLiBMZXQncyBnZXQNCm9uIHRoZSBzYW1lIHBhZ2UgYXMgZmFyIGFz
IHRoZSBnb2FscyBiZWZvcmUgd2UgZGlzY3VzcyBzaHN0ayBjaGFuZ2VzIGZ1cnRoZXIuDQpZb3Ug
bWlnaHQgYmUgYXdhcmUgdGhhdCB0aGUgeDg2IEZQVSBpcyBzZWVuIGFzIHRvbyBjb21wbGV4IGFs
cmVhZHkgYW5kIHNvIGFkZGluZw0Kc3BlY2lhbCBjYXNlcyB0ZW5kcyB0byBoYXZlIGEgaGlnaCBi
YXIuIFNvIGNvbnNpZGVyIG1ha2luZyBhIHN0cm9uZywgY2xlYXINCmp1c3RpZmljYXRpb24gZm9y
IHRoZSBvdmVyYWxsIHByb2JsZW0vc29sdXRpb24geW91IGhhdmUgaW4gbWluZC4NCg0K

