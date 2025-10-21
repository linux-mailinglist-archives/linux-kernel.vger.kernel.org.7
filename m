Return-Path: <linux-kernel+bounces-863695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F20BF8DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18994813F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D5281368;
	Tue, 21 Oct 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co/aV9Mf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEE27FB37;
	Tue, 21 Oct 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080384; cv=fail; b=W55iePMcJZiwcNKQ2YjmNMEyJrvddXb7waCjHfA1fWwUfF1umXHc99J4tFRXfQD88SctDnp+9AErmfS9rEAp01bfj7qbynP29qf6aYPi5KKZ2bgWUv+86j4TGYBIJ/T22IGbtSS0quxxtIdbRQ2G/IXbw1EY+eO/gU6VV1ff4lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080384; c=relaxed/simple;
	bh=3kJ0MSj0aGBTaNzS0rCm9gXbFLpZeM/uoSGdytIKIUo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jNVvGICyjL6Zpv7Yoi940yfvcwqqg7475JOOWs9wfhoLH8+rMbWtNbjkPyhvorLmcBQet46vYkfn75dM8Q2AcFkzo5q31Nb/tYOjXZmebBGSFWyEJu/QwDnhJZfZ5MeQ16HSjgXZxtW0DArBz3UhVlSaxdSVZnMZzc9+9KhAajU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co/aV9Mf; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761080382; x=1792616382;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3kJ0MSj0aGBTaNzS0rCm9gXbFLpZeM/uoSGdytIKIUo=;
  b=co/aV9Mfdy3UiT7z7x+17M3irzkxGc3KHBQIFgrL59risL6sHBCAogVd
   IrIoHGjCqW8h3xCA6fBiVlH/TyGraLkVIhNCn2v1Oqqreb9TJyNgFiaQ/
   WbG+8JyP82BNpZwRKYROWsuu4GQEpc9kv30Qtm7iaxEro5XOziQ1atNzf
   rdEi2R5mj8jSAHM5GQ/5Qq6OHry8knaWRtPw2/w0WVJakmVGenb8e9X7A
   /Zr+yCbXlb/3aRbjz1mDKQOvySc7B1Exxp+kjSiAQIlHuyGaDd9mv6oi1
   a3fKI4CKkx7HBdnsU5UT3axUGo2TtjGKDO6UCkQnw3gKcENa8CS7LWaui
   w==;
X-CSE-ConnectionGUID: hPquCQHaQzGY3DhtAvWINg==
X-CSE-MsgGUID: n9135vDgSESrMZnhJVyOXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80656429"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="80656429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:59:42 -0700
X-CSE-ConnectionGUID: 0HjJaBqTS8iALSjcP+WRAA==
X-CSE-MsgGUID: RB/NdPC2RaavrTnt2+1UqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="188972316"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 13:59:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:59:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 13:59:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 13:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVkh+9y4nhcN2BFGiR/47FA8BucAzKiMHjA9Y7sHG65kIK0RIt+l8u9y/y+faBQOcK3ZT5kJ+LCeqGXtjsclmrEbJDitEh7OrLltWPcdHYmgpcau2YvHs/Kfmu0oZ+xSwxm/sKEcGz0VZUsulCxkM+ddIg3Ho6jIUtdBOPvgZ3vgMPLp7pC9eDf+jqk8uUBOixHMWHaegCSpEa5XDsVcE6hDOke6aIBfyYCWmEIZydPCLvs+syJ67r4VHWZV7uNTOPaUzX/oy80AAnHmlR5B6vNQxWAEXgv8IkfiXgRiNJqrlrNvnsx+yVY4K4/M/WiMoX+2fYwsE93nET7Yp711mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRZz/JJv5UCa7uU1eW8Unf5Yrn3Doh+qr5QoN6Bk6lw=;
 b=tjxbQQsujUB5uTPiIYzzzE+ctGwabx1xSY6djfcCk4rcm3IKHPAtfHDoRZZjOBudN4xdPj44OWwM/tUInSf72QRbq309PL0WdzbcLxGribE0FaEvnKHESd81jxjfiaJc/3ZbQ/fbnfkfGU/Rc3HkPK94kFyKmSDgQWLkrHuMvjRuiCkYHdhJMGMOz2wlvoI9GD7txf82AFbSTil0u00xtxQqqbubvH4C2WMzg7e4xEWp+W5ir20T//5vO451jvOxxoUCZmQ2niuVOkw2Iursq5qvLXvQSpwgbzuT6bjBIQUo0Usqa7kZiIkMlTMUgU7r7QcevEMPVh4ZubCIWaK0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 20:59:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 20:59:38 +0000
Date: Tue, 21 Oct 2025 13:59:36 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: Reinette Chatre <reinette.chatre@intel.com>,
	<linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aPf0OKwDZ4XbmVRB@agluck-desk3>
References: <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
 <aO0Oazuxt54hQFbx@e133380.arm.com>
 <bf18c704-66d0-40cb-8696-435ac1c928b5@intel.com>
 <aO/CEuyaIyZ5L28d@e133380.arm.com>
 <dd5ba9e5-9809-4792-966a-e35368ab89f0@intel.com>
 <aPJP52jXJvRYAjjV@e133380.arm.com>
 <e788ca62-ec63-4552-978b-9569f369afd5@intel.com>
 <aPZaTk97RC6sg+uQ@e133380.arm.com>
 <aPZj1nDVEYmYytY9@agluck-desk3>
 <aPearyfcnpJJ/e06@e133380.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aPearyfcnpJJ/e06@e133380.arm.com>
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f59b23a-d1b9-4212-d031-08de10e4bf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ooC36NqlM9jDrvjcp+EmVJ+nC2W59gKkYNzBoorCX6MViNYkU4bRMUQgSZdX?=
 =?us-ascii?Q?muNzOuqA5Gh7bb08A/HiT3GBupw7NfiyuRz4PvJ9ioVvi2JYmWMBaJK3mZtc?=
 =?us-ascii?Q?PTMvC/jkrTEOTSZh1WCp1Asq5dJrUlNobor9X5I7jBotbUGbq9KKChZ/FLzm?=
 =?us-ascii?Q?a+e9fEtz4/Kzo62/gEAlH4lJ1ZriLZKHlIT0b5bisi5mbhpinTEUVco4AutC?=
 =?us-ascii?Q?7cHVGTkiW/9L0tvEo1Alt+xK3co4RJMGxzwkUCLR6PYcTihMSUYHujk+55rh?=
 =?us-ascii?Q?u7sshA+gkv0eC+YpkzUgraJcVJ7o+w8VWLzvN7hfj8HJH+Z2lpm6bTGmQv5A?=
 =?us-ascii?Q?OOR+XxsWrbeBIEw9/oLT+5dTD65Cw3VhAEGJboeR9NqJKmvUhAp1W0lZMHkq?=
 =?us-ascii?Q?VwZoL12d1kmCnvxqixb3z/YSQA2BFoaq3ZSqeck5S9wbAOrRwTY3ukNYH2CJ?=
 =?us-ascii?Q?e7ulKtdrZAVH8vWTeGPm0HkAkYtTpLdXKnEPAJRAsS7W7I5YoP/XlMCa2ZQA?=
 =?us-ascii?Q?pQ9edvHeYuAgUbSukuMpR32iZNS0eelFDuoD7mVgSnTIBQKqAuOs4fPBbCW+?=
 =?us-ascii?Q?ObqE0OPliHhhe8OxL4qax/uisleit5tOByc/R98tYrzR+g+/khnk6a0XT1CZ?=
 =?us-ascii?Q?qR7NJpL8dyfjd/mRdDA69A25qcQYncC+hdJAjy9nwllk2mrUUfGt/ReWHxGG?=
 =?us-ascii?Q?EHiRSovEcxJ6yzL4HMHHzgNf1gBpaarydlgiO/9FH4UTpRhpcPV9uyRUQKtF?=
 =?us-ascii?Q?Nz6nMFP+ydvOQu3wi7eLK+EnIJhZhDJypWO12dKItrWoTzP109n+yFUcWnYk?=
 =?us-ascii?Q?HWMgVfcrLWWquaZTjLnuJrOzzd9K0jk2PmdgamFSHBxTEMZEvImx7z8zyQE/?=
 =?us-ascii?Q?jISRNqUvvUD6JMLSv/GKB3Ffkm0XdkRqzyqz1DQs3qZN2nWTSkOQYw5YTJJT?=
 =?us-ascii?Q?0s7r5aTRqskGTkNtdeUT+pUQkysUibYRuBKXWesMFUyROj0MLtX0fi2kDYG5?=
 =?us-ascii?Q?BlLnp6hI17NwNegJGlheEJtk70ew/Q1TfaB11OG/BU5rFJS9WVCQJGhnxFTo?=
 =?us-ascii?Q?f8wGQ8soO8m2ElnlNiUwAm5zPw9LnWUJayfndP2njDTsN812OKHrYPomyTwE?=
 =?us-ascii?Q?xFwGq724laM2CsV6IWMeYL8xzw/Dpq/i9hrmyiL3wUAE0NIStRyNPFbXO8GH?=
 =?us-ascii?Q?yqFkOrvxTZUcjXMd6z9TCiKpKTKkG9tsqGJPDExootCiiN9XfA1A4S+zhGr4?=
 =?us-ascii?Q?pu4XTcJtD5RzEN9HbLEryw0C240aFx9d8Uf1OZJyNuzNKeZ3+es7zcLmCzX8?=
 =?us-ascii?Q?gtX2swsmgRaVHA09p0vVxdUbncDL4P9DarzbiSSK0JtZ+X8A1tEwWbTMQ4hw?=
 =?us-ascii?Q?sMm3OYfEYIS0/mzIEiDRZFiqbuIPiphNfBxzBbtuZSZEQ3Hj0qBoyJeoGAFF?=
 =?us-ascii?Q?OptHdXGVc5yASNwxE20W8g19RHVLvA3e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdC/n9tkzOErV+hf65XcehVVgZl60frKzSHovwLut9pgan6t9hbvyBPRUoj7?=
 =?us-ascii?Q?UwOUvOwbSwYRt/1vg6OyU67Yt7DSC9QrnHRQnd4gSvqGJgMri5j1US7eq2hd?=
 =?us-ascii?Q?oi3OHyzLrvKbv4PMd8XR2eLvuP8ict9P4xeCaVEYsjmyCvWXfLb9fPQz238+?=
 =?us-ascii?Q?GSq75ItlbN6OroFsZ3xRQVqbqVZiHW8KNRuW4b9+bQg1XEVtffcXnKHfd/FV?=
 =?us-ascii?Q?nI69GJWbXE7NxJSSyDC9/eBin7ju7bssyKCD2xXG7Wb3rmfpw6Xt7Z5TsfJR?=
 =?us-ascii?Q?vJc4JN1ofCVtFNR4s2zzVjDuj4sSqYV85zvbFrKkQEeyZYAe6XD6kGe08UkL?=
 =?us-ascii?Q?RHN8GLsOKN0yjK8T/mDwY4mHYxxMj/NKTVPTHmwoGDOQ9KSM4mWU9I4FDtJv?=
 =?us-ascii?Q?gQ/hDuWPL0TrtxLBB+u7N1mXwBKHxBBVcV3ilkis1cxdtLX+5aao7wJRXiSZ?=
 =?us-ascii?Q?XpxWFHpKb7ZbPmnwchP/cw25xuPcyh3WHyaWptM9cCjsvtbhMTsaPLM2Kk+7?=
 =?us-ascii?Q?XQ/CLN0mbLa9hQK8GQkhPgmD5DwJA97FhA232nJSh8AKFYjy02x9c51ZHpz2?=
 =?us-ascii?Q?ZsHjUJGYkvZCc+CAXtr7SlkJkxiePG7V3UrE48NGypqew+bA+iotwMQukqy9?=
 =?us-ascii?Q?xM28Ft4+PnbI+1jFXYblr/9q+Stos0sYb2lBWqylJ2lkjV/TcD8vvSF+E7HG?=
 =?us-ascii?Q?Ix7jM7crt0i9pyD3xNs95GgDnMNYOdpTTqflTwXwEoTqnzlXxLTaIrWNS6pt?=
 =?us-ascii?Q?uIcRDIK2LhxHy7QWxkscPLoEn4c7Hu8RymoU51t2JL+jZEp3fD+VLHotgQYQ?=
 =?us-ascii?Q?dJ9cx6YdUb6JS7J7tB7uJjw71IuqWxWa1OtaDZR2gv5969C88ZzbwFVXF7Xw?=
 =?us-ascii?Q?hUII/sxaflpQh5FjmrMBXs6S9TkuS9Qy7vNFFzHH8LXnwiqH+Jq1ibP3zkjD?=
 =?us-ascii?Q?lecArPavu4XsTWjUewib96978mpVg5xc+jfM3eEWtsd/tkl7Rd0DW7c6c0Wq?=
 =?us-ascii?Q?oy1NudqIbjz1JB9LTDEzSJ3OLoaUYSxWBIWUXvfLQSuXpvdMXmRKlof3Qqxf?=
 =?us-ascii?Q?tYmwiN/lx3tjU8u6Kk5/MFJwkXptqcDa1TgFhfZhiX5qO1Y97kiyq6O5lHOr?=
 =?us-ascii?Q?7Sh6WjPx6nqjkYWfeDHwJgZW5UpcMdSbou+zVgfsGVaple2+tju/uoeMx6nq?=
 =?us-ascii?Q?3a6pC4HxO9i1YP3PxvUuG7HnKK6MzUSBU4dU9BP4ffLEkoWuw7B/Mb28YUAX?=
 =?us-ascii?Q?qbuES0vkumlt8LxhmS8igSMlnIwiHHNxe4aauKSPe5aSZPqDa4wytOWcfX8h?=
 =?us-ascii?Q?qqywdYJcSiuwor2Xo2twvcCanEUwncAccCO3VlQzwtJ/tdOq6IbprxDFPRkV?=
 =?us-ascii?Q?SkX7bbQ/YsTEgK/dMeTeXJJWnoKysaUvIthlXtgZzgAQFWHi0WShXhVIsWmF?=
 =?us-ascii?Q?ge52THi2ZwekwUCDCbb7yCDy9k3Z/q/y/z5ZiUfxG77MXA5NE/t+go3MGjfn?=
 =?us-ascii?Q?xC9qUE4a2M//wrPXGAO0xiuw3TkBnyPS/dj//KaYoYuigcB19v7mYhkbj5/a?=
 =?us-ascii?Q?BMbzt+7v6JGzFTj+55MtTaAW3PJXh/Gz5DmpLp4N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f59b23a-d1b9-4212-d031-08de10e4bf5c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:59:38.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AB8O7JsySsnbtvfTjFMxwj9w+5dXxtWLID/HqLDNAk7Z/xTnWZ+S0MTHNFwkB6sb4cKXwO7Phq5O9A3DowYZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com

Hi Dave,

On Tue, Oct 21, 2025 at 03:37:35PM +0100, Dave Martin wrote:
> Hi Tony,
> 
> On Mon, Oct 20, 2025 at 09:31:18AM -0700, Luck, Tony wrote:
> > On Mon, Oct 20, 2025 at 04:50:38PM +0100, Dave Martin wrote:
> > > Hi Reinette,
> > > 
> > > On Fri, Oct 17, 2025 at 08:59:45AM -0700, Reinette Chatre wrote:
> 
> [...]
> 
> > > > By extension I assume that software that understands a schema that is introduced
> > > > after the "relationship" format is established can be expected to understand the
> > > > format and thus these new schemata do not require the '#' prefix. Even if
> > > > a new schema is introduced with a single control it can be followed by a new child
> > > > control without a '#' prefix a couple of kernel releases later. By this point it
> > > > should hopefully be understood by user space that it should not write entries it does
> > > > not understand.
> > > 
> > > Generally, yes.
> > > 
> > > I think that boils down to: "OK, previously you could just tweak bits
> > > of the whole schemata file you read and write the whole thing back,
> > > and the effect would be what you inuitively expected.  But in future
> > > different schemata in the file may not be independent of one another.
> > > We'll warn you which things might not be independent, but we may not
> > > describe exactly how they affect each other.
> > 
> > Changes to the schemata file are currently "staged" and then applied.
> > There's some filesystem level error/sanity checking during the parsing
> > phase, but maybe for MB some parts can also be delayed, and re-ordered
> > when architecture code applies the changes.
> > 
> > E.g. while filesystem code could check min <= opt <= max. Architecture
> > code would be responsible to write the values to h/w in a sane manner
> > (assuming architecture cares about transient effects when things don't
> > conform to the ordering).
> > 
> > E.g. User requests moving from min,opt,max = 10,20,30 to 40,50,60
> > Regardless of the order those requests appeared in the write(2) syscall
> > architecture bumps max to 60, then opt to 50, and finally min to 40.
> 
> This could be sorted indeed be sorted out during staging, but I'm not
> sure that we can/should rely on it.
> 
> If we treat the data coming from a single write() as a transaction, and
> stage the whole thing before executing it, that's fine.  But I think
> this has to be viewed as an optimisation rather than guaranteed
> semantics.
> 
> 
> We told userspace that schemata is an S_IFREG regular file, so we have
> to accept a write() boundary anywhere in the stream.
> 
> (In fact, resctrl chokes if a write boundary occurs in the middle of a
> line.  In practice, stdio buffering and similar means that this issue
> turns out to be difficult to hit, except with shell scripts that try to
> emit a line piecemeal -- I have a partial fix for that knocking around,
> but this throws up other problems, so I gave up for the time being.)

Is this worth the pain and complexity? Maybe just document the reality
of the implementation since day 1 of resctrl that each write(2) must
contain one or more lines, each terminated with "\n".

There are already so many ways that the schemata file does not behave
like a regular S_IFREG file. E.g. accepting a write to just update
one domain in a resource: # echo L3:2=0xff > schemata

So describe schemata in terms of writing "update commands" rather
than "Lines"?

> 
> We also cannot currently rely on userspace closing the fd between
> "transactions".  We never told userspace to do that, previously.  We
> could make a new requirement, but it feels unexpected/unreasonable (?)
> 
> > > 
> > > "So, from now on, only write the things that you actually want to set."
> > > 
> > > Does that sound about right?
> > 
> > Users might still use their favorite editor on the schemata file and
> > so write everything, while only changing a subset. So if we don't go
> > for the full two-phase update I describe above this would be:
> > 
> >   "only *change* the things that you actually want to set".

I misremembered where the check for "did the user change the value"
happened. I thought it was during parsing, but it is actually in
resctrl_arch_update_domains() after all input parsing is complete
and resctrl is applying changes. So unless we change things to work
the way I hallucinated, then ordering does matter the way you
described.
> 
> [...]
> 
> > -Tony
> 
> This works if the schemata file is output in the right order (and the
> user doesn't change the order):
> 
> # cat schemata
> MB:0=100;1=100
> # MB_HW:0=1024;1=1024
> 
> ->
> 
> # cat <<EOF >schemata
> MB:0=100;1=100
> MB_HW:0=512,1=512
> EOF
> 
> ... though it may still be inefficient, if the lines are not staged
> together.  The hardware memory bandwidth controls may get programmed
> twice, here -- though the final result is probably what was intended.
> 
> I'd still prefer that we tell people that they should be doing this:
> # cat <<EOF >schemata
> MB_HW:0=512,1=512
> EOF
> 
> ...if they are really tyring to set MB_HW and don't care about the
> effect on MB?

I'm starting to worry about this co-existence of old/new syntax for
Intel region aware. Life seems simple if there is only one MB_HW
connected to the legacy "MB". Updates to either will make both
appear with new values when the schemata is read. E.g.

# cat schemata
MB:0=100
#MB_HW=255

# echo MB:0=50 > schemata

# cat schemata
MB:0=50
#MB_HW=127

But Intel will have several MB_HW controls, one for each region.
[Schemata names TBD, but I'll just call them 0, 1, 2, 3 here]

# cat schemata
MB:0=100
#MB_HW0=255
#MB_HW1=255
#MB_HW2=255
#MB_HW3=255

If the user sets just one of the HW controls:

# echo MB_HW1=64

what should resctrl display for the legacy "MB:" line?

> 
> Cheers
> ---Dave

-Tony

