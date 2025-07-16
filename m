Return-Path: <linux-kernel+bounces-733759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABCEB078A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D241A41CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4D2F363F;
	Wed, 16 Jul 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzdB1isB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9612F2706;
	Wed, 16 Jul 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677463; cv=fail; b=BlRe8LwUkCbv6v2zXX+Y5d3I00u1lWTPUN2jwUTjon5Bk7pDOjDrxqLGM2vaufA+He0FRCldZe2J6LNroqMp3aXNW0HZQWR5Rhhz5ULdwBxZHpIRWKyvzZV3zPJlP6nVZ8Ca9exTwmuHRbHNyAyxX7gGRAQUmV20TGk7GP+hObY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677463; c=relaxed/simple;
	bh=fcq4B3gjsEjTZFOcpHFZ7jCB1KKHEb94d7YgORHC+C0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pqwxyeukeJgoTGl6ma4tUn4eVEgwoJ9PNvQDbHTtjk9iRxVrH8Sh21yPQJP88ide4QQoNIF3TOsYwYPKYbpjfoO05hYgiyXpI/jnjXBjhKEuosRAVmE2kAIy13yTeKI0lmekWOk6VbSqQNrmgnCjomNv5Gm4vfl7Ey+26H4lybA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzdB1isB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752677461; x=1784213461;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fcq4B3gjsEjTZFOcpHFZ7jCB1KKHEb94d7YgORHC+C0=;
  b=IzdB1isBP36QK/ie+Q/0w4BCIkpvw/fKaFs8flDs5DAkuBp2eGWfZ2MJ
   KZObSEL9Fvzj7O0qiOcEnRfve8UIv6D+QUJZ2ljdMs0ky8u+9Zn4RhLcb
   ES5jDjCCNSLQjC4L6vkv1E6q9HO5A2w+eTuPiZL4ZBZW1JzqmSZIOQcgp
   eomj6PONGGoqjj25d6ePPzp0HWZDuT7YqI1BX8NYiyYKSuRIRTEj+mW59
   FFywvzYTFdzXYAKkXLpWKUiwdEwK1CjXmqAR4FzGjKbHL/TfaQ32/yCXn
   Abe7E9O7CrtJpkyRUsXHdpV/Ua4V8pQBe4K8GaBbA9gwTUQ8l2ufLy1I5
   g==;
X-CSE-ConnectionGUID: nrxqUitATUWcgVWACZBmaQ==
X-CSE-MsgGUID: zDpEWz41T7aQXmV3f40aAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65187155"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65187155"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 07:51:01 -0700
X-CSE-ConnectionGUID: JhFQE5YsSiqh7+KVvi7oWQ==
X-CSE-MsgGUID: 34faWf1JSy6cZkHdOJfjPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157878141"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 07:51:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 07:50:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 07:50:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 07:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngSWWFmw9g+rAYV/cosK+ucJeSNbvsnvUVxJ2ok+VYEpfJHoYF5sjSPgQ/5CkCHFAm3ChWqMXprAf/sqJy+/CCZhxs0xBkvVAfrEtJ51hvKFE8w8dBdCBkTiuNGcPVuRQt4wibMG0ZEplsTnzq6pB3mN3A84/WC+Npas1L3L3toYG1AJF77dPtMMZsKxRT4PkoYTAJx4ueuBvB6SNgOrJGGrDelYFddkSTuXTbJyfHnrEat/HO8tXFlpstF/w8/b7lBd2NXgAMzkL75ZSA3FXY4djZDQvyUssGUTOkzM8EGi7J41c+930Un0YSMyZ9L4wiCJVQbC2IWvmpE7MQldCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQyJFShqN9cqAAks/MY31V2TbGt8C2wXAmVpkGCA3C0=;
 b=mZLsi72XZcVNKETnoFq3+JLgQnchk5CS51jBAEW+K6dq63fhRaxLCFRkddJ/W+C0ckHh5hbtfAS+2eRMdjq+uN83GCZeerHgqwhZtnbqFoxao0HtO9Vc3kxYUGsqxmfQz6Jsoi0HI7AghhRibklCYggpI2LA6RMRf8lbW/qVbGKosAX7wtGzBY7/hioatUgCtEZ2h0KJZd61oP5NmCvM5lLizmY+K8BDi6/iSdosQ3S9Wi/2b3XWWgqEMHhnlOlSRDPdZcv50NMUHzjtITYL/4CVxF+aJx33Qgxuc9x2oU6BcCfHOE34m/a3ATH5HpQzeE45kVQk6zsAP3uD7fdm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by PH8PR11MB6612.namprd11.prod.outlook.com (2603:10b6:510:1cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 14:50:42 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%5]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 14:50:42 +0000
Date: Wed, 16 Jul 2025 10:50:38 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	"Andi Shyti" <andi.shyti@linux.intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] drm/xe: Fix a NULL vs IS_ERR() bug in
 xe_i2c_register_adapter()
Message-ID: <aHe8PhkKYnP3izvV@intel.com>
References: <65825d00-81ab-4665-af51-4fff6786a250@sabinyo.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65825d00-81ab-4665-af51-4fff6786a250@sabinyo.mountain>
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|PH8PR11MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ae6f8f-da02-4bfe-68d6-08ddc47822f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e+/rZ5/EVVrLyNGvTmmExmdJa4/nYgBoKJqRGU+8y8pCUCnvHt0EfuROxcEs?=
 =?us-ascii?Q?05nbyaL7OJ8ZyNV0GseEUq1lUyfqxfjwSz54TW4nguEc3JxuipzinDAtjK5q?=
 =?us-ascii?Q?FHhL6VwDumvVM+FmjNasUl3bePtU8LTgJSJ6xbu4IAbnqu1PQ+TYN6ggB2vD?=
 =?us-ascii?Q?TBeumnfTg5JzAjZxmT4IV7OfpEy2rc8xrZgwbDR8ce8nC/3bMzTRK3NJ6l/V?=
 =?us-ascii?Q?WPn5vj73sgRoxczs7Bmwgj+Upg27Wi4bmmOq3nre7kpwqDta3jsh4Eue7iKZ?=
 =?us-ascii?Q?+aGVPcV8ryKO7KKQVftT5AO+emw9fUz9jRi+INDK4IInJn+I79NPD7cb2bEV?=
 =?us-ascii?Q?n7nUg6sPmbtZYhNY0Fxjl8xOqVNz9QoV4lb5tL5EzC0ihnelaA6Au8PB4Bmo?=
 =?us-ascii?Q?QMJkcNv0/THoJ3rt0z3jbIdfbi1YWu5wXM/TIOr8yuZYyskLlKGz4mMCPYVH?=
 =?us-ascii?Q?hiiY9brzvkwkaEgGfbJnhyrULrI/Y9wRyvKX6KI1cHk1Rt7+DdiEv8ubSxI/?=
 =?us-ascii?Q?XHJMTAskpqvvufWFWWie29uk61pjk9dkz+Zm8ILGtrMyWPAWY9sC2CcERs3i?=
 =?us-ascii?Q?HEPZSB4dG7LkPJ89sY47xcoqR8C2svfpcboksjaJVWxnDlpNFalGlnZupd+E?=
 =?us-ascii?Q?0Pa3L7Nj16BVL80Trp29bUrcDHcAUvf/raUX5Q2cGenE7InpROV/KNLIUhCw?=
 =?us-ascii?Q?Hr+5esrgkA5ZBo85UYuW+cci3oci8sKsbRU0xVr9rgADZFRxWa42t2/RQZFR?=
 =?us-ascii?Q?q2QrKBZSvcXfQm44kXh8notFOO8HzKMyKHBIreoXSthm8VB67m7AWynYmTfI?=
 =?us-ascii?Q?D6IyqNDAkqeRwFUroRKy8OOFnAyu9hOMEtcPpOk+fgiQfvcmBnJOirYQAKk/?=
 =?us-ascii?Q?+AYUqByCJprOnxoP3cnsVyFqolcCbAvZ/CSnTjbSiu0VGkH/QRji/Fc6Wkys?=
 =?us-ascii?Q?4tvNgItTuuQ3SuIPkkCEC9PK/Hs0KZNNBaLDheY3a+haffKvRaiyUQFka30m?=
 =?us-ascii?Q?yxinGaBMkZ+H0Oz8rQvfsHRBFhxMVNHPAae0+AzMmHIsfi0CaMSII75eErug?=
 =?us-ascii?Q?BS8cnQFqIqBRPWOdV+D7jC5PXs+FEF3h7wNyvCXPsMqlWZ+o3wdnc8beMDhj?=
 =?us-ascii?Q?T0/A18RbfhZdTtc7o5y+6enG03jbNe1ngDQ46qlBLiTEYgH6mL8EHeveSQlz?=
 =?us-ascii?Q?LhsrXuFlhq754j47mWj66M6h2ryNzmR4YZwxWQSh6+OmDHPbeI8Sx6AmO6Ct?=
 =?us-ascii?Q?6ztJzhqI9foawa3KqMelUGh8nHQDrGNKUkcx/ScjJOh9ydRt7v/Z74x+PCYd?=
 =?us-ascii?Q?6XBbd76nwBlDlkKZ/p5LZ+V3yxQ6JmQwDDR2VZwO0N9NGvgFXDGdtqtYSTR1?=
 =?us-ascii?Q?q2PgTN1Rkh3uS/EI3Uboa8QEzL508NgplLguJQxjG2CZjlbzAuhOtNhhQNVg?=
 =?us-ascii?Q?1d0QJyTeMqI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Z1u0+yfs0/Fny7nTpZDSzVnhmHqCsfeGjAVJgMlUtY2YbMk1/DE2HdihjJU?=
 =?us-ascii?Q?v87QRjz8/p0+16BghlU3B6SVQJDatWnDB1a6N1ger9uH0ltfUrMVOZDAbFDK?=
 =?us-ascii?Q?xDYEWILkrXy3EOVD0BFIBuz4eK4CT4TJBt4uNFFQ9REfXlMcvfuilT6QMP6f?=
 =?us-ascii?Q?CncgvPjNS3AwpYQytaAH5uJfRuVfCrfHwj9oSVRjwDb5HvGcC95QvuUOGa5T?=
 =?us-ascii?Q?onSNMOUSxhb11nUno0Tp4V+k5v+7IhiD8YNFY5w8N7kpnagwzP3ccGQlewmz?=
 =?us-ascii?Q?0czfC6cepiS0nxxfqqLa13F/zoj8eFS9W6ik29BP+J4tSP0Q8EGxoqjZ9jTw?=
 =?us-ascii?Q?2J3pzqaVBwN2C8zJQTlFlLXDIVsEvEn2BKNbxX3pr7iyuCgV1NkzI2Pn7O/p?=
 =?us-ascii?Q?4yU8FeB2zBaHWEJSPFRgnuhKXJTyVvhRK+c4LmfCSOERUP36eFNyJKat8T45?=
 =?us-ascii?Q?5h7qUBE0dWyjJW3O97K5tfxTtTlThMjf6J2rwFrKuiFS5TbOMa2125pKeVeM?=
 =?us-ascii?Q?+EOEevgfBz77GgxYm3yP8ROmL4t/FGJMT6Ye8HIzRE1USuoJtPHk13LSW42N?=
 =?us-ascii?Q?JEmpCu6OpgXwrYpd4csv4IyPelihhlLHz7LJ/ZmT18d8B8gI/JTg4FhsMxue?=
 =?us-ascii?Q?Msouwmev1mSzs944Rf3JocB64McLYqeKuu1lZHIsELsdJjDl/e3xFBXiunfm?=
 =?us-ascii?Q?mcra83vN0q+182YTanA8LNrdTUzQ5DBWBLqAmcPU6TKRqHVCyDoDHvf7we7P?=
 =?us-ascii?Q?E0TGcOLB2y0N6F0BzOGHOjbd04cdfCEkKy09+t2X9XcOZVsUjayMDG3TFEBt?=
 =?us-ascii?Q?xs4+sxq5eFz3M0b9nME4atLBdpT4tAZVuHbxkeZ8Ge1FlhsywcNbHL0sn8VC?=
 =?us-ascii?Q?9NfKYQmZY3C/9vCPtvVGYqppi3m/ul1zhXc9MZhksndGY69t+lV6tpzIhOab?=
 =?us-ascii?Q?R696knyMuvo8z7opzhX3qepvtlIXt+sP4TuY+fJ963r/YXA585HaHnYbanwD?=
 =?us-ascii?Q?WuPmLz9DyrzyepFUr3DoQhBiSgXW0fkmiKyqy24HzYAcT7qXjhm4u1eopfgp?=
 =?us-ascii?Q?EMTRZTk6o3AU6ZHRoUZFAsyrZDgngBvCJU9HIQ0DcGBaXF2tmWoYEUKmm2yv?=
 =?us-ascii?Q?r2pSMDAMsaPCb3rVJqwM8kIJ5dO3lqfDUJ2qxF72ED7Cr3VToK/Lxmn+aSqv?=
 =?us-ascii?Q?wtvKtezLIeGZVtLhwPV2qfTGdtDRz48hysMFA/eCLUUOYN+yV06HWnPcGY6s?=
 =?us-ascii?Q?qIXWyhYFzwshkIM0sMNtFh5FANOOL69dBZor3G5pGh/kT227iOnwWdtaAjoM?=
 =?us-ascii?Q?DlMc5r+kDyuZB8lpvE8kVLVXHgV7XB7EAY64krQrHu8Fmn31T0ky55C0a6H/?=
 =?us-ascii?Q?391cl1yeNm5cXgyYcFT3re4GeJcK/iOK/80JTxYWuaKG/QBNwQLtrpGdMqFt?=
 =?us-ascii?Q?a9dgiRoQK1Q0oKIs9suglYEOXS+w4+7a3eIHrv58ro/LEGhfuf1ER8tzesZL?=
 =?us-ascii?Q?HdVttMvRi7UdIvZku8gk6xirPZ8CnRfWu3JAdJ8ecVR9gLjWOHc0nkmwVaWP?=
 =?us-ascii?Q?MGr+iuBQQNKxechanT0iCGUSbbSb37tIS9cp0wUtcokqaj0UnSAftAdQCjbJ?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ae6f8f-da02-4bfe-68d6-08ddc47822f2
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:50:41.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d77RfHg2uzDTFP3BewexyIeKZqQa/o6PwKe+K3Hg1AzUA6kMoHifzxaln8M+tC/vkPJ9XFpTig3gNRwY6xDmLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6612
X-OriginatorOrg: intel.com

On Tue, Jul 15, 2025 at 05:59:44PM -0500, Dan Carpenter wrote:
> The fwnode_create_software_node() function returns error pointers.  It
> never returns NULL.  Update the checks to match.
> 
> Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

and pushing soon

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/xe/xe_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index db9c0340be5c..1f19718db559 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -96,8 +96,8 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	int ret;
>  
>  	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
> -	if (!fwnode)
> -		return -ENOMEM;
> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);
>  
>  	/*
>  	 * Not using platform_device_register_full() here because we don't have
> -- 
> 2.47.2
> 

