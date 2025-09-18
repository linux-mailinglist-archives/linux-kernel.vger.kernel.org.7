Return-Path: <linux-kernel+bounces-821131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE5B8084B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82EB1C2694F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16293397D9;
	Wed, 17 Sep 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y8bgp/qo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GTWUf2eX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF53064A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122719; cv=fail; b=ENAUCt4RKipm36ghIjG0QRsN08UIH5qIwo49IpR3uNgbQbYOxzRR+HwCytpuDk8uvgHDGTQtzNRXBVVVjr/Ogt+Ac4uaYUpMDbHQWQkV4gC22U4k2XkNmidT+WvWYZkGU8ziGVCqIjxB38R5VwqxYneCp90fzIKrzK8g1fVf6iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122719; c=relaxed/simple;
	bh=TLjwBgdN08zvZ0tPxVOZT6FUGWsYfIom6QvGD7j5Mho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y2ocnhkWUwB7u3qWIicPp0gLm/dO8hW8gSkXdWHP0InvdUHwvL9RrFnItbr7Ggtl4pVPq2DiEEabpg+OW1+Byb+SONN5rBMJO8HTC59s9xr3PeH8oCwn1DI2gqZscZMFEP0oAnoyeFb3Zb/4RQ3wfbTewDa36lm3g+M0Z4uV1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y8bgp/qo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GTWUf2eX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEISXP007332;
	Wed, 17 Sep 2025 15:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E+qSf1qFl2cxfz5au0Rkydfar4LZPeBi53cDe0EjHzg=; b=
	Y8bgp/qoChfD/OAikGvmkCiBJMK60vcunaOompbZDmKcYcLBu7c317wD/txeimcu
	VLP91g2kyiySO8o0RTMYG0BfvCdJOJByUAZ6a4c/Rmsln5ykg6wOYQ+DDGCNBSZi
	0hOeuuaLqjbL9u8AMO82HdvykTuujsVbngBoeGL9A19w6RnSZ3Ky/lOpEkDMyUuo
	YAJs2kAD13pLbPbFF+2IudbjRy7A7GE4VfkRJoLof/ElC9zGDdPuf3pxBDymFsJi
	noVCnXBNFt6GGDYSSyIg4I77hrxYvS7MEUVBfYcoQO3y9FJCLll0N3sJNdmwsqOB
	IAOsE08TA8rXYwS0VQnWKQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx91gsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEbBbc027235;
	Wed, 17 Sep 2025 15:24:37 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2m70xr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1ylje0qO7VnMaQso2Q846Idh10+SsozMRd1i9MHp022mGFGV0EiHq2uqUsbhvSS+4SEtdQELEF+L7Tfyg4GK2hArAk1Q27GrSORaMKkZZRfOJyJOWzEQgwpvn8/qjXODHjEOPejHOowKKDjwTQtu1hm5JSi73wvH1uEOHuCLjXl9bkHw145Ir5oNLFbrs/cJtYGKEpOzFYsFhYneM9q91xRTiAHyd7fhop9B/7SAYUPcIMNTAsWiRVeJ+2Lbqk2ySzqhjiDOzabXDEoYwbcks8RNt3FslWO8vfGs/Q37ySWncf2lYxpHIKzBA5O67cu0B0vmET32U7GA4DkqL7Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+qSf1qFl2cxfz5au0Rkydfar4LZPeBi53cDe0EjHzg=;
 b=gtOndnYEcnrrAFKCZI/abyzofUN38VzaR1ds23SkWzkNn8PGieFY485i2wdy2qKcpWxFYL19KU1oqsO8OI3EwA7Id799TihcgHEO09eHqBJMFyZ4seE9g98h5rEkjbuGcD+Lq5vWevofw05K7UoVyLTTy8ZGvlIHPYY+EcTcxraiKYdW42XkRCBL8tYIXaG2tJY+FHa3lsXFqJP/LcIjvg2Cj/iWHVjOOicrf/C9X1880LaBPC8iJ1fu4quY6e8LnYtDAiqVMSMiyTQu3RUNtmr/3Yw3aOYEpk/rq78oBUwz1tPIrRsHZXwoHKEQBxITGYfH8abG+MnpGr0WU+u0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+qSf1qFl2cxfz5au0Rkydfar4LZPeBi53cDe0EjHzg=;
 b=GTWUf2eXgQDjH4dMQTMlN1Oyy2z7KiLii/r+5+eGNrDXAOXqQL+ZpB7moEjRXFjReb6bYupaKaXJ5ioAXUn790sn1s8f6t2tatm83BZQ+Vlhwvapivf0i3C9tlVCuyYjloxBgqQZ/RXHeuoCXA+onEs+T/xWFwGgh7DfSFemVw8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:34 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 08/16] perf bench mem: Refactor mem_options
Date: Wed, 17 Sep 2025 08:24:10 -0700
Message-Id: <20250917152418.4077386-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 4786e0b9-d629-4933-c3ea-08ddf5fe4eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X7H5P2lmhw7ePmAvRfK4r/2BmbvU9bp+HhOeo0DjotOvsH01ZsjtmDmZnkPt?=
 =?us-ascii?Q?3JSCDXO8WG9sbEasU1apVBsm6ZrgnugMMBS48QvJUJ8PEl1BtCTidQSzfnBJ?=
 =?us-ascii?Q?NE72+lJNNoYM3YzIijydm0iB58UWbXMshf7ns4tANiSIyJ6bPMAbWXLc6YcY?=
 =?us-ascii?Q?oPpnHvLijGvSs+4bPwR/MtE9Z53+ejYdbynnNSNnAFGw873Kda6MT2R/LZ66?=
 =?us-ascii?Q?3qQQQohz8gUpcXQGyYrJS94tkQxJIAATTj/1Xb9Ft+hFv+wZWR4Hz0YvjMxl?=
 =?us-ascii?Q?FwQ+YF7/zQPZ2F+9DxNQpVVKMOFatABvpNXAM3Mfr9AJe3AoYFk1X48wUyor?=
 =?us-ascii?Q?AvPE93hVKzh6nfF9WpqtYd7ECqFvOgnB9miNtMEBXrjYcHASDS/PBIdQpJ2p?=
 =?us-ascii?Q?zwVulTOtBHK8aCFL0IJKzFO3zeB8KZaqLBtoBOeKZcrq1CRg+p25DkJWhIq9?=
 =?us-ascii?Q?3pJcD0xi0XHnZaggru6Jp2ZsNl2t3l3Dh/klsf1CskO5eWL4ntVXHiycykmp?=
 =?us-ascii?Q?Jd0C0JkyZZPYYmez+tZxBRZfdLXAc5+h+OA89fJ1RJ7CuWR/4YOYvUAjwytX?=
 =?us-ascii?Q?zcjstIyd0CIz1IDUa1+eZtYjdgRb2tJRI23eHePrUmUDlUQwYUWRARL7CdPC?=
 =?us-ascii?Q?20xU7C7YCq1lyJznE7lEsR2F6ASyj6begg1w9ONzBANIzeYUmOksUli1RImV?=
 =?us-ascii?Q?K3Oe11xZwH4eoE77gsbU2Cje8tA7I2IdAZoBMX2TH0LszktcqJB1V8ldd3oW?=
 =?us-ascii?Q?rl2wbJEbsq5CuoTj5TUQOrWUnHPeky82WHJ9dlzOwHPW6xlcIRHNJzzPrp7p?=
 =?us-ascii?Q?EaH9uf+bLkX7/wOwpyS+VTOrsJ1I42/0eRZ+a2TKaR0D2/FGVO9Hp8jPfaX2?=
 =?us-ascii?Q?NWqSA09f6TyvQaCXShL0BjFwFEHxXNlKpECwCPkAi2+sSdABBpXkGkoYj0ts?=
 =?us-ascii?Q?sLj9D4m+084lVR4XQoWb7VoGY5DY99DKaKEpILo5rUXkWd1fW7K0SYwC27el?=
 =?us-ascii?Q?wSoCRvs8NW8CKp2mbLhR3pJghjYoPOwI5hbRi7MEf8jt2/e5d8HWwFSzDGGY?=
 =?us-ascii?Q?DxmxqW0/x8C9EmJqpLXwoVAUbNUtoviIbTKcrkxGen0RgIVdQVwdFcY12Qtr?=
 =?us-ascii?Q?bIanrg7cPMdE/XBHhj8oPmbOnJ80LOK+LUs/wGuxcxIIZ+NHkNhzBVVUPu3s?=
 =?us-ascii?Q?pyzeDIjGklXsF1/WFS1BruldUCdnPgZrFFZ9Q2L2Jhs981DApOcsFDUIO+9X?=
 =?us-ascii?Q?AWOYfAkxlm4ue1CowC4/xTdJdA6qnNR0z+tbJTd8ZzLgihXK0moIBMQouJrk?=
 =?us-ascii?Q?s2xRfm09H4Bd0MeI1z0OVddXb8aAWm5ZT48juUC3KSRXmlFhFQ+2Z6cc4v0p?=
 =?us-ascii?Q?SuIQKnxHmPtxCaLE1PCGF0n3YTx2hAR68xurPEOAFIH9C6o10w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TVw5Ek9bNoIJ3tfSWzRu39SrTCfroHg2yldOAAK5PdK+tH89W/3vXkB2NJYm?=
 =?us-ascii?Q?Lg82G5SC1c4ynCeMz8jcnHjlsnmHTMMWvZ/KvzUr/gdHOK9A3Um8XEXqhdU5?=
 =?us-ascii?Q?EKE2yo96AlYlSK6rbiqyxy+P10ldmgI02baSVcvUQ8jK5+sAZT60Pt5UNpIS?=
 =?us-ascii?Q?pGI0o7UCMIo/JZYJHviGtaljtyf4uQs56Waf8Udc2lvmgm5R+8rSLnTMcBmR?=
 =?us-ascii?Q?rXpxEIPs7xPqFBPQNeMs+sg3ZME/H86irRjAeeQogNGEcZEERZsEojelGKM8?=
 =?us-ascii?Q?q0Sb1JD+zxhJbUPqd5LYBuSQ0hsyXV1Wo1euIjMJRcz3JsVvxNtBmbZG8Mrl?=
 =?us-ascii?Q?lBjFhKhcOAiOgSnUZbpoACktEAqdJaBD5SNXoPkXrcLo8zxzpnqJ2m0Kjm0f?=
 =?us-ascii?Q?pFLmHczewPZK5rEm1iep/4AYW6IKFrTZtkot1IKr7X7ew48esMgJg7x2x6QY?=
 =?us-ascii?Q?hrpq+H5aTcLbYoSN/eKA4961k4nAQfPa4FTW56pQZu/gr+gMhHoQMNygl+Qe?=
 =?us-ascii?Q?g0CqJ2jHWSmz3CfoRRPk964+YMxUHtsrBZ40FtgNEWkE4FUW7u6K3kW+GH9l?=
 =?us-ascii?Q?Ib9wRIW78fVEUY7UKhf2LNTokEwdnuv+/0YRe0bmJg/TpnAgZ5HoEpgDvKIz?=
 =?us-ascii?Q?tY3Obg55anZb2BAqEVjVm1gOrqYL/JW6WADjc8TVoCW1324QIJsnEQ8/OU9g?=
 =?us-ascii?Q?7brRiPLT1Ydux6/3KZ98clPUOPKbUayYSblIhP18PYhQT91/kY5iwl/fwxmY?=
 =?us-ascii?Q?ZCjNIY2MY5mPCFrPdD6xmEjmvp0ws16tUmudL476bW7PYcWhbnqGYZPJck8Y?=
 =?us-ascii?Q?t3MYJzuVgpwp++iXwSEjDn+GuQt3Qo43iShRxVi9YMcagMTQebaaTtAHaCMh?=
 =?us-ascii?Q?OrYsv6pnGoGlzOKNO6/lqQg/pVsT4qOBiERT7QiII2jnvmkFsEabEoMO2346?=
 =?us-ascii?Q?aXLJBs2r5OQRTOKaGaGXgMX8870OzL16CD/93/adorIhodreTaPR1ycO/AwV?=
 =?us-ascii?Q?z8RDBd7ieJVa0n1e7pLawDLMCIVDoWCggpMlwMUsn/yNWmataaREDV+h6tL/?=
 =?us-ascii?Q?0rwUluopCwN872Fj9xKWQGJO0zcp6irXOBk1YhA9slwTP4ks6eoClScjshXr?=
 =?us-ascii?Q?2PuKABzgwGaSsofBmegNg03J4tmfDzNtgtxFMt7qyNW+aW6hVbjP0MoKER8e?=
 =?us-ascii?Q?8viqRlOmcor1QKe3berQuJvwCcB2FFNnZw3x8NJVOPAPxMRoMw5fdozT1rQa?=
 =?us-ascii?Q?K8VvERoWe7zmKVMjRSXdRIFWRQctHObT8nd93ejXWUlpd1M2p6dJFT7SKN7H?=
 =?us-ascii?Q?1H8gmMvRxJHmQ9MIXshrpJTrnfbmO0E9uLf0dSP7wyjU2I+dhx9CacY5U354?=
 =?us-ascii?Q?hZLri571MxJ2r/9cYEGN2Y5fTJtTvytCS0nz/a94Zl3ien1S44JZj/BtGTQC?=
 =?us-ascii?Q?GxGeXiCWA4tXeRfIiW/8Xh9xIO/MtVkY8uR9E354+CuMqbev7p0WwrnkgVdk?=
 =?us-ascii?Q?cFKwlx1ckRJuAaEnzeWPtnZyopGNO3Ewh0uKN9MuFA/8i6AtVG0tAkzFkOLv?=
 =?us-ascii?Q?tciXvQJwDuJb2yCoHjtZMd4Wzy42GPJuukO4eYdbuIENZWatbp/MEr7COM2E?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TYaibFWSyP9wG70XQa4M5Qtf63TlhA1FREuSL4lN5RUCrJ5kkCoNS6QrhV6esnlIViFgMR9K824lpq/cNy34NfppRnDqa/65AFSxxn2jD8A7pq9tgb2gRPG1egGlI4oX51o0na+h/5oplenUi4eV1EhGnU0PbESlsSGVckZRS+Kv5GcbIJCopzEypDAxLN+9k1ARU297u6uM6fZwegazZ7DaitI3+SSGTFirdqdQUbdv7Oqw0+LzHVAfKii4ApYPc0uBxerufbNHcpyM8LC9dO+CQ3aGr4ZrVZfTpiqoKESCth4R1lmlEIRlYGvke8VXBZtEvLoQFFVhhsawIqOZI7FvCBTdH5ATcHQRgqkumlVSwP0IZohXh5sITA7IMJXEwpCo1id8cSGy7+4vT64xQ5Sex43ujQ3wlFFCH04LlenEIx0fEKKQR7/Ef0i/KDRgXt3EdUfb2rJ0KReZoDcxf5WyIhZl+5nBPGCUELqFabsnPm2tcIs9Fpj+pNZ5k5SY9SnRO2k2FH9ZMpmSEMQyG4wFmTnNc1dDwprx+s9AEiTD4xLWwQvtvX+A57qY07Hb1KgnOB4cLA7tgTrcAm/pku2S/GiqmXpUVUjsqxTYQ+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4786e0b9-d629-4933-c3ea-08ddf5fe4eac
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:34.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFvrEk30EfKVANly+EDPhW+XqA+mOw/YzGuyNLr0zNYLwamb5B3m8n99AS12vtMAgCfFHAbsh1xPZjVE42pvxwbNMMa7Rq/vZ4IA9s3doU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170150
X-Proofpoint-ORIG-GUID: 0AHnILUj1u7VkzZODwm8VilYIuONC7GX
X-Proofpoint-GUID: 0AHnILUj1u7VkzZODwm8VilYIuONC7GX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8g7F7Fk2DXBF
 g1LJOq/qPTpm6Yl6d017jYjBzbUeuISnQusyPFKbNtkct+2GmZYyJT1B6muRGBvU6SNPOyAOEGK
 r90jhBGqMnnJzBkL152QsIWMcatF8ws02XZ/tAFKEPExwo0QDdDSpTPnR72gxlxJSnwmt5Nyesb
 DpmzJxLcd47f9h1hM8bpAZxYAZucRUTjqBMDEP7+hZm1zCaxICuqeTYfhBhQncxi377HCMQIrfp
 H6ThT/16is6yX8GPMW+6U0gvcNJbfAcM5GhY2L5Kws+cMLg7l+guyFtkfw0EEmIbclidbcTB5BT
 JQtM+5zvNYV8rv4ZrN6D448+bDqgP9zUSl7yyaGrjJy29phaIEvGyyq80Mcff3BHaebgHA739d3
 RSl72mawV+Ubwj13rCSdgtgIlRVFBA==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cad2b5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_oAs_-Zd7h5Ft3cs7ucA:9
 cc=ntf awl=host:12083

Split mem benchmark options into common and memset/memcpy specific.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 69968ba63d81..2a23bed8c2d3 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -41,7 +41,7 @@ static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 
-static const struct option options[] = {
+static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
 		    "Specify the size of the memory buffers. "
 		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
@@ -50,10 +50,6 @@ static const struct option options[] = {
 		    "Specify page-size for mapping memory buffers. "
 		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
 
-	OPT_STRING('k', "chunk", &chunk_size_str, "0",
-		    "Specify the chunk-size for each invocation. "
-		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
-
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -66,6 +62,14 @@ static const struct option options[] = {
 	OPT_END()
 };
 
+static const struct option bench_mem_options[] = {
+	OPT_STRING('k', "chunk", &chunk_size_str, "0",
+		    "Specify the chunk-size for each invocation. "
+		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
+	OPT_PARENT(bench_common_options),
+	OPT_END()
+};
+
 union bench_clock {
 	u64		cycles;
 	struct timeval	tv;
@@ -84,6 +88,7 @@ struct bench_mem_info {
 	int (*do_op)(const struct function *r, struct bench_params *p,
 		     void *src, void *dst, union bench_clock *rt);
 	const char *const *usage;
+	const struct option *options;
 	bool alloc_src;
 };
 
@@ -230,7 +235,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	struct bench_params p = { 0 };
 	unsigned int page_size;
 
-	argc = parse_options(argc, argv, options, info->usage, 0);
+	argc = parse_options(argc, argv, info->options, info->usage, 0);
 
 	if (use_cycles) {
 		i = init_cycles();
@@ -397,6 +402,7 @@ int bench_mem_memcpy(int argc, const char **argv)
 		.functions		= memcpy_functions,
 		.do_op			= do_memcpy,
 		.usage			= bench_mem_memcpy_usage,
+		.options		= bench_mem_options,
 		.alloc_src              = true,
 	};
 
@@ -454,6 +460,7 @@ int bench_mem_memset(int argc, const char **argv)
 		.functions		= memset_functions,
 		.do_op			= do_memset,
 		.usage			= bench_mem_memset_usage,
+		.options		= bench_mem_options,
 	};
 
 	return bench_mem_common(argc, argv, &info);
-- 
2.43.5


