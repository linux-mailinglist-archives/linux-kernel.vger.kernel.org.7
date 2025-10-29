Return-Path: <linux-kernel+bounces-875130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCCC18490
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F213BB72B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95BA2F5A02;
	Wed, 29 Oct 2025 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBFbUvj+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562982DC336
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715506; cv=fail; b=ieD/CJSuI4VCw05bTRL+95SGFKHCUH1KZx6wF01j48LPq73nO4GEWjhfiVsyZubYynX82Fb25X5mQHyuX779CvsRjAFFF9XYTnGzJU9Imwk4H6hPpoinAwVI8cb1Qabitg8tCe4LHuXP7vb0YiSSwpg8p6NNlk2uGm71EDBn3bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715506; c=relaxed/simple;
	bh=4DpFK5a5FRGMtSIqh9Yb8xoOhVwkb0b4bjAAciFNRTI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pQa3MFN+AQHtvGSXLa1g2THR5VspwN1rxpkM1dH3DJGzMjmGYfnc2Bs0EVwhCE8A71+fcn578sMV0Agb9rnV+I1HygWFiS0TUsZJoqRvD7NBmrD2WlCFoate9Z2u/k5zXoYQqAq80lgq6j1X4/fe2KwBTW4meTtxf/1q/3SjN1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBFbUvj+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761715504; x=1793251504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4DpFK5a5FRGMtSIqh9Yb8xoOhVwkb0b4bjAAciFNRTI=;
  b=JBFbUvj+hgUnnpg8wBSKmauu/Hy3A7RpNz2hMrN/b8Z5dC97Gj0TTv1f
   b7v8pXB8ZPckBbp2opn2Pe8vX2I2JiM5tYpG1SQ4SXdMY5a29oCYIugWU
   rXuqYUtK+TB3RZILSJhO2I2I9rghfiMPZ97Fre80ZU5r8EFANOcjkxLRV
   zdHY4a2N+bj4cDVmhh4t2GqxqMuj8FdegYdu4I0S0jkJpQ2kRxTm8VNUz
   70mc9iLV768T9VZH2ddxQWp6z3XTCjaE9u1am3JftOgUsXOtfaFsJ4hs6
   vQEGaas5ZuZvAiTufIYAx4ZcaOE7HjbLiovKXhfxsOJDYfmdAyItPQ7CX
   w==;
X-CSE-ConnectionGUID: ETwPM5aFS4+0/gNxS9anfw==
X-CSE-MsgGUID: DyMVLlxhRLaZj+ZUOQKC9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67690505"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="67690505"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:04 -0700
X-CSE-ConnectionGUID: SdaHpvT7TLqFA70ibgpFFg==
X-CSE-MsgGUID: 0RqzJuTgSOSVBaAYJMQUcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186014516"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 22:25:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCAQE+uZuwis3R4gJXFlKJjwHQ6ADIx/vT9zrFVSOXhx9D4QFJ5kFNsImqLRAt34vtBSJCZ/faR2uccxA3RG5S3ERBLqnk2nrkw9YZtV2clB3Z6kLs3ADbL/7MxNIohswoOMjyFyjYe5mz7fyNr40Ji9WuZru4hN+cvL2+XkFdA3915T3alcbKcF82XkmrjzWFOhuKelLf6hoBuhoeGcY+mrhHUTtCzEkL/9xab+f22fh3tLYgoNuoIzrR7Z6XqSUeBTIjwP0YDhq2pW1fuWahmvkV+wUj3FGTggua4c0sQvgfr20/mjPIpequduB/8fOJNnvIzkpwncQ1bTLkacLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu8740ZifmXWnnH5sguFSi/P5drZ5/2bEffl0RG4+Qk=;
 b=Z53xNB/nu8x/wPnotEHu0rhCmHJtS6TxU5RpoFpEbgteXSXgGMWWUbdlgkBrrzAC31rTtLkGUs1Mlwd1SYSMRCW/eFFvAAa8iZNp9TfuDnLxPsiayAZEHa3CLNxQhQBopOVs5+beW18Hf/hoTWRHLF0ms3dRHuVorP9+VJwaS8Kv76wZsqfvls3q1lqPxTmZ4nE/kob2Yu32u1wkdegkjp71Om94MysBCKthEVp9U3MFdeXJ80huieXIXqPVg6vVGJpP0iGNB5wBvASPS0gw/KA+6UW/JoZv5vJL1easM2Dbd6iQD9s7gZuOG2myv8DXZQIGk/xiosNIWoHJqGnGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 05:25:00 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 05:25:00 +0000
Date: Wed, 29 Oct 2025 13:24:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: arch/nios2/boot/dts/3c120_devboard.dtb: serial@4c80 (altr,uart-1.0):
 Unevaluated properties are not allowed ('current-speed', 'interrupt-parent',
 'interrupts', 'reg' were unexpected)
Message-ID: <aQGlJHONKIe1624b@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: eaba6256-e22f-43ef-ad46-08de16ab819a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xlqYnSvL66iJebuv93R4ne5TM5ohDERuER2bt4ZEwRWcE5lPxhao1KP7Nptx?=
 =?us-ascii?Q?mfwn4FwAbFT5mhlWTD1wnCe93ELz4ZHyFTk/HU4bvGWveEjcpOXXuFHlMvyC?=
 =?us-ascii?Q?qkIGJK7B64Zt0W+rsf3cePqWTVVcsSYSciMKMaiPhgtAogw0xAQARNN8W05+?=
 =?us-ascii?Q?3l/M+D/D3QCL1Me9aFXBwUHWwBJo+HfIuaIvmIVd7e41xVnUkQ1AkljuZx8O?=
 =?us-ascii?Q?efrR0xKKBC8y3CBUOd3dwYbqdxNyCAcINd0FgMYM123EImw8KXUQeteFaKFe?=
 =?us-ascii?Q?lo/yqlSUgOrtvj4dmTHhRR7Mes9SWDKls9r+1Gh0CXHt3+qHTWo6Tt26LhUu?=
 =?us-ascii?Q?cobP9oNycCDln9QWYhLtjnadNzawpEGS9jCXb5O5Ow+IicgyPGl1Fr7RXKed?=
 =?us-ascii?Q?Gy0Sq5cPpcycUZHvj8pEv8oz59QbezqwEwEQzwJwV9SAP4a5GMgyuThYxQNj?=
 =?us-ascii?Q?Gg0lGqqfKMzK2BCfX8JQAy9YZpXU+JWDpELjHtuVWbtyz9dzmwZHbnLDQGx5?=
 =?us-ascii?Q?6Wdbxlo+/ntkptqBFNVDhKgAdE9jD6+PIm19bN1tCIA9aFivfyH8nHiPgqa/?=
 =?us-ascii?Q?wWD3OLxveaZO1sGTDQZc0HRBf+z89EGpeetMwPM/ZW0JBpkNGTnARCRtdAF3?=
 =?us-ascii?Q?3LgOVYaxe9EAWbHgYa2PfytrN2NSA07jG/cmtGS3djggkO8SAuD9xoGaVp1U?=
 =?us-ascii?Q?HXCewRYwnB0urQySzP4VUXL3Ifg5Xbp2Tco+/V/w7EcXHbF7/C4ziFJL4xhQ?=
 =?us-ascii?Q?7S9dLnz26/daCoftr2nvjvxQpnN3H2qpC+fZxzrgcIeUlEaNS0ZDkz72tWYW?=
 =?us-ascii?Q?4fioXIXWyMOnKVsh8K2l5JOwTaluDC4aukh9S05cPXl20v8pU2Lz0SFilXkf?=
 =?us-ascii?Q?1gqqvt3CTlTqrl/GahXkLnNuXR43EW6qD466bI27MyP7jaMbi+W6YTSC9MQg?=
 =?us-ascii?Q?l/A4TCTbVQ0ixXnHl8uygGpE5IiDA0is5D7gNp5z+B4KcPzCiEVhklw/cyxn?=
 =?us-ascii?Q?YDTURdaukxJanesAhl158MNr6Urzzm9zipe4mEjRkJieG9VyzSNu10J0G2oE?=
 =?us-ascii?Q?cLEh1VI4aMzfMi2PgHPR7lqv/Ex2HV7WXA+cGM7F6/JBKh7jIXKZimy20u3q?=
 =?us-ascii?Q?63ChD4DqvCaevixtuIzD758umdM4oodHpL7ge30sDUO0RigZzpVQqq4Ua2i4?=
 =?us-ascii?Q?6gi5hABpNMJxylV0ViTYF6PKy391P+ydDh0iSURNQUrHMVQOKHaYq/oYevUQ?=
 =?us-ascii?Q?r+67/YFKbfmWYj1ZXomNufSYaz8VaPsWhTzQdfhS0GjFgPwMmYYVuaDY+Wt6?=
 =?us-ascii?Q?Pp/uIWn0PZQmPDYKfPzkb7G39OUIh3NOsdkgEViIl6XuS6hp32gV5nmeFWIL?=
 =?us-ascii?Q?olivXkgoasmtdvqqYbZRysC4cDdhlYOD3/ZC1o6qW9jOZsJsPGeZJHfFl2sl?=
 =?us-ascii?Q?S2cCbN/NrKU7J9aPG9Lhbxby5YnP9itLbE6Z8a1qXhiz/Xt2RPGZ1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CQiMa1f87l0Ocy4b92m8o7XSje+QrixdxLJ81t0BL6mkuIcm8K5OQcgDjOT?=
 =?us-ascii?Q?/2X6+8CfKA5eiD+mu0V8HN6z6gr2f3g1/fEg2s2YFm1n3alhyrB9Sd2Zwj5r?=
 =?us-ascii?Q?TkSmCkCIYPKAQwR2l0y0PbpBLCD1GjZqiM/5sKyHsiDbDOK+8jkLjW4oYjrB?=
 =?us-ascii?Q?DVg6+lyZR5ucOOwwnTtWWu4kFfhZJRTZ1E+hYlxsew0pvunVrjxdqdB+z7Je?=
 =?us-ascii?Q?zIeVmtDo6VN/jfGy1Ob6U0nUluB4yjdS7zYfmcrE5guQwlhn5lrc6HENE2Te?=
 =?us-ascii?Q?DOkwmJtTMEdDvTpVEICLdenzcRoYwYOpsNs6RyAv/LtjZk7dpHD4LOCZqmww?=
 =?us-ascii?Q?pzZJg4DG6QxcOwG79y0X5t4B8iZJDx6eL2Z/mEhd3vhifiVt6sl4omVAXHI5?=
 =?us-ascii?Q?gTMSkTnFiCcbSpjceu7HSNpPBpehNZJeeZoT98c7pCYKldDJe3ZjnVWtBFY9?=
 =?us-ascii?Q?lRca8fq+B5PicFVWlduS0VuPBN1IuYDEKPqUXks2P9sB0mtoWYIfuDUuf2CE?=
 =?us-ascii?Q?qNGlwR7o9MNrTBEqGttGXzQ7BaKCXTwNIV38UrZ6zV9CuGc7j2Qm1WGPJRYB?=
 =?us-ascii?Q?XHLG1vbXRZus3P1RqUVKU1AfmQODBg8omeE/w1Woso3CzU+rSMEyi4Q7NKEX?=
 =?us-ascii?Q?+mtCtfvWa0aAw5CeOFxJ15ej5QCJJ/icMnzq50SBjK7zktGynZKzVJtNQqbn?=
 =?us-ascii?Q?itupJ3LU9+yrtOQCGtFND2ipX1fquw+WlYsAO0jYGiOoqG9SnOqhR8Y3wdwz?=
 =?us-ascii?Q?Nt6UdF/GPalqf6eM5IS+6CrD80KGqXhYFk49HP25lpDUcDCaGuJND/lwPSiU?=
 =?us-ascii?Q?oaltLCUnnFxyzyoP6gXkuDKFtGmAjmyVM7Zt1pOrCLL3wfNyXcq8Sgt+z72A?=
 =?us-ascii?Q?/KARIiNaPOdNPpYyDPszm53juHrMH7F80U+BBhAYonrm9ig3J0lyPohXiXB7?=
 =?us-ascii?Q?s/Rb7CWDmh00EZyZZxpEgKaO76Z6hjIMJ+DKl5i4xYOxmvYFb2qc2a6OLAUR?=
 =?us-ascii?Q?lukWZvLNdAaza0g9U3xyiVxDOMcMBgZLOhZfTYdGkazraq2KvvcIT977/Kzt?=
 =?us-ascii?Q?CL+p4RFT5z2vHWYt+DVt0dJ9hw1mmlOB14m7NPZ7AylKCvQyfA4sAGqeAofR?=
 =?us-ascii?Q?hHGfYSNyiAvr4aQdDuzonkXwMb7TEPzI7CNmwhMHqr0xbJKEtTEFUFuO8dqb?=
 =?us-ascii?Q?OWij+liapxklPQpX42CXfBVeccny6+X8H/wX0h+mX1yBfDMjxrp4FoIIlrhG?=
 =?us-ascii?Q?mtKXrtSziKvhbMpC0z8gpeULiV/pMLkdR2rVxO2n2B5MLl5QLJRtyYFPclCx?=
 =?us-ascii?Q?k1OKI6EpAz1bisIWP44qKokZkgZKfP46RViqdMldIT/EN5nXjuu5WEWwaNCO?=
 =?us-ascii?Q?qSIZ0BYULmXnEmolGN+R5Cm+GbVPkHw9iiluvVrFAuzi57LlCwc3tbzF9Im4?=
 =?us-ascii?Q?WJroudwO62Q6e9enjoWRQfGnd2Jcs1vquC+p31C8FevhdlwEeebUs61Vlv8f?=
 =?us-ascii?Q?6/4J3P/XrWDiq0lNFdNj30slnaPLUt7cUEpk6ZOot1e+PJt0mQr+eUDwOEC+?=
 =?us-ascii?Q?WO8KBDd3GugEpRSOm2Gph+pguA3Y7mgurdawY8NrgiyjMsJYfbjhQ8ma7QY+?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaba6256-e22f-43ef-ad46-08de16ab819a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 05:25:00.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9t1x5T1yw8vybVfS/CZVgohArD1SxrofOeB3t1u2wKUK0XB4/KJeXnrGMDF7xGsJbTmZREjaNjtOnkB0ZjNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
commit: f75794b6077ec729f57de9a1ad24f14d288a68bb dt-bindings: serial: Convert altr,uart-1.0 to DT schema
date:   5 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 5 months ago
config: nios2-randconfig-2052-20251024 (https://download.01.org/0day-ci/archive/20251029/202510290424.bG5rtREi-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
dtschema version: 2025.9.dev12+gd6be03029
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510290424.bG5rtREi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510290424.bG5rtREi-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/nios2/boot/dts/3c120_devboard.dtb: /cpus/cpu@0: failed to match any schema with compatible: ['altr,nios2-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: sopc@0 (altr,avalon): $nodename:0: 'sopc@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0: failed to match any schema with compatible: ['altr,avalon', 'simple-bus']
   arch/nios2/boot/dts/3c120_devboard.dtb: bridge@8000000 (simple-bus): $nodename:0: 'bridge@8000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/timer@400000: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/timer@8000: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: serial@4d50 (altr,juart-1.0): 'interrupt-parent', 'interrupts', 'reg' do not match any of the regexes: '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/serial/altr,juart-1.0.yaml
>> arch/nios2/boot/dts/3c120_devboard.dtb: serial@4c80 (altr,uart-1.0): Unevaluated properties are not allowed ('current-speed', 'interrupt-parent', 'interrupts', 'reg' were unexpected)
   	from schema $id: http://devicetree.org/schemas/serial/altr,uart-1.0.yaml

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


