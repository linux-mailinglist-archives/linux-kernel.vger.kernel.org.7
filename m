Return-Path: <linux-kernel+bounces-879428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87409C23153
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A8E422CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C230CDB0;
	Fri, 31 Oct 2025 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zwqt4hlI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE328A3F2
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879235; cv=fail; b=DBya05j8EmRVc+31xdW25mJJzSYXSHBRQdZ/WK6Mc7OpFPHc9FieYiyC1jxto4wKVvD4g4nGYqrPVi428dDFk66VG1MeuRrOuWRu/JKbcmmuUErUu5C+sWgGMhBTsBjCIIlPt+uW8LyajHXwyRgxG7cjl9dk05l3g7CDhOt+gLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879235; c=relaxed/simple;
	bh=w/lAD/MgKqgg3TauLViGuC14EarKb23spljOgewBiH8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TcsQZQUWNN1KlDhM6ADWMXsZvFQK3YgChg6smcUEcySB7bVgDoKrYrGg9nGSfAfdTmZpLRmFbrF6YfR56hasaar3jP0gHrDYq1NLVOiRsZCcwzNlPeVM2uzDGEQg0CwMGPkz6R6Zojxt/oU96oLBYSCOXbL8grgq+PzUPNRzd1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zwqt4hlI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761879234; x=1793415234;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w/lAD/MgKqgg3TauLViGuC14EarKb23spljOgewBiH8=;
  b=Zwqt4hlI7s5Bb04PBGd3OyZN+aPUUchuIJL1jj7MLirTtA9CW0XaLhfe
   HvS0HZ1Gv+BVyLNEoj6HvsEEDLDFeEjPnNuDztrFpd8X0Ss3Yvwlpitju
   cy3K5ZFZBLvYUvcq5mpHVVLw7y+5CQifAZwpm2LVU3s4FEcpzEN2TSoJr
   h+wuTsgqf1bw9X2iVOhIMXsDiPpevYh6J5UZe1uoOsBuEqhm9c9BYVCju
   yHBcJhdVAPtkXKIRkZ7YsIVHdLUIt36/o9/JLEFfwtvnDdYwJaL/aBkj9
   Z2WNMpsEO4GPahFptZ72STFXEnOZSko+TnysJJ5QS9JqTb2xSfrG3Eay8
   Q==;
X-CSE-ConnectionGUID: 1Q1GryhFRZexcz1SaF9sUA==
X-CSE-MsgGUID: /DqALfvGTXCs7vcOquyBpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63947072"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="63947072"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:53:53 -0700
X-CSE-ConnectionGUID: zsoal2XsQ8m2oI3dGxbsxw==
X-CSE-MsgGUID: TA0Zr8KaT/GRtXDk+W7ghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="191267372"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 19:53:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 19:53:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 19:53:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 19:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+wlajRaeGoIpjoZgMq8Z6y/ZcGB8NhQttrDLPJjby838sGBF+0Tm8Dw0jP/bgeoq/qQIl8E22BcqBz+mOXmYOI94WbLgU8p5o/0eS27IKGtuWiZ/eeAjFqnS28uGMWif6FNHmFmEIsmqooJiccjwWShRlCDh6pbzvIfzu42IaFz9j4aXiM+/cC2BIwpaorwNrU1nUgMGyMGFSvFmytm299QGs4oS8F3EFalTWcyTh3lq4EyvPXID4mld/tbsAejO9mrrie6QZUMIO4dQkYQ16X+Zby6rsKBQSMAwwkXcRVNoVH3+YK2IQxAfJzNW+1symR+2hbtzY+MGs7h7U+0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4/tghSe3Q9AlaB0hYiBmC/XZ96WghUEQgvzba7uALg=;
 b=JJshwcmoJvrxw5h5WoqnIgz8U4r4aRWyRvqxp5r1s2ZU/HMzoddB0dFNZ4NHnTBJdbph6eCo1pb/3WjgHIFUPGdoyeVH9UOd4jEySG572fK++/tW++XrTwhVSe4Jsu+koHRbc/G2xc3wNcyCkIKAqMgBGTimz2ZIqGHaCQT+i5aBsrCHKhFlBKaI/XiTGnTphjKgx9oDT56Q2jT35xKdJUDrvHz4wPymzxh6EFLku/zOZ4NXchbhOREmGR6Z0FD8HRBW16GTDH1tcDbPLv/FybFIFgGdcgcFiQUmTUZZdYzv9S0oK23drYTaQyG54OHRC4bSF6HWmgmcj1lKD1+RKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB6172.namprd11.prod.outlook.com (2603:10b6:208:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 02:53:49 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 02:53:49 +0000
Date: Fri, 31 Oct 2025 10:53:35 +0800
From: Chao Gao <chao.gao@intel.com>
To: Vishal Annapurve <vannapurve@google.com>
CC: Sean Christopherson <seanjc@google.com>, <dan.j.williams@intel.com>,
	"Erdem Aktas" <erdemaktas@google.com>, Dave Hansen <dave.hansen@intel.com>,
	"Elena Reshetova" <elena.reshetova@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Reinette
 Chatre" <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A. Shutemov" <kas@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v2 00/21] Runtime TDX Module update support
Message-ID: <aQQkrx2hXkPdcifr@intel.com>
References: <68fe92d8eef5f_10e210057@dwillia2-mobl4.notmuch>
 <CAGtprH8g5212M26HPneyaHPq8VKS=x4TU4Q4vbDZqt_gYLO=TA@mail.gmail.com>
 <68ffbfb53f8b5_10e210078@dwillia2-mobl4.notmuch>
 <CAGtprH-rv9T1ano+ti=3eU4FO2APCOcR06buPALggAwUnka3Dg@mail.gmail.com>
 <690026ac52509_10e2100cd@dwillia2-mobl4.notmuch>
 <CAAYXXYyVC0Sm+1PBw=xoYNDV7aa54c_6KTGjMdwVaBAJOd8Hpw@mail.gmail.com>
 <aQFmOZCdw64z14cJ@google.com>
 <6901792e39d13_10e9100ed@dwillia2-mobl4.notmuch>
 <aQIbM5m09G0FYTzE@google.com>
 <CAGtprH_oR44Vx9Z0cfxvq5-QbyLmy_+Gn3tWm3wzHPmC1nC0eg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGtprH_oR44Vx9Z0cfxvq5-QbyLmy_+Gn3tWm3wzHPmC1nC0eg@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bd5e91-ecc1-4464-acf4-08de1828b7b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YA7VTk/TaWEM1rF2wjYS/FpdHieiIWhRzjMv/uCTiR7m9fmOcCr9YOxKf8Sf?=
 =?us-ascii?Q?YAWVmNQDcesc1i3FmsCi3VVrORiJJDrskwZYs/lkcSuLwCsaGLMYUsgk3vhu?=
 =?us-ascii?Q?mtvorVA1+uJneK/G22UuASUXfAOEFuNNYRQLJvHET7ur+iRezdRoCd8f3Os2?=
 =?us-ascii?Q?2B3u4kfCn4NVrSDeV9Ds7FXa/UpMLgxZFGdgb8WuZ6ClFaVYzM+O0U7DKcfG?=
 =?us-ascii?Q?ldaMgOd309m+2+B9v3V9akF+WLoYbPX2moq0E4VBKK6/EjRimTLgCcvqvDu1?=
 =?us-ascii?Q?WMIcuHLvbo0fZQr1fOvA8BSAdlrzHTUbd2HQDAN6PRisCH1oMIRVa/VkfbU5?=
 =?us-ascii?Q?Jehh4cv6/BIX7eEWG0ZH+lju4UbIun1XvI3W34/PFehzuxD1mt7ssdhXg+TA?=
 =?us-ascii?Q?PqkyF9nxLKt/qw7DC2NACB/3KzPWGh63ybdpL1D6UUSecly1Sm5IRLH4o7Qr?=
 =?us-ascii?Q?YdSes+16gHb1NDQVvdZaaqhidgNMaVIlvrWPiZW7NEw0s+2X7S3SbC2OmoVA?=
 =?us-ascii?Q?fu1UbQXMDDSAll7zAHJAcaRorm3PLQ2goJtPR5/D9NbnE4Lk91DDQRGGN2vW?=
 =?us-ascii?Q?nhAGVE1Vllshzcc2jTAnkXYwDFO0kll/OuduCK5u6PjaqVoExHiV7lL9OKCX?=
 =?us-ascii?Q?HWoqsiwPFRmbLQBWKBw8mOnPd5YeCKO2TGnhTZF/RmJVK0xti5fwGrWYYlP4?=
 =?us-ascii?Q?j67Wkdnnn3DpQt+U3LJSOluwAIjjl1EEBKsndO8Qwo7fFhJf9zZJ7cB8mlLU?=
 =?us-ascii?Q?0ihqWh209pneIdZ0QMVm74FzsTBvTfWMpehpt7oLt60KVY6Gk3jrxmRQB/iO?=
 =?us-ascii?Q?TbOl3DEwVFBD9mhutNv1GZ6uI8zkuWelqDrm7HvsOn23PnfhdsxdU1nUlMY9?=
 =?us-ascii?Q?3KSYftYNEgWrAvuCVSPzEXBFFd8rZoOU6BBcgvkiKENILa9jzzJ2EIGJLuK6?=
 =?us-ascii?Q?f1eWgS2K4Od/v1tZBKPEhMq1NeIGg3rTafkXpFEfXmOsyw8y03X1LBxhSXdy?=
 =?us-ascii?Q?Fv8DyEzVk+YyAvpyF5Jjn3MooUr0z5VEMXUfHxFZP8FY0ZeejvZ6oBR8zNfp?=
 =?us-ascii?Q?N6THPwkEdXvzZTgC9PoWIAqF5dRhNiH3x753YEBDIidWqoIqHJPGAOx0MGMp?=
 =?us-ascii?Q?EjMPV8SnR0/jseXcWdkP2f9joVSO57hxJT/jpGyupLUae213FZQ5pSwOpCF7?=
 =?us-ascii?Q?i4HUdj6ynwvRtCNlnqmRZXyWVJlgo7whELvn/95bU3zkzWgVtS+4ScAiZcns?=
 =?us-ascii?Q?E37qwo//yF6NJ3bVPx5p7PNkxqjzdQvWHoFCGplGfP9wR6hI5cJzEYbpiwZr?=
 =?us-ascii?Q?DEO+YJ8HuKJWu6l5pOjfPDQz0PGKy82MWQ3PCez5/53ihBhNMLUQKevzcIoU?=
 =?us-ascii?Q?eM9SHett4+cP4XZFW5VVLhe16UqljdTZ6/EG/+2Lq4GupeSYfj4XnMbUrlZ+?=
 =?us-ascii?Q?+tUXWIKO9IFq4VirchlZ+p11yKjPryophyfjNOdzDvuFcy+d7t1ApA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygyDBIftU6fiKciI1fRTHndw3aUaSbpgpjj9Z4TZXAh4UkH1Nqu2UW6NYTY0?=
 =?us-ascii?Q?9b/Y4mdKG3xPkwA4ljSOEuxbvcFM9MLIeXFa9mhI9NncyCWeUFn9KDh9aJgn?=
 =?us-ascii?Q?eCs4yyAUSAQUivuTA7M5xwY+NboI2Tj09J0ngBtgi1731bkB8GbX/fU0fRDT?=
 =?us-ascii?Q?hFdGlby1srKavMtd2bgt8SF2mhBcLV4u5oSYEl5db/ne/H2VUOlDYurcW+h+?=
 =?us-ascii?Q?y7m8aylua5ntWxjHm68TEaxev+y3x1VVu6VHpHNEU9co0QLCM9YI5CvafqGw?=
 =?us-ascii?Q?KOn685TVVeDhVpxdulpB9fNs6e2EIO7b6R2GPnc5wXltKrmv+MWWAIwzcIs0?=
 =?us-ascii?Q?yC26P/398bCpq9uGlZGOPkmGPyFXto4ay7HUjARQb9aTh0X/gcS+HQnAbhQ4?=
 =?us-ascii?Q?ggGKQm9R2klevFzL52soOoMgt87vGaR2RTfXtFyQJDTKflEbZdLFFTOLqXPP?=
 =?us-ascii?Q?ZgdXFzwM9b4cET07HuUN+Rq66hiaIDTNonT0Xy8BLZUGwOR84uS+6fIg3/6n?=
 =?us-ascii?Q?Egzl4We12RPmOkpV2t68Ckgh4HH7I8XfI55WK0Ssl0p+LIMTJsZOii/eWtn2?=
 =?us-ascii?Q?5PrSMqMSsRuaewK+kqOCv3MbuODJ9F9rHF4jhqBlHZ8HPeVN9e7xNHw1Nx4U?=
 =?us-ascii?Q?EjjwUShyUzLCeLXNx9wY6x88ryDU0UtSXx5gQ2hdmK91gOOF7D+hHb4rJawM?=
 =?us-ascii?Q?YipkfAdSrQSLQVbIFhwZ7irCLb2wLqfmabq7n5+hGyVmMZU6yOyzEcfsT81X?=
 =?us-ascii?Q?RQs1ZTbndY0N4L+m/HcjxQwO+xxA2x8xLDwbiWQ+BTRqQyB3jj6LW7aQrcfV?=
 =?us-ascii?Q?fq/RqivcVYFkSKky36evujWo8xzQZQP46zxkjxQutkPiGa+hPBq6w8BhJasj?=
 =?us-ascii?Q?wuqOg1ljuzCR4H5fONoG/CgBJOSTM3Baiyt/PuxUNBJbPr2lLB+u/uawSSf6?=
 =?us-ascii?Q?U4ikomBgUCJyIzeOMPqGzJNjIV8FU9gYUsYJFm3mGMy7OSDJxjGZq5aFzQF/?=
 =?us-ascii?Q?C4pkUfrR7Iy9uNDIi1dMIhn+Ki/ur3Oi+bhVUbfBJBeVEVlfmdi4vLegy7T4?=
 =?us-ascii?Q?uA1TSblme6eI1EhyTzN/jbiSbnNdrkPYiP0tmsH2D38q1Om85H6d8mVCLoPH?=
 =?us-ascii?Q?UfvmwCndz/Q9aAhrdj24J50LU9p4Ljy4QpFmWrGljab8LGXZN8ePCp8UjWgc?=
 =?us-ascii?Q?1tJODLxop5BDNBXfwEqoivrAlZRSyy7i4FxYiODZbwUMTf8rEPdTnLhXPiyg?=
 =?us-ascii?Q?xYytJT+aCYHtLvhv91DLqG1CSbTWY0qS3uc9J/g5NggGnKoMTvxYSEo6LcEn?=
 =?us-ascii?Q?FiCZtfdSJYi8+4Sx6fwEBMjcE4dCzC7UV0r2HdCzRNWundsCP/ct4Q6FVETo?=
 =?us-ascii?Q?QNBFAiWIRW/aiJr9p5wW2L3nhQ6y/G8JLVSWjWh63HsdxZr/Fver+Jpv6z3N?=
 =?us-ascii?Q?mBBGnc0visEVmcbtJmMc6L/g3oehrOuiTLpYOD/Zfl8Oslw093Xf914rOfTg?=
 =?us-ascii?Q?dNqHYcUk1+fQXoT60vMhHviegAIox4YKm21hfhETU2XEM6fmsc1B9c9xDJmf?=
 =?us-ascii?Q?xUZBzWSScZwGoui1RGs+ypCGo8ZO2jGKUlXIDn3V?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bd5e91-ecc1-4464-acf4-08de1828b7b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:53:49.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ3l+Iuzl+caRxy3q3IY2VfIe+yDiaSbfAfEYG5nbCMoJAPfteU9NbjumYG6wPSbnzTqSyC2R+Fhr4CiUPsG/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6172
X-OriginatorOrg: intel.com

>A reference patch we tested for "Avoid updates during update-sensitive
>times" and one caveat was that
>/sys/devices/virtual/tdx/tdx_tsm/version was not available post update
>failure until a subsequent successful update:

I also tested this. It works well to prevent updates during TD build, so,

  Tested-by: Chao Gao <chao.gao@intel.com>

And I can integrate this change into my next version if you don't object.

Regarding the caveat, could you check if the diff [*] I posted earlier this
week can fix it?

[1]: https://lore.kernel.org/linux-coco/aQAwRrvYMcaMsu02@intel.com/

