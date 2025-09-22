Return-Path: <linux-kernel+bounces-827728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A5B928C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EF818953B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109A3176EE;
	Mon, 22 Sep 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1oiFa7K"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6A2DCC1C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564419; cv=fail; b=VLCOifBsOy8UX46R4pRg4Tg2aOgwaaVknBwmiQrNC6EZFuGnAstpJD+XWj4J1rHIipGO7pJbsqzsrFT9sZbQsJXw1wW1o93JmHOUvi4iy6cHus8sWeH117L/WA/15sSnZRda4/SCw0jFYpwxRWSNLtlop81bsov2HAZTldjkE70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564419; c=relaxed/simple;
	bh=GjMKALjnmMTXFsRJDkG4ViW1C8lVd99GOokb069yF/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SesjkvVXNVPz01dQUamoAcdrSExMfc+D2K0xguaLMgp8nGL2y6nNKTYCpL7LNTzYRxioM18za7XwS1oKqvQZY26iCdqMwCMMvq3EyuQXQiiO5SKTQi/mvJCRUDheZIxFLuCFpf/oZ9l1rpxn9/e786dEbeEXvr4zQ35zwt5ap7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1oiFa7K; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOqMkl5QIBbHVnWFCV2C/bTmY1o7ZZBoj/BY/rU+aSrcFRTVYjY3a8ycuWvUBj1/gdRO6rKz4+lGSeU7R0+5VscDnnmrzmxNkB0oRaJFyzsDjujJ5g1KYJmqWzOLDxLDpQef3Uas4SknWetl1Y7eY2he1gH7OhRx9QAksUjh4w6lzZ4PNSxcM1hMmvD8Ahb6+FpObzdWakXwTVlmC0ykum0WG5kuj758HGsrk0j4lfyBa8OOEHCvVGSoA70MOKEsRaKRVz+GLlnIKLk3b5dkDcelPnEdSZn8NvgD7FKMIeKrCFjLo9LIRk+GuxZOYbzyiQhTa17TeuT7eZXQljZKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgyodoyQE3Ds6B+eoxx608x8XgIW+waw8/94Tl11E1M=;
 b=VkjZOwEyz3pHDtByVAccGmJEvB9zn/tHi3EsXtXKqdUfq3LJjfxdpg4mbMb6VkPGSqcyza9d5SR+iSfC7GLIkbJFJhQWuY7DXnTWAoxWt0h8qCF9UiyuAwLcRCtvrzk0QKKIojaclTxL5rajXq1ana5WJzDWPVWHumfzr6rxfaHdO3x8cwKsFG9kj+p8vHAKfP8Sjl4IkhfL1YdxTMnijdh90vJ2TKdrt7ercaxKxvQvXJdc1TdPmQH45KbVIKL/u9de8XNTKXLK/fitPlHl7J/VN9dQrU5g8RsnNXCTDtckCPXc7M2tffrC2hz7XUcB3icffl6lRjA6HTww/Uzl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgyodoyQE3Ds6B+eoxx608x8XgIW+waw8/94Tl11E1M=;
 b=L1oiFa7KQVDwKwa3qhiTKjQW/gbD+KvE1I8xqSCcJs8ocHBsvtUOuwl0Q1eKDS/lM5+CSsvK/G8KcZ9bwa5AcmbCj2u8qG6RVPiF+mlxjov2wlZWUbm+o987ep8IhTRl+GA8kpFdpGDBIaETM6jmzBZxtFRq925VXluo9yR5NSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Mon, 22 Sep
 2025 18:06:54 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%7]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 18:06:54 +0000
Message-ID: <d3b94b72-3e38-4951-8c75-8b028db7915c@amd.com>
Date: Mon, 22 Sep 2025 12:06:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Optimize remove_duplicates() from
 O(N^2) to O(N)
To: Kuan-Wei Chiu <visitorckw@gmail.com>, austin.zheng@amd.com,
 jun.lei@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, siqueira@igalia.com, aurabindo.pillai@amd.com
Cc: chiahsuan.chung@amd.com, nicholas.kazlauskas@amd.com,
 wenjing.liu@amd.com, jserv@ccns.ncku.edu.tw, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250909092057.473907-1-visitorckw@gmail.com>
 <20250909092057.473907-3-visitorckw@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250909092057.473907-3-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0302.namprd04.prod.outlook.com
 (2603:10b6:303:82::7) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7e2de3-68d0-4c61-ac06-08ddfa02cff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0hkR1BxRmJCRnNLVU9JbUZkNmttNFdqNU5RZktRcjRDRUJ3ZDBxZXZGYVhn?=
 =?utf-8?B?RmtHaEhZRUM3UGRmSTdzOXZ6OG9qblh2MVVxR05PeGRuU1o5SzVtaW51dDZL?=
 =?utf-8?B?UFJQNENFdk5mbmJpR1JRazJUYTNzcFBZQ3NiaWFMTWJ5Smt5ZnhQREdoQ3FC?=
 =?utf-8?B?bDBsa3QzQS85cGZmZkR0WmxyQ01nZE1RNjBEbSsrTGtUS21jZTlzVVo5alpH?=
 =?utf-8?B?ZFBpVjRKSjZJM1FDTVFCZ1h2dHg2c3RSNFRoWTJpdU1YT2VhaVRvWDIvM2xv?=
 =?utf-8?B?TFREdkNPK3M1K1hXcExaL0JFak9JeDBNQXhrSkZTVkQ3K0VhRDRnMGN1d2dq?=
 =?utf-8?B?d3JiNUdLS2lLRTIyNUN3dVFwbzMzb2IyeS9kaW9pd09qUGdKNnhtZDVha0d6?=
 =?utf-8?B?M0pIRDFVNHl5aWRkS1laWDFRMnRCcUtrMGU1Z2FyT1lxdmFWVERqcnM0d3I0?=
 =?utf-8?B?K1FLVnVjWHNWd1ZTcjl3Qy9ZTlBvM2Zrc1l0aVo3Z0g3V0ovYjhPYklSY2Rk?=
 =?utf-8?B?aDBybUNmZXRGZTZNbUNBRU9FdW5zTnpmT2Ezc0V3ekZBL0NLdXBQR2NYK01B?=
 =?utf-8?B?MWt0aTZBZjdGa1JQa1pMaXJQK2RySDFaN1ZodEFLWGNOWEp0SlBFR3p4bTdE?=
 =?utf-8?B?SEE1RjBrUjlvT3BSdmtxOVdLR1RxNER2Zm9GQ2gvakcyYVZHR1o4aU9iTEIy?=
 =?utf-8?B?dXBKcEZlL0VYa0VnbzVZVVdnUERLandUZjM5SjArL1NvdkgzNlRNbkVOVWpB?=
 =?utf-8?B?WW5VVWMvWE9peUxmOGVEQnlkWXJYZVY1WXh5Z1BsOXJmY2lrb2RsZnBxaTBB?=
 =?utf-8?B?TG12bUVtNDdYTmxHM3M3ODhDcXhBRHVNOXlROU5LSit0dCtXTHkrUFN5dFhz?=
 =?utf-8?B?RHgza2Y1TXorNDlTRFIxa3BlMDl2R3AxRThjb3lTUXhGaXFGSG5mV1FhRldO?=
 =?utf-8?B?WDk4NnhCSnN0OVJyLytaZmNMWEhHb0NZWUs3WmErSFR1R0FmbUNzWjh3Rytk?=
 =?utf-8?B?ZzdPMHhKRy9CR3NwT0xLaGlodUVOaW5FOWpOeWo1WkhnZWowcVY5UjNjaWNO?=
 =?utf-8?B?b1dnOExTOWo0TUFlOGNHV284eForRmFOMmM4WTRka25CMXY0M3czQ3c2Z2Jk?=
 =?utf-8?B?T3Zpc0R2K0E1Q3FyemE0MGQwUWh2OUFmNGdwS01waitNYzdOY0NLa05aQnhK?=
 =?utf-8?B?T21oN0N0aXRaVHhHc0hMVUczaVhsZWxQaCtReHpseHBoN2dncVdaRTJjNlNq?=
 =?utf-8?B?ZEs3NjhMRlpqTXhPTnQvb0pkNFpNSk1YRDF2UnNTYXFjVWYvNmhuN1hzOFl1?=
 =?utf-8?B?dlYwdmRDMSt6TVE2SDhpNEhkN240V25XZWRWYnZnR1ovajhLK2drNWJFdTRL?=
 =?utf-8?B?bXVBdThCS1o0Mjk3RmF0NXhQUk1rb2hQVzZ5STYrcUVEOXZEOGd5NlJqYmNy?=
 =?utf-8?B?UmlpUjFFV001b1lWbXNBNDVmNWFZT2J2dnBpZFdFclY1T2d6ZnBFcHpwTVov?=
 =?utf-8?B?OGIydnNIYm96ejFyc2trM2FvcGN4RUFOZHJ0M3BSVDBZNzlhSFZvT0tWeml6?=
 =?utf-8?B?MUF1MTJ1eFI0ME1zRVhoc0NsNUp6VnprSjJucTBQSzBBSlE5OWtsUnpWeXJz?=
 =?utf-8?B?R0phV2p1aVRtVkpzOGFCcXc3VjRPZ2c5THp3VzUwZU01MEc2ZWhvWDdhbWR2?=
 =?utf-8?B?cjgzSjUxc3Uzc3djbVJQYlhod3o1Q25ZbjVOYTJMbWRMSlV5YXpQUi9lZDVJ?=
 =?utf-8?B?WkY4eEdTN2l5NVA1ajVJWk14ZUNXajJ4YVFGajlqWXI2UHdHN2R0WTBITmdm?=
 =?utf-8?B?UVd5MktQMU05emNVNlBBQ3BIT0VQNW5oVjdYNVlhYXQ1TWRxaWk4Y1hXZjdB?=
 =?utf-8?B?WURDclJZYlk4SnlJTTZ2UVBWRGpRYmZYbWhEa2hraUFXME5yZmlXdmdHYk91?=
 =?utf-8?B?Zm8xTFRJTnFoS2FiK2Z5RGlQWGZacUdBMk5STTlrQ2NOclU5N1lmdkgvTDNr?=
 =?utf-8?B?MnIrQnVDU2xnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3duZ0JROTlZWXhkamZkNlMwbkNMcEZIVUhtcjg3WW03VzUrOXhQSFVyUEQv?=
 =?utf-8?B?cE45RXY1ekZGRlkvNUh6clpCeVhsT240dTYwYzI1UVgrUGs1ZkZkNTBTRjNx?=
 =?utf-8?B?MDBVWDRFMi9zRVpONElhWUd2eGh0cSswRXI2RzZkM0tNaEhBbDYyY252VHdB?=
 =?utf-8?B?NTRaS1djVXUyZ0Z5TmVjd0d0RksrT2NvN1JtTGJxREhHVVJWZWdRVkxMUXdJ?=
 =?utf-8?B?UC85TlZHZzJadkMycVFXK1dCbTFySTQ3c3lWbE5NZUpXUUFWYSs3cms0WGR4?=
 =?utf-8?B?V1NZbFVrdGpGMGpOMHZmWUlhcEl0MVkvdTdJcTFyV1B2NVFCdXF6Wm8rNlRX?=
 =?utf-8?B?emdoRFR4M2dIOVBFM2EramhGOUlxZndLR0RMWE55RVEvMUo1bVlYSU5ZSGR1?=
 =?utf-8?B?QTByYnlxdnlkZWdZZjhDKzJHWHJZcU1ZWXMrNFVqZnZTMWd3ZW1TK0xoNTBv?=
 =?utf-8?B?em9tR2g4VVgybXl6ck52NVZtWGtGZmdIRmI5WmEvcUZSbldWNU9wWXBOdER0?=
 =?utf-8?B?V2ZZVVI0cjZnVHRxc2Z0SnpMekh6Y2pNdUVoUWxsdVFsZGszWW9mRDRaUHRR?=
 =?utf-8?B?VTZXQ1VXZTU0M2NjbE5SemhnQnZ6SklKS3ZmMSsxQ3FkM01UNVRUQlplZjR5?=
 =?utf-8?B?M2gyWGZlUm1vb3dxbnY5cFZlUXk2SDBlRFlaN2NrWkNVL0tNOU9SWTdCV2F2?=
 =?utf-8?B?RHliQlhUZlRjanFoRzBxWE5PLy9OOVdBTWZGR2hadFFkWWswVGd1M1dDc2dm?=
 =?utf-8?B?cUFHSXNUV2dEQXhQT1c1cGV3WkF4WTBHSXFQYU16aWtrcmVPNnczcnpIci9w?=
 =?utf-8?B?N2JSTjE1K3RPbWhoZklGWXlzRkZLcG1zZnFrdi9zRGRXVmhaVXJrMlBUVlo0?=
 =?utf-8?B?SEtaUkxpTC9MTHJWa3Uzc0tDa2g1bndOVXIreGhyM0lTeVBoR0RtZENIVS9U?=
 =?utf-8?B?Y0RQNTJ1MHI0UmUyMkVpaE1GL3FLZnkwYVBCcmpBQ0JvMjZ1WjJxbXJwN05o?=
 =?utf-8?B?bkh6c0VBblVjL0xUNjZKTzBnb2Y1R2lXdkd4M1JuOFhmOHVGREFubnI5SHdz?=
 =?utf-8?B?TS9UcGZPNlhNaW5ONEhsSjZBZGh6R2FFNUw0ZGVZdzM5cDR4bHNJUTkvNHBw?=
 =?utf-8?B?MUZocEpOSFc1T0I3ZUJsOHZTSnBJSXRlUHJsWEw1SDNjVjdGUUc5WlNlTE41?=
 =?utf-8?B?eks1eXRCb2RZcFh4Ky9WNTZHSnJRMWRoelVpTGhVRDBwbnhVbUV1aDVLZEsw?=
 =?utf-8?B?czBBbzVSN2R4bmJBY2NrWjZxN1NrVzJlZnZLVndHY1FZeDNOMitYbjgwc2Qr?=
 =?utf-8?B?MTl5VG5wdk0vYkJLK2hMYzBuNDVBdHhCKzhJWm1TWjgyckJVR1VONXVzUkcv?=
 =?utf-8?B?YWo4Qlh6dzlVQjlMR2ljN3JKWE1BY3dzZmFRbXNIQ0oveCt4MzUrYVQra2lr?=
 =?utf-8?B?b2RhT2VlUm9QbW9wZHRIaEtyaldTRFFrVHdkcE1xR3AwbEpHMEFmRzVSMkpH?=
 =?utf-8?B?QVN0d0tQWnNNT1ZwdTBjLzFheDkzbjFlNTFzREd0ZTZVU0M2SW5vRk5pKzNi?=
 =?utf-8?B?QnBiSkZZM0lqc2ZjL1l2aE5mYk1nTXE5d3hBS0hVYWJCL1NUUFkzeWs4MTEr?=
 =?utf-8?B?WjJBVzBNY1lMYUtjQTVGYzVPVGIrVU9wUHhQNjBZVjZpSk1uMVN4djE0THpU?=
 =?utf-8?B?a1FsdFZNNGRZZFpTWlF6M2kwNHJ0bWErZUUxUUtBSDFmV1BPVTFhY01MR2tn?=
 =?utf-8?B?RkdDWGQxNEhoZ3BpeXBQcTdUL0F4MlVmL2xkLzNrQmZwMnpJK1ZVZnNxSE15?=
 =?utf-8?B?Q3hrV1JOOTRQODZoaTFhMklCUUFZcy9LZllUWk1LK3RsWjNBbUVQa0J3Mm01?=
 =?utf-8?B?a016QUhUTkJtSGVvclZDRk40SG9BYk9Fem9ISnl3d3gyS3lVcU5ucmtvVUtB?=
 =?utf-8?B?amFDRDhBQzloSFV2MU1FR2MvZURRY2YrR1E4QlJxSVBHaUF0YVgxL294S21G?=
 =?utf-8?B?dVJleFFKTHVzQnZxTElidFhUYnVieGhyR2VxNWphSzdPRCs5ZXYzL3lDQ2xH?=
 =?utf-8?B?T2RmWmp3dXVCVDUweEdidElUWDZaaEROTzdvQTVVSHYxWjN6cVRwMStsVC9m?=
 =?utf-8?Q?XzFv5XTOlzftWUXK7QSENhIF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7e2de3-68d0-4c61-ac06-08ddfa02cff4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 18:06:54.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCV89rQhrv2JANmX3wwyhBLl30B4KVwNkBgJfnTEr2Zz3Ki/1ys1xb9dWtsnJQhtgmQE9V8ECzcsz4rXuBDHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 9/9/25 03:20, Kuan-Wei Chiu wrote:
> Replace the previous O(N^2) implementation of remove_duplicates() with
> a O(N) version using a fast/slow pointer approach. The new version
> keeps only the first occurrence of each element and compacts the array
> in place, improving efficiency without changing functionality.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes from v1:
> - Add early return when *list_a_size = 0 to fix a corner case.
> 
> double arr1[] = {1,1,2,2,3}; int size1=5;
> remove_duplicates(arr1,&size1);
> assert(size1==3 && arr1[0]==1 && arr1[1]==2 && arr1[2]==3);
> 
> double arr2[] = {1,2,3}; int size2=3;
> remove_duplicates(arr2,&size2);
> assert(size2==3 && arr2[0]==1 && arr2[1]==2 && arr2[2]==3);
> 
> double arr3[] = {5,5,5,5}; int size3=4;
> remove_duplicates(arr3,&size3);
> assert(size3==1 && arr3[0]==5);
> 
> double arr4[] = {}; int size4=0;
> remove_duplicates(arr4,&size4);
> assert(size4==0);
> 
>   .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   | 21 ++++++++++---------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> index 2b13a5e88917..1068ddc97859 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> @@ -50,18 +50,19 @@ static void set_reserved_time_on_all_planes_with_stream_index(struct display_con
>   
>   static void remove_duplicates(double *list_a, int *list_a_size)
>   {
> -	int cur_element = 0;
> -	// For all elements b[i] in list_b[]
> -	while (cur_element < *list_a_size - 1) {
> -		if (list_a[cur_element] == list_a[cur_element + 1]) {
> -			for (int j = cur_element + 1; j < *list_a_size - 1; j++) {
> -				list_a[j] = list_a[j + 1];
> -			}
> -			*list_a_size = *list_a_size - 1;
> -		} else {
> -			cur_element++;
> +	int j = 0;
> +
> +	if (*list_a_size == 0)
> +		return;
> +
> +	for (int i = 1; i < *list_a_size; i++) {
> +		if (list_a[j] != list_a[i]) {
> +			j++;
> +			list_a[j] = list_a[i];
>   		}
>   	}
> +
> +	*list_a_size = j + 1;
>   }
>   
>   static bool increase_mpc_combine_factor(unsigned int *mpc_combine_factor, unsigned int limit)


