Return-Path: <linux-kernel+bounces-755498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2023B1A708
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E24516236C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033621930B;
	Mon,  4 Aug 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ6JCHkN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FE6ADD;
	Mon,  4 Aug 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323657; cv=fail; b=Qsa6+IWXb+KSjAFKg9PhL7qoAmPBZSRx/4f1yo30eVaeauSl3UgVQU9FwvGTuFxn/ORKIBL6EctFGlq99qH5jIFT/ognuRcBgCBcpdIcdIM+GtZfE9iiC3n/JsEFiOjBR0n/rnMf7nLK1OuWd3xmWzmLVc+0rshJ6/Pe4KE4k6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323657; c=relaxed/simple;
	bh=qfmhb1QWVgCrWOBCtXEZXpIhWQLQFqQbokl1rZvRba0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OrloSxuKa+WzRpVjhxGachk69iUXC/KQSdCJwMVDK5z5me+EOUS4NQE/JztLihVUvbDaKTfzH0K+1z7Tm4SrdjOprprBHBTqoGoZ0rJlp97kitz2ozB7XZaYqHIQUilvkla2XbjimapaWA0Dfi3hF+znKKzkk6l1lWcSGyLvaGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ6JCHkN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754323656; x=1785859656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qfmhb1QWVgCrWOBCtXEZXpIhWQLQFqQbokl1rZvRba0=;
  b=KZ6JCHkN7wPOIPpcCcnkVkHH+TibwQnU1LwJByXY0y9zqgWsBgGTlwYI
   C3JYP7EW4/agCmk0YV1L2V2xzhE50zMp/+5dC/uTpOi8WTdRRtKTuZyfI
   m20H12Ltgqtyufp+GPErhNTK8tVrcdA8/rXicCLBQgP6iULXoxyN6FOCH
   mFXpFpi+sI14hOvkT9/Yb6OAyQQ+W9AoZHGhqpQtijCBIG93jdUeElvta
   R/BAZN9uwYYxNWLdPLgtCwx1fNNFbSZATkbzkxS/24RlPDdyUURRhsX+a
   Hl7nbXxsba8pd4FKMC+nIsYXCZgzTi4ipf6cFRbjpblcR16YXvc6qHYeA
   w==;
X-CSE-ConnectionGUID: VEBFuTVZSCqH0T5BzswXhg==
X-CSE-MsgGUID: e6rxSJt8SLyz9Gv6ARfuJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="44184441"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44184441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 09:07:35 -0700
X-CSE-ConnectionGUID: v1Qgy/mES9C1I8HAF6d4/w==
X-CSE-MsgGUID: 4qMb6G8NTs2fD3hjhk2/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168651307"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 09:07:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 09:07:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 09:07:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 09:07:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPmEdo1AJgbwuoVRJ2V3xaRlWHmT+6xRDJQOqp2m0RqRK0ND/eqwQ8dzlVPvhIq49rsRhQZ8A8aWHVs9VvXiGRu4TXZnnFb+mih6qQxBs9ik1IE1otagrdKWFpGngtZk8apn0XHTnoH/QjgN4LB7+QfgplYT31wwYLG3LsqjF/fl6IxXV036TChWOQuEgfxoupzkz2dGMIImc3aPFd2KcGyURh+6ZJYo5wlp91nu1aQdUZhUSlf8WrmQIrTtIgaJZGeKtAWIN92/Jhe+SMQCiWKMSyNHfYUqe0ilQ8wXL5kgze+uH7dDNYGZN8Gk7GTCrlhRWTxvEjxB3dU2puQrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn290oAig0C8rfml5OlPt8WO8pvgP3YAHwlF38CvfUw=;
 b=BY9NuCHsMvboijx9nvyNxsd58PZo//LWEeItfPf3wDBi+GQ5mHGjUXaGgh/lgJNb11TYFapD3P8ZF+DuVSnrAiiRMOin06DCUqRaqAfoayuUCfeC57TLRT6cMYN73c851eqn03WuGnf9k0ubCH8h5nf1Fp6QAXvA3ZIxdWWM0VZsWZi+QpomPS6gqT7mJR3d0IBRt7m9L4VIvGhVNfYDS53gRRm3q4KoldeBfAYqcm77olHFbqWqpMDcG9dirvGcS35+ukMjwY6fHyjrRb4lbP1Yl4XcXMwgZ7G7nxW0HxyEXDanN+w3JAJcF/Qd7KkkY+mvvv6a7FtZCghxAVuz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH3PPF6CF64E2E6.namprd11.prod.outlook.com (2603:10b6:518:1::d2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 16:07:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 16:07:32 +0000
Message-ID: <d1c3b736-8dc4-43fa-9ace-acb26ac0f3e8@intel.com>
Date: Mon, 4 Aug 2025 09:07:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	<corbet@lwn.net>, <tony.luck@intel.com>, <Dave.Martin@arm.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <e311fd8f4ddfd33c29febdc71d5d41f8a06680cc.1752167718.git.babu.moger@amd.com>
 <ebd0a6bf-cb55-47ba-b9dc-65f56b065ab0@intel.com>
 <5c784fb8-fafc-4529-afd4-d1acb71aded0@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5c784fb8-fafc-4529-afd4-d1acb71aded0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH3PPF6CF64E2E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d769152-238a-4880-d21d-08ddd3710469
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1E2WUgzWThNVGdlY096UzdjQnhTR0Jabm5BU2w4TnRaQTRRbEVIT2pLZVlV?=
 =?utf-8?B?SStnKzFkTm5pYzRmZ1ZnMjQwRkgzZDFhQ2RscEJWQUI4Sk5RQ0RjRERTWlFo?=
 =?utf-8?B?RGxpOXErODhqYnJFbjEwVTZaU0Nic1dlSFBHMGFpbTdCUk96YXJDb3gwM1Fj?=
 =?utf-8?B?Y0FuakwvYTNNM0JHd2c3SFpGZ0JUYnJpZ1ZaUDhrOHZaV21qVkdIdk5EU0VI?=
 =?utf-8?B?dHZ3Z2FvOSs0cnM5enRNSTJWaGVvTStvUTBaQlB6bGlvekJBVGNianBzL05P?=
 =?utf-8?B?UTRHbmp2SXdiSHRBbkRCWW5oSTUwTjhHL3Ricm8vR3N1c0Z0clZMZGptZXE1?=
 =?utf-8?B?cTFSeHZHWVE5SXhIYmtWcm9wNCtHZnEwNE5mcGkvekZuV3JJbjZpMVNSWXNO?=
 =?utf-8?B?WGsyQndGaGs0MVV5eEY1QkFHcmdUTDlrdi8yWktaYlJ2YkFIQ1dUSkNtOHVV?=
 =?utf-8?B?Y01JQjZTamszU2Q0d2t6Wi9wamwwdWFqQ1pJUDhwbEJlTVlLWUNtaHRXNnRI?=
 =?utf-8?B?QXJvUWcxdTFOL0xiNGN6VGZiU1B4eFB2bjVIRjJNbFNUWDVFLzEzVUJ2bTh0?=
 =?utf-8?B?ZG1nSTZyR0tKa0pVb1RCL242bzNYOFBPYlVPK3RreElaZXMwT0lmVnIweTZZ?=
 =?utf-8?B?N05oMGJZY0tuZFF0aGpjZnhuRjRmU1ZzYWFkZjMvcm8zZks3ajcwc0ZjQ2Rl?=
 =?utf-8?B?UWUyWEo1Z0dIVDB3T2lQYW5JQjNjN1ppVys4ckVJRThEU2FZVnAwbVdXR05H?=
 =?utf-8?B?NWVuejRoazA2WGtFQlBnN2FvL2JaYU05eWpoSVBSSnFMSlFZSjZVTzhpVlBV?=
 =?utf-8?B?RTBWUUZra3FVRkJPOGN1MDlkUnN5S1VkeCtvNFBtQjdKT1NUUUMrS1RuOW1h?=
 =?utf-8?B?TzlDa1JIbzdzWmtxOVhVck1xY2hrVCt3TDB1cWNQNDVEV254ZFh4SGs4SklL?=
 =?utf-8?B?bk1iQ2FHTDlLODZGSmJ3bkNZVXZGT2ovVHRkZjJkNHJ5OHZaK2xjVHM2TlZx?=
 =?utf-8?B?TUkxNURPckdZNWpodTE4ZmpxODFBMkcrWXdsUFMyNzcrRWt6Y3ZUenJxbmRW?=
 =?utf-8?B?TVRRRVE4eGVPaE9PaklLL201ZHBBbTVoeVMza0NkMUs2T2xsVHBkZlRtbzJu?=
 =?utf-8?B?bDd5ajZlakRrKzliU2NTM29lZ1lMZjd6d3RvUjhoRjRobzBWaDJGakpmckw4?=
 =?utf-8?B?R0R2RHFMSGkvOTNqRVkxNGR0QUhoYW1OeHQzLy9ES04zd1dLZW1jQkVpTXBu?=
 =?utf-8?B?Z3dzdEo1aHhzVkRHY1VMK2prOUNHZzZwaFNyMXplZjBoSDNLZ2ljS1FOWUFj?=
 =?utf-8?B?WHlkM05WbWsySy95ZGY4U3U0ZHF2aitPc0Zra1A4L0ZJUStycWthT0pndmFn?=
 =?utf-8?B?cHZ1RHA3YWczRUNHUFIzY1liaW5qSXBvZjdVLzFhUFRmU2JOaTFJZ0FPVndZ?=
 =?utf-8?B?SHNxQkRPLzEvbnh2bFpPWndQVGpBWlFuMEo1dlBiKzk2cFk0cDNJbUxxQXJH?=
 =?utf-8?B?SkM4QS9aeGdQWFhqOGRSeHp3UzBkV3g5cWR2SmM2bUIvZjBsQ0N4S1JxSlZO?=
 =?utf-8?B?TFRMcnZ0ckVUTWo4WXNHblVLMXB6UVdROWdNbjlxcTRhYWE0ck9Pdkhtb0Fz?=
 =?utf-8?B?eXo2Zmo2dmQ1ci9xL3RDL2ZkbTBnTmFiWEtRMTVzYlhldllGVTYra2ZGQURE?=
 =?utf-8?B?U2tqOUNFb2NzUGx6T0NlTllnOFhnZVpXQ3JJWVdhTldGVityTkErOUI1MTRa?=
 =?utf-8?B?aUhmaDQrSllKK3JDUVY1aWR3ZFNXeVVQNjVBaWVOSDdKdmNzUFdEdG5SVVJM?=
 =?utf-8?B?aHoyUHRhU3oxR3V1VVJiRllxT1ZRQWlxV1BNV3ZtRlFJbStMcVRRVXA0UmJQ?=
 =?utf-8?B?dTJ2OURNbkgvV3Mybzl6cFlTMlZxMG9NSFhDTXVzejdtZXNaS1k5NHoyQWdt?=
 =?utf-8?B?WE1GNDdVZlBKZmR6NTgxM1g1eEVqdFNURTUxelJtblE2RWJXSHVZSmVsUE12?=
 =?utf-8?B?Y1VHOWkrOGp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1BBVU9NWXNpUVlSWm9kQ05FL0dCQldQNmRLV1R2RXpqNllrckJ6ekpMODB0?=
 =?utf-8?B?UjRvSWZ2MTVvWlhFaXZsYkFoeGViNWtPVCs3bG9ka0RjRjlQeDlqRTl0UnNI?=
 =?utf-8?B?SWxiOVJXZVRUUTRxcGhITnV1U0VaV3dSRnNQcUtwQ25ubUV1MjJ5WW1qTnBW?=
 =?utf-8?B?OUpMNm9XVEc4R2JYM08xNExmdUsxV2xuUHNjN1ViR1gvOGJ1SlY3WUhLNWcx?=
 =?utf-8?B?Umc0R1hQMUNUeUJHOXhaK2lSSStCRTdtd0NjMHB3WkYxS2xDNGpHR2QzSDBP?=
 =?utf-8?B?bkQ4Ymh3YTJYdkFiMFF5U2Rpc285WUdEZGtzR0RPdWZ6TXhIN01GYS9wMDRJ?=
 =?utf-8?B?SWxqQ1BTVWdsTUtCZkc3Mlk3Z3VWSjY1bU83STBWWTRwd1VDK1V1bmpLQmhQ?=
 =?utf-8?B?L1o5WG1WY2YzbjNSMzJkZWR4NG0zVVFzeDUyblJldUlOb2tEN0JHTVlnbi9F?=
 =?utf-8?B?MENrV0pSdVlUMzZsOHp4V2xjSERFWXNWa3RmcTVEVDZWTFpHNmRxaGV4c2pn?=
 =?utf-8?B?RDRqTURUeWRzeStLYmFRWGhNRUpMME9hZ1FlM1c3Q3RaMjNHQkprQ0pSZENQ?=
 =?utf-8?B?SkJ2cHo2Ymx2YlpITnlFN3JrMFJWQ3JTbkc2UlN1QUx2OEptK1dqQXZaTE9O?=
 =?utf-8?B?NW1iM29jRUJDdzUrYmM0VzJDZ2Z0aHRvbmFoT0syNTJ4OEZwQm5UaG9STml2?=
 =?utf-8?B?MisxZWR1elNKVEt0SWx6eURQVjQrUXNKRjJyOUFSbG8vUWxHMFVRMUFsNDNV?=
 =?utf-8?B?U2cwWWd2OS9GTHZUN3pkSTUzQkE5d01sbGZWem11QVRxcnY5QnFKelBPMVlJ?=
 =?utf-8?B?VzBTdFU3NHBnbVVEV21tUG41ZjliUmxzRWFsNDhXR3RsZnlpSHZWVGhXQ1U1?=
 =?utf-8?B?a0pjVHlhUVEweG04bm9lUWNEMDRlZXhYRFROS1FVc0lrR0REaFAvS3NqNmta?=
 =?utf-8?B?d1dzY0Fad2JFaFRQUzNVVWlSUGxHcVlFSVh4KzlJQkFoOXdFd0xQQnNSdDN0?=
 =?utf-8?B?Y2t2YXdVTjN2NEJvYmplZStTdG5TTjBpd1JzUFB6ZW92OThKWnVHSFNMQS9L?=
 =?utf-8?B?MDdVN3ZwSTZzSWtXWlFSU2cvb2FLbUkzdmlYVTNWZ1YzdkQ0WWkzSWRkZVdB?=
 =?utf-8?B?bmg0UE4xOEtpQjhkQWJxUnF2bTEwT1dzanQyUlA3VnhIVXJveno2bHNiNWh4?=
 =?utf-8?B?ekovemRVaTlHOGwrUnk4UTJrZHprVk9sZTRVNEhVdWR5d0lHMExzcDYwN0Rz?=
 =?utf-8?B?bUxTaStrR0R2ajYwZHM0eUtjWnR6L0dKcWJpRmtFcmlmRXJEOTg4eXdndVVm?=
 =?utf-8?B?UG4wa1RNcWE3TExUQngrTTdpS3gwOXY4VXpHVXMvVGZjK2Q2R21DMitEODdj?=
 =?utf-8?B?bzVSWTBRaWVWU1BxbFMwTFMyeWJQMEVSdXVwcGF4cEdxVHozZ0xDTG9yQkhQ?=
 =?utf-8?B?dU9OQ0o0Z2cxT21WVTVWYWhOVUhEZktXTWlXV1lzMFYrM2xmR3dIdUpuTVJ0?=
 =?utf-8?B?R2RaSUFZYXZPMVVycndZNWpsa05rSmZMZXdsNkVqK1RqNE5HcVZJK2RMSnlI?=
 =?utf-8?B?d3JDdFVxY3lhSVpPVDZEMDlVVkMzckVGRXNRTFk0d3ZEQUQ1V0o5TzNySVhu?=
 =?utf-8?B?SXZpbWwwVllacGFoUHZWLy8zT2FldG1sbnVJWjNhSW1rbGh0empiSm5uL24v?=
 =?utf-8?B?T2N1TC9yZ0hocmJPamNFaHN4amlyZ0RuQ3lKajZRMlVDaFpnSFRVU0ZlNU9T?=
 =?utf-8?B?MExsTmgxaFBNVytjT0hxa1hYbzZXTHdlZDBjb3g0YWI5UllhTU43bVlzVndo?=
 =?utf-8?B?SlZFcWMzcXAreGxrYnROZmRLdmFmSXVCSlhlM1YzN0hmNkNTMW8vcDg1VE0y?=
 =?utf-8?B?a2UzMGdHWUUrdXBOelV2Q1lVd3lVdEQ1ZE1sTW4vT2V1NU5xZmlCRzQrYnM1?=
 =?utf-8?B?K2gxeXlJNFo1ejNjQVZ3TExLUlRPajVTeDdwRFNYYldYR2w3d01xYWlra2pJ?=
 =?utf-8?B?bUFFV2UrWnF4YlN2emFJaHR4blJUUVA2bTJGQUVhdHhjM2t6WmROaEpMZTVj?=
 =?utf-8?B?UGlMajhsaDZ2bEdJREdCbFc5UFNqaE1NZE9rMGM3QTZyR3ZzZE5DZ1k2TGZP?=
 =?utf-8?B?dkwyQlNJejVZbElaVVlKMHdnVkFuL05ONGE3MFdmei9DMXhIY3FHWFc5N2Zp?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d769152-238a-4880-d21d-08ddd3710469
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:07:31.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UehZHsfIlqm+QcQP2EKcHcofCo6tHcX2hJ9eSfL7TQYKmIQRfBCsN+PL89Af5hTBOvplkkwDPtZ+NDHupZEVDpqr6jJfJwy5mAazBE/C93M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6CF64E2E6
X-OriginatorOrg: intel.com

Hi Babu,

On 7/31/25 3:52 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/21/2025 6:40 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/10/25 10:16 AM, Babu Moger wrote:
>>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>>> devices into the cache.
>>>
>>> Introduce user interface to enable/disable io_alloc feature.
>>
>> I think it is worth a mention *why* a user may want to disable this feature and
>> why is not just always enabled. Here it can be highlighted that this feature
>> may take resources (CLOSID) away from general (CPU) cache allocation and since
>> this may be scarce enabling user to disable this feature supports different use cases.
>>
> 
> Sure.
> 
>>>
>>> On AMD systems, io_alloc feature is backed by SDCIAE (L3 Smart Data Cache
>>> Injection Allocation Enforcement). When enabled, SDCIAE directs all SDCI
>>> lines to be placed into the L3 cache partitions specified by the register
>>> corresponding to the highest CLOSID supported by the resource. With CDP
>>> enabled, io_alloc routes I/O traffic using the highest CLOSID assigned to
>>> the instruction cache (L3CODE).
>>
>> This is a lot of architecture specific text for a resctrl fs patch  ... I think
>> you are trying to motivate the resctrl fs implementation. Similar motivation
>> as proposed for cover letter can be used here to help explain the implementation
>> choices.
> 
> Updated the whole changelog.
> 
> fs/resctrl: Add user interface to enable/disable io_alloc feature
> 
> "io_alloc" feature in resctrl enables direct insertion of data from I/O
> devices into the cache.
> 
> Introduce user interface to enable/disable io_alloc feature.

The solution should be at end of changelog after description of problem it
solves.

> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
> exclusively for I/O allocation traffic and is no longer available for
> general CPU cache allocation. This feature is disabled by default. Users

Changelog should always be in imperative tone and problem and solution should
be in separate paragraphs (above paragraph mixes problem and solution).  

For example, "Disable "io_alloc" feature by default to ensure all resources are
available for general CPU cache allocation. ..." Although I do not think this is
accurate since this patch does not do this?

> are encouraged to enable it only when running workloads that can benefit
> from this functionality.
> 
> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
> "io_alloc is supported by maximum supported CLOSID" part of the initial
> resctrl fs support for io_alloc. Take care not to expose this use of
> CLOSID for io_alloc to user space so that this is not required from other
> architectures that may support io_alloc differently in the future.
> 

The changelog requirements I refer to are documented in "Changelog" section
of Documentation/process/maintainer-tip.rst. I feel like this should be
familiar to you by now.

Reinette


