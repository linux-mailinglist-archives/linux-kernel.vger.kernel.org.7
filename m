Return-Path: <linux-kernel+bounces-744729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB55B11056
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91371CE5851
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A862EB5AA;
	Thu, 24 Jul 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IT9+Ug2A"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657E14286
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378057; cv=fail; b=RyjYO5UrANx+ELV3slvdHehjZYt++RygCq3lYu0JBFJ88FslsKwoY69/49Ajg+WlOLZ3B1DgXtSzwV0/mZYaJi+SrgdEzZjQpsxTbw6bX/8k9KAg9f1+NCZQK2nUPIlyICVYm4DWmxGx3TV3WRq+Pcz1D7giLsvBrRtjc3SqpQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378057; c=relaxed/simple;
	bh=os39I7CXIhPMVd5aHLspRVVD/mH/vfnXTHvi+JF3qBw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGv/mZ+vbvRhphGr8vrhFzcmFnnY7CVCVEUl5lPnrz5TUeCMf75Yg3x670k01+vBY17Ox7ic4Z5L559Ble4z8wn8k+6kNIJ+uIrLQhbWt1hOAadT7aoa9rJ1Ql7rPrKGEj3EBx9Hk2FOG48xj7Iv1UHmk63oRN03sUVKLdDGe5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IT9+Ug2A; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQU9gkmf8YEQtUbl0opkFIglVFOjAWE8RJmvQFh1B7Eou/I7KHF+ZuNb2v8zqKvbHsetmG+DMu7lNaG/bE1/6KvS9IlrRwg41dO/hMMhCxGWaZK9OPXUb7Yv8TC/gYb46v/sORkcGUq6bmp6onCzVgKb8c3GZ2x8qy5MC3xVmx+Sbkz2MS5hRRVg3GNVzXV8jU5F8eFaWg0FL8trCNWGM2+RNWCHSVoGo9DsPuqw/9IeZbc4r5HrsxRcplM39MrsIVt8+KzM5qUp8BX/QzKJbP6L0mWyUc0VySAp9ohmeH0DyaRg5QB7s8IbVJtyX2SfqLl9PSoLZGK9pt981RoAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/0VI+IVkDn5KzRIfDiECVYDrYRoSet0Eprz8iJ29qQ=;
 b=TJve8ilyBpct9lxkneEa+4hLvz4SBiqhHmUzjTlUwS4SARAJg004Z0oiDyzIsHsXlIu2nRfYinVfnHZNuSx3/Wzb4FidN9MCsOa4RRYxDUItmDZcjYWjD71GAGX36Xd2QL5NvdP5E14xbZVIMmYB4LBDwWh46XKU1FZ8TVCm9nYyOFQ2Z0AffXan2erNxlLAdtLbAQF1kj6jXHcRtXITd4boYJP3qqqO08UCoiVAwRYUZ7r5o75IA236V3KiwCfdOuZTmTQ9hAKrNrwbMItjmjrDWxx96QLZhPHgWv6ph057hojZyjRlxS8zCapCvoWM9ncBgGu89YAm2F6cy/apYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/0VI+IVkDn5KzRIfDiECVYDrYRoSet0Eprz8iJ29qQ=;
 b=IT9+Ug2Adv41pH2onS6OpMSNRLxlnRpGg6+bFnH8aIAR2pAO5ME21S3FOriACv5Etzh9W4kdnJag6LwOs7Ogz/S/IEoHhVdb87UAz3LeLn0NLdkLKuGcWmll5Dagr7qRu5FKpuh7XFAd64TEC2ZXZKQc+eBT1NsQRZSxz1uZyfXKr4GB+V/cEP5gg19ObiHb/1AmFMYBRBxn37/wZ2H0zKiLWeC4FrTLQfBTUQ6qJvpX42kyeQLpLiqA5bvl4ZuuGn91VsTEsvUM1lpF5BI6t9QfUsl8+Kyp4AnE9w9JbXjpLPwuRlC17PVoNJzrcSaaIDLiBsjeD5YgpNr7qlS5+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 17:27:32 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 17:27:32 +0000
Message-ID: <f0d925f4-e133-4cd0-8840-096b0858243e@nvidia.com>
Date: Thu, 24 Jul 2025 10:27:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/gup: remove (VM_)BUG_ONs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Hildenbrand <david@redhat.com>,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Peter Xu <peterx@redhat.com>
References: <3dfbbd63-697d-42aa-8906-539d74df9123@nvidia.com>
 <44af8f5a-2d94-498b-a3e0-31f5dde74538@redhat.com>
 <20250606184212.GB63308@ziepe.ca>
 <f2d8febc-cf95-44dc-9f01-b28151fe1282@lucifer.local>
 <e5e88da7-d7c5-4a10-9318-76c1e38dd0a6@lucifer.local>
 <20250607134214.GA158671@ziepe.ca>
 <04f52d21-baeb-4286-99eb-99edead514b8@lucifer.local>
 <8ce6c104-d2fb-4fed-a108-224a6113c227@nvidia.com>
 <b387a3c6-1bf9-434f-a255-6e92269e6ba5@suse.cz>
 <c5be8d13-59ea-43e9-9b89-69dbfafd4a9c@suse.cz>
 <55fdc47f-5a14-43d4-814b-7defd1101050@lucifer.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <55fdc47f-5a14-43d4-814b-7defd1101050@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::27) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c1d17e-1e5e-4bb0-0f15-08ddcad75f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ti9hbGRNQm8zd1RCNWIwRmhmd0ZrVWNXOXY3QnhoRDMwaTNEeit4ZWU2R29k?=
 =?utf-8?B?ZjNDbi9wNlZyckFCR0dqaENZSmdvNGlaeDZDdkRISm1mbkhybFZoN2ltUVBK?=
 =?utf-8?B?MEhReFd1aVN4U1B1UVRxWHg3amRHMENuVG1OUDFUSWppNHZnVHJMeVFCTnh4?=
 =?utf-8?B?dGRZSUZJUmNJZy9ENEw4RFFQaVgyK1pWTXIxMzJ2cnBaL095ODJZSHVtamta?=
 =?utf-8?B?Z3dlaVFEbzgrNkdPSU9sQWc1NW1GeVlmQTVrYWtYdkN6b1RUT3pGdXcxb1pJ?=
 =?utf-8?B?WWZ2RWNEd2VKRktNdnowdUVXby9UZHNaMVJsVk4vYlE4T2U0K1NUZXhrODQr?=
 =?utf-8?B?NU1sZW40UnhuSnA2QzZmY25BeGlLMlg2Mktqa1VONmIrU3U3MmZGL0ViTTNJ?=
 =?utf-8?B?d0RSbFN5NUVWWmt5K1RkWUxZeVNwT0ZGSFN1eU1xU2VEUS9rQjkva3F6alA1?=
 =?utf-8?B?SXpMUmZtTDY4RlVWRHlLb3BCbWlVaEJOdGRjTzdQb3NrNFZKY1NpLy9NM3pT?=
 =?utf-8?B?UzJJNktPcW16cUFWTUVGTVQxMkdDbWIzYkh6WDAyT25tYVA2aitrNXJ1V2xE?=
 =?utf-8?B?R0lsRlBSNDd0UkZmQjlsYUswVTFsWHRSbUNuTG90K3dEZlBCR3NKZXlER3pa?=
 =?utf-8?B?NEl4bWNWQ1pRNWVIb3YxaXVtZlVjOExySVZBN0Y1OXNiMzU1OGJKMTZQUTdn?=
 =?utf-8?B?ckE4VCtCT2dZeWNQU21MVU92V3VsOVRzcmZrbjBDMUVNNWYzcFdCMnZteXlE?=
 =?utf-8?B?aUlPTndQY0d5eVFwQkY0MG0ydnhhMm1NYlkzRE84Wm41bXN5RURKcTlVWnlG?=
 =?utf-8?B?QjdXb0U3TVJlc29MS2s1dHFMeEx5bnU3TGNKUmhpWHRvaE9oVTFtT0pyUGFN?=
 =?utf-8?B?OXo4M0tZWFhoUjNBVFp4VWVsTDQrWDFSZW1qeDZhcjJ3RXBXRXRJM1Rma1B0?=
 =?utf-8?B?QUdyV0x4am1QODl0amdodUcvamdvTXpLRms3QmZQdW5Db1NRcDJGeG1zOWxp?=
 =?utf-8?B?dHhaWVB6M29rQ09DZjRGVm5RTnpFYmQvZ1NCbGRFMGwvOUxtdGw5V1J1S0tK?=
 =?utf-8?B?WG1GZ21sMUdWZmdVRU5vZGc4S25rS1BPNDJMekhFeFhBNXNUV3EvT3pOR2s5?=
 =?utf-8?B?aVYxcEZWTEVPRitTYzdicWplT1cwVWtQN0I2ODVaRmJZaEwxWmtTcUtBbUd1?=
 =?utf-8?B?T0RHbEQwRWtGYlZYUzRnZ0lzZmlYc1JGanpCcHRzVkV5TFl3bDhzK25PYmcy?=
 =?utf-8?B?Wk1vTm02NWdxbkp0dmVvOEtLU3ZOS25YYVlUMW9RM2Z5SDkyc0swMzZlMG5j?=
 =?utf-8?B?T2w4cTRWeEFkQU1jSEFnZUtQQ3ZYd1dlN0JTV0FXRHQzYjN3aFJvbnh5Y0FR?=
 =?utf-8?B?enB1dnFOU2wxNXhhVGNGOFFheTBFaEt0K3Y5ZzdDaWRGZzBnWElpZnhWbzdM?=
 =?utf-8?B?S0ZDdW01SXkzUXpZQ0hIUkpKMVMvVFRoSVJJTGV6dUNyL3FLY08ySWJLdzVl?=
 =?utf-8?B?Rkh2QVlRUmFLZkFCVTYrWHFlbFU0ZVhYQy9KU2RLc1hhcVJUOUsraXJiRFBM?=
 =?utf-8?B?NVFvUDZDNEJhYmwydkxNa0JENTN2N1RpNWx2VjRpRUxrUi9LSC82ODBTS3p2?=
 =?utf-8?B?OWtVYXFRZXhVbDlwV0JhZXRWeXRwZDZMTmIzWUQ2WWRpSCttSUhBcGZSVHpv?=
 =?utf-8?B?QXVIZ1RGL2FBUlMwNEUyeURidkJDNnBTQ3RmZHQxRzJHWW9VOXB3VFBKaWJQ?=
 =?utf-8?B?b0lId2dvZHF3MDdsZ2ExYVJ1Zi96M0RZOXlTYmFIVzloY2hWRnNPeEVtTjdJ?=
 =?utf-8?B?L0daNDMrOU41N0hjR1dzTGNIMFdzRGYxUUtOTDFxdjdzbVJUTG5oekM0cndX?=
 =?utf-8?B?MkNQNmNpbGtnODZ4T2tCM2YvTmhHMjRtd0xPdjIwcisybm1tUndyWmFKK29a?=
 =?utf-8?Q?fA2WRoB+BGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVXS095ZXBKNDlNTVRualRzT2hOcU14TWttM1c4UmhqeTFJMGk3MHk4ak01?=
 =?utf-8?B?aEdteUd3SEVzK2g0RG8yc3RIbitoZE5VcjFPVGZ0WDUrVHNVdVovTnI3cHBp?=
 =?utf-8?B?bGNZS0RZOEk0emFJQ2V4LzhKNnNXek5XNy9ZSzZYOVpHbkJzTjFsWG5kbEpj?=
 =?utf-8?B?MmJmQlkvNm5YOG80U0pISGNnU3pPWWk0T0s3VFo3clFVaVBlTy9UV1FwNEdw?=
 =?utf-8?B?a2I0Z0phKzM4Ykw0Q0FIV0c3TE9YcTRwdWxuY3VsYmhpUG5pU0ozUTg3UGp0?=
 =?utf-8?B?MnpuWnluRzF0aFo1dVpGWVBlVjlRWE8zQll6Z0hNNmNDU3dTWC9BNFVzUi83?=
 =?utf-8?B?RU5EMmhZOFVYYXhMSU9xUVZGNkphNTFBdWN3bzNKTWY1M3pMQ051aTJoN0tt?=
 =?utf-8?B?UGRJSXE2Uit0dnZmK1pVNkI4b2l6WE80dmtCN1NjRDVBS3pmWjJISW1nR1NZ?=
 =?utf-8?B?UC9BMVYwM1NGZGc1K0lUYmNsekhRYVE5cXgzdnhjTGZIUDVOdng4NUdDQTVh?=
 =?utf-8?B?a3VCS3ltSktLc2VWcU9Ea252MW9rcUpQTThOa0xFeVB2Q1E2UWtidncwbDBP?=
 =?utf-8?B?VVJ0YkxaUVhVVjRwcjltRG9iQ2xzVnpJd0ZQZGpldU91YTNDY0NjMkc0WjN0?=
 =?utf-8?B?ZE91aW54cnMxSzhxSElNaG9sSFZGYnZTOTY2cVgwOGhrWjFQOEdmV2FtLzZL?=
 =?utf-8?B?TlJibllsSGRnOUFnTGtzQmVPY00rUlJzNWhBUnlNVlA2eTVhWStPTm11N1dQ?=
 =?utf-8?B?aC95RTVtdzl6TUplZFlObjVoUXFYQ2FtaG5mRDJUbmcvTW1vTXlhYkpLaVhz?=
 =?utf-8?B?c2xOdlFscTRkWWhvVXYzTjY4cFRZWVhlNFZnblpUbk1Jc0lRRXN1UEpzVTla?=
 =?utf-8?B?eGNHUTA5VHVVM3pyTHdRaE56T2lGeGdMMmg3R2ZWRDlzRUExV1ZPa2lNa0NJ?=
 =?utf-8?B?ZitLN1dZa2l5dkRzTlNaaXZDQnI5S2VNZGUyc0F4Nld4YmtZejBjMlIzd2ZN?=
 =?utf-8?B?ekNkamN1NXJaNzNMVElPQW5CMTVOcDIvOVlmOWdSUU5ZdkFRZWEzYUpyUTlB?=
 =?utf-8?B?OG15N3ZEcUkyVUU3QUUxK1RjMXAySU1YTHFJMm8zTG1zRzZ2elJUT21ndlh1?=
 =?utf-8?B?cVNMcHdZRlVWOXA1eGFhcFNVNk1hTnVuelF5Q0M0OUN2ZzYycU5FYXZVTlk2?=
 =?utf-8?B?KzJnRnU4N1FjQTVBeUwzTG1JWHpXeCtuYmN6QkdVTEszaGFXZkVEekhYdDdH?=
 =?utf-8?B?TWdZNkJ0NFlnZkFqU2IxVVZETmVCaHpCWjNpN3dvM0szbVQrWmxSNCt3U2Mw?=
 =?utf-8?B?cllHbkx2eEF1RFNySExFZUVmZXBuVng3ak9OYUNiV0FwV1pCTVh6aWQ0MDJO?=
 =?utf-8?B?SlRGNmlZemgrcnpxU0lpdnNZOFdQcVl6cWo5Ym8wM0ZTOEJZNXRybHlwQjk5?=
 =?utf-8?B?b0hISzRHN3JRdXlvQkJhZ2s1OGJ0cEFIR1JWQ2JuazF4L1QrYmpUQVlld1Ax?=
 =?utf-8?B?aDRBa3ZIQXg5Q20rbWFaeis3RzEyNldTRDVBM3kxWkxTeTdOVWJNZlcySkZL?=
 =?utf-8?B?ZlQrUmoyRXluUFNvdEJxbDlSd0dXODA3SWgrak1pUjg5aDJhK0xIUnRUV3pW?=
 =?utf-8?B?Z1ZwemwwanFvR0hMK3AzU1MyUFA3Z3NKTDQ4OHlaTkhtZTl2RGdHK29MdEYr?=
 =?utf-8?B?eW9EbHJneUlSSmdQaVpRSXBTcGJXYzBybWxDTW1XNUlLRmJUM1dwMUw1YTl0?=
 =?utf-8?B?QjhMWEN4LzIvWldSMERBWUVwQlVIRFlCYlhjTU9qeTAyU2Qrekw4WjIvcDhX?=
 =?utf-8?B?Vkc2SkNGVGtEVlhtaGp3RFdVckxJc0FReHZicXBONVI2eUhHTGhpdlJEMDg5?=
 =?utf-8?B?YTBCYU5hYzhXeTYxd09YcEY4VXk3czNOZzB3OXJrSVhRdHVtY3BDeFhGWDFC?=
 =?utf-8?B?ZjlpOEpON3NHekhaY1o1ZU5JQUxFYmtQQnJZNjRVcnN0ejUyWjFsbDVNcXBP?=
 =?utf-8?B?dnFGcmtIajl0TVdhR1pSL0dmSUFpdnMyRzN1RG9yQ0ltSVRuY1plL1ZHZXhO?=
 =?utf-8?B?VUtwellhZi9kbktWRTdndXFWWUxwUjJyM1libzNpNXoveXNaTFEzVEFYZktk?=
 =?utf-8?B?RmtibkMwNEEyQ1YrcGl5eDJSd3lVcGcvNzd6cUxvaWJXajhSZjgvKzBsVFBk?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c1d17e-1e5e-4bb0-0f15-08ddcad75f74
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:27:32.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoW3G0gkuQOE2/hUEojHA7jf4jFHfarCbU7NyO41YAKgxrKHoq6tc8mc9FiORiMSJggvsziP9fNo8d2BYhRIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010

On 7/24/25 3:56 AM, Lorenzo Stoakes wrote:
> On Thu, Jul 24, 2025 at 12:54:26PM +0200, Vlastimil Babka wrote:
>> On 6/9/25 11:57, Vlastimil Babka wrote:
>>> On 6/7/25 8:00 PM, John Hubbard wrote:
>>>> On 6/7/25 6:53 AM, Lorenzo Stoakes wrote:
>>>> The worst part is that if you go to reproduce a problem, you don't
>>>> see the next warning in the logs!! This is devastating, especially if
>>>> the site makes it hard to ask for a system reboot. (If you have
>>>> ~20,000 nodes in the cluster, a reboot is not a small affair.)
>>>
>>> Assuming you know how to reproduce the problem... I wonder if it would
>>> help if there was a way (sysctl?) to re-arm all the _ONCE warnings. It
>>> shouldn't be that hard hopefully?
>>
>> Oh hey it already exists, since 2017
>>
>> echo 1 > /sys/kernel/debug/clear_warn_once
> 
> Ohhh! Nice!

WOW, how did I go all this time without knowing about that? It's just
what I always wanted! :)

thanks,
-- 
John Hubbard


