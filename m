Return-Path: <linux-kernel+bounces-838327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D12BAEF91
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4152A1F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C624DD15;
	Wed,  1 Oct 2025 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+aoz4Pk"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C746B5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759283514; cv=fail; b=dHymgPYwWJSY1AbpCD4CQdm5iQBi84+QETOkWCP4afN/B4oheWY8s05gOm/hf7aZB+SNxMyyr7m8XGOtcvYtu1m/hJCWLmNq5s2ILYCHjYsVNHee5nw2sUCL6pRZby2MYma/6UZHzoPFUMwCD1PSgsdPp0/Qd+yE/g1mYi0wteM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759283514; c=relaxed/simple;
	bh=xlu2XMRY2f0T8G6lPWLyKS1VNQ62p1e6ULRvWE0hUg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ybd93YVriHKRQ/siwYaEkzYi4Ma1FToQnrnrc091wLPEwOcLulMDIEB7MuAeb89mgqD4rTC1G2iHct0q4uRGE1HwKqAw9TvjF0w5EYl7LpMp6LzJLYYAM4XBZDs5+mZWFrJyNxJoD89yBiE6Q6jep4uUBjZJ1CWroEHlBgKk4cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+aoz4Pk; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC/D53r2pxMYZrzCzycbFF9NbO4Vm6p3Db0vRlDbvp/BneSomL3+jqT2OtUdeav8OEwWMv9dcx4kPhTfy5wZM5dJmOMik80xFsLcrtTGh6x4wjFVLQvnLgtRZTCkWF7BhOG8oh5AOsp2OCsVU48HraAke6y4qW0fV/OTfC9apk85cOcSw3G9knYG4bWoCbSH9ioGM215STqlWSqsPNBsnEPmnt/f8/RK0AEDnzDHEehL0NvHLfYETxFOUBMUeNjUF6J0SMx1mvzleyUmuDyU+I4q5qDwt2lo/+ASzutuaa319s1mDInBw6EY/f+i3NVVYAzHpDv4iuhQdU/3oQP1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5k5y/YdvpulpJhnXVHU5g5fta7hIvppvsSDP7DUegU=;
 b=BGJfuVC8b11sv9wfkB7BgAjNbjGhwrUgZpDmYn9mi/y7LgPlS6K1tX6hR/0Y74x5biL1jOWMIMmCQW3q44mlo927cH7BRi1CyD9CwmqFG2MlRuz2VgBeKOWTjrYhbPPnZYQVgGgLXsYUv3w5vLrLRtWNKmTbkpByRMbm7m8+EwMSGQoXA/VOUYYqG4/y/blO6xRyoxkj8z9V+uWaY4YX8r+TUhf9B9q0ieieEmfaIpAtonKQl2sTR/y6w8JtZ1hdIS6EG5VDW+1eDHm0mgBaK5WJe7NaXwJn/RVJjxtxtvBZpYGt4fnSIis0LUS59Iqa2naI8TOgY0TFjgAB1QnuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5k5y/YdvpulpJhnXVHU5g5fta7hIvppvsSDP7DUegU=;
 b=G+aoz4Pk6J4kC7tM1IVl/PedGDelPBt3JQ1Sruh4MbuAcyK3OctidHM7p+nyChMAucYylZacI7FUxEarpX9aDIJs9mvoBuUwNyHRUuXhZBwOSStV+TW0N2VMvMROFD4+mbDBWA9OB50/8k9OpM0vISjNhId4FaR0q0CwNra+4bCTAPSJlwH09+NVI9Y2RDIZUPDG4KJSuB4ZqE6IjowvDVMWt98p4MP4Yy8Ib9eieOmIcwkTKWyNc3hvsjx5S+snZnD99jtTOLXd3QtLE8OYj/gt0aRwCmtEI1Fl1NArhm8QDkh9PT+rLoYFRZ5HxMv3EoL+C4OXO0te/tt+iQxt/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Wed, 1 Oct 2025 01:51:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 01:51:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 David Hildenbrand <david@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Tue, 30 Sep 2025 21:51:47 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <C7CD4DE5-1C8C-460D-BB9B-1A11C8E038C6@nvidia.com>
In-Reply-To: <CB2E9455-480C-438F-982A-AFCA1051BBDF@nvidia.com>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
 <CB2E9455-480C-438F-982A-AFCA1051BBDF@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN1PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:408:e3::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: fa598117-b474-4dfa-83af-08de008d1674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?46Z0dkSEPu//cKgW/T7fSMtkmMAZmuvEGnE5DnbYgNAyKDtxE9r2GcSi+vf+?=
 =?us-ascii?Q?3ddkN9fXJiWcW6PXiksMTH78AUNw9t1Qt+CH7EpCSCS7o3vAYBWejm5YXEs/?=
 =?us-ascii?Q?X38R0TJ7BylYcjm5HatpZynRHyJ3IS++xb2mLdyN2wiP6gbjsohDAtHCg703?=
 =?us-ascii?Q?5uKf3qvQXxHMiXe6u9fazG601nEsGYLPPj5lKVu3Pj14IogNOkSyngPxFr61?=
 =?us-ascii?Q?nDQxctfgdVz6O3+E/UeaZaNVMchBea3IeqRVCZuOm+I/RGODB0vBmnAFycxv?=
 =?us-ascii?Q?CoWu/zFC0xWv8BYvsk3Arw1wYv2t7/5EFq8tRlziu2JwrvyA4iaRrueyy/+h?=
 =?us-ascii?Q?D1u3uMFAg0qNrjdpkim6DNs23tgxcXQz7KvKIP+UsLjbrk4AnD2NyXW+UMhx?=
 =?us-ascii?Q?eNaNNwgDTFCsM07S1iAHJRdCEpKdTnxAVHHK6RhmBnRTX+/o8MeXfOpzBoMC?=
 =?us-ascii?Q?QExOo2xA1FqhXspG2bVHZxkafAKQ9rsG2Wv2gQxqJgL5FnixMciOBjQzcJqO?=
 =?us-ascii?Q?ZLO/YdH3RwFfi1O+eUFKRFxrrnFl6CEHFCn4hIYIKvSpRZtzjr5hSzn3Vkg0?=
 =?us-ascii?Q?h46EpYdSYzN8rAFDo59mmt3dc7cDkoT2apJ3dTU0lNIG2xfBGyztnL02MJXH?=
 =?us-ascii?Q?h8qoCwXxWYbz5W+T56PPfM0ku5zb/VqhES6YLFrVGS6vtsDPCwUuibCUosLc?=
 =?us-ascii?Q?k4o+NNcCmsXf19BwA4HZQwEUknADERXkBXZ2pU6u1JP206p5BJPKdpB6Bo1h?=
 =?us-ascii?Q?cytbB+Wf5tvETB2vRrx2od1A0FyDkpizmE3B4cM1GQRIpSIK1ar6IjVtQAUe?=
 =?us-ascii?Q?VeHpuZ+RYxy8SmU5lmp3c0wlVPP8z0o4Ur9eeZjx7T06aYAsLFd2Yz7wXsAy?=
 =?us-ascii?Q?3XH1GvTrJf9RvP51RSuKCzmZW73YfJ4B2xSsF4IQr4txQ10nWX1WbgdrXwZB?=
 =?us-ascii?Q?AUvgwQVuQ30yLwOLVePNWIw7Fy91awXZzA3qdvv57cTI4jylewhBfen4n6XC?=
 =?us-ascii?Q?bMNPe6ejeKAUDfDqlDyKvh6DoSBcoxQfdg8fMsNTUDmyXhkvsOHnp3lioIk/?=
 =?us-ascii?Q?vx/+Ty/M3eR8SUBghZRkpS9uRhoiiVMZNVWfOdlpAqFFeTX8vAOhor1XmlSI?=
 =?us-ascii?Q?/OjpdqwCXs9Z0PfmVXFBqA7vHbwp3Tqb2twD3E8L3uK4OLPSikuWA6UEQa5R?=
 =?us-ascii?Q?VTCuX8ZjRChnEoGs49oJNg7AdEy2wSbri94SEYOihXqdSco9LuBhGZOL1g6G?=
 =?us-ascii?Q?rjR7qhNRC0b+r3QPP9eyft+F7Xy+dWkrrOq8ulyiw1PU/x3c112c5qn+KM1Z?=
 =?us-ascii?Q?paM7Xq70egJ0JBG4c6va7dsNY3gn1SPOdhEptLILYux1S3P+YWyhstaLwV+l?=
 =?us-ascii?Q?8YImZIetdW+hVnXmQFAgYnOalFj11g1//vv/ITcxz4wuybqEO5gxyXYnXRtG?=
 =?us-ascii?Q?rJNN0d72l+rDBjK+Mv4e5f0nA1TahTHy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axQxXoTqKT3A/z2ME+nY0E7J95GdhIQQJXloB2ILgB+fcbw6gq+xUc+B8MJI?=
 =?us-ascii?Q?j6FAg+CeH4cwdvs4t9Oxs+7kSTXAGXurIwP1HaIua1DOFTFE5tkgQ/B6EBdP?=
 =?us-ascii?Q?rKE/RVBXH21WnBPAfh97OiAzw2GHKrTEinZbmUHhxjVNdlHylp8AnCrzQKX0?=
 =?us-ascii?Q?nczjmclkyHx5Aia7Nl4WqEZs3veLBeo+IiCS29j4jitSbHZQp3220UmLLTdW?=
 =?us-ascii?Q?VRwUAXVg+8x5NQ7QAH/ELNM5zOXiBhnzsYO8v0kinAhCbeeGKn+yay/lWvYn?=
 =?us-ascii?Q?HrJ/DRugUdgKOlH9AOTZvACbNk5CJwyqcIr8j7W6b4GFlQyWeOMw2cFE4QVW?=
 =?us-ascii?Q?oS7Ov9lcsIL6kFL6ncj5HgndFnNnjT/z1PsejZ92F/mzYgR7ZD3CLQhC/k1v?=
 =?us-ascii?Q?7Nzz1s4a029a9ozFN4uKznehMwMoCmQKdMaSBFgItrxsXOTvZEwwk1F3M2Fm?=
 =?us-ascii?Q?1qbh9UkXuOWBU2qa8f+b9pMnJR7j4uBS04Uiem4DRosON8osAFs/ouJ/2t3W?=
 =?us-ascii?Q?vSMileO8T7lMUpJmcPKXhjSWuhlS/uz+ruWKWbTmBiGAU6BmkMeezTCyMAmv?=
 =?us-ascii?Q?hotaZz9fe0Ux7rNZZfh5b+mB1sSFdswzmJcROpS7m9rQxhcxyxZm1g0ykoiM?=
 =?us-ascii?Q?SG5MZlv5tFzdHp6Lg2l2c0JiqJUttCuWD+m6CDWND97z0/Ew0qpOkNl58Qh0?=
 =?us-ascii?Q?vjiRZNboedtT8xl1Ul8YnSKcr9Fsyoj+AZJyPpxrqn45OR/ecWn2rC9TGdeX?=
 =?us-ascii?Q?d0/v7lR+d0MedGP9k3b8FwLV9NerH4q/Kd3Zcez7GMcX1QAKRSRvo23xxCAT?=
 =?us-ascii?Q?WjJlDBtdDMcoe2d6S+KRgmvtckwRdUdiIHP9SR/OzNEgXsZFBTF404J6pduC?=
 =?us-ascii?Q?Oer87JW+y0tEzzviULLnbJv6aJHl5F8Rzq/u9dblfkM2h+7GiVJUKJUMPEP/?=
 =?us-ascii?Q?FRFA3/N1ClBcI7C7SWPQpFmYMcRJqSzus8Gv/wcsxsfTFrOxdwdOLcADm7Xq?=
 =?us-ascii?Q?fNgoYISayjaYWTGN2uTdhlyIAhcu+yvE4BiwOtkm6hluoTJbvm5pNUu9Lig8?=
 =?us-ascii?Q?RJo1X7w9k7rLUgQyLJgYA4ZHvnU44BALHwTAx0TJQvX9jUsJ1QABKOlRcPMf?=
 =?us-ascii?Q?lEjDiarFXV4OknbxS1BK/ONblz/TfwWPq1GHyFHa+na2LhaAyeOX57bJMuU+?=
 =?us-ascii?Q?sqYRgd8xgJO0OIOhRi6qsFug4xyZ3htOBA1R6owG/vl6HwR9TGji2HKeO9dv?=
 =?us-ascii?Q?keqh+fnrBtXmDM/X17VRFDPNAx5suhhpo67Qm5b3TrM+KxiJIDv7u5BizqFB?=
 =?us-ascii?Q?Vm1JOahdEU483mXtf83x9uLsfmyF0jO16+m6bHisuDvOkGeYpyaWLMFxeTt+?=
 =?us-ascii?Q?I/uo7a4yF0ZU7PCBU8dnNgZ7Ru/MJrY0t05cI5VYn8Y3NJgENYcRXmyIos5v?=
 =?us-ascii?Q?RUaw2nOjZR1D93QvFo+vpBQs4z7X3SeV91oHCAx79n8fHz7b60a3sl7tIFpR?=
 =?us-ascii?Q?N8xMFlKFsuwaL4kIBbucMz9Lezqn9A9ko+VEljXOfRSi3cZH9nVowVVaaxgE?=
 =?us-ascii?Q?Ja7K9m0HWZ486IoSKqDUFNHVSkr/ZbuJzsL/5MEu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa598117-b474-4dfa-83af-08de008d1674
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:51:50.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFHJxnyaaiIfL1OSRgYs4af2x5Bb8TtoJkwqLKJl1YVumCMnE6B3O0gcpxIIrV5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436

On 29 Sep 2025, at 11:20, Zi Yan wrote:

> On 29 Sep 2025, at 7:08, Pankaj Raghav (Samsung) wrote:
>
>>>
>>> I want to change all the split functions in huge_mm.h and provide
>>> mapping_min_folio_order() to try_folio_split() in truncate_inode_part=
ial_folio().
>>>
>>> Something like below:
>>>
>>> 1. no split function will change the given order;
>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new=
_order
>>> is smaller than mapping_min_folio_order().
>>>
>>> In this way, for an LBS folio that cannot be split to order 0, split
>>> functions will return -EINVAL to tell caller that the folio cannot
>>> be split. The caller is supposed to handle the split failure.
>>
>> IIUC, we will remove warn on once but just return -EINVAL in __folio_s=
plit()
>> function if new_order < min_order like this:
>> ...
>> 		min_order =3D mapping_min_folio_order(folio->mapping);
>> 		if (new_order < min_order) {
>> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
>> -				     min_order);
>> 			ret =3D -EINVAL;
>> 			goto out;
>> 		}
>> ...
>>>
>>> WDYT?
>>>
>> I think it should be fine as along as we return an error if someone is=

>> trying to split < min_order for file-backed folios.
>>

<snip>

>
> OK, I will send a proper patch to fix this. Thanks.

#syz test: git@github.com:x-y-z/linux-dev.git fix_split_page_min_order-fo=
r-kernelci

Best Regards,
Yan, Zi

