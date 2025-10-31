Return-Path: <linux-kernel+bounces-880821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F1C26A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42E0E4EE9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D450429617D;
	Fri, 31 Oct 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcHm/VGB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA782222A0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936836; cv=fail; b=PqVCzQ0aMsf6a1M7F5OV3mb+yEXW54MYs9uNUlIckeYMa4J3O/1F4VZNo1N2q0piRmUDiWjDERHkg54ibQHqNVtHTznoLpUsX7IYTaIwoeI29FjZMcR4dtF36QtSSPbqpKR9GN/258VHSLNNcqFBigswHH4eJnISOakk2dEj2uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936836; c=relaxed/simple;
	bh=3eTvFVLEzAlq7eosHBPqPqN5/5Cc5YKq2sLI6lHtRjo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=SM8hEpC6/l3jwsdXse9WBHfhZ3rdDrLj8MtM0bqK6qg8cpM3Xd5izS4hS2dZKHsb5L9eIq7/+YoLA4nBWicy9IEnhio7zfnHeMpoXzv7PIiE0uZwYbKAVaSjKnQFIG6SnG5PuMIWNQ+fgU7VW+HbpNTdyxotvp+0YbtNqIEY2JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcHm/VGB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761936834; x=1793472834;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=3eTvFVLEzAlq7eosHBPqPqN5/5Cc5YKq2sLI6lHtRjo=;
  b=lcHm/VGBkl+RFKJyrz9fuvZC2/ucOU3z8D3YUh1EAIx7pL/GdksVuhhW
   6oTbNCuofMkqlsDLnwyBSeBtYixv7HepzMBIu/taveyDe8AcAuUP1EUtf
   GbMWYvW7Nzf7PVyFYenTJmuqBNHhkQdKg3QOV0OylQ/D5sA48x5xfoQnn
   6st1+A+gJP5rxFW8XHKV3jL7FWNvm7U6Br8ZM+7hiv1YuG5bFnuAbdk1D
   +lVjXEY5dJnmDd4ATHdFPL0l2F4yHOuanf6G/QNIuG/XKKGghPONAXypy
   Dz0K/cSJ7KZi2/rnTcbcjR/Mk3KGAQM+sritbbfqk/BLHcEkkLigvfQ3w
   g==;
X-CSE-ConnectionGUID: pnszuzrRQGeux4QLfuBm4w==
X-CSE-MsgGUID: sra1no4UQHy0L3kejlTejg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74780327"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="74780327"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:53:54 -0700
X-CSE-ConnectionGUID: SJ3I5aPaRx2gMJGoTHdPQQ==
X-CSE-MsgGUID: 0PN8yzo/SGehm5xGyBJ9tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="185578525"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:53:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 11:53:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 11:53:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 11:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVUT1XS16v4iU8LVwqOyXuTz0JvrxSziklJUVDhuqcqEzwKo8xZ+NWd/1tTAlhRd/693CEpqg2FrAJbjgEkrC6K+vOTzLSSbSYvJ5hWN5odr7qgRy009NaFrEqn1QEgyaCnT+Zwv4IQvyCZHkaAC9ipNcqGPQQcqYy4M5nHYVNJd98U9x7uOvNpweYlFM34EajLdbAyI8DIWcYzfOsenHHpixrThlOj8+UgviX/RgDSETs4SFz0x+81WUP75qlJwPdCrwOfqaMCjy0uAcQmi7wlw1COvgGKhOcJvDuqCzuQqCo6MJ4hmjvFzviiAak00LjAluhgjhgo+CUwT+tAI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEa0MGVVHgWoBrIiOv7+TjaquDNWKcDmImGMbpxvB2Q=;
 b=o93CKA2AJrppCEgO7B/lbvOcc1ZYNbcJd/z8PyhYsURp3QZte1Q9q7NdVyWZPSWrEY9z8VNIr0PYLp/GPwpPVEKUOMHs6sldOSv7/eE1TTfP0CNZm54/aPKl3BTH19ElK+ryJREVTMqgQUQDBwznU1DSiS6OrvwmsrI2LDiO0KhtJpGfR+HZfHowsedfoh8sBJJt9+vUMBgFGyV2ZEaBPWwHa/yzzjOakbn41+IjMQw7jy5Sp5zD5t4tB67Bv+UXHCDPQycAJkMF1pOyxE17V9qxK0mvwhlOSwDLJC6MnaOyJZxiFR6yrRKQegsLeaUBX0+jPhdyp/4zDcIvn1WOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF307806035.namprd11.prod.outlook.com (2603:10b6:518:1::d13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 18:53:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 18:53:50 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 31 Oct 2025 11:53:48 -0700
To: =?UTF-8?B?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>,
	<linux-kernel@vger.kernel.org>
CC: <willy@infradead.org>, =?UTF-8?B?Q2FybG9zIEzDs3Bleg==?= <clopez@suse.de>,
	Dan Williams <dan.j.williams@intel.com>, Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	"Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Message-ID: <690505bcc8105_10e910095@dwillia2-mobl4.notmuch>
In-Reply-To: <20251031111908.2266077-2-clopez@suse.de>
References: <20251031111908.2266077-2-clopez@suse.de>
Subject: Re: [PATCH] checkpatch: add IDR to the deprecated list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF307806035:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f62ec3-96ac-4da2-50a2-08de18aed484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXUxQTdnYTY4NVFEbHJNM2xadlJVcG55cDE3RTJic244anVRbFZ3MS94TE1q?=
 =?utf-8?B?NEpXRkVkNzRwWi9qeUtRNFB2RmU0MlU4TkJMVklISGZ3Z0RLZWpvWmZ5UGtq?=
 =?utf-8?B?K1ZTTHVWd3gwODluNW5IVDFmMm4zUGNvcUg0UHNNQmZTY3dLYStqNVRoWERt?=
 =?utf-8?B?S0R0b0tPeFdUSEZNWVZLdTRjUGFTSHJ2UHNUdkJSRitneVh5YldiRVozc1Bo?=
 =?utf-8?B?ZCt1TmkyMGRtRFZBSW1najBrWUpCVHh2Yk1vOVRkR0FUWU1tcW13RnU2WVlM?=
 =?utf-8?B?ZjBFMHc2c1ZaNkVoUVlMMEV4cERWdXFTS01VK2FMSTdQZ0FzVDdTSzkzRjVu?=
 =?utf-8?B?M1lkaFFjMzQ1aGZJbkp1SjFkMjRPUVBJQTl5cG05d0tYUG0xODJvMS9tWGFv?=
 =?utf-8?B?Uk1ydjBURTJvc2REYUZEaTZPZkJ6UjdmazhsYVNscU1iU0UyWDZQTHpubnh6?=
 =?utf-8?B?ckF6NlNxL2VYRE1OSTA2b2xhaEVRYVVvL0lpMUxaYmlrRm4xY1haemFMaXBm?=
 =?utf-8?B?QVlaY3dRZ0M5RHBsa1I1UkFEZ2FVODJXdVpnOTVFRm0yV1lXNk1ZYUpHYTNh?=
 =?utf-8?B?NmNISk1pSmp4R01yUkV2ZXpUNkROdXh3V1pZMCtSa3pjbk8zN05UZUtkTjhT?=
 =?utf-8?B?UG9jaDJMb2cwN0pvcFVpT1JrbzJxakhvRmthN0dCenhvdUh1VEFyZjJuZ2hy?=
 =?utf-8?B?YjJ4S01kejNCc1pKT1lRa2RHSE4rN01GbFZXTDYydklKYmpEZ3JSeXBHVzNU?=
 =?utf-8?B?NlluNzdvNUdzeDVWVkRqTmFJMVNSNHFtL3kwU0hmbDIyU3hvYlhXeHRFb0hI?=
 =?utf-8?B?aHRzRnFwN1BWUlg4R3RFUlFMK1BsZHhiWFBaTWFQTUt0elRCUEFCeU1LTHJy?=
 =?utf-8?B?VzI3YnBvcXp5WkxsTWZUdEJEbGU1d2tRTS81WFVQdXlzeUgySDlKVmh0TkEx?=
 =?utf-8?B?OTUyRVJ3ekpTSUExK2U2YXAvRytwOVZGWU1rL2M4dUJsdHFNbjI5djRic2RL?=
 =?utf-8?B?d1JMTlVwa2V4YkhmWnlwbTlrajlybCtJL0M2cnJ1cHpVZ2R6NTREQW4yL09J?=
 =?utf-8?B?ZDQvdDhUYU9CSmlPcXFQeFRRaURESWlma29CZzN6OEc0OWhhRVFuYjF3Uzhx?=
 =?utf-8?B?YjBqSTRseVpTNXEzcER6alVBb0JIRUNnZHh4UElibHU5MkJWaHgyaFJoVXdp?=
 =?utf-8?B?YUprRFBJU0d1TEZ4S0VzeG9mNENVOVpadlozY2szbXNrU29pcUVocDhkYjho?=
 =?utf-8?B?TFIyZnJOSDlyaW5sbUpRV3NqQWpTcDYvN1R3b0pBbTlET2t6TE5qYmQ3ZUJ0?=
 =?utf-8?B?bElhQkNMNkhHMHJscmY5SFZ4aUhNNFhaR3QrSDFrVU0rSEFrUjQxS25pUzBp?=
 =?utf-8?B?NzNNUDA2UHFlTmNKVDJQdUVMWlhIdmNQekNWMEN6NVNIOUFQMU9FUXBQbzRy?=
 =?utf-8?B?UGZDd25lOW0wQ1VQcHpuWWk2Q2dxYytJZEVKTFRKVGJKcnhSVFg0UE1nQm5V?=
 =?utf-8?B?cytNSXhRenpYRUhvWWFFWGhKdjJ0bFhyWERvQnBkZHhuZld2UTdvelV2MWNj?=
 =?utf-8?B?eEtrZThlaWhDN05sNVRsQjlMMFNJWTY3dGRIVjhEaUMyS0hQdyswY21pbXdH?=
 =?utf-8?B?b2pJWHVZNTUySTBaYmhEekk4NGZrM3EwUUxmUjAvODhtVmUrbEtnb0lsSnhE?=
 =?utf-8?B?Vm9HSndNcW8vdklUVXNORStxMVBWazdFU2tPTFZiZXVCVGNnL2hrU1BXYU1D?=
 =?utf-8?B?bk5HU0E0UmdKdE5maldPcTZUNHl4MUtlTEVGRGEyY01tMEdJdVh0NDVwWW4z?=
 =?utf-8?B?cGFQTldJbFAzVWUrRWNrVjBlOXR6MDNMTXhRT3p2aXlyWDY1d2hPYTJWUjhT?=
 =?utf-8?B?ZHkzTTZROER5T3RsQWNNRjFWK0NBc0NQOXo3aEF3K3VOdTZIOXp2QXJHeWFS?=
 =?utf-8?Q?fREOoQU92nuMqJXXBZgH2O0L5EZsJXVg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNzRmJvbkNxS0JlTFlLUlZQSENvYks0VHcrM25IQytncFhLYThhbk9LTWtu?=
 =?utf-8?B?VTFlNTRSZ282TDFvT3hMWXZBaVBNVXUwNCtLMjlOMDg2ZVY1a2g2U0J1Mm1Q?=
 =?utf-8?B?RWYyekt3OFptaGJsejZuTGZtSlZYVDRlaGJSRzA5NWpRRjVaZlYxeDc4QURU?=
 =?utf-8?B?NXVPTTZrZjZqb01pMVdJYXNDZE1Mb2E3cTJHKy9wSGd4ZHJ2K0VSTUJ0WmU4?=
 =?utf-8?B?dGhFcXN1ZmNHUWM3UFJTbkpTR0V6ZjhpcUhhNDlFMFhLdkdmcjljcEhnMnBv?=
 =?utf-8?B?VnJiczVwS242QW9IS0J2Y0FLaWxadURXVE1rbmttRlpiQjhOeUV2TDR1ZkJF?=
 =?utf-8?B?ajkxdm4wZWh0c2h0MFFrL090cnNaZVRURTFla3dnTXFYYnNDczZEeUUybndP?=
 =?utf-8?B?QXEwbzFXQnRJQzZCRTJZd3pVQ0Z3NHVxYkIvejJYa1ZOVHhuZTlMTXA3VjBR?=
 =?utf-8?B?aCtwYk1SM3NPMVlNVUd1em81dVo0ZEV1V0k4N0JMZU95a1lueUhUaWdLNVhj?=
 =?utf-8?B?YXQzb0hQeE9zTzJLR3QvSHc3VC8xZUtqRUlGUW92dUkvSWJtaHpCTk8wS3FT?=
 =?utf-8?B?THJTWm9kVjBYVGNETEVrSFdOWjRYOTU2N2E1VjV5akNjaFpZc29Ob0V0bXJ2?=
 =?utf-8?B?R09PbE1Tem5UMElSMStyY2VGRHlFVEFkWkJGOFc2eTN1ZDJoU3A2WjFqc2I0?=
 =?utf-8?B?VzAzQ3k1SE9aOXlYcFh2amNkTTk0UlpocUIzMlVYOG13bGs4amgyRVd1enhX?=
 =?utf-8?B?R0ZiaThUKzZ3QXZyNGJhcXFwSFREdlFYZVVKaDc2N2dTUHA4UzFnYTV2amt0?=
 =?utf-8?B?ZTdXOWE2Y3Y3OG9raytqQUtmVnBwUE40UVdCYnJUNUU3a3pQMUpHdUdhWmVP?=
 =?utf-8?B?eW0rU3psSWc3NUxsUTFMdUUyVTlCK2FEMUE1a1N4UDdNMDI3dXVmSy9tN1Zy?=
 =?utf-8?B?UjE5d0YyVHFhRG54U1YrSFVsdFhWb2tHUFFTWE9CbmwyNzY0WEdPeU5BQ1VT?=
 =?utf-8?B?NjBmcktmVEdsam9rdFhtZS9XK0ViQ09hTURSYkJtNmh1dUIrWHE1a250c2t4?=
 =?utf-8?B?VGZsNFpmUk51UHVxNG10eXZ2YXpBbjY5OWNPNGtrMG9vSSt2U1BDZStNM1JQ?=
 =?utf-8?B?UnZaNHhHeGlqMjFJWTk4SDRDVDJmWWpWTzZwc0E1QXdjb2dHaGgxenluK2c1?=
 =?utf-8?B?MktBem1rWUU5Y3F3Nm9tdmx2TFpkaGNUbmRuQTJRenArWWxvSmJkRG5VSEJi?=
 =?utf-8?B?Z1d4clFrVTd4WE9WZDMvYlg1VFRueDNhbTBXaXk3R09sR09Ja1NuT1M3NWRI?=
 =?utf-8?B?bWpGcGNNa1hqZ1FWZEd3aWtnaDlBcU5POFBydC9qa1RmMi8ydGJMelpVc1FZ?=
 =?utf-8?B?U3FBUE9xVHlXeU5CdCtuQTY5cXNUK3g0Ym9DSlFJanlzanRNOXVPeE10bzkz?=
 =?utf-8?B?RkZYdG5XNVgxdkJFU0RBUVZjTWdhSTJFS0M1MzR2RUE3bExZRGFObWRwTzl2?=
 =?utf-8?B?SGVpRzRNUU1ZVVNSQTFCWjh3L2NDZ1A0NThRTGl0OEh6S1dVcENjVlRndlQy?=
 =?utf-8?B?WUxmbTNvc2IzZEhOUzhQVEh4MkYxeW9VV3ZrK3JIODBSL2Zxb2FLOUNQVkJV?=
 =?utf-8?B?M2FUTzl6cmJxNGNycFBTMFc1bGszeENrOW5xd1dJSk96OVpuQzEzWktCNzAx?=
 =?utf-8?B?amtLdlk0cWFvbUpNV3FLOVlwSHNBNmlncTArMlc0WkgyOGNkQmVzZy9kYW4z?=
 =?utf-8?B?cmtQYzZzdmJ0TU9ZU1dmTzZOWkx2d0JqZ2FpNnIvdUFFOXNoZGJZdUlsbitq?=
 =?utf-8?B?YXNzVFJGUDEvUUw2T3ZaNUplZzZRVWs5ZVJ2QXNSVW5oSWFEcTh4VFhGQjhS?=
 =?utf-8?B?RGlFSXduREl2eXdxamkwaURsVFdPM2R3ZVZRR3FWWTJJS0d2UDI2NXpzc1dm?=
 =?utf-8?B?L2VkdWtZbkQrRm5sck9scEVqT3JJY0duOFRSbnNqTlhabW1OdFdUdmhKNzRo?=
 =?utf-8?B?d3ZlOFZZM3l1T2gvZ1Q2SzZsbFdiZWk1UUYrcnhFcDdxSDc1bXJDUklpdmVK?=
 =?utf-8?B?S0FxdWhQdTNLTm05dElvdmNKdk1vNU5VWHQyaHlYUnhoNGdkSHhrVHVxenMy?=
 =?utf-8?B?OFJYYmZuQWc5U1NVbEhNNWthR3ZlS0N3TlMvWitRQXYzdnF3a0FrZHYwL2Vq?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f62ec3-96ac-4da2-50a2-08de18aed484
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:53:50.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzaU89a3T5c4+7GMyYgti7vu/M8V7bnPKA6CMNU3C8EwR9g3y8EEymH6nUeoeI8GPm4QoMNzkQt22BV8316EKqmT6PoC6HscysOpHUtjD/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF307806035
X-OriginatorOrg: intel.com

Carlos L=C3=B3pez wrote:
> As of commit 85656ec193e9, the IDR interface is marked as deprecated
> in the documentation, but no checks are made in that regard for new
> code. Add the existing IDR initialization APIs to the deprecated list
> in checkpatch, so that if new code is introduced using these APIs, a
> warning is emitted.
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 92669904eecc..bc72fa66c0ef 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -860,6 +860,10 @@ our %deprecated_apis =3D (
>  	"kunmap"				=3D> "kunmap_local",
>  	"kmap_atomic"				=3D> "kmap_local_page",
>  	"kunmap_atomic"				=3D> "kunmap_local",
> +	#These should be enough to drive away new IDR users
> +	"DEFINE_IDR"				=3D> "DEFINE_XARRAY",
> +	"idr_init"				=3D> "xa_init",
> +	"idr_init_base"				=3D> "xa_init_flags"
>  );

Thanks! Works for me:

WARNING: Deprecated use of 'DEFINE_IDR', prefer 'DEFINE_XARRAY' instead
#111: FILE: drivers/virt/coco/tsm-core.c:15:
+static DEFINE_IDR(tsm_idr);

Acked-by: Dan Williams <dan.j.williams@intel.com>=

