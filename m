Return-Path: <linux-kernel+bounces-790784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B65DB3ACEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D96D1C85A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72E2BEFF7;
	Thu, 28 Aug 2025 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7GBqftV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AB1DC9B1;
	Thu, 28 Aug 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417568; cv=fail; b=fgiXacXWkb+3n0Y41r01D0zl4SizgT1CAvaa+nDpSuKwAJIa5y4QXE2tuwCQCPD5DHxbeiY6jGNszO2F0UAomBZvYIBA8kVpUq4RfkQ6mXkGsHCSgndAkW4oDEJwe4arydyY2i4rlp6TTJxbgw0n0A89dUz2WaJAYBxBZJcrQW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417568; c=relaxed/simple;
	bh=HZoAb0mpPHr+d+IIWYAw0m9DdTj4dr92ykb2DEYgb7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IUaSGZjT5ekMhM5Six/mjpUpAMKZWjJW3Ne3wm9NIM6PwUinmto+J+HQ515rcOcz2QVzBCdvalte5onmgKABF2AJuTCiInulMPR2IEPbwnC9d2pj4HIEckbtybkyRQ/co33QEn00QR6yvvJqa94EVtGmeQ9Xw4S93sZ52LlPSno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7GBqftV; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756417566; x=1787953566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HZoAb0mpPHr+d+IIWYAw0m9DdTj4dr92ykb2DEYgb7c=;
  b=Z7GBqftVev6ZMddCV9LkdjbJKiXr6lLjtGV0bAc5vPzm7D3dNmk0bWmN
   JCafcC/1EuUnBXr1wQeumespShuCUcCGXk+bmlgNBnUKCUJqgGumajyUl
   Roaq6nN6mvzQ2g9LmVmfauYRn2avmVMud3r/WIiXIl2pLXCtuyT/lOHXT
   davznyzM5X1/J+15rf/Ju8z0/U+odjGppnUA+Nd3pvxL4FNBAAC6M+A5Q
   d4RO+nQusYK79jTuJiqSmsVA4871DBiWoK+0uNR8j+07VoWlJC286GmfW
   O6Dv6l6h4wt4/gXr7MiS+h8pmNSzvBU7bXJSrGwLtqN7WynjzK6HxWxKr
   w==;
X-CSE-ConnectionGUID: bm6rPx3aS+mGBK0FUYJjuA==
X-CSE-MsgGUID: 8JlLSBJbSyKVOVfRGy1t6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58847492"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58847492"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:46:02 -0700
X-CSE-ConnectionGUID: A/UwWrYGRhK387Q+sWwusw==
X-CSE-MsgGUID: MqZ9BLt+SOqYMgO6D8IFbw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:46:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:46:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 14:46:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.53)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 14:46:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSeezJ0RAlxCiXB/LmKjHPA85VUuh6fes1YcexZyJxyu4vAgGMy/WFdtyPs/jZbJt2D2HagE0PG/UvCznqKPftBBIwgv00DXOheIbzXxSyQa3QekWHM3V1eRDmPaldKU93chHLrW0e0mWZUYwSRzDbwGiIM/Hzz9KiaUgpw6UPBNCy7OJx040a1JvRMbLrubCNtxnZcU3wqAptCSuemE5iu4i9lujHgZv8EiWYf5VzVZZ2dpj0HnoRE65kW+VNS/8kt8E4AgqMwQs5qHhWdDuwgP6pomTkr7cOY4jLkegFCpTpgzqWdydYt5g6lL1NVQqPLE3/fkM24rVJzxJ5W7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agGelzn3oQj9lwiJDYKrBJS6MububdCMTN3EoWqB9vo=;
 b=y4iqJZZi4j/ra33kj8sb8vkkQeNkNF4QQvppTGBz2RbUU9I91x2QEDNo23eOLWqjE+FCGDxM8mYabEUzcoLe/eZeY2sxVx/uXLy721RIBlb+XUJE/cpBDWwXf1oZgpUKEitYXRHeQPPS0L6MSVfx1yAuXb+0PWdh7r4je4zoTokOQ5GcOSHBwHcHjGfacShArz48KVH1DTOob301nQHSdlWxO9iWq/nBhyyXzk+HE1IAdOSP4vyje0EhAkS0OW9xDt70GFWw7EdQrG7FMOv2RUpKtKwT6e9IrWRHRTI6IYrX+2I7H8id5Sxss9+qftVd3fiJ7X1H/MfzGz8CXqwAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 21:45:59 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 21:45:59 +0000
Message-ID: <c53dedd1-5c58-4325-8da8-552f109b67c5@intel.com>
Date: Thu, 28 Aug 2025 14:45:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: (coretemp) Replace x86_model checks with VFM
 ones
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <linux-hwmon@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
	Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250828201729.1145420-1-sohil.mehta@intel.com>
 <9f1fbf32-fd37-420c-82bc-a43e6d5ef57a@roeck-us.net>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9f1fbf32-fd37-420c-82bc-a43e6d5ef57a@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|PH8PR11MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0208f5b4-7dcd-46c1-a02c-08dde67c469c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzcrTXJJdURaT1c3WjRuVCtIOXRtWHNMSmsrTVBHckNuNVZybExCc3h4TitX?=
 =?utf-8?B?WWs5MkQ1bDNzRjVoSVJLM3V6NVV2cFR6a2lYaFdYMy9YR3puNEFHUlJabENC?=
 =?utf-8?B?bUxqVndOb2ZGTkJ6QWVIZ2x0YkVHdnpwc1hIWWpPS21XbUJ4KysvV1RzdGMx?=
 =?utf-8?B?Uy9Qc2s3aTE3YXk3K2thUG9FRnZLVUVJcTRSWnRNS1lLcU9HZGoydTh1blJO?=
 =?utf-8?B?Zmw5cWJmVmN5T0ZRODlRK051T1Y1ZURvOE4xZ2ZFeUZIY2xhZDJGMGc3WnhS?=
 =?utf-8?B?eENySGZHTld2RFArV21rYmVlMUx6MHdhVDlEQ0xBV2Q5T1hNYmhJejFZZWdz?=
 =?utf-8?B?Q043M3lEV3czRHk0S25nVk8zZHVEeDVlMS80QndhMUx0ZU1oSWtDMTd4OVBp?=
 =?utf-8?B?TWI2aUM1dDRNb0JZS1R4VE9obzFDK3JVWG00ZklvMGVvQnRKQnpsQTNKN2Zi?=
 =?utf-8?B?Sm9nQ1JKU0dyY1Bhd2E0eTdCaFhiZW1NWThKUVFDSDQ2QzZURTVla1ZZY0Y4?=
 =?utf-8?B?WW1UQjJZYVdEUDF0TWpqU3pGSFlPWmM3b3NuMEdDUk5tbXBLNmp1YzFJbDZj?=
 =?utf-8?B?NUhjVURPTFMva2xSV0ExRkNxMGZpVGU0a3NUWnNFUFdVNHI2UGlDYzFoemZt?=
 =?utf-8?B?RWl3QUZBVjE2L3BORzVSQ1puUzBHSEtMdWVoenNJcVNZaU9XYVhJNnp5cEpW?=
 =?utf-8?B?MkZxYjBaQWhubG9wbXlGRnV6TWJ6OFJrWmJrc2oyTUVrTlVSK0x6dVRCUngw?=
 =?utf-8?B?NDA3TGZEbEMvVkdPUjFIS0ZEMVUyQUtwN2hLWjlYd3JNMmtxdlBLM1JYS29O?=
 =?utf-8?B?QzczaTRjQm5TVDQzTnBmMWtmOS9rTVB3cFlJMThPbVlDR3NORVBwMTZPWkFC?=
 =?utf-8?B?VUVta0FlVnRVMEpNN2lVbWs4cjcyNEJKWmtnRG1EOW5PcGNPN1dlMG1aNTA0?=
 =?utf-8?B?ZHFKcWVjUnBqRTdaVEhrWWJxL3pWRVBMYWZ5SWl0bUJ2UnFKMkVXYUdJaDB5?=
 =?utf-8?B?U01ORTF1VElhZ0hBbG5QenFEYWZ4SWdlOFpVMkJaRU1JbnlnNFRCV3ZqdFk2?=
 =?utf-8?B?cllkU3BRRnV0VW56OFJMVzVhd1JnNVFWQUhsR0FwODF6N2h5UWg5LzhWdE9t?=
 =?utf-8?B?bStkc3k1Qjd4cGhoWVp6NnVxcUducm9aU1c4cjU0cktLNkRwQmE0emUydDVW?=
 =?utf-8?B?ZGJoa3FYd3JQZEQ3K2Z5dS91Wk9XSFNMbXhnWnJKamhRdkkycTZNVmRxTnNx?=
 =?utf-8?B?U1dFYVpJL1JOV1RYaHR5Zit1NmdEVzNFV1htYzNNYVVhem03a2FESmh5dlBJ?=
 =?utf-8?B?K3d1dW4vODBjMDFzOGhBZitLekFlNHg4R2dMMnZYdjlseHRjejZJaXF1cHBp?=
 =?utf-8?B?ekJ3R0dlQU1FQUErMWpnZHFIRFl6aHJURUhxYk16MldsSUowSkcwQmtwY21t?=
 =?utf-8?B?QVNNUjlMWDVMU1pEU1ptUUI4aHVMWjk1dmErU29EWnVDMEFJeUo2NUZ1aDN0?=
 =?utf-8?B?Qm40aU5wL2svckpZWitnSzVjMVF4TDIvZFVaTDlRd1RobmxTNmlRR1BJYmRz?=
 =?utf-8?B?c0k2R1lIYnZGd0hSSklnTUtSK1E0RTM3azhZclhtc2FyOW85YmFnUEhiNnJi?=
 =?utf-8?B?VEdhdGVOdE9EWnptR3V5Ym42VWpxWEtocVIyUXdkS3NZMEVGMGpQcWFGQmhw?=
 =?utf-8?B?aFdTQ1ZrMkRENXQvREkzVWNDTXNraWRIRU5nZ0N3cnBybFdiYVluUUVVSGRV?=
 =?utf-8?B?ajRzY1hhbFZ4UUhuVnRnQnpXc2RFYU1hMXNmOEpYK1FXVERiZkJHY3dlRVdM?=
 =?utf-8?B?ZXg1cm5XVTIxS0hhdENBeUFEanlJb2NVSzZ3NmdZRnNKOFpjaUFrUjFtQWFS?=
 =?utf-8?B?Y21YM0NLRFQ5V1pkMHRoTTZGQ2lzUU9PRmlLVU1iTURXWWlZVWtJd3h1VnVV?=
 =?utf-8?Q?5UqXGGJC3PU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpxWkxEdWkrZnNHZFJ6YWdiRmZOeHUvOXh4djZURFVHTjVWeGdSWjlmUTdM?=
 =?utf-8?B?UXNHdG5aRWRaRUNUd2VGeEFyNWFXdGV0bUt3RVR0M1IwVjM5K0RSc1E2SDd0?=
 =?utf-8?B?Y2YvN0tmWi9kYXBObGhRUy82T1UxeTkySmlWTllmdWlONEJXRkNKWndtQ1Fz?=
 =?utf-8?B?aDVzUUJSN1ZrLzhJbTFOWFN4aGpGeFdYZWsrcTRpcDNPam5rT1kvSCtMZmZr?=
 =?utf-8?B?SlFJS1AzVURTR0VzeGM3TGs3a1lmV2prQnViQTYwQ3BGQ2dmbFVFQzlXdzJR?=
 =?utf-8?B?am1DN2RhTCs4M2RBL0FsaVVnbUE4VEovOGFuQStBODVlakRsUEtXczl5eGdP?=
 =?utf-8?B?Uy9sL0ltQVE0SVh5UnNVbXE3TWd1cTRmWDJXSjBlMjg2MXlOVkZtU2c2TWxy?=
 =?utf-8?B?a1FBVDVxQVNya1VCWUZuZktXVjZ0dG5kSnJqK082YzBjYnF0cUtNdDY1NkFE?=
 =?utf-8?B?UkxHclZEMlI3Nzh0ZW9nMno1NlplMityUG1aK1BpMHR0TklrWTlvdHpnM2ZI?=
 =?utf-8?B?WXNsd2xIWGd1cG5aNDlPalUzUHlaZFkvQTdORTVhM28zSkNqeXlXYlVPbnBC?=
 =?utf-8?B?SnNDUHNUUnlnckhpZFFEbWpzaFhFR0lDaEl5UG9pTVQydy9LT3pUTjBSR3Ns?=
 =?utf-8?B?bWxCOTkzSWo3YWlVZWo3UnBJdEJTaTJCaUZuMW13aWhkRklvTXdlN2hZaHBM?=
 =?utf-8?B?NUprZkhFMmswY2N4eE9wNWJDOFJVN205cGxoNzVXdDVvVjJhQ3U0b2VGbThD?=
 =?utf-8?B?VWZZbC82bDRHcmphTnpHOWM3MkFKL21Qa0xWVFl6L1JKK0tiMGVaUmRSUXpl?=
 =?utf-8?B?YmNmeDJqUVRkRFFaWERWNVBXZUQvWFhhdjZIK255bVF0dnBrdzBDRGlwMlRK?=
 =?utf-8?B?RlBhbWhYQ0tLVngyeEFCdG9ZSnE3em8ya0RLVDc3dGRlMnZFbTdBSnJmTmFy?=
 =?utf-8?B?cjFwdmdGRUJvS0lXdjVVYWYxc3JRZEZqNnJMUnV6WFdEYklrcWxRKzlDaXZE?=
 =?utf-8?B?STE4U0xxNHo2UlFxNkd5VGlPUlp1SnlvNEN2T3d2QTR6UkEvdFJ0QldMSWxn?=
 =?utf-8?B?TER6eVdjdnZTbFdkNWoyd0VxYnhEcGx1VjlUZEozY0dMU3pmV2RMWHpKT2pU?=
 =?utf-8?B?WFloOTAzOU0zMnhjSDVXd0x1dFdQNnNZMmVEOVFEYVB3M1lEa3FKOC9VakdV?=
 =?utf-8?B?eEZuM3Q1WmVOSTBIWXdmeHRPbnFhZDVaUXJwM0VNMkRvT2F2MjVDYzJGcGNo?=
 =?utf-8?B?VExoQnh3V29ia0JEWnNtK1R0VnRiV0ZvRGJoRVYwbTJIdUlMS0haTFpFaS9R?=
 =?utf-8?B?UitLa25wN0F6QkEzMDRhTTVCaDArdjl4dnNaVGpsazZYeFFxYm9lZXRiRUJ2?=
 =?utf-8?B?MzdydUdJMlZVS2NYciticHVZajVhellPN05ZTEV6Q3ZFc2Riem56RjQyUzhG?=
 =?utf-8?B?Z2x5TytwNmxxdjBDOG8wbXIydWRJSWdzci9mZUFKT05henA0OE1KUDgyaFR2?=
 =?utf-8?B?cFM0a3pDSXBHMGpHclBrMFZ1QXJzV0xLRHl0ZDhoL0k2VndMUm5JRDZuK2N2?=
 =?utf-8?B?RjdYNjBHTnhROTJRUnJnTnp5SUtVdXh6ZWhDUS84a2lCNitZRCtqOFI1MDhJ?=
 =?utf-8?B?OEE0V21uWFdNbEFTSnc4cUw4Lzl0MmJvZUZycmUxTEtkWTRmcXZiZTNGWHFL?=
 =?utf-8?B?Q0lhcWcyamMrMjhHS2pGSUMvUHEvS3lPeEhicmtJZmt3Wm81UFlob1BhTnRT?=
 =?utf-8?B?VFZWckdBeXVHcUF1VWE1SWVVSHVoYUsxNnhEaXU4VUNFYStmc1VuUXhNNVRF?=
 =?utf-8?B?bHJxaUduQmlMNmxMMXpVdm5FNEpXQ3JVaXEvUUhtMmQ5LzRwREN5dHlMbkox?=
 =?utf-8?B?TndzU0NBa3NBdHNqWC9wQ00rQmszQi9ZZmdpd2kvOEVnRUNua0dDZVNnNVlP?=
 =?utf-8?B?TU5zeXR2Zk1WTkp4aGpFa2s3LzNoNnpxMVc3eVdMeUF3Mi9LR2tvdjFhL0J5?=
 =?utf-8?B?NStIa3RqUXdyWXNtNlBNOWhCVnBJYXpHVDVJSXdESFdKZ09yRDE1RVdKV1hL?=
 =?utf-8?B?TVRHeFd0TEJWS3A3czJmbXYrMGxaUzRORFZwYkxwK2diVC9QMlprK2VUMXJG?=
 =?utf-8?Q?JFv2sXFes6FuVwYWj/pGBGyfi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0208f5b4-7dcd-46c1-a02c-08dde67c469c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 21:45:59.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +njJ4fGzoRtLbeYRxxUic6lFm78rHIuG1FR9r2o4Fus19Pc8ZJzYiMhiQZpnN/KWQNrUT7dWs768f+QEqsvEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com

On 8/28/2025 2:42 PM, Guenter Roeck wrote:
>> Missing-signoff: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> 
> Checkpatch really doesn't like that:
> 
> ERROR: Missing Signed-off-by: line by nominal patch author 'Dave Hansen <dave.hansen@linux.intel.com>'
> 
> Never mind, applied anyway.
> 

Dave has provided his signoff on the patch now. Also, he suggested
including a Cc: stable.



