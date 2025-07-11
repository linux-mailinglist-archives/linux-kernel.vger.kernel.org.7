Return-Path: <linux-kernel+bounces-727948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AFAB021AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E083ACAEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837712EF2BE;
	Fri, 11 Jul 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ApqNUmqz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6972F003E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251180; cv=fail; b=O1tk+4Gl7dmuPP8vRg1yH2V7SrQ7L03wIJ7j6np2y6kAyRw6LY31quFmTg1Hdb/LXiHhnzq12ezkpmniKiSGXZlJP2mA/AlwQRU3D8JArVc0i3vWKRyPn6qIaHHTZbOe+/9F0syf7YrdR664TY3kBrb/qx+dybo++EvHCMjlyeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251180; c=relaxed/simple;
	bh=HIXDYlXxZ0QUPI4OYw/mmLxm+K14xgvvOSSqb0JZH9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZOg+S+0xEqjwyfTGDAhRPe9h9sCPaWDmKB30d+j0/lU8rqpqu/dPIBff9yPtXFbwD70UjKxKEwU5EGZgyBKoWnsgb612mZPk9DbCZEhliOTxH6q7pid83OOcrqDuwSjlxC7Mrqbz7X/Qc85NAPhX1Nk0Ba7VnnKRRObzhL4wrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ApqNUmqz; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhCyYgjPyWmlG2QRrCbqINH92WrftvQWXufsHhzzEGEhhyqP9vD8pYRRdHASDID+PDLO5IRfRThk6nGxIXQ1lCsoexZnCP9dKBuHkAmNAoepRfFHF3XkfDGFfHk+ED+fcKTSGYmwF054Y2kkY2Jvnb1NGtrUxBTZloSEI338VD5gIBJQblK9yopuPhyg3WYKk7aK9BVw9XlRcDoUwOiyM1GzPShPJVr+VGRbX6PXK5aVKEr7cbD9j7UZcJtE89F1KudHmP1EDav8BdoegJ2jQp/P9zO3vqA9Q8o9AclHoI/NZQva5nO1nqrKBNW/s48EF/+1jWFrygCI+wtOjdhEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGPmawBmUM4hdYFi38O5HKnjcN/CoDA8L58DKM9T4Ho=;
 b=IcjwA5xkBD3zUEU2nDWlf3O0Khupk+9euC4CregT/wTu6OcPSIPWDxZ6yBQinCSlQ0bePNmW5o0drBjudAG8pIiEHKyOJdBP66CdJOWjrbKOUFpygcIMGgiiZHD6XduRfM62/b7O51YZjG7gSOTjPN7KGmy2dVIzQ3mxXJ1wbVg84dwdmLNtsh+EBJ7Dqn7v5r7NP7+ObpT/Nqvxj/tbKJ+Xa4/gh2mm9PNdtIU+9XIa9YBZ/fqnQsVVJLu84+Kn8jZpF5gj7/WWEEW+lpcLRMLC4FclrFsZJ/09JyKaf6fGFVktT86RXCmYU4j/A0JGSM9N9Kf7gFro6TK61XeLgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGPmawBmUM4hdYFi38O5HKnjcN/CoDA8L58DKM9T4Ho=;
 b=ApqNUmqzGLP2dgXPeq+0f3rVuRWvUIv/OuOtYlgH3gY09mHJ/lsr/Higka3TukfIMgWZ6jRFL3Tyk0HBGe40bj7t0I5uJ3YhsY+LRruNSNZdF8wdiGwuQAY9i+jTFZxfhYL3BbAYXQbzStHArf9IR5GQC/tvY9XTBiDF8ZmVWIw4IdVA3C8lnUaXQI/8DhaeFolv9s94oLUGF06+NHz5pIdo6DYfXKd1rL5GDyTfIArhyvl1CbZzFrVdbNNJXfpl+5slPk/0d6QVLjEVJBS7KRq4/KGT0BM/T7+UbJGMwDKQsF5tVx1/B0IQIZ/JU4P8+u2I3St0aNzIp2mil8SHyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 16:26:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 16:26:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Date: Fri, 11 Jul 2025 12:26:07 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0189444A-451E-4DE6-89EF-EB472265F3AA@nvidia.com>
In-Reply-To: <b38591bb-5827-4e99-97d9-03f74f231c05@redhat.com>
References: <20250711030259.3574392-1-ziy@nvidia.com>
 <c7e82a13-aa93-4eb3-8679-29cd32692bd0@redhat.com>
 <2AE055C4-BFFE-4B61-A96A-6DE227422C7B@nvidia.com>
 <3223bd3b-38cc-45d1-8080-d62117df0e85@redhat.com>
 <B9C05B4D-2777-45DC-A229-B4E119B0E9A3@nvidia.com>
 <b38591bb-5827-4e99-97d9-03f74f231c05@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: cced3378-f253-4164-ed39-08ddc097a63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTZBSDgyR0V5S0xHbGFWM1lvTFNmbW82YVFSTGF4Q09xbW1qVnYvc1dqV0FF?=
 =?utf-8?B?T1gzWUJ5aUkxZzVmcUxOU0g3dE12NVNUQVRkdFVQajZRSFlHSVkyKzZMbHdw?=
 =?utf-8?B?Y2xMYjh4UVZiSWZQVnhZbE1qZkIwTzluUlZwVzJwdTBKdWV0WEJvdXI0MmhC?=
 =?utf-8?B?Rmo2NXVucnpRb0ZpbGtwVTd5bWc5L2dmZStRZXp0cnpudmpsb28zY0ZNcXZL?=
 =?utf-8?B?S3BtcFBMV2RjYnQ0bDZYUkJZQXU5a0dET0RnMS9VQllUTG9YRXRFVEdDeG0z?=
 =?utf-8?B?aUpRUGN3MkJGRkJjZGJDd3ZIcmc5bko1eVdxb2kvNnF0eGUzUi94SzBmT0tF?=
 =?utf-8?B?WkhZUU1CN2lQNGN6M0hJcDFhN0ZaQk1HMWxMdlg2N05KVHVIU1VPbnFMMUFC?=
 =?utf-8?B?T1dxRW5LOERWMGhQVkJLMkM5QmRTMnd3VjBWRjJYcXRyNmhLd2NOQlYyb21W?=
 =?utf-8?B?RGM2c2tyNDA0UUtBb1lUNW1aYzg3ZjRTbThRS1lWTXdGYlE1U0hMMXBBRk9B?=
 =?utf-8?B?OFNZeFdqaVgrVktUUWg3T1ZvL00xYjZRcG82enlFeVpEazVmeW1EWEdKK25V?=
 =?utf-8?B?TSt1d1MwdmdMdWJUZ1kvck5mV0w2aWIxUzF2QTM4R1dSRDdiN3V4dlJuMEJP?=
 =?utf-8?B?M0NHUGZ0YzZUdHdIRm1SckxZM2d4RU5adU5hYjBoQ1UyRDNjMXVZZFRtRHNB?=
 =?utf-8?B?MDREblEzaDNPbjdEbTVwYml3czdJTndJWWZ4azlaK3V2UWVrSEVYMUhlcDA2?=
 =?utf-8?B?WkVNVHltenVVTTQzZmRmVTRGbWQvWDdhUlpBc1VodkZCQ2NHREM1UmZ5VHJB?=
 =?utf-8?B?Mm40ditCaVFlbWtkdEFkR1JodmdvYnVUQ2x3Z2RrRnV4eE0vYlgvMHV6SEE4?=
 =?utf-8?B?Uk9qK0dpNXNteUlKTW9WNVBOQlBVZkVHbXNTZTNCNmhwT0JJaXUvKzc0d0Zo?=
 =?utf-8?B?cDRtWi9KakJIbEtkeWNDSGhROE1lNDhQdDhrSHV1ZVV1OUg5N2x4dm9jYllI?=
 =?utf-8?B?emo3RkxpaDlSc0VwWER6Nm8rZ3RNazhDcHl5N0w1aHZFb3d4OHZvWHA3My9i?=
 =?utf-8?B?THhEdjZTZUpXcSsxR210K0VSWTlLWXV2ZFhBTnFFZGpwNDk5d3g4eEhMUmo1?=
 =?utf-8?B?NW5KOUNITmx0L0d6dlNmT1Q5ZGRzTUprRXNwWm5zaStNazl6VFluU1hhMFpS?=
 =?utf-8?B?b0pBVm80QXI1Qm8zN0sxRVFtS2tGQnQzRXBHNEsyUUNkM2JPbDBKZmtWSkdp?=
 =?utf-8?B?Z2JtY1BqZXMrcWxRUXh5aWJjQ3VWUHdJS3FRam5ocGpjYlNtYlI1VzR2Vjd2?=
 =?utf-8?B?Q3JvNFUyb0Y4bk9YM0xsRWp2ZHR4YjJqUWo0aHVaRmd2S24vMFZCdVZKdWdh?=
 =?utf-8?B?ZVYrcEdxYlNId0MwRUZVbXB1blVMMXpYTktiQzB0OGVuVlJJQkRDWmlWeUlM?=
 =?utf-8?B?Y1ZCUlhnZ0NrSUhVYzJzRElsUk12V2dUNEVMeU50ZWIzSXRSS0k2a3JpUk5X?=
 =?utf-8?B?ZnQxanBEaW4vd21WN0VlYUJib081QzVyYmZIR0FoRVZnZUE2eTJlVHBtMkJ4?=
 =?utf-8?B?allRQy9SRG1vcmpHNy8xNFVZMWxLU0FwaFVETjI0UVBZaDlNME93NVpTb0tv?=
 =?utf-8?B?emJWbnp3d3l6VVp2enZjNjZ6cWwwdm5kSGZpY0poM0tLcnZWSUgyVU9vSWRL?=
 =?utf-8?B?b09ycVFzYXhhRmxTUHBIdXNJaGcwdFJJTDVlMDliMDE5SDFrOHkrVnBzQW81?=
 =?utf-8?B?MUFKbkxwK1h6TlRPS1hyakVFRU42SG1NR05qYlhmU2x1d0lpemtidzAzaFd6?=
 =?utf-8?B?VGtKdkFFUk5VTTgwTjFicXZoanN5YlYwMUV0a1JndDRBN3ZkWlRPSkJmZTRz?=
 =?utf-8?B?RUdWazRjSlJneE9BT0tTQUdhNW1GNUZGU3FNVGpyaHk3ZFhQZ0RIZGhPRzIv?=
 =?utf-8?Q?rQhVhR+u6o8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFjVUZ3ZnQvdmlRckxtdFdkeUIzbzlMYnFwSW8yUkFsMkZBdXFja0JhUEw0?=
 =?utf-8?B?bVBnalBmcUxBRXNQK01OR09seHNnQ25BRC8rcnd6cURrdnkrVGJMSW5pUklM?=
 =?utf-8?B?bEU0YTZKNlNkaFlUR2x6eXhIZ2FMRzBtMUNyY1VOdmdCMU4wTUlQNHVVa2NP?=
 =?utf-8?B?czgxVUh1ZmVyUXNWdWtGWHFIaTIxUElCS055cy9USUI1bTArM25VeWlyOGZm?=
 =?utf-8?B?SzdJQlJQUXNuZmtGVVlRU3FNWXd4QWhSU1cxUlZmc1J3OEJjTW9FNFFlQnhm?=
 =?utf-8?B?VHJEelVJblpMb1JWeUVHN2RzL2l3V0NyTkxEV0IwUzViWXpIRk5qSldKUmV6?=
 =?utf-8?B?Z2s0UXVTWmxpNm41T2xMOWozODI1c3ZEaVovRGdPL0NxSVZkY29lWmYwN0Qr?=
 =?utf-8?B?ZmE0Sm9hQkV5Zm5RZDZsRGRSdmp2YXZBYUcxWHNieklPOEVCMXQ3V2tKeHph?=
 =?utf-8?B?S2FZcHo3UjROQUUvVlJjQTd2YytBWHE0T3d1RUo4bHdEUDJQVUtkZC9MaUNm?=
 =?utf-8?B?djIrZXM1U2c3SXMwTFBLOVdZUjJYbm5KMHZUTnNtajBhOEJUN2l3a3FhQ2JD?=
 =?utf-8?B?RUVBbVBRYytlajhINnYzalpJbzNVSmtacHUyVjJNQ2t0R1FEVER2THQ1WE1q?=
 =?utf-8?B?NS9UdjBzZGI3dzRiM1R3MnNNRDRWTTgxZnBaSmw4SWlsZklWSFVXWnZQejY4?=
 =?utf-8?B?RHNOUWR5M1AxNk9IbHZ5K3JkZisyTGVSNmpuOWhEN2krZ0RkRHZRbzhYZXNS?=
 =?utf-8?B?bnpYU2luRk9hYVBDU2ZTZEVkMys0cXdYaFRRMGV2emJCNjcyVW12WU9YU3E1?=
 =?utf-8?B?aUxxNVZyVkxBZzBHK01uMEp6OU1NZDB0R2dyYUpkN3hNSnJPUld5TGtEckxp?=
 =?utf-8?B?UU1zR2wzR3VJWHBrTlZCK1hRT2pKL2gvTU9Wd0h4d2ZjMHp3aWREYUpJSmg3?=
 =?utf-8?B?Uk92bUgzalFNZVprSTBCOUpYY3pUczJva0c4d2hJR2F3a09zblVFRVZYVWto?=
 =?utf-8?B?U2c0LzN6djRSckJNSmtIekhVQ3BSdDhlM2pJSlkvSW9CVk5pdndVK2NkejZK?=
 =?utf-8?B?ckpOME0zbnVTMXd3SXFSaS8yd21Jb1A1QWFnT1NUdzlEZ0o3TFlkMEF5YmVZ?=
 =?utf-8?B?MXhOSEFPVy94RUNaaTQrRnp0clc3enlDY1pFZjVlcTB0WDU3NmgzZnVvM0Zv?=
 =?utf-8?B?RkFJdWRTWitaK2FJMm1sWlVTMEoyaHcyL216UmJmYmJPNVVlN2Y4OUxwUWZ5?=
 =?utf-8?B?SG1SN2tjcElxWUhHK0hwQjd2SjlnWHBIVWZMZFRjVGJDRXo3WmtxWnFaZHNN?=
 =?utf-8?B?bGRVdUNXYzQvSjgvUDlkYWJjVkE4eVlrTHZSR1lzWWhPTG1jTVdjSUNub0M2?=
 =?utf-8?B?QjE1NFZRV3JYeW1jRGlZWlQ1SzUrYmJ3VEJxRS9jcmlDbUNnS1ovaUlKVG0z?=
 =?utf-8?B?Ump0anMyaTlYRksvRUU4M09jZUMyRlhJN25vV21RYTJGWmlkWWIyNkVxS3RX?=
 =?utf-8?B?eERYODFlRnZHVFdVamVwbG9zZ0sxdmZIY0l3R2x4bnNVNktvNTNaRGF5VGdW?=
 =?utf-8?B?eHJLTitJRFBrNTBhQ1pRQW85SS9oZ1FyVjhsM0N5NWtvWTBpOFVrajdaSGNU?=
 =?utf-8?B?TWowVXRPNEtxeGlTT1NoM0RTYmRqRnVRRDc4L09IOFgzVkhWQmRhVGFYMW01?=
 =?utf-8?B?R2pBYzhYNE5Hd1RsblRnOTF1S0x2WWE0Vnc4dEh6QUZCSUhiZnBROVZYRWlW?=
 =?utf-8?B?Ukg5YVZqZmszNHovOFNHNjhQUEE3VUxEMnNxWTRTdDNvM2hFRS8xOFlPUFV6?=
 =?utf-8?B?TDEyL3hpM1pZWk9vVXo4UWkvY3BjWVY2UlRrYTBTUDlJR1FJbU5jYXlxb2I4?=
 =?utf-8?B?dFAwU3pHUlFRUlNaRlZBUW9iMGpwK0JITWhMMkk3UUpNZHBYRWZqTWdmVS9u?=
 =?utf-8?B?UThleHJmV1U0Z1NBSkNqQ1hoTzNMTUpmYitUcUczL2h1TjNjYk5pNjEybDJm?=
 =?utf-8?B?ZCtBQlRMTjJyRm1oblRuV3orUG1WcWU2YlJPdGRzMGk4Q0g4NkZMcElUYjZx?=
 =?utf-8?B?am40c0toKzAra21uVVd5R3cvR3dIYUF3di9hYzNLa0Rha21vbXY2LzBET1JK?=
 =?utf-8?Q?XIEtFpx2KYQgREltvHXhaU2A4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cced3378-f253-4164-ed39-08ddc097a63c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:26:11.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7HyP4EoXZszSmmvhSWenYn2ii4kIAS+bDyLPHcG4zBr5XtOQgkRXH6yDYsNfrr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

On 11 Jul 2025, at 12:03, David Hildenbrand wrote:

> On 11.07.25 17:40, Zi Yan wrote:
>> On 11 Jul 2025, at 10:40, David Hildenbrand wrote:
>>
>>> On 11.07.25 16:37, Zi Yan wrote:
>>>> On 11 Jul 2025, at 2:41, David Hildenbrand wrote:
>>>>
>>>>> On 11.07.25 05:02, Zi Yan wrote:
>>>>>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not related=
 to
>>>>>> splitting unmapped folio operations. Move them out to the caller, so=
 that
>>>>>> __split_unmapped_folio() only splits unmapped folios. This makes
>>>>>> __split_unmapped_folio() reusable.
>>>>>>
>>>>>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>> Based on the prior discussion[1], this patch makes
>>>>>> __split_unmapped_folio() reusable for splitting unmapped folios with=
out
>>>>>> adding a new boolean unmapped parameter to guard mapping related cod=
e.
>>>>>>
>>>>>> Another potential benefit is that __split_unmapped_folio() could be
>>>>>> called on after-split folios by __folio_split() to perform new split
>>>>>> methods. For example, at deferred split time, unmapped subpages can
>>>>>> scatter arbitrarily within a large folio, neither uniform nor non-un=
iform
>>>>>> split can maximize after-split folio orders for mapped subpages.
>>>>>> Hopefully, performing __split_unmapped_folio() multiple times can
>>>>>> achieve the optimal split result.
>>>>>>
>>>>>> It passed mm selftests.
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B=
54845@nvidia.com/
>>>>>> ---
>>>>>>
>>>>>>     mm/huge_memory.c | 275 ++++++++++++++++++++++++-----------------=
------
>>>>>>     1 file changed, 139 insertions(+), 136 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 3eb1c34be601..d97145dfa6c8 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct fol=
io *folio, int old_order,
>>>>>>      *             order - 1 to new_order).
>>>>>>      * @split_at: in buddy allocator like split, the folio containin=
g @split_at
>>>>>>      *            will be split until its order becomes @new_order.
>>>>>> - * @lock_at: the folio containing @lock_at is left locked for calle=
r.
>>>>>> - * @list: the after split folios will be added to @list if it is no=
t NULL,
>>>>>> - *        otherwise to LRU lists.
>>>>>> - * @end: the end of the file @folio maps to. -1 if @folio is anonym=
ous memory.
>>>>>>      * @xas: xa_state pointing to folio->mapping->i_pages and locked=
 by caller
>>>>>>      * @mapping: @folio->mapping
>>>>>>      * @uniform_split: if the split is uniform or not (buddy allocat=
or like split)
>>>>>> @@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct fo=
lio *folio, int old_order,
>>>>>>      *    @page, which is split in next for loop.
>>>>>>      *
>>>>>>      * After splitting, the caller's folio reference will be transfe=
rred to the
>>>>>> - * folio containing @page. The other folios may be freed if they ar=
e not mapped.
>>>>>> - *
>>>>>> - * In terms of locking, after splitting,
>>>>>> - * 1. uniform split leaves @page (or the folio contains it) locked;
>>>>>> - * 2. buddy allocator like (non-uniform) split leaves @folio locked=
.
>>>>>> - *
>>>>>> + * folio containing @page. The caller needs to unlock and/or free a=
fter-split
>>>>>> + * folios if necessary.
>>>>>>      *
>>>>>>      * For !uniform_split, when -ENOMEM is returned, the original fo=
lio might be
>>>>>>      * split. The caller needs to check the input folio.
>>>>>>      */
>>>>>>     static int __split_unmapped_folio(struct folio *folio, int new_o=
rder,
>>>>>> -		struct page *split_at, struct page *lock_at,
>>>>>> -		struct list_head *list, pgoff_t end,
>>>>>> -		struct xa_state *xas, struct address_space *mapping,
>>>>>> -		bool uniform_split)
>>>>>> +				  struct page *split_at, struct xa_state *xas,
>>>>>> +				  struct address_space *mapping,
>>>>>> +				  bool uniform_split)
>>>>>
>>>>> Use two-tabs indent please (like we already do, I assume).
>>>>
>>>> OK. I was using clang-format. It gave me this indentation.
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *folio=
, unsigned int new_order,
>>>>>>     {
>>>>>>     	struct deferred_split *ds_queue =3D get_deferred_split_queue(fo=
lio);
>>>>>>     	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>>>> +	struct folio *next_folio =3D folio_next(folio);
>>>>>>     	bool is_anon =3D folio_test_anon(folio);
>>>>>>     	struct address_space *mapping =3D NULL;
>>>>>>     	struct anon_vma *anon_vma =3D NULL;
>>>>>>     	int order =3D folio_order(folio);
>>>>>> +	struct folio *new_folio, *next;
>>>>>>     	int extra_pins, ret;
>>>>>> +	int nr_shmem_dropped =3D 0;
>>>>>>     	pgoff_t end;
>>>>>>     	bool is_hzp;
>>>>>>    @@ -3833,13 +3729,18 @@ static int __folio_split(struct folio *fo=
lio, unsigned int new_order,
>>>>>>     		 */
>>>>>>     		xas_lock(&xas);
>>>>>>     		xas_reset(&xas);
>>>>>> -		if (xas_load(&xas) !=3D folio)
>>>>>> +		if (xas_load(&xas) !=3D folio) {
>>>>>> +			ret =3D -EAGAIN;
>>>>>>     			goto fail;
>>>>>> +		}
>>>>>>     	}
>>>>>>      	/* Prevent deferred_split_scan() touching ->_refcount */
>>>>>>     	spin_lock(&ds_queue->split_queue_lock);
>>>>>>     	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>>>>> +		struct address_space *swap_cache =3D NULL;
>>>>>> +		struct lruvec *lruvec;
>>>>>> +
>>>>>>     		if (folio_order(folio) > 1 &&
>>>>>>     		    !list_empty(&folio->_deferred_list)) {
>>>>>>     			ds_queue->split_queue_len--;
>>>>>> @@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *foli=
o, unsigned int new_order,
>>>>>>     			}
>>>>>>     		}
>>>>>>    -		ret =3D __split_unmapped_folio(folio, new_order,
>>>>>> -				split_at, lock_at, list, end, &xas, mapping,
>>>>>> -				uniform_split);
>>>>>> +		if (folio_test_swapcache(folio)) {
>>>>>> +			if (mapping) {
>>>>>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>>>>>> +				ret =3D -EINVAL;
>>>>>> +				goto fail;
>>>>>> +			}
>>>>>> +
>>>>>> +			/*
>>>>>> +			 * a swapcache folio can only be uniformly split to
>>>>>> +			 * order-0
>>>>>> +			 */
>>>>>> +			if (!uniform_split || new_order !=3D 0) {
>>>>>> +				ret =3D -EINVAL;
>>>>>> +				goto fail;
>>>>>> +			}
>>>>>> +
>>>>>> +			swap_cache =3D swap_address_space(folio->swap);
>>>>>> +			xa_lock(&swap_cache->i_pages);
>>>>>> +		}
>>>>>> +
>>>>>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>>>>>> +		lruvec =3D folio_lruvec_lock(folio);
>>>>>> +
>>>>>> +		ret =3D __split_unmapped_folio(folio, new_order, split_at, &xas,
>>>>>> +					     mapping, uniform_split);
>>>>>> +
>>>>>> +		/*
>>>>>> +		 * Unfreeze after-split folios and put them back to the right
>>>>>> +		 * list. @folio should be kept frozon until page cache entries
>>>>>> +		 * are updated with all the other after-split folios to prevent
>>>>>> +		 * others seeing stale page cache entries.
>>>>>> +		 */
>>>>>> +		for (new_folio =3D folio_next(folio); new_folio !=3D next_folio;
>>>>>> +		     new_folio =3D next) {
>>>>>> +			next =3D folio_next(new_folio);
>>>>>> +
>>>>>> +			folio_ref_unfreeze(
>>>>>> +				new_folio,
>>>>>> +				1 + ((mapping || swap_cache) ?
>>>>>> +					     folio_nr_pages(new_folio) :
>>>>>> +					     0));
>>>>>
>>>>> While we are at it, is a way to make this look less than an artistic =
masterpiece? :)
>>>>>
>>>>> expected_refs =3D ...
>>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>>
>>>>>
>>>>> Can we already make use of folio_expected_ref_count() at that point? =
Mapcount should be 0 and the folio should be properly setup (e.g., anon, sw=
apcache) IIRC.
>>>>>
>>>>> So maybe
>>>>>
>>>>> expected_refs =3D folio_expected_ref_count(new_folio) + 1;
>>>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>>>
>>>>> Would do?
>>>>
>>>> I think so. Even further, I think we probably can get rid of can_split=
_folio()=E2=80=99s
>>>> pextra_pins and use folio_expected_ref_count() too.
>>>
>>> That will only do the right think if we know that the folio is not mapp=
ed and that there is no way it can get mapped concurrently.
>>>
>>> Otherwise, when freezing, we might ignore a mapping (where we should fa=
il freezing).
>>
>> You mean between unmap_folio() and folio_ref_freeze(), a concurrent mapp=
ing
>> happens? So that what folio_expected_ref_count() returns has
>> folio_mapcount() !=3D 0. You are right. Thanks.
>
> Right, but maybe locking prevents that.
>
> E.g., a locked anon folio cannot get migrated or swapped in. So the mapco=
unt cannot increase once locked. If already mapped, fork() could duplicate =
mappings, but in that case there would be at least one mapping already.
>
> For the pagecache, I think we always map a folio with the folio lock held=
: see filemap_map_pages().
>
> So *maybe* just checking folio_mapped() before trying to freeze could be =
good enough, arguing that the mapcount cannot go from 0 -> !0 while the fol=
io is locked.

Yes, but this is very subtle and fragile. I will keep the code unchanged fo=
r
now. :)


Best Regards,
Yan, Zi

