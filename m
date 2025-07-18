Return-Path: <linux-kernel+bounces-736232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19AB09A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03F83BC44A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F601C8632;
	Fri, 18 Jul 2025 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWPd2rpX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B2E1C861E;
	Fri, 18 Jul 2025 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810744; cv=fail; b=L2NN2Rcy98eTJG4OB9kyJwKUa3LrqvZ8ECIVegKigjwuqmQv2/UksuPDPgsEckIz1x3lsHK6QXEsRH7M4Zmjrj2fbihlThHl8u+KQFJNK/cfpk4Ry1u7MdFNb9cOtPrypTMJiqnoh11Xn0B0az7HpI63goyuL7nLiSAmfwqv1yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810744; c=relaxed/simple;
	bh=8BvWwdhwQZX9mNujBeEQFiqYnPVHyjbg9kowbdU7OKM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D1P11E2ZuU4bwbew2KEk0ezzTVqVJ0inVmz4YNZ4lN0dF4PbDVW8kYzsHY+1QP2WOoELgtF7a5CEmsMg4ARGlnaDLiQB9APtwSf5ZaPgPIcPkwmnKB9dvjRsKD2xp5s5XzLnacfZYlsKB+X1GXSPQ5ctqLfr4+aEgAhp02mAIGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWPd2rpX; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810743; x=1784346743;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8BvWwdhwQZX9mNujBeEQFiqYnPVHyjbg9kowbdU7OKM=;
  b=dWPd2rpXYtUvGq4KeevBuUNzhTnLFY6PBpaq5mQeEV/waQkSacxvRX+c
   JekZyk+vbDcPJIIMnNuc2Manxri1k6cm1JwxznVbs1L4muwWofMn2NvM4
   fQW75cmxF1Nt0LRJ+JMz8ZT9bmyd7cuI4NNox5luQXN9A8tgsl3Itgs1t
   oW+uU40I11BUD92KyVXgHIEqXSqC+Slnv2PMb8emCE5xVPJRVSaZIFpmw
   V3NQImSnEV4+W1zC5u6gI55UHC41LDX3/GQlWY6/NRwh+ApczhZ5jz7ph
   EjZxnXvsuJwxSvWnctl6JCekzoKpPxg1VOIMaKkKYXf7O+YIKep9aZCp4
   g==;
X-CSE-ConnectionGUID: p6MFvRjKQFm3n42MYUl4fA==
X-CSE-MsgGUID: BQzRLytWSYqEwjytypwXJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55040411"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55040411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:52:22 -0700
X-CSE-ConnectionGUID: SW/CIec+TmyM81Xwf5Q3Qw==
X-CSE-MsgGUID: 3O03N5ziTsWFjw5BMBoAfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188940459"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:52:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:52:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:52:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ5VlMcIMDhj5iJk7SA+Ev32upbi9f1sUeBMSdzj0/9oU7YXEfnLMqSk4/Np+vAduTuinyG1XGujSpZsQMuRXNQ7gvVcMxYaAF4xxubHGwwURKPCT+4dbWX1JY5gCJcVg0TezFmLwWkwr63nDKlIoFrqwJ46fT5M0iXmU7YgnMNpenW5ziNLkJESzTyegAB38UMeYvoHUwvtkqULCpkmk7Z2MFrPX7IvWqHUimPq4DKYVOlHN8sRQj7ZVI4XhHbhkldl5CHAJABPS1hX2EjAGFe8ktSckcfwglYD2ivJoVGOA8nk9/t6m4YcTP0e+i2MxXpbFFefttkQndDGJekZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4Il754qXol56havH7MoqyIOmjtqJ1jDwdM9+3XBu88=;
 b=ZVallwWYT9kx8rkMed5jqbQ0AuU2RBo2yqMrNElWrabl9z4tTu1jI0V4yI9zMHqLdHTVGY+bw2RKAlVNUbFC5xRhURjibHFdQVzijS/nrNWyrukHCrBKMzYGS6HoAaEwwe1OXmPUVYOK+6ArF8OBnpQxSXwVsWSKDWDGS/4e2gXqpbRJY3Fg4v5DHiC2DhdZHzngEngLqcN0UwmsAYcMCYIW01DLEJOBmi3khDuslA5vZKLH6M7BaA/nZRH6txXU1gCtwvCtfBOQG2j8w+7tyfGd2S7MkqL2si7ckh0umJQEoK+p7qYZWOEZc7XeuwFfd/h9YR2BbYAX3ViyXk3ieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:52:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:52:00 +0000
Message-ID: <272dc6d5-eb63-4dde-8201-880acc9a3846@intel.com>
Date: Thu, 17 Jul 2025 20:51:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/34] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <d31ab6c51a57591423d3aa7b8e741972cd66eb91.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d31ab6c51a57591423d3aa7b8e741972cd66eb91.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1050f86f-9e23-4c9e-d7ea-08ddc5ae72f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OU1tLysrdjR5aG83cU5YNENMNWhnU1hidFpqSUx3OTVHTXp1dDBXU3JyYVl5?=
 =?utf-8?B?Wi9FdnRENktXdzZDRmNsSS8rSFdwTjlWVHUxZXNnZS9rTVJadm4rNjhYNlJ6?=
 =?utf-8?B?eDN5YXNVcHY1cjlIbWdSV0hSb3JsOEl2VDNSU3dEQnBtZ1lmVmg4alFuQ2xq?=
 =?utf-8?B?WmdwQURJSlNmdUtHUzdKR2Y0WVVTaklhVDUrRVJQUVV1T0k5WHZYVFFiTmdr?=
 =?utf-8?B?akRZd01Oam1Rc1ZYMkJWeWw3WHUxZFlpWFBWRTQvNFMvdVNBenRRK205M1la?=
 =?utf-8?B?ZlN2Sy84eTFjRThJSW5RQjRxM0NoTGxaWk83dzRxQk5paHhqQkhUVkg5M1I5?=
 =?utf-8?B?ZDdRMVBUd3hhSk1aSm9kenBHNllIQ3VYbHBZQnhra09NS0pQS3lhakZ1UEp3?=
 =?utf-8?B?SkJJRFR2am9ZTUNkVU5lUzZjMkRrRENrSjVtZW8zQ2tRNDJ4L0x0VkhDTlhs?=
 =?utf-8?B?SUJhM0ZSTTJRTTRWbjgrdnptWXBvUWxTemlrdGtscTZiUUNpTCtUM0ZEaUdm?=
 =?utf-8?B?SXRjeGRic0tMTmJ6OEpBejNyd3ZLdG9pUTlmaWI2MmEzeDNHRDhYaDhCTzhp?=
 =?utf-8?B?aXRhanNVUDRuRDJITzVOeXlZbFFCc3NiME1GRGI2MllydmhIQy9xSHAwTnRq?=
 =?utf-8?B?VGY3Q3pqek5wV3ZwbXR4NkRKMS9UbGVDblQrSnp5VnRaN0pwajZUeXEvZmVT?=
 =?utf-8?B?MCs5YTFrWVErVUFIWFQzejdDYnJmWDRSN3c3R2lyVjhxSHdaSFRqQ09xQlR0?=
 =?utf-8?B?WnJ4TVBhOVBUa1BHZjBvT1FIem1zSU1wazNBSFhpVVorOUZWUElLaGdJQ2Nu?=
 =?utf-8?B?YktDSlA1aEpGN1lyQ1grQTM3aE5YbUZxSk02anVUR3BWYVovZm5MaEM2c0xT?=
 =?utf-8?B?dEVORGhrL3hOaUI0OXBTVDVLaG9MbXJ1MnlKdTlnZkFFYmF1a25lYitpWjY3?=
 =?utf-8?B?QlYvVHhQWHhxcG1Hd2dWM0JHbS9Zc0ZFTHJaWmJQM0VzSVc1WG82RHpZWHc2?=
 =?utf-8?B?NnBxMEZsQVV4Qk5GUkt6eWFsREJRUmlPMlJWRFlPZVZlOG8wODFWUGhMbEtN?=
 =?utf-8?B?RVQycDhvTHFXTVdoa2J2QVB4R3hhODhSY202L0VIVUpmaVIva21rN1I0elFr?=
 =?utf-8?B?SWlXQVA4VW1qZmVSR0M5dE4yaTI2NEVpWUZlbGFUMGRhY2QwMzJyYUEyZnpP?=
 =?utf-8?B?dEt2VkwvenBiOVRKY0J6TXJ2K3ZVTHJKSVF6Rzl6NDU1am9ISUVIbUN3aGpH?=
 =?utf-8?B?dERqaUUwQjA1akxLejJmU0sxZXp5SXA2MkhwY3pIL0dvMEZ5c1VORkMybFNq?=
 =?utf-8?B?QVlKWElTZHBrSXE5M08wcWY0cGc0a0tzcGJEMmFwZTZKbmlLYTZqWVk2T1Uw?=
 =?utf-8?B?d3ZkQUlPenBBaUYxQU91eURaU2N4bTZWVWJoblBIRWNDR054QnNqRXdsb3Zy?=
 =?utf-8?B?a1NHaUpHaXJ0bHo5Q1dLNjlVckFOSEs0NHRGUjJRODdmYVVuMVlaUkVDaDIv?=
 =?utf-8?B?Vm9pcUhkNlZVejZDVDNCTmh0bDdTR2lxY1hwc2VyV25MNVc0ekJvczdRK2pk?=
 =?utf-8?B?U3FpMlA3S3RpeDRRUTNJbjdCRHI0L2N3aHZ1T1BkVUhMSnRyeVpVazZkQ2hp?=
 =?utf-8?B?Nzh1b01DcWNNNFVSajAwUG4wQmE4MHZOT3FlUXFlSldyQmZQRHJCbDh2eWRh?=
 =?utf-8?B?UUsvZWNZNmRjK3dKUmlUSVc0U0FIci9QZHB3ZHlKOEd1ZzNEUFR0RFM2bURT?=
 =?utf-8?B?cnpNWG1lK0ZzVnpreGZvVU0xUmhZcXUxdzN6QzVDSXJHcW5LMmFpZTZDTDBZ?=
 =?utf-8?B?a0hOa011S1I5R3VtQlZOejM1L3RzM3BQMTFlKzVNc3RqVVdvdVRTMDRmNWd1?=
 =?utf-8?B?Qm9WRVU0WGV4NTVhaGM2dkFJRklqTDlqdXRGbitiNmpVK0o5ZUp6aXFiOWhm?=
 =?utf-8?Q?oUQg62kFZD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVvOURSRlAza2IxQmpwb05VTk4wckxOT3ptWkFISFphdEZEM2REOGRUOXpO?=
 =?utf-8?B?OUU2eVdqNzVHRXFSZGQzUTA5R1ljdWVoZnhRNVNnaExRL2JYbkFkb0xQV0RO?=
 =?utf-8?B?MUZ2cndCQWplTTMvWWhyOFBNRk04Y1dMWEkxWk5KY2ozWlNsZHJZSFBodVpB?=
 =?utf-8?B?ZGNaRURGbHFHUHJQZlBTUnN3bGF1cXVVZDZURXBKR3BzK3J4TjRQOFhsR2Y1?=
 =?utf-8?B?MUY0bUQ3ZE5QbEFjbThqZFVEYkxTanA0MmRFT3krSG5GeGdYcjQ4VlJlS3JQ?=
 =?utf-8?B?VHJ5Wmltdmt4aGE2WjlJMWRDbllKelBxZ2pqOVNPejNRZkxNRkVuT2pUOVpH?=
 =?utf-8?B?WllFVUcybTVvQm4xN2xYbDZFWU5JV0ZsTE5oTE1XcHB2aWl2T2JIN3VidjVa?=
 =?utf-8?B?SkdIS3UwSTNxUm1SNSsxUlRKaFBNSXNEcldGc0FuemUrTWg0L0N6aXEzQ2hC?=
 =?utf-8?B?N21aMWdyMForVW9aUFh6OElvY2h2SmNVbXlkL1VGanh2OVF4aVlBVEg4TDJ3?=
 =?utf-8?B?TWRYYktiU1MzdzZWTEhVZUJERTJQdjZrZlg0NzRCNjZrTFRjckF4UW1MUkNM?=
 =?utf-8?B?Wk90ZGphNGtuZUFLMUJlUS96bXp0RmFwcURhYVA3UXI2ZDI4eEdoNlVFRWcx?=
 =?utf-8?B?MDAyZGJXM1dqamR1QUhtcExXdzhramdoVjRmY09JWEJ4UHk5Vzc4R1BaU01J?=
 =?utf-8?B?eHNTM2V4eWIwT2laVVdFQmVMeE5iT2hyUm85Z0hWRk1rclJCd2xqYTRwOCtr?=
 =?utf-8?B?QUVXZGVROGpoSjVLL2tiamFGRmpDeGd0Wkt0MFVJZlFSVEhudFo1SDBCVFZn?=
 =?utf-8?B?Q1JRdGVNVG8yR3dUUDUwNUJZdFhzQ1Bkc2sxUjJDR2pjM2E0Q1p6MGU4eGEy?=
 =?utf-8?B?SFZud1BJWGdKQjZtb1VwUzZEaGRpbE1BZmJNWWlFSTNFem5yQVhLUDBLNmdD?=
 =?utf-8?B?Mkp4N3NVa3JWWGxWdE1ydG40ZmpwbWZnVWU0MFRqNlpFaG9HNlZHSXN6clNj?=
 =?utf-8?B?eVQrUjQ3bmlQNTVnLzU3dWtpRmMrT2xNWW83eTU2UTMwSzEwS1NxMzZLd1ZF?=
 =?utf-8?B?RFB3NzZNTWdXMkR2YXpXSG9RQmxKWXZFbjE2N1lVUkJaMDZGZTFxd0s3emd1?=
 =?utf-8?B?WkNneHRYSDlqZHdybk1OWWZhTVAzQllIaVJTODg1dTVXL3I0bEVIMG53Qkcr?=
 =?utf-8?B?Zmk2MG94Z3JIQ0VjOUlpL004WkVnZHFtYmNtQ3dxRERGeXp3ajVFRFZ0V0RZ?=
 =?utf-8?B?ZW4zUHo0Nm04ajA0TVZaZEJ2OEErb09BcFhzcUFxcnNORUxDS2xGRDlMbUsy?=
 =?utf-8?B?OUhXS0V2Zlh3MlovN3cyRmUwYWwwaUltRS8zL3hhamZFODM3NWh6dytPQy92?=
 =?utf-8?B?SGFEOUg1Vm1XaVNVVDlvRUhGQ0FDRnF1MTJJdW9NcFU0WlRZeVNHU1g5Y01N?=
 =?utf-8?B?M0dTOFBKRDk3b244Z0FyeGZOYUFQTGs5YnM0STVtUFJlN1JmWk5iN0RMd25X?=
 =?utf-8?B?WVBjMFVicjh4YWRTQ0VBMytxWmZEOWhCbk12cjZyYitJUjVGWWVoRWZ1ZG5l?=
 =?utf-8?B?NjM3cFlIVWxCTWQwSWFYUzZlalRtblVNZWdFR1YzS2p2QXFydTdpMTc5Tnk5?=
 =?utf-8?B?RFl1MHgyeGppNnJlWjZWNmNCV2IyWmNZamh4SExoMEZXTEJWUytwWXBVekNh?=
 =?utf-8?B?TUpDMTA1a0JTU1FJWG5tcTdPNUlEdElLMDNCSU1oUmpzSkJnS2FJUVVaQTNJ?=
 =?utf-8?B?MElyUXRhaDU4MEY1dTJENEdDbkEycEdWTjdUOUszUGhjUFJZVmN5NFhTaE5I?=
 =?utf-8?B?N3lJTjhoK1VQbEdCdFE4OGo3dzBJSlIvUHJ4cFB5WTMzZHFLNEpiMEptd0xu?=
 =?utf-8?B?K3VmdVlUWlY2K3F0M2c4ZDQwUDlTcWFrUFl4Tko4UUZ6bCt6eFJtYXo1OUx2?=
 =?utf-8?B?a2dtQW9CWlQ4b3hJRk1SN1JoMHFQTzZ0MU93cy9rNER5WnB6S0RNaDkzdFRx?=
 =?utf-8?B?QzRwT0NHbGp4RnY1M3J5c0VYU2VESzJJOW1hNWU1TVk5cFVGZG1BYi9UQWFv?=
 =?utf-8?B?SEJueGRkd0Q2SGlDTzVQa3RUWkFIcGN6dHhhWUNsWGhhRjNnSmluekZyNjhy?=
 =?utf-8?B?SmhkUVRXNkZId3FaZkN3a20zRHFJYTYxeDA4U0g2eCt5bENKdHlmQ3lvL0Yz?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1050f86f-9e23-4c9e-d7ea-08ddc5ae72f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:52:00.1715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf/JuN2omX9es9pLFIRtasJMmwe5f/nYP0erWffwQqTN9rsAg4sbniE3YJh1fajef5REJ+p4GREMEgbg5Yb3NQi7pxlCQZTHT09KwBTdKJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> System software can read resctrl event data for a particular resource by
> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register
> and then reading the event data from the QM_CTR register.
> 
> In ABMC mode, the event data of a specific counter ID can be read by
> setting the following fields in QM_EVTSEL.ExtendedEvtID = 1,

Seems easier to parse when "fields in" -> "fields:".

> QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the desired
> counter ID. Reading QM_CTR will then return the contents of the specified
> counter ID. The E bit will be set if the counter configuration was invalid,

Where is "the E bit" defined?

> or if an invalid counter ID was set in the QM_EVTSEL[RMID] field.
> 
> Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to read
> event data for a specific counter.

hmmm ... they cannot both be used to read the event data? 

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  6 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 70 ++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6bf6042f11b6..ae4003d44df4 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -40,6 +40,12 @@ struct arch_mbm_state {
>  /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>  #define ABMC_ENABLE_BIT			0
>  
> +/*
> + * Qos Event Identifiers.
> + */
> +#define ABMC_EXTENDED_EVT_ID		BIT(31)
> +#define ABMC_EVT_ID			BIT(0)
> +
>  /**
>   * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
>   *			       a resource for a control function
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index a230d98e9d73..026c2e2d19d3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -259,6 +259,76 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>  	return 0;
>  }
>  
> +static int __cntr_id_read(u32 cntr_id, u64 *val)
> +{
> +	u64 msr_val;
> +
> +	/*
> +	 * QM_EVTSEL Register definition:
> +	 * =======================================================
> +	 * Bits    Mnemonic        Description
> +	 * =======================================================
> +	 * 63:44   --              Reserved
> +	 * 43:32   RMID            Resource Monitoring Identifier
> +	 * 31      ExtEvtID        Extended Event Identifier
> +	 * 30:8    --              Reserved
> +	 * 7:0     EvtID           Event Identifier
> +	 * =======================================================
> +	 * The contents of a specific counter can be read by setting the
> +	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
> +	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
> +	 * desired counter ID. Reading QM_CTR will then return the
> +	 * contents of the specified counter. The E bit will be set if the
> +	 * counter configuration was invalid, or if an invalid counter ID
> +	 * was set in the QM_EVTSEL[RMID] field.

(same comments as changelog)

> +	 */
> +	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;

One of these must be the "E bit" (unclear which), leaving other undefined?

> +
> +	*val = msr_val;
> +	return 0;
> +}
> +
> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			     u32 unused, u32 rmid, int cntr_id,
> +			     enum resctrl_event_id eventid)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +	struct arch_mbm_state *am;
> +
> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +	if (am) {
> +		memset(am, 0, sizeof(*am));
> +
> +		/* Record any initial, non-zero count value. */
> +		__cntr_id_read(cntr_id, &am->prev_msr);
> +	}
> +}
> +
> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
> +			   u32 unused, u32 rmid, int cntr_id,
> +			   enum resctrl_event_id eventid,
> +			   u64 *val, void *ignored)
> +{
> +	u64 msr_val;
> +	int ret;
> +
> +	resctrl_arch_rmid_read_context_check();

Is this needed? I see this context check as related to the MPAM cache occupancy
counters that need to be allocated when a counter is read (see comments of
resctrl_arch_rmid_read() in include/linux/resctrl.h). To me this does not seem
relevant to this work since all allocations should already have been done
when the counter was allocated, no?

> +
> +	ret = __cntr_id_read(cntr_id, &msr_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = mbm_corrected_val(r, d, rmid, eventid, msr_val);
> +
> +	return 0;
> +}
> +
>  /*
>   * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
>   * which indicates that RMIDs are configured in legacy mode.

Reinette


