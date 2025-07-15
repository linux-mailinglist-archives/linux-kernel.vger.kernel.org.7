Return-Path: <linux-kernel+bounces-731442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25255B05471
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82721189E0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59655274B50;
	Tue, 15 Jul 2025 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KL5IZxD8"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013009.outbound.protection.outlook.com [52.101.127.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924C26D4D8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567274; cv=fail; b=otDmD2Af4tDXWvlqWPkxcfHZMoYw5VTuf+neHOH7XnOF0BXJJ46IqP9pBUO1G1MNnifxzQ4fQ59lqu06wheV3p2wBr2w5zeWJzuZiDD7XNQzqkOcaQ3YCAK36jRENTgCa9WnGdCXU2D4dxvCfHP/LM1gNb8FDpBo+iNrInBVBNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567274; c=relaxed/simple;
	bh=e1erT+O7IcWhxeOX16j5i3D/GjwVS0fmlmxlqBFpk6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqRpDguYeIkJiZiEQUDE2fpbdAHwYvgoYjhO835XatRgr7dGIHPjX5fRx/lDLQmRhDQuF/rOvNxpNPalTieK8lceULaNs/CyM6wI1gOGSNPdWfRMYk2VWoGPiCVwqByE+yKp8sURbsBS6FiV9AsRrWHD4lmXczegLqS7ea2UGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KL5IZxD8; arc=fail smtp.client-ip=52.101.127.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAbzdIg1e2+nDqogEokOpehhM+TZ2dSNpeNIRhyraHcOjfRXeLEBFh70EwfY+ramWV2BspdMLEx2/vr3WKkGXgqrxcDd7xD9e3PhHJGI9F5sRbG0jF+x+m1DI88pxt2Mf3h1k4UDzTo/UvYs4xJ8LQHaRNhSREd9XcTQEhWGyfNzJpjAyTx+ZRs7xs4MUEy/g3SHrnmJHaBA4qkB9lzlnsmJMso7rmeSKAHet5F977SMC4Wh/2ZPOdV/Ly+sIk7i1g+g/IQ3xeXKsNxgT0Rf2ejIojy6hkglAeKaTu0P8D0bREx/xjICC2K9RYVPm2APJ1Ufhka83De0L83rPVy+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3HRPrBukD2mIDomiNEeabJ5nA2DHd33i0i17SJjn1A=;
 b=P1scDkCeovL1/0F573CDnFBuY32RLjDXXjo4GVlh2aNdpuTuqvxEia82W5vCdVsBW2lvaPsPUuiY7/EsMmrAE6xze1Ymvvpl8PX8L6Hly+kBLAS7L4Bonim6Xx8E470fjkiRdLnY/2SLzNAZ9p3HY2UxC5O2A2yHfFrIeRSfJ4RMfI31/o1pzo0WOKWLOHRSStLbupSDVGGyJQ1TxSZBHtX8sVMiBR0XGgfk8L5/Ab0lt05O2NnLA3Bzpj989bt0ipWY4cKWrpzPTt6xtEclwQq6N4D5eADnrZB5zlymp0BAHE5DizggKptb2uXm6LB4egagBBnND2tKt/EqO6nINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3HRPrBukD2mIDomiNEeabJ5nA2DHd33i0i17SJjn1A=;
 b=KL5IZxD8/GMOj5DPAE21XwCFh6tSvbbjCRZzu5Ioh7OtnjLtoX8n4iBHe1/ZjZgWqb+0+tLN6t+efuV1SuHFhyqWEzBzzDMZpW7xk1at4iASvbZc02vO4zv9jJoAKhgtdj8SNVwcIUtXHTkFeFlSaGxEX3NMkyD1Yx+74LwBqd/9Rvh6TYX+4EZ1rfawlQ217FVAo6wECayz3ZfpbT1F+cJ0oPRvingk/R4WT2U8M84cJL9GF7HNzCBkd9SFFOuJ87Li175gLEB86wW+8fIVx7g2R3irL4RrujnNvEF1ZUgrnTgdmx+7kQw+CnkgqvSUpoePB/TIg5NrYB6QM8eOgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by JH0PR06MB6811.apcprd06.prod.outlook.com (2603:1096:990:48::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:14:26 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 08:14:26 +0000
Message-ID: <137c0a07-ea0a-48fa-acc4-3e0ec63681f4@vivo.com>
Date: Tue, 15 Jul 2025 16:14:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: axboe@kernel.dk, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
 <d822f21f-bfdb-443a-b639-66860a30ccbd@kernel.org>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <d822f21f-bfdb-443a-b639-66860a30ccbd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|JH0PR06MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bea6640-3439-4d88-df07-08ddc3779d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm4wZ1ozbG5uMjRUc01ZYlNHMzZWcFFXK1JXTGJpL0hmTnYyM0VXRHlwOCtY?=
 =?utf-8?B?cjVHRTU5NnkxbGhZSHNUalEveDZiV0huTnMrSS9ZQlJENkhLdk1NaWhlRkZw?=
 =?utf-8?B?c1ArR0JvakpFelIxZmhia2dXU1dia1VXVXV6VmQxVktnaFBrU3VSQ3JWdzN1?=
 =?utf-8?B?WmhkV3k5VWgzTXZ1SFRNWUNGd2duQkhiZ1RYOEpuSlZLd1RTL2tBRGMydGFu?=
 =?utf-8?B?ZzlienZkK1YxWk9TM1FCcFRyMlJRWVNJbUZXakRYVmtTOU1XdnRiSkpiREt5?=
 =?utf-8?B?TmxnR1dlcHlJTGwwUVhyRkdCaVIza1g1WnRCb0xQaDZuYXJyZUpGZDdHUkI4?=
 =?utf-8?B?RjhJb0FlSGlud2lpMEszVFMyaTg1a3c1dElFeEZJTE16K214bE9PV0ZaMStk?=
 =?utf-8?B?Y2tMRkVkYjd5dWdjczlERlJlNzg4MVh6VDQvbitZMDdSVWRGVEluUDZxR0dp?=
 =?utf-8?B?b2NEYlFiY2JHa0FtNFBVRnIxM2crQjF4eTFTZVNBSVowaHNTcWtVN3JiVTkr?=
 =?utf-8?B?UHhOQW5QRmpRSjZnc3kvUEdKUC9PcFNUdGdWWGIzcldwT2NJRzlOclBzTUhQ?=
 =?utf-8?B?eDk4OUpCOGkzYThDeU1JUHYybmlJVXVYeGZzOHNodVJtd1NPLzZDNUg4WXdJ?=
 =?utf-8?B?ZTBXUTJyUlU2NDlqcFZNeFdibDRzMjVzNXA3NGpaVWZnaTVnTlltTFVMNDJJ?=
 =?utf-8?B?Wk5hUVFISWFwNHMzYmFpZFRYWVY5V21pVkdiMjVSa2d6clZKenFqbG4yMHlt?=
 =?utf-8?B?ZDg2SUtEZUFkV242anlEV3B4R1RqellLVCtVTlV2SHRSVTRNSUxLR28yanpp?=
 =?utf-8?B?L0p3UTFSWU1IQ2U4ZFJsZ3Z3WW92UXZlTm8rM2cza3VXOE5TNzB5MEVjdGxu?=
 =?utf-8?B?RDJEVkpsZEQ1V0d6QXZTMlpvTHoxKzNHOStYTi9lSWJjemdxZDhIbTA4SEJi?=
 =?utf-8?B?c0lEdTB6Y21pZU5UajlobVdsN01OcE9PQXdmaEVLUVgxdklZSDZ1d2c3ZHFO?=
 =?utf-8?B?OWVBWlJOWHN5M25jaEFaTjZxeGk4cjJ1cG9wRFBlY2FwMTlPZFQ5VkZZSlpz?=
 =?utf-8?B?VCt6QURGdThXb2JzZ0hvSlNoQnB0VFNhdXUvaGxoaWdac044ZWlycm5ST1Ns?=
 =?utf-8?B?blF6bTByUTRyZ3pwUVBValVKT2NSUk5EUVNJNVhUc2xBR3loSWhsaEZKWDZJ?=
 =?utf-8?B?SWhNYTVRWEFPeE1RNzFQa2ZCMmNLSytKZUljTjZaaXgxSjV3cjM1dHV3YllO?=
 =?utf-8?B?NDA1NnMrUG9NQzdLL3FjRWRja1F0UVp6UFNocFQ3OEJHK0oycEpuUVhxeDFk?=
 =?utf-8?B?cnJobUFyeTlYaVZRaDdFVUhqK3FJcWd1NlR0MDl2RmtNYkFKRmoyTFlMRzlY?=
 =?utf-8?B?dE9Gazh3eDNGRklMc2xDdnd6MXpRV2FqTUpVYWVidDdvTlh4YXVoUEZTMlJq?=
 =?utf-8?B?N0sxYlpuYTBNTGhrOWw3UHdJbWloOG04U1pFd1NrQVlQMXBCdzJjRDBoN3I3?=
 =?utf-8?B?bGFDLzdmRlZiKzQ4Q01zaDRkbitKVFVnZG1EYTRSenhxWTB3Mm0wNEJnSFVM?=
 =?utf-8?B?bVBmazFLVGNiYkxMdWlBZzhYcW9WV2ExYkhHMFZINll1aHZZRDBPWDE5d2ZB?=
 =?utf-8?B?WFpuVXFjc0RCYk9tU3FnaXFlL3VRNzVxYkRoNUFBZUVobVJmQ2R2VGFtNTNn?=
 =?utf-8?B?MHE1RlhCeXlEVElBV3dmRmxEbU85bVc0eDMvd3FKaTFSS0hVY1lwUHBtb25u?=
 =?utf-8?B?T3ludUVvUTZNVG0vTXhuQUQ3SlBMTHhwMVgvVG1GVmI1L0syQVRDenIydFh6?=
 =?utf-8?Q?7lfnMWdCSAjYfTmQ8+dNvQ23CEYFqJnHOAixw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1hHSWQwM0o5cVViZnZZQVlvd2VxQU1kdDVPWmVUV29aRy8wcEs4dytmMFZK?=
 =?utf-8?B?alU3L0Z5OGtuZGZhNHJkVXFLYnRmZEJzZzBsTTgwRnBOd2hETmQ3blZsL1U0?=
 =?utf-8?B?OGxodzduRXluOUxZcUJ1Z2M5Vmg5eDl0TWs4d0wyVWp4M2dhSmkwdFJZVHBj?=
 =?utf-8?B?N2s0bFlNV1JvQXp6R08xNVhOZVZVeFVod1huN3JTRnVZOE9tODZRb2VIOHlr?=
 =?utf-8?B?SHVIMVVoRTNnMGlXRFVPbTVZZ2hUYXNuUnFZZDZHTDdYSXBpVGpqWnZyMEdR?=
 =?utf-8?B?WnZhTmpGdit4Z0lyMllJZks0bXg2MDBhZnRzUVRUL3N0YmZPOWEvQW45NjN6?=
 =?utf-8?B?L0lxeE5ueG9nKzVJdURQYjlybnNUQjIxajN3Tm1zRTRBZjFhOFRrcHFvOHVN?=
 =?utf-8?B?QWpValJpY2c5T0NUL0FWU0pBbTE5TzZMWi9xL1BzUzdJeG9OeVYvTUQ2bDc2?=
 =?utf-8?B?REF4V3VQOUU0dmxDVzlzTEVWa0JzbTA0NHZjbHVBcFljdUY1ZlQxaXNLNmpk?=
 =?utf-8?B?bXdtYS96dDMzR3JnYkdVejdnSG5PVUNiTUE5T2Ribit5T1RjRVpodDJzU29Q?=
 =?utf-8?B?dGdWMlZCalN0OVNmTDZPc0E1ZzdwYXczWnV1aEUxaW5lS2d3SEo3SktxOXVV?=
 =?utf-8?B?SVRCd0pTLytTK3pRVmFiYURYUnJRRm56UXNNR3hyaW5OeHRLbGxGVzVOOGV6?=
 =?utf-8?B?UFNjY1JwRkE3d2JiVDljaHArREVPVEM2VGZTRjVvYjNTSytyZFRoVzNDdXVY?=
 =?utf-8?B?ZUpNUVZRa1dGNEswZjA3ZUNmRGZjalkzNlh2cys4MCtHREN2aThCbmZJUlk5?=
 =?utf-8?B?ckh6ZjgzUkVMaUFVa1lGVS9NTUV1U1VvbHZ2Vk0zSWJGVEZBbXFhakpSUkR4?=
 =?utf-8?B?WE5aNXNkdHFTMndKV0cyYVBONitQSE5KQXhmenBCYkZWdE1JSVozSUF5NUl4?=
 =?utf-8?B?U0FFeHJqQ094bi9tSWZhYmRlak94WVhHWFZxM2dTNHRkMk91SldSZkF1T0Nz?=
 =?utf-8?B?Z2lPQlRWdVppcUNYWXA3dE5FSGFDNHc2UnVlV0ZyYjhVc21QL0VvdWFPNVVD?=
 =?utf-8?B?REoyZHo0N28zdmNNUkZMTlNlS1Z5SC9EaXhZOEhzNTBmREFNcml4T0xaMTdk?=
 =?utf-8?B?aDJLQklreUd0dVlOK2swYnpQN1VLRDJtbVY0Nzd2SWtFVnBiUm1wM2JsSW9L?=
 =?utf-8?B?MVg0V2M2UVowb1hUWnp4YmZpakxwUVYvbzFqM2pvRWRlak04eC9aVnZickpC?=
 =?utf-8?B?QWp5bnFqeFg1SW9WOWlXSjJoK0xTZlBxR01ta3lCbDBuRWkwbi9UV2t2ZUx2?=
 =?utf-8?B?UUsrRVBsOU5HRGp1QTFXUGt4YlM1RnlCOXdsMjB0N2VEamdEc2lBQ1lmWnVn?=
 =?utf-8?B?cUdncXVEWjkvNnZIK1hXUGhTVEdBTHJwYzFBVjduZHhCQnBBU0NoRW01SExu?=
 =?utf-8?B?YWNWNkxIVlhQSm1ZQnRsWlFCT0Y4d3k1RE9Qc3cxUWE0SFpNWGQzS3BtSUlW?=
 =?utf-8?B?eEluSVVwdGk0VHpoUklwQytpZjE4SVhYcnk1TlByN2R0ZzlEeG4yNm9Nb1VD?=
 =?utf-8?B?TkwvSVhXREdQc1ZveHFTTkRkajduSTRZQzVNcDB3OGlmbWVlOXlaTEZnVUVI?=
 =?utf-8?B?SWlxTTA2eUVURFZVd2t3L29YWVgwVkszZXJOM3VYTkJQcmxWRXhMY29LNFIx?=
 =?utf-8?B?OGoyTDlocngzYkFTdmkyT0ExUTllSlVyWDFKZWRHZGRSRCs5T3hnUlJIMmVU?=
 =?utf-8?B?YW5jSWRTUFVlODdsOW1GTlcvNEg1NWY4OWNQNU9HY3doU1lVNG1CdnJRcEdS?=
 =?utf-8?B?cXRla3I2UUNwNGRHUWxxWHZ5bDVvd1VYL2g4V1RMVjR5Q2RKd29YZUY0clNs?=
 =?utf-8?B?VXBRcWZJUWdGU000M0dyckFKQXVRbDd5M25Qb1l5M2wwdGtZa2NNd0E2TzRs?=
 =?utf-8?B?YnF4VUY2YzlUQjJzSVpYYVFsMit3b29QZnI2cDRCdU1UTWkvYTZEZmh6TDBt?=
 =?utf-8?B?d3BiYWVzdkl4bmIzNDhuNXZza0RWektleFRZY2doRVhzVlR2YXZlL1RJSDRy?=
 =?utf-8?B?TjNQd2d3RUVsc3k3SVNDRXlrWjhDd3JyVDkyMU5JNmUvekd0M0Iwa2hnaFV1?=
 =?utf-8?Q?14XkF+WcfYdw20Hapjl1M+Q3Y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bea6640-3439-4d88-df07-08ddc3779d59
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:14:26.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okXhKN7we9Qt6zu/WzwGULQ3dOYj8yMIBgKP3BRU/0/38VoInNuh95qKrKD8NkeLPS+ISV6SJpoUc8poODVuVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6811



在 2025/7/15 14:58, Chao Yu 写道:
> On 7/15/25 11:10, Qi Han wrote:
>> Jens has already completed the development of uncached buffered I/O
>> in git [1], and in f2fs, the feature can be enabled simply by setting
>> the FOP_DONTCACHE flag in f2fs_file_operations.
> Hi Qi, do you have any numbers of f2fs before/after this change? though
> I'm not against supporting this feature in f2fs.
>
> Thanks,

Hi, Chao
I have been testing a use case locally, which aligns with Jens' test
case [1]. In the read scenario, using uncached buffer I/O results in
more stable read performance and a lower load on the background memory
reclaim thread (kswapd).
However, in the write scenario, it appears that uncached buffer I/O
may not be suitable for F2FS. This is because F2FS calls folio_end_writeback
in the softirq context, as discussed in [2].

Read test data without using uncached buffer I/O:
reading bs 32768, uncached 0
   1s: 1856MB/sec, MB=1856
   2s: 1907MB/sec, MB=3763
   3s: 1830MB/sec, MB=5594
   4s: 1745MB/sec, MB=7333
   5s: 1829MB/sec, MB=9162
   6s: 1903MB/sec, MB=11075
   7s: 1878MB/sec, MB=12942
   8s: 1763MB/sec, MB=14718
   9s: 1845MB/sec, MB=16549
  10s: 1915MB/sec, MB=18481
  11s: 1831MB/sec, MB=20295
  12s: 1750MB/sec, MB=22066
  13s: 1787MB/sec, MB=23832
  14s: 1913MB/sec, MB=25769
  15s: 1898MB/sec, MB=27668
  16s: 1795MB/sec, MB=29436
  17s: 1812MB/sec, MB=31248
  18s: 1890MB/sec, MB=33139
  19s: 1880MB/sec, MB=35020
  20s: 1754MB/sec, MB=36810

08:36:26      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
08:36:27        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
08:36:28        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
08:36:29        0        93    0.00    0.00    0.00    0.00    0.00     7  kswapd0
08:36:30        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
08:36:31        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
08:36:32        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
08:36:33        0        93    0.00   75.00    0.00    0.00   75.00     7  kswapd0
08:36:34        0        93    0.00   81.00    0.00    0.00   81.00     7  kswapd0
08:36:35        0        93    0.00   54.00    0.00    1.00   54.00     2  kswapd0
08:36:36        0        93    0.00   61.00    0.00    0.00   61.00     0  kswapd0
08:36:37        0        93    0.00   68.00    0.00    0.00   68.00     7  kswapd0
08:36:38        0        93    0.00   53.00    0.00    0.00   53.00     2  kswapd0
08:36:39        0        93    0.00   82.00    0.00    0.00   82.00     7  kswapd0
08:36:40        0        93    0.00   77.00    0.00    0.00   77.00     1  kswapd0
08:36:41        0        93    0.00   74.00    0.00    1.00   74.00     7  kswapd0
08:36:42        0        93    0.00   71.00    0.00    0.00   71.00     7  kswapd0
08:36:43        0        93    0.00   78.00    0.00    0.00   78.00     7  kswapd0
08:36:44        0        93    0.00   85.00    0.00    0.00   85.00     7  kswapd0
08:36:45        0        93    0.00   83.00    0.00    0.00   83.00     7  kswapd0
08:36:46        0        93    0.00   70.00    0.00    0.00   70.00     7  kswapd0
08:36:47        0        93    0.00   78.00    0.00    1.00   78.00     2  kswapd0
08:36:48        0        93    0.00   81.00    0.00    0.00   81.00     3  kswapd0
08:36:49        0        93    0.00   54.00    0.00    0.00   54.00     7  kswapd0
08:36:50        0        93    0.00   76.00    0.00    0.00   76.00     1  kswapd0
08:36:51        0        93    0.00   75.00    0.00    0.00   75.00     0  kswapd0
08:36:52        0        93    0.00   73.00    0.00    0.00   73.00     7  kswapd0
08:36:53        0        93    0.00   61.00    0.00    1.00   61.00     7  kswapd0
08:36:54        0        93    0.00   80.00    0.00    0.00   80.00     7  kswapd0
08:36:55        0        93    0.00   64.00    0.00    0.00   64.00     7  kswapd0
08:36:56        0        93    0.00   56.00    0.00    0.00   56.00     7  kswapd0
08:36:57        0        93    0.00   26.00    0.00    0.00   26.00     2  kswapd0
08:36:58        0        93    0.00   24.00    0.00    1.00   24.00     3  kswapd0
08:36:59        0        93    0.00   22.00    0.00    1.00   22.00     3  kswapd0
08:37:00        0        93    0.00   15.84    0.00    0.00   15.84     3  kswapd0
08:37:01        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:37:02        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0

Read test data after using uncached buffer I/O:
reading bs 32768, uncached 1
   1s: 1863MB/sec, MB=1863
   2s: 1903MB/sec, MB=3766
   3s: 1860MB/sec, MB=5627
   4s: 1864MB/sec, MB=7491
   5s: 1860MB/sec, MB=9352
   6s: 1854MB/sec, MB=11206
   7s: 1874MB/sec, MB=13081
   8s: 1874MB/sec, MB=14943
   9s: 1840MB/sec, MB=16798
  10s: 1849MB/sec, MB=18647
  11s: 1863MB/sec, MB=20511
  12s: 1798MB/sec, MB=22310
  13s: 1897MB/sec, MB=24207
  14s: 1817MB/sec, MB=26025
  15s: 1893MB/sec, MB=27918
  16s: 1917MB/sec, MB=29836
  17s: 1863MB/sec, MB=31699
  18s: 1904MB/sec, MB=33604
  19s: 1894MB/sec, MB=35499
  20s: 1907MB/sec, MB=37407
  
08:38:00      UID       PID    %usr %system  %guest   %wait    %CPU   CPU  Command
08:38:01        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:02        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:03        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:04        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:05        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:06        0        93    0.00    1.00    0.00    1.00    1.00     0  kswapd0
08:38:07        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:08        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:09        0        93    0.00    1.00    0.00    0.00    1.00     1  kswapd0
08:38:10        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
08:38:11        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
08:38:12        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
08:38:13        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
08:38:14        0        93    0.00    0.00    0.00    0.00    0.00     1  kswapd0
08:38:15        0        93    0.00    3.00    0.00    0.00    3.00     0  kswapd0
08:38:16        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:17        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:18        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:19        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:20        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:21        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:22        0        93    0.00    0.00    0.00    0.00    0.00     0  kswapd0
08:38:23        0        93    0.00    3.00    0.00    0.00    3.00     4  kswapd0
08:38:24        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:25        0        93    0.00    0.00    0.00    0.00    0.00     4  kswapd0
08:38:26        0        93    0.00    4.00    0.00    0.00    4.00     3  kswapd0
08:38:27        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:38:28        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:38:29        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:38:30        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:38:31        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:38:32        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0
08:38:33        0        93    0.00    0.00    0.00    0.00    0.00     3  kswapd0

[1] https://pastebin.com/u8eCBzB5
[2] https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m0dff9e4f79c95a75c6b2cf202bc9d3d6f4559723
Thanks,
Qi

>> [1]
>> https://lore.kernel.org/all/20241220154831.1086649-10-axboe@kernel.dk/T/#m58520a94b46f543d82db3711453dfc7bb594b2b0
>>
>> Signed-off-by: Qi Han <hanqi@vivo.com>
>> ---
>>   fs/f2fs/file.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 696131e655ed..d8da1fc2febf 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -5425,5 +5425,5 @@ const struct file_operations f2fs_file_operations = {
>>   	.splice_read	= f2fs_file_splice_read,
>>   	.splice_write	= iter_file_splice_write,
>>   	.fadvise	= f2fs_file_fadvise,
>> -	.fop_flags	= FOP_BUFFER_RASYNC,
>> +	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
>>   };

