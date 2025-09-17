Return-Path: <linux-kernel+bounces-821141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F80B80893
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FA146733E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28D371E87;
	Wed, 17 Sep 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qo9oF15n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vZ+YcbDl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CD34A32F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122728; cv=fail; b=rEttH3MDCbyPhf6PYChhgadyuBdVATU9GUIIHMOAu1ATpfpOP1eUKrn87IageVMxlN3uca9C195eeO9c4tlZTgaUHBbcFAX2f8fa5WoI4mLsJL5hDVD1/WTROiHtXhghK5yJAATfFdCDs36UvERHzgALZYSgFtRbRy9JtEXqn3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122728; c=relaxed/simple;
	bh=8hPsNdy9qCXf125riU3MzFZFPfQw9rsCP96FCuf3gDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YV0DQZBDFdFsSLo+Hd3iNCXO+EkVmXKNVUvqqlLOaOADpv6XW8LigukMi/ibNxK0NQJ8zNUEedVKnFSxCItcaDtGg/SYQmbYdp+K3BASXzRIEG1nIssNiVd3B3i/3QRdJLY0Um0cyuzkelOHXXVr3H0crPI6gQVwB/cPpe4OLVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qo9oF15n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vZ+YcbDl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEISxZ007341;
	Wed, 17 Sep 2025 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1jhh2wbXgvNKGlkz07LK3EJ3G2Jr6Z6dAyuV5F6P0xk=; b=
	Qo9oF15nCG8GGsM7dHIDGb3LuqI8TzIZmiGN1vQMa79CqqZu9Pw3w8FwGpftvXfm
	sSgckhDFNbfVZh8EUxuyT4RcolcBXzljQNV/TSylmX68wMRCegZd3e8XmoGLJvLh
	uF6dSuBCI32+oH4Op6PZkSaRrWvJ1RqAAQoJ6pCpacUQ/s8ErKfwdKTQWLdQ5/+O
	Wr+BtFQx38UuKySokWhIcLU3bHZPmkTbJYNs4AyPNVw4eQV/+IGcckix46JqeJuq
	E336x68DE2hvkoa+E2S1yeP1cxvs0lBWeuKHbmfhm8whJ6mu3Gi5ENkmNnHJWuNl
	0eHEpGz9DrSicNFF6qFt/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx91gsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEm8dH036930;
	Wed, 17 Sep 2025 15:24:48 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dxufg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuGxvxP/YQe76pSKJEvSj/b6f8BhE4GU1da0jdzLZX8nrCYyY64ORVbsmeE+8ywV75Brxe+YkGguPIuCXoENBgRE1ceoETMjUa33+rGm62VmD+H5/+qhJneDWrKNCytuILzHppe6gVnB8VILd9FjY3Y9GpMy+2OS7erJeKhcIOc/xyZEM8oWDh2ckUbEZStdc4ugTj26buAMRzTprRAYglg6k1eq1cDOfw7L2YG2jPCErTH0SvnOzgoa22rmLe5UO7QUbo2bERMy5bnFcDr+bKQWcMqVgvP9a9pKNS2cVsNoPkwkRwpa6bDHP93Pi3Q5IwJifm267H5yREUBI+DmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jhh2wbXgvNKGlkz07LK3EJ3G2Jr6Z6dAyuV5F6P0xk=;
 b=tNdOgFAH1o0BvEmmpU4YqM4g97vPpsfOLcdfbNHkGFkRFGUDAeyJIFh5oJcqbMsIC81Xlw+WTX/Z5IxNLQlFUbBQsBmSQBtIos+fuKYd1zOQZFuAI2tNADj7mfjGGQIEQoFhEKW4VObQUyTR9a5M+cKBVfp362FkhRKr4LbQ5+SzsiXydbpMU3MYXmY0+9kOBmwrLAQ+XbSMn5BIBlp1jrU77U/ezw3q5T0oiLaVwiC8D3ArV0EwwYpvMrCgjLxuxTql9ALL0xb3jeQD1MK8ihUrqovzUrXsCjJJg+8WyjpxrqictrsCvBN8Pxje7LRrz3SjisAywM8/GFHrvYDPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jhh2wbXgvNKGlkz07LK3EJ3G2Jr6Z6dAyuV5F6P0xk=;
 b=vZ+YcbDl2qoEu0d3v4Q0D5YjLQYj6Pdez2rCUiA5msjn7vGutr2VoaqG9l/ijtAO51F9KTAwwaKtF6ESD6PzA2oUT6lZX+tvhgE7yHEew7rTF1ylOHx3tu0wvvmre2Aa9h8eMH4V30JyOFRxXLtRZYqyQmaIPLL1DSxv+AzlNZU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:41 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 11/16] mm/highmem: introduce clear_user_highpages()
Date: Wed, 17 Sep 2025 08:24:13 -0700
Message-Id: <20250917152418.4077386-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: b0716c09-4eee-45ce-334f-08ddf5fe5256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F1/luQa3ar69KbRC9isGlwcjOdsc5LcXYo2Eym/TJ7h6TL17XNJhFwMHSRaj?=
 =?us-ascii?Q?20qbLlTgSj2+3u5elOZb9QPyIP/UiwK7ofDjS1NFCj09mZdP0nyw7IHXsU7V?=
 =?us-ascii?Q?xBoMpnFmOL+NToFu0tFUgLPh+B47a4VqsLWKm+en4MIFa5cbea/6QPpEqSYJ?=
 =?us-ascii?Q?X3CLKakdxX+lZAFR3IgETM0vwGyv96PN1YzCfISlwAZiX4A3mIbVK2t+1c8t?=
 =?us-ascii?Q?Q6E3IsQbGaTNYOqxxxc+2TyGlZ4kwKig32Li/uQYzybo0nbGtNfALoIyvqiJ?=
 =?us-ascii?Q?dwqL4YgtFB0n75QjIfV+xBC7T7OrUzeYgODQGDSsAvg16UIBfMXP7NbDdGM4?=
 =?us-ascii?Q?UADVU+QCjPXiJEIJO9yn4S1cC29c46dLAFodoZ4+8zQNQ40+48UsyxK09DEZ?=
 =?us-ascii?Q?WP/H63/0sc4LsabHpzPvKErU6tV+K6+cD0dOh3SU2zg6XHkSSpeUKFxb9Xpy?=
 =?us-ascii?Q?DVhKuc14IatwIxx4tYQHuGVpBja9Jwywt4SsMFQQ0sRt0IP6M2VsUYt7cEtb?=
 =?us-ascii?Q?9f+oHysCrBmVU7Bd27iaoP7uzzcDM4IM7vQk6IP05mUtB3+GZ0oXKbyKbJCj?=
 =?us-ascii?Q?kj7tc7hnDUgBIh6q5linbtyrQJOK+NTaDRvm1U0kIJShZjUmSXr3AGn8D5mN?=
 =?us-ascii?Q?/zB3Dshr+t8nBG3vqyAyigbcwS45Lz8enHnGB2NVY1E1MLO2IItTHjmQ6g1+?=
 =?us-ascii?Q?nMDci7j4C2gKKiO02V6hzqbrt/eYZifddGqlTKhK+GiZBmpvhKK1m3IeFK2P?=
 =?us-ascii?Q?ZtOSKUrQpoKmQCeOi98rqsHPX0QEHKhkCdzobAKO70C4xYjOuW6XuCriA/Wl?=
 =?us-ascii?Q?KCWiByHbCy0zCx8MGquEbLqmV09V8vpQf9Wsr3SQmUeTpEjF8Ow6DZXtk9wr?=
 =?us-ascii?Q?FQF3lxjKz3hCfst7140cD2Zb2oQ3zIjgIEBT9XOFG8knhK3GftY5XZ28PYsv?=
 =?us-ascii?Q?8Fo5Bq7J+fc8AY5BODZio+3s8Mx1q7MXg0vC0cX+j2k3HIp/lP8tWfUdRi/+?=
 =?us-ascii?Q?nQPxjU5trONcBapx4ifyiMe+0f036FBfIcYFaidz8I619N8+tzrbP2do9rP8?=
 =?us-ascii?Q?AgkHGNLsMr3qn+Feht6JzkbO4Ku8ACBzMyt1cjId7FWpRheIDENin7iHJk+h?=
 =?us-ascii?Q?sFJ/g0kCuFIPNBqKUhh7Uw3TZQsYcKCID8/83Og3AP9XHdnm2zR0Wxk9Kf1z?=
 =?us-ascii?Q?Qq5DsQRlurWhfU59GBHzILgVHw2hmCsRMOzLUI4WT/rYeVHsdawSgNpnPjev?=
 =?us-ascii?Q?wcmp58xBZ+pS3LCyID6AmCaOTU7cZqf+7uRVmy2veeWVmqEVvMzm8WfjsO89?=
 =?us-ascii?Q?pzSd6BT9sQ+F5veB7GkRzJuhC5xJYGEt9q4uSsB4AtPe3JMzPX+FI7PoupoE?=
 =?us-ascii?Q?M0kKBRk+xu4Q+Gw+1YV8cI8vPxXUImEsnpid9u4MUyCHRtxZ+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tX5jAygqLRF0VvhWPAswLRUIg6+pBs0ROUhYbaFyN9/bb1WztXfmkuHGqydY?=
 =?us-ascii?Q?NbMSF9z2UiSMUqiYIgwPtOAvUWnYq2y41Vv/Cg02FaQoxXuZ9GAUfQKiN6LY?=
 =?us-ascii?Q?Gf/PdWah3FHub17l+E03ryDR0CqbJBQm+gV/yu2L+7uRi5LGmg0dRrY8hvKJ?=
 =?us-ascii?Q?2cBacn+kD1y9VG4H/dzX4RRvrdbZweNg9sV1hFakomB7ORwaj8KMF48YLjs3?=
 =?us-ascii?Q?ncG94+mjaBl8boqDbFnDE2FDodDdGdquqUzyIojkuMJhCrf6oMkg3jLE9Q8r?=
 =?us-ascii?Q?6oSKvuZsg1WYQIkSeq3zXQu28TkRZOPkVWon8kwnpJbFEuaprQNTiyDufk5W?=
 =?us-ascii?Q?fjMjPr5BFSjkfdDDpBKkVSndu1TU1l+ZJ4VRBq48mfvRKllBpd+rhPfYxSoC?=
 =?us-ascii?Q?FNgFr8znCbnO8ck97lsQhr9CQTPmes8YpHriKoHiwYGAShRYj2eRFw0Eugu6?=
 =?us-ascii?Q?0A8W8HHcFs8Ihu4roLooty6bGiDRjuN3rvt3jtXM3TgTvSvvudQ6nJZeuMGP?=
 =?us-ascii?Q?Fa7FwkN4zTp6+4beQdBboMmMh7Jn7KlyIr8ltgWHMMtcvspETwJoWJlpzJ4I?=
 =?us-ascii?Q?NnE4N0yHEiErcrBHFtn+tQ7ppj5ApxcDi0LXLY6fZinWqSSkmiEJuniJ+TRH?=
 =?us-ascii?Q?b4O/Dn8EnsCyzLWGQbNHIkTGWcS2WPdgNJANFac5UE3E1uhDF0F0U+VDA3g0?=
 =?us-ascii?Q?1sfKrHclqFiG4RgqhVmk8aNE+XkjnSIjBzU/xY9+APWbVCUwEei8ar8Fc8si?=
 =?us-ascii?Q?3+Ighk9X2Yu+7eis2YHCtiD0Uxjp5UmnBj0T57XgVQ8RdQowLVJrgEMD56xR?=
 =?us-ascii?Q?/3SwR8asi3SBebolrAellLXd93tBRj9kaYzF1dO8o9DEs34uIDL0aQUJD37q?=
 =?us-ascii?Q?2e58KvgGxI8pZqOz8Xpaq07IlxPGwENxoXBw88UWaUCIxWAhgomvFtQgjev7?=
 =?us-ascii?Q?Vgo/H2DoVyGPeRm+s2sfpvHfRLRVPsIQndYnIgoNAz8SIoPFon/foyeKTy8p?=
 =?us-ascii?Q?Uq8PaZ57x33LolTfU5Drew2OOaFyvxPZ+2JMUFkRzejdxupxSFPXqVNwncEq?=
 =?us-ascii?Q?Z+cG9g0VWX4BuRFBW2UrLr8NJ+c+hUo8AuiCCgMxeErfpuezHw8XQsawYefX?=
 =?us-ascii?Q?G9z1zOSqbX/CZ9umZcmUytMvysfcNQ7Hxd1eIfTOVEpTOI1oyHiFx1sro1d4?=
 =?us-ascii?Q?+CYii71TyqxQC3Rrx81+NYbtAgbwdS/lH6Q/ZvnXQzA8LM7HGebVKmNdlcyc?=
 =?us-ascii?Q?Gd8sudAS+j4NlSI6dPbsexnC80UBzvYEw3TdP7Y78Wnem9fMcTKEyCiLE5Wx?=
 =?us-ascii?Q?Mzq0pUrwBfIMq9HZ3LxkSzK7Uwp1DXJTfhpvYAc0nCsfEt3H4X3wND/IGVEF?=
 =?us-ascii?Q?ymMgJbCM2SJgMqme6kMl5mcX3OM6KK/g/PBy6nl4M/nB0MSgzWK2Ujc2uOGi?=
 =?us-ascii?Q?gRbRJLxbFzYV1a4EAvDvIPq881WPD+QcI9EsUwUq99i3L24JthRS8/fAkwla?=
 =?us-ascii?Q?KsUOWf0dodwp/CkQVEp6V/yoTzop9lRx20cjmHLxiDDTOEevN2Nkciqztmgz?=
 =?us-ascii?Q?PZl3zrQ2v7tTkq8zYGtpHQiNCLWKPzKpraVyinf9f/UbvFePzg75j1RG6tVo?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Q4aSOZ+XbYAjiYBJvtxrirDBiQXW6L7ta5cu6+ZSI43R6jL69dikK44VxH4xH31pJ74IIbUCX4N91cZb5nyQPSZtPiNIIPp9jLC27ehVKK11Hry4EKXq0Tw1glnpQrRx+2+6chnrm8bbOBCn6IfCUGkknpyZeljNrh5MbU9sVaDANqxktmUoYY982SnST2Wr9LdTSLrWYQ+g6jxL2vg9wJXgQvAFeA4puZJF1d2UMzgiKcNkoTUEIYwIti3i3NuzKdi8zq6uyZIz5G6l9hwn2WFd7oHPx58LhoObWsOdXaaDAktk5C4Qc83M7u09aIM3rLTfH1VWBfG6GBIiDHMv+BOLJMfKt8Enj+KqM5JlS0c0VDG7x1WxY8iQW1b1iq1XgPJLQbSdraQqPaylb0UtUzh7Cn/yiV/DRfQtB1RHFTHCyuUO61G8g+NICIjAbTFmVhMKMdPrdVgBVGFNT+XofAhLymSfhmVc4OBmgqwxky5ZICq8t6Wz8+8R/1ElooWJxCNLSMAvC+b15TLxTAtw/T+j/v66/A50T9cK0USGuHWkoDSb6r9YcqzumpMpYtoYBJvpGHQ+wGeS6e0Wtism2V+1M0oZ4GZEsYEu3favWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0716c09-4eee-45ce-334f-08ddf5fe5256
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:40.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAYdNLOlzogQITsx8RuF5GwZZT/hPl+0OugOyQr/KpaVUI8sCQQIPV/EKQMPEUAs63tPTjQde4UFoQI0+G7VL6NMOzkiOq8reCyc35n9wgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170150
X-Proofpoint-ORIG-GUID: spQKExu2GpdOFS03vw98aI-xenEBs8Zy
X-Proofpoint-GUID: spQKExu2GpdOFS03vw98aI-xenEBs8Zy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9xb+cJT0Frpj
 AIWRRSKYksUeJc2WRG7gBniHRTih/maMqXVHXIpbCDNdPz3aDZOVmJurLG/YrjCMQYt1k+9rr4a
 APT6FMjHmvvP9D4deIY5ubQJ/wgSwTBDRJAOA3wHoIsOhfBHSukBTtiQXvqsj3fYkeURDXGWgoU
 l2vD8z0T861lRoBu8nvv7HjRAmIEW0R+0Fx7FcK7Yp/5zOvhYHV0UkuKxsz3wOJvWTqJppvApMv
 fkXqN65EHSRRmpNI9v93jx9D3eNWhwmaVsKna7Gw452D5Pk2OG+qZ/21Ghxf7o/go1OAaUDaoFe
 L0drBsmiUoHsrHyvv5dJg44jwcw1eHu2fFCdB/BSleVOGZrp3Rh0nRPoMmH5BKJKIHWZ+6w6IP1
 Ayaa/6f22hhRTNFmDdr2GcPkY4EzTA==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cad2c1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0BMyZFS9aL5pxuX05u0A:9 cc=ntf
 awl=host:12084

Define clear_user_highpages() which clears pages sequentially using
the single page variant.

With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
primitive clear_user_pages().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/highmem.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6234f316468c..ed609987e24d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -207,6 +207,24 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 }
 #endif
 
+#ifndef clear_user_highpages
+static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
+					unsigned int npages)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
+		void *base = page_address(page);
+		clear_user_pages(base, vaddr, page, npages);
+		return;
+	}
+
+	do {
+		clear_user_highpage(page, vaddr);
+		vaddr += PAGE_SIZE;
+		page++;
+	} while (--npages);
+}
+#endif
+
 #ifndef vma_alloc_zeroed_movable_folio
 /**
  * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
-- 
2.43.5


