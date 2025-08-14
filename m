Return-Path: <linux-kernel+bounces-769320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3CB26CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB677BEB09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5D1EBFFF;
	Thu, 14 Aug 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYM9hnZv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D21C1991BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190020; cv=fail; b=UV7L1o+Vxbyn18rBbz8VyCWvju4RytHPkNI/ccKafUANbO0Od32508PnCuqoTc2wrOVaNxNXvb6epU7+BuWNVqesZun17wfh8d9UfjZAvzCWmEuV3oeAsuX05UUIHoxKmd6rdmEl2+Tgm4E27C1NGNTIhbe7ga4gx1wHRJ2yetU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190020; c=relaxed/simple;
	bh=xQwtux2k3ac0jjM9+oO2q6GR80FVCWYrHnJJoQFzVhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TThX+0gM2Qgw/FTeLHYSVPAVhAjs2k2eepfktsgw/dZqDkNV4XOkDT8dWZbV7pk967FpLmLefquhElLERioHuDtba935Qy6XXMsWhITxxL/fe0gn2t3TKIxk6jC514d6W9I5tUC96ycNewbqxyMb2RAwsr/fQt4HNh8FCBuWQPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYM9hnZv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755190018; x=1786726018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xQwtux2k3ac0jjM9+oO2q6GR80FVCWYrHnJJoQFzVhw=;
  b=gYM9hnZvKtMitcxSLnThv08HZ5A7CIw4MRpmsd/73+XMO8r2tViuG7Jp
   oP/cmhcCNUslu+Y6cXKCormPedJRqDtRe2LbLwiJUwqPCE1ow6rEbMr5n
   XrCRczYrkCqyGeZws3VhhIBNr/Ma4PvN4hWOFxcHOa3D/ySJhgwnQcZCO
   rnURh6i2/8ImRdxmq9BpbPhiUcUmQrMHhWaZUWl1mAu7qUnHhCMeF+PTb
   p39lDcAhCyYT/N2Wcxoar41EoNFl//YvZiFnGk01/4abgx5SI41ZcHQ+R
   a23O6x35/qrN7BkMN6SzZgYXbNlglGjGtQtX7VStHLwtHYENr+pTDtHjK
   g==;
X-CSE-ConnectionGUID: 6pIQ4hhiRRmrF3kuPSK76Q==
X-CSE-MsgGUID: GatTPRE0QTKWVpGN04qmLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61143057"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61143057"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:46:58 -0700
X-CSE-ConnectionGUID: P/b8CmrWRTChoaR4dMgMkg==
X-CSE-MsgGUID: nC1eKznvSE6f4gJuPYgXag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="165989323"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:46:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 09:46:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 09:46:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.40)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 09:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9zq+tpbO0BFuVd/5PD99F7kaZy6tlkJ/Vx8c9iRGVRKUetysgwFyPSZ7sl8z7pvwJMP0IO0cRndRAQ12U8+5RSPm+0uvqlOwChtAOa/ZRhegy+m8sLDbdM7AcxNEfgBfT6kmiBeaXF7N0N5cUM2nEx5OAv3HjMIOvyKicQuqKAkKi2ttqcVbUEw8XBkVJjo7vnfz5K2ibWn15Nmv9fFRf4sEFVYNdxMFmYWptbnDOjpdCqp1cCWE+IpVkXKC/uOk/nRbNbRNOa/2TwsiCmlG/TRuhfNrtohzqEAzy8VbDn1awcG9VWyjrtG/gSxCgfCzZwOb7lOKWhAicDf369Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQwtux2k3ac0jjM9+oO2q6GR80FVCWYrHnJJoQFzVhw=;
 b=eZiFfRZRvVrI6b6cZT8iFl+3mxek50pETgHfrfxZ3NwTHAhNAhJpg68wR3DYiMVq96DAKR1MQIXiuVcRkwbFl2w1USb/iLtBV7lBxU1thIJJOeI9/SjoCz6WyLmosmkggLCoG6FLe49JdUElWd96jMzEWUMnG1dTqL03VWTGj4d2xwfdHeDGP4j9qBXSXVQIOZjhcnFXobvRGYcsoU4kGx3uYBne9kt9KTSq8s7uyqXfcxudGDctNhATRd6jWuiX/S8+KxBYoJfazOm4Bg95wvFFQ5m38NxeDcT8kj9XdaI6narYCKzRgUyAKfMOdu++SYIfEo/uJsc/UbRWIJ/F6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB9132.namprd11.prod.outlook.com (2603:10b6:208:56d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 16:46:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:46:53 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mingo@kernel.org" <mingo@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"oleg@redhat.com" <oleg@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/6] x86/fpu: change copy_xstate_to_uabi_buf() to accept
 fpstate + pkru instead of task_struct
Thread-Topic: [PATCH 1/6] x86/fpu: change copy_xstate_to_uabi_buf() to accept
 fpstate + pkru instead of task_struct
Thread-Index: AQHcDQRr5/6RHZdJg0+3GvT+z8IverRiXAqA
Date: Thu, 14 Aug 2025 16:46:53 +0000
Message-ID: <a54c86dee04ab8047f337c102fab611d9ce2ac31.camel@intel.com>
References: <20250814101411.GA17341@redhat.com>
In-Reply-To: <20250814101411.GA17341@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB9132:EE_
x-ms-office365-filtering-correlation-id: 1efb241d-c87a-4fba-5b8a-08dddb522c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFE5N3NKSzkwWm1vQUpONXNwcnd5azgxUUFXcldtVURrVXA3a243UlVBbmNw?=
 =?utf-8?B?VDBiaTZpcUhvQ1h6ZDNCdEVPQ3dpRnl4QXJqUnI3RmxPaHBxcGwzT2VWWklS?=
 =?utf-8?B?amV2bTA5ZlhqVEpQd29YZ2xvYzFmNDNYbEk3L0dMTG5yRFV3YlNqQ2xsRVA3?=
 =?utf-8?B?WW4wWmR4N1lxQTkwc2NkQlkxdDZTeG1ncEt0UHJtaUhrWEM3ZzRLN3hqK3Zl?=
 =?utf-8?B?TnJKaEVVem9CTmxrVUtYcDQrcmJiN3BwaW16RjVBVTZielA4KzY1UWVxekpE?=
 =?utf-8?B?OFEzMmxYYXR4RThHYUpBay9BT0VQNlorOFR6THRYZDA5djBja003TVRHRlZF?=
 =?utf-8?B?WnQyS1J4Rk1KMiszdFFvVEp4WVNtYWpZMmxoMDNTZE9ITmdET0oxN00veERB?=
 =?utf-8?B?NGNBQ3NuVEh4TlNnRUNyYW9EcUExTXZxMzRTb3V5cVRyQlJ5eTBhUVAzMnNa?=
 =?utf-8?B?dUZNVGVPcWZZc2pZNzdUeFFKQUQ5bjY0ZkZBSWZZRGkrelBZQWxWU0xJM1RX?=
 =?utf-8?B?SUMreEg3WEFPYTF0OWVDbE9QVDNwRE9IMFFaUUdxbG9sc25qd2Z1SHZqakty?=
 =?utf-8?B?dUhZR25iVjJjSHRXaHM0VnJ2Z2Q4aTdBVkxudmV2ditWOHRkYUcwWElsYnRG?=
 =?utf-8?B?cEZCVi8yeEN3bjBSM29seVA0bEYxclJkaTVUa1BrcnJoTUZ5K2gxTFNqekhl?=
 =?utf-8?B?VU5BUEZUaHd6cnFyRGVVcytxTXo4d3ZiRTFzREo3dlBvT2owNXpEWnFOcXla?=
 =?utf-8?B?ZFJwZHdlU1dLdHFyWkduTE9kdStCWk0rUmJhRWhWZXN0SU5qSkN5UHA4SFly?=
 =?utf-8?B?ZTJGWEl2bVRxeUpDQm1ULzM4ZFlEc2JoSVFJcEY1bDE2dyttb0h4NmdFb3hy?=
 =?utf-8?B?alJ1c2R1cEd1ZE9mTlF5SThPU0QxanNpZ0NpdHU4ZjZNQkttayszakliQmFq?=
 =?utf-8?B?aUY4cnBBZUhZMGtjVit2T0Fyb3pFY0pnWFl5MGJVMFdlQWpPUlZBb0dsQmc3?=
 =?utf-8?B?U0R6YVBGNytLdlJqNzdGa2FwcDB0bUpGVzVuL3dCcjBmWEpGYkVvVFBRWHVy?=
 =?utf-8?B?dC82SFprSDRIVkRiUHNWTUYydFRzejcxQzlCWml3OHlJcGtJTkh4Z0l1a3RU?=
 =?utf-8?B?enI2SjNRZERkWnRFaDd0SUpRaHhqWnArYWpESi9DQ3RsdWdISDhwTkprN2ZD?=
 =?utf-8?B?SkVoQm9zMW1jRWJPVWtLbnRIMG1zcmNTQzhqeVp4bnpybmdXektIcTRVUDJt?=
 =?utf-8?B?UVhrSGh5N2JzbXRMVGdQbk00eDZaMmdXM3Y3eHFCNVRUS0U4WE1pRjhTU2Ns?=
 =?utf-8?B?YXlmNGlIOC9QNysrV2ZzOGRNcjVKNUMrTGVSUkpvbXc0UXRuMWI2VEhsZlNP?=
 =?utf-8?B?TFU3TVN4Z0VKZXFBVGMwNzRmeFgzR2c2aVNFRCt5TUpqYkYvWU16ZWNpZW9k?=
 =?utf-8?B?VEErSDFCRkx6V3pCZkQwZkNpVzFpNEVYMTJRUjAvNEgxbWRNN1lJcjFacGdH?=
 =?utf-8?B?aUJIc21vNU9Nd29xWEVIZU5leS9HMGQyQVJPckRtN1cxME45b1BZb2wvd2s3?=
 =?utf-8?B?WCsyQmJQMDd1VFl3OGxRRXBpbGcxZkp2RExTODBIdDN1c2FrdmpQTmpiQllO?=
 =?utf-8?B?MmlVRml6RU8rdW9tTDEyUElFQThRNlMvbTBjRkxwTExoU3hWWXhRNjV5V1Jp?=
 =?utf-8?B?S2xMZElzc1I0ZW9rQmtlVWVoNDFtSHBYdi84WmVxQXhNVFZ5c045YTRkL01W?=
 =?utf-8?B?LzVPNUNrQnZST0JUWGZXeitTS0ZNdTJEd2Q1SE1LVG1paFU0eGgwcXU0U3R2?=
 =?utf-8?B?alkvNjRlZWYvdDdId3JGcm1yTDFETWxFSmMwUFNDRndvTVJ4NFEvMHpxVktn?=
 =?utf-8?B?N2E5V3gxYUVPNUpOUnRLMG5GUi8wa0FvVytGWDZsbVJpWlFGNXE0eE42NnNE?=
 =?utf-8?B?YW5qU0p6Q3FMU0o4NVU2c1JibCsrTVY5OXB5VWR1RUlnYzZCclpwQWdhZytD?=
 =?utf-8?Q?YtzWK4GHJQMa/6ancCIuJODReTtmyw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGpRR0p5TlI2bFV0akdzY2dlMW9JTW9WTW96Qy9MMEtKbDFvcDBvdkFzYjJV?=
 =?utf-8?B?VXpHbSs0OTk4YStDaXhvUjhFM3Y5ZlY2eEN0MVlXOWlxUVJJM2U1WkE2SzhQ?=
 =?utf-8?B?dXlLS05kOEdkT2IyUVpWOFNqZEZ4cWs5U2lZeTRXOVorMCszbFg5bU0rZUdw?=
 =?utf-8?B?L0w1SERkRndkc3hFbDZPc0lNNGlvdUI1Z3QrZStwelB2Mys5Skw4NGJvL1FT?=
 =?utf-8?B?aFdpYVJjU0Zjd2NBdGVrN3NaRytzckx3UXBtZ0RhZmVhSzJPMGxJM0hwWVln?=
 =?utf-8?B?OGRLeGJBbkgwbDFPZTREeXEzdEZQV0M5SzMyL0JPSlV4d1dMNTVhTmtEcG8x?=
 =?utf-8?B?WWVoc2x2WWJQMURKSExRL0ppTUpzZXJXSlI5dTk3UlJseXEvS3Vrejc4YWR3?=
 =?utf-8?B?SmxHaDFEYmlCZGt3SlVqblpPODZ3bC9Ka0o3RmdLUk5GUzJ1SVpEc1BIRlZH?=
 =?utf-8?B?SDlsNEMxR21ZVWpzTVNZOCtyRmJWbGRUK000dC9EKy8xdExDUlRpbDRVU3pw?=
 =?utf-8?B?blEwUTF1cWNFQTEyNmw5MVdmc2xwWkFzbEdHcHRXa0pxd08rN2d2K2VoUzRU?=
 =?utf-8?B?T3VTSHFQQ3plQWpaYSswRUsvcEQzNXQ4Qk83VVRiSmhHbTlualR3WnZMLzlj?=
 =?utf-8?B?UDVZS1BySW85a1k5WVRiTFVjeWVxZEVReVNXVEh2cHd3Ynl5UHJ4NnVwQlB4?=
 =?utf-8?B?QmZXVHhwa2lCSzJBdXBRaDZOSU81QVdHbGtya1l3TmZZaCtTRkNrVFZiM1Ex?=
 =?utf-8?B?SFpGUHhaTFUwdSt0TG9pSjE2RU5uSWozZGF6ZmNVNnNMaVZLTWw1UVI5RHoy?=
 =?utf-8?B?blhnc20zaW1QLzg2Tk1uU2ovYXlNdkRQN0NqZG9LOTJhNnBBbEU0NGdacmdo?=
 =?utf-8?B?UUpiTXh1WjBjOUxUYkpFYWNpd2VpaHM5WWpqNlZJN3VvRnI1Wk9TNWx0b0Fh?=
 =?utf-8?B?TURkYTE2SUZOR1J6MlplUCtrOW9BeE1CcHV6ZldFRzliZVMwYW0xdDBtcng2?=
 =?utf-8?B?T3BmbHV0dFd5SkFFdGJLRGkwODN2aUxFT242ZkNZR0V1RzZqUEZYSkNQdkpy?=
 =?utf-8?B?VGJ4blFMSWtqdUNOL2hHbXVzd2F6RjhYUXpHWk1HeGZxRG5hT1Bkd2JSbXVU?=
 =?utf-8?B?MWJlTS9RZUMwT1kydmdKLytnc2JWMWtQeWZWbkt5YTRSUTJDc21hMVlKRFhq?=
 =?utf-8?B?QTJpekRrbXhhQmlXQ3VmYWJiUzhSWWV4R2t3YjFEeHlHUUpVS2paZzlQUkZ4?=
 =?utf-8?B?VDlaSGxPUnRZOTNlTFI3aHlUcS8yTzB2a0NQSzhXdXVvTGRxeGtNMExiYTNk?=
 =?utf-8?B?MTFUdTZkN0NlVHFzSEg4ZS9xVXgyYXZjNmFERnhRSVh2dTlVbzJqWS9EbG5I?=
 =?utf-8?B?TlNHNVVoUmtHSEUxK2grdnJoRmZLSklGczBlU2JKRk44SUw4bjdzYWNqdmlj?=
 =?utf-8?B?Y3U3T0JoclFtRVBQaEU4WHdZeUNSNFhUd0kzdzBTdUMxclpYVUZqeFBpaE9z?=
 =?utf-8?B?bTBndnVqZzRXY3R0aWJjbk1DaVllWVlCZE5PT2hXN29CYXNGV2FyOXI4UEhO?=
 =?utf-8?B?TFhyaG9IcWsxSXF6dnZrNWlObW15d2hsa3ZKZERRb1pnMjVMSGZSVzRSdllm?=
 =?utf-8?B?MDRpSy8xR2ErUzBrMWVWNTRSTHJCNmJ3d0U4a2EyalNuSFJuRFVDZmk1cm5M?=
 =?utf-8?B?QmQwajFxTGxXajJNdVR2Q3ltekVTdXlzWld6N09wdVRObTBnbUY4bmh6bnFt?=
 =?utf-8?B?dHJBU1h2MlhPNklFLzN6SEgzMXNMZm5HYlJtZ2dlZ0tQQmplb1JVYjR0cmZn?=
 =?utf-8?B?aDFJajdjUExPdUV2ZUh3WkJqUnNRZHlkNWMyd1FodExkYlRrWWVXblptNTh6?=
 =?utf-8?B?VENmc2huZDNJVWNZSUliVkE5WE9kR01GbGFzVnZjR0ZQYlRxT1hWWXorMzNv?=
 =?utf-8?B?SFhTcTAxZUZoV29DejkzV1hydGhtUlViaEI4TGVITWVQY2pjenlTT1FjZnZ4?=
 =?utf-8?B?S2llSkt1azM5cjdTbFZkTVUrTGJBbjczMVM0TEFFZWRIOHNIb2J4V2JOMWtk?=
 =?utf-8?B?YnJmeXY1MlczejNVU3FZU0doaWpkclJuYk5FQ2NqcDlZSFZJaE44YWpySFJN?=
 =?utf-8?B?MW5tblpGR1RvOHYzZUtpNmZDNU9oNy9NMkUzeDJRQSs3dnpIWUxYSE0vZ0F3?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <039F7036CAF1F54CB1146184D63AB758@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efb241d-c87a-4fba-5b8a-08dddb522c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 16:46:53.8512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLoLegwK43dUKsqCRP9//9dk2DvA66mkZsszZQFSocZ6+d8NsEjtLJAAKq+5jXHpAwNShQ5u9PMuXMkvrf41REpm58AzAri+pNhZ3ATqEjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9132
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTE0IGF0IDEyOjE0ICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0K
PiBQcmVwYXJhdGlvbiBmb3IgdGhlIG5leHQgY2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
T2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPg0KDQpUaGVzZSBwYXRjaGVzIGFuZCB0aGUg
Y292ZXJsZXR0ZXIgaGF2ZSB2ZXJ5IGxpdHRsZSBpbmZvcm1hdGlvbi4gDQo=

