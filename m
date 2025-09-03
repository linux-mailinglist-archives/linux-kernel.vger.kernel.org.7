Return-Path: <linux-kernel+bounces-799262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CDFB42920
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F5F7C316F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F43680BA;
	Wed,  3 Sep 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3z1KmHuA"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6BE36809D;
	Wed,  3 Sep 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925595; cv=fail; b=P2BuYVbQk0S0Ey03dRW76VPGm+mbuXK7TPkHziR2JZb6h+ak+BWWIbAQ6NYFgSm8LzKm34CEelGDgA+Cb1IDwV8PxlEQhOv2zPHoOL5jWlMFn5nT38l/SXUkHaR0QAWWCzaIsIa598IOcw5JhJv/eY6ZRvA2D12j9rhh6pZJZCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925595; c=relaxed/simple;
	bh=5enyt2ommkmwsqN4V3h1ocwiM2QRSqDvisxsP1mjhCc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pPTmFIYfCJ4IOq2hhJhGLszyQkE+5+sTe1y+SQsL+9069W533bD4huRNZMxV6Iwj+4IYhXaF+VLANXlDfWZDkLqx+FA1MGFxrXe08aWzFQ4mYm+faFPR3ZhHkC+zheTePX19VV6JLCa1dVPPld6fE+gFs0djSEyDvfPp/pGxtdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3z1KmHuA; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWyS17ImVldOieF1ne7BtDVnbcJuxfq1S+gLs35BhbtzNi8htFa1FckKNX+/50KNUojldHBCXMWpBWrjO0+qcZlp8duP8Oh9F+aUMMvL7wfU1SB5BmBX1CMfP4lLUCU/iqXf9ONvvXrl/RypAFzuHA53JSoYOkjq3PDk7s2PnU6GrEWXrqCj5zYOFYbQ0dDwrJTrEO/R/v6qemczJUxjudsvmiE2N5TZ2IHczvLshWbHGYu2dpr/W09mUPv7PuNcDK13GZVEBDp5lHJ72y/TqyJUxUByAyLc9YSvljEOzsRLciBJocrIgSHlqRdGgEG4JbVA8miNuRU5TjyB3KV6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fG3VJpn78wVKKlUpRlG1/oNeqHhbjYpDmyuIbbtgtE=;
 b=VTwrlE6OZGnGgHZGBAJpT8PN40p1excPVYe2jP8BIshBOenbaDqtCnllTPoY8FisMlepbecmMpL/Rpq88WLTBelVUc9kR9xranIX6vjG768cYHyRAGQNuRHQl9SMqPhd9+Ar/f95vcAWWs4kHaxNSDFZR/jkzyO/WmXowOfzrva5ni4rmIOi3siSAgvS3dhYaEv7z+oY/esHXLzcoAPiHu1j6oLKRzymOO6suORn+qzGAXvX6syaVSt/+YXSybi0hDVh09LxSZ6bNUdDGfugpSqmKrS9ljKVUs+bO6g8A53UU3VvcV/sQWnu5V67ZukF0oij8/1Tfz9jInccREgqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fG3VJpn78wVKKlUpRlG1/oNeqHhbjYpDmyuIbbtgtE=;
 b=3z1KmHuA9vefeQOmf3BMm6OJpCREH3EShhXa/P/hLn0sM34yNfT/dxRDVdYLx7oDJA7MyWBZGLi9tPKA1EuSNqt4oM2yudbmCGm7gmEuIkanxU+RwqyFWXDzI4L7X8HOCAP42no0RhPZK5+IjiFK8xRRX8E1maQwKTkaBSggERM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB5877.namprd12.prod.outlook.com
 (2603:10b6:510:1d5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 18:53:08 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 18:53:07 +0000
Message-ID: <bf052db2-3131-4295-a745-7ca21d0012df@amd.com>
Date: Wed, 3 Sep 2025 13:53:03 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v17 26/33] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <1966b499476d38cfbed6896dfbc50cddad35a126.1755224735.git.babu.moger@amd.com>
 <8620418c-d414-4b6a-bb27-bdb835c76a38@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8620418c-d414-4b6a-bb27-bdb835c76a38@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:802:21::41) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: eaddc48d-7ce6-4d17-d149-08ddeb1b1efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QURLWXdBV0hHYnBBN0dtWlBUejljbHo2WmlNdzJCQmhmekNjU1pYWVl0aVNO?=
 =?utf-8?B?OXdydmYraTdVUkRWcmsxVjlyK2oxeHVRQUw5Q1A3WnlIaEYwQWJidmdpNHd1?=
 =?utf-8?B?WjVJOS9sTTRjN2ZBVjlLUks1Zm5UUExhODU2QkdwUzRoOUhoU0tha2FlWDV1?=
 =?utf-8?B?VVZ3N1VSSkg4akw4Q1Q3UzdETGUyMXFkdGdCL0N4dDJpUjdYSGR1NXUvK3lD?=
 =?utf-8?B?eXdCd0hDbEM1UEQ0TUREcTlINmpSTDJuOFIzSER3VDcvZ0VQT2xYQTN5MW95?=
 =?utf-8?B?eEhhZzRjcm54Z1U0YUdzSGRWYmVLbkJBQUNtd2ZxRkZJeHVVRmtuU1ZvS3dk?=
 =?utf-8?B?eU93cEFaNDVXbjZJUkRwU3U2RlkxeXhmMis3cUUzVEpraDVWTENGSnhzUTll?=
 =?utf-8?B?T3c3RG5CWUlnU0lUaXYrdjE3bGd4V1ZDalg1K0FQL3Z1NmkzNllHMVlxcDIr?=
 =?utf-8?B?bFJ0OTFFWnFpM1AvaVhvVGc5Y1h4eGlQdWNIWTRzK2NzallXWDlEZ0p6RVln?=
 =?utf-8?B?eXd1MWs4TDRwRDREeUtJbk9EaHA2aXgyZm83RGdXWjdGVGVYa0Q0TG9ZLzgr?=
 =?utf-8?B?N3NOcCtyZFNkdlo4aHd4L2V1Y2QzZ0ZYdmtBOEh6czF4a3RaY1RrSTVQcFQv?=
 =?utf-8?B?KzBGMzBMaStHaXJ4WkQzeTZMdi8za29XaTROK2dUTVZSTkVacytPSjRLMkJE?=
 =?utf-8?B?S0xvYzJsSG5qZUdKL0RzMHA3ZDVVVEw5OEUvVTJhb0xEK201YlREMWdmdnFT?=
 =?utf-8?B?VVF1aVMyS1JybWZueUxzamNZTjZlSmV1cTVDamFuTFJROWV2VllhM0ZBUm41?=
 =?utf-8?B?UUF5VktYb2xQVEw5NnM0NUFnMFdRYmNlc0Fob0R6RVJvOHZUYjRoUTQwUjYw?=
 =?utf-8?B?REVESjNwTlI0aldtdmN0anM2NXQyelluc3BzRnFYTkh1RnpFV05zeHVjczBq?=
 =?utf-8?B?YUxxelNIc1R5Z3NFeUlwM3NPQ2t0ZUpIMGtoNE1ia1orYjAvaUNJdE5FbHNr?=
 =?utf-8?B?ZGZLblJGYVgzaWJDVGR3ZE9DNE1zYnE1RWZQaG5OZkRweGg0MytEVkx6cHVK?=
 =?utf-8?B?K3QrNWtqSzlqL1NJc3hBaXNCVnFDNWNoVCtFbUpmZjNCRU9GQjhrNjFUYU1K?=
 =?utf-8?B?Nll6YmlIODVYYUYydmo2TzFTZ3Q0QVA2aEppOHFNMnVRK0NHek05WThuV2k4?=
 =?utf-8?B?cHpYb0pDRnlkMnA1ay96alZYRjNRbWFUOGdoV3JOSlBlTklJZGNsTUpwUkc3?=
 =?utf-8?B?L3hrNGVmUDR4L0Jvb25HVlJ1UXk3SWRVL29RRDU1aDQ0eWhQbVBHRnFFdjMw?=
 =?utf-8?B?UWRhNWx0S1FDUGpZeW5ZWWdBQTM0VXVJRkQyRGlhRVVtcTAwL0h4bkIyK0hH?=
 =?utf-8?B?VEpPRWQ0RXpOcXUveUQ2NUN1aUs5SFF0UTJQWlpvZWtrSVNCT3R4WlBlaHh1?=
 =?utf-8?B?UFY3Um5zcTh3YjRsWjVBTEpVaFZUSUVmd1lWMkRxR0pOSisrNDkzZFR0VSsz?=
 =?utf-8?B?Z1g2Ty9YM1hpQWtvYnlzeFo0NXdlOEE5UDYvdkR2N2dwc0tObldhTEViMGF6?=
 =?utf-8?B?SENJQ09HSUZnQnVIYXlQbjJaMHJWejIzWnF3QWovMkI4ZmxjUEJIbXlqZW4z?=
 =?utf-8?B?dHBNcEZiNFBaOWxQN2UzNkJlMDVPRjlybmttVEhPTXJrVy9pWGhRcXN1bmt0?=
 =?utf-8?B?UjVJZFMzbGRGSDlZZTV3UzdoaWVndnVMeDFXSitUejR4U3ZwWjcwWFdpcy9J?=
 =?utf-8?B?bHlIUmd2NGFES3ZTUllxbGVtd1ArNmZNbFp5MkQzdWNuM3I3Z0RsN2xGMmda?=
 =?utf-8?B?U1BkM3NXUWl4YXFuSmlzaE1VVjJRS0Eza0tvcXhSS2tKUlFXUFdpYXltdWJV?=
 =?utf-8?B?aHdaV1l6Wi94R0JWSmRKbzRCRTVqbVRET09Ua0dkMWswcEtQcnBxL0xoY1Fu?=
 =?utf-8?Q?W8l3IAXzy7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3hweWwzMmhOTUNDY1BVRGlWSW5FdnU1MTVFTk1CMFc3VDIxQkkyb1RneHdG?=
 =?utf-8?B?T0p1cGFlRHhBZlRxRGdoVnZvOWptaTZrVDVPWnRGZ2NuNWE2aDVnSmJiNUhQ?=
 =?utf-8?B?Qm9ROXJkZ3hCTml2SUtRdjYyS3JCNHdlUWRBSmxhSWp4bzNaMk1QOUV3MGNL?=
 =?utf-8?B?ZGUyQkxyZ1Ayeko0dGJpNWY3eDB2aHRzSDRJTCttanlzZkdVSEZPWFU1cmU1?=
 =?utf-8?B?aVlzKzVQaTk1RHZaallCVUZ3VGx5YlhES1FmU1hOeitPcGVMZzdpTzgzT09i?=
 =?utf-8?B?aEJrNE5MdHpHTXJLSjZkUzhrc1hEQmVVWnJYNVZnVHZvWVV1T0NvOGZwUHZ4?=
 =?utf-8?B?c3grbzkvMUJQSjFpS3FxTkd1djFKbE1WR0gzaVpsdDRnck4xejYzeVVXOE03?=
 =?utf-8?B?dVZ1Tk94S3JsYkdsZWIwaVBsdGNJUml2RzFqa0lyWnBMUkJ3cUwyTWNKN2Y0?=
 =?utf-8?B?SENweGg4SUt2SjE3bVgwOXRiTWMyTGZrT0Z6Vlo1TTJYWmJxRm5DTS9mTmp0?=
 =?utf-8?B?anhSQUtZSnNMZUgxcmJhMHYrV1RWazVvZ0swbWNvU09nRDJ0cU9WcE0yaTU5?=
 =?utf-8?B?RnF3OWNmeEhNZnplWTRmZTlobXRzZEtYZkJtbU9SaWZ2ZUdZamdMQ1VodUZz?=
 =?utf-8?B?ZTdwRU9RSy93bi9Na3pFaUV0MTYzajlSM0dOMFU5UDhMTGZTWUZnRUNYZmJy?=
 =?utf-8?B?ZFlaRGdVVjdQQm03MWtjcEJBNk1wZWg2NGJaMS94MU9kUTJ0R3dDQnhjUkhH?=
 =?utf-8?B?cE5CVkQ2bUN1Y3dMRXFwM2U4OXBwdFlXdGtXZE9CSituSUFrQ3gveC9PaGFC?=
 =?utf-8?B?Q1ZRdGZSMGY2dXl3NzdadFhDZFRaOHBVZURRODhiZk93VTVnMDIyWUxsbzNP?=
 =?utf-8?B?VjNjRzhxeFBZd1NVY0JTUDQyaFJtY1diLzVka0RmR3gwdFhkSnBBSmxRaUc3?=
 =?utf-8?B?dXVTQXZMT0JNeGR0dDRkVXc4SGlBYStqZWJuT25XZWFGcXRvN0RnUGdjRVlL?=
 =?utf-8?B?UGYydUFKbEwwYXhBbmc1a2d3QlFNdFBzRGtrTUQzS2R5a3VQT1UrcUhyUk5s?=
 =?utf-8?B?ZDk4K3BpQm1FREFrNTd6WVNKcnp2YVhrVmVtTWw5cmpYb3NGYTcwU2MrWDRY?=
 =?utf-8?B?RWV0VGFHcERFMHNHYXRjNU9ka2I3VDVvdkJkNU1hSTNEc2kyRndlUjhEQjZM?=
 =?utf-8?B?Mzg0OHZXNkxGanhVL0N5aThtZTNKUDlxRkJwbCtKQUV3c1ZsRlczbFF0Vkpy?=
 =?utf-8?B?NGtnTHBYUFNHWVY1Nm9qWW94Y0ozcWJOa2FIZm5rak4rK2tYS2lUMlVjYzB3?=
 =?utf-8?B?c0dWVERqLzQ5OFRVSVpsVDNqVVBFckt4WlJybmpNNTJJbDljODQ0OWlCQXhN?=
 =?utf-8?B?SVorRklTWkJydndmYlcycWV2cXNaUWxSREJ0S0x3VG4rbDVzb2xDYmhBemIv?=
 =?utf-8?B?a0M3UjhUd1BwaHNTV0RXUXdrMHhtdlc1MG9KOHUyRWp0dXJXWjBCZ0VPNmlV?=
 =?utf-8?B?TDZXT28xSU14T2JJdURFMThzaDFLb0dFWm1LSnRzdWM4S0o1dkhYR2xNKzNJ?=
 =?utf-8?B?dWliQmV1YVlxWTczSTJoWFJKMXpuZlpuMGFoUVdqYzFwZUlqUVpBMFdJTGN2?=
 =?utf-8?B?am12a0dzNjJuYUFqT3NlcDB2bTVjSlRjbW9iRnFZVjFKQzlvbXVZdFBkenVK?=
 =?utf-8?B?K21RSW1wbWhuWG5oVVEwYjdKOTF4SGphQTIwVk1mSjFRZnc0QUhKZmcrYmNH?=
 =?utf-8?B?QTVOTTdnSE91d1NVMEpYSHVyaGh6L3hSeWhsS1paNi9WRUhoYjlxSzFGT3lS?=
 =?utf-8?B?QmZDTExCcmdFTmVQMUd2cFFjS1VacW5NajVWTFpWc2tyRGJHY1BpeTBSejg0?=
 =?utf-8?B?L01jV29xOEJ4SnVXa2tVaUx2VTdOVkJPMWJWTm9CNEI2blNjcFF2Mkl6dzY2?=
 =?utf-8?B?bS9zcUh0dFI5UG5KQjFteVBsSlF6dzk0ZkxSejlJL2trSlRaT3BTdmc3Q1Jj?=
 =?utf-8?B?TTNLU2pZQ2dDVlhZT1dmUzcyWUlFdGRnaW1IWDdrTGc2RmpmZmJxOXZNdU1B?=
 =?utf-8?B?N1YyYXBhMVBHWWplQ2NXOXNTRklKVEQvQ3l2Uk9yL2FCdGoySm9MU3lSZFNr?=
 =?utf-8?Q?FxI4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaddc48d-7ce6-4d17-d149-08ddeb1b1efd
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:53:07.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htgZceKHKhyhR3soEJr2xtOubxSKbMSW5X3SQcYTfUEmapGYUyZSi2AsW0Q2pGvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

Hi Reinette,

On 9/2/25 21:44, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/14/25 7:25 PM, Babu Moger wrote:
>> The "mbm_event" counter assignment mode allows users to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>> assigned.
>>
>> Introduce a user-configurable option that determines if a counter will
>> automatically be assigned to an RMID, event pair when its associated
>> monitor group is created via mkdir. Accessible when mbm_event" counter
> 
> Mismatched quote: mbm_event" -> "mbm_event"

Sure.

> 
>> assignment mode is enabled.
>>
>> Suggested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
Thanks

> Reinette
> 
> ps. If there is a re-spin, please consider adding "mbm_assign_on_mkdir" 
> in cover-letter under "Feature adds following interface files".
> 

Yes. There will be at-least on more re-spin. Sure. Will add it.
-- 
Thanks
Babu Moger


