Return-Path: <linux-kernel+bounces-899872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC36C5909D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0C4A10F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0835F8A0;
	Thu, 13 Nov 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NXh+IRS2"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFD3587DA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052415; cv=fail; b=DIvjPuRvpOAe0u5t2b5pQC4NO3mhtK25NZvvLhbvYhF5TmoypXvRo6TV7x6hmVNwg/9TXGPajcb4uJZh31JPKm9o2+CO5DL8L/iFjIvOyanP2Wru/mzn7e0/oXn1/3q8+/O1cpO3jGHUUVoCLK9TS6GZoKTKdMqx0JPr01rikdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052415; c=relaxed/simple;
	bh=nU3x7VbZ/9V5Imron5pg0h00p3rZI5J3M+Fk1F5EMSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCSi+wDNuA6E8oc0bWp3CqmPPI87IB5FDPzpcfTrK+LvVt9O7WvYAPiOUNmehrC1ADsGBsYwfxRAHpPWwV/sX7Yml3AcqBpdJ+Gj7klENjeiDllVqAAP76pNkbhSpzOBSLLMDI0CWEYWK+hz/eABPnfuooI5oWxbNEb2PFiKvOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NXh+IRS2; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Knd7NWb8D1y/5a7d8kV46QpQQxp0xJ7jDMUT4xXVqcjhhq/zq4Cy3oi7TkzjBBr6ySbq2sGVoXkTEJL5vhcY7jGd5/GsVog2l1oimnhKL0Beeckt0DKr3P2DaDwDMRzsgO/o1vgbne7BJKlCckqBuohHICrnSZJBBR+SvmjPc4lmRVlKdt+taFqPiDF8eo1+jo5/4rC0DW3+bbG4j0ZvLxx9rC0EgwxdxtmjQbggOZ4emk+bbbrT5nAzj5bji+g+GRjJVjixix4EuOAd4jUT8vmhv/Z/3VPgOF+sLXKbwUKe8ogRUZQ3kbFDXejW+ieHMk+n9CtFyPfr7QkcrAoMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3+gRF1uA2WlFx60lyG3dyn95PsTvQ4PW/yrPw+qLfM=;
 b=TZUQwebR8AvT20eM9nltUj5bZEGBLCsRvFKLD6W7KsHOJfsQ5476BIWVVZ/wIU4FiNN9yLFHXEwVk9oapWjAxFybNQ4mZ/oD1tepb6URn2sDlpvrArM9WGlfbJiO5N2l4Txlei4A1sYCkZ175BFbzKo+k8vTrZjcQ349mM/7/gEiGAyMnRkjGBgwhgSsM0ydEjc0cmNtBiRNG3Vn1L+ZTP8QPu5Gzm9Yo71y0b0NUhlKmsxEEHE9vuW1txtzlAnYMKaI+cqcnH/H8ZyzXE7dhgqixnvOJHWrpuEVtxpRbkQPBYdKxGERigZVO4RopYqEzS8y75lk8XC3eh5PcvLVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3+gRF1uA2WlFx60lyG3dyn95PsTvQ4PW/yrPw+qLfM=;
 b=NXh+IRS2Ev3hSw/HjwciHQEr7cC2cIQzTA6jYE84d7yuB1fnhP6Pc8JiO4PG0/psWzqSFZmLbvwJPeJMLt9yCDv2Nw7o9dxKDTKX27tsSy3H19jJFUnIeQ2iP85RRsNUTU4w2i09JHn0DKAb65PJoEC4NBjTaEc7b/MTk7L9a8dMVgmCySWey16N7YazwDaIPDAn8pqo5Oqkzwp7KyCZFAW78XtsJsJ3ClHeaUkFgr6shWTZKzw+ffPxFjaMuuGKvXo0Sr96BIHBKmhE6pzQV+e381Odds2IpWx9RMK/rJFRG5fFcuZkaBzeDgVzLaCHpmwvI1Koyl/zuMK/+fJcYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 16:46:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:46:50 +0000
Date: Thu, 13 Nov 2025 11:46:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	gastmaier@gmail.com
Subject: Re: [PATCH] i3c: master: Remove i3c_device_free_ibi from
 i3c_device_remove
Message-ID: <aRYLc/+KAD13g7T7@lizhi-Precision-Tower-5810>
References: <20251112-ibi-unsafe-v1-1-d8454db22613@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112-ibi-unsafe-v1-1-d8454db22613@analog.com>
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a072802-bdc8-4add-3e30-08de22d43e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NURzVHFvMkg3bjl0Vm0wZDlNQkFCK0luc2laVVRXU1dPbGQwcTdkRlRKd1BX?=
 =?utf-8?B?alBEcnNGVmIySlhwZUxCVThYSEQxMmFOUVVIeEZWUzczREpncFdzN05HZzF1?=
 =?utf-8?B?OUppZ3F2TmZ1cHhQLzJGU0FzYUU1cSswZ0ZyWEtUc1I4dUZSUXV2TTlpSXhV?=
 =?utf-8?B?ME9XdEUvTVdKOXN3MlJpNFhUSlBWZnpIcDFldlBEaS9URVZqbFEwbnBTMlRt?=
 =?utf-8?B?Wm9hbVpOV2JTcmNiZE94eU83K2Y0Rm1aNWFtTkVGbllFcXdqYmhTN1llM3dj?=
 =?utf-8?B?K1dwUnJKVENTZkt5bk1pbktOZUNaYXoyZ2FJcllmV09wWURCQlFXSnJybmRl?=
 =?utf-8?B?R0xLc1duenlJc1hRaldpZ1Y5bGd5SWFYTndndmRuYzhDeHRsS21RcEsyUFNY?=
 =?utf-8?B?SS9WeFdVckpWZlowOFpTQ3VHQkFyOWpNbFp1a0NiSHJ6amF0bEY4MjdZWk55?=
 =?utf-8?B?Uzg0NkFSQ3pWTW0wV2xINHp6alZUbGN3Q1lFYU9leHpsTlpCTmFwaVhBYndm?=
 =?utf-8?B?VlcxR09JbWlsTkovMnh5NUJ5Y1ZjRjNBZWpqQXcwTk8vM2pNVU56SXBPQ3JN?=
 =?utf-8?B?eHJPa1dvRkZQOVRsNmtvQWF5S1Jxa2Y0czV5ZlExME1KWCsvTXE4MElvZXJO?=
 =?utf-8?B?Z1NITWhjRXNXbURsRXhPQjU1ajVwd09pLzhSMGhDUTVBbWVGMUNGOTNRYjNy?=
 =?utf-8?B?WXFETkQyRGlzZEdqOFl2TGxPWC95VUUySEhjYmVlaDF2TjY4YmszdzNud0pk?=
 =?utf-8?B?YllpMStTK2VuMk51WVRTMmhsMENkK2pZeDVNZy95NXB1bzdvMVNndnc1a1Ri?=
 =?utf-8?B?Zi9rR3NlSEdBdTBQV254VVlSR3UvL1J5bE5mRlVEcGxqeE9laGFVajBqZkZB?=
 =?utf-8?B?S3F3TVV4dWQrRDY5Ny9HUWZyZEI5b1Npby9PeXEvamw2MFppSHhjS21yU0JJ?=
 =?utf-8?B?VmpheXhIQXBua2V6S1Z4dVlLMzQvaEVHcEJwcURCaXcxZ2sxSGdkbmRmcmxF?=
 =?utf-8?B?WW9IWWZBOW1mYkFOcWRCNDdhRXlMVWpkbFdiU2NzeVJ5allqR0RYQXYvRFdB?=
 =?utf-8?B?d21YOGF1eGhGclBiZlZpZUgweVZWd0FhaXpCTktQd1oraDVKdXp2U1I0cE5m?=
 =?utf-8?B?eDlFdzM5Vlhsc3hnUHBDdnd6TUtLaUF5VFNEYmliQThtRlBLcmNVQmkySXEv?=
 =?utf-8?B?dWFsYTJzQUVLc3Zad3FRZFVkOHR3SlFmZHo3cTJMQXpkM3ZCZ3VQNGl2dnV4?=
 =?utf-8?B?bjlzSWdkNjRsYVRZSko4WEg2cVBsVWpEdDYvbGhKcjExVlFzbFRGYzAxV2x0?=
 =?utf-8?B?Q0JqYnkxamJsSkliOERMZ1lLS0RiNWlJUzdFSGdtR1FJelA0OFp6RG5mK1Na?=
 =?utf-8?B?cStIRnd3aGlESmtPZjM3NlFsU2JmaEZnRFRwb2hLMVBEVk9RRU10Q0dFdFF2?=
 =?utf-8?B?RklWUlF2WFRuOVp6NExlQ2JHSzBhcWQrckszcDJrNlZsWThUektsZCtpa1l2?=
 =?utf-8?B?d0p0cDJ3dHgvOE1IWEFHT3NTQVBpQUNoK3RlVXl0VHhqVS92OEsvZ0xvQ3BB?=
 =?utf-8?B?YXdGejhLZU80QU1qczdSMVF4TE8wbEdkZ3R4dFlhUjBXbWk3Rko2UVFYU2ND?=
 =?utf-8?B?VzNQZ21maXhBbjZsY3BITnVoYXVoUEZ2QUZSSXRhRFhJT1RqOVpzbHRPZ2tp?=
 =?utf-8?B?Yi9DTzh1ZFpZUFF2czdaZGljWHAyZ3lMTERBN1Nya1NJdXU5SUo3UlV4Wi9O?=
 =?utf-8?B?YjZXV25qVTFVeDVtVTVjV3RYUWx4WE56ditjMjJvUnZrWlJDMzJ4VjNUYnZj?=
 =?utf-8?B?b1JtV2xZbStXR3NsYWMvaG1uYzhwOTM5cGlrVzR3MDZtZHE4R0Fva21GNUFO?=
 =?utf-8?B?VVE2VUF5Y21sR3NZQXBjZFZPQnpIeDhKcktRV0J1Z2ZTdkNFdDJURnVtOWsx?=
 =?utf-8?B?VVFsSkI4T2tTOE5QQ1hubGJpenlWZm1yYTZjb25XMFMyYWg0UG45djBkWmkw?=
 =?utf-8?B?d2gzbHAwRVpmTmROWGNnTHBGcjRoSlRVNzZBdnU2a1BBZy9keDV1eGp6VHBZ?=
 =?utf-8?Q?S0yfHk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU9nRDAxS3MvYWVaemJOYm1YL0xKZEZXRkZTdm1CclczVjVJbGdiZzRzVGZX?=
 =?utf-8?B?U1lWcDd2N2VLWG1zd2k0cGdzUTRrbGkwRlNVUUZiYnhtdXZhMTBwOHBDNUhN?=
 =?utf-8?B?YjZOcW53VktHdlV4VUYvWlpqTEVsSXd3aTNNdnpoRWxjWSs5KzI1b2dFMWxZ?=
 =?utf-8?B?K1VRUXN2a0hTZE52bDAzR0FTVUg0RTEwMnh6cklEZ1dDOE1lUWZEK2lpc09s?=
 =?utf-8?B?QWp0QXQvYnQ2aXRud0Q5NG5keCtyL2J4L1BPRXpWZkpjL2ZYekJHUTlGWGd1?=
 =?utf-8?B?WHFPN2FyVm5IUVR4c3l6bGlSNjltMjZoclhRSHhjcmxzN2s1N216SmRvYXJu?=
 =?utf-8?B?L0NRaVlIUXVuR0pNVjAzR05KL3NUbzVrRk9mUE9BVVZJYVVIRU5XUEI1Ykd5?=
 =?utf-8?B?Ylp2NGJuQ1FUamo1aHorL0czWEJ1Z1VMK1FvTkhrVVlFK0NxL1dYMXFNc0FK?=
 =?utf-8?B?VE1Dcm1xeWtvMVAwb1RVRGMwbEZYbW1lODU3bG1UcnpXdytKNUZHOWJwL09P?=
 =?utf-8?B?SHRoa1BndDgxNUlnTjYwQW1jN2ZiYjF3ZjFTUDBPa1k1blNET2pDNTdTejdx?=
 =?utf-8?B?VjJCSVV5d1BxRFVVQTV0TGV1QzVnVm9WZnlKbFgvdEVVa3M4UVFheWx0cGJQ?=
 =?utf-8?B?WVc4YlB5bVRnT1N1amlqL1RUVEFscjFLT0hvZDV3Z1N6LytVdWI1Rmp3VWhO?=
 =?utf-8?B?Mmhhd0xJbUpLd3BMbzRSZG55eEh2YnVtVmRCWGZtblNrNGVXVkJXaXZhRUVT?=
 =?utf-8?B?VjE5VWYwUkFGMzZ3bm5yUGpMdVN0R1I5MUlTWlJYdFlrL2xFR2VmVkd5MWw5?=
 =?utf-8?B?WmxwRlZCdUdmRGpxRXA0MTVFNUpiemJPOUt1UW15S3ZscWpQWXdmeFdYNmk0?=
 =?utf-8?B?dnVaQUJUVVY2VTZPMDNsUHd5d0J2aWRYRzNLYjlNNzlCOGV2R2xsKzlzMTh5?=
 =?utf-8?B?QXloNWRxSkk0OUNEOFd3UkdKR0ZWYitKUkYzUndEeXVxUkNWZHRJMTZjU0Ix?=
 =?utf-8?B?QU9lZXJuQjZmUHR0TVlZWnB5VjEvU0pIbFhwZjVXTUFaWTR2SWs2eVBiekFk?=
 =?utf-8?B?TE1BNm5mN2FFdnZ4SkpldFpoSTRVSWZsSi9MSVNmMzF1SjVZMUFsNStDM2Fj?=
 =?utf-8?B?d2F4QmNZbHkzQVo0SXdOVWx1L0k2RWVxcmZ5QUJzL09LMGdkUWpRQ3YvWTVi?=
 =?utf-8?B?dTQrQjY5MGJ0TnlDWWJDSFQ1MGlTbmxNWG9kcks3YW9makJnWEIvT3BUb29W?=
 =?utf-8?B?K1ZHbjhGd3kyTXBVT1lYTUVicFVKOFZ0MkVLWndYeU1zWUpMQVQrU2JVZHFQ?=
 =?utf-8?B?b1VrdVRwdVNqWlgwQkkwdS9sYmxib2NSYzZZdDVqZDE2R1FReG5sWlIxS1BK?=
 =?utf-8?B?TkwyU3FlV2VJaTBjcVB6U041b0tQd1d3Q2tQOFVWN1lRVXdSK2FHVTNoUUFi?=
 =?utf-8?B?SElPaXdjeWQ0VlAyQTJyQksyZW80WFBRVFlySTJJOE41d0w4UlVwTElNS2NI?=
 =?utf-8?B?bjFIckZmZm54QkNRdnh0R2sxSFNuU2RDVVlCVDhQSWxwZ0RPdDRLZ01hdGhr?=
 =?utf-8?B?cWw1S003djVtd3NvZ1F4dXlUZ0NnTkF2S3NZL3J6cjZJR3Z2MWp2cHFUa2My?=
 =?utf-8?B?SFhvd3JEL0tSaDJVMEhzQkVMUlY5QTVsOUtDTXJxamlRZS9ERVB3L1pIUEtU?=
 =?utf-8?B?TEFXakNWUGw5SnhrcGJhRThZZXR6OTJsZkRDMFBXRGllOXhkamYxWkNpVW93?=
 =?utf-8?B?M0p0c0hZZURYSkp5YnJFSjVZMEgxd3liSnhmeTFGVGlqVk1HbFhyZlcvK0o1?=
 =?utf-8?B?dmJ1a1d6ZTNkWnE4TjllR0JoallGbmZGYlhoQnlET2hTN0VGM2E1YkRUak1a?=
 =?utf-8?B?MWY1ZndKUy8vdGJ1V3o2Q0tYMG9DenFiZyt2RFFYaUJOYlNNVlhLb21oaDJj?=
 =?utf-8?B?ejQ2YTV4YjlqcHZObzZDOVVPYWR6MS9nRjRzQnIxdktCKzJJeVJscWFGYXBM?=
 =?utf-8?B?UTYxY1dJU0k3OE4wZHg4MXhmMDR1VTN4S1p3L251STdVeEZsTUpXK1JNVXdX?=
 =?utf-8?B?elVEV1p1cGY5RXQwTDlVOURjY2RGcytvZ1FINEtNNHFqZmlNRW9hbWd5b0xy?=
 =?utf-8?Q?5iHbWoBf3Md1M7Sa2nbnQ0s12?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a072802-bdc8-4add-3e30-08de22d43e27
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:46:50.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8eX2CLILHcQ3i8awUo5WXDoYcZinpO3T9ULAt/i/8PxlzFnrOGiIpg7tCOYB6NoVetdDeI2UfCeIiksBKQ/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046

On Wed, Nov 12, 2025 at 10:30:00PM +0100, Jorge Marques wrote:
> i3c_device_disable_ibi should be called before i3c_device_free_ibi,
> however, a driver using devm actions cannot yield the call before the
> bus_type.remove(), requiring to use a .remove method that is usually
> discouraged for drivers that uses resources already manage. Since the
> only consumer mctp-i3c.c of this method calls both
> i3c_device_disable_ibi then i3c_device_free_ibi, remove the call from
> the i3c_device_remove (bus_type.remove()).

i3c: master: Remove i3c_device_free_ibi() call from i3c_device_remove()

The IBI management functions "i3c_device_request_ibi()/i3c_device_free_ibi(),
i3c_device_enable_ibi()/i3c_device_disable_ibi()" should be handled by
individual I3C device drivers rather than the core framework.

Currently, i3c_device_free_ibi() is unconditionally called in the framework’s
i3c_device_remove() function, even if i3c_device_enable_ibi() was never called.
Although this has no functional impact (the function checks for NULL), these
calls should be symmetric and managed by the driver.

At present, only mctp-i3c.c uses IBI, and it already handles both
i3c_device_disable_ibi() and i3c_device_free_ibi() properly in its remove path.
Therefore, it is safe to remove the redundant i3c_device_free_ibi() call from
the framework.

>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
> As is, if i3c_device_free_ibi is called before i3c_device_disable_ibi,
> the following exception occurs:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 12950 at drivers/i3c/master.c:3119 i3c_dev_free_ibi_locked+0x84/0xb0
> Modules linked in: driver(-) at24 regmap_i2c regmap_i3c adi_i3c_master nvmem_axi_sysid
> CPU: 0 UID: 0 PID: 12950 Comm: modprobe Not tainted 6.12.0+ #1
> Hardware name: Xilinx Zynq Platform
> Call trace:
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x54/0x68
>  dump_stack_lvl from __warn+0x7c/0xe0
>  __warn from warn_slowpath_fmt+0x1b4/0x1bc
>  warn_slowpath_fmt from i3c_dev_free_ibi_locked+0x84/0xb0
>  i3c_dev_free_ibi_locked from i3c_device_free_ibi+0x2c/0x44
>  i3c_device_free_ibi from device_release_driver_internal+0x184/0x1f8
>  device_release_driver_internal from driver_detach+0x44/0x80
>  driver_detach from bus_remove_driver+0x58/0xa4
>  bus_remove_driver from sys_delete_module+0x188/0x274
>  sys_delete_module from ret_fast_syscall+0x0/0x54
> Exception stack(0xe0d09fa8 to 0xe0d09ff0)
> 9fa0:                   004a2438 004a2438 004a2474 00000800 00000000 00000000
> 9fc0: 004a2438 004a2438 00000000 00000081 00000000 004a2438 00000000 00000000
> 9fe0: 0049fe10 bed2b73c 0047f0a5 b6c26168
> ---[ end trace 0000000000000000 ]---
>
> Forcing drivers to set a .remove method instead of the wrapper
> devm_add_action_or_reset, due to the call order.
>
> I believe the best ergonomics is: if the driver requested and enabled
> the ibi, the driver is responsible to disable and free ibi.

I agree. it'd better add devm_* help functions, simpify more error handle
patch.

Frank
>
> The usage looks like this:
>
>   static void driver_remove_ibi(void *data)
>   {
>           struct i3c_device *i3cdev = data;
>
>           i3c_device_disable_ibi(i3cdev);
>           i3c_device_free_ibi(i3cdev);
>   }
>
>   static int driver_request_ibi(struct i3c_device *i3cdev)
>   {
>           const struct i3c_ibi_setup ibireq = {
>                   .max_payload_len = 1,
>                   .num_slots = 1,
>                   .handler = driver_ibi_handler,
>           };
>           int ret;
>
>           ret = i3c_device_request_ibi(i3cdev, &ibireq);
>           if (ret)
>                   return ret;
>
>           ret = i3c_device_enable_ibi(i3cdev);
>           if (ret)
>                   goto err_enable_ibi;
>
>           return devm_add_action_or_reset(&i3cdev->dev, driver_remove_ibi, i3cdev);
>
>   err_enable_ibi:
>           i3c_device_free_ibi(i3cdev);
>           return ret;
>   }
>
> Best regards,
> ---
>  drivers/i3c/master.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 66513a27e6e7..a0fe00e2487c 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -334,8 +334,6 @@ static void i3c_device_remove(struct device *dev)
>
>  	if (driver->remove)
>  		driver->remove(i3cdev);
> -
> -	i3c_device_free_ibi(i3cdev);
>  }
>
>  const struct bus_type i3c_bus_type = {
>
> ---
> base-commit: ddb37d5b130e173090c861b4d1c20a632fb49d7a
> change-id: 20251112-ibi-unsafe-48f343e178b8
>
> Best regards,
> --
> Jorge Marques <jorge.marques@analog.com>
>

