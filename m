Return-Path: <linux-kernel+bounces-821348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF80BB81081
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F396C525730
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F02FB610;
	Wed, 17 Sep 2025 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTQ5S+sJ"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66424288A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126730; cv=fail; b=Jn+qu2O0AfArx81UzQYLmcGSpkWDu7HN7bF+KWKVmn8+87k+plk0E3s4+i/j9ddmRApbAnk/DvltCdYmhfBU9t7bDSu/ypAr2AT9OkDtIQlstr2n8Xq+WlwfTxNTt5fh0ZKGVttlysdlmHM/CAcr4IMCiDEfZTCcrWEuoseSUQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126730; c=relaxed/simple;
	bh=VmlAnbQj4Rr9d5LYEsmNlfdKELddL06pK/21kn2E2RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K6QrUL+FMl2gr5hiNeVvREnyxkizOdtl/Wd00Wjb/aBg4ogLaH1q9A0DElvc5Ft1i/sOZ1YZhBH8ZAIxKXWbZlzhHik8y2BXfiQ9J0Vrd1+k69yqP9csLh2y9L8E8ekWWn3vBkevRA8b0pIYAiuJP/EUVO7B0d1gEH4e5Naic0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTQ5S+sJ; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmkYNZU+ANe+q60D0h8c92EyLF6KHCRrL1swgFViZlMSr9OJ6YYOKXCk6uEUOaYiOAcAPpLvk+9sRkobuMWKenMmW+rkDMZJjf3zitoitUo7nVAbKcxX989Gv2x5e9WHYGHXvVIOVbzGZOYkRw1gmBFhk3KPSGmsTqeI8COFacLhEIx0+y7hDfHVY2I20tpAfqdkqT8IbL3/T1D4PcVBCkOD1lqpTUEqCV5FIgH8WIrX6PcTomy/RM9UN2orhBkEM5FqCLnF4SnZ4Ow3U9dAeNzgXlgkAhQU7vR4Wu9+caO9XPIz05g+9EMwzGNEHAbgRlUPNBEAJmoP8cMaAqW8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b32zUIOjVzOhyXoC1fxXNglfE2mM4XOaMSItNlitTjg=;
 b=TwAjnlRaR4FWISIz5A3ZFMyVdzsdCspt+R1MF58sOS/Vs6FZh6mFJcpekk5S7IpwoPvTdBMX4asn4xuQA+E5W1dtOm9Wol03BbZQGae+UmcfnOCsd1zvn6GqJVRIBbaZtuPeau9aa+v7vHb5goZCqH8IJn+KQY3tUNMkagJNXwXCd6cWehO3S1QSoszkPNVaPbpp25j0SxZy/QY9JYkhrr5pLhBhcqT/+tmC5fGNOnvixXetu50dT59Zj5/2hJjfwtM7SbiSU2v66y7uVDOpADbvOT6jljfwGjnMoRxnnWcKMZRNGgiw2AY5ZDBPg6OpKThS3zifwC9AO5MtcmDlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b32zUIOjVzOhyXoC1fxXNglfE2mM4XOaMSItNlitTjg=;
 b=RTQ5S+sJVrNGsHr53VPQvic8okjugTSb5ih+eaHAnzpzKiZVfA8Fp2E7gTqO9WouATMpHoA3F2cGjT7PlZBWAzpIYnQ1huUEFYoy1oZsZfVOHGgZFt+GTSfnXalikE+yoQkr7ZDuYljNixR5cfiKGX5W7rO6bmo+A5fdplScJhdR8gqcqY+jFVyox6U97991VAOjwrfLaA8m22iZC2yM6MEQjWc9S8Lm38xWRnA8Lu1ZLu/9SbNYcbtqwaWp1CNqeRJU3wWOoIDY01L86jvBM0Q9/+LipSRbsU4C0mMxZfGAPSYKM+PHnuIhgDl+TckjkzOEoS40O78jO4FjUp+cNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 16:32:03 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 16:32:02 +0000
Date: Wed, 17 Sep 2025 13:32:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
Message-ID: <20250917163200.GC1391379@nvidia.com>
References: <20250917025019.1585041-1-jasonmiu@google.com>
 <20250917025019.1585041-2-jasonmiu@google.com>
 <20250917122158.GC1086830@nvidia.com>
 <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 7627c97b-2de4-4c26-3b30-08ddf607bb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFJUWFJiOFpQVjFUTjVyNTZ2VlVuYUFnVEc2VHVScGtYT3B1eGlTRDJyc0Q4?=
 =?utf-8?B?Rm52Y1BubFFaMmY0UGpZV05UVDNDRytqYUI0ckVWbUs1OGIxbk0rT0ZGZ0tZ?=
 =?utf-8?B?cUVnbTlxRzRURU1jMCtuMXI3TWdSZHpML3NzTmFMa0NmZTI2SDU2dkhGZ1A4?=
 =?utf-8?B?aUhwejJrS2RPSVZhV0l6dE9PaUJCRTRVWWZUMTZYZUdsRnJiVml3Nzh4bS9G?=
 =?utf-8?B?cHNaQjh5QVNUc0owcjUvek45YldsVGFmTGVvM3lLb0FZU2lGZXJQNzJiNnlD?=
 =?utf-8?B?dlUvcjh3ZFJLdE5sTE10Y3YxSCtsdDVaWTJuTldhdCtNZmp2OFRQRlJBNDQ5?=
 =?utf-8?B?eHlXWU1pdEJ0bitoY3kwYXA2Rm5RZDZTVEw2NWRMaXYwbEhueUdWY0hTQmJR?=
 =?utf-8?B?VC9ZRG1tcUszeU1zTStrb1M1NzI5M3BYN01sSkFET3p1SGtkaGZhZjM1eC9M?=
 =?utf-8?B?VEthYi9HaThyK2xpR2FmajIxM2dxeC9EMi9SUExxQUp1K3k2VFUxaUlBbmNY?=
 =?utf-8?B?NXBwT0ZDK0o4d3kzT1BIbUpOSkhNcXoyYi9aT2t2WE44Wm5UL0hFK3JyeUpU?=
 =?utf-8?B?ems5RXZRRnJ5WUZBYUM3VE1XaGJUK0lVVUh4OTRWYm9NS1huV3ExZnR2eFJa?=
 =?utf-8?B?Y1MyODluODByZEhHMTMzRjlRcm9OOVNvT2Fzc3lBcHRYOS9pLzJsaXExRm91?=
 =?utf-8?B?QlJjWjhXNmpLSVZFZ2hMVXFBZExVWk1CT1FuQ1pXZVB5QS82d3pxcGhCZ1VI?=
 =?utf-8?B?MldseTdUaXBhYTZ6QkNtZXpQdVJZeUhvR1hhNmxTeVRkTm5uaUJ2a0JrSlpl?=
 =?utf-8?B?Q1JWbjJodWJ1S2ptY2lzRkxScllqbWJIMmJuTFpZWXlEYnhMSkkwc3VuKzRv?=
 =?utf-8?B?SXlFTHBGSVI4aUZZcmNEK3pZY1NjS3lvRTNsQUl3NTkvMUR4bzBDSHdlUDh1?=
 =?utf-8?B?VTJxQUlybzVENTZySExEdkZQL05kejI5ZGkyeGRLQVRwb1ZxaFlTL2RvbUlC?=
 =?utf-8?B?eHRxQmViNnpMV3NNNTJnUmhUM1lxWGZ3eHZOR1pSVS9lQ0NuVE9DSHdyZE5x?=
 =?utf-8?B?b2pnb2tvbVJpQ3l3T05rd2hkYVl2ZnhVWG9XbzJUSmlJZElTd2hGdzlwVXhV?=
 =?utf-8?B?U3hjd1N5T0dxby9JOVZBOUMvOXYxYzBydjc2WFVZR3NCNXJ5NFE5eHVZL3VG?=
 =?utf-8?B?YjVFN1haUWZDWXQxZVg3RVljWFpjS2JialVHYTM1SE9wYTJIbnBzSVN0eEpN?=
 =?utf-8?B?QWQ0TEdHUlZmeGY3bFhqcnF3UGNqbUVUd0l4ZVZMNU9xeGJlWmpoOXYxcXpw?=
 =?utf-8?B?aVVkOG40eTlUM0NMM1dCQVh6YkJZWVd4Vlg5L2haMCtIdmk1MG9FWFBSZm4w?=
 =?utf-8?B?bm9PTzVPaDczYnpPdC9pdWN4eGU0ZE9CRnI1ckZLY2lzd29memtsUGpuVEtj?=
 =?utf-8?B?cmdaQ2xyZjNZTktXaFYxL0JwSFA3UXhGZlh5NjlUTEthOFJhNXlXd1lKdFB6?=
 =?utf-8?B?T2JqZjc3cDJHa1NBRkEwUklCVnRkZTFVOEE3ajc2LzhkaFg4RHZFRklSSkRI?=
 =?utf-8?B?T25PWUZtZGRSdGF3ajZ3ZFNaR08rb3NwRW14OEhxOGo2dXJmanUwS3NaOGo4?=
 =?utf-8?B?WmF4YnoxQllzZlA4b0oyOHBVSHVYK29mc3BIamg2WU5KLzVLRVVESi9ISE5Z?=
 =?utf-8?B?UUVhRGZjK3pHRVE3K1dNL1o4MEJvaVJOZmNkVjY2MU5neU1sR0FBM25kYzFR?=
 =?utf-8?B?aC8vWmovaWNJUU1SSk1keFJKa0YwcW1BNEx0MzRBMDR5WjdnMUh4T1hwRjJF?=
 =?utf-8?B?UStyQkVsWWRTVy9wVEY1MDZDdUo5emx0WDFVT2dWTjdJaFFCU2I1T1Y5bVNZ?=
 =?utf-8?B?QUpmTkZnUGdTOENnT1RhUGg4RHZGZWxGc2R5MmE1b2xhRGdyWVNWOTlvdHQ1?=
 =?utf-8?Q?w9Y1qxNyDrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lDb2ozaWtwaWdFa3RzRFZ2d2RoL2ZhRDlHNVdFZm5HOUp0UG5lY004dkdV?=
 =?utf-8?B?RDJMZjBkbGNtcTdmMEo4Wm9aaU5jR2NXMDJjeDNPS2JUc0llZURwK3gxS3Qy?=
 =?utf-8?B?ZWh6TmNac2lLYncvUlRtNkNSUHFpcnZqdmZCdVl2ZHM4cStaMTM0WGVGQWlW?=
 =?utf-8?B?Z3NYS3ArQ0cxWWZiOWx6eHRHeWpOR1dBaW9tMWJpdVNIOXlOazNjZGdSMDA0?=
 =?utf-8?B?Y2lqQXNBeFV3ekZKRVNlNU00OGVqdFBoa2NZNWlMSUtJdkU3dkhTNHlmbDZ5?=
 =?utf-8?B?MHdwNEdDNG1XZzd4RkRuUThrclhaK0hPNTAyRTU0c2FlRm9XRGRSNkxsVExp?=
 =?utf-8?B?S0hBam5NZmpqcGlhbUxlcTJ4RXJ2YnZ1YWROVE1LN1JVQ2M5UFliYU8wWG1h?=
 =?utf-8?B?bXAwUXdGUmEzR3JUNWx2d2pkYlg0S1FKeStpUDRZbW9QSkpDcEtCS1dvdm4x?=
 =?utf-8?B?RDFqem0xVXY2M3pWTW5FZ1ZhdCt5T2RmRHdZdjlEQi9nNXl2VHFEQWk5Qjlk?=
 =?utf-8?B?ZXhWcm5pVFhFVlhLNCtNelNkR1hIZ1Y3YUJqZnIxKzJSS0UzWHZvWUJ2Smta?=
 =?utf-8?B?dE9ldmo4S0sraXRzb2Q5TW0rUThjUm5zazhOVzBWV3hGaDFPOERZWGhjem5Y?=
 =?utf-8?B?L0NhWHhIL1ZTNlpJcmU0ZjhqUmtjN1huTzZ0d0VFOG1sek15TFdGRU4xMk5T?=
 =?utf-8?B?RExHSEUrdnRYNlMxdzVHdkdTbmVidEdvajRyU2RaZnplZDNEWG95N0xUK0p5?=
 =?utf-8?B?WWlXYzBiMjdFeUNWZkVXdUU0MGNwTXZ0QkEraWlNKzlRcTlhSXh2QU9JSHNJ?=
 =?utf-8?B?TmpNRzNQS3RHQkw5OXBHc2hSY3JZNmJPNm5ZTW4reC91bEJRL1lPTU5xeU5q?=
 =?utf-8?B?dVFrcXVUTDVhU2tPb0JWb1VsUTVCRGloSys4cll6SzA5M05URkhaK3FRZXY0?=
 =?utf-8?B?MGhvb2RtSjRNbFRDV0E2Rm5DSTlvQ204VENTd0cvUTdQTGQ5Q2xYN0g2Uzdj?=
 =?utf-8?B?aStOTnhjQ3ZlR0pOUnNNeS9rQ280cUtxODlsMDBpRXNrZFdRejNlUC9NZktv?=
 =?utf-8?B?RnNTb01xV1NOYXAwVmozdkRuUDh1U1J2UUtPNkcrWk5jb3V5czdIQWpNaE1E?=
 =?utf-8?B?QXYxVElBVFpHbkw4VDBIQWRRdGlxQzR5MzlWWUthUE5sVW4zVSs5UlAwWFVh?=
 =?utf-8?B?RjlKOExlSWF1YnNXbnJHWVZZYVI1TkJwWjBLRVdpMWt6RTh2K0Q3ZDBGWEpJ?=
 =?utf-8?B?RVh0YjBlbS9oUWY2T2NlWCtxVlowV0dEYmdOS1hLbTZwRDA5MnJYTG9zL3pk?=
 =?utf-8?B?d2FUM2x2QnZSVmhpcEhKa29UTVIwbFpyejkvVzdEa0xZVW9WaUNpTVl2WVdM?=
 =?utf-8?B?MGU0cnk1ZHowMWhxdmFHb0JHaXBUbHY2dHV6MDRoSHBWdWdJQUZiVUl3SWtN?=
 =?utf-8?B?d2p2MTVzYVVCaThoUmhKYktEUWtIZDJMejYwdWs1djBVLzY2ancrNUc3K3Ns?=
 =?utf-8?B?bmQxQjRPVzVJME9sWkoxUWcvUEQ4WmNjTmV1Y3RYRWs3K2hnbUk2QXRQRk9G?=
 =?utf-8?B?cG0xQjlpbFFtV09XLzczRWhMZFpKeE10c05sbGJGK3VmMU1RREgrZEFpZ2Uv?=
 =?utf-8?B?ZlJ5UlBva2phYWQ3N0pHcmpuL21QTjk0UmRXSTMwdXJIdzVvaTM2S3pONlRx?=
 =?utf-8?B?Rzl0Z2FpbXFKNU9NYXZKclNyWXVXQ1Q4RmExb0ZxZHFSY1FvYlZnZkp2NmZC?=
 =?utf-8?B?RTYyaEpYODFvbWZHR05JMTgrd0EyR0JXK0pwZnVISm5pWEFwOThKMXZ4clZW?=
 =?utf-8?B?YXVGTHM4YldxYkJoWkFlZWViOTN1TjBmU0wzY20zK0NpdGxVNzN0MW80TU4z?=
 =?utf-8?B?TVRVdmxMSGtxS0RiVk9DOVRqY3F4MjU0WXkxSjdBMzhORUdxdWRvU2dCT0FZ?=
 =?utf-8?B?b0VKN2w3bVhDd2dDZnI5a2c3M1dNRjk5QjlPWkE5cnpIbDFBODRhUmtqOUdu?=
 =?utf-8?B?MHVZNjg5dzlJWVRUalFsU09XTTQwazNWaTVPdS9GQkJUMWVKYmozMkw2VFg1?=
 =?utf-8?B?eS9kYWdDV0t1OTZmb3FSbmlZakc1eWxuM0dsaFphM3VCWWp5aWU4SUl6S1hD?=
 =?utf-8?Q?DNz6BRs1qkd6ji42y4HX2+t/H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7627c97b-2de4-4c26-3b30-08ddf607bb6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:32:02.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+8aUUqV6a10j2l/Ytt4P2MoWvAnQw8RAl0zJGRneEIgPdyriVlIVr494ucPSYLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

On Wed, Sep 17, 2025 at 12:18:39PM -0400, Pasha Tatashin wrote:
> On Wed, Sep 17, 2025 at 8:22 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 07:50:16PM -0700, Jason Miu wrote:
> > > + * kho_order_table
> > > + * +-------------------------------+--------------------+
> > > + * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
> > > + * ++------------------------------+--------------------+
> > > + *  |
> > > + *  |
> > > + *  v
> > > + * ++------+
> > > + * |  Lv6  | kho_page_table
> > > + * ++------+
> >
> > I seem to remember suggesting this could be simplified without the
> > special case 7h level table table for order.
> >
> > Encode the phys address as:
> >
> > (order << 51) | (phys >> (PAGE_SHIFT + order))
> 
> Why 51 and not 52, this limits to 63bit address space, is it not?

Yeah, might have got the math off

> I like the idea, but I'm trying to find the benefits compared to the
> current per-order tree approach.

It is probably about half the code compared to what I see here because
everything is agressively simplified.

> 3. It slightly complicates the logic in the new kernel. Instead of
> simply iterating a known tree for a specific order, the boot-time
> walker would need to reconstruct the per-order subtrees, and walk
> them.

The core walker just runs over a range, it is easy to compute the
range.

Jason

