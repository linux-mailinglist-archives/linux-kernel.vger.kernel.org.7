Return-Path: <linux-kernel+bounces-896959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DFC51A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE103B1DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88224302163;
	Wed, 12 Nov 2025 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JDYS+7vA"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D03002A6;
	Wed, 12 Nov 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942909; cv=fail; b=FI3CitAWE7nDZMLJcuvfCxE36lZpPHLXrDDaGCF5aEL49ummBnz+Wy0npPYdNvRYFX5ji2yUhzZRgWHCe3ELJMF7bw9czn1ByuNlKtinhHnDB4rsVab/QSEPlYNzws2EmsAhrLawtMu+tu41ZDOh5Q1Lb+inLV5d3Dp5dyWScz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942909; c=relaxed/simple;
	bh=iTZWorXfAzHjNqutj9pAYShjyhubWEjbHf03fceVuWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbNsUqNuRTnvL1k0APBjmJ6mnU/ziqg7jpVapJig0f84WtACYpgI4WCWHSaIsMsSmKRP7GzKAF6Xse4f5McqZDBRXsJ4DVAJ2g7M1L7++tJvb+QGAUz6o/z4hUpHivxtio5RMxGvhCOF23ynjFpIUtQ/2C3kHhBdswqAol0QXIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JDYS+7vA; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7EzAZ50hpuBAyn8lISa/xaEJrJc6HSlLvIjxJ8CqmvTUQmdpY3cbryxd2oesE9GjXYBbWpcnQZ2ZvVG24EvDevAOgWq4kXKVqBHHpIPOpupBlGLB0A8LjyhsxbzgH5HiIXtcyMsa6DazIAm/7+9eXSskwddFN2RvZ8QSl8etx6Uf1qh+E1Rze6ciT5DKobukLiQpfjBZQHHaHVld5q04fGP87FFE382Jeak4ywWOv+jG/qPTQEssCr0sl0BaEjgw5feyA91mHgCNnPtIVoghiCoupe2btITq4rhUan/48aSS/lXdhUl4Fcyz/fAZRhjk6i9DsI7kS2A/t1/0hBkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txHBz5icDLfbqj7ZuRumcs1RdDJcz/kOrBf7JaiBou0=;
 b=b4nntxSEoJGMdAfo+Pl9csfHQzoHYARkB9Dm8faw8v2f/YAr2svkBiFuZ6qhm/NGV7FpkdFVtidmjBuXDMBtzN0ijwb4d1aGMhbNWYCRL6asyVSPTGm9UNiIi4VXmqkKcl/YCIcinGvjj0XOkZiLg8INYdyfOUeu3voMicVGhctqbVQ7Wabp9Dvop17uQBI5BBJihoz2sK9Bgt6Vp0pXbcDu0E8FdvEkGU0qoq1jTUogVEQTZXzj4yFH44bDLFSGlZFWRpD//TWzbeaOdf1lA2mYU20kUTbUd01QSOkV93/3I7aabhOi6MZfkywmjTrFMQLvMvxBKItvGgLfGqS4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txHBz5icDLfbqj7ZuRumcs1RdDJcz/kOrBf7JaiBou0=;
 b=JDYS+7vAzu/QrkgzgvdEdvWNeXNN7MxhGgRPp0c+pH7jGILUHBQ2xwgCHs+iqqEsIvPi8MRVvHQ4W2mb5QG4voc5eESc8lFKZkXSp6fUuKhqpIYQsNzTnKPZ42ZJA62Cscj61NPnxnooskXw925h354HtTqtaKXhSCp6aLfbr70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 10:21:44 +0000
Received: from LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4]) by LV9PR12MB9829.namprd12.prod.outlook.com
 ([fe80::c47f:251d:7b84:e6b4%6]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 10:21:44 +0000
Message-ID: <591efd28-805a-4a13-b7e2-0f78a3ca3eac@amd.com>
Date: Wed, 12 Nov 2025 18:21:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
 laurent.pinchart+renesas@ideasonboard.com, bryan.odonoghue@linaro.org,
 sakari.ailus@linux.intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com, Dominic.Antony@amd.com,
 mario.limonciello@amd.com, richard.gong@amd.com, anson.tsao@amd.com
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box> <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com> <aRL8ZPwXSeKD4Qmn@sultan-box>
 <e09207fd-1879-44c8-a5c1-838a140dcd4b@amd.com> <aRPH1hV7bEfagPtE@sultan-box>
 <aRPhMCwJjpMqAROG@sultan-box> <d9afc6db-fd8a-4069-a8a8-1e2d74c1db3a@amd.com>
 <aRQyAdyiQjhsC11h@sultan-box> <aRQ5aA4Gus4iCVLp@sultan-box>
Content-Language: en-US
From: "Du, Bin" <bin.du@amd.com>
In-Reply-To: <aRQ5aA4Gus4iCVLp@sultan-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To LV9PR12MB9829.namprd12.prod.outlook.com
 (2603:10b6:408:2eb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV9PR12MB9829:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: a739510b-1824-4284-5d38-08de21d54721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STVYejNYbm8rQnp1MHFCT25GRVNkUnoxcEFLci9vMlNRSnRpeFFIcVhUZWhB?=
 =?utf-8?B?Y0VYOWRCcXhNcitGRnRDSjNCTFA1SUtkWkd3TFk2WXpsZXhpa0g5QkppV05S?=
 =?utf-8?B?RDArZ3BHaHVGZ2JIb2hQYVZDdDlUd21uYWUrL0VWTHNQQjZHc0hQRFRlbEMy?=
 =?utf-8?B?MjViOUE5TjJZaG9iMFVBY3hEWWF0UStDd0wzUXltbnFwQzVHVjlCdHhCSnNk?=
 =?utf-8?B?VGxQYmNQK0wyMFdNQjBYakFFcFBRUWcyUHRJVGFqa2FUZk05aW9hTHB2YnRM?=
 =?utf-8?B?YTZlUThubmhmNDc2Vmx1Y3JtVnJndHNXM1U3R2ZuRDkzdmU3bWZaOG9lL0xa?=
 =?utf-8?B?ZmJ6MzVLTnNwdk1WUG44cXcvR1lwOXlxMDkzL05EbjU2TkpNME84UVV0VFJr?=
 =?utf-8?B?a0liZGZ0WjlPTDVVV3pvRVpMMitjejFPUERWWFlNalcvdDZhc2VSQWJwcTAx?=
 =?utf-8?B?d0NOSGVNbDNyY2VUL0RoLzVwQWVqbEhPNDdpWE9FUk1PMkRJcVdZY3N6MkhE?=
 =?utf-8?B?aEpTSnJIWlNIeHBJY3RORnU2cWxzQ0pBVEx0eVE4RGpsWGJJMUVaMGRTMGt6?=
 =?utf-8?B?YUo5T3lBYkNCT2p5SEwrbUxaQmhubng5cDZXOEZhckRJUU1pbzU0RGdyd3VU?=
 =?utf-8?B?ZnA3UW1CVmthMzR1RlVsS05ZaFl3cTBSK3plWHRJOC93RWgrNzJZalptaitP?=
 =?utf-8?B?OVhZaCtIbnFKY0NHYTVYQm5sZ2JEbW9pVW1vRm1WMlpOUThNb2V0aEx5WC9j?=
 =?utf-8?B?TTZUTDF0Q1BEWVFmcWRsQ29sbU50UGNScFVEN3BuN2JyMkpEYkxBOSsybGlL?=
 =?utf-8?B?ZWpocmF4ZElRdFBxYTk5eXBmb1hqOElqY3U5QTc4L1Eyd1VqaDBaZzZEcy8r?=
 =?utf-8?B?dGNxMzlpZFdSV2tLQU41UXVRald6a3RhR2hReUZ5U1E2ekVZK2lieHp1K3BO?=
 =?utf-8?B?MEdXZ3hJemtEREs3aURTTS94K3p6Rk5uYWlzUVU1Rmg0M3E5ZFFiejRSa05W?=
 =?utf-8?B?M3A1QXZxMHR5Y0ZYL0JsRkVvaUJkSnM4MHBwQm94TkFTUGpHLy9DSDhERDZj?=
 =?utf-8?B?dkdzc3RJbXYzdGhvL2JwUVlDL09ZNmNaR1hmNStIZ0d5TzJNR1M1N2cxU0Ux?=
 =?utf-8?B?OFhOdWNnR2pMVU1QNDNsYnpSVHJ6OXNraDdQTFhXb1B4TXZhTnFqKzV5MFMx?=
 =?utf-8?B?Wm9FSlA4d1lKZS93QzhoV0JXQ3pmSXoxaEJPTThaU285ZXFnWEpEMmpoU0pr?=
 =?utf-8?B?RHNlNEhqb2x2R3p4RGtJZU1hSGI3aEREcDRMaDNFdE9Bd2JxeUFGcVVqbWN2?=
 =?utf-8?B?MS8zRzRQdWhiejNRczBlczNERkpTSXZhdklvc0ZXSDF4clI4RFJLa3pTSW0r?=
 =?utf-8?B?NFJKWHFyMEFxL2FBMUJZNEU2enQ5dFNLMURYaDM3VEFyc3JDdEFNZGRNZVNp?=
 =?utf-8?B?RWN1V0I0eGxobGJrRGhZV1JwMUhIZUg2TkFweUpDUEw5NnRDUUVNeGlxYmpE?=
 =?utf-8?B?MWt5WVo0SVYwYzRWMVpGWFhaRm9XNHVBQXVQSFhhNGR2UjFFZ0ljaG44ZTFI?=
 =?utf-8?B?Uk1GM2VqT05tdHV6NWtrS1BiOC91OVVqZlhpR3k2SytiVjV4WTQ2NVFCb3Iv?=
 =?utf-8?B?UkpITVhRdDdONUZQWEwvNktNTE5mTE1keTFKblNPNWtOMmVjRzZSdTN5QnVk?=
 =?utf-8?B?VW14Y0wxS3poQmNCQ0theGlHeXlMaCt5UU40MWtOMGhEZUlqK2lNYmhhNDhX?=
 =?utf-8?B?S0FxVUFnT3U0eExSSlpjaWdRTnZKMlZFZzhqaHljekEyNW82blRLYkYwdUVX?=
 =?utf-8?B?NHhtOGtrOTJWdUczam84YU1aQ25vc2RhaUR4TWNxZEt0SERiT053OHZXcVI4?=
 =?utf-8?B?a1EyVW9pd3drSElmSDJldStvUXZHWTArenFKempib1VWUXR0RnJmR0E3YWZz?=
 =?utf-8?Q?8Z1dtGMix01H1s6rDIfwL20q0fIMrT0U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR12MB9829.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mno4MXRBY29rNXlzVnk3MW1iT1BwU2x6WVBNSkkwMnYzejRaOXhDdlRhbkx6?=
 =?utf-8?B?SXpPcFQ0OURpOWdxeFRldEk5eEhna0EydlhOdEc3SjlpYjBUQ082Wk0wOEJ1?=
 =?utf-8?B?QlNBdG9pb0lCVEdZKy91aFhkbW1KdjYyenBadnQ0bll4ZWd5TGZyZnVMTVpt?=
 =?utf-8?B?eFhxajF4bkdUVlNaa3lhajhhTjVCUWhZTURvdXVRUWhFSytacHpKeUNWdkdP?=
 =?utf-8?B?QlhTVkVKUlBLUXlJbVZ4TmgrdnJpTmxHRGN5U0dnTjYvUkljNFl4NURsc0xW?=
 =?utf-8?B?bUdVUDliN0JneDRLcjZ1T01GR1VwWW16TWZHcC9TZDlnTGg2UERiWno3WWlj?=
 =?utf-8?B?K1hzUjV4NWhjM0w0cEJxZHNTejIwZWdaT0ZXd1VVYXZQM056aDdiVWlORUgv?=
 =?utf-8?B?bXNkMUpTWGtRajNrMk9JRk1WYXgvVlE5enlsRzQ3YkZkeldEZjA2VzQ0d0xJ?=
 =?utf-8?B?clphNDI1ZFhtdEtzTTcxT2tMV3ZvQ3oxbi9uckQ4RXlzV2dpTmk4MnpqOXdM?=
 =?utf-8?B?QWZHd0tCdkhYUmJVQ2s2ZjM2Ykkwa3psZjkySUxxcFkvVzV1TGQyTmJ0S0tJ?=
 =?utf-8?B?akJML1FmTkVHU1JkRHZWOTVzMnBCQm5JZTJoOU5LWXF0SXpzMjhNODJ0Q2J5?=
 =?utf-8?B?dEtQTjFLcko1b2lmTEdxKzhOdzREVHNnbU1hY0J0SE42VjN6aUFuVXhvNG80?=
 =?utf-8?B?WXd4TG1NOTF2VzhLUU4yR3BXWHg0c2xjTUtUaVppYWxLNUZqRGZIR2NHTW96?=
 =?utf-8?B?N244QStxU0wzVzVTWHFqZHUyNVFkWHJMTUdRTVBaR3Zza1VKcFl2SzZqTVg0?=
 =?utf-8?B?emRVUXR2SHdWOFhOMlkzY0JHOEdreHlCRENtRXBDZzJNbHN4QjV3SDdYYmpQ?=
 =?utf-8?B?dTNQNitTWEdHZVkxWG9ra1FmNk9EQ0RqTUhTRXNJTXpPTStadUNqYUdNWmx3?=
 =?utf-8?B?cXBtZTlKVzVHdndFbTNXUGZFZTVKa0s3ZkxKRUJiQUp4a2d3R1VFUjcwOEJm?=
 =?utf-8?B?N3Y1L2Y5dGwvVFlrYStyRkJtcTZwL2NCZnIzVUFvMThWVlRrQUVnUnhpbDRY?=
 =?utf-8?B?ZWMrTlRmellvR3lwc20zTGZTWXpJeXlzeWF0MUZ5N0luMmNwY3RtaW8xakYr?=
 =?utf-8?B?TEhISzJScjJWMG9ONTNUdGxxWWNmQ0plNXdtMUhmVVM1NXFFd1B4SU54NFNE?=
 =?utf-8?B?MmNzbUJ6TEJGNmxrZUR5bFhMb1NXOWVGc0RCdzJJb0oxVlZITHFOV2lGOTlB?=
 =?utf-8?B?aDFUOVQraHpLQm90TE1pejBPZzk2emFNcHVGMi80VUNwSS92b2ZydTBtZi9P?=
 =?utf-8?B?QXBtVUJaZXdRa1J5TngraUJFa2V6bzlWNXJuUTF0bDlnT2doVHp2YityYWwv?=
 =?utf-8?B?dmxWaWpLaEdBWXJkdVdEMlc2Sm8va0VxNU1ubElCako0cmJJQk9FM0NIVlNE?=
 =?utf-8?B?MmtmVFh3eHBQR3VqQ0xzZklWSHJZT2ZIOUxHbEtUWlgzemJFQzYwWkFDdE9x?=
 =?utf-8?B?TzI2bVlYTER2UzJyY1U0Z1RTL1FQZklTdkZmbnpkUERhZ0JOaTRSRGI0UzIw?=
 =?utf-8?B?ejB4NzA3Z2FvMHM1eVRvdHZ4SjVOWDM0aFltYzlOOFA5RnFyUHVnN3ZpTVlQ?=
 =?utf-8?B?VnIyWDI5RlUzOXhMcWFwMWNWallNUU9TdWY2bzltWHV3TEwwakswTGhCbWg2?=
 =?utf-8?B?aWlSUkdNb0QzRnZ3NGhDQ2JVTmZHRHFjazhkZi9Ud2ZoNmxLWGtJb3M5d3Js?=
 =?utf-8?B?YWx3dmRZcjNQazZBdmh0bjR0OHFPdHlkWkF1RU9NREVVSlVIVGdRZzZXeVdM?=
 =?utf-8?B?UXoweEFCcWVsa3dHNk85QWt1YjB2VzlQYWoxWlBNUDVsazE3UFdON3dVd214?=
 =?utf-8?B?NXBBd3JiemZTWHFWWndQVGdLSXV3cGtTUHdQd05DcTk1Y1ExWkZ4T0NiWHpR?=
 =?utf-8?B?bzcvWDh6OUdkcXBFaFVIazVkdTBHTnh5dmM1Rkg2UWRXSUN0emEzWTF0ZG4y?=
 =?utf-8?B?TitGblF4a1VnOXp2dGdsUjB6OFlXWVltVjZIWDFTUmwrU2hhK1JjNTRQM2ta?=
 =?utf-8?B?Q0s0b1VEK2gvMHlMaXFuZ2k0NmJaYllHNktFdStRc283QmhDZ1RMVmV4K2lv?=
 =?utf-8?Q?irWw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a739510b-1824-4284-5d38-08de21d54721
X-MS-Exchange-CrossTenant-AuthSource: LV9PR12MB9829.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:21:44.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEoE1kdrEt6N0Bwb4ZDz4q5euzs+NDDejPQiq9NfSoGMWG4Q6Xj9n3V47cObh3yG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774



On 11/12/2025 3:38 PM, Sultan Alsawaf wrote:
> On Tue, Nov 11, 2025 at 11:06:41PM -0800, Sultan Alsawaf wrote:
>> On Wed, Nov 12, 2025 at 02:32:51PM +0800, Du, Bin wrote:
>>> Thanks Sultan for your information.
>>>
>>> On 11/12/2025 9:21 AM, Sultan Alsawaf wrote:
>>>> On Tue, Nov 11, 2025 at 03:33:42PM -0800, Sultan Alsawaf wrote:
>>>>> On Tue, Nov 11, 2025 at 05:58:10PM +0800, Du, Bin wrote:
>>>>>>
>>>>>> On 11/11/2025 5:05 PM, Sultan Alsawaf wrote:
>>>>>>
>>>>>>> On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
>>>>>>>> Thank you, Sultan, for your time, big effort, and constant support.
>>>>>>>> Apologies for my delayed reply for being occupied a little with other
>>>>>>>> matters.
>>>>>>>>
>>>>>>>> On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
>>>>>>>>> Hi Bin,
>>>>>>>>>
>>>>>>>>> On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
>>>>>>>>>> Hi Bin,
>>>>>>>>>>
>>>>>>>>>> To expedite review, I've attached a patch containing a bunch of fixes I've made
>>>>>>>>>> on top of v5. Most of my changes should be self-explanatory; feel free to ask
>>>>>>>>>> further about specific changes if you have any questions.
>>>>>>>>>>
>>>>>>>>>> I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
>>>>>>>>>> I should send what I've got so far.
>>>>>>>>>>
>>>>>>>>>> FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
>>>>>>>>>> protecting the list_del() anymore. I also checked the compiler output when using
>>>>>>>>>> guard() versus scoped_guard() in that function and there is no difference:
>>>>>>>>>>
>>>>>>>>>>       sha1sum:
>>>>>>>>>>       5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
>>>>>>>>>>       5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
>>>>>>>>>>
>>>>>>>>>> So guard() should be used there again, which I've done in my patch.
>>>>>>>>>>
>>>>>>>>>> I also have a few questions:
>>>>>>>>>>
>>>>>>>>>> 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
>>>>>>>>>>        faster to use that than using disable_irq_nosync() to disable the IRQ from
>>>>>>>>>>        the CPU's side.
>>>>>>>>>>
>>>>>>>>>> 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
>>>>>>>>>>        beforehand to mask all pending interrupts from the ISP so that there isn't a
>>>>>>>>>>        bunch of stale interrupts firing as soon the IRQ is re-enabled?
>>>>>>>>>>
>>>>>>>>>> 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
>>>>>>>>>>        when the ISP posts a new response _after_ the kthread determines there are no
>>>>>>>>>>        more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
>>>>>>>>>>
>>>>>>>>>> 4. Why are some lines much longer than before? It seems inconsistent that now
>>>>>>>>>>        there is a mix of several lines wrapped to 80 cols and many lines going
>>>>>>>>>>        beyond 80 cols. And there are multiple places where code is wrapped before
>>>>>>>>>>        reaching 80 cols even with lots of room left, specifically for cases where it
>>>>>>>>>>        wouldn't hurt readability to put more characters onto each line.
>>>>>>>>>
>>>>>>>>> I've attached a new, complete patch of changes to apply on top of v5. You may
>>>>>>>>> ignore the incomplete patch from my previous email and use the new one instead.
>>>>>>>>>
>>>>>>>>> I made many changes and also answered questions 1-3 myself.
>>>>>>>>>
>>>>>>>>> Please apply this on top of v5 and let me know if you have any questions.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sure, will review, apply and test your patch accordingly. Your contribution
>>>>>>>> is greatly appreciated, will let you know if there is any question or
>>>>>>>> problem.
>>>>>>>>
>>>>>>>>> BTW, I noticed a strange regression in v5 even without any of my changes: every
>>>>>>>>> time you use cheese after using it one time, the video will freeze after 30-60
>>>>>>>>> seconds with this message printed to dmesg:
>>>>>>>>>       [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
>>>>>>>>>
>>>>>>>>> And the video never unfreezes. I haven't found the cause for the regression yet;
>>>>>>>>> can you try to reproduce it?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Really weird, we don't see this issue either in dev or QA test. Is it 100%
>>>>>>>> reproducible and any other fail or err in the log?
>>>>>>>
>>>>>>> Yes, it's 100% reproducible. There's no other message in dmesg, only that one.
>>>>>>>
>>>>>>> Sometimes there is a stop stream error when I close cheese after it froze:
>>>>>>>
>>>>>>>      [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
>>>>>>>      [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
>>>>>>>      [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
>>>>>>>
>>>>>>> When I revert to v4 I cannot reproduce it at all. It seems to be something in
>>>>>>> v4 -> v5 that is not fixed by any of my changes.
>>>>>>>
>>>>>>
>>>>>> Hi Sultan, could you please try following modifications on top of v5 to see
>>>>>> if it helps?
>>>>>>
>>>>>> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>>> b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>>> index 39c2265121f9..d571b3873edb 100644
>>>>>> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>>> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>>> @@ -97,7 +97,7 @@
>>>>>>
>>>>>> #define ADDR_SPACE_TYPE_GPU_VA          4
>>>>>>
>>>>>> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
>>>>>> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
>>>>>>
>>>>>> /*
>>>>>>     * standard ISP mipicsi=>isp
>>>>>> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>>> b/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>>> index 248d10076ae8..acbc80aa709e 100644
>>>>>> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>>> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>>> @@ -697,7 +697,7 @@ static int isp4sd_stop_resp_proc_threads(struct
>>>>>> isp4_subdev *isp_subdev)
>>>>>>           return 0;
>>>>>> }
>>>>>>
>>>>>> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>>>>>> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool
>>>>>> irq_enabled)
>>>>>> {
>>>>>>           struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>>>>>>           unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
>>>>>> @@ -716,8 +716,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev
>>>>>> *isp_subdev)
>>>>>>                   return 0;
>>>>>>           }
>>>>>>
>>>>>> -       for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>>>>>> -               disable_irq(isp_subdev->irq[i]);
>>>>>> +       if (irq_enabled)
>>>>>> +               for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>>>>>> +                       disable_irq(isp_subdev->irq[i]);
>>>>>>
>>>>>>           isp4sd_stop_resp_proc_threads(isp_subdev);
>>>>>>           dev_dbg(dev, "isp_subdev stop resp proc streads suc");
>>>>>> @@ -813,7 +814,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev
>>>>>> *isp_subdev)
>>>>>>
>>>>>>           return 0;
>>>>>> err_unlock_and_close:
>>>>>> -       isp4sd_pwroff_and_deinit(isp_subdev);
>>>>>> +       isp4sd_pwroff_and_deinit(isp_subdev, false);
>>>>>>           return -EINVAL;
>>>>>> }
>>>>>>
>>>>>> @@ -985,7 +986,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int
>>>>>> on)
>>>>>>           if (on)
>>>>>>                   return isp4sd_pwron_and_init(isp_subdev);
>>>>>>           else
>>>>>> -               return isp4sd_pwroff_and_deinit(isp_subdev);
>>>>>> +               return isp4sd_pwroff_and_deinit(isp_subdev, true);
>>>>>> }
>>>>>>
>>>>>> static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
>>>>>
>>>>> No difference sadly; same symptoms as before. FYI, your email client broke the
>>>>> patch formatting so I couldn't apply it; it hard wrapped some lines to 80 cols,
>>>>> replaced tabs with spaces, and removed leading spaces on each context line, so I
>>>>> had to apply it manually. To confirm I applied it correctly, here is my diff:
>>>>>
>>>>> diff --git a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>> index 39c2265121f9..d571b3873edb 100644
>>>>> --- a/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>> +++ b/drivers/media/platform/amd/isp4/isp4_fw_cmd_resp.h
>>>>> @@ -97,7 +97,7 @@
>>>>>    #define ADDR_SPACE_TYPE_GPU_VA          4
>>>>> -#define FW_MEMORY_POOL_SIZE             (200 * 1024 * 1024)
>>>>> +#define FW_MEMORY_POOL_SIZE             (100 * 1024 * 1024)
>>>>>    /*
>>>>>     * standard ISP mipicsi=>isp
>>>>> diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>> index 4bd2ebf0f694..500ef0af8a41 100644
>>>>> --- a/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>> +++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
>>>>> @@ -669,7 +669,7 @@ static int isp4sd_stop_resp_proc_threads(struct isp4_subdev *isp_subdev)
>>>>>    	return 0;
>>>>>    }
>>>>> -static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>>>>> +static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev, bool irq_enabled)
>>>>>    {
>>>>>    	struct isp4sd_sensor_info *sensor_info = &isp_subdev->sensor_info;
>>>>>    	unsigned int perf_state = ISP4SD_PERFORMANCE_STATE_LOW;
>>>>> @@ -688,8 +688,9 @@ static int isp4sd_pwroff_and_deinit(struct isp4_subdev *isp_subdev)
>>>>>    		return 0;
>>>>>    	}
>>>>> -	for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>>>>> -		disable_irq(isp_subdev->irq[i]);
>>>>> +	if (irq_enabled)
>>>>> +		for (int i = 0; i < ISP4SD_MAX_FW_RESP_STREAM_NUM; i++)
>>>>> +			disable_irq(isp_subdev->irq[i]);
>>>>>    	isp4sd_stop_resp_proc_threads(isp_subdev);
>>>>>    	dev_dbg(dev, "isp_subdev stop resp proc streads suc");
>>>>> @@ -785,7 +786,7 @@ static int isp4sd_pwron_and_init(struct isp4_subdev *isp_subdev)
>>>>>    	return 0;
>>>>>    err_unlock_and_close:
>>>>> -	isp4sd_pwroff_and_deinit(isp_subdev);
>>>>> +	isp4sd_pwroff_and_deinit(isp_subdev, false);
>>>>>    	return -EINVAL;
>>>>>    }
>>>>> @@ -957,7 +958,7 @@ static int isp4sd_set_power(struct v4l2_subdev *sd, int on)
>>>>>    	if (on)
>>>>>    		return isp4sd_pwron_and_init(isp_subdev);
>>>>>    	else
>>>>> -		return isp4sd_pwroff_and_deinit(isp_subdev);
>>>>> +		return isp4sd_pwroff_and_deinit(isp_subdev, true);
>>>>>    }
>>>>>    static const struct v4l2_subdev_core_ops isp4sd_core_ops = {
>>>>>
>>>>>> On the other hand, please also add the patch in amdgpu which sets *bo to
>>>>>> NULL in isp_kernel_buffer_alloc() which you mentioned in another thread.
>>>>>
>>>>> Yep, I have been doing all v5 testing with that patch applied.
>>>>>
>>>>> BTW, I have verified the IRQ changes are not the cause for the regression; I
>>>>> tested with IRQs kept enabled all the time and the issue still occurs.
>>>>>
>>>>> I did observe that ISP stops sending interrupts when the video stream freezes.
>>>>> And, if I replicate the bug enough times, it seems to permanently break FW until
>>>>> a full machine reboot. Reloading amd_capture with the v4 driver doesn't recover
>>>>> the ISP when this happens.
>>>>>
>>>>> As an improvement to the driver, can we do a hard reset of ISP on driver probe?
>>>>> I am assuming hardware doesn't need too long to settle after hard reset, maybe
>>>>> a few hundred milliseconds? This would ensure ISP FW is always in a working
>>>>> state when the driver is loaded.
>>>>>
>>>
>>> Actually, each time the camera is activated, the ISP driver powers on the
>>> ISP and initiates its firmware from the beginning; when the camera is
>>> closed, the ISP is powered off..
>>
>> Hmm, well I am able to put the ISP in a completely unusable state that doesn't
>> recover when I unload and reload amd_capture. Or maybe it is the sensor that is
>> stuck in a broken state?
> 
> Here is the log output when I try to start cheese after unloading and reloading
> amd_capture, where the ISP is in the broken state that requires rebooting the
> laptop (annotated with notes of what I saw/did at each point in time):
> 
> ==> opened cheese
> ==> cheese froze after a few seconds
> ==> closed cheese
>    [   34.570823] amd_isp_capture amd_isp_capture: fail to disable stream
>    [   35.077503] amd_isp_capture amd_isp_capture: fail to stop steam
>    [   35.077525] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)
> ==> unloaded amd_capture
> ==> loaded amd_capture
> ==> opened cheese
>    [  308.039721] amd_isp_capture amd_isp_capture: ISP CCPU FW boot failed
>    [  308.043961] amd_isp_capture amd_isp_capture: fail to start isp_subdev interface
>    [  308.044188] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044194] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044196] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044197] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044198] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044198] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044199] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044200] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044200] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044201] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.044202] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.065226] amd_isp_capture amd_isp_capture: power up isp fail -22
>    [  308.174814] amd_isp_capture amd_isp_capture: ISP CCPU FW boot failed
>    [  308.177807] amd_isp_capture amd_isp_capture: fail to start isp_subdev interface
>    [  308.178036] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178043] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178044] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178045] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178046] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178047] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178048] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178048] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178049] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178050] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.178050] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.198776] amd_isp_capture amd_isp_capture: power up isp fail -22
>    [  308.306835] amd_isp_capture amd_isp_capture: ISP CCPU FW boot failed
>    [  308.311533] amd_isp_capture amd_isp_capture: fail to start isp_subdev interface
>    [  308.311723] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311723] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311724] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311725] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311725] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311726] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311726] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311726] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311727] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311727] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.311727] amd_isp_capture amd_isp_capture: invalid mem_info
>    [  308.335281] amd_isp_capture amd_isp_capture: power up isp fail -22
> 

Thanks Sultan for the detailed info, I agree with you, tend to believe 
it may related to the sensor, I will follow up with the FW team to 
investigate further.

>>>>> Thanks,
>>>>> Sultan
>>>>
>>>> A small update: I reproduced the issue on v4, but it took several more cycles of
>>>> closing/opening cheese and waiting 30s compared to v5.
>>>>
>>>> Right now my best guess is that this is a timing issue with respect to FW that
>>>> was exposed by the v5 changes. v5 introduced slight changes in code timing, like
>>>> with the mutex locks getting replaced by spin locks.
>>>>
>>>> I'll try to insert mdelays to see if I can expose the issue that way on v4.
>>>>
>>>
>>> Could you kindly provide the FW used?
>>
>>    commit a89515d3ff79f12099f7a51b0f4932b881b7720e
>>    Author: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>    Date:   Thu Aug 21 15:40:45 2025 -0400
>>
>>        amdgpu: Update ISP FW for isp v4.1.1
>>        
>>        From internal git commit:
>>        24557b7326e539183b3bc44cf8e1496c74d383d6
>>        
>>        Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>
>> Sultan
> 
> Sultan

-- 
Regards,
Bin


