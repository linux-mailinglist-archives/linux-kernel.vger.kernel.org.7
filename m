Return-Path: <linux-kernel+bounces-833312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373EBA1A41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4954C3A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EEE322765;
	Thu, 25 Sep 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHL9UBQ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA0324B26;
	Thu, 25 Sep 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836167; cv=fail; b=ucN5nLr+ORk2CPdKASopuWQJN+5po8g+emXNw9v9BfA87qTl6CvDkHucYmWW4GM82ztnHcpputQgctB4MgTStxifG52EiXIcyxc2NEL00YDGSc2xdyld3NvxdTJQmzNxEvy1WOgQdhshj3yngwebAYK3rv1HS1T0kBUQRtU+oJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836167; c=relaxed/simple;
	bh=3nxN1cfJQyTzUnNbZtdNa2WdanXBg0WJqKz4shzRUiw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V0UbKuCA5wsXgZ5XIlNpMwE0cxOeylr1MVqz9C1QzrBSJxT1ILXb8fZeXlVVJtiv5nhHet4RG6KSKrlWMudm9oEcxf6XK3unlKo6aMK+VjvWptu6qc0M/RQ1aAahuH+wjptOBC6T7BM0XDMDe5CNB4mZMqCzghJOPtx7xfR50dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHL9UBQ8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758836165; x=1790372165;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3nxN1cfJQyTzUnNbZtdNa2WdanXBg0WJqKz4shzRUiw=;
  b=bHL9UBQ8I01qd5QAziQ6f8dEYqyZDvRI4Ifj0xl4UEmAkQ1Dz+wS4IUn
   sWrwq6hO3RAcD2uWGIyZULehbboy9XLqljmaDghWTvRRs8A98unaN6FJE
   0229j+wRy159P2QVHJYMncaVPoLBKVPhl0ZKTo0Q+ORhwkIiuPDMOL83P
   GhdRmMnJ80Ni3pkIUqBWoKRXcYZaFLllBX0RRyMhEs2GlX5TujyeQnOFU
   CK2AOPlBtigQcEed6XegXInIOKzA+x1TH6chgMDyaMJeLVKwpQ5l0cAWI
   mB25UQLPlWNxlpT8FIPwGbPEphzrmABN9Gc6bdPCYa9bRLZ2V1gScQN1i
   g==;
X-CSE-ConnectionGUID: CmdS6PxmSc68QmkFVU5VWg==
X-CSE-MsgGUID: E+uyxO03R6aE1yOdcOUVQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="63800678"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="63800678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 14:36:04 -0700
X-CSE-ConnectionGUID: LsazHHfrSDmSiOrGBwiGZA==
X-CSE-MsgGUID: tAxuyWYWRua0irGcq053Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177018475"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 14:36:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 14:36:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 14:36:02 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 14:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7Mxt3Puqsg+u+8cp5m6CCwIEQ0CZxQTVTntB2k22+poUSvUgYIfwSl+V4KEFjNav0f2LmMkTGHyXmr5qnBHxRDrMmtfh48xUgxPu2BW12CLW801jDuyXMN4ivaD5jB2PbPk8NO0+tZ19qt6nVQg0QDupd1zBOTBEtlEtBNtET14vuG4oEQWB77Wm/wgYYB6BubETwtc7Cu4uqs2LYvyoaj1ly1pRHxqjmhc2wG8sQUuCDhUPSPqUPYziBrhH+Uj5dkmDjA1mG2lU+bewONieIpuUB2F2QGk3wObqCBh933jGYSp2MnzpKcXW8wxQN4NOSwMb/t/apCydGv1D/pY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGysugZmUutjcx5Lc5r2ZxNhphGbiKhUq/EdSe8wOpg=;
 b=zHekoUkV0CFqELHTdqlA/DxLjLHcYXuCnj+2womd15/WTpXoozhX1nMM+0JwLZmMO5dmXOjNzKUu69iyH6+EvjqqQrhhBBovvODy1+OqX+xENLU+LfLY/YvBS5YUvoQPYNuH9AQyQAyfy/hNIOHXL6LdVk7YbxqBT4pilivCRipMXInLluCMlzLvubRo/SYrCkSoNvbvNLCPaXNHCGALKaZo9UDRVYHdoKbJ0ttVMPDfgrJLTfsjZbZK8Hz3pzQwMNd1CQ9ak9AI3xNiMyQQ57g0jqj8bMD90X2DucOACEfmprgEX6plbL3ELhiq7QGZ3Ee5HERO1GFMz42H66edfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 PH7PR11MB6377.namprd11.prod.outlook.com (2603:10b6:510:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 21:36:00 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%5]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 21:35:59 +0000
Date: Thu, 25 Sep 2025 14:35:56 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Dave Martin <Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNW1vAd6Jhq6IkyJ@agluck-desk3>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
 <aNFfs43UBp6tjqPM@e133380.arm.com>
 <5be54a14-a7ba-49ba-8ddc-db532f2cf318@intel.com>
 <aNU5nCklRhuc4u3X@e133380.arm.com>
 <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dba03c5-cf45-4510-ab6c-2a945e73fd1c@intel.com>
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6077:EE_|PH7PR11MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 4911d22a-f08f-4303-0433-08ddfc7b84e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cEiLvbUoUrj5l4pkywuoExmnhy/X0zfqH78BJ2nrJl32A8bfBTiWvsl9pW?=
 =?iso-8859-1?Q?u51JxOTIAhKOhtCpFVR8cSPl4OvYyCiSxzk+RWi6GFPqniTwxv2r7HNQpN?=
 =?iso-8859-1?Q?HYtKSNZCk0YQ6VMG5l4rUl9gL5bz3JfTR14K4CIbvht9UNQX6nJWtQHa27?=
 =?iso-8859-1?Q?yTxgcXGwp/iOK/gccCKL2xdpohWLFJiV+uGkQwN/DCjgbX0vK2Rhx9vtzj?=
 =?iso-8859-1?Q?rYhdDQ+RhCj8c7DoeIlsYlkMcZ4i11NIJdy9B8aahUaYOwqM8+5uuU5cWj?=
 =?iso-8859-1?Q?2R8EHTZYMNMxaCfQqY9MTZCQCYwo/KDvN/w/h3WCW7WyN2XWcaUS8C0gHf?=
 =?iso-8859-1?Q?LJ3PAJy16hyQe/wqwBF+ulRNCBEVj8Hy+Y7kSVaBbswR6mcvndoT7EeHNf?=
 =?iso-8859-1?Q?lj5GK0nJe7m0tnvr3M3eSKg3xZ8X+7oCtQyoxoWpV76GMLk7dBuYrK6n2I?=
 =?iso-8859-1?Q?Za4Cmsiab6lQPacJ1E6iyM7F/ya4DX+FOaH+U7iXyriMVmo2KsW15FsCsM?=
 =?iso-8859-1?Q?8XIDgMdOF8mCl53uIvjFm7AxG27whW86aVguYtPkT7PkKEUaq9F0Ru5vzi?=
 =?iso-8859-1?Q?Dqwgf+KoMkKkkE+d8cYpRarMIH6sCwZiNXaDHAIS2hZdXCkSddTrDFFQe5?=
 =?iso-8859-1?Q?NacirwujrLWh3EBVdC2RDMlXoHkEUrHdiJKpgAE/pTTenkiIqzNoCnPpai?=
 =?iso-8859-1?Q?913SNkEls89yubFt/ykt6/+gKbQHsJI7dk8cOYgxeIrHOa2lahZR9I6vB1?=
 =?iso-8859-1?Q?n7EHjfuB9IYOx6vZi0Ukbtpa04OAdhXk/YYA73mptZKz4HowFHwPO9VrTa?=
 =?iso-8859-1?Q?x72igfyol+MTSnOj8y2NmFfmg8Z6APiUXqSnXWHg7inG//5KYEh3ul4+Q+?=
 =?iso-8859-1?Q?9hd4/J1jS5h0VV/avp91g+No0F+2CzitZIpHiZTJX1rY290qmXUSiFt898?=
 =?iso-8859-1?Q?/lwC5Lw4W/yMw9DzYd9l9W1DWGKzNsDYu/iHgw9qnnZLEZB8IpnSAbZMSq?=
 =?iso-8859-1?Q?NRywMtVsz4UIcoJKWDavwPUd7ivGJP+SaB5bvGLSZoZLhUeGD1ZS9J89Wf?=
 =?iso-8859-1?Q?V3H5HTUJb12GlALbaQGqGjdwmAi0BAM31UyoH8+f1MTJekjTp3pgo5DnKD?=
 =?iso-8859-1?Q?RbWmq4dcKWvZQAb0EsWVA76oX08Bj/piwePlgJ3vhmx0JhkKXVijm5NUko?=
 =?iso-8859-1?Q?JKRnMCXNmP7exgTEwbLchNwg1VAnYdmMzX5wC8Ei45jhudHS4OCz4gE+kZ?=
 =?iso-8859-1?Q?h6VWE+TLal7JNBaP1ZKh25o/yq6rzXClusnhRrCxYvaWzk5YOiE76pHG0z?=
 =?iso-8859-1?Q?sjbG97SD/p0Ms59MuKdjTZWhfsWPzRbJ8fdVMGUaTcPSeOvwYAYSs86clr?=
 =?iso-8859-1?Q?wDn8JemKIWLBiYupb65coDOKPvw4QSpPv0lX7A/LhmTwb9KPRyd2MFfdf+?=
 =?iso-8859-1?Q?y8NfHsPDJ+SLHRN9fQX9+9EjfQ5Ro8B8srXFRgneybuV+JXTsxNulI7ZU0?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2y0UUz8NdbHENUivulZgdObHWAdrEog5/am/OtjEKPjSEnGwXIMyzGOFwk?=
 =?iso-8859-1?Q?dGlAzoPiRnNoPCEX6hnyUnS4tV03FoPEToJGG82gHjqJHtKvcrc4AKp65T?=
 =?iso-8859-1?Q?VJJ/v05MaE/XQzXX/DJ0PahHDF0U7Ar1A/D1Dz1CEphpYjL1ZCAF6noMoP?=
 =?iso-8859-1?Q?iGLVPlZfC9w8WtlJK9JJAqvj9pxnZbKOnTuDB/9otMr7ZHRTCjvVAowCBm?=
 =?iso-8859-1?Q?1EQCmy0HxBG/0AjRXbZqdAfzEsPjN4wZ9lcKBUgT0PqDsuMZDG6PKG4gF/?=
 =?iso-8859-1?Q?Bfc3oNfUG8Pho+1qX0AOaIXpwkn0N3BuWg4aX9Eu4v80TD8iYADMqFf/a0?=
 =?iso-8859-1?Q?0gyHQJOFu7MZt+V6yvwAM2l5FVaHGrAcv/QSzk1R1cu+oC0vWaJI1dhawr?=
 =?iso-8859-1?Q?A0HjIUSff1EeDAvcF3zuxXU3MMGZNBdEL03d2dsVL8vFUpdZj3ugPvFkds?=
 =?iso-8859-1?Q?7ECjoB+t4ZAfBZvX+0tbsvyuizKOJtDJWB3QEQtAGZ7H6mJC/jmXhbk6D7?=
 =?iso-8859-1?Q?FAWy6UQFfCZIDLsqyYG4L6FAoCAanDfF8OAxG+D3KRFXjcnjDHvD1xu0Pw?=
 =?iso-8859-1?Q?Q7279oa1lD4CsKNsR0WHJM4RvxBHL7bJF2a6fm2ygeW5Pu4PmQyjlYR2DA?=
 =?iso-8859-1?Q?Jw7Zi3puH0DY1wItO4qiBdowLW7A5xePyw/xCZA+BW0kPI/C6ngYiw/s74?=
 =?iso-8859-1?Q?hXHTf996hVFmt7/pUw38XGhs0L0u4bAtarvw7FTnyPb+tkgbB24nsMoTre?=
 =?iso-8859-1?Q?5EBJ/iY1xJ1CuxVemTh22BJ91wqB2+1JkK45U6Gc21InAr3gTyRWwAyh3D?=
 =?iso-8859-1?Q?n1idXJTJwq5mX07U7Za9SrBPM2fT7M9uPsaD0z2frzUy9XMgKPsDwxF4cH?=
 =?iso-8859-1?Q?g2Uvb3A0gqbEQJMRsUxfSXXwnUVxfU8LhxDBI4FQCrOv8Eea9Pquu/EfkW?=
 =?iso-8859-1?Q?06u8908Qjosj7P3yt6c/lGqUluCQqwx3AmatVX95XR+Rbw+3BSywF63m5S?=
 =?iso-8859-1?Q?s+bi6Vq26f2Udl5SXfl0zO/dKa7m0XpEQDhlPQY03/Gd1ADvL3+lWUO2Hv?=
 =?iso-8859-1?Q?BWLyLLe6uxatdqyKbhVc/J72s5VEV7r/jNtzV+qMhjqBoKeRHrWOIXIpLZ?=
 =?iso-8859-1?Q?xU6qnVDMlXi/6xXRxXBNYXUYiFezoYx7GVQxxul7dijZ7EqvAq2/txKUCQ?=
 =?iso-8859-1?Q?BhfSQaZs0m8vWod5TQYGbNa1vtvInRURBHIJrPIMXIsKfIoPBr742hltWs?=
 =?iso-8859-1?Q?rf6b72rDHA0X7uoOFWetuUBSCvjboJTYgbNbWvdstNy0dSsmW6lnTehP83?=
 =?iso-8859-1?Q?kzv9TAh5/m6QgrP7Ub8KEdRvdXO2OeGMAlKojdoedGJZ9GWPqCJCxORnqw?=
 =?iso-8859-1?Q?dDaxamD9MeDch7x/etT4lgYcK/6pTRY0Nqa9d2F1GCuK7gcBGVKoqjU0NL?=
 =?iso-8859-1?Q?NtXZRA4svt1hL2L4ZTY+exf5mN2xciH83Fr83f8vknYcdO/hRtpsju2oAQ?=
 =?iso-8859-1?Q?Qyojfe6qrv/gzo+3Z+jPWyeVsu7Abocer/qKHpeCZBFoRDBD5sRV+Bw1ZM?=
 =?iso-8859-1?Q?zJMfYDjOi4hCprC/kJQTJSRSVBUG8JC/Ch438OWismB3wCWZ+ELV1TLKLe?=
 =?iso-8859-1?Q?ugSVFA3PJM/XHFxl0JieoTI6DewcRGu4qw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911d22a-f08f-4303-0433-08ddfc7b84e4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:35:59.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6R5lPFPNR/KcKQTRRz9Xl33btEu0PKsJ4pbSqmsjXmjMjvH6U7/+0xV9oJIp+pjmHBZV2BNipbAlQbDcm/bpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6377
X-OriginatorOrg: intel.com

On Thu, Sep 25, 2025 at 01:53:37PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 9/25/25 5:46 AM, Dave Martin wrote:
> > On Tue, Sep 23, 2025 at 10:27:40AM -0700, Reinette Chatre wrote:
> >> On 9/22/25 7:39 AM, Dave Martin wrote:
> >>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> >>>> Hi Dave,
> >>>>
> >>>> nits:
> >>>> Please use the subject prefix "x86,fs/resctrl" to be consistent with other
> >>>> resctrl code (and was established by Arm :)).
> >>>> Also please use upper case for acronym mba->MBA.
> >>>
> >>> Ack (the local custom in the MPAM code is to use "mba", but arguably,
> >>> the meaning is not quite the same -- I'll change it.)
> >>
> >> I am curious what the motivation is for the custom? Knowing this will help
> >> me to keep things consistent when the two worlds meet.
> > 
> > I think this has just evolved over time.  On the x86 side, MBA is a
> > specific architectural feature, but on the MPAM side the architecture
> > doesn't really have a name for the same thing.  Memory bandwidth is a
> > concept, but a few different types of control are defined for it, with
> > different names.
> > 
> > So, for the MPAM driver "mba" is more of a software concept than
> > something in a published spec: it's the glue that attaches to "MB"
> > resource as seen through resctrl.
> > 
> > (This isn't official though; it's just the mental model that I have
> > formed.)
> 
> I see. Thank you for the details. My mental model is simpler: write acronyms
> in upper case.
> 
> ...
> 
> >>>>> On MPAM systems, this results in somewhat worse-than-worst-case
> >>>>> rounding, since bw_gran is in general only an approximation to the
> >>>>> actual hardware granularity on these systems, and the hardware
> >>>>> bandwidth allocation control value is not natively a percentage --
> >>>>> necessitating a further conversion in the resctrl_arch_update_domains()
> >>>>> path, regardless of the conversion done at parse time.
> >>>>>
> >>>>> Allow the arch to provide its own parse-time conversion that is
> >>>>> appropriate for the hardware, and move the existing conversion to x86.
> >>>>> This will avoid accumulated error from rounding the value twice on MPAM
> >>>>> systems.
> >>>>>
> >>>>> Clarify the documentation, but avoid overly exact promises.
> >>>>>
> >>>>> Clamping to bw_min and bw_max still feels generic: leave it in the core
> >>>>> code, for now.
> >>>>
> >>>> Sounds like MPAM may be ready to start the schema parsing discussion again?
> >>>> I understand that MPAM has a few more ways to describe memory bandwidth as
> >>>> well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
> >>>> schema format to user space, which seems like a good idea for new schema.
> >>>
> >>> My own ideas in this area are a little different, though I agree with
> >>> the general idea.
> >>
> >> Should we expect a separate proposal from James?
> > 
> > At some point, yes.  We still need to have a chat about it.
> > 
> > Right now, I was just throwing an idea out there.
> 
> Thank you very much for doing so. We are digesting it.
> 
> 
> ...
> 
> >>> For this patch, my aim was to avoid changing anything unnecessarily.
> >>
> >> Understood. More below as I try to understand the details but it does not
> >> really sound as though the current interface works that great for MPAM. If I
> >> understand correctly this patch enables MPAM to use existing interface for
> >> its memory bandwidth allocations but doing so does not enable users to 
> >> obtain benefit of hardware capabilities. For that users would want to use
> >> the new interface?
> > 
> > In ideal world, probably, yes.
> > 
> > Since not all use cases will care about full precision, the MB resource
> > (approximated for MPAM) should be fine for a lot of people, but I
> > expect that sooner or later somebody will want more exact control.
> 
> ack.
> 
> > 
> >>>>> Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
> >>>>> the other tests except for the NONCONT_CAT tests, which do not seem to
> >>>>> be supported in my configuration -- and have nothing to do with the
> >>>>> code touched by this patch).
> >>>>
> >>>> Is the NONCONT_CAT test failing (i.e printing "not ok")?
> >>>>
> >>>> The NONCONT_CAT tests may print error messages as debug information as part of
> >>>> running, but these errors are expected as part of the test. The test should accurately
> >>>> state whether it passed or failed though. For example, below attempts to write
> >>>> a non-contiguous CBM to a system that does not support non-contiguous masks.
> >>>> This fails as expected, error messages printed as debugging and thus the test passes
> >>>> with an "ok".
> >>>>
> >>>> # Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
> >>>> # Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
> >>>> ok 5 L3_NONCONT_CAT: test                             
> >>>
> >>> I don't think that this was anything to do with my changes, but I don't
> >>> still seem to have the test output.  (Since this test has to do with
> >>> bitmap schemata (?), it seemed unlikely to be affected by changes to
> >>> bw_validate().)
> >>
> >> I agree that this should not have anything to do with this patch. My concern
> >> is that I understood that the test failed for a feature that is not supported.
> >> If this is the case then there may be a problem with the test. The test should
> >> not fail if the feature is not supported but instead skip the test.
> > 
> > I'll try to capture more output from this when I re-run it, so that we
> > can figure out what this is.
> 
> Thank you.
> 
> 
> ...
> 
> >>>
> >>> [...]
> >>>
> >>>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> >>>>> index c7949dd44f2f..a1d0469d6dfb 100644
> >>>>> --- a/Documentation/filesystems/resctrl.rst
> >>>>> +++ b/Documentation/filesystems/resctrl.rst
> >>>>> @@ -143,12 +143,11 @@ with respect to allocation:
> >>>>>  		user can request.
> >>>>>  
> >>>>>  "bandwidth_gran":
> >>>>> -		The granularity in which the memory bandwidth
> >>>>> +		The approximate granularity in which the memory bandwidth
> >>>>>  		percentage is allocated. The allocated
> >>>>>  		b/w percentage is rounded off to the next
> >>>>> -		control step available on the hardware. The
> >>>>> -		available bandwidth control steps are:
> >>>>> -		min_bandwidth + N * bandwidth_gran.
> >>>>> +		control step available on the hardware. The available
> >>>>> +		steps are at least as small as this value.
> >>>>
> >>>> A bit difficult to parse for me. 
> >>>> Is "at least as small as" same as "at least"?
> >>>
> >>> It was supposed to mean: "The available steps are no larger than this
> >>> value."
> >>
> >> This is clear to me, especially when compared with the planned addition to
> >> "Memory bandwidth Allocation and monitoring" ... but I do find it contradicting
> >> the paragraph below (more below).
> >>
> >>>
> >>> Formally My expectation is that this value is the smallest integer
> >>> number of percent which is not smaller than the apparent size of any
> >>> individual rounding step.  Equivalently, this is the smallest number g
> >>
> >> Considering the two statements:
> >> - "The available steps are no larger than this value."
> >> - "this value ... is not smaller than the apparent size of any individual rounding step"
> >>
> >> The "not larger" and "not smaller" sounds like all these words just end up saying that
> >> this is the step size?
> > 
> > They are intended to be the same statement: A <= B versus
> > B >= A respectively.
> 
> This is what I understood from the words ... and that made me think that it
> can be simplified to A = B ... but no need to digress ... onto the alternatives below ...
> 
> > 
> > But I'd be the first to admit that the wording is a bit twisted!
> > (I wouldn't be astonshed if I got something wrong somewhere.)
> > 
> > See below for an alternative way of describing this that might be more
> > intuitive.
> > 
> >>
> >>> for which writing "MB: 0=x" and "MB: 0=y" yield different
> >>> configurations for every in-range x and where y = x + g and y is also
> >>> in-range.
> >>>
> >>> That's a bit of a mouthful, though.  If you can think of a more
> >>> succinct way of putting it, I'm open to suggestions!
> >>>
> >>>> Please note that the documentation has a section "Memory bandwidth Allocation
> >>>> and monitoring" that also contains these exact promises.
> >>>
> >>> Hmmm, somehow I completely missed that.
> >>>
> >>> Does the following make sense?  Ideally, there would be a simpler way
> >>> to describe the discrepancy between the reported and actual values of
> >>> bw_gran...
> >>>
> >>>  |  Memory bandwidth Allocation and monitoring
> >>>  |  ==========================================
> >>>  |
> >>>  |  [...]
> >>>  |
> >>>  |  The minimum bandwidth percentage value for each cpu model is predefined
> >>>  |  and can be looked up through "info/MB/min_bandwidth". The bandwidth
> >>>  |  granularity that is allocated is also dependent on the cpu model and can
> >>>  |  be looked up at "info/MB/bandwidth_gran". The available bandwidth
> >>>  | -control steps are: min_bw + N * bw_gran. Intermediate values are rounded
> >>>  | -to the next control step available on the hardware.
> >>>  | +control steps are: min_bw + N * (bw_gran - e), where e is a
> >>>  | +non-negative, hardware-defined real constant that is less than 1.
> >>>  | +Intermediate values are rounded to the next control step available on
> >>>  | +the hardware.
> >>>  | +
> >>>  | +At the time of writing, the constant e referred to in the preceding
> >>>  | +paragraph is always zero on Intel and AMD platforms (i.e., bw_gran
> >>>  | +describes the step size exactly), but this may not be the case on other
> >>>  | +hardware when the actual granularity is not an exact divisor of 100.
> >>
> >> Have you considered how to share the value of "e" with users?
> > 
> > Perhaps introducing this "e" as an explicit parameter is a bad idea and
> > overly formal.  In practice, there are likely to various sources of
> > skid and approximation in the hardware, so exposing an actual value may
> > be counterproductive -- i.e., what usable guarantee is this providing
> > to userspace, if this is likely to be swamped by approximations
> > elsewhere?
> > 
> > Instead, maybe we can just say something like:
> > 
> >  | The available steps are spaced at roughly equal intervals between the
> >  | value reported by info/MB/min_bandwidth and 100%, inclusive.  Reading
> >  | info/MB/bandwidth_gran gives the worst-case precision of these
> >  | interval steps, in per cent.
> > 
> > What do you think?
> 
> I find "worst-case precision" a bit confusing, consider for example, what
> would "best-case precision" be? What do you think of "info/MB/bandwidth_gran gives
> the upper limit of these interval steps"? I believe this matches what you
> mentioned a couple of messages ago: "The available steps are no larger than this
> value."
> 
> (and "per cent" -> "percent")
> 
> > 
> > If that's adequate, then the wording under the definition of
> > "bandwidth_gran" could be aligned with this.
> 
> I think putting together a couple of your proposals and statements while making the
> text more accurate may work:
> 
> 	 "bandwidth_gran":
> 		The approximate granularity in which the memory bandwidth
>  		percentage is allocated. The allocated bandwidth percentage
> 		is rounded up to the next control step available on the
> 		hardware. The available hardware steps are no larger than
> 		this value.
> 
> I assume "available" is needed because, even though the steps are not larger
> than "bandwidth_gran", the steps may not be consistent across the "min_bandwidth"
> to 100% range?

What values are allowed for "bandwidth_gran"? The "Intel® Resource
Director Technology (Intel® RDT) Architecture Specification"

	https://cdrdv2.intel.com/v1/dl/getContent/789566

describes the upcoming region aware memory bandwidth allocation
controls as being a number from "1" to "Q" (enumerated in an ACPI
table). First implementation looks like Q == 255 which means a
granularity of 0.392% The spec has headroom to allow Q == 511.

I don't expect users to need that granularity at the high bandwidth
end of the range, but I do expect them to care for highly throttled
background/batch jobs to make sure they can't affect performance of
the high priority jobs.

I'd hate to have to round all low bandwidth controls to 1% steps.

>  
> >>>> I think that using const to pass data to architecture is great, thanks.
> >>>>
> >>>> Reinette
> >>>
> >>> I try to constify by default when straightforward to do so, since the
> >>> compiler can then find which cases need to change; the reverse
> >>> direction is harder to automate...
> >>
> >> Could you please elaborate what you mean with "reverse direction"?
> > 
> > I just meant that over-consting tends to result in violations of the
> > language that the compiler will detect, but under-consting doesn't:
> > 
> > static void foo(int *nonconstp, const int *constp)
> > {
> > 	*constp = 0; // compiler error
> > 	(*nonconstp); // silently accpeted, though it could have been const
> > }
> > 
> > So, the compiler will tell you places where const needs to be removed
> > (or something else needs to change), but to find places where const
> > could be _added_, you have to hunt them down yourself, or use some
> > other tool that is probably not part of the usual workflow.
> 
> Got it, thanks.
> 
> Reinette
> 

-Tony

