Return-Path: <linux-kernel+bounces-733037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3454B06F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1DC3A49AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C138F279910;
	Wed, 16 Jul 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn6fqeBm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E551D88AC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651906; cv=fail; b=CpxoKTQNjXmmSTQcDNAIsAo9ynXKYKWZMnwM65iJ9Ru0SZdiWlqbSHI/QsP8pPrWjEJ8x4VGd6/bD74Dww26UyGTujYXlLTYDBjxwfJryTYZekoSGcUOu8XSfZEqTTISG+fVUwtl5WbOr7MHywlXsQTbFYLb6IsUhRMj9HeCK6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651906; c=relaxed/simple;
	bh=q+zDnAupWEFg9du1R+f6JWPthd+bCig1PxeTiZ+p/60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ek2SISEPLCLBVN0LZyI4SaZph+lAmh5p9WGwyfqivKteEJgpxcZ5zzLnu3+n+QqodlRp6ElMv5KmqysJsxhPugIo9Z7nf6ez+GCraktb6E82KAcdDaYVP9y8pkTV5Dgasqx5ZcZQDAwdhRPNHsmEHoaT+L1hY5AXKDWVQBe9Th4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn6fqeBm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752651904; x=1784187904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q+zDnAupWEFg9du1R+f6JWPthd+bCig1PxeTiZ+p/60=;
  b=Qn6fqeBmKwy4yOw8TsNlkVa0QMPsKA2Dyt5VFZGtWIdOx0T8XJxv+Gk9
   IltPwkP3o402mzCcQTKK77LUF7X/N3aiO7Ck0IedyfP5f/vYhBjHdqZ3b
   W5oxymg+F2x8DMQZ7+gXXIMzrAWIMVYJFvc1cQpp3LIEuNCIuvQX8V6jj
   L5Dnf71BPl8G8WLpttsgZzTddie0tTZO/MFITHXEEfJEGr5+o9cPN8KLW
   E3t2EVMwL0GQVO/ADyLCJ+sifus2KXu/U4QcIlFsb2BgPl89qe0fqxGvP
   gOyeKsFurc2jXmMa8BTiLOrHdcOmI+GqrEd487LXxay7WQDkk/4PBMQPa
   w==;
X-CSE-ConnectionGUID: xCze7q9zRYGC/RzC9IhpHA==
X-CSE-MsgGUID: oEWF92bbRcmMYZMcRtAcxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72460981"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="72460981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:45:01 -0700
X-CSE-ConnectionGUID: 1UsgjSivSg6tMpSBXSJdYQ==
X-CSE-MsgGUID: ysA3vgTZT4apXMbOmZlCFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157784632"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:45:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:44:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 00:44:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 00:44:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqSBtLPbBNsPMWjmBWJ80jFF07BKQv/7yGk8yy6IUMcATibTymknxuUIcGO98ANgzVGXiLwC2PclZC76U4IZNYeQINgPmhHutxXMkvSB46I5AxLHiTjcXpJ+E7WNl6y5KImXXpwzzvk7chWOXwSnbZcPciRqiCpXDLctU0PWW7a4FE9pzycrVTq6LtREZ8Kg6EgXPl9QqP6GzyuIfSzb5gY2i6KF2tmIqHLvxjtYh8T+SGw76lkiv5qDlHKTkuY0Gm2gMWdh3gw7Vev5GC0iiSng7IAQhNAndlUtPSugykjYKZm/BJd2m7KNvGZ/6ckI8YS5ha/s7rdn2ifr+gDrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+zDnAupWEFg9du1R+f6JWPthd+bCig1PxeTiZ+p/60=;
 b=Hldk9V+1clKvv6WnGe0hGpFIKlEEmNIYUuwfTgKD+chRjk+/YOt2P9sypFu69d6sCm3Fpj4OQbn/RqboO8ChDvucgOKvIPfi9dYOX+Vjl5tVHB52s2k9eWIrE2b/ES6UJV0J1riaS+UQLB1+vz6mgiW7mAvU3rKDicUUDaSqHZulq9OlVpJpzflIFCm6eDS0chIkQeYF/cadGXHbUiPbqGzv3TQ3Kq/G/hk8Ek1loJ8ZM2begNaVxyZ7c5cUIC2a2J30UYQ3TZjo1EUSASnbp051oJrpgwxYqqt1qbdIjrUn830wVAY6g8nh++Ubs5ECQQL5bkb+jAerCqh+tAryIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 07:44:28 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 07:44:28 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v2 1/5] mei: set parent for char device
Thread-Topic: [char-misc-next v2 1/5] mei: set parent for char device
Thread-Index: AQHb6aIAxk3SG64BwkqkjQJzl4tXULQbeOuAgAAqNDCAAAsngIAAEgcg
Date: Wed, 16 Jul 2025 07:44:28 +0000
Message-ID: <CY5PR11MB63668A73BB62B09A30AC10BEED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20250630091942.2116676-1-alexander.usyskin@intel.com>
 <20250630091942.2116676-2-alexander.usyskin@intel.com>
 <2025063036-hypnoses-ajar-fdb0@gregkh>
 <CY5PR11MB6366307E6C7330B44132C6D7ED46A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025063030-surprise-blinker-89f8@gregkh>
In-Reply-To: <2025063030-surprise-blinker-89f8@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|BL1PR11MB5254:EE_
x-ms-office365-filtering-correlation-id: 08aa9b07-9702-4786-8438-08ddc43c97e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VnkrOGJoSnRuRTI3bk9YT1p5ZS9lTzM5UC9pZTNpUFloeHRxRm1hY1RhcnQ3?=
 =?utf-8?B?VXRhNWhHdzltUXZBUDJkVGZBK29xZ240Tmkzb0M2Yk9tbUxzVWsvZmlhbXls?=
 =?utf-8?B?YUprZk9haEhQVHlySTNPMlNhQjVBOGplc3RXS0crU2ZFS2tDOE80dld1WWdk?=
 =?utf-8?B?Q0RiSHd1d3cxSml2a01zWURkUkl1ek1GempXSWkwM3c4WWV0cHBNQWppeDVJ?=
 =?utf-8?B?aGpUekw3K2xpeVhvMlJYNzV5SHA4WUExb3lQQUwzSGJTVFRoNlJKbXZ4ZlZ3?=
 =?utf-8?B?OVB2dC93NzQ0WjJVRW9EQXhFNmRlL1lsbkJLMHpHQ3JncEhBYzJydnF5L0Z5?=
 =?utf-8?B?dnpMS285QVkyZU9XQXEvQXR0TG4wY0FhQUxiUlhBa0ZBQkxLRlJYbkZvL09B?=
 =?utf-8?B?VEoyaldkSFhtZXRBWjJGVlR4YkxwSW5pQ1R4SjNwa1VIZ3E5dFc0eTVqZnM5?=
 =?utf-8?B?T0hDUG4xa1FSWllRTTN5LzcxT25ORlVqYWYrZStaamEyakU1VDRBTUFYZ2Ez?=
 =?utf-8?B?dWw1MDJBWWNJOEpWQ29lQzZ4elRpK21CNTg0YWkvRjRwYm1kSW5NaXBDZVll?=
 =?utf-8?B?RDFhb3YxWGhXVU4wdXdUc0ZSbUZyUVFBdlZzdjVLbkFBa3ZrVEIrRDlyYWpw?=
 =?utf-8?B?QlJxbE5JSnhpTnB1cXpWajc2ZDU4enhyQ0EvNUJjWEZWMXpUaVlDeFpsQVB3?=
 =?utf-8?B?dEZjOE1DQ2JUWnJWZ1FkOHhjYUk5eGdnTDMxZHRIdHYreU9qZU40bE1OS3ow?=
 =?utf-8?B?blljM1I1RzB3TTkyN2NLRnYzZDMzT2FUSWtJdDlZcTFiNlhoUjdQRFRVZEJM?=
 =?utf-8?B?Y09nTFlYa3BjaXN6QUZiZ24vZXZOSjJJVy8vMUZnMktWb0NuaUc4YXRXSmJ2?=
 =?utf-8?B?QmtrMVdKSndoZW9SZXRmeDdSVDVaQlc3OEd1MHFubDc5am1rOFN6TFBOWko4?=
 =?utf-8?B?Mjk5enhuSUVKS2NzNUcxZCtLMWk0NVBZWDNNWVJodlQrQWs2STNJL1VrTUVP?=
 =?utf-8?B?aGZ6UnVDNjlaeXZQYWJWMkxzY214aDh0Skwwd29SRVVNdlp5dkppbmhUUCsx?=
 =?utf-8?B?RmJRRXFNUVpzNnEwbVpPQWFPcFJzUDBUb2tIL2tqenU4VURwQ0NTSjQyRWNv?=
 =?utf-8?B?NmE4M0tkTm9yNmtiYitSc1RIQlJwZG1wRzgxV3NMeDhxRnlIYk1GaDBZWlpt?=
 =?utf-8?B?SFBhRnoxejJ6ZHVTY0JOdVkvbExkcG15ZVNNNVNDTG4xcTQ0ZzkzSGdNV3pX?=
 =?utf-8?B?SStZWGM0ckZ0L2k5LzNVZjkzcWlVL0NkSmZOU2txSUlrdW9HcW1CNHpYdisr?=
 =?utf-8?B?MnhCTUhFSmF4eWZSTHAraGpYN1o2UDFLMVM3OE10ZFZZZ2hiakNlVUkxNVBr?=
 =?utf-8?B?cnJ4ZnFoc2l0aXB2Y004U3p2eDZrdVRveTZlVFhGbi9GNncvR0lhN0FKclFu?=
 =?utf-8?B?Wnh6N0FWVXU5RTJCcjFjZHRzS0xwL1hSK2Z0WFc3TkI4ZDJCV1dXaWwzdXhE?=
 =?utf-8?B?c2xHWi82TUZLZUp6dzMvcVZDMzluakVuVGloR2liaDRvMzNDK0ZMUG5xeDQ0?=
 =?utf-8?B?Y2tjSUJhZEVPam9wSWkxZ0NvazRibUhxZC81RjRWa2ZDenJVNlZiMzI0bU92?=
 =?utf-8?B?ck51NnI3MmxVeTRFQ1g0NUE0aWU0TkdWZVpLdTBXK3ZqVFdETHNLaHpkNitB?=
 =?utf-8?B?Y1dGYm5uM29EOXF3RDQrSXhoL0hRVC8rS0xVLzY3aGJDSU1aVXo5Vm1pelAv?=
 =?utf-8?B?eGpGUEFEKzJPYUM4MzdsNkEyTG9CZEJxc0N3dkV1dFBhOHdrMHpVU3JiV08w?=
 =?utf-8?B?UENnSllUTmNpRFVNS1FaS1duOXRWbml2eEFlbVVrWU1BeVgzWXpzUEQ2WHpo?=
 =?utf-8?B?WWQ4WnJEdG1YdHpVRmszSUVaenQ4SHZlTG1vTWtTcFJPK0JISk5uUWhQaEQ5?=
 =?utf-8?Q?416ipn3wEhY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWc3ZlYrU2NJSVg0RG5pQUhNQjJLVVI1WmtHekVabGJyK0c4OVJkVnRjU0FU?=
 =?utf-8?B?clhYektpUjROajFpUjRWRU9wRmtpRkcwZDMvdC8vVVFhSGlHOGpUWXU0U2RO?=
 =?utf-8?B?ZlIwRDIwWDZhbnVFVDZhdVViZENZcXZtNko0d2xJVURiN09RWWx0MkJhM3JD?=
 =?utf-8?B?WHdObnNXU0RaYzZNSUV2UEcrclJsT0ZPR05lM3lZRjEybzBJeFFSVTV5QU90?=
 =?utf-8?B?d0hIM2VLK0FiRTN5S3lseXFEbk1uaytjRERGMlAwd2gwaGdrbXN5NVJXcHB4?=
 =?utf-8?B?a1lId2pDUkpLL0ZZRjdJbmxaVlhPRVJMWExFQmxNUFRPOWZOcDk3TVZJeHlu?=
 =?utf-8?B?S1NDSXRPT08xM1l0enR0QVd1bHRZTWwxaDFocjRkM1BDSUltT2JIaDVMbmZT?=
 =?utf-8?B?YlJhNDRJYnpheWx4SWQ4eFNONzJJM013c3YxS0xzTTYyUXQwTmxIWElzYVNZ?=
 =?utf-8?B?b3ptb04xa09ZQWpkWm5XUllRWlRHZThpNXQ2UjVBSDRsVG5PMjlkbHpSUUxS?=
 =?utf-8?B?Q1ZSQlN4QUtBUHpqOVd0ckFxRWIwTHZ1eWE0VU04bzBNendydGF1cDkvbHNK?=
 =?utf-8?B?aUFVajZmMVVyQjBVaDlxNDViaDAwbmRHTytKeHlCTURoMEswQnQzOGR3VGpm?=
 =?utf-8?B?b3hkRlhuWCtKajV3ajE1NlN3Vi9OOWwxZTRjWlR6eTJRNWRwSGJ6WVlZN29u?=
 =?utf-8?B?d3g3NUJqcHFITkxTSUZzTXBjTjUva28rRkloM0cvTUw4VjRVeGxTQWdWNHIx?=
 =?utf-8?B?dzF3NVpZNUVjR3BsWGRjSU5XMjM3VHJTUnJkS1FuMUpML3lMQnR1ZjdKTXI5?=
 =?utf-8?B?R083alQ0dWVDTFVCNTdSWkN3VWZCNTZGNU55eUJJYjArd2Z1dmFCZlNkNDll?=
 =?utf-8?B?NTNlcnhsS2pRdFhFd0d0Qld1NHZtUUhZZnpuQWxHbG1KWmJYSWcwWjFsakdV?=
 =?utf-8?B?V0RqeGl2dVhteEhKbGNjRXorRUJiOWlLMy83ZHIvTXVlWUQvSUp0dTNoelNG?=
 =?utf-8?B?U0s4Y1h0YTlvcWU5c3g4V1A5V2FSMXh6N050U0ZCajQza2xuNklDRW1UR2lh?=
 =?utf-8?B?N01vMUZUVGJ4YklreklYdkcvS25kaVd1VEFobkZybEFOamJJMytudUN6VXBO?=
 =?utf-8?B?amlDckVReGxRQTJ3aHhjL1V6NlluY0FOVDBhV2p1SlNGcU1zTVpnTUpBdTZk?=
 =?utf-8?B?NEg0OFByU3dGeENoSktVRHZUdjZoSDJsOTRjOU1DZlMwZDRTMFdYalE2UHY4?=
 =?utf-8?B?T2VsQ1FEZE9SM1lkYm9MNldGZVJpSWM5b014TXV5VU4rSkZSMk9ScjJ4TG5J?=
 =?utf-8?B?Q282U0FsM0hrczRqN3lYZWFnNU1NRlRXaGthbmxidUg2aDNhNE5QRlVFMVdr?=
 =?utf-8?B?QnFvY2NQQytLc3lVRmtBNnlFQkZ2MDFkL0lNWkJ2QVAzcWpZcy94M0V4WWdP?=
 =?utf-8?B?RGpocUVNYTNIMGFOQkt3YjM2SWpGVXJ3dVdpNi8vTE90ckJ1RTc1aVJMaC9F?=
 =?utf-8?B?dTNvRWZibEdRZjlKdncwRWNrR1JyUlBGL0RDSTR3aEhqMGNLc1BtaEt6OHdS?=
 =?utf-8?B?SXNrdFZEMDI1Q05yaGwxRGFZaDZGQmtCeU80THJoU0VSUGRGczkxamwzdkxo?=
 =?utf-8?B?YUd6R2twaE02VnBGUmhScEFYVldTTG5PdHdQTTJWRy8zSFFuUkdVN01OaDNh?=
 =?utf-8?B?KzlxRWJOV2wvdkdNODNBWTljNUxZN2FuVU9FcWMzVG1VdFZHcHNUSFRBSWU0?=
 =?utf-8?B?YjdPYjFGbWZHay91VUhZVzQzaGR2ckIwMWsxQXNhdlBIZzkySGVkdnhWV2VC?=
 =?utf-8?B?c1lNa0xDU2ZDV1N6eGdjbEszZThCcEF6cXdPaDBLVWhtM2luZWNuZC9oeTlx?=
 =?utf-8?B?bUppbVl3U3BZNGpXMmtzTGRMd2lZSEpENmwvdUp3Y2lMUEt1VGRzR3hSYXJI?=
 =?utf-8?B?ZUNCVTlPQXplUTdwWmU0ci9qUHkxVTV3V0JKMm92azlqbFVLMVppWXlya2ww?=
 =?utf-8?B?SDNDTGEwUjZINUQyZHpqTzhhL21zbUJaTkdzckFxM0R4ZTdwMXZ3b1ZOU0hX?=
 =?utf-8?B?V3pBNi9lUWVxOXdpUUkzT21xWWhNUmxzZkx3aWoweFdVemJOK1JLeTAvanVT?=
 =?utf-8?Q?lWUiDixfN+jBBJ1fXi2iHsa4x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aa9b07-9702-4786-8438-08ddc43c97e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 07:44:28.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8kuJhumGakebRN4N/GjAmmTHPJArWj7c0ozX3LFh+5Gt1wEcIDchghKthX5ggavJk8OwuZBInF4o3EmFk1cXGSJCHjuXs7OLfr8YlhZpNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYy1uZXh0IHYyIDEvNV0gbWVpOiBzZXQgcGFyZW50IGZv
ciBjaGFyIGRldmljZQ0KPiANCj4gT24gTW9uLCBKdW4gMzAsIDIwMjUgYXQgMDE6MDI6MTJQTSAr
MDAwMCwgVXN5c2tpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtjaGFy
LW1pc2MtbmV4dCB2MiAxLzVdIG1laTogc2V0IHBhcmVudCBmb3IgY2hhciBkZXZpY2UNCj4gPiA+
DQo+ID4gPiBPbiBNb24sIEp1biAzMCwgMjAyNSBhdCAxMjoxOTozOFBNICswMzAwLCBBbGV4YW5k
ZXIgVXN5c2tpbiB3cm90ZToNCj4gPiA+ID4gQ29ubmVjdCBjaGFyIGRldmljZSB0byBwYXJlbnQg
ZGV2aWNlIHRvIGF2b2lkDQo+ID4gPiA+IHBhcmVudCBkZXZpY2UgdW5sb2FkIHdoaWxlIGNoYXIg
ZGV2aWNlIGlzDQo+ID4gPiA+IHN0aWxsIGhlbGQgb3BlbiBieSB1c2VyLXNwYWNlLg0KPiA+ID4N
Cj4gPiA+IE5vLCB0aGF0J3Mgbm90IHdoYXQgY2Rldl9zZXRfcGFyZW50KCkgZG9lcy4NCj4gPiA+
DQo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTYtcmMzL3NvdXJjZS9m
cy9jaGFyX2Rldi5jI0w1MTENCj4gPiAqIGNkZXZfc2V0X3BhcmVudCgpIHNldHMgYSBwYXJlbnQg
a29iamVjdCB3aGljaCB3aWxsIGJlIHJlZmVyZW5jZWQNCj4gPiAgKiBhcHByb3ByaWF0ZWx5IHNv
IHRoZSBwYXJlbnQgaXMgbm90IGZyZWVkIGJlZm9yZSB0aGUgY2Rldi4gVGhpcw0KPiA+ICAqIHNo
b3VsZCBiZSBjYWxsZWQgYmVmb3JlIGNkZXZfYWRkLg0KPiA+DQo+ID4gVGhpcyBpcyB3aGF0IHdy
aXR0ZW4gdGhlcmUuIElzIG15IGludGVycHJldGF0aW9uIHdyb25nPw0KPiANCj4gSXQgaGFzIG5v
dGhpbmcgdG8gZG8gd2l0aCBhIGNoYXIgZGV2aWNlIGJlaW5nIG9wZW4gb3IgY2xvc2VkIGZyb20N
Cj4gdXNlcnNwYWNlLCBpdCBoYXMgdG8gZGVhbCB3aXRoIHByb3Blcmx5IHBsYWNpbmcgdGhlIGRl
dmljZSBpbiB0aGUNCj4ga29iamVjdCB0cmVlIGFuZCB0aGUgb2JqZWN0IHJlZmVyZW5jZXMgYmVp
bmcgY29ycmVjdC4NCj4gDQo+IFN1cmVseSB0aGUgbWVpIGRldmljZSBoYWQgdGhpcyBzZXQgdXAg
YmVmb3JlLCByaWdodD8gIElmIG5vdCwgaG93IGRpZA0KPiBzeXNmcyBsb29rIHdpdGggdGhlc2Ug
Y2hhciBkZXZpY2VzIHdpdGggbm8gcmVhbCBwYXJlbnQ/DQo+IA0KDQpNZWkgZGV2aWNlIG5ldmVy
IGhhZCB0aGlzIHNldHVwLg0KSSd2ZSBsb29rZWQgYXQgb3RoZXIgZHJpdmVycyAtIHNvbWUgb2Yg
dGhlbSBkbyBub3QgaGF2ZSB0aGlzIHNldHVwLg0KDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoN
Cg0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K

