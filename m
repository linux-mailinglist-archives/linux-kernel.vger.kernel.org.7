Return-Path: <linux-kernel+bounces-775088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D1B2BB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B523A9E21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEA181732;
	Tue, 19 Aug 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="nHwsquek"
Received: from mx0b-00015a02.pphosted.com (mx0b-00015a02.pphosted.com [205.220.178.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB497265CC0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589923; cv=none; b=JvMlF1iuktaz+Wx1mSO4Nq38qJ4Di8Uao3/ZsRajYbVvr4122eWfEdF0Y33glhLI5nXXyMm9I0BDSerfjL9e4u2gIwhqIQUYuT45EKfXOvAeJJtWAnxo2VbZWHXh2+OtBbEqjrWYSpvcHz034fRc2v6hs6yFl06w68EhngvBqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589923; c=relaxed/simple;
	bh=KLa8RhSAKn5U9sYLTQyqRxSod2wIsZ7n4+17BZ+wEPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQPx1dT1EZxz27QiO1GgwSjKsteHgs8wtpg+tENE3VtlEuAmRGffhkw++ei1lXNbwa/lppsTEjpgmM6t6xhgcShyU99SSg6FhRi8a5tBIcCMFEGLP4whPhHce0NS5VlWlEWTuBsqkeUqTHVp4WXMXH7PmreI5n9+/604wATTiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=nHwsquek; arc=none smtp.client-ip=205.220.178.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0264210.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J717fd013474;
	Tue, 19 Aug 2025 02:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=podpps1; bh=av
	KWv1YT6oX80vsU3mpq60oKlgXt1iQlAdhoO+jnM2M=; b=nHwsquek9z2KKDnENf
	nuvxZtsA7cCkiHSdsSDy4oq9l6FtDBUudzZ3GdNOYIEDqSB988USx7KZU5YSh2Wv
	rWJULu3B7gLz+QbvCtEc8FMFWSok9gT8SbWVTAdLwIRxJs2+tmAP55v3NM2NBc2p
	kFMvpw2/JrV8DqhPsnfRWx9nZneBNgA3Lbp7ggMzOCQc2ko/MButEOVo9DV3AOG2
	/+1My0MMrWsEDBn64rFnJTkzCeqv2+ehsAAnGgMQ7+Bk39xxXd3MzPwt45F14yIw
	JhHgqz6/myKOw+zFzo8AqrHjp5dzyr7hZORgfDI+0GeGqoCO7UhH9ccrQaYqPwQJ
	d7qQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2100.outbound.protection.outlook.com [40.107.237.100])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 48jqbkmngr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 02:43:14 -0500 (CDT)
Received: from SA1PR18MB5692.namprd18.prod.outlook.com (2603:10b6:806:3a8::9)
 by SN7PR18MB4400.namprd18.prod.outlook.com (2603:10b6:806:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:43:13 +0000
Received: from SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3]) by SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::1b82:7cf8:55cf:35e3%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 07:43:13 +0000
From: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "afd@ti.com"
	<afd@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: RE: [PATCH] phy: ti: gmii-sel: fix rgmii_id mode config
Thread-Topic: [PATCH] phy: ti: gmii-sel: fix rgmii_id mode config
Thread-Index: AQHb/UCoUZLW3pLGokivBDSJ0rSu07RpvqaA
Date: Tue, 19 Aug 2025 07:43:12 +0000
Message-ID:
 <SA1PR18MB56924713F249FD6D042909379930A@SA1PR18MB5692.namprd18.prod.outlook.com>
References: <20250725084640.845760-1-aleksandar.gerasimovski@belden.com>
In-Reply-To: <20250725084640.845760-1-aleksandar.gerasimovski@belden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5692:EE_|SN7PR18MB4400:EE_
x-ms-office365-filtering-correlation-id: 57195f95-3d6b-4f58-9710-08dddef40d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dcSNinbOTE5pI4NkHhcjGPYep8cCIH0jXHuHpxP9lLFYZCEabmsNmIji34hB?=
 =?us-ascii?Q?wElnHDtWf8HP4POwl9gZJvAFFX0abQMuaoY/ZwCcPqYCNFnVZd3mqfpMtMKU?=
 =?us-ascii?Q?lAW8RLpOxKbPjjq9vW16BTXx1oh8j4l/mqWUZTqQ2SSqdxxBZHObyLAo0XKu?=
 =?us-ascii?Q?ocb9IFup4ngdhAluChTLyk3hfuBO4OanMclUszm2yYPgUFDzo8zMoNLdLT1W?=
 =?us-ascii?Q?t7YeVWfInWVNV9fkuYS0uoMNZuJX3QCnYs5ld//C7KgSt988JDYAGYblKvKq?=
 =?us-ascii?Q?oUa4EzHVajkyXKqpI5kcmQS88bHeW3zFyEDRWniW67SfJFNfdWnOdLha9QA6?=
 =?us-ascii?Q?0jv5fma6UTnmcP4zn1m1bFnDXLJqhl8l9ov2j9BR0zDP3Fi3tFX4ezUrNwig?=
 =?us-ascii?Q?JveCHKqcXyK2IjouVAQAvNKhAw5u0xwpjvzpZumwW4Kvs/EQ+bMWs4+H3v2B?=
 =?us-ascii?Q?C5abBT0k07Qhsci/0u5hB9Fn4xRhb6vrk8P1yIdegwXhild06uMvjTWC9n7p?=
 =?us-ascii?Q?5lEpnWH2TYTv0hICL5IIvt/tN1ye3MVH0oJjmCp83gTzJudJNmjipQDwcqbW?=
 =?us-ascii?Q?e/tPeB6vjXJ6yg/5yVJepnES///KnhoPt8XB8bueNB7SuEvhrlxr9y65ijjh?=
 =?us-ascii?Q?cG/Ra9bD+JNW0SK06TdqdG0pZMV9s67+RnjV8tqoq6mRMaj/GwkLDPctPv0v?=
 =?us-ascii?Q?9LOdoCJrjNWrgg55afdrJQCIQ96rivfvbYMCVvhsp4tAvL7XW4Wcy/pcWni3?=
 =?us-ascii?Q?AA+rQ7B0VtJFHJg8pqwFD/d7/YZZMQYuPV6ygXFXNKzdFHGBDIpJOw7tKTGJ?=
 =?us-ascii?Q?/FW4uAGYZ9NwAT6iIRCkWdbZoBo1gCzMND9KWCkBAZ3b+72Xt4hZLfIZO245?=
 =?us-ascii?Q?kD6ex4oJLdsoJWn1gczp1DNsY822B3pSHAwsBL+8SWh6d5csr64tFFaLXDw9?=
 =?us-ascii?Q?aFskkfZ9pufLR080mqBl2pvauT0iIu82JR6TAItW2No/VFTT+b2DlHNfDFH9?=
 =?us-ascii?Q?v9m2tojtbJqrWVbjudGLPIrGghqnOZxZsgG02x/DhaBlJMwztGNaA7Ubgw9M?=
 =?us-ascii?Q?K+ZYZA/CscOfL+eruaSKl1lgmYpZ0GxJQdylJz0/21dGMRzNWuO8WGvn4KHw?=
 =?us-ascii?Q?rZGcp6BdkzWe74ZRx4shU2oT4S8MhkmQ5JcySfdp1XeuyD15WYsGETZQtN3T?=
 =?us-ascii?Q?vRJsm6z+C1aHu0iCi78aKXFXtQ4HP/ERRM+hiRLXsQONw5rD4EzRE4523RzX?=
 =?us-ascii?Q?XZeevooJqHFLxINIhosQUNfI+WYRUyRZr3CGHX0scgAHAw7JvSKetQTzBsfa?=
 =?us-ascii?Q?utFmChUGYnjPWcQtJSbPEGowPTooxWCl+mtEn3Tb+meY0NZLZGbv6YfIEh7q?=
 =?us-ascii?Q?7QiUmyMioqU4c9JWUBjbBhCInnmtIJt8Gbqyq5Js8R8daRitRXMRhRYJVT9C?=
 =?us-ascii?Q?IUwM/daUPl9XwkH+066toH8jvwr8c7FN3nfhGBBix+EQNS3TVkKDwCfp+Miz?=
 =?us-ascii?Q?wD3wsasqVkL2cdU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB5692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tokAzdVoiu82yWYsq1suXvOBYyxz3958Ceyqt5OTzu3FIlYh+aRScuuPSQwr?=
 =?us-ascii?Q?LLoPhL7lNjVfTcSUmdyu5tSGqkbnrOe8ngxB2bbVRCzADuQM5vHPL/9ui3rd?=
 =?us-ascii?Q?MlIwMqeWWzv2ZlIIzNBaEvonlIESTTnjxRdgmaQX1S2UjspgllB8OvaTS5Ru?=
 =?us-ascii?Q?Ty1s1OH6lE2qnno4WPqzxapNflojkxyF2FDxp91oOU7ml4zs96/eRi04PPCb?=
 =?us-ascii?Q?cxlxI5k9qOS1jZyWvVOuSD3ZzwL626alybfx5r9CGIwc4DavIUVgmsFZ9pzP?=
 =?us-ascii?Q?BsiKxilfY9gwnRuKIMsSCUHrAIPTQHGHyHl/psf2Eti6KOZ2ofsfLhY43WmY?=
 =?us-ascii?Q?ePrL8Vz/6R7KVq5w5SANqsUq08K0vUhEqU1CIccOFrlTZwIqZsjRpoK0JsWn?=
 =?us-ascii?Q?7pjnyziwDzc41hYvzFxAgERP/TKuhfqH9MsIaVg4fhgTTUpuvAfaitpNrVSA?=
 =?us-ascii?Q?Zs8mGC3uWxgrmhXiS4SOye2shxJHuRfQwW0BJDbaOAg4D9RPMo20+ANHbirp?=
 =?us-ascii?Q?foVoBmbL7VNQm2W54bSNvd1k28k3FpZAXYOkpsbf0HVMMoQoJrcP589Yqt6V?=
 =?us-ascii?Q?G+cVIZxm+Eq0b/w4eZ6PMD+g7aRJRw1WPnx1bleeI+qbOWqb+orXpGrM/tBG?=
 =?us-ascii?Q?MHxLWQI42R1fHG5i5PMP3LTV3U16/OBpNgRPZxfJCT/pXjNjMv6gXMKS/PY2?=
 =?us-ascii?Q?nk81U7PK8WClFvrz7X2InFuQGFwZo79i0wwVXgRf3FAoh3QK8CgbIBhgX52j?=
 =?us-ascii?Q?4xU6Ph2XSpQHF4NMl8iAvuRW2bnmiAjOQ5vusS7RVWe1WPLMRGM/9BcKgzn4?=
 =?us-ascii?Q?aauC5fCGbjDJrqsjz9jzl56NnsPiUqdx7x4A5bUwA5pxH5M8CwrA6MW3Hw2F?=
 =?us-ascii?Q?QjnnbngnKXO8vcs8drVC4tp/CI0LU9D7DJYJ7tXCRpUurSiLGiVnZ5Vj1D0g?=
 =?us-ascii?Q?5QRXqwlTtiLN4QNNjbMe+iwuXGQebYagp2ST8alWtnShbK5kPQA96FEUMt7B?=
 =?us-ascii?Q?F4P3BOlY5wjNk4Z4IYshaog3uHCijCM4d8pxRtxz/CIQG6VKJ1eOurhJsWW/?=
 =?us-ascii?Q?DPmK0etBfWvRot2KhOpIMta6U+w7lj86ICZDnJMJpWDF07bLPxRzK4RnJlrN?=
 =?us-ascii?Q?0ghFkZPl27gY/9wd6mumbOCutLqwioFzt45dSpdt6x793atSpLXLFc5Pg5+3?=
 =?us-ascii?Q?knM8d4o5AyJ7KUoKpLAtXRWYXS0FLWiYUJveMmyOreTNkjCkO0GDItKSND+/?=
 =?us-ascii?Q?qj+RLFLgcVnd2BCufJLKMy4QUnbP/MBfkKOstaWlI1pDcmIv8qUot551pMVu?=
 =?us-ascii?Q?cL8AjAe6WtXdzvVW7Q+RLQu5RJV/T32xq9sjH8UNG0D/eN+x+dXB8mmChAAB?=
 =?us-ascii?Q?+kfShj8c8uhHgZ0jH1OlgPQuV66Im1Grqq2Lpes7HVkcjzyfvSSbmgCJIaII?=
 =?us-ascii?Q?5YS0W1VUh+LltPgqNuhVM8ArOVYyqg/QljtioFDCfOF20LXgQVfIeR3w0Qtl?=
 =?us-ascii?Q?AMbm0pqYIsckPqE8TRxe0hLqzsCDLafEDLgf7iacJujoOeuxjM5GEIby76/Y?=
 =?us-ascii?Q?ZotpWW2+z7nTx0c1y06tY7pJhod4hX63d1tHq4kHwxzlwlgD37/7vNWRNxHJ?=
 =?us-ascii?Q?8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Izr3HLD/X6zuFPRhoYlELUh+dR+xpVBOPPLtWHOBV2hQVwqJGE19o9LsTHnutkXmeLyGtz60NbUKTsQsCzcUGZmgtr5XVMPbY1xHcQTb1uC8R6ycOJXm/JSarjJyN1zYVzRKPbqVFz6a5gUQxdRiGedka36Goi/Y4jIVQYjEEx0i+PV+ASoLZWUzBOKHiLZjzuws/JoyRb/QgFLkf8GcXYd5gHduk7HF2Z32ofotaN9PYs2utG1eo75rnVFJJtivmf/1cqCc5A5aGp+/Ej3Jfwnm1aL0pGIsTSIIr5R95sULQjlNyrusJSZu4SqMEQRwWOcD9ZRydLTsTj5ArUs2mVcogqKWxZyGA0XBVHRBrVVw19vbLsRDaKdy8QgLbsesmZAcQtb36ei1f5jJWw6faXC6wXry2/IRCdYUjxY14EqLHdTCEce/l+VG6jf24kdHZ137Vm+cWwIms4xHFQ3Go6VEOyS43jJWU/IqjNZLqyjPN+Jgv/ZS93p2OkMummUqEf5kx+VoV5rm1oF0/NZKTv7OvWJtPdDII6WII7G2bOTz0PovaBMgzcJ+sjRUfr+SttgyJdXfEyEP2b4wd1AKC6Dr1M8cQ0km/uImAl6s1ciCDKHThz9tRSAO0T5jGJ+X4QAe8yPXI/dMuKcpbGtYOg==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57195f95-3d6b-4f58-9710-08dddef40d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 07:43:12.9236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzSA0A6dF5dJgq1pV2lqjt+XdpFywLdwwqp6l5aKiG1nBG5OwmBwh2vO23WyeQINrJHI9ex4Qu1gpBuF5V2gORXXrSplxwsxpUWEfpxT0HGJu3cq4zZtSbyHOMZLCAxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4400
X-Proofpoint-ORIG-GUID: L9uDxNVDE66p9rnLb66SGNLfpLS7Vct4
X-Proofpoint-GUID: L9uDxNVDE66p9rnLb66SGNLfpLS7Vct4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA5NSBTYWx0ZWRfX7yCHy+UA+zal
 2TaQbPxZHv0Xcs/xr5dHHfCh8z4xwua0Zy4TTJFFafd+3AojQekeDzYrVjzoh9ZCqNalke55X8/
 7WSuZ8wfoTLYQWFaGT6yqvzynU8oqvKSKS3kIVLy+AYM3rh9UpObgP1RxpRGOjWvMYeflIVihbp
 Ixx9TZ23UBRUwI6jO6fM78Hs2WjLWpXBqZhc5w3tUJpCl+Vj1A0FBpPJP+vmzChUq2FBD6rQVm8
 tYLmsVna79b6X9pvDhYg5t5DMg7R2RjFOEG3PyKnKttFCkRMrSSAqIqYbrKTA9pTrXW3TVkilWe
 12btXWvVszntH9PvLmr+C/MBifBnEP3finOc87CartV6S9TXWQbCR/O01FReH1lRkJ1f0iO7bsp
 VNOUiEMs
X-Authority-Analysis: v=2.4 cv=VdL3PEp9 c=1 sm=1 tr=0 ts=68a42b13 cx=c_pps
 a=2YGd4IbhlfziBVieGfYAVw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=mCf63rc527wA:10 a=WDlp8lUfAAAA:8 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=kUMQbp02cAE42aDAPWoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160095
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam

Hi there,

Any opinion about the patch? Or maybe I missed the active maintainers of th=
is driver?

Regards,
Aleksandar

-----Original Message-----
From: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>=20
Sent: Friday, July 25, 2025 10:47 AM
To: linux-kernel@vger.kernel.org; afd@ti.com; s-vadapalli@ti.com
Cc: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Subject: [PATCH] phy: ti: gmii-sel: fix rgmii_id mode config

Without setting this bit the RGMII_ID link does not work reliably, we have =
found this thanks to the U-boot cpsw-nuss driver that is setting it. The bi=
t is undocumented in the AM64x reference manual (see CTRLMMR_ENET1_CTRL reg=
ister).

This problem is not visible if the Kernel is booted by a U-boot with enable=
d networking, in our case we see the problem as the U-boot networking is no=
t used, and it is disabled.

Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 41 ++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c =
index ff5d5e29629f..60a1312acf33 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -210,19 +210,44 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814 =
=3D {
=20
 static const
 struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] =3D {
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x0, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x4, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x8, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0xC, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x10, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x14, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x18, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x1C, 0, 2), },
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x0, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x4, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x4, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x8, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x8, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0xC, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0xC, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x10, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x10, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x14, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x14, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x18, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x18, 4, 4),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] =3D REG_FIELD(0x1C, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] =3D REG_FIELD(0x1C, 4, 4),
+	},
 };
=20
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 =3D {
 	.use_of_data =3D true,
+	.features =3D BIT(PHY_GMII_SEL_RGMII_ID_MODE),
 	.regfields =3D phy_gmii_sel_fields_am654,  };
=20
--
2.34.1

**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.

