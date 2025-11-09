Return-Path: <linux-kernel+bounces-891846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AAC43A51
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B105E4E24C4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D81D263F5F;
	Sun,  9 Nov 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzNGhRfQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5013777E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762678063; cv=fail; b=BYgliYcTCympp7BlHgMB9nDJvDZ7jjtAwYzC+8MjU9xNyExZfVQ6RAYZkR7FSgkhdTQxn+CNvynGO+rz5uFJxzxtnwAScspIQsO3143HtXnxHGsRgiOcxb9mfeiu4xf4UhNhrOIDpK83TbF0fpE2bOyHk4bK9tDxdedu64Z8rD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762678063; c=relaxed/simple;
	bh=NZtyIEH7VkZw8FEi+nQb23ZigFb+tilqkkbfT3GHcDk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQb0lSm/ntGHrYDZjVgtz2pWhb8N9CckVdzPeLjW+t8RvGUPDy1AOVN0B4t/rGah0gNGyD5ZX8dHUUEXhU/nMoLrIxRturmq4LraSuPZRbxBjpTJQNipDjpT1e9TOPPNHsdSy76arY8HIMDGbTzRlJ2j+Va2bEpazGuwRYQhpso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzNGhRfQ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762678061; x=1794214061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NZtyIEH7VkZw8FEi+nQb23ZigFb+tilqkkbfT3GHcDk=;
  b=mzNGhRfQ+XxrP6RlKI1kLX3oBU/+cFWTRSrfrYSKBLRUTH5OUOukjzlh
   qLN+DnIUedP1972oR6lzaBKtEHtHUo+Gt278j3NCbwCHn9K4oLOxVkOVN
   QiHnC4ENdx2KvXNaCrhFdVCpDEIujCwvyMaLjEpgJtIfqgb8xYJDN48Qs
   MoZT4dpK/q35HVUeY28rOTbuwBEvGKrKldHGnim+gsk5uoDW3x5u3IbJy
   eZrpYgId5x673f6vN1ZFEZRGqu5WovNvfn2/XM75avZ/DlzwzKEJxTm3q
   TibswDmPYc5FdXWrg9ZvWN0ei1eFBxJiilGgzTmeprcqsaNW3vtI2NX0Y
   Q==;
X-CSE-ConnectionGUID: ihL79XUpQNi3b5FbKDGTqg==
X-CSE-MsgGUID: kEekqubzTziGkzq+mbAa0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64798196"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64798196"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 00:47:41 -0800
X-CSE-ConnectionGUID: POt551ZeRm2Bo60knBlvfw==
X-CSE-MsgGUID: hjpzS2QjSUqSJzjblUbJmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="211836805"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 00:47:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 00:47:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 9 Nov 2025 00:47:40 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 9 Nov 2025 00:47:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5xwiKEzo9e+hrTeEVMuR/eFWFA69Nn3/VFtKwJBOOmX1o0deYmo+b5dg7Xt02wEXd5C6PC//QDv5Rc6smJcLRcpnlct/St5xPLYRQiYXU472EcVKeJugjULjlDXZpAjsHnGv1ssRv8lurGxdGvdQq95baOks7xQ8MpvyFNzEfXSQkTZVKq/A/0Fez1U32tVAoL6FuRGGhYZtvXKFYgmTrVmkNJHnfR85JPWWF8lTI4C12eL3fftvn19pjrH90pLCmxhvMZVp/pMTGN4wOC2LA+Imly5dozUofmJArCiJBBnD7yLYsJl/8vkVk4CUta9NACVcpP+B0qGwqexMIWaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD0juJMtAZX4vo01oTWHZ1ULjdUQPGy2oQldlN2Vk4A=;
 b=tjUlWAPwEGgy3xT2pjvXVuzMuAQ3azJGETFcvE6e7VUbPiVOYVM+BRMklKArTuqWZrHdnbmZ/6R+RHTrLhT6FQf1senWDbmNUXw+u5Kboo5EX8KFRJTUPIBb+y3DX24TufzYDxK5rEkNfXg6cMv0HY29Bbp1VfRIS0m/loxPAFoG6IIHos7BpuZTuJ40qOGmnboXnOQcIe4T1k3aIVYX8YopAdEyAQThNAmuewPFChvde4im9cLD/NXL6o61UsD4E1Qc6DUCoklYhPzz4Av/y8WPjuVZFQ7yB+elVJRBbn/gYJvI4E3EvhdYMWdUB2F8pvvo6kckvKbT9lJHv//PZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 9 Nov
 2025 08:47:37 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Sun, 9 Nov 2025
 08:47:37 +0000
Date: Sun, 9 Nov 2025 16:47:29 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Filipe Manana <fdmanana@suse.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>
Subject: Re: fs/btrfs/tree-log.c:2649:32: warning: 'inode_item' may be used
 uninitialized
Message-ID: <aRBVIcoLcBmQzwXU@rli9-mobl>
References: <202511090321.X08Rh6eK-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202511090321.X08Rh6eK-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|SA1PR11MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 3786acb2-7ac1-4943-8339-08de1f6ca278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hEXDpJz+7pmsdzgrOEIejLclXcXJrF8z+brbQPEAtP5OcTmvHHbE1bG+JGU1?=
 =?us-ascii?Q?BFK+Ov+cbcRenO1fuYQtlpSfFGiU9ozTrRzUJxkqphiXUGQVDJP34fNukgai?=
 =?us-ascii?Q?vbr58jVne5al8yJF+oG7cIyBvS8Zjm/uiC9Sj0dJEM4wKHQAl3paxjAQwnHl?=
 =?us-ascii?Q?nJtGVH6sLhI733WEcxicgkXZJEJf1jvYFp/SQKMTMk8T7kM0j8FoRcl4vC6V?=
 =?us-ascii?Q?yWjknm1fvSBiyB0lFUBfo9Rrgj5e4lH8I2AWPt4fu+6t0YDBjw1EcKljMVzA?=
 =?us-ascii?Q?v3rzo1brNeTh+LJ6S5qMt4kibAsw9UCUteyuWPMh4qQPXZKAh5IhlNHJ10cB?=
 =?us-ascii?Q?/1XlxNU0sXC71rHu7RA8vBCUPpxzudOM7EQENPNIsK3g3GX3pU/5HaLAEQ1G?=
 =?us-ascii?Q?ythpgOEMdFu2QGzBrHqkG2rxI751olomJC/I2horrF9NuJkN9u99H7HPJzG8?=
 =?us-ascii?Q?9uG2jwfWADZonG7200GiPnEBrslhwhRauiLQP2bwMRtF8CMdp5DsBhE74r5f?=
 =?us-ascii?Q?q6pUbS3R15bMAK7O0219VIr0/oDyw424sdiw/JM8UbKNgutunaAkn48bI2gJ?=
 =?us-ascii?Q?4uwiB1EZtQe8WmAXaSWLeHjHt+amUpGgx0dPEsi15Jzb15kgWaUU+Cnbt5pk?=
 =?us-ascii?Q?OsCz8G4imYX6CnbvQZPVN+PVrJMfPv+hWcZgnkl5ykh5R89WPb3sRdW61Xvf?=
 =?us-ascii?Q?Xllrgh2vzD42a4sh3UJSfKkZVyCFjH2HnaXkzyHWx+tkq5Tm+oHDpC7cFPR+?=
 =?us-ascii?Q?28d/eQH1xZBncCL2xmBf02coa7WPddJf9el39MAfFB4Bbc1lGjad5D6wKtTq?=
 =?us-ascii?Q?wYcDLkASdVM6Qf6zE4avobhZYrN7YOMu76jL1yBkS2jYgFqG8GjTzYUrFiFr?=
 =?us-ascii?Q?gJi9i1sCYD5roxO0Q9/XniqkTOO5ZhYZpV6ULnN6c55f4D19G2O95yta2c6L?=
 =?us-ascii?Q?dPVK/GJpiXfg1FHrx0PffNsC1DhSucBRjyd1hlHUAszGQXFdUp2Gv70Q+F+z?=
 =?us-ascii?Q?cqRBlr8FNS1yEZxuKaC6BsdAJHl+wp3qYbj/LaphPQi0oAr6zuFzORUDxtF0?=
 =?us-ascii?Q?LThGxOqMdiUhACqjv+xmYEN6iKaKCpmMqzdmXNkWxw+9a5ziMHntjQ8PXC+N?=
 =?us-ascii?Q?C6hVPy+rPWCtXbB6mrShudD5RKVTtPxVArd+IySdnzt7vI+3udymbSUOX9Cx?=
 =?us-ascii?Q?XWVSELtNVPPGK883YzA5pUoOQ5YqsF1UcsXuTnbW/D96934ptwfNJqqUxAt5?=
 =?us-ascii?Q?qaM62AuPRgyQ+4q57UuMLNfnOMo7s8ldu6h5Q0X56yPb0TAxVCKYFSMjKp89?=
 =?us-ascii?Q?ax/sd36QnKIiz3eZsgcYkmNWodHK74lfLU7yOLDrE73G4Bzziv+AvbJBeKWi?=
 =?us-ascii?Q?SVXkFIZvybFS6CxjVcgNa1Jj9PxhnFJZEKUkccKmcXUGiDcZTzT2ILJ/V2ow?=
 =?us-ascii?Q?5HA8S1elYd6M7vWcxvoPk5gdyxlpG15qjwlqaOebzjdHXpxHohSrnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9R+lCX7D9zkDcv07AL65dyCjeSor4Ok0ZF8wcqrlyWqZ7+rmOSgbOzHb3Phl?=
 =?us-ascii?Q?ZhaqJMr/fOINCVtSewbZ9tTOpKd3Dce9FmacWgear68OC2K9RpGbDpEE+rfQ?=
 =?us-ascii?Q?dCq4z523ezfmXIKohXwMKVzwnU4azvkeFhwYPzhZOwf0Tmz/pAL7rUnqPBR9?=
 =?us-ascii?Q?t6sl/FFbu5qDD044CEJBLSb/6HEVESBecFi4kOQxLtkj3hCfhEAdartMr39X?=
 =?us-ascii?Q?CPDrJR89vO5Hra4KXS5Ywr7+IDAHiKkwHF2UNMI9wjDLbwTykW2gv18VHWF2?=
 =?us-ascii?Q?pUd6k12uXPpNFauQOduGwuJd0usuNpolSLFRSwQG8E3ocXI12Xa1luzyzflj?=
 =?us-ascii?Q?l/G7FDpSExvxT+rrln+B8oCtPHRuUyTdCfAPAGeDTkkEstudWV0VRuK/DCYY?=
 =?us-ascii?Q?8C4g7KGpJnnlR6o3zsy5GQF7XibRi9n+uhbI1buNesZ2Kf06mf2Yq5bIuBLz?=
 =?us-ascii?Q?P6z0KnD3ekvzkXEcBF+4PNMlAqDDtgFRzSP7pcST71517LIhcRN0mBAY6I/l?=
 =?us-ascii?Q?sFrm8S8VMD3Jvi1Sx3npI3ekd1pAsuizb5YmOtiFOus3PcMOY8fxwQ86F2Am?=
 =?us-ascii?Q?NHVGp0wgm/NRgQ9P3QWslZkBjfVWNEnlc/WQgrKTuMbQE8buFS1NeNqCDRYo?=
 =?us-ascii?Q?bSmnYG51+lo1eqtu4xlKYFzrWuHe3d8dLZd595QDv2XwwUvpE9rPb0SyXnCY?=
 =?us-ascii?Q?g0wA1yceEu+b7yevNfHLl/yficBo9tTeWFAhSSRn/stkaPEOIBNDQpRQyCIK?=
 =?us-ascii?Q?owj3+xtw1/SsF3rQgY/+GWdB/9M2X/oaiNBQEg6lzulxvGXZlDHpWC997z8r?=
 =?us-ascii?Q?bBAT8coKalU5ph+AKsr4Sdt91X7LnP//rEzntEKgm8CAIkw+hObcet8xW3hQ?=
 =?us-ascii?Q?fjzCs0jdiQZrKeOvv1kvX0hPi8znhLBcPwDvr8ASishQ4ZMdiv6zOgaNTxL1?=
 =?us-ascii?Q?dT+YvF2iZW90yTROJptegnL5X6mbkZr5aJfl4FmTxYoJfjtZule6siyLQf3U?=
 =?us-ascii?Q?RotHsf50Y57SMA+tsOUgR/avLwiZu30p64aA6gfSFhbZPSr39pAsY7lMhB6c?=
 =?us-ascii?Q?51a9Fu6rdLLJr4HdefLhH+RwkO7v4wRaMzW3DZCWrJ8cc8/jsjTi6K2zLZer?=
 =?us-ascii?Q?fZn7coGtHvOPjc2zd/nPvSdRyLPgopbo7DCHMUfTwwNB78XzxXz75rRsg4f5?=
 =?us-ascii?Q?0a5XDq0VRJNrXHK9b6u/rNQfTI35CWhQY09vtwPyXl6L9v60s5zyHURgySin?=
 =?us-ascii?Q?uYTW842CS/QGu8aFVYudxMGWX5jbAgeSdaaD/EuJ1KBQ7PcxD/ZlxIuC3i/i?=
 =?us-ascii?Q?wZXKWqnOZt3brWmiD8wqeZdbaIirWoXWY9nxeTMVuUR/5XMp3Bp1eOddFR4E?=
 =?us-ascii?Q?TaMzzflWgqY2tVm+7SQ/h8JC79vXdlp5wBuTVRoStICS/DGXBjJvIhBc+Csd?=
 =?us-ascii?Q?bJyhp11/FHHlE5nrq1LxyeCuJo1Do2tIWxl66g+JSH7nm8nhdllLLK158Psu?=
 =?us-ascii?Q?EJYgApPPy9B95itjEbxz+GCWYz4iRL8oZm6a2tzB9QgH4NR45rnjKk1sTccO?=
 =?us-ascii?Q?cM9hqtq7ArP5sYnNbsRXYnH8YxrFghgK81ntPk4O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3786acb2-7ac1-4943-8339-08de1f6ca278
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 08:47:37.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BX/ltuTB/llirLKjMuLbBPLNd4y4KeeYOBbOOBQvBZdURbTAskuiRecPJz/IfSbKEds91SscZrXmjZKxZqX2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

On Sun, Nov 09, 2025 at 03:48:21AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01
> commit: 2ac70946621ff3d90eb84d2e3b74563f4154f24c btrfs: add current log leaf, key and slot to struct walk_control
> date:   7 weeks ago
> config: um-randconfig-001-20251109 (https://download.01.org/0day-ci/archive/20251109/202511090321.X08Rh6eK-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511090321.X08Rh6eK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511090321.X08Rh6eK-lkp@intel.com/
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):

Kindly ignore this report, it should be a false positive, sorry about this.

> 
>    fs/btrfs/tree-log.c: In function 'replay_one_buffer':
> >> fs/btrfs/tree-log.c:2649:32: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
>     2649 |                         mode = btrfs_inode_mode(eb, inode_item);
>          |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/btrfs/tree-log.c:2607:42: note: 'inode_item' was declared here
>     2607 |                 struct btrfs_inode_item *inode_item;
>          |                                          ^~~~~~~~~~
> 
> 
> vim +/inode_item +2649 fs/btrfs/tree-log.c
> 
> e02119d5a7b439 Chris Mason   2008-09-05  2563  
> e02119d5a7b439 Chris Mason   2008-09-05  2564  /*
> e02119d5a7b439 Chris Mason   2008-09-05  2565   * the process_func used to replay items from the log tree.  This
> e02119d5a7b439 Chris Mason   2008-09-05  2566   * gets called in two different stages.  The first stage just looks
> e02119d5a7b439 Chris Mason   2008-09-05  2567   * for inodes and makes sure they are all copied into the subvolume.
> e02119d5a7b439 Chris Mason   2008-09-05  2568   *
> e02119d5a7b439 Chris Mason   2008-09-05  2569   * The second stage copies all the other item types from the log into
> e02119d5a7b439 Chris Mason   2008-09-05  2570   * the subvolume.  The two stage approach is slower, but gets rid of
> e02119d5a7b439 Chris Mason   2008-09-05  2571   * lots of complexity around inodes referencing other inodes that exist
> e02119d5a7b439 Chris Mason   2008-09-05  2572   * only in the log (references come from either directory items or inode
> e02119d5a7b439 Chris Mason   2008-09-05  2573   * back refs).
> e02119d5a7b439 Chris Mason   2008-09-05  2574   */
> efa44fc4fde3eb Filipe Manana 2025-08-26  2575  static int replay_one_buffer(struct extent_buffer *eb,
> 581c1760415c48 Qu Wenruo     2018-03-29  2576  			     struct walk_control *wc, u64 gen, int level)
> e02119d5a7b439 Chris Mason   2008-09-05  2577  {
> e02119d5a7b439 Chris Mason   2008-09-05  2578  	int nritems;
> 789d6a3a876e32 Qu Wenruo     2022-09-14  2579  	struct btrfs_tree_parent_check check = {
> 789d6a3a876e32 Qu Wenruo     2022-09-14  2580  		.transid = gen,
> 789d6a3a876e32 Qu Wenruo     2022-09-14  2581  		.level = level
> 789d6a3a876e32 Qu Wenruo     2022-09-14  2582  	};
> e02119d5a7b439 Chris Mason   2008-09-05  2583  	struct btrfs_path *path;
> 2c123db1f0e1fb Filipe Manana 2025-08-26  2584  	struct btrfs_root *root = wc->root;
> 425652cf102838 Filipe Manana 2025-07-16  2585  	struct btrfs_trans_handle *trans = wc->trans;
> e02119d5a7b439 Chris Mason   2008-09-05  2586  	int ret;
> e02119d5a7b439 Chris Mason   2008-09-05  2587  
> 6cb7f0b8c9b0d6 Filipe Manana 2025-08-28  2588  	if (level != 0)
> 6cb7f0b8c9b0d6 Filipe Manana 2025-08-28  2589  		return 0;
> 6cb7f0b8c9b0d6 Filipe Manana 2025-08-28  2590  
> 789d6a3a876e32 Qu Wenruo     2022-09-14  2591  	ret = btrfs_read_extent_buffer(eb, &check);
> 912c257c88cd8c Filipe Manana 2025-07-18  2592  	if (ret) {
> 912c257c88cd8c Filipe Manana 2025-07-18  2593  		btrfs_abort_transaction(trans, ret);
> 018642a1f19788 Tsutomu Itoh  2012-05-29  2594  		return ret;
> 912c257c88cd8c Filipe Manana 2025-07-18  2595  	}
> e02119d5a7b439 Chris Mason   2008-09-05  2596  
> e02119d5a7b439 Chris Mason   2008-09-05  2597  	path = btrfs_alloc_path();
> 912c257c88cd8c Filipe Manana 2025-07-18  2598  	if (!path) {
> 912c257c88cd8c Filipe Manana 2025-07-18  2599  		btrfs_abort_transaction(trans, -ENOMEM);
> 1e5063d093b5f0 Mark Fasheh   2011-07-12  2600  		return -ENOMEM;
> 912c257c88cd8c Filipe Manana 2025-07-18  2601  	}
> e02119d5a7b439 Chris Mason   2008-09-05  2602  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2603  	wc->log_leaf = eb;
> 2ac70946621ff3 Filipe Manana 2025-09-01  2604  
> e02119d5a7b439 Chris Mason   2008-09-05  2605  	nritems = btrfs_header_nritems(eb);
> 2ac70946621ff3 Filipe Manana 2025-09-01  2606  	for (wc->log_slot = 0; wc->log_slot < nritems; wc->log_slot++) {
> e02119d5a7b439 Chris Mason   2008-09-05  2607  		struct btrfs_inode_item *inode_item;
> e02119d5a7b439 Chris Mason   2008-09-05  2608  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2609  		btrfs_item_key_to_cpu(eb, &wc->log_key, wc->log_slot);
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2610  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2611  		if (wc->log_key.type == BTRFS_INODE_ITEM_KEY) {
> 2ac70946621ff3 Filipe Manana 2025-09-01  2612  			inode_item = btrfs_item_ptr(eb, wc->log_slot,
> 2ac70946621ff3 Filipe Manana 2025-09-01  2613  						    struct btrfs_inode_item);
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2614  			/*
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2615  			 * An inode with no links is either:
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2616  			 *
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2617  			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2618  			 *    got linked before the fsync, skip it, as replaying
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2619  			 *    it is pointless since it would be deleted later.
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2620  			 *    We skip logging tmpfiles, but it's always possible
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2621  			 *    we are replaying a log created with a kernel that
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2622  			 *    used to log tmpfiles;
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2623  			 *
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2624  			 * 2) A non-tmpfile which got its last link deleted
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2625  			 *    while holding an open fd on it and later got
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2626  			 *    fsynced through that fd. We always log the
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2627  			 *    parent inodes when inode->last_unlink_trans is
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2628  			 *    set to the current transaction, so ignore all the
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2629  			 *    inode items for this inode. We will delete the
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2630  			 *    inode when processing the parent directory with
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2631  			 *    replay_dir_deletes().
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2632  			 */
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2633  			if (btrfs_inode_nlink(eb, inode_item) == 0) {
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2634  				wc->ignore_cur_inode = true;
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2635  				continue;
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2636  			} else {
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2637  				wc->ignore_cur_inode = false;
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2638  			}
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2639  		}
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2640  
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2641  		/* Inode keys are done during the first stage. */
> 2ac70946621ff3 Filipe Manana 2025-09-01  2642  		if (wc->log_key.type == BTRFS_INODE_ITEM_KEY &&
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2643  		    wc->stage == LOG_WALK_REPLAY_INODES) {
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2644  			u32 mode;
> 0a32e4f0025a74 Filipe Manana 2025-07-30  2645  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2646  			ret = replay_xattr_deletes(wc, path);
> 4f764e5153616f Filipe Manana 2015-02-23  2647  			if (ret)
> 4f764e5153616f Filipe Manana 2015-02-23  2648  				break;
> e02119d5a7b439 Chris Mason   2008-09-05 @2649  			mode = btrfs_inode_mode(eb, inode_item);
> e02119d5a7b439 Chris Mason   2008-09-05  2650  			if (S_ISDIR(mode)) {
> 2ac70946621ff3 Filipe Manana 2025-09-01  2651  				ret = replay_dir_deletes(wc, path, wc->log_key.objectid, false);
> b50c6e250ef913 Josef Bacik   2013-04-25  2652  				if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2653  					break;
> e02119d5a7b439 Chris Mason   2008-09-05  2654  			}
> 2ac70946621ff3 Filipe Manana 2025-09-01  2655  			ret = overwrite_item(wc, path);
> b50c6e250ef913 Josef Bacik   2013-04-25  2656  			if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2657  				break;
> e02119d5a7b439 Chris Mason   2008-09-05  2658  
> 471d557afed155 Filipe Manana 2018-04-05  2659  			/*
> 471d557afed155 Filipe Manana 2018-04-05  2660  			 * Before replaying extents, truncate the inode to its
> 471d557afed155 Filipe Manana 2018-04-05  2661  			 * size. We need to do it now and not after log replay
> 471d557afed155 Filipe Manana 2018-04-05  2662  			 * because before an fsync we can have prealloc extents
> 471d557afed155 Filipe Manana 2018-04-05  2663  			 * added beyond the inode's i_size. If we did it after,
> 471d557afed155 Filipe Manana 2018-04-05  2664  			 * through orphan cleanup for example, we would drop
> 471d557afed155 Filipe Manana 2018-04-05  2665  			 * those prealloc extents just after replaying them.
> e02119d5a7b439 Chris Mason   2008-09-05  2666  			 */
> e02119d5a7b439 Chris Mason   2008-09-05  2667  			if (S_ISREG(mode)) {
> 5893dfb98f2578 Filipe Manana 2020-11-04  2668  				struct btrfs_drop_extents_args drop_args = { 0 };
> b4c50cbb01a1b6 Filipe Manana 2025-03-06  2669  				struct btrfs_inode *inode;
> 471d557afed155 Filipe Manana 2018-04-05  2670  				u64 from;
> 471d557afed155 Filipe Manana 2018-04-05  2671  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2672  				inode = btrfs_iget_logging(wc->log_key.objectid, root);
> 5f61b961599acb Filipe Manana 2025-06-18  2673  				if (IS_ERR(inode)) {
> 5f61b961599acb Filipe Manana 2025-06-18  2674  					ret = PTR_ERR(inode);
> 912c257c88cd8c Filipe Manana 2025-07-18  2675  					btrfs_abort_transaction(trans, ret);
> 471d557afed155 Filipe Manana 2018-04-05  2676  					break;
> 471d557afed155 Filipe Manana 2018-04-05  2677  				}
> b4c50cbb01a1b6 Filipe Manana 2025-03-06  2678  				from = ALIGN(i_size_read(&inode->vfs_inode),
> 471d557afed155 Filipe Manana 2018-04-05  2679  					     root->fs_info->sectorsize);
> 5893dfb98f2578 Filipe Manana 2020-11-04  2680  				drop_args.start = from;
> 5893dfb98f2578 Filipe Manana 2020-11-04  2681  				drop_args.end = (u64)-1;
> 5893dfb98f2578 Filipe Manana 2020-11-04  2682  				drop_args.drop_cache = true;
> 425652cf102838 Filipe Manana 2025-07-16  2683  				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
> 912c257c88cd8c Filipe Manana 2025-07-18  2684  				if (ret) {
> 912c257c88cd8c Filipe Manana 2025-07-18  2685  					btrfs_abort_transaction(trans, ret);
> 912c257c88cd8c Filipe Manana 2025-07-18  2686  				} else {
> b4c50cbb01a1b6 Filipe Manana 2025-03-06  2687  					inode_sub_bytes(&inode->vfs_inode,
> 2766ff61762c3f Filipe Manana 2020-11-04  2688  							drop_args.bytes_found);
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2689  					/* Update the inode's nbytes. */
> 425652cf102838 Filipe Manana 2025-07-16  2690  					ret = btrfs_update_inode(trans, inode);
> 912c257c88cd8c Filipe Manana 2025-07-18  2691  					if (ret)
> 912c257c88cd8c Filipe Manana 2025-07-18  2692  						btrfs_abort_transaction(trans, ret);
> 471d557afed155 Filipe Manana 2018-04-05  2693  				}
> b4c50cbb01a1b6 Filipe Manana 2025-03-06  2694  				iput(&inode->vfs_inode);
> b50c6e250ef913 Josef Bacik   2013-04-25  2695  				if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2696  					break;
> e02119d5a7b439 Chris Mason   2008-09-05  2697  			}
> c71bf099abddf3 Yan, Zheng    2009-11-12  2698  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2699  			ret = link_to_fixup_dir(wc, path, wc->log_key.objectid);
> b50c6e250ef913 Josef Bacik   2013-04-25  2700  			if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2701  				break;
> e02119d5a7b439 Chris Mason   2008-09-05  2702  		}
> dd8e721773fdab Josef Bacik   2013-09-11  2703  
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2704  		if (wc->ignore_cur_inode)
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2705  			continue;
> f2d72f42d5fa3b Filipe Manana 2018-10-08  2706  
> 2ac70946621ff3 Filipe Manana 2025-09-01  2707  		if (wc->log_key.type == BTRFS_DIR_INDEX_KEY &&
> dd8e721773fdab Josef Bacik   2013-09-11  2708  		    wc->stage == LOG_WALK_REPLAY_DIR_INDEX) {
> 2ac70946621ff3 Filipe Manana 2025-09-01  2709  			ret = replay_one_dir_item(wc, path);
> dd8e721773fdab Josef Bacik   2013-09-11  2710  			if (ret)
> dd8e721773fdab Josef Bacik   2013-09-11  2711  				break;
> dd8e721773fdab Josef Bacik   2013-09-11  2712  		}
> dd8e721773fdab Josef Bacik   2013-09-11  2713  
> e02119d5a7b439 Chris Mason   2008-09-05  2714  		if (wc->stage < LOG_WALK_REPLAY_ALL)
> e02119d5a7b439 Chris Mason   2008-09-05  2715  			continue;
> e02119d5a7b439 Chris Mason   2008-09-05  2716  
> e02119d5a7b439 Chris Mason   2008-09-05  2717  		/* these keys are simply copied */
> 2ac70946621ff3 Filipe Manana 2025-09-01  2718  		if (wc->log_key.type == BTRFS_XATTR_ITEM_KEY) {
> 2ac70946621ff3 Filipe Manana 2025-09-01  2719  			ret = overwrite_item(wc, path);
> b50c6e250ef913 Josef Bacik   2013-04-25  2720  			if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2721  				break;
> 2ac70946621ff3 Filipe Manana 2025-09-01  2722  		} else if (wc->log_key.type == BTRFS_INODE_REF_KEY ||
> 2ac70946621ff3 Filipe Manana 2025-09-01  2723  			   wc->log_key.type == BTRFS_INODE_EXTREF_KEY) {
> 2ac70946621ff3 Filipe Manana 2025-09-01  2724  			ret = add_inode_ref(wc, path);
> 7ebf381a69421a Filipe Manana 2025-07-11  2725  			if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2726  				break;
> 2ac70946621ff3 Filipe Manana 2025-09-01  2727  		} else if (wc->log_key.type == BTRFS_EXTENT_DATA_KEY) {
> 2ac70946621ff3 Filipe Manana 2025-09-01  2728  			ret = replay_one_extent(wc, path);
> b50c6e250ef913 Josef Bacik   2013-04-25  2729  			if (ret)
> b50c6e250ef913 Josef Bacik   2013-04-25  2730  				break;
> e02119d5a7b439 Chris Mason   2008-09-05  2731  		}
> 339d035424849c Filipe Manana 2021-10-25  2732  		/*
> 339d035424849c Filipe Manana 2021-10-25  2733  		 * We don't log BTRFS_DIR_ITEM_KEY keys anymore, only the
> 339d035424849c Filipe Manana 2021-10-25  2734  		 * BTRFS_DIR_INDEX_KEY items which we use to derive the
> 339d035424849c Filipe Manana 2021-10-25  2735  		 * BTRFS_DIR_ITEM_KEY items. If we are replaying a log from an
> 339d035424849c Filipe Manana 2021-10-25  2736  		 * older kernel with such keys, ignore them.
> 339d035424849c Filipe Manana 2021-10-25  2737  		 */
> e02119d5a7b439 Chris Mason   2008-09-05  2738  	}
> e02119d5a7b439 Chris Mason   2008-09-05  2739  	btrfs_free_path(path);
> b50c6e250ef913 Josef Bacik   2013-04-25  2740  	return ret;
> e02119d5a7b439 Chris Mason   2008-09-05  2741  }
> e02119d5a7b439 Chris Mason   2008-09-05  2742  
> 
> :::::: The code at line 2649 was first introduced by commit
> :::::: e02119d5a7b4396c5a872582fddc8bd6d305a70a Btrfs: Add a write ahead tree log to optimize synchronous operations
> 
> :::::: TO: Chris Mason <chris.mason@oracle.com>
> :::::: CC: Chris Mason <chris.mason@oracle.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

