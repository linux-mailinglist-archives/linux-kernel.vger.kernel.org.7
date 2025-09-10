Return-Path: <linux-kernel+bounces-809460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B321FB50DED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6874E440BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A92D481D;
	Wed, 10 Sep 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AxVd3oQe"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5C2417E0;
	Wed, 10 Sep 2025 06:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484866; cv=fail; b=PWtpV/MsXlApjZlfWOXysXOsXgmjnsfNESwgBvqqms3WtoFRq6z1jU6Uz2+EH2E2BS1Dn5jMqf3z06V4+Q5iygiPV7R0xJ9ZkYL8BmGZljkvU6v4NMjK6MCocrRhQerhC5Ivsb4tWMjtMrVlWFZoPMVSSHNShyPlf0m67dn/kJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484866; c=relaxed/simple;
	bh=9O09rpDyOme9lNYfM/k376W0vSNGYVAqWJ++kX2/fmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmUH9yVM0BrOjvd3k0f4H6Rv1vgAaACNGlOP4rOtQBfM2q6UIumQMqNOJoFtwqB0NKpzxFnnkqnFviHeXFkWZeMz3otsEPdV4QJJePRCsXb3fXWEnRDmW8Q2ZQOCyKbuDkrR1fAivVfcx+lreC6zRjonwOaIYfFLqvKhArxI1rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AxVd3oQe; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb9umoh7v2AgbnPQYTOGNow57vhmnXoN2jZdo/HZxwN1J9LZwcLg/sAaQ3v+S3sQ0/wL82qEev9V/hfusZYeWIx2L1Z217LfijJNcI3yQBjGHuqnPKGkU5L1ytwrXOGi8uUI9PH6OSgj5JeTNW4Wvu8fUS7yg1xQZzGJmBYK7MDEI+ZwdPCyhqIYcWak6zz0iGDVBxxlBiN5r/7syTUFoyQTDOWxy6sRUI035A+SenMxoiXHSDnuRI2Sqs8rDO2LBRX0qaVzNckcVb/zLjkAU9JqZGCVyMbQSJ6MNQNR/agkJjgSemUzPKaoNxOdeXM04DDveVWb1ZbhKBenVP6Qlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O09rpDyOme9lNYfM/k376W0vSNGYVAqWJ++kX2/fmk=;
 b=YJX63tvJNRAeFlwsNaeCr7t2Tijw9sT3cBCxwcIYob5gxArpwBLW3+QG//dGdks0aw3Vg99IZBODGWMj3cmqWkaYEBQOjFYKYgFwqQuESNr11hHKQ7IYAa2q4awpwccxnuVk7syukbu9g8eS5JbqgaAFQpUtG1ntuuFsJxrFciGsQkZUdgPRddd3orgVJcEKIgB0FqlWAOSvFVkoP7KNndM7yr7cSUH9KcYLP8gMprr8rPfpKeABEkEgYSZwlXq2Vrw4hFDLnETBd5j9aVqTHncUHkiXCuQccyficXDUYHOlPiRn9AHYnZoc5lOcm43lSj2WDrVbY1r2F+Gie4+cpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O09rpDyOme9lNYfM/k376W0vSNGYVAqWJ++kX2/fmk=;
 b=AxVd3oQeuvnG9k9BodPoV0R7bQrNbtrJQKoePvl1tZMc8uY77lzLHQIlQkF5YLoBG/8DWiCfXtkbjaOewXeHcc3x0qA25tCuIWiVcsrSoLtTl2J91MMDnLsWqyfgsOitzsJ2YXNMqmuTdcNZY9G1Ft2aKCNIXJtS+LQyAC05E0xo26f5OyNfmuMfpKoowmk5W6s+ry9eZaCtKLNGnWEqTGvCX8/H/TYko3H5Cr4V1D/W60+wbQ7Jwu6UTLusR8mcljg0lfaCDHVk8OiLUiqHN0ULrOY5lvwvmORNQ0mwdeumrRe8HyoEvnkVRFJQ3Kp5hKNJfJVstjhJydSVgLJrKg==
Received: from DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) by
 CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:14:21 +0000
Received: from DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347]) by DS0PR11MB6541.namprd11.prod.outlook.com
 ([fe80::e268:87f2:3bd1:1347%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 06:14:21 +0000
From: <Durai.ManickamKR@microchip.com>
To: <conor@kernel.org>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Balamanikandan.Gunasundar@microchip.com>,
	<Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 0/4] Add Microchip I3C controller
Thread-Topic: [PATCH 0/4] Add Microchip I3C controller
Thread-Index: AQHcIXrk5kZg+kX5Z0eoZKz+GqPMYLSLQgOAgACvUQA=
Date: Wed, 10 Sep 2025 06:14:21 +0000
Message-ID: <d3daaab9-71f5-49e6-b3de-b05339fa7adf@microchip.com>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
 <20250909-pointy-tanning-8e7b4320979d@spud>
In-Reply-To: <20250909-pointy-tanning-8e7b4320979d@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6541:EE_|CH3PR11MB7392:EE_
x-ms-office365-filtering-correlation-id: 21e8683c-f963-4455-5d74-08ddf0314868
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVR4VE40aHhxaTJiYWZvQ1VwUVRRdUxzeFVhQTVjSjZNcDJHTDRUcVBBYW50?=
 =?utf-8?B?ZHFuT2ZDbHJrRW1WTk84UDAxYzF1UlB5VUVQV3h0V0l1NEpYOTJwLzFPTnlQ?=
 =?utf-8?B?TXM5US96K29IdVlvZlcyWktFSmFRbCtLaHo1SjdVNlo2bEJVQldGZHh0NmVx?=
 =?utf-8?B?czhQSXhsZURjSkpuUmQvM2VNQUpsRG1ma1VocENaYUo1VTNiN0RpVkZGbjRK?=
 =?utf-8?B?VXUxK2JWSnJId3k4RkxKcEdmUEtZblVOMzRPbE5PT2l0QXNVS3E0RWN5Q0RD?=
 =?utf-8?B?VlEwMUxjbXhHK1UreWtyOGxqN3pKSkVrTE92dDNDUnoyTUxwNUptOENFcmt2?=
 =?utf-8?B?dmNRVU5wY2hvUFZsYkh1VnhWS0dIeGFJeDgxZGxTTmpzR21LcTR3amlEL2FH?=
 =?utf-8?B?Q1I3Tnh3VVo5aldxQkprcG5OUXRZZ2M4eTJRZ3dlTHUvZitaUXdqY3pCQzhJ?=
 =?utf-8?B?eDNDZkNmSFJXK1NVbTFsNTdoL2QvYm5GRmQ4WTNIWFR3anB3QVNrVDZRS2R0?=
 =?utf-8?B?aXhQNEc2OUNEaVhGaGFNQVNTcnE3UCs1YWpsK05CTFU4YjhJSjZZVVYwdndL?=
 =?utf-8?B?aWFNc2VuOVNvZkFkcjc0eCtTWXNleHUzakQ3STdMU3YyRVdlaU9xemRxYlJi?=
 =?utf-8?B?bzJCNnpqWTI1cEZLZFNObzRsLzAzUldUa3lNOG5VMXRSTk5PSFdHdjRDd0Ix?=
 =?utf-8?B?TjE4MjV4aThNQlB0S2VYSFUxbU5KcnVXN1IzYTFIL0s3NnNaY0ZxV0RnSlZR?=
 =?utf-8?B?aTAvc0JtbzFzWGFBeUROeEtDb0VWRWovOE82N1VwOHFad1lTSHFpanRiNEF1?=
 =?utf-8?B?aFZiZGdReHdZVk9SRVRPWTc3RmIreFZ6M0thakhFQ0FvYkdXbFFaa09FNzZx?=
 =?utf-8?B?WDJqYkxrV0hIOVBrWDZrcHNKWVpGdExpWExBeUU3bndzdGJQZmxwK1JoZGtJ?=
 =?utf-8?B?aXpBSmlkNjZGWUJmZ29yeFJ2QklJd0JyYm5LRXZiSEVEUlNSNzRsUFlPYi94?=
 =?utf-8?B?OGRQbXJRamgraXFTU3V4NmVEdUNDTlVDRlMyR2krYVBrMGFJS0VwSWYrUWlL?=
 =?utf-8?B?TmNZdnc5dURCZXNHa2xqbUJjaGk2clFSOCs4c2ovbEdudzZQWFVQTERsTTVM?=
 =?utf-8?B?VHdFLzgvNHdhL2NrOWRWRk80UnpSdmxqMjRiMGs2SDh2bExQNE9tVjZQZ3d0?=
 =?utf-8?B?SVlTTmJ6c1czWGdtYXZlbW1KTkVSSmVWbjNndVNsUnhwck1qZlpQWmNhdytv?=
 =?utf-8?B?TjdWcFdJTWcyUXhkZW00M0w1dFM4MS9IK1hHUUN3eklpcHRMVVYvSHNYbWM2?=
 =?utf-8?B?T20wSS85SFp5VnVwdHcra3h4d3NWcGJoVzFVSEJVcUcvTXNPeVJVSVlQWFR0?=
 =?utf-8?B?Y0hjUUNFZ00zd000NEY0dzJscWRRWDJXVVVhc0VhSzhJVjZGMUJEejJZQ0tr?=
 =?utf-8?B?MUg5Z24xWjBjQWJlU285YmE3QkduZ1p3WWU1ZmlvdVlpZmxMb0xnQXhYZVRh?=
 =?utf-8?B?dVIyaWNhMEx3QWFSQitQb1B2dGdUQzJKUkNwNDdMbmFYQlJOYlcxY1lWYmY2?=
 =?utf-8?B?aWp2aFlFRExKQkVCczgydTl6eUtDSEdEK09sN1RJMXhFNWhJWVk3UUpMd2ta?=
 =?utf-8?B?enNlTUZNNlFaYWxuZUdWVUl6Rkx3TXdjQjg0M1daUUxyNHVlZytpNmhHckRL?=
 =?utf-8?B?R29vWVJ0SGdqZlZCRmxZNEhqYkV1Z1dVTFp3RkkraGdHS0RUdzgzVFZiZFlS?=
 =?utf-8?B?a3lyQ0NtcHE5SCs2eDVicHZLMHFTU0pFdk5MQmtNNUtsRVVLZkZyOUdNMmkx?=
 =?utf-8?B?UGRPTVhESFRsbU91NmxmZ0ZXM0plMkQ2S0NSV3UydHFBWVNEUnBFdEJJK0th?=
 =?utf-8?B?OFNBdXdMbUthT0cyTWhLZSttZlp3NHFtNFdGWFFhUVNVRlRtdVA0b3Uxd28z?=
 =?utf-8?B?VkdhTm53RGFrMFVKclpxWStVL002TldLQTNtbGJ6aUpkYytDcUpEejd2NVZr?=
 =?utf-8?Q?Y5AEjwVBpegCw77UsTyhf1AB9Ch700=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6541.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXRCdTZXV01BYU0rK1J5NUdpNG10dm83THJQdEFDMWxLYlFIaVdad0VRaDcx?=
 =?utf-8?B?NEJZRE5seEVhRFd0MC83WWRCUlZpV2t4cHRIZHRqL1VKSDB5QnQ1bDNNTlA5?=
 =?utf-8?B?TExGWnBQcHdXajUyVUVQTzVFSXR6SmdBeWRSaHd5RFlQMXhrZUh4cTNpQUNi?=
 =?utf-8?B?MFk1ZnNTSEN5bVRZbFB4WXh4K1c2SXNRZFYrU3lTTUkvZElsL0tOV0RtbDA2?=
 =?utf-8?B?b2pZSjJXa3Uwb0tTemNnK08xT2YwUVFXVGR0REVnV0FEM3ZJY0VCdEpoNFE3?=
 =?utf-8?B?NVBhVE5tdVF4ZjlDcXh1UkVIeWtDK09OeTlNdjBtWUIzbEJKQUp1WExUTVRq?=
 =?utf-8?B?SXJqTE1hV2cwWmNoNUZvYmtBdVVNVHhaeUdZMSt1R2NNQUtiTUFIclpJQUhK?=
 =?utf-8?B?RG5KbmprUUpOYlZwVnp5MzRlcW9COUlLa1J4ZG01Wk9uaEtjSnFjZjdpK0J6?=
 =?utf-8?B?MmdLMy92SnhaeUM3SG5IV1ZmVGg2bFdMelE2UlZtQ20wL2VBRWh1WmRzMnlO?=
 =?utf-8?B?cTdWK1FzNlJWWk44enVzUjE3SXYxRTBMNFMxZEpwbURCOGVLZVJVTE8rUnhm?=
 =?utf-8?B?Sko4dTZaYU1ORlhHcEFJSWVyT1ROUnEycWVEWTV4NFhYemExRTJRWkl0MUxz?=
 =?utf-8?B?bk9FN3ZyNnVRaFMyeGNaYkZZVHFGeUZxVURMeDRtOG5vZjhjOGtYMlI0ZjdC?=
 =?utf-8?B?VVNyMXBjSUtzWkYyY0xkQ05mbHN2V0l3UXhwZGc4TUpid2plVmExTWR6NHh3?=
 =?utf-8?B?VldnQ3V4bVU4R3JHdDJQZHA5SGw3clNEb3BILzZmSDBadG8zdC9vUFZyVk1M?=
 =?utf-8?B?ZFgvUmNXL0MzSU12TGlobDkvSHJNWktVUVVvVWxLeWVGSCt6ZzRJYXREc0d1?=
 =?utf-8?B?MU5ibWJuNDRFbDB2aTRsWXp3bW1xcmY0K3A4TmpucTVwZjRrRFpFMWVxMlp6?=
 =?utf-8?B?UXhZT3pPUGtVcmZneEZmWEhjaW1mZ2ZyQ1U2dnB5VGJjeU8vQ3MwdEo2NUJF?=
 =?utf-8?B?OFV6VDA0SEpwRmxNalVsN1B0NHR5Y0wvVjlkak5teDNjcVpOVitsWDgvMW95?=
 =?utf-8?B?SmxSYkpFenM3S0xuVWVUblRrTlRkcWg1SHVHNGdBOVM4OFpxZDk1cW9BVHlu?=
 =?utf-8?B?Z1A1cU1wNmxPa2x3WWxKYXhmd3YvNkRYeDcyUENyRFZXMUpIUzU0MkVqV01k?=
 =?utf-8?B?RVFaRHNOT2NPcXZ0eDJHQk9TOUlXWFRDSXRoV2N0YUlKS0JIQ0RMdWJOUVhn?=
 =?utf-8?B?eVI3ckVPSmdGdHhFb1ZCamxaRXpjbE1sREtya2hkOVlSbnBtK0ZQbWpXS244?=
 =?utf-8?B?MnQxTHFjdmFKZFduYWJGWnVYS3pxNEJvZHlMUmJGSGhESXNRQzd6K3l1d1hX?=
 =?utf-8?B?cVdrRzcxakFqcVhYQUEwNHlJT2lSNWhiSFNMVWtkNGxIV3FLWUJ4c0E3RlR2?=
 =?utf-8?B?dW5xTUhhenQwTGpXZzg1QmNqTmc5YWxSOHpkVVk4bFBUWjBkWWt5WFdtV3BM?=
 =?utf-8?B?NzV0MEkveXBzc1lrWFRsR3NNS0hFZERVeXNDWkhqSmNSd2Ntd29odURGc3M5?=
 =?utf-8?B?U3M5SEJPbUxyb2JkRDg2Yms2Zmh0em1WTVVmT2RZMU1Lc09SR2tNL1BsVm4z?=
 =?utf-8?B?M1d1QWdndmlwVzVSamhRYUExU0tEdlhEN3JEM0JlUTVZYnVqNjhUelVKN1Bo?=
 =?utf-8?B?aitMQlFDVXI5enNpSWFRRVJPZlRVeUp2QmVtNkpiNnhEbWN1TGJNRVMvTGJL?=
 =?utf-8?B?RmRUd3BqNHNhWUFwT2dncHl3LzNCSjhxVG9kVWJOVU5ocGVmYXNZVUNkalJZ?=
 =?utf-8?B?dEpXdHJaUExYSys2RUYraVROSG5lUVFFZ29zekRvdDZFSG5EOUxMMG1FdmJ5?=
 =?utf-8?B?R0RMY05XeW91Mm9QajlJV2ZvSVVNZmJNdktaNnVHWTl2dHd3YUU5T0NZZUFX?=
 =?utf-8?B?Rnk0QzhYenVONmVPZUc1NVlza2U4VmVQc0tKQjAyZ25YZ1FBNkdkYytnR0VQ?=
 =?utf-8?B?N1dRUWhZTXVyeXBELzhEUjl2VHYyQVZjS0t1MVFEVlQ3OXMrZ1BMbDl4Vy9p?=
 =?utf-8?B?TGNucytndkd3cHozOCtKcEpScTk2WG9MdTVDZG50Vk9RWHBPdGs0bEZ0SzF6?=
 =?utf-8?B?eVVNbnFwaGRxZEVXcFFCOWIxYjYyWVcrV1I2NWZyY3BiVVRqL3FIVFdiYWRn?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <955A77451246394A81778490813C4671@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6541.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e8683c-f963-4455-5d74-08ddf0314868
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 06:14:21.5309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfPd7d54wyDgq8YEee0ISFnsdravQ8ewI7pkz/ZdOrLLF27/Yg7rOsu17rUL/uqaEHBVyGOkrMsH7RWF5VwO9nXr0NEACsc2dwgk0aZiuE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392

T24gMTAvMDkvMjUgMDE6MTYsIENvbm9yIERvb2xleSB3cm90ZToNCj4gT24gVHVlLCBTZXAgMDks
IDIwMjUgYXQgMDQ6NDM6MjlQTSArMDUzMCwgRHVyYWkgTWFuaWNrYW0gS1Igd3JvdGU6DQo+PiBB
ZGQgc3VwcG9ydCBmb3IgbWljcm9jaGlwIFNBTUE3RDY1IEkzQyBIQ0kgbWFzdGVyIG9ubHkgSVAu
IFRoaXMNCj4+IGhhcmR3YXJlIGlzIGFuIGluc3RhbmNlIG9mIHRoZSBNSVBJIEkzQyBIQ0kgQ29u
dHJvbGxlciBpbXBsZW1lbnRpbmcNCj4+IHZlcnNpb24gMS4wIHNwZWNpZmljYXRpb24uIFRoaXMg
ZHJpdmVyIGFkZHMgcGxhdGZvcm0tc3BlY2lmaWMNCj4+IHN1cHBvcnQgZm9yIFNBTUE3RDY1IFNv
Qy4NCj4+DQo+PiBJM0MgaW4gbWFzdGVyIG1vZGUgc3VwcG9ydHMgdXAgdG8gMTIuNU1IeiwgU0RS
IG1vZGUgZGF0YSB0cmFuc2ZlciBpbg0KPj4gbWl4ZWQgYnVzIG1vZGUgKEkyQyBhbmQgSTNDIHRh
cmdldCBkZXZpY2VzIG9uIHNhbWUgaTNjIGJ1cykuIEl0IGFsc28NCj4+IHN1cHBvcnRzIElCSSBt
ZWNoYW5pc20uDQo+PiAgICAgIA0KPj4gRmVhdHVyZXMgdGVzdGVkIGFuZCBzdXBwb3J0ZWQgOg0K
Pj4gCVN0YW5kYXJkIENDQyBjb21tYW5kcy4NCj4+ICAgICAgICAgCUkzQyBTRFIgbW9kZSBwcml2
YXRlIHRyYW5zZmVycyBpbiBQSU8gbW9kZS4NCj4+ICAgICAgICAgCUkyQyB0cmFuc2ZlcnMgaW4g
UElPIG1vZGUuDQo+PiAgICAgICAgIAlQdXJlIGJ1cyBtb2RlIGFuZCBtaXhlZCBidXMgbW9kZS4N
Cj4+DQo+PiBUZXN0aW5nIGRvbmU6DQo+PiBXaXRoIHRoaXMgcGF0Y2ggd2UgYXJlIGFibGUgdG8g
ZnVsbHkgY29uZmlndXJlIHRoZSBsc202ZHNvIEkzQyBzbGF2ZQ0KPj4gZGV2aWNlLiBVbmxpa2Ug
STJDLCBJIGhvcGUgdGhlcmUgaXMgbm8gbGludXggdXRpbGl0eSB0byBjaGVjayB0aGUNCj4+IHZh
cmlvdXMgdHJhbnNhY3Rpb25zIHN1cHBvcnRlZCBpbiB0aGUgaG9zdCBjb250cm9sbGVyLiBUaGVz
ZSBmZWF0dXJlcw0KPj4gd2lsbCBiZSBhZGRlZCBsYXRlciBvbiB0aGlzIGRyaXZlciBhZnRlciB0
ZXN0aW5nIChwcm9iYWJseSB3aXRoIEkzQw0KPj4gYW5hbHlzZXIgS0lUKS4NCj4+DQo+PiBEdXJh
aSBNYW5pY2thbSBLUiAoNCk6DQo+PiAgICBjbGs6IGF0OTE6IHNhbWE3ZDY1OiBhZGQgcGVyaXBo
ZXJhbCBjbG9jayBmb3IgSTNDDQo+PiAgICBpM2M6IG1hc3RlcjogYWRkIE1pY3JvY2hpcCBTQU1B
N0Q2NSBJM0MgSENJIG1hc3RlciBkcml2ZXINCj4+ICAgIEFSTTogY29uZmlnczogYXQ5MTogc2Ft
YTc6IEFkZCBTQU1BN0Q2NSBJM0MgSENJIG1hc3Rlcg0KPj4gICAgQVJNOiBkdHM6IG1pY3JvY2hp
cDogYWRkIEkzQyBjb250cm9sbGVyDQo+Pg0KPj4gICBhcmNoL2FybS9ib290L2R0cy9taWNyb2No
aXAvc2FtYTdkNjUuZHRzaSAgICB8ICAgMTIgKw0KPj4gICBhcmNoL2FybS9jb25maWdzL3NhbWE3
X2RlZmNvbmZpZyAgICAgICAgICAgICB8ICAgIDIgKw0KPj4gICBkcml2ZXJzL2Nsay9hdDkxL3Nh
bWE3ZDY1LmMgICAgICAgICAgICAgICAgICB8ICAgIDUgKy0NCj4+ICAgZHJpdmVycy9pM2MvbWFz
dGVyL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgIDE0ICsNCj4+ICAgZHJpdmVycy9pM2Mv
bWFzdGVyL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICAxICsNCj4+ICAgZHJpdmVycy9p
M2MvbWFzdGVyL3NhbWE3ZDY1LWkzYy1oY2ktbWFzdGVyLmMgfCAyNzA1ICsrKysrKysrKysrKysr
KysrKw0KPj4gICA2IGZpbGVzIGNoYW5nZWQsIDI3MzcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaTNjL21hc3Rlci9zYW1hN2Q2
NS1pM2MtaGNpLW1hc3Rlci5jDQoNCkhpIENvbm9yLA0KDQpXYXMgcGxhbm5pbmcgdG8gc2VudCBh
bG9uZyB3aXRoIHRoZSByZXZpZXcgY29tbWVudHMgcmVjZWl2ZWQgZm9yIHRoZSBpM2MgDQpkcml2
ZXIuIFdpbGwgYWRkIHRoaXMgYW5kIHNlbmQgaW4gcGF0Y2ggdjIgc2VyaWVzLg0KDQo+IFdoZXJl
IGlzIHlvdXIgZHQtYmluZGluZz8NCg0KDQo=

