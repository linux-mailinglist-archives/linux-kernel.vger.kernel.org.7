Return-Path: <linux-kernel+bounces-778972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FDB2ED61
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961661BC7852
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACC22A4F1;
	Thu, 21 Aug 2025 05:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLW+kJH4"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548313C17;
	Thu, 21 Aug 2025 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755752567; cv=fail; b=O2f7zehSK4uDmL+5Th/tpX5mfURGpiqTM3Ee8ZjgRIqYuwZku0SClYS6vG9DB/GcCDPCFry4Q5Fy8hGOPmVDphQSTTUE4m6dB7qystLbKw1Yledu7usujvHJHVNnKx/FJW9hP9UYQmc2yQ0W09hjnv8QkjpZqo7OQnTdySwNwsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755752567; c=relaxed/simple;
	bh=Am/cSzEqTXdkcX9IhApCpqFyOoXL/LvsnQMZKOeU+vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P/kRCZRT/wseyPMHyAG3QsPNdzqskvtRaD5gD2d+KE1IVB552LmhUzWU0VUEOe68Z+wOpdniqeofIpom/tH1hpK1D01W++X8YlJtxaj/BxzmWluW5iA6YxOv6eoDg6WvvtXGn+gqu8S9HEjQpMC+OJhbhiBCswf8xzefJLr9fac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KLW+kJH4; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhapJnVeQWqH9xpvlAxsracnbw7Euv5m2SZdaRqRfWBiwTk+H6PsI/81WW1hocP8OfnLkRBY/vn3SjW0CrYgAg4RpC6CGkjs0dIJXmyVbMkj0+J8wkuyMdlzuUv+Vz4uToK6yMlQvTE3maQmX6aQzw2YWpjcbfGmar3eOeZnFnG+fORzPXw0duRLKJkH6w/vw+7ybXNqVw9A4tMDJiY1HFrEEH1b2VJWeIpjn5EjAT/Y6HNeDam8o9zO81QM4GnyHxxnJKGELGtuB943dQLJBf9jJrezIPE1XkZqBmla35+EME4jSOuwZ6AVfYP4sR+kOcGXO7QW4vk9diVwKezwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZnrdlBj9BP4ycin2RIrw+VvCYI8Mc+XU2LvJ+f2GmE=;
 b=yxRbrFFN3CVAAJuudtnPdYw2HmHceDJUhJxVfjQexEfXCglBih3y0tm/mc8ywKETecqcuK28RULBR0LlQP9wGvYMQFFdy3o4K8/wjB+N08RzseEefVEo+kh3a4knm4InZjCApNiInQvnWNBNqAqT13lt7EBi9hlbj99uBs6PQoIWqlb0BqWpdDIpoGpOPfk8ao/GdP+cezqNOZg01XD4rJtjUfmncplXF2qQU5vAaQXwB6DcAnGP4+396VJWPs1UpuS8m3D6iyRUJD2mHJpYxWEF+YBj8rCMnX5kGqaskjRhStKcod6+hs8NsaManLUTSLOhr5D0nTpg8xa+mDA/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZnrdlBj9BP4ycin2RIrw+VvCYI8Mc+XU2LvJ+f2GmE=;
 b=KLW+kJH4+02dZ2bzJLdOiLixhmxFWyE8fFWlsVoZZwjLbtgi/hjPAM/QZcvfdCJSW9lqC3ZNU416BMwG5BOP6Hx1FV+ziojMO/i06C2bpxM8fDW9nEyHD6l5rY/EWxj4a0OfzxYMivNdeK3bIT5vibT4xJldyGJ89OcCWTpDpiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.21; Thu, 21 Aug 2025 05:02:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 05:02:43 +0000
Date: Thu, 21 Aug 2025 10:32:25 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
	Dave.Martin@arm.com, james.morse@arm.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
	paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
	david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
	thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
	yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
	me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
	ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
	andrew.cooper3@citrix.com, perry.yuan@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	manali.shukla@amd.com
Subject: Re: [PATCH v8 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
Message-ID: <aKaoYYm1ixYkVtyV@BLRRASHENOY1.amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
 <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53db5c6dd7d0580c0cb1f252d947357d097842b.1754436586.git.babu.moger@amd.com>
X-ClientProxiedBy: PN2PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::32) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fde589e-ed2a-4b3d-ed79-08dde06ff62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jN3SdrTfYBH5A671vgnPydZeErd/lLJVzm6hUFvQe96I3OOSQJ/nfX7G8zRq?=
 =?us-ascii?Q?of7XxrzTini9X3TSZeWXPb4lYTGTlJBsQVIBj0uHtRi2FJoh6XoNq06WWZVW?=
 =?us-ascii?Q?nZYb3MN6lc7rnPH1IAtgP1OL7WvNuEg1hQAwmYDARAVQlH+qmeORqo4Ka3HE?=
 =?us-ascii?Q?Ny5RWddDuulq6QVoUEFkDQyTTjAySiEsDy4x9+YPI8mDJAfr/kk9O6yYUxKW?=
 =?us-ascii?Q?55IK5ZzpFtpLtcwV2ko9OS78NFFNBfDYyti7ZbJDiu+950sD+nZAeprCgKKR?=
 =?us-ascii?Q?i1+n9sWfLcvdXN/x3pOtI8fVbjNDh4nVcYocSbNzu+LMDvTSOfFtundS//jn?=
 =?us-ascii?Q?9i87h6pSWRZc4F0arQgZ7oGhmPjN9eXH2W2c2Tr4HjDWoNsWl/JcPRzV4ARW?=
 =?us-ascii?Q?fvdKzwpL753AzuQPmob7xLdsigK5Hu0uGewtNK0RthCm2/jk9ZUZvSFksiEF?=
 =?us-ascii?Q?4LtIN/FI0OhHt91AeLz1uYQOTVBh5hEfkUlPFRPY+Ycl2JsrcEPnG5hw/Scx?=
 =?us-ascii?Q?sub+ZGfT4V7ss9ovPOI9mzyj9wHCkW0Sc2USOZhlHPmZJmTWC2+dgKWLfyyM?=
 =?us-ascii?Q?1GsNUeCqj8+J2Wh6eHM0vIjcv38bSJoMagn1zhrfHkzjN8mfuOmwrx0Vp48u?=
 =?us-ascii?Q?sk30qHx3dV9OyFh8dP/tvnpDoHGtieSr0zw+i0gEe5KGhH3VgGx1vCVDC4Mz?=
 =?us-ascii?Q?RgIyl0ydPpt3gfpWnW720Oh8HmC8QSsR8i7oL5BARgILZuiTLt59ugupqKY9?=
 =?us-ascii?Q?jVUD2xTD1S5q45qHsS5ou94cZiFei8Oqp6yGhk4euz+R6wUksCr9oB4g06TJ?=
 =?us-ascii?Q?8MBdNXJ32gtmJOPmZp5tUWvng8B7w9GcojGk/4ABAtDid5Z6VowcHIsJkUf8?=
 =?us-ascii?Q?AuFsdj70DM4dMBWY4O228NbqIC9JrN9oXJ9JwDOFjwHf4xVCKosppnCjJKnC?=
 =?us-ascii?Q?B/WRomqCiXYsFu6mp8apb1RTr+6H8C0Ma54xuEqjJ/PoJD2VnXzhNOLV9/AI?=
 =?us-ascii?Q?Qk9BPH/L4fZbauq+0MTkXg2BIFFiU3WFa5b9ubbopkb5luIomuUnMkqRpTdG?=
 =?us-ascii?Q?Q7BoINBAxT5c0D32TCNdTswEbh1yxQNHXBlc6QMKm9UciLwub/bjHyNmBXye?=
 =?us-ascii?Q?rO+RkQQMizlWxVzEJw/IcmRWVfAVrlK8EjBxGSZDj+Zu4C9e943DkEseerPZ?=
 =?us-ascii?Q?jLG7EjGeZu6IuO0dg3ox2MZxOxuQ4qCSn8SOoPBNLMSQbcw5OEbyGldzn7h4?=
 =?us-ascii?Q?sc7vV4WFi46slTvlz0QuLpAodeKn3ZeOB9DxuakWclF2j1zr2EWaj5p61PZw?=
 =?us-ascii?Q?QjGbrhy1S0kejcQc3ItwBm22tXP+1i6rkRoUuvf3sVgm2TeKxn6kxKcuKe/3?=
 =?us-ascii?Q?1pwbP3o6zFSV1zWaJxSOAZaX2CWOWvpxhNjYv/iWcUTa4UnuGRzpP+b+ZBGv?=
 =?us-ascii?Q?Mu4gV4xmDg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgrJIoON3z3gDYSoSQueEy9+3/Gv7M/NUwC4/uMHk6+IboY6jjfZNZdA4pm4?=
 =?us-ascii?Q?L4O4qczc4ohk83ZBkYqkny4WlkXyklbwSssKcJ1b+mg1HWQweRrri8rsJ4N5?=
 =?us-ascii?Q?V8YCxyRZtrW3UwqS+DiE+eKmO3gwJZlQTYxPxJ9kbLams9fjJVmHtM0PkP3Z?=
 =?us-ascii?Q?db4XyKnUAdS+147xSDKTGsfps1EFl8URz8LtV0tf6igrbJBBWHWH/N4fxPf8?=
 =?us-ascii?Q?3Be1JZ+zkgBldHFNOrq+BHf9GVffOSgGaUJSor5hPBbYjUEYXxPZ12c3Qgmi?=
 =?us-ascii?Q?thG0IKW8L3fIxjfX6RNqDzZw4oWUR0dEO8pRE1DgxB7zTCvwgu3ZWje/arvR?=
 =?us-ascii?Q?yxRbAFE7F6epb7+Kyvy8Br/9IIB4roPgYH9h6AsEDPzdCu/aoiXCf1j1KzII?=
 =?us-ascii?Q?owG0qy9Hxh5ncvuingOJQx3Sbh/YnWJFfFkWA6emZIs6Dqv3mQW/nzZ63A2n?=
 =?us-ascii?Q?NVLyetS2s0MnhfdJ/uYUtmyDupQnxWTBoSFvulJya3RxAGBJE5wYUfCobfw9?=
 =?us-ascii?Q?Kh4h4WjNLrWSNWUtuGjKc78Z6VrIyHFid1byV2zKO1ADwNne7rW3/UMvQPRD?=
 =?us-ascii?Q?qCpTyNTLEacDNKlXL0LkziEAWNvFl1jXsTViEAui+FZEE1oA3MJKn2nVefbt?=
 =?us-ascii?Q?YnVN/zt9YudvZV1t+NXWkQjr9RWimRddJ89KC3H4fXRr9zpM8w2NyPCSHpbG?=
 =?us-ascii?Q?mwTPG3huu84YcTwbt5cJuRjBwKS6GC9BBgAGb30aUdYzHjMp6ra9cfyEewrJ?=
 =?us-ascii?Q?b3Rnh/cDqxsuF07oK81THYqAY6QIuynph4qZdgonB6GqnFbvyuQpdtnKG8ND?=
 =?us-ascii?Q?SR/hkyJ0F/S2uNLlpG0kzc73GAEpKEjfwafoRpYsvHgHI+fDfcpBjPBmXzIE?=
 =?us-ascii?Q?zNWQr0IcRh40bJvIbLsWj7SC4EFqZrojqc6F6uOh2Z79BWruyYt7kRKHYyez?=
 =?us-ascii?Q?ptJcvKqRogT+fl4SKPtohAdjR15DOBBJJ4/Opu/XM6TBTDa4oz7q2HEn1CAz?=
 =?us-ascii?Q?xYAF1xkVR/yGG5yZNPTufSa52+VhERFMEsQD1KkmJ4bBmaV+qzQ4ARIdjIp/?=
 =?us-ascii?Q?QpCQ7tGL0P4uAn6wB8wajT4bywdM0f5qzFZRJeLoQYqJ530wvgiM4Nr5VDxo?=
 =?us-ascii?Q?nETkuLOfPmOhJ5sbH0ojNrWDPBKXa5NGRC9quKmL3+1SalOL/AK65rvzYFg9?=
 =?us-ascii?Q?ryjM+UXnYlZX3N0lNwhd5p/N76wkfkJOy8v1jJ6MQenROpiRGB9DaLu5Yydp?=
 =?us-ascii?Q?QYfwEIpvEDB94C0VmimOY/PqlVsmdjabZ2ZXTPlVFN+/y9BM+RVLu0riHXaW?=
 =?us-ascii?Q?gLorOcTisqfvtEwc2sT5ro/1eyDpy+KxOa1i6Pf6AG6hX0P/OZJbp4g83Uli?=
 =?us-ascii?Q?KsBCTFXUft8pYLhi6u63n5U5V+nLmHCJTdyIIXJut8Dxem/4DCVGk4HwqFEt?=
 =?us-ascii?Q?nR2o52tMX6RJKMdy1X9IP6AlCYi6MrrQF8HG8vWn07FVTCWIA5I9jwNoBdZC?=
 =?us-ascii?Q?nN74JASfrXcyYRXNIIhxXqSAHGXLO1WmVYeOCFVwOpDjmEKBpWbBgGXonAhr?=
 =?us-ascii?Q?jsMU2MRRUnJWl/GW7PksrzxcLtSc+rUr+TfkAjXs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fde589e-ed2a-4b3d-ed79-08dde06ff62c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:02:43.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JFw93ENz2z8vvVYVWFWYkXrcikuwYI2ZebGJraALhNRhv7SRpGSm5cBEKQ51kt71KKC0UAzSiW3uxWz3bqRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

Hello Babu,

On Tue, Aug 05, 2025 at 06:30:26PM -0500, Babu Moger wrote:
> "io_alloc" feature in resctrl enables direct insertion of data from I/O
> devices into the cache.
> 
> On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
> exclusively for I/O allocation traffic and is no longer available for
> general CPU cache allocation. Users are encouraged to enable it only when
> running workloads that can benefit from this functionality.
> 
> Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
> "io_alloc is supported by maximum supported CLOSID" part of the initial
> resctrl fs support for io_alloc. Take care not to expose this use of CLOSID
> for io_alloc to user space so that this is not required from other
> architectures that may support io_alloc differently in the future.
> 
> Introduce user interface to enable/disable io_alloc feature.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

[..snip..]


> +ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
> +			       size_t nbytes, loff_t off)
> +{
> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
> +	struct rdt_resource *r = s->res;
> +	char const *grp_name;
> +	u32 io_alloc_closid;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!r->cache.io_alloc_capable) {
> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
> +
> +	io_alloc_closid = resctrl_io_alloc_closid(r);
> +	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
> +		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %d is not available\n",
> +				    io_alloc_closid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/* If the feature is already up to date, no action is needed. */
> +	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
> +		goto out_unlock;

Does it make sense to move this check before calling resctrl_io_alloc_closid(r) ?


> +
> +	if (enable) {
> +		if (!closid_alloc_fixed(io_alloc_closid)) {
> +			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
> +			WARN_ON_ONCE(!grp_name);
> +			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %d for io_alloc is used by %s group\n",
> +					    io_alloc_closid, grp_name ? grp_name : "another");
> +			ret = -ENOSPC;
> +			goto out_unlock;
> +		}
> +
> +		ret = resctrl_io_alloc_init_cbm(s, io_alloc_closid);
> +		if (ret) {
> +			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
> +			closid_free(io_alloc_closid);
> +			goto out_unlock;
> +		}
> +	} else {
> +		closid_free(io_alloc_closid);
> +	}
> +
> +	ret = resctrl_arch_io_alloc_enable(r, enable);
> +
> +out_unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}

[..snip..]

-- 
Thanks and Regards
gautham.

