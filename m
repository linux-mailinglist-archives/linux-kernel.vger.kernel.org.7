Return-Path: <linux-kernel+bounces-866570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264CAC0020A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C670D1A03291
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4402FD7A5;
	Thu, 23 Oct 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J6Xi1jOm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GmvgYyUn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294932FDC36
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210407; cv=fail; b=ctoIJuI0FPJ+nSLQMdAxnOs8JQxiSIMi9rGMzf82Pp3Ze0CEKHbK3Xtj17hJjuA6w8SECMgZctVF8HzkUNuPs1tRGfw0lc+uu+tOI/0pDUVYgQeEIUlFAOOFC91nA8UavmRLryu0n1jgHIwF7KnDIZCbo3/azfYqe4IkW7BHuxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210407; c=relaxed/simple;
	bh=5Vj1qM3BqzArZI/MHrTZ9cKLrggVP5ebJ15gmrcHe20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmPnul6wL6PlFivhOlLep64P5tj5i3JjImJ9aqYYx/hCtdueNI3ENa8OGIUWXNE4IyAPXWzSiF6RWGL1RJd1THrxUbkE+BiGFgh3mnjddOiCXFYuq7psMn/j2cIi6qKOJhrBiCx2Pv2OnrwQL/IRNQTiSUlvZT+23/s2hwn+Yqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J6Xi1jOm; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GmvgYyUn reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8neGC025473;
	Thu, 23 Oct 2025 09:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Yss5uDzf5nMYCr/p4jcRKSWkCnZk4obekIe8nZHiWiA=; b=
	J6Xi1jOmyC2bp9olIUo5xPBVK0WP6JO0Lkhu1DTUInbUy8Lcy9JDOLJMjEsgl8CN
	urr7q9pXKUu9KC5CNanVjd4NyQLCGbGRorqVXf2piKbDNo4Zp7p8whkA16uPMRmy
	xtIh49xkHpZv3Q3jvyH5OAyV4VEdQBE+8vBua78LUh2kUZ7xvKazmBOB+vSLSctV
	H46+vuPTgGYKj2yiuQpK2Kx0WYy7SSZrgzl0dtvLvoc4KWwLa7REKw7X4Cnao98n
	Ewx4Yt4CLAcAcP8xwhibtAmDqIw0d//oR4ETPJzrQ/X+is83McfMrJ+7IXbUJKWQ
	+E1+E7oUy2WVCeOzLdJdmA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw1bwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 09:06:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7wtdd012018;
	Thu, 23 Oct 2025 09:06:18 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bej7b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 09:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hhc/gT/bErSnLGjhfXpibnYD3crd/T+1Ktjqywc1ZFy0x5xwNt/gyasidoFLLKMyx93cHMAlnUbYZBMchTdd0XZ9tzn33SxYExbzg0HGfOZRilGKY2NwaP11gX/D8swO8IlTCe+/mWJ9zXNw2KyHUXCT1MfdRy0yvmiiWLrPofs7ZqKYUDFHbpB0xHzQbfuHehuMIWTJWokcATj2UGXSi7zrMeXTj2uyWYDKII49SwQStyCc1JFRQipX/0OLXpgSF/cq4fWamt0SaNDSATzuGIQAqViQQf7abyYrDLMKWTqnS6wTTQuEM+YC+6rCaoSFqYFHCK23A195vEi7qU5COA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrDyduiKFyJtoorQod6cLpMmGBkoWfCcMfyegeGfVvA=;
 b=aanY2Cp+zN/UKpudFRbU5JlxtFPnw5jYUTPP9hH2JTUmfbo5sBopTaDJ0NzkgWOaiJlDWNNrKxOnKlmC1q12NWyxRrr+hmj2QTCdgMu2HkP1caS+gC0ooHFeJOoYreODNJDz+K8aF32NGS2/2XilqTvyAD2sCa0BYo3o9xrKpojZUPfdw1dJ3EhCv/hf0WI8jF/PSY7Hy/NGNRuAcsP9EA4BWJlVKySu5MM92OB7VryUtFqyLfH9KsufEdWTMjLDQ9xkEU8ZGRg8x+73N4lgPnL1bLDifNHfdieDW1+qBoKb8wC6UZAMtNACSEXva0qGgPq82FfYC+gJ8ieNCS3taQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrDyduiKFyJtoorQod6cLpMmGBkoWfCcMfyegeGfVvA=;
 b=GmvgYyUn8hmW7TNh5+r3dZZw1DbClhSffaKvIH76TEOaCBdpHLU36QSxLIty58mXVhWe96ggtEZHQcDb1TD30YqlaqPMimmOMEZIitpfg8N84+BydDw4tr5AGqcU6IO39wFG+jPGSFBDIHETHCydoSIzqr2U/4varSI7LiY4XU4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:06:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 09:06:14 +0000
Date: Thu, 23 Oct 2025 18:06:05 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
Message-ID: <aPnv_W48rbPPmAOj@hyeyoo>
References: <20251023012117.890883-1-hao.ge@linux.dev>
 <aPmR6Fz8HxYk4rTF@hyeyoo>
 <b8c90552-7be6-45bb-b586-ee21f63499c8@linux.dev>
 <aPneQRY5ei-zvSGQ@hyeyoo>
 <cc961fad-f9bc-4c5a-a7f1-ea3842aefed3@linux.dev>
 <abc7bc71-c9a4-4a19-a47f-f6d6f40608fb@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abc7bc71-c9a4-4a19-a47f-f6d6f40608fb@linux.dev>
X-ClientProxiedBy: SEWP216CA0128.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9327f406-c350-411d-bdef-08de12136abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ekasSG+1SDoVlrC9RsLIOMIEnBorvhJ7Wm0gMSLNcP+S3UlC7aKUHx8JpJ?=
 =?iso-8859-1?Q?eE2Kd9xHBablANYq0nV+HnvBHBTnP/dnK8KMhcKI9qOXVjqnjv9ksWKAQF?=
 =?iso-8859-1?Q?mJ3DZO7dx8AxE2QbNAXpGYGlOUYKAzRXzbcyvg2PFjXw7ucNXoa5syg57g?=
 =?iso-8859-1?Q?E8BicnTmZgc4OB3laYvOXjhGVzOIJSqlGgsydA5AcXcDkGeriMo9awB18y?=
 =?iso-8859-1?Q?aIsaFYXOungNPLHOAXHDYHfA6DeCidFopHSSRED6ttMWJsnfBu6R8QWIP3?=
 =?iso-8859-1?Q?sQ8y8Gyxv/do5mm0S+OWkBKrlz4ux0K/qyezeT39LUKvIuu4vY+nJs4Kt6?=
 =?iso-8859-1?Q?5BsTYSby4kGnYClop5AUdVDu/kaOK6zkNLBYRyeTY15Qy3y4jXkGXj8ick?=
 =?iso-8859-1?Q?DC+PXaJ5ZZxdeUhqGm8QLnBOXUBVfVVsLaSxqhxYvLwZpsluqAC92+FgOQ?=
 =?iso-8859-1?Q?5TZWL+85dZlu0AwSnTU+5Jr1PSQdMwacEUanZhaVry+960f9uCo4K3eq+0?=
 =?iso-8859-1?Q?PPcd0LG9Jv86qdk0EjRUvw994cPOO3NC9l7JHOyDmuk4SP436sbW2Pimr+?=
 =?iso-8859-1?Q?d+0mv1y/v+KSyxMkdVOH0XS1EkG1BMq3yP4bRZKDbDyRa8m/ubYB681d2Z?=
 =?iso-8859-1?Q?gdFnAZHs/BVbp6yFVRu7dC2xrAFrupo8VTfGrEIlAdsvxC7lPDWTJ1DZsn?=
 =?iso-8859-1?Q?OJa4+y9aemUFSWOt5UpFK6GyVMH3qIAZ0wTBqGwG7Rsud3L2IrNO0j7qY1?=
 =?iso-8859-1?Q?2VaafavIk2lJ2mqQmrzgfwVobPgw2aCjXPVzc8cPgIpUpKnG+nOFtSaPIl?=
 =?iso-8859-1?Q?dF/6j3gDCly6o622QNqrun5sagk0nALf0hisPkZ0wZusoVLeCeC4CggpNc?=
 =?iso-8859-1?Q?lAC3cIIiGcxPMMsfFoJbGWtpoCJdhUHtFhfoMHmYHw/X1Z4q2w5eGOni9Y?=
 =?iso-8859-1?Q?cwhr7YJ1ibXv9/qyRg/7C044RBEDxUzKh8LNWEbYmFaT1YrLvqve0eKBt1?=
 =?iso-8859-1?Q?OOjqZg55e2+k1WE7nB3C8LqdFEwTNu8hEZIS1fpO6zKBK650vKYAoMJEVG?=
 =?iso-8859-1?Q?ODTn50P0Rn/hf//qKlSSNl7USra8IQ3qZ7my8xL/RvtZVweU6KQYv1nuUO?=
 =?iso-8859-1?Q?kSssJX4Zw33y5OlxA8qeOkg41KYVwOEhOW6gBs5zbH5oyz0sT18z6K3aDQ?=
 =?iso-8859-1?Q?uzlX+ZksVWLaNjzLhrBug/SMpwKtCjWLT+7x+o+JXhIuvjkTMkLRwuHONG?=
 =?iso-8859-1?Q?hyreeY6VsJkYvbJKdG1UZXxF2CyF57XutoAUsQGwQdFICggHpzaDCq/fj/?=
 =?iso-8859-1?Q?1jLIJ7FJQlcKOyNiShVEaUY+ec2MJHbi3oa5lNHhO4XRRi2CkUr2Z/ie6y?=
 =?iso-8859-1?Q?jDK2gaZtVNAvsPK/1LuWZ3Is+LJC3Fi9y23MgcBEQLp7quCNaldNf32nfB?=
 =?iso-8859-1?Q?U5mb+f91lkRsAXbykhP9BpQgpH2k56+KQ+ZRkKCKsYa94mqzzNhK8kU5vx?=
 =?iso-8859-1?Q?6ME9oCF5d8JsTxhmEAjAEa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?b8B1wlrOFKNk3G6V8zK4wt7Br/HYD5BOMRtK+0VW7dG8qr3j1ipYMkfZxJ?=
 =?iso-8859-1?Q?/Bf8cuHkQvaL+WS4VAjyDanUx3WYBNG3nuwENOyEnaCGqP2A4SPytvNmBC?=
 =?iso-8859-1?Q?kXo05JCxjBnvTtw1ZBt8mZQ0pd2GEkAocdVDieSwdNXU7iVDintdRYtXEP?=
 =?iso-8859-1?Q?s80SvUz70iRKTeG2J9ru5RhG7zGF+N55U3w5q1q1BiOUgged6L/4ke8wPf?=
 =?iso-8859-1?Q?UB0sya43Sq6vW3ck9sM3bqormRG4/AG7Rk0+6N1rJC6KU+F1mpVExM0mFT?=
 =?iso-8859-1?Q?vbU4Ncn0dBjaEl7DAq87RH+fFUlMOF82qKZTEClWeDAjeDIsnBcZbCvtZg?=
 =?iso-8859-1?Q?K/Oi5rdrGG+2c/zvnzTP8cSUmTgzumHTOrOApsyS5L5rjHQp5qKR9ohR4Q?=
 =?iso-8859-1?Q?/iAvOKB/+aTdB1OGQhWDJ6LY653BpO64y1P1qHXFgzNW7tQ+XmlHjP8DOC?=
 =?iso-8859-1?Q?nsHFMu2ezy3GuCbSooK+BxbPO2UFdY24D+4VlVgFeS/mtNfq8enc0c0ZWH?=
 =?iso-8859-1?Q?ZAR5Odmx3ZyGjX0EsLgizyseDNYNhE3ka8LxyXOuIE8xqSNxrEtufZjbUI?=
 =?iso-8859-1?Q?lwLzkjv5EXVUjixJqzTyPNGqI3nbN6Wr6cpIEB7OrnNI3wj97Qy+i2sAJe?=
 =?iso-8859-1?Q?0x0RY+qrqlzU/imig2bWYBPlI5jqvr6RGLSfQo2KcE4j283Z7aQxFQqTEN?=
 =?iso-8859-1?Q?xcBaGSC2v15iOLfi62w9iupTIF82hoWzoeXV9jorr39fIWqf4qBNIB6ZBa?=
 =?iso-8859-1?Q?10qyfKe8svBIpjerBCDPBw7mqe0EFmWwaTEVC+7aAqA5fN9vT1KQ/eEJzf?=
 =?iso-8859-1?Q?e8I3MYUvIGgtk5o9MQh8cMn8+B/jjxh9lfClpbRvcOU0KbzrckdPy9bLrM?=
 =?iso-8859-1?Q?ZNCQYlNhbm+69ZzZrwJcCtTeXclDhMrhP0M+FGpHMuG7WeBSvi8LVjqOOq?=
 =?iso-8859-1?Q?D6Nk/brxlKws+Z4U1szdkCrrW78KnEDXSQ486uVbpdD1ISaNdrludcuS2c?=
 =?iso-8859-1?Q?W9MIJ3xkukAmBnE6nhWtGbeataE8zxPjoRFjVhygxZwgE4Y2HbeKCAxYHK?=
 =?iso-8859-1?Q?KcX6XQ23veX76XuEwdecL+19OXMsruZZe1p4D08pS5LxKj/rTk9mK3ESDs?=
 =?iso-8859-1?Q?MS6sFpa8469TF64YBpWTiA3UKg8aoWNKWwQjzPHRv68OnSyHOoEQeEScZp?=
 =?iso-8859-1?Q?gcZMgDSU57g7PONySkgzgo+b9DTzjP97fVUARbXRzdbft7DGw1pZRBwwA4?=
 =?iso-8859-1?Q?/9stPbC3UyZP2/jmf+iKIqSwxCNt/jt+mv0l7FCziCZonddKfngoJAeNFE?=
 =?iso-8859-1?Q?gbcyoMUsOnJEbcbfvEgPR0hGODIPokgBxuhalIeU428wE8/F+AB28QXMRL?=
 =?iso-8859-1?Q?rq9okij6h7so0QU0EnyIJvsRLj1pdxZtfibQq26pbdu789r6kpsYVqo2C8?=
 =?iso-8859-1?Q?fPvpuh6j1J/yL+r0vocQucLEWdI2K+rbSUZ83+6efLCEgzEJ7kVTUYBXJ3?=
 =?iso-8859-1?Q?/ectEzrx9jW7xnt1oQd+ctYf8us0DAmFzzQN1KUawuZrn4obucyL/o9cGQ?=
 =?iso-8859-1?Q?JioKTAinPf9AXG337erpmmbBtWFhhtjCqP7/2uWz2ifja+VGw5CWhBnM0v?=
 =?iso-8859-1?Q?PDo/lph3i+qOHV7S1XoOUCZMvrPtA815q9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IkfWxmXI8olocDXErSnf1MdmCfocCyY3GhOPBvpe0XB+zZbsChEUddbXRw+dsaj7iFoKifjDyfwCzAuLkplpp7/YQNjQPkoic9UpmCpHMjFPWGHQsL8n64oRb0w03LrRQLeI8Gm4Phkj/EtpkD69nDpBjCk3AC9rgWtNVwxhdWRrLXRwQqnhFg7u6+2aYDX2W8zDMiVtmX7PEDmluNTQWL9jK4+zrjdBDcGOzbEhrjrVMBqntvfv1W+PsauEKexRiprXH+r5KWmHp3KitEuKdJN86xbRm8BqaegOsA1zGPOvI7oU4qoriEddOkQncbAyZERrN1HMZe026agj2wnj/5i/pH2B1bDg5C0P4htgvtYF9z72mvf9z+Mab0AFFmt/CeY5KST2b/8QbmG6UaTPKFYDUo72M64JezzjLYL/wGCFgxaPJSgEx9UkTfLagbS+I9GA7ombS8VyF+BtKaOleU/ExlF9IkStHi5T3uDorveOyE+qfpeo3TQ1gKdASsE+oqT8p/ObXvWpbqStjbuqDmdOMXYNZPmqiOBiAE0r6zMwwvLFJvGAOXCI/fUSzgbaMW56MBbkEgZ0Orix1wOcR/awkbAhkAR+LGk52rbvWs8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9327f406-c350-411d-bdef-08de12136abf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:06:14.0846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0p9dRuAu+7OUtGoCgyXAg75m3PIz37I9ttx+aSyHxyeGLuMOpCdffKlOluvznu9OR90nbUYjL+aRsmWH0ErVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX81k1nHfwyn34
 Uq9WPcZ4BTH1BWF7Ed8fjFtrbSdhMXiAdmQZ/CEhrISq/f901TT8j2MMfHgw5FHQnNvdoGQkekj
 RgGofHWlGIneZ9+gT3UIkQKIHOywZH0tOUeOS6g6W15go6ba+7AfzN0k/BwJfyb8c7lsvZvZqrD
 OmIaKaBjrZyWkiiJ4+eEU+xsjA0xYSNhyBia6iAwpl88/4iUMgXc9WnR5t4zAQKxSYyBYeL4diI
 jUqEh5hvhaETBQNE6PuAIS7+HMd6WHQb68U2+GaGP8iVwIBOEs8Ar3lprUaoW3zW+sTjiPFeuQ0
 E9I6jU9K2J22o6yEvkY3qXIm/iu6ylw/qAaWl01YkF0H3/kd4BhhhaiZA4qZXObZSd59cltD+b8
 7hiwukwHlHY8AP/D6QwzkQ7qCa6ORQ==
X-Proofpoint-ORIG-GUID: S0G04Xu4RbEK_Ongts4G1YzIZGlkVAS1
X-Proofpoint-GUID: S0G04Xu4RbEK_Ongts4G1YzIZGlkVAS1
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f9f00b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QokhSt2ydNtxb3VdzbAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22

On Thu, Oct 23, 2025 at 04:46:42PM +0800, Hao Ge wrote:
> Hi Harry
> 
> 
> On 2025/10/23 16:23, Hao Ge wrote:
> > Hi Harry
> > 
> > 
> > On 2025/10/23 15:50, Harry Yoo wrote:
> > > On Thu, Oct 23, 2025 at 11:11:56AM +0800, Hao Ge wrote:
> > > > Hi Harry
> > > > 
> > > > 
> > > > On 2025/10/23 10:24, Harry Yoo wrote:
> > > > > On Thu, Oct 23, 2025 at 09:21:17AM +0800, Hao Ge wrote:
> > > > > > From: Hao Ge <gehao@kylinos.cn>
> > > > > > 
> > > > > > If two competing threads enter alloc_slab_obj_exts(), and the
> > > > > > thread that failed to allocate the object extension vector exits
> > > > > > after the one that succeeded, it will mistakenly assume slab->obj_ext
> > > > > > is still empty due to its own allocation failure. This
> > > > > > will then trigger
> > > > > > warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
> > > > > > the subsequent free path.
> > > > > > 
> > > > > > Therefore, let's add an additional check when
> > > > > > alloc_slab_obj_exts fails.
> > > > > > 
> > > > > > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > > > > > ---
> > > > > >    mm/slub.c | 9 ++++++---
> > > > > >    1 file changed, 6 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > > > index d4403341c9df..42276f0cc920 100644
> > > > > > --- a/mm/slub.c
> > > > > > +++ b/mm/slub.c
> > > > > > @@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct
> > > > > > kmem_cache *s, gfp_t flags, void *p)
> > > > > >        slab = virt_to_slab(p);
> > > > > >        if (!slab_obj_exts(slab) &&
> > > > > >            alloc_slab_obj_exts(slab, s, flags, false)) {
> > > > > > -        pr_warn_once("%s, %s: Failed to create slab
> > > > > > extension vector!\n",
> > > > > > -                 __func__, s->name);
> > > > > > -        return NULL;
> > > > > > +        /* Recheck if a racing thread has successfully
> > > > > > allocated slab->obj_exts. */
> > > > > > +        if (!slab_obj_exts(slab)) {
> > > > > > +            pr_warn_once("%s, %s: Failed to create slab
> > > > > > extension vector!\n",
> > > > > > +                     __func__, s->name);
> > > > > > +            return NULL;
> > > > > > +        }
> > > > > >        }
> > > > > Maybe this patch is a bit paranoid... since if
> > > > > mark_failed_objexts_alloc()
> > > > > win cmpxchg() and then someone else allocates the object
> > > > > extension vector,
> > > > > the warning will still be printed anyway.
> > > Oh, just to be clear I was talking about the other warning:
> > > pr_warn_once("%s, %s: Failed to create slab extension vector!",
> > > __func__, s->name);
> > > 
> > > > The process that successfully allocates slab_exts will call
> > > > handle_failed_objexts_alloc, setting ref->ct = CODETAG_EMPTY
> > > > to prevent the warning from being triggered.
> > > But yeah I see what you mean.
> > > 
> > > As you mentioned, if the process that failed to allocate the vector wins
> > > cmpxchg(), later process that successfully allocate the vector would
> > > call set_codetag_empty(), so no warning.
> > > 
> > > But if the process that allocates the vector wins cmpxchg(),
> > > then it won't call set_codetag_empty(), so the process
> > > that was trying to set OBJEXTS_ALLOC_FAIL now needs to set the tag.
> > 
> > Yes, the case I'm encountering is exactly this one.
> > 
> > > 
> > > > > But anyway, I think there is a better way to do this:
> > > What do you think about the diff I suggested below, though?
> > 
> > Sorry for the delayed response earlier; I was trying to deduce all
> > possible scenarios.
> > 
> > It makes sense to me, and I will submit the V2 version based on this
> > suggestion.
> > 
> > Thank you for your help.
> > 
> > > 
> > > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > > index dd4c85ea1038..d08d7580349d 100644
> > > > > --- a/mm/slub.c
> > > > > +++ b/mm/slub.c
> > > > > @@ -2052,9 +2052,9 @@ static inline void
> > > > > mark_objexts_empty(struct slabobj_ext *obj_exts)
> > > > >        }
> > > > >    }
> > > > > -static inline void mark_failed_objexts_alloc(struct slab *slab)
> > > > > +static inline bool mark_failed_objexts_alloc(struct slab *slab)
> > > > >    {
> > > > > -    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> > > > > +    return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
> > > > >    }
> > > > >    static inline void handle_failed_objexts_alloc(unsigned
> > > > > long obj_exts,
> > > > > @@ -2076,7 +2076,7 @@ static inline void
> > > > > handle_failed_objexts_alloc(unsigned long obj_exts,
> > > > >    #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> > > > >    static inline void mark_objexts_empty(struct slabobj_ext
> > > > > *obj_exts) {}
> > > > > -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
> > > > > +static inline bool mark_failed_objexts_alloc(struct slab
> > > > > *slab) { return true; }
> 
> Maybe it returns false here.
>
> When CONFIG_MEM_ALLOC_PROFILING_DEBUG is not enabled,
> 
> The following condition will never be executed:
> 
> if (!mark_failed_objexts_alloc(slab) && slab_obj_exts(slab))

Good point. But without CONFIG_MEM_ALLOC_PROFILING_DEBUG, we don't know
if someone else successfully allocated the vector or not (unlike, with
CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled, we know that when we lose
cmpxchg()). We cannot "fix" the case where a process fails to allocate
the vector but another allocates the vector.

So I'm not sure if checking slab_obj_exts() once more is worth it in
this case, but I'm fine with either way.

> if another process that allocates the vector, we will lose one count.

By "one count" you mean skipping accounting the object in memory
profiling, right?

> > > > >    static inline void handle_failed_objexts_alloc(unsigned
> > > > > long obj_exts,
> > > > >                struct slabobj_ext *vec, unsigned int objects) {}
> > > > > @@ -2125,7 +2125,9 @@ int alloc_slab_obj_exts(struct slab
> > > > > *slab, struct kmem_cache *s,
> > > > >        }
> > > > >        if (!vec) {
> > > > >            /* Mark vectors which failed to allocate */
> > > > > -        mark_failed_objexts_alloc(slab);
> > > > > +        if (!mark_failed_objexts_alloc(slab) &&
> > > > > +            slab_obj_exts(slab))
> > > > > +            return 0;
> > > > >            return -ENOMEM;
> > > > >        }
> > > > > 

-- 
Cheers,
Harry / Hyeonggon

