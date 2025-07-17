Return-Path: <linux-kernel+bounces-735774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B676B093B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09073B1CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A12FA64E;
	Thu, 17 Jul 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RP4e8c0X"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158D191F6A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775516; cv=fail; b=W1UFG1gbcG4QlZbgYlvnUGQuslH9wbm6cpMZMIMsX6oGtu2hY7lDY2TR8rE7Tn7LZmXGw7wPCaGeTMbnZLFQT8fZWEKUARwA6zXi+18TP4c5ZPH6D+DhVAACpFq8B7OCTuepPClj261pQAc6QWI6wGEKTeBiY+kypMEAImf8eX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775516; c=relaxed/simple;
	bh=TMYND2t3AKv/pOCsNtj6qwgtX0UWrKHoi4Awgl/shQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k526v3KHOETfTB9CahP/WWidO7eEvSL8kPgEpNHZVdx1U8ALqrHDgx3Tq4/aKpG7ked/oYxDW5YdeDe/y0YfqLRiqQzBEbbyOCMeSjDH1F9GqeOqZZjonPP7VU1GCPqK3AMeHUSJUp85SR+upLZBG3fQgMqMCBtgQ98OI+w9SG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RP4e8c0X; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFNwHzh19ZWwZztFmvYMdLEhwwpCxKodPi+5oZoYP81Qr7qOOH/eHsoCRtxphKBzQ8boM/cOpi4W3Ha1x0ZyQmLspmO+I/2ISLK9K4vbt2CvOSo/6DEa1pQio39Z6TLaTsEkIqFt50jB7mz9ukMw5ydRfMtW+SB54nab1wddHEwu2cQzzbMZz5hPq15N2XocgnIONZEJ0B1BPL7m23a0HCz1ODg/yxmfycRV5lKTKRI6JU0HrPxtcComAcic+9DJXF2X/9hy5opAzfg6t8Me2WF2D16l1YSLUzSx8Z+KrykOloSF7hpb01XTmPto3FYYz+1JsrvzuHIYI8NauoGMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMYND2t3AKv/pOCsNtj6qwgtX0UWrKHoi4Awgl/shQc=;
 b=DSb/AlPw7BfFLT6Komyh5dLiVysO5ymTAtPzLOx/3oZqusYMEQDfQUwB/TUts3YBxXhKANeaU1dEaapv9Qeu2rmZ5JuywaJjw+9l1hi/x8jYoj2RXqQL3qqPHEOq5jilxi8NY2TAe22eP7ZLd+jI1PGkVARxkmvZV1mXoCzAcDy3ePWjyRghQcWnIrDNAwDJoeufLb3E1rZCrI0hhra/10WpwMb/xWh45qSjmPiwhxF5hcrSMwVHfJ0gcpIDOI5DWztmMWFO4SPEr2s7lEJrwcKFA3godKpq4V+6qqDLllL604qBHhTak6GOSRsv9CbUVrIKkthMktBeXSRXfz+0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMYND2t3AKv/pOCsNtj6qwgtX0UWrKHoi4Awgl/shQc=;
 b=RP4e8c0XDHXgymuQu5l8fs5dEd9QXtlDUT0Mn0q6ohHO7ADljtuXsf9x5ELXtaxwiZBpOe9zPlbpBXsqNNTPuc+wkIy3AAd5gYnKaUeI/5yN4cjghks+gHGuW5fmtveTJ7BwiOgAltzAZWoMVnBfztHxczPgwOcmVOUcoVQT1yPNctJBYsfxpH9jKGLRXBP3hYh/6HoRkFalqv9JjKnZP13RG1gJDe/F2ijbbczgedk5hV4tVKxUkbCGyrUzzLl/W9wHccnSPdJTq/nALo/wT0voDK3cVPCCoS74l4BuZa16b/MM1EZ7EWbkUh42pUA5OG+eTFKj/mnP2oLWJ+Mk2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 17 Jul
 2025 18:05:10 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:05:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Date: Thu, 17 Jul 2025 14:05:06 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <63986D44-0A44-4231-B6A0-E118BF5DEB42@nvidia.com>
In-Reply-To: <fbe387c9-4205-41df-84b4-ace69f7cbedb@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-2-ziy@nvidia.com>
 <5c97b1a8-b877-438b-91a9-1d1da19964a3@lucifer.local>
 <214884E5-15A2-48F6-A495-6133CE07E1C6@nvidia.com>
 <fbe387c9-4205-41df-84b4-ace69f7cbedb@lucifer.local>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: a13d2f78-3e73-4f0c-ac1a-08ddc55c7819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eDAr/dA8r6+9IU97fwfcV1E8iUivZFEcDMhAF8Ge1fYOIJ8lPBMYINepYYdq?=
 =?us-ascii?Q?/XfJo3DPIJ/1hJobdsWsHnJ76D8IwBHsdi5At0v/Ge5p00hAwziFPZp/7zzA?=
 =?us-ascii?Q?yUYMFJUFJTll6KMbFUad+kAVJAloD6+izujD3yLmzjpeHCI1sJlH8guPdQNk?=
 =?us-ascii?Q?jA1mTltNazschh9VMWNiMSzH5VkdS/v0haINPIE0lo6IGudbOic9s2UjWzad?=
 =?us-ascii?Q?87Min2lGW2CBKJ2Kt1DONuGoDrhD7EYMYR/cLo4cAJjzcKIM7a5Net+A3efE?=
 =?us-ascii?Q?J8nHLC36vXaGuFLzmJFwMILIGu6V01NXWFe9SZgmj3cXBYpilhq7RpaYs40/?=
 =?us-ascii?Q?YxS067+w2/ZR3EK1Cf4Ox9s5yQ/CQ5pjblgOJ+hxBOVRY+84pVWCSshJ/ACg?=
 =?us-ascii?Q?R5breuxM8h/KGpLzNkzcEVJ9DtV180UpMSafYORZoB1lI7Q/XpQro9DJQTBw?=
 =?us-ascii?Q?L2l6NsI1W23yuauArGxpo5eVp/pX1x0ZwC3u2+FyEs+j7cj8t9XFVyz483Cd?=
 =?us-ascii?Q?P/SoZYYFmPM0V29kNB4UWXBjQ0Qb8265tDyDBueE4HHBFog15pphiVqIyUy0?=
 =?us-ascii?Q?Hd2k6i5+JH2esT+q+IIdBGaNDlUz07vPrzeD5OLMqFPtjuFzJWE/gzxJgsRW?=
 =?us-ascii?Q?ZcIbvaq7M8oeeszne0LxVWwxRjaPP3V2KdtJj0rQWsn9Cj9sij+T5WNfuzwR?=
 =?us-ascii?Q?p+GrKLf1T2Uh/uU6LQEADpytJ1ZifVsL7OMulaIMzdRkJzCTWpVauR79i1cl?=
 =?us-ascii?Q?7UBOaTQJNNVGeW7iVlm/IrmPvDdSiQRxVKu6Ye6sinASbZwyfAsF1qL2xMHn?=
 =?us-ascii?Q?qA0KZkew+HpFB3Nfj/lrAUZ6TgoDAJq4NgpIl+UTrmlduaKtE8RvBdm92ykd?=
 =?us-ascii?Q?E4YbIBBreirly0UTMcSlTzWv34PYIrGzJM8TuwuNSkljoVwO37NLjUon3Ke8?=
 =?us-ascii?Q?d7nfLO4/jeq2r7cqoo9gsHq5auvPOnLcv4as+Vg1N7nvKG7QMnrimUEmq5uj?=
 =?us-ascii?Q?rA+bU5YaANGjdkhH0QJvnszRuu7nE4WttNxy4AfPzXovIIPT2xf0HjXD5jNg?=
 =?us-ascii?Q?dVvMRoyYV6YdSKe36HCRRM1XO5HhQkml67kOy/W+3adIit6Aey3hoG8XJEjp?=
 =?us-ascii?Q?K4jXXNABiufGxraexNcE7HZYo6hAJDLZ3IsTWZUCkRdwyAMH5TFhchbI/RA4?=
 =?us-ascii?Q?fAMdadw+ocjM1TnASRn1ST5A+3DZWx0FajAFEAp8JTheqUE8ZcpfuorKDPt2?=
 =?us-ascii?Q?NJrD/oLfaHm/29r70vSl5uhq08gjbVNR7IRjLo26GOaaMn6ERx7HgMaFejLM?=
 =?us-ascii?Q?W8C2sturTSNUZdqaTPnFg3P+hNrqeW2/ghVTDf0ydxi/cjWb9G2MHdNnA1SD?=
 =?us-ascii?Q?iew7r/1bOpdrWmf8P4zPYv/qadqXVHVwlrsCev45ZvQvr9rMuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqcnGUC8zNWUG0ZLLqFXNlvWzPHd9PawT4LpmWyXkDmeDD85kTyYAJ1N4H9L?=
 =?us-ascii?Q?C5RsoG0SSTKFJp3u+kD9u7Tpd4VxV0d+NDg9JufWpHpgfcQxfGzGEnjdWBmj?=
 =?us-ascii?Q?rsbbqhzcPa++k6JKkfRvTAhOefRHJYWQ4o+r4KUacutWCP4jtAGgnf9+OZZ/?=
 =?us-ascii?Q?qNlr4lWxH0Y+RKvKsehcVRzvzi6KyA/V2VK46hf/tMQWmqf9M2xkKTjRje61?=
 =?us-ascii?Q?Rwg3wakL0IhcAAlnTkfMOCG/JcNkH9JG6VPg21VP1kbFRy/5XmWNyeECCTyJ?=
 =?us-ascii?Q?wZNyY0WVQhk77o0ji5oYlH6M34/3P+7ooXd9OSlMVx6IRp4xxDzwAWlijqs6?=
 =?us-ascii?Q?fa7wUfeUVQIAx7Y+XVJMF/iFzGh5EWShidDfzyM0gdf2mRMStjKEMw5kcrE3?=
 =?us-ascii?Q?ZB7Nt0mDiJ2VQgZV+p2Yao/kq72jyAlLrbX9am7SJYTPrsDpJJJAuxkArXvZ?=
 =?us-ascii?Q?KdqAPSHBqKATfnVsm/J8qN2mAvADyFGTWfl4H2Os9SOxY925cz8jJu/wl0uT?=
 =?us-ascii?Q?ePIYC/vMY86FTEuFRf7wlntwqrVcKzdjmgnUuDWz0ypbkXEaZEcEw1UsteS0?=
 =?us-ascii?Q?H0710uFVl5jo2Teg87tcztCh0OcE9x87JRk5RiRPCZpApxecS5y571HoSG7U?=
 =?us-ascii?Q?XctcmZPUiPQFwIOB79Bz5b58889SIXIeYrndDqFgDYbd9mjkZmNAdSNx8cMz?=
 =?us-ascii?Q?s/EcPLTDD/m7bW0aK0KZBaZQyLQD5IcM0hOnmFiSaoHrcklouKKrinvhxKNo?=
 =?us-ascii?Q?rb93tBiE6TxwX/ZhecWmZetoiimYv6ZWuoPzydKJUQVp5Ai67QYZ6gcmYJg4?=
 =?us-ascii?Q?OH04rib2dHVwbM/F7mn9QEJROXVT7C6MbvGp+ha1GOCnZM/6jp5R5T0FN9OP?=
 =?us-ascii?Q?FedHVEosD7+aXMBQp7utx6+wdFFrbUfqZwwx11AtgkdlriCW3zgefGQq1/ko?=
 =?us-ascii?Q?G9C0ejNV7tR7xMu5bJhcEbMa4thgdRof8TyyGI2dQsBSCJEHcpGUwLhR7PTJ?=
 =?us-ascii?Q?r8T8YyWsREJEZKtTHUdQd1RhAu5m+993pxgtwT+gB1wjo7OW9/3AIulXOxYj?=
 =?us-ascii?Q?jD9VgzlNoMS/YUsCxuy+7/+lrp4QpoCwzBhOzNfHrxW3vHbp3T0zJBzTxrgn?=
 =?us-ascii?Q?jmp2Aoge4TIVBb8VC/bseulxkyXaRamUCEi7bcCFUGgEhx+wenPmxI6o6N/i?=
 =?us-ascii?Q?4S9pSHDg3+LluH2u0A2dLCvO0la88GfE/VEf0Ke/kuURK3BBXZFjMxiIFt4u?=
 =?us-ascii?Q?4LUPe6Tmm6GO/997q17mSzes2y7ewGPIeXE+UrgFB80ZqzwrzjhQso7emvUc?=
 =?us-ascii?Q?NFoYczgU+gnYFCeZc6bBhp5TCfS8bNiED6tupqdFCZhCwOEW+TsdZyKQoy2R?=
 =?us-ascii?Q?Bt39b0c4nW4umP4/zxwvNT/2m7kp/SfCeq4EztgT91Qk7BsZQ1/xKS61xwDE?=
 =?us-ascii?Q?YXwp9z0RNE8x1xBl7SkJPIzR8MoQn8e8C37LoSCgPP8JCUvjItHMkD8UzhOH?=
 =?us-ascii?Q?4PxINNmb38rq9A1e2qA4gRrWAyzft3+YNq6NUj7Q/VY0UUwMlfy0hRwPbC77?=
 =?us-ascii?Q?FoUZ2HnLB0xOlfvbKITsDsEq1qmQUK8mxemZygVt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13d2f78-3e73-4f0c-ac1a-08ddc55c7819
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:05:10.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjFwQar6D6x8tf2+e0q7Ue2EOhD4b1LbUidcxqj61JXIdikqMb5+W33u2lv3OSGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343

On 17 Jul 2025, at 13:44, Lorenzo Stoakes wrote:

> On Thu, Jul 17, 2025 at 11:41:01AM -0400, Zi Yan wrote:
>> On 17 Jul 2025, at 10:07, Lorenzo Stoakes wrote:
>>
>>> On Mon, Jul 14, 2025 at 01:18:22PM -0400, Zi Yan wrote:
>>>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
>>>> splitting unmapped folio operations. Move them out to the caller so that
>>>> __split_unmapped_folio() only handles unmapped folio splits. This makes
>>>> __split_unmapped_folio() reusable.
>>>
>>> Nit but maybe worth mentioning the various renames etc.
>>
>> You mean release -> new_folio, origin_folio is replaced by folio?
>> Sure, I can do that.
>
> Yeah that kind of thing, just basically briefly mention the other stuff you
> did.
>
> Thanks!
>
>>
>>>
>>>>
>>>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Acked-by: Balbir Singh <balbirs@nvidia.com>
>>>
>>> After a lot of staring, 2 difftastic's at once and exactly 0 coverity
>>> instances, I've convinced myself this looks right.
>>>
>>> I think you really should have split this up into smaller patches, as this
>>> is moving stuff around and changing stuff all at once with a lot of
>>> complexity and moving parts.
>>>
>>> However not going to make you do that, since you got acks and I don't want
>>> to hold this up.
>>>
>>> I have a few nits + queries below that need addressing however, see below.
>>
>> Since I need to address these nits, I might just split this up.
>> How about:
>>
>> 1.
>
> Missing some text? :P

Yeah, I meant to fill this up after going through your comments below.
The plan is:

1. Just move code from __split_unmapped_folio() to __folio_split().
2. one patch to remove after_split label
3. one patch to move fail label and related code
4. one patch to refactor remap_page() flag
5. one patch to convert VM_BUG* to VM_WARM*, three instances.
6. use folio_expected_ref_count() patch
7. mm/huge_memory: refactor after-split (page) cache code.

Maybe 2, 3, 4 can be squashed into a single refactor patch?

Best Regards,
Yan, Zi

