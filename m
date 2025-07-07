Return-Path: <linux-kernel+bounces-720443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59536AFBBCA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5E7A8345
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328682652AF;
	Mon,  7 Jul 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uYbik8hx"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4C12C544
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917095; cv=fail; b=IWNr53iNbZ5YIn6FmodhLlnECKx7uZUB3KHqz2Movkd1cS0I9utVaKYdwgNfBMTH77OHq1Aiz5irvAkiCnqFXi0YBZPGmAcpwyzzCFt/AxWxkCzTzCKMEalHVjo8oMDNlHfLlKIC5KU22hweUPDY38Y52ScFP604ak+WpiOA/K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917095; c=relaxed/simple;
	bh=/3Ez33iKi9GRGuD5EnV3yKh78eS0MBJjSsxu1Uc7gMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tDqvCaKJIIfXu9Acc3gbupgcspKbp26GLQQwAOACjo/qQ8EnhmqkzjJhM1I9h2uwD4o0ZEGhQEmBDR6d/4nYgsuQ8DxLgvRZkB+zFoOva27ilv7dXlz84tmZM4e43dSBeBA0nISvTYFsOhaIT/PfgQPOpI3anL89vUgpCLZzVi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uYbik8hx; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY2zVheCSmEl9CxHBeCenDi+8TgRLfnewvZ6TKr+KveDMffHqyuwvgZsjzEQdkVmm5BXFtfE1pidHofW7UkzdyamSXyaeQtF+dM1+BnW2/HSeXZnMHg2q0iy7qqGWf++A54ymC2PwOiQZ3Ltx8CVsZQix5k29464xOH1NVwMlOvXoucJ/8PK/0U3vgHBjuMKy72bURMlBE4gaT818uK0+A9MJE+MNUMGZcb+pGrDDymiuMlBKmb+b9+8zPHBtxlT3J4tPo0ToIzacLf6DLjseIwiJscjHmfi9JCFF/vyiZPyBJp6uEKePzr/IPRzkbKv4I45DjrCXx/wCRPGQS5uyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JLfUtBgXTfA1bwcnwOHgBiuhAnBG16hmd/8uTeFDic=;
 b=xZXxCQlnNn+XZYr2GVg1cOtpj0honlsBsdIJi+oIC+vdUuAEeE+7+O0vQhYPEZ9l+TJaTnQdWSU2baj1PW17Q6zmlWEkaxODXnWAmUAaakSGAfoCeO/7JZqIH5YSLrpCnm6G1gt2gCBLqGbnzxegCcYAquTR/EfLDqiX3JmTBd8LFx3hGERMNAPxlz2r1Wt32vMq52/vzwcTH3kGsMGKSqKm5DeR0mMPADABnIgnpzlITpx1x64/lIlFpHemVmzpepevIwlM7yXa4fvVpZ9nByy9t+ss5PQLwP9o+qxVVSRfHTYvCwUI0QQVKu7lxMv450Cfsi08/BzjQna/ijvZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JLfUtBgXTfA1bwcnwOHgBiuhAnBG16hmd/8uTeFDic=;
 b=uYbik8hx+A6pZCtVPw+FqEWV2+6hvHQlC8u521i4sQWNUKRgp9+nzdlXsPMREQLJbrPpkieLZOhOnAvIns5kLg+SAQWafoVYeWWDRKZVuhD/YslKYiy2TxxyAaULKPtZqmHBHkwcoYMjWYJ+GvvAiu+8tc8yZ/DsDewO6U6MqyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPFF1E6547B5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ea) by DS0PR12MB9423.namprd12.prod.outlook.com
 (2603:10b6:8:192::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:38:07 +0000
Received: from SA5PPFF1E6547B5.namprd12.prod.outlook.com
 ([fe80::b737:7dcf:301e:f3e7]) by SA5PPFF1E6547B5.namprd12.prod.outlook.com
 ([fe80::b737:7dcf:301e:f3e7%3]) with mapi id 15.20.8722.031; Mon, 7 Jul 2025
 19:38:06 +0000
Message-ID: <6d11acba-76ce-4c02-baac-4828adbb9525@amd.com>
Date: Tue, 8 Jul 2025 01:07:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/memory: introduce is_huge_zero_pfn() and use it
 in vm_normal_page_pmd()
To: Luiz Capitulino <luizcap@redhat.com>, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <0e343f6f088fc79f625161b5d74567d696f2228e.1751914235.git.luizcap@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <0e343f6f088fc79f625161b5d74567d696f2228e.1751914235.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::15) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPFF1E6547B5:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7544ab2a-2174-4c6d-4231-08ddbd8dcb64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVpKOCswK3V6ZHdrbkxKMzN0aWkwcVc4d3V1czlHMFZZNTFDTGkxVmRXdzN1?=
 =?utf-8?B?aWNjakpGN3JHTXluc1hiSTczNm9rSUNzUmYrMnNaZU40Y1hHc0hQRjlTYlFE?=
 =?utf-8?B?eEJrdExaOVdRQ0VqQW03N0FIL2FDT1RkN2pRQzZONlMvRmVNZjZrK3pUT1gv?=
 =?utf-8?B?RGxUUnpaOXllV2paY0ZoYWRDWkFDekdLbmZzVFRCOVVEN0hQdFRvYUZCVllL?=
 =?utf-8?B?MU12Zmd0NDBSbGdhRWtiYnp2aU1iYXBYVjBrTENQbEZxK3E3SGthN0RWemRB?=
 =?utf-8?B?a1I0YjRtK2RFSFdVQm1jZGkrcFY0bEl5N2J0WlRVNHNGdnRIUFY3eXBtSEdV?=
 =?utf-8?B?TEhJRFgzQ2o3R3hoL1J1aTNBVHVIcWdwVGpodUIxVGdrRnRHMXJsbzc0a0lK?=
 =?utf-8?B?VndNbFNwOTBDWHowWThybW51MDdyNStKaFdzekN3L05LVFZMdjgwUnNvR3Nl?=
 =?utf-8?B?ZmUzNnJ6UXJ4UnAwemxtSlBoY1cvZ1RNb2ord3o3amlvc0xzNEtrL01KVGdO?=
 =?utf-8?B?cmhVSGliUkJla2NCblovbFRLUS9ERHF3T05FQVZsTVZySGp4Y2c1OGpJSHFs?=
 =?utf-8?B?ck0zN1pqNnY5V2V3YjF4eVBVRGN1U1JTNXZ2ZmlGdnh5dXZJTnU0bXBNclBv?=
 =?utf-8?B?SklSaHlzaENkdFZvalhsdm1sNXNtWHREaGl5TDBxT2pNOWQ2WjlBUjZya2ly?=
 =?utf-8?B?WGZrU2N4QXpaSVlSRkN6OGhvK3JiUUlkeW1ld3RvTlhzOXQ5M2JENzVna084?=
 =?utf-8?B?aGpNNXNZeDNNd1Z0M054WVVwYXg5emx3VnptYzFFWUJ6aUpxcmlNWEpkaVpi?=
 =?utf-8?B?VDBCWjc1ZlRsQmY0MEdkNHVwY2liMXZUNnVJU3J5OFFTcUlhM2NvcVBpTUxH?=
 =?utf-8?B?UnNjRFIybnJtczRhYjYrZkJ1aEd4U2o4N3A2cnFYK3JYMitROERMcWszcW96?=
 =?utf-8?B?TTFlUFhvcVhPdjczZzN4UlY1VnBXS1VPbWJQMVFJL1kyWGZsT2V2Nm5Jc1FH?=
 =?utf-8?B?YldlTnF3TnB1MjJCOXQ0Y3pQWEVNM2E2VHhDbGNXNlpxcnRqN3dKRXNlU1pF?=
 =?utf-8?B?NGN6dFFtUW9WVm9YUElHVVlwVE15YmN4b3Vzc29yRnFEdC82RkYrZHdXczZp?=
 =?utf-8?B?M1pmUFNzUzhiY1RsV2dRM0NCSEJEdEF1RU5FN0dsOGhQWitXS0NnSE14STVY?=
 =?utf-8?B?Mk1FNU9ySmtLTHBPSG96Vi9lcS9tRWl2aWw3TmV4U1RGM09selFjU01zLzYw?=
 =?utf-8?B?VUJkcUxidkEvcWE3VEgxd0ZJUEFhQWlzbEIvaUY2K1ZVVlliazJ2bUNGaVpr?=
 =?utf-8?B?Rk85ajFhMUZtam05dEZicGRFZ0pnY3p4TUlrQnlZcDRmNmtldkdzSUR2WXh4?=
 =?utf-8?B?OFRvUXFpekozcm9Ecjk3VHhOWmhhNW1aU0ZUU2xmZmxlRHpyYkszbURMUFVh?=
 =?utf-8?B?OEw3VXRlMGFjVkdYS3pVNzAvVTl0V3ZQMkdLWWZ5c0VHUTFJOGsxK0psYmZX?=
 =?utf-8?B?QkU4ZlZWWUZpWDAxQnoxcyswbHdiWHF6aDVwSUtqOUt1ckQySDFZaHNCaEFN?=
 =?utf-8?B?TGNGR0RMbC9CYllTS0FqTnZwVVFaQTZBUXJ5S0xHSy9wcTJTQXV0aHZSZFpp?=
 =?utf-8?B?UjA1U0Q3Q2tVRFVIRkhjdURGdTJHR2hKYTMvSVpmZU9uTkNweU9NN3hQOVA0?=
 =?utf-8?B?a1ZxK3pLNFNUa0c1TWN6bzdOODZpRXcxdXNYMnVmT2JzWitDM1R1Y2RhTUZT?=
 =?utf-8?B?K1kzdnMzSGUzRUZxbUdLQUdsdnppcHBUSTdVUnlvWFFuUEpSN2lZdjlSZUpn?=
 =?utf-8?B?b3lsTWFjU3dBWEJCR1I4blREQlpjeUV2dGJRWlpzOUswYW5iMnhNbXRzcjho?=
 =?utf-8?B?cWdkdVU1aFdhTHVCY2VpQ2VPKzRkNHp1QWtWa0w0cDVQRXo3OHcyZ1JCSGhC?=
 =?utf-8?Q?LFJicvnE+zk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPFF1E6547B5.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R09vVTdqV1pBclB3d050OCtUamdKeEdJT3JMZC9TNUhEclBQSFNSemhtUHhM?=
 =?utf-8?B?c01NR3BtVGZNd2dZUXgwLzcxVnhqcURBYWNRRS9ibTVTL01WV2d5U3UvUjIw?=
 =?utf-8?B?UkdsNnYyd0s4WE5vVlRUWmFISUFCaWs5MjRDNkpUak1JK1RIbmxrdVZlcWlt?=
 =?utf-8?B?UjhkM2Q0VHMrenVLS3ZFcDhTamJwaUZESnkvcmlXYlhaQzZvVThNZm91SzRJ?=
 =?utf-8?B?N05IckhqK2xEUGozNTBLVTloT0tpYzllSjFRaU9rSnkxeXNYTkVlYkoyV3pa?=
 =?utf-8?B?ZEk1aDMyaEppMytTaEVzZ3ViWVhOcDZ2RDU5V1I5M3VJT1dRa3kyOHE3N1ly?=
 =?utf-8?B?ditQUHJnMkVmc1pXT3dJc3pLZTY4YUhvZ3NaK2hCNkRQWFg4OFVJLzlOM2lN?=
 =?utf-8?B?d0xtNGh5OCtnbmZta3B2SWdMMnBzRjVhWnFVSVBZcTZYQ3hWbFV0bHRyUHhZ?=
 =?utf-8?B?WGVhdlE3UW9hWFk5RjdsSjFJV2tWc3BRS1c4RlphQmI0bytqM1RXUTkyckQ0?=
 =?utf-8?B?NHpNMk1DY0hQbnVHYWtYQldQaDV2U1JEb3Fqd3dHNkFDSkdCMm96cFNnYUtW?=
 =?utf-8?B?ODNlcEtnR2o3a2tUMTNWdkk5TS8zanVpdDRJYjVON0JTS0FhSzBLbTNDam1X?=
 =?utf-8?B?bWFkbTFTcWlmQld5dlczZnhZbVI3eDFzQ3JYbDhGT29yWi9CZmVqV0VnYmxP?=
 =?utf-8?B?bTlyeGVDVEVZMVo1Uk0xdWFJSzkvdHRSOGRkRmpEc2ZmVk9rZFgvTVhONk1X?=
 =?utf-8?B?R2tzY1JSSTdyMXlZd2xnNFJrWFhhQjJNdGJGeDdwYVp2c0hSdnE0QWdqSDFt?=
 =?utf-8?B?TUFxc2RwV09UV091bXRVL3hqcVNyMFVuZnd5QzUyampmcldZUzRFMnF3Wi90?=
 =?utf-8?B?QklQSXVEOE9Dc0xCQ3F3bUwwMUZpMGlvRlFpQkc3bHhLclU1ZjQxT3M4cExz?=
 =?utf-8?B?anIwcy92RG9TM2ZQeXFpU0ZQdGg4MEhNckZrRVc5S3piTzhGendwdGI3QWZP?=
 =?utf-8?B?dEFSZHdSRUt6NXRmWXpNTGRwdE82NHFkaGd5STRqSXdWaDVLaklpVVZDUTFj?=
 =?utf-8?B?bzlEVWJiZlh6V2ZpclFmek1WY0loeWhJWUN5cDB6QTZDSWF4WmxJRjlGY0dP?=
 =?utf-8?B?YmZHbjJVMmt4c280SkF6cnlqcnZEV3ROQ0VSQ2JBZjRncm9VTW4yeVJtRm9H?=
 =?utf-8?B?MDlUQmNJTEI1ZmZrSHhmT2l1dCtXY3d2MlV1ZzBwNm80RkZzKytXbG9ZVnho?=
 =?utf-8?B?NEltMEFzdmVrQWE5dUVTNFJWWDAvVitvSmlSZ1I3M1VkeXdKcHRwRWppSUQr?=
 =?utf-8?B?YnVRbms2cHRMaDJYMVlZbnRJVjkyMVBackZDOEcydnZ0MHN5b0E4eU4xU0NC?=
 =?utf-8?B?cnNWbzFGWXVqS0E2QTdLWXMvT3Nqd1VYT1VvVVNqNWhmTG1jOFhtN3c1dmMw?=
 =?utf-8?B?WG5BMHkwWlNJSUg3U0M5OG14T2RsSUx0SS8reVpTVlIrWUtQV0FJU1huVURZ?=
 =?utf-8?B?ei9wQzNDQXp5cFp6RzNZVy8yQzBMSyt6K09rZm1jK2pMZk5Pai9pd2ZlYm9j?=
 =?utf-8?B?eE82OVJGRWgwcFVHUzNvcHlhM1hDT3hLQkFWUE5WQit4UWF1SVh5SW50NEZ1?=
 =?utf-8?B?cllia2VaZnZWeEpIeTlMSW5jaXMwK1VIcFJkUjAyaWtCbTRWOWFiK3FjY09i?=
 =?utf-8?B?R0o2NCtKNTNlYTZrRHR4empuQXN5RnJacGFSNStOc0c2dzl1bFJNR2JyQnMw?=
 =?utf-8?B?ZlJPd3AxdzlTVXNVdG4wZUlnYUtKZmtPM1pGdGg5dE96TFdhczlrT0hVdG1C?=
 =?utf-8?B?UnVEaFNEWWhwVnpkaWg5MGJac0FXRU5wWmVxYXJadVVsYTNaYkdXSGgzL2FP?=
 =?utf-8?B?MHZXTGw4NVFseHB3aEE2eHdmRnJ1OWdnOTRxd0NacmVsbjFUMEFMN0dDeG9j?=
 =?utf-8?B?OWgyVUU0K1dNcEtDZHBQVVBhOU11Q0p2NmZYZHVUT0NWaGxaY0hkYm96eExt?=
 =?utf-8?B?MmlReDFtRlpWTE9RbnJZSHhLSHZjSnRGNmFSVis4aWpQNktTQW1LTXRtZHVQ?=
 =?utf-8?B?MzFJeVF3MmhqaVpHVE1kSExxU3N2b3FOSDJrT0N4YTRYbytTZDhLWXpNK1Fv?=
 =?utf-8?Q?/uyma+lr+3IHbFR6aL/N7XIBJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7544ab2a-2174-4c6d-4231-08ddbd8dcb64
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:38:06.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJgi0i0WBcy1rPHxlLzPC9ySACash3KFh2tnYGLu8wwHlYasqzoR788MrPDYNY8yw4eiecYzoGNjLFCHp+QLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423



On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Let's avoid working with the PMD when not required. If
> vm_normal_page_pmd() would be called on something that is not a present
> pmd, it would already be a bug (pfn possibly garbage).
> 
> While at it, let's support passing in any pfn covered by the huge zero
> folio by masking off PFN bits -- which should be rather cheap.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>  include/linux/huge_mm.h | 12 +++++++++++-
>  mm/memory.c             |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2f190c90192d..59e93fba15f4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -486,9 +486,14 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
>  	return READ_ONCE(huge_zero_folio) == folio;
>  }
>  
> +static inline bool is_huge_zero_pfn(unsigned long pfn)
> +{
> +	return READ_ONCE(huge_zero_pfn) == (pfn & ~(HPAGE_PMD_NR - 1));
> +}
> +
>  static inline bool is_huge_zero_pmd(pmd_t pmd)
>  {
> -	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
> +	return pmd_present(pmd) && is_huge_zero_pfn(pmd_pfn(pmd));
>  }
>  
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
> @@ -636,6 +641,11 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
>  	return false;
>  }
>  
> +static inline bool is_huge_zero_pfn(unsigned long pfn)
> +{
> +	return false;
> +}
> +
>  static inline bool is_huge_zero_pmd(pmd_t pmd)
>  {
>  	return false;
> diff --git a/mm/memory.c b/mm/memory.c
> index b0cda5aab398..3a765553bacb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -687,7 +687,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  
>  	if (pmd_devmap(pmd))
>  		return NULL;
> -	if (is_huge_zero_pmd(pmd))
> +	if (is_huge_zero_pfn(pfn))
>  		return NULL;
>  	if (unlikely(pfn > highest_memmap_pfn))
>  		return NULL;

Reviewed-by: Shivank Garg <shivankg@amd.com>



