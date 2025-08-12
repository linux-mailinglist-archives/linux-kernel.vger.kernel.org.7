Return-Path: <linux-kernel+bounces-765370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7CB22FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E78B1AA145B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CF2FDC36;
	Tue, 12 Aug 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EaSGh8Ya";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ovzd6QCR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D82F7477;
	Tue, 12 Aug 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020537; cv=fail; b=TBcv0J8drnaWSNZQcEp28verGfn9zbtD4UmRUo/BoXrN1lmH6Mt+cQrChZJbiTCL6virWLJZ1KjJmNZHemIhXnrTGO277H0NCC6u1aDLAawEl7Qyxv5hV9OfzM0FOeaCnPrfKjVatBd29Twe7qP2PieyfIUVNdW78MqIjq45rks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020537; c=relaxed/simple;
	bh=fuiwXHPDOZYCR6/KYpmwh0iBPjec/tIJoiVEchPqQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKDN40i4DkiRr71dwYi9Et2nQmjyit/44kTuBwD8nzTvQVVq76oodcspyepR/fLcl3b3058uoaHa8ia/HreJkoYFgInseZpEEHYD9s58YlP7TPQIzNYEM5bSy/O7hDZHW8KwjPoZz5DHnDfKsjFqwWVu0t4ZWFQYIaJYUN3rPyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EaSGh8Ya; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ovzd6QCR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC0R7021862;
	Tue, 12 Aug 2025 17:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mY6iBFiDs8HkxevwUm
	jiZfXDR8WSqNEsCN2bnQ7FW5k=; b=EaSGh8YamP6eypHX1PvndQtp7Q9lBozekC
	ly4T17gcpBdVMoUcoNogmMiv1sWCwqsUd8/5H3c+n/NW6+0qmyynZTI505+KlZiH
	uHGecLRqknCqpXmJcuwVRIMdMArUgdI0gPx1NiJoFxzFSU8EiyiamenVt+rXZ2N3
	zo/ZwYhy7QWlyIrGY8R1u6iooS0bVdCOtElORSqsil4EHnr/MptdRroRQ/ofRRJV
	44q38j2hNLxiXARYENrZRys2KJyLgDKvdmMY9w1GiPzChyiTEOhwUSB0WC0BhYTB
	rkPJ+FZyGhkGgaQNZWgQOBheJnv1FX0nKieYPsiUDBxn0DOJmj1A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4d9dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:41:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGUhPu006372;
	Tue, 12 Aug 2025 17:41:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa305n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKgFw6auZf+h1doEa6D3sidnRer1XcMiGIbMDGJ/3vm8GC5sNRrwPwDUE2maP8IO6pbZzPswst8V/tvDtA8045T5xO0ApFpYFtsjLss3Dq8b+4C9HRPAx+tmLtm8MsMsH38pyLF692yJCmbxhvu5kKOBDZqF2jwib0XVwMiJs+LBn7WZ4jdt0cG0Nk9KvQW0A/xItN1TRmJl/tg/GyojSnn4sedQDjXnIygISFPMjpDET0EVIgv76Ktf6KqLHptLOdAFtznW0+35fqvsJXvf9i1NtBafpjN+3LH7v8m4cKeBciVdlp8fUiyAbGMzPDg57YsKOfxS/PPN8j4k2Ticrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY6iBFiDs8HkxevwUmjiZfXDR8WSqNEsCN2bnQ7FW5k=;
 b=oTLrhYM0HjF2AzIq08Ud84auMs0nzVCtsoElNlTtBiHunzw+q9ZXQ9tzKI82Q5Npr26kB/5WZoVJkVcOnEpWO7tYn9aCYeiMNQ5r5KYG3AdghQnLY3zIAcZPyx17VO3j61HGQT6MSJVzNPcfo/oJpCT5UScb22ysjRQ1/6v2rm7jFt93ESKRT99u/hUrItSRDUVjUEE/UTF1OjeqqVEpcwInWgg+kvHyAcXYdXK7pkxmIdygA4QaO7/7Ay4pATmnqiKknE9Sc4RCkjTBt1Pwc+R6jkTOCqhIAwap2/cF0jwP7KdRwmHQWd2UofipsRHQH0PjuBCO94GhRqIERJi1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY6iBFiDs8HkxevwUmjiZfXDR8WSqNEsCN2bnQ7FW5k=;
 b=Ovzd6QCRn3DhlHgnzPgWZe+qgZ7TawFobfATIDJ52CFF9bdmx/2iY0SP3axftoV+SQJ5+BbdbPW4ffBalksDnfpTaUMUm6WV8RBThbwOpCOQUvraGe76/EJpyGb/gWPMgWihNtZmcBJSyzHTxvndRJWj7kux80q8t3fpiPnJmxE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 17:41:47 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:41:47 +0000
Date: Tue, 12 Aug 2025 13:41:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tamir Duberstein <tamird@gmail.com>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Take ARCH_KMALLOC_MINALIGN into account for
 build-time XArray check
Message-ID: <d3vt33v5jkhv7xp2yvl65sc2n6uiytrojgyj63voz7oilxxvr2@c6niknhbfiep>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0496.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aae0423-3c98-496c-e144-08ddd9c782f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rMsTgW1Pn2LNUYtzurjTlxU50qMRcRohsuRwZLzTueMsrwjg4tsGLjRnpqvC?=
 =?us-ascii?Q?nyJTzOc5m0ItfhhRcM7FjXNYKEOWJH+W8e+HaoDFJWdxL4D+BCWuvs9Sya64?=
 =?us-ascii?Q?ZAQZDu9QJ+h06eFba1+8InAbR1Hdkw4ZxbMTAy67JxJXzH3AOIPzFloW3Knj?=
 =?us-ascii?Q?TAfKv4vKHOx3VSqkKKfOYqAJEjyMIraUwdg4sKjWZbGgaNCEV8W6sTPITpTE?=
 =?us-ascii?Q?5MLBPa7dxvfmgn511Vivvfjw6RTVwPbo2uoC09unJG7rRjTbfvENg3gb5A0x?=
 =?us-ascii?Q?f8VGjxL8lr4kP4vUK3ZGdZz55MI8+wERmWTJFC4patVDOyifDa1HffYDyiNN?=
 =?us-ascii?Q?/7IrJ8raDYqmE9LOxwfmHyhO53nN/1Wy/55Y7mI3X9DAmzmvq6c8FCwwJ32s?=
 =?us-ascii?Q?agyq18FUD5kpmD/A/8gwsReYm79RsRXLUhW3FSmkNdYJu+wBLC0PwIDAbXac?=
 =?us-ascii?Q?xOGEoBHdPwly/LiLPClcS6tQ/8T61LBjs0+FpKbOarWUir9UY7c7cNYNAB89?=
 =?us-ascii?Q?OQHQOutw8Ki1MIBzwlJtPh1lnGZYRwHkJZuydu/CsDTmMtLy+XPC4OYJql/+?=
 =?us-ascii?Q?obw8xCz2BX5yFeSkUrmyLaKkefRuaXX4L8xo12Ch2YmtQeSMHo4VD42HXtep?=
 =?us-ascii?Q?mtn+OcF4Z7gwP3Vt/vWrpTQUYttHw5i6cqG56DbwK9hLB+Z2PAsQ9mxFLfPU?=
 =?us-ascii?Q?Gq/UvcGySRgWPu2naZBPLVcnb/yIL5qu9uVSBDDjAM2P1hDw8HR6kud5s1a9?=
 =?us-ascii?Q?DeHMSp2gxlGg8USIOujZe/HN2y2oNcnePr+be9zccFSB3COPeVKiz8TXV0iW?=
 =?us-ascii?Q?IElcpy0fTJ3u+VmdjY6aH67jRK8MiagaXxtsrjxL35L+Zktk0imYiwvnabMG?=
 =?us-ascii?Q?8awc42OZSsjH6egdZB22I7SHpvqVH5dcxk6gvJvRjcjd40xNFheKUiy9k+PA?=
 =?us-ascii?Q?dTmgYOE2tzHs9Z9pqnjjEpfaTtTAR9e4NZJAWbGurFz01LKvj1zfLL2HmZX1?=
 =?us-ascii?Q?PN6HOptXhABKCwW9dXfCRspZoA2BGfCp8cWYEI9xg4oldPP/7zYPUYvJTFSH?=
 =?us-ascii?Q?clIFZQgMKQL9ztJ4xqRJ00QrDuYuc9nFGsare8Orbx7OIpGMaiWoSXAeNhXJ?=
 =?us-ascii?Q?K43xVBPT8Hx5bfKa2UwJcCxfGS4JyflBXG8bK/9QNK1Jsbaqp3A/XHZeaPze?=
 =?us-ascii?Q?oynihVYXDiMLUZlBcJWCIyCc2TNlSPnozRTTIpsZjXWWTWoxFoLLl0IJHoU8?=
 =?us-ascii?Q?Ns+KIuJDSoSgmf6FYhSXIOi/5H4BYjbl1L4nHmnrzbRfkBKHFpE3PHArDuPp?=
 =?us-ascii?Q?6dG1dtAqygxvJAS4a5DWfSAz5sEvRFS/7ltbDjQBSae7MJ3MvTG9jcC4giyn?=
 =?us-ascii?Q?BcMwnrTtMPnWO8HsRc/w/9uV4U+0yp7H1+UXdpLQSAUjUhn5u9PwgujX2oNd?=
 =?us-ascii?Q?dZaIYHtO/tg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9fr2wzQxrJsA+4OnzNIkaXWqtpmM6avS71LRqfhmMGYpZc5Dq5qNav6O2/62?=
 =?us-ascii?Q?VL7FzcPXFcCX6GPXm/Pi1cGFu96wRlSJZxBnak6+GMIMn8MHK9XwdRPOWyCz?=
 =?us-ascii?Q?/lNCLS3nfu5BFuF31TnRVWlbDrfhiBbxt5dBdH46ayFafJwif1UB5GQs5P4b?=
 =?us-ascii?Q?WweXb+qxPAe5u7Vr7nTnJNBPZKXVw+OOUh8/rXgU2yly5dVC/g6TaZLzXam4?=
 =?us-ascii?Q?V9Q95AD+wHTRxpCLYdTMaxBfC8DVQH7B1lctEnaZR5tDsTU3X//SSgOc0aKR?=
 =?us-ascii?Q?4hlf3V1JE4ccj8Lq+sYZuRZCgKSIepjTNu3c3eF2NS0fFOVbZUiXuk46D1JE?=
 =?us-ascii?Q?yQvg6EVAfoK0xsYV5dx5+s3Kt1/6OKFkAODWJw2KYK9hCamEm8GlPNJr3M8D?=
 =?us-ascii?Q?zYzrW7/8PxJmT8fG9h41pgBUY8Y9M3gU3nVhCfnkUV0gs5isTlcd0u6efxu3?=
 =?us-ascii?Q?iuPRqkmw77z2c2n/KCLSgTS4fNrxywCfBOZmaPv+/WE9iHXIjxaMvUe/C3N2?=
 =?us-ascii?Q?ceaUoBIZRTy74GqNvPt4/s4gXWvWiwC2e3TQOqM+QR3wJBCw4AoBcwFyZFfH?=
 =?us-ascii?Q?40rRlHu77/pUan9diLZgJ6brZs3jV4V7tgUPxpvIme8MZPhMI21JlWmpqG9i?=
 =?us-ascii?Q?8vxuP0rJ8B1ueRrRn7RWo8M4kwtN13Xx7X1A0HC9BRqEJJkPc2hyjQJcjp8L?=
 =?us-ascii?Q?ZC13434y0rB9PKOLrMPWOtHYSH4eUjO0D7FMbbfY26fEME/Zkq0gONO8Av5t?=
 =?us-ascii?Q?tSw7O7cnFUGcNXplpXg2Iy11mXVoRevKiaRLe7fz2jQ/+O42OZ2DZRn+HF54?=
 =?us-ascii?Q?ThRXDIRlLR2q44f4G9Vi+byeb6U+pEhr4t3AQwQMG8e+9KibvGYsmdja4r9L?=
 =?us-ascii?Q?BggeJ/bMN3EIngz9v6z9fiUPpPCfr1ON/hsorYBw8tH/7VvauV7wfUIJ6tv3?=
 =?us-ascii?Q?H3oN4IaSeI7i9ECuM3sInyeKzLWz3SmLupq+h1pzhJm64QHx289PF4z+2R5a?=
 =?us-ascii?Q?+wXfZ2JOPYt6f4LD2ZKJIEzh1TdDnPsaxKh3PhkaFXiwjW3aUBS+RR6+b+Bj?=
 =?us-ascii?Q?BPZuf0ilEgA6pnE+7i0TPI7yoNTDMDSqb/AH+Pe6xXYzk9PF1d0/xj0hwrAE?=
 =?us-ascii?Q?WjRbwzkGaGiN7vkGdYzjGnffKtJrWO+I2LoEekG8csl6+8NvrCnI9bnrA2X0?=
 =?us-ascii?Q?QdUqSfff6ElaMiDsW3Jr3uC9Xlh7GWr03xnmITx/AfOTgaHMQPcd0tilFTdA?=
 =?us-ascii?Q?CpcdYPd3zOvICbzCG0ZpP3VVLoDtD0a64XSeP9mvoXfmgdAgE5YsqGMRFw3U?=
 =?us-ascii?Q?y93eqtBRsoit43eq0yOFAEYRKuVCqksaDQK5fJDFVRmMZI7NXioAeHOUgMrq?=
 =?us-ascii?Q?vc3sV7gRCJpBNDsAoiEd55jmh5h29kpdIx6pCDdJZU12l5JmutOFfNo6SS1j?=
 =?us-ascii?Q?syYinnUBlZhBLrTytPw8a7Yr6971C8pSWJwsFHy/7asR1t/bKimVwYrbQpSO?=
 =?us-ascii?Q?/PiqZhHfa/xPpObjygCpXzLIT/2Nb3mlZiQfIUoNibDpDpIQ+dCjsT3hT+Zb?=
 =?us-ascii?Q?EM5PG8ZQj6FGoUkhUSlJLn+Hvuldo2AZtYIOGFb0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zn5i2eQQ8JCDHtIm03YggINsLzBOePofRui5fkHEpLW9WVLHN4nT6lQ0rG6zcv0OgjPOXG0Tq1C86fqArPnNy3vkR+Hh/MaSguELvVtiXoBIFd/wAhXhxWrKZ1zCF1vYCs7vgZb3dz6Q5/DVFAINGqenj2xIJPTZ1+uc/61ACrtdbdcJLYzd+hh+YVPA9C68OPciUZ48+SOrv1UWqQvyNSsfdck4z2yzouwyirAOszctoE2Tsq3lBXF2UXTnldDcAvWHDcQ+03oaLZswbAwQRQ8O97phINpVdD5TggG9fRAMWapjx42zitcojdhSxytv4KZUdFHzw76QX8bU6lRUIWA1zBBOHZxWEWgxTcrIsBIdV60xwCgHLwocpmWWB/lYzlCQWJuaNybXa4OG2sK+dJLT7JehEZimq1HwG5SIgHIr/jzetdySsFHyyh/YOyHwIi6+5iD3gVdLTbn0kdHWp2NAhm2bAM0UZXtd+GHgAA3M0iWDhs9pOk8DfV4W82aXVJDmSv9ll73hixSqBgPSXzQpF/oBMiewcIdR9nlwi3t+SQphQWuq5PVuGOlRinTUOnnkztj7njUV6ig/qFs0FeU01+zlFjaHxiYV9RAFay0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aae0423-3c98-496c-e144-08ddd9c782f2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:47.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1sO6qUMHm+bcluPOXi85kMq4Mz3gmPXcBxBjnc3wB7bFtMOsFi+CXUCH9dGcTDtjPaR3f06YcLSB87NeP0nMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3MCBTYWx0ZWRfX59PMHubCYyFk
 XOJUfoE3kkJY822zVjGQCrazg7QOihZ50XFo3a3u9jl/oGMnwJHKUtciY1ZmMqFC/acI2zCzOth
 Xr8uTYhD2Z6dAh+N4S3UiybF4nbMPgkRafvew7atl29UTa8W0GTfUQpwCNVYw+dZuzCPx3CjBIQ
 gGUU+gHcllTyWZSXtqNmvcOrRMo70tSEa9AbI4mklHjirgsRQvt6eE4Cvli4Z0GifX8LqNd4h33
 BMCS+Ja62k6ANS+aVPvruYFj6bD0dVnZauLRgi7HyUU8/FTHo3rh3ybZMM0ORyLeXox6cv7PVj6
 0muz5RpaFZ1S6cbviUwxfVwaNwn5lDK0vPekAxgWUInHfhdDAw4ugtYNhzpPXUpjGyFZg2LoDVr
 NAtux7aUeC2kLzP/foGB20IpgAAOBWWI7V6ocxT77hOmrW2YJ5P0uFCCoU+twxt+dIt0lbuu
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689b7ce1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=Uw3LVuzM-qww5vyfl4YA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: IcB2Jo41bOv21zl_8IodtIJrQBYonMqQ
X-Proofpoint-ORIG-GUID: IcB2Jo41bOv21zl_8IodtIJrQBYonMqQ

* Alice Ryhl <aliceryhl@google.com> [250811 08:32]:
> The Rust bindings for XArray include a build-time check to ensure that
> you can only use the XArray with pointers that are 4-byte aligned.
> Because of that, there is currently a build failure if you attempt to
> create an XArray<KBox<T>> where T is a 1-byte or 2-byte aligned type.
> However, this error is incorrect as KBox<_> is guaranteed to be a
> pointer that comes from kmalloc, and kmalloc always produces pointers
> that are at least 4-byte aligned.
> 
> To fix this, we augment the compile-time logic that computes the
> alignment of KBox<_> to take the minimum alignment of its allocator into
> account.
> 
> Intended to land through alloc-next under the RUST [ALLOC] entry.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> Changes in v2:
> - Reword guarantee on `const MIN_ALIGN`.
> - Change formatting of if/else in kbox.rs.
> - Rebase on v6.17-rc1.
> - Link to v1: https://lore.kernel.org/r/20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com
> 
> ---
> Alice Ryhl (2):
>       rust: alloc: specify the minimum alignment of each allocator
>       rust: alloc: take the allocator into account for FOREIGN_ALIGN
> 
>  rust/kernel/alloc.rs           |  8 ++++++++
>  rust/kernel/alloc/allocator.rs |  8 ++++++++
>  rust/kernel/alloc/kbox.rs      | 13 +++++++++----
>  rust/kernel/sync/arc.rs        |  6 +++---
>  4 files changed, 28 insertions(+), 7 deletions(-)
> ---
> base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
> change-id: 20250715-align-min-allocator-b31aee53cbda
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

