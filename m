Return-Path: <linux-kernel+bounces-884601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F7C30900
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F23BCC5F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54762D73BA;
	Tue,  4 Nov 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YylJLmNv"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587432D3755;
	Tue,  4 Nov 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253064; cv=fail; b=UFEeOHkJfEE2chFs9Sro+531uqeqldkVJpm1pjUW+A7QXM/6UdVgscPEtBX9DKmqsAfPdgnnu5kNL7UvHdZ6MwZmq8TbWyEl+DFbMky4MrT/v5ly24+0kM68A4sykzg1vXEuyUzObLHBc0Btbs/2+/mYwcJEHXPu4JS7BrSt+Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253064; c=relaxed/simple;
	bh=38650MfUPEQiBRzIKHh1khjVYWuN1J0QlsfodDbqeaY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=et+/AXveWZOJYqANXahWgsUA+Yvm4bJAVsNQTEW07Ffi/Nsq76lbdwOc0kIWL9jV9nI+s5/CfypGspWgHnd5bSRy/43Qw6DfMC2x0VFirTOoRWjG3/Ki4jZpzlY+YO+Ju+EjcO+ZnCbhdtQ6TJ7uSNcuq7taSK82Q5V179Sjdag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YylJLmNv; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBfWF5N43FiNzZNBC550UJQNW5BtXQgsJ/rCSJ8DJ5F7vyzrdt4GJB6ahNIpxIgigWsY8+Osb0xvN//ptAs8JHMvAU22Lem318Mw8qRG3EaagTe0VULUmpcXJmn/o68d47VzYRa9uEc8onhqoqNyl9sngIos6BODmn7QLLAGoZvg6IDpZeQ49idoegZpLJxDm4qh7bdrVtA4hiqKd+oPyZzjOrT4KSbuQXe70T99Mt7OT/frQK4jsa+G0XlgYHxAegVH1tUT9qz4irD8R1RhF6JgDIu4rJidm+8SKKr6dZz7wMbUUIgIobiHDArYqAIxPt/MBU7PFzJFbNZkQk8raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38650MfUPEQiBRzIKHh1khjVYWuN1J0QlsfodDbqeaY=;
 b=yVCZdCjUAbvDdZsR7ZkMGn9KKxTExSSHcxxvYUzzisJOFIblmsOh5TQ9DlGXR5qPEnkA1H5oXv9KMWBM1PmCEn34+FxFff4O64oyTvqYIJ6IUZ27CPgtymoxeDWVsXCNg+TAYTUKS5SKo7ZhNRnzrMSiEn35fx4Mkodf6MCsWvhqrj2/pKLCgnyPbqVF0qCIzQyIdpzqbhEYSMMcFS5ZDMgkuN2EJcmE3zPlZf5EBXn+uOSj/enG8o8ue1JnMIlPHypK4GHH/Fq8GvlxCOmLN3gDd+Pm9sKQBIA/5uiKzhUYaZBORJ1u+avOfhIiYmvAq9PtxDnNLiT0h85G6N+z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38650MfUPEQiBRzIKHh1khjVYWuN1J0QlsfodDbqeaY=;
 b=YylJLmNvs8cIx/Rjz9LTf5REtFig3qckoPEp/wdTCo9KJRyXAzWlUitc/odtRLN+xVhYLVPUgJOHLRMVVjKaEJgvAuf+x5MktuoOwgHWa4l5q8RuV6js8VWdZjcH7ZiVT57kLeaCDP7JrzsnPzyYTmGC1aoi23RTp7zhdg3dUln2RwGLLq9ctLAMnRICUYq/kwREjOXtjVprNTAB2mSssLeu2WRVvXU04Q+FsnkvHn8VkLFaZ1NrsQhqnkr2T+LDlZjo4QHMuZb28OsFxNWQhNrFJPrVkUFJU+9qOQeDxWA55oqRblvA/D5M28bOCssq18GmRi4wzrhF8c8s3Kj4Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 10:44:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 10:44:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 19:44:16 +0900
Message-Id: <DDZUKLS2RY8V.48IYCRHI2L2M@nvidia.com>
Subject: Re: [PATCH 1/2] rust: dma: make use of start_ptr() and
 start_ptr_mut()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251103190655.2326191-1-dakr@kernel.org>
In-Reply-To: <20251103190655.2326191-1-dakr@kernel.org>
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e17cae-5aab-4c06-f18d-08de1b8f1ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU1RWVMvdEZMa2czbVhZaEorUVFGWjhUN3pibG1obTkrTkNKaC9aVExuOElw?=
 =?utf-8?B?MUYxYUFyRWJZM0wwcGxRMWVGZGU4b1c1aTRoWUlGd2hGYzJDRE80dEFjNDNn?=
 =?utf-8?B?QmlNbG1EZnUzTmRVaFA0NTc0U0JkbFd6aGdDKzR2VkFPNFl5MDM1bzd5TjVX?=
 =?utf-8?B?OThGTTBndld2OTZSVWZ6VHhxdm5xY3RycWREZWw1dFhRNFdtNWJKQW8vSmx4?=
 =?utf-8?B?RUYvVng2emNyMlRvWW5oek1yVU9qM0NMMTF5U2lyNDZsUVV1Rk9JaFlvSUtV?=
 =?utf-8?B?OWxYNVp6eG9SeHBuSUw5Tnh5T2VTVEdQaEVySEFPSUsySjVVTWk3cmI0TEx0?=
 =?utf-8?B?UEd5V2RyNTBDVU0yWlQ5SDMwT1lVWmYwUHdSWUpnTXlzSkZyaEtZWWh4akV4?=
 =?utf-8?B?b0tXc2libHcxaGcrTTMvcFN1eEJCS1djMk82SG1XRjN5Mm4vaVBhZ0tsWmx2?=
 =?utf-8?B?aUVOaHdreTNUZXlpa2RFaEN4SVIvNFNPTHhvTTRXa0ZoQ0lMR3JjSmJPV051?=
 =?utf-8?B?REo5Z1lKM2hOWEVHVElRWGtYd3p6SnZQRys2SFJnNXJVQVI3WFFVTVZ3bEk1?=
 =?utf-8?B?TzBHVWtZNy9uZ3JkZkJtWnQwVVhJejFDSTNhRXNLZzQyUlVnWEVGSHRQQW54?=
 =?utf-8?B?OGNOUVpuNTdBN09SVVpUWlYxZzVCejF4bmp0SHNCZ1BuMGppNzl3WWxHRUM3?=
 =?utf-8?B?bVd0SVFFZDREM3hJK2tGUWdaWjFzbm1oWEFSc1lnbHhVNWNJRENxSzFmNXhw?=
 =?utf-8?B?ZWprWTh1bVlMMzVkdWI1bW9rMDZsaDJGSXBCaU9xazQyajdjZWQzbm9aZVc4?=
 =?utf-8?B?Vit2bW00ZVFoUkFMVVNQc1RYTUxLUVZSWE5PaTBnMFJJSTM5aGlIY1V1bVRF?=
 =?utf-8?B?T0VEWm5lSGwzTC9mQmJVUTgwalB3dzZjTFZzNXV1TkVXWUxRNjBZVHFKRFo4?=
 =?utf-8?B?UEpKanpFMXdjRG5Kb0c4bUNCU3VPaVlaYitJV2RJRDRtRzYya0xwY0lHa3N2?=
 =?utf-8?B?V1o5SytsNGdkbWpOemVBTkFoMUR3eTVUUzk2VkF5VlZMdkFyWEl5aDFNWHFk?=
 =?utf-8?B?a3hhTmc0c1JJSXE1ZDJlQkhqUGVZeGdxRFZ6ZC9yUDFLcm9QdTBsOGN3cDVo?=
 =?utf-8?B?dmxQK2ZRbmZSVUllNy9VS0l3Y0xNNzdMaDFUMDVWeGcvek5xQmVHZDA4WWFq?=
 =?utf-8?B?Yjl2NEJUcWtSSXJReWVJWVRpM3hkQnlubE01U05KZURhUzZ3WS9JdHZsdzY4?=
 =?utf-8?B?Zlg5SjNvK2dTblQ5ZDhmNXNFNkxnVWpzUmUvRUxZUzF4MFExR25OWVhRK21p?=
 =?utf-8?B?RnorQ2hiVW9JNE43UWNHWkVqSzlBVlFEOEFJZU13WXFaQTZ0aHFtOEN6eWpJ?=
 =?utf-8?B?UFhCN3pVQlExNDc3UkdjODhCek9DWGZzSVVPSXVpc0dxRXBsOUJVWmxyY2J2?=
 =?utf-8?B?eGQzb2w5U3A3dittck00ZDNQb1M0QnZFbWJGSEZrb3VESElFVTQ0MlgxSUpa?=
 =?utf-8?B?MUtoNnJUaVdwQ2dqM1VCUzErdlZOY2pOZFBaeW0yYjRCWE5PTkFSQ2NXUTdD?=
 =?utf-8?B?dXFETGM0eUVwcm14YjE2VmoxNElTQVdOdS8xVDB6R1l3ZzBmd2ZxYUxITlVz?=
 =?utf-8?B?ejJMTGlMdFlFRDd6RDJQZk9ORnFsNFo1SnY2ZDZTL1FhaWhPSUU3WkhkUnJr?=
 =?utf-8?B?cjcwQjM0Y3cvUEhyOVdTTURHaXo2M0pJdFpBMVNqL3cvS3B4VW12YTk4WkJ3?=
 =?utf-8?B?WDV2SHlXOGxPNE9KSjhVVlV3c2NIa0o2T084YmIxd3VXMjViRDBnWkNaMkl6?=
 =?utf-8?B?STJORVc5WjJSNGZTd00xdVhFYXpYd0VSMVQ4MzZlczhINFJ6RENONS9NNWF6?=
 =?utf-8?B?M0FYZENrVk81d2t3VlY3a3U5UHNPam5xdUxzTGRRRmphc3FnR1QrekljSnZC?=
 =?utf-8?B?WlZTaXhwQXF6MkJxazMxZkI1S280UWtqY01aL1YvZi9ocEJSazZPaEFwaDdJ?=
 =?utf-8?Q?JWmYvRw5RdNWzKCoV0RVvkEbGcapbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2diVlhnbFNzT1RrWTFyT0lhTUtveHVmQUlsbm9naEtGK0R2eDBxdSs1T3or?=
 =?utf-8?B?RVRIanJGek5ISmh5VmY4dVY5SEY2c0xhd3o3UGRXcStxUnZXck5vV01KK0dI?=
 =?utf-8?B?cm1BSmdUR2M1TG0ya1R3RTdiZXRTTFd4SUorR3Njd0ViQ3pCVmRvSUJUNVlu?=
 =?utf-8?B?UG42M015RTRnQzY5OFRjc0lkZTR1cUlhMlF2WEpWdk9NaFJ5VTlHdGpOMGps?=
 =?utf-8?B?SndrTThDSVQ4Q2ovVHh0aEFUbDlGVTBvMk9UenFkYTRQeVdoVGhtTVAraWVK?=
 =?utf-8?B?LzdUeklJbVdNZ1lGUDlKTVRGazlEY2pPQkU3WGlxNUxCS0kxMGUydG1XNlVj?=
 =?utf-8?B?SzMyYmg3WVR5MFp6Z1F0Q3I4bU9Bd1VkK01zSXl2ZzhrK292S3l1K0NPU1p4?=
 =?utf-8?B?MzQ4SWg3TEJtaXBiVE5HTkxxYTY3UTJHdEsrTFZFWFVIeGhrMDNqL3hUOW9J?=
 =?utf-8?B?TGhValF6d1RFMkxpY2FWUVV4WGxFUVhvUktXdThXQURhUlhucFRzQno1VHRr?=
 =?utf-8?B?MGdaQXhFRWtZZlRvWHROU0xjRjBWVFVpOER3VzY5QjZPdXhmd2FBNUI4WFdX?=
 =?utf-8?B?TG1yUkRzT2hwRmtrWEdvek1teDJUdjVPTFc4WUJ1Q1BDMnJPYnBiT1dBUzk3?=
 =?utf-8?B?aXFpMWNuNXFKem1Vc2R2RXQwbGtna1lWUE5RZDlhN2NXMjlWOXd3Q2lzVnhS?=
 =?utf-8?B?b3ZkNTZGTktZdlplQU0wS3VvbWtuZWFUT21lRXh2UnR4ZXZiNTY4ancvclhr?=
 =?utf-8?B?QnJZd2NyU1hDM2xZdzdvU1dySmNDMUhCQ2NqSjVoenJFcHdlZWU4aVNSTHVC?=
 =?utf-8?B?dk9pbHBPeWRpQWlCdk1qdy9QYUI2WGFwNUNIcG1VTFUyd1ZuZU5CSFVuQW5W?=
 =?utf-8?B?UGF4Y2ttd0RtcWNpa3lxVkE4Q3RXUmtrempCTjhiRnVUZ0NmYzREUngxcUdY?=
 =?utf-8?B?Yk51UEV2VUFCUnNhZFpqMWlNbnQ0WDVWUVR6dXB3UUN4VS8rZmlzTTdKLzlm?=
 =?utf-8?B?dDRaaHZoR0pJdTJaTVFXWExaeDB4RStXMTJPalFaa0ZjcnVKRTZOSGJZdkN1?=
 =?utf-8?B?ZTk1ZlVJYXl6dFdRODhVYnhjL3dKbUxESTVSYURMTE1FWGZUdndncnRCM2dr?=
 =?utf-8?B?blBXU1NXcmgwMjk5UHpNVjdmaUt6UkRkbDFzanJzMzF1TlFzcERuTUh5U1FF?=
 =?utf-8?B?WmpkUEtBUmpkZnk4aW5MQ3JZNnBLakE4VzN0U0hsb0NLWW03eFZGckhzMlll?=
 =?utf-8?B?NG9mOCtZYmRxM2hUMDJzQ1VqdlhpdmppVGVaQnBIM2htOVVaZXUzR1ZUcjlx?=
 =?utf-8?B?U0lFcHcxYnBmd0ZROVJpNTkxcnJRRzFiVHVGVit5cTIxR0FUanl1bjdPL2tQ?=
 =?utf-8?B?VFhxV2RZVUdwV2JmS2xTTkd6cGpvdCtnZHJ3Z0F3VExOejBMdWlpMzhQQ2dS?=
 =?utf-8?B?b2pFRW9WYVB3S0FJY1BpcXltb1ZTY0srVDhzaTRraEUyYzhzRW9hZDRCNVI0?=
 =?utf-8?B?ZTBSMFpvNmlKZHl4N0ZqRXB4WlB1eGhmMGpXZGltYVF3YjF2c21oZCtYbHpi?=
 =?utf-8?B?K3YyeldISzRCZkd4U1BEWFVNTTVScEVOOUdzMVlITS8xZFF1WldRRWlVYUpR?=
 =?utf-8?B?UTBhMzlMQlhWTzVZd3hiQ3d0azEralhPWHBoSjl3NlU1VlJLV2ZPdzROSHQw?=
 =?utf-8?B?UVIvZWoxdnZ3WGxaVWdWa3h6dE0yaG9Ga1pQS3kxbHdiS1RQeFBIYTBCWlA5?=
 =?utf-8?B?S09vcGJ6ak04ZFFTblBWWmJYYlFMbXFPbkhqWmJsNDc5ZTdQcS9VT2JKdlhE?=
 =?utf-8?B?TTM1NUlwL3lUL2I3Vk56RGZaaHpuS1VWektFeXBwTVhqR05rZStmeTc4TUFS?=
 =?utf-8?B?dWJmcG9LWVBpcTlndWtSZUdBUmE4U1VTRE4xYkQ3MElITUN4RTJkbTJRRXZx?=
 =?utf-8?B?dWhWVlBrdHYydTYrNEdHSktvSkVvVmRGR2F5MVZYa2pTSHBFcDhuTDZIWTlP?=
 =?utf-8?B?amhSRk9qK3RIMVlqblp3bWdBcUdNQWZpemVGWXEvdDFEdHIyajhaSTFhQ0oz?=
 =?utf-8?B?OW55eFhueHRGVERncGpGR2RHZ0JIYVFWWUtCRmVaOWxGbEVKZm5CVzVrOG1C?=
 =?utf-8?B?ZmowTjFZS0FzYm9KNHdyVGZ1YUpXcnU0UnZIMGl3dGNFc2Ewajhqb1JPTjBh?=
 =?utf-8?Q?KrGvyOBHh2DdBOm2GwM41oN9iYDvD41fS3ThiX74xQ2e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e17cae-5aab-4c06-f18d-08de1b8f1ba5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 10:44:19.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qcd6sEMh2Vfsk+fuze3K/R18F1BHabtHs3BMe3aVw+bdShnAJPTEimSX/cTo8C+wOB4G9lCL+B4T9Ren38ykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825

On Tue Nov 4, 2025 at 4:06 AM JST, Danilo Krummrich wrote:
> Using start_ptr() and start_ptr_mut() has the advantage that we inherit
> the requirements the a mutable or immutable reference from those

Typo: "the a"


