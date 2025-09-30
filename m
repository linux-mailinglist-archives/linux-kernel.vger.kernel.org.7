Return-Path: <linux-kernel+bounces-837209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB0BABB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F693B12F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161E29E101;
	Tue, 30 Sep 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOQAaZS/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17D299923
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214764; cv=fail; b=rufYLUyaGa55mZUZEK7MyJY/h0+cnOmYmUOENTnP6fm6IhzvJnb5FmS8pVxOwhp5guM4ZuY/npbuTxaeF1Bibxybwd04Xi4bKVrwpAE9zDY6kftmBa0nizlxiWvuw60L+v6xE3XIOisp2KU71kpNHhX9BlJP7A7GYWrWSCZfI4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214764; c=relaxed/simple;
	bh=Y8V5XHKtogp3y7l8v1oQ/pAJNjlNjTcWB9z56pMVwNc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QdbT3sx5shDwX2TkQWon/lozLbsNve0v+v5p6jrVm1cWb0hEBUGtQOmSa/wriTlWpKG8oOefYAJ3IuwUCFoUAtjPz0g5tuxqz/1pcjSHlHcqRS96TZeM1ymbdGSyw3hTvk8E1e2mhKZUg5BDskeIqlVJOzofTFei50e4GLVBhW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOQAaZS/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759214763; x=1790750763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y8V5XHKtogp3y7l8v1oQ/pAJNjlNjTcWB9z56pMVwNc=;
  b=UOQAaZS/yE4gz0/Ugsho7kf7/qClq7CF9RukNrL1QJdSiQuNd6JPbOgm
   K1aP4F+O+nN4mNQtlkQUe/6nCXY6B1s0i33Tzai0jCuO8ElEMrJV+7YFu
   oCTMOZj7mdfnklDSh4syOSh12eF38URKqQ4Z9CEBVeqvqiBLCglb+5Odu
   4/1aBrzKhKZjNQrl1UZZgVzPTEv2GXS5vsI81QUZjUnIBQ7mGBbyaCo5e
   2mACns7DclsgR1gpaYwYoC9yFjxREBoarP6sIqiDXmUHfNICc4spG2gux
   A5x/vAhIzmNedYyXr7XAQ6rroj/5wV9eS1BsFlFSJ+tEakj5K+P19FupT
   A==;
X-CSE-ConnectionGUID: 6VvvZVxWQG+0sCbzXuaGXQ==
X-CSE-MsgGUID: 0Smvz4+rQ5CuJV0PUDI/wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="64084959"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="64084959"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:46:02 -0700
X-CSE-ConnectionGUID: If8cPRWGTN+Q9PP4eqjbNQ==
X-CSE-MsgGUID: QNunVuJyTU23YyF34SRMiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="215590447"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:46:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:46:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 23:46:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MesMpl7wexWv2YsoBGn1zE1iY4x+PeH1xKZNRyXkQ0UT0SZAjrGy1Tul18GtIQJRqNo9hX3GdoAfoSu9Rk2W4akjA0lueXbJzPKKx1R0TlKFtrbGWrXPs+J4DJPgsLZW07zbvKKvWFw8HUMX1BUBnWfpWXvUwAyjy+cmkMcWMlfC+DCPJ71l0DyclU6z5681GAcFvhEbbegazIsCiWIbp8VBpH9eM8UXMHyFjtz+y9wYnm5h7LvnFHQog6Mjcch82RBddz2A+ngMS8K0SL+kCMivFjYsZqrLWgi9JPGvTxqXKnD2baikNbKPCZn7aU3lmF7eh6RbNb95wJgpMh0iKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV+iEjInXAUG+vPC8bqPK843jYlaDFAkVKxtqAyyExo=;
 b=Z2V9qWemuy2eIwb/TVPCkk7iSt5JAQchykaz3EY+ssPShbZ56LlfwPTXNJNj2ym5QnFh4NUq7F/Vi1x18AYkQObqZzIfn6JJeuzEJ24oi+S0LbdJuszn/TFurUvE0g0+EzqlTVH13de+geJI3c4ALqpIvsmrj69Elr+9uU2RwL1YhpEj52/2HrJ52LvnNkqhRg7Y6JmRa7votM7mpkyaTTv4s5fWEiq2yJsf599txcmTXmtp2C6/NQi2ntMQyG/tipVW7Xlfq1StS7D9vORxWWK40yiXhU6yMa2YGJo+9N1VFzio5yWBBRjbb7ANUA6/yo7D6lhZNP6D0uqjWlqTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 06:45:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 06:45:56 +0000
Date: Tue, 30 Sep 2025 14:45:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [broonie-misc:arm64-gcs-exit-token] [selftests/clone3]  0b67d4b724:
 kernel-selftests.clone3.clone3.fail
Message-ID: <202509301454.adc93851-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1P15301CA0059.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5fe487-52f6-49d0-ef85-08ddffed01eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jOqbrhfv8d8s+uzPISqQbau8FgEwJeAO1O8RPZ98T2BP6fonXhwprbj0ITXG?=
 =?us-ascii?Q?YF1WJbX2Jpp5hQV+cf3xXpo0HbUgeItc5oK4kaEgz1iYHmlnuLjj/ZxrJG7s?=
 =?us-ascii?Q?qW6lCWUfyFLMZ14xuEoOtG2VTnLfhiyYTK9bbmp5w4K5sTWQpiY+l/xefJb5?=
 =?us-ascii?Q?YTDYO18SPt02Nos40nPlooxvvs4fhrdZIyoWny1j6MoSSi1783YhYYa3LUhQ?=
 =?us-ascii?Q?wLYRFn7xMZxgJR+pEBXMxUXAFfwCmCuRikYPkb6IwwPP36FA9PTHk3XjSdeW?=
 =?us-ascii?Q?9gYDjwmErmpiBxlhcGIRgQG5iNXzIw7TBeXYuUCXXOfnRyQffUTQzTVQVTf5?=
 =?us-ascii?Q?FhRLvrlPG1OLG4tJ2JHI/xxPhtbJB6y2lK4CupQV4oGtnKeMHVodm3oJgiBH?=
 =?us-ascii?Q?OZuL8TuNhBN5dvbgKSKBrP0c8k5GcKC5W1gYULHEFSexo+Tp/buCg7AmHLAh?=
 =?us-ascii?Q?xuxzdiDgRP+FsuWFoNnKIgEz5JLC2DxdG+WqkDHwS4HCP/T/axaXk/I2YgRS?=
 =?us-ascii?Q?6X+hDCjYChcXlK0o4pLsmaNrF4FxKlsT+OI4w918EOqcTMg5zv7ZRg41kptm?=
 =?us-ascii?Q?jbjgfYVGLdJ0Pr0E0a1Xfq+5GVNz1pBoQn/xVW2+4HKyx2DFcpQvzsd3O1rM?=
 =?us-ascii?Q?5OOPLWRY7aOHLgLXreatHbvN9cofcAvf6iW7nUhDWnyeHoMZe766pn7ranl3?=
 =?us-ascii?Q?KByqBOLqlVND9+d+XzqAItXYPJETvLE7BNoDFHSh0ryWZvUQq/ao9m0Dceoo?=
 =?us-ascii?Q?MAj7VYUNod0PShU3hRJcGE17SnbhpcBZT4XXv1qBvkrAjasB4i/CNacDd8Kl?=
 =?us-ascii?Q?puSq8VeUozit/aonjzfm1ZEnl3N7/CiJCzxlP1QlfU1ZwFxBYWPgZMufhU5B?=
 =?us-ascii?Q?k46nl+xK5cuSXewEdUnCGyEQR9AuA3uSg3fpKmlGFUMb3O9mhmIIuXSvgJaA?=
 =?us-ascii?Q?QpPt/57r7AYCMYhSBqEsKqMhlb+BMbqBDAaxDa7LHNXP63UDA/oECVfqso/X?=
 =?us-ascii?Q?HeMMGYtRi2T85S8HPD+//Dewu2ooufPLwYC0BpMo702+WiOiudtwcZfm5cql?=
 =?us-ascii?Q?HlrnzPKUYOu9iCeb51pESaxCMBtycRqg/5qvToD1jrEJYduIeV7N+WxS+rX7?=
 =?us-ascii?Q?05PrrZr1Bn6MvWNldnS0AdG7yWVXRPkKBtyJzPwMeUFn5VeB4lD7ArDAH5Gb?=
 =?us-ascii?Q?e5qiVIv9aeRVqq1n7ld8Il4BBeFihppJ8QoYJ8S9UxA3I+iQPdxnN1YMhWef?=
 =?us-ascii?Q?gDK83QfiDqsS/g2oRZJoLifqiQSFyyXcQjesONLhF+t/SqwoWfYPjEFiENbM?=
 =?us-ascii?Q?QoEeh5gMmcOqUkofwCen9chqB9R5Rv3RdCFa1s/vFoCX64moCuALO/KnM4j6?=
 =?us-ascii?Q?QREumLwbryI7oqRCKD+vhIBuG7E3ZTS1s/ZrDEWnSGm3IweJ859Vj0Zdt2TR?=
 =?us-ascii?Q?8VOHVUbKtRI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PytIYf4oLR6IpUOQxwOWSPiDXX/KYWL5odEbv+9nE5EvGWfCi3tRyVPruJHY?=
 =?us-ascii?Q?NemQwf/pH70sTibcUb3A96C+PA/x8vJ4xfXlz82n/xTY1n/XS+m41yFcVqZH?=
 =?us-ascii?Q?gOw7Af16dqW2n0WlWYmGog7dGKmMHVx/H2kwFCf6DnsChAup3L3Jh8pfivnr?=
 =?us-ascii?Q?fTKk6xbVFCDTeuiZYMkFpeMnnMALtNTFu10rSGvWCUiBmCIDu3Mmd8hs11C1?=
 =?us-ascii?Q?DV5cZ1Kxl8g3tBWdncAdsXvBh9StC5uFgOtZUQjlqfdjZtmmzsEw7EmdjVzT?=
 =?us-ascii?Q?bYaBHoVNBX3/OvXVYmVHyVZWMsrogtZwVZ5ExROqVCfn8P4Bh/5CKI6B5kx/?=
 =?us-ascii?Q?HWBciXdI7kkV3sDbr7XpcVmMZ39YUhW1qgXCd8RXNR95qUwOlUZLkCjiKHJ9?=
 =?us-ascii?Q?p/3RsUIfvIQgdu3OZS0t4NJcFRZ8eJeVHQ3VFRX+oOdm+kb1OSYZu7b4j0Gb?=
 =?us-ascii?Q?ZuLQN4jS/tUc+vx5/91K94VXf1PJSdSTsSGt5HE8Y8OCiyx4zJLdeCCnODm2?=
 =?us-ascii?Q?AI8+HpaYh+NhCGol3zv5w8rLtfsQ5uqI4eoUQrcuEnHot2iV7mfbPxeG5lDp?=
 =?us-ascii?Q?Vtas0H0/JS2BUUzRCs6QaTYUdURo/RkE6kLgwKles5/uHaaGkFtwXXUUm5D+?=
 =?us-ascii?Q?8FBGBB9fb3FwSkb2Ck3wfINikgVJeXeaa6VRRgR+rRWoJQu6fZus4r+wMwj2?=
 =?us-ascii?Q?IVSDiXTKXkdUwzdAvAMzIdzI8tkuVV2ZcIRtQ6GirPU0QQfH+i7OFDXyKbua?=
 =?us-ascii?Q?60zR6IooKaLUic2LLugP4Tv748Z3uYqIipKONMxVm3zpIc7OLazhVz0HSH3S?=
 =?us-ascii?Q?hMe+DAE39A10QT2isfEgsFyxO/phzWuBnps/RXnPtuKvkPMkyqQ63HYthPH4?=
 =?us-ascii?Q?NiS+QoQvz50wPLXXsE8xZ14uWwqjSNNjAFXTlgGoXrzfz97KCmSvLr8no2Tr?=
 =?us-ascii?Q?PZl8nxU2Yu3STavDlWUzctSFhjMCxFJ5nyU1YJZlOuP0YMRB1RwgEf4Df5D4?=
 =?us-ascii?Q?JNNd4cw/dCxihVrzPNkpgFfn6FCsZCmZej+pN73TMulIA0p68f+qnjcJdymu?=
 =?us-ascii?Q?VRwkfHLWLG91Ji61j6SZglLPRIjReUqtsOX3M7IdSutvngd+a9GOG2tOQwIc?=
 =?us-ascii?Q?jFSeOFfclduVW9b233inGQsmiq8DzmklF4d7q/kF5F5Il2OUDVP0krFK+EWh?=
 =?us-ascii?Q?0jZlbVrgpx/59EkwTtvKccg6w76R3RiWiiIEYmRmtWzd8s6o01hEZ4APNeaT?=
 =?us-ascii?Q?mHYzon/CYLFlGq9CrBqPHDp4rcfIzepPX23Do2t60l+xlB1+kNXlyAHNZNEO?=
 =?us-ascii?Q?+osjt8CeE4Vtbu5WJWTHmHeJm9lmsD7c4elIVyEQ8N4V7PpeGXRWYQO03ilC?=
 =?us-ascii?Q?fiBT2aL60XPjU7MJOfIJoAIotxH2mWfQLds2e+0xM6tJyoLgC9jcwAY3c84q?=
 =?us-ascii?Q?ic1rNxZ/ACpYbMTPBMiEr4I1RXMPQw0InDpHLnDX7J5VU84FAaNdRp/g/lgV?=
 =?us-ascii?Q?jqsKSR8PQ73C/dyRma0rwETibMcgmmhrgJex4jOeBBDB5Ru6jbKPhsgyiuvh?=
 =?us-ascii?Q?huSm9JhW9wM+8dsK8IbVJqkErmOl+7eLoONO3tPA2eisyBeoMjjpG3iZToTW?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5fe487-52f6-49d0-ef85-08ddffed01eb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:45:56.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1GkOL9BtcDR14jeYhz7rYXcVKYOmycbx2Kz70SKs+fi193B7WspH+ZJbrvyW9PYE6c//RmyX1bUmAZZqBMvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.clone3.clone3.fail" on:

commit: 0b67d4b724b4afed2690c21bef418b8a803c5be2 ("selftests/clone3: Test shadow stack support")
https://git.kernel.org/cgit/linux/kernel/git/broonie/misc.git arm64-gcs-exit-token

in testcase: kernel-selftests
version: kernel-selftests-x86_64-592a93fea16b-1_20250918
with following parameters:

	group: clone3



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509301454.adc93851-lkp@intel.com


# timeout set to 300
# selftests: clone3: clone3
# TAP version 13
# 1..24
# # clone3() syscall supported
# # map_shadow_stack() not supported
# # Running test 'simple clone3()'
# # [2448] Trying clone3() with flags 0 (size 0)
# # I am the parent (2448). My child's pid is 2449
# # I am the child, my PID is 2449
# # [2448] clone3() with flags says: 0 expected 0
# ok 1 simple clone3()
# # Running test 'clone3() in a new PID_NS'
# # [2448] Trying clone3() with flags 0x20000000 (size 0)
# # I am the parent (2448). My child's pid is 2450
# # I am the child, my PID is 1
# # [2448] clone3() with flags says: 0 expected 0
# ok 2 clone3() in a new PID_NS
# # Running test 'CLONE_ARGS_SIZE_VER0'
# # [2448] Trying clone3() with flags 0 (size 64)
# # I am the parent (2448). My child's pid is 2451
# # I am the child, my PID is 2451
# # [2448] clone3() with flags says: 0 expected 0
# ok 3 CLONE_ARGS_SIZE_VER0
# # Running test 'CLONE_ARGS_SIZE_VER0 - 8'
# # [2448] Trying clone3() with flags 0 (size 56)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 4 CLONE_ARGS_SIZE_VER0 - 8
# # Running test 'sizeof(struct clone_args) + 8'
# # [2448] Trying clone3() with flags 0 (size 104)
# # I am the parent (2448). My child's pid is 2452
# # I am the child, my PID is 2452
# # [2448] clone3() with flags says: 0 expected 0
# ok 5 sizeof(struct clone_args) + 8
# # Running test 'exit_signal with highest 32 bits non-zero'
# # [2448] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 6 exit_signal with highest 32 bits non-zero
# # Running test 'negative 32-bit exit_signal'
# # [2448] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 7 negative 32-bit exit_signal
# # Running test 'exit_signal not fitting into CSIGNAL mask'
# # [2448] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 8 exit_signal not fitting into CSIGNAL mask
# # Running test 'NSIG < exit_signal < CSIG'
# # [2448] Trying clone3() with flags 0 (size 0)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 9 NSIG < exit_signal < CSIG
# # Running test 'Arguments sizeof(struct clone_args) + 8'
# # [2448] Trying clone3() with flags 0 (size 104)
# # I am the parent (2448). My child's pid is 2453
# # I am the child, my PID is 2453
# # [2448] clone3() with flags says: 0 expected 0
# ok 10 Arguments sizeof(struct clone_args) + 8
# # Running test 'Arguments sizeof(struct clone_args) + 16'
# # [2448] Trying clone3() with flags 0 (size 112)
# # Argument list too long - Failed to create new process
# # [2448] clone3() with flags says: -7 expected -7
# ok 11 Arguments sizeof(struct clone_args) + 16
# # Running test 'Arguments sizeof(struct clone_arg) * 2'
# # [2448] Trying clone3() with flags 0 (size 112)
# # Argument list too long - Failed to create new process
# # [2448] clone3() with flags says: -7 expected -7
# ok 12 Arguments sizeof(struct clone_arg) * 2
# # Running test 'Arguments > page size'
# # [2448] Trying clone3() with flags 0 (size 4104)
# # Argument list too long - Failed to create new process
# # [2448] clone3() with flags says: -7 expected -7
# ok 13 Arguments > page size
# # Running test 'CLONE_ARGS_SIZE_VER0 in a new PID NS'
# # [2448] Trying clone3() with flags 0x20000000 (size 64)
# # I am the parent (2448). My child's pid is 2454
# # I am the child, my PID is 1
# # [2448] clone3() with flags says: 0 expected 0
# ok 14 CLONE_ARGS_SIZE_VER0 in a new PID NS
# # Running test 'CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS'
# # [2448] Trying clone3() with flags 0x20000000 (size 56)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 15 CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS
# # Running test 'sizeof(struct clone_args) + 8 in a new PID NS'
# # [2448] Trying clone3() with flags 0x20000000 (size 104)
# # I am the parent (2448). My child's pid is 2455
# # I am the child, my PID is 1
# # [2448] clone3() with flags says: 0 expected 0
# ok 16 sizeof(struct clone_args) + 8 in a new PID NS
# # Running test 'Arguments > page size in a new PID NS'
# # [2448] Trying clone3() with flags 0x20000000 (size 4104)
# # Argument list too long - Failed to create new process
# # [2448] clone3() with flags says: -7 expected -7
# ok 17 Arguments > page size in a new PID NS
# # Running test 'New time NS'
# # [2448] Trying clone3() with flags 0x80 (size 0)
# # I am the parent (2448). My child's pid is 2456
# # I am the child, my PID is 2456
# # [2448] clone3() with flags says: 0 expected 0
# ok 18 New time NS
# # Running test 'exit signal (SIGCHLD) in flags'
# # [2448] Trying clone3() with flags 0x11 (size 0)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -22
# ok 19 exit signal (SIGCHLD) in flags
# # Shadow stack not supported
# ok 20 # SKIP Shadow stack on system with shadow stack
# # Shadow stack not supported
# ok 21 # SKIP Shadow stack with misaligned address
# # Shadow stack not supported
# ok 22 # SKIP Shadow stack with normal memory
# # Shadow stack not supported
# ok 23 # SKIP Shadow stack with no token
# # Running test 'Shadow stack on system without shadow stack'
# # [2448] Trying clone3() with flags 0x100 (size 0)
# # Invalid argument - Failed to create new process
# # [2448] clone3() with flags says: -22 expected -14
# # [2448] Result (-22) is different than expected (-14)
# not ok 24 Shadow stack on system without shadow stack
# # 4 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# # Totals: pass:19 fail:1 xfail:0 xpass:0 skip:4 error:0
not ok 1 selftests: clone3: clone3 # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250930/202509301454.adc93851-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


