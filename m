Return-Path: <linux-kernel+bounces-810494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A05BB51B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EC9189AD76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0642580E4;
	Wed, 10 Sep 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEwlC2yr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D31329F3B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517592; cv=fail; b=TXevdWXccmwpQciH8AUnBXA9ZdaoIV4tBDnMiPQCHMWOHRqJoFT89OMsGl2DZ8J1HrUJw6Ysjs8QuW7WKbra7ihLMoMT5d+7tgv7qXX4l+jD7R5aCL/1HQLnMzU/J/ZzpjHE2y9Omkgvu1fCqbaKmm323rZPwI0VRf0eBQNxqtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517592; c=relaxed/simple;
	bh=JouYhLeNxPvhNBZH26x5Olb5Wyy+wXrQ9G1PJzWZAGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D9YtVeFHJnfkNgpW+gJFOq2G67XnSZr0RdWoKmeHzHDnXI9BqeyTeWAMd4YnRLq+epXM75ELIwdMm1/bAzy0oPgVd83yHDnCBl7XeqIVazdwRn2er/NxowT2UlxN7UFkoz95MlKM5C9D+Eh845PRR26vixK4etiDr3iB7LGg+X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEwlC2yr; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757517591; x=1789053591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JouYhLeNxPvhNBZH26x5Olb5Wyy+wXrQ9G1PJzWZAGo=;
  b=HEwlC2yr+8Fmu6qrDJ1HUtr/PVgfxxnzSNVm3hgSemnv663Yy8zy8r2O
   G1IxDWRrTrD/Y5of9jruv5cgaNxKozo03YbebIg55ZbtlaolKAvuLJ+1J
   gbVGPkC33ufjx+5uPaeAYeevhGRM8dFeTQwCAbVU5gRZwSclcif77A7Wb
   +tuql2cIKdvttOyZMmc2qU5utCqZImToPi/XZdVLCZf+w3U9Q5aEpsDtv
   RbDicVLnwJAkovNqvol0Ts7JKKW2hGah9pJ2ZMXkpivbm1eFO2gJn5708
   xA1hI780hnk7TMqOPRCnWndYDgau3j/zox+GTgbrktiGHnywoAgptVATD
   g==;
X-CSE-ConnectionGUID: e5QNpqEDSSiqVx89vSD99w==
X-CSE-MsgGUID: A3FLLm6bTTS/6bA5dBMe9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59907970"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59907970"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:19:50 -0700
X-CSE-ConnectionGUID: oIacSMdCQGe6TEERI5DvvA==
X-CSE-MsgGUID: NrVSYJBTQXmtIK20wNOxGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="173272507"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:19:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 08:19:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 08:19:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.77)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 08:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNPcShfqBGjZxdctPLHcSzV6xNzu2Q2QtuXVQKW/7GIjeGjWyxeeuv3eNYARf0uP/Pg+jTaFdmZ4Qr/nBQc2dfmYDx0b8mRjqIFkEVhhKDn2Y2SlbPSDIeTwwFojnrp9W+zAAJmjBA+Gfm01AjAygokH1oF1OJ5iEWaO3/NjkZ4wn2ltoy1HH0m0I2eSsmBBoYH5BqnUfqGGFRfIMWg5qQW7WN0EsbjesFlMLlSlhOdn0ynqZNb1WPSIPCt03SWzOi5YDV0sQimrDuP1JyIwn5HQfqv9+j+Dzau7RscnosMwMwPru5tAuD0hH4o7pXui0BvQgQ0cUzHSDgwl5VvktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X5+1ePEH/WIkaDuDSYDCgMuJrdtcQUH1ihhtFIroXA=;
 b=upWs5LBmu3QMEr5SfrCoeJKnoHBaj7gDzQT9JB7lrxaVipM8MJtN+0G602JUBvLhH0QTO7aNpmbWjMRUM6VWBbeEmUhLtbYng75wZ7lg2XSY2YAukq9VZgmDvI//Q/HTbATHoWOmKEGeLs0qcJ8KRqOpHiL9MJ/29BYmJi+d1j+7AoNWeuvvq2Rnoj0jpcYQWnK2jAg4yNmdmfPX1INyHCsNQsXIW/rt7nPyhS6QR64aXzZ8gqqidhur1kOrU9K3vzpeZEmucprrWghPWXDO1VJ9I8EQso32nMScKgGsHjDXmJYIHepBjItoDfv3x97DR4rgbQ/vXE89pZ1e2wKQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by DM4PR11MB6190.namprd11.prod.outlook.com (2603:10b6:8:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Wed, 10 Sep
 2025 15:19:37 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:19:36 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "josh@joshtriplett.org"
	<josh@joshtriplett.org>, "frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] refperf: Remove redundant kfree() after
 torture_stop_kthread()
Thread-Topic: [PATCH] refperf: Remove redundant kfree() after
 torture_stop_kthread()
Thread-Index: AQHcIllVTzqH7x7FyUKotTUJvQHqCrSMh0gw
Date: Wed, 10 Sep 2025 15:19:36 +0000
Message-ID: <LV3PR11MB876827543D56176BC8023124F50EA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20250909054148.1573012-1-kaushlendra.kumar@intel.com>
 <328b2f91-acef-4ee8-9562-9ec608124d07@paulmck-laptop>
In-Reply-To: <328b2f91-acef-4ee8-9562-9ec608124d07@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|DM4PR11MB6190:EE_
x-ms-office365-filtering-correlation-id: 87407a25-e2fe-4ca7-3dc8-08ddf07d73d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?CRd5z3ZwtcKayeKGrkR5V9Bko68WpvlofDBxyVf07Td/q1tZAfb7lfjJWRfc?=
 =?us-ascii?Q?98w+8ThiYE7mrNbrlxU+PkkqIehblS0cryzbx0h2SBCDGCLnaZHZXrQyOD5m?=
 =?us-ascii?Q?q5lIsjdtRqyV11csYiQEaNZ+ItNZ7xDX5StvAH0HjqV7/D61ku6eXkW0evVA?=
 =?us-ascii?Q?A3iZUSpTYgmtByEdTJRAvczn5doxcBfpRFVGk9Zv2j8hsxiQmYf0qzcivROp?=
 =?us-ascii?Q?jyC00ljjzIR7jaE0uPoZJ1zqQi6ELiPI+aqHeTiA5tn12xUqMHyNpcwqZZAO?=
 =?us-ascii?Q?9jWsoyjbxl9pzJpZTfbMMWE3RmHnLiC49uKrhbmIhUkTOWr4OjbOsSP9Jx77?=
 =?us-ascii?Q?8s/FhF3M2EUeNTZEPHGtx+S1gRpnbUL7+xhh8AkVceXcu0ljy6SW20e4+Gd6?=
 =?us-ascii?Q?o9fqA5cxbH2eEwDhY5TjOXmqgQawdQpuW2dwKPnWvjbfpAHLYVXw8NfcP1XH?=
 =?us-ascii?Q?SHBYb/bb6uHVCA8mXG/XZ1mWkm3UCJk1Fb8DIUDYOg9VdTI4es0GRC4KfiAy?=
 =?us-ascii?Q?S082QgmhCfMrfUmcKidKVinv9UNcRKPmZ93RT8zzvNC1iVHIyOmDv7is0TpG?=
 =?us-ascii?Q?GrYBWT1SE1AS64nkyVMxti21ASOAe06kRdeTC5TTjVcvuuMkU/CG9GA03dQ+?=
 =?us-ascii?Q?JhWztzZzFsMxCmMEM3jndS+8ez+l66wGlZ+ON7izxpOfeVLRP8jEqYyAy4tJ?=
 =?us-ascii?Q?c2kyUCz9u2SKFM8Cl/2ADiks9OWEmwat2+2TzrArWgncsQfUEFPkwf3toOXG?=
 =?us-ascii?Q?wMKXYtnNhi/mpF5IQZFZwOX6HFvne/clzGyUPEx5fkEQ+0YgTgfi+sVXY4UW?=
 =?us-ascii?Q?lOCYhQ6Dz036Ka13y186MYcPKSM+a90lnlFxFaGJGbEsYHxecSzJ7+BllrT3?=
 =?us-ascii?Q?uQzKW1fXslcTDjNx187DLZBoxSZql1SdPSAXe+vWYTh37LE4L270XXeHnxBz?=
 =?us-ascii?Q?PGBLdTaWNaSzF7cb/qCiLF18uWkWK4TfVje3ZWgW0dUnbNEdW3WWZNrIzc2+?=
 =?us-ascii?Q?t0HnZylrowVsejiP99aDt5C2H0VIxxiEpPUGvmxSC/QkP43RxFRTGmSbjVN7?=
 =?us-ascii?Q?HSaYDZiP71fYS+mp522wDGh3+L4ZifY/1Zs4a4746/wEFyeWx/2jqPNoS/zM?=
 =?us-ascii?Q?Zm2f/mzK08ESe7I4ysH84Gh0R3D7Wfj4JPCSy8rG1x/muOgBV0niiy/gQaqQ?=
 =?us-ascii?Q?SRp75dG4XTCggBmIm9EILcGGKZn4Dq7OIba6R6NwUDJAMRMosaiL5j50faJ0?=
 =?us-ascii?Q?3k+KJXdCb9G82bJz5O1+FQ8j6jE9L0WRlWIm6FB8j2EfgnApBygqO5SACimZ?=
 =?us-ascii?Q?O41r38PLTq6nLylLbGEtVVWYAVr9UwDjhbiZ95wi8x4dfegVHTf6toHKgJlH?=
 =?us-ascii?Q?jmbnAiVSu+ZenolHN/0nD8GTXWy6KBoOCJ22rVuSy9HaCorQbAUCrxCAzkkr?=
 =?us-ascii?Q?dgobE/w5o3cHgxyYBQ+3Ctl5csothbNBq6aShjvLNNzZZEwLHC8HNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?57o/CZqDXLVYKSiH1XF2G004I5pE0WrasglCidxHJ8C8C8tnYmMiwdSgTJcM?=
 =?us-ascii?Q?3T+XMtSrpnCngDlzCuYUOf6wxT5DMv0ldCoqLK0qL10d7n8ncuT84ffYfIpd?=
 =?us-ascii?Q?tW+o3n1Qpw6MJnLY2Xao1DWFAOIn4/icptyFDGArQYj7VSok5vS6nZkX32Yj?=
 =?us-ascii?Q?Q4tVH6CgZ6pCoKQhqlO1CPfl5188CG0QEdnmeVhzC9sFV9WncPhP3pwS6fsW?=
 =?us-ascii?Q?mrIesn+QFyXdO1fciZx45NkQp4tyH08aGPirlpAVFQouBqljSkGuE8eQOFJ+?=
 =?us-ascii?Q?tJC5CkUXl7pUU0VdAvUJ9vR0hKBj5BdRmHT1VeEDYVqmj7PqaPrbw8AnG7JG?=
 =?us-ascii?Q?gKlaxXjXHqdDuy3z3d/RRiJ9KgvtIJ+oHjbBZMcIKMTaZabW/L19Tf/+1nKB?=
 =?us-ascii?Q?c2CyegoTfGyZTuqu4vtyBWxJnG/D9uh8p4slGYztK/5CjnDN3FOEaXZYla1z?=
 =?us-ascii?Q?mke6UoLo0jpS6d8RDGzg7lLA7mbqID1eJYZVHoAzR+NXGgtx+BubxsJn2UW1?=
 =?us-ascii?Q?a+pwPW4keivO+LNPr7BZ8O043Ed1fB109KFRH/6VQBdBsnTfXD1Z1IcfABi2?=
 =?us-ascii?Q?xMR7XoEM3FKqUleRC0gPhYEA76AZerHza0jNn3XAKkp5MunAh9yrCadGpfHG?=
 =?us-ascii?Q?p+w4sw+mNCtSgO2MmMaVbZp2sFYPRcQc8BHomH8dLKWfgW3a7gsFrMOP3++x?=
 =?us-ascii?Q?0t1na0Rok69HRyU1ox5lvx/hD5K6a6U+mVQXbVN3QUM3nYptgIgh2WZvfpan?=
 =?us-ascii?Q?Z/GfZnkyHAEMBhSTyJeS4XAITn3tZ2CZVybNGFHKdB5wtX6DvCwXcwcSPRpI?=
 =?us-ascii?Q?u0Hpfmw5bTEGKANNyCDKAV0YgdN7xlripp+eakSQ25hgCIKfXKkH5pWlUVJn?=
 =?us-ascii?Q?n0vDtJ3ec1Y3bQapDsOs8s63s1hI5NGzjy0B2wLULsIB97MTF95NsY6zCpmy?=
 =?us-ascii?Q?VhwEiquuWR7nMgURAceSDk/QLWQ5PP54478+RgfWNi90RgFyN82hG2I2Q8Y5?=
 =?us-ascii?Q?UOwLSaudLwiZOLQJC8GrYVGjpI2bUg78pmWsiTa5SNOlxtREmKkluB2F01U9?=
 =?us-ascii?Q?dyT/fwOlCBP6Ar60zbdWGtl9lLdN91JXKmB0LsTmRcUoICGtxSwEVnpxbhup?=
 =?us-ascii?Q?BM86eGnmkpZauui4ytmxemFw9RlLjmJxP03P9qmn+QRTO+TzTIRyuajMa6us?=
 =?us-ascii?Q?G49FN7VrVkVfHPj4Kp/bL+qXcXukJWmBhjkLFYof57eWUVKfK1eG7WOcV3/y?=
 =?us-ascii?Q?XznW1Tcf6ZyElXG8UF98fJhtxi0hgxUb7YdnVfKbiwB3z2UzjvLxN8tchqRU?=
 =?us-ascii?Q?kgb8tdCm5rISvZ0XDOZujTv1fOUi9zakPzn0blZPZxPc28VOuC4jjFtF3p7o?=
 =?us-ascii?Q?c0tYWl8zso2cPPkydINn6mUnt0Tlo7hyc5NKz9SNfZ8D/jNxCJFQiJolpamR?=
 =?us-ascii?Q?B17JvvcKyFGW8i2rbZycEqoJ9v/UFkPiLZeqvNjiOOO5+MJIjLR3JL4QGZMN?=
 =?us-ascii?Q?/AAhhv/gPCLQuxBCh79Til/fHGdr0uW3Jhxvhs9yAyBWc5Rjt7d64MYKQgsy?=
 =?us-ascii?Q?+LKgy69wTvSrKharCqpmJpDKRfmRDIXTwH1bxvjs++ic5mLi9v2pGTXOPyuy?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87407a25-e2fe-4ca7-3dc8-08ddf07d73d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 15:19:36.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nty/zdS5Bv38wEl9yjdNDlS0p3Y/vz7H3/jwwhSzFoVe7yFs6iIsSBFiHUSLXx0R+GjFE3kWag7uZ3nNQ1AW8uTw32SlSxy+Pt8/Lna4Go8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6190
X-OriginatorOrg: intel.com

Hi Paul,

On Tue, Sep 09, 2025 at 11:11:48AM +0530, Paul E. McKenney <paulmck@kernel.=
org> wrote:
> On Tue, Sep 09, 2025 at 11:11:48AM +0530, Kaushlendra Kumar wrote:
> > Remove unnecessary kfree(main_task) call in ref_scale_cleanup() as
> > torture_stop_kthread() already handles the memory cleanup for the task=
=20
> > structure internally.
>=20
> Again, thank you for your interest in Linux-kernel RCU!
>=20
> And you are right that the kfree(main_task) is redundant, especially give=
n that the main_task pointer will be set to NULL in _torture_stop_kthread()=
, so that this kfree() is just a confusing no-op.
>=20
> > The torture_stop_kthread() function is designed to stop the kernel=20
> > thread and free the associated task structure as part of its cleanup=20
> > process. The additional kfree(main_task) call after=20
> > torture_stop_kthread() results in a double-free condition.
>=20
> But this last sentence needs adjustment.  Because _torture_stop_kthread()=
 NULLs the pointer, the second kfree() gets a NULL pointer, thus not doing =
a duplicate free, right?

You're absolutely correct! Thank you for the clarification.
.I have sent a v2 patch with the corrected commit message.

> For ease of debugging with kdgb, drgn, and other tools, it would also be =
good to set reader_tasks to NULL.  Please feel free to do that, either as p=
art of this patch or as a separate patch.

I'll handle the reader_tasks =3D NULL assignment as a separate patch to
keep this one focused on removing the redundant kfree().

Thank you for the review!

Best regards,
Kaushlendra Kumar

