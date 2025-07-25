Return-Path: <linux-kernel+bounces-746355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9554CB125B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A9F189AB04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6325A63D;
	Fri, 25 Jul 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHy9bXlw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588325B1C5;
	Fri, 25 Jul 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475722; cv=fail; b=Dg1v7RPsgiY5jJTgnZQysteWVofRHQd+yWWC13/OFQkVaGxMfvhOhj/QMGbikv9am6OXTqBd/iFd+RSsjKy/+vUp1ewIz+4UAGi8npKWT8h8eYiFjiTosfyxw1a+NJOXk12OmKAMRoxjEAojCKM7RstR7/lKK5g8Zz0pB0sqrdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475722; c=relaxed/simple;
	bh=bwsYl1Yd4mnIV/bay4uDI53mpR5SNBH2a9VDhuq9lFY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=I5o62wkWjumspaf1mMIcsdgPzAdvcHDM9dw6tliUeX0iEdEgMYgncrL+xIib2/LK+/v3Sg7PuXCJm/TEE5TeTM6xf7QayjKn1DHEYb5eJWmKcRvGwXYOg/WsCT7wURbqaXyHP92v6Cettp0MNiFkvzy3hfqjKN1lliMHl7vmvVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHy9bXlw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753475721; x=1785011721;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=bwsYl1Yd4mnIV/bay4uDI53mpR5SNBH2a9VDhuq9lFY=;
  b=PHy9bXlwmCMRq6jqC7Va753/S7xKDnblAtWroA3fpVYPWMK2aiu9odgC
   INQPqe2NRz7AawJ/wntGbkFwklrK4Iqx10nGKbRKtj+sXnBd4CsicUsfX
   OZH4Qa1Jn8aomPmiLVNDJ0aMqpqSM+NvT9trQgMlOyLxBp9vSvDCHpsh0
   E6/Ftb614JFdyk/fm0YCKcHLYUDuK8tggIY+h7fgWPNqMHWZnZdlDItbA
   crHX3aSJZeq1PFk4e0TQa7b4K2Ckg3nHiOTSnReiVrD/OVfPJOb384ueR
   7LkpbNKG5b0EWxPKdr114+AEnAXKHzb+BnH5mqaoTcEfVjidStjUwNVYv
   Q==;
X-CSE-ConnectionGUID: Xi2dZshkSn6wIyGywaMi6g==
X-CSE-MsgGUID: OSx5IwXxTFOCM+IsBPNHMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="43431014"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="43431014"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 13:35:20 -0700
X-CSE-ConnectionGUID: o/+ZAYcVTgWORWAN2nNFiQ==
X-CSE-MsgGUID: lOYB+lSyTde/zWltcCHQSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161441854"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 13:35:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 13:35:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 13:35:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 13:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pt+bsyCKhp7m8BUH4fVjwHpKiWIp6YkAkdeVUU9vBtsdUZFCPRRlpHcA+ttRKyya132qyL9LraWnvouNrcTeRArhGtmpamChq9lBnnkWUqqX1HiXWWYMrqKB3kfg8vlAtHVUMydWy5FYK4FAZq8Xec83lUlq7EB6iIAkMYNPZTjjI3DTDnKGeJz9/Z7YFsR+ytLM9ZZEZ5FH7pDOr6Gs8vq23kCiDX7GfeZWzWSg4MksPPBWL7Xh37uOr0GEA4xoPwsj6kjsYfi8NUtFzI7vr63ACG3ty37S8NEzISIKP1W1EfYZ/yQP+XmCIlidMdoOvybo3XRWykhPcEOU9CMwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+2mEWbQGztZKM1W48JwijVLxh3KKrNj773O+g6E4RY=;
 b=odFZsLn9acgAbDMgnIGF3MhieoGs0ifA2CkpQAQg8vWUlrqLG2VfYLZh8X0LEm4KELaLatftHvPu4eE7KtQz0oS3Pd/YfF+bc3quzYUrRr+s2k1wiRD23XiIPn5mKvRlUX6cuISoRF0u72ERHxeH6rmhBGBZsGWuN6UPzBSRaepFOWyHSY7RGZwPK6TMgH69bNVAQRlP733s8gR5f9bEzHY/KHpevw1O7aepj3evroLvB7N++M9I/O64dSo14zrHvla3f2zORae6gM+KSgFfaPAYleuLz5RVAlMNb1xj0DKywWqwGh79Nt7qlK53QBFy/QtM+cHLvEnkt3HhQBnGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 20:34:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 20:34:35 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 13:34:32 -0700
To: Jakub Kicinski <kuba@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Sasha Levin <sashal@kernel.org>, <workflows@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kees@kernel.org>, <konstantin@linuxfoundation.org>, <corbet@lwn.net>,
	<josh@joshtriplett.org>
Message-ID: <6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250725125906.1db40a7f@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725114114.3b13e7b1@kernel.org>
 <20250725150046.3adb556c@gandalf.local.home>
 <20250725125906.1db40a7f@kernel.org>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9c6f95-06d9-462d-730e-08ddcbbaab09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXBtR0p2NHh2MURZd3BXNjl5SjRhZUM3YlFSTS92R1h4akMvQ0pCNGxwOWFZ?=
 =?utf-8?B?Q1lqOU4vTElLNXh5amxsL21EVGVIdDJtdFQ3L0dKUlNvd28zbjJqcUtwSURm?=
 =?utf-8?B?Sng3d0t6UWtQU3pZek9yVHgxQWcyL2puUkVvUjZ0dVFTeFU3M1EzNEdMZTkr?=
 =?utf-8?B?Z245YU9Sek9zZE1GWmcwYXVNM0xoRk1iL2ZtY21iUmVDYXBZS21xbFl5TjF0?=
 =?utf-8?B?RDdJVm9WN3NqZXFQNzNKWEFFMWlCb0d0S2RuOUNjU01JV3ovY3BkeUhJRHJ5?=
 =?utf-8?B?eG5GckFzOTFlclNmSjN2N3B1S3ZmMHM4NnZJdUJsWm43SWR3dkx6RW8yOEp0?=
 =?utf-8?B?RGh5YkprcHZWUzhaVFoyY0FzK0hIdDR0c002ZUtFRjZRMkRoMmZ0Z2dEN2xj?=
 =?utf-8?B?b2Q1ZWczU3JRRng5KzVEcXJGNHk4YzlSd214dkdvdTJiUE55ck1MaC9Ubm0x?=
 =?utf-8?B?MU5McXR5cjZhTkZ2RTlVd25HR0FvU1hIY1FxV1l4NHRaRFNNcFlqVEQvT1h1?=
 =?utf-8?B?VmdCZDdzdFYzQXRtaFhQbmtWV2NzUlJrdlRNWG9YOTlDUllGSVNwR1FEQXRH?=
 =?utf-8?B?a2dZeXhXeE5JS0NGMmZzcEMxcEk4VFlXL0FrcmI5WjF0WE1jMVFxaHVMZm1j?=
 =?utf-8?B?Qk4zN1JQcHUyMWl0Zyt4MnI3ckpjL3RaVWd0bktBa0V5WEV3V3lEZ2xpK3hJ?=
 =?utf-8?B?bDBKZUQyalZ6NW9FSFNzdjQxd0k0NnlETXEzaVg5MnRiOWtCaktCUUdKOVJI?=
 =?utf-8?B?TUtKVERQdmhpeXNUZGxhYjhKRENlMXBlcVh1anRLMG9JUTJTclFxTk44UENO?=
 =?utf-8?B?dzdGUVpyU3RYcVcvM0dXdmZ4R3BrbGxRbzZZeFFJamJnK1hzYVlWdXU2eTZ4?=
 =?utf-8?B?YWtyRHVBb1Y4VWtPV1pGRmhNOU9OcjNoNThQRnJ0R1N2R2JCUnREMlhhUkJV?=
 =?utf-8?B?YjFXZ2hkcnBmNGRmTmswaFp4Zy9JVU9wK1RsdURYWTZzMXZzY1JTNGlnMDho?=
 =?utf-8?B?a1JqQnVnNVhDZ0VUakYwSHpzRTJkSGl1ZHFLUUZobW42cVBqWmlOUHZSaTVz?=
 =?utf-8?B?TnBDdXdlSG51N1pwOTZOenNENVNlOU4wNnVVMWgxd0czMVdKNVZsWEtoSVpN?=
 =?utf-8?B?bVpVQVd6K1U0TFJIbjc3SllSMWhVemwrVFMvWmx1N1A2QkJoc2ZQSHk4MUdH?=
 =?utf-8?B?NW0wMHJvbGkxK0N0bU44UmJZVEd6RmdrNHZUVmpnMzMvWSs2MFpleUc3azR6?=
 =?utf-8?B?Z1lKNmpCYURVbEQrc0hlZXRVYTJXbXR5Q3V4VVFaUm9iNk1ndis1dS9qVVFG?=
 =?utf-8?B?a2ErSUkxK2FxVEtkWFFBQnlxdmRwWmFFMnZRTkFhQyt1dHBEZ2x2Mk55SmNE?=
 =?utf-8?B?RWRtTGEyTE9Hdnl1S3lVenYweStVTld6Nll6RUc4QUQ5OHZrV3V3M2JsaG5V?=
 =?utf-8?B?QlpORFZIWUZRR1FmU3Fib0xVNitON05WTkRGMGtRN3J6SHJoV1B1MjFXUHQ1?=
 =?utf-8?B?TUxjQVZ6VmJjRzZGaEQwWHZKblJoSEw0MmRHZ0RKaEdZek1IaXpQQXYxZyt2?=
 =?utf-8?B?OEJ0NjJVMDZZaTRJUDJzMjUwbkx0SkFrNmRPREM5OFViMCt6RFFpM1lIMTRi?=
 =?utf-8?B?a051S3FsWTNJcEtUSVhKM2t6eGREWVNmK1c0dFF1TFFwTHFwZ3BzcjNFVFNN?=
 =?utf-8?B?NGpEY1RxK2x0RThMSGRCT1RxOEVzRmo4SjF1SXQ4d09vMytMZVFSRFhOSzhJ?=
 =?utf-8?B?ejNQZGdPTXExREFwRE9wbk14MVN0QU1vOHJjbmpPS0JmNWc1akRUNzZMTXJq?=
 =?utf-8?Q?9fmIhZSphDcOPjgrn7eqYGw2fqE8Gwv3tfxqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXlNd2lrWUdKMzZuRVArcHB0RzVWT1lCRkRROVk5S2RpMDVVQXlZNzFIMGQv?=
 =?utf-8?B?eFNTL1pMR0p1ekxEVkNYVXVibVhWVDF2a0R2WHRDRWtvdmlZbzBXcnZ5NFJP?=
 =?utf-8?B?NmN1aVZnQ1dGYlZLV3JndTQ2dGE1cmFUbWVTcXdQd3hGcm4zckt3YVRicFg4?=
 =?utf-8?B?YkN4dU53Q1VFdHBNRWVSWEJSQUFwbVBMTkpJUkNvajlhbWhLeUxtbGI3R01S?=
 =?utf-8?B?M2ZUcDhzcnV3WW9ndmxoL3J0aFFVOTVIc29seVJMNDNJRVhaUU5Md0pHR3dn?=
 =?utf-8?B?dCtpU3cxM1ZLakdJTmw2T1VFZlc1K1NPRGFyYmFTYWlSZDFuOEpuSVlldWM0?=
 =?utf-8?B?dmdlQ1lUcVZWRmRiQ2V2dEZCK0QyOVR2bjZSZEJJakEwZis1TjBkRTZLeHNR?=
 =?utf-8?B?MGVNUVRWVmVxUnVvWHJUWThwbDdMYjAzc3RoTHpQRXo4T1k5Tm1vRkhDYzd1?=
 =?utf-8?B?dTRUN1E1dzhBVDNUZ3NiNmNDSDc5Kzc1Ynp5L2Q0ZFQyMjYwbWFmZDd6K25G?=
 =?utf-8?B?bEg3OC81bE8rM1pZbmM5S2lYSUlXc1ZoK09pWXpLa0IrSSt6QmFRSlQrNjFN?=
 =?utf-8?B?dENrdmNkTW1vdXJVZzh4WHRMTXhCTlIrek01dU53ZUVma3NYbTVCdmFqRVFL?=
 =?utf-8?B?Q081bjZla0s4Y2gvb1ZNOHVWalBtNGRLRDI5QzJZNDRwMTRva0xpOEhEUmRF?=
 =?utf-8?B?UG9VTlNuVzBCUlB3ai8zTUVsOFc3RjdFcWZ1OFh1SzhMS2VaTWZ6Qmk4eldl?=
 =?utf-8?B?VGpsL2xNMk9FRnBKUzY1anBCQ0lQUHpGOFJTQis5K1Q5VmZmNDVrbEN4SkND?=
 =?utf-8?B?cmpIbE4xRjR5Z1NjaHg2bndXS3JIVCt3UzVDVFc1bGx0eHdEcjhBcGpjQ1gx?=
 =?utf-8?B?L09vdWJMc3BFWHpnUDFiNjZjQXFWdE55bzZVbXNaYlgwcmsyencvb2wyb2Jl?=
 =?utf-8?B?MHNvUFlMVnZ2VEJWSEFuY1Y2Szd4K252ZHB2bk5XdG13b2FFNXZHZHFnbmU3?=
 =?utf-8?B?SDh2S2FDK2hUaVVjUThQcGQ3ejIyMEZHRkYwQTYwTHhIbWtldzFNY0ZiR0ZN?=
 =?utf-8?B?eTBvV29qTmVzWHNXMVZDeVBYY1BmbkJNY2E5SmdncDRXSHhXMUlNajRBRWZY?=
 =?utf-8?B?Q2RBQnhxaUhxeWRIeDhYR0RmNmRsMmpMaExGNGFkN1NUZUM4MERRU09kc0w3?=
 =?utf-8?B?akEybkRveURoLzhkNGtQYUVlQ2ZlUFBmcVltQ211V1JiQkhleHpVMHp3Ujl1?=
 =?utf-8?B?bk5zQkJhRi9WWVM4MnVKNHUvVDdiYjMxdU5uMVlNdmVUaFVRMW12VXByd0VT?=
 =?utf-8?B?cnh3eklrV2NUV2NXOGZubUQxV1JGTGNlZ3luTnh6NThKdzVBcjdxUDJGRzEx?=
 =?utf-8?B?Um0xWlNyaGxwdzVHZTJ6NTk1WTFaQlovTUVQVTZCcUVUOVZXTnp2aEdwUnAz?=
 =?utf-8?B?OFJad0QzMm5HZFpUWkh6SkdYSjVXOGt5YnVkVUNoT2NKWGdNRmtjT3dtTVlx?=
 =?utf-8?B?TmNEdUYweXNhRWxaZ01KeFZ0THZFTWhFZVJ3R0hhZUk2cGZDQ1I4SDJ3ak5a?=
 =?utf-8?B?djJVcHBUelhZYm50YnFHSVBJbS9EYTdQUm8vR2VZUFphVTRpSjFweGFHeVNH?=
 =?utf-8?B?U1pTM2JkMHg1b3VBcVFRMkxHbDZDcEtYb29jNFVMSUlxejAxbjNUdFpUODFr?=
 =?utf-8?B?L05uZ2x1SkJHWWZPWGN1Y0RwR0h1UER2QTc4S0RBYlZXL0htdG4wMDFBYTlo?=
 =?utf-8?B?cFZLczRsSEZ4UnhUSEdhd29Tb2ZTZjM0bmt0eFFoMUxEYW0xeXlvS2ttOWc1?=
 =?utf-8?B?OGdna1NxZ21NenBEZ1liQUdsT3N3OHoydFFWTVhuS21aWEtKTnA3bWFKZXdL?=
 =?utf-8?B?WmJPM2MrcDhOWU1CRmRXcVFZOTlLNlBweEl4VGRDQVBOYVU1TDZWL3E3QzhW?=
 =?utf-8?B?M2xPdmxSbzFmVVRkZDlGMDFJaFBXOTI5Z0NHcU9RUlo0NE1HVGlQZkQ5eXYz?=
 =?utf-8?B?OXUxY0cwSVpHblcxU1o2b0N6djZ3VVdsSW5BbG9oVWZ2bVc3V3VEeHBpRDlp?=
 =?utf-8?B?K0I0ckg3c0w5UEUvdjFESHBHZk1RaGlESUxzbnZ2TG54RzEzQzdQeHViUkQ2?=
 =?utf-8?B?aFpnTnNPbjRXWnpwck1MR2Z4b3J3NWNQeS8yVjR5WkdlSEZKekxUV0d4U3FK?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9c6f95-06d9-462d-730e-08ddcbbaab09
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 20:34:35.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP6y/H+Be9qFuXGkeUyQ71J8sem1IXxg1mMllpgA87WVJ6qGbvYZFoVWNgtawl9XmWRUCeEKfibQrHxgBRKaT6VN1tucF/VFRmFUCqB/y9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
X-OriginatorOrg: intel.com

Jakub Kicinski wrote:
[..]
> To be clear, it's not my main point, my main point is that 
> the information is of no proven use right now. As long as
> committer follows the BKP of adding Link: https://patch.msgid.link/...
> we can find the metadata later.
> 
> We never found the need to attach the exact version of smatch / sparse
> / cocci that found the bug or "wrote" a patch. Let us not overreact to
> the AI tools.
> 
> > Also, I would argue that it would be useful in the change log as if there's
> > a bug in the generated code, you know who or *what* to blame. Especially if
> > there is a pattern to be found.
> 
> This touches on explainability of AI. Perhaps the metadata would be
> interesting for XAI research... not sure that's enough to be lugging
> those tags in git history.

Agree. The "who to blame" is "Author:". They signed DCO they are
responsible for debugging what went wrong in any stage of the
development of a patch per usual. We have a long history of debugging
tool problems without tracking tool versions in git history.

