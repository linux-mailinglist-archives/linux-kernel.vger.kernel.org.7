Return-Path: <linux-kernel+bounces-818603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C921B593DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4E94E3EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFB72F83DE;
	Tue, 16 Sep 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="buQbcoEe"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766442BE035;
	Tue, 16 Sep 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018779; cv=fail; b=Z7abe4L4gC2B4RgydyMPBx0QkcrRrNfOOLIETpS8McTJzeIedBuHLvg19E2++IUbsCgS9GSQV7GvGqG0H812frubCpyq8nLW6Oua5FnljJuM9lprmAM0F5hq0JaO5y5Ny1TFd2XFWGiLHVfwTUJ/oW7yM4gKT/PLWqOdGKne/Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018779; c=relaxed/simple;
	bh=hgGbs8DDU5Lyhj5GoAfqe513XeuqOYoinNgb9SI93y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PhF79046ycY301kSO0YMHabgpZpktJMG/onsLNE6fiM2FbihCq6jqPzCa07TWNZLpS6gNlgwr9RHSrlYIi6LemCNOuj8uHPkxLeerAFM7aFHckhkFEJoHSWnm58bo3BDzlaSn8xcE7e5USWeFJLlqW8Bc5XYXPJak5qadfp5GWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=buQbcoEe; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKjpSCl3wKDKfzShTRAuy47Xaif5E9X1DV8xxmF5AyLLdKep8v9Ss+8Tj+lCdc2aYltW0SfFa8KK2TDfnP+LB5xPIlssVTwcMpKefAVUgm/VqWYGuZtchzo988giriNn1rvSBQyqrFOLXUPrrX5yi9Khwsjcb7MqQstt6tG6OABwKzdNPKkTnv1BiSIjwBoG+Hm5eYtT8PMYBPgSBYDhwTmobAdthHssDuQheqoKukSi/SsjD6yxxA9Q0u9647OHbKr2srSW5GKIQUveM7LIYgPrHP8D6XCfcaxP+nSfIlIjJxYEUCemLStkzn+fX9o9K1nO6ku7ETJnhM088dXlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaNHbQ5gt8fYrDN8hCCNdz0ylNFycpvzbc3yNsxFn/M=;
 b=jN6a2FkBMKCCIYBxYLon6SWNSGSscSTwpLQuDI9QSTwQYhdmVowqLV7COFTysJ1sLcvjbvRe5+0iP37c7+wbayNgLjQooY4XEJySDux7jHXlQ6jzYTLVkEPIMPz0EalTFkksQO8JzfaSrexDRCD8hKdJwu5v5F6WfXXknUBC13u264c+tLxppU+u1pn+MPDnNzoxumtq9kpHuDYanxQue/6xECyCOpq+TVSNl1UgUMW/A4rE1CuwHLCJVDe3CpwGAUr0kX9NultDG2wxRGsHu9VETBbGoXXUqQ5PYlPBgQ1MztE+RknC2eTyavQF3CuHLgy+6h9E3mx6XvtLFhAzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaNHbQ5gt8fYrDN8hCCNdz0ylNFycpvzbc3yNsxFn/M=;
 b=buQbcoEeefYYUwk9dqRwYhHzO8/PiADkyEpCMsxj6w/ZEFAVXUEmPQ99twPOl3tjbkSF1l38cv3FWHC+pibtCAW3xAPysh+z4YRJEWfLhAr2iqAuW2INz/BHlqGh5eSs7jF9wnuIxyHfX7uW2XbxVDF1OJeUnvGCI3kSDez/++P3JmSyFyLcwjo3fxgozGXdf8nOYLesksFVBkcts3Ym+yFwgdnIcDm8GObNYWamUgM/TXsS6gDgcve/++8jX8LVGmT041SCpgMbr4mD0n4RQwb9OcGVflUR9qOLh+epo+i0ywb+KBPqhvxD3r/NWVshyC2xHJnpvwbVb5l2iEj92Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 10:32:54 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 10:32:54 +0000
Date: Tue, 16 Sep 2025 06:32:52 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Printing with overflow checks can cause modpost errors
Message-ID: <20250916103252.GA1660986@joelbox2>
References: <20250911213157.GA1039411@joelbox2>
 <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2>
 <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
X-ClientProxiedBy: BL1PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5d9738-cea2-4852-80fc-08ddf50c651c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Xd5tXFtmpZt+D6aklEGqkjqcC5FXRD0r6SENo/VfU2cCMITBS5oljKndjK5?=
 =?us-ascii?Q?pv6pU+l45RUSkJBX8WC4peRq2wYoIENAzrX+eDYFg+gs/vtQOEXhAzeIt+XE?=
 =?us-ascii?Q?QkKUv6eJmHz1lW+tq4FggZRYBrSV1lTrYxPPN1uE/8fS3/tS93uoDPZJC5bB?=
 =?us-ascii?Q?Yf+2/TsBvd21Kr+vNeBckt6qBZ2+0BU/c0VDvsdsdr+vW1E43IpBvN+shxdU?=
 =?us-ascii?Q?5TGoL2d9l/clBxNaC21w5I6+CJE1UN20ZFZ2ohay2ab8Em00+uKxcjwhieMH?=
 =?us-ascii?Q?O7VLLOkrFhbv7gN/4hkMbwg2T++UCfUIMhsd21u0kFm4GGDNrtF43Y4JdKtr?=
 =?us-ascii?Q?8lJdtOepEKxCP0C7FvozB3yzQXUrA7iIpy4QRVzYvIXLYdPaCZk7Qwqmv00n?=
 =?us-ascii?Q?mIjd6znhGhQJYvciC4hUaUUU02QJRZmNVYCOAOthroZBL5+h16vdnbb+HQ8y?=
 =?us-ascii?Q?g2/ISVqDt+oftHRql9PxRJkwh0v2PT1N68Oy65TH8vqg3R4QX/rifEiDLuV2?=
 =?us-ascii?Q?ZAkfjz0lt49HiRfplP4n/vkpUwGktKo7ICrYc0GIoem3leTJyNO1g10krJ74?=
 =?us-ascii?Q?lhZLYB1uX0iq4z9M5g2C6SvJI35EPg1a+oWTbziIbHMEjix9j2ib5onAsA8o?=
 =?us-ascii?Q?fvp+o5IFSyFGLC0EuYR7elAooF6dBkTzF6GydQaWqrdb28KekakMh09suhmZ?=
 =?us-ascii?Q?oXqQLG+eHVtUmNPfKJ1iqmM9D49q60W7akkd1V56oWyV9OGZcFYt6niJ8JkA?=
 =?us-ascii?Q?BNZyZBn2F+kQHPv6Q7O8HdZdRgB2V6mIaGxkQqhmMD++iyMZ5Ec+ODjronPb?=
 =?us-ascii?Q?m7ESQ7GwltSSFsXHlPoU7UtukeTxRVand1juhHwOufHvJzNqUbU/jyiNEPcS?=
 =?us-ascii?Q?nQ2ESG/a+7/icU+dsYkMvNtDRFlLHh1p84BrUQU1YxkiI4W71KTRF7KnxBBT?=
 =?us-ascii?Q?P35Td9zynM4HMu+fjPpzZ6wx+NodjppcJQeYtUOaHSg6xHSkb8MJECMHGCyR?=
 =?us-ascii?Q?km7giTR/r0HTqK9tgP76DVSi9K1nFluioxp/VzqQLotks+xYIiTGSpZCpIbh?=
 =?us-ascii?Q?t8cPNKnlzwiOWI6FJiPVja4gIBYZv7Ek4YDocrtLLYZqCEVs3WUgAxxjpRcQ?=
 =?us-ascii?Q?0vgPVqRzrGuo54hmYFE+LOtT9P09+a5Tn0P9caVqSa/oVHWpJJxbjPIiQGo2?=
 =?us-ascii?Q?5C+YGAlfIULNcr61dYyIsCbXxZiiN8vQr28ZKwzYGHnnwBXxYacq+QRznljl?=
 =?us-ascii?Q?NY/lDy/pYAP3O5H8ioIqt0w5bFPcB4X/iXDQ0NUrmUgO55NSpmTDayG+f/dw?=
 =?us-ascii?Q?8ta6Oqg9hdSHhZ74RqyN3W7jbEiEmLXQmaEG+nCdlXX0IOsS+2G+4l1Gq9ck?=
 =?us-ascii?Q?WL1nBSDgptKM/Mxt/RepVASo+WVGwAReqZ3d4034c3Z+eNmw15xxVNXKpjcU?=
 =?us-ascii?Q?5erx8E2evPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ecOwXBt9eRby5ofFX7DnqWtYzSOZC3K/V6mkELSzkNsUCfKj4lSBU6yPaS/V?=
 =?us-ascii?Q?aZMmeE9jyj0+7f17F5bsZWFdrYCwhKlYuaLNNIL95BLCgKfiST2GY9F3Puet?=
 =?us-ascii?Q?muYbpW8FjSs0AFAsxqm0drOxVAmKjdg6jrSEAe7a+ed7NvqYIAZzV1YXjbjm?=
 =?us-ascii?Q?NqeH5fQ3S3EhQ9MhnI0IAPE3hRjfkt+HiXRv+8aC9hSbjI1jqSzSn1phQL2C?=
 =?us-ascii?Q?eV8LRoMxgPOk2TsGf9uZAJBlqdNWJOz2GZeSfOsVDJLfpnyvh3m5N2tQb2Yq?=
 =?us-ascii?Q?DyhhnTPkRui5BiYoi9jw5oq5rsaernvdskiEYs/0GJYp4Z5Q7wLKgk7ob8af?=
 =?us-ascii?Q?Uh5HAJ9HrFvXE4rTp4oCPxWhaHrPMAgcyG8ogptokM/qxJCgYas1pixd8lTd?=
 =?us-ascii?Q?L2Ll9/AdMrjJmWNf5/TrLRJpDBykfveZJsb6eudhPOdeFlkgvv7uSDeYpRMR?=
 =?us-ascii?Q?SmCywS8zu5uN8CATh6T0FgB8owSHqNlO0Ex7YCxH9Gu8vkd3zJScUYT+8Jo/?=
 =?us-ascii?Q?uytA6GroqjVKoN1m/PHN77bJ8esotg2ZdF2BMGilcr4UFaXqRKn0eVU5K4z1?=
 =?us-ascii?Q?TOogiqf5cy0RtCRKw8AjZ2v1f8xO9TVI+9bdd7ogZiFI82s4akYmR5RPtiuc?=
 =?us-ascii?Q?uC/xb3vF9sYQrHyxy4MxDDlyXjL5+BRMH+pP1Dj7CZ7BVadATwNXOO5+QCTB?=
 =?us-ascii?Q?KBUK9gqJ9UbGdwfYkbOp/PZqJMRPtMP1xLb6p0LTXRPMLT13hQDgpKxpBkLL?=
 =?us-ascii?Q?ynnkhtiK6jtL+pYUOnEdL1eMd+IBotPAzrcnMAZjdTTE8tIvK7eQa/kSnRgO?=
 =?us-ascii?Q?6XshHukG6N4T98zyzznnsr4WD2/1PKMMKhBLNMIoA/w7sf7TKyvPLtuw/mrB?=
 =?us-ascii?Q?UdMOZjCr1sj1BdVGhP1Izdt991e2IAd96hrHEv16rcLxWMhfoTC+zjkhliTF?=
 =?us-ascii?Q?IEjgGHcTTIT7YeYyxxXeLYAyGK8uCfKFbuI0upeb+c1yMVABfi2A2EPrn3j8?=
 =?us-ascii?Q?f3zO50DRsLDga0hIb4p+6c3Tu2CYKDP5AVGwi/hkUowI+QkBzAmmHCviOFWm?=
 =?us-ascii?Q?V3nFS+8ALwsZAiH7S9CaBt/Rwl880xeZORskRk64P7XO+V20ZzabPArdKPeL?=
 =?us-ascii?Q?pjaTj/WB68krrorSIj/GMZfTu7CeYkMH+pgf4q+a11ZyFOyn0ExYjkPIYmfA?=
 =?us-ascii?Q?iJYMrzIUJq4Vx9xvMWgC/wr8F8Cp9Ezm+YoFfxxoJLaB08N6vzjGyYDQzrGU?=
 =?us-ascii?Q?xnHqNHjrR4gPm3fASXYGL1XP6HF+bHiH3LT9OmbWFv5yG3Q0zV+cIFtsOa7m?=
 =?us-ascii?Q?kTTLLbB78jsfqJv+JirkfKNhBjTfPHMpS2yANOVRDRrM0TSsx2WUjECAjoWu?=
 =?us-ascii?Q?+WkbSrKj85TKwq4b6cqClKCZg6b/619dnEyrPjPgcPoGJ6VUVRaGuBXZIpCS?=
 =?us-ascii?Q?bDAMWaxuvJeQ4OnVtONw1IXEpKGru5BRT+TOgkVFRocby7K4UfIMv2nV61t4?=
 =?us-ascii?Q?qezJMCUIGicvpA3VT5BLkJ/XaA6TGEB3qUmKBIDFBSXXIByRjZvSdWAhTd1X?=
 =?us-ascii?Q?xIvxveCQLWHR9JzrYJ6bQP5HLB9Bk0fQaQ4Eb0Wr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5d9738-cea2-4852-80fc-08ddf50c651c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 10:32:54.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjydtZD9Nrnmc/a61y0yWc9/Tfc/gclgBiVPLxZBBrLKNlwjJMTtlUCAsfC8dgwmGNs8LqwBE5j3q9WTGuNsJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738

On Thu, Sep 11, 2025 at 11:08:17PM -0500, Andrew Ballance wrote:
> On 9/11/25 9:53 PM, Joel Fernandes wrote:
> > On Thu, Sep 11, 2025 at 07:27:26PM -0500, Andrew Ballance wrote:
> > > On Thu, Sep 11, 2025 at 05:31:57PM -0400, Joel Fernandes wrote:
> > > > Hello,
> > > > Recently some of have been running into modpost errors more frequently. Ahead
> > > > of Kangrejos, I am trying to study them, the one I looked at today is truly
> > > > weird, below are more details.
> > > > 
> > > > I narrowed it down to the print statement and specifically the FFI call to
> > > > printk bindings. This was first reported by Timur Tabi on CC.
> > > > 
> > > > With CONFIG_RUST_OVERFLOW_CHECKS=y and CONFIG_RUST_BUILD_ASSERT_ALLOW=y, the
> > > > following patch when applied to nova-core will fail to build with following
> > > > errors. The question is why does the overflow checking fail since the
> > > > arithmetic is valid, and why only during printing (and say not during the
> > > > call to write32).
> > > > 
> > > >    MODPOST Module.symvers
> > > > ERROR: modpost: "rust_build_error" [drivers/gpu/nova-core/nova_core.ko] undefined!
> > > > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > > > make[1]: *** [/home/joelaf/repo/linux-nova-rm-call/Makefile:1961: modpost] Error 2
> > > > make: *** [Makefile:248: __sub-make] Error 2
> > > > 
> > > > Any comments or thoughts?
> > > > 
> > > 
> > > Io::write32 tries to do a bounds check at compile time and if it cannot
> > > be done it causes a build error. it looks like because a pointer to
> > > offset is passed across a ffi boundary, rustc makes no assumptions about
> > > the value of offset. so it cannot do the bounds check at compile time
> > > and causes a build error.
> > 
> > Are you saying this issue is related to iowrite32? I don't think so because
> > the issue does not happen if you comment out the pr_err in my example and
> > leave the write32 as it is. So it is something with the call to printk (FFI).
> > 
> > Why can't it assume the value of offset? All the values to compute it are
> > available at compile time right?
> > 
> > thanks,
> > 
> >   - Joel
> > 
> 
> This is a resend because I forgot to cc the mailing list.
> 
> it has to do with the FFI call. The value of offset can be found out at
> compile time, but because a pointer is passed through, the c side could
> theoretically change the value before write32 is called.
> The pointer passed is const so rustc should assume that the c side does
> not change offset, but looks like rustc does not do that.
> 
> as a test i created a version where a copy of offset is passed to printk
> instead of offset and it compiles.
> e.g:
> // SNIP
> let offset = <B as kernel::io::register::RegisterBase<$base>>::BASE
>     + Self::OFFSET
>     + (idx * Self::STRIDE);
> let offset_copy = offset;
> 
> pr_err!("{}", offset_copy);
> io.write32(self.0, offset);
> // SNIP

Andrew,
Thanks, I came to the same conclusion. After the first FFI call, the compiler
has to redo the overflow checking and cannot optimize it away. The issue does
not happen if either drop the print, or the io.write32, so it is their
combination that causes the issue.

So I guess how do we fix it? One crude way could be for the print macro to
alias its arguments automatically. But that does not fix the general problem
as it could occur with other FFI calls as well, not just printing.

thanks,

 - Joel


