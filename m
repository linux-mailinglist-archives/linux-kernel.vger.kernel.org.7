Return-Path: <linux-kernel+bounces-756809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FBB1B992
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65E918A46F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029D292B3E;
	Tue,  5 Aug 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="etR2Lwnz"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2120.outbound.protection.outlook.com [40.107.101.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1B295DBC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754415941; cv=fail; b=jduGdzuTUhlisTT8QLgQZn/uvD5adEGL2uPz3BU1sinkf1Z80HwpDRwk6e7gxxBHbblgXI8WtY1nkkGP+atTEEz28M7ro4kW9C+HCCheseanKgRrb01BEVjguj2NQJ+1DIq0UTLOQd4znWPd/vK3kH1D2DApktTx1HGnfiF6p20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754415941; c=relaxed/simple;
	bh=YLrkBJHl1V0Km/GGGHzyQ78cb0BcuHKdr9DTb2v/rpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iKbK0X8A/1ki5cRbRZxjHEocnTFYlbnACekJlkZxfveFC+WC8/ycy29TvuVv81NzDxizw+JMzdcKRXhQGb21tFx7X/c3a8RL/8h9Twx2rbXgXzlROl+hmJKi531ZVa0TKlRA94PzZ0+210vnLlmLKRMkfh4CyO2XbUXfzeNNqxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=etR2Lwnz; arc=fail smtp.client-ip=40.107.101.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/QtBW3DLqwYYlGD6Z8uc1HTiO5iruN07CoTWuPvKiQTd3ye5P59CLZFeY2BGd1cjLMuSJpG3T4pW6/vCvNlN+FNlNRSt8bO0wElvH9B5tbgt790DGGooL8rol90bc2TJX85pPR+4tH1lbSCzWbFcR7iVTlH5RpnjBOllANJKmmotZARUz9CEtlQaij3t5gSxF1JrxskOWxfNXYdvwkT42gUiwOFpnJ+26GNJUHJCfHwuFf4w6kDVQctosA/Iv3kszsPYUPAT7+iO+ctTNtaGBaWrWku2O7095+UU1VhFctmsXijR+Z2QMjpap58WUM7XkOKzLGnZpM9Vqj4qvloyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWehGQL4vGGZzl4IyCkZ85Qzq66gqpTWKDjXRfg7tYU=;
 b=lPIr+ngk1EiDaSuDIWjL5XWm41bp3IWyO6qqeQvWuKLHkB26/CiWEU81zDXEiWuOy3A1LN0uv13S1l5cdWTsl2WaSoXwp39UV6BC4jsS9JUvOuUfbUNgsZBULcMDps0wXoTvHsJyHRHHvek/bqlKA9mFnbkk7dX2TAY+vnmewMHSD6s5tExA2fJR95q55olvzbZdiM4kqmEiVhI/RxCyfhi0GBgtO1epDgw1DKuRd37xT2RUKbFV29PSW1Rhv/cnvCXvnCU8aymiXxulWtW/l3PqKX51cnXOHk6gHiocKS7I6Em5v096QlzsVG0m9m3DvC4ylyCQdXkyVPp5DyN9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWehGQL4vGGZzl4IyCkZ85Qzq66gqpTWKDjXRfg7tYU=;
 b=etR2Lwnz724ZmUa6vcJIW5/6iifhntjlyaFD356HGoYgPokfqnYUzL94bRHp/GeJRS9u0LUt3S+MIlg48dUM7L6NGMT/hEeAWUag+XNaNtGeOqd1Rbdf3tnUHaMTABLkeOXvnNGF0Yeg+ErE8UmymYn1701zeOwpsh2nZZkCQHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BN0PR01MB6894.prod.exchangelabs.com (2603:10b6:408:168::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Tue, 5 Aug 2025 17:45:36 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 17:45:35 +0000
Message-ID: <1a4dc965-511b-4638-bac1-03f36d044141@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 10:45:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: mm: split linear mapping if BBML2 is not
 supported on secondary CPUs
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724221216.1998696-1-yang@os.amperecomputing.com>
 <20250724221216.1998696-5-yang@os.amperecomputing.com>
 <86d3af99-0011-43fc-9533-4d51ffcc9a0a@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <86d3af99-0011-43fc-9533-4d51ffcc9a0a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:930:8f::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BN0PR01MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: e124d065-c531-470e-f93b-08ddd447e1d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1ZQUVBzS3VwbmJqZXJwRWtuNTNiK3NUdlgxOU9TYW4wSThtdWVMOHdabWRG?=
 =?utf-8?B?N085ZHR1cEtYODM2cVhucmp2NERPbjdBc3pvRHNDWlI3NmxacHI3K2ZKa2Mz?=
 =?utf-8?B?M3doem9BdmFnY251bjNCU0N4Y2E0UDNzQU1oWHFPRlBtaDNmbVVONm9BUmhR?=
 =?utf-8?B?MVpFVTc4SS9aNVE0Qm8yQUk2OXJMRlo4T0dTL3ZJZ1l1VkFMMTRJb25TUGp5?=
 =?utf-8?B?ZWhRaU9FVUVnWGtYVmNoMW5EdmsrUERGZ3RZVVYvT0xkOEo3MFZXTW1QSkJx?=
 =?utf-8?B?Sm5KV1RRRWJodkxVc1haaFoxT1BoN2Y2RitpUThjTWRpbGllMnJBaWFqNHNk?=
 =?utf-8?B?dVc2emR6ZWcyWkhZUjNFa0JnVXF0Vm0vandZbWJwS3NKbnFWRW43eFZhcTBw?=
 =?utf-8?B?bjVwZGNnWFllMnQwelNPYktFWDNDT2xFN1dVdjIxL2hyVmcram9nMWFQUE9V?=
 =?utf-8?B?RWlYU054c1Bid1B3cGdiL0RWWnIyUVFMK0p6WS9CS0RYUVBqNE13V1hHL3Vs?=
 =?utf-8?B?QWp2Qm5sTGpMUWpIaEtmMUxtTGNWWUNmcjZ5aGZUNWFCTGM2THArd1NMbjYy?=
 =?utf-8?B?eEo1UXpaSU4zVEFycjdSMEFIVkl5OS9jbTlIOW5Qb25leUJlU0ZiR3BJdGdr?=
 =?utf-8?B?clJVL1d3ODhZK3UrcFFDRXNzdG5RSlNaSlcwNU03Rm1hWkZWTHQ3NW1qVVNi?=
 =?utf-8?B?Zk1FdW1SLzMrcWQrZjBPczVuRmhUMjZwY3Z0Q1c3eEljVnFVaGlmZWk1bnM0?=
 =?utf-8?B?ZFMzMnpDYVJYSTk3VWVJb0JWRW83aWNQS3lvcnNPWGtUdVZvRUZsc2xzQkdN?=
 =?utf-8?B?TFExejBVcTR2eXRtWHRnVkZndUxlOWtRWDNiai93OE5YQ25qc1lqT1pSSmZQ?=
 =?utf-8?B?WmdzeFhYUHIzeG9Wem1PSEp4NElNT0Z0N0NDQXNOTUk5RVB6S2MyRTdUZGI0?=
 =?utf-8?B?ZU1hVmp6clY4ZjhKWkZOTWdaZ2R1U3VnSDk3bmJnc0FhTldSZ01jN290a0wx?=
 =?utf-8?B?WXh6U2Q1MGNEaXdyQ0VTL256bkN2K1pURWF5dVdnVHBUSEx2Tlh0M0Y3QktV?=
 =?utf-8?B?ai8ya1U4T3hQYWNZRU8rR01TWFRHTjZrU0JYeC9WSC9iZWZYeFBPYm9wVlM3?=
 =?utf-8?B?Qk45bkphZDNtZWJEKyt3aGNZYUxMcEhUcEhWQlZwY2svWjN1alhFTTJOT1dC?=
 =?utf-8?B?d0VIbmM3VWhlbXkvR3hEMzI1ZUNFUlRmZGdBUmlOd01jSUJ4OWxJWkpXdGNM?=
 =?utf-8?B?QlpZZXRpVmVtT3REa0N6OWlmblU3VHl2d1dMOVdqdVNmVEd1dis2MzdqSlRw?=
 =?utf-8?B?RUxRbXJ3UFN2MjZONmhGdHYwNWRSTXdrT3FhRmFpakFPbW9oSjl1MEVxT0Q0?=
 =?utf-8?B?WkJEMEEvZjRoT0ttZ3kyeXlsQVk3MHdnZDlJcTZOQ0ZMUnIwbmhIa0s1bWdW?=
 =?utf-8?B?ZUh2ZzNBZElMNnRXN2N1ejkwWWdON21OSDFTSEFpTFVHY0dPM2drRDErWjFK?=
 =?utf-8?B?RktCdVBhWkk4U2xDQ3JmLzRzZ0Q0RGwwZTBORGxybURYNEsrTmxPWU85a1p4?=
 =?utf-8?B?S2Q5U0ZUTFdRK0E1UFJ3Y0tnUFEwaXpGcUc2ZEcwNHJ0QUFUOVRHTnEwR0dQ?=
 =?utf-8?B?SzZLZ2ZaNTN0bldETHJIUzRVeHhFaG4xSW9mNHB4YU9ZY01BTG1PSEZ3bWtk?=
 =?utf-8?B?d1NUZVVWZk1FemlhQ1M0RDNvV01YT29YU1FqS1orZ3ZraHRhS2ovV21aOWs1?=
 =?utf-8?B?Zi9UOXhEQlBZREF4N2Zic3c0ZGlaSTIvRUNzOTd1VDFmdld4N3pVSm0wVFRJ?=
 =?utf-8?B?UVBmKytlM3pjVVlNa1A2d2lnRlViUWtUYm1jSkU0SHEraVpLMWticDk0VjQx?=
 =?utf-8?B?UXRaVmFicjZGdzhwM3plR2ZjY0syMVlPeTVQaDJhWWdQbVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0Y2VWp5dEkzM01FTkE1L1BaYWh3QXRsdVlLSDVmKzlGQ1R5Vmh0NURxWHkz?=
 =?utf-8?B?NzBhL1JZa0xUNWg3eElHZmdFY3dIbzM2aEV3cUZ0VWw2bFRUeldaRzlMUFh5?=
 =?utf-8?B?MjdVcGNwbSs0YnVnWXUyQnRwTmRNc2pRQWg3TVFsY2M3Y09uSUNWSFBPcEZS?=
 =?utf-8?B?WldTV0YrbU95c0hQR0NzWEtHY01zVUhWVW8zOGx1bjNZQkF0RzVsVmtmRm9y?=
 =?utf-8?B?QTJUU1IwbU1hVmdHbjlxNmFyaGtlTk02em1PbmJGeGRjZ1VUZEhNd3hBYkVE?=
 =?utf-8?B?dGZZZWRzb0lHd1dNZVZBNm5LSk9RSkVlTDc1R1FXczJqaWk5SE1OS1EyNkdH?=
 =?utf-8?B?dUIwcGM0NHAvYzEwamU3Z2FySzNCWC9BYVlJNWpES0tUbFFBY2xlS2cwMjBC?=
 =?utf-8?B?a2xXTkNVUE1EMXVCVlVPZ3c0STRiZWZVVWgwekFJVTZpTDhDZzRtSUFRSStk?=
 =?utf-8?B?V3A1eHBSRERpa2kyQ2NoMmZKV01TQy9udTRWQnJYbC8ycG1jK2Q5QmZGT3Nu?=
 =?utf-8?B?M3B6dTVIY0hHMEhObVNRQlRJUU9YaHpaTElKRmhxUjRsSzBPT05pSnJVZ0hw?=
 =?utf-8?B?eVRvbzdCb1lTNjJNZWFjdUNnQjYrWS90djYxZVBlQ01xUUc2Qk5hSVJqbzZS?=
 =?utf-8?B?dW9QMDlIb3lQVk9iZ2Z2R1hUdXh5ZWVHZ1ZZeVVORm03MzVZYkRLa0RoZ2Ni?=
 =?utf-8?B?OUh6VHE1V0FWZ3JpZ1BQSG54Z3RJN2xlVkUrd0dWUEdTWUNtTUdaa2VXaC9S?=
 =?utf-8?B?cXBrakNEQVZycW5KM2V4eU9yYWF0dkFVRTRabTlpM2dabmFjNEZ0ckV3WW5l?=
 =?utf-8?B?RnBMRng4M1gvTHVGZ1UreUhDNGwvNGxIaDM3TWdhNW9kUzJIbm51TEpBY05Q?=
 =?utf-8?B?ckZLV1k1TmZLK1orSXE5aU80eHU2YXUvMXdxREhTOTNDTlNScnJ3OHdLS0Qy?=
 =?utf-8?B?YkpWRTZ0anJRUno2ZFlKb0ZpN2JhMjM3VzZiSUl6RWNkUEQvR09OUlFsUjdN?=
 =?utf-8?B?WTBTeTIxOS9xV05MNFA2alh5Ry9jMW1ZSXJ6VXBGUzM2SjNoUWtoTnRlV1FU?=
 =?utf-8?B?Q2hKZkh1ZVd6akJZZnpOdzJodW5HT05kV1BNS09US0hubjFOdHVVekVFTm5C?=
 =?utf-8?B?RUh0VlM4VnRNVFdsajRXY2hPVEphM2s5bmtJYnRURU5Gcit3WkowT3RrOSsw?=
 =?utf-8?B?ZUNuazFBR2xIdUpYUHNrRzBsL1dPYm9yTjZra01iVlBOVU83QUFDellQYVdp?=
 =?utf-8?B?L3JHOTlYL1F6d2t3bGY0eUxraFppc25SWnNqV3VwbmFoRjNkaXJwOVhubHNH?=
 =?utf-8?B?K0M4VG9kMndtVXVlYmRTZXEvL0pZTXhURmc5SW56K0lpRkpveVFBQ1JOU3RH?=
 =?utf-8?B?Zk8yUXZ3UytwWFdYUUFwN2lqWmdZVnA0NGg1dFMwN3lEMUlaWXovU2xhU1l6?=
 =?utf-8?B?ektYOFpuUUZBejYydjJDRGxqSzFxRDhwcUxOSm5EUXg3N3lrbE82dFdrMkNZ?=
 =?utf-8?B?VnFIMmlBL05sTFR1QnNwRlpZcnF2aEJMZXl4WlRYZkRxSkdKL2c1eXg1RjBC?=
 =?utf-8?B?Y2RQRmN1Mmw4UWpIODU0OGRFZ0VtQWZuYVRVWTYvZVZMakQ3TVBHV29pWXU2?=
 =?utf-8?B?TTNqRldaSTdUTCtkOEZjWHNKZTBid1B5eGJKcncxejVHYnAzbWRUQlRBS0Ft?=
 =?utf-8?B?eEhZdnFQMEFBRU9sSTZSZi9pOW5DcVRDZmNsNnN4M2VoK1JtVFREU0hMbGJW?=
 =?utf-8?B?NkJhaFR2WmlaM2dPOUJLdWpkWkxleUUxS1pxVlo0TWtUWXR5cEp5ZEs4OFds?=
 =?utf-8?B?bHRDaTd1S20yczA3dEpTTHViRmliY2FKcHlidmRyN1hJK0REMWloU1ZqSVF3?=
 =?utf-8?B?ckYwWlZsd0ZwU1BhUFdqTk9VdEhDdnAxb3NTdHJrcDlMME5aVk1kdmwvSVhV?=
 =?utf-8?B?cTIwc0IrQnpTbVowK2VvN3JxcUVmKzR3R3F6NFAwTXVPT3RRaXc1bmpPMHU0?=
 =?utf-8?B?azdCN0FnRDYzRGpGeUxwRDZBR2sxaEdLam1Cc2pCczZ4QncwclhRZUFYa1VC?=
 =?utf-8?B?S3hnd3JEUFJXWFNwazZrb1BwRXkzZGI3Z3BMVVBwb1BFWmQyRWNXbEp3MGZH?=
 =?utf-8?B?Qm5oU1UwL2FoOW9yLzBXMnA1eE1tckNqSnhwQTRTQmZPazBVQ2xpVjREYkc5?=
 =?utf-8?Q?WASRFr8xylZdbP3m8znheUc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e124d065-c531-470e-f93b-08ddd447e1d9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:45:35.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW2HpKK4FBlK2ZfrFlsdfCbqyh8ShfLjnpbLttvQ9lBT4QEc7yIwS7t101iRQwHbjG7HVqKVJrdp0X8xVxhTbOKH8ZAt9xm/aTzt8JmWAQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6894



On 8/5/25 12:54 AM, Ryan Roberts wrote:
> Hi Yang,
>
> On 24/07/2025 23:11, Yang Shi wrote:
>> The kernel linear mapping is painted in very early stage of system boot.
>> The cpufeature has not been finalized yet at this point.  So the linear
>> mapping is determined by the capability of boot CPU.  If the boot CPU
>> supports BBML2, large block mapping will be used for linear mapping.
>>
>> But the secondary CPUs may not support BBML2, so repaint the linear mapping
>> if large block mapping is used and the secondary CPUs don't support BBML2
>> once cpufeature is finalized on all CPUs.
>>
>> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
>> same BBML2 capability with the boot CPU, repainting the linear mapping
>> is not needed.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/mmu.h   |   6 +-
>>   arch/arm64/kernel/cpufeature.c |   8 ++
>>   arch/arm64/mm/mmu.c            | 173 +++++++++++++++++++++++++++------
>>   arch/arm64/mm/pageattr.c       |   2 +-
>>   arch/arm64/mm/proc.S           |  57 ++++++++---
>>   5 files changed, 196 insertions(+), 50 deletions(-)
> [...]
>
>> +int __init linear_map_split_to_ptes(void *__unused)
>> +{
>> +	typedef void (repaint_wait_fn)(void);
>> +	extern repaint_wait_fn bbml2_wait_for_repainting;
>> +	repaint_wait_fn *wait_fn;
>> +
>> +	int cpu = smp_processor_id();
>> +
>> +	wait_fn = (void *)__pa_symbol(bbml2_wait_for_repainting);
>> +
>> +	/*
>> +	 * Repainting just can be run on CPU 0 because we just can be sure
>> +	 * CPU 0 supports BBML2.
>> +	 */
>> +	if (!cpu) {
>> +		phys_addr_t kernel_start = __pa_symbol(_stext);
>> +		phys_addr_t kernel_end = __pa_symbol(__init_begin);
>> +		phys_addr_t start, end;
>> +		unsigned long vstart, vend;
>> +		int flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>> +		u64 i;
>> +		int ret;
>> +
>> +		/*
>> +		 * Wait for all secondary CPUs get prepared for repainting
>> +		 * the linear mapping.
>> +		 */
>> +		smp_cond_load_acquire(&repaint_done, VAL == num_online_cpus());
>> +
>> +		memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>> +		/* Split the whole linear mapping */
>> +		for_each_mem_range(i, &start, &end) {
>> +			if (start >= end)
>> +				return -EINVAL;
>> +
>> +			vstart = __phys_to_virt(start);
>> +			vend = __phys_to_virt(end);
>> +			ret = split_kernel_pgtable_mapping(vstart, vend, flags);

Hi Ryan,

> I've been thinking about this; I think the best approach is to use the pagewalk
> API here, then you don't need to implement your own pgtable walker; you can just
> implement the pud, pmd and pte callbacks to do the splitting and they can reuse
> common split helper functions. This reduces code size quite a bit I think. And
> also means that for split_kernel_pgtable_mapping() you can just pass a single
> address and don't need to iterate over every entry.

Using pgtable walker API is fine to me. The biggest concern is how to 
reuse split code for repainting. I think it basically solves the problem.

>
> I started prototyping this to prove to myself that it is possible and ended up
> with quite a clean implementation. I'm going to post that as a v6 RFC shortly -
> I hope that's ok. I've retained you as primary author since it's all based on
> your work. I'm hoping that the posting will speed up review so we can hopefully
> get this into 6.18.

Thank you for making the prototype. I will take a look that and reply in 
that series directly.

Regards,
Yang

>
> Thanks,
> Ryan
>
>> +			if (ret)
>> +				panic("Failed to split linear mappings\n");
>> +
>> +			flush_tlb_kernel_range(vstart, vend);
>> +		}
>> +		memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>> +
>> +		/*
>> +		 * Relies on dsb in flush_tlb_kernel_range() to avoid
>> +		 * reordering before any page table split operations.
>> +		 */
>> +		WRITE_ONCE(repaint_done, 0);
>> +	} else {
>> +		/*
>> +		 * The secondary CPUs can't run in the same address space
>> +		 * with CPU 0 because accessing the linear mapping address
>> +		 * when CPU 0 is repainting it is not safe.
>> +		 *
>> +		 * Let the secondary CPUs run busy loop in idmap address
>> +		 * space when repainting is ongoing.
>> +		 */
>> +		cpu_install_idmap();
>> +		wait_fn();
>> +		cpu_uninstall_idmap();
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   #ifdef CONFIG_KFENCE
>>   
>>   bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
>> @@ -1079,7 +1174,8 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
>>   		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
>>   
>>   static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
>> -	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
>> +	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
>> +	  bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
>>   
>>   static void __init create_idmap(void)
>>   {
>> @@ -1104,6 +1200,19 @@ static void __init create_idmap(void)
>>   			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>>   			       __phys_to_virt(ptep) - ptep);
>>   	}
>> +
>> +	/*
>> +	 * Setup idmap mapping for repaint_done flag.  It will be used if
>> +	 * repainting the linear mapping is needed later.
>> +	 */
>> +	if (linear_map_requires_bbml2) {
>> +		u64 pa = __pa_symbol(&repaint_done);
>> +		ptep = __pa_symbol(bbml2_ptes);
>> +
>> +		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
>> +			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>> +			       __phys_to_virt(ptep) - ptep);
>> +	}
>>   }
>>   
>>   void __init paging_init(void)
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 6566aa9d8abb..4471d7e510a1 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -140,7 +140,7 @@ static int update_range_prot(unsigned long start, unsigned long size,
>>   	data.set_mask = set_mask;
>>   	data.clear_mask = clear_mask;
>>   
>> -	ret = split_kernel_pgtable_mapping(start, start + size);
>> +	ret = split_kernel_pgtable_mapping(start, start + size, 0);
>>   	if (WARN_ON_ONCE(ret))
>>   		return ret;
>>   
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 80d470aa469d..f0f9c49a4466 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -239,6 +239,25 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
>>   	dsb	nshst
>>   	.endm
>>   
>> +	.macro wait_for_boot_cpu, tmp1, tmp2, tmp3, tmp4
>> +	/* Increment the flag to let the boot CPU know we're ready */
>> +1:	ldxr	\tmp3, [\tmp2]
>> +	add	\tmp3, \tmp3, #1
>> +	stxr	\tmp4, \tmp3, [\tmp2]
>> +	cbnz	\tmp4, 1b
>> +
>> +	/* Wait for the boot CPU to finish its job */
>> +	sevl
>> +1:	wfe
>> +	ldxr	\tmp3, [\tmp2]
>> +	cbnz	\tmp3, 1b
>> +
>> +	/* All done, act like nothing happened */
>> +	msr	ttbr1_el1, \tmp1
>> +	isb
>> +	ret
>> +	.endm
>> +
>>   /*
>>    * void __kpti_install_ng_mappings(int cpu, int num_secondaries, phys_addr_t temp_pgd,
>>    *				   unsigned long temp_pte_va)
>> @@ -416,29 +435,35 @@ alternative_else_nop_endif
>>   __idmap_kpti_secondary:
>>   	/* Uninstall swapper before surgery begins */
>>   	__idmap_cpu_set_reserved_ttbr1 x16, x17
>> +	wait_for_boot_cpu swapper_ttb, flag_ptr, w16, w17
>>   
>> -	/* Increment the flag to let the boot CPU we're ready */
>> -1:	ldxr	w16, [flag_ptr]
>> -	add	w16, w16, #1
>> -	stxr	w17, w16, [flag_ptr]
>> -	cbnz	w17, 1b
>> +	.unreq	swapper_ttb
>> +	.unreq	flag_ptr
>> +SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>> +	.popsection
>> +#endif
>>   
>> -	/* Wait for the boot CPU to finish messing around with swapper */
>> -	sevl
>> -1:	wfe
>> -	ldxr	w16, [flag_ptr]
>> -	cbnz	w16, 1b
>> +/*
>> + * Wait for repainting is done. Run on secondary CPUs
>> + * only.
>> + */
>> +	.pushsection	".data", "aw", %progbits
>> +SYM_DATA(repaint_done, .long 1)
>> +	.popsection
>>   
>> -	/* All done, act like nothing happened */
>> -	msr	ttbr1_el1, swapper_ttb
>> -	isb
>> -	ret
>> +	.pushsection ".idmap.text", "a"
>> +SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
>> +	swapper_ttb	.req	x0
>> +	flag_ptr	.req	x1
>> +	mrs     swapper_ttb, ttbr1_el1
>> +	adr_l   flag_ptr, repaint_done
>> +	__idmap_cpu_set_reserved_ttbr1 x16, x17
>> +	wait_for_boot_cpu swapper_ttb, flag_ptr, w16, w17
>>   
>>   	.unreq	swapper_ttb
>>   	.unreq	flag_ptr
>> -SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>> +SYM_FUNC_END(bbml2_wait_for_repainting)
>>   	.popsection
>> -#endif
>>   
>>   /*
>>    *	__cpu_setup


