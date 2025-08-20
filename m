Return-Path: <linux-kernel+bounces-778181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE3B2E245
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498655E2A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3932A3D4;
	Wed, 20 Aug 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LHgcLitz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746D32A3FA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707266; cv=fail; b=L0+M/6KYWh5BfoB40Pv/5G+70YuB8KD2EbJ3KwbAEyNVP/Vscfgzf4QwnBYrjJdXBzsuHQaiWcewsGNf32eYJ9ZWgt6F4G9hH7ncUaLoT1KfR5uuqyVekbQPU+MP6qkKlnFzJyfUed5nfiYD8Q7bS2hfOniq52h+zYGP5hvJlg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707266; c=relaxed/simple;
	bh=Vv20lLFJbgyjrcnrxvwkVoUoBrnJ0XfdOzQ2rUxQFkc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hgBKM1wfc7Xmzk20lEW+CxyzyIQs0yhuRgE+sSBey7DnnNkOLG5CcOzHsJaEOIVNsU1ZFeWIZ/opw3hZItl1FZw87XHz+hYBJd2OpfnrTAi9MUPqEcsyIUqNOou4/qsyLQCImN44pQ0ygzZ5e00/AQGxu6aZW5MaTxUdoPgqrKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LHgcLitz; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DesATU+3gfDY2F75C13haul80TAlMK+mfbPfdQwyzmHQe8pxWTKH+CgCytOBIDMNOf96RZ57Mm0AOxR30XGSkRnS4Vt2snDiwaka5GLtp023bojjeV9+b8gyQNbdyX2QNWgcu1nZYmwO9EZ8Jp3bAwHOoygwrBOHR3oJGLlbhB6iDJ0OJ+S35jAQGt87VC+YYwrP5ouCxgi7yaE7qZo+d3m8179U6oGEPjKsEHe41q7YXwbiM5kOG0oXdSpGra9S+0xxSsYrdfG1hMQ+dt7P6wtbemVoRN29Pj/Lf1RujXNNt4/2J5yyqN3fFG6xgUk7Bruc1LV7DjSV6WkJ4/nHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ieraqIcNhhoQUlpdnELGCdyGLe0KkaRnICZKYSJhXI=;
 b=NumLZAf2UESEmHtLSUkpSs65UDUR4atim6m+mIPETOzA4zlT3XkTqPCoyh9y+TVAgxXcw8eOa2NgFdBC2tBNAIWBdPs6st1XcmChTLolruKzU2wcLCqS1eXhrR9oYY8teoPcrkflFbsjNY85mGIvbYYa+TXyG8eOz44XkF2cIDUo1ntqJwg9wsMpw7xFAWrhIFagbpQIDEfAS7Xr+rEEK2RWJV98J6cMbRRYnE05oq+gbBbT9hZpinYRyC1Qf/tZzNwEpBy/LZF7Jh5TFsumdO4mj3lKInrwMG/GuBokoUfxMRjcCMRWLd8hMF0il+Pnw+KTtjl8sVEny3ol0x9AnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ieraqIcNhhoQUlpdnELGCdyGLe0KkaRnICZKYSJhXI=;
 b=LHgcLitz4gcCyeQAgeWlRyVX3elIDXX3hmNLEYpH3tnHM4uhskSInF9R3JiyeEuIDcJMQWucrqByBnjotBLxgWeYunAYDCcfm1yZUBvBR4VCncnuFkUp+F/RnNOB/tT638AOM5x3IOXinT+gi/xBfNCpy/zUKygGMEQ1/x4DT4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:27:39 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 16:27:39 +0000
Message-ID: <3c22983c-6aa7-44ef-a368-17ff9d96fb9a@amd.com>
Date: Wed, 20 Aug 2025 09:27:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pds_fwctl: Remove the use of dev_err_probe()
To: Dave Jiang <dave.jiang@intel.com>, Liao Yuanhong <liaoyuanhong@vivo.com>,
 Brett Creeley <brett.creeley@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "open list:FWCTL PDS DRIVER" <linux-kernel@vger.kernel.org>
References: <20250820124011.474224-1-liaoyuanhong@vivo.com>
 <7350db53-d5e6-4b3e-8686-3749353725a0@intel.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <7350db53-d5e6-4b3e-8686-3749353725a0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cf0f09-feed-4bfa-3922-08dde0067aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU5ZcWFUYjNuREZDVzRrVlRqUS9RcHFUVkxOZXN6eW0xcERadHAxd2lwdFpB?=
 =?utf-8?B?d1pseXpQNFRBeTJTUHdSTFRONmFmVWdSZ21scDJCTEJWcm5RdG9xV2NlZDVo?=
 =?utf-8?B?ZG82S2VveG5FZS96a0R6dEY0WVdubVZUdkhhYkNPSGhZOFo2TitlcUlYMGUz?=
 =?utf-8?B?eEgyZC9kVHBZaThyaWt4b3R3ZVEwV3h4b0pQNmNtZVlnWndaNlcvMVp2NndC?=
 =?utf-8?B?SzVYWVhxc0JOZDBFWFBjYkl0MnlHaW5FdWZpTFBXMTcwK05JRGVOQm9QUnN1?=
 =?utf-8?B?dXpkT3ZWSlRMbXNkcHNwUnlEYnpxVDFjQWk0MytBTXd3Ny84cWNBTzY1WVVi?=
 =?utf-8?B?MjN4ODhaalljZVV1RHpMeFpLSHg5dm80aFlVSk9Cd25XSG5kemloRUJmOGJ2?=
 =?utf-8?B?NzlZQlhyMmV0eHNvL0FrOS8rSklQTG8yVGU5Z01jelRud0VEWlh0cXB5TTJG?=
 =?utf-8?B?dVNuK1dQeGwxWjM0UHR3aUZTREVyVzdLS1YyLyt3bndiUVhnTVBXeEpwZnRn?=
 =?utf-8?B?OUVwRXQzZEdJQW02V29COWdNbWNFcHlRa1NEZ3hzY3FEYlhBdXNoOElTYVBo?=
 =?utf-8?B?OWg2cXFjMi93WDU0UWNsMktXZDl6WS9wSGtTWStJMzF4Lyt6Z0djZlc3dWgx?=
 =?utf-8?B?ZjdPUHdHbnF4eTF2SWVEVkxtNFRyNzgxYXFBWlo1VFdXZGYyMVJxMnlPSVlk?=
 =?utf-8?B?cVBoSXVvVWVCSXUzOWVxQU9XNHpWOEw0b2RKTHVobS9CV1gwYXlnTFR1dzhX?=
 =?utf-8?B?RmlBRDdlUms4NUxZVXkrTzlrN3hIUjhnVlVOcW1wK1o3UFdyQmlUQ1U5amRt?=
 =?utf-8?B?YnBTRndoaUtOTEx5QjRvakcrRkp5M2liY0VmVmNVTDQ5VTlSamRuWEhlSjFz?=
 =?utf-8?B?RGlkMGszTmp5VER6WXJFb1FESGNQN1FJL296QmhRaUlib2lVWnhGMFIreStL?=
 =?utf-8?B?azd6Qit5Y0s4SkdpWWY0bEtxZ0NyQlBVN2JDSkZqR2NWdUNlK0VLSi9vNmtX?=
 =?utf-8?B?Tk13eDVFRGF3a1Y2NkxJekRyS0pETTRFZ2t2UE11bEZFcHY0aWdoOTZWMk94?=
 =?utf-8?B?NXBaekU4OWhVRmdoeVI0REdUdEJTcFVmQ0czbUtMcFIxN0VsMGUvWWhtYlRW?=
 =?utf-8?B?eElkTW50VFNzeU1PSFlTRlFnSnNtTlBtVUNyNE1MK2ZPRUdrUVRFd2NHUzhZ?=
 =?utf-8?B?NkdkanozUnpkMVg2VjI4U1RtSWtGdVNqaENsTmxSUjhUVzdOTW8rWGZqNXha?=
 =?utf-8?B?VFVNU3RXd2VyUEdMUURiNlBQeStIc04zc0dPc29KQ3lrcmZnaDd1azBiL2Fx?=
 =?utf-8?B?L045dWNXY2RxTmFwaU94ZXlSMWk0WE9NSE03Y2NORUNuRjJ0S3RBb2VWSW93?=
 =?utf-8?B?Z3lJTldxVXhKVG5zTTViV3lWOThQakxLeTJrZVA2WVYzblZMaFJUSytTQTNQ?=
 =?utf-8?B?bjFFWWp5NUVvZjV3U05MWHJRcGZMUERFTTFjSjNCWVk5VW1HdWYrZ2F4YSs1?=
 =?utf-8?B?Nnh4SU92a2RSQzRFeXZabGJwTitqYnNjdHQ1ZkhHcW9ra3AxeG4xbStQektp?=
 =?utf-8?B?Nlo3NjNVS1JUZTEyRVVacFViQi9NUnU2bXB2QnFIT2xOeXBsZDZQOTQ1Z0RH?=
 =?utf-8?B?UmtQV0lxTFp2N05BdzFKeG9YMERrc21BSlRUTzJYT21qL2x2cTk5S0h6bW9m?=
 =?utf-8?B?amlEdjJremRtakprQktPVXpmWExVM2tTUnlEZTVkZTlUcG1tZWFXR1RLMWJo?=
 =?utf-8?B?RFBrOFFYdlNsOEpsME1KdkVldythOEhWbVBUSkF2Y3RDK1FQNk45SHQycFlt?=
 =?utf-8?B?WFQwRFVIN1MrVkhWRDA2Qzdaanp2WEhtckg3bUJhc2hMenh0SlozTnozcUhJ?=
 =?utf-8?B?ZGt3YXYxNGlkeWM2aWxsQTRhdExqbkk1NkhJYUYzd3kwTFhqMWhGRDI0T1Bs?=
 =?utf-8?Q?orZkGNWAaz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNGVlYwdGk0ckZNRHVhMDlJWW43QnNwbGxveTkvcTVDWWlxZCtiVkd0SWZV?=
 =?utf-8?B?eHA3dDNtS056UWJWUmthS2ZHcU56SFFIWVpLcjFlOVRlR2N6ZGN4aktqWnVz?=
 =?utf-8?B?R3IveGNKTUxUVmplNGtWSEVXai9LOU1tejN4WFB4TVZwWkNCa2N2TDVMUkww?=
 =?utf-8?B?QkVCa1F5T2Jkdm9ONUZubjR4T09JdlUzWEF0Z2x2d2I1UnRGQkRtU2hVZDBE?=
 =?utf-8?B?dTBEaUVKb2JMOGJJUUxGS0dMOGEwU2p2MCtjbFkvZW54clRsR0R6bUZZUWY0?=
 =?utf-8?B?UDRiR3FWUlhielVSWnVabGNnZTZyaWdrd1owVElaRlNNZFNCUW1SMWo3UEJ5?=
 =?utf-8?B?NUxUZDF0dFpERWNrK1dscit2TWU1bXpSa0J2YWJpdmE5RkZRTDBaZEFxNU5G?=
 =?utf-8?B?QU5qOTg2Q3lNUi9wNGRTSk5FOFpsUS84S1ZXdDIrUncyNFpJM1ZiTUVpMk5j?=
 =?utf-8?B?M2ZzbzVSZ0tLL2NrS3h0WEQ3QXZjdkQ0UzRNYUxxakFUL0l6T3ZXc3hONktv?=
 =?utf-8?B?RXl6SUI3a3lyRjkyd09HRVh4Qy96RGprOHljdXRPNlNJRFRJQWg4NkJIQWwv?=
 =?utf-8?B?Z1JYL0hZakx4TUVtNlFaOFQ2dzBRd2RCR2lFTHpLWHMzU3ZXeERhdFhFTGFV?=
 =?utf-8?B?WEZLb0x5RXp5WTQzQXpLNTBrV0JJYlFjMm1CNFhLYlg4Z2huR2U4Mk52cTZq?=
 =?utf-8?B?cTk4OFcwdWZTTmd0QmVrNk5VNVloMTBCODZYbzJtclRoTFdHeWJOdVB1WmQ5?=
 =?utf-8?B?Q3hVNXNLWkMydVJ4SGtjNEM3VWZremNCaDIxdm9xQlc3bTlZbnNWZnpDZWtk?=
 =?utf-8?B?d3E4OTR4SFJVV1YzMmZyVmdEanhzR0wrSXIxaGM0dkc0Wk00Y3pTeW8rTUhk?=
 =?utf-8?B?YmhWZWJqZEo5MTJ3djRVTkdqNDZNZGFEOXlvZ1VsY0NZSDR0a1VROUd6eHpv?=
 =?utf-8?B?dVBMeTdrSUI4eVdjMEhZWFp0OTNyeTlZeGQvbWpBY0NZYmhlWlg5MGc1Ujlm?=
 =?utf-8?B?dHNiTW0vZ1dlTlViQ2RXbmk4TXptajBmYjFieUs1WXVkdHIzWmhGOEtVck5p?=
 =?utf-8?B?UXJlQXhacXZNTEs2eWJFTy9VdHpudDFNekVRNnhzdDdTY25GQ040VnJwUk91?=
 =?utf-8?B?dHFTNS9zMkJyd0FMUFlheC96TkY4eWNDbEhmU2w2RUJwcFVNZEZHcGlZblJn?=
 =?utf-8?B?R1BEZUZWVG5kUFVXaE9raDBOdElqS2ZpcEprTWNZS3B4MVE0bEoxVm5BbUQr?=
 =?utf-8?B?VlV4MmNXbzlwaEc4S2pLYkREaVEzYjRkYlVvLzZSdzhpQjM5TUVrU0I0TDM2?=
 =?utf-8?B?N0NBQUFOdjkxWS9teDVGbmI3S0Y5enN5dWkyVFZCQkZWSW9IZEhCVVVHaENN?=
 =?utf-8?B?ZDdQaWJiSTdiZFIzUlRhUkRCckNEZWhFazVFMVY2WUxmNFlLWlQvZER1U0FE?=
 =?utf-8?B?SjRsN3VzUFFxMzRyWlphOW1lVVZDWTVCVUgwK09iUjczR3ByTTQ5Q2F5ank5?=
 =?utf-8?B?YWhTUmp0azhuRU1oNlZ3bmJtajJDQTF3NkpvZTZtVHUrVGZPSXVZWVRSUEFG?=
 =?utf-8?B?R25UOVczL05BSzRqdDUzZG11K25SWFdkbVdGd0NoOGR0TGdlcWFvSTVxRGJn?=
 =?utf-8?B?YjZvSmw0Ym11cjBXck1mOEtrdDhJbStYV2p3MndiV2d1clJHaHNpekZ5OGxq?=
 =?utf-8?B?NzlmNmFrYWJqd0ZkMkdZaFRTZk95SW9jM25iblM0dUZudHloQmZIWEFaVXJs?=
 =?utf-8?B?ck1neUM5dUZOZHV6ZG1iZm1HUk9FRVJNRHhkVUdhVGVSQ3BaREFPTkxCenlj?=
 =?utf-8?B?VlVTZVFsaUdrVUdwM2ZnYjJWWGNTWkNDazZJUkdPTFJTUzROUTNlbU55NWI2?=
 =?utf-8?B?L0hGY0pqUGV2cmhCbHloN0ZDaGhnbnB2VFNIOUU1ZEpid0xtamszTkxMV3Y0?=
 =?utf-8?B?bEtqTzNMQzdEMjRPVk5HbnJveVVWUVU4cXpJVHZKOW1FYzVPelJLd3BjRDhm?=
 =?utf-8?B?WlVuUFh3dElEaE1HVjdKalRzTHdrV3BIbTRESUxIVjB4c0RCdWF1MG1HQXBD?=
 =?utf-8?B?aFFjU1EzazdzVmNRM2FqeWYrQVRTUUNnK3NiUERvYVNNUVN2by9SM2JSYWJJ?=
 =?utf-8?Q?gIL0CXfNhAICJoiDhfbj8Kfmt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cf0f09-feed-4bfa-3922-08dde0067aaa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:27:39.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00tCEhCyo5fLpVGWeunaJOBLWa/95OHONMlmLC45Fz43ET5CQUbHwbeKChZdpDqVXEl++r8qkUhbx+tjqIwIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235



On 8/20/2025 8:03 AM, Dave Jiang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On 8/20/25 5:40 AM, Liao Yuanhong wrote:
>> Logging messages that show some type of "out of memory" error are generally
>> unnecessary as there is a generic message and a stack dump done by the
>> memory subsystem. These messages generally increase kernel size without
>> much added value[1].
>>
>> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
>> remove the useless call to dev_err_probe(), and just return the value
>> instead.
>>
>> [1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/
>>
>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/fwctl/pds/main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> index 9b9d1f6b5556..8dd659aee256 100644
>> --- a/drivers/fwctl/pds/main.c
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -481,7 +481,7 @@ static int pdsfc_probe(struct auxiliary_device *adev,
>>        pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>>                                   struct pdsfc_dev, fwctl);
>>        if (!pdsfc)
>> -             return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
>> +             return -ENOMEM;

With dev_err_probe() ignoring -ENOMEM, this is a no-op, so this change 
makes sense.

In general we like to have messages like this so the failure path is 
immediately obvious.

However, in this case it is unnecessary because there are specific 
errors in all of the other possible probe failures.

Thanks for the patch.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

>>        pdsfc->padev = padev;
>>
>>        err = pdsfc_identify(pdsfc);
> 

