Return-Path: <linux-kernel+bounces-874472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F9C166A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823911B208F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1405934DCFC;
	Tue, 28 Oct 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGuStxxs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7B199FAC;
	Tue, 28 Oct 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675286; cv=fail; b=CncjmIHqs+a0n7YLnCXJfOlF2C9YU9xSmrkXJYMDmrWBf+H9mqDj8UzdbIp5BYQ5dxBUQohU4i8YM8DwKVyR5Se0p/5IU4JbY4rMtBNxfqYqOkKD51+3KkWUD4zUDr/lwW5wPRNBmbldw//IRqglZLuIfQxGBVR9AbL1JP0dfhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675286; c=relaxed/simple;
	bh=ivA2/gjXP36d3OHeTFjmb1VWxH+H0qvQwP9/YjFYbN0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QcKhJt4evCZzqO7eiGLAbwZ8vAmbjLPGbTXOMXxUfXieEgPMwx8Flw/DDjRZvhY49ck6nJ/xijOWvowIB+pEserwxcd7icNddQ2ppX37/um5iFUTiL7Rab9HoDV0JIkNNzfmN+2L7peMi1bgM+nLqlmjf3nXcRG7q6QLyMXLCpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGuStxxs; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761675281; x=1793211281;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ivA2/gjXP36d3OHeTFjmb1VWxH+H0qvQwP9/YjFYbN0=;
  b=GGuStxxsOvsV4xm2v/kOtDTUrsNuORXyJuumgbrX4YF9n57xAqZuw8Zr
   APNmwiw83asYh1+tDqNRyvhE3WKKyVNg2Co06aCHJ88ezhrmTMOFPfv6J
   QG3deizdkvv9QJpUNDReAEs45fw/jOu6drOCVAVbWaPhzMvs08sxc753C
   JZWs6HJodr9T/ebPgWQrmD5pz4FaMSold/a3NbM71xVdB72lIXNv+0epj
   V4Iebe4/i5dFzFib8SnEBdW6djChNVNH1L4nJFXu9FocWvO12iKfvByTL
   IHtwfJU+BfFaxBGn72i7aGhR6MwLUG/t5PUQFRtsdjtz+iR2+IrR9bmEP
   Q==;
X-CSE-ConnectionGUID: oMf4NruERbeD6XC8/4iLZA==
X-CSE-MsgGUID: QHbCSZGtS9+65BemMGDDBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81208166"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81208166"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 11:14:40 -0700
X-CSE-ConnectionGUID: 2Xc5GVwNSuSxneOiEIOJFg==
X-CSE-MsgGUID: AORgw1UuS4+4zzhFrMUWNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="222645818"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 11:14:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 11:14:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 11:14:39 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 11:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMtd+L9d+Y11Knv5+bokDgPYpW8Ss1zHqS1l7ZnqHGtGUp5ycijOr/xggb6DOByBTa6KEPQZbPvk0WqWDMnOeB0Ey5/CnU05X65HeOnVrZ/yRpOe4ehWgtvBYaXjPbZeHzMFQD7rUWIrnLfUuMuX6Vo57nciM4xqQsx/alJbHttnhT7kGnUa59tI/Tc0AIwvMp+QLJ/n39e2mC8xwQY/CVzQGq8mkvTCwHsDqFZU7UIDw/Q/2Znud1Dh70EiMNu+kqJ4pBtdFfqpM1c9FtnxAdekcmaLI2XgKoI8O2bj846n9Sxab3FhezGZAF4udeAULhn5ek/FyqJquIXA28hhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVeqf0v78kOpwlsQq8STT3yxt0Gu1I+Sv9h/qDTMPUA=;
 b=r4380sFuE/3eYfR1ZYi1xF9JGAHPK+z7MXk6AY252gOs8Uc78ywcdlfHqRPtG70xQT/Lohu1K26GxD37OTH0OlBwV9ppImT7yg71T9OXzb0DwNCfdPD6d52eBHg+UGTTEDcTyuvUXduloYaSDLSrgBXxDxDJhm049hcGa9WdyFxHIn9odncZyfP/HaVfXqKUBy5X1M2AERcn99zrjBQR+5Jd2pbKwDfydFOOB44nTu+Pp5d/l0PuVPy8cbTDhu1li7rOYi/qLlucQ2dJhsFMwRpWHEhqaAw8Mbq9wg4n8yMcR8vGDbSTDCtEWZMnS+JYDFDfWTLHGfpeLNauMFWgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SJ5PPF3F833FA49.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::823) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:14:36 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 18:14:34 +0000
Message-ID: <0ec765e1-1bbd-4a7d-baf6-0163b64fd9a3@intel.com>
Date: Tue, 28 Oct 2025 11:14:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
To: Andrew Lunn <andrew@lunn.ch>, Steffen Jaeckel <sjaeckel@suse.de>
CC: <cve@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cve-announce@vger.kernel.org>, Greg Kroah-Hartman <gregkh@kernel.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>, <dima.ruinskiy@intel.com>,
	Mikael Wessel <post@mikaelkw.online>, Mor Bar-Gabay
	<morx.bar.gabay@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>
References: <2025100116-CVE-2025-39898-d844@gregkh>
 <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
 <a42d374f-22e8-466f-a7a5-ef1d51ef6635@lunn.ch>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <a42d374f-22e8-466f-a7a5-ef1d51ef6635@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:303:8d::14) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SJ5PPF3F833FA49:EE_
X-MS-Office365-Filtering-Correlation-Id: caffec14-eb53-4008-6bdf-08de164dd8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2ZBczFGOTNMdjJnMUJ3ZlM2SDB1N0N4RGJPaXJuQ2l2bTArSk9IOGNtTGpy?=
 =?utf-8?B?Zm9xU2lweXFkNThoeTFNbFFKSDRMOWFha3JTMU8xdTBjY0Q5UHprRnpQenha?=
 =?utf-8?B?elFwMUc2QlVsVzRtdU5sZndoc2ZiRTkvcWFXU3E5cnpMaDE2aC9hQldUL0Fh?=
 =?utf-8?B?aHZXTmp2c1lJVUV2UDZ3UHBkOUZYbVhKdjhuam02Y3A5c0dwOVJsRnFxajlh?=
 =?utf-8?B?RWlrVEErK0RQaFpTOW9QZ3JaQ3IrMS9hMXF1alljaERCRkhvclo2SytFNXlN?=
 =?utf-8?B?UVZtRzl4MnFPVW1LSjY3S29pQktzQmF4ZXNIU1BGcHpCZmNZK2VqdWlFenVD?=
 =?utf-8?B?TVVmYlA3T0p3SkpkZUJuR0FBdzd2dTVoRkFkTExBOHJoVnl0dFNsTlFweXp3?=
 =?utf-8?B?L2E1ZS83QUp3Z3Y4OE0rNlNnRm91UzBqUUk4QWxJWTdicUI2UzZMVnZGendR?=
 =?utf-8?B?UmNCc1JST3FpN1J4NlBiR2xybkxPSlgyZklROUs0b1UzSzllM3VvS3VpdmVZ?=
 =?utf-8?B?cDlPb240R1ZvdzF0ZUxtdFhEeDRTM3dqMERGa2h4dGFLLzJUU0JUZlFGQ1VK?=
 =?utf-8?B?VWEvZW82ZGlnN0xkaDdrM0xzK2tJbDhDZytCQURwdXdsbXVFczdwcjFJZ0Fh?=
 =?utf-8?B?ZTFBbWFJd21JUzhpTTdNazJMSkxsWTZpRjI3MWNsZ1FieVNzWEhoTWVoeFBm?=
 =?utf-8?B?ZUtzS0tKTzNad1FEYkZ0Nkd1MGtLR2ZHVmJQaThFNXVsMHkxNG8wYWRoZlps?=
 =?utf-8?B?UlVpVlVvK1JkNEx3akJ4eTBkOFZmZmppb3NUbGJPbXdXSDR2Zys5QjYxRWlj?=
 =?utf-8?B?NFdKNnNWVFRpR1N3Mzh5TjdldUVMNzU0dU50VUVJcGg1NHVGUk5Ka0pZSWpj?=
 =?utf-8?B?RkpCZmJ6ckpSa1RrUS9ZQnNSc3dLbEFpR210dXg3cWxiYlNZaGFVeE12U0oy?=
 =?utf-8?B?NnNhQlhqY1Fkb3hZeHNsTlhhTG92YVJkM0VLNERGcjlDRmowTUU4SVN3WDli?=
 =?utf-8?B?NVJOazBITEN2ZDh6aDI5dDU0M0pKNmFMWFpDaW5JM3FvbzArZDdYVGFsdTNr?=
 =?utf-8?B?MWUzUnAwYkhpNzRKQ1hMMjVPeXFTOElDUnB5anNsdlFLQUtKZWlmQ2JkUDhn?=
 =?utf-8?B?YW9SK0RpQWdZWFBvdUZtZ0U4eGM5bHlNQjhQNnV3dHlaMUZwNjdKN3hMRktq?=
 =?utf-8?B?N0tVeExuRzUzeDYrWGdaZjcvcW1HQnhHLzJ3SkhwVEZ3K3hEaC93TGpQM0M1?=
 =?utf-8?B?QTEwK2MxdnRyZm94amhtaFV1MDZqRjJUcHc1eDRONnF5SnVlM0ZtS3FlVXZU?=
 =?utf-8?B?YjRnSCtJRjZoSnlRYjVzMFFwZ1E0dncrYVVXa0VUYUFOdHpiZytEazEzb0N5?=
 =?utf-8?B?Z1dFcDYxRkxUNnMzWWE0YlRUOVRoS0ljNmlKZkhNNkF0VTd4ck0xYjM5Q1ha?=
 =?utf-8?B?c21NR2FaUlZ5UlR0cE1oZi9PUjRqdXNWcGJidHRjMUdKVGdBRjJCaWFkTndD?=
 =?utf-8?B?ZElOMElneUlLRmcwbjdvaWlybWJ5S3JzR29pN2lxcDhBVDdweEN3aUUzbVlK?=
 =?utf-8?B?d0kyaDVpdlVuMHpJdWc2enBSMXZsTnJETHdIc090NzFhZUZOQ0QzNE1uQldk?=
 =?utf-8?B?NEpYdWF5OVAyN1JjZkpUSzA0c3Y3UjczNnpEdGYzRnFteElHWUVvejZoY1No?=
 =?utf-8?B?Sk94cFo5bDhRenpEWElJVzlxUkNnWjA1R2xDS1VIL0ordEg4YnMzbzU4T1RY?=
 =?utf-8?B?cUp2cTJ5cFcyZi9XenVvT2crU0R5UERvaGtQRUJYanhkUng2MURlRFhQREF3?=
 =?utf-8?B?cm9tUzhHc3JHV3daQnAwZDVGdmJHSEl6anZjUGlkbFlEZENUTUlkekVmN2Ns?=
 =?utf-8?B?SnZwcjBoRHc4b01vOXFXSHozMHhlK3hqdUxPZitzaC9wcElMcmJBUytlaVZE?=
 =?utf-8?Q?yMkPtd1cNChuHdDc4vuTxMwzacgM0wBX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy9PTlRFY1R2dzlDQ3FUNjFNL3FLbi8vcloyMDRVc0pJUWhGd0FnUkFpTUlx?=
 =?utf-8?B?VjhmT1cvRmJ3cWg5Y0RyVjBJNm0xY2JvV0k0eUtFOGZyOUwvUkY3Ry92eWNC?=
 =?utf-8?B?WU5RQWVWYzRLYlozUXZsS1JBdGVyOCtJai90U2xOelpUemEreFBuNFJ6MGJT?=
 =?utf-8?B?WStVdnc4ai9aTFdUV0VZNmFwTlNiSWhsTi9wTUROWXNsLzEyNXp6OFhMR1Aw?=
 =?utf-8?B?U2FqL1pnYnpkaUVpVnBnMmsyZCtjRDFlVEpMNEg5Njl5MlQ4ZHBhSWFPRU9N?=
 =?utf-8?B?MEpaQ2dUN3FaY2VvY3hwZVlSaFRXaGhCZFVTckcyVTVTSlVCemVRelIwUDhO?=
 =?utf-8?B?cjVZdHkwOExzeThWOExBVWV2RWZLMGE5a2E0QmdyQzNCKzBxN2lReWh2NFl0?=
 =?utf-8?B?UUZDanMwdU5GQWF3d3A2SE5EK0RCbS9tZ005RnRrNFNHaE1rYTZ2bGh4S2dF?=
 =?utf-8?B?dFBqVmxoN2NVZEZpUlZKYTRmSEwybDFJdm9Qc2Q1dW5UNHJYb2I5bld4Nnhl?=
 =?utf-8?B?a2U5M0dmRk5IY3lKOFZsYjBjM1dybUMvYXF4RStadXZTN1ZTM2pmRzd0WmRX?=
 =?utf-8?B?b0xuamxYZk0rUlJnYjdYNkM0a0hKanprc3VLd0NneEhLNGd3Q2U1QWk0TENo?=
 =?utf-8?B?UHhQMG1IaWZmR3hPa2NCc1VYWE1ZaDc4cXdtRmh6STlrUnhJUVd3MWdETkpa?=
 =?utf-8?B?UkpKc3Fqd040OVR0TzFYYUNoUG9uWGphejdDeDhGcjVrcW9sQ01LS2xCSnVy?=
 =?utf-8?B?VVI2TWduVlY1VkR6S3JIK3ZQenlXQXd4M3hSKzJFTTU1V0RBaTM5Z3dONGxk?=
 =?utf-8?B?NlphYVRYS2RDSHNWN1JNSGVtOVIyQ3AyTWsxRzVjZGRIcHBWOUtWdlZwT0tn?=
 =?utf-8?B?cFRqdElSWmJLdzFrU05BZ3d5Y1FkU1Ruc1A4WWcvWDBZRm5KTkwwQURIN0hE?=
 =?utf-8?B?eGxSR0kvRUpxbGxMVHZmQWFWY0ZNelJEYWFlTlN4bUZiRVJyM2VNZnBOeGZz?=
 =?utf-8?B?S1pxam0vTDd1a0JNYnBTUkplb1Qray80WTRyZDhRUzFCU3prTmFFMTZsOHZo?=
 =?utf-8?B?VHFtajZnL0IwVWs2OUs5ZEVLSEMxY2l5elF4cWpxMEFhK0V1YTBLdHdCUlFF?=
 =?utf-8?B?aEZhRGhkemRyamtmVG03WkQyQXJUUVhpR0g4MTF6WDE1RWpjeVZDekUzV3Q3?=
 =?utf-8?B?WUhhR0VpU282akNZSzVnMURJUkNQaWhULzdQcTJ0N2E0QWIxNGUxeHVrWWxN?=
 =?utf-8?B?bGhob2svcTVxOWtwVUZCSXRWQTNCOENtZVVHck5TTCs0VU1JY0tNUzVuMFdq?=
 =?utf-8?B?S2ZhMVhzWUoxZjhNaFkwdmNnVWwxTENWQkp6bEh2NFYyY2o0dDFSTEtwYlRZ?=
 =?utf-8?B?a1c2WUdPL05hWVpkRU5DZTlKUVRUaW1TeVpxNHMzYUNUMWhTSy9FSmpOUVBR?=
 =?utf-8?B?RndVTXhYMExpa1hLWnFJR3RKeHRrVjJlVFVTTEplWlFzMmlZaG02cSsvelBk?=
 =?utf-8?B?ZXlVMS9jY2ZPdkhLTHhTajlYMzdLUnNHMXRtWHB2ejM0MDlPK1RHUng2cmFk?=
 =?utf-8?B?TGRyZTR5T0xWa2hZek1vR1RMM0hlTmhpRVo0RTQ0QUN5MGpHVytwQitNbndH?=
 =?utf-8?B?bGRGY2tPdFZYZGFpWDhNa1hCQlNDMGdjQmM2bzFKaXkrbEh4bzZhSnlTdlhr?=
 =?utf-8?B?NFhTNHUvd0tqWFM1WlRpVGJkcm14V3dhVENjNlMzN3RxK2h4ZHUySWN6RkZh?=
 =?utf-8?B?Y2lHME1QL2kzVlNRWWpDSUcwaW1MYkZPd05la2REdkkyR1gxUVRIV3A5RDFi?=
 =?utf-8?B?VUlTSzBwVEdOYUdsMnY1V3N0b1dNL3lqUXQxU3IyUFhRV2RVaEFFTWR5czRP?=
 =?utf-8?B?NWNzUjcrc2ZOcm9JWXdDam1sMVFRWWpURVNEMis2SFF2d3JxWmhvUEhJVElz?=
 =?utf-8?B?OGx1ZHFOS0tvSTJXb25HSEl6NUYyTUZCbnBKdmhGT1RVUmdaUWFvOTFDdmI5?=
 =?utf-8?B?L014dUh6YjBBUGRxN3BiOGUwNDJWNmtHeW5DRzFJOThWQ1dXajJ2M202bitK?=
 =?utf-8?B?ZENtdkQvRTV3Smo3ZXFHNEg4RmNSaHlzblhyVjZFNVAwaGNsV01mK3BZMWJE?=
 =?utf-8?B?UVlKWUV0QjBjbC9qNUoyc3JwSEQ0NFN1a3Z6QUcvc1daMlJCVTRIdGlwQXFi?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caffec14-eb53-4008-6bdf-08de164dd8ee
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:14:34.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSdEzR/au/8/qWoRrFc0PNRWetBReZuhZwSwlVJjvAjFo0FXZk90SPUXq2Wq2CEDgtT/TI4ptkC8FbUJ6QNC7dFG11bk653nNf3TUFbTdRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3F833FA49
X-OriginatorOrg: intel.com



On 10/27/2025 2:46 PM, Andrew Lunn wrote:
>> we believe that this CVE is invalid since the sole caller is
>> `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the
>> necessary checks before invoking a driver specific implementation.
> 
> It is either invalid, or the fix is only fixing e1000, and very
> likely, the same issue exists in lots of other drivers, so the fix is
> wrong and should be done somewhere else...
> 
> This fix adds to the e1000e driver:
> 
> +       if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
> +           total_len > max_len)
> +               return -EFBIG;
> 
> In the core, ethtool_set_eeprom() we have:
> 
>         /* Check for wrap and zero */
>          if (eeprom.offset + eeprom.len <= eeprom.offset)
>                  return -EINVAL;
> 
>          /* Check for exceeding total eeprom len */
>          if (eeprom.offset + eeprom.len > ops->get_eeprom_len(dev))
>                  return -EINVAL;
> 
> Are they equivalent? Is the core broken?

The checks in ethtool_set_eeprom() look to be equivalent to what we were 
adding to e1000e so I think core checks are sufficient, and the e1000e 
ones, unneeded.

Thanks,
Tony

> 
> I will leave it to somebody who understands wraparound to decide.
> 
> 	Andrew


