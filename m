Return-Path: <linux-kernel+bounces-869559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77349C08293
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C09825017A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFAA2FF650;
	Fri, 24 Oct 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8GIy1O6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258CF2FF17D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340364; cv=fail; b=bp017RrSTyMIlrVwVKZJSSvk9wbLeQ9ejnuGgFqlGKaHc7TVgYO/YnxB849jPNtPHpzkyBkfQ8ayI+ByRs9DY/g1owZystd9DtCDyX3qn2XJex2r8hM9e6evMrtwLnXaZasdtTVqrNL3B7W0jJNcS05mly9XFrPDh6Is5Y3d/NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340364; c=relaxed/simple;
	bh=kyca6j0TWp/HYWEACkhot0H3nabEDlVcgyAIE5y3bf4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=u+f/q5VqOQtAYatxUjU3vnITYvIb5pZoSe7Xi2EpZCzAD1HWUFpDfDoxNeJJWEfiXB5/GwiDGV//4tLIZRxjlP5VnAq7bRSczX1ah6cGZwu78+aRcvQe06CUwuWL9jBltOVmC2sNsuIN/MxiTbxY2+maDcqdJOcavLlA/7T02uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8GIy1O6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761340363; x=1792876363;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=kyca6j0TWp/HYWEACkhot0H3nabEDlVcgyAIE5y3bf4=;
  b=h8GIy1O6L7QQEiAjAIhd8NRouGsWzVqFHZSXOXm2v7A9YPwR0dQIV2Ve
   MoBfn5DMh25d4GR+0zf9rIZKi8U8PNuj9husAABMBhViM4BQrVtG49LY3
   9Bny6FWrApC3N/SsjWUQoCS3/yKNeIvjdqir1bvbsPfRJT/ho+B2JNs2t
   pV4cHyhhsPTXVy8gw0sfDFHU/omn6iJiKrJx9Jwqoqi9pG5QKbvBC1b7M
   GYa9fT8gAo1LOJQM3IMjVcWgglsPwfDYSSCUp985wyltvXKAmeCrLwYEm
   OPXkEEpO5ttilPA1Uya/zpowOmN4k4z09XoUGodH77cFlRUbfvArudxVc
   A==;
X-CSE-ConnectionGUID: zpW9OFuYSd6sIUuuS9DSfg==
X-CSE-MsgGUID: uio6BP5uR8GDm4obxbfNUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74871560"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="74871560"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 14:12:42 -0700
X-CSE-ConnectionGUID: ebA3BlrHQX+UlgdqDvUPYw==
X-CSE-MsgGUID: WniMMIGpT8OTjWEUnFG20Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="189649370"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 14:12:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 14:12:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 14:12:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 14:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad9Vqt0WZwzaCm8UhR6aGxN9RVQwFTMvYefxA4WVSNAb8GldX8t1Dq5r1XiUpgdDRNA1k182XxUh2/RgAR6WaIjkdgdltFoktz5afrq/P5kZolBk5aUhDdJIK+rHsm0KBQlZU9bYuw09+JQi6v/IW8sXBtGLM3l0KFsZXSsaUVl8WPmT0ezuhenMt8nko7T7F2GM69ARmFZ3Z9+XSiUaOt4OLB+sZu3M+yFJP77gL5Lp0zJxOkuFXhOqHgDFooMRfk53yTSNVr6v5Y82xhdl5VVPdS28m7QJBFXAMBLbNfCnRC7MYYfhtgiE5QNCOWAuJOkA9gG8a8LgP3KK5+G+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHafsvDB3NvMVXS3LRkegM2Qfek1hbG5lCZXC3392ZM=;
 b=A5pi5nz36a4MFlZ5Jq5yhXyHvfvVatrVTs2rvzMzDXBS1swaWJ0UwVnwU0oF6R2trrG4SMfRyIiAcaRiKs9vd1aPFrWQHRniGlam01N3z2yNKUYIej0v4l/EajcLsxTfBmHEe43k9kNN7xc/NF4CsvUjN81jq2U2RUmYkpkdYJPBzQoiR+RytxnqILJvovmsepKbfc2nvpvrhtD6/TR8l90FtFlsdY612SvkSnLBu6Up/ZBRvAstEDYKgC9RSyipjUNBwzL2Ot2B+wRT3vasGkgItC/0bcksBh0D6tZBsOEhJlzKTjrplIceNV68I4PW4NwcyZ9nfIH/gxHsztNpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:12:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 21:12:38 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 24 Oct 2025 14:12:37 -0700
To: Dave Hansen <dave.hansen@intel.com>, <dan.j.williams@intel.com>, Chao Gao
	<chao.gao@intel.com>
CC: Vishal Annapurve <vannapurve@google.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Message-ID: <68fbebc54e776_10e9100fd@dwillia2-mobl4.notmuch>
In-Reply-To: <2e49e80f-fab0-4248-8dae-76543e3c6ae3@intel.com>
References: <IA1PR11MB949522AA3819E217C5467B51E7E8A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <5b4c2bb3-cfde-4559-a59d-0ff9f2a250b4@intel.com>
 <IA1PR11MB94955392108F5A662D469134E7E9A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH96B5K9Hk5h0FgxSUBa-pik=E=dLrO-4oxx76dxb9=7wQ@mail.gmail.com>
 <IA1PR11MB9495BB77A4FAFBD78600416AE7F6A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <CAGtprH-h_axusSLTWsEZ6QoxgmVs0nVknqNJx-iskpsg_qHKFg@mail.gmail.com>
 <aPiEakpcADuQHqQ3@intel.com>
 <CAGtprH8q5U6h3p5iDYtwRiyVG_xF8hDwq6G34hLt-jhe+MRNaA@mail.gmail.com>
 <CAGtprH9bLpQQ_2UOOShd15hPwMqwW+gwo1TzczLbwGdNkcJHhg@mail.gmail.com>
 <aad8ae43-a7bd-42b2-9452-2bdee82bf0d8@intel.com>
 <aPsuD2fbYwCccgNi@intel.com>
 <ca688bca-df3f-4d82-97e7-20fc26f7d69e@intel.com>
 <68fbd63450c7c_10e910021@dwillia2-mobl4.notmuch>
 <2e49e80f-fab0-4248-8dae-76543e3c6ae3@intel.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0e076d-16c8-49d6-00fe-08de13420f7a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmJ0QkpBQm0zOStTNVBSc2pVOHBCQ1JjbXhXU3hZbU1ZZElBK1VEZ1dkNUdT?=
 =?utf-8?B?Z1VYcjNLR1BaRTNMOXpTVm44aTBmMFR3TGU0MXN2bEFUU3c0cDJ0Rlc4aHlI?=
 =?utf-8?B?MG53dTJOeWdoUFFlWEdyQUkwc3FKRlU2VFQzbUYzMXFMdjRDYUpUZVduaTlB?=
 =?utf-8?B?VnY1M0NjbWQyUUlJOGhqRHFNOUhKZ0Z6TjIyc09RcGd4S1RVay9ZYmNMSTNQ?=
 =?utf-8?B?UkVKOXFPdkZtUUFpQTVnYzF2eWhxalFRNjczTHR0eFZjSDJYU1paMFNxcCtP?=
 =?utf-8?B?KytTNlFBN3hwMnlkS0hSb2M0Sm45dWt4MjRXZFFTaXpGWTdkTHFPcGhHZiti?=
 =?utf-8?B?ZG1kOWV6b1p2WWhTeFl1KytyWFFDYzNJZGhwR1A5SEZxYjBNMGx4SGJUbm1C?=
 =?utf-8?B?Z281MEVvVmhxQUpSbFVMSnV2R2dDUXJDeS9wNUtYZGxlSUxPUVRqRUhnOEk0?=
 =?utf-8?B?bXB6dENaSmM2MUJhR2lPYzNzdDRsc21kendsU2wvclRtTDFXSmprcTAwM2Rx?=
 =?utf-8?B?NzBmU1hIaW8ybXpWcFhBWUIzdDZGM3ZyVnMxVkswUWhmSTg4ZTd6dmR0Ui9m?=
 =?utf-8?B?QXhaRVhqWkVUejRra2lPUXFsRzFjTE9TZGFTYWtpaXdvdTllUFUrNlk0S1N6?=
 =?utf-8?B?bm9oYTZ6bWFlZGtxTktDMUZOczhGWkNVbHRjQWZnLzBmRHhZK3JmT2pXVnAx?=
 =?utf-8?B?ZjBaQ2Y4bUlINkJndGJoQktJRkRwY3NQRjFiOVZKRjNvTUh2eDg2UGc5QTFC?=
 =?utf-8?B?RU4vcUVuUmpLbC84dzdIRksxd1d1ZWtzc0xZWkdTbkVmdVhqR0lsV3B0WVBM?=
 =?utf-8?B?NUVIQk5JMVFjVHV1bGhYaWFLZGdVaTBCbTMrMGVPYnB0Y2RKVUVjM1I0OWw1?=
 =?utf-8?B?UnpwWE9HcC9SdlJtelNTbkxXTFhVanZndUxZM0d1MWNVZmtGQ3g0cnRKR1VU?=
 =?utf-8?B?SjVTK2lING5tNEJyRmF3VmQ0QlU4aHNUTnUwZ203WkR0NTFkK09YMXJwWFNI?=
 =?utf-8?B?dGROZWhaTWFSZjNoQVJLTHkvQk1XbVFtT0g2S0VqOTFnbHRSRzBkekZEclVa?=
 =?utf-8?B?VVNMc1gzcC8rZUcyUkhYTmwzVURkR1RCV0VYYm5BeXJhdDVobHE3cFdqT0dY?=
 =?utf-8?B?YjZjbC9WdlB6Q1BaeGlYMjMxbko2OVlrNnNsT0t5eUVDUDFWNld1WXNQOGpK?=
 =?utf-8?B?SmNJT003TnAwalgzeVhBVVN1Y1I4b2dLV2IrWXlvdE11S0EyU0FaSWlaN3l4?=
 =?utf-8?B?Y2lXajFkWHgzSlprMXBtQ1VpejZub0wwZkFSQVdEMUUxWTdlQWh4dlo4ZHc5?=
 =?utf-8?B?OTRzUVJpNmtkMmFnekpFYloydHB3aGI5a2NRK1p6elVjNDVmTjYzbHBjQlNx?=
 =?utf-8?B?eXNybTEwU044djJHVzE2MEtaMm9WaFpGL01ILzhlYVMvWTJOMVkyc0FVTW1C?=
 =?utf-8?B?NlF0YndMRjN6Vm1qNTh2YUcxeFpyTDJpVVdudWFGWHdmMjJDUW9FaC9YdGd4?=
 =?utf-8?B?elo3OXdnczZtMEs2Qy85c2RmYjl2bGRwa2t0Rys2ZlZhMGYrV0dRTDlRM1BG?=
 =?utf-8?B?cGo1MFZuVnVKTXNzVFpkcmpvOEMrWGp6bmJjc210NXA2VzBGTVRFU2xuQjFi?=
 =?utf-8?B?dnRVOVZ2eDdTTmFsU0dXMzNvZVhBbzhyaElWd0lySlFlMlduQW9vMENyMTdJ?=
 =?utf-8?B?TTRlMm5NNWUycHF1d20xWkV1c1N1UEZncWF5RFR1czhLSzVwSmRkVDN3cE11?=
 =?utf-8?B?Q29Ma2xiSHpnN0J4MmFKK1ZHbTZXY3g0dGNLQXhNWFJFa0FXdmp1NHlWVVRz?=
 =?utf-8?B?MEpUWFJQTHBFaTRkZXgrR3VpNkNXSTBtaUZ4NUNQOEVMZ21OVFA4RXhsTUhJ?=
 =?utf-8?B?clRRN25HVHAxSlF4WU5jdWZjRk9iVE80MCt6L1NRRG5Zd2cyd0RlL0s2cUps?=
 =?utf-8?Q?OzcL3P4ggRAaQYzGTgwgQiMt+tG+FQYD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1YvVUpzUi9GYks4UmZXaktYV0hlQ2RKMUNxSEdtcVJ3dFlobkcvVDVSdktj?=
 =?utf-8?B?Z0lFdTRoRGprenhqSHNrbkw3L28waHgrUC9RcURQbWRMdkYzTUw4b2N5OTVZ?=
 =?utf-8?B?cWR4NCtXaElWdm1vQXl3UFdWejEyVW5iSUhPYU5pN0VsUHcwWkROTU5iOEsw?=
 =?utf-8?B?VHNOTFRSZVdreTVzb1JiYnA0cHdDTDd0UFhBaWdJVWRXbHU5QTZhYVFpTkZu?=
 =?utf-8?B?YVc2ZHBCbTZFUnN2VlBjVUdibmFQQjVsY2dnbzBxS3lrZ2Q3ZFRxT3ZIalZW?=
 =?utf-8?B?KzU2NVd1Nk0wSTdtOE1zY0lycnVXNzNvbEtFdUdiYVlXd3NsK2p2TFdva3p3?=
 =?utf-8?B?b1F2cEF5U2x3czRtVklvN05uaGYzamtIS3M4QmY2bU91T1IraFV1b1R0VVo1?=
 =?utf-8?B?SmNyYk56aFpZVXdiN2tnQUJIMHNNelZKRnRMRW1sZFNNd2ZzbnowdTN5SUhK?=
 =?utf-8?B?d1dWaUxXQVN0c1FQcFV2UE5tOXRua0RJL3E0OWJFY0d4V0lScCtUemliamxE?=
 =?utf-8?B?Lzl0eWdPNndESnRNQVF0MFl2dUtsN3BEU2hzeGVSUXZBSUlRVjhtSWdWcGc0?=
 =?utf-8?B?QmdkRUREc2VZb2hzckIyVWwwald2eGw4K2FWeFIyUE9ZTmt5S09OODlJSG8w?=
 =?utf-8?B?aTRPcm5sREZ2aG1TTDdMNUtYSXRvZHpITmJsM0NqNUFnRy9nMklFVGFnT2Vj?=
 =?utf-8?B?d3BzalJsSlFvam1OTjhBT0tvcHB0Z1V4RW9mRmJscC8yeTV4aHFnUlVyZjln?=
 =?utf-8?B?MTBWK0lvRENENmFGRHJrQ1FaZjBaM0FmTnVHcmxQWEpDNEZOTnFjMjJqRDZ0?=
 =?utf-8?B?b2xjLyt0b2RjYUpYOVlxLzN3VGVKVEZiYm9kODFLaW10L0k1eHgwbmhJaUlK?=
 =?utf-8?B?QzFHVCtka1VYSThudkZQMGpQcmdMaFBFTnp4ZlRjY0R4djRqeHI4aXp6QWNl?=
 =?utf-8?B?ZHE0Vmt4UjQ2Yzk2Nzg4ckM2MzNNYjFBTlJoL24wWHRQRmVpY2t4aGdHMkkr?=
 =?utf-8?B?QzdWN2dWS2Y4V2RtZ0ZhK3JRVmZpbUhseC9NRWZWdW0vRDVUeWptVEczTFdD?=
 =?utf-8?B?eUdhbWJlam9xQUNzUnV1L0hMUE9NRUJCWW51N29tQjdETUI2eVE3SGpmenhy?=
 =?utf-8?B?eWVXbFo1akR3cHdIaTRkV3dVQ082cmg2elNxaFF3Q3ZNMEFMVzh3dEdSdnRx?=
 =?utf-8?B?cEFsZWhOTmNnU25TYS9nSUpxZUc3dGQ3czB2RHpyR2tHenRPd2dWT3BOZ0tq?=
 =?utf-8?B?NCsvbWQwTUMrUEZrSGpTRDY1cE41WUE5cmtHWmVTSVBPYlc3MHBJUUZXK0tv?=
 =?utf-8?B?NGlYMFJHcFJVdTZ3ekxSd2tSbEVpaXhPM2ZHb1hLUGlSODF3VjJTRU95NVFz?=
 =?utf-8?B?SVdYSW9ZS09vem80OHpESjJYdFRrcjRZaStqNEpObjBVNTdUZ1hyalhpeEJW?=
 =?utf-8?B?SGhqWXN0blEvQUMzaGcvd1lzQnE2VDdmV3F0M1dWdGpQSzFENGRaV1pTU0Mz?=
 =?utf-8?B?WXdDTjYyUGFLNkxSanBrMnQ3cjg2a0FleHcvVmRFTzFDY09ndVQ4MUVrRytC?=
 =?utf-8?B?NkV3UHVGbEpSVTFsekdSR2lzLzRrbi9XY0ZCS0RRK0VrVW85Z1NObUhVdFFJ?=
 =?utf-8?B?anN5SDNSN2hOTG92bWV3RmlxMTlncS9kTjJJYm00WUQ3UTh4SWlMWkFlMExk?=
 =?utf-8?B?U0FYOGRqOUFNTWI5TFlNRkU2OW9WaXhJUTFTdm90RDhyYlJoY1dCRmZQSEty?=
 =?utf-8?B?V0J6NU5vbytyMmFVUWhLRUFrTEFXVnRERitOMFRlT3VPUWdzSzZ1STdlZkQw?=
 =?utf-8?B?YVZON1BvYVFxeDEzdnRXZHpNdjcxZUFJMDl1aHEwbDc4Y3JCY2w3RjhKZm5X?=
 =?utf-8?B?WXRBRm1MMnhUakUvY3l1STBTUXFnWlordXZwcGFlZlJXS3NuL3AxUWwvZUEr?=
 =?utf-8?B?eEVLTTBrRUZuZXRReFR3Z1lNRFJaemtXN2ZNK3JpRWo3UVJ3UTNCZ2JldTlF?=
 =?utf-8?B?VVpEOWZSbVVqbm9ycGJEMk1FYlRVTmMxYlN2K04rRGgxNGtMOFdVWWZ1YWtj?=
 =?utf-8?B?c2dQdFJYcTZvelBFb1RNVm1UU3VPa0VuTXByeThONW55RTg5MTIwOWJOeGk0?=
 =?utf-8?B?bXdMZUJRaFlOdnpsY0JPckswak5tOXJFWHdvLzJGQmpJeWpvN1c0TU8yL0tw?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0e076d-16c8-49d6-00fe-08de13420f7a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:12:38.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl9YIJaIoH0KHRezLboL3GQpFurOGqO1U7jWQ3Oo5EIv6jOjTBcyRSnZiGabOiq2WRropOlCsit0v+yzMU5OE8XMymdAoTNDUgdWS6lSaZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com

Dave Hansen wrote:
> On 10/24/25 12:40, dan.j.williams@intel.com wrote:
> > Dave Hansen wrote:
> >> On 10/24/25 00:43, Chao Gao wrote:
> >> ...
> >>> Beyond "the kvm_tdx object gets torn down during a build," I see two potential
> >>> issues:
> >>>
> >>> 1. TD Build and TDX migration aren't purely kernel processes -- they span multiple
> >>>    KVM ioctls. Holding a read-write lock throughout the entire process would
> >>>    require exiting to userspace while the lock is held. I think this is
> >>>    irregular, but I'm not sure if it's acceptable for read-write semaphores.
> >>
> >> Sure, I guess it's irregular. But look at it this way: let's say we
> >> concocted some scheme to use a TD build refcount and a module update
> >> flag, had them both wait_event_interruptible() on each other, and then
> >> did wakeups. That would get the same semantics without an rwsem.
> > 
> > This sounds unworkable to me.
> > 
> > First, you cannot return to userspace while holding a lock. Lockdep will
> > rightfully scream:
> > 
> >     "WARNING: lock held when returning to user space!"
> 
> Well, yup, it sure does look that way for normal lockdep-annotated lock
> types. It does seem like a sane rule to have for most things.
> 
> But, just to be clear, this is a lockdep thing and a good, solid
> semantic to have. It's not a rule that no kernel locking structure can
> ever be held when returning to userspace.

Sure, but I would submit that the lesser known cousin of the common
suggestion "do not write your own locking primitives" is "do not invent
locking schemes that involve holding locks over return to userspace". It
is rarely a good idea to the point that lockdep warns about it by
default.

> > The complexity of ensuring that a multi-stage ABI transaction completes
> > from the kernel side is painful. If that process dies in the middle of
> > its ABI sequence who cleans up these references?
> 
> The 'struct kvm_tdx' has to get destroyed at some point.

Indefinite hangs because a process goes out to lunch and fails to
destroy kvm_tdx in a reasonable timeframe now has knock-on effects.

[..]
> > The operational mechanism to make sure that one process flow does not
> > mess up another process flow is for those process to communicate with
> > *userspace* file locks, or for those process to check for failures after
> > the fact and retry. Unless you can make the build side an atomic ABI,
> > this is a documentation + userspace problem, not a kernel problem.
> 
> Yeah, that's a totally valid take on it.
> 
> My only worry is that the module update is going to be off in another
> world from the thing building TDs. We had a similar set of challenges
> around microcode updates, CPUSVN and SGX enclaves.
> 
> The guy doing "echo 1 > /sys/.../whatever" wasn't coordinating with
> every entity on the system that might run an SGX enclave. It certainly
> didn't help that enclave creation is typically done by unprivileged
> users. Maybe the KVM/TDX world is a _bit_ more narrow and they will be
> talking to each other, or the /dev/kvm permissions will be a nice funnel
> to get them talking to each other.
> 
> The SGX solution, btw, was to at least ensure forward progress (CPUSVN
> update) when the last enclave goes away. So new enclaves aren't
> *prevented* from starting but the window when the first one starts
> (enclave count going from 0->1) is leveraged to do the update.

The status quo does ensure forward progress. The TD does get built and
the update does complete, just the small matter of TD attestation
failures, right?

Note, we had a similar problem with the tsm_report interface which,
because it is configfs and not an ioctl, is a multi-stage ABI to build a
report. If 2 threads collide in building an object, userspace indeed
gets to keep the pieces, but there is:

1/ Documentation of the potential for collisions

2/ A mechanism to detect collisions. See
   /sys/kernel/config/tsm/report/$name/generation in
   Documentation/ABI/testing/configfs-tsm-report

I really would not worry about the "off in another world" problem, it is
par for the course for datacenter operations. I encountered prolific use
of file locks in operations scripts at my time at Facebook. Think of
problems like coordinating disk partitioning across various provisioning
flows. The kernel happily lets 2 fdisk processes race to write a
partition table. The only way to ensure a consistent result in that case
is userspace sequencing, not a kernel lock while some process has a
partition table open.

