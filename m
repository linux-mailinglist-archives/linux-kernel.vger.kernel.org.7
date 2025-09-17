Return-Path: <linux-kernel+bounces-821136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14EB80857
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403491C2530A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE2C33AEBB;
	Wed, 17 Sep 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGF+A8pv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOCEjtDQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9324337EBA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122721; cv=fail; b=M9oHu5vBKT77bjIzZeiqNJlnD4LS7VMihQwKyLNEYTF1e5J9rh1AYsJMkU3aMbi+fHMFVHD3E/tax7+SMyYN9KFpSzKwSpCe8BDSnJSbeSkcv8MKJCsmG8V9iykMDst+iHhRXzhavHbmmtfYb9N2KjMfEALxEjmq6+N3JmJAo9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122721; c=relaxed/simple;
	bh=x2ZkNMTFOWtkTucCzIr03TKjWftFzfXHckg3hFMZDjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hV9mWI6JkQwa9c0TUeiJH9YkwjWSU4aZhtiupipIsGiiKs0gzV/wet94dJ+FRMMrUgMi/V9phxfkVVf+X9VhH6PhFGr/rU3d8QUA+tqv7F2Xplmx36tYKxzVorGR+i3jhWvRMNZDl75g3/iTy9xVTrJ0Mv2E0+3+eC/LYsE7jQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WGF+A8pv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOCEjtDQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEITon007388;
	Wed, 17 Sep 2025 15:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OxdspWbIMutqWN8pJh5Q+AXIbRph7/kyYrDPbjDMMno=; b=
	WGF+A8pvTryJ7W+qheO13ZK/jez+2vF+qyzcn0BxF4+u7CJoWYp8IJ3wle0LwQg/
	bm/Vl24KmJaFDXcCwwRDn1mfz1TjcvY4jFj+0/qo+LBKzoxgToNrB19SsIJfLkpw
	TDD7CuyTbsCaRuwUUtrq/vSnK/dgqBzZl6BLKxONq0mMzxfarqpd7OcS2IQG8WXz
	mXgu5l7HAGG6zLu9MzXetAEMzXIbHdt2Ut08eRYsiu6obm6XOLVELdH1Vhb9giDD
	4Qx0XUjzB/UC9iuDwGoaUtoptLlZIObJLCXLZ15nGZFnJecpJD3WTnsiRRxBu+KF
	qgh0z6nv+69BHzdJZmszuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx91gru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEfejg036779;
	Wed, 17 Sep 2025 15:24:29 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dxu57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIOZdtQubFtCHizBnM3AziTo9sZC1R5V6VCuqznLd+r7EzrQhchwHvBPXKta3LQBaN7s11qrC11v2NJ3x1/1Z7FvUw9ZI3QelMDcNcKH1nol2At0CzKn3tBJF8eappLBcq38Xtx4Wc3AC2aPwRmZFic2RupYV8bJbT+nbq7AfKoWNdsnMfWrYQFCqxXnMaE/acPY1g0VIyzat1LPekxUfrChWt6LbY+c4uXo4VHklmVqnczJ9Ul6x/vdUAabo4UHeCfWwqdIr6zwBbFeASyXbAIZhxR+Q9P6NbQRqbuzZgFpVKuisEhURHSBXyZeiqmd8bsZLCQHc+t8OcwQRzt9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxdspWbIMutqWN8pJh5Q+AXIbRph7/kyYrDPbjDMMno=;
 b=zMaab6zKt/FkBPXntnxXn9aS4fLds6IqdzAfniSEprwsjrSeBVEWRoiRzWeF8CbgH70xo2il0WxBtLuEMSQwvttiwYa1I5KUj2joXeoEVZRkJ0xqgCUV9TQ2MRCaOd8ZO49cLWVTtySXD57Hl0Okd4isEUIQVVzLuJjJNOHsHWRPWgkIdOtuOxbLxhsHlfSCWdYK2dPz8wUFdy9gJi5X2+wPTT3uXzmdxOZndT2P4dW3TovYKl/i4xDGKNt4jIma9tBFkjW9+QrpXKABBaqCrtjnFvLAUNKeLnpObJfOSfmRnkeZ3z2cwYqTxrvoboiyrfv1p9XlYqUAwwwApY3DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxdspWbIMutqWN8pJh5Q+AXIbRph7/kyYrDPbjDMMno=;
 b=bOCEjtDQX/ikkHZ6zfj2iCOak9FX+DZIdurRB55gt9ZQhBwwIeyVkz1g4tQoda18YS9oJoMLCINKis9aWl+54SVzYcKc0/KDKp+b6GW+fIvjE0H6Hih+lhpuW7PRscNP6RsAkb/IZxA/jyfpJdblxQ78QKmAVAPwZhp8dTUuq3M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 15:24:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:26 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 03/16] perf bench mem: Move mem op parameters into a structure
Date: Wed, 17 Sep 2025 08:24:05 -0700
Message-Id: <20250917152418.4077386-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 955aceef-cbc1-4d03-cb0a-08ddf5fe497b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkT29w/7HoriAveQSJ9mS0K8XFIibMDwk3pMEWi7B0YLKsjsHlCBVMbirBuR?=
 =?us-ascii?Q?40K9MNA2u6HhwtOHLzcTklV4gf/qr/rvp/Iv3Fqu5gDGD/458bbMfG2xRuSz?=
 =?us-ascii?Q?jujTNtxqn1+F+BuL+ON78Cm7HLviv7Te1qvFRIFdmg92HNkZFcbczlbaPKbQ?=
 =?us-ascii?Q?sLWUECHtbKW9eLo8J+dejhqhHOHjjh5s1jp4/xF80b1U/TjekekTGXCX1l4d?=
 =?us-ascii?Q?UrdgQo8pISiUEOCrwJbY3TKSPKivM2fQvd2ljbbUnrjCwTPphGAG4LH4YlFc?=
 =?us-ascii?Q?7EUtQPA68D7d6wkDBFMXwKEsJhL4COEGzX0MAcAy9rVMizxbPNNz3b3TEKdR?=
 =?us-ascii?Q?6UqZDcDgL+05Km5P0F08+3qQgMsnU8LLWwiqKz64vrKHgUVoQj9nKFpYqEuT?=
 =?us-ascii?Q?qKww3/oiR3Qu3DTr611gbTvtW5uoV5MOccesOMdqfsGwI9OBSFpRg8zIjepr?=
 =?us-ascii?Q?KdRB+1sMEwEXWdy7gZzhxaUP/u3lTAfHwuO5ocq0AlV9F03ywt8sicsPSPhO?=
 =?us-ascii?Q?/+jlcD+ECjQ4Wyzp9MJtdUpcfihw93xSainSkwpgnDIPpLoRxZbwYWGvxPQb?=
 =?us-ascii?Q?XFeSaNzRMEj9lUcGlDssnLcMhPqfdpmrWbjoo8uJD6AFcijgzaHaYBNypGPa?=
 =?us-ascii?Q?WN/eepGtyw2a497PzsT3q1QbMtK0vwrRH/sPh8Yi9uKe8D6CLs4G1kSCaSuy?=
 =?us-ascii?Q?CloS2lCJ4/OUAVcxBpJ3qizWzaPzZCvti+8evqpkLpIHOcn3JXgWRdXZlcqB?=
 =?us-ascii?Q?/1UNVXfSAnfGCVD6l5IUKSWVJTbvuM8AZDTDfAiN0KpG7O5ynuFoQanpWYzz?=
 =?us-ascii?Q?kmn9olkewfI6T9mwhy2M1kSujpj0WyVxo16snhzeuKBWqmspxCVssfsx1S90?=
 =?us-ascii?Q?d0DQvRLX9bgQ3mhnkyZZ+gzFMf6RL1SDqj5O+HGPaYo7wvi9C1NnJPtkdOGk?=
 =?us-ascii?Q?XKVhk+eYH3j00cfw2jcJXhYlT15joXcCzJm79nxeIQeHa4kSSGjO8soG7Uy5?=
 =?us-ascii?Q?uXQPQbLsQKmQwwwCF3r6lUKZfpl693NmAt8AVner4XZOfwYBoTjs6Lo4+8S0?=
 =?us-ascii?Q?mSmPk7qobrUQRMNUCWDvkf6keebjg+3TV9dHeqr1PZPeUR+LSNXo/tJtcKtr?=
 =?us-ascii?Q?jZfCopRA7kTT7Xik3sCLsBx2m2qGB1XKpOtPDNcnn2cK7KmTsVgtSu+JubbH?=
 =?us-ascii?Q?ibe+uO72AmjiYQPOSXHj7poatlg7NWYowc9GaSuguPENQM3xFyW4759BXVxQ?=
 =?us-ascii?Q?wUvgxqzs/QphUft06fs4RlU83UP6aers1gbgt+rojFoBD5Gk0SiITQknxTM9?=
 =?us-ascii?Q?E4IM01kI6uTD8kK4O3ck6nD19n429KQCItdw8xkwqozVP+69OhFe1qn0/l3B?=
 =?us-ascii?Q?gQkgRo70MlpLfqvUhG3B2pACNnKK4A8nqsC+Zb1GuRsuvgCQWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jHBO+gcHjIoGO/2lWG2bfPgZm0Cv6QPW4iGmvp9VM8+W+0jxs6c67ykDN/Ih?=
 =?us-ascii?Q?4SlW/bSow6HxZnANgonoMsNu5ku44/XICbtMDUe6nyhszuIFYq9VynkqugZP?=
 =?us-ascii?Q?hxAcJRFjEMulYzSf0/57B665UlnRmSNqZp+Hh5rCuNgbtjvrrn2WsePUcJx4?=
 =?us-ascii?Q?sSD6/zb4KOJppRrynMT0IhT1sjMBLCEbm/1+dtvNnSerZIljSs5upBsG8jTh?=
 =?us-ascii?Q?L58d5aUleySdjfJKkrJ1116yPhSJoiVtK96EVkvvb94yoLKYwBsngUFQDzc6?=
 =?us-ascii?Q?fAcAJOnHTLYZTFJwt3qvZTtH50UjLF2W/Pi/1ZjehrxpoLbP9/w7g41zxpmF?=
 =?us-ascii?Q?eq3HQ9wBFru/YJFQAok4htaKpNo93xn0B4JF2PQNucxSXeYYgpo3y3+wdyn7?=
 =?us-ascii?Q?t94x4FJuG1xite89vLCryTpqd8xtSAkonOipUTRQfb6cDk1YoXsskG3GAtPg?=
 =?us-ascii?Q?Hg9PJRy8wVePwPElNkodsIEp97JNNRoU9igSANyL0hHWo6sHNiVdBNq/CA/6?=
 =?us-ascii?Q?Pq/nvnAkVglyX1/wUR4vihBttXSDO5dwk7eaKFK05e9Og468M6HOLYOZ6t9L?=
 =?us-ascii?Q?k7o4f87qS4738xu/+Pw5Cyr4Fy7pqM62QEfhgdPRju5rnolv7kvP9ERXAUo1?=
 =?us-ascii?Q?N34XfQ43sfzVyv2dsyHTo4S2hL5coQNivQmHes3Az+2sZhsycD+fSWCxohgy?=
 =?us-ascii?Q?TKwSGY/8GeW8M8p9Bwjpqbpzm3X41W/MCaZ4hYFLmP+PspdBTMV1Dy4gt0Tj?=
 =?us-ascii?Q?wppGZm86tvJUfOhVuVABEG5WQdhvoe5kc6YWQUeXc6XnOdKflYAtuI9wlXSe?=
 =?us-ascii?Q?Kfl+HZe+SG6uFzCVOREMms2NoW+18VAQiQdUsUYilHj0TSmDdJvsQTc+RGLM?=
 =?us-ascii?Q?o1gcSujiYMudOnIhxvT3aHHSv++HcbKRx/tWHAcbFsZM164PFz6gZZ1f9Uz6?=
 =?us-ascii?Q?+8FWNdA6GFM3RvZ/KZVuIZWcqOB/0APXaOb41mvQirrzf+qwoTKK7tsPK0hC?=
 =?us-ascii?Q?GP1qgg139ZjA1hLcCzB94iknLqRLMIPswRSn/B1a+Zr5JhmhFsFGIsKDeM8D?=
 =?us-ascii?Q?qU61eosKMIrwwetQmIwAQK9vC4DDdekk94H0EnDAYSOCZG0hpXpTarJj44sj?=
 =?us-ascii?Q?jlDwFvxmcQniixhWM0GHYky0YyjVspjfwZbUXJOAURM1Y3MKGhWMRK/AKZf4?=
 =?us-ascii?Q?6Sz5zpFCzJa35AXZ61+eP5hGncaY0B922aOPOfn7JJwNMYwygU3gqesjtyyl?=
 =?us-ascii?Q?qwR8EBykOt40zcoJmj0HSE+ROVk/6qWrQyc2IbXmwW+MCqP8lgezvmFaXISS?=
 =?us-ascii?Q?9+AnVTPfMlWhWqa0U3/MpiVdf5DdExURzihdrK3jc32eFOYyODqMSqCu1okp?=
 =?us-ascii?Q?4UbaMyrDY5BuhltsYcnlksOb6czlhSmAQabmmDNarduNGRXDYu+23Ei4LG9O?=
 =?us-ascii?Q?rP+2WL6NQV3UXcWnwBy6bjiPk/SOob/ZRmIo2Da8ArEfurdmY2cguXHhhFsi?=
 =?us-ascii?Q?oJK5XZAE+JNKEObk4YRHjIF6+s1PuGR5qyAlfKB7EPZmmRya5lZxAmnC6J7h?=
 =?us-ascii?Q?UX0K0kjOLPVMo77w/fnMRmu+KG8jjNoyBj+TUnFAkhy9TKuc7UPNP94H/QGC?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SExQ6kPp7N2JPjvfIhY4381s5D7iOj7ayWjDcCOrUVkpGVFbtCBYE9zcVKMB0GHccfIwYt/JSFtzZMEKBC0lTy2GVHe4bx4CM/3rHLdmc7C9rXSoJP+B9r6yjPcyVmMfTmDs/zRE83jB2ExYI8MoNNOCq3yOLnWyxs5eg88ApuRjwa2ooIsOgJ+NqnNzz9qWHdyBkP1gnanM8nFxAT15MW2MBzGP8qRN5nRFMkDGLhcYORy4EKkqWspRwaWkQj1dpK5IyvV1o8VDIsp8wUiTr16y0QDpLsT+NfxWNSy9MDihZ0jMJu/IiEGv1OrgQZBpo/nWaM7g5lE3DlYyenWLXO9MrDtggFdJ3uZqDufUneV3XYm8p4efXS6HrOyy3o+kaWrOGjpZdgatL5j/bwf0NmBO9PVtXNS82k2wTCZDtFci6VP1tzPKSqZnIDC6b+khq4KSmoFzdu1HtkxuOFrsYuzYOdzbErGwtmtA6pA2QhJeYz1mmxVBV1YqA7mH/31GogDa58WMS+pbDZlxLDjG9uE/ycEgbySWLyxPsYwdN9FfGtei0WMP42/XvatvXuk3DJdBBCHOhq26erbucA23efLCKsAmor7BnGtKCeBAJ4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955aceef-cbc1-4d03-cb0a-08ddf5fe497b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:26.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MaOOyRLhlXSiTrWsKAaS6J7YAY7iu9FfCNWTj8AqpZA0yfDT5Qb4NB5sHw5mDDAp0uR+/8BKkU26lb1u4FfhdMbAhj9s589etDLoZbKHOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170150
X-Proofpoint-ORIG-GUID: u92PKdB_wlvHFgxYftfv13BjTJwiS0dn
X-Proofpoint-GUID: u92PKdB_wlvHFgxYftfv13BjTJwiS0dn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/3UGkZqz16jx
 RIUQtl6xY0I1aj2Ekk/En8kbSGMvDOOTytgDkE2zNC4frlWQwcOV5OUD2wAwXtLVRyAyMaZjANV
 UBdKa4RGbX2O1fhiDgxBOdsnwM7LPeEaS/Tq9Zwq31JwMvgf+8KiS9XyonBPUxRI+B04qnXvJ8U
 hXRmJWu+kGcXLE70nDZ6D07fn2i0MuD6brmjJ+ygt/ovwdbbIsUBeJeVon5LbmNLPOAPpZUa83g
 kZCVimdeokDn1+vdJ4ezvWsgHRRadj2pL88dQ8kXCcHXFM/9vXx+gQ1ycVtT5jyTsJpb6grh+Ko
 LMvXwye45/5V0YpCoANDU9wTYnBqAxU3jNhL0GdewbqObRA83VY37jtIcDkrFr6D9jZGFD8NQM4
 7025scP7pol/nVpBe8CRPJPDBtVDKg==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cad2ae b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_WLpKjk4XQ775Vi3V00A:9
 cc=ntf awl=host:12084

Move benchmark function parameters in struct bench_params.

Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 62 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index fddb2acd2d3a..4d723774c1b3 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -30,7 +30,7 @@
 
 static const char	*size_str	= "1MB";
 static const char	*function_str	= "all";
-static int		nr_loops	= 1;
+static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
 
@@ -42,7 +42,7 @@ static const struct option options[] = {
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
-	OPT_INTEGER('l', "nr_loops", &nr_loops,
+	OPT_UINTEGER('l', "nr_loops", &nr_loops,
 		    "Specify the number of loops to run. (default: 1)"),
 
 	OPT_BOOLEAN('c', "cycles", &use_cycles,
@@ -56,6 +56,12 @@ union bench_clock {
 	struct timeval	tv;
 };
 
+struct bench_params {
+	size_t		size;
+	size_t		size_total;
+	unsigned int	nr_loops;
+};
+
 typedef void *(*memcpy_t)(void *, const void *, size_t);
 typedef void *(*memset_t)(void *, int, size_t);
 
@@ -134,17 +140,19 @@ static double timeval2double(struct timeval *ts)
 
 struct bench_mem_info {
 	const struct function *functions;
-	union bench_clock (*do_op)(const struct function *r, size_t size, void *src, void *dst);
+	union bench_clock (*do_op)(const struct function *r, struct bench_params *p,
+				   void *src, void *dst);
 	const char *const *usage;
 	bool alloc_src;
 };
 
-static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
+static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
+				 int r_idx)
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
 	union bench_clock rt = { 0 };
-	void *src = NULL, *dst = zalloc(size);
+	void *src = NULL, *dst = zalloc(p->size);
 
 	printf("# function '%s' (%s)\n", r->name, r->desc);
 
@@ -152,7 +160,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 		goto out_alloc_failed;
 
 	if (info->alloc_src) {
-		src = zalloc(size);
+		src = zalloc(p->size);
 		if (src == NULL)
 			goto out_alloc_failed;
 	}
@@ -160,23 +168,23 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 	if (bench_format == BENCH_FORMAT_DEFAULT)
 		printf("# Copying %s bytes ...\n\n", size_str);
 
-	rt = info->do_op(r, size, src, dst);
+	rt = info->do_op(r, p, src, dst);
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		if (use_cycles) {
-			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
+			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)p->size_total);
 		} else {
-			result_bps = (double)size_total/timeval2double(&rt.tv);
+			result_bps = (double)p->size_total/timeval2double(&rt.tv);
 			print_bps(result_bps);
 		}
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
 		if (use_cycles) {
-			printf("%lf\n", (double)rt.cycles/(double)size_total);
+			printf("%lf\n", (double)rt.cycles/(double)p->size_total);
 		} else {
-			result_bps = (double)size_total/timeval2double(&rt.tv);
+			result_bps = (double)p->size_total/timeval2double(&rt.tv);
 			printf("%lf\n", result_bps);
 		}
 		break;
@@ -198,8 +206,7 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *info)
 {
 	int i;
-	size_t size;
-	size_t size_total;
+	struct bench_params p = { 0 };
 
 	argc = parse_options(argc, argv, options, info->usage, 0);
 
@@ -211,17 +218,18 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 		}
 	}
 
-	size = (size_t)perf_atoll((char *)size_str);
-	size_total = size * nr_loops;
+	p.nr_loops = nr_loops;
+	p.size = (size_t)perf_atoll((char *)size_str);
 
-	if ((s64)size <= 0) {
+	if ((s64)p.size <= 0) {
 		fprintf(stderr, "Invalid size:%s\n", size_str);
 		return 1;
 	}
+	p.size_total = p.size * p.nr_loops;
 
 	if (!strncmp(function_str, "all", 3)) {
 		for (i = 0; info->functions[i].name; i++)
-			__bench_mem_function(info, i, size, size_total);
+			__bench_mem_function(info, &p, i);
 		return 0;
 	}
 
@@ -240,7 +248,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 		return 1;
 	}
 
-	__bench_mem_function(info, i, size, size_total);
+	__bench_mem_function(info, &p, i);
 
 	return 0;
 }
@@ -257,18 +265,17 @@ static void memcpy_prefault(memcpy_t fn, size_t size, void *src, void *dst)
 	fn(dst, src, size);
 }
 
-static union bench_clock do_memcpy(const struct function *r, size_t size,
+static union bench_clock do_memcpy(const struct function *r, struct bench_params *p,
 				   void *src, void *dst)
 {
 	union bench_clock start, end;
 	memcpy_t fn = r->fn.memcpy;
-	int i;
 
-	memcpy_prefault(fn, size, src, dst);
+	memcpy_prefault(fn, p->size, src, dst);
 
 	clock_get(&start);
-	for (i = 0; i < nr_loops; ++i)
-		fn(dst, src, size);
+	for (unsigned int i = 0; i < p->nr_loops; ++i)
+		fn(dst, src, p->size);
 	clock_get(&end);
 
 	return clock_diff(&start, &end);
@@ -305,22 +312,21 @@ int bench_mem_memcpy(int argc, const char **argv)
 	return bench_mem_common(argc, argv, &info);
 }
 
-static union bench_clock do_memset(const struct function *r, size_t size,
+static union bench_clock do_memset(const struct function *r, struct bench_params *p,
 				   void *src __maybe_unused, void *dst)
 {
 	union bench_clock start, end;
 	memset_t fn = r->fn.memset;
-	int i;
 
 	/*
 	 * We prefault the freshly allocated memory range here,
 	 * to not measure page fault overhead:
 	 */
-	fn(dst, -1, size);
+	fn(dst, -1, p->size);
 
 	clock_get(&start);
-	for (i = 0; i < nr_loops; ++i)
-		fn(dst, i, size);
+	for (unsigned int i = 0; i < p->nr_loops; ++i)
+		fn(dst, i, p->size);
 	clock_get(&end);
 
 	return clock_diff(&start, &end);
-- 
2.43.5


