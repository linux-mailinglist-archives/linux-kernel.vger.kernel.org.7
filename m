Return-Path: <linux-kernel+bounces-785908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18393B35261
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD446241780
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C502D29D8;
	Tue, 26 Aug 2025 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="vpeh8o5U"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5B238C0A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180182; cv=fail; b=LhoIMS4j/pyFfS0h/eNDJRf1BWwPNo5kiTu7/rLCx00Lk074dSJ8YXvxfI8KCEU1UICnnrgoJJaAGTY8ldmLzIk5ogoI2a3xu0NeH63LUZTbyzejl1gznUkgm/Dx1n6NzIG0zKIfWqjJgI5OiPJfHFQmt77dihJcZuMkCRcSSJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180182; c=relaxed/simple;
	bh=ZCC9EAQZ3G4n1FDShCuhT9U9Wcvp0U4lI/mSkhOS5ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XVK6Mof0Iq/OCjlJTUz3TI+xNNPTxmy8RTs6NRqLpGHm2BZ2pE61K8/tNBZ37VeYpaLja9P15B+lq/anoxDFqJUvMPwGcDJ8+2E8k6TCm2L3iPEPrLFidFAZxgEo9rPXcIoDy6neZuyRZ7qabyFNZerjalgWNIt9zIB4KMb+loo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=vpeh8o5U; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUVrWea+8A+DqiC01jun7X13+mx+jzDtI8IxCqoU+GWsuN9VYx4n02E1ha7tRcFQoUSTRi88pKzD1sXoKncrL1O4v1GZw80s1THSh1WJ+qgjOUqrLlPOrbiLL5NCFfZZxaGYgvwLVm6QOLqOTayKFpYaWlsoyHIgMBxHqEVI9fHH/+GRImx/oi22dqLXehH1fDLhYCdX2uYGddlVsZD2g27LsPD5NzEXBsEHMPwC3iBqbejjLQMS9q/WosjZSUohADJmEkPbZlXEkrnN1UpWQ8Z79SsGF/A4xc0Ch+PROBjcsfajvhS6th138Iys91jOk0JZdSEDXzX4rky8MNDJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNucvqzWyAjrRSZmOn+V7BcJ1WKNrby3U+n05X5gd/I=;
 b=by3acM0TUstS39CCO2JeOnS5om9eRmtkOPZVvANDMSstsd4QnDB+ocZhv/mDgiMCEGGy5868gfYIYmRAfJXGnUeR20E1Eq7wGLky2HC8TyG2SI2Hl8ZofimaNGIhaAvuBcGY+ocoDlSq4gxs/4FRRCkaNvTHJfkiW/5+Q6AwIyKJ0BP8OV2em5SthkGQCpN8dC7wUqxk47fB2ha5uwR/59GHokzXXlcSJMuHWMk6jPuxDl86r8h/OR0NuwnYn86reO6Bx4rGjNUoZEwVPcahXinlCfuYxJuMdVWoYp+iDz5F9EUBlIHGwN6okGYEsXNCyOS0Dwdo7HEqpXJ0EEJ9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNucvqzWyAjrRSZmOn+V7BcJ1WKNrby3U+n05X5gd/I=;
 b=vpeh8o5UBw+5/PBcjznCj51hzXK0uxe3K4rksBAzmVKJvN0+4IRwUh6Un4x0vNcfjNGFkDBw2P8XlBPuaFO+HQYugv8E8L/kB+BQdkLTRnJSg15lq1cyvsI+RLtjLMyxYRuIt0YbDpF7VK30YPqYHFQh6i5HhMdGQgK9JThQBGQB5Pp3FYimRVQG3/BwajO0EWfLYMPHuH2ofZmAs/iRwyBQXa78RMYIdRPD25WRizleGtMSsJDHrJcHFZ88thlgWj1PFinOPo0rZv9dzPx51Nk7MEFtWxcCCb1Otdh5F3RRlWXNLSq/tS3Q6sl8JXCk3fv3Ai8J5OiO3Rdeyqjvtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by BY1PR03MB7288.namprd03.prod.outlook.com (2603:10b6:a03:52a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 03:49:37 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%2]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 03:49:36 +0000
Message-ID: <7276113b-28bb-4347-9e7d-6b63fb03a36b@altera.com>
Date: Tue, 26 Aug 2025 09:19:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] firmware: stratix10-svc: Add mutex lock and unlock in
 stratix10 memory allocation/free
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250722163045.168186-1-dinguyen@kernel.org>
 <2025081920-greyhound-discuss-79b2@gregkh>
 <0bee0edb-5a3b-4648-8ca5-ad334220f092@altera.com>
 <2025082234-scarcity-relive-9362@gregkh>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <2025082234-scarcity-relive-9362@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::6) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|BY1PR03MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a5a785-362b-4591-47e9-08dde4539343
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW5kSmlOS2lFZkN5RC83Rm5DcWhSYW14S0FZYzNJcUV4NHg0NitWbGhEaytW?=
 =?utf-8?B?LzZZZDM3OUpkekhNNFYrTG5Na1ZsTWY5WWJ6bnBhZXVsdXBqaHhlbzJvOEVO?=
 =?utf-8?B?TERPYzRnL3JxQ3FHMkJiNlUwY0hBMVRESXFnWndoZVJaQ2pLRURkdXZlSjFC?=
 =?utf-8?B?R243aXAyS0x5TWlLdG4wdFo5aW52cnlieW91STlaRU94OUVsTjRUVG9mMUg2?=
 =?utf-8?B?Tkp5RW9QTzV1ZGdjRndrNTFUbmhkekM3bVkyVlViRmJTV0lrb1pjeTJzMU5F?=
 =?utf-8?B?bnNoT2ltR3JZR2IxUTZPZXRxeURtL2NTOUpsTFhsTndiYkFVMlYxZnJEM3Iw?=
 =?utf-8?B?cDR6Y2R4ZWhrS1d6bUVkN1NsanFqcjVwMG0yOGc5bTBIdThEMDVrMWp0WmM5?=
 =?utf-8?B?aWJBc0FjNHhUN0JGYnptcHovZHRWaGJPS05SK2UyajN0bE12MWRib05HN0FH?=
 =?utf-8?B?aHJmaDR6ZEVnSGZoVjlDWDQ4KzJhdWE4a05BYTdXazYwQVBIbHlENUZKNVJG?=
 =?utf-8?B?c2x3NUtwU3ZOdi9MU3pYT0Z1RTBaMXJtTVN5UnNPeEdkUmtjMDZ1cU9wNkZo?=
 =?utf-8?B?YWhYbXpzbEttbmxMMlY4SVduUXV5bGxQS05mbkttSWdISTFCU0ZDSnRKL0E2?=
 =?utf-8?B?R2d2NUFNSUxTMmlIaDRCeXJkc0I2RzZlazBGRnFkZnRqUFNzOWlKQ0QwYzhX?=
 =?utf-8?B?eUQ2bXR0Uy84cGRaTXBPZE92ZGQrM2VVbTJadjI0dE9SaC8zbG1aOXVoVW4x?=
 =?utf-8?B?R3pEMWE1K2xJaWRTOXhVREk3R3NZS2R5elQ1RUN1WmY1VkNRUzEyWk0wRGxo?=
 =?utf-8?B?MWRPQkJERDNzQUhFYmxWdjllbDRMcGpuaWVITjRkc1JXc3FuTmJRVTBxZGN2?=
 =?utf-8?B?L3dvVFRaUkp1UFkzYU1wRm91L0JvNVRRUXdBaXJLMk9PSGR6TlVMMUtmdkpr?=
 =?utf-8?B?VThDT3ZzV1pYaTQvK210M2d2WDRQWVQrdGpyMmJ5WndQdlI2L29xdVpnZm1L?=
 =?utf-8?B?WStXcndwSjNma0RmMGdadnoyR3psb1dnSHZwa3BxWEc2NGJPWE9mNTZTQVh5?=
 =?utf-8?B?NXREMm9oMkV1RG1VNU0vNEQ2eTJGZkNRWVBGYy85WXovNlBpcHlIWDhJZXhh?=
 =?utf-8?B?UkN3SFJXUzlTeW9zaDdueDNLdXAwcFIrYzF6Y00xVFQ5SVNqWi9DOEZUK0ho?=
 =?utf-8?B?ZmFYdTZRd0MyK0tFODJBVFNmZXFSWHBKZW9Rd3pQMFdralY1K3NNdm1KZElu?=
 =?utf-8?B?M0xBRXRTM09NQTlFZDZ6SXU2NzIrSmdydlN6TGN6eFB1aUo4TEZyd1dkVnZZ?=
 =?utf-8?B?Wm03c25taG5NTlpkUU85OHM3elI0OW4vV3YwRFhtektIMG84dWNoQXp5UkM2?=
 =?utf-8?B?Y29PbVN6bFFEUklXeVFsb2QvN1BhRmJycFV0cEc4VklRTTV1aUt6UHZqUmsw?=
 =?utf-8?B?RVJiRVJoK1RZSCtzenhKeGVnY1IzQXVBUHRWR2d2VFZYbzgwd241ZFh1Y0hw?=
 =?utf-8?B?SVFyNzBMM2ZtUmExdVhpalU3M2YvVWhVZWdteERNVS9FaS9teVliZjhlSzRH?=
 =?utf-8?B?M3ZTaHVJNHU0Wk0zT2F4aW9ITFNGWWt3UnJSeFJPdkhlbXIvK1FBWjMvNlZq?=
 =?utf-8?B?YTJSK1Y4OVRZWDR0OTY4T0dnOWdta0Jna3NhU1hBOHhOV3c4Z0VWRVphN1Zl?=
 =?utf-8?B?S2F2U2J1TXljeWkrWGFXeFlQcUhDdloxVXB2U3RSZ2R5NTJPbFBkUk5wQlN3?=
 =?utf-8?B?OEJZOVNoeER0M1RRUTZ3bS9JZUZmZ0FIOFRLOVpZemlGSlRtbEFYMHBoaWwy?=
 =?utf-8?B?UXpXMGdnWDlncTYzK0JGTzVXUTdpeHRtc3hVaHV5Nmc1c0dWUzlIZmRiK2VJ?=
 =?utf-8?B?NXJWUEVYWll2K3I3TTZSdGZOTE1YbVBqampBVmV4RFN1dVd4UTROZDdnbnRM?=
 =?utf-8?Q?Si9iBSKcEkg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWZDbEZDZk4vTkpGM2xrR1UxZFBneHBJOU12dnZ5UVFNYVFyNlVmcXFEMHBB?=
 =?utf-8?B?S3J1bUJxQmc3b0d4WjY1YXgzc0JwM2hFbURhVjVCNG1UT3BUZXZSZlFTYVU0?=
 =?utf-8?B?V0ZML3ZCQlRSaURXbHcvWGtnc1Q5U3FjWnRNak14Uis5UERsT0t5SGNvdkJP?=
 =?utf-8?B?dWlyVm5YOWRncS8xeDd3UVZlQlJRdk45MjdzbU55enhvSjhPVzFyWGlZWUZq?=
 =?utf-8?B?Ui81SFlMVjZNRjE3aklqa05aT29lVTZhdXQzVFBueG42elB3cUNjeWZaT3k5?=
 =?utf-8?B?bHVsb1hNVmxqZlgwWFZiQTJXMlBkaXFlZHBCQmxGczYxY3J5SEFHNlpYWXR3?=
 =?utf-8?B?VnNERjhad2xYVFMwbWduSkpibW96YmR2R3VDQ1Y1ZkMyKzErRjhwdm53WlZr?=
 =?utf-8?B?TzNjNlMzdm92RW5kelpmUllYTGYwNVNmUzB3N2V2SnVIUUpITFpEUHJGcDMx?=
 =?utf-8?B?SDFxNHRWQTU0TVJCcDlUSW1CdUxpZU5udndBMjVhcVJybzR3R1EyZGYzZVo3?=
 =?utf-8?B?VVdYSWZHOG9mc3Y2TnFzR1RsSUZsczR0a01TaTdic3huMC9sMFZDZGtzVWlV?=
 =?utf-8?B?c01qQ2wvT0IzTk5NQi9xbjBvR3RXTU5lQ1ZlejNnUngybVArWjh1bE5jaVJ3?=
 =?utf-8?B?eTBzc05hNlB2UWw0ZnFBM3czbGdiSXQyU0tScFVGcE1ZTFhQR3BVWFFKdTAw?=
 =?utf-8?B?dG1PTm5KWGlhVUdEbisvQmh0d05Ud014T2lzcEZibHhCaXQzd0ZORmZkK0lN?=
 =?utf-8?B?RzIxQVhveEY3R3ZkMXJVMFFnZVpBZDVXTE1mWmpPTVN4Rmd5SUdERU10a1hs?=
 =?utf-8?B?YlRoTU1tVGR2Rml1eGVHUDJrNEdxcXJpMWV2SkY2elVmWUZOTFFtK1E0OXRS?=
 =?utf-8?B?a2xCZ0pneWVQNmVkaHJ5Wk1hQUlPVGhIVExDTlJkWnBTYytnOGJuVVF6OCtx?=
 =?utf-8?B?VEZvd2JGVnMwQklaYXVQRXc3RnBqQUlPZGxHNnBTMFZUSEY5dlUxc3o1cm5R?=
 =?utf-8?B?VDlESm9MSTdveCtYWXpRWmcvTEJ2NUhJN0h6dFhiK0pJbTdKdWc0S3RHbTBj?=
 =?utf-8?B?c04yVHRDRFZITnYrY1hKZEVoeWRsNmF5VHdmaWxydlIyeFBmeHB1Wi9yTkhC?=
 =?utf-8?B?aXJnWU8vbENaWVRuQTdaZFc2R3JXY0kyd2ExSnNtRy9zQXZhczlpSGppZ1ZZ?=
 =?utf-8?B?cWUvK21XeVlBZFB6SFdOajBOY2p4MWN3bEU3WmJpaGJCOEhvSnJKZ2wyMVRG?=
 =?utf-8?B?ODAvRmVJdmRuMlB4VE1GYmEwS21FT0N5RlZ4cEsrdlNJa0Mzbk41YTlxNEsy?=
 =?utf-8?B?VXRVYzFwZ2dhTUV0eVVudWZnQUE5M25KdWtlREZGSmcwVVk2VHVrRTU2RjY3?=
 =?utf-8?B?eXZKRHdlb2lMeVhRZVpIb1dSWmFjRmNsVkduVHVLRURRb0hMZDlzVTNiVFNM?=
 =?utf-8?B?MU5lNGd0dnhlQW5YT3MwRWZkZzhoRTFKN0xpVkVHdEcrNHZINXltaDFNU25z?=
 =?utf-8?B?UUxLSDFua1hiSUh0dS9Oc0F5dklyT3V1WExzaVh4U3RDTTRiQzlNL1psdzNJ?=
 =?utf-8?B?djVzUDVSaFlia0RSNWxJdkw2Yk9pL1RzQWNVOTUranUxK3ZtQkw5dEkzcGl3?=
 =?utf-8?B?MEt5T1crSjg4aGFVUE9uZFY5VDV2U3Axa091WHpCOVdoNWJaekthUWI1Z0t5?=
 =?utf-8?B?cWlTamtZSFJRR2tTTE9MUkNKY0pzYUFPTENTVW9QY3Y5a3RQTkRCc2VPYTd1?=
 =?utf-8?B?ajNDMVBabjJVaTV1a2ZpWUxNd3MxRWY2L1FwWmppNFErZUxnUkNhL05hSnpC?=
 =?utf-8?B?dGpRaDZKMjFES0JVYlQ5TnZQRTZJMEFteGE1U2tkaDF1QXhSS0tUWkJHNVJk?=
 =?utf-8?B?a0w2ZWc4dUcwS2t0RDRZRWlRNVlrd1JWNGxjcjFMdThDUE0yMzd4SjMxUGtR?=
 =?utf-8?B?aEJQV1JpR2F6WWRRM2xLVXoxVnBuQnNwYUF1eTgzVnA4QnlablJXRzJYN211?=
 =?utf-8?B?S0JiTnpZQ1d1eWp2VjYyWmluTnE5M29UMlJYeXVSMXluZ0g4ZERCVzRiZHlQ?=
 =?utf-8?B?Y0g1NEJkZ2V5VWs2Qk9xRDVIRGlaeWxKOEp1T09tVTFxRGFIRFBjM1VVd2JH?=
 =?utf-8?Q?bscXY7hBiHt6t5GzjifCg6VHx?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a5a785-362b-4591-47e9-08dde4539343
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:49:36.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cggmeqmRwrCC+rcpHCZkX0plw3V8sMnD8argLJFdoK+XEY8YmUUxqd5yoBf/YjEXLVnbXvH0kkvl74S+/yrbaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7288



On 22-08-2025 05:19 pm, Greg KH wrote:
> On Fri, Aug 22, 2025 at 03:17:54PM +0530, Mahesh Rao wrote:
>> Hi Greg,
>> 	thanks for reviewing the code.
>>
>> On 19-08-2025 04:36 pm, Greg KH wrote:
>>> On Tue, Jul 22, 2025 at 11:30:41AM -0500, Dinh Nguyen wrote:
>>>> From: Mahesh Rao <mahesh.rao@altera.com>
>>>>
>>>> This commit adds a mutex lock to protect the
>>>> stratix10_svc_allocate_memory and
>>>> stratix10_svc_free_memory functions to ensure
>>>> thread safety when allocating and freeing memory.
>>>> This prevents potential race conditions and ensures
>>>> synchronization.
>>>
>>> You have 72 columns to write a changelog in, please use it :)
>>>
>>> And is this fixing a bug?  If so, shouldn't this be tagged for stable
>>> and add a Fixes: tag?
>>>
>>> If this isn't a bug, then why is it needed?  How can these race?
>>
>> In the current implementation, all operations were performed serially,
>> eliminating the need for protection mechanisms. However, with this patch
>> set, we are introducing parallel access and communication with the SDM
>> across multiple client drivers. This change may lead to race conditions
>> involving the svc_data_mem list.
> 
> Then that needs to be said here :)
> 
> Also, what is causing these operations to be performed serially if there
> is no locking?

Use case wise, currently we are only accessing this serially. But I 
agree that there is a scenario where parallel access is possible. So I 
shall add fixes tag in the next revision.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
>>>> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>>> ---
>>>>    drivers/firmware/stratix10-svc.c | 31 ++++++++++++++++++++++++-------
>>>>    1 file changed, 24 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>>>> index e3f990d888d7..73c77b8e9f2b 100644
>>>> --- a/drivers/firmware/stratix10-svc.c
>>>> +++ b/drivers/firmware/stratix10-svc.c
>>>> @@ -1,6 +1,7 @@
>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>    /*
>>>>     * Copyright (C) 2017-2018, Intel Corporation
>>>> + * Copyright (C) 2025, Altera Corporation
>>>>     */
>>>>    #include <linux/completion.h>
>>>> @@ -171,6 +172,10 @@ struct stratix10_svc_chan {
>>>>    static LIST_HEAD(svc_ctrl);
>>>>    static LIST_HEAD(svc_data_mem);
>>>> +/* svc_mem_lock protects access to the svc_data_mem list for
>>>> + * concurrent multi-client operations
>>>> + */
>>>
>>> Odd coding style, this isn't the network subsystem :(
>>
>> Ok sure, will change
>>
>>>
>>> And what about a lock for svc_ctrl?
>>
>> There is only one instance of svc_ctrl and there is no parallel access to
>> it.so a lock is not required as of now.
> 
> But don't you have multiple places that list can be accessed now at the
> same time?
> 
> In other words, what is changing to require one list to require it but
> not the other?  Is there some other lock for that?

This is just a context controller having only 1 instance as of now and 
this context object is only updated during driver init and read in 
another function.

> 
> thanks,
> 
> greg k-h

Thanks
Mahesh


