Return-Path: <linux-kernel+bounces-868562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5518C057A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BF54FFE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E5930E857;
	Fri, 24 Oct 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+6zv6Jt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59430E82E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300280; cv=fail; b=k1idzuYd+hGoKJhFCYT9peQyrhqQJX5y17A8d7bGVsc4aUjorTmcggeoh2xdPXPz+APwx6RJgQVpGCDCQZEWlBvxtAtTAPTJQe2MHwxtXpqcy4E2xvD0AjGpK+3gq3LprvptpqFhSnPq1luCXZzcDYPaPpXyPDRkveEGYA39rDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300280; c=relaxed/simple;
	bh=BAs15EWHNPnyQEtIa9ijFfcNzO1IWl0e1VGmJoS+cR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pnoQUStRbfzPIj6wvJFMO6+IsegUX489BHvTUxNcWc28/oOaYel8lRYL1cZ4PzY6QIRVgYt50/rGr0z0vCkBwIxNRm95Ua/WtbuGczT8gM16ix0e3LVGVAPlnTvCxkJS6R/lUW6/iXnwkxVQIJaBNEMZimJWXSDtUeVFT7nnqlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+6zv6Jt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761300279; x=1792836279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BAs15EWHNPnyQEtIa9ijFfcNzO1IWl0e1VGmJoS+cR0=;
  b=I+6zv6JtXUT4R8p4S3mbTFaxDFNHwI9aMzeC/nXRwyGgpzR2Bnw5pj+D
   mP4HFPaEK8KybGNJF3ni/9dEeLOsiSl8UlFzt3lSW69smOWwiM457zu+E
   8WYd1qAwXbk8Lin4W3rKKQGjIOOj05XH9PoCLN2f0oqy0g+lI+Dd/mqB3
   SnB+WviyGHouYF4mifNjvlA9Mpa66x3ds07We70pO2M2wIoM8riIxTxqt
   XJ38uG8r0YLOBoXtlNmPyhcuygssrjW5m3VKwXMOJHTIgesShei2kp4JL
   gWZUEfoY9lGOEBdXaiKC39JcqYg+llsvgGvLBVYy437HlhSFqyqIAQLES
   w==;
X-CSE-ConnectionGUID: l47fora/Sh+qtxDGpC6HVg==
X-CSE-MsgGUID: AZhMghgwT2WLgFNAys/kXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63576666"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="63576666"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 03:04:38 -0700
X-CSE-ConnectionGUID: +OLJltceRVqEhY17uXBeaw==
X-CSE-MsgGUID: 9CVU/2RaRrqdJoJZNY/hpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="184003410"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 03:04:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 03:04:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 03:04:37 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 03:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJtG8Fwaff/MrZ9OXFbZt+XejkbELRCQAwrRVlU49ZXblSXlVKBcNGoSvDc8z2zadesgUk2P9UvOsJec/hjCRu6uf18vifsFKH5dYz3DrBz8j2/a+Zr9HN+NUXG4tVpSl89SjHLGqOblskE/I2k/BoasrFOPe8Abluu4rxuYDF02SK1CnxTUoG3mI45Z/EEbKdTJ6XsAAPlAEOTeun6UYQoI+J37nHzV95PR29FvpHfCeO9rITD9wSyrDxNbp94WgumjoVv8RKPmdtf9ZcWnxh9u7J5uvBQxOq81vuqWEISQWeNh9epwAsgrS78ZUoikLQe4vZP++zW1XStwe2sLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nfci0ktfXUar3ZpLxnwGoviEHfmKCw1b91LNlaJsAK0=;
 b=Vc+v+Cbf+RmbQkOiQcAETxuLlp8VzOOS3mN4kIwyFR207Pu6jKBlrtci/vdLAX+6HbyKKxXHrasCXJSkQbk4qZnnaGdxvUt6SBtWSRCNoNxRyyecuMqBOaSRTFikzAkFM7+NIKkCHrIUxVL7g5WkmB4goEbq7OEdMlifNpFqjfmhq8U4kkE8BLmaBeIer71polm9Pe+lXhpiQT0lHPfOvydjNKi6YzA8NbpaiKlZqyE+fD3v4KiHu3DNewTcDW2mU8Ls+MB8e5ysvsZpbVo4I8VRtFIEtDpFlz3AHBC3RWG6RnGncNnpFKZ0NTVHl4lmtJrfolPF2E+l/CWSGBr8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 10:04:35 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:04:35 +0000
Date: Fri, 24 Oct 2025 18:04:24 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: Dave Hansen <dave.hansen@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Kai Huang <kai.huang@intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Retrieve TDX module version
Message-ID: <aPtPKP7d9dbgcL6w@intel.com>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-2-chao.gao@intel.com>
 <934568ea-b9a0-4ea8-b62f-2edfd2e64f9f@intel.com>
 <aPiNy8Q3uPrlVlug@intel.com>
 <nfos7qsdendp45avmlpbftmekckewwvbb6romybh2dnbvomfee@a5lqto3xkeak>
 <aPsds5SCmmoG4IJO@intel.com>
 <mvwzymoykhb6symwvwcc5liws4nb5cnxbyibh25gt67kufxhy2@vnqb3npptx5z>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <mvwzymoykhb6symwvwcc5liws4nb5cnxbyibh25gt67kufxhy2@vnqb3npptx5z>
X-ClientProxiedBy: KU1PR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:802:19::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DM6PR11MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b96268-c0fb-4c8e-ccb5-08de12e4bc67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jNY3LSWO0+qGGPj4QW6Kb7KlMI1SkBJmgn1hPD1DVdWLm4ty4Nk2qWP+8l63?=
 =?us-ascii?Q?bYhq7+D89+QJQ3uvVrujFyOPwEuetWseBE/ZmNnVn1NBj1A72LOzpc4c1LKO?=
 =?us-ascii?Q?kX8uaT6yklNcyPER2hshzCmlPVukb39d2r7/wFi6i/XhQhhb0WzwrqgjQwKC?=
 =?us-ascii?Q?qvMbBIB4hYEDe9AQiFuLy5gMnFJtXokVmrFqL66f3I5dQQAEPV4V+SiFrYCK?=
 =?us-ascii?Q?3mmoht9ORyi9AwsoXbZqRqJ6Dy5rJsgsiKwgpU0WBa833XneBUOrgDdoXqoX?=
 =?us-ascii?Q?nWxaiE5DB2JKdzP8Vra9VUB1WhNAhWcSgUM4OxmXQKqz869fQ57/Dlr411O5?=
 =?us-ascii?Q?Xd/9KMrXL1TyIthSQuX4cKfctaLRMKLhCQ/HPkZO7+3oRWqqaTX3+mjdXNr+?=
 =?us-ascii?Q?tnLEE6MWSG6Uz57AQDpaCKrf6fxQnuABgQwNjH5WJK/HcVsmC8o2reBvnaIq?=
 =?us-ascii?Q?GOxHfVMBJ38W0uKSj37Bs5E8ZdSvYeEtXmMvddVGkVaFuheUkhsbvk/mo8FW?=
 =?us-ascii?Q?rmin4mWUl8STloo7yKmQGFvbdTE0PkFbrJGpcMvXkE5c3i+WGnxpQogdVmjX?=
 =?us-ascii?Q?LC+YfyBcQDBJouKcQovZ0Yr2ZwPDAAMtby9aXMT1/z6OQG76rom9aYBzQtlE?=
 =?us-ascii?Q?PNJTOplc9DNmmycF6tiVT8Pykrg15KSVN87PBgO5X0pV3GnEky8m6/u0mkL6?=
 =?us-ascii?Q?a7JC06EqS3zh+A+Ouw5aex/WCkJfpZwgPkR3t+jXb2lE8z3DQ6ys3UGveMIH?=
 =?us-ascii?Q?b7MiS5zIHE38EPYMSsZOlJUOnEOdCqbqXdj8o1AmSjQkMJFF5Vv2UiGl++/K?=
 =?us-ascii?Q?F71tLiTS0bE2EnetEbmSnYDyCmY0bI/fTv5vHUo6vcglBJv9P6xuspzuZgnj?=
 =?us-ascii?Q?7n2cOFTNENK8wc9NnhFxuDpMpbwK7a8HgILn/1eLlsZArpnyIGoVfGhgCghK?=
 =?us-ascii?Q?bq3eVKxtTyQ1Ap3BdJd9Y5YePgxbe7SDDJW01TAHWf8Bg5j7IgSW3asVjpSc?=
 =?us-ascii?Q?oXfO4cE+PhhaMTItYKWrMP7Jgam2ZAZB5uhS3tcEzvfMYpWdaNXoSfyjUmJo?=
 =?us-ascii?Q?NUzJKsKlRDlZ5o6sLrw/5e12BrC8xrdHWNf856nuIdjQxIl3k4nOQnxmCOEe?=
 =?us-ascii?Q?vWL8lPngY1fv4sXZbKa1iZQRD1JKy/GYtsr7TefI04ZGyD1p4w7yXisZ426U?=
 =?us-ascii?Q?9q9ErPwRnoubn6Oe3c//nyBjACLXuOvIu4Tj3ruOv2/fsljnMwC3e8CnWeSF?=
 =?us-ascii?Q?LjqttvoyKq+ZzJuVuM1+QVKEKzZpIwrYJLqt6ydTtCULIyEyh6tHjF4l9KaS?=
 =?us-ascii?Q?rwamzQG5df4u0M9yac3cLSr3OXsVtESDw1IdEfkR0ORCyliBGlpUraSnvgep?=
 =?us-ascii?Q?3oTM/5MlAjU+d4ym6xnZg2S5jFflBslpKqYtQSWu1kLFTDvfZ0WzrLNfDxZy?=
 =?us-ascii?Q?8PiTwsMqUt6qr3JjEVXg2QJzIT1JwelA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8UPSqPdIwkw7/NOsWRr3I6g7AU1hsvbSaRcrQQHlns6ChJYkWIKnQP2gDVY?=
 =?us-ascii?Q?Yx4xBTJuxvjvGgprbDKDfLmjqbY4pgnky6A3CGXNvbDh9PquCOwygj+aEuJZ?=
 =?us-ascii?Q?bE4gircOwLKXcFb5efMmj9NK4naNfH4dzALPvw24KdyRck6EKc7dERJo6Wqe?=
 =?us-ascii?Q?vh/UbiigG9iRrlSkpH4+9NX2zNhFmJBgvLjVguiUldi5w3fTCS9bJ8fG+Apn?=
 =?us-ascii?Q?NsIBaGZddOBNpryy5t0cmxWfL/lDi4Zg1tPk+rzX81TXczFX1rx0RJLNQ9Kh?=
 =?us-ascii?Q?VsXb0i2jqSkRELeSpl2ahkZNcwa6LiD7qRcI5lNwlZYBDXmjNAq4pwxiHSAi?=
 =?us-ascii?Q?E1CGL0gb5nogcDdPcY2ShebXEc30tkP6y1qovlHVFyXlWHM4DhAj+juvHFMI?=
 =?us-ascii?Q?cD1YJzSqNjcYxSoeOrlczpZEwCpCtYCakNzatc6o0/0wIW7049F5zU+jTqzg?=
 =?us-ascii?Q?7rka3kZzn7KLyURpV08CXlzPLZ7ThNvDrQxEQ3zDsIXgrKhCVLssUSnRCOiF?=
 =?us-ascii?Q?8d7Xo8DqelaLYfIx9TUxCqwc3HEyu3e4HbJrYS3h4ZmMwDqWPfQ9Qv5aKeqF?=
 =?us-ascii?Q?YYvds0Fk0FvCozqJwL0KWiHvD7f1M0DfONxSwwgs7xFNBQREMdD+QsQWBVyG?=
 =?us-ascii?Q?67A4YMM7u6BTl67948FHeRelYuJVIeMkP0IMkyKxx27cVL4NbeBOZNWWUQ1I?=
 =?us-ascii?Q?Pfh2GWvGCrid9twyPsLrbf1Gl1n0/cr6z5YpnUvLACrSX9Ty3U+lojKboK6z?=
 =?us-ascii?Q?6Y3hphl2ZjOz1PaTuLckM9elmrZVFvGIvVd7D1tDA9e1qUYgV1RvIBHUX+pq?=
 =?us-ascii?Q?9bAL7DQQxQgEAbkk9KKYxZ9BTyRTc9U27ywlsia2+fx+blFtT5h9bcRSzJ+y?=
 =?us-ascii?Q?iFTak+zCgMkh4+b2jwYZjpeELB7GxCkitoJrBZGQTwTZtMff4hXNUBEuB4dV?=
 =?us-ascii?Q?0QRJ58NA+UJLctTS2VWLHuZxoDDQDWUH0ZrNoyiy64UjY1jFLnAX4PtXxl8J?=
 =?us-ascii?Q?4ryXRP9H35WBGiuAFZxw7nhyTdUct8pyxwAhyF4GhutpDW4tI0v7cV3Jor0Q?=
 =?us-ascii?Q?/IcCLFuQasPyRn+BYsi7rV0bu1Zxo5jHjIVPl1F5OxPvAqu69A+K4hyQDFZm?=
 =?us-ascii?Q?VeLUyAxOiocIGU5RWFh/ureO9PzAe11ToeA6vqvH1707RbNqdBCScf8/eJK7?=
 =?us-ascii?Q?8Wv5Jfe2Bxuktyh8X8+iuKwt7twX1Us346hZLe6iapWpiQyAlF2eyGVrKW81?=
 =?us-ascii?Q?LZpdJmuWY9OLivsIHHRVU2Eb/BRUdPnyUo71La4cN+8oJkD0sIy8Yq2up2na?=
 =?us-ascii?Q?9p1rD+OqoPF1mHqFslRSC9GHp2M3soKwSDlXnCwSoc5Wu3hHuHtMMDqi2XYs?=
 =?us-ascii?Q?7KG1YyaxIa3BJEM9FtPmFNOCUC6lYEdLzCMAp/rEXf+g1uezbnt8HWg7nePw?=
 =?us-ascii?Q?aYMy2iwL/C1fnsRnYC9A+CX6sRyDeSdZYG3isrNTZSebc1GP71+2oj/R23X7?=
 =?us-ascii?Q?oyRGC8+jYt9x5vtPvf3I4MLe5XpnMykZroML2dX1YyYoaI8dC5fbXdWGmtuP?=
 =?us-ascii?Q?eSEOWKocUWEVajkUzUJLnDLV8GmAx6mYKVEZbA17?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b96268-c0fb-4c8e-ccb5-08de12e4bc67
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:04:35.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUQwhKF0mLSp51jjqAfciHPG5L2KWkvZRb2LONp2oi8eRIXSB7OCHlwkGIcgklcIYZhE5k2POcjbaKcI+HGNXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com

>> >Hm. Isn't it buggy?
>> >
>> >Caller expects to see field_id == -1 to exit loop, but you never set it
>> >in case of an error. It will result in endless loop if error happens not on
>> >the first iteration.
>> 
>> The caller checks the return value and bails out if there was an error.
>
>I misread it. Missed the break.
>
>> >
>> >Drop the branch and always return ret.
>> 
>> Setting field_id to -1 on error appears unnecessary since callers must check
>> the return value anyway. And, even if args.r8 were copied to field_id
>> on error, this wouldn't guarantee that field_id would be set to -1, as
>> SEAMCALLs may encounter #GP/#UD exceptions where r8 remains unchanged.
>> 
>> Given this, I prefer to leave field_id as an undefined value on error, and
>> callers should not read/use it when an error occurs.
>
>It is not undefined. TDX module sets R8 to -1 in case of error.

Yes, I saw it. That's TDX module ABI. It doesn't necessarily have to be the
semantics of this kernel API. So, we have two choices:

1. Follow the TDX module, i.e., set field_id to -1 on error. Then we should do:

	if (ret)
		*field_id = -1;
	else
		*field_id = args.r8;

 to cover #GP/#UD cases.

2. Leave field_id undefined on error, as in this patch.

I don't see the value of setting field_id to -1 on error if callers are
expected to check the return value.

