Return-Path: <linux-kernel+bounces-741054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01747B0DF84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B01D3B6891
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908B2DFA46;
	Tue, 22 Jul 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWlpQZU9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FA450FE
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195675; cv=fail; b=OPy9qhhX4QOh+zG0G5KILEQDzUotQ+/OND/V3kZKTwRhpy8/UPt72mKrnldYp+68hVGXhr/Ogcy8PA4Jvfkt0I0vvurDmwfBa8ptd+Ds5FKk23Lg6XcgrTZ7mngvTwHUjJEzAD0PLN5zG3Ex1BoDb6d99TPo0c/PHhbSXMcHk0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195675; c=relaxed/simple;
	bh=nnrOknk1JxAggwXnLyBvvqh0QrG991Paj+7evKf/La4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soFGuTE2+MR+5Z7owGibwV0VWYCwNIhkz1O/5oudU83BjwMU6CWwPXCcbRWFqRvoaVKYi3P2QSAblaggunu7EqLmRqzAO0PG+sn5xcs7rJAxeDdVHlzzCo6CG3hLp5SoeYpPwZPYRBVxMKSy0S+sKre3h9Fe3vnmbdGvGV3dLCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWlpQZU9; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753195674; x=1784731674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nnrOknk1JxAggwXnLyBvvqh0QrG991Paj+7evKf/La4=;
  b=NWlpQZU9y7I/A7Tyj5wRQRl7lgwTtwLSOtZwUXjJPVBvvPXlxMr8Hln7
   jmsakuI0R1xNvgjxFCzYo9mQ8HzpL4+IDEFSCBk/pBsMN1w1tiiCGJd+q
   MUTjX/IYcmLnXADk6hJElFit6nO+fuxTinsZW+HvWBt8fA3E4hCdPP55K
   C42XDsXWJVBKeyMbIA+gDsL7OJnjFK2ZELn7YCckrOsipqYowTxe7ZTaq
   JKk22luLS84valjTJJF51wgXOd2NM8blnARD6LdtYwh340el5dgyXa+HF
   oYSnf9/EdiMSA/cyMb29cexJv1xB/kYV2wf459V5ar7+ajKqVkYicNbDa
   Q==;
X-CSE-ConnectionGUID: mKRubK94R7aBjXwQmkaSFg==
X-CSE-MsgGUID: /x/SLiS/TKaNmJUFVbodQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55295517"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55295517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 07:47:53 -0700
X-CSE-ConnectionGUID: bvOsX7jdSsmINsOgvV719g==
X-CSE-MsgGUID: SKOkyKsTQpGS1gcCdZsHog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="190127808"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 07:47:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 07:47:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 07:47:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.84) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 07:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0EAR8P9htvw1bxmqwkFPdhXqZUJs9WSjnhY87zg8fvFm9tVLZS/P6rP1tAXlo5qTIphZdQxIUEinVpQZaMxgzRIFcG5PDbr69O0gsQaF29eg5DiIg+X/FQn7cHXVtEMOGWXITbDSR5UeZFbc5FQRSRf4RXZdnyh4BDQ9ubOP/pcZJgLko3SQjSWb3RMW6qL37Xkm70vYP7RZZmjSy23YtvzmdJbMbHkzsLYIef2vTbKNFqz3HqG2E+Wp84FkOCc25anjYciGQoRBQ5bCFQ+iCBuKD63XLJDk40HFbcgKCScJWDWtqPRtpdWHMGIB0Lgk/m/80YdEWoh3p1kepCeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnrOknk1JxAggwXnLyBvvqh0QrG991Paj+7evKf/La4=;
 b=onraxYR0/GQzar1xK0cn3TPt8Fq7nCcNy7U1L0jKXx3yt95fin1OD5SP1DABw2YIZPi//dQtU9tdXZrpyGFv8QtiOol0ZmSYtZ2BrUCxPPAbde+j76SWP8fIOK9ofi3AOFspCmzG+rKB7xYE0cXARbiBreduo/lQpGy2t/FX1cA50VbM8gU/XYle0OEnPlnTIm+jvQnBEhTpd5YHOXguj0iwazOZrw/eb30SGS2rCblrmQgaq6ZDA+jkL8UK/tlRafRxhEXoxw40qN5ejyIScem7yMEJkq5Bz7URcrwJZnZCcSMgjBO1alapAUO/ZUfvhb5mvStC6AUdXOi/v/4qgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:46:56 +0000
Received: from BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff]) by BL1PR11MB6003.namprd11.prod.outlook.com
 ([fe80::4584:bb9d:44c:1bff%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 14:46:56 +0000
From: "Deng, Pan" <pan.deng@intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Li,
 Tianyou" <tianyou.li@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@kernel.org" <mingo@kernel.org>
Subject: RE: [PATCH 4/4] sched/rt: Split cpupri_vec->cpumask to per NUMA node
 to reduce contention
Thread-Topic: [PATCH 4/4] sched/rt: Split cpupri_vec->cpumask to per NUMA node
 to reduce contention
Thread-Index: AQHb7udDyMK4V6hIvkeMjCqbD/13B7Q8hhmAgAHKvVA=
Date: Tue, 22 Jul 2025 14:46:55 +0000
Message-ID: <BL1PR11MB6003E8FFBFA2712F4E61FAB7965CA@BL1PR11MB6003.namprd11.prod.outlook.com>
References: <cover.1751852370.git.pan.deng@intel.com>
 <3755b9d2bf78da2ae593a9c92d8e79dddcaa9877.1751852370.git.pan.deng@intel.com>
 <36eb3d2e-03f3-4829-b0f6-94b0f3371629@intel.com>
In-Reply-To: <36eb3d2e-03f3-4829-b0f6-94b0f3371629@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB6003:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: 9b27234d-4cef-4239-cd4d-08ddc92e9ae1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDkzZU00ZU5ram8yRFBKOGNSRGFScWFPaWFrc1ZsNXkweGQ3cS9mSzQ5VWtt?=
 =?utf-8?B?V28wN1BTZnUxcHNPRzRvSjlQS3lwRWR5TGdUS1RwQ25JaVhWb2Z1d3hVWFdX?=
 =?utf-8?B?WFRIREtXeWY5R01oRUNMS2hUaWRnU3R3REg0NDg3L3ViQ0J5Rk5TK1d5bDBZ?=
 =?utf-8?B?YUdLWFAxdEpGaVdKbkxUQUtLdFF5QWFobGRBWXJCZlkxaEkwd0ZDZUFyZEVh?=
 =?utf-8?B?UVAwQUFiT1g2Nnp2ZGpDSnAzTEtGaWlPSk5RaEo0L2N2M3hrSnBlM3E0SU4w?=
 =?utf-8?B?aHVYenhtMnFZZDVDUXJVK3hOdUJSMXZMQ3hPSEEyZWtiMTNodHZid3QzK2ly?=
 =?utf-8?B?ZDQvKzNtS1owWTQ3S1hMamVRbUhvV0VxQytsMExGTjVkdGx0N0trVmtSM3dq?=
 =?utf-8?B?U3NYcFFVSmY5RG9aUlVwSGZZdHRuTC9IeTRvR1pPd2R0TFFWUmhIaDROZE0x?=
 =?utf-8?B?N2tZMEFqRk9YV3VqbEQ3NVN1djBWZmdPRzNIb1FneUQrWWdDdlRtNndETFlM?=
 =?utf-8?B?T013aDVxUkxsbmlGR01qbkVPOUZKK0RYY3pGbHBYa2lMMjlpNEhCTVlDSm11?=
 =?utf-8?B?L3pxd3p3VVhOc3BMbFRPd1hnTEcwY3ZVYTh0MTZaV2dCQ3pSWE9IeThHQUxJ?=
 =?utf-8?B?ZmVsR2dxYVc3Y0YwdkFCNE5KUExDSFJGaFpDWUErT2lMTVhqR2JWNUxSd05m?=
 =?utf-8?B?NGswYW1ORVF2UmpmOE4xcVZiaWpUeWI3YW92WlJiYWFtL2pOQzNtZ0FzTFdH?=
 =?utf-8?B?UUh4TEtkV0FxTGd4R0NMN1pFZHZGVUhHaEdGVTU2T1R5MUxmR0g3ZElyNCtn?=
 =?utf-8?B?WlVXUEhKVkp5NVZNR2hubjN6bzNUV3ZUODBza3NYZ0Z0ZmJWTGJ1enpuTEdk?=
 =?utf-8?B?TGlqSG8zZnQ5MWNweFdGQ1VZRk16LythOW1rOGJ2VHlPdlUwc3dyTTJGTTFH?=
 =?utf-8?B?RGtHUTNvYXNIeUl1QWtKMTlETFFnZDkwMVBEZmMvZGFtM0VVemRpUHRkWlk4?=
 =?utf-8?B?UmJBYURtNXF0NldLZ2FZMFBWMjNud3VVdjBrODduSk16dE1SYzF5QUJRaGln?=
 =?utf-8?B?Z2hINUhNdTQ1OFZOLzNQZUdBZU1nYmZkWVJISFZXM1RIZFVmSlZxcFFWTHkx?=
 =?utf-8?B?YWdqZVlPS2VzZUVnUHhPTGFTQjY5anljb0RMS0o2amRVVjhUOHBHeVBvOTRU?=
 =?utf-8?B?TU9LTVNXcU9xdk5pczF5NmVCQ053NzcyNkpDcStDRmdtRTlTdnJDM0xJczM5?=
 =?utf-8?B?bWw4Ukw0cjFVUlNhRytLTEt3ZXkzTGFGWDJaRW4ybWptWloreGlOaHFteXlK?=
 =?utf-8?B?aDlKRlhqdXJKLzM0WXdIa3ZPWVRBOVUyWDlLVi9hNThjQ0VmbDNmdFFQSmlr?=
 =?utf-8?B?QURIVFJFRlpKbFJVSzJxRm50UTF5N3BMU0pyRVRQWDBNdlVlUjZVVGtwOE9X?=
 =?utf-8?B?QStUWHJpOGlqdFJRZHRadnV5WVRNRXZVM2gwamdQVUVCaGd5RnROV2NMbGJn?=
 =?utf-8?B?VWdwOVNBQ3h5YkVNbjA4aFZwSU40V2thWStJNTNGSFBzOTdSaTFmUEpNWDg2?=
 =?utf-8?B?alJtWFJnTFRlemw5TVNVMjZGVDRLTjk3MUdEZnJuUW4rUDkzc213bDRnT2RM?=
 =?utf-8?B?Ky82WlF5R0dIUzhheWFrRFVSWXpzSVFGVEMrRGJpU2wxa0hLRE54c2wvNGZI?=
 =?utf-8?B?Sjl2WWF4Y05ZV3lFdE1icTRLNXJDOEtQd1c4K09ERmRvZy8xbTlEM2pUNHBE?=
 =?utf-8?B?aVg5YmtEK0FqdTZIWjRmNkdFU3ByUkxuYVpxb1JRTWt2Wm1OR2piK2hHNW1B?=
 =?utf-8?B?QUFPWUhUS0NQcEtobE8zMlhqazdwYjVGdVlxT1A5OVJ5YTI4ZVlJaDFJWEZG?=
 =?utf-8?B?QVdrTDQwZ05ncWQ1Q0owdXNqSjlyY1V0NTg5RVlkblZZcExma0N3c2pyUmMw?=
 =?utf-8?B?dGQ0alJ3NkUzUDM3WGFINkJQanFXcmlWMmV3YWNwSG5mMjhreVVsdTVua3h2?=
 =?utf-8?B?Y3EzQ2RhYlB3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB6003.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHNJUjRkTThQSlZpTnlGOHN1QlY2NkxZS0VHeWVMa3ZQdUx5MVB1SVNiR2Zo?=
 =?utf-8?B?Z1IrcUR6eWdCajkxMGtvVS9TUDRnenFuRU5rRGFrZGwyYm9teGt2cHMrT0dR?=
 =?utf-8?B?ZS9IekFxckhCdGt5Vm1OTlBJSFg5dHpzYVVUOEE5Vkd3bkZSOUNLVE5SdW1Z?=
 =?utf-8?B?MlFlbGhTSUZreG1rbEpmN3U5cnNpMTZsR1pVL1diNDVmdXcxVDhwdEg4VkdV?=
 =?utf-8?B?MHVZV2d2V3ZMTkpnYStvUDFpeGdjblJLa0JkYXFRNW1VRE5STTBCUHRwRUZl?=
 =?utf-8?B?ampVREVnK2J1WVpzWDRQbE0yK3FrWXQ5aHU5K1kvUWdWTDBNRFNHUnFLVFd4?=
 =?utf-8?B?cHZiaVdJZzZaSGFocUF0MkF5bVBlc2pNcnN6WDN3TW1PTU9iNGlZTTY5dklJ?=
 =?utf-8?B?ayt4TGdzbEQvWDlKU0tIbTJwUkRmQ0k1QXFORXFiK0VRSXI5bkFMTm9EOWtH?=
 =?utf-8?B?RkVYaTBONW9xYjVZUVZaVmZWQjVuQm4zVFRGN202THBqSEFzSVBlQ1BXWCt6?=
 =?utf-8?B?cmo2WUVUQnZTYTBidU50M29yV2ZBQnZOMXBhK1I3czZzTWZ4VUpFVVJ5Mjlh?=
 =?utf-8?B?Ky91RmVOak1oRkZ2bVBJOFZxNGpQUG1WcDY0VVd2bjllNnlzOFVQSkpxNnAz?=
 =?utf-8?B?T3hsdzZBMFlIU25tOEQ1ZU85d1NCNE10cTBaMm9rQjlTSkVWQUxrTmZjMXA2?=
 =?utf-8?B?Qm96YWRmT3g4RFY4eHFzeW9jYWtOMlAxWnMvdFc4Tkk5WlZ1VDI3b2c3aGEv?=
 =?utf-8?B?YklML1FWdzNYM0pSdkVFREN2S2Q3cWdKNWY3c1FiSkdiYmhjeGxKcXhEbENB?=
 =?utf-8?B?clIza2VOU1d5OGN0Q1ZqMHUybWdxUktEczhuL1VIaEhTcmxEVWNIT214eTNV?=
 =?utf-8?B?R3QwRW5yRVRQRXpLcjEvUXRsYzJtUU1qNHZkWFFXeEZXUHNwWk13WGw2T3cv?=
 =?utf-8?B?SnNaZkZIZkpxaHo3em9yUVdpd0JJenhwQ3pCNmJ0OXMxNGhQYXJkaVAwN2I1?=
 =?utf-8?B?czhETXozOW5OM0NpRHBmUW1COVdRbnY3ZFJqTE9JcitxN0ZSamwyOENwYkZr?=
 =?utf-8?B?TlZkTkhEdnBGZS9iTHJ5MTZLUHFNTWV5VnJLT0lrVm1qV3ZnakhiTFhSMFh3?=
 =?utf-8?B?L3pPcGQ3c2RoT3RpenJOLzcvRzN2S0U4cjJURTA5TmtvcXBEc1RUTjlFUEpa?=
 =?utf-8?B?QXBNbjlkYXdUOWovMTlkQ0IxMnMyQmNoQUZvaURPZE8rRVlLemV2VEpRK25X?=
 =?utf-8?B?eVVWK0tYRk40SWdQNVllVjdBd1luQXBjUCt4NGJLejR1YmFId1ZJQzN4SFhx?=
 =?utf-8?B?NDZncjc0Y3p5c25sajZLSCtHNS90NGVLcFdnVHpZWlFGV09LK3VmL3l5dzFw?=
 =?utf-8?B?YmFxKzVVM1Y4WWZwMERZbWI3MXFDcXpjYldYcEhJai84UTJGcWhFYmxlQlgw?=
 =?utf-8?B?VlNzaG1uT25ZdTdwUnV3Qk1mMk44ZU85MkRoeGF2R09hWXRsK0Q5eXB1SUZ1?=
 =?utf-8?B?K2o0N1ZFa1B1bC9ZM2VmVmpaL3RBSzE5M0kwQXhsUlZFTWlsRStvRks0NTRo?=
 =?utf-8?B?aXNpQ2p1dHJ0N290TDlJc25QeS85bGlxVURZVnRMb1V4dHJmQjN1WDVFWU9G?=
 =?utf-8?B?b0U1cUgyU2tUL0hUZDU0dVc5VkFoeVhwWnZXM1UxcmdiWlNGVFFTeUVPb3Zz?=
 =?utf-8?B?NFBlOG0veE44Z050V2VOYjN1UHR1TVhnNWRQVlBMVVRpUS9tcnppNnVVR3Zr?=
 =?utf-8?B?aTZMS0pDWWI1TW5DaHgxbUxaK3ZwaWdZaVJjcG1oOGFiQW1KZlVkRVMvV2s1?=
 =?utf-8?B?eHZVb1VvMnhpTk1pK1dwR1Z3T3AwaWVQSDA1MDBIbi9UUXRXMm9nUktQUDN6?=
 =?utf-8?B?WnVMZ2NLNHlUQk1uYmVsVzJhQ0FndkU4cElxSlBNek5uR0FRZUNrSGZXa1JO?=
 =?utf-8?B?bWFBaTN1SFNzNlJpSDVuM1hORXlVZ1dJaDY0Y1BqK0c5Y1dPN3E3WWRmazh6?=
 =?utf-8?B?bFZmaGJZMS8weDlXY3d3VXRiZGZEekloSEI2YWQ2bi90NDVCMDI0bUYxQVRX?=
 =?utf-8?B?Z1hkT0hlMkxMOWczTXZXTFdwSXZKcXUzbHR6VkovZE1lQ0FJR3FEaUlhaDJH?=
 =?utf-8?Q?BTCWwUPNS47fK303rFTLLaCKk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b27234d-4cef-4239-cd4d-08ddc92e9ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 14:46:55.9883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIybEXe+6F3MBzIvhmFBtHTtw+tUAhnCnUoIycfSvTKRgC+ZLE3CNjF2o+Xyk/6h5uc+S4oHTVPv679EgMJMng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW4sIFl1IEMgPHl1LmMu
Y2hlbkBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyMSwgMjAyNSA3OjI0IFBNDQo+
IFRvOiBEZW5nLCBQYW4gPHBhbi5kZW5nQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IExpLCBUaWFueW91IDx0aWFueW91LmxpQGludGVsLmNvbT47DQo+IHRp
bS5jLmNoZW5AbGludXguaW50ZWwuY29tOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgbWluZ29Aa2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNF0gc2NoZWQvcnQ6IFNwbGl0IGNwdXBy
aV92ZWMtPmNwdW1hc2sgdG8gcGVyIE5VTUENCj4gbm9kZSB0byByZWR1Y2UgY29udGVudGlvbg0K
PiANCj4gT24gNy83LzIwMjUgMTA6MzUgQU0sIFBhbiBEZW5nIHdyb3RlOg0KPiA+IFdoZW4gcnVu
bmluZyBhIG11bHRpLWluc3RhbmNlIEZGbXBlZyB3b3JrbG9hZCBvbiBIQ0Mgc3lzdGVtLA0KPiA+
IHNpZ25pZmljYW50IGNvbnRlbnRpb24gaXMgb2JzZXJ2ZWQgb24gYml0bWFwIG9mIGBjcHVwcmlf
dmVjLT5jcHVtYXNrYC4NCj4gPg0KPiA+IFRoZSBTVVQgaXMgYSAyLXNvY2tldCBtYWNoaW5lIHdp
dGggMjQwIHBoeXNpY2FsIGNvcmVzIGFuZCA0ODAgbG9naWNhbA0KPiA+IENQVXMuIDYwIEZGbXBl
ZyBpbnN0YW5jZXMgYXJlIGxhdW5jaGVkLCBlYWNoIHBpbm5lZCB0byA0IHBoeXNpY2FsDQo+ID4g
Y29yZXMNCj4gPiAoOCBsb2dpY2FsIENQVXMpIGZvciB0cmFuc2NvZGluZyB0YXNrcy4gU3ViLXRo
cmVhZHMgdXNlIFJUIHByaW9yaXR5IDk5DQo+ID4gd2l0aCBGSUZPIHNjaGVkdWxpbmcuIEZQUyBp
cyB1c2VkIGFzIHNjb3JlLg0KPiA+DQo+ID4gcGVyZiBjMmMgdG9vbCByZXZlYWxzOg0KPiA+IGNw
dW1hc2sgKGJpdG1hcCkgY2FjaGUgbGluZSBvZiBgY3B1cHJpX3ZlYy0+bWFza2A6DQo+ID4gLSBi
aXRzIGFyZSBsb2FkZWQgZHVyaW5nIGNwdXByaV9maW5kDQo+ID4gLSBiaXRzIGFyZSBzdG9yZWQg
ZHVyaW5nIGNwdXByaV9zZXQNCj4gPiAtIGN5Y2xlcyBwZXIgbG9hZDogfjIuMksgdG8gOC43Sw0K
PiA+DQo+ID4gVGhpcyBjaGFuZ2Ugc3BsaXRzIGBjcHVwcmlfdmVjLT5jcHVtYXNrYCBpbnRvIHBl
ci1OVU1BLW5vZGUgZGF0YSB0bw0KPiA+IG1pdGlnYXRlIGZhbHNlIHNoYXJpbmcuDQo+ID4NCj4g
PiBBcyBhIHJlc3VsdDoNCj4gPiAtIEZQUyBpbXByb3ZlcyBieSB+My44JQ0KPiA+IC0gS2VybmVs
IGN5Y2xlcyUgZHJvcHMgZnJvbSB+MjAlIHRvIH4xOC43JQ0KPiA+IC0gQ2FjaGUgbGluZSBjb250
ZW50aW9uIGlzIG1pdGlnYXRlZCwgcGVyZi1jMmMgc2hvd3MgY3ljbGVzIHBlciBsb2FkDQo+ID4g
ICAgZHJvcHMgZnJvbSB+Mi4ySy04LjdLIHRvIH4wLjVLLTIuMksNCj4gPg0KPiANCj4gVGhpcyBi
cmluZ3Mgbm90aWNlYWJsZSBpbXByb3ZlbWVudCBmb3IgUlQgd29ya2xvYWQsIGFuZCBpdCB3b3Vs
ZCBiZSBldmVuDQo+IG1vcmUgY29udmluY2luZyBpZiB3ZSBjYW4gaGF2ZSB0cnkgb24gbm9ybWFs
IHRhc2sgd29ya2xvYWQsIGF0IGxlYXN0IG5vdCBicmluZw0KPiByZWdyZXNzaW9uKHNjaGJlbmNo
L2hhY2tiZW5jLCBldGMpLg0KPg0KDQpUaGFua3MgWXUsIGhhY2tiZW5jaCBhbmQgc2NoYmVuY2gg
ZGF0YSB3aWxsIGJlIHByb3ZpZGVkIGxhdGVyLg0KIA0KDQo+IHRoYW5rcywNCj4gQ2hlbnl1DQo+
IA0KPiA+IE5vdGU6IENPTkZJR19DUFVNQVNLX09GRlNUQUNLPW4gcmVtYWlucyB1bmNoYW5nZWQu
DQo+ID4NCj4gDQoNCg==

