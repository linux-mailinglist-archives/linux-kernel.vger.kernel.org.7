Return-Path: <linux-kernel+bounces-758483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1FB1CFC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209A9168FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BA2A1BF;
	Thu,  7 Aug 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bLOpMxnD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D650125D6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526005; cv=fail; b=eOA1MgKdMoG/WpAmlV96JJ7mlzRwWuzl1u6kpFUWAEvfA3ITjIKcYNSEsmkNSKLDZINclXHdjLfrbYFJM/YhFXtT6358WVxWkJPksvE9WWZeA36o5O8UlzT1i3JKadLEuR99nc4a8VY+OVqIgcvN8K/ECitTC9Y5kCXsT9tGLOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526005; c=relaxed/simple;
	bh=JF+E8sud6zNQRAgjWrZzbc8VlvF6EM2zQQhbQWiUJzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F7sDF3fO0JySc2wSze6uorPK7rhoSdhiN8hMi7ozuWX/7+QroOM0YWSh9CbejkXsKf/ZiLOScQR9z749Ht42NzaU492o95P62aEOsRi/c+6OLE4Yu5dmeB86NLMDNmV81UWBkLpkRTp2w5dl0s6FED0Km/l1UIAboxI/QvkiILQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bLOpMxnD; arc=fail smtp.client-ip=40.107.237.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUGefzUeZ4N0+0R4n6GLImmy2wZ88Pe6FW/txkUBY+afyN9W2pso2pUnYRx9OXvMFgutl/rEyuJY+FVFNOrpFLBM/Kb0dkZr6R1Gx1oBR5PnPD/JlyfApRR3fGAIIsBRaFa+FHSGPyJSG5WBGmIQNOLiVCMCpC2uxCuaoldUrP4Hsf8Ff18FvZqKdLTMw4GIO4pdrj1bYTXvWxakKiC8KMkQfYCsM2SiZ3FAlBtlmo+7A66NO/Yz5wUx7bqhIkhrDMVVRO0pggx1L2U2U1wXMvkWXH4tIzTvSqpGQKtQu6meHOo/f7fGbYD+BoN6P3xZJOiHVWZaAaaFbSYnMieN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6ZS9XcBhdtrdCpvxQThH+ieb6XTOPSG7mZH0S9jzRY=;
 b=sxqyWredYk/aSo/QeUO8wBOqQ4YAaJL34R2nAC4bfbCMOfj5gqEwD6Sp+IMs6nLQElPF4jyhGH+clU5vUt3zpP6DsJFW9orrG0slg8wtmp5UtxAlxMQ4dIkE2aMrK0IIXsczRGI/CXbyWqJrW2WOJFfezldK2tvaXrw5E+6h/kJlWolzYl778lkYH/ZIBR/f2eQD5o13e/rupgZJnp2LwfFo67fgdi5hjy23gaJbjTX/zbpgJE9aMY0IORNHepIG/3dMX5vSDtg/lgzmsoluV1M9djq1ikeVPS7TuThWL25OWsAYOnOmJVw+bdBAPEE3kw2uVrPUrl7fDlReClXIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6ZS9XcBhdtrdCpvxQThH+ieb6XTOPSG7mZH0S9jzRY=;
 b=bLOpMxnDmCNq6+3cB5hJ1ylZxIvUIzSPMPOr5c22ys0IBl1S+sjUhuNTYx4CzftrUiczpLcJYRI0+8snpb/4ttNHQgQrdp+MxnAFeO29rrD8VVkBTz8VJhT8RGcZpRPHheUf6ePx/hdk70B8zNPntvTTn74KLWJWi9+5r9laCFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH7PR01MB8956.prod.exchangelabs.com (2603:10b6:610:24e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Thu, 7 Aug 2025 00:19:58 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:19:58 +0000
Message-ID: <72383736-a1ce-4f26-8fe6-7de491eff0ea@os.amperecomputing.com>
Date: Wed, 6 Aug 2025 17:19:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-4-ryan.roberts@arm.com>
 <06e63282-771c-48ec-bcfd-b174e94d52bf@os.amperecomputing.com>
 <e68455fe-37b8-4f9c-b7ba-3a2f72d6c76e@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <e68455fe-37b8-4f9c-b7ba-3a2f72d6c76e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH7PR01MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5efc2e-2846-42f5-4e38-08ddd548245d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFpEa2RhWEw3clpTcmxEUjA5YWVnQzRQSlo5SkF5aFh1S1IvcHdIb25yWkU1?=
 =?utf-8?B?dERPOHNncXpITHJzMW4xdEpaMUxJVk5DWVk0ZTBCZ294N05GRTh2dFI5M2dQ?=
 =?utf-8?B?Mk5KakpPNnRYWElTazBWY3JobG54UTEyTzNEc0lDY2FJOTg0a29XUndyOGtE?=
 =?utf-8?B?U0JONWpHYzRua0hZMEZwa3FKeXBkQjV3TENPTzhIcWVJdEF2VTJQN3BDKzha?=
 =?utf-8?B?ZHRneVRHSFRHeStYOXJXdkxFUTRvTHF4NDFrc0d1K1h6N2xrdXhpSVJUZ0Fa?=
 =?utf-8?B?MTI2Z2hqZVNkRXk1UmtYTXVZNk93S2M4U0N4OTYwRVhRdXBSUzdiY1VSVzdF?=
 =?utf-8?B?dlR2aitMRFV5Unl2dldGNlhIZU1qSitQMzB0UDl1dzhTbXJ2WVR0OTkyQVIx?=
 =?utf-8?B?QmhoSE9ud1RuRk5DZU1lM2hvc3JBRVNySTViUjRFbG1OdURsOHFLVzBpclhj?=
 =?utf-8?B?aWNSSGdHWUk0U2xkTklEdmtuQXRKODFhU3IvcGhIZU4vMHhLRXViRWxkRExv?=
 =?utf-8?B?dCtGN00vdU9WK2RTcUJLWDVLbThCRHRTL0xKYXVlMUVpby9JZzRaOVNRdUZX?=
 =?utf-8?B?blRia055VEFCaGhwMXc5Sng5MXpVUUtPNVVQRnQ1bk4zNzE3NktJdjNGVVp2?=
 =?utf-8?B?dVJWVjBxYXRsOFhYaXhBeTEyNzVBOWhvYlUzamcwTGw0OFU2enU2VkdQM0pK?=
 =?utf-8?B?WVMvYlZSdEtUQjBqdWJrSmwyZmpISUJGRG5BZXl3SmFidWo3L1FvUFJBZFZ4?=
 =?utf-8?B?OWNFUnI2RSttS2ZGdHR4M3hrTDlzZzlKMVVtbVdYd3hTMTVRdUtaMFlqTTkv?=
 =?utf-8?B?bk1rMzNCSTVrNXlKNURhNGEzYWp4M2szWnhERFNlZnJoT1BXcHptUE0zbVFL?=
 =?utf-8?B?Mi9FOG5ndXE0azlqU05aTzJUQ2JrUFpBVGdTR3VhcDk0R1ZqbWJ5M0xxVDZ6?=
 =?utf-8?B?VHZvVEZLZzgvTEpsL3I1Z3pCdDlJYk1PTjBXMzFnOUZ4MnVYU2hoWGxKUytp?=
 =?utf-8?B?QkhTbGRLSmZaeXQyK0phTUlwOS9qZ3JvWjVBam8zbUVPQ0c1ZHVoMnhNQkZq?=
 =?utf-8?B?Wmg4YzdsbGtSaW5BdHBsMDZNbjVMY1lEYWp0VDI4T0s3RnQwb1NTVUYzeC82?=
 =?utf-8?B?bHNFVG95QVVTR0xYcVVEeW04K3pESVJjTmtyelBCQ2RiR2s4eUxaYzJpN0xh?=
 =?utf-8?B?OEZXTVRaSWJaZ0d5LzFFYnhoenAvWDNua0hJUTB3ZFNlWXY5eUN2UXRYdWNx?=
 =?utf-8?B?VWhvWTlnYndqdE5pTmJqV0hpdWp0cWc4VEdYOU40ajUvUEt6Q1RlcmxLNTBr?=
 =?utf-8?B?TTJBSEFBcTFST3VGMmdnNjdBZTJUQnJ5L1VhaHNSYTFJZ2Z0c3FWQ01zL3R5?=
 =?utf-8?B?YmxFMmVxeDgyTytaRW5rcEt4NnE3ajVuaG1Sa214L2oxQ1BkRjN6Q3BjajVO?=
 =?utf-8?B?SVhOSThDcFl2eERyWGwyait2RnVJTSs2UnUyK0VxWW1pUlI0ZUdaTjNUbHpT?=
 =?utf-8?B?cHk4VFhLUjB0NkluV0l4Sk5MNkpWdGd2K1Y1MWZxZ2h2M3B5YncxUzhhYzlj?=
 =?utf-8?B?NW01V3psUFAyenhEamo4U1g4YjVCVWxVYURTZnJOTmFLaVRob2toelk3MW1l?=
 =?utf-8?B?WTV0QXduZGVXYXJDQUhTZ3BackZVcnNROXhLZ2hCUEc2MXFpSmNaUTBxazRG?=
 =?utf-8?B?N1h2RmhKS3VOdE1leEFTZ0I1Y2pkeUhjTnJQMlNXQndvOWF4L3NiTlVhT05p?=
 =?utf-8?B?SHVTdmxHSDFLczNpMVRYSU9RL1IzNXJDRkt2N25TMDZDbi95L1hnVzR1Mkhw?=
 =?utf-8?B?d1ZoTmVubjdnU05rWi9oRk9vWThUYzROQWhtMDFaQVhNRTdKNWdFQzZHOWxu?=
 =?utf-8?B?TnhaQkkvQTJGS1pjNGNIeEZtOWNGU053Y29BSG9VY09WbEk2L3lTWjAxdHBo?=
 =?utf-8?Q?XyuK9eMkkzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGptYXJHcmhWQTRGeUY5bDN5aUdxdzIxaVNhZWJidFhXMW80OHBYR2RCS3Bp?=
 =?utf-8?B?cVZld0k1UkRZMDlqdVgyczF4OEdRZGpHZXZjLzZIYmh3bGE1NVEzWUkwY0Rv?=
 =?utf-8?B?VFNuc3IrM1JnUm53c1JPUHlHcU8ybGtRN2Nhc0xZZ3dSMGtPWnZaYitwTnVN?=
 =?utf-8?B?cjZUWDdtSVd0N1Q1M0ZjektZeStud0lJQjBwM09CSXh2dGNxNlBqNWJCWTJL?=
 =?utf-8?B?R0YzY2lSTlBRMTJFMlpTMWx5Mzg0cDlhSUsraDIrN1gwdmpwZk1nWUMrSTNz?=
 =?utf-8?B?T21vdElMYTJmdkJCaEg3eVViK1VWMDBzenhYcENEcUc1VWVuQ3NVR3hSUnhU?=
 =?utf-8?B?anNDUkFDeWZiRmMzTDFSZUEraGg5dldKelhoYzZyelRHM0hDQ1BKcS9RRjh6?=
 =?utf-8?B?SmtyZyt5a0NvYnBydldaMW0zZmhqeW9kL1NiUzBFOEtHWWN0cWlKdzNXWnJB?=
 =?utf-8?B?c3FEdkVQOEZheXZyWnlCS0pDazB4clQvYUVJczhhaU1lRU4xa0RiN1FZT053?=
 =?utf-8?B?VTUxaWgvcVdPM3M0cTZPSUYxMHZOWi9lWGhYcmNRSWxWdmhvQ2ViWXRhOHBu?=
 =?utf-8?B?dTYrMmYyb3BmZWRUTnFyL1BBN3VBU0pxMTBhTHc4dkd3L3plWGpwQnl1cy9M?=
 =?utf-8?B?a3M4a3lJMEtnWFgrQXl2Z0V3bTJ6cHlDZzM1d2YwandIQ1ZwRUlqaENtK2V5?=
 =?utf-8?B?K215VmdpbnZrb3IxUDg3ZDVZWTRhRSthZWpXVlBnQ0doMEp1KzBlTXoreFJ5?=
 =?utf-8?B?cFhBSzBXZ3pxcWo0ZWFhckFoemRFWDByZk1HdTZVdkZJU2VQZmpic2JWcEpG?=
 =?utf-8?B?eU05dzZVZUlqM3Rnc1A1eXpXenIxZmN1N2Zka0JoMnhIdmpJNG5NNllZT0Jn?=
 =?utf-8?B?Y3JGV3loWFdtLzFULzRKWmZXdm1nUnErWmN6d09FSmlZbkJmdUJRNUlTaUQ2?=
 =?utf-8?B?RzhxNmFHM3JHNFNiSjdKTVU4V1RRSWt4Uk45TTA4QVRYYVRtc3RlZEY0L2ZK?=
 =?utf-8?B?eE1vWFMrU2lYRmdlcTNDMmwxRjFONEl1bUFBUTQ3UEsxdHhoSWFHQW5hVlJD?=
 =?utf-8?B?M2E4ZytzSlhieTA5T1BQaDMrZ0JxNWRyemYzYlluUGMrWWpUdEtRL3kwL1Bu?=
 =?utf-8?B?V2xSTFpjVlZ1QzR2c0pIRlV3eE5mMHJ3NHMrNE1KTnZuRFdhS0lYMjVmSVpy?=
 =?utf-8?B?aVV1N2krci9XdmpGbnUyWUt1WjN6YmZsVWc5MG42Z2F2WmhtYnRtOHhCUmFx?=
 =?utf-8?B?OVF2SkRVc3d1UzBCY3dtV3BzdUJoYUxCMk52V1UxN2xtUTZiSHZkaGlSaWxw?=
 =?utf-8?B?NjNSZVpQVTRGYUl1WUgwWmNKL1BUMnBIak1BWW0yK05RcEQrejRuTmZSOWhL?=
 =?utf-8?B?V1VubHpnRTBwV3VGSGkzc0Z3NUhBclRNT1ZtdUcyeldnTjkxQ25yMG5LVmZG?=
 =?utf-8?B?TFQ0SW9ET2RMSkZTT1pDNGZRc3pSaGgvMnhGblV1UmhEQ3p0V3BNZVRxRm14?=
 =?utf-8?B?a1UxTXRUNVVRZk0yWkcySGtBNTJVS1VGVU50blI3eDBkQzVDRWxoZnJMWVBi?=
 =?utf-8?B?ZEViVUJwSU1LVnZVUUlqbUFiSERueDhYLzRiVFdQUWpRa2JJSWFJdVJQNjFQ?=
 =?utf-8?B?eFNnSVBma1lEQTBQd29iUGxpa3dRbFB0dEpmUm1UYnJZMlNaaEQ1UnJDbzVx?=
 =?utf-8?B?NVdZWk9BMlFoU1oyZTdaQ2hSakk5Y2h0L2wzZldtRUhoeGJ0eXhtMGNzWlZt?=
 =?utf-8?B?b01KTU1BYzVJMktqYXk5anFxZWljbWFqUUZNNGVneUNCaGVJY1U0T3dxWk1s?=
 =?utf-8?B?N3o1bEdyTWd3QnZNd3Vod01rTlFteVNHVVN1b1RmYXg0bFIvOTBQemtOQ2ZI?=
 =?utf-8?B?ZHNTVjhJUjN5bFRFQlZxeTJPN3o1aG9vazkrcjFVUEQyNVVnWU1Vc0ZKWUF4?=
 =?utf-8?B?SU1sbk01NXBmSVhGNUJrWnBGR0NUaGhESTRablU5eWdFbUR4YXdoMlVLYTdH?=
 =?utf-8?B?Qm9MeDl5TTNLWkwxOGJEbkV3U3FYSG5uWlZZY1o0a2c1NWlzL1dCV1pWOFNP?=
 =?utf-8?B?TWRLQmRTdEYrcGpIMG1PY1FlTHBCbXhTS2xBcTJNZmEyRjBJb1NiRTNLdUg0?=
 =?utf-8?B?cmRoWnVWTlNnZmlGSnhNc1JmRTRmVEpWVW41cHQ3d0F1aEM0dmVkakRrR2NJ?=
 =?utf-8?Q?fxiK241dp3Ar+H1zyg6avbI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5efc2e-2846-42f5-4e38-08ddd548245d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 00:19:58.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ka0MgACpNy161xdGFQCWKlqJrnxuDjNiAcZqKzm1Hln7un11djMHEebPGoHljiIsg4Vmj+w6To5svIYaIMR/NxQhBr5ag+pWyvPfBZOm4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8956



On 8/6/25 12:57 AM, Ryan Roberts wrote:
> On 05/08/2025 18:59, Yang Shi wrote:
>>
>> On 8/5/25 1:13 AM, Ryan Roberts wrote:
>>> From: Yang Shi <yang@os.amperecomputing.com>
>>>
>>> When rodata=full is specified, kernel linear mapping has to be mapped at
>>> PTE level since large page table can't be split due to break-before-make
>>> rule on ARM64.
>>>
>>> This resulted in a couple of problems:
>>>     - performance degradation
>>>     - more TLB pressure
>>>     - memory waste for kernel page table
>>>
>>> With FEAT_BBM level 2 support, splitting large block page table to
>>> smaller ones doesn't need to make the page table entry invalid anymore.
>>> This allows kernel split large block mapping on the fly.
>>>
>>> Add kernel page table split support and use large block mapping by
>>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>>> changing permissions for kernel linear mapping, the page table will be
>>> split to smaller size.
>>>
>>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>>> mapping PTE-mapped when rodata=full.
>>>
>>> With this we saw significant performance boost with some benchmarks and
>>> much less memory consumption on my AmpereOne machine (192 cores, 1P)
>>> with 256GB memory.
>>>
>>> * Memory use after boot
>>> Before:
>>> MemTotal:       258988984 kB
>>> MemFree:        254821700 kB
>>>
>>> After:
>>> MemTotal:       259505132 kB
>>> MemFree:        255410264 kB
>>>
>>> Around 500MB more memory are free to use.  The larger the machine, the
>>> more memory saved.
>>>
>>> * Memcached
>>> We saw performance degradation when running Memcached benchmark with
>>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>>> latency is reduced by around 9.6%.
>>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>>> MPKI is reduced by 28.5%.
>>>
>>> The benchmark data is now on par with rodata=on too.
>>>
>>> * Disk encryption (dm-crypt) benchmark
>>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with
>>> disk encryption (by dm-crypt).
>>> fio --directory=/data --random_generator=lfsr --norandommap            \
>>>       --randrepeat 1 --status-interval=999 --rw=write --bs=4k --loops=1  \
>>>       --ioengine=sync --iodepth=1 --numjobs=1 --fsync_on_close=1         \
>>>       --group_reporting --thread --name=iops-test-job --eta-newline=1    \
>>>       --size 100G
>>>
>>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>>> number of good case is around 90% more than the best number of bad
>>> case). The bandwidth is increased and the avg clat is reduced
>>> proportionally.
>>>
>>> * Sequential file read
>>> Read 100G file sequentially on XFS (xfs_io read with page cache
>>> populated). The bandwidth is increased by 150%.
>>>
>>> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>    arch/arm64/include/asm/cpufeature.h |   2 +
>>>    arch/arm64/include/asm/mmu.h        |   1 +
>>>    arch/arm64/include/asm/pgtable.h    |   5 +
>>>    arch/arm64/kernel/cpufeature.c      |   7 +-
>>>    arch/arm64/mm/mmu.c                 | 237 +++++++++++++++++++++++++++-
>>>    arch/arm64/mm/pageattr.c            |   6 +
>>>    6 files changed, 252 insertions(+), 6 deletions(-)
>>>
>> [...]
>>
>>> +
>>> +static DEFINE_MUTEX(pgtable_split_lock);
>>> +
>>> +int split_kernel_leaf_mapping(unsigned long addr)
>>> +{
>>> +    pgd_t *pgdp, pgd;
>>> +    p4d_t *p4dp, p4d;
>>> +    pud_t *pudp, pud;
>>> +    pmd_t *pmdp, pmd;
>>> +    pte_t *ptep, pte;
>>> +    int ret = 0;
>>> +
>>> +    /*
>>> +     * !BBML2_NOABORT systems should not be trying to change permissions on
>>> +     * anything that is not pte-mapped in the first place. Just return early
>>> +     * and let the permission change code raise a warning if not already
>>> +     * pte-mapped.
>>> +     */
>>> +    if (!system_supports_bbml2_noabort())
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * Ensure addr is at least page-aligned since this is the finest
>>> +     * granularity we can split to.
>>> +     */
>>> +    if (addr != PAGE_ALIGN(addr))
>>> +        return -EINVAL;
>>> +
>>> +    mutex_lock(&pgtable_split_lock);
>>> +    arch_enter_lazy_mmu_mode();
>>> +
>>> +    /*
>>> +     * PGD: If addr is PGD aligned then addr already describes a leaf
>>> +     * boundary. If not present then there is nothing to split.
>>> +     */
>>> +    if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
>>> +        goto out;
>>> +    pgdp = pgd_offset_k(addr);
>>> +    pgd = pgdp_get(pgdp);
>>> +    if (!pgd_present(pgd))
>>> +        goto out;
>>> +
>>> +    /*
>>> +     * P4D: If addr is P4D aligned then addr already describes a leaf
>>> +     * boundary. If not present then there is nothing to split.
>>> +     */
>>> +    if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
>>> +        goto out;
>>> +    p4dp = p4d_offset(pgdp, addr);
>>> +    p4d = p4dp_get(p4dp);
>>> +    if (!p4d_present(p4d))
>>> +        goto out;
>>> +
>>> +    /*
>>> +     * PUD: If addr is PUD aligned then addr already describes a leaf
>>> +     * boundary. If not present then there is nothing to split. Otherwise,
>>> +     * if we have a pud leaf, split to contpmd.
>>> +     */
>>> +    if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
>>> +        goto out;
>>> +    pudp = pud_offset(p4dp, addr);
>>> +    pud = pudp_get(pudp);
>>> +    if (!pud_present(pud))
>>> +        goto out;
>>> +    if (pud_leaf(pud)) {
>>> +        ret = split_pud(pudp, pud);
>>> +        if (ret)
>>> +            goto out;
>>> +    }
>>> +
>>> +    /*
>>> +     * CONTPMD: If addr is CONTPMD aligned then addr already describes a
>>> +     * leaf boundary. If not present then there is nothing to split.
>>> +     * Otherwise, if we have a contpmd leaf, split to pmd.
>>> +     */
>>> +    if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
>>> +        goto out;
>>> +    pmdp = pmd_offset(pudp, addr);
>>> +    pmd = pmdp_get(pmdp);
>>> +    if (!pmd_present(pmd))
>>> +        goto out;
>>> +    if (pmd_leaf(pmd)) {
>>> +        if (pmd_cont(pmd))
>>> +            split_contpmd(pmdp);
>>> +        /*
>>> +         * PMD: If addr is PMD aligned then addr already describes a
>>> +         * leaf boundary. Otherwise, split to contpte.
>>> +         */
>>> +        if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>>> +            goto out;
>>> +        ret = split_pmd(pmdp, pmd);
>>> +        if (ret)
>>> +            goto out;
>>> +    }
>>> +
>>> +    /*
>>> +     * CONTPTE: If addr is CONTPTE aligned then addr already describes a
>>> +     * leaf boundary. If not present then there is nothing to split.
>>> +     * Otherwise, if we have a contpte leaf, split to pte.
>>> +     */
>>> +    if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
>>> +        goto out;
>>> +    ptep = pte_offset_kernel(pmdp, addr);
>>> +    pte = __ptep_get(ptep);
>>> +    if (!pte_present(pte))
>>> +        goto out;
>>> +    if (pte_cont(pte))
>>> +        split_contpte(ptep);
>>> +
>>> +out:
>>> +    arch_leave_lazy_mmu_mode();
>>> +    mutex_unlock(&pgtable_split_lock);
>>> +    return ret;
>>>    }
>>>      /*
>>> @@ -640,6 +857,16 @@ static inline void arm64_kfence_map_pool(phys_addr_t
>>> kfence_pool, pgd_t *pgdp) {
>>>      #endif /* CONFIG_KFENCE */
>>>    +static inline bool force_pte_mapping(void)
>>> +{
>>> +    bool bbml2 = system_capabilities_finalized() ?
>>> +        system_supports_bbml2_noabort() : bbml2_noabort_available();
>>> +
>>> +    return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
>>> +               is_realm_world())) ||
>>> +        debug_pagealloc_enabled();
>>> +}
>>> +
>>>    static void __init map_mem(pgd_t *pgdp)
>>>    {
>>>        static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>>> @@ -665,7 +892,7 @@ static void __init map_mem(pgd_t *pgdp)
>>>          early_kfence_pool = arm64_kfence_alloc_pool();
>>>    -    if (can_set_direct_map())
>>> +    if (force_pte_mapping())
>>>            flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>          /*
>>> @@ -1367,7 +1594,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>          VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>>    -    if (can_set_direct_map())
>>> +    if (force_pte_mapping())
>>>            flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>          __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index c6a85000fa0e..6a8eefc16dbc 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -140,6 +140,12 @@ static int update_range_prot(unsigned long start,
>>> unsigned long size,
>>>        data.set_mask = set_mask;
>>>        data.clear_mask = clear_mask;
>>>    +    ret = split_kernel_leaf_mapping(start);
>>> +    if (!ret)
>>> +        ret = split_kernel_leaf_mapping(start + size);
>>> +    if (WARN_ON_ONCE(ret))
>>> +        return ret;
>> This means we take the mutex lock twice and do lazy mmu twice too. So how's about:
>>
>> mutex_lock()
>> enter lazy mmu
>> split_mapping(start)
>> split_mapping(end)
>> leave lazy mmu
>> mutex_unlock()
> Good point. In fact it would be even better to share the same lazy mmu
> invocation with the permission change code below. How about something like this:
>
> ---8<---
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 5b5a84b34024..90ab0ab5b06a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -625,8 +625,6 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>   	return 0;
>   }
>
> -static DEFINE_MUTEX(pgtable_split_lock);
> -
>   int split_kernel_leaf_mapping(unsigned long addr)
>   {
>   	pgd_t *pgdp, pgd;
> @@ -636,14 +634,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   	pte_t *ptep, pte;
>   	int ret = 0;
>
> -	/*
> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> -	 * anything that is not pte-mapped in the first place. Just return early
> -	 * and let the permission change code raise a warning if not already
> -	 * pte-mapped.
> -	 */
> -	if (!system_supports_bbml2_noabort())
> -		return 0;
> +	VM_WARN_ON(!system_supports_bbml2_noabort());
>
>   	/*
>   	 * Ensure addr is at least page-aligned since this is the finest
> @@ -652,9 +643,6 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   	if (addr != PAGE_ALIGN(addr))
>   		return -EINVAL;
>
> -	mutex_lock(&pgtable_split_lock);
> -	arch_enter_lazy_mmu_mode();
> -
>   	/*
>   	 * PGD: If addr is PGD aligned then addr already describes a leaf
>   	 * boundary. If not present then there is nothing to split.
> @@ -734,8 +722,6 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   		split_contpte(ptep);
>
>   out:
> -	arch_leave_lazy_mmu_mode();
> -	mutex_unlock(&pgtable_split_lock);
>   	return ret;
>   }
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 6a8eefc16dbc..73f80db2e5ba 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -131,6 +131,8 @@ bool can_set_direct_map(void)
>   		arm64_kfence_can_set_direct_map() || is_realm_world();
>   }
>
> +static DEFINE_MUTEX(pgtable_split_lock);
> +
>   static int update_range_prot(unsigned long start, unsigned long size,
>   			     pgprot_t set_mask, pgprot_t clear_mask)
>   {
> @@ -140,14 +142,23 @@ static int update_range_prot(unsigned long start, unsigned
> long size,
>   	data.set_mask = set_mask;
>   	data.clear_mask = clear_mask;
>
> -	ret = split_kernel_leaf_mapping(start);
> -	if (!ret)
> -		ret = split_kernel_leaf_mapping(start + size);
> -	if (WARN_ON_ONCE(ret))
> -		return ret;
> -
>   	arch_enter_lazy_mmu_mode();
>
> +	/*
> +	 * split_kernel_leaf_mapping() is only allowed for BBML2_NOABORT
> +	 * systems. !BBML2_NOABORT systems should not be trying to change
> +	 * permissions on anything that is not pte-mapped in the first place.
> +	 */
> +	if (system_supports_bbml2_noabort()) {
> +		mutex_lock(&pgtable_split_lock);
> +		ret = split_kernel_leaf_mapping(start);
> +		if (!ret)
> +			ret = split_kernel_leaf_mapping(start + size);
> +		mutex_unlock(&pgtable_split_lock);
> +		if (ret)
> +			goto out;
> +	}
> +
>   	/*
>   	 * The caller must ensure that the range we are operating on does not
>   	 * partially overlap a block mapping, or a cont mapping. Any such case
> @@ -155,8 +166,8 @@ static int update_range_prot(unsigned long start, unsigned
> long size,
>   	 */
>   	ret = walk_kernel_page_table_range_lockless(start, start + size,
>   						    &pageattr_ops, &data);
> +out:
>   	arch_leave_lazy_mmu_mode();
> -
>   	return ret;
>   }
> ---8<---
>
> Of course this means we take the mutex while inside the lazy mmu section.
> Technically sleeping is not allowed while in lazy mmu mode, but the arm64
> implementation can handle it. If this is a step too far, I guess we can keep 2
> separate lazy mmu sections; one for split as you suggest, and another for
> permission change.

IMHO, we'd better keep them separate because the split primitive may be 
used by others, and I don't think it is a good idea to have the callers 
handle lazy mmu.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>> Thanks,
>> Yang
>>
>>> +
>>>        arch_enter_lazy_mmu_mode();
>>>          /*


