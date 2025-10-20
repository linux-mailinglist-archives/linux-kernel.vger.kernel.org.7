Return-Path: <linux-kernel+bounces-860182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127ABEF874
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9103E07B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F222D9ED7;
	Mon, 20 Oct 2025 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b="T7cDu9g2"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2114F9FB;
	Mon, 20 Oct 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943343; cv=fail; b=BPfNajALUwlw2Jkf/bHDPOiYk8jx0rzh7anvlNCbliFKM0MdzxeoCY9UVYu7Q1Eo7s796f3iNEK6SSym/GUG37PLCdtixNIJSJZeH+W50mM7Ai5zfAl+WtaYHMHlJ2COuc8+97aCkLDnZLJB6eKvfbKZis5y8cdtfbd7dmocu9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943343; c=relaxed/simple;
	bh=/IO6zddLLapnlfwvkf0K8FYUjsNmYalRRXA3eomDsy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7x8FAIPSGPTOon/1lCS7dyxQOQcrbYRqZv0fsgUUVd51zyNEhH/gV7C2znt8d66PP+sJN7q5z8IEvfYhoSjTOh8Jh1CIgFFk6SN283WO9n/dtk0yjXwMkj+RAkhDICDOXhrkKd7WD8V2L6OYLPhWt/dS1vyYHy5d53jPOAGdq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=yuji2.ishikawa@toshiba.co.jp header.b=T7cDu9g2; arc=fail smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 59K6Oq361733185; Mon, 20 Oct 2025 15:24:52 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=yuji2.ishikawa@toshiba.co.jp;s=
	key1.smx;t=1760941459;x=1762151059;bh=/IO6zddLLapnlfwvkf0K8FYUjsNmYalRRXA3eom
	Dsy4=;b=T7cDu9g2LcmMdru14vX+xlkcp9vu1dPDo5GW8CseK6fm/RekX9KHgcpVlLca1Qu1nHJGp
	vjOQ9x8uKN6z81zh5PSR+4SUNzEStnz9lBMNkc0TxGzgaCTXV1Fo+o7sJ8Zr8DlU7j4u2WNVXFAYW
	gCIl13gv4me6+MzHRxrSeWlXO7gy79KL4VFKnZbhm3e56ELIiPb+Gfw9YoVKvkWUFNJGEH8GUWx2A
	R4DF9CUlyPNnnMgD8tRKuD7srxom9Mbuq1PG+zuIOmhi6DNS8avME5GtLtpwmbh4c2mcN2uf4hm17
	dGtbN9wXBDzRiSyIEP/+YhqPCZQGi5lISPgT0C9Z2w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 59K6OIFX3923631; Mon, 20 Oct 2025 15:24:19 +0900
X-Iguazu-Qid: 2rWhejjBIfoW8jsLAb
X-Iguazu-QSIG: v=2; s=0; t=1760941458; q=2rWhejjBIfoW8jsLAb; m=GVS6QT300WFSDhI6KthC1khWH7QxCb/1+UbuTP9gS98=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cqlkp0vH9z4vyh; Mon, 20 Oct 2025 15:24:17 +0900 (JST)
X-SA-MID: 53279205
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiGHyC8mw6OD2b5PGHV+xqrZavJ79oAZMId/zNssOksEYDtwcTMAta4eJOEXxQvvQGsWRY3Ys8vxImRcPSeDywe7trT3X62oYyhZjWlfbL+zIoDo9SHm6pav57S934hPoChDxeJXsoe9sgGwILRU9YNXQb5Jwmgo69kL2pcrMTPl1LyjyFwuQ7RUZuP1UXxu8r8RjhjOm5qESpD/yPZNGzB0zgUROml7cj6d+moA+CzgAopnHDUfmC2K33mMy+DlSdP5h3OyRMOx6IZ3xoJBmnYAU7wndBjVkw55aRHhravZC8RKADn0b91lx8aLDTs5m0yYAWMej1Db4EwAtUlEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IO6zddLLapnlfwvkf0K8FYUjsNmYalRRXA3eomDsy4=;
 b=W420jzEm4EZoC0yVlA9sNZMZ8a8IJl0RzUU9epMRZ7y608DTKMhv7Tqb48Zl1NUhy6QIy+lDJ82mFfv979JD2mlQU48V6NLqilAv0rhY4bKf1W+NVQpFzLnG1oGlGQB/e2GqdnE1U8m2/l3QcYaG7+cHhrmpIYcK96X3bAZNi7l//i3nPNMiI9gR+4qKiqDs0aE+TY6M3+i2xSdscImyi20ejPDYlybyF1D0hrk8JAIdqgmzfnuHIHAv8t82j+y9lc9k74ePKVL1+N0hDRAztCCIVRLLfNz+Iqw1/KJa1VCDLb6eyxrW3buiO85Yd/+M36YETIfl4XmbwNFjDI8vUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <yuji2.ishikawa@toshiba.co.jp>
To: <krzk@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nobuhiro.iwamatsu.x90@mail.toshiba>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: clock: Update identifiers for VIIF on
 Toshiba Visconti TMPV770x SoC
Thread-Topic: [PATCH 1/2] dt-bindings: clock: Update identifiers for VIIF on
 Toshiba Visconti TMPV770x SoC
Thread-Index: AQHcPjz5Et0qByZMFUqda43eD9InpbTEU0WAgAZCsIA=
Date: Mon, 20 Oct 2025 06:19:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB9982013052EF296EB7C48B9692F5A@TY3PR01MB9982.jpnprd01.prod.outlook.com>
References: <20251016013328.303611-1-yuji2.ishikawa@toshiba.co.jp>
 <20251016013328.303611-2-yuji2.ishikawa@toshiba.co.jp>
 <04b3271b-3723-4d6e-b39e-31894f9ecc80@kernel.org>
In-Reply-To: <04b3271b-3723-4d6e-b39e-31894f9ecc80@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB9982:EE_|TYYPR01MB16084:EE_
x-ms-office365-filtering-correlation-id: e701da91-a36e-42a1-af78-08de0fa095c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QmdrZk5RdDg5eXdCVnp1TGpmaVNvZ0tBcmYzWm1PQVVjRDRqTWNDY2ZVc1Ax?=
 =?utf-8?B?R0lESVk1YlZPcnNZY1N2RTdzakF3WDgwSi9ha0p1NkV6NlFDYjU0MnZEZ3B6?=
 =?utf-8?B?WjdST3d4Z1cwUmFVUDN4UUxJOXV3NDAxdzIrUGhFU1cvNUpkd0E0LzEzUDNO?=
 =?utf-8?B?aTNkZzNGWlVLSmNucG9PYytqNkZTaU00UTZUTlcrT0plaDA2eWpRMFpJdmZE?=
 =?utf-8?B?aE1XODdwaVBKanMrdUQ1Z2M5alZBQ0RrbGpxMkFuc0ljalhhYTcxcGVnV0hw?=
 =?utf-8?B?WG9YbFlLQTdwbW1GT3NFYjhrMVVFUnlscWtMWGVOYmEzajJtQ24xUWw3em1E?=
 =?utf-8?B?Q0xBVnlHek0wbzhVRDVERERBQlNRTTNxeHVwWGlod0ZKc09TZEluRzVEakpD?=
 =?utf-8?B?aTNneGF4UG93M2pyckhVV3NUSXFMa2NsODhLNmtMTTJjc25McTFuS2NWNjVS?=
 =?utf-8?B?bDFzUDJVaExvZzUrc0RuMjFKdDJvb1B0U3A3WmthSWpQbkxBcEdBVi9LVkRE?=
 =?utf-8?B?WUpPMzVBK2NoRUNoWm9UY3lHenN5SVd6Q1o0eFBFaXB1TW5CUmZFRFA0ZUov?=
 =?utf-8?B?WStGWXJtL1NKcThFZVRDeHZGNFlhUTB1ak0zRE1sQWh5MnB4VTV6WUhFcElU?=
 =?utf-8?B?bXpYOFJNbEwvMHlyclc4QWY1d213MXNFU2VXQitXT2FIVVdXS0NGemtJZHpj?=
 =?utf-8?B?TnRNcXBWblY1dXR6ejhLMmhHVlYvNlZFM1liUnFXUEFCVms3cGRnQllaUjBK?=
 =?utf-8?B?bjlRNjNpb2hraC9XbnYwVng0U29TVjRYZHhEeUg2bjhIOU9RMmJSclhzcVpU?=
 =?utf-8?B?L25sVnpsWm5IK0hIeVZwWGhQdXdlYVQvQnQwWnRjWHA4QWNGOHEyUUMzTDVO?=
 =?utf-8?B?VTFiOFhiZVl2WGhtWWlrRzBJbGptcmRlQ2J3c0RHL3RLSjlUQUxHMjZPUkNS?=
 =?utf-8?B?Vlc2eCtySjNLUXFkalV4VzRqQmxmbCtIVmVPa2FEa0FacDFMcnZtK1RUL3lj?=
 =?utf-8?B?SkszRmsxTU90OEUyYm5hcE80ZTBDOEVXWlBiVktuSXB6R0tPTDgrQ28yenlz?=
 =?utf-8?B?NCt4N1ZtSVZYZkh4UTdtdkcwNEwvcE5qWkxvMVczdTlmRFUxOVBKQlRlcGhO?=
 =?utf-8?B?QnM4d2JWaExjT3FGQ3pWR0FYVHdaN0hjL2VNRHRoc1pnNmtXMklveVhWYm82?=
 =?utf-8?B?ZTd6ai9vekUwZjU4SnRJY1hxRWo0TEVqa0h2bW9wWStHVDl0TWRVaHZodGd5?=
 =?utf-8?B?UG1oMzFFTzBuMlRWVHpVSWk1Wk5jTnFPR1I5bU1hY1FPUzNoS3dXTTB6bEtM?=
 =?utf-8?B?VG5xZEFycS9Pc0R6SHFqNkpXVktrTHNYNHcydWRkOXQraW1oRHZ5NitMZjhV?=
 =?utf-8?B?S1l4WmFEcWNUb1VNbEkxcUkraTB0aVRMckQ3Z0lZZ3g0dTVVcjFjdGp6RHBt?=
 =?utf-8?B?ZWI4SzloRjAvQ28xcVZVMTJSM05QRGhjOVlRUWZwR0lDQ2ZETG50bE8vck83?=
 =?utf-8?B?bk5XcXRKWUh2WkRoQmlZdU1WSEZmZnpuNWc0QkVhVjMxYy9WUW1weWtFLzg3?=
 =?utf-8?B?Y3RJSmMzQUcvQzZaOW90bGc1L2tSMzJ5ZklMVFIwV3h2eXhJYnAxTVF0WHJw?=
 =?utf-8?B?ZWNGK08yeGxDckZMN0ZnVHp2R1gxMElFaks4bnNQejd2a1FNZDVFcWFnN2Nh?=
 =?utf-8?B?N240K29MWjNpVEdVbndtUWt0RFhBOXVyVHh2RmtyUE50aTIzK0daZjRnUXNN?=
 =?utf-8?B?TE9ydGtJb01DUE9aOVZuUUhCV3BjN21LNW1ueCtmdm5IUVhUTFBJR3NCbE41?=
 =?utf-8?B?QytDVk13eUJjblhnd3ZudGIrZDJ5cGMrQ0h3ZFpWVU91SGpydktDT1lWdjVk?=
 =?utf-8?B?d0tXc1VjTnNjQVlxOVdQT3hiclVmZEV6TjlOVnlZbnZkOHEyL0Z4RDlqTktE?=
 =?utf-8?B?OWVpZE1YaXVJSUVJcExJTmQvSzJKbm1Pa1Ftc0RHYjJTQWwvbXNSMEdEYTdC?=
 =?utf-8?B?b1FQVzdja3BlRWFrQTFZNlFBa2ZxYVpvVE5jQ2JMeTlPV0paRWI5NHUvVjdt?=
 =?utf-8?Q?F4pAc7?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB9982.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZWhBclVVdVNrR3c5TnNwT0VsWUJDbThUd3dTOCs2ZERoYWtUV2lWZnZreHdr?=
 =?utf-8?B?RnFraVJ0cFljenlIOTN0Tnp0dFpIN1JMcUoyWTNQNHZ5STZiVkJWN2J4OHlh?=
 =?utf-8?B?YWpiamlqend2ZWIvMU5sUVRwTDBFcHFjTFo2clZxTkdOQW1jYlZzdHU3RUhF?=
 =?utf-8?B?NUJXMm50RDRaZnhsZm44K3pCSU1DTWtQcmw3N3dKOG8zYkk1QmhGZ1R2R1JB?=
 =?utf-8?B?YkV4YVJubXZ2SHVTcGlkc1hGckdYTDQ3aktmbDRPRE5vMUh5QStZZVhERlM3?=
 =?utf-8?B?cjRrYk9vRXhiTXVpbENIcDIzMUhOWWlKdHZscVcydElWcU9FdFpseVRsMmpl?=
 =?utf-8?B?Y3lLQVYweDFhRWMzbDEzVUlLczd5VzZOTFZ2Vmo1aiswOEcyaHduc1MyRjBj?=
 =?utf-8?B?VzN1TU11UGJGTWc2b0xNdWxzSjByaFAzR2hvdnNrU0dnZEw3a1lkNkZvdUoy?=
 =?utf-8?B?M1NVZUxPVzdTZ3ZUUlg0SXJFNTY2a1daZFJFWHJjcnNiM25ZVW40dGhnM1dk?=
 =?utf-8?B?UW01MGtJN0E1OVhhWnYyRTRsL0tpYWhoWGpzVzVKSlNONEtiVEFSNFJBVjRD?=
 =?utf-8?B?RXdXcFF5b0t6QWY4b3RQdklzMVVHbTRyK0RTSFlDc2ZLSWFGRTFOT3hOVnoz?=
 =?utf-8?B?NThZRUJQRTZwcHpmc1RjcFdyVHpmTThPWjB0RlVkdmN4KzRHVWIvV1VKUkZJ?=
 =?utf-8?B?UUx5ME9POGJpNFpZNGY2Rlhxb29TYmZNWEdOZzhDWGMwU0pqclNZL1JDWDBM?=
 =?utf-8?B?cWxnaEwwNjRDaTJ6c25iaTY1VW05d3BGTkI2VlpyRm1pZjhhT2dJQ0ttWnZR?=
 =?utf-8?B?aHc2cEJ6MzArVWVGTnpjc2U4SWIzUTB3NU1GV0FqSDNFUS80TDdIVUZxZ213?=
 =?utf-8?B?M3RzWDl1dVc0QkU1eTUxODZXMWFzWjNvNUpUU1UzbWI0LzBLcFMvUHZYT29R?=
 =?utf-8?B?UVhwN3RCSWlUOEw3YmxjK1ppVFQ2WnRUd0QrZVhnVFR3OGU3YjhFdXpuUWVZ?=
 =?utf-8?B?WHg3czRuNHRocXZ2aUt3UmNzbGxSRkFpQ0o2YVM2WTZ5Ry9hVm8ySUFxajJG?=
 =?utf-8?B?blZ3OWk0djFYQ2UwRkRkd2d1OFpWZHdSWkwyQWU3RklWeHM5b3hieE4vT2N6?=
 =?utf-8?B?Zk1GSDNCa2xlTld3U3dzNlhGZDlLdm12c2txQkJnaHhjTUFRZ2FVM0tiZ3E5?=
 =?utf-8?B?cVVFd0lJbjBwa2pVMG9nY2JMSXhKS2hhLzFOdXF3Y0lnR2pIMVBKeWY4UGFT?=
 =?utf-8?B?SVVlKzBVMjFkcFlnd0ZidmdkOUZHVzl5RnJwZFRIaTBWY0pzWStxNDhnYTRZ?=
 =?utf-8?B?NGMyZmVRRTl2U0R3SzRqYktZN3g3dFZCWDhLQjczUUhaWlBhSUhEcWpOcDlB?=
 =?utf-8?B?QVdOOVJEVi9kRjc1aElvQ3hrT09OWkZKeEd5QWtSbGNwWjFsZ1FJTkN5RkRP?=
 =?utf-8?B?TkFGbTFZUzlPcXZ4OHVlVE9ocklNM0xrd0lhRmxXR1J6dFVUbHBmd0RXdmZJ?=
 =?utf-8?B?TUZIdjVINDJNVEMzT2NUTVBaM0hXN21GZFNqd3RDZ2xQbURybGVheHh1V1BS?=
 =?utf-8?B?dmVoRjcxWDF5Z1pjQmJEK3VsM2ZMVFNLQkxuejd4ZWViZ254SkpKQzZhZ2tE?=
 =?utf-8?B?b2lDS3ZWTVJ4YllOcnFrZ2N6OGlnK3dKV01KWVlkdnB4MGdLS1J1SG1BK2NM?=
 =?utf-8?B?NUIrNTl0TkxobjQ5bTZtUjZPdDlrUTlMRmR0UWdvNTUvYk54YXcya1JXbWFD?=
 =?utf-8?B?QzZpei9rd1A1SXdYUkZLUjFhczNQa09vY2gvYVcxODl5RFFzRzhVNDlUWnZo?=
 =?utf-8?B?MXB5MUtGdDlqZVE5TEdidlZQUE5ZNjY4bElZVjU0TzRJNDhMbmgra2NiZldv?=
 =?utf-8?B?OHRLTmFPVitwUUpydzZZdk9mL2xxVVJCd1I1WVlBSlJlQllLRTZWSUpYQnBl?=
 =?utf-8?B?V2xYVUhBZHBEMllJSnlFQ1BlWnhBZ21UVjh5eDFQeUFYY1poR1JSb01zcHNT?=
 =?utf-8?B?RW96dHpzM2VSd3FDZmxhYXpvbTlMdnRNRmlvaVprejN6Q1B3NXltcVAvRE9t?=
 =?utf-8?B?dmVJTkk3Q09ZWVJFTWJSL3IxU2tIRHpPVHhaYWl6NDdTUkxpMWllLy9uRWU2?=
 =?utf-8?B?eWRJaEdtT1hvVG5rQmh1YkJ1amw5ZHhtd01MYmtEM091MlVRMXIvdlR4dnBV?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB9982.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e701da91-a36e-42a1-af78-08de0fa095c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 06:19:11.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAbCnsPV3o9qnUmzGHf3p5f6CfdNVOO1V7bXj64Pr9SJ5bYkOa1WEDci7RTH6pbB+AtObb7B6+3xsi8+cPUQM1ETpbCYuZjwFpLK5K0KqPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16084

SGVsbG8gS3J6eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3IGNvbW1lbnRzLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
emtAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTYsIDIwMjUgMzo0MSBQ
TQ0KPiBUbzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg5Y+4IOKWoe+8oe+8qe+8pO+8o+KXi++8
pe+8oemWiykNCj4gPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+OyBNaWNoYWVsIFR1cnF1
ZXR0ZQ0KPiA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+OyBTdGVwaGVuIEJveWQgPHNib3lkQGtl
cm5lbC5vcmc+OyBpd2FtYXRzdQ0KPiBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8pO+8qe+8
tO+8o+KXi++8o++8sO+8tCkNCj4gPG5vYnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsNCj4gS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+IDxjb25vcitkdEBrZXJuZWwub3Jn
PjsgUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IGxpbnV4LWNs
a0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBjbG9jazogVXBkYXRl
IGlkZW50aWZpZXJzIGZvciBWSUlGIG9uDQo+IFRvc2hpYmEgVmlzY29udGkgVE1QVjc3MHggU29D
DQo+IA0KPiBPbiAxNi8xMC8yMDI1IDAzOjMzLCBZdWppIElzaGlrYXdhIHdyb3RlOg0KPiA+IFVw
ZGF0ZSBpZGVudGlmaWVycyBmb3IgdGhlIGNsb2NrcyBhbmQgdGhlIHJlc2V0cyBvZiBWaWRlbyBJ
bnB1dA0KPiA+IEludGVyZmFjZSBpbiBvcmRlciB0byByZWZsZWN0IHRoZSBhY3R1YWwgYXJjaGl0
ZWN0dXJlIG9mIFRNUFY3NzB4IFNvQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1amkgSXNo
aWthd2EgPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+DQo+ID4gLS0tDQo+ID4gIGluY2x1
ZGUvZHQtYmluZGluZ3MvY2xvY2svdG9zaGliYSx0bXB2NzcweC5oIHwgMzMNCj4gPiArKysrKysr
KysrKysrLS0tLS0tLSAgaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC90b3NoaWJhLHRtcHY3NzB4
LmgNCj4gfA0KPiA+IDEwICsrKysrLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQt
YmluZGluZ3MvY2xvY2svdG9zaGliYSx0bXB2NzcweC5oDQo+ID4gYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL3Rvc2hpYmEsdG1wdjc3MHguaA0KPiA+IGluZGV4IDVmY2U3MTMwMDEuLjJkYmQ1
ODg1YzAgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay90b3NoaWJh
LHRtcHY3NzB4LmgNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3Rvc2hpYmEs
dG1wdjc3MHguaA0KPiA+IEBAIC05NCwxMCArOTQsMTAgQEANCj4gPiAgI2RlZmluZSBUTVBWNzcw
WF9DTEtfRFNQMl9QQkNMSwkJNzcNCj4gPiAgI2RlZmluZSBUTVBWNzcwWF9DTEtfRFNQM19QQkNM
SwkJNzgNCj4gPiAgI2RlZmluZSBUTVBWNzcwWF9DTEtfRFNWSUlGMF9BUEJDTEsJNzkNCj4gPiAt
I2RlZmluZSBUTVBWNzcwWF9DTEtfVklJRjBfQVBCQ0xLCTgwDQo+ID4gLSNkZWZpbmUgVE1QVjc3
MFhfQ0xLX1ZJSUYwX0NGR0NMSwk4MQ0KPiA+IC0jZGVmaW5lIFRNUFY3NzBYX0NMS19WSUlGMV9B
UEJDTEsJODINCj4gPiAtI2RlZmluZSBUTVBWNzcwWF9DTEtfVklJRjFfQ0ZHQ0xLCTgzDQo+ID4g
KyNkZWZpbmUgVE1QVjc3MFhfQ0xLX1ZJSUZCUzBfQVBCCTgwDQo+IA0KPiBOb3BlLCB0aGF0J3Mg
QUJJIGJyZWFrLiBUaGVzZSB2YWx1ZXMgZG8gbm90IHJlZmxlY3QgYWN0dWFsIGFyY2hpdGVjdHVy
ZSwgdGhhdCdzDQo+IHNvbWUgbm9uLXNlbnNlLiBUaGVzZSBhcmUgYWJzdHJhY3QgbnVtYmVycy4N
Cj4gDQo+IE5BSw0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpJ
J2xsIHJld3JpdGUgdGhlIHBhdGNoIG5vdCB0byBicmVhayBBQkkuDQpFeGlzdGluZyBjb25zdGFu
dCBuYW1lcyBhbmQgdmFsdWVzIHNob3VsZCBub3QgYmUgY2hhbmdlZC4NCg0KUmVnYXJkcywNCll1
amkgSXNoaWthd2ENCg==


