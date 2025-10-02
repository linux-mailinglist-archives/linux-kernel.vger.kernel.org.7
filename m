Return-Path: <linux-kernel+bounces-840317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F22BB4185
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF416E8BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78279CD;
	Thu,  2 Oct 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1Vb7Jff"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4A24DFF9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413259; cv=fail; b=D0MxxdTu130yTXmrX3QLNUiSGDR+lvcn8ULRlmAAsLcii4jpus1Uk5ocabtiFpdrlSHQgkLm/duXkoiySYwa/8n1WGoEySyrEk00nyoa/rsUPWppieUNn816ejdzA94+2PMXYBgRKVfcOALFDXN9o4PxzAUYllFJSIsTBSDH9+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413259; c=relaxed/simple;
	bh=2wg42MXRiY21D2/i0J6ZNBh9HqIEO/KVnUIRbvLffrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQMUDVxAYjSm8JxZI7B9V814rJiZGwJbwqljNp07rSiN60uv3//5qvQ+DpC8k9O+mFmELAeE8+VaID1DqYfuuO0pD95PBbmJ3fKviVKwf5voEPYsNZprgB4v15mM23Og7+ztm+WEFQZbfY3i2zDtkinMXk9eNpNeRuJgxgXN/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T1Vb7Jff; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxHOYIM7ScYsGa7Xv1GC1PKI0oKY/desY2e0haXN3Wz7BXbJEl3mSr30LNFKlTvwP5Ef/zDfIlT/ei3mwYm1LtdR5Lswf+nGYiJP65g909aZFQqBPTJg57h81zXBpCCLR0aHCxpFcXHwgjBqrsrZbaQXdYiKzyqRnrAO3yCoMHSq+iDcBDc7AC42FAN8/7TN3whS4DC4ujBCwA/HRio5SpM+F5HjdNmfe5R1P4qBmn0W6kVSC8/Pgk0vQY4mQpYACvATJtRX1xkYkHmQSuoSPehS/O06qawa86yTHDlYNmDYRF5Q5wGeUj5/M3PIrcCIxnLYiL1DVnHIt/UIX9qa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WBE31DwClJBtVQtjB1gBKey13rmVJNYNJfawMAb+WY=;
 b=BZx7XCoK4k2d5jZv239Jx9Gd3vd1pHpAt8dcVxWy0lVmnRRi0sgjDCjpYPYBoteCa69mn+6y8lDEyH3okdb4vEnvm23hyo7XK8l6C9HJtWL1KEn7hK030HRrLGGABapPSM/Khxa3fkcDGfpbGT6rk4PdE1M2+q+qd8GoCL4j/jzMFC5Jx9JWijg+inzauyizdsI5EADrjoiOFLfZwIeAm+ItXVAHsvOSaszdJLUJZMuEfXioag7cyddbf+BJyRu1YxEl3vBksiHtK0O+h/48+2c7yIbIOMGwV+ZbzppWifDeeeC/DbhA8ifDcOTeudaS+sUsprPW6+rjKvjoZ0FQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WBE31DwClJBtVQtjB1gBKey13rmVJNYNJfawMAb+WY=;
 b=T1Vb7JffVRbr/NDFS26PTzxyUKMNVEprG/t7yA6QsdZSf5YLkYqOKNOTJVAq8gf+VVeF4t5Rlx4qhrr0CiL7YDhG+2SMmxRgKfiKEvT1eBxo+ZUux28pbTE5UPv7WZGa76cpGG/lvJIhLI15ejHBR1tOVjLKj+54pc2f8/AbVnK8AcfTYv0liYM05SfYiJm7r8vyaMgFejJA2hV1iyxKclZcTv/0+FBcuSKeZFTFGmcYxl4MoiRZVySo0JblXs3XhPNCW2MCfxIVLydW34rTwRIE8VYhj85m1iT9NDfm9sAlzbMu85a2ln+HVlPQWo8GzLE8YSlx4y6BLYw7DLCyWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 13:54:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 13:54:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: jane.chu@oracle.com
Cc: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, david@redhat.com,
 kernel@pankajraghav.com, linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mcgrof@kernel.org, nao.horiguchi@gmail.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Thu, 02 Oct 2025 09:54:09 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <CD6D8EBD-F139-41BC-9A59-5033EF5A09BC@nvidia.com>
In-Reply-To: <57d9aa32-2fc8-48d2-b68b-3308c7d58125@oracle.com>
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
 <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
 <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
 <57d9aa32-2fc8-48d2-b68b-3308c7d58125@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5fed8b-9c34-4c0a-0331-08de01bb2b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yAY1LVLlv0X8lbfbGJWZALRATM0SXslo8FF5xhmSUr1DvugE/BiXv2yUrOmw?=
 =?us-ascii?Q?38cG9r1as4Me0AkyzYAJ2m695LI981BAWVHik8Y4iUzwzioa2Y42VutPDGQo?=
 =?us-ascii?Q?wRQcfT5sxAapOxo094MvM4yFBGZgq3jHj6YdYoi2b/nTOQehpCqU5/taQVnI?=
 =?us-ascii?Q?rTX4Tu0AubSFcPEOUc+GlfBeMv+oiJh6E4UXKRnbMXoKRyrN4oVJP/c7lP2v?=
 =?us-ascii?Q?6zpF5SbVEeyBO91O912oaODD3xs2N5P3Dqz+jlILoJn1VzDaadSYoTykCmC5?=
 =?us-ascii?Q?3JE9gETMfACc965HKV43sZLXBBhha4r8iKKi9UwoHsfM0kWy87fE1yAFYXFa?=
 =?us-ascii?Q?M5DawEK8CBOBUOXS+FJ2TanTzpVj677MxrSLGwcas4nCfpGImBFNgYUDu/vI?=
 =?us-ascii?Q?ceqg+MFR2ZJwt4xSEUltjjy/aeCqDCbggcU3D+vHP6GAPVwMmNaUlxPmir3K?=
 =?us-ascii?Q?AiNVeELw1sA62R+Nde8dtGgh57n2JXR08biAYcJWInTyA3C5EPoZPDZHsvnH?=
 =?us-ascii?Q?SWV2tFltym6qMdPyuTbWEkAv16AyiNw7NKvJoyiOHDMpG51+EjSBtxVGuR5v?=
 =?us-ascii?Q?jjmhHVT5SS1sPLGRahnxaWb0LxLwLGB+3YX9i57K5SED233DslwMWNbO+vOP?=
 =?us-ascii?Q?x0wUigigGCnvA8wYqh5DrcRXY6U3VrHN3IRFrAfhnYzcdGqqHF6XknDv6jMo?=
 =?us-ascii?Q?9bu7cy+3HDx9+t0y6ce5FilJbev4jaow1WwWsTtoij2vNHU02thGmsK9SeND?=
 =?us-ascii?Q?CmrbhY5rbViOOJOR5EZ9ZFICSeq3CJfItR6tEmofQsSKYjWkNAQ8mkJGBMin?=
 =?us-ascii?Q?bogihOLlXEAzGzor+x/5LcGAY8FffYGz/CXKSw3jMCuXcgTEuFSW9C9FAtTD?=
 =?us-ascii?Q?X3+cOcOr5k9GyWLR/Gcue2vHOHw5gCBgOEWgz5Dms8Jq/DSmUzYZn3IOChUg?=
 =?us-ascii?Q?0hQL0fJWBjJ+i9bNrV/lWgW+wermCQxQpBtVOcU4AO71ncktxbsNkPKfFtff?=
 =?us-ascii?Q?ApWqzZBvP4e3ehrvEe+BdKNKYa9/L3qAUz0Zan+D22UGsQEgwgYI2lgl/Wj+?=
 =?us-ascii?Q?8u2mRRjyXXABNGOHD7me5FoWf75ar1SN1lhmS7kVAdZtOKnj09Fyu+xukpYu?=
 =?us-ascii?Q?HRZMj1SPTCQjJhMSSGoTAPY6BdOBmaYtujhkKI4c5uNe4zl4/gVSP1TruzEv?=
 =?us-ascii?Q?sGrWHi8pm1/L/4tqmwb3MThtQIFtivRylF6bNULbKqPR6bKFnEw9s+WiWZMn?=
 =?us-ascii?Q?LGIfpgk7Vz2qVCeZZyVkP8l+DNAHatTfEgn0YNQWTfJRSkyA+w9qdp7NPvMk?=
 =?us-ascii?Q?Y3hMQcRff3SfSdbhacqiDJQ2DhXfFkYbOXJU8nN01RhR8MMgQ1YSb44vUjr7?=
 =?us-ascii?Q?3EWns+cgTr9TFjC3a3o3euYva9P1VVOYcA8H5z6vF54B9X4VkKFFU+dv7kiH?=
 =?us-ascii?Q?V1yT/GwS63WtKSwow0IIp7+hRhL6+h9C1UQfy9zKkX0LIbrwPpsaOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2Kjgdjbw3I8+NW4jaICQthVMFO5AddxPKgzBzNgETkfdH72NqwO6oVUM+p7?=
 =?us-ascii?Q?4c/KrxcglybR5+LKsRj7yWskpnreZ8mTGuiSygRb9lLFMZjDOdgbeomeDk8+?=
 =?us-ascii?Q?393atWWND9rx8p52Tjqtw6QtPv7nILKL6+u6kuZ/qvpnIj49cpJbIRvijWhq?=
 =?us-ascii?Q?+RvuDrtrawqnDwEuQEmx1thDrNFtJSvGzPiXcWjb5wgHEL6cUxxY+miaAKqm?=
 =?us-ascii?Q?v0elO/nzd9nM7IpBs9hH5oAV970EhDjKj/kgqQvJA8btJSSG/Eol2PEfYcXI?=
 =?us-ascii?Q?99sez4vLqCmPzbWtrQkOcVFbWbnPs7MvToX+Xhd0AffoE8KZBMNrj/D0dqqZ?=
 =?us-ascii?Q?NZtRyi7A+ay+fOl0UTVgXPGOlraHJQgV2wrcwq4kbEccogImnJwRjxWPHuAB?=
 =?us-ascii?Q?U+IcQd/ySXt55hSmMSTqk0B6FoAVee36Dp4/MBCI3NGOfshSwBUF4rNUnYva?=
 =?us-ascii?Q?3ltJ7e3rPTuj6dNtHopmKm90pD7NqQoFPw2WkF1rB699o1Dd/4pMucFfmY9a?=
 =?us-ascii?Q?F27NPpsuwJnZV0PjzpoQlAfX4LdItPkS5+MX7RcvWYdErGUlF5LgiU7+rt/D?=
 =?us-ascii?Q?Kjrn0f83Au6AcQA4NwaPV7GhlK1BbHMaLlqnNms8jdAcIy5Fkziwr0SfUqOv?=
 =?us-ascii?Q?SKbEjMlPbV5Yktm+lIWswKl7jlRN6TZk1cSJWTXDPyiHnUazNG0fvMYsckfP?=
 =?us-ascii?Q?A8gT9gKsfyfVYlK8SLUlAQVIWLVJTS1GEav2ZTu21lBHfJha4vAfQLmvEaMn?=
 =?us-ascii?Q?Gr1bamdNUrNHwvhdR17DmwCydca4a6lnuqD2oKPVXFwB3EPWVykN8KJVfpZ0?=
 =?us-ascii?Q?AdtjYMjWs9laRp9EcLaZ1p1tPkcnUUpg4pBjkkHWHZTVoEgCBTRhoqtfKXE/?=
 =?us-ascii?Q?yjyoLcSjBORrxwcrUmYBEWo5ncal0UT40H2uYZr+8hSh5T3bpg6ve2GxAnfl?=
 =?us-ascii?Q?2CccCUtykLorHYYdHjIGsUbQi2fxC3xIduvBa7YwBAdkk0tOSiuQmn0KeZvh?=
 =?us-ascii?Q?fqTXrlZAA2qKXpHErlXFDmIKGTjJcR14Ar4ZlM6SFITeuorJmZ0CRJlkBT6k?=
 =?us-ascii?Q?kIpnOhTZu0howq3oaCgsDDJ9lF4tiw7bjSV3J24BImrZ1bRx6SuD3U4PEIyI?=
 =?us-ascii?Q?ngSj0p27cZoW7hJmDtv8vLAbypFaBNJa5tEpOCVjk6IK3d0FvRbK8QgiKvhS?=
 =?us-ascii?Q?pj8ljPUJjvWs7qKHJoxB+CgKnWyfPpwX1W0E3BYkqHlFFyR/bAF5K12cTvE4?=
 =?us-ascii?Q?vWM/cZtji8nQESlANg8ZQRSDFFHSV9fDq3Mrajw5k7icH8ivOo2Zwjn+38rK?=
 =?us-ascii?Q?iqdSr1EO84XTHoaO9JuDinDYEnLl0o30F1sguD91Dk37wKMxnkK5QMCsnmrb?=
 =?us-ascii?Q?lwuZCsMyC2q1JnYf2UwF1/KyIUwll1NeWWmdlMteSKWE2lAuB1Ul9OD2fdQs?=
 =?us-ascii?Q?UQEcED4/dcAaF17eI4pJbA8gnRX6YmIon8drLk9QdB2uIQKf30RflOmDH2oV?=
 =?us-ascii?Q?gDDb4WGYGa7jRDHeTuzuJbZxsaxaPr4/aE5c7vuaf+ARl7WLzt6gAQMvVnfl?=
 =?us-ascii?Q?baEUjS33KIh8SCOpXoI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5fed8b-9c34-4c0a-0331-08de01bb2b49
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 13:54:13.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQWxgeZdAGbvrREn9mOcT78LI2k3jRZyFaAvWR3FFWNiSoTCyMsQJmaPON7joeN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

On 2 Oct 2025, at 1:23, jane.chu@oracle.com wrote:

> On 10/1/2025 7:04 PM, Zi Yan wrote:
>> On 1 Oct 2025, at 20:38, Zi Yan wrote:
>>
>>> On 1 Oct 2025, at 19:58, jane.chu@oracle.com wrote:
>>>
>>>> Hi, Zi Yan,
>>>>
>>>> On 9/30/2025 9:51 PM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot has tested the proposed patch but the reproducer is still tr=
iggering an issue:
>>>>> lost connection to test machine
>>>>>
>>>>>
>>>>>
>>>>> Tested on:
>>>>>
>>>>> commit:         d8795075 mm/huge_memory: do not change split_huge_p=
age..
>>>>> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_pa=
ge_min_order-for-kernelci
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17ce96e=
2580000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D714d45b=
6135c308e
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3De6367ea2f=
dab6ed46056
>>>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f9=
09b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>>>> userspace arch: arm64
>>>>>
>>>>> Note: no patches were applied.
>>>>>
>>>>
>>>
>>> Thank you for looking into this.
>>>
>>>> My hunch is that
>>>> https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-=
kernelci
>>>> alone is not enough.  Perhaps on ARM64, the page cache pages of /dev=
/nullb0 in
>>> Yes, it only has the first patch, which fails a split if it cannot be=

>>> split to the intended order (order-0 in this case).
>>>
>>>
>>>> the test case are probably with min_order > 0, therefore THP split f=
ails, as the console message show:
>>>> [  200.378989][T18221] Memory failure: 0x124d30: recovery action for=
 unsplit thp: Failed
>>>>
>>>> With lots of poisoned THP pages stuck in the page cache, OOM could t=
rigger too soon.
>>>
>>> That is my understanding too. Thanks for the confirmation.
>>>
>>>>
>>>> I think it's worth to try add the additional changes I suggested ear=
lier -
>>>> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@or=
acle.com/
>>>>
>>>> So that in the madvise HWPOISON cases, large huge pages are splitted=
 to smaller huge pages, and most of them remain usable in the page cache.=

>>>
>>> Yep, I am going to incorporate your suggestion as the second patch an=
d make
>>> syzbot check it again.
>>
>>
>> #syz test: https://github.com/x-y-z/linux-dev.git fix_split_page_min_o=
rder_and_opt_memory_failure-for-kernelci
>>
>
> There is a bug here,
>
> 		if (try_to_split_thp_page(p, new_order, false) || new_order) {
> 			res =3D -EHWPOISON;
> 			kill_procs_now(p, pfn, flags, folio);  <---
>
> If try_to_split_thp_page() succeeded on min_order, 'folio' should be re=
taken:  folio =3D page_folio(page) before moving on to kill_procs_now().

Thank you for pointing it out. Let me fix it and let syzbot test it again=
=2E

BTW, do you mind explaining why soft offline case does not want to split?=

Like memory failure case, splitting it would make other after-split folio=
s
available.

Thanks.

Best Regards,
Yan, Zi

