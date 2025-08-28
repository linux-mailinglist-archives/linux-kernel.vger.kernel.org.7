Return-Path: <linux-kernel+bounces-789210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E063B39240
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496E85E78F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1E6245028;
	Thu, 28 Aug 2025 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VEBM09gi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DQzxg2wY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C05BA4A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352168; cv=fail; b=XnY4KghQocboIfEnP7NVuLwRVGMZMIIFAk5RdOptIX/Eh5BBdlzFqdRw2LKk3eVZcRj/GIziLMK3Im6Hl4393tiaIu+oW12JqCrZO+TpsA8z9BErAUekMlCCfNXYpyHn4K0WQm7GCm7BuIPu69TegAg3aRqqKzhLTPlG/B35xas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352168; c=relaxed/simple;
	bh=QvUqSCmdGD3ONQT1CC/L4BEVzpHM2KmqE/EIKz5oBpM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FmPkRqLsqjUnu//v5tEnaKm6N7HzAyfqimrZphy65RkqftztxgXrbeyIEmyPhlKOwK+L2NgC7uX5lvMY8eI+Dhofth0Blseuu/weJN7lKi9IhnjtSvxAygDTZbiE3YZ+Js70j7OozmZuZ8RFH3nce4pz15PX661QYztTMkd8sN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VEBM09gi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DQzxg2wY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLH5to015341;
	Thu, 28 Aug 2025 03:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zAGJnH0NiZYeN2SRSS
	0fHbu1z5l41hv4smigLHQuoUg=; b=VEBM09gidi281cFhJwZrZgOjfyuqS5IS53
	aicNR7T2hN4XtNxGVQ+34JTs9qr278O+RwNFicMwtdg9eDphEuyEmkcRKd3qGgYT
	AGDzw61K8MbCS0P2wukObM6adbmRZwuDNJfJuZ9aOA5P2ORbsQoZt/9PduBR+CIj
	O01AeFlCnZzgs6ILPGgwFZEbk5tLCR0YD+xEL2eSbC6CfI3Rlgzo/LMh3LnAq7/O
	UboBz3S+95PrJqPH1l3OzBdXwdTQC/p/plMldM0fRoHwOwLhVIEMjk3s+uOwb8Ju
	LqMWslDqPhe0azOrQPrJ91SEir3QWwY1IZUyLK7hrIT1a1Xz12jA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e27s2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 03:35:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S0tBl3026739;
	Thu, 28 Aug 2025 03:35:45 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b8p8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 03:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWAeYMYUioe02YpK7BSYj6aLTUGegM8DcEK2NFJ00gM+u/oh5D1eNQR7zWT4MpnCTqeZkHZhhHxq+yXCSTvMmEFTUEbWJrJsqxvUjDPdQtCZwNLDEOAvEMyMsVHdCL/8rU5NwAsqFlep5NEynvW6+4fVJK2M5wHcjqK74qiZhQHPO3CvaMVldV2F18O45umnqpu1IrZWz4CQ8tSuiA35Pl4RHUkG2EuNUfFFyhfa8mUl38mr3Zdo4GiQoIQVVBGu1PgnIhpUZP7fzjiVLCVg6qOnubzN5+5CsV+Pl5jek1cSw5ipFeVhI/fvaO3zKzgLEJlt2wL11x1jD6vqAcUXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAGJnH0NiZYeN2SRSS0fHbu1z5l41hv4smigLHQuoUg=;
 b=NVFHDDkMUhW/+kIwWu8wtgR+Pf90M+eXRkWc8TcePMlk/ua0IdWROTG/JxdVFg/0YV2ByCXhdhN7reNSvmlAeU7k69Xl+87y9Rx6VbsmLtsBEGNATV5H1Rx3WVmm9AUONomEqLpov8+pH4W/Tj2ZPUaybIg1kJSKQ5teWppuwvAkONqMbx7d8GM3KAPUUjm80sxZl1iQMmJknbds2oxy6rclTZa9c5/RfD9z2uNdzjU0cX/IRil0SsSCoysMsjSjV7gWXPqYwILsb6P2jfMc+C7GGbl4lLJ0mqjVNMtZlb3CLrWWtMnBD8108M7n9hsLXqjy8PeXniNI0KXyPLiIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAGJnH0NiZYeN2SRSS0fHbu1z5l41hv4smigLHQuoUg=;
 b=DQzxg2wYRLkvs04uJMTkw2aN/pNlCxsr7gFF36N7NDOct3hWelyOTvlJ5k8vYcdxGFvwkrPOjeEw4M1Yh6kPfe4DGCtB6rbY0FmD0yJuPOICQr/aV5ArQHdYAX7ErB7nPEDqskgop3xxEhM7U8Eb5xkWXp/CMXYpHrTpn5zRTW8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Thu, 28 Aug
 2025 03:35:42 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 03:35:42 +0000
Date: Wed, 27 Aug 2025 23:35:37 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Harry Yoo <harry.yoo@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        peterz@infradead.org
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_munmap (2)
Message-ID: <vxxrlgnkujdpjl7jv5alkr5kjatq4f4jb6fw45t5son6qwzkuj@hgwye3dhqthm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pfalcato@suse.de, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	peterz@infradead.org
References: <68a7eee9.a00a0220.33401d.0168.GAE@google.com>
 <2d1297ef-5df3-4679-8e38-05be188f18d8@lucifer.local>
 <aKh2vr9HtFRKcnR6@harry>
 <ourgzm4wai237cpcef3ypdn67hspjgw4u7fee4hyouj2hn3gwx@c322noqn4kzq>
 <tvtzgibiy5fvmf7rms4jeyim3lx4nas7qmgv36oryizdvwaujh@bsxqbd3nii55>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tvtzgibiy5fvmf7rms4jeyim3lx4nas7qmgv36oryizdvwaujh@bsxqbd3nii55>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3b8546-0993-47d0-8e2f-08dde5e3f6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C23xyNoU578sUp/CllYkbk8wGKy9cUJl9lXQR6xyMxwvJvBN1xRdjQzY3SwK?=
 =?us-ascii?Q?cW/JFGI0vI9OZc6nukihtLf6uOZ7g2nHqcIDZR37CueOb1qNf8+fUfnd3yVj?=
 =?us-ascii?Q?2uQIuT+3f83IsCXoKtFjKm1t7gIsKgewn1CD5/1irSfse1SoKmBmyxUB4Glt?=
 =?us-ascii?Q?grRy5FFAHVDDv/w4PitJHvdr4ZbFLOVmHujslpHFpHr4/E4DLh6KfrCiyG/e?=
 =?us-ascii?Q?7/y+NdlazOQ+df/yVAGitWl9AkLhHYSvfW0xqz60leFsiOBiWI2BU5AvWWX7?=
 =?us-ascii?Q?E9WkPqJa4K77mK/N3brwHNTHorpTPPrEiy0DwLi+kcS4Y8VJ6PPlpC8anQL1?=
 =?us-ascii?Q?yyqfvYY7ImkZL56qbirSS7s18SQ96k9aCyitd9jAIsOdA04lUnGjfh+JMCoZ?=
 =?us-ascii?Q?FAl2xmrYF8iQJb+rDdQ6N7YUvKMSIfHLSBvx72xvfC98dN+5eFi388huKklX?=
 =?us-ascii?Q?slrxUNstg0qDmxVqhcTmvb8q7aP9nmjalF/0o788BxN975QSKp9D8XjRXcWX?=
 =?us-ascii?Q?ifcHV+IQa7nCRUD1RnfPad2cJKFBkJlk+K9mLPMT/QcCRLIsicnapRskZmN7?=
 =?us-ascii?Q?7F9G7B69vz5VDucq06E3y4QcDSYn8OuScJTbDZ+9Pkn3Pnh+Q4nyVmV7r4KS?=
 =?us-ascii?Q?zFsw8rp2gQgmYuwglXGShdxaR+vbB5JYlvJD0c1jZsnJybdtq8UO47BPb1ks?=
 =?us-ascii?Q?oU6RP7o1s1BPSyA/E6kWPJT4gBUJL2U5ZfW4iD2+AzbC0hBWi1/fj6QdOLeF?=
 =?us-ascii?Q?N6KIeDVEsDEEQ2Hof4RcuQ1ggiCGEXFWUWNyT6EkJggYER1sTI03d8MN5n/i?=
 =?us-ascii?Q?MQa+a5bGvzG9Nx6Ys0e3f98WzPxIt1ZSHVk8nGnr2bogBd9vyZIrGU7+G5b6?=
 =?us-ascii?Q?uPe72JI4C8HEY/GseIpY228x2jYtcaYN7IVwA399Q86xpfEGX4wDef0dR9Z3?=
 =?us-ascii?Q?LF/kj688f9LFOJcZLrRpT/DVVkKoJAwpoTD/Ke9jxxl+gGA0h9l6AhwG9LNy?=
 =?us-ascii?Q?2ovf5JUeBoXfhGMz+BPsDHzMmpeRX4MeFsfqzMz6t4k+unPpOR84QBd/mQ8I?=
 =?us-ascii?Q?1T5TtEOFn42iSD2qVLj9a/Ez/7Lbd9ktXgUqKLu4Vez3ngnF4S2ydK9PERzx?=
 =?us-ascii?Q?R3T5P0Nje/GjzsLPY9i2tj4Afg0GVKfl7k2KzOC3EBh31htDkbBknyuy4mt4?=
 =?us-ascii?Q?Mm09DCrIzM1l8KdMyDvrOPQUKazB1QjCuTHLkr/HUOpj6TtY7Cx1UetZbNHH?=
 =?us-ascii?Q?Six0Atag2q7y3+nxyYCvQjHIlt8teOppTVUKwEaWFtWo3+Jjr7PXKOOrmSx6?=
 =?us-ascii?Q?kKJJrBWOZ27hRw/eH2ygxlFvavJ5LPB3X7uPfMlfKZQGDc55SZNgy9ntUYWY?=
 =?us-ascii?Q?c4Pt9lSxRZB5LWu/zu5BRygChd/O4w5WcNxsmhC3h31SZns5L4+FUCKSWziM?=
 =?us-ascii?Q?vslrZy6YK0ptKerwCjZO0rQ6befJiy67v8dn/EYkcnvh4i5G3ZxpRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8E9VadMxUL9ggcUSzeiMPlNWjxLQDncyFGHHT+US2QWhZIbldqGpH2V2IPOF?=
 =?us-ascii?Q?h+dYvgv3sKhviGeeQhDIpgo+M0XZtoF+VuRSQTyrUANG+TK+H5tbIznMebAm?=
 =?us-ascii?Q?GMbLwyqDov2N9G/lr4QLkQTBjcWZ/Fz5lbf7Xc2OJ7IL2T+PqFUlouttNLmL?=
 =?us-ascii?Q?D4H88LUW9PH5AunLRUA0hp5ENs3LaNsIiJS69R9Hcbuvms0+YI2yBEA2TA2S?=
 =?us-ascii?Q?8LuM4IchIMmAPsR6704vhnLlBRIxAp+CFQPkcnR+LULNUoUEtpBO7cMWNMeY?=
 =?us-ascii?Q?kn3LhgfaOFNu2pg2Sr6KqXiIWQEOvJxiKLeohPg6tSMZ8jvNzVkdnCqH4mVP?=
 =?us-ascii?Q?DL277EdYkOt2EScuJGodMqKALFQ1qH98+ELvAJZCToiVX10OGz1sQooseBTN?=
 =?us-ascii?Q?cpEBoom/zwILCdALfzFODqexGLL1DE00R8KpfktWQmiO+avY1T1/NeyQwLAS?=
 =?us-ascii?Q?7oZantGYJc6EnOCv2sxNApu0GfmHKYhmhDUJTafxSXRI8S5JIj+YX1nDdhsb?=
 =?us-ascii?Q?UZIRGbbEoQrRI+jVAkJdCsPdC1LZ9hJOrAsj4f7l8ZsTj7diAnDO/66jz0VZ?=
 =?us-ascii?Q?vDMoViKcl+JoXrX6wxAlCIWBPfujJjgbIZsLECjT307XBUPxqvf0rUcQTTSl?=
 =?us-ascii?Q?cpGP+mKhL+XRpKPoPAiWGtINYzvcoxTGF3Qv9EARzxhdec2RgSDEu0su40IW?=
 =?us-ascii?Q?jeRZyTiMuzDAm6Y2Nmq/SDtV7Oam4D3qnfBKYxr2DX2uVye24bO5c+y60hJs?=
 =?us-ascii?Q?vQvKaymta4HINpJw5QBO5AUJPX5M6SMfuhCqB/AjsbjeaJAF6wIB7jayxTgE?=
 =?us-ascii?Q?xQZ+CUYxZylSUCA/2B5otfMU2hEQU0f3Yz72CRnmXuuihpoDNgtv32CC3vOH?=
 =?us-ascii?Q?ASFOvApbkuMiqo44zFW7aHpzFs6MgRUuYjqilJx1oXYnfQbtutbSzTG+4Poz?=
 =?us-ascii?Q?fhtkEYjuy0czCBPHkUxOmVGXo2N9CVrC9Q389oj18zduR5SyDPfvUG25Wo6H?=
 =?us-ascii?Q?WDKg95yPX4xQJNTbEjSbRXeRbQaFeEwy/aQkjZvnoVDx/NW92M+Aer3SsM0K?=
 =?us-ascii?Q?nt8V05WJ3jXdIdZUPiwTR25EH5vahz1kCLvLdCLpZo0Kc8a2M9y8R5Bv5nN0?=
 =?us-ascii?Q?lGWK0tCikY4SgpLxKkc55OCNkHp0HG8DdU90W1XV9HgTJuum21WQSKo9hL7h?=
 =?us-ascii?Q?8a5M4E2uY5qFb2NftUiTL0IAIwZd03Ut062sLkiXrG2U+fZ6wW84H+V+U9I3?=
 =?us-ascii?Q?SKwrW9iGVgrTBVnrVFxjLwSyos4DYt604qsGm915ZOqvGIcaQgfqLYpt3/F1?=
 =?us-ascii?Q?unVBGAqeYJcqoCk7WNkti2m5aSktSjoj9mvUqSSgaQNAypysHJvnqRz35Fos?=
 =?us-ascii?Q?Yz5fCLPE+Dwh4+sDicfRgHpTOTI4XEshFyk+WT79qI2xrUiZ/E0mfKMLxVFV?=
 =?us-ascii?Q?4Tdu5/qVsVf/gI7CdHRu9qo92EJmr7bFRWZwJfjy4yqcRMVSbJf3HbIHqdBW?=
 =?us-ascii?Q?vjszebr1DVR6THA7KJ5EjPjxpTEu4n7qeu2370q7lcf8eaWiSSzgrTfjdOb3?=
 =?us-ascii?Q?ElVxqjwYG10kmH+gsa9nR98KGdt59wQUQXHkmhT62IYc1L23IoMLZnif+km0?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H0hcC5SoVw6IllF14fRN5bo0oaid9Wq3aWf+b9JTauqZnCX6dtH09DIyV938ZNpbrB6hhwK3v+GWuGj7tSHJWmm9d20vFKCoILKLNT40e57HUVDNSXzg/qsM02HM4eGlY3BlwmnM5g/DVT755QJBRVNAeXMtFfQnZ5Xcs6T/qATCJdiMnwQtRweylb4l2ojV/ouCwF79LUVJBHBX38/271QoeFir1a6B4FjlgrVBdjkqPldSvBNu8N1uraFbIPO4hHuiNq69pTkV5nFDqXMv1MZF6G6IkPb9Xwf9rqVlGun9XyJuaCLZPmEhE789yzIOWGDCb3FX/mdA83PTeBJltqO6thzxRu7OxP+xMx95Z941Tj6HTAuzbxcmbTOXK5307A81yjHJcikEsrkHLy8y9yTDriIjMaHTnjPXRGw9z+FoaCR2d2B21yELxQeiRt1WVh3843hYJpTybX9U9NTDizOWCflKwVyiSJAmwxLHDdvmDhKsTCVUp9bgtJ7ddWHFMaGJ2TX9Y0k+y/akRyb/VoJ3Sb/L4bGPQuwmz9PMNBVfd/NTfC6YsT0AYlWIuyRN5l1211a4JbXuu6p8VDjogowEQbG48W7ZXTCfp+MxFc8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3b8546-0993-47d0-8e2f-08dde5e3f6fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 03:35:42.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erDbQADk8olNq9d3dNgwoV+92eIce835isT4QpADz1ecWw51k6laOgizgwc1zyssJtOtekNltxihyTrvRKeWWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX+tKQckLVEKsV
 MxmfohFr0Gf5wP2AesVOxQRJWAeVxU62a6vTKGPLBVIUZIB0HkDJcvt/uu30TWVIbbzTwmLhVdf
 VxGO2ZXGczn5U93SabbbM/y3eFig10mrVDlc6v96HasdNgZKplF/2CvAgNted2F6Z8DGgHVyM8q
 r3sFU+9sda6wIZE7dUEVnwGU9C7LnHbpTBrfuM6w4hH0tRKTkm8qWx0C/+lPG3cQPXsPwkJMfvs
 6R6nf0ydRXnFSw3la8Vp2Mu01ywRWpqLBVxjz+19Mfp3hrRXFOV3En9U7aMPn7rFRicACyeZbHF
 8jA5qK1eR5fFz10/CKQe+2HWHhdqql00VYUcUeSQzWnJ93OdacJQQedNbIZYQBbOi14dUh69g9M
 5CKHKv2A
X-Proofpoint-ORIG-GUID: 3-gf9HR7eWUe6CiU6eY8QK64bFxFEdaZ
X-Proofpoint-GUID: 3-gf9HR7eWUe6CiU6eY8QK64bFxFEdaZ
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68afce92 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=klVcNUNte2gKD6hMR10A:9 a=CjuIK1q_8ugA:10

* Liam R. Howlett <Liam.Howlett@oracle.com> [250827 21:58]:
> * Josh Poimboeuf <jpoimboe@kernel.org> [250827 20:29]:
> > On Fri, Aug 22, 2025 at 10:55:10PM +0900, Harry Yoo wrote:
> > > On Fri, Aug 22, 2025 at 01:08:02PM +0100, Lorenzo Stoakes wrote:
> > > > +cc Sebastian for RCU ORC change...
> > > > 
> > > > +cc Harry for slab side.
> > > 
> > > +cc Josh and Peter for stack unwinding stuff.
> > > 
> > > > Pinging Jann for the CONFIG_SLUB_RCU_DEBUG element.
> > > > 
> > > > Jann - could this possibly be related to CONFIG_SLUB_RCU_DEBUG? As it seems to
> > > > the stack is within KASAN, but no KASAN report so maybe it's KASAN itself that's
> > > > having an issue?
> > > > 
> > > > Though I'm thinking maybe it's the orc unwinder itself that could be problematic
> > > > here (yet invoked by CONFIG_SLUB_RCU_DEBUG though)... and yeah kinda suspcious
> > > > because:
> > > > 
> > > > - We have two threads freeing VMAs using SLAB_TYPESAFE_BY_RCU
> > > > - CONFIG_SLUB_RCU_DEBUG means that we use KASAN to save an aux stack, which
> > > >   makes us do an unwind via ORC, which then takes an RCU read lock on
> > > >   unwind_next_frame(), and both are doing this unwinding at the time of report.
> > > > - ???
> > > > - Somehow things get locked up?
> > > > 
> > > > I'm not an RCU expert (clearly :) so I'm not sure exactly how this could result
> > > > in a stall, but it's suspicious.
> > > 
> > > Can this be because of misleading ORC data or logical error in ORC unwinder
> > > that makes it fall into an infinite loop (unwind_done() never returning
> > > true in arch_stack_walk())?
> > > 
> > > ...because the reported line number reported doesn't really make sense
> > > as a cause of stalls.
> > 
> > There shouldn't be any way for ORC to hit an infinite loop.  Worst case
> > it would stop after the caller's buffer fills up.  ORC has always been
> > solid, and the RCU usage looks fine to me.  I tend to doubt ORC is at
> > fault here.
> > 
> > Maybe some interaction higher up the stack is causing things to run in a
> > tight loop.
> > 
> > All those debugging options (e.g., DEBUG_VM_MAPLE_TREE, LOCKDEP, KASAN,
> > SLUB_RCU_DEBUG...) could be a factor in slowing things down to a crawl.
> 
> DEBUG_VM_MAPLE_TREE is super heavy, but that comes from validate_mm()
> which would be the last thing to happen before returning, usually.
> 
> I mean surely that would show up in the logs.
> 
> Okay it's in the second log on the dashboard..
> 
> Yeah, I think it's debug options eventually causing failure.  Apparently
> there's a reproducer for syz now but without the validate_mm().

I don't think it's the debugging options as removing the validate_mm()
did not help.

We may want to wait for a c reproducer.


