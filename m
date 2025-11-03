Return-Path: <linux-kernel+bounces-883081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE5C2C730
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C713B3C60
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F5280338;
	Mon,  3 Nov 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jk+Q+oGx"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212D27FB21
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180744; cv=fail; b=KUnSZ3CSJfvmOuIMSZAKgXP/ZiEssqV3uYjX4o19P3Uf5vnWQn9rg01RKH57uUfTQr9VvAc20Q/xeVNq3WO+sdTcg9ZR32SH/6AfKX9HJGQrvu4OpH9CiD9wHon6xnoaEAPi0gVrdjgeL3qVXdo7IERnWCIyrponebLyIcDO/Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180744; c=relaxed/simple;
	bh=/wv8mQrcvGJQm91jKXvcY/jJiN8c2vSP0AK7V63myNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NkdJBm58XUZhAy3hjaRaEvnvSXZWvIKQ6VAC9ZXJ/Sl78lkWd8cP5lB2JDVkNzpOoi2p+ZL+DnLIUsw5tDnOKoI5OZwhKVOlQBKho1q59z5ENM3ZNoe7mcgcn9BR13dgT8Ht9Fg895EkBmG7RtXQn+pKvofe3AzMtEQdn423yjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jk+Q+oGx; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBfLre3h0Y+ULfdMrUDdYfTSnVLxrBxn8knkC7fSk+Ax2oOOL6FHIiIUkt5LzkxOkJd0wrYrjIzmOIMDRihZYn3Bm+XLRUU+ZZCR37IFNCDUQy8Cd3RiP0Cbdrmexccun057K7UFhS299f5skw592FH19EoSzLgS/E+2IRXVXDcH4lHYu8/53KXl4wUTzGG3CSanYnjpRZCqpml5PUigSDUE9u4tl5539WXMzHJLS/Vn0PdskIfGsiUwVhZ5DxpbxJfztkTK4jyNmy0zRzrQb6XZEeNZk64E6mrNcIzXBrmz5kocPkxljyRzgGcn5D2vkpIAUzry5vSQL7ZCoD6xNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFxQ6VW6uI49Kl5Iwk3McZF/GYiHIMPk5FJJL69TMW4=;
 b=veHIHuIE05lveJUyY/9eJbpfk78gVZ0P0xVgg+MG208oLYJ8oL5pkgzFoCruAWEwj6IjWbEaMS+FKZI86qkfeW+iNkG1R9c76p3iyd/PYTQjm97ord9AQY1YzJEflwi7q+3mP0xFkhq2EWR7LxPKHQ1Uu06ns9wh62z7kNVOa9sVkxK1EkbaDFDz4mfSHkpWDC3i9Zj482QfO2cJ+6VW2uccGL+7kGBFb+TqB8wP1/LGstMP4cL8b4MT6Kb8aS6MIsie19L/B5qDyRYqckxEXdVIef2y29EcejPdVGC1cDzVDvP/F88XmsmIUC4XlQM7C85nanWab6Jp9LkUiMq1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFxQ6VW6uI49Kl5Iwk3McZF/GYiHIMPk5FJJL69TMW4=;
 b=Jk+Q+oGx5CV+SDZ1Da/Ljoe8Z67Ony5T5UG/pX0lkUcc3I2tm6fBjj+2FaqgWcfe4enlVmN9mVuXRvc1JK5URDglrmqkWenLnQzJAikuXCTRO5uxxqewDyNME5Wo3yKX/7y1fhvfcOdoCpz2dnDXhbi8jqaGcChBn9EEw7gyfUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 14:39:00 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 14:39:00 +0000
Date: Mon, 3 Nov 2025 09:38:51 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: x86@kernel.org, regressions@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: AMD topology broken on various 754/AM2+/AM3/AM3+ systems causes
 NB/EDAC/GART regression since 6.14
Message-ID: <20251103143851.GA8673@yaz-khff2.amd.com>
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
 <20251024213204.GA311478@yaz-khff2.amd.com>
 <20251103084021.61971a89.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103084021.61971a89.michal.pecio@gmail.com>
X-ClientProxiedBy: BN9PR03CA0475.namprd03.prod.outlook.com
 (2603:10b6:408:139::30) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b39c91b-e4d0-459e-3dca-08de1ae6b9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhHC4p4FznPdLiYmsWsVm3i37gUHqisnrlck2CNI1GOehmrerkIQsDdG0YUc?=
 =?us-ascii?Q?bimR1PxH1RYX4F1URhIyUun3tadThHb1otcO69BAyKINQVckstW1an1N27hd?=
 =?us-ascii?Q?5kUdqzNx3toLjNlz3b28BDbGGTceuQD8eom5mDHdDfAy43ZcrKDAo3z0dpE2?=
 =?us-ascii?Q?hj0eBtD+D3x+x/3kk+QgvlwLqSYAb9uALj0qBhsOzwi+JmiVRo13Ml1VSsmY?=
 =?us-ascii?Q?0ghVmJCrB33wMDQ3d1P7KhbwUjAmTSXlI/UinDVAFTIPh1pmddnzh0meOdN0?=
 =?us-ascii?Q?t9IHBJo5Y9vbfIGxbAoLPnZx7RWFIjs79ifCjGsfKL0/WPRNAmyOqA6MF3d9?=
 =?us-ascii?Q?4ykJ1vOW9zY5tSnP5N+rbrJfjWX4dstvRBcI1IEongNXvP8w/DVEmFUWZ9tz?=
 =?us-ascii?Q?uUD1FaLJSz9lnJKFA4abbQqNi8KiqPTOvHo4W0d0cWs85Pjn3I/LXI0yH3Ed?=
 =?us-ascii?Q?jbCwzhDl+1juch/eN4MtXPwz71GwDwYf8iMPHLphYFI44j7gj7qzx6qZBcR0?=
 =?us-ascii?Q?RzbaJ/GUg9PkKuo3+hbom4DPjsZbwAVHI/qsCOXhf5/+XBvM7O3NLXgF7TH7?=
 =?us-ascii?Q?h/g5/6AZi5NdGNL4BrJbsE9WimZbJZRTAxSQVKfKwBEBfs2uPrHZ7nlaUbIr?=
 =?us-ascii?Q?I8+6XM4jVNE2lCQEvm1HtnToV/6bs2uUw9v758lRsXX60UEdVsZNFAjJzggv?=
 =?us-ascii?Q?+iHIQknh6KjYt3FVGqRSXKr1RVgBls21TqurL8OUmTUJXekJ0Oou7J0rJ0aV?=
 =?us-ascii?Q?Et3b0r3KRw+gtaXyHiPLyz5ZOntkhWYMA5KKtmwSUYeKUyRXiZjLASUdKe8+?=
 =?us-ascii?Q?YYgDpkmITibHU4PdH54AKLZaECSMERJbzf5yShsCkSu9l5wBlQsBj1dFxcwr?=
 =?us-ascii?Q?G4Umursq3Ky7MPGEkfKHPG04DplLeK1ODp2mVpxVr3GAah8Xu4//fMhOj+em?=
 =?us-ascii?Q?26YBDgeJlt+uaIboAgk9TYWTLzLYzGCPISvPPRBc5WvnlfJuqRYQ3VvlBFzl?=
 =?us-ascii?Q?qt6ahZXRu0afZzZaW5MNxmLTPwNk6grqZa8dQBT0u4wIyoghHPneumZkiq1J?=
 =?us-ascii?Q?YrP6bnnfNg8fi/Xpt2SnXRsiAyPLae4PiI04K8AsS+MxPHeMEkZe6PHrgWDp?=
 =?us-ascii?Q?n+c54x1gl3WVhyHrU5lkVnyTpdLCktNdGRQLnX5bTJdYZhxQCLAxXZtSFQuc?=
 =?us-ascii?Q?pBOGUBZuCuX0jyI9W1wwIRy0anmgHFKnRlYuk1INwWa3Uel9hlWFfTOB22kf?=
 =?us-ascii?Q?uIlEZ92g4qeR4RdSZKhgiBtg2Dv8FqCGH37DtWTyI+pVeJxRIDLLHnWewZGG?=
 =?us-ascii?Q?7xWrPT+tBYfSZhs4N2CutwDy3aau+AiQthmGIGLjvMsGe8Px9z1PmsczpRVt?=
 =?us-ascii?Q?s0SMR19uYBURnRhvLda3tE0WD8aucyuuJJKWFgYMkFg1tuPyjC3O/4vahE2k?=
 =?us-ascii?Q?yiFjYtV2Ik4pqJLRr/w6NEDEu4eH2Ytb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Om4ybgCR08t9Bx1YGX417qbehr+aKiajMsALKrxTpMJJry1iT8V6LaxrgR7T?=
 =?us-ascii?Q?h7gyxzsLRNh/Grsx6DxERl6smX5Mmwx/uujyG2F/BydyBGz9Ws0Ph2hwlL/q?=
 =?us-ascii?Q?VCmdYvpLBYqVgLI71hytj9xcUte2iSJmK1YiaO98hCEFpwnScOo0uipfaQH+?=
 =?us-ascii?Q?8tWgGznX1YvSPCkSSKmbI6zr5boaQytr92DHQT2E3fUhtYEAOk6FtdYcwKmJ?=
 =?us-ascii?Q?mdjg72u1foAF29pgd9piAJinfYVVIiuV5p3CWTaSdyC54QA8jsea/xXj+Q2A?=
 =?us-ascii?Q?abuS2WgWHSA2zpWMgiCYsptUK6gKL982bCrQIOWEsjlRZ4QG5DmwjinF1D6K?=
 =?us-ascii?Q?x6JriEU8jIsmLffteiAzHrCa+iTAJbp6+KOcedxlKrZxrgbxixDPezFBmFtO?=
 =?us-ascii?Q?juBGQ0F4+YcnukvxBnZUf7UhB0LfzAXK/HJpfnyybr7c1gGMz7pB0o3s9kwp?=
 =?us-ascii?Q?6unhWKAuOQr0cgjrVM2YNCHqAXE3E2WUSlPV/i9yWY6/PXRgx+xoCYi4ZBsH?=
 =?us-ascii?Q?rjSYBNpUdIoz7so+AffU3BDqisECMJo9QNQJz4gLV5m0V3IXM+/i8obRGpPA?=
 =?us-ascii?Q?C61qqv0LsLU90kHElWSJib+Od+C/IS4SY2mFKiOu0Svtnl7VyivfuWPIr3RL?=
 =?us-ascii?Q?r/i/Nmwivf3Kn5toBtGJcakOsoWs6ojUuHntURMcxQ6hfAF7XzwrUm1D6m/m?=
 =?us-ascii?Q?ZlDD310M2Tini0OMITB89/G91LhDNPpi+QGH/6fMh324KlWtk0TVVvG4riWd?=
 =?us-ascii?Q?A1hdSdOcES3hCT1oGvk6VdpQ8lg9lYRu2lDjkK9dZpn0XzC2NgU2UhC+FHzw?=
 =?us-ascii?Q?clQ/z8lJT2QwNDzQXLO8fqhfI7ZKRjsJ6+Xm9dnxCcXKqkMRSeunO+humrFt?=
 =?us-ascii?Q?nl4P0C2gNQWSvotd46dMStkGLLQanmR1hM/r3m3FeZaK6zWEGwif7HUj6bsE?=
 =?us-ascii?Q?4VF9iPCJKCm0Kshs6k/cJOMnG2X2k11sc7UNGlsID2y+1DGn1QckJjy1bo6E?=
 =?us-ascii?Q?lrXLjtSgf3ILwf0ErixtG+YZa3m0yzD3jmeQ0GQVnPg70li/rpTRmsoK14WR?=
 =?us-ascii?Q?AviXNTgDWx0uEPwirfBQ1V8nz4SX//l+gT8AI6/TwKkN8LjwRVwQUCsAK6Ex?=
 =?us-ascii?Q?gcREgdhU9/WDLEe3OlkFwqwdlP1UABZaJ63SivHbMaMckcAQcYEBU7ACYRUN?=
 =?us-ascii?Q?jscSYDRB1b3W6cz9DkWhJ/T31W4Jz6xKPdlmZzflpat+6npEhSnAWWAlYVvY?=
 =?us-ascii?Q?U/ufX6HJVVthUIysNTfwYNGG3Ebpts1RPHCvYejRLQQMWwjirsiF2qhDxjAU?=
 =?us-ascii?Q?neFXnh0EmdrRCyfhbelxwkr7qVGrg36WNKw6ESRN2IUd0NKC5x7VragGoZFv?=
 =?us-ascii?Q?Ys2VULcyuqEEYJCB49CqXUBQqf2F61gOLd/bpfLapPBcJOSsCTRjXYPnmo3i?=
 =?us-ascii?Q?peTj1yrlxgpj1buCzo0FZN/nrBHzUO76UXFvHOh+BG7C8rmbWh42jZYfw8j/?=
 =?us-ascii?Q?Jd7zRKWQi+cUyvOVjzMJ3eh3W9kl0hCXBeZ1M6Dx6rz9ZdfUaGNetD5XERAn?=
 =?us-ascii?Q?ICAECvCMlhc15hOWY/djrtJeRawFq5FrAhlR1C0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b39c91b-e4d0-459e-3dca-08de1ae6b9d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:38:59.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8LQCI02ycr77c4qGCeogZ5C7HEXt2en4MC4jXNrOcl+436dlIbBCdyKMJeyLBRCNrR2FJgq8MW6gBOXdPVfpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

On Mon, Nov 03, 2025 at 08:40:21AM +0100, Michal Pecio wrote:
> On Fri, 24 Oct 2025 17:32:04 -0400, Yazen Ghannam wrote:
> > So far, I think the way to go is add explicit quirk for known issues.
> > 
> > Please see the patch below.
> > 
> > Thanks,
> > Yazen
> > 
> > 
> > From eeb0745e973055d8840b536cfa842d6f2bf4ac52 Mon Sep 17 00:00:00 2001
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Date: Fri, 24 Oct 2025 21:19:26 +0000
> > Subject: [PATCH] x86/topology: Add helper to ignore bogus MADT entries
> > 
> > Some older Intel and AMD systems include bogus ACPI MADT entries. These
> > entries show as "disabled". And it's not clear if they are physically
> > present but offline, i.e halted. Or if they are not physically present
> > at all.
> > 
> > Ideally, if they are not physically present, then they should not be
> > listed in MADT. There doesn't seem to be any explicit x86 topology info
> > that can be used to verify if the entries are bogus or not.
> > 
> > Add a  helper function to collect vendor-specific checks to ignore bogus
> > APIC IDs. Start with known quirks for an Intel SNB model and older AMD
> > K10 models.
> > 
> > Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  arch/x86/kernel/cpu/topology.c | 52 ++++++++++++++++++++++++++--------
> >  1 file changed, 40 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> > index 6073a16628f9..704788b92395 100644
> > --- a/arch/x86/kernel/cpu/topology.c
> > +++ b/arch/x86/kernel/cpu/topology.c
> > @@ -219,6 +219,45 @@ static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_leve
> >  	return cnt;
> >  }
> >  
> > +/*
> > + * Some older BIOSes include extra entries in MADT.
> > + * Do some vendor-specific checks to ignore them.
> > + */
> > +static bool ignore_extra_apic_entry(u32 apic_id)
> > +{
> > +	u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> > +	struct cpuinfo_x86 *c = &boot_cpu_data;
> > +
> > +	/* Allow "physically not possible" cases if in a guest. */
> > +	if (!hypervisor_is_type(X86_HYPER_NATIVE))
> > +	       return false;
> > +
> > +	/* This model only supports 8 threads in a package. */
> > +	if (c->x86_vendor == X86_VENDOR_INTEL &&
> > +	    c->x86 == 0x6 && c->x86_model == 0x2d) {
> > +		if (topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map) >= 8)
> 
> Looks like possible functional change compared to the code it replaces,
> perhaps it should be a separate patch?
> 

Yes, that's right. I just wanted to put everything together as a quick
check. We can clean it up if things work.

> > +			goto reject;
> > +	}
> > +
> > +	/*
> > +	 * Various older models have extra entries. A common trait is that the
> > +	 * package ID derived from the APIC ID would be more than was ever supported.
> > +	 */
> > +	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 < 0x17) {
> > +		pkgid >>= x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN - 1];
> > +
> > +		if (pkgid >= 8)
> > +			goto reject;
> 
> Yes, this works. The excess entries are counted as "rejected" rather
> than "hotpluggable", package count is correct and EDAC/GART are back.
> 

Cool, thanks for confirming.

> But to be exact, the known case is (apic_id >= 0x80) rather than
> (pkgid >= 8). The latter assumes not only that there are no more than
> 8 packages, but also that their IDs start from zero.
> 

Yes, that's right. I see these checks as quirks for old systems only. We
just need catch the bogus cases. These shouldn't be generally
applicable. Though it'd be good to catch as many cases in as few
conditions as possible. My thinking is we start with more narrow
conditions and expand them if there are other reported cases.

> I have this AM4 system with some proprietary HP BIOS:
> 
> [02Fh 0047 001h]               Local Apic ID : 10
> [037h 0055 001h]               Local Apic ID : 11
> [03Fh 0063 001h]               Local Apic ID : 12
> [047h 0071 001h]               Local Apic ID : 13
> 
> domain: Thread     shift: 0 dom_size:     1 max_threads:     1
> domain: Core       shift: 4 dom_size:    16 max_threads:    16
> domain: Module     shift: 4 dom_size:     1 max_threads:    16
> domain: Tile       shift: 4 dom_size:     1 max_threads:    16
> domain: Die        shift: 4 dom_size:     1 max_threads:    16
> domain: DieGrp     shift: 4 dom_size:     1 max_threads:    16
> domain: Package    shift: 4 dom_size:     1 max_threads:    16
> 
> It seems that pkgid is 0x1 here, which is not a problem because
> it's single socket, but dunno if HP or somebody else couldn't do
> similar things in an 8-socket system and end up with pkgid > 8.
> 

So is this another bogus case?

And, if so, it works because of the "ignore hotpluggable in present
package" check?

> 
> By the way, do you know what's the reason I don't have /sys directories
> for those phantom CPUs (before this patch) and should I have them if
> they were legitimate hotplug CPUs?
> 
> Maybe there is already some check performed in other part of the kernel
> which rejects those CPUs and which could be replicated here.
> 

Sorry, I don't know. Maybe others can comment if they have any pointers.

Thanks,
Yazen

