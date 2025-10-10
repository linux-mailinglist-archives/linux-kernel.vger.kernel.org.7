Return-Path: <linux-kernel+bounces-848446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BCBCDC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6E4E2646
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625422F83DB;
	Fri, 10 Oct 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Na7JH//7"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038F26F28B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109930; cv=fail; b=MRHS+hUC2PEuDhWxD+iVJzHUN3NblwM3Fy22M9lmwXGmW1NcpqazTQoM2mWmO5OW0xzkybfLyr0ERV4VHWSuZnjU16LIdAJsyTXW2AMEWHwN2iUrJSuvHChW83O3DDlNl8FAEpq0i61m+T6+0YxIkswQwIe4TeXW/8SRJhybafg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109930; c=relaxed/simple;
	bh=XIhcIH3Nm6iFwPnyDXSnEahprlfRJC4n4uSqU6YR0MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g96JAiCpJh7/XXSowAZnwIihyqi0dYBnV9QjH64oA93PWvwAhkC0wUFp04ZjFKrwc0Ih6LCytU+VRDlISFUpurK4Xg/sPpjN3gCA7QDiPCTIW2N32AZHIi4CkXuJW6ERnIrixWApMAwCEoOz84qVKFOzWej+vNRSF2nojOkUSKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Na7JH//7; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSc4XKT1pZN5OUMD2UCH3hSBx90R1w2KzNZot5f+Q9c8+14h9RCos+k7nntHNOTsCuXb1NHosy5D3nzdk7PRfD8HsjJz1CfoKVzPXBRbJw22RYOJM2aZ8GMt14acgGpZYEB6j05VXByNQyd2AZndsfZnuJ67e80rXdM5Xd4tjqA+uw9XQiyxxqdpm3KRA4Y7qjsoLeVC4W/lki0hEhLp6eIHItndM9JFxvsR+SLgCjClIxRHeIN2Jk1hMZZ6oWDLKTUjUgKNmwFJS43s9q9tdf31HUAAMHEB0uSLTBLHKNPNSjEv5Bi4PF3UZUJT2s9nH9tK/BT8h2dprnCzm2Lxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIhcIH3Nm6iFwPnyDXSnEahprlfRJC4n4uSqU6YR0MA=;
 b=KsdWPY7ldxKu4+rkFKtrXk3A+WzrU7azV/0JQLviKXuzi355NoKA5HzE+ubjo4QvB3+cg1kw3aYCVtgfVzFm8fJwGtG5Q0DEbG3QC9qPOL88S0fIdV8gCbbvHC3X7dXpksiAB3dHW5sFrHV6PrsbRLEDJnHCj2Krz4aYvOvWh3/aWESDCVPyTLu+8cthNxH01jnx25A7zz6QFMA/ozIGqYRGY54N6+xZtdaJZrg/2eSHHq9zX/TWJkLSpNO+Q/RU3HFAI1oDig3qKhPrtG9jIlSzbBmksy2JFurFSwmWkOnKCP6w5CUZTae5NvQQOEA/7tsbFYx+h/Lz4Q/32jiK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIhcIH3Nm6iFwPnyDXSnEahprlfRJC4n4uSqU6YR0MA=;
 b=Na7JH//7Hylk4BW6eVL+CisP/vEwJhOLK4WNBoyw/Biht8Rvv/E1ukAA062/ISHMRQv/i2X8szas+Od2NdM6+2gGZddwVLHSFgG6TeBo5WO9HWqLMzCSOliG11lqutK+3zeEo9ZWhAUMjRePOGZVHL8deczTpcUWw+6NNqzPWR7kn/Z87VtG7nx4jLwoRX43FVMTc1AhRpBQBlHM1MwLTpnVvpQY9ROKfVCYmkyKECg+dux+7HY0BOlgUMW8XdWR9fjr2VK6WtXk/iymNtMQdS4gcwnfZxuhM3dHcI4WZBK9anDkbxrb+u//1zxtHcOUyp+lTfEWa5xM0Su4TR9oTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 15:25:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 15:25:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: jane.chu@oracle.com,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, david@redhat.com,
 kernel@pankajraghav.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Fri, 10 Oct 2025 11:25:19 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <97A3301C-8C35-419F-9BEC-B2E6FA30321D@nvidia.com>
In-Reply-To: <f5870e90-2c3d-7d65-fcc3-92ec5a1fe177@huawei.com>
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
 <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
 <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
 <57d9aa32-2fc8-48d2-b68b-3308c7d58125@oracle.com>
 <CD6D8EBD-F139-41BC-9A59-5033EF5A09BC@nvidia.com>
 <ae74c0b4-7115-4856-a3f0-c61945f64c7d@oracle.com>
 <f5870e90-2c3d-7d65-fcc3-92ec5a1fe177@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0041.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: a14b69b9-b6f2-4271-7103-08de08113a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkdiRDVNWlZrNjEyNHo1dVo1c1c4aTN5S00yT0JTdWF4STdaZnAwWHdjZHVu?=
 =?utf-8?B?Zm9mZkllemZsZUl6b3NqeFlMVXAzaUpLN2pXRjVITUxwN0p4TzR2UzVmTEY3?=
 =?utf-8?B?SEdPbzRSdTY0S3lJV3I0MFRkR3UvQUswSjM4ODNDZGovVVJMQ1NhYTlMUWM0?=
 =?utf-8?B?R1oxTm5pZzQ4VXFzTjdtcEVrcVJJcGtHOFZxQ25BbGhhVE54T3ZJN2pNWWVn?=
 =?utf-8?B?cUlIalo0ejdOcmxiUzkrQnkzNUlmZVFWS2szVXVNNTZ3cVNSMTJWZWVOdnJu?=
 =?utf-8?B?eDlxanVFVWFwcEhRcjhiRHJ1cHFvSUZmNER2dXAzMGtMRXJVc01ublZndGto?=
 =?utf-8?B?Uk9wZ1hMdEQ3a1kzVmplbG9TbzN2Nnd5cnVaU2htZytETVhpQkM2R0l3djdp?=
 =?utf-8?B?c3YwT21xdDFlSXQ4elpQUk9tWkM4bGtydUM5RkdKckI2Tk1DSHE2M3ZKM1B6?=
 =?utf-8?B?alBWemovUlZzaUhUaEtLdHNyblJzU2psRUIyVldGSWRRVGVhWGtmbXRoN1dF?=
 =?utf-8?B?ZkM1OXptNWdCUTdqekQzRGN2Yi9PeW8zNHcyS2lPbE4ydVFCbVc2VkR4YU5q?=
 =?utf-8?B?OEszM1BSeTRFSFdqSTgyY1l1ZkdlY0Nnc0l2MXYvY040OExsVTBGeVFqNUVZ?=
 =?utf-8?B?RG1OaTNwNTBSZkVFYmJEK0lPZHpmR2RTd2dQdWQrdERldHpUM1VaOWY3WFRK?=
 =?utf-8?B?UkpqU3RpdUJBTmlLSUZ4a2w3K1dyRU01YlViUGsvdnBFSjk3MVhwSkF0NzBy?=
 =?utf-8?B?RnNhTnFKcWM2eS9rUmVrRE5JYkNqM1ZhUmVTdW84OEdCK1VsRjlSQ0FTUUZ5?=
 =?utf-8?B?UjdacjE5NlZXRDFyS2oyUVU2RDZ1MnU5U0VUU3NUekZFQTQyMTNqaGU5cno2?=
 =?utf-8?B?MEZFNVl3aW9KZGFsRUNxZzU0ZXJUcjdGSHgvODE5OTlIMlNSMGtzNEZwSXVr?=
 =?utf-8?B?WnVISWFnNkNyVW84aEd1OUxaSjh2VUptczN6d0I2TklBUG1VSEdYbWg4clo5?=
 =?utf-8?B?N3JjODZLUmVSdXZ6L3N3ZmNjZ1NsSEwwVUgvTWNXRUhUMEV4WFRLZWRwNXg2?=
 =?utf-8?B?dm44dUI4TGtxRm5tcE9hZlVmM290b2hobVZ2YVZ3UWpMSnpMMTFCaC9vWkU5?=
 =?utf-8?B?ZFZTQW5RUG5sNFNlSk1lV0p0NzZwZWVKa21NZHRlaGRqSSszbTRXSzRsaE1D?=
 =?utf-8?B?cjhDTzA2VzJYWStrc2NRN3hmVjdGZm4rUmJFdUdoMlllVFlMWWhuQ0xCdEM4?=
 =?utf-8?B?Y0VBVjYrcWMvaW1SUldTcnpFT1FDZ1ZVdVU4elFRWGhhUHo5akVMaS9FbExR?=
 =?utf-8?B?QkhOSVRwSDA4amp5WVdIK1p5WllMN0lxL2pDNmt3N2ZQN0N2Z0Nhckh1cWtF?=
 =?utf-8?B?L1ZwT3RiU211dlpRVnN5bEI0ME1jRnM1OUpqOUFLN3QyL1lTbGY2R0N4em52?=
 =?utf-8?B?WlZiOXhFK1N1eWVVTEdxd1ZNVndlejV3RytiM05vd0hqblJxbXh5eHZIMzc5?=
 =?utf-8?B?ZUJyZ1AxdnIvTnphcm4rSG9odDAxUWpON0tLUUFhRERGYjl3TW84TUNaZVJr?=
 =?utf-8?B?NGtmMCtZTVE1TWcrcnJTbDFmNWpKaDFlTGsxeXZWTk1GSDUxYVoyNjhFRDBo?=
 =?utf-8?B?Y1pqTHMwZHpXSHJ6Y2F3cFVYNERvZC8wV1pjVTI3cEFzMTZSQXF6WjBzZjE0?=
 =?utf-8?B?anArRFgvcXhJaFcxZkJsV3N4dDJ5cDI0Q09jYlRFR2ttQlAyeDV1d3lsTTJY?=
 =?utf-8?B?dzlMVzJPT1JvNCtCRUZqYUR3Z3drUHZSaGo3VWw1dHEyY1AzS0JlNjIreDd2?=
 =?utf-8?B?UTRWTFc4OHZ2bHdyUTFKN2l4Uys5bmRZN0xRWjdFV1AvQ1VuaVY3aDduT2hj?=
 =?utf-8?B?RHlUbVkvb3NMc2VGMnpnZTEyWldmZnYvT2pMQ0Q2S2wxUjY4QUxONjFkZzU3?=
 =?utf-8?Q?ZKdWSUOHmK42VLP0BtlanMeyBZnmq1Gg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEZhUVRVb2lsZVI2WVBwb0crSFNmZXM4UkJjbDIwck9SMFhiWEQ0aFNJS1Np?=
 =?utf-8?B?SzBnUU9Wc3paOHhXOWxmU1h1MXJOaDRqMWJ2dms4WUxFSzJIcnU1U0Q1OUhr?=
 =?utf-8?B?bUhDNFkzbnlocmxWeVJxcEFkdUtodE50SmN5ZkV0eXZLY3NlSTFTR29mNzlG?=
 =?utf-8?B?Z0EzaUpsbzVhWnlYK1dyQ0g3SWFqdkx6ZHpXWDhmcDFRd1gxZytoUUJuMmw1?=
 =?utf-8?B?NkFsaENUTUVtMHU3dzlTQVVTRHFaa2dKWXBzN2tKdlIyNkYyR0VjYzZjL05N?=
 =?utf-8?B?Z3NuL0M5MzVwVU5VaXNtcmFKTFc0TVpHeklsWEk2RHhscDc5NlNhUy9iaGZN?=
 =?utf-8?B?SU1IelVLYUNJWjN4QTlPeFA4clEvUUhQek0wczB5RnFweWhrS0t1dG5uSy9l?=
 =?utf-8?B?eVl3Y1ZKQTNpbnp6Qk5ueUlqQVZOT3hTTU0xMmcxb20xZ09PR0xWcm0vUUxa?=
 =?utf-8?B?OGJ4Ym9HVHc3SVVzUTR5dExEYW01OU15dTNDNGZtMkZUY2ZIeEpDUEZYSlFB?=
 =?utf-8?B?Wi9BdktVVkVJaC96MVNHR3VZMVNIZEI0dWM5a2hoOEJsOXJHbkdMNGxLbnpZ?=
 =?utf-8?B?Mk1yMzFIeVk3bVprSm5lVzRoQlV4K1hFT2p6UDJhUExUbXhrdDRrTXQ2ZUxl?=
 =?utf-8?B?U3pRNTViNUU5VlRCWGZsM0JNeit3YzN2TnNPRWJHZHEwMDNnN0NqRTF3VTdY?=
 =?utf-8?B?TWJqWkxVVlNQeFdNZjc5b0dxSk5mRE9tM0lTazVXU1lSOHJnQngzdUF2UVdK?=
 =?utf-8?B?QXg5VXQrdEU2OUV4eXZXVFpMMTI5QmFUL3VMR1VvSXQ1VzRZdFk4eGJrWVNs?=
 =?utf-8?B?ZDAzMVVUWmVzV3NTNCtSTjZJK3JVRWpFYnJpeW9YM1RVOHk5QmVNL2lZUmNk?=
 =?utf-8?B?NzhEbXJaYmFPV2VqZG4wb3gzV0JjL3FvRWFMSW9FTnd2MEhLalg5b1dYeWxk?=
 =?utf-8?B?OXpiQzI1NU5sc2xHT2hJeGMrWXhVUU4rUEY5d0w3S1RlSEQyN3ZiakFTdzdu?=
 =?utf-8?B?VEVTRHRKU292ajVTb3JlOUlzSUNENHdoOXp1bzJDeVAvdW9FL1NGSVdQMjFJ?=
 =?utf-8?B?QU1HaGlWNjlDZUNmVlZtTW91VG9HSkE5aTFvTmFpUVNDS2laYURXclpvS0sr?=
 =?utf-8?B?Z3doVFpYUmpWeVF5bFN2clVlU081QmJGcmdmc3QvOFpTT2RnTVJlTUJhdm00?=
 =?utf-8?B?dnBOSGgyU1RoaWdEVmloU3hIZDlOdjA3ZWVXRE5Jd2VrUlJQeHVQRjBGUXBE?=
 =?utf-8?B?ZVZCUmlNdHdQYm5neXl5T3lST1JIWFlJQk53VEpMUVN0eG9SaVB2aUtGdmUr?=
 =?utf-8?B?RXRlUDBlNDkxd2lEaE8wSnlJc3FwckVGWGFEdTljQWdJMEZwdDlYOEJuT3Yy?=
 =?utf-8?B?TlBJT3h0a1dKRnMxREFYK0RscnExR0FlU3djdXc1aXI2MWZuaFFzVEVLY0w4?=
 =?utf-8?B?MWRCVkNYTnROUkNKQjZPWjJrN2psUzJETTBTUlFFc29kU3c5ZXNYWkVSOEVw?=
 =?utf-8?B?YXVndGRSUDRoL3NHcXdsNnZtYi9EVnA0bGxiRW8vYy9WNWdwVzUrUkQvb0w2?=
 =?utf-8?B?UXdRRXhwTUwwV0d6VXpOTjg1YXQ0bjZPTElBOGZtbGtua284Rm9pRExNRExM?=
 =?utf-8?B?L0JUclVRMU1LQ01IU1VKMUJTYjRUbEVudWp5NVhEdWc0SkJJRElyaVJ2SGIw?=
 =?utf-8?B?K2VNZWVEazhMUWtOSHZxSlBsRGxZd3FrYWVieS8vVW1lb3kyS3lCWEo3OHNv?=
 =?utf-8?B?WFFlR1hQZ2FEUmpiajVraDArVEdRME5PUjVqYm1hVG5TSVJTelJHaDUrb1ZE?=
 =?utf-8?B?MWFNd1JEOE4vbmwrM09ZRmNSS3k5Q2N4UCtVSlRnc0hmVlQwTGJtRSt1cm5F?=
 =?utf-8?B?T0JMUEJ5TzdTZmt0SitOOGpvYU9qWXExeW4zU2kyT3kvcitoOG1vdGVDRndk?=
 =?utf-8?B?alBFN0FlQW82SWNzWjc2b0JqODFRTXZHTmdoaWF2dkE1cHcrak1NTkJka3E3?=
 =?utf-8?B?VnNSdlVaODRsN0czV2tOT05CVE5HSmI5L0xDSVQrRnJIU3VIOVNwbGpyYlQ0?=
 =?utf-8?B?T2VQcCtsaXRTTWtIbzVLWFNVSXlUM0czOGNic0NZaTRYd1prbFlkcGRWNlZt?=
 =?utf-8?Q?WueqO0dRVy2fXCpssbO/lReRT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14b69b9-b6f2-4271-7103-08de08113a00
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:25:21.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAEyzDxnxGDSKpOiLAMUPcVqEA0D64QcjFoqXzl7lTt8+YyRLfxdF2+h8ht04NKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490

On 9 Oct 2025, at 3:39, Miaohe Lin wrote:

> On 2025/10/3 1:47, jane.chu@oracle.com wrote:
>>
>>
>> On 10/2/2025 6:54 AM, Zi Yan wrote:
>>> On 2 Oct 2025, at 1:23, jane.chu@oracle.com wrote:
>>>
>>>> On 10/1/2025 7:04 PM, Zi Yan wrote:
>>>>> On 1 Oct 2025, at 20:38, Zi Yan wrote:
>>>>>
>>>>>> On 1 Oct 2025, at 19:58, jane.chu@oracle.com wrote:
>>>>>>
>>>>>>> Hi, Zi Yan,
>>>>>>>
>>>>>>> On 9/30/2025 9:51 PM, syzbot wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> syzbot has tested the proposed patch but the reproducer is still t=
riggering an issue:
>>>>>>>> lost connection to test machine
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Tested on:
>>>>>>>>
>>>>>>>> commit:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d8795075 m=
m/huge_memory: do not change split_huge_page..
>>>>>>>> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://github.com/x=
-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17ce96=
e2580000
>>>>>>>> kernel config:=C2=A0 https://syzkaller.appspot.com/x/.config?x=3D7=
14d45b6135c308e
>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3De6367ea2=
fdab6ed46056
>>>>>>>> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version=
 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian L=
LD 20.1.8
>>>>>>>> userspace arch: arm64
>>>>>>>>
>>>>>>>> Note: no patches were applied.
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Thank you for looking into this.
>>>>>>
>>>>>>> My hunch is that
>>>>>>> https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for=
-kernelci
>>>>>>> alone is not enough.=C2=A0 Perhaps on ARM64, the page cache pages o=
f /dev/nullb0 in
>>>>>> Yes, it only has the first patch, which fails a split if it cannot b=
e
>>>>>> split to the intended order (order-0 in this case).
>>>>>>
>>>>>>
>>>>>>> the test case are probably with min_order > 0, therefore THP split =
fails, as the console message show:
>>>>>>> [=C2=A0 200.378989][T18221] Memory failure: 0x124d30: recovery acti=
on for unsplit thp: Failed
>>>>>>>
>>>>>>> With lots of poisoned THP pages stuck in the page cache, OOM could =
trigger too soon.
>>>>>>
>>>>>> That is my understanding too. Thanks for the confirmation.
>>>>>>
>>>>>>>
>>>>>>> I think it's worth to try add the additional changes I suggested ea=
rlier -
>>>>>>> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@o=
racle.com/
>>>>>>>
>>>>>>> So that in the madvise HWPOISON cases, large huge pages are splitte=
d to smaller huge pages, and most of them remain usable in the page cache.
>>>>>>
>>>>>> Yep, I am going to incorporate your suggestion as the second patch a=
nd make
>>>>>> syzbot check it again.
>>>>>
>>>>>
>>>>> #syz test: https://github.com/x-y-z/linux-dev.git fix_split_page_min_=
order_and_opt_memory_failure-for-kernelci
>>>>>
>>>>
>>>> There is a bug here,
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (try_to_split_thp_page(p=
, new_order, false) || new_order) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res=
 =3D -EHWPOISON;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kil=
l_procs_now(p, pfn, flags, folio);=C2=A0 <---
>>>>
>>>> If try_to_split_thp_page() succeeded on min_order, 'folio' should be r=
etaken:=C2=A0 folio =3D page_folio(page) before moving on to kill_procs_now=
().
>>>
>>> Thank you for pointing it out. Let me fix it and let syzbot test it aga=
in.
>>>
>
> Sorry for late. I just got back from my vacation. :)
>
>>> BTW, do you mind explaining why soft offline case does not want to spli=
t?
>>> Like memory failure case, splitting it would make other after-split fol=
ios
>>> available.
>>
>> That's exactly what I think.=C2=A0 Let's wait for Miaohe, not sure if he=
 has other concern.
>
> It might be because even if split is skipped, the folio is still accessib=
le (thus available)
> from user sapce and premature split might lead to potential performance l=
oss. But it's fine
> to me to split folio first in soft offline case. No strong opinion.

Thanks for the explanation. I will add a comment about this. We can always =
do the
split at soft offline when we find it useful. I will send the patches out.

--
Best Regards,
Yan, Zi

