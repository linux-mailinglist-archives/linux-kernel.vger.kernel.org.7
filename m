Return-Path: <linux-kernel+bounces-801426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9DB444E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF486A61732
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED8321449;
	Thu,  4 Sep 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kGRS8du9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B93148C9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008462; cv=fail; b=inW9wHsvevMahj4qHk5tiUAy74odb/UlN1ziVlc5x9mYV6qdPGs4UN7urzScAdNWni1veCTp0vcamQ/JX3GUe2XneD20e4v0fGXHgjLQdfitglCNLEGecOQxGL+cUtDUd0ljDWQ/L9BwXKLt2QU2qq1Ehp+N5xclLfoYFPPFhvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008462; c=relaxed/simple;
	bh=ZaAsoqDDkI1tyfAIJWy153JVm9vMfuecbSv9TpcKxD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N29qvaYFeBACBVjWurDPmBExQQGu4X+kxOjfDu3eUFFcIylIGqO8jDevt1NgtzC8XrdG2IDTKPXd4minJxkonxo2hBabrL2L9HOhfsNWGdbYWVAU1T9Xd0FQMIF/8CIrtUX4k6c8HXWJc3/Q+1lcUQyctx9r1XZZ7QMXJen5JRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kGRS8du9; arc=fail smtp.client-ip=40.107.243.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNvbhMHAY/Gz4QDpLrAqYDatChSileq0LTNX2vO561D9IqxdzzsR0YwdiZ4zdHrIVZCfYOwV1hRNP3doUpmMJG9Oj+2WLfSz4C7ssR8+ZJo07KyXbvNlW2FCiuiqM14tNzVzTyjyCXCl20cu119E7ybBlYnmX2w/AWZL4Rbymf/9KIJLvPAI2yizPwpP7zTA4sa0BwR5+lHi3F32NyxLjPDza7HH0QkMnvFpToadCa5XSq0VdHGGi2AiMMQKYFpn1lPDbLOn0LP4GkKViEM09gaAJu98K8p8fpVh6UC80ER72KfQbn0/R0fLKhnumLOLLC1/YYaR6WvC7K31ggV84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC/h3QfKMJzrRDSZDbq93SJp3ae5x/zr+tomjc57MZ4=;
 b=IpQt1Ciytex5Psjh988n2GgL3abmpDOHhwo8H9vI/bK2PWkYJvGIZPC7Q34tDy9VkP2/ukfmTgu0fXlzbiKy2D6jZt0zm+l2GVyWAH964IAeIaTSDQxQFf04HVCv89eEEURX27IJR4UdWr0PWFcx+VFB7NFG/SPHnJWELkLZnnGI1buWGnrUnXuPXn+xh7WPErfyTUGUeY9/vStuq9snTvxujcgGdyk65a4MtM3k+tOqwAXlr9obVmax/d5lYeoZfeEa7AiDr4M+WuXf+RA4Z+yzL7lYrS9C/DRYcw+xKiFCZmr0OkzpPbT9s06GFTQfurRCoxsO3k9MCRvm+IRwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC/h3QfKMJzrRDSZDbq93SJp3ae5x/zr+tomjc57MZ4=;
 b=kGRS8du9PfHMDZo2AcC9NDA5oeNPmPyVCTu3c2PjpsxJyGymjcRLq+l3wcGefbCRv8b0LSJ3dKq+metW1+zBFS3R25sI6tciF7IB7h7HWNZZzG9BKaIAfE0MLR5x/7QF6nY08ZL6jSmWea+BMlhSN6bZSBW/2449sS4XW0vRGIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CY1PR01MB9243.prod.exchangelabs.com (2603:10b6:930:106::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 17:54:15 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:54:14 +0000
Message-ID: <1c9093da-3ae5-4d13-a56d-592f92a63d51@os.amperecomputing.com>
Date: Thu, 4 Sep 2025 10:54:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] arm64: mm: split linear mapping if BBML2
 unsupported on secondary CPUs
To: Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-6-ryan.roberts@arm.com> <aLnFd1Hl_FSHZR3z@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aLnFd1Hl_FSHZR3z@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CY1PR01MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0214ec3d-000b-4ddc-ee7f-08ddebdc0f73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MExkN0RBaGVXcjRySzEvTHFnU3lTUUVjcFc1c2FoZTZzYXQzeDg1OHVvbk5u?=
 =?utf-8?B?alBRVS9SenlOUk81VmxvTEw5WW1nREhtU1hWc3o5L1pCK0lSYWMvVGFlR0RQ?=
 =?utf-8?B?Tk9ja21yKzlsL0JCSWxmRVoxVXhqSktScDNjWWYrRWlVVVEwdGpxdHlMbXZj?=
 =?utf-8?B?bWlLZEpKcTh3N0tOTXExN3hJYnFQdWFodFo0RmlpTlZCL0pWMnY4eGhoNyt6?=
 =?utf-8?B?RGpGWFRIcWhwc2hsSEJZdTRNMStxSENFRTFjQ1o1Y0VmWVlFUi9YamNaMHg4?=
 =?utf-8?B?V0NZdUFLSlhMUktxODhjYmlIZkFVbEF2VnBHOHN4WnljNE16MXRTSnU1OVRt?=
 =?utf-8?B?SXhRTGpBdk4yNWxHMit1UHVqeU5XcTNIUmZnUzhLUzRyT2hNa1I4SXNOZEtE?=
 =?utf-8?B?d0R0RUNrb29VTEpVUEEzS1lCdk5saGF2bHNXcTM5WEVLTXhFZHdCeU9tNVN5?=
 =?utf-8?B?amlBSmpmVDE5SzFtbENPekQxbGF4bU5naVkwYi9pS0IrZkRTSEtsdklteEZm?=
 =?utf-8?B?UW5weWFZRUZ5d3R5OUNxZGcvUkRja0NVNFZuc3diVzFsNCsvbFF0V1YrVHJS?=
 =?utf-8?B?NDRHK2pXblVhbUN5R2UzaGxleHJWZ01CbVU4aWcxMUpLRzdCTWJUcXROdTdq?=
 =?utf-8?B?dmI5dlVyclpnbC9xTktQTU5HeEFxdEhRTS9mdWhZc1kyWG5BYUZGbFBKT1hO?=
 =?utf-8?B?ZVl5bFFOWXNWNmtWM0ZSdVgzZW1rbExuWnV5V1VySW5ucUpneE5ZTHFuQVo5?=
 =?utf-8?B?MENTY2FrdmNlemxOKyswbHRMcUxZR01YZjF1S0M4SDdFMVpHVkpRSDJ1YTFu?=
 =?utf-8?B?bi9zcU5sSTZKaGp1eFh5RHZDVkt4MHlCd0IxVXlQYTM1Sm5TbWVKYXZaUDZq?=
 =?utf-8?B?cUZaY2w0ajlGRFArNHJwN0MxNUxJSDZWY25WZm1uOXRIVUd3YXZWblJ0K3pS?=
 =?utf-8?B?UWY5Z0ZGeU1BVlZPcXhhNEZ0ZTUrOE5HeXlYaERrTTBoT0VoTm5nSm1ENFNs?=
 =?utf-8?B?bklmdHJIK2t5ZlU1V3MrN2h5QjlFYkZJUzhPYUhZWUZUTFBpcHE2cHdYN280?=
 =?utf-8?B?a0NMVlc0T2JPVVZrY2JRQVRYTXVHM3JNNTFGOG8zeldTcE96NEd1OWgwd2pq?=
 =?utf-8?B?WWtIZlZPdXZTc3FHOXI0bVRDSkNObThQY0FNT2lOK0JZVGk5cEE4L0Q4L2ZK?=
 =?utf-8?B?YU5kMzZ2bUJUSXYzN0ZCeTdJS3BJYUJESjUvMDhkM2UybCtGc3hoNkdVS2t5?=
 =?utf-8?B?dlViUE9JMTVKaGxMaUF0Z3B6TEdweWl5dmJRNzdiVmFaQzFucFk1d0J3QUJ4?=
 =?utf-8?B?bEltVEYrYnFHWlZXSW5SQUZTZkdzUlQrejFIb0JkS2M0MGxiTG1FTjFFaHZI?=
 =?utf-8?B?ZmNWSG5NaTl1Rlh2WXhnOGlBd3hmbWhmREhZL1BxVUEycTJnNkR0UmRjWEU0?=
 =?utf-8?B?OVlCSWlEbkltYlBtcGZlZ0hkMlJncHNyb0hlMTBabTlXdFBpN090cmNxVEdp?=
 =?utf-8?B?WlFUOWVIdDMxOWs0cnFKamVRSHlieTBNdFFXZzZmS0ZiaGhCNGR0Q0RlVGxp?=
 =?utf-8?B?Y3F0ekpNemZHdm5iL2ZRc2MvOUNUSkRpb1RRaUFvb3poOFNjK0puKzR2OUMw?=
 =?utf-8?B?ZnVHTnNxMHdSaHJUOVlCbUFtN1lFOWdjcTRNdDF2YWJiejY3ZE1ZTzQzSXB4?=
 =?utf-8?B?VmdOZFNPVE9USFhzSXNKcnp1ZXdWRnJ4SkwrRlpUd01tY09mRnZkQ0RBQ3Jh?=
 =?utf-8?B?UG04eHFZbC85eTM1Y0x1eEFKVWFYTDNnWnlTbll0aUxuS09lUmxRTGhNZWl2?=
 =?utf-8?B?dXJybmNlaVovUUlXMWlGaXJqZ1p2OU9Ua3N6MDhkQlZLMFpCY1h4c3JURHND?=
 =?utf-8?B?S01qcER5RjdMUzJHN2JkZUNQbFZvOWFjMmVNQzA1S0t2ZWM4ZEFxVVlid1Zn?=
 =?utf-8?Q?qO9ls+r9Aw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVQrSmVsSCtNTGdybWFmV2dBR1h4L2QrdHRzSlZ4U3JSV3BHMmlBQVNJRjVP?=
 =?utf-8?B?Ri9NRE1hWjkvU25zL2k0dkNYbHFzMjhTemozTTk5bTdsMW1FZUlCZlFRNndv?=
 =?utf-8?B?dnpuaXJkSTRjMW9nc25PN3VhZmdJbmlxN1VBSGZ3TUhrcDJxa2dEa1JaU1lD?=
 =?utf-8?B?SHI3eHJVWjYrRi9ORy8rYnN6SFdpeVIwSFM0MXNhdnQzYkUwZ1h2QjBkMGU4?=
 =?utf-8?B?VlRYNWNLKzJQSGF3R1JvNXl3YVYrc1Vua2l4d29uRTBnVncwM1dORmpoTWdI?=
 =?utf-8?B?U2V5RGdBdTVjSWpDY1NwYytiSFVFek1VVHVGZlBETlRPbmJpNEtlRjRxY3FQ?=
 =?utf-8?B?eGRmTnNvUkZLeE51VnZQbFBaeVZDS1VoVUg3NVpmRDVVZzBMVHh3RUhGWE13?=
 =?utf-8?B?V3kwWUpYZGZHNUhBV0dDblJMWnh2cmJySDhIWlBVYkdKaW5uT0VXZkF4N3FM?=
 =?utf-8?B?NFNudkhpV0VvM01NZEkzZHFDdXMzYzBXaG4wSmpHMzYzZVdERXpPNUVIeFI2?=
 =?utf-8?B?ZVJoeE9CRXMwY3JsYmwvZXlrWEtPV1UzOFpROWYvdHUrL1M0dDRsVzdCOVN3?=
 =?utf-8?B?VWdoVUN2a2YvNTZZcWFBNWt2M3I1SzFPVGpJYzNkMWNpYjA1ejhzR2RaY3Vq?=
 =?utf-8?B?a1lqbElyQjV2aEE4NnBxUytTRi9aSU1oQlcvWSt1YU03d1pwUlFCQVpDV0tm?=
 =?utf-8?B?My9xdUhyTTlicWlLVUNRT2kwcHpPKzVyZ3lOc1ZHRXNoNVI4UmRXZ0FURTRp?=
 =?utf-8?B?V0pxYWs1U1h6dEdJTkFnbnR2UHN3bWZKYitRNFduTlhWUTZqN2YyV1dVcStC?=
 =?utf-8?B?SytQc2l4ZnM5NkR3dCtCcEZZNC8zRnpuVEdqMFpoL2FWcFl1NUdCMHN4dDZq?=
 =?utf-8?B?SjNZVFZyWlE2YmdKeUx5TXJHWGFwQ3lvVjcxQzh0TmJ3UkxjRllDNmtmTjNh?=
 =?utf-8?B?N05qTys0STdDaFN3Y2tpS1VYSVA2SEhvdmpkMjBWMTNEZ25hSUlBME1OVE1v?=
 =?utf-8?B?aGh6dmtJNWxHRlltZXNJM2NPL3BraWJXYUlub0t3QWZhdzdiMTRuZys5N2NG?=
 =?utf-8?B?VGR1ZXpPa1FLVVo3S3BSODJFWHZabW5pOGhNdytqSy9DWUdBc0lKV2RMVGFp?=
 =?utf-8?B?b2d1V3ZGWXJPdjhOQ3UwbENNK1JvMjlKMHd4NUlYTjBlMmZrOUN3dnpuWHhz?=
 =?utf-8?B?aXFDTTY0K3FtSHd0R2E0WGIzR0lCQTJiTGx2QW80eWE1Um5jK2ErQW42NFdu?=
 =?utf-8?B?SStaMVlVT3d5Q29taGhLb0tMMkhmRElETG9ocXNOdUZpRlBWZ2ZDbkt4L092?=
 =?utf-8?B?eEtNUnB1SUI4bjNUWnAxUzJsa1RkSHRkdHVpMlg5dnYvZ2dNTFlrSW1CMTlj?=
 =?utf-8?B?LzFnUElrckM0RDd0ZkR4WVpvNHVaQXNxcm0xeDVCaGppdHhyWHFYK1c3MHIz?=
 =?utf-8?B?dElpRVFiVVNCdGVXUVFSd0hxYzJFUXNhdTFraEZhR09PV25kQmpnby92MDJG?=
 =?utf-8?B?THlWKzFncWp0czdWZHVFY2xZQzJnZDUxRmwzU1hVc3p1SWtUbnNBQlpYUldm?=
 =?utf-8?B?ZVBJMmVKWVVOZy9VQVJJV0F1L1o2THNydWdwNW0vNEtCUEdrbDc4aEhidzZH?=
 =?utf-8?B?SVgzVDJCTGd4UWNCVWowZDlJRkpMci96ak0rekdRcE56N1ZEOXRtYmk4MFAy?=
 =?utf-8?B?aVYxVE81N0dFeVhBYUFUV0NUekEwdzlRU3dhTnVtZnRvbmFQcERFZWJDTVll?=
 =?utf-8?B?ZEJLbjVCZGNrZGNBOFMvRnA1L0lzeStyR256ZE51VmdYYlpTV1FkL0xGNXJn?=
 =?utf-8?B?eVJUejJycHFlbzc2U2ZKaE05UmNQK2tQVGtSWnd6em4rY1BGK1dmdmhRNTBz?=
 =?utf-8?B?L2VqSUkzWFR2ZzB3NW83SGdNZjQ5SGU2RjlJeGdiN1ljdFgzZmxmNlg4aGE1?=
 =?utf-8?B?R2ZEa29TNGZUenlZM3l6TzUxaEtFK25HdHZaL0ZZa1hxOGlUYUlhSjZWRllR?=
 =?utf-8?B?TEFCQzVJYUhOcnl1NFY3bUJpeGdaZW5PbGExSFdwbFBFZnJjQVNhaERJOThH?=
 =?utf-8?B?MmMzSzlhOGY0bjNJMDZWbTBmV1ZpS3FwbmVXVGRkb1B2K3BPRUI5Y1hWckg2?=
 =?utf-8?B?KzU4ejFKWG83dTJ5OEJPTXdQZzUvaW10cHkrVmpNK2d0THRxL0FxRDRuai9Y?=
 =?utf-8?Q?YniU0i9JTs8rNJwNkLBKtgM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0214ec3d-000b-4ddc-ee7f-08ddebdc0f73
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:54:14.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw1LO208X5TzTNnfQujIDbOgBdXNGyWYp3f7WHX9I6IMJiIxi5n1HklJ4j96DL2pRyXJULi31xOPsDYTOguB6EzFTd3HeSL/MTHYgR7elAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR01MB9243



On 9/4/25 9:59 AM, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 12:52:46PM +0100, Ryan Roberts wrote:
>> The kernel linear mapping is painted in very early stage of system boot.
>> The cpufeature has not been finalized yet at this point. So the linear
>> mapping is determined by the capability of boot CPU only. If the boot
>> CPU supports BBML2, large block mappings will be used for linear
>> mapping.
>>
>> But the secondary CPUs may not support BBML2, so repaint the linear
>> mapping if large block mapping is used and the secondary CPUs don't
>> support BBML2 once cpufeature is finalized on all CPUs.
>>
>> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
>> same BBML2 capability with the boot CPU, repainting the linear mapping
>> is not needed.
>>
>> Repainting is implemented by the boot CPU, which we know supports BBML2,
>> so it is safe for the live mapping size to change for this CPU. The
>> linear map region is walked using the pagewalk API and any discovered
>> large leaf mappings are split to pte mappings using the existing helper
>> functions. Since the repainting is performed inside of a stop_machine(),
>> we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
>> since we are still early in boot, it is expected that there is plenty of
>> memory available so we will never need to sleep for reclaim, and so
>> GFP_ATOMIC is acceptable here.
>>
>> The secondary CPUs are all put into a waiting area with the idmap in
>> TTBR0 and reserved map in TTBR1 while this is performed since they
>> cannot be allowed to observe any size changes on the live mappings. Some
>> of this infrastructure is reused from the kpti case. Specifically we
>> share the same flag (was __idmap_kpti_flag, now idmap_kpti_bbml2_flag)
>> since it means we don't have to reserve any extra pgtable memory to
>> idmap the extra flag.
>>
>> Co-developed-by: Yang Shi <yang@os.amperecomputing.com>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> I think this works, so:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thank you!

>
> However, I wonder how likely we are to find this combination in the
> field to be worth carrying this code upstream. With kpti, we were aware
> of platforms requiring it but is this also the case for BBM? If not, I'd
> keep the patch out until we get a concrete example.

At least we (Ampere) are very very unlikely to ship asymmetric systems 
AFAICT.

Thanks,
Yang

>


