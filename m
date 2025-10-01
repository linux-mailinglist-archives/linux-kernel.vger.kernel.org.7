Return-Path: <linux-kernel+bounces-838336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0201BAEFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226A04A7A51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02C25C822;
	Wed,  1 Oct 2025 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMVbHnnf"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E061B4F2C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284813; cv=fail; b=YCh8Oz42YCCqvvvf3xu4wTTTDQr5gAnf15vCTM6FAEUVvVWT4CfSf4J0twWccJHWWXOwrPzlgKcyx5zLu1WhkV8toXUHLbp1mFf2KVm1Nmhsnemb9Rgza6T2+PMYe/FB4SPc6XfV2RYkx5gOCMFoF/sOwbVwEndRRlfWbh9c9Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284813; c=relaxed/simple;
	bh=MIWiGq0licoenanzYRKRzBtHS89cQNvuMq2qSnFQaVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B4pV76alL+RQoxigreOOa7O0aUEYQQiaOcqNzQ4zkcHF8R866Teepdl6NYB8SBc0PSixLgdCLFEhdRFPo6SWuckUDRiy2KArm7W46K4gatJJ5dXX/lUHJkoTfzqSP9pY6xFaUTd7GSSmoMMrOWUbdMFtG4k19Op7trz7ftfFxCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LMVbHnnf; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEdmVHl0pe8oIxq9TCW3OF00LFeNDGBc844HcP9W+UC28uEJNBto/xOcur7dglSLKa3w+0L6nWw7X3AzZ/QZ6bDijs8asQD9zsPQmmP3ta0ogLcO8aXZG4PxMUcdAhRS1aw7nAcoyY/2RGKpGf4bBRVRn93HotvodY+TZwP/igtk31rP7tI1Mwh2H/oMwP9LZqD3fwG+wsWPkL8HFiSC0CKXtr46R5OhwV1VsidZc45dGFccR4UhmdAChPzF+z3pmP19hRN+E92z/CXEo5hqMwwRR1gdTOD6FsRo288dOlrlw/d0tG2QV/NygtP4bkhHsSFrw8fm9OulY1ZqCeb3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzdxXIveayq2K1aICTqv1gyU1qWdEZXL/GS0UiVe01E=;
 b=bTgWxJYA7G4mlIw3HNddWZwYzuhtVQga+MeTXnS+uJ4Iukwo3tStpFQ2nsxo8o2v0YZfJFZRWhTFttMQxhGl6cTsMRDb1jjYONca3dl16n1zZHhMgxILWbwds+28sEdKnSuCCkxZyu6/175jv6iKUKeU8wGlGxIE1B3DWJQ5yB4RhnMSeBTwZVDjU076glwKQyBkKm11eLJs388VEPBe9J03KU1F0gZYZhEHqXyYD4q1h1PvwafUWbopOrrE60PZbm3yLYSVMzmJzYE+/HnuMfkOz9F7w+X8E5a6zmboKp6TLZwRGBeeUyC/xREPL2vmvWGRIlYGd95WgpdEMXtcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzdxXIveayq2K1aICTqv1gyU1qWdEZXL/GS0UiVe01E=;
 b=LMVbHnnfGj56BPusK8z+e6jv1uej92Kx4S2d2nhWn7kUJW4dwWfyCJjKADA/Zy7VWqRxouBs828Djb5QuFi1EZ3bErHsNE2Jn5ULR4grmmDaF0iAdDG4FrNyxnXFq2yYYE4xrRlMpP6fvFNdjHi/dWjpUnMG4DfEFDM+7R70lExcUngHnsCYsjmzmzlwn6xApByLE81+DIlXPIhTM0pK10SM1DzQHbzg2n2rnVvTT5YQJB7A6beHYwaizZjBkdYnM2FoA5eKedUumDmtUpxaG+Ngd/O6oPVU/Wj5vO4sD0Rfv2iVTcpBwE28mp349CmghQWKgEEbGUCt8M/+ijjhvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 02:13:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 02:13:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 <syzkaller-bugs@googlegroups.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 David Hildenbrand <david@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 <akpm@linux-foundation.org>, <linmiaohe@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <nao.horiguchi@gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Tue, 30 Sep 2025 22:13:20 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <7F95F86F-F002-4CD1-A5B2-4A261A9D1317@nvidia.com>
In-Reply-To: <C7CD4DE5-1C8C-460D-BB9B-1A11C8E038C6@nvidia.com>
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
 <C7CD4DE5-1C8C-460D-BB9B-1A11C8E038C6@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:208:160::48) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a92cc1-880c-45e1-f78f-08de0090190a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a/g/kK0wqZai65lL7dh1agae9/k6qzBnz0cD/u5UGMrV8GQsrAR8iMRgZVZL?=
 =?us-ascii?Q?Ftexj/bJKI0ybqfOCXkj98ovBUV1XG3JvfzkYf5btfUfxjUDAAiW/v5BgY2+?=
 =?us-ascii?Q?RfrWs2f/HSC28EL/LPLz8Cvs/ku1NIgoobA6W6qroHVGmovoYIxM88M0gYlo?=
 =?us-ascii?Q?zrUaBbi3QQWaCTZw3Eh1GsKGhs5BfUtcHdUXloYAia6lB/eZzl4t8hnrx4uR?=
 =?us-ascii?Q?UlqT7cbI+HrLbMOrs6y81qiB5MyclKd8YVi3lh69/CZkNf+BW37KpsCw0ORh?=
 =?us-ascii?Q?e4W6T2C3CYJf/xP9xmZtcEgMXJRDoIIQ39HZ/vaqTdn3IQpHugf1uLZqfsaP?=
 =?us-ascii?Q?DVqyFdkN1CZ7pX3iT/YU7NzvustPaqTsF1NO6+gJkFLt1hFEWoRWy3qjGQKE?=
 =?us-ascii?Q?R8+NB9dLptUks8K6XPMSU10es2ww5J7u7WDLyVHgcjiUkP8+Ay/OvSS8do1Q?=
 =?us-ascii?Q?dOZjJiYygasBos6EbEE/Euxc3GwVfzR+YC+dzYTvuHrxLIB+8WdjvB6UPMoa?=
 =?us-ascii?Q?TuMHyRPrPM0IhLMTGMnEkXobJmss3qtPoZb/WCMp6sIrkJIO6DKn2tTpDCRG?=
 =?us-ascii?Q?8FnMVekdRyd8aIsk+FlWxgK4m/gdakeoH16VyqLgAVSNWsrlHTZtA3HQvIGZ?=
 =?us-ascii?Q?nPXu9BMbXGslsRa7vhYnUjbfjqQKlA4WfsH6czAM1cBzrM91amzm01tZ2kIw?=
 =?us-ascii?Q?fkM8GOyPdPUWKrVS81Xf6zfoHNSo7upiprqE3RM6g+tHyeCllyYlY9OBrSAa?=
 =?us-ascii?Q?RMB401PxwCzTW+Qibqp7rsI15vQoUjA/iSvh7qJoDJRTyVh+HJLMkqa6aNbZ?=
 =?us-ascii?Q?rdh+doCKee4+EDWzR+6DfBWdgYAj6uCkcVhrM+n2maEYany943ETutiFfWA2?=
 =?us-ascii?Q?jZ3rESg4h1d5GyFsObG6TyE5R5G6Ce27tqJIt7a/7sPjyoYCNMIGVUdF5ZIL?=
 =?us-ascii?Q?C9ku3EYzkpVNMNZGKTQNi8oCrvRChSmg73INIFxJXmkWLMEaQq2vPoqa3I0+?=
 =?us-ascii?Q?SGdfLozjxX45iQ69zvcv5d0XNuphYpzxybh7zMHef6kPrQRngI+Hroj2/0o8?=
 =?us-ascii?Q?+Yx45A/nmg1SUDQjtyY8LM47zO3J7YKKBz55HAl9wJbqCTjdeOPg0kCc3drb?=
 =?us-ascii?Q?rckNZ6FghaRy/g+zsOFaGNG5BiMhDKUZcVBKiLzsgiUPlLn1Ol1l25gDwp7c?=
 =?us-ascii?Q?QBLliUPV2hv9clHQPlwoekP3J8OhSYJvYIchDCNWMah7EnruzYwV2I+ZGNkn?=
 =?us-ascii?Q?wBTq9tkFzoxQ336LkE6k34TXeucWrCD9Hvz8ZTgmdM/xHH8dDHHaQnOpMB+6?=
 =?us-ascii?Q?Rd3+9L6xl0sUkUtZDBgLGmz0o0ZcL98y0+XIW/Pyg630opbh1/T+sGGQNEtp?=
 =?us-ascii?Q?ywUFF3MI0D0a2j2EcDt5TD3xclQWR9X9ZN+JMHqoS1XD4e3v6+wGro7l2SY8?=
 =?us-ascii?Q?MR8XUKTuNUzgR3Asr0SFIlJH2KONp7RGbwfpKkED2rNfReEi5LxpvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vD1/1bjHnP4hcPKssvu40JOTYFrCXIBOflfCv2s2JSTLqcLfLrFlNvbocr2t?=
 =?us-ascii?Q?me0XZ3uzuKJCvXwYXpBq9wOgQ6n4u+xZDRCjkK2Bgiv/Mal5VrGz0t/kDEOf?=
 =?us-ascii?Q?wGME6dkFY7F2LsaObmXj8UTI/yaYUKpzpUPUZZHvKJLaj7GScHrH8VTQ7/OM?=
 =?us-ascii?Q?2V5VPpW7S3WU3T/NZpYL6eXir3GynKXVZc5JW2eNf/rjbzdVFdbPUOMSVMyz?=
 =?us-ascii?Q?qwtqUTZ8jUP3SJ4LQ6d4zEknHFZup9psuOu4xCwCIcm22opEJlzDk4U+hdrY?=
 =?us-ascii?Q?+gp+fatP0IHRFyVA1AUiQL5pc20RLYX8rm9dHE4wG+1v/VvgW4bAb1DTQiUK?=
 =?us-ascii?Q?gEQiob0kYPdLS6/Y3O9xxdQIFE37cxhsNdlXTQgEZw0a1JN1AAyJoN3cBR+x?=
 =?us-ascii?Q?dWuFsoozvmclaE3ciY9PvxAgfqk0DeZ2N+92yBaWhhXuDlFIkUWCsM38Sbb2?=
 =?us-ascii?Q?ZV+voUt7MQ74t7+7u1k5kFN4tDmrpZwdVeBY6f2M0dfP9ST3XBMNAUZIEirS?=
 =?us-ascii?Q?S2r9UFGSXv4hFlslPeMmlIeiUBGOHRL7PS8rRzdL9EsMv+eM/9s1ypRTfwN9?=
 =?us-ascii?Q?n+zChgc8SNM/PrH1JTRiwuBQDs0nS5+1Kp1fWeVlTD3We1GyGK5YBC2KNsiS?=
 =?us-ascii?Q?WQ+uibxi1laFAdMP99kvnWv/WEf+ikUS2MxcwW1BdqMLLeMn5VttQSm/B1hI?=
 =?us-ascii?Q?sLM5dMhkux8vGtd/JZ2RtCPmyFMZJVlwc2Qo3uhXksXNyTiXTn5BTiwEnB1a?=
 =?us-ascii?Q?9zZSoL2XNhiAkADXN8NxIn/fNfMkAuXX6aSH6BEOj64jOBRs+jdvPcBr5xru?=
 =?us-ascii?Q?MM/j1g40eJZK583vP32hJrnr0N4+zQsm7KGhBMRC9PxMEHK+obedns4TrnJi?=
 =?us-ascii?Q?QKNa1TZlCi3vukbxIgfH0dcImOGAi+vCsgMboNrRkSjTDPW29mf12RHUHdid?=
 =?us-ascii?Q?BKOFAfRMk67WgH7QTVZV89x4gu+jCAZHdNnCaJHDBR46EQeI4olALUx9GdaL?=
 =?us-ascii?Q?EsYa9KpvabrjPYkx9mINeOoesXYgO4TDFQ/Ns8tM/p1b49Ws9XkBOx0hnCIs?=
 =?us-ascii?Q?IDS/eXCdBbmIQmRf5cuaAUF2g7cdwAzrrum0B1EnFXBah1wxh1i5bRFEQVxa?=
 =?us-ascii?Q?ZPtKynMZNwXuSNYeBDWR5A4r1725nS+UlmrbypOCdJZHPLs6ozCle0w3eUBp?=
 =?us-ascii?Q?uPSo1UYkiWpSwzq4152CZduWQuVtADo/ekY5Y32IxzOU6s8MHQW+9Hk5hK9w?=
 =?us-ascii?Q?gztKB0ftXqJueg1mSkzQLFI08K1bdIs83k9nqFtr2kz4OlrSANXb/OHXHLgH?=
 =?us-ascii?Q?SRKwA+9RngcoBkUMLzBqYoqG7kFHnRHhO9F99lYS+xuhW/UrDJYMnXVRP0Di?=
 =?us-ascii?Q?3qnJ7ap26jNL/9FOWueAlwApUExluPioS/HzM2AsrV0UdP1CFBEpk64kz47M?=
 =?us-ascii?Q?cD1Lpd6BZ2W0bTCY6PZly7Rd89cJYqO4MWxa92UzoONFGah0c66QR2cTm8fe?=
 =?us-ascii?Q?HDmwXFmgBOgKVVgrUCadz37GBxVJxE1t8X9XhAJrT7s5Wv8PATrlvx+seD4e?=
 =?us-ascii?Q?gVgGEUVIuw9qXKi7fLjmDYODZgyXpLXiyRCHCYS2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a92cc1-880c-45e1-f78f-08de0090190a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 02:13:22.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPDKDA4SIsWdVvP9Nors7l+MgYLyQtbymBNnMv6nhLRxnWhBi7um4vBD9fbnZGE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141

On 30 Sep 2025, at 21:51, Zi Yan wrote:

> On 29 Sep 2025, at 11:20, Zi Yan wrote:
>
>> On 29 Sep 2025, at 7:08, Pankaj Raghav (Samsung) wrote:
>>
>>>>
>>>> I want to change all the split functions in huge_mm.h and provide
>>>> mapping_min_folio_order() to try_folio_split() in truncate_inode_par=
tial_folio().
>>>>
>>>> Something like below:
>>>>
>>>> 1. no split function will change the given order;
>>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided ne=
w_order
>>>> is smaller than mapping_min_folio_order().
>>>>
>>>> In this way, for an LBS folio that cannot be split to order 0, split=

>>>> functions will return -EINVAL to tell caller that the folio cannot
>>>> be split. The caller is supposed to handle the split failure.
>>>
>>> IIUC, we will remove warn on once but just return -EINVAL in __folio_=
split()
>>> function if new_order < min_order like this:
>>> ...
>>> 		min_order =3D mapping_min_folio_order(folio->mapping);
>>> 		if (new_order < min_order) {
>>> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
>>> -				     min_order);
>>> 			ret =3D -EINVAL;
>>> 			goto out;
>>> 		}
>>> ...
>>>>
>>>> WDYT?
>>>>
>>> I think it should be fine as along as we return an error if someone i=
s
>>> trying to split < min_order for file-backed folios.
>>>
>
> <snip>
>
>>
>> OK, I will send a proper patch to fix this. Thanks.

Let me try again:

#syz test: https://github.com/x-y-z/linux-dev.git fix_split_page_min_orde=
r-for-kernelci

--
Best Regards,
Yan, Zi

