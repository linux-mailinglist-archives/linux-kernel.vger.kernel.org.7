Return-Path: <linux-kernel+bounces-836554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4056BAA025
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810EC3C0BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB930B508;
	Mon, 29 Sep 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrhhKqGA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18736309F03;
	Mon, 29 Sep 2025 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163001; cv=fail; b=p11rbInb1J4xB9LvEjsV53RU6oy5YsGJQk37Iq3MSe/BbEN8/ENU0lG0kew5QcKBO/e2ym0V17lGyBxOuoEXcVSfLr86Ml2r1WsIYa3UGlEsJuvan2n6hbpBtJmpGqFeZZiW8ciSuzzYcESYpsv35lNLHwd6T1ZhL3kA6IyJFB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163001; c=relaxed/simple;
	bh=7GOGHqQBx6LB2vzwbv5kbpXiRF0dmMJnXBf7OqXLDkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gpt3UF2g+Vabw0dVMQxLMRPVQfV/qipl4z0MladWyqKligmcCkP8n7+YCQUUQifHXXqOKxm53+K2HvRs2fdhqvLiEBCZMlLa2Pwt9RQNQsHgSSp3azkxIZk3mX8bEFJ/UB0WmsT3J5Z3bHL7wUWjp/m32iMbh6J0RvyAaE4nKpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrhhKqGA; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759163000; x=1790699000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7GOGHqQBx6LB2vzwbv5kbpXiRF0dmMJnXBf7OqXLDkg=;
  b=LrhhKqGAwRvV0G6hUEQEeE5B/ABX/QcldLKk5f0YtMGqA3C0TGHFnRMi
   axAv11prEwVQi1IcHq4Z8cn/XqVDDthv91SbxMne8eq2JNXEpuwvkbReh
   f0J2wi6Nos1F666VR7eWxCb16gKyElPy6A688SfEFCLDIfKxkTRMo8VfY
   UskLKSQYqnYfMTW6MgrRebXg/A0thxvA5bQIcFP+kZS+7Kzu1xfWaRQGN
   ELuW43IMp1ch7GrNL90XYZXlpnO25QcvgzO4MYnkx7j6Ap6vME/ccsdWx
   ax8i84DZsX59S7CGADJHQ9pylPPVZFTq/R/XoFvP3OAuufGSgx5DcclBT
   A==;
X-CSE-ConnectionGUID: cfuzDPf2RYOm1B+pms8Zlw==
X-CSE-MsgGUID: rk88dh2EQNqsjcsaQHNSKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="48971879"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="48971879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:23:19 -0700
X-CSE-ConnectionGUID: B/ayFju3T3Sh7DPMkEwtBA==
X-CSE-MsgGUID: n8R7hAp4SVyBq3sj4+pMbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="215439951"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 09:23:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:23:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 09:23:18 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 09:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCokwuG1LNFm9kXTIFSJDj0XF0YxlYcDevyFDeDQE8R2l0EnxuBaBbn6qyAnnpiktAmhWsmALEAZoeD+pYlW35gpOCOmpqZzzejw6CJTDfyXTfBsNhE2g001olTqRdXtD8h9LOugajVH+Vf1Ts4+h0SXWhLoHPYCwWuLp6OYXbDLjkJeVWP1408nu+NZ+85I7g48QlPH+wbxXimHw6J3i4VYWhPwI7ihX51iMDxTvKcp6gfhTthqDH8uA3K0Htve+vh+ap6q3n/GcK3oIeWEjNdaGqZorag6y88BtHo8hkWWVEM7C2kKHSzHsydam/HbIT8ajTCsvHvqiCisxUgy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPf3jio4Lk9OMYns/m1FvRidfFF+s6xuAmBlz4JYBKA=;
 b=MY7kKxH+23sxvQDatAWLE29ZPQUczz8W5WuTypW/6WtaaADQzildNiQXtG/hIp9wawjie1YzMue4CxvMa/x5U7yYP7UAc8ZNeb96D7uTR5a4LgrxUxXWruP6uSPzajdSsBYx9PXD9TKEkcCO/Z94F44j4meeh1dw2EIU5M0yI0MHiJj2pdSlhy682C679H+E0wEiOOmgaPM7RenF56sZm4xQYlvYWHdPD2EZPAVwLtl6EAIe714bapafuNKzhyKk9JiHqqDwYn8ItiJTgxHaicr9snYybGonk6WFMFISHWeWhm8Qg1K4K8OTtbvsXRsSMf4FX08SZj600OORWqJ7bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 16:23:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 16:23:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	"x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Topic: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Thread-Index: AQHcHCY4c4HVqMw7CEaMcDAeu2aTP7SfbCMAgAU7aICABWR8AIAAUhcAgAAfltA=
Date: Mon, 29 Sep 2025 16:23:13 +0000
Message-ID: <SJ1PR11MB60838E8CBD68B962380BBA60FC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
In-Reply-To: <aNqUACFbXHjURWir@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB7414:EE_
x-ms-office365-filtering-correlation-id: 66ba80b7-d55c-4ac3-a783-08ddff747d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?V2JKiR3UzoFqC7bhPHYmrpXuPS9CUiAAWhNUNs1PfE/UQ65bfuV/KI0tT5Lh?=
 =?us-ascii?Q?SELpRM45zbYsE/L43Qb3+Kfj+CsgSAIHGVOhT8R3Yi2kx5xt9gxQhF450IJV?=
 =?us-ascii?Q?aI4rvy2e12jF0+l8dcCybxS9DkFhF4i99cVr4/BdAzgczxNNhLcJZtXKQ/er?=
 =?us-ascii?Q?EpqsBn92rgv8Y5xcdEGu6TDp7PgGxShIIAFwaEr7gbpzy4eAYMWDTvxqJ3S+?=
 =?us-ascii?Q?CgFb9QFXFvn5z7yuO2Ljir5z5F4FmdxlzPwA6KHeYLfxHGcC++ESvSiXnrqQ?=
 =?us-ascii?Q?9ePgjakja3kWS+iRESy+bHQSxs8WSHXy0vW3800oSQMqwWmabEz5sVDE7QL8?=
 =?us-ascii?Q?QAiiPpH2unqbY4PBPH5baBucds8i4pOYnACSePPEG28sUZ9xxWMMbnKK8YIh?=
 =?us-ascii?Q?B0gc304EN/7Ru/xi+kvi4AeKdqv1R25LQ9Fcv4D/2eNFo6yZRlBbvC2OTpKG?=
 =?us-ascii?Q?UTGdGxWdStNDAQacOwi+G0FE3tk+UaOd6dAoMCJkkPzW9vpObC+OEOSX2tze?=
 =?us-ascii?Q?aFpf6UT+jxOPPFLFC0FlMYkRcSgtzJG8RO88zPFnjiGDdgzLzlRjQ53ZYtvN?=
 =?us-ascii?Q?IzeTQqglAZ3arm10DC1XDqneSvFwz/TM/WLY0swT3K1SzGy348jhC8iVsW++?=
 =?us-ascii?Q?aOfY+c9g8C+xef937pjnyA7uVYArXE0ABCKMs4f8eB1O3DzuONJmtHp2EvJJ?=
 =?us-ascii?Q?hcOFefm65ae6Cc+q6eA+7PxB8SSP9ua2CXcFDulMqvca9m/d1L7c6rSQ+I3q?=
 =?us-ascii?Q?eQYBRDxwhEY/tg06ELl71Xe8ULroV6FJOMgty67ARTZU6Jrd9zZEw9BAz812?=
 =?us-ascii?Q?4XfkTDAXJjMfDGj1RWYdkWvv4BDIMRIZHGiPxzvF+dBFNm0L9Uba/V0MwexD?=
 =?us-ascii?Q?8O7lb6IL4/8Yp7sFQpxTOU3Nt3fu/fmvF7/5/wGGfmhCdAhsfZIOJkKugdqB?=
 =?us-ascii?Q?NkTIwOfRLrb3AgqK2wPEjgoJU4PKq5ipWkbxFM9zjOago5YWBBZOyV4wDA3T?=
 =?us-ascii?Q?e+BQGU7pfe05rbUPIBp3JCaO20rWnYTheo9cHHFCcbGoWnka8Bw9+jyEQXxj?=
 =?us-ascii?Q?zotQZDwPLzA0F9y8P/dwUP/0Q7Z61SyFWInDL49f8P6aKzZNmx54zY6rCAFl?=
 =?us-ascii?Q?59MGe+BdVixTLTh5KZ11yWFNwOl2Z5tyNmQQ9jiUcNnyGFptHjv75f/FafFD?=
 =?us-ascii?Q?dwvf5RCJRkqlhX11D+UuX0GtYQ0n+J4Fv/7awg4cYZEKyq4gWcSo9yZ+KFWF?=
 =?us-ascii?Q?EJTZK4zbXQ7mfjh75G2k4Hkh9htpdiEfD5UKPhQbVedrpiuzPo3ns0ElNZDp?=
 =?us-ascii?Q?dv22Pn2pEBmDIok3U2YpO5rdrICsi9AJGuHQQ78ggKFGA317S4110mu0k3o4?=
 =?us-ascii?Q?Va7i/EwaiIObonNOCrz9DwJaRGo/F0rESxZVsjAnhQDoDafKsBxmbmqQzUSi?=
 =?us-ascii?Q?1kFkEU6Qu5IxXcz4pxU2hYms0zV7Sr/mOeT0olMtlVAF8FubyWuRLow4KvH2?=
 =?us-ascii?Q?zRJeBEpUp59hULBaLhDQs0rKKB4XzthxMX9H?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hBy7aWJuMAjS2aEd8Olv6SBpv9rNudatjIdIOGMtSb1fYCE7a4cUSwo8Icmb?=
 =?us-ascii?Q?flkYzN8WnJHC9LHhyu9KaDtW7bmGcuwfxCxPwK7R+ZEh6G5cVAL0QOHnb+Yu?=
 =?us-ascii?Q?eQ6PMom8YIgyYRQcJXbNY+9HmKWS5Qd8cGljJhNHnMgWIIay7R9bYsTWPbZp?=
 =?us-ascii?Q?VtfYWOwWnr1lJ+DV4drm8nnoBqYu2tQzVUk/Mwd/WySKEcZeVikVUC21lYLL?=
 =?us-ascii?Q?PfWO4ukiTPKlVfGfI8lEeLKOq1ZIODougOM52tiLvYf8LhuYn24KDHLhIDJQ?=
 =?us-ascii?Q?fz+L1uP4412B5zdH0t/SwIWXPIvz3yxqK7KKYR5nlbQOqbyld6p7Plk3ZKLw?=
 =?us-ascii?Q?wnJdGlylCfGCIPYOblYB82w7VeoZw8f63EwKQj7f597ZOl2jd5D6e3SyxgXN?=
 =?us-ascii?Q?r0lirA7GjoAHxAO1MZgoH+tCvB6RsvleozliwPXlMEztzkonpohREWWF50cx?=
 =?us-ascii?Q?HHsUQ2wsyXe5EdZ1muENAUM1E6OVrlAnYXyIThnO7537rOcqtlSOYUpxw7G9?=
 =?us-ascii?Q?ngXiAR7y9sMUVO2SpRdui3qrP4EfBrRi+v6sLTDFwNXBh2Vs7sg4IlR4T3xo?=
 =?us-ascii?Q?Tf9YkT/eUZ5JMlGpSnH+Gz7vD0WbRLnJgLTNbQjEfR1IUAMh7YtOQid3lXjJ?=
 =?us-ascii?Q?6KD07tZYmywbk37Pq7lXiQ+gM6uCGF/P7dkec9rBSpY7xrmAELRIqkcPiMUV?=
 =?us-ascii?Q?qiWTBSykPtPMfYSpnx8BIWUVh8xJh4CNifAz/ifHaflVEuqtgC8qgg2VNC28?=
 =?us-ascii?Q?lXViswnBfPtHevYi/rweSKveSinD+qt2SpFNDNMcxt2OEm9KRzuiI4BIRzh1?=
 =?us-ascii?Q?4euIkwAFZFH+Sb9lPRoOjtbiBPIlv2rb1oFyUQZsQkNHzo7qH3gQbUi2qPCh?=
 =?us-ascii?Q?nhMTqy9PhFAGl8BmmXf3zlYJOITChuzWxbrDGgerg4al6CbRHV0RL81hle74?=
 =?us-ascii?Q?0D473W4KZfoZr4RBykzOZVonV3qQx4YidaWfHe7FiQ/AosGZsCiYMZAUnnJu?=
 =?us-ascii?Q?FkOM778Jeth43LQoCPvo2NoRgwquLa5D8GOcJDYjKEJu8RUNpW4R9rMpZgfu?=
 =?us-ascii?Q?WsDswr/qXA2OR8Rp43sOwAppzPYZjyUn5Hr+A2p2PS33TvhrQHdMnWtILFe3?=
 =?us-ascii?Q?uJjYYrpUOPfdm3RQEz1SmtsH4HZCjlV3XEXx6thfWqk0oXj+8ge+H/iiGx4o?=
 =?us-ascii?Q?6GO5pssNnKC5VslKXVQXdALgh536iK5g7RyyIXGB7fUc2crIIU4D1dZGFgvY?=
 =?us-ascii?Q?XWTLXK4JiHMsWWY/d/3I7YH14FPbX9K9YxH+Qr0t4qxth/80d1lbcyVjwVmU?=
 =?us-ascii?Q?BDk6XZ8MRQdcmKAUk5Fdm6V8hNb8aI5AVZobY29LvFNcmcvjELj0K/EUUZS7?=
 =?us-ascii?Q?lgNFwpkLuADRC+IaV+UvPN7iuUFuccBH2lJmjgNOSEzl7q/yyNy5KXaDELl+?=
 =?us-ascii?Q?ZTpmdnynY5l3wmvrnSAAz3jSzyP5uFYoptmwPwg6VghKIYHf7VCXPxgzg9rN?=
 =?us-ascii?Q?ct6BWDpZCUAo4UqsgX+MEvJZk8oBpRKcs+w2kEbz1k1dH37ZjOwApI12Hsgl?=
 =?us-ascii?Q?QJZ8N4AjM8vFSgwXDP/c76XpPYo49TaCjvQMvcv9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ba80b7-d55c-4ac3-a783-08ddff747d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 16:23:13.6942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBGWeRhPKfVTLf1R1BS/GJkMg+1P9ygytZZMkjGDlFI1lh5LjN9eJoqScqNw51q4qeiKi4WCFZMOhjWPM+bwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com

> > This seems to be applicable as it introduces the new interface
> > while preserving forward compatibility.
> >
> > One minor question is that, according to "Figure 6-5. MBA Optimal
> > Bandwidth Register" in the latest RDT specification, the maximum
> > value ranges from 1 to 511.
> > Additionally, this bandwidth field is located at bits 48 to 56 in
> > the MBA Optimal Bandwidth Register, and the range for
> > this segment could be 1 to 8191. Just wonder if it would be

48..56 is still 9 bits, so max value is 511.

> > possible that the current maximum value of 512 may be extended
> > in the future? Perhaps we could explore a method to query the maximum u=
pper
> > limit from the ACPI table or register, or use CPUID to distinguish betw=
een
> > platforms rather than hardcoding it. Reinette also mentioned this in an=
other
> > thread.

I think 511 was chosen as "bigger than we expect to ever need" and 9-bits
allocated in the registers based on that.

Initial implementation may use 255 as the maximum - though I'm pushing on
that a bit as the throttle graph at the early stage is fairly linear from "=
1" to some
value < 255, when bandwidth hits maximum, then flat up to 255.
If things stay that way, I'm arguing that the "Q" value enumerated in the A=
CPI
table should be the value where peak bandwidth is hit (though this is compl=
icated
because workloads with different mixes of read/write access have different
throttle graphs).

> >
> > Thanks,
> > Chenyu
> >
> >
> > [1] https://www.intel.com/content/www/us/en/content-details/851356/inte=
l-resource-director-technology-intel-rdt-architecture-specification.html
>
> I can't comment on the direction of travel in the RDT architecture.
>
> I guess it would be up to the arch code whether to trust ACPI if it
> says that the maximum value of this field is > 511.  (> 65535 would be
> impossible though, since the fields would start to overlap each
> other...)

resctrl should do some sanity checks on values it sees in the ACPI
tables. Linux has:

#define FW_BUG          "[Firmware Bug]: "
#define FW_WARN         "[Firmware Warn]: "
#define FW_INFO         "[Firmware Info]: "

for good historical reasons.

>
> Would anything break in the interface proposed here, if the maximum
> value is larger than 511?  (I'm hoping not.  For MPAM, the bandwidth
> controls can have up to 16 bits and the size can be probed though MMIO
> registers.
>
> I don't think we've seen MPAM hardware that comes close to 16 bits for
> now, though.

While kernel code is sometimes space-conserving and uses u8/u16 types
for values that fit in some limited range, I'd expect user applications tha=
t
read the "info" files and program the "schemata" files to not care.

Python integers have arbitrary precision, so would be just fine with:

	max 340282366920938463463374607431768211455

:-)

-Tony

