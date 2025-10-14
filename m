Return-Path: <linux-kernel+bounces-853456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C601ABDBB68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C6E3E2BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CB22B8A9;
	Tue, 14 Oct 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgFKGxC7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEA1547D2;
	Tue, 14 Oct 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482551; cv=fail; b=VUYg34ifrg2euoGI39dmD3aDP20aiGbpbJlzaOGc88GdBjMRfpSjpLms6KV+iKoVvhDrAc2eeWTZ23Pn0Ua+zGutCVPWpb2SrICD2Kt5lyEH4fB5f38B+Y0+jXnzRiIzUKAwpUJ5ryrp7gMcrxeMo10jS4kQNrS0fUjwmlPXtvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482551; c=relaxed/simple;
	bh=qmxMxPYv3ENWK2T0RoO8Y4dMf+h8zW2G5yI2NyLUCRw=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwyf9XTkxYE8TAvzUikyz0i/cPD0zOds4pBJQYt/EqZf9UIXXehQzn+tRlZ+ql9BHHjRp2hBb+Cngx6IPSb8iziHrOmvCPdPCoMjHoyUn2iSSzHsOArZNddNLJ4cn9FpQdXtl89Q9BkSPz8j0DVQisqRQHrGnAii18cWA/QSQEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgFKGxC7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760482549; x=1792018549;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qmxMxPYv3ENWK2T0RoO8Y4dMf+h8zW2G5yI2NyLUCRw=;
  b=DgFKGxC70Tw/Wdp8CbcOHx2mKfhC72NnEFgbGw7EL6L6jFu7U4p0BkGa
   qBeit/7guEPMS7FCDzmQj/MertW5YTGmgJutE1C3zBmUP0uPKvRWEwiJr
   E7b1J+LV2xTxYxDSSDX0hFB/0dx4eiSZ2mRU6DZFQDctHl65Box9wBdiD
   7od9eo7iBz0vNLEk2TGMjrPH/DAK/LuB8eRH9Eq37oLav48EeHPafX9gf
   r9vPd2uz/3/1T2AQqtQvkNGLvw/GfcTHT2WBqsoTmUTz2jMvL/cHBGMAZ
   SwtSu1EP4ud0lzbta1sMMmnLZBZJ3EWz+Lhf/LYvTpb4CKymeIwfiRgcL
   A==;
X-CSE-ConnectionGUID: GTg/Y315R9GL9q7Vg/ASww==
X-CSE-MsgGUID: c9TXGbLJTVC5icd27Tui8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="72923878"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="72923878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 15:55:48 -0700
X-CSE-ConnectionGUID: RaUakXV8TbaVCpmPvNQ5Eg==
X-CSE-MsgGUID: HKNA8LcRROWUCksxkrLLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="186257493"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 15:55:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 15:55:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 15:55:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 15:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MghKo8dD33q+1Om11l1rpG8kisWV6ZZat5sAutraacj+UX1I2F54d9kWMpJekAudGev1FGg47fL0/6GBSiYhBOdjyxZJUK6XEFZjima1k8AWOzt0NqnXuOT2ORQe0wTWntIa3puEaQu5fJPfo5dBZ/YsFXW9LaBRroiAGw9RDD/sY3oM49IXQKh4y79HHdQaeonhbkc93vsq2/BEoAQChodReJMkfm4JURDIi7e5p2X1jEcHChAPw3FrLw1CCCk2Kj3dCqdwc1103U/6TYe0fA/4OpAH6ixtmH2h4zMqzBPyY3aTw6/hXMDOElsA2v59HJFmdDauZpYAly2ZvcVQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OhwO25rEhOwgEIFAZXZaGiUrQQoWJxq41AqQWxnJ6M=;
 b=AIIGFKldSPpRc8+e8I+9i6KEDtO+dmi2A/WpLBPxzWh1Fe2ACmYJIo//VoOD5V2lZkWnL7sXPxluWSElUhvkLmoIU3qfgcbuDsDauxx/7ef+NcvsNRGSlexVafaZai72d4yH9hHVweU1Ks7gWFR8IJTbn79yflkQYJpJXEpDHwmhIA6H2fXGAFk2iftFgY9smVM0Agan5rnt9n6o3XhWUv0ZaiNwXZp9UboOYUDWpcXTT3bgPIrcEDYMonfjdiTYXwYBM8YBlbfZO6qYysDqyd1oidkP3xdSPfeSTe0IdVg49236vgwO0VbLeHCfOD2Zx4VDxxorDp/9HHW0Hvp+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 22:55:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 22:55:43 +0000
Message-ID: <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
Date: Tue, 14 Oct 2025 15:55:40 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
 <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
Content-Language: en-US
In-Reply-To: <aO0Oazuxt54hQFbx@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8c8252-d3c2-4d5a-e352-08de0b74cdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1dZVlAwakUvcVQxZTZUZ0V5S01TUS9ROE5JVTNWUFFtbW0wY1RIZFdyOHk5?=
 =?utf-8?B?MmRtNDFZbExyeXFrR1NuOXVqY2theXlGdVJDN093K2pob2ZqTkx3VGZEQ0E1?=
 =?utf-8?B?RjRoYkVnemRZU3hhQm1OS1V5ZDdGeGpzOTg1VHZFeSsyQytwdXVnTFE2Mkgz?=
 =?utf-8?B?RzFQZ1c1RXhIbWdUVy9jcFJNOHd2eTg0VVVJbFpHd3ErMGlvZ1Z3azlFdlJI?=
 =?utf-8?B?NHdBQ2V0SHREWmxVNHl0eW5tUXlETXVpK2E4YUlaQzJ5dElsT0FJQ2xwVys4?=
 =?utf-8?B?cFE1QUE5cytiWFJLQU9BN2p4OGY5bHRxZzVDQko4T1JOanJvaElaZHMwaDFz?=
 =?utf-8?B?TVZLZ3R0UnU5d0UxbXRGMXRXTnZTb21oRm1xdCtFSUJ6cFZLa2JOeXVPdXBW?=
 =?utf-8?B?cGZBNmZqYXpJRTJITmhENmhFemZmT1dyM3RsNHY5NGFuTE9qcnU3RitnU0Nm?=
 =?utf-8?B?YVhhQlE3WUVZdEd6N0FWVEtBdTdmRGh0MmwzRlUyd0dTdU83cWtiSmFiSGZM?=
 =?utf-8?B?QzFRT2lDVlk0Uk1WM2IveWR3eUUwZlR5MktEZ2Q3Mnp0V1RXd3NRaFNhQlZy?=
 =?utf-8?B?UTduU1R5aFhrZmxwNHFCbXBrRTd4Z0k1UFdxRWwxMktQODUzUTJQQndiamhO?=
 =?utf-8?B?WXo5cUdIakgvVjgvSFFOTmNDeGI3TEg4VGp0U2I3Sk9UczlEUHRVb2dsdi9n?=
 =?utf-8?B?aDU2d1pGRkJMU2ZrdzdCak1QWHVpWkNIOWhtb1N5cWttYUtlT0lFWndwUmdQ?=
 =?utf-8?B?azZZNUFxWEcyOWxTT1FmalpYMXZGZkpGNUlUdmd6VE93R1pLdlM5Uzl3dEFR?=
 =?utf-8?B?aTJPdDJMRmxMOHVxNXczRkhPMzYzaVdaaU0rNitiRzFrMmJRemdHc1ZmaW9D?=
 =?utf-8?B?YXV0eVQ3d3Z2dzYxWXFmd293N2hlS2xUSjZiUjIzWEppb0VFUkx3V1A4SlFl?=
 =?utf-8?B?ZHF3ZjhVRm42ZEIyMzh1Z1BjR3BEcVdRc01KclJmcDF3UjlRbG5TL0FEa0R3?=
 =?utf-8?B?ZVoyYk9MbUplVk0wSkd4dDdPSUNWM0o5TVBYRm5sMG03eDNTRXJDV1QrN1Nq?=
 =?utf-8?B?U3lYLzc2UTdxRXRIeC9DQTZBOXlPbXlUVkx3U0JWY1VxbTF5RnJsTE1nRGt2?=
 =?utf-8?B?YlhDQkJpTWZ0OXM2My93c2NjUmJMOHFxL0d6VTBnYmJkaTMrOTZYZ3NYL1VX?=
 =?utf-8?B?KzJNME85b1VXb0RHWTVMdXN6ZTh4SkMyYzIyU1JPWk1BcVp4di9Ka0JrbEFH?=
 =?utf-8?B?TDlLd2FRc2dWUDV4aGZsNVcrQ3dYZlZpM2RMY2tqQXE1a1pmUEpBTGowSmNm?=
 =?utf-8?B?bktYMlk0azhEYlJrNHBnWkRPTTlmR0tOSUVFM0tGbTVkSExRNDRqNWxwV0N4?=
 =?utf-8?B?Y1VjZWJ4ZjZSclpzOFhjWU1BVDl5WklWVG9ibkhaeHJjamZyeURjOFZzM29z?=
 =?utf-8?B?eENVUHZ0c0llNmJlSGFvcTQ4SkdBMTd2ZVZaRFBQdUpoQ2QvdzZDMWMwT0FF?=
 =?utf-8?B?a2hYNkc1QUdFUlluUlh0djlWK0dud2lKQWdPVDFSQm9WRTRST3pwOE10cjFl?=
 =?utf-8?B?TzR6bFlPTHM2blBuaEdGN3ZuK0VZd3VxM1hXdjlFeGVUL3E4VHRDdmQ4cWhm?=
 =?utf-8?B?VDUvTEE1VTVyalg4eHRRWE1EWlErdXU5T25xUnJ1enROOG4xMXdjcjl0QldC?=
 =?utf-8?B?ckZTQ2txWjJkaG9YanVJZXFHNWY2UmZMaWI5eFAyQklITGN4WkM0N1BJYU5k?=
 =?utf-8?B?TlVOcS9tdDRUbkhhMFdWdlM2eTlhZ25IVnZ5bVpBQWFOWnJTQ1FoM3hMQVls?=
 =?utf-8?B?T2JESkMyMXVvcDN1TTdrVnZzZUtHNkhxNnV4WXhydjdrUzhRbzJQaklLUnEv?=
 =?utf-8?B?RW5HekhLMCtyNkdONDdldkVOMCtIMTNMRDVoVk0xS1JsQWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1Q5VWVtYkNPVnlTcjZlaGxYOFRUc3pXWmYwZm9pZWg5L3I0cTJMZ0JIRnBF?=
 =?utf-8?B?alNOZTkwSDMzdlYwWlhsaWQ2SU1GU0h5VStjSVlMQjNENXdMZzQwamRFMFdH?=
 =?utf-8?B?RVNzdTJQRGlBcHdORnlTNEk1K3VhdW9RK1hKbXJFbmVLRUx3TTFUK09DakVu?=
 =?utf-8?B?ZG02bjQxR3gxUm9vTUFqTVFrbnZDZ3l5SFZCcmRQcnMyWkp1bDBLUXptVHJB?=
 =?utf-8?B?MTJobUY0aWdMbFViN0tZRkFCbU95MGJjVTFub3c0RERzbDBoVFZZRzRyMUlh?=
 =?utf-8?B?b2MxUlBIR0ZRUWQxZTlIWDBZTG1YRXd3MVB3RE9DazB2SlVsTlFVSWZ5Q2Z3?=
 =?utf-8?B?dnpHUGcvL2x2cjN1RHlkUXZHWncyNVAxYXBoWWxVeWlCN2p2NjM5TWhFeTBk?=
 =?utf-8?B?WWNDbEZrSkxpUnhlZWhmTjkrSW56L1Q0d3BiV3dweGlDdkVZcmljUjY3c0Q4?=
 =?utf-8?B?UVEwb3lHOUhOMnpxMlBMNnZyU25aWEJvK1VDTElHelZnTG94alFETkM5bUl5?=
 =?utf-8?B?aE1vMDRTRVJsZEVQa3BkOFNwZkZWa09EaDlmcmN2d1o1d3FpdncraXgzR3FU?=
 =?utf-8?B?UEJqWTN3SlkvVTYvKzdaS1ZIVGlMVTg5L0hzT1cybzdSazBHZitZd25IR1A4?=
 =?utf-8?B?RWJYVDJYU1FzUjMyMGxpbW9sWjdRSURRRXA0cmRSL1BnOVBFNUh6VGp3RFZL?=
 =?utf-8?B?Mi81RTVwUzREbFlzSWZjU2cxTUo3S3pBUzhOYkJJVGVHdk4ya0ZkS0ZNTStV?=
 =?utf-8?B?cm1QcnhIVDdxbEVGNVpNUTRlZnlpOUNtR2pxTGh3YWhGNGFwcWNEVWVVRVYw?=
 =?utf-8?B?T0lnM3p1SXJENVBaSWpScWdvUDljNjh6Mm80SE9kaEhHRFRTVkovSmxlUDdE?=
 =?utf-8?B?d1ByWUFKMHBqRUlsbTNUWXN2WkFpYkkwR05iMTZBa2hYVU05Z1NhMmxhcXk4?=
 =?utf-8?B?V0NoeVNFTi9CSGdORWk5SXBhSjVYRFo3UkkvNUgzdGovb0VxN0k0WG0zRjNh?=
 =?utf-8?B?N0g4Z25HNjV4RVVEekZZK0lMaERpS2dJcVNxMjVPeElzSVFkSkEyaVZYcDBh?=
 =?utf-8?B?N1FaeCsyc3RsU2VoV0NwRHJRVEUzMmdhcDBFU2Y5MWE0NUdTd3RsaU5TS0c1?=
 =?utf-8?B?OStFQlMyelRub2g1VEFJcndmYlNldUFtbnJwZXJCdUxibzVkK0VMcGtNaG9t?=
 =?utf-8?B?elJwRnB1RXVRVGJRVnk0TGVocGtIM3F5cEl0aThqSVRRTWlPd3kxdVRBQ0dB?=
 =?utf-8?B?VVU2TlpjTlZXY1pBZXluSFRHWkxrV0JTM1dSNFVGUDBKTkhlZDFTNmk3Q2xY?=
 =?utf-8?B?NXpEZ3FHQVJxNDRjczRVOVQ1N2s0aHRuRUJ1Nk1ZbDBjeHFsWXBYaVRHc2gv?=
 =?utf-8?B?S01IOXJiUWlaK0pIYnNZSDlGcWp5TmlFZFZRQkxNUG5JWVoyZndWdGxyc0JK?=
 =?utf-8?B?VEdFWmtLU1Jkb0Q1amk3OWRSWGcrNTc3SFpYb0QzdFhUVjFUS0NsNFlsZ0tm?=
 =?utf-8?B?cmNzSnFhQU40Z1BGWk5WUXI0SGpHYjkyYmR4WmJHN1IyUUtteWFCZVJFekI5?=
 =?utf-8?B?Q2QrWkYrRHl5WkxyS3NlM2s3Nm9JcU1nUmFFWWhIOWFxVTNRdmt0L3E5NStT?=
 =?utf-8?B?aUY3YTNjMWlUUkYwVGIvQUNDUnk0Yi8yNGxXaGQyZGNhcGllYzJwd09oZTRY?=
 =?utf-8?B?b2IzRlk4R1VPeWlyKzQrbTcva3lrSndiWmNvejZWNC9VK3RCNTlzakNJZkgv?=
 =?utf-8?B?QzlMR3Nkdit5WFJWby9TT2dQTzQzZEd5aGdicnRod3h1ZzVldXYxTDlKdCsr?=
 =?utf-8?B?SUF3UVZibEZMZ2I2M3hLUVA3dCswdFZXSys2YUp1ZFIxODJhZjgxcGZ6bURL?=
 =?utf-8?B?Q3ZtYVFXRmdsQktwa1d3N0ViZlBhNUJwd1M3ZktkZGpsZDVQaThTMEVNTkI3?=
 =?utf-8?B?YjJZdVZIU1c5T3B5L1U3c2lkUnlHcEVhVC8yMXp4bHJBQUVGamZEM1NCNnBp?=
 =?utf-8?B?c0dkbjdZY040KzBBa0ozQUpyQ3I1Uy9TSWxacXpMbWlLb0lQeDNmZzdGUExV?=
 =?utf-8?B?QTBLL3hBQWRYR0VTcWZCM1dqVGJaY3U2ZGxaTGNjSnZSbGc2TDRhbldjaTZ2?=
 =?utf-8?B?YzFEWHExbENxMk9Qc09zMHFNb2I0eEJ2NlVNR2V2ZUVGYlg5WE1kSmxZK2py?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8c8252-d3c2-4d5a-e352-08de0b74cdb5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 22:55:42.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gXFjAUr3maO/xe1MDIycGaMRBal31uJHC+TwfhZVagQrFfEwdGtWKRf93g6wF8XPecHd75jIliDUVgUt1bOVV9GoANI+HGYOX5oZ/zBqzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com

Hi Dave,

On 10/13/25 7:36 AM, Dave Martin wrote:
> Hi Reinette,
> 
> On Fri, Oct 10, 2025 at 09:48:21AM -0700, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 9/30/25 8:40 AM, Dave Martin wrote:
>>> On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
>>>> On 9/29/25 6:56 AM, Dave Martin wrote:
> 
> [...]
> 
>>>> 1) Commented schema are "inactive"
>>>> This is unclear to me. In the MB example the commented lines show the 
>>>> finer grained controls. Since the original MB resource is an approximation
>>>> and the hardware must already be configured to support it, would the #-prefixed
>>>> lines not show the actual "active" configuration?
>>>
>>> They would show the active configuration (possibly more precisely than
>>> "MB" does).
>>
>> That is how I see it also. This is specific to MB as we try to maintain
>> backward compatibility.
>>
>> If we are going to make user interface changes to resource allocation then
>> ideally it should consider all known future usage. I am trying to navigate
>> and understand the discussion on how resctrl can support MPAM and this
>> RDT region aware requirements. 
>>
>> I scanned the MPAM spec and from what I understand a resource may support
>> multiple controls at the same time, each with its own properties, and then
>> there was this:
>>
>> 	When multiple partitioning controls are active, each affects the partition’s
>> 	bandwidth usage. However, some combinations of controls may not make sense,
>> 	because the regulation of that pair of controls cannot be made to work in concert.
>>
>> resctrl may thus present an "active configuration" that is not a configuration
>> that "makes sense" ... this may be ok as resctrl would present what hardware
>> supports combined with what user requested.
> 
> This is analogous to what the MPAM spec says, though if resctrl offers
> two different schemata for the same hardware control, the control cannot be
> configured with both values simultaneously.
> 
> For the MPAM hardware controls affecting the same hardware resource,
> they can be programmed to combinations of values that have no sensible
> interpretation, and the values can be read back just fine.  The
> performance effects may not be what the user expected / wanted, but
> this is not directly visible to resctrl.
> 
> So, if we offer independent schemata for MBW_MIN and MBW_MAX, the user
> can program MBW_MIN=75% and MBW_MAX=25% for the same PARTID, and that
> will read back just as programmed.  The architecture does not promise
> what the performance effect of this will be, but resctrl does not need
> to care.

The same appears to be true for Intel RDT where the spec warns ("Undesirable
and undefined performance effects may result if cap programming guidelines
are not followed.") but does not seem to prevent such configurations. 

...

>>> This proposal is only about numeric controls.  L3 wouldn't change, but
>>> we could still add info/ metadata for bitmap control at the same time
>>> as adding it for numeric controls.
>>
>> I think we should. At least we should leave space for such an addition since
>> it is not obvious to me how multiple resources with different controls or
>> single resource with multiple controls should be communicated to user space. 
>>
>> To be specific, the original proposal [1] introduced a set of files for
>> a numeric control and that seems to work for existing and upcoming 
>> schema that need a value in a range. Different controls need different
>> parameters so to integrate this solution I think it needs another parameter
>> (presented as a directory, a file, or within a file) that indicates the
>> type of the control so that user space knows which files/parameters to expect
>> and how to interpret them. 
> 
> Agreed.  I wasn't meaning to imply that this proposal shouldn't be
> integrated into something more general.  If we want a richer
> description than the current one, it makes sense to incorporate bitmap
> controls -- this just wasn't my focus.

Understood.

> 
>> Since different controls have different parameters we need to consider
>> whether it is easier to create/parse unique files for each control or
>> present all the parameters within one file with another file noting the type
>> of control.
> 
> Separate files works quite well for low-tech tooling built using shell
> scripts, and this seems to follow the sysfs philosophy.  Since there is
> no need to keep re-reading these parameters, simplicity feels more
> important than efficiency?
> 
> But we could equally have a single file with multiple pieces of
> information in it.
> 
> I don't have a strong view on this.

If by sysfs philosophy you men "one value per file" then resctrl split from that from
the beginning (with the schemata file). I am also not advocating for one or the other
at this time but believe we have some flexibility when faced with implementation
options/challenges.

> 
>> I understand the files/parameters are intended to be in the schema's info directory
>> but how this will look is not obvious to me. Part of the MPAM refactoring transitioned
>> the top level info directories to represent the schema entries that currently reflect
>> the resources. When we start having multiple schema entries (multiple controls) for a
>> single resource the simplest implementation may result in a top level info
>> directory for every schema entry ... but the expectation is that these top
>> level directories should be per resource, no?
> 
> I had not considered that the info/ directories correspond to resources,
> not individual schemata...
>>
>> At this time I am envisioning the proposal to result in something like below where
>> there is one resource directory and one directory per schema entry with a (added by me)
>> "schema_type" file to help user find out what the schema type is to know which files are present:
>>
>> MB
>> ├── bandwidth_gran
>> ├── delay_linear
>> ├── MB
>> │   ├── map
>> │   ├── max
>> │   ├── min
>> │   ├── scale
>> │   ├── schema_type
>> │   └── unit
>> ├── MB_HW
>> │   ├── map
>> │   ├── max
>> │   ├── min
>> │   ├── scale
>> │   ├── schema_type
>> │   └── unit
>> ├── MB_MAX
>> │   └── tbd
>> ├── MB_MIN
>> │   └── tbd
>> ├── min_bandwidth
>> ├── num_closids
>> └── thread_throttle_mode
> 
> I see no reason not to do that.  Either way, older userspace just
> ignores the new files and directories.
> 
> Perhaps add an intermediate subdirectory to clarify the relationship
> between the resource dir and the individual schema descriptions?
> 
> This may also avoid the new descriptions getting mixed up with the old
> description files.
> 
> Say,
> 
>   info
>   ├── MB
>   │   ├── resource_schemata
>   │   │   ├── MB
>   │   │   │   ├── map
>   │   │   │   ├── max
>   │   ┆   │   ├── min
>   │       │   ┆
>   ┆       │
>           ├── MB_HW
>           │   ├── map
>           │   ┆
>           ┆

Looks good to me.

> 
>> Something else related to control that caught my eye in MPAM spec is this gem:
>> 	MPAM provides discoverable vendor extensions to permit partners
>> 	to invent partitioning controls.
> 
> Yup.
> 
> Since we have no way to know what vendor-specific controls look like or
> what they mean, we can't do much about this.
> 
> So, it's the vendor's job to implement support for it, and we might
> still say no (if there is no sane way to integrate it).

ack.

> 
>>> MB may be hard to describe in a useful way, though -- at least in the
>>> MPAM case, where the number of steps does not divide into 100, and the
>>> AMD cases where the meaning of the MB control values is different.
>>
>> Above I do assume that MB would be represented in a new interface since it
>> is a schema entry, if that causes trouble then we could drop it.
> 
> Since MB is described by the existing files and the documentation,
> perhaps this it doesn't need an additional description.
> 
> Alternatively though, could we just have a special schema_type for this,
> and omit the other properties?  This would mean that we at least have
> an entry for every schema.

We could do this, yes.

>>> MB and MB_HW are not interchangeable.  To obtain predictable results
>>> from MB, userspace would need to know precisely how the kernel is going
>>> to round the value.  This feels like an implementation detail that
>>> doesn't belong in the ABI.
>>
>> ack
>>
>> ...
>>
>>> Anyway, going back to the "#" convention:
>>>
>>> If the initial read of schemata has the new entries "pre-commented",
>>> then userspace wouldn't need to know about the new entries.  It could
>>> just tweak the MB entry (which it knows about), and write the file back:
>>>
>>> 	MB: 0=43
>>> 	# MB_HW: 0=2
>>> 	# MB_MIN: 0=1
>>> 	# MB_MAX: 0=2
>>>
>>> then resctrl knows to ignore the hashed lines, and so reading the file
>>> back gives:
>>>
>>> 	MB: 0=43
>>> 	# MB_HW: 0=3
>>> 	# MB_MIN: 0=2
>>> 	# MB_MAX: 0=3
>>
>> Thank you for the example. This seems reasonable. I would like to go back
>> to what you wrote in [1]:
>>
>>> Software that understands the new entries can uncomment the conflicting
>>> entries and write them back instead of (or in addition to) the
>>> conflicting entries.  For example, userspace might write the following:
>>>
>>> MB_MIN: 0=16, 1=16
>>> MB_MAX: 0=32, 1=32
>>>
>>> Which might then read back as follows:
>>>
>>> MB: 0=50, 1=50
>>> # MB_HW: 0=32, 1=32
>>> # MB_MIN: 0=16, 1=16
>>> # MB_MAX: 0=32, 1=32
>>
>> Could/should resctrl uncomment the lines after userspace modified them?
> 
> The '#' wasn't meant to be a state that gets turned on and off.

Thank you for clarifying. 

> Rather, userspace would use this to indicate which entries are
> intentionally being modified.

I see. I assume that we should not see many of these '#' entries and expect
the ones we do see to shadow the legacy schemata entries. New schemata entries
(that do not shadow legacy ones) should not have the '#' prefix even if
their initial support does not include all controls.
> So long as the entries affecting a single resource are ordered so that
> each entry is strictly more specific than the previous entries (as
> illustrated above), then reading schemata and stripping all the hashes
> would allow a previous configuration to be restored; to change just one
> entry, userspace can uncomment just that one, or write only that entry
> (which is what I think we should recommend for new software).

This is a good rule of thumb.

> 
>>> (For hardware-specific reasons, the MPAM driver currently internally
>>> programs the MIN bound to be a bit less than the MAX bound, when
>>> userspace writes an "MB" entry into schemata.  The key thing is that
>>> writing MB may cause the MB_MIN/MB_MAX entries to change -- at the
>>> resctrl level, I don't that that we necessarily need to make promises
>>> about what they can change _to_.  The exact effect of MIN and MAX
>>> bounds is likely to be hardware-dependent anyway.)
>>
>> MPAM has the "HARDLIM" distinction associated with these MAX values
>> and from what I can tell this is per PARTID. Is this something that needs
>> to be supported? To do this resctrl will need to support modifying
>> control properties per resource group.
> 
> Possibly.  Since this is a boolean control that determines how the
> MBW_MAX control is applied, we could perhaps present it as an
> additional schema -- if so, it's basically orthogonal.
> 
>  | MB_HARDMAX: 0=0, 1=1, 2=1, 3=0 [...]
> 
> or
> 
>  | MB_HARDMAX: 0=off, 1=on, 2=on, 3=off [...]
> 
> Does this look reasonable?

It does.

> 
> I don't know whether we have a clear use case for this today, and like
> almost everything else in MPAM, implementing it is optional...
> 
> 
>>> Regarding new userspce:
>>>
>>> Going forward, we can explicitly document that there should be no
>>> conflicting or "passenger" entries in a schemata write: don't include
>>> an entry for somehing that you don't explicitly want to set, and if
>>> multiple entries affect the same resource, we don't promise what
>>> happens.
>>>
>>> (But sadly, we can't impose that rule on existing software after the
>>> fact.)
>>
>> It may thus not be worth it to make such a rule.
> 
> Ack.  Perhaps we could recommend it, though.

We could, yes.

> 
> (At the very least, avoiding writing redundant entries would be a
> little more efficient for the user.)
> 
>>>
>>>
>>> One final note: I have not provided any way to indicate that all those
>>> entries control the same hardware resource.  The common "MB" prefix is
>>> intended as a clue, but ultimately, userspace needs to know what an
>>> entry controls before tweaking it.
>>>
>>> We could try to describe the relationships explicitly, but I'm not sure
>>> that it is useful...
>>
>> What other relationships should we consider for MPAM? I see that each
>> MPAM allows per-PARTID configurations for secure/non-secure, physical/virtual,
>> ... ? Is it expected that MPAM's support of these should be exposed via resctrl?
> 
> Probably not.  These are best regarded as entirely separate instances
> of MPAM; the PARTID spaces are separate.  The Non-secure physical
> address space is the only physical address space directly accessible to
> Linux -- for the others, we can't address the MMIO registers anyway.
> 
> For now, the other address spaces are the firmware's problem.

Thank you.

> 
>> Have you considered how to express if user wants hardware to have different
>> allocations for, for example, same PARTID at different execution levels?
>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/
> 
> MPAM doesn't allow different controls for a PARTID depending on the
> exception level, but it is possible to program different PARTIDs for
> hypervisor/kernel and userspace (i.e., EL2/EL1 and EL0).

I misunderstood this from the spec. Thank you for clarifying.

> 
> I think that if we wanted to go down that road, we would want to expose
> additional "task IDs" in resctrlfs that can be placed into groups
> independently, say
> 
> 	echo 14161:kernel >>.../some_group/tasks
> 	echo 14161:user >>.../other_group/tasks
> 
> However, inside the kernel, the boundary between work done on behalf of
> a specific userspace task, work done on behalf of userspace in general,
> and autonomous work inside the kernel is fuzzy and not well defined.
> 
> For this reason, we currently only configure the PARTID for EL0.  For
> EL1 (and EL2 if the kernel uses it), we just use the default PARTID (0).
> 
> Hopefully this is orthogonal to the discussion of schema descriptions,
> though ...?

Yes.

Reinette



