Return-Path: <linux-kernel+bounces-872928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F360BC12A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64F2F351DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE381AF0B6;
	Tue, 28 Oct 2025 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M98ER+K0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E572DF68
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617596; cv=fail; b=sd2eW+1LyOenJ1GpPU18KBtLJqERCTqn5PZW8faMQj6ffvWeWwTakjEnDS/i74z8HkXBwSzNsWgRzvoYllnAMv6/3yU0E1fB2m6t3otmqHU7l9gpe2orVWfGyb/XJHpV/6z/hV/rX0WB2cB/OqW+VeO6HbwCtf2PCjwWKdZGhKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617596; c=relaxed/simple;
	bh=JKNjCb79lfJNVDntATdPkPwaaUB540OqWK+aQmmcDqA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=lmRneZw+Ge4YAtczvgurFj02vVyIg08alCrntaCj2usyzZdHMmIIEplf6KoPtXL8zfDVD1LgF4PqlIa1iye5kY4FQC4M0b9YNVUpeFKvAfAlAcWo1I0rJjm4rxXifAPvfJyM+lvszCP7eXe/udto3uYWA9uH6EkwsE5IaltbN28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M98ER+K0; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761617596; x=1793153596;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=JKNjCb79lfJNVDntATdPkPwaaUB540OqWK+aQmmcDqA=;
  b=M98ER+K0/3mIPCT4FNCtoLr0RYUuRZTt6j+5oeLJXJNKBo7WI5lQG9hA
   GzGpKo08hmx0fXHLkvKnhD1JNUyFcoTH1FyzD01K1syBmZcyxtK9uGz9f
   Lr+SGarRNh4RvxD2teiwA1xITk3yYYDwnsoy26lNl/dDC/FPNmLbEooSK
   u1ji+JFw5Y3ta22Q/3wMJNDXkbPZ0RMCSvNBxqks1D7ADFeypJy4aUPvC
   GYXIO5/zAZw0vbWKbEAe80aLZ+d7auf2SWu1O2lmt/lY+0IezYZqU6lt4
   RjcrKXY1kBkMbRxkB6vHj9PMVVzJIjBFd01usYkt91inhPS2U3jwGIip2
   w==;
X-CSE-ConnectionGUID: uTpPUPAYRzOeKjLymRP7KA==
X-CSE-MsgGUID: eiWAnBaERpS1lEctBoikBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81131638"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="81131638"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:13:07 -0700
X-CSE-ConnectionGUID: K6UzzbsHRTm35x5iw5ywWQ==
X-CSE-MsgGUID: Cii+TnlaTkqTY/tq19kwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184841662"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 19:13:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:13:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 19:13:06 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 19:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKTbc8sOqeKBn4Ps8VCyicH4xWAvB9o46WRfAYGC485hfTAoU4Fm4il2lKJ5jHtHqU4uVhbxd1iUoXgKFBZDnqP2OhuyaQVnnqeGuZG+tNk7+TZmSnnf6zPx18SmAHW8skSd+li2wQa+hhm+S6iQLJgDpu//UgZ3CCFMOiOAkZjlbMT8OuPqvUHKMQ0Z6ADgiM3w07QkFfs583ME2i3yprIcE9Y0sUxzL7e14+EqxQQPLU8ZsfVDdzeIt3Wg6qiecF6GJE1Q07yHu+dQkZU8eixkRzQJNy6iE/FMXuN5VVHPF/NPfNw2/XK83HOKzHVHvKK3cE/GqLnNeJodtLO6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKNjCb79lfJNVDntATdPkPwaaUB540OqWK+aQmmcDqA=;
 b=ysTd5AMofT2xsuETsLL5TOZO+9L2VidEAomLSTcsPt1JjTbaWv7RbkUOh4W27+d29IaZpUZHy6NaWdI1phUC4vEGK2e3mGeYNZ0JuQ2txoRnnosWQcT18VG9QoH+fGqoiuXAkPtBW1LS9kmr1dVqdKGer/uZYG2z3pmVLKVUWjE2MRkMCVX5WE4wr7Jzh7Qfb2K+11taORaVvHYxILpEPCCveUQCoRUul5BiG03qQXbkA6J7NmrCzxgnBi8ltOl+J3gQXkuW5v2corC5MunVSbQIgVIbUd/yeHZ52Gq8E/Sqyahtb3qTpT36dr6wPtu3MWaL7hPPz+6pu/9gJhz0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 02:13:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:13:02 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 27 Oct 2025 19:13:00 -0700
To: Vishal Annapurve <vannapurve@google.com>, <dan.j.williams@intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, Chao Gao <chao.gao@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
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
Message-ID: <690026ac52509_10e2100cd@dwillia2-mobl4.notmuch>
In-Reply-To: <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
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
 <68fbebc54e776_10e9100fd@dwillia2-mobl4.notmuch>
 <10786082-94e0-454e-a581-7778b3a22e26@intel.com>
 <CAGtprH8AbW4P2t-wHVcTdfLwf3SJK5mxP1CbsMHTgMYEpLiWjQ@mail.gmail.com>
 <68fc2af6305be_10e210029@dwillia2-mobl4.notmuch>
 <CAGtprH8-UGFkh4NmuY1ETPYmg7Uk+bm24Er2PPxf8tUOSR_byQ@mail.gmail.com>
 <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
 <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
 <68ffbfb53f8b5_10e210078@dwillia2-mobl4.notmuch>
 <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::37) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f3b5be-2f6a-46d4-abec-08de15c785d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjdtcVpuWnFRckpZWHZ6QU5LTVRhcU9NWHllOWVtSWkyS0ZGQ3krYmdVL2Z1?=
 =?utf-8?B?OWZWRXFkcytsbG5RS0hkR1AzVFY4VTBFV1pCbFRpd3VvMnZ1SmpGNjVxcitn?=
 =?utf-8?B?WExSemFCVnExbjJuRmlTUDYxSWtlOGdmVWQ3ZFJjZENIM3VoQ0g2ejBtY1Bm?=
 =?utf-8?B?UzFxL0UrbW1aWUsxNzlGNVQybUxaUWRVUzQ2TnRXV2pJNXhUaTdSa2lncyta?=
 =?utf-8?B?cUVzWVpkR003Q3YrbWxncVp1bzZ3QWJpUndoYnRQRDF0dVR6R1dxcnplWHZK?=
 =?utf-8?B?V1BjUkZTN2NZNjdMT0p5VTlBSXJwbWpnOFJqc3ZYNkkzZkJjbi8wdGRPRG1P?=
 =?utf-8?B?bTdVc0JlYlVEbWJrcktpc0ZYYzJDR0lHWEdPc1ZIQmtsV1ZFN1BwbmRQd011?=
 =?utf-8?B?KzJGS1JCOHQyUWpZN2tYV3I1YStnUVhMdmxaM01jU0tSMUREelMvNTdlQjZs?=
 =?utf-8?B?dmZ4ckZackFaMkozY3VzMjV4TDRGR3JjMm92bFMzL0NiUW84R1NHSXBJbmky?=
 =?utf-8?B?N0dqREJ5YnlGM2NRWjdKS1FUTTJRWXhlbTV4elNQQWxmbnlRclRtY1o5blJ1?=
 =?utf-8?B?RldWajBFSUViU0JKaUt1aHRuSnYzN0xvVUt1VXB3d3ovMytlb0VEWlZZTjAz?=
 =?utf-8?B?WDZVdWJ4Vmw3TjRkVUZkM1RJMVZOREl2YVVaRGJIQXE5U2U2U2NGb2JSZGwv?=
 =?utf-8?B?d2QrYjdOdHl6NWFlbnJKVmxRc0htWll3Z1RvVlhPVDQ0Q0lWcVY4T1BoY3RT?=
 =?utf-8?B?eWlpVG9vWHIyR0t6NjVZYVg0anlncmhXeGZwa3RnNmZNa3Jub0YyQlZ3dVpS?=
 =?utf-8?B?U1g3WEp1ZGxIanJiWHBOQ1NWVnpHR1NXTGFUODBTKzdvVXplTm54ZTRkUEJ3?=
 =?utf-8?B?Y3QrditiSzJOdTg0T1JIdTF1bEs0MmR5Mjk0WHY0bmRiY2VjVEkvNVFGcVl5?=
 =?utf-8?B?MGloVHlYeXBlMDEzMlRPTjZVYzA4Mk4veWN2TmovUDNueTJoSXdBNmdnNXFw?=
 =?utf-8?B?ZEM0NFFwSHB5Q0dRQ0gyb1p2K3dCMUtReVplaGJuL0N0VHJWcDlaUVNicUd3?=
 =?utf-8?B?TEFhL0NGUzFtc3Rnb2JFVEwrYlI5aXJRNnJOMkFpYVBFcFFZSDJUYjBwVDVa?=
 =?utf-8?B?K2R3c0dBTFpkVEQ2RUtqS2syaVloSnBPSS8wMUNVVjVZc2ptelR0Z1FrUVdV?=
 =?utf-8?B?dmFtRzBoeko5N0h6VjlheWQ4L1lvT0d3Yzlqb1RCcjE1VDBRTGJaYkI2dm1M?=
 =?utf-8?B?M2dPbkhuZUJRaXhpVUpCOEw2Njlod2pEcmR3SHRYMU1PV2lhZlEvTGlMb0Yr?=
 =?utf-8?B?ZGZ3K3RJWXVOZjRDeWg3a3RRSm1RU3QxRXhSQllnTXJJMStoNDU0ZkFtZzJ2?=
 =?utf-8?B?aXc1b2J1T3p2aFFRdUh6ejN6QzMwTUEvM04vOCthYVBZSGxZR1JBQkUrVnVs?=
 =?utf-8?B?VDh0eVZkNXlGOVB0Y2hlQzRFSDBFZlczc1hBbS9hTzluNW5kMXVWL0NJQ2FB?=
 =?utf-8?B?RGxEVjEzZEJHYVIybFF2ZzVBRjdTdDFPcWJHWGVyMHJEc0VidThOakpROXdN?=
 =?utf-8?B?RnVpTFBIMzRZakV0MnVjSjhWWk5aVlZOWUhFL2M0NWFsVzhCMXRqeU9WK09r?=
 =?utf-8?B?Y3h0Z1NFZDVjMDBkL09HUE1mUzFOWWc4L29wVkNJZnc1TUw3YmdaL1ZVV1FJ?=
 =?utf-8?B?ZVBTVzNFVlBMaXI4RzhzWjFQZUUrdGwyOFZWd2FacFBFc283M09mNXgxNW9J?=
 =?utf-8?B?VDNGSzJ2d2F0RVdpZ0I3b3ExZ090REZFVGxXakVwaEFZcnZteGpYVWVvbXl6?=
 =?utf-8?B?Ri9sM2RsbUhwZlR6M2NLeCt0RTRxSEJnRS91Qmx6NGdIbEwwa0w3eWVIcVc2?=
 =?utf-8?B?QkkxdkJKdktVZHpWd0gzS2lPcWU5dEtkQ29HU2JIamVHMEJyNk90VjVZTXA3?=
 =?utf-8?Q?d8BLNIigdpbWflJj6wqElklppy/bjEWH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUUyT1ZhU2F3YzI3OS9MdnRxVDhKWEUrdjR0aUVNTlZ4Z09lM25qNVRSRVJD?=
 =?utf-8?B?WjhlMjc3ZFVLekRZMEVTL1RwQmMyMzZIdjRPRjRhOFB6SUlJU1BQZUtIY3R4?=
 =?utf-8?B?R1ZyRjU2aENaUkVZVmtNNHJlSnNwOVJnNXNJL3UyZWU0RVRoNEhsVVVid0o5?=
 =?utf-8?B?Ui9sSU1wQXV5QjBPdmV1dkszLzN0Ry93RGtFN1BpQWEzbFRsZWc2QXNad1Zr?=
 =?utf-8?B?bDEwY3QvMm9kTlhoV2o0Q0xyaGxzV1JVeGtDZ3o5Tk14eStVWW9jL2VWbWl5?=
 =?utf-8?B?aUFpR2hOZEtLWFdPSnl3SEdzRmlaZkt0NjVPK25CR2tlTGlVT3BZYnVBUFlw?=
 =?utf-8?B?UVZXYUNpNm9RRlRhYjJpQkRsNkhCdHZZUVprM2tqUkZJTDRmaWszRzRYV2Zs?=
 =?utf-8?B?ZmNLVDdiU0lDRUxOM3NoWnF0ZzJMVm1UV3dvd0FWNzlpOXk4c0ZNK0pkZ1hs?=
 =?utf-8?B?QlFRQWsrZXo2dXc0MGVkOGZrYzl3SnBRUWJnTFkrQU9sNjdxOGVxeTk3TDBw?=
 =?utf-8?B?cEdLMWU2UmdpUXE4VGZmVStPclRWNGxvMG9SWjh6Mys3L056U053aWRqTFlZ?=
 =?utf-8?B?VTE0d0NTNTlTZmFNcXQ3MFk2ZlVtWU9qZjVuMDZueUxrMDZyaFpwd21DSmpl?=
 =?utf-8?B?TmZrR1FnNWdlWDhUQXZDMEVhbmFpYnJTYlg0bXlreFM4emdhUFNHTjljVFJP?=
 =?utf-8?B?Ylc5R0pFY1BlbGtZcHBXaTFCdWRlc0F5TEVybEZVYWJTZWxqQWdhUmVuVlBv?=
 =?utf-8?B?UFROOGxqNFVQUnpRcnZ6MTgzdDEwQkFsemVqYS9LdDZybFNqL1RlRTJjUWxt?=
 =?utf-8?B?a2RzNVpLY3BUTzJQMWY2bFREc1VrejFHckhUUXVUZC9Dc21qVEhBRnVUUXF4?=
 =?utf-8?B?RUc2K04xM1VHOEl4aHM3Q2tUN1RnUUhqS3oyZHNlckJDSDgycTRlcFVUWkRx?=
 =?utf-8?B?V1I0eUI0L21FWDFwVXFuZEJrSjZpMWlZVU80OXNiYldhUDlzbmlBa2FXYzBJ?=
 =?utf-8?B?SDdnd0NMWmRyUm9ISnhKQ3lVVU90a3dKbWFObW9qdGFoczQ5R0xDM24ycTJ1?=
 =?utf-8?B?WVRiL3FyZ0RHTmJRMkx4dE1BOWlVLzFiZ1dQZU1ZVVlMcW8xR2k5UC9XY3ZB?=
 =?utf-8?B?d1hrT2hNb3pCTFBjS1RxSmRIYkM2OHk4akdrQWdZWkhTSkswN1JBVDFaTzJy?=
 =?utf-8?B?dHc1Q1p0ZEdLS2Z2SW1NTklTQkVDdHZIdDRSaVlpTzFycFVQRzJiZ09uYUF1?=
 =?utf-8?B?bkwwTEF4THpnZU14YUE0akdocnA1bUhmZ3hIMzNLRUs4VXVnSmFjdC9STjRa?=
 =?utf-8?B?MGV4OW1WempwcC9adUNPVk5yQ0tHRjlKemM0dXJQRHllNzVrU0RVSXNZc0po?=
 =?utf-8?B?dlZaWG43VWc4eC85UUUzZ2V2VlV4b0RVaG4zV0NYWnliWWdMN1pDREtEZWMr?=
 =?utf-8?B?b0g3dnc3OTJGTEd5bWNlQmtnVUdXcWtRSVV0WDRxWkNxUFl5eWthalhGUEg4?=
 =?utf-8?B?VURPOG9yVmpvWE05T1hnL2pmTmZiMjd3aVQ1ai9RYXNsQU4yd2J4Nm00N0JX?=
 =?utf-8?B?dEV2a0xjRE1KL1RWT1k0KzluNG02SmVuMzIxaWFnODV0TnplRUFKdlhaYzYw?=
 =?utf-8?B?YjROcW1NVEpxQ05iNlBGdURqaU8vdTN0UGtuYW9PQU9tcjlzdC9iOWgyaGpO?=
 =?utf-8?B?enB5MFRaaUhvd2xWdjdVelRmRzh2WmdRMFBNdURnUXJ3YTdjZENvSkxvQ2lm?=
 =?utf-8?B?cGxvT2xYVkNNK0VvcSt1UTdxdnFGN29BNVZQL1NVQUNDaVFjdldCa3VDMDV5?=
 =?utf-8?B?RWN5aDE0bjJPUUpta3F5SmFOTXVldlRpT1Q5ZHJZZHFscXJ1akNFOUZZVjRF?=
 =?utf-8?B?MTlpTk43MVR6U0dsUmZFb1VsN1YyRTNBZGtqNDFJbHhJaitRMGRhbTV4OXhH?=
 =?utf-8?B?UEVwaFpMakRtV2hxOGlkSnVtRUR2OUdyZGlpM0xYZHVzbS9zWldPN3Bwem1p?=
 =?utf-8?B?RVljL2NNeXp0a2JsRWY4Y2x2ZitmRElIZCtJQVBmNWFSMlI2TzhsTnRXQkVq?=
 =?utf-8?B?bEd3U2FNY09DQml4QjNtWWFGZStpVjRUWHlJK0ZlSlZaYm1GREtFZVZRMm5x?=
 =?utf-8?B?bXhUNzMrVlR6anFPUFFYU0RCY3pKVFFsRXJJNEIySE1BT2hwVkhVWXBTRUsx?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f3b5be-2f6a-46d4-abec-08de15c785d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:13:02.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/ubyuovNV+JNCMWDM1iEN97HrkVz2ViWqHI0S6pRkXuQSAU1yiFP64rvdytsNGDTXnNxU527yaGx1ptfuVpKsncLnCXqf0k2d2r3IW4mck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com

Vishal Annapurve wrote:
[..]
> Problem 2 should be solved in the TDX module as it is the state owner
> and should be given a chance to ensure that nothing else can affect
> it's state. Kernel is just opting-in to toggle the already provided
> TDX module ABI. I don't think this is adding complexity to the kernel.

It makes the interface hard to reason about, that is complexity.

Consider an urgent case where update is more important than the
consistency of ongoing builds. The kernel's job is its own self
consistency and security model, when that remains in tact root is
allowed to make informed decisions.

You might say, well add a --force option for that, and that is also
userspace prerogative to perform otherwise destructive operations with
the degrees of freedom the kernel allows.

I think we have reached the useful end of this thread. I support moving
ahead with the dead simple, "this may clobber your builds", for now. We
can always circle back to add more complexity later if that proves "too
simple" in practice.

