Return-Path: <linux-kernel+bounces-894196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F69C49745
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CA2E4EBE50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D9332ED0;
	Mon, 10 Nov 2025 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1VqVAmr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6D21B9FD;
	Mon, 10 Nov 2025 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811560; cv=fail; b=ibMrEkYzckm0PK7aHL+QY8y2vcMUKzR4WcTEuxhgP8RmRyMIzzWQZVMSvxanpoh2zSufreC76kgOfUtZnzb1c02XiKtb0IJFvFDj78fLwynKSTYquIfvNtfIc/IL8Te3KtAJVz7RcThYXjCH8PGSFSN+pPqRE5pIpIv7IBFPlt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811560; c=relaxed/simple;
	bh=9H0ZT8PA3gkmscWuZdq4GnSRZQ4/6ksTv4T+h9YG8mc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fOjoCwdM2n5jXK46PHGV0fFr5ICrlIWQWt/r7WO4huqOF0RSkicV8d+tDerEqaDXtvcTUIqckEz6zNj80w4avZ1SHVXLFswckM40AYKWraY/vt3Azx7sFQv0BabbTUc1YKy4tultDmsLHz715HLgb59+3vy7movr52FdPeV3gCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1VqVAmr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762811559; x=1794347559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9H0ZT8PA3gkmscWuZdq4GnSRZQ4/6ksTv4T+h9YG8mc=;
  b=F1VqVAmrIV0rARZswX97mXwIYu4LsPHL/ZoERzdgFjgme4xi6k5IdO44
   SIHdfbj0MJddDKXAWKvttxKWjyVAxS2ELdAOCvbBEKuw/XqEXy97pO/za
   GembQzO9KauhPRa9pvI//s5018kIOGE47TSzSy5oUPDkQEageBG/s62TT
   gI/BYI5VcReKt1RPGkw+KUvI0soidjPThGpGoYm3M9pmZuUeDj6nIoE7R
   kPD/vIJQbMJoWxhjR4ZWdExbme3ZCbNwJQrCI3wdvi40rAi+Kz7zJke2M
   OycIweY4c2z1iPbhoPpQVwLgeLdLROZ7/NBbdxy74PUpxeRsS/4Hce/0y
   w==;
X-CSE-ConnectionGUID: eDRUULarSKebFi/zXmbDLA==
X-CSE-MsgGUID: EsOV8l8NQY66YQ6J6XNnVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="67474528"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="67474528"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 13:52:38 -0800
X-CSE-ConnectionGUID: OIX1ERY+Q1WHjOtjVj+/Gg==
X-CSE-MsgGUID: 6VjWfaWzQFSHW2vO6wvn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="219497802"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 13:52:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 13:52:37 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 13:52:37 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 13:52:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY7oAub//a8/krnHX3V6PYKtlJnjhy7vXZ9GbQ5nzqQiS4+URSRiZOochYC65Sa8Ic5pNGniXwEsJCCU6Pn9OLixRb0vvdyYsLFB0Woca4hn719GJleZ4if8o+dtNlojvR74RYMHTKSl1vj/q4lv5J+rw5/mdV2xq6Y9eFa+HrYoYzgbuAQz9JGpTRRbX8tOBf8F2QdDxVNX4l4hRO/IHW8o5dyf39wF82MtMJonnHrIS/bR7PZzbyYNv89O4j1vxcKY+R1U3wvVFg3YEiObHgiWddm8FMeB0NHMHj69dWAQ2OisW5XNrMnFZtLvU4pglsMaNcIXeW/tPbsuG8+Gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzUL0Jl2niH+K+NdIg0CYIxqK11+LHJTl4QXzCTEUo4=;
 b=vKn5YmV7RHLr6ddH4XCcw32DL3tjia7TAhyq362/1Teg7yiDN/PWs14yqacd1ceUg5kGrmmrwfzdc2GBhkYvyWUqG90H3d/253DjQqgan/ZSeh0kVsMb8PiecwO+FKuM/oviIfQX1XTGZw+kLGSjP9TKIRRfRI2aNHpU07kkUvI4rLxasc8BaRY5YmsXRU03tO60hCwanmEtY2aRlL2sl7gZNPfHOhFPo3NE5xxkQiV6ZE8G6WVorPmW+6hHdVsE4QmDY5QlRFbKdemnJrAUvCcpr/CdW7HGqVJbMYDlBi2g5zFXOrDpDZTrkpicZuviZr7lHM5qOePbjMI0y4Mbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 21:52:34 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 21:52:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, James Bottomley
	<James.Bottomley@HansenPartnership.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Christian Brauner <brauner@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>, Sasha Levin
	<sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
	<kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: RE: [PATCH] [v2] Documentation: Provide guidelines for tool-generated
 content
Thread-Topic: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Thread-Index: AQHcUhW8eCcx7eGkpEu2OqRw7hpCqLTrnE0AgACNcoCAAAVGAIAAD4IAgAAHVACAAAN9gIAABPgAgAAFDoCAABhsAIAABdiAgAABNpA=
Date: Mon, 10 Nov 2025 21:52:34 +0000
Message-ID: <SJ1PR11MB6083B928B445DF82EE5AE3EEFCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
	<653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
	<20251110-weiht-etablieren-39e7b63ef76d@brauner>
	<20251110172507.GA21641@pendragon.ideasonboard.com>
	<CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
	<aRIxYkjX7EzalSoI@kernel.org>
	<CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
	<A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
	<CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
	<20251110145405.5bc87cc5@gandalf.local.home>
	<21622a5393ef21413cae91d9c8ebbb8425d2c193.camel@HansenPartnership.com>
 <20251110164225.4b343fe4@gandalf.local.home>
In-Reply-To: <20251110164225.4b343fe4@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: c1af7a50-f5ab-4547-4a23-08de20a374e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tr2s17ysfkttO1KmschqkUz2owwGCJiwPHUxe3k/fAxCjd6g6BuCLnVNjbgN?=
 =?us-ascii?Q?yNFCmQ0tFVIb1YEhNIKEOxINvsbM0nusB3J9uHhVSf2z7ytRxePPNjYI6+/A?=
 =?us-ascii?Q?pXxomSCF1jxjv6lucEP8RbMfhBKADOAIsWYW9YGybP6UlEsSstKyOqly0oDt?=
 =?us-ascii?Q?nFUY5Ab7p4dIZrN7fZwC8bx3SinDtAcqSOQ5A04KpIy5IgArPa6txgqX40gl?=
 =?us-ascii?Q?Q8kBiaWhiel6Q4CRkKu4vdj4B96C7/BNbSt4dO8Vwl2igZwOGDLwT1yKMArM?=
 =?us-ascii?Q?flynFLz4L3O3mBZ1vct2IxoCynZG9ezP5dE8QxNAS2+VztFGx+ooCnsoUTvl?=
 =?us-ascii?Q?/Ivm8S6yVwWY+nHspO0gwtkgnOquTacwgJZ3AhUpPEcS2h4w9aaOrCbwWfeg?=
 =?us-ascii?Q?svnyuYzyW3LrbQe2R1ZSSRiTicNvqVkAYvk1wDMD1tQSXpzJmRJQ9LcvJ7oN?=
 =?us-ascii?Q?Wy+3VNwLJ18LxBNepmmRchryiVM+Nv2WvMGOgmsW3f9RLPXINZTrTT+QBCoz?=
 =?us-ascii?Q?KcBsy5zGxIiQBtPyfCTtRLotjxwF8+AlhO2gdFBoqFORvsqd3mEb+2VCI905?=
 =?us-ascii?Q?1EE3P69MAoP8QlpBwUPjGV9oxc9ffNyDR85m7pHPIQfjQQnB9q0HPN9vH0a1?=
 =?us-ascii?Q?eXxV50pyQOOUEaIHclFgsnx3Soo8ePH9KJ4mE+zZjDej+egXCdZ8khpvVgiA?=
 =?us-ascii?Q?+a+nd+aYGvUIy9Ah33iYafJjTNH6+auq+jJaAWKeQKRgwOxMxFRZ1Z6Vqtoy?=
 =?us-ascii?Q?TIn9KSwfRa1Xv7gphKWzNnwRjPGFMuZ06PpaCfSJgVqwTsL+LKbQMU5Opuvs?=
 =?us-ascii?Q?Vq/3W0zMxMKM7WwQ0kDbYpaJ+vT7YAnaki2NhQg2jeXRCmvFS3ml0MYqZZXR?=
 =?us-ascii?Q?i823u+TfFEGZRTJffMq9n2B+HWDmkXYac/wEqcYcRc9U5oCyaKlQA/hauagK?=
 =?us-ascii?Q?c6eCqWf8ds01ojVdpviMlPUMxLe8OKdPLlqCnjUAv/i0J1pP1dmE7vEtTLZC?=
 =?us-ascii?Q?xJQLUpbd4Kupp+1p/FgpkYm1+/2yFZvdzP9l+LqJ734c5/QrJRGMYkMNi8K0?=
 =?us-ascii?Q?OzEzvHL5/13HJ4VnpXJJo7VeYmuGhMfw1hGjvIHtBnecid5RJRsKbLVeQmh/?=
 =?us-ascii?Q?V7f0E4kLdDqqbBLzsk1xESo3uFpnCTR+9a1t+v+YWjyhFBK9iCDPEXwKyykC?=
 =?us-ascii?Q?SQc3US+J3kgBsnMLKGX4OQI7DkgWOWbIhPxoF1QOdmxxG+3gmvBEVDGcVIiT?=
 =?us-ascii?Q?+1UY4cbFxQCaOOIUk7138KvHdeeBUI4yUKTB5IExUXy7wAQfmV5xSzwOs/ET?=
 =?us-ascii?Q?qNFkMUFY+Gud06N5oxatpeDoW6gESD8GDAYps9W38PYelKfWNihLft7dH7lg?=
 =?us-ascii?Q?qHoE4oYMnlPPHI+bnZFO07YU+ulFiLYQJGDa0+EKJSdxPNo4Y7lxHTPq8EBg?=
 =?us-ascii?Q?taDXZvPrdViF+xTV2TStPXaNIxqs6gtpzOkeefs9+wVjJujQZxHzte5lilgM?=
 =?us-ascii?Q?zCDT8DaVlzRVH7Q5A1csINkCSnpqCXDyzorI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0PS8VUd59vfFNdVIMuS1V+R3sFcTi0mAc1sOHsaSmLDt5sZXTYs4QB/PMmM+?=
 =?us-ascii?Q?oSG+7CNTU3c8suuqacEscrbBlxWPRiNpFRmQ/iM++qrrINgH3c+/sfpG2enM?=
 =?us-ascii?Q?80bVm15R9eNB7ekHzJMx/lK1UDrn0xGFv1WhrcJ1ZOoBMwBkUCRo3abQYNg3?=
 =?us-ascii?Q?+MF71fMSSawW0Ee4HqacEZV5SLxMyUWIVB+ddepsSoDy16AYLNE+eC5gt+ZG?=
 =?us-ascii?Q?nRbeg7DIGCujloRKvKwqpm+57f9dtyugfFZxbEQRZo4sCLRH/Abl4DN8oF/j?=
 =?us-ascii?Q?HfKX3xojkDqhoafcwezO+OyR3B9m4lO2jrULUBf+PmUm/ynz17C8UoiZ9jSN?=
 =?us-ascii?Q?Q4zNAKhOaWvak4BQxMPLBFe2V8wKjFBRJ5JSuMOHbWOH/uMT6BhHMKK73K5h?=
 =?us-ascii?Q?yf5zS/dse7S5gfwgXWNuN6LHHuGfLLTG1mTv674v2xBzLR5+Y1nm9S+yrhq3?=
 =?us-ascii?Q?cxHL2WVT0w1OWfmj6O0SEFnpPGOojt1WeSqSJ9UfMbHhXMEAMfJ4KKJcWhcx?=
 =?us-ascii?Q?QpuRd+OJZhrw/n3iQLepJk9LtrbfBaqsqd7CQSvk28W8GLYJq4fXLQlw6buG?=
 =?us-ascii?Q?fnNaYrQVtbviNv1EKOcRsF/YCXIfhQLVwm+ORJjmU+ABkWjFNoUqlxRZlbCP?=
 =?us-ascii?Q?I1O53z1bBrYp47F8u15dIYikyVHyQZ1n3KvzCT+Y6wdOBpY1ZQpnA+OQQN/O?=
 =?us-ascii?Q?08mLopfIc8yru04y7IdXSCPPWnM7YojEGiOpjmFOYbwUX2+O11gqyZPjTwIT?=
 =?us-ascii?Q?+egLq629iBTLUsNPbs4V8PvfX252Kj/79S2iZk2mY6xsJNRFUhajFXGNiefy?=
 =?us-ascii?Q?EOCdSpQ3dtODLbpWAMStp95WWOSf22nJt1PReHrOF2AqTWaXF3FygtXP4XFi?=
 =?us-ascii?Q?u15PvN5beqH6zO8yloCtCN+a0Xlxxa2EmU6aciV3as14OGM679PNXOyM4a32?=
 =?us-ascii?Q?JzvlZAA1LQS3ucw2u+CLLjUgtbSm+K48lOglzu+H+GIx8z19srXNEhuDJCUq?=
 =?us-ascii?Q?h7J4RqdpOid6sAgFD7WPXpWh90oJDDckh89+6UJpoWV9atXXl09fAa26y1bN?=
 =?us-ascii?Q?X4pvn6n49qYMr/3aXrVf8t39Q1Fbzx6X1AkmCqas+liqMdvCqZHyda7ODiRa?=
 =?us-ascii?Q?RaV7VN2gIes1Q4OLLxyco3Ecoc3KbxiN+tKt3tVyNIjdJLoDPfLKd+5PrnAy?=
 =?us-ascii?Q?pJb7yTtAHRVeoOEBUYBmdiz2Zv6pj1ciJqUY8noxRHDxw0+8raAh5vAlqfm+?=
 =?us-ascii?Q?NnCPXi6nEVrZIQJTfnscqV+Y67LFE8JzoG133w2VT3hV0XyhPWVZZwWLfQ79?=
 =?us-ascii?Q?EqbDkLb1/zoKA89Qnoky0Cb9bx03Tdg4HbpUa2j5U+C+o57iNVq062l1XlWg?=
 =?us-ascii?Q?8wnVPbqqjlNLQPmezUASQ5EErrsO7FeidB5ryxAsCKl19gUhUJ/QBf4thFB9?=
 =?us-ascii?Q?RjLRJjeKufGI3ebcrrm50Fhu9Pn53NNdZ4CxBCYgXwalBPx6ztZ+39II8HPP?=
 =?us-ascii?Q?gOpCkrTclVajtLIbGwqhCsZzFzMpupgfvtbtyobt0lGt+3ewhRX0UwfTkO2I?=
 =?us-ascii?Q?Wh7nBDom/7O366thCNtHsMRWLDkc6eP4Upfnbga+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1af7a50-f5ab-4547-4a23-08de20a374e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 21:52:34.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyT3oCmglRDoaFRhkeIRdEJg4UXi8ZgaovFHsRHkx84gHok7kSXRyWnwdDEdijkpSL00Q80d4jIMwHzwSvMHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
X-OriginatorOrg: intel.com

> I believe that's what is currently being argued in court. If AI is traine=
d
> on human content and prints out something based on it, is it a non-human
> creation?  This isn't a case of a monkey taking a selfie, where the conte=
nt
> provider is clearly non-human. This is a machine that uses human created
> content to derive new creations.

If the output were deemed copyrightable, who should own that copyright?

Option 1 is "The human that crafted the prompt to generate it"

Option 2 is "The corporation that spent vast resources to create that AI mo=
del"

Option 3 is "The owners of the copyrighted material used to train the AI".

If a court ever must decide which to pick, it may well pick the answer requ=
ested
by the best funded legal team (which would be option 2).

-Tony

