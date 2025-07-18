Return-Path: <linux-kernel+bounces-737225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90979B0A977
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBE77BDE74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D02E5B0F;
	Fri, 18 Jul 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcaavYB/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BQV41XCe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7778F24
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859691; cv=fail; b=WMmLo7uO5oOvGLLO8vcsbIDycPRz3scIBN0vN8WezCWm0uCFWNyn6drdtJ9vUvuKqjwy/sQNv07jJRAlszmAQ6TwuVunN77hzi/8BVar1b3rkY3UkPYvTKjTJONTRP3zy22II6Y8ropzxtWg3T3Xy290gyE7GeZgWImK1Zac/YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859691; c=relaxed/simple;
	bh=I+ZwFxsl79QUBAV3k/w58SXtx8tmaK/mS1GERtN8Xuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHXFnr7i4TZrbwitUS3yE5lJQvm3ORU9s15bsy/+I4oRVT0wKPbeifss1fTDckji0AiaLhqoZyla08SFFu+LtO4IaIwq6a21uh9hXNPtuvW4LZqmaPKHPPj043qTZJMtIE79De6++og5oY33Yp7ernkWGiQGR73399tbpm3PpUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mcaavYB/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BQV41XCe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHHlwG019881;
	Fri, 18 Jul 2025 17:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9DgdOI10YoS8646bQr
	nhfGPpdvHta+S+PDwSrPoa6hc=; b=mcaavYB/WcXBw6dk5XPDCA+v9SLyQg3M3v
	kScYBNWz1trEbOgIPgVr6l1YIqah6PsAxFEmq9utycnfcFGM9W0McqVFRhHjWRke
	X+J235riyankfcUDwTayMcs5xfARKdZWdwSketUVcdTJ0EnE0noE28ZlYzAi5JPR
	K4/FF2ZYK3mE57HeM01OYoHPXir8YebeM0E8hrpY9xi19LI2Dr9q3+hCn5VF//Qb
	vj1+zvFF7Y3LoB6/jaLHAfxqFyChILb/KCjZvBikktvU9rMqMsmrUW1hdOsoWR3w
	1xTrrEMru/d4YnkSkCwa2+9+jLLGdeC2NdNjuIaaf0BFWttISgQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqxbg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:27:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGuswl039721;
	Fri, 18 Jul 2025 17:27:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ed4e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 17:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6DEqOoHPwTRTmvpgwRloOShkuSw8aTNA5VFH+ya++6oPSvsyFjuWQiZEci3kxsPYgsGt5BGPqJXDwHyWZoD19ha3WD3kwkiWzszXsmzT6ieul07iPu59GQN6tG8PI7SXnuVIZLB3GNZbkz2vWVXssx80EbkqUUlV1j6fTKQlTszPsAoU5N98vTrtKR30yBlUSeTRgWB6MSTVk9yFVH3vOk4l8AxRRciNBJGkTVWvMbt0KM3sXKL3uj3dd5scADZ/kDVQOMR6svIhibsNvnWzpsDp5lbcNAeGWlKb8CNZa/Y8wOvBthJtdutx9iOscs4Xt5IC/z0s0i+KjN+UPegwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DgdOI10YoS8646bQrnhfGPpdvHta+S+PDwSrPoa6hc=;
 b=Pwe1NwEXS0Wxgqv98NxVX+nZfyXxDzcJgcj4/52IqPgt5c7QEzRLyjkdz/DYyoQzZfRZcoio2N/qYM+gtiLiEIWn+0iZ/SzeVrfqJGgKZ9c6w+HfOIO3wASejDmcHOMI7hR01Ak7V34kkqdFjWShxcPm5pUhzRcG6RildTmEz9cfimXFH1CD7oHoc/i0qYNDL6dPtI5vS8p4CqiOAncoQ6bl0yW5PKjbFAODWXwpGN/fxh4rM9g+2NmFKzDTIC0LzQuYbNnyokpBgq/EqF91guMBXKqc6iMVzU5Wnc7PfCF+mzvmOTHbzs2Inc5NCRl6GOebeunklE8xvrYe9MUOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DgdOI10YoS8646bQrnhfGPpdvHta+S+PDwSrPoa6hc=;
 b=BQV41XCe3QRLrJk3VcNlIlGeUBk+ApIsLN6LLvWItsNaUrYdR0H7cqKqB0+iv8GM6YfSofZFlm9mGKkbhVoLRqAvKGrTnJifuEAN54Lw772YpVUnUA7O8pB9AYScLGOT7l9eZkD9iGFdaYNX20WSp6lPX4Tf9i9R3Vy+YyrsLek=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8102.namprd10.prod.outlook.com (2603:10b6:8:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 17:27:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 17:27:24 +0000
Date: Fri, 18 Jul 2025 18:27:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
        willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
        peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
        baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
        christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, hughd@google.com,
        yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 5/7] mm: Split can_change_pte_writable() into private
 and shared parts
Message-ID: <b1ffcc15-6150-43ed-b49a-5d1fc8d7994f@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-6-dev.jain@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-6-dev.jain@arm.com>
X-ClientProxiedBy: LNXP265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0701ec-3a56-4d0b-f041-08ddc6205c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X7HPdvuDktLhtGTPFKbraSIOK87zj+VMswlqw2+dXPE/1TQOsIJD7dxsXLNB?=
 =?us-ascii?Q?hfhb0+CLn5gNmyJKu3UAwqmEL8Eil5QjUrprCbs8jcRrH7i/shcn2EkP58JX?=
 =?us-ascii?Q?uhNpuuitFFvxg/2Go3jgI46ECKeGasm/cJXIMBq8eOSIRU4coX2Q8z2YZDP7?=
 =?us-ascii?Q?B9qv/ucJgBkryPUOriK0FN34YvN1/yO5NDdhWLgNfoYBmORkkvyEEreparX6?=
 =?us-ascii?Q?Xi5UWxdyN5VRnbQOJyVDq+vC837tMsaqOUVjeBdHMoamKrT/irOFgpEiKZNn?=
 =?us-ascii?Q?dJeXmNg0GzOdj50aBeNm0Zl8KrxzbPGzPZfM/ldXC9ubBDUO4CAwmgD7T3MT?=
 =?us-ascii?Q?ITXoMIEXs/bY0q7FFRFKEqO4GfdRWjWVPc8V4EJMEKolrfNffcNNKS4oYRY8?=
 =?us-ascii?Q?1x7FpnuMOOGTzEETJwSZO5wyZuH6qCxV9fcLy7A15Ys/BPjf45T4dqhqFidN?=
 =?us-ascii?Q?tA9nfV8EH/y2DtCOw/fiOsiqlQ2H75DDWRSkc9oCITZceYsZTKq31juu4dm4?=
 =?us-ascii?Q?amE2LChuZkggDriJbKaNV40V8Slj6fp18ibrchWTfc6abUyqi9y/uPtfvUae?=
 =?us-ascii?Q?aSJ6RJ2QPqF0QD5r9PN9+NnJ4sBAf30eHzQV/CspcfX7W5SY7TaIHEjG4hjg?=
 =?us-ascii?Q?K5as7AxuoNRhTXs8zxiY2+lGt0aw9NTJ9SJLaCZwcGWk9HPM00Ll5Zglwyg+?=
 =?us-ascii?Q?+IEO28YXsEfeweVGtxZrqm6dYeGS2Wr4cS/KdN3J2c+LrKgiy7kbUxZ3BIRr?=
 =?us-ascii?Q?shJN2ynwP3/ces3LmeuCMWuvXM0aD020h2G9Esj8jbHJDnvLVakXFuWEPQH0?=
 =?us-ascii?Q?mh8yoEF7Qh5cMpxMcSu9F/x+GTJufX0kenHQOz07NuO71gQQz/YiRFWwBMYc?=
 =?us-ascii?Q?59gcksfmd1FIkmS21CafznWzxbY0jIfzlys4bxJPOejL/J3lnK/hQlLLsulX?=
 =?us-ascii?Q?Atq0oLCt/NqE+bTS6X7BvrjrWY56bJAmncCvl+bgj9fJfjl0XjO2pZE/Ztq6?=
 =?us-ascii?Q?fZDcG/M4bTuLJXXf9MICcrlhoFDt8fS3nKmGr3cZdrygV1uZlYZKURvh0K+O?=
 =?us-ascii?Q?KGOn9/opSRT6YxoD8qZmL8QWY3lKHNoi8WX7VdVNXkEv+1sZtfzhWgc4Ke6/?=
 =?us-ascii?Q?Cn9V5S7/SAZ9rtlWx2ShYoXhTol3IibvwR2TUEkC54PaZtL9cpfTyGE9kU3R?=
 =?us-ascii?Q?usUcGw6wWahIzSK5h+2SEo1II1xb5XoYg99nucwj1BIcGrAw9MMZwajzf13o?=
 =?us-ascii?Q?TTiw5RDDP4lW0/HsPn5S/BfZWKtL1N3EuVd/+fMMzzJrT+J3fHiFdR1X7xHA?=
 =?us-ascii?Q?n310V/4OO3wO9znd69OrYoVFOjB0qIeUwuFuCzToiZHfA553ZEF3VH/2I4qD?=
 =?us-ascii?Q?c3OlYMrB+mitdUX4ZgIaUtuRj9piJU20jYtZIMAVk9PZXZPoFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjhM9C1oZF0DvcDzmqRtxneemJnKYICEGXIaeuanbAjtCLC2D8oNE1CbaTsm?=
 =?us-ascii?Q?nG/cQE4XKalL8C+h0+toZmrqR74ShSiknMpqfcYAiNfCY09uIwqU2HYqylWX?=
 =?us-ascii?Q?HaciXuI5sHByfPmRAJn+xHvwTmnFVJAJiYYKzgeNEbwo5sVEO+SQ15H5C6aR?=
 =?us-ascii?Q?Kq5GvYAmDqqnPw2cW/iJeZk3paXOsl1UbXNjG2TmDoDGqOFua2qQVJliBHop?=
 =?us-ascii?Q?yt0+SxhaTs2S7OYOu8AdyLHaRJhc9lmoxVjgLL/L4b+5qkuhSWyYtBTngbWN?=
 =?us-ascii?Q?xj4d8mY25x33LD6FAPiHxHpOrCIqNLkZYYPz08yuXQPPc+n0zrp0kLRrKiJW?=
 =?us-ascii?Q?lrQxi2sOWpU2ErsHk/9Vp8gWS2FK6Tah90eqwTxSxELY6EtUBg5dvn5deDG3?=
 =?us-ascii?Q?ZLAdLqD65+hs3II/k0KDyF2uh9Zk/rDAUypJJ/ExWGRd2h57Ld/lHx0HxGBh?=
 =?us-ascii?Q?ofTaX4k/yApHQTFJYqSrF6aYiWABQMj7WOXQxl4xiC+j/Va/5BnsAJOCTPTg?=
 =?us-ascii?Q?ODRY9lqdQSg3z3A0+nEHJFVMVIr5D8qAmNwYhoAaB+C3/PWr6rKg1PC/m2Xp?=
 =?us-ascii?Q?So//eFJazY8Pon+kwix0o1yExUBTQPx/+5FLB0+gUliKSQ2Fgid6sqO7yuKI?=
 =?us-ascii?Q?/UG/RarIrpdQ3ppAgO/v5bvrLyrl8myMKpVvsjjnxEZ4sBH1Ywaixz8iKORu?=
 =?us-ascii?Q?XkTvCUaU83K4GebeUljUfTNWbjP1kWL7JVzTL91b9ls59aQjKnQztvEBujAI?=
 =?us-ascii?Q?8h0wlGFBSxjbcI7h3Ixu2MRDWTlAp2RVvbv0RSaM0dvQLBd4Ys7XEzvONvuF?=
 =?us-ascii?Q?EEFbymsjbwypiEWkPcLffsOMSxQAF7Wnj3XL8RWl7KHluXGLnKS9FH4lj6+u?=
 =?us-ascii?Q?y4YJTBN1kCsVPJXenugIdmWXtDlpQO9b/Yc8yti92xe+ksE2l04+4DiGn/6x?=
 =?us-ascii?Q?T1WYAshCULHsvZNL65wxmDdBvtHzMosiWe3G3Le1UrLAdk+7lxcqpnIzL34I?=
 =?us-ascii?Q?H7Yh84QfvBbrIDn5nERfvPxIwEzEe7S+9DMjNNU3faLnMChnajMgZXCtxJVS?=
 =?us-ascii?Q?GrUhihjZ5ugdVNLPld2A3Hcp7XrdZnM6ZTfgHWHd5wJK6QYck4bphcD21o9N?=
 =?us-ascii?Q?MQCOqulKT/curfM5fuVhw3T6E2MTIgqIdCncSynTXvXdkszhX7Kodzm4Vt4b?=
 =?us-ascii?Q?yfy4IvR9Ok0lZDwqNjEu20hKrvxWqI2lVJeOvMKNnNv49xfXFhXvh9YBcBjQ?=
 =?us-ascii?Q?EPPYEA1RhIht8W8yjt40QfgplWDwNZYzJPdsltb9We/lMtH/mq1RGKufLSIT?=
 =?us-ascii?Q?3irezFPRj9LHQniz9W7hQOfpnB8a6V/4DeAG1QgMLq/PPid1MpCFFRXlBeRa?=
 =?us-ascii?Q?Ymh4O5JmcF6Hgz8PMRBR+Lg9OiDS0jJToTIAZaBAThgYtso3z69wii1kzS/W?=
 =?us-ascii?Q?SfyDWrFgFenYLDFUknsbbHrtlW/O3bSpUg6xRdtA7ZtG6sws4UyOcvgeTF2y?=
 =?us-ascii?Q?+j2bbL33vSUjn6y1f+jnn6TdGXy9XSB9efxgwJ19cbqubNSTGT0F0y2YJQ7J?=
 =?us-ascii?Q?RM3+cwbiBkO33oXxbYvpXQc8ZwzNYH+oTHcnmiVdGFTsFPG+Iul8qhUpcF35?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C1LEfVZ9LwC75KhFLdDnf2maseRgSorM/LQ78oNGjgNNZsy3W/b61fwUH2ux9rWMpBNq+rC2K3HzSy4c+h+fujxOc2KW5Z80LeTeMAcOMW9C3u7eX0O4jha9xVJzmIa+ZzV4eUJYXjJBRyV9A94FPq588AZIuub8UkFKpUAe92gRf/496GawHEo2jRmWfkV6Ayn42bfK9duzFKTNRjHK7WUyIc83doOBLmvZ/dnDU0kW6F8gVOjFDxZrzULqS7IPvVp7md75J4ATWiiWYYfgHeiXtv4uLTfT4u9Jrga+jksyjVIB2F1cpnMjmvn9B5KIMRU9Kj+O2WlriEEhv7kREqYD9Yi0Spb73GDDVBZcqihRBZMwkPe6IiuCQ4kQT9kxTLNV6mN+onK8r9DrXJRgOVRx8OuqaXR3/2bNO4BPUyE1KAsiu+jGc1VXhP4U5mewsVLNWiyN+QDjAbJvFV0xscI6liGgO74NiK4T9y2fQ6/Oa+7IkVilEovg7Z1Lbvjt/lkbi5pDfd+ki2MGgO+XoAoAwZl7ffQhq/4ZkK1TnoP7kk7xyH0WWpQMAXX3EdU4xfDxRK7sOY6OOOYuEkp1a+Ow+5m9bv89zqFp17TMSxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0701ec-3a56-4d0b-f041-08ddc6205c70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 17:27:24.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrHFsRFiECgOnEkX9Cx2cApZxOzyrvp55xspNvi4Ps0hQdnmuVNldak2KK9nWQ8fjQKYigYPu0T3wNOXaJr3zncMiDZZaqwkBd9lS9MqhKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180138
X-Proofpoint-GUID: o9s7xzNIiINv-tv6CalPudvVEbwEbews
X-Proofpoint-ORIG-GUID: o9s7xzNIiINv-tv6CalPudvVEbwEbews
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNyBTYWx0ZWRfXwn0/GwZqghyl ojHLg2t5Kp52/XhhCZG0EIkGZXPM5W6YoDZ00RX9s8y52Qy4GZeW7Z3LAs69q3AryoK6Ob3W1xM xILiBcCPsmlf6FFFIsdjwYhsRIPJfQo01j1yaI4iyxVnaPp1BPcYfUJ0WuqfQ4qaXbBGKxRAcnc
 mP1wS6WnWOIsUBQmesHzEMVhzI0ZURfCVIUJIaEaOjUC4yyYabyfVRGoNaPbI1GaPzCise0KLY9 Jj9tn1putT1DMEKK96MGhUKQ7Zzf4nw/V+OiWbYYWtmBPcrNAIJH0JqPk1pZ6NdrBhM/MDZdesM PMcWcPN04zlL6BE1YOBe6DIBFRSGAFzpUSekvHyYKBoJ5yGt65dGHaekO2ocFj9T3OACPKS2yMK
 7D1dX1rAcyYj3MwzZzMr9j4ZTVlHSFh/zkSArN+OZYfdLMBt0Np5n0B5LsEP3i53MLlTTHTk
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687a8408 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=pBioLmu8cAQ8ziw8FlMA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13600

On Fri, Jul 18, 2025 at 02:32:42PM +0530, Dev Jain wrote:
> In preparation for patch 6 and modularizing the code in general, split
> can_change_pte_writable() into private and shared VMA parts. No functional
> change intended.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Great thanks! This is much clearer I think (of course being the
Suggested-by here makes me somewhat biased :P) :>)

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mprotect.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 4977f198168e..a1c7d8a4648d 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -40,11 +40,8 @@
>
>  #include "internal.h"
>
> -bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
> -			     pte_t pte)
> +static bool maybe_change_pte_writable(struct vm_area_struct *vma, pte_t pte)
>  {
> -	struct page *page;
> -
>  	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>  		return false;
>
> @@ -60,16 +57,32 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	if (userfaultfd_pte_wp(vma, pte))
>  		return false;
>
> -	if (!(vma->vm_flags & VM_SHARED)) {
> -		/*
> -		 * Writable MAP_PRIVATE mapping: We can only special-case on
> -		 * exclusive anonymous pages, because we know that our
> -		 * write-fault handler similarly would map them writable without
> -		 * any additional checks while holding the PT lock.
> -		 */
> -		page = vm_normal_page(vma, addr, pte);
> -		return page && PageAnon(page) && PageAnonExclusive(page);
> -	}
> +	return true;
> +}
> +
> +static bool can_change_private_pte_writable(struct vm_area_struct *vma,
> +					    unsigned long addr, pte_t pte)
> +{
> +	struct page *page;
> +
> +	if (!maybe_change_pte_writable(vma, pte))
> +		return false;
> +
> +	/*
> +	 * Writable MAP_PRIVATE mapping: We can only special-case on
> +	 * exclusive anonymous pages, because we know that our
> +	 * write-fault handler similarly would map them writable without
> +	 * any additional checks while holding the PT lock.
> +	 */
> +	page = vm_normal_page(vma, addr, pte);
> +	return page && PageAnon(page) && PageAnonExclusive(page);
> +}
> +
> +static bool can_change_shared_pte_writable(struct vm_area_struct *vma,
> +					   pte_t pte)
> +{
> +	if (!maybe_change_pte_writable(vma, pte))
> +		return false;
>
>  	VM_WARN_ON_ONCE(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte));
>
> @@ -83,6 +96,15 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  	return pte_dirty(pte);
>  }
>
> +bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
> +			     pte_t pte)
> +{
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return can_change_private_pte_writable(vma, addr, pte);
> +
> +	return can_change_shared_pte_writable(vma, pte);
> +}
> +
>  static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>  				    pte_t pte, int max_nr_ptes)
>  {
> --
> 2.30.2
>

