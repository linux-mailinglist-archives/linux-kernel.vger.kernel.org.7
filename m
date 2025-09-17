Return-Path: <linux-kernel+bounces-821139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C226DB80866
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CAE170A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2833B48C;
	Wed, 17 Sep 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fiZd8mcy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0AgBrpI5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD633AE83
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122725; cv=fail; b=JFEy+vjkuTVnNRiv8lBTplXAhXmThmDsDp5Qu1woswulFRvd0OwVYsjoGQWFuz8UHhFhZtumQTMiU9vzo09ot5ZOtYE4w6hF0QbfMKm2hvfYjqOM6vaT9Bhdv2d6/3DYp86nl/firJeWXO9skqUvIaanXN/QbVUcMtK+chqpRdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122725; c=relaxed/simple;
	bh=C9gGyPPyWIv+0iB5OBFf5pZQqz9LECm86ltUmpBqnzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OG0Zj9kPTd+HxXFFF2+dkEi5qGvm7SkJObC7Tj7ih8bJbpzNHYF+uFAznN2olzJ3b9QpsYvXVFiuR3oqMZw+qiR7EWICdhQXVXk2XmjScJgCXf7pOJT62S1Iz+D6Cm5A1Ta5FQbVxduWlt9jgvi/TK817OtLRDh5dVvJzi3PViY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fiZd8mcy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0AgBrpI5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEITIe007394;
	Wed, 17 Sep 2025 15:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KFLYSFGZD5yBxLlMBY2/zl33FiP/qx6R8CwaZA8JDWA=; b=
	fiZd8mcyHqGSrlKGeWCe6mm1TnieYWaLA1qrQYyQPwR0EZB+YE66266KN+Uy0POn
	idmhs4c3AF5Cic9u+ngzg1s+fiKJhVf2U0dR0RLRiW9LaOXs/0Wry0IMKG39qq5N
	tsjuYiMb49bXMTPUwynOEy0qAa0BUYAafmfPdjiwt0kCUulkjn7l3ET7eUwhw3+D
	QefRkvVY49N3pw9MCbLudWUHtwFSWiV3kVZe6pRuXmoVwd+IHvOewUCTcXoBnUXf
	3X56JeWObKvzkw5gSrgKRMyag+3gTnyoPGJZU1M+COue7eB0HD/KCpZAa/6X/AX2
	tBF8AW6IZTt70dEeQYZmug==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx91gtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEnin8036777;
	Wed, 17 Sep 2025 15:24:57 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dxupy-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgNTSL/Kzk6FKYUHlEQWo6yAUuu1X1Sv3zSuzbF+c/3ngsxa+ktb8q+pdRUezxoIKEzLKWM8N+EI7DipceWmMXe3L02r13hQrrCFNLRDiu/5lLIy8Fv8dXWrLWhybsPVMh0qkvgzTdo7Tqzbu3qshH4z5xOnJOhyH24xYf74g/Gr0vkQ0UTSwPwEh1FREHHgahxZYKz79+PNTZBRs1ZNjrUUZZ9Xzc2lY4QRgurU24kFXTDGekQaqLEyewUtWhKlY5/RBt2tVc5wBA7DPHKyx/YTv4bwSJaPGM6tUFbPqPTxbrlK8b4Lvq6VnbAI8xJHXFXsv9Woa2k+t6SyDqfZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFLYSFGZD5yBxLlMBY2/zl33FiP/qx6R8CwaZA8JDWA=;
 b=Jfuo+PkdhgMUXViR+uvAXcUEbB0CZkics1QoVRucz0KgXAuZKvTpmOQOyofsc/u6Ka+sxq6S9ZejjpuVWVOT+9k9IyOPxZIQDNHdv0qqjZ/o2I0jcGAZ/AoDql3renmXIBzVHqDUT6REXXcVP6zgcddc6BEZsLkJjNgGy/c7ZlzmgvALSWztu3e4J/AZWxE97sq/s6uOK93xK+u7bFyRriN5HNFEOJ57ExglCsxP0go8eoxcgImoSTgap9xRRvAWJ50o7HZ1fxiaEfL8eBFuUj4xV1EsTjYLX4rCoCBpT/0LC+rKiAc8CSsM+4Bgi0CNIIzKQelaGYH6Akkl6ULjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFLYSFGZD5yBxLlMBY2/zl33FiP/qx6R8CwaZA8JDWA=;
 b=0AgBrpI5x4DpvZfi/paMsjlM4QhwiUA6wl+Ttq2RwHThvX3izJTfz1TX+aJ4zy1NSXCViJMzN2CYSzQKlqSWtaO0c6Dd4pzWC6XsKdyD6pVGdtL2bLqg8Qa5qvAEBOxDAxpi4KHSnACMToxV9SumbfksFWm7bQsvbbHq540v6yY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 15:24:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:32 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 06/16] perf bench mem: Allow mapping of hugepages
Date: Wed, 17 Sep 2025 08:24:08 -0700
Message-Id: <20250917152418.4077386-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: f73044af-d5e3-4a3c-e6f9-08ddf5fe4d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zcOVKhciC4oMEy77lyNzCHV/lOt2Sry5kTK29SpN2S0nukeyx3q+O4GHWSfp?=
 =?us-ascii?Q?4dISBNPK8Zh7OvLX+1MGM+Bv4YuY6XQkogifP0laORIqbv2TgYqGrVGMl55M?=
 =?us-ascii?Q?cpIOGkODK4B1rCKTVkes81myH6MD0xtMP9OVb5A45qRSGctsz9bizKOqlV4b?=
 =?us-ascii?Q?cwJ/aDmV1Z3L+NhnmaPFdh+0Ceh1KzIWdUB6rK8zEYkXim+Ktj/sl5xuk7EP?=
 =?us-ascii?Q?FvJ8XkP21Iyf5nmU1YxHidVZmnRLseTB6XTQxJLIymwG324macF6SKna57c5?=
 =?us-ascii?Q?BiDF/Hk36xOX7XgVj8Ty39Oj1ktar8TF/0YwTsRiKfkR58ouxO3MnxnX5tdi?=
 =?us-ascii?Q?m2gV366ZW8XMvBzXcuKsc7NgxU428JstOIV/sNb5j/x1hBcCjAFM6q31tJbA?=
 =?us-ascii?Q?zfQCs4raC9mGKmTvZZ6aX9teN5wD5waa89bzpkDC7uF6/YVai2Uxc+Hs7AUG?=
 =?us-ascii?Q?6cgWa5nrmydLVZ6kcRhcYrdU5a6hz+42MybVaz+uC7CZaPADcB5HfWc8M0VL?=
 =?us-ascii?Q?kGSsmy3Zspq7Hlf7KkV/IjxgTbpOoBtSfF9vD5BjzaGdqBA6XdAKl6puhB+c?=
 =?us-ascii?Q?gAxKrK499zpq2okYGaCqOGjfm4CXclN9YavJ63jQe7GVyvncUP/e2eku/9pW?=
 =?us-ascii?Q?rTjddigNT8SK60JVJ1oEarNsC1u8lPtjSact6QQOxpUim8+bi5h/6HehNzFu?=
 =?us-ascii?Q?KwUStVPj1KaFJn+ac4wjsbjOM+SF2kc8xNfPeQqlLSkK1kZY3ukDPYnBqoQN?=
 =?us-ascii?Q?GDUDa4UoR6iyNDCLQ8WDWUwisce7z8lMx2+63myL5sIhy0GVnRDEVn84xtD+?=
 =?us-ascii?Q?5UtGVlfLVunQmD29Wh7AlzFSN+Mo8aJOHobVN2foGkKcWF5gqnNWTGIcw6A2?=
 =?us-ascii?Q?qzAl6PVuQQBfkiM53As/FF7IfyCChol5ubyTxomMIXdCv918aYL7XAyDvzY8?=
 =?us-ascii?Q?AVTV0vz0tkparyY7fy9FDys3KNxtlT5WbBXbIAkBTUZinGprKClQAn8JbOpi?=
 =?us-ascii?Q?n/nRj1LtDagwDPZo9leAQJiWmjD2AZETMuJ+8R62G6eUo+DH7+k/EDk76MkL?=
 =?us-ascii?Q?ogceKEt9WHDAZ16myClKNZ3vYJ0LQl0p9RN03lpSjv6HhLCTj1QFnbWMDFiS?=
 =?us-ascii?Q?pueqLqD3EcPu5+7qNoV8aPzSqlGZQMazIvcWfvQKoMP6sL0N57lR2gxHeLWA?=
 =?us-ascii?Q?rfHueKOL4Pizw2UoXyCFAT9teFl3QJiLGB9miKAX+iyT8MnXelRAzbDmKf49?=
 =?us-ascii?Q?UNTcdYdss6USaRldUs6+HS+3soBwOeEhvFKa0f7rW2XWxiAYg0kV6JeWN6SQ?=
 =?us-ascii?Q?t7GWQT/5RAu/vKURvWic0D3tu7lMDv3F+Xi79cSFm7F5ztDVcjy2PzruwjVV?=
 =?us-ascii?Q?Wi7DjAh80zrjoLpR2VZ5Np+3ev9uyf9DC3CjAprkrOWcpjilDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TVyEA/jWAv9YF3tX3Htplvu5yF1OJL71qnaxzehedpLdcYHmM/0LaaxUY6+?=
 =?us-ascii?Q?uLkOBNc+z4btL9vuHexfiHbu0HFKuQK3/Daa885i2tBz4j3eJl3z8stPnKVL?=
 =?us-ascii?Q?JKrvN6qfS3FphWINb9kB7LZLAyHmMqDC9m2Y1ZIzqTuBpXyg+3jv6HTTffud?=
 =?us-ascii?Q?ORXU3HkWVpM95j1bXEK3VDj553raAdFanNw91lzCS5QeHU1wQty9wv/wtmgQ?=
 =?us-ascii?Q?OjEYy8v+FbFP4l+faO8HAtur4pJJcmmr0Tq7z2DdCmOf7XXZkySdRFfVQKsA?=
 =?us-ascii?Q?2skUZ5+Xf50579NV+kIb0kzddBh4ocgAkMmAkr45V0pN0K4weMcSYv6B5Dem?=
 =?us-ascii?Q?0/zevwsJPEt8JrHHMcJdX2Mbb/SM92Q2tfH+nVM2grh/CGI3td23mzzjRKef?=
 =?us-ascii?Q?RXlQWdKGW6UDcT6HSSeJO/IvlQcUMphxTvGXnGbTSRkF01e6ZlQHq0/D9wS5?=
 =?us-ascii?Q?fgoqRfMW7azloJ/OWlm0o51siJRbxflRoYTiJQWROXzzBS9h0mTLbYfmffsy?=
 =?us-ascii?Q?4KhY4lFdX61mQKB+Mm9o0VOWuHtUqN/HWQ0i4OjVmfLoe//Q7kE1/GuUa9da?=
 =?us-ascii?Q?5ihXx9toInlcW/HndK5v2WW9skpWLDCIAyTB3gkdrsRmsDbhmlHMLRUhGdEw?=
 =?us-ascii?Q?iUkdlHusjLqECEa2GhKZcZnkFMOirvB/IcBxdFtbyLKLt/e6HUrG0MqLxUUw?=
 =?us-ascii?Q?dc81RlHqE2wOOJJOd0II4s8xz1hTXyNTZlbiECr+H+CGa0AKPmBy0KPvNPqN?=
 =?us-ascii?Q?JAo4LRYbZwViN5QqMBxdjjm0KPb6LO6VjS4NdsFSQ1BkrhgYG2DijA4Il2g0?=
 =?us-ascii?Q?9JG2XnNRsmgtAERkElT32iwlRiZsZiLesUfaBDSHQPkdkBuyIvk635fx5JdA?=
 =?us-ascii?Q?W6ed6OSDgQfYAfC/TSwdmqKAyeGHXH8pkXhB2VwqqXvVudPUjhhX/CD+d9H8?=
 =?us-ascii?Q?7dvxAvKCUG8L3nrZ5YiwOdW1DxzJ0GpOaCu2RA4OePgN5hyqW5p/Q0aaBGST?=
 =?us-ascii?Q?3JDf9FZWNDa+G799S9hzbxewNgbEMnbcEsiYjG8L7QcQY/+90RweIb92nWbx?=
 =?us-ascii?Q?r1CY1BFTwb+eI1FmCK/ExnTPugjSHP4HcUkCU3RXrpmP18tdii1mCShSvfxx?=
 =?us-ascii?Q?ZbGbLD8V/tc+MeU1BtD5IAc40ncsMswcXOs4a1wFRxVU6O9i+qXG5fRUaga7?=
 =?us-ascii?Q?aorQs1ebEnW2u3jNuB9LfVSO7UZtfCp5yWkWYYdtadsAv99aMHq2Gg2J5kXJ?=
 =?us-ascii?Q?rZr+RRiVCiK67+ZB13MquK3fgK816jx3CgnxT7Ss/V/0ibiUU4WoFZI237yq?=
 =?us-ascii?Q?1ZGlx/mOtv43uvhMF3dDT5lEMXrZpMiTvePoXQoTBdDjYMq+UIJXVUEi+28O?=
 =?us-ascii?Q?wAiqcEWHcvOIhO2W2TaaA4hiNwsLBA8EMgmi7V3bVMkvx0RyzDS8JcssNvsn?=
 =?us-ascii?Q?FuU877aG50/OeWK+38nfNv7F0jJf6JEYzlBKdXiJnpv2x/7DbRyduXHBlIUs?=
 =?us-ascii?Q?ZcHko71nqb3ufzSfMACs6fHJhRi7Ob/+k0qIycFnBMdEvjw0z7lMsEjEJT61?=
 =?us-ascii?Q?A0XObV6c6v11v8X/DykLwJxECmOc3KAVTuWM3TNfqFYScc2DAwkWXCcK2HCZ?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x/mbVVa2+cAjJmR9pLAUFcMs222l3SBMOkKMFHB5ljddymkbm6bDnaXrZ8SRp41qbZ8vXaOIQIxC9685t4eDSe4Rbd+Z8WLMH7O4MxkxJIODc2mg9QRAw8qVq4cueaeaVwq8Bb1MNv0xYLSi251Yzz0BqwDxiNP6kH0J7f+C0Bx4XdDzbJszCPMvvMMj4i3FkkXHyHJiZMzNiPYto7nMmO2TFwPSSeUbHT18lhfgbosCgKj095YZjs+LJq/20kdeUh4LWIOSqQFxV1NCsLZr0iTzDE3rbrwMzzlPF6OHvTendmded6RFK0fRUz87O4HXaDioYSKMRjtL5jHjFL82LIKCy39R7om3iKtCr/tbzANBorpi4WQh6GaccU6RI9E/aKbXA5Jd4FJEX60/+TzUz4paAorrIlXrbtZBn67mS2luh1WVZhqVUzMz7Q2lovlpkizYeRrnlSJZhG97Pc3Ot9VItZSMT0CRyDzCuSvYXaXwLImca28mqyTS0c0kcr80MAH5WiXJKr1h7yJ+msdfKFfUWVgWNdE+jMcaq03jZY1pthMSD3uDnvA2K6Y9h0QTnhdyMJ8F7UzZ+UNtcXU+UgRFaYW/sc5TnJ2i1Pgh12E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73044af-d5e3-4a3c-e6f9-08ddf5fe4d56
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:32.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/0T75Ep6NJ66wrzG7YtFB8S93blyNY6ucOTyPCh5iBGaq1xQ12yAhZQGugS/OdGMsr4YfYcKTM/UP0I6YNcFkUm+AKVCPRpa49Ug4YGD+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170150
X-Proofpoint-ORIG-GUID: jqodXdPgOcXxKsxD_sZxbA2oZWQk43vz
X-Proofpoint-GUID: jqodXdPgOcXxKsxD_sZxbA2oZWQk43vz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0cYdvJD4hVBO
 HSnu83Z6eU5PXOkcxufGnGfgnhdJusYotSiOMlXKINKyD3KZT9QRzH+sKskz+WFEeUM18UyPVmu
 h7ztJxMa++9J/JngtMirIcAprgBx/SNiCBFnIdXT/cb2xzJT6muBT0/+VnVpvXgUy4QT+kVsG62
 rejsYVYKbwvePbniazbMaMFBGBMKx6VGWbU1jFPaqIRFskFlPWWcE/0OQIfpz0kaabXO1rkcCv5
 wOy0+3U/2YMv9XQO+KG2ZZ8qBY6ARPhOMwik0HKECXIvj6v3e+KLWuDIUTWOIzbRUMSPd5XvazJ
 yb/53U8sOev1rmr9mkHHQtlxsIicvdsnQAcnRzsStcbsgmeEuCxxXQqrRgwmKe25JhRrdn9m+1G
 I4W+83sKdIcbII0a5/u/DQ9LYknu+g==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cad2ca b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lQCSvQGvPXAejg8cu_YA:9 cc=ntf
 awl=host:12084

Page sizes that can be selected: 4KB, 2MB, 1GB.

Both the reservation and node from which hugepages are allocated
from are expected to be addressed by the user.

An example of page-size selection:

  $ perf bench mem memset -s 4gb -p 2mb
  # Running 'mem/memset' benchmark:
  # function 'default' (Default memset() provided by glibc)
  # Copying 4gb bytes ...

        14.919194 GB/sec
  # function 'x86-64-unrolled' (unrolled memset() in arch/x86/lib/memset_64.S)
  # Copying 4gb bytes ...

        11.514503 GB/sec
  # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
  # Copying 4gb bytes ...

          12.600568 GB/sec

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/Documentation/perf-bench.txt | 14 +++++++++--
 tools/perf/bench/mem-functions.c        | 33 ++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 8331bd28b10e..04cdc31a0b0b 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -177,11 +177,16 @@ Suite for evaluating performance of simple memory copy in various ways.
 
 Options of *memcpy*
 ^^^^^^^^^^^^^^^^^^^
--l::
+-s::
 --size::
 Specify size of memory to copy (default: 1MB).
 Available units are B, KB, MB, GB and TB (case insensitive).
 
+-p::
+--page::
+Specify page-size for mapping memory buffers (default: 4KB).
+Available values are 4KB, 2MB, 1GB (case insensitive).
+
 -f::
 --function::
 Specify function to copy (default: default).
@@ -201,11 +206,16 @@ Suite for evaluating performance of simple memory set in various ways.
 
 Options of *memset*
 ^^^^^^^^^^^^^^^^^^^
--l::
+-s::
 --size::
 Specify size of memory to set (default: 1MB).
 Available units are B, KB, MB, GB and TB (case insensitive).
 
+-p::
+--page::
+Specify page-size for mapping memory buffers (default: 4KB).
+Available values are 4KB, 2MB, 1GB (case insensitive).
+
 -f::
 --function::
 Specify function to set (default: default).
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index e97962dd8f81..6aa1f02553ba 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -25,11 +25,17 @@
 #include <sys/mman.h>
 #include <errno.h>
 #include <linux/time64.h>
+#include <linux/log2.h>
 
 #define K 1024
 
+#define PAGE_SHIFT_4KB		12
+#define PAGE_SHIFT_2MB		21
+#define PAGE_SHIFT_1GB		30
+
 static const char	*size_str	= "1MB";
 static const char	*function_str	= "all";
+static const char	*page_size_str	= "4KB";
 static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
@@ -39,6 +45,10 @@ static const struct option options[] = {
 		    "Specify the size of the memory buffers. "
 		    "Available units: B, KB, MB, GB and TB (case insensitive)"),
 
+	OPT_STRING('p', "page", &page_size_str, "4KB",
+		    "Specify page-size for mapping memory buffers. "
+		    "Available sizes: 4KB, 2MB, 1GB (case insensitive)"),
+
 	OPT_STRING('f', "function", &function_str, "all",
 		    "Specify the function to run, \"all\" runs all available functions, \"help\" lists them"),
 
@@ -60,6 +70,7 @@ struct bench_params {
 	size_t		size;
 	size_t		size_total;
 	unsigned int	nr_loops;
+	unsigned int	page_shift;
 };
 
 struct bench_mem_info {
@@ -202,7 +213,8 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
 	if (r->fn.fini) r->fn.fini(info, p, &src, &dst);
 	return;
 out_init_failed:
-	printf("# Memory allocation failed - maybe size (%s) is too large?\n", size_str);
+	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
+			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
 	goto out_free;
 }
 
@@ -210,6 +222,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 {
 	int i;
 	struct bench_params p = { 0 };
+	unsigned int page_size;
 
 	argc = parse_options(argc, argv, options, info->usage, 0);
 
@@ -230,6 +243,15 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 	p.size_total = p.size * p.nr_loops;
 
+	page_size = (unsigned int)perf_atoll((char *)page_size_str);
+	if (page_size != (1 << PAGE_SHIFT_4KB) &&
+	    page_size != (1 << PAGE_SHIFT_2MB) &&
+	    page_size != (1 << PAGE_SHIFT_1GB)) {
+		fprintf(stderr, "Invalid page-size:%s\n", page_size_str);
+		return 1;
+	}
+	p.page_shift = ilog2(page_size);
+
 	if (!strncmp(function_str, "all", 3)) {
 		for (i = 0; info->functions[i].name; i++)
 			__bench_mem_function(info, &p, i);
@@ -286,11 +308,14 @@ static int do_memcpy(const struct function *r, struct bench_params *p,
 	return 0;
 }
 
-static void *bench_mmap(size_t size, bool populate)
+static void *bench_mmap(size_t size, bool populate, unsigned int page_shift)
 {
 	void *p;
 	int extra = populate ? MAP_POPULATE : 0;
 
+	if (page_shift != PAGE_SHIFT_4KB)
+		extra |= MAP_HUGETLB | (page_shift << MAP_HUGE_SHIFT);
+
 	p = mmap(NULL, size, PROT_READ|PROT_WRITE,
 		 extra | MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 
@@ -308,11 +333,11 @@ static bool mem_alloc(struct bench_mem_info *info, struct bench_params *p,
 {
 	bool failed;
 
-	*dst = bench_mmap(p->size, true);
+	*dst = bench_mmap(p->size, true, p->page_shift);
 	failed = *dst == NULL;
 
 	if (info->alloc_src) {
-		*src = bench_mmap(p->size, true);
+		*src = bench_mmap(p->size, true, p->page_shift);
 		failed = failed || *src == NULL;
 	}
 
-- 
2.43.5


