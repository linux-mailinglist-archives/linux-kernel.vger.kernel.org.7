Return-Path: <linux-kernel+bounces-783883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0AB333D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C42034E1065
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB422577C;
	Mon, 25 Aug 2025 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="IomafAJ0"
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAF131E49;
	Mon, 25 Aug 2025 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087504; cv=fail; b=brGybXxlQ/JhdqVkRIiBjJGsVgZUQ0EhEJhpzzxIsxJLAu17UMLfJT7hR8654elv9AgCaF2Vs7a+7oxYdmJUcfVZ0J/RSmcef/MzL6jUASFDqwaxAbSNyM27mWqcDQM3ywVqKqODBStBR3a0dDTQEQuif3TV0a9J8GyNgOnr4Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087504; c=relaxed/simple;
	bh=Ou6RoFwtcwUYgt5qi6BN1cGERYgO5UnypVJEGYb14VE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQpwgJTQfLpWmPm+aqQeGsBoDCDlq8clVKlGmHTvx7eA49JRvJu3LZ8G9OoGg9FNx47iB62Bqhi5/jWzzDz6FlKhc9w5bI7OZnBs8Ns++5UhpT/WGpT804Is5MRE1nK0mOWbhsz6aOVlwPF2/BtwhaNMryCVRy0N4Dwe4UTY+DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=IomafAJ0; arc=fail smtp.client-ip=210.130.202.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756087479;x=1757297079;bh=Ou6RoFwtcwUYgt5qi6BN1cGERYgO5UnypVJEG
	Yb14VE=;b=IomafAJ0y/fPpDm9logpa4w16cpilEwcBxBRTXQYuHoA3aUVuTGExoTsCVVsyXWslt4
	Wuo60Rc97oiYypLCxCtWAcYk6G7FNipEyQvlaLuwN0zdDOlwOWGSnvQfCXHwcBP13+YznAHPJd2dz
	lu54FTGrTawqm7+BbLVZFRLyOxCWB2MZo/XPRgfSgEDYJwku7I5O16cyHWXWsW24v2Sw2++z71vWt
	zcKg46y7wnoMIOHaDHk8XW2mReqVtjC/eW7Ghip6/fMEn5YUQj7YuJA/JqvZCWm8zIh9KjuqanMq2
	IxUcCk1gGWGTADjHeD3H7BgeqlkGWmN++PR/FU5d0AbQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57P24b3l102292; Mon, 25 Aug 2025 11:04:37 +0900
X-Iguazu-Qid: 2yAbyr8UtJ2sxyF4Mx
X-Iguazu-QSIG: v=2; s=0; t=1756087476; q=2yAbyr8UtJ2sxyF4Mx; m=0bJBiRjsFgC3/BV5xQPaj7oPdn26a1PIhp+oZaphi78=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c9Dcy2kSPzyPQ; Mon, 25 Aug 2025 11:04:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRRboVL69tW8BnSVoBkILaKW9wmpuavpWy+2Pq1wpqcgOdMP5Q9xPA7H79ZMxTyKDlvdYinRvAKce2aP/Vwr+DClvEN7Fd1g7dNKIG9/HWj/Dxwy1EHm1J3ni/4r0eRpdGMzlJCeG7H3wqy+4csCmdUN1YZhiYm/zjREwSQtfPI0w9/iTNmnTjX4IMUvR4/FsTZzybNbq9TbYhWaAoIizAoUvs2R6xfZSEDTnipgNu9Tcop/RF6pHI+kXDI3pWXbSLeSQh0089kQD15t94y8p7+NZvOyRu/HHOkOIR5zwXhLHEm22NT5l/HmvGj2L43ww6VHXoTlZrCOWN7079kT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIiFL5JFSujsrVEFpL/PD7SOluDax3l3m9cCi6HEHj4=;
 b=ichwlvg+pLXbSy2Ldh086r7H1XexxAzTY8uNNt+Krzb1PrFfILlc1rM3wM5Z3iT1uTBBjMHLTE5y6Yr0dmrky2B3a4OlkMIISh/RZbXL7WASxmM9e2XXqppcgbfDWXIpVqxMngTgP8aZOM02SpeUarJaijryOzxyYnUNupNqGObBeatOjA75+I0Wk/ddM4EKhO9/2qvvfPnON66xR5DAfpnMXRW4IfWIhqYxiH1m19ev06YILf1raGoAZEMjg8IkYzx7JW/0r4adYfxrOlcEDIpTNiYQ+6WHk94zlq2OAPkZ0qUrQFTlTxpHUol0a1YiV7MWUfaKPovMOi8YF+Lk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: toshiba: tmpv7708: Add default GIC address
 cells
Thread-Topic: [PATCH] arm64: dts: toshiba: tmpv7708: Add default GIC address
 cells
Thread-Index: AQHcE2locimWLk8n+Eqsjo1yNhlnVrRyoXyg
Date: Mon, 25 Aug 2025 02:04:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148188286DFE66C70C5770E86CD3EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250822133340.312380-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250822133340.312380-2-krzysztof.kozlowski@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12846:EE_
x-ms-office365-filtering-correlation-id: 8d276723-257f-466c-ea8b-08dde37bbb83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VFhiZFpqQzgwSEljbWhZeWdVbmNwT2hLM2kvSmcrS01UekxCOGd0R1Zl?=
 =?iso-2022-jp?B?YmQ5Rk1DbSsxL2IxYWl6c0FqcGVYVit6SGtKemI4eHdQbmpwWjFQK0Yz?=
 =?iso-2022-jp?B?RmVyK1lIK3p2VjhZOUZnWDJDN1dDQlBSbGZpMzQyUk1XMStHS1VsUSty?=
 =?iso-2022-jp?B?eTY4N24yTTdKbExjeEJvMitJMzl4eHBrdWJHcFVGSnh0ajBvQVNIZUhR?=
 =?iso-2022-jp?B?QkZ6RUNMUXphVitNZGZ6ZmNYb0RFemYwUHdGVnEySExSV1FDd2wzNTkr?=
 =?iso-2022-jp?B?RHl4UUlYL1RXbWlKUjlPb1FSNnh3WmVlOEJmZlMwNTI0QTZOUDE2ZWlV?=
 =?iso-2022-jp?B?YmhmV3FKY0pKbmNmZ0QyWjIvWlZObDB6Qm5vQ2d6YVdRM21UNG9mQU5W?=
 =?iso-2022-jp?B?TkN0aE1BZ3NqekRucWp6ejBqRzVOMDJnanBXZnNTU0JWZDZ0TmVvNEJ2?=
 =?iso-2022-jp?B?TDJzbTZmWERjcEJzSU8zdDNPK1VzaElNSStlODBmMzlOR3F1Sy93MGo2?=
 =?iso-2022-jp?B?a3pOK2pZQXNhd0hkV3J2eVNBVHFZVnkzWDI5cWZycys5Qm81TVpLdlIw?=
 =?iso-2022-jp?B?SVI5NllwaXFTSTI0NUVlM3N3RHo1ZmdyckxnSGFqcjB4MS9NYkZYTGhY?=
 =?iso-2022-jp?B?NmxtcEE3ZmpiQlZSZTVEd2VzRDFsTkhVcEJtOHZjYTJoR2hBcUIyWVNO?=
 =?iso-2022-jp?B?RUdTZFI2RWlBUVhSZUxxNXE2dzBFYTRtSjZTR1RDdHhmKytJL3c4Q3BF?=
 =?iso-2022-jp?B?RHdpbG9PbjQ0enM0QTFodFhPNkVGblAwUnQ4SGVCOHc4NUs4SERPREta?=
 =?iso-2022-jp?B?eVk4SXJqQzhGNWZqNXYxUE5xMmdsdTFtZVdqbGRWVnc4UzBPVHVPUGdo?=
 =?iso-2022-jp?B?d2dLMGlucktMbDRTZXIxcnZVbzBLdnprN3pEWVRDVk5qMGxkMUVwY3M5?=
 =?iso-2022-jp?B?djROZVRMZmIyYTBRRmlYS3dnM2ZwM05UWU9ucWRMZFV1bmcrOTA0VWx1?=
 =?iso-2022-jp?B?SnRyK25TbXZIVnV2bWgyRTBhVjZuZ3c4SHQwWGNWVmhLYVJBcmNXU1Fl?=
 =?iso-2022-jp?B?UUlPdFdFUDJyM1ZkT09kMTVjUGhtS1AwSkRyQ29kODVlaUIxSkRHRjVy?=
 =?iso-2022-jp?B?ZElkdSt3YkVyMlVGcmppdkpWQzMrMUZwVEhoMHZLREE1Tm40aTVEUnhh?=
 =?iso-2022-jp?B?U0xHTWJVQnFXS2pZS2tNdUViNUZrZ2MvNmdvaDUzVzFkTlVscWI3UVJW?=
 =?iso-2022-jp?B?Mjc1MUR6MDB5NmZqWGZtd0E3bUdEUW82RVgvZnduVGM3MjRHM01mVXp6?=
 =?iso-2022-jp?B?MEpnekhRRU54aEJuR09CbllmMVVvaXQ4a0YyTFNmaWJpM3Q1V2FvRWVT?=
 =?iso-2022-jp?B?YWZ2MmJpZ29vdWtzdGQza0R5RUo1UjdFU242T3o3bzdDYlAyQ20rSmpa?=
 =?iso-2022-jp?B?Znc4ZnI5Q2pSejFqKzh5N3liL3Nyb1VhVDZkRUU0Nms4MjhySTFaYWto?=
 =?iso-2022-jp?B?VWhpQXZNWTc4SHlBVlBhQ0pxYVFKSzVmbS84V3JIenBwWkJvb09aV0U0?=
 =?iso-2022-jp?B?UjhySHpqRVd1Q09IRVZYekMwQ0IwbTFFOU1YY2VLOFpUZS81ZE1scUVv?=
 =?iso-2022-jp?B?Y0dZa1Q3YjVjbE8wQmtOaFFHaTZhWmJwc1RkV0pFeXJLbjNCcmFXaG50?=
 =?iso-2022-jp?B?REg4eThyMnJMdVhUQmluZXI1aHdyUGc5dW8yZ3NxWEhNeitRTHdHMlIz?=
 =?iso-2022-jp?B?V3VvMlBoK25obkFNVWRVR2pUVmlXa1dHNGZENy9zamFoUEtGd2YvcHE4?=
 =?iso-2022-jp?B?Mmp6TnNVb1FSdW1hcE9qZnpZVG4vZlI0NDE1VEJTWWt4K2VDY2cvUXZj?=
 =?iso-2022-jp?B?Vm00ZXNwb1J1V2VUSWJ5bkxxWDlkTmZoajA5bnh5Ynlla1FVanBlTzFl?=
 =?iso-2022-jp?B?RnZPSURPcExrZlRKbUliWXM4TjJFVE5acEtYeGpSL2ZuZkZ2d1owSDJz?=
 =?iso-2022-jp?B?cmhpK2JDL0wzdmFiSWxEWDNFVmNFQzZMMnB6RVJyTzZCMVdhcEt5YkJi?=
 =?iso-2022-jp?B?dnRBME5UM0pKVTFVMTFPVnc3M3Q2WXZhdklNaFFnQTNsU3FWRk03UFZZ?=
 =?iso-2022-jp?B?NmlKQUF6MDBkZ0xCSloyN0hjY2lPcW9nPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b25XWko5QnNkemw2TVpHckVHK0tmMzNMWEhmZDdnVFhEK3IwMDM3VEN3?=
 =?iso-2022-jp?B?bzN1ZUJ6Vm1kRTd5bjB6K1lSVm13NEs5Rk82R3ZBdWhUNUprSjMyb21y?=
 =?iso-2022-jp?B?TnA3SktvUmVIOEsxUnBBaE5FbVZPRkZPdldwdTBkdUJieit0NWNkQTZQ?=
 =?iso-2022-jp?B?VmExamwvZ2tSdHJNQW1HOGxwK05PZm1WcHhYM3BIRFRQN2djVFBaalpl?=
 =?iso-2022-jp?B?Z2ZUckgzditlWWFrWDV0WnJld0lLTXhuQWFjRXQ0eGFrcHgzMUpuaEV5?=
 =?iso-2022-jp?B?VzRFcWlBRjYyNUtJaHZOR2pvT0VlQjZXVE13SGNBamwzRXcwQWxTWGsy?=
 =?iso-2022-jp?B?MmNGd0FiN1MzbnBQS3lWcHRjMTIybGtJYzlpeitETUJQOTNDdlVwUEdJ?=
 =?iso-2022-jp?B?WGhud1FvUEYrR2FKSTljM3ptQ3U5NUxScHhxNXdSNWZPVDZLN0tCOWlU?=
 =?iso-2022-jp?B?b0c0eXFWbWJZb2V3d1RMOStKbWloYnVOVWlkaFhvTThmdmlTc084VDVl?=
 =?iso-2022-jp?B?TmhtUlljZDRZdDhtM1ltYzBjZlJndDkvUFNjUkVGTDEwcW83cEJsMXN1?=
 =?iso-2022-jp?B?d3dINFFKZnRhY2YvS2dYRXNUdis1cE9vSW9Sc29mTmlmS2NmbXE4dDl4?=
 =?iso-2022-jp?B?VExVT3RHV2taRUpTRUtUbGpXNDdOL1J0aUNmNmxncSs5TjlIQWF2Vmpp?=
 =?iso-2022-jp?B?RkZzZklhbm01Sy9hdkJkV2NEemVKa2ZWamoxdlkyVzM4VFAyaWxRY1la?=
 =?iso-2022-jp?B?Qmo1RzBZTEtJQ0sxNnZzK1pXNHNiZXdWYXBSWEV6ODRReHhsY3BGNDJq?=
 =?iso-2022-jp?B?U2lqK1Q1RlpBeVJ4d1gwVm5FZFBDTE9pOWhGWnNsUjdxNXhQVzMva0NU?=
 =?iso-2022-jp?B?RGRjSjdISGFMMFZWdEtaWmRybXdZcTNUSDIvUFJhL2ZnY2dGY29GNjBm?=
 =?iso-2022-jp?B?WjFhanRIbnJVWk44NW0rYmRFSGRCanZXWmx5TTFNYy92aVpMMW1SbDM3?=
 =?iso-2022-jp?B?eW5mY1kyYktZN2lKYUJqaTdvZm9FMmgyUWpqNit0OXFodjRmd3lPVzdt?=
 =?iso-2022-jp?B?dk91RmxUbG9Ta3lJclZJTGVYKzUvNnp6MTl5OWNPbzFSR205T0NaNDRn?=
 =?iso-2022-jp?B?Vi8ySnBPV25xN0UyZUljMHM3YmFqVVp2eGpUWXVYc0NVZlJvam50YmNa?=
 =?iso-2022-jp?B?K3M4c2VkeXczTUtselQvR1cvVXhkVGZ3Q2FtL3YvRTVhbStMQmhXanl2?=
 =?iso-2022-jp?B?eVlHOWpKNzF0cTF2WVEwNU55cFF0aTBRazdlTCtybVoxYUVJYTIwOGw2?=
 =?iso-2022-jp?B?UExyK28vc1YzNVZTMEdHY1VZM3Brd21wMlRtdnZLdWlHRFMzRW9HZkNC?=
 =?iso-2022-jp?B?UWRCc244VVNQazl1VXRuVmh6TE16ZDczREp0eW9sVjZ1Mkk2cVJxRDR5?=
 =?iso-2022-jp?B?OWNaVWlpTjd2VWs4RFpOcWFHTjVmYWhkempKeWxkVytIdVc0UjlWcXhG?=
 =?iso-2022-jp?B?ZlpuYTVFOW5TUDJEVGJBRFArbnVXbWRValpEMGtMTU5xbFJJWUZRNG45?=
 =?iso-2022-jp?B?ZlFvc3NyWGRrVG4vSVdicE1kb2FCY0FWMFNuNHBYUmtMMlBJSmE0Snpj?=
 =?iso-2022-jp?B?cFAwa0w4SkZ0M21Qd0Z1N3k5RDRwaktZenYySE0zTnhrNVRjNUhDVWkr?=
 =?iso-2022-jp?B?WUpmaURCYmFkWHZOQTlHRVRhdndqWU1SQlFIZitocWdyb2ZjdnZQUVdI?=
 =?iso-2022-jp?B?NWNOTkRHY0JCaHkwM1hjVlpoODZPMlVNMVZBMENFTFBGbkxodnJrWVRB?=
 =?iso-2022-jp?B?VlBjb1VNUWo0Umd6WlYvQ09nMGRwV21OdDBvcTNJYys1S3U3a0xlbEhV?=
 =?iso-2022-jp?B?eHBvZVJmd2Y4OHk4RDdMRlZ3VFBsa3Q2TG53U21sd0p4SDVwbFNXVEpp?=
 =?iso-2022-jp?B?aGkzZEtQblE0Y1BsVTcxcmtvVWlaMTdFY0VpNldSTnZHWjlTaWVqeThu?=
 =?iso-2022-jp?B?WC9NdjZSN1d4NTJ1bnZ4OGgzNUpXUEw4dFdUY3pSWGxnUElkTkV5M2Y3?=
 =?iso-2022-jp?B?RDlxeHAxYVNxZEt3YlBKUWNlVFVsRlJpeDNXWFNaS3doZFp0L29KNmtp?=
 =?iso-2022-jp?B?ZmRWOXVBZFVkZElra3cvdkQzdTI5dUtGNnpGUElFOGRqRTNQTmZQOHJq?=
 =?iso-2022-jp?B?azNUL2dvUzVraklUblRkZ1pncnpOK0NDc2RKcUJDUWFtbFIwQWhCSlVu?=
 =?iso-2022-jp?B?SWRSSjFmRDJIR05QNWlWSTZJWk03ZUlFOGx0akF3NXVNUHFEMVdveGl5?=
 =?iso-2022-jp?B?TkRiNllCV2NLamsvLzE5NkNrTFFENldzOWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d276723-257f-466c-ea8b-08dde37bbb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 02:04:32.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xj2rtbW+CIynXkf6+MbJFyIetqs77/EHpTjuiQnrkF6W5TGoH8ItA2TdXBNpuJpMZswUQt6bIMItvOoArFtnkd1DifZe4cwWphOnZf7oQnjvod9VCO6hEgqYOmK8oCcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12846

Hi Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, August 22, 2025 10:34 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] arm64: dts: toshiba: tmpv7708: Add default GIC address c=
ells
>=20
> Add missing address-cells 0 to GIC interrupt node to silence W=3D1
> warning:
>=20
>   tmpv7708.dtsi:503.4-507.28: Warning (interrupt_map):
> /soc/pcie@28400000:interrupt-map:
>     Missing property '#address-cells' in node
> /soc/interrupt-controller@24001000, using 0 as fallback
>=20
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children, 2. interrupt-map prop=
erty (in
> PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=3D0)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


