Return-Path: <linux-kernel+bounces-797557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E850B411E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17EC561A65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A331F2371;
	Wed,  3 Sep 2025 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDYbA6ps"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161271D416E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862449; cv=fail; b=FO6n0a3pATXvsAgt/vbVywB5zjScJLrE5nb+ogBZzpX5etOWaZeW1gvhyoP6Wfxt0p1dFiP4KehMCS7QLVKfQD789kD4d6oAhpD9NdR8j6/EUSyLWRFY6qjtO4w8tbkgtU14pYNfV3uY60PldOoLJ3/wxhyRw+VYIb/wr35rXEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862449; c=relaxed/simple;
	bh=R60ef56UKFA8XqGAS3oWgq+FbbDm4iqFKqO8uQZ9ks4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=XrcO5R85WMYbTCe+TPB5cDpZx79y358Xani9ea5/oK4FzChfmOtOW+b4LyVZiyDSMBvm+DsmMMgnLqQLIXoeCBLG3WvQBKblOKjzUrtRUTlO8e6Z6pqRYmFFRfhcZtn1pcYaeLDLkC4ee4yaE/mS7Esf1Wi8sR3pxneiV9oyJ9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDYbA6ps; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756862448; x=1788398448;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=R60ef56UKFA8XqGAS3oWgq+FbbDm4iqFKqO8uQZ9ks4=;
  b=PDYbA6psDBRssc8scr/0PgvKrWyOoBVPfytBLMeP7G3qsNzO0f/vodHq
   x/363AiYBIMGARU7YsfO507YZaHg+Zdyy5a4k+yUO9KDk5OixmHL7h0dO
   Yt/bAbfJ1v+HWsH0c2hW/nwi/NPI51TCBR7zDaCYJiv+BD6xixE4zjFcN
   BrgTFrf9FLXSyjTpFZIIzJ7D+Jf8xGevjQ9V4Bxg8QbJc1hmFhrNHRAkp
   aoQ5SiXJrAb6HEhHvorNMwGdUxaMxwEY8PTV8yV3ZWLoCA+e1CEzqTFjD
   9UIqgZ1cfCP5S/10WRFDHUh6eIpAX7gCvwf8jbwM3DELlwtcURbv386qO
   Q==;
X-CSE-ConnectionGUID: 0YjDaU36RTeEDHY7XDXuDA==
X-CSE-MsgGUID: 76AFvC8pQsar5BMw5SlDIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59300100"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59300100"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:20:47 -0700
X-CSE-ConnectionGUID: EDcLN955S2ebNrACx847hA==
X-CSE-MsgGUID: OCbyJQb5Qai2iRhgrssoAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171893413"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:20:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 18:20:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 18:20:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.71)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 18:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLgtrC105R0KB1Y1P0CUKZx+pfrGrgXUYGHay3angtWvUsIabumxUw2yhR9gLVGjeLiqnuPAc9W2301xDkIPVRTKzx0Gyjl+hWer/F16ab8NUgIsXzYNRdT+V3m85+exmWvoWWFu3ElS3hQk9JD55i/mtanuCdMiLGJCPNMwCatn6Ch1UFE1WYAUuXmMY637fsUIQ8KUWlllKjp2i+tu8RSh7PBJJntEuZduGV8Q/ZxvVBkn2jLJdvixXZPzH3fw7GZ4/BNf85VLw+DM8jQ8b7wXos5kPfHbp4guQukJLV/RmmdweM5q7GJXUFB3SJgNdfS76a8HQ3IStFJthKNMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCV/ubi9OzsRlQHj1RzJ5vqdfK1AKE0KFSoi6ia5BIA=;
 b=MNJfybnf9tte17ytPc03bYTqInYlO/If2vW2yMyFRiW5aqeGlgaerdLa3m1HindO8aCU5YCf96cIF2Ix1UK4OiyR8gcIp9FcdnYV/fLLlzBUM3i5p+x7WajPBvennDihYaf6gB+WooR3HmqVUDBrKkwZv12KExMFNREmnO3SvMG3Qy1pkBnGLfYAYgES1gTX1qa+YxQ74WEOI/yd6gfBFE6aYo4OsU1PsL99IqedTBVcarBuMwqQhzvFxHKKSnbb7/DAkwcw3Y2wy4DqFH5npqq1BWLZltB03IW4SejzzHCRuZ7a4loShFlfBYGRJmCQPWU3VHY8MFJDERhxqNW1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 01:20:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 01:20:43 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 2 Sep 2025 18:20:41 -0700
To: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>
CC: <david@redhat.com>, <osalvador@suse.de>, <jgg@ziepe.ca>,
	<jhubbard@nvidia.com>, <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, Alistair Popple <apopple@nvidia.com>
Message-ID: <68b797e9e270f_75e31002a@dwillia2-mobl4.notmuch>
In-Reply-To: <20250902051421.162498-2-apopple@nvidia.com>
References: <20250902051421.162498-1-apopple@nvidia.com>
 <20250902051421.162498-2-apopple@nvidia.com>
Subject: Re: [PATCH 2/2] mm/memremap: Remove unused get_dev_pagemap()
 parameter
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a2bf65-e571-4e78-b811-08ddea881a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE9relBaNVpTem56Y0JRN21RYm9MK1l1VnVQZytkb2JlRzBvbFR3K3pGcVYw?=
 =?utf-8?B?Qkh5NkREYWRTdVZVT0s0UG5HeDJBeTBuZVNtaEQxVEJLV2loRkFuWWVBWTJ0?=
 =?utf-8?B?V0lGVVlTN3YvLzV0dzBQUW5HeW1jUGFlRjhRNndLZXFyaFZaMDZjMzFVc24z?=
 =?utf-8?B?Qlo0bzJuTSthcjNCUCt3S3lEZHZGY1RUQmZ6RzhzaGxIbHQ3YkdNc1BqY0VC?=
 =?utf-8?B?ZmY2b3RHTkdVSHhxeThTakFyM3Y3SGFNblAwVldDa0Nsb1lvUFN1ajJKRUI0?=
 =?utf-8?B?aGc3RDNhMEI4Y2JOV25Yck9IaWJtc0w1c2EzV01aOXRCZFNXOVE4NnBVaW5i?=
 =?utf-8?B?NEhYanhTVHg5aW1tR3JSR2VKWXBnNDRpb1NLU3R6dnFscjZycUNMOTY2cmww?=
 =?utf-8?B?U1ViS2JyUW5SRXRLRkRLaFRpbzlaL0xwT2NCL1dUdS93Ykp1djZxZlJ6OEZU?=
 =?utf-8?B?bEVZMmZ0ekh2bXZ5Z3k1cWhtcDhINi9IbGt4M2FhOU84NVhOamFod2tKUFZW?=
 =?utf-8?B?QWtGYUdVMjFiOUhFY0NqOGhCdkNtNTdTLzVyVmFCaDRpRU1GWVdHcEZLWnNi?=
 =?utf-8?B?ZjZCMHFDZHRxeHBwZ2pPWlo4WVJWdm5odStMR3RBOFdOV3QwcVYrYTkwYjZi?=
 =?utf-8?B?WjF5WkNUWGE3eVc5M3pEM2Rld3N1ZTc4Q3FlRVh2cnZHTkFnY2RJYmNGeTNx?=
 =?utf-8?B?WjljNTN0YytnVmU5KzRUMmFjSkxsaE5qWVRocnRiTGx4M3orUnpjRHRMR2lP?=
 =?utf-8?B?R0dWUUFacndCOUtUdzVpdGJEUnhQWW5xblM5MEJjZGJhT0llV3E3UFdCTGtC?=
 =?utf-8?B?Q1FpcFJESUh5SlRYT29GOWlmWVl0aHU2anlIbkdZZjlzcktmenlMaEpvL2Qy?=
 =?utf-8?B?SXNITkl6dG5TcmRVcmtYYS90S2dobnNpTG1tNHdNTGNDQmE4RC85TkVvcmpt?=
 =?utf-8?B?TVZBSDI4eWMvejRJSjZsSUNreUdGZWlZRTdvU0NST2IxU2xlQlVtUGZjaVBh?=
 =?utf-8?B?eENrMjdWSlVwY1l5SXF0OHYvU3ljOXFodnBXZ3ordkwwM3hnK0JYRnhQNVdI?=
 =?utf-8?B?ejRVZTMxZ04vbmhnQ2dKSm95cXJVd1NIUjY1NnUxcHJ5d1FvRHZjclRMWldW?=
 =?utf-8?B?bm16QnBvQWtvVGtUWWR2azZLYVNxVHkvOU9JSW9SZVFFL2NCd2tNa1JlSXVT?=
 =?utf-8?B?Q3hVbTA0dUJJSHJ1M215cmZaQ1NQRGZ2YkV5a0FuRDU2R1ExRm1renduaWcx?=
 =?utf-8?B?WDQ1SUp6RlVlT2FUdVcxQXlwYnd2NmtQZzBHNm5kOVJUUHV2bFE1SEtWRkQr?=
 =?utf-8?B?Q1YybXgyVG01czBiUzZzSjB6b2g4c3NUbUFzUld5djc4eC93MHJxR0RWQWEw?=
 =?utf-8?B?aFlwMWQrejZqTjVDSE8xSVA3OUpzV0JabGdFY2Z4YXVua1NnaU5Fc3VjZHli?=
 =?utf-8?B?WjFhY3Y2VVJjQjRWaU5nYUZQZEZTYkw3YUZIbjhkaG1GY1RMVU9POXVhVEow?=
 =?utf-8?B?bU5qcGtjWHB0S0dQNWdBc29PNVVKZnlGWXdWZE91QmVqeTNVNnlPenRGOU9V?=
 =?utf-8?B?UEFPZUhDbFVXZjd2cDdGcUVUUzVqZnJBZ2l4cVJOdVAzaXJhYWc4QzZjcXNI?=
 =?utf-8?B?QmsrN2thcWc0ZWs1eU96emp1MEpQQkQ1WXB0eEpLTWVISndjalNJblRFNk9W?=
 =?utf-8?B?M1pTc1Zka2FWYXR5UDZBTFBtTFhGcGtJcENONXlRajU2anVLRmE3dndMRGZ5?=
 =?utf-8?B?NVlTOVExNXUvM1V1MDVXdUQ3RWw1SkJFUCs0VVVvUENLZmJjVE8rNUVVQndh?=
 =?utf-8?B?NEdCSE42a2NmU2RKaHF0cGN0UHFqUUFCZHpKalVHR0pVQSt3NFY3M0xXQi9Q?=
 =?utf-8?B?dHU2S2ZSVDYzb3RIdWlGUnhZak9GcEVhTEl0VW5IQlh3alVxRmh6cEFDVnEv?=
 =?utf-8?Q?odDq7pAa9DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekljakE1TXo0VVdaNnRMODk2dEFrOHllN3hBU3pObXhLbTBMZkdKRmdaUkNs?=
 =?utf-8?B?MXVqSk1mL3VYdTFOb3N4MDNDZmROZFpjeUNaVlZrTkh4OE43Z1EwYnVFWE5r?=
 =?utf-8?B?Y0ZOcGRnSVhyTFQ2S3hZeFF0eWZMQkUram5heHhrbTZMKzBzSEVSSzhYUkV3?=
 =?utf-8?B?M0h5SEo3YllqTHVhcjJhbXdKZ1F2dm1KZzhna3NLVFM2VjllNCtBQjV5NG0v?=
 =?utf-8?B?UG9WMHBrT1cwNXAzU1FmS2szNVo4aTFPQUN2SndsTEF3cEpOcGRObnVDdlBI?=
 =?utf-8?B?L25zMmVqWWJqTEhVV0hBVzZENUFuWXdoazNqYlVybE5nV3V5YWNGdW9pOW43?=
 =?utf-8?B?SnBUZ1hVL0w4QVRZbWlzSWdnOXJUU1djaEtGZkxSL0hGaFBsQUFGUVRaV2ZH?=
 =?utf-8?B?MG1neDdrcmw4bVl5R0Z3eEhCNENFZmtmVnEvWGpydzBYMmRrTEVmeUppaEpM?=
 =?utf-8?B?dlV2SmQ1d2gzUUdHN3J3QXB4ZFJ3SUhkWWZQYkNtZ2dBMzFpNURneGQ1UXZR?=
 =?utf-8?B?SzVjVzMxL3A3bnkrMlBpaGFDNzU2RDk0ZkpobnU2Y2VCaWFGUGtTS29NVCt0?=
 =?utf-8?B?ODQ2WDJFNkRNUzhmazYrU2ZCYjZtZDVwMGNtcitCN3BQczltR1pRVzRZRDJI?=
 =?utf-8?B?dGRYMG8zQzdZV21VNzc4bTROR1FwQXZmQ3d2Ukp4Z2w2Mk9Sci9QTDVnSC9H?=
 =?utf-8?B?OE5NMUtNbzQ5aWlVaFB5NGRiVlo0cUJOckE4VWthd2hZZm91bUZ1SUordTN2?=
 =?utf-8?B?Q1NpN2hnVEFkdkl4eEtKUEw1b1dCRVFtOUwzZjJiK1VvUnQ1ODdUM3RSREVX?=
 =?utf-8?B?all1bnJzK1FuUUxJWHQ2Um5IcVdHNW5FSXRORFl3bVZwWW04QXRtazk1Y0lQ?=
 =?utf-8?B?WnVoY0FVOFFVOXFpejNiT0NqY3VwNDhMM2QzZG1XZ1Y3anBiWE8rZnBBVzgy?=
 =?utf-8?B?WlNYVVJCcStNaW9qcmU0eXU3QlZFUFY2OTN3QjhmZlRzRXlKbHkzOFhZUkhM?=
 =?utf-8?B?ZGJXa0w4UnczVWpVd2xMS2I5MFNrV3M4VmppS0FrTDh6NE9CZlhscjBTL1FP?=
 =?utf-8?B?dUoxeFVEK0hkNUVEYjhINFA0WWp5empNcW9rNkhMRWN6Q0FUdHY2ZU9wSDBX?=
 =?utf-8?B?emJFNXhLeWY1MHJIM0JIQTFWckQ0M29BWTFGRzJLSmxwd0J1dUJZTGkvL2Rx?=
 =?utf-8?B?NEZYTnlyZlkxcDgzNDlKeTAyb21OV1Bwcyt2YmFRblF0SU84enlka3A4MFdq?=
 =?utf-8?B?Y0VIZFYxd2NVSkNYU2NwUHNpd0kwcDA4RzNFbXlLR05LSjh6dndMWU1VZ2Y0?=
 =?utf-8?B?NkhRUjB2dTlCWUZOcWZVaFhUYWMxNm9Xc0RUdk9XRTFZN1dMRjVZblFnNGkw?=
 =?utf-8?B?NkVvYnUzSmduMFJiMlY3WEhlelk0V1V1NWVzVGI4RFQxOTMyVkxIdkc3SXRR?=
 =?utf-8?B?cG8zOWsrVENTSjYwZUx4TmZGQ0xSUFpJWlllT05KV3NKR2hSY29HZFp2eFFt?=
 =?utf-8?B?VWgzQURUazN5UEZwdWh5NkxtT3IvSms0L1ZVbGVMSTkvZ3IvY3VQUEtHSXEy?=
 =?utf-8?B?dUtXRXJmbTFIKzJFLy9sdEExNG9oWVZCTTVUeEJNSjlhMGFtdWFJdVJjN3R4?=
 =?utf-8?B?Vnpsb3Z2RmJ1TjJPbjU0RXJSU3J6TXpyVWRFSmc2b05WNTBaRmJqUHFBRURS?=
 =?utf-8?B?dXF2U2VqSXlrdEhMbGl4M3VqbWVhSFZKQldmd2t2OEk4UVp3Z2tsaWFQYnNF?=
 =?utf-8?B?U21tNUtjWGdrbVM5VVZ6NnFrNUFSb3I2dnhLSzJLVlpsN1phdWNDanJFcjNQ?=
 =?utf-8?B?VVlqbGRpRTVkTnJwSEZSTkF5TmVzbWZwZ0MwNGNzd3NzQmEzYllLSEFmV2w3?=
 =?utf-8?B?OWVXcFRNTUhINVkvV2tETzFKbVFqNDBoUW9EZGFqZ2xJN3VFWStwTUc4cXVN?=
 =?utf-8?B?VllIOVVReDdkakhrcFY1TE1iK0c3WlQxVUpITEtlMFpPZmlkNGdveXlHL1hD?=
 =?utf-8?B?RnNWN2lqSjdrY3RPcFhzNmVhbDFQWWpxUmNFTHBKYUtKZlZRcDlXSyt1Vkx3?=
 =?utf-8?B?WGtqeDRqZ1k0RC9wZVlVcnF6YVQ5cThqRk9qV25JekVsdng1WENJbUhRWC9J?=
 =?utf-8?B?VUk2RFhZc0cwV1hCN2FJd3h6enY4cVpWMCtrVW4wSUszaE4wMkphaHFSblkw?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a2bf65-e571-4e78-b811-08ddea881a72
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 01:20:43.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnpNckL1IMQs+mkBu2SVx1i9/Kac1ovp4fr85GQcC4EW4c/PsZz4P0jgMqdO6P1VHm5iZLFT0s21kVCTcFw9pUCWazCL7FODZn8FzfLTnBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
X-OriginatorOrg: intel.com

Alistair Popple wrote:
> GUP no longer uses get_dev_pagemap(). As it was the only user of the
> get_dev_pagemap() pgmap caching feature it can be removed.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Looks good after you fixup the missing conversion in memory-failure.c you
can add.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

