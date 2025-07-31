Return-Path: <linux-kernel+bounces-752235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60730B172CF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494C31677F4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9492C3244;
	Thu, 31 Jul 2025 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSv1UxVf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kcnO6//c"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A91EB39
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970794; cv=fail; b=ANGJRB53YknE96GIEaktBL4b9yuSJjswBoMysbXV+OXv+MIanTF1oZ3L/KOxMFYgCzCbEtI3ClALEJhcqAgkwwK1n8LTBB3ZIbuak6vUvdIsA9UBMy8iLN3QQ6znU+hMMg/3U41/Gh9xljJdjRL196B9O+S4/M3s1US5ofLaipg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970794; c=relaxed/simple;
	bh=418NaU4ozDQdcM9Pyg2WOEawRBvi8RABzWcz7mWBIYY=;
	h=Message-ID:Date:To:Cc:Subject:From:Content-Type:MIME-Version; b=TMNQNRUGGAuMDex41yso1iGT7yfdR05VspJNiqgBNqcqm+nO+/912e1taBiFSXDtm6Vj4Vqb5ASz/tPWPA67pV7cNxDSv+DiHUM+SVYHH+kx36PcukZ5HuNQV6oDlFelAa5Q6Ad10JxbDnSqzCj0/Oug3KMvpduxl3zeBwuqCRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSv1UxVf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kcnO6//c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDj3j5019382;
	Thu, 31 Jul 2025 14:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vngiP84+KaMqnfwF
	+ljDdN3pkdY5zBO+YLF1pc0XjDM=; b=eSv1UxVfbWAQyjXaE7mzdvs/NiPDNMbs
	sVzIdGw5ORKVUWAkR040Q/0FQSisxBIONXeIt21WQ1xhkWi/s6+4rkuxqUs+9Bzu
	S0EKo8zJ+8WG/kJ2m4k9JDoWDEB2LddKgP3qKJ6h7zpgEkkMObGO+7aWNez5GbfA
	olA4HxaIPSrC/jFcY5UcIKQp1xUtOQQ07KwW+C4eJCsYudgwuhe9ymAAFdYe0Ppa
	RhR386y+sYwelg58G/xoD4wmaz++Xlo5F4EpwzWEATlJ7/OzQMY2U/ZQO9H2Y6wy
	1Il2L/nxf2aD8dtUj56e6Vl0oWtzBl0lEq1wpJG2a5UkaEjlshQVCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ym58u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:06:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDD2ok034459;
	Thu, 31 Jul 2025 14:06:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcrwx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 14:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2JkSzrB9v/LsJwo48CLrLM2gqfOHQyUR1hcuzrI85yQtlot3lt0zi4VrtCb7nuzSJHKlku5dBk8RbYzFqxrzvuy1VOkmzuDOpm/CxTdOeKRQ8etRzGC7RqNK4ary73eHw0SKQpj18u0PEVp/C32JHCaMzTt5VcchZnhFU7E5Jhkes6t66va8I0hdn8Gh6HZ4OTTUmJe5xvStWchgelEB2Vr+ix0ebARFTw6uLVu8cXrnshdGG+T9DKDU7bTvaSz6cFm0Z7vZPVpwpKyT3tUdFmKfTgpeVl7l4mkK+PitPEJM7pplCCDz9BaP7P9jRlHHa5/PgaLobRTHiQgI3QY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vngiP84+KaMqnfwF+ljDdN3pkdY5zBO+YLF1pc0XjDM=;
 b=ZMkpY+9eer5qMz/eFaTV3mSEDr+nRaG3urQZyFLbkmFMHoOZ3XnYHXDZCUsXDJUW+fh3q0Wc93vIHSYE8muFcXMC6hawQ+0qg2zpWB7pBvrOyW3bZ5okbNEZqT+AgiXlH+Hw4fIjmJyo/GfQRSLIcPavtcQlXpwWNCcdbTO1PgxYvAYC+yRybpmFBJ1kB1E3J04GDEfydczh4PSbr2otZisRIfkiP+8UUSmgmomfkhDEOkGL7IZIUfXzMYKi2x7oEzKLh6ZYbycM6NKu/jVDp0II/RE/iZKMyWiUVDjPz35cJvWdweSJ1c7TxajuyRMp6U3qvjV0oFHF1Hb+NAz52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vngiP84+KaMqnfwF+ljDdN3pkdY5zBO+YLF1pc0XjDM=;
 b=kcnO6//cisyQ0graWGT+f8Z02ahkfqVEDzhd8cypjysBDyMC1PLe+3tP2FREIxpn8lPyNfQbWuv+lx3Kye1S7Y/5VJ9v4F1i7hgbIKuBVFO328yb4xxEMpH2pCyxxfzrxzTY4jrsd6i3i0a/qq8QQe6MeXrmK7DqC6UVGv96tbY=
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d) by PH0PR10MB5708.namprd10.prod.outlook.com
 (2603:10b6:510:146::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 14:06:12 +0000
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::731a:2be4:175e:5d0b]) by DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::731a:2be4:175e:5d0b%2]) with mapi id 15.20.8964.026; Thu, 31 Jul 2025
 14:06:12 +0000
Message-ID: <1ab1a9e3-037d-473f-954d-248037f2ec03@oracle.com>
Date: Thu, 31 Jul 2025 09:06:11 -0500
User-Agent: Mozilla Thunderbird
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Subject: [GIT PULL] jfs updates for 6.17
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:610:57::19) To DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF35CFB4DBF:EE_|PH0PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe7e6b7-37ec-4bb9-b15d-08ddd03b6825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTRha2JLMjlnTi9VWFNhUnpJTW9HZHV6Y1JYVTBQY1BYa3A0bHZkOUxTcDl1?=
 =?utf-8?B?WmN5dW5KZ2h2czJ4WENRdjlBSVMvMU80d0p5N3cwQTVmdlQyTk5rMzI5d3pL?=
 =?utf-8?B?OUNuR2wxMmJFTGVLSlJJbVVUQlcvREJ3N0Z5V0Rab3dvUzkvS0lMbVprRkJV?=
 =?utf-8?B?R2gyV1RoQ202a3ZBSmF2TVVFYXF3WHA4K0M4SEVWV2lyUkdPUXV5L2VEMDRL?=
 =?utf-8?B?MStnOU1DZS9ONEhQL2RKRUl1elB2cktkUmk0RnByUW9SaWxRd3E3Y1owZ1BP?=
 =?utf-8?B?SmltZExPTHJIV3FnYWw1Y2xieGljL1lEY2VhWWRYYldVYzZyOFl1QTc2WEZX?=
 =?utf-8?B?cm0wMytmQUhkVFh3VG1rOUNSZzVoLzJyQzljYXlXTFJaa0czd2pkL1VBM0tZ?=
 =?utf-8?B?OC9KeDVObGlhNVQrZkFTZmRLUWNES3dScW5ySXU4OGJRSDd4dmw0SFR1NnRp?=
 =?utf-8?B?S0kwcHVLdDZOM3hiaFo1R3RXbys4UmVjVUJxcDRHSUI3d3d4OVpJWDVnN2gv?=
 =?utf-8?B?Tm92bkRCZXF5M05yUGhhQTlHMGVDeS9jK0k2bU1WMnFFa25EUG9yYi9aZVB1?=
 =?utf-8?B?ZUlQZU8zOVFRRmMwMDNDTjJYbFIwWE1jQTVPY3J6NkF6QlptZE0yY1lrOUNO?=
 =?utf-8?B?Y0s0bkk4LzFjK3BnbVhIZi9nYnhJM1ZIUEtOOStKVElyYUkvT0RFSjB0dGli?=
 =?utf-8?B?elRMR0R2RklidkNjMHl1aGlHS2dDZFJoZWRyMjJ2Z0R3TEE1TlJHMkJrT2pG?=
 =?utf-8?B?Tm5xblplY2pqQ2pNTldLYitrWU5mbzlJTldKNUt4ZzBOVlQwdWp2QVJGUWR5?=
 =?utf-8?B?ZVFTenZDWDVNR3daMkhCUUw1eXZyMUpCSGpqaVdOVTEzUjI4VTJoMnliWGgw?=
 =?utf-8?B?eFZ1aWlVNTh1RkpucXJBYnRaMzJ2NDY1QjFqa3lRUjEzelp5Syt3NG5UZ0Jh?=
 =?utf-8?B?SzFENFVNUU9WNGdNMUYybHk4RldzYUdnL3RxS0phUFN6bWJOWUd5REZ0cUt4?=
 =?utf-8?B?S3pQYWM2c2hDd3A5c2NDRmk1U29pRU44QldzMi9FME5sSHJtOS9HemhkR1VG?=
 =?utf-8?B?RGxZektOY0tKQXN0eERIaHlYajFCZmg5a2hjQ2h4OVNmU2hiQ240R0FmS2M4?=
 =?utf-8?B?NGxVeWZMcW5TOTNieWZpOWtCaktOR2tteForMTNBZ1lMQU13cDJPZS9qaTZu?=
 =?utf-8?B?SGNqU2ZLbHdva1FwTUFxSG5oeU53Tlo2RXVyQlpXZVpGQ08vYkxLdHIzdjhS?=
 =?utf-8?B?VFZMdVYxUG8wYVg1SHdJVGhvNVBpV0I4Sy9VYXI0WFZ6MDh1Y2VxRm5XUmdo?=
 =?utf-8?B?Mk8zMVppUERnLzNMVDQxSU1mbjl5UmhpSk9URWVaK053Tmh0OWl2SlEvOVFE?=
 =?utf-8?B?OFdYa2hPcXA2THBKZ0RXRWxrTnFBbW9mNk5rS2hBWUdSeDFoa3Y4RUhvNTFz?=
 =?utf-8?B?MHc4ZUxIN0JWdWo3ZzBLL0Z6OSswUTg5MDRyOVp2WVg1OEw5YWM2STBaR2Ni?=
 =?utf-8?B?RmQ0NmcrYmVWaVQ0bFhqOVZ5N2N4aFdOSG54eCtmOUVlbzJ0U3RkYUZGajFy?=
 =?utf-8?B?V1cxZkFiOFBnQ3I4bEc0M1oyWEN3ZUU4UVk4SlVIdGxSRFB6QUpRd3dGTmp5?=
 =?utf-8?B?Y2cxVFRxcmNQOHVEMmRJaFF1TUdPOFNmOEtadU5sTng2cTgvdlJMU21xVmhV?=
 =?utf-8?B?UjUxQUhGQ2FZZUJ1cEpRZHNYOU5jT09xVndyenBUT3ZxV2gzYWZSVTJkeUxm?=
 =?utf-8?B?WWNHQlhvU2VpMGdBYmt4dFpvbHc3cUc3RERvQ2x0NFZjNWF3SlhFU2RJa2dT?=
 =?utf-8?B?Zm9GdlU3SjNRWHpZUmN2ekMrUnpoSTgzQU1PdGFVdVh2eTZQUTYrbXRHcDE3?=
 =?utf-8?B?UE5uMnoyN3IxSkxqUkVXMjdsUTF0c2lWZEx2b1VRRHN3NG9WUkNJblRIQ1Vm?=
 =?utf-8?Q?9IZwEL/zx2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF35CFB4DBF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWIzRGxWbHU2dlRvcjVpUjRrNUY2VGREVEF2cllNeUVwSGxvK2RxajU1TUpj?=
 =?utf-8?B?WHdvV0VuNzF6YXFOVFRCQ1orNTVYVnpmRjZxZHBWbUt3ZU9QYTFVL1BXSGJ4?=
 =?utf-8?B?MXVvOUkvSE95Ri9zVTdVazAxcTB1V1RONnZMNFd5a21CeElEa2w3cEdsb0lS?=
 =?utf-8?B?MExKSzlUN3gxa3RheEVnV3kvVVBERm1mYUlicnZuK1ovRmw0M2trSi8yYTNi?=
 =?utf-8?B?SGZlVW1NSWQvWDkvS2JRc2ZVZDdOcS93NHBBK2o3V3pYbW9xV1huaTVaZE90?=
 =?utf-8?B?VVV1Z1VxVVpvU2ZtVFBGcEVYdXVVbU1xNW0ybjFsZnlFdFlRRGh5eDgvaFlI?=
 =?utf-8?B?OGRlVGZjRHZKZmU1K2xYc2t6US9yWXEzcURZK0hyeE5CbmtjS2ozWFYzWjgr?=
 =?utf-8?B?aldta0xhaWhMaHJzYjZRTTZrMjBOVmR3SDNCdUhoMWxLQ1ZXdk1tV3hJaTlz?=
 =?utf-8?B?S2hDMklmWVpTNmgzcnkzT3hPN0NDWVVPZk44S1FTR3gyVEdpbGdNV2t3SURu?=
 =?utf-8?B?Rng4TEpVT3hkN0k0R2VQeFYycGhub2RiQ0xjSklDRW5oc1AreXAwbXBYc0Vu?=
 =?utf-8?B?QWlGOUV2MjJOd3NvU3U0QVpHUXIrS2RteUthME8wTjJibFRsckVQWHkxbGNo?=
 =?utf-8?B?TnoySk8zVUhyWkk5RFViaXhDZk8xYmFlMVc1V1BuaFU2bW95WWlMenVZbUVt?=
 =?utf-8?B?QnprQlVxMk5rYitRdG9lUWc0RWJFTXlKTmRTQVROMnNlV05KNmJpT2Fxb2w2?=
 =?utf-8?B?UUNpcGM1b0p3d1ZTeU9aek53YkgramRhQlR3OGR6SVZUZmcyMWJqOHcyRXB5?=
 =?utf-8?B?aDV5RHB2dmVtSzYwUjV5SWc5KzYxdytzSmtJTnhrb3NwU3liQjFkNTNzUHpu?=
 =?utf-8?B?MTIwUS9UQWNYVXBVN0RySEdlQVdPMUg0OENscFBnVWR1ZC96N1VwbyttcXl2?=
 =?utf-8?B?bXVRMi9yZUJHaDJMdG14MWUrNTM3K091NTkzWU01dC9WMVpJSXBJK2RaSGNa?=
 =?utf-8?B?RjhUWHBOK2VVZVlkQ29wTjk0RXJwN1hPV3JCbUY5TUlNak1ucjRCWmY1Smt2?=
 =?utf-8?B?cVdNUUozV2tmTTVZNG0vb1haQVZ1ZmRkcWdIZEpGVVZBTVJ2U2ZFL01NNGpB?=
 =?utf-8?B?THM0QUN6N3d1SndnRjA2MitYZytVdG9wdnZUZ1U0bWo4RDYzajY5d3A5V2lx?=
 =?utf-8?B?cUc1MGtKenlTOVNib1JDNlNTSVJIZ2ZCMlNTQlFIK1krcHZHand5N2dkTGVa?=
 =?utf-8?B?QUQyc3J3dzVEQzFHaG5ObU9MbndrSTB6SlNiVUFpZDNwd2N4ZUdNUGNYT1JL?=
 =?utf-8?B?QWtGS3lkbHM3dUx1aFBUYmJUMTR1U3BtNmtxTmFnTitCK3dzczJoN2FScS9h?=
 =?utf-8?B?U0IrcmF3RjNnK3Eyejg4Q2NxNUVuNFhsOHVUWXB2NnhPNExwK0diL0x3Y1Np?=
 =?utf-8?B?dHpNL2R2TUMrRTQwSnZGcWxlZEUya1d0TDM0K24yWlU3aFdBSkgwalVhN2pE?=
 =?utf-8?B?SGkySFg3Rzl6dnRIQVBidTBFd1EwTjlZdlNMY0MxVVVKL1NoN1p4dk5kUGpU?=
 =?utf-8?B?NkR6aXI3azlBQ0ducFhEcUlZRjVUb3RUbWUrS3k2WXp6ZmdJR0poYTZJZmpQ?=
 =?utf-8?B?aWxISENNcG9wRDdvUWhTM1hpM0krVHFrK1NtMEM2YUVEdmo2VmQvNi80cVFp?=
 =?utf-8?B?Mk5PVk0rZTA1YjBuOUM1dGJFZGgxVERKdUV3dHpLd2pqR2dUcFVGY3hiOVYw?=
 =?utf-8?B?SWRuWHM3SkFpcms4aU5JMVBHS1NFLzMyTEJvK2JzOXRHV0VueFpaMUhxNUo3?=
 =?utf-8?B?K253aklPRmJ0MUU4NUFtQ05oOFZOcFBxbUFVRUdLWHIxQ1BrL2RkejVvWlh3?=
 =?utf-8?B?bHY3VmptMm9OM3AvTDd2R210YWhDdGJhMVhRMW1JankzUUpBMjFDMkdldUFI?=
 =?utf-8?B?ZDJlbTlMQ3lVcVhmb2hBb052TXNLTWVHWVRYRDV1UW9rQVJGdXArejc0Wmdj?=
 =?utf-8?B?bXFjTC9VUU9lNlZqZGhJcUt1Z0RkTC9qZ3ozWWdkcUdNM2NBVjMrNjEzM2Nm?=
 =?utf-8?B?ajdaZTN4VytlZi9ZR283dmFFK3dZZEg1NnlpR1ZNdW1RUFlES2xqMWEyRkNz?=
 =?utf-8?B?N3NzZDVCaFVLc2F3NFQ3d3JFU0g4eCs2WityZjBEYkx1V040TnY5SEdHTHBC?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7UofNGIQDbmeoyjB7xKOa1565HR9XISK/eD3qIbHlbwA2014bU+4HmyVncRoWk8V9tOso8W1UZc+gNtKEWsYdGie69bKS2DE/+pgHkRe2KArdwg9OtBfRKG7s5t4RnAs7DF1bKTaCVSA/DdvGJFWYqR4yjmH716XrK+nlXQZjKAMqeOX9WSlgl7/ENPV7t0QuQg43bueUHzl/CA2U4n2In0g2YRNJQnaVqBVQcumkGGDgmxShG76K2RhQWW2BRKOo2mlAMUjQYon9sHMI75zHcUf7XW4f1rGPejkuST5aPoQnnTDE0NgGJu5YUmu0aP5Iv+PZCI9VK1RgWgf6tb4M4krVdLCoguIMhKqK3jIXI9C2mX8ag45xWfG/qyR73Q5WskY/9Fro0/RSTVoD0u6RgYRszyni3jLLbOto5jcKhiBvuKQHFmsoUHNDryTQVZvOpvp2IXTLzEsKDM0fejy/huPdze9kNtBA08hcsz9Jdl4mYVUTMzaHaIAFRrHZNDF02AhPB4GFeiMmlPWZi1TYvQNk9X8ABSz8LjXSNThcbPQ+freSgYL8IOgSGdv+AnKxTyIdAAFKf3nDfvs7dzGSBTAZCMC97iKJTBrgtW6KVs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe7e6b7-37ec-4bb9-b15d-08ddd03b6825
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF35CFB4DBF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:06:12.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKZlGi9wbyRn9n8Sh0jUdVWfE59QmYghsuUzMrZxHoMohXPjKKvUgDrlM258bM+hhUkoQs5/ncMAb/hxHE2MyKCrhetmIoiXojmtjYf4TXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310097
X-Proofpoint-GUID: lGLFvmpo6H7JvNXlTtdULVA8RFUs8UTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA5NyBTYWx0ZWRfX87WOi6/RUHx+
 pryUc7vryOKSsj23DYrvFwWWvIdDyd5dQ8Xb/FZdHrr7QyJM+/qPzzIMsUpsAkg0OUA8TUM2zNo
 KytIw5QWUEEBvD6nFOe1Wiyh56v1TfaPbjeyyywrwO/8vPL84CVWYw13TqSOJbG5AdVQ9hs/BKO
 IdqzXXV8RIo4uQ7ucPyUUAAG2QzszfVJKTzKkNbQyXwfUY62M+opSrjD3xzitY9Jrp46Mn01Qlw
 5WFT5rw9btHw0BsMEITLtJuqDXubyUv6J5umUUngLm08p051Js5XE4ZBxTQhqZ+0ccQAuugxOuR
 rT0VVJ+ebiFM43jF9/hBjMlNLpKGKTFTDSa7MY9sAKVGQIz6AdAab3m08poc+nXozj2w95HzMaK
 gJ3LKNa7IISA4W/g5y3dunlMaImFOycECLFIf4TDTbFy4WKRlDSeacCmO0iq0Irio3lzaDVi
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688b7858 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=BVwiC7BH80hj85-zOQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lGLFvmpo6H7JvNXlTtdULVA8RFUs8UTl

The following changes since commit bc9ff192a6c940d9a26e21a0a82f2667067aaf5f:

   Merge tag 'net-6.16-rc6' of 
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-10 
09:18:53 -0700)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.17

for you to fetch changes up to 856db37592021e9155384094e331e2d4589f28b1:

   jfs: fix metapage reference count leak in dbAllocCtl (2025-07-29 
08:34:57 -0500)

----------------------------------------------------------------
Fixes and cleanups for JFS filesystem

----------------------------------------------------------------
Arnaud Lecomte (1):
       jfs: upper bound check of tree index in dbAllocAG

Christoph Hellwig (1):
       jfs: stop using write_cache_pages

Edward Adam Davis (1):
       jfs: Regular file corruption check

Lizhi Xu (1):
       jfs: truncate good inode pages when hard link is 0

Suchit Karunakaran (1):
       jfs: jfs_xtree: replace XT_GETPAGE macro with xt_getpage()

Zheng Yu (1):
       jfs: fix metapage reference count leak in dbAllocCtl

  fs/jfs/file.c         |   3 ++
  fs/jfs/inode.c        |   2 +-
  fs/jfs/jfs_dmap.c     |  10 +++-
  fs/jfs/jfs_metapage.c |   8 +--
  fs/jfs/jfs_xtree.c    | 142 
+++++++++++++++++++++++++++-----------------------
  5 files changed, 96 insertions(+), 69 deletions(-)

