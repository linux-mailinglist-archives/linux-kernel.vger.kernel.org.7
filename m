Return-Path: <linux-kernel+bounces-880955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CDC27070
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ED2188A63E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304931579B;
	Fri, 31 Oct 2025 21:25:52 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021142.outbound.protection.outlook.com [52.101.100.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBE2D8362
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945952; cv=fail; b=PogpvplCxcA5SsDCaws45ztlELAC9sym9cT5quisZKEtPx0CJa/93KTyIJRIu2PE7nQOk9Z06HlehgXDxpjyBB4UBjlAmnvMz6eyVP/0kkNTiIBFPkn0CxfCci1sQ1mtItEwvbwafHm3m2PEr5YNQcZ4R+efYJ2d/96kiXbDg4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945952; c=relaxed/simple;
	bh=tj3rbVRz/zwObpuE0N+ET/gJMFtWp0hrV9bzI8hzIMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uco0MR9itpQGy7vyng08FJgh0nKeqQfRUz4pE3KFlbCjigNWo464dudhTFxyhtIYJcFOVTYczWrTeEnu1ZkN7r9jkp8FU18T6E7Sgkq2Md/SWI8+MhI0an1kybqy4qrx3KkcndCZg5LXCfsCmsCW3Kid8iJMGeN1MFG1Lxu7h00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omRik72pDlVzNgt7HTsNaafFEZkd8Ok/Eevr+ui3XeYxG0E4ZcLKZmgx8V1TUNJb5WgjlzI5KLYEUBDzH2I76yfF+3V+uPgy287v1jvw1W4w+QNRT2JcuuUA2YtkhIv0S3zF2LWOdBA0ytWTA+TNKmnbDwl6R1tAcBVmY5CJcHJtnPmFNQgGOwFnmcQbzVt/b2gzjkuDKVXwbtGfIjAC1cyx4OmbL6b+LZm9JeR2cugdVl0sXdMZeLVnm6/Z7QEbp4qQeoQFDMAkI6p4lU7XNMkQ78CPYx3KLvklOSnEAiZK2iwP39jEoNB5rfWji9qdZCFAS06WTOxTu0JzjypgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW1CJl8C5d9/KG3uvm/AnOl+IEuilFQxuJuX3iwLaaY=;
 b=L14Z59Gj4hBpIhavcCZndyTORzM/8qtajqw2SmHS17wdI2LKhos4fesfEpnso1Ig4lAREnH1ijEdsHXUrLIGS5LurKTwpQ1brVT2ePaew+CbW+dZAIx9B5daIgnfCDDCPF/n8e1SvXj8yUsSXuej2P1C7oiPShVBUf7bCapsnXRxl+QBfD0DKKIF429uoyI6D4lUEgEUoOfsg8gQ1qy5ErE1yRho+6/ExUki7Ttxb/gAC0m7M0nS/4l6tUbC/ZC39nzZkNjEqD4EZUAp9mjhywZR0uPYqQu5W5A+3c1AX48BbG5eElvuDTC7aK73lakRdoYQtcBpkvE3XWN2UgVhWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB3902.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 21:25:47 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 21:25:45 +0000
Date: Fri, 31 Oct 2025 17:25:41 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>, 
	"Dave.Martin@arm.com" <Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"babu.moger@amd.com" <babu.moger@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	atomlin@atomlin.com
Subject: Re: [PATCH 0/1] fs/resctrl: Show domain CPU list in schema output
Message-ID: <c26dierez6gzngp2syreufhdwhx64iuiox6cqrpeomz2ieuwkh@4l35mbkc4ez6>
References: <20251031181722.250851-1-atomlin@atomlin.com>
 <SJ1PR11MB6083A4A7720723C14F3AE314FCF8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A4A7720723C14F3AE314FCF8A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:408:e6::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB3902:EE_
X-MS-Office365-Filtering-Correlation-Id: d671ad5b-3b17-426d-284e-08de18c40d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OS9SZS9NWHBENTRBZmFaUTdZSEJ1MUdYYU1CZkNDNTJ1NkVKdC82K1pBeFNU?=
 =?utf-8?B?MGpCRXRqbHdJTkNXbzh6NzhMSXJ4a2VLMVFzQi9oZnlLMGJQUmYxcGRsTHFF?=
 =?utf-8?B?RERHd1l1cUZkd2lnSGVsRXc4U3lLeXN4WDVUc2xRZEQvQTRJV3Z1QnB0Qmxh?=
 =?utf-8?B?bUIydnoxN0Z0TFJmQys1VTBsSjRSbkRzcTErck9WaUFrMkdyRXBRTGkrRGVX?=
 =?utf-8?B?ZmNVVHJKZm1hWW9mclJVWHFYMXZ3bFNqUWp5TXZjd1NDbG9KSTJSTjlZcDZZ?=
 =?utf-8?B?c1VyL0pEcXQzQ1YxVGtBOXQzTUp4bTduTmEzWi9WQTZpWEZ1UGdvaHJpVnNr?=
 =?utf-8?B?am1BVTdyemhsS1NWa20rY3hOSlNpZkFmZUQ5NVVJSDFZd3F5YzhZKzBnY0g3?=
 =?utf-8?B?UXlCOTVZV3d4Ym9wWTFWbUNJT2M2L2R0bWRmUjJ4bVhibGR5QzNlblBHNzVj?=
 =?utf-8?B?ekRmeTdiK25VdlQ2UllXYnVtOW9nbEQxZ0FUSkZPa3FHSE0vajNpSUN2b0F0?=
 =?utf-8?B?UEFRbTd0TWsvVTNnWXhpdlQyUXBqM2pCUFZmSWQvWXZmSW5rV3lyelVid25T?=
 =?utf-8?B?OEJ1SlJqSzZ6dWVSYXZObm96S3krL01rRHM0UWw5MWdkdjZ4amJRaVZWSkR1?=
 =?utf-8?B?VWtBbFI3aE5kendyWU1BTGtTYmhHd2FZRU1ZeHF1M1l0UXNsQnRLWk5MaUVy?=
 =?utf-8?B?U2E2MlJzMGRmMEQvNmZuc2RDejJkTVc0U0M0ZGFyanlxV1g2dDJDbHlWSVUv?=
 =?utf-8?B?Q25teE12bFdQelRGK0xKMlphSU9tZ29SL3JIZVQ1aUxUZjJjSGhhTXpnQTY4?=
 =?utf-8?B?cThkcnhqYkFtT0hac1VtQ0s1K1BvbGY0cHlQaWFyUkk4dzlLOTBVdk5LTk5m?=
 =?utf-8?B?UThwWXUyUmhOb1lBY2VUOHJwZk1HMS9yMjNldHI4dU9ZNk5oR0R1Z0RGSkF4?=
 =?utf-8?B?ZitTS3NhTmVwTlo1c01DQ0Rmd2wyQ3RiVWQ1Y0pYMTZrNWNKLzZqODRnb2kv?=
 =?utf-8?B?NjJiN3BMeVJtWi9qK05MM005SXdYTElQTll2VW8xQ1cvWFViSXB1TXpXZGlS?=
 =?utf-8?B?Z3FzTlBacHI0MVByb0lvUHJSZS94VEljdFlUZm9WcmoybWU5eHVnUU9oTFBN?=
 =?utf-8?B?VE1rUE1uYWppVTFZZUxvdDZzOUZKWENkU0Y0dWlZWjlKbnlZenhXRmxYL0py?=
 =?utf-8?B?WU1hODd2TzkvS25XTkwrNEJwK1doT3hIRk1YczVHUVg3TzRCcWVnQ1I4alVq?=
 =?utf-8?B?djBDWm10S2JmSHgzVUtDbUxOUzdscThvMzhLc2Z5WDUvMHlBc3lYMlpxVHM5?=
 =?utf-8?B?bjRPSHMyUm9zUVg1NFREcWdOb1ZHN1hFWjBRYkNRMlpPdllGNU0weDBTM3ov?=
 =?utf-8?B?SkxQS2NOYnRXRVBTZkc3SzdQeVdoaVB6UFVSS3RKUWl6UUZpNWlUZlNrdjB0?=
 =?utf-8?B?c09BUnFaelZPdHovTnM1M2lBczM2anVYRmxacXM0UUJlSlBPZXUwbGJ0NkM1?=
 =?utf-8?B?SVlxUDhuenBnYVVTeVR4M3ZnNUNjejFXcldJSmlHTG85ZmtEWnNFUnozMDAx?=
 =?utf-8?B?aUluU1Qxdktsd3FuQUpWRkQzY0RpbDBIdzJuVXhvdi9NYWU3UnpGU1M4Njd3?=
 =?utf-8?B?cTNZbTY2ZGxkZmtxSm5nWDBXNDVDMmtuNUo1ZWhqYTJCaFZabUFZODY1SnJ5?=
 =?utf-8?B?bzFNelU5aVRaL1V6OWNIM1diYTgzWjdHQkYxQzVhTk4yMDVOWHhnTmR0aFNn?=
 =?utf-8?B?bUZLQlV2MVZ0WWM4aWJOVW9CckhZSFQyT1JkcGpXNWFjTDFuRE1oL2htbEVw?=
 =?utf-8?B?VzYwRE5zNkdBb29halhJTlAxYWZTRFFDZnZHbm9PeEJDbUZxMXhCY0VXRTBH?=
 =?utf-8?B?VkdFSkF0MWpmcnhyaGRsV093R0N6Q1FuUmxkQVduRlFiRlBlSDFKdUxOZmtO?=
 =?utf-8?Q?Z2ICfRsF9SrvHi/hiUUWBx+pgohyILZ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUZoc24yM2RaaWxUZUxYb0ljMnJwWU5nbVpQYVEyV2lqcXBYNDg1c2FoMElM?=
 =?utf-8?B?aXhGTU9iRFZ3c1dFSVlxbmxyYi92WlRNSVdvOHVhYjgvbWtLQzI3NXZYcTJw?=
 =?utf-8?B?eFJLbVlhSEllY2JhUXZtVTN0U2pHcFMzeUF2c3V2SWdLZGJJWTVaUDJ6dDh2?=
 =?utf-8?B?ZUpQTFlvK0lMbkF2VXBRK3EyMFMvZ3BkNkRwRjFJakNpTVNiT0VyOHZ3MTYz?=
 =?utf-8?B?a3o3aFNLbFNtNTBNdStra1NHTm1OMis3V3NVeDR3Ukd5S0wyK0NQTS93TStZ?=
 =?utf-8?B?VG5IQ1c5QXdObTBUTTVOdTQ0YUlkRU1KcUQxVGM0OXg4T25nVTJkZ3Z4Qjd2?=
 =?utf-8?B?WWxRYzNwVWNGWEJGMUlzTHNPQ1M1WFNlMDg5SWdYbG1GSkxtYUlXNzkzcDBR?=
 =?utf-8?B?bk9FSG1kakdORnE2QkI2TjdJS1FPRUJhSXpGMnNMQzNlUlBmMjJKaUVUMG45?=
 =?utf-8?B?cEJ5U3kyQnh0K3AxSS83aHlvQ29JY3JLNkFtTWxMOVdPOU9mNjZiSmVmWkJC?=
 =?utf-8?B?OEp5dVNFcDJ4NVNRMDc3NXkzK29ZSENKdGcvNHlsVXd5cEVWUzE0R0lwZWN6?=
 =?utf-8?B?WkZ5OEx5bTB0enY5ME1kbnJpN1hwVGpKWE5URFY4emJmV0ZZbXNwYzFIT29D?=
 =?utf-8?B?ZHpOdWVLdHhIdVViYjlTcWMwWTE2V1JOcnV2bXg3UUh3Q09hTzRKZm1mWTAz?=
 =?utf-8?B?dVVXUWNLQnM3TVBJemxXTXhTZU5oNWYvTEJXd2JXZ0ZyUDZHS0NLcmh4KzNG?=
 =?utf-8?B?ZVZiWXhKeXNubUpJdUNyWXdTL25IWmY1MFhQT2VyMVk0SFkxSm8wY0ZLV2tB?=
 =?utf-8?B?djFDWEJxbDFrTnZvTjhCTjZ0UlVpbUozdXJTcG5LSnUvUWhtZkNaN2ZwQXdr?=
 =?utf-8?B?VzlrTDQxSHRsSVJmbHFuYmZ0cDcvTE41MWU5NnE0dXBWRXFJc3pHQkxnVHRy?=
 =?utf-8?B?L1E3L0tmVEV6bEVvcW5NRWF3UUNBcUZzV1V1U2tGNWx5NllwaHFuWjU0UGZk?=
 =?utf-8?B?TUNrSllNSzlmSTU0V2F4cVZCZ1FUMjBxR1ZtR05wVEJ0c2JOSXpFakJmenFr?=
 =?utf-8?B?cE5GRm5UVWhXeVFMYTl0RlhOVWFnRWxxVGJjaU5raDBPWUsycXlkVktrT2RR?=
 =?utf-8?B?SnN6Qmk3YWFOaGZ5REQwcmR2S3RINTJSU2M3ZEI5aW8rYjU4S0FlcUJ4UTk3?=
 =?utf-8?B?NFA2OWpwdnJ3ZTh6U2JnT1paTkIxakRmd3BoSFpSbTdHVU9HRDhwOXVjOVp3?=
 =?utf-8?B?UXJUQmh5RVE4eTZjd3Z1ZnY5eHEzeXlYcll5UVJqNGcrYWd1cjJaL21wOWVQ?=
 =?utf-8?B?Y1NLcWN5eHBRakRkaEJPbGZLb1R6ZlZ3aEZQR2N1V0Jna1RWa29QL3gzMDJt?=
 =?utf-8?B?YlBnS25HRnlwTHVXbkhVSm9MQmJ4ZG5xMmczMUNQeWFTVmQwaUpDUXJSWWFU?=
 =?utf-8?B?VjRRU29iY2FTQzYwams3SU92cDdaVDRzMExvM3NVQVNUUXBwcW04YnZkd1FH?=
 =?utf-8?B?UFAydzlaZDN4ZHM0SmJXeGpsMkxZV2kwZnlYcFYzRzV6QTJRdmR3S3RKbHBi?=
 =?utf-8?B?cWJkMFlUc3VJVjRUTzZvWmNQSHh6a2w4aUVnaWEwc3hucS9Ed3NYQng1d1py?=
 =?utf-8?B?aGF5a2xObGtQSGMyZVBwZmdPLyt4clpWM0JhOTFwaEE4THVpc3N1VCtSdUFr?=
 =?utf-8?B?Z2lBdHJ0OE1MY2MwV0NhUmQyV0kxTHMydGhUQVdYc0hyL2dZWjJQcENBOG1Q?=
 =?utf-8?B?N0ROL0k4V3N2YkZNYlRneTllSDN6enlrUlU3b0Z3UFpZZDl1dDZCUGFhOStp?=
 =?utf-8?B?c3IrU3JHdW5aRkNqd1lEZzNMdEROM21NZjdsZ0kxZzdHaW9TZmtYckdPbWcw?=
 =?utf-8?B?RHoxZHdhZGxPaUNNdnVhV0k0Z0EzTVB2bG9qZTRBV1V3MUEvOUovRzJUNDho?=
 =?utf-8?B?TkFhekg5MGpOUjRCdWR5TC83RzErNjA4RjZOcUZDdTFlMWxrNmMxdTVsSkdM?=
 =?utf-8?B?RUlDUzBGUWFDbFNwdklGS1hyTkxxT0tvdWpVQmwwYXdtS0VyQ2FvSmNQZmIw?=
 =?utf-8?B?K1VuWmdHc25xSHZyNGxPeGNzdFRvMTV0NTNxNlhqUU01d1FxbEQrcVBUTFQz?=
 =?utf-8?Q?r+Q7ajV7eXzi0BbgqTta833lc?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d671ad5b-3b17-426d-284e-08de18c40d48
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 21:25:45.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBOOGrzSb8LxSgGN5A5Yt9yjCHX6ICDiotpFIgjouNAjngSpeSNV9wAzgumc3uhLOn6gyP+yrhj8p9uD4lxm8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB3902

On Fri, Oct 31, 2025 at 07:03:15PM +0000, Luck, Tony wrote:
> 1) You'd also need to change the "write" path for the schemata file
> (treating the CPU list as read-only).
> 
> 2) This would break user ABI, so is not going to happen.

Hi Tony,

Thank you for following up.

If I understand correctly, parse_cbm() and parse_bw() would return -EINVAL
if the user incorrectly included the CPU list, no?

I suspect the issue is if one can read something from a file, one should be
able to write the same thing back and have it either succeed or process
only the valid parts. I agree maintaining ABI compatibility while allowing
the new verbose output on the read path is not ideal.

> Users can see the association between the domain numbers and
> CPUs in sysfs.
> 
> $ cat /sys/devices/system/cpu/cpu0/cache/index3/id
> 0
> $ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
> 0-27
> 
> Maybe not as convenient as a direct read-out in the schemata file.
> But the information is easily accessible.

No, using the above to establish the association is absolutely fine. 


Kind regards,

-- 
Aaron Tomlin

