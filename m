Return-Path: <linux-kernel+bounces-749728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF8B1522C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255FD3AEE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516429898B;
	Tue, 29 Jul 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4c8foRT"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F21A2390
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810931; cv=fail; b=ODQodhfnfs9jveM94GxZ1nKuteP3oZF38o9S6Z3XjCWUSCWEwWyNcAjZcJ4KnhSPGlSUbMEakk1Ji2aHGoma0xR/bmI4Sj79soxut2iD97DBAsipnOiavZWp7qYRD9XyOMl2FSj/XJqD1pX8FT5crCSQcN1mVZX/Yx2rUK385sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810931; c=relaxed/simple;
	bh=gjVVujrndYFIILuqwslS0I3abNLVQbiwcmLSrUezsL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MN/qiwWmbyDatr+FUeKEzCzkZ0Q4Kk/VtZHP91Nt/zoetfJPLZ46/1K9ubE4famtIP+PTUzLuCIQd7QTA2l8WKbMZtjFWYO3mPsdL6MtCJAJM9OWOOdf0g4mLrA3KqyTyobUAyeZd9B+HG9m+w9+9Bcc0IN02rGTaP1ldgfuAiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4c8foRT; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU0Ctj5LKxT+X0t/CaRcheIBFv2opVXdtIvp5KxnPuHaEflFU+n+77wr5frH61HZTtCUaGIo2SnDpmhSYT+yIjFiLD64GUFshXy5iEZiDdz1QlmwTRDs09lLCXgrZwTYRILXF40T3uRKAguvbe8fbXswbEqsHqokneZ/540PKUWGpwei3HbJ5OK8Gv86Id7HOVVHxT23Wn/PjkJ/HUdMlKw/hPSHKP9yic4Xka5UIJQcvqeXxKpcwdNukgEoKTKEjNvtgmwOCPvOtx3sEAmOF0Q0CDCZPs2m1o/kadvONrkTJvfrO6c88Cv6ABMzXS7VpEpGANe0cmXP2jcrymZm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7wFExnlurBv4xIuGi+QJBz228fRoSlehZKE4tL/G24=;
 b=iPGO0CoPcNjIQW9yTgMZE9LT/9y2E28Pe5vLPhGMhrFksl8UIkNXO7vwov++9/y4U9p1uhzM85s03PE9ik4hnK4AGH7Et+/siOBHPwELA5h+3vipMun0IbYxLg17HapzGhM7l5TRvKTV9WYzUWU1Rerm6IW1M1BebAmPo9Y5RSdeNVijrkldw0HrgWQVnX9hASNBOaI3B5go763eRrXjFkfvCr+2lPCqhAmQsU2kmKlJPJYLuxg2Sfn+f/WIlQj+VExPQj359Mxc2pGoaPGTlPXM/s2NCwP/jqwE3EsfqT68OVsJN3rvYwjRRDwXy/MbJnhk25RoIdRn2usA90SPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7wFExnlurBv4xIuGi+QJBz228fRoSlehZKE4tL/G24=;
 b=a4c8foRT6lQzFzz8gV7TAKAeEnSUPkTN8hCk36QLmBkN+oi8OZLY+vHWwRm93Mwf+b7jEviX8ndDh0cLkuhlnK5NcSHNfL5iijNNuCk/b0Gc0sPAgHKVovZKF4csyj9qx7IV4CKfoqioln4um2X8/Knzb8JbGeigp5sWdXI9Qok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by CY1PR12MB9699.namprd12.prod.outlook.com
 (2603:10b6:930:108::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 17:42:07 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57%7]) with mapi id 15.20.8943.029; Tue, 29 Jul 2025
 17:42:07 +0000
Message-ID: <fd9d8b12-97b7-47eb-a26d-54a8148bc57f@amd.com>
Date: Tue, 29 Jul 2025 12:42:05 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [Bug] x86/resctrl: unexpect mbm_local_bytes/mbm_total_bytes delta
 on AMD with multiple RMIDs in the same domain
To: Reinette Chatre <reinette.chatre@intel.com>,
 Hc Zheng <zhenghc00@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org
References: <CAHCEFEyd0Y+wTrLWNMUNvwgJrCxAi66D17w3Zg-ikH5005k1-w@mail.gmail.com>
 <a148b764-0609-433e-b6e9-932493f6c1b1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a148b764-0609-433e-b6e9-932493f6c1b1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbc9ca4-da38-49a1-a5ee-08ddcec73ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFJqVXNveTdrdW9KMks3QnRnSGRPUkpMdE1Zd2M5bXN1RFdnMVNNLzlRdWFo?=
 =?utf-8?B?YW5XNjRzdDhETkJSay9HTE5mK1hiQVYzclZMYWtTelF5a2E3OGpQcGo5bTBu?=
 =?utf-8?B?VXA3THB2Lzg5R25LaWx6ckk4RUN3dThkK3BwbnRDQTRkdDlkRFhIWVRLZnVB?=
 =?utf-8?B?aTI2Q1VPVnFodlJFNUxHV1JLNWdvUmRkS0ptSEpUcmplVUxGMVRzdjI4VTdD?=
 =?utf-8?B?akYxbTRkNmtqTjdhQnBLVDdBS1lsSnIxWTdwTUdMN1ZtL083RFVJREs1TDlo?=
 =?utf-8?B?L2NHOGdpLzdmNHNaWEJwYXFsS00rNzhWRjdvUDR2VEpUbnNLREk5NUFQUnVH?=
 =?utf-8?B?eWxybzBWMkpVVXNCZ2g1NWZrTE5GRldWblVnRnNJTElueHk1aUVZTUhSUXNL?=
 =?utf-8?B?WUNVUjFpei9zK1MxTFNFSUxKQ0dIMUlvbUxQc2dKa2VnWUhsaEVraG5wV1o3?=
 =?utf-8?B?KzhYZVVkTkJOQXI0M2dnQ0VSMUdBTzZsRXlJNko4ZFZwSDZkcnRVU0VjcnBq?=
 =?utf-8?B?S3FtWUlTdjIzQzRZcCtlNUY2TkNVd21aU1JXVDYwVk1nRGthOC9QQjcwS01y?=
 =?utf-8?B?VEFvMTVkOXBhRm9jOXFuTmlpeTdoVFY3Sm5nblFuMzFpU2VRay9aSkovaHU4?=
 =?utf-8?B?Qk0xeVVhMzhjZWpWMmE0TWdacVZwbzBEcVRtamhuL3ZvdnhKeDBib2FpQith?=
 =?utf-8?B?aHJVRFN6K1REYWxEMzRZL3RZb0VNb0l2UE5rUXI0a2wrRDY5MkRrU3ppOVNO?=
 =?utf-8?B?QzJjYnJEb0pjSWpBSGhRajBYNitUYzBCNUN0YmxCdXJjNlNBcHVnTFRmRFFM?=
 =?utf-8?B?TURjWnFlNHA5RDRuYWFXaUJBUm0zNjVlaE1wSVZMR1BZNmU1MXNGVWY2Q2ti?=
 =?utf-8?B?R01ISmxHQU1TOVdqbHJSNHdpLyt6VXlzRzYrQlZxOXIzeThocTlpVWoyU0hy?=
 =?utf-8?B?dFo2R2k2YmZvbTAwMUorK2Z5N2h1ajN2Q2VYVkpZK3YveGs5WmFOVCtlNDBJ?=
 =?utf-8?B?SnMxR2dIWUI2TkFMWXc0VzUwdk1PakhibXRveHdBelNHalNrSTArUjhxYnFE?=
 =?utf-8?B?Z3hSYkpzRmR5ckxWbGpneHJ4U2JhcHpGeVNYbXRFR0VYdDJUTXcvQnJEWWFp?=
 =?utf-8?B?OTVRV0dRY0J2TFdWZmRITlU0UGM1TWJkaVJveGpDeVlFQUpRb1ZUaGRvZkpG?=
 =?utf-8?B?SFdEMWxvVnRSSjhFZjVLSkxjTjZQY1BNQkdWbG55UGpjQ2RRQ1UrU3E3d0tt?=
 =?utf-8?B?cjNNTmErV2svSUFFNnhFSVFvUGVFaGdpKzQ5TjEzdTJqVjN1Z29QWnF5TWdP?=
 =?utf-8?B?K0I0TmJGRXAvR0hDcUx4ZVZpb2IrVW9Wcnc4ek9DVVZ3QlhFOTEwODNCTXlH?=
 =?utf-8?B?Y1JvS0hFeGJ2c1dheGhOZUxVZ3J5UytCdHUzUUZaZHdBMWdDOElrZm5DaU9o?=
 =?utf-8?B?QWsxOW1SclM0QzVjRUU0SjU2V080eHFPQVp1R0g0dU5MMVduL3VjNHI3K2FM?=
 =?utf-8?B?VHNsQmFmUkg0ZVFjeGh3akg1b3IzM09sVCtrR1lOaWFkWjExcjQrUDljQnJH?=
 =?utf-8?B?QTZyUmZrREVDb2lMUEZhZlQ2RXhTOHR0NnFhR08yY0p2ODBtcTFRREwzaEFr?=
 =?utf-8?B?aEE1TDVrSjRsYlM2WkJZTWEvTWRkdEV6QVpJbnZSZGZUK3VEZjJlRkU2eVg5?=
 =?utf-8?B?clRuYndaNWhtTklCT1MyQlpDWU14d1lVQjAwT2d1dnhieGhhcm5uRDdKUFRF?=
 =?utf-8?B?aURSdmpXNGExMTlXODMvYVU2ckx1RW5scVFlR2pYUURSb2dwd1R3OTN3U2pz?=
 =?utf-8?B?UDU0SWdJMGpKcTU3c0lCcHZtbE9HT3FBNGYxbWV2d3FmdlU4aXJRSnJmNTlS?=
 =?utf-8?B?aWNiRHJreHc0OHhlTXovN0UrTElPL2VsWTBvMXk1Z0hYdFd3cDFnMFZhVlZv?=
 =?utf-8?Q?3EKh9kNiudM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWxZano3bXJzcUF3RnIxcGd5RzdjN1BZbUpJRHdmT0QvdnBCdjF1SmpvZlFF?=
 =?utf-8?B?S3FYQnN4WHY1NUpvQjFpSUovNGsrQ1JscXhOMnVtNDh0Nnh5SXpYbGUvVTF4?=
 =?utf-8?B?Ym9BNEJYc0lNdHhueGNSOHFFazFxZmR6cFMxeW5MeUsyZ2hCcGVhME5zeHd5?=
 =?utf-8?B?aUpkU0JETC9HcWorWEN4S1EwRlR1aWErb0xlZW9YNTNNQzdScHFjUXh0OFR4?=
 =?utf-8?B?S0czNjVFU3ExcXpGVmNqMzFadVdSejk0WXQzNWhlY0NTMHZTLzBadkYzNHdZ?=
 =?utf-8?B?cEJzTXNWUWtUcWZWMmRvUWdkVUNBYThTZnRmSXh6elREVUkvSjBhbExCbkZ4?=
 =?utf-8?B?dlJhbEt2RlhTNU0rMS9zTE1NWXN1TTE2a25zRWs3U2FETHEyT3RpVzg4ekMy?=
 =?utf-8?B?UWZOcXJ4VmFvWG1mR2h4NkJ2SENBemEvMHhieTQyaEFMNENjSEFVUGRtbWhk?=
 =?utf-8?B?cmp0djAvR21zTTNsTGNCazhuQmRzUkZLWVJYbGNhNjB0aHNvY0Fra1VVVVNV?=
 =?utf-8?B?Ly9rSm9BTjl1QzI2dnpaRGVMelhzYWUvaExRdmNIejV5aDBobERNUFNCN0V3?=
 =?utf-8?B?WnByd2ozMGcrenlvdmFtQ0VucHJTZ05pbDBUY3BWNUIrSkxtdSs2OXVKaVlo?=
 =?utf-8?B?c1dkaXlDa3lpc2tHdTcrSUxwczBIQWhtT0Jjb01xbmxlK2xqTHNiNWpmczVt?=
 =?utf-8?B?MnY1MlRPNjhEKzNUQzNWMEVNWHplREh1UWJlWVhRR3J3TzE2bnFnazQ2VDR0?=
 =?utf-8?B?eVBoVjJxM3pIVVVGYmRoWmV1L1JpR3FRT2xzSGRtZHIxTXNaVklrTy81aldv?=
 =?utf-8?B?Ym1maWNodjFZb09XOG8yUE9WNHJuY2xYTTF2QVZrZW5ZeHl0WXFEQ0ZUdDJ2?=
 =?utf-8?B?QUk4djloR3N2MENhWjFnQmIyTTBOWTJERGFxVWZjZ3V0cTJyTEV5ZWFzZGJL?=
 =?utf-8?B?S3RlTFh0bTZmcTQ2b0hxRU5kN3NYMnlJclRXWTBGYkE1MGxKTVl5QTJJWnRt?=
 =?utf-8?B?U3dHd1BsSDNqbTI3alkvRnIvc0ZvN1BFekpPTVJJcUJ6cDZPcDhaamtaQTRB?=
 =?utf-8?B?K3o4OGt4QXk1eFZsZTNrbGR6alVQL3VZWkZSU0Q3ZlRhRlZYaS9hN2UzWlNE?=
 =?utf-8?B?bDJLSERPNHd2S3V5NnZhbS9iM1BURktsdVVLV0MxNUFIaTZxZTl6L3NzS3ls?=
 =?utf-8?B?akRnYlJCS3NiamNKZTBick13cUZYcHVLVzRZNEVIdkR1a21rYmdNandUODdN?=
 =?utf-8?B?enBsWnVRTnFLTXFlUDkvQlZ3Wmp3RFBPSGxMclI0b05yclN4a2crZFIxdmlW?=
 =?utf-8?B?QkVGYzc5ditNbmJKc1ZwMjRGSGJwRm1MM0RJRGpISjZmVHlIS3BmQ3JreEZp?=
 =?utf-8?B?R0YxVHRoQ2QxZ0N3YUc1Yk1TQms2SS9WZVcwU1JCOGV2aGVyczJqOGZ4R1dw?=
 =?utf-8?B?WW54eTN1cko2YXZITGtXbmIrSnI1T2VvajdHMlhWUXNXS25HNlpUZXNYdWVE?=
 =?utf-8?B?N2lRVVVpL2g1V0hPSEZ1enBSWlRReGllMGZycTRBRmp6VEdaQXFXZEtNcXF1?=
 =?utf-8?B?b2RBb1R3cHhsZTE0cTlxVVBBRWU2RWFJMUd6UWpOTS8yM0ZKbEtBa2V4Q1FO?=
 =?utf-8?B?SEJiNXRLMUdlNCtNQmw2QVhub2VsYlNnK1BrRUs3cjBrZVZQSmFLWnlwQ2Ra?=
 =?utf-8?B?ZnBCMkJnekcxb01pVzBHQ1U0MzNzVEdhVWZwRndKZjVYanY0dHRNcUVhZml6?=
 =?utf-8?B?SG5EWjdoZWd0blVvU0owZzRSOVpmKzViTCtmWEgwWXJkdGJjUzlVeUJRVjdU?=
 =?utf-8?B?aWlPTWJsRDVBWUdzZ1NURkVVd2RZV2ZrTVhxNzNJYXp2TThQeXlKV0oxZm94?=
 =?utf-8?B?V2RjV0VqWXUvbG5VVTh1eTBoUHVOY1UvMjZRcFdPTGx1S1V1bHlPZVlGWmdB?=
 =?utf-8?B?Q1BsZzV1N09MQ3NoUDg5bDdYdVpYOEcxT2M3cGlyN0F2YnZQUUlEdEFIY1NT?=
 =?utf-8?B?a29ZQm52MTdjM29qQTRaYUdISVBVeHAvZ3VkZzBNMHh6dlhoMDdJTndhS1Uw?=
 =?utf-8?B?cjRVN21oRXhaM3doNjNxSi9uNWlBQXJ2MGsrNEJwcDRHbXhwRzFIcWRhT09V?=
 =?utf-8?Q?NMxk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbc9ca4-da38-49a1-a5ee-08ddcec73ccc
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 17:42:07.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfuWkacxdnEwAhuWxaqyKDnH3j3YxY5JM/CwtB9pMxXAkhJBhtdbby34Pd2GBJ7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

Hi Hc Zheng,

On 7/29/25 11:49, Reinette Chatre wrote:
> +Babu
> 
> Hi Huaicheng Zheng,
> 
> On 7/29/25 12:53 AM, Hc Zheng wrote:
>> Hi All,
>>
>> We have enable resctrl on container platform. We notice some unexpect
>> behaviors when multiple containers running in the same L3 domain.
>> the  mbm_local_bytes/mbm_total_bytes for such mon_groups return
>> Unavailable or delta with two consecutive reads is out of normal range
>> (eg: 1000+GB/s)
>>
>> after reading the AMD pqos manual(), it says
>> """
>> Potential causes of the “U” bit being set include
>> (but are not limited to):
>>
>> • RMID is not currently tracked by the hardware.
>> • RMID was not tracked by the hardware at some time since it was last read.
>> • RMID has not been read since it started being tracked by the hardware.
>> """
>>
>> but no explanations for unexpect large delta between 2 reads of the
>> counters. After exam the kernel code, I suspect this would more likely
>> to be a hardware bugs
>>
>> here are the steps to reproduce it
>>
>> 1. create mon_groups
>>
>> $ for i in `seq 0 99`;do mkdir -p /sys/fs/resctrl/amdtest/mon_groups/test$i;done

Looks like you are creating 99 new groups here.

You can create more monitor groups,  but hardware cannot count more than
32 RMIDs(or 16 in some old hardware) at a time.


>>
>> 2. run stress command and assigned such pid to each mon_groups , (I
>> have run such test on AMD Genoa. cpu 16-23,208-215 is on CCD 8)
>>
>> $ cat stress.sh
>> nohup numactl -C 16-23,208-215 stress -m  1 --vm-hang 1 > /dev/null &
>> lastPid=$!
>> echo $lastPid > /sys/fs/resctrl/amdtest/tasks
>> echo $lastPid > /sys/fs/resctrl/amdtest/mon_groups/test$1/tasks
>> $ for i in `seq 0 99`;do bash stress.sh $i ;done
>>
>> 3. watch the resctrl counter every 10 seconds
>>
>> $ while true ;do cat
>> /sys/fs/resctrl/amdtest/mon_groups/test9/mon_data/mon_L3_08/mbm_local_bytes;sleep
>> 10;done
>>
>> ...
>> Unavailable
>> Unavailable
>> Unavailable
>> 61924495182825856
>> 64176294690029568
>> Unavailable
>> Unavailable
>> Unavailable
>> ...
>>
>> at some point the delta for 2 consecutive reads is out of normal
>> range,  (64176294690029568 - 61924495182825856) / 1024 / 1024 / 1024 /
>> 10 =  209715 Gb/s
>>
>> if I lower the concurrecy to like 59 or lower, the delta is in normal
>> range, and never return Unavailable. I have also tested on amd Rome
>> cpu, the problem still existed.
>> I have try this on intel platform, It does not have such problem, with
>> even over 200+ RMIDs concurrently being monitored.
>>
>> I can not find any documents about max RMID for AMD hardware can
>> concurrently holds, or a explanations for such problems.
>> I believe this could become even severe on AMD with more threads in
>> the future, as we will run more workloads on a single server
>>
>> Can some one help me to solve this problem, thanks
> 
> It looks to me as though you are encountering the issue that is addressed with AMD's
> Assignable Bandwidth Monitoring Counters (ABMC) feature that Babu is currently enabling
> in resctrl [1]. The feature itself is well documented in that series and includes links to
> the AMD spec where you can learn more.
> You show that the "Unavailable" is encountered when reading these counters from user
> space and I deduce from that that resctrl's internal MBM overflow handler (it runs once
> per second) likely encounters the same error with the consequence that overflows of the
> counter are not handled correctly.

Yea. The huge numbers are due to overflow problem. Kernel assumes there is
an overflow and adds a big number to account for the overflow in a
subsequent reads.

Yes. We are trying to address in the new hardware which is mentioned in [1].
> 
> If you do have access to the AMD hardware with this feature, please do take a look at
> the resctrl support for it and try it out. We would all appreciate your feedback to ensure
> resctrl supports it well.
> 
> Reinette 
> 
> [1] https://lore.kernel.org/lkml/cover.1753467772.git.babu.moger@amd.com/
> 
> 

-- 
Thanks
Babu Moger


