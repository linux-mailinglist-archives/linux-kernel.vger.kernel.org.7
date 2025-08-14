Return-Path: <linux-kernel+bounces-767756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4055B258B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F488845C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9AC13EFE3;
	Thu, 14 Aug 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIclN091"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0CB672
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133230; cv=fail; b=F6V/grRcPRSTZ3s8VReKI1jhB6qJaNXke7gHzrJZbunZoGwG77/Ki1wGG13LUCWFRfV0pu/DEl4pSaTSot0+gJLvT+ZDwiSTstEsqpZpHU5KtUnOPvdh9pEv1HlUbhdELQv/6cOgzOUEC/7qajvhZOOxRETirbFEWFTh8qUOYEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133230; c=relaxed/simple;
	bh=3dwqK5w8Mra8J3gwxHODBhR4gJEOubQBwx9nVtr0Nvs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NTCjevXLZtIXqdekYUeKqXOLAcsSEWK223FFjwTdJtX0My0mLLoWz39whHRkiUNH6xGKdUGIqat1sT7s2U3L1yNmV/Di4cNldCsKTFEm/CBd51GQlBtHtf71NbSi2AjoTgTRUqtQi1+5j9nUDm2eVSjdT351Ue6VJP7zQwpwzWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIclN091; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755133229; x=1786669229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3dwqK5w8Mra8J3gwxHODBhR4gJEOubQBwx9nVtr0Nvs=;
  b=HIclN091LcR7TInSD0+ttNZSBnKRdmVpd0tOPCaRSmSevRAnVqOPesV/
   T8GRpr3NjWYerbqZ7dAUwLYSnGRXV6NQTkJqWastWmzxOhaSRsBPPBIzV
   1yep0vh4721eiW8knOHUqZGfcgxVeJ9QXeDjXNkg/2Klp2J5kaYJpGCA+
   h81qLI4kd/Y4/PA0a0bOgoXYqJR3xf29/DwPz8iddMgO4tBA1dnE0HFWx
   6CjFGPIzOuZFVSGKhGsHqJVv2w7WXJCQNQQ9Bc7JpSAjZnowMx4E/7f81
   Zp3UiUTgvO0QdC8N3MFmU+/Sw/tXptrvD6UKHD5bOKNuiVBiWFZOl2l3w
   g==;
X-CSE-ConnectionGUID: +LTkl/G5T5a6tHqH9IQ1zQ==
X-CSE-MsgGUID: GyppRMkCScKj8rtt83bFZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68896703"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68896703"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 18:00:29 -0700
X-CSE-ConnectionGUID: YZdYnHyrTJm5x7le8/cQEw==
X-CSE-MsgGUID: 9f0i7YQaTbylrWLwSlmhgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166608441"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 18:00:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 18:00:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 18:00:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.54)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 18:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SypzQmw46CnkI9WVJ4jFgx7yMexpBxN4MLULmcj2BOJSMT+aKUKWU7IIcI6QhsAy1tPk7noYHIOd1joDdzKrmy9Ygd9U+ouao+vUx6k6o+bWFXdFkr3Pop9kT2OJlgdVWRtbstixodjxTI3zwgCKP8hOkAvJ8sPSlKEwEyHNzvPUsFWR7oX77LwqwIxdLxwN0VS593aKWHqcbztirpg2vLkk7dJOY8JgXk+jPFwLtXsQL5MSlo7Pmx8OaRNraEpjBbWm1F+QSwmCdBjWQveZPjFhelcUypqoAbVO+z5kkVDhgZ0CMg2u+b1o2ALvCKdg0kHVkj8yyezIXSHRFXlR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnCjXmKmrcDT60/680K4DBcFxep3M9x9U0171L7mXco=;
 b=JWUfPNMJDwe2DHLZUS/eFjLlzuah2nrIdl5wM50WuXoz+U7OJeHYhU0ioM/ZwPg4OBsUWyVPVvyC3N+lwbVyZHkGtesiQ5cCLzcCXh/qP4v8xjzG7Oot7L8V7aRhy10XYVi7pHOyO8wjvxtiAFfciysRINZxIQDsgEi6WAZ6EZ036RtXZTJ2mKziagrRZgcMaOViSFALbMYRKFO23jc46TNnox+K7a8wvkovFBms8vFSsWNem2n2R0pYQa8q7be0o3UN1rSeQPvhJm7gQrGDOeNCWsrSJKbFFC+pgvahy09lMFBpMVP6XoiS1QKeV8jjXgjg/+zbNowwfhZ9xCWJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA3PR11MB9461.namprd11.prod.outlook.com (2603:10b6:806:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 01:00:25 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 01:00:25 +0000
Message-ID: <084b7506-028a-4213-8523-57610b498837@intel.com>
Date: Wed, 13 Aug 2025 18:00:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
CC: "Lai, Yi" <yi1.lai@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@intel.com>, Sean Christopherson <seanjc@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "Chang S . Bae"
	<chang.seok.bae@intel.com>, Brian Gerst <brgerst@gmail.com>, Eric Biggers
	<ebiggers@google.com>, Kees Cook <kees@kernel.org>, Chao Gao
	<chao.gao@intel.com>, Fushuai Wang <wangfushuai@baidu.com>,
	<linux-kernel@vger.kernel.org>, <yi1.lai@intel.com>, Jens Axboe
	<axboe@kernel.dk>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
 <aJVuZZgYjEMxiUYq@ly-workstation> <20250808074948.GA29612@redhat.com>
 <e46bab92-ee1f-478f-8076-d46bd3fe9411@intel.com>
 <20250808151131.GD21685@redhat.com>
 <39edf291-d842-4ae1-b988-76dc3688673b@intel.com>
 <20250812125700.GA11290@redhat.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250812125700.GA11290@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA3PR11MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d2e55a-7169-417c-19c8-08dddacdf3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emU4NUt6RHNZRENFTzNSanJSeWhiOVBBTS9ZUGtoZ250Q2NHSkUzb2ZydzhV?=
 =?utf-8?B?OGFJNWJ5N0RyNWkvWlZJUFIxTGRmWjFpMGM5aHVWVXhrSFdlOTdJUlBaWkVW?=
 =?utf-8?B?ZE9ZNXNWV0dZMGxqbkdMcnI4aFcrek80eVVBVW53THFCbDIzcklSS3czUDVt?=
 =?utf-8?B?Ujh3dzM3Mm1TYnI4OUVUTThIZFV4bUR0T3ZWUUUxdFJhSUZTYU9FODZBUzBG?=
 =?utf-8?B?cGpyNFlJUWxyRXVQYjRxWUlvYUpnSkx1ekhsdG4vclM1N1IxaHQyd3lzMFVF?=
 =?utf-8?B?MjBLcmRPdHpCN1NTSEp2VVdGL0drZkxtY2ZMdDNWRUNSWlpGZnliRmQweGMy?=
 =?utf-8?B?K3pWWEdQeWoyeDhlTUlxQ3ZIUjdQYXNJMjRVS2lUaHRVVC9wcnN6QWJuYzlu?=
 =?utf-8?B?dGdqRldzc0FhQ3lKbTlwS2tJVUx2Znp0Y3JEQmtNOWxMZFF5QW1wRG13Q0Nl?=
 =?utf-8?B?ODQ0MlIrTHVvZlBkTU8xYzdtNi9JNnBEcWpFZU5FbzYrSzMzQWFzL1pBb1Mx?=
 =?utf-8?B?KytTWHZ0TFFVNWxCOSszQXJwSi81dVhXblA3OEEyVDA0V1F3ZG1TS25RekVa?=
 =?utf-8?B?UU1CVmlLMUdUTTc1bVpZTk5LaG9VdUZZYlNJb0MrUm9Vc2ZMYlo0L0k4WFIy?=
 =?utf-8?B?S282b2NKQzhuYVR2YzNzZWdqYko0VzlSdDlxbThCbE9KOEdOTjNUaFF1MVpo?=
 =?utf-8?B?OHoxaDI0Z2UwNXEwMWd1TEh0em5uMEV3TDFaYTFVSWxJRTRJcGtnQXdLR3do?=
 =?utf-8?B?RDFZMHJ0Ymx0WHliYjlvNmRFMEVFaXVDWUdjeFlOaHF5T2JpTi9oZGhCdVY2?=
 =?utf-8?B?aytqL3J4UFg1T0cwNmJjTlljVm9FaWU5dnhicjFiQmdObFRJOFA5SEFUSDJY?=
 =?utf-8?B?ZndxZjQ3OWdTQmF4N0Z6QVVudm9UNnRTc1pERUh6UG16SzBYblNqNEdRU2p1?=
 =?utf-8?B?Y2VtcDVOZzEwUGlacnlaT0tGMXpUOE5pcGZQNTI5TldjYmFmM3Y4c2V5M3Vo?=
 =?utf-8?B?R2FGV3BMWHMwQ25ydzJOM3JYTTBDSWNFWnFIWWFzbDVZTWNYdGczekIwT0Zt?=
 =?utf-8?B?OGJEekVZODNhaERNS3cxN3lwVzNod1NxdWhaRkdmY1UrdU03T3V2Mmt5TCtV?=
 =?utf-8?B?c2k4cXZycm52anV0bDREeVJySlN4L1hTc1B4Y1o5RTE1Z1NnODloa2Rjemhl?=
 =?utf-8?B?Y3FkVTIrcm02RVFiUTcwWVFwRjg5cDN3UHQ1dmNZYmlZWUVGVjRpSTFacGFi?=
 =?utf-8?B?SkFmNFAzSWhpazdMV0pMaGlNamNBb0lrQXFPSHhuTE95WXhYTFVTOUtnZFgw?=
 =?utf-8?B?SXFlQ0lmT29oaGx3MHlrVlcrRHhPSm5xVHRua1RtU2R0QU40MERxYnEyc0J3?=
 =?utf-8?B?amY2ZmpsZmY4Z0lMb1E1L3NXQlpxVlo3TTBaWFRsaXFKV1VtckV2Nk9sNTkz?=
 =?utf-8?B?UzRSaUh1MEFjY29zQzVlcG1hS1RrRXR1b2tEVU9yOW9QQVBOeFhHaHUwZERG?=
 =?utf-8?B?ZHJyQTF3TitPL2ZzVGhQQ1pNcWtWUXU2emRMNkhHWWkwVHJBVTIrcGI0N0li?=
 =?utf-8?B?ZnJyTzYwZVRXaExIajRiNlZhOUVVSjZEUmpEMEEzUzM3MUhGWXRybmsrR2xF?=
 =?utf-8?B?WUVKTCtCU01DZmhPNVlFYkJDbWpBM2hDamFnVDRDdXpORGp3THhrMU42NHM0?=
 =?utf-8?B?eUlLUkVCSWd5bWdFczcwSXdxdmdGV1VxbklCOU1wMHJLUTJUT1A5eFhPTkZK?=
 =?utf-8?B?T0JuZzNNMjNEVzRQSENpQUIxVzd6cmVMd3RSald6M2hBSFpwOTRHcVBnYUlw?=
 =?utf-8?B?cFVPdzl1Z0wzUHdMN3V2UUtjRzJnR1JDTkJyUHRRWExFMHdhYng5c1BZeEdx?=
 =?utf-8?B?WHQxbGtra2UxS1NJbGRqR0FjaVVqanRnVDdHSlJLV1lXNjZmcUNoeVhnVjNY?=
 =?utf-8?Q?bB3yTDWaTqk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXl3SkRlU3pFcDBMREV5QkdpZTlPVWp5NXl1YTVnYkFlWEFaMDhGOHFOVHFW?=
 =?utf-8?B?Z1hWcDJzbFUyek5IVmVqbC9qc25ZTXpwdkNld2RYSkJGNTVZaXQxdVFLby9G?=
 =?utf-8?B?c0RvcEkvVXRpWGd5U3piNVdTOGlCZDdYcmE1TytrU294M0RmOVhTQm8yZjBC?=
 =?utf-8?B?MXBiTXRVYU9HcmdGWVVXc2xaVlYvNlRabXRCLzUwWWttSDlybXVldFQvOFhx?=
 =?utf-8?B?RHZMUjZ2L3dSWHprWWNVR21Yd0hsUmlEcENPTjQybmhkdmJUaUtUSlIxR1hS?=
 =?utf-8?B?NDJPc3B6VFRxdE51Ny9xc2hzeWRjTDlyR3BZQnJWaDNDeklBaExVbUZoaXR1?=
 =?utf-8?B?K3JNZmIzaWFpdjViYytZY0ltdmRuM1JUcWpHMXhZeDlLSElCUDQ2SXNLRy91?=
 =?utf-8?B?T2swZEhMUWl1U0NaNDZndC9JYzNlSVRXT1VHVXNLdWw4TUNFbCthOE5RVENu?=
 =?utf-8?B?RG15MTdHTjZDUkEyWDJaQ0JGT2V6YUxSR3duV0M2RVNUTnZpb2UwQk1nSGx5?=
 =?utf-8?B?eE9EbHJ4cG1MQXFwb0VKM0pHMTR2ZE1EeFB3V1hsTTgrSm1GcDRaL1J2Q3VE?=
 =?utf-8?B?VHR1U3ptNTBKcUsxeE9tZkwveXQ2OEVPUTQvd0JDRGlFS01PSjQ1SEMwWHc2?=
 =?utf-8?B?MUVSUW55RDYrQ01LZkczVWhBanFlUC9mNXVBS0k3OEwwbXBVWUpqeHZ1aG5T?=
 =?utf-8?B?OUROOWJaTDhUbEJnamRSSW03VnBDWkJScWRlNzBxcE5xMDBMcFNWZjlKVWVn?=
 =?utf-8?B?Q2RJekZkd0g1VEJXM082SFR1cTFVaWxxMWs4MEoxaStxQ3dvbDdtS3FIamRy?=
 =?utf-8?B?eXA3MUhkTU9nL1dWUFdvUUpJSjNuVXZEWTJLQUlOT0oyS0tpbzFpU2M0V0lw?=
 =?utf-8?B?S2tjaTVSNUtpU24ySVNFVHR4NnB5ZnRYdWJ4VXp1M09wNXpEWkNFUjVjSWx3?=
 =?utf-8?B?TjljVXdBbGtaMVhIVndJT2pqc3M2OXJVeFhYVWgyemtKRXE2RGJWY0RwWUpK?=
 =?utf-8?B?bmZoZlhoZnJYVFRiaHRSaDVaSHBKbmxwa0dIZndscDFZdENDRmtjaVdiOTBX?=
 =?utf-8?B?MGFJdDZBbjVPckJLd3V3VU1tNlJsYk93dms1eHFxU0JyeWszMVoyQ0NVTk1x?=
 =?utf-8?B?QXJCVVRLSCtvcS93Y0lML1hWdHVYWm5JbGxqWmc1ajYyY3BaSnRxQmFybmFQ?=
 =?utf-8?B?Y1d1OTFpak52WkhtN1kxQkZBOTh1c0drTWxDZjJWc3RKY09EQitnWENUT2Ji?=
 =?utf-8?B?enlJZEVlZ0FISDdlQXAyMC8wdkVSVEJLd3dYRWVjTDV4UXhldmsyNGlkbWR6?=
 =?utf-8?B?VWk1ZTI3VzRuQVlZRFZtQmpzQ1BIYkoyVm5ZTkZjVzlzc3JnK1BXZVR5Y1Jt?=
 =?utf-8?B?bGdjaDIwSlRSc0x0bEZIUDhCOUtDdjczOXljR1BlWjNKQ1FOTTAwTjdZQllL?=
 =?utf-8?B?UEI5Wjl2TStFMlJTSjFVbmRnNXJ1anhKQWdZand4MW95cE1aUFdKeWNNdzVm?=
 =?utf-8?B?SHk5VlVKNTEwUmd0NFVhNldma1BFbzE1eHQ4L2hTblJod0VEaDVURU5pTEx3?=
 =?utf-8?B?KytPdlltbjhJNDZIWGxKUVRHdVE5bHphZ1lKZk5kZEtBSWxUUTdsNlY5WUov?=
 =?utf-8?B?dGltblAxSlpQR1l5QXdhbjBSb0NKYXpSZExpcDFaZ2NzNTZ3M3ZiR1VFWXRV?=
 =?utf-8?B?MHlOS1o5Z0lpcWQ2aTYxcVhDK1RieWJzWDM1M2g2RlJ5cWZsTWphWkZYR2M4?=
 =?utf-8?B?R1Fadm8vcURWNmQ5bzJqWG91d2lXYkN6b200eFFIVUJCZ1dWdENKUk9HMDhk?=
 =?utf-8?B?OWtQeFBndlFHTUx6TU9uVVM3dkFNc0VocUVSMDFDUFRUeXEyd1RKeVZwSjFx?=
 =?utf-8?B?VmY1TWpYaXRYam1Zb0svRGNJS2h2U25UblJmV3NMOUlZQlVnaythWlN2UDF5?=
 =?utf-8?B?ekdRSEdlUTU2RnlnS0NCWjdjYU15cWpZZnF4Z255dnQwQnJBT25UWHNyaitj?=
 =?utf-8?B?YlRDcStwQy9nSDBmUzg5VW5VNDU5VEI5VG95MENJR0o1WVlTaE1EZTZidUZx?=
 =?utf-8?B?MGlreE9kaDhNOTYybDVWczNKRjJIY3ZaYzFJcnpiSTlmMEx4aDJ6UFVRK0J4?=
 =?utf-8?Q?GqiR4cKHYp19XS1ppAPNwjAxp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d2e55a-7169-417c-19c8-08dddacdf3df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 01:00:25.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA1tYO3YKgH4Gk27qYcd/KFldB9oIWXo1hRqq9/HfybguwAHw0YBywm5f2QxA4A2PO+Js4ybcGPfZaPPW3zDcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9461
X-OriginatorOrg: intel.com

On 8/12/2025 5:57 AM, Oleg Nesterov wrote:

> A PF_USER_WORKER can't initiate the coredump, it blocks all signals except
> SIGKILL and SIGSTOP. But this doesn't really matter.
> 

Thanks for checking.

> First of all, I think that in the long term kthreads and PF_USER_WORKERs
> should run without "struct fpu" attached to task_struct, so x86_task_fpu()
> should return NULL regardless of CONFIG_X86_DEBUG_FPU in this case. 

Having x86_task_fpu() to be consistent would definitely reduce the
number of corner cases we have to deal with :)

"struct fpu" seems to hold some metadata such as avx512_timestamp as
well as some permissions. Hopefully we never need any of that for
PF_USER_WORKERs.

Is the eventual goal of running without "struct fpu" to save memory or
having a cleaner implementation?

> So. The problem is that do_coredump() paths or ptrace can abuse
> PF_USER_WORKER's FPU state for no reason.
> 

Agreed, this requires immediate solving.

> To simplify, lets only discuss REGSET64_FP for now. As for xfpregs_get(),
> everything looks simple, but needs some preparatory patches. membuf_write()
> and copy_xstate_to_uabi_buf() should use &init_fpstate instead of
> x86_task_fpu(target)->fpstate when target->flags & PF_USER_WORKER. This
> matches the reality.
> 

Yeah, using init_fpstate seems reasonable. I don't know what userspace
would do with that information though. But, not returning anything would
likely break some debugging flows.

> But what about xfpregs_set() ? Can it simply return, say, -EPERM ?
> 

This would modify legacy behavior, but I don't think changing the
register values would have any effect either, right? Another option is
to silently ignore the set(). Maybe we can go with your approach unless
someone complains.

> What do you think?
> 

My knowledge about the FPU handling is fairly limited. So I don't have a
strong opinion on this. Just curiosity and questions! :)

Sohil

