Return-Path: <linux-kernel+bounces-749939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2009B15532
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE35A18A20ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC03283C9F;
	Tue, 29 Jul 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SHEVJovx";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MEdV2wUJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RF7/OlG1"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4E22DA0B;
	Tue, 29 Jul 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827573; cv=fail; b=hE+Z7EMS4WTgjPERSxBH64YV2uj4EFnFSkKaTIJIl90MnwF6n1PIqXbLNX7IzJJDXE8OHtZHQwH55PeYhDRVCXxdrxqr4eRlfKJOLIqEW3sSOq714EcM6KYElkO3MDk6BVy18EXSEXxTZoybSt3VsSkNIkbi+QVyjMRYVaIOPr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827573; c=relaxed/simple;
	bh=A4JLOVhfUZCCmQB1TFrUl/7MpUZHaWFd/L8qLxeoQLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kiXxs13Lt1cmy+COUqSsuMno9AZQPgKuMJ2QnHMN17ypBGxSE6H5Ngo5cmbKL5/cox11SZA9/WG4awUnOmajDAJLCkvY9Dd8axwsEBBnO+BugZ2mUwF0Qoiax7MZffGzQfFERnpHI9rmh6phx0hp77Ayyb15pGTWMpUFHlzYNw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SHEVJovx; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MEdV2wUJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RF7/OlG1 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TI4mRN000622;
	Tue, 29 Jul 2025 15:19:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=A4JLOVhfUZCCmQB1TFrUl/7MpUZHaWFd/L8qLxeoQLU=; b=
	SHEVJovxGokyM1Rs/HpTM+4YWpFA0AIyR6xkAU8Rqc8O3deb9CAxEST09N1OXZvC
	VKhc10eTZzeVdE81cS6og0nU0GmpS5swwjm40M6XdTz3NqrwGJ4wdHcVs5BrA+Oi
	eoS1tcq/EdPHdNx4tBthxUn3cE56f9ZbXeHkmcfxFe0KVNoBo5Bb5X3evUN8zjwt
	BW1zjh89rl3lDNO6N0eY8CU2TFc+/dY3DdJ//hylGPr5LJPx1+IumG1NgwoQQrXJ
	wRfvAuuhTUx7sSrMSYTiDzHl1eC/j7vtQTXqGosreRc2715qlNo5Z2VqV7jJUsoy
	WiattM1TBL5keGJAHzdavQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 484wxu6cw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1753827557; bh=A4JLOVhfUZCCmQB1TFrUl/7MpUZHaWFd/L8qLxeoQLU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MEdV2wUJ+9tY9DL5zkRFpj0hJw1cdnBmWHXJzMoEH8wQi0xj82k5xGO/3exmABXdf
	 Z/vQ3nVUr8bVJJkQXHYuU7aiA3WzlKpiiG3Mqhz/waYlvk0lD1PkVsiU7e1lu5zFod
	 4GSHNECnCLwOlq2KTPdtUDkY1XjEoYOgEJj6iB5HPVNjgAySLz7Ri/2yad9CDo8eB0
	 Ov8trkxaMbyCcj5EHleRtzSphO/jSkCpo4Mf8fLlcNTdQY96Fv1FzfJ7la+/BQ2jHB
	 LNf3vNuLy0PFoOW8bDm+vkk1i5bXAfBqJZ7s20HK8DW7Ive5sEmughD6qHeE7G9w8r
	 A1q29qWfO30+A==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B730B40408;
	Tue, 29 Jul 2025 22:19:17 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 926A9A0068;
	Tue, 29 Jul 2025 22:19:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RF7/OlG1;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0C5FC4028D;
	Tue, 29 Jul 2025 22:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGjEBYbWiwsfH3OpG+vrTUZOpkB8mnJRItFxpSUjNxUY03QGW1WDY9rgVUOT4U73CMp1tCzafeJp4wdFCQUbBDI7FihMZXydKKw+yWkb5ckNitquiaYm1CvFdJgCYew53dA/cNsQLnkGwl/UpOECYXWZAyhYYiswKq8CbFXtzWjJeEy7UR7QYsOLcKLUS095PEVmMIfbQOcxqV1RWUCDsKl7QPBKEhbqwBhrvebpsdxu5P6V7KJE09kfe0VXtfvjkpFMov69HgCk4kVjjzWCX7Y2ASu+6dB7Ch6eySKAvimrzig7QH3YXqY92pHjA4s/DPJhji800lBiTcU0DYtJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4JLOVhfUZCCmQB1TFrUl/7MpUZHaWFd/L8qLxeoQLU=;
 b=hNbzOPEabg7PvyRFSE3zppjfBNGmIxK5+5PSLzQCrXKUmj+j8tArq9xvrRTsk7s8a9j4VxEsi8Nspl5BgZmvT2ZkAveO0P71JpfL/WSbPHGK5iwPeUzsNS9jk5Hht87PKuxLRtbz7Nmz0dStZXiO5AvhNpz82OQIPxlh7+YNh75x6E8h3I7SGvJQGiVydsubiURZeSqZAB1kHfXfp3p6bVYbMn2uLzfd6nBZViktepuWZvfuwve5w+/gfHlDEtvlpxz5ZiNCdYXPY+l3SFq72j/4SrdKibcE27ullGhXRCicOesGhmXwAzyzn6+13a7VyMLROC/fAUSGupiJmj4Twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4JLOVhfUZCCmQB1TFrUl/7MpUZHaWFd/L8qLxeoQLU=;
 b=RF7/OlG1/0fuUTupfrh/FP+1pFf+XVqWsS8KhLS7eQxE1pNc5bJEZjtPnbVSvnB6lezL0BJVqTaGwIhWHPZgM7pXw8ivtc0mOZM1VbcWMClzWadZ3GoJiO3k647ZbStnHQYWMvJ60qk06gqWeihbluz9VDgxIcufjg71whLWIkQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 22:19:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 22:19:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: qcom: Add shutdown handler
Thread-Topic: [PATCH] usb: dwc3: qcom: Add shutdown handler
Thread-Index: AQHb/SyhkBLHTnV2GEi8+LmRwTAy8LRJs0eA
Date: Tue, 29 Jul 2025 22:19:14 +0000
Message-ID: <20250729221913.33qgxhb77f5hl5df@synopsys.com>
References: <20250725062158.2418961-1-prashanth.k@oss.qualcomm.com>
In-Reply-To: <20250725062158.2418961-1-prashanth.k@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB9256:EE_
x-ms-office365-filtering-correlation-id: fd851ceb-97d3-4aa9-8190-08ddceedf3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VU40SnIzdlJNWWZBNGZJU1lMTGpFV1lXWkJWZk93YmxpVnR2TzBQY1E4SXBm?=
 =?utf-8?B?Tlp4NXlYYmwvWGFya0VmcjRNclpEcmFKZFZaOXN3eWdKQittL1Vhb2ZUTU50?=
 =?utf-8?B?aS9iMkRpb0pDcEdrS01yeHNKeDNZb2g1cVFJK0YrMTJEU1NBYkZKV2NpdlNB?=
 =?utf-8?B?NVl3S3IrU3piOTE2Zm5FcStSSHZKeVZBWURiOEFWLzhOMHJpTWVKbWFOSEZP?=
 =?utf-8?B?ZllaeVFQMDEzTmtjNEJGb1lvUWJPYmd3bWp6SFVwUitVWEc4ZVFZMGl3NGI5?=
 =?utf-8?B?bWpMMnprZU1vdzJFaEhHbjNUUGh4WkZxd25NUUYxc0g2ZVNqNHFyVVVodUtT?=
 =?utf-8?B?cnRYNlBFQ2F2dXNSVUZYU1dYMlFHbUorT3Z4Mk8yYVg1d202ZjlEdE9hWm5D?=
 =?utf-8?B?Y0s1VFEvaTdKVzd4eVVwSWVValEwcWFEdTN2dXFuamNLT1BPMlBZb21rajJ5?=
 =?utf-8?B?VGVGcG1vdnVoOWZBeXJ5eFVpN3VNTzQxb0hlUDQ1TEIrQTJuUU13MTZkV1Bw?=
 =?utf-8?B?YS9kZ0ZkU01FbTFwL3RMb2tVcWFPSTl5d0ZLeit0U083VUJXYkhmbC9JOVBJ?=
 =?utf-8?B?Z0lJZ1V0MEcxa0NKSjZmRk1GREt0TUtqazBaWnZzcmdzOW4wT09kL2wzSk5m?=
 =?utf-8?B?ZHRYN2hNOUxJWWc3cU4zNXpkYTR1MStyTTM5WDlKbnpkTkFiVlVkczZLVWJW?=
 =?utf-8?B?UW9FamI1enJyd0Z0Q1hSdjVkK1hvcGtiU2RpSFRnUXkwU2liWE9EV3hQK1N2?=
 =?utf-8?B?djFub3dqU1diZFVPUFUvc1BCRnZnZ2g5Q0VFaDJtSDUyYllCS1NDbFQ3RHNK?=
 =?utf-8?B?YjdLVngyWi9LNzZSdC93bFdIOVovb2QrODQrRFZ4RWNYZDJnMktQRVhnb25q?=
 =?utf-8?B?SUtjUWhyeGVweHRTdmNqUW5yQ2pvb2lKTFdLWTNYSzJVMFliYm8yMUxaa2ZC?=
 =?utf-8?B?MlpxSHlVajlUMUd3MlNIbVF2VmhuUkNNZm56aXdZai9wdU0rVmxKNFBnd1NR?=
 =?utf-8?B?b2l3Snp4SnlyVURBZDNzUTBHOWU2eU9TNnZNaXBnNExxUzA2N09VbzlTeW5m?=
 =?utf-8?B?TkkvVUVCRlJjWGk2TXRQSVRFd1dScUlqeUNQcHpSdmlpbGVGbTVXRXZmNlVt?=
 =?utf-8?B?QXZvYkxqODZvaG0vMGdQLzlXSWhwRjRQWmltbDdhVWE1cWNUSXc2alJvNk8y?=
 =?utf-8?B?WlNhZjdPS04wRWkvU0t1NCtkU3FLS0F0YzdmdnpXSkZlOHpUMTdRLzNBVHZR?=
 =?utf-8?B?cHJOZTNuams3VHIrTjBZUXhYU0ZzYWVidUZjWWlORHRSTDFtY3d3Z2NVQy84?=
 =?utf-8?B?dHo5ekVidHlZQy9vZktKUHRFYnRXMDYxbE5rMGc5RlBuZGRJNk5sWktwdTBh?=
 =?utf-8?B?ZjBGVndCK2h5ZERsOVhTUEU0MDFDbGFSaWZHOWtpd2xqa1ArVWFhcEdOT1pU?=
 =?utf-8?B?MDBvMi9VOVAvanlNSEFuaGhtZGZSNHk0bkNUYkdJNVpVYVE2WGtZb0Q3STdh?=
 =?utf-8?B?bGI5TEhzbVdNTkFySXB0S0xwaTdTMzNwNkJOUjJ4OVB5RndneXZEZjlLRzhF?=
 =?utf-8?B?eDV1KzBCOGdIZTNRM0w5cDZHZFA4MHI2Wit0cUc3cDk5NXd6ckt0U2VraUFx?=
 =?utf-8?B?eUFCQ3lmamUzVVgzVWZqcDB3UTBsbGFONEs2Qnh3TkpUQlhyaFVjWEY5WVN2?=
 =?utf-8?B?VW1RMldoQW5kOVRZeFZpN1l3dThjUzVpVHJyRndKeXgxUTdSSnlFVE55dW1q?=
 =?utf-8?B?SWphakFHY2pQdjNoWFVxQ2FOd01NNlZDNzRia1g4UmF1RlREOUFaSWRRUGZs?=
 =?utf-8?B?SHgvNWVCVnVHcmQ5RGZNdGx3ZmxYSVgzdGdsaTVBK2RDYS9nVUhHWnk5ZEto?=
 =?utf-8?B?R3JpZThWWkJFaldQWURRQ2x6a3NQUUhNOGhLbE9aVFBRVEZheXE5V0FBdVJL?=
 =?utf-8?B?dFY1cjlsUzduQTl1TDI5VkVaN0MrYzd4bUJjbU1pRW8rRk1MbFByUFdMZE14?=
 =?utf-8?B?RG1oRXBmTzBRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dy9sTnB6eVpDZ09kYmtOM3FLREdVdEwrZ2wwRk5raElUTG5JTW9HR2VNSGp4?=
 =?utf-8?B?dGRXYTk5c3krT1FDZTBvZ3hpaGhSZ2dobDVtNXBQY3V5SFRJdnVTVURZSlJI?=
 =?utf-8?B?Ymd5dXRDRjJlakhBTmYwVkFkUmVPa2VyVk81aW5kRTZLQjh4eVRPcHdITWll?=
 =?utf-8?B?ZkdiUy9NR05JTUlPb2MydWZkcmVLYU9Ga25aWGVGeWVKckRlZzhvd0ZqcnRW?=
 =?utf-8?B?UktRWUlnTDZCYXRkZGROeGxRc0pQUEVoSnAwcld6R1VLclFDRTdMY21nZHRi?=
 =?utf-8?B?YStmWkkybE1PSnZaUWVYL2JUQXFiTmNnUmdTanRvbzluYlV0SGpzRllFUTRo?=
 =?utf-8?B?N1RadW1SSHAyTVBrRUN0QjUyaTRKVDVCN0pQU3NEQk01N2YybENEeVBpQUpX?=
 =?utf-8?B?SnVlbGdRTTd5bHZPdHY3Z1hETVkybThybm05cFEybUJwMG1tcDNCMDVHMjhi?=
 =?utf-8?B?NEY1MmZoTExTQUJqaTFNd0FFUEVlV2tDQjcvMjNIRGxLMlhScjNRUDcwQ3N4?=
 =?utf-8?B?bVhhOFdXdU03Tll1R0hrUWhxU0NoL2NBdGV6T0trRUxkWFpOd2U0cDhPZFhu?=
 =?utf-8?B?SS93MDZiRmFacncrejN0a01oN0tBOWR0VGdWZEZHNkxjSE0wcVZwUHZ6YktU?=
 =?utf-8?B?S1B4dUZkNFBRaVplUEZMbUYrM1pQa25XdUVpWGV2ZWtHRnNsYjI4aFBVclNm?=
 =?utf-8?B?UmRZejA2dTI2K2d0VmRHMFBKd2MzQnM3dFhwMkFJZ0NEVVVyaWQxZ1FDQXBN?=
 =?utf-8?B?Vjg2T2MzYXpGelBibGkyNTBHakdDczBhVmc5b3NnVlVtbGJZUy9sUy9hYTZt?=
 =?utf-8?B?R3pjYnFyWkVjVzhVbXlCY25XaXpPMW1JVSsrT3ZQbzFYZENZWDNWdGxLYVVL?=
 =?utf-8?B?YnVXNFRSUmFFT1VNTHBhZ0RJcEo2eDlLeVpDeVVPdCsxWlJTSitQMUxCa0dh?=
 =?utf-8?B?YnNOMTl6OHNtMmYzdk84RlNFQ0N2dHJYWDYzYU9CbTFpcnRzOU5aUTF6bDEv?=
 =?utf-8?B?aE1DcGVhVWhrMTlua0x5a2xmWHZEODdJM0pBYUUwY0lqUEpsL1J3MmZaNXBl?=
 =?utf-8?B?N3NvNE5YbUMrbGpyUU13b01MNHpCL0ZRN29EQjNZWFRLMkNyN2lCcExsSkhk?=
 =?utf-8?B?aFhEdEZFRFlWR2ZRSUpNenFJeVVGSEc4Lzk0WXRiQjhkZE9HYWI5eklhL1Bp?=
 =?utf-8?B?ZEJ3N3dickw3c2tiaVMzeExRRm81blBoYmx1dzVGUkJNdGozT3BoU3dpZlBu?=
 =?utf-8?B?ZW12TDZYMXZIdGF2eHZMNW1mK1JQTHpLY3lLeEtxQm4zQTlUL0lqK2JhQ0tP?=
 =?utf-8?B?Z0ZIMGVONitoNXNSYVNXZzd2eHM2V3pqRFV2VHlQMUtjd01nZ3hxZHNMVS9v?=
 =?utf-8?B?TXZSLzAxRGVyYU9PTFdoOTI0Y3dJckRGdXNrN2tMNWt1am5xWk9rVUZkLzBq?=
 =?utf-8?B?YUhWMTN5OXBodWxpUlNZbGVvUmhEWUIyZVZ0NVdFalRhdW9TZVUwcjVVZURN?=
 =?utf-8?B?YUhZaFptcUhnYnZRZ2RIaEowbDJxQTVhR1R4aVUwbC9naTgvNGNGQmFqamxl?=
 =?utf-8?B?NGdNVTdhTm00OU5WaEZWWkNRQkszeWNQV2ZMbXF3VG42TDhIaXZWQVpSUXZx?=
 =?utf-8?B?bjdka3RGWkQ1Mkw3QUNFZGtvSzVVQmVIeTl0Y21zTTc0RDZkTmR2eHRhNkdj?=
 =?utf-8?B?NUtaSG13VUxYTCtBcWE1Sm9XeVRMKzVHWW9QdjlYcElZeFJiclZ0VHJQREZE?=
 =?utf-8?B?VURyS0pPeXBSaHgvUXFlazFjTGY1N0Y3SHdRdXFDSE1oVDR2ckxwREljWHF6?=
 =?utf-8?B?dFQ4ajFyVWlKMXhFQ2gwc1JOanlJWlpWOTJkWVpiaVlqdUQyeWYvMHpFVG10?=
 =?utf-8?B?eFpYMGFxejlqMkg3ZW1DVHZ6ZURwVnE5OEN0b1ZNdHk3NnJrQzAyZnh6a2or?=
 =?utf-8?B?ZmdFbnYwU3ZvUmRSbWJGaUNwbERUN3FLdHNCV3puVmFpVmtiK0lHWHZTb3da?=
 =?utf-8?B?MVhpT3M5T2ZPdUxDZ3ovSXd2enI0MGg1MjdCL0daOVJOejJocXRSVHRrVmRY?=
 =?utf-8?B?eWhuOHVtU0ZJbGRNYXJkT1NoY05IRmhvRnB2TVJoUmdNUEx2d1JNWHc1YUpW?=
 =?utf-8?B?YXYyTG4rNVVHMUFFcmxwaUE0L0V4elkrMVRaMERCT3FVWGpRUm5qQUlJZHdL?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0242FD73AC37F245BFD5E9F55C58A3ED@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5b0St3w0xqT2t0SaJtRMq+ekt7325Pj87n5jmRtw4SwiO6f+ktihCr5eHT7n4UpkXI9TgiPXV43Gj5j+BG3g/J3FCQqQ3flmzM+wWn6mQI4x+Df2C2IpyRXCqnFIXIkPRJ6+u9xdanp0Snmqj3xqXdR1YJCaITRJ+KO14ooDGmhbmtnehCuHtVxHRzh289pXvZdGXfZHh4v39+Y1Wx1E8/RvPAnY7J6yPwmpHTPCz+44vWFB4so3ds/hclKxjKDsIDS8bp94LfkVL7ksVoYdEnRkJ8OvRG1Gm51vHwm1A/M6lcFgZXK5VkYHBrhKCd1BZxBQMy7DTKPdWdvJLd0ZeoqWUc9hmAMeDfSpd+WrGbWLore8BSfvpZPVO52ytEurf8sayut4rlsSi6nL/DMZXIMwe7PJaVILr/AN5fDwbI2d5wJ0S73r8Odxm5ViR2bpVqDtLa9dQLTzL8Pw9ZHNjUXHGzODoC6Z/+k/gvjhPb6f79odvDqT6c64PlCdB81LH0PE1EUPQv1uOYph/WK4VwvmZBpy4W/Y0xUz3wyitvFOjpDq8yR8vByXh9mccFx9X33uXMG3e0CA5b5IzDNhrPkFY9f4K+jj7fGp5VaGczWHS3nh2DHPK43fYIBRLphafHJn9+zlrRj6eSa7tE7xiA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd851ceb-97d3-4aa9-8190-08ddceedf3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 22:19:14.6718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3B63DvPBIjbKw4PJ0yy1/Ie6apHx4DxNb0WwPq3YkOmd3yO3gAcD/gijRWDvegEdyKdnm4e0BltXd6jHA2z/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDA5MyBTYWx0ZWRfX7osbKmxY+WQm
 fZ6AK8Pp9u2ahb6hhygzPEoF/4kHFdr4W3PVGTlDw8Uw0zJR+Rq/VqV0fBAen4OK9agNQ5AKKwt
 ZLu48uDT0t/kEsNNE8USU9+xUhKf18EzG8yk1iSzjRflrE3Bqbs9rhOs7khRTYQGh9tRdeqBQbC
 p0Nirg9O6ZUBIuvGMbnJ8cbEJGQaKCgOjZvdKYdWbJqxcVfSGkvaqTz1hpl2zVH1UJ5YXUuMBr6
 TUcwH3b3cWjuFUk5pA2FpMwSHu48MPNyDeHcggZz8VcWXytFgrRMPd+4A8K92gv74NxxuZFajyQ
 7rh6hZQDBnK0gHGtvRWQ6DJjtpyISsJofapFVeI4dmx+cTC/vBdXAKIVVAGZWQKqEHBm8uOlO1L
 GXakgi0x
X-Authority-Analysis: v=2.4 cv=SN5CVPvH c=1 sm=1 tr=0 ts=688948e6 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=qPHU084jO2kA:10
 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=xPOWtUYH_2Ur908Smm0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wfbRR64tYAloLgXprFHZe6Rv-o312Ldf
X-Proofpoint-GUID: wfbRR64tYAloLgXprFHZe6Rv-o312Ldf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260093

T24gRnJpLCBKdWwgMjUsIDIwMjUsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgZHVy
aW5nIHN5c3RlbSByZWJvb3QsIFNNTVUgZGlzYWJsZXMgaXRzIHRyYW5zbGF0aW9ucw0KPiB3aGls
ZSBkZXZpY2VzIGxpa2UgVVNCIG1heSBzdGlsbCBiZSBhY3RpdmVseSB1c2luZyBETUEgYnVmZmVy
cy4NCj4gVGhpcyBjYW4gbGVhZCB0byBOT0MgZXJyb3JzIGFuZCBzeXN0ZW0gY3Jhc2hlcyBkdWUg
dG8gaW52YWxpZA0KPiBtZW1vcnkgYWNjZXNzLg0KPiANCj4gQWRkcmVzcyB0aGlzIGJ5IGFkZGlu
ZyBhIHNodXRkb3duIGNhbGxiYWNrIHRvIGR3YzMtcWNvbSwgd2hpY2gNCj4gZW5zdXJlcyBwcm9w
ZXIgdGVhcmRvd24gb2YgVURDIHN0YWNrIGFuZCBwcmV2ZW50cyBEV0MzIGNvbnRyb2xsZXINCj4g
ZnJvbSBhY2Nlc3NpbmcgbWVtb3J5IGFmdGVyIFNNTVUgdHJhbnNsYXRpb24gaXMgZGlzYWJsZWQu
IFJldXNlDQo+IHRoZSBleGlzdGluZyByZW1vdmUgY2FsbGJhY2sgZm9yIHRoaXMgcHVycG9zZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXNoYW50aCBLIDxwcmFzaGFudGgua0Bvc3MucXVhbGNv
bW0uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgfCA4ICsrKysr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IGluZGV4IGNhN2UxYzAyNzczYS4uMzA4MzYwYTMyYzkz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+ICsrKyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gQEAgLTc2NCwxMSArNzY0LDE0IEBAIHN0YXRp
YyB2b2lkIGR3YzNfcWNvbV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IAlzdHJ1Y3QgZHdjMyAqZHdjID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAJc3Ry
dWN0IGR3YzNfcWNvbSAqcWNvbSA9IHRvX2R3YzNfcWNvbShkd2MpOw0KPiAgDQo+IC0JZHdjM19j
b3JlX3JlbW92ZSgmcWNvbS0+ZHdjKTsNCj4gKwlpZiAocG1fcnVudGltZV9yZXN1bWVfYW5kX2dl
dChxY29tLT5kZXYpIDwgMCkNCj4gKwkJcmV0dXJuOw0KPiAgDQo+ICsJZHdjM19jb3JlX3JlbW92
ZSgmcWNvbS0+ZHdjKTsNCj4gIAljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZShxY29tLT5udW1f
Y2xvY2tzLCBxY29tLT5jbGtzKTsNCj4gLQ0KPiAgCWR3YzNfcWNvbV9pbnRlcmNvbm5lY3RfZXhp
dChxY29tKTsNCj4gKw0KPiArCXBtX3J1bnRpbWVfcHV0X25vaWRsZShxY29tLT5kZXYpOw0KPiAg
fQ0KPiAgDQo+ICBzdGF0aWMgaW50IGR3YzNfcWNvbV9wbV9zdXNwZW5kKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gQEAgLTg3Myw2ICs4NzYsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBkd2Mz
X3Fjb21fb2ZfbWF0Y2gpOw0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZHdjM19x
Y29tX2RyaXZlciA9IHsNCj4gIAkucHJvYmUJCT0gZHdjM19xY29tX3Byb2JlLA0KPiAgCS5yZW1v
dmUJCT0gZHdjM19xY29tX3JlbW92ZSwNCj4gKwkuc2h1dGRvd24JPSBkd2MzX3Fjb21fcmVtb3Zl
LA0KPiAgCS5kcml2ZXIJCT0gew0KPiAgCQkubmFtZQk9ICJkd2MzLXFjb20iLA0KPiAgCQkucG0J
PSBwbV9wdHIoJmR3YzNfcWNvbV9kZXZfcG1fb3BzKSwNCj4gLS0gDQo+IDIuMjUuMQ0KPiANCg0K
QWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIs
DQpUaGluaA==

