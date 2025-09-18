Return-Path: <linux-kernel+bounces-771373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C347FB28631
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BC61D06DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D823270548;
	Fri, 15 Aug 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzMZlqAB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sxTLJAoy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0721FF2D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285093; cv=fail; b=LWNzNC91RwxMgsNIwsLzm32cQ2Tj8JNVRe/EGblTFYWbaYrBe4x45+2/s0t/TbWSsHGicaFGbwo2EjzWcPlQhK9dNHewcriWSUnVix5VsNRvBHjnoQrCpcZKBxBpqCDS6HUix4VKNOTIypZtY5Cx2qYoKKnQz31bGs53/XwfeNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285093; c=relaxed/simple;
	bh=zs57R3yCXKLC57ayejfkSrzLI9OPViWMl6QPG9QLv44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKCwrpVRrPobeADTuH8F4ZE7ySlhhvD6tlhJo0QpNc4rOx9eFuCpr1cbxSLbR+9cP9NZoW11yZMvmpwGb/1D6VheaFCfc+VxVl2ys5Pml3ydptUoqBV3j8tuQknOPQWFTUJJWHUTVmQb1bs1nScZUwQ/vLprJA5o8zJ2olYDR1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzMZlqAB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sxTLJAoy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FHlaNS007889;
	Fri, 15 Aug 2025 19:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Zbwlbb+54RHTI3Fr/+f5AP/brYfhObDXaTFJSl78qeU=; b=
	IzMZlqABifC0+1BYBr5VXnUOJWmoXj4046s++q0ayr5X9SNJc2sj0+4Vvurjpno0
	5JhspkVVZnHAerk4CJq6IzARzsIUwUXZo7rOKQsLOmhqVzWoqJJb7aq1TlB+zWU+
	TA4OhPWUqS7vilImWVq66+8uwvSIcqd8UCeWOMBulgnBixCEK50H5wFIWvMIreMh
	fpkJu3lu6K6YGHgIfE508umz+WlZRtv6peR8fjrcOytVxsY5GSRbuBLYucEStfE2
	nZhOzC2qrSbZmwSuO/TTzDwtkS/vWnnHOx5du/2SfiQoCie35VyycYOaHAY85FIe
	Xz6pyBfGvc/73IWaFJxfVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48h7rmunes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57FItrDp038531;
	Fri, 15 Aug 2025 19:10:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsmvuqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 19:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVUA+323GyNXAirm5dpgG/lnHS7ITLXfhUtzLwxhgW0RL/YN4pkryaiHmE1nykLwStExCAqNBaE51ZHWn28V9OEK2KH8GhI0yrFrhp/eY7MB/p+/xdManxZP/xliLz146LUCdYhGqTf7ngIDQIsNoQsnjzPWA8JMSV4u26D/xANq0XRE+e0sYrHZzGpMq9RKN23bRGZeJ6cbkOKfqOkevMpb7tyRwP8g74jK/dYA5JNMrJADviQS8fUzHiK5iOO9mCowNNSSlTsvrIIb7zKZBrLbuf4zcaPYp3YQuptwkavT08wiJuRFWbCWCXt7fmdC64/W7/mQaYVXCngDtV5X1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbwlbb+54RHTI3Fr/+f5AP/brYfhObDXaTFJSl78qeU=;
 b=DyA1J7pbn9h8AxCWR6qKgx1JPALRhVRJkYVuPAGrwr8rJ5v1EljiZz31nddv24SBOB31RDA4q2a6eDffBi9T5M7Xixj0uS4RF40hVXKM+CoXbt8H4omSqcWh7eb/EIKdITxqYZpLxzjAhyWfEVuoovdjSk+fhSIZxJK1rTKDkNy1a1xKtvA5B9s5w6VEJzNV7bAXTBicrWilaV4ilzGCmdaBlOy3nfmo0XGQLExxEqAXv4xxmwdU/Z38FfyIVpd6Ky2Rx+AbJhw/B9/RjH0DbDTH6E22JMFsePFmDDQ1AxtMrHjCfIjUflcjWYOzq5BtY7Mc3ObOAPKkI5nw1E4qtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbwlbb+54RHTI3Fr/+f5AP/brYfhObDXaTFJSl78qeU=;
 b=sxTLJAoyRueLB9qerX2HGB6880wTVS7o1hGTGJq6bi0jIRQBXyj+wx+lv5NirJDZI6lHDo587f3DEYeljWEh3t4dbrQ8ilDCzcSO1IuGnUiqYbnie25YcIuR0gvN1plQPDlz9lCOY7I4B3wzZY/f0X223YUPpCNtBDR2hnOTKGw=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB6464.namprd10.prod.outlook.com (2603:10b6:303:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 19:10:42 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:10:42 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
        bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [RFC PATCH 2/6] mm/mmap: Abstract vma clean up from exit_mmap()
Date: Fri, 15 Aug 2025 15:10:27 -0400
Message-ID: <20250815191031.3769540-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0236.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::33) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0ab96f-c62a-4c05-46a7-08dddc2f6dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3l8wncjPS6rdZFx8DpgbRkNOG6R4q2X/I3wiAbY6RCJvxPmtSgAF6v0OH6Pf?=
 =?us-ascii?Q?dyOLROJh8AzW5Ox4HazLwtQzzWif5FZDtuCo4sIoM7RvHVv/GU321NKDNptZ?=
 =?us-ascii?Q?hdlSP/VVHhDEyE8/vGuFxSiq1ZTzWYKwYC7cbppZQWq8jbByNlsvUSXfWHeR?=
 =?us-ascii?Q?f4V7XN/jAh0pcIEW3MopReF8StSlEskDQQNW41waSIixo+84zFepXlED5I0+?=
 =?us-ascii?Q?tBQPJbRP0B+7Hy/yUqgCkAaTut+Lm9rxxAvYS2VkQTQrNV4SLHJOnIlQHf99?=
 =?us-ascii?Q?NMwmrHHJrB5sWhT4R7GJS+ZybJDuxXQfS3rWuqRtq1CGPmli6G3P16T+zveJ?=
 =?us-ascii?Q?81y45WuJRTv9eYSk8VYCHdL07gHWRwkUOjgh30fdCO+mD0w4wpghadsb58TK?=
 =?us-ascii?Q?zUgOGDn4T/JH+xsW/fFgVQVLZkXOLlvrYrf1NH336oc1NUnxiQinlPDAt4xH?=
 =?us-ascii?Q?T0lXvphWxlqmU4UlIgSuLx5V2byv8wDPAYplv7RU/iM3Gw9QcaHkghaDn9h4?=
 =?us-ascii?Q?LP22qH7Xl/BH2UtTgn9f9YXpcoVBt65kBJcZ5QKb1mlGJGtRzQuRZHBm6NX5?=
 =?us-ascii?Q?lB4eT+1aEnkwmHzpz0Lkmj7RCdNiKXAJt7Z9Zi/fyO0MHm9A0+QUckiAlIrc?=
 =?us-ascii?Q?AlpYaiTX6+xqzKFs5STB+KqROMC9VU2UPSinAUich8k76JuN2sIXauRjLGp9?=
 =?us-ascii?Q?E2C6jYgJ35L+9q5cBPw647FTLLMGRl6rWB1WpCAEPWIcx+RU9DFVFH2JalK9?=
 =?us-ascii?Q?orCCz7ocxv5xBTxW358UHoW43vEQamFnLXpV4S/r0I2IDkRJq2FN/4i6ruGy?=
 =?us-ascii?Q?oLzjvbBc9lFrymNsSotdogPJAh6+gqq5Uj9Ed4uoYHXFPI5hQxTIdYALWClF?=
 =?us-ascii?Q?+mT3w7+EDl23tdnBEiXx8ipfG9UHiU8uZurErIyeofZEKqovx+MibQUSes+7?=
 =?us-ascii?Q?jRUfchSLd1+7idQzQ2sLFk/SW633bbFzXqQrUABZzC6idc+U2AQZyBTGWMBb?=
 =?us-ascii?Q?jt8KI9qR1GKt07JYCLQtMYPM6dPOI7KORFjlwSdTrD5Z4KyjEpHKVir5s43r?=
 =?us-ascii?Q?oM8DRm16sIp5y0Rsf4OUE2wIqfQdD2MzAavc4MYtTGCm6IWe05jbVmY4xdLi?=
 =?us-ascii?Q?WjyUAY8tVq8EkMBesve9CVKLPDIgEPnD03uAqibPTowia94jz97jBaIOIZPI?=
 =?us-ascii?Q?itPfaAFBJm6uy56BnitGwPKsFFwO7hzuM/yp18IVb3NQkFiAAmOMKRGihbZP?=
 =?us-ascii?Q?imdjrG64IBp19aYhhDSGeR+KlSbaALgNQw8QM4oW/W6UMhDxzXzbFe7Ghor3?=
 =?us-ascii?Q?MHsBhZrlhB8fW5rwCE2zh1FJq6nFRdhkic+x4QHcA9rrU1MZALG4W4e6V5Iu?=
 =?us-ascii?Q?TdkxktJZam6N+0qM/dGH4cAoNENvg30ObYjvt1BCzYefkuoReC+2c19ND2Sr?=
 =?us-ascii?Q?urF5U9hdW8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wnXtWvrylQq6PdlBIvLha6Eswx8OSr7XDSlNB8i133Lxr6H0tJS0sssmuIJf?=
 =?us-ascii?Q?tqqelbt7IpLYFXI1nfMuVC74vMQqPoaxvIy92ihgE1lyMYXten7F3OONbvgw?=
 =?us-ascii?Q?mRN9d/U004zuj0yRckV38mYFhFjzEhCba5yo011bV8ZolJhLkzlVdTnwKX3o?=
 =?us-ascii?Q?MMxkDAQECGQScFQmmUk5EZFYuCkR3NHKn8Fy4/b00jz5Num4VIi6WvNSMM4g?=
 =?us-ascii?Q?mW1M248QSZVx4Z5DcIW/S0IKa9XDW/SjT7mhqA0mlLn3NY4crNO9ztFnY3Wm?=
 =?us-ascii?Q?0aiKMoCHC9QkhJwEamZgTFhCsfuZl8bjEUsG1GJ1Pxaq+FTW9i/PfDhqTwfS?=
 =?us-ascii?Q?EITn5Bjxox3jZ6La2/f/yyUY9c8mCRo4N1zdzWYG/oTuZYGrwaT40AJCHN3a?=
 =?us-ascii?Q?uK7teqaM973CZWn3dTFbKyKyZZ67Db40JHie6GgVJKUGW2wL+HF+6tb8fmA2?=
 =?us-ascii?Q?N778YtSiaTD+QSWUADaZbRQX9EwbjpAcNabISbmTBQOhql0sSV6zwTWPZM8b?=
 =?us-ascii?Q?WO3tEYqQicp9rhKEQrWjPe+kWULRYL1WLA3PGvutqgny0P1r9/bTIXJittEz?=
 =?us-ascii?Q?MROntluaI/nRSFuYVoj0zrT2gUjIIUEKSWsMhfhkrSko9sU5nbttTjeEFhi+?=
 =?us-ascii?Q?/22gWqw1SsDIcftcYFLvhwWbNHPsqgNsQG0shzvph27rVOftvI9ZDIfyQDur?=
 =?us-ascii?Q?je/rKh/vvDDYyGfzklp72NpkSqRUQr0mzid+/YZiBHEnPgAltyrlXKaJxQr9?=
 =?us-ascii?Q?16c5Kuuo2Tle49LP+UGw0srlNEabOLdb/ermt3GFgsUC745SVwWYYyj+7Qbp?=
 =?us-ascii?Q?UPvvLp4XY63Y2fgE6UHD8G//jpd3Ut/Ww/biwtbvqgyx44GqOCQciZUEjVpG?=
 =?us-ascii?Q?LV3qat51yys04YrifA32M+R4zTBOTIa6Wq0R8MMRQ9yTem19QTKh2ZaPrqPk?=
 =?us-ascii?Q?USFPX5XtDOG4+RwkvL1bjM2XHp4qDCvWXzNwz4qQ49yDNIPKCYL4jjPhL8aV?=
 =?us-ascii?Q?m7yjqxBhaw5XJTlq1vcj8yzlpje9qcLLUarsJF6qlxImHyYQexcCirVVHMLT?=
 =?us-ascii?Q?5P8B1KuztW/Pbz8HIdpQRYQ+BCGXxWYjcLkrbZxGknCk8J7TJNOWrW/4Pkt8?=
 =?us-ascii?Q?RsyufQLooqehCufURGKIdsKvocBMgCaz8gS6VNlX+5pNhcDNt7y6N0yV4C+Y?=
 =?us-ascii?Q?tNmSTFqYcHVO5hptGFEJeEI24R0mtjTpv4fA2GIraQKXySy9EWjX8N/FqQlU?=
 =?us-ascii?Q?J6ffjaMqzv8siBDh9f/KpQAul1QHxcLkYMZnh2NU9l39ueUeZQR9DiGwhIa6?=
 =?us-ascii?Q?psBZvZLauK8q4cmyBP1+Smruf/YBd7iVet1sDhxG41uID6GI7w4HqhUM6ZiP?=
 =?us-ascii?Q?hOgTl9+9kud4kInLiUNR0J48DRYJaKdiF9CbIGDXuptyOLy15Z+otwf8C57m?=
 =?us-ascii?Q?yEg+l45qIs2o4UWrRqxnoLYQoqh0OudbFVtOth2jV71M2Mzi9ymBVbV9KyVm?=
 =?us-ascii?Q?cnn5jbHa8SzCOjPIGGqfRT4N8zqV+Z9gw3BiqYLKnMyiKCuJTbmc25EqL8ck?=
 =?us-ascii?Q?Wk98tGwN2SVp7RDs/ANqOnNZxQySKzOAp1wmGGrv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cEl2q64O1owoC+gJKGMUH9QXsa+6d3Z4DPGsp9N+W3bCvvgxghGv1yuihmDAENh5u5HcWHqkua1t6OF3gQ+OaV+4nDfhb+Aheo0xiEwV1LZ84rY0o+ViFPkvwE3IE88vJUupFxCe7v4wznj+qzTRi01NMJQ2CRzDkrgjayv2UEEAzyhZt2X/8ghKOrdf85ytPHN4XlO3R4Hd2n/+cneVY63nKWyyXHMQhwd2bsFH4gp/g9a7dmCMsUOvLKDUaoB/R2qP1lhODNvty3lY14m2iAQI1Su2sXnDvOjfFoowtjKPybD0FSiciYMwv7REUmVI6XqeEsdpMotU/0nHQRnkRvDeCWl86yhDzJtqh55Kjvdl0yK9yR9DZRISbhVu2awcCAX+gBimcintAHTMnhv2oPMCXGG5NfyOix00jFrEJI4H6lA4/Ed6x7POfPozjFSUuearf7jSRMH+T9SrumpmRp1TtKy92Vyk0m/Bu2+pZb5Fbfy2xZ8wT2ASjVIgMwesI607pRIViIu3rwSodGvlFOnS75zbQpBgdp9OdOv9bRT5Nc2SKnK2fWf3drvaTGinWph5Zvhtov927IPT9USMMmOU/W0aYRF1CupnKcFqtp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0ab96f-c62a-4c05-46a7-08dddc2f6dc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:10:42.1138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4uavsYrvnuP/jMmadA0nuvdFBSEkSl3HjOFs4TJf7xsk6mR0IBphPwrjGLCjB2wS6mDaTRmitTyWuOpc75egg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDE2MCBTYWx0ZWRfX4UQIj5tGJujU
 WwR/GDszFr+zVzp7w08L6bKzmCutd4OI44IB2QCVbXn8YhilCnqb9FroLm2qsvuXoTGpvkDVk+5
 XRkyNjoDAAdH+FN05rwkYsGo3DSVkmlPPglY/Nu+QAWVRYqW5K64IGx+mbjZV0HAmmBmRSmayI8
 NzblScX5FuKY1xQWWyi1w9MjPrZWpPaHUMdMVj/1WtVf5mvEnwagWWc1AChCkHklBSw+x0lK88s
 JjGsTfl1z1VRTgRc7YUfaNl+C5ZCN75CR2kJ5IkNNHj6LLKqsnRqztP97C+m2fFfcSI3+ly6V0w
 TIZL2AVvVyYrX4IFJtGKUnIUDPoK8VlV6pAMcgMzFcWdyM0oev4EeOi3f3PPZ1Dqri7ZSZVSHcu
 iMNwswkXnp1SjOkvrmsdtXeBW/bvSS73WRqFxKAz7gzTGTnYW9kSFMAP/ALbSqmq6clq1G/7
X-Proofpoint-ORIG-GUID: 4d2idNHR2wpo13IO43g2ZCsOj_KntXEt
X-Authority-Analysis: v=2.4 cv=UN3dHDfy c=1 sm=1 tr=0 ts=689f8635 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=DO5yfXpT9pfNaLUI-vsA:9 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: 4d2idNHR2wpo13IO43g2ZCsOj_KntXEt

Create the new function tear_down_vmas() to remove a range of vmas.
exit_mmap() will be removing all the vmas.

This is necessary for future patches.

No functional changes intended.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c4c315b480af7..0995a48b46d59 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1250,6 +1250,29 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
 }
 EXPORT_SYMBOL(vm_brk_flags);
 
+static inline
+unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,
+		struct vm_area_struct *vma, unsigned long max)
+{
+	unsigned long nr_accounted = 0;
+	int count = 0;
+
+	mmap_assert_write_locked(mm);
+	vma_iter_set(vmi, vma->vm_end);
+	do {
+		if (vma->vm_flags & VM_ACCOUNT)
+			nr_accounted += vma_pages(vma);
+		vma_mark_detached(vma);
+		remove_vma(vma);
+		count++;
+		cond_resched();
+		vma = vma_next(vmi);
+	} while (vma && vma->vm_end <= max);
+
+	BUG_ON(count != mm->map_count);
+	return nr_accounted;
+}
+
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
@@ -1257,7 +1280,6 @@ void exit_mmap(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
 	VMA_ITERATOR(vmi, mm, 0);
-	int count = 0;
 
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -1297,18 +1319,7 @@ void exit_mmap(struct mm_struct *mm)
 	 * enabled, without holding any MM locks besides the unreachable
 	 * mmap_write_lock.
 	 */
-	vma_iter_set(&vmi, vma->vm_end);
-	do {
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += vma_pages(vma);
-		vma_mark_detached(vma);
-		remove_vma(vma);
-		count++;
-		cond_resched();
-		vma = vma_next(&vmi);
-	} while (vma && likely(!xa_is_zero(vma)));
-
-	BUG_ON(count != mm->map_count);
+	nr_accounted = tear_down_vmas(mm, &vmi, vma, ULONG_MAX);
 
 destroy:
 	__mt_destroy(&mm->mm_mt);
-- 
2.47.2


