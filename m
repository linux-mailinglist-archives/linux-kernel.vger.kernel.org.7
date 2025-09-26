Return-Path: <linux-kernel+bounces-833611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E5BBA26AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DD624248
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB82749CE;
	Fri, 26 Sep 2025 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsGuOOf5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBDA271440
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862637; cv=fail; b=SIKWh4Buzqb2V2wPIWGhKaSN0I1O9UZhuaN0bAMsGKvo4V/AIXfD6kB2Q7DZFsTdcrNnz92dqxPsW43iuTwFUb8I85BClP3tMjmnQcB31pRl0kYzBigAiptiRi4mVyKCtTlhT4aDTwDJW36lfHkpDQQt5F/fgthAaxMiqHPK3Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862637; c=relaxed/simple;
	bh=1gS6rNmeylfWjPR1i7lb4/nIGIthob9MGxzrCdsrt2c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atM+Me5G7jPrcFJEUO9yfVoKr+233GwalGyQvAnwFR6wkiLfm1BAsO065GTiK+TLA3s7bH4rIIr3VMsk2gNCp6pWZuoODmu96PTi2sZ7YK5jVTYVr7HCE9fgIVweIlEc5hVlsf2ZM9Vbqavplfcx07UcbeOxhPfxKuvVQq5dZH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsGuOOf5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758862635; x=1790398635;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1gS6rNmeylfWjPR1i7lb4/nIGIthob9MGxzrCdsrt2c=;
  b=SsGuOOf5RWYqnO9LM9I66IsBovxnc5ePeZkFdaYzECL4MhsOfwH+w6tv
   xyI1UnQA0+Q/jJtAY/VQsQMxsDLDy4bLI8K7RadJekdKgjJVq+0TfTUKL
   90boYgRLE4mKSox3gQWAQGVVRk4OIUqSMkhNBbthdv0mXIZ/mvj2OSwvY
   hiypWC/T4J0mFa3X9a3hskSn8tMqWEXksOvnCmTtPlQ2W3CGXGaA6waG5
   pziWo2O7nCGIKviFwMytWt4GKbaQ04naeWLoLIpEzb2OPGQ/8J/j0/1Jt
   UVvciIyyqebKvybBky9z3K6iBmQOVI1S721z+Xmq2yMEGAG8Wp6Ahsrz3
   g==;
X-CSE-ConnectionGUID: T5zhIc3JTeuKWpqsleqVaw==
X-CSE-MsgGUID: C3I6D2x1S86C2Gds+6SHkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72623274"
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="72623274"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 21:57:14 -0700
X-CSE-ConnectionGUID: e9Rm3G4IREWX+lPkFCRGYA==
X-CSE-MsgGUID: Xlp31NebS6OJ+0FbBbsmnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="178271654"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 21:57:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 21:57:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 21:57:12 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 21:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEfIJL+FCjb8YlB34XSfZ8aBdi3zGEA5BSaA619/Ip5rY5qZLdqpsUeib5Ghi6O9Oawr+11wSYAM4ILQoedMYq9HBO/AqSzk/tv7B8wvwGKeKPc2h3y8Lqg+0bUlrjmBY1zdiy93jdb8PojagWozKaV63eYHKeYn1m7ipCFD7g+a69I6Sz6dy7CJQ2jY4uySuB1jirPofh0HIg1BrdXYG8AEZF1dUb6qwsZA6O6kZZZZKvE/AZa/0RLppnupOJVN1UzF7IM1ZnpNYxLKkbBO9t2NpleKbHG3t1pIrITxvOIMDrqlaSl46rH8vAqSZgmiP22G0+RbNXEJ/SzfAYfzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHoWNwvfE7RlDz92giD4escGGnYVimcmAiidBkaC4h4=;
 b=AOi0e6AmKL4XX2bKSrRAPz4QJ4FjKOMIcc3cwwTmFE94aA23uPW6Vrq7YI6QYSiVYPG83zwwxSbR/bgSFoCj1mcW/L2yWU9M7CtvMQCO7IOBiTcD4uLmRR8iA+gBro+Amrc9fSz1+4CKMtUvR/jrl011mZS4dwz/vdOrU/DVBTY2UrBAMjgCEJt88u3f6OQecte86sKhOTHUzcFIeqN2OGG/XJzOieXyGwHaf1V6JjSLhjqQP/YKxKEr9A0Pg/Gffmyrci+N1DyDG1DLOdX74VKr7sSdqkYL0z3vSlcAkRYLoEZHk4drAjtMwNRkNYcxn2ubj9+/kaABRWYxl1iepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 04:57:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 04:57:02 +0000
Date: Fri, 26 Sep 2025 12:56:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Fernand Sieber <sieberf@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <peterz@infradead.org>,
	<bsegall@google.com>, <dietmar.eggemann@arm.com>, <dwmw@amazon.co.uk>,
	<graf@amazon.com>, <jschoenh@amazon.de>, <juri.lelli@redhat.com>,
	<mingo@redhat.com>, <sieberf@amazon.com>, <tanghui20@huawei.com>,
	<vincent.guittot@linaro.org>, <vineethr@linux.ibm.com>,
	<wangtao554@huawei.com>, <zhangqiao22@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3] sched/fair: Forfeit vruntime on yield
Message-ID: <202509261113.a87577ce-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918150528.292620-1-sieberf@amazon.com>
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e6c3ef-b01c-4afd-47bf-08ddfcb921e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?h1v8lwCzlfEuz/MfPRrrQHgVVCDQqV/SEoxhfuTfym85/Jm+rFEmOYR4iD?=
 =?iso-8859-1?Q?amxDqwgLNsmwQg6T9NnTe6PpnwFPkw+rkRIBg6HBDGNdpYUv88mGgoYcKa?=
 =?iso-8859-1?Q?Qw3Lk5QDQXsmpvKJ3i805L6HQ6bPyjqRzhnhp9jhG3RWlo6MUenQLFAx24?=
 =?iso-8859-1?Q?P6fX06iL1Ix8TIXJgCVxlyfHr0qpKNKkEHBkOQjCpnuNC/uZzXqEt0O81M?=
 =?iso-8859-1?Q?2qda/M6Z1Z9ih/Yw0xOP6qXiOKx9LDMtlEhNa6z6B30YimlXFYye3GqTh8?=
 =?iso-8859-1?Q?0UWa6lgEOXiLwSg2wXBpZOL6oB2wiyyCiaJRj9tXMv0ZY1G563wJX8aMfp?=
 =?iso-8859-1?Q?4TZ8W1mTSmRNPquA8pzaHNuToTGxwCMZibNHfrj9p4dYkJ/QQR5w9bJfzv?=
 =?iso-8859-1?Q?GtBPLSnsoUOcIySX2fVVw46rXa4TYVf3usF2f4YeQqjbZu7rZXr878JWyw?=
 =?iso-8859-1?Q?Qw4NcU96pGgA9DPvzmGHRNmE4IINv8bfhMwaSo+zO0szWi/ALxLcSMlvui?=
 =?iso-8859-1?Q?sdicc87eH2gcCi6wqgY5czkwvZW5JSs2Ra1xxaorzj7PVECEUmEy1XSrwF?=
 =?iso-8859-1?Q?sQiZs7ciPxms5loFsOx55ym70sGuz6zUCgTNfWfKg5ah+dEkgE7caK9q5u?=
 =?iso-8859-1?Q?OFxWCYbA75EkN6Rst7QMz936EAYTWsAtbRnc1d5KCvniDsp4HuJqr/fRuw?=
 =?iso-8859-1?Q?/r9tH7r11UCdbVaqyeAg6xw6+QTl5CY0iJy965WVRlxlmzfdiiEYVG9Xva?=
 =?iso-8859-1?Q?9nmRe/7vO+/T4Jd6rQjpzlMZ28hLmB9ZlepVwFI3doMKVRckwnBFQlPb8L?=
 =?iso-8859-1?Q?/Tu5skPoXJOeIg1sDiPVktti4BjWZRuvpxaoIksodYk9ziROrdQCrH5cmR?=
 =?iso-8859-1?Q?WycYPdrB+I4PqrgZwczmcKd64lppi+AtmDZaAQ6Jw119w+g9niVN3jf+1V?=
 =?iso-8859-1?Q?usx/8ACy4vhx9Wamlhz5Kx5rEPnvvPO3kzRmFynHrg4mnhI0KOLfpGHQlz?=
 =?iso-8859-1?Q?rP598Z7UDWcm772nIsub94dmu7nCO4oClSB7PKI28R4mXqTr8pINa5DzIn?=
 =?iso-8859-1?Q?X5PBZP6arrhe5lEHcFN1dvG92GhGxD/F3w/NwPXy/tCevxckspN9BAlR53?=
 =?iso-8859-1?Q?4jXKVnVwEFG+yEnoBLgFF7WC+xDKRCmSlSRSJm9VakCeaH1omyJsns+l8x?=
 =?iso-8859-1?Q?oEuFgFkZ1ReuriJ4KSiQ0QAtmEVZt0GWuNB8qJKskmLjWmsV7U0FVYCf8y?=
 =?iso-8859-1?Q?rqxb/3bEcT1r0YlAmhQLbpQLes2dUFl5U6meJvFtemq+zbrN3d23DybqWe?=
 =?iso-8859-1?Q?FLtbwHcuKp2bNvwYFZb5YjYM6UdoVuWbkfkZGfO1UqkeqfOx0OkZ76QtxU?=
 =?iso-8859-1?Q?YPxbX6eBwZWHsPZWcDJdNFuqiqWauK6L/r4Q8rK+qAE6759MbFvQrc+e19?=
 =?iso-8859-1?Q?yZ4g/z7jYmcaxJEIp97SFB9e9rQd4R6E1SFS8kurQoaFmsL4qRx8y62WVC?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pajrkeBPJwaUY/pUxFOH7lfMqMsCWF6exCmo+on5JczPFDpNrlcYT4sG7r?=
 =?iso-8859-1?Q?5ojxLp2C7yEJycqCUZGj7eaFAT7jWjeVWrIq/1Cm63e3i8hg5gcPJqepxV?=
 =?iso-8859-1?Q?djq61DkOvmLhx62TKezJ2LedSDxBVOKhIM+OM90I5UFgMeUxgzwEP1mY/3?=
 =?iso-8859-1?Q?NkpArj7Z+jt59fcMYplful7n1DckjSVRpD2uzGwmXdg59X7ZjvgQdXA7aX?=
 =?iso-8859-1?Q?qImU3y069yCTLI4TgVdOVxy8/js7CW0TL5tALen5im5WyNqML57c4Abmk6?=
 =?iso-8859-1?Q?qUzzCzssqDH4jQ6EtLCLa/t9kSS/0fUvJ87VkeG2r6KyFPJLFygTlCCK1X?=
 =?iso-8859-1?Q?q19NJV+qRII1FVoIycPWuU0pLsnOHou+TS74fJB6PiGoT2vy5Qofpmp6G1?=
 =?iso-8859-1?Q?bRrHoHlVN1IKyKBMvwhP0yw+YhtQf0MLvDU3mIzEeVwhtPB9P0QQd44Ueo?=
 =?iso-8859-1?Q?2aKvXm6cygXlhnb+ifJaMezAZK0pes22rlMxBXIKBK1k2Za4pY5NLEAiLf?=
 =?iso-8859-1?Q?HHxpNT6ReqkGwtGobkkAme08MGLAMGkPb35hQlGlgY0agahnrxFit7D7Fc?=
 =?iso-8859-1?Q?luDbOYk7a3RVzyIS7xPJ+K8BJ9hiGOU3JM0Qvt++u0yCXe9FGS9TP86izH?=
 =?iso-8859-1?Q?aOs0ZdtgnH5g1m5y7iRJV82LYz3oMs4VwyQWreMk04yOhi6pr+8CkuMBLs?=
 =?iso-8859-1?Q?Q7O5DQh5cTSS4sHzMznhgMMSjT3VDRdvagecSgb7zIuUdIjzWKRAePIkwW?=
 =?iso-8859-1?Q?FOjOgDbAfw3Gx06A7euEN8mgCi+I74KsChK6Vf0gJU8uxo6O0jOwgyAbXA?=
 =?iso-8859-1?Q?qAFg4HVXIJupdeE/xSKJFqdzTMqw4xXhVG7CA2nHsUx/CjHhBHzt4u0H1p?=
 =?iso-8859-1?Q?pLcwQbjjm2JAcQDdWQ0XQEL3dCxWhSmcKpf2CICDr39K14yHPbCo4rjVNq?=
 =?iso-8859-1?Q?0ikHDYWGVoopRR+eO3O2HYRCX1VWN4eqWt9p9cDa9KT+BXSmruuF5pGkWt?=
 =?iso-8859-1?Q?l8dj8WXIPv3Z9n31K2EHhUaFXlfrD5sW/xgqsw+oUGBRIhmLTTObQ2FiqC?=
 =?iso-8859-1?Q?cdpjhqfMbn8Mju2K7sWABIFnDMMAcgGmCF004wfOyJo7nCcVf3tAeYzyy2?=
 =?iso-8859-1?Q?AgkG5Gk0ceQUp7P5qdhbXp+6SVntAg7aCvBJQvzgtnMd0X+HdpRf5dXhEM?=
 =?iso-8859-1?Q?H4S5sWkFcFMZVdZA3aRlOnAWWHYhDqc4oqCrD6wFgX8uvTQlSSpag564rK?=
 =?iso-8859-1?Q?A8W3u7SPhdKSgbjYIfnhWVfpLbZ84Pu9k1fGzBLdoKuvxrzcRN5OPIDE1X?=
 =?iso-8859-1?Q?n9uDFIF4WuPnD+lCsYblqF5KYhlPAHTmTkSQZfeIst1UDX088OkGiEP6/T?=
 =?iso-8859-1?Q?vhrp9IoIKAmPXDhs6L+vPiLeOHfpzeLeZgCX0B43TmglKh7asJk1QK7BZn?=
 =?iso-8859-1?Q?t+Vl/agdTB4ii53o7Md6oCVh/yEZLvo47mqMblYEWqhOmYNYg9Sb2vkxE3?=
 =?iso-8859-1?Q?qaMpWYtce4fmelgXGFm2oOY9GtJmeUx8cFdo1uBWXcFXV664y62Gx32WzX?=
 =?iso-8859-1?Q?MBCeTN6hQeJyvKJFBb4BBcYjWTTf7nPRg4AHL2fi5ABFyW/ofXoaj+Dj1A?=
 =?iso-8859-1?Q?3/Qht5RxE6yH3SYw23yeYKx/fP5gUNx+EIM/E50KPLKPYRiUdMpWPHJA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e6c3ef-b01c-4afd-47bf-08ddfcb921e5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 04:57:02.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Y4vLQY3/aylHfA9Ob9jTtmOdPRoAho45LkQZQp/HayQlHJ4Ug5p/mgDZkuqRnTazsfBpb/Vu5BHg5TxoWri9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4979
X-OriginatorOrg: intel.com


Hello,


we reported "a 55.9% improvement of stress-ng.wait.ops_per_sec"
in https://lore.kernel.org/all/202509241501.f14b210a-lkp@intel.com/

now we noticed there is also a regression in our tests. report again FYI.

one thing we want to mention is the "stress-ng.sockpair.MB_written_per_sec" is
in "miscellaneous metrics" of this stress-ng test. for major part,
"stress-ng.sockpair.ops_per_sec", it's just a small difference.

0d4eaf8caf8cd633 15bf8c7b35e31295b26241425c0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    551.38           -90.5%      52.18        stress-ng.sockpair.MB_written_per_sec
    781743            -2.3%     764106        stress-ng.sockpair.ops_per_sec


below is a test example for 15bf8c7b35:

2025-09-25 15:48:21 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --oom-avoid --sockpair 192
stress-ng: info:  [8371] setting to a 1 min run per stressor
stress-ng: info:  [8371] dispatching hogs: 192 sockpair
stress-ng: info:  [8371] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: metrc: [8371] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [8371]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [8371] sockpair       49874197     65.44     72.08  12219.54    762108.28        4057.58        97.82          3132
stress-ng: metrc: [8371] miscellaneous metrics:
stress-ng: metrc: [8371] sockpair           27717.04 socketpair calls sec (harmonic mean of 192 instances)
stress-ng: metrc: [8371] sockpair              53.01 MB written per sec (harmonic mean of 192 instances)
stress-ng: info:  [8371] for a 66.13s run time:
stress-ng: info:  [8371]   12696.46s available CPU time
stress-ng: info:  [8371]      72.07s user time   (  0.57%)
stress-ng: info:  [8371]   12219.63s system time ( 96.24%)
stress-ng: info:  [8371]   12291.70s total time  ( 96.81%)
stress-ng: info:  [8371] load average: 190.99 57.46 19.94
stress-ng: info:  [8371] skipped: 0
stress-ng: info:  [8371] passed: 192: sockpair (192)
stress-ng: info:  [8371] failed: 0
stress-ng: info:  [8371] metrics untrustworthy: 0
stress-ng: info:  [8371] successful run completed in 1 min, 6.13 secs


below is an exmple from 0d4eaf8caf:

2025-09-25 18:04:37 stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --oom-avoid --sockpair 192
stress-ng: info:  [8360] setting to a 1 min run per stressor
stress-ng: info:  [8360] dispatching hogs: 192 sockpair
stress-ng: info:  [8360] note: /proc/sys/kernel/sched_autogroup_enabled is 1 and this can impact scheduling throughput for processes not attached to a tty. Setting this to 0 may improve performance metrics
stress-ng: metrc: [8360] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [8360]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [8360] sockpair       51705787     65.08     56.75  12254.39    794448.25        4199.92        98.52          5160
stress-ng: metrc: [8360] miscellaneous metrics:
stress-ng: metrc: [8360] sockpair           28156.62 socketpair calls sec (harmonic mean of 192 instances)
stress-ng: metrc: [8360] sockpair             562.18 MB written per sec (harmonic mean of 192 instances)
stress-ng: info:  [8360] for a 65.40s run time:
stress-ng: info:  [8360]   12556.08s available CPU time
stress-ng: info:  [8360]      56.75s user time   (  0.45%)
stress-ng: info:  [8360]   12254.48s system time ( 97.60%)
stress-ng: info:  [8360]   12311.23s total time  ( 98.05%)
stress-ng: info:  [8360] load average: 239.81 72.31 25.10
stress-ng: info:  [8360] skipped: 0
stress-ng: info:  [8360] passed: 192: sockpair (192)
stress-ng: info:  [8360] failed: 0
stress-ng: info:  [8360] metrics untrustworthy: 0
stress-ng: info:  [8360] successful run completed in 1 min, 5.40 secs


below is full report.


kernel test robot noticed a 90.5% regression of stress-ng.sockpair.MB_written_per_sec on:


commit: 15bf8c7b35e31295b26241425c0a61102e92109f ("[PATCH v3] sched/fair: Forfeit vruntime on yield")
url: https://github.com/intel-lab-lkp/linux/commits/Fernand-Sieber/sched-fair-Forfeit-vruntime-on-yield/20250918-231320
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 0d4eaf8caf8cd633b23e949e2996b420052c2d45
patch link: https://lore.kernel.org/all/20250918150528.292620-1-sieberf@amazon.com/
patch subject: [PATCH v3] sched/fair: Forfeit vruntime on yield

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockpair
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509261113.a87577ce-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250926/202509261113.a87577ce-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/sockpair/stress-ng/60s

commit: 
  0d4eaf8caf ("sched/fair: Do not balance task to a throttled cfs_rq")
  15bf8c7b35 ("sched/fair: Forfeit vruntime on yield")

0d4eaf8caf8cd633 15bf8c7b35e31295b26241425c0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.78 ±  2%      +0.2        1.02        mpstat.cpu.all.usr%
     19.57           -36.8%      12.36 ± 70%  turbostat.RAMWatt
 4.073e+08 ±  6%     +23.1%  5.013e+08 ±  5%  cpuidle..time
    266261 ±  9%     +46.4%     389733 ±  9%  cpuidle..usage
    451887 ± 77%    +160.9%    1178929 ± 33%  numa-vmstat.node0.nr_file_pages
    192819 ± 30%    +101.3%     388191 ± 43%  numa-vmstat.node1.nr_shmem
   1807416 ± 77%    +161.0%    4716665 ± 33%  numa-meminfo.node0.FilePages
   8980121            -9.0%    8174177        numa-meminfo.node0.SUnreclaim
  25356157 ±  8%     -22.0%   19772595 ±  9%  numa-meminfo.node1.MemUsed
    771480 ± 30%    +101.4%    1553932 ± 43%  numa-meminfo.node1.Shmem
    551.38           -90.5%      52.18        stress-ng.sockpair.MB_written_per_sec
  51092272            -2.2%   49968621        stress-ng.sockpair.ops
    781743            -2.3%     764106        stress-ng.sockpair.ops_per_sec
  21418332 ±  4%     +69.2%   36232510        stress-ng.time.involuntary_context_switches
     56.36           +27.4%      71.81        stress-ng.time.user_time
    150809 ± 21%  +17217.1%   26115838 ±  3%  stress-ng.time.voluntary_context_switches
   2165914 ±  7%     +92.3%    4165197 ±  4%  meminfo.Active
   2165898 ±  7%     +92.3%    4165181 ±  4%  meminfo.Active(anon)
   4926568           +39.6%    6875228        meminfo.Cached
   6826363           +28.1%    8744371        meminfo.Committed_AS
    513281 ±  8%     +98.7%    1019681 ±  6%  meminfo.Mapped
  48472806 ±  2%     -14.8%   41314088        meminfo.Memused
   1276164          +152.7%    3224818 ±  3%  meminfo.Shmem
  53022761 ±  2%     -15.7%   44672632        meminfo.max_used_kB
      0.53           -81.0%       0.10 ±  4%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.53           -81.0%       0.10 ±  4%  perf-sched.total_sch_delay.average.ms
      2.03           -68.4%       0.64 ±  4%  perf-sched.total_wait_and_delay.average.ms
   1811449          +200.9%    5449776 ±  4%  perf-sched.total_wait_and_delay.count.ms
      1.50           -64.0%       0.54 ±  4%  perf-sched.total_wait_time.average.ms
      2.03           -68.4%       0.64 ±  4%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
   1811449          +200.9%    5449776 ±  4%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      1.50           -64.0%       0.54 ±  4%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    541937 ±  7%     +92.5%    1043389 ±  4%  proc-vmstat.nr_active_anon
   5242293            +3.5%    5423918        proc-vmstat.nr_dirty_background_threshold
  10497404            +3.5%   10861099        proc-vmstat.nr_dirty_threshold
   1232280           +39.7%    1721251        proc-vmstat.nr_file_pages
  52782357            +3.4%   54601330        proc-vmstat.nr_free_pages
  52117733            +3.8%   54073313        proc-vmstat.nr_free_pages_blocks
    128259 ±  8%    +100.8%     257594 ±  6%  proc-vmstat.nr_mapped
    319681          +153.0%     808650 ±  3%  proc-vmstat.nr_shmem
   4489133            -8.9%    4089704        proc-vmstat.nr_slab_unreclaimable
    541937 ±  7%     +92.5%    1043389 ±  4%  proc-vmstat.nr_zone_active_anon
  77303955            +2.5%   79201972        proc-vmstat.pgalloc_normal
    519724            +5.2%     546556        proc-vmstat.pgfault
  76456707            +1.7%   77739095        proc-vmstat.pgfree
  12794131 ±  6%     -27.4%    9288185        sched_debug.cfs_rq:/.avg_vruntime.max
   4610143 ±  8%     -14.9%    3923890 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
      1.03           -20.1%       0.83 ±  2%  sched_debug.cfs_rq:/.h_nr_queued.avg
      1.03           -20.8%       0.82 ±  2%  sched_debug.cfs_rq:/.h_nr_runnable.avg
    895.00 ± 70%     +89.0%       1691 ±  2%  sched_debug.cfs_rq:/.load.min
      0.67 ± 55%    +125.0%       1.50        sched_debug.cfs_rq:/.load_avg.min
  12794131 ±  6%     -27.4%    9288185        sched_debug.cfs_rq:/.min_vruntime.max
   4610143 ±  8%     -14.9%    3923896 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
      1103           -20.2%     880.86        sched_debug.cfs_rq:/.runnable_avg.avg
    428.26 ±  6%     -63.4%     156.94 ± 22%  sched_debug.cfs_rq:/.util_est.avg
      1775 ±  6%     -39.3%       1077 ± 15%  sched_debug.cfs_rq:/.util_est.max
    396.33 ±  6%     -50.0%     198.03 ± 17%  sched_debug.cfs_rq:/.util_est.stddev
     50422 ±  6%     -34.7%      32915 ± 18%  sched_debug.cpu.avg_idle.min
    456725 ± 10%     +39.4%     636811 ±  4%  sched_debug.cpu.avg_idle.stddev
    611566 ±  5%     +25.0%     764424 ±  2%  sched_debug.cpu.max_idle_balance_cost.avg
    190657 ± 12%     +36.1%     259410 ±  5%  sched_debug.cpu.max_idle_balance_cost.stddev
      1.04           -20.4%       0.82 ±  2%  sched_debug.cpu.nr_running.avg
     57214 ±  4%    +183.5%     162228 ±  2%  sched_debug.cpu.nr_switches.avg
    253314 ±  4%     +39.3%     352777 ±  4%  sched_debug.cpu.nr_switches.max
     59410 ±  6%     +31.6%      78186 ± 10%  sched_debug.cpu.nr_switches.stddev
      3.33           -27.9%       2.40        perf-stat.i.MPKI
 1.207e+10           +11.3%  1.344e+10        perf-stat.i.branch-instructions
      0.21 ±  7%      +0.0        0.24 ±  5%  perf-stat.i.branch-miss-rate%
  23462655 ±  6%     +27.4%   29896517 ±  3%  perf-stat.i.branch-misses
     75.74            -4.4       71.33        perf-stat.i.cache-miss-rate%
 1.861e+08           -21.5%  1.462e+08        perf-stat.i.cache-misses
 2.435e+08           -17.1%  2.017e+08        perf-stat.i.cache-references
    323065 ±  5%    +191.4%     941425 ±  2%  perf-stat.i.context-switches
     10.73            -9.7%       9.69        perf-stat.i.cpi
    353.45           +39.0%     491.13 ±  4%  perf-stat.i.cpu-migrations
      3589           +30.5%       4685        perf-stat.i.cycles-between-cache-misses
 5.645e+10           +12.0%  6.323e+10        perf-stat.i.instructions
      0.09           +12.1%       0.11        perf-stat.i.ipc
      1.66 ±  5%    +193.9%       4.89 ±  2%  perf-stat.i.metric.K/sec
      6247            +5.7%       6603 ±  2%  perf-stat.i.minor-faults
      6248            +5.7%       6604 ±  2%  perf-stat.i.page-faults
      3.33           -29.7%       2.34        perf-stat.overall.MPKI
      0.20 ±  7%      +0.0        0.23 ±  4%  perf-stat.overall.branch-miss-rate%
     76.67            -3.9       72.79        perf-stat.overall.cache-miss-rate%
     10.54           -11.1%       9.37        perf-stat.overall.cpi
      3168           +26.5%       4007        perf-stat.overall.cycles-between-cache-misses
      0.09           +12.5%       0.11        perf-stat.overall.ipc
 1.204e+10           +11.1%  1.337e+10        perf-stat.ps.branch-instructions
  23586580 ±  7%     +29.7%   30600100 ±  4%  perf-stat.ps.branch-misses
 1.873e+08           -21.4%  1.471e+08        perf-stat.ps.cache-misses
 2.443e+08           -17.3%  2.021e+08        perf-stat.ps.cache-references
    324828 ±  5%    +187.0%     932274 ±  2%  perf-stat.ps.context-switches
    335.13 ±  2%     +41.7%     474.95 ±  5%  perf-stat.ps.cpu-migrations
 5.632e+10           +11.7%  6.293e+10        perf-stat.ps.instructions
      6282            +6.5%       6690 ±  2%  perf-stat.ps.minor-faults
      6284            +6.5%       6692 ±  2%  perf-stat.ps.page-faults
 3.764e+12           +12.2%  4.224e+12        perf-stat.total.instructions



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


