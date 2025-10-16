Return-Path: <linux-kernel+bounces-857025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD8BE5AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E700234ED12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD862E0B71;
	Thu, 16 Oct 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Yq9U4Mdh";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E+bcocyA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kKLauFcR"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467D2DA75B;
	Thu, 16 Oct 2025 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653677; cv=fail; b=S56/8YHlByoKiZ5dAALCbSs6FJqLfVyqrDC1vG68OIQb0wDlMJMQM7+EdDtdBHpf7l2WCH7T5Z7v8Y+xoMsFHTLp+VIr/v41r1TDabUvkXdtroGb70qbld7/a31Tp2y4Prcy/LPld6qDPTn8lULXlHGdoG4z76t5q/+fXAVmv8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653677; c=relaxed/simple;
	bh=O/GcL671HwxH8YBdyx/A3/8H4wmC4eEGbIv3QW7HsY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zx1lM4FX8XGqypX2c89yezf6EeqrGE4hvNW+saDXP5dl7eIBE7pqL9inVN7Z1/sNJ+TNkglVjvBLgr9I0UYwXCK2ju2GXY7T0hZz9PPGsWWQLgRQ/Jh+eTOoL2aFORGl6toQQ7iIHYTZy59dw6W82AAvDzs65ZptO6nN6cRpZD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Yq9U4Mdh; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=E+bcocyA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kKLauFcR reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLmUVC023346;
	Thu, 16 Oct 2025 15:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=O/GcL671HwxH8YBdyx/A3/8H4wmC4eEGbIv3QW7HsY4=; b=
	Yq9U4Mdh5ht8gtPEt/wGMmJCP88gTGcvL2e9OAwJc70fUehLET2MkFTJQtK3RZ4U
	uXOgNszv8iAUg6G3bvwiM8l3dJd+wUkrcDdIQIkWjSewmZKxEdSimwTcJuPBKGaX
	AKADj+UFRhsMh1mJyfa4iSeOSOq/1uoIUCKe3/WrnLk5o9S+46n7D2AOokFFxlYy
	GoJihiw+AmrYEzIpiwesZjPFu4yyvJYV4A9x7tWEVKiPsWzu82IaYJXUX+50UazH
	oMRg+NkRzBqO8tvQww+bHxxB/tsJZg7h1dTW2n05aLw9yl1JidiKXKsBHyf4wkgE
	Tq8xEu77U7ZjuPcx/f9QNg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 49ss58qyyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1760653641; bh=O/GcL671HwxH8YBdyx/A3/8H4wmC4eEGbIv3QW7HsY4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=E+bcocyArDpxk8f6TcXiw7uXpf4nUe/ATJ5zf4gS+29B4zUS2XakzJDF+1MbkU/IS
	 gc2UoyNelOn80RXrdbt7vp5gWTRvDFQB0UIs6PjtSSi8avIs83n9fApQ5dnGWQUB2u
	 NlYooINxKMFlpEeoxNC6deyfqqKf3R89Up6J8VmoIwcBMrMUYBqRyfHU+oZHxOVUGz
	 kWtlW3jDMNtNs7coOsZJYKBPblA+wZbrkctzNhkWarXHoSO+i347Sl4W2ZSFbxR4my
	 03Dx7GvWIYx5c91gmJU1AJK+X+cOuLbZP5qu5sdhBoigW6k3oN8t7XrROU1XtbKSo6
	 0emJfGVIZ9sJA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F1F4F404F3;
	Thu, 16 Oct 2025 22:27:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C298DA006B;
	Thu, 16 Oct 2025 22:27:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kKLauFcR;
	dkim-atps=neutral
Received: from BL2PR08CU001.outbound.protection.outlook.com (mail-bl2pr08cu00102.outbound.protection.outlook.com [40.93.4.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 17E4922029D;
	Thu, 16 Oct 2025 22:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjHQpfmcPJKJrfKDQoQIGk5X8rPnr1PyRpy1UmoTC6S6uxzIdlZsfD5HR3lPu/mT+PoSP7NxbIdh+siHDCtH/qqgIjTZlhiGY7ACJ6PbFcy6GyUCepjM24QzyUBBVWNp7A2QcOXJKTJXokkTnhUF8KbgZnQKqXWljAW9u4RQRLqbnDR794E8zCuhFzg04uO3hlEe6aQB/a1ODHNbhzN6utUFXYW4FnmvUgcK1mOKP4sgfPCj/80DFmsYWAdK3B086Z6AjqrJ5J7BtzG+4EG3Hdovr0Hu016rIQ4dBtH+JqKtLc6h9UUowLEIbydTpGV1cPvG4B7Ut75VcrKhdp/Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/GcL671HwxH8YBdyx/A3/8H4wmC4eEGbIv3QW7HsY4=;
 b=iGBEYH6HJ4RULhgZl3yYmTjGpKmn4gUZbLn/iNLfP0oUK8F7R/53aKvYAHvqE7Ks1p6kMPGDTV5qkbXcNNf7ZXV7L/9w6esDNyZWM/pddKdopPc9lLrVLow4K9fj616S78Y2zx/Di08uzLrRd0tKgM6y3iJJZ6z++GCRM3nbib6KrjQWTHEI4JF/bs1rSu8s8JJ4yaTC7IZbUUBXyYJhPpZ1fRVbaUnQf+N+qeqxDOskSbohuh8apbdcf+NW6UgyzAiqvuq6qqm2QN0UHR7rqr76AACBJqMF3nV5nZGPIDLvNtsZN+5FMBUFr3Uf/8aVM74+21VDO9ujEeu2oyd5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/GcL671HwxH8YBdyx/A3/8H4wmC4eEGbIv3QW7HsY4=;
 b=kKLauFcRL3AfR3hOBazUN1X1KOpk3jM4uvxnxPLKHhyIy39CpIVRprhHdZiJQPKMhaMj3Ce4seUBWls3uSElpwF0Z8xr6ag5PQCrHmry/zGxHJ2SVc+TjKjiuxHBuHOFGpaiZ3MF3Wski+oxX9vG6dd5gVIH6d6+h0jbVP3eWZw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 22:27:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 22:27:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "caohang@eswincomputing.com" <caohang@eswincomputing.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ningyu@eswincomputing.com" <ningyu@eswincomputing.com>,
        "linmin@eswincomputing.com" <linmin@eswincomputing.com>,
        "pinkesh.vaghela@einfochips.com" <pinkesh.vaghela@einfochips.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Topic: [PATCH] usb: dwc3: eic7700: Add EIC7700 USB driver
Thread-Index: AQHcPoIGBkfc0pQLaUCVW95OEQCHXrTFWwWA
Date: Thu, 16 Oct 2025 22:27:16 +0000
Message-ID: <20251016222713.d2sutc7tyf2idbkv@synopsys.com>
References: <20251016094654.708-1-caohang@eswincomputing.com>
 <20251016094812.739-1-caohang@eswincomputing.com>
In-Reply-To: <20251016094812.739-1-caohang@eswincomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS4PR12MB9795:EE_
x-ms-office365-filtering-correlation-id: bfa6c51f-0588-4cc0-d80f-08de0d032996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHJtQ1B6aTdmUmZCQUt3ODZtRXZkM2lPS3Z3dHlQc01vUVFaV0NVa3plK2NH?=
 =?utf-8?B?Wjd0Rk84cDJlengzUXhKSVJJaGJpRlF3QkJSVXdET3ErSVF6SmpzVkdYSHpT?=
 =?utf-8?B?VExwYy84M3lpeS9BSTVBNk5WSVJaN1RGVWZtSWo3V2tWOWgvVXNMbElWUldh?=
 =?utf-8?B?WFJkSzJZMFJvdGo5R3U2WEFBcjh3bS8zSVBMdGl2bnhFOFk0ZHc5Mjc4N2Vn?=
 =?utf-8?B?YThTaWpvMytJaE10RWZhR1JDUG90SXZ1d21PbG16U2I0bmV1a1c0c2hBQmhU?=
 =?utf-8?B?L2JEZWZhMG5FbER2N3dBSjNpc3Zudzd5VVIrY1I2MDNQMURaQTRmdzBZa2tW?=
 =?utf-8?B?MCsvU2ZJZG9CNWgyUVRZL2VSVlVBd1ZjS2dJMVdVZWV0c1QwbU1mNTFUaDJ2?=
 =?utf-8?B?elpXU05mYTgwUHJIZzBOOEZSS1czR2ZOWWZXUTB5NGxHS1ExUm13Y3ZsU2NM?=
 =?utf-8?B?U2Z4TnYwWG0xbVZxT0lCa0t0SUQ5OGl0eU16VnJ3ODcrRnEwUllhVTRDWldI?=
 =?utf-8?B?WGdmN0xaSDhWenZMa1M4aERpTkJqRWpNdXpsUWtOa1k1aStjTmlEeFc4YzRC?=
 =?utf-8?B?RVRUbVFjVlltSG5FNVd0WVo0QVFrSXZvZGxWLzZMWDJEUWhacUlPM2pZRjNy?=
 =?utf-8?B?L21YU3pDNkNGcUdOZ3NZdWhZZUp0enpGN0VTbllOWFpwbGlHb00vYXU5K1Fl?=
 =?utf-8?B?MEJvYWQvbEdid3JEdStCdmUwaG0xa04zcmdtUFVhN3YxdnY1eEtlOHRwWW9T?=
 =?utf-8?B?aUZXWURFdGtmOUtpS0xPckhuTVBDNWlFSEtGaEdoM1FhY0FlQUNOVExLYVhr?=
 =?utf-8?B?Z3drcU9mdVJ3RFlCS3NRcnJrY0JiWXFSNzJRUXBqdjRMVS9HZDNzSllwQ2sr?=
 =?utf-8?B?TE1aQkwwK2dsZGJ2SkV2YmtOQThHUVF5UFlCVjVWWUY1d1ZwNHhkdjZFV0px?=
 =?utf-8?B?R0p6VnpzNGNrUjYwTHN4OHVXS3JCRlUxOEZOcVMrLzhhZHVmMWtqK01HS2tR?=
 =?utf-8?B?QmtoamlYT0pxWVIzcm1uQ2VnYUkyRVl1S0NibUpMS0YrU3NVaDZwcjNCTmVw?=
 =?utf-8?B?Y3RwRWMydDhmNS9iRVNtK05VWGRQNDlmUFpxZTVKeHFVM25VQ01ZWWRxY3No?=
 =?utf-8?B?Q3NhZDZicGx1UzU4TVJWckVXdmY0T1IyWmRzUTdhWnd3UUNPUTFUellKTUVs?=
 =?utf-8?B?Zmw5Tk1kaGUrdTdlT3YxSG1BdTJYL2lrZExNWWdVOXJmejNEczNpNi9iQ3Q1?=
 =?utf-8?B?WjRKZUVpS0NyRU0vRGIxS0pLMVc4Q3BVOEhiQjhyUC9LS3lvL0pYOWZLRFFv?=
 =?utf-8?B?b1ZpMklXNDlKSVBPbTk1SEcrUVhvbWhkRXQ1S1BlZ3JiaHNOdVRQZHJkWmlM?=
 =?utf-8?B?dHB6eTBRVnV6SEM5VlN6RDB6Vkl5Wks4NVRzbG5hUkxCdVl2eTJMa3pFQkVX?=
 =?utf-8?B?cWhNdUFMa29uR1RvSnpldnM4clFNQTIzTFpnQ2d6RFpNY25sQStLOXlUVDYw?=
 =?utf-8?B?UVpUQUM1eGN0Q0poaEhwMXE0NS9nYllKbmIvS0VFWnUwZ2MvTlJEUlYwWHlm?=
 =?utf-8?B?SnZnS094MTc4UEtSV0RJZmwzb1ZkSzZKSHNlUnh6Nm9kTXZpYUZHNnJqK2t6?=
 =?utf-8?B?YzJEUDBRQmlRZCtkSWRJNGpvdys0bTJDajJtZXFDMEo5Wk1DT0pQRDRmYVJT?=
 =?utf-8?B?bW9lemFQNTl2UUhoeGpVOU9VUW9iSUFPWjJLaytIUUptNG1RQWoyc0dqUUZZ?=
 =?utf-8?B?QjdFeUdaVFlyV01RSkgrdTFmMFpuNTYzdGVIbWJuNXF5TzhFblA1MTNSN3dS?=
 =?utf-8?B?TU9nY0hLVHllYjA4RWJpZC9WRTBNbDVnZkIzNllzUWdkcG5lR0toY2wzd254?=
 =?utf-8?B?Skl3NFJHQlFzYURybnlVUTRIcm5MMWxOZGw4Yk91M3lCaUNJYmVYZGk4bzZT?=
 =?utf-8?B?SU9xTmZIdFJ4VDJPUVlkZWo5RGthaEVQVTVJczZJT3JGcjh0ZWREZ1QwZnRx?=
 =?utf-8?B?VU9TYWQvNTUySWFEU2RxNHB3ZkJ5UDEzeUE3dmQ2WXgzM3M0M1Y2Myt6TGZ2?=
 =?utf-8?Q?zZKjG+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c29HTi9aQXBxdTF0UVE2NndkUUFlUGVDdHQ2aEF4N3lMQ29ZS241QkRXR0ph?=
 =?utf-8?B?VlJBT0UyLzNjZXJhQURiQ09WSWxreGJwSG1ZOFJkYnZCazdKMDlZTWllU0R0?=
 =?utf-8?B?b0YvSVZpVG5KcGhtN3FtZThUM20wMzh2TjZXbGF0cFErY1k2QmxSWnZlc21G?=
 =?utf-8?B?dk8zamd0MVVlRXU2TXhRREN4emszNnlUMjdYZUNUZmpEQW5vVERUZDI4eGFM?=
 =?utf-8?B?cDFJWWNRWFV0aVkxNXRCcHdMVU5WaG9OQ3JkZ2liVmUydkNzUDE0VmVycUZP?=
 =?utf-8?B?QVd5OCt6MVF4ZUdjUDJlN0w3ZDg1bUdTU3FpR0NjcFVnYmdCWjlvYThvNHQ4?=
 =?utf-8?B?cTliTVhLT1dVT2ppT2VTNU9LZGZDSUZpMG9pOFNoN1IybGwwdjJwa3dzMnhx?=
 =?utf-8?B?Y2FsZkF6UWlCUEZlWmVKLy9uMGdlNjBLYWZxaUN4OGNVOU1RZy9BWTZsa2JO?=
 =?utf-8?B?bWhvQ1JSZk9UNlo1YWxrcGZwMUNSQjdkcDdtczZhdXg1eURyOGpwWEhmd0pP?=
 =?utf-8?B?VkVSNFZSREVtOE9yOUxpcnA0WWRmVnRocjdVY0RtWWZxdnQzRUl5ajZaNUln?=
 =?utf-8?B?eHRoRnJMVHdqeXF2ZWN5eXRubm1ldDErQjB2SC9GdVBqSUhzNnFDdWxQVjQ4?=
 =?utf-8?B?YTFmL1pkS2Zybm5KaGoxYi9XRy9qQmhuNDBKSjRNUjczQXNxcmtzWDkvZDZY?=
 =?utf-8?B?WmZaYWZnT2FtUlJKRm0zcWp1aGdWbWFsWEp5MlBSR0c2OVoyRUhOejFkYlRy?=
 =?utf-8?B?NmxsZDhhWmRobVdrNTJ0cmZkdWM2VVl0VDEvVUNnY0h0djNHU1VWSHNCaHRn?=
 =?utf-8?B?bDNHNUdTVkRFNytJUjNMdkJwQ0Ztd0x1NXdQQjBIeERWY2REQmw1V0xTd2pX?=
 =?utf-8?B?RElwS0MxV1FtVWJ3QkljQ3YyZm5KU2pZMCswTFl4VzVJY1Z2MmNLaE04R2lU?=
 =?utf-8?B?Wi9YVk1ubU56S1NjYjV3QW9pb1k2L1E2TVg2c0YrUzBpTElsRTJWMHFNSnRz?=
 =?utf-8?B?RVFsVUkyNTQ2OFdZQm95Z1FUWnB1Y1NzakF2SFJmcDJtU3VXWlFKSEZZWlRy?=
 =?utf-8?B?N2dQaitXREtwRnNKVENxSUhqNGxOTWV5Yzl4dWhXcnlURVRmV2JPVmg4SHYz?=
 =?utf-8?B?U2hMWXZmaXRjRXI1YTgxT2FYTzhnQTZHaWJXa1g4WXNOL1FPU0xUM1FRTnN0?=
 =?utf-8?B?SlRxOUZET2JNUzZGVjVwU2lqMkZyNWpDUDlJVmJMTWU5QXBtU0QySDhWUnRx?=
 =?utf-8?B?T3BJaUU0SWpGMVpRUERpNE15ZVdKeTB1ZzM0MmV4Q0ZmQUU3ajkzMmZzMzdw?=
 =?utf-8?B?Smg5aGNkSWEweWdoMEpDNnpETUlneXh5UERhUGp6R0tqSUF1Q2lNcjJ4aGho?=
 =?utf-8?B?SStjcjBaaFo4Q2tZZHphUTNYaGJmalJSOEQxNWMyQ081TTJ4Y0ZqdUNGMUNC?=
 =?utf-8?B?emY1cnhVVzQ0WTNYUHpYYlZJWFV6UExiTzBPcmswZEVhdWpnZDZTRUVFTGw1?=
 =?utf-8?B?UGlqUHZjTkJEMFJpYXFTSGZYWG5UYUZySEhCclEyRXFzYVI0QzRnZExCa2gx?=
 =?utf-8?B?SFFtVXVxUWVyRWMwcWhsa0RKbmUyKzcwdWpZOGZkdERkS2JJdWZqRDAzMUc0?=
 =?utf-8?B?UEZ1Lys3WW1zNGdnZmNVUjA5OFVDQTQ4cUIwK0NJMGxEUE12S3FiMVNPM2Jk?=
 =?utf-8?B?TENXcmk4Q3NCRDlaUmVFWm9tY3hkZ1plaXY4QitjSWFBYmtxWGxqU2UvK2lq?=
 =?utf-8?B?UFlMNmFzVGppSmgrYjU2VTVrNUZGd21yd0tXUWRIZEtPNUxQWm9rS0ZmdkFO?=
 =?utf-8?B?Y1lYNCtIY0tiS25rdUtBR3d5ZURyWTlieWhGS2ovTzh2VXExV2paTjArMnVx?=
 =?utf-8?B?a25XSkFBRmk4NW1makJtdFdsWnBEcEd3ZWtCV3FLUkF0Qmp6WEJLNFBhRENU?=
 =?utf-8?B?UmFXc1VObUZ3S0tRNi9qd1pOQ3YyMGhnOVNEY1ByMm4xb0g0WGNFdWZHOFpk?=
 =?utf-8?B?WEo1YmhhUEZPRFVBVHQ2alBvVlZlUzhnalBvNEZLaXgxS3lOUTN6S1Q5aFl5?=
 =?utf-8?B?N1lSWHVKUkZucWdqc29nSTd0ZytoRUdCT3NxREdzaUpMemFwc2plWk9YN1hh?=
 =?utf-8?Q?wE1RuGTfb2/WgoQqNLz76dPPp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F190A09C52E83448301BC5660E19584@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SvkwJ9Di06KCVk5wuz9Gzwznrvmyxzxa5pb4kRadupMa+tfKWaulniahN0ost6W1W5GXFcwy8gqTHd86qmP4hy1oe+9kypnRVHXmxYPaLZsvwtVekM2bRLMtJi5BIv42p+JREPVYWbJP1zIRwWdKUOYrMZ8eLLFg17RpoLwZ1WjfKgEAJ2/VCDgsDbQtaUudNS2f35c+VvFWkKYdZJTDvG0gLxBOba1DRAb0KaSxBsowLpOC1laY4jUmnWFAzKSsl29AvUkrzFYJGPkOuY5niK3U0a+e28kWgC5UjcB69xbllFFdYBeSeaad4kbSx8StWhNemGrOzrM1QdEFoo44pgOCyBQwGgoo64+xaugdf2Gle0eNcSokysKmEv+AasQBjxb/gRZrMJ8UiT/2IR5YLUZkbXVtBDfm3Pzkahh0anQGmFnf06D3mh62JXfvvN8UtjpKXNzhRxltpaE/ZNIwUIvcmEynYBTLBpsL+M4rQ0WzpLTlQoSj5BQ45n+yegbpG4eFCAHlk3HglIbQ5Qe47j1fSnDcyxDzScvVAB42BwOMbrwfke4ydo1vdp8p43ebHNXdB8GUSVKpyBPPJQs+TdTk8iISIj8t2mIvUbGI25hGGNypA6Ao4mIwxIElwV6KQwMYwxCV/xyavBYBCX/+yw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa6c51f-0588-4cc0-d80f-08de0d032996
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 22:27:16.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOaXS/4EBgj+d3an1RzJVlwKyIClUHGuB03OyyrlvGIU46C93A7xsH8sDPCIDoRZKepBqm6Jmqxv4QEIpzENhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795
X-Proofpoint-ORIG-GUID: sEuFfPRpa8pAOoRSV3qYacjDqilwjDBT
X-Authority-Analysis: v=2.4 cv=OOcqHCaB c=1 sm=1 tr=0 ts=68f1714a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=h4SL0BZ7AAAA:8 a=Oowl1o8BJeJ1nK25Ts0A:9
 a=QEXdDO2ut3YA:10 a=Cfupvnr7wbb3QRzVG_cV:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: sEuFfPRpa8pAOoRSV3qYacjDqilwjDBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNiBTYWx0ZWRfX8+nHApnmNSNR
 BOUgVfimLCNTC+3YIQ96YpydsBrKriURzUlZpch2crcy7p0m5EcKQu8jwC/+5pf/Q+AC8RAuF8K
 +f0mgo/2xvWLyYnBHnSM/MKhmej2gilC4nvvwUQiQf7X+G3S5vhYDc4y++yFqWUAbkBcwz1/t4K
 Z3HuXAuvz9EBduBz7qsqIAWLCdOICJeBcc5PnXRbHDBrKDW9kTUdrrO0AwFGDJL0/hIcH46689i
 TWdo+QzLW/2GHjXAonHT5Ycvg72YbcqwI/DiRUke3mI+jGo0EysUfn1m9rRdLt1hdGUKTsjBzo1
 pMUAE5eXx7LTSijifiZOJNSKXrohhRFq5pOYcM++q4f47vGis9v1kNEtCl0CcJdqF7fgrSkNcSC
 9bSg2zzhMT1Ya0+qP4yWjRa7IRkrfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2510020000 definitions=main-2510140116

T24gVGh1LCBPY3QgMTYsIDIwMjUsIGNhb2hhbmdAZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOg0K
PiBGcm9tOiBIYW5nIENhbyA8Y2FvaGFuZ0Blc3dpbmNvbXB1dGluZy5jb20+DQo+IA0KPiBBZGQg
dGhlIGVpYzc3MDAgdXNiIGRyaXZlciwgd2hpY2ggaXMgcmVzcG9uc2libGUgZm9yDQo+IGlkZW50
aWZ5aW5nLGNvbmZpZ3VyaW5nIGFuZCBjb25uZWN0aW5nIHVzYiBkZXZpY2VzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogU2VuY2h1YW4gWmhhbmcgPHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5nIENhbyA8Y2FvaGFuZ0Blc3dpbmNvbXB1dGluZy5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLWdlbmVyaWMtcGxhdC5jIHwgNTgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJp
Yy1wbGF0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2VuZXJpYy1wbGF0LmMNCj4gaW5kZXgg
ZDk2YjIwNTcwMDAyLi45ODQ0OGJjNDM0YTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZHdjMy1nZW5lcmljLXBsYXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZ2Vu
ZXJpYy1wbGF0LmMNCj4gQEAgLTEwLDggKzEwLDE2IEBADQo+ICAjaW5jbHVkZSA8bGludXgvY2xr
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvcmVzZXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ICAjaW5jbHVkZSAiZ2x1ZS5oIg0KPiAgDQo+ICsjZGVm
aW5lIEVJQzc3MDBfSFNQX0JVU19GSUxURVJfRU4JQklUKDApDQo+ICsjZGVmaW5lIEVJQzc3MDBf
SFNQX0JVU19DTEtFTl9HTQlCSVQoOSkNCj4gKyNkZWZpbmUgRUlDNzcwMF9IU1BfQlVTX0NMS0VO
X0dTCUJJVCgxNikNCj4gKyNkZWZpbmUgRUlDNzcwMF9IU1BfQVhJX0xQX1hNX0NTWVNSRVEJQklU
KDApDQo+ICsjZGVmaW5lIEVJQzc3MDBfSFNQX0FYSV9MUF9YU19DU1lTUkVRCUJJVCgxNikNCj4g
Kw0KPiAgc3RydWN0IGR3YzNfZ2VuZXJpYyB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldjsNCj4g
IAlzdHJ1Y3QgZHdjMwkJZHdjOw0KPiBAQCAtMjAsOCArMjgsNDEgQEAgc3RydWN0IGR3YzNfZ2Vu
ZXJpYyB7DQo+ICAJc3RydWN0IHJlc2V0X2NvbnRyb2wJKnJlc2V0czsNCj4gIH07DQo+ICANCj4g
K3N0cnVjdCBkd2MzX2dlbmVyaWNfbWF0Y2hfZGF0YSB7DQo+ICsJaW50ICgqaW5pdF9vcHMpKHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+ICt9Ow0KPiArDQo+ICAjZGVmaW5lIHRvX2R3YzNfZ2VuZXJp
YyhkKSBjb250YWluZXJfb2YoKGQpLCBzdHJ1Y3QgZHdjM19nZW5lcmljLCBkd2MpDQo+ICANCj4g
K3N0YXRpYyBpbnQgZWljNzcwMF9kd2MzX2J1c19pbml0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
K3sNCj4gKwlzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ICsJdTMyIGhzcF91c2JfYXhpX2xwOw0K
PiArCXUzMiBoc3BfdXNiX2J1czsNCj4gKwl1MzIgYXJnc1syXTsNCj4gKwl1MzIgdmFsOw0KPiAr
DQo+ICsJcmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZV9hcmdzKGRldi0+
b2Zfbm9kZSwNCj4gKwkJCQkJCSAgICAgICJlc3dpbixoc3Atc3AtY3NyIiwNCj4gKwkJCQkJCSAg
ICAgIEFSUkFZX1NJWkUoYXJncyksIGFyZ3MpOw0KPiArCWlmIChJU19FUlIocmVnbWFwKSkgew0K
PiArCQlkZXZfZXJyKGRldiwgIk5vIGhzcC1zcC1jc3IgcGhhbmRsZSBzcGVjaWZpZWRcbiIpOw0K
PiArCQlyZXR1cm4gUFRSX0VSUihyZWdtYXApOw0KPiArCX0NCj4gKw0KPiArCWhzcF91c2JfYnVz
ICAgICAgID0gYXJnc1swXTsNCj4gKwloc3BfdXNiX2F4aV9scCAgICA9IGFyZ3NbMV07DQo+ICsN
Cj4gKwlyZWdtYXBfcmVhZChyZWdtYXAsIGhzcF91c2JfYnVzLCAmdmFsKTsNCj4gKwlyZWdtYXBf
d3JpdGUocmVnbWFwLCBoc3BfdXNiX2J1cywgdmFsIHwgRUlDNzcwMF9IU1BfQlVTX0ZJTFRFUl9F
TiB8DQo+ICsJCSAgICAgRUlDNzcwMF9IU1BfQlVTX0NMS0VOX0dNIHwgRUlDNzcwMF9IU1BfQlVT
X0NMS0VOX0dTKTsNCj4gKw0KPiArCXJlZ21hcF93cml0ZShyZWdtYXAsIGhzcF91c2JfYXhpX2xw
LCBFSUM3NzAwX0hTUF9BWElfTFBfWE1fQ1NZU1JFUSB8DQo+ICsJCSAgICAgRUlDNzcwMF9IU1Bf
QVhJX0xQX1hTX0NTWVNSRVEpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0
YXRpYyB2b2lkIGR3YzNfZ2VuZXJpY19yZXNldF9jb250cm9sX2Fzc2VydCh2b2lkICpkYXRhKQ0K
PiAgew0KPiAgCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGRhdGEpOw0KPiBAQCAtMjksNiArNzAsNyBA
QCBzdGF0aWMgdm9pZCBkd2MzX2dlbmVyaWNfcmVzZXRfY29udHJvbF9hc3NlcnQodm9pZCAqZGF0
YSkNCj4gIA0KPiAgc3RhdGljIGludCBkd2MzX2dlbmVyaWNfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIHsNCj4gKwljb25zdCBzdHJ1Y3QgZHdjM19nZW5lcmljX21hdGNo
X2RhdGEgKmRhdGE7DQo+ICAJc3RydWN0IGR3YzNfcHJvYmVfZGF0YSBwcm9iZV9kYXRhID0ge307
DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gIAlzdHJ1Y3QgZHdjM19n
ZW5lcmljICpkd2MzZzsNCj4gQEAgLTc1LDYgKzExNywxNCBAQCBzdGF0aWMgaW50IGR3YzNfZ2Vu
ZXJpY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXByb2JlX2RhdGEu
ZHdjID0gJmR3YzNnLT5kd2M7DQo+ICAJcHJvYmVfZGF0YS5yZXMgPSByZXM7DQo+ICAJcHJvYmVf
ZGF0YS5pZ25vcmVfY2xvY2tzX2FuZF9yZXNldHMgPSB0cnVlOw0KPiArDQo+ICsJZGF0YSA9IG9m
X2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiArCWlmIChkYXRhICYmIGRhdGEtPmluaXRf
b3BzKSB7DQo+ICsJCXJldCA9IGRhdGEtPmluaXRfb3BzKGRldik7DQo+ICsJCWlmIChyZXQgPCAw
KQ0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gaW5pdCBv
cHNcbiIpOw0KPiArCX0NCj4gKw0KPiAgCXJldCA9IGR3YzNfY29yZV9wcm9iZSgmcHJvYmVfZGF0
YSk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJm
YWlsZWQgdG8gcmVnaXN0ZXIgRFdDMyBDb3JlXG4iKTsNCj4gQEAgLTEzOSw2ICsxODksMTAgQEAg
c3RhdGljIGludCBkd2MzX2dlbmVyaWNfcnVudGltZV9pZGxlKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gIAlyZXR1cm4gZHdjM19ydW50aW1lX2lkbGUoZGV2X2dldF9kcnZkYXRhKGRldikpOw0KPiAg
fQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGR3YzNfZ2VuZXJpY19tYXRjaF9kYXRhIGVp
Yzc3MDBfZHdjM19kYXRhID0gew0KPiArCS5pbml0X29wcyA9IGVpYzc3MDBfZHdjM19idXNfaW5p
dCwNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2MzX2dl
bmVyaWNfZGV2X3BtX29wcyA9IHsNCj4gIAlTWVNURU1fU0xFRVBfUE1fT1BTKGR3YzNfZ2VuZXJp
Y19zdXNwZW5kLCBkd2MzX2dlbmVyaWNfcmVzdW1lKQ0KPiAgCVJVTlRJTUVfUE1fT1BTKGR3YzNf
Z2VuZXJpY19ydW50aW1lX3N1c3BlbmQsIGR3YzNfZ2VuZXJpY19ydW50aW1lX3Jlc3VtZSwNCj4g
QEAgLTE0Nyw2ICsyMDEsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGR3YzNf
Z2VuZXJpY19kZXZfcG1fb3BzID0gew0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBkd2MzX2dlbmVyaWNfb2ZfbWF0Y2hbXSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0g
InNwYWNlbWl0LGsxLWR3YzMiLCB9LA0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAiZXN3aW4s
ZWljNzcwMC1kd2MzIiwNCj4gKwkJLmRhdGEgPSAmZWljNzcwMF9kd2MzX2RhdGEsDQoNClRoaXMg
ZGF0YSBpcyBmb3IgZHdjM19wcm9iZV9kYXRhLiBVc2UgdGhpcyB3aGVuIHlvdSBuZWVkIHRvIHBh
c3MgdGhlDQpkYXRhIHRvIHRoZSBjb3JlLiBXZSdyZSBhbHJlYWR5IGluIHRoZSBnbHVlLCB5b3Ug
Y2FuIGp1c3QgY2hlY2sgYWdhaW5zdA0KdGhlIGNvbXBhdGlibGUgc3RyaW5nIGFuZCBkaXJlY3Rs
eSBjYWxsIHRoZSBpbml0aWFsaXphdGlvbiBpbiB0aGUNCmR3YzNfZ2VuZXJpY19wcm9iZS4NCg0K
Q3JlYXRlIGEgbmV3IGZ1bmN0aW9uIGR3YzNfdmVuZG9yX3ByZV9pbml0KCkuIENoZWNrIHRoZSBj
b21wYXRpYmxlDQpzdHJpbmcgYW5kIHBlcmZvcm0geW91ciBpbml0aWFsaXphdGlvbiB0aGVyZS4g
SGF2ZSBkd2MzX2dlbmVyaWNfcHJvYmUoKQ0KY2FsbCB0aGlzIHByaW9yIHRvIGR3YzNfY29yZV9w
cm9iZSgpLg0KDQo+ICsJfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07DQo+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBkd2MzX2dlbmVyaWNfb2ZfbWF0Y2gpOw0KPiAtLSANCj4gMi4z
NC4xDQo+IA0KDQpQbGVhc2UgcmViYXNlIGFnYWluc3QgR3JlZydzIHVzYi10ZXN0aW5nIGJyYW5j
aC4gVGhlcmUgYXJlIG5ldyBjaGFuZ2VzDQp0byB0aGUgZ2x1ZSBsYXllci4NCg0KQWxzbywgdGhl
cmUncyBbUEFUQ0ggdjQgMC8yXSBoZWFkZXIsIGJ1dCB0aGlzIHBhdGNoICRzdWJqZWN0IGlzIHBy
ZWZpeGVkDQp3aXRob3V0IHZlcnNpb24uIFBsZWFzZSBmaXggdGhhdC4NCg0KVGhhbmtzLA0KVGhp
bmg=

