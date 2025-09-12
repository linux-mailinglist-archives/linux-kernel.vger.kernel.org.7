Return-Path: <linux-kernel+bounces-813100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDEBB540B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B5E48031D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2C220F2D;
	Fri, 12 Sep 2025 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JfntySs/"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81863155A4E;
	Fri, 12 Sep 2025 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645629; cv=fail; b=tNPNcVLXpXthRVetEKG2UY6mh0a6nsXujcTB9oAXTmEfP2EKaalfqt10qJD9wC4Wx5dEWOCnJyJZvfhwGRwf7s0bQGHhbaaXRQ/bcmQhok5JbOliQfVQKXMLUh+3HpGn2U0g03n25dA4Cx5lckoFG5CSqcTTO11s2VbzcI8wrGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645629; c=relaxed/simple;
	bh=Zt4y6LIPubCAUqi57bTc7XqHd1MZ0VPOTcd06B/dUGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iDIfUT0Mr1sxDqQXboogx6IljC7T9A9b5GnrgzoRvpeZrAOm926GfgQKmmoGOip/Q9iY7G8zQSQrPwBCpbz6+0T2CRKH1T8Sz82QMBYxbKSf/uvE3lPeG8BgI73C1+Tmfjd4BCC3emcdvUIOil8ylnJyKOpg0StJIbn7cIthxEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JfntySs/; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/C9mW2HAYvU8dfouzR2sOuT5BwePjz+ZBrQlXZk5zTt1QDtxpE3tmxSRlN2sbd8vaQyug926nvvrvCG8zWoT+6JQ+5+JDiuLtDcemVdHDOaotYq8913bOxxOpNKmtTb7JjYINey1W87g7QXDTWFNbdJEX8OOcdfiHP4pxsye0hW3WZEkzRHY9yW97NpxCLrXYH5SAaf+GUNCJXr5e6XokQQ/vNkfLE2YtcvID8I2bsYHcscItuc+jAr1wm2NDfEJQ1JFEH+2cMHds7fcw1sp+6maJzrtYq68jBoT6DoxTJo56I/2U/uZnNGgPcz+bWPReRUgpiDoJ1ScYn53d8vYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKiLY2EGRgq93FFiLGHdSG8NHtFo5lIzkrMJmfIrdOs=;
 b=lcWkIDr60uHFwspxyhdE88sxY+bhjFPcKsPn2g3Qitxq7Y0BnykpBUzC+b7igrsxZOrBO/ThuF1H0vQJvsWa2i2+Z48ZkJhsdR6CfyJOFzDJPk0WWOkOlfQwOdfqN6bWQpgQEbOoNp4uHe7cCcztoQeUA6yNBqB5TbtYtQKiobz9sFmP0ql9E73tA3CMJNHMg3+9HmN1l3KomgWV1kBSpieXZdnQwh+5WnQxF58uYDTdwXhMusYnczaAXxae7ML1DIfq2QdcBzKOJJrYPp4VrtFIHK+6U7B12/k1ma+9JcnU8eYYg5amaSJWxBcDjFqood0MFKF+aFq7Cv/k7myl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKiLY2EGRgq93FFiLGHdSG8NHtFo5lIzkrMJmfIrdOs=;
 b=JfntySs/ddc+h74Z4hHoSdaIC6manVPkV9xHwKje5N/JbRCzlc38j6WA4F38rg09GZumIi1njBhP2YcB9eMsTMBqXIkp1fswIdrDmnR3H/74FKILbQMms2Dam6uys6GK7BilIufQ82cT+xw0mjARrBACGXWyqpuL5oV8Wz2JiNChYUoa3JtYR/2uez5rg5p2gNreCDf6bHMgmELh0OhABELehdEMgt0CX0HNFc6tC9gBRDzzOMREnUhFEMZ697EafAPm1iIOUSjz1MYYNFsc2Ujukcb0PMzCtg5syWzeC8ONBY4bSrpra1J88/YnTrHgxeewkjwon1Qy26XqOOFWPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 02:53:45 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 02:53:45 +0000
Date: Thu, 11 Sep 2025 22:53:43 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Printing with overflow checks can cause modpost errors
Message-ID: <20250912025343.GA1376629@joelbox2>
References: <20250911213157.GA1039411@joelbox2>
 <aMNo7qRCp_yprUAW@my-computer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMNo7qRCp_yprUAW@my-computer>
X-ClientProxiedBy: BN9PR03CA0939.namprd03.prod.outlook.com
 (2603:10b6:408:108::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1aeb50-be0f-4663-5050-08ddf1a796e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXz4eo7bHAeh7alor3nQgwl10t5MbP9FJJoV0G7Pm+q915Yf51GaXrVD8Qak?=
 =?us-ascii?Q?4FvS2DL7MFD7sTXTurq+MlKx8q2x5+bbcPzF7kZPo15SSgUGWUJbY0tDftvN?=
 =?us-ascii?Q?eWIOoOLXs44wD+uiBEUkT0sM57HnNUiX5O1F37jZKSoU9laJddsRrUGbg73d?=
 =?us-ascii?Q?DL9VjD1+fVEIbSnEEqKk/huk/Oz/mzqRiaFrJKVQvoNb3QBBQ06kVTiIVWT1?=
 =?us-ascii?Q?pC4PnEqvWoe0ShWT59gBnjyI7lEbohPaf6M5KqSZXkrDuN1OoXcfFdGFyzBX?=
 =?us-ascii?Q?7We/VACr9t1q3O9J6hXqwG4uu8wJ+SOlkd2aADGQhJoTsIqySd3aUrFjY7w/?=
 =?us-ascii?Q?h9ohf+hzTUDwPafj03HsFSey2fXD3R1208yNkhDNDff8yziSkI9/DBCIgea/?=
 =?us-ascii?Q?u9h77q1TLh3q1D/OcTkdh+hXN1FSAcHjgKAFnu17kUG+baytIB+Kjdhdqd2f?=
 =?us-ascii?Q?ZNqJauMF9mplAzoUx8KwXfVUbIsrgwLe8D2ArOm5dMASW09xt7an7OFEq7nX?=
 =?us-ascii?Q?PBWR85oMW1y1mOiZDcMK2gE3Wh3SVfanLufpCgtuA4/N3G8sTpsLmZDUuz7r?=
 =?us-ascii?Q?seqyr9GzmTlYvR3NNs1DE77Rjd/U1ouy0JAtstlWZ7HjWZ6h59nuwX33RIb8?=
 =?us-ascii?Q?pt/A5Ye9C4oLWYd5borElA4Rg46W4/2xZ5euu59R61b3AuIHrcNZL9pSmhvk?=
 =?us-ascii?Q?SY88wLPfg+uJL7sr/3Vl5fU0PmMQEJSmGYSKemuIiLgsitOzkcPuobu3aOAz?=
 =?us-ascii?Q?JNm32eDsiZjqaeHMXaD89B9H3JMP88axqtzDhfi7EC6UDu+VNLx99ithjtFD?=
 =?us-ascii?Q?zhbpzIAOseZTMvKD71rYraT3nWh4EljD6KhxvdJsIzlhrR1mNyavFYpXMU/e?=
 =?us-ascii?Q?RNr9AM8fpkYESGyykPNd6gWm4TYjo1wV4+RGKO0Xz54WA5CVcZOJ+7jj3qyw?=
 =?us-ascii?Q?/RbDZyTny0baIUYXk6KgXxKAd9DJVWu70RNACmxF43b+AO4k22ud0PXrITGT?=
 =?us-ascii?Q?QOV2WjGOJMCf4q4+wbNaq+8TRNGteMd4bnOEkCQm3P0lvHuPRkUFNR6QRQda?=
 =?us-ascii?Q?1sS7x12438fQwZwmNgUzUGzktdklzJ7C5WZ+9ispholwk+Zfch77b+MEVejs?=
 =?us-ascii?Q?AHjwa0ugUl7zcF9iJQll/QfeZsHEzN0ldSTot7/TtzO+oxURPDkn7zAxnGEK?=
 =?us-ascii?Q?pj3kLnszNtq5ktqZMCkxj6Nh8soaV8nSniUi62/Ai4O5ZRswgCDbmWRCRZtd?=
 =?us-ascii?Q?NRzrH7b9+Bt2BZ6hTpCytmKbMR/5YWxUhZxTNXSivCw7GMjrCtl7zkE3Asvi?=
 =?us-ascii?Q?w27BkTSZhhti5yHY8nAa35ETTyh9QxuNbZPwc34R48UCxUmXXqXySEWUngI+?=
 =?us-ascii?Q?mKp7RsuLSvWmLGH2Wf0f+6mPRehrvZMq76FWMiScRbxworJxof+Mso7QgRLj?=
 =?us-ascii?Q?+nBITa9p48E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OywLHnh91u+7S+9vEVjiJpSSQSvK6oop5aRujwU/3iOYMRf00KylBdVENm2T?=
 =?us-ascii?Q?627lOihtgOGbjDSyIeAfDTsS/YIPydUYBT+pUlJ+BxSyz++LX32LC4g0fAIC?=
 =?us-ascii?Q?q/DxPyt6C7Pz+IdY/jloL9adn8qy56g2MiLxWCl20AKiWJieig4SUjhPVnT5?=
 =?us-ascii?Q?M8ox1BMGTKFtcyZbZiwwvGJTZKXFZz0+XMHgHWlrDQbL/FIw09H8/+XoNQJJ?=
 =?us-ascii?Q?lHzxbROl/jPmK+m7eXYr1CmzZd3lPD5qj7JkvzPhZBTLbg57rRQEjvNI4jta?=
 =?us-ascii?Q?P2RSP8rdS0bU1jrpkG3JdEuSFXk8CIGYimzPcCPhJibh6EPHiV+0aFgcxsya?=
 =?us-ascii?Q?s6sK+I4EfQHJYoz1JTPFF0TwEjCD6gSG0JNXY7ugmtdbEgV12cWmNxgcZje9?=
 =?us-ascii?Q?5NJ1BCi12S/4t8Hn3e8SUXYQiuL/SYZUTvTArDhErgK7lYQK3a3baIWuzAaP?=
 =?us-ascii?Q?tyoSDjYkFqcFe71Cyywzuk7xKmX12hPYLL1Wb4MofSojJRkxoKNpOeIS5wf0?=
 =?us-ascii?Q?CDDvbzoIx7/L48NYtVBV/6mAfyiTZ+HgOhpdKP6JoHgiLesx5WFb54TY4IAb?=
 =?us-ascii?Q?mCdA2R7X0cdo8cKWzIogrVfX3o4OQHvFjrHbtplo81n7iqm08iGFKcgRZwbO?=
 =?us-ascii?Q?54HWCeRmoFtzOw0v6YypTk5dhp8bbgtMEKEvvRx5IAAa3J2azO5K+gsc8ebw?=
 =?us-ascii?Q?GkFHMhruQrQrx0XAhk2WwXayQ3n+M0S6Jkr5xeonz0p02sQ67Z+f1/hJBUjJ?=
 =?us-ascii?Q?TAV96MLYeZYgS5MajGXG4BLXH/QsTFJBQNsarz9njEyUOW2vo+kl//A6quw4?=
 =?us-ascii?Q?5kTiL0OTgK8495SHN3N7W6upobt/7jk2AGP/hlD3nOHioXvImYRnotXbDrL7?=
 =?us-ascii?Q?z6ltPETnhwegJ+4UIsS2y8OFoQGuEfCoPm9QJAWjSPE+7gxtuZ9fZFKyitjA?=
 =?us-ascii?Q?QBdf1ix6zOB0NxqjdHad6+5Mv7BVfdCpArFVICZ8bEQdXlSpjvu5ZuokioAo?=
 =?us-ascii?Q?k46wOQmQDADxgwqVQqKcjv4PeWTMMzfzjHUCAMYIJWqQEqDYmjbkzIZyJMt1?=
 =?us-ascii?Q?5th/pSZlcoP7IB6kfuDFUXrfQ6bDjhXeC3o8PyQB5LjEmaDs98YSRmksjbQT?=
 =?us-ascii?Q?H10D0o0UNcvBUAUTZ3nQZNLtwLujnFv1XFmVXLDIdKLXr4f9o9WJh8w14DlU?=
 =?us-ascii?Q?+CtDgizl1AMu464j1Nx7Ztjyi5kn3Mk0fEqU9HQ6tH7KckOVkA0HOnIORQOO?=
 =?us-ascii?Q?JxAHlnr/yrwEXmpJokwPa7JvExKbtLOrBxTTayvFIiHyiaJizXHS8x+01ptd?=
 =?us-ascii?Q?6h/hwZ7qJMmUoWxEid9Ve3adEvcEzF60+V+dszm1mwD61NOr/F+CzjQMsJUg?=
 =?us-ascii?Q?YgHkbyWdz5hKYSC/MAtRNWzABhzZ/dL4PwL/kopjBBZ19YszdGcqcK3Ir1Gs?=
 =?us-ascii?Q?6oxo9+Jbk6djHoHUNyPJCpusRPm+EcKs6wBOKKSec/AkT/D0Adf4O4+Whyub?=
 =?us-ascii?Q?3TP8ujxFReAukztk90nkJ1dNfuJD0/5aq6kKQVpxqItf2aK2ZtnyJOtL4waw?=
 =?us-ascii?Q?wQ++mOnv3+WfWlV3BoqYgkMZTEoazXN7vrkCDP9e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1aeb50-be0f-4663-5050-08ddf1a796e5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:53:45.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L6K64ElWOmZ8QfSLwLu8HvwFfqZrIwva+3moLDt9u3DdXur5OKmpxdeCl3mNE/eQ2plz8KaeouisWdoiui6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

On Thu, Sep 11, 2025 at 07:27:26PM -0500, Andrew Ballance wrote:
> On Thu, Sep 11, 2025 at 05:31:57PM -0400, Joel Fernandes wrote:
> > Hello,
> > Recently some of have been running into modpost errors more frequently. Ahead
> > of Kangrejos, I am trying to study them, the one I looked at today is truly
> > weird, below are more details.
> > 
> > I narrowed it down to the print statement and specifically the FFI call to
> > printk bindings. This was first reported by Timur Tabi on CC. 
> > 
> > With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
> > following patch when applied to nova-core will fail to build with following
> > errors. The question is why does the overflow checking fail since the
> > arithmetic is valid, and why only during printing (and say not during the
> > call to write32).
> > 
> >   MODPOST Module.symvers
> > ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
> > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> > 
> > Any comments or thoughts?
> > 
> 
> Io::write32 tries to do a bounds check at compile time and if it cannot
> be done it causes a build error. it looks like because a pointer to
> offset is passed across a ffi boundary, rustc makes no assumptions about
> the value of offset. so it cannot do the bounds check at compile time
> and causes a build error.

Are you saying this issue is related to iowrite32? I don't think so because
the issue does not happen if you comment out the pr_err in my example and
leave the write32 as it is. So it is something with the call to printk (FFI).

Why can't it assume the value of offset? All the values to compute it are
available at compile time right?

thanks,

 - Joel


