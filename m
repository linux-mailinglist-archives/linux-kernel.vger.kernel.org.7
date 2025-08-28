Return-Path: <linux-kernel+bounces-789057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C145CB39073
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F834681461
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 01:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F341C32FF;
	Thu, 28 Aug 2025 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dw22TnRy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iHRSot37"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650619CC39
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343061; cv=fail; b=RpaStKiOxE/CtvcGMj5Y4lMDi7DFLHBSMK0wZyhwOrfjgL+6E7xdlRDkE/K294xloBPilnmd1JMoc/CQBeTf+HCTpesa0f6QvMqZ9af+JKk7E7H0OZy4NfnqmsnX3jIhMnNMh+lzenOzMGqyT9qi0mJd9LDdkSoTmwQM58J+gHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343061; c=relaxed/simple;
	bh=f+UFZ7U13jID6Z8Av/48+xxa5qRYS/8pKfT8MhAFBaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdZ1POM395nTX/a1NwuuZ8W/L9H4TSmRYHrgdFZr+LRsvleBM3AKrqHHTEq+2jPxHxrl5PT3W0TKSBUMoYAaNl/c8Va3lB/jCyeSOiyiZ7fxAPxOEtI3nlXLz+7AXh2bnC6TKUoEPLGXIgg6AiNJ4/rugNHaZu4ySbgAYaGfpaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dw22TnRy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iHRSot37; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLHZOJ005592;
	Thu, 28 Aug 2025 01:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Rx1XGhMn5IkhRNFkJx
	hgKIEGRKJU4eCPgHv6saa54Hs=; b=Dw22TnRyT13riS5Ea58DUHFfT3yFCWecWq
	2ic+jWQhbY/Zm26dwrpj+W6GalP6ZnlRxEUVrWst7VZdCxVLENlo/tQqvaUlef9W
	zLxilJ+RtiRs+fBGt4o/agPW6iSpYEDZNpmB5b1cSUbbvYnLjzyNXOXi9xOsqgmj
	CxTD8MDpCatqpydCgITZLzrAjrJW+F8STggy/XEBclFxYY3Gpmt9iKHHK550kb6x
	YL4QQadkY1AOHVuR9dOnhtHNt+9xp28VEcHv+DWtlfih+UVeU5azb6XuucioqCoE
	DUgVdhjzPYA1E9OjY66ihYu3+1GiS1a+O0nMjL9PKTgdhJ/b0LwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jaqjww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:04:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RMF4Xg019585;
	Thu, 28 Aug 2025 01:04:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bbvyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNfuMYOmWOWNs9rPWu2fZykbste8WZaZT5xetu5evvq9GRW2Ds5tJADwYPZ4yEEwj0y2jXHPAjUWhRZ0XTylwL1mFt2n4bbTWXKkzSN11HUnjB9jdu/+ZSa0Ad1y6y40k38ZjE0uxJI5alINHvMoMR9jReAF0G4p7PfWbVrcsM6sCLtx2SaIqWng0/Qly+0IHIbX1cCkCclUxitzoAKYkoIOwuBqnNHUSQAVIDRElUADQ3OKRxON0iIpKy3LIMc7GZvWN6CndBK2t5O48nc+aRVRylm2Z2rYH4+/783dysXHX6f0TKErA9aB6vSd5mZs3xT4RmOdbcul7FSA24yszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx1XGhMn5IkhRNFkJxhgKIEGRKJU4eCPgHv6saa54Hs=;
 b=mHyn9FyyqGfvVujnVHGEikFfprIUs4BT4mleDoalUTEZKtVc8ss8vS6cnwRF1EBwOKL0GM1x0gHf/jAflDkShuvrpjlSu9sAPOp9GyapF1LgdBgUbDzkQd05+x8k0hoXrxKtBaQQB11vmYw7Ggvubgqb9w62UO62753dhsPzEfDsgquFcig2Ov8XaHHKS9OGELY8w47KKspfmzM1qupr2e4kyyaXrEDcrJCKZ+g9Asqm+/VWquDnOBkogeOlnrqf21JYAMZk96Fo2y6DNzUkwabj8pts8kQnbXga1QUOhqwy9UxG6Y7tz4lwAsy5uBGstBD01oxebnt6CsEydMz0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx1XGhMn5IkhRNFkJxhgKIEGRKJU4eCPgHv6saa54Hs=;
 b=iHRSot37ULyWzVQKHxw+fYP3GJsCx/XhiOoSXyGTFGXr/YPM6ZDtPnl64clWztoehImHe0jV8yomUGSfuh12LibE1p8mC04HMU0OiCO9Seo/KnVQpe3gx4qVm9RiunCd9SInio/t5/VRtO/BVjZp3KqiuYwPVj7dAKtq4pGvlDU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB5972.namprd10.prod.outlook.com (2603:10b6:208:3ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 01:04:03 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 01:04:03 +0000
Date: Wed, 27 Aug 2025 21:04:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] tools: testing: Support EXTRA_CFLAGS in shared.mk
Message-ID: <azhumduljv6djbpoeehdab2rr6hvirmpvg5triiycqdwt7gjto@a3avbu4fv5gj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Brendan Jackman <jackmanb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-b4-vma-no-atomic-h-v1-3-5d3a94ae670f@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3441b1-fef1-4de3-6777-08dde5cec7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?llj2dVxhx/9PcM7A33ltcWDFZP5cFSf+j/NvOvDG1RL0xVIxapHLduIzI9Gp?=
 =?us-ascii?Q?Y/c1Uv9BCg6TXZrt88IyzKv7KKmN5UoacSste6NYLktDpjgWRZpR5BmE6uPQ?=
 =?us-ascii?Q?J7GQyovm6iGk22QnNrNp8B3C093hGSr96A8iRBFuxRauNEqop3dSyfcdPxBn?=
 =?us-ascii?Q?g4LAbPP7kD0JiQdk8a/1Tenao0ux7WI/GliJLZukHp6hm804YNygwjsgomHd?=
 =?us-ascii?Q?P89QTcgz9AGd1hPpZGC1eXGlBWOUCq1JSX9e6WuLZjiwk9LYjKCJYbtVDYGS?=
 =?us-ascii?Q?4oWHBgrRAH7bn7hkpSS7L0QehEdTUXeHHH7J+xyLr94+CcAr626FCcriqNS3?=
 =?us-ascii?Q?t6SgeIzcW0Ksj5DjTNPinVwD+PTUNHoRyamb9XwT7ZygnKzbkFEtfIr57k91?=
 =?us-ascii?Q?nJqxLbuuTCTNO4B60r+5w14qR1WTdWBLrSZmr9Os70iYWXoLp3KeoQDyUNRV?=
 =?us-ascii?Q?x4U6kv7nDIAFEZIxZjv3/6jbj6hOe8MoOLMkTC4M39kNgZTjDzoFARVfjvGv?=
 =?us-ascii?Q?8uNDl5reRjixlQX40RC0KTebSXCaRNIH/VsXt+xkT8P/RurzrDEbdD+EXBfW?=
 =?us-ascii?Q?zSt0kVKBjllPnEj77YvUCB4WbGkGkU0KCqew1+T6zI6Eg25zxWqQeqrHxbMB?=
 =?us-ascii?Q?MQgXJwQiIWgtbRgZcZAXSAu3XEC1hfCi6Mcpvl2w8HJLQmhCAIgxPtMGg2Zu?=
 =?us-ascii?Q?akzCnzOZNzUQLXwQmkiBu2b8xc5Mblvj5exRfFBgyvzHcqpkBhLbDFzkxew6?=
 =?us-ascii?Q?8D5Wspu24ywH47ySjGaBGc7lQtbD87oO0+L0MC7EUwZCk76Q1s6bKWFtpK6s?=
 =?us-ascii?Q?EGiOEjCDvgcmrTbRPSS0cY9Oqi60y5wvknc5v62PdDzaiRmTAKwrDMKMAteJ?=
 =?us-ascii?Q?xJcmCLOApzCTx4eM8i+f6m7Or7R295R7tRYvouJTaBv+t36C0iPyHQoMpkVZ?=
 =?us-ascii?Q?TKmr/PM080v5IArguHvjP+IOlntEo6F5g7Et8crU4vUSVtZ9HdZs0uelAL3a?=
 =?us-ascii?Q?31hEi4q8ZPP1NUlQsHW6LC99nlWRGRABIe16P76TiAL6ZGaONC1AOHiTcazN?=
 =?us-ascii?Q?TALNCi1xQUP/BkpV5DUtK2zVzGk3iEjNGgL8cMqEi6RV977+rh3nhUQghbB4?=
 =?us-ascii?Q?QdozlcdeHJE3GfdOTrqCfbiyRyABKFYRUOZM3FefJS3lpht4lA7I6rxt/PuA?=
 =?us-ascii?Q?WB1LuC8yAPgbePCuIDebCMiT+iaJyaSLHMWf/rx3Hx1bkTB9TGVLWArw9k/W?=
 =?us-ascii?Q?a+gg6k+1vjeCUtFm9eHoRUY3803/aBGRbAgMew4Hpw40+olN5c3z/pP0jvse?=
 =?us-ascii?Q?MvTbmKVuKhOF1cOa9KJT29KbK+Wha7V2yCE3xaXwUseDeqXJFAnc1q5oLL/8?=
 =?us-ascii?Q?CoJ/vEtPx83PMvBrPjbqehNtakGMEUK7syiQ8qwbehnaG2epNuy/CuAY2/YE?=
 =?us-ascii?Q?ftT1cGzd+Y4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkQHgb8Iu0aHSHp8BWeM2Ih7FBrZ5bFR/63gYB1C2yl8QiKUqUx1vhEbGJDE?=
 =?us-ascii?Q?xPk7WZstLT6b5mw+sWZ6yMvKyzSAYXw6YJwn/uiCbVAcpyrzeOpan7Kk1sDG?=
 =?us-ascii?Q?FhHRJnnSCWFVkh8QV1gklruuD4Sf9nLU20u/VOJc9AGOmHd2ojyEg8fv+fS5?=
 =?us-ascii?Q?x/nwga81tYPRsghNzvnVXZ67CjdygytFiK541G7ykpgBliwqXH0PCD4Imd4H?=
 =?us-ascii?Q?aqW0bpYOfYKxwugzgGU4DxWdaAaTxPFVztO9iPrqwhI2M+mpC89Cy22IEqk3?=
 =?us-ascii?Q?ghFqjcna/gdDbxLIJVP/enGKgcnBmqT+r3C8XhwUj4OKLV6P4ht8OABqpc88?=
 =?us-ascii?Q?FiwYfpGgfXmh+84ycebrkV4YaNNSNRggn78Y53YVGnmoIhxnQGkq4Yh8cYoT?=
 =?us-ascii?Q?SdyKvvU+F5P8ZE2P0SiUZUvaoXbm7vdYGdhAny+cEU7PL7gLCWS1MWduc518?=
 =?us-ascii?Q?dhPNB1467qV53HrHCN0IMLfiRr6u64wORQJbCccuO0XlK0YGwNNgD785svV7?=
 =?us-ascii?Q?/riRssecvLxH6UWqm9rCjkPQw58LEIDTdL4QLk63WCxONVdaoveee0EDCSok?=
 =?us-ascii?Q?RJIp/wZtVi5tvCyCiTdZmPQoiftRyM0eGOXZ3LJ9UZDoqfSzmEPuizO1jdgA?=
 =?us-ascii?Q?jNhnbJHe7ESouYUsF+PERAyPRdvsg9AVxvWELlyj8RqWX3gYrYsscRBm6b3t?=
 =?us-ascii?Q?P5/XcI3S5Ldkcl0T0bCI0KlhHWEyBex/6R1YfD+Blcg5fQjXRVHMZOrekZBi?=
 =?us-ascii?Q?ZCFPz0Jha4DuHMuNhIJ+QxUR9U+szfO9Gg07tj5N/Q2pX0kNQUPhUCdgqxgW?=
 =?us-ascii?Q?1h1g93WzFcIjko9zpvuIbqhI3Wg9Fh5zGm7jU+bnkdtbetjarTi4EWZ+AMfa?=
 =?us-ascii?Q?jsKY7jW27Jq0f3LKGTh+gSt0QnOYH5+zpYiSko7Ugk7u7cpFxDxEzbr78LQ8?=
 =?us-ascii?Q?6dU/dDY6rF5eHagtbO67y4avKP8vnzrVhe1pXEpMbZPLKM9jWp9fklPgTOE3?=
 =?us-ascii?Q?JlvlITI5DAmB1PuP96uoF8DhQWtZqbjy1xchJZ4KMpL4AHD5pSYlvTf0Rr24?=
 =?us-ascii?Q?RWizvMyYFm79KlXZhVPRZLXMzP8sqioqVhkP3/aBgFkqy1sNnnMlxypl2znG?=
 =?us-ascii?Q?6ubCRd1fnexo20YffYTiHpS3wAIrtBXwSZpUJIvCsgfYRVAPXCnyw1X3v0Ie?=
 =?us-ascii?Q?N+9lPAR6xsguUjm5VZCCKcI9dmq0vmvbG1K7F9x+H23Wzy/QRkM/agYeoEHs?=
 =?us-ascii?Q?o+t4Y8K4pY8YXhzp52C7b8Uim/zBXvfRY7xfWXYP9kS550mO8gBahKGo57qB?=
 =?us-ascii?Q?PGm5fcf1Ujf/GtlAtcFh+9XqtLYAU1/3JR85Aq9Kw+kqRV9/DOIeyFNmHzt5?=
 =?us-ascii?Q?bGvXRebK0VZiqFiLnAy5dN0+Dty43wnhbccr5AOd8zRs2NVnc2QB/B0vVTCy?=
 =?us-ascii?Q?hAFI8uE7KfyX0mewlO2Ss19E3SQ+mhqn0LJOB7L7WJe+MWcQB5y4RdJntCrO?=
 =?us-ascii?Q?1LTT2LaqBQjuMeEWS9I9QiL4AIPtQLbPu9UWyDJUTzzv2e33v3ns0hWJori4?=
 =?us-ascii?Q?0X6uc3YzhifIENxawAwvQ9Nb7jurOohpfGE+FtcuKOZWVUlNxIHMYH0zWZ9y?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xTthdZy4HmstvNhA1ZURqDtzXQjLH29/B6wQV3izu/Ivah6bZroe/2NH5Lp63XWMHqh7yOanZIbKxS9vaZ3sQuJafg9aTwmdqTqYYbOzdSonXBRsny6YWCqGSEJ1h17cxAn50eLCzom1fomxQ/BliZ1jN/tnZVp1dV7qCpqEuOV0v/hKjcYZcFdicPlwRo1qQg7QFITX4OxktphK0IW97rRx7DMf0OQmEVCGwQxRApq9OTPhX/sVHugxW8BGzf2iJirdl+10TkJphxbrAPRqkaXnxlPEQjpIdV53DdSFeRhlxAhctZqLSXTr7YEqEgaIipRtCZdsIMmNu3VW+xFEaKYSlyNF5XS5p4qSORcBnS7BV8F1L+9bsJHbjYGA/0crf26pO58GbAZw2CdRLE4ZDmZFjBE3ylsO2G3SJIbpUoUKsVIRcAk7CtPQm8nVxaVT/TaTV7VjdobumyJffH+zQ9zYpwCBpbnSjpvKtovuzY/HT6m32TEZuWCEJoi9aCPP+q8jR7kWKiLfxTO8H309SIsUCc/qVD2qrjPyejboWIrFnPO6denHmyEyZOpjdQB7Ztf03eQ3Ipgm3HDOI/VimvXm0o+/aq0cg2ka8WtczxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3441b1-fef1-4de3-6777-08dde5cec7a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 01:04:03.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WT8NRVn+abk6o1JLbABiSoRzt0SwHAuXwuOUQwqMHhjaqzoWD/fwdx0WvCD18sWKq3ArwITYV4cderhDpnnLTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX9lrcR7alsckj
 73zeG0tEj6asIF4PdeI4N3t5AIeaLhwx5P1MupJ+SowrrPVXEd5yq0KJQ8A0RKLtj+BRLBILZKB
 xWYHrlfb9IRt9I6HXuTpzY8jE1zjqz5pLwqI6fhKc26guTXMCzIuZyrWO5bnPECwIclP3b61RbA
 vuQacAMiRT/8Pt312jBkyjDm9H+KnChrpdBUdMyIVR82lfgCugaU+X34lW3kMMWP+ORl8NoVkZc
 aZMeYOjG5Q1EmcHxlyZQH3iHmi6Abxuj1cBqTrMUW7ZFNqsEJ0qHLsXHJXNhAX+/AIm1sDsuWFR
 n5phbO07vW3vnK3P+BsQXnL1xppwJxS1gnkhOrsFpfYos+B+cILhvNBRkbifmbxdFVSgowzIA0Y
 Du3vG3Rm
X-Proofpoint-GUID: HGYrM2qAwY-GCQeAWQxoU33ghYghu-U7
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68afab06 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=ohWG2JzJXNQoksziXxMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: HGYrM2qAwY-GCQeAWQxoU33ghYghu-U7

* Brendan Jackman <jackmanb@google.com> [250827 07:04]:
> This allows the user to set cflags when building tests that use this
> shared build infrastructure.
> 
> For example, it enables building with -Werror so that patch-check
> scripts will fail:
> 
> 	make -C tools/testing/vma -j EXTRA_CFLAGS=-Werror
> 

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/shared/shared.mk | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> index 937aaa7623320da1085a8e0f43f6a728ddd3ab1c..5bcdf26c8a9d51ab2cbd264f2f8a7445d7c036e3 100644
> --- a/tools/testing/shared/shared.mk
> +++ b/tools/testing/shared/shared.mk
> @@ -4,6 +4,7 @@ include ../../scripts/Makefile.arch
>  CFLAGS += -I../shared -I. -I../../include -I../../arch/$(SRCARCH)/include \
>  	  -I../../../lib -g -Og -Wall \
>  	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
> +CFLAGS += $(EXTRA_CFLAGS)
>  LDFLAGS += -fsanitize=address -fsanitize=undefined
>  LDLIBS += -lpthread -lurcu
>  LIBS := slab.o find_bit.o bitmap.o hweight.o vsprintf.o
> 
> -- 
> 2.50.1
> 

