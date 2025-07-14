Return-Path: <linux-kernel+bounces-730023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2FB03F49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E298E16C137
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75073252900;
	Mon, 14 Jul 2025 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qYnbynAb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xTgrqAlp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01E2505A9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498514; cv=fail; b=nYM3XKatgxPB0TSzzHMHlrcHArbty5nnm/fJP42jhcCEU7akJKJ3TSL5bwzcliwFjsYW5iMTqYfQnexiXTI2BQ8rEamtgwpBZmwCVuar1kuylvG8jt95+DqIcEHSbdB+RAfS5nTWNG2t6IWSGWBAOGqb/kMlBPfnGm1WOmL6flg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498514; c=relaxed/simple;
	bh=41tIuLV/rIGeGzHR3orRH9d9PxB6IODO0e+/YT3gYUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcPPYJTXgfS86ggn+vJuQH81B8yyfh0d+tftDFT629vQyukliLLykXX/JpKRtMlWcOP/uc1W2Tu2zF/IPmpzb/zRf+Ql8Pu9y3hq8vngjQ1tMtlmGhyaqCfvm5Nt7qC7gCkeaiwHdKhRr+0D+0SAA/yEbLFBNup5ERotmgLe6fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qYnbynAb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xTgrqAlp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5kM031168;
	Mon, 14 Jul 2025 13:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GlyVoBNu36JoF3KVmfQ/OZ3grx0Su4GtfrqkL9c95bk=; b=
	qYnbynAbvJUC7dsOgUfgF79qtxxq5jdXR2d07W4JqXBSEsdInVEX/sbjnLJHHZWL
	OxBrr0NKHNrjr+hi8uGjOpXz7NJuoaYs6br4w1Titn1BY0e2CJYVTSR/LY1RN0Eu
	7B/H0kYAGZ4TRtAScYss6aVMfbnw1CN5t8+srOwtHJxDAhyD5wStlD7cK0tqw2Xx
	Z8oqs7KRESUjfW2tuwaWs141J1kqAd5QCa0RpAJvbOe9iwOTdacRiacShZOvHwAs
	mxERZSVMVQkFo2XkGehC+UqCfrF02Zp35+hdgROwt8PxnRUawDcEQDkjOJ++lZPI
	XG7AjspVvNi3nBFtmzu1oA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v27e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EBRjG3039597;
	Mon, 14 Jul 2025 13:08:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58hx75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCCTwaaHlRK49Bih/tgndlcutKtbiSDxWsbUYAx9V5oBmYZ2Sb3LngJnU8yW9Cn1oh3SjiFXxmkMrzf24sKySVWuj5fcLg1nbm28r81tIPBisNfix8I9QRWbqTVB2dlKkk00Iewr/3eJD2sTrT7wsAes6UIL23YsXYvDD83Qrnac9DaoM2m5ZKyVF25FdlU++9zfd+MQchbwxjsu+4/0tKREHYZM/9GjJ4bF9FwsPJtquxJk25eNyiGmu0m2Jkp59E3E734KwkvNqmTPDb1cWnoq+TM89t3RNR+YLGc8h2A+YCnTI9I9kegiWfKLXF3WTegNaav3/9Wq7v2Zuw5XMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlyVoBNu36JoF3KVmfQ/OZ3grx0Su4GtfrqkL9c95bk=;
 b=ijy3qzqviTrJrLEtOMrnxIUElxRFuiBfQZtdxxfUqJY/z2ldq0bQ6X7Gh5zcseD/Dw0IuM5oiqrCigWjIkUrCeJfb9QF7Mbxmfg6KVZnEvJhFx+8CgXGl75r0HtZEhj1xEPABqDRqL9N2zN0s83umj/Nkf8HCacP27RBZvN8GnolG9n+Fr/zXqj1+tlTjp0DOT801NnF8f4RPSeqI9UX3A7hvfyZfRbxJ0Q+5/hqDibAwTARejuTdhYsOCQ7UR1W3w+5LZRs++lLprTUvNQZ6orP9ukM8Mt2w3kJiqEsoM0WClzDB+JiKN8dKhr1bu7ThNxzmm/S+mB4KpsVfujcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlyVoBNu36JoF3KVmfQ/OZ3grx0Su4GtfrqkL9c95bk=;
 b=xTgrqAlpIMg0fTwbtyIr3DpxogmL61ojFiIGk2+VRAhH/uNt1Llaq9+rqZf3kfEbs3LNPHvCKWOKfpfDTkAUtcBa9wwtl/OEEc7sGVsoElNqV1CXig1D4xz770tm82QkLsHwOzCcejju9y+vEvaCRYXliPWeiUbPvC52nJCXC9k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF1F3678C2B.namprd10.prod.outlook.com (2603:10b6:518:1::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 13:08:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:08:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 3/5] mm/mseal: small cleanups
Date: Mon, 14 Jul 2025 14:00:38 +0100
Message-ID: <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0611.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF1F3678C2B:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b9602b-c087-4bf6-1800-08ddc2d77fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hgKmCwoiDWUsVOi88Ycq4SPQQVRMWbDO3ke1MqtI0N4IVdME0kGatSJWYtxQ?=
 =?us-ascii?Q?bGIT/gg9OJ/Cz8yG/x0xamqpOHTEsYm7jn4nyoeZn2ZURH7ebmSNEVABuPPA?=
 =?us-ascii?Q?IZdmgZ9WbNrYnwyUJCLWPDP2YrNwYfuDkYMP+kZewAYfnFZZ25+IiW0d3IS3?=
 =?us-ascii?Q?z9CY087YWh8MD03GhGbSj12Tzx4BmFnXQ4s6f5x4Yx59QyV/oG2upPd6h9kL?=
 =?us-ascii?Q?9jj0zy3KPbIMsNoGqXxTHckyAo6UixolvbKer5a4rwDGe181OUF+GwubhxiU?=
 =?us-ascii?Q?kvEowDFe/2icGuo8QFprP9R6F2Vx5NHP0vVVoVWVoFSCVEn9MF2Bv/GN/D3J?=
 =?us-ascii?Q?1emzKtvQWynjd2gHa6S0s+StWp4IjM+4c3paltVy1HsYlCTe8cY/LMOz9bqq?=
 =?us-ascii?Q?MAFMP0WA6fJgQSELeNX7MruExFPdk5p3LVC6bPJjVMG5DAPugQ2bTZ2/Udl9?=
 =?us-ascii?Q?clSQlNX3nlYipw4Q00to50619YiG3EzWTtrhvUnTN7zysHC4uEB1R0f0ZLjS?=
 =?us-ascii?Q?K7rOAl6NQRkdzO05wZQOuYH821PJb+xERX0myda9rmI/cKsX/rtykOawqN7d?=
 =?us-ascii?Q?sNQpL6J13gE1hvpPUALplvGxPFLL7KW72NCnX4JEb1CF+x9VXOVMRIOG7wRw?=
 =?us-ascii?Q?jB5iba5d5iJzbME8ctKmfX0x39TfWaadTCXjD1E+QGeguUxmOp1tKEQTqr5Z?=
 =?us-ascii?Q?820Xi2CSbFkHPE/bPLDopbfUxtpFS2Ul2stCN+heN3sP3BGLVEa0PLPvHkrB?=
 =?us-ascii?Q?/GcO/8SVbsSlasPe1/4MiUwV404KbKh6XorVPHh4qbEnoZPBDIbLb7DIS7fm?=
 =?us-ascii?Q?bC3eL7FnXZQyOAQhubsLTtMfvE8kpgbBwE+DnAT5SzDFO9FKgqRIEclGnOAE?=
 =?us-ascii?Q?/IwA21M2XcZM4mxU+PXNb1aLFIxdZu4T5/Tr0o9uo8v+DItUXjhZgRI1vFWu?=
 =?us-ascii?Q?W0sZ9N/4qn0xMIcRGs+zYzTwaLIh1peOenOMpXW3VHMnI4J+nU/jtDIut69y?=
 =?us-ascii?Q?SsxV1ykqkgNGSg6MDJHJPwiebOukIdwYLB8l+cgueusrEnz4v87pElBDBgmy?=
 =?us-ascii?Q?khsIr3rDMhPNpNUpmWp3Lc4Z/S0Az5NQMiObGViQBOO2FiNCFt+Nb3eABa6G?=
 =?us-ascii?Q?kMrmMhQlFRHMVhIUBFt92hCfCGWFhfP5Cml32X7WsjAdpWi4qGpWHsN2tjrB?=
 =?us-ascii?Q?Ddhd2ADbJEgWw7odU26b4O1Sf0+lW8svzLC5XxLGel6GK4ooSPrL94/m9BvX?=
 =?us-ascii?Q?X+vcSXG5iMiVQ/GoP615Gh1nmW18M5xFYd05mvQZ40cGtEIa9hONfUD7U96f?=
 =?us-ascii?Q?Bbqj8bUptpC3rTCa70gBXB1PjS3loGh2NjI/t2HdQ8xDy8tKx2zfL6jAymwP?=
 =?us-ascii?Q?RJVFCPS5NIax8XpSfcPuDhYHBMxJQMbaKv2GULIJa9O1WYxXDIXcLRnMRY2v?=
 =?us-ascii?Q?rU++VPuXt90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogD4qBnViXRYT4BjTkELq9ZWij9ihgPyqij37K+O+WIpZp0XX27NNG/7Dwla?=
 =?us-ascii?Q?vQL6HJsIBKpjTFvqEilvouguVBDl2y4YPeIR8FWSkSraucAsNB7sdYh44/Ko?=
 =?us-ascii?Q?dusqUjuMcCko/ID+FdC4ZmYbcfHpafeJlcJ0eAnJETUSMxbcXOHPjocPhWY2?=
 =?us-ascii?Q?zOiYUzmdPLkvYkikIRfXHc2bAje+tml3gyncGhkn74GEdv9qUzfDdiXMKoV6?=
 =?us-ascii?Q?if/VCBbv40Es+cX2E03yAti1UiOw0iFbP2ewpaPTQxn7/g4opJ18nCP3VRV+?=
 =?us-ascii?Q?pU4+RrndvKTteXzMBJSBC9gJ8B7PUQxIkQhYft9bDiZy3FrP1D40Z9XaYPFf?=
 =?us-ascii?Q?+hGMsQTOF0RSl159ZlXFTabfwn2esCISMVgGFAhY78rMy5+X6Y79zzM/n1Zu?=
 =?us-ascii?Q?f0WtyHBUgnumgQpH9F/tqnuiG2zgf9pxftpdYNp2KLNJAzV7NMXREAnv+4i9?=
 =?us-ascii?Q?Cg4OmHR8w8TExpxjsm6pErvEEQURlRGPqywVKr7y2EyxKlh1lvZjjBdGwisS?=
 =?us-ascii?Q?PlFnLJzwxuHwmZx/bjhbTr4j6EYACoUZoguKIuTnR8veCelwZD9k3b9BvD8X?=
 =?us-ascii?Q?kTx3/qToMm9pBn8jKjOFmM4Aiy+SEfK3PRAmYay+b9XIKyl+bi0WtLiuDmpx?=
 =?us-ascii?Q?vzCB5old7oWObAM3+LwDSBwGx3huAdjIzQq1e5EdbQjTgFfrzMnMztpQ5blZ?=
 =?us-ascii?Q?8UazxQIRteL1nOyIrJ8F9yL3+wPXYxZiMac4H2CHbXq5sLfC5FvwGo3DEKe9?=
 =?us-ascii?Q?vqXQdMzCTP3kxuJ6AHqiF446T6LMk6ogUSEuvY+2OHTaNFXSdKb58fS9eKVP?=
 =?us-ascii?Q?yjj5T3VLrulv/Qy4tokk1Gl3hLQpWUVHVuO/JYiL7k8iBhjvP6W4WtEvAqgB?=
 =?us-ascii?Q?MQdYfQdqugrjYB39MyxoaK0RS+BNh0NqSGesh751YQ/2LfNy5DrXcV2vy4av?=
 =?us-ascii?Q?nYXZEIRp1GErBKuSDkTBHUSWzcKnYn4ltOD9tQzVgqDEBX3qIX6lwo9qEfIA?=
 =?us-ascii?Q?ukx7VZFsnxSnLOE4wKiJn77xmqYmxkx5hrPC5RrI8mkGZo92qInEkXwVqF9y?=
 =?us-ascii?Q?8yL8wSjYF3o6TbP5kpN9gig/TLdkbZgQoMyzJo8bArcs5xwUxYsJXwHQ29eP?=
 =?us-ascii?Q?8Lwk/TZEYFoeEmpG5uHUoWAiE22PhOAlOEuyF5Xwy6VgVoyxwr8nMK3Dzltk?=
 =?us-ascii?Q?BnDY3Gk5wF55S7McdC17nlBX3zZ9oywv5WLCwVDkt1swaSQcl1jDnpNjSKRJ?=
 =?us-ascii?Q?kQMv8XptA57moczyDXWaTno2yAvko4l3KYcUi262QUOoU8bByO5gl2wgdW97?=
 =?us-ascii?Q?QvMmhAms24+sdLtnz+FPTmJhaEMICM2uafjKk1QAz+omVCzZeSRhI1va6o1u?=
 =?us-ascii?Q?7Ih0dyGPDoUiN81jb4QBAteliDCZRh4zCkJqcFW0PZl44snxSaJ1Ns2Pzpcx?=
 =?us-ascii?Q?B5TKjS0ximlyz6e3g8XHipXiCPcmfDqKWuZF8pzJ7QJVbgHAqtwQbHF+gQoY?=
 =?us-ascii?Q?m7+WNCR9R5rYu2D4rkb0fPmoAkVGl4LecgW0fqKCImk/eFMLUMYqnclO8kc4?=
 =?us-ascii?Q?27tE4i7WRJl/xSirbDZeVBZr/1h/2npmJLXp8yk0uBKmKPXwTm8EYB7j2hzg?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fhi7dX02J1n6qC100kPrePWikgIKyOySiFXlXPCbOIqBBt6AmaPgEa3uzjZi2PesvqE10JcjNZS+u6nHzzKowi9CHJ5+pUOkL2oUbtEfeg9gzeQIgg4Sm/UAiyr1wAMgZK90rK22oFTnshkMf9YXr7RJzK3nCk8XWyZGDjmWsf1aad4mA0Qxi4gyfRpqWILcTh0VhOJnfklmgSIA2tLvGff0D1fFeFxSqDzcm+8OdCzgLu0nbYAWDXZanNuqVO8/zqc+f0K8lR5kbQIS7vaQPFEW1Lfrr9SK2q5YSj+0+9YyOtOqiv7RJIs9dyIJ5Jj+6WY97PciP3sLivAdfB3rEPwSvFHU8OoC4+VsAUZzkTG6J31QEyE5aJmMPs+croSI8m1Q32eODLidj0kxgVtpE3D5F8NbSlnU1hfU/VVtoFcJXJc3D4ZEcipj5p9R+g9/IsGbJdpZGuRlTxr7sGQ92K3bFYkIDHe+ea6r7TLJGPgQ8aP7zG/byIvObdcphUFwSNyARHlubZHcmHec23SbBiLOOSEE1RuFW2MCzvL34zg7N95AVgTr6dtqVhEexNkPogvphu/dYFZiQgcAza6q5c8E/s4qDlmFCyTu785ejpU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b9602b-c087-4bf6-1800-08ddc2d77fab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:08:17.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ij79LgP74c2kackEXpl4pDig5zTe2zz2VwSlOpJQu8TTB9vEk4tGkOxe6csN5p+aiuQs6wqrkk1j3nTT+xGywCcwWL+kjbbuL4Ljr5AK6lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140077
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68750144 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Qz1AkeZg3oEYCUx6DssA:9 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: -TuCF92Au8yemfIICE3E8xgcdBoFZWbL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3NyBTYWx0ZWRfX8FaCWI7VxfyB kxKRBw5nojwRmU2hJV2Pcvnf6eTJ3m9LNLpKFKdgEM02iH5vr/9wKOOq2XfuZocxLm3I99giOpU Mr+Gvk9ycGNNRGLZIEQ7MPzO9aScOVcPfYJAokUh8G275Am2R5zAvy6ZRkkgxAeq7Xnf62dgOAY
 iniHwmn8OXispEcXjl57VYoa3/yKbr/JHZaLGPrg7X5IAIHK4CoAN8gNWhuKnpLwc+9VBH8lcct 6idhJEhGmrFqCQywyp9TxAuSML+R+4md8guPVYZ/cRM8CEp1PaBEjngcduEDlVSYGhktV6hKbI3 FYqfxzgCnd/gCLMyuWjNRUPXykpwre0CTHBcStU45uJXqcDGVnMPHsDHUWcQkSdm+uFwpjITXzF
 MjS+Vfm/JZ3OBUAjP0kBsTyeSlY+WBubUSIZDv/2RACDQ3vkc9X0PSzwrHQ/l/dNHZQ+I3Ur
X-Proofpoint-GUID: -TuCF92Au8yemfIICE3E8xgcdBoFZWbL

Drop the wholly unnecessary set_vma_sealed() and vma_is_sealed() helpers
which are used only once, and place VMA_ITERATOR() declarations in the
correct place.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mseal.c |  9 +--------
 mm/vma.h   | 16 ++--------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 1308e88ab184..adbcc65e9660 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -15,11 +15,6 @@
 #include <linux/sched.h>
 #include "internal.h"

-static inline void set_vma_sealed(struct vm_area_struct *vma)
-{
-	vm_flags_set(vma, VM_SEALED);
-}
-
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, vm_flags_t newflags)
@@ -36,7 +31,7 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}

-	set_vma_sealed(vma);
+	vm_flags_set(vma, VM_SEALED);
 out:
 	*prev = vma;
 	return ret;
@@ -53,7 +48,6 @@ static int check_mm_seal(unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma;
 	unsigned long nstart = start;
-
 	VMA_ITERATOR(vmi, current->mm, start);

 	/* going through each vma to check. */
@@ -78,7 +72,6 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 {
 	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
-
 	VMA_ITERATOR(vmi, current->mm, start);

 	vma = vma_iter_load(&vmi);
diff --git a/mm/vma.h b/mm/vma.h
index 6515045ba342..d17f560cf53d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -560,31 +560,19 @@ struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
 }

 #ifdef CONFIG_64BIT
-
-static inline bool vma_is_sealed(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & VM_SEALED);
-}
-
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
+/* Check if a vma is sealed for modification. */
 static inline bool can_modify_vma(struct vm_area_struct *vma)
 {
-	if (unlikely(vma_is_sealed(vma)))
+	if (unlikely(vma->vm_flags & VM_SEALED))
 		return false;

 	return true;
 }
-
 #else
-
 static inline bool can_modify_vma(struct vm_area_struct *vma)
 {
 	return true;
 }
-
 #endif

 #if defined(CONFIG_STACK_GROWSUP)
--
2.50.1

