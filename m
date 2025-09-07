Return-Path: <linux-kernel+bounces-804521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C854EB478B6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 04:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CF1B2182E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 02:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390F1B0413;
	Sun,  7 Sep 2025 02:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="YVmFvQBG"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2020.outbound.protection.outlook.com [40.92.19.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925027707;
	Sun,  7 Sep 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757212124; cv=fail; b=qqWQ9K57OTSxWslKeThFfW8HVab6TP30fg2dKFnVG7FXd7tZp5oDRlcFl3/9PY0KQ4bTuJlx3bbV+PGNe75fPW/ggnTG+mXvnGsTfcsME4ieROmqbbd3Zj3YdwkbdcmVqqaAkBxDWBsTPE6wnu2c3Zh70D8omBkV1JDYrVcEV3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757212124; c=relaxed/simple;
	bh=RYis7w7q7o0Ww/HUToIElc+OSIjDBi0JBofqR039Vhw=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aBSshNEf3cupZXOYK6DAlDuKW7oO1HemgSEoxjVFbDX4+o43eVUiTy87KZImgOUISx85P4TE76DmS825W4D81lLncNKOzejT4qpRmDuV8vXQtUAU5GfzFNvFxd1bJfQAJA4sJcNbpQ/8lKV3tD6S4l36/xvVPDNsTmPWufWqK4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=YVmFvQBG; arc=fail smtp.client-ip=40.92.19.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBN1GFeebdpDjrEUVkhqeuj8ayT6x8uXXOtMgRhawjVKLB5XCHQIS71hJ4nb6LD8TkC4ViHO6gdobskISGV3g5L4X0ZLbah/8NT6Hqxug+cJYeSHkFFpp0E9iQe4gI47U3OrV94XZSuhB0MGnpAyJF9Lkf79NNcGaCfzut8KIiL4JGt6wonxFHQQ0o5W1bwyPnQGS6H55LsuZynbVQF4fymhT+PKeQUQV3WShecSlzM5A7rNs+1vzdyRQVqMT969NbbUGySZmsoGHxE5bZdOD6n5QLmo0/tuKnIU+HxpJFmFY8bhUy6VbD2Sl42e2u11oJ4kGtxLoucpnPsOYAvhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPMMVtC322UCvFMd25KUn2Vejcpsib7MpglDfn9mQZA=;
 b=redHmBlSNnW3oaJ1x6ygp/NP1nPiOECcf9dYiqpGQkvB+lFSjCALOWPd0SeA+VXzT5HV1EVLUbIFF4XiKCssF1dJVKpkP4XgTgxDUq+Z/UJvzs/BurI4nNAshSDxYEG+gXMwN3RQY+vRgy5nPCDJ5A4lV3Utk97JDHNhyjm/MYVjCXxbbExfppAn/FKzTBi1/NRBPYQ5ki850r3zJqmZdb1IJNNS1USFaM7bJ+zuVJ7B83fiY4YFWn+2bnQSJRInhxcI90gvIYs7Yckou6v4ROUnJnVbi5IqPQ2/DM3kTiiKF+F9Zkd/F9l6HgFIarJgeP+5niaWvoVNwgdxDaXErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPMMVtC322UCvFMd25KUn2Vejcpsib7MpglDfn9mQZA=;
 b=YVmFvQBGnyrgy5NOilhyQxzzQtbo4O7fRJCU8zNrA0nPRODYDNUVQhyDMVssS/4fXdgzDVccy9yzE2nLCymbQEnHIehAgqj2znR4sNDGIFJoO+bPbNJNcnIKkCh65+rcdW/xS4z/TLl/YWis7LivP6+68MzF30PHO94RWECRUDE/Byso7g/Rk/ksvd0zDdmnMJakSebsbcaxHrix6AMrEpBMW03Sb4JzJvz+hopa2YWW2/C7PBsAFiZgddUx2dQnhEJh8LS+2KE89xvQJU+XHQyx4wJKotam3GoBCjS9X0lD+RCG207w7sY8TNKR1cymibeeBwv2ee4hseo+XcCeWQ==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by DS1PR06MB10194.namprd06.prod.outlook.com (2603:10b6:8:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sun, 7 Sep
 2025 02:28:37 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9073.026; Sun, 7 Sep 2025
 02:28:37 +0000
Message-ID:
 <MN2PR06MB55980FFA32BF5DABCE34333EDC0DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Sat, 6 Sep 2025 22:28:39 -0400
User-Agent: Mozilla Thunderbird
To: ilpo.jarvinen@linux.intel.com
Cc: dany97@live.ca, linux-kernel@vger.kernel.org, matan@svgalib.org,
 platform-driver-x86@vger.kernel.org
References: <d2e91809-8872-7a3f-743f-b4091e8196d2@linux.intel.com>
Subject: Re: [PATCH] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store
Content-Language: en-US
From: Daniel <dany97@live.ca>
In-Reply-To: <d2e91809-8872-7a3f-743f-b4091e8196d2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <03984958-9428-4740-8f16-30961c85d79d@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|DS1PR06MB10194:EE_
X-MS-Office365-Filtering-Correlation-Id: 521ece09-0856-4042-f2ca-08ddedb63f6f
X-MS-Exchange-SLBlob-MailProps:
	ZotS1sRCahf71ar04bfk4CpKCVHcNkOYnqDCHf/3QP74R6phgUA1mZyqjdz+y1ytYMwTZkNdSmVHvzNjz6sCXGvhC7ykJMqnlT2AEpFb5UMF28upJIx9a0ON0AAPlfk2VYY9DXZ+KpZ8Yus6v5+rMNBJmEGp3JLxUhYqmwxGNbZ7H7VDoDpy3zOdUGwKqOBxES9eHOkZnd7uSvnDWW9jugRjthXPKrXTqDI+SEgAexRpFmx2uHkooDaRBITaVy/5fmkjqGJNdMHrmha5HZ6T438BIUakKjKrFbHsNSZafkr1gwV0lH4aNRtLERSZRAb5+aeANmNuN5bMRQrv/FXL8MEPvaEuCspyEkEk8W7guCJxvCEfCqPyyKAMoPivg1VigLgYm17Hdc6Qdw2AKm6nPAC/dCO0dQ/YNLO89vuCkiBJ63lcZ+cEYhdDEoJwusmw/M8638JLDhtzVv77VTiIXQFH0HkcIGXoIEIH2Rg2v5Ca6rHGUi78387euRs2a+krLA0V+8o43kihuS9GxlkNsnQWlo3tPusORDNV3s1R0svvwgLgr32sJF0Zfnrm4iqZyxj8iBwqWYyjTJ8qSJlDRpcH1jE8cytpfBqHkPEBrcDrjsNmpbPvyiGB2ylaajyT6BFP00Itod2UHqov51Z65b6G9wy6RDV+
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|15080799012|8060799015|19110799012|23021999003|6090799003|3412199025|440099028|40105399003|51005399003|26104999006|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1hJekw4QnV5TWk5aW5tckhPTGt1N1Y1UDRrUys1S0I3LzJvMVlWOE9uOW5a?=
 =?utf-8?B?T0tURTBPVjZ1ZmJJcEtwZXlqTGxYWXRaZzV2cWQ4SVJZYUtNWG51QmVURTBU?=
 =?utf-8?B?dTBOUlptODBIS0ZlcDB2QWRQNnV3bTlWZnZUMGs0ZFRZM2duenJudEYxcHd5?=
 =?utf-8?B?Q3ZWQ1JFbnpoMHY3UC9CVUNTb2g1NUdNYklwTDUzejNhYmV0WU5EUkdpVEpS?=
 =?utf-8?B?cHBZQ1BJNGNTekhYY0FzUnZ1L0RxSXp3eS9EZWIxSjA1ZE95K2drSkd2YkdU?=
 =?utf-8?B?T24rNlNVdHdHY1JXRStDSmNUeURmZ0RaZ1FMc3MwQUF6TlB1QTFQSGhSYkYz?=
 =?utf-8?B?ZGVHSWZubzBlcFdLRXpFWWdZbHk0SHMvckE5SVlORXplM3hLaElCVjlJVWlX?=
 =?utf-8?B?eDVvZ1RxNmpoME9nSFhvMTZVeWJHNTBNQTd4M3NjRDQxdEE1dlVvRVl0c3Bo?=
 =?utf-8?B?ZzNMTi9lVmx3bmRjYXJYb2tqbVV1WVpxWXc2Z1BWbXZtaWFPWjlUdnFlM1Vo?=
 =?utf-8?B?QUR4SEhCZVJJNmxaaVZZN2xjcFVSMkY0Z2JNWGlPUWJTTzlHVjJLcVdRUmVv?=
 =?utf-8?B?cHB2dWtRYXh1djc5dytCbDRlR0JZdWJMM0hKamlFMWVhd3JFakNGaTlvWU53?=
 =?utf-8?B?S2gvUUhvSWhJeCtvVzgrWnZsYnk1V09pRUIwYXNNZXNIc1BTbWorRGloV1NC?=
 =?utf-8?B?ZWROWURocDFCU1JBZW1HTjl4MWkxVjduU2NScWpjQTl2aEI2U1REOWwvSCts?=
 =?utf-8?B?amNIbWV3MXN0RVBvNERRRHBaUUlzODFydkdxR2JxRTFhRndHVE5ySWowdWJm?=
 =?utf-8?B?OXJieGl1Q3pMWWxEVVN4SDc5L2JDMzhKbXNvekpkMTRPT3FRcSthRFF3Vkk5?=
 =?utf-8?B?ejU5Zk1KRG1MUnpXZ0N6Smd3S3pyN0YvWkZudDljVm1sTk8wTVRpaWwwcEpH?=
 =?utf-8?B?d01CUmhTRk16K1hTM2N4eWF6alVteFlmakptYWF4ZDZXck81c0JIWGRCYWRv?=
 =?utf-8?B?M1ZScHpLWE1Zbm5tOFpiYnpVandtbE9iLzF3SitPVWI5eXNqSFBxOTZDL3g2?=
 =?utf-8?B?eHhCMlpXL0N2UmhJR25qcXRWTW5mT0dXUEJlWG5wbHc5UE8wOFRYanRQbTZB?=
 =?utf-8?B?RE9zbmVkeWFuVzNUbkIwRUhVbGE4L0lxTzBIdEtWSTU3dWZTdnJYZENZbWpM?=
 =?utf-8?B?SXVTNnYyc1JtM3YvZTBkN3VUOWY0WG0rV0F2R0FHY3ZJZlNJTnFwcnlPcFJI?=
 =?utf-8?B?M3VJa2NXM1FqYkI5WXRhNFY2U3ZoSitMVmhVVkRBVGNnakZaSEFKNWM1eDZu?=
 =?utf-8?B?VGdZTklvWUxrRE0zdmxMS0c2VW8wNzllT3NCMzRUZHNSRXRlUElSZWlkRlNU?=
 =?utf-8?B?V1dwbUZldWVvMkQrRlU3MVhYT3oyVjh4Ti9DSXF0S3VVa0VsVlJlTEg1M0ZR?=
 =?utf-8?B?VXpOUG96OFB2VHkxRkVUNWN0NmszbDhIODlialMzVnVpa0N4SXpxUTNYMC9O?=
 =?utf-8?B?eE9vd2NnVk92YUJ3VXBSOXFlK2hEK0lURkRwNjV2eW1lS0VBSWM2L0dxTldQ?=
 =?utf-8?B?QU9JRHNiSWVXbmhzbW9rc092SzJWcHlsZmFXV3owdncwR085d0JyVyt6Qm5t?=
 =?utf-8?B?dVF5eFUyNmU4VHNIYzV1Ni9waG1IM2NsMjVMQlV3YnE0SDN4NVA3Z2lxWGE5?=
 =?utf-8?B?WGhWTmg3UGcvd3hyUk1QdTU1dHV5cUxLRUtjQVk0QTBhVFplTE9VcHl3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDhZVW5IUlJnc1ByVVdvUkpRTG1iY1YyRElGQmxhQUJxSldIWXppOW5BVXN4?=
 =?utf-8?B?OHZPcW9OcldNVGdOcjRoV0EraGk5RW9pS1g0K3B1KzhQRzZrSFNYcHRnakMv?=
 =?utf-8?B?Y1J3V1Q3VFFSQ3ZYdWp5QldQUWZpL0FHRGFNU0gvMFZrVnB3OXQzdVBCOFFz?=
 =?utf-8?B?cXlLaVFtNXZuTkdrVzFpOVIvSU54Yld2NE5pNW53VURGdmdHS2Y4RW5uSnRi?=
 =?utf-8?B?WnZPaGw3UUVzZWk3a2x2YVIycXlJVmVrcUJoM3pyeTZacTJ5OXEyblEvM3Zh?=
 =?utf-8?B?TjNuZ1MyWEJPRjVZOHk1OFNUQjBZQm5VclR4K3RmVW11ZlJvSVpKaHRjWmtI?=
 =?utf-8?B?ejEzK1JHWldKNTF2UzAzY2svRkpWWnRaS1RvZWQyVTJjT2FRazQ4T295UmRG?=
 =?utf-8?B?cElmeVBSTUhoUnlLaEJhdzYxejF4YU00YnlwUDBMbHMwWlU5RDJRT0g0Yng0?=
 =?utf-8?B?eDJpVldYWHVEMnprNk1QWTNzUmVYZ0tPMzA3NnpESkRmTlVDL09PMjFXalg2?=
 =?utf-8?B?MHpsYWZ2eEJWUHp5ZmZwMFhRbGZYSkhYakxNT2sxcUtpYlk5WnlXRzNXcDFN?=
 =?utf-8?B?eTQxSGU0WGdNcVJ1UGErZGZ0aS9yVWZYYitvUjNLa0g3cjR6Y1BrdkRlZmhy?=
 =?utf-8?B?MXgvSmJaczMwb3ZkTzNuYkREVnZrZVZUS2tsYW9BdGZaR3ZVOUVYUGhUa01q?=
 =?utf-8?B?c3Q3K0FIN2FtTStvRm16eU9namRCNXQ1ekt3ekg3eWM2cUVITTZiSTQzQitj?=
 =?utf-8?B?Zm80ZUVpZzZ4K1VLVjBDMmJ0MGNKVlI5T09aYkE5Z1cwbWptSG8rOWs5UTFN?=
 =?utf-8?B?SXlJK2F3S2FyZlRseEQ3b0liVXVkZEtkUUpDNXNROXBWMWprOEVnY2c2RWlv?=
 =?utf-8?B?YkEyTFZURkxtcWFBbVZMYUhrenNGZ08rYitNckdNQURaZ1RIN2VSWkFpT2JT?=
 =?utf-8?B?eEZxdGc5eExneFQySlBmdWFJbVQrVkIybGFpVEZORUF3U0pTSHB5MXFxanVv?=
 =?utf-8?B?L2drQVlaYUNYVHFOaHE2elJ4VzByNFVOYnJFeGdraWNhUGpkbVNjYlpPS2JP?=
 =?utf-8?B?RDRNSXZwd3pqVGRXZXJDelJBaXFtNEVjd0kzOFc1WkZOdUZLdFc2akU0elE5?=
 =?utf-8?B?UXJOV3FJcmN4bXora1JWWnpuczcyaWtodENCbU1idnphbkdsNXlCL1dEYkdL?=
 =?utf-8?B?YWNxYW55dW1heTJqQWc4cGxsM3JvMUswcFl2VWJnNWxrZGM0SXEzOEdKVTBM?=
 =?utf-8?B?UDBZWEtLZllSWHJGOFRBNENZMWxWdW16cTRmQUs0bGVlUUNqVkgvdklRc0VQ?=
 =?utf-8?B?cnkxV1lPSmttVE1oSElkenJWUjFvRkVpRGlSNkRNeDJNaUR6RXd0SU4zNzY2?=
 =?utf-8?B?KzZlQmFDM2VGenJEVmNUcERzc1M5b3VNUHFtOFhGRFlFY2N6dU8rWmdwR0t4?=
 =?utf-8?B?MWtVWmZXOGRUTTNFYUpMNXh0WUVFMGdoVTkvY0RIYWNFZzVpK0JaRzFKYTZM?=
 =?utf-8?B?eEI3Z1lCclIvKytHVHVsbENSTldleHMzWko2bE8wZTJ1aCtyWWRtOFJ1OEJm?=
 =?utf-8?B?TUloUFdmQXdUd0t2QUpWNzIwUW11d0V5T3JPVk9Vc2pLMkM3L1R0R2FObjY4?=
 =?utf-8?B?TzBTWjVYWnE0S3NBQXFqaXluYWxMWWc9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 521ece09-0856-4042-f2ca-08ddedb63f6f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 02:28:37.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR06MB10194

> Is it okay to remove preserving the other bits?

The WMAB call reads only the lower nibble or the upper nibble from the
lowest byte.  Similarly when the fan status is read from WMAB, something
of the form ((x << 4) | x) is always returned.

> Please name these field with defined GENMASK() and then use FIELD_PREP()
> here for both fields.

I don't see why something like that should be necessary, seems overkill,
but if you insist then I'll do it.

I'll try to send another patch sometime soon, I've been very busy.

