Return-Path: <linux-kernel+bounces-730021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C436EB03F47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F20189EF0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DBD248F60;
	Mon, 14 Jul 2025 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hxW6Pqer";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ornwciao"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1C2512EE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498511; cv=fail; b=UYBbscz0nnVGizY2N04IyWTTI00Phdlde1H6GaTq2YW+6W7aNUJ5FfA7PLeoukNfLZuO+4dmRMPpsmtB03I49OJKLRZqjekRbZixpBbyCHv7VVcKoCrK4Me+EO983GFyq/K+OlOGz+l5/NO7bVzO1mkRdCBO8SLO1rg4ymD9pEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498511; c=relaxed/simple;
	bh=b6Iq+eL9ADFrY8qx8PVukJIsL/2+UrEstQmT3zLlqtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSAfPEgy56nrGXJsVThIJUlAhUIZJki+01sPuBa5kxJx96P3wAW52x5UmOeNv7ZU+xb8Q/RjjLODqyaWCWCRJwZPl67AoZ1pa9gOKWW8aXcjTmbWePd8FE5QUH8L8gB1A/KylOVt+AZqWyCGgzgsyRssNmTS801aAjcN+lCKsuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hxW6Pqer; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ornwciao; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5IP018801;
	Mon, 14 Jul 2025 13:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lC4w1sIGHw3mTNOtNRJOZr3Rn0BiysgxIcmQcAPzuH0=; b=
	hxW6PqerXMl7Jxxu42wgzX7qhPxmGPbkFJW5rub6149vCE0nIcr5+QVAFbtMCqRd
	TDHf+VB/Ac8ta2c71nMDNpM17Fg4s8t+3xbXsDrKQzjUfe+tVT9r6+djl1cfZ2Gt
	OaobY5jobGDTQmHZKcDNY9TD6juzpvSjG7redt/jV0bNizMpa2kDpe9yUQHptOyz
	bavqUmWv0Esp52PmATUY95mjtpY7WAikBwaWvnU3g5X9EUhJp3pxKp6/WT5pxo76
	DQEHausrC6ErF6nIMJvTV+XaUaBkuu2Xmo8UzcgFLsAwT+10vJ0KL/gxJ3NYhNQE
	ZfNcgi7h3uWRAqmE0i/zbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqmuny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EC7sod030319;
	Mon, 14 Jul 2025 13:08:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58h900-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAr///xWOT29pTr6/jNh4aoInF7XHIFrNNrCB3PB/qBcdPrZhMUOdXbbsPDNxsyXF3zikNPI2TEcGCYf8APjtqBApyDZSE/PPZTN3AIvksLrfoO7X4uG1iyV1XUVjMbYICGjyE3gTTrslUvAwHrKdNMiTc+z2zBiaS+LU4BuTgy+XUDyqUEG7F2c96sZSDJ0bj6YGkJAgXPN7sBm2A760Y9yNfB0sBEToI4N07XdkKrLxJx1bDTEZ075dkc76AcRXTJmf/LtzvU+7Z0HFv2TnJmBdcPQpwHKh45uhoMWhoWwubjHNLY8rzQsFgSO+ppkdRbHsadfyhctfwUYbTWAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC4w1sIGHw3mTNOtNRJOZr3Rn0BiysgxIcmQcAPzuH0=;
 b=qfhmChiTH/1RGMLR8SsQ24z8pq3qtAvOFiN8Q9rDUyajB01vQvLq5wOhmLGLvlG0dJ9XyrblM6eEujxBcE+gVdp3cLO1mXqSnLaMis8otyz/IcB6Fb26zjRiHcdhDcJfH1FbdexGFMhb+W5VWtBvYIY7y0s9aAsAMG7XwrD++TgZ0OAYIemPgZxIDBt4U73gSWXhYNqyMBwLodfNthhHRkbTQkXM8Vqaq949AGinP7DRhqdf6TnXz1jfSRMCUDoKa+thxkrsUNGGHr8XgUy1ePr4ioPU6UmscWXNmthL+QPpkFcbUF6JP1WxBBkUsX7vGd18hLHsmfSbinkE05Wf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC4w1sIGHw3mTNOtNRJOZr3Rn0BiysgxIcmQcAPzuH0=;
 b=ornwciaooLPARhj43M0iR0tWDq+NJAwIKUMByqLS86fue/IJnZrKceNrOQShG1uqSfVEtUlHwseyzCeW098YRh0+YGNGbJbPy6dAs1t0dWkiwTuJY49ZzOHdEGot+cwLAJNT86fLExj+D8yEN0avWTgTIIt8l01rWyZBkcQXAFY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF1F3678C2B.namprd10.prod.outlook.com (2603:10b6:518:1::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 13:08:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:08:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH 1/5] mm/mseal: always define VM_SEALED
Date: Mon, 14 Jul 2025 14:00:36 +0100
Message-ID: <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0234.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF1F3678C2B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e53242e-ab89-4a61-2632-08ddc2d77c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HcDRt75/5cJGFK6Fkqu6xgz+8GmsUtQ1edQKh38zi4mNTIYVWLt/vNRM7WH0?=
 =?us-ascii?Q?18S2SGcCD18VAfoKmIopS4d3x1AexQwA+YEhsTrCf41wOhGUiiDxz7hc+tKX?=
 =?us-ascii?Q?lZXJTf4sHua+3OYrcxhK5pnGkK4wddG5LKT/Cn3uNc04zaIiP+48QSI1HbhB?=
 =?us-ascii?Q?MKYPKp8B94S28jbr8vWT5c+G7CyHLybzjz5THJE854dTWFc1lJvwkg1Khzbu?=
 =?us-ascii?Q?jUfnfPlmGxJ9GX9g3VJ3M3K7fqpeL6pCOOcs2xxq4B0VaaKIx4FKPuUw87+K?=
 =?us-ascii?Q?TpE7ExJmd/DRYRV/NqNgLaUuEQFIjFgy8ZBU0HtEeIstExP3QWW8bATaoN3k?=
 =?us-ascii?Q?nEjfM2vp1FWG66wg661UjlUlb2YUqDkt9curQSSD27RwiEbSNY6LIC+YXnL9?=
 =?us-ascii?Q?WyBXV1FMxdYqWnGCkDQTBcYeL2hh63gg+Y/dp+nHND+6JlpGBw8QjyNRnsuA?=
 =?us-ascii?Q?M4n7Rj48QXqFwZc5vNOGOLSoYSsan3JfW6TfwuUk17fC9Pz16qaVBLi6ZIcM?=
 =?us-ascii?Q?GNODtS5tFOCLsXhKgrLT8D4jMy4erPXvIetAkcaaDJXInDn5nGpQI9AUqG6Y?=
 =?us-ascii?Q?ZmGiTT1U7erXlHasmRawqMtYbo7MoS42f578zlaU2U3waMKNMeZtQ+YIE6fW?=
 =?us-ascii?Q?oQwUiCXd2mwhDKbVqM8sNrnwy1FEFQ8VaMukAUv86DJM4u/EM8i8ix0BlCmR?=
 =?us-ascii?Q?z7yyiV9Oa5YPDOKTfbODRorAByrByst+wEk1iseQia8KM1/1S0pwHr2KlPUi?=
 =?us-ascii?Q?nRRI/M/tySEG6Xa0EJCSoVo3vd6AF/CuGIb49ES1M/VkHiLNBIn7N3HioI9M?=
 =?us-ascii?Q?0XBV18kat3aVmweyLWb2sh1Kc4jGT6kBN8o2J5qTZqNV0We+MSLr8K/F8tZD?=
 =?us-ascii?Q?/z+AfPSN4P+yP3QlAloSZqw8c/qgpQMzFSZyqxoKFeikt9mcrE3ZyqzxDeen?=
 =?us-ascii?Q?deLQi670LjyQLKHjw+gxxtdrMYjZ1wMESRiUpig/Xv+HxR9pOhxFubVcy45L?=
 =?us-ascii?Q?SsEmf9tX1G9PDtBkiesEpA2Y/GxdbTH9nKerD2fOh4nu8nfmac9oFKUV6Iz8?=
 =?us-ascii?Q?nRRBbOqdQ+iEEkBzo3Vlgwq5uVJCMQ9Mn+rfBSLdr6Inu9h1CS5Z2Q4JPaJC?=
 =?us-ascii?Q?FgWKROUr+UqB4ckw2DGNcRSCXHB7gScse7xe/6s7Oy1ZVXaLGSjqd3Ezsd9k?=
 =?us-ascii?Q?/k6ZB8LcX9n1+lPTWgZEe+pTHRX57/McmbuaaEOwZenXMzdjhWGrXP7dMUAL?=
 =?us-ascii?Q?83jM8tBJX1Gn4P6yyorrJ7tvicSzDpPI15t7oCPU/XEVySKe7jhLJwAMRnrr?=
 =?us-ascii?Q?eQEU3dswtuo77HPl4MuNP+q3q65gGkAL7F1RbBQc/uqtaxpPPvUa9Ar6S/3V?=
 =?us-ascii?Q?31LFZTNFkPNXB8Z28fD4XHuX4dDOmY1P0CXDDELYi6OINHJRLoMcgYFckZCV?=
 =?us-ascii?Q?E1AzFB1RXKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ApMzU8wQPJvro0X9wyugnIoU32ROfOhZmzMXsXlmlsgZuLNqpswV/pmV+kh7?=
 =?us-ascii?Q?yPgLMKINYUCsor1gIIUrd35PzV31z9cRLhFhfXWmrSFMZCAe3Oiy+65Qkxr+?=
 =?us-ascii?Q?8Caqr60/BHAdt00LFdt0r7GMpVrsWe4mCvh0Daq6a0OUXC7COQ5gf2QeM/Ht?=
 =?us-ascii?Q?7ENLANU1yw+JjA/XX5+/m9qNc1E23X0rwIKKlwVbFpeH1qEaDcdtq66uVSXk?=
 =?us-ascii?Q?vnFLpoWhYZTr8c5rfTRVZ3Z8eT1dIzUvWV74k0tCANVE/ioIwkHMF1fTnchJ?=
 =?us-ascii?Q?FSZ2w4VEDxk+Pw+Dm4LxOehetjKtT5EIYM4UmNRky6221VmBtLWUN750Ib1W?=
 =?us-ascii?Q?9Ajfej9Qs+uw7+VnhtWt6m0x+/1QonvnsX5pMj1+CiiY2tYDE0ziu/RjHGZw?=
 =?us-ascii?Q?iytj6Q/E4TNDQqXw4AW0DFn5dXdVthEa/Vxt6cLPPRpixHtHoUX0gOmXGKTh?=
 =?us-ascii?Q?YveKnWJNyYs6viVMUdyTUGAidK4t6wbYaBvCGNmvHtan6qp9AyCVXBGHlgV+?=
 =?us-ascii?Q?A8w+CmC0xlHfu513V3wK+0SIzaCvhK1Z3xCJD5+iWuJK7T/5jSidW/XKeK29?=
 =?us-ascii?Q?lsPjd6Fsu1ibjwgarJT0KFqDLJ5xuerwoC9mDFUQQis0bUCWkGOvgejCpfyf?=
 =?us-ascii?Q?6MPG905A30UODi2sLbma+PgGBUapJtaIEDjYxmgejW3LwlKC1PUqnxn9RQtE?=
 =?us-ascii?Q?w04VB3vvWrbXa67Hy6XohGw0wOdt3YoknWsgP2lJ9QBVNiIFlT8i34alVVmI?=
 =?us-ascii?Q?1ZzrBqc+Ll0He5QyaDBiaACRBUVvTxhSOXASx998lDrSnxiP+zuBcsCMPl8l?=
 =?us-ascii?Q?fbVhHsi4+51QtWWIEcumM0jHlWUnr/6ez9OzrrgkG1Y77/1ZM/deaXi9O0yE?=
 =?us-ascii?Q?ndasrM43doaaf5YpbOfgKvW+lLjrgPiGivBgx3+xi0lCOuRQWZ27aQ2CkRq6?=
 =?us-ascii?Q?maLkMC2w0bcNT9cil8rcaR2omO+mFKzrc0hEs4WpGg1oSFhvqJcU0NCufgYZ?=
 =?us-ascii?Q?ojaForsO25JJJpMo0dGQdht0sqEiC6TI0lHZrpMdzDm4ARMu23LkXUTpbELJ?=
 =?us-ascii?Q?x8JtBeR61HKj1pxj8DzYba4u10OBmPm4PbhFIBOlgCeDjUp4Jda1QJtl88Lq?=
 =?us-ascii?Q?h43qgJ0eIQ6hxAqOx3bKpOUIrHS4iD13SA5/vI9+q86ez+S3J1m2uXohV6c0?=
 =?us-ascii?Q?entVZ2CS6HDEsomjjuYXBuWfYB4uMC8SJ0apH4BrOVwInX08SxJpRx8NIEex?=
 =?us-ascii?Q?hxSx2/fPeDt8GSCpdUPyrG3nOPP2GBosaPVjnua3i7PuBS61aqfT/KUhIq7H?=
 =?us-ascii?Q?2tLEbbsM9I50lf0b1ykpEtWbWZIjzWY6mCEPrnvwXhkxNZGxJCRf4d416t4u?=
 =?us-ascii?Q?UxvQtXZ84mm/Rld3hMSdOpPcq/jloeLRQJJ8XCvGUlOnngp8YENyDQsCB8Af?=
 =?us-ascii?Q?gbjAnhQzBzW57Fv0WVIOwmSVBRCvxjFPMsEmQQaGUxe1v4uV61X9ubR2Ed8B?=
 =?us-ascii?Q?+2dx4ax25959VxnY1TRXt8uzF5jLZn98JIjQyeOqKhgJbrQLYMZ18QG8K4fG?=
 =?us-ascii?Q?X4SSuXvSCJ1shA8JNIWdS49OndaFLDVfKRJX46RzwL0EaR5xYrc6gH2CozRv?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8QXAgQtIfzkXT95hggj+6iW5Y0qcoylnWF2uzpUMaJy09fXS9k+wyy2PQ20h3kBDgur7C09eLnXlD4seU3khNp9zCoyouuN8Uw8quCxDMDMgw6/Nb2tu+ewjdKPlUxwSBon7eGV/kISXpOAeB0lRFn78OrseeM/457cK2AHlea7T6soLc+awcFoZxxjSEnAaLBqOVVgjXnolrCbgD35U6LsnbA6KVmc4PLId7rjNyE2AVQV/fmFpSndw1YG9pabWbPyVs65N28xmeeCsI1eupa+pCcDcupeFCt+N+CP04CpjMLlaua7GkVmqOykaWPSXSk/oivHBOOtocQXPXgOG8mGHidUmYLZAEo+cM3iY4c/hfpfi5rMNqHuVnjkmPaCzB4Ek93UP8968tumXILO2uLe2HppHPKVJMHYyzr6Rv9STVwoztnspMmUQrWuYje3An6bzDh6LdeSsudFz7+69O+79f1dswqFUgV6CPYjNz4cswQb9/p7FHcWANw3/0bdSJZ+4yKj5ArNtdGzNCtM4aouI02+9Zpzm3qvKUwCY/kWYXu1I4aG3CZhSQ8dU1fFJgL6JqTg2kpol3W/UWIKVWF5FQyibU33H+V7wxa513j8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e53242e-ab89-4a61-2632-08ddc2d77c23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:08:11.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSLAbnHUBPl7nbky8X5T33ti27Nli9Jb+3U3OMXoFwoVVEgHE0JZBqj/VwyPdbKt8udKRKFQ8hNa7npqLLiDfyWpLzHKrpeTLB+ozzs9M10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1F3678C2B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507140077
X-Proofpoint-GUID: 67U9wBozwe58evCaSX5xHs0jiHlsNvmZ
X-Proofpoint-ORIG-GUID: 67U9wBozwe58evCaSX5xHs0jiHlsNvmZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3NyBTYWx0ZWRfX+Upxs5dj/BPH +iXpZJPIs+9OEWB4uD4SzfYwoKrGbXxTWqfo6jscf4SA5rcZz7hnLYLGZsIUPrQ460PJteIeO4Z HRJtCtKLyDljBSHm31OrG8zMU4ljfvRVTPA39P1PZ3iGPY8CenlW9TpQeGwyYksadcfBh/Zy85q
 SmCWutezlMrLFF32h+qJ2KGmEBVUORQ4F5IMTXBgJhnKWcLlZIx7dn/JGpAHTtcXUlPDFPtgeh9 E5fRJJZD1yBQwfqNcKvafDUHseoNR1i96ENNOY4mGeKUALBz4k2mF9oQyPmE70P4ff2VKQ9Ge/U tvLb5uDM2tv3z6gMlTc/NRISc7/vkjKi2Pp5+9u/4bFru7VkaEU1+M2zGWVnFatuKczlimtnX0J
 WvqKAGSJb0MT8UH1kn+ImCtdRIWnJjgoZKszjzNZePRfzwjeQbHt7znnqmpnqt8Q3w/mk7Pt
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=6875013f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gxeMIzJwE0WXKCnSo1kA:9

There is no reason to treat VM_SEALED in a special way, in each other case
in which a VMA flag is unavailable due to configuration, we simply assign
that flag to VM_NONE, make VM_SEALED consistent with all other VMA flags in
this respect.

Additionally, use the next available bit for VM_SEALED, 42, rather than
arbitrarily putting it at 63 and update the declaration to match all other
VMA flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 6 ++++--
 tools/testing/vma/vma_internal.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2e5459d43267..aba67c3df42b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -414,8 +414,10 @@ extern unsigned int kobjsize(const void *objp);
 #endif

 #ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED_BIT	42
+#define VM_SEALED	BIT(VM_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
 #endif

 /* Bits set in the VMA until the stack is in its final location */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 991022e9e0d3..0fe52fd6782b 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -108,8 +108,10 @@ extern unsigned long dac_mmap_min_addr;
 #define CAP_IPC_LOCK         14

 #ifdef CONFIG_64BIT
-/* VM is sealed, in vm_flags */
-#define VM_SEALED	_BITUL(63)
+#define VM_SEALED_BIT	42
+#define VM_SEALED	BIT(VM_SEALED_BIT)
+#else
+#define VM_SEALED	VM_NONE
 #endif

 #define FIRST_USER_ADDRESS	0UL
--
2.50.1

