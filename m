Return-Path: <linux-kernel+bounces-896253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF2C4FFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76DA1891603
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D502EBB8B;
	Tue, 11 Nov 2025 22:34:42 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022101.outbound.protection.outlook.com [52.101.96.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D2C2DECBD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900482; cv=fail; b=mNHsrI6Uz2YqJKIHFiyekjC31O42zZDKyM3Qe2tnDJPqq7v1q+aRSgEyNxGJeu8xqoK4zLdS1/Ny53BFWtWFk+8W2FPryHPL+Kas5QWJhEYwjBJWWXS/VIOzS1N7H+riQ0vDcURpzQhsp4n34r4IFj4TfcLKQF15bhHJeqaeUsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900482; c=relaxed/simple;
	bh=6gmIJenhsJ9I4lxSUv87Y8+z7G8/2HVh/8ADhHg1O+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROQ7o0MUd4IH9MdmIp69PLjZ5jmfjYd5opgQQq9b0EEPew2JXDQr4QKarwYRqM2xUoXvGJeR1oUn1neJSY4w9qSQueGHhUsIpQoiJPA0OehvxVqL96wX0imTQAKvQwv7dci0Bp+26zJMcDeYniU/3Wl8i/o+/wCfLWXMjQq3RIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6Qmy9LUQiWrw1KB/kiy//fDQlj0jLT33hUF5zB2AA8/FxChfzFvswJsHkF4JHSIWAFYVh69Wx+O7P4UKR6dVU0MFq6uOcDEmUSp6fS26HxffVmkJqK6IuojDTMi2u2sxau7usE8d/kuFURkSnyfUwtd3HgEBxM1gWBtP9pe29QpOQ+LPNTYieE0zPvcprCoEPeP1/sLAH4Yy4upxK0Pc0WmDWoWPe/MrBzCebhoLygKUOJkcPhuS0RliKn8b8uH8rEzyDnnbZJKNvs7IV059hjS/GrTK8TnTwpE7zc35bKaLLnSK7QP/J4FV/mgvB2aae+mr2l4VPIra0IKjEoveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XqgUvXLyuj1Z/+VZHn69zcpxK7YsMFeWGWlrKd++ro=;
 b=huvnu+KJLysPG9VyehwdeiPPnYXAa4/CHnAnLKIA3rkQzx8vVPIa9rG0vmZRRyqtJfH2onKIzDg+S4EJ8U1T+LP8JnTpLbSKerU/knFEvMCyLUR2Ef+IGONeRvQU3DkShfanxItocpK3cxxugve9gNdzNUTLch/9lo/MNMQ2I7wwtp+zvISLxHeNAt+3Ij3piVMSYQ3/wYqWyQEOmLzkiH6DleSy0jA8OzOoegcq/jz8f9cM54FnVXNKuVeWpEOmg79e9zMQLsXdOb17eZKo7ivW6H5pIrEGvQEUOUKVNkEWrnhiDkeXNS+AQ9ov3IFNZCBzzupYR7GWVxrLcB6T5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by LO6P123MB7271.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:33c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 22:34:37 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 22:34:37 +0000
Date: Tue, 11 Nov 2025 17:34:31 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Babu Moger <bmoger@amd.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>, 
	"james.morse@arm.com" <james.morse@arm.com>, "babu.moger@amd.com" <babu.moger@amd.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Message-ID: <kszvsxhiz7gxmiklsiiybh3hiykvtishw22fkgg6gxlabulzv5@x4dtfw24uz2f>
References: <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
 <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <w6thhucyyfnveawixyub2yugsb3s2goiocqtene7s56csrgtfz@x4zll7p6tyla>
 <7e264e18-23f4-4566-86f2-f0600a243227@amd.com>
 <589d5db4-68f8-4aee-9d6e-dee5b8754564@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <589d5db4-68f8-4aee-9d6e-dee5b8754564@amd.com>
X-ClientProxiedBy: BN9PR03CA0989.namprd03.prod.outlook.com
 (2603:10b6:408:109::34) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|LO6P123MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 095b26fa-0902-49c5-6620-08de21727e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0FlYXowMi8vbXd6U1Jud243Y1lpMTlvVWh6NlZBa09EOFoyL1p2REllYm1D?=
 =?utf-8?B?SnBXOHI0eTl4d2lNbGhJdHgyaEdKc1l3SE1zVDZ6UGlNaHdYT1ZWQ1BwMVI4?=
 =?utf-8?B?TC9IaDcyZkQ4WDBlV0tHOHZmV1lleWUxUCtTSlZranN3WU1Wa0IrRlY0TTAx?=
 =?utf-8?B?SnBlWXB5ZmJBUklYWWNVUkRTRk1GZ2Y0ZWRJcC9kVW1mVXpVdjZYMk1yY2xh?=
 =?utf-8?B?SSs4bVd5bkZjSjhVYzVzVE5GVlllNVVkMVhRL3hCMVpQdTgxUmxma0ZoZFF2?=
 =?utf-8?B?VkdEQ0FXbkhlQ1hxRStVUmpTdHRyKzBab21mbWx5UHRRUE9KWVVZTHB2MWFv?=
 =?utf-8?B?SWEycmpVd2RYN3BkTmxVTjBkZnJkQU5uNjhVZ0lYSzdVVThNdzh4RHlheDE5?=
 =?utf-8?B?dk5ob0NFU2pXay83NE5FT0h5cmFUclgvUnd6bDRtUWlwRUlRdFM0TThzL1Br?=
 =?utf-8?B?a3VHMWYrSm8vVHNJblpxZDNTbE5Xak8rME9xY0M0Q0krUnlaVlhLakpCUXRh?=
 =?utf-8?B?RmVnQStTc2NRbmVBdWsxajRxVkw3MXcwTHlDRlBVWjZzNEl0RjA3dm5EZUIw?=
 =?utf-8?B?V3JXMGxQUW1RNTN0RFlWWDhNT01hZ1AvczRYQjlZa1d6OTZleWNDWFpOekFr?=
 =?utf-8?B?cGZrKzIxckFETUpXN3AwVUEvcHZjUVFKeW9CMDRDZzdPVHRCT3VucUJhVlZN?=
 =?utf-8?B?ZmY3WmRYY1lvQnR1NXQvc2RqZkRXQm93bUpJY0VVbWFKbWZvZ0E1QS9iVDkr?=
 =?utf-8?B?RGsyTnhKRmZ3UzFpME1mQnJvWjM2bUlmU0Vobk01RVVQVWIzZkFLTUhwQXNK?=
 =?utf-8?B?STk5RFh6NFJMMGlwT0dtZVMrdWdacnNwR3Z3S3VjZ2tZOGNMb2wyd1EraSti?=
 =?utf-8?B?bkdScnJCVXo1UzJiWmswUUdBcGxyOFRoT2JCb05haTV4dC9lbUc1YUVPdklR?=
 =?utf-8?B?QUFrMEZ4VjhWWmdDVnVhdVRWWDFVTXo2Z1ZiNGlzUDA1U2VXV2R3QnkyYXNr?=
 =?utf-8?B?VlRBZFVvdTUzNGhwUlEyNzR0ekNYbDY1L2lJVTNjUVptUnA4dCtLM0hIRUVU?=
 =?utf-8?B?cWw3eEF4U04yb0pLaGtPR001QVVMSk9saDNLd1pneGcwQnc2dk1KNUQxakR3?=
 =?utf-8?B?YTM2WUxzeFdEUHhHM1BGK0JhMFNNSGc5MFNGWEg3UWxiMG51cEtMeU5rYXhV?=
 =?utf-8?B?YVUwT1FDaXBrYzM2cGdLSnozaUJHZGY4M21HaDZEZ3JtUzhiN00zOGhnVit2?=
 =?utf-8?B?dENrRS9JbFZaMTBab0lKeVNZLzd4UCtaeURmOWdSeVFZQVhVQURPWndjSEZL?=
 =?utf-8?B?TWxSSmtPQTV0eGlSNUZXb2ZDRTRNS01WNldKOXdlMlVhNlg2NGc2SDRxU21U?=
 =?utf-8?B?TFByNWI0eVNkUDk2Skx2dS9QQTBTenlDMGp5Tkhwa2NhQUZBUnlkcXFtZzdI?=
 =?utf-8?B?RC9jSndCQm5uMHBFSXdRczVTTDlyQmRrOHkxbk01QVNlMzhlQTA2R3pjWUFa?=
 =?utf-8?B?WlNPSFBNN2RLMmhtTGozUWZLT1lFS1Mvek1GRVArNnFxK01JYnlaR3pUa3BN?=
 =?utf-8?B?Sy9JODgrbkJrR2QxQlRVcjVlRzRQd2ZvQ1V2Vk1naXpXZkFTdWExQzhhR0I1?=
 =?utf-8?B?eCt6WjhHdDRreCtoZmpnNDVmd2liaFN2VVI1OEovVGZHUnpUV2NXZkJzcmZX?=
 =?utf-8?B?NHByYU8yL1NuajNJNGFmRkhiSVFMUmtUR3J6SjU5RktWUWdiSEhTRVBmcjBM?=
 =?utf-8?B?bm9EbXpOR1VzTzZCYS81VzFkVVFoYXFCVWdTWXBObzdzY09jNFVNODJ2VUVW?=
 =?utf-8?B?bVQxakhPRzRiUUNrakRqVURna1A2ZWtuQkZmWFprSWFQL2F1Unpka1dmSlQ0?=
 =?utf-8?B?QjEwWjV5R2hVQytxREhDbk50a0RjK1pkZmgwbkhPdHNjRlRKekxKT1BQa0gy?=
 =?utf-8?Q?gfgYLvZnCM2DW4JFKuFLh6H0liqN8TCF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlIrTHBiRUVua2VabUREL3NVa0ZIcUwwS0ZRWk01dU9FUnh5aGh1cDhQd0lW?=
 =?utf-8?B?elhNT3l3dnB5TG9TMC9ra2k5TGI0WkZzNnp5WUNFcmJLSlpwT21HZER1dENP?=
 =?utf-8?B?ZTdFLytvUXhzdFA1OXg0NWNjTGw5WmlZc1pTWCtybXdIeUliaWN4dk5IeHNv?=
 =?utf-8?B?aTJZbW5BK3E3NC81SURaZitQU0g3M2NIOVNINU1FQ0tUaGRPN2hKMEFkWnph?=
 =?utf-8?B?L2NYNHRvV04rZGUvelJzUWUvam9abnArNzNXYVdNa2xFQVAxRVhxNVUvTVVL?=
 =?utf-8?B?bGtQUEM0TlBzWlFNUGZNSTVseERkVG5tMG9PbXRuaWVKM0djUGdoaU1WVTZE?=
 =?utf-8?B?MHBvYnRHOU9qbzNWRjI5SXhIN1diOUUwYjVVWjZyZGdtZG81L2grTjhYTEVZ?=
 =?utf-8?B?ZXBkV2VoU0xlL1JvbENwYzRrWkNYRVljcmN1MUhhRmhGbTgvUk1SNUhqOWl4?=
 =?utf-8?B?Z1ZFZkkwYXNabmdEZHE5V2FzZzNnN0Z5NUoxOFkxT20zdzJRbmN6VC9jOUU2?=
 =?utf-8?B?VVNiNVAxZEVqQ0hQV21nRmp5ZythTHVHbHlwdXNVZWdOeHVtdlRxTXB0OWkv?=
 =?utf-8?B?UlhPSUZ4eUc4azN6K01ReEZEaGJHTW1WeVhxY1Mvd1prckl2UHBVUWwwS3Z5?=
 =?utf-8?B?MWpMangyR0tiMDdtYlp0cjhKOERWakpyemc3bTFJVytzNXBWem14eU9wWmhC?=
 =?utf-8?B?eEV1UHZRQmVQZ1A3SGF1MlhCK2pZQ1dKbVR6K05vdW1mV1hXUW14cXFzenRK?=
 =?utf-8?B?MmdEdDJOZDZJK2p1d0ZSYVpreWwrK3N3bXJva0o3WFlQNDRvSEhZV1MydTVQ?=
 =?utf-8?B?anYxUDVpdUw2OHU1ZnphUXlHSFMrVHpzamlFaXVuZlRkc24zZ1Noa1Y2eUd3?=
 =?utf-8?B?Y3dOM1Y4dzNCaHFoNm0xdDIrbjVhQ1loQklhUm9xV00vVkF3SGhRR2hsWTVE?=
 =?utf-8?B?THpMcTdicW1aNGpWQ0VENDZBc05RTnErOHNLNjFpd2lUaWg2V0pZVm9YN1I1?=
 =?utf-8?B?aGhLeUlwa01tUlkxNnhCMUJJLzd4RklkT293N1o2R0RiSE9GeVU3U3RmWGJp?=
 =?utf-8?B?Nm5iTkJ5Y3FrYjVWYjJRTjVORFhURzB5dFZRdUFiR3VPU1RPYUYrRXNhcENw?=
 =?utf-8?B?cFFhSDZDWWxtUTgvZER6M3JJVlhDMmM4SmwwdzJwdDZ6QWJYWlB3aUU3amMr?=
 =?utf-8?B?S01LU016YzlTdWlJeUhFdlFrYW9NRG5XVU1Cc0FwVTVBS091QTBlc0FoSnJs?=
 =?utf-8?B?OE9Ka085Vjgyc0RvWHo3K2Y4bVg5aWRWNjFhZ3pCTkhOOFkyeDlGU2crcFJj?=
 =?utf-8?B?UXBUbzZnMDhIeDdrY1lTaFBETUc0aVZuZFJCWDVBdXlXYXZoT0hMY2l3T1ZP?=
 =?utf-8?B?SGYzWjkzUHNHbmhud2J3Q2NIeTJhSTdoMjJNaHk4eElzbDcyYU1uWUtDRE5w?=
 =?utf-8?B?eWJGbUtLQlJpakgyNTdpenFrQ21PZS85NmtTTDNnVTNaWmJ3ZStrZmNyeURr?=
 =?utf-8?B?VXllUlpSRWhLVkdKMnRMVjNYc1JhMTRyeUdwSXRzZ2RSRjhBTUxTL01FTDdC?=
 =?utf-8?B?Y3lUNmpwVlArREE4cHdqQTRLRm1DenVYNUxEbXR5ajZuYVNLREVFMFpOa3RW?=
 =?utf-8?B?QVEwRkdFYXB6MnpiZGo3S081Z2psaFM2c3N3dXVpSm9VcmtISTBQdytLaGxz?=
 =?utf-8?B?MlJaYitDQlVMdVk2OTBVT0k2eExHUU9IckllWXRXNDJiMUpWamZPUUFCTFZQ?=
 =?utf-8?B?SWdOeXFVOFNkT0c4dmZqNzRUa2VyUGtUK2p2YWhZUHVReTh0WmFTL0U1TUQ1?=
 =?utf-8?B?ODl1RnVQZTlVQUpIdUk2bi9OQTFWQ2tIWFRoK1JaWUxBcmFORVMzVGk1eFZ1?=
 =?utf-8?B?VmczZjRpcGRZcnplbi8zYlRxVVV6NjMvSS9CSzhUTTRWbHdrRjZIYXY3NU5V?=
 =?utf-8?B?aFNQYUpJSlBIOXp5L2pLRXZLaFJheVNZbXBJWDAyOEZTMkdlSHRuNTBYUXZJ?=
 =?utf-8?B?Rk14Ty9HckZrcDR0Q2hGdm5hak1WNmthL2svSEJRUW5xdXN5ZC9obThld3Vs?=
 =?utf-8?B?WTcxNmxwRm9IM2R3QlEwKy9ZbHBkZ21lZDFJdld1VXpwVUM4NW1Hc3A4TWxH?=
 =?utf-8?Q?yFase9qZZ4JO9r88N1S3X110c?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095b26fa-0902-49c5-6620-08de21727e08
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:34:37.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvIvJpARXVpy8xbFtzBMV4qPpfW/Ezak00jyhzmZXpZ5Kk8Dv7psI+B3azgvtNAe7ijp6+VPpMNrmvvfgJXOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7271

On Tue, Nov 11, 2025 at 03:04:55PM -0600, Babu Moger wrote:
> > Here’s my understanding of the discussion from this thread:
> > 
> > 
> > We plan to support the following operation:
> > 
> >    #echo "*=value" > /sys/fs/resctrl/info/L3/io_alloc_cbm
> > 
> Looks like we are going with the above approach where "*" represents all the
> domain.
> 
> Couple of things to consider.
> 
> a. Send a separate patch to add this feature after [1] is merged.
> 
> b. Add this change as part of [1] series in patch 9. The series is mostly
> ready for merge. I can add the changes. Only concern is, it will might delay
> the series merge little bit.  My expectation is to have this series ready
> for next merge window.
> 
> [1] https://lore.kernel.org/lkml/cover.1761844489.git.babu.moger@amd.com/
> 
> Any thoughts?
> 
> Thanks
> 

Hi Babu, Tony, Reinette,

I believe the most prudent course of action would be to hold off on this
particular change until the main series has been merged.

As I was the one who specifically requested this supporting functionality,
I would be happy to prepare and submit the follow-up patch for this detail
myself.


Kind regards,
-- 
Aaron Tomlin

