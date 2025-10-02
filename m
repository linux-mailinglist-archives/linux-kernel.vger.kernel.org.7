Return-Path: <linux-kernel+bounces-839756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB73BB254A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8681519E0EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA558634F;
	Thu,  2 Oct 2025 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OCBXcwKk"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DA34BA29
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370697; cv=fail; b=W+qiN7jXo1RsTKG2erjyxjbGxCZe5gdGCz10QtrPwTs7BFi2TvwyIk7ITt4cn3HCcsleOOBjiwB0AbnYCa+7Ggzs3i5uimWPmERlgb8jhaHH39CNbxB0rkytAvm4lTS1Y80PYiBVkcnJwu564M7WOBr9gCJtNwdASGefjOBFnq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370697; c=relaxed/simple;
	bh=135xKsWt8YXLCKsLmxMKKhHO5CJIodBVgwPD1xyWPnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glmcaL2dgOBXVvma/oIHbob1a7mog45QUHGc/8JBYVQMDBC5O3/RXW2dsfDMCRouC/wRb1sMzHHT11cJZkRH7+U2ZZ70h0teI7zTupXbfQ83lRUajMNHLUICHjXAVmvKnNalySfp8zMZTBYnB2e49Qq/4kHxffYNPuqHgh7cHAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OCBXcwKk; arc=fail smtp.client-ip=52.101.53.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nck9wxJ54isN3EohNZmwH0d8x56a9+sO8Blztt52lEIyUXP3SF1VDK110CLXyLdE7BaESiB3uVR5+mVzMN0ju9xzCd7ziITSEv28b7pMk0l/7Du/U6wkEUGlTQuLqBa9O6oLYyJ/3mjTFVovHJ5kbooygIzP51db+Ij0FOOB54V0+gyGcGwB7VS3H69aZs8ayH5eiF4zjnpw96W5+FJ5WR/RtGpcE5FYrN26W5TYcdks4dAy9zcERn9S64OkOuNwG84m2NLT3iFXTsrZcQmu2dLiOPKQbCc0pYteqyo4RpL6cdUjreDym7KXOdDGrDTYIPE9nqUmqaNDwbJ9ChN1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gzQudGwWJQjzKq8B0PYFToMoIbQ9UVFq7ycTOx37o8=;
 b=N66S6tjJQrbwHMiC3ePlVrSq2jw0cpuO9YuGLaqDjpvjQMItUOdbIoI+L2umQ4kJRvTc1TAikXgjc+bzBxOad0aeWFKyB7aPEybkHfdrOivQxdD7gMr0J9gx6X6Wv/+cTvTqV8QkyiGRMAJ6yPV/8bbWpi4f5b5iMfuDz/1Quihukgt3L4vXr7sh0LGrjibNWy4IdJdqvilqz1pQJN5cB24px8Bijm/2hv3duRjFTiMg/WCAuxtZz3gSYIIWv7fNoVsqOjufVP2bcXZ0d9bRXi0oEVQ/FgfJpMhN9UFEau61bODwebbSADni48g60KzuJDMMzGj1rov/jFHFU0N9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gzQudGwWJQjzKq8B0PYFToMoIbQ9UVFq7ycTOx37o8=;
 b=OCBXcwKkYEMkb5DxHKQTHhGXyohkg90ksxj/4WxTyVS4twn0ToOnGUhvYJ82a0DJH9ek0GZ6w1i4vtgvHltZtkLB8mC5XPVIHgKsBLDeq/DV9dZ7qhsqDn2xl+gbmgeYdhcBbvkxxj7Iu0OZtR0ion38qjkcLlqmoLFFDn5QenFLHlbkysb/e1XtngRPEaiRVOTYL04NDYOb4rcm9cs4fpKVQ0s7IGZMBDp4CmsP/YTgsrOo8G75IUcuCwZmfksVFmkH9KhmnJ21D5uQK9brCHJxBKahe35O5abZqdL/NjyK9RWlWwIFK9lJSg5Vprlq+NqSQ93xPlT8bhdNHxKQ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 02:04:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 02:04:45 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
Cc: jane.chu@oracle.com, akpm@linux-foundation.org, david@redhat.com,
 kernel@pankajraghav.com, linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mcgrof@kernel.org, nao.horiguchi@gmail.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Wed, 01 Oct 2025 22:04:43 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
In-Reply-To: <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
 <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN1PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:e1::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: ead36683-ffbf-4823-5a69-08de01580ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5OFTPM2WAA7m5aU3pv7Vdeye+oj6E0PZz7ijhkVNlNDocsn7KuOMo241/hPa?=
 =?us-ascii?Q?Q81/Sqxzrx616qTqTPDCv24mjHAloIJ0D9hFfIlj7P6ZuTKPcrYQmlhMX3Ld?=
 =?us-ascii?Q?RZOtSRrjq2m1pTrLDjRq6ZpUPE4XY1L/y2jLcpJDP1nJFu5+DiIrAfZa1d01?=
 =?us-ascii?Q?suzzSQC8vtxOifxl1/Itxm6us1bKuAh6rcox7ByzrBgdQ9PNtYGor/Tc+Skj?=
 =?us-ascii?Q?KoJkJnE1kvShZPnrT3zuSuhDup71XyYYmP2aJLlTfaO+wjIv86KwiBOjgDmC?=
 =?us-ascii?Q?4KIWycY2vykJ0z/mbkebtb9ib0nGSQJkLVhvHMyAWbaLqw3a07t9LCR7sou+?=
 =?us-ascii?Q?1VczyxuxQZNqkdFovjVtXn/AIo35Q269CfrHAQ3yyyF4Id5e9Ytu3xOVonu8?=
 =?us-ascii?Q?lymj3rz+yu/aHKhfRVv76mahcXt0KoT76y4WMT090jpSd8qEyHRoQ+lymY+d?=
 =?us-ascii?Q?Xogx0ovClaazQ7UCrxfbFs01DfClIWU7Ka18JJaoAaBEOreBahIlKLaMwScd?=
 =?us-ascii?Q?LAcIe6iJJhMQNQ+4gxO4AKZ8qWNmU999FTMtXHrefh6k3AtqKJ13lc8Y4DdH?=
 =?us-ascii?Q?OoCc12DNmSopoKTM1cW154vPcrWCntoGRglVHkXz9t5gQZ3bEhXsLbTtUaMj?=
 =?us-ascii?Q?+BAKkzOD91hS9inxWzBlVlFjNxhTBGqRTuyS2PxFzXNkfvLv3erxpBCA6F5F?=
 =?us-ascii?Q?gVg3e+5z/zY2m4GweInmOKhnUBpuATES4hBLXOtNaUyVatiiQbGlt2L6Ixb7?=
 =?us-ascii?Q?/WmRtw+dOpXARWlmNmRUmqU3QiVU1Lm6ZuTkNlcWXgQxqxMCWb283KlNFvWB?=
 =?us-ascii?Q?RKprcgZMTIAgm5eQbnMZu6fHi9ilUU71MWZ+jjDJ+Xd6gucyNEhxZDqfyEi0?=
 =?us-ascii?Q?NxUqowcjf8ze3gu/8Ql4i22jgXbTiYzasAZPKZaq+14THBbo0Wwj+Ex/KEWQ?=
 =?us-ascii?Q?6ZOArMN5OJ0zYbmaaUK4I9G8W+rx0INUQ4/Oj3XkaIrODwyfrQF1ktgzGgb0?=
 =?us-ascii?Q?3SfhbVAQdniVYLDdaFG+EcnbEY0YZ65ymE1ky+eng/Bvv7cguxwmJEHFIiyc?=
 =?us-ascii?Q?7ouUNQs433OkAe3pJaiCCen5Rn+ske7XmSxF0hc0ws13aQlHgVa9/GwLsil2?=
 =?us-ascii?Q?2OzjoEVMLTJUNMWCnEvaUhiKh89mQ+9L49bCqrM39tq2R6RlgMw4x56kfU0S?=
 =?us-ascii?Q?OZGl4ZF5FVzXKuM1Ebra6j2/nz2NDaZ8+2OJ/gYxjaILEqt5rNMdGT6CmZM7?=
 =?us-ascii?Q?k/2DkHrqBeC5qxrtjOvfQbOEGss8AJmlcbsyP+jEXeH38W7g3Ha7dyvzaJiy?=
 =?us-ascii?Q?HcBD3iAeLnvuwlx70llxt04Q8vp1zbKfb99gVCXGAnw6rlbtIVQEoUYfD/I9?=
 =?us-ascii?Q?a30ZSfyrcC2vHa4u92A7UXEE4+WMuOTAusEm8yA8dkdNw6wCLgOvWgHH3uJd?=
 =?us-ascii?Q?+re3exvl5LTyTvYOVyrde1csvvGWT9EiY/amPCTSMALtTys1RVaBuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cqeFd5gWBO/wyUbqxJnRSHkWLKBkQWBgFmLEeOEbJQU1KKCF+yRJXX7e/OTI?=
 =?us-ascii?Q?dS7ngy++ljm+/SR6/TDCTnBwiPM6iCYSPJjEBP5TmH7NRArZG1yg2DZYCBkH?=
 =?us-ascii?Q?AK1NBzczX6+T7jpGFkmKP3M+v+MrMRB4wwX1fUiFAuIeMZ/PFDd51I5jJqGX?=
 =?us-ascii?Q?/5SJkNtr39EpHPKywRTGaT1w3Eu6FDHfZwlx7rQ6iTFrzznT0TutJMy/bRwK?=
 =?us-ascii?Q?98snjwGyLppfabV6zYHWgLGKPT8T9G0Y3Hac7jDu5KRWNAgrTTg11ZfUIGDP?=
 =?us-ascii?Q?sDA7hm4tfMtz5x+1t1o4Biv4QvvMgnMQ4Biqayl/o4injVO7n8d2rqPdK/A3?=
 =?us-ascii?Q?tRm6cnBsT7GEkyKKMX/MqDPqIzKNwxmNp1f7epleqdBkexd5FsNeVpuwTkKx?=
 =?us-ascii?Q?H7x48p6dzoC0v6ZywnmWXDz0RqR33WL6z0ibrWf3/1K8yDgNp6rTNAdwOeQd?=
 =?us-ascii?Q?7qxrPAeQsIpEPxgMjnutZ+0IJc4Sw7pl/LrhNpMO9QczL1yPDEPM2AXZgqLS?=
 =?us-ascii?Q?nP358BGcuUd99ldHjnM/2FV1xx/pmhus5VQ6spBDfThuqBJ+Ok7/hqKBZ6mD?=
 =?us-ascii?Q?VnV/dvBYcB41aGlXToNwOQCNkfKW+mjSUGlWW2rQSDDwFBdCwyNGw/uBFRe1?=
 =?us-ascii?Q?PgiB4fsxvuyT8z5dOGtsy1GZcGl8sxMyzjF/6bBY/mLHTUqcaGcy0DWzvsgF?=
 =?us-ascii?Q?3pLeQHyyqfjo7gKwgl46bhYNrSeRy/XzeOdKRpshxaiT1hj0AbW7tSPaSMYo?=
 =?us-ascii?Q?kfRJ1mSWX7VhQPt0zg7HvxR3Sl2ETnldTazKKW5/O6Gtf5aHiVp22urRzOPM?=
 =?us-ascii?Q?iatTAXFaX0hypGSYE9fviw/QLudbXN/R5VKpldd8vEb7ep4m8FQBQep3R+hO?=
 =?us-ascii?Q?bZV3yHhYUfmrGCddymuoK4IEMYRPqdHe+r2dcyNDjGwfGQenHwigb4xD/ezb?=
 =?us-ascii?Q?tRCoRvmGfxrQnJaFaPzFQAK4B34X6fKyU7wEyoOvYOFrLrj3DR+TdpCZse6K?=
 =?us-ascii?Q?ZKEt0dYzAT47+TycpMCU3rdLp8rUB8RV9UmQcieZRb4W9hKSXNwb8LgA3/LQ?=
 =?us-ascii?Q?gbwGSWRQxnBE57CCQfYVzT8pw6VEE42g7pLwj9iw5b8pKCfCm3LlqNIG2ODF?=
 =?us-ascii?Q?GFbPoNvP5GiDIqJLkZ/m/9Iyb6J2ya6lY/D/omBePxn+iOn8Skjy46LgJdPq?=
 =?us-ascii?Q?3SllC1mqLNmt26xl8dLEdiwoCL1gRnDmoQeUPQBpp5Q153qJibohKa+xhRhs?=
 =?us-ascii?Q?ziCaj7o4il4tfO5JPBGPdteNJeMqmBqQ9XyH541iVOsx2orHK1tY/jell7WF?=
 =?us-ascii?Q?3DEWxUtFlSl6tgWkE0wM8kNeTKOHdSxCRH0CsmDsrl+SR2fd4u2I0WKPCXLL?=
 =?us-ascii?Q?MmOUODgxrov+YbtWxXclnGIbMW7SxfKIkIFaHLqAdhgmbrzGW7/WsWt8MN8J?=
 =?us-ascii?Q?/vnDsqP08APLC2puMENyXJ6Yr8Ufck/jKXWn/NXubhpTiJuomDif5HdxOsOH?=
 =?us-ascii?Q?ezxABb/7FHOQqlO+r6lMXikpNAD4Sm0X74OlBZqp4ugy12dLuWav0pT1MBBt?=
 =?us-ascii?Q?xsPdYtll2CF3rFRGYsJ90ZBeWYakv9yrtfplIVZO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead36683-ffbf-4823-5a69-08de01580ef4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 02:04:45.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izJri3NkZ4PGnZElXL4MAC0YmYl/nrZeK4wC1FXvsnTFnuIBSng27OWrO05okQ5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206

On 1 Oct 2025, at 20:38, Zi Yan wrote:

> On 1 Oct 2025, at 19:58, jane.chu@oracle.com wrote:
>
>> Hi, Zi Yan,
>>
>> On 9/30/2025 9:51 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot has tested the proposed patch but the reproducer is still trig=
gering an issue:
>>> lost connection to test machine
>>>
>>>
>>>
>>> Tested on:
>>>
>>> commit:         d8795075 mm/huge_memory: do not change split_huge_pag=
e..
>>> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page=
_min_order-for-kernelci
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17ce96e25=
80000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D714d45b61=
35c308e
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3De6367ea2fda=
b6ed46056
>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909=
b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>> userspace arch: arm64
>>>
>>> Note: no patches were applied.
>>>
>>
>
> Thank you for looking into this.
>
>> My hunch is that
>> https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-ke=
rnelci
>> alone is not enough.  Perhaps on ARM64, the page cache pages of /dev/n=
ullb0 in
> Yes, it only has the first patch, which fails a split if it cannot be
> split to the intended order (order-0 in this case).
>
>
>> the test case are probably with min_order > 0, therefore THP split fai=
ls, as the console message show:
>> [  200.378989][T18221] Memory failure: 0x124d30: recovery action for u=
nsplit thp: Failed
>>
>> With lots of poisoned THP pages stuck in the page cache, OOM could tri=
gger too soon.
>
> That is my understanding too. Thanks for the confirmation.
>
>>
>> I think it's worth to try add the additional changes I suggested earli=
er -
>> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@orac=
le.com/
>>
>> So that in the madvise HWPOISON cases, large huge pages are splitted t=
o smaller huge pages, and most of them remain usable in the page cache.
>
> Yep, I am going to incorporate your suggestion as the second patch and =
make
> syzbot check it again.


#syz test: https://github.com/x-y-z/linux-dev.git fix_split_page_min_orde=
r_and_opt_memory_failure-for-kernelci


--
Best Regards,
Yan, Zi

