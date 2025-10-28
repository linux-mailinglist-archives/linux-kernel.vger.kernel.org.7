Return-Path: <linux-kernel+bounces-873179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EDBC134ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3792D5E0B39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5B242D78;
	Tue, 28 Oct 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRmsADzc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE231D5ABA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636585; cv=fail; b=tjVr4ZktR2AvLc/Z1RE+KizQ8FWpBZQiMNNeOiBoeCV0UEwHHBLXWJhlJNRKh6PRBp9rBWfb2PQ+Z0GnDvAGt61s7miBX5J6NUrTdyWIu7A9j/9eAju3RWaz1k7iDzXMm6XWUd0vX0BQ1x+Bjsb/iDvK2FWGMKdXl6q77I8aO48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636585; c=relaxed/simple;
	bh=J1KRySxJmP5IPLvNkjnG5a0Xx2KY+1B6nO6TujWWnuE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ixq0YrlZuDeprw/oJBFl7oHKQwFSkH1nleSkPL6ejJ2llMTtXsOpnKEx1MB2cPH8qDDWO0+Ro1ezFbh/Ej7sK8hQ/eKii2WTWtXddPceCbicnSHYeLY9cfmwBJf7mLhM9dROgLUSEJW6w+Cm3n2M2du823yG4+Wk/R6QBI+ynqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRmsADzc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761636584; x=1793172584;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=J1KRySxJmP5IPLvNkjnG5a0Xx2KY+1B6nO6TujWWnuE=;
  b=ZRmsADzcfg6cs9wrTXk5HJSj7tZewQtY40YdJ2yrrfi5LJC8r/F2oDH2
   WzXus3OYkf/sIqYZTPENSdkj2KFy9RAqZZIllIZpuAp0y3nAt20Oj1fjI
   TX27ILNjIJKf70GVKnamJsiLybA9B2D6OufhU5dyrPyDnHsuZMwogPjHM
   ryXUPynAAOdee2SxJHrBlhG8INxru40w68UQFpicv5GM7AxR6t2nkFGwE
   37noVfgB94w2oI4HHsBt2OyJsTyM1bd1kqrEeq22qbFftk5lEo1zpdJIp
   kGuNL+9hy/OWlWNK5fiX9Qj465KCjgZTELW3AsRZpYJ+PHnZ3ej92uA8K
   Q==;
X-CSE-ConnectionGUID: c0uB03gdRcK03Js11t27kQ==
X-CSE-MsgGUID: qWyLMwxNSTWgo8+omCh8Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63431551"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63431551"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:29:43 -0700
X-CSE-ConnectionGUID: 7/tCXG/ASPGJxEgy/huRyA==
X-CSE-MsgGUID: HsKbZm/1RpC8sJZ7+k3X5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184970248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 00:29:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 00:29:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 00:29:42 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.66)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 00:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhAyNlOC7uZBs3E7ft4dSbaN48y1DUJLzhfqelVR9LqlRRKCWftaG4Vxythm8qJklUDjzYMG4WGHFmpJKfTkBvAHYXRPNNchfOGln4BKof+HoPnZ9PVk32rKQ9necmYgxNHq7CMDaBBbDphY0E+mxeolnBVq2QIXNBg8uwUfd3HgVqCvFcU4VjyE/zEAYpqRNEni0eCZ2b4nvdNDvvBSxqw+Zwt5df32Ykq3xzomPgJUvKVIvtLOeryFMY7dJ3ctUITgL+ypkjJh7SpbKWfjmLUM0WwH6VLp8Tzelkh6g/nfUXvM2/V4zrSBnj5DdK7vUtJW2QSVQx0eHYwk9EoI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwvNrHUtOv0t4VZoNf2tA5OhR0YddrrwVfb5Ziu65/M=;
 b=Y+Da4TvSBGtsR+Pesv9rmw651R9s8i84KOuWaZg9YXYoFOYaClmLWVtXDiABhiB4fXS1z9m4hZqo/VXUhjnLwyXbbW4d5A1e7+N9oRJEBxwVU30ssjV4ELsmOTJRUo6niZPHnNqy4+d8AIBMPSNVOMXRX+X84wDm0J1Tc7g8NZizvMBKFrTKg8jscCp+f6yKpn8yLN2f7ocFqRRniD6JpCawMJo+CzqTQ8c1IM8CivXcpvZz+xBK1GFznbvBGvbTlehu/UOvxRzCpnZi80bZJfI2dYEf4s45fcmefDrA8LCn/jFhCsOr4RJH1a44GpW9ZCflDQPr/lTfZ0EI6YJpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 07:29:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 07:29:40 +0000
Date: Tue, 28 Oct 2025 15:29:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shubhang Kaushik via B4 Relay
	<devnull+shubhang.os.amperecomputing.com@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shubhang Kaushik
	<sh@gentwo.org>, Shijie Huang <Shijie.Huang@amperecomputing.com>, Frank Wang
	<zwang@amperecomputing.com>, Christopher Lameter <cl@gentwo.org>, Adam Li
	<adam.li@amperecomputing.com>, Shubhang Kaushik
	<shubhang@os.amperecomputing.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup
Message-ID: <202510281543.28d76c2-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com>
X-ClientProxiedBy: KL1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:820::15) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6dfcc4-3056-4617-33db-08de15f3c095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MQvqPQDGUimIJI2NHOxiYn980Vqh8M/uYlKH6DGzsoTm3Hzbbh/wFX7cOO?=
 =?iso-8859-1?Q?z81W3j9FajEm3waj4CwjlypsA7fSS7qN9wSw+jMjmUe+ANNe2gsEdqh/f3?=
 =?iso-8859-1?Q?5quFtJMxO0w7wukxDGNViVsN74kHPXkqPY/tI8cM0wSSmq3TST3Vf1oBsL?=
 =?iso-8859-1?Q?2m9+/7tReMfbEMfK0fSGUxIjzexnSzn68yIzlrNRXm1uA2R8/pRxGALyZr?=
 =?iso-8859-1?Q?sV/9/WayBGHyT5+Yvhpd5T0I64HDotx04gICDziJ0xcIz4mvuzkHeewY5m?=
 =?iso-8859-1?Q?fA3llVfQ3TGaC7OMKbpse5nkndAWa13MwCD06u2XA/RA4bCcFx1eCwqZyR?=
 =?iso-8859-1?Q?UVzWk2v/iLvB7R4dLYZbs8uJf5w+QEABtRrQGv4L+jpNottptt/cE2H0nv?=
 =?iso-8859-1?Q?zhyZtC1RNuwgtOIy07Tc8JFOdaV3125ocL5LKYwe6rcwFc94MQFrNq7a2K?=
 =?iso-8859-1?Q?R7kLsG1EHMy/d0x+ICYuSPwlIYMAxG0t4wwhe/+pY1sodif/k6lNjEFOwA?=
 =?iso-8859-1?Q?tDYafqdousb59jQsgOGuftb1yI9KM87rgisKpaxiJhEJuzaXGjQL81UuUV?=
 =?iso-8859-1?Q?qAO8+q+W5DQFbkiqIcjiiVQEuLbKOJYItMH1NdqUm5srntYWyxEvHes8CS?=
 =?iso-8859-1?Q?OkmMYQhoOs/7+/dhifq4kjPNHIEvGp9SqIgH9CDNQTKr5AXcCXuPR6wJ0k?=
 =?iso-8859-1?Q?RHhrMrODYbepRXZlaZaou3Gw7P4B/8RQDhdVgnQBiSSb4aGYHuvUUl5Dhh?=
 =?iso-8859-1?Q?KCntZ+eyJ5c9WAq1joJvNCf551hOJHVBlQDC0lTzFrZnX8HAXQ3aC7MBMA?=
 =?iso-8859-1?Q?a4PtekNi9cPMOx0AmLl3oMUE6hJUzNScND6Dsh9waFRpoPTsk2A5EF5+2S?=
 =?iso-8859-1?Q?5/PmO3CbQUqsy13uZWeOS0fukJqRdz7x2RfaLme5NQFJLmw3mt2fnXZ7GD?=
 =?iso-8859-1?Q?Df0NLJP3COaoRWIk2Gc3EuMISABfTIxTzGHTIsDXeIxHH1owKP3xrUciQl?=
 =?iso-8859-1?Q?8EeaaH3kgJVdh0FckXnvV1cSGxscesm7AevgVbqgt2T4Ot3CoqyBSZvpIz?=
 =?iso-8859-1?Q?v+2vkFuMjVUQj6A2HSQ9+fF9vUeFJU2kvXhyBTMZRRS6TjcvUpIU0YHH6U?=
 =?iso-8859-1?Q?w0DevOGto05ZxRYy5bFcIWSn7vK+B4aU0p2nlomiVFD5/0NK4Ro99IEvaZ?=
 =?iso-8859-1?Q?QBsgv8eoDEDjWymJGH9B+u6g31H6/W5OZvDk6/yPTj+81teFlNg0pRbPPY?=
 =?iso-8859-1?Q?Qm+EeeDWHkECp0FvQB7EiP+RwNE8UF8z2mSM3UVfSgFli8ijSqpZgh6fY8?=
 =?iso-8859-1?Q?Tjt+WrMyhPsI95LLO3Yi1fv1z1bGT/mJ+fQSQaE9oNfhsaQfg1F0wvRJQS?=
 =?iso-8859-1?Q?xvJ8J9f+9kwITFR4OGY5Y4GN8TgtuMWW8kFdpPjK1G5p76dM+WGOnJE7+f?=
 =?iso-8859-1?Q?pDgGDmMHsJl7syEottL3+XUc/4R01eRqVoaFtoQQWJPl/MKlUPNqwpbmTN?=
 =?iso-8859-1?Q?qvIZbWBkvCreqtyDPZgC+rDHOc4bUJ53/w6ywb04lbtg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?boFvZSGUmDo5KHaQqOjXJV+KKxxwRVwecDaTfsbDjq/N76mMZfga2k3/gt?=
 =?iso-8859-1?Q?CNmOwPDuTWXfmLLLBsIhslE/riMOAio21aonfedxGEdnYgWUEBBiiIKfDv?=
 =?iso-8859-1?Q?PAoi8hvCKvNhYH20ROB7aEHnZFqhi2/E5gbrNJ1yxZTfsqHW8kqE7L5g4X?=
 =?iso-8859-1?Q?mjsHE7nhhm5C1DVieGOjB8ln7tsXWAYuph146DB9LBljPynJ50f+XKSYNN?=
 =?iso-8859-1?Q?/lAO9rk4uOe0pmRrxsrOO5swpwqxYrUT6r2DDlGUo/ey9iaHXtZ/xed466?=
 =?iso-8859-1?Q?YL+qxzTf5aw4AERPh1J6DToGW4q0+YWYGqYkdI729H+5OQK5faW8RghH5m?=
 =?iso-8859-1?Q?O7Xlo5GLzqPPFTJBXymg2JvE6vRd7B6g16+OF23Pztnfnk82tICILyZLu1?=
 =?iso-8859-1?Q?q12W5qs4hkws+HQPvA4DNHaMQt/rnl2rENceRkA9+tCVXf3yom9CNV0MwG?=
 =?iso-8859-1?Q?uh1wQyUji9rar+I+IFYtXp9dLhDWLL6QJlYort6AI1DV3Ws9NyMzHXCvQr?=
 =?iso-8859-1?Q?ubTZLytfO2PihDPfLEw5X6ffWCL/Q78JV+Cr0AnyBPPflDTBd9dwDcqafr?=
 =?iso-8859-1?Q?Q7HrAt1gx7G3exiAk9+Zz3Aff92bWo6PAuMHpiFJHgtBTou4yZQmOlcfen?=
 =?iso-8859-1?Q?8jIDyZok1IpvEJcHhEOPx0g7Z1p35fzXBEsAtChftWNKwGI5mHkF0tpVbW?=
 =?iso-8859-1?Q?u1MmfnNhwXEJcjv5n4kHrbYrivgTPHkLtnIAmFpGoX0k7ZCU9VlNQs342R?=
 =?iso-8859-1?Q?2ZDocQc+Drf8mnsxCAOwnM5cBGYxxKW9nsIcx/lbmEkn4Z5mwgcNjfzOxB?=
 =?iso-8859-1?Q?jx2AkWzjSGGM1p+H2KYF0PRgBldOxrrFSPdkBgAZ2OIeW3xMYEmOF7R/Fb?=
 =?iso-8859-1?Q?PF1z5KLpBQyLbA161AgmMNmAobx1qDDs/yhuRTIR4vMt2hyhVpCSFNUQny?=
 =?iso-8859-1?Q?8ub7npOVyhi1/38CA92BgR8fj/ac1GLBzlhq3SHJ4tGM2rrtVVgb9McNQX?=
 =?iso-8859-1?Q?IXzpAV6fNCStlCAk0QGVCvIo7UZVsFVEeGpc6vWhIMU2HIQTDyuL4Hao4W?=
 =?iso-8859-1?Q?Bb0TqKEPr+eRMiarMuMnNXo2dqMqdXn/9wFCGCN/eY7nFXVJBk4FHVQrsg?=
 =?iso-8859-1?Q?efeytPHMjZ0TwFQf7WY1fzSgsga+b4bHAWZE1pntTDB/Vt/p7hhmbpg728?=
 =?iso-8859-1?Q?fhoX8EFBfrtaJRoRwWPoFJ57wd8vUKJRpNUfY+/sdUmAPBLO9Ojuw9w2bx?=
 =?iso-8859-1?Q?fgN00n5TlCCszx0qQvjitRxk//x05+O83wAv53nV6X4Hu28F3sCu26U+Qj?=
 =?iso-8859-1?Q?Nxn5edYRwCELQ+662ODKEj6wftFUe/DUvbU+ijyQgFVWF0lWV9IW5jRxY6?=
 =?iso-8859-1?Q?hbhpgPTlgPfIJOLkgk6G87rLjBl19mdEzFui+/2w4JjGBOcbvQo8ZWOXu5?=
 =?iso-8859-1?Q?BWsk8SGo9eRr8Tobz+F/6j/vq46//NfKkA96zUt8zdysY0cIl6nXlfLr94?=
 =?iso-8859-1?Q?i2z70zAoo42z1FvqlWnEr9K7l4NKb19UdjzIjB3ZyLJlKhgVFmJLuk7sAx?=
 =?iso-8859-1?Q?4PBrexT0DHexAKUoCT3zaaBL1u4/kzltEfaHyaopLZ296QgojopaQp7Oo8?=
 =?iso-8859-1?Q?i6I5+FTJNN4pwIigSQPPdmLKlMHdRlIHTQYo+Bn8MxHVywy32eIBkEsQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6dfcc4-3056-4617-33db-08de15f3c095
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 07:29:40.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbUob3TyPWrofPTs0QvGaHh8lWP3iv/vYwgNm5SyK0K8Rrf5hgNfwhE2KDcQMwcUEiPl/14r5EgQ4WQun53IEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 76.8% improvement of stress-ng.tee.ops_per_sec on:


commit: 24efd1bf8a44f0f51f42f4af4ce22f21e873073d ("[PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup")
url: https://github.com/intel-lab-lkp/linux/commits/Shubhang-Kaushik-via-B4-Relay/sched-fair-Prefer-cache-hot-prev_cpu-for-wakeup/20251018-092110
patch link: https://lore.kernel.org/all/20251017-b4-sched-cfs-refactor-propagate-v1-1-1eb0dc5b19b3@os.amperecomputing.com/
patch subject: [PATCH] sched/fair: Prefer cache-hot prev_cpu for wakeup

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: tee
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251028/202510281543.28d76c2-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-spr-2sp4/tee/stress-ng/60s

commit: 
  9b332cece9 ("Merge tag 'nfsd-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux")
  24efd1bf8a ("sched/fair: Prefer cache-hot prev_cpu for wakeup")

9b332cece987ee17 24efd1bf8a44f0f51f42f4af4ce 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12097 ±  3%     +10.9%      13413 ±  2%  uptime.idle
 3.662e+08 ±  7%    +382.7%  1.768e+09        cpuidle..time
   5056131 ± 56%    +426.8%   26635997 ±  3%  cpuidle..usage
  13144587 ± 11%     +21.1%   15921410        meminfo.Memused
  13326158 ± 11%     +20.6%   16067699        meminfo.max_used_kB
  58707455           -16.5%   49043102 ±  9%  numa-numastat.node1.local_node
  58841583           -16.4%   49176968 ±  9%  numa-numastat.node1.numa_hit
  58770618           -16.3%   49175467 ±  9%  numa-vmstat.node1.numa_hit
  58636509           -16.4%   49041602 ±  9%  numa-vmstat.node1.numa_local
      2184 ±  9%   +2157.3%      49310 ±  3%  perf-c2c.DRAM.remote
      3115 ± 11%   +1689.3%      55737 ±  3%  perf-c2c.HITM.local
      1193 ± 13%   +2628.6%      32575 ±  3%  perf-c2c.HITM.remote
      4308 ± 10%   +1949.6%      88312        perf-c2c.HITM.total
      1.95 ±  6%     +10.4       12.34        mpstat.cpu.all.idle%
      0.50 ±  3%      +1.0        1.53        mpstat.cpu.all.irq%
      0.02 ±  6%      +0.1        0.09 ±  5%  mpstat.cpu.all.soft%
     74.24            -7.0       67.21        mpstat.cpu.all.sys%
     23.29            -4.5       18.83        mpstat.cpu.all.usr%
    232818 ± 35%     -18.3%     190138        proc-vmstat.nr_anon_pages
    124104            -1.1%     122691        proc-vmstat.nr_slab_unreclaimable
 1.167e+08           -15.0%   99106005        proc-vmstat.numa_hit
 1.164e+08           -15.1%   98853060        proc-vmstat.numa_local
 1.168e+08           -15.2%   99060661        proc-vmstat.pgalloc_normal
 1.147e+08           -15.7%   96704739        proc-vmstat.pgfree
 1.071e+08 ±  2%     +76.8%  1.894e+08 ±  2%  stress-ng.tee.ops
   1786177 ±  2%     +76.8%    3157701 ±  2%  stress-ng.tee.ops_per_sec
 1.044e+08           -49.4%   52882701        stress-ng.time.involuntary_context_switches
     21972           -12.1%      19317        stress-ng.time.percent_of_cpu_this_job_got
     10131            -9.6%       9155        stress-ng.time.system_time
      3070           -20.2%       2450        stress-ng.time.user_time
 1.512e+08           -37.9%   93853736        stress-ng.time.voluntary_context_switches
      2816           -10.5%       2519        turbostat.Avg_MHz
     97.12            -9.8       87.30        turbostat.Busy%
      0.11 ± 52%      +0.5        0.66 ±  5%  turbostat.C1%
      0.40 ± 11%      +8.4        8.78        turbostat.C1E%
      2.39 ±  3%      +1.0        3.42 ±  2%  turbostat.C6%
      1.08 ±  9%    +168.3%       2.90 ±  3%  turbostat.CPU%c1
  32638444          +167.8%   87395049        turbostat.IRQ
    110.56           +14.6      125.14 ±  4%  turbostat.PKG_%
     23.05           +32.8%      30.62        turbostat.RAMWatt
   7559994           -21.3%    5948968        sched_debug.cfs_rq:/.avg_vruntime.avg
  11028968 ± 13%     -38.2%    6818572 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
      0.34 ± 13%    +104.0%       0.69 ±  3%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.38 ±  8%     +75.2%       0.67 ±  3%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     20.67 ± 33%   +3672.8%     779.66 ± 73%  sched_debug.cfs_rq:/.load_avg.avg
    519.67         +7141.5%      37631 ± 10%  sched_debug.cfs_rq:/.load_avg.max
     86.71 ± 22%   +5134.0%       4538 ± 39%  sched_debug.cfs_rq:/.load_avg.stddev
   7559994           -21.3%    5948968        sched_debug.cfs_rq:/.min_vruntime.avg
  11028968 ± 13%     -38.2%    6818572 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
      0.12 ± 17%    +117.1%       0.27 ±  3%  sched_debug.cfs_rq:/.nr_queued.stddev
    809.69 ±  2%     +15.6%     936.26        sched_debug.cfs_rq:/.runnable_avg.avg
      2093 ±  3%     +18.5%       2480 ±  8%  sched_debug.cfs_rq:/.runnable_avg.max
    259.47 ± 18%     +71.8%     445.79 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    576.64           -10.6%     515.40        sched_debug.cfs_rq:/.util_avg.avg
    137.33 ± 12%     +85.3%     254.45 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    609.44           +15.6%     704.34 ±  3%  sched_debug.cfs_rq:/.util_est.avg
      1839 ± 11%     +23.7%       2274 ±  7%  sched_debug.cfs_rq:/.util_est.max
    245.27 ±  7%     +82.4%     447.29 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    702831 ±  5%     +19.6%     840863 ±  3%  sched_debug.cpu.avg_idle.avg
    378668 ± 14%     +32.2%     500458 ±  6%  sched_debug.cpu.avg_idle.stddev
     44.33 ± 22%     -62.7%      16.52 ± 13%  sched_debug.cpu.clock.stddev
    909.29 ± 12%    +160.6%       2369 ±  4%  sched_debug.cpu.curr->pid.stddev
    639355 ±  5%     +80.6%    1154626        sched_debug.cpu.max_idle_balance_cost.avg
    500000           +57.3%     786555 ± 11%  sched_debug.cpu.max_idle_balance_cost.min
      0.00 ± 20%     -47.2%       0.00 ± 18%  sched_debug.cpu.next_balance.stddev
      0.32 ± 14%    +111.2%       0.68 ±  3%  sched_debug.cpu.nr_running.stddev
    574871           -33.2%     383811        sched_debug.cpu.nr_switches.avg
    788985 ± 11%     -32.4%     533309 ±  6%  sched_debug.cpu.nr_switches.max
      0.04 ± 19%   +1073.1%       0.50        perf-stat.i.MPKI
 1.443e+11           -17.9%  1.184e+11        perf-stat.i.branch-instructions
      0.08 ±  3%      +0.0        0.12        perf-stat.i.branch-miss-rate%
 1.049e+08 ±  2%     +23.6%  1.296e+08        perf-stat.i.branch-misses
     31.56 ± 11%     +16.6       48.19        perf-stat.i.cache-miss-rate%
  25936672 ± 22%   +1080.1%  3.061e+08        perf-stat.i.cache-misses
  77849475 ± 13%    +714.6%  6.342e+08        perf-stat.i.cache-references
   4288231           -33.1%    2868755        perf-stat.i.context-switches
      0.85            +9.6%       0.94        perf-stat.i.cpi
 6.387e+11           -10.2%  5.735e+11        perf-stat.i.cpu-cycles
      2828 ± 24%    +596.1%      19688        perf-stat.i.cpu-migrations
     32456 ± 26%     -94.2%       1870        perf-stat.i.cycles-between-cache-misses
 7.486e+11           -18.2%  6.125e+11        perf-stat.i.instructions
      1.17            -8.8%       1.07        perf-stat.i.ipc
     19.17           -33.2%      12.81        perf-stat.i.metric.K/sec
      0.03 ± 22%   +1341.1%       0.50        perf-stat.overall.MPKI
      0.07 ±  3%      +0.0        0.11        perf-stat.overall.branch-miss-rate%
     33.00 ± 10%     +15.2       48.24        perf-stat.overall.cache-miss-rate%
      0.85            +9.7%       0.94        perf-stat.overall.cpi
     25848 ± 21%     -92.7%       1874        perf-stat.overall.cycles-between-cache-misses
      1.17            -8.9%       1.07        perf-stat.overall.ipc
 1.419e+11           -18.1%  1.162e+11        perf-stat.ps.branch-instructions
 1.028e+08 ±  2%     +23.3%  1.268e+08        perf-stat.ps.branch-misses
  25499974 ± 22%   +1077.5%  3.003e+08        perf-stat.ps.cache-misses
  76519245 ± 13%    +713.3%  6.224e+08        perf-stat.ps.cache-references
   4214394           -33.2%    2815077        perf-stat.ps.context-switches
 6.278e+11           -10.4%  5.627e+11        perf-stat.ps.cpu-cycles
      2763 ± 24%    +598.5%      19305        perf-stat.ps.cpu-migrations
 7.358e+11           -18.3%  6.009e+11        perf-stat.ps.instructions
 4.489e+13           -18.3%  3.668e+13        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


