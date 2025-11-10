Return-Path: <linux-kernel+bounces-894186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21CC496FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02351886054
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F632ED35;
	Mon, 10 Nov 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kE3Fwcft"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA011EF0B9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810839; cv=fail; b=noUEDOoyxI/MmNfNnJ0Bzi7q04fied4iPzRFcBE9rT+TaYBxxZG6bKxjdnEpxlV/KudfAjutLxzSM3gLbneUTF+XlVyhk8QKUrU/pKqMSsrwwWVdD8C7ZJDX7Pzta4+pH5VlekAhFsCRGPQhJbwo+uyBKowIR0cacKn7txpjbFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810839; c=relaxed/simple;
	bh=PyWICkO+ffG2jpzVEQIeb12Wf2TKBVUTlcf9J3iBtKs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMv0vpAPCImdYldSuL31I4OQ9MC8QAERaBtkErgyXcVHeEPHup3kH8XpfBCm4XjxvpKwlACyV9Jiq0ipKmKuv8VAehrPXkGCbf5gzRUsz/vFpRxHocCuIjhzTRzS4FJAIuO+K5f11rbOcP/BMd6ewt5PPw/QoQWIIEEQhY+z9gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kE3Fwcft; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762810839; x=1794346839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PyWICkO+ffG2jpzVEQIeb12Wf2TKBVUTlcf9J3iBtKs=;
  b=kE3FwcftMy0VzYgolBFqf3ZeqBtojTaxx+xzfopITRbhmtzJZuagYD5W
   v77nROz6FmBkxUeOL9RSXUXMUs1W2VcsghCQzilNnFOatP6VgoFpajQ09
   Kd5iZP84wUHsk5PlEi9s3Mhw5xLJuGPjXxflPbCtGYKqUSAzWLLswqrDo
   n7VzmoyfQU8vb32e0c1gFf3BEwbIh9F6tMQyuKfjLV5edsSouDUGDyEan
   TIoV/vZ3FUXqWfqdQN1ahKx0R6u6TzBEGIFbu02olUOAHVbB2Mb1nPbpy
   08J+IZ7J57+csijnjh8ZWnRLHRsMFh0Fh8TiRyivF2hSFu522JjsvJyZF
   Q==;
X-CSE-ConnectionGUID: tdXzIDFsTmmHTwkVn7aO5g==
X-CSE-MsgGUID: NiH9sV9IQyiW5cpjLD6c6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68717880"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="68717880"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 13:40:38 -0800
X-CSE-ConnectionGUID: HrXQlOl9SkiSuxaLFkVV8g==
X-CSE-MsgGUID: OLddmZKlR++N6MzdSqH8sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="219495582"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 13:40:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 13:40:36 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 13:40:36 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 13:40:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUet5QWzAiXNmx6ULZhcmYX0PE1853tMiWC1ezR4GNMrMvrLe8TWq2DlNO/A4MAnbQFY2vtXZOnyi2lafV5C2SR3iva5cg+H3Uypykvr/9yIE5lKSnGPnH0DVEZ+kIXjfXIF6zK7aIjSuNGQlEtevClwctiBuRtCOaxtPE8Wj+mNwGM/d7LRmsQUFgi1hU6Bd+SBKsFoImp5ag9YJ42rh8qENhCrn/bauCScVI+U8kd9BtZk4+LdU8uxDm7CDpgTtbwkXbdK47I/cIiP9jFuLS+OlgjR0kWoswJF0ALFkN39Tf6MddAbb7zGyEaKG1XY+jfj0w4ixCbI5eo7TPTQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fVNIS57CZRZOC6EVvDN1/5f8RaIg9Fz9P5mQWD1xqU=;
 b=W4OzZJspWcOVx2iREb7U3T/pm04kNc+fa6V7V+K5GUHnN+Djri/jn/YJx9rxceiALCl16ukO59oupvGI4ViaMJtsGgXn1FohxR3s0wGCH1YqVD5RcmErRs8EQr/5VTPgamVOwuyUk/IFNcP6K86YRP3jbjOsC4vxtPcQSOc4aSrf2boW/PIz2FMFZcuJh+KK1ON1yUZLzNoFrhoH/AatyeEl44GfUE31lqSHhN1p+xlDW6C2FuVOn9T3DfSIs4oxWaoZbYq3TkJ18Xrg5b5hdVBs9dsU8oEBEFskX74j+/JdHJNh17Dxv1nPTKJWwHFhFXodRbem9AwIRpHtf8dlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 21:40:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 21:40:34 +0000
Message-ID: <f5ac9fea-1c57-419a-befd-1caf946d6005@intel.com>
Date: Mon, 10 Nov 2025 13:40:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: "Luck, Tony" <tony.luck@intel.com>, Babu Moger <bmoger@amd.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>
CC: "Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "babu.moger@amd.com" <babu.moger@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <SJ1PR11MB6083701B503CE361E3D7A656FCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <f4a043d2-9cb0-41c9-a45d-31f96fd007d5@amd.com>
 <SJ1PR11MB60836AB4270419338FBB4D1EFCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB60836AB4270419338FBB4D1EFCCEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 01464aad-3132-4a3b-630f-08de20a1c77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2tCNzlDajZOemRRVk1RL2JGWUo1U3VyaGFzVHlVdkN0SjJVdWpZVjB0WGhx?=
 =?utf-8?B?WW8rZVY1QW1YWVpjVlduZ0MzTEpYYTljQ25xTUZmOURFSkg0T2dwdlF4WnRo?=
 =?utf-8?B?NnpMRVc3K3VyRU1PYXB0SnF2ODJNdFA4d1pMYkxXVDNEaG44RFdmUWw0YkNi?=
 =?utf-8?B?b3BxRG5JNHZWcW03Tkw2b0FzRmZUbmd6T3hSTDdRTzBqY2pIbEwwZzU0RjNy?=
 =?utf-8?B?OTI0QUFCY1VGemdReDBxOGdteGFhMHNOa3NkUExLSXNFNmg1QTNMUTAydHZY?=
 =?utf-8?B?RW1lbHN6TFdWSy9FdW1ISW9MVzhKdjRzVHVyWkcrTkZLQVF5RnFhZzFvRnF0?=
 =?utf-8?B?Um41MWpkMnVyd0IxOEdiamZsbFdwM0x2N2dwbTVvc2xRQWpPYWpucmUxWXp2?=
 =?utf-8?B?c1J4dmg2TU9hZDhYeXFZSS91S250dmZkS2NYaTdFRXIwNnF6Q2RjeHdOUXV1?=
 =?utf-8?B?S3ZsazNmTEhmcHVjbnR5ay9rUVgvMHNjblBDdk5BdEtlV3NjbzVzcmRROFFk?=
 =?utf-8?B?QnFIZ0pxN3pyblJKRzdxYU43d0txQlpiTTFOdlk2M0pXZWZpWFZzLzRxcnJQ?=
 =?utf-8?B?a0xYK1hKMGpyY25QTFFreGhNZ3ppcE44dzF5TnBZR2JhR3lkOHUyaVdLVC9B?=
 =?utf-8?B?Zk00V3pnKzFhK0NqUG03MjY1K1NDWmc1Njg0dWhIbGw4M1ZBR3FuZWlXNkZv?=
 =?utf-8?B?YSs3TWxmWmVPVTBBMCtBSUVHV2F1NjJRS3NkdzNibW5aZXdUa0NKQktYZDNL?=
 =?utf-8?B?K3ZnOS94NXk2TDArcVFqcFFwK05rUFdMN0FkZmlucVN5OGlWZGU2ZjNOdVVK?=
 =?utf-8?B?VGExNnZZdUFxQjJZaEMwMTlwaXlRbndJbERwZm14SnB6c3dnbm91YmF1UWRX?=
 =?utf-8?B?TDRndDhVckhVTFFmU21CVWtlZFBUUVFqeTladGpjTmtxdjlQODB4RWN3Tmsx?=
 =?utf-8?B?ZW1PSm41ZzRuNU94SEJJK2ppbjMwRnlVNGpMaFZ6QS9HM2JGdlltcnYwYTlO?=
 =?utf-8?B?UGVkMkR4eHpOeWNuUm9tSENkdUVEd1lMKzZKUGZxekFVaVVQS1k1OXBObHhB?=
 =?utf-8?B?SUtvVFpnbEZES05uOGo3aE41WldLZXpkZFRZMzRqQmoxaFJzOXRJRnhNbm5a?=
 =?utf-8?B?S0lWTEVwL0pkeEN3TEVodUFxT242QVJuZFlITlEyb1VsenZBZnJSY3A1UnIx?=
 =?utf-8?B?eEtjUE5PejRsNzJuSVdKNEVDMlVtUHV4cGhFait2cFB0RWRJcGQ5MTZac1lo?=
 =?utf-8?B?M3lESjZpS2VwaWVWN2RETHozdmRxUDdKZWlmMVlmMHRXNFpOK1pNRTU0ampI?=
 =?utf-8?B?WHJLSjJSY0JMN1FEc0QvQnBqVU13TGxKNGFISUZvcFdGVHVBZHlnekNaR2VJ?=
 =?utf-8?B?L1VqUTlLTFRmblpjbXVMem04bnBkaFZGdlFSYWtVbkYwc2dWVTNXRU9MZzdu?=
 =?utf-8?B?emR6NU53eXhhRjdJUWQrcTZveklBc2F0UkE3RC85eVNORk51VGVwVFF2ci9p?=
 =?utf-8?B?L1BPSjErRitJWnIreEJaV0diWnhFUDJZZWlTMTVkRUFhb3NNbmxhREowbk5V?=
 =?utf-8?B?SVZvYTJZUk9RMzF2UThVNWlTd3MzMHpQaXpwRjl6ckFvSlRZR1NnWkVzS3pa?=
 =?utf-8?B?ZHRuWGdxcFBnTm9teW1YVmpSV0RQUmZ1YVJwWnJteTdVUW5Sa1VHaXFwd3E5?=
 =?utf-8?B?ZzRBdnZtbkgvTEsyMENJdy9tZjdyN2J5N0d0YllDczlZaHNMVFA5cTgzODlP?=
 =?utf-8?B?eTVLVVpTUkx0ci9VOUFIRmxGVHhock92V3FGeXY1cldiUWF0Z3lXMWVuT0JK?=
 =?utf-8?B?Z1VMdmVIaHpORklSbGdITzQyTHphZXFZc1NDZWxCalRhbmtKY01qZlQvai9o?=
 =?utf-8?B?eS9aMkpnM3kxYUtrQ3p4SzEwMU1UQlRUZ0pmbUxtN0xNM3BUUjVNbGNITkJn?=
 =?utf-8?Q?cZ9aIzrbrGC66W2aW4ZZvSFtKsd56Njc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0gyUk5yaS9uUnhjZGFPSWREeWlDWVZteXRtQXEvS1VKeWVNbjI3NVVGdmV0?=
 =?utf-8?B?ZDFjZVIxa2ljaHBZRzQralQrWXVkMllUK1NCdE93SlkvcWF1SktOT2ZzVHRZ?=
 =?utf-8?B?VmtadzI5QXZhUWFHK1diQ3dpdjNPeS9OS2V3R1hzOTdWb0g0OGxSallhcXYz?=
 =?utf-8?B?TWxWNUxLNmozaC9VeC9YQmMxS3VUVUxVL2N2dUIwT3BaNHFsUlpueTJEZHkx?=
 =?utf-8?B?K3M5TFlNVTc5c3U3OUZjbGpuRTg4UmkvSkxlaVgzSERpWFpCUmpYd2RhMkpD?=
 =?utf-8?B?dFNUR2FxNk8ydVErTWxLUXB6c2xTUVNRY0tFM29tWFU4VVlFTml2MTd5Z2pE?=
 =?utf-8?B?V2RNSmVVckFCdFphS3lQQWFDU0FaekRtaGx4alhtQmFzK3ZrclhRaUZVV2cv?=
 =?utf-8?B?Z2l5K1Bwak5qQzQrN3kyMm1iK3hrYXNqRVJvZ3laL3k5ckFSY1AzdHZUNVBU?=
 =?utf-8?B?VDBNZ0tOMGxZaEVjMHpmTDUzUDYxMnJkZ0VXRU82cnRFUHd3TVJhMHg3THQ2?=
 =?utf-8?B?akJHZTJiOVBJS2o1alJBNnFBc1RyL3Q3MlprN0NQTUNJS1ptTmIwRHdsMnh1?=
 =?utf-8?B?YzJPdmMrcDJxaE5nY2RVL3R5VTVqTkN4QUJnSENCQUdWTVhYS3JFRmh3dWJy?=
 =?utf-8?B?aFE0QUh6QXAvTjc4ZjEzWVg1amtPeU5NbnhweXZjeHlrV3dERW9WeFRkcDNn?=
 =?utf-8?B?UFh2Ry9XUTFHK2cyZUNBVmRyR01hd3psL3daVE5HU0FGVkw2OGhxWE53QmVp?=
 =?utf-8?B?dmRhelhZM1BnTmJVblFDMFJJTXoxZ2dXY2MzanBqZS9tSnZkWFEvUTdoSHhV?=
 =?utf-8?B?eDBjemIwc2F1NFl5eUtyaDBrY3NPZjBVcVpMK21yZk44NE8zYS91c3dZcEJL?=
 =?utf-8?B?Y25wd2d4QnpGWWQybnJlcVZkaUUvL3hGRDBNY3o0V3owb0Q2VVlNeEltd1pS?=
 =?utf-8?B?WVdvcUQyV2dWa2M0ejJXRFRmVjVsbkpJMG43RXc5ajY4M3RmcE1HWlpFbCt1?=
 =?utf-8?B?Rk4vdVFBcTRKMWtLd0lzSjl6VVY0TGEydC81RmU0eWUwbC9CdUpETE5CWG5q?=
 =?utf-8?B?a2gzSUpCY21kV2w2ZS84Qjhsa0hHWC95WkxnM1IxUjQ2anZvVHlHeW50MEhl?=
 =?utf-8?B?dkpNL2daVEZyMnFDOFNzZW9kRDdLZ2JyR2tacGhMTmVpTk10T0ZvUnBGVlFI?=
 =?utf-8?B?WUxlTFJmTGVtM0IwVmpzejdkbFNqTmZLTWpTVVZkK3JXM2JCbkU4Zkg0VzE1?=
 =?utf-8?B?dlNteWdsWHVzZVFuZTl2TXZJNlJyc0dFVHZ6c24zUjBDQWF5VDdzNWlvVnZN?=
 =?utf-8?B?eDkyTHIxUkVHOFhMUWNiSFlVWHRLY1BzREMyMGk4akFJZExOd3BBYjl1T24x?=
 =?utf-8?B?UDlnK0o2ZkI1U0cyb2svbEFHYkNCaUd4M1A4by8rZ0NiVytoUTRaQWNjUXF5?=
 =?utf-8?B?U0ptRWNEMjhaQ1Z4UzZFMDM5Mk5henBURUpLbEFVWDcwdkhpd1VMd3k2M09O?=
 =?utf-8?B?bUF4SnpYaVhtOFZPSUNsSVRTMy8yQnhua1ZDZW5MZkhUZ3BVSGRRdkk1RUc0?=
 =?utf-8?B?cHcrSi9qNEpxdW5zbE9SQlVKK2FYQnBpQWgwRFlzUllMNno2U3RxNlo2NXAr?=
 =?utf-8?B?M3B4TXdNQlg2c0l0ODNtZURlWitGS1FRYTZxTUlNeml4UjBzREhXQkROMlhH?=
 =?utf-8?B?aDJTNnprYTFuVUF5eG1acGRSZytZOVB2TGlDdThrTUFnTHJ2d09KTjIzNE9p?=
 =?utf-8?B?b1BMK3V2R05mRFI4OUVrVHhoUnRPN2lraGR0MUhZYldPVGtWbkN4R25JMVhB?=
 =?utf-8?B?UVVUeWVQODMvWXYyNG1WN0lKekRtRG5FUjRDN3NWT0EzQmY5dXoyd2IzMVhv?=
 =?utf-8?B?ekFKR2VlektRNUtqdWN4Z3NUbkRSQ21iR0xSTHNicFNkVzZEUjRIN1JseWdI?=
 =?utf-8?B?b0ozOWZOcHB5UHMycGduc1d3OXJDTmRjMkpRSCt6cDhsUEJYaGVIZXo4L1gr?=
 =?utf-8?B?RmJ5SDhWNjJ5aVVuUzFzcFNjdEdJSFh1NzBWWUs4TmlySFU2L1BIenFrYW0y?=
 =?utf-8?B?M0lWSXlzcHNpa3BvbmhodGR3V3FoNkNKYzJ6czUwaUpVNTF5akx4QkR5RHJq?=
 =?utf-8?B?d2dzOWFkYmhKNWcweENxcXZINjU4TjhYVXpTRUg1djZ1dW9FcVZiclpxVG9P?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01464aad-3132-4a3b-630f-08de20a1c77d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 21:40:34.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAHS5bOBm8TJTWiGP8OZco89OGGJIEI0+W10HtUPf5CgXRItOpLNMcYLcMSGwaN5lZDjitCiK+JZVwrIeYWdDaqCC0eU+dgu+v4/OkR+FOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780
X-OriginatorOrg: intel.com

Hi Tony,

On 11/10/25 11:56 AM, Luck, Tony wrote:
>>> # echo "L2:*=fff" > schemata
>>>
>>> would work,. But
>>>
>>> # echo "L2:*=ffff" > schemata
>>>
>>> would try to set unimplemented bits on some cores and would fail.
>>
>>
>> I would consider this a user error, as the user is expected to know the
>> supported value for the domain.
>> This situation can occur even now — we simply report the error and exit.
> 
> Babu
> 
> Maybe it was a poor explanation on my part.
> 
> On a hybrid P-core/E-core system with different L2 cache topology schemata
> may look like this (8 L2 domains of one type, 4 L2 domains of other type.
> 
> $ cat schemata
> L2:0=ffff;1=ffff;2=ffff;3=ffff;4=ffff;5=ffff;6=ffff;7=ffff;8=7f;9=7f;10=7f;11=7f
> 
> The proposed wildcard syntax is only useful to set all domains to a value
> that is legal for all domains. It cannot be used for the "reset back to defaults"
> case because different domains have different defaults.

Disabling and re-enabling of io_alloc may be substitute for "reset back to defaults".

The '*' syntax would be useful to initialize domains to minimal allocations ...
assuming all cache instances support the same minimum. 

Would it be an issue if user attempts to assign a value that is not supported to
all domains? resctrl could fail on first invalid bitmask and the last_cmd_status can
then be expected to indicate the details of error.

Reinette

