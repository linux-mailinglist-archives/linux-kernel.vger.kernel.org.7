Return-Path: <linux-kernel+bounces-732055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB15B0615C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2463C5A58B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716E25B2FD;
	Tue, 15 Jul 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnryGmg5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D552528F3;
	Tue, 15 Jul 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589666; cv=fail; b=YRNfrNj2IPE/NB9r6P/7mEz9MXaR1uPOkPQ0P0BaS+Q/WbUpdBLdccyKtyotnVXJpePGsIrB95Tj70H36RTiBIUVUe8ICi5KFErME5oocXkexV3SfcONBOGRgSb7q0LDf4DwD6Z+LX2G361Hzs9lDdR8+IoOfhd9sjcwM00ap/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589666; c=relaxed/simple;
	bh=6byGrfFlBNSKF0mLYRaO6bbDfp5ciYCioPKuurwEluo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVXRSNAUM0HwlPpaIXB4XufuzF3Wil5UiS575myWHzdoHh3MncrLygoPs48t7+ULk1T+iSoBX75KfT6lGL/rhIIdsOgkfbcb9JCnFUKWuoJ5HOZC8ieM0+3xFjLTTf9dps7CtPrGjJgiMOClseAKulcM8yQp+YfW4lT1JBFvQ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnryGmg5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752589665; x=1784125665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6byGrfFlBNSKF0mLYRaO6bbDfp5ciYCioPKuurwEluo=;
  b=GnryGmg5TKUmgvkB5Tl+SUVfZFD06uHLyxzPpbW10mES1gM9m9lGI/QX
   Q1W3bYZwLeEfcAtqBKTGxbrNMJUvOPrNmzKKfE+xpK713K6i5oFt5DpWs
   AXObyFAbw6a/F4S+Jpxnb20zUEic1hk/pK2GY47JEcQOGWINoba5Tee0i
   V13XzVO+DPEedoulMONY4851KtK7tJXlzHZRjcqiTK9wZY9GLn93kr0Jk
   urqqS6t4VHA31l8Eof800VASg96xu2jZyCesT/zUWtLxwuLnlP1GBAtm3
   35W4O26z+4Q6nfLOaBI2xRXGx9yPEIH7yl+RhuDg+iDDw6idQA5poJi02
   Q==;
X-CSE-ConnectionGUID: vIzlvC2CQ4Cja5FihYEdaA==
X-CSE-MsgGUID: JzmPzlqHQzOLN9wrGjZMIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54965661"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54965661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 07:27:43 -0700
X-CSE-ConnectionGUID: RQP1Y5RDSnyhUcBk5CHKfQ==
X-CSE-MsgGUID: t6M+YyFXT9GYn8IIWKa8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157589359"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 07:27:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 07:27:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 07:27:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 07:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJIxQogrg4cUCs54Q8wdI2ZYYfdfLGPVQMESuf9C5Ky4gXmiQ69R0l+ZrZt/XJ+HKdPSUf26KLFaHZpGhRwm+Ph5qk3F7C02osVxyX6Vygt8DZFcnD0Gp1JU2BJZfpfYMj2l7D4YsHmSkTKrkV8gMqP+r/j3tCMvv/bgV1CE24uUIor64byqclry+ksiTGsH1nzUXXq+dapoA2cSb6S7Kf7Uvm2EcL5GXGzjViWNfsRyKIQ3LGtQ3ASe7Glzhly8tjp3U7iiVeNKbodk4zzelgpPJ0dfSBTVv9rKvRXw//6nKBLJStxkz6nR8mnvHBqWWp7XyAPIQ1fGPA4rEx/VyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jNiI4M9voFhD5VcqoOls+ZQh/rPLI5XpEatW0DkuoA=;
 b=Xx8H1IXy5C4XoVSY3d9p/Z2IESJQ+xpExDJcY6/Pe9Z5rR/Eyp5H7jg3cexJeyIIKr2Z32yq9kbLuqW+neARjg27NFDv3Dt6DHRTyQhq7CLrFa7mCfc/7P7rvfY+Heo26akplvY1yDB3k3B1JQgaqG6hvX5mrfQJ7QFQkZfazO7rGULaUNXyhwW85yOA9mFAP/niZyyQlgT3u2rUvKgivGQQjuy27Dq4fZYwMyYd/Wot+EyopyrIj2152z2VzzIzgwFal1j4kN6/AIT54zNEhtpfWu5tFcKQAfRhGaKIr2TC6jYaF856ooMBQCacL7ct7P4rheb9bEJ6UBwAUT6yFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS4PPF890B596B9.namprd11.prod.outlook.com (2603:10b6:f:fc02::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:27:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:27:04 +0000
Message-ID: <8a1e2bf5-1e6b-4142-b0ce-6b1bd3248956@intel.com>
Date: Tue, 15 Jul 2025 07:27:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 28/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <Dave.Martin@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <paulmck@kernel.org>,
	<rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>, <david@redhat.com>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<jpoimboe@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <ef5934fc2b04654c7ff3e6bb910e7c5cf38ba62d.1752013061.git.babu.moger@amd.com>
 <CALPaoCjN7-1fBF+6x1X4SfhRyx6L8aWaOfqOLQzKMRp=zHiyFg@mail.gmail.com>
 <bdda1774-e03b-44eb-905d-1ca2e30ab61d@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <bdda1774-e03b-44eb-905d-1ca2e30ab61d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS4PPF890B596B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ccd0d5-3448-4742-435a-08ddc3ababbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGxHZXhRZnEzVnhTTWsrdm1RSU5RODUxckluY2hSUnExYlJkTWs5NjRubDcy?=
 =?utf-8?B?ZDRjWVozcXhVd3pIYXlWOXpobUlRaDJUVldVQUcza2ZvdEZnOUNma3NlTU1K?=
 =?utf-8?B?dHJBT21tL0MxZDUzVDU2WUFKbUFIT2FCYkxNSlN3U2hOTS9kRTlDdW5IbTAx?=
 =?utf-8?B?RFUrS1JWYzE5QVNlaHFaZUord3NVY29Ld2dnaTAwR001M0Fkb01WUlhHU1Nt?=
 =?utf-8?B?Z1pnOVl5enFiTFRnOTVHOGVFZDJjUnVKeVRnNURxVzdjVUtlMUwwWkpmV3Z2?=
 =?utf-8?B?ZEJzaHgxbUYxTXBkMlNqTGowVUxlQU1UZ2g2aS9UTFZvdk9jL3NQTWZRRzdJ?=
 =?utf-8?B?MzR1bnFmbWlyZnZxdkUvSmhDOVhQSlBadTZHUjFLY2t6RitONkY1Ykw4MGhZ?=
 =?utf-8?B?ZENQOGJwYXJLUjV2Vk9QNU16RlZWZDBWTWNITkxQL2J0S2VMVEczU1NjdGVM?=
 =?utf-8?B?N2dPYmhLdXd1VUlPQ2gxdCtJdW53dTNzV1ZFTzhxUi9wVGE2ZUh1OGtYTy9k?=
 =?utf-8?B?NWNTMzlza0ZCSVMxSnBFeC92UGd5UnJxcm9XWGxHbENYU3BVQ3BHRlJYRWNo?=
 =?utf-8?B?Ykgzb0lwUnpYaFFQTTMrbkVZOU9ROGdNai9zck5IZkR5eWRuWkp3SDRUZTBj?=
 =?utf-8?B?S3BwNllkY3F5ck9sN29jcEI5SlVqRWF0YlQ5S25ySjRlVUVpejNEdEVIMXNl?=
 =?utf-8?B?eEU4Wm0wbjBPKzhhMUNSTUxVK1MvOXZkdXR3MDBUMmF5RktZSkROSjUwSlRN?=
 =?utf-8?B?azUvVGFWSUtnbStTaG9saTZpM0U3M3dQODRWNWRKVDZ0OW9GS3BlbmVpZmlk?=
 =?utf-8?B?bVVab0RvaGkvQys2eWJleGlScktZRWwydmRLaG5icndyQjZVNTVRMXhtd0JK?=
 =?utf-8?B?YlpiVk5lbVI0SkFDb2hSUkpxQkphdldXK1VmODlnOWlQVGlBV2lvTXAvRnBz?=
 =?utf-8?B?WEJjeitJc3daa1ZHc1crT0RVWi95QXNMcEpzQUtQMTZ5NnR4NHQ3eGtuTHhN?=
 =?utf-8?B?SXlqa1ZtMm5mZENsaDJTVkdocnB4bW1jTkNCa0ZRc0pFcHRaRStuSXVmMEpw?=
 =?utf-8?B?akd0STlpb09qeXVSR1RId3p3VnpoMWw5S1MzTFJUWVUrTUZWbi9ROElyNlRE?=
 =?utf-8?B?YVBCK2RhQ2NiQ3J2RmVIOXN5R1cxdm9naWJzUFFnK01WSXcyaFhpcVVvSUhC?=
 =?utf-8?B?WHIxZVJiMFFCL0hlRjAyRVJ4WjBLdUVjWUVueHlQdHdRQjBlK2JQeXRlaGkz?=
 =?utf-8?B?Ymxha3BpSmdud1ZBclJPYjJLQzhibGI5SjFMZjFkZjIyRzNZM2oyQmRINnVT?=
 =?utf-8?B?d0N1dXJ4aXVUdGlZMmdIMGR1R3dTc2EvTkRmeUczSGZFRjlCMHg4SE5HVG53?=
 =?utf-8?B?N2ticCtyUjdIY2JVbVBJYWp5SCswVTFIMjVmV1AwQjBoTmdBZVpRSXExSjFD?=
 =?utf-8?B?ZTZhUXEzRTdvWWplZnRPL3JrRXB5bElkd2czd1U2cWorOS9Jc25SUEVtRzhS?=
 =?utf-8?B?WmtjYUYyMmJwYVZneEVCZzVzRzNzcWhPdFBsWFlHY200YWhiY09BOGlVS2Fs?=
 =?utf-8?B?bjdNQ3pKcEUvek1KRkFDaXFFZ1NVaENNeWhKVGRLRWlCRFFRQ2RMcHBLa1Bn?=
 =?utf-8?B?amVCWEZTM3hTQnZlQ0pZcU5rbmtjWlcwdHhCQnBKY0pNOWkvMVA2YWVUa3Zq?=
 =?utf-8?B?SEFoaWE2YjN2dzZVSGg5RWlibCtqMElDMVl2bWRMbFVuc2tSTlY5d3kvQXBt?=
 =?utf-8?B?d1BJN3d2ZVU1OXNLQlRVdTgwQmtVQXY0SlE3Z00vWXI1ZWUvVDhOU0NkSFpT?=
 =?utf-8?B?bytMMUI1dENSUCt1MDkxWDhJRy9md2FORkoyTnNvVVJKcE5BKzJVMHE4Qldj?=
 =?utf-8?B?S1ZBdzhtWkcwV2xjTDdVMXUxVEZ5a1RpSWF0UTBjWGp2L1ptRFVSS3p3Wkxu?=
 =?utf-8?Q?UVCYSW1tA8U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdRTDdZakFNS0l4eGZza0MvbGVCdXJ5MkdYemFqaHp0TjN0V0ZGaTVHTW1a?=
 =?utf-8?B?OFpGNGF0SFVES1JxeFp3U2NPYnJiQnNKTXNGR2loc2hxOEdDK0I5dXZPM3BN?=
 =?utf-8?B?WG5KcHBEMU5XZHV2R2o0cUtMc0JaY2dhTzkvTHl2OUpSWmE2b25zVFpucTV3?=
 =?utf-8?B?Vkl0UWRsZ0Jyb3BydG5lT3lVK2tRaExHMEkzQis4bm1Vei9rNTUwdE9qS1JS?=
 =?utf-8?B?QnN5c3Q3UXUySm1UWWVtU3EwcFZYS2lZSE4xNzZob2drbURZSWNZZlF2dVhr?=
 =?utf-8?B?ZzRwU3lNMzNyQVRHdHFaMEoySDdSemFSRDVUZVJhc0dLQnUwNFhrMVJaSG9q?=
 =?utf-8?B?MTBueUhCaTNmVHJFbDM0ZlFBVnhXT0FuS2tvMVJhcDQwQlA3ek1vbFpKdWRJ?=
 =?utf-8?B?RE5VVmdwNlQ3c2ttTXI3WEFveGE3VnBUM2lKVndoaHlpdVRpZHk0bkMycSs3?=
 =?utf-8?B?L2EzWWo2MElwRFRUbkp3ZFZVb09GM04wcC82UXpxUEc2WTVQbVIxUHc0WHZs?=
 =?utf-8?B?QmVySlhKbG9xQ3E3K2VqU1l0MlpzS0E4VXJha295K3liVGw2THFRR1Fnam1S?=
 =?utf-8?B?SVlmMy8yYnpwRzhnVkZEMlNqWE5kR1BFaG5MdU12a2QzTHI0UU9aNUtXT0g2?=
 =?utf-8?B?SVp5c0pWNVk3OUNoSmNGVnpFcTRLMTNFMktjcHRwN3Vna1cxRTV3Y1RWQnNU?=
 =?utf-8?B?clBjaVZtWnlEdFM1aHNqdzdGQmUwcnhlc2lCOFg2UWlTYVdNb2NlY0lMZnNG?=
 =?utf-8?B?TjVQMktReStrT1hRLzN4K2hZVEZldnAwTjdjd24rRXl1d0RzTWpmMnpkZmZY?=
 =?utf-8?B?dEZ0Yzh0OFNaOE9nNFF0YzFFclQwZHdXVlpDWmZ6NnNWUVYvYi9UNFNNQS94?=
 =?utf-8?B?QXpRZlZKZFRuZWlJcUNiK0piUzQ3U0owZUNUZ1hxTmFpWlY4bFhrWUVEUERv?=
 =?utf-8?B?Nitsay9lWTZFY0Y5YS9Ud0lkemlHY0lYaGVOMUNIUWxXZmN2TzJOdFNScVZX?=
 =?utf-8?B?c3B4bWkrZUtrMEU3cjBhNW83Z0RDUm9rUkVpR3JoS2toNUV2cGNTVXY3aHI3?=
 =?utf-8?B?ZmJNdmtDOVZ0bjRpcWJ5ZjUzUFVQVitydmZVdFRjd2ptU3FWZis0Q3p4dXpI?=
 =?utf-8?B?bk5hcjFxWTFhZHZBWXJtTk9KUTJxSzVNYllHWXQ1R1FKTU50RDJSbTFKOUd2?=
 =?utf-8?B?Q3ByQ3BHSVVURmhhVXpRcEtIWGdkanhjK3hVMkIwb2F2SS9hS0Nta3o5SGFu?=
 =?utf-8?B?YmQwbjBhcTFmL3U5OTZkc1JBanA1ZUtFNzhmUG5tMStoU3pWSTRKYXdid05C?=
 =?utf-8?B?aUV3cGtrbEpkKzNuV2lmNW1wbkhvUEc0V2hoRXJxUkFkdmxIdFJKSUg3bWtB?=
 =?utf-8?B?VUduUXE1aHBJaE5WQTBhWkNYT3Y1c0U5K1phR1lTNGJaNU1aQUZJUlhwWk12?=
 =?utf-8?B?TzhPZDl1dDFLRFZqMmt3cnNIK2NMRElWamNqRjIySXFvb1R0T20xTUVuQ3h2?=
 =?utf-8?B?RTZtOHdWc3FwaUFWVTlNMmJOenBKbUdySTVGY0xuSWRSZDRDRXhNaDJuOHVS?=
 =?utf-8?B?akpUYUZqQU1YbVY0RjdzKzBKWU1oZkplNVpzSHZpejZQK0IvSmlmRWM1eEsv?=
 =?utf-8?B?QVhOMUdlSWxXakhacDlBQ1hXelU1ek9rU1JOMXQrMkhUL2lYS0d5SlNpSmlZ?=
 =?utf-8?B?Rkd6SjM2TW5qbmp5TndVdC9NT3U5c1VsOVVaR0RCZjAyTzVwUFBlQmRTYWpJ?=
 =?utf-8?B?SUJjOVhRak9ONlYvd1FjVHFPcVc1VWprRzJnK1NhdDhaZEo1aGEza0ZSeWN6?=
 =?utf-8?B?eDBXRDdrUkJ5R3JQRnA4OVJPSUsyblE5ZGdiVEJnL1FrWkVNNFZvakFkN2hO?=
 =?utf-8?B?R3NVaDJSUW1JMjZZYmVkQVJIblJJbXB4RW9hMzB4SUFGZUR5bGduUGt1UTls?=
 =?utf-8?B?VFlCVzdRQXY5YTJyOWp2YTdsVUFvYVFQRVk2UTYyRUtCaU9yTHN5YjFsUkRG?=
 =?utf-8?B?T0Y0Q1RDQk56eTh2WjEwZHVlTzJuMTRjZ2FzaUthRlFicEY5VkNvZXpSN2g1?=
 =?utf-8?B?SGRCdkdSU3pVWlVnd2hvTy9aakZiQ3J6SWQ0NzRTYXQ1b1pIY0VabzRHdldB?=
 =?utf-8?B?blNnTXFnaStseVFWdEFwczZsVkxFKzZaVDRZUkpzZHlqNjY2M1BOeWRBbVVn?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ccd0d5-3448-4742-435a-08ddc3ababbc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:27:04.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/d6NaMCNqe/MxIGwMIPf4mO9iYJCgBpF0RpaPy/eZcA93LMwQyCs/BMVKsyPHrujV9RwUKjs9r9QyalckfpEFkk/RyYT2QZhv7TetOMijQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF890B596B9
X-OriginatorOrg: intel.com



On 7/15/25 7:18 AM, Moger, Babu wrote:
> Hi Peter,
> 
> On 7/15/25 08:53, Peter Newman wrote:
>> Hi Babu,
>>
>> On Wed, Jul 9, 2025 at 12:22 AM Babu Moger <babu.moger@amd.com> wrote:
>>>
>>> The "mbm_event" counter assignment mode allows users to assign a hardware
>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>> assigned.
>>>
>>> Introduce a user-configurable option that determines if a counter will
>>> automatically be assigned to an RMID, event pair when its associated
>>> monitor group is created via mkdir.
>>>
>>> Suggested-by: Peter Newman <peternewman@google.com>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v15: Fixed the static checker warning in resctrl_mbm_assign_on_mkdir_write() reported in
>>>      https://lore.kernel.org/lkml/dd4a1021-b996-438e-941c-69dfcea5f22a@intel.com/
>>>
>>> v14: Added rdtgroup_mutex in resctrl_mbm_assign_on_mkdir_show().
>>>      Updated resctrl.rst for clarity.
>>>      Fixed squashing of few previous changes.
>>>      Added more code documentation.
>>>
>>> v13: Added Suggested-by tag.
>>>      Resolved conflicts caused by the recent FS/ARCH code restructure.
>>>      The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.
>>>
>>> v12: New patch. Added after the discussion on the list.
>>>      https://lore.kernel.org/lkml/CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com/
>>> ---
>>>  Documentation/filesystems/resctrl.rst | 16 ++++++++++
>>>  fs/resctrl/monitor.c                  |  2 ++
>>>  fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>>>  include/linux/resctrl.h               |  3 ++
>>>  4 files changed, 64 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>> index 06c8c08d0341..f9e9a8a66cae 100644
>>> --- a/Documentation/filesystems/resctrl.rst
>>> +++ b/Documentation/filesystems/resctrl.rst
>>> @@ -354,6 +354,22 @@ with the following files:
>>>           # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>>            local_reads,local_non_temporal_writes
>>>
>>> +"mbm_assign_on_mkdir":
>>> +       Determines if a counter will automatically be assigned to an RMID, event pair
>>> +       when its associated monitor group is created via mkdir. It is enabled by default
>>> +       on boot and users can disable by writing to the interface.
>>> +
>>> +       "0":
>>> +               Auto assignment is disabled.
>>> +       "1":
>>> +               Auto assignment is enabled.
>>> +
>>> +       Example::
>>> +
>>> +         # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>>> +         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>>> +         0
>>> +
>>>  "max_threshold_occupancy":
>>>                 Read/write file provides the largest value (in
>>>                 bytes) at which a previously used LLC_occupancy
>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>> index 0722e72f6cb1..ccca2330eebd 100644
>>> --- a/fs/resctrl/monitor.c
>>> +++ b/fs/resctrl/monitor.c
>>> @@ -984,6 +984,8 @@ int resctrl_mon_resource_init(void)
>>>                 resctrl_file_fflags_init("available_mbm_cntrs",
>>>                                          RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>>                 resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>>> +               resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
>>> +                                        RFTYPE_RES_CACHE);
>>>         }
>>>
>>>         return 0;
>>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>>> index 4889e7556cc7..b7289ce2b3a6 100644
>>> --- a/fs/resctrl/rdtgroup.c
>>> +++ b/fs/resctrl/rdtgroup.c
>>> @@ -1987,6 +1987,42 @@ static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
>>>         return ret ?: nbytes;
>>>  }
>>>
>>> +static int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
>>> +                                           struct seq_file *s, void *v)
>>> +{
>>> +       struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>>> +
>>> +       mutex_lock(&rdtgroup_mutex);
>>> +       rdt_last_cmd_clear();
>>> +
>>> +       seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
>>> +
>>> +       mutex_unlock(&rdtgroup_mutex);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
>>> +                                                char *buf, size_t nbytes, loff_t off)
>>> +{
>>> +       struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>>> +       bool value;
>>> +       int ret;
>>> +
>>> +       ret = kstrtobool(buf, &value);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       mutex_lock(&rdtgroup_mutex);
>>> +       rdt_last_cmd_clear();
>>> +
>>> +       r->mon.mbm_assign_on_mkdir = value;
>>> +
>>> +       mutex_unlock(&rdtgroup_mutex);
>>> +
>>> +       return 0;
>>
>> I noticed that "echo 0 > mbm_assign_on_mkdir" never completes. This
>> should return nbytes.
>>
> 
> Agree. Thanks for pointing it out.

Not the first time:
https://lore.kernel.org/lkml/7fcdb142-b188-4f8d-ab26-391e0b9cec8e@intel.com/

Reinette

