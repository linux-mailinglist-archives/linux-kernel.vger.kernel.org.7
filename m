Return-Path: <linux-kernel+bounces-879252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5314EC22A39
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30F014EB7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2F33557F;
	Thu, 30 Oct 2025 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEIsQXjW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C632ED2F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865549; cv=fail; b=t3+0t3bAYRaf3WjP7DQlpjG8yZFo2dpwwr4K3zsfnJ/rVhJ7XFLV+BsI0WfR5B3ZpmwuYxlZu9p3k83lW5s1Ybje4/F7dwP/JoJW7wY+ytPJgBN7EeeIi4232MhzGlE5szI/4gMg76ZTFmb2gujYgIpifm8xz7QCgWaUu/JWqQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865549; c=relaxed/simple;
	bh=76nxDP+nmGpWRaYh+eCvHpfaP9dSo2oV0mo9BORvbUI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dIyXs9uwtZPqgIXDLwZhgfzD57gFxd8/JieDei0tePcRWYmd11wVNGsTHwaL7tYJnpVo9pHkX/DE3wLHR5uCivyQzXmMTPAvk5HSYxEjd2HYIvdf884Qw09M7G7SriwueYYav0yXTB+NJeUaxVvcLQguipl6y4gCpOxwfJkrEsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEIsQXjW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761865547; x=1793401547;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=76nxDP+nmGpWRaYh+eCvHpfaP9dSo2oV0mo9BORvbUI=;
  b=UEIsQXjWFW9tiDmds2Dvt7Xu5g9hUy6NoN/uQqXFBfiFtXjzwoH6l99r
   gz29DzOtC2cxNINXy/dLGkyjGFsG7mkKQGoqgIp0pkxoRVzKCAmPd7as0
   nkfk2hT4uP/Znd5yTJHrAnI+P088vt+f7Ao0B5/Dri3LGW4UqjoS3vMtW
   o2XbVco2Z0laIdkJj4D84ZY3CD1eJJX9adRE+hva76IF7E2IenarEqkJX
   TdXvNdri12gx8NIFcZ5q6QGqzPCTsbkiwCv8y3iP2YQqpAo3PiHLxwoQv
   EUhLfgHiehH+bLTjm6/m2q6JQp4ixqQz18AnbUPaqpCgz52dyGMAcBQHX
   A==;
X-CSE-ConnectionGUID: ItX2HpnJQse0NIFTC1hIRg==
X-CSE-MsgGUID: EUTIE5bxQl+G0qFhw7Jl+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63927520"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63927520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 16:05:47 -0700
X-CSE-ConnectionGUID: dA5iN0IjTcCTrL+PrBW0+Q==
X-CSE-MsgGUID: fthF5vJbR1ihYaVu0eVAuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="216735779"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 16:05:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 16:05:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 16:05:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 16:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMCTtu4xxorRVQeOz1Ba/ciyXoL4x4ZheH3rdWRqXZMdY9L5S3BU4npfkZ3xE2bOtxGU6nFoocailnfObazgyuBdu6lCSUixZIGOcdspWExKHaQG2h2MrrTpeijlkq5R3gI7QMbXkdrPqu43XzhODjBucTvh8jMf29kFV861IGYjxvCzXjYsw9CRiVKvTdFKYVKYgSOgjbsQFq/iCB0Zif5ptykhmlWuxmvpGW95A9ALV3bBJ/th+7w64bBlhFfFv7f8H4mp0fvqI7GSLw0QkdwmLkXUfmVWMNFffAEciqQCNu4Qi8adZBmXsPM/gdNXG8VYsVmpqKBOrpoGyKOAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKL/VUVLwEpzK7Q6YBtDRRi9vghk9plBzj4dfqWwrb4=;
 b=jivQ/jMFr21SwrBQq19GIrqd1aufTujOkf+Ff3vMsD3QNJmh+l6KKnz/MvCPNBmTnOqZH2TsBMl6nyUWFWmw30FGKVwtukG7fxaJEQdKZOKuCKy44JCLP3oFlSCVOTfgL4aiW/X1TT7lEa7w5V6Yl0GEREWkgj2ZMwR1Rm8WBbkbb6jjvKEiO9pUUi07qtYbrBpmhSaCVecrpDVePlAeOY2OnSfacTPl+9GY4f5MUcu1Z/iSm17NClc+HkGpx70XFlSQaDhEXCHB3qfGZzB8QSMQDL+zqU63GFmiCIP+4y0hOFsQ+QrZSUfu4TYLz/cjZ1uk3YOzqbeBx6t/EpQpxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 23:05:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 23:05:42 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 16:05:40 -0700
To: Sagi Shahar <sagis@google.com>, Chao Gao <chao.gao@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <reinette.chatre@intel.com>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <vannapurve@google.com>, <paulmck@kernel.org>,
	<nik.borisov@suse.com>, Farrah Chen <farrah.chen@intel.com>, "Kirill A.
 Shutemov" <kas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <6903ef44cbf81_10e9100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <CAAhR5DEQw9eMVJ_mWRP3G=XqmsR4_46xh030_Vtyx3HzWXn3wA@mail.gmail.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
 <20251001025442.427697-8-chao.gao@intel.com>
 <CAAhR5DEQw9eMVJ_mWRP3G=XqmsR4_46xh030_Vtyx3HzWXn3wA@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 80716986-8222-4f36-fea7-08de1808d9bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nityc1V6djRkZ3pJVVlGaXFxbjMxWmN6Q1B2K1NFQmFXYUxKTVNQT1JYSzls?=
 =?utf-8?B?bVlLcUtHOEsvNG9ZdFVsc2FabkJoU1VYaVZBZ1phcVZvdEtkblhnbnVrcnQz?=
 =?utf-8?B?UGZ3blpQbk9QWmtabXVDTlI0Zjhkb1A5SXE5UHdJbU1XM21rNmNJL09haXFk?=
 =?utf-8?B?a3ZwZzZFZ2wwNVRFZ2VmN2xXOGlCbkRyWkV2OUo3NDNpNDRIWXpCSGg5am81?=
 =?utf-8?B?VVBRR2J0dVljUWVFYkZ5MnVIZzVpQjRBR3dMUDRoeHJWcUpiUGxjZ21FQkd6?=
 =?utf-8?B?d2p0SXR4b0Z3VVB5ZUZ1OGNqNDdRYW8wSGlJTi8wWnNQS05xRVZUeURjWWlS?=
 =?utf-8?B?YWNVNXN6Z3JHUDlGdVFNRjhYZHFyeVdXcjhMYTBUQ3pSMWhwL0hrTytyQmNS?=
 =?utf-8?B?RzBiR2Y3UzNaMTRSYjFZUnBucjVvY1hzbS9IMGM1ZzIyYmZRWklDT3J6WENR?=
 =?utf-8?B?RFQ2cFR1NUpuSVZyNno5czBhNWRqMDVYb1RKbjZIYWc0T2daUHJFdjg5QXlx?=
 =?utf-8?B?UkVaVlBIMHl3VVZ2WmRTQWZQaWoyKzZxLzQwRWpVYlRWS0hhcmoxR1FVZnd6?=
 =?utf-8?B?dlc5NHdPeEFiVWFOUjAzUkdoeDNWZXJNbE8vQW5MK09ISGlCbmd2a0xSVmdq?=
 =?utf-8?B?aTlEcDRxbjRXMmljQ04zUkFqZTUwdHBQTVE3THlSUmJ2cHZMNkszWm5OcGJv?=
 =?utf-8?B?YzYwUlVhT2NkSmhoR1pQVmJnUnJ3RkJTTUFud1QwWUpsUURqc3d0VEdNeElh?=
 =?utf-8?B?cC9ZZmpzRXRTRHVnS2hpWFFxTC9xUlBjK1N5REtqeWt5SzNDNUtvSE84RlhG?=
 =?utf-8?B?ejZTOExSNDFJRVZtUDdZZCtjb3p2aDVsY3h5R2pvbGZaTHRNRkMxblhEZGt3?=
 =?utf-8?B?SEZOZ1NWNTdObTljck4rbUxMdnBNcnhJMVlBTU5vMlpqaGppMXkvdkNMVWUz?=
 =?utf-8?B?TURNUTZrUDNSOUlJSUJWTHdvRStPaUdaYnowU2xwK1hUbTJZUnBPdGF4RHNC?=
 =?utf-8?B?d2UrQ0d1eUt3YWt5NmgycitnWmh3d2VoQ1pzNlFDUTl4eU1HTGNuMTJ3OHY3?=
 =?utf-8?B?NDM0S1hWMXovd3FGdWROa3AyYjU4SlpaQU5GTnRESDJGRXo3a1J0RWxCMTZx?=
 =?utf-8?B?cDhhbnRocUxkbjV4UndLdDBNUkt5cWlxWktrTWtjVkcxS0xEdFBqNXl4RUhl?=
 =?utf-8?B?YWZUTFA4blBQSmpNRTJGeXVFdTdUV25HU0EydllERjdqeE92R0trRE5tUWp6?=
 =?utf-8?B?OVpEN2Q0YVlBRTVEU0d3WUpuYnQvVlJSTnlzbGt2SmJSdGV6YzF0My9jS2dF?=
 =?utf-8?B?ZnQ5QitzU1I4bTVSMTcvQmpJQ01jT09yc0NURHFWSEVtQzR1VG40RXJjTG9S?=
 =?utf-8?B?dDJpMGhsTVJERUZOampJOFEwRFdxNDhNQ01lK3N1WVE2N0RaVHAzNnUyZ0FR?=
 =?utf-8?B?cDRRUlUrdnVUenI0VW5Xd3JEQXN2RlNDaWJjVVN5YVc5UFVLQ0thZ3YzSU16?=
 =?utf-8?B?QUE0eGRIUzNaWUdhZk5HaVdqSytrVUN0VXl3aThscjhwUTJpNWZ1c2s0cytH?=
 =?utf-8?B?dU1OZmZSMnVJckU3OG5ZRDlLdHBnakFkUURVempaZ0xXZTJCdGdyWE5DWkhU?=
 =?utf-8?B?QnpPaWZIMnJlSXIyMjh6cTlRVnhqSG5PNy90dlRMb0pQcW5YcS9MRDhaSkl6?=
 =?utf-8?B?VjJrVktkQVppUXp4S2Q4ZnZJY1RUQkxXVWJ0TWZ3WDlkZWllRVhxZGNtSVpX?=
 =?utf-8?B?VS9jelVmdW9iay9qOHowQ1dOdzc0L3dZeDlXZ0Y3YVIzQVp2VVlyb0tJRWJk?=
 =?utf-8?B?MHZtVVpCcnA1MEFVV3h3SXhESkJyYi9HcjRtK1A2M0dhK0RreVdWWEovSTdC?=
 =?utf-8?B?b1YwODc2eHI1emNRdWJVZE1Nb01pb2VZUU5Ia2VUR1NKcFZaM2c5eEpVa1NX?=
 =?utf-8?B?U0oyZmdFNklyanJGR01qZnpFVURRV1pBT0M3T08xUk8ybk5CU1dRTm01bXk4?=
 =?utf-8?B?bitIbktTeDhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBHRG8rV3haZEp5SVArYk9uSjMxcUJNWE9YditLMVprRzdrNDhBWlJqTytr?=
 =?utf-8?B?VzlQQjJiSUR4bDJrRGVSY0tLdS9FbXdLWjRCWE4xc0phZyticTd3dzBRQWE3?=
 =?utf-8?B?c2dFUVdDQ2hFb1lHZnFGcUVTODBaaXVLTDR6c3hLVlp1ZGRaUmpTYWNTcEt2?=
 =?utf-8?B?WUNpMnl2TGpwNWRONWEwdlBQWEpvdCt5VHV3U01SSGNkdmNJcm1nL2phZGpB?=
 =?utf-8?B?WjlUYjJVaGhWbTQxY0V4Sld1RGlyYmd3cWI0UENwTFV3UTVCWHR5NURlK3Fz?=
 =?utf-8?B?blU5NjVHcjJhT3ZzOFIyS3lKTEQ0eWdiSXFURlRZYUlzYThKdG9QRTlvM2Nz?=
 =?utf-8?B?OXB5aHE0MFRTcmgrVXZXRlE1M3dFc3ZHSXE1N050V0VhU2d2emlmL1RNa2w3?=
 =?utf-8?B?S1BjREFEbWtCVThOOXY3UnNQUksySTRzUnhETW1UaUJrM0ZQWm80bm94RW1x?=
 =?utf-8?B?a3hTQWoyaFhScjZXL3Y0NDRwanlFekRmOUozK0toOEZjQWtzRHp2dXN6M2M5?=
 =?utf-8?B?MnRxQWxjRGVjNWtWQXRpRVcwaXR4YTVYM1VxWDR4S3lhLzNHQnNOY0xFMUpj?=
 =?utf-8?B?YnZJU1grdXBYREJuWVVEa04xNCtxbjMzVzUrNWwyL3kxUFNzYW1DQUM2dlp0?=
 =?utf-8?B?UVVnMnBWYTR6eW10WVordnJXc1hpYW9CNjNRV0UyYVY1b1BoTFk1am5WSWFz?=
 =?utf-8?B?TVdjRHA5MEEzZ05XUHBSdjRiWElLWXB3UXc0WnVzSnNjMm5WQXAwSDFrcEpR?=
 =?utf-8?B?bEFxTjgxQzF1dU9BN2QrK21UUjdJSVZFWTlRWEJqRDNyaGRsdlVnUXVpWWIw?=
 =?utf-8?B?ZzYrTjJuT2xKYXppT1dLWXRONzZBMUZ4TmU0ais5dTVydnFydjJucUFYN2V2?=
 =?utf-8?B?cU5VL3owVnM1ZWRHR0pxcGdvMlpISm9MUURqWXZLVmVXNVg5emhRL0JxUUJy?=
 =?utf-8?B?S1NWV2xKS2xYYTgrZTJFN0hLNlZHcTZoaGVneDF5Z2ZTaDErOXdacmUrWlVP?=
 =?utf-8?B?S1YyUXN4YlFqdFppUm52ZHJPb3ZXWDNJN1B6RzBTcHZuSTB4V2Ywa3VsQ1B5?=
 =?utf-8?B?YnpLYlhubVYyZ3hhV2lJZUk4eStjYW5BUFVKZWtFQWhzSlpoNW9UeGZENit2?=
 =?utf-8?B?V0R5YkZhMkFnTCszT3ZnZEtZbEMzSXBmOVdCMHVEY1JmRFM4SDI1R0h0YXJh?=
 =?utf-8?B?K2NLazU4aVFNNFRnaHUwVFBjQ1ovbGNJekNDQWlnT1RmYUR3bTQ2VTVYelhP?=
 =?utf-8?B?bXhJazRSeUl4Y0JCTzRUSmdGRksybzI5RFZBbFdsUGtCQ1A1bVNWNzgwK2Vl?=
 =?utf-8?B?ZnpjMStydVJESGExUXU0QVBaME5zNStuSEoycllTdjk1SnB3aDFJaEJLNmlH?=
 =?utf-8?B?TW1LKzdtdG80Wi9sbURUcnJKYnF2UytVVmpwT09EdmFnM1BCTS9zRGlCSmxC?=
 =?utf-8?B?dWJFbGFGYVRVWmZMSmhaWitsSWp4aFpWODFiWUxzZGd2YmllRFNzME1TWXV0?=
 =?utf-8?B?NzlxNkY5M0dZZzZRNmE5b1RBR3FjOWE4UGZuUVRDRGgzQnIrbkg1S2E4MVA1?=
 =?utf-8?B?YnIwaDQwUzRUQzhPT0cyRmpxYmpaVmJmK1IxTURSekN0Lyt1cUIyNmduNWlG?=
 =?utf-8?B?anVVSkhGMG9INTNZazhlNzB6K2FvV0hvM2tmb01mRVFyWVZFZmMxWmJEVVlX?=
 =?utf-8?B?ZW1WeFRPK3lSbmg4VUo5d3JpYUdqNEZsOHhIY3EzMUV1V3JoZlkzbjkycTFy?=
 =?utf-8?B?N2g1eWNzOWFuZ1NUcVFLaDE5a0V6RmtHSXdwckNORnJsY1ZocHRXSFk5NUVt?=
 =?utf-8?B?MFdYekFWTzdralJXR2xod2N6VUlzY1VPak5ZbEZrV1NZMXlFWHU5Mmg4eC9Z?=
 =?utf-8?B?b0hUcDJjQWRQS053bWVCV1cxU3JpUHNXcXF5ejlGaHR0WSt5QVFUTXNwblJh?=
 =?utf-8?B?cHJIV0ROdlViSUxLcDYxdWk3dzZHWWNVNDhKY29vZ0NFc25mV2pjTHN6aXl2?=
 =?utf-8?B?emZjUTVnK3lPY3NxVTlRL0EzcjVqYlF6enZTOTFSa1NJWU05dnByWHlteFg0?=
 =?utf-8?B?UTY0R3NsaW45TzFXUDZMN3hFTlFlMlpPRTMyL1ByckN3RktaZmZ1N0M4TUdi?=
 =?utf-8?B?TEFBTWt0R0JVYzhJSkJYYzlOMmZCcXRhL0NiNjFxNXVVazN2M2hRU2tjdkhT?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80716986-8222-4f36-fea7-08de1808d9bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 23:05:42.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HNTlT2y9iI8hHUZN18PZL3PyzZUPoYeZIUtmaBShW9dLu2TzVNxqkXyNMA9CCSP+qvzH9k6/VQrGGGpm402Rm+F4qoTNuvS0BYR1o6+Bww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> On Tue, Sep 30, 2025 at 9:55=E2=80=AFPM Chao Gao <chao.gao@intel.com> wro=
te:
> >
> > TDX Module updates require userspace to select the appropriate module
> > to load. Expose necessary information to facilitate this decision. Two
> > values are needed:
> >
> > - P-SEAMLDR version: for compatibility checks between TDX Module and
> >                      P-SEAMLDR
> > - num_remaining_updates: indicates how many updates can be performed
> >
> > Expose them as tdx-host device attributes.
> >
> > Note that P-SEAMLDR sysfs nodes are hidden when INTEL_TDX_MODULE_UPDATE
> > isn't enabled or when P-SEAMLDR isn't loaded by BIOS, both of which
> > cause seamldr_get_info() to return NULL.
> >
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > ---
> >  .../ABI/testing/sysfs-devices-faux-tdx-host   | 25 ++++++++
> >  drivers/virt/coco/tdx-host/tdx-host.c         | 63 ++++++++++++++++++-
> >  2 files changed, 87 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Do=
cumentation/ABI/testing/sysfs-devices-faux-tdx-host
>=20
> Trying to apply this patch locally fails because
> sysfs-devices-faux-tdx-host does not exist. There are also conflicts
> around drivers/virt/coco/tdx-host/tdx-host.c.
>=20
> I'm looking at the base commit specified in the cover letter [1] but
> even the current head of the tsm/tdx tree [2] doesn't have the
> sysfs-devices-faux-tdx-host file. Are there any other dependencies for
> this series?

I hit the same head scratcher, but then realized that Chao did say that
you also need to apply:

https://lore.kernel.org/linux-coco/20251001022309.277238-1-chao.gao@intel.c=
om

...so:

git checkout -b $branch 9332e088937f
b4 shazam 20251001022309.277238-1-chao.gao@intel.com
b4 shazam 20251001025442.427697-1-chao.gao@intel.com

...works for me.=

