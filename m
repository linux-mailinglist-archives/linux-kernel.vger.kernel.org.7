Return-Path: <linux-kernel+bounces-733082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFAEB06FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7DD4A3BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB028CF5E;
	Wed, 16 Jul 2025 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRKJuE7w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC2155326
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653393; cv=fail; b=CIi4oGPJGaToLQJrzA8dvJ9aGVVihnepfstMJn6nfCsl3sl6I2o60RbdO7VgFgtKk004XN8txBY6HVClbe/EbKjV8ftIq1LJG7Gc1mitQ7DCP3WfrDcJZUuTrBN9XBiRmLNO/GhEuP5ur9cBVt/pXJDEBSJXxmRQasrKrEARv2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653393; c=relaxed/simple;
	bh=ph2qShbRTWwSgAyIux4hs9QwqGi0SMaFit+f9FgWzWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p79wzsetberfQ2hWYv2i3kkvz1brmojTyiK6Uoo9Bfrq7d1YxLYL3AWA0uhBlHjYXLnowva9VPPOuAGfu9u6fN3Hc1FoG2oTtq4y8/Ugm7wRLbdUsfM5zqr3LI1EM98qqjh9jHKF0UQq3+gE51jJZZ+Blgg2v4x194P6JyxFN+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRKJuE7w; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752653392; x=1784189392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ph2qShbRTWwSgAyIux4hs9QwqGi0SMaFit+f9FgWzWg=;
  b=fRKJuE7wDrIUqGMRP0eOad+CHKT3LmBDvmEiFkzlfo/3xLb+MF6AXZkK
   GA00r94vs0xluShd0a5uCWdC7Vlwwpln2ewLof17bRPWuugf8t0mqaZ1j
   dinYmKg2x/FWnmRJrT33Pd0LdJhaRv0i16bPTAHwkCZkO50rxeeooxSev
   eF7CnbcRER+5KMtSBI1d3ATtYBpkjxPjeiURQjlElfhLfcOfgFVN3fkiT
   W5Pg/OhRFRUPanekPqRNUcKAasd1mLp0PVDqeaDyYrvx5t065CIpiGCXK
   lyxA6l1zu1YMXVrTb0gkY2RG8LvnzSk/ogT7uZ2iWfwPJ27f0sP9w/cMM
   A==;
X-CSE-ConnectionGUID: Q6sFU2+sTu2xhIUqCAQ4Tw==
X-CSE-MsgGUID: t6XHvGifS6OPbBIpw22w9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54980070"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54980070"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 01:09:43 -0700
X-CSE-ConnectionGUID: I64Zau8kQoyz7P9kHxwcGA==
X-CSE-MsgGUID: cNRvqnt2TFKPGhTT/Ax8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="194584886"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 01:09:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 01:09:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 01:09:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 01:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlDf76FK7bBOJ3Q6+yyVeYfMnXS8HEFFZQQCRuodsEbsP9NncZMxCpmZTLfwpGPkGM//x7YaTvJmef+fVFWh3MGp806j31BhSrAt8TXYMs4DxJLyC3SbgY0oWlIel7s9U5a5yvH29pKS0IsOqJ/8IG1t2BI0N8/5m+qyGQ17zEMkKQJrJFrCw2eaCdb5xkrmX9e6We/18knku/P/VYfbyznRfIscKd50MylcGX11EoeOQXTSK0qCN1ZRSLTAlMzX51ekW89EaE+9NJsj3XKx2uR+PckIREr7XDX+fS7gOgKoTrfiGV/1Qxu7V7/2bz3RLxshNF6LjutopXIui95mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph2qShbRTWwSgAyIux4hs9QwqGi0SMaFit+f9FgWzWg=;
 b=g80ZYSCsl6JBm3ULr6RnRey8gUWjGA1xHwOOWunPFA/5lkvL/QpInFZZIpjGPCLVNlkPIPSL4URjWdfnFs6c+9s5W3+5x+qsmZGvfLpMKrSQ99Ct7plFuW4xqZB02LDQ8ceNFZpbEa8+h7vpNLXc11lPbn+KbPbYoHz7eetz5jUGXIQIyHMfZY0AHuV1+K9wQUDTS7NNiM9xk1M0DUrj8z04zulDlm538WYjWVrI72jWl643FG5RtJ0/251UHLCic4lZfi+WOxOfJD37LUzLiy/uPU9TBiv9m7jLvy7ENySsFFbvQn0sfQXjfrJJcdeUwXMlRWyDaRBgRRmYi1yHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA3PR11MB9375.namprd11.prod.outlook.com (2603:10b6:208:575::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 08:09:13 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 08:09:13 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next v2 1/5] mei: set parent for char device
Thread-Topic: [char-misc-next v2 1/5] mei: set parent for char device
Thread-Index: AQHb6aIAxk3SG64BwkqkjQJzl4tXULQbeOuAgAAqNDCAAAsngIAAEgcggBi4JgCAAAE1MA==
Date: Wed, 16 Jul 2025 08:09:13 +0000
Message-ID: <CY5PR11MB6366B3733FB8F09D7F66ABCDED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20250630091942.2116676-1-alexander.usyskin@intel.com>
 <20250630091942.2116676-2-alexander.usyskin@intel.com>
 <2025063036-hypnoses-ajar-fdb0@gregkh>
 <CY5PR11MB6366307E6C7330B44132C6D7ED46A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025063030-surprise-blinker-89f8@gregkh>
 <CY5PR11MB63668A73BB62B09A30AC10BEED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025071623-lasso-twenty-9b9a@gregkh>
In-Reply-To: <2025071623-lasso-twenty-9b9a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA3PR11MB9375:EE_
x-ms-office365-filtering-correlation-id: 7b26904a-79bf-42b0-040b-08ddc4400d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVJSQ1JCd0xZYUFvUzJKKzBHSWpibVM0aTBvcG9pTWplZ1piaGJpY2tEenpC?=
 =?utf-8?B?b25nTFlZVnFMckFUUE9naXpmaVZVbUU4V0NHb3lPa0hNTWlnMS9QSFRCOHM5?=
 =?utf-8?B?S3ltWWtGNEdDSXhpR2syU1ZYM0NIRk1lVlhMRzBJZ01LQTZMZzNNaktRRHR1?=
 =?utf-8?B?U24xRllaU0oxWDhGRzFsMjhUTmRIUEFXR0lSYUpvM2VnbXArdU42TnVTV0JI?=
 =?utf-8?B?UWtNNWFuZ2c0YkcrTWg2dy83YzF2U3ZXcXh0MFczN3lHb29NVmgrODFVNm43?=
 =?utf-8?B?NEw4dWV4c3ovY2VFRkdtZllTQnRodFkyd09SV1N5V3BDZTZvSmdVRXAxclhx?=
 =?utf-8?B?OTZGRC9XU2dpeVJ6WWNWZllqR3F1Znh1bjNmVmtnaFRTYkFlOW9yQkJqSkFD?=
 =?utf-8?B?VTJDcThWOHZIU0FlOHRxbFFidzdISFFTVDVLVHR4WGR2WVRIUjM1TVhKTTRI?=
 =?utf-8?B?empPWUo3dmpnaVYxY04rNVUvTHEwSjY2MU8rdHpZRFIrNUVlNHRDa2VxVG9E?=
 =?utf-8?B?YWZRRHNhc3dTaFNXNytqVWl0WTFvdk12QkpkRlk2eGRGdFYrOU5GQmhqU0tJ?=
 =?utf-8?B?Skw4ckRPMVUvdUtRTFFBbFl1ZHVHbXp1OWV1K0U1blhZQlpKdlJYaENCaWdX?=
 =?utf-8?B?b2ZCV0g2QXRuT0VZaTVUMm1tQnAyeEx5bGRTZlNua2J3TWFkWXEzYXBnTnpQ?=
 =?utf-8?B?eFgxUURTUVQ2OHBTK21BMkRSeXJyZVY2cGdkSVVKUTErZElrK3FwelZJRGhn?=
 =?utf-8?B?TXc0VXc1TGZiMnAxWFFscVo0TVpQUFl2a3h2SzdRWHlOU3FKUmxuSUtlWXVh?=
 =?utf-8?B?UDRhNkJWRG5Sb3dJeVlTaXBxZDE2dVpDY3VxeFNXQzZBRTdkbURjRDlTWFJE?=
 =?utf-8?B?dE5xUGY3Zmt2aldzeGU5akpCVVZPL25uV2JHK3dSVHFXa3VJSmRvcVBOUkdx?=
 =?utf-8?B?b2prUnZ4VC9LVGlSMVV5SU95MDlrT3NvZnlOYytoekpEZ2RtNS9ETXZHazlq?=
 =?utf-8?B?VTQxRzBzSXE4aEx1SkMvT3lrZ25QeXpORkF6VjhCRTNkUGNrUXpjblFLeHFH?=
 =?utf-8?B?Z1NBSEZtSEc0L0hmTjhuRDdFTlpubGp0M0xEVDlXZXFhaEx4eklJYVNDVENP?=
 =?utf-8?B?YnFhWTJaeVA4c3B1SEEyYXUxZzlSU2dRQTg1Nm1yaVlLMHM0YzdRc1JkL3Y1?=
 =?utf-8?B?STVjdi9aWlFiTGViTVhmV3pNKzArM1d2alhrcGxpd2I1c1pzWGJxSFZkSU1v?=
 =?utf-8?B?OTVrbTl4QmhIVzhDakd6MGw5NlJibFN3bUJ0RVJKbFE2WEhueFBaamRDdysz?=
 =?utf-8?B?bWhJUk1odm9EVnp0YVZMVmFwNGpmTmlmWmxBQy9IcVF5Wmp2TGZSYkRHa2NI?=
 =?utf-8?B?L1BJTHNXUmUxbmFqM1BuOFVkSlpWWXRPcEtTZWdmaVpoOUd6a2JwanVNRVcy?=
 =?utf-8?B?UFNPdE9GYkxaVDJhR3lKWlFqd2lBbDNHRWd1MzIvWHVBL2FqOWJsdzlncWJO?=
 =?utf-8?B?aVFJS2l0RlFiRW9iNEJ2ck41VDVDR1ZHL3lXZ2ZkdlFYZHFtdmdSRWFCU0g5?=
 =?utf-8?B?N050aWxONFU5Rm5mLy9rZC9vc0hRMjlOWWtqUm9WRUVwbUFMMzBsRkYzeldi?=
 =?utf-8?B?cVFWWjBPZVNLdWx1Z0cxdkUwcFRLRWpRVS9BaGxaZHBWU3ZwOXBaSUFVaVpS?=
 =?utf-8?B?aklibnh3VTNqNGprY1hwcmowbGpDNlpYa0daM1BvWjdlMVJ6Z2J2WmFzLy93?=
 =?utf-8?B?eTFMZDhtM2JlSFRuMnBqUDcrVkkyTU1oSng4MmZ0TFFGSnJreHd4N3dObDly?=
 =?utf-8?B?dmdHRmhNQnJoZEVxMHJnV1hLT0xGOUc4WkthT0p2SDZUVTV6ZVJkbFdyTGZ3?=
 =?utf-8?B?U1YzRitHTGd0TTkrRVJVQm9WVVd0aEFnbnhPd1l5QS81WUNPTk8vUHcyWldE?=
 =?utf-8?Q?Dk2cV3YuVkw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wnd4YXFsWkR0dWI2RlpmK2RicjRSeXpHZTNydVp1YlMzYVBSaFo4Sml2YytR?=
 =?utf-8?B?NTFaMDFZR2xVa2pydWJRTWRSNWt2WHlJcE5Nc1hBN1ppUWpCMHVrVTZjZVhN?=
 =?utf-8?B?eUNpTHZnNWhzL1EvRTdiOHBSbSs2U2g4Y1NnT3lXUUFnRDlMM2hrQ1ViTita?=
 =?utf-8?B?NE9rdVN0R0Z1YWNqMVRpcnhSeG5kSjJLUEpvdG80bnlBQXlTTWJmYkpPZzBv?=
 =?utf-8?B?VW83MFV3QXZTUGN2YVFZSDhmSVIzUlA3enQvNks2Nkl5OGEwbWE3eFM4RW54?=
 =?utf-8?B?bHlUVVdxL0IwNmNCM0lKSGxHUEtLeGVCeURTMlNaRWpNblovSEJ2Rmlpbkw5?=
 =?utf-8?B?TkRxRFQ5cDdaQlU5UEJFWERkT0VLL252VDhxVVdaNzIzTE1ra1ZnRlB3ZGJz?=
 =?utf-8?B?V09FeHJFRjJHVUJUSFV3eFpRaThJdFZXSTlsOVNvVlZIOURVcm5CZnVtUlJG?=
 =?utf-8?B?ZGdIaUh0ZDlZVHBqUjJxYTJNaWJvSHJNT3ZQZ3J4eDJHaE9yd0ZWVEhIbm9h?=
 =?utf-8?B?T2EzbGN1Z2k1akdndzZpc1ZFS1RxeFpvekV2OUNmSWxlM3ZVd2hWbUwyRHN1?=
 =?utf-8?B?ZVNDdGtUOWE5eVRuaDIrN3FQVTlYckdSRlBaVEovR1kzOUVOL1dqcU1LbEdz?=
 =?utf-8?B?ZXBpV0xlVUxyWU50bWRtZHZSZW9HdmIzd2tXMDhrSVpUSVdnejhYWWVkYTdv?=
 =?utf-8?B?RHNXdzVDVjl3N0lWN25TMm9TcC9BY0hMUnNxVm9lZFQwM29wRkhncGJjR0NI?=
 =?utf-8?B?UGx5RVVMd0dPVWREWnk5QkV5RnJwSFFvbG03Y0hNKzlLc1dPVE5XTmIrMURM?=
 =?utf-8?B?STUrbWorSEZSaklvSXFYSThub0kxTmc2cEl5ZlhkS0EzUzk3MWI5VUxrVnVa?=
 =?utf-8?B?dTZjakphb1RRTmhhcVhmcEh0T2pOY0x6ZkVIR2tVNW8vTHJ4R1BSaDQ1bGRx?=
 =?utf-8?B?czdWRXhJeDdYcHpSejRTM3Y2MXpmU3FjTUptRFRhRlZUL0RGWUJYVHNvV2FW?=
 =?utf-8?B?TzZWYS9SWDdrbFFkeHJWbHJiUWwwUGtiTDJVRmNOR2tUQmlEaXB1WDczUEtH?=
 =?utf-8?B?amUxZ2xnUFdtMDd3ckswbFo3Y1paNmZWZTBMQTJjSVA4eXpPSlYwQUJvVzFu?=
 =?utf-8?B?TC9mU0lJcm5pcVdKUzlnaUVGblEzRk92dld6MGh5aWNpR3RGSnJWNHJzSHYw?=
 =?utf-8?B?dTdWYlNMU3ZQYkhaN0tKQitoVElTNFdpeUNGQTVQVTJiR0hxc0JzQVRBczh6?=
 =?utf-8?B?Q3Y3VTZuUThFNmFZQ3pGbW9DVjl0ZWNPK1BycUZQWGt6R1dUTjMyaGdSTUNj?=
 =?utf-8?B?eE1HUnZyeUpGNE1SOG1XWGl1aUN6bFQrRnJocXNtajJ2dzMzSU5uK1RvSEl2?=
 =?utf-8?B?S1R1a2ZaZnBodCtkU01mTDVwUGlSSTh2UFZFTDlpUXVqVVlycVlTUHV4UXp3?=
 =?utf-8?B?K0YwSzhPdis4eUxXSVlwcDlpbWJxOFptVnR3Skc1eFduZmpRN2hKTU01UzI4?=
 =?utf-8?B?QzBsVW9ZQkc2bHE3YnVHcmE3Z24rakFER3pqRWdBQW12L1NJY1FRbDVWRnZI?=
 =?utf-8?B?eFFPeDJQS3lVKzVxbHl1eVBYNVMxclNWeWdPNEc5ejk0VkpIejdaYWlPMndF?=
 =?utf-8?B?N3V5SDRiVE5QdUZhUndtSENJdUxiM1IzUWlvVS9FWnluSE9SQTF5TWdrSWND?=
 =?utf-8?B?SmxUblhES0VhTEs2V1VKVTZMZHJNZVdoMXhJRDlia05TWDAzRENaVnNrZXpM?=
 =?utf-8?B?dFNJcjlQTTU5UVl0bVM5KzE4SG9tb1ZaV0l2RllvN1MweDBFQU41dC9XQXdk?=
 =?utf-8?B?OUFXZGUxMjVLYXVhamdQSm9xN1RvWncwQzlzN3Z1a0ZRUmQ4VWw1NFp5NkRN?=
 =?utf-8?B?WDI4VkJzRFM4Mm9iVThMY3RpWWxlS3VIQzVTQ09zMWFoZ0pLNWNHeWxLWDFH?=
 =?utf-8?B?QnZzTVgyc3owM01IVkU4WkpJYldxUWV3ZGNJMEovWkdxTWxhemV6M3ZlUUk2?=
 =?utf-8?B?b2syQWd1YTk4eVVSMjlHQ3RwV25FMDllQmFvbjNYY0FMSGdOdmhJbjdNRGhH?=
 =?utf-8?B?OTd1ZS9iQi9VQ3FpSEo2RlJrRTBaZGwxZDhBN3M4ZUYzTjR3OWJOUUpuZjV1?=
 =?utf-8?Q?ksr9vhsaOdHd5fVUDToCxiqnU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b26904a-79bf-42b0-040b-08ddc4400d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 08:09:13.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yQbefGmLYC0lJrIKbw7xLPRYySuJM7TG30T92/oNPCBuozGInt4mfblu8xJxHjeZAafMFG3Wc6jY/ItyE55J5iG0ToBdLzKjuS77dZo/ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9375
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW2NoYXItbWlzYy1uZXh0IHYyIDEvNV0gbWVpOiBzZXQgcGFyZW50IGZv
ciBjaGFyIGRldmljZQ0KPiANCj4gT24gV2VkLCBKdWwgMTYsIDIwMjUgYXQgMDc6NDQ6MjhBTSAr
MDAwMCwgVXN5c2tpbiwgQWxleGFuZGVyIHdyb3RlOg0KPiA+ID4gU3ViamVjdDogUmU6IFtjaGFy
LW1pc2MtbmV4dCB2MiAxLzVdIG1laTogc2V0IHBhcmVudCBmb3IgY2hhciBkZXZpY2UNCj4gPiA+
DQo+ID4gPiBPbiBNb24sIEp1biAzMCwgMjAyNSBhdCAwMTowMjoxMlBNICswMDAwLCBVc3lza2lu
LCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtjaGFyLW1pc2MtbmV4
dCB2MiAxLzVdIG1laTogc2V0IHBhcmVudCBmb3IgY2hhciBkZXZpY2UNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IE9uIE1vbiwgSnVuIDMwLCAyMDI1IGF0IDEyOjE5OjM4UE0gKzAzMDAsIEFsZXhhbmRl
ciBVc3lza2luDQo+IHdyb3RlOg0KPiA+ID4gPiA+ID4gQ29ubmVjdCBjaGFyIGRldmljZSB0byBw
YXJlbnQgZGV2aWNlIHRvIGF2b2lkDQo+ID4gPiA+ID4gPiBwYXJlbnQgZGV2aWNlIHVubG9hZCB3
aGlsZSBjaGFyIGRldmljZSBpcw0KPiA+ID4gPiA+ID4gc3RpbGwgaGVsZCBvcGVuIGJ5IHVzZXIt
c3BhY2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBObywgdGhhdCdzIG5vdCB3aGF0IGNkZXZfc2V0
X3BhcmVudCgpIGRvZXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjYuMTYtcmMzL3NvdXJjZS9mcy9jaGFyX2Rldi5jI0w1MTENCj4gPiA+ID4g
KiBjZGV2X3NldF9wYXJlbnQoKSBzZXRzIGEgcGFyZW50IGtvYmplY3Qgd2hpY2ggd2lsbCBiZSBy
ZWZlcmVuY2VkDQo+ID4gPiA+ICAqIGFwcHJvcHJpYXRlbHkgc28gdGhlIHBhcmVudCBpcyBub3Qg
ZnJlZWQgYmVmb3JlIHRoZSBjZGV2LiBUaGlzDQo+ID4gPiA+ICAqIHNob3VsZCBiZSBjYWxsZWQg
YmVmb3JlIGNkZXZfYWRkLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlzIHdoYXQgd3JpdHRlbiB0
aGVyZS4gSXMgbXkgaW50ZXJwcmV0YXRpb24gd3Jvbmc/DQo+ID4gPg0KPiA+ID4gSXQgaGFzIG5v
dGhpbmcgdG8gZG8gd2l0aCBhIGNoYXIgZGV2aWNlIGJlaW5nIG9wZW4gb3IgY2xvc2VkIGZyb20N
Cj4gPiA+IHVzZXJzcGFjZSwgaXQgaGFzIHRvIGRlYWwgd2l0aCBwcm9wZXJseSBwbGFjaW5nIHRo
ZSBkZXZpY2UgaW4gdGhlDQo+ID4gPiBrb2JqZWN0IHRyZWUgYW5kIHRoZSBvYmplY3QgcmVmZXJl
bmNlcyBiZWluZyBjb3JyZWN0Lg0KPiA+ID4NCj4gPiA+IFN1cmVseSB0aGUgbWVpIGRldmljZSBo
YWQgdGhpcyBzZXQgdXAgYmVmb3JlLCByaWdodD8gIElmIG5vdCwgaG93IGRpZA0KPiA+ID4gc3lz
ZnMgbG9vayB3aXRoIHRoZXNlIGNoYXIgZGV2aWNlcyB3aXRoIG5vIHJlYWwgcGFyZW50Pw0KPiA+
ID4NCj4gPg0KPiA+IE1laSBkZXZpY2UgbmV2ZXIgaGFkIHRoaXMgc2V0dXAuDQo+IA0KPiBTbyB3
aGF0IGlzIHRoZSAicGFyZW50IiBvZiBhIG1laSBkZXZpY2UgdG9kYXk/DQo+IA0KDQpQQ0kgZGV2
aWNlIGluIENTTUUgY2FzZSBhbmQgYXV4aWxpYXJ5IG9uZSBmb3IgZGlzY3JldGUgZ3JhcGhpY3Mu
DQoNCj4gPiBJJ3ZlIGxvb2tlZCBhdCBvdGhlciBkcml2ZXJzIC0gc29tZSBvZiB0aGVtIGRvIG5v
dCBoYXZlIHRoaXMgc2V0dXAuDQo+IA0KPiBUaGVuIHRoZXkgYXJlIGJyb2tlbiwgZG9uJ3QgY29w
eSB0aGVtIDopDQoNClllcCwgSSdtIHRyeWluZyB0byBmaXggdGhpcyBtZXNzLg0KSSd2ZSBmb3Vu
ZCBhIHdheSB0byB1c2UgZXhpc3RpbmcgbWVpIGNsYXNzIGRldmljZSB0byBhbmNob3IgdGhlIG1l
aV9kZXZpY2UuDQpXaXRoIHRoaXMgd2UgY2FuIHVzZSBtZWkgY2xhc3MgZGV2aWNlIGFzIHBhcmVu
dCBmb3IgdGhlIGNkZXYuDQpQdXNoZWQgdGhlIHNlcmllcyAodjMpLCBsb29raW5nIGZvciByZWFj
dGlvbnMgd2hhdGV2ZXIgdGhpcyBpcyB0aGUgcmlnaHQgd2F5Lg0KDQotIC0gDQpUaGFua3MsDQpT
YXNoYQ0KDQoNCg0KDQo=

