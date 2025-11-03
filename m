Return-Path: <linux-kernel+bounces-883760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C0C2E524
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC583AA301
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD212FABFF;
	Mon,  3 Nov 2025 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="au3kjbS0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263B2E6CD7;
	Mon,  3 Nov 2025 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210321; cv=fail; b=tVWLcWlHepIywnzFxmoyFXt4+xrp4bhgYvVObg2R+qBnGmo2ZqOlvc1MQ4FuR2qvAmHdrhVaAP9SVR14SK0pAMOtmZiTWp9YTsSrrT3NotwqH+TkrqxMDYWxqvymqEeqBi2efmOIBpIJd2003izApRCGW6VPuFHqu7ClNVX7KZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210321; c=relaxed/simple;
	bh=O/Ao67+ZVUTX9Cko8f84b1ZGdIeR3/NRUlzyHTfrBbY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYKdctJjmAXAnuJLVNn7vqjDva/cvh1tdVP2TaGac4DvIv3ETU4SMaGO7/chYrSyaKjqHO1asw8L2iIpXqMrmN7vgmgorhYnV9+E2IPmNoHgD6WAp0N/ecbZP0t3Gm4aNGUv6UWL7ElW7GghvlvRv2QUfjLeZLEnUsSeHpElZU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=au3kjbS0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762210320; x=1793746320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=O/Ao67+ZVUTX9Cko8f84b1ZGdIeR3/NRUlzyHTfrBbY=;
  b=au3kjbS0AriSZPrrydaJGvZXDDTEFzBsPtmJNsFUR61IBhqbUCxst5Di
   OD7LsmNjtZHmdfPP+5WGil1X+cDHfJlViXBMyYe5eM+0aX+kqsaSYTohi
   c1pdsK9o0OGEoZ1f0ZG8qbFZZ0t6jOrjT2MDS/STrgndMWAUTYMDQRwxC
   TAwaPQjo1MzLBWWz/caEhi/Tu7lkO1rJdD3RnpEkeQ3H1FFoF+fS9wyT+
   46ZARAsHYHFn3QOMnF3cNZT8L2bJzrA7Y3AmCdPgItvnN1C6zUyxtYNEO
   TYIIoAEqauT12D3WnUM+RGG0/V0Ul2GiIxEkUSrBMtjVEG4asbzgPhbkn
   w==;
X-CSE-ConnectionGUID: UKm/v/BeSEe/3AA4x8HOmA==
X-CSE-MsgGUID: /MpkNFIJRJWeZBhNJYp5UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89758799"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="89758799"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:51:59 -0800
X-CSE-ConnectionGUID: Rn58Z/bnQLKbEMsFVURLEQ==
X-CSE-MsgGUID: 2vUFVoJARrO7/+dMOhvclA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="asc'?scan'208";a="224238941"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:51:59 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 14:51:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 14:51:58 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 14:51:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnuJaro8bDw72S7uG+rMFrVIIxze887BPrtbzAe8M35rbHecqio4Lvcv2YHSY7PQzExg+0eypGZxyLR++/jRmhIzG/Kqkouuqtz5YpUbULxiWhSmhil/rnwVPovKN/DWk+yyaxjE/Qp60c2gIje5i1NGGe+CjIw1/IFSCJWsouazpBLvxn4LwHhwh96M/P7ceE6UUPNC8K+AmibZb1jbnqnOy5xvoTgXxtJMgX54j+wQ3hVIWuYM8TUihgySOkPLgHCtQXZL/v7VPMG/6W/kj7umQkjfYdSq9NzK1NcPSGU5PaOCWdnmFOADYk4Kcx4s6qHP2zCoMtzdhhhg4XgThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WoItB1WRdl28dvy0xKMdQCWGmn1clSBHOJx69ypm5M=;
 b=IuRtb7/gh4ddC8lJxYKsFoG0AjcmVQ2A8WHRYeXQ8tGkAi+4iqRMy7/OOpkaP+jD2BpsRnTt0LG3qfB6ro04b1NjColzT+DyyVDj2kRGu5Hl1vyVJvB1WxZnpNIdn0HLrYeL+xg08ko+Ogy1ndDzVarL0nCEhmLII9nE1WK89f5ApEkr+faxx62kSTA1dTsQjquy8CVaZ6nLPdf78h6tjJAFYVcjnD/cHrzSQaus0W4Sai6IWx+OpKXxqD+0IqaVWhxRn6o/WRVIyNoAu8LKCjzBRq9uRX8yahV6N9Kd5BKJMY0dkd1s2CaXtHX5Jf1Djkp04hrLfPxzXGlkRJO3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 22:51:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 22:51:56 +0000
Message-ID: <39096776-9b98-4e09-a008-d8d9620433dd@intel.com>
Date: Mon, 3 Nov 2025 14:51:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: pldmfw: Demote library overview section
To: Randy Dunlap <rdunlap@infradead.org>, Bagas Sanjaya
	<bagasdotme@gmail.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Documentation
	<linux-doc@vger.kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
References: <20251103030228.23851-1-bagasdotme@gmail.com>
 <33ce66c4-d128-41d5-9e26-aabb7e80aa67@infradead.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <33ce66c4-d128-41d5-9e26-aabb7e80aa67@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------2o6I4THBubJ0s1zEC6v130gd"
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ace4b4-2438-4de4-e162-08de1b2b967a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2hGRkNZZUNmT0o5eXdLVit1SkkxaS9XTFMzUGVEd1dmT1JiaGovRmR2Qlpz?=
 =?utf-8?B?WHpNR0kyb0NYTDZhaFg3NllGeUIyZHlMNE9PbGFPLzhUcWFSdFdkM1JoUTFB?=
 =?utf-8?B?R0xDbzJ6aGp3SDRaQWpEdzdrRVpPTEp4RmtkNllMaEdFa3owYmNhKzFia3ZF?=
 =?utf-8?B?bUFOUSs5UUR0cmo4b0VIUlhQWlFBV29mL1hRYlg2eTkrMk9sVGZXY2hWNHZx?=
 =?utf-8?B?TUROakdZZ3h1RGRBSUZKSFpNNWVpdVBiTUIxaW1PYnVjQzE5YTFpR2tUWHJm?=
 =?utf-8?B?ZmlxV1dBSnVRN2M5V3hVUUxhUzBKUHg1cVBTdHZqSEo1ZHgvVEdXNDhmcUVn?=
 =?utf-8?B?NWxzbWxQb2piVmNmeWJ4S21mTGM1LzNvUUFVb2lrbkVNT0lXakdHWjMxeDRx?=
 =?utf-8?B?TFc1WElKS2wrQU1KS0QzMTk1bzZKaXM2MnRodDFEZ0c3UWg3WmpDa1hWbkJs?=
 =?utf-8?B?OC91Y3hpM09acUhtTDd5U2dDd2hSU0QzMDN1Yk50SFlreElUQ2RUaWJPTENK?=
 =?utf-8?B?R28yNVpma3VjblEzbndpN0M3S0piQ1ZINHQwR1h2QVNpUm9xOEN1TDB1cnhD?=
 =?utf-8?B?WnF3M3lYcEw4bGJ0ZW1KZVBFTEFqSHVvNHlCbVJvZFI1WFpmVXVTWTE0MkdC?=
 =?utf-8?B?c01ZU2p5ZkpybUlmelFHVDFuSVhMQnlUdUdScklhRGpzcGUyd21mL3RDK212?=
 =?utf-8?B?eFJsdFRnL0lReHlMTkN5VjlvZDlDTWdXL3c4bXJ3OURiUFVHOFI2QzgzWFY2?=
 =?utf-8?B?M2EwbDkrTjArU1RoOEppTEVPbFAyaFpuZG02UkN1ZVRRYkRBSmdmblkrbzBa?=
 =?utf-8?B?aXV1KzF0MDUzbHNXMTlQMXkvZnFYNnJBUUdYNGE5Mit3N0dyV0xRNkpNMko5?=
 =?utf-8?B?Y0dlK216L2wwZElWT01pYWpMU2Jzb1ZaaEpQbWN6ODFVekVvS0JqcHMybWhk?=
 =?utf-8?B?UTJCRHI0VjVvaXlQVGVMN1BJbEpxN0ZPUzBKd0xKZDRMTGU2YUZjSWpyYU5t?=
 =?utf-8?B?YWJlbDU4Q0k5M0ZWZDdLN1lNS3JRekUzaGZyT081bzdlOUVGcE1RUUVmYlVn?=
 =?utf-8?B?OHA5czRLcGpqZjhqbUdsUS9wSm51ZGtPeGJmUXV1NkNZRVRjS3hIRi9rUnhI?=
 =?utf-8?B?ZlF0VE40eStIQTJSMFY1RnpnTk01ZmdtbzhwSFhwSzB6T2x4bmFyWDdVcWh6?=
 =?utf-8?B?MHhHclhtM204VDV5OTJ0TWkxRUJ6dWpyWXFZL0RwNEdWOHBDY0hXVHhoYWI3?=
 =?utf-8?B?MnNLaXd5VXZKbTlRWDNzT29yY3NBL0FKRFdpNUxIVEg1aTRtOVNZTnFwVFZB?=
 =?utf-8?B?dk90b0FqenpGc2dxWEpHeW82ZGk4OG1GMTVybTgxYW9waDZuc2pKeEdxYTNT?=
 =?utf-8?B?VFpNOURuZ1drbUZKblZVSDZGQTFhYUJJaXN6eVdMWFRFdGVHeElUYkFvNXhk?=
 =?utf-8?B?eGRtelZLVHZlR21DaWNxb2JMWjdyTUt2N0xPM3daK0RoNE5hR3lvYmd1K3pD?=
 =?utf-8?B?RVFxQ2hsZXlab2VQZGxzWnFUeE51c3pwVW14SUtCUGdiZk5WMk95RzAvWlg3?=
 =?utf-8?B?VXdjNTg5ZUpGU0tNREhaRVNCWjhXb0RocFRscUQ2b1Zyb3Q2RWxxbTRKM3F6?=
 =?utf-8?B?RlR2eWgwQzdUOVNsVE56UEoxMkwyemhEUTduOFFsT2JueFhNaUVuVHJhUk1M?=
 =?utf-8?B?bS9SSWNieHlTVll0bEtQdjB4VVoyZ2pobEZDQllSN0VLR0xFdDV0ZW1LaUZW?=
 =?utf-8?B?cG5Oa0NLaTJiTXNhdTd0Nko0VjdYNDZrZTVQTWNRQjZ1QWdjbkF5NGpRVEZv?=
 =?utf-8?B?dFVSTHBycmJ4VWRyc1ZQbGtaaDVvNkNGZEJhZ3ZvOXRlR3k2Z3FpTW43V3RH?=
 =?utf-8?B?YnUzSE10SHJjbFdWeXJrb1NKNEM0b2hpYTNSb2pObDlWMVFBRnFFaldlMnlT?=
 =?utf-8?Q?0ylyoCc7+r0zZ9LnBPf1myDEjaId703u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2YxTWErWDBQOUtxbHQ3T3lxaG45T0htRTRldmp2OXM2MjRVQUtMcmx6b21B?=
 =?utf-8?B?YXRKN2NqWWphbWpjWTlJeDdLa1hLK1J4dDduWTY5b2RZRHNlS1ZENjNxMmtJ?=
 =?utf-8?B?RHIvbzNRWURNb3I1c0plNGZUSzVRd1JJcVVkbDdxd2s5L1Z3YkN6U1dlTURZ?=
 =?utf-8?B?SlNOVFFmZU5jVGZndS8wSy9HZEhaRzVOMFpOVnJxSERQVEFaMmgybE9xSEU1?=
 =?utf-8?B?TGVrZGRRNkhKaS91ZVYzSVBwcERaS3BRL2RUUU5FVi9SaXB0WEJlSE5hVHJF?=
 =?utf-8?B?WTFnMldTZFJqMkE2dGgzVXJTdy9WNWMvK2xJd2laTGhmNWVUNWpSMk5XQUk0?=
 =?utf-8?B?NVVPNGZTQzVhVHRESndHL0dOR21lWmJFZ08xaCtGMzRyRWJvR0l5SVNMOHlx?=
 =?utf-8?B?YThBbXVxT09ERGRHOWNDTDJYQ0VTY0xwbkx5Wm1RT1dRd0pCNmFqU25YUk9L?=
 =?utf-8?B?aGhCeEpxeHI0QmJ3NElXUUwwLytrYkpJV1ZSQ0FiLy9za2xPODZMcVBqY1Fs?=
 =?utf-8?B?U3B5Uzh4YlpITS9nMlBLRmxvbitBZ1NjaDFReUVpdEg0YS9kY2F3M0JiU2la?=
 =?utf-8?B?WVhlREJONzVyaWpjUjh3TExjWUw1YXFNNDBBT0JKdmp3ZURoUm9HU2RIc3FG?=
 =?utf-8?B?MC9MSlRocG5iZWJQV0xZZDY1Y3B5Ry9tWTNhUVEva3A4MFRNL2xLVGRoa09P?=
 =?utf-8?B?c0gzdzJDc2xaNmhXK1NHa0pCcUo2SExaMG9IcXVWVUplVjc2U0NMSmJEU25r?=
 =?utf-8?B?SUV5d3U2cyt1SldpcDBCMTQ1MFRTRWVuZ0M1NFhQMW9VWjltSGNDVFgrc0JB?=
 =?utf-8?B?K1kyNmt6RGU0UThVM1F3MjBobEw3U0Vhd1VUUzVQdkh3dVl6M2VmeXpXV04r?=
 =?utf-8?B?Ulp2WmR1OFdYQno1LzlKdExiS1NSUktOSnJWcWVKbU1VZGFLOFZGdFNXNFE0?=
 =?utf-8?B?c0V6ZXNsY0FrRVZOMVZvbTV1RHpCeDJmZkRzWEp4RGJmdUpEODdyWXdBdTZN?=
 =?utf-8?B?MVZLQUFjNW9JRWJKdjA3ZENsazZNckNzQW9hekVtbWF4bXFiaDNWNXJWMWo1?=
 =?utf-8?B?WUJWK1N6L2xoajJBWGNIMTFSYkIwWjdpTitMRHhwVzJUT1NXZW5JQ251WUtC?=
 =?utf-8?B?SnR4OUVBaGFleDIxanFBSnNIakRlam1tbVdObjFmZjh6U242WE1GZm5CZ0Js?=
 =?utf-8?B?c0owMnlmNHhFdmh6TUpSTmRIaVltYXJVOEZCcWc4Qno2QzN5SjZYdTUyWEJq?=
 =?utf-8?B?eEFsMHltOUE4elRHS29hRkdGSVlpaHpyOVk1K01TekRuWW1USEJnKytDN0ov?=
 =?utf-8?B?djh4QytDQUZZdXg5OVlIOTFOWE93SnFDM0tvaWF2VWNmRVlqekpDeXBhdGll?=
 =?utf-8?B?Tlp3TXV4ekU0d1BLblAyaGtTVGVjTUhkRDVqL0VjcDd6SnhHZjB1ZURPV3Bx?=
 =?utf-8?B?cHN3Mkp5cDNWdnlYRHpoM0dlSWFOQkp1eHVnSFcyRmxXR2grMm5xeTlja2xh?=
 =?utf-8?B?L3cwUWhtaXNUTXVPeE9KdmN1VWxITEFDVldyWVNzUjB4MWNraTNsakZYSEIx?=
 =?utf-8?B?eU5JbUdZMXNaYm9KN2QxblplQ2dDUXBUNW4ya2tHY09qUG44U1JKb1IySHVY?=
 =?utf-8?B?Rzltc1dsaStaTjhmc2ZGQmpYOVAybmV3bVFwc3hxUy9VYy9pU1pCdW5OdmJJ?=
 =?utf-8?B?MmZJZXlKTkhiYXM0cXZQOWFoMWs1WWhnYUUzRmY3d3oybzN5SnphakRWTDdH?=
 =?utf-8?B?T201aTNidGlOR2VYSCtnZEUyZTVnam9UVEs0RlVMNFhQTFI5SjVXeHE4VDIz?=
 =?utf-8?B?OVZ1cXA4T2RGZVRESmhrbEFWNDFqa2VTSXJmaFNvbERZUURIZG8ydGRFeEt6?=
 =?utf-8?B?cHkvalRtYm5IM2cxN0xEaTNsb0lhY0VKR2tPN3lTcGZyaU44WFFTcTd5RHl3?=
 =?utf-8?B?TWJWVDlpVnZwSGZYRkloRWo3S1graTBKYmNpWnJXS0hKemlGYUw1eEp0T0Jr?=
 =?utf-8?B?T2M5RzMzZldybmZHT3M2VmZQb3lsV2kvVnUrYTZuTDNkY0xrSHpNYkpnWDNw?=
 =?utf-8?B?OFJ1ZlpxWnZ3endzNVQ3dFZOdWNsaGM4eC9yTlkvVEN0eWRTNWZLTTZWY2wr?=
 =?utf-8?B?cThWWTVQbVMyWTJWTjNVY1BncGxnamRCK0dGZ3VGZTBWVUs5OVBzeHc5UWti?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ace4b4-2438-4de4-e162-08de1b2b967a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:51:56.1788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjVlsK8CN037mQA6oT4qKDN1rFTuxh9M+plrSsZclPnDz+QY5c9diITF17YSubQe1WrHetlBzaEPndhdwdN77ycEFYYYaXBJOKPJHKAFTJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com

--------------2o6I4THBubJ0s1zEC6v130gd
Content-Type: multipart/mixed; boundary="------------OkxWxlj6yIcRzXUVRU0fEtj8";
 protected-headers="v1"
Message-ID: <39096776-9b98-4e09-a008-d8d9620433dd@intel.com>
Date: Mon, 3 Nov 2025 14:51:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: pldmfw: Demote library overview section
To: Randy Dunlap <rdunlap@infradead.org>, Bagas Sanjaya
 <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
References: <20251103030228.23851-1-bagasdotme@gmail.com>
 <33ce66c4-d128-41d5-9e26-aabb7e80aa67@infradead.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <33ce66c4-d128-41d5-9e26-aabb7e80aa67@infradead.org>

--------------OkxWxlj6yIcRzXUVRU0fEtj8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/2/2025 9:09 PM, Randy Dunlap wrote:
>=20
>=20
> On 11/2/25 7:02 PM, Bagas Sanjaya wrote:
>> pldmfw library overview section is formatted as title heading (the
>> second title of index.rst), making it listed in driver-api toctree.
>>
>> Demote the section.
>>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> Thanks.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

libpldm doesn't have its own tree at present, and most updates typically
have gone through netdev. However, I think this makes the most sense to
be taken through docs tree, since it doesn't impact any code.

Thanks,
Jake

>=20
>> ---
>>  Documentation/driver-api/pldmfw/index.rst | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/driver-api/pldmfw/index.rst b/Documentation=
/driver-api/pldmfw/index.rst
>> index fd871b83f34f3a..e59beca374c1fa 100644
>> --- a/Documentation/driver-api/pldmfw/index.rst
>> +++ b/Documentation/driver-api/pldmfw/index.rst
>> @@ -14,7 +14,6 @@ the PLDM for Firmware Update standard
>>     file-format
>>     driver-ops
>> =20
>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  Overview of the ``pldmfw`` library
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
>>
>> base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980
>=20


--------------OkxWxlj6yIcRzXUVRU0fEtj8--

--------------2o6I4THBubJ0s1zEC6v130gd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQkyCQUDAAAAAAAKCRBqll0+bw8o6Ahl
AQCpD4zVwRAB7OWpm5AOLEBsOqcv2XCEfnZVNbfS+7GGAAD+I/3aCUkulCkM7rQbR3s60kHDNCzA
pz1yjWxaBGuX/g8=
=96yT
-----END PGP SIGNATURE-----

--------------2o6I4THBubJ0s1zEC6v130gd--

