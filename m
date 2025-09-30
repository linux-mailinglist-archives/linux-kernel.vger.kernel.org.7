Return-Path: <linux-kernel+bounces-837547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA8FBAC89E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6831719281EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4262F6560;
	Tue, 30 Sep 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OBb9IGeJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wsowi/ef"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722F1C4A0A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228970; cv=fail; b=PxMYXNnon6ceibi3jqsTNtZpeRm60C5qJLzDD+yT3fiIuVTVaeEadBqiIs4bywciD0gO6NIyjXW/jlRls79jSnbN6Dz6N6ExIqFX5xXbbWDedNET2M9An7Tc+JODnUcDuswX6HeY01gISCiU6de3H6C9bC5bR0gfVH1+rAEoAkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228970; c=relaxed/simple;
	bh=SVcuGHdAunL9zNGoyEk1fUz3w97M+t9wVz6HUZ5CfLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=UqjGspxr0d4N7egkxAKHjU2ZlNzVfcS3mF0ED7Ktuzg7WYdq3n85SGJ+CFUOPzvQU1228Ab75zRXZeu05aqAarbr5O/RLFapHYE++trGXOFe8xBxOcH+BoiGdyj5oQ07/vH3nGtJBEDrZOF4TmrdE4Y/PE6/mIFdvlYpUimBjSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OBb9IGeJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wsowi/ef; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UAdT19002540;
	Tue, 30 Sep 2025 10:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=SVcuGHdAunL9zNGoyEk1fUz3w97M+
	t9wVz6HUZ5CfLU=; b=OBb9IGeJtCfKBP2f891Qoo8p5omsRVkPBlXw+rnquoC+K
	ITOuzB4uXHt3h62Ejy0C6fK1SovVTnb/D9nwlYPskimSdQw8XB/v00yBjnOxjdTz
	j+xq/kTRk3IMEQNCsw+gTEtm23nGaLqRVJ7kuXcS9unl1win9zHX01Vxo8V5sMjL
	ZQimEem2MN/+GSBvgn4K5wv6PBTrjhHyY2em0lmA53j0OVYBpw5byCkE5asxy1Un
	yr9N8U0/iRqyTykFAlEvnw33zUThPS2C7stafdTIXm0IXwhA6MQDrhMka6WfIHBB
	g3dGQKCoSsX2asIAVQmp6ikpHEOeJmEPDaDp2yaVg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gdn2g07k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 10:42:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8HXsx037381;
	Tue, 30 Sep 2025 10:42:36 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7vp47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 10:42:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENRssfdiY9OtxQ2ZUosrpnY9+jsJ/agiM6tOwI/95czvNYL1Jt1OJlTFDrJSJVkS3ppA4Eih5TWk4LbusL+Iw/T10BVJiqnN5klPU1/rlgx/3I0cd3todOrOFg906TKKQUR9j0cs4uusoDsqTLVGPBplT1EcOjGiEBY+hjfKnqtgWwRtTgMeAgM0+wLsrbuw0iy4OLhNhv8JF3neO8G+LftChVq9bAb+cz+Ys36p7ItuFdKbI7zA+kuNysDQwfGpebf7A3sUJ9DqRq3G6WUwc+e/RR6CEeA7aslVhCSmL644RTYeWAN+0o0HqnZa8lCWJui2SjWBtpkleSwYJLvFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVcuGHdAunL9zNGoyEk1fUz3w97M+t9wVz6HUZ5CfLU=;
 b=snmpjW6/BPclddyezvQUOXrr6yQcAHrZFWSkgZvZZYKrER8DJPpGVgJrAFZxnlE8SlK0Vb3SK/1j+GcSDMuUF/6HIgE0VQAKBR0d0HTCBMNsCG6kiPTSufkQudNSA/yAXOFu47Jspbso2xjBeFjfOw/pR+4UxPHudGEbfeqxKEhOcK0l+wUWmd53UCX+VZq+HKEhAtBPy/Y1NWjOn1OpilE7gOFBrMMYLRgCbky/Kr0TQaqXRA1gqgN7WkESF77TYn2SF2yyE7znyHGjKllLc6PxIGY/oDA8heYay3PGg9BN4sda7lGn47fNXM1mcOZfkS9KdF706o6Ls2z8VvfwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVcuGHdAunL9zNGoyEk1fUz3w97M+t9wVz6HUZ5CfLU=;
 b=wsowi/efC3Y5VJzXBHvrI/LogFD2h5nGqig7zjwTD7kTdhXCd+zYiQ9I2J5ZYKlaaKNAR1BQLf9pPs6QIyabzpu2Vm04S+nbf2dAoOElfveCHXZGIe6Iy5k28KLvN3H/7KiACGkFwTwBkPFjQWifY3UqRRSmPQnbS+7UQUv/jbY=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 10:42:32 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 10:42:31 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "gregkh@kernel.org" <gregkh@kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer can
 contain the reserved report ID
Thread-Topic: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Thread-Index: AQHcMfbs42m5VzmjfEqfsO7mm+LibQ==
Date: Tue, 30 Sep 2025 10:42:31 +0000
Message-ID: <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
In-Reply-To: <2025072818-CVE-2025-38495-3b28@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|SJ2PR10MB7758:EE_
x-ms-office365-filtering-correlation-id: c9267f6a-1b15-4e21-3f13-08de000e0f43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?c04rTXFiSU8vV2J1UlY5MG9BQytCNEF1VkZacjE5N0FwSWpwVDBOclpNQ2ZI?=
 =?utf-8?B?a2RydDcvWXNubmpmc1orbzdjMlRUQkRhbVZVbk1qU2VMSlhGKzN6ek9tZFNC?=
 =?utf-8?B?bFY4bHhrZzNZVEJMbFdXL2s3YjlHR2lpdHRHdm1GZktnTGJOREtFSkxEdGRK?=
 =?utf-8?B?VDhySVdnY3hqdjA4VE1PbWg5aEVuZHV6YnVCSWR1cHFzaGRXWk15TW5pRzlu?=
 =?utf-8?B?M0lWTjJTTVA3c054WTBmMXpnU0NrWUZrKzNZZVlmZ01JR1p6bTFQQlcrcXlz?=
 =?utf-8?B?bnpKazc0bCs1M255VnhwcFdrWGs1MkFsSHpEc1RvMEU1VzlveURuNk1EK3Yr?=
 =?utf-8?B?cVhZM1g3dGdMb2dYVm11eiswQVcvUDA1T1RGTC9KMEk0QUFXQ240YnhuS3cw?=
 =?utf-8?B?VTFXcFQveStTNW12WTZMQ0RMTVdmNWNveTFTNEZBWUNJMy9SQitrU1BVSmVw?=
 =?utf-8?B?KzNPRURFZ0JWc0Q2S003c210bWhWaWpVaHJRUzF2QkVjc1JLTE0vWUVDSVlp?=
 =?utf-8?B?YnBBaDNkd29FMkVoNkovenc2UWZKWGYweTRDa0hST2xramdFSGRxMmNwQWxP?=
 =?utf-8?B?bFhjTGJ4LzRxSDB6RHhIZUxVL1B3Rm9od0F6QXhiNXBxWDQxYlRNYldha3Ey?=
 =?utf-8?B?eitrR0oxeG1FMDhNdm9jaEdCa0xyeDRabTVJUWh3UEtkUmtxakp1ajFYYzJo?=
 =?utf-8?B?VnZDa3dJU095d21hcmtMY0JmTDZkS2tXNnpXMXNOMHByR1BLVEFnTWdUdk9j?=
 =?utf-8?B?ZWVRa0g3d0JMZ2NsRmJ5MEdjVHV5M29admMraWRraFVrN1ZqaW5xM1ZScnFQ?=
 =?utf-8?B?UTIwcXVuczYva0s1QVgvUmNYNkxVankrYk9pamJVVWMzMGJkL3JVT3JMSVRY?=
 =?utf-8?B?Wit4T3NpK1BmNHRPVnFhTkU5NHJWMUczM294RXNIWVpXd1BjTWdGZGhmN3RL?=
 =?utf-8?B?ekZIQmxYN1BCMVdvN2FjOVhpU1hmYnJvWUk4c0hEckNVY0tmeDBxY201ZFN2?=
 =?utf-8?B?ZHdFNEZFVlpjcUJES0pzdFN4bDdONjZmdkorVElkQy9tdFM3QTEzUWNndmZh?=
 =?utf-8?B?dENVcVN6d1FHNmRHQUlzYnh5MUtOWjdzOG5DNTdtN3dxL2FFR0ZlVFd4Q1d3?=
 =?utf-8?B?SXVxYWlqRFhBaHRONHZJME91cjZLaGR2T3lJbnVvMXVCRDZoUHNCWlB5bVpF?=
 =?utf-8?B?bVVVajkwam5GQ0YzTmhFOWFOK0R0WHhoQmQ2L0lOQnduQXlqbkZBQzNsN3dk?=
 =?utf-8?B?WkNiYWZhek44a1JLb1FzdUVtM2ZnNUREWGNVUUpZa1Rkb2lrZE9VSVoybVFG?=
 =?utf-8?B?cWJ1b1dpWGxib1hOd2Y1K2hvby9yMlhrSWF5c3dDR2tVcTF4TTRSeUtKTm5E?=
 =?utf-8?B?T0ZmU2swUFBoTC9OYWRUZm1zdFdDOVAvc0dnbytyS3RHOStSVStuRk9pVFIw?=
 =?utf-8?B?WWFoaDVEK084ZUpnd0FXQTRqZ3kxUUhCWHpxUlFUWkFvajN2OCthL1VrVFZw?=
 =?utf-8?B?Q3RTSkNLSldzYWRaQ3dVeXNBVmdJdFFXb1ZtdnFVVDIzSjd0UXdPREVrUTF2?=
 =?utf-8?B?ZUpidmVDSzlhRjl3YklKcEg0T3A4b0s2NUQ1Q1BDakpndytQZEdMTEk0citM?=
 =?utf-8?B?UzRzbk5WcTFjejM4aEJ6eWE2OXAzVXZVb0ZoOEQzUWtla0h5eHhJZHZmL1B0?=
 =?utf-8?B?LzZyQTRwRVIrd2liZlZHN2MyM0FpNXg2MEpUTXJscVpRRlpmNm9xdDFjYWs5?=
 =?utf-8?B?ZGE0MWdmNjZqa0cxdXlyempSMDNGajdDUEF1ZzEraElXVnJ2YnVUVnNQRzZC?=
 =?utf-8?B?MHZLYjVBZmswSmE0Y3N4MGtuOEV3MEhQaklmeDRCRkQrU3pjQ1pRemRBaW03?=
 =?utf-8?B?dlIyZ2taek5yczRia2hZUkNqMXNEVmRZVEZkNitadDd4Nm9ydTNRYWVNVjlN?=
 =?utf-8?B?dlZBaDdqRVd1N1JNMURlanlvSEo4c0R2eWE0RDYrYy9sNlZvL1hjalZaMFVF?=
 =?utf-8?B?MUptWkRCUmlOWUFhamx4UWZ1bGJ5OUlJWVZ6c3FiQm5qOTFJZjBML2NQa3J2?=
 =?utf-8?Q?uqKTQc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmRDd3dZWmdsUGJoUDVKVVV5cXJudG44dnRmc3IxMzRiWHdqcE1Vd3lEd0Rj?=
 =?utf-8?B?Ymh5eG43cXhmQ25qZUo3ZGRFVmVnTThBL21kUm1lam04alUyVjJXMEEyOWVz?=
 =?utf-8?B?UTdhaWxWTDEwV1hWZ2kvSktldmFQcjZ1N2wyaTh2MW1kV0lXcEcxUzBQREdu?=
 =?utf-8?B?OG5VdElZWkNObDF0TWUzdXVXa013UGs4ZmRYcGFUblc1d2IrYjNhdHV1YXo4?=
 =?utf-8?B?MHBKdHRrWXYrYUFzR0QyNEZtd0RRY2hzakxiTnFLa2g1SFZxb0E4R0M4ZkZZ?=
 =?utf-8?B?ckdDZG80Z1dnZmRaajlWRElIcnp5SE5uMnQ3Mko5WXg0MENCYWhnMEhvSlI5?=
 =?utf-8?B?Z3FnT1JiNDlZVCtHQUtobm5hSitUWko5Z3dvOUd2NEdXdHdRbU5GMUoxU0ZY?=
 =?utf-8?B?RjVSNVAyRTBNRzJjeUdYZUR1MzJZcHltSko1RThwbXV0bFB0bllLWkZRWTU0?=
 =?utf-8?B?VElCMkwzdWpIcTUrdE1rNmZ0djNkRFZJN1hPZGxhaDdleHBvbDAxbHlCbnNo?=
 =?utf-8?B?czhabWpLR0lncU9Nb2t2MlVTTnY2Q0pRNlJIVjZ1MjhvOXM1anFackp0SWNW?=
 =?utf-8?B?cGZSQS9DNTNBM0lpVXo4UUNtZDlaNDlqUENvWmZQUWQxSE1ST283TjVsOTJp?=
 =?utf-8?B?ZTVzUlUvdDZvWnQxaWhZLzQ4ei84ZE1aclFUNnJmaUhyRU9YRENuUGVITUZY?=
 =?utf-8?B?Z25sUVhqQjhXc2R4YmNkd2QyRkFXUFZTRFJiNFJzT1RpTllQalJCSnh5Z2RJ?=
 =?utf-8?B?MUdCSWxRK3duQXNDdTRQbUxKMHRTWGRoU1RvK0VBbzdITitBT2l2dGcrVWlI?=
 =?utf-8?B?a0lRNzhzK3hrKy9BOTcxM2E1bytMeU5DN1BhdWE4bU8zR25HV1NDU01VQXMv?=
 =?utf-8?B?cVpzRDBPbFNYc0FKTmtna3R2QlpoK1MvdWVycmlYREM5Wkp1c2VQVExHdlhv?=
 =?utf-8?B?eUhyQjFnZmJrU3JSN296NVNkNU5TNVBqM1JJTXRranNSNnlYYmtXODk1UVFn?=
 =?utf-8?B?T1Q1U3YrYWFVVXh4NzRNclplV3lkNENJVE4rZUFxZ3hieWNqdnBIcWtTc2F6?=
 =?utf-8?B?VUtEUVhUdTRpSnVuQzhMd2JCRFlNVGZwVmttbGRLS0pSS05YeWl0Z0t4OWdp?=
 =?utf-8?B?anh0aDZvT2N5TitmVkowMldDSWxHN0RZQ0RHay9HR1IzTm1qQW96NDhVSVRT?=
 =?utf-8?B?c2Vvak1kSVJBc3lZdDFXWjdKZXdDVFhtb2hROUxIczdrSVlqTi9rNzJMVnNl?=
 =?utf-8?B?MFQ2OFBkQklORkNQZ3l4bk9YQTFLQVF1alpYWmE0aDJwanVmVmVNVkxGcVZK?=
 =?utf-8?B?R2hTTElNakRvN0MzYkU4K3dzV24vYnBVaDVDRUl4SzNIUTRUcHVZYTFRL2Jy?=
 =?utf-8?B?cFBXK0pwMUtaalljamNlV0VZVWE5Q21VN2gzY2RFUCtQbTNBNWpvQWFtTTM4?=
 =?utf-8?B?TC9NckZTNmt6ZDQzMUZUdUo4dHR5Nk1Bem42RzA0Tyt0VyttU3k3Qzdldng2?=
 =?utf-8?B?RlBvL3F5ZERnWkRkUlp4S2w2dXVxRk5xcU0wYUZ5bTRTMG9KMzFXT2ZuUG9j?=
 =?utf-8?B?cVM3U0lrbVpPbGJaK3RPWk8zZEpwald0Y0drWlVsVERYMi9tTVNaUVZjeVFO?=
 =?utf-8?B?K3lwRTlTcVFMT0FTTnRXdk9oSjBENVlhOEoxL0kxMFdIcGY2bUxKRzZwaEhh?=
 =?utf-8?B?Mk1oQ2Rpd2w5ZGgrVkRONFdyQzNTOGNQQVhPTm9reUtTWUw2L0ZXbDRFazN2?=
 =?utf-8?B?WndpYS9GL2pPSWlxS1hFcmhHU1dadTk0L05aVmN0NzRRSVpsRUNIUUIveDMz?=
 =?utf-8?B?WlQ2VWI1b0JjM1AycGk4NDltUnpvekh4cENzYXE2UGIwTnhUOVdUT1F0QkZX?=
 =?utf-8?B?RkFqWml3RDY2TUZiQXo2eW5UOWVUZ2hDMThpMEJKSTR0WXdqYVhLeW11SUJB?=
 =?utf-8?B?T2J4enV6Tk1YZmwwSUliNFMyOFZKeE9RanNVSEExT1U3bjJTbEgyMDlRS2hT?=
 =?utf-8?B?NHRvMkwyV2tIa0dsR1lkdllGbjRkWExzc2ZvZndiZkxlZDlBdmJRUXd5QmhP?=
 =?utf-8?B?SW5rc1hiOU9QL0NZQjlMazhNWDJuNTZaY2l5bFhJcm83bXVZTmxkV1VXbHpB?=
 =?utf-8?B?QmtxdlBMK3dkV3d1SkI3N1VhWUV4WmJhTDVJZitqdjBTVTAvbWhDRm5FSWdy?=
 =?utf-8?B?d3E2cThFeWczV1NUNG44NlBaMEtITENmdFBGTVBiU3hRMGNFSDRabTNXWGhw?=
 =?utf-8?B?RzFsamtidjlmZVNPQysxV3MxOSt3PT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-OmuRW9MgWN/JYxclYsS2"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aVEZpiEHgumZdXDwk8mbCy1ZgUiSjC1HXDpa8Laj+airswtVIwQbtYF6AhoV7Be6Q+BfpeS+Iu5Y0n6zEkHKZB5UoQmaBzNSMOpt05pV94RO/o/CZ6F3KrK2vnA6LOI/nIJt2+hQiSo5NiJiUZG//KiCD8m6uMBPEBxU0sEj+qt05SVhk4cemKHgZS1bgU0TyW5JtT5vxbQL9v3vRZtQUOy3NIGrGN53cQ49Sf9HjBFJfJkguqbmaCZP8TiXMUSb3X69+oZf4IgxhLeDitbG+3uJlHNUObNPpRYTkuPQPtepwFQ1FBidP14cACM4H3AofmjycS6WF883lr0x5q+IiXedvMezP2P0NHy7mEMoOfwNGNfdY8aGWs4XwihDb+DwgvdKmStD60L12eD/3pXs99EgfgypPHCIpplj/mTy23lEGE5V3Ia7nJycR9p7xeBSbw+dMqTX0CSy5a9Xl9V3L2s8Dkfn9/HT4B9aTA4ytsAGGxmg0XQAzyNIWRo97jZ5D7AiuGmQbNWkcMQZtrQrBwTq29UtlI2Jo+ZxmXUYYMz/zkPw31/TDu19otsymMK0Rieg+Pwy0AWOadIkKugJmzA2dRMt5ZfBxrx5EjXSFDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9267f6a-1b15-4e21-3f13-08de000e0f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 10:42:31.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5J22EoJtwwD7/8awt/GQvgs/yB7LbCNegeFZG6C3saFtRwNecwrl/o04cz+JN0HyZREkSMUeLGJLpYpflTZNBBsjOCuraTDutA/zm1El3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300094
X-Proofpoint-GUID: rlkhzkvBupox4IeG4YWJUmUq9ug9mk5S
X-Proofpoint-ORIG-GUID: rlkhzkvBupox4IeG4YWJUmUq9ug9mk5S
X-Authority-Analysis: v=2.4 cv=JdexbEKV c=1 sm=1 tr=0 ts=68dbb41e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=UjjhGpaVWVAYNAOKgxsA:9 a=QEXdDO2ut3YA:10 a=UTHPhK8xD_7VVb9Qe3oA:9
 a=FfaGCDsud1wA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA5MyBTYWx0ZWRfXwACgT9+skOxa
 Q2zpzWVdgrValF2z/T6/svOoCTaFMll3nPEMT3z5lqfd1WBuVcpeec40MwfnlpWvuUW7Nz12YPF
 lKqWq60tx42pkVZ7uKRnotY7droJyuXnCxecBdkEkay5xef6zV1qT/Wqlp50My0uO+r94C+AAyO
 R1LwLrIXb/q1RuxBigEFeWPWrwTXQTpkHxzgb5/bUbnnqPf4qs1OPnwR0N0Rq5FdhKKzqmY5aFb
 SQmqD/tluIy1IyHZrUpynaIfhkuUvDQUne3xPUFiyjhhXQfmmeMhCKTuSvIF7fNYAJaE84IEBA4
 NVJF3g1Whnl3ivffpUhsO8lLkvI87zwZtPi0ZmclmYsz+iyUSTpGAC80Q3op39O81wc6J63YuLj
 N19UOcl5XeEIZXJWR53f7HXMVTx3CQ==

--=-OmuRW9MgWN/JYxclYsS2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 13:22:37 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> HID: core: ensure the allocated report buffer can contain the reserved re=
port ID
>=20
> When the report ID is not used, the low level transport drivers expect
> the first byte to be 0. However, currently the allocated buffer not
> account for that extra byte, meaning that instead of having 8 guaranteed
> bytes for implement to be working, we only have 7.
>=20
> The Linux kernel CVE team has assigned CVE-2025-38495 to this issue.

This commit prepares for the next commit in the patch series. See
https://lore.kernel.org/all/20250710-report-size-null-v2-0-ccf922b7c4e5@ker=
nel.org/

The patch series has 3 commits, with the main fix being the middle
commit "HID: core: ensure __hid_request reserves the report ID as the
first byte".

Unfortunately, the 1st and 3rd commit has CVE numbers assigned to them
but not the actual fix.

Please assign CVE number to the middle commit.

Segue: Can we not have same CVE number for a patch series fixing a
vuln?

Thanks,
Siddh

--=-OmuRW9MgWN/JYxclYsS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjbtA8ACgkQBwq/MEwk
8iqCVQ//Q6Gyuyvf93BfNEQ08Y+PjrWWp1QSadjuGZy6GEclLYuD/yonfJBUB38M
NytnclYolyGRnPFmglUn4VqJUfN3dqveTcgxJe25kTuTmGW2pYcicSoUTeWmRzEC
3BqfzGzHY50enRiuRBXDiWxwW/Ei9CS69L8Dvhqcq8864ggC68IWRC8UJ7jgLHxv
W+T5Nv/zakPCL2D2GdIP+X3jMX98Ex1KGNA4PtWuhOWMKZazgmsgVEaudwhaIm/O
MWMpPh9+03betOWX8TtRZ7ZiEMIPLg7cQy8X6cuZ5DC6zPyG1PAMzfBFrrwiTwBE
1drPZTu9bOfSS5hd4GnGqYEKAtgkg6oIK6Oq7bBpOpDLwHWhiq7oKMoi19rTktbp
oP0JKBZ7nxkOsk7xp+GT6ojsCng4hOVSIUGmA4kZiECHSgMCXKzFftAVwz7Nph1+
2MJ9frxjmsrBBLRxQPGTnsCuiOBQNRai8Xk51990CiIBQ34wp7BDn+QKgD/2TBCM
cZPYZhfrqa/ksP4y+M7CJoLUaUcPcEyblDfOQMZTD+h0DI32TLguQNyuJG9j6Jde
HJ4NHJiM00wyC4NRuP1Y/cy5y08hMN5m6QcZXklfVsGv19M8yrrFR1DoJgampZ+x
YfzvFdHDTL9eQjC2nT+a/lBUN1pv3rzXQ57rjHBGZbOF2Ugp2OI=
=lst3
-----END PGP SIGNATURE-----

--=-OmuRW9MgWN/JYxclYsS2--

