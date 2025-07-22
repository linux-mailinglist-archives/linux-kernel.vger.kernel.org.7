Return-Path: <linux-kernel+bounces-740008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EECEB0CE83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED1B543C96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263F248F55;
	Mon, 21 Jul 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX82xo29"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1041C32
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142396; cv=fail; b=JsOkgkrDjg88qyweRuaT89UdD+zFqt9zmVkZis1ViBCf0PcgER2Fgrp0PRN8IyT46JgzmUOWV8yQHS/KxxkQFX+mDafGnoQsEv3ckhNb88Dc40xXQDLJOVN5s95EEN0+kWfuiyghXj8nSAvYNrNDDmHKQolULnIz+IQ+7Jp4Dk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142396; c=relaxed/simple;
	bh=x4X/8BZsYJ4aixQemGL6bjpohba7m2b4S+kKZjjfePM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jpSfSYtob/YFmIN1/dQ/u9ISjgUiW9qWTFtVF2F/blRJKV/KEjgk7F9a3yvd0Owcp1rmaHlt6Pj8oWViUqsuXvFZ0/me3VBeXkmTiobQfW+NBG5NpfxWnIBVEr3IiRQIjGd5pBQ1H/I/XXWvFGnPdeMAluJhWuMneC1buHyju6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX82xo29; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753142395; x=1784678395;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=x4X/8BZsYJ4aixQemGL6bjpohba7m2b4S+kKZjjfePM=;
  b=OX82xo29jp11UvWNiQq0Qf0B7Q/fmpUxamP6Kf6exqPWXERPJvaRkXF2
   0l2xiC3onikx1SZG+YJSQNWdGszsMy/sOlRznoz7NSHexxtFJ4V9GXGVK
   9hhZ3z/DCDDWxnnN91pBKTpCDyX+4i9URbV8viAJ9iJ3HUG+jLlJ1yYXq
   tHIOVZgnSUuqXo8GNyTcKnfKLIeMNcmt+/8sshuyQKeUOBbTYbiNa6UqL
   eTeUcDDCAXkb8ckTCvObfxCU3J8/Lyknv+HjtNUeprjyYsUpVUYTxMnJ3
   XSrNzFn2v8XcOm/BPHsL1bwo9kFrvQlqSf/BMr1/gBM9wjKeTbGY4FbOj
   w==;
X-CSE-ConnectionGUID: sQ+RXbgXSmuixM27T5Dauw==
X-CSE-MsgGUID: UXlqbUFlSuy5N+34uQOBlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66720300"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66720300"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:59:53 -0700
X-CSE-ConnectionGUID: pTA+OcgeS72x6xqKjh7YEA==
X-CSE-MsgGUID: XeEEyhyFTziPNvrjcrblPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="158640937"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:59:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:59:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:59:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:59:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukaBBFOSBQlEm7G95MYrq5Ie752cj2Ip3Oh0Wz7F4QyYg331aooxe2KX2tTrhTcUiJA66FFPJaxAw0cQG1rd7De3WhGj3KGA1ujLFTMXa60x7LSudj8ukWc+eDoOH8g/H0IWd3da90Z2hgOqTG8nJIb/SF1tu3NunXiGS7U4sZ/Y57DvGR+I5HA9wf5jClxXqUQpA8lN9YB8gQ/Hy7pjpj09CDGOJiMmEyLj+Q9K4m3HxcKkC9SspWmi+bfEPkK0DadCrugoPXtjFIwgIxT1TUHOC8dPm71yjw/uDjpRsYLXUS0/Wd64Uy8ijV1bj5frdyy3/FPHlqqAmXl7x9NybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdavedLN4Y4BbBXWw2MmSz3FAnWSWS8uQZVm1EyMP8E=;
 b=G3xv/Rqj601iQ+vB8ZXQYymRJGztOUI2UT0cRD4hPm7tmp06req7geXOXNuXx+z4edSqgP5aFj6v0GOEtbcsKKhLIdh+/f4jKHv9Hz74JYTqsoEjjt84ubpijY0kIrriPwcxCKobS39W0KIn2clMR0FmsYFKYnk9r7HrqswWvMPI1MPPIZf8DHMm9k1ojR8hIZgGk1pwRseLsefDjM635ADHqQX7zFgCZEC0Qrgn9Fu5WMPap6D9fuTWkVv+vXA5QEeCAWrCLNu1dy28HRn6PkB5dBjskNEhvHcXI4vC/P2dWUt2wx8YRa78TLZl9DwdzltIlP44bAJBYuvGBAbMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6527.namprd11.prod.outlook.com (2603:10b6:8:8e::19) by
 PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Mon, 21 Jul
 2025 23:59:34 +0000
Received: from DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::5a48:57be:974b:8ee0]) by DM4PR11MB6527.namprd11.prod.outlook.com
 ([fe80::5a48:57be:974b:8ee0%7]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 23:59:34 +0000
Date: Mon, 21 Jul 2025 17:01:20 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Francois Dugast <francois.dugast@intel.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
Message-ID: <aH7U0LVBf0NqCrWK@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
 <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
 <aH4nibzGVLiPE5-4@fdugast-desk>
 <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DM4PR11MB6527.namprd11.prod.outlook.com
 (2603:10b6:8:8e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6527:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 01940508-78bd-40fe-bae8-08ddc8b2a455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7fpMtS70y0Yj7gmVsdYGLO+UIl8nbN9ZWtMSumBVgM1SF7+rTLNONsQR4l?=
 =?iso-8859-1?Q?7xafeIY74WVyzCYFvuREh0DKhEYc2Lts14Kx6CM6mKB9g2mAlJEpLuR9PW?=
 =?iso-8859-1?Q?ZZwWL7U/eo8I800FtwQEdJjP+2FhWwswsRAHHZnB0UOZNp5MyC4zfLnxGu?=
 =?iso-8859-1?Q?jD8XEX5moXm8YynVrqOocFkfYa2dvhO4Q39R8dk6jVtQ6LbqxT/aGUaCXW?=
 =?iso-8859-1?Q?m+W4KgfjmJixgitvfooJMWjqVmyzYqnZ9+KD2bKTOOu0tt6ME8ZsjkF020?=
 =?iso-8859-1?Q?oFZ5HKUdEKgdhKii0iRQKmVgC/hQl0qU/sWYlRdWpaEBNGFFvmkmvw0ZwA?=
 =?iso-8859-1?Q?9bVT6WveKXYAo6zPYgQ6j3LzoR6gcif+d27DSrIR2tUHS7V7WyAd+eA8Nc?=
 =?iso-8859-1?Q?R09JUmg3sWITLXt9iaoJKD8+cky1fOYqPOftzHr81yXSxG7JC/Jj49376j?=
 =?iso-8859-1?Q?HYxu8n94EZdQMi9NibsXceDwmmNsvCEKf4VL6KIN3eZMoYKpy0wKRBZ2Ny?=
 =?iso-8859-1?Q?2REJsfGg1Y0JEO8XKmD+35HX1TH9fF/ODZ6eJYq+ljIfaFmJGRq3FuaXCH?=
 =?iso-8859-1?Q?Fvv9QDs58+7e4QL0pm/8tIATr1TTrF6efAI2yDitgi4mNLsG7ueQO/0Koa?=
 =?iso-8859-1?Q?zH+uf9KKHaoze2Vor4TP0bUBV7ho2CvHMoTGGS+sRzQoYMLiExaBakaQa0?=
 =?iso-8859-1?Q?qCzCfnKsdJ1tcrAx3LDwXZmCiTeEYF8N50cFf+1wCxznzOIdXQ33rBHKNv?=
 =?iso-8859-1?Q?4GraBFnGDftIlsZEeFZrtRqiM1GiXPeqf+GqNWpRaKY+y1tHt3qw9kDyuW?=
 =?iso-8859-1?Q?aDFmlYiYMhRZ8MgOl2a+QYrYeRWEuIfc+RTXIL2oOte3gVWesTpUzVUFx9?=
 =?iso-8859-1?Q?d08ynyTOAqbC3HYhoxvyQ9Qii9zNjuDrggk4AoQBPsb9BWuHPX5WczbA/n?=
 =?iso-8859-1?Q?bKQj8wKDd+sErv9C/I7RVYa7QgpPersoPtCnZLY0DQVj/7auQ5RfxDlXFn?=
 =?iso-8859-1?Q?aGyThfiUr5fMngYCpZkNgSAXAdagtvk1z6YPz+GJ3gFZc1n/6xTK6tE3LL?=
 =?iso-8859-1?Q?WcHkTngpqL8e2jwigrUezp0QXXQVI9nCIb5SDWIWyOeh7nzUorbVwWUaPe?=
 =?iso-8859-1?Q?BKKwjNu6xqsvlQk/PRXG4YZRERE5TfbnlShyXG6HfiX/wmfS51vWAXzle5?=
 =?iso-8859-1?Q?4IQgJed1aY58Lc0lAis9YPpf311Xmz5BrVAVTrBcQqvEG6qieD7qiP9Txx?=
 =?iso-8859-1?Q?vR9iCi3+gBNJ84Mv7TVuSSYoPdw2UlDGrZqYgEMck5XP/HgPXQhiVqkytk?=
 =?iso-8859-1?Q?BfpsHS1cSJuFJv30DXxhXSQIYZf/5MCdXcXDq4pRiCFxcea+iLOmgoiHTZ?=
 =?iso-8859-1?Q?8lhbx+5+Yoo0sIzesEJ9oUs0Q3PWPCcaX35kwVxJTPzHjZ5/PzMqBBB6bw?=
 =?iso-8859-1?Q?e8oHN+pI/e93q33ouGBlwYobhW/neuaMyqZgEA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zzBZt/WEEuqw9KPxxqsvcHlYIF9iJiBet5tSnkaDSukQ//hWrrJBr8xMP0?=
 =?iso-8859-1?Q?9tBPgaq+CN7EvpcE+k9GW7CAtngX+hfvUJoTdxFWLanD2WkQjy3isSwA4X?=
 =?iso-8859-1?Q?9W2frOq2B+DbWAAqvxqCBXBk1FXQ+t9x3GL38JcB72KTwdqteKMQ2ErUb9?=
 =?iso-8859-1?Q?aB/YO6x8sDX5/0iJYUr1bkevc2OkqtwhoPsPvT8i77d7mbWIyEebyTHD1P?=
 =?iso-8859-1?Q?uvMGNzYalPRHSxhJ5aSYJC9wYDanES78fzCGeCdi0ya1dnliO9PXKPgqCB?=
 =?iso-8859-1?Q?4ag9PQ0Uw41cvDvGPjFpOMrckFJKmb7psO9ZzhV6FrvlFecKz5yqRzC/Mn?=
 =?iso-8859-1?Q?JqhFZt2hZczCiVOpS0y+TnzHHOEhrZpXkRDJxpW2KllBLYswRO8JG3kQs5?=
 =?iso-8859-1?Q?WHqyu1HfNbcXfwmHA9W/FG254LJSXpoPNc+uHSqPRwaXNHPHN6pFWZw4P4?=
 =?iso-8859-1?Q?iUIJfMCRCGb1ExYfStKDX0UxlmgbaWEvHaxjW7b1yQJ6fFsMLpmaI4fbOu?=
 =?iso-8859-1?Q?A5UAlRMEDzP+AQuaZMN1Ib2yGJ1Q1YTbFMUVEEadqtOu+i8ozdhQmmfsnO?=
 =?iso-8859-1?Q?Z23hlquPAdNOfOJyPIb0emmvuez79p3K0lI46k1pq5QJeXv0wvdd/hfuyb?=
 =?iso-8859-1?Q?MG+Ean59bj9vrNhEAzbhKboqiMs1Cgrhrp1vSMk4OUN6363E1ZVDCG+/O+?=
 =?iso-8859-1?Q?m5Y+IBz15Tx9ocEgpIK5Lw6jskTeiw6a8LAfID8QArNZWHgupjxA1dTCiu?=
 =?iso-8859-1?Q?gJDnlsD7GQrLc0IgcSMzeGNb9mpvNLb92CnLBnI80L/5UYAI4ptmTgFGv5?=
 =?iso-8859-1?Q?XxL+a+xqAoUQffiV8at44iENdMwy/N5a8ox3hKpgOBV7NBPryk+urCiMOh?=
 =?iso-8859-1?Q?NcIrbB3ALvVI0YtaG8MosDOXZgLHOCmCaztTDfFgJuQHJ1MQsXxDX8EqJ8?=
 =?iso-8859-1?Q?Rq/7mECwugG9CjPK5ZSFMT0VCrBaj/ag6ia/U1a5pioh8PxrO8kY0p+i6p?=
 =?iso-8859-1?Q?cjexFXiyFcVdvKG0yRbVQjDouWGgLtBVZxcqDB5VW3PNsxfzQoJrB2KXtG?=
 =?iso-8859-1?Q?iuAcIEmGBkMcY4Il4FmdqJnB+G6L8tU7lBa9GgECAUFab8MmaOOXv5n8OT?=
 =?iso-8859-1?Q?pllr9DrbksMRNzUW2JU9Wr7a5BIOen70oJj+6JgOzTof5rJiOIJljsIErV?=
 =?iso-8859-1?Q?RRop5orhTqxpX8sa25iodrZn8r0LvyuwyYxj7+vCiir9Ti78TQIf01B63N?=
 =?iso-8859-1?Q?BOw913mKwRGbRmMOKX/KMhHit/ifgZKsGybhZajbgv4/HI5dY6SJaSC++6?=
 =?iso-8859-1?Q?zoPQElE/8joZlg/ClvW8iNXqlk55gqQ9lFJ0djIqp5gUztrdtUXPlkIm48?=
 =?iso-8859-1?Q?i4w/3BoiWqH9AV/miEE0HKU+/wcqFx/YyaIEWTQLq06NahE7AQiXhBH36f?=
 =?iso-8859-1?Q?8CnIrzXDE1Ei2FFUu704qR5Pu8+YN6rRSUON7NB+8NbEN7+aQZm1ttPEjX?=
 =?iso-8859-1?Q?tgZKyc0cWfS1GXemaL6DGdC89a4XMPA6HuKGn/45z7TlmAk8bC7F/jQOXA?=
 =?iso-8859-1?Q?4CBn/PExbNDyv+gCnV1QdAAU1lAhd1XJdUGfkuE/9LUy5vSx4bxLj4ThuW?=
 =?iso-8859-1?Q?S0m3q1lwwckRzX3M2PbhRNFWVnFN52u1cYPFCF3yDvqI3/J9SclvJTGg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01940508-78bd-40fe-bae8-08ddc8b2a455
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:59:34.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxvnrHe64a2qPRXSMzVNGCh2YJ5ScPiOwHCKLE/LROMgZJZPUVjJszpPOcnAZUw8fRN6Xa1tiQA8rUerg9WcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
X-OriginatorOrg: intel.com

On Tue, Jul 22, 2025 at 09:34:13AM +1000, Balbir Singh wrote:
> On 7/21/25 21:42, Francois Dugast wrote:
> > On Fri, Jul 18, 2025 at 01:57:13PM +1000, Balbir Singh wrote:
> >> On 7/18/25 09:40, Matthew Brost wrote:
> >>> On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
> >> ...
> >>>>
> >>>> The nouveau dmem code has been enhanced to use the new THP migration
> >>>> capability.
> >>>>
> >>>> Feedback from the RFC [2]:
> >>>>
> >>>
> >>> Thanks for the patches, results look very promising. I wanted to give
> >>> some quick feedback:
> >>>
> >>
> >> Are you seeing improvements with the patchset?
> >>
> >>> - You appear to have missed updating hmm_range_fault, specifically
> >>> hmm_vma_handle_pmd, to check for device-private entries and populate the
> >>> HMM PFNs accordingly. My colleague François has a fix for this if you're
> >>> interested.
> >>>
> >>
> >> Sure, please feel free to post them. 
> > 
> > Hi Balbir,
> > 
> > It seems we are missing this special handling in in hmm_vma_walk_pmd():
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index f2415b4b2cdd..449025f72b2f 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -355,6 +355,27 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >         }
> >  
> >         if (!pmd_present(pmd)) {
> > +               swp_entry_t entry = pmd_to_swp_entry(pmd);
> > +
> > +               /*
> > +                * Don't fault in device private pages owned by the caller,
> > +                * just report the PFNs.
> > +                */
> > +               if (is_device_private_entry(entry) &&
> > +                   pfn_swap_entry_folio(entry)->pgmap->owner ==
> > +                   range->dev_private_owner) {
> > +                       unsigned long cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
> > +                       unsigned long pfn = swp_offset_pfn(entry);
> > +                       unsigned long i;
> > +
> > +                       for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> > +                               hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> > +                               hmm_pfns[i] |= pfn | cpu_flags;
> 
> Won't we use hmm_pfn_to_map_order(), do we still need to populate each entry in the hmm_pfns[i]?
> 

I had the same question. hmm_vma_handle_pmd populates subsequent PFNs as
well, but this seems unnecessary. I removed both of these cases and my
code still worked. However, I haven't audited all kernel callers to
ensure this doesn't cause issues elsewhere.

Matt

> > +                       }
> > +
> > +                       return 0;
> > +               }
> > +
> 
> Thanks for the patch! If you could send it with a full sign-off, I can add it to my series while
> posting
> 
> Balbir Singh
> 
> 

