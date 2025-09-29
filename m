Return-Path: <linux-kernel+bounces-836811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD9BAA9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8C71C55C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC721D6BB;
	Mon, 29 Sep 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4spw005";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TCOsAYQf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03A24677A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759179186; cv=fail; b=Iao5oBjV/QYcgQ4nFNrwPJvw9I/cOrbAcK/gMNn0dNRwcNP6u541lpeOxN+rADirO5rMlmaNkwseHQ0VGEkptk3tLIHCJvNRGlGlRA7cje3gN8M3pniArfMhRhwoALyMNM1MCXso3vOcRtQO1s72mUVtUVTmmm+QLANrjyEpqlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759179186; c=relaxed/simple;
	bh=6ZjtP/weX5ACYtR+2sS6+nRSKgJydxCUEXfKXlpcii4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKJduO+OWnmPhCBnaiNPqFpDCMSRDe9fMzmDlLI4JZQqgPtzWhDLQlMpAT8lWe2s9IbSm45zQaWhIk2mABAgkBxZA2tYHT4fXKzOJFmMtTebfTyOiToeZLxm8LdotWR6dC9WZyjdKI817N0o2dHjbaPin40bcQCZRjcnMorvfEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p4spw005; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TCOsAYQf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TJxs9t004966;
	Mon, 29 Sep 2025 20:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IP7suHRVs5O0+V8kYEE3wVZfOEISubATXVbUSJ/4vsQ=; b=
	p4spw0059JADXSRDXSASFL8L4roKRxtUaI64Qx2dqp8ryBf6tfPYJ84xJ081eX6B
	aqeIDpp2ZP/0QhkPsoPZbc+2kuPUfQtIM8QQ7RHn6vYVvWpIeMlhgTnL5k4MrDuj
	AdtFebtlXQqaezni63pRJ8yjfljXROcR2ctTjK+/zcuLFtwGIbs7dtb0AFknhqvg
	8qcGqd7WFs4xoZhbzLxk5UsIGNT5KGbJX48lL/xRVDuX5nqa6vlhsaoa4uxqpQac
	RaLSCL9YeXPI+fWSAnyneDaQBgCIoz1JH0DEraCkysNVmxIG+ueEnnmsxp9yz+17
	HCl3PoZidE6jJ5u6bfawcg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49g0rjg3ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 20:52:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TK2LF1027173;
	Mon, 29 Sep 2025 20:52:31 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c6xx5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 20:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6UmEQgSrlPMHjMXpAeLgrMw3DLf8zMVqEDrUw+XHgUhS2MB5gDeNpBZuMQF89djh9zq8hA+hfeKyFJfEZtvIDypYfbpr0R3469WC7HFqkxhqTphqu+hWsv37OOU9TxsQzTTqa8Q8l1sW5YgKjOwB20Gd2v3mnM7QVcI70n6ZFh6MePXdPvlwUC1eNf/EErXMU1GzfwdEGWepUnOZBkef2KiWn358qQUNgJjhmMy5Mf3W2caL+Wvb8ZxRF/duCDPUN4DPm8d6pMcReO6vC5UKijvHSflAOhIDeN4GELAKP2qzyPGuzpwk4U+W+w27eDEO/5jlBBWyJ0Qdc76pIdOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP7suHRVs5O0+V8kYEE3wVZfOEISubATXVbUSJ/4vsQ=;
 b=M+KxJYY1sghHoZbScEvwlxxEHdEQzaLcWRwoggBqAkjgA+lCEWUdoZ3HWDTcnyok7JoTDXFHZ/4s85P1SjJ5psMon+Ui9zlskqGlaepnp8AI2y7WnNzPHNRJUA20dbPNBvYFr372YJoY2UFm01wvS4qab6YCesypXzHwZfiHMkxYfZ4ENhnu/D0YcQJOf0VttVd/8Zrs7XYiT4/qnKobWRIoHYfE4zThLFuimbxz+rf5h9pmFkZICpSMvcBehCb0EgGavjE8cRQeQ4n6JpQMMy4unrx77LaigCBTHWoeqWaMfGf9/4LV91wIvr9QlP9QSehv6toiL8YXcNP1pXEfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP7suHRVs5O0+V8kYEE3wVZfOEISubATXVbUSJ/4vsQ=;
 b=TCOsAYQfrEKuR63xyc4v0vE6o70Hbo+UZIFMPPULT6KosGlBk/6h+TsX2z5sDM7iXb09IEGBSvQ62Y0h8Bna9Ju1W3epGXaWP9ZnrwJTOU2SDoExgOaMbhHXyuRx7pr1TWmY/FEv7p2YQ9za30t6R/pPw31mi+MGspa1lXzyCTo=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 20:52:29 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::c047:e76c:2405:bac2]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::c047:e76c:2405:bac2%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 20:52:29 +0000
Message-ID: <00650ad9-367c-421c-9bfd-8701613ead85@oracle.com>
Date: Mon, 29 Sep 2025 13:52:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
        David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
 <594350a0-f35d-472b-9261-96ce2715d402@oracle.com>
 <7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com>
 <c61ca94b-5b19-4c69-b2a1-d11a5301c6bb@oracle.com>
 <92AF859E-AA5F-4470-B1F9-0DEC3F7030B8@nvidia.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <92AF859E-AA5F-4470-B1F9-0DEC3F7030B8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0638.namprd03.prod.outlook.com
 (2603:10b6:408:13b::13) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b44dca-175d-4416-e9b0-08ddff9a1a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajBJWWh5dGh1VFNPV0U2cGxNdnZWbWUyTGJuZXZjT2p3TnhxVTR3dmwvVURw?=
 =?utf-8?B?ODl3c3d4QWVXYnpudWVvRWNHZ0xVc0lRa1YyaFdNOURQdTVGaHNFK3hvQzg5?=
 =?utf-8?B?Q1hmS2hzYzdpZk9tTXhvRHFKcHJTSHM1VmNhTzByc1FhdVczeTRZLzVXM1Z3?=
 =?utf-8?B?U0J3RVIwVzloVmNYWm9UL21sT1liUU5QaXlqQVlrTTRSVy9UN05HZmZVN1dh?=
 =?utf-8?B?S0dzWkZRVklKbjVYcVo4RUhJd3dBTXE3aWkrVkFWclFibGVnaDZnanVaKzlU?=
 =?utf-8?B?eUI1cFJXVGd1TGIvVy9UM29GM1pBY294aUR2eDJXeTFmeXVqMXhWUkhBWEJ5?=
 =?utf-8?B?RmdxVDVvVUJqWFN3ZWlqYk5kZnFlZGp3NkdlZjZycWk4ZmxPL3p6VnBkMC9s?=
 =?utf-8?B?c290ODNlWlpPa1ZmOSs5YXVhN1V4VDErUWdWc0RuQWZ1MlVvNDVPNnlvazdp?=
 =?utf-8?B?VHRVUEJET2doVkdid2k4YmZnaXdkalZUa3ZUMXBqSzNDMGN5QS9JRm5ndmMr?=
 =?utf-8?B?V2ovK3J6OThqOXQxc2s5c090OTZkaDJQU1drMnBQNTFuaHRiOUdCQzYrZnBP?=
 =?utf-8?B?dGcvS3l5WFZyWFcwNyswdE1DWnZGOEp1TDVzV2VXckdodzM3UyswT21kT0Jl?=
 =?utf-8?B?WmRtNXZDb0FKcmZubjVRWDZlbk1WZU9FQ0hHVk9qMjYzY0plS05XSEdrTkxi?=
 =?utf-8?B?QjZ6TlVEK09sT3laS3FPcGFPMmh3UiswcnRWckYrbWw5R042aEcxWnpmc3lL?=
 =?utf-8?B?T1dWdXhhZHg5bU9oRFBwdVB0N2FjNHlUREZXbHdBQXBiV1hCQkQxS1B2WVRH?=
 =?utf-8?B?dkVoc3JZMlFDdEhHMElWcVdRL2wvRFhkMzlSUGdyTG50Qmw5Y08vdzlKOUc3?=
 =?utf-8?B?SEkrUmUwNmxEZ0VjR21tdVVybUZNdGlYckxmQ0RRa1NDbG4zUkptVjlhU2Mx?=
 =?utf-8?B?V0cwNG51SzZIWGJ4SkpXTjZrVkUvQjdBT1hYdWF6eWc0clhpTHNFTk5rVDlu?=
 =?utf-8?B?OFo0TXVFaTU5M1JGUkVTUVBuZGpvalBHQUNjRWovQTFzNUdmdHE1MHpBL2ds?=
 =?utf-8?B?Wnc1TnpCZnNJLzU2OXBXVFlsai9zZ3ArckZVcy8yTXNWa2Q2c3pwV1VtQi8y?=
 =?utf-8?B?Ky9lYzlKSEYxL2dsdU9lYVR4NTI2WXRrYVpGTzNRRFc4UDl6U1hIL1BZRFBp?=
 =?utf-8?B?M1g4YlN3Und5SWJqd2JQZFZQZ1ZHY05SeDMvcEdkWHpSVFUrZHFSdTBSZnQ2?=
 =?utf-8?B?dWpXa2JGa1ZKNEVBSm9tb1JJY0VnSUtRVjlzNnl2ZWxMenprK05EK3lOQ1Vo?=
 =?utf-8?B?R0FENUNHcFh3ZjNnRm5BaXdIU1BxbjRudXVXYnJZd2lTTEJxWFljV3BXRWpw?=
 =?utf-8?B?ZVZud2dQYWdDQ05zdWZBRzdpdmFtcnIxODdIcnJNOFV3NFRMYmZBcUVPNG9F?=
 =?utf-8?B?dzBGaURRZWtHNEhEYk1mSGdaTkh2T0J2aStsdkMzSFVOQzNvT2FkSGcxc2Zj?=
 =?utf-8?B?cE5rWVc5a0FiTUREaHN3OVduTmNla2cxRWREVUlhMjAxaU1zdFMvUDZ5WG4r?=
 =?utf-8?B?MGYwMWkwazBrY0FrU3BiM0h3Sy81SUdrQ0JiaDY5bkdzMDdJcFdiSHUrYUVW?=
 =?utf-8?B?UmtvSzV0dzFCMGcwaVZvdndhUHJ1dW5MNzZNMDJ2TWFlaER6RUViZkIwbFh5?=
 =?utf-8?B?eC91cUZVQmZEZlFGbmFnbE4rWkE0cmRkM28wNjVVZnhHb1F3SVUyZDQ2Y0dV?=
 =?utf-8?B?Q09xNjhWbkFmWFQ3NXZRRlp1c24wbEk5S0NiTTBjdkU1aXBURTV0ZWNWNHZh?=
 =?utf-8?B?VWgzOEhzZmJpVWVhZVc3QXRhRWFlenhZQzV1WU9tQUxmOTVrVmZaUTR2azRq?=
 =?utf-8?B?RkVsNHlQUk9MRXFRYWNmN056L2JZQ2hHZnZoWDlYSEVaTVpBMjI5WnJhWEp2?=
 =?utf-8?Q?Wrmlqsh5bFNENwHnEWtSse1kecJCiM6L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE4vOGVUTTdKNnVMc2QyeGM0TTl2dCtleUR6ZW1RSkdaTldvT2xBSXpHdGJ1?=
 =?utf-8?B?c2NmY0crNDBmOXJ1QUVhTXp3L2tGVlEyS2JpaitxNVhSYmpnaE5OTkdYUmds?=
 =?utf-8?B?VGdZdXJjZ3JBUXNhM3BWYWZTRG5JaE9rYUE5UXZZeWt5QU5VbzgxS2hKdzBa?=
 =?utf-8?B?TUk3d0xpUHFEQlNSQWVKMGtUeU4wUjJLSzkwRW13cGFHQkJTOEVYczlqby9t?=
 =?utf-8?B?VEpoVXY5R3hYK0ZXSVdaS2RuS3AzOXd3ZUU4UXFQSFJrdG1sRkFYT2oxRENs?=
 =?utf-8?B?OFpSMEthelFmVElVUnNSQ2hTaXMxVVk3dGJBV2N6akxCbExRWlFvYTRwbmZH?=
 =?utf-8?B?K0IyNzQ4UTIvWTV3Q0ZMY2dISEtxUDZvWkF6SzcvOGl0ZHFjcjBrVTdYZmNi?=
 =?utf-8?B?NnVLbitCTm0wZGlZVXFzdHZqMElybFB5SzFDVGNpYmE3ampMQWJMUnI0cGN3?=
 =?utf-8?B?VDI5Rzc4Wm4zQTZoNTA1ZCs0bzFnQ2xOTVM2MVUrbzQ0ekc2OFRPUXNKRjlY?=
 =?utf-8?B?bTBRQkVQams5RDVvbXBxREFzMTRrdHBFd05XZ2ljeXhTeW9FWFp0VXdyejdn?=
 =?utf-8?B?R3FuYkFzZDZpWE5nZ3ZBbTd0RDRXczQrL2F4UDVRQlJIL1g0cGlsV21Menk4?=
 =?utf-8?B?eDBFVWRkYllzYlRHZ0JUMlVqVCsxUzZ2KzRnWmlXOFprbWc5RHZkeFFnNzNW?=
 =?utf-8?B?YWhIRDYvVDdwcDVtd0JGSi9JTFpvc1lEZUVualA4UEpxZHpLNzcrR1FRKys4?=
 =?utf-8?B?Q21hVU96OVFGYi9xR0NGTHhkVHJNVXgvVXkxMER4c2RSa08vWGhuN0dpSGx2?=
 =?utf-8?B?RTBTK3hlaDFGTDlpSGlZR1N5MGdpZXRhbFcvY01WcFJwczBTRk55VmVtRGJW?=
 =?utf-8?B?czBpMXdaWC91bW5uTFVxSENVZ08rc0dqd3RoZXBZRFh1MkVZd2ptdGNjcXZL?=
 =?utf-8?B?dHk3UTZSQmhLQ3N6K2Yzdi9nNll6SE9XdUMrRTdXNXpmM1FaWFA2b1hoaDFN?=
 =?utf-8?B?cWdMeEdrcjlIdDdjMnBwUnFZZWRlUTRVWi9uZFpheGRXdHgvQk12UURVUTAw?=
 =?utf-8?B?N2Y4WTRBUm9TVm1yUzBoYnVLaDVrUkZtUHhjZEk4MkNiZEY4alJYc0Zja1Yw?=
 =?utf-8?B?VktNS1BlTGQxQ3JHaFJwN2c0VmxlSmdSb2xMZkZkdDNhT0hYOXkxV0p1K3pS?=
 =?utf-8?B?RkJtODIxRy9nV040eU5sYTA2M2FjRElqTFo0aFg3RXFWZ3lBM0RRaHYybGF3?=
 =?utf-8?B?Y1ovd21jWWQrUlFqaTQ0c1NldEZMZEFmdytibjNxTjNIem56UUUrU3NvZ2RV?=
 =?utf-8?B?UHBpQ1ZpQWFnL0tJR1Ivb0k5VThWOHk4WFkwWVFOdmJVTTdWY1UyZERXWERN?=
 =?utf-8?B?RFNwZTY2ZEswbDNnMDFZeW9UTjJXWStybkk5TVdJYk9UNGUrL0thOS80eWVM?=
 =?utf-8?B?QTArSmw1bFg1eU0xcWorOWN4K2QvQVlaVFFVUG8rdlZxZVMxdjlhUlRmTU1s?=
 =?utf-8?B?ak5QN1lFNGtGNy9hMzdLcGduc05MTWZLcEQ4N2dieHRZSzVWblRiSDMvMWJF?=
 =?utf-8?B?K0RNcDU4QjNTOUNRTXdaTHpwTFk0L2tDMVZxV0ZOWU5wZ2ZFWGZ5aU5Oa2JY?=
 =?utf-8?B?b0czMisrZmFQM3lTbXl1bG53NVFNZlVnTnJJYkpwK3AxRm5RMUEyVTVBOHZu?=
 =?utf-8?B?L2RVU1pVQ2xNRUpqdno5VkdvaUltV1NaUEdTS1ducEloaTZwYXhXTUU5ZDhp?=
 =?utf-8?B?OFRReDFYa1dja2Z6S2JZdDY3UzQ5aDkyeG9lcnlzRHRMNUtvNnNwVnNkRXVp?=
 =?utf-8?B?MzRsQTRxRDFPa0ozakE5ai9zZUk5alNFV3hPZWR3NVlJSS9YaGg2Nkl1QkdZ?=
 =?utf-8?B?TlBGNktsemNXbDZyMVQ4MXpRRHJnbGcyREdESkZiRXJPeWJHWVY4Zk11NGFr?=
 =?utf-8?B?bnExa21jaHVVRmg3QTZVbUdVM2x2bUpMZnBxTnRrL2hTZHFjY0ZoZ3k5REZs?=
 =?utf-8?B?QkR5QWt3NEhYNXNxU2VESG41Z3N2Mlc5K2l6Z1ovcVFsQ1pyQVJINEFjWndL?=
 =?utf-8?B?UXc3N3JHbWEwTVloUjVNYXh2SWk4MC9peXRaa29DV1g3bVBFUnh6ai9BVlB1?=
 =?utf-8?Q?FuKHRJ/kZGWcGTWvzLllNFCiL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mysCDnERyjzOQY3RLj2qYnGLUcR2a4w7Xjw6NhNE/ubJR0H0oXXlp+BKeUjsCROCveqXuB04hNkYm3oO9MynNRFDP+re8wg4Go6F15PodERY3ilUkaedb25/8PhBdJZtYmBKvdwtYMzkzIbhMhVLobhJmtv6uSowD5Q2O07CVRWua/0Brf47x0++SxHRQ9hA6XZoAbOXeMDmXSYYFqc/+QIFbKR4IlpcpJYPoZGwvMBcTP8hYxsFvjZArPuY1J6p/eN+YiSKBA4ABi6O1q1vgu+bG8QyghlFLeNu6VdV1LWPGPFJomNBYMtaLkWP7yiCKxRY+vAqZQ77jc4p8Wtc8LkIcm0GguY8Nb086gWMw1Zcdr1jPR9B5dIZuHiaZVGyeQdM+RMkBos7uW1tFuUuOwR7Nd3CK7S52Sm/MncaO8GmNKyD2tANzwBev2ErbQzPgJG/+3GQZk6W0Tvs7sN3+XFktamIkCRP9o2CQ/LICqqBmlErn3q/Oc3tRUzmEsbZUiJR83dQQHNRmnciVTsQ1BUAyQLE7sSGHVYzE5OqXAfqFMOdUwLoqU3neJb3XmF6zFopI05HGyo5r7LqqvT0FeIjtPqDniyFkARYNoiPTIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b44dca-175d-4416-e9b0-08ddff9a1a5f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 20:52:29.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlzUyYZBTgyBV/56yyVTCrZCoyIIubpGMPXYq4wcLE1SzUFFO0U6EsDMDbMHanKPoca1j2kTOf/5PwMYPy4qqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290193
X-Authority-Analysis: v=2.4 cv=ZKnaWH7b c=1 sm=1 tr=0 ts=68daf190 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=AgpXiHI-Zi7-MHLGSnIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: tXZyVvCKkMkPwK0igG4ipX7EOmEnP1VM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE4NSBTYWx0ZWRfX0OmRlj3rKkhe
 psyEXCniLi3655+itrrlaSvDv5F8fWm2fS/KR/kQsPnqR+L4nOrf4FGm7aKHH16P3QsJs4Q22HO
 oU2ATEKFY//X3Mnzeqi1chxWku2BRP8ReozXzs770FNjLGtmiEAWDGufnN5qwX1GtGRXoaGFyC7
 ye777y89WpBbRYT9EZlLJUaKG13zdODG7dJpUk9U/BlfqISCda3NhGPXeY5Twxa2TpnH2YfyG+N
 T+S7kXM58lTuqCAjy38QzPxeYiOOpwa4E1eOjXwATU0p1d183I4iYgTNHnad/JlWNUG8nn0tdGO
 JgiWOQJTiITV/IxsF92gu6SxXtsvtUgefnulOiPtn5vdf3tdPVzjgFiYyX+RICgEFFGmISP0aEJ
 qEHGs1ntp8a07HgCaiFOVdibBjxwwA==
X-Proofpoint-ORIG-GUID: tXZyVvCKkMkPwK0igG4ipX7EOmEnP1VM



On 9/29/2025 1:15 PM, Zi Yan wrote:
> On 29 Sep 2025, at 14:23, jane.chu@oracle.com wrote:
> 
>> On 9/29/2025 10:49 AM, jane.chu@oracle.com wrote:
>>>
>>> On 9/29/2025 10:29 AM, jane.chu@oracle.com wrote:
>>>>
>>>> On 9/29/2025 4:08 AM, Pankaj Raghav (Samsung) wrote:
>>>>>>
>>>>>> I want to change all the split functions in huge_mm.h and provide
>>>>>> mapping_min_folio_order() to try_folio_split() in truncate_inode_partial_folio().
>>>>>>
>>>>>> Something like below:
>>>>>>
>>>>>> 1. no split function will change the given order;
>>>>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new_order
>>>>>> is smaller than mapping_min_folio_order().
>>>>>>
>>>>>> In this way, for an LBS folio that cannot be split to order 0, split
>>>>>> functions will return -EINVAL to tell caller that the folio cannot
>>>>>> be split. The caller is supposed to handle the split failure.
>>>>>
>>>>> IIUC, we will remove warn on once but just return -EINVAL in __folio_split()
>>>>> function if new_order < min_order like this:
>>>>> ...
>>>>>          min_order = mapping_min_folio_order(folio->mapping);
>>>>>          if (new_order < min_order) {
>>>>> -            VM_WARN_ONCE(1, "Cannot split mapped folio below min- order: %u",
>>>>> -                     min_order);
>>>>>              ret = -EINVAL;
>>>>>              goto out;
>>>>>          }
>>>>> ...
>>>>
>>>> Then the user process will get a SIGBUS indicting the entire huge page at higher order -
>>>>                   folio_set_has_hwpoisoned(folio);
>>>>                   if (try_to_split_thp_page(p, false) < 0) {
>>>>                           res = -EHWPOISON;
>>>>                           kill_procs_now(p, pfn, flags, folio);
>>>>                           put_page(p);
>>>>                           action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>>>>                           goto unlock_mutex;
>>>>                   }
>>>>                   VM_BUG_ON_PAGE(!page_count(p), p);
>>>>                   folio = page_folio(p);
>>>>
>>>> the huge page is not usable any way, kind of similar to the hugetlb page situation: since the page cannot be splitted, the entire page is marked unusable.
>>>>
>>>> How about keep the current huge page split code as is, but change the M- F code to recognize that in a successful splitting case, the poisoned page might just be in a lower folio order, and thus, deliver the SIGBUS ?
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index a24806bb8e82..342c81edcdd9 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -2291,7 +2291,9 @@ int memory_failure(unsigned long pfn, int flags)
>>>>                    * page is a valid handlable page.
>>>>                    */
>>>>                   folio_set_has_hwpoisoned(folio);
>>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>>> +               ret = try_to_split_thp_page(p, false);
>>>> +               folio = page_folio(p);
>>>> +               if (ret < 0 || folio_test_large(folio)) {
>>>>                           res = -EHWPOISON;
>>>>                           kill_procs_now(p, pfn, flags, folio);
>>>>                           put_page(p);
>>>> @@ -2299,7 +2301,6 @@ int memory_failure(unsigned long pfn, int flags)
>>>>                           goto unlock_mutex;
>>>>                   }
>>>>                   VM_BUG_ON_PAGE(!page_count(p), p);
>>>> -               folio = page_folio(p);
>>>>           }
>>>>
>>>> thanks,
>>>> -jane
>>>
>>> Maybe this is better, in case there are other reason for split_huge_page() to return -EINVAL.
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index a24806bb8e82..2bfa05acae65 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1659,9 +1659,10 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>>    static int try_to_split_thp_page(struct page *page, bool release)
>>>    {
>>>           int ret;
>>> +       int new_order = min_order_for_split(page_folio(page));
>>>
>>>           lock_page(page);
>>> -       ret = split_huge_page(page);
>>> +       ret = split_huge_page_to_list_to_order(page, NULL, new_order);
>>>           unlock_page(page);
>>>
>>>           if (ret && release)
>>> @@ -2277,6 +2278,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>           folio_unlock(folio);
>>>
>>>           if (folio_test_large(folio)) {
>>> +               int ret;
>>>                   /*
>>>                    * The flag must be set after the refcount is bumped
>>>                    * otherwise it may race with THP split.
>>> @@ -2291,7 +2293,9 @@ int memory_failure(unsigned long pfn, int flags)
>>>                    * page is a valid handlable page.
>>>                    */
>>>                   folio_set_has_hwpoisoned(folio);
>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>> +               ret = try_to_split_thp_page(p, false);
>>> +               folio = page_folio(p);
>>> +               if (ret < 0 || folio_test_large(folio)) {
>>>                           res = -EHWPOISON;
>>>                           kill_procs_now(p, pfn, flags, folio);
>>>                           put_page(p);
>>> @@ -2299,7 +2303,6 @@ int memory_failure(unsigned long pfn, int flags)
>>>                           goto unlock_mutex;
>>>                   }
>>>                   VM_BUG_ON_PAGE(!page_count(p), p);
>>> -               folio = page_folio(p);
>>>           }
>>>
>>>           /*
>>> @@ -2618,7 +2621,8 @@ static int soft_offline_in_use_page(struct page *page)
>>>           };
>>>
>>>           if (!huge && folio_test_large(folio)) {
>>> -               if (try_to_split_thp_page(page, true)) {
>>> +               if ((try_to_split_thp_page(page, true)) ||
>>> +                       folio_test_large(page_folio(page))) {
>>>                           pr_info("%#lx: thp split failed\n", pfn);
>>>                           return -EBUSY;
>>>                   }
>>
> 
> What you are proposing here is basically split_huge_page_to_min_order().
> I can add that as a second patch.
> 
>> In soft offline, better to check if (min_order_for_split > 0), no need to split, just return for now ...
> 
> OK. I can do that too.
> 
> Thank you for the input.
> 

That'll be great!  Thank you!

-jane

> 
> Best Regards,
> Yan, Zi


