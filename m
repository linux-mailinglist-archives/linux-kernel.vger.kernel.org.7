Return-Path: <linux-kernel+bounces-728204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ECB02498
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD2BA6064D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D52DCF4D;
	Fri, 11 Jul 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9nLMcUj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RDYUNjzg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CE18DF6E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262129; cv=fail; b=czttD4PX6PMAE/PDBWfVTHvSOevQYAXBQuLvKFCq3neBNjSTi+Q+vSLXS7hGzBxQN4uWrhGhrgaQ1jLA76kQKecff9ZLFI4MtAXXQ8n5HxAa96Y1MAGlbkQ+IA6+HzleAQZisMyqI9GiSEV4k6CU8qdtXqND+Vwo39YqK+mFPPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262129; c=relaxed/simple;
	bh=ukkEE+NEbicZsC0TL/Lq5p6leoX4dYDAXFYimT45HxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cCIEpHSKSsH68FnnuTxe+XKLUh5hi1pUPN51oWTJ8lQX3e7zEefBBnKHbzKYVRBJSyttg6j6jHQvhlos05LItKAayFGGCtswJFl9x3uBBaqQOGe24PwVQiHS3uigK2xrCAD8kcA7m7eFQgb+Se2QSjhEVmD3o3kw5iJPbN+Ik48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9nLMcUj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RDYUNjzg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIHfxY031985;
	Fri, 11 Jul 2025 19:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dEJ3dkeaR2AtxJqfRmg5Ruy5otn+5nUg32ZvWhN8V9U=; b=
	O9nLMcUjrlmO+GJqyTirfVUZK+RIuN1xA538m1amEgxltHLd22MvLKnd8jKbNex2
	sXdJOe4RNmUSQtwIcO7fjvWbzjY5Eug8sqnl0eN3ZkF2sNR6Y6XJ6GIcP8oQStRy
	2RT7fscuO87M7h+3u8GB45eL+F0LSdI1EVdR4wsf+nTMqfh3v/NGn7WKoeUtc9Ei
	tp82yimmTIdWh6uRJ12Ynk6t0NePU2M7vKlM23bAahXC83AQfzTlVW1wh7nlb+6r
	g6k6o0Jx8m2Vzjq1qP0U6xla2r0aB/vS1ksddWF5lHz7Bk0etiWgl2a1BIAxCOkq
	LOS7vz0EOjQP9q5qFv5Trw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u7rk03yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:28:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIq4mi014236;
	Fri, 11 Jul 2025 19:28:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptger547-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWhpX/yDeKBB5xqF3QcKox76YdVGfHbzzGi4hLzHlAUOJ7JCl24pYl37D3ka1kynhDE8CrdQAWTWDwq7ejGqhu1WhYKvUWw4Ovms8yU6aNMPIC3A2J/dDVzM/EIy0GwhooPjKE15kit3hcOkMmtdnTCUo3hwTByoSwGGdtumvcGPTgTyWe6D/gz79cOE9fxTvzwodvHrXcPqFasIXq8UscHMozNBPXDX197DJFlbaBaERCZhK5Jhgtq+VRFsH5VEV49b6ye4a0b8tiN5P1rnvlrKQIWJ9w77B3ISKjNojOWfwR0iZpN+r4jSq22+ENczubd9zurv5xTK8whgXifPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEJ3dkeaR2AtxJqfRmg5Ruy5otn+5nUg32ZvWhN8V9U=;
 b=kwRvh4shfHlSN0Uj/ntWtbqcQjkGtjdePhdrjwD5a7sBkNFGI5rp+Ne4OckWUV7R8QH+0tdZbaOG2ODRbYvG8/ivzKCNianGop3ehOJj2YdTu7GwGcHgN2VgwDgrj925L+1JaSSiqXn2yCMRhpq5Zq5Cfju5ONAeB6KWCvQ5JkKJ4LU5H/gWlKhLn+UOvkyLu6wGi8yUAyg3xyxGWZzoi3hvh3jEoU/41v7GfFw6JaoW314UouD3aYjua16olCREyqTqpDTWDaWCH3H+ETJLdxgc3BgTPtlzGA9m2LGYeXO0tvkmDYsuaaaZ0YvuGwEPmN4dagx3P4HsUnPn5XGSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEJ3dkeaR2AtxJqfRmg5Ruy5otn+5nUg32ZvWhN8V9U=;
 b=RDYUNjzg0IXLcZxXqk0mU89s/HSbU0ItSiaQeVigFddGlbXYwQ7/FNG6iwGfo9871JcLOoCR33BFKZlL8ShDYZtSNdqcHzVJyonp0M/Yekxe7B9Kle+U+ErnZwOsDAyc4GTVrS4cmLbuejLLQ04+TbgbkIUo4Vm1mNuPQ2T45P0=
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d) by PH0PR10MB6957.namprd10.prod.outlook.com
 (2603:10b6:510:285::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Fri, 11 Jul
 2025 19:28:27 +0000
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4]) by PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4%6]) with mapi id 15.20.8922.025; Fri, 11 Jul 2025
 19:28:27 +0000
Message-ID: <77db1539-247c-4c58-ba07-93239d7be31b@oracle.com>
Date: Fri, 11 Jul 2025 14:28:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: Regular file curruption check
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+630f6d40b3ccabc8e96e@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <683eb35e.a00a0220.d8eae.0062.GAE@google.com>
 <tencent_35CC9554E896EE32CDD479766DB42D056D0A@qq.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <tencent_35CC9554E896EE32CDD479766DB42D056D0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:610:e4::16) To PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF517B7003F:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 555c38b2-7dbd-4f2a-1fbe-08ddc0b11c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UytLMSt6QnhlL2JmZFhrMXZLNEdhQUx0WHlpYWpmSHhxUTBzN214RklvR3FY?=
 =?utf-8?B?MkFhZml0R3lIeHYzZVpXVUJ5a1RkNlZYa3NRczhGbGk5VG9GaGxxSWx0RUI2?=
 =?utf-8?B?SjZMd0phSlM0MGJIc25pMWFqWElsZllDM3B0TlBmWG1qWWwyUDEzRk8rQUp0?=
 =?utf-8?B?Wm9vdWxGbWJGRWZqL1B1K3p2VDRNeEhncnQzOTk0VGtIRmdqdmk0T3VtdmtY?=
 =?utf-8?B?OTZCYzljbzVmR3ZQOFg3cUptazR6ZHFURERoT09vU0V6QTM5Z3JGcDVJN1hv?=
 =?utf-8?B?U1R2MWh2NEt4WmhmYldPOUFnN3BPbUF1L2ljc2ZtbUxueGF3VVBKN250eXdE?=
 =?utf-8?B?OFl3Ry9mK1pxU0szdUhPc21LRCtVRVUvWXdldDBxZDVmNktoQm9IYmEzb05B?=
 =?utf-8?B?VDdVYktJeFNZc050MzhUUmsvNHJldkowWERQbWJ0bjRJQXdSa3RCcmJUcjMy?=
 =?utf-8?B?alNUTSt0eW9YTmVCVW5XSFljMjhzSHd3QzJSeGU5eW1ibnAyV2ZnN0J5dkJH?=
 =?utf-8?B?akVFSTQ4YWVqQitPN0dkWXBJWXJ5OFB4Sm4zWm1QaWtId0ova2NrNkIzMXg5?=
 =?utf-8?B?M3FNY1JTUkhCU3JBckdHVFZYRXhwSy9RbjZBUWd4a1FUMXNDZi9wSk5wV0to?=
 =?utf-8?B?dTRMSTNJSjlHbW85T1FkcS9yU1RiVk1BWDRKajI0Tm80RCt0Q2drZTk0Zkgz?=
 =?utf-8?B?N2ZjQzloL1lGTEFOQUFjQWw3YWNQM3BKRE5maGVqZU1OandZRVRUVmFtb0pk?=
 =?utf-8?B?YmpaU2svK3N2dy9mNkIzOEl2NGpMTm9hcTFPQlh5cHhGMEtxYnlzSXUxZkFE?=
 =?utf-8?B?MnNjZDdwbWNkbGFacmpRdlpDK1A1cGdZL3NramhaeFQ0Q092bktsQkFOenJt?=
 =?utf-8?B?VE11ZkFrUkxSWUhJM2hrMFZPdy9lc3hOY1g5T1VJUGFmekdRTkdMbzRjOHh6?=
 =?utf-8?B?cTZaSElVNnFXWlhGamxEYkRzVFRHUVdlNjVYdkNYVG1xNm0rcVR5L2hFZkIz?=
 =?utf-8?B?VVhndThLZzdISTc4MzJzME45V0lHZDBqYkdNQ2JVb3VaQ3FSaFFkMjhxc1BQ?=
 =?utf-8?B?c3B1RU1zTE9odHNjbkROM2dMZHFwa2ZBOEVoOWlNK1ZNYVUwY0ZjYmlGVmFM?=
 =?utf-8?B?STM2ZWk2czhhUkZrTEFlZmN3eUcvNGFyVDN3S0NWUVhRUi85eFNxa1dQUjJt?=
 =?utf-8?B?MUllTmdJbEZTK1oxTlRqRjI4Z2J3NnMvSlUrdmpvQzdVVmp1YmhFZWNqb3Nr?=
 =?utf-8?B?Z1oxYVpZS0xNZnVqbzJJSE16N0Z5blIyUEprNG1qcHg1VFR2YkgwYUpQNVgy?=
 =?utf-8?B?VmxqRFdSMlVmaUJaaFZqemFiLytrT25TcHhNYTFQZ25ObjJqS1hXRU1VTVNz?=
 =?utf-8?B?dW53SzNTalVUVXdtYllabmVZK01aOGxTdFV1RzBlYlozV3dxcmg5VW1UQldx?=
 =?utf-8?B?MmpLK3IraEZyRXZOOVczeHlQOTdCdkxTOTNydzJjbm9FOXpZTmxMZmVlL1NU?=
 =?utf-8?B?V2RvVHhCdFdFVkhkM3dkZmVObWRsRW4xaDd3N3ZjWjJtTTUxdDMyNFNjc3lU?=
 =?utf-8?B?ek9KMU9zVndPT1RnMUpySlRGUTFhRWxtanhPVUxveWJJeE9sdXNWQk1YaTNN?=
 =?utf-8?B?RDZ0WTBsc2F2b2x4Rnh4RUlnN3lwRzZ1MGtjRXFTRVFSUnlGRG4xdThBK09J?=
 =?utf-8?B?SDBySUxEeUs0d1AvbUVWcVdZOGd5eHpEQmg0V0xlL1VhempSWVo0ak5VMUNC?=
 =?utf-8?B?UTU5VVlnMTZMVENzVFFidzAwMzVWS1RMREF4dzZkNHRNTHdublJFT1Fxb0Za?=
 =?utf-8?Q?Su1t718Ptxg/nVPFLm4dp69oScLwwAM2lc1oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF517B7003F.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFd2UnNUK3hZaEl3R2Q4c1ZQVmZBOHJjODA4L05CTFRCSU4ydzZjbUpNSzJa?=
 =?utf-8?B?TzFoS0d4RW9wSVo2d3JSTlJoOGl5VGVCN3EzRkNJM2F6UkNXNnFNeWJHcDBo?=
 =?utf-8?B?YmhNWTlQb1BDckNhY2hTdUI0T0pvelZiaDZhYkxraDA0V3hjQzI2cEk0anRP?=
 =?utf-8?B?d0lTR2NYVVdrSm4rTEUvNlptRlFYVFNmWERpaEtrYlJtY3N2NkZ4enJpMUVz?=
 =?utf-8?B?L2ZiNitKTW4yanJ5NmJ3ZjJnMHBoaFNmR0xJL05yeEpJSE5jNDhpbHROV3lk?=
 =?utf-8?B?VjdFVEZoR2MvV3hSbHE4TnBZaG85eEVIUE9MTDBjWmluWU5kUkJqb29nRHAy?=
 =?utf-8?B?aEJ6T1ByZS92QXpIOUZ6aDArTEhtL1l6MGUrKzVEVHlURyswWmF0VU9Bejlx?=
 =?utf-8?B?Wk41bG40Y0FreDdVcytJQVI0SEpTRGlHeEs2cUtuVWJWUWZZNm1WSllvSlBF?=
 =?utf-8?B?V01sYjVtOExrOGxlU1BaY0lRUGtlRlQwZlRSMlZJbFVaLzFQSGVVQnNFenRx?=
 =?utf-8?B?dUxxbkZMQkFlQ3F2SlFUNjFGUHV3d2wvZ1g4eVF4SDhVMS83aTQ0TlYxU3JN?=
 =?utf-8?B?R2lNY2NZc3dlSktUTmMyY0tONjJtclZHUFVNSGdxVE4zK3FkQWZpNWZlQTYz?=
 =?utf-8?B?MUV0dkw0U28wM3Q0eGFwcGhsc0tzbjEvbnVGY1hWSjZUQXExOFhPamdBWGRQ?=
 =?utf-8?B?V0toelcxSVhQNHpKZ2FGSS8zaWNLMWliWjZQd2lTV0x3T0ZDVzJvK09qYjFl?=
 =?utf-8?B?OE1JN3RNVWlMMFV0Tk14NkkrempYUlkxTFJXMWJoV1UyR3RlNi9mVzN2WWNu?=
 =?utf-8?B?U0c4U0hGaWpIVktnRi8yZmtGYzZWckVTc3NDVFlOSnNudVRYZFdWVFNrNGFG?=
 =?utf-8?B?QzE4Z3hNY1g3WmovY3V3ME04WFBZL21xMTFYY2FoTThwV0Z2d1RralltSkI2?=
 =?utf-8?B?NGZJNW1WVzMrc0pvL3gvREkxRlNUb2N6UFY0NFJUMEtJOTBQbnZoM3dTUmhF?=
 =?utf-8?B?TUpKWG13VG1ZMnkyaCs0NEpMajRZRTJJM3FLb2FPY204WGkyeDlwNUx3TzZM?=
 =?utf-8?B?SHk2UmpkTFRMWjFOaGNhUTE0NWNiMVBWMTQxNHlrMG02YkgyZGdHdTRvNFJR?=
 =?utf-8?B?amtiWWtRVlpVNmx4MnNPWStmUkJmYVlVRCt4clM2WkQ1SXA0TXdmNFRtTjV6?=
 =?utf-8?B?ZjU5OWlyTXJjeXZIdGJRK0YrL2s3bkJLaG1yRUFhOHdEajZzdFR0c2srTEhR?=
 =?utf-8?B?NlVUZ25kbENBZUdRQnZQWENyK0hiK0pMRC9POER0UE82VFRLeFdyaHNvck9Y?=
 =?utf-8?B?VzMrb2pXUkRpY25iUzh4K0tESFU4ajlaNHVHZk9IblFEQnR4V1BheHhFY0pG?=
 =?utf-8?B?VUlla2RjNHNQSWVUMGQ0d0xmbHZudDd1eW1WQW9FSWFrM09YUWNudjk3blow?=
 =?utf-8?B?cHYwd08wZnRiQlgzRWlrUXFudzlZVndLa285ajUvWTF6TEoxRGNyODJGcURI?=
 =?utf-8?B?OWdKVllhNm5IRUxJK1dJbEpaTVR6NVE4d2FWcmNEK3NzVmhnRFdVWVZDTzJt?=
 =?utf-8?B?dzh3TkFIUkVqdEpQemJzL3E1ajAvSFVWNDUrb2J3NTZ6aG8zdHRLUHRSYldS?=
 =?utf-8?B?U1J4eXNtWEFKWklwNVJaSzR2aUNFMDJaODZwRE9ZUkNYaWgzdTFQU01XZ0Js?=
 =?utf-8?B?V0FDa0dUNW1tajYvTURySHpuN1dNcG9PdUVQcktqcFE5MVc2VTdwQ2tsY0hu?=
 =?utf-8?B?MmRDNEo2UGdOZEk1V25ESEJTSitWNFZNYTcyUmR4L3JPOFhTUjd0MGI1VFh5?=
 =?utf-8?B?RzhubmRiaTF6Qzg5c1pubnc2Qmd2ZXpLTVdMTlc5bW5vTTFOdGlaRzVHb1k4?=
 =?utf-8?B?M0lWSUU0YkVIQ3ZRRFJDbytONnhMNFRBQ2JRVmZxZkIzTjhmNzZlK0Q1NGtT?=
 =?utf-8?B?Y0EwcjFzczlPYVN4Rm9lUFl4SE1yLzk3QnZUQWFGdUk5TUVveTRsd3V6Mm9W?=
 =?utf-8?B?Q2IwMWtzNzB4RU1YOWhOOVJIRm5rby9aSExieUl3YjY5WXN1U0tUYk44ZEMv?=
 =?utf-8?B?bUNOWHMwV2VWUlBuRWVzaXllQXBRSGtZR25oaGpXeWUrQVM1azlORWRYdU56?=
 =?utf-8?B?dmNFamJtMkV2SVhyWE51SkgrMXJzSmxIbmlZek4wdCtmV3pmMURmUjQ1b08y?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eAJzwoii1W4ePggSwO7VmiyGUNFakJuxk7LHKrOv1X4FpyPOSgqh3vbFSGlkyw3gXkMdDuqIKeb7bDvJiQDrE0e+tNE6V5W3aFaHMBQdriEXfC3rrgBNpseoHEY1qIMVtoYmEVbnMg3VKBzboxADO3P/c7DBLxCTcIVV9Vz7Q4usy+2JkZZnfSqvkFTjESN812WqahTGdAuOW4yCRVhmNdJ0tOzsU49gdTC4fgWkoiT+BGyGqccCxgE55y0hxocLoCHIRVFTTfTcB8I8G9rgW5Q0AWY5VzNp5xah88pSO4HkK3GnYlzbve2n6yY2aGZ2qCrH+g8j01Jo+t9drQt75FCnoWRI80PJR6vQOU1wl6R5VJrZ9V8kH+qbiFCeEWk10e84tRi22VyeWYOuVlacj5MzWvRtE5qMLHJVTIRZjhk674L7hn+3NkHcZDfsN5B8NcrjMGjz3yfKMCsxUG/hC+VXyB71INeUdHvaK08B5WcKvYZAWjJ7EA+b5o7op0BNZp7dY1AjpEnji2QcqCVohOpsOdtVUHoU9lpGrAq8O8Y2OK4ODIXjHVBoMXfFk/TOQIrMehmfLwQlzDUK7j+SEetxPa966sUbMWMXEm4AhLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555c38b2-7dbd-4f2a-1fbe-08ddc0b11c51
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF517B7003F.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:28:27.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2RxjrAwGLU2KT/+3DbcUk7pBwNMBlLi6PQJf5z1XLEwa7d+yQd4KGnoEbVSwtiB0DGdh4DDB/LfOryg32/zNKHPsAY8BffoYjbO19WqqRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110145
X-Proofpoint-GUID: FqbGnfBujUDbfnLiXhrTVgLHxlHpUj0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE0NSBTYWx0ZWRfX5f3DUSUru4ay HCZuFPPq45V2+qQdaOZoT48LdDol5/1c+KAx7saWNSuCf/MLe6jBg9lE96enBSgc8DR9zbOC9c2 1CI6xZJkhi1lsTrP5cl2Id23n8ldZNp0Pacw8tBH5s35L+27HSJ48LbxBIedhBgq7Xtga4P76ei
 W0up+f6C9vjQKJ08LfZEiNJn91AO67CiRzHWmotyUl4YVWOh5h59z4k3DeXXvE3ZegWsRVxVn5o NlwW0xjQ/C9K//fseMt0iCLjwGge85KmIw+lT1odj9/hgB96Sof3BI0kwBT6/aER+1v2FbSVheA YbFRhbGnYEmcnh3O9Kaid7zNpMy9esJjl9loM2rVjHDu+TgYinMllXLk8xLaCSHRZV2JGHSjeu8
 4447Bp4mSYnmT+nhTPGk8E2mfP0YUqd1gCRD8qIBGnJiWkcLOxDVXlFLqFAYO+VRVOjepqOt
X-Proofpoint-ORIG-GUID: FqbGnfBujUDbfnLiXhrTVgLHxlHpUj0h
X-Authority-Analysis: v=2.4 cv=OIEn3TaB c=1 sm=1 tr=0 ts=687165df b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=dZbOZ2KzAAAA:8 a=GyjGf0OwxryQ3Subq6IA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:13600

On 6/4/25 1:48AM, Edward Adam Davis wrote:
> The reproducer builds a corrupted file on disk with a negative i_size value.
> Add a check when opening this file to avoid subsequent operation failures.

Looks good. I'll apply and test this.

Thanks,
Shaggy

> 
> Reported-by: syzbot+630f6d40b3ccabc8e96e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=630f6d40b3ccabc8e96e
> Tested-by: syzbot+630f6d40b3ccabc8e96e@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/jfs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/jfs/file.c b/fs/jfs/file.c
> index 01b6912e60f8..742cadd1f37e 100644
> --- a/fs/jfs/file.c
> +++ b/fs/jfs/file.c
> @@ -44,6 +44,9 @@ static int jfs_open(struct inode *inode, struct file *file)
>   {
>   	int rc;
>   
> +	if (S_ISREG(inode->i_mode) && inode->i_size < 0)
> +		return -EIO;
> +
>   	if ((rc = dquot_file_open(inode, file)))
>   		return rc;
>   


