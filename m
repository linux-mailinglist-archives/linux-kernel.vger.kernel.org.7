Return-Path: <linux-kernel+bounces-790790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD18B3ACFF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C933ACC21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA326289E36;
	Thu, 28 Aug 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C20znpY4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6C37404E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417906; cv=fail; b=T4zoO/2t/nxYe5wePGEp5ggVwFAEJuRnrp7fbmz1lBsP2CGWjYZ93a74CFIACWgSI6BbRGT54r4XjBVp+hXlvLAEGSfAoSsoX6d3XUGpakZMl00Gpex8PRLZfOH1RbDrNdPBDlhX3bIi1tHwKEBTDn67gj/G1t5YsyPWHYco7rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417906; c=relaxed/simple;
	bh=CrqdA3J2Z4Ag4Jtseq0iZmcn57TXIU9bx9vWcWTKgb8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YvpM7quHNHHdI1OOKlPVt8eG8hrFl89l4X3kZEO5ay8IrUuRAFiMmVZOqwGCK3oThGNcnQO/pT2RdyQOhrIWFZg7VHXLnzh11htGixoyeZCaDAQavcs1h/fAYlm7jITqVMqcIRHaCHLkIa/3wmYuWCjFyrmqHB1F99b1e+VOxQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C20znpY4; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417905; x=1787953905;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=CrqdA3J2Z4Ag4Jtseq0iZmcn57TXIU9bx9vWcWTKgb8=;
  b=C20znpY410u+ji3cOqo/OeoniPevvPQVZXzvSXQOZgyXo+u1jv4QEL4X
   F+2Tr8hR0fCfBXu6BIBM+aiDnoP+hvv9v7Vx/+Wi0BEzBEib5xVimHAF3
   qNkCveP2fRAOA0OY6aI0KvY1EwJrHWy/2BNOjcGJ+rqDpXtgcREPSsyKk
   Tw5EOc70P2fw4CyDbeUWYn/5YhhSEcV8XN5yAEcfpfTBvKvQkVo4vEZT/
   Tv+INxXDoU0ZrRkl6cwYja5MPH6Lfz66TGsl+9e28yM2FkKLwFxO6eeo0
   r00+tVmZ9UPhtLV7ddEs7k6EI5HZuTcl9dtzUgIGpnCGPdHX2xrk76w5s
   w==;
X-CSE-ConnectionGUID: srlAsEwGSJS3MnXsjIeOcg==
X-CSE-MsgGUID: l1fXW88AQdyhK0GNs0I5mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58410487"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58410487"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:51:45 -0700
X-CSE-ConnectionGUID: I38lHsmSTPGpdcVmpyfqqw==
X-CSE-MsgGUID: mSUh1gUFQKyYLTEq9M48UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="171014735"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:51:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:51:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:51:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:51:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDs23QRj3l1xpYQ4T/zrWw9+RYkC7nqxomnhrz2KppQSkIsjVyBEtvp8TdCd1SyXIRHvzzwvbCfXVNleVJ1m1DqBq+lD3iWk6mimeimVjCrcU389wQQ53+14qrV2ABg7NmXlD7QeutVFeEkg6ANdlLIOHIZcDG2ChNQRd52EqaXWOM05yfNa6mnv2hH77u+heV19Sm4hIEX8W5cgQKaewqVCB5qvudF04BDqplkDggZxSoWhq/JOisfedgHjfTweNBDZ1FClYM7tx5OYjheB9IQSRt7OimffjiZBRiyxoJsumEX8en9mNpsNyxBDtFf30DpYpbjzHSngWEjp53Bt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrqdA3J2Z4Ag4Jtseq0iZmcn57TXIU9bx9vWcWTKgb8=;
 b=a421CfL7oQFjY7QuBobI4KlMl1yDiTxy1g1wtrFF49BXyQmmIdkMt/89MXbXdhJnphrJemQvcKSefA6gFNiM+ZNWoHuLsaj9RNO9OtSWh8nzUGjG4016+dRNiwzzHvZanGbldWUj3up0mrv+QSUu+SftWetnnE8RRxT6eZfS/Qk74zmPS+HaSnHete83GLOb0XYxrc3PRDIM5GmAB2/yGqTRz7z1v9pGxD8nkEk1nbpsOgl77YN2Mn11L35HMHKXkXnn0SJUKc06ETvqPmdvHCQ8+yABoibIamKZjxPuTvOO3eov4kN4Tqv8+hDmhSHzFBIorLsxETpfgbaZSfzDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7)
 by DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 21:51:38 +0000
Received: from CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::e179:e:20e5:53db]) by CH0PR11MB5330.namprd11.prod.outlook.com
 ([fe80::e179:e:20e5:53db%4]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 21:51:37 +0000
From: "Winiarska, Iwona" <iwona.winiarska@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PECI changes for v6.18-rc1
Thread-Topic: [GIT PULL] PECI changes for v6.18-rc1
Thread-Index: AQHcGGXtM/arIIdFWkKvyM2pv2mKAw==
Date: Thu, 28 Aug 2025 21:51:37 +0000
Message-ID: <26c72666403f2718409d903957ddebb3984f4ed4.camel@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5330:EE_|DM4PR11MB7399:EE_
x-ms-office365-filtering-correlation-id: b9cf87cf-20f2-4433-6366-08dde67d1085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDdndFpBcXVmQ0VRUWd0M0I1UjQwd1UrVlAzMnM3ZnU1dzdqT2hCOFRkNGdN?=
 =?utf-8?B?a2R3NGs0UkZ2OTczZm0rUVArOFVhbkYrNGdmR1RZTjUxMW4wam1PNFA5bEFP?=
 =?utf-8?B?bEd5QUFWZTlRTlZUKzE2bDdrQ2FteFBYd3FvekxyZWMxRXZTK0RYVWV3WGRF?=
 =?utf-8?B?SG1pdzBZYmxJbkZHekJUTDM1OU1pcFcvWGNiR2Z3TExzUzBQUm5KTFZidVYw?=
 =?utf-8?B?QllIR0R1d05aUk1Lb0s5Q01VcnprR2VnWXpKK1dQZ1dEWjZma1ZSUHRncmZI?=
 =?utf-8?B?MTNkM0ppTGxPaXRQTVpEbUhZTEtRa0dBYytOaFZDVDBiU2txRXpMZlBwKzZI?=
 =?utf-8?B?T0w1aktWVkhlWFhkWmdSRGhEaVVlYStTaUkzQ0pET0czVWU5c056K05OYVcw?=
 =?utf-8?B?eGVZeUNRa0VnUGxDVVdPOGkxV3JEU2VMR1doSTZ6b3lUSjdQSndtblVGd25C?=
 =?utf-8?B?SDViT0pXWWZYSFE0TEVWZmQ2V2l0cGFUNWJKbXY5Q25FTFdqdDl4Wko1cWZh?=
 =?utf-8?B?VURpNnRrZ21MZzM5K2xTT0YrNGNYQU5SNzdUYU5uSmVLcGk5SEhRSURVc3Zv?=
 =?utf-8?B?eVNhQ0lYZDJHTHhJKzZ6aUpGaG4zTGJuc2FjOUl0MXpEaEJaS0xlSnFLQmRv?=
 =?utf-8?B?alNzb1RUMStRa0hja1B0VjNIY1ZDbGg4cndnb3dOTWswdTVnYVd4OXdTMG96?=
 =?utf-8?B?NFJ4Z2pKL1ZRMU4vYzNZQzlQVnEzS25Oc3JzakRjMHF0cjBoTEJ3aUtrRWIy?=
 =?utf-8?B?WHVSWHZoR3ptUnRnbWI4OVZFdHJQWk5pdU4rVFlTRk55S1pjdlNGeGd1ZmRG?=
 =?utf-8?B?ZFFodlUrcWRZQm1oaUsreDh2TmRKTnZ5TzNPUUpodktzN2s3S0ZSblErYzB6?=
 =?utf-8?B?ajNSTU4vUkwyUDFSSFBFMmxmVFloTEZOd01xZjFRMWtIYlZPOTZMOHAxRUY5?=
 =?utf-8?B?QjBOQjY5TVJWZm80ZmUxaDkyWjFGRS9IdnBvNEJtenBuc0dnbWhibWgxSGxH?=
 =?utf-8?B?ZTl5YzVIMERWY2lwZ3lMaU1EUTZ2Mkhpd2ZBYTQ0dnZNTkdibEUyNmFkVCti?=
 =?utf-8?B?YWl0MGd4cHRuTWtmWW9yZ0d4VzNPMjVCSXVSZFlmY1k2ZmtGVVRTNm1DeG4v?=
 =?utf-8?B?QmVJR3dMZUEzdFpNejRtSi82eHlOTUczbDdZV0RiTVJ4YUUwT05YL09YSnIv?=
 =?utf-8?B?ME1tVkEvazcyeVlGbDBySjNJYUV5N3hMNE5SWGx1WDl6bWl3ZFNHVk1tYUd3?=
 =?utf-8?B?Wkloa0VUa2luMk9ONmh5RkFydGhqME9JZFhJZTlWaVdoUjhtazhJSnhoVDNz?=
 =?utf-8?B?cVNTK2lScE9RZGJIdUtIVkFIaktWMmJNK0srUjkrb0VONCt3WG50TTQrckdV?=
 =?utf-8?B?c1hnRk1hYnBFN0FaNXlqdzcraUpYRlNSL3FoRlliVkFub05zaWNGOWZwZXpW?=
 =?utf-8?B?VXp0TkhQWk5PVGo2OEo0Tnl0bGxPUkdXTnVZUWxJMDlQT1dUVGlPbzNhN1Rs?=
 =?utf-8?B?d24zeUtxUENrUTdUdmZ0R2NjbVp1aU50UnRtNGFuN0RrYTJpTnR3OEc5czJU?=
 =?utf-8?B?ZzhDb3c4aEs4UGJvdHZ2a1hWVDlwVmZUMXJwVWNXcHQ2QUhoeC84eXUyMmNM?=
 =?utf-8?B?VDA5NTVsSWQ0ZVlHZFRNUDBuN1QwTGVucFpvOGtCa3VYWHM1R3hKQlQ2TFZp?=
 =?utf-8?B?NklYOWdBWTlyTVBDdHNtZVNjdXlCVHAxck9Wb3hEUWFaOGdxMDFRcWVBc3NQ?=
 =?utf-8?B?dEIxNXAyVElCemkybThhQ0xuUzB6WDIvUStSNnFldFBYd2pzaG1TUzNoWnBx?=
 =?utf-8?B?N0ZwWi9uQmlwRVBqYnZiZ2xhNGczMTg0bVdxM3hJWVdONG5xMDRyOFQ5RU9K?=
 =?utf-8?B?OWVPa3gxekNrVVFsUWp3aEJDZy8yemNMR0Z2KzdiQnFOdXBHeGtVQ0VtSEJW?=
 =?utf-8?B?TnhkNStsT2FOWTNiNGZjUzhaUllTM3RlRXgzT1JhcDlSeldBcE04dTRIRXVB?=
 =?utf-8?B?K3FCR0o5TTV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5330.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzhjWm1xbnZ3U2RieG5nK0RaZStNUnMwTVlQWGYvcVd3QU82cmZKVGpPYXAx?=
 =?utf-8?B?cTI1TndtckhHVEMvbFM4TVJ4Y1VISExjNmRsNndRZ1E4MWRQV0JmVDR5cWxR?=
 =?utf-8?B?RXVpSEVOVmYxTS9xQ2ZXZlExRHZFZ2wveDczN0Vta1BEeHh6RCtvSURBeS9D?=
 =?utf-8?B?TVdMelhDQXNvenJQdUROTUdVU2x6SDdPVElTVng1K0dxNXdnTCtQV3pnNm5W?=
 =?utf-8?B?YmtYZmVraHphU0N2VEp0Y2Zxc1RIL0gxUDRLQVdvTnZnSktnZWs1RTM3c0dh?=
 =?utf-8?B?MmNIRVdDdzBTNDZqT0RNdGdGcmtZTFV5NStXdWJ4cnYydDlrWjMwRzlrdkhG?=
 =?utf-8?B?Sk04R3hSUXJnRjZWNDlVOVRKVitpbFBkMjJQdHFVWDJlTG5NMURpSkhTdmtl?=
 =?utf-8?B?TTB6NGhmMU50Ri9hblhzQldyZnNGdy9MMzdmUG8xZ3ZJbzZodmtEeXlDY09U?=
 =?utf-8?B?bEJEeTdHYTVsaWMrb2dNb1hlc2I1MXdvUnYxa1E2S1hQbDJZbkhtWUVkR1dD?=
 =?utf-8?B?dTR6aWswelJVTnRUcTJtZ2ZOcjN0djJTdkNScjBOUGdCdmFXUDZHWUpDUVpy?=
 =?utf-8?B?Q29lS0lBZE9KMHoyQ2FPV05oRmlKMGNTVnpLR3RWa3FRNFhTMkFjc1NNcHVt?=
 =?utf-8?B?aVMzVHd4U3dLLy84WXI4VkI4OU1vaW95Um1IYUNYUmRtQUJtV1JVVzRvUXpJ?=
 =?utf-8?B?K1BjS3F0d0hZTHlRTEFMUjhqM2F6ekxqSmFaZ3JLZ1ZyWnJ0dmlpZFNWWFd3?=
 =?utf-8?B?NHlrOGRVRk96b3FHWlcydU9OMUpHY3QyTVRpVWlDN2Z3OFliQnNPNTZublpv?=
 =?utf-8?B?V2s1U2JlNHdFWEw1VzNnME1JTmRvelBNdHZRVWt5bXlXWXBDb1R1NC9iWWtH?=
 =?utf-8?B?L08zOVlUY2Zkby84N2d6dlFUclFRN2RRWWx1U2UvaG5yOFZKLzRpaXZSOTEz?=
 =?utf-8?B?M3d2blhqN2ZLNml4U003UWt0Ukl6cVNJbHRHOWMvb3ZUMU9yQTlqN05sdFhM?=
 =?utf-8?B?LzJZOTdZSE1XQ2hPK2RVYmFOOHJFdWJQdGRPV1FGRnJ4ZVRYM0tGanVqRUNP?=
 =?utf-8?B?Q1lTWW9sUVh3TEMweFRDVFhUNzJSNi9BWWtpM3RadE5tUnFmUEZ6ZGVvYVJ5?=
 =?utf-8?B?Wnp5UDdOQWxQMjNHbzVuYksrKzF6eitnVTZuZzg5SmtDNktoUmdUSDJsaVNB?=
 =?utf-8?B?MkR4Nk82RGx0YjlGSTB1L1AzN2FQSWZQNGFBS1ZHYlpiU2ZNUW1meW9iT0Fi?=
 =?utf-8?B?anV3M0JaSVVoTUphZWtzMGFEMFA0THZUMHRYd2M4VXlpTmMrYXVZQnRhRTZG?=
 =?utf-8?B?bFlRVTdQdDRuWDdwejJFeWkwcllaNnkzUE5ubk5PbHh5TjdDeElVTTltazc0?=
 =?utf-8?B?R3ZBMy9PY0RUaitEdUtlc3BGcUxWZGdpTkRHL2thUzJpQTR1bVNuK0V0QkFB?=
 =?utf-8?B?WkhmcjQ0RFdNdUNmNDQxcWEwL2lUQmtiY0NvQ0s5RFVSanBHcEZzVjNXTlA2?=
 =?utf-8?B?bzRtYm5lZ0g1VVRGRmFtYVpIT0JBZitSM0YzUTdtOVdCRW8rVjFwTkpJMzE3?=
 =?utf-8?B?ZHBja2VqczhBa2hWaldHaVUyeWpiS0l3UFlMVWE1Z1dmU2Z3V2laa09vTEM5?=
 =?utf-8?B?UG9rODJEbjA1d3oxczVSYmQvbS9TTFdrYUhrTXVDMVhxUFZuSkJIeC94UGVE?=
 =?utf-8?B?V3YrQjBXRHY2QjFHSUFBTjFWZ1Q0bjdUdTc0V0lnRGI0QmNxaVcrZGQ2enVK?=
 =?utf-8?B?dU1WM1laNDgxQ2ZWaDFOL0hQUVhYY3RRSkZIVmVMbCtKY2pjcU45VmNGY1pM?=
 =?utf-8?B?UFlLbmFCajNya01mdzAxT2s3a3J5ZmliaXNZS3E4bnhNSzdkVjJMdW8yWkk5?=
 =?utf-8?B?VDhndHBXWlJsN2M2UU5lNVgycmdkd2FTNEE4d0M3U2V3TjFLZGs2T1hUcGNJ?=
 =?utf-8?B?clBmRUNBbzR3MHpmelM2bVJwUnlDZU1OYngyd09HbVpTLy8zQXpPNFgvMHdi?=
 =?utf-8?B?ajJNdmlITVFCekt4UkVNdFY5ZnE3SEFudzVVc1VpVHpjb2wyMG9pK0U2Qmxk?=
 =?utf-8?B?VFJlU1RkSXozWXZJTUNRMFZrMHlsYmMrOGUrQWxPSFd4SDE5QTE1SkcxeGdS?=
 =?utf-8?B?MkZWdThUbk55SjR2dUl2L2tUK3kvNjdNaDlPeG1sRU8yZmtFOWNURFJILzN6?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A222EBF30893D438D565C93FBDE3D12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5330.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cf87cf-20f2-4433-6366-08dde67d1085
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 21:51:37.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNzMxh/PaNs6JXsPOrqZzFWGcqITZh240PIPThJEU7GBYfeb2uNvK4vu+X24d9FH5TMwgZdaOuc68XM6xtYUhQURiWi5UVHaeGx1wf3tTK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-OriginatorOrg: intel.com

SGkgR3JlZyENCg0KUGxlYXNlIHB1bGwgUEVDSSB1cGRhdGUgZm9yIExpbnV4IHY2LjE4Lg0KDQpU
aGFua3MNCi1Jd29uYQ0KDQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDFiMjM3
ZjE5MGViM2QzNmY1MmRmZmUwN2E0MGI1ZWIyMTAyODBlMDA6DQoNCiAgTGludXggNi4xNy1yYzMg
KDIwMjUtMDgtMjQgMTI6MDQ6MTIgLTA0MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCBy
ZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9pd2kvbGludXguZ2l0IHRhZ3MvcGVjaS1uZXh0LTYuMTgtcmMxDQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBlMjdmMTU4Y2YxZTk4ZDlhNTQxMjgyZWY0YjM2ZGZhNDQy
N2JmMzYxOg0KDQogIHBlY2k6IHJlbW92ZSB1bm5lZWRlZCAnZmFzdF9pbycgcGFyYW1ldGVyIGlu
IHJlZ21hcF9jb25maWcgKDIwMjUtMDgtMjggMjI6NDM6MjMgKzAyMDApDQoNCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClVw
ZGF0ZSBwZWNpLW5leHQgZm9yIHY2LjE4LXJjMQ0KDQpBIHNtYWxsIGNoYW5nZSBpbiBwZWNpLW5w
Y20gZHJpdmVyIHRoYXQgcmVtb3ZlcyB1bm5lZWRlZCAnZmFzdF9pbycNCnBhcmFtZXRlciBpbiBy
ZWdtYXBfY29uZmlnIHBpY2tlZCB1cCBhcyBhIHBhcnQgb2Ygd2lkZXIgcmVmYWN0b3JpbmcuDQoN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCldvbGZyYW0gU2FuZyAoMSk6DQogICAgICBwZWNpOiByZW1vdmUgdW5uZWVkZWQg
J2Zhc3RfaW8nIHBhcmFtZXRlciBpbiByZWdtYXBfY29uZmlnDQoNCiBkcml2ZXJzL3BlY2kvY29u
dHJvbGxlci9wZWNpLW5wY20uYyB8IDEgLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQo=

