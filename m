Return-Path: <linux-kernel+bounces-759975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F541B1E524
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481A41892EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788A266EFC;
	Fri,  8 Aug 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CDs8LWOb"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012064.outbound.protection.outlook.com [52.101.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FE25484D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643583; cv=fail; b=CBamsbi0Pg3QyEtNuvMLOrMUpMTsQBLPcxeWtPzN1GeDUP0qs84x/WOzsYE3u7TGNL+ZKzbmRf++cKu3/krD/+CobuTvOg558IabLkj+uhjzmFZxBM6P1PKTghKKKG1fkouv3ZKhc+NhDOTA2T1lrzMmkrYkToMKqdp770NxRQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643583; c=relaxed/simple;
	bh=Ffd/s9jD2Vkj1E4TAt+1cJa3pJpz+kG3PllAvYull/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xp+QlkSQxji/Wq/ybQcL1NaxH93JTB9FYIysDTh3I8526DkFGSIEhzu6wIhVtukS3WXDF/fuSt9zgBRE2qAnVF9BrwQikNZ5/kRrjy/o/H6J1TpuUyOUc5fKRUt/wBon4KyhVsnLkVzxodg31Jd5DCXBXvw9py0SBF5y1rffmXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CDs8LWOb; arc=fail smtp.client-ip=52.101.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8kQ55ZWsYMvVwOMewiq3cPkLJPRFHWYM+fQrra0mU6sQ+Loo7y7DiHLagoSyGVCs8mon0xoe/h+sWNOd7zU/n3lS4VaeC4StWG6vQC5eWKSPiSlQNLF4zhMZJB/cKoTu/tU1iKOxriAGhC+7xlr0DNM8mm0OuKjqr/C4z/VbHT5H3myAwjZvx5Jv/MLD5/3aMLnuLG8XKVSPtLpvT5dIOOhlBdkSHwdIuh6hpogQ4g6w64l7cwsFljsBuLaSHktyyfW/3p/vuEQQWAowVWZInSJElJceqksU3lxefdAUfNUO1NfAbgsK5eAtMWzl0IhpnqZ/io03KERI2ZbQwCYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35vnqT0Pwb7/ULCRChoERa/pUTomL/D4RodpISeDTdg=;
 b=daS8BgO7qz2xkUi+mLwdYE4O4EbSd7hrUBKrRCXNJYsIIBpZ+PgUgqW35G0OCPDo/I9eWlDEdMVeS+BXEhzy5C5o5mIyCCDKwK0AwYXDmHmlvKPdmsX5R2dyAEg2AnGb4pxognLYNk/ndSEldJOMbYuZCkHFEulIzuIuydk5/PS4UxhCDdciH3ODYm/X55PYxeVTU6txHeJf5kF4xa6p7E37awAIfOzUIVRjmPxXuO4gWzy+z/Y7BU2RQznBIv3xrOqbRZgeyVEbg0iPXOA84xavyPk0KXqGgTRmq25i/Ma2E0zUBQWMq8HoqOKWOumMk2byO8W9Fv1yoG3nwFZpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35vnqT0Pwb7/ULCRChoERa/pUTomL/D4RodpISeDTdg=;
 b=CDs8LWObWKvyd5HtASoley4oj27xL8mrRc92PN/VF3dPuvuWwhqm9PVeRPXHwr5EVilU/FiyGv4FK5nyKNrsX7NXjxDV6h4NIEqQ/RNuntV0b94g5uswtSBlzkGlUXmwzeZ7EEZCHFIILmizJss2Yi1dFm8QteGxKB+sxI/KmWwknAHZv3iEK06dk0Rq6Ru4ZE3n3gr/Sz7pAjetgb5AKNSJJhsaK6gKySWx9IWpS0jUtakdLcUWZ5INnJBWmAodfbELUeY5xh+UlqOCLcoazygJchSBcphTs+B5J5WSsQNat/hRXPwMeaYynZsdlVOGEDSAXZoYkypfh+9B+nIf6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com (2603:1096:400:32f::14)
 by KL1PR06MB6041.apcprd06.prod.outlook.com (2603:1096:820:cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 08:59:38 +0000
Received: from TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263]) by TY0PR06MB5579.apcprd06.prod.outlook.com
 ([fe80::4f2:e048:7c93:f263%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 08:59:37 +0000
Message-ID: <ef339cbb-5179-4c4d-9315-d331e3a8f31d@vivo.com>
Date: Fri, 8 Aug 2025 16:59:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] f2fs: Add bggc_block_io to adjust the priority of
 BG_GC when issuing IO
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250808072939.202357-1-liaoyuanhong@vivo.com>
 <459de7d9-970a-4921-b16d-d8ee658f86a8@kernel.org>
Content-Language: en-US
From: Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <459de7d9-970a-4921-b16d-d8ee658f86a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:1::20) To TY0PR06MB5579.apcprd06.prod.outlook.com
 (2603:1096:400:32f::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5579:EE_|KL1PR06MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5361a983-6ef3-4847-da10-08ddd659e6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpZMnhBd2lxbFJ0WXdFNVlKc3MzNmVheGNpWHNON21abzV6T0FJaTNxd25N?=
 =?utf-8?B?OHZwYjd6RXczK2NpZ24zWnJoRGJEWDFZbFVjUTQ5dXFQSzRLMVRLKzdHN0FM?=
 =?utf-8?B?Z1Rkb0Fia0FRbEVaVlU2cWJMd205ek9YU0RBODV4VW1OdDM3WDhPczZWTnMw?=
 =?utf-8?B?MlJrVFBJRUIweFlSY2xoTUIzNFpzbDZtVTBtd2lyLzhPeXVvdDJ6ZmlrRTI1?=
 =?utf-8?B?cTlmcngrVlY1WUF0dFphNVZQa3RrcXM0dWtlTjZ6cnFWRXhvcXQ4emlrKzNa?=
 =?utf-8?B?bEppLzBrSzdyUlNSMW5tZnYwUHR3NkR2S1YxQ1BENXNtMVc0dEpUaVBOMDBs?=
 =?utf-8?B?ZVBIZFZGZkExbGU0MzJzZG5uZUYzQVl2cmVZNWJpMFc3dTZXL1Vya242eDhm?=
 =?utf-8?B?aWN6S0VmUU9va0FQZVBrWVJ5Q2syMW9pRkN4cVoyUzB1Zkw4ZE5nSzZxanQ3?=
 =?utf-8?B?Z3cxQmxzTGhvQ3VRS0sxQisyNkFIYWZaVER5RmxNSkNTei93c2p1T3N5Ly9P?=
 =?utf-8?B?dXlrd2xHN3BYM1JPOFliTlI2YlQxTkJSSmlVUFdEVlhRSmZtcTJSY2hmVFY1?=
 =?utf-8?B?VU80cFJxNFYyN05nZmNLR3Y5NHZxMlVLR1k3TkNrZlRiNkxvQmlZc2kzUDFE?=
 =?utf-8?B?UXRsU1dVWWVrQUVsaUZTNU9MbjhJMUJSejlvS2ppYTdnZDl1UG5NSjV3VEVz?=
 =?utf-8?B?N3BDV1I2andkekZ1Vy9SRG4vZmxXRDl0ODZmRVVBQnkyQVVHRHMrc0hucGNK?=
 =?utf-8?B?MG4yTS8wcDUxVUltV2JRZFdFS1YrblV6VWk3NE14ZE9tanF4ejdGWGNIMHhD?=
 =?utf-8?B?MFNJb1FJaHlhbnpjcXlmaS91TUpVYXdXUE4yMHVldmNQNzNaSzJRUGQ5cFZy?=
 =?utf-8?B?d3J1MC9Kc25NaitFTElpTitjOUx5Z3pnRmcwdUtZWXlLS3BRaWpyMjRPUjVY?=
 =?utf-8?B?OG85d0JEM3hFWGxMSlhEdXc4NW5TVExVM3p1aWxDUkY0NHArajE0UURyZE9F?=
 =?utf-8?B?dHBnU1VGdEtPVnYxVmFwTXhGeWRWTkVoS0srOVltKzkvZkpaZ2lCUklSWEtN?=
 =?utf-8?B?SlE2QlVXVjBwUmVpQUM5aW5JVmVYTGpORXFCMGp1MStHVnJQbklaYzQ5TnBT?=
 =?utf-8?B?eTVaTGlySVB4bTNsZnAxL21rVGg2M21TRE9MSDc2U3JpSTlkNVJ1bnUrOVhl?=
 =?utf-8?B?RmVDQ3VGRVB6dndhR1FnRlh0UkhibGRFSzVYZHpYUUdYaGVPaEZrS2w2Q3VQ?=
 =?utf-8?B?eXU2MUZ3SmlGYlVuM29zQk9Melk5dkhZalJ1RTBtNTBrUDh5N2ZwTXZsR1M4?=
 =?utf-8?B?ZDRjelVma2FmY2Q0MHg3SnUyVkkwUk44eGFkNVl1M0N4dGFtVEk2cWdKaC9Z?=
 =?utf-8?B?N000KzI3ZmlMSjJvNzg0dHA2UHNFTHNoUGlZQU50RlBaeXFsZmtlb3d1VlYy?=
 =?utf-8?B?U0tvc2l1NkI5U0pZYjhqNlVlS0F0VkNCWjZTV2gyUmMvL05QNDFZc1RaMXRl?=
 =?utf-8?B?UXNYVkZFeDhFTUQzVnIyRTlzem9hOFVPdnF5T01wMWRQYk9qNDhhaHh1UGFz?=
 =?utf-8?B?OVhVK2kzOHJUdnM0RklUWkNqWVJWRFdJRWtvaDNWWXZJTHJuWXFGc2FTY0NR?=
 =?utf-8?B?RUhpUm9wWHhjb1pvWW9vSVVEYlhDeTFoZ09Ra2lIUnlhZmM3bjE0N0RHTDRq?=
 =?utf-8?B?WkcvVmNpejJKSW52T2ZuRXNkQ2o3RC90S3dqLy93VjNpdVRxRHhvZkFLc0lE?=
 =?utf-8?B?SDU4UXRQd3hmS0RZRVRCRUJTUmF5cThxNGJuY0J1TWFBSlJuc05GSUtUWElx?=
 =?utf-8?B?WllGZWFVZjNhMFNvVm92M0VLTjRZeUQvVTd1Qm5DUFZKQWY4S0RydnR4MFJy?=
 =?utf-8?B?SXlqY0hiRm56WTVubWZhbkVhMkpuTEhiVGRtN2hsOTQrenc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5579.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2h0UWJqVGxPR0lxY2RFK3RLZGpVc1E0Z1lzK2pRSGZ4bXBDVmpEMGNiUmN4?=
 =?utf-8?B?WU5LSVhwdC9EM3F6S1J3SGI0V3UyQ2NxR3JCUHR1TmduWVFmYitGRnhqSmpR?=
 =?utf-8?B?dUhoTXdBc2hhNWJSdWZTbzhtL0pzaDQxdS9iTTJZQXpGS0w3akt1WmhuTFlo?=
 =?utf-8?B?YzhDdm5pdkNSZ2IwZ25jcGZ0UFlEYjJuYkpVK2MybnZlU2dKdUpVdHU1Z0po?=
 =?utf-8?B?MCtleklBNWZEdUd2KzhJS1E5VHZFZ0hnRTRYRHduRnR5SlRqbHlORWU5TGY1?=
 =?utf-8?B?ODBrTVhZTVFyTlZvSGN1UFM3NUdJOFErZmM0VGRmUzlKNUpVOVlTU2NPMnlW?=
 =?utf-8?B?eHo2YjNjZlZIOUdtUSs2WEZRVzhBaTc4MDZrSUtyR04xVzlqV2ZuaWRqRWpK?=
 =?utf-8?B?dDNFMHNQTWpNQ0ZxUWhDU01iTW5kREh1WUZMSTVtNXVoUnBtU1h5ZUtlZzNa?=
 =?utf-8?B?eTkrWmxBazMwOElEMVBCNDJWMlZtSFlvdjRmNkxmMDRDV0VTMmhHUXdTa01h?=
 =?utf-8?B?U25Ibk4rNnAwWG5UMUhNaGRnSVZIdzFCSzJibk14aTBOWGdGT1VYbFFXdmMw?=
 =?utf-8?B?SjlVb1ltY0NHVGxPSWkyREYrZzZ5d3ZqeUFoTEMySGRZQWhhUXdvNUp5NzBh?=
 =?utf-8?B?aFV1alZuVDlTVEVoeU9TYjh5YzMwc3lJakJjZ2d0Y0lXR1NUeERXbStwNHJs?=
 =?utf-8?B?VHBseGRnTWJoM2VOcDhQRExSSkdFNlpjL0VYK0YrNTAyeWtLcDlodGlna0tj?=
 =?utf-8?B?NUJOQk5KdHRqTVR5alJGOUp2eG1OL2hCbTZIYXpOdEhpcmUzZWFPTjVOZHFN?=
 =?utf-8?B?ekxOZmFiSjNBYzM4ME9hNkw2UWNwNXBMZVNyclZaMkRRUEYzTmNJMFAweC91?=
 =?utf-8?B?L3lHR0liWFpnUXI2R1ZZTzJtU3VoUXdJMHFaTDNINTZTR0pNc2xoSzczclg5?=
 =?utf-8?B?Y0pKa0tXZEdEaGxhRTBlVDBQczZGMWo3ZjlteW85eSt0bkZZOUxvZUZNM1hR?=
 =?utf-8?B?TjVMVUZuT2ZFem0xWnlRRFh5cVRaNkNFN0NLeUI4OVRCNjNpRDZrNHNaZTE3?=
 =?utf-8?B?YkpsY01RQ29PMGJ5RWltL0F6bkhyVngyTHhRaDVyYUJoOW5RYzQ4L2Z1ZVZj?=
 =?utf-8?B?aFBoYVpSWXJ5cTZXcHBudWEwNHc1K2I3MmVqS0h6VThJVzV3VnJzNWR1Y3FT?=
 =?utf-8?B?Yk1GTEZQdC8rZzN0cjdxZHZQM3g5eDYza01TVkhINWFqMXFsY00yZGZPQzg0?=
 =?utf-8?B?Q2JoWklFSS9TWEc4UnlKVkJEbEJKRzhLTEtmY2ViRTFSSExtZTV3cHU5WXhC?=
 =?utf-8?B?MTRCMjk1NHhpQnNReDljbUMrYmloQlpmOW1NU1ZVV0hOVGdoR1o4QTl6Wnpn?=
 =?utf-8?B?ME1MUG9XMTRiNW5SelF1RFlJTmlsZzVLYndCb2czd3ZsVStLUklhbW5BK0I5?=
 =?utf-8?B?cXNTeG5DQU90SzEvL1hrNWM4QmIweStxQ0lXNldOdE1tem80Rk9MRnYyVXJN?=
 =?utf-8?B?ZFVObjRZV1RrbktSMWR2RWIrTTk3am1kd2o3Zm1NSi9pa2NFeW11U0h4TG5Q?=
 =?utf-8?B?U0t6aU9DcXQ5U0FyaWE1WWZsRVFkZ3NTRHJDRlhCV1lsN1BrMk1KeTlaSElN?=
 =?utf-8?B?QStnaFVyY2lIYlYwcTRvMFoxV3BPZ0NnOHN1MFJRdzArTkNUYkVUN2lhOVlp?=
 =?utf-8?B?T0hOWU5QRzRETUZEZmZpR0F1OXkvTDZVUXBqUzdyaHhiOHRkSUd5RTJhYzI2?=
 =?utf-8?B?TXJycHpocjE4WUl0NmtVaEZHYkxjQ1F4M0ZlUTZZTzBpblRlV1hiNHI3YmZE?=
 =?utf-8?B?Tzk4bFQ4bkd4cnBpb2kzRTl3a2I5VG9kOFZjTUEyTzkyb3gyQ1dpTHRmTWhT?=
 =?utf-8?B?N1RwVkw2dUdpa2lWaUhiTitKSUVtZEt5N25ndzZ6Vk9NOXJnaUk3WjhkSHVh?=
 =?utf-8?B?SkxwNHRsVE5nWk9xQm42dHJYemlsR2YxR1NjeXphYUViWHRGZjViMDU0cWJ1?=
 =?utf-8?B?aFJpMXJYWTNvU2JwME03Z0pHOVc4YlpwMmtZdzBPQmVSSksrbUhObTRoc0xu?=
 =?utf-8?B?N2pFd0dla3RVK1NxdEdkM2MwWjhOS3planVoT2YvZ2ExVjNyQzNMT1dEbWs3?=
 =?utf-8?Q?/nxMXUBBLGqBK51m0L8rrgObd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5361a983-6ef3-4847-da10-08ddd659e6ed
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5579.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:59:37.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIHyNraBPxV9+rDxXKhm5lUM76jRoQnomHD10VS5FjmbmSoLBV+3Sai3tzUuFI0dV6ZlDOai38ro2Ivmr62MEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6041


On 8/8/2025 4:51 PM, Chao Yu wrote:
> On 8/8/2025 3:29 PM, Liao Yuanhong wrote:
>> Currently, we have encountered some issues while testing ZUFS. In
>> situations near the storage limit (e.g., 50GB remaining), and after
>> simulating fragmentation by repeatedly writing and deleting data, we 
>> found
>> that application installation and startup tests conducted after 
>> idling for
>> a few minutes take significantly longer several times that of 
>> traditional
>> UFS. Tracing the operations revealed that the majority of I/Os were 
>> issued
>> by background GC, which blocks normal I/O operations.
>>
>> Under normal circumstances, ZUFS indeed requires more background GC and
>> employs a more aggressive GC strategy. However, I aim to find a way to
>> minimize the impact on regular I/O operations under these near-limit
>> conditions. To address this, I have introduced a bggc_block_io feature,
>> which controls the prioritization of background GC in the presence of 
>> I/Os.
>> This switch can be adjusted at the framework level to implement 
>> different
>> strategies. If set to ALL_IO_PRIOR, all background GC operations will be
>> skipped during active I/O issuance. The default option remains 
>> consistent
>> with the current strategy, ensuring no change in behavior.
>>
>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>> ---
>> Changes in v4:
>>     Adjust the default policy ALL_IO_PRIOR to 0 and modify the 
>> description to
>>     match this change
>>
>> Changes in v3:
>>     Modified the issue where it does not work after closing
>>     CONFIG_BLK_DEV_ZONED.
>>
>> Changes in v2:
>>     Non ZUFS can also be adjusted through this option.
>> ---
>>   Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
>>   fs/f2fs/f2fs.h                          | 18 +++++++++++-------
>>   fs/f2fs/super.c                         |  2 ++
>>   fs/f2fs/sysfs.c                         |  9 +++++++++
>>   4 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs 
>> b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index bc0e7fefc39d..21e6951919de 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -883,3 +883,16 @@ Date:        June 2025
>>   Contact:    "Daeho Jeong" <daehojeong@google.com>
>>   Description:    Control GC algorithm for boost GC. 0: cost benefit, 
>> 1: greedy
>>           Default: 1
>> +
>> +What:        /sys/fs/f2fs/<disk>/bggc_block_io
>> +Date:        August 2025
>> +Contact:    "Liao Yuanhong" <liaoyuanhong@vivo.com>
>> +Description:    Used to adjust the BG_GC priority when issuing IO, 
>> with a default value
>> +        of 0. Specifically, for ZUFS, the default value is 1.
>> +
>> +        ================== 
>> =============================================
>> +        value                description
>> +        bggc_block_io = 0   Stop background GC when issuing I/O
>> +        bggc_block_io = 1   Stop background GC only when issuing 
>> read I/O
>> +        bggc_block_io = 2   Prioritize background GC
>> +        ================== 
>> =============================================
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 46be7560548c..440542ea0646 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -155,6 +155,12 @@ enum blkzone_allocation_policy {
>>       BLKZONE_ALLOC_PRIOR_CONV,    /* Prioritize writing to 
>> conventional zones */
>>   };
>>   +enum bggc_block_io_policy {
>> +    ALL_IO_PRIOR,
>> +    READ_IO_PRIOR,
>> +    BGGC_PRIOR,
>
> Hi Yuanhong,
>
> Just nitpick, :)
>
> A little bit confuse for BGGC_PRIOR naming, since it won't submit
> bggc IO in prior to other IO, just not be aware other IOs.
>
> So, what do you think of renaming as below? Keeping align w/ naming
> of discard_policy.io_aware.
>
> /sys/fs/f2fs/<dev>/bggc_io_aware
>
> enum bggc_io_aware_policy {
>     AWARE_ALL_IO,        /* skip background GC if there is any kind of 
> pending IO */
>     AWARE_READ_IO,        /* skip background GC if there is pending 
> read IO */
>     AWARE_NONE,        /* don't aware IO for background GC */
> };
>
> Thanks,
>
Thank you for your suggestion. I will submit a revised new version.


Thanks,

Liao

>> +};
>> +
>>   /*
>>    * An implementation of an rwsem that is explicitly unfair to 
>> readers. This
>>    * prevents priority inversion when a low-priority reader acquires 
>> the read lock
>> @@ -1804,6 +1810,7 @@ struct f2fs_sb_info {
>>       spinlock_t dev_lock;            /* protect dirty_device */
>>       bool aligned_blksize;            /* all devices has the same 
>> logical blksize */
>>       unsigned int first_seq_zone_segno;    /* first segno in 
>> sequential zone */
>> +    unsigned int bggc_block_io;        /* For adjust the BG_GC 
>> priority when issuing IO */
>>         /* For write statistics */
>>       u64 sectors_written_start;
>> @@ -2998,13 +3005,10 @@ static inline bool is_idle(struct 
>> f2fs_sb_info *sbi, int type)
>>       if (sbi->gc_mode == GC_URGENT_HIGH)
>>           return true;
>>   -    if (zoned_gc) {
>> -        if (is_inflight_read_io(sbi))
>> -            return false;
>> -    } else {
>> -        if (is_inflight_io(sbi, type))
>> -            return false;
>> -    }
>> +    if (sbi->bggc_block_io == READ_IO_PRIOR && 
>> is_inflight_read_io(sbi))
>> +        return false;
>> +    if (sbi->bggc_block_io == ALL_IO_PRIOR && is_inflight_io(sbi, 
>> type))
>> +        return false;
>>         if (sbi->gc_mode == GC_URGENT_MID)
>>           return true;
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index e16c4e2830c2..a21cecc5424e 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -4629,9 +4629,11 @@ static int f2fs_scan_devices(struct 
>> f2fs_sb_info *sbi)
>>         logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
>>       sbi->aligned_blksize = true;
>> +    sbi->bggc_block_io = ALL_IO_PRIOR;
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>       sbi->max_open_zones = UINT_MAX;
>>       sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
>> +    sbi->bggc_block_io = READ_IO_PRIOR;
>>   #endif
>>         for (i = 0; i < max_devices; i++) {
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index f736052dea50..1b587908f049 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -866,6 +866,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>>           return count;
>>       }
>>   +    if (!strcmp(a->attr.name, "bggc_block_io")) {
>> +        if (t < ALL_IO_PRIOR || t > BGGC_PRIOR)
>> +            return -EINVAL;
>> +        sbi->bggc_block_io = t;
>> +        return count;
>> +    }
>> +
>>       *ui = (unsigned int)t;
>>         return count;
>> @@ -1175,6 +1182,7 @@ F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
>>   #endif
>>   F2FS_SBI_GENERAL_RW_ATTR(carve_out);
>>   F2FS_SBI_GENERAL_RW_ATTR(reserved_pin_section);
>> +F2FS_SBI_GENERAL_RW_ATTR(bggc_block_io);
>>     /* STAT_INFO ATTR */
>>   #ifdef CONFIG_F2FS_STAT_FS
>> @@ -1303,6 +1311,7 @@ static struct attribute *f2fs_attrs[] = {
>>       ATTR_LIST(discard_idle_interval),
>>       ATTR_LIST(gc_idle_interval),
>>       ATTR_LIST(umount_discard_timeout),
>> +    ATTR_LIST(bggc_block_io),
>>   #ifdef CONFIG_F2FS_IOSTAT
>>       ATTR_LIST(iostat_enable),
>>       ATTR_LIST(iostat_period_ms),
>

