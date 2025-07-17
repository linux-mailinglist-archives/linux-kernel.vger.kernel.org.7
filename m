Return-Path: <linux-kernel+bounces-735776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E92DB093BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB4F5A0E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062242FE314;
	Thu, 17 Jul 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThXV70Un";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zADvqum3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CF1F5413
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775654; cv=fail; b=EKHZQ5dZg4ScGCPqKbS3rK0dEeeWqAfnrzHvceCkh5sMwKHdllqSa2KdJcpKCRV7m8raPY5CvMiRjfmyHGiV5Df/lrrQtOfh/CLfVnUoPMG9iszGkZ9/AAz6PNLVE9lZX9NSea0jbF1HHEBP/zMJ932T7kZxb2BikgWzGqjoRmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775654; c=relaxed/simple;
	bh=33hTp3c2jiv16NM2swxW2pxSKsEv4WsBw89TkGmIKos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGNyJwGbX7joz4/BiJ84G4mtQzVapUg/8Z7ed7j+8UqsnzPj5wYKsXaRNkzteDKLuwkj0Bglnsj9w+Enq9lqMB5qsIC01fFRHXc8cnops9JDhFObGK0EWm+6esvKrc/mVFdRRBmdM7VXVCfJ3MCmtf4FsoxiuHqKfw/asVWgXmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ThXV70Un; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zADvqum3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0h6e010735;
	Thu, 17 Jul 2025 18:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=33hTp3c2jiv16NM2sw
	xW2pxSKsEv4WsBw89TkGmIKos=; b=ThXV70UnimYHnpOvxTI2VN21m43S6080z1
	K9ANMRkWNRnEWp5DRFL9qX8rfbZVTgS5eq+3SgeMhAUcY40MJwgtxJERRPZ709nd
	/4P8tyOH07z1F1ORv2TClfdl5wnFQN0ccO4O4xbjksbyDL+t1FVQEQVQskAVIPJ9
	YDLBG42+pJe8FP4ozf9BqpKdVWKtNpdIo1+nYl5iqgeRjUDhn54vVx0eOwqqVW1t
	Y3XMKhR9KkEGnCc9+tcnpECg8KO+BkgrR/nWjbb6PDeMc2/xTChs/Oot0zIvuI8I
	+AenDRsMZjbO+DLh/eWGLwjZTBXYevniPKVVBus88GuZeHnBxyzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfc8u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:07:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HHMeqp011669;
	Thu, 17 Jul 2025 18:07:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d41n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI5wBSxe25ye1LHYdDJ3ouoMLoAI4FBuiqTs2rwthQS5TRbuByV/QIoteJN06uJ6fROJ32iHwOziDmVNJ0RAPZ9QLF3T4ogmUv8SpETKXgbxrYAoEVsBjw7C3ceOOC8bKdCJfNZBEZmBN4zvTZzVovutrHUzeXPwMX+fbR01xR2pYWn3gW7Gu/3GpnaZ4ibGTOP/9rtfb6N3Gu3YYyyk0dvxykRRkpbzmI4uxrE6aC+rlMmSfkKSh42HQvxwcd6oT+vKPA9tgQOpi6JcEejoV45LEz3KMY9g9UN6oJhnvft/h3942Q5cKPQ+Uq0CGUbzrENppaeSgBTNgrDmCQR+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33hTp3c2jiv16NM2swxW2pxSKsEv4WsBw89TkGmIKos=;
 b=QhcoycpURY2tJ6ZQoeGPZ8/h7dsKflq+ZmmLLMZydhu1SE3NEzuYYvItDfqGtMzbh0R9U4dVdqldm1fdZaabdMbQGYRy9uVKUlcA/hMWhAdm01jr/S1M/C7kMKWC6+88uMsG6suxSZLUlDrEeA5wNGE4YFWUeHjrmobSZ6hx7ymAzC9l+GDjiAYojcLR4RB27gwo2tDdsfPzp7L+y1HC1eFSwQ6S5sOHPwTB2s+CyiWkjGcyiCvIneFgwVtyUKgKae/zyr94lpCq9syxOy8XQZatBq8WSgCIfahYmxbYLGKIJ3Jx7hViJ0/5yhKSfIajFxSxRDbr+8ewwFKzH2fCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33hTp3c2jiv16NM2swxW2pxSKsEv4WsBw89TkGmIKos=;
 b=zADvqum3jJz7/knGj+HSr8jpUEECTmsSwDiVsEPFroscBTuP0A8+SrMR2DRaKrKy21kcn0SNBnYEcC3r1eWej0OFm4DmZU4R24kU91wfM/G2op/i1QQofSB4bT04OTOrqnYNhO+Ri/pwpZUQmEhI/ZR7yl/vHFenLfP406+/6h0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5165.namprd10.prod.outlook.com (2603:10b6:5:297::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:07:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:07:09 +0000
Date: Thu, 17 Jul 2025 19:07:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Message-ID: <75a36754-ec7d-40f1-8866-90ea2a415d13@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-2-ziy@nvidia.com>
 <5c97b1a8-b877-438b-91a9-1d1da19964a3@lucifer.local>
 <214884E5-15A2-48F6-A495-6133CE07E1C6@nvidia.com>
 <fbe387c9-4205-41df-84b4-ace69f7cbedb@lucifer.local>
 <63986D44-0A44-4231-B6A0-E118BF5DEB42@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63986D44-0A44-4231-B6A0-E118BF5DEB42@nvidia.com>
X-ClientProxiedBy: LO6P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d948c0-51aa-4cab-1bc2-08ddc55cbf7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g+stCaurjRxTvEDcsRdT1/7UK1r9Cw0443Z8S8elHisp1nuAbKhNIoJhWesJ?=
 =?us-ascii?Q?GWnPlzQRcQnwGOQzF+Oe/Kul8oIIJs9zncfMtakbXt7noaP6jW21PwoZ6W8P?=
 =?us-ascii?Q?UztjJcW8bU/gE2zxfmozmz3RbpfgANkGhnmu6TDP0NUaS2EL6FHYVar774xB?=
 =?us-ascii?Q?e7SIQQ9MFZyIbwAVcNOERj8HpiJMUv/OOzrtMj0hbb7B2IFIpm2jLSYjON2Y?=
 =?us-ascii?Q?ORpfVBUoVf9o8Ea9mZC1u8jemDyxV0jZbYTKfEEmGcjJEYUp0Ow7FvRAkgkj?=
 =?us-ascii?Q?hSAU/2KyafBuXToVppyrx4C3XJB+lhOtiLTyX13d5IATbD7zrgUzr/xiBiFQ?=
 =?us-ascii?Q?sK1wouqdRgqP+O1o6neYrlRX73KDXkYXZn51hO1Z5YSL2Qd2wAS6IkWxEMhR?=
 =?us-ascii?Q?CTurvv52xovHdItheRk+1+Z5N3jGrfwXhiS8v4KkAWJ1cEOsvhy4znoCe1lH?=
 =?us-ascii?Q?bZl1bP2V3DDLDKuhcXFUKEdLKf2H6E/Nw1ZiXlSRDG643jIlO0sTBa0iOv7g?=
 =?us-ascii?Q?8eDM7WzVfPbXC9E4cJ67oztl2CH1yMDA2aOi/959NcZTRTQyo9Xsc6zp3/mx?=
 =?us-ascii?Q?SJ1GlKLDf04AjeV+z5altvdKQwPJ5VKt5ZGC+9nZ3gsin+Iq3m3DgeMLkbho?=
 =?us-ascii?Q?tBCiAOoOBlVqWNjSVCEIv6Sd72nF4gWXtx7j3KxfiK/IOpkgCBQ/2HYhKqJG?=
 =?us-ascii?Q?M91EQdL9LX9tC8hrMCtX1oQe1Lg7wzLxTBYDb3X8VED17bZt+r3CxmYxcEhs?=
 =?us-ascii?Q?w1lkkUMwA8NJ5dOqAbQPdcwO/oUuj6sA5NrMGL+YAJDTqZPX1l09zX/M8tlK?=
 =?us-ascii?Q?WdKzbevlYhk02mJejiyf2EwBzJUeyrUNhYGq/7lqXXT131bcfKHoUwJNsxkt?=
 =?us-ascii?Q?KEmAc3WykEVZQFePC+u9WdQfSv9j+2E0SlHO/ZsF2MDOhHY5ETq1YfBNKS0A?=
 =?us-ascii?Q?XsYJhLmHkVx8yt7tSfYy+1TwimtR7eecIv87GtQJWMAexUM7muYw1oeXu9Zj?=
 =?us-ascii?Q?iO+AlhaNGbZb0rdME+qXMnNUi9wPrWOLqjX4ho6BN43u9pWcXdFFg80l9aeD?=
 =?us-ascii?Q?/lI026R6HobnsakOUXZRxbFQUcEoHJbzUdEuhaRmSFYDf68NLDsnk0aOf3Jy?=
 =?us-ascii?Q?oRgY6R/cTIOs6FtufMdMDEFVUYWlBRpLnWvc95kWWzHCG7PdeKxa2I4yKvRn?=
 =?us-ascii?Q?yqFtUw6BY29yetDvSvsWYaVR0K8ASMWErLtvjZoYquzRqPBGvq+9duEkUyHS?=
 =?us-ascii?Q?3U/LaUu8DWmHLyhiTgabXjKCaZcVKYSzdLPO1yNqrDb+qo8ItNCV+0eXI2gm?=
 =?us-ascii?Q?DyHB1vgFJdXvW/HAItZiK2JIzPWT4oP90Qqr0SR5ETQi95y2vAkMh7cNlUua?=
 =?us-ascii?Q?HsDZm1DTF7YntYK+5LaFaO19UleM7qZQ6asCJgFl+h9DMXgBHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/NzdS9B7yRic3e9iRrWH00c/3vp9b73FZGWicsylx08qeC3iAITiFhwi7t0?=
 =?us-ascii?Q?kREeSxB1EcNpyb/aI8pr8H+TV/8oIRN6VRX1Pf6u8RMZhaeueudShP5jKO6D?=
 =?us-ascii?Q?pZto5eBZniXdoMSiChIrwOuTDWQQ05cKzatwIMId0B15h64B7SBzokpJN0cH?=
 =?us-ascii?Q?bko3DassMDCW8AheG6YScrJsoaX9L6YBO2MsT5a0NL0HxEoVY2kOaQhYuiNV?=
 =?us-ascii?Q?2IGdVwCnxShK7Xa7o/IWWdz84qLfzE8AU9OTNLnfslLbUi6+glDnv8shSqGh?=
 =?us-ascii?Q?Cqdu5ew3WumeWrr5Raf1tZtH0GlpRMjWh4GF/Mz3JTC3ROVWCO43hVs3ieDN?=
 =?us-ascii?Q?IzcO3NdIQj0T0zD2I5Nx6iPrqg1KvfzJw7ewDUhzV+g9L6nIrZWy40PxGQo5?=
 =?us-ascii?Q?I8wWAjvrSVlo3PTgHizNO9gLqCfxC5gt0EaJ2riKmLAoDjV4dxy++8nkBWhD?=
 =?us-ascii?Q?QlxXx629Y5nXfXJtT3tsAgwukCcyCB7P1Fu8/gzroBAGtLMT05s/eF5X2AVS?=
 =?us-ascii?Q?SNUd5UsRPEZVaXMbs0F1be4k0es682K9iB0dPz/doMS28FYUzehqko1vhMum?=
 =?us-ascii?Q?8SclFuDTHwkMscdj7GTpIn3MAErfCDh46tcuwk8/MZx+k81BmcLq+c8QkLAq?=
 =?us-ascii?Q?VuotzsZR4Vvrk7i6bOlN4hGuVZ2GEtInx/jY6lwKE2c4Yma1gG7WNIme90Uy?=
 =?us-ascii?Q?N4nAgki2Ms8ZHGFhIeRxfWlD2gqtKCr7Xlm3/lZhcexd7Vggn+2SXCSiPYm+?=
 =?us-ascii?Q?W5T6m2f3mP0tInZtAI+Vxld3hB6Sl6mIeCzx+Zo/F+9y2KTBBJX2PpGNXWEg?=
 =?us-ascii?Q?lHRkvS92FyK/pUdolxMRa3cDem0Db0bPQtx/Aa6hJQKmaACpI0MbGwC+HQh5?=
 =?us-ascii?Q?676I6D1DjLdlq8/RBVZ/9HMx5twuNCiBUYgDj/IFMvUltKwblvOS8UsPGBml?=
 =?us-ascii?Q?gXHX/GzRrXA5t4Df+O9cTpbmMCZnLq4SxA4EjSV3IOrC65Ax7CVBepf9UU2A?=
 =?us-ascii?Q?YsXgfgSwXAJPvPqJcVeoKtcXLvibGXaNamhXit6mkd0i9N5Yuc+/ZxC2VDdZ?=
 =?us-ascii?Q?10oknFdKfNS0OURki/Z1RPq1rQdoDaIxXnOHDCnPThjvjP27vwYAi52L81ZB?=
 =?us-ascii?Q?85QtnooMP1xvyTcAvwrTLWXEsjTfzLoLDF/US6pxQ71ZhnDgGF4zPXZRViwU?=
 =?us-ascii?Q?FxRgSA6UaqWO+LqYJ+u2/r0IwCtzMpSeDYIr6cCSLP7fnsUAk12r5WePWUln?=
 =?us-ascii?Q?50oSKVVvLKTCLAtt4+rIGUxNOJ0b7Vdap+pQBeYQarzuDxAEgpx8IzS2dmzn?=
 =?us-ascii?Q?8/40V6kQ8+2EzY7flr8XuQiaTyJZnUIUsP8oqjcRdPI4J50vl+Mm4+2UBNAY?=
 =?us-ascii?Q?9VseLZDqtyvxcedp+yhzy+TS6GQmBhOXfTx7+lK0OtK6PR9f3ne6ULHR+rVD?=
 =?us-ascii?Q?oj7HgmLFaSuDpJD2e4uEXG3rGpFUC7G4BVmUf15aBpTI7BbQVUHvZexsVjjS?=
 =?us-ascii?Q?zloKrhpAFG2Q2QUftUDhvauNBGb4UYUKU+XB2uHl6v9GzYva7vHU4MdNhHrV?=
 =?us-ascii?Q?oRFJrW/r0POB9NuXRR+tLdK+34LhmRYZ+E0aqUBDA7xxSMEIfpkCJhYWqOy9?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ONYxMLEZHSbXOcAUrl9rb/EmTnfJjZF3AO8kCnlqFgaF7GavmUTfGpmjSjpcSz81evtUMp9CxlZ4LxxL/y+fQuarITNC263XoADKXDNTiwMhoflJXo5G21PsaV1aKOSlajWfW602JaItVD3QJkiqaUlAm0AtSOkM+Piqy3aFmneR13UjfFCM0hrwi8dV41c41bvnIOY5pq3Vmxmgk0P9GrcdJoYix+GSuiedYBrhAFjPVQE2yaaJcgeq5kH6pck4vvOEOoXtCIlB7uPXercqylN15cpAofGJqcEF7Sx/DJYykVs/+QDCd8AJl7VfVwsKt3HNiI8NBS1ckhHlmotIbbVReFkSzkcPeAGbu3YTMzPNhI5aOxoTBjavi0Ln8spI2+j0/0RC2Ka6l44UsfvNmreOcaU/wKLQdIpiQEgLTYORw3h5MwjBdCD8SK6AYe3VqMj1Q0FnxFK+kkrL7pG+hk77j4QqHL0/H02SA+REcfdn9josfVmnZfDet4BUwXcD3cer93WzA8YmmknUZv0ExDkmZA71J6K0C3j8sqtlbNX5SzO0RXM4iaSyo8XXbUv02S9igoYaqBU+3nHDvwNYhcGDzgwUqPlQ0xWkGF9man8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d948c0-51aa-4cab-1bc2-08ddc55cbf7e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:07:09.7534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MIoxbs0jNNdw8pSZgfB+OD5sbL5ejKivmVjtbM09/ixXnfkL/kGVkwBWidvljXY5oOLoGgd5M6r8U4j0098JdHDwTyjR1E3Vlu1XWKFfs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170160
X-Proofpoint-GUID: r7XsFRJilPbCIUqVL8dZrmwSIFsej_ux
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68793bd2 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=WyT4EUe6z5zZ37e7BSwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: r7XsFRJilPbCIUqVL8dZrmwSIFsej_ux
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2MCBTYWx0ZWRfXxD/svZ+m31Lh VDiMTVI65hzmXAcneQvQ8Jup0vDaPxyYnGi9t1j814DElqUrUSdibIDwoHktFzmLlYNJ3tyEhNq ANJRqnumDD8SdO++6+13LDo7FrQOhHho3KKPD1sLVjRGsQkq2BN8m0lcqRt/RZdfOkmkRjYXGcq
 bGI8/s7Iu95tEHBbW1AlDR0A5Bk5fBuwR+4ycbDGQfv7U+U5MaOzw/in3z0QX99DZRpvNYyTRJ2 dGz4zr+ChSBqd9WKdWx6Gs1DNoAc0+jANp+9EuAepWfewmLa+NATivbwxXayM+RkA2qdb0MBb/n 2EounbG3P7DWCLeJsRe1c71XMjvFP57GXZgnHewyZURWc+kQGTd/sXXAaxz2EUHNuA2BvcKNiyP
 iSHJI65h5P/1jRRzMr+hBWSXv1QbJ0iL/rvKZXxz+xUUvwN468bLY4C36WyA6YeIkQY102WX

On Thu, Jul 17, 2025 at 02:05:06PM -0400, Zi Yan wrote:
> Yeah, I meant to fill this up after going through your comments below.
> The plan is:
>
> 1. Just move code from __split_unmapped_folio() to __folio_split().
> 2. one patch to remove after_split label
> 3. one patch to move fail label and related code
> 4. one patch to refactor remap_page() flag
> 5. one patch to convert VM_BUG* to VM_WARM*, three instances.
> 6. use folio_expected_ref_count() patch
> 7. mm/huge_memory: refactor after-split (page) cache code.
>
> Maybe 2, 3, 4 can be squashed into a single refactor patch?
>
> Best Regards,
> Yan, Zi

Will leave to your discretion as to how best to structure :)

Cheers, Lorenzo

