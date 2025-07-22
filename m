Return-Path: <linux-kernel+bounces-740127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830EB0D044
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B474A1AA3463
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6727380E;
	Tue, 22 Jul 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="cmVYR9Jz"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022124.outbound.protection.outlook.com [40.107.209.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0022EF4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154795; cv=fail; b=FfahA01ASq8c3v9vvdFU8yxonBGRIOV5RxlCiQKg/Iczu7ktdcexIWsIltmuGSyfwykRIC4Oakl8N+uzu2EJIcjNxOmn67EmnKPXbwzwj3qfejuHprhfSq8WWoD/rIJgBnmdY1X3YCDzdw9Pymksy/NdB01+H7b/QgXE455JkG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154795; c=relaxed/simple;
	bh=+W9sdBSPpQUoU4MBwj5xskE67t8QxhQxWiI8aASChpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxB3PsVIQX0F3xriQ34cRTlyMKbrff83000bVoGCu0bZLKGAznGvovIhsXsBwTP3nA3cDN3s8dmLwfH9PWngAmiIQ2CUPuCRNeaTK81I6pzNpRyFqRqLsZ0TIdN6dfdJCWlpyuPpdK5I4tX/ZTse8EdM9Fx+fSF8YrRKH1LxrH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=cmVYR9Jz reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.209.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/Xz92pqk+FEQB5QVH46IdKBtn0r1EQAELrn8B/lmlRoEr1V+Fswp6HKNg7xWx6ax/XuNHun0iivpBDja0WYh3ed3zwL43Xgsd4WpCNzRz7MJmZeMa8ugZlMSJd7e37pLahTDqyvZoMFVnKYtsgllZy+bJNpe2ZK92NZvC91U27LJ9FxuYU/7HRsdhHUeVH4TP7z6OnAxX/mKMO4dd3P+q0f8z358Uan2B0y9rCQ7I7OoTp5sGzx/2YNWHBbazcZ7Fbsl0Du3hne9zf4qlID2NKJWw6r3tgo7aXRRSDVAOmhB9LC9vZ7abenqacUI5R0IIODO2TNrgKZENIdTX6h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuppGXhMHpgqgTAX6KNarm3AN62PPnQF0Kui8PpjBec=;
 b=fmSti/7b+SPYL5vc5dDV0sD+QpUNHLXF1XgCvKWiVFQcQUIQ9AH+PhTa+YY4gIqcVru2r/Yr651G3gETEN1wC4gKUsCOLbUPdtGK5IjfPiqrv0He9qMh0QrcYSE64ozEwtcWI4QTKPt7ImlRlcpjeAGlyIZdlhhdMOUK9SOESfuB6Mi6bmVPAun8XvvZVoGn1SP2vyiJVhFpXpEj/AfdnAw1v9jWSqpKvgGx9BWqR6+DdD/QRML9bf1tDveC8s81vTdNaXaWMM65qwls9VtJHpl+BU2azbC1J/EWBMgDv8aonBAbGGxWoHfEimWuPJ+ZqEL6avA81yHUZ1d6hGPFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuppGXhMHpgqgTAX6KNarm3AN62PPnQF0Kui8PpjBec=;
 b=cmVYR9JzNLTyFdiDQBakeLfvtx2SCFgb65sXXRb+wpHtfFgM2Rz8k/0373fED3phygu2LabtVjtHzbGgxFHBB4aG1Eea9sN7ptaQ6WzBFSw7VfOC7CUDqw9QOd/h4hurV6oDQiW+BtM1Q+ME6cbN6wcRzXmFVc7C6USAFko+y1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8532.prod.exchangelabs.com (2603:10b6:a03:55d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 03:26:30 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 03:26:30 +0000
Message-ID: <28cb1f15-137e-41f9-9b7d-fa2daa70c774@amperemail.onmicrosoft.com>
Date: Tue, 22 Jul 2025 11:26:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: do not scan twice in detach_tasks()
Content-Language: en-GB
To: Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 patches@amperecomputing.com, cl@linux.com, Shubhang@os.amperecomputing.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, linux-kernel@vger.kernel.org
References: <20250721023939.19703-1-shijie@os.amperecomputing.com>
 <CAKfTPtC7+V6ubaGDPy0MW2MFG7w_yrnYCPQ-b2=3uYgeM+-+EA@mail.gmail.com>
 <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <xhsmhv7nleqfl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0026.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::7)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: b15aec61-a3f5-4878-0b7f-08ddc8cf8c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2VGek5wMWVwY1RFajl2Z2lrRTd4RUhtT1FvQXp4WFNRT0lTZSswaHF2SGVy?=
 =?utf-8?B?OXBPOFd4R0JrUXd3T1h2R3Z3UnRFbjAzNlJlRmhjaU9aNlN1Z0hIY3k5Sll6?=
 =?utf-8?B?QysrYllFaFpPVlg5eE91WU1xRjdlQWorQ2c0am9qTGVZNzhlVVNxWnNnM3NX?=
 =?utf-8?B?YzhkWXE3VmVQc29sQ25uc2FzeXU5ZFhsTllhTnVreGw3Qmgxa1U1UHVxcmpq?=
 =?utf-8?B?NE5za2lZYkp4Z0liVzJ5bXBWa3Z5djJwYTcwUElFWHlrbldpZWZ2SDFKTmp3?=
 =?utf-8?B?VlJ6VzcwaEdIVEthY1J4OThSVUZHOTBJS0NXa0Z3eEY5Q3ZoRGl0V1llZmxJ?=
 =?utf-8?B?RFJUVXp4WnFwd2pZcm1qb0NReGxIYVRzdEZQVWY1L0ZSeklod0ZFSHJJNFVt?=
 =?utf-8?B?cW1aZXhNQWZERlFzMEdpb2RUWXV2aWk1dXRDTHkrUnE3QU83WVc0ZXRkMHlF?=
 =?utf-8?B?eHNha294M0JzWlBOcm9STmxYL0pMVWxzZHdZaFNtSHBEckY1UDZFeXpZbFE3?=
 =?utf-8?B?dHM4VFJicjdJQkkweTR0cjBTYkpXRCtSVzY3TGd2R0MvbTA4aDJsTnlQUVlT?=
 =?utf-8?B?Y1ZsTWJtQmF6VHVmazN5NGFHbldla0ZweWs2OTlabWFiOFBPR2xYc2RGTUE2?=
 =?utf-8?B?ZnE0YWxKbzYxVVArbkxPUy9GdVRHcDk2djMyNU0xZzd4Yng0SDFGWlhNemdw?=
 =?utf-8?B?alozQ2xGRk5NS3lXRFhhK1c4QUFKcnBGTmZWMnNkcXVJWi9aS0gzR2JiMzBS?=
 =?utf-8?B?SUVjQktRbDZoTUVyK08zRnhBeWVJMXh1STlqZzZkUXREeFZVL1NOVHpqcndv?=
 =?utf-8?B?UDR2S21YaVdBc3UxZXNqSEtlV0N5dHc5RkcvUTNva01YMEdUUEhuak11RjNY?=
 =?utf-8?B?QVdwM0VVVGg1RzIrL2VrTW1uSTFOM0Nlby9wWUs2dkt3M3BIZkg3QVRnR295?=
 =?utf-8?B?MUJxc3VZMjcwa0plL1dDSklpSUxoMmtlU0doTjNRSjVucG9zQTIvVFhDM3BK?=
 =?utf-8?B?UXdCV3o3dEFHZ3Vvb1I5ZC9NeEhicDhobEJkVVBvMkhEeGxCeDFZWHZNT2pp?=
 =?utf-8?B?NzdhVi9Gd2RlaWFIaHkzUG1mV21GcnhlUW83a1hONTQxSE9lSGwyeUFKeUxE?=
 =?utf-8?B?V2VMZUZZUjEzQUF3dVBoMDU5OFp6b21TSGVCWjFoZ250TFJhaWw2TlFZeFY1?=
 =?utf-8?B?OUJFbkNuQWZCaE1oZ2diRW02OFJ0dTVhTER4Y0MxYktZYkx0YndTVEtiUFB3?=
 =?utf-8?B?SVFESzRwR2pCUldsRGptK3NvNTBhcStsYzBoUUROdXNUSGtYYlp0ZmFCRzFo?=
 =?utf-8?B?aWdyTk9sd3JQc0htZmdDSURFWWdSakpTR2toMTFPSTVxRVVJSndDWHpOK1o2?=
 =?utf-8?B?WGNOeEprY04wMTdPNk5EeS8xZVRpdkJmRm1SaVJmSEpiYzI5dGpReHZMcWla?=
 =?utf-8?B?M2dDdVJMaC9TWjhnMjh4R0NlLzhwWWFsVFRTVUo2NVlhVlRIaW5RYUQ0djVp?=
 =?utf-8?B?bUFpWGRDVDNLdzBXM2JGNkhnTHZuNXg5SEppcG4wdkw3T0srZXY5MERUSkdr?=
 =?utf-8?B?empENUZTSnYreGNrdm9hMVhVZFRqa05xL2RieW1KK3NHU0JwRnRJUnAwWWRv?=
 =?utf-8?B?Y2RwNitpMGZ4ZGpPTTRDQlBsemRqSVFCMGt2WDNqWG94Nk5UTzRTVFBLbVVZ?=
 =?utf-8?B?Z3Zib2NFbmtiMU5EOTJ3emtLMHdFYURUYzBia0l4MlZPR25kYkR6eTdXWnBx?=
 =?utf-8?B?UDdaenl1b1VYL280d0toQXhnRDR2Q2ZwWGxZRktJekRuTjh1S0NCTkNHNU5a?=
 =?utf-8?B?YXVHT2hVV1F3bDQ2bWdSbEo2c0tRb3V0MDJJMEx3Z3NaeWNsT3hVVThCbkNs?=
 =?utf-8?B?RjE1U2IzeTBQQU12TnBNZUVTUmYzalNRVXJtUm1jbTVpa2ZGamNOL3N1NHc1?=
 =?utf-8?Q?ulWk4+IvHb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhXMk5BaDg1RW1zTnBQOFQ3TzBTdEVkN0JiQ0czUVJkaUdtc0FaYnh0VHRn?=
 =?utf-8?B?cjArWjE1dVZBUzRGUDhhMlNNRWhleUpzc2FIRmlWWUhvSU5KRmdUdEovRU5F?=
 =?utf-8?B?Skh6enZEY0tWcnVsUmRzN1pXbDhoMDBCTUVzTTFPUjE5MHZIeGlVV1JqSzhR?=
 =?utf-8?B?YkhDb055ZEtGTW11Yys4dmtXWGFnWUI1NUhZcnQ2SldGbDg3NUM2b3h1YllB?=
 =?utf-8?B?UC9adzdDRHBRNTVSM1FHWGI4R0laQTVpZjJzSC90WXRkcG50TlJOTUxqd0hQ?=
 =?utf-8?B?c1VxWWpqNUlIZjNqakt4SURlcHhUanRjcU0rSkxwOWw4bmZWYU1uYU1IdWVm?=
 =?utf-8?B?OThJU0xncFpvL0VVaStGK3JxYmt2ei9WN05OZ05odnltRFRZZFlUMndmWVc0?=
 =?utf-8?B?VG40MGx1Qi9iY0o4WURpakNTMGNIZThrUUJ4YXBFNW9aS0thOWcxek5nWVFO?=
 =?utf-8?B?eDNNV2lNM0xaT29Wd0ZNbEg4ZVlXdDIxNk5IRVExdTdRcUxLUjJBb01yc2Jk?=
 =?utf-8?B?UWJFSDRMV0JOQ1NGQ253dTV6NnVrelBzTXd5TndzQmhreTF3K1NkdVF3OGlt?=
 =?utf-8?B?eVE1dHlITktmZ1VvM1dpdmNLN3g1dUk2U1NNTDlyWFF3NTlPUURMa1RCWjdF?=
 =?utf-8?B?TkQxc3N4c0NramwrRHdxSlJzWUxMUFo5UTh3SEljOEo1QnNlVUJaUDlUdWpY?=
 =?utf-8?B?Ri82UkM2Y3JJaHFxMXpmeHo0WGRXMkJWYVRMTml6VUNJYVhMWGljSUkwVWRG?=
 =?utf-8?B?SkFmWWJtd3hHWEc3aEZva1NCODAyQ3RweHJxS29oa0lCeFlwR1J5OVl6cEh1?=
 =?utf-8?B?MzlmdlI1R1pTNnlQdWJTdlpnYlNEVHU2RFdLVi9TbHpnVGVNbGFhSEV6WTUy?=
 =?utf-8?B?UDBzcERHOFROVjQvamJEK05UQW0xU2kvenhLNHdxSkh0eVJ6M2Z4aVg0TnVj?=
 =?utf-8?B?MVA1WllUSDBEdHdDM2xoUXlkM2pwMFZIK0pkbERvTEs2WVgyVi9ZcVFYVGpZ?=
 =?utf-8?B?Um4rQ2hQcUVXY01YRjcxRk1jT29KQ0FpQ1FENnpDRVFDOW9UU1NIall6dTNo?=
 =?utf-8?B?dVpDYnJZZm5DVC9VVHdia09sek5LVityeEZOSzZaOVFCV1dQblVsU3psMGhY?=
 =?utf-8?B?TVpwV28ySzBIaHN4WVdLNTR3djkwMXdXMHZ5b2hnSGk0WWxMOVk3N2VXTXU4?=
 =?utf-8?B?MndUOXVqamMrMlVRUjZMYXF3dVJsS3dIYWM2ZVRVOFB4cHBPc3pHc0lCMWtD?=
 =?utf-8?B?Y3BQWS9JWG5KRGhKZ3djK0xwVENsRmFNaEpEZkF0aTBxSzdWSG9SWUtoTlh0?=
 =?utf-8?B?OCtyWkRLL2JCMk5MVXNMSEZzSmMvYmFCdnB3NUVBOGNiQUNZM3ROckFLVzUx?=
 =?utf-8?B?SzRGeXVKcXk0SklWRUJCL3RaVHk3RkZOZUFpd2JGMVc4QTJKWWRvbmJoRWpx?=
 =?utf-8?B?OXhybU9zTURZNDRaUUlhaFhQbTJxTkZNdVFHMjFlMlhxQldOblhQci9Rbm5T?=
 =?utf-8?B?WnZ4NEU3M0E4QUZVd0gxWDBOaTgvNTVnQXRaS0JuRmFWd3VHWENVRWxBQlp6?=
 =?utf-8?B?V3B0NCtRT29QelI2NEpDYmUxS0hlUjI4MkpUWkNqS3RKNzBUSi8ybmJ4UWFs?=
 =?utf-8?B?Q0ZaVmx5bWhkdFhQZzFaaHVLRG5qL2c0eWttUnp3OHNHMWFGZm0wdG9BUEl4?=
 =?utf-8?B?RmtHQm1qRDJBU2p2U2dqMHdybjBGaTlibForMUJSWlNlZHBRbnp0RkpXajNB?=
 =?utf-8?B?YkIvWVV2Wm1TY0JMOWd0MzFHcXN1L1lMSlFIMncrZjdIckY5RzNjeGQ5dnd1?=
 =?utf-8?B?T2ZZSmpBcndSTnRodXc1ZWFGVVBYZVlsTVdudGpEVkF3T1ExRTlPQ240Smow?=
 =?utf-8?B?TW1FVTMwUmpodUVTZlgwMmR1dmtXSTV3RGFxSmU2M2owdUR3cytWWmdSWUJu?=
 =?utf-8?B?WDZManVMeEVEdzFSc2g4N0JvYTZ0YzU4MjMrM3ZELzZQQzc4aVhQTlF1cjdF?=
 =?utf-8?B?SWJDR1NwL1pJdmZiZTl5blFLaThzdjE2N0ZNSzE2b0RmZFE4Tnl5VGxmdzFi?=
 =?utf-8?B?MmFZZ0FuTHNQMm1oMWpyTGVNVTdHbE93U1YrUE9Zd1NBMkxINnI3THEvTExs?=
 =?utf-8?B?bjBoQkdudW9IWlRDM253MUhaaExyQkxsWUhWVzhydjluQkozYkYzcUlzZDF3?=
 =?utf-8?Q?x1ji4Mw3oW9UWLDMO23mP0g=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15aec61-a3f5-4878-0b7f-08ddc8cf8c79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:26:30.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXoUTsCt9Zp6YppPgh0Y2k8VUvO0YyVWiR3NlAkc+bkgNejAcNFpK8ydM4qwd5d8RhtKZrvql+55G1FCQhu3lAhstn+0ljmQk4HFXXWyOtKIQR3Ry0/GgwWBT6G1+KC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8532


On 2025/7/21 19:25, Valentin Schneider wrote:
> On 21/07/25 11:40, Vincent Guittot wrote:
>> On Mon, 21 Jul 2025 at 04:40, Huang Shijie
>> <shijie@os.amperecomputing.com> wrote:
>>> detach_tasks() uses struct lb_env.loop_max as an env.src_rq->cfs_tasks
>>> iteration count limit. It is however set without the source RQ lock held,
>>> and besides detach_tasks() can be re-invoked after releasing and
>>> re-acquiring the RQ lock per LBF_NEED_BREAK.
>>>
>>> This means that env.loop_max and the actual length of env.src_rq->cfs_tasks
>>> as observed within detach_tasks() can differ. This can cause some tasks to
>> why not setting env.loop_max only once rq lock is taken in this case ?
>>
>> side note : by default loop_max <= loop_break
>>
> I thought so too and dismissed that due to LBF_NEED_BREAK, but I guess we
> could still do something like:
>
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b9b4bbbf0af6f..eef3a0d341661 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11643,6 +11643,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   		.dst_grpmask    = group_balance_mask(sd->groups),
>   		.idle		= idle,
>   		.loop_break	= SCHED_NR_MIGRATE_BREAK,
> +		.loop_max       = UINT_MAX,
>   		.cpus		= cpus,
>   		.fbq_type	= all,
>   		.tasks		= LIST_HEAD_INIT(env.tasks),
> @@ -11681,18 +11682,19 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   	/* Clear this flag as soon as we find a pullable task */
>   	env.flags |= LBF_ALL_PINNED;
>   	if (busiest->nr_running > 1) {
> +more_balance:
>   		/*
>   		 * Attempt to move tasks. If sched_balance_find_src_group has found
>   		 * an imbalance but busiest->nr_running <= 1, the group is
>   		 * still unbalanced. ld_moved simply stays zero, so it is
>   		 * correctly treated as an imbalance.
>   		 */
> -		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> -
> -more_balance:
>   		rq_lock_irqsave(busiest, &rf);
>   		update_rq_clock(busiest);
>   
> +
> +		env.loop_max = min3(env.loop_max, sysctl_sched_nr_migrate, busiest->h_nr_running);

It should be busiest->nr_running? or businest->cfs.h_nr_queued?


do you mind I create a patch based on this one? or You create an 
official patch?


Thanks

Huang Shijie



