Return-Path: <linux-kernel+bounces-743140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A0B0FB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF777AF91E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688FE1F4176;
	Wed, 23 Jul 2025 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v5MdVD98"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68842E630
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300008; cv=fail; b=Cp2RBiAzphPYBzFV+uagBAL9sEfaYIzLE9pB6eTjzMqvwzTuNEDH5tzD6SFWhxU/hUYYb+tY1ObH9FfTof+SDTZiVfRIGl2oHQcevp6322TFruSv0y1yVkUw9Nx5M0ZoDY0WZKZdB5alGgtJbop8/UY4ux8MNhSBvnr1qoT0IJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300008; c=relaxed/simple;
	bh=wOSShY+n+gjJDko7lvSj64yg6r9lzQFfhma2TaVOjec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eKO+7RgD2+W0Zj4Y4uXukq2iVen99G0E3zXW6U6COa3azbqpbumACBIKJXKqrN11+LNmaXz//szoW9ha7rpLiw30y8W3QKYjgr688FLb3YAYnZatBWEWP2LRtS44puSQW6vIn8KBUUO5kkZ+Fo3+oz2m37EIJkKZf8b/wubw2Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v5MdVD98; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNnb5vwPy1Kbb91tOJPfXxjbm/aBpEqPY7oFVA9oYdxfl70WRcEhwjhNqmwl+X6utcCfKrrEQnObyXhpd1MXhrOTsm55cQ3eeBBJ/7Hye7iF5eV2uigv2Bfk239gMOdn6HK1ka55Y9+ar4E9T7E6tux4JsBSQlZNM/SAAFHbAZT/3eNsdDyJKiVUzB/AhDfg2zDx6XWeZReMMQ3Ja7IKJhGf3LoAWdItt/D5PFChm/K4DRX/02bYPxG46pOQNp9CINf0GymVMmlhCngqsBBwvehXIhJPQkNnbIJX3r6E8cGmTbw0EQ1SwXBwXsNttmQe8XoH7Ju2/I0bIPKUjnQxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmQAproEMnTSl+z/XOK1WRkTu/KfZfgxgrxdPz3CBZk=;
 b=oDhV9sTjlK2niXKO9EHCdFBCBonxVOPf0fIJ6iRM/4HaUxatWXaoooIYr1w8pp7+boa3eXX8RCADukkzmA0h0U3YRhAlUTRsGI6xbziGBfzdgtpgAAWcM9/AR9ScKw92DW2Fh8b+bYbB+xaw71qZVn/fpeZ61FZPGpuYopgXYTH7G7lA6FV4Xxm62s9S2xt2PXkvUSMtvtR0+HXdYeIcHC9pZ4HC8X6fQIqiDMI25pondwDyRaN2D76jsSabPoeFF8024e2JTBYmqcZbR8BUomEVNFaB7T5jQE7xDw+NBT0SoO8pKMUARmMge5rW3SicO+wxgh4ooHidf9QROKOO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmQAproEMnTSl+z/XOK1WRkTu/KfZfgxgrxdPz3CBZk=;
 b=v5MdVD98DcvWw/eaN/avfWwavmDtB4igmmpgmsFn6pXHsuu5sed2Dg5lYbRzKAtLNuhLTPByokBE89MbPYF485clSCINd9s6oIwfkVCziPBsZzbCQWlD/asO7csdm8VowltPLb9UODZv5/8FlpzD9020w/rZLx+JjuZZ7pVm6oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 19:46:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 19:46:44 +0000
Date: Wed, 23 Jul 2025 15:46:39 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Libing He <libhe@redhat.com>, David Arcari <darcari@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
Message-ID: <20250723194639.GA1229722@yaz-khff2.amd.com>
References: <20250721181155.3536023-1-yazen.ghannam@amd.com>
 <20250722165615.GCaH_CryG7kNrAS4O6@renoirsky.local>
 <20250723183426.GA1158000@yaz-khff2.amd.com>
 <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
X-ClientProxiedBy: LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 400087c4-53c0-4adc-9fce-08ddca21a6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Al/sz+b3VpkZbSsIVBdLoUhEswq6XZaQ3Tf+NywpCM4EOu3x3fyzB+yEBAmE?=
 =?us-ascii?Q?M17iBeSNyWJABKecfTozXuMVbBNJW+6R8eVOzpOMnaXpvT9HHxRQzNVWti4B?=
 =?us-ascii?Q?ZoCBwf13BvJnGuCRJSZ9MRyMBhSpCxHAmgiPgIdemUHUvCfEq+XIZv00V2Iq?=
 =?us-ascii?Q?vIIz9QvgdVy1ph2nwRCjHd5fxbAfKl1kYaul97sgzKEDS6wmcuqUmoOlQZW+?=
 =?us-ascii?Q?QfWqeOmXDcjgszYKRTi9ScBjBZ/l+7QOQdquZZt06sHYcXzloXO0lK93JRyZ?=
 =?us-ascii?Q?Im3LEvjqo1YgN5d+26v04QZWygzvGzuPzP8aLGmssnjXB/QV03MFaP5MG9gn?=
 =?us-ascii?Q?1BsFlI1gQHYe1oZZro800GquOunO78fwTguwcOs6/j96YpRn0qpq5hWwKcEp?=
 =?us-ascii?Q?iicdjZwvCvLaXoyOjg/dmcsf1NfjTfOf//X80kkvtNFzUfl35vrNGvEKOCw3?=
 =?us-ascii?Q?2w85yPoc1kdvHu1Cp5JLP6dUL5XG+rDdQggGkC8qmnX5R6maVYzn+X9tpqy5?=
 =?us-ascii?Q?RYZ3TSKYb1Q0ZMKvoVHAMPHBZ4MXIDVNj1sFPfM97C8fybNbOWAG8n/AW7yb?=
 =?us-ascii?Q?8FafE0bZrQMCp3hw4aGu5YfDnKqQzBD+U/1qbPGcP9zC2gyO0uMkisMWemp+?=
 =?us-ascii?Q?VwllKrz3My6jsBb0G0BkozTh91s265/4tKGdRJ481k4P+QPfh9y12nYLb5gg?=
 =?us-ascii?Q?kGv/qVcnEJj1igPt5nx/feZHzE7IlL6CqmGLHeH4p3V1oAw+0JQAGCMoDvcY?=
 =?us-ascii?Q?bBtIZebkk5rrA78mvx5svnDCkt+TniX5WrfwA2YPCcY6AtvZ1GM/q9iqlbwj?=
 =?us-ascii?Q?w5rJltBlqm2tH4hinZxmZdipRmIkwBWOs63/isp5r3l3ZlxQygKy7VdqTYsk?=
 =?us-ascii?Q?+0qZnK0Enh4TgHL00jYuRYMsCLHA0GkRJVxJtcj3hJRUeIY6SqgfjxqHD0xx?=
 =?us-ascii?Q?A8pkbBxs9q5jvuOQkc8EKrNaVwurac/dFTHd0SULPGJcDhYbEMu0iht0bZIT?=
 =?us-ascii?Q?7b8IUmp1sbiA9184qHdApfjYb3jnROy4dYRyk29tNw+N6l+2XrUjLvSjaWz3?=
 =?us-ascii?Q?ePmF6xMGBJNz6YWC6yDuazhuGVvc2mOCDMiH/54/ACP2xQ2IFjnsCOnzcGpE?=
 =?us-ascii?Q?93zqlV0ET7FYIRAs/oxvnNU47Jz6JTksjFOT/C1EvS97d+boIFbyfeGZ3v1w?=
 =?us-ascii?Q?DzkP72Ea7B4rQa8bGftXxMykpTQgRzkpySkrv/UNR8WK1AFiZdk82VYCK/LR?=
 =?us-ascii?Q?Xqvg2CKAo4SCj8aoYIQ9t5iNZvL0pVDfdhraEZvCG2YYxEHmnoWB29Iati4M?=
 =?us-ascii?Q?RwA2yCIw1IMzP0HKB5JZ9RKmeBjAiAPhhZddS1i4Y+YqAAuS+Ce/AhBoks7w?=
 =?us-ascii?Q?9g293v0ZRuh/PfT2RVGX70V3cHABNPo0q9PqN0ot1YKsovSaxvqFlVn389/G?=
 =?us-ascii?Q?NUxV4LwF/us=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGMH5OQ8tAlaHmpz53vdGF0SyrRF6HfxTJumfe09CAUJ00N2b5AulMIN/zic?=
 =?us-ascii?Q?xxzpJkGFVAl61PmdT280qWWKU76d8z36z2T3LWKviqEy2htsu0FcNyK0cYoL?=
 =?us-ascii?Q?MfINi2EA3y8lJBz7m+EiY2Qs1L50nfTiKn4rM3DF0hK5xEn8Ev4bTv+pPaV2?=
 =?us-ascii?Q?Yp1US8w3A+KioctSsk++KVH9/uRbWK/TiERcdXo/GWWajiv5/STnkWVouVb8?=
 =?us-ascii?Q?yAokVBKm050CZ0bORcNNAL1arxyXgPbLbNwALWp6l4gJOMm5kKJ1uQt0j8VE?=
 =?us-ascii?Q?4dg8qzCL+nNgmBFCb9NQEZChrVoTvZaRG1uy5+59Ly/IZUA9UUliy6o2jn4D?=
 =?us-ascii?Q?J29twT73oPQYW0hRlEhjBJ76QLvzos1J5krLI1Ep0vIj9s1byzWw5fH3Pkh7?=
 =?us-ascii?Q?71+++WwWQI4LvgDrq+yrfFLM024KXOZyF0Kw5SVtZIPsaeOUK6xMc+VhhyoL?=
 =?us-ascii?Q?4rJmVm125PpYu9z4BnM2hruPuztY/ddCN/7FNW94PMCxl3Nn2Kd6aZ+YQA19?=
 =?us-ascii?Q?QZlETzPS4VhtEJFI+dEKZ1X6BruCQw4uVaS9g92IAm3dLrr40qSb2uSf3Y95?=
 =?us-ascii?Q?bAgmF++3lFe+V9NwZ1Y9Bzy77RG55AwuevzMdYTA82msevp6LAXPBALoNDQN?=
 =?us-ascii?Q?orU55sjwNwzm7qEVbJBEBMkyCOlirIo7MO6lVRy5sh7q2l6yeHdCUVDoyI0O?=
 =?us-ascii?Q?Ub+TFsrZIyScq9QnbDfsqxDkiJdpYIJNZSEWF8G38ykXx4UPh78xy604rsZ9?=
 =?us-ascii?Q?NJOosRCrM65wNVlKtP6HKJGFLaZX+Zogyl9+zBAE5mfSmNBlvroC/hVkNWdK?=
 =?us-ascii?Q?ZEe4a6Wbj1Z4PdyJ9wl5ZTS/S0mCcZpdqrvl0U9fsoMHg25F7hxKMT8M63DG?=
 =?us-ascii?Q?T0CqrU6Kggn7YUY6ksYwXymWo+yqwefzazo6ION0U7V+bPGw984UvDIvotmQ?=
 =?us-ascii?Q?l/1Tn/6uN/olDlTyW9EawWW8qGmXDJypmOHySRi/AscAsrQkB6107n3+BwwF?=
 =?us-ascii?Q?pGfyVuoYtifHIOxJO99c4yMSGcAP+IjOH0VhYzWFtlvsVqetZu+vFhwPH3rK?=
 =?us-ascii?Q?VIlQyd9Cs88bmACSIuy4KriDzqsKUJX7fSsx3ODGy6TQ4saQIPi6laSbxV3H?=
 =?us-ascii?Q?Pkv99eMAYMPm3Jkz5rTIv/5Xby7BziTdXXZNMx131/XowHOhKw74JE6tc43T?=
 =?us-ascii?Q?DKl9B3DBOqFZidH9qR05iDVUyvRaoIEb50qGKwU+ruzQsfP/K7c3hcgk3feP?=
 =?us-ascii?Q?G4YUrXoTZmVUXUj6b4zPoSB6T0iREvsryHKkSVt7Vvz0eVXIvWgFKT0tg8XK?=
 =?us-ascii?Q?P3M0oH2yhWbTpIQ5RSyFWxMGcQJiX8DrOMuW3Ccep4Aegg57+D2Sd5YOnY4z?=
 =?us-ascii?Q?o1vQOWhgsamqq7sfIqYR5lOVHXsS4+/BABtcW7OXXHKMI6mJCRHEbaUtHFWb?=
 =?us-ascii?Q?oyFOdzbkxPj66/3GXzNB/FfNtqlqkjmolEFWn/Y1oLWDk21zGgbpFevZ0Fe6?=
 =?us-ascii?Q?ThRl9350RWdKVNB5xuyPeh5w2coC5mujmZy/Cx9+utCYb+kHopja414W5dhn?=
 =?us-ascii?Q?1t/pQNvzUE3zraRYhwOWswI7WLR1bNwOHVX6xm5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400087c4-53c0-4adc-9fce-08ddca21a6f4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 19:46:44.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmA/4ZNLyjPgAN7yb9X9Q4/tfBBCuwktZtbMli6QvQ0ZroZ0D73Wu4dU4uiu9tXheD3z/wSirt4o6UH2PLasiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250

On Wed, Jul 23, 2025 at 10:35:31PM +0300, Borislav Petkov wrote:
> On July 23, 2025 9:34:26 PM GMT+03:00, Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >On Tue, Jul 22, 2025 at 06:56:15PM +0200, Borislav Petkov wrote:
> >> On Mon, Jul 21, 2025 at 06:11:54PM +0000, Yazen Ghannam wrote:
> >> > The reset reason value may be "all bits set", e.g. 0xFFFFFFFF. This is a
> >> > commonly used error response from hardware. This may occur due to a real
> >> > hardware issue or when running in a VM.
> >> 
> >> Well, which is it Libing is reporting? VM or a real hw issue?
> >> 
> >
> >In this case, it was a VM.
> >
> >> If it is a VM, is that -1 the only thing a VMM returns when reading that
> >> MMIO address or can it be anything?
> >> 
> >> If latter, you need to check X86_FEATURE_HYPERVISOR.
> >> 
> >> Same for a real hw issue.
> >> 
> >> IOW, is -1 the *only* invalid data we can read here or are we playing
> >> whack-a-mole with it?
> >> 
> >
> >I see you're point, but I don't think we can know for sure all possible
> >cases. There are some reserved bits that shouldn't be set. But these
> >definitions could change in the future.
> >
> >And it'd be a pain to try and verify combinations of bits and configs.
> >Like can bit A and B be set together, or can bit C be set while running
> >in a VM, or can bit D ever be set on Model Z? 
> >
> >The -1 (all bits set) is the only "applies to all cases" invalid data,
> >since this is a common hardware error response. So we can at least check
> >for this.
> >
> >Thanks,
> >Yazen
> 
> I think you should check both: HV or -1.
> 
> HV covers the VM angle as they don't emulate this and we simply should disable this functionality when running as a guest.
> 
> -1 covers the known-bad hw value.
> 

Okay, will do.

Thanks,
Yazen

