Return-Path: <linux-kernel+bounces-875021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B69AAC18080
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A60F14E2550
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4F2135CE;
	Wed, 29 Oct 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAVU5sdQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B871386C9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704246; cv=fail; b=f4iCDj0Gukl4O3dHl0nwVFOhYpB9zFUssZ9lzRQ9deKpyu0nT0pLS0c4EMr5qlhRV4Rs6x9LjOoCKneDu7g2SewJZUMj1UXTAA3bFnPt7NcR6Y27XdN7uu1Li3003hRZR4wOCRPhFNCpbRk3HbQu3n/e+hDqV5T+RPai/U7XmKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704246; c=relaxed/simple;
	bh=7duRx1rK7FwLiu0gBlLwhXGpweoKni5wwklXLaDCycQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NdtLjWxvL+OOfaEef25n+0ASTwFcLWu8ET0lUE0hI7alhQpNxetzSQLdZOx9OlKQ5NutEfaFqrWuYvcWywCncyb3wAWNMGtSaSHxJ5Vn9DGTmhUIse/PSEZuPIKE6OYIhp0EkrDEY++FCxRx5yc7qqoPP1iZbgy+yyI3eSt+e7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAVU5sdQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761704244; x=1793240244;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7duRx1rK7FwLiu0gBlLwhXGpweoKni5wwklXLaDCycQ=;
  b=QAVU5sdQdGwguB8xLy8mBUpVqkhG5LazQH1Z0CcSj6LPI41bIF6LVoK1
   dlg+tnKlWpTFKQeW8bkVwYIuICWErTgu0d7Aldqkt6EG65LELArBsLyVM
   Rldzf1MUogvdhqN5heNYf7DJ11agyhQ9mrG91uiqXt0SHsrT8LWccvjqI
   T5V83bQwB1BTgDf8J+fnr4iettw+WDmqRJ3g3Q5w7Q+R3rMcXWLG6hl37
   kApmiN8z7LEKE2DBYdmxA1J+XCdVSZXWti242zm4LAXZkl1JZUGy4aie/
   oGpWJEwnJelL+d6QNkDgOZn+tr+F1Fh/wJXz6MKNpNSP1UeNLZmBq9wgB
   g==;
X-CSE-ConnectionGUID: 1BsJEVhnRTStbPnAsZRTyQ==
X-CSE-MsgGUID: PHWZuzlqTgeEfsR71ri0Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67459312"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="67459312"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 19:17:24 -0700
X-CSE-ConnectionGUID: sw/0YIiWSJSuKySq3oPD0Q==
X-CSE-MsgGUID: deIHXRj9QbStnbeeqBvZQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185984618"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 19:17:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 19:17:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 19:17:23 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 19:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xom6pfKwBi8LVWsP9sJUOijRE5GYNP0cQm+wa52/6IPgR9NgrtsflsLHjW60ql8SFpmMjYxewhPB9lF0efNzHUzDIrCwSEV/hTOX/Px8pVUbvdXwvbq0OH8JWPIsPAKfKR7caCAogGApcF/58C6HKB4SpWX3Ip/nee8SZVAEv6cQ92r2+NI0sQM3b+CeE/+hxAlOPbhZ/JjqZtB5jiVdVSvsIOlOb3OyrvRC3ii7Om2ux9YYa9q+J0DErZCbjsQG2Y+Rnvyh8ovsB5EAruLkqO4cqBDBew2QLASh8sP9jCYMJNCEQtSKHELOKCQq5H7fi9aQRnjN+IZdkD0/M/Bnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3APlZpZ32vfXVVOkej27r7IGqzvzVPy/6aAa8FAeThg=;
 b=sszmSrLgs29GdjVHgkbZRErB9ScCIRn8l6+P7BtVPs9mFEeCb/8gVugQ6qUhUFqS2nM6n3U5zb/tNn8LXr3N/DtrshZzxxJzl/ZcVC0cMjtm8QneMPKZsIepeklWzFFfqNa6oU8Qb2IhSS15yDzbvba4rWu4zSJVq6tuCd84qtGJytTbN+jUD/f/BwZZxG3oNrJtAcdxhN72JLNzLLYsbt4COf5IUDxZIDzSljRJh/7gcNZGzG/MfAzuODb4clUaUZ4MXSSXtBPx94166eDpNoVk4bwz5W1LgYEA2fQVMmeqJfTvRF6mN5c7yP3XDj28v6SxuvfqRWF3O0ZWej56NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 02:17:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 02:17:19 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 28 Oct 2025 19:17:18 -0700
To: Sean Christopherson <seanjc@google.com>, Erdem Aktas
	<erdemaktas@google.com>
CC: <dan.j.williams@intel.com>, Vishal Annapurve <vannapurve@google.com>,
	"Dave Hansen" <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Reinette
 Chatre" <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
Message-ID: <6901792e39d13_10e9100ed@dwillia2-mobl4.notmuch>
In-Reply-To: <aQFmOZCdw64z14cJ@google.com>
References: <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
 <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
 <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
 <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
 <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
 <68ffbfb53f8b5_10e210078@dwillia2-mobl4.notmuch>
 <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
 <690026ac52509_10e2100cd@dwillia2-mobl4.notmuch>
 <CAAYXXYyVC0Sm+1PBw=xoYNDV7aa54c_6KTGjMdwVaBAJOd8Hpw@mail.gmail.com>
 <aQFmOZCdw64z14cJ@google.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7826bb-d9b4-4b22-63f9-08de1691498f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVlteStnVDBPRE9sbERFTW55RlEvTHVBWC9xRHBoTGs1M2E3UHRzay9zd2hk?=
 =?utf-8?B?MlorQlBaNnh5RThja3pnakIyWHVSQmpydVR3Qm5qdjN6U3BWSVNJWkZEUjQ5?=
 =?utf-8?B?NSt1QWNiYnlwanFWS2ZaSHpRd0g4RVhCcHpoYmUvZ1pPa2FZVURsUGg2bG9u?=
 =?utf-8?B?bXFieGcwZS9tNkkxMHpjVlJ3c2tlZ1l0bHZJaHFpRmFIWnFZSS96YTZ5MnlY?=
 =?utf-8?B?TkV6RHpDOXVDZVN2MkYvZ2p2V0VmSXp6YmVXVlFmdkdrSkdKWnJ4REw5Sm4r?=
 =?utf-8?B?bDRlQjRBcklYcXArSE5JRTRCUEJWaTRmNUx3Uk5JL1huYWJpblE4bTQ4d2Jh?=
 =?utf-8?B?TEczaUNXV2Y2UUY3dUZ1YkJtU1FBSmxhdlFSNVVjQVJOcXlraU9tRS8xcTJS?=
 =?utf-8?B?OUJwWEV4Yk8raThRWklocGtKSEFVb0o3OUhpNjJqaHhxdjYzeHlUMk1pMUt4?=
 =?utf-8?B?cG5hV0o4QXZIbnFoa1FWSDIwQzNOZ2x5WWtBK2MrbHhkQ3BWR1JaOWNOOE52?=
 =?utf-8?B?L1VheVJPNmJGc2dGWDAxQ0p3R0t6ODVCbHRTSlpnQkJ2cEIzV2RSOC9RVVhE?=
 =?utf-8?B?cmJMOCs3T2owTURzVmNHRzNWOU1vWGVWWDY1Qm50ZUpjWVNmbHB3WU8wSTli?=
 =?utf-8?B?Q1pNRTdDMVRkc1lPUkVzTVRYZzl5RzRyTmh2U0YwZ2NyaUV1ek5xcHVHY2Y4?=
 =?utf-8?B?Qk9UTmZZMGoycVpiU3ZBenNuRmJPUGlCb2tCbm1ZQThobDdhejRJaFI1VFUz?=
 =?utf-8?B?d1FEWkRZOE9GZ2ZHV0puT25xS1FnY1RJbTk5aUJtNGx4eWl1QVAzTGV0VlBP?=
 =?utf-8?B?cDNteFBBWkltSHBDWGFnUUFSNDk4VjV3TGVYSmllOHpNaEhnODJCNE1ZczU3?=
 =?utf-8?B?TW5EdE9GR0RNVWl3SDJMbm9FdVViU1Q1emNRbkZOUVNmUmQyYmRNOUY5YTBi?=
 =?utf-8?B?U0xBMDh3dUpvVzR2OHlRb1dzZXFBNFBtWElWL1YvbnRuL0RVRFlScTFqTUs0?=
 =?utf-8?B?SlRIZU4zM3JyZkxGWEVZbW1JdnAxdFZBSHEzYkIvRGlacklrRlZvcW94TGov?=
 =?utf-8?B?eC9ZUVdrK2o1RDVrR29Oem5HSytCeUlGdk9TdVZRcEF2QTBLQzkwTENSRVZI?=
 =?utf-8?B?WVJHelV0YllUWTFEMWJ1V2huVFN5SStkOHU1SlltcjM0YlNoNjZBbjdRREpt?=
 =?utf-8?B?MmJpMElXWGtNTi9CL2dBZFlTZ0dGbTJua0U1UW1PM3BhN3RpS1NZUVYxc3Nj?=
 =?utf-8?B?VVh6V1VGbHUrWWlwSk9DcHR6eXI2bDZMT0ZtY0NWQTBoWmg1MEJ4UXlPSE42?=
 =?utf-8?B?aUE1QUhJVFk1eUFYaERka25mYUxMMGVEN3o3bUtHazROcm53Q1E1Y3MwRmh3?=
 =?utf-8?B?MndHcFkycWVxVlZXRFB0SlJQOFJZc0tWYWpwb3hrYnJQYzA3TFdNZ1RaaEcz?=
 =?utf-8?B?SllodFNvUGJoMU5yaUlWT3FVS3I1SWN2cGkxM3h5aExUVWdQMkRzRm5XVy9Y?=
 =?utf-8?B?ZFJWb3IveEJrSnVmazBTMWFwK2ZVby9QSGt0dVEvRGIyM1dtTTFxVWQ4OWdj?=
 =?utf-8?B?b2dvaUZ2bUp3QzRaNDJORWRCUzBZODJjS3Nwa3F0UVNuVHhtREpnZlpwVGhm?=
 =?utf-8?B?MldvU0lEa2RUMUxkSFFIT1NCZmM2aXJLQmVvT2QyL1VDMnM4ODk3bGhPT0Ry?=
 =?utf-8?B?NG05OVBrTG9yeVN2SW9rdTFOY1YzYVQ4S0R1UU5DN3dXTzBsUzQxeE8vMkM4?=
 =?utf-8?B?ZXQ0MXVpL2Fua01DUVdWOHRDM3hXa2pQSUNEd09NYjRWd2Y0MU9hbzMyS0dF?=
 =?utf-8?B?b0hzWHFwNyswb0NDQzJhaWJEb3JtbWNqMXZiOUtWUW1wNTF4eDF3dXVRZC9q?=
 =?utf-8?B?UlVRRDdRUEowSithd1hYek14Vm4xYTRHZGlpNkdiYXFuMHU1WSs1K0hGMzhl?=
 =?utf-8?Q?L1HTQFBtdDDyIaakMIkeS/+8VfWAFz06?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZ5TncxZ0tQTzkzODhDWEtud2pIS0pIejZ5VjM0YmUyY1FKUFk0Z0hZOWxi?=
 =?utf-8?B?cmc5UnBHbEJWcnBTc1c1c2liMll1Zk4veHRUbnByT3d0eU1TbnhrT0svRXg1?=
 =?utf-8?B?VjU0dCtGbG5FS09EeStCVXNSRlJDVXJtazNDdk8vcnpyVERoZHB1T2kyWklF?=
 =?utf-8?B?c1NaSnlWUC9OeUkyVWRPK2RDYk1zOEZRaDZTQjVwbk5TTFdlVktOZHpXN01K?=
 =?utf-8?B?dW1kSkd0V1pLeEkyVlNwcUJvV01JSGdseGVUM21McEhNTFdJM0pIS2NXWVJ5?=
 =?utf-8?B?enp1R25Zc1FmaVRJbXloMHRqUHVRNml1eEJnS0wwekFTUmhPdk96RmthUHdi?=
 =?utf-8?B?VTA0bEZneHVlY09MMEI1NlJXQVhvdlladHh3VnBCdnNUc1VRNzRFajZ2Mmpj?=
 =?utf-8?B?NXZONnBMRndKd3JhakVCZEZRemxwdXFjSVNJR3JxeUhwNnk1VXR1Y0NPbmFM?=
 =?utf-8?B?dEV3bDlvYW1LcmV4azBkVFBjSUpoUW1ZTDBqSG1kZHEwOVdwWEpQRVk5NmtK?=
 =?utf-8?B?ZGR6T3BQSmpsOWtaUldtK2k3U3piMWdTYmFncnFxcTl1UXdiYlZKQmN1WTJH?=
 =?utf-8?B?WHowYzI1UVVyWlF2UE9MRGJ0YXFiK0ZFWUVPL3BSUjdmOC9BRHRoNmExNUx5?=
 =?utf-8?B?U21hTHA1bmZUSUN6SnVqczJUYk9NVVliQUU0N09YektXWVRDVFQ1clJMU1ZP?=
 =?utf-8?B?RDNQZ045dW5LcWptZ1BuU2xXTzIyTTVzbXdkZElYd0FRQ1hzMWprS3JsOTZI?=
 =?utf-8?B?U2lLYzVqU1dleDJhNHNxb1A1NUMzazBBUWpqWWJYTnc3dFdGQ0M3aTlSeEdN?=
 =?utf-8?B?ZUJaTENNc0lOeWFiVXprcDAveXNWekh1S0JZb3FFbEU4LzZFSGMrVUcxWkVT?=
 =?utf-8?B?K21XMzNPbHBHYWl5cXZqQ3dCMWp3VGo4RVhWRU9GT2dFWTkvS0tzd2N4VjAr?=
 =?utf-8?B?ZHlKdWtvSjdrU2hzL2JUOGpFOWpCMzM1UW1UZzI1dWluVU41R0JtS3MzaDIv?=
 =?utf-8?B?Q3dsTkNjeENwWnN1ZHVKWVhVaVZWMzMrdVJOOUVLcDRla3NTN2VtTzVCYmtJ?=
 =?utf-8?B?SUhWaW94WU5XYlEvNkM2dDd4c2FSR3FSNUpLamJEQmVOck0zTUFGQUtaYnZI?=
 =?utf-8?B?VVpPaHFSQmlqN21ZcUlVbmE0amFZWmlvc1Y4Zjd0VHJZN25zNENQM1FFY3Fq?=
 =?utf-8?B?NVpyeHM1bWNWdS9rQ3U0OW9UT1VKZEdkREhFRDgrNG5uVk9ZMHl0Tno0eXlJ?=
 =?utf-8?B?WHBoTGs3SzV5WXdSU2ZwcUcreG5aS2R1MisrbEFoeWxvdzhkcU5zS1BvNGtM?=
 =?utf-8?B?Qmx2emdlUURaZlU2dDV6cU9iVFg4WThDcGZXeU9DWkZFODh1bmJCTlNER0Zu?=
 =?utf-8?B?WGZCUi9tekx0eGdlOExSSWZBOUxtR0wrUTZ3RU1MdGMwbVF4UHByVVBrSlpk?=
 =?utf-8?B?UHBmWTZUNzh2dm8yZFBoL2dXYlNLREwxM09VcTlReFRhc1dLaFB0cUp3Z2pR?=
 =?utf-8?B?d21nUUlCT0pab1RrT2RkVW92TWlYeGhFQmZpVjY2N212UDBTbEFoQ3FMVEkx?=
 =?utf-8?B?Z3RJdUJ2MmhMNTlIbENUb3JZSjdsTjdiRkZmWDY3Qk9YeHkyOWhEb0hWK3pt?=
 =?utf-8?B?emp1NzVKMUthMi9GWnFoSk1iMzRKWEczdUllVTBHYm42d3FDTnMxVDJ1UEZJ?=
 =?utf-8?B?LzAwN1hUVTZ2NVY5RGlHaUdRT3dkbEpzZGVuSjdJVktiY2UvNm9lOFBoTUFP?=
 =?utf-8?B?NWtUY0RiUnpaK3BYbmRuakg0b09TWkgraXhLc20vdG9sek10TmRXeEpNdFBK?=
 =?utf-8?B?bXFoRjRlOXFxY3g5RThEWjgrZFMrT1ROZmJWVFdtL3FoYWMxRTcvYWxHeDFL?=
 =?utf-8?B?UXlsVzVpUEF0a1F0N1dpT2wzTHZvMFBKQkd2eS9vYlVia09xdWxMRjVMelBN?=
 =?utf-8?B?UDBmTVpValM1VXU5aGV6ZnlydDZjOHEzcDBJMVlMd293ektGL3YwSlVXMjFY?=
 =?utf-8?B?anF0enVqK2hxM2RQYVVYQ0VhWG1nQ0FZaStkbEE3aUJ2RmhGbHVDc2t6cHlz?=
 =?utf-8?B?bmU0VWdHams4MWpiYnI3NlE4U1h2RUtIM2p1aXhMVndxTi9VVE1vMGY2M2xI?=
 =?utf-8?B?cWtOUjV0R3FSUjE0ZEtTQjFZcGpKYkpia21ERkdQd0Z1R0ZvazZoNlcxMm9P?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7826bb-d9b4-4b22-63f9-08de1691498f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:17:19.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+05a92CLXRS8yqjPEt7PZ208L1kQaWV6sXV5XyQoqSQ8Td3ffqIyZ3M6Q1lMNixysEP5VOyqKSLlePss1QIKmdUd37/pmh29Xf9VqGFhIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
X-OriginatorOrg: intel.com

Sean Christopherson wrote:
[..]
> > IMO, It is something userspace should decide, kernel's job is to
> > provide the necessary interface about it.
> 
> I disagree, I don't think userspace should even get the option.  IMO, not setting
> AVOID_COMPAT_SENSITIVE is all kinds of crazy.

Do see Table 4.4: "Comparison of Update Incompatibility Detection and/or
Avoidance Methods" from the latest base architecture specification [1].
It lists out the pros and cons of not setting AVOID_COMPAT_SENSITIVE.
This thread has only argued the merits of "None" and "Avoid updates
during update- sensitive times". It has not discussed "Detect
incompatibility after update", but let us not do that. You can just
assume the Module has multiple solutions to this awkward problem
precisely because different VMMs came to different conclusions.

I want this thread to end so I am not going to argue past what Dave and
Sean want to do here.

[1]: https://www.intel.com/content/www/us/en/content-details/865787/intel-tdx-module-base-architecture-specification.html

