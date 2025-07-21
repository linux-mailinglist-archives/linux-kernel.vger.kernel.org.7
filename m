Return-Path: <linux-kernel+bounces-739993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF637B0CE51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DCC7AD5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405EC24676B;
	Mon, 21 Jul 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQczF94Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7F1A5BA4;
	Mon, 21 Jul 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141246; cv=fail; b=oJsfVMwp62Njs5qv9GlxzPKkecpWOrIVTcVL2pOKqKPRlyvPmpP0EJo/DNYGwiFHjjgGqdoAmZOdvj9qFpvcCEJDG+O38Y0QlWsjy57za6swV99+fa0WmUqPR9QDDkBL7rfzqIViN7nYqF6hTf24MKjP2jQa6VoG96LhmOrNixs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141246; c=relaxed/simple;
	bh=RtaHbjQ0PUXmXhFymaCNdcUu/BkzC7K32kTeQHX0JTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VxjFAY5EhD5t8HGjzEM3jxn0uRRNQR4GPPXO6kyMEakG8nR4aoYcWciSDgqsg0qggd2j/+EKLwFs1Es3iwIAbOX7xIZvnb3P5nwc1vosN8i03Ww3Y8CCZCbSvJnRtJcCRR9BGPI8hxoqeKaKTl0CU7cRy9Y5GSTbs+4pg5QZCpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQczF94Z; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141245; x=1784677245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RtaHbjQ0PUXmXhFymaCNdcUu/BkzC7K32kTeQHX0JTI=;
  b=dQczF94Z3ne3NWOtQm2hrjP/mylsjJ8bZLM+mXZ1R1SzG0kexDBVeI02
   qk9brxn/zJTFDXaNImiH616zMY7AbB5eDSrqsqGE4qV4Ujij+SjSieSTF
   6VWsQmfJzkNQy30iNaPd6Teby4I2Ws3iCokzvCk9PwSG3UPC1ZmEqjKyX
   W7DSz1ORBcWZygYUZF6YvOvyIhiPFiKTU91m2A/Mexvh/CHQBlxWmAO3S
   pQKJg6vgaWfVErybRbudRaH1dEX3Cji5i1HKRfVJ+eueHVIsyMVsdJK2K
   BhIqdA+mMhSt83x2JvvUaKuNySbD3sTCAkz9/rs/VZgU7reGDBnTnWnld
   g==;
X-CSE-ConnectionGUID: lJ0l6HdsT4SdXtwiCqsbkg==
X-CSE-MsgGUID: ODUeQwPPTPmBY+sNca6Rhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72944420"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72944420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:40:42 -0700
X-CSE-ConnectionGUID: AdEb2C+8SKS3DSeoRTFQcA==
X-CSE-MsgGUID: qNV4OxWGQ/WwV5EZ2Pcufw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159022120"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:40:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:40:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:40:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 16:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXu/NKkI3hu760s0KZSSl5slTo/5R1c5WKhqY9baUdxK5UNP05jLwlGw94GVnNEiGqAy4HJLQ085zUf+vAjUZJomcDIltdos1l5PL+c/4exV5J2V3ie1GletzllW73Y5Hjm5+PNH+XdFb8TUtNJ74OCHyuvd9NdI8VPhBDU3o43UyzFJtLR1Bad7UQC1rHIhJMoYGaFHO/LHXCw8fBN+Ie7+9SLttYput5F7NWk+bD9LLGfTDnP0p+anB02kuDBPnNUyyP5lPeRTZA2WtkhQ/JUhA9EnpLZUQnOW9W0ad1UsWcnfysiauZUoA36onqX1Tm+PqyRMgIeir+asbg5rYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckvwl9PtOtRs1ew67sHEyeK1velWZ+8mPEwmdz054t4=;
 b=jNQb4GWlXtrJLhNfq3CaNYmoNoc0zi/vEHpJPehI+PFrkCWDS26/PAHFCOCCJeVpAj+myO2mRLS65ky08bxh0WhyM51eLzjuiebAk/ue/7r/JXABw7UAoezCYfaiFZi2ntQIx1ueSgmotGZ3+HxWOl1KCyVKuI2mGptDqHkEv6SGN4Whh8hCmruJ7yI9S6fCYXL0vs7mIj4vsMOqyxCsMJFRYpCr1sEyQHBloHzRr2L2mF4bd/EIPotxwQofaXwB5hNYQnydG1Ckc4ZA6euj3ro/LaJKRSHpX8jglYnvb8GjSHwHwAzGHPOnm3SODVE6+7avklJp+Ypzca1eFIOAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:40:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:40:36 +0000
Message-ID: <ebd0a6bf-cb55-47ba-b9dc-65f56b065ab0@intel.com>
Date: Mon, 21 Jul 2025 16:40:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <e311fd8f4ddfd33c29febdc71d5d41f8a06680cc.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e311fd8f4ddfd33c29febdc71d5d41f8a06680cc.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 118af111-970d-4f93-e496-08ddc8affdb9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnR0aThYcG1qRHpndDZjY3VkVk1sc2MwNzRpd0x2MmhkQy84U2M4eVo0SmZq?=
 =?utf-8?B?a3hGRmFVWDVabUJxNk9Ja1ArQTRlWGNqTlF1cEE3UzViMVZEb0tKeFNVa21V?=
 =?utf-8?B?aEd6TFFZYUQyQk1vSmdXWWN1Wk9YNlYxZXZlR0FOT0lRaFBaTUdRTlU1cUJX?=
 =?utf-8?B?MkY5RWt4UDE3c0l6Qi9ub3ByTnFWMWNVOUVEZkVXYW1zTU9oWkMzWE5IRURm?=
 =?utf-8?B?NVJWNnFGalpQRTZWakdYSWZuUDBpUVVQZVRGZFBNT1c2RGxxaU1wTjB5bHgx?=
 =?utf-8?B?Ny8rK01LRVF4WUpDOGpod1ltUUNUMHpSQnh3ck9kZTJDOW1raSswdVJjdGpS?=
 =?utf-8?B?R0NJTmdjYzQ5VGpSVGpaNVNQQmx5SlRaQ3R1OVA2WUZBVUg4dDRKbXNuaEZQ?=
 =?utf-8?B?UW1sYXpsLzdGV0tQc1lKUFVUUi9rV0p2NFpiR3lLRzVKWlhpWmpZMXdtNG42?=
 =?utf-8?B?V1JUWUNxRzBKTnYweVVJT1V6ZHhTM3F6TlY0VkpCc0VWTGVmS1I4QXIwSkVw?=
 =?utf-8?B?QldBVGRkMXVJM0tSd210RHpmQ0ZhbzZIZm1pbDVERDJSQ1FIZjBoaCtydC9F?=
 =?utf-8?B?N0xTQmRNcGpFdC9yRDdBZUZCZ21QdS9VWlUvWk80RnpHOG54dWlMSy9CMmpn?=
 =?utf-8?B?bjVoeThLMjMxMWxwRTFpNHNtRFdGZnVzMWZiWUp4Ni9MVzQ0K0dhOGxsSi9R?=
 =?utf-8?B?QUVCK0lBNC9ja2dERVpXZjAwRmpBdElJVTgzaStWZ1V6TktvNGo3aUxZR29r?=
 =?utf-8?B?NXFnZnRLRDYrelU4TEVSc1R6MDRoVC9abG9TTHNOQVdYN1FuRytMeUFpNjJK?=
 =?utf-8?B?ZFROaW9UWE1XNWkxOEFveWlVUi9mRno4UlhFanBiUGlNTlFtQUgwZ1FHYVVo?=
 =?utf-8?B?TWpQQXdUV1Q2Vk5PNENLajhtNFhUU0hHVytyOXdPSTYyVmRhSEtoYnBnMldr?=
 =?utf-8?B?RUJLeUswUGpmWU5icXQzK04vbG45SXYvejVtTHlLb0JqZ25LVjhEdmJacllX?=
 =?utf-8?B?Q1FqUXRmRk44VTlPMUhVZzBJZzZNS3FWOTZta2FHQzA1NEN3TDdKeWw4QUVz?=
 =?utf-8?B?QzVqQWpMNmNDRENYZTB1QW0wL3ZrdkNpNW1WNWk4WXo0RjVid3hpWC9MZTJa?=
 =?utf-8?B?VmZmaDBDSHZOSFA5VGZQOEJDdmQzYzVtZzlwa2RXOEJJODJEdFpqZ0xjK0J4?=
 =?utf-8?B?MGxXUnpPV1QzV2NubTN4UWdrMlVtanJFUkdURVJRYnBuekRDeVhidzgxdUt5?=
 =?utf-8?B?YjdTdEpQbmZRN2tIM1JHQ3VLVVozWStveUpHL1JQc2MzWUtYZkJqdXRrdHln?=
 =?utf-8?B?bW9mU3U5THloWnhEdXcwZ1NOWlJOZFNTRTRHajlsUlBjZllyNExLeDdxdk9U?=
 =?utf-8?B?QWR6TXNiT0JadHM2aVBabUJWREU0OWJWRktVYTE5RmNZRm9wWmZtQUtPSHQz?=
 =?utf-8?B?QnE1cWpTdmZXK21tczNGemxxSmllM3N6MGZsTWw5bVhJSXpDNk1mSlJsOUdD?=
 =?utf-8?B?SVdaMWdjTlRjV2F4WEhPanZ0NEMrSmluNVlMNWhsVzlVUXFCK3gwcWh1RXl0?=
 =?utf-8?B?V04wUTMyVHRxK3Rvb3Q2WHBURnl0VHZCZUdLNUp5K0tZeE5uaGY3cmxIM2Rt?=
 =?utf-8?B?blpuemtmUUkxVktYVzlWbTAxN2lrc25xbFR1RUtJem1NUEE3WC9SdHhHa0Z2?=
 =?utf-8?B?RlBXV3JWTlVaSnByb05pc1h6VjhKSCtNNjFMQzBXTU1wNU1mUGYrODBrOXVk?=
 =?utf-8?B?WFZQdzNLd2J3U0MwUlNPVmVPbkRwMHpXcHZ4VDlJcHJMVzhxM2xLaFIxdlVS?=
 =?utf-8?B?Wms3czlCL25IdUl5UjdURklFZEtZRjdCRkNiZ1ZqdmpncjE4TmJ6V3FoZ3Yy?=
 =?utf-8?B?OWFOWjQzcEI4YWNxK1A3c1M3MlRJY0RoVEV2bXlXc0ZlSnVrT3pVTmkvd0lq?=
 =?utf-8?Q?0dfuZQ9eO4Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXpyazN4SFgxaVJnbWVVS2JrY05CNEVhb0pUK1ppaUN0ZzVrNUVCNTh0bVB6?=
 =?utf-8?B?eVpJakhINDRuQ3BVRzBkSmFmb1Z2Y2UzalJmWGk0LzMwWmZrTlZNL3NGYzB2?=
 =?utf-8?B?bDlJNDF3WXNiVzk3OSs5RFNKdlBsOXlUdUZDSld3dmZaMHM2a2c4a2tuN0FF?=
 =?utf-8?B?Z3Q4c051WmFYeHltZGhtclJSeXpnMkVaTUMwV1VBOEVEeTc0YWswdVdvdTli?=
 =?utf-8?B?czB6N0kxUmtSeU1UOGF0ZmNlcVZFdFJWNllkVjdYaVBPQVBwaThDZGg2MFVH?=
 =?utf-8?B?Q0FiK3BGMGhQem85NEJ3Y0dyV0tYb0h6SWRqMnQ3UGhxMnJHZ1IrMTY4NS9j?=
 =?utf-8?B?UVlNdUlZemtBTkttOE82UVpHNVExOXFKTmY2b2tsbVpvOExzekpIckJDZW45?=
 =?utf-8?B?MGc1QkZTdDBra2M3Z0lBRVVlc0hpV3VtbkZQSUhsMFVZZHNORDVwRkE2Visv?=
 =?utf-8?B?N1lXdjVYajVJbEVJdGFCQVFRSWV5ZFYrcWtOcEx0K1VQT0E0clpPTFRqL2VW?=
 =?utf-8?B?NUY1NVFoZjhvTnZ2akhhQjVLUDllRkZaVis3UHpVcDZCclFDelJoOXExTFFD?=
 =?utf-8?B?OU5lYm42OFUxdEVOZVVWcmVFZW9UQ01HWDRvMHQ0cURMN0MxcVlWNGdIU01q?=
 =?utf-8?B?RkZoelcwVHlCNy94V1pLVzV3eE9yRTZ6a0o5V0xndGVYN3F0QUpMME82cG5t?=
 =?utf-8?B?dnRXVVM3Vm5XbURpK0JrN2JOZGptSGJJRDZOaEFFRU5ITWFjNEtrZzVOVXNk?=
 =?utf-8?B?aWt5Q1lxTXJrWHAzSFlIMjR2UlhYenZZQzk2aVNzWHdBUDAzbGswZUJnUE5J?=
 =?utf-8?B?aTk1anpvQVQ4Q3l0Q1BtUmVjUnFCdFVnaGZKY2lWTEFaTHl6Sm9lOVZidmQ4?=
 =?utf-8?B?ZE5zYzYwRDgyN3RBQlBYVzFNWFFuRGFyZk82SW5reUJ2amhrN2QxaHgvenlP?=
 =?utf-8?B?NzdYcHJLTklyS1I2MllBWHVXR3MrK3RNclN6MS9KUDZndlBJNC8weUhKdkgz?=
 =?utf-8?B?MFRtYmtiYXBzWnErVHlPY2tXU3p1V2c1a3hZQitqL2d5TmxlOElIeHV5L0hR?=
 =?utf-8?B?ZDBhMS85dUJlcnpRTnJRWkQxcG9OcFluSXdoa1NRNENyZUtZTGZqandUekIx?=
 =?utf-8?B?eUFoQlNNQ2VORzc2ek5PdVBMazJYemlXWlhBVFpIUGZPOFVlbm1mT3czdWJv?=
 =?utf-8?B?MVkwWU5CVVdCSGxYVDAwaUYwZUJmVG5vamxqWlhjYkFzYkd1VnZVOWsvL0pn?=
 =?utf-8?B?dUx5RXUvZEFlbllHL0pxam5xMDI4UkJTbDR3bUhFQ0pYdXpsTTI0WHNjV2Y0?=
 =?utf-8?B?YzEvRTJXSGVZZEpqWTFFMmx2dGdVTWFNMXRFSTc0Ly9ZUWlPYVZBRTFTeWVB?=
 =?utf-8?B?Y056eDJrSFpVc0tRbndxeG1uWG90UWEwZm9JMG9YNExGU3lVTlQydW50Zk42?=
 =?utf-8?B?VVdIZmNFQ0dPWTk3RmlsQTh0dHcwakkxSUt6Rk54dmZta1hhTTVWaENEQ1JU?=
 =?utf-8?B?TWZFdVlEU2hENXhiUnNFREdTL3p3OTJGRjBvWmdUQ2NTVjhRWW1CbU1mMFBp?=
 =?utf-8?B?Q24zUXpyZDhFWVFkeUNvdzI1V09CWHpxWEdkQTBKdXk0SXNJV3ZSVFFwV1Ix?=
 =?utf-8?B?NFlHbEdpMk5FOHhxeWhBc3drYTRBTmVDcUxhOXlFOFRmcXMxdzIvTUtkSlRN?=
 =?utf-8?B?UWp0bnAwTzJGMzUza1BRSkVoK0ZaMEFrL0xIVlpKTFNDdDkySlNpMmR4RVpQ?=
 =?utf-8?B?bER4d0tCTkpWdkxiaTgzTHVHYlhNbE84VGdwTXdkM0tWczZMNURhbk5jcFk1?=
 =?utf-8?B?UHdoQWVISnduaEtjUzdXTjJCZXlIMkRSMGl2MmtZRzYybEZQL04vQVlmcEdE?=
 =?utf-8?B?aEhhazVKVnFjS1Z6RHNZVmt1Q0ZYUmRrOTU5T1lVR2Yvd01QK2JOZnhkZGcx?=
 =?utf-8?B?QnFONWt5c1BDT1k0bHk5b3d2c2hsOC9mNnlBSWV4Y1pHYURueXl0UEZQbUl0?=
 =?utf-8?B?MC9BQ1Q3VWI1eXdCOXR5eVV2ai9kc21nd2NkMVRrREJhaFdtRWVUMGZaeXdX?=
 =?utf-8?B?YTl3TWR6WWJ3UmoyODAzaVVldnByVG9ac2N1M1dYZDdBRWc1b1psb2Z2VUty?=
 =?utf-8?B?cG1vdjJyaGRuNXc0cEdsZk9HRTQwczBMenZvMFJpQTJ2NEw3MEkxbzNPZ2hG?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 118af111-970d-4f93-e496-08ddc8affdb9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:40:35.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RISOpE5mYy2GeoEyy2oJOyvWVpWhS38A3xLV0UlLd4J9K3bhPAb1PZA6MDdcSF4wKfy5P68FF/KWzAszdLdYVKtqRbTVfw0d0jcdGFGcY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> "io_alloc" feature in resctrl enables direct insertion of data from I/O
> devices into the cache.
> 
> Introduce user interface to enable/disable io_alloc feature.

I think it is worth a mention *why* a user may want to disable this feature and
why is not just always enabled. Here it can be highlighted that this feature
may take resources (CLOSID) away from general (CPU) cache allocation and since
this may be scarce enabling user to disable this feature supports different use cases.

> 
> On AMD systems, io_alloc feature is backed by SDCIAE (L3 Smart Data Cache
> Injection Allocation Enforcement). When enabled, SDCIAE directs all SDCI
> lines to be placed into the L3 cache partitions specified by the register
> corresponding to the highest CLOSID supported by the resource. With CDP
> enabled, io_alloc routes I/O traffic using the highest CLOSID assigned to
> the instruction cache (L3CODE).

This is a lot of architecture specific text for a resctrl fs patch  ... I think
you are trying to motivate the resctrl fs implementation. Similar motivation
as proposed for cover letter can be used here to help explain the implementation
choices.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst |   8 ++
>  fs/resctrl/rdtgroup.c                 | 149 +++++++++++++++++++++++++-
>  2 files changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 354e6a00fa45..189c1ccb92d6 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -157,6 +157,14 @@ related to allocation:
>  			"not supported":
>  			      Support not available on the system.
>  
> +		The feature can be modified by writing to the interface, for example:
> +
> +		To enable:
> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
> +
> +		To disable:
> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
> +
>  		The underlying implementation may reduce resources available to
>  		general (CPU) cache allocation. See architecture specific notes
>  		below. Depending on usage requirements the feature can be enabled
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index d7c4417b4516..06c854caa55c 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -70,6 +70,7 @@ static struct seq_buf last_cmd_status;
>  static char last_cmd_status_buf[512];
>  
>  static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
> +static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
>  
>  static void rdtgroup_destroy_root(void);
>  
> @@ -232,6 +233,16 @@ bool closid_allocated(unsigned int closid)
>  	return !test_bit(closid, closid_free_map);
>  }
>  
> +static bool resctrl_io_alloc_closid_alloc(u32 io_alloc_closid)
> +{
> +	return __test_and_clear_bit(io_alloc_closid, closid_free_map);
> +}
> +
> +static void resctrl_io_alloc_closid_free(u32 io_alloc_closid)
> +{
> +	closid_free(io_alloc_closid);
> +}

I do not think these should be helpers/wrappers with a separate
namespace. It will make the code easier to understand if it is clear that
the "io_alloc" CLOSID is allocated from the same "pool" as the CLOSID for
control groups. 

I would thus propose a specific, for example closid_alloc_fixed(u32 closid)
helper, and just call closid_free() directly.

> +
>  /**
>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>   * @closid: closid if the resource group
> @@ -1030,6 +1041,16 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/*
> + * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
> + * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
> + * is in the supported range.
> + */
> +static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)

Please move to ctrlmondata.c

> +{
> +	return io_alloc_closid < closids_supported();
> +}
> +
>  /*
>   * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
>   * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
> @@ -1858,6 +1879,131 @@ static int resctrl_io_alloc_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/*
> + * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
> + * and unused) cache portions.
> + */
> +static int resctrl_io_alloc_init_cat(struct rdt_resource *r,

Mixing two features (io_alloc and CAT) in the function name is confusing.
How about resctrl_io_alloc_init_cbm() and move to ctrlmondata.c?

> +				     struct resctrl_schema *s, u32 closid)

No need to provide resource as parameter, it can be determined from schema.

> +{
> +	int ret;
> +
> +	rdt_staged_configs_clear();
> +
> +	ret = rdtgroup_init_cat(s, closid);
> +	if (ret < 0)
> +		goto out;

More below, but I think this flow can be simplified by moving the logic
handling CDP here. If CDP is enabled for the resource then a successful
rdtgroup_init_cat() can just be followed by a snippet that copies the
staged config of the CDP type to the staged config of its peer type.
Their CBMs are supposed to be identical so there is no reason for all the
rdtgroup_init_cat() processing to be repeated. resctrl_arch_update_domains()
can handle updating both in a single call.

> +
> +	ret = resctrl_arch_update_domains(r, closid);
> +
> +out:
> +	rdt_staged_configs_clear();
> +	return ret;
> +}
> +
> +static const char *rdtgroup_name_by_closid(int closid)

This seems generic enough and appropriate for rdtgroup.c

> +{
> +	struct rdtgroup *rdtgrp;
> +
> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (rdtgrp->closid == closid)
> +			return rdt_kn_name(rdtgrp->kn);
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct resctrl_schema *resctrl_get_schema(enum resctrl_conf_type type)

This also seems generic enough and appropriate for rdtgroup.c

> +{
> +	struct resctrl_schema *schema;
> +
> +	list_for_each_entry(schema, &resctrl_schema_all, list) {
> +		if (schema->conf_type == type)
> +			return schema;
> +	}
> +
> +	return NULL;
> +}
> +
> +static ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
> +				      size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	enum resctrl_conf_type peer_type;
> +	struct rdt_resource *r = s->res;
> +	struct resctrl_schema *peer_s;
> +	char const *grp_name;
> +	u32 io_alloc_closid;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!r->cache.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	io_alloc_closid = resctrl_io_alloc_closid(r);
> +	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
> +		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %d is not available\n",
> +				    io_alloc_closid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/* If the feature is already up to date, no action is needed. */
> +	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
> +		goto out_unlock;
> +
> +	if (enable) {
> +		if (!resctrl_io_alloc_closid_alloc(io_alloc_closid)) {
> +			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
> +			WARN_ON_ONCE(!grp_name);
> +			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %d for io_alloc is used by %s group\n",
> +					    io_alloc_closid, grp_name ? grp_name : "another");
> +			ret = -ENOSPC;
> +			goto out_unlock;
> +		}
> +
> +		/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
> +		if (resctrl_arch_get_cdp_enabled(r->rid)) {

I think this block can be removed to simplify the flow by moving the CDP handling to 
resctrl_io_alloc_init_cat().

> +			peer_type = resctrl_peer_type(s->conf_type);
> +			peer_s = resctrl_get_schema(peer_type);
> +			if (peer_s)
> +				ret = resctrl_io_alloc_init_cat(r, peer_s, io_alloc_closid);
> +		}
> +
> +		if (!ret)
> +			ret = resctrl_io_alloc_init_cat(r, s, io_alloc_closid);
> +
> +		if (ret) {
> +			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
> +			resctrl_io_alloc_closid_free(io_alloc_closid);
> +			goto out_unlock;
> +		}
> +
> +	} else {
> +		resctrl_io_alloc_closid_free(io_alloc_closid);
> +	}
> +
> +	ret = resctrl_arch_io_alloc_enable(r, enable);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1950,9 +2096,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "io_alloc",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= resctrl_io_alloc_show,
> +		.write          = resctrl_io_alloc_write,
>  	},
>  	{
>  		.name		= "max_threshold_occupancy",

Reinette

