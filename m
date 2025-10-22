Return-Path: <linux-kernel+bounces-865595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A893BFD8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A1C3AD88C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88435B138;
	Wed, 22 Oct 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="g4VyMj98";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="N2BtOtR9"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAE42048
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153352; cv=fail; b=sBkEx5Vjbb2DNHBJ3fh2PcHUP7LQopAD0UfK9ssvm/7F+xkBZwL+Df5bw9JHQZqdzd1/m7HUngcQEhilSSNBp9ME4L6gG0v31k07K/iBZx9RkJNpRJY6jC8Vsu/R7bZqBXHmqvi+0Y5Q5Fwo6rxeNnEYiJ9qpdrRO8zx5jtaOTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153352; c=relaxed/simple;
	bh=/GTlAQMpXEmYv29r3HAKT+34QLqUaAGLfaatYNanVrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ar2xI2+omQ9cuv4smGPwRXqqW+1Til/dNjLMcfAwCkBk7hik2XwCuDG4dAtUilS9LI0iCi9mpuZ/CpiNW0qPbz01iyNuNsq353tUDftcRFeS89Go9D2zWnKgLU1FQtgK4y0xkMc30nSFQcfZVRc8vvIY4LwCMNV5QJw29LR0hhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=g4VyMj98; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=N2BtOtR9; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MHCCxN2162042;
	Wed, 22 Oct 2025 10:15:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=/GTlAQMpXEmYv29r3HAKT+34QLqUaAGLfaatYNanV
	rk=; b=g4VyMj98fLeymNF3RL0t+Z/f7DyN8RSdTHMlhVAcCDbqwCwCdBpvTNhFb
	Y4fG3xdql6wz4rikhso7kzILPP6TC/ZyOtNQLX8LnpM53GtiBON8IqXlDXB99UH2
	8RfT9IQM7uy0s639ZwKpno/tswszp1p6+UXmRr4LJr955UXsY3ILpzyQCaBcoX4h
	nxld9KHjhsUhKxoErO+e3DLkWOkUoGnIeVtPXydcF+Q4HMC4VOchb7b6NnYidmlH
	3phTyaw6P5GWpya41LGttoo+ii0REkojnIsqZ7yxqYkRoctkMQUS/ZEiylX6l/KB
	K68Rjao+irPktzztK1XWEQ+3yVB/w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022093.outbound.protection.outlook.com [52.101.48.93])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49xyc00q1s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wig822lE8MdA1497Tol4A0K6i7gZ92a13hxt+1/6oH4WLxciM/sm6r0Q1v1Mss45sO4blicOmJBXHL+wo9mRwN3NKs81lp4DnJQIymJT/zsLBLAit8C9RlZLahfs61xwQTZpRkw+D/rAQM3FEsAQsYfOxPapWv1Dn0asyQBoUrfQlqnSEWqHcY5F8TczIBoOlWc36oHYO8cFp5GXTunEILiwhLVEcAz4+QJZDPWZIPOhcS1tMP8vl17i8/KMMlma34eSLHoHJGa7ZCbZfPVeyAaDiZxvpUP0kgcesFgnHVk/OCKKgqLMij+bSftpSQzEfA1yHAVVRUKfT6XyJdAKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GTlAQMpXEmYv29r3HAKT+34QLqUaAGLfaatYNanVrk=;
 b=aYySnDSL4teEO4jWSjP3vxCPyOPcKwLdqJfmBYImTkc9s6lTL15RqFtnVsPUqZ4zpaSLGPkdPeKyYW41hOCGq7hgFMCjucvEqeu+7bqZGry1+UQeTD1KMuO9blsnoLg5f4F5BmspHx/vG48ee0KihTCrSucQMoQU+k+Bq/mEPRSOamWL8I0x9NLPCH8CCPGZXy4Cv6Oi/SMjGnaLDCxii+RYYX0DXVQy9YXfLTOjV74gDl+EggYdw/dCNxUHwbqPi7rzkoV5Y1hxAJJ+cLSP+4/cIlPmtRL4Wf/0G8Vc59kbfYujB087BNbHBb8EH+tvG9wnlWW6IdxyRELnYPe8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GTlAQMpXEmYv29r3HAKT+34QLqUaAGLfaatYNanVrk=;
 b=N2BtOtR9xJjCRXR8kvvdLz3gRsrVeSFyQDZxUafB2YplVQL6k2/UhffMg+6bDpZQ5y5S0bac3CyCZDxG1I0cWbjQwprhlV0jNFmdxGsXiE1mDuUGRVpwGdbR9zcBVtJQDaHYa+96Dp6b6mzkO0u1W9So0CfOQ1s7J4GElJUFKr2Bc0wjSYxo5ennqgA5h31wxWqQaxbNl46fIDQkJ4vsolbPVW6oIirkcCL9ZCodPf2a9yJumaIvzEfxxfGOXcXxKmgVI5ncsjQ8Pd24BsRmleR/ALB3YCHSYGyempn4ECvQj5AUZus9G4LwkG8huy0B2OyUHa5d2l6XgZynWI2IGA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ2PR02MB9923.namprd02.prod.outlook.com
 (2603:10b6:a03:544::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 17:15:01 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 17:14:58 +0000
From: Jon Kohler <jon@nutanix.com>
To: Sohil Mehta <sohil.mehta@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org"
	<x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin"
	<hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf
	<jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Dave
 Hansen <dave.hansen@intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Alex
 Murray <alex.murray@canonical.com>,
        Andrew Cooper
	<andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Old microcode CPU matching issue - x86/microcode/intel: Refresh the
 revisions that determine old_microcode
Thread-Topic: Old microcode CPU matching issue - x86/microcode/intel: Refresh
 the revisions that determine old_microcode
Thread-Index: AQHcQ3dkJdfO8V2RAEuU2xSk7F4P0w==
Date: Wed, 22 Oct 2025 17:14:58 +0000
Message-ID: <38660F8F-499E-48CD-B58B-4822228A5941@nutanix.com>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
In-Reply-To: <20250818190137.3525414-2-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ2PR02MB9923:EE_
x-ms-office365-filtering-correlation-id: 5552b463-9355-4ca0-8575-08de118e8772
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVAzVGRwakN3RzdrUUtpdnBGbDhMQWdVZk9YbTZydUV5SDA2NEs0WWdXbTV6?=
 =?utf-8?B?ZitNNnBGQngwL2I1T0dtOEpucUxldk9pNDVhaFVCaW1DcUpDclFScFl1OExq?=
 =?utf-8?B?cFNJYmxrb0RNazc0Q2d2RjJocXk3c2IxUERKYkl4NXo5NTlNVk5lWFh4NXVW?=
 =?utf-8?B?NTloL3FyRTVKdUNwOUhMVWRNMVhEL2s1QUVnKzljRkdJbFVzN2pJMXN5RHdT?=
 =?utf-8?B?ZW1aZFlhZXc2am9yZmI0eXVwTndnaHNrbDVLRk9KWWR1TUdIVzhiK0kvWnhQ?=
 =?utf-8?B?NU8wL2tUdU9OTnJGMlB6bm96dThWa21lZnhWWnQvYmo1RHVGV2pBYjkwcVc3?=
 =?utf-8?B?eEZ3RkFtcjlaR3M3b1JveTUzbHMwMVREYTlxKytNMXRlajlpM21JU2dlV1R4?=
 =?utf-8?B?M0M5dlZ3RkJYNkViM3FWdFFWYThRb0hFTTk3TUU0djNYR2FQVGlzTWV3ZXZq?=
 =?utf-8?B?TmkzQm16K3UvQXdpNWVOY292a0JmZjZBVzBKelk3K3MrN1dyenRyZ3ljTWxx?=
 =?utf-8?B?aU9GZTAzN3hlZW5TeWYrMlF5V05pT3JQYmZPaWJ1cHBTa1krZVp3RW84RVBM?=
 =?utf-8?B?bUJ6RUJrUCtrRkpYQVpaUUdTVEhqcTRJeGk0TERwdkJnSURuaWJzS2doT084?=
 =?utf-8?B?TVI5d1hITUxCTWNsNVBLMnBoL2ZQREdXWTAwYWtaRDZjeXVxbzFwdmx1a2g2?=
 =?utf-8?B?cDFOUEtzZTFtdHZJZEErSFQ5S0xwUW1nZ3ZKdEU5VE02SC9RRmhiNVV5RHp0?=
 =?utf-8?B?aDdWVHFLaU5QQzF5VU9wZ1JQSUxWaWhLbUM0M1JSY0xVVHV2NXNpZUtoSU1P?=
 =?utf-8?B?SzFaVGs5clJyWWs1ZHM0RXBXa3VCdjJoMzNFazUzME50cXBaS3M4UTNaQmJa?=
 =?utf-8?B?OXl4cEhMb0hGMzhFeXBwTmRVQklpMjZ3b2Z5T2RneWNmVWlwVUFFMnNwZmsv?=
 =?utf-8?B?d0xQMXJpaVJDVkVUVGNMWlpwUGFoT2p3eGZFVmlEcUlac1RYbVo0ZTkySlBa?=
 =?utf-8?B?ZjRwRTNNc2JYVWpMbmgrYWtCaGtqNzZrSjlPSTBDVXJaemRUR2E0bkR6bjBV?=
 =?utf-8?B?M0lPV2lTbWFhdzNnOWY1cFJTNEZDcUE5WHF1d2pGY3MrQ3dBcFlHN21ZcWhz?=
 =?utf-8?B?OTl1QjZmUVF0ZDhPTk9jbWoxejZtMGRyLzl4NkRMZ0FNUWMreENHWU1OeDg5?=
 =?utf-8?B?MzZyaHVWRW5YRDlpczVrMVlYWjZHcDJ6SUZXZlEyRTlxZGVsYUlMd0xxZkFz?=
 =?utf-8?B?TWxVL0VycTNqNFJuQ2tBcXI0TGw0c3lrTEhhL2FWSmVoMGVtTk82SjQ5ZTlk?=
 =?utf-8?B?ZE9zcUQxb3BTRERlbDBSaVluSlhIYUlPMkJBbUlQRG1JOEtqd3lSQWNtaUs5?=
 =?utf-8?B?ODBrOU8vRWZmSUx2MGthMmFsamxPWkhWVlRkeXAxM1dUZUt0NS9YT1BlMVZ4?=
 =?utf-8?B?WmFBYzJJbzlKMVo3VUtCTTR1YWpNL0pWOXN6RzFleUE3dkFlMWxXSzRiZWdi?=
 =?utf-8?B?QitrME1yVVJqRE5hMW90TGoyWUdOdGw0VEx0RzJDS09CV1QvQ2hyOXFaOW9j?=
 =?utf-8?B?amcyVDRERlcvWm5BZEZpMkJPVGhYWDZwYU9mdE5WcnROUXdCYTNXQWF0TW81?=
 =?utf-8?B?RVVaUlNMTkd2VmhrMndiRldud1FqV0RGZi83K1plUnZoRHdNTFVYQVRDOVRI?=
 =?utf-8?B?TmFxS1BLMzRKc3kwQ3Z6ZjZwSS9YQzQxTFVBZEVmcEppb2NFK25MTDlKekQx?=
 =?utf-8?B?UG1qYVAzaEo1MUFIdVN3Vm5NVGgwejJFdUZlNnVsRExPTGhoV2FXZzdjWFl0?=
 =?utf-8?B?RUNsc1NNd0tqd3FTTE5aWmdWWGowbUJobTg1N0xHLzZnWkVKK2h6MWxKLzln?=
 =?utf-8?B?UStYM1BmVUxPS3NEREQwM09ZdzRPT2hhQXRHZWVvRnpVZ1VETXFRTmtmdWlD?=
 =?utf-8?B?K1BpNDVnbHFFS0puTkJUNnVqY0V4Q1NQYlRWK29mUXNvVFZGeGVZaGlnSFZH?=
 =?utf-8?B?SWFTMExPVU1FZVVCYTV5UWdjaGNNNFZRMzlTOHdvWTkwQ0FtZ3JNVXlvMUNM?=
 =?utf-8?Q?dsHIUi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2tObml5dHpvck9WVlorcDhVa1lxM2I5Y2l0SlorM1pXMExPdTV5bFlyT0pv?=
 =?utf-8?B?VTk1aEJWR1UvcnJqSjhhcWJZSnQxL2lZUkNoZUNWbXM1NXRidFVOdnZ5UE5C?=
 =?utf-8?B?Ly9VaHNkSWtDTDJjQ1FCVS9jSWN3SitvOGRvVEh4N0NiWXZZbmk1ZTByUDFW?=
 =?utf-8?B?VDFMcjVWS2RFdEtkMXdnTEo4WVAyclZZMzVLZE5YYVZQanJMYUVxdWYwS1dI?=
 =?utf-8?B?NUZHRVhua3Vmd3RkUzBRR2UrVXlXV1ZhZUlyRG8wWElDb1I4QW8xbytZbnRG?=
 =?utf-8?B?RXpoVGhsSDlZNHd5MzY2czRmVDRQWERUaHdJdVN2SlBEMTMyVzJHbVJqejU0?=
 =?utf-8?B?d1Q5NE1YUThDcjJyWldsQTNwVnp6Q1ZTRklDKzJvWnJ3UXQzYlNzcUkvVzRr?=
 =?utf-8?B?aDJHUWhWc0cyQXBIVVk3TkdQRmt1OVJjejBpNGhSS1pUT3dZc1FXaUthRWw2?=
 =?utf-8?B?M1hUNlNubHhLUS9panhrN0FKWUlNdFJNZDBYeUQyOFNPcFE3U3JORWcrTGE0?=
 =?utf-8?B?K3ZBdXlDaFBhQk1EejMvaWhnNkMrYTdBQ001SkVuejhmb0ZBNW85NGN5QjFw?=
 =?utf-8?B?QnZqWDBaYk1CN0U5dDZQSjJ3dHN0elNJSHpqRnNBN2hFRDd3SllWYUdiaUh4?=
 =?utf-8?B?ajkweWtiV3BJalk2anc0OWM1amxhSlI2OUE5RmJ4R1M5N01xK0tlT0dyV2hD?=
 =?utf-8?B?U1dEbmJ6L3lJSW5Kcy92amsyUWNNV1lWZUNmM3piYTgydjZ4NzdIcy9iR1FI?=
 =?utf-8?B?U1lUMWNROVdsdEx5Z1lOSXBEQlZmTTV6dmR3YTZYcUNpUmxZTEhFK3pRaUVn?=
 =?utf-8?B?S1k4VFVDSEhqeHpqSktYcXhrSWkxQWhHT2VxMGdDcGNpczNhTTJWN3FjeHV6?=
 =?utf-8?B?UVFNcGRGZmQyQlFVVTZTRlQxaEw2NUhjTHQ2U2RZMFp6VnNUMVNnb2hZMElQ?=
 =?utf-8?B?Yy93dmMrMmpTZXJqZWp6REthNkpzMjdrdWRDUElaWjI1R3NMZGNIY2FNUXVH?=
 =?utf-8?B?ZEZHY1ZCTVArTUlpREo5OUxRNEZMbkZZbXlRdGducTFUejZGdUdnZWVZWGps?=
 =?utf-8?B?OTRCb1NadmxYdkI0TkI3dXVVZXpnY3NvTG45ZGJPa3pKcU9qWU03eVE3Z3dX?=
 =?utf-8?B?ckN2dUdPOEI3d2psUnBGSzJmRDM0SXFVOGRSZlErUDhoNzdtak44RVZjK01M?=
 =?utf-8?B?eWhtdFVGNUVxRmlBMVVYOGFoMHQzUy8vWndjWGpGeFkvWE5UeExGZmlQTGRx?=
 =?utf-8?B?ckhaUWVVU1NlWXdGMWlVWWZidk4vbjVPZGZvNEswS2dzdk1zK1k3T1BYd2Qy?=
 =?utf-8?B?bUozSmI0Yy9iZW4vQ2NZdHZxV0FIWWNNK241dHNMejYvcC9RT09seDYyWWU3?=
 =?utf-8?B?UVFlTHYydkNZOWFJejZPMER0MTJoT1puQW1PT1dkY1B2azA5OU9sMjZkVUIx?=
 =?utf-8?B?L2xrRVhNaEtQcC9VWXBpSlU1WEp4ZDl0Yit2aVp4VFQ4dHI2VC9BQjhTQ1Bm?=
 =?utf-8?B?Q2dwNjN3eFZ2M3c5WGs5RXFKMWdIVVlXb2NNUWZYSWs2YlhRSkhkcUU3Ynkz?=
 =?utf-8?B?aUFOc2g0ZGxRZHhQSU1lVlV2WlJXdStEby91QXExazFsL1UyU1NZKzE1SW1x?=
 =?utf-8?B?Z25WN3hNMHR6b1dwSGwwa1UvcTRmUGtDWGhmdkw3NjFCMkVwVWdqbytXRFFR?=
 =?utf-8?B?am9DaVdsQURoWWVsWW93N0hvUTFWQlEwWll0UVpHV0RnMVdqR2cwemhYTjF5?=
 =?utf-8?B?bjNFdGVoQml5YWkxQ2E5RFhPQXpTTHpyUlJmaEZyRWFpM0dDcDMxUk4xbUJ6?=
 =?utf-8?B?Y1NUVEdTTStEME14czZNNTJuYkFmMWhJSTdlOUlPcXEyQlJCM2pYbVVwUVB0?=
 =?utf-8?B?ZWdGWkE1U2VwV1NtUU5jWjVHa28wY0dmMjBSQWdrRVNDWEZiSCtEd2F2SWRL?=
 =?utf-8?B?a3M2SUlRMmFpanY2a0NhUkxBN043Q2U1eEYybXlXRnhNcEozWk5OUGdTTDht?=
 =?utf-8?B?c2NwK1ZnTWs5RDBsMi8yU0dJZWZEZDhDcUJpUWF0Vk5kbE9YOXd6QloyUTRx?=
 =?utf-8?B?eDhwV0RkMzlySTFoSW9sVGhYTXlieER1c3pheU1RTy80aXZWa2Vjc25Tb0hp?=
 =?utf-8?B?cm5ySUFvZUdXUzVHay9Zb0Y3N2xrYlBveGxjcVNQT1pDK290UU9ld0crejJH?=
 =?utf-8?B?Q0kyTXpHeDRzZ1crN3Rpano4Y3g4ZEMyMTJVL3RKQkdldmpTdEVrU3MwTnpB?=
 =?utf-8?B?UWg1V2pLaVlkZ0FKYnV2VU5XcVlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A8431F79E0BBF4F87B324332AE14A55@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5552b463-9355-4ca0-8575-08de118e8772
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 17:14:58.8095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFRqRgvNVO9ofAXb9s1pLlj25wy4njtfh0dMoF4Sbha0+m5EViK2ZIqyJW5bYrsl9Im4Gq4yLWG/g7fKKJOZP7zp63k7q9w6p+SpHeYUbPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9923
X-Authority-Analysis: v=2.4 cv=BNi+bVQG c=1 sm=1 tr=0 ts=68f91118 cx=c_pps
 a=9VIIl2UxNuoJMDRiX/J/iA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=AaBQA9ZgmpVIyKA3SH8A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE0MCBTYWx0ZWRfX19mCSUF3rz2V
 r1dgdIYjYUs9H417U0HwnDyNnMRe930SvVvtdJK3Jbb044SpjI4Ozt1FWImZarODtepA/3a03Ol
 fPa/bQytWYjAJnmDo/MJsQsg0N30Fc1y0lGsNaxjTpDkj1BcUy3r1RtidFwsj4t4xtBsvNlbAUz
 2w0/SzLNGCSba9B5L2MgSFbweygyqhi0Y/TvyzGBAlFTb0i30fnMg7V1i9XfwWsqXqWBDlUgxs2
 p5YKV9twb1rBx6liqAuarVVXUoILQ8CUVGTXXJjoBxqQRZI7ps9sZoYXayvtErnya6yntPpUYWM
 F/aKy8BbslebWW9PLJrFeRXytZwJ4M5cMB3QQEXFac6jF+N03lwqGCFCLV+Y56tnjNR7ty/UQTR
 V4bISsi4vV2afrjm4n5e/mthoRfjtA==
X-Proofpoint-ORIG-GUID: W9WHdatY643UO3v9zyYKx5IgCvruDuZg
X-Proofpoint-GUID: W9WHdatY643UO3v9zyYKx5IgCvruDuZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQo+IE9uIEF1ZyAxOCwgMjAyNSwgYXQgMzowMeKAr1BNLCBTb2hpbCBNZWh0YSA8c29oaWwubWVo
dGFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IFVwZGF0ZSB0aGUgbWluaW11bSBleHBlY3RlZCBy
ZXZpc2lvbnMgb2YgSW50ZWwgbWljcm9jb2RlIGJhc2VkIG9uIHRoZQ0KPiBtaWNyb2NvZGUtMjAy
NTA1MTIgKE1heSAyMDI1KSByZWxlYXNlLg0KPiANCj4gQ2M6IDxzdGFibGVAa2VybmVsLm9yZz4g
IyB2Ni4xNSsNCj4gU2lnbmVkLW9mZi1ieTogU29oaWwgTWVodGEgPHNvaGlsLm1laHRhQGludGVs
LmNvbT4NCj4gLS0tDQo+IC4uLi9rZXJuZWwvY3B1L21pY3JvY29kZS9pbnRlbC11Y29kZS1kZWZz
LmggICB8IDg2ICsrKysrKysrKysrLS0tLS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQ4IGluc2Vy
dGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWljcm9jb2RlL2ludGVsLXVjb2RlLWRlZnMuaCBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvbWljcm9jb2RlL2ludGVsLXVjb2RlLWRlZnMuaA0KPiBpbmRleCBjYjZlNjAxNzAxYWIuLjJk
NDhlNjU5MzU0MCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9taWNyb2NvZGUv
aW50ZWwtdWNvZGUtZGVmcy5oDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWljcm9jb2Rl
L2ludGVsLXVjb2RlLWRlZnMuaA0KPiBAQCAtNjcsOSArNjcsOCBAQA0KPiAg4oCmIHNuaXAg4oCm
IA0KPiAteyAuZmxhZ3MgPSBYODZfQ1BVX0lEX0ZMQUdfRU5UUllfVkFMSUQsIC52ZW5kb3IgPSBY
ODZfVkVORE9SX0lOVEVMLCAuZmFtaWx5ID0gMHg2LCAgLm1vZGVsID0gMHg4ZiwgLnN0ZXBwaW5n
cyA9IDB4MDEwMCwgLmRyaXZlcl9kYXRhID0gMHgyYzAwMDM5MCB9LA0KPiAteyAuZmxhZ3MgPSBY
ODZfQ1BVX0lEX0ZMQUdfRU5UUllfVkFMSUQsIC52ZW5kb3IgPSBYODZfVkVORE9SX0lOVEVMLCAu
ZmFtaWx5ID0gMHg2LCAgLm1vZGVsID0gMHg4ZiwgLnN0ZXBwaW5ncyA9IDB4MDA4MCwgLmRyaXZl
cl9kYXRhID0gMHgyYjAwMDYwMyB9LA0KPiAteyAuZmxhZ3MgPSBYODZfQ1BVX0lEX0ZMQUdfRU5U
UllfVkFMSUQsIC52ZW5kb3IgPSBYODZfVkVORE9SX0lOVEVMLCAuZmFtaWx5ID0gMHg2LCAgLm1v
ZGVsID0gMHg4ZiwgLnN0ZXBwaW5ncyA9IDB4MDA0MCwgLmRyaXZlcl9kYXRhID0gMHgyYzAwMDM5
MCB9LA0KPiAteyAuZmxhZ3MgPSBYODZfQ1BVX0lEX0ZMQUdfRU5UUllfVkFMSUQsIC52ZW5kb3Ig
PSBYODZfVkVORE9SX0lOVEVMLCAuZmFtaWx5ID0gMHg2LCAgLm1vZGVsID0gMHg4ZiwgLnN0ZXBw
aW5ncyA9IDB4MDAyMCwgLmRyaXZlcl9kYXRhID0gMHgyYzAwMDM5MCB9LA0KPiAteyAuZmxhZ3Mg
PSBYODZfQ1BVX0lEX0ZMQUdfRU5UUllfVkFMSUQsIC52ZW5kb3IgPSBYODZfVkVORE9SX0lOVEVM
LCAuZmFtaWx5ID0gMHg2LCAgLm1vZGVsID0gMHg4ZiwgLnN0ZXBwaW5ncyA9IDB4MDAxMCwgLmRy
aXZlcl9kYXRhID0gMHgyYzAwMDM5MCB9LA0KPiAreyAuZmxhZ3MgPSBYODZfQ1BVX0lEX0ZMQUdf
RU5UUllfVkFMSUQsIC52ZW5kb3IgPSBYODZfVkVORE9SX0lOVEVMLCAuZmFtaWx5ID0gMHg2LCAg
Lm1vZGVsID0gMHg4ZSwgLnN0ZXBwaW5ncyA9IDB4MTAwMCwgLmRyaXZlcl9kYXRhID0gMHgxMDAg
fSwNCj4gK3sgLmZsYWdzID0gWDg2X0NQVV9JRF9GTEFHX0VOVFJZX1ZBTElELCAudmVuZG9yID0g
WDg2X1ZFTkRPUl9JTlRFTCwgLmZhbWlseSA9IDB4NiwgIC5tb2RlbCA9IDB4OGYsIC5zdGVwcGlu
Z3MgPSAweDAwMTAsIC5kcml2ZXJfZGF0YSA9IDB4MmMwMDAzZjcgfSwNCj4gK3sgLmZsYWdzID0g
WDg2X0NQVV9JRF9GTEFHX0VOVFJZX1ZBTElELCAudmVuZG9yID0gWDg2X1ZFTkRPUl9JTlRFTCwg
LmZhbWlseSA9IDB4NiwgIC5tb2RlbCA9IDB4OGYsIC5zdGVwcGluZ3MgPSAweDAwMjAsIC5kcml2
ZXJfZGF0YSA9IDB4MmMwMDAzZjcgfSwNCj4gK3sgLmZsYWdzID0gWDg2X0NQVV9JRF9GTEFHX0VO
VFJZX1ZBTElELCAudmVuZG9yID0gWDg2X1ZFTkRPUl9JTlRFTCwgLmZhbWlseSA9IDB4NiwgIC5t
b2RlbCA9IDB4OGYsIC5zdGVwcGluZ3MgPSAweDAwNDAsIC5kcml2ZXJfZGF0YSA9IDB4MmMwMDAz
ZjcgfSwNCj4gK3sgLmZsYWdzID0gWDg2X0NQVV9JRF9GTEFHX0VOVFJZX1ZBTElELCAudmVuZG9y
ID0gWDg2X1ZFTkRPUl9JTlRFTCwgLmZhbWlseSA9IDB4NiwgIC5tb2RlbCA9IDB4OGYsIC5zdGVw
cGluZ3MgPSAweDAwODAsIC5kcml2ZXJfZGF0YSA9IDB4MmIwMDA2MzkgfSwNCj4gK3sgLmZsYWdz
ID0gWDg2X0NQVV9JRF9GTEFHX0VOVFJZX1ZBTElELCAudmVuZG9yID0gWDg2X1ZFTkRPUl9JTlRF
TCwgLmZhbWlseSA9IDB4NiwgIC5tb2RlbCA9IDB4OGYsIC5zdGVwcGluZ3MgPSAweDAxMDAsIC5k
cml2ZXJfZGF0YSA9IDB4MmMwMDAzZjcgfSwNCj4g4oCmIHNuaXAg4oCmIA0KDQpIaSBMS01MLCBE
YXZlLCBTb2hpbCwNCldhbnRlZCB0byByZXBvcnQgYSBDUFUgbWF0Y2hpbmcgaXNzdWUgSSdtIHNl
ZWluZyBvbiBvbmUgb2Ygb3VyIFNQUg0KaG9zdHMsIHdoaWNoIHJlc3VsdHMgaW4gaXQgYmVpbmcg
ZmxhZ2dlZCBmb3Igb2xkIG1pY3JvY29kZSwgZGVzcGl0ZQ0KaGF2aW5nIHRoZSBsYXRlc3QgbWlj
cm9jb2RlIGVhcmx5IGxvYWRlZC4NCg0KVXNpbmcgNi4xOCByYzIgcGx1cyB0aGUgbGF0ZXN0IG5l
d2VyIG1pY3JvY29kZSBsb2FkZWQgZnJvbSB0aGUgSW50ZWwNCjIwMjUwODEyIHJlbGVhc2UsIGl0
IHNlZW1zIGxpa2UgdGhpcyBpcyBtYXRjaGluZyBhIGRpZmZlcmVudCBzdGVwcGluZw0Kc28gdGhl
IENQVSBpcyBnZXR0aW5nIGZsYWdnZWQgYXMgb2xkLiANCg0KQWRkZWQgYSBiaXQgb2YgbG9nZ2lu
ZyBwcmVmaXhlZCB3aXRoIEpLREJHOg0KDQpbIDAuMDAwMDAwXSBtaWNyb2NvZGU6IEpLREJHOiBh
Ym91dCB0byBsb2FkIG1pY3JvY29kZSAoQlNQKQ0KWyAwLjAwMDAwMF0gbWljcm9jb2RlOiBKS0RC
RzogbWljcm9jb2RlIGxvYWRlZCAoQlNQKTogMHgyYjAwMDY0Mw0KWyAwLjAwMDAwMF0geDg2L0NQ
VTogSktEQkc6IE1BVENIIG1pY3JvY29kZSBsaXN0IGVudHJ5OiBmYW1pbHkgMHg2LCBtb2RlbCAw
eDhmLCBzdGVwcGluZ3MgMHgxMDANClsgMC4wMDAwMDBdIHg4Ni9DUFU6IEpLREJHOiBCT09UX0NQ
VV9EQVRBIGZhbWlseSAweDYsIG1vZGVsIDB4OGYsIHN0ZXBwaW5nIDB4OA0KWyAwLjAwMDAwMF0g
eDg2L0NQVTogSktEQkc6IG1pY3JvY29kZSBpcyBvbGRlciB0aGFuIGxhdGVzdCBhdmFpbGFibGU6
IGN1cnJlbnQgMHgyYjAwMDY0MywgbGF0ZXN0IDB4MmMwMDAzZjcNClsgMC4wMDAwMDBdIHg4Ni9D
UFU6IFJ1bm5pbmcgb2xkIG1pY3JvY29kZQ0KLi4uDQpbIDIuNTIxMzM4XSBzbXBib290OiBDUFUw
OiBJbnRlbChSKSBYZW9uKFIpIEdvbGQgNTQxNlMgKGZhbWlseTogMHg2LCBtb2RlbDogMHg4Ziwg
c3RlcHBpbmc6IDB4OCkNCi4uLg0KWyAzLjU5MzA2M10gbWljcm9jb2RlOiBDdXJyZW50IHJldmlz
aW9uOiAweDJiMDAwNjQzDQpbIDMuNTkzMDY1XSBtaWNyb2NvZGU6IFVwZGF0ZWQgZWFybHkgZnJv
bTogMHgyYjAwMDRiMQ0KDQpJIHJldmVydGVkIHRoaXMgcGF0Y2gsIGFuZCBhbHNvIGdvdCB0aGUg
c2FtZSBtYXRjaGluZywgc28gaXQgaXNuJ3QNCnJlZ3Jlc3NlZCBpbiA2LjE4LCBpdCBqdXN0IGRv
ZXNuJ3QgbWF0Y2ggbGlrZSBJJ2QgZXhwZWN0LiBUaGUgbWljcm9jb2RlDQp1cGRhdGVyIGl0c2Vs
ZiBzZWVtcyB0byB3b3JrIGEtb2sgdGhvdWdoLg0KDQpXaXRoIHJldmVydDoNClsgMC4wMDAwMDBd
IG1pY3JvY29kZTogSktEQkc6IGFib3V0IHRvIGxvYWQgbWljcm9jb2RlIChCU1ApDQpbIDAuMDAw
MDAwXSBtaWNyb2NvZGU6IEpLREJHOiBtaWNyb2NvZGUgbG9hZGVkIChCU1ApOiAweDJiMDAwNjQz
DQpbIDAuMDAwMDAwXSB4ODYvQ1BVOiBKS0RCRzogTUFUQ0ggbWljcm9jb2RlIGxpc3QgZW50cnk6
IGZhbWlseSAweDYsIG1vZGVsIDB4OGYsIHN0ZXBwaW5ncyAweDEwMA0KWyAwLjAwMDAwMF0geDg2
L0NQVTogSktEQkc6IEJPT1RfQ1BVX0RBVEEgZmFtaWx5IDB4NiwgbW9kZWwgMHg4Ziwgc3RlcHBp
bmcgMHg4DQpbIDAuMDAwMDAwXSB4ODYvQ1BVOiBKS0RCRzogbWljcm9jb2RlIGlzIG9sZGVyIHRo
YW4gbGF0ZXN0IGF2YWlsYWJsZTogY3VycmVudCAweDJiMDAwNjQzLCBsYXRlc3QgMHgyYzAwMDM5
MA0KWyAwLjAwMDAwMF0geDg2L0NQVTogUnVubmluZyBvbGQgbWljcm9jb2RlDQouLi4NClsgNC40
NDg3NzBdIG1pY3JvY29kZTogQ3VycmVudCByZXZpc2lvbjogMHgyYjAwMDY0Mw0KWyA0LjQ0ODc3
Ml0gbWljcm9jb2RlOiBVcGRhdGVkIGVhcmx5IGZyb206IDB4MmIwMDA0YjENCg0KTG9va2luZyBh
dCB0aGUgbWljcm9jb2RlIHJlbGVhc2Ugbm90ZXMsIEkgYmVsaWV2ZSBJ4oCZbSBzdXBwb3NlZCB0
byBiZQ0KaGl0dGluZyBTUFItU1AgMDYtOGYtMDgvODc6DQpodHRwczovL2dpdGh1Yi5jb20vaW50
ZWwvSW50ZWwtTGludXgtUHJvY2Vzc29yLU1pY3JvY29kZS1EYXRhLUZpbGVzL3JlbGVhc2VzL3Rh
Zy9taWNyb2NvZGUtMjAyNTA4MTINCg0KV2hhdCB0aGUgbWF0Y2hpbmcgY29kZSBpcyBjb21pbmcg
dXAgd2l0aCB0aG91Z2ggaXMgWGVvbiBNYXgsDQp3aGljaCBJIGRlZmluaXRlbHkgYW0gbm90IHJ1
bm5pbmcgaW4gbXkgbGFiIGhvc3QuDQoNCkhhcHB5IHRvIGNvbGxhYm9yYXRlIG9uIGRlYnVnZ2lu
ZyBpZiB5b3XigJlkIGxpa2UgYW55IG1vcmUNCmRhdGEgcG9pbnRzLg0KDQotIEpvbg==

