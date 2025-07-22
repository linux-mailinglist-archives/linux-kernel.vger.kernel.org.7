Return-Path: <linux-kernel+bounces-741473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CBFB0E497
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7824565838
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA63285061;
	Tue, 22 Jul 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d5T42J4A"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663D4A2D;
	Tue, 22 Jul 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215129; cv=fail; b=nruMR2/IYBG9qxyStp056ExNAaUTJZPhgnneA6nmH3foikcZxiuw0vPTvBBgwmcGcjC81xajYNYKUCGzLR0MJzHEGxxNFa2ysh4H2pOfjNxUvEzer0mNE9wWexvAtJi8BPdXVVmueTsYPIpJaHqUQ2wKICrxeISYLOcEIfMBN2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215129; c=relaxed/simple;
	bh=MGQ0SgVcH6u5A22peEfGa8NcJxZsH/gMrFf3dBIaIrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p7pjfarNi33WRJWFZ+WmzOZPORjbwauHCKXxlmgidOQDkfDWstAeTzV5ywX9mvy7Fhwv8yMffplSJbVMi1LJPitcE3KWeAgHgb2+1BL/8R0ubf47kBNmOxahfApZ0lqQNYwWjYkztPFi4W5KlNIErCotA/tAXXUcY/KXJ4uLuOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d5T42J4A; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ite4Lldo3OaNkmMa4ToXZ/xnvpWMU9M6bO68tTUYNn4O+528sxIbQR99f48Dro6kKy08yd7YUDM5fUnqXnFIZNdFEt19h8V2kWJVUZTXkfAPfQrXdSB9mPPtwzu6NwFHZZECU0Ppo2oGnwfnD2SkNHQy+vl1EdygV+YQcVgfFcIJ8lwwi1MfD/vvFrPWIb5An5KYfVBDZD9Fw0UeKih3O15U9o9r1BiGxRTRDMEjYpL6CS8Pu90qKsza/k5Y25qA3abbEMMtBwj1FXNohEYunXJYwORy5p0DEOUCRXq1N0zW9N4cGpuUcYHvTKe95j+i+DS4+KF/SgbrtZYygCQJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BzYUYdWa9WVCUBDXgzU1sMFmUxGzSMLdZT4DhWyWK8=;
 b=FbfEFZ02lHDFWchvaoFuVcnY8/zz7F8OICvhipmxnGlfXBNXVJaYTihMEuzjuiyl7uTG3TmIvq/ADv7YWM4i+n8YKSyv7psg14J8nP1nuBg4mZBWUL4nrYLsXqSU8wBkzyCOwhrG3Hxes7ColOFFLbxC72TliSOoP2C4mkFZfglXOThetJYzATSCTrHRRIiJOcDAUQmWw/YmBJoibzQAzDrIYdQH/dOCSROCj047zeTMf1QPQTkXDeAVKWCCPQulQud/i9mznH3ipbv3Q6Gve0hedV14iTpgK20NXdhB4FoKPXDweqBQAOPpmWQ1zM7Rxba08Zzf4XJE/qdRyeHiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BzYUYdWa9WVCUBDXgzU1sMFmUxGzSMLdZT4DhWyWK8=;
 b=d5T42J4ALZE32qGNXAJ40SgLN5rJfB39Bq/W0k6MH4gUUMTqluQQ9DLNeJ0S3Nh+WogYSWNzWLmO3orlWnuvjMD9ntoQyYi0kT3COIBfpjUWKUaI5DWC8YKr+qDwUP6dUNAcOkGaZSV3F1tA4ftKyWt7a51Eni+4ODutVpup4ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 20:12:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 20:12:04 +0000
Message-ID: <7ecd5229-9966-4983-b053-09c8bc560aa8@amd.com>
Date: Tue, 22 Jul 2025 15:11:59 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 26/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <0fda2f958001dec07827f803f0e31158a2b77a8f.1752013061.git.babu.moger@amd.com>
 <2028b020-bb31-421c-b7d8-acb9ac7e9f77@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <2028b020-bb31-421c-b7d8-acb9ac7e9f77@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 630a3c05-d026-4348-7da4-08ddc95c0655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk9tSTlvQ1FjRzR0T3lnSUtPOGxuVWMyci9rTXZRcDhpcUNVa1pmQVQyenBt?=
 =?utf-8?B?Vll2Q3NYMWdXNGM3elBNa0UxbE4rQ2tyUDlvQVFxWktrNjRaVnRrWkJJcXBQ?=
 =?utf-8?B?SEZUcTYxWGNoZm5yTTVQa1hvRVdaTlpsMnoxbzFvdDhBOXpwVGJRTEdhSHpy?=
 =?utf-8?B?aEFRaTEzd0hQS2tEbk90ZmtzV2JvdlNyREZIRzRXVG9MWnA1d3dIU0lmU2ow?=
 =?utf-8?B?RGJ0SU8yeDJRdVJLV2c3TmRnVUJsYzVESlhSaDBrUm44OXE2VTcvbTVZd0NV?=
 =?utf-8?B?WmFkSkpZRjVXTEptNlBpUEhWTDNtenEweVdHRy94R2NsVHZ6UWpuKzQyMUFU?=
 =?utf-8?B?QTJuUXNpbVpBeXk3MkRzQU94Z1pNM294QjRBQm5GcEFDQklQSXJKRlRwN2du?=
 =?utf-8?B?b0duOTNIbmEzK0w1WFZRZExqMjNuZlpYaUNJRmI4ZUxQQW1KOVU1eVBNWWgx?=
 =?utf-8?B?MWZCdDdlMmNMYTZhM0t6Y3BLaE9qSnpKNWVRVS9lNkRtZ05lSDNiYWJKTHdJ?=
 =?utf-8?B?RjlOSHljTkRSQVd0VU9OUFkvQVN1YzFJcDZsd05UdjNxd1RUZENualcvczBz?=
 =?utf-8?B?UGFuZGdLMUJud2d4dEhpTzZzZjM3c2k0ZzVHSXpNU1F2a1NtNzYwK0o0MkhJ?=
 =?utf-8?B?VXM1NW43OGZWYVJNa3owTTdwb28yTmZBSzZqN0JWejduOVNrZWljcWtnNFhj?=
 =?utf-8?B?OEc0MkxxVGRIakV6SzY1R0RTV1JZR2t4NS9GN2Q4QUZUTzVOenJHQllVYXdv?=
 =?utf-8?B?NU1JUUtIYkUrNFJROGloYTBOTzJsaDU3NXNIck1PQnJ2SFA4TmlIR2sycnRq?=
 =?utf-8?B?Wm95WGRQYUJHQ2Vzd3UvdUltRE9KWmlPL1lCZ09sTmRESGNWTkczWjNwNGR3?=
 =?utf-8?B?VVBlUDVNS2tFcVloQTRXaUJ0V21EM0JhSVJqbXU4M0JBVHpsWnhQRENmcmdY?=
 =?utf-8?B?M01VMDJXUnk1K3ptbmEwbE1IczB6OUgxdm9xRFh3Qm1kYTZXQ00xVUVURWR1?=
 =?utf-8?B?aTdlVlBrL0k1eUJWQ0txOW5ncHlMOXNZM3BUc2IyeXFJOVJnbnlQY20xVWhE?=
 =?utf-8?B?T1BCSUNkUEFQMTF0U0VhWjUwbytiTDdzbXlYNFVXMlZCZUpZcDhIVVAwV3J1?=
 =?utf-8?B?R3NHMzVXT0c0aVAvV3E0NXZuNkt0N0xyUW1mVTNxTnJSWWl6YWpycm53RUhD?=
 =?utf-8?B?eUlBeTFnK2FPY0RmRmVUa0FCTUVubnpIMVh1YkJJVXBEOEQ2ajRMTHltSlRG?=
 =?utf-8?B?TFNpRFAxeDBBL2NDN1ZaVEVIemk4ZkVGZW9vVVhnbGlDeHA5cHFPYk5KMjcw?=
 =?utf-8?B?WGNPdzVPVlVmUTdFVnJpUUlkNm1nbW1iT2J5QWZHQm1Od0pkaS82YU9LZFBx?=
 =?utf-8?B?VDFLUHE0UEV4aTAvbWJqQlZSLzRZK1NkZmxaNHljMzh4Qjh1eUVyU2dZOXIx?=
 =?utf-8?B?TFZWSlR6TWNPTFJHQkY5cjRsaHUrLzBzZU5Uc2MreCtUYkxTRnBRTElnem5B?=
 =?utf-8?B?aW1ydDFwbi81bWxoQ2xGUTdIYVBxTTFCdWp0SFBvZkpIYjFKaERRV3NGRDRY?=
 =?utf-8?B?clJPb0tEN252UVVidmpnUkNmeS9VaXpKMzZQZWRkVXhoUHpxU3M2WUJOTmdB?=
 =?utf-8?B?ZlMrU2hTaWMrUHVML3YwbW9zS0xFdmxjU1dQanlwdmc0cHkyRHZkU2VDNm5X?=
 =?utf-8?B?YmZScFBpOGpKb0s5YTcxZDV6Z2RqVWkxM2w1NHZ2Ym1QekNDWUNRTDJIUTBT?=
 =?utf-8?B?THpJRHBxbVR3ZzNqUHVoTm8zcEJraXVkVi9nWnFsMHEyQjN5d1N6V3ovV0Fz?=
 =?utf-8?B?V1JDRXFqVUYvWkpHc2pKbGh0cTI5UUR3bkhFRi8rb1Rra00ySDlMVngycjlQ?=
 =?utf-8?B?eGNxaGdCL2RKZ1UxYlZja1BDM0VpS1V5dDNncWFpYkRVSWtoSVREM2lRU1ZG?=
 =?utf-8?Q?fuIbnjWmQpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUxjaXVCelFZVlVYQ2FCVkEvQlZybnRaT00ydlg4cEtXYUVlS1JmV0h2emVo?=
 =?utf-8?B?V1ZOQ0ZFaW5WTGdzTExRMkZQWlA0RjhOVGxPdHRScEc0S212V21xdjBQQ2VN?=
 =?utf-8?B?SnJ2OXBRNjMzNURvN1dPM3Z6NDRHbFpSRlh5eFNVQ3YwTWZwTmJ6bnZhbjdI?=
 =?utf-8?B?NmpNSTlkcm50bW9DKzNwUkFBNGZOZ3lhdGVNdVlmVXh6QXdRRmVHTnJvK3ky?=
 =?utf-8?B?SDlRa2xiL1M0K3diS2J4RlNTN3dkbUNTMkZvTG1aYndrS1liMnkvSk95Sy9Q?=
 =?utf-8?B?QVJLMXpOMGZSdGN0RzR5a3dySEhjMUpxSG9HZ2laV2lFWHlxeUh3OXg1NVpG?=
 =?utf-8?B?M2krejBYUEZoZEJWVkhUZmllU1VkZUorM2dNNW1PeVE2Qy9xeDIyMEIvUncv?=
 =?utf-8?B?ckR1QUNUakx5U3dldWQ4RDVPNG54Mmp5UEpNK1liTFY1NFgzRmdXd2JxQm4w?=
 =?utf-8?B?ZkZKbTA3bVNQQ0I5bG5Velo4RStQOWQrb2NudE1LeHJsdlhISy8xSk92R1lZ?=
 =?utf-8?B?UUVGS2hsdkUvbkQrZ2dXenZsS0dHWDR2ZHV6Vi9zMnZtTTNZNWNuRXVGd051?=
 =?utf-8?B?blJDaVRpSnhHUE5tTWdjVnR3anlzMTJZRXQ0bUJBUUxaRDZqK2NJTXdlQVp5?=
 =?utf-8?B?bjZ2RHYwNlAxanV4WXFPOVVtT0d0aTRFY05WQWowM3JFYTZseC9qNnRVS3Z6?=
 =?utf-8?B?cTBuc1M2dUpqblNucnpTR01wL2loV0NILzhyRkJIa2U4UGNOQS9rSXNXd1E5?=
 =?utf-8?B?TW1jQnliendHcVRrVExiMDY3clA3WnQzOXR3cHlGWUp3VUNuR04rb3ROWXU5?=
 =?utf-8?B?RmdxQ3Rsb0oyTVByS1V4WUg5YXVpTTB1NFFHUHpxb0xVYTJoek4ycXZrd3k1?=
 =?utf-8?B?bU15ZjVUUWMrVTd0cUcwY2VVYUtyKyttdWFiS2pDUHZUYXRFVm5qVGVWbXB1?=
 =?utf-8?B?T0MyUTRMR3p1b01SWWNKMko0ZlpPaDdpV0xjbnM5S2V1T1dHa2IrcGNYcndn?=
 =?utf-8?B?aFd1Um1hWlpkbHE4WG9TclNJRDRrSXRldys2MG80bTlENWRkdlhidkEvNXFz?=
 =?utf-8?B?cXY3YnN3WStkTm5OSFV4N3pjdHNTdHRZQ0N5SGtIdE5YNUsybnZrbitKandY?=
 =?utf-8?B?K3Awd29oUStRcGthWW5oNnEzR0RmRTdxQnZ6L1Q0Qm9yeWJnbUxGVDQyak1D?=
 =?utf-8?B?NUFYOHdqY2o1d2loVVN1QXhoUW5FanVuR012aW9SeFVWazdYalExa2I0Qm85?=
 =?utf-8?B?VjRIM20xMWVycmZtNDFiQVRKdlVWZlgwVFVjb0ZjME00ZE13UmFsd0Q1M1JS?=
 =?utf-8?B?VzdOdVp6dkU1UDk0clRibjNpTTNkQVBTbEVabnZWS0dRZncxektSZ3F3U08v?=
 =?utf-8?B?N2h5NFpyNlJ3RUlpdXl4c3VoRDdKY0xDb1hocXZrQ2tNNlVnbUozdStkdFlt?=
 =?utf-8?B?Q0hkS3ArOFZnZTVEYnlSa0MwNXpZNDhvVmtXdEZHOFZKOGExUlc3U2NsQnBq?=
 =?utf-8?B?YlAyVW9xZE52V2ZXMjVZOE8vUktVL3QxSjZid3FwMStudDNOSWhmZHBpZzBX?=
 =?utf-8?B?ZnRUSGRScGZ4dHFTZDZiOUdURFJsZ1EvcWVvQmgwalFMR3VyRitaZUt1Y2R2?=
 =?utf-8?B?ZG1JMFkwWHJlZ1Z3Vi9yZllVTEpEMm5lWExoVktJeHAwK3hmU3NvbHBpVVlk?=
 =?utf-8?B?OGpETFl5M1RiTnBJWHNEeGFhRlhDZ1pvbnN1NmovenZ6cklBckwxRElpV0dk?=
 =?utf-8?B?Q0dJOEFzQ2hYa1A2VC9IVVdDWEJBMXovWFRxUjNMTkxYVjA3Zm0zUmlqcTky?=
 =?utf-8?B?U2h3dng5bHRCcGUrVnJEQUh3SkhsU0dsaGRaWWV2c3pmNmdFbDBvczBPMmdM?=
 =?utf-8?B?Rk91RmFEVFBxZXNtS2xHalFIWHQyaUFwTUxXM2loWUN3TTFVWVMvWjJrS0VE?=
 =?utf-8?B?V3lsRmJSbDZndWZTZzZzaVd0OHAyQ2hOQ0M2ZUM2dkJOdDIrQmxGRE5od1Bm?=
 =?utf-8?B?UDVzeHBSdEhTbGxMaWxianpnb2ptS3M5aE9idXNVY09jSDBkaEYySEl0WVdm?=
 =?utf-8?B?ZHZndzJMeWNMalJnUWFCOHVFVmU2bGpHRlIrR3diT3BScWdGYk1qa3hoQUEy?=
 =?utf-8?Q?HHn4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630a3c05-d026-4348-7da4-08ddc95c0655
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 20:12:03.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34Biiext2mpRF9Sa1CdHPJgY16/8GNCXO/oVUBq3qhOfxY8HKNQzT2GuuLd3OQIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

Hi Reinette,

On 7/17/25 22:54, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 15d10c346307..bb28ef7e4600 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -86,6 +86,8 @@ enum resctrl_event_id mba_mbps_default_event;
>>  
>>  static bool resctrl_debug;
>>  
>> +extern struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS];
>> +
> 
> Please move this extern to fs/resctrl/internal.h.

No required anymore as event_filter_show() is moved to monitor.c

> 
>>  void rdt_last_cmd_clear(void)
>>  {
>>  	lockdep_assert_held(&rdtgroup_mutex);
>> @@ -1895,6 +1897,25 @@ static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>> +{
>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>> +	bool sep = false;
>> +	int i;
>> +
>> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
>> +		if (mevt->evt_cfg & mbm_transactions[i].val) {
> 
> mevt->evt_cfg could possibly be changed concurrently. This should
> be protected with the rdtgroup_mutex.

Sure.

> 
>> +			if (sep)
>> +				seq_putc(seq, ',');
>> +			seq_printf(seq, "%s", mbm_transactions[i].name);
>> +			sep = true;
>> +		}
>> +	}
>> +	seq_putc(seq, '\n');
>> +
>> +	return 0;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
>> @@ -2019,6 +2040,12 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= mbm_local_bytes_config_show,
>>  		.write		= mbm_local_bytes_config_write,
>>  	},
>> +	{
>> +		.name		= "event_filter",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= event_filter_show,
>> +	},
>>  	{
>>  		.name		= "mbm_assign_mode",
>>  		.mode		= 0444,
>> @@ -2279,10 +2306,48 @@ int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
>>  	return ret;
>>  }
>>  
>> +static int resctrl_mkdir_event_configs(struct rdt_resource *r, struct kernfs_node *l3_mon_kn)
>> +{
>> +	struct kernfs_node *kn_subdir, *kn_subdir2;
>> +	struct mon_evt *mevt;
>> +	int ret;
>> +
>> +	kn_subdir = kernfs_create_dir(l3_mon_kn, "event_configs", l3_mon_kn->mode, NULL);
>> +	if (IS_ERR(kn_subdir))
>> +		return PTR_ERR(kn_subdir);
>> +
>> +	ret = rdtgroup_kn_set_ugid(kn_subdir);
>> +	if (ret)
>> +		return ret;
>> +
>> +	for_each_mon_event(mevt) {
>> +		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
>> +			continue;
>> +
>> +		kn_subdir2 = kernfs_create_dir(kn_subdir, mevt->name, kn_subdir->mode, mevt);
>> +		if (IS_ERR(kn_subdir2)) {
>> +			ret = PTR_ERR(kn_subdir2);
>> +			goto out_config;
>> +		}
>> +
>> +		ret = rdtgroup_kn_set_ugid(kn_subdir2);
>> +		if (ret)
>> +			goto out_config;
>> +
>> +		ret = rdtgroup_add_files(kn_subdir2, RFTYPE_ASSIGN_CONFIG);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +out_config:
>> +	return ret;
> 
> No "config" is happening here so the goto label can just be "out".
> 

Sure.

>> +}
>> +
>>  static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>>  				      unsigned long fflags)
>>  {
>>  	struct kernfs_node *kn_subdir;
>> +	struct rdt_resource *r;
>>  	int ret;
>>  
>>  	kn_subdir = kernfs_create_dir(kn_info, name,
>   
> 
> Reinette
> 

-- 
Thanks
Babu Moger

