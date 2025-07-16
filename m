Return-Path: <linux-kernel+bounces-732750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68EAB06BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1074A56364A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE527280B;
	Wed, 16 Jul 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MNZYgnQo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EmTBtiYg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B0171C9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633272; cv=fail; b=IzLpxY4DjQfAqF+H54bt9nwZ7dnD0B08YvhgpMXc7JuqUUtoVfEIY1DUXvmBbVQzJzMxWYBDrSrGtn4hnBHMpuyoy6fgAFxmrHz6imP6hkqg7xWiBLbaDXX/BjecH/EEuoG38k9nvXurMCAqVt6+EnBMrbOBonXstVlfFN1PCqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633272; c=relaxed/simple;
	bh=V2JuRd8gYUiQ5DRoX1xv2FYfX6mNICeMEXacrtbRM+w=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=f5TRZ4wfA6UPDuu2+uMzpXcDcwpL5V9+0BeyJ8JY4h0A16oDatMmnjGIwSj+gNAeNM9+L2FlxXjyjlsM+iJSMTCmwOU9PstkNboPauYTG9MIgNrhZZdwYRrMk4a3z8yAmkXhyvrsZZPzAQ3aq733DuCS3oej23aAaj3kJ+FjVsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MNZYgnQo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EmTBtiYg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0giZR016834;
	Wed, 16 Jul 2025 02:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0XD6d0Pzad2NPMqrki
	cociptYCjpcSbTuOE3rSbELAo=; b=MNZYgnQolNGJwrFGJCAZD1vCl8YYWdJio7
	LTl+hrtPKBDFKNIeJVkI/TaoLHzMQhGdWExcK0CtIrFbKFzBKLp8Y+2l6tTHZAps
	5DLFkUHffxMWgMGQYIguM4W/Z3TxBofg7zvXDloV6beW3T5C+16CT/BqWhjwAm/2
	EtvynDn6UBExHNZAtcEGKTX80muUc62nckjmoAccvou8uEvLoGy2MpwTRm24byg0
	G4avijdudgG2LtO/bIDq2lCf5gzQU5XWc2BZfgnoov8qEgv5NxSgp75vwBHtjmDU
	JtaN0lfEh6E3QWhbLYOzbn3KwPtmiiF+3hvli+hJYiwzIT/nViIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0yx5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:34:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0N5gu029568;
	Wed, 16 Jul 2025 02:34:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ardym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3+B+X0TsryhPIXQeFWVerlAwmaZSY2V1r6K6rDqW4DGWryjfwE5JFpUQzJCPzrCGjgCoybQodPlZrqlWoCW5XbFnw+QtuoPS/LmItl3yj+ibeeexCYnEuy+1NsXVYJouyAkQWWZJEqK/JIJA6/BR7xL5YIfdKKBibCw2lyJjshaJ9tJK3RC7xbfTOTcZTEYfwiKH7XKl0/ebfOb6lE5rW64QIGJhqOTAluSXPhA5WEJgZ1ZXVq3/mRSzsGrlauVFSXiOXPHRRTz6vV20X9Aa8QqxMGA051LnBPjjgVSsyS4jLjYPNw6VJyX/v0tcERvqpt39SA/tgApNpuFztXzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XD6d0Pzad2NPMqrkicociptYCjpcSbTuOE3rSbELAo=;
 b=tufKDUogC1QFNqcNp5hLES7tp+vEVmBcgj/ISmC4k3c6VfWbdv8qcreWg3BWh9MVDSKOSf+JSiONwnLrqJJTI1ZPyJYhYJv3QE96bqN+0n0YBCk5u/W+DuxliKThyUIW9FvE1WBKFAK/PiGiKQrA8EWeuM23g3g0ClMU0LY5PTHg1tHhkDv695oy+cCJQCJvh6TftbE/VdCSGOXdJd0+C0W24s1BvWeXpJKBlqt+CKVjrSrVYrCZ5+nSiKzqKPtMF6l5NPQna5/uFKgFShvICeOLFgNau2ii5mcNWPAQaWh8i9Wgtgja79gv2MEBroAnUcHwmymGOy4voqpK0o8EyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XD6d0Pzad2NPMqrkicociptYCjpcSbTuOE3rSbELAo=;
 b=EmTBtiYgI1DiuUG3ov2ypkf+oveMLNoWuCLX+lt2bLoujxu8iTb2A8gRN3uRhlz6I+AOXvT3SAhqFxze7XqTSLpurSo1RBJsSN2A1pELpqIiaKLVHct53cbRq676MFVPyO4YUh21UxNGyQjlWr2o9i9ipcQgp6P9m8zP4saY4/I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM3PR10MB7945.namprd10.prod.outlook.com (2603:10b6:0:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 16 Jul
 2025 02:34:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 02:34:04 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-8-ankur.a.arora@oracle.com>
 <aHa3VgRA8qm8U9my@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 07/14] perf bench mem: Allow chunking on a memory region
In-reply-to: <aHa3VgRA8qm8U9my@google.com>
Date: Tue, 15 Jul 2025 19:34:03 -0700
Message-ID: <87a554kgo4.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM3PR10MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a599e6-d8be-41dc-94d6-08ddc4113b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5QmvP6MuDZ1B0SIWeoUmbSSDMjVMjYGAlXxDcHvPOhLltEHJTgqwJsIhGtc?=
 =?us-ascii?Q?CiugQiNvZ3JYDAlUkvFRcdYJ2UWA0W3YV69Dly70XLioGCGgBgeirfs7QK+/?=
 =?us-ascii?Q?wBVjN6KQeUeyz4wvWdztHYEfdTioGc/nLOwXOOOR95edT9uCDgpkGqxqPbkm?=
 =?us-ascii?Q?LaU3IwzRbF1VUNb4SHi1clFl4wc32EBC/DxfqqKnkV6eDiBMV8RpEEWbPFcD?=
 =?us-ascii?Q?ulUkRLJdBEk3b8N++u8+Q8VP2Xadg+jG9pfuBwkpWQ3bF+1BDcAD9WLc1Dty?=
 =?us-ascii?Q?PdpvETEXP5MqaQUapZ1GtVq6xWahr0IwQhykcFdwrpe6TrL6KmYAOjbQEXBK?=
 =?us-ascii?Q?VFg5PCS1KvAs3Ye80zXAwSyQ52KfP3re1x17anhHazbpJnGsNyLRk607HQFH?=
 =?us-ascii?Q?S1laymITbVlvG0N5cFmlM9B5NBS14Kxu5hOcNJOF130tFLAbuy8BPhvT34Lb?=
 =?us-ascii?Q?qi20sMvZfl0+zypr+pxm+AWEQI6ru0C91/r/OT1vdn0973VUwslgFiRG7Skz?=
 =?us-ascii?Q?+7uvpqPz/l4/gnEEawhO412kAEN5d5Mp1iqQNxjhRe/P3iE+qQZ7OgRDjr0h?=
 =?us-ascii?Q?kYbz8dSI8AaWVKZrTLTZuVCZNq/sUJlRFHVR1t9RJoUTcOSRQXKy/tSXHHxg?=
 =?us-ascii?Q?x3CgYO5+e867FCbNzRYN6zp1UVuMA3YY2/EV6qaRUphov8oqPNNPdor0WzPI?=
 =?us-ascii?Q?nXP/yQf4p2wlseSAGoa5DtRXkzRrL/uAFoRpaiQUEOV8fHpejfoy5ulu0TDx?=
 =?us-ascii?Q?StfHp+KYHWnnL8W8Kzs1nomH+n5GBnguH/9b452vq8U1qGQBt8AORInaLBTM?=
 =?us-ascii?Q?vNvfLhXBFpxdGBi3UpjShiQb2+6GilcE19YXj+I7XqrG0AQRuE5nrg0zazix?=
 =?us-ascii?Q?SETOVwAJ4v5slL5Tqh6qB8N0ecPxDcvKP36HpNEzxa/FZtw6DBzCp/920qbz?=
 =?us-ascii?Q?p2n1Ce1dzPw+4WNS+g3Tf5ZbEaUc7fUvWTtfuVJlw3dgOFe0X1vI68YEDPb0?=
 =?us-ascii?Q?N9oSHQpM+p9xI+kXe1Xb1JcENvrUtc5uS1PXqYatXLnp6+rD2mykTn7FBtXe?=
 =?us-ascii?Q?HkFKP0mUjO54q0bxFpvDU79LnNkqftWzyorNbG7jVtTezbmuYM9xnFz/pPAS?=
 =?us-ascii?Q?lr1886nfcexEn1MSMDERTphwoJP4s75qgJ7ntz/1Ugs+oTDZONy1WahzwSiJ?=
 =?us-ascii?Q?aKmYHISGOenqt/qMa2MWOQuVn3yyYB/BaBul7eQ/SuEskmvHzw2QgKuTQpaK?=
 =?us-ascii?Q?arb52z3s77K4whgMWhnrf22cdEGqxKBULUmknRTbTpNdPNpoM1qnJvWU3iz2?=
 =?us-ascii?Q?Wp/aAPrdTHnHRf8hVOiyG5fWuoDFvCD7pKQufYW+sJh9toL+QpMS1V6KGkTt?=
 =?us-ascii?Q?nDWgN0Q2coKZCl5AXsss9PRQi8HlebqtbVtM8W6rbOTQyn8U1Ev0vDEBG4Qr?=
 =?us-ascii?Q?08jzVsI2oqs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oVvYOj5HwszqAFVTlObQJgdqwv976Ca6ckQvrowQzlhd+Of/1NapBDwSBJqH?=
 =?us-ascii?Q?/6oq9I0PTQ5Jqn+M2TSjBJ/xrs0DePyVzCKvn9B3/z4qJ1slPoW0ZikdbpGL?=
 =?us-ascii?Q?hoi7QanG+87ull+LpBgmM08GtowAvxUHvvZKDpipYv+HIZ/nOfnhDmSTjw4D?=
 =?us-ascii?Q?QUESxks4TcQY8gv8ay/lXuyLEOkREklIa16cU+d5b2jdHD4WwU+/B/HT240f?=
 =?us-ascii?Q?qMrzgSuIqmy4V8wlyx1zGZGhACFwgyBELqwjNSwTa8USuCRB8RaCubejOujM?=
 =?us-ascii?Q?86G0uXSHb1T5vFa5pqD31Xp1BjdQqPfXC38oTso9VrE4ilOnNAOyVt1wXcMT?=
 =?us-ascii?Q?CMUTQXx4STySM+InnHoC4Qt8c+CZ4SSBm3AVaqQZmyuRMpdMFWlzWb/nVitx?=
 =?us-ascii?Q?LJQF/OyEcKK0den1H4CY/2893ZJrTIW9uXqO9zEhFI1Kik5r0rhK+lUOUHEi?=
 =?us-ascii?Q?3JLd9J2EFmnMqpH2rVQY0Ewp6obyYHPOu444etB5Fi6dLpedsTR6g7dasvjm?=
 =?us-ascii?Q?pwhFZSYgsJSUg0yohrZBkb7b+9NfYaCZIh8KVTiyNc2uTmbAITSzVlkAc3PM?=
 =?us-ascii?Q?b9NsLYII5xy+kZqjZNFRkg/rmMVE8LtnJ/Giah/y4f7NNckdKXBLNebaHL6/?=
 =?us-ascii?Q?Ugiq2INC1VIYejfP4p+3etafxVfZirXkY3aY8Kj6fAmy4UFMmM4LDxWRPmr0?=
 =?us-ascii?Q?mnTZXjvmxEgdxD3zFiEgmGTEwRKLTY0+weNpoBBaaktY4wHcfcLFsmJ95H4V?=
 =?us-ascii?Q?LC2bcUrCQduXQUicr8nHAUWcBrrOWC6REmYFDFG+C8dfa9YalU2dnW91c3pI?=
 =?us-ascii?Q?ORpYjdg13EAKgHXFmTpVhZeUkgGa6LjYA1oO8T/dXGtGTEJQcL5nbyGIRPHz?=
 =?us-ascii?Q?bHmRlBVMnWw7LoSXTWWPUrpuB3jnvYrDjAZjJ7uTAAbIy2bpTJpRtsFuSLy/?=
 =?us-ascii?Q?v/G/jBzQiP4uB9HcrNk+kduJGIXsQUxQgTVttdm3x6AGZIGRZL0szt9apTRU?=
 =?us-ascii?Q?SFjRJ3uPFBYNseiRPwzBNQLlpaLNew8eovuLUf1WIZPqs71JldY5aKF2iBda?=
 =?us-ascii?Q?n387PUr+zUCNpyRLhTfSZXvKkyXzkbIwSsBbQ/LTfcebIZ/ZG8OlSFn+XlHO?=
 =?us-ascii?Q?jsXDtYjLKEjfuBu0uvkEB4y7o2yG290FcaoyHwaIewa+48E3tpyT47PuCENq?=
 =?us-ascii?Q?+S1JnZC76c5g+WL69dID247VjCf5BwzPf+vKCxfRN8JJu6Juk1qj+GpPTWLm?=
 =?us-ascii?Q?BKEcxJzW2duMfVQfzBtP7YLHwY2wEfoALHBYjEDoOGFjLxWG3jVdW1KqnqXA?=
 =?us-ascii?Q?GSuTMK81cQeFmBkgQsPKOiDfPmcI9hbZn8OV9jkI+943ieIaZ4h06QE3r05m?=
 =?us-ascii?Q?FewxcjEpKJzYneyYXEQt8kqnUhIfG1qCT7Or0XvOiyUTE3h+ocg80msOp4Xz?=
 =?us-ascii?Q?i1GI7uNkyuxf5+tK2f+V6hDZFvXVB/NgmcR6G+XsSrelHwQnKHq7JEsYqFYE?=
 =?us-ascii?Q?JOc0D3kX2icaj0rU7q/AoS2pGvy9ydtkP0SMIRVtH+BRf0wHodt54y5azl5T?=
 =?us-ascii?Q?J0F/tbKLISQhtoGtme5e+Oh91fDnAKH9ydEVzYR0+B3fNJdQyATs2Jt3K50M?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kYzwHpGUlffZW1tAY1TX56SV39QHZioJ0dWsK0WVxuDGctz62yIjPBrR+xVK5Oachl6tB3DecHQF/YeVrLDfQI9qjFoDNI8uGgZyM1JpFddS9D+3Vz+F3XySPKA84gZLIctJ+bL2jfBnqrvMxnbOFbydFlBs4NfV5UmEKitFeqKS9eL/DHL7anPs/VbcBEjMKot+eXT63dWosJwhgzjPiuiiykExyWJEHGKu/PJFbPGZjS9XLiNyEXAIrp3P4YOOLn5CG3i2F9u/O9EZqRfzVSIV9p0doQd3Aw8idSYe0gy7V0uFhWsvuJfX8g27peapegw8OMzH+s7fqYYAQmf1cEhUuSmghYuVNHOUAcmq8JNJOBcV4tFrnx5aZgQID3LkZm+UieeVkrmmBDr5eRNCq/ck9SrXGp6yadXJ2efztTJR9cph0Q7wmXFjUXXEMADQw5x6nty2ZwESGPz3wspbnqY0RZ+pfRnofFgd9gIcpiop0kyF4AexeIF1uLIUs2MiobBh7+AZpuh0gWYKRb0VCbR4sCUD8WaTEz1nnP2NCNbyu7o03DIaFqmfxxRn89C/BAyNBPNizr6+rK3qfLLhwWF7X9MN0obZ6fB3Xut0G30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a599e6-d8be-41dc-94d6-08ddc4113b3d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:34:04.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfDjUUiPl5YYPyHiFVBOUhZZem3xaVmkThClfCuwegdN8tD3QL1NCu6ULQZWJTR2ByNmXSgOu25JuOwMAsxfP9VjEwNg36klf6nE7BaDSqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507160022
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68770fa0 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=YpS0DtLlw9HE1GZK6yAA:9
X-Proofpoint-ORIG-GUID: gkPqJ2g1jLrHoGzCB8nKpZlHRJmm7MHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyMiBTYWx0ZWRfXx1HRBev2raIv kgZgQAsnrRlYA0AHMxeJ6vjzs5HBO6JEd4lWssrsbP+x++F7AjiNbblcwMWUjuWHbYL8hUBkZY2 moukDi9X/hch2QTF2xkfsO2LoNuUcXOAsefGjgutNfZ35P8ZaaPUa24MVsHhdTdSm6PZRrnmz56
 knFwlIdtbODKCCuJLERtBOKM0dVpcPtr7i+x4YjxknWFdzbByuuwW1FmjRpHLEKSw2pNzvurg9P qgPOHAyoK+Rl5DFLto3ToLQOgcbKGbh3KIoW1NU9hl0rPNG6W7O/wMVC/fVoIL8755gbs4yRu7X 9foklqpfemyayioZQfpLJswElhLte2xVrufDkXmCRuIsWceDncxGpau8VLFJF4rQ2GeBAS7GNjW
 mGrkHbFAnl2L9ljRlBIrCwksRRv4q2CCwJa1rfhD8emLaazyAYlZ6Z9AICKDtCTevgnQXg5k
X-Proofpoint-GUID: gkPqJ2g1jLrHoGzCB8nKpZlHRJmm7MHN


Namhyung Kim <namhyung@kernel.org> writes:

> On Wed, Jul 09, 2025 at 05:59:19PM -0700, Ankur Arora wrote:
>> There can be a significant gap in memset/memcpy performance depending
>> on the size of the region being operated on.
>>
>> With chunk-size=4kb:
>>
>>   $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
>>
>>   $ perf bench mem memset -p 4kb -k 4kb -s 4gb -l 10 -f x86-64-stosq
>>   # Running 'mem/memset' benchmark:
>>   # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
>>   # Copying 4gb bytes ...
>>
>>       13.011655 GB/sec
>>
>> With chunk-size=1gb:
>>
>>   $ echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
>>
>>   $ perf bench mem memset -p 4kb -k 1gb -s 4gb -l 10 -f x86-64-stosq
>>   # Running 'mem/memset' benchmark:
>>   # function 'x86-64-stosq' (movsq-based memset() in arch/x86/lib/memset_64.S)
>>   # Copying 4gb bytes ...
>>
>>       21.936355 GB/sec
>>
>> So, allow the user to specify the chunk-size.
>>
>> The default value is identical to the total size of the region, which
>> preserves current behaviour.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Again, please update the documentation.  With that,
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
Thanks! Will do.

--
ankur

