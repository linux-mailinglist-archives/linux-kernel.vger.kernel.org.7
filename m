Return-Path: <linux-kernel+bounces-736768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0FB0A19A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A66A3A255C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BA2BE7B3;
	Fri, 18 Jul 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FlkCnHXM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ks2E7nak"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9428B41A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836945; cv=fail; b=BLuthPRV6jjXSe7Xx1ltmaP8fKbiUKkG5Rp5EE9aHJ4FsOn8P6xGJgBvxGRVUjiHmIIyuxfoKXJy09KS4xqHjAPkmf8DEVCnIkUtV6+ktq6o74vaiqyisWZqYB0EiFk1iYc/09eg9XHnsmFISD2RpzRWUQaiqol9WSu4z1R/7Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836945; c=relaxed/simple;
	bh=4HoVVY3sIo2l8UJ4knUpju56S+n52h52N8OSCZly5pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqSAc1Y4RKyorg2SXI+3wge3vuHfUp45Pv01124dJVboT9uQI9NS7d7DKI8OAciHwzqOqAIqm2aWP2shoYG6NPlR9GaWtS9ALT6ZwGE3wC9Ylr78rtBwsZBbfmUQz+joZ4sm7khDmA+72+tZx5UUIKakrf5EMm3n+Vib2Lful4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FlkCnHXM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ks2E7nak; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8fmh7011207;
	Fri, 18 Jul 2025 11:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4HoVVY3sIo2l8UJ4kn
	Upju56S+n52h52N8OSCZly5pM=; b=FlkCnHXMX1rMd6+LfdwSf5aTH6sPv+Ni5S
	qivWp3bXzw3DvIQck7z24KoSQRxUrU7sVmf+0KQejX7J8An67X1Z9xnZVgbRVJB2
	W6J8VBpv/5lala0Qjl7fvPIrPRvYAUZi/Li2NWjfFp2nfmhfiimEZV7vxBQQ0mbB
	sRBj4/Py3ABc9Vy+anyzFwA/pNJNbcrFV1JFvplpGj4juemDquri4YiJNbYv32NL
	EtgYhf3O5axl+hMJ+Pr9dBtqBRgUmYrsC6EQPZ7iqoWbaqd0ExSFMsqk2XXOHdI6
	wHMskRCWPcP6WeOCDTVzTY82Q/Rorl2Gv3qTgOFDOIOunDgxKyNQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk674hxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 11:08:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9XZf3013526;
	Fri, 18 Jul 2025 11:08:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dfaqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 11:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whsvr0vnHNUODMkkR1dV5RCWDCa3hOd6TOa25GI5M8thyJ8zJ+83ghOFhSSQGFKCAnBaik0nz4ogzgezNhUlqMpXQ3Fp0fOFwIJiDCQmtLbDVG4+Rz1LPZyW6AmmYcjUDgxkZoVVehfXN4hKaFwvqjIGhSbSA+HPRFtRdHJEkvFtUgzXAPnUhqx9UzCHnjKOOM8J4MR5j1wsKtYq0BgOynyeFMwXNeQdXdhRYv6n+bVFx9XQ/9filX/eDLn+L7aJDyGDFG5E2kd5npy9DCmMLYI4++2o90Dxb2yu+WhViHWi/JvSWa5L3bQ3LO2NjAgwJZoldIGOsbAQHjLHF/CRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HoVVY3sIo2l8UJ4knUpju56S+n52h52N8OSCZly5pM=;
 b=DZBjPc6vTso9UF9NAmOzPEC0DsK6anODBwCs+LFOPk75tWOG/tiwR4FDKIUcYfrj2tu7dKwg2kSrx1d4WP6+7F2twVS/P0ffSoMhbGWfgqaQB6OCA25SKv2jq3vi73B4WklpkeNaoIJo78UdCtbO/CGdhQR015x7vj/xilIyD57dloIhzg0rsHWJrJN/4hpC/1Caly3s5GxxSESmegop0k0ToMMBMTaeou0DRMwfe37oOEwsw0NLCZoV0+i7Gu9Non3EPNqiuANiIlkZRXq9kv+vrNiX8A2Fsl75VSwqN+7K+YRRhMwikHmwFgDOtKIfqWe7vzwJVAOpD2Dj6iSsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HoVVY3sIo2l8UJ4knUpju56S+n52h52N8OSCZly5pM=;
 b=Ks2E7nakavpzx7WwldUQrbJ0Z3aCOlo9MqRl92NPZowU+THbxm8aVm0qTlfudVaCvCsmRx893Ky5XSffdFdl2KiTwLgA+uZFlOUxb21ygz7E997p/edyH3NJY7rjftyCSDjTVzJzBv5jrsLUXgsSisZ4wYWUk9ePSCHh+Vigi5E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 11:08:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 11:08:46 +0000
Date: Fri, 18 Jul 2025 12:08:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <1b307a1f-2667-4f06-afab-a49061129e77@lucifer.local>
References: <20250717014623.2253-1-hdanton@sina.com>
 <68787417.a70a0220.693ce.0037.GAE@google.com>
 <8a2f1892-3184-4aaf-91ea-522e9ba2391b@lucifer.local>
 <20250717234212.2329-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717234212.2329-1-hdanton@sina.com>
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 17777264-8077-444f-8247-08ddc5eb770d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMzBq0QYsaAsKFRLHgQQqAOTKEHG7k22dn2hrXKgwokJFWxiPvxkCglMGHLa?=
 =?us-ascii?Q?sH0egOAlXTqPysIUGoJjF6jijfh1TRJ7NL/1tfwGLF7Re3qLLdPjmIYKiaIl?=
 =?us-ascii?Q?UOVALfpueOlsJrG9M3mQfvPL/WrioWX5dE9kPVIgL19S8GCOQdF07W1TFTg6?=
 =?us-ascii?Q?WX3K51PQMiTYUuzJ0Isvwwpm7TRLfkBI41bvhwul9j+O4sL0hTUEbI8ERSMp?=
 =?us-ascii?Q?FHWTo17Khgl0X4By8pE9O4F0/twcvvHAZ7Xul/hInZ3OvNNWtFy/eiBpH59V?=
 =?us-ascii?Q?HCofjos8c52bDgT6d7JJoKVcKdLi90mq01a7ntFLLx5xFaG5SYNX4zyonVuf?=
 =?us-ascii?Q?6MKSrRYAZIEaTa13295Yj1k2mhBteG2H5pgBzP5HM/qyjxYOJP9cNuQ0uMZK?=
 =?us-ascii?Q?RrKgUqo5npNQtp+gWTVcFPn91/ir5Yy3HXUjGAKqhf2TrZbwjrjbJoyKHzQ4?=
 =?us-ascii?Q?w4sznsKWpmZyg6AzPntWV41MW3QvdoOwLWHfbJljfLpU+UPqgUHjn2SP8MR1?=
 =?us-ascii?Q?A8aCSCrv9xrMNgwX46k2jBzF4nDtElExRmXXxPTtdrmUKNikLZw9uqO/iO3h?=
 =?us-ascii?Q?/SbwOsY4zPazjGBwH+GGKJHJ3cGjMUn5Qbd9vVM4syPRkol6u1ayjSzzPTnu?=
 =?us-ascii?Q?qxuAzkLeB/LwA/fe3OkiozDhqyeWVs1CYzox+cHD4KwAecqxLNZ9sEGUP8Q2?=
 =?us-ascii?Q?J0C1ctKVaT9knZoQxUsSJvEV90DJ31iPobVu1tXUtc/SUAFbqheta6AuAvYf?=
 =?us-ascii?Q?DFc6VpAnv0xH55wscYs80ln4yEd1qUMWqqKIFBqBCxHx+jn5QsJ+94EfgmWQ?=
 =?us-ascii?Q?rSjjys7Kc7hG5W91yxiP6E9AO8SEaZWz3L2yGPsV8zWAcs85JnyBVYNbWyq6?=
 =?us-ascii?Q?v9acZcnE5GDSYvqWGe99F1srjhwBSaYQUsV9tTuho9dZw1hoxs3X4/rz3btN?=
 =?us-ascii?Q?xH9iqS10YXJI0Hu0CTwSBQPgujt47VJQdjee8nqxhiDGRDHaBbA0WhhIV9lI?=
 =?us-ascii?Q?IIk98NrPCpSp/NV549KY3fHe3Sj6wMGn01E51yWoi9u+kbMby9rMVhtxOuqO?=
 =?us-ascii?Q?RH5qep1+9lFEM14HFRXgwOvyqL9zV7shkj5TIHdIgKi9DZQU8buEE17o/+wv?=
 =?us-ascii?Q?q1AsLa+lJtOYMrPedpeXOCNpqF73bkkUCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/usQrdue3fAuxue/MwF8AP4WBUkw+hLynJrNxaTm9U/jdbzXu7gfSDx1xZ3?=
 =?us-ascii?Q?+k4kXIEDp6RbfGIBjeyx31Me3CyRcKHXpXrjkbIQDesKm6mH68eNHgtzkRHA?=
 =?us-ascii?Q?vR5sWd8f1Hh/XbLj1DL4rRfTXcQh/0pOmZo3PRaBzAfV5uMJjuKyWqnPtdMq?=
 =?us-ascii?Q?OaqUJ1Bx9gdZWpBHhULk1TxjnLKH0GZMIeNA17RK/Y5yVBDXvCtn35/wb9YG?=
 =?us-ascii?Q?8V99GZ1uZ/bTuCrWzufa7as4GT/cG6PIvOwZrrfYMZiyBhiyYl+552EN1GV4?=
 =?us-ascii?Q?GFKJxTUfEgoQQaiDm6WJQMXrm14dni2arcBqEMBKvaRjnIPeJh2zFGls6kd2?=
 =?us-ascii?Q?SrMdAZzM3XyhGZhbAp8tGDSCpSemtZG+nR3EfeYw4yaLxIVbF1S1oAxMTMzR?=
 =?us-ascii?Q?NsSf0Q3B3B57rw/rg6CDgtl7ZQ3TrsEVgeFjXPLNY6g5HdZkstYJ3aO5UoXq?=
 =?us-ascii?Q?DL46kkJ+o8Cg99Yxz3dDfnroc0Y6E1YEe/ydScyRDHatEaOY6PzI1qCitrlx?=
 =?us-ascii?Q?zoPSK+CssVVZnDA81yfeqzUxpNKpaAOH7/iaz+j26o2J3ar4R8HrWertYuZZ?=
 =?us-ascii?Q?wkuLi9DVAI53gpMxQa6L8Y4JPq7FXdbjTXGRXXsORBO4LzCY/MaFBlsrTKEm?=
 =?us-ascii?Q?955QxQJ7NKzdeU0HbVXwFVZmg3kCFohK5Sb8JP0g+1mcsvFC+25dMiTecElh?=
 =?us-ascii?Q?2Qotoqs5RTWJxDLkSpW1foCMbMXFa2hbbGUobvNF6orbXXHqPIjE1YCIe0bB?=
 =?us-ascii?Q?dnfMVNQnnE5tliMYJ2fhflM6LkR3QWIvATOSvMKbqXbrFs3/fI5lixmBGJtM?=
 =?us-ascii?Q?yvWsWoFL/53SRXMmXeQFedAdlL0QE6KuJ5HkehMRaxna86yrvcPGIw9TnhJr?=
 =?us-ascii?Q?sWu0iQ/9B9SZA5E4CwBjUiTrArXlBO2MGBZPMOyu+mXBWw9f6+Vyy7yv/i7b?=
 =?us-ascii?Q?Zxx6QZAVZ8kH+x5qMn3S8eL14dFeNqQnQoqzhtUEL/dYbqoWGj4dYQvv11zz?=
 =?us-ascii?Q?FsjO1/kK84/iilqSPXZE9wyXPPUlcHgoWLXzIfvK9E5F7reLp9S1EZ7dIsEK?=
 =?us-ascii?Q?dhXrI+pH0JVLzKkP/2oWoG+KlEKjqv5RIBMPKqWQ2rjFZr7IK6Uhzx/Ue411?=
 =?us-ascii?Q?GRdYSu/aCcBGg3kcW/KWr8e15U1AnqdPshVsLCHynsqwL+0oXdkERi4g9LZe?=
 =?us-ascii?Q?Zjbz0Bbxucl9hqxwH31fX5cFW5kSLeV/Uc6wyRyyaCsxRjvgkV+kjroBjfBt?=
 =?us-ascii?Q?utcYEZBR+BxfnebfceXjBIqXM3GYQFXxkhqbU4K8Wb9vaRTcJT4dogZeTBV1?=
 =?us-ascii?Q?JBmydmOTTLXZodpdZXNwnukjsEfyXS/YGFpjb6pU6IyuVSwQRrjYXKOS2Rym?=
 =?us-ascii?Q?6EllsYKdZPPHxwGYtz9zpaOneH8E6MRnSH0n7T7JEww9UQ7hNx/SPPA8o1Ie?=
 =?us-ascii?Q?Q2p+sNLdKr9j4PgGluuU8O1xzVCexmnQ7ILCnoLVnYkOWKOjMJkqX0qsrZsZ?=
 =?us-ascii?Q?32/oWYTTsVxCszTGSFDco6GLlFB3YwjopLl0/1l46xNc6o+eayKqNW9mGc2w?=
 =?us-ascii?Q?rg6wyo/Y5KWraoMsopbwUl0HqEQyi/VPGA26uVrGgtlsaCV2KS7572ATufu3?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nZb3Qr3jjmr9j3hrDQpuIVms8QZTnMrB28wg+GtiLTdANRV6WckExy4tszD4mCKMhEe6g3dmztoYrTz3VvxrCMkOaNN1XrnA/pQiDDU7TXooMkn/BiNVJOAM9JfLV/bJEHg9L4JMLSzj7sJTR1NquBO601IzVaZVZ+meaZHRE7x4PpztcgXAS6iWLaLwQabrFUZhOjjO8ULFHhN+L6JSmiJX/ZPJ8ZPM2GgJb+XFF58Fr3jIc8CcyGhSLNNZzdQuyh4TE3QR/D3LB41CVP52zStvtmDwSJ7trw9gPQBYl1VDhTZ2x9N16CNm1ygwLGvEH689S6qLRg5TA6thN9nkcYLDcpf1LShIqbC9HFzsNhmj/FADxsUn26xqcIYH5C62VWDHx1raLohMG78W0+8PvWI7klbfOR1NQ5KMRoqXOynSglmI4vaRXvcn3wme4cL0UI+RDA8epzl59oWOOf7K0vyrbfPp99p9ZFVVIUgvLvY1IMSizMD2Q9t8ISOampLuoeiwL94Y8d2yIaxuWiqWz9cXziZccgarZtw/YZ5AMPvmhJnrc3niuSCRZ0c9XI+Wwxupg6bWuHdvMX3ix9LluZU73Z3m7i0k4UQGhmxDDH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17777264-8077-444f-8247-08ddc5eb770d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:08:46.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2zYHwPMHiHQXAxAs59kV7JvRbRZtySE7yuZUndAfhk9t5Z0JtytLWENJwZxVL6YdET0pTfP9KPIG8J2uWtJ4DiWShUoG1IRhii94kd4BXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=541 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180087
X-Proofpoint-ORIG-GUID: 5HXkFEIFF6U8YJkD3CAv33Y4COqx0a37
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687a2b42 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=XcwDIasPkUU5zM0pE18A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NyBTYWx0ZWRfX83j9vhHBi8TN dlHLeaj/WcZ5pdWAfcLCXN34Ijb/xDdSJgxIYsjiAttndVK26eGc9JYhuHElZ8nekBdAwyUzFLa qn+bq1wU1Kwsnhhw8NRUetHHFYcVjy6JOPsqjFBf+btLuY7Rhk0a/2pnAa+YCggHmPJhatEG/5V
 kqx1r9ft/MiHIwi3amRgXpxDbkVmJQDM2sYOxxc4XyZB7sLQitHVlUxIa+fpyGmYKEkDIfwEull 9pqX+I7zrWbB8ZkqvlTvVz/160Oq8S3k07jPM2ePGvGQTHgXEXlbnRgVVwQFo+jjHDjLtzJJjH8 qvBhN9sB8i5kCZauEVwnPdBwzv0jPzphL9+GVz8JwIdYZ/hPcmDFly5M3mMOIs8dnqOa+wPJQI+
 A2rZ25DMiRuWOct7jzjwxA+SEwB68N93G+Jfk45vPHilurmJoKPn14uVOkfTv+YgS/8yi7x4
X-Proofpoint-GUID: 5HXkFEIFF6U8YJkD3CAv33Y4COqx0a37

Go away Hillf.

