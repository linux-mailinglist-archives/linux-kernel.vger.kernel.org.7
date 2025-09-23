Return-Path: <linux-kernel+bounces-828243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A95B943E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA64516A3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22518274B51;
	Tue, 23 Sep 2025 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RTHCBSt7"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880813BBF2;
	Tue, 23 Sep 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758602445; cv=fail; b=LGWNyxZ1lLm3LL2I8+5poMt0pMAlmZLtXsk87cXFmJM4tX7ZpsTIUaVeNDTEA+7aGxnj6gzw/a6JTRUAHCt6+Kjl3L+SzDhcoWOI5Zc57kly1F9m/aCEQwiM1qTFmHsW1f+n4iM+riOUKWoF3UerO+XNlWyy9DQrj9l7IZNhjQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758602445; c=relaxed/simple;
	bh=J09lKV3GcOdA0oqoBM08T+ySDSMYuhaCEIm3jNEETy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UN7k6q9tqQZ6FgAi+EBoVPD9jTr+WrIYk/UReFKonWu2KK629EJV5GM96ec0sVvU7lntuEuhrJ8CJc1XFyQ7ueiBZMZOHytZRblthMoE1rx+1LObBvPpfAAdzb9bzr1kb2X4JxhlzhgKHsAV997wHfT95ScaY6ZLUKsjSJXph0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RTHCBSt7 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+R9h/qcUNMxqPuN6eCXBCBS0I5Rm+IOXrR5q1v3ijvBriLBQhLUr67ITFasyKpjqKZpI5vneEEXG9yrXoELEJz3gBtZ7kqlfQVLRoJItCxnTtNDqNmbFho+Rz/BsE6VeoEObiRQc7/kL9cB5MJlNlP0Ws30RNsONnPq2XRDGWN5WgwlGFshFVYQsfVm1E0f1P/nyyrlTx5RnR/gw9SF8pkyq0dzPhViIXyflSxvAH91eXQReYdfbmdPcgaNrA3U/0fFwKrB66K1ttQiftM2EWAWhzCHILQfPoY4jWYH9BgzGkvpwmgq17HlzGZbEoDJNV957egnanEwNMxo4uj7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5AFzG7Sx7K+BNUiP6+H4YoKlsA7swRPcdriv1A4WPI=;
 b=QO4ETYMQBT+NXxeDm40yJF4md8Iuy+oquJ25GRtwvEyuGRfaBCHm9HESqvUGLHbZHutAsEbklAQgWKAbj3sjBupA6STmkISRpfuYHmPiWjc1Ft7yWJ6+uTvbzEhR73qgp50Sw043AcoAkSWWWtv8rz+GI0WZrAtC966mi8T/PNkM8o4DH808sE9xlu3hdsyyk22zk2J9jPtGdoGa8ZLMizsdw39RUiGPWsXQ+u0YD7jte/xlqnMA27oBC/hZnhOY5xNF5I6Ua9pP20aobGTUMZ43D6zRWnXkyOcHIRWhndqdZ+++MLyOvfuiof8HFlWdG5BRNItSK77jmRAFyNja2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5AFzG7Sx7K+BNUiP6+H4YoKlsA7swRPcdriv1A4WPI=;
 b=RTHCBSt7h/3kRKxfcSCWqUCjF8lD8RiNTM3JqYg6VRUYfSQ4YHmPSKTw7B52nleg+8cwhjwtTXCDE9nNBvIMxFymxfHhv5jpfdDkZWTk4NUjBjELFrmynz8Ehs0xSHqhUZ3crRIYFsGqG/n93JJ1LnjHtDKNOmlzT+f3vTQSgC9PEdwE13TfGljuP0glzIpftrmuW4FFrVUvOBIYHtrqpounlny43lYzsxd+gvlmK+Ofdw04W7Yg+UQ/A+ut4b3NNVSpOvL6385PPkintdFq0l5VBO9CjwaaE9jZVhbtnQTKgRFZrHor75DuoVG53Wrdzpj7nnWDgOoNyKJ3r6QA6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 23 Sep
 2025 04:40:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 04:40:40 +0000
Date: Tue, 23 Sep 2025 14:40:32 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Timur Tabi <ttabi@nvidia.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lossin@kernel.org" <lossin@kernel.org>, 
	"ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, 
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"tmgross@umich.edu" <tmgross@umich.edu>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, 
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "airlied@gmail.com" <airlied@gmail.com>, 
	"aliceryhl@google.com" <aliceryhl@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"gary@garyguo.net" <gary@garyguo.net>
Subject: Re: [PATCH v2 07/10] gpu: nova-core: gsp: Create RM registry and
 sysinfo commands
Message-ID: <xlcggztkxvt3wx46ldusrnkened3u4rutdw577drzoxaakfp43@u6o6hevrfey4>
References: <20250922113026.3083103-1-apopple@nvidia.com>
 <20250922113026.3083103-8-apopple@nvidia.com>
 <d87bff0c64fb2a549920354c8b09f764e145a492.camel@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87bff0c64fb2a549920354c8b09f764e145a492.camel@nvidia.com>
X-ClientProxiedBy: SYCPR01CA0043.ausprd01.prod.outlook.com
 (2603:10c6:10:e::31) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd40664-bcb1-4172-cc88-08ddfa5b5910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5YBKHJvIOY1/gJWWpg7yludo2Xi6A9N+G8H+1AyaI7Clc/Ty5C6msnyag8?=
 =?iso-8859-1?Q?lXDOm8zhp3uYSpKIiaE+eRvVKpGcDHtsu+kzHB5ejNTMBeoA0KSvyhQKV2?=
 =?iso-8859-1?Q?9YGo5ubS5JuAw65U4m42o4RB7ag5+qPQ2TLJOtAz0QWcOVoGR5CntNuOV4?=
 =?iso-8859-1?Q?Z+a+owzZPOijjHvr29WndqOL/VVPr2lr/1mOe3+ByDMH2JXLdSgJsfv5GK?=
 =?iso-8859-1?Q?s3bzTdFZXaveOpjDrnhHH1F3f1pz3WLnRq4qUaEuP0bqVp0NUKEkdXLi4S?=
 =?iso-8859-1?Q?zFYIbV6pralaEDFMg44cTHk5sQrtNC6tXCfvj2JlASiVTnBorxCxqvAWkR?=
 =?iso-8859-1?Q?Cnp676qeyIHYOSwSoV1SqdK9kJ2oDHZ4Qm24IUU9SakN8Shfd7X0OkuwE7?=
 =?iso-8859-1?Q?Wo5du7hOql6f+Y7Lu+NkP90XpUai+UC1IZw9MS0DgkVXNyvZ3BKYEE5eQm?=
 =?iso-8859-1?Q?FarPILj+O99A/GwGP+r+GeeMOf4JDlTLnUKNfAsXwh3whPmyGnJnsBiNiO?=
 =?iso-8859-1?Q?m2bas+5dNrRHHiCGUkKoLlsIFgjR7FHry92LJl7YqczMv65icAcfn5NiWD?=
 =?iso-8859-1?Q?cu3oVzSuqxm7WTIKj1vDTTHrzO48tbNEYjQ7rWvlRTDBCOAiLkR/3p2zZt?=
 =?iso-8859-1?Q?d/VHns/iH3dM5sXTLLj+02ioRk6qfJLdVu3oOzoPKNLX26PIfdonILfNDd?=
 =?iso-8859-1?Q?N+O8WdzKO/qwdX+daAbr6D/JodsQx1GpBHkmdT4hO57wpB04jQddchdbpU?=
 =?iso-8859-1?Q?h0il7wNliUKdpa6Oe2PKp0GjLQ5Ywcq6lomZ/LPN4shGcYBQx/kaDnCEbz?=
 =?iso-8859-1?Q?6JQBUAOslzrTv2eIBQfzyYCkmXTjEoTCBn/xiC8MdD06NJcslGIYGQ3GHX?=
 =?iso-8859-1?Q?esUqTWLFPmG+EAWBf92J1umFejJZHpOu37D0mIWj7YB5u57259uRCmMDp/?=
 =?iso-8859-1?Q?MfDOw0BXZU7I8GQK1aYAZWymhK3apmUqn4vtQ4fk/LgamvbqlFkpIU+pOC?=
 =?iso-8859-1?Q?IqlK1UZ/T/UOlumE/HbBT+WUm/W8jim9M356ClYwWwjnSGEFvVlJPqf7E1?=
 =?iso-8859-1?Q?epU3iLG5+xfbmE0Pr6I0Ecb+cyg+TuQhugysPlUOh9V3E8cIHVShEHFq/s?=
 =?iso-8859-1?Q?MKX/M41qjN7LsN9/ADH64IEwSoKIXQ4Ji3ZwsccB0N+YIsPUS/N0j0W3A1?=
 =?iso-8859-1?Q?zQ8vKhRTSebQZc/Q+TvJ5fcxmg7zZSasE5vhljruPSo4V6g0vVo2HoJlAD?=
 =?iso-8859-1?Q?PV766bYb7cWElGrxOAk0meYqIkIgvOMOfaszmG78z4Fifyc2roS3aooewE?=
 =?iso-8859-1?Q?DYfTryWKIqoI+iUAkAtq2D9O1pn3G+6IiNqge1mvNS1Sh9uOZMizhx5Exj?=
 =?iso-8859-1?Q?ViIL6kblSCGIHLQ2eSi6lDwsqMUUVQ+BIxPdmO/9JJs6QW+Iz8VEN9fZuw?=
 =?iso-8859-1?Q?IH0NpE+k8F6USzXKSR6i3kq2k0WoRenghBgPqYAZOx6hC//omK3v5WkL63?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?phn/R6QmdVmjWSk6wTulttB4y3bNkEXwNh4RFDjA4BR50NbsghDEeSfKLE?=
 =?iso-8859-1?Q?R0NA6BZkjI7JUgQO6cED4ELn+DQBgXOTUjRzcB1LkoZDL2xAj6Lt9L3Y4/?=
 =?iso-8859-1?Q?DgRXuzzrobJU8NYxH+10novzO5QH9VqdscagVdCp0QIhkVu811LLeAYjz0?=
 =?iso-8859-1?Q?QygdhpX5QEluJsEIOjLyYNDqtq81u6oDK4Vn6iq03PM6l+wpk87JFs8C50?=
 =?iso-8859-1?Q?OUK/fN0hSCS6nYR6sIgTQNqiNddqKGBqKKC+UnlEO7xq6WS43GZhKKaTz5?=
 =?iso-8859-1?Q?iUIGGbGV0YARrd2zXs9DPXquhXwFb2JWQKMwlFfJSPF6DJVRgARuYee8LS?=
 =?iso-8859-1?Q?wjfdN6CAdL7G485saRZ61WZB2Lmnv+M7i3kD/q90euMaI6Piiu/oKqVksB?=
 =?iso-8859-1?Q?hyyrTQgDNj1qISBcu9qKVSe7bYzxQMzKsw+Sr1O6lBO8VQIRxJPGo8Gbfk?=
 =?iso-8859-1?Q?F4F+ntYDsW4K3L844IaeKE7QaYguuwcQPpb3PyfPEVW8ZdnnTYZ7GwKU79?=
 =?iso-8859-1?Q?YxQgtFquG0hzwSB1CmOiIs+Qw4iCLNBxWgArMH7RpkfXrX36srTdSPJe7c?=
 =?iso-8859-1?Q?k/KLndr4ukj2m1QTiW/G7XkeHbMvN83Nbfppz2UMglBYlq/A89JvR7gA0G?=
 =?iso-8859-1?Q?plIXLzOxTri9S9qAICoBvwA/hcLqmvHekIbxS+AKZ3WqMdeDVJHo+37VQr?=
 =?iso-8859-1?Q?mQyWMhIVXdwdxp/EfoNo+QXaLP3D9IjDYtNk3K1VWMtPjV2M41nFTYLpMW?=
 =?iso-8859-1?Q?QJ+ZeCqyXCbKbO8uqKddCiY5HhRhSY97BBnVTWcHcTDKbak+ZsmXCnZjpE?=
 =?iso-8859-1?Q?eMWbRDjvn8xu+elgzqV0ELjEPUhRosIjNlAPXpT8bHHaiSsftfso/DnNYk?=
 =?iso-8859-1?Q?pSb0Cem3HCyYfYdblHPgvAsVciuoCkjW8x2D/Qb4HVZVfqAJK1GWIR+VCM?=
 =?iso-8859-1?Q?ql7nyqA4KlEEX0chVNU4nCVUuLtQDCnuFg+tXAzoRvKjiO/XiLNA+s7oSA?=
 =?iso-8859-1?Q?9EE4eqEQHU2xUJa5mdR24ZfIC9K+htq8SmVm1Q1wWP+0U3VsaRDTzBtoyN?=
 =?iso-8859-1?Q?JEgX8TaUb7FpBFQCzEJcvT+xRWJeSxFO/WIpAUUkJfPzjElGmKOLKllPR5?=
 =?iso-8859-1?Q?rpIzuit+pcP2Boz8gt1B51lPyhOkPNAWNN+NNdW6dRSGCCGjpCHzXbLyRB?=
 =?iso-8859-1?Q?ANIPSoYuWzhDSeLeRIfF6qRMgqSGADqK9H2qrRZBmowsZZJ69KX+ehl4kQ?=
 =?iso-8859-1?Q?HiPuZgqyzfnv1wKUcO84/px9kTP+LXkyoc+LKPxLTKmLnwSB6hBdHrVcK5?=
 =?iso-8859-1?Q?4CiuNbQJuMuuIWdNYPSddnxkBOxHkIVp+4u5F31hGE4m6mP0wAIk5wjKSm?=
 =?iso-8859-1?Q?25Hq7OU7iutGrri4JA2rjNEBP79P9xkAN+R1+Ze36W19uyA89dmQ72s3m8?=
 =?iso-8859-1?Q?4+j/GOLGya5Ev9xF+Iczu/IJvf+R3sIQWy57iKGNmDsrlmveeIOjErUErz?=
 =?iso-8859-1?Q?UL51kLLH4TqiLb3Mk9vq4PfS7o9o8LY2TM8L0pUBtJ1OWiajflq2NUrqHj?=
 =?iso-8859-1?Q?h/gxqcjH1LIfn4RP8ToOqcD5ymWsvHpvjuRNVV0VKxAXA0DGcODy+dCQSV?=
 =?iso-8859-1?Q?fzoZFT1HIzU9tnqW/u+QjbSdDOG9YfLDB+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd40664-bcb1-4172-cc88-08ddfa5b5910
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 04:40:40.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+mSnZbuAbkSMuWOmqy9l2fXHlf1/ABVK7aK7YdtEK8EUpxCfe1oQDDV1ltUeMJgSwSlI2CF9YJpPOe3Q+nsyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

On 2025-09-23 at 05:10 +1000, Timur Tabi <ttabi@nvidia.com> wrote...
> On Mon, 2025-09-22 at 21:30 +1000, Alistair Popple wrote:
> 
> 
> > +const GSP_REGISTRY_NUM_ENTRIES: usize = 2;
> > +struct RegistryEntry {
> > +    key: &'static str,
> > +    value: u32,
> > +}
> 
> Probably should add a comment saying that although GSP-RM technically supports strings as values, we
> don't intend to use that feature.  You just have REGISTRY_TABLE_ENTRY_TYPE_DWORD defined without any
> explanation that there are other entry types.  

I think at some point we will want to extend this to support setting arbitrary registry values.

> Maybe REGISTRY_TABLE_ENTRY_TYPE_DWORD should be an enum instead of a const.

Yeah, although in this case it comes from the bindings so it's not really
possible until we can get some richer generation of them.

> > +pub(crate) fn build_registry(cmdq: &mut GspCmdq, bar: &Bar0) -> Result {
> > +    let registry = RegistryTable {
> > +        entries: [
> > +            RegistryEntry {
> > +                key: "RMSecBusResetEnable",
> > +                value: 1,
> > +            },
> > +            RegistryEntry {
> > +                key: "RMForcePcieConfigSave",
> > +                value: 1,
> > +            },
> > +        ],
> > +    };
> 
> You might want to add another field to RegistryEntry that adds documentation for each of these
> files?  Nouveau documents them as comments.

Yeah, good idea. In general the comments in this series are probably lacking so
will update for v3.

> Also, you're missing RMDevidCheckIgnore.  See
> https://lore-kernel.gnuweeb.org/nouveau/c34ccc23-5550-4f26-af66-47979afd197e@kernel.org/T/

Thanks

