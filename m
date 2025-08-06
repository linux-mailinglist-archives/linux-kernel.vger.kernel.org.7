Return-Path: <linux-kernel+bounces-758197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3083B1CC4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB7F7A1655
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BEE29AB1A;
	Wed,  6 Aug 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WliXCAZP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X4l0R+eW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562626E146
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507270; cv=fail; b=N/YdZ3z7TmdgeBcNgLAa2e0mnNx8lyKGgt0xhUumkAq9WWt44logOcID9ZBvofa4DegWR91IetPmggUyUTEAq9GO2OYrPRN7X9glhqsb3vGQweelmDrsDyxKjW21cuiJWouv3E9ETGZJPul1+1lpGW29EuNYEanfW5/x44cudrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507270; c=relaxed/simple;
	bh=bDnHS2UQdvkSpO0cghN4XnGKKhYUpIKDSaIye3FWRow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDpE/dJ5Bcu7XSDKHtLnw3lTN9H89+xoWbeVEskxKYM2kyVF7uQK+fY+Aoz7ZJgcQx1jistB6xhHpjXPyI1dTpG7vg3qlCy0OOvVd2Q/CQbhGA9Pgtwypn++BwYvu5wHAHtvkhyiyub7M2aiBRAq3MfhQV9T6Y0/uzp10m9bZR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WliXCAZP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X4l0R+eW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576GRPuN001619;
	Wed, 6 Aug 2025 19:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yZAPmkdkr3ge3dnjqG
	hq4rDqLUdS0aMLUrgCoakskj0=; b=WliXCAZP5jBCF07N10+zsWZDCOAhUQSiEn
	CjUKFpx2MjKYpHwlgI/zRsV+XCX0zwLfRu8q57A7vyi50JtkEyF3ufZTgdZWLsmt
	ougijiVTearW80aVBkTUi/X0+sJnJN5g5JcS8FmEZM4kdhBpT4kFa/gCKLUd5giZ
	kEFhuKCvUn8kTV8MMN99fXVo6Iccbt1mrKbEM8oOYS9CPSnnBjcFlcun09wqqjtM
	DM+DKIRcdw+Drv/xuxEcbfN2dVQFs6jz1MPDKRdqsms3bvEc04CITelG0vGFOQQ7
	YPFMgxKzaxHF3PMQG0/6VFMFLxMpMcdkpT7zO6goieV9cTLKaFyA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd2h08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 19:07:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576IOuRt018415;
	Wed, 6 Aug 2025 19:07:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwretrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 19:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqZoKadhIRhGynnRvaAKg/sSLytuHKt99/inSr4iPHfx5E+L7SsJ4dpL//lezfragELAJJwI6b6Ab6SvxaVaE/ztgq7kQjzjQ7FPOAw0ntxW3slzs3SDBRIacu2UUQuKKo1ssDmHn2Rc9moIftOi+Rm1sVLMsgP/CZg3uNcd6/JOA6ITykijIO9jND1zne749gWHA+oQSMYMNAdB5mek/wKodJgqoTro/3U3mWadX8yoLcT1bOo7TwcNCu3rycn+YDuV0+fldPcXwvLEL9SfCj1djlXCUsKigNsxZ8Zem2KI/uMlYN/cxNLmK2St+cDsvXzicp49hwvhaNt9Xo9vAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZAPmkdkr3ge3dnjqGhq4rDqLUdS0aMLUrgCoakskj0=;
 b=XOxQ5GA0EVFeupk74g4+j98QrM9dBtjByAKahD0Bu1hWgA+Gxh20PIgykbpSX1f1qxvY0U0feOnR2jjXSFQqean5k4gW4RKEpqg7e95N7Hdt1ZIf0K41KMzdF9sttUycJCl4TLy+9dFXQ67TU3QEe0ivY6UzAwcSFkFbUtIxMUQfMTKocS07yftXOF3AhEBLXkzO+pQa0c3KuFbuJaCKaaNB+fQJgpL4SXW3L5kJTuPLmYDU+UWwSnH2LORfd8j3BSbSCBk1SRCw3pnOQETnD4EZTg/hUJ7Ym92gWifo/qjeu3toq6UlOGQnlWrRrM578hayeCjZERCbR97ByY5XXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZAPmkdkr3ge3dnjqGhq4rDqLUdS0aMLUrgCoakskj0=;
 b=X4l0R+eWDT0HJ3iXXaOMav+vF354zPMiivBqi1gToI25RXORLG2pfahK143CgowJHbMHgMdLckpiLUGBR2PCcaGfuIIlo6BNYERuUe7pbFC8TV1t/hnXzuGsE/ALAnyLQVtlNXzTAOcxRjIz31lE91r/sIWJfLbVY2AsxqH4cmw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7777.namprd10.prod.outlook.com (2603:10b6:610:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 19:07:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 19:07:28 +0000
Date: Wed, 6 Aug 2025 20:07:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Liam.Howlett@oracle.com,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.79.tang@gmail.com>, ahuang12@lenovo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: Correct misleading comment on mmap_lock field
 in mm_struct
Message-ID: <9305bdaf-9455-4c26-befb-471466f952ab@lucifer.local>
References: <20250806145906.24647-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145906.24647-1-adrianhuang0701@gmail.com>
X-ClientProxiedBy: GVX0EPF0001A04D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::49a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcac017-99ca-41ce-75ac-08ddd51c7c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aI9iwPopQACOKoDA3Bdx8DZTav3IxMfv6fRCDdiAPPX+B4/YKtjuKAV+nBis?=
 =?us-ascii?Q?s0t6xQ6QgQCWOq0KcC+8iHUpscnD92i5KA8pQEFRoYIlIk7UtOdUza976CZS?=
 =?us-ascii?Q?nI1qMFoppGYs79TTxIxiYOBQjmkZ1NQv3iH8D/FQtYW6C4dZX1+pMj0k0hLC?=
 =?us-ascii?Q?MLKLDrN6Qos7F1+QVLy78FNY2p+zM+rWqCOuR5vQPr5UbR13HDX/TDmTl4OZ?=
 =?us-ascii?Q?uVg+Lk1RWZVwhrzKhr/0sIGmLYxxf6p8Gcad+XsylsPzTdh/Mxv1mrCOfIw8?=
 =?us-ascii?Q?1SwsJxgHQ1qoJE2BD0MgTAjN85/c9OpHMsQ2VSnT3Oy10k/oJxP8aMIrLn5K?=
 =?us-ascii?Q?62OVSKgUu9dJ4edgJ9bkSPm3zWfUbHpAlsdDfPRRZm4jGrI0hcbZmASFLaPV?=
 =?us-ascii?Q?bOfqOup9eBSgmmLgfP3r9zJD+VuX00UE6K3+tjO+Dm9doUCY4un9z53HBZbN?=
 =?us-ascii?Q?N5zXlJnroxZVel4tANYMC3KXOkDxchAx840AsgR6RZX4A2W3gNkphY9x95I4?=
 =?us-ascii?Q?gGj0RFocTI2yxYrLT7GUfbhcLGNjQ+neKPh7nRforyVs0/0IyZ++A8HJvAnU?=
 =?us-ascii?Q?U5JSWvc8j1TMGSsc6j5Uh8oBliOZrE22xncyTQ8yUUSz+WcN/u3tK1D5bReL?=
 =?us-ascii?Q?Rq5g/tuMtYtK5ya9Yz+LPkh0nnvLwOEnvyYZP7jxGlpmcmiDzu8+nEQ6sm13?=
 =?us-ascii?Q?MsfLcdS4K445psWX6cVhICa1O/49DJafo41xi8uU3MKvVLQ8hLKxmBleRqr2?=
 =?us-ascii?Q?z9BoUnSB42iUa9xwl3uROhOQLD0SmTMz1YOAktM5M/9LMW85ZPxQolWT92ec?=
 =?us-ascii?Q?kKRkYRihvhepUKHzNKUUTaS5RDz3XZWZ/iijk/POa9J0s9uWEPSX5sOq9sZZ?=
 =?us-ascii?Q?3JIev/4ugtqj08ipjCTfbZMosKdXzgRCBn4ZzWI0SmruxrVIwSn9yH5vZW9J?=
 =?us-ascii?Q?BHXU1WnhVK7iSuahxPjoEz7kUfI29YjFLtycmrjLuFiNAtFHBJh4Nuujg/bW?=
 =?us-ascii?Q?Ujyi8KTw9/8AL4DFyt6+9gWVA89QIsjFKatLNVH7ooEUEnwlNIiJVuXE4JQH?=
 =?us-ascii?Q?4VDYXXQvKQo97Y+WwKJMD6xwKweblTYrUf/Jxef9IiYGm4z59zU2ZZ0+8aKr?=
 =?us-ascii?Q?mZim/ySakpp2SVL+7VS7cWroYeJsoQ6C6Df/HUScWKmuE63HfenwYSedoZCw?=
 =?us-ascii?Q?gXzbJSn3crDeMAP7YirrMrXCLOop7/whzAKsmlOBm2xpOCN+EiW9Cu76JiwQ?=
 =?us-ascii?Q?E7PmyVOIu7BXkt9o26v5SKqfFS4IURnqbWGkkvC0qubWFscj6rn0X7nh/uJA?=
 =?us-ascii?Q?DOWfJ2v7rYFNuLjLZMSUHKiLD4UIVFzanQkHXcdkioEojHtXI8UiFhGEq3L0?=
 =?us-ascii?Q?eKGFZW/h+W7gHCWrW3iF5pT0MzmLesHlWDruER3p/qGt7xWNMNvCha1GTk5I?=
 =?us-ascii?Q?wqDaVCgWEzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ELoJflJol5jkBzoJjXd0lawz2XJ5RfMIAYBLm6/N0ucERRtmLE4a3P7MEDsh?=
 =?us-ascii?Q?F1+zvjN48HBAao1xc1qT8eoM1WS4L6MHNKy5O7bn+Yl5SCp8XHiLJoo4/NOA?=
 =?us-ascii?Q?s/17+vu+g+q/fAyK+0eXklgCvqEDa6kpn7t5kInkoS/5Kdd5PgRdnFgCzkei?=
 =?us-ascii?Q?iFlsOgufsev8MNioCiyjmr9A0V+Tms1q9idgnCTvxPM+zupYtIwcQxJWSZTm?=
 =?us-ascii?Q?/EPMiH1jtoFI4zuW8NKM+S0djm/OZ4csFOdiUts8OachpGFosSqLox392e9g?=
 =?us-ascii?Q?9BdTpjrfI99eNIomA0GZDz6RAgPR3iOwxhGqXkYSsLDU+9U9xlSmMSzTaS8H?=
 =?us-ascii?Q?cpFT6v1fiqw1PMkVJ8ig/h286QckrotYhtQZTu1VCbLx7QCTV2rNeTmkM6oY?=
 =?us-ascii?Q?IkgQJ0TaJxWb7i5eyrKJM/CldMT1S9KZ2DHO+VRa6GJkLp70CgM4/pT/W4S4?=
 =?us-ascii?Q?h/tooIFZwOYXLgBHXai5LPefVXoH7PuzLlGhIe7HPfoPmfucWnQOBVAc2j/p?=
 =?us-ascii?Q?530/XgoT2GijPsllbT8KdVSFaJHlbhGIqxvL/yxh5KPkpVyPVDKx8WQNqQAU?=
 =?us-ascii?Q?c/VS0LBklj4PAcZaioqeoVKWT9n19p7ilh9Dq3ozPTjaGvO47AYq5am+EJbk?=
 =?us-ascii?Q?qDG4YdfVg2AZkwGpx7xp/UHkCUPkg74nQwVKWD8rLODCCmdVGUUXEie7pIjp?=
 =?us-ascii?Q?Adsp0uoqgTxw5dWm31gtLuVQZsbaxOxF2ruz4E0nA6abU51JrjH4BZEFUsek?=
 =?us-ascii?Q?qBies5Dk4Ss/wglzpznfALMBTGgZrr8gAAqA1iqgTTS6KJxDvIHWOanncxdV?=
 =?us-ascii?Q?2lnff0S8x4yE4IlWOOlAXNbqtoM3M6iobwD+qqF0/mtK0B+Yv2wb75gQugab?=
 =?us-ascii?Q?PmNflB6PYxui2VsGM/drWgsB4HotUsd4ZuYrwNuAhfeU5u936+DZevw2fgLi?=
 =?us-ascii?Q?PFu5ZdJHGGE97WHXPaDaPl14SJKKZCv+7RNBxUPMpcskBR2cbJipDlvQ4oEE?=
 =?us-ascii?Q?JufhL5pqVNYeUYAuMRv8tQ7tpoaWalglYo2tCDYOUivwwa8N6tk0JUhkHOK4?=
 =?us-ascii?Q?DynBBhvGkUlBtETz7xt9jqKpdxGiowbkgSSHmzM5tHNPIxG6U8chXYob6L28?=
 =?us-ascii?Q?Cij5eQjJvrOGikdWPFZpapIyOoWovPwKzl5ne2lA6NtErhNgBeUoZ2/xhgzK?=
 =?us-ascii?Q?6w9CJnWnnO6NuYMbPe3zgDtpFaHxBxY2OBCXkYRJNmXHbSIghlgULO5Hl1Mx?=
 =?us-ascii?Q?jRS5pToXZg3c1RccJ/eIx7x+9n6n2IQoTnFhUGGkrX7Y9KczyC6lq5B1e/H/?=
 =?us-ascii?Q?Pm/g3/BXDn4mBQI3PD4DrjnuU0waRvVKa9w+MXOUMukmNgkRktTjb1TDl+Cm?=
 =?us-ascii?Q?rgCHcG0n3xexnh+yQpYO0cze8LHReUlOWUT999MMNh4WkkdNiqV6BlC6U6WH?=
 =?us-ascii?Q?mSiypUkwQV+PTs2eEUm89Kj6N4MGaINHkxQwXWU5OdhslYQUpKU4X1ke7zvc?=
 =?us-ascii?Q?F797Dviinmh/KQp44yuoScmyk4J7CtgQAtx4rG7Kbv5cbLVGspG57alcXh/X?=
 =?us-ascii?Q?3sFqKt7rH7vFE5hnFXGdMCUe5kJra5vO1i+imRGrXXbXXpNJ7TFFRCO5qVyO?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pMH0be+B6CtH1gdXDfGPwlLF/v1BOica8ybKE98tnKAJsfpqVwR8s5qIk02/z9frU4NQiK0G5KulcAPGKoXCyf0CCG6n8nkeN6Nt2EmPUML0NJdlqQobx/9hdtaO19GpTGrgoIqXdWWj8QUTWoK/EYWcBTGZWLFjw6AIiEqR2g0golj4myoNg4jikBLt0xv8X4hg1eG+gSs9jtHaDsqE9wOPYVUeTF1nolndlGJ5xyjDjPQWzUBbMxPk32Q+jIxEvJbxceSZessKzJEMiLSMnSBHIL0g0bduF7ic/dOzLB+6+pFaFs8S0/k2PkGX8KPMzLnKUQAqiUYKwzpMl7fEMvbqgOeOj+vzbpjw9bOvlDeGU57ybJJRwuMJVmhRT71G90tuZT6N9hlnVnDOt+YrpJ3CfVSynd6i/8EALA4ISu4cCdDPKee+DYfkcHntQY2rAMEIFdcs+5ouPnvUasnPcAXhINH1TqQSyJNHvaiKPk4bGriIjx7mbD5QdrMQQyfAsodWeUiLYNP1DlACJQP+l7xH+CAvKKRsznXUDE1xBdlM0tI9zUmPCCK0fCkSviACzdka1bMOLS0AthJUuWw9YmSN0ajuzslwDzljKgLcIT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcac017-99ca-41ce-75ac-08ddd51c7c9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 19:07:28.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ju/1s+yFhTH0pdxsfdw2fiYpXiEsbj0T4K4k2cn+CRadR367dbJI4pfUmbc0KVf9PGAHlfG8cSMoXhIVdhDhE7pLGILQ97w3g0gMnkQLZ2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060127
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=6893a7f4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=Ksv7K3a7lSteU0vTKZkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: 9WShajWPyOj9Q37MRy6kP-7iiS0PiZSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEyNyBTYWx0ZWRfX5IWOn4JQthbq
 mLM5w/gxKEEVwT4Sk3EoU3MaFwSrIw2aSYhamG5F9kKe/gSiWGjTKEEOdzRsvuXT9PyO3USMghl
 XKvGPEIAs8x4wC+P60yow5wdXeqQHPs0OoqyEk3HfuULo6c2F126AnTywaFXGIN+CQnrx3Wr6Az
 YsdNMTC9Sz1NDWUFkxBLLwe05eW+iaraGiXN8cfVM6jCF0FZBXShHBSA6+A8TrrVNA88VWhiZC8
 g3ce4N0rPwdxeiH7+lc3TsVMc6aMKgWDjjGOK+1MmzI6hFW6vzdgHPzTcnAfaO2TaOXHDbusrvp
 xED96/TwlGYGgYzswOzDjpKIfoRsaKt/XWrFvBRbSG+IOjAHANV1+MBAPt9ueS/5xZpY2jILhOu
 nkiKFoPL9rfbf1NmiEsbTKlciFu9l/XC1G/oz3Pb7uV9XVUdUM+JRclHJlYkFBPu1UsKlqFi
X-Proofpoint-GUID: 9WShajWPyOj9Q37MRy6kP-7iiS0PiZSK

On Wed, Aug 06, 2025 at 10:59:06PM +0800, Adrian Huang (Lenovo) wrote:
> The comment previously described the offset of mmap_lock as 0x120 (hex),
> which is misleading. The correct offset is 56 bytes (decimal) from the
> last cache line boundary. Using '0x120' could confuse readers trying to
> understand why the count and owner fields reside in separate cachelines.
>
> This change also removes an unnecessary space for improved formatting.
>
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> Changes in v2: Per Lorenzo's suggestion, use "56 bytes" instead of 120.
>
>  include/linux/mm_types.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ec273b06691..c9c3d0307f8c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1026,10 +1026,10 @@ struct mm_struct {
>  					     * counters
>  					     */
>  		/*
> -		 * With some kernel config, the current mmap_lock's offset
> -		 * inside 'mm_struct' is at 0x120, which is very optimal, as
> +		 * Typically the current mmap_lock's offset is 56 bytes from
> +		 * the last cacheline boundary, which is very optimal, as
>  		 * its two hot fields 'count' and 'owner' sit in 2 different
> -		 * cachelines,  and when mmap_lock is highly contended, both
> +		 * cachelines, and when mmap_lock is highly contended, both
>  		 * of the 2 fields will be accessed frequently, current layout
>  		 * will help to reduce cache bouncing.
>  		 *
> --
> 2.34.1
>

