Return-Path: <linux-kernel+bounces-720691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B64AFBF46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36901AA82BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A21C5D7B;
	Tue,  8 Jul 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PCEpqlwZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ef0c3G2V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691A1F949
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935341; cv=fail; b=EiykuGwwURmYUQF0k6pV6DlBlKvvTHsMnlOoj+v06SokKLhp6jm7XwbNzKu/Xc8G7c1FEM5P1elz2jhYIWXeqXEUqAtrY1Az/P7JcGq7h+HQZAC+MsObwJj6YyPBTBWwKXBDmri4vtfK9Ty2hoExZHRrCgv/zNE/z5GHIhskPzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935341; c=relaxed/simple;
	bh=QPUgCuYvHGpAGamzEEsCLM0mXmlFUK4lR6Vb84Lz4S0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guwbUB+vEx4Gtf+yOu8gko41ns5cptLfWt+szpEEIaLNumBKZ+5fbZdfeiMXI8434zcuuiErR88Sto1t5dawwDwovzUgjVWIY3yWb2NXFNGp9opSbvJuv3iUgUnFwssqiCZfmXTP5pdPcgLYtw/+ryDx2T2FlwX/fU4YGGrMvrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PCEpqlwZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ef0c3G2V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567NW5B1027462;
	Tue, 8 Jul 2025 00:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TkpDNgWqFnnqrtaL4Db6hk4jjFkDRaI8RgCa7VpeULg=; b=
	PCEpqlwZ/xF45GnrAKGh+F+XrwmgalqCpV6VT2EY0opW4nQq5v8JhU+kIRUKV/BU
	yf/iO6aPcu7HuuAxtYazKqIw3/yo9wQIDEAcQSOgCtzWMCtSQSnHFntEXfqbcHO6
	J5X/+FUQpD3obXkTtPoHOU+VpeifYkYJUkJ2Xb7Fx57f52WBCdbKsQOdGhOueak5
	WQ0uQg02WfadaHeA2OSuFWLJvDHQdsBL6z0IavbEGsiYPgwiD3evnHovfRyM3uha
	ualM7M10KJNkDiiL7keGUF4X5oj4+2P2Ouzfzdab81OHX4+pKS4JqDQjy48XEOst
	y019em/V84jAl7NxE3z5PQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rr0602hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 00:41:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567N6qI4021432;
	Tue, 8 Jul 2025 00:41:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8xp4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 00:41:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad7m1uV7exvuiAuKTeskjAtZrCGTz7naj+U4s3lu4m6C9vWeytUisHr/Jaa2vlYHbO+cc5/bj+TKbay3+YmY5prR8sc2BAEnDZ/jVrBXbBSQ0VGIeRTogDBIxRrNEwpXkW/RGzJo3cD8lT9TFFwelgxpV7T+da/R3tNT6cJ01tSmIScv13bzlx5FiaUCYpzUo84R4R46On+OOdNaYW3W4oEV5NVXUxkb3wvbKF8OXs9hpWGgZSFaPr2TnJlo7YpxLyfBDShRrSdvmR4GNUHAMFDrOCiKZNXfBZuY6kU6atNbxkfVQs4Glx+sjhY2PURgwUbSmGB31h3o42WIUsccoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkpDNgWqFnnqrtaL4Db6hk4jjFkDRaI8RgCa7VpeULg=;
 b=Cg344FzeQfvt+OnwDTe280GD+gHQc/3wsDJUgYqgdVg0D/Kjpue/rx6XNyfYI2cmlBh4ttGeDyjUiTJYnHySzMAPaV1LwVs5viOc3BUn0E4dCqLBePFKhYFd/01S7q6ar38hK2vl6xbJc7ozBp2bzEvQV/zGRZGjquQDKbowuF71UwhYpf06BMZadmGZylTpjDxTgYyyh7Zo+TWejQTtRFGLgMQINL2ZtHBMIpvkXrlMCl+/uXnzH1Ds15GUZ5Gb1AHuSNGeydFr74/RmEV+xSEm/x+AZXF/D2rytkomyQ63nRZ6hQMpyhDbU6XzVuKzik/3pjCyDHBotCtXZyguWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkpDNgWqFnnqrtaL4Db6hk4jjFkDRaI8RgCa7VpeULg=;
 b=Ef0c3G2VxxTZIRbmqY5xcxbsrewuCUWeKpDjqxFMDvp7gqaisbQqA/cpnD1OKoMsIFLyu+E28Kgg04ECGa2x7eQ//KCuZExxNDFpXHpSOM9YNroLyJ+10eB3afLMxh0blBgsDKmgxx9n9Fb6K2DRN2c7lhtbT2hDDW76COFr1lI=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by DS7PR10MB4991.namprd10.prod.outlook.com
 (2603:10b6:5:38e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 00:41:46 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 00:41:46 +0000
Message-ID: <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
Date: Mon, 7 Jul 2025 17:41:43 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|DS7PR10MB4991:EE_
X-MS-Office365-Filtering-Correlation-Id: dfeaa627-8275-4b0c-9562-08ddbdb83787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjJadm56QlVrdjdBdHZISnpRNWRzN0R3a2F1YTB1bnpQUjBIZzlpelhvTjNN?=
 =?utf-8?B?blBtTzIva0VYTUxiekIvblZCcGRzSm9mME1PUWEvcDZPZ295UG9vSVlRYmFU?=
 =?utf-8?B?Zmprb1h2ekZKeUVuRU9abXNxaTVUK2c2U25ibmlJY2ZQYjZBbkpMR0RWVm1M?=
 =?utf-8?B?ZlI5a1ZpKzl0QThDejNlU0ZVNlVjQWdnSDFHUk8xNTNrb00zaXhVN3AyRXlI?=
 =?utf-8?B?RHJ3RnRQcUpsUzRydS85ZUpXYmowSHZCUktLYnBpNVAybzhzRElySnM5d3lk?=
 =?utf-8?B?MzlMeGVnWGFVRDMvT2kyeWNCemN1bGN3QTh1aW5KMjEzUXBZWTZXUEtEWDV3?=
 =?utf-8?B?ZHFYYmVOSnVOc0g2SkhtRmRWaWxsYWdMQ1JoZGdTdzMzMzZURXMyNVJoYnd3?=
 =?utf-8?B?NlY3OW0zZXJ6ZFkxWk1XZ2g4amZkdWZCUnhwcUZuWENJWWRSbS9QaTRHSlZR?=
 =?utf-8?B?ZUJjRVBKTzFibTd3Mk1FSlBUaDh0b2lEcUFUQUV2dUc5ZGZKRnNqQW1zWnRp?=
 =?utf-8?B?eVBXdEM5QkJDTFZaa0U2RHU2dEpScWUreE9FbHhHZWVJMngyZTRTQ0F0YUJX?=
 =?utf-8?B?MVZabnZ0SWxBVExQSEg0N0xIcVZJc0cvRVY5WGsvL2lxbTRzOU5aRk5Dc1RQ?=
 =?utf-8?B?K2xLZkdDVVlKdEhEek9hbWF3YmswL1VmVEN1VWtreC90OXlFSTZ6Uy9lY1Nj?=
 =?utf-8?B?NEI2dlZ5NEh0NFRLOU4zSk1FMENUcGxmL3dLY3NPSUdkalJXWlozajFTejhK?=
 =?utf-8?B?V1o0WVB3ek9FV2hnKzRnYy95bW5NdVdYalM0d29SUUE1cWRCSXJDOWRORjQ0?=
 =?utf-8?B?QnRPSnNaNnhWb1lhK2JFcWwxZS9vbytkRHM1ZmpySG1wbG1leW1HTU5mRm1K?=
 =?utf-8?B?K3JVYXRUTFNyMEFreVBjanZPZjUrOUVvblJzOGgwTmE2cDdNR2p5ek1SQzF0?=
 =?utf-8?B?WmxrZUs2NWh5Q01FWW4rUXJoS1duT1pLblJReUJSbVhhRHBnV0QzK1ZPb1cx?=
 =?utf-8?B?dzhqTWxQZG9XR1JEZXN1ZlZsZ0lyU0p5OEhhODN5d0NmWVNrSWN0Q3dYM1Fv?=
 =?utf-8?B?Y0laME55OXhaSlZJMS9ZTVNqYmRMZENBSFNIWGRzdGJEN1RNdWdSbTFxRUhB?=
 =?utf-8?B?RWdxUUszaXQvWjA4SDF4MUx5YWtoMWpweGRaRnhjMGp6eUFCVzRrZ3ExdElZ?=
 =?utf-8?B?QzZlbGxqV3BKdE0vUm1Xd2Exb1FtMUtHby9MVWpqUjFDN3cyU1JrcWVnMWtM?=
 =?utf-8?B?UExJZllvdUdvZnpPWVZXUVd6STJPZ2g1M2JlZ1JEbGEvbk9uak9zcnI4Wkpj?=
 =?utf-8?B?Z2JxR1Fidk9EaFJKaENlSFpZcHdVbDhMZk14RnBUMXJxZHFMUDRWUnZVbGFk?=
 =?utf-8?B?TkRNVFFxRjY3ODlKYlBjb3VnNTlWcHI5dXArc0FPQ2xRQjJPT0JjMkxjaGRK?=
 =?utf-8?B?b1orYkhXR3RwaE9XdGc5dU1OK1QyNWxYdGZpcWx6cy9tcU1tOEt0VC9odlN1?=
 =?utf-8?B?cUpWc0JhejNRbUtIRG54MHJiOTZjendONWt4dzhJd1p5THRONERZQUVVMFFI?=
 =?utf-8?B?S3BEUTB0aXJubENZRkNVRFhBaEpSMjBUVGpqQUpDOWw0eWwzWm5wZTJCV051?=
 =?utf-8?B?SWpXUzZGcWtEeGJnaU5IcmxidUFTSUsySDFkaWQ0alBvYzkxNHNxQ3Uyakdn?=
 =?utf-8?B?V1ZzbEtZWXNqSDdtKzZGckZFM1dyT0lTemttUDNTRWRxMnNMY2RCdlpxOFpm?=
 =?utf-8?B?Rnk4NmQ5N0lYV05sTFIyOEVKaW5xK0YxYldIZ1ZSOGgxWDRCSmNhejlkaER6?=
 =?utf-8?B?bTE2dWExcFFtUjhPUCt5dnppV1RJUGd0UjM5YkpyOVB0QU9GbVYwQUs1bUNq?=
 =?utf-8?B?OEFQN2J0RFRYc1NlZjZsRzNZTkVYQVMrem1xcWxLSW5iNDJ6Q3cwZGwzKzNS?=
 =?utf-8?Q?CANfxP7g9no=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtycTRWK3NvMFVnYUx0TTJhMlFQT3dQTW5TY21UakdPK0JVVWdOSFROdGNX?=
 =?utf-8?B?VjY3R0dUUGxXSlZYYjE1ZDVpS3lRUnZLQzVSS2xqclBENE1zc1U3VU9OdUJT?=
 =?utf-8?B?bCtQMFlydUNJaUpDdmEvZUhiMW9YZVgzdWd5dEo2ZFdEUS9zRTQvcm94Mjdk?=
 =?utf-8?B?bW15dGFrdjVTVEE4ZVZ3eVF5N3RMSkVXWk5jalZtUy9KeHRDQVR0ekM3cm9y?=
 =?utf-8?B?T3N5Z0JNS1JEZXhvUFBSQ1VPRjBHcVk4VHJ0L0tWQldQUnNnZnRYdkVHNEFG?=
 =?utf-8?B?SG44dURRd3FpSFVDYnp3ZkNCckhiMndLaGVPRmlkaDRadG15ZlV3Yk5XMUI3?=
 =?utf-8?B?RWNpTzFQTWVCV1UwYlRjU1pMQVorbFZVNlJqTXV5eDBWc3hveDFRRVJrcWM5?=
 =?utf-8?B?NE1xeGwyUENrWkliMVQ0QTlmNnd5U0k2SDhnZkJ3YnZ3UVJjYWFockE5Smxv?=
 =?utf-8?B?TlRuYnNiREdaSXhkUktXSzQ3aS8xVVRLblpjTUZFQW9NRS95ckJVeC80Nnhk?=
 =?utf-8?B?ZWN3amcwRXl2bm9uRkdaRzVmRGsrT2ZrVEdUdmlucnNVbTFNLzlkaDA5cEZq?=
 =?utf-8?B?WkFPY000VWhaVUE5QXY1elZHbklEazZDd1g5dGFqT1Z6S084aDMxNFpaRTFR?=
 =?utf-8?B?aVlocE80VzRoVGVmeXhBTlBBc1lRa3JNRG93ZS9oK205UDJ6Z2VhYUpWcXNu?=
 =?utf-8?B?dlFPeUJlV1VJYXZLVG5SMDBXVkJmTDNiUk93SUd4SEhRVWFYTFFpZmI2SWNM?=
 =?utf-8?B?bVYzZ1ZCS3pUa1phdlRRb0x5M2ErMW90ZnNraHFYczJWcTFqV20rd3E2MHdM?=
 =?utf-8?B?Nm5YbnRNQk1lQ1RJczd5bHp0NHY0L3d2TEpqYUpPY3A1Ylg0Qy9qNk4vbE5Y?=
 =?utf-8?B?Zlhaekowcy9WWEV2MjJWUkRPcmlmZnBheUFkK0phcWpVVmpXRWJXUG1hSURY?=
 =?utf-8?B?UkkvRWM0Tkx0c21qQjFsSkxDUjVXMHpVSGtsek0wWVZuZFRycW5pcW9kRUM2?=
 =?utf-8?B?UXNzbUJOWENlbStaejZGOC9BOXhVOWM2QWUwSVRUanErVWNEd0R0U29lbjBs?=
 =?utf-8?B?RXdVMytnV0t3RHhMWGMvUSszaWsyRmY4R2JFOUw2dlhiSmYvcGw1cTc5M2Z4?=
 =?utf-8?B?VzZDNGJSa25JUlZySGpMQ09wZDBNRmh2Z091K2k0ZzFPbHRQZXBnclUydWth?=
 =?utf-8?B?alpuREJEWXUyNDUxN1BpTHlJeVRTSW1XWnFnWENoTlBDc3FaMkVmT1YycUxy?=
 =?utf-8?B?QTNVaUZoUW9zT3BVN0JiL1hSQW1pUzRTSXpWd0tQc1hnajdUamVnYThSaGhM?=
 =?utf-8?B?M0lGaDAzTEVBMHdPUEQ0STlOQ29EdnpQZzR3NnVJSEcvSTZyMWIzRWVEeUE0?=
 =?utf-8?B?d0trWE9xRWlISFRHUE95S2tvSUtUMmQ5Y0tzL2dsNEU4Q09JSkxqZ2pGZ21Y?=
 =?utf-8?B?UnNyMlNQNFF6SUdpbUx0SU5JaHMvTnZuUGltM1J5bjY4YjU1cU1pc3RVcEJz?=
 =?utf-8?B?UElDRXUyNTh3ZkpLZG5EVTdzTGYzRmhaVHF1S2JQdHp2TnU2RlNMQ2FxLzdH?=
 =?utf-8?B?eHhRUDk4ZFY3WVhIZ3FCNGdKU1RSUmxQbGNPTzYrMlhMeDB5Z1MrVlQyTHcr?=
 =?utf-8?B?NU5ndEFqS0FyWXZyV1ZYNjlid3I3VlAvWFY2Nld0M3c4MTluc2lOam1yVStn?=
 =?utf-8?B?RnMrNjVKRHBCZnRNMlZpVW52dC9mcTZBeURQMTgxQVZOZDV1TjdzcWMvSGFO?=
 =?utf-8?B?QTNqU2tBMlhveGNEUkxRc3ErU1FLK0ZyYVZnbHgyT1J6R2xLS2gxbmdhaXdW?=
 =?utf-8?B?RFBuVno4Rzd1TXhiTm9pVG04NDYramo2OUJiV3ZWc3plZzR0TWdqQmJUdlZT?=
 =?utf-8?B?NDJOVm5tZkFzbE9VTW5VYlFKN0dzOEx1YzMrOGV4bGlzNVlRSGtydTNtZDgw?=
 =?utf-8?B?YkVxNTFxaTJwVUQwYlBlZUtsVXpuK1NYOGNiWWx6MWJsY3pOMElCMFlURE00?=
 =?utf-8?B?ekI5amhCckFWQXpJWk5HRG1nbEhYU3FiNnh6bUV3RkNHQzFOQ2x5RTZuRUZX?=
 =?utf-8?B?U2x4MElqbVZrN2FnaTBlTWxOQi83bXoxei80UEpXL3FXalc5Mlc3ckNoWllN?=
 =?utf-8?Q?sGkXFMKhxeWCPt5sSwisnnuBX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xlJUsVZLQ2ZpjvCcoPS/YIIezSACFEAX30UvWjzaEfYUcHLrdGeZKZvzR67xXEY0m8uctutxgZGFHuLgfv8yemhucE53qXUmYxLS9VKsv5/TnNdxLyla14yyFL/9IS4avLcedpn7MUxm3ir2Nr/XrJcqYSvHvZIvO8imh3lLtbiGaA9g2j7YTVq7esyEXCDLxp+AqZZi47cC6VyeKJ6u/Di5ERb+GTWJk05h6At6zy5+d1OG0sugzEmOaswHVS4ixLGWpWq/ja52YvLcqQAe7TTipv8EgvRzqpIY3kRQi2JrmjnP3sp18/Dn5EXnzEOfA8Q9/xjSxr5Y977Ek3vpD0sQe7axPh28tnmWVJtwVuqlwbuxOkiGCqe0SBfu2+a0QrEalqRoneUjIua3PgcDai2HPpDWLbX2GPSENfpXrRuXwEw2zcJ4CtMyPqASyALWYzBmwkt3SlRK2JoIvqVCJltzS6Bq6pmk2SegP6LnZ5mC/fsQQdQHcFIMtbjryeseq33KRqQnhOz33kFnndeFLnr3TjR/TH1ZZkMRXDRaoZZB2OcemQ9+8ixve7noIUkifOLVmbhHT7nlG/ukGCG17MQuxM91AVD6bIZ6dZVIYHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeaa627-8275-4b0c-9562-08ddbdb83787
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 00:41:46.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp6L9TxQhcxbumSINtfqdCSJtqsPUsDlVGGgqJ/hTT0N/PoI5s7Za/8wOTuqQjNm0Q6MfZ4dErlLmeec5l7c/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAwNCBTYWx0ZWRfX9+QJFrvesuSy HBK1S/rX1OW1HtH1YbjA0rK0yrHQ07Q3lHW6bb73ixFcCWCp9X1a04NlWbg6BiR1SO/37IqG19R vv+OM4zFSXrFUHme4dqo3SLIp4IuA+mhaAeUKpFtQnfIGbCnZrKT36BN1ri1toSkTVpMPoMwxea
 xYScEe75EjOXsD6Oq4e05f5TE6j8niPy5PfiBgo5hx8bZXjlPrHjwEdjQbSo7K/l7IOcmMbKkpv wwI4+TJWe4pFMi3DM9j49iEPDyWvB/PmoeKheS6yejgedLpFIZb6RTa3epYTo+8mPYN7AC+RdRz vCqmQvDxYpPOVJJLDlnI4YPxK2QyuGUOn1EETHWxe1ctKx56K2UDptWDBsQskiPuJ2BMaeFYq8T
 KS6W7LnuK+p0q62GWPYHMrKCFvkhWKDeX52U5R0S0KzcLbgrkdCSFmMt6TC3zIJcpIRgJxrU
X-Authority-Analysis: v=2.4 cv=C9npyRP+ c=1 sm=1 tr=0 ts=686c694d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=FdOQacZ0O2t5vRTRSiQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jivxQN50FfLd8kbx9bgg7s0tO-p8NSDw
X-Proofpoint-ORIG-GUID: jivxQN50FfLd8kbx9bgg7s0tO-p8NSDw

Hi Tim and Chenyu,


On 6/18/25 11:27, Tim Chen wrote:
> Cache-aware scheduling is designed to aggregate threads into their
> preferred LLC, either via the task wake up path or the load balancing
> path. One side effect is that when the preferred LLC is saturated,
> more threads will continue to be stacked on it, degrading the workload's
> latency. A strategy is needed to prevent this aggregation from going too
> far such that the preferred LLC is too overloaded.
> 
> Introduce helper function _get_migrate_hint() to implement the LLC
> migration policy:
> 
> 1) A task is aggregated to its preferred LLC if both source/dest LLC
>    are not too busy (<50% utilization, tunable), or the preferred
>    LLC will not be too out of balanced from the non preferred LLC
>    (>20% utilization, tunable, close to imbalance_pct of the LLC
>    domain).
> 2) Allow a task to be moved from the preferred LLC to the
>    non-preferred one if the non-preferred LLC will not be too out
>    of balanced from the preferred prompting an aggregation task
>    migration later.  We are still experimenting with the aggregation
>    and migration policy. Some other possibilities are policy based
>    on LLC's load or average number of tasks running.  Those could
>    be tried out by tweaking _get_migrate_hint().
> 
> The function _get_migrate_hint() returns migration suggestions for the upper-le
> +__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
> +__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
> +


I think this patch has a great potential.

Since _get_migrate_hint() is tied to an individual task anyway, why not add a
per-task llc_aggr_imb which defaults to the sysctl one? Tasks have different
preferences for llc stacking, they can all be running in the same system at the
same time. This way you can offer a greater deal of optimization without much
burden to others.

Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE? Does setting
sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?

Thanks,
Libo

> +static enum llc_mig_hint _get_migrate_hint(int src_cpu, int dst_cpu,
> +					   unsigned long tsk_util,
> +					   bool to_pref)
> +{
> +	unsigned long src_util, dst_util, src_cap, dst_cap;
> +
> +	if (cpus_share_cache(src_cpu, dst_cpu))
> +		return mig_allow;
> +
> +	if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
> +	    !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
> +		return mig_allow;
> +
> +	if (!fits_llc_capacity(dst_util, dst_cap) &&
> +	    !fits_llc_capacity(src_util, src_cap))
> +		return mig_ignore;
> +
> +	src_util = src_util < tsk_util ? 0 : src_util - tsk_util;
> +	dst_util = dst_util + tsk_util;
> +	if (to_pref) {
> +		/*
> +		 * sysctl_llc_aggr_imb is the imbalance allowed between
> +		 * preferred LLC and non-preferred LLC.
> +		 * Don't migrate if we will get preferred LLC too
> +		 * heavily loaded and if the dest is much busier
> +		 * than the src, in which case migration will
> +		 * increase the imbalance too much.
> +		 */
> +		if (!fits_llc_capacity(dst_util, dst_cap) &&
> +		    util_greater(dst_util, src_util))
> +			return mig_forbid;
> +	} else {
> +		/*
> +		 * Don't migrate if we will leave preferred LLC
> +		 * too idle, or if this migration leads to the
> +		 * non-preferred LLC falls within sysctl_aggr_imb percent
> +		 * of preferred LLC, leading to migration again
> +		 * back to preferred LLC.
> +		 */
> +		if (fits_llc_capacity(src_util, src_cap) ||
> +		    !util_greater(src_util, dst_util))
> +			return mig_forbid;
> +	}
> +	return mig_allow;
> +}



