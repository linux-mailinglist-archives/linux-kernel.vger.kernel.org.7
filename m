Return-Path: <linux-kernel+bounces-741356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0A1B0E325
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBC0565E02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08C13B280;
	Tue, 22 Jul 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="peZOL2Lq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AKc9wdqC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8736AA7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207164; cv=fail; b=q85ixwd76/P8FOnW40CmJ4rirOwce3vFADf8FnGIseSPlPUfHSpeeWSvZShM6W+1x/KjyVvlO69GacMHhe0kOCCkexgujaYIe2aAK18dBu0e9bZKP65CaF+vkWXNGxamKfYluoAIgDfvDt/XtVWukpAaIAnuxQodkbw96H7lo8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207164; c=relaxed/simple;
	bh=+y+M0sqL5odvanZCrLOikgb4vrW4PQUS8VikOAb/XMg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K+k4xDY1/cL+/VBInVzU/E3K2TcpI787/hAS+xbCRQa+qF8GXsBYxMlvZcL3s9d9QWja5lygGvD8BJzTsQwl+sfszKxhh8bEGhb3en+g/a/VClFA2MYhRaSJef7AHP+gAMc9IpGQblWsjtJvUykLeabtKV/5bxmqrGtXCi1y4qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=peZOL2Lq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AKc9wdqC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXmrV005757;
	Tue, 22 Jul 2025 17:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=e0k7//Bfz2JXx3jf
	x5uT5t/goWadMGO0bJ5e7b7BVXI=; b=peZOL2LqUQtZSHVSEUYTyzPJjXKa56cF
	gqMEptuTO7MI18y740DfaCkKq9ivQVXiVu6+gya+5L8h1b+8Eaz3S7rCuoAgCTxJ
	btbLf2TcB9Kyh+4eGrYKlfhneyOjR08YuO8yR9S9eThXlMkeQdampwBGImdG9sg7
	fEI0MyQAkGyOscajmHNpv/O0MyqmReFl8R78ESDBBCDukolb6geN/keeo1Pg/nMb
	qBq67QmPO1X3dzSVsN5UnA8treHkZjjQxM4n6ZujjnXFLnjksDUqArArKy0sWZ0T
	TYhZamcsPC067+oZERlaA0ZC9OQ+033NyqVCcpkVWV5VV+bkIAibtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2dvg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:59:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MGLJsK014445;
	Tue, 22 Jul 2025 17:59:12 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011049.outbound.protection.outlook.com [40.93.199.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfxefw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tia/PbNwO+kNyeEpLojzdtaDlTtAr9Oh9AIMBY9WU43HqA91+AaVxnhTR7WR83y45DCqnHSqpiAZu61DoHbMvPUhdWmxnL19N9WdTN5eHyCJP/u0coQ0USWvq1+wdOfoRwG3+pqgkbbAh/mkgLp99k2HEP7plP8SwtgAw7+m1E3m3vdO7LBzXdjMAW+LDpnU8JlCOEVTm1xGxZ0/suxcBeBvhkb08KVIdacxb14QWkmkjkcObeUvCAspS/A26URnSEVhyEaLGdmiCRUpYPXSeHPDBJjfEWNUbc1wjMzWj32n0PJhNFVSnv8wWsVRc/LymuF16qBfNUCmGmjJIE5Hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0k7//Bfz2JXx3jfx5uT5t/goWadMGO0bJ5e7b7BVXI=;
 b=aYxpjzgtthMaB9Fp4LuWVNZCWwkDj7vuZF0uGr7VAhYE/0tmZ6BWRaLTeIRZOXDrkJDKinSPerzLcjZjt0mrR13P1O0fyHCx6Gz2femwe+qHISRIPle4QgL/eFFjLa1Zv2yXGZOa+4/P+Hf5Gv04n5P+HCqlCvcUPTpYVatXPWHI/77J88DQ7WuUjQ7DV9mw/dZSCIUGQ7ianThxCB7xlfAsZMXxLKbtHTo8S4GpJfCffX0t6S7vXyYN+GgCplvHxpMur6vtHJff4+rEXxqUE0sZD5MsUOYxKM4CAc1mSmxrrEhe34pInEgV1Jk9O5nFjdFWSHkjZ1IijmrqiE+KJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0k7//Bfz2JXx3jfx5uT5t/goWadMGO0bJ5e7b7BVXI=;
 b=AKc9wdqCUccqjXyf5Jx25SrEriWGw2wIsCM5jjEW2lDtuXuyj739jA2pQd76kBVQdtJoyMpeaIs1383Dk91deJ2IHMUnEHNt8GhgmAYYdiiMREhQF2sTXyVlkR32L8unh4f5FVXu79bfZgJ7iAeEcaGPYgf/VsuUMdVH05oEfSw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:59:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:59:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH] MAINTAINERS: add missing files to slab section
Date: Tue, 22 Jul 2025 18:59:01 +0100
Message-ID: <20250722175901.152272-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0150.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: d9478ed4-a07e-485c-f2c3-08ddc949755f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s/f/qrvF56VdYGH0iMgYVFQBEuXlw+VUe84g7hgH0r3dFhBAEdl0jVw1DRDD?=
 =?us-ascii?Q?aYjKfQz/0WpZS+jo6v2vfwSDBOF0sts6BV84zw3m8Fck6A+vJlb2MdPFz0GL?=
 =?us-ascii?Q?zcwKxeJ50LivCJ9LOwz+lDLvKpUl0EeurWTiycLDYlv/1iQVAXwxLHfIfswf?=
 =?us-ascii?Q?5jDPFYJyx3zC9hZVJZZDQ/1iqzGKk67NxIpFg/E3mxDDHsB6IjF7zFwJwdqk?=
 =?us-ascii?Q?qkNo3Km647jYQy23g6ul879xd94eM1ZeRxm2hmlNp9fHdoPJEh+ggUVn+JD8?=
 =?us-ascii?Q?B80pXTHhWdzndgdTf7YP2MkL2l7ycQAlK0i9SeGtp5+Pzp/HN8vtwuiKB29y?=
 =?us-ascii?Q?VebypwfB7uD/CoNN98NZ3ZSdgss+KyP09lRNKBExo/Wo2AP3izDVc2j+7aJW?=
 =?us-ascii?Q?6y9cEJvenceB0sqhrtJ0e9qIrDR+6geXsFAd8Pn33Jk7znZdFrE1T+rZ3cFz?=
 =?us-ascii?Q?narVBMAffpAwTszpDcUjUOnPGSLKBuXR4rxEiDonpdol9tAOQCgk8TSk2pRu?=
 =?us-ascii?Q?EyW11PlDRh6gCky0sG+RJp9Gmx8mKk2+GML0E0Y76qmzS1u0TpKh49M9PyAu?=
 =?us-ascii?Q?yrqkXAC8yHukaC9zVW2cqccjLwjMpkUzRVQ0beUsi8p4EYaN9h8rWABtkdBL?=
 =?us-ascii?Q?fdNiKdc2PJ2fqgcwfu7S5x3EapBUq5xbBEcC9lvJuunXDiEfQfp5O9P9gDEW?=
 =?us-ascii?Q?IGzKWd5B5SYL/Wln62oe7GOmyWLS81UzhCQpKvXhZDPA0wbVPIqlhxBpCKnp?=
 =?us-ascii?Q?uAL7mLmRdbdIUWatnM+Qi6CsJZBXeiDnbPztCdCEEtkd0lvLFlHdKZp+6Zy8?=
 =?us-ascii?Q?gN2uWZY2eDzoOq5k3rYgbhrtqh2AqqEsr+F3dEihRp3UFIkTOPxYGr1HxyC7?=
 =?us-ascii?Q?l4h0gqPLK0Rsdfrpn5Igo76tm5Rf7md5WnDFr8F9RMx+Ra6LpJZ/MYhE4yXq?=
 =?us-ascii?Q?Hj/XhGEFZxisaZffVmHadJ4FQZBxUStActUug23wFL42EqsWIGRZ3zGjedsr?=
 =?us-ascii?Q?XR1HWgEwdijmdgFiKRQ58waL/R/jdSgJaABEVK5WE5MTyzUjwBeTxBJ9z7/F?=
 =?us-ascii?Q?+q20p3HysgwHoQ1wCIg6Pl7wpJafVoIhxQfoFqZBRlJakoLmJ/5kbecwDgqA?=
 =?us-ascii?Q?TbqMGDfx5DZOdvhAmqaG/3n26jsW5F9qAJCXfFm83RhuIkF3sfJ2smBBQizV?=
 =?us-ascii?Q?f5X2qqDGHZMgLQ96C+bRh6zYJGlW6taHQoBYtXZY5j2ZZHe4/qRb1PBvF3Ub?=
 =?us-ascii?Q?pTV6NRcRRjeyI2nnNKAJPrzA6Fkq5T2EXNYCr8qZ9Ytb9SPegO0n1C4iRnlo?=
 =?us-ascii?Q?GPX47EC483AIwvYfcNbbdwWV7vad88wGkeWP6AMfldQxm6sJgIW7y5SJ6ImU?=
 =?us-ascii?Q?86gbCZLQN2Y11l2njkcrbLGU0jWqeW+oTTFhlHjQrcIOLVOndaMdM81ju0s4?=
 =?us-ascii?Q?5qt7Tv8y1EU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LX+crLsi6BwbfPcoATASgdZdUOKwtfpl9zpn4cLnvBS1lJhiVl0yZZ5yIChZ?=
 =?us-ascii?Q?9xKTUQQ4ooGjhavXBgtIOZIlrKCHd083ron4FDcUrHwKkU8b3x+5rvGSZgbX?=
 =?us-ascii?Q?w+3nqXBlBIJ0WCCyY9qiF8NQ3yQizJE1a7yTSS5xY8+4w7uHPD080BPeFaPd?=
 =?us-ascii?Q?aS+r3AVFjCZbseXi3d+x7NEvIKXhLCFhCZfHYgePz6HgHyr3PzjivVVa9WYS?=
 =?us-ascii?Q?TYbp6DZ9Zbo9OspZy7MajHxsQ2p9iuIY35Y1o/2r079cvlSZb29HQjFk4PP9?=
 =?us-ascii?Q?AkwFFDd5CHpbI1u+8IF32KMUPIBvwRiQJ8GEGq8Bfkfxy/fx+RynsRLlQmMT?=
 =?us-ascii?Q?UM6PfWADZDVhhFSZhP9IV49WdOQzy1jcZrA1lAuhqmiECp8t+TsPfFzfo8Y5?=
 =?us-ascii?Q?myVVJZTPkxWU+NufznycXuE7I+c36UqBCsjv33GlmDGGyI+zM+cxtfs32Bx7?=
 =?us-ascii?Q?gXKU5nHEvfCeFl5+KNyW6p9KCfCLSnUwOhcZ7wBZlvf5BlWwiNgLPabAFMmC?=
 =?us-ascii?Q?UWJPqb0MRKQ+ErXqparS/NGoP8kbsk97iJ7CwTa/YhF65lMjJN6i0I0iCbz9?=
 =?us-ascii?Q?dFcevTN7Dq5DOOnUAThur4GglEkCSvqFipDAKs0bFvev2YDCE8wHKD1/GIxj?=
 =?us-ascii?Q?3bFyjhBcvxB02RQWMMGOAjMfaVwQZZi8vELu2/Ut4hm9Iysdv0mWT59Vkq3d?=
 =?us-ascii?Q?UDWPbxseyvTul3t2CkmcFkFBaLsO+R96/5L6emR6NABkFYiQ9tVaxpBjGCA/?=
 =?us-ascii?Q?xP4qooBX3GxJnWPS624Pz3U5KMUIXboL27ds7pH5Oio5N9cg4qusTlcHTbsW?=
 =?us-ascii?Q?5cwvtEg/07+wmYfjtAu8EYfJAIe0kvt+q8wOfwRDFpaJjdBETiReWK2o0eta?=
 =?us-ascii?Q?C9b0GiiRBoLXzHz3xCI2AQRjkB5BnMI2Vt9xQpzAp4Dd3V7KgV2ihw5U6VLL?=
 =?us-ascii?Q?izldZruHk+Nw9kVXssgEAsK5l2xRh6AIbgINLgruuScFhMin1vQ5jqOX1Tu9?=
 =?us-ascii?Q?9NUZqbjk3vv+0zUyIEyXMHI0lkpzCdSA656e1kroQhpdnC6ZWJ/xCiXYEQSK?=
 =?us-ascii?Q?MAnPbmkjffAJDeCWeVxoJO+B1NZdcWDkVbMSI1P5Bi0AIPK4CYv5bLyY6SBO?=
 =?us-ascii?Q?942dmqdoFNt/aJyjuMMGvn9x/1Pc90DKNyr3PrIS7CgASphpVK988j6+hTto?=
 =?us-ascii?Q?EP6RSe64mmblmuytLzVXXYNHUcMc9BzDZRC7sVjb0GC715esL3o2gtxF9HwF?=
 =?us-ascii?Q?aevpuJpqP8GoegTY630S6JxXs0I2LAwM6tKHsYGEQl7ti6/7DOTS5ZiWI7Gi?=
 =?us-ascii?Q?FEN9JJ7nZF2aNLX0Eg7pOPWT9JRR/71kq3MiZv4/VTNHO7Z+MdvuXJ4V67EI?=
 =?us-ascii?Q?RxV/G5cef1/d5ewqLTN2sDXM0q+vbA5OX5EV8vsTgPlIOQnaYSNLEL6zdQZZ?=
 =?us-ascii?Q?05A8vNVOYNR2S2RVlUBBeR+fG8JlodjwfKXyhNX0E1drwNoB8tx+PsscLVrj?=
 =?us-ascii?Q?R9P/TAtSTNU5goNglvo2bOaDiRuvAJ5dUGDrlmClQnhVWZ3NMVDQ/9ZvnnfJ?=
 =?us-ascii?Q?u6Gp2X6x9sPriQp1v6Spq/yqtd6tcmQ+QqnF3eE5gIkVQOyvt+bhuasNJ+ao?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+hduLyXyR/2Zr94vqZy53iUCPk/VVuvHT/r904aH72t/ECHf/GgtFZzAprZUny9XvM42Ae7NnnEbl33DIqQl0WNLYzCLSc1x+zFWKP+2G1xCqvteB8mGMcI+HdXernc2zOJt0+ZMz3rxKlVarrUU4PKiHMT8SCKJBBNBey7WlGgxnVNJ1TJv5+n65aKXFwcmONL7ou1N11Eg5rPTVQHmddxjop8SXtIpXjf02Yv3vkl5B0+gCwJKQ/WxjqIatTCakPSdUQlUPVjzcACGNGz/KZUK3AA1Cq9c8SejNoNkOb7MTsORwJgHDrlOW0HfS1DYKQ8TxT/gpMT33UwyxDgdqSqx/CLGXF0aUUfw7PRbVo8IrjKJY0GutPBNYRhduAvnTJHu7kTzd2VhYX9AS1aM9Ixche6qaCLtBgHSZlhsn51SSgI9265/cpBbTskXlBmqVu7LlF3Bq3arPJXZTK5M8zsb30DC3on6Lu+8366TjSay8ezEJK6r+7zmOyjG2O92dZwuOFtrLJullOuUmJvAQzKJ+ZYtLF6nGVybvdyjIP4oTjtW000Qlu75IFHicfUo2lccrQ4gfSZ3eyNNTSjnUtgAxftTE7SEFfLPmRzCNGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9478ed4-a07e-485c-f2c3-08ddc949755f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:59:09.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E/z1XDFZJfj6VdDgAUx+WVHq2w8uiNySCkRZFkOCzu+jUwYlng9wHeNOJMmbWnCmj0MbbNIYrlXrmwZlTDhK+t1XSjmBdRaFXdsmXCU9Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220152
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687fd170 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=OxYtbFCIvzEO3vfXyWYA:9 cc=ntf awl=host:12061
X-Proofpoint-GUID: Dsdkw1NbAPpW4IdYzW7t7-m0Ezsn0bhv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE1MSBTYWx0ZWRfX71en5XViWXVO
 /2lnD54Mc8YcpkHJy+X3h1W4Pn014e2Lj9H7Fi8p+sF0H6LX8EkYNBbIhx2d4e/zM4Rrly4ezW2
 UhLoBryvnsCWxyxyDdfkfCv+TqAyVeSBbbCdwaruQI5kbATjrvTT4ItRqLv0fS11FLBZUX2RVni
 KTsd1X+PrhoYNycqVGchD6boo9Eqf0Mkh5aVlZe+E+JmdV5ZX9Ux4y6PHimi8zFAfez5PWi/gCI
 oFeDaC5Sn8xhAtM6JzzN7U1Vaif6JQX3JjifAS2sHPACxdPB23iVir5/avxaHbZtW+RU8wK61BK
 iqy8oECsLdiysWTNZsmNrVMx9n0Hz3mTllWXfrG2ElMWqPWjZ6y22nOOvR+8zMxdzj7XFR/3g3S
 bsT4siVKdutucewoJKnwOJgFxtFipln0cYPE7Futn+7TwV3N4/UYxR6L4iMfqnAetaC4RpIW
X-Proofpoint-ORIG-GUID: Dsdkw1NbAPpW4IdYzW7t7-m0Ezsn0bhv

The failslab implementation implements fault injection for slab allocations
so seems best suited to the slab section.

The mempool implementation uses slab in the backend, so that seems best
suited here also.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
NOTE:

To try to reduce conflicts with the latest batch of MAINTAINERS changes, I
think this is best merged through the slab tree.

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e55accbef..2d5c844ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15738,7 +15738,6 @@ F:	include/linux/memfd.h
 F:	include/linux/memory_hotplug.h
 F:	include/linux/memory-tiers.h
 F:	include/linux/mempolicy.h
-F:	include/linux/mempool.h
 F:	include/linux/memremap.h
 F:	include/linux/mmzone.h
 F:	include/linux/mmu_notifier.h
@@ -22831,7 +22830,10 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
 F:	Documentation/admin-guide/mm/slab.rst
 F:	Documentation/mm/slab.rst
+F:	include/linux/mempool.h
 F:	include/linux/slab.h
+F:	mm/failslab.c
+F:	mm/mempool.c
 F:	mm/slab.h
 F:	mm/slab_common.c
 F:	mm/slub.c
--
2.50.1

