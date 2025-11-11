Return-Path: <linux-kernel+bounces-894398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3CCC4A211
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1963ADBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5725EF81;
	Tue, 11 Nov 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXQWmZA7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BF248883
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822859; cv=fail; b=QuhO9D82NrydgEjKWL/wOb5EVqy6O/liEZYZzwAFO7LQglDVJmQXjwZ1CUvm3CMw12KMQJHJWpuGPxS9e8jSxexhWZeYo7JbxmBEBpkoNP+Dup2NubSCZ7xFHRbEYBRwU8/4WL4RdYn8zmhUMZfx/PCyIf4dB2R8n9P3FnRBYwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822859; c=relaxed/simple;
	bh=gjHmsumOOttdPN+sb+29eAqXWBVlx8Vt0TozZTyEu5s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4NKimSI1aP9XHDrmwZmJzzQRSa8PWkhhcFtTPzVG9Mr4MChy0b5IRr4cmAXBF+mlwqjb6L3oXHv7/Zo2yAM6JvznM6IwtyUXIymR2TbluPeUiM74s9cQWeXDLXy6clh66fO+bvQ+mKLoRWw+TOrpjfWWwzTpFHx8f3GMXj/XK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXQWmZA7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762822857; x=1794358857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gjHmsumOOttdPN+sb+29eAqXWBVlx8Vt0TozZTyEu5s=;
  b=KXQWmZA7zyHNWr7PFgdgNVgt0isTeNFrstz4FGpT75PvKHrZqwbX/QtZ
   YQ4r4oVaRQK+hGu80Ag5TGrAvOdVlGJ/ckgp3BIR+yFp13Yp7qCt4Vf0D
   +woLOaWk1UJpvWdldUwnBxRmBRb9iXRGOdrCFTNbPwu2vyJ0CAw9C4xoP
   FllzmFS6NJ469dKP/I6DlwQHyYaK3M7qgD51aZpvLI9ScP0D19AN0UelY
   wf9D/Cae6070sjckQfyBluelNR0uDF+C2tos7bP5kLhtB3+Dm9IM8fTqT
   fc3pNIX9qxcxW1Wy8r2P0PfMWy3+Q85IT/FPWPyVVdNk8jcPxlqUccL7q
   g==;
X-CSE-ConnectionGUID: Hil2AZIDTyCWdpVebtC3jw==
X-CSE-MsgGUID: yiNjdKOEQ+KeSS15Vx/b2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76333536"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="76333536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:00:57 -0800
X-CSE-ConnectionGUID: CH0HqJowQ++7rG+RH44d+w==
X-CSE-MsgGUID: NZ/ejUXfQyyhZZRk/K5XLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="188655849"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 17:00:56 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:00:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 17:00:56 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:00:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZLJxQiGlM9i6CyBdulM/nZOIMUG0UIDqoBDq6fMzcWPks2ot+Rvi0whFi0aKhmGQCEXhkEH7QR8xSNKlLdOxV7BhfEgDALO9WGwLSn1bs80sIjJ9cfupuHpX2JDvq5gGj3ewipXtbd4hsuxBVa/aV9gWJ/ofUGHpPZVmUnM4rWtDSW+d7sRmXx+TqfAXSxewT2jnBS4WALBZnG/g+W7P4Fkz1qPBnwqg2Bm6EkBNuWRTIBfk9OF7cdyHiTvgh8AU0QhRUUm/4qk84gLYhI9UTPWhui1qfASLJBeJo7LSOH8sj8kyXS0GRTBfq6h6vcuPTNQCQTR9Ynan+9AXGcA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYH7ixoHOUcF+Oo4BecKFGhOY3MY8DjnQSi4+T+XxDM=;
 b=b9wo97wvsVx4zeodQDBRxfvZ/XaKoZa1m7FcsB3IAV+b6jEduFZS7zlPnVKC+3/C2hxbfMhOCZINGm5mh5bu79ju9NHdCb48msgtboqkU9KZrCtgyeZIipTNq6I9O1qrou8ZR6xLt2WretbksQ87SezsTYA05wffF6ehkEkvAgn8dHSlC2rp32dALXIqqxz6Po/1ZotbByLQ3LH+rPWByS3ucm2R/cCh5cP0SLnzlWE6FmjJfbKf+VT8uXkPogcYQ9U9IPbIDnJgl528kcDo44HXhj7v2QQ3fU2FpXr+2Vc/YyK2jKSnr3LTWWVvGLLNvqtiy3IDqAf6SDBTIzlPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7051.namprd11.prod.outlook.com (2603:10b6:510:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Tue, 11 Nov
 2025 01:00:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:00:53 +0000
Message-ID: <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
Date: Mon, 10 Nov 2025 17:00:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: "Luck, Tony" <tony.luck@intel.com>, Aaron Tomlin <atomlin@atomlin.com>,
	Babu Moger <bmoger@amd.com>
CC: "Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "babu.moger@amd.com" <babu.moger@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dae4fde-c1dc-4f2e-dad6-08de20bdc335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnJGUDdoeWNBVjdMWGtZVjYvMnZKWStDaGplRE1nNko2WXJwU3YwS0hJSXFY?=
 =?utf-8?B?eTRFZVNIUWNUZHJtaGRJaEM2R285RWdkQzQ2b1pLcW9SOU9GSVNjaWlQUDdH?=
 =?utf-8?B?dFFEbm5nWWR6akFIdHdKNExqWDl2VEQzY0hRYjdXcWVlNzJjUjNjcUZkdk5W?=
 =?utf-8?B?RTJ5L1h4NXlvWDgzTWxJeTk2YURlUUlVWE5yR01mTldmMlRlM2lrNW9pa2RE?=
 =?utf-8?B?Q0hFbWJ0WXFFT3pid1d3czYzeUNQdFUyRENTSmlxcXZmMGM5ZnRsczhpdU1o?=
 =?utf-8?B?aXh6UE44K0RyUURPY1cyZ201MjVFVmtUeXh0TEtSOUp6T1R2Z2U2Q210cXl6?=
 =?utf-8?B?MGJVUjJDTlQ2TmJ1M1RLdlE0aU1JNTJPZkxISmR5MVd3cytxRGlMMTVrLzdO?=
 =?utf-8?B?RDJ5cUQzanNGaHBoOVhQalZYK04wMGt1VVZQWFB5aGl5cHIvVWtLT0hQSjdU?=
 =?utf-8?B?eVdQNjloTEIrRXRjRVdjTzErdXFySWxER2tmNlY3WkNuY1ltcmxCejdmNlJq?=
 =?utf-8?B?VXFBUTBjNmMrTUwxN2ZqRFd0ZVQ5Q0tLNHVJUUdjdXY1ejdYQ0Izcld3aTE3?=
 =?utf-8?B?NEFxVDV2Y0xTOHppT1QxaWhDSDdmSjFpdmRac1ovVlVQUWN3MWlFdjJETm51?=
 =?utf-8?B?OVhHRkozNkxiRUNJOG4zWDBSN0hrSjNIVWlmVWhVYnI2OE5DUnZXR0huSWpN?=
 =?utf-8?B?eVVLUkZ3TmNBb3VKTlNzTVlobDJFV3RIWG9aWjdLZWRKeHFhb2t1b3d5dFE0?=
 =?utf-8?B?T0pGT1NJTVM1TEg4Q2UvSUM5K216TGMvUjdlUWVLQzVMTm1yNkw1SzJnUHg1?=
 =?utf-8?B?VWRvdFh5eGJ0ZVJzZURES096bHJIRmJTUTlKQVk3NnBHZlVheDd0RGxaZnhl?=
 =?utf-8?B?bEEzeUtBWU85NkVnV1B6anpQKzAxbTZIWVRuZnMxWTZaUEtTbVIvUGE2MzJN?=
 =?utf-8?B?N3VTZnk4ek5SWERFSUdYWTRUbGN1YjZtV0VIZWxLaDBXQWlDZmdUbE40dTN0?=
 =?utf-8?B?RVVEaFNVd05aYnNqdnBRdkQvYXBRK2RSMWRNV0lZQWdWSXBDM2E3R3A4VXhy?=
 =?utf-8?B?OXphc3hCNFVyRUFyNE5TdkJqZnNvT0ZXWUt3VWlXVm44WDlhdDRCWC9JSWFn?=
 =?utf-8?B?OWt5K2l1aGM0NGVIN2xCSVRSUG1xVFJwa0ZFd3NwZUVKUmxVNXBFb2k0eE02?=
 =?utf-8?B?RjhibzJFMnVFSjFEZThramlPQjA5L1lNQm02WklxOWhrVndEaklZVmcrMUFo?=
 =?utf-8?B?YitqSnJwV3ZvalRlNXAwRmczclZiWE92ZXdrTWVNTmEzRXdyZjVSM0p4YmJO?=
 =?utf-8?B?cFRDb3FIQmJsUHhUT0hickc3cURjZnVtWDRPS1o5cHo5S0xHbWs3dWd6ZHYw?=
 =?utf-8?B?QnFTdEtCRmNLVVVuMGxUU3RxN0NaYWhnaEVIUElQRkdKbGljVThGSDR0bWN2?=
 =?utf-8?B?ZGtGUlRzZUNBY3BvYTc4M0FtMmlBUkFHUGpEREVxSE1RazRFNGZtRHFjVDJw?=
 =?utf-8?B?enJqQ1BZTUt1eDBWdHo2UzJVVjNsWVpVa0YzZkptME9KdktZMW5XQTh6eXUx?=
 =?utf-8?B?OWxXbnFUQTZ0K2h5SHVOS2FyTGRQbHo0RGFydHI0MXpPamlkY0UxQUhRaE5H?=
 =?utf-8?B?MGpmd3JyM2E3MVVwV002eWdFSG92cDBWNXExTXVjYUNXajBmWjU2QWtPOFpO?=
 =?utf-8?B?Tm9CbmVqc0JtSUlsb3dGVEFkTUY0bm14Mmt2RlkyL0prWndPdU9EazR3cGpv?=
 =?utf-8?B?eW56NEp4SWFGRmN1OCtTQmRZc3BrR2R6M01HakRvTS9Hakd3UXM3VkRLWERm?=
 =?utf-8?B?T0x6d3cxU0ZjanNjdkJUZ29tblp0U1cxMGtqNEtRSEJ6RE5HdTlia1V0eHUv?=
 =?utf-8?B?bFhtWHZEWmRib3BWbWY4bVBCZ3JtMTlpOGJKbW1oZ0tmZkY4dEVJRloxRGgy?=
 =?utf-8?Q?0DDqNE4+9RcpsDE3FYwBHGAp600ETejg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUR1NWZyVzMwUlRmemVXUnVSWXZ2SDZETC8vMnJHOGVmK2pCeEVJUzFNdGtK?=
 =?utf-8?B?UTcvL3BNZVorR1FvaEwvdXU2M3BNVWo1dlAzRlE0NU56L29TZVRteHdxd0kr?=
 =?utf-8?B?R254QWRWczBsc21ZaUpNd05aNmxSWG9wdGU4ZC8ybXpTdzBjV1M4eWtjRlJy?=
 =?utf-8?B?K1Bob005aEcwNEs5V0VFVnRFNVdDSmwzYjV3SjlmTU1xZ09GeUV4Nkc4NjNF?=
 =?utf-8?B?WEdRNWkzcnY4cUZrNFVOdGkyNm04OE0zckkwL0FGYkpwbm1kcmE5K1NvVW1l?=
 =?utf-8?B?NlhZQ2o0MmdtcWNZRGpZNjM0RFdrOWRBOTlTUVYrdWMybW05elhGUjRjbUE3?=
 =?utf-8?B?ak5IY1Z2blBOQTVkRmtvNTRvZkpNRUJybkhIM3gyUVo5TFJOSzgwRDY1elB6?=
 =?utf-8?B?V0kvbTZ1QXJYMVgwOEZRTWdBUlhPL0lXekd2NFdycXZWdEZPOUEvU1ZVMVhT?=
 =?utf-8?B?bnh2ZElqOEthUkhWOUk3TTQxSy8wV2xYYUFQT1ZJUERxcUJTVERqYlRNSC9R?=
 =?utf-8?B?SW90Q1pQRHBHc0drU2Y5ZkNVRVI4dHlHWFBZK1lnRDFTV05rcWcxUTh1ZHhB?=
 =?utf-8?B?Z0Njd3ducDRtZEtwZUpWOWJvcFBYRk1FTVBDUzU5OGljR3gxWWtsZWp5V2g3?=
 =?utf-8?B?TEdXWEVPMk1COEJlUXJmcm9qMVc3QmZYbHJqMjNpYTJyVFpMWjJXcytxbVhj?=
 =?utf-8?B?ejdwcnJIdUNaREM4L1REZnZIbEt0QnpXa1VwL3J1ZkVELzZlaktwMXpERFpp?=
 =?utf-8?B?MG9QbjdBK1NzQndrRzBQRU5VTm0vb0l4MEEraURRSURQRjFaZ3Uyd3pNUENy?=
 =?utf-8?B?cTVrbGwyT1BQUGVUZmFyZXFqM04zMnVXZmpMUGZKTXE0dXQydjc5REJDdzVp?=
 =?utf-8?B?YUd6Z3o1OThRNzMxNTljVDNXSGtaS1RQd3Jybk55QjFlTVh4NGhjWFFWV09M?=
 =?utf-8?B?MkQ0NnJqNDQvc1FYVnR1ZmV4d0lvRG45NUNNOENESHd0YUFjM3NXekp6bzZ4?=
 =?utf-8?B?UXhDcUxXZUwzdFFyY0xtZElzSlZzMU5YR0hvVzNZMWZSb3R3b2ZEMHBpZnhi?=
 =?utf-8?B?bUp5L0VsdXN1YVIzYlBtSXRNNTc5cVVWc2hoZzgrR0tIZjM5aGFiK1BVQTkx?=
 =?utf-8?B?M056N045RjBEaTlNVnBEQ29HaDNSVEVaT2JhWStxZGxNYjZtVEZsaEtVZXhz?=
 =?utf-8?B?Y1ZIeWRoMmVlYlBubXgzdGJJRXVoMDVWQVhqZFM3cnFGSTNseTJqTEpXUDd1?=
 =?utf-8?B?dThuNjAySDlKK0tOM2FXVHVtallaaUI2dmUyZldyQlJvRG1RNHE2Rnc4MlRT?=
 =?utf-8?B?QTBZa2Y5TGpnRWMxZk5GU0xMc0JmZUlWS3VLdmd0eVBmQ2pRVHJORHJCaUJp?=
 =?utf-8?B?WmcxMDdoS2RXTmlwWDVoMEtqZmd0ZjdrakVNc2pKcjlKTGtQN051L1VlQXFs?=
 =?utf-8?B?eExiZWNLckVkbzZVcDEyL0pBcHJuVTYzNjVNajE3cWw5bmZRdjlxN2lsd2p6?=
 =?utf-8?B?aFp2TGFpOHowZHFuK003VHlUTzdadGp2M1hpbDY5emE4ZVBSbDNuL0VnMUFw?=
 =?utf-8?B?bzF5R09teFNGTXcrZ3QwN3VyVm9aODRZT3doQXhKWmRxUEFDVEs4UXdEeWNa?=
 =?utf-8?B?b2pqdG14VTVrd28wbytVZzVZRmhCMEo4Y1VZNy9sMnVnOGxuZ2tpRDFrSUR1?=
 =?utf-8?B?L2l2QjlUcGlENWhnSUJRV2EzUGNVWEJRbmVXMnl5NUdvZjdqcUl5bkVOdjNh?=
 =?utf-8?B?L0hDVWxOTk5BVlllMmJ6NmxLRTYrc25Fc1ZWTU1ReXY4eDlMSERxa2xQY1J5?=
 =?utf-8?B?MnR6bUdKRS9Pd1VtNmQxUlJ5bTZoRUlGTmlGMGtzWUF5a1ZzMTJ0S2RubVZL?=
 =?utf-8?B?NFNVbFRocktWQ2txQnlYaXVjMy9ldHV1elVXWFk3eE5EdmJNQVNObkplSjc5?=
 =?utf-8?B?OTJ0L2hNRGY5QUFRMnJvUm45NE1VQ2RhZ2lYU1I5Uk9TTkE4UnlnM1ROdVpt?=
 =?utf-8?B?REpYODZGRGNxTFFhK29KejZDN3pUMitEcnhaUFNPcHlQZ0taMXRFSnVSMzVC?=
 =?utf-8?B?Z2hyWFloekhqbmEvQ1VIUVZRSFR4dG40ekNmSHdwMXd6Rm9vbXpHOVo4dDNW?=
 =?utf-8?B?VytnRnNGaW9JMzdpNHVIR1JkV0tuWXh2UHJsQUNMMmRHNlZVdnpWekd0N1U0?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dae4fde-c1dc-4f2e-dad6-08de20bdc335
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:00:53.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFgxs+b3p9Mmh1CoaEx8qAxGhR9xDaMCZ6xVpg1RkQkSphA5JeWgE9GLPC6BhumDTTEwtPvAfz0icLMFAQs/nEBrmHXQ4XbNdr2Hkdld+DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com



On 11/10/25 4:51 PM, Luck, Tony wrote:
>> The goal is not just to "clear" the CBM, but to reset it to the smallest
>> valid mask.
> 
> "smallest valid mask" seems like a fuzzy concept.
> 
> Intel had one CPU that required 2 bits to be set in an L3 mask.
> Subsequent CPUs only requires 1 bit.
> 
> AMD allows setting zero bits.
> 
> So for AMD "smallest valid mask" is zero. Very simple there.
> 
> But on Intel you must have either one or two bits set
> (but it doesn't matter which bits).

Right, and this is exposed to user space via, for example for L3,  
/sys/fs/resctrl/info/L3/min_cbm_bits.

> 
> In some cases you might want to pick a bit that
> overlaps with the space shared in the cache for
> non-CPU devices (typically top two valid bits of the
> mask, but should check CPUID leaf 0x10 for the exact
> bits).

... and this is exposed to user space via /sys/fs/resctrl/info/L3/shareable_bits
and for this new feature the domain specific values can be seen from
io_alloc_cbm.

> 
> Or you might want a bit that does NOT overlap with those
> non-CPU allocations.
> 
Seems like user space has needed information to perform a sane reset?

Reinette

