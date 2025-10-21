Return-Path: <linux-kernel+bounces-863487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF861BF7F29
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A232218A2ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6A34C806;
	Tue, 21 Oct 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fqyqshsa"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4D34C153
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068666; cv=fail; b=iCe3MA5iMpgJiDl97yLzcG7qvETEe/CjesfV9SrD7P1PUozWzai7pNeaTCNx77zO843g+ftMlf6H66MGuha92G7XunKbXuibIUnjkHUgo99GMG0jEKNwJrayo86suYY1sPhj5XUMbxBYrwet2jSxKl9WpH2HqySbqbwaWf2vk98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068666; c=relaxed/simple;
	bh=chD/RBB+2zanL+isFbyLKl6IqI0sJOeU8U+a2BjXLCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ai2iuq61VoUxHyN7pIZHX9tk1wlYjst8F1dYcZBRmIT3BYaMmPb3Uo6ymGBPwbbFKzGnXjGr8fH2JDRAMEKjFDlGswvnviPZYZcLypPE0WtVlLnT3X0ZqJQpcluew8Q4zKdWRdWzEe66UwlH7p5U6hcyhyG6ucqrx2PSjWtl6vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fqyqshsa; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD2g5isTOCffvkI6ifzYL1vDWLqwz85/WphUxWWTTvaR3WXAQArjjyiYCCHKUib8ChE468zFGyh//dNi7wqkNIkFKWaHn3RvpbUkWhS+EtejOA5fOxe6iFzlVLotjsgAFcrJqjiMtK9xibuUvwzXgbgf9E26yz82+e0HMuH50NO/0GbftmzE83gWBtXXNwh+kyeLxmXyaihQPHyzG+9D5j3I/xaQPa+Iq8nw8g78QrgjAXcdnY1Q/tyg8dkLaoazv33aslaTnJRN6xpt60qEuNZcHmjwDSkAeWSnI0ar6H98Dp7YOvIjj7KAawKtT8UtHJl/GCylSjibtLsQHbDTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWSomv1vpXkr6V1ApOt1AiSM3bP0IkCtQClBITXjMSA=;
 b=RsaQdd3XX4tS9KXbJ1c1OeKg0JlbaOequvb/6h84JXMyt8EV8yMDrdja9MCK4KX1KGLud8aPz42dVRh9sQt+2iDCQ8IKz9NVye771bquEoX6mFs9z6mzBP6rzObjyyB8yBsPmm+cP2xAsBYBzeQmpcAVHbXDVEPXy6BwrfD3oSs+L80Z1jFikVQ3AKujEiV1DeWUpnK9wtz/18t68+ayaHkq7zmSW9I8H1+ktlGCc1J7mS+Z+wYwDuvp7ZddqY2B55mbFnRMyJHoZI1vMUH6qVgKPex3Z45S3IabizPbjqtL+XzLCppvkzerjmc/3COol31zXmxE9puKHt+jQCAKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWSomv1vpXkr6V1ApOt1AiSM3bP0IkCtQClBITXjMSA=;
 b=fqyqshsaZo0X6/gC0sFbnx8JMT2181toeFUVoexX02gNgHyWlelbBfB3YImwDPRWsbvWvoMNts4g6kM+NrP/YmkEqfMp5CJ8nkEpr14iFopVv1sCPGShUZAdma70RI6CbO8clCgxAcwvVotQ4Z5bStBuXBAV/BtMg0UjaW+2fVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 17:44:22 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 17:44:21 +0000
Message-ID: <9c8d21f2-5d6d-4b70-9eee-0bbd10b984b2@amd.com>
Date: Tue, 21 Oct 2025 13:43:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't program BLNDGAM_MEM_PWR_FORCE when
 CM low-power is disabled on DCN30
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 alexander.deucher@amd.com, alex.hung@amd.com, daniel.wheeler@amd.com,
 roman.li@amd.com, misyl@froggi.es
References: <20251020230934.387745-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20251020230934.387745-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:408:d4::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7916cc60-843e-4a7f-8db7-08de10c9778c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxtL0duMzRibkY1LzVHZ3NPdkk2VGZOUVZqR2ZPbmVwbGt2ZTBucXdjbG1I?=
 =?utf-8?B?Y3I5TlZDTzhGZ2dQRmd4Y3FjaCsrS1FzVnhJb1p3SmNjRkFzNGFUYS9jdmVi?=
 =?utf-8?B?RU8vUVFjNzltNFNrditxMkJWVStYQ1RxS005RmJRaTZaTlZYd0J6OXpTSzFj?=
 =?utf-8?B?bUR4Y0NiL2pWWi9TYW1OVTJDRDdNNlcrT1B3MVlpa1hIbWswaHcycm5jZUdl?=
 =?utf-8?B?WjZDNkhydDBCTExtOGpWNzVqemQ2cHZ0S0xXL1lRLzBjbkNSSTQ3NmZFenpn?=
 =?utf-8?B?WTlubE1FT0VGRGd2RWNmQjU2cFpFakNzdjdkMHFkcGVlUjNYNEppdVdMYVpZ?=
 =?utf-8?B?dUNLT1RpdXo0OVBSTmdzUGhwa2V2ZVIrakpJdUJ1bm10Uk5DY3dMUnJkQklI?=
 =?utf-8?B?OWNqYlBQeGxNcHZJQVFpbmZOb2tEbmUwQVI0NytjbFNBVFMrOTQ4a3lXa2FQ?=
 =?utf-8?B?aE5RcGVpNWNRQ1d3ek9iTGRYd1N0aldVOWNLRmx4K3l3ajhrUFRxWUVucmpB?=
 =?utf-8?B?d21aM3hJaUZFQU92VlNwNUdEb3YwVG1RcFpoeFZsQ0hBUER0ZEw3Zm50MS9H?=
 =?utf-8?B?cEh0R1JBS1BocEh6RWxOaERJbDVYRHpWcFFzSk1GMlBIeS9RY0x5bWpwNkt4?=
 =?utf-8?B?enNqbnBBdmZDbVllUFNFRFVObHhwVEM0Mk9lNzc1clU3cHdSWWRrNmpybWlh?=
 =?utf-8?B?VFJOSUgwVW40bVc5V1J6M3E0bDJBcklJdXhKdzc5TmhPaGhxODMrcnltb2VO?=
 =?utf-8?B?Z010QTFXZ05jSTlyZkJ2cCs0ZjkvMEUwSnRaY1dFbXhOZkJTeUpBYWZ1cmNr?=
 =?utf-8?B?NWZ1ME9hL1FTZVE0TUFTdnFlcWJkYjZnVGQ2QjR4aVYxMHNvZlZrMHk2S0NO?=
 =?utf-8?B?ck8xVUh5ZVMwNGh5SGJqS0dxV3IzMXhCeHFFbDZyM3MvRDc5TDVTeFdOM2sw?=
 =?utf-8?B?Y3BYa0hTUGVONmFDL1gwV3pjWjBtekpwVEpnSzdGL0RPQnFZOXlPdWxyRkln?=
 =?utf-8?B?a0tNVC8yR2JLSjdvaHJPeVdIZnRVdDdiUTlHY3hzS2RCNTNVaWlaRmZsakxJ?=
 =?utf-8?B?VE81SXB6aUZyNzlLNW9XZndvem5yclVwK3JFSEhLWkRNck13T0svc211ODBp?=
 =?utf-8?B?ZHBWZElCY3dHV01uS2RBSDBLRms2YjJpSnFuUnNYbUFwb3dlYWVBbnh4ellq?=
 =?utf-8?B?ZndiOUNEMERENUJ0SDc0ZEhSWWhLYVU2THFuYWZrTFF0b1U4MW1zUXYya1FX?=
 =?utf-8?B?Y085MGtFdzRRcHZkaWxIcEUyUGpJdXFCbjJBWks1L01JLzM0aFh4Qi9jWlVI?=
 =?utf-8?B?OUhLK2YwbzJUSlVPRmpYb0RzMXlIN0Jaa29uRWpnZGxRTzRPYW5TMm1zdFBm?=
 =?utf-8?B?eTltQnVhdWk5UElFR3N5aXI3V2tjaU1OclJISTFnT2ZJV0pwQThObzI2UVFP?=
 =?utf-8?B?aTh0K2tkVFExMHoxMk5iYkJDRzNLaGhncFUrNm93UlM4S1RIRldXWmJBcTEv?=
 =?utf-8?B?Nzd4UUIxTnZPblNENXV3SDVWalYxV1E4MVdObGNQTXV3aG5zWXp5Qnc3R2ZC?=
 =?utf-8?B?aVBrYmxrMW16NVB0OVVSeFplRThNRnJES1dyeEVjRVJPazM0UERlVHZlSnNZ?=
 =?utf-8?B?QTdPVk5FN09McXdyZ3JnVytvREwwbWpkR3N5ZVBCWGZCRVVnNDFTNWdjeE5p?=
 =?utf-8?B?SW11RmdDOUozRGtkRjNMWkxaL0RSc3loYUFrMUpjcFR4V2lCNEh4V1FtTldw?=
 =?utf-8?B?SGhFcUQ4TTk0VHVDcmtEMUpIU1I4cjROK3pub0dHcTZNOGFDNGJoOGNUVUlR?=
 =?utf-8?B?eEpHcUZoenlDbVMrMnBIcU1hQzNJUVU2OEp3bkNyNk13bXdyalBtZEM5cEhC?=
 =?utf-8?B?aXlXQ3RrVjBRdkVEVDc5UXBPNnlXWklIWG9TZ0tKTS9xb0h6K2dUaVd2WE0x?=
 =?utf-8?Q?xG0VOJxllcjH4VgkuhELlO3yYAZHJpT7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnliR1hYa2VXZG05STNHdGUrNGYreG5EcE9ZMGhMM3ZCZWpjbVhud1NpWWJ3?=
 =?utf-8?B?ZkZNQXpHMUlEb0R6YTVpM0lLWmRrTTJJR2UybFlobWRhM05tUUllNW02NXpC?=
 =?utf-8?B?dE0xU3VZT3gweEJjWXhreUhBUDJMR2l3WkxXd21SdEtQaCtNNlk0c3FQNlRP?=
 =?utf-8?B?UnVVT2FCcjFDemp1U21XV1BvcmVESWJJZ1FaQUlpNm1RanNFQVY2WEJ1MEo5?=
 =?utf-8?B?Y21pVkZ4WS9vVld5UlI2Y2tEN2dvSEFyVjhHRGFDbk9qQWVFUjVXbDJHZDlq?=
 =?utf-8?B?SUdCV05sdmlwaVFQemJuS05Rb2t2a0UzWGNUeXg2MHNHU2RQald6WHBsWlhQ?=
 =?utf-8?B?eWM1UHZQZjJCOUdlaVQxOC94QlhlRGY3Wi9JUHlJbWYySlVadE55UDRGTm9p?=
 =?utf-8?B?L3VKSkZRWDFvcUJsNDB0TWxkTGVOUUxpVWgvbFpBRmNpZThsN25DaWxLUWp6?=
 =?utf-8?B?TkNjYXpXekFTQ1B0VzBwMy92ellnbUtOZU1pVTJxdGhZSE4zT3J4ZVM4OHlS?=
 =?utf-8?B?TjY2TVJ0NlpQTi9HNktPMXJnUVlRM0E2L0xiUEFuWFhiYkFyMnByeG1qejJr?=
 =?utf-8?B?TjkvQU91U1prWmljVkVEN05wbzFpaEUzazlJRUdUZ1E4UXlpbHovYXlSaUJH?=
 =?utf-8?B?UExVWFd2aUx3MWx0RHlVcjg3TU1HdTVpTWgyTDBrUVF2WkFTcmg2T3ZiUGxT?=
 =?utf-8?B?V21QM2dzd0lRRTBRMEREV1RtbHZUc3RwRFQ0RzNZZUxFbWpmb1BNOGxINWtj?=
 =?utf-8?B?TXRuQzZ6SlRtZ0ljUC85UldXaTNTSzVJRngveU53ZThCalVSRXE3c29jTHRk?=
 =?utf-8?B?dEFlM1EyNXQyRnpvTlNKVWtMS2hiUThRV1pCN3BOcGRyQlRZMGJSVFFsMVYr?=
 =?utf-8?B?ZDNMQ2ZOTGFLb0FJSGZwb01JdENweXExK0plQXBMcHFNbEIxL3hnSVgwMkRS?=
 =?utf-8?B?MmtiRkVveU1hUDZtZTFwOEc0S0t6RlVXTTgzeDRYa1BYZXpJVDBjaVpHd2lY?=
 =?utf-8?B?eU0wM3pxMUdUS0JXNmtZTWdrS05mN1lLRWlSNGx3TUk5c0RyYXpoSk9ObFhF?=
 =?utf-8?B?d2lkTzRyNVphdnM5aEhlcnhwdG84czBBZmo2NWJ2U211MGFVTHFpUHVOZ3Z3?=
 =?utf-8?B?YmJWWnRHcjFIUTBwMk0vamFaU3ZTSG5xSjV1dloxNTRCdm9ZcWhaN2dVQVNo?=
 =?utf-8?B?U0IwRWUzci9hZisrU3lhdzRqODFNOTg0TEVHbmN6cm9DVlMxSUZMbHZya0Fp?=
 =?utf-8?B?amg1MG5pbHlaSFdvNUJZZnFJOXZpZFE5ZDcvSTVmS1JBdW90aTNtQXlXY0tN?=
 =?utf-8?B?MHZUSERKNUhHZ0IyWm5HQUpsd3JnYi9RNHRDbHR2Z3ZBeWlaTi9jWEl3WVNN?=
 =?utf-8?B?UzRXQkozQUQ2dVovTUJwNGRoQmF6MFNaenNFQkErQ0F0VC91YWhkZnlCcXI2?=
 =?utf-8?B?YlhRMkdDZlNkcnFQQ25TWHR1QWdPbzlJTFhZS3JKQWxpdmJEd0xtSDM0aWFy?=
 =?utf-8?B?M0hOZzRtL0l6bTZadXRpOFFsT00weXoweFFoYXZOK0R0YTE5cHdTdlllbmEx?=
 =?utf-8?B?YWIrelYwcUFjeHVZWjMweEpDZ0JEQ0FwMzQ3TjZOUSs4K0FncWxmL3VEbHhZ?=
 =?utf-8?B?dFVOblgwbk5uVDJtL1FsbEEwZWtUWWJtOHlaRTVrRGNpQVlCLzR0MmR1emxV?=
 =?utf-8?B?RXJIMVVrbm9oUitrVTlmbWR0Z2JacTEwTllaaEZrYUdoNWZ6ck1pV0hrOHdM?=
 =?utf-8?B?ZUFlMndLYnI3Y2lYS3JGR2NKbDBuUTlLTXNkNjROU0FSa2dzUHRhcTl1bkxX?=
 =?utf-8?B?UU9KL3BMNlN5dGp5Rkdqek0yUXpzNUxMZlFjMGpEK2hGM1lwcTczbW1oN0xH?=
 =?utf-8?B?RGNUeVFOT3F6RUtOUFZQMmpGYTFuSHhqalpwbU1GVCtlb1AwZmRIbWhDTmQ1?=
 =?utf-8?B?UDJXbjJXZXJKc0hHY1pyUjIwV3VNNWZWOTdDZXpsWlJqWHRNZWV5VWZ3QThQ?=
 =?utf-8?B?WGR1YTlRdGVkTDI4c25NSGNPZGdXSHJSanFIKzJnc1ByT20wdEdCUHI3cy9Q?=
 =?utf-8?B?MmlDbVhoK2RpM3Z0aTl0S0NEaVlnSjRtdE54T21keWVya21nREluSUtLV0tY?=
 =?utf-8?Q?s5qG+0kkAQ2A5cSPJpiCHf9j6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7916cc60-843e-4a7f-8db7-08de10c9778c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 17:44:21.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqWT+Y9v8GF076ldtbwyutspwMDct5EmnbRTR/yheZ9fZhHSK7zZHxJaiS8lPzMOBKCaXND3IhVLivKtf6c9tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539



On 2025-10-20 19:09, Matthew Schwartz wrote:
> Before commit 33056a97ae5e ("drm/amd/display: Remove double checks for
> `debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
> checked the low-power debug flag before calling
> dpp3_power_on_blnd_lut(false).
> 
> After commit 33056a97ae5e ("drm/amd/display: Remove double checks for
> `debug.enable_mem_low_power.bits.cm`"), dpp3_program_blnd_lut(NULL)
> unconditionally calls dpp3_power_on_blnd_lut(false). The BLNDGAM power
> helper writes BLNDGAM_MEM_PWR_FORCE when CM low-power is disabled, causing
> immediate SRAM power toggles instead of deferring at vupdate. This can
> disrupt atomic color/LUT sequencing during transitions between
> direct scanout and composition within gamescope's DRM backend on
> Steam Deck OLED.
> 
> To fix this, leave the BLNDGAM power state unchanged when low-power is
> disabled, matching dpp3_power_on_hdr3dlut and dpp3_power_on_shaper.
> 
> Fixes: 33056a97ae5e ("drm/amd/display: Remove double checks for `debug.enable_mem_low_power.bits.cm`")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> index 09be2a90cc79d..4f569cd8a5d61 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> @@ -578,9 +578,6 @@ static void dpp3_power_on_blnd_lut(
>  			dpp_base->ctx->dc->optimized_required = true;
>  			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
>  		}
> -	} else {
> -		REG_SET(CM_MEM_PWR_CTRL, 0,
> -				BLNDGAM_MEM_PWR_FORCE, power_on == true ? 0 : 1);
>  	}
>  }
>  


