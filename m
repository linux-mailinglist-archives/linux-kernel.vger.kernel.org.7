Return-Path: <linux-kernel+bounces-877311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D00C1DCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A89C189C96A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39E328B40;
	Wed, 29 Oct 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d8PvFMXY";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Dv/Xa0Qw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a46vfinj"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961D32254E;
	Wed, 29 Oct 2025 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781676; cv=fail; b=dOqCi6+tHxUw1GphDMI0GKHfnC3ZnoHT+Lcjrv7VB5uoFg2h6ICtbY1Vvm/F94pCGelPbkolwP0G8Ab8T6afIemNzOMa6plf90QoOTfofdney2uefnG6gMQNsCudn3ec+guuDh6YBiwIIfZjDykq1uJVoAggEGE7tb5cevzCsjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781676; c=relaxed/simple;
	bh=8C74rz47q4OEDgLkQgVFMWXIPK5tzz3UCxBT79UPqvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a9NQJ6RocTdtdOIJ1HUUOymCf5ly7/k4KPnyk4+lYl3gmStiGeAVBOJ+ot+IyV2ITaNoNYROKjjPIpysbyVzqPPT2fKQg1c8FpXrORVfqF1TO21RPGTkZMlxuCh3hEeDhA3LmP9gQl+EJhxrHZ86S59V/5YQUaK+c+gLiafiJqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=unknown smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=d8PvFMXY; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Dv/Xa0Qw; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=a46vfinj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TIPBlw4046115;
	Wed, 29 Oct 2025 16:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=8C74rz47q4OEDgLkQgVFMWXIPK5tzz3UCxBT79UPqvg=; b=
	d8PvFMXYYJktAbGTM6RAotUpIdfQYVrzA+FGrfOQFD0K3eKouOArLSpYHGlvsJsg
	z0RL9cgYBt0XjRhj2FNoVU18MEVTeGARNU4JJLHmyqKZPKozgbGQ7qhwMs9iIIMp
	PV8uuGzB+K3cwre0HtXOphW9WV2iXHH0QyorSK9WkQXsb8KIFTPQkXnK6CZ/W7+y
	b763dxCH/p7k4abVjq2Wn5nN95dYbF4a4GQAk8m3+yZzJdoiEaHHnVsM8Wf+t8Uk
	tdAQFIImFhNM36dsiS3YrZxmfa8DUVP37IsUY1IyD2Q4Grm0+sYZMEkG9IahA9do
	iBrpiZBkcX7UJJJIR5LLgQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4a349fy4cu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1761781658; bh=8C74rz47q4OEDgLkQgVFMWXIPK5tzz3UCxBT79UPqvg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Dv/Xa0QwFmSlO9ZRAVuNoVVqL8HUlburu+YL5S6c3jP0UYqk7rxv43HJgbtO+xIt/
	 tzTF2lmYfF6wXXr9SWFRiO5GKzM7fFy1mPYBlUNtyY6XzpONJaFDDi5Feli/EDVb/Z
	 mJ6/kUJ/4uq6w/vigXqaaOYFVXXKbMapY7TP5LjOM1hciv85glx93qT5Dhy5d6zYVv
	 Hu8+Ejj0Yv9eX7muw//yFh0+Vq+kE4hRMzc2KuezbYff/kP5QY1AfbU62pIbCZBROc
	 f87EGfPUdRjVA9J9wObAZSQOOp6nEm6e4iG+qlS/aIySbNySv7PxU5yWwPZjcpimMg
	 Sv9ZxeAq81rzA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6721640141;
	Wed, 29 Oct 2025 23:47:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2E1EAA00B1;
	Wed, 29 Oct 2025 23:47:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=a46vfinj;
	dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com (mail-bn1pr07cu00306.outbound.protection.outlook.com [40.93.12.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 451EE406E8;
	Wed, 29 Oct 2025 23:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k08J2MHOEpuxvOHBBL65XlISiz/jJY82eTwufaISdJBc9XKYdhSK5x0cDBf47kaJL+rcA6jDO6pXLmNoP2O1dEgFz/klUp0h/R5IYEaEQHl1rxEXdwMuJaOSTC/i1UwJybYvTahfGIDFBUpw9iJTMMSnHrZKnqs0aZZqH7PaeP2TZgRLeZemdwsR69flZvq9iHGZxozEoVX4paRiC6SJKsAfOEdPUGjo60MuEZbqp4LgxhAxPtdx2+AQQH11cseQAF42W/yGa4ZoIt0C4aPC4zVper8WeMTf0UZBzJKEDb9XDM6Giksca9cJVOIg4W7IdI67WifRpZPhNRDC+VObqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C74rz47q4OEDgLkQgVFMWXIPK5tzz3UCxBT79UPqvg=;
 b=yQe/0O51Ph2IuagAHttHVlQIb3rLUEzWac0OEC5RQtpz0DSiR3g72IWG8PRJRF/VHTZ+nR2K3ivXp4J8P/cBD3s3cAG20jc7scTEe30oQVrAKq2c9PoUDNJWP1au6L6PShJsC4lxFq3LbJdzx/DEb8yGzNYYejlZ4xpkGwvWxihn2hiYCtBQzyDiZhVZtZURdBXXwwzYUixgZ+O7O6uRb5KfNX1JwSycH1hnM4LsOKw2gfWrsthDe+zQ9CEcdnQ+Vmr81XV9Lu8AQGcLHAwwhZ1EDLoMjAWfjC5FKx9LMcba71m8kjtT5NcEb9zYG8kSYKJAhQaS/O+KnV40UdoDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C74rz47q4OEDgLkQgVFMWXIPK5tzz3UCxBT79UPqvg=;
 b=a46vfinjBhtFUztRrXvkjv/1ZDh15mof9NpCQUVCQ2iNkYvm9QmIamlpPlufWlIZyqmcBvTj1KG4IXS/RPu/spE/B+QstqPfNZqDrdrmzA63s7MenjX1/cjFgyQYBEaEgn2NFxAUghEixL9VunoGpuVq51YneK+s4oWBGR1Doj0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 23:47:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 23:47:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Manish Nagar <manish.nagar@oss.qualcomm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix race condition between concurrent
 dwc3_remove_requests() call paths
Thread-Topic: [PATCH] usb: dwc3: Fix race condition between concurrent
 dwc3_remove_requests() call paths
Thread-Index: AQHcR+G5zez0RKsXjU2awYETywqYDrTZzPwA
Date: Wed, 29 Oct 2025 23:47:33 +0000
Message-ID: <20251029234724.pg2icfi3a63ojsxn@synopsys.com>
References: <20251028080553.618304-1-manish.nagar@oss.qualcomm.com>
In-Reply-To: <20251028080553.618304-1-manish.nagar@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS5PPF78FC67EBA:EE_
x-ms-office365-filtering-correlation-id: 1b2d2dbc-2458-4c4e-21f6-08de174587f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVM3K29KWmxBWFJvZ1B5OFRzREVxUFBZTFNlT1l6dkliNHk2c2orZ1RRV0pu?=
 =?utf-8?B?Z0RvMTdtY1VOdEZNNWpDY3FJOFMrM3NwZGI2U2IzUDNnRkRlMnpMWDFvV09M?=
 =?utf-8?B?STh0bENPQWR6MWxRRnVVa3NnUVlpT3lqS3FodG9mZzdwa1g1TURYaExHWHlj?=
 =?utf-8?B?RG9LeitlL2xicS9CUjVXNDhWWFhzUVVXRGZ1SlF2MVBaR3I5cHN5R1lvVzFP?=
 =?utf-8?B?NnpVVUpONHpENEhQTHROazVZdVZQZ2hjZzNrMXhUZGlmMmdyTzROZ0lkKzUx?=
 =?utf-8?B?YkFLNVNRMEVzSWpKNmp1L0txVytTUkliZFhyUHI0cGlybG4wMmp4YzhyZ1FQ?=
 =?utf-8?B?NVhEcUlJeW9oL3JJRlQrU0dUMEFoclVabEQyQ2pwN1BlVmZ2bmd2dnlWM1M1?=
 =?utf-8?B?Y1k4RnZJSUNZUTBzSDVDejNXYmJFdmhDSGhVdEFuTnNUVmNuZXMycGgydW42?=
 =?utf-8?B?cWthNzJmblRtYmRQUG82dmpuL2t1dEVwZFBqZ0o4cnFCSVZMYVlaLzloeUN2?=
 =?utf-8?B?VTFEZFJwVzZDeXozZUFuWnlTc0NrbEFvSy9ybDNGQ3cxTTJ5Wk5KUFNoUVpr?=
 =?utf-8?B?ZlpCVDJ1L2NJM1dXSkRnenlIMG5HMnZoamtDZkxoNFduQXliMGlYV0hZZDdC?=
 =?utf-8?B?a2lwN3d2ZW53ZkhjZVlNU0VYZ2lTd0pjRDdmanlrSURWVDBoaWorQklIY3JM?=
 =?utf-8?B?MnU2azBDYVdSNituNkkyRE54VjB5Z1RHaTJ2dUdkTUtUUitZTVh6VGp6UzRj?=
 =?utf-8?B?a3lxemwzcVZmRmxOS3ZCZTdZL0ZBMVhydm9VempURnZ0L2RabGp1OTZnS2x4?=
 =?utf-8?B?bzJ0VFp1UURkeVpnUEZJcHl6TXVRUm82VDBHck1IVWM5bkxKaFhlUzR5cTJ2?=
 =?utf-8?B?L0R1bDNuSGUzNXU3ai81WHk4U2pJbnIrUWgzNkNhLytaalhJZUJ2TkZ2U0Ju?=
 =?utf-8?B?QWZOWG5waDFpZUhFWDdCdEIrWWYzTmtBWDd0RDNGRCtJWC90bSs5K1JjVGlk?=
 =?utf-8?B?dFdIZGxPTXlmYzhFNWdxd1RzMkM1RnJmejNWay9FMFhrUDVWZm9JMVpEQUdZ?=
 =?utf-8?B?c2tPRUNTM2JiTHRxb2VhREl4UTRPdHlRYVB6S3h6OGhhV0JHSGxOWGl3b0Rj?=
 =?utf-8?B?OHo2cHBYZ0trNFRsVTMzejc5d1hNcGgrcEFYZTZJZHByak9pSjc3TjJ1empN?=
 =?utf-8?B?eXFkR0psanl1M0QyNHZEMWcvZk1LaEFXWTlGM1NrOXZGUVdGYURpdDRhdGNn?=
 =?utf-8?B?S0RmZHpKbitPYlVrUVN1QnV4V2NWUjVEUXdBWkIwMm9MUzlhbUxEZ2ZaRkNk?=
 =?utf-8?B?Nzh5ZkFmYmdSS0pIV0hEUGdRQUNXYUJReGxEZ2pYSDliV3NTa1lVaFkzbEpo?=
 =?utf-8?B?UnpoUHhVRTlPOGdKYnNObmp6cUsxRkpVT2lVbmxHUGRuSnRkaEFDdnhPdXRH?=
 =?utf-8?B?ZlY4S2lmRHJKaFlpeVNsZUtuQW1PK3REeTFHbXMzNjFDeExpUTZramhWZFc2?=
 =?utf-8?B?RFN5SFZXQzdrYllKTm9KNXdkTVBGVGEzOEs1OFlqSmlkMzAxR1ROMkcyZTVW?=
 =?utf-8?B?RTFNUTQ4MDM5OStLc1NEU0pwNk05NEt5cURmeGpRK20vaFZRMnoxQmRnL2tZ?=
 =?utf-8?B?cjlnZk93emRGbXVGT2ZXYll0TmoxTzMzWkpmNmthZTI4cG04amFLYWhyMWdi?=
 =?utf-8?B?S21OVWtIVnhmT2E2QmIxWnJsMHErVTJUbWEyTUlFNHhueWdyZm5Ra2F2U2ho?=
 =?utf-8?B?KzlJclJsbGZsMjhreHBHK0Y1VzVUSC8vZ2NPbnNyWk9UZjRQLytNWVFzTEYx?=
 =?utf-8?B?THArYmk3RzhHZS92R0tCN0VXelhIRUF5dXNFRkQwRzhuYzI2ckROUWhTR0g5?=
 =?utf-8?B?bld1cnJwb1dYdkdyS2xPbVJySU9Icm5hRWFpZFpORlpTQncrSGJ2eUVhdS9r?=
 =?utf-8?B?U1NjY2VuaWN4QTJwcFo1Wmk4c2hZTExFY3lXNmR3SjA1VTZJc0VqT3E5SFh5?=
 =?utf-8?B?TFNSM0pNazB4aHE5YUR0N3lwblM3RFJ4eEVOdVUrdGlmTDd3cHp5OHdLVmRo?=
 =?utf-8?Q?JiPx1v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE0yRHBRbnVUZDYrRVQweWtyQnlNZmh3RUR4NzVndXlMc1VNbXd6aEJSUHJI?=
 =?utf-8?B?UmVJYVdvbHAyZ3dCeWQxRktmMFAxOTZsZ1FicHR3bC9SVDd1a2tUdjBBTXlG?=
 =?utf-8?B?UnkrMEtqTXlVL09xbENHRnRjMWlGdlhyMEY5a0NsazVuQU9EdS9TaEhmZ2h3?=
 =?utf-8?B?UmR3aVNheE9uZzR4UzZjNVJJZU5BaWNnTjVIZDhWVHVBekdXTG5QNm1oaTBu?=
 =?utf-8?B?UlJnc1ZnZkNFamh1aGhBNkZkUTFLcUVRKzZOSGVBTjVhUlRiTDdGRksxTDdT?=
 =?utf-8?B?THl0MTJHWDRLUkg2V3VUZ2w3UmF2aUc2eVoyWXJ0emkzVFJJTC9CUWt1a2JT?=
 =?utf-8?B?VmE3emNQTlRLOVE0ZC9oY2g1YjFTOEU4V3pCZnEva0Z2dnFnUVUwVW5hU3Js?=
 =?utf-8?B?S2hHTnk1WjhiR1A4R2I1YUtwc2hNVnlIV0p1Q1VDWk16RWFOYzNQclg5bnFi?=
 =?utf-8?B?a0hWU2d4cnZOOGoyRjloNG1LYmFtRGQ3SzQ5RS9RMTgyeWtMNFRaelR1RVlt?=
 =?utf-8?B?dm81cjhrS2VVZmdMV2FlbzBBVy9UdWxpZy9mLzhnRTdId3c1Tm1GaHF4VnFj?=
 =?utf-8?B?MEk2ZGtqbmpiRUw1dWdUcG83a2hWNGhzUUtWR2YvajJzOEFZT2N3ZUlmOHZ1?=
 =?utf-8?B?TWtjMGcxVGhDTlJXTzF2aE9QN1hnR2crSkkxc0s4Yk02cmJYbVU4d0ZwWXNG?=
 =?utf-8?B?QThPMjFaZnlDcmU3dm5ZTS9XUXVuZmsrTndPZkhDSHJvVVd0ajdOaDYvaTZP?=
 =?utf-8?B?ZlljYlNtNldVMFZpTVhic0FMUWU5RmEzOHpuUWtqZVBtUWFFUlJXa3FweWpS?=
 =?utf-8?B?RVdUWmY4MmZ5bk9pZDJuOUptNlJUT3ZuOXZGMEMvN280YVIydFBQQWRoMVBQ?=
 =?utf-8?B?Smk1UTQ0MXJpU05pU3UwT0gvMjIzYW1kZCtRTW5JTThHRzNGTVNNV2lYNXlC?=
 =?utf-8?B?Ni9xUjZqeitEdWNYL2N0blJIVG9CZ245UE9LQ3NVdElmRVZ4K2lsRVE5ajRY?=
 =?utf-8?B?ZE8yVm90bUl5VmI1R0lEdExCVW5mWkVVNFR2VUlNUWRyZFpsdk00SWthaGhu?=
 =?utf-8?B?WUNzci94ZmJtZHVndGJnMFo3blNGck1RS1lPQzJZbU0xdm94QTlHSFJRZ1pV?=
 =?utf-8?B?cm1PK082UGhqaUcyZUU3c2J1MTBtSExjbHZLM3NuOSttSkVQa0hBVFQwczhi?=
 =?utf-8?B?d2ZjWmEwcDRLRGRiZnExSzJkUVVHSGxueFUzdDd4TThDVW1ENzFJWXlEbjA5?=
 =?utf-8?B?WHR4VG1rMXBmSW5FTFcxNG8waVRES0c1QWRtQThDejdYSTZkT0VBNTV2WXIz?=
 =?utf-8?B?R1RISDJPTndJS1k5dVQzQ2FxN3pKS1pRZ1Bjd1V3WSttZUNpSDFUSnI3VWVy?=
 =?utf-8?B?bHdCWHFCaVNob3VIdDNqUENlRE1MbktkTGZGbGpOYkRtZ3VTcUl6ckE0UzQ4?=
 =?utf-8?B?d1IwY2x0MHFSbHBKSmZLdXh5ZldYWTVPdlI5WTNGUTVIK0VpbUltUGYxaDQ5?=
 =?utf-8?B?QVpxRlUydit2NTdYN2RKRGltOTNhSlluM1R6NFNwQkxCNVpsM3JmclluejhZ?=
 =?utf-8?B?K2NPU1plVVQ0RHNnQk03YjU2YkdWOVpYU0d1UzBqTGtZRkVnNzFlbFVBTkdq?=
 =?utf-8?B?c1ZOcHMwV3NMMEFwR0h6b2tDV1ZJT1BDckh3QmVENmtTVnhVSHlaRUlERThH?=
 =?utf-8?B?S3M5dTUycmhSOGNEMVl5a2V5Mnkzbm84Qm15YURwa0lTSnFhdFJ3SlBseHho?=
 =?utf-8?B?aXExRzdWRm9LbmJtZSthMDVFczBPUHVHTkppZUl5ZmFqSjJiQzRJZ0gzZ0NY?=
 =?utf-8?B?Q3JEUTNyRGxZYWR2a1RPZ0RJYmhGckc5Z0VabHZES0l0Z3R4b1M4anh3Skll?=
 =?utf-8?B?bi9TLzQ0eHMvVXZLd2x1anZsaTk3dnlHaXRnRHZFb25SNU05U21jTzAzMmVp?=
 =?utf-8?B?OWVLT25HeFJzMzhiMGhsSjQ4VkZIeWxpbFkyTjJxekZMRzJ3bDlKajFwM0RO?=
 =?utf-8?B?M3ZhZUEzTDdUMzBLcTU0ejQzaXpGTHZMeUsyZmNWbHFTcGsrQUhBbThwcmlk?=
 =?utf-8?B?STJWeDB1NnJ3VzBzNm1laG5SYTRrY09mUmhCeHFJYitXM3o2dkszSy9vNkZ1?=
 =?utf-8?Q?pEoDs8uqaqfRlGmKWlyLvJm+H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDED639F4BDDB14CAA243C08201332BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T1mGn5Ev+Fbv3JWs0YErOiPwcAUqL8PmBeEfT/YD7imEUMpzpkWyfHLGuBlq+VHu+WgWaK5+OQqaJvnH3YsM9kHTj1x9jYCBveCqqx3E/fqORYhsTAOF/6CkUiVqsCzW4ZrKseXB34jq49DgfFQbiYmDTU6zY/LKHSrfJ2opJpXe88qzMpBVTvsTnb/qIg2qRlSfjdaXQjnmR4ata0f1l4khFatkRsatcb7A+ymJSVGsDrW6SVuRzK9PKG4BI6mPsiWRUI32Qi83kL5xlEBnul1VOyZIQb0UjuNQnrdxAHtOgvbWuMEFFKxevvLF4nROR/cS5a6T++EdqI0ms4IfGukzAMB9YqCsUNehS7KX109NFOX3ivBPQ51hK/RQFQtbWN5st0DO+KeZq78KBg4aAprMGGtnKZcIey4MplAPzLX2cKgtXhJE1LmqWuKSx6iHtWGCCs63K86+dEDM80RRb/LTwzHunpO5EZ2Jgq116udjE9PUrI1H6UWnu0hRRijMli6mhOgueum/7sJ9gVxAm+KWgKA6r5XU5hwt1gOX3187dry/YHY9TPOO0pQasI6vQYzAHkOpuoIbME53lIxqcEC065XJuvIHESEtxj9O/2h8SA7WtOsG322pO2y40M40EZX24QIzZCt6adUHBO+adA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2d2dbc-2458-4c4e-21f6-08de174587f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 23:47:33.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIlPGlgH61RD5Ggn6GPbWolsMEZE9CWGew6aF1YwCnb3/wHdbLtUt0i12P2sPGQmqw96K8ffH8EdHmXrphq7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
X-Authority-Analysis: v=2.4 cv=NvzcssdJ c=1 sm=1 tr=0 ts=6902a79b cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=42MLr2Qild-MKVhrv2cA:9
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: bYuh540ka8A0z-XMQlQa4qfZp2Z598cS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE5MiBTYWx0ZWRfX2t25tmIKSIhd
 OshsFlw2h4J1iwCrTZX9zbGR2YP7G8RJw0xqeZwwmBK08iE7yVzHGRdKJ2yqsReoq25ydtdsk7u
 ku9p+kCFmsDoYfyy6DaIfVbV4CIjHSfsUFkMJZtsOKq8b1bN0w4K5BlRIynr81y7mIt5id9PJ7R
 gvSOsy0rAVT4/+Pf0lJsMejBqJJI5sxmAckkLxPF7Es3KjEi1uQJ95WE6I/Nn4ylmh0V65szIDp
 mW69E5fwXB3O/sLju7vyk/z1FKxGFupQuqWYPHs7zGRDTDUidDHNqzHffdh0/5HNCHIB80ERRrN
 kw1etbQMaKkvVNtNKGiC/sceXEHF8zsFfa9RsnWUgvQH3qzX15jWIOOSfEWD977qz/gZaA1uNzJ
 FehVr46oo+ifPDUHPgYIOdGTp7XWsg==
X-Proofpoint-ORIG-GUID: bYuh540ka8A0z-XMQlQa4qfZp2Z598cS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2510290192

SGksDQoNCk9uIFR1ZSwgT2N0IDI4LCAyMDI1LCBNYW5pc2ggTmFnYXIgd3JvdGU6DQo+IFRoaXMg
cGF0Y2ggYWRkcmVzc2VzIGEgcmFjZSBjb25kaXRpb24gY2F1c2VkIGJ5IHVuc3luY2hyb25pemVk
DQo+IGV4ZWN1dGlvbiBvZiBtdWx0aXBsZSBjYWxsIHBhdGhzIGludm9raW5nIGBkd2MzX3JlbW92
ZV9yZXF1ZXN0cygpYCwNCj4gbGVhZGluZyB0byBwcmVtYXR1cmUgZnJlZWluZyBvZiBVU0IgcmVx
dWVzdHMgYW5kIHN1YnNlcXVlbnQgY3Jhc2hlcy4NCj4gDQo+IFRocmVlIGRpc3RpbmN0IGV4ZWN1
dGlvbiBwYXRocyBpbnRlcmFjdCB3aXRoIGBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpYDoNCj4gUGF0
aCAxOg0KPiBUcmlnZ2VyZWQgdmlhIGBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoKWAgZHVy
aW5nIFVTQiByZXNldA0KPiBoYW5kbGluZy4gVGhlIGNhbGwgc3RhY2sgaW5jbHVkZXM6DQo+IC0g
YGR3YzNfZXAwX3Jlc2V0X3N0YXRlKClgDQo+IC0gYGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0
KClgDQo+IC0gYGR3YzNfZXAwX291dF9zdGFydCgpYA0KPiAtIGBkd2MzX3JlbW92ZV9yZXF1ZXN0
cygpYA0KPiAtIGBkd2MzX2dhZGdldF9kZWxfYW5kX3VubWFwX3JlcXVlc3QoKWANCj4gDQo+IFBh
dGggMjoNCj4gQWxzbyBpbml0aWF0ZWQgZnJvbSBgZHdjM19nYWRnZXRfcmVzZXRfaW50ZXJydXB0
KClgLCBidXQgdGhyb3VnaA0KPiBgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoKWAuIFRoZSBj
YWxsIHN0YWNrIGluY2x1ZGVzOg0KPiAtIGBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVycygpYA0K
PiAtIGBkd2MzX3JlbW92ZV9yZXF1ZXN0cygpYA0KPiAtIGBkd2MzX2dhZGdldF9kZWxfYW5kX3Vu
bWFwX3JlcXVlc3QoKWANCj4gDQo+IFBhdGggMzoNCj4gT2NjdXJzIGluZGVwZW5kZW50bHkgZHVy
aW5nIGBhZGIgcm9vdGAgZXhlY3V0aW9uLCB3aGljaCB0cmlnZ2Vycw0KPiBVU0IgZnVuY3Rpb24g
dW5iaW5kIGFuZCBiaW5kIG9wZXJhdGlvbnMuIFRoZSBzZXF1ZW5jZSBpbmNsdWRlczoNCj4gLSBg
Z3NlcmlhbF9kaXNjb25uZWN0KClgDQo+IC0gYHVzYl9lcF9kaXNhYmxlKClgDQo+IC0gYGR3YzNf
Z2FkZ2V0X2VwX2Rpc2FibGUoKWANCj4gLSBgZHdjM19yZW1vdmVfcmVxdWVzdHMoKWAgd2l0aCBg
LUVTSFVURE9XTmAgc3RhdHVzDQo+IA0KPiBQYXRoIDMgb3BlcmF0ZXMgYXN5bmNocm9ub3VzbHkg
YW5kIGxhY2tzIHN5bmNocm9uaXphdGlvbiB3aXRoIFBhdGhzDQo+IDEgYW5kIDIuIFdoZW4gUGF0
aCAzIGNvbXBsZXRlcywgaXQgZGlzYWJsZXMgZW5kcG9pbnRzIGFuZCBmcmVlcyAnb3V0Jw0KPiBy
ZXF1ZXN0cy4gSWYgUGF0aHMgMSBvciAyIGFyZSBzdGlsbCBwcm9jZXNzaW5nIHRoZXNlIHJlcXVl
c3RzLA0KPiBhY2Nlc3NpbmcgZnJlZWQgbWVtb3J5IGxlYWRzIHRvIGEgY3Jhc2ggZHVlIHRvIHVz
ZS1hZnRlci1mcmVlIGNvbmRpdGlvbnMuDQo+IA0KPiBUbyBwcmV2ZW50IHRoaXMgcmFjZSBjb25k
aXRpb24sIGB1c2JfZXBfZGlzYWJsZSgpYCBzaG91bGQgYmUgbWFkZQ0KPiBzeW5jaHJvbm91cy4g
U3BlY2lmaWNhbGx5Og0KPiAtIElzc3VlIGFuIGBFTkRYRkVSYCBjb21tYW5kIHRvIHN0b3AgdGhl
IGVuZHBvaW50Lg0KPiAtIEVuc3VyZSBhbGwgcGVuZGluZyBVU0IgcmVxdWVzdHMgYXJlIHJldHVy
bmVkIHRvIHRoZSBmdW5jdGlvbiBkcml2ZXINCj4gICB2aWEgYGR3YzNfZ2FkZ2V0X2dpdmViYWNr
KClgIGJlZm9yZSBmcmVlaW5nLg0KPiANCj4gU2luY2UgYGdzZXJpYWxfZGlzY29ubmVjdGAgY2Fs
bHMgYHVzYl9lcF9kaXNhYmxlKClgIGZpcnN0LCBtb2RpZnlpbmcNCj4gYGVwX2Rpc2FibGUoKWAg
dG8gaW52b2tlIHRoZSBgY29tcGxldGUoKWAgY2FsbGJhY2sgZm9yIGdzZXIgVVNCDQo+IHJlcXVl
c3RzIGVuc3VyZXMgc2FmZSBkZWFsbG9jYXRpb24uDQoNCkEgZ2FkZ2V0IGRyaXZlciBjYW4gZGVh
bGxvY2F0ZSB0aGUgcmVxdWVzdCBvbiByZXF1ZXN0IGNvbXBsZXRpb24gb3RoZXINCnRoYW4gdXNi
X2VwX2Rpc2FibGUoKS4NCg0KPiANCj4gQWRkaXRpb25hbGx5LCB0aGUgZHJpdmVyIGFscmVhZHkg
aW5jbHVkZXMgdGhlIGBkd2MtPmVwMF9pbl9zZXR1cGANCj4gY29tcGxldGlvbiBtZWNoYW5pc20s
IHdoaWNoIGlzIHRyaWdnZXJlZCB1cG9uIHJldHVybmluZyB0byB0aGUNCj4gU0VUVVAgc3RhZ2Uu
IFRoaXMgY2FuIGJlIGxldmVyYWdlZCB0byBjb29yZGluYXRlIGFuZCBzeW5jaHJvbml6ZQ0KPiB0
aGUgY2xlYW51cCBwcm9jZXNzIGVmZmVjdGl2ZWx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFu
aXNoIE5hZ2FyIDxtYW5pc2gubmFnYXJAb3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMjUgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IGluZGV4IDZmMThiNDg0MGEyNS4uOTNjMjBkNWVkZWExIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gQEAgLTEwNjQsNyArMTA2NCw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdl
dF9lcF9kaXNhYmxlKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMJ
CSpkd2MgPSBkZXAtPmR3YzsNCj4gIAl1MzIJCQlyZWc7DQo+IC0JdTMyCQkJbWFzazsNCj4gKwlp
bnQJCQlyZXQ7DQo+ICANCj4gIAl0cmFjZV9kd2MzX2dhZGdldF9lcF9kaXNhYmxlKGRlcCk7DQo+
ICANCj4gQEAgLTEwNzcsMTggKzEwNzcsMjMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2Vw
X2Rpc2FibGUoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3Ms
IERXQzNfREFMRVBFTkEsIHJlZyk7DQo+ICANCj4gIAlkd2MzX3JlbW92ZV9yZXF1ZXN0cyhkd2Ms
IGRlcCwgLUVTSFVURE9XTik7DQo+ICsJLyoNCj4gKwkgKiBTdG9wIHRoZSBlbmRwb2ludCBieSBp
c3N1aW5nIEVORFhGRVIgYW5kIHN5bmNocm9ub3VzbHkgY29tcGxldGUNCj4gKwkgKiBhbGwgcGVu
ZGluZyBVU0IgcmVxdWVzdHMgYmVmb3JlIHJldHVybmluZyBmcm9tIGVwIGRpc2FibGUuDQo+ICsJ
ICovDQo+ICsJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApIHsNCg0KVGhlIERX
QzNfRVBfREVMQVlfU1RPUCBmbGFnIGlzIG5vdCBtZWFudCBmb3IgdGhpcy4gVGhlcmUgYXJlIHRp
bWVzIHdoZW4NCndlIHdhbnQgdG8gZGVsYXkgaXNzdWluZyBFbmQgVHJhbnNmZXIgY29tbWFuZCwg
YW5kIHRoZSBmbGFnIGlzIG1lYW50IGZvcg0KdGhhdC4gWW91J3JlIHNlbGVjdGl2ZWx5IHdhaXQg
Zm9yIEVuZCBUcmFuc2Zlci4gU28sIHRoaXMgZnVuY3Rpb24gaXMNCnNvbWV0aW1lIHN5bmNocm9u
b3VzIGFuZCBzb21ldGltZSBpdCdzIG5vdC4NCg0KPiArCQlzcGluX3VubG9jaygmZHdjLT5sb2Nr
KTsNCj4gKwkJcmVpbml0X2NvbXBsZXRpb24oJmR3Yy0+ZXAwX2luX3NldHVwKTsNCj4gKwkJcmV0
ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZkd2MtPmVwMF9pbl9zZXR1cCwNCj4gKwkJ
CQkJCSAgbXNlY3NfdG9famlmZmllcyhEV0MzX1BVTExfVVBfVElNRU9VVCkpOw0KDQpEb24ndCB1
c2UgRFdDM19QVUxMX1VQX1RJTUVPVVQsIGl0J3MgbWVhbnQgZm9yIFBVTExfVVAgdGltZW91dD8N
Cg0KPiArCQlzcGluX2xvY2soJmR3Yy0+bG9jayk7DQo+ICsJCWlmIChyZXQgPT0gMCkNCj4gKwkJ
CWR3YzNfZXAwX3Jlc2V0X3N0YXRlKGR3Yyk7DQo+ICsJfQ0KPiAgDQo+ICAJZGVwLT5zdHJlYW1f
Y2FwYWJsZSA9IGZhbHNlOw0KPiAgCWRlcC0+dHlwZSA9IDA7DQo+IC0JbWFzayA9IERXQzNfRVBf
VFhGSUZPX1JFU0laRUQgfCBEV0MzX0VQX1JFU09VUkNFX0FMTE9DQVRFRDsNCj4gLQkvKg0KPiAt
CSAqIGR3YzNfcmVtb3ZlX3JlcXVlc3RzKCkgY2FuIGV4aXQgZWFybHkgaWYgRFdDMyBFUCBkZWxh
eWVkIHN0b3AgaXMNCj4gLQkgKiBzZXQuICBEbyBub3QgY2xlYXIgREVQIGZsYWdzLCBzbyB0aGF0
IHRoZSBlbmQgdHJhbnNmZXIgY29tbWFuZCB3aWxsDQo+IC0JICogYmUgcmVhdHRlbXB0ZWQgZHVy
aW5nIHRoZSBuZXh0IFNFVFVQIHN0YWdlLg0KPiAtCSAqLw0KPiAtCWlmIChkZXAtPmZsYWdzICYg
RFdDM19FUF9ERUxBWV9TVE9QKQ0KPiAtCQltYXNrIHw9IChEV0MzX0VQX0RFTEFZX1NUT1AgfCBE
V0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpOw0KPiAtCWRlcC0+ZmxhZ3MgJj0gbWFzazsNCj4gKwlk
ZXAtPmZsYWdzICY9IERXQzNfRVBfVFhGSUZPX1JFU0laRUQ7DQoNCldoYXQgaGFwcGVuIHRvIERX
QzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEIGZsYWcsIHdoeSB3YXMgaXQgcmVtb3ZlZD8NCg0KPiAg
DQo+ICAJLyogQ2xlYXIgb3V0IHRoZSBlcCBkZXNjcmlwdG9ycyBmb3Igbm9uLWVwMCAqLw0KPiAg
CWlmIChkZXAtPm51bWJlciA+IDEpIHsNCj4gLS0gDQo+IDIuMjUuMQ0KPiANCg0KV2hhdCB5b3Un
cmUgZG9pbmcgaGVyZSBvbmx5IG1pdGlnYXRlcyB0aGUgaXNzdWUuDQoNCldoZW5ldmVyIHdlIGNh
bGwgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSwgdGhlcmUncyBhIG1vbWVudGFyeSByZWxlYXNlIG9m
DQpzcGlubG9jaywgYW5kIHRoZXJlIHdpbGwgYmUgYSBjaGFuY2UgZm9yIGEgcmFjZS4gSXQgY2Fu
IGFsc28gY29tZSBmcm9tDQp1c2JfZXBfZGVxdWV1ZSgpIGFuZCBub3QganVzdCB1c2JfZXBfZGlz
YWJsZSgpLg0KDQpQZXJoYXBzIGp1c3QgdGhpcyBjaGFuZ2UgaXMgc3VmZmljaWVudCB0byBzb2x2
ZSB0aGUgcmFjZSBpc3N1ZS4NCkhvcGVmdWxseSB3ZSBkb24ndCBuZWVkIHJlZmVyZW5jZSBjb3Vu
dCBmb3IgZHdjM19yZXF1ZXN0Lg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IDFmNjdmYjZhZWFkNS4uYTFk
MmZmOTI1NGI0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTIyOCw2ICsyMjgsMTMgQEAgdm9pZCBkd2Mz
X2dhZGdldF9naXZlYmFjayhzdHJ1Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0
ICpyZXEsDQogew0KIAlzdHJ1Y3QgZHdjMwkJCSpkd2MgPSBkZXAtPmR3YzsNCiANCisJLyoNCisJ
ICogVGhlIHJlcXVlc3QgbWlnaHQgaGF2ZSBiZWVuIHByb2Nlc3NlZCBhbmQgY29tcGxldGVkIHdo
aWxlIHRoZQ0KKwkgKiBzcGlubG9jayB3YXMgcmVsZWFzZWQuIFNraXAgcHJvY2Vzc2luZyBpZiBh
bHJlYWR5IGNvbXBsZXRlZC4NCisJICovDQorCWlmIChyZXEtPnN0YXR1cyA9PSBEV0MzX1JFUVVF
U1RfU1RBVFVTX0NPTVBMRVRFRCkNCisJCXJldHVybjsNCisNCiAJZHdjM19nYWRnZXRfZGVsX2Fu
ZF91bm1hcF9yZXF1ZXN0KGRlcCwgcmVxLCBzdGF0dXMpOw0KIAlyZXEtPnN0YXR1cyA9IERXQzNf
UkVRVUVTVF9TVEFUVVNfQ09NUExFVEVEOw0KDQpCUiwNClRoaW5o

