Return-Path: <linux-kernel+bounces-768797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDDB2659A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D71CC1DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FB2FE041;
	Thu, 14 Aug 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OCjPtlvT"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697531A8412
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175249; cv=fail; b=iSPuBIcWZJcG1vyP4B00bprnKP7qNSSC4U4cQitqlMQWoWt3lwmBXsqSmhiADKetad/Lvi5yKnoZKp5qVuz3CP54FClft7ShAgz0P08cBiijZJTotOGV+s0wGKpRK5K4qMxG+lh5wRS2Ycoh04TWU+8JYlX7lRqVwYeCIrEPNck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175249; c=relaxed/simple;
	bh=/lUpWpQv73DP9en7IXBpqp0BqjkDCbMSup/oTgGXs7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E597CgS04bgJKa2k6YQVVqfLSMfyIDu97I3igvCtiAe+aFXI9y3fJhGwcLFuFYMFDG6cWgoMa4gKe6tbuVF8pJMXvqlbnhFUNB9h1RxCDwuigv6XSYPKzqONaAQzOG2m7jNLTHA3IGSVl4FI7MTRWj/J8e6CIcyEBx7qm4leN6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OCjPtlvT; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIF4+Wal8wYbYSK/PUfw7T7Jo4zBYzDKgsWyr2DlHwzYLqc99LC3cm5hkjLdR62ssY6y3XLZ0BJg53O0WxIZX61q0dmV4D5osc4h7OgWG9CjPHT4UjN8G2sV+hk1xJWhiuA8DBuAFDvu7OXOE9px5T2jG9PayBUTfwusTj2WXLDxLbIbLxR/4p+nKLXmu9yy4mmB7+QhhCVoJ5TCs3/9Mi+6vjRkkiZo6z6SCMt0X1gLSby1a5rORhwOXwWmOCbSsOZxkWnZHUbDXPCBXZh4zAN9MYF58gX3bHQJAIY4Q9v5uErvYOAmGHiRBUstKwgkgjwYY35pCpN/NgM8keSTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f6tMWCxwN6++uHzgz7rY2u3r89w/oJD6upXrWPFTdU=;
 b=a9bE19htJLlq0qd5TA7aELkgqy60cVd4FfcnvmOAfbo3mWpxSn/OeTThJNvvWs5kn6vOhIbXKKNh43QGsyfTq8M/N0arfxeQ7Cw1C8o80WyKD7Ep0z4Q26h6rUuJigCC8OpjO8TiQlga2l6mphWouH5uYg6GoYAup2UyPruoQxfAzqpJ/SIm29a52mqNJh08JMwJqUopQNIBJ2vJOq7SBWWG6XwTMYQlXY6mu3k4eYPj8wC2k2e67FD2nwSzBRvOCDrDR75nrCdhVqxO1tZXBEjTDXA/bkihHmuaa0zscsurC8r8WcCY0Aw1la2v7oGq+tP/l9JQ0XxOPb6Ns10YIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f6tMWCxwN6++uHzgz7rY2u3r89w/oJD6upXrWPFTdU=;
 b=OCjPtlvT1SXPDI3fC9/pau/rei9B2mlHNONMpYOpxVsUaf7oT4Kty8u2wRV1C+YePaNmkUBQssipKe/jR5WVpYDW54lCT3amKiUKvJN7XT4pnNVIfF9XeQwz73jl+VbkrQQBFGlttv5PAY78hmqTnGu6IirAeWY8dAVdgkR/EXXwY2cVU7OCOd0nQISTv2fCUoybC/mIQyzAIQq1RmskZMh2zzY2VNL7HxqqOmmNgvSJskJMJLw+b8Mk91rqvoCDyvh7m9nn0wE2yBpv77YEOt8SVAwPh7pWf1D/WJzF7UwrFR73qB8pIWOAEzvIrDyzdh/0ANDdsWMsJ+8PcCg6hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 12:40:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 12:40:43 +0000
Date: Thu, 14 Aug 2025 09:40:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
Message-ID: <20250814124041.GD699432@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814072045.3637192-3-mpenttil@redhat.com>
X-ClientProxiedBy: YT4PR01CA0390.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: a3310bbf-e28c-4b4b-ad5b-08dddb2fc84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2JmMmhaUGl6NFlkTzZiV0JEa3kvYmJBU1I2RU4yS0d5ZWZ3SzErSzhqakpN?=
 =?utf-8?B?TDNBWnlZYkowRXBRWVY4TmdPSUU0WXpMRnZ0V0taeTJtZDRUdjJLZENpd3BP?=
 =?utf-8?B?K2NMdE12ckozL09NaUdMei9NVGlvdXNtNkIxZGJYLytGVlFiMDU0T1p1ZWE3?=
 =?utf-8?B?c21Jb3RXbmpuYzRSV2h6WkhRK3FIaVlSeGxVVDJsT2NhaTJ0K1pWYXA5RE9C?=
 =?utf-8?B?Tk5xWklHb0RiekVnWFF0M0lvWkR5TU8zMmY0NW45YWdXWmRnRUJIRFNQaFVQ?=
 =?utf-8?B?TmpaQUJlbWRTaU5NMWt6V1BLRUlQaTBYSjBlWm9wU0JYTHNkT2Zuazk1RjFm?=
 =?utf-8?B?cVdqQldXU0hublZkWkZjUys2WURvSVhDLzIzTERpUGRWRGlsOS9WVHM2OXZ6?=
 =?utf-8?B?S3VMdWN1SGMyRmxxZU8xNXh3NzlCTFRCM3RiTTV2Um9YWDdZbFNYOWhyR0FH?=
 =?utf-8?B?bGIzMmZ2TjQyTkxGOVBkSEZuNTdpd1M1UW9PemVYRm1XR3VWeFIwTWN4ZTNw?=
 =?utf-8?B?ZWNKSjl2dW1VNXA0cUF4ZGRjc0hOd3V0T0xrUGpuWGFyRG9UUUlKa082RHNK?=
 =?utf-8?B?MW5oVG5QNmowcGUyN09VWTF6d29XRHluMzBUM1ZnaTBsVmZtSFkrSVV0UitV?=
 =?utf-8?B?eXNiSURiTFpOQy9WYVozeVY0MDdqcjZtY1krbm9URGtkaExJaHRxdTFhNmFq?=
 =?utf-8?B?Wmhic284YUo0UkJjNzVsdUFuNWhIR245N2Z5OEwzUVhRR3hwK0RERFlHN0J2?=
 =?utf-8?B?cUdsbDNpcG1CaitIVmNYb1l6cVg1S2JqaEVqaG9selVtc2Z3UGJnbGJQaGVa?=
 =?utf-8?B?YVFzdDArZ0RLTXdMejJkRW10VDd0VzVWMTc4cWJnQ1dwZzVIMFJ0UmVKTXps?=
 =?utf-8?B?RzZ4RGxZSkZvNndwT0p5WHFnSlFiaVEyL1NzcDZ4c3ZKNy8wa2RBSjMza0I1?=
 =?utf-8?B?OVdMTGlsM3NlcExFOGJXVkI1NFRjWkc1OGpEZC9QVHdJTnc3TGpUQ0gyNXBu?=
 =?utf-8?B?VktQekFvcmlUOFVQZ040L3RiQXE3bTU5ZW1zU2MwMjVrVmt2a2h0TmNhbUpZ?=
 =?utf-8?B?NEgrWjlkQ0YyQTNiSThxWUc0VGR6bW5DajdtUHkxdkhiNmkyV090dWlsWGIx?=
 =?utf-8?B?VTUzaEJwZ3U4S3FCZm5tbElYZ09DZDFVckRuRjd1a3F5WE5ZZEZZMWpoaGlT?=
 =?utf-8?B?YUg0Q2dTS2NYN25NVnh2TEdrWUtQRzlVSlRxNkhRT1JTTnIyK044c3VUV3dD?=
 =?utf-8?B?RDhESXpibFJxTWRIQ0pIRTBiSWxJbm5JY2ZSenFLUkFyVFVFdGNDRjg0Q21k?=
 =?utf-8?B?TnBqemVWSGtoWHhiUTcwb094WE1TVkVDREZxU3pOSEpxNWI0SzZ2WGlCSUdo?=
 =?utf-8?B?SUtlRnJlY2Frc0FMODBnMVJsWEk2U3JvMHYvUi9KNmU0MGdGK1ViQm41c2Ez?=
 =?utf-8?B?TG1QZ2VMclNoL3llUXlGQURIZU9FUmI0cGtraHdON0kvNGs1VUc3UktpSU1V?=
 =?utf-8?B?eUtwK0ZNVnpWYUhuaWt4ckJKY2JuMzBsek5WeUNESUI2VFV2QnhPZERTMkR5?=
 =?utf-8?B?MXFxVUhQNTNBUHQzN2JzWFVpQTZvanZIVTdSUjJxTEZwZldrR1RycmdzRHhY?=
 =?utf-8?B?eXRtUzRFNjhQSzczWFY3aW1WTFU2NXZsR0wyTVJ5ZW04Z2NJbWx6Q1FyVTJq?=
 =?utf-8?B?NUpyc2JwRU1KbElWWUJab0xNRE84U2FXZ3NrcjQxbHYwVHhLNkxkNFFyQ2hj?=
 =?utf-8?B?MlhBZGVLRFlUUUlvVEhTckRsaGJGUG54aXc1RUdNS0ZORDFTMFBEMGRXYTBu?=
 =?utf-8?B?LzAyR1JkMkVER0grY1cvUUR2dkg5T1VlMCt1S2prcG44eGRicmNzZXMwekJu?=
 =?utf-8?B?L3M0VnJUQmtFdk5vdzJzOVI5cUhyRWVEUHl5MVU4eTZzcHY4SXNJbmpCZ0ZT?=
 =?utf-8?Q?zhu1jz9nX2c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3UvWHljckxVNEhkMU5kN1ZaNFFnT0dJbnpmUGhtem5sUzdOZjJsVk0xM0xP?=
 =?utf-8?B?YVhTODFiWHpVaWEyM0dTV3hXclhxUlErQ2M0azhneENvS01YZUFkVWNsUXZx?=
 =?utf-8?B?REdDMDl5VmVEVFNPVGJzbWxuTlpiQTVPNE5qWUdEdjE1ZGMxWXZ3RFZYdTJ0?=
 =?utf-8?B?T00rVDUrbjR1QVZiYkdtdUJ1L3FuL0tvY0RJNEN5QzU5OE5WZnVLelQ1VWhS?=
 =?utf-8?B?YmJqS20xakVOL1VWMVVLenlsNUV2VWd0QS9Vc1RqdTMybGd0VEExWDVLWlVS?=
 =?utf-8?B?UE9DZmJnR3JVbTJmR1czd2gvMVBOL1JUY3RkeFYvallpRG1wNGtlNmtra0NN?=
 =?utf-8?B?b3U2NGVkZS9BbXl6ZTF5aDhHNElHZFJDMnBIM0VHNG1hZlBrZUtDdUdKNXlG?=
 =?utf-8?B?cTJaSUh5SXk2b1dHemp3dkMrSEU2aGRlT3Q0cXVWVkIrUXNKMkxTZFpXWmo3?=
 =?utf-8?B?YzAxTTN5WUFDSWpaVm1FVlRweGMwdjhSSmxxYlYvQnF6YWw4UTk1VENRY2xo?=
 =?utf-8?B?aG10aGlvOEN4ZDFobnFVcExmZFdIek84TjRmWWVnWEJYTDdQRG5yOG1pa1l4?=
 =?utf-8?B?NkxJRlZQNXFKUFUyVWthby9rZ0F5S2FPWktoVmN3elo4NktJS2hsZk5tbUpi?=
 =?utf-8?B?eU4wblpHcTNhNzJqR1RGWWI5U2FGTmN5emhOVkxEWW1WTGpXSzh4OUdPQUYz?=
 =?utf-8?B?RENkTVJVY1IxSFFFbjUxbXM0b0tBeUxrbXhVYXhQRDRrZkxMRTFjREhobmNp?=
 =?utf-8?B?Zm9BQWlTSmQxOFJoV0c5aFlsQVBrYWsweFdKdWo4NUdUY1JEb3MzMmw0bngz?=
 =?utf-8?B?cngxZHBmSE1OakE4QWhVbkc2TGp2a3JrODVGakpDUktUQzJ6cnBBY1NQV25s?=
 =?utf-8?B?SEliNjdkSHFuV1krWUM2eisyZXN2Wm1ZVmx2a2kwVHhoUTJrVTZKOEQrQkxk?=
 =?utf-8?B?RlJnZi84Sy81WmdkWXVQNXl4eXRKWjNHVEx2T2dTMUhNb1EzOGQzMDJXclE2?=
 =?utf-8?B?TCtlbC9sczM5azkrUXYzY0NrODdhU0g3R1k5bTVKdjgrTFMzTnJ3bzZkdDMv?=
 =?utf-8?B?bVdEYU9rcUFOU2JjMDI1aDlSdEtlNGYxemRvT253RHA3WW11dVh1eWhBNzE5?=
 =?utf-8?B?WFhQSnFqNGorVFB2NUFwTzE5SHQyZ0w0dnFHQ1lLdklKM09CdWt4STl6NTBn?=
 =?utf-8?B?Q3EwVGVSVXFBblgvNTdudGRRWVdFS1lXSE5Pc3JacEdYR0RQeG1Hamp6Z0JY?=
 =?utf-8?B?VkYwTi9QejdpMm51ak1tTUVMT2VDNzdtTVBpa0k1VjBzbUZqblQwTlNJZ3Yy?=
 =?utf-8?B?RWVITEFtT2F5RzRCV2o1bUg0d1lVTHlyVDYvZkRSaW5SM29Sei9lSUZDNE1a?=
 =?utf-8?B?dzg0ZU9VcmQzV0duQmkvaGM2WkZob1F6WmFGQmlmSENUTytmcnB5eXZLUDFL?=
 =?utf-8?B?Ujc5S0VpNVJUaE1NbFdyUytwQVl6TFFsZ0pBSExUQXJyVmp0a1d0MldQWktJ?=
 =?utf-8?B?cFYrSDJJZktCY0lDbTRWQm12U3lBSEQ0VllOY0QwM0QwRDV4UGJuQ3k2SzNH?=
 =?utf-8?B?NklBSCs1ZEhKREJBSkJhVkMwazFQdkdiK3ByNEZud1hOLzg1QVNhTWtpUitE?=
 =?utf-8?B?azRmdkZwMUdDYVNMZ2tFQVg3d2kySmtTZGNzYVVwM3RsWUJHdmFMNzdPdjBi?=
 =?utf-8?B?R0hoMlQ3blNVbkJsVTFKZlJDaE9FUktCRUdOcnN5VDNwSjQrYUpwQnY0cmxn?=
 =?utf-8?B?L2dqSUVEejJyUmlnTHYyVzdlMWZWek12L0tuWE01MjlLK0d5ajFjSmNnNk8r?=
 =?utf-8?B?OThvTkw5ZzZWRDdsODJBQnpQNDNobjF3SUNjT3lqWmRDUTY4K0xWZ3dYK3cy?=
 =?utf-8?B?QXZES3FoUzF5RmV4ZzlheVhJSnNuekhNQzVueVRUL3hhKzd5dW03Z1dkamFK?=
 =?utf-8?B?Q2U3RW05blpMNlJvbjg2bDl5SlFvR3FvUWxNWFYrbmpRcWkwTUpwRUFyV25j?=
 =?utf-8?B?bVZTajVFWEs4bllIUGhTZDBRQlg0UWkyNyttRkM0WGhKSnVrMTNtL2EvbmQ0?=
 =?utf-8?B?ajhSci9TMSs3WW9MV1dRbWxMVTFoK3c0UGJ4VHVWSWl6QjRLQlV3a29KNVU1?=
 =?utf-8?Q?RIIo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3310bbf-e28c-4b4b-ad5b-08dddb2fc84a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:40:43.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTd+M6XhXM6RFsLSl8Hk49TYDB6/hg4RIlR6rGJ+4S8G7X5JyguNn2bboRx03Cna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

On Thu, Aug 14, 2025 at 10:19:26AM +0300, Mika Penttilä wrote:
> When doing migration in combination with device fault handling,
> detect the case in the interval notifier.
> 
> Without that, we would livelock with our own invalidations
> while migrating and splitting pages during fault handling.
> 
> Note, pgmap_owner, used in some other code paths as owner for filtering,
> is not readily available for split path, so use current for this use case.
> Also, current and pgmap_owner, both being pointers to memory, can not be
> mis-interpreted to each other.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Balbir Singh <balbirs@nvidia.com>
> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> ---
>  lib/test_hmm.c   | 5 +++++
>  mm/huge_memory.c | 6 +++---
>  mm/rmap.c        | 4 ++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 761725bc713c..cd5c139213be 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -269,6 +269,11 @@ static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
>  	    range->owner == dmirror->mdevice)
>  		return true;
>  
> +	if (range->event == MMU_NOTIFY_CLEAR &&
> +	    range->owner == current) {
> +		return true;
> +	}

I don't understand this, there is nothing in hmm that says only
current can call hmm_range_fault, and indeed most applications won't
even gurantee that.

So if this plan relies on something like the above in drivers I don't
see how it can work.

If this is just some hack for tests, try instead to find a solution
that more accurately matches what a real driver should do.

But this also seems overall troublesome to your goal, if you do a
migrate inside hmm_range_fault() it will generate an invalidation call
back and that will increment the seqlock and we will loop
hmm_range_fault() again which rewalks.

Jason

