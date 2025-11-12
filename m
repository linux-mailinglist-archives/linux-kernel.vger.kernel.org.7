Return-Path: <linux-kernel+bounces-897354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E932C52B52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE444FE660
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C621A23A4;
	Wed, 12 Nov 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhJabWql"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C552741DF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956571; cv=fail; b=PDjGQN3v6PymheZtpHlHBRrK0FtMHpJyuNGQR4NJXXwjReac/LAxN/IZP1B8FPC8TBRxcVLbYumegWxRa+TZ0IV8rDXYsilK3De9zMmhIY2jrDJSBerm8H6gkFyKh8ci31hB7ZUiVFEzktmcIx0N65ML25mlQYd3RzV8n1QEvwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956571; c=relaxed/simple;
	bh=r43PCEU6tPnQk9Tu6G/HyYDqz7LR/gCEE0xuO9DhALU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uIzhITo/iyicVjuDHobGn7T9P7iU6oG9yYh1wr6UGUwtsXGZJ0bsx4j9/pK3h+JRuQRvMADV8ThgWOF61TVvpoCJmQ6y52CFgsGFMSRUynN29iXSafI9D4q4BeleX6wJxkhE97SS6RL+6feoJodOJHOITDqTE4+ib/IS8068vtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhJabWql; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762956570; x=1794492570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r43PCEU6tPnQk9Tu6G/HyYDqz7LR/gCEE0xuO9DhALU=;
  b=KhJabWql5KG8OjAySPaXNXoSrszHI/zBzRMKEbnztMZ4NHTugoiJRxBk
   o44HJJJdz0TYa/y3ssAxZLvivF3uSnexrXzy5EEBDhXz/znPu5SeKQ+55
   MyU7ICot6oK2PBqd4U3HmqKYjTR7WN1Nt1mMKCAW9WXEiGNnn5jeDqSBn
   /k/wD5MWjsjc5IHINlGEnCZcNLEk148y1V2tR//aRNSQ89Y1WOn4utpdw
   lg69w0H/AUHzsH+edbVq+pBeL4O3Tn3Pf2eKKij8057yEjwaqtT+sMi+V
   xDIIMbcVXZsgZ7+kL8cQYUHskYN1Oa7acLiZLwyZmneczeRT15PM6IqxN
   w==;
X-CSE-ConnectionGUID: SKdQORIXT9OXISPATmG4Zw==
X-CSE-MsgGUID: gW5o96N9Rrm6UxRiA///9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67620985"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="67620985"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:09:30 -0800
X-CSE-ConnectionGUID: uqPcjxWoTEmXD+5hjEyyEQ==
X-CSE-MsgGUID: Hdj8LnvzTAe4lQs1ZGW0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189956142"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:09:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 06:09:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 06:09:28 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 06:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIM9yGIjd9tRACv9hrFfe/jmcTxLCIeSDdaTTiW8xPQXjfZAMwxzXn89yoyiA/v4l8/4JvelEeKpTIGEJ7ipm6OTk0sVxy7o+p7QmI2OxAGDqDxnzzF+VrKtYGm3OLlYbzLUd0wPDKI2TMpv/IYR+X7/EzKzcSiOEjCqsjsZaBpuMUBd+VQAdU908QIKVXxWRHuX6Ko6vRaIPWMVG3USvS1SJ5gmxFDm9xu9RVZFOzPgHSWFqPs0a720MrbG3q0yWfQwmH/3j6pqKCfOTJl7uf3VbgenVMtSDk5LyFJ1n4tYrfPjWJ66oc4sDNGvTyzTp4/rbFwo2wYPHnaKMiibYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r43PCEU6tPnQk9Tu6G/HyYDqz7LR/gCEE0xuO9DhALU=;
 b=BKDAYZR3jW0GxQBrqucocpPJ76fiHBypS2ZNtb5wZBB6Gxw1CbSoSCEroNBZeSga+0c5P+QrTMRhMwcJKc7LfGrnQsWu8dGBMY0sXUB2aKbAm1hg2LdqxJqwc6hqSliodjeXmRu+dYwskjazRHXVOV1OrsDjRMTNg6hYFheBdTfEilQIUzpwQUg/crGVCqlJ+a/d74AbZJU+PtQp8uQvOSW9eZPvLpOTMhm73f/z4//xXRZe/h4Aqm+ySweuNERcbfvu7JXZ1eClG0Tx1QFSuLc+ScihKpM8dhRIVA42hq9NJ7nlMBEjhDmtAP0SEYogXTDymjaACMlYNSIAmnfDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 14:09:25 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 14:09:24 +0000
Date: Wed, 12 Nov 2025 22:09:11 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <reinette.chatre@intel.com>, <ira.weiny@intel.com>,
	<kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A.
 Shutemov" <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Message-ID: <aRSVB3TQxpgZPj+F@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
X-ClientProxiedBy: KU1PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:802:18::23) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: fd23036d-0f5e-417c-285f-08de21f5159a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IS4bz/j818gm7IxMieQri3QMu+cfkW4RSCTiM9Rv8TK8SYZW7UwteKs1BR79?=
 =?us-ascii?Q?oW4sNhtUwhMM1S/PegJc1ur7BsdMJR8R9J8jBj/+cTjr1i2DGzcreffU/pEK?=
 =?us-ascii?Q?hS/XKaIsBiFOR1thlSuB2OrZtLT/UHlt/bBgQd8FUNUODGXwULtLCN7JUqCb?=
 =?us-ascii?Q?hoRGddYgvTB8PqfPej1+cQVahe0kP+wZtooiwmztWts6LpowWpniYlKEpwOi?=
 =?us-ascii?Q?SuTa2X+6tBAXDBFkhmrn1oqKbdnyLuCXFTZx9avE1rVOWY/iLjAaxzx/pREn?=
 =?us-ascii?Q?ucjKGWCrWUisD4WqcuJRLmy+f3siNLOF8eiy1dKzsT+sG9vTxX6p9JRByGGR?=
 =?us-ascii?Q?T37AhCdgHM/gorADlJ/0yQlg20ERz/OiQLA3/+Ernn7hVKGJ9eAHyNBacHPd?=
 =?us-ascii?Q?vc+jxFwXOERxyKnmcpVLBjEu143h7kNbzr+PZs0sok6YuKntl8JCFIR1Eckr?=
 =?us-ascii?Q?+MCT0Xro0r6QxLOt0JN5CGFQWkkamFayocdxqnJbA5KTgTTJH7r8qO2UlqgT?=
 =?us-ascii?Q?zph8eTl9BuQWOMr1k3a8yet8S1wJTvh2OjTtCpHx/+ykADTmtWMvORTkgDvJ?=
 =?us-ascii?Q?hMNJzWAuFOuDo1kSk6Oxga5nkdeOgx4b8RXCvsJRniNriAvdm39cPaZEhe+R?=
 =?us-ascii?Q?YxslHOSJhTlPQ85AQLYutVcysovQQe8fAXmflgOvEKGOpReLnXGdbSyu2uf1?=
 =?us-ascii?Q?pWfp4b/FQLcihBivq5m4mVCwz4gknLSnOY6/y3RXwfI6fMCV0S89VwDuPxPd?=
 =?us-ascii?Q?DMY3qa6WtRC+YIY3OSOVAu+VIgf68FJFMjnCdvcFyM3qhRh/MS99dgnvjnTl?=
 =?us-ascii?Q?aRFI10eGAq3pn+aKa1/1dU6l5VybUHA78ZCG5ZIlqLTdOZZdBuHPmr1dxWeR?=
 =?us-ascii?Q?YTCR+eQ8DEwfWT5nKa+H9Y2AQMj2y94F3nO//DYnOXWI32VUadEKiwdTje30?=
 =?us-ascii?Q?jXioEnaKPDWEKkmC4pi80X8h68FQV5kkEGk4I18JSOzVAO5sGfklywCVnhal?=
 =?us-ascii?Q?lb/0b4YWbhkcktXpzi1izQ5K8NA8Nvev/EkrL6WVrV1D4D0bQko6llGjWDQl?=
 =?us-ascii?Q?GYLKMp+PL7a/6/iRixIRD9bKLAtHZYUXDD7fDcRhBpf9yQ2sgwpCJeKp4rNl?=
 =?us-ascii?Q?aSF1TJbQHNNsthYhBHFV2iAW7eq2IsnVYwqpyoOJqoOrB9gh7wY6XB5e0cqI?=
 =?us-ascii?Q?4d+G5UbrvPiYw6+OtEVwCONlQ6Af3K0v+2vZvaCyR+Rw7bT4pPEffhLwR9sZ?=
 =?us-ascii?Q?dvru/TH+dSHeeVRM3JCiCTHpO5l1y/6AXEB7wREmLciNqvfKk/9e/H/SUyBS?=
 =?us-ascii?Q?0fiEE815bgo8t+9ohhvv4igtNxsqinhznPnRrZAs6HZRYn8aS8mJYAa2oKP/?=
 =?us-ascii?Q?LuqypcU8c8VzI6QRRaM4jwWb419vButZv5WxnGYcX+URfaT6axIO/B3APl2A?=
 =?us-ascii?Q?oEJy9sM3NZIv7t57HE0P3TCZShydpuc0Jr1mjwmDF4CLpOHV1T8tC/F+EwuD?=
 =?us-ascii?Q?Jme+sBVdVZItSro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vLePKXgBtN3YoLvJzw1+AmXUhpSZQIg/mRG1ep5dYHp+Ve7mG4jD+z0khKci?=
 =?us-ascii?Q?9CkjSu0GEGjmS+NDJ0SzX8BUS38uddFtXz+0x5ebZ8xh/nVkfsudpbFehz7W?=
 =?us-ascii?Q?GcFvYfU3hf2iAQ0W/arTdvlCb+K2x+Wfs/7StBUI2DnPkmXJ7MWMUCopRtWk?=
 =?us-ascii?Q?n7Hm58K0gi22RCxzl4xDGbcCXOk2sd2rj1arhghaz6cmVTxuAsKiprefz0c7?=
 =?us-ascii?Q?J9FYPukSuX+P7v72YzgpUDHiuYoH3f/vUYgll5ZWz8DWN8jwfCqO3Ne66AVk?=
 =?us-ascii?Q?g2datPZ+ma4ewXtSPVydhRqLDdrdY/FzR5nzp7n4c8cOy5Twa2AnGZrWsPO4?=
 =?us-ascii?Q?YW6IdlQXgE39qeQZGpmw4ajePDGdCzQ7Q3ALlflszCU5I55yV5/0GtnfWNK0?=
 =?us-ascii?Q?THXEA7YRB3KqgsFfnHzgKMYH3WkxTemtZy8mHvclM0v2mK8/fNTb9djdZerZ?=
 =?us-ascii?Q?tILq+VnW8oaNfUxIjX/RXf9DwcQwF7k82zY/AUuPLtlpGm4bunJTpun6dl01?=
 =?us-ascii?Q?Yzpcot5m43Y+Txenps9XlYm4CMWIjTaraonZ/wGJTIbVeU1SEs1BcaikPaSV?=
 =?us-ascii?Q?kRLepHzMCt7iSeuZilYT+UGwVB+OTpx8flsVpvkylxa6CpagpI3BlKM0S+s8?=
 =?us-ascii?Q?3sUhBoikZBkPbNnEijEjzUuS/4qe3nP9Ky10OJwNBS1zb85rHQ/ktj5UoBSs?=
 =?us-ascii?Q?NgXvnvnG37ByGEsvFek9vdNumGS1n8izKa/7OyizyL9Yl7Hr0X/SHsL/bTqY?=
 =?us-ascii?Q?If9s1DopGaND5V9bgI+xDYOzhZtqYjhK2EnVZbeY6IJ9gMwcoAJEv/uw82Fe?=
 =?us-ascii?Q?RlkS740+4yF3MziZ3VJbnDVhwrV5akVoHcc/FH6vscQ8S1Vf9i96dYKR87kS?=
 =?us-ascii?Q?aa++J4lcOeMZaUnUmJuZrMn7k9wcHA4tsXMl9cQT+L7mkg8GE0j7T3xsxJTf?=
 =?us-ascii?Q?mjPa/8NnKEMvCMYQDbqVTYmsg2ltS2zZJboCqUW/WMZbtiWxsk8tAxetjL3S?=
 =?us-ascii?Q?qHgkCFdYPQjOXcKNSAqlleX8S7mr72Fynyi1uym6XIsp88cIi9tCz1AWJrJ6?=
 =?us-ascii?Q?5gThgkoWYrUZOE6nXV7LepK7bNx1RuFvycEHbCgymq5XQwhNO0/BuOTGwS/m?=
 =?us-ascii?Q?yvTB1pjQ/kFKeNQFvOvfnabS3AOqk6SUAeE0Zdkaikwpg/RZIkgkrfYjx9Xj?=
 =?us-ascii?Q?ppkXA3haUfJCVtSHKxi+cPuEbeAYed7de8Tm7a2EOygZW7gIXijjak1pZ0pJ?=
 =?us-ascii?Q?MozQLG6D8c+nk6Dmsve7pluKbWo0xdOqoRk4wk01oI8x8msDERDajT0hOq3X?=
 =?us-ascii?Q?DHGjtbgT2wkzenz2+3X+kq0lEgHBmlA0OixbVL31bCzVnAJ+U/XPzUnI6Bj/?=
 =?us-ascii?Q?s4sZ/OBFkBdjXbzWxLPtWCgMHEoY/JcP4LyoGERr53ItB9maaAPEU/8Agu+1?=
 =?us-ascii?Q?5QhxsM5S404EcWT54yl8GfzTRXPkAZ/tX8Nhr+K/V2DpIqgk3CtIaTZaegOI?=
 =?us-ascii?Q?0CFnsEG4fICo/mePBKSOV/sK/G3gZb4nWZeQAz2iTUz7VS+u2Xrd8EKcgfpA?=
 =?us-ascii?Q?ypIXeUeUj21V+4472SnImv4M4f3qF/88fpaM6iC4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd23036d-0f5e-417c-285f-08de21f5159a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:09:24.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWYF+YXXwlKnami6oDZb4HPUCOeu5nk0yIeOfIzync76G7HP7WXwsGnCXt0fue9MKLj8caFAG0YQXTE3JFSgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com

On Tue, Sep 30, 2025 at 07:52:44PM -0700, Chao Gao wrote:
>Hi Reviewers,
>
>This series adds support for runtime TDX Module updates that preserve
>running TDX guests.

Hi Kirill and Rick,

Would you be able to take a look at this series when you get a chance?
I'd appreciate your feedback.

