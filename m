Return-Path: <linux-kernel+bounces-808424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC13B4FF96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19E11C24B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E52B31B133;
	Tue,  9 Sep 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="izuThLZ3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OoDF/0+4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165A343202;
	Tue,  9 Sep 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428545; cv=fail; b=m18PYIgl7lRgW1xsSwYdFb5Oh72FU75NlERoPpfCikikPw4VjJH9uIuRqCRnDt519sPGbNdCdZ6Hpx4CIu89j4l2wRX7kRBnHBS+9Q5kYRY2/frgpBG1yDSa72jLQ+d4geIVeYFBMcv+P8W1Tkn82nX+zpti1MngesLFoEKlmvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428545; c=relaxed/simple;
	bh=E670+1zzPbR0GZnJC3UuHW3uWlbBWERXmh9r/hkmI90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GSAYOeiNfXBp7e7Q/ugA5CnlQwiJabXts3Fpl/VKvzAyQIbA6SKtvRA6blv8g39WIUt3YrcKEohtc/XPDSFqaGysfhxvHEmPIaxottP9jirP4Ru0TN1FlVUFsRqwQe06/v5EDJFDdfLBP/tJ8Ozal2pfLh8Ad/tprudH0Gd6o9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=izuThLZ3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OoDF/0+4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPJaQ032265;
	Tue, 9 Sep 2025 14:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=5QzhZrs61Yjaapimx3
	kZo7j7+GP2TLfFk7gjyrYi87M=; b=izuThLZ3bOO1hIU+n0kOVaw7KlxywuHB9V
	B+cB8JYF7XyDdyRhNWxIHMdKFqGTn7Cp3vwf9xNHIH/AtFNAFjGfqOS8aKS7QuKi
	zcoJFJpYUgg9uDV+9OM1Y1o9ygHvI6tk+dhLkxRmWuZA6WkicjKCMy/aDlDGtL9w
	AkqkSno5s9hmxK/PHcVGgDIODK1WEtd+K40XofDNz98eixI9rUghdWhaQiUyl1wx
	205jtxWLLJQHzqQ0sC3k4CQeNlBO/rfGdf3x2IpdZVAQcSU08CLhx+7p7sKpVxTu
	1A5Y//ma8tGHc++4YabIquA2Gz4DV/ekiYaf9omYF/4g210r874w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pea5va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:35:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589EUggo026344;
	Tue, 9 Sep 2025 14:35:21 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9qbvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:35:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwWDYJB6eSZAMkjAq6/3GrUFwUUsRH1+DfQrdc/7IAUY8mrrpsGFyJ1/Gt//IrTdK0SzyAKfsFgqxq4uebauiuXIs9r6ItO17RXClhZRBBdFfChc4urOCWtA0+A/QXiRLRzIzmyh/2vZMhyfphKWuWPnB59NbOwzeuBrenUEMqTnw5pX0x+pI+t+xiTX4EsvhhgvgrTomEPVWiVWjXjzG+Z1YnjyBn1sa4qaQjjqI320p23pEt75uY1nhS/epxtYvKt7IpV6TeEJL4MbuDUWr+l+bn9LLBU6jAThR67fs8goEIiB7LinEuwU8I8GhzMTndmvPH44D1eOYRqL2JYKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QzhZrs61Yjaapimx3kZo7j7+GP2TLfFk7gjyrYi87M=;
 b=EMIEAL1Mw9YIAYOJ9eT/ks4cui+eyiFjvWqa/lb0fj0JUCQyvnMoWlxbTH/qyT+L7BY0VtVd1x3yh2uBUETeAs2IYMfomM7i6Bg2WbiLggsonXvIymeTyhVyLmrdyszYpMU2cEMK1q64Tj9qQVMopSrOnfPMaGuCFcmFw9B8gCkZqi6kd9MOjeG8WLrLeE4gMylx9+y6IRjfMKQMyJFdeKwGDTSTvilMKKvzLe6UF/oWyhxK7w1dmxJrYLqGryr9lqD8JwI31VTaFgaHUg5WZkh4vf+E4tATpLSiObu5ICJGLvsh5iqlcwa+WbpaZLKJLhcASRjmyXvIrACC7DkBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QzhZrs61Yjaapimx3kZo7j7+GP2TLfFk7gjyrYi87M=;
 b=OoDF/0+4Rz17dVGVYoSP/+nX4dR3HA3CaWRd7tQ0z5vqC0fGrO8mPHmP5UMEXvpL+10R23lGiu+UaxK0Ng9E4AIphJWh4F9sRyIk8LpEFqQb3ZwRZ23HkUDfnYsAK6Hls7bnMKrXQ/VMtzHG/v4xXhwInVch1nKV+Az9fimd7a0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA0PR10MB6794.namprd10.prod.outlook.com (2603:10b6:208:43a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:35:18 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:35:18 +0000
Date: Tue, 9 Sep 2025 10:35:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v7 04/21] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <772oyaa3j27tlklhpo6oqxsdtlvsg5goh2opzuig6xvgztgum4@scsoxrgtqm2f>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, maple-tree@lists.infradead.org
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
 <20250903-slub-percpu-caches-v7-4-71c114cdefef@suse.cz>
 <aL7FFpIMmXtzzSL1@pc638.lan>
 <6f8274da-a010-4bb3-b3d6-690481b5ace0@suse.cz>
 <aL_uhPtztx7Ef0T2@pc636>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL_uhPtztx7Ef0T2@pc636>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA0PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: a0541492-1147-47f2-6576-08ddefae194b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vcbhoHyvYcXhD9aegoTgWtz/TVF41JIj0JUof5Dn4CWCqDZRorxKS0qw8DKu?=
 =?us-ascii?Q?C4r7WQGfPWhGPM73Q2Y2XV+Tc+XqxUUhpdoRatzXGB+g8YqOV5daE92qPlW3?=
 =?us-ascii?Q?nhKqrjSdiPNzliw9QkJZBNXOaLoiNbnvSzvjye84+dHAW2ldQkHAk+QgNGHf?=
 =?us-ascii?Q?B/ms6LQJrIddfoG5ZTS1+QHY3Do/4jWAzBfpHdcrpH3otGzTaDCwvX5ATihC?=
 =?us-ascii?Q?eXyiXB6afezhER2DhBaeLZCfbwHnYT/rf3yOalw4z/qBikIi5qcoTWJCdCvZ?=
 =?us-ascii?Q?MGbSWMBnrAg23RVLML2oC3wzi5AJIrv9+TuiYW7xoBeFnd6Y8npxLOtz9EDJ?=
 =?us-ascii?Q?dIBae4/cPmBYmMWZfE0VWo39j9YOtcIeJ/Y3IAX0APocyqVt5oy9nroqRwK7?=
 =?us-ascii?Q?AQjUw5Vnuu0xqG6CT/L41z6UH9quDQoOfMIMfs8Mc9dkEp8W+Mcz81H8DyIi?=
 =?us-ascii?Q?7agagbwVstQGoqeMf5gCiJ5Vuk3eqRyZYpZMG/XMQmRsJHdRLmEe4MI93vtR?=
 =?us-ascii?Q?1iybp+dy0HtSiF1OGZVKexFPK8tL3ySYhAZ74/Uh5OrTzZPZ6ouCs6sFiNmb?=
 =?us-ascii?Q?PV7IgbY7qSytI/cJOA3Apns+aLFYFimstwMIRPPE7wkLWeGETnn2UBPTesxC?=
 =?us-ascii?Q?ipc92g1pwA2DxKDGIWBLnJBZTjXM4+k5hLochusBzohYy7zJiJcKkh2tr51Q?=
 =?us-ascii?Q?rZV672VOyjQ5IrkpI1ThJyZCJNwMBYlxAMKe35E2/5y+6AR7IWgAHXwwBfcw?=
 =?us-ascii?Q?UFYiRkJNHzVLA8MvDgGkeHHClzST61O0TzjLA2jcCIqRR4Qd5I4GdKH4YvyT?=
 =?us-ascii?Q?YuGvkkMFVxYv7o1b38GY5wP2vdXwL0UyIocVqeRpQ+jCPIX+MLFyiGErWt+k?=
 =?us-ascii?Q?3KKL3Bm/atPVXLYGpHjsF4EPedaifQjhrQPBDvRioQwsQMj6N63iJ+jmVA20?=
 =?us-ascii?Q?rT9KEPXJMKIxlYCPoADliRnadOJhBU/U6xW6pm2aeqny05U3hILi6g0F4ssK?=
 =?us-ascii?Q?1s2/+Iwve6vo3mQbxzN5wM5mtyR9g1uF3/Bbpvtabbg5QWxhsRMc8BzXRjW6?=
 =?us-ascii?Q?bKqyU0+2gibgcFMDhCA0oAXdRj3LaRMqEkSUuoHvweRtAPOQ2MIbkn9ed8RE?=
 =?us-ascii?Q?s5ZLRCfB4k0+dNLq5MxhYVpfzz6gTIRvnu9EDf7EhnOuDplgKVq4kgf/rhH9?=
 =?us-ascii?Q?fukRecFSZKLKl80yOBgV4CBYDn7Yss6yn9PBvsEaMGyGEaxaXidHmKbE7Wpg?=
 =?us-ascii?Q?Yy0tlT3+cY6t8JBqye3V//Y0ltIK70RMatGNOx7IWnMyhmj9HWn9AwdoUSl/?=
 =?us-ascii?Q?AUwDsepxlscobZ+qNSlGsc0Ml0SbYzZUeGlvFo8E9sqHfqBC1R/ZfhzzGEz9?=
 =?us-ascii?Q?l0j7wlfR4PCldS/rgDFqH9M8h/cOxT1K9qHajJMbYAbG8T4hQNQpI5YhQChb?=
 =?us-ascii?Q?igKys3bicqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqdpBc0UqaKLYpatn0BIqh2q+3aRpI0/VksoOtzEYxTKVBpcZ9xjtsCqUnKN?=
 =?us-ascii?Q?pvaMFC3GRsKCyAU2KU9H3szuWdLdTiUC9ykI13nvafsLIDyhOnaLURMHI3pV?=
 =?us-ascii?Q?ckyjYQnxFI+qy0gBCqCEVOzGNvzptD5/5KFkW3W9Bx/KnP5dYekXwZx+5E6r?=
 =?us-ascii?Q?uGm6LlfE+BRq9MGtTR/DL0BNFkjYXcL1SazloEKI5gbxhWEiEmSytCl9wx1a?=
 =?us-ascii?Q?8hwGRKfZpk3WSo8p0YWTcVAnEED0auGD+1L+n21MICS3R/pUuB9bdNWyir9y?=
 =?us-ascii?Q?1Mf298ehuc0+uebbQ9TZMsFtizGOg0jjPDXIwvs9neRiOkxvNZRQ6CWdNk9J?=
 =?us-ascii?Q?IiJ/Rv1sUIrWkuMGBtfsupgkb+6PosGrGRQyF4/bK3Hu8FutyF4D71RBzYmu?=
 =?us-ascii?Q?uMd9wza2MbQ3XFIBFZBJen+6+qNI584Np80Cf/AWYHhNE7VovDQ6u6sHS6IF?=
 =?us-ascii?Q?7zNyZtI2l07h2Lg1BF7Nh9auv7ggbcIk43jFYqeRvPDk08LQOjpTJ9wUjLwt?=
 =?us-ascii?Q?sA18pVlgKyEwrqhacnizdljSRMgi9f3810M+Dohy6+MGGlP5rjb9MBCt7DXR?=
 =?us-ascii?Q?BG2EVmfjVOs52Ax8JgIQ/hmA3hiOiIXzVoKGjSZwrPwB74YaqmwGLZz5Y1Ly?=
 =?us-ascii?Q?crvKSGvg5Gkw39VXHjqq8cYiskNMn3PTQuLNu8CTMgGy6vLzrB/Z2YDcrDwt?=
 =?us-ascii?Q?BTqpPCgoZHKTfmGvEHqKQGiIgp/ozwY0MuKL4FAIpZ6ioAaTvH4Sf9V3m8WM?=
 =?us-ascii?Q?MG6KS1j6aAhjTQ8Zf1CWdcAtmP/FvSl72ksPlD2QuedSKzg9mkcFNKwx4SL8?=
 =?us-ascii?Q?CY3AuLbltrgJx9cdmq4PjsFDRIwBpaDxk2bF3NjmHvOiNv7+CcAFvtz6omYS?=
 =?us-ascii?Q?idvA9/qbRkUSzUSJMceNVnDqCrxpMOGj9BwXjpsdcANfzMet5xNWWY7KjkMF?=
 =?us-ascii?Q?gpRHcCKaraoWXPI794bsIu1XoBcBG5BzGAArQUHtlJ2SD2cO+slgn3cVE0yN?=
 =?us-ascii?Q?hvegy5aG5Lv23OHMlKmLW+DX+Rf9ti1hlQJqbIwi67hj2s4+hzUyFwyg9+Kj?=
 =?us-ascii?Q?7So/iypOkMHjUFfjcF5Yqmj2yS7B2/e40W4HioT/3n1i2Do4ZtUd3amUMeqY?=
 =?us-ascii?Q?MTsBc+XK0NK6glyZrpNfrVMY/UFe4AGDqW/kdzbS0qy3cOx3a42EDCNqooUs?=
 =?us-ascii?Q?dd2F4ZJ58Cg+RwYuvC183utTCFYBS2HxMY1IIqaXFwpCFlUzk73cWvGwr1ZD?=
 =?us-ascii?Q?ObhsJ+68kijzb9Fb+/p5z+1vXq0JKby1KUjJidQAPIJ4YT6e9a7BYo/fM/Y/?=
 =?us-ascii?Q?x1AWMGYSPKhybswGy6KNFmmBS00oXW+VuTuzSHsf95u+VCKgSDLfDFhm6ez3?=
 =?us-ascii?Q?iBza9AeBCWQ9OFYta5RTT5IUErqySrViIOVbynTp/f/4lW6Esh6Cd082m7/F?=
 =?us-ascii?Q?E/iuxSGbTvN8EH0M8MxutGKdfhRkheB2A2ezTj/ECa9DvW3MgocGMi6f7Vni?=
 =?us-ascii?Q?4zXr0xaF4P+eiqx+ARiuFW2V2vKUKZYQzuYFZWmK2YGvkpoJy/GhQbGf/qZs?=
 =?us-ascii?Q?KUy7IZdyHavWi6mjEVCGiXgNM2coDUfWmxPHP9YO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TEk5brnrLjeR5zc95jgVXDf2i0kixby2XNbdscMJMffn4dEm5/XgQai3Sm6SYlThI+iz9O44wJNx4pnE1phl2vBKBhErDphZCLtsW34maTIGAPLrRAc9jfFFXlSc8ZrRh5lo0frKvWuLW1dgzJLpnV5i9ZK9C3Gjo4PEuGzTlQThEHrvu49DXb097FVVixwOprG7xhp3y/dzmzcZnC3jLeIf8jt5KkptOYCX00Vp8fSN4WBgKO/sO0trsYpwmKiJCcsHqPIc4XaS+3TH/MTckZX2dkAzAN8r49ZSaC4YFoOON+C4kOK6bsKykHeoTexevSz/BIvqeHjCRtqvZmwX/bj6hF5Dd0cMqQW6BL8b3MHQpz5BtAPfbU3QeD1ZkPhAogjroZ45ymLggYuaOdi18qJ9e08c3bM4svMQB/N4eXSlAPj6cj8UgGRi4yFFrYDv8F0kCZ29ZmPb9+OcgFaUDXHj5SwfGIwiPnsbVTUIvR6eX6uHZDKPPLcsZfKZ18IyBFLteSbEbAL6ZQv7QiNbcQ3Q1bHfI5Xb996xQNmsmcMJ8urb2WWtqaH3YinlXCBZWss9AAigtArHde/RmhA5c/f2wa0YpEwV9kAvHhSXZEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0541492-1147-47f2-6576-08ddefae194b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:35:18.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOJf9fUaG+lT0bJeUNpol3Te62JG+1UAxh/q4HLU/MaH38mGzWgVINcL/vrvljaBzcl6u4j93WBVx8QJ7CQs0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090143
X-Proofpoint-GUID: Mzq7kFuapaTiyvAqPy-1wuKYoHhm6Aoc
X-Proofpoint-ORIG-GUID: Mzq7kFuapaTiyvAqPy-1wuKYoHhm6Aoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX3VCg0TZa8e1D
 CvG1rQMhhiktAsUXNR2FdhZxLlci/rA/PcRDJhdpUoZlri6bBYc6uM6QqrgqowghQoBPZe9eEqg
 KHcxxQIuxDgT0zxQCJrKCixvr/jUjigr5Hm107WS7sMDeED9duI1LOu18r0vnpCgtsQ/hFCHgjC
 BLzZfXn9b90W9EOhCDXYLfDlQHDzQRNPoUHjD4BhUS4B/hSYe63OcxaGiJNbyStc8yGFbQFNIlL
 OXrs6S9EmA4AmGngMiAq0TwRbcUrRYbC5kiVUKJF1AX1ugNAP+iXoGCByyF5YCI11iScEk1xSdP
 CdnB39Ap2roNI4ULamj1UY+BoytcRb0iMwA8RclJxLoKQ9F0VDHusT0i4gr8eViimGaM/Q6HpxA
 sMNcST6la+WV17TAbxUaPxFP5SFwyA==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c03b2b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=Xjvi5qJJJCqeoi8Lpx0A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614

* Uladzislau Rezki <urezki@gmail.com> [250909 05:08]:

...

> 
> > > - call_rcu() can be slow, therefore we do not use it in the kvfree_rcu().
> > 
> > If call_rcu() is called once per 32 kfree_rcu() filling up the rcu sheaf, is
> > it still too slow?
> >
> You do not know where in a queue this callback lands, in the beginning,
> in the end, etc. It is part of generic list which is processed one by
> one. It can contain thousands of callbacks.

How does this differ from kvfree_rcu()?

Surely if you have enough calls to kvfree_rcu(), you will end up with a
large list of frees before the end of a grace period?  Our placement in
the freeing order would still be dependent on what else is using the
infrastructure in the same grace period, right?

How is kvfree_rcu() affected by rcu callback offloading to a specific
cpu and rcu expedite?  Often these two features come into play for
certain workloads which are of concern to us.

> 
> If performance is not needed then it is not an issue. But in
> kvfree_rcu() we do not use it, because of we want to offload
> fast.

Today, I free things using call_rcu() and a custom callback so I would
think stacking 32 together would make the list shorter, but latency
would increase by waiting until there are 32.

If we wanted to flush the kvfree_rcu() list, is it done in the same way
as the call_rcu() list, or is there a better way?

Thanks,
Liam


