Return-Path: <linux-kernel+bounces-891095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95BC41D16
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EECBB4E2FE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414731353D;
	Fri,  7 Nov 2025 22:25:20 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021106.outbound.protection.outlook.com [52.101.95.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B624BBE4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554320; cv=fail; b=KTX1de/ThUt5aYK3zbR+lueEsD2h6OAY8c+VdV5KGT4vX0NrvCyqBIctiJVpesbj0Gb61OmbrWnaYDmdZ2+0GAd6+Xok5mh0HnEQslN6dzX4cwY4XCHTtd8EzAzf0+PxoFi8WVGEatYL9LutNJr8WaaoATYQ/iW4EDvDWUtVaWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554320; c=relaxed/simple;
	bh=fx1yamEL8Kyy63I4F62OdYtwbcf8NPxVz03Om0h5mSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dYiCkA7Ijkb2PyLqPxzMYaygCwQNEg4dkj0mt7dpb42XdG2WLNidd0AOYlvPne2xOlTf+e9QHxNpMXrXU/SsaE4eAdZRlrBlfx5BW6gbJbD+Dqg88Pm7V9EhnxFZSHO5G7JFmOYTVFAwWDU033A1xKi6SIV/jjjHof1x24G8UbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti5zkOruq2gjhmu04fwgj+XX7ckErSMXPo+YnNs34tECd2ch1C0xYmENJ7sdVTVgZoRrJEfir0BUQq0rhhHkooOVmJ66JWLa7PTf0rhPzR3WV+VbLNKHzk7aS13BYjBM1w0l8IHq1Bc2dHEAlCKbzjtsBUnmHseAk6AOvdf0niAxOuuIoQCunx3zO3FI/wI4QTI3A/BJN2DblHfGksyWU/WHLAPgoAqAc2w/SooZWpYxcOT3dfeMnpUx49zvbRLM3Wf4bG1Wdw8TuDhZTF/Ly8UUEt+GGY9NOM7hHOzBjF2UYgb80uUvnXiNOIUCSXmJpwaZ3pRZ8otZK2LTd/PZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNly+Jmbr8zT5MeI2TAaiHY72QNJoaVqtdgEw9mth+Q=;
 b=rjhl04V20bnb8bq8rvnpz3NkUbZEyhCiMoIOM5p9yUgR4xnvPI/E8n3Wod6CEdCdL8xGHJOiyo1gZ0ZMa8+aw+qO8G/uDFZ80UU1HccqFrN9TmOeNflsSwqHzNBdQgFdjj7MyPDOhkES0viefnJ097PIwcCIUydcQv4JaGj9NXFq5xqyHKa9i4dGpMkx1oKt8Kij1p3MMF6+sEHngjhIduI4OYm6gND2oY1JCocJvvi06U1TmwGomFB3pjtUAFtNLZiDDPUil+l/oQ5gshyHCvlTVKXi1IW+feqwt8hERupTnUnNaiXPbeNN3qdX7xQ2Jk79osLBDke+2dtO2m5vNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3158.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 22:25:14 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 22:25:13 +0000
Date: Fri, 7 Nov 2025 17:25:09 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Moger, Babu" <bmoger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com, 
	james.morse@arm.com, babu.moger@amd.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Message-ID: <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
X-ClientProxiedBy: BN0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:408:e6::27) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3158:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cf4f74-f794-401b-c7c9-08de1e4c84d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anBlemR0bHVVZ1BUM1ZqNWRpTkdtSUhWM0MvOEZBRVF4YUlhN2NnVDVvZUhJ?=
 =?utf-8?B?Zk54d25UeS9xbkpxL2VHbFdqOEhUaGxtd1hmYW81YXlPZ21WK1BQcXJhTXBZ?=
 =?utf-8?B?bnI3L21PS2tpaE53YXo5MWRLSHE0Mi91Zjk2K3FsaG5nQ3g1NnZWQ3hQTWNy?=
 =?utf-8?B?L1RFNzUwN2k1Skk4aUc3TytMTCtMSmNER3NVWnlhQjM1MmJ5aXhXVlNWM2NX?=
 =?utf-8?B?USttRHVwU0JPTEFnTUNYQktEMlRtY0NoYUt3M2xjV01iRk5mM01zSlpubDVW?=
 =?utf-8?B?aXB3MEwwVFVKR3VBWGpyN3l5aEdadGovNkFuTkowcWhIUFRqQzhHanJZTmph?=
 =?utf-8?B?ajl4MVdTRWZvL1NNSGZFWCtQbFgzYWNrL2IrdFhMNXVEUXBVVXY3NVpkUU1a?=
 =?utf-8?B?T2Nnd3FkNFp1TjFBM3Z0S1hjck1lQmlUVllBNUJRMnpIYVJaN291TEVKQjli?=
 =?utf-8?B?bVB1ZGVLVVYybWRZbXNtZkp4c2R2S0ZPdlFIZUNVWU5WSWZaYzlQbVl3Z0gz?=
 =?utf-8?B?aE9kb2tleDRjVmhmMDVmYlAyUGtQNWpNNlF6ZGVneUhmTVRsRHF1T29UV080?=
 =?utf-8?B?bU1NaE5LR3YxMTBDbzFHcVpuZGRMaWFkTGRQaUFMR0xTOG4zUVU0Z1k0Y2F0?=
 =?utf-8?B?YStFNjV6d2RId1dxeGtsNzViS0dwWTVmV1F2MURSTlFkZS9KMG5hNStmaGdw?=
 =?utf-8?B?eDlUTlVkN1o3TWMwU2NmUXlTNkJ1SzN0aVIrM2JYbHZBUGNycDc2L1owN2dQ?=
 =?utf-8?B?T200QjFoMlhzdnFrUkl4MUZvWmNzRzg1T0s2cU1ZQ0FOMVUwLzFyNUx4MUQ4?=
 =?utf-8?B?cTZzbEJZWnF1cVFtaHVEUTZvalBRVXVZcXB4K2M2Uml6TVYzWFUzZnpKeHlV?=
 =?utf-8?B?K1cvb0ZPY293K1libk43QWh4TVZIVzN4L1ByYTUzWEVab1ZSMTFhRUpiK05i?=
 =?utf-8?B?aFg2YW0vdExUL0U5NmEyck9Sc3l4TWJ5bzlFYktDa0l6YXNzZ0ZiS2VrUHNq?=
 =?utf-8?B?cVR6Vll4Vk5BOHJ3ZDBFQlZkSDRlclU5WVV0Y1F4emN5QUNhcGQ0MU44V3Y0?=
 =?utf-8?B?dUQ3N3BZU1dBTDBKcmZvNmYvTnQ5czRKazA4ZjZ3TDRkbml0L1RML3luVEMy?=
 =?utf-8?B?bEVYemh6WjVsTi9ZYkp4bHRRQWd2S3RyQWNXOXFSZUsrMnE1SWM2ZDhFb21D?=
 =?utf-8?B?aDFJRUw4MEFyRU5ta0RMZUxoMzMzSFAya3h0YmdZSEQ3WDRIeFRMZlZXWVB4?=
 =?utf-8?B?MTVGMzRRTVNqaXNlWG5YVUpIcFBTK05qMXloWjF3Q0JGWGJxTlhyeTEwVThR?=
 =?utf-8?B?WFo4WHMvbk15QjR2VjhORjFTS01sRnJuWkpseWVhajRQeEE5R1lDWjVIbUJJ?=
 =?utf-8?B?eW1Dc3VkdFEzRDVReXhMNi9sUWg0OExwcGt1WUZHYno1KzZiRTBIUlRCTVB0?=
 =?utf-8?B?MkZUblR5ckRFRUhhaWFnc3pqa0VXTVU1cVhMb0h6Y3MxaGtTMmR2UzZKblA0?=
 =?utf-8?B?ay9lcFNKQWRvOExMMGxFSEM4QnE3dnJHMVQydkJ2b3N5cFFrMkNJL0c3Tkt4?=
 =?utf-8?B?NzU5S3ZNdi80YzYrTy9DMkh1TmFSYmxlYnIxVnVBd1Z3NmRTdlJRbVNBL3Nu?=
 =?utf-8?B?K1Z1RHRIdFc2OXM3NXVoQnlBWTJ0dGUyQ2dBTW5OZ1lPMTYzNGxuRktMeXFh?=
 =?utf-8?B?bStYUjdrby8vRW1sUUsyZ0Rsc014WjJSSmxMUjNSZFllbkE4cC9SZkhkSzdO?=
 =?utf-8?B?RFZPdDJrM0laNUhsMUl3R2ZPNXRDVEtWMjU0MVFmSm5WdEwvb09VZjBySm1i?=
 =?utf-8?B?Ti8rTER2UG84R01WWWxzaVRvUFEzeE5nNzJVV1MyVHpqZTFCWFdJbFJqQUlr?=
 =?utf-8?B?QXZvL2xqRnhUT2hYZTN4azdpM3FDekhkZXVWS0dzLzlmWEhKZ0NLNlB2bmdj?=
 =?utf-8?Q?78fu/rNRgLagfXNZDrXyJfv5B19g6IpA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTExdmRBb001Nm8rRC9xTVBKZmw2bCtjZzhZNGZhMnpNVngvUXJFZ09FMEFT?=
 =?utf-8?B?SVMrekFHbVZEaVQ1cTZ4TTRjT1ZHV29zWndRcFp0aGpDbDcvZTdiSlFxMEg2?=
 =?utf-8?B?TGJlWDJZOHhUbHNPOFBZWTdML3QvZ1JrV0RMc21NTU5jWjRMVnpOWFkrcmYy?=
 =?utf-8?B?RGY1VHB6REFKcHRhSmdtVGFoVkpyUENLOEJ3TlVCTzFjQktaZmtpdDBxUjlB?=
 =?utf-8?B?d3pkc0V1YmVPU3lwWjE1TlQ0UUd4QzUwWGJUM2cvOTlxcWJXZnhKZVFPUUxX?=
 =?utf-8?B?QmcyK0NhQkNYTCtyUnZnaUp3cUlKcktMT0pYN1NoSStJZjdoUWNYTkNlcWdF?=
 =?utf-8?B?a0t5cmJBK2FHU2FiSEczeEF5TXcvZFdINEozbStuUy9WZjJ3bklKclBrRVB1?=
 =?utf-8?B?NG5NT1lKeUhPclRXaEZQczk5dFNoOVRVb3NEM3RKVUxGeUpqZ1Z4R1VVMzFr?=
 =?utf-8?B?V1owY0YwMmI3YklTWXRTZGRlWmlMRVRIU2QydDlRRFRaZk51OWVXR2FHY1BO?=
 =?utf-8?B?c2F4WDlMMFlNckVoeGhuRnlZOHBNa2l5ZXJMNHJHQkJ3ZVhpY2VicFpGcjhy?=
 =?utf-8?B?ampSSUxTK0lIWGdqS2RSa1d1Q01XeS9EN2x4NUdnV2tPNThzMXBhYW5DRmxN?=
 =?utf-8?B?MXZJZC9qcnM3Wm1ES2lwQjRDWVZqUHk3ZU9sQ0lpMnNwNHdLN2lmZ21lR0JQ?=
 =?utf-8?B?WEdwaDQ5UHlsYjZTenlSVVlmYzNpdVFTRzk4eVFtcE1KbmtJcnRSMU9DWE1U?=
 =?utf-8?B?MWEvQTBUNVcxaWNkZytTZFdyZnJ6WERUM0IrMzJ0bmI2OFRVaU5TMmYxOHJO?=
 =?utf-8?B?SXg0cUVIeUtIYUlzYUNrajBmUXg0eFdnNVdqMlRPZnRQeDR1bkUxQ2FKWlJV?=
 =?utf-8?B?M3huRmFDanVIb0lKNzUvc1dRVzFjSmQxMlhSZDViRXBXbmlYUVdlYlhSSkhS?=
 =?utf-8?B?Qlc5RFFFc3N0VTZWQ2J1ZGlvaTlCNVl2c2xwK0MwTDRMRXoreWx4bTdhN0k0?=
 =?utf-8?B?WU4rVjNNUFBibW9YMS9ZQ29TMXg5U2FVWTJzNG53cWl4YXBQUDFObEJVR3Ry?=
 =?utf-8?B?YmVEMUxnQTlTbjQ4ZzU1cjd6SDVuNmlhUjFPTkU5R24xVVhkS2huNFcxTzVa?=
 =?utf-8?B?ZnlZUTJEUVhkaDZRdHQ4VXNnNGNOTzdIWkN0YjlOQWdsZWEyQ25GVTZZazVa?=
 =?utf-8?B?TEZFQ2RPSlRyeTVPTVl4TDFYaE05dWJNVEdEdVJOdTYrQkM4VEUwV05kSzRt?=
 =?utf-8?B?SldHWERaT0RFMEFZMlVZN3ZoeVRtdHF0T1dVeUtGU0ZmSzF5VDMrdHlFZ0JS?=
 =?utf-8?B?NkVOenRadXpjYlZlTllvUGZwS0YrT2xYeXhxQ1hadkgxaVU4N3g4YmJSVDJj?=
 =?utf-8?B?WENoc3VsQkJvV25xNTY2dUpSUFlWalF3U25nK1doTy96WWRqRDlqOXJNSm43?=
 =?utf-8?B?cW44aHNuTW11MnRQTlFBcHYxTXdTdENEZzlYenRmN2QwOWI3M3NqdExENEV6?=
 =?utf-8?B?NmdqYkJXLzhnTVBiLzlDUmV5NTRYQkF5K1phU3JJdCtlNDBnRzIxeklUaHZE?=
 =?utf-8?B?WmQ3OGdGcmQxZ0JVd1BOR2licDhZNW5sV05mdVVnTzlYeWlIY09rUFJiMm9h?=
 =?utf-8?B?bVRaalgvRURkREg2KzJqVXZXdkdGRWcvMjdnTXF3VkU2SmYzSk9lQ3pkWTUx?=
 =?utf-8?B?ZVdnZ2cyUXdBYzM2Q2JZTHJRZUFkS09oZVZBVkhBVWtVbW5mRkpId0VBTklW?=
 =?utf-8?B?MFhKd1ZEaklpNTVXWWtodVdTbklyRkc4ZGtJUXBYTWlpaUtTZ2g5UXhiYmE3?=
 =?utf-8?B?elI4eUZMOFBnY1B2RDl3K3VpYXlmZGpwWkxJT0tveUNTVnc2aThkTC8zVk1V?=
 =?utf-8?B?aFErN1hpeWllMzBXZ3BtZGpTb29FR000bDBWcDhNdXNxMXVLOENpSlpJeUVk?=
 =?utf-8?B?Skh5cWZzeDZ3MkQ2TUN1TUgvRVhVcGFEQk9hTTVFSmdYbHdKRWtFeWp6UitI?=
 =?utf-8?B?MVVWaUNCQ21CVG42SnlZUy94ME5jWlc1a2R4TVZPWjAvU09Ra0thMHhnRDh5?=
 =?utf-8?B?YWkzYytVUEhkNHBiS1hQWWtrbnNoTUtmTVFqMjdva2NsOVFyR3RETkFVUTV3?=
 =?utf-8?Q?PdqNhAaz94MW2ShYVTVBilwKL?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cf4f74-f794-401b-c7c9-08de1e4c84d9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:25:13.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwJ9J8ZMjb8e8tlNMyA54ss/D3K8NxhNPPJDAld/7hu/sKotLTNba9Lkb1MsVcEdQiU2jMkueYOgEPx8NDyG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3158

On Fri, Nov 07, 2025 at 04:02:39PM -0600, Moger, Babu wrote:
> Hi Aaron,
> 
> Thanks for trying the patches.

Hi Babu,

Thank you very much for taking the time to review the patch and for
pointing out the efficiency of the existing interface. You are correct that
option [1], echo "0=0;1=0" > io_alloc_cbm, is also accomplished with a
single system call.

However, the primary justification for introducing "io_alloc_min_cbm_all"
lies in abstraction and the knowledge burden placed upon the user, not the
system call count.

To successfully execute option [1], the user is required to have advanced
knowledge of the system's current cache topology and capabilities:

    Domain ID Knowledge: The user must know every active Domain ID (e.g.,
                         0, 1, 2, etc.) that supports the resource and
                         manually enumerate them in the write string. If a
                         domain is missed, it will not be reset.

    Minimal CBM Knowledge: The user must know the minimal supported number
                           of consecutive bits that constitute a "cleared"
                           state for each domain. While this is often 0,
                           relying on this is not architecture-aware.

The new interface, is designed to abstract this complexity entirely. Also,
applies the hardware's guaranteed minimum supported CBM (based on
r->cache.min_cbm_bits) to each domain automatically.

This unified approach provides a robust and efficient mechanism to
guarantee a full, architecture-aware reset across all domains, eliminating
the need for userspace to parse the topology and construct a complex,
domain-specific input string.

Please let me know if this clarifies the motivation.



Kind regards,
-- 
Aaron Tomlin

