Return-Path: <linux-kernel+bounces-818629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B96B59451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968EA1BC8252
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAF22C0F69;
	Tue, 16 Sep 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKy7OJsE"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26B2C028E;
	Tue, 16 Sep 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019738; cv=fail; b=GhhVjxCI0Fl4pFSQDR+/gaUEEGxMKsFdOa1OzesATAvMYDIRjYpMsdwh98/KjbKs3hOX7+oS675v/6KWfqOvTAhTn/A6HXS6nYSEm8TzV6WWO44RyfBjLOGOWN1JBeIZc1w+yO0HPSEjk7Gm7WbvIAtaR71qBhJsTuPwPb/xry8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019738; c=relaxed/simple;
	bh=knWewBprQQohgppgJVcujcU1SiIZJ2Y6DZYbZxXcJyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cStABeJnHFv//qC0KIeAxFuacG6GBfQckcWK+N23DhVE98lrr6CgYzzLsFK89+kuHT3qsYV005Xo2J7WsH0n43qS831OBpnfxryaMCqDhpojcl3N+/vU+oQCoKKoPgVoHcjLVdHtqLA3e3yBSE8j86B/qHNyANDDizKdK0ZppxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKy7OJsE; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPyViDIBfPGyH7qfc7JJX8hdYkePyZDVBzpxQU/M7ku8c1fHYvVw9vWQVv3o3Ct35AiF4I92fiPvAX2Ozk8ktBPo9ziPL3imK5aTbcfckMqmK1ybYVu2nFOXjrVTS8Mx+BN2cjcOZwX5b1ZDVNLFZaifwqm4+45eSZeOeZLIMfAbG5S6b29IP/2rWVfeNXcXAMtcFZXH37emRC0/Hg/o/2IMCch3GhAPl78TI4gNMFp7j+mVTRxkwzHlZ4NpWMI6yqusf6Wtvqp/w8az2OBQQfr6N5v9cqyNuX+ZdL/1t2qFgCTSyt8EHnFgOtYS9ZIZeIwo5SG0gKwQU4mUkxaaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkJlWGhnWXMtzYrR2FODpCwoS3ki8VSKbIl0OPUj6uk=;
 b=cVwYWbhC//NalFdbUgvxe8uoV7PGz6cnQVxnYPPfI22BW9z4EvpDEMRTBLJC/CBmA9b3Mb2FAA+URIMHMIkKuEgPRTyYPl4m78f1Amp8Q0OIX2RO1SlMWxP8BaoMsH9O2nrJBNb/6eHTqWUTLpwmrBVmMabl2/lnpFsuZKUZBaRL41TrCpUM/FFvxsWwJzRqpWB9qAddovcvUXcIj5HyqW7uMHoy+1Gq+cSHPkVfAUNpJFUKfIyOnQp9lV7hikxJ0aoKtJhfrsIl/wdh4ERPN0Y2vRCOOGYTBcsXDm46f4ZofQcPCPDD9q3TwjN/xB7wOOScyD1CMFbdMlYmRDDoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkJlWGhnWXMtzYrR2FODpCwoS3ki8VSKbIl0OPUj6uk=;
 b=MKy7OJsEwhmSx1Su3mymd922lXeAk/2tqix/Gm3gZQsmMP5yLzXV+cKabRs9OaQAsvJD9wnQDRojO0oo2QtpLBkjmQB0OUtIRmzzjXIz9ioPcUNdmyv+oPXFaqzpGSNlin0cMwA53dC1bHHu3S9Fwd3l9AYn3CxwHjZDI2xe6xJMVG4oMy/k6Pq4hj7bSSvvfvpq+il6ts11c970+FIAyZ7TnLxA6eWg2ElD+kCKUr7eNwUOAdEu1HnQAnqZWTxlaj9QGYzfFHc3KV73tnYV+w78O6jCQN4OoVJBViwaC0uW7QlCnZ/PFwGfn5Ymb35ZMsAspCt6YLkogTzA2lyvpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 10:48:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 10:48:52 +0000
Date: Tue, 16 Sep 2025 06:48:51 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Printing with overflow checks can cause modpost errors
Message-ID: <20250916104851.GA1679817@joelbox2>
References: <20250911213157.GA1039411@joelbox2>
 <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2>
 <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
 <20250916103252.GA1660986@joelbox2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916103252.GA1660986@joelbox2>
X-ClientProxiedBy: BN9PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:408:f4::30) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 507c178d-216c-4f89-27f7-08ddf50ea07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ost0dGzkW6ybeZMXXYKUs9a9JC+NlT+565aSGy6USzm39fLFQrw7j3BZ/3oV?=
 =?us-ascii?Q?/2S0CSOLg4oPKyEufWtbdDUTHGH6niQ6offXx/Cno0CjGl8XlnqdYAL3fsHI?=
 =?us-ascii?Q?7E5yfz99YW2KN2qmBb+aWil/HOat3evB/aSTwLp6nsDQipuMiQH7U8rM3Mkt?=
 =?us-ascii?Q?Ma1EtswSSR2R7wDrJG77P6g6UTs7AcHOpHwSrYtgdq9oOp88umiYCnq7RT7G?=
 =?us-ascii?Q?bVSNjl/lfYthEIVdxmyR0qTBF2+A6NUFNIIZRuDDI2rXOlbnGUSi3BDceVV4?=
 =?us-ascii?Q?3AtroEJn6vXnFKNX6gTc1AMr+18bFSoAx8CHZG6IlVvd96mR1fY+Ib/Z/Iml?=
 =?us-ascii?Q?iqIPe9I0Mp2czlCxtQgvn9v7TqQ8Fil6ei//dTwvcD80GOZXmzOf9gTecWYU?=
 =?us-ascii?Q?dCqBo2Cmm8lIo9uZlBb7tU9TE1h0zmrsULfxElxEq3UIJdR5Sh7uILxNc8PJ?=
 =?us-ascii?Q?Sf9DavjjMQCy7KSi3BeGhO915K9vsfa1Jvdx+FbwUhaLmjwCtvjlwUvTeS9u?=
 =?us-ascii?Q?2NzW0Cq4d7gA1hXLKqttwtb1qXgQZYaPeUd3qzAfqydqu10oCIddqxb4/7Ef?=
 =?us-ascii?Q?Xil8wUm93lCqyu8aoVSe1Uxm5ceUW5UqsnKjwhhAG3SahuiRhoAYz8V/igTu?=
 =?us-ascii?Q?gMMXvC6DK5NsVuhPkVFV1WbLfCeJL9GMXw7cFNaOCERgFpjebr+nnPFlgjJk?=
 =?us-ascii?Q?7LsfHFxGvVDSR9/+KYszed0caLkXvcFSPb2NgImBlp2TB/aIEx0sHd03KO7u?=
 =?us-ascii?Q?w8yyaYfHpoDKRghGOkPmwmvP6s0Qs4IUMBr/DmzisJXz9o2EOrSpkVa3v4VS?=
 =?us-ascii?Q?qHPgggPuQP0468pGRilJB9X27cAbcjl5edMclbuyWA5gd20Jxx754Ke20L6Y?=
 =?us-ascii?Q?ZIGJMURRl0RjzXlpO/zQx8fI/+yqjSInMSCEk/t72usgBbRjIDLviVlZYhTq?=
 =?us-ascii?Q?zpkaR/gNKZarTYuEqLplFcMWuwmwCAvdNr84sLOJfEqBvtzTgYCwjysxSrRi?=
 =?us-ascii?Q?f4QMXLQsh1PGrlZS/m5Mn8dYE3koDTebdj8zqG3+HlPTcUncPAh4HgH6lyGj?=
 =?us-ascii?Q?NPUZSAa4M5mXECvY7qLwvqqAeeQg9xWJH4XA7LU3XEdmXEdKiXAmaJzTuNwP?=
 =?us-ascii?Q?V65/zH0LtXGy1TbigpupQEqGYxtyMOZRrix8UPppKbyzWeKGkSXcRwYwY/a0?=
 =?us-ascii?Q?Rp/KYyHDlxFLcFo7KkxvCzhe89xwbEVryKDXOTy6DwMyCsJEr7UVl8hQn500?=
 =?us-ascii?Q?3Ddw8jDnZQ5w4NjWWtkA6Y3Guks8aOfM1ZrIjIQLP8KDoldqaJSi7AJPe2u0?=
 =?us-ascii?Q?Ny5ifQyUc58NSVKstMiwaq5UD+8RU8dyWvQ1KKe4i6OF09lzTI1azGymP3Im?=
 =?us-ascii?Q?0Ch5RMrHjEEt0dbgADsZ2aLed4UbQ/aoyJmaU/HxNXVEGRTmzQ8PBSXL4JV4?=
 =?us-ascii?Q?Q0+C3YFY3to=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?te4Vw5ZJ1dh2galOIE4Q0JGR7oyzh0Be752rF1iB/lFuiHe/IyAVsfg/Y55z?=
 =?us-ascii?Q?eiPalrBWOokZxQ4s3DNFmTL/0ZPk9K78rihi9cTSM6ANcv02ekdTMn0nVCy/?=
 =?us-ascii?Q?5H18c1p+WgD3UvLsAkvPEUxY6e5cFPeerxKo3lLq85+QRq0gLaicBEps9gsP?=
 =?us-ascii?Q?j7jC04L6NlxEbaxhggkz22xWG55S+GWYTEE0DwS0wdDAXB6+RcRYpBfH0nnE?=
 =?us-ascii?Q?4H5ObsvQzICJn6pZro2LrYFHtJZU4r3ckhgJLyIJESYn5O+nvBio0J+uW2B/?=
 =?us-ascii?Q?FpvFNjf9ev/2/bu+5ahk5oc8132/fXatILhEW3faxDseLYjvSrFOzpVc071D?=
 =?us-ascii?Q?SwtPL4CU4NkXIG+JYc+G2C06gspK5/1IqAi6oNYiyIG4cLmTcz+yGb+F40UR?=
 =?us-ascii?Q?4NUfJI1Y4hyxrkBavFvs7dAhoqXl2HRmaSYbSMfZB5fBYllc4EjIoLAnumbf?=
 =?us-ascii?Q?BNjyTFJli49uYRUXs3z4hJ+s8GNutu1d4TtVEfAYCb0cLaBgnOFXRZcpZvoe?=
 =?us-ascii?Q?Oq/S09sDfHueBsZ7zJq5XoEWW63v6jWAZ9SNtKxGpDlndpyykFIl0wcMJBcL?=
 =?us-ascii?Q?oBa8aVABNGFCX06zPUT1esCvwP6iyJJuCWEWr41bnzdvl8iGlYvrPjyqeclf?=
 =?us-ascii?Q?jAPEPc38WUGnJEYWehq4bq3aaDOb1e0WWh3hqkWU7T/EDQ6taxj+d2dFT0mA?=
 =?us-ascii?Q?4+DNzjikK4d57mngaUZilOEUDMF4MdZndmz6SpfoHu9X5aDE15w3NlDydnIw?=
 =?us-ascii?Q?p5MvNw1XqEeredVCCl0/fqu8jwoRc5+Bf0EifJ0w6NI2W6x8bYbXXAwsRhKb?=
 =?us-ascii?Q?h8OC3xz1csxpaWNwjDGVBQLPQ9NpIa5kmmZIcAh+6/MZY9et/uPojnXEAE+o?=
 =?us-ascii?Q?9cZ6lYl5fM+yVdLsLYd4oda3GfVLbN8IVxvSlkPHYr8bKlsj+Hq7kA03OfJ6?=
 =?us-ascii?Q?pY2JT4ITP/mojvlANcqcrT+0GK4tTRGsh0Rehc2SIAue2o/7a6aXsxlofFqy?=
 =?us-ascii?Q?CDRqW3gPLgrJAHyYquGm1DoZyb/Eb9bfdXmWMIyFr9GX5h9TU/mMftIb2W62?=
 =?us-ascii?Q?HVlaPly33YHxji6nGpzbQBfm3JUK8B+SV/7itfNg5aQXsbSdq5wW7sDKKaLG?=
 =?us-ascii?Q?fZloe8MFuZw8KeJlLE4sDVuC1WzW6PRanpNR/O2VMpb497IutU6Muky/4RA8?=
 =?us-ascii?Q?OR/5SNw7LCnlfU9HMqmFoDElLbaHpfRCkP7NbzH3Ci1eFjsLEsPK1iR4UERN?=
 =?us-ascii?Q?nyB7wtbR+9Qit7X53q8sjR+R1HowBoPAqjeA13drlL8QM4+3/hyDaUGcqVeg?=
 =?us-ascii?Q?C7oZzkEVDajctcZ4UGWxhW8OAII3Ule60lg25hYyfzFeCcETqd16Dj6dpCN6?=
 =?us-ascii?Q?WvV0lOMx1LUe3VYqjAW+8YFeCXxFeu4CAXoVgiyjVddf4jEPfXXR5N22UnQc?=
 =?us-ascii?Q?a61iSmwxOkmKImM735FCnUiAHWCdBgdF5e10kG1uzUMIL7nq8ULpa/JfXCcg?=
 =?us-ascii?Q?Nb76I6aVhO2u//jIKV4p37Dpf0KXGKqEKduY3ulc82836vsHrS+OShGAgMGv?=
 =?us-ascii?Q?48fVdtnpWaDskywZVI5A6mxVDSl/TeVZrAXwnXiT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c178d-216c-4f89-27f7-08ddf50ea07b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:48:52.8443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8reuxHHrgwuK3KlMhWPTVFt8hl0IzySC+fREOw1vx+4bQouRpANMh+EsctrJrW3s0h23pfkqWVdqBzi9OoeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

On Tue, Sep 16, 2025 at 06:32:52AM -0400, Joel Fernandes wrote:
> On Thu, Sep 11, 2025 at 11:08:17PM -0500, Andrew Ballance wrote:
> > On 9/11/25 9:53 PM, Joel Fernandes wrote:
> > > On Thu, Sep 11, 2025 at 07:27:26PM -0500, Andrew Ballance wrote:
> > > > On Thu, Sep 11, 2025 at 05:31:57PM -0400, Joel Fernandes wrote:
> > > > > Hello,
> > > > > Recently some of have been running into modpost errors more frequently. Ahead
> > > > > of Kangrejos, I am trying to study them, the one I looked at today is truly
> > > > > weird, below are more details.
> > > > > 
> > > > > I narrowed it down to the print statement and specifically the FFI call to
> > > > > printk bindings. This was first reported by Timur Tabi on CC.
> > > > > 
> > > > > With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
> > > > > following patch when applied to nova-core will fail to build with following
> > > > > errors. The question is why does the overflow checking fail since the
> > > > > arithmetic is valid, and why only during printing (and say not during the
> > > > > call to write32).
> > > > > 
> > > > >    MODPOST Module.symvers
> > > > > ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
> > > > > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > > > make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
> > > > > make: *** [Makefile:248: __sub-make] Error 2
> > > > > 
> > > > > Any comments or thoughts?
> > > > > 
> > > > 
> > > > Io::write32 tries to do a bounds check at compile time and if it cannot
> > > > be done it causes a build error. it looks like because a pointer to
> > > > offset is passed across a ffi boundary, rustc makes no assumptions about
> > > > the value of offset. so it cannot do the bounds check at compile time
> > > > and causes a build error.
> > > 
> > > Are you saying this issue is related to iowrite32? I don't think so because
> > > the issue does not happen if you comment out the pr_err in my example and
> > > leave the write32 as it is. So it is something with the call to printk (FFI).
> > > 
> > > Why can't it assume the value of offset? All the values to compute it are
> > > available at compile time right?
> > > 
> > > thanks,
> > > 
> > >   - Joel
> > > 
> > 
> > This is a resend because I forgot to cc the mailing list.
> > 
> > it has to do with the FFI call. The value of offset can be found out at
> > compile time, but because a pointer is passed through, the c side could
> > theoretically change the value before write32 is called.
> > The pointer passed is const so rustc should assume that the c side does
> > not change offset, but looks like rustc does not do that.
> > 
> > as a test i created a version where a copy of offset is passed to printk
> > instead of offset and it compiles.
> > e.g:
> > // SNIP
> > let offset = <B as kernel::io::register::RegisterBase<$base>>::BASE
> >     + Self::OFFSET
> >     + (idx * Self::STRIDE);
> > let offset_copy = offset;
> > 
> > pr_err!("{}", offset_copy);
> > io.write32(self.0, offset);
> > // SNIP
> 
> Andrew,
> Thanks, I came to the same conclusion. After the first FFI call, the compiler
> has to redo the overflow checking and cannot optimize it away. The issue does
> not happen if either drop the print, or the io.write32, so it is their
> combination that causes the issue.
> 
> So I guess how do we fix it? One crude way could be for the print macro to
> alias its arguments automatically. But that does not fix the general problem
> as it could occur with other FFI calls as well, not just printing.

I even see it with the following simple example, just using same variable
between safe and unsafe code, here offset is not even going to the C side
(there's no print):

  let mut offset = 0;
  unsafe {
    offset = 5;
  }
  io.write32(self.0, offset);

So maybe the issue is that the FFI related to print involves unsafe { },
hence it causes the same issue there too?

thanks,

 - Joel



