Return-Path: <linux-kernel+bounces-812639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47993B53ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E857CAA19F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADD35FC3C;
	Thu, 11 Sep 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SsgQp0Pj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB6635
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613357; cv=fail; b=MIXcaQWXIbxqj2hmxR6VrKtY8wo4agGI5ZT3OoamtxMLVrUrkLmFPjXQYfPYKC2VM8MP+K/uc4U4BUbP3xmYVuGvKaUVPkJWfC2O53Crb1VW2ENye/tEPqQ+3K1hKnW078MWMatN6lkmlTHbTh977h+FKz5E6F7y6i9MmOaj810=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613357; c=relaxed/simple;
	bh=45WXE7cczDRerYskucewQpGTHSj5PjlAoBUohXlJl60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rzRhX7yV1oIiS/zdtU4y9k+ozP1GHl7ZPMqxzfYh3c2rMS1aQWJSJzceB4hwgH0V9PV3kLCsuDQ9QdoSsz/OO8AZHgXz32eX5gPLg0XLYl7zT1mddVaZc+JfyFAksxRP5BlfzyEj+eeOK3+2JTyCXbblF5DYJ7Babrw7/tJWPRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SsgQp0Pj; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJn179vS2BTJ6AebMzbkJz1OlGvaKZVfHQMdqb1IGYjz0Bbhayjm/c2B4jXce+nHE4Mqk0ShDeMkVoEDe/bSP1oujnBv6Bs+Azx4lNYaggC8d8TRmNqs19RnxODyLDM576BhUWKcdnoY1FmkVM+Z9rJtNKBoq0xZWLyDjLCU/ybEDF+P4Wo1lVU3bU7vCEfWjD5WZ3IcvivDfGSHN5aABhZVB+3WkF/ZjK+4mhdr/iDCdVZL6mIkYj52vXzVw3oOUe+oq4m9mUxiUdJPhxtbi52t2DU5kcyVAnxZwFOnErLeMXdKAtjuMUzvbbH11ZAkLkx0YZJsWw4XNiDGGb/c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlJamb28xZuijTkHz7tbPzVLwaivp4YBzrDwUR4Q4v8=;
 b=XoAS3iEdefEVZ+t45CWa+DuxcBPbO1lOxRRbUBo6bk9gGiyDqj1M9fgj+hjdz9d5lvBPrGHRPLJNsnbvXD7+Niqrk8OHoAhhq1azJ+4/Mc0x+keo/jikJJdo9faMQsWRvu29fL2+jxnuBhzio5hyDXoNu943T9r1fDdxtq4tSjJALcvD8NLDuARe0YJTQxh4FJJCDgCzrWjXbtN9CRJHluxy0mCObIfcAeR7EvsNqPpXyt8gsk81xCEjKZgFAlftkhdnMbrGDSF7IlEvshXb3Ti1GN8jgerHC8rNzNRE5E0/vXcpfz3J7EEccMH30S8bDX9T39tl24f7jdTK8d0J2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlJamb28xZuijTkHz7tbPzVLwaivp4YBzrDwUR4Q4v8=;
 b=SsgQp0PjQb2DS75t7Q6yPKdTev1BC45MLWKB0ZXX9r/j6znKbIm2MXld1hNrF55IK9Yu+RKmzjnSnYXKISck1vwP/avASO/UsAogFmcjY2wIl6CCnEueGenNi8ccjyH9nBYpWLfWTtWqnW3nf/pRznzUSdQg/hHdYpoOpCRD1DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:55:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:55:51 +0000
Message-ID: <ccdc6dda-8341-4b77-a571-e0642499e3f7@amd.com>
Date: Thu, 11 Sep 2025 12:55:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume
To: Matthew Schwartz <matthew.schwartz@linux.dev>, chiahsuan.chung@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, simona@ffwll.ch,
 airlied@gmail.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, zaeem.mohamed@amd.com, misyl@froggi.es,
 linux-kernel@vger.kernel.org
References: <20250911174851.2767335-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250911174851.2767335-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: c28b8608-f9be-4eee-ebdc-08ddf15c724f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVM0SnJkWDN6bGI5dUkrMzRocFV3Und0SzdVeGI1K0tnQUwybnhobHB5R1lM?=
 =?utf-8?B?YkFnQklVeVRPZng4ODZUdlZmMGRocUZuaTZ4b0NHVWZGWldvaU5SV2pyYndL?=
 =?utf-8?B?eFdtNytyL0l5UmdiMmRac21pUURqTTFaMGxaZTJ0QTFKdnlCdmRaTkpkczRa?=
 =?utf-8?B?UElHdFNQWkdYWVRMdGZmNlNHb0RmUEV2QjRLeFk4Uk1IMVpkUTZzWklzVGNx?=
 =?utf-8?B?TWkwWjFDek11c2lHcE0xejlrRUNXcmpiVXdRSW5mdExDQXowcmJnVTJGZTdK?=
 =?utf-8?B?b3FiUHgzazlVSUFJTWtOZWR2SG8wU2JUWGxsRzErT3JyMmtTaWpFdGY3V0pZ?=
 =?utf-8?B?Y3BKbnZoVTJUcWkyRUpWNEtaWGM1MWNQWmVmMFRrMm9kVE1NSXVtTnlqMVNr?=
 =?utf-8?B?L1N5ZVRrWDNNbU1sWUttdlRIU2pGc0l5VW1LVkhJcnNmQW0rUmJLUHROZkFI?=
 =?utf-8?B?MzdkZUxoWEpKM0E3RVBETmwwNDk1NnZkVWs3bzRHd2pjcmZVblpyY3Q1NytJ?=
 =?utf-8?B?bXBBSjhFeDJZeVptQnZrak44bjBZU2JNcjBvQXUxWm5TRVF2Vk9idnQ3MVpN?=
 =?utf-8?B?ZlM1RDhTdzBCYkRIZ3hhbzAvWEorc1I0c2hhR2s2MnZlR2NadFI5MmlxRm5M?=
 =?utf-8?B?dDErNWF5cHVmeWxhc2lnWWJRb0ovN0J1cW1QME45RGsvamVwaWt2WnpYYTRi?=
 =?utf-8?B?anFLcGVxT0lydTlORkFJWFpINFRKN05OZ3ZuUitRSGFhWmJzZnZZajIvRERo?=
 =?utf-8?B?NTdkRVdkQ0VaNm5FVmphdFFISzRmcGZYY01UaFZiVVZqR1FBd2NGc3B1R2xJ?=
 =?utf-8?B?bm5wWXhoYk9ub3oxY3hDVS8wVFkxOGxCM0t1QU9SWnc4UnlRSWxLRkJsS1hG?=
 =?utf-8?B?NWlmdmxOVE9OVjRmT0FxYldXMTNtcjRBT3RWSXE3cnFLQkVJWngyYkprU0Fk?=
 =?utf-8?B?M2xvOWtYQUFlWlVkOTdPTktJNmcxZUFuYmR1TGxCTlUwaTZobS9LcDl4Vlo2?=
 =?utf-8?B?SmFKRVhYS3hUOUpzeE54VzdhM1RXcVN2L1A4T0JGdUFYMG8veXJUZ2RXM2hz?=
 =?utf-8?B?emFZZXJCdzd0WUxIYWthSUZZNzNyanZNUGRvSDE4R2MrZmxvU3pyYnBJRkpV?=
 =?utf-8?B?QlcvUklLZW50MldicEFPVVpHdlJHa0FKMnBjZ0w2N3lLUkpLRllMY3RRaUpu?=
 =?utf-8?B?Nlh3ZEJXdW9ub2QrQjZneklrUGRVOFVWTlpSK2FVMzVnUi9NNWJ5YlBHNGNu?=
 =?utf-8?B?dFpXUGc0V3FpTnhiUTdoeXVLVGExcTlHaHBpVlpVNUpYaFRSYTcvQzJDUXVo?=
 =?utf-8?B?c2pvRW1tS0VGeWg4K1AzQWR3UDhidXp0U1dDVTRweWdKWkFTNE9qREZlbEN6?=
 =?utf-8?B?QWVWV3lQQ3FadGkwQWNTSEUwTFdQamRsdDhvRG4vWEp2OEVXNk5TWjkwWkY5?=
 =?utf-8?B?WjRLQ2I0aVhCRlZDcUVkNVJzaHRUeWdGYUV0SkNrSjNiZmRjUzh1T2xMN01S?=
 =?utf-8?B?dlg4SUgyYUhBSmxLUXd3eTlhUUJ6UE1zM0ZHRElydjF2VVQzeEJKRlRiQnlT?=
 =?utf-8?B?YUU2Qkt0ZW1DZ1NRMm1QR25QYWNWbkplQlNkd1RnRHo1U2VlVGg5eG9pT3ox?=
 =?utf-8?B?dk9NY3lqSHNqb2ZlRytwOUhJcHZKQkhGcnk2S3BEei9zU21wa1htaVZad1BC?=
 =?utf-8?B?dUR3YzJzZTBIL3lETDV1aEhuN0pvRVpzajdmUlI2ZGtvWmR2T0lxOFlZU2J3?=
 =?utf-8?B?RjViNy85a0FpUm9TM2lUK2xzaHBneHh0cG0xSDlWaG1PRUFkakJXUWFpRWE4?=
 =?utf-8?Q?wqEYetZTkWsMwqSsNSXyeVTLrmspZxXjQqXAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnVSLzVPZ01nQ29ZL0gwM2YxQXF3ZG5nY1phWWJqdGR2MnU0S1VvL0JNc2N0?=
 =?utf-8?B?Vm1IRWlKbUxvZisxK2ZENlhMbkZyejFjVWgzYVNVV3FBODVqRldUcmczbHA0?=
 =?utf-8?B?MHFwY3BxVXZWait3TWI3MTdBYi9ET2JXMEhqUzlLdTlPeWRsOWlSMndtMlZP?=
 =?utf-8?B?Y2NmVXJDR3poS0ZhZDR2Y2VvMGp6ZExFUTFNa0RHOHBBc3JRT3VvS1ZONm5E?=
 =?utf-8?B?a3hJSVVaQ09Fam93MVFWNTVrMGNHQW9BZGQ1TEdCeFN3bHhYM3FmOGowTVM0?=
 =?utf-8?B?bmNscjVsTCtmSVJFWXlYL3ZId0NFMjdyQWNRZ1F5SE5HV3hBQXg5Q3A3Tmsy?=
 =?utf-8?B?ajJxbURlZmdhTTZ3dWxla2RsY0laU0t5dWVhVHpheUY4SCtMOGcyTzRsUGw5?=
 =?utf-8?B?MFRHM2RjaVQ5dVhoWjJGL2xOZHBzYXpocmtYMU1rRzQydGRWbU1XUTkyTDRY?=
 =?utf-8?B?YXJCb1NTQTBab3VjZlZEQVU0Q1d3cmp5VDdrYnhzVkIrV3Yyd29JTFVGY2VW?=
 =?utf-8?B?NW9QZWpqejBoMW5XNjg2R0VWNW5tdllZZXBlQmlSbzhyVmpXQWFNbG9VTTJk?=
 =?utf-8?B?aDZUNjdlWTlIN2NnZ2sxWC9sdWZkMExYeDErZ2QxbHlzeDdZRkd0eENWUTR5?=
 =?utf-8?B?aTc2L2sxN2xqQWMvYTJiUFFlVUgza0VCdzlPdWJNVGdHYXlMWElwLzlVWi9C?=
 =?utf-8?B?eVoyVHpkeC8xNGZPWXFNL2swSFZ1Q0ZmTEJmQ3BsRlFONVhaWmRETWRBOS9H?=
 =?utf-8?B?TW00R0RYZWpidGhKK2hnL3lrOVFXdEh2Z25tZGRXeFR0dVpnK0ZJclFHa3l6?=
 =?utf-8?B?anhJVDd0ME1mTlNQWitrMEdQQllUdXA2cmplSThJbDRpOEhlZkhkMmllZVJM?=
 =?utf-8?B?M3FXdGdRaTVJUnhLaThndGFwbmYrWGxsa1JNNXpYMkVsQzI4TkdSRTZsVXgz?=
 =?utf-8?B?WjRLY0FZUHI1VHBiQ3o3a3NlSlptV0VqWUZuSm5yQS9Vc1pHUUROZEZ6cklY?=
 =?utf-8?B?dy9zUldFUWthdG5PelE0NGtsTXpWS0J1WnAvckNpbk00U1B0MEVKbGpuNDc3?=
 =?utf-8?B?bmJ5MmV6MldBSnVEczJFTmQrcEt4am5BVkdDOGlvRkV0WVM4OUZPbklVUTJu?=
 =?utf-8?B?WGlQL0VOK1hicy9OT1RQRWRzOENMWUpFSmZwWEVTZlRWRVovTWtyajRjVHZ1?=
 =?utf-8?B?ZUNmdm1lS0NmZ01scWNTR1JCRnBCUkFIVGpBUUpDTGZnSHZVdzBENFlFcGE1?=
 =?utf-8?B?WExhVVRCaGtJbVNRdFByZmdIcnMzMjRxTU03VHdwRml2Y1l2T2lVQ0xRY1Z2?=
 =?utf-8?B?NHcyUnNjVkpRVmhtZ2pDcmhhSGdCcUtRdnVVQUdhV0xzaGlnZGNaaUdxZzQw?=
 =?utf-8?B?R2xTWUlLRW1zOEUvMVdMTmpVV3JEYm1odjRSU3FqZk1JOU02d2dOY2RBcVox?=
 =?utf-8?B?WXQ5WHI0dUZMakx1cHVxdTRmZHhrKzdjK3VDdFVENDM0dnVnU3h2aFp2WnVN?=
 =?utf-8?B?dWk1d3o5SE5QL3JPNkNZZGsvWHg0Vmw0V1p6d3Z5ZCtiWDZQNVRSVkc1UHdq?=
 =?utf-8?B?NCtteXZXcjB5MmJ5V2svZTBIbVRnTWVRQUo4cVp3dHhCNUc3d01YNDI5RGd0?=
 =?utf-8?B?M1pDZ1FwdzVmcVFUOThrQlN1eGM3bHlWYjJFamxJTi9qb2JFVzJHbTR4NHRW?=
 =?utf-8?B?Z0tLVGJPeDNuUElWV0hRbHpzSTFtTFFiNWRMSzcvMFNOR1pNMitQRHVQOG4z?=
 =?utf-8?B?RkZ3aUVkYW94ck1EN09yemkrdExFRGlTUmNYOXQ0d3dhNm1RRm91bmtqcmhD?=
 =?utf-8?B?Z1NuYU94YWxLN01rSG9SMTVYUHhka3VKZVNSRlk5YUk5Z1IwM0FCcFVmSGZ1?=
 =?utf-8?B?am43UmRFYWxhZXlXYm1pVm1nZkpiaEdVRUt2OGlJVUZSdS80ZG50ZTdHbEJ1?=
 =?utf-8?B?OCtGeHErd3VCK3JZQnRscC9rNmg4SmoxeGZPRnZPeS9FeG5DOUx2YVdtS0ZX?=
 =?utf-8?B?TmtuZFBCUUhDSFBPRVBleHhvR0FuaUc2WHUwL1R5c2wzdGJTYzZPclA1NUVZ?=
 =?utf-8?B?OHc5RXBibkFrMFM1Z1RkOVpwUEp4bjk5NmRUODlWTlFqUUFoM2NUUkMwcXdj?=
 =?utf-8?Q?A5qPDjAMxvySazb5HwgOjYhGD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28b8608-f9be-4eee-ebdc-08ddf15c724f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:55:51.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML8swqSHfdlD63LdO/gDzCjF1Ghkz8eACvFWeP1g92Mx+clZMBCvo3UzNwxB6TmbBP2iZr71ZwnSGxj98ISWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

On 9/11/25 12:48 PM, Matthew Schwartz wrote:
> On clients that utilize AMD_PRIVATE_COLOR properties for HDR support,
> brightness sliders can include a hardware controlled portion and a
> gamma-based portion. This is the case on the Steam Deck OLED when using
> gamescope with Steam as a client.
> 
> When a user sets a brightness level while HDR is active, the gamma-based
> portion and/or hardware portion are adjusted to achieve the desired
> brightness. However, when a modeset takes place while the gamma-based
> portion is in-use, restoring the hardware brightness level overrides the
> user's overall brightness level and results in a mismatch between what
> the slider reports and the display's current brightness.
> 
> To avoid overriding gamma-based brightness, only restore HW backlight
> level after boot or resume. This ensures that the backlight level is
> set correctly after the DC layer resets it while avoiding interference
> with subsequent modesets.
> 
> Fixes: 7875afafba84 ("drm/amd/display: Fix brightness level not retained over reboot")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4551
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Haven't picked it up, will wait a few days for more comments.

> ---
> v2: Drop set_backlight_level and use dm->restore_backlight in
> amdgpu_dm_commit_streams
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++----
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7808a647a306c..2a5fa85505e84 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2037,6 +2037,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	dc_hardware_init(adev->dm.dc);
>   
> +	adev->dm.restore_backlight = true;
> +
>   	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
>   	if (!adev->dm.hpd_rx_offload_wq) {
>   		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
> @@ -3407,6 +3409,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>   
>   		dc_resume(dm->dc);
> +		adev->dm.restore_backlight = true;
>   
>   		amdgpu_dm_irq_resume_early(adev);
>   
> @@ -9802,7 +9805,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   	bool mode_set_reset_required = false;
>   	u32 i;
>   	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
> -	bool set_backlight_level = false;
>   
>   	/* Disable writeback */
>   	for_each_old_connector_in_state(state, connector, old_con_state, i) {
> @@ -9922,7 +9924,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   			acrtc->hw_mode = new_crtc_state->mode;
>   			crtc->hwmode = new_crtc_state->mode;
>   			mode_set_reset_required = true;
> -			set_backlight_level = true;
>   		} else if (modereset_required(new_crtc_state)) {
>   			drm_dbg_atomic(dev,
>   				       "Atomic commit: RESET. crtc id %d:[%p]\n",
> @@ -9979,13 +9980,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>   	 * to fix a flicker issue.
>   	 * It will cause the dm->actual_brightness is not the current panel brightness
>   	 * level. (the dm->brightness is the correct panel level)
> -	 * So we set the backlight level with dm->brightness value after set mode
> +	 * So we set the backlight level with dm->brightness value after initial
> +	 * set mode. Use restore_backlight flag to avoid setting backlight level
> +	 * for every subsequent mode set.
>   	 */
> -	if (set_backlight_level) {
> +	if (dm->restore_backlight) {
>   		for (i = 0; i < dm->num_of_edps; i++) {
>   			if (dm->backlight_dev[i])
>   				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>   		}
> +		dm->restore_backlight = false;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index b937da0a4e4a0..6aae51c1beb36 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -610,6 +610,13 @@ struct amdgpu_display_manager {
>   	 */
>   	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>   
> +	/**
> +	 * @restore_backlight:
> +	 *
> +	 * Flag to indicate whether to restore backlight after modeset.
> +	 */
> +	bool restore_backlight;
> +
>   	/**
>   	 * @aux_hpd_discon_quirk:
>   	 *


