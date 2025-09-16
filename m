Return-Path: <linux-kernel+bounces-819711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC63B7E8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCC4E0630
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA927F4CE;
	Tue, 16 Sep 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n/yUPXqR"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2C54279
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062824; cv=fail; b=BgNaSCHeChOuxQkSUi8CZ5I9/vXbFeiTE8JAWK3PQlcg/yzLFo/pFjWCcAv82BuheIrINRhmQlHCiOLm+7EdOStVAx9951KZ+ECYb8UPhZWAfVZp+4yfLMCNgD2z3E3QxIzO08aqi1HH8wwW5JnIFapXb4D/UTftHOS3hSsbY+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062824; c=relaxed/simple;
	bh=5oBA8Omndv8YSpocUE6TIpeH1KKAXVB4i7DbDUcaOdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqvzE9i5Rdo5vniDuk2EK21hfPIPZr+oVLfqKTxEjcHOkeQ+7UtE5B9pU8ion58d6DPMt/GbKfbdWjVGSgZUBs9jSoKisgzDE3ANGerKMu6LKXCm0GF6xzLgWf2KJMnqbopNw40ks8hkfHBVZ2x1W3mA1b8SIXluvwPUPWaUv1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n/yUPXqR; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyHXaDx936IylyEv5sR//KnkkUlQyPHqjuI4AhSAvrx2t2CXbEVnuBXyIpJFCaKas4uC6AN+LoiJ0e9v+HOtSu7YCL4l9gzckPun6j8/QCIh0YZ3BOGAgxmQn2oW/Idh/2xMGuNbrU38Ef4tRN/NMXBTOyA1CQ1zury6wvrZDlfgSDCpGmMR3uTqXySOnSs+7LxE1flheuJvHD7hWmf0hHQKzXaekcqoxPoFL4waECSfwBpzKUygfEywnw6wK7VtZ9AsATk0vbN05sm4mP7GzOs/lumVOYUSLt/0dsx1yfK7G/xg9FQgCsMlxrzr3/P8vvSyQUramzUosRSjbYSDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtUmFUy1PNhqOGZqRMZU+fVV7p0b70yPcyRwRMbAwwI=;
 b=WG7865wiUPlfmDGHRyghrkfg07wC4rzdK3ZpejyqtnGmhLm6ew3bqvgEio9u7lq+V3jqeINe7CpWol5O0xbQkMtkCdhTRwFr0CrgXV+ZKzsD0RB8Bt1hMr1pZCHYb1wRxFRHTm6x8Izv86Cqi1lfcZ087tZ30gBYDckUd2ixazJvWIMyzHpj5wBFL/PJDg4/EXWfABsnyHyKpZo0IoNyLyOhWEW7+/FDreb9/o/nqlA+C2/vEDXCCXQnPDlbPapIJY4ogcQz5zEnsLTVKITTo/EVObk0vDw7sDsFbZ/QXTYAGxXKiQRPWIkMcs+1lclaOPB1siLQKKfQSnc/13+sAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtUmFUy1PNhqOGZqRMZU+fVV7p0b70yPcyRwRMbAwwI=;
 b=n/yUPXqR9MtFclto/mszm84su4e/bcTl8OJ22wlzGItoG9w8TKFcTXmrWWg0ZHbM/dpIgqetbwdhr9xNXWn+ixpkFj71InXj+wA5V5q2M70l2ewQDEXWJ22re7nFm+bciPYAcjH3MtWam/jHSP97E7mnc92XccGJCJrACU2dULM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by IA1PR12MB7590.namprd12.prod.outlook.com
 (2603:10b6:208:42a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 22:46:59 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 22:46:58 +0000
Message-ID: <6d25c7a9-02f9-481f-9eb3-b1f6e3276e58@amd.com>
Date: Tue, 16 Sep 2025 17:46:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Fix counter auto-assignment on mkdir with
 mbm_event enabled
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
 <437d6c22-f232-48a0-94db-a395aabe85d5@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <437d6c22-f232-48a0-94db-a395aabe85d5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: ea60767f-7e75-456a-4185-08ddf572f1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2Y3NlRGZnVleFVXMlJnOGgvRFVsRXhSNW5tdmFxV2cyRXBjZGlSSXBmMVNN?=
 =?utf-8?B?eFVVSWpkSVErTFF3aElsZHoxZ002YXVSNmpaR0ZqbUFPQzIyOFl2RUtFbThU?=
 =?utf-8?B?UzBiOWtzNTZnOS90TllmSWorOUZlUDFCQ2FlWjFFem1QU0xPMWVWWDQvMHlt?=
 =?utf-8?B?dFpmbGR4NXdGOTR1cjlOQ1Z0djluWHFzd2Z5U2hQSnRFL0VQZ2R2enAvQ1Ex?=
 =?utf-8?B?TFpFZDExN2NuNTgwNDk5NEhXMDZIb3lTUGkyZkkzQVE4ZDhPU2tza25hSm9E?=
 =?utf-8?B?ZHUwcTJFTUVEQnNBbG1kcWZxVXJxZzRyV0xmWitIbkZJcG83TWd2WU5GT01Q?=
 =?utf-8?B?QVlVMkdNUEhPaW5DTWV5OCtGVUszcUhvQWVsMjN6ampySUY4aGkvT2gvdW1r?=
 =?utf-8?B?cGt6aUZXY2lJbFhnY2VZK3MxZEVuQWFuM3AxekNIUEYrSEVJWnNucW9Td1JV?=
 =?utf-8?B?dHlXaHltOFd1M2pKV1pqSGJ6aEdLL1FYcTlHY2RWd29hVzk0bTV4d1paNTN4?=
 =?utf-8?B?cEdhVnk3RHJTNXVZa3ZIUlpGdVcxVHVtcDZya1A2NmlnNWdhVTQreHR0N1hK?=
 =?utf-8?B?SC9UMlVqTG5FcXZ3REhGa1NCK1U5NkU4WGhCbTRTOXRXV1lGTDhMSm9VWE1s?=
 =?utf-8?B?NHZLSzZjdGdWNEZoWWt3OWxLbW1tdEI4bjFWK1F1NEpLZFRYMmthTWF5UUlm?=
 =?utf-8?B?TVhFL3JJdjJlTzNEWFJtWXJvRDRWZnQzSFRJL0RkUFpEaTV5b2VRcGZycUdW?=
 =?utf-8?B?K3I5Qk1qM1JXYTlWM2lMbmlRNzB5eDBGdTVUMUlSUlRDOFFMeGx3dnBKcE5H?=
 =?utf-8?B?Y2ltOXBVU0k0NVQ3YTVuOGpNYmcwUGV6MkZBaEdrU0dzbHMvZ21ZUW1WdDVu?=
 =?utf-8?B?WnpUUURlM0Y3aGNIVEhBcEpEVjdiMC9FZy94Ymw5bU5adGM0OHduRFFsVmRr?=
 =?utf-8?B?SjZjWG4ra0U1cjB3S21FNTFtY1Z2M3NnWGUvVjZUT2F4SDV1Mi9vd0pCMW9E?=
 =?utf-8?B?ZEZyOTBHL3FlS0VTYldUc0hMVlV5RkJNdjk1c3B1NXYwT2xxZnBXMzVLdWJZ?=
 =?utf-8?B?U2FwckJJdVBGeDJKaFV4NE5lZS9ZT2ZUdWI4QnZNaWR0aEtFUGNobC9qUzFZ?=
 =?utf-8?B?UGtmeTJBMitPOGUxbXJ0bkdXUXQrM3pJLzNmU0JRejBrWlZwN3ZCcWZMcXpZ?=
 =?utf-8?B?a1BlVFFaRzVQeGxtOEkweGxJaUdtbUlhK2dUd0J0d0N3S2xYZXkrNytHc2tL?=
 =?utf-8?B?Y3dMSTlCQ2ZhOUw2aGhFdlMxTytQc1FyU0RoWDFiTEgvMjB1MzZUaWNLaHhy?=
 =?utf-8?B?TXhHZmQ4LzV3bGhLVjNPMFAvQ2JUcHVSOURKRVp5djVZdW5rWnpuNHI3cjNy?=
 =?utf-8?B?NE1ya0gvQS81V3REaTJTc3lSNVVGVzNCY0FsVDR5WVE2Tk5NTVdQUkVIVzVh?=
 =?utf-8?B?b2hqcmtYQzFEcmdkSzRkRlMxMGNjbE1rdUN1QXBvQkY1ZUNzenIxQjlsVVo3?=
 =?utf-8?B?MFlnZ2RWNkVDekM4OW1jYjZxT0xUbm5hNngzRjVibWV0WXRDNFFJZ3J5cjlz?=
 =?utf-8?B?UXZ1alNIMFVtYVNuUTVYTnM1SFZTWVJNaE9vQ2lqTGRMbmJqdXFONDVYeHVW?=
 =?utf-8?B?dUhub0M0c1hHQ055M3JLb2JId2lwMENhc21iYWIzYk9kUmNwazVHOGtuUzdk?=
 =?utf-8?B?MEdSQ1hLM3RNUG5EUVpMaGdzZHhiNGIvNlJZMVE1eVQ3Qk5nSlpYUXh1ckJH?=
 =?utf-8?B?MWl4UURMTlBoOTBRcDlSRTJocTYwQU1nMzQxZ1JldmtzZ013bzhOV1E4WkJC?=
 =?utf-8?B?b1RGaWZhdzBSSXg2V0QxRm96dDh6SFd3WklzZ0hyaGRmVHpaQytsUGNTTzRn?=
 =?utf-8?B?d3JsSjZEWDVQV05acElCN25TaC9QSHBMdUtOc2lFYzR1RmpHYzNYemY0Zkls?=
 =?utf-8?Q?/jnXkf8+8d8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qno3RnRWNXNMTUtzNExTSTB1L2hKbUlVUVVtU0MyaEcyZlFLOWQ3elJoalpq?=
 =?utf-8?B?cU5EVGtzU1VCbkVXcEpjV0gvRVhsZE56WmVOMnpRZ0lCbDY3Ry8zdWZyVkls?=
 =?utf-8?B?U0hhTTdOdXA5ZXZOVWxqcW92aTQydnJSdlpJRjdGS0pTQysvS212UGRkMG5S?=
 =?utf-8?B?OGRZYVBxVzVCL0VySllnL2lJeHJnVWlPRnA4dG5pZWhTazNKSmJZT1BiNDgw?=
 =?utf-8?B?M2ZkTUpicFYzTysxdTRwNU5wOHM0M1hsZld2VmRDNXVxTm52VWtDVDdZbWpa?=
 =?utf-8?B?NnZwWU9lSDNNUk9HdmFzUE9DKzdoSnFrTHNlVEw2Wncrd2dSNm9JNURubzBP?=
 =?utf-8?B?TW1LUnI3Um9CbDNmTE1RSGQyUnRyRXlOUk9UbEpZclg3TnFvcmR5YTl1Q0VY?=
 =?utf-8?B?Y0dnMzNnRW9oQjV4aEliMDNJWWh6MDFjNUU4TllQWjdoY09sY2ZxbW5Zb0RN?=
 =?utf-8?B?K3I0d1RuSDFIelF1UUJ2UjdydlFsSnVSdExWQmloL1E1WHJzbnJiSk0yZUJQ?=
 =?utf-8?B?eU8xSEhqOFJEUjhsQ3BGU2RLalNDQ2I1dlNaUVgxaUJ2SE5GTW82N1F0Ui94?=
 =?utf-8?B?cFl2L1R5OWgxQ3puU1BGb0ZvaDk5SW1NWkxPNUN3VUdjUk0yRTdET0J4MnB1?=
 =?utf-8?B?UUs1S05IOU9tTlZ1SHJLb3lKYkM3cC9HTHE2bU10QUdOdnVxVFRGbmtiamVt?=
 =?utf-8?B?QVhCaWNuR1NhclEzVzZxMUJwUTcvOFJNak1YOGdZMVZGUE04Mmg3ekh4U3Qv?=
 =?utf-8?B?S2ZjK0lybG5rTmRhT1FpVHFpczd4VHlCYXZHUmE4MHc4R0h2SkcxT3ZvQ1NS?=
 =?utf-8?B?R0d5SDFZNFE4NmdLeGs1RlZqUXAzb211UGhlUUVMMEFIUjFLbmo2bUxPd0FS?=
 =?utf-8?B?N05HR0tsT3lqMkNTKzhuS0hDbzVGZmw2Tnk2S24rWkR0elVRZzFvM2o4cjFO?=
 =?utf-8?B?bzhSZXNoMENueEs0RGY5NW5INi85TmVOVGswR3F3eGZXUmtpTHArQnZnb3Aw?=
 =?utf-8?B?Q0dsbTBML0N3T2wxM0pZNno3L2hDQ0NqYU1UbFBHeEFlakloenV4MFNwYm5B?=
 =?utf-8?B?dnpKTUFZcXpTeHJscHVmYURkZjlxTGFtSEg3MkNnYU1DRXJvRmMxVGpWMEY1?=
 =?utf-8?B?VXVvNUpWUXV2QjVDMXhUWE52ZHdFMVMrY05qd1RkVGNLaDhNWG41Rk5uMVlj?=
 =?utf-8?B?c3JYN3AxdE9USDFGYkRoMmhxZThzUW92MHQ2MVBNelRUSHExU0JBNDVzMG1y?=
 =?utf-8?B?SFYvTFZGSi9yUDVqTDU4dFVwcnpPYTJaK0hKZHBYTnVqeHA4Zlc4alFGOUtl?=
 =?utf-8?B?NzR6WE4vRGM2VExSUFV4Q2hWa3cwcUtFZzdkRWdJeEZSRGRFdmQrSE9HdXhz?=
 =?utf-8?B?eDQvMlVNTjdDaUlCOWcxaTBhbURKRm8vbXZFRUpCVDA3KzBMY0V5eDBZSC9X?=
 =?utf-8?B?UDBBNzIrdFNyZFZJNFJDZGQyNVZvcEtHZnlISS9oeXByUm9pUDhUWGk5bm9M?=
 =?utf-8?B?ZjhoQytMMVNGQk4vbTkxRjJCT0FuUXpXZThiWjJkdENWeEFEcCt3WjRjVUJL?=
 =?utf-8?B?TTRuWHhzczZneC81OXVKQzllQTFOSFdjMjc0d0NRVXUxV0txdHc4Q1dXTTVV?=
 =?utf-8?B?VG5tdUJoQVUyU0xyWFpsRGVEL3Z0Y3BiUkVWanBaV3Z5ZUt3WGlqMnpmVHlN?=
 =?utf-8?B?Zy8wSmVUdExtUk50WUhFbjRRNVhRZEJ1ZEU1ZTk1akF5dUhIVG0vWkRVeGMz?=
 =?utf-8?B?REZSTU5HUm9iTldpeU1WY3ltWGVORGNMS3cwdVJQODNidncwU29vQ0ZqQUtt?=
 =?utf-8?B?M3JaR0djeXRwd095MXRDcnoxZjBWbFhpbWtjd1hBZ2U2SVZyOHNZVlpzcWtR?=
 =?utf-8?B?S05TWVYzTDI3RTgzcUtOcm1RUkRRNjNnc0xwQjhyb2g2TnV4ZlI5WHRUU1po?=
 =?utf-8?B?a2JmNlpmeldPamRTclViRjhRbzFxUk91TnJTSS9WMVVPVzZsakZNeTdpQmYr?=
 =?utf-8?B?czkycWdvVzNYNTJJNHBuQjZaNWFhVUo0dkEvRUJqZlpSN2dUM01OV2xoNkhO?=
 =?utf-8?B?SlBvLzNJNExudzNKOEw0RWk3Y3R0MW8zWUtCY1VHYWNpVjdJcUtXVTU2dGlT?=
 =?utf-8?Q?B36E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60767f-7e75-456a-4185-08ddf572f1b5
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 22:46:58.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jznRUj8CaRiSoEC+rJecJOEls4PAGE9o0/a3mLkq0+vVCOQffc234Oa+s6hA0bp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

Hi Reinette,

On 9/16/2025 4:58 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/16/25 10:25 AM, Babu Moger wrote:
>> Found that the automatic counter assignment is not working as expected when
>> "mbm_event" is enabled. Counters are being assigned regardless of whether
>> mbm_assign_on_mkdir is enabled or not.
>>
>> The logic was mistakenly placed in rdtgroup_unassign_cntrs() instead of
>> rdtgroup_assign_cntrs().
>>
>> Fix it by moving the code snippet to rdtgroup_assign_cntrs().
>>
> With the goal to address Boris's concerns about changelogs I think the changelog
> can be made more specific by replacing the vague "the logic" and "the code snippet"
> terms. Below is an example changelog that addresses this but I am afraid that it may
> now be considered too much text :(. As I am still learning how to get this right I
> surely will not hold up the patch because of this, tag is below.
>
> 	rdt_resource::resctrl_mon::mbm_assign_on_mkdir determines if a counter will
> 	automatically be assigned to an RMID, MBM event pair when its associated
> 	monitor group is created via mkdir.
>
> 	Testing shows that counters are always automatically assigned to new monitor
> 	groups,	whether	mbm_assign_on_mkdir is set or not.
>
> 	To support automatic counter assignment the check for mbm_assign_on_mkdir
> 	should be in rdtgroup_assign_cntrs() that assigns counters during monitor group
> 	creation. Instead, the check for mbm_assign_on_mkdir is in rdtgroup_unassign_cntrs()
> 	that is called on monitor group deletion from where counters should always be
> 	unassigned, whether mbm_assign_on_mkdir is set or not.
>
> 	Fix automatic counter assignment by moving the mbm_assign_on_mkdir check from
> 	rdtgroup_unassign_cntrs() to rdtgroup_assign_cntrs().
>
>> Fixes: ef712fe97ec57 ("fs/resctrl: Auto assign counters on mkdir and clean up on group removal")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> Thank you very much for catching and fixing this issue.
>
> It is not clear to me if the changelog will be acceptable and I provided alternative
> text just in case. The fix looks good to me, for that:

Looks good to me.

Boris, I will send v2 with updated changelog. Let me know otherwise.

>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you.

Babu


