Return-Path: <linux-kernel+bounces-783082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A256B32928
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AC75C5726
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B41CAA7D;
	Sat, 23 Aug 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZsIL0yf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF91C8630;
	Sat, 23 Aug 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755959386; cv=fail; b=NDYqmuyW3F2LcHrB+t8xG4L1JpPoH/OhGYtAQFvQTnAsk1BNLzjm3B32SAACJBbrokPsdgv/lPyQC6HChTLqTYAm/vC5XbqhIpG+nJtaP+bIKwA61FGCXodjDnjgIeZsljbPPEWZWyKV0qw0hJ1nY51pyx2HChUl8hxvxL8xqS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755959386; c=relaxed/simple;
	bh=uJN1/V6iWpxiVaGFmAEggBSJjVYdmjgnnKse7JlDCBk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Ig65KdfGex/e576ZDuRvhXm8BdGyV9zohesb2+2tIHazEuXghCAxZfEFk4ZYT3V9WyGpV9i2qTCCPI2OBUAOShCOV7cWz+Slhlh8eLC4jcKNICvr+XOSuK9IFdhhbHJsnPriPpPu9SVT4yqMrZBAtzxesSZY9cvUf7Bj504Unws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZsIL0yf; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOvr4RPP/p7yr15v6rCOvmjNeHn4v3qCa1s8ULAeu3z1NjZTdg5XZt+jQnGYT4gl5WsMfXRmYuF/7Yal35EeWv0DAwsKLkdtCoOE6aSfOulIUuLTFZrzPO84LGjV+1zCEGa7xXDgX25TjxgqEKb3huizVnpcyF+aDzcOtChC8sGFj3PayoiIHGs7xhvRZQN/gIh+8lQym5ReRcb9uceS3C5xz1N/Mizfm/FqJlxao0eM7kE1vc96hBd50MOHjXACJcsedHBLAjRQSDtv0bWe4SH/86xOKPqOUxj64geb+h3mnpDua2/g8jGrYLkYecwN7t2mcABQmDRAOHlesHtXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJN1/V6iWpxiVaGFmAEggBSJjVYdmjgnnKse7JlDCBk=;
 b=GQILVr9fWSFVdNNJFP0iwCnlfDGAGFqNvMlfuBgHQU5dC0RyV/ExNytV2npLTVHfdv7czpKN0mi/VHsE0FS2aRkqb5FFhk/BJt+lINF7MWpuvjvTaOJHlgG9SKkM5HAzPl01XzkG3v7MVpfyG7RaThGraum2sfFQ5Fxzs4YSxNGjToC/oFonk4yqexr3h8++gfmJ/gqOSv59i19gKC/+GkAmQyVExJHxFqQq5Y/JMpr4CY+BWB1TPRO+YYCQ4O6qXmnyLgN+olRBZ+4QL8AhGyG2inxrnYtOy/svDmHj4QQpmHcKzJmaMT4ij+K3LD5RLDlnX1harmAE6evnf1/x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJN1/V6iWpxiVaGFmAEggBSJjVYdmjgnnKse7JlDCBk=;
 b=CZsIL0yf0f8FJoabWUqzI0HVkaIQ5TvF3F5fZpMOfiia7O2QyYjmY73i2vgJHHev0YjJSnDf3t7oNoUz6cx+RmFhpxIqhXUov9XYyQ3WCy/a5ITkl+GQbR66NIw73PZcIzKpddZOaHoLcB8FvIdCnDR5vD05y5u6tokWT/2Lx9FqaMmzNzvTelzRO92dJYKzQ4ChEYfqUG44RvkuWucmgv3wq/2nDnAucevhOdv1uMoQ5ry2Xz313J2aVvjneyaMNutrrA6+k1EpHJGjuV6+gHVcDAZh7jYfTZhMMUg3V0j+4SAE/yFI4st2E2QCd8Hzcwozi/1jbjTNreMQUz7AJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 23 Aug
 2025 14:29:41 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 14:29:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 23:29:37 +0900
Message-Id: <DC9VNDN0HLMX.PRFLKH5J3SCU@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org>
 <DC9UR87GP16E.2K9E9SSTHEBRB@nvidia.com>
 <DC9UYN56HBRZ.XRDXQHO2QQQ1@kernel.org>
 <DC9VD4LXAK9R.1RIJYWF1MFCMS@nvidia.com>
 <DC9VG96PR778.4L9WNCE521AV@kernel.org>
In-Reply-To: <DC9VG96PR778.4L9WNCE521AV@kernel.org>
X-ClientProxiedBy: TYCPR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e7257c-4537-4c89-53a7-08dde2517f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGZpcFRkUnMzcG1mWDI4NWdDS1d5TG5JditBKytMQXBJKzFYL2VzeUdXNTZG?=
 =?utf-8?B?aW45ejFBVUljVDNkb2lVbEpNZmxqU1dPUU9CYW1WcnZLS2E3RGgxVE5wSzBF?=
 =?utf-8?B?OVE3ZGNMaXR1SCtFdStNZGprcmV2MnE4NzVtZVhxY2ZGTUlETTlrTWhNcE1u?=
 =?utf-8?B?ZmdWajdtc1U3bStGdERkSjYyUEQwSW1pMGkxNElxUG9XSE16QjNVK0VqOWpm?=
 =?utf-8?B?L2w5YkcvR1g2TTlMWWptRUFBOHlDZExMWmxDWS9JMEhNSkEycGlFWkdFVHNE?=
 =?utf-8?B?RFJxTzBuaTl4eFZQVkdvQ1QzQll0N0NQMExsVU9tNDJrbGdMUDhBYmJmVlA3?=
 =?utf-8?B?WGdqK3djcy82TFRWNzM3K0ZYR1lJbDVxNGxTTVpqMU5LSWV0YjM2SGVjRGRB?=
 =?utf-8?B?WjM2VldRVnVrOHZFRk9hSWt3RnFVR0ZSVGlxZUlTcWNZM0lNN2hONS8wL0Zi?=
 =?utf-8?B?VUZLZUdDQW81enljTGNHc1dscG1CUURua3ZmWWE1bzQ5Mk56RUdSN3BUNjly?=
 =?utf-8?B?NjR6bDB2dEVkaXNiS0hrQ3oxdUh1ZXJxK2JuOEYyMm9JUDdXbDRIL05oZTMw?=
 =?utf-8?B?aXdiUUlESWNpV2lBWFJFMTVoYkFhVUpNaklGRVJ4MjRHK0VqV2F6WVZvbGV1?=
 =?utf-8?B?RFJQOHg3amZlNGpFUDN3b1RFdEZHYlRUdjJDZWUyaVVYS1Rjdjk4Vjl2MzVO?=
 =?utf-8?B?VDIzZ2NoQnFqVnF4SFRjWmZFN2RJV3JJTVRROUtqTnRXQU5nclZrMEUzZFF0?=
 =?utf-8?B?aVdVL3lSVVVDYWRkUWE3U2VudHRGaW80VWpSdkQ4Z2EvcnlPZ0I1WGtCWXVQ?=
 =?utf-8?B?YlhXZDljTlRMbnc5WFJjZUZLcmluSGd3RVlEUzkwN1NXUy9vdmczOXBBdjRY?=
 =?utf-8?B?YWl4KzZYMWY4ZUJubE9oWEhEVlRrNk9GUkdzanZMT2hLVU5WUXNOQjYvUVM3?=
 =?utf-8?B?L0l2eVhMbHU5bHJTaW9hZU5ObGF6bytXUWZaMjJnTUVRVnkwcVFFNEswdXBD?=
 =?utf-8?B?K3RpUHVFUmRQcUNJTFFFV25JN3Uvc2tjTG5oZWxhSk5sbUxoTFJxZEVyWlAv?=
 =?utf-8?B?bXJNMlJKeHlKMFhBdVJ0SlhLQlJXQ0lSN0ZHdnF4b0l4N1RYeCt6QUtzMWhQ?=
 =?utf-8?B?QWhTRDdvLzQzeFlhRWJOQU0yVnFXOGFQNkZYTktIU1M1eDg0dHlTejZVNE02?=
 =?utf-8?B?My9CRU9leS9oMThyRlFUalc4bVpKRFlwNEl6d3M0clVCZnQvV3BxTTI2eWcv?=
 =?utf-8?B?S1I5VmVsMVlmb0hSbHBBdEVaUzlLbTk4b2FhRjFRK2NORkJGSTkyaXFZN2lq?=
 =?utf-8?B?NE82aUpxWFVQYmRyM3ozS0pGNVBnTmF6bGRsbnNvbnhFaWplUUlyTU1sdkxB?=
 =?utf-8?B?bXF2UEx2Vk56Qis5QUtHQk9OU0EwTTBjbjIvMEZaL3h6Mmx5V0VmV2svS1kw?=
 =?utf-8?B?ZnFESUFESUxtQTA2M2NjV0V2R0hMN3lacmZyNjgzdytCTnBQM3ZsMCtvN2p6?=
 =?utf-8?B?cld3aUd0Um1uZ1lZckZyWUJNWnFVdkUvMHF4amNxNXIrU2ltZGtmOTFSQ20w?=
 =?utf-8?B?YVdVNE9jMXBhQ1FGc0JhT0xrRkIzUTd1RVNNVis5a29oRm9JU0VvdEtKamdT?=
 =?utf-8?B?RERhTTA2Ly9VaG5LZ20rN3pObjV6V3doWW9SUG9ZUlJEYndKaFkyWVhHWVN2?=
 =?utf-8?B?ZWt1dExldFdWc0VRODBIN1Y4ZU1uSzFCakxHZVdmRjdWZkEyOHdOMWpNSlV2?=
 =?utf-8?B?Qzl3ZzZlakQzbytxMytkTFMvSEpyeDNLMGpESG8xK1RYTzVEVW5LN3dOVnlI?=
 =?utf-8?B?OGZDV3g1Vmx6cU9GM2l2VkFqSVNFcWxydTdsbmMvRk9HeHZrWXhEemtpdUh5?=
 =?utf-8?B?S01yeTBIVGdPOTZxSW5peE5FNmdqaTNnS1R1bmN3NjhKbkN1MnZFNW9MVjEv?=
 =?utf-8?Q?NjrZx247b20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWEvcFowZWpUdG1pUlNVR1JyblF6eWtlVUxpbU55UTQxQ3NLbGQwRHJLdFQz?=
 =?utf-8?B?RUNlYVFFWnFtMjFlMjZ4WkdZVEJ2Nnh0VmQ2RkFuRWMwVUV3cG5TdEFRQXdT?=
 =?utf-8?B?YlVrZWYxamloZlhWaG45OHdNVTZtQlhsQVVzZnU5S1RnS1VGZFFaWXJWZFVu?=
 =?utf-8?B?WHVBYlRnU3FsNjlEdnFPZFhQUmE2UEdVRUlJY3NseTY2SDM3ZHZDTkROSWkw?=
 =?utf-8?B?R2k0eG1BUDJLUVZWYnppaVdTbHJGZHUwT25hNy9UcHovN0l5ZWxjd1djR3N2?=
 =?utf-8?B?Y1padWZjUkYzQWYzSjhFRnZxTUprM1dPTjhxN3dvelJhRkpXejZZMUhoMkR4?=
 =?utf-8?B?Y0FTN2xEM0dOQWQ1YWVqdEUzais4eEcvcTBOU0lmTHVlN0dFVWxTYmZZK3hK?=
 =?utf-8?B?VjkwRnltQWR5YUpTcnE1d0szZjdldmJlY0gzc0IwaVN4b0tYMjNnY1RCNFJi?=
 =?utf-8?B?MTFLeVlJLy9yZ0hxa00ydDZqY1QySXZrRWRpQlR3cGQwSnorbko5YjJvRkZP?=
 =?utf-8?B?aktSVkFQU0pTV1BPdWlUcmFUWDlpTzNvc2I3Nys1bXk4d2VIU2d2TkdXOW1I?=
 =?utf-8?B?a0Z4TmN0UENlQ1JrcUtUbjhQT0ZXbWJEVW1sRjllUmJ5UDFXOVdGcER3dnZ2?=
 =?utf-8?B?Z1RXN0U0SGdrbVgzTEdEVU8zcS80L0dQdmVINUhwNW40ZzloZ04vUFJRTGZR?=
 =?utf-8?B?aEttU0NEL2taM0tjUkFoaldkcCsxWDNucVc0d2dKb0FuRmdzbk5kUlN2ZkxU?=
 =?utf-8?B?Q05BRTh0WjNMMU1NY25nOUJ6aVAybDlEV1hTU0hnVy9rTHdmMmZzeE1TcDNh?=
 =?utf-8?B?dnpXSDJ3aGNVbkQ4b1g4a1FtckFiK0RJc29Mb1o1TmVmTmt1aDBBQWszcjRk?=
 =?utf-8?B?a1hlQ0ZqTFRoVEQ2ZEt2L3VaV1NxTVhXZjdYZWlpN1orUUhzOERiemFUMmQ3?=
 =?utf-8?B?V3k4L0N3V3RCdzFKRGl4SzNDU3V2RXN0MTZIREFMNkZBc1ZFTXRrVVcrL3pP?=
 =?utf-8?B?eFRsbUYrazhMbVVtb2pqYXZrZVQ0SWZOM1duUXFWUkxXOGEwM3ljN1BVeVEv?=
 =?utf-8?B?ZnJDdEdEYURtWWJ1RE1CUTl6R3JxVHNla3FOSXdyNzl1UndTYkpseER1TXU0?=
 =?utf-8?B?enY4cVc2WEVpclZKQldMK1BwSjdHbEtqVnNDYmd3QzdCQU5RVTBXWmNickJR?=
 =?utf-8?B?WWdkTmdralRSTUIrbXErNjIrZGxkamlGWi80WU96dUJLM0xTaGJzTEQ5RTdP?=
 =?utf-8?B?RnlZdWhDejljS2NRZUxHb3ZqcEhCM3FEZ0ZGRUgwZ2daSTdjV3hDQk1lR05w?=
 =?utf-8?B?Sm1HRWJ4NzUvZ2xtYisyZHgxRituMjZtb2R4UjV6WTVUaTV5cVRjYVhlNWl2?=
 =?utf-8?B?WTMwN3lpbThSeGRRaTRCWGl4MEdtcGMwaWYyOGZQUGlkZENBalNFQzRDUVhU?=
 =?utf-8?B?SzUrcmlwYmlOOXUwa0IwVUVUcTVTb0Y4NUtidkpRYmJRejlIQkh1V1Y1SEVi?=
 =?utf-8?B?T3M0dlpIZXMwOGtVZTRiclBQOGpDcEc4T00xaGxzSEVlREhFTjIxNnNKUzYv?=
 =?utf-8?B?WHd0VXJOa0Zjb2RVRkFSSnJuZGNMaGRrQWJ0R1pZbHZyQVZxVGlZSDQ2TjdT?=
 =?utf-8?B?R0o1OFQ1cUZ1WVdqSlRDTWsrck5FV0ZOUUhNc0w0SXdYN0dxMWJJUGNqUnlX?=
 =?utf-8?B?SmhWUS9ocHJ3ZUJJUHYvK3pnTVpNWVVWVUtsY1dSck1oZTErUVYyNjJrOW9X?=
 =?utf-8?B?TzljM2NwWHlDQW1iWS9taDlhVFZZRHVHMjc4emU3eU1Vd0ZmdWxqZXBqL09N?=
 =?utf-8?B?RXA4WHMzTU9hTHFuYnpNKzBFWVlaTC8yZTBlT04rQmEyenFqKzdZWGMrbzdG?=
 =?utf-8?B?WVdRNi91MGhsQnVKbEpBbVgyckNKbzY2Uk15V2lIUnNObEw5Y3RxTzRWRC9l?=
 =?utf-8?B?M0J6WHV6S1FXZG5DcFM4VS9hcjNwZ2xtQ2llTjRscW53WFJhaWthZndGTnBp?=
 =?utf-8?B?T01kaUdTMm5BMktoT1poMm5MQkNzQjZHUFgyTEhldVBsSFNNN1BoWWxxMC9v?=
 =?utf-8?B?bndvd05VTnVjU1gwb294WlhwMlZzWDFQcG1lNy9MYkwxWmM1UktVVlRDcEx1?=
 =?utf-8?B?bjBVWStmRFZVQXRTYmQzUVBSMVovVWE5N0JBS045NWxjMFRpdDQ0a0IrVjhL?=
 =?utf-8?Q?2IUjUfH4bsadBPER5Z3KJNs+1o/F7idDBizcDTepElH3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e7257c-4537-4c89-53a7-08dde2517f2d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 14:29:41.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbIt1iOE1dNyFzl3FdHL1zJdy1SxKuLoQMPftm/MWpEvAlqMkvcK4qFM5efani1PnZ01nKeGKXtAnCW25bottA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

On Sat Aug 23, 2025 at 11:20 PM JST, Danilo Krummrich wrote:
> On Sat Aug 23, 2025 at 4:16 PM CEST, Alexandre Courbot wrote:
>> On Sat Aug 23, 2025 at 10:57 PM JST, Danilo Krummrich wrote:
>>> On Sat Aug 23, 2025 at 3:47 PM CEST, Alexandre Courbot wrote:
>>>> Oops, forgot to mention a couple more things:
>>>>
>>>> On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
>>>>> Add a safe Rust abstraction for the kernel's scatter-gather list
>>>>> facilities (`struct scatterlist` and `struct sg_table`).
>>>>>
>>>>> This commit introduces `SGTable<T>`, a wrapper that uses a type-state
>>>>> pattern to provide compile-time guarantees about ownership and lifeti=
me.
>>>>
>>>> Is this actually a typestate? From my understanding, the typestate
>>>> pattern implies transitions from one state to the other (such as
>>>> Unmapped -> Mapped), but in this version there are no such transitions
>>>> (the previous ones had, though). We are just using a generic parameter=
,
>>>> so mentioning typestate sounds a bit misleading to me.
>>>
>>> I'd argue that it's still kind of a typestate. You can derive &SGTable =
(i.e.
>>> &SGTable<Borrowed>) from SGTabe<Owned>. So, technically there is an
>>> uni-directional transition I guess.
>>
>> That's technically correct, but is also not the intent of the design, at
>> least compared to something like Unmapped <-> Mapped. Not a big problem
>> if you prefer to keep the current naming though.
>
> I don't mind to name / call it differently, any suggestion?

Simply using "generic parameter" would lift the possiblity for
misinterpretation IMHO.


