Return-Path: <linux-kernel+bounces-885047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD6C31D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617A13B9554
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D724258CDC;
	Tue,  4 Nov 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="13Yqiuu6"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086F215F42
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269847; cv=fail; b=O4YIVxe5ZJhaAak9OdyDL8VEF4EpXvKJnbCq7yK5jF3XQJNDTTxRHXZAdS+YjviNpi0Y0n3gVQB64yymlRJh86ZtpC23HIv0gwfZ2x0Y2oVRXaDGno9yifuACUAixX/QG3q3C7sWgnSmE3KZe4UZ8S8gVAVGHdeesCtx8M5YujY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269847; c=relaxed/simple;
	bh=QkM8HUFC5uC/wzmZ3bslIwdDSE2OKdXDMvPIBPVSWS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VNBOg+NyZbIu87xJlmQzrI/Y+2djDLf3Ectl9jD5Lu7GNSAE2loqpDVDk8MmWeKpO6vJ0o/LN+vZ5tMKldvvoNWxgDONLVFLAA6Zo7adsWXShcFfTUtH956LZbr+RG1p88esk0unCDmTOhoUJzwQ/IYfvYdIgFfIu0TEaXsk7Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=13Yqiuu6; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjLVp1R3sYuUIjF2ka41s0YzzCs3rt8Co5BedL7VUFRpcEnJF8HErWN9heSHV13hKF84GfVIzIdyIEMGFIzCg6udj7ixM2aQ9RbPa+U3+/ciOOAh6TDOcNAnC8UllBNikK7sOBXicIMVmes5xDsaxTt8Lxle24eeQ41Th9cPvkXPrjbghn42ICmiUhob+jHMnz5ZXn6ALZeuwRa/qVYuWFM0upweG4miWbhAygQvyEE713j9qnLQV/uK5LrQ74HeW7nF/ZLNwtZOTCKgbko5APsExPLniHGFGCnLYdmDcp5ylySEnFDA3ZoFIl6b2p1i7sFThDNFpIszyVHcRdbuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUgvJnY++btKnemUJrtxlUV2ZotuYIWGqHemr1DdLB4=;
 b=tbAWmtubPmP9zNq6mwI9+bAbZ5EU3HV0g5ajMy3X7+K5L3xfnV6FRrh3BRDMn7OlJ6wLZ2DIiOiyPDJVUjX5ekVHaonAAc8EfcpPy5sRwBZ6KLIRc9OEvv1hGSIw8jV8Ve70dJ7w+3Y0tx9MG995jobPYGAkmTn4K365rTeC7P7XoLVMY+EuxyfOIi6RntqzG3Z1sGEHKLSwpzejr2FkKrTg/ClhhhqIYEcnEyXyOKs5ZRmOTJGTN/N2EmIR6AE/hjwK759dq1yWQ9IZebRi/UkeGmMkaga10AgjhdjLdolb8IJEF8ZVcJxviwYoAXQYLg+Sx1itK9KdQ8ihE5xSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUgvJnY++btKnemUJrtxlUV2ZotuYIWGqHemr1DdLB4=;
 b=13Yqiuu6CKgDAiyvZEYXeZm4rPLvN7j+IVdZmy3DiDQ/+gkfJ9OJlNrA8A+06/Y5+4xZpn1B8V+sFsjPpWi/43pFqpERbGH6oWiXN50EQD/4MTpM/+uJH/EF/MLHfoa3s2ADruJ37oevxQrXHi8LsJw+fMDPmOaDbxpd2Qf25tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:24:02 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:24:01 +0000
Date: Tue, 4 Nov 2025 10:23:51 -0500
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
Message-ID: <20251104152351.GB452990@yaz-khff2.amd.com>
References: <20251024204658.3da9bf3f.michal.pecio@gmail.com>
 <20251024213204.GA311478@yaz-khff2.amd.com>
 <20251103084021.61971a89.michal.pecio@gmail.com>
 <20251103143851.GA8673@yaz-khff2.amd.com>
 <20251103181245.7745621f.michal.pecio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103181245.7745621f.michal.pecio@gmail.com>
X-ClientProxiedBy: BN8PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:408:70::41) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: a9071b0d-80b0-402d-89d0-08de1bb62ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EkzMquYrq6y4YvSeffTsIMTNj6cf2fH6xYCsci0KAyG60f0LT5K2OGV6TdS?=
 =?us-ascii?Q?RGg/sLL46Qg5Xh7+8cfnF3TEZv8izPPApIS88rxpplHU9KuPOIlzUn7o4gp0?=
 =?us-ascii?Q?3VJY4NIQHqAUe+DW6ncFoDODlkzzfA9pZJ7iAvalG4BuINfQrsN5i19ClY9g?=
 =?us-ascii?Q?rp9GUTMdQ8HvawS0ayXSv4bcAeiee4ZLz406xYYMnLQA0hEV5Z296j1NobDS?=
 =?us-ascii?Q?VXIaORGLFYLv7u/BVUeKeCqtVIEwZS1CjlssnxnP0+xwQQTzrDrHXqT5Ipcb?=
 =?us-ascii?Q?LwwOjmEovQxxsOc5tSmB8yZJCDivshhtQbOLNFAlzl3K/8vWNe7KMG8B73wj?=
 =?us-ascii?Q?MVwfYvJc2w0KUvwflI2pPWTQ/XcPSUrtVcN8QnDIETcQJaiFxGn1xXlnqhWk?=
 =?us-ascii?Q?SdzXPLQLVBY7DNRK/+ieOdP0k/MS+WBYf1CT3tPyZ41v9/+VuS9k/Gtqn9+5?=
 =?us-ascii?Q?Sl1w7NCOVbafqUAB74gmpa7EbZFWaplUC9B+Fg6sI4ANCMtorgCa/s8i5a9Q?=
 =?us-ascii?Q?m6dc6WuM/RxhkSEGP4Y2EYiuLOmMGNkkYgkL5JKSF3aHCjNwk2EUxXWfr8Gc?=
 =?us-ascii?Q?PMJpr8I8e+2//9e8gzQSL0oyAWCshQEfV4fw0j3AoWzplZz4eyZ37kftgwFG?=
 =?us-ascii?Q?zKoQZhpl45ZsdeMeRNyM27OPWqUwt0OrnOgj91hvQ2cDlv/e0llAPY/B14JF?=
 =?us-ascii?Q?of//OBUZj4JIdVbYwuqPq584NdMycRElQMOF94Lqw9vF3crI/HG/GyWffYTz?=
 =?us-ascii?Q?lnAE62K4ITZpJKUcYjEWC1abU7Qf6yVy4C/jBoQY28fF+arP8GM90mmKqLQ/?=
 =?us-ascii?Q?vgdEYeHuaXj41X/GpE4+yiabqu1ZbC3DEOeyEaRyJ9XlYyHlRQ3qn5rm7oG8?=
 =?us-ascii?Q?jaDv9O0OFyDGL4wZakh6CO272+SpfwGoa28CwNahrZKfPAwbwYE7TcBDvTUM?=
 =?us-ascii?Q?fG85/ql1JiA/RlI70kizdUrIsuUlkamn56mR97IZIfwh8L7qV0KF/TEFC+8D?=
 =?us-ascii?Q?+kp0S7vwmlKnIkK9vcz51PYAoIuhQFo1/Hr/2O4ksZA8Eo4PTTLhhk8Szdz1?=
 =?us-ascii?Q?ME+AtfKT4HHbUQ4XDZT+z8ghSYrbgUnHEzHFmD8lXDToGYcmcmoiDEC0PY1l?=
 =?us-ascii?Q?POsL8jFk3b+8pT3At98bUs3PqoJ0uuwAP5qQ9meV88RpVV6ki5kKM3F7KpAU?=
 =?us-ascii?Q?r3Oh0WvcLroFzpPK8NlRYbgujuOpdgozGUTHl/gR5Tz+eEQcm8a7row1ybiY?=
 =?us-ascii?Q?kxI8LRJ+RbfD0wST8XBDOvDWJunvlaEjV5swKefxdWhdePitFDlzAm1kM76F?=
 =?us-ascii?Q?bXSSU3CzvoG5FZNJ2pUKWZIZ2oEQVTDaOmpdGLqH38Xq152OYb9YyQTHotAM?=
 =?us-ascii?Q?LV4uFMI0zXhJt6pI0VZ9Go3iEo/d9/NPPvIHRpEAZVr22bzbglEs2k1KI/O7?=
 =?us-ascii?Q?5Jfbkdi19jhGR1RVNcWrvaKLV4gzvvIt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjBBfwyS59jGLmqi2Ls6/BicoKvPf1cHX1cilsdZiiQadgsywSvfnPLzRGkh?=
 =?us-ascii?Q?g6wbBc+JFqHrLcJtL5e62/JD1vDxIcojYpbYmGMIQ09IXW6g/ypqswEo4vc/?=
 =?us-ascii?Q?Gj5F2FBAyYirxl8tt9xKc48PE6ewo9rQN2nCc6NrGy8nTWCkuPMZFT/Hb1uI?=
 =?us-ascii?Q?w/uSX5ZTcOmxDxBsa9W0EqtfsyxV8BHxCEKgbg5MJcNrrPR9VHxna6XvctX/?=
 =?us-ascii?Q?GxWx84zxns3cddZiePmlwxO0WkR5eODV11d1ax2lkuoANWc3MRP8JyBxggkN?=
 =?us-ascii?Q?32jdJnb1rmhylYa+xJFvXScBCqTZJBhx1LXgbywtI/U2470r3X+si1hUYvr3?=
 =?us-ascii?Q?ZsMnEwd/qu9rIy807CfoubB3Yc5s9JXASq6uy82c5e46uL04rF3cFJfleNvz?=
 =?us-ascii?Q?c0x2JwH0o8HbAN1m84+WLWkXrVYnhYnGBudOW5VdXwrvLso1rYq0sM7sQLxo?=
 =?us-ascii?Q?6J9Soo0M1y+jxyi48Tvg5cJkiX5yFg9QTalTpWB/jjXhj5tqIns+3wDy15iw?=
 =?us-ascii?Q?BqJ0N9PBLSzjK0UU6JOFAkIFumrKDVdBnLSuadPQuIXPub3nx+JcOC1dZOND?=
 =?us-ascii?Q?+CCz2/FgqjsdZxgPlcUe1qXTjDeV9Wdu8LJ10Lhqr8jRwHIWtxAgPAIIuAdp?=
 =?us-ascii?Q?rrwSUWzaxjhXkufAoc6pTvFnBBx55tV99LE9QFNub8l2vJ3T3YXw0CQ7Y6U+?=
 =?us-ascii?Q?wvw7DW/J/MGS5vWTUQGNVhNhaRfI7WO75RepOHjNEtxg8+Hg0bUHgyJuw+pf?=
 =?us-ascii?Q?Xq/dYXe5RckMlM6JgfjXKhReAyyeE+9Rs6aRIFAPLkWA/So4UXoBynt4JPgo?=
 =?us-ascii?Q?ygA46NxWrHJC5s6TlCKOmVqByVIHO5s65B5q3M8EzDNU5nQ0Y68G+A5b6JXx?=
 =?us-ascii?Q?sIuQqNtR8ckSAwfk9DoIaO1Ch6JFmU4T+Vy/uoAnicQ4bRMncopbqSR/iyCL?=
 =?us-ascii?Q?KTtnM+ZUuiq7lK5D1mKl0eKaAK31mB+mUcf++u8tyXFPwvZR3Ncfu+9WE1yi?=
 =?us-ascii?Q?UVzGgvYUTbKvZK+6TRJ4UAVOuq4pKqjJyX0njYR9fAeaMcrgrmdVSBq4k+g/?=
 =?us-ascii?Q?dR7pk0TaNUd4wg2GBhUYAAn1Nq2T0LnaxoLp8vQM8Wec035Cyy52ZnZoZ7CI?=
 =?us-ascii?Q?cMA/eetWldgRCVaWnCz70LRTNCWL39/J6vB8zZRyhXOKrdQ4M0SirN2nwmZ9?=
 =?us-ascii?Q?+XU677yGoRHFsvvKHOitvlnNhnnJ/9orlOag5ULdb73UbpfE+GeWZS2nuF2F?=
 =?us-ascii?Q?ylqkxc/gVdTHoNmsfnpEPqOXi4QUFpT/y3RvDv4eJA9TCXc0sasCzH/ZwZKo?=
 =?us-ascii?Q?ZtrhCR6Wq9H5RrGRmQxy0Mh1eXrZ4obZ4UxmeCHj2+ZAMV2AgAZZrUxXCzx1?=
 =?us-ascii?Q?ha/omZn4mBf6yBJYRyOAEjvAl14Dn8VNntWpwp99WMPOtJ6BYLIM6wVv24Pg?=
 =?us-ascii?Q?3zznBOrrkN0cQ99UGUiP4Dv8MQBVGOfZ4++wMyO4pFpR66AxAc9tdjr7CZ1Q?=
 =?us-ascii?Q?1zGZI7G3S9wCWlkXqngYssL27M29s19AtK2L0vVsG3ImZ9NotxQ851yddINw?=
 =?us-ascii?Q?4GwrGO9N4xUWMn+/jp1FFXenJOw4+p42clJxp+MJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9071b0d-80b0-402d-89d0-08de1bb62ea0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:24:01.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn8lQFyErOwSRn6Ylsv5Hm0pzYaqrj3LQZxWIqnN8Yw9MkAdb0Iqlhej+affA/t9DNbPtuLWjE4fDLlz0wXRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

On Mon, Nov 03, 2025 at 06:12:45PM +0100, Michal Pecio wrote:
> On Mon, 3 Nov 2025 09:38:51 -0500, Yazen Ghannam wrote:
> > > I have this AM4 system with some proprietary HP BIOS:
> > > 
> > > [02Fh 0047 001h]               Local Apic ID : 10
> > > [037h 0055 001h]               Local Apic ID : 11
> > > [03Fh 0063 001h]               Local Apic ID : 12
> > > [047h 0071 001h]               Local Apic ID : 13
> > > 
> > > domain: Thread     shift: 0 dom_size:     1 max_threads:     1
> > > domain: Core       shift: 4 dom_size:    16 max_threads:    16
> > > domain: Module     shift: 4 dom_size:     1 max_threads:    16
> > > domain: Tile       shift: 4 dom_size:     1 max_threads:    16
> > > domain: Die        shift: 4 dom_size:     1 max_threads:    16
> > > domain: DieGrp     shift: 4 dom_size:     1 max_threads:    16
> > > domain: Package    shift: 4 dom_size:     1 max_threads:    16
> > > 
> > > It seems that pkgid is 0x1 here, which is not a problem because
> > > it's single socket, but dunno if HP or somebody else couldn't do
> > > similar things in an 8-socket system and end up with pkgid > 8.
> > >   
> > 
> > So is this another bogus case?
> 
> No, it isn't bogus. It's a quad-core Carrizo APU with its four LAPICs,
> but their numbers start from 0x10 rather than 0x00. And AFAIU, the
> calculated pkgid vaule will be 1.
> 

Oh I see. That's interesting.

Though something still feels off about it, because these systems never
had 16 threads/cores.

> If HP or other vendor would do similar thing on an 8-socket system,
> the assumption that (pkgid < 8) could no longer hold, even if the CPUs
> are completely real.

The proposed check only applies to older systems. Were there any
8-socket AMD systems in production? I'm only aware of systems up to 4
sockets from those days. Hence the arbitrary value check.

Now there are systems with 8 "AMD nodes". However, before Zen these
would be 2 AMD nodes per socket. With 4 sockets you'd get 8 AMD nodes.
Naples had 4 AMD nodes per socket, but the max system had 2 sockets.

But I think I see your point that this check would break if the pkgid
values can start from an arbitrary number. If such a case is reported,
then this could be a new quirk or rework of the existing quirks.

Thanks,
Yazen

