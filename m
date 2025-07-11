Return-Path: <linux-kernel+bounces-727848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334FB0209A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BA1CA22AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3C2ED844;
	Fri, 11 Jul 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GKpmoAJW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14192ECE9F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248421; cv=fail; b=U3nNEHSszzkwEFtp94PTVWlvk8HEtuTAp0P90rHNdval8XLwhPSTGhkUErLZPtFI+kmT2vSez3uGbQGWpC/FVP3vZ3WMSt8G8GBYA3K22Y2JdI9wIy62xFOmy5jmF3qpyR996o9WFYD1efcQhrh5MW7KRYfH41vOiQswJeQXtmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248421; c=relaxed/simple;
	bh=k81+cCFwhosgekzmkJIzLqmZ9EmpXX6OvTSZEFhXYbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kb3UBoBA/lFGJd++TQUc4h9+plkxTy6hAtt9fWFQ/TO7/e5+7yTdT5vZWw3BNVTdLdHt1RbFCiZVvU6cPXrdFNlNxt+q9cjybMtghwgZXDLojrW/fRXZLp0wuuNcELhp1+/Zz7qvtBPWmfV8zknYJYeocbgDQMInpflNHFzRoBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GKpmoAJW; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOCxZclaHd/oaZ5X22QIyRX+7Qrc3E0mY6+s4jN4lIgbWdLQdivsogyUbRgJ9F5E70A5TIozpktU6VuegA3NMWajPWJc+x4bdNvh+ULUF4y3yTuv1piRjpydDRk2HnRCj4TkmBkWCi8ZeqKxz5crPqW/OyUj8vNdJ+ygUV0bdVHHiYPqFO0Y5UIXlCLmVfpc0yPsNU7kq2ebCx2PO1RRe2KfE3BF25IUy/hp/b68GXnWl6FX/UMDrWQCR3y72bY5r2S2sTGr4a0zqTKTefv72SjDFtsMklMGdCmjEuHWXxFqjEQoQVer4/nHzpjlj8MnMhmeGsnuXJx7Ff50B5l4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOexHNEtxGagEeKR6UEWFg+kvoE6poGm19XiWSAXT6M=;
 b=L4+gdWxTcqNmTBtNrF2stsG0X8SQytG6eO9jOATS16/5yhRTbeGD+lKK3spz0VfRn+GgtwE8h9BH7CPSz2KwLtCBAuyjaHBq+koOfcEKkfeKkZaC9KxmRcvkYr7RbGTRsD1BQwUD2guZdV1Qir6x4LtwnlQmLGUO3Y4/1uijYMoJEgh0U+F3eaplzuOAtlAiIpRCLVzsNbjmgjII60FzXbuuTgWLHI/36j1opRoh4rzLBKDbJFeQg6eCcCH2sC9uLSSc6r+sTOQNSPwnZhrZJqBaqC1+4k2n+JAWi5os0hzktQuQxhNP6fUfFhc3TWRjxmyfvjZmmxEgHDZ6HwEc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOexHNEtxGagEeKR6UEWFg+kvoE6poGm19XiWSAXT6M=;
 b=GKpmoAJW28vSjlRUdZ68FLCg50Rb/bvZsX8eTDg6+2P/gNTXIzihYoNCn8U7axWDOQVZiKRAoYbsYOLV/yW4rbP+rCf8AibKh4nzxmrxzr13ErSyNosryghHLU0uK6H04JBVialxTpOw1PxDIuBSfnVZrb6QES77cAIzlRas3LY1hJqc4ZZrrQ9CcDPN2WxZfz0zqJNUUbTfqthxwGvLNryFN50e0iYGlB/nAol5YLB7BgkjFOzwyCSJNLU2csAjB66AsoKZHe9CW+RHkxrbgaUIe0bbZiGuFpk7sxt7bhw3yKgDy1cvBl+ixo2Fwfl4K8ObiqNu9tkBsb0RxH8vkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Fri, 11 Jul 2025 15:40:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 15:40:16 +0000
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
Date: Fri, 11 Jul 2025 11:40:13 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B9C05B4D-2777-45DC-A229-B4E119B0E9A3@nvidia.com>
In-Reply-To: <3223bd3b-38cc-45d1-8080-d62117df0e85@redhat.com>
References: <20250711030259.3574392-1-ziy@nvidia.com>
 <c7e82a13-aa93-4eb3-8679-29cd32692bd0@redhat.com>
 <2AE055C4-BFFE-4B61-A96A-6DE227422C7B@nvidia.com>
 <3223bd3b-38cc-45d1-8080-d62117df0e85@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 06251d7d-6faf-45a8-53d0-08ddc0913bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0ZNT1JSN01uRWpRbVNXd1RpelN0YUlid3BLTHVnRm9GZWtmNTRqT2lvY2Rz?=
 =?utf-8?B?Qm5pQk93LzZpeFBaRm91aStQTWhDNjdyZDBBNUFWRnh2Tk0xMmJ4NFJLcUwx?=
 =?utf-8?B?U3JyL29aYmdyaWluQTlRSDZRVWxUVDlBUmNSR3p1NFNTSTVqM1dQOHhrdG5q?=
 =?utf-8?B?Q1BMSVJpQWtVL2x6WFZGSVY5MUg5ajNIR2o2a2FFSWhNWDY0TVFzbDRkRTRY?=
 =?utf-8?B?cmlFRU4wR2VGYm0rQmVGZGRPemNRL015MDJhL3Y2SnJXQmNpSklnb2NaNlRl?=
 =?utf-8?B?cFlWNWVnN2hhQmNWSVNWZjRrcWt0SUIyc3gwVFZyMGphekMvd2cwV0pHMGVv?=
 =?utf-8?B?L01Fd1ErNUladlNTT0ZKdis3dEROdGJYOVdENFNLalQ3aDlZSjBLOXlIQlNC?=
 =?utf-8?B?WjgxWHFBV1Q1eHI1NFNPSFBSM0hwcnJHRlovVTE3ZXEvNVdtNGIvbGU2VW5M?=
 =?utf-8?B?UE4zVWVXbTU1RVdOMEFiMnNQTVRvZmFlQ0FLeUpOSU1MVEt5TkllbjJkQTk2?=
 =?utf-8?B?UVJ6cS93bHlWZnlGU1poSjVkRWE2bGx5MDkvMENqbVlVRG5KcDVwbC81dCt4?=
 =?utf-8?B?QTg1NmtjTmI0NFROb1FWV0JSZWZObnZwbWI3alJzNDF3Vmc4NE1JemF6SGJw?=
 =?utf-8?B?RG9ScDB3MzRiUGlkQUFEcC9FRDZBKy8xM2dvT1JTTkZyKzV5OG9WVHpmUG1I?=
 =?utf-8?B?NHVmTVpiZXJBNVE4WWl3K25TR25CWDZwNkhFQkRSNWQwUzdXVXV5aEI0Mjky?=
 =?utf-8?B?Mkk2LzRpTFBzbkNwMUpWRTJKSzhFUDVzMzlIY2d3SXNkMlUvd0ZlaGNGQU1m?=
 =?utf-8?B?ZnJjUzEvNzlhbTVoeDhrQXV2RFR1ZjRuTE1CYWVabU1rYWJLUDY2WWcxOWd4?=
 =?utf-8?B?MjJKcXBKU0RDdGEwUFlZT0NUVnVubFJlcVFXT1BLbEt0cXhGRmZOSDlna0s2?=
 =?utf-8?B?eC84R3ErVkkxakt5YWRleXZINHV3WXhBY05VMGJzaGtBV2VaeWZNT0IvSDNY?=
 =?utf-8?B?TldQZDh4aXNOWWR1QkoyY3Vwdko5ZUtKMTVycjZKaTllbEpucnJQa2FOWnJE?=
 =?utf-8?B?VmZQZnA5WjFwUjJHVWFyY05MUUMvSFh6cGRRRlVnQTlEaks4YnNvZVh0UTJU?=
 =?utf-8?B?ckswWlV0djhHTUduaGtycDVBQXowMm5QN1lBb0VGYXppRVA1clhKcStnL29o?=
 =?utf-8?B?KzdYK2xydDhFYW9uWUkvWFZPOXJ4Tk9UNmxoNHAvYTNrVkR6WnJkUlh2d0FM?=
 =?utf-8?B?bU1XWkJJalRKbFI2S3V6K3JuTExDVS9TK1NiODJIQS9JcHVxN1NlZm9EU1BM?=
 =?utf-8?B?VlBSOFFtTE1Na0FWRnFKaVc4ckdmVHZvZ3RCdkV6SzRiNFVIdi9UUUpGMUx6?=
 =?utf-8?B?bDY4SVBUWEtmaVl4WlQ5aDR2aWpGbnRPLzJ0UGtQM2h6Rm5wT0ljWjMyT2Jh?=
 =?utf-8?B?bWZlaEdxL2UzL2htWU5rTmpYLzNZYnJOZVFzbkxneWZPTE9SdnROZHlNUlFU?=
 =?utf-8?B?c3AxbDBDT3B4R01PWWo5YWJDS251YU5RZjgvcVBhVzVqb2JWNGkzMnNpUGRF?=
 =?utf-8?B?dTIwd1hHV1lZT0xmZ1dudzBvWXFjaCt3VlQvV1RsNUgyS1p2WkE1K3JMM3cv?=
 =?utf-8?B?MHA1YWcwU1djNlV1YmpYQWFVeDVLMTZLNDRiSXl6ZFJOc09wTWpkSTJQbXhK?=
 =?utf-8?B?RU9XNU81eUJ6RThYYWZJb0dBRkI2UHAyTUhqS3pzN3phUkRJSnNVZEZqWnc1?=
 =?utf-8?B?L1Bjb0xRbVU2ZVlPUWRvQnRmWVROTGRLUzVSbW50ZlRnK055TWFhS254cUJ5?=
 =?utf-8?B?Y2tpcmNXSWZrbWtVUkhRWVRJajNkS0pPMWg4bWhRaGswK25KZUFWMWJxVUdo?=
 =?utf-8?B?RjRGSnkyWnRmMzZoMUJNTVBIRUh0YkhJenpNaEhIQlV0amZCRXZZUk5yWkJR?=
 =?utf-8?Q?sm0Sx/UGNRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5YVjBtdzl4RXArYlJreTNPcEoyT2J4N0xyTUZta05lekNhd1Vqak1SOEc1?=
 =?utf-8?B?U2M5MWFIdUR3bzR0UDRtQlpHNUFBWVkyWGdmakVXbDJEOVZMaitPQnI5b1c5?=
 =?utf-8?B?eHRWNFBlY3g1MTVLU1BaQlRqTzFEbTBKWHhtVGFTeWtvcFdtVnhUR1VIY1ND?=
 =?utf-8?B?SytpMkdKM250RDhldjcxWDVnZWt3YTRmQkpPVmthUTByMTJCT0JOZ29ZRndt?=
 =?utf-8?B?RExsditUQlZuQzB1UHA2WjE1Ri9yRldBSFlHK0ZSTjdSMkk5dy9BSXlWcmpQ?=
 =?utf-8?B?R3pCU0h3Zkk0YVZ5L3pkQVkzVlBnNlJDaTJURGRhR3gvbkVqaFNXV2tGWTNR?=
 =?utf-8?B?RzBzVXB4WjU0eXF5czFrb2hTZzB1endjQW9BN1BPUjQvZFFSL3lYSHhvTnJF?=
 =?utf-8?B?LytIaVVjZXZqdVdheTkxMzBscVNvY0oveEQxV0pjOSt0a2hRejJKNEFJREZG?=
 =?utf-8?B?RlVjRUN0VFM0RXBrcTh3ZTNKdmJiK0doYnU2RGMzNm9XNDhxY01WMTg3Y1FC?=
 =?utf-8?B?dzZ2NGl1QWZnRGZkVmtoU2xMc2lXMDhRUTlPOEFNMnFyQ3dsUjExYTVnTmM4?=
 =?utf-8?B?dmdyVng2Ti9tUmpoc0RaazBLNC9XbXE2WTZBUVpyRGVZeGloVHRRV2w2TjZD?=
 =?utf-8?B?Z0hqMFBwbXJ4OEJvcUtTaXZkaVZLL1V4cnFjcTZLYVVLTnZZMVpWamFxN0tE?=
 =?utf-8?B?WXlYamlCREdwWlRMMXArQUY3ekhlSmpHdnY1VjhFZEhkczVDMTJ6TUxjSmw2?=
 =?utf-8?B?NXBSY0tuNUxFR24yVzNWZWMyTVdIdzJvS1p1N1lQcHRiUFdJWUZGWjk4bFRD?=
 =?utf-8?B?blVqY3RBT3dGd0draG5JT0tlblNqdDdPcUE2bUtqcjh3Q3U1Z2xQSXRwYjA4?=
 =?utf-8?B?VUdhSVBqck1sQll3VUR1YTZ1b3NyYnU1Vk55UmZyLzc2TkkrclZpSXQvOENJ?=
 =?utf-8?B?T1BEY2VuYTJmOHhYU25tQWFOK3RSSUk3bW5rblNKbWpjWHhnNGZZTWJLd3B4?=
 =?utf-8?B?dTZFc1prT05vZEVIM3h3aFBCOXI5bDlSS1lMcUhLaDV6eDVPQzlEREZZU0hx?=
 =?utf-8?B?WnN1dlc4eVE1MTFtUGczakxuL29VeHg1b1pObGwrdVArSE92WGhlZHgzSkl6?=
 =?utf-8?B?Zm93cGtoN1ZmV1BMZXE5MXRLeWUvN01EZlMwZysyVkNkaHk3TE5XNWxzdk94?=
 =?utf-8?B?TFY5c3pyZzM5b2FkSW9aNUhZVDUvRGJGZzlZcllsZFV5R0lpVTllbjdXazNz?=
 =?utf-8?B?bXd5V0lGNDRrd0dQSHl2OWpXU3ZiTjYwRzJnTTJyL2QzWUF4b2pJTk15NENC?=
 =?utf-8?B?RWQrSjkrN25UQnZwYVJFNG1vNHNkSkNLL2VxS28vY2hIZzI0WjN5WXBlQVYy?=
 =?utf-8?B?NnNnR3R0a1JIZ0tXUllLVER5QzdYMFFvL1d5Zmt2VXhMcE5oR1prWXRYYysx?=
 =?utf-8?B?QlBwMXN1T3dhUERpZlJ1TDZmWmlFVWdIQmNoMmxjTXo2eUsxN0oxVlFBSHNE?=
 =?utf-8?B?aENJbENRTGZKRE9WbWJEVkVjb0VJcSttUGdJRUtPR0RrWi8zU2VKblNMdnNy?=
 =?utf-8?B?V3RVUWtydnNpUjVlZUpORmtFRFFWWjNncDBleGVoNzhpemRjUjVRaG9DMU5T?=
 =?utf-8?B?Vzh0bUx6eTVHOWsrM05raDF1NzRBdUhSTzEzcE5JL3RndW16MHR1SUkzQmhW?=
 =?utf-8?B?aTkrR2xlWmtHNEhLd2FKVlVJT0hlbWU0NnFZdGhFRk1BMllSaXNub2Y2dXdQ?=
 =?utf-8?B?YU1rUXBoRWxjejBIcE9MTEg0bHNJWDJUVnAvajc0T21oRDVMNzFlRHhnMG5E?=
 =?utf-8?B?WFM2OXREWS9XdlpIcVgzWnIyWmdXRWM2ZDJZTFhaTHlVK21hRVZyUERhd0xW?=
 =?utf-8?B?YmJna1VBd0hiQkdUKzNLN2VDMGp1WlVGRW85YldhL2Z3UjkzV2xUS0FtSnBn?=
 =?utf-8?B?QjcvZ2gyVVZ2SVluWXE1Nzl1RGNtQ3Y1UFRpZENneVVRNWxEUkVTV2w4TzE1?=
 =?utf-8?B?K3NwR1ZoTFUwd2pVT3VHaVpEQ3ljZkhHN29GV1hYYUpQK3VYa2pCVmdXdTNX?=
 =?utf-8?B?KzlmTXduUzNJZ2VGS2x5MEI1aDAvNUZGNEtySWppSFJVZjE2YSs3a3JJVW0z?=
 =?utf-8?Q?5u7PKZx5mBmSJ1vVvXgJZ+ZN5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06251d7d-6faf-45a8-53d0-08ddc0913bd7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:40:16.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buz1q4yknnJQSvyApDJkdyrPg3w105Ax7xE421NEjfswEUMpWVenmFli92K2AB+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

On 11 Jul 2025, at 10:40, David Hildenbrand wrote:

> On 11.07.25 16:37, Zi Yan wrote:
>> On 11 Jul 2025, at 2:41, David Hildenbrand wrote:
>>
>>> On 11.07.25 05:02, Zi Yan wrote:
>>>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not related t=
o
>>>> splitting unmapped folio operations. Move them out to the caller, so t=
hat
>>>> __split_unmapped_folio() only splits unmapped folios. This makes
>>>> __split_unmapped_folio() reusable.
>>>>
>>>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>> Based on the prior discussion[1], this patch makes
>>>> __split_unmapped_folio() reusable for splitting unmapped folios withou=
t
>>>> adding a new boolean unmapped parameter to guard mapping related code.
>>>>
>>>> Another potential benefit is that __split_unmapped_folio() could be
>>>> called on after-split folios by __folio_split() to perform new split
>>>> methods. For example, at deferred split time, unmapped subpages can
>>>> scatter arbitrarily within a large folio, neither uniform nor non-unif=
orm
>>>> split can maximize after-split folio orders for mapped subpages.
>>>> Hopefully, performing __split_unmapped_folio() multiple times can
>>>> achieve the optimal split result.
>>>>
>>>> It passed mm selftests.
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54=
845@nvidia.com/
>>>> ---
>>>>
>>>>    mm/huge_memory.c | 275 ++++++++++++++++++++++++--------------------=
---
>>>>    1 file changed, 139 insertions(+), 136 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 3eb1c34be601..d97145dfa6c8 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -3396,10 +3396,6 @@ static void __split_folio_to_order(struct folio=
 *folio, int old_order,
>>>>     *             order - 1 to new_order).
>>>>     * @split_at: in buddy allocator like split, the folio containing @=
split_at
>>>>     *            will be split until its order becomes @new_order.
>>>> - * @lock_at: the folio containing @lock_at is left locked for caller.
>>>> - * @list: the after split folios will be added to @list if it is not =
NULL,
>>>> - *        otherwise to LRU lists.
>>>> - * @end: the end of the file @folio maps to. -1 if @folio is anonymou=
s memory.
>>>>     * @xas: xa_state pointing to folio->mapping->i_pages and locked by=
 caller
>>>>     * @mapping: @folio->mapping
>>>>     * @uniform_split: if the split is uniform or not (buddy allocator =
like split)
>>>> @@ -3425,51 +3421,27 @@ static void __split_folio_to_order(struct foli=
o *folio, int old_order,
>>>>     *    @page, which is split in next for loop.
>>>>     *
>>>>     * After splitting, the caller's folio reference will be transferre=
d to the
>>>> - * folio containing @page. The other folios may be freed if they are =
not mapped.
>>>> - *
>>>> - * In terms of locking, after splitting,
>>>> - * 1. uniform split leaves @page (or the folio contains it) locked;
>>>> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.
>>>> - *
>>>> + * folio containing @page. The caller needs to unlock and/or free aft=
er-split
>>>> + * folios if necessary.
>>>>     *
>>>>     * For !uniform_split, when -ENOMEM is returned, the original folio=
 might be
>>>>     * split. The caller needs to check the input folio.
>>>>     */
>>>>    static int __split_unmapped_folio(struct folio *folio, int new_orde=
r,
>>>> -		struct page *split_at, struct page *lock_at,
>>>> -		struct list_head *list, pgoff_t end,
>>>> -		struct xa_state *xas, struct address_space *mapping,
>>>> -		bool uniform_split)
>>>> +				  struct page *split_at, struct xa_state *xas,
>>>> +				  struct address_space *mapping,
>>>> +				  bool uniform_split)
>>>
>>> Use two-tabs indent please (like we already do, I assume).
>>
>> OK. I was using clang-format. It gave me this indentation.
>>>
>>> [...]
>>>
>>>> @@ -3706,11 +3599,14 @@ static int __folio_split(struct folio *folio, =
unsigned int new_order,
>>>>    {
>>>>    	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio=
);
>>>>    	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>>> +	struct folio *next_folio =3D folio_next(folio);
>>>>    	bool is_anon =3D folio_test_anon(folio);
>>>>    	struct address_space *mapping =3D NULL;
>>>>    	struct anon_vma *anon_vma =3D NULL;
>>>>    	int order =3D folio_order(folio);
>>>> +	struct folio *new_folio, *next;
>>>>    	int extra_pins, ret;
>>>> +	int nr_shmem_dropped =3D 0;
>>>>    	pgoff_t end;
>>>>    	bool is_hzp;
>>>>   @@ -3833,13 +3729,18 @@ static int __folio_split(struct folio *folio=
, unsigned int new_order,
>>>>    		 */
>>>>    		xas_lock(&xas);
>>>>    		xas_reset(&xas);
>>>> -		if (xas_load(&xas) !=3D folio)
>>>> +		if (xas_load(&xas) !=3D folio) {
>>>> +			ret =3D -EAGAIN;
>>>>    			goto fail;
>>>> +		}
>>>>    	}
>>>>     	/* Prevent deferred_split_scan() touching ->_refcount */
>>>>    	spin_lock(&ds_queue->split_queue_lock);
>>>>    	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>>> +		struct address_space *swap_cache =3D NULL;
>>>> +		struct lruvec *lruvec;
>>>> +
>>>>    		if (folio_order(folio) > 1 &&
>>>>    		    !list_empty(&folio->_deferred_list)) {
>>>>    			ds_queue->split_queue_len--;
>>>> @@ -3873,18 +3774,120 @@ static int __folio_split(struct folio *folio,=
 unsigned int new_order,
>>>>    			}
>>>>    		}
>>>>   -		ret =3D __split_unmapped_folio(folio, new_order,
>>>> -				split_at, lock_at, list, end, &xas, mapping,
>>>> -				uniform_split);
>>>> +		if (folio_test_swapcache(folio)) {
>>>> +			if (mapping) {
>>>> +				VM_WARN_ON_ONCE_FOLIO(mapping, folio);
>>>> +				ret =3D -EINVAL;
>>>> +				goto fail;
>>>> +			}
>>>> +
>>>> +			/*
>>>> +			 * a swapcache folio can only be uniformly split to
>>>> +			 * order-0
>>>> +			 */
>>>> +			if (!uniform_split || new_order !=3D 0) {
>>>> +				ret =3D -EINVAL;
>>>> +				goto fail;
>>>> +			}
>>>> +
>>>> +			swap_cache =3D swap_address_space(folio->swap);
>>>> +			xa_lock(&swap_cache->i_pages);
>>>> +		}
>>>> +
>>>> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>>>> +		lruvec =3D folio_lruvec_lock(folio);
>>>> +
>>>> +		ret =3D __split_unmapped_folio(folio, new_order, split_at, &xas,
>>>> +					     mapping, uniform_split);
>>>> +
>>>> +		/*
>>>> +		 * Unfreeze after-split folios and put them back to the right
>>>> +		 * list. @folio should be kept frozon until page cache entries
>>>> +		 * are updated with all the other after-split folios to prevent
>>>> +		 * others seeing stale page cache entries.
>>>> +		 */
>>>> +		for (new_folio =3D folio_next(folio); new_folio !=3D next_folio;
>>>> +		     new_folio =3D next) {
>>>> +			next =3D folio_next(new_folio);
>>>> +
>>>> +			folio_ref_unfreeze(
>>>> +				new_folio,
>>>> +				1 + ((mapping || swap_cache) ?
>>>> +					     folio_nr_pages(new_folio) :
>>>> +					     0));
>>>
>>> While we are at it, is a way to make this look less than an artistic ma=
sterpiece? :)
>>>
>>> expected_refs =3D ...
>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>
>>>
>>> Can we already make use of folio_expected_ref_count() at that point? Ma=
pcount should be 0 and the folio should be properly setup (e.g., anon, swap=
cache) IIRC.
>>>
>>> So maybe
>>>
>>> expected_refs =3D folio_expected_ref_count(new_folio) + 1;
>>> folio_ref_unfreeze(new_folio, expected_refs).
>>>
>>> Would do?
>>
>> I think so. Even further, I think we probably can get rid of can_split_f=
olio()=E2=80=99s
>> pextra_pins and use folio_expected_ref_count() too.
>
> That will only do the right think if we know that the folio is not mapped=
 and that there is no way it can get mapped concurrently.
>
> Otherwise, when freezing, we might ignore a mapping (where we should fail=
 freezing).

You mean between unmap_folio() and folio_ref_freeze(), a concurrent mapping
happens? So that what folio_expected_ref_count() returns has
folio_mapcount() !=3D 0. You are right. Thanks.

I could pull the ref_count code in folio_expected_ref_count() into a
new helper function and reuse it in can_split_folio(). That might be
out of scope. I might back to this later.


Best Regards,
Yan, Zi

