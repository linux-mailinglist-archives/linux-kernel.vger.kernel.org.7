Return-Path: <linux-kernel+bounces-724720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C5AFF63C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152A5189E5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34CA25B2E1;
	Thu, 10 Jul 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OS1gY2/a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wtqrbm3g"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49E20B1F4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109208; cv=fail; b=V1bAK7Wc5c+jKzY3CMF7WdEbdaywR7ilT45aUx8FWQIQl47xv/E+tSyQ5jP9Hbjh0YXE+l2pp4OeioOdD/AkroNCHuamAb7WK/FkAPkpBLUWf0sqkvaInmDdmefh7PzErj8+t4ei9tCRiMbfkzChO4AQ/3drCvz8q/UcrDeBeFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109208; c=relaxed/simple;
	bh=M3MPKbv69iLTbxKVdzCN0iDfrm8nbaOCyH8ZJa091fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n7MoA7o6hvzBcydFV4gY7++9/JXAD/dEagQqP3QOj6LlCr8IdncYADOZM5Cxl7SQCHHsYHO9Lv8v5+JQDFORgAXnUtohSpi9bGIgDHfpddwvUDuGGXYo+zcsoh9+OGR6E3Srs0A6rBpsR7/e/h+K78Z631l25yQx2MIg7hKsCm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OS1gY2/a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wtqrbm3g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569NIEqI013087;
	Thu, 10 Jul 2025 00:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vytiry0GUKOqcF2jTm99b5DHZkzau4R7q0b0ggyHbPc=; b=
	OS1gY2/atRZg4uE9mw1U+qQuWhdIhhB89APYkzuP69v7I6d42zY4qNBtbdMU6xtW
	ENld0SS2OBg9FWvYNYRzlCAbyFso6NxLbQfXJO2jJE4KULg686t6+tleWPsXJVDs
	ldKO1XsiYXkqed5/VWtqFTWbcPR4KoS3iVdJMJ8L82mu8NUuvgh5fZtGB1MVIP99
	nFHgiuV1neFHNU9MrZYveX6RQ88wICz4WvhDXKvIPRqe5UNanJz7JOWDM5+gxaBK
	AefgPh1DoBfnEh2GFQWc8Qph16/Nv/Mfv5flEe7lO9Sh5nOkUSg2ujsmdslJLH4r
	OlSlaLE/HZrxjFh7xGKZOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t1y103ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0TKuS014057;
	Thu, 10 Jul 2025 00:59:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbndn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVgI1uNYzdklkeC3KdvMBAFJyXT/pFrPcLh1obtf+pHWTOpO17BAqALlmDcUxK91RZmHZt48ahP4eoqfeJBBrxaEWuz1pT2KBAkFzj9ZcT4/pb0TaV+/5QWMkCnXRoeOtS0i1zdsj2eYDqY2lFXNQiMb6yYgQQPJ70cChlqq8tZz3tHpnOZj4AFT0wSwYPZ6+GD1Y4Fw0MJ20CqXr9W992n4f7hifo7NjjPR+ph0lAru7ooC5WXU3dKF2RHz1ILYb6gLmX0kRk74Y5Hb84dFhNYNLiJ+i3w8aEh7Kn/F/gi+VO1quf2j7WoU9WbRLpkR1K9VjmodmaPNLk9WrJmScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vytiry0GUKOqcF2jTm99b5DHZkzau4R7q0b0ggyHbPc=;
 b=jZWa/+7lXChlb8WhqWXELB999qgp1E/e6WtVFfjiwRuzeR5ky6ImzfebqBct60lcgNmXp2fV7W7kTUTazJKEVTAb9GQuHtQN8NAvckwM3J1Pvmyatyl+wjz/nDit7jyH4+CTqltMZrfbAmr5Kxx9HkQwaLsTcSbeNP6KEpBKHgFKsvsDZx0QWRVI4DxiqrNKKAjz+L8m6XsQs+g/sBancmcjB4cZ0iVqI5P+PeEHVAYfaYAViltcAYVSATBzfbK+R/x5dkLLThY3MlslOIqZ1fxlzz2hti9wNNVujFzRZderp4QdbQ9RBztGyhoHMEfmqdO0Ip4Scs5Er9kKdwuDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vytiry0GUKOqcF2jTm99b5DHZkzau4R7q0b0ggyHbPc=;
 b=wtqrbm3g82DVhjx+AglPu8e5Aoq/6wL9qSvu0ouYq0b1OMXeVLTF/V42sUpATOqcgKQ3nl6NoMTUkFNrXl3Xa4u0DuBjXZsy8ovyN/Ck3oEidz2eXKOoltI43OhuyJr+TzD5jBysuwLDANgGatlyROkV4KApl3qc2AZxcTncbc0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:35 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 04/14] perf bench mem: Pull out init/fini logic
Date: Wed,  9 Jul 2025 17:59:16 -0700
Message-Id: <20250710005926.1159009-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c1d547-a204-48ce-f8ee-08ddbf4d09ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OOVaZvo+QUEQFPlgnYswgfaCZoBL+GzRg9wE13GSc+/4XJx7l8cNbVCzEF18?=
 =?us-ascii?Q?Cfh5NnDvgTNdqPmJtxQP6w25Alo6lt4SrAg7LssxHjJ/0qQnMuiiF5ZTi7Ki?=
 =?us-ascii?Q?KCKiQBlsqnPsMgoVOVKdTCldW9hduEvzyqdbTnpNw/WbcOeyM5DrVwZPvGO/?=
 =?us-ascii?Q?RluvxhGbvBqI/gCKlprbXat9YwrOVLz2fdo0uoeQPkJP2eM19ijzuqpUyXru?=
 =?us-ascii?Q?ZOW0ZXZYIFdfbQcqvHYNHtm8m2Pgu2Rh7U92NljpAaO66lmjeBlqOqgVzI8i?=
 =?us-ascii?Q?DsvxDLh/UaupCHNdB8RtffWoBEmPVn/mNY6YTRR9NwSABid++eBXvgpzUcY9?=
 =?us-ascii?Q?OHvkUcCZfHqoBrhQOCuQtkEc3eOm3dfgGr+yWgfyLwveja8VXbKn6acPKYOt?=
 =?us-ascii?Q?e6Arj9B5AIWbMqUkCfUBPWM2Exh/yE2CiIIvRiD3KyN6QdQC+nCUVPktvtno?=
 =?us-ascii?Q?WGU7FbiQ29Qu6k+vzkibtYBKGa3yrxHCFiPLtL9ItLyZRJncYJ6XGYknrGRW?=
 =?us-ascii?Q?7PL3PJVd33zpQQxYkTlLcULaQI1NySef43L65xL+Guozvbut7p1gnuwOTCfd?=
 =?us-ascii?Q?2X4F34fKVMnsLERgxQapV7B0g7uUenXMvMqXNq1ckwn1D6UHMd4FViXR194g?=
 =?us-ascii?Q?fn53b1IZpvMtybWP+QaWKpp7WW0duymKwn7vaIYs/IPM5hYFKvvgRUkSgSdu?=
 =?us-ascii?Q?E5r8Edgto7zGFAl2mwQRsr+6Xn5ROQ4f4U8HAHer1wgaTC3Qnq5KGIvGQtYR?=
 =?us-ascii?Q?lqC4gRsBUCAWvHqtoU7MIGmkSHtxWvqYyxJMMKdKshtDE4lG9DMqrXDMW+jm?=
 =?us-ascii?Q?rixprjBabQVqTIcCO77w6zGkJv8rz38dZUqc2frAqz4mn/K5m/EFRWAY0lvi?=
 =?us-ascii?Q?n0dd6bIw0QzDjZwu6wJE/L7sAGU1HxNfhpAiT39KosYj2N+UOVRaveJuebNb?=
 =?us-ascii?Q?U/z1wGKPHJuM39R2GEwnVP82GZxr214ATDWSHnzbk5NKxD8t2qu0HsY/6LJP?=
 =?us-ascii?Q?1f1JyIaa91IXOFtDup3foW+ZdIN3doUcaJxdFlnUpkD+NXvPmimYjeBq0BNa?=
 =?us-ascii?Q?/RJepG5ZNlsmGhyImXjNxNMObWj6WH3UyuO15RgdeQgVirZCrwhnVpsmZ7qc?=
 =?us-ascii?Q?Q7u0YsuXscnNLN8Rzlyn3ybmtOWOxy+ME+d8x8xSe5fcFmDL5J/lLPqJGXAw?=
 =?us-ascii?Q?y/rBBQGnrBDhWuFh3po+2kKz6sgfpX9vAz0USa49kO900qDTEQ9wPjInloHl?=
 =?us-ascii?Q?g7ggdOHRCD4Kdz1Y/ZO3uNjMcmGkLdPFOrEPh/iw2CbIRhUDFmLk/ZmmEUZl?=
 =?us-ascii?Q?vsCPv2Y7QcOCTwtsY+eVb3wlsFydvsVJfxo0+Nh+F+TGKQrAOSeUPGbHUnfr?=
 =?us-ascii?Q?aaHBuLpzEUE7P7sEIdJmIshUwvkHzTF7tm2vJsIzPdoBTWcWmGGP1BgqBxTD?=
 =?us-ascii?Q?YnsbZEuVPiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CaXFW0WHvWUczVwA60+Nzw+I2MULZkSCp+nSlUJnJFCjUaqtAIN6EtDkrWqD?=
 =?us-ascii?Q?eTfIIuuFyvNcWU67+oXizCspu48+lY/Dg0ZxyD2GYim0X5FZNACL6BJLYsYh?=
 =?us-ascii?Q?dmk8z2co+sHqBafS48/IOS5ZYzSq76asLiJ7OpkJJfnz+CzRPCiweAAufiw1?=
 =?us-ascii?Q?+4ULiR9oo8YtqAdxQhidFVBuB9RtXxN706yX2vQp7OHntgCyd7OCzuUTiBxv?=
 =?us-ascii?Q?CoyYwzZGk6fVI/eehfrFg5W0macTEtko3uEIcefJ0g08afXOdteV9P9pBQOL?=
 =?us-ascii?Q?A559w7wXsKeyXhdE2Oj5VFxJlQ363GXJ4IYIVwoMwVcSMF0JchxBUd4JyV+0?=
 =?us-ascii?Q?hAuudoubnOgeZno+igANj0nTbu6RGubh9JLpNXp/lQ8T0cGvZiL9ylhwuzuZ?=
 =?us-ascii?Q?hjorKGr5JlQm318CU+Ev8i0Viaz9sB5rbMD7dkXA3dop0Jf9vUUraHFkToQb?=
 =?us-ascii?Q?HONM2I0DS0A4VOcj0yoUK5ZqvSQuStW2YuekAu4sHF4O5QkmTk9mtXNi6Zvs?=
 =?us-ascii?Q?TaD/Xt/81TIQXwB2n+WZFtyOx+sYMmcDEWliZNN4hI6ieOYwYXjMDaIc3/WN?=
 =?us-ascii?Q?bIuWITZ2FfzKNInkFT0NXsEfJZikcssD5w90cJ8kcIlKMHfgbzh+RX4HhU4l?=
 =?us-ascii?Q?Kj2f5qCUOpjxbQvbdLqgEb9VCeFfPVkkfk2+GmKfPwEC1ECV25IRS7y5M4bZ?=
 =?us-ascii?Q?puZAX85jIYgHWN/JI7lfYgHKsJx2G8qV+SGOL//yCvFCy8vyfGXSU+isWuel?=
 =?us-ascii?Q?sERm43AY2Mav90NJ9QWVfb2ca8zvn8QzollQAxDxYTw8xZSzBeSY0WAcWN5q?=
 =?us-ascii?Q?Y6C6GZt2bM45A2Lp82xbyNmwJTgo9jZQuBHEyEBUjnOQt+VwXNNyXDwvU5Yn?=
 =?us-ascii?Q?tu+yTekCB1ZXeL08NaxHyDezB9r2AXywlie6JAd9l+z3SRDKAiLSX+c9ruPO?=
 =?us-ascii?Q?tbbm9Pd868+VR4WX7jrtWm4Y7UtiRTyGTyjk6EKIPF1DXdZfrEgEDEycGKtj?=
 =?us-ascii?Q?R4bes1BCpdwmasf2Ntb9eGBfF8fIONMIjC7fVndBHqxm+nNr9gd94lMmdV0P?=
 =?us-ascii?Q?8QPkOcNcm3MAWWPsoEMdl3kGE0JwmSB0xWJOS35HKLw9vP5hqwq+YwH3QJ6L?=
 =?us-ascii?Q?xCwWEeo312VgkaaGnw7umAKTwBNvvpBKsiIvdQC0w3Ebugz/2CT40iwzOMM8?=
 =?us-ascii?Q?Wvn5ll7BgYBMVDnDEFCZ+kwEQBWXAKGl8NkaIKkQTvcIm6r1iElnTjzq3Lv9?=
 =?us-ascii?Q?tqFDO7yMLe8P74VdsjUIKQw2kdFye72Efc74f3gzZOI44qP4C5GAPR1FCGLB?=
 =?us-ascii?Q?SV/8HgMyIE0JNxSVaM7xkvkmmoAlPSWI0k7k7BmJIN7GoQWaaHirfH+lFvId?=
 =?us-ascii?Q?6pulavVebtk8h1/vgiKhvcMZlRG3qAy4RaQyU6w6gF2Jtbh3QKDw+q7wP0Tq?=
 =?us-ascii?Q?XJA6rl00nrtqgb6HZTsY2a6E4K68gumS7VO2XYhAcl4UbZ/9vkAnW5jh7GDL?=
 =?us-ascii?Q?OvNVjUPA9oiUGxyAAYrx5EFgToa3X+vxunlg8AK1ShsNuR3/FrNJxbD45eTu?=
 =?us-ascii?Q?RKj7dXbmrnrMdMtYEaVoChbGecu+uUgqggVJ8C3bOzx96nac3rBygUkrMUjw?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TRahPG2GSfAVWmVte9LHAP5CmD2fWiGslNycVe4Hl86BLijia3TdHbuZr++V7i0WIj0Jh1f85Xjyak/RZ89raF0pHkEwc0PNOaB9qkvQlH80lCkwDy/gqV1F+JiDLEjkrptoireVP1uAQnZAXC9qmKs5XKv7Xvqk99X5asdp6/5vNmVGAyeJDnV3avHof6drHm35exs7fhbww+3PwUu4Wy+29gXNQ6k3Q0SMkiN1fGaQc/d67uw1jbUSNI6piL/PvEb7FeHAHRR6+sBXZPNAf6z5bUNCTRNIbLgJjDgchJwtSBSqBJ5NMdFK0IkkjIXY90kGcdOlqNk+rP739se6sI3zNETAetKeKYVc7qzv0mPAPbaJ3qlnrMYySQ1oHosnAB65Rrq02vV9j73B3KfwnLCp8Q12Yq/emTkSwcYk9meTQu+4eo0jaW3vpcBlLv7hVuHbECvEyeVCCQAMyVxpFKHdsC6FIm17uoQbN4FHB1JsG4zJnv4veeEZbBL1EVIsBfbjqxm+O8W+85dvtfxuFphhWuT5GDv4IMFSpDkIBrVwVsTMVN8v713CCRdHEEkluA6AwJCJ5B38DKM62q+W81thXcMcoy9srcdsaB7EUlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c1d547-a204-48ce-f8ee-08ddbf4d09ef
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:35.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaIbaHP4fiJbb3DlPqz4H/4R8KjNdkQAmZpqkARLPCdcI0+MS3w2Uk+W4XpUhmcUQ9B+Rsp/4m5t81wmk92d5GdbB1qm99/YjiuabMJNZcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100006
X-Proofpoint-ORIG-GUID: WbiFUXjAjqRfRzScsigNQuOjd4aC8Lbt
X-Authority-Analysis: v=2.4 cv=UqtjN/wB c=1 sm=1 tr=0 ts=686f107c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TbKJQeBsitzCtKh9844A:9 cc=ntf awl=host:12058
X-Proofpoint-GUID: WbiFUXjAjqRfRzScsigNQuOjd4aC8Lbt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfXyrnce9lu9B8C ogAVqo82YNuEmS0OKbpQDMkFMFmdWdRjV7WNR6uzFsYoWbHU9Lco2OZDlVdnEdLjzW1cyKeF3vG qWZDlEHR2A47OjMwtdMd62GXegSzb1sCFkoE4GTar+XiWmJWBbmdokVcQdrtstYTyN3+rh7cHJf
 trQwIFV70GsQGByGTDWsAqnVdE5nFniWKLuqouvptXy6lNGtLJgOz/9PGy7yRg123s+2ihsu8RW iEpNh4eE85E3T1r5/XCfpuzOX+Xsf/v3ef5uHi25LZX+3VLNHbYdkqh6/cS7nEVTtSIi9MwKSVw qsOhEPvcP6fOGaOQts+PnLPBfY+G2oKd8MXurb1F8Yqt+pY1RPjfCoHpbk2zxahFm7c7U+Ey6SK
 zw94cVOq0Co/Uqhm73snAoJmrE5VEj8KWXIN+1rxuQIdb2B5LVFcPSMr42+p41UOr5VVCp31

No functional change.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c             | 103 +++++++++++++------
 tools/perf/bench/mem-memcpy-arch.h           |   2 +-
 tools/perf/bench/mem-memcpy-x86-64-asm-def.h |   4 +
 tools/perf/bench/mem-memset-arch.h           |   2 +-
 tools/perf/bench/mem-memset-x86-64-asm-def.h |   4 +
 5 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index fb17d36a6f6c..06d3ee6f5d69 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -62,15 +62,31 @@ struct bench_params {
 	unsigned int	nr_loops;
 };
 
+struct bench_mem_info {
+	const struct function *functions;
+	int (*do_op)(const struct function *r, struct bench_params *p,
+		     void *src, void *dst, union bench_clock *rt);
+	const char *const *usage;
+	bool alloc_src;
+};
+
+typedef bool (*mem_init_t)(struct bench_mem_info *, struct bench_params *,
+			   void **, void **);
+typedef void (*mem_fini_t)(struct bench_mem_info *, struct bench_params *,
+			   void **, void **);
 typedef void *(*memcpy_t)(void *, const void *, size_t);
 typedef void *(*memset_t)(void *, int, size_t);
 
 struct function {
 	const char *name;
 	const char *desc;
-	union {
-		memcpy_t memcpy;
-		memset_t memset;
+	struct {
+		mem_init_t init;
+		mem_fini_t fini;
+		union {
+			memcpy_t memcpy;
+			memset_t memset;
+		};
 	} fn;
 };
 
@@ -138,37 +154,24 @@ static double timeval2double(struct timeval *ts)
 			printf(" %14lf GB/sec\n", x / K / K / K);	\
 	} while (0)
 
-struct bench_mem_info {
-	const struct function *functions;
-	union bench_clock (*do_op)(const struct function *r, struct bench_params *p,
-				   void *src, void *dst);
-	const char *const *usage;
-	bool alloc_src;
-};
-
 static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
 				 int r_idx)
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
 	union bench_clock rt = { 0 };
-	void *src = NULL, *dst = zalloc(p->size);
+	void *src = NULL, *dst = NULL;
 
 	printf("# function '%s' (%s)\n", r->name, r->desc);
 
-	if (dst == NULL)
-		goto out_alloc_failed;
-
-	if (info->alloc_src) {
-		src = zalloc(p->size);
-		if (src == NULL)
-			goto out_alloc_failed;
-	}
+	if (r->fn.init && r->fn.init(info, p, &src, &dst))
+		goto out_init_failed;
 
 	if (bench_format == BENCH_FORMAT_DEFAULT)
 		printf("# Copying %s bytes ...\n\n", size_str);
 
-	rt = info->do_op(r, p, src, dst);
+	if (info->do_op(r, p, src, dst, &rt))
+		goto out_test_failed;
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
@@ -194,11 +197,11 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
 		break;
 	}
 
+out_test_failed:
 out_free:
-	free(src);
-	free(dst);
+	if (r->fn.fini) r->fn.fini(info, p, &src, &dst);
 	return;
-out_alloc_failed:
+out_init_failed:
 	printf("# Memory allocation failed - maybe size (%s) is too large?\n", size_str);
 	goto out_free;
 }
@@ -264,8 +267,8 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
 	fn(dst, src, size);
 }
 
-static union bench_clock do_memcpy(const struct function *r, struct bench_params *p,
-				   void *src, void *dst)
+static int do_memcpy(const struct function *r, struct bench_params *p,
+		     void *src, void *dst, union bench_clock *rt)
 {
 	union bench_clock start, end;
 	memcpy_t fn = r->fn.memcpy;
@@ -277,16 +280,47 @@ static union bench_clock do_memcpy(const struct function *r, struct bench_params
 		fn(dst, src, p->size);
 	clock_get(&end);
 
-	return clock_diff(&start, &end);
+	*rt = clock_diff(&start, &end);
+
+	return 0;
+}
+
+static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
+		      void **src, void **dst)
+{
+	bool failed;
+
+	*dst = zalloc(p->size);
+	failed = *dst == NULL;
+
+	if (info->alloc_src) {
+		*src = zalloc(p->size);
+		failed = failed || *src == NULL;
+	}
+
+	return failed;
+}
+
+static void mem_free(struct bench_mem_info *info __maybe_unused,
+		     struct bench_params *p __maybe_unused,
+		     void **src, void **dst)
+{
+	free(*dst);
+	free(*src);
+
+	*dst = *src = NULL;
 }
 
 struct function memcpy_functions[] = {
 	{ .name		= "default",
 	  .desc		= "Default memcpy() provided by glibc",
+	  .fn.init	= mem_alloc,
+	  .fn.fini	= mem_free,
 	  .fn.memcpy	= memcpy },
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
-# define MEMCPY_FN(_fn, _name, _desc) {.name = _name, .desc = _desc, .fn.memcpy = _fn},
+# define MEMCPY_FN(_fn, _init, _fini, _name, _desc)	\
+	{.name = _name, .desc = _desc, .fn.memcpy = _fn, .fn.init = _init, .fn.fini = _fini },
 # include "mem-memcpy-x86-64-asm-def.h"
 # undef MEMCPY_FN
 #endif
@@ -311,8 +345,8 @@ int bench_mem_memcpy(int argc, const char **argv)
 	return bench_mem_common(argc, argv, &info);
 }
 
-static union bench_clock do_memset(const struct function *r, struct bench_params *p,
-				   void *src __maybe_unused, void *dst)
+static int do_memset(const struct function *r, struct bench_params *p,
+		     void *src __maybe_unused, void *dst, union bench_clock *rt)
 {
 	union bench_clock start, end;
 	memset_t fn = r->fn.memset;
@@ -328,7 +362,9 @@ static union bench_clock do_memset(const struct function *r, struct bench_params
 		fn(dst, i, p->size);
 	clock_get(&end);
 
-	return clock_diff(&start, &end);
+	*rt = clock_diff(&start, &end);
+
+	return 0;
 }
 
 static const char * const bench_mem_memset_usage[] = {
@@ -339,10 +375,13 @@ static const char * const bench_mem_memset_usage[] = {
 static const struct function memset_functions[] = {
 	{ .name		= "default",
 	  .desc		= "Default memset() provided by glibc",
+	  .fn.init	= mem_alloc,
+	  .fn.fini	= mem_free,
 	  .fn.memset	= memset },
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
-# define MEMSET_FN(_fn, _name, _desc) { .name = _name, .desc = _desc, .fn.memset = _fn },
+# define MEMSET_FN(_fn, _init, _fini, _name, _desc) \
+	{.name = _name, .desc = _desc, .fn.memset = _fn, .fn.init = _init, .fn.fini = _fini },
 # include "mem-memset-x86-64-asm-def.h"
 # undef MEMSET_FN
 #endif
diff --git a/tools/perf/bench/mem-memcpy-arch.h b/tools/perf/bench/mem-memcpy-arch.h
index 5bcaec5601a8..852e48cfd8fe 100644
--- a/tools/perf/bench/mem-memcpy-arch.h
+++ b/tools/perf/bench/mem-memcpy-arch.h
@@ -2,7 +2,7 @@
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 
-#define MEMCPY_FN(fn, name, desc)		\
+#define MEMCPY_FN(fn, init, fini, name, desc)		\
 	void *fn(void *, const void *, size_t);
 
 #include "mem-memcpy-x86-64-asm-def.h"
diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm-def.h b/tools/perf/bench/mem-memcpy-x86-64-asm-def.h
index 6188e19d3129..f43038f4448b 100644
--- a/tools/perf/bench/mem-memcpy-x86-64-asm-def.h
+++ b/tools/perf/bench/mem-memcpy-x86-64-asm-def.h
@@ -1,9 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 MEMCPY_FN(memcpy_orig,
+	mem_alloc,
+	mem_free,
 	"x86-64-unrolled",
 	"unrolled memcpy() in arch/x86/lib/memcpy_64.S")
 
 MEMCPY_FN(__memcpy,
+	mem_alloc,
+	mem_free,
 	"x86-64-movsq",
 	"movsq-based memcpy() in arch/x86/lib/memcpy_64.S")
diff --git a/tools/perf/bench/mem-memset-arch.h b/tools/perf/bench/mem-memset-arch.h
index 53f45482663f..278c5da12d63 100644
--- a/tools/perf/bench/mem-memset-arch.h
+++ b/tools/perf/bench/mem-memset-arch.h
@@ -2,7 +2,7 @@
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 
-#define MEMSET_FN(fn, name, desc)		\
+#define MEMSET_FN(fn, init, fini, name, desc)	\
 	void *fn(void *, int, size_t);
 
 #include "mem-memset-x86-64-asm-def.h"
diff --git a/tools/perf/bench/mem-memset-x86-64-asm-def.h b/tools/perf/bench/mem-memset-x86-64-asm-def.h
index 247c72fdfb9d..80ad1b7ea770 100644
--- a/tools/perf/bench/mem-memset-x86-64-asm-def.h
+++ b/tools/perf/bench/mem-memset-x86-64-asm-def.h
@@ -1,9 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 MEMSET_FN(memset_orig,
+	mem_alloc,
+	mem_free,
 	"x86-64-unrolled",
 	"unrolled memset() in arch/x86/lib/memset_64.S")
 
 MEMSET_FN(__memset,
+	mem_alloc,
+	mem_free,
 	"x86-64-stosq",
 	"movsq-based memset() in arch/x86/lib/memset_64.S")
-- 
2.43.5


