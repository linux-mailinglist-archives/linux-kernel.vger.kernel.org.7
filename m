Return-Path: <linux-kernel+bounces-883489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92624C2D959
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB6D189914E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA83191DF;
	Mon,  3 Nov 2025 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vbA755NM"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020080.outbound.protection.outlook.com [52.101.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AA41C72
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193154; cv=fail; b=aa/CHUycuThsr7zZEzF6TVExCxVNBBXjoLvmUTNqILiT4aA3VilloqmjTAZXrViq4gZzurrJ29HaClofnKm7ta9fzW+R+hLkr4ogKckvuWTqvgxaB6sjC/BQZ9o6YMFmdQotM8n/+TDNS72ZCulsMiKOdeUYsWFhLv95KwvLMi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193154; c=relaxed/simple;
	bh=lgGUSYScxBJsRhKSH95+HYPXLsWaqA1oavkPnjl/o4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RuXyjuVlEZw55zvC5rJgHoECXMabcGa9MDKsD3Jj3nGD7b5vBkBxdJVZzx+Qopx+jDKAtgu0t6/GE5pDGcmGqLH0UmIdn2GOCLx4Tz5dTpRrgzbECIM9MZZqK1tk+D1ylNDLo+6iJNbFCgcHRHaoBLQf9Gq+mGxkm5q72eTvGWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vbA755NM; arc=fail smtp.client-ip=52.101.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQxSLOn4pzYIq9HHdQnnV1Ec6IFRLmJbna0FFf3Q0M5YvEpCSKhrIaBGNyYqWqAZRobtXrG4sFOAyiGUN1oKxur79xrAiQd10oEpRtUQ0d4kF+S2dQhg/Hje3Vz+VXsX+MQ4dMNm5wUBjw6dIHKmBOhMIY8ZYcvKR6b2P35pVp0/dDk10D+5fPGv6hUGAMCLUg4Zi/HtGZFiE5IrJohzQYtKuy8g6wYcuxcJbEk5oPJakPuZ2GEV2PW5eIZINP9/D06HjWQe9uOraNglKtR23EyAvXSyBJPvuBkZi1fXvQry4Aeb3VfZ/GJ2m83d6cidgafEM6h0CCyWsK43Yk0Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlweDKYQc36FDVTCAaH8ymGwWtW+jC4Oz0iC1ttJVpg=;
 b=tubSyTt8YiNkZqlYPUfWfTnXyKYvn+5SIuzclsGHp67WUZUjKhNpOoya1hWPDySLXA6juiU7NJscW360OiQhatT9eTLvmRfpAUf+pugeGtLUJaXaenrvbG/1eDZtGrYWIbolcIStssBl2Q/Z+5Q1F9zrPM4GRTZoWkTc6sM8WZzawdAYpmErsvR22qJXj4YsXj93xqVCYsIuI8n6HPkbH0aE+7ZMVv3z/BEQN+k8WA0XWHdoKnE89tSLtX4fAwWa2c28hEbjRAFoUVKX2WFGyiifRJt+rn16/Gp5I3x1dz8xwn1R6Lz1YbthpUzNqeDQMB8/swyNRuwQJPDNMi1ZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlweDKYQc36FDVTCAaH8ymGwWtW+jC4Oz0iC1ttJVpg=;
 b=vbA755NMOdDacW2XJcSI0yMpZo9VsxikM4IOITF7MiJG0G9QzbRfmo0UJl493ZknlBf2aRbZWUFITUd3z8MmIyww4fNJ2hOCx5K9sVaNdHfWDz7aBzI7zUBP/SkzYuXMnsWdKklNCQjIaDFll6p+Zd+sSnPvuBfjAGby9+Z7JvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB7002.prod.exchangelabs.com (2603:10b6:610:107::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 18:05:47 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:05:47 +0000
Message-ID: <37b62e31-a323-409e-84a1-a3d3fea15d7f@os.amperecomputing.com>
Date: Mon, 3 Nov 2025 10:05:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: mm: Don't sleep in split_kernel_leaf_mapping()
 when in atomic context
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, david@redhat.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@google.com>
References: <20251103125738.3073566-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251103125738.3073566-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:930:d3::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: cc083d6a-af1c-4b33-4c17-08de1b039d4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUtudUV3OThlRVBCdUxLZHd3L08vRWVkVkxGZ1hPekVZRFFvUWgyQ3ZmY2NK?=
 =?utf-8?B?NmJrZFZaTHFvaVlHZm1QelpDRlRQNUdIQm5qamZkdjV6TjN6SHljZ3lsamFI?=
 =?utf-8?B?dkZlbUdxMXJHTG1nOFVlaHRsV3FWcG54NVVPUlRFM0dnZFlPTmdCWnUwNG1H?=
 =?utf-8?B?RXN1S3Rub0cxQTN4bEZ0TXFSQmtLUEhIeVpFelluZ3k5dWZ1elc0QytFNXlO?=
 =?utf-8?B?b3VtQ1VtTWkrTXVIWHRVSlk0eCtxdVJVKzJTTnhvT0JscjBmR1FVRHU0dksz?=
 =?utf-8?B?aGR0RmUyQ3pSa2RQZ1lhSWpJRk5pbWNwVVQ5citxbUNDYnpuU2J3bDFyWkMv?=
 =?utf-8?B?cmh4MWIzdHFhcmp4RU1wWFpDZHRYNFBLOVhPM1cySENQbjJwQ2NwTnlKalha?=
 =?utf-8?B?d0VteWcxcWtTRkQ4UXJyNlJhS0NReFA5cFBqNFVvZUIrWnhMQ3VCRm1rVUhD?=
 =?utf-8?B?eEx6cUcyRERoWjE2dGpramVVT3VDSUlSaEJ1L29lWXBLazJxQktYbGpTWHFH?=
 =?utf-8?B?bEFQVDZqODZlNnFQYnpDcXJNWFlmdkNzeHVhYUZRM2k0cHR5c1dSUmhCdzR3?=
 =?utf-8?B?SHBZd3ZscjI4OWdjcm5tM0JzZEQxQkVzR0NGSFhrUm5QNGFmdjRsOGwxMGVO?=
 =?utf-8?B?SEdXUjlDYkIzb3g5UEJ0cnV6Uk16TTZuVmNQU3I2bDRNOFhHTW80bnQ0Sm5z?=
 =?utf-8?B?ek5WU2hPWExFSU5kaUV5QWsxMDdsdjBBMEp1TEh5UjFkQk5MNHByQ1k0aWR0?=
 =?utf-8?B?M0NWWkczQzloRG9PMFZXT2dtZEluL2RGVC9qM0lWc0l3YmVEblR5bWtudVht?=
 =?utf-8?B?THZQNHVSYzVveWljS3owMGNJQkdsU1BzUDJTcmJtYktzdFM1MWhsam5jTmt1?=
 =?utf-8?B?S2ExVTZ5ZlBCMzArcUhScUo0NmtpMm1CRjdiVTlUUnVaeGFiU2dJV3FjZzNv?=
 =?utf-8?B?b2ZxdzV3RHJpQktJMUZ2REtDTmkrZS9vaGZaZWxnTGVaTW5iSVpTMUpOYUM4?=
 =?utf-8?B?dnF4WDh0OXM3UjlZUDVkR2Z4VFVERFVKaEd5Z3N1MGxPVnNHZ2VxcVArNHBU?=
 =?utf-8?B?OWVEUURCbVhtQ0tYOE1iTmdpTmhpMGpDOEdna0hXZFR2NkJLMk9IWVFtekRu?=
 =?utf-8?B?QTZmT3pUb2dqbHpaa2tUbTRMZU5IY2k4YUM2VmlSNXdhT0JhNjZ0MVUvQ3JP?=
 =?utf-8?B?L3dmdEVtOGtBYWJqT2ZuTjN3QTFMRHJMUU1uVTZmR3NXRGptVURzTllkSllI?=
 =?utf-8?B?OHF4ajJiWjBNR2kzb0VCMTB4c0p5N0RQY0ZYS3VRNzdZa0o2NmJkeVJwMzMx?=
 =?utf-8?B?REpKNmw1dzlqbHVlREE0amR2UGR2RUt5eGIxQ0ovYlVQTzl4a1VTVncrTGtX?=
 =?utf-8?B?U0JnTDJjNWFkWThkLzZwdUxtR1ZqdHFvTG5tNHd5ektRT0VXTEtvTmRIQkU5?=
 =?utf-8?B?Z1ZicnE3bWtMaDVxbU93ZFpDL0pnZHprb1g5Y3NJMkNNK3c1MUZBdisxazhw?=
 =?utf-8?B?MFlyU1pJYnNKZzh2MWhNQUpvSmR4blpBTzV2ajEzTSt5S1NwckJOSCtOdnpy?=
 =?utf-8?B?VTVlTHN2UXY1Wk56NWhleXZpRnlCckFCR0VPVzZJb2laaTcwdGRTYXJTWjRx?=
 =?utf-8?B?Zm9ud25admtJYnRUVzNnbXF4aEQyOXVxMjVxeEpOMnpsQVV0SUpmcjFMMzRM?=
 =?utf-8?B?MzBEbjhYeWJiVHFGS25TTWF0SmIzMUVvamhFVFhkUThnU091R3JEK0lNcEZK?=
 =?utf-8?B?dWVwalZkMFhQZm8wOWlaSDcvOXBicjVBS2ltTW9lRlQyZ3RUODl5QUppeTd5?=
 =?utf-8?B?Q0V0N1BWYS9YSDNsbnQxY3JxTzdyUVA1SmgwbnJCMmwvUlZlZUNPQy8wa3M4?=
 =?utf-8?B?NVVNaldLN3V0bDlDSzVrMmFvTFl4NEpsVjBwNy9sMVlic0l0eDF5SExrTnRx?=
 =?utf-8?B?TTc2anpZRW9kUDhCZ3Z1U0xJYlFaZGdjL2pXdWIyV29jMG9FdEFRbUVJemR5?=
 =?utf-8?B?aG9lbUQ4VFZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enM3TTdVYXZjMVVqcHFEeTNiV2ZUMENzcm5tZHNqZGNOVWIzZ0NjSlllTkw2?=
 =?utf-8?B?OGJlY2lrZzZQaFVWM1A2TjBiV2t3c0xDTFgxWnhpWU5WaFNteW5Pa0FKZmFY?=
 =?utf-8?B?dm9sb0IvNXhQVzlVUzhYeEZHNHRlVEZFNnk0d1ArUllVZHFXaS9pY2MxdG43?=
 =?utf-8?B?eWl4S1Jxa0hwaWNmK2dVUXgrejN1OWZMZWw1WFdIVXh3UXV4QVhKNDJQKzUw?=
 =?utf-8?B?blBjaTcrZXQvVUJNQ1pMa2V4VXNUbDVnb2JVdWplNmhjWVRvb01BeW5lM01U?=
 =?utf-8?B?V05UYnZJcmdJRkxvQTZZNWdaTFhJeU9lUVA0bkhJZG9rcmo2cSs3MEJaTWRx?=
 =?utf-8?B?Qjc1ck1tdzVObFRPVzc1VjBodjlKMkpOOGU2dk5PbnFMbUxIVGJjem5obHEx?=
 =?utf-8?B?TEV4bG5kNTZNM2x6bEdJRndSMTZML0dxclBOM3o5NzdidVk4OWRJVGlSN3o5?=
 =?utf-8?B?VlpSbGU1ZDVvWkw2YjZaaGNQaUpadGppTm5DekU5VENoRzBucVpmZUxpeHBM?=
 =?utf-8?B?QzZ0RFJiek5UU1FITk10dENJRGNTYVNZOFZWb1VmMkZWa3FaSkd4dkQ1cE14?=
 =?utf-8?B?RC9KTDhYUDVOWUpaYzdmVXVncmtBMFg4Qmw3akZQbEdqUGtWaVFXdFRSOUxL?=
 =?utf-8?B?NWpHYVlnUVlJdW9uekFQcUV4NHM3ZUFkQTRwdnQ4aHdyM0pCZHVNQkhtUzhw?=
 =?utf-8?B?VDRacUVmQlMrRjhyQytGeFEvalRLVDFCOXhkb1JxR1BvNnllVWg2U0JiTURp?=
 =?utf-8?B?eEszd3AxM1Y4VlB2eGdoQmZFRUhBL0tkWGlWOTdQWGpXc0NLVFhMaXl0ekVQ?=
 =?utf-8?B?ZFl0VjNSdGR1cnlMYnBZZS84QnBwOXV1N2VPaFV2MnhSYUtYSjliUmpwakRJ?=
 =?utf-8?B?ZmR5QjJxU1djTTVidHp0S3pmU1FMeXRyT09lVm1lR2VkNkl2NGtpMHQxeFpW?=
 =?utf-8?B?blJjT0kvOFppeHN0MnN5ZjIybUFIT3dNdjBNdE9STzhUQWM3NU1yUnZtamc4?=
 =?utf-8?B?c0Z0dERkaGFXRDFyU0w5N2pkK2UxdzdSMWtSdlRKQmVTclkxWWZ1ekJPcGp0?=
 =?utf-8?B?UGlBOUZiZzNYbi9JR21jaHFQZzhSQ3h4K1daU2FuTjhNK3pHaXpqcWVEbHhC?=
 =?utf-8?B?UlFWbVRWMUl6ZHVpRkNRQWgyWGpXMXhDaFl4SWphUXJ6RnM4Q2tPbmhuYktn?=
 =?utf-8?B?em4yQS9PaVpPTU9iTEVVRnJzdFk4RExkSWl4bUlEbHVWMFZiSjRGUTdmZmZy?=
 =?utf-8?B?MDBsYzlJenE3OEswMTFjK2NHN1dKOWtmZWc0QU0valFBdVJtWm1neDlnWllY?=
 =?utf-8?B?WGI2MUd2YkNYMHk0RG42S2pzcENOQVVFaE1UT3EvTS95TVNGc2RxS2Q2a3dr?=
 =?utf-8?B?eDNta1krY2NYQUdMc2ZieTZZeXY2c3BpSFUvdGdMeW0wRUUrVGlIbkVlTkwr?=
 =?utf-8?B?dDd4Tmd4VytTMUwyREszcW5MbEYrSG1GS1FrcklJZTloV2MrWmJaQWhBemsy?=
 =?utf-8?B?emdCK0dKOHo0dmI1VDQvTnJlMDArUGp3dnBwZ01aUDF6R0NWWHliQWZyZzVB?=
 =?utf-8?B?aHNQWXFVNjRFYjNYYkd0L3FjZ09QQnI4dWRocVVEakluWnVidkd1MmtDbnVu?=
 =?utf-8?B?c05LdTgwcFNoNkRhRC8zVG05ZEZPUDRKYS9USENSZmZ1Q3BPYWtPeld4bWNE?=
 =?utf-8?B?c3hFUW5JYVRFNWlLSkhCbjhyNUlLQWc5VHZIMjdxdHE4MlpVbXhLZDVKaDk1?=
 =?utf-8?B?VTNsVnNQcEpXNE1rOGtnYlM4UjB5WFlaUnBtYktYVWZybC9SOFdkZE5rN0pu?=
 =?utf-8?B?SWhtNzcxbUdyWVhhLzhzZnF3anBLdzFHK3VRUTlJTzg3RXZ0R25hNG9XeUZM?=
 =?utf-8?B?N1FVNEpFYThmeDZ3NllEYVhhRE50MllUUmo5Yk5XUDFZL1R0WFVudXlGSjNF?=
 =?utf-8?B?UDFkMjRUdEU0blk1VUo3ZUUvQUdQcmtVVHdqMWkzdXNrRGlxRllMN01iQVdR?=
 =?utf-8?B?U0JkampORFBWVEh4WVdWVnloQTMzV2tDZFIyTkQ2UUhKWWs0U3RJV0JYWUxY?=
 =?utf-8?B?TTdZekNFdWxDTzE2RXY2Y0puQ2ZoaFdCbmI2K0hWYmlsQmlxTHVZY0NrakU0?=
 =?utf-8?B?dHZ5R0lYaEEwNFVYSytMUmQ3dUQyKy9QK2Q5aWtvLytFbWd6cHFSV01Lcytm?=
 =?utf-8?Q?lzb1e+rkq69lZwR6kFBZGeE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc083d6a-af1c-4b33-4c17-08de1b039d4c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:05:47.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxSmMF8x7FrUgua2ZOPQOWbTcDYoNzlfzufJmdFsr0OyNBMmFvSFzqTzeOMy2d+sgweGYUfVIjJ7TJ3vUH97Q4AWYf1flXIVf9Bb4WQKerM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7002


Hi Ryan,

Thanks for coming up with the fix so quickly. I believe Will and David 
already covered the most points. I don't have too much to add, just one 
nit below.
On 11/3/25 4:57 AM, Ryan Roberts wrote:
> It has been reported that split_kernel_leaf_mapping() is trying to sleep
> in non-sleepable context. It does this when acquiring the
> pgtable_split_lock mutex, when either CONFIG_DEBUG_PAGEALLOC or
> CONFIG_KFENCE are enabled, which change linear map permissions within
> softirq context during memory allocation and/or freeing. All other paths
> into this function are called from sleepable context and so are safe.
>
> But it turns out that the memory for which these 2 features may attempt
> to modify the permissions is always mapped by pte, so there is no need
> to attempt to split the mapping. So let's exit early in these cases and
> avoid attempting to take the mutex.
>
> There is one wrinkle to this approach; late-initialized kfence allocates
> it's pool from the buddy which may be block mapped. So we must hook that
> allocation and convert it to pte-mappings up front. Previously this was
> done as a side-effect of kfence protecting all the individual pages in
> its pool at init-time, but this no longer works due to the added early
> exit path in split_kernel_leaf_mapping().
>
> So instead, do this via the existing arch_kfence_init_pool() arch hook,
> and reuse the existing linear_map_split_to_ptes() infrastructure. This
> will now also be more efficient as a result.
>
> Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net/
> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
> Tested-by: Guenter Roeck <groeck@google.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Hi All,
>
> This is a fuller fix than the suggestion I sent yesterday, and works correctly
> with late-init kfence (thanks to Yang Shi for pointing that out).
>
> I've verified this on AmpereOne with CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE
> individually, and I've also forced it to take the linear_map_split_to_ptes() to
> verify that I haven't broken it during the refactoring.
>
> I've kept Guenter's T-b since the early-init kfence path that he was testing is
> unchanged.
>
> Assuming nobody spots any issues, I'fd like to get it into the next round of
> arm64 bug fixes for this cycle.
>
> Thanks,
> Ryan
>
>
>   arch/arm64/include/asm/kfence.h |  4 +-
>   arch/arm64/mm/mmu.c             | 92 +++++++++++++++++++++++----------
>   2 files changed, 68 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
> index a81937fae9f6..4a921e06d750 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -10,8 +10,6 @@
>
>   #include <asm/set_memory.h>
>
> -static inline bool arch_kfence_init_pool(void) { return true; }
> -
>   static inline bool kfence_protect_page(unsigned long addr, bool protect)
>   {
>   	set_memory_valid(addr, 1, !protect);
> @@ -25,8 +23,10 @@ static inline bool arm64_kfence_can_set_direct_map(void)
>   {
>   	return !kfence_early_init;
>   }
> +bool arch_kfence_init_pool(void);
>   #else /* CONFIG_KFENCE */
>   static inline bool arm64_kfence_can_set_direct_map(void) { return false; }
> +static inline bool arch_kfence_init_pool(void) { return false; }
>   #endif /* CONFIG_KFENCE */
>
>   #endif /* __ASM_KFENCE_H */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..0385e9b17ab0 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -708,6 +708,16 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   	return ret;
>   }
>
> +static inline bool force_pte_mapping(void)
> +{
> +	bool bbml2 = system_capabilities_finalized() ?
> +		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> +
> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> +			   is_realm_world())) ||
> +		debug_pagealloc_enabled();
> +}
> +
>   static DEFINE_MUTEX(pgtable_split_lock);
>
>   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> @@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	if (!system_supports_bbml2_noabort())
>   		return 0;
>
> +	/*
> +	 * If the region is within a pte-mapped area, there is no need to try to
> +	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
> +	 * change permissions from softirq context so for those cases (which are

I'd prefer use some more general words, for example, "atomic context, 
for example, softirq". We are not sure (maybe just me) whether this 
issue exists in non-softirq atomic context or not, so a more general 
phrase could cover more cases.

Thanks,
Yang

> +	 * always pte-mapped), we must not go any further because taking the
> +	 * mutex below may sleep.
> +	 */
> +	if (force_pte_mapping() || is_kfence_address((void *)start))
> +		return 0;
> +
>   	/*
>   	 * Ensure start and end are at least page-aligned since this is the
>   	 * finest granularity we can split to.
> @@ -758,30 +778,30 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	return ret;
>   }
>
> -static int __init split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> -					  unsigned long next,
> -					  struct mm_walk *walk)
> +static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
>   {
> +	gfp_t gfp = *(gfp_t *)walk->private;
>   	pud_t pud = pudp_get(pudp);
>   	int ret = 0;
>
>   	if (pud_leaf(pud))
> -		ret = split_pud(pudp, pud, GFP_ATOMIC, false);
> +		ret = split_pud(pudp, pud, gfp, false);
>
>   	return ret;
>   }
>
> -static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> -					  unsigned long next,
> -					  struct mm_walk *walk)
> +static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
>   {
> +	gfp_t gfp = *(gfp_t *)walk->private;
>   	pmd_t pmd = pmdp_get(pmdp);
>   	int ret = 0;
>
>   	if (pmd_leaf(pmd)) {
>   		if (pmd_cont(pmd))
>   			split_contpmd(pmdp);
> -		ret = split_pmd(pmdp, pmd, GFP_ATOMIC, false);
> +		ret = split_pmd(pmdp, pmd, gfp, false);
>
>   		/*
>   		 * We have split the pmd directly to ptes so there is no need to
> @@ -793,9 +813,8 @@ static int __init split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>   	return ret;
>   }
>
> -static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
> -					  unsigned long next,
> -					  struct mm_walk *walk)
> +static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
>   {
>   	pte_t pte = __ptep_get(ptep);
>
> @@ -805,12 +824,24 @@ static int __init split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
>   	return 0;
>   }
>
> -static const struct mm_walk_ops split_to_ptes_ops __initconst = {
> +static const struct mm_walk_ops split_to_ptes_ops = {
>   	.pud_entry	= split_to_ptes_pud_entry,
>   	.pmd_entry	= split_to_ptes_pmd_entry,
>   	.pte_entry	= split_to_ptes_pte_entry,
>   };
>
> +static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> +{
> +	int ret;
> +
> +	arch_enter_lazy_mmu_mode();
> +	ret = walk_kernel_page_table_range_lockless(start, end,
> +					&split_to_ptes_ops, NULL, &gfp);
> +	arch_leave_lazy_mmu_mode();
> +
> +	return ret;
> +}
> +
>   static bool linear_map_requires_bbml2 __initdata;
>
>   u32 idmap_kpti_bbml2_flag;
> @@ -847,11 +878,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
>   		 * PTE. The kernel alias remains static throughout runtime so
>   		 * can continue to be safely mapped with large mappings.
>   		 */
> -		ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> -						&split_to_ptes_ops, NULL, NULL);
> +		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
>   		if (!ret)
> -			ret = walk_kernel_page_table_range_lockless(kend, lend,
> -						&split_to_ptes_ops, NULL, NULL);
> +			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
>   		if (ret)
>   			panic("Failed to split linear map\n");
>   		flush_tlb_kernel_range(lstart, lend);
> @@ -1002,6 +1031,27 @@ static void __init arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp)
>   	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
>   	__kfence_pool = phys_to_virt(kfence_pool);
>   }
> +
> +bool arch_kfence_init_pool(void)
> +{
> +	unsigned long start = (unsigned long)__kfence_pool;
> +	unsigned long end = start + KFENCE_POOL_SIZE;
> +	int ret;
> +
> +	/* Exit early if we know the linear map is already pte-mapped. */
> +	if (!system_supports_bbml2_noabort() || force_pte_mapping())
> +		return true;
> +
> +	/* Kfence pool is already pte-mapped for the early init case. */
> +	if (kfence_early_init)
> +		return true;
> +
> +	mutex_lock(&pgtable_split_lock);
> +	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
> +	mutex_unlock(&pgtable_split_lock);
> +
> +	return ret ? false : true;
> +}
>   #else /* CONFIG_KFENCE */
>
>   static inline phys_addr_t arm64_kfence_alloc_pool(void) { return 0; }
> @@ -1009,16 +1059,6 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>
>   #endif /* CONFIG_KFENCE */
>
> -static inline bool force_pte_mapping(void)
> -{
> -	bool bbml2 = system_capabilities_finalized() ?
> -		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> -
> -	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> -			   is_realm_world())) ||
> -		debug_pagealloc_enabled();
> -}
> -
>   static void __init map_mem(pgd_t *pgdp)
>   {
>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> --
> 2.43.0
>


