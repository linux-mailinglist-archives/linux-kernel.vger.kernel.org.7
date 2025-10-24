Return-Path: <linux-kernel+bounces-868131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB7FC046F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800023B959A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE4231832;
	Fri, 24 Oct 2025 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmJ4Dh5z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACDCA5E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285624; cv=fail; b=A+cnLbaWHSWXc+wpvXPWuu8GX+cDv8fMM0f1oxWD455VgvqGZVJ7+oOIpB8Rix8hGqacQCgcv6K01hGg/kUUjG/kmjv1L6sU1gczWCCGsMGXWBXng1fMkT38Gojq7SqOYVnKIpuC7hC3SDc2HSOyM0fbGsPMBHVbJaDs2Vr6nMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285624; c=relaxed/simple;
	bh=bt20kesx/dK6zZGzDQDZPGSuX6OAYrG0UmDPKQYInnM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XTKcTxvj+JvFFlcWBgYrnCAKLn4+kO3sHNVJzPPEgItqtN+iULV6dgcLy55SDmWnfXxlJM+pIxwD1LgMcV03OVa+c4iNfy8qSLeyP/eL5bF7LdUpH37ahPAqLSeEl8pDiJ1xEDTAol4mdiaKT9bECnnECu8TDjhVBeNHyx+aKCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmJ4Dh5z; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761285623; x=1792821623;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bt20kesx/dK6zZGzDQDZPGSuX6OAYrG0UmDPKQYInnM=;
  b=UmJ4Dh5zO3KyM0RDqrtBg+kk0YMzUqVGWH9im4HEkzmQ4in5NiMDv3y5
   n/1yAUsdauFVCvQIEQCGjRLnSRtlNOrTWVsMSoAoxgvaz0vcJTNSjCdav
   qWvsext5xrr58W1LzGI5np/fF/c+01Xv0BD/NSoAbJBs4aOGQsRnZMMfi
   1oJz+1iu6R7hBa80a6cipjpNZga4V6NLDyVIWfwZ+SYkap1pli0i+CwuJ
   KSfq6oVsnWPXxc6dYWP9pjBLUekF7rkiNDyNel+hkUS5dUpYon71IA9Cg
   sEpaVVgc1nkRb784p6BDVZK2JYkT62rgJzCGJAT4qUc/2CddNPyE0xoKH
   Q==;
X-CSE-ConnectionGUID: IuWbqwDyQd+nwvaS7KUBPg==
X-CSE-MsgGUID: DdA3quEGSHmJcPrtkLHoEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62494085"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="62494085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:00:21 -0700
X-CSE-ConnectionGUID: 8KSqCvulSKmqn+0T9awpyQ==
X-CSE-MsgGUID: cIa9JmDyTJKsi8hGvTT7qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="189475104"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:00:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:00:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 23:00:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7hDwy3ROJ+tucRGl6wzQYVSKbvf9kiIoW85N5HLRh8kBhwkY8CEe/6iBgmvZCrP42+1Q5BMVAb78nOJnS99NH2OLDLAhcBMrlzu9lzNfawtbAm9ec8hdRdyJ3ZC4lbxdyjwPa33MTjLUGIhzqg71LTA1m+MBCwanYqZzNt9ssfHtCsgqdlBuhxo5c39m1K8+4ctunDAFiza+nvAPj7uAjOXS3dnTlWv6PGWCafxuMPrhDz5eabHAWan6fBH/O+ulk8GzszHTQvB8XUsu5+MyR0o51ZwW3Mmg0V7TRr8uSvRccoY0rUwzQ27wKuro1XnXgQMm47rDACALEDMzVCV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP3TTkwekN5b3FgymlRI2+fpNEglHReiXZx6nrta0xo=;
 b=IFSDv239ImfjF1f5sCIf+Nuf5WiC+LyCEYRhlzJSKnL9/X94Eku35g7oqTTPCVdXD7cWa0Lz97jcezrH/VGu2/gV4pxiA/cY6XJF9sUKipY8aOaOlW3ht2X71s8Gvloa9x6I/DP2Nue/v3US500GrB27Ae+4l6z2KNPPPXkyrZjdp/MfXY/LNTUZ9zRDZbXDVJnp7bU00nTEM5tG/b5e4tjkhjy5pbqqi7Iu3ft8u78YB9WIY9TDafCu1xUJpB1UU8fdH5d3JTYgnYUoZAvaEP0ZR4dGaKOUh+hdH322TfnTtBsol9sXARQY8AELc1fOAR+kIa/IAFeyK57f2bOEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:00:17 +0000
Received: from SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2]) by SJ1PR11MB6153.namprd11.prod.outlook.com
 ([fe80::9546:aa5b:ecae:4fd2%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:00:17 +0000
From: "Li, Fei1" <fei1.li@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "acrn-dev@lists.projectacrn.org" <acrn-dev@lists.projectacrn.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Thread-Topic: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
Thread-Index: AQHcRKChkqxb1RMa2UOKI3cGmiOHe7TQyh6Q
Date: Fri, 24 Oct 2025 06:00:17 +0000
Message-ID: <SJ1PR11MB615389E066F50BBB68686A26BFF1A@SJ1PR11MB6153.namprd11.prod.outlook.com>
References: <20251024044226.480531-1-rdunlap@infradead.org>
In-Reply-To: <20251024044226.480531-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_|SJ0PR11MB7704:EE_
x-ms-office365-filtering-correlation-id: 3f57a82b-9fad-4b64-33e3-08de12c29ba8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4gRns/uuCAPpHmVnDE3NfLXcOLnxU+c/6l0rEeR2XRHXKjGK/P/aHUoH7Jph?=
 =?us-ascii?Q?EKSQkRaVzmr6AcGUlEAEr3eRplWDUrYitTG7c3/rM+D71U6ootk9eggLkMPL?=
 =?us-ascii?Q?4ahNDBQvZm9guZOFafFEekjOYIxSKTY0xIZUpzQ1atjWb+Jvzyh0yKz9F1ih?=
 =?us-ascii?Q?RTHnbPwCf0nKvf0O530qWxIcU/PayE3HkWfUmUjVqG1SGVvcpONQmNABX/V8?=
 =?us-ascii?Q?xhdbsEqn1ozc9IYkq9cNjVvsY6paBclZtrF23eqEw3j784YGnWba+Bceo1Lx?=
 =?us-ascii?Q?3ES3gi8H6ZdMMVGdPQRi9e0IF4PCX4KDWSaJrUCXt6znw0g6NOyrqZe3sALp?=
 =?us-ascii?Q?viID9U8MncgHh9LCJQWsHSiiFV7LEXaySAu4DU9Gfa80t9Q3dBi1DmZ4Y1An?=
 =?us-ascii?Q?/+d6a2XBsnSEyeTAxnj8ukiWwJGub3m/F2/WAAege3Qzka1kqt3DtfFl6gG8?=
 =?us-ascii?Q?8AhYMkHDrxXAd9UR24gqFFeqgOS+hmQs5HREoe13i9xM5oWLztTqntowmkvt?=
 =?us-ascii?Q?CnB6Up4UfhXaVLxoOwCkaIDYLM3vD3rKF82s3fFdUyi2V2zX7CgcO3SJ+CaB?=
 =?us-ascii?Q?VsZgWsMVgGfqHyNu5eAUAP5jHCTq3y8p1GPAYhf/x2/W29oVDh7/wH3BVB4T?=
 =?us-ascii?Q?AndbjzeV3zP8HQrnz9zOASAgzpGU5YOybbByRAkAvhsvfU4zFrGEeraMKf5n?=
 =?us-ascii?Q?EphjTcqJfwkHY0x35qFGsNHU/4S+ye8v2m1JIeQ5CVrWLrP4smZCrW11vRvC?=
 =?us-ascii?Q?7MykUa+R1flJWUnX3f2SzF9gfv18lRadyNEjwJI//5S6K4M7jpAad7VK6y7Y?=
 =?us-ascii?Q?OlSOZTqb7SPLBDJkB9oVPKOfn3M1gEGw0a01f9UBet1GPV21ZUmzwZqBys9w?=
 =?us-ascii?Q?1pZa+szdmb5gOb6ucOjyD5Fid3cY9zjjD3JPq8WWZ7NwlEJhk+eVViM0bzUB?=
 =?us-ascii?Q?lxcKHoVBuk88TKkjp8x7gUmyEZwc6Sg7ffy3w2WSxsmELMluMYp/XmGFtZua?=
 =?us-ascii?Q?27Pi+sFmL6CuvJKiEMeTUDy+fvDLrvEwaoP5kGXrsXpz4RDncesPxRCr83hY?=
 =?us-ascii?Q?hcTKPVe3Zxuvcfqwmq3sr4+VT/ofL3kR8/5YKzFIZ+RpNh+JWegbX9giys+b?=
 =?us-ascii?Q?mFw0IsfUNM/+uBQnZF36+5nxrKd+zIVDKdjGP5yYICxPu0fSOnMAjlFsFkXu?=
 =?us-ascii?Q?yUiu4y275fbw3AVOmBVqW+7QFi+omwM+Rsfv97z46R98CegDef0v6Du5EM7M?=
 =?us-ascii?Q?Q34AkxYNI72eV0/xLvOsj0BV4jw5fZD1IyKO+BaQaChXEk07uQ1e8t7gpI9j?=
 =?us-ascii?Q?zth9cKZpRYQLVd80rzV7i2YMpXRXxGXyPEUyAlOaJm7Zrw8abMs0hLiXQ4Fv?=
 =?us-ascii?Q?tavPYJ36Co2p9jyApCysDId9FA5+UD7RqNB+TIlT3DJCIb0wDF6qevvqcvWQ?=
 =?us-ascii?Q?lg1UV1qrm4rm4rCteXTm5s4v/Qmqrjv/HgFAXyG6/hROgsmYjI12VQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6153.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dq4o7Ie4B/lpXWryXLmhfWqRQKQDS2Did4nbvbbmFYjb+MymLIAcQEQK7Zl8?=
 =?us-ascii?Q?PwkFdUQzaAJAIoeHyShVIuT+f2U/tQ3KBC3iupa7t5I5k0e4m3ELL2nlhd1l?=
 =?us-ascii?Q?6yT2LYVyu4XkeRj5/GLrGlU3JqE6qY2wUg1ez6iLiph15ybHkmNJgtqvKMP7?=
 =?us-ascii?Q?RKVAQGHaCECrk1mvLtM/PX+VaFNwbc83lhqjSyLm0amsItYGPjZ1EIQ7teba?=
 =?us-ascii?Q?ZS0lKMmQ8VdinLWrXCLqDteVCM2cYAVNUTjkolh0JMqyAAa6ggip1pWaWTnL?=
 =?us-ascii?Q?KoWHlK3KPMdfsDLOI+ZlCxQ259ogRGQ3jVjZ7NrlHqvaFPZ4DglNodFS5QXd?=
 =?us-ascii?Q?z6VbjMnqUFyGjjYK+ajGLARzNQSzx/hKKP0/lC37T0bs9/E4Kg7R1QUc2i76?=
 =?us-ascii?Q?d6xw4+WsecacLMDNhheClPWS9/1cjxBzq5tpyyPVOwTqmDZfcOPaqPTk5fBu?=
 =?us-ascii?Q?pBBvdulAi4liDL6VhwLztzgUcOok9iy77UagsxIlaeje6sy5oKgNIssj/+z1?=
 =?us-ascii?Q?AWsPtrhhrKW+ZxWTmLrlfv4sHFFWtEcdflFwgBmUqnxVnC6w6xQpIfTmwhpT?=
 =?us-ascii?Q?LdJmIqgS38yYwTHv+TzreTz9xIjixE0zEC8LBJASaS+q07OfSyc6loi3omF9?=
 =?us-ascii?Q?0ZIhgDOIx++uqZdb5KBYzkfscvNcCaPqqqGVDu8+rOAODdYHvoMJv1lH1Vho?=
 =?us-ascii?Q?/SKreJtAP+H8C4TTLP9+OcbU9paTa9mMthmvx0s+AwCM3GmTnZKQOAGIQR5O?=
 =?us-ascii?Q?awH4iRBuUz0JtU0Y6EKnXaOSZBV9AEhrVLZ1eYrCVePvR1YIcQZJVqNDmPnz?=
 =?us-ascii?Q?gn8kDuETq0O6d2kauoZDrgAEWR4dWr+vVaTxQC2Nm5qAP5wZyB2gbWtG7njD?=
 =?us-ascii?Q?sdbXUWXPBSFMXNT48WeRM8h7XwAcvUqwvQqTsgZlDXDL+ZHqBDD1rsNhNGnK?=
 =?us-ascii?Q?2OeTqPlhwlx2nUIUEunuQAFinFJ42bEpz5B6lMEgIH4G0y/yWfaDhDuYeTiM?=
 =?us-ascii?Q?ELC1blGcH/jUmkmsQzq0Fcrkqyc/lufspIX9DiGH5IFuDewBOkjlZLgbp5MX?=
 =?us-ascii?Q?q96VxiXO6S4ElNXzy3G6gowtDSBSrwJMr2VxDWgrlCqBVRoqWJ1RBITR4W00?=
 =?us-ascii?Q?wmvClef9VHSjALjU9GGyOrpyj8BUiY2bVi1di18nzIsEysxTQWvdPm9WCAgq?=
 =?us-ascii?Q?DjogVbrvIXsyu4efjeKoA3FfehASVA0GjqbXtMixhYx/ytqaCxDwU1gBB6fY?=
 =?us-ascii?Q?3xUz6aB+nikSL/59qXRUSpZbZmLymS0Av4aW7ix77oRafuOQN6AjN1jhc6uC?=
 =?us-ascii?Q?k/k9EMrJ9I9QfJs9nQDN7YOSYlR+MxsC7TKuwABrK189KxUeG/g032sxybYg?=
 =?us-ascii?Q?E49G0JQFzVvObhUlRFz6SDFTmzKrXP0Vke9GWjwMHIFqZfHFbp3AGFUFqfWp?=
 =?us-ascii?Q?nS+vQhq6pmgGKlf4PjAK99pgoQPIcN4HjfsjoOrgurMA9yRI5qL0e4KJwgeU?=
 =?us-ascii?Q?LjQXtgQ6CO3PsOSe5SX+irG+Yn4YMcpsQJ5TtyEzXdxkEhmFewbdhNAxlLWO?=
 =?us-ascii?Q?NzXANc6zHvHIWFIXVK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6153.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f57a82b-9fad-4b64-33e3-08de12c29ba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 06:00:17.7245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cfYJDmoeEDLK55KebI91eTKSGVFbHGdi6JfbI1Tt2zlDrZTrFCD2wMeR/BncuRJvVVWnz336gY/oGp7o3Gx1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Friday, October 24, 2025 12:42 PM
> To: linux-kernel@vger.kernel.org
> Cc: Randy Dunlap <rdunlap@infradead.org>; Li, Fei1 <fei1.li@intel.com>;
> acrn-dev@lists.projectacrn.org; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: [PATCH] virt: acrn: fix kernel-doc in <uapi/linux/acrn.h>
>=20
> Fix the kernel-doc comments for struct acrn_mmiodev so that all struct
> members are rendered correctly.
> Correct io_base to io_addr in struct acrn_vdev.
>=20
> acrn.h:441: warning: Function parameter or struct member 'res'
>  not described in 'acrn_mmiodev'
> acrn.h:479: warning: Function parameter or struct member 'io_addr'
>  not described in 'acrn_vdev'
> acrn.h:479: warning: Excess struct member 'io_base' description  in
> 'acrn_vdev'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Fei Li <fei1.li@intel.com>
> Cc: acrn-dev@lists.projectacrn.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/uapi/linux/acrn.h |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> --- linux-next-20251022.orig/include/uapi/linux/acrn.h
> +++ linux-next-20251022/include/uapi/linux/acrn.h
> @@ -420,12 +420,13 @@ struct acrn_pcidev {
>  /**
>   * struct acrn_mmiodev - Info for assigning or de-assigning a MMIO devic=
e
>   * @name:			Name of the MMIO device.
> - * @res[].user_vm_pa:		Physical address of User VM of the MMIO
> region
> + * @res:			MMIO resource descriptor info.

Hi Randy

Thanks for cooking this patch to help fix these warning.
Could you just add the comment for `res` and keep the other comments for th=
e fields of ` struct acrn_mmiodev ` ?

Thanks.

> + * @res.user_vm_pa:		Physical address of User VM of the MMIO
> region
>   *				for the MMIO device.
> - * @res[].service_vm_pa:	Physical address of Service VM of the MMIO
> + * @res.service_vm_pa:		Physical address of Service VM of the
> MMIO
>   *				region for the MMIO device.
> - * @res[].size:			Size of the MMIO region for the MMIO
> device.
> - * @res[].mem_type:		Memory type of the MMIO region for the
> MMIO
> + * @res.size:			Size of the MMIO region for the MMIO
> device.
> + * @res.mem_type:		Memory type of the MMIO region for the
> MMIO
>   *				device.
>   *
>   * This structure will be passed to hypervisor directly.
> @@ -449,7 +450,7 @@ struct acrn_mmiodev {
>   * @id.fields.legacy_id:	ID of the virtual device if not a PCI device
>   * @slot:			Virtual Bus/Device/Function of the virtual
>   *				device
> - * @io_base:			IO resource base address of the virtual device
> + * @io_addr:			IO resource base address of the virtual device
>   * @io_size:			IO resource size of the virtual device
>   * @args:			Arguments for the virtual device creation
>   *

