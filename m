Return-Path: <linux-kernel+bounces-883514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A5C2DA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774A63BE635
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B272618;
	Mon,  3 Nov 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FXC674Gq"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020114.outbound.protection.outlook.com [52.101.56.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C22AF1D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194140; cv=fail; b=B3b4CjjHLbMubnwWFSypDSmUgEdjU+fw7zctBNJHLtKdK5c8W0If3yR4YuIyAGIBJDgnr64Dgqd3cdA2S/Pcx1viDqOLGNEhBrx9OzshWwjeZd7IuS2O7XCGHV08BDFNH4lpmlsgGWmYkA9Y3n28fDTYP1/c524Xzgy0LZdLH8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194140; c=relaxed/simple;
	bh=/SDsRNtXpZ7j7aufw2Qiwpwc1Iiauo30ck9wpMYbGBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bR8QgtbWAldT0/bjRpHoTzUuh6jFZw3K5PidjaWXjnpGH9whyXpjQTctqESAPa0LQFKt9LbDOP1PTpmWgMZJe9M2OII1YBdTcBMHMHqH4c/6rGKFjwKBFfw+IRMjw6WgcoxploOWhScqe7NqG3Q5kK4IFOF2z5H01UkCZOG1C84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FXC674Gq; arc=fail smtp.client-ip=52.101.56.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwRvKneVrny9FKsvOV+tU3SxHuY1xfigNzEPSpJ2SX1laRz5Ap7Da7uvjc5+sv0uicSJYteKTl6lCa68iYw6HMlkUtgjNEowzJMOJeu5NmfL/wAnYX6iHKrG3USEW57wzKFR5bpm0EkZ/lGmfjgJf2O/z9L4z9GTZqmlyxB5ID8uw3NOVxYJU0nJw5Op+MX3jjktgXS79s/kH3uzuul6m46L7ayQ5cQRxt+V06NBzGIMTgnw0ExRF/ig6lYQIV+9A8ZLuwxX+2I1IzIsGLnMMcuaeyBqWGXpSaELNFjcZQD3oQoHBA+MewNxfBMvTdaQpHmTzyuNgrU02wtQ2vfP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOkSrmlf0aOWsDYEHY5io0janLDt+V8WTrWiBQZVLTA=;
 b=baS2dsl5nXdj7cw0xYx8cecKDkcWIpnzG/H9QTjCwPkxM2x7uhiKNLjF0WGpRU6qQaSjR5852qHp2zYMIU4nbKtPCwB+xiOtQS3+BS03UYBHIxQzMml39XvJSHHRIY7ZQ0zM0RTFswC0Er+UTjpHsHKNBTTKGNBmHdipAIV3xKsBcQGRMUZB71zEpLQAnLR2yeAOQ2osVgNKSTdquMRUj18nRqnoHnNIcO2t5idyxoUK5QhddBlOvcuaHKvKDDn4fUoBsNGStZ6CTJcUgu8kutE8prYeF5mvDf0bP3T7ZirNH5J+vnS0nFwa2+u3i15j3FPXvvMw9t39lKxUwXjTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOkSrmlf0aOWsDYEHY5io0janLDt+V8WTrWiBQZVLTA=;
 b=FXC674GqrESbeFLzKmQakaDX84FYoCLh3jwLGPBwL8poJc+7hcquGtSwdrGJm6k/YfQG2r05mT/Z3zZ0Wk3zpExqSOTG1ncSmenI7zYaLt6DnfIvsMfZG6lCjJXU+ZGJHruxPMmDYV0ezuhDYcyDC7kWkUx+dY/sYNgpf4iynxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV9PR01MB9399.prod.exchangelabs.com (2603:10b6:408:2ed::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Mon, 3 Nov 2025 18:22:15 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:22:15 +0000
Message-ID: <3fe7e501-b319-4b9b-b129-dce5e945bf9a@os.amperecomputing.com>
Date: Mon, 3 Nov 2025 10:22:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] mprotect() can't clear PROT_MTE
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <04ea9978-e6aa-4498-b899-76d56e19b084@os.amperecomputing.com>
 <aQUEk6a_3OWapRbE@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aQUEk6a_3OWapRbE@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY3P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:fb::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV9PR01MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: c58c8fc7-a697-41db-ddb1-08de1b05ea65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1BVZS9Bc2pTM2E2UHhyNy8yL1c5SE5jQTFNQnRPdWxkS3lNWmdwZHlGZ3Z1?=
 =?utf-8?B?SDlIM1NlMncrTzdRM3E4OHJSWDE2RnN2Yno1dEdJejFGT2dKLzE0aFZraGh6?=
 =?utf-8?B?NFYxTXUxaFA0dytrRmNhckIzSjZybm54NUlEQkw5VXlZOFlYMXIrd2xTWFdz?=
 =?utf-8?B?SG15VVZjRFdwQWorL2I3R1Q4Wk9UaUxYRE5VT2lCL09zVWIzN2pUZzZ1L1dL?=
 =?utf-8?B?OU9temhYZWFEeW92YWFNSlpNQVV1bStxRWxFaE55SmRacXhPdEV5TFhVaFA2?=
 =?utf-8?B?cE1DMEQyNWNlNmJXWWxiU1diUW82cUtsMlVoQXdTcTFtb2ZhZDlFZTlSaFcw?=
 =?utf-8?B?OHpPWFRCdUluTkIvbWZwMXhXNDdGbXpKNDVGaVBXWTRMZkhMOXVjb0NIc0J5?=
 =?utf-8?B?QmdhbFNPRk1OWXc5WjRpRnNCbzhEQXRqRHhncU5YcjFhTlNWcEltYkpPTlNz?=
 =?utf-8?B?ZTNMZ2ZWZEpCOFJqU1Zkd3BTaWZxa2xoZ0Nia1RYUURNSTZ0Vm03NzJENTFt?=
 =?utf-8?B?RksrbHlBVTc3K0N5M1RPWDZqTTJYbDZSMnhxOExWRDNDOUNRRG85QUh4aTJP?=
 =?utf-8?B?dEpjUzR2K3FFVmFJQUZvTmlIRm9WZVhEdUhxcUFBb3dnSkd6RllKSTNPQzZ5?=
 =?utf-8?B?ZStmb0Z2VkE0NW8rZEI4UGNIOGNIMHJCMG04L0Noa2tDdCs4NEI1Qm1uR0tY?=
 =?utf-8?B?YmQxcDRxcVUzd3hDc282SEhERklmbWJwekFtb1VqY3FtMXptdUwzNnhCS0R0?=
 =?utf-8?B?TFZ0cWs3UklYbTQ0c1E1am1xalB1RndTVHd0SEo3Smd0bDZhRUZibE9sSmlH?=
 =?utf-8?B?amlLVDJsQVBUcS9OU0w5RTRjM05hek8zZm40b1NaZ1FjTS9VSlp4cXNoeFhK?=
 =?utf-8?B?c0NLaUt5R1BOS1ZBb2xaWE9BVVMrcTZNM3MxY2craXpKWXVKejMrNkZhWkE1?=
 =?utf-8?B?eTJUWjFleGRKeU9nVGUrbXBkbjZjOFhWcjg1SkdzdXcxK0lGeG45Z1BPYmRa?=
 =?utf-8?B?SzJLd1N2NFAvQWwxMy80ci9uandyMlpvcUFSc0pmcy9SV2Fwb1dnQ0d2RnFo?=
 =?utf-8?B?cE0zR2UrVlhzL3hGNktUSm5Pam1FdUlxNFdkdHdabmpoaFZjK0FYbllZSDdl?=
 =?utf-8?B?YTV5cHpFY1BmeEFUOVBiYnh6SktvQ2JIOUh2VHR6UVhrNmhsWTdBeEE4WWdy?=
 =?utf-8?B?c2tJMGpkU3pSTC8ySWoxamlTMnlSNTN0SWhmbWdRL0xXVk4xSDRlSURxaW4v?=
 =?utf-8?B?aFBNVFV6OVpZSDAyZm04SUlhY2lMb1ZwL283dUhkUDdFN3h5bkZxYUdlZ3Jw?=
 =?utf-8?B?YXRydzRMSVVkM1lqRFFER0lwcTN5WjM4Wm5mbEhEVld2dUFaZVNPWXJQaDZo?=
 =?utf-8?B?OXM3Q0lUVnBiQ3FOMXlLU1RUM3pXdUJvS0dVRk9TbGdOSlJpUUZLTDdjais1?=
 =?utf-8?B?cnBJNW1hemxkTkpxOWsvRy8zaUYyN1VUK2xhcG1KOFRUY1JsN3Y1Y2w0bjYv?=
 =?utf-8?B?MVJQMFFSS0EySmxuR2tKVWsrQm1ad3pPTS9CSkFHNEg4d1E3MWtlMXI5M0lo?=
 =?utf-8?B?c0pzMm9IWndzV3gvaTdNVElOTWIxY1ZNa01oQVkyeHpaUC96NW5ZV2ZNc2xm?=
 =?utf-8?B?M1lBYWxuZFUwOTdkYW13WURKTVIwM25jOEVzcElseHlOdVpUSEJXVGpPWXcz?=
 =?utf-8?B?dmpOeHFsZFZUTllMdGpVcE9Od0w3TnN3RzZSc0lzWjV2TzAraXMyZU1FSjFt?=
 =?utf-8?B?T3hoWkl5QmVBK2htckJUVEVYY0ZyWUZ6U2x6VUpIQWRydWwxR1Zlb1Z1dDdO?=
 =?utf-8?B?OGJ2TkhaQWJLWlJNRWhmbTZjbm5CUW1BR29yVHpTOUl2a3Irekp1enNHeU96?=
 =?utf-8?B?eUdxUUd1TW1sR2d2emh6QzFtZngvTDdhNit3K0lNM0RaRXViMjdob0JTeHBL?=
 =?utf-8?Q?9QC/kBURGTb0NiRJK9qBov+LMWzlYAGM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVpqNUVrNkhZV3pwQzU1Rjc1WnltTVk3RW5xREF3KytRQmNjN0ZvREkzRVp1?=
 =?utf-8?B?Q1V5bGlrWktPRjVkb3k4M1lYYkh2cjU5bFdwSkJSRE5oRnRFMCtHeGhTR2hu?=
 =?utf-8?B?RTZtdTBZK3RVVlYyTlkvQnUwWU5LYlN1MVVWeXNGdTk0aFJTcUJWRisxNHZv?=
 =?utf-8?B?QWFDVWFOZjB5eG0rSU9pWVBucjExYVdveG1ONHNxbkw0eE1ENk9qeVlpbjlz?=
 =?utf-8?B?Nk54YVMrdzA2ZzhwbGphRXlCaTAxV3RhMDFpRG9kcEJKanhJaW9vdjJGN0F1?=
 =?utf-8?B?K1lWNG56OFFja1hZL2dCWmgrbDVLS2lHVHg5Ny82UVNROHNkWjdvRnk2NVU0?=
 =?utf-8?B?SVNZNzBpUGNleEh5UUkydEdNaEpWSVozUjdrYWM1NysxeFJqaVFjcnEvV3k1?=
 =?utf-8?B?ZEI1ems2RWxuQ1FZT1BiTmcxVGFuMDVBaitXbGt5Y09XVVFnZnp3c3Q1d2tn?=
 =?utf-8?B?RVFjQjRqVW5GR1QwZUN4bXU2ekUzU2lBWkszY3ZzOUxVQVFnb24rR1NCeXVX?=
 =?utf-8?B?VnlCc05XaVRnem9zRmFucCtxZWxmd2hSRXkzMytKY2ZtVUFjK1ljVkdNYzMy?=
 =?utf-8?B?aXhjTGRFOSt2cE9PUmhaVXordngyK2hJTTJGSHBKUCtZb04yOEdnY1JPcXFt?=
 =?utf-8?B?bUlzalp1UG5BczExbkNuS0hNcDRKMWFDN2JZc1NFRU1ubmgwRTRrM1FGdnVQ?=
 =?utf-8?B?bWxJdDJTSGF6Z1pHRWVlRlVRQlkwd21CcFdoZG1mNnNQdkNQTTZmdTJRS2Jn?=
 =?utf-8?B?RnFXdkZEcmlDMkVWTHNxVG1PMUQyTGM4QWhwenU3NnBubXJ0Z3VwZ1BIdzFG?=
 =?utf-8?B?ZG8vZXAzSkhUNUVBZngvWVJab3lWRG5JU3duTkFKNit1N2xnaGNnU1JFRXdF?=
 =?utf-8?B?VFo0ZWZOa3lPcEFHMWlXZVZ3WktqbFdDd2RmR3BZZ3JNOW94Tm11WHRqYjVO?=
 =?utf-8?B?NWF5M2l2eGx0bzRvSlBONGxaZ1drK05lYk9tWlR2WDNtNzBJdHQraDBFWnN3?=
 =?utf-8?B?K2F6Z3VhRmFGdU9zdGU2ZEFES1Z0K2pqazNVRSt3VEtXcXd1cXFDUGRBeVAx?=
 =?utf-8?B?YUlPdm9pUjZtSmkwa1dWaHBtQXFXM3d4QTNBNzJsK1ZVM1I0T2UxQko1ejRj?=
 =?utf-8?B?TjZETjMzemVDck9adjJZM3l2LzBGTXhlVnpMeXZMa3l5RXUwcktzWEJWTnhD?=
 =?utf-8?B?c3hYRHFOQnpDZk03QXJEL1AxMmpMTU8rcjJWOXVJd0ZHM2lLN1laRG5iUmdJ?=
 =?utf-8?B?S2tiQm9NVS9ZYUdYSEs2eUliVmpHNEg3emhWUTlyVUFITlR5OHpqVElaa3RQ?=
 =?utf-8?B?UUdQU2crdm45cmZBTDVKN2YzMEZiWUdFamt6aFV3am9OSWpaZng3QlFCODVl?=
 =?utf-8?B?UW1telJkMzJ4SFA4RmdmamEwbkVtMlJDSzl1bUNXa281bkhiU1RMOU1mejJy?=
 =?utf-8?B?WmdVbUdxVEZ6amF0NGdUUW1PaEhpaDdYRWordTNCV2U3cGR4TUlFRUsrRjRj?=
 =?utf-8?B?SEpiZElzNDRqQXd1aVp3UUhnZ05tL3hkajdTa1ArVEtuSlpOQTRWc1JRUTdU?=
 =?utf-8?B?ajJLREdmWnpsUEk2WkFQVFhRb2VqRDdlQ2ZwTk55L3RIZENOZTJQSEtIbXhM?=
 =?utf-8?B?YTEyUTFtTURCa0xSbW1MQ3h2TGxZZWpCTzQ2dEpVcjEyMHJSckpNUEFMTmJZ?=
 =?utf-8?B?Z09wV08rdmxuQWE2cTNMakhORnVNUElqUGxscHZnc1ZicnFEY3pWZDBFWVRz?=
 =?utf-8?B?NHJSYmwydk9IOS9TbkcrNkVMMzdhdVJlVGxYWjRvdGE5ZDgxTFlUQUU1VFZn?=
 =?utf-8?B?NWlZMHNLSGdEbWVwRjlTOW5nTXE3eXNCUVRZck9ETjRodTJxRnlIUE0rU2JD?=
 =?utf-8?B?Z25BU1lzeFhQMnNNYVRqdzIycGxMYnE5ZTFWcTBBQ1ZLaEIxUVFnWTRpdmpk?=
 =?utf-8?B?RXJTeWtoSEhoSHdrSWNrRUphNGxNN2lFRW5XN0p4alBKNUtmblYrellvMERk?=
 =?utf-8?B?NzRqRXBVYVdaWWJnbGFqQ1d3WTFVQTlvMkM3RXFobXhaRGVmQWZlK2tzVFhT?=
 =?utf-8?B?WEt4eHNZdmVtazg0SHcyd1k5VG14MkFBWHFVVXgzNmJPWHpmb3pHS0JabGpo?=
 =?utf-8?B?QWhFSWRtOFBIMGV5OGoyOERVYnVYdFZJbUJBZUplajJUTUVZTm0rdmpqb092?=
 =?utf-8?Q?Pbk41V4XavTcomwZCjpb3js=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58c8fc7-a697-41db-ddb1-08de1b05ea65
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:22:15.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SJ4myyouWc4pTuSK7pMn4dXMywePRAeXnyGuWCNDx/EPXsZ4A4Z+gRKjFsYNVM0V00T4raB+B0DhzNdNYEXY8CXVFrQaekOT2E7PZ4k+lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR01MB9399



On 10/31/25 11:48 AM, Catalin Marinas wrote:
> Hi Yang,
>
> On Wed, Oct 29, 2025 at 03:41:17PM -0700, Yang Shi wrote:
>> Our customers have usecase to untag memory w/o unmapping it, but mprotect
>> can't do it. It seems like an intended behavior because I saw MTE doc
>> explicitly says PROT_MTE flags can't be cleared by mprotect().
>> But I don't see why mprotect() can't do it if I don't miss anything. So I'd
>> like to know why it behaves in this way.
> It would be interesting to know more about the use-case. At the time,
> clearing PROT_MTE got in the way. The theory was that an allocator
> controls the tags and the PROT_MTE property but if that range is used by
> something like a JIT, toggling between PROT_WRITE and PROT_EXEC would
> inadvertently clear PROT_MTE. I'm not sure whether this would happen in
> practice though but it's ABI already, so we can't change it.

I'm not quite sure about their usecase yet.

Yeah, understand. It has been an established behavior.

>
> I'm happy to add support for this if there's a concrete use-case but it
> will need to be gated by a prctl() flag to keep the current ABI. A
> weirder approach would be to add a PROT_MTE_CLEAR flag (I think I prefer
> the prctl).

I agree we should not change the current ABI, some applications may 
already rely on it. prctl sounds fine to me. Anyway we can discuss more 
about how to implement it once we have more solid usecase.

Thanks for educating me about the context.

Yang

>


