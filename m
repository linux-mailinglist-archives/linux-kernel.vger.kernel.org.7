Return-Path: <linux-kernel+bounces-750441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE55BB15B60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEB53A9BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02326D4D9;
	Wed, 30 Jul 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTPUuRrr"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E0635
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867316; cv=fail; b=UtOH8SWL8QoifJkhNE4PUu6pTafnOCcMZ/XB00s+TTjK4Ul3OllEE2eGXdcOxvY2/gPB1swb84S/Hqi7DpohGewUGLdhAuDnfzm+Ea78KdKCnXjkMKlpPI0AMB8N/IDYT9NrD/5YicR9OdOvL5O67Tuw1Cb0L+R8GZuIehHqD00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867316; c=relaxed/simple;
	bh=QdqN52Cn80jwXTSvTUWmRgo7QegYLc1Ass0cyNmQZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uASFzuQWLNWHuH8EHFQmPT21Od16cx8J9YwgvPp/cI+wvmLd9Xc272lsDsMRUDzzmrl2ks5nms0lUrqGO2Ab+KbeIOcXp0z36o8pD8KTIzz+0rDLT9ln396q6Q4kWOtRnElGhKCed3sD8n79R8jZFLe9WqYhiZx56S2+Zg+g85c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTPUuRrr; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzdGQpE/EVjhmNryj3zkJIJssVdrxehshG5ZxCnvAckD9rikMBV9Taf9lOjSswYlbrbbfTYjwFyMCVKIT/sH96M+e2U6c2b6BCLhtJqBFj+qef17ML0uo/NMYl0bGouutnaEMytADmCp3DrkuLPqwMyv3WeWLt0Q+mCuycoLB41clAORk8+DBm6IqlDByDwovFuiuZa2zI6WywVe2LSIiuhEdVPGhCggNIz+mrx9SxBZcbPowtv8U5WwDrk9EdEfqIuIp2JBqsbu890VpHSP3xxjeNHQVp51AtFaW3rtl/tJmgGpCodW4TdHf40goMnwWLYXJlZmbuDqLGzAd50Kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZe2s+BE7fb6IUv8aPXcJaZmn4Agthhqx8lwWs9RTA8=;
 b=cgFgI8yWNyasLDniwYxZktYCrSj7Nv57EOxQ5zZ1wcmgQtOET5CCUA3iUcp8+nTmvy/uFW1ZHbrSABnYGuYxWDrAGagikvMBAv98fVx18AlixgzPEpodfTzv8RNYMCPSvS4bxWkVIHS77S1zTDQXJu/yU1gbPioNC17kQk0wzKAYlDiAq5auABwXHQV2xuhAxkkR2oQU9ns6WySHuayD3dxTFL98dotjbqN9e1e6p7bi6hZP/wA+KGeL6bYPxVArOrRoTMO7HXrdx5Jt0y+pOFHhpyX91uNKSqz3pN+UBpgd/+Ky3CKqNbzuCUwt0XqTY0/qZKY1YSo1aUOHXOlO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZe2s+BE7fb6IUv8aPXcJaZmn4Agthhqx8lwWs9RTA8=;
 b=RTPUuRrriyk8UMpuz/OHMlDltT61vsyOdKpD1TaF6eobFOFuDz8PTYL4nV4LQlDHWfB9k2vEphiBWVhPDN7QhZo96b6ktcqTksJqjUdepiDCFzHqIPqRp0YHEUpbhZrOV4igZkMWrcKGpTD65Z5HtY0r9qG/RNXniAG1iSz+GZnt4Zme2Nh5czzIch3J4v3mopwHt2xDxqYeYpF+bqqxaDAi7Yl5LPLhqgOl0qK+kuorJ3Z04JdHr/ygPPTZkvqGcORrsU0SPyZomOGATrj1vnogXhnWfqZ+6js7UcRf6efLB9Lh8hEeT4dXzXkzZ/1NaxeGD2AhWmsPlpGlPxSbvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:21:50 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 09:21:50 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [v2 00/11] THP support for zone device page migration
Date: Wed, 30 Jul 2025 19:21:28 +1000
Message-ID: <20250730092139.3890844-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5PR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::8) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7b6b26-2d7e-4377-8c2f-08ddcf4a83a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0pKUm9RT0VlbWNFaVVJZHprRzQzMzBXaGc4dUE2bjd4TUMwaWhMREkrdnFp?=
 =?utf-8?B?aTBIdzZ1ZmY5RGlsY0NkOWc4ZCs0WjVnT0FFdVRISGRxY0o0bXVTV0pGNVJT?=
 =?utf-8?B?WHFUV3FpN2hLNFBEeHNtalFqNndpelJ0VHJzMTE0QWQ5eXorRU45RURJcWc4?=
 =?utf-8?B?c0lQVFBSN1djRVAzLys3SzB5TFZFM2lCV3ZRTTQvd0RaSkh1UzVQdkR3dzBy?=
 =?utf-8?B?K09DRHN4bEtUelByTEpKUUFLdmJTSUN4bTRqM1o2ZVRhc1I3d3MxN0cxMGk1?=
 =?utf-8?B?Z2RlMGdhM3hXaEQvZGU2WEpmNUxFLzBJVHBueEVwbkJtSHBsV2x5c29GZ1FD?=
 =?utf-8?B?UXdUTWVHZTVRbFMwWkNITlRSZTJMbTJFeGFpRURnNlE2OTZncllDdmxqUWF6?=
 =?utf-8?B?ejZQcTAvcWE2T05VRVF0czNSYVRGWFhoZzdmaUZDZVprazg3d0JDK2lVeERw?=
 =?utf-8?B?VVVrMWlEbjJmUnRiakJiZCs1RnFYaU15T3MyNGRnOExhUEQyZG0zRmdZT2RF?=
 =?utf-8?B?Y0RaV0FJNjhVYzlxbzJ2ak1GNVNsZm44YjBBTGdXYytSTFZHQW15UFhQb0hk?=
 =?utf-8?B?REVNck1pZFhPSkFnQkxIVE1PMWpVazVhRkxickZrN0gzdEtiRmc2c3Y0Yjc3?=
 =?utf-8?B?MDNQZVZqNk15LzNUZXE0bUo5UU9NZ0ZacVA2RVpXcitLVGNyRjJ0TmNVWjJo?=
 =?utf-8?B?Tmcvb1QzMXpnSWhNSlBjYU5lNlhHVUpSamEvWWhkZWxLdC8rYWNmUGxTWkZX?=
 =?utf-8?B?RW9lNmEvM3Nzb0pJdXZnU1VKcGVGZkxUd1dKZWRwUnBkQmp3bzF0anhFU0Fr?=
 =?utf-8?B?c3Y0c3VjTW1TM09BOHJ4NitBVkpsK2V0R0NNVlUvbU9VVnoxQWUxSnBZbU1N?=
 =?utf-8?B?Z1JYU0lMdlJWVEI3bWFhUXNPM0FFaTVaM3gvaVprTUFoL25KMitVeTNITEpT?=
 =?utf-8?B?cVZ2K2FJV0d5NEF3UXpxODFiTzZLQnpxNVdxVjZJZUlCbEhKa0FJYkJwM0w3?=
 =?utf-8?B?Mi9IU2JWN2FsMWR0SElSeG5TczBtYzJ3dzE5S1Vvc21sUmc4ZmhVZjdmV1Ey?=
 =?utf-8?B?WUFpRHA0RDNvcHpRMVArdnl1TzJ4S09ubGRVVG9JcXdQUXRWNzlZZXg1ZExm?=
 =?utf-8?B?TVBqL1NyL1BWYnVudnFXcHdiSHUwbVZ2YlZxWXhGOGM4NHRzMFAzaTc1d3l3?=
 =?utf-8?B?UERWbEJQb0JTOWIyaXhjY1JQQjhjQ1F1SjZENkF0bmtEVzFzSnVWcmdIWnk1?=
 =?utf-8?B?UWVVWWdya2VYYXg0T3FoVGFHVGZYaFVRazExZG0xMmFOeG04MVpBTDlqQzJy?=
 =?utf-8?B?N0dodGNETUp0RTg0UnN3Q0txZHdlZng0VGNPeUYwcUtFZVIvUnhIejVhTUts?=
 =?utf-8?B?akVoM2lOZEt3cERvY0poMXljT2JnWGcyUDlLMW9FWnZhWjA5Tk1HaEZpVzky?=
 =?utf-8?B?c1c2ck9QVk15R1lWVlUrRWxSeFppMFkxdVBDZmpFb0xadkw1b2xEdHl2TVRZ?=
 =?utf-8?B?bklBVHRmdkg5M2dIRGpCNm03cUtlV2cySUhjcVh4QmtpNldWenJ5RmkwVWRh?=
 =?utf-8?B?aGtqbEVOeHpmTjlPNzZUeVVsTzVpZjBQUFIzb1RZT1BTbUJKc1g2M0dqczdH?=
 =?utf-8?B?MFdTbjJ5ODlWeWlVR3dRODJuWmtyaHpTclZJcUtLZ0orVzdPdUplckJGbmF4?=
 =?utf-8?B?NFZRUHVHMmExMUxzQldEaUNIOGdZT0djMFZhcW5DYnNwbVpWdjErcUhrQTFh?=
 =?utf-8?B?ZE85M0wwMklLQ0owTUNrL3c0MHZ2MU9vblBRd1gxcjdFQkpUWlhBR2VrZ3pq?=
 =?utf-8?B?R216d3ZBY2Q1VzhzdEJMWDY5YitCWWdwWEJIcUg1dGsxR1RNUTVPVlNOSDF6?=
 =?utf-8?B?YlozblovQk1yMFFyeHhodGNSVG5KUzlOUUtNb2pnTlM0VnowcUJYdDMzWlZk?=
 =?utf-8?Q?BTPfa7HIzzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJNVHNrM2xlMDMzdDJ2alZaSDBkMm94b3pPTUYreFlCMXc2ZWFDemFkZHYv?=
 =?utf-8?B?cEc1QWJvNm14U1hHMnkwNHpIS0lhZGhjeGJnQlYyelUxWEpBaXczaHpHYmVv?=
 =?utf-8?B?NG1pN0hFOWl0S2JRVHIzUjU3d2QrMFlYazdMTktaaGJOM1BMNmk2VjNrOEpM?=
 =?utf-8?B?cUlPMUMydWdaOFdadTRiYSs1SmVweGhiRGtmSnJZTmdDbkxFbkhqMjFnQTRK?=
 =?utf-8?B?ZGs0MUdHdXl1eUd6VEJDOHZ0anphc01Sb1gza29vUXVEK2ZMMWNDK1FKeHUw?=
 =?utf-8?B?NG1oVy9IUGxrandEdUJLY01tRTUrN1dLNk9ualkvWENFRURuR1BwU1AwUlVz?=
 =?utf-8?B?Qm1EUEM1T0V5WjYxTmp6KzVOeHpuU0FaK0hxcnFsSU9HM0hnSExkanBFMzJ2?=
 =?utf-8?B?bjBVNjRKbEVXeU5YZzluYTk1YmJjOE1UL2d0azR1dW5MS1BjZnoxak5EV2hX?=
 =?utf-8?B?eGxJK1pWc053N01iSS9QMHd2aExUbWV2RmpPZi9YSXJwdkh1UEFsQ1IxOFlX?=
 =?utf-8?B?QXpwYVJTNzhXMEZJN2ZsMlFGUFJYMkk0d1E5RHFXNC9ST1QzOXNROTBmVHY0?=
 =?utf-8?B?MHN4cC9QVy9FS0RSbVFucTNxWWE1ZVhBck9Idjd3OGo5Szdvek83K0xCa2tx?=
 =?utf-8?B?THRhdzErZVpoRFh5MDR2ZVFsVENlcTB1QzUvM3VjZG1QamplWUY4cmdUc1NK?=
 =?utf-8?B?bHRkK2xCNW95SUFiYmtNSWZMdEtyUHZnUEU5RENQZHZVZTVXckQwcm9DNEdP?=
 =?utf-8?B?ek53eWZmMkRvWmtEZ3NCaUg1SFgwek51NlFZNWF5blhNKzFGTWdWVldFRmRh?=
 =?utf-8?B?NjREaGFUekRHRDZOVmxHZjFoSS8wQlJoaGI2SDd2d1RIM0VDeXJuVTZNVlND?=
 =?utf-8?B?OTY1YTJiWVNsS0pmYjBRa0VlRnZZMjN3Q1ZVOGxscUZ2c1VzTFJzNk9sVkVt?=
 =?utf-8?B?cm9xbHUwSzBmYVlYWHg3NzV2b3k1RXVlemRTL3hEbnNDamtLYm9VVm1xYjNL?=
 =?utf-8?B?YjBYS01odmZZeGE0ald6YVRFOFZhZ0p5YzBXV2d6elpXakJQYVJ0Zng5S2FV?=
 =?utf-8?B?ZEpJYVJDVXovbEtoVzFBbzIwZnNnWjRkSjhQSXVSajdhaS9tOXdSRW5ZSnFv?=
 =?utf-8?B?em5PR2pGcTJkaTJDeHlKaHhicGNuL0NweWc2akJnU0ZiOXlFa0NIcjZ5Smxr?=
 =?utf-8?B?MDRqSVlNWWNuTGI0bXNwQ3ZPSys0YzNUMDFwSmJlaTI2VEt3b2dVNWJNSnI1?=
 =?utf-8?B?OTRkdDhQUWpkdE9lVnNKOGlzcHlJOHpIOVpHNi9ZeER0enpNWVdmWHIzRSti?=
 =?utf-8?B?VHdIMnFNdjBZSTZwRVhPTVlmVnhlMUJCKzNHV20rWlFyUTdKUHEzQlhPZzdN?=
 =?utf-8?B?am1SSEFocExGQkcxeUtlZXd2Zmk1d1NXc2RrSkFMNkUxaCs3QTFDblFZQXZO?=
 =?utf-8?B?NmduNENMWDd0ek1KQnJjMnZ5SkljcmJYRm9xdUNWc3NjODQrWEQxTUlrdUMy?=
 =?utf-8?B?RDlkTHVrZEVNNWVhOG1OVzBRZGg4NkU0aEVWRDdxcGp0eUQwd0JQUHJ4UWpO?=
 =?utf-8?B?dS9MQ1lvM0twek1qTTgvN1cxQ20wZ2M1Mjl5a3JQeHpWUmNFM3hkdGZkN0Y0?=
 =?utf-8?B?eHB2ODFpZ3ZPcXVTQlQ4cnR2ZkF2cGxjcnU4d1pCQkxJU0x2OVhXMGJTYTZO?=
 =?utf-8?B?cmtwMENLYjcwamFrbDNQVWRsY3cyRUh1b0pZYmE1ekg2dmlYRVdGQjRxYjVB?=
 =?utf-8?B?cnBOdzFhR2RJWWpoVVRpRVMrbEVxdk5RZ2ROZlFybzRRZ2gvNlJ0Vmd3ajAz?=
 =?utf-8?B?ZGlHd3B3d0FLYmZPU0ZJU1kwQmJhNUkzSWZQMC9OVFgzTHZ6QmxDbGxLMXJS?=
 =?utf-8?B?Q0lGOGlIL296Rnh4WGgrQktoMkRqMzJEeVYxdzR2dXpYRjNpaFFUTjVwcWo5?=
 =?utf-8?B?Zkh5elM3Tzh5Vkx4NFBpU3Q0Vnh4aFB3Z3lrUFBYNy90ZVhMWnQ4YmdEc0ZI?=
 =?utf-8?B?ZDh3UFJscDBGdjIzdmxCTkZLWkJEdTVYT2NJVWtmTytBWHFlMWpLWFpVK2JH?=
 =?utf-8?B?STAzeVNBSWN3TkpNdko3anhZTU0vc3ZObU85NUptOWhncUZSNXJ3NmpTYnl6?=
 =?utf-8?Q?u3YwIlA6Q4dbnjdpd+VWOkC37?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7b6b26-2d7e-4377-8c2f-08ddcf4a83a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:21:50.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbgG7QDROehWZbIBmWQ49SRMNDtPgbVjkzyVaDhkgjYrrf2ZscQudiwgBufqWfwmyiel5szXgAywbD3AhMjfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

This patch series adds support for THP migration of zone device pages.
To do so, the patches implement support for folio zone device pages
by adding support for setting up larger order pages. Larger order
pages provide a speedup in throughput and latency.

In my local testing (using lib/test_hmm) and a throughput test, the
series shows a 350% improvement in data transfer throughput and a
500% improvement in latency

These patches build on the earlier posts by Ralph Campbell [1]

Two new flags are added in vma_migration to select and mark compound pages.
migrate_vma_setup(), migrate_vma_pages() and migrate_vma_finalize()
support migration of these pages when MIGRATE_VMA_SELECT_COMPOUND
is passed in as arguments.

The series also adds zone device awareness to (m)THP pages along
with fault handling of large zone device private pages. page vma walk
and the rmap code is also zone device aware. Support has also been
added for folios that might need to be split in the middle
of migration (when the src and dst do not agree on
MIGRATE_PFN_COMPOUND), that occurs when src side of the migration can
migrate large pages, but the destination has not been able to allocate
large pages. The code supported and used folio_split() when migrating
THP pages, this is used when MIGRATE_VMA_SELECT_COMPOUND is not passed
as an argument to migrate_vma_setup().

The test infrastructure lib/test_hmm.c has been enhanced to support THP
migration. A new ioctl to emulate failure of large page allocations has
been added to test the folio split code path. hmm-tests.c has new test
cases for huge page migration and to test the folio split path. A new
throughput test has been added as well.

The nouveau dmem code has been enhanced to use the new THP migration
capability.

mTHP support:

The patches hard code, HPAGE_PMD_NR in a few places, but the code has
been kept generic to support various order sizes. With additional
refactoring of the code support of different order sizes should be
possible.

The future plan is to post enhancements to support mTHP with a rough
design as follows:

1. Add the notion of allowable thp orders to the HMM based test driver
2. For non PMD based THP paths in migrate_device.c, check to see if
   a suitable order is found and supported by the driver
3. Iterate across orders to check the highest supported order for migration
4. Migrate and finalize

The mTHP patches can be built on top of this series, the key design
elements that need to be worked out are infrastructure and driver support
for multiple ordered pages and their migration.

HMM support for large folios:

Francois Dugast posted patches support for HMM handling [4], the proposed
changes can build on top of this series to provide support for HMM fault
handling.

References:
[1] https://lore.kernel.org/linux-mm/20201106005147.20113-1-rcampbell@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20250306044239.3874247-3-balbirs@nvidia.com/T/
[3] https://lore.kernel.org/lkml/20250703233511.2028395-1-balbirs@nvidia.com/
[4] https://lore.kernel.org/lkml/20250722193445.1588348-1-francois.dugast@intel.com/

These patches are built on top of mm/mm-stable

Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>

Changelog v2 [3] :
- Several review comments from David Hildenbrand were addressed, Mika,
  Zi, Matthew also provided helpful review comments
  - In paths where it makes sense a new helper
    is_pmd_device_private_entry() is used
  - anon_exclusive handling of zone device private pages in
    split_huge_pmd_locked() has been fixed
  - Patches that introduced helpers have been folded into where they
    are used
- Zone device handling in mm/huge_memory.c has benefited from the code
  and testing of Matthew Brost, he helped find bugs related to
  copy_huge_pmd() and partial unmapping of folios.
- Zone device THP PMD support via page_vma_mapped_walk() is restricted
  to try_to_migrate_one()
- There is a new dedicated helper to split large zone device folios

Changelog v1 [2]:
- Support for handling fault_folio and using trylock in the fault path
- A new test case has been added to measure the throughput improvement
- General refactoring of code to keep up with the changes in mm
- New split folio callback when the entire split is complete/done. The
  callback is used to know when the head order needs to be reset.

Testing:
- Testing was done with ZONE_DEVICE private pages on an x86 VM

Balbir Singh (11):
  mm/zone_device: support large zone device private folios
  mm/thp: zone_device awareness in THP handling code
  mm/migrate_device: THP migration of zone device pages
  mm/memory/fault: add support for zone device THP fault handling
  lib/test_hmm: test cases and support for zone device private THP
  mm/memremap: add folio_split support
  mm/thp: add split during migration support
  lib/test_hmm: add test case for split pages
  selftests/mm/hmm-tests: new tests for zone device THP migration
  gpu/drm/nouveau: add THP migration support
  selftests/mm/hmm-tests: new throughput tests including THP

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 246 +++++++---
 drivers/gpu/drm/nouveau/nouveau_svm.c  |   6 +-
 drivers/gpu/drm/nouveau/nouveau_svm.h  |   3 +-
 include/linux/huge_mm.h                |  19 +-
 include/linux/memremap.h               |  51 ++-
 include/linux/migrate.h                |   2 +
 include/linux/mm.h                     |   1 +
 include/linux/rmap.h                   |   2 +
 include/linux/swapops.h                |  17 +
 lib/test_hmm.c                         | 432 ++++++++++++++----
 lib/test_hmm_uapi.h                    |   3 +
 mm/huge_memory.c                       | 358 ++++++++++++---
 mm/memory.c                            |   6 +-
 mm/memremap.c                          |  48 +-
 mm/migrate_device.c                    | 517 ++++++++++++++++++---
 mm/page_vma_mapped.c                   |  13 +-
 mm/pgtable-generic.c                   |   6 +
 mm/rmap.c                              |  22 +-
 tools/testing/selftests/mm/hmm-tests.c | 607 ++++++++++++++++++++++++-
 19 files changed, 2040 insertions(+), 319 deletions(-)

-- 
2.50.1


