Return-Path: <linux-kernel+bounces-787425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325A4B3761E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0157B08AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C926AE4;
	Wed, 27 Aug 2025 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4featBtd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3E30CDA9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756254708; cv=fail; b=GhSVmdA0W9c5g9SM/vuvhyk/3GHIa/yXae3ehRdKnxryJHgcuJgbRSM+wTuG0auHkmJuVf2atvL5Xv8DwuU6zFETwWoQWHZmj3r4f7nVhhErE3Pr8h38gdursnptuIrrqOCXRk5eeOO1jWBIIMhvB622j5Lwl59rp4cDI+YIdZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756254708; c=relaxed/simple;
	bh=hSJt5Z0CTbMJnO4uVbECrxmdt6Zp6NwZmpLKOpCkgrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QPimBl6axcBDx9OHjhcWDGlOERpOQFwETbah8A7qwZabCu+MDtqiii0aCXQdpz+7el0HjoiLJxJ+j3bxmwZ4V0l9O3KWpAwLWB4RfatudbaTJHhE+LVWuRVV59vUfen/D5BvL0xnK8MizXt/N+AA4Yft7d4qBIbP+Rw3GzSHlY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4featBtd; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=En2yQBe5r3qd7cpf+LCU/m51KYXVxwbDcndYnDDgVr9qH/oPIDvE3pSYb65MncXR2Cp4VBI9g7aTSb5u2in1K4+H+5TVJIZBAJiU5STrKbIJFCRaHpJI2UDde1ac5sxMDXJAIku6GCpvjvbo3KPIulvfTs4LEL+lEK6n8cBfYKAkz57r5IYQx7DnRq7mZmnsmDU+15cDh+VTPu0Sd7BtrqGHs0ycIlrg87xMT6+uMY0q4HGqiwyuaWOekNOpPArL2wydu17GmD4loTY7OY6SOCY7SwJwBsQuRsyRDlWqBFpZtJUIjEBrtAAlCf8YZFs12IPaQwvd0+NjBtocBx8Y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1RLUG6M8j9NDy9W0CzXz+4sXnI+7wF7VJIpX61JTrM=;
 b=LbZ/50/xw9eq5Q6CN+OKpLPJwgVDFtRhDFYx0bVnRPTNOLmlA/ge5Efcwj8ZGPGRhD+mpz2/0FEXkTDBiU3W6TpeBYq6/hmO66OBYalANNiWtCqq0rSsBcfql4ll2EBlAdxmM4eslEdq1c0sIEDTMJhiIN2FN6IfV/PU/6RYmXArJ1AohnSslWlUkVB/GBKMvGyRhg/nsQ2/RQmn2YDLiZaBZKngJYhua7bhK8VZR8LLUBPDBEcWLN+zjvskrXR2b/sLQL0ECjWycCMbsVGcJ3h4/dgDmTe0vXP2LqjJlHTxMRH/lBIBPI7u6QseiEDK9CmskYB3y78fkDuTrYtafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1RLUG6M8j9NDy9W0CzXz+4sXnI+7wF7VJIpX61JTrM=;
 b=4featBtdtFTMVYHLQcmI9OhbNmyAKrm7MXG0ASLUbLdoPTb2jCF3DmS0yA20bD/fnKCS1sA3e+PJXx20O1qbusikMQxpom8BMYOJ2vk4M9P/Qq71MUhn38sHl1OLfIZt98Iw49lWC4i5oxGkuqiSbtGbpZa2XpyV6cZ8SjMuqoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Wed, 27 Aug
 2025 00:31:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.017; Wed, 27 Aug 2025
 00:31:43 +0000
Message-ID: <c048645d-480d-4b7f-8dde-efb095b2c2fa@amd.com>
Date: Tue, 26 Aug 2025 19:31:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add ioctl DRM_IOCTL_AMDXDNA_GET_ARRAY
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20250822172319.377848-1-lizhi.hou@amd.com>
 <2bec1429-4f8c-472c-99a1-420a33a3d316@amd.com>
 <d6a02baa-3b05-73e6-9c2a-66c257efecc3@amd.com>
 <a9814644-96e3-456f-90b7-8705a102c938@amd.com>
 <2a21100b-2078-a166-0b47-9db6b4446b5a@amd.com>
 <b758a72f-e30e-42f9-a6aa-6f6297b8cce3@amd.com>
 <b3874221-5b4f-9625-de8a-4e54dc6884a2@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b3874221-5b4f-9625-de8a-4e54dc6884a2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:806:d0::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ba5d15-ee0e-4ed1-5602-08dde50118c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzE2dXRZYUc2QzQvdG5SbElKTG01R1MvOUpCUkpqUTZGTG9WdGdNUnZhSy84?=
 =?utf-8?B?V3VGdmV4OFFHTFJSWXdWOEdHbXYrZWt4S3ZrN09mdlFESGV2UkV5M0Yxa21X?=
 =?utf-8?B?aVVLNjVDSElldENDNjZtd0IvOWJGZVVrejlGZ04vTElVTmh5djR4eStTY2Zm?=
 =?utf-8?B?dk5KRHphbTVoZ2puZmZ3anVPRTRDNnJEdDQ4c0VmM0NETUJrbWlQbjF2MXRa?=
 =?utf-8?B?VGdvUXNqbzNUdmo0V3MwdVEybXhEVm9HSnBMbDl3bmp1NW1QcXVyR0pRd0xl?=
 =?utf-8?B?ZmJWZUVOV2pnemVGdWlYYTIrMS9LU0sxcHhjRzNBZUw4UlZta29neG5lMm5s?=
 =?utf-8?B?NjZNNHhRNjR0ZDg5T1FJS09xbWJITGNSdzJOcEwzVjhEaWlpYndZUDRNUEVJ?=
 =?utf-8?B?Zk91dEhrN0k3cXp0cFNCUktMcGxKT2tlZmJtaUlQQ2RlUGc0YVIyUkRNKzRF?=
 =?utf-8?B?UWE0UGxFZFJVSkpjS1VhUTE5ZTB0c3hsdFZTT0J6UEdhSG9xdjZiRUZ1Qjcw?=
 =?utf-8?B?dko2S05PTENPMEhaNkRJdk5ZSUhPTXZNMzJRYlYyM2ZVeFN2QnNhWkpUU0ww?=
 =?utf-8?B?VWE2Y1pSWTJOVEtnaklXUkozd0p6VFpuZDJIYWJCa2h0MXpmZ3cxYnZzUWY2?=
 =?utf-8?B?V0JXMUdHb2RVUkN4b3I2WGR4eE1xbis1OEdJOEZPUWkyc1dwaTNUdzJXT0M2?=
 =?utf-8?B?dnJ0MVZpRUU3c0R4QUJ5SU5rcHpzWERNWmQ4R0RXd1RES0hMekJybUZEdFdC?=
 =?utf-8?B?NGFDY3YzTEU2RmhzSmVTQXVhVm9rMUVSalFwbklHV0FZN05yZ3o0R1FhU2pN?=
 =?utf-8?B?SE1JNW56cU4yUjFLbGd2WElRWS9wY2JlVXYyaEgzOTI4N1BjdSt1SnRRbWc1?=
 =?utf-8?B?NkhyWGhxbm1mYUw2ZmRVVVZCK20wRDd3K2V2Vk9KMThncUhiVmQraVdCVlJQ?=
 =?utf-8?B?U1ZaMHF6Tm1CRThNRUxhTnl6Y2VuRmVyOTlvdzZhMWFOcThHNHNLdFZ6MmRt?=
 =?utf-8?B?MXBXbFZ3K015a1lYMXI4QjV6RGFpeFBSNmF5cHczMFNEZkhiZmlWc0lwNFNn?=
 =?utf-8?B?S3JFL3hvcVY5UFVLT2xwd2RiMjN1MENnZTliTDdwUjNaUThidFhSZUx5bTNQ?=
 =?utf-8?B?bnEzVHNHTW5pQkwyNVZKUjJqemJ0UjI4aWEwTWp3Q1JBZWxOOWJwV3l5QWlr?=
 =?utf-8?B?YW82bjNKaFdkV1kra21jZUgwSjJFdDNNVW9GeDVyQng0WTVWZTRXZ1d0K2t2?=
 =?utf-8?B?bHA1R2tZRnpDbDBtTFo3VlYwN1pKWlRsWWZyL3JIVys0czRDREVpM1pOWkRG?=
 =?utf-8?B?OUdYc2FWdERpN29aNWFvbnFZbWxiMUUvMUc2anNHbVBLV2wyS2czV0QxOFhK?=
 =?utf-8?B?ZG54ZkhqOHNjUHR1M2ZnUWJkMUk5b0VYYnRMcHZoMVY0LzJYL2had1NuQnVo?=
 =?utf-8?B?N2J4cnYzZ0NISUNzOTFJVHpET0V2UlRRdlplS0QybW1NZEkwNllpZm5hZUNM?=
 =?utf-8?B?ZVVJZ0ZJT2xUVVFSWVI2NDVhcEV0YUxtZzIzTWJOSWtRMU9CYW9hOWxIN2Iv?=
 =?utf-8?B?RUx1U2pyRXB2a3pPNm9UMnpQNGtZTEVVMXpLUWNlbUd6cHgzN3ZudDM0UE16?=
 =?utf-8?B?Y1ZjYU9YTFZvYnFMZVFySVlmcFE0M1BRV2Y3U3BJZnRKQUVVdVplRmUvVVFj?=
 =?utf-8?B?ZC9KNDdFU282TEsxMjFjWG02MW1yZk9hTGxDaU9BRjF4VVpBSzNwTDlUU1o2?=
 =?utf-8?B?ZDNqaWRyNk1Wb0h3cGg3ZU5IRmprNS95RldVNDJTSkRZTmU2TjNYcWpHaURT?=
 =?utf-8?B?Mjl4YVNVR3k3bzVtSG5lM2QvUnRsWFhrdmVyTVhKSHpGVVowbVQvZUxpSHJp?=
 =?utf-8?B?SWFLaks1V3ROVENoVzVMTmE1eE1rRWptMm1oaXAvdE5XSjNHWnhIVHFsQm54?=
 =?utf-8?Q?ydQSqYcv5zY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YngxMENORmtVdmpvYVZpczFrVjM0dTBJaGRiSEZOaGV0WkRtR0tzSHFsT1BH?=
 =?utf-8?B?S3Zmb3R0U0lseG91QWpJRENjSjZBWWhxL0lLRFdJS0lHQUNKd1Nhb0VYd1Iz?=
 =?utf-8?B?clZsem9pL2tiald6dlB3MXJsR3kzZFFZTWlVTUFaNCtoQzNrM2pzWEFnbW9H?=
 =?utf-8?B?R29OeG42R0F0WGRWbGpIanJhYjU1WDRGOVk5TjhYbUJncFFnWFUxVzNvU3pL?=
 =?utf-8?B?N1dneitDL292eVgvQTlxRFZqbnRzRTNCbHhxYitRaHV6eHJjb29iWkF4VWNS?=
 =?utf-8?B?eHQxMlVGRkc5dHM0Z0NNZVhYa3psOHpSZ05uQ1NwTjBoT0hlRW16U1BtUHQw?=
 =?utf-8?B?NGVhcUpkYW85V3hTcWxFTHhQTkVIUG1lNG5FQWhxcDd1aXNiT2ZNNEVHSUJl?=
 =?utf-8?B?em9NSnFZNjdPa2o2UUhrdFR5cnlRQWxUaWszbDU4bXdZdEFOZFJvdDdqaEZW?=
 =?utf-8?B?V2V1RUlMZzZ0alQ4aHUveURDNE9SNU5TdHMxUmtDZnNJclZQK0NzN1FTUnc2?=
 =?utf-8?B?QUtjTzhnKzNRVkxZU2tQZE1Ia29aeHdLZVdQazFZTnMvbitQcVp5MTZSNVhW?=
 =?utf-8?B?OStJK0VSb04wUFZlbTUvTWNqcWFFcE9kdnhJbFlXNGRRV0R0eFhuVEdldXlS?=
 =?utf-8?B?SUQxTitiY1V0WDgwZFlFZWFBN2h4K3MyUkpVQURZaFlsVmtuN2RoeXFIZm4w?=
 =?utf-8?B?ekRHcUdJTnVqbDFBSDFkUDI0VjZuWU11WHRzRU4rT2laYWxCNE9YYUNNMzJz?=
 =?utf-8?B?eG9NYkFzcnJVSitiemlkN1lMbHM1WGpKazRPRVBCOFZiWnphankzdWJTMVNv?=
 =?utf-8?B?bE9PMFh3dzM1cHVVbk9uUzVZNUdSNjJHUVpFem9JcFNVYVhldHZlbWZHT2xB?=
 =?utf-8?B?Q3RneG5Da2M5clo1dlBCTjBpTU5MSzVXK2VVQzRpemw3Nk81L2wvNXNmYnN0?=
 =?utf-8?B?ZEM2UUg2b0QzRGJwZHlRWU1wL3lBZEFtTWF6VFVLcUI0TmtxN3drSGt3N0Zm?=
 =?utf-8?B?dEIvMHM5QUxpZXpQanJuMWt3d2p1K3BtSWxab25JcjhDK3BKcUpIanlCSVdR?=
 =?utf-8?B?V2NDSXFuLzhiT0hQckpEd0ZDZXM2Z3Q1Y1Jxam5sMDFsZURobWFzZ0Nab3pM?=
 =?utf-8?B?UnRPVzNPbnFzVEQ5MHhpVXhPVmkySjI3aVFCYUJmdU1rM0NQTGloVTlESVdV?=
 =?utf-8?B?Wk5ONmRZbHVtNTUxNHBHZjZCa2tEeHpQZVljVUEyeVQ3TEZ2SXlxelk3dkZW?=
 =?utf-8?B?MllETU9oNHRPWGIzVU80RGMzNzdUYk1LMGVUTVdxUEp2aXhjNmViVUIzMGZM?=
 =?utf-8?B?cmhYYjd5ZnBjd0FqaDl1TUExVGtFOEFtUW56TEkxb2dDSHpEN0Y1Mm5BTWZk?=
 =?utf-8?B?VlFaZG5hU0ZJNWRXRjdOeHZmZWxHK3Bxd3BzTld3RXJFZnVLaU4vSjFNcWxo?=
 =?utf-8?B?aFI2TkMxOWVSMHJoNGVLKy9KK2R0UlF2bnNTamFyQU4xZFFlL3F4emZyZzBv?=
 =?utf-8?B?UDJZMDdGVHNNemFyRkViVjhxY1psZytJZ2NaT3dZN0tNMmNSOTdkWVFYdHBh?=
 =?utf-8?B?YzR3dkVsN29tbFp3YXI3YnJtZ0ZxVmFGSHNQK3VUeTQrdjNUd2w3OVJJaUVF?=
 =?utf-8?B?OHhYZE1DeHg1eE0ycGFseVlPZWJtOTBvNDJ2ZHBMQnhhSWFpM1RpWWZtb1VS?=
 =?utf-8?B?MHcvZWM4L1hjZ0lsSmxMM2VnTGs4VmpkTElpQkJSSFBWM0plNmVsMmNyK3d1?=
 =?utf-8?B?RlNsdWlNSFcrTnlPUUFQSVFTa0ZaRWtENDA2a1BKVTVRVUU0dW9Jb0hBdHJB?=
 =?utf-8?B?WTA2cUJQYnREQit3TEQ3QWdIcS9KVGtsRzYxY0I5N2E4ZGRBN3Jpem1RTmZM?=
 =?utf-8?B?V284d0srQ1NSNGo5SEVId3VaS2M5bERnUFU5cFR2cUpXSE16YnR3ZzBCbDV2?=
 =?utf-8?B?M2tWMzZlKytwclVGWjJlVUhvd3RsL0g0V2VKM3U1TU9jVy9jV2UrQW1OSUNu?=
 =?utf-8?B?VFZ6UklrdmFPcXZxN2pCQjk0RlY5QWgwS1cwdGUzRVo2Ly9sdG5RZ0U5ajRQ?=
 =?utf-8?B?QkNyaHc0dEwzREhjUWU5aERTMlFxaDVnb0NhRlNZeXlIbGVNZFdFODB1eFha?=
 =?utf-8?Q?JuKPQQ5MHtIK10tSr3C/xy8LQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ba5d15-ee0e-4ed1-5602-08dde50118c2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 00:31:43.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIN80vyW0mkdpbjJLsRZBPkip7MR3tD6RMTesGgZA59UqwvwAfR3hYVYrRjO6GMXd13uZZClvMM4bYcnTDCrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

On 8/26/2025 1:10 PM, Lizhi Hou wrote:
> 
> On 8/26/25 10:58, Mario Limonciello wrote:
>> On 8/26/2025 12:55 PM, Lizhi Hou wrote:
>>>
>>> On 8/26/25 10:18, Mario Limonciello wrote:
>>>> On 8/25/2025 11:48 PM, Lizhi Hou wrote:
>>>>>
>>>>> On 8/25/25 14:28, Mario Limonciello wrote:
>>>>>> On 8/22/2025 12:23 PM, Lizhi Hou wrote:
>>>>>>> Add interface for applications to get information array. The 
>>>>>>> application
>>>>>>> provides a buffer pointer along with information type, maximum 
>>>>>>> number of
>>>>>>> entries and maximum size of each entry. The buffer may also 
>>>>>>> contain match
>>>>>>> conditions based on the information type. After the ioctl 
>>>>>>> completes, the
>>>>>>> actual number of entries and entry size are returned.
>>>>>>>
>>>>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>>>>
>>>>>> How does userspace discover whether or not the new IOCTL call is 
>>>>>> supported?  Just a test call?
>>>>> The kernel header version will be used to determine whether the 
>>>>> application which uses new IOCTL will be compiled or not.
>>>>>
>>>>
>>>> But it's not actually an application compile time decision, it's a 
>>>> runtime decision.  IE I can compile an application with the headers 
>>>> on kernel 6.18 that has this, but if I try to run it on 6.15 it's 
>>>> going to barf.
>>>>
>>>> To some extent that comes with the territory, but I'm wondering if a 
>>>> better solution going forward would be for there to be a dedicated 
>>>> version command that you bump.
>>>
>>> For in-tree driver, I did not aware a common way for this other than 
>>> checking the kernel version.
>>>
>>> And here is qaic patch of adding a new IOCTL.
>>>
>>> https://github.com/torvalds/linux/ 
>>> commit/217b812364d360e1933d8485f063400e5dda7d66
>>>
>>>
>>> I know there is major, minor, patchlevel in struct drm_driver. And I 
>>> think that is not required for in-tree driver.
>>>
>>> Please let me know if I missed anything.
>>>
>>> Thanks,
>>
>> Right; so bump up one of those so that userspace can check it. Maybe 
>> "minor"?
> 
> I meant for in-tree driver, is it good enough for userspace to just 
> check kernel version?  E.g. The drm driver versions are not used by ivpu 
> or qaic.
> 

Just because they don't doesn't mean you shouldn't.

Take a look at what amdgpu does for user queues earlier this year for 
example: 100b6010d7540e

This means that a userspace application can look for that minor bump or 
newer to know the ioctl supports user queues.

