Return-Path: <linux-kernel+bounces-891186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD2C421AD
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE21A4E2C74
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239682AEF5;
	Sat,  8 Nov 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnAY+XM3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6620B22
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560691; cv=fail; b=ZiRrPcug+Lxtu22R6sYyZ0jkHsZl2DC6C8bs9dqUAhbHpxWI19p0SRiHdhYwBi73YdbFMJrlfrvastbQP6ro5DAl/2XmPmwPxqBkg9ETeK2M2rP4lrv+F39Djj6idpmRlmTq/e/nANsUwCJkdtxouo3axRUmPhs318Qj+ram7O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560691; c=relaxed/simple;
	bh=HD0IP8oZMSf3MikZWoJqOOFJix6yFukK5hxxii4ns6E=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nkRdVorWwqhqVgxpgyKk6hgL/+jI9hnQvupdsIXOPXivGDCTb4aCBxl+cMyOuYLqFiELNm72ZPXkpuiH661Ih7UaN1eCrYUlrRMpf+VD8PLH0zer+L2MuwdTiaoQzBgRP/C7GNt1NKzEdWhkazntF5jXLBJnwPB/sHpicvbOxDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnAY+XM3; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762560689; x=1794096689;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=HD0IP8oZMSf3MikZWoJqOOFJix6yFukK5hxxii4ns6E=;
  b=JnAY+XM3WfW7C8RjWe4x4s3tEDBAogBUejZQf4zCBIS4zJI1ElnhZyYR
   exYCgYzb72WYJHHjqZommyMLTF19LjAGW0fkyWdrqpHR0Kf7Zf8/sT2ZR
   QkBMMGnvmwX/CPtLr5MoiYs4AoITw39CE92IChqUPyLs5Hy/JD+a8TYLz
   oFaIod7UhN/0RUx2pcEo9+Rn/hZB4LWXGv9mCkV/Kcqx2E7dqN1NGd/rx
   FE+qY7xCcg76LrzUWIoZAtExjDM20KrSooduIKJL/NTm6Gk5hH/PiP/lL
   O/MCkQ+CgqjAoEhXghdlr8RobtfG11MuJ0Y9zAH6ITwB8Or5gSAMls7OK
   w==;
X-CSE-ConnectionGUID: 34uaQG6GQwGdS6G7Wl6BTQ==
X-CSE-MsgGUID: cOnf6PpRRl2se23fV0piVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90183571"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="90183571"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 16:11:28 -0800
X-CSE-ConnectionGUID: 9bj8xORwSq6Y/2CqifZYVA==
X-CSE-MsgGUID: s9WTYUl9Sx26sdCD+x7MXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="187999667"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 16:11:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 16:11:27 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 16:11:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 16:11:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGyxzFsxRDqfdWa3pxVl+Ych+KkgBnfEZpz69IoAytsbz6dpWyzKI68MPZ2/0fCr78jWgcL0yNbr8aohu9YbtSJ+Nl8QdTG8aElqRlXC1wVFwi2OUguw8ULLT1T/pinRYvgTzu+m18b4tmII9BEFroMXCwqpMOUeFqoZMyw9Gs71gpml4ErN/y89jzcaiEP2JmiM95766SxPIQnZIo8LcVEClQyk4eBS6ag0MGmiDgGrGY2sJ8zKA6JCS+EDMdMkdntvYfILMopLjZDgeWFz7vclmonQBbaGiR13+A9gvt+IIuwY71n23Ww3WIUFbULdLrhjSTKzi5EQaHGj+0/5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UNv+5MnQMpmPYHJSvZTWn0EAB8CDeglEOQjtBRDNWc=;
 b=ulHA8FJ87Z6ryRmmVfgyqPGTQuoDwWiKa7QyBfEmUqGDSJNnzQhNJT39Ew9Uv+MvceZKgsG4dAw/o9hGiUn0ZOGxOY55c0ccTPKUV3lS2Pi3MhseBlqurFUkuHlaG3FHiFdvMq+6etOm22nFxETtgqgYswNy1JTFpmZEvM4Xzm4BL/gE+RPKrf3P0Ss8WrvmPe8Lts1FsIWyt/7a5xQzDIaLkISQ9jW2/OU3SVRy8xlQCRnsyeOAKVUmKJ8p9J5OcHX7jBkCSfz4mp6JiBjfAPqXn+ZNmnisPc1IqXczZ4PuiDZDnMPqjcqYqvsK0/av8oDtzTgUUyPpenZPQszRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 00:11:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.007; Sat, 8 Nov 2025
 00:11:24 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 7 Nov 2025 16:11:22 -0800
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Steven Rostedt
	<rostedt@goodmis.org>, Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o
	<tytso@mit.edu>, Sasha Levin <sashal@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Shuah Khan
	<shuah@kernel.org>
Message-ID: <690e8aaae5f47_74f591005b@dwillia2-mobl4.notmuch>
In-Reply-To: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated
 content
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: cec136df-ef03-461a-0571-08de1e5b5a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3hjQ0ovejN5c3g1RUdzSTIrVGpJMlpuRHB0UEZXUzF4UFQ2b2I5a015T0xL?=
 =?utf-8?B?V3RUMGhrNzJNNTROeW8xL3Q5YS83N3NQZzdUNUxSSmNVcVB3dXhQOUhjQjBu?=
 =?utf-8?B?WVBndUVNQ21zRVNuQjc5SWNqYkY3Z2tnMFRDRHJSM2pVRmFxb1I3UmpnVGU3?=
 =?utf-8?B?ZWZFTnlGKzRwQ3VzMk03T05nRGFXZXBuaUwxS2JaRVZBMVBGNkNpWmJJN1Zr?=
 =?utf-8?B?alhZeEIzVGowbEVaQTAzZklMNStUY0srRHJGN3pyLzFkalovaW5hWTRYUGZa?=
 =?utf-8?B?T2VYaGswMTNEa1Y3NFM3MDA0SFFmR1dBbzBURVRsdlVUWCtwTlVFYXhNYWV5?=
 =?utf-8?B?Kzk0cUljQ3Rqc1ppN0ZhZURrTEJoRFMrV1IvQVBRcnNJdWtYSmJQZFdSekFW?=
 =?utf-8?B?VnArWDZBcUF2MFpIeXNmbjdGczRjTUErSUEyMTlKaXd6WlprTzRLaENIcUg5?=
 =?utf-8?B?NmgwMGdseWZqVll1ZHFxQlVSSkJ4eGZxM2ZsL3dMNUdLTXNEbC9QSGJzUE0y?=
 =?utf-8?B?YUVidjRjSGFWbHFCVnJoaldqaWRnd2hWbGpJMW91NjF5Mk9IMmh1QlpadHM3?=
 =?utf-8?B?cUtQWldmL0R3MmwyY2JhLzh1NUlFV1JtQWU0RTR4NHltOGFiN0R1TCtUQVZq?=
 =?utf-8?B?c21mZVpQVmo4cDJSQS9RQzB3Ukt1WjFxNWE3ZTVhREUxTEUrTC9QWXFicUx4?=
 =?utf-8?B?ajY3bEVFY0lGeHM0WG1uRncvQ2NrRkZZM01TNkRYRWlRbGV0QlBCUkcreWlC?=
 =?utf-8?B?ZDl1djdyZ0R3ZEM2L2RJV2xheHhUUXlmT2xNTm16MlVUOUx6Q1plTThTQjI2?=
 =?utf-8?B?b1VQb3lpMzZINHp2ZGtzK25jQUlaVmpkVlB5Z2xhbCtUUWk2aHZTQnhNbDZu?=
 =?utf-8?B?d21scDE5dzhwZExwbll1dHRnL2s4T2Y5amRlZnUyM2dWaCs1NGRMS3pjK0gv?=
 =?utf-8?B?cGliQWl4Zjdub1FqWkNJRENSbTY1bmFnR2NEeXdmVnRNU2FIU2RBVGxYUVRC?=
 =?utf-8?B?dlRkZXlma3ZyR09wYVpQQmYreTBmYWNucktFdGtPRXh6clV5c3I4UFEvbmF3?=
 =?utf-8?B?YTFiNHlTb2gvN3MvQnVXRDEzclJpSnpnMnVsSCtIQ0RpSTdNRGU4VStMSWQ1?=
 =?utf-8?B?V1JTRDMyNnA2Ui9EYStWRGUzNWFrSUVZcnNRS2JSbHV6REZCc0ZhTGorVVdL?=
 =?utf-8?B?ZUJpRnFEY1NNZUx0c1ROK3kxWEdtMVErRXUyWnRiNWFYNlJHSDBVTjVOUkZ5?=
 =?utf-8?B?dm5YclVDcUlNVy9rTmdLeG1SMDFFMkk1QWN6Zmw5RDhCNmFrM3FnemdQZ2wy?=
 =?utf-8?B?Z2dlLzhZS0VUbmFWMld5YTRtNFRiaFhzUC9EMTlKNDFxNDhqNXlxK2RsMjZG?=
 =?utf-8?B?UDFyOVJYKzRzOExtMHladXhPRXZ2Ymxxa3ZwSjFjWnhESzZvaUEyODgyWGJt?=
 =?utf-8?B?aVlOeWdXalk2bjc2VjVvWmluRkNLZ0NBWHdMak1HYzJVU2hLb0hxS1JoU1Vq?=
 =?utf-8?B?eXpQK3VGUStDTExKUVpIa2FTZytrT1hjSW1PakpwTERrTWczUDRhY3NMSlRp?=
 =?utf-8?B?WjNZZlZ2Q1JWSDZHbHZGUWhBL25kck00R29jemlFclZsUGFKK3cwV282TUpU?=
 =?utf-8?B?RlhCLzRTbmpUaUtlNm1JcThoSHRicW8yMFdCelYyMllXR1BZN3dnL0ZkRUov?=
 =?utf-8?B?M0Z0N0FFYVhJblRJQis4WmF4RnNWODkrYmRsV1lYY1ovQzVDMjRiNzR0SDdZ?=
 =?utf-8?B?aUZaWURjN2NEU3pNa2FsakxMWmJJU0Z5eVg0NU85SXplQjBIdzl6bStVSXE3?=
 =?utf-8?B?VHJnTmZGUzZZcXpFRXg3dUVqaWZJaWUrTE80MC9WR3I5ZkI3c096bzVXQkEx?=
 =?utf-8?B?bmx4ZFhJN2R5NCtWbnZ4N0x3UUFvdjRKb1RtaDVFRUVOLzc0Ky9lb0JmMHcy?=
 =?utf-8?Q?4BugU7WC2bzv3e3kpK7vxZmsc86W25Q0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk5rUk9LYnZJNWtaSVRQajZ1YXFteURPM0h1RENrNFk4dFoxNXdheENqSm5t?=
 =?utf-8?B?b2Rva3UwYkhOYUx3OWRDdFpEamwvQnJuZTRHbk44MDFtVXFxUXA0OTluSTB4?=
 =?utf-8?B?QnhHNmRhVm1kdlNDdUEvREhZT0NxdkpINkUwNnVVR203cUIxNnlMc1JnNG5M?=
 =?utf-8?B?dDArV1NhU0s5cmNwSGx2NVY2cXNobEwzVEkvQkNpNTZnYzN1TnNMcDQ0Wno1?=
 =?utf-8?B?cmRCVW0yOHljMXVwa3JoeWk1S1NDYm5GU2ZUdU5PVm5td0VGc3dhcWlUWDE4?=
 =?utf-8?B?bHJuSzVlV1hBUkFRdFk5ODVxRzVTWko3bjBNSTg2cWE2UTZUT2d5THF3bmpO?=
 =?utf-8?B?M2g0RE1aSm10b2dNNUhpeW9DakhMOVR4N2F1Y1hYNUZhOEFUdXhuQjA0eVR0?=
 =?utf-8?B?RDd5eG4yYTk1WVpGL0cyejl3cTI4VitIaXJvcXBxRnpHYTFQdjhpVmpxZyto?=
 =?utf-8?B?V1phSEV4QjM0NzMzeUJMb1hGUXQrYSsyZ3ExazA3dVFWeXVrT1p3MTlGNmRK?=
 =?utf-8?B?SGFIZ1ZwMHZiQTdGNmZQRmhoNTV1U0h4Z3FPNEFqTjVzdkp4QmE3VVB3NVds?=
 =?utf-8?B?UHA3U3RuYjhVZlk2TFdROHFLU3YzMXFYck9Ea0RxbEhkRk9odjJtTWJubXht?=
 =?utf-8?B?TWpsNGFRSUJwSnBXbVFJcG5wVVZhTW5KZ2FMQXRqWmpxOHZqSU9hcHhaV0pB?=
 =?utf-8?B?UldkNEJ4ZXg1c1pvcU5aV2x0S2JWQTZrc3BZUE1lVGZucjUvaXNFdnk3UEZJ?=
 =?utf-8?B?UGZiSmhnYlFKMVJidXBZcjd6MWRwaGtYdUhXOEFrQ0p0NXMwTWdSd2FXL3h4?=
 =?utf-8?B?a1RpQWQ2UWdVMXNzcTA0TEFidUFxZlZNZTVxVXA0WGh4Y3gwSE1qbk4vRmxh?=
 =?utf-8?B?RzQ0Mm4xbUVIYU1WVFZnRDZoV0RpdDVjMlY5Z1ZYU0NmYnFZZTY5SzdpMnYy?=
 =?utf-8?B?Z2JXSFVub1FiTFJRanlMRUFTNFlMS1FKbG11ck9VdUtsTkliUTI4a05nZit6?=
 =?utf-8?B?RVFBOVk0aGhMSnRHYnlCQWNoS0thc2c2NFhNNGI5VjRlaDNBei94L0dRbi9q?=
 =?utf-8?B?di9TK1YyTUlYK2V5THhxNHRKYm5ZTGlGME9hWVN3ZTRLZUpwcXlBUjVzOWpM?=
 =?utf-8?B?S3JRVGpxdjBTeWhvRlprV0paaExSdkNIZEtyMDkyeEVXL1krTzIyaDVIUVFH?=
 =?utf-8?B?NWJIcjZkeFgvaElHbjlmYUJGSFJxbnltR2ZQemRxalFWUDJYSnJDam9rUW8v?=
 =?utf-8?B?S2hjOXIvYlYwWUp0SHBJeGVueEN5NHFEeWxlQUVSVGF6cnRoMkQ1RDJDdG1H?=
 =?utf-8?B?TTZPR296VGhxSzQrNmtnM25TeFBnbVppelVWSGlPZGZrdGNkN2c3Z0dCU2Fh?=
 =?utf-8?B?bVdwb3hwWldJVXlxY2Q1SUlmeFBid0xSK0J1a3p6N254OTd2aXdJT2plVlFU?=
 =?utf-8?B?OElSR0Z2VVUwc2ZhdlJ6bkQ1RzdBRWhXem1zVzdWM2t4bXpaaUc0Rko2V0xo?=
 =?utf-8?B?MFFhaFpyS3hXaGtDcnRtVENEL0tBaXp2TnNNN3ZIdkNVY2U3YmFUSjY1RVpE?=
 =?utf-8?B?ZTlyN1RCaXNxNmgydVBlZ01YQlpML2lqaGxYZFg3bDFMQ0MweThKc3lMVEY4?=
 =?utf-8?B?aXphTndoSk13WjhKcWJlVTFObXcxRkpUL2VGZlpqMVZWMVpYSEhEWDM5WWsr?=
 =?utf-8?B?YkVWejZKUmxjTHhwR0JyaUJweXJiT2hFV1Zpc3ZvQ3lzUjdIbWpnb3FlaUhu?=
 =?utf-8?B?TS9GckhIZVVOQ3VHSk1Ebmd5VjNGMjRzVjFMUGYwanFVTEdrc0pZNzJCMGIv?=
 =?utf-8?B?T0pVbmJwc1VscVVkdUw2bmlHbFN1bXRSWGMzeG9hUmtLbU5CYmYrV3dQVERo?=
 =?utf-8?B?ZU9Nb0hsZ1VDMDJYa25kbmhlR2FoT0RQWkxJMXBlTXBOTFB4UnptLytLQk9z?=
 =?utf-8?B?U0dpcFVuakdEdkROSktXS2hxV0Vodnh2Y3VraW9YeExTcSs1bzVPVk5DbnI5?=
 =?utf-8?B?SEdmTWh0WVhyY0ZyVTFpSHJlZGNBdEhWck1DTVk0dXBPZEJyNkZQcVdxWWhs?=
 =?utf-8?B?Z2pQa3JEZ0g0ZXBGWjRZZ1lxYXliTEpQYW50alhBTll3bzJXa0RvMXFJL2JK?=
 =?utf-8?B?VmF5dGtxN2ZmZmpvUjJ2YW1pOVRCamhTU0dTSXdHVWtXZStGeHhnbXV6STJ1?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cec136df-ef03-461a-0571-08de1e5b5a73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 00:11:24.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu83Zi1lAcAqiyBwzz/nSn5gfio3X8vTk3hD5Y3H6DrZbR9lU+PWr/RHs/VGsvTTZo0s6DELJ0C5X0tfQCykQ1/ywt0qdopra499sLv/CRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> In the last few years, the capabilities of coding tools have exploded.
> As those capabilities have expanded, contributors and maintainers have
> more and more questions about how and when to apply those
> capabilities.
> 
> The shiny new AI tools (chatbots, coding assistants and more) are
> impressive.  Add new Documentation to guide contributors on how to
> best use kernel development tools, new and old.
> 
> Note, though, there are fundamentally no new or unique rules in this
> new document. It clarifies expectations that the kernel community has
> had for many years. For example, researchers are already asked to
> disclose the tools they use to find issues in
> Documentation/process/researcher-guidelines.rst. This new document
> just reiterates existing best practices for development tooling.
> 
> In short: Please show your work and make sure your contribution is
> easy to review.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>

Looks good Dave, if you are spinning one more time a couple trivial
comments below that you are free to ignore.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

[..]
> +Purpose
> +=======
> +
> +Kernel contributors have been using tooling to generate contributions
> +for a long time. These tools are constantly becoming more capable and
> +undoubtedly improve developer productivity. At the same time, reviewer
> +and maintainer bandwidth is a very scarce resource. Understanding

s/very//

[..]
> +Some examples:
> + - Any tool-suggested fix such as ``checkpatch.pl --fix``
> + - Coccinelle scripts
> + - A chatbot generated a new function in your patch to sort list entries.
> + - A .c file in the patch was originally generated by a LLM but cleaned

s/a LLM/an LLM/, spell out "LLM", or maybe "coding assistant"?

Otherwise, I assume the three different terms "chatbot", "LLM", and "generative AI"
were deliberate to try to capture a spectrum of tools?

