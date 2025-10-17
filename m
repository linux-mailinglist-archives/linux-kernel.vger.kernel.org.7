Return-Path: <linux-kernel+bounces-857123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59BBE5FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 290ED501592
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFD244698;
	Fri, 17 Oct 2025 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RIAV29A/";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="S9a3dLJE"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3223D7C7;
	Fri, 17 Oct 2025 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661577; cv=fail; b=jsbk/gUMgnHJo9O0QFPbx9x546CAcZRbnKSiKuvsjQvyQSXt6/aQmyNhVVd3tveWTAWCnnuCqK+4vNaiuKKzRILiiQLj5Eub2sNVkVoM9z4Zgpq6Wv6x3EXZYyJFm7lfxGunnvfhztOfw7FSYJwdU/w+VOSLfQeFiOTrcy89I4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661577; c=relaxed/simple;
	bh=LOgRPxBMq1HPcl+FDsv9zWE4m65EHc9lbd+Zy8jTEx0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KwTNU3+oWtJstx7QlajNmOFJ3r1kiHP4mY62N+86DXzbtzHHI9KULXtOOiwwXyRcfTd9DHMevzAWM8MP8xY1k9TydFSeUmlveImzuUWZpwEcYIzDdbuzJPUmvuodhZ49tT/vCqV+VSLXdpM4CgCbenjx7YFotLKAxvTYU511JIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=RIAV29A/; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=S9a3dLJE; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GFpjpU4182223;
	Thu, 16 Oct 2025 17:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=rnSMS3/tPzdF7
	BhyDT5f3e6JI1KtBMyCSgRKz3FWGHA=; b=RIAV29A/6JJZkuiTUPqzeyFMGxX5q
	aL72t/zQ8B2/N8PXlfVMbAmdiIWzbK4dB95i5XWW3Z6oWj6GzYE6qJVJMZb5v2gC
	qdEoT19IWCtLbuD0w2lXbzINLZmWLTvPvPdeqB3QVPfjkLU9osFfee2ZUVy0I21z
	iLz3eJm+h0U5IniJnGYFZcNs0Hsz4RK6RxC6w5+4MFJs1PNZy86i52s1XWeWJqvT
	dxnkBby9h7pBF/uqanUrxyyTJ7rK5f/oGS9l+/86yLjyx6Qi87oFPOBMeiuWocGK
	XDfDU2+314gGOUPYL7L9NPN+cUNjjFT2O5dMM/1zQgP9Rf7l0gh0ilheQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023115.outbound.protection.outlook.com [40.93.196.115])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49u3qk955r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 17:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c11JjNMa+sqwpHzHqLPP2tKR/JgdX6srNiW3ln5igLBJrirtIM+lB7MvjLHBR96HySb43P98Q7f/kivMCRQvSWADYMoDADYd3+fEu2HH1QLweLpaFAe0A5YkyLGvPZj8jim5bbiCPXDFdA4wNv4aPzALq1E9XhGyGRw9PuBE+w2ww8vMrptdL1ivAi1BQ0jHbl7PZTJlgQkf6vElXXSFBhh9YFePfrcz0B6Sl78ccH5ur/64urJA+OVv1IGDByEWmdu6ACrND0WnGlOAElru7W6HZk3htHmPfdcbTPIIS37Ug7t5a4W+RhGqxirQWsaX57LgcwGNdUyN9zzYrlNYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnSMS3/tPzdF7BhyDT5f3e6JI1KtBMyCSgRKz3FWGHA=;
 b=EpkHmI/yl53BlOVnuHLBcM26FDJFJRX5Xa9rtLkweQdchJ38LXVHDIgO7YJSZata1e/iE/iXk49n8Ukcc8YBnZohpBYQBnRCCCS9km2tAufBW0xWDDVGKeK/dYfSumxNbJ8arpZ2T/do/FHHbzrV9tOWdY7r3Rq+jTeQeGj0r+uC345466twIV2De7gwmNrPuDJmTKlSH1+PQ6RvH4FdclqcvgjVQ2fG5WgGG1bzPoiXRDxCFCgpSSKAiAV8/e7fDTZOtGv40cRQMzI4shYE4I4d9yhAJ1XvKTyCExRhCLxgBpSf2hfoUfOjkkaFFrw1EerTRYEDP6cLvA7FY+wEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnSMS3/tPzdF7BhyDT5f3e6JI1KtBMyCSgRKz3FWGHA=;
 b=S9a3dLJEAaMfLZpAU9j5CGezotd1Ro6LRGUYG/rWGPae7b14hER5hV+LmFRrEZ1G3l3mpZyyk6YJK5mwvivfBwsywhj5WApT1ma6AcE+GQPKrbsGTZCGLvW6GY8hYBo97fE91bQgSyarpEr3jHTDOpjxxb3bRnh7xNB9TkRpgSuHwrNiIOc7w+16jzhMDZ1qvG//JGNEv4GDjykk4JxNQFRRn5tHYyMZn8J6XhX3TSN1C3AeQLLiqzs+3UBEvjjGXHarVM4ltItDaqq9Ud9To1SQNUuxFREE5qKLO7pbCmQbr8MOW7SjieqsnkI6nT+Zj45afLZ1TOoDVpIWUsqX4g==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CO1PR02MB8602.namprd02.prod.outlook.com
 (2603:10b6:303:15d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 00:38:36 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 00:38:35 +0000
From: Jon Kohler <jon@nutanix.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH v2] x86/its: use Sapphire Rapids+ feature to opt out
Date: Thu, 16 Oct 2025 18:18:30 -0700
Message-ID: <20251017011834.2941358-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::24) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|CO1PR02MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: acf2dbfc-9d31-48cd-b607-08de0d1581cc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99FavnMJhXrSD5g83jdY0fwHR18Fk87pHiqfyoLIBoCns5QrWmo1u0i4NgCN?=
 =?us-ascii?Q?7LRgsfgM0LdwUWP7p0sYVe7pbRlRU7vIaqVRj+NWRkmvJGsxQjuehmBDcz5d?=
 =?us-ascii?Q?l/sW1OgGOk0zGgaKjy0iNRuTZKHgTjJoOljYPcPICHj5ju3CEOxB0kQtggSU?=
 =?us-ascii?Q?BLEDQQxq2Q5ytlwR11/dNeFyMqRmtFFic49O8S0iEhcyJ/nZbx+i/OBiIrRZ?=
 =?us-ascii?Q?aGYpivUNtxJrYJFOPD+cRokyf72YVvWRgX6hkcQGlkaUd2UkJw8aQa2zYYJf?=
 =?us-ascii?Q?8ULeOZ8p9t/LkIDTBofyyNTywdsXjich5CmsiCkRLhdT0A3c012Ptd8xjC4F?=
 =?us-ascii?Q?ulx2N5Wtnj/6RKFDgcF/pzG/yptxL+Or238jz6igNXZ9GzAsj4L7uxl3OBkq?=
 =?us-ascii?Q?HSwruXhbHHfVxpXMraAiIVt4YAVNw07lj2OIEVzmG8grrCHDgjGnzBggtJWu?=
 =?us-ascii?Q?UzTVji1LI7wwBgl0Bgd3C4Dc3IyckDDpX0TXGFlBuXJC2LvhygKIGAdCf2Qw?=
 =?us-ascii?Q?iFkPeF8o6fPibw+/aCnZsRnjbvASFC6Pcq+a945hwzoO2FM7p5wpDBuLzq5L?=
 =?us-ascii?Q?xhFc5BmMFIjG+1jQrsHlK0ivt5b3BgkpLLGedB4w2glWhK/mE1Ahzvulct1s?=
 =?us-ascii?Q?xG8O2Q6eriywayRh1MpQMkh80fFzxsfNpPzHLRqc7bLBTLV6AkXW522L50So?=
 =?us-ascii?Q?XqqhW2P1+FScgDVGhFdCwaWhsQQ7SSBc4etaBX2LWF+HOOvCV4PfYqXPRkbd?=
 =?us-ascii?Q?/apwv69mXplGlPsW7FpgEYPWVJXg0aYKvlTmmC3+5hbuqctBkCWJNg7qtWNE?=
 =?us-ascii?Q?qIwcLZDlmwqAl8ThC4ArmP2r3ksumaYFY0Imh9McdwNbF+v6/ByzVqH0k03h?=
 =?us-ascii?Q?wSCxwfyQ9jdhIaM+ei9Ucx+kHiFyqDe9LhS/JQhiBmWddgvWdQbu5wR+x8CN?=
 =?us-ascii?Q?Q9aU3KItzFD+lSfH1lhPLoIH3/eUJoUA72efs4FR8xva5zEfv7pVp9eq8ruX?=
 =?us-ascii?Q?SHveIYLxMUn5IPorVjh30XOVu0RZuULViZEP+ym+aUshmrlvfOJf7F6BZwTA?=
 =?us-ascii?Q?B3oNNHB7ALA/kBexL9+WMe5DcR05XlfqL286Ffi24ZPVTDoSwffujSO+ZZKd?=
 =?us-ascii?Q?LoJFHhoby71j9VC/y1AHTmUfwCjKYMZJVi9Af7cdcDQ6w5t2+e+/zjoDvC2g?=
 =?us-ascii?Q?O7vYmOQgViaAHfiS+dMbBvecRvHsyUBETMtJd1/wduW9qVyTqnk0NI4cDQxH?=
 =?us-ascii?Q?F4toYbOBekqSfdJWyZlrIcMJJlkorZd2tbtCUgpaB09Ksm9xqPebyywUKpT+?=
 =?us-ascii?Q?Lr/exs7bSoYi3EoRrmLL8TkD7NPN21yyqWMIOjQ5Fy0qOwU+FGrOqGqk/mpn?=
 =?us-ascii?Q?Ye8cEFhq2pq+z1aRL+chehzBWrL8BPeTLc/TfXkT/oro7RQdVWK+K7+I7fp5?=
 =?us-ascii?Q?aZEVebiMIaShXxVK8O5d578LYbe2hpD/LHdRKDfHtDWmIVyF9034chvLXnog?=
 =?us-ascii?Q?APHKP7WD2HmLujnXRaIZ9Nx34GfN0jahy3STUf++J1jckn4x462gpGxxjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FS4Ooz4rs5QxeeRzjO12xeuI+YTFKIHcmxp+bpSBIETT33FN+WrvO1ZGGdg4?=
 =?us-ascii?Q?2XQZhm8EelO+fEt6J6AN4lnCf3CUNUn9VrHBXDoUts6U9xg7vCGxBhAiUcr8?=
 =?us-ascii?Q?mzph9ztDRv0nGovOLhDjoP2TWX0DHmaFN1+h8bTPcoAaaXTaABi+71eMPnK9?=
 =?us-ascii?Q?7szneCcXwT+Jg1yPJv2hyGC6X8XumUHJiY3drdgIA86t4DXH5onmQ1+K3bDL?=
 =?us-ascii?Q?O4vKcuRJe+U5I9QtFYHKeTcxSW1qPQNojeSB27wJyU9is+xM2bYrsD+/heC2?=
 =?us-ascii?Q?Z6a4YPZd2BbVRSp36GWTUIwYsC+kqzWQHqE7aeDQBorxYx/H6s9tN2FyvzSE?=
 =?us-ascii?Q?4TvxNsKtBkFzpECrQ+OC20In9yeXST92V8BnWXTUnTNkUneidKIbjSxfwT+d?=
 =?us-ascii?Q?oJ7mkUnKuwMBnG62V7y/3N81nB2jai5yz6bB7RlGGmHe7QFHU00SukX0fDIs?=
 =?us-ascii?Q?5Kdvd7a+7SgAHTSv47AN2ybSq9x0aSPzlRjy7OT12mdevwTOj3IADyupnSIp?=
 =?us-ascii?Q?wje99iVdhVdSC9nhHi8TTs6BHAqzF2uCLcAn2uXxkVOQem8y23OupVyMyt+E?=
 =?us-ascii?Q?mW5CwZu8lz5tQnNBqcXP3G6dvtsc6QXfy8vPIiR6TjUOgNIxnrZRzW11N3f6?=
 =?us-ascii?Q?sjFrWSlU5HM+qOTmzybTlhc6uXwussoNtQaFmFhyQUAscvRLxwsTE07n8h/j?=
 =?us-ascii?Q?Y5uR11DJKKbO+r1+ZPCXN9ax8If+6ybTaE6lPjhiJ+Edc8F3O4MZditbT7Uj?=
 =?us-ascii?Q?YwonyXpiFZMNuIe6TbfNiE4uQqaKsgz/iGOfV2pEqZJWlX6wjaJpuVyN9lVi?=
 =?us-ascii?Q?i/yviSKUfWE7FXIBaZZCb8vsI6ZS0RHD9BQ+dFj4WbnqGx3iTgsA50LNZUrF?=
 =?us-ascii?Q?1Yth5pyEhE01JVdOcVAXFds+wOcdfHMmNymz7wXhwxA9LgQif41tLO8Yj0DR?=
 =?us-ascii?Q?SpOaueSwg+zHBrAWim3ZiRc+qFXqNIiYK9sDWKyE4aY13AZ+Otp2jGCKwGMj?=
 =?us-ascii?Q?UrVhxjWgDENbE5RvfUPGjYd4yOrXgV5tfqRsvBqnY0ML7U/nzBvDDBZaFyYl?=
 =?us-ascii?Q?AU3ximPgwEh+7iCjPsbUfsmkDX9BwjZhuv0qyQeanhB3Yk/PbERycFOpQkqH?=
 =?us-ascii?Q?2qxgvf0vPahNtaLzhviVVcwYXmAVd1TLYlbiZs/zQJ4VaxKfT73++BwOSJ1I?=
 =?us-ascii?Q?c/U6WZwFqJMhQNLKevuZC/uWCLnCNlXfRU9hBVSt/G5UKMItFUPUdflN1iDG?=
 =?us-ascii?Q?d5NaSHm73/JntHKcipLWFUuFTwJ1S8JdIVdtpWju26oPm98Sl3sbaiOwf/Eb?=
 =?us-ascii?Q?1cINLzBDVFX4iIaZlDEGRI5dGBjKmxUlCX+tmPiOxTTNKEC6335zqnbbDOxL?=
 =?us-ascii?Q?cKCp0GB8rQkaL/0l3SguUpChCkjOE+FzNWdaOqWeXm/JURvUrM0LNslK9bm4?=
 =?us-ascii?Q?4TAGYSJtV38t6eYtyrUcKgMM+X+qk4PRiaylyONSUmveHznSrZ34KU88gwc+?=
 =?us-ascii?Q?04MhZqB3EPbFxD+eK1BG4ZThGR3/RF4IDBisFVvaFt3t0+pZqlwwn33nxMPP?=
 =?us-ascii?Q?mErUseDw6AvVNKX8qeBM7zpN38dML3Q10g68o/n6jksc5XikllD6JoKqoZjH?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf2dbfc-9d31-48cd-b607-08de0d1581cc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 00:38:35.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EFyjroAuJZ0PPUxpERMe0rLBbFQkJtb7jn3CTLbslkoXBsMFxEu6+9kwJLXqr8fXmNwlRN/I1rpZBgz0TZCFRwy9OmYu0OniLgf+PiXVK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8602
X-Proofpoint-ORIG-GUID: jUNGWQ7rS2pvI5xqtQDbfCrTFv36PLCr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDAwMiBTYWx0ZWRfX7JbeQF3jaSKT
 AyHZ8uheOo4ahbarjgG1I7sFTBWHQRaW1PnPQh70thBd6rPVuIEpreSxDubtCN8Q3/IKkJYzepU
 npWGrhwhWfHODMfDJxjL5cGio/HOyQk7Gha3ijFMc5JKpOyBdzH2c3hKCq57KIchX3nZDDQ1Bry
 xT2aS1x2ZWyY6+/nKLxbLzxk5dXw5XNOVbhoD8lmW6IcGjc1IZf7G8hn2EaxniCP3g07nZlt5B6
 EIaLbkcZNiaUAHkHwYY2rrkp0i0YzopHeQwMWJAvZiWBjro+YG0hQYOOCXf1aezRCr/vNgfMZtg
 t0kZ5dsbEWOZDdlaByfWYIbUVTLMQBXn26h7RQevkIAHdu/OKs94au4beMSJJwTR94KVp+KSlo3
 20aFPLpbYGFzRW7EtHJT2LK7f7Parw==
X-Proofpoint-GUID: jUNGWQ7rS2pvI5xqtQDbfCrTFv36PLCr
X-Authority-Analysis: v=2.4 cv=Zqzg6t7G c=1 sm=1 tr=0 ts=68f1900e cx=c_pps
 a=Xf/sOfNuiYS70hS914xU5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8
 a=sHQuVjOH8-NXzyl9kj0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

A VMM may not expose ITS_NO or BHI_CTL, so guests cannot rely on those
bits to determine whether they might be migrated to ITS-affected
hardware. Rather than depending on a control that may be absent, detect
ITS-unaffected hosts via a CPU feature that is exclusive to Sapphire
Rapids and newer processors.

Use X86_FEATURE_BUS_LOCK_DETECT as the canary: it is present on
Sapphire Rapids+ parts and provides a reliable indicator that the guest
won't be moved to ITS-affected hardware. This avoids false negatives
caused by VMMs that omit ITS_NO or BHI_CTL. For example, QEMU added
bhi-ctrl only in v9.2.0 [1], well after adding the Sapphire Rapids
model in v8.0.0 [2].

[1] 10eaf9c0fb7 ("target/i386: Add more features enumerated by CPUID.7.2.EDX")
[2] 7eb061b06e9 ("i386: Add new CPU model SapphireRapids")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Fixes: 159013a7ca18 ("x86/its: Enumerate Indirect Target Selection (ITS) bug")
Signed-off-by: Jon Kohler <jon@nutanix.com>

---
v1->v2: Fix logic typo and checkpatch warning for Fixes line.

 .../admin-guide/hw-vuln/indirect-target-selection.rst       | 5 +++--
 arch/x86/kernel/cpu/common.c                                | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
index d9ca64108d23..3cfe4b9f9bd0 100644
--- a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
+++ b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
@@ -98,8 +98,9 @@ Mitigation in guests
 ^^^^^^^^^^^^^^^^^^^^
 All guests deploy ITS mitigation by default, irrespective of eIBRS enumeration
 and Family/Model of the guest. This is because eIBRS feature could be hidden
-from a guest. One exception to this is when a guest enumerates BHI_DIS_S, which
-indicates that the guest is running on an unaffected host.
+from a guest. One exception to this is when a guest enumerates BHI_DIS_S or
+BUS_LOCK_DETECT, either of which indicates that the guest is running on an
+unaffected host and would not be migratable to an affected host.
 
 To prevent guests from unnecessarily deploying the mitigation on unaffected
 platforms, Intel has defined ITS_NO bit(62) in MSR IA32_ARCH_CAPABILITIES. When
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..60fbfeba92e9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1361,9 +1361,11 @@ static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
 	/*
 	 * If a VMM did not expose ITS_NO, assume that a guest could
 	 * be running on a vulnerable hardware or may migrate to such
-	 * hardware.
+	 * hardware, except in the situation where the guest is presented
+	 * with a feature that only exists in non-vulnerable hardware.
 	 */
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR) &&
+	    !boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return true;
 
 	if (cpu_matches(cpu_vuln_blacklist, ITS))
-- 
2.43.0


