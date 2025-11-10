Return-Path: <linux-kernel+bounces-893498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B4C4790B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E94ED441
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025823D7DB;
	Mon, 10 Nov 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LdUqmshr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e4Zr99Og"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C49476
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788676; cv=fail; b=QyeZws0SUmcZfQi8jY0Kg/waRYOEeX4NDPc1oOOXdGLXZkTklLW+/OjOudeHyucRzAhHJVku+penTCEHAZqDdFoC14tAmF4kkd8tADFCKJedDGPTvrtKtJFkwIn78FRM4yvsSB03d09qtRdQeM/LC6gBv/F+6zKi4UPXRBK5fzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788676; c=relaxed/simple;
	bh=62MNrBefa4fU1puTcMZ1jdGNU8RR3YAXQAJ7v7KKM24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bux3yNJJZnOJoftKdquAPtOax0OClrY0oKnrV++o3VDIsFSu1qrDsS8rMjphMlNS52fyGJv4EGhVm+6fpOEG/jlihXz+bM5hrPb5q8UQ3rz4682MZvSHiwQYp5T7A58YKl3XLgBHxWa6O32mCEpL/xcw0sgDfUbN0AS8T1K7kUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LdUqmshr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e4Zr99Og; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAEgAnQ004653;
	Mon, 10 Nov 2025 15:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dftl/ZERpPzrELuq8Z
	vNuXv8QzTwJSdZKLSLeMk9sfQ=; b=LdUqmshrMYDz1ccPuFcyHfZ4jw9JP/fS9k
	8PRlGc3orYZRppiaEom6BC6N3xBjEA3i332Q33y4Z8zXbyzxukmKBMCOMbnVeWGa
	JFTNXIh0K+HqOLDPkKSzczTzWKI7p6RmdGnVjjPWRdKuTwRrMEWJgDxiQj6c9fAT
	S+KbuNKDQFmwRDkROa8cf2kx40WkrWMe3NFe0vLdLoPH8mK61aJJOwHPUVTVnU87
	HNAcqm5pKv5sRbJjxZ//gdjdwfhd+asVzVG7Eee3GljuTgY6Heq0Drcho3gOLH1a
	LFF33qIdJPOHTMKsKs3V3V7t5GwQV5xyJGOhLLFVt2SfyLhp4rMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abgs50axd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 15:31:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAF9u0Y012821;
	Mon, 10 Nov 2025 15:31:03 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabsnvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 15:31:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZndhZBho/J9vJKCL8ZZBgSqF2PGsvRS8j5IZnPogrBWglLTqloQ2QmYj21EWW1dm4pu1KgwYtJz3VR41sC/aZQce8UYMkiUKdWHPyWHVODvMhAKHgmgMzNEFuanJ4jWNEk3wj9bhZz8fuSG0aIYjyPDlUCkOIGeA+Y3h7z6n67/Y4XNXXN0aw/f04eF9LvBehUXBpHPNeSnNCptZPgsx1ZoVKcIR0a61jCx99VzhqsHa/3rC1zAkJCndOmN9tbvVjdGy+ZVg50pLGUIBbpgQesuMCDgT3XC7IPHNKRgj5ec8sAnv6hoVG28Onl3PlfWJ7il4cnt6sdOlP90o6pbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dftl/ZERpPzrELuq8ZvNuXv8QzTwJSdZKLSLeMk9sfQ=;
 b=mwSVuaHVPllqJREVtv5VMCakSvuXX+SL1kEN4GTb0svRR3ZR3CI3aVX/5j0V3QtBVMx94Lo1bHziJRYjTjfDybr/7huGVAlpxqQH6uD27IADmnjaI5UX6/8y+Wn/cKZk95KgGmxl2SozMCeoHImVABnGPV0SYCwzXzNcj3+9Tiw3tzKdD66HnmOS/MZvew0eOTpwWTswMktHORPSHUFOqH8LKRmwL+6fIoiFFkUU2DUJV6BOzSKKS/8IqE5jWtEmuPTU1q3d0iu7xu4XIldVW3vDlcCBLzAw7hD51bNy9pMS2VFShDT1HrqZXDMH1Q8GVssMFfeTz6uvEtuNobQ2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dftl/ZERpPzrELuq8ZvNuXv8QzTwJSdZKLSLeMk9sfQ=;
 b=e4Zr99Ogz5CfhhFYoMfLEFS2/2TYlSewkXjJEDerfH4LQXZfM4DZ6FRCwsRleg7rL+ODANjUzW8pXFQoitiliQ4M8ds2qVmzmReSNZ2gxglx1us49FXpL+B9bGUmusWlwYKhaKnvEVh7c9vR6vxrEBRYncthLmXovi2zUT8q8GY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:30:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 15:30:59 +0000
Date: Mon, 10 Nov 2025 15:30:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <414139b0-92bb-4516-8286-732f2d5e6bda@lucifer.local>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <11eaf7fa-27d0-4a57-abf0-5f24c918966c@lucifer.local>
 <87h5v1zzib.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5v1zzib.fsf@trenco.lwn.net>
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfee98b-8702-435e-b156-08de206e261f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vjiHKI5JCgbf9bfRgdt93emSEVN3di/0CfScGkIDgzdZdzqjtsbeYBS/gqty?=
 =?us-ascii?Q?pNwZN3uSnOdm8lZY1vuaDxCqGXsgYci+k0VVTjcP+aHElI1744fP/3V8u9HC?=
 =?us-ascii?Q?EWUKYiwH3tvJt+9sJkSqsiyvGBI0li1yBJJks6uw4oukJ4DajDuTt3LinefZ?=
 =?us-ascii?Q?vXX8CejNiLcDAPL2Ec05mbn9sDRVde2E+AJmbdI8RVGN9oXblYrTKuuU9Q24?=
 =?us-ascii?Q?CmTQJnSCcrFGyz6AUeKd0f4ZGAuxzE4dMzlnOhuyNRzIVAKlHG1z8YG1Lb4H?=
 =?us-ascii?Q?fPKV0jzBFkK0C5F8OaHPkBtCWEOq9AMhQZkogoJwAlwCB829qEJGQOqwXKdM?=
 =?us-ascii?Q?+XNQfdwQjxWbVcpjsS02SFuLR76WpFq+Z2sEm369Ve1bwRTG5gCH2oL6ttlw?=
 =?us-ascii?Q?O9Dah9y/6p9/YKqYI8wcWFLSftVLxDTw7bb2lLjC6aKdKcVvOvqeTHA+TXwE?=
 =?us-ascii?Q?BRYy++uOlKvAln3/bA2p80Lw8OJx47mN8yspSA7rJBcrNjRCtNP74Wn+mneq?=
 =?us-ascii?Q?Ob9I8qFCIFfW3VDYTeIsQTDIA27/zWpBrABMkVSGOJVp0Oogsw7B+0RMrP5R?=
 =?us-ascii?Q?9Ui2EIhVpDaFIMZL9poVCOmlA6TihGMHIWV1DXqnlGGRq9dtDQGxEpXYxfVo?=
 =?us-ascii?Q?1wEKCmMEatrDMATsNyBE9ojJ0WSO35J9LhfwBn6yjzjQ9IoVF1uTrTT2+Om2?=
 =?us-ascii?Q?jGgOz4c4LkBf/+NeneLT1v1QnzvIVyAM7BZPZjWaVi0DPWLikwOqzMGp8lfn?=
 =?us-ascii?Q?bjbHTrSp8bnlrz9AyFhBWfGLLWTcbFOb+CRO8+trFqraJxXLMycNWHbVideP?=
 =?us-ascii?Q?NR4xP1J3EwN1PQdJ8fioyup/IlSnEm5NrkvLHuAdjwRGr+9UV2NZBE41X87v?=
 =?us-ascii?Q?J/iEEbU2hLXY07KvGBSENbs8vcGPqEm/1kcWK2lK/JbSX4xW7ObDsdkZUfHj?=
 =?us-ascii?Q?lV6zVatv/NWljzHHPOEQhXIb1njCKMOO7GVbPeTY6Qcm6uxUgyHwKXXw6NtP?=
 =?us-ascii?Q?6IYAcsutzz329ZGLJBE7+5JCtzy6izWhlDaPBOyutW96kzo99YSZnjpc8pld?=
 =?us-ascii?Q?1GHGOQS3sToLz726fEXdMzGBXlim3rhYzpK2FGZIpEfC3FpOfDdev2IO3lMx?=
 =?us-ascii?Q?tQe8RKpWT0JckKqAciWExi2DZXPQYpQabKqzlgjIbKbI82mklc18JXTAPfn8?=
 =?us-ascii?Q?PViwF7Ne7OUsWaqgZYUK2LqLVGgMMJIKCM6DN7R/mEXoTC3aMepVCo/nRnPj?=
 =?us-ascii?Q?PnzzAwsNZz79cwpRyc2B0iTy/OQ18U33QkjL/bG+pCcJu/99O5sQQg2THv5n?=
 =?us-ascii?Q?lnKTR4LEAJ8dYvM434/Uf+2xusWBy2Ivg3hDK0BfSZuARUJ3x2yf645272MJ?=
 =?us-ascii?Q?LnIZ5xPWbXefpTIyXPkETUrnPgsy7iCY/+5okLIRhU0mHkJPe3d9m42W/hvh?=
 =?us-ascii?Q?23futztgYSjAih811+l4RMorarw4N3YQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQHdL597jqonOU7esYjDfXbjKwvElh1GCAHxAysdEBCsVpHoavtgTZzQI2xU?=
 =?us-ascii?Q?MQwQXQe5ubnzLdY6jLjVIE2Rc9umzBrBWWnqWMVvrvJLWMwefKTD7XB+LydJ?=
 =?us-ascii?Q?rMYgYaGdMmWU+MV+E7RzT3SkhqdOG4ni4Kb/pKrZVnSmny5V1M6RRIznn8IO?=
 =?us-ascii?Q?z86CZAwCUzuiC0J0EFV1Pysx+nMNki6u/iCvLgPqpkkfmtwwWToRAk1bxomP?=
 =?us-ascii?Q?URCiVv3eBVutvsOJ3gNWH9YkPwheTgpo6sCLXA9+BlyEBRVTaEwoabFSxJte?=
 =?us-ascii?Q?Lmu5785T3mDeTT3SUh+hix6ol7ZulfVVCwGtdlwML1rJQACgLXFbVBZquY0o?=
 =?us-ascii?Q?pGVLN3BpIHVr3gjyr1VGrOZVCmwELTr9IUkwIpoyoSBX1MoSDD9vjVQRoDpO?=
 =?us-ascii?Q?6TpgG3JPGVQukpub1XtU4rM4q7aKnecqUrfpjn/Tygs+vcsPYzvgsjsDZQaj?=
 =?us-ascii?Q?bAmdqHZ/CQfpqp4mRqOeWjHpf2DcZaJMe6Uca3f04HOFh0cPrN9Di/d2XZwi?=
 =?us-ascii?Q?0U/lslWYalerQj6/r0kP+nmHKaNblvzKmsUX3dQpaFpurhoGLvBtND5omtEH?=
 =?us-ascii?Q?k0nNhfwYfUnJBzHFgd+I3ETSy3XSuEMKyury+tbW987u7E4Z2mdoR3JB+KYv?=
 =?us-ascii?Q?k6oJVJsy144waNDRoRo2ANqzf8UzisS6qEzV+k91KLCayIRpgzY1/y2lciv2?=
 =?us-ascii?Q?pr7PomDr1UNzXHKkMHvJvHy7qtiqI1/47Lefch3JNMC6m4vCAmqmppbGRgUN?=
 =?us-ascii?Q?IQKPIVduJnlAp4XShVzuVAsu+8E6a4/ALwtgIxSTQ/PVtvZyc36tzNIo9qNh?=
 =?us-ascii?Q?gBcQl1S5zaZcnZmA7sQXoWCFueaof3HkZOkCcZcRT2On18idLJEQzPfRfoqf?=
 =?us-ascii?Q?DVJruzGTJnU3Mhw1gyxUeHloC1ENSeJfcPbOJtkLtyB/hqxYu/M3941j1ikh?=
 =?us-ascii?Q?BiRu+lH2VWVdWQOsWrFnpQ4mrqa62zkLZaXWEk+KpWv+pt6tQ/049eBl/N02?=
 =?us-ascii?Q?JQJEmKVtx3bxn1xWdy8S3dVhqF1/5iifv4OB/CXYHRznyBomLWUGlIFSg3lO?=
 =?us-ascii?Q?9VFMgKwNy9hVuQvAzP4ZZxPUnbXqvpBEk8MnFqTCaZR7QGBiWeEjYSHQkR2M?=
 =?us-ascii?Q?sMV4ldQTgN1ulBUjrhow61g+1swfvYq6A4ULe4WzGC2G6kBUcgVXqwdTSWH5?=
 =?us-ascii?Q?R6Fpl2BlWn+O9lr9RwKbZSlO1WEEybe54/Y7P00SeisvtGEOarCgreB5jsNG?=
 =?us-ascii?Q?F3QV8j909+gn02Xjgn3PeHAJsAV6fBVtEe5eGZjyLjG8DjNs4kqieQ3VFhLH?=
 =?us-ascii?Q?sMkTao+rvfLIg3rc52ekXPpND05wWunIAVjT8McxhTUZJbrCxYxN8/8Ka+D5?=
 =?us-ascii?Q?OmcdixnIqnqOT8gCuXSCVu3RyG6eVwsG05mV9WuLUlWWG69ZLbuadK0vTAyz?=
 =?us-ascii?Q?WD9krRA0RwZT2rlYcMJksEHPaOkjQSPprqjOgcdSFwEL/UoURmYSqweBCgdC?=
 =?us-ascii?Q?Rmh6tH8TDInfPwt/eNeKdhPwu/HoOzYZheOFBU5RUR07ZwjF/6Yq6TD++mz4?=
 =?us-ascii?Q?yuQbUuw35hjLbpKrwgSqXX5a0AEUpMpXjmucq1wF/SnzMab7CfWFKp+QYCgQ?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G+jOs15HaNcl+QvXllBw1J5ByAGQLOap0q0akkf/lSbmbB1LVRU0zWd+0VDGnLlwV/mD1kcSDUTU96csYlPp7nZPLzfT71GSISyysObE4WOvWAULvDjXEPtD0nryM9w0NihzHmsOLCvrMH4awlrFnsmDwMVlzTmclToMPnYPhesqJx8GQis/Gqc7Vgkf7sV9JEyunG0IZkCzwBvZP1iYZbCRWmJqtekjDVRFI254sFnArcILw4wnBNGwuWpTlB54NPbK/Rdd12UvhZusTiraRcshFkHM0cA1rcaqMplY5m7o0omxBTte5Ru08X0qZvpgb5IoG1d0+1Gir9xilA8JuFHwemV0vVDx0Y7ANl9gsrJuN0xfjDsA459K7eBMT5JGcwCXU+NS26COBSoSjZ7uwKff1V8scTGU5GbC9dYir5q7wUz1MbTelM9SM9aUV/NHGaMFTyCJ8VKQ3jg2rCacziQ+xVr84dRBsb+CmX+lXxSnIb03vjoHDH89nn2bikR0LyNgSLMZAoJGyb4a1qjBpP5L8kepyN575hTFl1Ugw9Q7BVVnCXguz8V+JLx2ydL43VZ953mnpHg5jC/LylZT8KsJCIpf1ZM/5sVDAuSNxHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfee98b-8702-435e-b156-08de206e261f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:30:59.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdXRbk44cC6jy9VUmgvwSgo9Ub1ZxtVJ9gFPO7ARIW6UjNV5Oib0Y1HRaK9sb4gqoQ2vq3Kbkyx0oJsMKul2xbLRFFmYBZNd8xjnzBxFLJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100132
X-Proofpoint-ORIG-GUID: ygi5N7sOolrpaPavIyA_agN5BU4IDEA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNiBTYWx0ZWRfX/KWFr63fQpJA
 6jukJH5sDz33HvNqcoAGQcLanT0n43rqe+emc/9RQcjE/5a0dPphdgjLXpbLAXCGTBu7WGo60pc
 DNChV56lY4U0ba8ecrVo6b3aFwH+05u7reFFYEqZ8XM1Jtvoghn7SsfbcPcBY5/ps6mj5yOF4rp
 yKRTWfBenMhOmi/VgokNSKASAhv4PPUHmwrwel7cCfl5bwWikiTIM9u7/so6noNKgfGL/2aZQeA
 Mh95Ws4+ArTZPO0gzclMExQH0knGDKmdrOmjbr2zVBNzivbWjQ6xP23ItmHADMceiaVYWBqWESs
 mU6zd45Iqoyxg9GiOJKsoCVf0ZsPEVKlb1juVTmChU2aDD9btHLOBkSMIAghBRVpNd9fQl+WEnH
 7q4oev5+yh9oQxKlR+WgQlICh+cqpM0jkndfChttvRMac1KnIjw=
X-Authority-Analysis: v=2.4 cv=PtqergM3 c=1 sm=1 tr=0 ts=69120537 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=_W8vX05nDvCfFHxHK4UA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-GUID: ygi5N7sOolrpaPavIyA_agN5BU4IDEA8

On Mon, Nov 10, 2025 at 08:19:24AM -0700, Jonathan Corbet wrote:
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
>
> > It also seems slightly odd to produce this in advance of the maintainer's
> > summit, as I felt there was some agreement that the topic should be discussed
> > there?
> >
> > Obviously there may be very good reasons for this but it'd be good for
> > them to be clarified and those who engaged in these discussions to be
> > cc'd also (or at least ping on threads linking!)
>
> The reasoning, from my point of view at least, was to have a starting
> point for the Maintainers Summit discussion.  Trying to start from
> scratch in Tokyo seems unlikely to get us far.

I Would understand if this was an RFC or there was a big block saying 'this
is not yet official' or something, but lt the moment it seems like a change
sent only to the TAB committee as an apparent 'fait complete' with no
indication of it being just a starting point? (forgive me if I missed it).

I think pinging the relevant threads would have been helpful, but maybe we
need a better procedure in general for this kind of thing.

In any case Thorsten posted on fedi so I was made aware and pinged others
:)

I'm not invited to the MS but I wondered if this planned to be discussed
there? I don't really care about my involvement, only that there is
community engagement on this.

>
> jon

Thanks, Lorenzo

