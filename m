Return-Path: <linux-kernel+bounces-869266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE11C07742
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3407635D284
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F271342C80;
	Fri, 24 Oct 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zdv3LYvx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0331B823;
	Fri, 24 Oct 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325478; cv=fail; b=g3hn1KlefVpmyv0QzmQGJj/0yGt2IwmBqABm7lCCoVMdj7YTCt/wfRD27ZxgP1bPifj/o2uEgGYw5L7fhtimZmpBw2UVfikP8iUaXLUBAsTVpQFdHeMO1oMLm6kwRTcL2YcA8B2yRp8YpBCoReN0Rp5QipEwm4zHgyFgqQt8yKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325478; c=relaxed/simple;
	bh=ELvITkGV7sk8l+bliWIBQJfAD33ZrO+VSM8XwGV9tM8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oW6BzaCsZ3aq3P/V2ujTwEVJEHy8dxlemoJNi36SIpCiCnSVHFm3LDL7i1GGQ4UG+/Y/94exrjC4fJILZ7ldr/BwgFwdMuXIyS/IKjZexhd50G7kYaCaPSG3N+9P1hyAax7xHkzwO/K4hPziVY117RqnqxZfbCXQDI7mZSVRVTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zdv3LYvx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761325476; x=1792861476;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELvITkGV7sk8l+bliWIBQJfAD33ZrO+VSM8XwGV9tM8=;
  b=Zdv3LYvxcQwKKSS6VRLa6fOxJMO/fm1Rd5/IHbOUpaavv65OOXeUunJI
   frt+fyVJLXPifiz79hjz041yjHgSWywPEm5RmFi+N8IIFjMat77Mxzg2t
   I+rDyGzZ5sixsP8aZYM9YnR18mKCxYMzYD3bOGqZc7fCKqb4j6GqqljLl
   XHMRlHivsN1YjQG0lsCG7PNWluuAp39URLfQgvAQASgSYPjBpFe4HkEqm
   S7LVOpaEosy5s1IeLJb5sK20tHYc434It452qmRcMhvoqLooDYYJaSn1u
   f8rXwt+b5OJSRWPWjT2ccNcKuE3uziHYbm8pkx1+QaIejCwmeTHkTlrXK
   A==;
X-CSE-ConnectionGUID: pDtZDANUQ4e7KLdNdheBgw==
X-CSE-MsgGUID: 71DC2Mn/SX+bC3YvLo6DCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66126296"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="66126296"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:04:36 -0700
X-CSE-ConnectionGUID: RrZJRd6ASheeTOXQ7bUvkQ==
X-CSE-MsgGUID: JqtlbbO+SLWUT0n74zIOTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="184085502"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 10:04:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 10:04:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 10:04:34 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 10:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvH5DG6jDOmon3Ryj7Ck6ZIVoXKJEVQTjNpMo9tXyb5KHIXVBIPUO/4dOV+nO3kQhefxlzq02XNEr0ADBLDbWllVb2NRj5VOGXJUNUyOpKdvBs1FiTv77671VNpYqtwCBrI2wVUKPtp4xrL+IvhC1oFTkBNvY0kphD5PNzEKRbSzTtdyzGIv0BwZ77JS3FUyW++s6ZuApGFttQfxn9b3I3lPu11xiHbN4IQ+AOrK6O2tj/Wo73v1yPDtj9jRTEyUAxY/n6ZmxfU6Q7m9yzZkIkW1gXEFozXVj4VpUA/MNRIlTaMPYGfYeHUCHL7juHg5v/DdZDency4GluZ3V7w0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPQKzfDcXE4QX33JGV/XkTXjuIv0Ko+EMqZnYEaqZCI=;
 b=BZxvGJMpCTH55hVeG42hX9uUKD1bVgEoIXeXTSXkdPVcVS1LOI8QLW7rDYqwWIZVwDudNzNH0NHxOVdt4VuBtlVDCtkfQ6LwA6/ScfCp+9pYTqAp1I5C9LoCADwa6DPoErJ3RzBzwKZjLXl948EuL3PWLj+IY9w/ybrQT0dH7CsoNaTyU3CEF7FlB2dEfUMHt7YKCqy7I2gmJqmo2oBj6cL++TR4MLzLwv7h6MPyxAiRFgNzu/INAnB74zPf2S+UUS4cKLVwTzvxZqDecgv6MpX9BVDNJc768pJVtL0lS/FRyYkOTDErTv0rp+zdqaSVKyDzDw87uh3usgzW2fDwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB7607.namprd11.prod.outlook.com (2603:10b6:510:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:04:32 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:04:32 +0000
Message-ID: <423fab56-ec08-43aa-9742-4fd4df2849de@intel.com>
Date: Fri, 24 Oct 2025 10:04:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
To: Greg Kroah-Hartman <gregkh@kernel.org>, Steffen Jaeckel <sjaeckel@suse.de>
CC: <cve@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cve-announce@vger.kernel.org>, Vitaly Lifshits
	<vitaly.lifshits@intel.com>, <dima.ruinskiy@intel.com>, Mikael Wessel
	<post@mikaelkw.online>, Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>
References: <2025100116-CVE-2025-39898-d844@gregkh>
 <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
 <2025102432-motive-passage-eacf@gregkh>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <2025102432-motive-passage-eacf@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:a03:117::25) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef87e6c-be1c-490f-25a6-08de131f6697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2JkMURyY21qMFpoaTAzczZyZFBobkpMSmMrbUM0ZGt5ZVpwVTNTZCtuY2k1?=
 =?utf-8?B?UXhIWXI2ZDZqeVRUMzNaZGxoTmVGdTg1dDN5WmU1d3hkeVBXd21oT2NGRS9C?=
 =?utf-8?B?ZUJkb2hqaHZ4bVZRYllaTis1UU5VbUdydG9FRzN3NisxeHZwN2traElpTTFC?=
 =?utf-8?B?eUVnNWpDZVZNaU5MYWp2SWNMdm5rQjJ2LzNMUkdjK2RlN0huejh4YUxUcVNX?=
 =?utf-8?B?TDA1UG8wenhiSFhMSEFldUtwVjRXZTZTd3JUdGlXTitRM0xwRUJWc3F0cTdS?=
 =?utf-8?B?b0NRazNxTlZMY3BMMGFkcGtWTE13OXM1TitKUlJ3K3gyM0FxZWl3NEsrUEsv?=
 =?utf-8?B?aUo4UzFDZ0V0VllhelJLRG5zNTB4U1JRbnJkWEdNZ053d1J3WXM2T0hCZU4r?=
 =?utf-8?B?R25rbFJHV1V1YVAxaE85My9uWk4rU0IwU0ZEUDhFaldFdGRrUHJsSmZqMkQy?=
 =?utf-8?B?OTlsTFNLWml1R1dpQ2xNV2hLb0UySmdqNklxQzQvamdpUDBDelhkc1NTbkI1?=
 =?utf-8?B?clVRNVRMZTRYNmpIek1VS3FmaDJTVXRmUlJiVC92UDhLV1A2ZjlBWWRjN09W?=
 =?utf-8?B?a2dZQ0MwWkVoVTExOTQ2NG91MXBKZ3ozOVE4Z0FOTmFsVVBqcFVOUUFlMXZu?=
 =?utf-8?B?S25pbDI4VGQyYzhHNEtVRjgyeVEreEwxSTZMaVVEbmVFQXpOQzd1L1Ird1Uv?=
 =?utf-8?B?aWFEcGtFVFhaSkJHOEoraXZrLzNRTjZRaEJmMlAyZ3RnSC83WDJrZFYrZFkr?=
 =?utf-8?B?THVxTTJLcEpmR0k5ZHVOeDdFSmpuYmpBMUZHZmIybXRtMEJ5YkhUNTVzUUtI?=
 =?utf-8?B?WU1BQ0JSSWxIaURNUVlmMnNUaGlnWGwrUGc3Mld2eW1GYktnZy9vTnlhd2Jt?=
 =?utf-8?B?ZDM2Rkw2TnV0TzNBYkNCb1B2TnNicGVWWXdUL2JFYmZPWGRQYzh1Y2FkUGFy?=
 =?utf-8?B?am5CSTZROHdPNmQ5WHV6T1V3UTBYM0diOXhhclZCUnNFaTNBcTFpbGtyV3A4?=
 =?utf-8?B?NHpCUC9qNHBTbFd5WW9LZWRkaEpNTzZaa0NXdFcwSlA2ejJ1SVhNUDJwUFlP?=
 =?utf-8?B?Umc5MU1PbkJtU2lzSUgxejFDVlE1ZWpMT21VRkVFRGtmRFJDd3kyNHdNTlZL?=
 =?utf-8?B?SGxXL3AwQ1hnSWVZd2xNWE5jYlNiYUFDSlpHa3JaT2JqVzZod0ZyWnFDWnpP?=
 =?utf-8?B?ZS9tMlZ3cHNtNjcwWkZOTlBhUGhYNzliRHVJcWVCcjRFVVB2K2g4T3hNc3Va?=
 =?utf-8?B?cjJlelE5eThZazNwczJJcjl4REZnWlpDQ2p1SnlBTmRwMVptVW4rQUZyb0tt?=
 =?utf-8?B?MXVNUUtuTXVkaGVQNlQ1QWJtRFFiUkNpc0VmZXl2NjFVdlc1VmZ1Z0FoYmt4?=
 =?utf-8?B?K2xVVlNBTnE1VEx3NjBuWEVNWGNOdVFFbVdQcmhSYjZkcGRFZ0Fibkp2elY0?=
 =?utf-8?B?ZVFLdGZ3U1hHa0I5T0JuQnJqUW9PVW9USm9ZVE0xaDIweXRaY3N2YnZCQStI?=
 =?utf-8?B?eUtFcTk3ZnZ6QTFqOHliU0h1a3lYRG1YaUttdVdlU2w0Wno4bzJZVXNHUHla?=
 =?utf-8?B?bnV6aFdYZ0Z6OFpPWXFBejdwRkNNOUhvb3FMVlpiUE9xekZsU1R6Q0IxUHU1?=
 =?utf-8?B?TEZKV0xBM1Ira2U1aWlBK0pCY3dGR0hscWdUYzcvY3NENERMSmtxYU8rOWVM?=
 =?utf-8?B?OS9QNkx4bnNkZHVxQithYmpIUjVIK1JINHFCV3ArTlB2aXR1dzVJMlhVRTNu?=
 =?utf-8?B?eFF0TDBUUDA0UUwwUXZ2ZW9iYjZQQzFMYzdXKy9GQk4yTFp0eXh3S3QwdEdu?=
 =?utf-8?B?eVZ5aTRjVXNCclhrdjAzOFFGOTU1eFN0bWpEQkZtMUlHY29UWnEyVVJYMnhR?=
 =?utf-8?B?QWt1UXVnb3VyUlIwZlMrb1Q1YWNJSXlJSkgwT3crclRiWmhIbEovVU1RdEN2?=
 =?utf-8?Q?chBjWU5E3qgHzasxXInvzmp63N2+/mC6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTczWjRYTk9xUGR3WDl1elRzdjUyN2pzajR3UUlVbUc0dE9tWWZUVk5lSTJ2?=
 =?utf-8?B?UTIxNktyejZaZ1cwNnB6Nk1WNUk0ckxvMVB0K2M4UUM2Rm1RdWhkSytEUURP?=
 =?utf-8?B?RFhuRGxjZld6dWdPVTR0NTRtMG5EN3VoN2IwL0lBenM4dCtmalVlMStuNW1a?=
 =?utf-8?B?QU14K0VjNE5rRGRpNHNCNFVSN3lTdW9nck1xMnpRWmVETHJ4bERWeWlwZUxO?=
 =?utf-8?B?cGp1RXNXM3h1RkVhSFhWUnlsOEs5WllsRWZjUC9jMHU0L2ZZazVVaGUzTlpH?=
 =?utf-8?B?Sk5MTUtXVTlkeURYVWZBa0N6aktKam02enYyclZFQkhCcnFLWjRXeDdjUUJZ?=
 =?utf-8?B?Ky9qVnBEZ0FRV21RTTQ0anJMaE1jS1BtK0lnUmpYbTZtdnlPVFFSQmlHZExm?=
 =?utf-8?B?QmNrMi9CWm5hVXZKWG1jbFdmWDRtMGNwTGNmNzZONHAydm9abkh0b1lQM0Rq?=
 =?utf-8?B?UXl6Z05WRnZKYVI0VzgxcnVXTHNFbzlSWldabU5WVWIxNnVCbUNHQmZReTZI?=
 =?utf-8?B?MUlLWGhibzIwM3RqUlVRRWpUZWtDQkY1YTVjYWpxMWhOZTBzM0pnMGMrVTV3?=
 =?utf-8?B?enFucTlocUNEblpFYXdrY3NyQkhNQXVScHNpMHBOaUVlSlFNMWlnc1dkenEr?=
 =?utf-8?B?RDU4ZGwrUlMyd0M3SzIzL3lJaFQwOWs2NUdvR25vdlNpaERLTmJuUm5udGU3?=
 =?utf-8?B?RGdacndxSGVQR2Y3aGowYk1pcm00TnYxUnBPR3U1WWUrUWFJRVdLL2lVUkww?=
 =?utf-8?B?UVlMVTlKNTlXSGpGN3JzdzFyL2VJcnZvTEw2RmdMeGN3N1hDSWlXbCtCVUIz?=
 =?utf-8?B?ZklzSElsdFVEOFR1dVZ4Z0hrMVNieUU5Z25pa1BqNG9yYUxmTWVTMmZ4R29l?=
 =?utf-8?B?b1lKQSs1ZDZId3RrT1BhTVFaSlZ1cU9kWkJibkpkTEcrRU1xTG5NVTVkamJk?=
 =?utf-8?B?aGFiNUhOVlZJYXAwOGp1SlZST2pjYmZtM0RzdVFmOXQ2Qld6d2tmWXFmSzE1?=
 =?utf-8?B?S1c5UllKRlYybW5wTXU4cWh1RnZPakVXU0djanlrMW9saUNWclNVNkhzR1Vq?=
 =?utf-8?B?NUFkV0VoeTNqNVpLV0lCbGhURHdLTnBBM1V4YjNJbXI4M1JmRU9TNTZDQlpB?=
 =?utf-8?B?NGZSWGRPaS9yQ3VTS1EzdXpXdTBIdjUyb2ZYRkVWMEdMeUtwZDNqbTRGRVJR?=
 =?utf-8?B?WHNGaS9qaWs3SkVkUFZ1S2x3eUZCZWVQTm4wSmtDSFR4UlNZaHVYaWthZlgy?=
 =?utf-8?B?aU1vNk10STlnbHg5NmIvZ2hYRDNtRkxJcDFGOGNjeC9CN0lDa1lKRitkQ254?=
 =?utf-8?B?MG1YWmoxK0t5cjQxL3dkS1c0amoyREdrSW1xSzdFdkpCVGM4WlVsbUs4Y0ZW?=
 =?utf-8?B?S1BtZmMxeWs4cnRHaHhOSW04all6VE9tYWNxeU43TTBlRFplWE5UZ29vMlZN?=
 =?utf-8?B?YzZRUHFQVE9ZbzRwbTV6anV3WG9BN2oyOFMreW0rMStNbU5VWC9SRGkwcExx?=
 =?utf-8?B?Wmx4cUtXY0VpN2RDNld2aWw3RnJvaWVjaXhIelo5akNtdzljNTNPNmJ1aGsy?=
 =?utf-8?B?OU9PZ3FiTnRwWHJidVNQbytEM0JvUXIxZFluZWFSeVE2MWgzdG9McjB3MWcw?=
 =?utf-8?B?bXQwYWRnNW1qOWx5VEh5RWUrUm9hNzQzL0NGcUpIRWZ3RVlSKzY3T3NNVG0w?=
 =?utf-8?B?NTBCbmtxcVlzeGx4ZFlUeTZZRmExNUF5NmlIekVmUHFtcVU5QVNmOTJUdy9u?=
 =?utf-8?B?blJoamVncEZMRGVqNVdVdUxkU0V5bitTbGl3VUdkVG5KQUJmdVlhdzFYU243?=
 =?utf-8?B?SHN0U0hDeFdQcHY4R3lyVExUMjZ3VUFwTjByckJ1Slh2RkIwMTRvYVByZlp5?=
 =?utf-8?B?NTJ3VU4rclQxb3lJMGN0SWo3ZmxtOWRiUVZuTHFROVQzNC9tc1MvaUN6bmZv?=
 =?utf-8?B?bFFmSWFsZ0ZzQW1DUDZVbW5uTVE0Vy9IZW9xaGRmeUZjTFNBYW5KY3JhQzgy?=
 =?utf-8?B?N0FxQUhjQWtMWld5S3JDbkY1YTZBRWg4Z2tyUVY4K3plVVJHd25mYnlPVmk2?=
 =?utf-8?B?bGdzM2dNQ29YbnlycVplQnE5M3hWeTZHYUdqUzNpYkNSRzNZS3VUUUJDbjBC?=
 =?utf-8?B?Q01Nd3o2bGtGMXY4U3pMN3M1UEZNMHlGSVFBR0tHcDFQM3lqOElqRWVJRXY3?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef87e6c-be1c-490f-25a6-08de131f6697
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:04:32.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6xIBA/9yqFO0U+/+NC4N+f7ouUGAmSKHb2YPPYrCU9Z0IvPRB80osIt0LTIuSIiXQNPJnuC2x32Fny9VT22NBl5q2q/KKzplKPrx1fzWpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7607
X-OriginatorOrg: intel.com



On 10/24/2025 4:26 AM, Greg Kroah-Hartman wrote:
> On Fri, Oct 24, 2025 at 12:53:44PM +0200, Steffen Jaeckel wrote:
>> Hi Greg,
>>
>> On 2025-10-01 09:43, Greg Kroah-Hartman wrote:
>>> From: Greg Kroah-Hartman <gregkh@kernel.org>
>>>
>>> Description
>>> ===========
>>>
>>> In the Linux kernel, the following vulnerability has been resolved:
>>>
>>> e1000e: fix heap overflow in e1000_set_eeprom
>>>
>>> Fix a possible heap overflow in e1000_set_eeprom function by adding
>>> input validation for the requested length of the change in the EEPROM.
>>> In addition, change the variable type from int to size_t for better
>>> code practices and rearrange declarations to RCT.
>>>
>>> The Linux kernel CVE team has assigned CVE-2025-39898 to this issue.
>>>
>>>
>>> Affected and fixed versions
>>> ===========================
>>>
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.4.299 with commit ea832ec0583e2398ea0c5ed8d902c923e16f53c4
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.10.243 with commit ce8829d3d44b8622741bccca9f4408bc3da30b2b
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 5.15.192 with commit 99a8772611e2d7ec318be7f0f072037914a1f509
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.1.151 with commit b48adcacc34fbbc49046a7ee8a97839bef369c85
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.6.105 with commit 50a84d5c814039ad2abe2748aec3e89324a548a7
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.12.46 with commit b370f7b1f470a8d5485cc1e40e8ff663bb55d712
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.16.6 with commit 0aec3211283482cfcdd606d1345e1f9acbcabd31
>>> 	Issue introduced in 2.6.24 with commit bc7f75fa97884d41efbfde1397b621fefb2550b4 and fixed in 6.17 with commit 90fb7db49c6dbac961c6b8ebfd741141ffbc8545
>>>
>>> [...]
>>
>> we believe that this CVE is invalid since the sole caller is
>> `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the
>> necessary checks before invoking a driver specific implementation.
> 
> Great, will this commit then be reverted?  I'll go revoke this cve now,
> thanks for the review.

We'll prepare a revert for this.

Thanks,
Tony


