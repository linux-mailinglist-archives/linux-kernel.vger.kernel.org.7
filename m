Return-Path: <linux-kernel+bounces-898910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E10ABC5649F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55BBA34639F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CB2857FC;
	Thu, 13 Nov 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxhiCybM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DTxTQkUJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3163161A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022795; cv=fail; b=uztstYAsX0XsikojohOBOo4fkuRDO2y9YMRh6JvKCwHsWVK2GHJ0g2ALZ5utzpJMyLqH8uudOdyKfbcYQ6uXxIietH+RJ2XuvbUNR4DPQMKb2Amk4m+fEs/PX22eX2LnKx0V+mArHvmEqLWuHvbqp7KVN5SSQ9r3rpa2Gr6h56I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022795; c=relaxed/simple;
	bh=gVK1fDS1+VbKHfjFZAYbynWnTyAdxn+Slz7XOx0dFRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVLBTydz1oHNG/sjkiKSCqszKfWhFHJOfeVjiW9TGFM5JITQL/sF/GN2Z5XuWEp2jg1lI/9LZgMKXCnua+ZlX3i9YlYTw7zSNgB0eCRdgy8KDA9pBBTl5d5k41slhH6JN9uV4E88WIhEXDiZpUvCMwOSQQ1MycVaOAE+hZ+zVkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UxhiCybM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DTxTQkUJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1go02021054;
	Thu, 13 Nov 2025 08:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/p5xNwUdZrksoWZEy2
	JbWCBcaRYBroNHwqGEYL8jby4=; b=UxhiCybMNbf7IUpBhZrJnHp7Buc3V1njjm
	1yT9Bdooaz2zY89a1uvpWHnq0lwUZDZRJUvaOgIK19qUh/62UqU+YvO9Fnb/Vi+x
	EBdy2dv083MqwjD3HFLtRlqsKbCJ6zLfDbZlIWqxf7UnI3wgZzKZEVdWer7mFuMU
	dGNbZBV/YANRJY7aC0RxESR1Z5Ndvl+1+xtqw2y7LQp5+WMvuGLBN0GNh+fEeGmW
	rwHa/LeBG7YwBPIrwpPX0WfnGOjq35xzXDy502QOAgdMSIwYLHCCOGgev+WqgsRp
	4SkscUjE7HOd3r1XGUgF3wCU2F8HCaTH6EKJHCmvo56mOqheZDMg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjt964s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:33:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD70nOI032481;
	Thu, 13 Nov 2025 08:32:59 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vank68q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKQVjcUmGek9x/hg8QtSN2AvK0ed1U5sM8mnV+488RZwS4oQZ/uEwXWgq65vn0xKfUAshy4LLNmv/Z6wXbIncK+CRFYGJ23MYo8Nd2Qm8GCIOWNaw+hEJahraknl9kKHvFmbEv2Dbwio0zSsB//iwTxP8dnIzNsXY24AeAI6Ct/dr9uKwalsLgOlyzMG/iJfEzq5ivv+lp1tGA8gVYiCeKS7AoRVKMjhA95jpKfCv+Mn7/egeZdlGvDI+P1IUPir3KsA1tRAM6sUAtWCAgdGcDLS5aR8f5aU+LJNYyvXo7ySAxal1Ccsbih594D2HcwwUFQH4buaQf76mStB95d6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p5xNwUdZrksoWZEy2JbWCBcaRYBroNHwqGEYL8jby4=;
 b=psUUVrExJhFnhQYhKEeW8nG9Oyg4s9dhnQGo6HgzjFIcuZBSwG4Tqa+PZegMnfXeFRbsVHuiL9wllPh8RNxm+lBNEAN6r1NDpp7tcmTX4Va3khnhvmxIPuiuuyWQlm9bdRD6biIaIYOUQ6pxrZPE96S8FTxpXd5tfkAG/wTR4+ti6GID6RMxBDf+RvSq2zNt3ZhpypPguQSQ4bQn5uu5+HExzidN1lt+Vd2sSS36xVTM4/IXD+QB5yMbwiJ5aZQrS+7MOK2at0x8J1lP3Tt7YLZzI6HYsws3KY4HydOLrRtKqL0bDqPJ5hWjSuKZb2jhJnk5Vrge9zdj5OtY2lEzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p5xNwUdZrksoWZEy2JbWCBcaRYBroNHwqGEYL8jby4=;
 b=DTxTQkUJkW+B9zKSe1m638IcaLUwOiMfTWZSTabOki91ZAjoa+JwTn9n9MTj6WNZedw3481X+jUT74JJGA2+j6MPaKiQbbK82TGRt4wTUgiB+n6nnmxn3Tmu8G2eHb4AXgFY6Z06VF89nVXnGYjjKgfvChbURtXC9U1fHGlZh0o=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 08:32:57 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:32:57 +0000
Date: Thu, 13 Nov 2025 17:32:49 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] slab: use struct freelist_counters as parameters in
 relevant functions
Message-ID: <aRWXsVuiSCv062su@hyeyoo>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
 <20251107-slab-fms-cleanup-v1-4-650b1491ac9e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-slab-fms-cleanup-v1-4-650b1491ac9e@suse.cz>
X-ClientProxiedBy: SEWP216CA0009.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::19) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: de51e7c4-d1ba-4abc-25da-08de228f3f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nf35TwqYgtsF4y1AqOHUBGNKYToxcxOD40W3ccZoFBU06cSu42i/GW6Ag2mU?=
 =?us-ascii?Q?BDmX7ovJLN2hDQGeEVHdF8foXgO3A8ea+UGWeIS1wTIGzzBWJ8womrGjHeoQ?=
 =?us-ascii?Q?rHLlNVUkxkfxrSGiIpgLd17w44PmIe8UeGlKK4tBHgTKKp+dstFjxsYFRG23?=
 =?us-ascii?Q?req6ntf7hdQyghxCt8CV5t7amc/BwNtzbv7T25NSWaKM1sdttJHPt1WkIZJN?=
 =?us-ascii?Q?6L7nMUbwF0trOibGJjsELk8q6i6PGnpiadPSpOCscvhZ3Zdd7p1bNJjSWCAv?=
 =?us-ascii?Q?MGg3xBE8wJEwZ2wUPWEcBNvhlIgH2tPO81UoxsC9dBBw34L52SDXddtkWx2C?=
 =?us-ascii?Q?iDXCAhAdcDPdw2YmZcf8ODz+GeYwCbFiiKXgSwFbg0ZQ1g7TXeCeCKgULp4c?=
 =?us-ascii?Q?uoGhxInFzSFdrMoHcUApniSVS6eGALssm41K+TFwCDOsGddCvju06xIqETIW?=
 =?us-ascii?Q?x/hyygU1sn5OLdVrzj63jF6+kSyltqjZpEz5nzrVnXnr7SF8xOQOnjTZk4sk?=
 =?us-ascii?Q?BgxESbHqRytOs07iDpFE7zFbDSrBzB3UepPNRtEx2LbnBWw8IhqWTIYULV1z?=
 =?us-ascii?Q?N5BUCWNIMpU0Cud5XZdrNV3opEs5jxiLLZ/UlIRz1Xcnn/Z44hH9deuI+R1/?=
 =?us-ascii?Q?Li44LBYt6g9QqhdAOrQ6FjdOPXEPpj0hm0F3oTrkOv0EOyADj08NeMIO0vmG?=
 =?us-ascii?Q?l3oZi5XPoe0mhj2KU3A+15rgKTkpNoNbY/NLA2Rs/kZiExkGf7m7VOzlk7vz?=
 =?us-ascii?Q?0F6DAyyzj+GfQHSAvVa6Px4uljy8S0ieAeHbgjzQZQNHuGo0LdoBlVIXD53b?=
 =?us-ascii?Q?sEpcbRaKPweA9wZA2kTfsRuGLR8aRAC5b1z3zawnCd47fgfWJcr/9HIYwl2b?=
 =?us-ascii?Q?RjeMwZ7D65SmzBDJr6lUNL5F1DhxNVPclo78Tn/vTDMhnWJYsrHqZltRNRr5?=
 =?us-ascii?Q?2yazdDqKkZpHPcnLkPrKF/TBUFZIU1TLKnm4Qnb1+zcr+WjUzw2+CMG57E/x?=
 =?us-ascii?Q?Vzbg5P4+KvEzoS/JOanI2MY40E+Z5lLExTJamnlBvPELzC6oU8PKsgzLeV6h?=
 =?us-ascii?Q?NiBfIke18BAq+EP4fxqkBA7UlV4+dodjrkXXkgvXDyThH8P84d3IgwYQPewf?=
 =?us-ascii?Q?Q7xyUa9SbY9xfk3GWrLnWwQ1MUHnShP7ppGR9WmtbrvglbyJFQxUxEKTqYYY?=
 =?us-ascii?Q?rDtuFkTqfqNsc1le3hSBunTM8T7x6Vf1h7IS9cy8wBPNuINPkbDF+aKjDsce?=
 =?us-ascii?Q?MMWIvsp9aRZ+IyZ4sb2p767WpmxZPx/j7aOB1/qvt8DrQ2lthX0UtaWk1BR9?=
 =?us-ascii?Q?XWfiMOATk0d6Gnk+Gd1e+wHeudXsDHn+aiTb0SjEV4aXuXlmAlzcSIlEVFlS?=
 =?us-ascii?Q?vpMoNvS8Eb2jB9vVGlaqAQS1NDoPFD4VXVN5gZ6LWPYEbIM6BgcnEDSccgN2?=
 =?us-ascii?Q?zLvSOMIbCsnnlIcxPb1phQFT2jbGKEfZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31eygNvyaz91SVM+41bL/ACpbQHumDbwAknpwFvQSPTInrwaTM9f71QTIfLO?=
 =?us-ascii?Q?Aj9ToPXnSFMbm28G+KB099KAjoG0oBr3+99Z3c7LZLvmeSTOqE/kUG3vJcC8?=
 =?us-ascii?Q?rJvaiynBjYT6aNxIfICN6LkfiljRkC+zjjDkbO78AJwgbUVwTAlIAy/NSjTW?=
 =?us-ascii?Q?8C2Fuoi7fLKmKlNDqqpxoTlqSyLaBKxOv6i64fZKmpeQgdy8vTEyreL5mcYl?=
 =?us-ascii?Q?v31TgOSu1iLXQ4E/Mwri1mpK8dXoh2Me8h/kj042JOQerkoPtfp31+URFe/V?=
 =?us-ascii?Q?8Sdi7RfmwSNbLmjcRquqvAjw0uWvhLPzY7BRQQhUFthtah4Artw5s63GosRG?=
 =?us-ascii?Q?bYqFUmjZYBVeUUPlMcZw8hAS5olIIfH5Sg3XXF6d+NfeEcqICI06wPO2iLyN?=
 =?us-ascii?Q?FtzrSenmZ8dSaLyM1MyGpVVw65Tiqre3VHwdLXKvrgwJczmyTy9Ytqf8A90f?=
 =?us-ascii?Q?v1w40HWkhCIPIlmn9CTp2KA7i0BVGLGV2NTKBk3IZc+97On2BZ2z2f2tO2MP?=
 =?us-ascii?Q?IjsLvSCL5avSAHBpydUJhwxLPol7Un4BmUNm8ZXpdf4OQRzPwJdjsqZ/nISf?=
 =?us-ascii?Q?nQVORXnoY3n26/xW3VxJOb6Gadow2IUBSE3npEaZ7l6rC98wRh9MQnC8GXaD?=
 =?us-ascii?Q?Q3jljk8bZ+xFNytLb82H6D5wGcRcHKc/YYF+NmlKZCsVZxeUGVt3j8nf+hEE?=
 =?us-ascii?Q?WMMr2CMyC8wP+y5nOB567HQOUWRIkZI8pNpI9heZEf9ynXhtV8rIxjwOHpUD?=
 =?us-ascii?Q?tE/3fE+4cwsTEFdwKU3ee2usifXpOYJRnzTiRhSqvHBt0ZOrFl8AJNWbdG3M?=
 =?us-ascii?Q?IC2VcwKCA29q7lVNA+TvooWW9jLGxM5JhXA2rlR9G7yr231O1/Dz77VoVHHS?=
 =?us-ascii?Q?I6MykTOincRzoECgeAQNomSU3yOe8knTWbFoSLsZ1g1AaNxEjhrtLHMZ6eP3?=
 =?us-ascii?Q?5fHAKrzwtXX8pI/QPhvEmwPUdHWNEnv0uQD+3Gm/eokGWFdO8Kx65Nx4SZ9q?=
 =?us-ascii?Q?xeJyS05WXBrrF6KcE8D9FENSV4PLqf33KfQaBDsb/lfN9AB56P5IYmhdyMfW?=
 =?us-ascii?Q?vw5W3Sy/JARDTvr4HFQ/FIQs6Si5UBokTVYkSK4AWuytDwbYrf200y+ZwuvL?=
 =?us-ascii?Q?NNWv4uGPm7h1LkI6ZxzXKVbGSrUhnTUe3vQZjyyZ06ZprWjECXEfwVz4HkVn?=
 =?us-ascii?Q?/OMtCvZoTAcdlcwVjnNd7G3HfMm/Bhx0aY9OGnOB2wNb4I7VWUrAjzsz8Xbx?=
 =?us-ascii?Q?I3ZHtpLvvne3Qt8BfqFLmSbX9ajGKqfzMGpzs4A4vvzSGu8TGiArufHDdWGV?=
 =?us-ascii?Q?YLPiBMIryXYecPPC9dhEB5mNDYXdRWM4WBYW6/M7FLzYrbVBxFhPwjjNpYg5?=
 =?us-ascii?Q?6v9odUwPKFwLBpmJM8E2JcFllTWHCvetuTqUSVLGWp1GQEmI0KYXs0OHNsUc?=
 =?us-ascii?Q?ZHArwc5uBngkMSeSG9QJcIY9GD3CC4PhuGHATjGhAyNluAvuyceLb9101RwK?=
 =?us-ascii?Q?Q94/DNlNJBt6lqltkEen+00DtlJtobueHVMDRrO3IObHJmdSSldkftHqMPXq?=
 =?us-ascii?Q?dWG0ywAiYlFu8oy5NwKFUa/PK0eCjKgwbUMZrDir?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1tdmxZCQkaPznzd2P/H/tTRmMhle+Ce6u+iRdANr1VZl0szXIgzWzgb93vlpWeude7rkLd8/sWQu9c6m3JNcAE2ZTR7Y/AAalUVdoiwTqw99pdV5iS3o1VXnaC3M3p9mopmes2T1jbOTLwljYXjFfH86xB3COZFfbzA3CiBSl+ZN96bJ7GwiRFxUxnLiEplnoEb21aYEw5tGihbMdYetMJxf2qUSPxw6hfeUo7h1h29Xiu1PBMCYfyJUzI0h6zHiEmuhAXvZGyamzK5S8kTc8wS3SSGt+WjEsq0ooYLyPpCmkcMTgu2ahWAybLrrzfNJDgMTCFtlsnNqulOh0z/Ike7rqwOGqDGYDwapMlMmHKR0ThreVtd0czOyvc/q7T6l9eX0Coat40n+u3c5feqB3Bk7yrbUaVMTw7A7nryQxvSVM2rTigz0odaGLEbV32H/ohE4yxabunLU+4TvsjvKtbZX1zIOeVGKfl9jD9dcmduY5nxnJuWiIHpTXYdT7CokEnjIzYAkpiEhOm/vG+M5irsyZh0yvovVVGR2UhOdeMonwVgh8nwR/XCcGyihEsifAi3yGkYOk83HvI2M6gng1sjoQY9j33OCTpQSpdbvpc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de51e7c4-d1ba-4abc-25da-08de228f3f2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 08:32:57.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crZ6mjX23MGxIOJAAbsahWJ7Wdl3Iy6rpXFmlHme1X0fJRF6Hc8i+QV8qRlFNqE/uQzQQUtUPEzGgVWBcuHStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX19ax5WFEg9so
 azZ3DLC8HKI5o3hqWaW8cWfbZmC9L7n/4Ap8JgEgBO8EkdyoS6WQFBlglCMP2lXohQWmZgwLYYn
 +ycZRuTzQgEK7c+Sj1NhaHmr4ePlSpRbb0TFGtre9rV2Bv9heRdIEdLxJVGsCo6np5LIk1PRXaS
 Luy/iAOeBKNZotNn0nNwCCrCp+xrBiiuR2O/NeC6HQtRq6RRi6/q8dXMC3v6CrBb2i6qw7qao4S
 e1mM1Ze28IUzEXTXHLCpqCH/MsK5XjdXazfptyw6p610LTUweC0ejUk33Vbd8DKUX1zb/5AAaTG
 qDL6Gi/3fzQjA56w1UEa/LdVn0S/wLqOAecSIFCnBD2FT2yp8LrWV47nhn1NoSr4a2JCvfDEKIk
 kdEEJfnqo92W0j3VsGhOozqUgoZ3mUCxIE41HDKTnFYiAGkbUcU=
X-Authority-Analysis: v=2.4 cv=S6/UAYsP c=1 sm=1 tr=0 ts=691597bd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=I-ewVVp5xxBP264aUkQA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12100
X-Proofpoint-ORIG-GUID: acdjTs8F-hQT6BDuK3Vkq788uSFNbcLS
X-Proofpoint-GUID: acdjTs8F-hQT6BDuK3Vkq788uSFNbcLS

On Fri, Nov 07, 2025 at 02:51:26PM +0100, Vlastimil Babka wrote:
> In functions such as [__]slab_update_freelist() and
> __slab_update_freelist_fast/slow() we pass old and new freelist and
> counters as 4 separate parameters. The underlying
> __update_freelist_fast() then constructs struct freelist_counters
> variables for passing the full freelist+counter combinations to cmpxchg
> double.
> 
> In most cases we actually start with struct freelist_counters variables,
> but then pass the individual fields, only to construct new struct
> freelist_counters variables. While it's all inlined and thus should be
> efficient, we can simplify this code.
> 
> Thus replace the 4 parameters for individual fields with two
> freelist_aba_t pointers wherever applicable. __update_freelist_fast()

nit: I guess you meant struct freelist_counters pointers, because
freelist_aba_t is gone.

> can then pass them directly to try_cmpxchg_freelist().
> 
> The code is also more obvious as the pattern becomes unified such that
> we set up "old" and "new" struct freelist_counters variables upfront as
> we fully need them to be, and simply call [__]slab_update_freelist() on
> them.  Previously some of the "new" values would be hidden as one of the
> many parameters and thus make it harder to figure out what the code
> does.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Nice!

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

