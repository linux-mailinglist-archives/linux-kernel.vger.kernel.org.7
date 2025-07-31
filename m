Return-Path: <linux-kernel+bounces-752386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CF4B174EA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57064567E67
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5638823B61D;
	Thu, 31 Jul 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJhX1scN"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE41DD88F;
	Thu, 31 Jul 2025 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753979323; cv=fail; b=tWcgjw5/YftN+jmNnEbZaROXaJrINCjUU/nx94El80sDrbh5XCdYCQstsbG0mvQcAWNnVaxcEkeKtLtk2taAjU2XmHcssRlMF9uX2ZIm+jd+nBHID5vFOQ55GHzG46RmBRmk1u4dF08UYavP/+6M0AcDFFaLZgwq6u+/lOnOcMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753979323; c=relaxed/simple;
	bh=3YdyOSIX0Z1uob7MHKQd+qTAAA294GPlTUHDwknIHsU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHAtGIfOZwMazGKPu3ZrFba4rnUu5i10KrBbdGOPv2/ReutT0ruu91pipLNBy407Zw3YiqQ5BVXNFA/JRLT4+O5Gy1Ub75+LOalP9DJiqw55T3F9vt96FE6lCH3Dpc1FHPY8u0CpmZ7k6eBuki4MujDmTQm96tNxOu0Vxl8GUP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJhX1scN; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgwIPMgDil0LJR2x5zKLEiu1eMFzeYUpM1J6sMWEgTbUmwFaBeqRLfmzDqADOklzhh4dJuVHshpGU53ePiv3jAoUzVMWtnhjiZ57BFCEpV0ybLYKh8Nq+wm12KibmJpwHO559FOv9KCAZYyVSUks7YdTpnNrf61qgU4zwLiwdCQkeGPG/a//TQQo3JSqI96fHxL270apkZAqq3TTOvfomrbHRwB+ap/n2IJ0TPzCyCPFR2pilvb4xx6WDkDlMiACJPMO+uJHep5ij3znChVlFSrbOPZUSc5OGTTPvT9JOCpzUEpQWPZ2FK5rj50sf+swDH5OhKqfOedmrlchQbkf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLXxuyPHQSaAQO1/HSEKu0VXd4srJPmBeLFZmgEdIA4=;
 b=lrx3CIKqyGQu2Z6wSE7hcL1ADJDyN8pAKP0IpUGzXUgiYw0aNUFTNmDOF30U5bAaAaZChMoZRwojKLB7D7uBKTmCF0gpf3AWA9O8ZI9r+SsjaJJDIIg7ljrmiEGH8XYRdekIEy+CHct4XD/POl6KFo5fc01V7kRUFKTJSv5e1yomlmu00TP37YDLFrzWpZwQeL2AkPLL/hMIq9W4YnxDRh3l8gG6fzR/1UoBxwmtu95NbOhgJcW/So3QacHoOR3amZkU3DJ909HT/GVBc4A14x+UaKPj+zi4ZwvIDSHpbWQLCtqtUrpQXyH9xUF8C7aeMPhy0Pedcp1IDTQWR5LdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLXxuyPHQSaAQO1/HSEKu0VXd4srJPmBeLFZmgEdIA4=;
 b=vJhX1scNNuwsPUzUXpRIMSOMf5cqNvvl7/uDIUqdlFp+DtYz0cyEcGhB4h94+hCzFyGHpBknikFz/OaVNBhJg4VT/RWe904BoD6huVbF+iu1ZTUpsSuP/1eoJZ/UqjmJ36nP90ipJTfemmqh2pGXfKPd9DsAet6gRvLdJWUF7kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DS0PR12MB9324.namprd12.prod.outlook.com
 (2603:10b6:8:1b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 16:28:35 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 16:28:35 +0000
Message-ID: <c4bfc16e-1afe-4547-a234-3d7e7487cf67@amd.com>
Date: Thu, 31 Jul 2025 11:28:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 02/10] x86/resctrl: Add SDCIAE feature in the command
 line options
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <f3b1e748c13086a7183ffd159e667d07a4ff6cab.1752167718.git.babu.moger@amd.com>
 <cb7c6520-e774-44cf-8328-08fc19e8815b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <cb7c6520-e774-44cf-8328-08fc19e8815b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0129.namprd11.prod.outlook.com
 (2603:10b6:806:131::14) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ee65c8-6f27-4cb4-ba2b-08ddd04f4bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJ0T2hiR3BXRUN6aE1jNkFXckZMVXU5L1pJWjF6Rm5NS3Izd3p3Rm03NUY5?=
 =?utf-8?B?c3dsZEQyak5kMjEyajF0bmsvMnRmM0s4cGZDMXcxNjBDMmlyUHQ2NHE0Wm80?=
 =?utf-8?B?aHM5elMwZzV0bVU0SjVqOXY1TGNyNHNBcGsxL2dyL1FpbCtrU0JISVQ2QVND?=
 =?utf-8?B?Y0FpTDE4NWhTQjZhVnk4dkJPRnNjWS9ZdTV0VCs0RzJnb09wQTE2Z0NqdVZW?=
 =?utf-8?B?YmJ2SHo4Y0M2cU51UXNLRGd6NlZrTG9reURTUFNkamZIeDlXRDN0U3grQ05Y?=
 =?utf-8?B?KytORjhJNXJjZlZnQjBnN0pCZ0F2MFljbDk3N2JZWWRTZmdaWVlmMUxqRmVU?=
 =?utf-8?B?N09hZ2ZRTkpvcGpoaldNQlRtWFZQUlpqSkpLL3loMkVGdFJ1T21jM21RdXFC?=
 =?utf-8?B?UU1rSW5vdTFBQXZqOVlJM1I1b0pQWGwrNmk5UDFzV0F2WFJ5M0wrTm0veDhw?=
 =?utf-8?B?eTV3ZDRQUFNROUczYlRyaW5DQmJJTjAxMEorSkoxbTBBMnVNd0puMWFtWVY3?=
 =?utf-8?B?NGVZVWlrTTA1cFZ0TEVpREhDS0lEcUNPMXlrRWR0YXE2dWJ1TElDKzhITmg0?=
 =?utf-8?B?SHl4MWdlbGR0WUVDaGFyK0ZueUN6Wm1wcGVIZU11cXBwemFnd2cwYzllSVUw?=
 =?utf-8?B?NXdVKzF0MjF6VlRaZmhTblJFTnd3QUNqWkY4V09GRlV5cVowdFloMkhDd1Jj?=
 =?utf-8?B?Vkllc1IzcDc2RjN5K0l3bnZTQWhqUXhGTjhNSmhUWFFzVU5PTmgzYU5ac0FJ?=
 =?utf-8?B?RUlpOWw1Q1NyR3FRUFl4cTUrdE4zWHU3dmRNL3BNNUdWbitxaDlIYzMwWHJz?=
 =?utf-8?B?dzhBYklubllDS2JURU1EQ280ZllrQk5VcTVSZlQ2MCtmNkZoN2tqeWFxR1Av?=
 =?utf-8?B?MHB4d1BGZkhxRzRLcFo2S3pUWXV6dG9XeFAwUXBHbjZSQ2lFWDVOTXZxWDgr?=
 =?utf-8?B?OG9RODBCbnpXOEpIRGM3T1d4WG96UWNYWUJFRGtPZ0NwNnBzSjIzbGVYWVdm?=
 =?utf-8?B?YmdiR3R3bTJ1Z3VwSDQ5NkNsejlHRUR6QWxtTUkwZUpzWXpwSE1SdVk5Q1U3?=
 =?utf-8?B?dGFHSWI0ZWpMUFhhcWJSYkhHYnJwdkhtYmNESFlwVkFwVU9zcU9mMEJtUVg5?=
 =?utf-8?B?YldzeE9wbndhL2MwWElDV2ZPK1daOCszdVFCN2RJYURtdHFlN203Nmt5ZW5D?=
 =?utf-8?B?VVh4Mm1HcmphdVd2QndjN05jTk53RWRUQ1ZwUFliQU9oSDk0aXZxVmc5cVh4?=
 =?utf-8?B?cDZnS0NTdmp3R1JhLzM2MTFQY3BRV2p1QUZyS1FQODUzSE5sbDcreXczMWxR?=
 =?utf-8?B?T0pJZllxcTZVc05KejdtZ2hMMjBsSktvVTZPMlNsMjJud2x1SUJGL2o4eHJS?=
 =?utf-8?B?ZWpzZVBpbjZGZlllV2tlZ2lmTHJBeVFpOTQ1U3BobnIwVEVKVlRhVHRBdUNZ?=
 =?utf-8?B?UGVJNWRuZ0hOWnBWS0V1MklpcGtydk80emtNLzFoVTVGaG1ucHlHUVZkaU9E?=
 =?utf-8?B?S0tWK0NkVCs1RTFDQlBpc092Rm4wVFA1eWR0dzlYeUdyQWpuUEV2WkN6bUE0?=
 =?utf-8?B?aWJpMXgwRHJxeW1LZkdxaVRaVC9jWUcwS2Qrd3VDM3VuVml5bC95M25KbmpP?=
 =?utf-8?B?MGFzSytjTE1jcmQ1WW9WWUlkZ2U4MWFHTDdUV25ORW51YnJ4c2hERHU0dGIv?=
 =?utf-8?B?NUJhdUF6WFlXSGZ6WlRqcXhRNFJrRHZDYmZyUjdjQi9TdnJ2emw3WU1NQ3Yr?=
 =?utf-8?B?TGxRQk1HazJ4Skh6UDI1dlpodXFmSGtWQUdTY21Od3FoOGxJbDVRVWU5TVFu?=
 =?utf-8?B?Zm1DV1Y1aGhCaGRCdHZOSXBsUUpmcW0yOXpiZzBsL0Q3amEwVjVkQkJOcHFZ?=
 =?utf-8?B?cWhTeFFxRWszbUYzUUVpb29VR0J4dHV5REY3Z1BlRlcycjZHcmJsZE1Rc1Ri?=
 =?utf-8?Q?HPwjMJbIEmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STU1a09KN3pveWJUWjRYckl0VTRCalROU2E1cmxRMjM0N095R1crWmo1U1lq?=
 =?utf-8?B?L0p6bnp6cGlDMnlSY3BLNnpWazN0T0xhTGpHVGlpWGhVeEExUGVua3FhS1FW?=
 =?utf-8?B?Y3pEdFc5eEliV0RpWjBuK3BFRkJYVDRnMXBvdytVTFhyOTdoNi9XNU5YSFdC?=
 =?utf-8?B?QjhzVlRwY2FNUjc1bGZJY0YreXY3YTZvMkFhM1BTN2Z0cGFlL0p0QlQ5dlZ2?=
 =?utf-8?B?a011dzQvNXlHM0g3dngrUHNXZW5Jbld4dnFXNDNjd2hpUHlYMHJKS2hnZmw2?=
 =?utf-8?B?NlVyZjZtYk9kbnNGVGRMQkdGS0dQVnB1NFZjRmZmY25QRTFxRjN5NExyVHlj?=
 =?utf-8?B?N0wyQzlmVnpwRGRueng1QWhONXlKeHo3SERreEJFRUZ4Y04xNUdpcmgvSHdJ?=
 =?utf-8?B?aGhjOTRNQ0RkL28yaVYzNVphOWdsV2RqQ1dnMlNOcjNQMmJYWUpCbGRsWGZI?=
 =?utf-8?B?YjE3d1RSNUNnWHhUR3hydU9hWjhlQVFxK0RKeFdhWmUwZFdRd0VXSmxtSzEw?=
 =?utf-8?B?TzhsKzl3OFNpWkZ4STRIRU8wQjVRc09vREVyZTd0Z3dadkEyQVV5YllVczRt?=
 =?utf-8?B?aEVraVgreklVWFU2bU4vcHlDeHV3bTB5OFBXZi9hajZBUVVYdmVJYVVvemg3?=
 =?utf-8?B?L0QrTm14ZElSNjNQUlJJK3NnSTdaNEgrcFc5SERCeWRYU0t1TERNcmlGeWsz?=
 =?utf-8?B?VEFBYXJVcWhhUHFPYUZOZ2MxQTRBeERBNkV1eW5KSVNnejhxK05VSUNPdGdL?=
 =?utf-8?B?SEpmeWVIek5KU3JUZHdaYmlvRUI4Rm9nRzJKc2thTUUwL0xncGlKZnZGeU1v?=
 =?utf-8?B?bGJWRGNmdWErUENXbDRSMnBKNVVOTDVNRHc1TTdnV2JzVC9vbjJML2I3azRk?=
 =?utf-8?B?SFEwYm5OWm1xNjFXUnkySDdFdFl5OHpWV3N6RUlWdmsrNllxRkNuYUVNT0o4?=
 =?utf-8?B?QlNwOWxUZVpoYXdkeUs3ZWhiTG1FaVNyTmo5TFloa1FwczZxTWkwdllyZTl2?=
 =?utf-8?B?V21UTXhmNEQxR0J2c1Byc0hZRFBMc0Rydm01aWtNQmZsN0lSR0pmSnBCNitU?=
 =?utf-8?B?eERQbVJSVERpSldGcGtabjZDN3lEajgxUjRhMnlzQmxHVFRqZWxtc0hrZjBh?=
 =?utf-8?B?STlPZXRQaVZlSElObk5IY2lJaE9mUUtCeEpFWmU5RTM0UlhQSm1hTTVWLzhK?=
 =?utf-8?B?UzY1NmdWU2FLTlR6MDMxUEdwWGlpRW95Wm5LSUp4WG91Y2lMOFh3WitBa0Nj?=
 =?utf-8?B?Ny9GSmtQOG5YVUI1UlpQZGdWZ09aT0NNWGh0QllPTEs4Y1dUUUh5bmd4bm1N?=
 =?utf-8?B?dzhNNTZudFArT0VESmU0YnlMUG5kZTlmekNKeHhIbVUzMmlYNDFIa1V4dVFt?=
 =?utf-8?B?bFY2Z2ZZbytjdmZCRzVCcHlWUysyWjg1a0dDSGhDcGpoNlFibjJDQ05EV3JB?=
 =?utf-8?B?RFNkMGdoaVo2ODRRTGdmUDZzTWJndUhDYitsVjh5N0huclVEZlJ0aXBHYVNk?=
 =?utf-8?B?UDZEbVNwWnR4M3oxRnVmWDBnc1MrandqZ2lBb1ZoVUVzTnFYVVFEYnZJNzJq?=
 =?utf-8?B?bVhRVFF6VGJlMnpwWEdDUmwzY25SZGxLdzlnMmxkSlhZcC93Ky9PbldKVzFP?=
 =?utf-8?B?UUFhZHJHamlFUkpHVHdoT3VYZjI4T3ZpSld3bmgwQkxoa01pYnFCREx0ck9W?=
 =?utf-8?B?VlE5U29hYUFDTzl2ZXArWGNJK2QyVUt3eHFXT0wvclhqSXFPSmx4UkFSZEl1?=
 =?utf-8?B?RVZnRXZVNDNWbDFHekJhMElPem5QMUs2blgyNTFSOG9YV0NKWjNnWTMzbms0?=
 =?utf-8?B?bVZjcEdTQ2FPa0UwRGV5andyYTNKNWNqREN4a09TYWg0SDdEeHJVcVpXc05S?=
 =?utf-8?B?dWlncmdqY0psTlNPV1k5enFNMTkrbVdFanU3OHNzc0l0TkllRGVqekt1TEZ2?=
 =?utf-8?B?R1RFWGVEajRPOEtTTjBXc3Q5Q0F0QkFNOFdwTDdwaE1qRU52Wjd4aklGd25k?=
 =?utf-8?B?NVNkOHJTVFNTcXltSVJoZ2pLTDVUVDlmcldDbkp0REJ2YmhkYTJQeEJ3MEFp?=
 =?utf-8?B?WHJURlkvTmtpOTl4cEFaYWM2VHFTUHVXRC90dnA0SFdyY09ZS2tEWmZJcGE1?=
 =?utf-8?Q?/hrSUoxloWBcvvaHp3yx2UPMC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ee65c8-6f27-4cb4-ba2b-08ddd04f4bfe
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 16:28:35.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTdRcBzI45E8zWvnskTserrXbc3/GPM3RlZADqDTMZmKj+lIVRIOgfKDdqBgFaaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

Hi Reinette,

On 7/21/25 18:29, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> Add the command line options to enable or disable the new resctrl feature
>> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>  arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
>>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Could you please also add associated update to
> Documentation/filesystems/resctrl.rst ? For reference, the similar
> ABMC change:
> https://lore.kernel.org/lkml/00cd603997e3ee6a389f83aef066fe7313b1abaf.1752013061.git.babu.moger@amd.com/
> 

Sure. Will take care of it.
-- 
Thanks
Babu Moger


