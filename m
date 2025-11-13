Return-Path: <linux-kernel+bounces-898812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75633C56128
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3C4634279C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23A32720D;
	Thu, 13 Nov 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gPR7XslC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0C+tgGfb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AC325488
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019280; cv=fail; b=B9bxvCNjwS2Pk3OjJ/tQBJfYNW12CBUf1/jwH+jzgTJq2y0kTCPHFUSXBVq7nWDMM29RRqSirNRfJx90PYptupF3abK1hwxShZ313uWCIXw1x/7cZPC5YVpS4q2KCmUOSTC4ziPRd2eNxVF33XP7w4rTjdu46X6F/cQ+qk8OFYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019280; c=relaxed/simple;
	bh=tzr+85hlMEwnsr1VhzR7nvU2L5XmzRYp5Woefu/UfSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kfb1RgpJBTMl4Pv8ipxgmsUvP3yD4SMdzF6TAKLSSN/lcI3Tr66YItuFzBDBZSvrwZ1c0f6GaRaAz+gdO94J3/w4P+JupcEIS+q3U4vVS7ZrfsWqw67tYaVH6IrIYQJlHs+zsSo2Vq2IfZl0YOfE3vb26+rzpfISOl9wJqicQNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gPR7XslC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0C+tgGfb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gNTJ004104;
	Thu, 13 Nov 2025 07:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w0pknYjFcLzWR/Hv7D
	o+LRwr+46b2L71uyK1voYY0Gc=; b=gPR7XslCJBXMHac6XEooRKyrtyZPRJLDs8
	2fLwI/nFl7+YiPz1dMZRioHKKOOIR0l8uK5HhDKu9OHWM1hnG/VEB4QeAlZPiWQv
	lqu+POU2s5y1q/pj1L7OqZPN/2sK1Fxro6vV0sYlqcGSBwrAKTVrcizLZmts2IH2
	c48p6azk83bBRK9GyrdY1uHuseR3MakdYD+7s01/R9mk6dL4AlVdqxbfe3lsLoi4
	jfsmpOHWwGClWtyQTE1HYkWQTFXmDuy7s5sE3bdCAT2OwN0zACDheb3Wi/glnIwM
	1ByF/mNEAv/9hE7C6rJY0qMzIYeiElKrOAD3dbA9Oxe0fYgOa51Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxwq16ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 07:34:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7I1xH029159;
	Thu, 13 Nov 2025 07:34:21 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaftdhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 07:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkD1KXdTDEh2l48bdDj4eBlIKLzXUi3aukTHdu56eHHw4j7G5RSobRQY+DTwFEeIxcOTs5I8WKs2SklVi/DAPdiK9w5rPeDoe51cy7Uf4FzZbbw+bzDuJ8tsYPDn0eCVyVHBcSChmJD3iZEgB5OdhGJhRe2K7WLhoAaAmzTXvNsx20gF4yLHBUwq2J0lITWCmezUApRlsytOqdY+a8a7Nf/4Wpni09//IF0XCg1OkX6TyIuPspSpKeLS+Owm/1lujAb6UmWxQ76QlHlJEjPpsLnHxFtvqFAu6GNDDUOFqvAKiu0C94vUL/41Okljnpq5XBT97CK2wMISjJR8UU2mVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0pknYjFcLzWR/Hv7Do+LRwr+46b2L71uyK1voYY0Gc=;
 b=wCyvlahsxuGNM7cnV0lqY+KLWscO6gi1aY38XNSHoEHMb4mzSRcKAOhhrqS3h2kiXLyX5BCosyqp6r4DBJBm/a785K+oArIe9HmIkuJAcLO0SaJ7Sd0wznlD/WbpQEAuFS/rLXBwfWtv8R4Amyv888Owi2tLTK9a1Q8xsmMYHUDoQUeYFze7bek306cWvrtfpisU0rdYjJfeQeCEMsV/R20JH6Iq2OTaMBT1Xgf1kMHq+avabEeDXmQzEQh68ai++phxOLXTH++mlwPO1LSjN6hUtzjN1IDAbFt/5RBZWsrb8bkj9DnJXrw7Qu03N2N+684VoHi+xQQb3BjGrlMmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0pknYjFcLzWR/Hv7Do+LRwr+46b2L71uyK1voYY0Gc=;
 b=0C+tgGfbEPXo62UqUrpqyhcJpCMolLWFlFIs72UjGh/LaIuEjktJELvMfAQc0bD4ybJ3g9NpcrNq6uZJRiOopIXKqLOOUGiJPkXiiv6MaBuVcdC4UjMx+GRkAfsqwT7iNujMorDad0v2gBvTB2SeNobNkZ5ts3uccEPKdxvCVTg=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 LV0PR10MB997685.namprd10.prod.outlook.com (2603:10b6:408:343::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 07:34:19 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:34:19 +0000
Date: Thu, 13 Nov 2025 16:34:10 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] slab: turn freelist_aba_t to a struct and fully
 define counters there
Message-ID: <aRWJ8kp7Bo5ZD6sl@hyeyoo>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
 <20251107-slab-fms-cleanup-v1-2-650b1491ac9e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-slab-fms-cleanup-v1-2-650b1491ac9e@suse.cz>
X-ClientProxiedBy: SE2P216CA0044.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::11) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|LV0PR10MB997685:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e90514a-30e0-4969-8dc6-08de22870e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtZ3H6qZiAFjYYDAXb7vYF6iQdm4b20qeQOKTIOqXUR7z+H4/+WHvwFbSqoM?=
 =?us-ascii?Q?O2h/Rwni7RYfgSqmr3pqzIgpWXuijmCxG0a3x2zLpC3FJbuEDyJwLpmxCDRQ?=
 =?us-ascii?Q?0I0qcb5i/Ggpe+oOY6q4Lh/3NQ27LJq6r2S1zwlAR4+UL0KMogTR8a+qonzY?=
 =?us-ascii?Q?LNphym5dIKqgm866Gims7rHMRwET8DuEi1b6gnh8oxayKPWLkIfwKc6/MMiT?=
 =?us-ascii?Q?oacz7cU/D/1+eOUKEx7p08dvDjNgTrWhk7N09TnnedxftynUxcTbBatqg7xk?=
 =?us-ascii?Q?b9AQ3zryLO7vW7YB1EEo94BvfnxsM8Lcy+qBf9mBu8SDFFCFXX/EZo0D/fNN?=
 =?us-ascii?Q?AW6Le8AglTxAn+Bg+DtpHsb8NIviGsy7353TTKfWEu2hhksFnO2gOSGOgMuR?=
 =?us-ascii?Q?lHUTLyQsIq1mEij1A26yGdOSeLHOXyXfP9RTz8SU5gSKaE/vwYgEhHGMojk+?=
 =?us-ascii?Q?H7CHZc7GO1ZvymNOl5UQThNxxuQiyDAtXBYpaUaqrK1NDCP82lTKcP6zGubU?=
 =?us-ascii?Q?zJBS10aYaWA/7aSzaIqmQQfmHVqQRj/WM/H+07/JJsKw1wSly0mI3K5fglgt?=
 =?us-ascii?Q?UEk61tOluJY+VM7YimkZf5KAtLuZI48AJyRTTFrAlxOgTLYqavR3HvNhPSfJ?=
 =?us-ascii?Q?Q4AK0Fz4hnGjLQOaNsoN8qMRn1VgiD7KI6FBYiy541dJ5NP+rQai5xXZB+L3?=
 =?us-ascii?Q?80YMw3rGlchOLmjfLVlDVqyFZ5KUSqJ5loL3DMSs483e2I9iOMrMYuEJ+0dv?=
 =?us-ascii?Q?2uF0lr1WQ4RGn06TowCJvJraiGF8c5nZHpOA8pcRGOfhZwQlhZSe1Rr+SvR7?=
 =?us-ascii?Q?IDSfSxgghbLkuNZtFDjZ7BFBdqXyzFmmXf9SLKjkcYBEcw0w99+lRsbMj/B+?=
 =?us-ascii?Q?xDtT9+dnIgjN4ksSDGuM8Esh+J1JppMGAtR/qNQCMHHSrOcwMV1NtEITdbyP?=
 =?us-ascii?Q?8x1ul53A5nPQH5We3IyBv33vjO8h6yCX7BD0LD5j1PRECRd+E5fIP5xOelmV?=
 =?us-ascii?Q?RzW7bZ5ylFZBzKElo2xVT8ZfAvkY4zV7ElZaugfFl2UxXUoTDfrnaF30cnOD?=
 =?us-ascii?Q?dFGNFJsyZxsX7H+YjDKJpNRCgTdQNAGLQqEVv8DU1veveBM+RRsfXTnGuauv?=
 =?us-ascii?Q?lolDvEothXos2cmeEOg6Zwb0LWtQMFCQVW1jEbwVjsJDLbWdYQXPHXAf7bNZ?=
 =?us-ascii?Q?Ob4vD7GvJit+795cuUP91kjajXf9FH9ZEePBUXpglQMTcB4+VMgQ0C0aRa2r?=
 =?us-ascii?Q?EdwUf4p7umREpmH/xiAvYo+LQYRNYa5ve0PSMVQuxyzT7CilaKpt/A7Ces24?=
 =?us-ascii?Q?SSCTMJjJgh5uI/LNwq7cHDz8LFKnqHyvpu3f5Yn38SjETagXcDYp81JplRim?=
 =?us-ascii?Q?TYy44KKH2iL+muK4nmAvqp+i68IpOQGzou/3Co6JHUCv7YcmrqwOOdHHJgUH?=
 =?us-ascii?Q?D1NLS41pqLuPt6KaxXVgx+Mrt26tYWhT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F0EXXTSCbtL6mJWTg8mTC5MaxhweJbSENZqLjzrkmAebaRvVjss9QHgXF2X4?=
 =?us-ascii?Q?U8fcRlVCLh7hSYJH64sFotarjTF8kF6CEZWYUmj9n9y5mM9ET9JQbM2IEHc8?=
 =?us-ascii?Q?Dkpgz6fbquWS2kDPYhMLIbGeOl4qchfLzAp9ThaWp38FEYdleheAdeOLFruR?=
 =?us-ascii?Q?lB5Y1iWf9XSDxOZQT0+NglzkC59lp2/O2o+HyQuEeNlKGS+M1OJUygs/xf2B?=
 =?us-ascii?Q?T4StngknE+pKLPYnOaJo1phBJCUKWInga0EVmeQiSsBc2W4ZRPPyz1PizzSW?=
 =?us-ascii?Q?bz1LzcERBvSwzCA/K22OpgQOmpr8oZx+NwXpRQwWigX8Mg6zPaHlFZkWRvUv?=
 =?us-ascii?Q?xAIfk4ZSzG3Y26vIR/+LMZj/vEKG4Us6mhrOAtFbOzoVOdhJ2HePBQO/KJS8?=
 =?us-ascii?Q?xCLTMJG3bo2mNvLPzQ/bXqH25HgzkvEzxDNPRjgtMwpjtXo15L+JngBahboG?=
 =?us-ascii?Q?fs6o2a/xq6vvYCoFLBYTIFpXu7LshmVyy4emGf6S+MAIJJRkjfn0Psle+avh?=
 =?us-ascii?Q?cyUO/uxtR+aGYf3ASzEf2NWdmujetW/gGqicdHyKvgSdA60P3KHhHSrhAJg1?=
 =?us-ascii?Q?lfzq7luXHyZEp5cyin3sDpidvO+WXKyHxHlyWA6fzk8yEORrpFl+BKayZppG?=
 =?us-ascii?Q?QuIkpXlSB6CkerE/9mJt6fN6qJwCPasWLaJCkIElBN6AumEFWHTfZ7QQ8NYk?=
 =?us-ascii?Q?+BvL0D83c8am8h8wwiPcoSrmDhfCy8YO2Wj1Hj+k5u+LkKSlI9vtYrKwiup/?=
 =?us-ascii?Q?wANl4epl5pi7GY5WqiJd9tKfG0CttN2RtE3PKxQWDFudxccwVqZfmkh/Ikco?=
 =?us-ascii?Q?ZsxymFY5XPnngc6di/AOXZgetnjZaEEyucMFsNeOVfCW47w/1q7nam65ZnAM?=
 =?us-ascii?Q?aCQXBf22j+xGus/CgW60EdMo4a6XRFt+7iuSg8ESDrPUwLeJwKVlVDRdRo9k?=
 =?us-ascii?Q?o5bO+57SYN8F0tJU8iD3Xa8fgW6ch72DFua13749eclDiWOPcBGOQDesv2EV?=
 =?us-ascii?Q?lSqUcw/gTmLfVdmHn8L7H3K2s7Z7gMHR/TPyJNBDakuAkk6EJl2pUAyEQPA7?=
 =?us-ascii?Q?Eywx13F7PY0NLkBKZgsw/5hK+BxTle4FHAirQhR1JNZ4Feq64ffZQGJ1TXyX?=
 =?us-ascii?Q?zh5EZ9E4nmVbAYQPt+cQlQ0O+f7nXkV+bjAvkKys/oYaNPXZEUObObFgiaV9?=
 =?us-ascii?Q?sO6Q6MvzRJy1JdrMp6xV+XCsD13/dF1S1b5Q9Wowr2T5wEe3vAd93K14QHMW?=
 =?us-ascii?Q?f2ALpFXuUdmiG8OZT1ORrvtAs/9C4/mCSNuDbVmyEfhWexBQD8ZGSYHpX1/i?=
 =?us-ascii?Q?eaJL7rrZu2z2D7h5i7MzrCYGakxvsiI+/itOUW5UpCCHj3A3wb2gPGHeVf9x?=
 =?us-ascii?Q?E6yU1KKs7+FATsPYagTD0oop++ubhKsfN3i8Wsobap8B2Ga8NjJe1939C+AS?=
 =?us-ascii?Q?hBF1JLrazbPUdGmlkObpJt+xJk57hCJ6MB3og26wdLf1D4oseKbx51H44PTh?=
 =?us-ascii?Q?1BwwR1qkoegE07thf+CQLlnJV7O/59hA4ZJdxAC9kuAKA+eIdXUi4mY0xo7k?=
 =?us-ascii?Q?fgKUg71TJebh0dziDWbUATy23+6i+/3Ngae0Xk5w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BV/qp3dvSLghKnAzPXz3GI9RQyjZbg14YfDVlEIHuYK3o7rhBWrKXZ/J25yZhVsUWtky0mO5cl2w+rxdCtZAEByTow3IToihWXCGRH3HW7fJMC5aK475nk8pWO5ROZV22xFtlZf/vvMwR8THOtNUUbHLZMig1H/psn2nfHOAxyWZUW9bwohbrzbdQvg3RYT5XBG/owEA7g58cdrcoE2icFxnc11gdtN9VEFe0gHOHc9OXT/2x0CdRc1flq1ZoSS+CWq08DvEipyonNsdm312F290Q9KawVm7mxE6wKaQJ3QApTIxP6kPP/g/hD6Wb8mzwzIvNZ/K13Gv0UjO6kQe5bcEMtQ/EYn3N66XTnYTG/sITBl6RYHafAVkpcj4jlFvE/RR+hDU5fNnxwmbyfQg3pl3kLldvfYYGEg6pA01QGMo9Vu5sCtsGx3SE5IVMY4Do7JVH/FOw86L217lV+WDxGdHHfm21t9VylaVQHbNbkI9pRmNu5WxAZtJwWyiUX+KzUk43TnOhoPgWEE4oOm8PHq9VMoc/5pgElODfOFol0wQBUQwz8FsB3E01wjoQSV92SLFA4mpwZQmYRK9Ypr+Nsqg5xVHEHpoyevUYe020EE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e90514a-30e0-4969-8dc6-08de22870e45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:34:19.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j5ip4M4e7/X9fvZgHj4d67WRc0qTu4xdrQhWAeEQeAk9+k/eVBFwqfi60kg8pfcPa711ouGdpMKMBjicyQ30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=886 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130052
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MSBTYWx0ZWRfX+uj9HL2L6HgW
 5kE6BqURll7SUuew37wjuxPMlkvDMv4Eds5G07KyIe49ZQrtIk+hOn3qr/pn/Kt+2ARrUWoxpJC
 DOXmz6FXeobK8ynNS+LZ9doeYeI1uRFib1lx5sS85oAxkLXARaz359pFH0QcPrN+FeqWV47CKq+
 +k5lfAEkZG1lC68JnSNHHnmfIRKSsKVy5Pi6geOzbp/ypp0D0XSxsCUiwX0dc4ZWPAtusP1Y31l
 abZotYw9GZXpaWX64Sz8OQCJXFCPcfhIMVs/zKZgxI/xYwu+TZFLOhQHHZcsFRW3anRw2UK+XoZ
 1w8U58GWLBrwmZaBgfLjpjjdQREJXei6Yy5UDZLu8A8fpLom6dQeHwvgh/6pw3cqHgEImRfroTi
 FJuedI0D4t0urOLPFxKb1KWCBPRvEAT2TaHyhOevDYSq6iRTNpg=
X-Proofpoint-ORIG-GUID: 303f8Jkyn4DknYY8w0vn35Ds_TKmGUQI
X-Authority-Analysis: v=2.4 cv=RrjI7SmK c=1 sm=1 tr=0 ts=691589fe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=9WRvsxVaw5q7EFSfZ6QA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13634
X-Proofpoint-GUID: 303f8Jkyn4DknYY8w0vn35Ds_TKmGUQI

On Fri, Nov 07, 2025 at 02:51:24PM +0100, Vlastimil Babka wrote:
> In struct slab we currently have freelist and counters pair, where
> counters itself is a union of unsigned long with a sub-struct of
> several smaller fields. Then for the usage with double cmpxchg we have
> freelist_aba_t that duplicates the definition of the freelist+counters
> with implicitly the same layout as the full definition in struct slab.
> 
> Thanks to -fms-extension we can now move the full counters definition to
> freelist_aba_t (while changing it to struct freelist_counters as a
> typedef is unnecessary and discouraged) and replace the relevant part in
> struct slab to an unnamed reference to it.
> 
> The immediate benefit is the removal of duplication and no longer
> relying on the same layout implicitly. It also allows further cleanups
> thanks to having the full definition of counters in struct
> freelist_counters.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Nice cleanup!

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

