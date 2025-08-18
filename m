Return-Path: <linux-kernel+bounces-772758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DB7B2972C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721FD4E4F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7D259C9C;
	Mon, 18 Aug 2025 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEDVf9iM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1000211A11
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485891; cv=fail; b=fuAhTKpQPyDpdEbbnAVwGaXL64MFeMds3k/U5CRdDwDQjFL0ZQfmpFr9dIkvpuJOGvrPyZ2vdF5g8H5DTg4nKgBAfIYVXYUV8AjsF6lz74Xb8bWMLRYEG3FJ67HSyi5+p2La9WoU0YUyqzc4ZEt+K+zbJWyJbtLvTPc+xddEPMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485891; c=relaxed/simple;
	bh=Ar6MyQRSdWdPqB/IjixhgpfOlyUzW2Ajm/T1QKWtNxw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Iss6LnWruGomXYexrxzH6A9SQ4hygkN/2HGe4lXWekTxkNW8AYdRQb3KOOwzIuHggAx40mwUF++axZF+v7u+SKtp6kdBeJ4SL7PGfxvT/3LgG6uak3WpFNWkmpKiIVx+SbAiR58I9cd3ZC8PpTjugYQBr9a/M56uGwQwWH+0LRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEDVf9iM; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755485887; x=1787021887;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Ar6MyQRSdWdPqB/IjixhgpfOlyUzW2Ajm/T1QKWtNxw=;
  b=gEDVf9iMYLSkvMMFJaUqKZGFYa9VFYF1udTvIOEdzWxWMp7P7H9JZKDH
   RHe3bnG4rC1oTXSiUwx9BSv+uuNC7aazAzEFAVcf2UwDz0rJYiFo7fuKI
   h8wHQ/8KNFzzx9mFnISnlPXunjvaY/HTfEdg5N2YjbmKa1C8AtB1/ER/O
   7sckon6jILIXF9AVLaUqYVd7KowYdW/rFrBilypIakneczNIwDAj5nXF6
   ByGxWnq3nDUO6mB16kdhPiqAtKNwXJ0+JlDvtmHmhwPIF3ivtYJyMVg6L
   xxzEfXNSOgIaJ4ebGLfyzmlaueh2rME694LLsFyD9kCNBU7zmiGAfzlVZ
   w==;
X-CSE-ConnectionGUID: TqZp0awrQ7aFuHf4CmZyaw==
X-CSE-MsgGUID: o7IgJJQXQLqHTPfJ7D31sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="75268976"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="75268976"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:58:06 -0700
X-CSE-ConnectionGUID: YDeeSXgVSzy2CTf1b1/X7A==
X-CSE-MsgGUID: 1Zq8Ib6PTWmAL2YZoNN1XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167435413"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:58:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:58:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 19:58:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMBEdURfqQWtUI+Jvb+sNfj3Znd83qP+ANuhloAthEfVBiuPxvhuT5HzYd1PhCjBFpQ4T3OpnzniY4qiMsreACwcqPGerWAQsDLnujjnm2smCj5wRP+pH7aNyeMRUuyg/agBem0bq+em19CI+vJoVDoXNjwk79yaPr2lMtxv26ZDKh/HF+KV+I2uRo6+A5Wk6xYo18MCwJBE0hfFADP7+sLXGWHAMtsWaenSVzxwzROM/f36Rqc3qc+2ji9Nj9ajweWT6M0I4NYZ/Hnsmzsur5b3fAFI7dD3WB4ust2SqVHKS5yrdxhcrcf0n06Xu+PJe6W3lYdzf6ZHRE3p0cSRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCRYWwZBTdhkcdD8OpkgyTc58wA43EdbR4IE8GwoW3I=;
 b=oMiK3PCzzxj7805BwEBOvZzwgpV0yJO3V1izocmNGfbs0a3XgjRp/tvHcpGAmjA8NnnlEVwCRWtpxNHUw6lHAiuQDSzZwY/wmEd3cVCKa8+faZJxFkbSnkdA1Gk28ifX3IrsS1rkfnvs6vvd81IzoGkQEIeXodJq+m65gIKhG+DFduNzUy5eD2hh3arC6GrNFLUeRrdGcU8bskyv3QSDKPT+4+E/l9VnEddTWDSnLxA7LDyYpKKSpszteNucV8RQLz3i5nyvU9hc8muC1E/1XgDcNvXzBxbSo13tRe09Tr0TBZ71LRV38SzePj1y9HhiC6kqoQTK4NtXyh03RmEqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 02:57:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 02:57:56 +0000
Date: Mon, 18 Aug 2025 10:57:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [x86/mm]  1701771d30:  will-it-scale.per_thread_ops
 48.5% improvement
Message-ID: <202508180417.950a8478-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 72113d11-2369-4d5e-09b8-08ddde030817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Fhko6gIExxnEzrl89u+zjt3vD6OPEOLi2SusgMFVymHGCA7mAfgx6mT3Rb?=
 =?iso-8859-1?Q?WpqGbFg+9RYfqFoU8jXEgNCcnFbG00FX8bTOdjN8LgPenUurNmxPc90YSq?=
 =?iso-8859-1?Q?u2aNdWHIL3+MAe4VTJkpbC2MRkNunIxBdr0Zvu4LfskciX4zV6AKNUfDdK?=
 =?iso-8859-1?Q?2hdKeBDHa41SA765dTiLOkKRGCMM1P/gOlLuFtYV9HnePEx8RaA4yNtwVQ?=
 =?iso-8859-1?Q?aI2/4OcUv1IpC5l+FgBFFQDm/rP4t/lb8inxqKxHkd7HZDWbXoh2TtDi/O?=
 =?iso-8859-1?Q?TJBsrvhpuO55OKx7zmjSPr0dbzOQ4BGB7RHWC2Bk1oZ7aFeRxKOm+aqtkH?=
 =?iso-8859-1?Q?ldYMqBmrtMuyQIeoyp21M6OGFhqsZcVXpCEkIMty9nWunv3c26fWhmPmcQ?=
 =?iso-8859-1?Q?e16x856VCTpnRCCyLk+OSF5Su7uunkG0YTHPRBnOEitgStSrOadcD/OB6n?=
 =?iso-8859-1?Q?VT1tMZyeDzJw4dm5blA11LNo4XGGEd0U0CEyKv5Mc2kQZ1Iola7KVjncAe?=
 =?iso-8859-1?Q?Naf7+KWVr6cU6lYQgEB0b1F9DGGmF/iDxRU7lOeMdIjfMLklE36u7bhDno?=
 =?iso-8859-1?Q?z2x97B2iHhJUw7zisiv3ahNXIJGDsNnzkMSTDc466b/j4AivsPl3p+e/5r?=
 =?iso-8859-1?Q?cxi0n+EtsWeQNqgtNGmVgITotDc0tfi3OGd6ebJicyEO3soht7BIt2fSCn?=
 =?iso-8859-1?Q?WE7tBGHfnuaEyJUAKJ5oSzdyvxu7Jaki9ZTVJPe7md8zRyWuF3O+T6az3q?=
 =?iso-8859-1?Q?Ye7aR18I48XiATV8NIxXIx3hgmIiOp1qiApRBC0GzlCbk3i/WQZO0l8b3L?=
 =?iso-8859-1?Q?QEBIipimRX5zQ+mdiPflAx5sQ40XJXIbGjjiZAtIDE9wOIDzZQQ6FKySBZ?=
 =?iso-8859-1?Q?4QPtNx34GAysxCKn4APmNPghCTdCvP6Od0DfzctxOnNgxCpZ1ule/2umIC?=
 =?iso-8859-1?Q?LKLwqnkRFWe4W2uAhgei+HSGkTGdqciqwXYSnU3WtrDfFjDEK8uledwHac?=
 =?iso-8859-1?Q?UGmk0aNmSbnMCwp/6RJt8wQdCUg8rUFCiDpYgg95BNFiyPllKiURVcKAjD?=
 =?iso-8859-1?Q?GLD8vc4DM6bnCCmdBbqPfS5zERbWfmfrQyitV8qJ8CzErg1w+5Z3R4rVpg?=
 =?iso-8859-1?Q?NsN+3+T2NyPpWAo7hFxmLtbZP53WGsAxcBwiEnLGipKo8jF48rvlvm233f?=
 =?iso-8859-1?Q?6ilevnlD0naTkOXrFw5LWQP/aMfSqa/9k39miHYWaU6Hoe9i2Bdlh+q+y9?=
 =?iso-8859-1?Q?Mxld1ylBUYbnsmuSTo0ldQGXh0RzEFJHjATYxtTyODfuqjW54V+JluOgTt?=
 =?iso-8859-1?Q?PXdNulDkSQkty5XXJYnWUetcsMaIdy1dX3r1OJoO0vLxBYlv9+lbFcn7Ks?=
 =?iso-8859-1?Q?zYi4sQu4b7vZoxuJSFos5k1vCBhyhp+1cHCGJSVvl+pDrIK8bORJZcsReT?=
 =?iso-8859-1?Q?LXUrWS+NVSMxbYcL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QPJem5/JrS0nbPz4gxIZIlT+V8id9/mWQOhCKmzV79vQmPn7CuiJR2xl0o?=
 =?iso-8859-1?Q?mSA2nMeadQovVdsSZcGIPawFq1XJGl8/89f8/ZCHOxANIZvbgNPW5Qd3u8?=
 =?iso-8859-1?Q?9rNIJt7wvLFWyrI90OUwdF25D//aVEDnlZ5CAxLUU6h7hmjnH+eTG+RG9g?=
 =?iso-8859-1?Q?KRGmY2HbHxKSoOWCHqD9fFU6jh8PY971GzQXX0rteA8f3aGzw2Mb8MUAW4?=
 =?iso-8859-1?Q?9w/Mfbwj3/urq8Hd03Dszj74uuSDa6dMX+oFBnqGC/eSyM08hL0lGqP86P?=
 =?iso-8859-1?Q?1UEt0sjvUZZHQg4sXZ5bTMgdS7shS3DeLpgZApQJjT3sKTID9783Z5UTCe?=
 =?iso-8859-1?Q?JJ+TQMubNtklqTy2onF90KvN2me5dUHBAdm9s+JsbQXL7qscREqNDb4+rH?=
 =?iso-8859-1?Q?JwgT+fHraiJN+ZPd01wTROAq8nO7K4St2U7Fx2UwRZMSdd+CTuWoqZwdpI?=
 =?iso-8859-1?Q?yrDlQhGKJjjBtRy2j/OsEjAEW0d5ic00O+ShyvrGAXMYJVBFNrMJNHNk0O?=
 =?iso-8859-1?Q?ZuCOHmnITMBEKILFCwiJUFLqswZWsT2+hnf9HN0KigBLcfqQPV3sP6+Kyz?=
 =?iso-8859-1?Q?dXNKgqAo/7DB1zyZjz1vmFJC5+c4xylRHEVq3Eo/w3J0Vcl4g7qfu9sjwV?=
 =?iso-8859-1?Q?IE7BnT63nieJiKSDEtHd9QsoEgK4LBK1jDxeEHluk4oQl/UNKXmmbEoNQw?=
 =?iso-8859-1?Q?8pu9+qFeAAHJVCjJ4aWD0cJ9oMgCkHCxRMvsHvnueUeG+03EQsMpsEO0BK?=
 =?iso-8859-1?Q?5/VEvN+7hdPYqyX78Zo+IMzk+vl+53Z5oHU5EK+Lf+ig5DQkzqBB+x3rpx?=
 =?iso-8859-1?Q?1SabXR46zZE1so6u5yjI1W3EMlLiakSVS4/GDHeFSVRDd4WrTtbfLUdT2f?=
 =?iso-8859-1?Q?QrTwp1DKFDI0dhKWZR46/gTkz6KFJoMrIhHLV2EZewyMU7BPHcyo3EzSBo?=
 =?iso-8859-1?Q?JKUmZlZNXac3o1HrjOR/EpqAnzUem4d7jA9ZiyFxQCcalvBU3CU57raOlD?=
 =?iso-8859-1?Q?eyPd9HKoOadypAqlh4wHzDin/Yr6R2PdhpJbELq9y3b9W6Py+28quodmxQ?=
 =?iso-8859-1?Q?q9nZkijv1iqLyjoblSCCzTXG6ighMYRu+s+KaUMpILh6Cu8TcW3BvbCaij?=
 =?iso-8859-1?Q?NklSOywwncqJt0ZK/9Duj00JCZI3xOOIaF8dyEYG8thEgzXVozZX4fNnM1?=
 =?iso-8859-1?Q?k4Le/sbH//OCoIRZykNRy49cMAWblxr1aaWSsRKZi5otppxeDCZMms83qb?=
 =?iso-8859-1?Q?efX6WhGRtYmC9WWcQSzDQcgl3jHPqZiVAn1gClPSqRT4oY9fMvmltpIJui?=
 =?iso-8859-1?Q?2Vvlw6Spkgn8Nevp4PynqV00xZN0oAiDycOHABCDr5G/x6GboR93Wh1ozW?=
 =?iso-8859-1?Q?0ajZ+b69nIvQ271o2ki6KWHwhWc8BC+pPtqjzfbHejq0SftrkGQncwzsZw?=
 =?iso-8859-1?Q?iDXKUUAb9GdlxcMXEzE/oQsjQ+22ctmSmdx64eWLXORMpoFcOvaOQ8nkkp?=
 =?iso-8859-1?Q?89VhQ28wVe0+BDIWpnNvxpFmqfIJycAbn8778h4cDdsm7m3nIJq/ISYIEB?=
 =?iso-8859-1?Q?5MsntDoaTpP3RmX6ZBBuoG6fzOj9t08DaMX+M8t61owTSP7PE/55lH/2um?=
 =?iso-8859-1?Q?8F53fDpXLgJ384VxDF8JaUZQksNp7OsjXAaaF/ioPXSU2qV/Qx3pDwdQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72113d11-2369-4d5e-09b8-08ddde030817
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:57:56.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NY4evLpdLedHZG823wFj3tVoHjhxaksF6YCy3tbSIqkCcfhXzTQU4J2ICxM0zUIi/ZCPFSVwzSjqt4Favw1W4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 48.5% improvement of will-it-scale.per_thread_ops on:


commit: 1701771d3069fbee154ca48e882e227fdcfbb583 ("x86/mm: Stop prefetching current->mm->mmap_lock on page faults")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: page_fault2
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508180417.950a8478-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2sp3/page_fault2/will-it-scale

commit: 
  2b00d9031e ("x86/mm: Simplify the pgd_leaf() and p4d_leaf() checks a bit")
  1701771d30 ("x86/mm: Stop prefetching current->mm->mmap_lock on page faults")

2b00d9031e42eabc 1701771d3069fbee154ca48e882 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 5.913e+10           +17.4%  6.941e+10        cpuidle..time
   3370993 ±  2%     +41.4%    4766543 ±  2%  cpuidle..usage
  19769205           +20.1%   23748643        meminfo.AnonPages
     44703           +21.9%      54498        meminfo.PageTables
    136314 ±  5%     -20.7%     108055 ± 12%  perf-c2c.DRAM.local
    974.50 ±  9%     -70.3%     289.50 ± 33%  perf-c2c.DRAM.remote
      2764 ±  7%     -31.6%       1890 ± 15%  perf-c2c.HITM.local
  6.05e+08 ±  2%     +42.7%  8.637e+08 ±  2%  numa-numastat.node0.local_node
 6.052e+08 ±  2%     +42.7%  8.638e+08 ±  2%  numa-numastat.node0.numa_hit
 6.131e+08           +52.6%  9.354e+08 ±  3%  numa-numastat.node1.local_node
 6.132e+08           +52.6%  9.355e+08 ±  3%  numa-numastat.node1.numa_hit
   3928360           +48.5%    5833482 ±  2%  will-it-scale.256.threads
     74.24           +17.5%      87.20        will-it-scale.256.threads_idle
     15344           +48.5%      22786 ±  2%  will-it-scale.per_thread_ops
   3928360           +48.5%    5833482 ±  2%  will-it-scale.workload
     74.52           +17.2%      87.36        vmstat.cpu.id
     16.78           -98.8%       0.20 ± 21%  vmstat.cpu.us
     61.54 ± 13%     -47.7%      32.18 ±  7%  vmstat.procs.r
      3023            +4.6%       3163        vmstat.system.cs
    115235 ±  2%     -41.7%      67188 ±  3%  vmstat.system.in
     74.36           +12.9       87.29        mpstat.cpu.all.idle%
      0.79 ±  3%      -0.7        0.06 ± 10%  mpstat.cpu.all.irq%
      0.12 ± 41%      -0.1        0.04 ±  9%  mpstat.cpu.all.soft%
      7.83 ±  2%      +4.4       12.21 ±  2%  mpstat.cpu.all.sys%
     16.91           -16.5        0.41 ±  4%  mpstat.cpu.all.usr%
     61.20 ±  5%     -48.2%      31.71 ± 20%  mpstat.max_utilization_pct
  10070130 ±  8%     +14.3%   11509329 ±  2%  numa-meminfo.node0.AnonPages
  14937073 ±  8%     +14.4%   17087403        numa-meminfo.node0.AnonPages.max
  35036784 ±  4%      +4.1%   36489338 ±  4%  numa-meminfo.node0.MemUsed
     22343 ±  6%     +15.7%      25852 ±  2%  numa-meminfo.node0.PageTables
   9687239 ±  7%     +26.3%   12238707        numa-meminfo.node1.AnonPages
  15642580 ±  2%     +10.4%   17273432        numa-meminfo.node1.AnonPages.max
     22363 ±  6%     +28.6%      28761        numa-meminfo.node1.PageTables
   2511699 ±  6%     +14.0%    2863139        numa-vmstat.node0.nr_anon_pages
      5608 ±  5%     +14.6%       6426 ±  3%  numa-vmstat.node0.nr_page_table_pages
 6.052e+08 ±  2%     +42.7%  8.638e+08 ±  2%  numa-vmstat.node0.numa_hit
  6.05e+08 ±  2%     +42.7%  8.637e+08 ±  2%  numa-vmstat.node0.numa_local
   2455910 ±  8%     +24.3%    3053806        numa-vmstat.node1.nr_anon_pages
      5574 ±  7%     +29.0%       7190        numa-vmstat.node1.nr_page_table_pages
 6.132e+08           +52.6%  9.355e+08 ±  3%  numa-vmstat.node1.numa_hit
 6.131e+08           +52.6%  9.354e+08 ±  3%  numa-vmstat.node1.numa_local
  13334066            +6.8%   14234561        proc-vmstat.nr_active_anon
   4960815           +18.8%    5893088        proc-vmstat.nr_anon_pages
   4672730            -1.1%    4622722        proc-vmstat.nr_dirty_background_threshold
   9356886            -1.1%    9256748        proc-vmstat.nr_dirty_threshold
  47078351            -1.1%   46577473        proc-vmstat.nr_free_pages
     19725            -3.5%      19043        proc-vmstat.nr_mapped
     11202           +21.6%      13625        proc-vmstat.nr_page_table_pages
  13334065            +6.8%   14234561        proc-vmstat.nr_zone_active_anon
 1.218e+09           +47.7%  1.799e+09 ±  2%  proc-vmstat.numa_hit
 1.218e+09           +47.7%  1.799e+09 ±  2%  proc-vmstat.numa_local
 1.218e+09           +47.7%  1.799e+09 ±  2%  proc-vmstat.pgalloc_normal
 1.206e+09           +48.0%  1.785e+09 ±  2%  proc-vmstat.pgfault
 1.218e+09           +47.7%  1.799e+09 ±  2%  proc-vmstat.pgfree
 3.954e+09           +67.9%  6.638e+09 ±  2%  perf-stat.i.branch-instructions
      0.13            -0.0        0.09        perf-stat.i.branch-miss-rate%
   5323407           +14.9%    6115620 ±  2%  perf-stat.i.branch-misses
     87.84            +2.4       90.28        perf-stat.i.cache-miss-rate%
   4.8e+08 ±  4%     +63.2%  7.832e+08 ±  2%  perf-stat.i.cache-misses
 5.455e+08 ±  4%     +58.2%  8.632e+08 ±  3%  perf-stat.i.cache-references
      2974            +5.1%       3126        perf-stat.i.context-switches
     11.51 ±  2%     -71.9%       3.24 ±  2%  perf-stat.i.cpi
 2.373e+11 ±  2%     -52.5%  1.126e+11 ±  4%  perf-stat.i.cpu-cycles
    301.57            -1.7%     296.57        perf-stat.i.cpu-migrations
    497.20 ±  3%     -71.1%     143.47 ±  3%  perf-stat.i.cycles-between-cache-misses
 2.078e+10           +62.3%  3.373e+10 ±  2%  perf-stat.i.instructions
      0.09 ±  4%    +250.8%       0.33 ±  2%  perf-stat.i.ipc
      0.01 ± 40%     +84.3%       0.01 ± 53%  perf-stat.i.major-faults
     30.61           +47.6%      45.17 ±  3%  perf-stat.i.metric.K/sec
   3917924           +47.6%    5782141 ±  3%  perf-stat.i.minor-faults
   3917924           +47.6%    5782140 ±  3%  perf-stat.i.page-faults
   3047437           -66.2%    1030826 ± 47%  sched_debug.cfs_rq:/.avg_vruntime.avg
   5427213 ± 17%     -74.4%    1389422 ± 47%  sched_debug.cfs_rq:/.avg_vruntime.max
   1285704 ± 21%     -45.0%     707277 ± 49%  sched_debug.cfs_rq:/.avg_vruntime.min
    555322 ± 16%     -75.0%     138863 ± 48%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.20 ± 25%     -41.7%       0.12 ± 30%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.33 ± 16%     -22.9%       0.26 ± 10%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.20 ± 25%     -42.2%       0.12 ± 30%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.33 ± 16%     -24.5%       0.25 ±  9%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    272.40 ±  7%     +65.7%     451.23 ± 30%  sched_debug.cfs_rq:/.load_avg.max
   3047437           -66.2%    1030826 ± 47%  sched_debug.cfs_rq:/.min_vruntime.avg
   5427213 ± 17%     -74.4%    1389422 ± 47%  sched_debug.cfs_rq:/.min_vruntime.max
   1285704 ± 21%     -45.0%     707277 ± 49%  sched_debug.cfs_rq:/.min_vruntime.min
    555322 ± 16%     -75.0%     138863 ± 48%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.20 ± 25%     -41.8%       0.12 ± 30%  sched_debug.cfs_rq:/.nr_queued.avg
      0.33 ± 16%     -23.1%       0.26 ± 10%  sched_debug.cfs_rq:/.nr_queued.stddev
    230.01 ± 18%     -63.8%      83.17 ± 50%  sched_debug.cfs_rq:/.runnable_avg.avg
    981.10 ±  3%     -23.7%     748.65 ± 19%  sched_debug.cfs_rq:/.runnable_avg.max
    317.68 ± 15%     -56.9%     136.82 ± 31%  sched_debug.cfs_rq:/.runnable_avg.stddev
    229.80 ± 18%     -63.9%      83.04 ± 50%  sched_debug.cfs_rq:/.util_avg.avg
    978.93 ±  3%     -23.7%     747.37 ± 19%  sched_debug.cfs_rq:/.util_avg.max
    317.59 ± 15%     -57.0%     136.72 ± 32%  sched_debug.cfs_rq:/.util_avg.stddev
    131.29 ± 26%     -55.4%      58.51 ± 54%  sched_debug.cfs_rq:/.util_est.avg
    214.02 ± 20%     -42.7%     122.60 ± 40%  sched_debug.cfs_rq:/.util_est.stddev
   1395005 ±  5%     -29.1%     989638        sched_debug.cpu.avg_idle.avg
   3221791 ±  8%     -52.4%    1534179 ±  9%  sched_debug.cpu.avg_idle.max
    427812 ±  8%     -77.9%      94534 ±  9%  sched_debug.cpu.avg_idle.stddev
      2320 ± 32%     -57.2%     993.54 ± 25%  sched_debug.cpu.clock_task.stddev
      1173 ± 27%     -41.0%     692.07 ± 29%  sched_debug.cpu.curr->pid.avg
      1994 ± 15%     -24.8%       1500 ±  8%  sched_debug.cpu.curr->pid.stddev
    708029 ±  5%     -29.0%     502887        sched_debug.cpu.max_idle_balance_cost.avg
   1613573 ±  9%     -52.5%     765980 ±  9%  sched_debug.cpu.max_idle_balance_cost.max
    198344 ±  9%     -88.7%      22491 ± 23%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.19 ± 28%     -40.4%       0.11 ± 31%  sched_debug.cpu.nr_running.avg
      0.32 ± 17%     -23.7%       0.25 ± 12%  sched_debug.cpu.nr_running.stddev
      1207           +14.5%       1382 ±  8%  sched_debug.cpu.nr_switches.min
      0.04 ± 84%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      0.02 ± 10%     -43.2%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      0.04 ± 25%     -85.0%       0.01 ±101%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.04 ± 26%     -97.3%       0.00 ±152%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      1.24 ±206%     -97.6%       0.03 ± 57%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_fault.__do_fault.do_pte_missing
      0.04 ± 14%     -71.6%       0.01 ± 47%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      0.07 ±149%     -85.3%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.06 ± 39%     -68.0%       0.02 ± 21%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.06 ± 43%     -70.9%       0.02 ± 19%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.14 ± 51%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
      0.16 ± 27%     -98.2%       0.00 ±144%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.04 ± 25%     -89.7%       0.00 ±141%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 55%     -50.6%       0.02 ± 13%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.09 ± 52%     -75.0%       0.02 ± 61%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.55 ±209%     -97.5%       0.01 ± 24%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
      0.06 ± 21%     -78.8%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ± 15%     -87.2%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.19 ±185%     -94.3%       0.01 ± 21%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 38%     -55.8%       0.00 ± 27%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.12 ±  8%     -38.3%       0.08 ± 13%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      0.08 ± 20%     -92.2%       0.01 ±101%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.07 ± 26%     -98.5%       0.00 ±152%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.07 ± 16%     -82.9%       0.01 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
      6.54 ±219%     -99.6%       0.03 ± 28%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.12 ± 43%     -71.6%       0.03 ± 22%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.19 ± 47%     -72.4%       0.05 ± 69%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.06 ± 84%     -58.3%       0.02 ± 13%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.22 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
      5.82 ±185%    -100.0%       0.00 ±144%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.07 ± 24%     -94.3%       0.00 ±142%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.13 ± 73%     -67.8%       0.04 ± 22%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.00 ±100%     -82.4%       0.18 ±137%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.23 ± 13%     -90.7%       0.02 ± 29%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      3.13 ±214%     -99.3%       0.02 ± 42%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.12 ± 56%     -70.3%       0.04 ± 32%  perf-sched.total_sch_delay.average.ms
    262.31           +10.9%     290.96        perf-sched.total_wait_and_delay.average.ms
    262.19           +11.0%     290.93        perf-sched.total_wait_time.average.ms
    499.26 ± 19%     +40.1%     699.36 ± 14%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     17.83 ±  5%     -15.1%      15.14 ±  6%  perf-sched.wait_and_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
    161.82 ± 26%     +67.9%     271.76 ±  8%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    462.11 ±  8%     +34.9%     623.54 ±  6%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    115.67 ± 12%    +121.8%     256.50 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     10.17 ± 15%     -95.1%       0.50 ±152%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    112.67 ±  8%     +68.3%     189.67 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      1394 ±  2%     +22.8%       1712 ±  5%  perf-sched.wait_and_delay.count.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
    184.33 ± 17%    +107.1%     381.67 ± 21%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    437.33 ± 20%     -97.2%      12.17 ± 86%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    436.67 ±  5%     +55.6%     679.50 ±  3%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma
    808.33 ±  2%     +36.9%       1106 ±  5%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
    237.00 ±  4%     -42.2%     137.00 ± 12%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      2621 ± 13%     -35.1%       1701 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1054 ±  5%     -74.0%     274.36 ±145%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      1164 ±  6%     -39.5%     704.00 ± 71%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    178.53 ± 14%     +70.2%     303.93 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.do_pte_missing
    390.81 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
    463.43 ± 68%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
    499.20 ± 19%     +40.1%     699.34 ± 14%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     17.83 ±  5%     -15.1%      15.14 ±  6%  perf-sched.wait_time.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
    161.65 ± 26%     +68.1%     271.67 ±  8%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    139.96 ± 12%    +132.7%     325.65 ± 26%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     41.88 ±135%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
      5.07 ±  5%     -88.3%       0.59 ±153%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    462.07 ±  8%     +34.9%     623.53 ±  6%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    625.97 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      1054 ±  5%     -73.9%     274.99 ±145%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    775.43 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
    672.09 ± 69%     -75.2%     166.69 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    103.59 ±135%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function.[unknown]
    995.46 ± 38%     -91.2%      87.31 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      6.13 ±  5%     -83.5%       1.01 ±177%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.56 ±  2%      +0.2        0.78 ± 15%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_fault.__do_fault.do_pte_missing.__handle_mm_fault
      0.64 ±  2%      +0.2        0.86 ± 16%  perf-profile.calltrace.cycles-pp.shmem_fault.__do_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      0.69 ±  2%      +0.3        0.96 ± 15%  perf-profile.calltrace.cycles-pp.__do_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.87 ±  2%      +0.5        1.39 ± 24%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.__folio_mod_stat.folio_add_new_anon_rmap.set_pte_range.finish_fault
      0.90 ±  2%      +0.5        1.44 ± 24%  perf-profile.calltrace.cycles-pp.__folio_mod_stat.folio_add_new_anon_rmap.set_pte_range.finish_fault.do_pte_missing
      0.60 ±  4%      +0.6        1.20 ± 17%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof
      0.62 ±  3%      +0.6        1.22 ± 12%  perf-profile.calltrace.cycles-pp.lru_add.folio_batch_move_lru.folio_add_lru.set_pte_range.finish_fault
      0.67 ±  3%      +0.6        1.28 ± 12%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
      1.00 ±  2%      +0.6        1.62 ± 23%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.set_pte_range.finish_fault.do_pte_missing.__handle_mm_fault
      0.93 ±  3%      +0.7        1.61 ± 16%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.do_pte_missing
      0.00            +0.7        0.68 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
      0.00            +0.7        0.70 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      0.00            +0.7        0.70 ±  9%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +0.7        0.71 ± 17%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.07 ±  3%      +0.8        1.84 ± 16%  perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.vma_alloc_folio_noprof.do_pte_missing.__handle_mm_fault
      1.16 ±  3%      +0.8        1.97 ± 15%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol.vma_alloc_folio_noprof.do_pte_missing.__handle_mm_fault.handle_mm_fault
      0.94 ±  3%      +0.8        1.75 ± 13%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      1.00 ±  3%      +0.9        1.87 ± 13%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      1.00 ±  3%      +0.9        1.88 ± 13%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
      1.00 ±  3%      +0.9        1.88 ± 13%  perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.9        0.90 ± 11%  perf-profile.calltrace.cycles-pp.lru_gen_add_folio.lru_add.folio_batch_move_lru.folio_add_lru.set_pte_range
      1.25 ±  3%      +0.9        2.16 ± 15%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +1.0        0.96 ± 19%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      1.68 ±  3%      +1.3        3.02 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.68 ±  3%      +1.3        3.02 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.63 ±  3%      +1.4        3.00 ± 14%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.63 ±  3%      +1.4        3.00 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.60 ±  3%      +1.4        2.98 ± 14%  perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     13.86 ±100%      +1.6       15.41 ±223%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     12.87 ±100%      +2.1       14.94 ±223%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     12.82 ±100%      +2.1       14.91 ±223%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     11.46 ±100%      +3.2       14.63 ±223%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.24 ±  3%      +5.0        7.26 ± 19%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__pte_offset_map_lock.finish_fault.do_pte_missing.__handle_mm_fault
      2.37 ±  3%      +5.1        7.52 ± 19%  perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.finish_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
      8.66 ±  2%      +6.9       15.54 ± 18%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      5.06 ± 15%     +48.4       53.51 ± 13%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      5.13 ± 15%     +48.4       53.58 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.set_pte_range
      5.14 ± 15%     +48.5       53.59 ± 13%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.set_pte_range.finish_fault
      6.11 ± 13%     +49.2       55.32 ± 12%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.set_pte_range.finish_fault.do_pte_missing
      6.26 ± 12%     +49.3       55.58 ± 12%  perf-profile.calltrace.cycles-pp.folio_add_lru.set_pte_range.finish_fault.do_pte_missing.__handle_mm_fault
      7.32 ± 10%     +50.0       57.35 ± 11%  perf-profile.calltrace.cycles-pp.set_pte_range.finish_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault
     10.33 ±  7%     +55.1       65.45 ±  7%  perf-profile.calltrace.cycles-pp.finish_fault.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     22.16 ±  3%     +63.1       85.25 ±  2%  perf-profile.calltrace.cycles-pp.do_pte_missing.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     22.56 ±  3%     +63.3       85.88 ±  2%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     65.96 ±  2%     -63.9        2.08 ± 24%  perf-profile.children.cycles-pp.native_irq_return_iret
      3.55 ±  2%      -3.0        0.59 ± 15%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.00 ±  2%      -2.6        0.40 ± 19%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.89 ±  2%      -2.6        0.28 ± 23%  perf-profile.children.cycles-pp.update_process_times
      3.01 ±  2%      -2.6        0.40 ± 20%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.79 ±  2%      -2.6        0.19 ± 30%  perf-profile.children.cycles-pp.sched_tick
      2.92 ±  2%      -2.6        0.32 ± 23%  perf-profile.children.cycles-pp.tick_nohz_handler
      2.92 ±  2%      -2.6        0.33 ± 22%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      3.06 ±  2%      -2.6        0.48 ± 17%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.35 ±  6%      -1.6        0.75 ± 18%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.43 ± 26%      -0.3        0.14 ± 13%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.46 ± 25%      -0.3        0.17 ± 15%  perf-profile.children.cycles-pp.handle_internal_command
      0.46 ± 25%      -0.3        0.17 ± 15%  perf-profile.children.cycles-pp.main
      0.46 ± 25%      -0.3        0.17 ± 15%  perf-profile.children.cycles-pp.run_builtin
      0.42 ± 26%      -0.3        0.14 ± 12%  perf-profile.children.cycles-pp.perf_mmap__push
      0.44 ± 25%      -0.3        0.16 ± 12%  perf-profile.children.cycles-pp.__cmd_record
      0.44 ± 25%      -0.3        0.16 ± 12%  perf-profile.children.cycles-pp.cmd_record
      0.34 ± 10%      -0.2        0.10 ± 14%  perf-profile.children.cycles-pp.down_read_trylock
      0.28 ± 29%      -0.2        0.09 ± 12%  perf-profile.children.cycles-pp.record__pushfn
      0.28 ± 29%      -0.2        0.09 ± 12%  perf-profile.children.cycles-pp.writen
      0.28 ± 29%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.write
      0.25 ± 29%      -0.2        0.08 ±  8%  perf-profile.children.cycles-pp.ksys_write
      0.24 ± 29%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.vfs_write
      0.23 ± 28%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.21 ± 29%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.generic_perform_write
      0.18 ±  7%      -0.1        0.05 ± 50%  perf-profile.children.cycles-pp.__vmf_anon_prepare
      0.13 ±  9%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.__schedule
      0.11 ±  9%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.schedule
      0.07 ± 10%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.__pick_next_task
      0.07 ±  5%      +0.0        0.10 ± 12%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.06            +0.0        0.10 ± 17%  perf-profile.children.cycles-pp.__cond_resched
      0.05            +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.policy_nodemask
      0.06            +0.0        0.10 ± 17%  perf-profile.children.cycles-pp.folio_unlock
      0.07            +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.up_read
      0.04 ± 44%      +0.0        0.09 ± 22%  perf-profile.children.cycles-pp.__free_one_page
      0.07 ±  7%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.get_vma_policy
      0.15 ±  3%      +0.1        0.21 ± 18%  perf-profile.children.cycles-pp.__count_memcg_events
      0.06 ±  6%      +0.1        0.12 ± 16%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.06 ±  9%      +0.1        0.12 ± 12%  perf-profile.children.cycles-pp.worker_thread
      0.00            +0.1        0.06 ± 20%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12 ±  4%      +0.1        0.18 ± 22%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.00            +0.1        0.07 ± 18%  perf-profile.children.cycles-pp.perf_exclude_event
      0.13 ± 13%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.kthread
      0.13 ± 13%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      0.13 ± 13%      +0.1        0.20 ± 10%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.access_error
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.perf_swevent_event
      0.05 ±  7%      +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.pte_offset_map_rw_nolock
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.rest_init
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +0.1        0.09 ± 30%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.decay_pcp_high
      0.10 ±  4%      +0.1        0.20 ± 15%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.08 ±  7%      +0.1        0.18 ± 14%  perf-profile.children.cycles-pp.handle_pte_fault
      0.02 ±142%      +0.1        0.12 ± 25%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.vmstat_update
      0.00            +0.1        0.10 ± 14%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.31 ±  3%      +0.1        0.41 ± 15%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.33 ±  6%      +0.1        0.44 ± 20%  perf-profile.children.cycles-pp.charge_memcg
      0.07 ± 19%      +0.1        0.17 ± 19%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.process_one_work
      0.13 ±  7%      +0.1        0.24 ± 18%  perf-profile.children.cycles-pp.free_frozen_page_commit
      0.06 ± 52%      +0.1        0.16 ± 19%  perf-profile.children.cycles-pp.handle_softirqs
      0.07 ±  7%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.___pte_offset_map
      0.01 ±223%      +0.1        0.13 ± 23%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.17 ±  4%      +0.1        0.29 ± 12%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.02 ±142%      +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.11 ±  5%      +0.1        0.25 ± 13%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.16 ±  8%      +0.2        0.31 ± 11%  perf-profile.children.cycles-pp.start_secondary
      0.19 ±  3%      +0.2        0.35 ± 14%  perf-profile.children.cycles-pp.___perf_sw_event
      0.15 ±  4%      +0.2        0.32 ± 16%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.19 ±  6%      +0.2        0.38 ± 18%  perf-profile.children.cycles-pp.free_unref_folios
      0.24 ±  3%      +0.2        0.43 ± 14%  perf-profile.children.cycles-pp.__perf_sw_event
      0.14 ±  9%      +0.2        0.36 ± 13%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.14 ±  9%      +0.2        0.36 ± 13%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.14 ±  9%      +0.2        0.36 ± 13%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.14 ±  7%      +0.2        0.36 ± 14%  perf-profile.children.cycles-pp.cpuidle_enter
      0.14 ±  7%      +0.2        0.36 ± 14%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.18 ±  6%      +0.2        0.40 ± 14%  perf-profile.children.cycles-pp.common_startup_64
      0.18 ±  6%      +0.2        0.40 ± 14%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.18 ±  6%      +0.2        0.40 ± 14%  perf-profile.children.cycles-pp.do_idle
      0.60 ±  4%      +0.2        0.84 ± 14%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.64 ±  2%      +0.2        0.88 ± 15%  perf-profile.children.cycles-pp.shmem_fault
      0.15 ±  9%      +0.2        0.39 ± 14%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.70 ±  2%      +0.3        0.98 ± 15%  perf-profile.children.cycles-pp.__do_fault
      0.26 ±  5%      +0.3        0.56 ± 16%  perf-profile.children.cycles-pp.lru_gen_del_folio
      0.34 ±  5%      +0.4        0.73 ± 17%  perf-profile.children.cycles-pp.zap_present_ptes
      0.18 ±  8%      +0.4        0.57 ± 26%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.53 ±  3%      +0.4        0.97 ± 19%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.48 ±  3%      +0.4        0.92 ± 11%  perf-profile.children.cycles-pp.lru_gen_add_folio
      0.90 ±  2%      +0.5        1.45 ± 24%  perf-profile.children.cycles-pp.__folio_mod_stat
      0.42 ±  7%      +0.6        0.98 ± 19%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.96 ±  2%      +0.6        1.56 ± 23%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.62 ±  3%      +0.6        1.23 ± 12%  perf-profile.children.cycles-pp.lru_add
      0.63 ±  5%      +0.6        1.24 ± 17%  perf-profile.children.cycles-pp.rmqueue
      1.01 ±  2%      +0.6        1.64 ± 23%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.96 ±  4%      +0.7        1.66 ± 16%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.76 ±  3%      +0.7        1.48 ± 11%  perf-profile.children.cycles-pp.__page_cache_release
      1.11 ±  3%      +0.8        1.90 ± 16%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      1.20 ±  3%      +0.9        2.05 ± 15%  perf-profile.children.cycles-pp.alloc_pages_mpol
      1.04 ±  2%      +0.9        1.90 ± 15%  perf-profile.children.cycles-pp.sync_regs
      1.00 ±  3%      +0.9        1.88 ± 13%  perf-profile.children.cycles-pp.tlb_flush_mmu
      1.26 ±  3%      +0.9        2.18 ± 15%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      1.15 ±  3%      +1.0        2.14 ± 13%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      1.15 ±  3%      +1.0        2.14 ± 13%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      1.17 ±  3%      +1.0        2.22 ± 13%  perf-profile.children.cycles-pp.folios_put_refs
      2.00 ±  6%      +1.2        3.19 ± 13%  perf-profile.children.cycles-pp.do_syscall_64
      2.00 ±  6%      +1.2        3.19 ± 13%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.children.cycles-pp.unmap_page_range
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.children.cycles-pp.zap_pmd_range
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.children.cycles-pp.zap_pte_range
      1.41 ±  3%      +1.3        2.70 ± 14%  perf-profile.children.cycles-pp.unmap_vmas
      1.63 ±  3%      +1.4        3.00 ± 14%  perf-profile.children.cycles-pp.__vm_munmap
      1.63 ±  3%      +1.4        3.00 ± 14%  perf-profile.children.cycles-pp.__x64_sys_munmap
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.children.cycles-pp.do_vmi_munmap
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      1.60 ±  3%      +1.4        2.98 ± 13%  perf-profile.children.cycles-pp.vms_clear_ptes
      2.47 ±  2%      +4.9        7.34 ± 19%  perf-profile.children.cycles-pp._raw_spin_lock
      2.38 ±  3%      +5.2        7.54 ± 19%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      8.83 ±  2%      +6.8       15.58 ± 18%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      5.62 ± 13%     +48.8       54.44 ± 13%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      5.74 ± 13%     +49.1       54.81 ± 13%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      5.69 ± 13%     +49.2       54.89 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      6.14 ± 13%     +49.2       55.39 ± 12%  perf-profile.children.cycles-pp.folio_batch_move_lru
      6.28 ± 12%     +49.3       55.62 ± 12%  perf-profile.children.cycles-pp.folio_add_lru
      7.33 ± 10%     +50.0       57.38 ± 11%  perf-profile.children.cycles-pp.set_pte_range
     10.35 ±  7%     +55.1       65.48 ±  7%  perf-profile.children.cycles-pp.finish_fault
     25.89 ±  3%     +62.2       88.06        perf-profile.children.cycles-pp.do_user_addr_fault
     25.96 ±  3%     +62.2       88.15        perf-profile.children.cycles-pp.exc_page_fault
     22.19 ±  3%     +63.1       85.32 ±  2%  perf-profile.children.cycles-pp.do_pte_missing
     22.58 ±  3%     +63.3       85.91 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
     23.12 ±  4%     +63.6       86.68 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
     28.63 ±  4%     +64.9       93.49        perf-profile.children.cycles-pp.asm_exc_page_fault
     65.96 ±  2%     -63.9        2.08 ± 24%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.22 ±  8%      -1.0        0.24 ± 19%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.69            -0.5        0.14 ± 15%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.32 ±  9%      -0.2        0.09 ± 13%  perf-profile.self.cycles-pp.down_read_trylock
      0.05            +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__perf_sw_event
      0.04 ± 45%      +0.0        0.08 ± 15%  perf-profile.self.cycles-pp.free_pcppages_bulk
      0.06 ±  7%      +0.0        0.10 ± 14%  perf-profile.self.cycles-pp.up_read
      0.06 ±  9%      +0.0        0.10 ± 14%  perf-profile.self.cycles-pp.folio_unlock
      0.05 ±  8%      +0.0        0.10 ± 15%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.11 ±  4%      +0.1        0.16 ± 19%  perf-profile.self.cycles-pp.__count_memcg_events
      0.05 ±  8%      +0.1        0.11 ± 18%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.pte_offset_map_rw_nolock
      0.09 ±  5%      +0.1        0.14 ± 12%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.policy_nodemask
      0.10 ±  4%      +0.1        0.16 ± 24%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.20 ±  5%      +0.1        0.25 ± 15%  perf-profile.self.cycles-pp.filemap_get_entry
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.charge_memcg
      0.16 ± 10%      +0.1        0.22 ± 18%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.perf_swevent_event
      0.15            +0.1        0.21 ± 16%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.alloc_pages_mpol
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.access_error
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.free_frozen_page_commit
      0.00            +0.1        0.07 ± 14%  perf-profile.self.cycles-pp.vma_alloc_folio_noprof
      0.10 ±  3%      +0.1        0.17 ± 14%  perf-profile.self.cycles-pp.__alloc_frozen_pages_noprof
      0.00            +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.__free_one_page
      0.00            +0.1        0.08 ± 12%  perf-profile.self.cycles-pp.get_vma_policy
      0.04 ± 44%      +0.1        0.12 ± 18%  perf-profile.self.cycles-pp.free_unref_folios
      0.09 ±  4%      +0.1        0.17 ± 17%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
      0.13 ±  8%      +0.1        0.21 ± 15%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.00            +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.10 ±  3%      +0.1        0.18 ± 15%  perf-profile.self.cycles-pp.folio_add_new_anon_rmap
      0.05 ±  7%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.set_pte_range
      0.11 ±  5%      +0.1        0.20 ± 13%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.14 ±  3%      +0.1        0.23 ± 14%  perf-profile.self.cycles-pp.folio_add_lru
      0.00            +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.__page_cache_release
      0.08 ±  4%      +0.1        0.17 ± 17%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.07            +0.1        0.17 ± 16%  perf-profile.self.cycles-pp.do_pte_missing
      0.29 ± 12%      +0.1        0.39 ± 18%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.30 ±  4%      +0.1        0.39 ± 16%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.12 ±  3%      +0.1        0.22 ± 15%  perf-profile.self.cycles-pp.___perf_sw_event
      0.15 ±  3%      +0.1        0.25 ± 15%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.10 ±  5%      +0.1        0.20 ± 10%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.06            +0.1        0.17 ±  8%  perf-profile.self.cycles-pp.___pte_offset_map
      0.06 ±  6%      +0.1        0.18 ± 11%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.13 ±  6%      +0.1        0.26 ± 14%  perf-profile.self.cycles-pp.folios_put_refs
      0.12 ±  3%      +0.2        0.28 ± 13%  perf-profile.self.cycles-pp.lru_add
      0.24 ± 23%      +0.2        0.39 ± 23%  perf-profile.self.cycles-pp.finish_fault
      0.24 ±  6%      +0.2        0.40 ± 13%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.17 ±  4%      +0.2        0.36 ± 18%  perf-profile.self.cycles-pp.zap_present_ptes
      0.16 ±  5%      +0.2        0.37 ± 17%  perf-profile.self.cycles-pp.lru_gen_del_folio
      0.32 ±  3%      +0.3        0.58 ± 11%  perf-profile.self.cycles-pp.lru_gen_add_folio
      0.34            +0.3        0.62 ± 27%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.44 ±  3%      +0.4        0.82 ± 19%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.03 ±  2%      +0.9        1.89 ± 15%  perf-profile.self.cycles-pp.sync_regs
      2.27 ±  3%      +5.0        7.27 ± 19%  perf-profile.self.cycles-pp._raw_spin_lock
      8.60 ±  2%      +6.9       15.49 ± 18%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      5.73 ± 13%     +49.1       54.80 ± 13%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


