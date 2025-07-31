Return-Path: <linux-kernel+bounces-751811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED268B16DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F4856550B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9221A92F;
	Thu, 31 Jul 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UENrrWLC"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97292E406
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951275; cv=fail; b=HBBZDRDKEvqTQP9IicOUM5em1aNTtXB7WsX5+uCB960HUyQPiPhm+uDXbW5VaO6MhZbGiHUgGffXQhu7XgqjwZ6Yv/cb2rV8Y7ZTr7bEQHh+DSnLmzZRyKICR4jJTSi02BHQHNdG5P4Nq8crG+yElUZ3dZvE1heKsFrPE4+NVac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951275; c=relaxed/simple;
	bh=9Q2fFWcvhmVsrw4GQzBMmvEY3K4pJSrgtyAYInRtC3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPsASq0xyMqMHYF+URTuqU3Z78qhP/ZWPXksiJ6x91kxNP+WU343aK8dXqNu0ghw8beTlL+3Z9meGAFSjPsix99f9kbawzAxo8hrUMJy9bKrkclP7EE+rv4ntMoNLFOoDgwcAQZYh7SkPiBl0Gi4GuVUXnG4Ne5SxMEp2oF5UqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UENrrWLC; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POFloxeDRWjN7RGsE5lPRzQ4NA19w0F7hj/WmEH3hLNIJS+1kfYgTDFzIbodfUROZpcqXG4Fw+2oLks765LruXNmnd39oc5+EuxeeZaNihpDD21AyHKlaPLLJ1GQJpQEexH/tF3LzVOWw98HLG7YpZ5ulY5hny7GXPsHZu4EpOJ263KBgdY2cI6vS4JzDHWlS+hh/cG59IFnWUhEhQj+uMENlKQNRyjrWXMn2LCjQroQM5JSOZ0490Ejk5lVvkTVgIxzSJENLTQ+PQDbD6bl0lPO/K/vVCNnsCq16KVrr/pK5ZWiNgJFkCnON1NnvH5ZruncLBBW26K6wTLOqYhifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL7d/TFIGiAtJUUVQwLMK6k0XFGLk600bLVs+iShtuE=;
 b=ix8SEW48PAOCayGp0iGY2x5D64tN6RCZnf4fhwPg+wlItptUlQtyclJopQsU12H2IKFGygePkn+oL9VVqilO8W3dnpOhOM5kcTaVVGJktJ3hO9K8SKB+Zvnm9YvV7alYyKkbOv79502CHfkInZgJzNYFG40DF4D2lg6UI1VgDxZ3C48O0v0Pch3gqzGLX325XJIGIdQ9AUdnuoTlB3KuO6IutBJjZxwK09UaXUXmqSlomEyL6zn5phqTagsvNoJdbUKnSfAvwVzcLPhHVTOjmzqvnSVs+5x+LdgWWct+HHcvTYKrMT/58leWCH7Ozgi3vEX+85ShERmFXPhd/RHbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL7d/TFIGiAtJUUVQwLMK6k0XFGLk600bLVs+iShtuE=;
 b=UENrrWLCCC4NICqHopHApxdLSqYA1k0WApzRXJVCu5vCoQVQOA9GIYrwNiho3wR620379hufuhT/RjbbVlCV8QcuIqCtONA/YhUiomA1GmHGa3yjDWqvok3v79ewqPYJGMWJnZI9CrIzk/GsFNp4OtxwQFqHKETrGn6bNtqF+f5yVrf1bwcffV7ubAMb34dPAlOd7EjpDtiDKdXWMeosFzRttsLr4PHSvBOtQ9Tfnui8Bp03yRZNjP3rNS8YkkR+jZdWNQVxJ8soSQ318tpfAxCQJie9ge8doDCuHPhAc+0utxaI+/M6BhH0+4EeRfzowkGUC4jlUFA30Hs7ollZ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 31 Jul
 2025 08:41:11 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 08:41:11 +0000
Message-ID: <1fa09b2c-4845-445f-9343-3a169e202ac5@nvidia.com>
Date: Thu, 31 Jul 2025 18:41:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 00/11] THP support for zone device page migration
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <e0153fb2-af59-4bcf-a07c-d650fa56d55e@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <e0153fb2-af59-4bcf-a07c-d650fa56d55e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f34c96-7cb7-4a1a-011c-08ddd00e0040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2I5RzZKRnpFRFppQ0x0WlZrNnl5Y1BmN2ZRVi9IanRHNC9BN0N0aUhLVkJU?=
 =?utf-8?B?dUZMaStuUEpEVDRmMm1oTnlQNVpVZHIrWlpvcDBHaGlvd0RybWVWWG45V3cx?=
 =?utf-8?B?T3BSZno3czJkWWF4Q0V4cElxL3JJZ0g1RXhScU1VYkU1V3JyY0s0SWMwNnJw?=
 =?utf-8?B?NmQ0WHBEcCtTd1RkRS9IbCtObmFOMExQQytkVlBKcnczNUpNYnRJb29XbVRD?=
 =?utf-8?B?aDZSMjV4eTRrRUlKV3A4bWZkOGUvK1BPNFRDS2lEY282VW5NVGZ2bmlJTXh3?=
 =?utf-8?B?STlUd2wyYkswdVRSdkt6emZZenpJUWhoa2pkcnBraXB1WUV5ZjVQT1NTVGg3?=
 =?utf-8?B?eHZMYmpVMkxLVXk5ZmpiM1lTMWtpYllVbkhJWmxYNkpSK1Y3cENnSGpnVG5U?=
 =?utf-8?B?RENSV1lIcC9DeFM2KzdJa0Zpcy9qSjRpM01ndTFCMUM4WUNjMVg1L2FXYUxx?=
 =?utf-8?B?ZVM5cWJZRnNZNFBZbEJQMjdKRVZwVUFmOHhYa0lnSFdEUjF0T0RzbEh1VzMy?=
 =?utf-8?B?cjQ3T1hkdnRIUlBPdWs1dnE5OTFpeEVJODFXcjVGRGhaYWQ1M0F0M1ZYcG5W?=
 =?utf-8?B?T2pvcHFuWjdEb3FOYVhnaWNWZ3V5YTZVT3NMRVRTWWJBakZSaDhGQ2NscDBI?=
 =?utf-8?B?ekp2QzlPazhvY1Y4RUlkQkZYRFVLd2l0bHZ5Ri9KTW5qSlpIVnBDQk8wdFZl?=
 =?utf-8?B?S2EzNlhpMDFiYW83TUZ5ZWRDUXdBU25CK2s0b09lTDN0cjQvNWoxaXJuSVFP?=
 =?utf-8?B?YXRFNlZaMWx0R1lxZjVpK2h6ZE5mZHZnL3FCdFViM3pDNGVEWnp6Z0k5WlZF?=
 =?utf-8?B?WEdFem4vQm1Tem5ZeE9rUk13T1p3aU90RUpTZk9oRUlEK3Qxb2kxek40Rkxz?=
 =?utf-8?B?MFNpbTB0akRmZkgzd0ZiNUdTcTRQbWFySkxDSDdmZWllT3hGbDZnYTd6RnJO?=
 =?utf-8?B?MDRlb01BcnVQRXVhbHVKSVpLbW5aL0RPWVAxTG5sUzhDK3ZJVUZXbllWZUFo?=
 =?utf-8?B?RmltVFdMeEplUjk1S1o4YTlocSt5RTY4SnVTazh0TnVzemduM09wTUlpeENo?=
 =?utf-8?B?TWp6UXlJbXdoWUY4M25NMlJiMU9ZV0JYaXJlNitzVUFMYkZFOVVGbTZBRERI?=
 =?utf-8?B?QUZWZjdqbUxaSlFFeENYM21FeDQxeXV6Z0lZSVRadEFEc0l3Z3Y1cVJDT1pL?=
 =?utf-8?B?U2ozMUpiZU4wdGZvN3Z0SWtnK3FyeDBPdnJzYlpoMEpBZkpYWlgxTGwwb05K?=
 =?utf-8?B?N2lvMStqUWZnL0dSNHBaVkFnWjYrMTRqeGZOV08vUmIvelg0ZkFNUE5DRnJU?=
 =?utf-8?B?ZVV5VXM5OW1nUkRYSUZrUzd6V0dMQXBEZE5VaFdSblhaNGprYlFvTGpnWkRD?=
 =?utf-8?B?ZjlMbU90TWxKT0w2dHIzUmw5TE96MHNuTVJnaUw0R2VmTDR6MGFMRUdoTDU1?=
 =?utf-8?B?Y0lFbzNVYjk0RVZMSXo2bUtqOEw0MTdBT3RyUG15MjVpR1pRUmZuWC95OUNC?=
 =?utf-8?B?cmcrL1VIckdzRW5aalBLenRFelEramprOUxJdTF4NFFsbkNvaC8vNEVDRGxK?=
 =?utf-8?B?YmVkd0Z0a2pjNUVhTlo5aXBCeTh6OGVVM0RqWTZqSHhwMlQxZHozWXBiKzZm?=
 =?utf-8?B?RThvV2VCL0MxNCtITlZEZi9qTzNOeXVBMnMwQmt4UCtNWFY1cWRGUDN4RW15?=
 =?utf-8?B?bjB6ckFXWEQvRS9CZlovKzJtOEZVNm1GTXA0RklTUWFEdHNuRHczS0tQT0lO?=
 =?utf-8?B?UDc5NW92M0NWcERQOFljM2lQT1dlaFJKWVZORHpReDQxZzZST1FHMzRyWkxy?=
 =?utf-8?B?ZkNyQ0hsQUtTM05oMnU2emxPS1YveEhpRjd5U213NndVMkh2cDM5elBnUWNv?=
 =?utf-8?B?MWtwbjlHSGZTYmptNEczN2VLRDJ0aHloYnZ2TEhBODZvYThhZFdJNGZ0QldC?=
 =?utf-8?Q?vMLMkolT0mg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkdyTVFrYnhmVFZQU2tzeXBYODZrdmREMm5mcHlwSnBLeTY3MzFNeEVaZTZj?=
 =?utf-8?B?cGlhd1pjbnVzN1dJbVFSeTdLVmRVL1NTNysrNlZjVXZvTkNPS2tmdmNLeWk2?=
 =?utf-8?B?cDZrcThKL1ppNEV6QzdWU05VeWFsQkZWbHozNi9TNm93WTRwZ3VjeVV4M0w0?=
 =?utf-8?B?cndZMDBHd2Jtb1FPZFJGazlVYUJHcVdvK3BtWHRuT2J3Wllrako1NkZkbHcw?=
 =?utf-8?B?K0N0Zlk2Qks5M2owRVlLUXlTbngrK0dXeXpmYTlEZkJkcFN6eGJKNHJLTmdv?=
 =?utf-8?B?SmtJT2RHS0JZUFBBaThRMlYyb053TFFKOHJnSGNoRlE3ck9aVVBxRGlLOWhr?=
 =?utf-8?B?cDhnbUlFV1BKK1gyWVVESXNMWGQ1dG42c2Z2ZVBQdXgvSTNOME9kSkIrNnFi?=
 =?utf-8?B?WE9STlVrRVJabFlkQ08rbURhUjBaeTd0UXFFb1R2Z0JBSTJjOVp6cllHUmxW?=
 =?utf-8?B?WWdXYzJJWG44ZGYvKzVFRWwzb1dMcWpGT3Z5M3YwRDM5NzFUUnJHS1R6Rm90?=
 =?utf-8?B?ekJSUkMzN2F5TlA0MzF4WmhsSXJKa0tHakhSZEVHSll3TndnTDA4QmtTdmo2?=
 =?utf-8?B?Z3poM1pMSjlwbmg0d1pIeEF0M0lCZVc4WWpWaG1QSHNKVUQ5YW5wQU1uWkhz?=
 =?utf-8?B?dHZiM000NG14M1NmM21nMG1PS29CMnpiQUJOem5hOVUwaDhmSU4wRkR2SlYx?=
 =?utf-8?B?eCs2aU1aQjR0NmtOclgwS2dqaVJXWWUvNTZ0ZlNkZi95dWxMaUZGTnlRNUlE?=
 =?utf-8?B?a3Y4UmN4R2RJblFaVlFwakhOcWdlT3FNSndZYkxHNGE5V1JBOUJuM09jKytN?=
 =?utf-8?B?ZGNnSnR5VzdYVzJCZUllc0ZUVUI3TDNTK2JyTTR0eDhaOWV6MWJ1YUNZUU1p?=
 =?utf-8?B?RHpMUDgvUjdjODU1NTZhVkxZZGdJZnltNWtPZ0gxSllxNkR2VStnQkdibGl1?=
 =?utf-8?B?TFZMUVRnRGdRSzhvb1JGMXNlcklpN3RhZ1NBRnlNZndUMmJYbklQTzdTOG4y?=
 =?utf-8?B?b1I3bStBMWlPeFltRk5lSFpxZFFuRitBckxIZExhV3Iwbm1ZWlJ5dFpmeXZv?=
 =?utf-8?B?STBJSnFlakJNUUVGMmdDa24wS2RaVHk2K3pXclV3NmdvZWxHT2JoWlZxdkUz?=
 =?utf-8?B?WTFUT01XY2lWZGtUUFIvQjBPRjc1R0xOU1crNW8vc09XTkxXMmV5ZGtzRGNB?=
 =?utf-8?B?VDRJZGY2VDc0ZGlEd2V0Z09vTDhDMCt6V201QjZGWUFreWVqY3ZZRmFHMTdV?=
 =?utf-8?B?K0QxVHFjUVAvVGVtUllUUUJtWkRNVnI3bmRURjZpQzdJQUlra3NtQWV5U1pF?=
 =?utf-8?B?cEtJbmNpekdWelVLMk9tcVRnMDR3TmNySEVxNnUzekRhYkxXLzJQYTY4UEJK?=
 =?utf-8?B?OHdkZVl2QUJCcVNxNFlrK3JoRDduTW5XN2VGVkxZTDBKWUplWkdaRC9zN085?=
 =?utf-8?B?UzhKc3l4TFZTRDg5MTQ4TUpOM3oxQy81MHFnYWVoWTY2SnlyQ1QyNUE4eFNu?=
 =?utf-8?B?ekJpY3l3RFM1UHcrOUpMQ2EwRTVPbysycGJ4R3prUHE0MUVCVlgvR1RZL05Z?=
 =?utf-8?B?b3BzZU1rNVI1NDlYTDhaRmtoNUovT0tmVUJYNzVCc01SSVRBUWNObTVheEFZ?=
 =?utf-8?B?WjNhenUvOWxTUE10UnN6WGE3WEl1UWZJNVpPNkozUWdvWVU5WHJmaVhKWmE5?=
 =?utf-8?B?Mzl6RmRPTGZZSi9YL3NESEpRbERQNWVYemhQeGl5Rk9oNVJSeGhTVDZJYmQ1?=
 =?utf-8?B?ZHppdmJISHR3ZjhVM21abXhPSU5HUld6emVJeVdGZHgreEE2NFJ0ZmRFd1FI?=
 =?utf-8?B?a3c4Z0JSVGcwWFpTVUJMOW56aXhBOHMvUUVpdWZuVDFWVTdwdDlpa3d4czVw?=
 =?utf-8?B?MUZvb0FmcTB1QjQzSlQ1OFQwVFloRzZpUVBQMEUzblp0VHNSOXFhcUd3U1Br?=
 =?utf-8?B?dkVEb1J0SklnQUJkTDNWdUxrbzBiMFd1OWJuOU9iV0phbHIwQWpzQ0dqL3Vp?=
 =?utf-8?B?UXdLYmdtQ1JlclQzbTRUb2tpQVdINzhGSXgwOUszYUVEbWNicUxtSk1YSkFp?=
 =?utf-8?B?N3kzUjhYSVNHUzVZK005U2lPbHZHclJxeHMrK0FJKzNvOW5wRmVaSXZJN3JJ?=
 =?utf-8?Q?NBHDq0pY/tVWDGRi4wZwYZTA1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f34c96-7cb7-4a1a-011c-08ddd00e0040
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 08:41:11.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDYZ+zgQurh+YSVdaMcdU7FD47/PaVrCOAkk1reP18DztNnQfK8wn59Al/x5+HjI5OcWE/ZHXTcYTF//0eH25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29

On 7/30/25 21:30, David Hildenbrand wrote:
> On 30.07.25 11:21, Balbir Singh wrote:
> 
> BTW, I keep getting confused by the topic.
> 
> Isn't this essentially
> 
> "mm: support device-private THP"
> 
> and the support for migration is just a necessary requirement to *enable* device private?
> 

I agree, I can change the title, but the focus of the use case is to
support THP migration for improved latency and throughput. All of that
involves support of device-private THP

Balbir Singh

