Return-Path: <linux-kernel+bounces-736281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B4B09AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11307A609C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879141E3772;
	Fri, 18 Jul 2025 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MjaHS9/+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Psxm0Rx+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2F2E3701
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752816423; cv=fail; b=vCw4e8v3yRAmc4+SnV5FKyWT2cA377nQvJM8P1BoqbFssVMcqCF8F0lRQMnZq1qfhYye5XOKtR28eMn06L8hVSTJZFouxw3lFyDz80nmrBtu0cKMdoACXOsXsf1T7lHue368RRnVCDRs7bySE/UI4AwGDKicjB6SiOiKdvi0kVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752816423; c=relaxed/simple;
	bh=ntASjcZ+B+9CzyEvigN0dOWX6hxKQYZ5+xZAtrR7K6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gkQ/faFELrgEKU42meWauhzfa0KN7Y4IAQGLBNgtDA4ApsaCTVXZeJl4FsIU+GXtoB+WGLC8L4+xhzMxBSTmEr82+Lu2Fq74ccYwpD2pUkYdc2zlu+gBmeQb3VRtWhatj8ORvXtVEIvvM1OSWO1Y9ntbqkK6ykzPrPP2P9GZgcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MjaHS9/+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Psxm0Rx+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HKZGMi013593;
	Fri, 18 Jul 2025 05:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Yu8iU6Sp6pLzZFZ5mO
	Tvh+2yp5Wvhn0zIVLGaNHdsvs=; b=MjaHS9/+RaLlbC6Ws7l6LhxAm8WIgrtBfw
	vBJRK0QkjO7rNr/6nPAnUvElrriQqxYC9ZaFrGgycrU48AP/uprgIqTpLCsOoFXe
	BrCNZ4FPIu7kN2L3HEjwNnnOcoAw8HOFMIfgmC6LRIso06l0ZJn9jR4yKTJZIcSk
	+TEaCHYq7XbaIOSJYkyaM/SlilvIV6TNf6X2fIIljSW3Zuen1c/eFjwxuvbRZ43S
	P+KaPn8Aih77b2Cgq6tShii4IZ7Cc9CZ/NTHps1StLM1oC/ttMtZP9Mm84R+/288
	cuZNkz1/YMduLT3HjlMJsKMTuP+U2HpHGsfyNusjfLSxp/FSTcXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4var1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 05:26:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56I34IIW039704;
	Fri, 18 Jul 2025 05:26:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dpg7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 05:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE/RNabfW8DK5ooepD3XqERPez5fC7gu374+0XG3VKS05q9Q6SloqN+Dd31jEDyYMBtYfCCTxb0YUwmwYnu1Oyd7TKGA4P4+5eF1sXbxkK6FMI9cv8h4afu1TkoftF4HMSqYsDYX6ARpkCX7Yn+NQ57fO6tttk8rdNs0xJ+V+Y8I4/DoSJOo0gIqrxgeTHKoxExO0mPeIROx6FHxjj3tgrfD9iODwYxIkQPd3X6ASFSri2p1gt/ejU4F2WPxUe35tog//vMqWQWNQjQMZXI/VrRxq58huymA64pkrU+Q1lIu2rA4GPtt4/4RXlTdt1PlXn5wJUWuK2nJofNFITf+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yu8iU6Sp6pLzZFZ5mOTvh+2yp5Wvhn0zIVLGaNHdsvs=;
 b=TAe4b04DeospzTWH9eDU4VX1TLP1PY08krtej78ScVGET6k/RTev/xjSKJbLdGHKwFCEGR7Ow3+jVkiQ9KVlZ18u+CxnTznRKejpIxaZi0LUxibJ+1/0oOIRcb3UaF4bFVO9C8DrUmPU68mpd87CLhJa4noTYeeE/5xLXLusIXvVoCabJB8TTdXGm6z7fW8q+uczhgXVCZvI9GyiEBxwMvef8ZLOJPN5AThLKUemTPIJrolpYiCdYHao8Mm5mLxqxRDwdv2wUHa07u47oaxe54T1pMmJYTc7cSbNlzrjTXTruViSBj8NYddkrhKtB2i+niYeHQYyGKsSct8gVTZkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu8iU6Sp6pLzZFZ5mOTvh+2yp5Wvhn0zIVLGaNHdsvs=;
 b=Psxm0Rx+DFRmoFNUDYoAJTDXEWs2RGqYwDqoiS5dRXOpoQeeFMXrz8s1wTx9kEtBNirHyAQk2G25A+u9QRpYyATIub8Ic68HlFln1022mEWukrpJeztfyPjbkllTdETf4Gq8L6gC9A88dvMt/YW/aTEvyGRQLxnBTg4MNzT3q0M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6720.namprd10.prod.outlook.com (2603:10b6:8:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 05:26:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 05:26:35 +0000
Date: Fri, 18 Jul 2025 06:26:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Balbir Singh <balbirs@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] __folio_split() clean up
Message-ID: <9696c72d-8b28-4658-adab-11c8eb61c2ce@lucifer.local>
References: <20250718023000.4044406-1-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718023000.4044406-1-ziy@nvidia.com>
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: e1eeba0e-73fa-43c8-79a4-08ddc5bba97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fijzB9YWdjaSqwaLWeqOy0uKnKD3KBg2AYlD9Oo7vTEpdmfl1jthNHPc+V6d?=
 =?us-ascii?Q?+dLXYKjDrD47Ul7HgrIgdoW85kbgeiHWHAz7zsZPO5oAGt55690BIZm+9wZp?=
 =?us-ascii?Q?p5/hOq4rShGy0TA4Z84yduYUJLLTu6WTNqQo/0LCc45dJFY2Vdy7cR5cGA0H?=
 =?us-ascii?Q?RSUoyq4aQhc3lit9Iret47bsCef10RxJvL5Dju6k/4PGvrFCR0bfl/HB+N2n?=
 =?us-ascii?Q?bCGxFNpMPy3GQgwFFnJzsrV831hnV+AkM4HfyNI6dPuehN3k3vypMzQ8hi+n?=
 =?us-ascii?Q?uR6BkOdk+XeMUcS9822dcwgeyRJWrIimfG2mFZ9chjmKwLVZYLj91Z32skr/?=
 =?us-ascii?Q?IiN5hsbKgZoNOboHXYIy5FDANIC1Z8AbjiztqFRDmGczBHbdCZqAVUpHFzF2?=
 =?us-ascii?Q?c9+Djk+OMJpBGkQG/FO/mvsEU29lINmb73W7XNqploAJriMLNolSa2aUua2X?=
 =?us-ascii?Q?xGerWB13ukoJHQNx+bbN37OKkPceHuy9e+WRldU5jW8t9q8NnKoyfRFX9HDk?=
 =?us-ascii?Q?7NXwnrhpqJdDoZqqjEEFLsaq41Zi3tZLUEer6s0Re2xjVvQmIDoIJU+Ck37r?=
 =?us-ascii?Q?vA/YIVtdTo+7pVEFQs8MoLp1liQ2NXD16OvYqLCBtyLVgOYRU450qSP0uG2p?=
 =?us-ascii?Q?2khSCx/U/cKxn69Wkaz7hJGOp+/OBb1IhuELnFTzmGyzlwtUywqBZIFDdyoX?=
 =?us-ascii?Q?PBsTOQGxecJj+3eNwMf7smhtLg0uT7J+q4ga5GbtWy0x/U2oaWOZnPT9ozk5?=
 =?us-ascii?Q?oqJrUdJwmkvTmjy7YImeTDhYSKsfCnFxPMlx/wd13KXkh9ez3GxsKJ5knDwf?=
 =?us-ascii?Q?ap14utomJd2lSxti7H9FgbRQCmJB3h4pYi4pDHZdoMs69zRDfTQJvaFXRjrG?=
 =?us-ascii?Q?ApGYH53f1oRO9a8d9Wua1aaUxA1tNpuoMEuc3MzpM+/FLoQcIkP+oZM8kWVm?=
 =?us-ascii?Q?9ceN44zLPtedy66NNLEGIPS+459l0wG37f2BS4gomnXjBQfn10EmcUabPXEO?=
 =?us-ascii?Q?ppGE32AYpdZmjwonHAIvoMnktXbpM6yqx1NwWdNwk++mQZxJuETkz92plz6h?=
 =?us-ascii?Q?z3dK9Q3PIiA8Wkkg/NPRjIw56BnO177lgFoRn8Mw64kpjLa5QYlbmS/lz6qF?=
 =?us-ascii?Q?hdLOubAArimTPXx5xb7Gy2E0CwIDmO5OPkHJl6msnriws6Ll9Z0ciWw1Jhh7?=
 =?us-ascii?Q?UfoDl5gt5TBnwxlMtfBW9rni9/QP4uPlG9il874JQA0gWx6dkYIf3syXgTya?=
 =?us-ascii?Q?PUEQsM5jqCQ766bDDbLSMgNwPgWZHfzTKH2301jGCyiDZLHsoO1UxNz+dkzA?=
 =?us-ascii?Q?rZW97MXxdBXH9rBuWqzBy2S31zN4Bsu8qh7VqWrnP7uG4p643RFIY2sLx7MV?=
 =?us-ascii?Q?EvnF0k+XSMWF5tTZ4JwRVNsAN0CsEOHzno8sGL0eDQQy/ozW9sargbi9AHAi?=
 =?us-ascii?Q?PdlDd3UyMhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbLfgPxkvSGkv4gONCYyil6KqQURPwBAwLDu9L7dhJbKj5tCkqKWoxLCSfGB?=
 =?us-ascii?Q?ObWF3h4SOP+8u1jb7csaf946Qa/4Zx7lkptXbWSdP+zRifeyCfOAs45I3iT4?=
 =?us-ascii?Q?5CoIY7RFVrGzzs6/4jTAH1dbPRGv+Iw4QshPjKtUzbC5MNQpT6v5YiKdIoZR?=
 =?us-ascii?Q?dkrSaqvszq89y6vsVbPOjNEsLXhlipuD0DzoWswmzED1jdaicBeMCwtZ7cy8?=
 =?us-ascii?Q?8oVnrNQVu/jbmxx5/UxWMWrSnSL3X2Bd4taePSEPpvNZUGNes2JDrfpUqA2/?=
 =?us-ascii?Q?zkxPIXJ5CRL6au6iQpbBxMiQT+r9hSA2Y+Yx4LFcglVvpzmvictpYdyoJjeE?=
 =?us-ascii?Q?T4YUxj0ixjIF/Tgq8SHUe3pYsmcRBj5f7jNE0S3lVoqijlIYhSxbx32Rmqq1?=
 =?us-ascii?Q?hxAbGO0znNurwj8af/kfVTKaArX0OlBu50M0Uawyr5csMx9MHKrCgWz6/BCD?=
 =?us-ascii?Q?ifa6GWT4HI9w5QxbAEQeAcX+p4fg52bfuY2Tn7y3Pk2mt2uVzYyuwQbxWdPs?=
 =?us-ascii?Q?hlIsqO+ISl3EtfxaTYmdnWeaN8Rs7hqXvd090ruVDMmGkiLc8NLrskX/csmX?=
 =?us-ascii?Q?4cMEFG+g7SO9sjUEfhLvcuBexi7Idvwt+6NvLloqUERztfhm37Z9z+sEWqKx?=
 =?us-ascii?Q?W6nxKYoZcwSrPOM87a7zRHjycOMOZAV1nP/67+THsTJP5iFscmCmnyU59Q4s?=
 =?us-ascii?Q?CicydmX5HnxyGVn9AxupaVMqZEd/q7FreKgIU8BzTi+v6zWd/ZDbY2aI4MdD?=
 =?us-ascii?Q?lZ5hjQZwylrEefQPc1Zp7d5JQnbc/Olpo/YRkFlAHNUuD/MCjY8rdwS9pCq5?=
 =?us-ascii?Q?gJtaLV3TDkWY2vkFaIVvMVxEUyFRdJ6ZEhGHxoKlzYMOofv2ht3ltJp+9sj1?=
 =?us-ascii?Q?Ll5uEZfRqAA1bpK/SXr35NsRFd7f/YmLi65r0/l0QaAH2dwtcb01h+55JDG8?=
 =?us-ascii?Q?rY6CHGw0v69NQhE1altsv35OmRtyPquFvY9rjMOq6dfgyAbEfuwO8Q3Zalcy?=
 =?us-ascii?Q?VrkxQrwQNR5kqLBB4iEoKsf/FVLd9VlfYweg9jbtmCTw62J7Yhct9gmfhggr?=
 =?us-ascii?Q?ki+QyfBZMnoLM0uwmLR2TwxzbXXxWElZV5xtfltYr254rAQbHw6Uhat4iyaf?=
 =?us-ascii?Q?gQ5U+wDM7gQsXjgbaR5yEZKb8unjYaeUtN8U5rC2MSByljjgyZM2Ki0RiHw9?=
 =?us-ascii?Q?ssC1V4wbFHReP8XhczbO+8DXW6xPG2CgNSTWbHYu1b8IQaYDymJ5J8oRMicf?=
 =?us-ascii?Q?gSlpWbmHPru5JougblFcILI0gC5YB9aPPXSCKQT8houCCFhBO/ylKpWvHfwt?=
 =?us-ascii?Q?X3XaqN7dvAHBPhYO/KVQAXBNUuszJ+TCyxGkvRwhnZ/3balCd/mNTCnUGlv6?=
 =?us-ascii?Q?SM5zUDT9vhixJPQVawfgLFxF0h2zTAoaCzI21FL+vwSv90h7Nhm1/qxBrDwC?=
 =?us-ascii?Q?/QiFf4jz11NPR7UpAveEJ9FphdiC8W1uIIXviOz0H+XHvtuiExEFjbSNrCYZ?=
 =?us-ascii?Q?lHWSmO12+w+XfA/9/Jz27NolV55M3v5NDpxy8gQfVOKQ/jnyPwh+VKd9v0Al?=
 =?us-ascii?Q?d2UntiaaebZIKbNQZZKxqCIp2i4vlbaV5Z9y0nyGENfJJzbmKpCbVoKQEAur?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hXasRlFS96lKUtGgiGT5opYq1J9X+t1EDX15GRdr5oQK5bpXR1FQ4UQ3CZInkshRsaADzTMojD7URmz6p5Ijde/vPoQNPiUNx30yTFiWwOvThU3YAeX3ufUwnErwQgR07oBcuIl0sdxQJOdZ1AYVINS5R7vQGTl/bVrCO30uWRPP+hdRWHvBZOilzJ0HhW4mMGz8xAKJbBt1ihOt3VTEnlUGN3NSZJqSmAUhCNxaBcrj6PDAoPrKx8IB1ctnWi/GCy4qRxpbqQ1/D9YIM1O5ZozdgV9lzUJA3UwKCqU6LtuSRtrRJkNcGelwBHtgBy16YO/bx+iXZdhK3yFXU/TPQoQCBIqXTkY+R268b4Guqw3Yaqo7OLQXTqkcs+FyCvtruLrN2jKBxxxHWQV0n6/jU1YPOZDsua00R7alkihQV50xZMMG7djV33Aks3edoCf9XJmGKnmUJCzyeFJGS+SZjGTxFONNNhVmpzYn4tZJjKwxJgKF2pVB9RpXqhSJ4z/zRFQjOm5ovuaaj722KEiI9eltOJ7dmX48vZd1r0q+qzZ8YojvFJkzcQlcvEOdcTNURzIBG3VxLCyRqowZ911ifq7TYjJZugTvAEIdIK4ex4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1eeba0e-73fa-43c8-79a4-08ddc5bba97f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 05:26:35.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuUA8LLgQm7LaiO8y9FW/ZXIgRwRqKXsxb8caWjcfkDsrWEZ0pskO8urdWwqu46exTybSb2hEMo1WFdkoURpmqNsimIGRgX9gESOZAJwOKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180040
X-Proofpoint-ORIG-GUID: e68Y4MI26uUwslGw0XNGHXXKpXtvtLoy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA0MCBTYWx0ZWRfX7y4r5FRPZwrH 3rb64fqC/mmMDoBi7ry2O8CvjFHZ1DrRD5nmOTpOKiFTmwQVuN6qgI3X0AcTtPAZbjhn04bEyHN EjCPS819icp68MmAzvMCLDSH30mFKxyHaM0SyT5bGO7/qW7LiW6uBtvQlw0Zn2mqFBm/7mDaHs7
 B6QFhrkRRgMOEdbJL4LNEdXpe7AflfNiTdI6w2+3cw1m2/tX3iFoAaduZbsqj8bWp0ZcPzN/Utm +e7Zb1DCWrdyi/rllljJHHaE7MKUlCWkxNhjgmsrscEQrKF3GbDQtsbMTOZXSfYQTNQyisbcfp4 OsZEYAvqSzpkCmV37Lyyr/bj+KVzz8ph4TbVu1ooHXl9cXhRVwcXG084oqak/HkPaTHku9fN/lA
 nd8bakBGgcQk1u9+HqudSioFOK7bQFiKJtQ/EVQqAxfiRYcPjmLXO8JQV3TgHJtNTXm8fm9B
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6879db0f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=JaL7poqf8t9DfHBwCtAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: e68Y4MI26uUwslGw0XNGHXXKpXtvtLoy

On Thu, Jul 17, 2025 at 10:29:54PM -0400, Zi Yan wrote:
> Hi Andrew,
>
> This series replaces both [PATCH v3 0/2] __folio_split() clean up
> and [PATCH] mm/huge_memory: refactor after-split (page) cache code.
>
> Hi Lorenzo,
>
> I addressed all of your comments except renaming folio to origin_folio,
> since I find that might either cause confusion or require a lot of code
> churn. folio variable points to the original folio throughout
> __folio_split() and using origin_folio in the middle of __folio_split()
> is confusing as one might wonder if origin_folio is different from or
> the same as folio. The alternative is to rename all folio to origin_folio
> in __folio_split(). That seems to be unnecessary code churn.

Sounds reasonable! Cheers :)

>
> Hi all,
>
> This patchset refactors __folio_split() and __split_unmapped_folio() to:
> 1. make __split_unmapped_folio() reusable for splitting unmapped
>    folios. It avoids the need for a new boolean unmapped parameter to guard
>    mapping-related code when __split_unmapped_folio() is reused to split
>    unmapped folios.
> 2. improve code readability and prevent smatch/coverity checkers from
>    complaining about NULL mapping referencing.
>
> An additional benefit for __split_unmapped_folio() refactoring is that
> __split_unmapped_folio() could be called on after-split folios by
> __folio_split(). It can enable new split methods. For example, at deferred
> split time, unmapped subpages can scatter arbitrarily within a large folio,
> neither uniform nor non-uniform split can maximize after-split folio orders
> for mapped subpages. The hope is that by calling __split_unmapped_folio()
> multiple times, a better split result can be achieved.
>
> The patchset is based on mm-new with aforementioned two patchsets
> reverted. It passes mm selftests.
>
> Changelog
> ===
> From V3[4]:
> 1. Split up Patch 1 into incremental changes:
>     a. Patch 1 moves code out of __split_unmapped_folio();
>     b. Patch 2 removes after_split label in __split_unmapped_folio();
>     c. Patch 3 refactors __folio_split() to deduplicate code;
>     d. Patch 4 converts VM_BUGs to VM_WARMs;
> 2. Added "mm/huge_memory: refactor after-split (page) cache code"
>    patch[5] to this series.
> 3. Added remap_flags to make remap_page() call easier to read.
> 4. Updated Patch 1 commit log to include variable rename information.
> 5. Converted additional VM_BUGs in __folio_split().
> 6. Renamed next_folio to end_folio to avoid confusion.
> 7. Added a comment about start for loop with folio_next(folio) instead
>    of just folio plus skipping folio in the loop body.
> 8. Dropped swapcache folio split check code from __split_unmapped_folio(),
>    since the check is already done at the beginning of __folio_split().
>
> From V2[3]:
> 1. Code format fixes
> 2. Restructured code to remove after_split goto label.
>
> From V1[2]:
> 1. Fixed indentations.
> 2. Used folio_expected_ref_count() to calculate ref_count instead of
>    open coding.
>
> [1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
> [2] https://lore.kernel.org/linux-mm/20250711030259.3574392-1-ziy@nvidia.com/
> [3] https://lore.kernel.org/linux-mm/20250711182355.3592618-1-ziy@nvidia.com/
> [4] https://lore.kernel.org/linux-mm/20250714171823.3626213-1-ziy@nvidia.com/
> [5] https://lore.kernel.org/linux-mm/20250716171112.3666150-1-ziy@nvidia.com/
>
> Zi Yan (6):
>   mm/huge_memory: move unrelated code out of __split_unmapped_folio()
>   mm/huge_memory: remove after_split label in __split_unmapped_folio().
>   mm/huge_memory: deduplicate code in __folio_split().
>   mm/huge_memory: convert VM_BUG* to VM_WARN* in __folio_split.
>   mm/huge_memory: get frozen folio refcount with
>     folio_expected_ref_count()
>   mm/huge_memory: refactor after-split (page) cache code.
>
>  mm/huge_memory.c | 317 ++++++++++++++++++++++++-----------------------
>  1 file changed, 165 insertions(+), 152 deletions(-)
>
> --
> 2.47.2
>

