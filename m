Return-Path: <linux-kernel+bounces-802994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9BFB45940
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E31B627B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D2350847;
	Fri,  5 Sep 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oRPBp+jE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aIbo48Y5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1941D61A3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079424; cv=fail; b=TBhXWqK2sbDpuEv1eVtrLYIp/0+/VywwdNWKyVp2D4a4jw6+jcNvRPjIu/GWr0nOvm3Dsur0aufYo5piZZS3LIWctaO/whHe8SM6W+YvSoQIzROTPN4KH5ZLl9dUHqn5RpKuoIrN6HAw88UgT+JuPedU9if6yUSyP4VMN/TSCW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079424; c=relaxed/simple;
	bh=oi83Yk8TyC/1EF+r3WsUzLYLwPZU5a6WX6XJSc1tVs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n4gmOR/VXgESRgqoiGpzpJ/ts14TEoXdKErNOxNyX7q0iC5si1SbAn3P2vRhFTreRkoLLFMWE/rQjSIavVoYuEkEksTM0IRTjyJ4PU00Y1eeER94ajlFY3IT5Z1hUglZJxDaYHPO4U1MYNk4faF7yQ58ha2f8BaShQ3ZQ6Nr0ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oRPBp+jE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aIbo48Y5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585DOd5X032690;
	Fri, 5 Sep 2025 13:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=foO7Lo5ghLQ9cLpO6p
	P6csyk3ID3GJiHWGM8NZzUggc=; b=oRPBp+jEjdlomjmAvskxop2MGqt0c9+5mz
	fo7fY3Y6M/4aeKnst0IJLvNmZznqfjQSdzHj8YFE6B9zdEbQclHXnFcRkjzLNW4O
	Te4YUvkOkZcZ58yL354p1YetG8kfrL8gQ/ECCRP6xPtTPxxyjvtLSqvZoy5Lyai4
	y6swiLg+oFUEYFXcTdCYg/tMaso7hjhQGpzqnTpcqom0VsvrlV+9zW4WRezGHAf2
	UkEwBOVJi+nKVUdDR8ylNM2UGGKw3Nr1IYcH8Xjeea4biw61/AXau21X7wFDeGSc
	W9u+jQeXq0qc45g7lCDbVDS2D3JQ8FDE8UyH6CZaOTRiI5QgFBgQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4900qg00hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 13:36:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585BctdU034394;
	Fri, 5 Sep 2025 13:36:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01s623k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 13:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+0vGo9yuiR/SChxxboL7+x2nu3QoI6Koif6brN5eZBKssaW+AQ4FKF0YviyuBcpk8kY8zx1RUiorJQnLGjSQoLcZo1T66i2RKaeEW1Ok/v0ic0nxgLMfbtLx+c8dDgQPWFm+nrGIDeJQbmiAXtR0Ln1BdCdn/+ODCdFdUd6lhVLZaRQDZiseg/ODAp1WEyskscwrtLp/A49j+J8A2p7QUO6G3rCoW7JaXqn6LhT2ldKH/0Z/bTK5iEiO612zFP/uT+LMzhmdtUrTENI7aYcYBPO5+C6xlFUGdFcgnbzL3X7E9E5q+TbysnoSUKMM9lEngKT4ZQYIlX5X1s5Vuh1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foO7Lo5ghLQ9cLpO6pP6csyk3ID3GJiHWGM8NZzUggc=;
 b=fdSJTr9DiViX5rwdToN9qn/KVzNMU7u8E1PQFTN3fI5YVTgtjNqSKtZMxxusaduK4x0iNjQABuJT3n6JY8qflMWhfrVfSPJDbcaRWuNICOFkDkeGNQFmfWalLc6uEXZoevvdaqFN+C41tJjEs/GB3oYljEGJe8nOuUcxFhA2GGjN7D78QiFPgsdzJuEvVL+GAcU0irCgEvCveii9Q29j/LRqCgOFDEb9avb60a+HRy7Ck7iz6XYcMkPITW1rKfBsHTDdNvtArDRZc5JxJXXc7Z1V/M04wtOPrgczh/LA5jra97juj84238QPN1QVnvKmWloZsdAClBYp5NLxDz67RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foO7Lo5ghLQ9cLpO6pP6csyk3ID3GJiHWGM8NZzUggc=;
 b=aIbo48Y5R1IwHfryz71skFW5gMlG4pJgoTmsTLA3ZzmKrIRdumEXRvBfMJDHxnZB892x/zBAikPBuDxLxAmtqYY2/jWb97VSctHcZVxu25Wi5HVE/28+1dLtW5VSj1/+84rh5+jsnFqGjrGOIdBcoOFiOqLKe7uOp3ib9HNJOh4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 13:36:39 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 13:36:39 +0000
Date: Fri, 5 Sep 2025 09:36:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add tree entry to numa memblocks and
 emulation block
Message-ID: <4qfqhadgtv2nicckgvczcznpyxmpcmvuxdhckqlbh7bjvyvjhx@i4vsnnqz2mzw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250905091557.3529937-1-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905091557.3529937-1-rppt@kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR0101CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::18) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: b961a410-76f7-4ae8-099c-08ddec813de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qm5CG5xs74OvFKvp9gHp8MmRFUL4X+nzT4VWrnFU9dyfA+CjeXM1raIdOl+p?=
 =?us-ascii?Q?rdnF0warvxVWIdBcjyiOumhVkaoOQ4MbsfjcXbbAf8qRelPPk+kdkweN3bzi?=
 =?us-ascii?Q?pvsC9bvjM+MreVFJS1D06/UKFvXCRMX88oJToq7xhfz9mBd+Ei8UTejj0r1e?=
 =?us-ascii?Q?Q3qMzQN+br23yUofRXYYbu9JVUivDyJ68YG92Yeic53y5j5noHDKiTuW+Khe?=
 =?us-ascii?Q?sBq+LfS8ABoE+sYYyFMuayF1zHTXMJrzmzfmeT7b5sUmGvn4Hl++ScmScN2u?=
 =?us-ascii?Q?PofLfodA8YOM8Tm6D5Y9LwWqjlwqMppecHud4pNykjXLUMB1AVNyg7FckW3V?=
 =?us-ascii?Q?meCPQO4jGXXNlOW7cnoVXaiB/hGlDz2nHanJpz3o+ZsAmAOotZrQl9VquCK3?=
 =?us-ascii?Q?YjRUu1FYN7IpqZMecyNzXLCOAvtmGdQCz27n4DpeBKAHBDiaB4bjLjkOY/IM?=
 =?us-ascii?Q?aomQE1KlLwED6GrZ2ErSS8ZYKeM40RF1UHSfP1TxsAcTTs4kvi0j+D8oWUhZ?=
 =?us-ascii?Q?ggQovLtNXFQ+9bpx1Ln8m6EWctOfrTkBlyH4l/sqEhodTyuz/KGyCcswjQlr?=
 =?us-ascii?Q?a6n4Fda0TXTPtq5Lf+kqxC3Ev1HRX6XqnTxJe127bo2dRz2aXIVx3olfp37W?=
 =?us-ascii?Q?+ErnLMI9lxWAL2UzQwqKonW+jYkq0N+VMpNvK16sqFPNKyN+f01DTHDs+16F?=
 =?us-ascii?Q?G34E52/uMFbp0eLxHFiBT62jNy/pJFXzDkxRADHT+Dr+eqHerLn07zVb37HV?=
 =?us-ascii?Q?ms6RdE1V5VauRNWhmlUmLeASZkfDsxmyu6yS/t2icRlMIe7QIncanJxW83hf?=
 =?us-ascii?Q?51/fsVwaVyNkLYdNHiwvqtSccsB1FjsaMB8+Ew7gZ+shoNSVTmzCMe3jEkkA?=
 =?us-ascii?Q?WnxmZK6I8XZ0VbsST33qPtsWszh+/qnfpEZBjrQpkRk1KXsusNbtFrHhOR9i?=
 =?us-ascii?Q?2jtqTkYE4HcvaW5j6ZcdmzWGqRWWNcHs5GUJDOBYL9pEXvlwJ1IV+ygDrdry?=
 =?us-ascii?Q?iREl5SO+RNw2WLbFHP6yb5TVN2An7IjGN0ctOFyvutVtUThvzYqgGRqTnTBS?=
 =?us-ascii?Q?cyP6MQBut9fYqg1pR2NEwERQi8ciJQ6CxpvZqJMZHcLEWxYByo5/BwDgrqEP?=
 =?us-ascii?Q?/95PJpXXr+Bv8ELe5nrr6Xu8ReudgSFlYGROyJfex5g58la9z9eZEY2hgOiJ?=
 =?us-ascii?Q?+NHKsW7obbsJgzAbQBPyk5Tmbg4yeJEbR+A7YM9/qNNMeY7HD1N2eQYF/vtl?=
 =?us-ascii?Q?e0a5S13wfKyphc64UQJo03K9jjRHhugzipgrf26qlLsWqeXoufm0MheSW4QP?=
 =?us-ascii?Q?XzFDaJsriBdRsE2Hzyg9QFAoO9tk6utv5ywaECJP7O2ki8CdZjMeTG4a8WB2?=
 =?us-ascii?Q?wJ+R5M5ulDngAJEuWbOFpQmPjiH+sQMxkRbK08d7CNg7S+/b/1hql2APq83X?=
 =?us-ascii?Q?tKsEmQpeHp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FeBzkEnGhHiy+5B2yR5maT4LUfmwxF9f0ZVWnX7l/TFFIfhrr2/0QtmsIXy6?=
 =?us-ascii?Q?yErNhLHkJYmO/BkbobddriuWtYNRkB2m7mzIuBVcqqErgQqcBzuYXInZ+JT1?=
 =?us-ascii?Q?LCYnyw2NGt4XxrHRg3AK+KpT3QeiO9x7pHLmsnO2JvtCII6F1Lu+br9T0yCa?=
 =?us-ascii?Q?tFNfVk80N+NeWUok4JTPInjDJndZ4Ei/flsWz5iUrdHHOVpA3tgc89YLn74+?=
 =?us-ascii?Q?hY1GjTJVzzyxJWNJ/kVzaPSjJmnRrZYgupoYXAxhuukr6sABgmvl3o0xUAuu?=
 =?us-ascii?Q?8k0+dG12zOQx/Qp5SIkq4aLM7KZuOklYuN0j6D87qA4VHma9G3fKMO3hUyWT?=
 =?us-ascii?Q?TAGB4OgALtqy7Gj9xDYc7MLma/3iOk8LqFKbGj1AV81qIFXJx2uv1ZZRGmkW?=
 =?us-ascii?Q?hVB3gGNseleENcHEpnYXZ4Z/cNk356cPgHCxer9VDOLo7QXKWdfcEZppmElN?=
 =?us-ascii?Q?b4bToQ1XyWhW4k/vs0QpjQ4d6yti6AVo0GlOc65HUJEWDT2Wd8mhrqDvsXpZ?=
 =?us-ascii?Q?pNHdpQEFI7jk7S51NfXizjL3+dj+h6nFeHRYQ5JoXH6Eo64qZtz5dKZISVTv?=
 =?us-ascii?Q?tuZWuGq6tPapbu20pGV7D0bF4+NU12VXc+frVWB4b1KmUWsSWMGnSzWSC2J6?=
 =?us-ascii?Q?r+x40gnxsE6CNzCvjAra0Pj06gp92yml9E9Lqt42pctEWu6lR94zmgV41cqL?=
 =?us-ascii?Q?XM8AY0sYGw/4XjKEN9q2HevSeqUldn4fZYgfmijyG9TS8QQrWKtWtfeejnMB?=
 =?us-ascii?Q?Pr90yVTFvCAgkDlevSUSdLUkGo3RJ1kwPey91NsBrFzy3KaovCzpt9gMMUL9?=
 =?us-ascii?Q?KtJl7FUYEik+Iy9Y1NV4Dw+2yEK33Gwevxd8AAQyWl7GYkAiU8NEUIGTBNWu?=
 =?us-ascii?Q?0GwA7x7VCcIIYfPQwGckjxtrGlH4dRGxSmGpKAwSG4BgOv2yBFJGAEy24hAr?=
 =?us-ascii?Q?SVo21LNmi8bnAuDgS1AwRt1fIieaR54yNbFtzv/qPc6gsneH6N7qJO7gemXY?=
 =?us-ascii?Q?d3f/5Mv3umEjrFzgEa2F90Jlk2vcmdl0t/x+VU5QbgAHRcJyMPygWoUpzoGZ?=
 =?us-ascii?Q?RnE9muOxNS7FfakpiaiVnyrMnoWdjTPqkyb3qOJSmEyc6hWNIbABU2q873X3?=
 =?us-ascii?Q?sw9XB95qdeUv9Abgof5jE3KeTgYKQFx3u3ji3N6JQ8TR4LFzAoTEb1ueePor?=
 =?us-ascii?Q?F7zNHIsHHiCpZMg78IKak4RG/fxRySkLD8G3agQX4Mm65NCV+OHibd8ZsTK7?=
 =?us-ascii?Q?FdjCsZCCK6t5v/owrQw4OiNXL9kGMJg32YlpS5Qkloiw33CHjMzVo6n3+Vvl?=
 =?us-ascii?Q?YTJBO3VDDblUf+zAW2frqGguOeAONuiwKww1SVTir/U/AT3VNYzjgJwVxCx4?=
 =?us-ascii?Q?JaD3O5K0/PKoZSOKlq0lqxM8VEH4P1mI2LP7oEp02an/7lCyFKcVoOprjtBY?=
 =?us-ascii?Q?NWjFApFzi3xQZ1YquSN3Etske+9aetDIso239+4tx7taibY3owJorHne2Iil?=
 =?us-ascii?Q?EqJRbRCveXxcf/fKo2YZf0gXuOHoL/h/kBJ2zvMhci4K1/W1AK52ChtYb/sX?=
 =?us-ascii?Q?fPXlWnGO45bQDH3uKh5HFNf7db56amq509vgpWfd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YcgyaHtvHOJKJ0ENU0XluTBGZnapr9Ob8hIoMAifmLmfpOkufAdQ2Fw8Tl8SeCw7FnzDIbtPujTxLj7BbJaF61/olxyQ0z1Kc7iBKwuvtPKJsEYj1vDBFwjOhRYhLgOGrA4BZCdWHYuoqTRAyQUSWrU5NI8LZXS5ul1x7U3nzvkTh4RrZ//YThXoM6KOxWmOKXfxVOnB15tpZqR0v65atJDejRUv7BbQO3BQAQk+tS+W3o4+IJCFMBsIhWO0LtJ7jP128QcvEK6Ey3+NXtB3NpyMJA4Ndcvcj+N8xNvfYZr418XBLSSeRYv1Qb72Fz/DaLlKzGFQ8FObSEjrQLYwmvAQIe+FF88o9rcT6pF338OJfdLF3YI3FtvJhBwik0kDhd6Z0oD2o5OmLogrI5cd0fUlzEMc6GviSEpJRZW89yAzx1Vl729aY2/Z4FqyPxuizvsNRhue1YD11tOPc11Wy5b3qKblzaWXqmuANYl3d3XfoxklZMssQs47Czz6tNUIWt6pt7N3L2PLbiJqGSh2xDLvfuHqY6U9Vgf7GTMn97JmKMTcjcrojfVYGEOfOv2ouDv/94vaTiF6A4RHAyKdTlLy909/9kSVNX92vUV4zJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b961a410-76f7-4ae8-099c-08ddec813de9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 13:36:39.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tGk1iwGngIrIzm67oSFKFGNHtYi2mwFjTAkzorJca0ooqIW6vMtQM9AA18KrvD5ojt73YRFUiYKT6SIVvXhBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509050133
X-Proofpoint-GUID: K2OPkoOcFfHeb3X00Qo4xz3C4yoccHbO
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=68bae76b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Z4Rwk6OoAAAA:8 a=37rDS-QxAAAA:8 a=p8UZCAe8x6Skcr_MNx8A:9 a=CjuIK1q_8ugA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-ORIG-GUID: K2OPkoOcFfHeb3X00Qo4xz3C4yoccHbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEzMCBTYWx0ZWRfX5ssW8QwdfK/3
 GYUq9uMvp+imP5vekApKzrTxJIo/Q843/7YZuKgoJ/dbJBAWVRcicfgIf8ptmAEhC8akVWiP7gb
 6eHRJdOG5lxILI3LWkwBZ/NLRlqy+VpZvO97SwMQ4xAf/r12yfCTeAguLnSmbudbWpU1dczlzNe
 Y9ZJdWeqQAZD1UYp2OMD0/J2EGCbFLDCWJwKQwbztl8S6EL6tu193tLgZ5TycEMl87DhiEAHz7h
 t7D3WRcyJJA610EGv6m+A7CLqs+io4ZgUBgNXLTpawkm7PSeFq92RLp/46ofVIUlXegtGVn74eY
 q5daq7FzVEKP1yxY+qyrGNCAFfXadK79h6S7rBR5K8CjwaWbNrhsSDBtSXxtwzFMyJKrpfxnFp/
 4qIq/GJm

* Mike Rapoport <rppt@kernel.org> [250905 05:16]:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef..fbdbf7c012a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16127,6 +16127,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Mike Rapoport <rppt@kernel.org>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git
>  F:	include/linux/numa_memblks.h
>  F:	mm/numa.c
>  F:	mm/numa_emulation.c
> -- 
> 2.50.1
> 

