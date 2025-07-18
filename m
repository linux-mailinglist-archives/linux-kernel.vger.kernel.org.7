Return-Path: <linux-kernel+bounces-737117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4667B0A7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC34E17A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD42E543F;
	Fri, 18 Jul 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdxiJbsS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA32D9483
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853747; cv=fail; b=PNHLgKVLCQoI47qhb6Mh36b2EIbCco7JmOIOyxT+VZ3YfKCCAobSasKjIvqHwSuEsSkkfT2Ww23vlIPEJ1xsW18grkmrK6QtrHzxQgkhp6F3k7WRbHetZUOG76w1ay2I++T31wfJmdVdoFElEuhEHGtCuKS6BmpdgnZIIVCoIYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853747; c=relaxed/simple;
	bh=L/PmpkDZC1DvgqQV4qM8fPdHRFqANjY37Iqz4pTiftw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DbF82YyROSpew2N3FJszq1Jzsp8Eq+yy7qo4jUP+okMeVC897K6Kvft+cOqeINPJIEWrj7WeG8vDy3OGpljv73svw1j0ZstjewJqb5bzC00q99roBMsg+i8dxu0pUl0+0GkXHliSysFg+5Of5LnJ0uf1FsTH2QmjYPl+KgntrOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdxiJbsS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752853746; x=1784389746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L/PmpkDZC1DvgqQV4qM8fPdHRFqANjY37Iqz4pTiftw=;
  b=FdxiJbsS7hJoqPrgRuqezO64HYO+bES+UuAT1s1N2OTkj/RdCV7hnT3A
   mT19pQkzqZpt3/y+4AaGHYp75uWMKH+Km6LNJHKS/IWR/fFQKo9/sFoXD
   uJBAr8D9+Vp7d95ujMyjaP0AWGn000Sa2t/KFwlZWTDZtBrWNRT/sZgsO
   1TiTWbkk+m2XKfrDWg213YBRvMJRC0PVRfoVTgZodQQRH9Dw9BXeyHkKS
   6BRaZaZCvUy/BjdkfTcilqfpi+2ztCayn9w5c4OMtzc7jy0qDpl7vxKVA
   /aFpg3wkXKa+pL2/xVFR2CSlFYocVaOONDcBU8Q9aSSFpGdbye4e+/c6l
   Q==;
X-CSE-ConnectionGUID: cvcsx/91QayYsCFSrYEslw==
X-CSE-MsgGUID: HRVKJGP6QeKf5ofKRaRRaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55004442"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55004442"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 08:49:04 -0700
X-CSE-ConnectionGUID: bKQksImCRBWX7F5Xqngwww==
X-CSE-MsgGUID: Iq7KhOLLQC+K6nD+cqZ36g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158568721"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 08:49:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 08:49:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 08:49:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 08:49:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhYrKOOys++GIUsKlbCMAg9WtSrHbX7TwLEJnMxsXOScW29tOa8mrnwJSr+Zip7p7+ERGxai7VobDtOBqIaWrDRzye71kfutyiBzXk5stn3MTwr1NqSZCHp/HB1zs455vfYfb8s+Om94XZd056tN3YrGMme1nnSR8LC6HpTaAjbmtBX+uX3wtH/wPCF2adC3MJUVm4zDrBAoMQh8P3tGEsvEz0Ee+lokLIIvuRTh7NOiARbfd8/c3FjD0R9IC34wSMQAam9wqj9wf2gZ7f1hBqQ9HLBSUwCMlGm0kN3qduy4BTjb7J/vUH/Ips6df2DEtXe4KGmCAWFq+LdlZJg/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO7iDpO5WhU3qFEJijqolgg/GpucfyGxSqFmxAzbkC4=;
 b=ZNUwFOUwRz1PaxnF/fkakzJGkjOJ5xI/1QWGZaAOB4/7Dogbu5B18k/dp43+H5yIzAWjUVQlm4x33bne64qX9QPNchsSWlgY8JJWkPH6LvErQXvjFWejCF9AjqGU4+5oYYvXwOU3qBVmE8m1OxXxyzHCeg/HBjU9l/k7XPUXD4l1a0zieKbalK6JHerBAwfF4+oxKximCbisG2+pa/n8LJIY1Wa2SdNcWVgo05CUvmAPMj4qzZ1F4VgbIBEgMmxoSiuLgT3VD9WHiIgTW9x01jOSAB2acSX7msAgWA/bhfaYC1sjJ3CKiz5keyR/vQyueGCOYSaexilM36wAcGOQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4995.namprd11.prod.outlook.com (2603:10b6:303:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Fri, 18 Jul
 2025 15:49:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 15:49:00 +0000
Message-ID: <34924bd1-8070-4ecb-8696-c4a575c710c8@intel.com>
Date: Fri, 18 Jul 2025 08:48:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/resctrl: Optimize code in rdt_get_tree()
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: James Morse <james.morse@arm.com>, Yury Norov <yury.norov@gmail.com>,
	"Dave Martin" <dave.martin@arm.com>, "fenghuay@nvidia.com"
	<fenghuay@nvidia.com>, "peternewman@google.com" <peternewman@google.com>,
	Babu Moger <Babu.Moger@amd.com>, Borislav Petkov <bp@alien8.de>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "bobo.shaobowang@huawei.com"
	<bobo.shaobowang@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Xin Hao <xhao@linux.alibaba.com>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	Ingo Molnar <mingo@redhat.com>, David Hildenbrand <david@redhat.com>, "H
 Peter Anvin" <hpa@zytor.com>, Rex Nie <rex.nie@jaguarmicro.com>, Jamie Iles
	<quic_jiles@quicinc.com>, "dfustini@baylibre.com" <dfustini@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>, 'Koba Ko' <kobak@nvidia.com>
References: <20250623073154.3320458-1-tan.shaopeng@jp.fujitsu.com>
 <OSZPR01MB87985042129BAD34812742F48B50A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <OSZPR01MB87985042129BAD34812742F48B50A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:303:8f::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4995:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2f0101-7c1c-4383-58fb-08ddc6129cfe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXU2S1R1czRlcmNTTjBoa21OV28zNDBrZENwRmpwQ0txS0Z5aUpnYi9lUHc0?=
 =?utf-8?B?Vkc5QlltdTllaHlFTXQ1bURDbkRoajcxM1N2RVRQdGhSVk1GbEErMU9MaU96?=
 =?utf-8?B?eU1CTjNhRU9KNW94UzBURXJpdkdRMEt2OFN1aElUMkw0dDRwNGJ3N2Jpb2tX?=
 =?utf-8?B?YTY2WUU0WFl4VVNTWk15VThVUGQyckJ6YnR0R0ZXSWtlWisxTEVBbmhUU2xH?=
 =?utf-8?B?L1NYRTVLSEs4WmVyZFgvckdmSzZIU0RxQmlkcUFwNnNnUnhLSTRKVnllTXlP?=
 =?utf-8?B?aVBKeE9ETmJjVWVWY29YcEhIY0dkbjJ4WkNxNHp0WDk4TENPcFFET3ZKdDJm?=
 =?utf-8?B?c0g4VSt0UmVHdDFwb01haFFOdzVwSlNhWjdRTStOZXc5TDdQamgxOHYxWVps?=
 =?utf-8?B?VTI0WWdzM0xwR0JWWGNTaUtHbU9pQ0c0MUlmZksveDIxTXFjTXFtVWVCTE9E?=
 =?utf-8?B?c1dwNU4zYzdNQk5KL0g3ak91cGtqZVZBUS9XbkF6ZDFoQk5YSDRBRjYwUy9O?=
 =?utf-8?B?VWFsdlVucnBSRXJubDZSL0d5aHVLb1NjMkxvVitLa1hwWmJsWTNveE1KVnpB?=
 =?utf-8?B?NnJpUCtTbElIdDNoVy9UU1dnVDE1TnlqWlNMb2RQdjlqem11aDFlS2NXaUZv?=
 =?utf-8?B?Y3U5S283WWlWbW5lK0xmbzh6SUNpbGUrSFM2V0lndFozUUR1ZUgyYXVnYkFh?=
 =?utf-8?B?UnZ0ZzRCem4ramVTb1VNS09DSFIvT1JvYzFMVlpEZmhGb2hxNmxRUmVGWGRq?=
 =?utf-8?B?TjhrSnc2QkdQSUxkQjVCaG5xSTNIdnU2VkdBMkhsbU9nUHJ1bUJ2S0xjS25u?=
 =?utf-8?B?QTRpNHBGUnlDVHRCKy9hRmlmSW1HNHl5Smh5aHd0dksrbFMybnVwOWdlNmtn?=
 =?utf-8?B?eFpXd242bE9LZlpSZmZmZkFVRWRTdUpzZWNUSDdNV0ZDOTZQU1VyaExHQ2dv?=
 =?utf-8?B?THRPUEtEVytJM3BnZ0dvWHZURjFKWGE5UkdsOTB1dXRZUFc1M2NIMlR3QkxX?=
 =?utf-8?B?Y25LS3pSTjZnS0ZMeFhTc3EwTEg4VGUvVnZtemR5ZG9DelVVL2pFQ01rdS9H?=
 =?utf-8?B?V1pxYzFJd3lYMFVtcndyRWRWMzRQbXg5TExkV256U1Vlb1ZQYkRNVnROWndz?=
 =?utf-8?B?ZnMwTFVXdVhWZEpqeTBPdzN0NXFIL0JzaytkTWsvSmVvRnFvdVJTa1JncUxE?=
 =?utf-8?B?OTQ2ZmdLblVGSnhuV0JZcEwxQ295VkREM3FjSUdqeWpha09qZXAwY2ZHbjAy?=
 =?utf-8?B?cGp1S3RrdlNSSkJiaXZ2QythbkhrMTA0bURJSnB5eldvZGJvb3lINGtqdzFO?=
 =?utf-8?B?Z3ZUdG1FWkZWUkpoSjZPZlp4TzRHUUkyNklORkJLZHdSRDhxVVRvaG5hVFRw?=
 =?utf-8?B?MkQxOXFoTlZLNjBmZEJXOWtnYUVSMUU1OGVZck12djk2TWFYWU1XeXZmVHl0?=
 =?utf-8?B?QS9SbzdMWllOY1AwY0Qrb3ZMOW91K2FWYjZObnNEUUdjS1lNbTBSWm14SXdp?=
 =?utf-8?B?QnlmdFFpaTlqWFZPeVljT0hweE9ieHRuR25HbWpKRWtjUGt6VXFKbVZBclRG?=
 =?utf-8?B?YnhWZkpPaCtiT0pFa2JBUyt4bTFpdlNKbGJVREw4YXFMVnBpQlpYQ3dka25G?=
 =?utf-8?B?VUNDUFQ5YzMxS1h0SmRHZmp1cTI4Z3dwcDJnRTZCdU5ZaXFwbk1PTjBlSS9y?=
 =?utf-8?B?YnhoanoydjhUalNhYXZqdGZyR0pHb0dVaHZyczVMR1cxTndYaGxrNzIxL1VV?=
 =?utf-8?B?THdMUmdKcEppSXh1KzVCM0FyWG5oYitOZWhrdUJBOTJNMDZQd1ZWZmgvYnUr?=
 =?utf-8?B?L3lpYWNRSVV1aTBWU2VkaTdKM1pxajRTbEJDWC8zNlpsaVVHTTZKT1lER2Uv?=
 =?utf-8?B?RGV1UTlXUVM3WXcrQ1prZzlhTmtQL2Jrd2tDWkZVbWFDSkJZSzUyYW5nekM0?=
 =?utf-8?Q?2qt2Rxsh9Tw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9BRE1WUjlwVnZDbU56dzlpVGtrMnJaSUEzQmZxQ1RyMXRYQ2gxblI5ZmpV?=
 =?utf-8?B?ZDRpZTk0OHlVRU5GY21UZ2NzS2ZKWnhWT2tWeTJxbEQxQmt5UlZ4TFNMdlVQ?=
 =?utf-8?B?ZVM5NlNidjMzTDV2SjZENTRDMmE1MnpIQU9ieVhWbFVURmtLVTlEaEhsdU5x?=
 =?utf-8?B?bHNDM0xESTFSdFQ3QnovWDVTbWhybUxvdmI1OFhSQXcwM045RXpFOXVSOFlj?=
 =?utf-8?B?MTdSbHQxc2pMZWYvRFFocHlqaS9nRHNaalhlN0pXSzYyNW5oUTdkRFd2SnRU?=
 =?utf-8?B?TFhBOEU5alZDTXRNSG1BSHFSeFFKVjNhMTNub1hPZ1lTVXVYemQ1enY2eWJF?=
 =?utf-8?B?Y0tnL2dxVjlmMEZGMHpUaEFNRzVQdVo3dnp4L2JZTDZwQkxJdXNEY1dlbFp2?=
 =?utf-8?B?dURBNVVzZGJqeWtHZkY5ZCtzbWdmNmwzOFVwMU1venJGaG0xYlZXUDNQcXhk?=
 =?utf-8?B?Q2dWbFJ3QmpWcFl6eDV1THZTSmpuODNXYXE3NXMxekVLZ2hldHgyOGRPeDhs?=
 =?utf-8?B?alRqUmVIcTIzSFFqY3hRbDl1dEdnbWp3ZWx1UjVlQ0hIWDcyNUQ5WGpqSk1S?=
 =?utf-8?B?RC9CUnptS04xL056aytBdWJQanhVZDRMTGl5SE91Y0RQVFdHVnJrbElBbDZu?=
 =?utf-8?B?YklXWnh1a0tQakM0aWNPQWlOeDBrZVlsSkhwYjh5SzVPa3RkcnNEdXoxcitY?=
 =?utf-8?B?V2ozWWlsZW9TenlGVTNuMkdRNkZEeCt5T09jRjhFT290ZU5aRmtsa2ZwTUhh?=
 =?utf-8?B?ZG9IczQ5VlFFN1FBcFp2YUdwL3B3b3Nhb2ZES3Vwc3piTE9LeG4yRkpUZXFL?=
 =?utf-8?B?RzRDaGR0TTZYN3luMHRyM2MxenpURTcvM3BTRkRkWkZKYXdGemFESW9uNGZx?=
 =?utf-8?B?dGtkQjdjaEJTSU13d1ZHSExzbkh5WXQ3S0t3VmVRM0NpQ3lZZ1NVK0dCQTRQ?=
 =?utf-8?B?Q1JETHRLV3l5ejhHR0s5REtvZjM4dFNudkNNRDJidHZlaHpSSnA5Uyt4S21Z?=
 =?utf-8?B?cDJYeHVWaTBKRzc4NkJYS2VpRnJtKzVuaE5XYmRCQTBsanJYQVErUWxaSHBi?=
 =?utf-8?B?SXRsMzU0cXU0UnpDaURQcFVvVERoZFVtMFNIeFVmR2p0MFJVRU5Ub1V6dGYx?=
 =?utf-8?B?V29uODN1aS9BUXBkYUZBQmkxUUY4cUJoYkwrSHIyVmZ5TDBkdnNObXBZTG8w?=
 =?utf-8?B?S0tkR24yem9vSWlSVUk0ci9xeGJWeE02Vnl4bEhjK0pYZ2ZyRGU3S3NVNG4v?=
 =?utf-8?B?T3hpQkw5bVhRTnQyb2MrNUlwU3Z0enUzckJ1WTF4Q3lRak5abUQxcS9kMkkz?=
 =?utf-8?B?T2dGeWY4RlAwcGNENnRqVjF6c3FKNHdCSThXOXZGc2tvUE1SaTYvR2ZkZ282?=
 =?utf-8?B?KzY1RzlLWDVQanRETkN6dXc4TnFlK2Q4TUQ4ZGV6QkQrN2d5L0pqT2tJWkVD?=
 =?utf-8?B?VDhzNkJSbisvL29udHFLeHdUaktTeFRKU3BNUlpHd2ZUUklDYnM4bzhITXcy?=
 =?utf-8?B?U3Mxd2ZkSm1qR3pRZ3QwU3BuaEg4K2hQVFBVSEtIUGh0VG1zMWFCWXZUM0l5?=
 =?utf-8?B?b2toeFowYW0yNnp5eE5yeGxmK0crVXRaVVhmeCtTRnNQVTl4VXJTQ2drN2lt?=
 =?utf-8?B?ZjZjQjAwQVRSMVVpRWxvbVVQWkNPMTFFMTNmc3hvUnQyNkxDa3RRZUMvbTFu?=
 =?utf-8?B?dGplU2E4TEpvNTJLcGNoMEJlVytQS2cxaWJyT2N0aThRcFFMZ25lRjVNcVhM?=
 =?utf-8?B?UkRRWFNMWGdQcFhCdEY0SlZnM3A0SzhIdTRJa2NMSTdscFRoZ21OOUJTUE43?=
 =?utf-8?B?MU81dHA3eWp6alZLQU9WaTFzMzlNeE1YY2V1U3l0SmU2SGI3L0ZnR2taNWY4?=
 =?utf-8?B?WDhSaVVsUVBkdG0zZzNiblBqalRHdmJPZDdyZnB4NDg2MytjeS9mTzUyVGpF?=
 =?utf-8?B?ekNra0JVVVQ5dU1xOHZETUs4OWx5YStJQ2FEWkwveXoxOEo1d0xjRlN2aHBE?=
 =?utf-8?B?MFE4V0ZudVpocTZ6ZTVqTE1HUmdSN3h4N09OUTlFeWZOOGtmMktJTmk5NVZi?=
 =?utf-8?B?eDJiTElUb2xGcXdzT3FTeWkzUXBUd0NSM01MOXBvTEE1MmE3WXdPTmpaOWdY?=
 =?utf-8?B?TDFYaTI4TFJIWWxoRFpiVWF6UWIrek9RWE9uSDg2K1l3U1ltZVRJNUdQNnU4?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2f0101-7c1c-4383-58fb-08ddc6129cfe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:49:00.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2xf60+X/qGOiX0a6sYUA4QH0nFptPJAEQXwo3lfzOXXyOQQ/S2ywvz7asmpvCap+hOwup7HNaTlbk9Ljg2xaLudCuPoPR9W7QZeWP3hkEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4995
X-OriginatorOrg: intel.com

Hi Shaopeng,

On 7/17/25 10:55 PM, Shaopeng Tan (Fujitsu) wrote:
> Hello Reinette,
> 
> Do you have any other comments?
> 

No other comments from my side. I expect that you are wondering why this
has not been merged yet. It does take some effort from multiple folks to
get a patch upstream. At this time this is the only pending resctrl change
that is ready for inclusion via tip. When I considered its impact on
resctrl together with effort to get it merged I decided to hold it back
to be included with other resctrl changes that are being polished at the
moment. Please let me know if I missed something and this work should 
actually be handled with more urgency.

Reinette



