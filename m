Return-Path: <linux-kernel+bounces-799576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D3B42DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2165682A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0661FCE;
	Thu,  4 Sep 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uo6RUaT8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LbE9Y3WU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d4e2hLQ4"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFC1A254E;
	Thu,  4 Sep 2025 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944037; cv=fail; b=CtqL5nvZRZT6iXLrddCI3u21XzWT446Oh9Rlz+zr52eAPTmXFRC3+aofrhTseTPc/20EfBQoQMoNMLBnQsUAC1g6hWI/OgDsTUW1KM8V/KBCcdfDGdaXtRg0bzxS++u26aWZRiCRdjekEaYegODHGDww3rskqgiF7W66wlnJJIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944037; c=relaxed/simple;
	bh=TxcAtkrfiksJs5f/CBUbTzpSSWb9qjyvY/CvnZ6Hlgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EbfQhUkgSosvZhMcrcemGah+hGnmH34hkr02v8PmXpH0fVkUxnd+Hfu4tG/fFmWLAAt5S+v+h0LfvFI+6r/CtkQTSrf0TqYkbC258eXi0N6mWy/eigZ+7rTGuz921B53rQd0FcFi92nskGLGKU7y1j2XGCYvf9YqIW1jUzxQF7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uo6RUaT8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LbE9Y3WU; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=d4e2hLQ4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583GhabD017628;
	Wed, 3 Sep 2025 17:00:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=TxcAtkrfiksJs5f/CBUbTzpSSWb9qjyvY/CvnZ6Hlgo=; b=
	uo6RUaT8FpiQb/v+Vn4ryI8xwWYIb8BZEHR5Zd2n8Nfv23rmOu0My91cPmo0REIU
	ezPwoOOK+CqbLh3EzzkYWGpSFPvRO0yv97wjNaoAk5Ln3gZD3iBUx6aDBdFdL5DM
	KdBesq01DuFU+kL6Nej08vw1ftm0DefeBdo7H9b83CwcEZxv/ZGp0O6hkqTNfWUp
	lZBuF8netEE4wMYAjnFA/1ZOOepgob05BX2nuIM/d/zdReCorO0qE1qJwOzBP08X
	ADQfJQINrVySTfgJ2YePZo4dbFBKYO2jcbR0njQ3tR53y+6W3/NNMDcXTydSZMd6
	UKFFygC9gzFZpjnwRWtBlQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48uyxf63t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 17:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756944020; bh=TxcAtkrfiksJs5f/CBUbTzpSSWb9qjyvY/CvnZ6Hlgo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LbE9Y3WUi/XeEAoZB/RSFH0QqdVKpWm9pm63CeQYCt22D9r6TGq/4oyAS/ytMQMb+
	 nD/NybuishAEzrLdzkEhC6atBBsUQzl+ZkVdEL29sBFfmNTiItOFO/e7dwCnx2LxGc
	 bi4jpDH0fv8VPBr7qU5iH2lZYm8ksVZVg9WMGeJniQeRgRp0T/3wxjg7BGezFMTdD5
	 YRgRETIIAQDIfggQfH0Pg3dh/rov8HBLzy9VdA1QGqebYMNLQnujMdhAcmSysooUqE
	 /hh+jyqrzzjO+VIQByEkB3SzHdb5q1zCfKKse3WKIH9XSVHvMX8LIjoITg4t6yHDIO
	 R6RtFPGLUXviw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F08ED40736;
	Thu,  4 Sep 2025 00:00:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6F99BA00C5;
	Thu,  4 Sep 2025 00:00:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=d4e2hLQ4;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D98B3405BD;
	Thu,  4 Sep 2025 00:00:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5jJQO9EeBUBLHPh/dvnHReLhLFRX9BNrVs3992Vhma07c0Qyc7Jrw2KhKi1mZBQGyLE7CGYzc5l8TQduXljo64rCk54hy2XSr2ptHU2LxkgphD/0Prg7ea1SeWFEkQc06oAF1SIp6FBx2qIzT71xzPZrfbm7h0qEmK9vw6m+b4dxtMy9bnrXv/Mtdv3H+wdlxJ/67bGFoe8vPgWpmWnns3+rZAYrm6BQTTt+nyrlnnG3kP7Ij/r4obOaxzdSwIZCmeJzN4j1gfVe/X1lAaPYhICsU/j2pD1yDIJ7NQHH/AIECUkEoYiMuT5/TlI30+//MdirzCklyrXdYScXNql5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxcAtkrfiksJs5f/CBUbTzpSSWb9qjyvY/CvnZ6Hlgo=;
 b=IdDFu62669A4b+PVHdgCtzOLctULT/cO7CL8EMecHbNd0NpxUVt4FZNTsyGNWjtdD7K9uhYFzPKRgfLZDlH2oMeoVwVFiUKW6Ao1cYS7cECxS2o0RrHp8485SqucG80dL5wZTujdfPmcwHTF8WhZarSTezgtDDIdhBXjJay3IeXVhVBcnASz3pzdlC9bWZmMufuVmcQ03fL1czmC0TNl6XtGnv5jfZqVkqDwtcScarblDwv5HM38WuDmzMSSRpgX5zS94Kxfy9/I9V2SdR6yB3z9fcuk3ISqq0bHJLBA2gWZq3kzkproy3xXiLOEiC7BRjYnoBJXW5dn3qzpfaatSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxcAtkrfiksJs5f/CBUbTzpSSWb9qjyvY/CvnZ6Hlgo=;
 b=d4e2hLQ4eiqthb+ty5uA/NJeS1F995ceWfWwLfKxB82Go8Yz+VoSVAPcaShn3ty+5SojsaYPNGuGhaWwaoMqCru84prEHtOphJJoqE9+0+4HMQ504EPr2hCgh/4YBQp90pwR+RoTlCL41qganL500+KzziNx5+K9QEg4TLmVjDk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 00:00:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 00:00:12 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Thread-Topic: [PATCH] usb: dwc3: Log dwc3 instance name in traces
Thread-Index: AQHcFbWpI8fQ113kKk2/GPa4dCHPkLR4sG4AgAVxqQCAAnmiAIAAd12AgAEfOIA=
Date: Thu, 4 Sep 2025 00:00:12 +0000
Message-ID: <20250904000003.b4j7fnucronjf6ej@synopsys.com>
References: <20250825114433.3170867-1-prashanth.k@oss.qualcomm.com>
 <20250828224852.ukelgargocektp3z@synopsys.com>
 <5b30f63a-5999-48f1-972f-93f02fcc0ec2@oss.qualcomm.com>
 <20250902234450.vdair2jjrtpmpdal@synopsys.com>
 <67329e66-2221-426b-88a4-eece06d694ec@oss.qualcomm.com>
In-Reply-To: <67329e66-2221-426b-88a4-eece06d694ec@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB4289:EE_
x-ms-office365-filtering-correlation-id: 176f729b-474d-4e88-b574-08ddeb460523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?allqTmtaYXBwNUZXMVh3ZzJRVXBXeEx4akw0RURTVVVwclNPZ0dKWlQyTlQy?=
 =?utf-8?B?aEx6anRuZS84ekhja2NzMmd1dzZPZ25oY2w3Q1RwZ1FLZVVpSVdUS0dxQ0Jk?=
 =?utf-8?B?bFZJS3VzNHBHYXVoaVpoUHBJWFl2bGM3blRKdktQU214aE1GTE5DMWJvK0lv?=
 =?utf-8?B?SXdHL1ZWc2lLVVZaQnhtaVV1YVhKWmE3R0s5M3RmU0Z5YjhXWjFBMkhRc2ZK?=
 =?utf-8?B?dnFhRGpiaXlyQmVkVnZKRVlENlJ1Y2VqUlU1N2d4dCtrRFowc3Q2N3BNM01h?=
 =?utf-8?B?bno4ZFEvRVEwK2ROZHVzRS9WRHNUVXZ2TXdYd2FBOTBqQ1hqMnBEY0xaQVZM?=
 =?utf-8?B?SUNwUWo1cG8wYzFlTG1HU1Y4cm9KL0JtWG1BRTRxWWJSRGtPNUIwMVZUMmt6?=
 =?utf-8?B?SFBJVE8zNU03QndaelB3dU1DaFFWUHAwWC83a04zRmNHSURqcGoySDdlMTll?=
 =?utf-8?B?QS9ZNmRmcFNFNzhLdU5mTllQMUp2bzV1bVhoeU5QVnVERHYyMkZLQ2ZPT1Q2?=
 =?utf-8?B?Q1JFNnNlMUd4KzdhZVh0UUUreE92Y3BJUnhkUGY0d2gvaFFOMTRLUHJmSEto?=
 =?utf-8?B?dWpoNlJ6dUFUWFd2OWwwbndPK0ZvdmdtY2J4bE9sbWh4WDMwTDRYbUFMQndK?=
 =?utf-8?B?bCtvT1pvOEw2em5RQ0JpbzlCMzlHVXh4Z3NWRTFOcFBETFRwa3h1cXpjNUp4?=
 =?utf-8?B?VHJGT2VJc0hCN3JWMDRlODZoUU1jSUg0ZlJBbWU5YzlEeXBsZzVVRjJCOVdZ?=
 =?utf-8?B?QjRQcFhGZTdxNy94OUY5MlNpYTZoUThFeVBWWGwyblEvWWdFS2RHS0VYME9v?=
 =?utf-8?B?dklweFgzQ0pZR29RY0RydmdjY3MrWld2V25PaDdQN09oRjJzYmw1TnJSV2hm?=
 =?utf-8?B?U1ZBOUVWQjhIRmR3Z2tGNHVVbzhUbkV4amIyc2ZGcUVWODA5dkhqTjZuQkdP?=
 =?utf-8?B?ZmZ6UDJCRVdacUdjMjFaTUYrOUpBTUJvTjQ1bEFpMERQUDJUVUxEa0VkWUZE?=
 =?utf-8?B?RzFMYXB4Sm51QjBKM0kxOEJSa2k4RTgyV2NDTmphZFFPNzlHRnRwZXQ3MDl5?=
 =?utf-8?B?VWRkMzk4SkdZMlhLQlg0b3lRWFU1NTRSOTBZYnNCTkFub2cyMzFEbE01c2NG?=
 =?utf-8?B?SGxaTlhvbDZERSszcmNrYVhGWFdnVzNRTnorRHdUUlNjak9SYmpwWVFYcTFH?=
 =?utf-8?B?VFlmVzRqM3pxQjJsUS9mWjd5YkRLeDd5enhDMXVXNERmUUFlTjEwTzVBcUY5?=
 =?utf-8?B?UVdFWW5jWmNjVUV2Q1Z6b1hVbklYY0RPL2xodUpmeW04S2pVa2U4dEdhcWQ3?=
 =?utf-8?B?cjVSbnpjcmRuWU9kc3g3cW9IUVpxeEgxRHBXSW14Y2JySUlrL1dyM1hibVpQ?=
 =?utf-8?B?TGhSN2E1Sm1YaXlUTFVzMWhZVnZ1Q3JWN3RIK3krUzVaeVlqWk5mL04yajNF?=
 =?utf-8?B?SGxVeWJ6VTdxQm0zY0ZjcWRBYmpQY1lReFo4VFJmQ0xzN21uTFVIQ0NEY2cx?=
 =?utf-8?B?QU9YZkp1LzluSGovaStaUXF4TmV1N0xQVlA2cFZIMC96WmY5VjVRUUhXd0hK?=
 =?utf-8?B?SmlxRm1BdlZGdFlUWEZtQU4vbWorWTB0Z0haQnp6TDZ0bGUvRGYrSkpQZmtq?=
 =?utf-8?B?Wnl1SGVvYTJYSU4vRzE5ZHE2MWxHd2prVWZnc1lOWHNacG5GMlhEK3RCQTRN?=
 =?utf-8?B?K3diRDYrbmpTYjlMakt3OTJzODBTTGl5Z3k3ZHkyS1ZZTkVPRUJMWUZ0YmVK?=
 =?utf-8?B?b0J4enMvclFyd3Y3WjhDVVdzb2xVQ0s2aEgxVUg2VkRsY1BmTk9JYVp5cHVz?=
 =?utf-8?B?b0tTNXpUdFNrRW5PL1I3ajVNaXlYNXR3OFZQaUd5RE5lTE9sMExpbkdtU3BO?=
 =?utf-8?B?a3RCS1pvM01mT1IyeTRPckZRcWtaUTQ3eVozU3JVbWR0ZmlpSzJ1ZlZmTGFP?=
 =?utf-8?B?M0JBNDk1cG5ka0VSblJUWXlGbGcrUlhGdTJFSkt1L0xZaVRSOENTQ1V4ZWFw?=
 =?utf-8?Q?cnNOR2DkKVIeV1aBfkeuRskeh33bbA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDltUWpkQ3FFUUJkSVVISm9GNzlhdjJQTkZIL1dIOHUrbnRUWUFDVkJjbkdZ?=
 =?utf-8?B?WlU4djdMZkhtQSt1OWRXZnN4azBhVlZwYS9JUWVQNmtkWTVDQzQxWUhRUGZ1?=
 =?utf-8?B?bHBSR0pJSTVnNUNWYnZSQVlCZElodXUwQXp6Uko1dm9EYmhUaTJjdmJ4endW?=
 =?utf-8?B?YlJHdVZNakZiczlRLzVsNUxRNU95N2lCT3ZaY2dtMUI1ZnNBWVdmQTdvNk1K?=
 =?utf-8?B?bEgxVWxla3F1YU1FN2N6S2pPZkRiZHdxaHB6V0F4bGVOQTRTckNYYnE5U1pO?=
 =?utf-8?B?SE9PeFU0OXoycmVrSG9XMUNQQTEwNHRFY3ZGdndLdkNYTDExRHhHSnBrV09K?=
 =?utf-8?B?aTNORzVXMCtPTkZJcHZSV1JoNTlRS1J3YTRuVnZSTXNTWjUxSHFFbCtPZE5Y?=
 =?utf-8?B?VFBrdUs1Ym8zWTJrZ3lJL0Z0cHlkMzZwMUFyNCtKVVAyWHpSdWt6ZGJ6R2N1?=
 =?utf-8?B?RzBMVDJlUHFvQlVIZ3hINCtBODZPMDdGTTJ6UGtMUzZBOVMyMVNjOU5ROGt3?=
 =?utf-8?B?Q1RId3l1T2tVbldUOWVzdUdYek9YdHNrRmNuajJvd2xlbEFURm8zekxMYzl5?=
 =?utf-8?B?WmczWnBlVjNvL3dtUUZvZVVoM3JRNVRqb0dsL25pK0ZlTVhoUCtPQUtjYmZF?=
 =?utf-8?B?dmdXOWRsZHg2bDlaN3huaW9NZnNyWEVYeWtjTjAxeEk4eTVaZWZQRmtmZlVO?=
 =?utf-8?B?MUxRVnlvNGZkU2RKUnQ0TmVYcFcyUytsalZMa290OUp1MFg1NkM3M1gvOTBV?=
 =?utf-8?B?Ti95dWlpTWJGTitXUkRWT1pNbGx2N0FMZ3NYdlRPZ0JpZ0hyRzZRWEJ5MkZs?=
 =?utf-8?B?RlN0RGNTR1pMbStJN1JCWkhaOUp6dEFpVFBjcnQ4RTVyMDh6eUp6aCtQMFVJ?=
 =?utf-8?B?TEIwcFNCLzJsV3BwUUJ5Ryt1TFR0cVBISThidHFsdU0xT2kxQ3V1aXJJSHZi?=
 =?utf-8?B?UjZLTFQ0Q0wvV3RZY2RXeWJpOVRwaEVlWU5JV0U1SldYWVVGMkg3TU5Kelcw?=
 =?utf-8?B?ckJZWnAzRzFqZG4wYVRiM09FQURKRERHZ05IY2swSXhrZWFRbWJkNURPdkZa?=
 =?utf-8?B?a09WMXhidHk0aWhDYVZKUXlDZldjNExabk9iY0x1NVBYSEpzOFdrQ0tZR2Jn?=
 =?utf-8?B?dXF3Zlpxb3gwTXU5OVhnRFA5MTJKcThzbVlUSnhrLzlka1BjM1VzZi9tR04y?=
 =?utf-8?B?ejRBaEZJRy9XTWFXSW9ZejhFSVJac3pPVHJBek5HZXppSEN6bFhEaDM5RUFu?=
 =?utf-8?B?ZTZkNHNZUEVWUFRzVzduU1lzQmhSc1BPZVRZcllid1V0SFFzYWoxdFdHdUlD?=
 =?utf-8?B?dDlnTnB4SEs0SlVLUU1ERnRiRXJoZDVGSzZhRFJUY1M3bHdWZ25RSStrNlMw?=
 =?utf-8?B?TVFweVg5UEJSVGd4MHU0ZzZBTUJkS1ZYWXovS2JGK2l2YkZ3ZUppMDhIdERT?=
 =?utf-8?B?cWE2QWJ3VFVvam5vNTQrV1krWGJFS1MyODF6V1NLVm52TUxGRUZ1VmdRZ21O?=
 =?utf-8?B?cFdFRXRvam9XV2pGWEZ1SWlqRTBLSEhnUVRkZXFYRXBjbUdNdGNKaHhQeWcr?=
 =?utf-8?B?aTR6WTZqdVVPQXB5ZVg5QThLdzA0RW1XZzYvRnRnajhiZzlXWFZzbnJBeFFH?=
 =?utf-8?B?WitxZUVSQk0xVG4rclN1d0lDVEdsZW9jK3dWbWFEQ0J1S3VKQ1FGeUZxNFJH?=
 =?utf-8?B?MFVGYWlXN3BTZ2IwNlJJVFhVR0pYRHFxdEduL3JvN0QyMi9MZGpTSXZwZ0c4?=
 =?utf-8?B?S091QUJpWFpPRWJXTm82RlhuaitLTDUvM0hqMGVtYTBLZms5N2UzaWE3Sjg5?=
 =?utf-8?B?YVJTaTRBZURNWEFVcUUwSXlWNzRxWGg4WHM4bEdpN2RIQkNlclE0OWQzcEZu?=
 =?utf-8?B?Z1Fjd1pGWS9kZ2hJZ3ZlaGM0L1FrTXRKU1NIdllqV1N0c0w4eUM0SExkTW9C?=
 =?utf-8?B?blBibitSZGYySVFWUG8weUVSQXNkN3J1OVVpQUlxZDVrTndhNDVWejRYR0pT?=
 =?utf-8?B?RkM3SG03TFhzL2N3VDVFaHRNbS9FZHJCT2JaT3lVZmhQYVlNWFEwRU1Id2ZL?=
 =?utf-8?B?d01rNGpjVHFHcXZ4RnJiaUl0OVRpc1JrVmQxdE5zRUVSNEZnZTF2ODJkN1JT?=
 =?utf-8?Q?jyAEcyBQ4CMg8BEYeH24tBEd/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A612E9E114BFB4DA06B95FF8B39DF3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iQ+fLBdqp87g7tpLi5gNSXSR5/AyFx2Yml9ht4yPtl8Z26AOOA0FoPDNYxMEdfOd2FJ3fThomlDtC2pGtPODLKnsnouxL0O1BhtBO7VH5UTNN51oxenH/4wEUsmNDDWDTgP/mPFEp68yxfuUOxRtHk+2NlgVD/p2gDEr68IyiCdhI6Az7p216952jl5/yXyBO0XWMzAsmtDUSESLkRH/ME7IPysZUXNxvBlGtWN8V6YKm7q/yIblk/ZbP9GqWAMSkaivHvbygRybLTokfXNl4NSTRArVkf3XPAyT+TRc6aWSyE5BeNYpTOUCTOPc+dNyAWmYZGItEzRsOBYmAw58+n+Hh8eybSm8HUXRpy2OWym8RsSngh58MH/DG4ZLIlmHg6ZPQqtmjJTfHC+bL91oGg3umtGrt4/6a3aEBdVXH4VbsIpPIUYh+TaNt6klDSDoYrH37a+hIQ1o1fqCpfAgZhkg0jvHq+gH/w1Ms2iC3LqDwnukktnKy/LqjBIH+0a2fqoslYu9LyLhBLj7reOwmnzAczL5xYBwthQ/UWapbAHX2TIUcMtxr37BX3Xj8M4htd4AoGdJAGJvNmSEk47XyY0SM3XcoC9gdmMXQzpytzL2jDGtcZRcpkINoqSE6pulIRlSW9fUH0lGUBdwrFn5IQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176f729b-474d-4e88-b574-08ddeb460523
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 00:00:12.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VF2xeUL72QLxNin/PbhIwoT8+f/IhLgrKCWASEZAa25PXVsMSbcOmj4j9m8AXP05PTAf/9O+ppdcuPglD8+fEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
X-Authority-Analysis: v=2.4 cv=U7+SDfru c=1 sm=1 tr=0 ts=68b8d695 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=EUspDBNiAAAA:8 a=RWUitrD8pFLGzow5wVoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6vjlBkQzLEIrtWCReXdy0_w6e6dkrHh-
X-Proofpoint-GUID: 6vjlBkQzLEIrtWCReXdy0_w6e6dkrHh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDEwOSBTYWx0ZWRfX8jdiDq+LS93M
 yh/j1p62hvUXYqNf1Y4KmpCOFALbV11+sA/kqJ3u9K/7WfWtkzR9oyfmqv/nnrckpkfytl3wIbP
 llTUQFy3X0espnDhrLACSbXj0Qd6MFsQ008+5OMFuK7iWvvrSS3J9XccxveSjbTxfj9U8QLBj6+
 T/0fxCUG2kRIYcqctsEqhzsNIl4iA9HfKSnRZ9S3LgFnkkpvetBGo3Kc6rys8VNNlgAt3TcqgPt
 /VwRqD2/q7335gJTA4NZVdg3cRORWjI6SN7lCVcbNyey4C2LiAFaF7tebMur7PP1xkMLnq8I1mj
 7fNHP8+dhQQ8a0C1UhPL+10BYgPck1MwMfSduxnzIjr1jtCsPi2Lm6/lMjY3Wjj8+g5D/3sc2+G
 mHiA7LdQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_11,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300109

T24gV2VkLCBTZXAgMDMsIDIwMjUsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDkv
My8yMDI1IDU6MTQgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBNb24sIFNlcCAwMSwg
MjAyNSwgUHJhc2hhbnRoIEsgd3JvdGU6DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDgvMjkvMjAyNSA0
OjE4IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBPbiBN
b24sIEF1ZyAyNSwgMjAyNSwgUHJhc2hhbnRoIEsgd3JvdGU6DQo+ID4+Pj4gV2hlbiBtdWx0aXBs
ZSBEV0MzIGNvbnRyb2xsZXJzIGFyZSBiZWluZyB1c2VkLCB0cmFjZSBldmVudHMgZnJvbQ0KPiA+
Pj4+IGRpZmZlcmVudCBpbnN0YW5jZXMgZ2V0IG1peGVkIHVwIG1ha2luZyBkZWJ1Z2dpbmcgZGlm
ZmljdWx0IGFzDQo+ID4+Pj4gdGhlcmUncyBubyB3YXkgdG8gZGlzdGluZ3Vpc2ggd2hpY2ggaW5z
dGFuY2UgZ2VuZXJhdGVkIHRoZSB0cmFjZS4NCj4gPj4+Pg0KPiA+Pj4+IEFwcGVuZCB0aGUgZGV2
aWNlIG5hbWUgdG8gdHJhY2UgZXZlbnRzIHRvIGNsZWFybHkgaWRlbnRpZnkgdGhlDQo+ID4+Pj4g
c291cmNlIGluc3RhbmNlLg0KPiA+Pj4NCj4gPj4+IENhbiB3ZSBwcmludCB0aGUgYmFzZSBhZGRy
ZXNzIGluc3RlYWQgb2YgdGhlIGRldmljZSBuYW1lPyBUaGlzIHdpbGwgYmUNCj4gPj4+IGNvbnNp
c3RlbnQgYWNyb3NzIGRpZmZlcmVudCBkZXZpY2UgbmFtZXMsIGFuZCBpdCB3aWxsIGJlIGVhc2ll
ciB0bw0KPiA+Pj4gY3JlYXRlIGZpbHRlci4NCj4gPj4+DQo+ID4+IERpZCB5b3UgbWVhbiB0byBw
cmludCB0aGUgaW9tZW0gKGJhc2UgYWRkcmVzcykgZGlyZWN0bHk/DQo+ID4+IEkgdGhpbmsgdXNp
bmcgZGV2aWNlIG5hbWUgaXMgbW9yZSByZWFkYWJsZSwgaW4gbW9zdCBjYXNlcyBkZXZpY2UgbmFt
ZQ0KPiA+PiB3b3VsZCBjb250YWluIHRoZSBiYXNlIGFkZHJlc3MgYWxzby4gTGV0IG1lIGtub3cg
aWYgeW91IGFyZSBwb2ludGluZyB0bw0KPiA+PiBzb21ldGhpbmcgZWxzZS4+Pg0KPiA+IA0KPiA+
IFllcywgSSBtZWFuIHRoZSBkZXZpY2UgYmFzZSBhZGRyZXNzLiBQQ0kgZGV2aWNlcyB3b24ndCBo
YXZlIHRoZSBiYXNlDQo+ID4gYWRkcmVzcyBhcyBwYXJ0IG9mIHRoZSBkZXZpY2UgbmFtZS4NCj4g
PiANCj4gQnV0IHRoZSBiYXNlIGFkZHJlc3MgKHZvaWQgX19pb21lbSAqYmFzZSkgd291bGRuJ3Qg
YmUgaGVscGZ1bC4NCj4gVXNpbmcgdGhlIGJhc2UgYWRkcmVzcywgaSBndWVzcyB3ZSB3b3VsZCBi
ZSBhYmxlIHRvIGRpZmZlcmVudGlhdGUgdGhlDQo+IHRyYWNlcyB3aGVuIHRoZXJlIGFyZSBtdWx0
aXBsZSBpbnN0YW5jZXMsIGJ1dCBpdCB3b3VsZG4ndCBoZWxwIHVzDQo+IGlkZW50aWZ5IHdoaWNo
IGNvbnRyb2xsZXIgaW5zdGFuY2UgZ2VuZXJhdGVkIHdoaWNoIHRyYWNlLg0KPiANCj4gQW5kIGZv
ciBQQ0kgZGV2aWNlcywgaSBhZ3JlZSB0aGF0IGl0IGRvZXNuJ3QgaGF2ZSAgYWRkcmVzcyBpbiBk
ZXZpY2UNCj4gbmFtZSwgYnV0IGkgdGhpbmsgd2Ugc2hvdWxkIGJlIGFibGUgdG8gaWRlbnRpZnkg
dGhlIGNvcnJlY3QgaW5zdGFuY2UNCj4gYmFzZWQgb24gdGhlIGJ1cy9kZXZpY2UgbnVtYmVycywg
cmlnaHQgPw0KPiANCg0KV2UgbWF5IG5vdCBoYXZlIHRoZSBQQ0kgZG9tYWluIG51bWJlcnMgaWYg
aXQncyBhIGNoaWxkIGRldmljZSBhcyBpbiB0aGUNCmNhc2Ugb2YgZHdjMy1wY2kgb3IgZHdjMy1o
YXBzLg0KDQpUaGUgYmFzZSBhZGRyZXNzIF9kb2VzXyB0ZWxsIHlvdSBleGFjdGx5IHdoaWNoIGRl
dmljZSB0aGUgdHJhY2Vwb2ludHMNCmNvcnJlc3BvbmQgdG8uIFRoZSBkZXZpY2UgbmFtZSBpcyBp
bmNvbnNpc3RlbnQgYmV0d2VlbiBkaWZmZXJlbnQgZGV2aWNlDQp0eXBlcyBhbmQgb25seSByZWxl
dmFudCBpZiB3ZSBoYXZlIGFjY2VzcyB0byB0aGUgc3lzdGVtIHRvIGtub3cgd2hpY2gNCm5hbWUg
YmVsb25ncyB0byB3aGljaCBpbnN0YW5jZS4NCg0KQWxzbywgd2UgKHNvZnR3YXJlIGVuZ2luZWVy
cykgYXJlIG5vdCB0aGUgb25seSBjb25zdW1lciBvZiB0aGlzLiBUaGUNCnRoZSBoYXJkd2FyZSB0
ZWFtIG1heSBhbHNvIGFuYWx5emUgdGhlc2UgdHJhY2Vwb2ludHMuIEknZCB0aGluayBtb3JlDQpw
ZW9wbGUgYXJlIGZhbWlsaWFyIHdpdGggdGhlIGJhc2UgYWRkcmVzcyByYXRoZXIgdGhhbiB0aGUg
bmFtaW5nDQpjb252ZW50aW9uIG9mIHRoZSBMaW51eCBkZXZpY2VzLg0KDQo+ID4+Pj4gRXhhbXBs
ZSB0cmFjZSBvdXRwdXQsDQo+ID4+Pj4gYmVmb3JlIC0+ICBkd2MzX2V2ZW50OiBldmVudCAoMDAw
MDAxMDEpOiBSZXNldCBbVTBdDQo+ID4+Pj4gYWZ0ZXIgIC0+ICBkd2MzX2V2ZW50OiBhNjAwMDAw
LnVzYjogZXZlbnQgKDAwMDAwMTAxKTogUmVzZXQgW1UwXQ0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVk
LW9mZi1ieTogUHJhc2hhbnRoIEsgPHByYXNoYW50aC5rQG9zcy5xdWFsY29tbS5jb20+DQo+IA0K
DQpCUiwNClRoaW5o

