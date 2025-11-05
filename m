Return-Path: <linux-kernel+bounces-886011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A82C34805
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E4718950EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE521CC6A;
	Wed,  5 Nov 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="E9pFT62I"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF211991CB;
	Wed,  5 Nov 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331795; cv=fail; b=UgLL5JJCNGBIUTWIZ66W5BZqvOfH0N/ZNfoSC2HuZGE3zQMTJe6Q+A3tadWgzYePNX8CBgLxk7s6IJ0uqKSL7TP/jyOLCGrbb/McnZ4kQqKGvGq51IZG1jIlrsHKl4ytv2Lk64b8o5BR9PiBxvi2ol0ShRMpDr++uwlXoG6Eulg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331795; c=relaxed/simple;
	bh=U3vCMDlRyroNJAAPoi2l5wHMRs+CdIefZUgn8+K2Rc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ApfUsLCqWv/sD6BuiGHNY8+Vnxzq+/I8dxPEUJ9u9P7WqExxxnLfwlypsGtUk2vsVhHnb9ia0Cpe85Api1FIzibVSLYf/BwjHsZroQ+YlKmxkCO+Zz/fwxPpElZU41HK1UGFpcXChRHGg5OKjPyvwXt0ymAuow4ya2OskEobUt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=E9pFT62I; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEIQhWqbqwGJl8MQ54CIKgqfyHVp8R9pZZyhzvwVdB+JT0zvyYprechI7WV7Mztc6aqTFShR4bQ6qkBGud3BEG7fdfqvyPFKJ1DSZ7n40424R6jd4xWkWpv4M7+SoXjoR8T5bnwirSTGixIoYMtiAcKzgr6b/cD1PiiSZ8X7NwoQahNKlDOxdKwopXqU7JfJ/1FGnLoN4Y94xqB56MwTVohCa6R/eoZvuImKOGumnQXFh3oCe+8/bTHQWN4ybjfoMXpqhAQg7ENNZUMwe1pxL1pblIUxU90ck4Vxassee1roG1Yi54yDK0dYV2KxlPkjYXUCOf3xJnit2WGN8/cDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3vCMDlRyroNJAAPoi2l5wHMRs+CdIefZUgn8+K2Rc4=;
 b=xWPeTHvAL9vEHZ5GTjfyduAd7s/+eqP5zB0tkmmFJAmTQZD4ABg8LRar1uZ8cZpCWFacosebGq8c8usfz26m6u7HxQ8flEUqVdvA98u53YIdRJFtqmNmAa8L4+ecLwb4HEXZxDiZHQZ28qodX+5i8Hg7xsFXPA7dW8bQ7ILo6oVoN+UDKxEMzfybCro0HvWDMFMAZvYG7+8x/zGH4I3g/jlEa7hVLfQB4PucesbNJGlyHC2X7y5Mmfs+8G9kS7T2YZ5Sneho6IRHpnvgHTS0uE1BzEVQhU+X5xMU407jnvKRS4z2nR44VqyCKQcOY1I89AC9b0d19CERXMO7Qm6wcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3vCMDlRyroNJAAPoi2l5wHMRs+CdIefZUgn8+K2Rc4=;
 b=E9pFT62ItkHEW2j66RQzt6NmpuVNcOZoMJYPwnH2737D6Dn7rxoE8WQKvP+T2PFrFV5CWTnc74G8ZrIGy/T8yA71MjT2jvkO6chlNd4gh7echAGbcPIufTdyYTztlcpxVaLm4K0griEXSrHr8ht1wA3JFqRss9nWOxV/burJHDR5VAgHvauRn6Mc/SEmQe9gHSVgvFXwkl9DeGhDN4vp8jF2GLgPY2pfxPpT94pEYtawcCSb+HciZyyKhtX75p712d+dkgF49asfltLl73V5hD/lPi3ykZnt93umSjszLL/Kbec+Tj2COO0bHeiCniXnv2+4jnuBjd+UcWMeZpf3TA==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CH2PR03MB5368.namprd03.prod.outlook.com (2603:10b6:610:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 08:36:31 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 5 Nov 2025
 08:36:31 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Rao, Mahesh" <mahesh.rao@altera.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Ng, Adrian Ho Yin"
	<adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Topic: [PATCH v5 1/2] dt-bindings: firmware: svc: Add IOMMU support for
 Agilex5
Thread-Index: AQHcTfvVkoqTt0ND40af56N0bit/H7TjvwaAgAADkwA=
Date: Wed, 5 Nov 2025 08:36:30 +0000
Message-ID: <9e08b398-f785-47f2-b580-424d08f20e8f@altera.com>
References: <cover.1762308672.git.khairul.anuar.romli@altera.com>
 <97c7c260544f2e2f1615e494408a608d6c731eea.1762308672.git.khairul.anuar.romli@altera.com>
 <20251105-giga-ostrich-of-prosperity-410d1c@kuoka>
In-Reply-To: <20251105-giga-ostrich-of-prosperity-410d1c@kuoka>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|CH2PR03MB5368:EE_
x-ms-office365-filtering-correlation-id: cee3c79e-28d0-4e3f-3a29-08de1c466b79
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWNDOTdKaFl6TWRndlJFVmJmRFpvMFB2M1NMd2hnZVo2S1dRNmVwYVgyeVNx?=
 =?utf-8?B?a05VOUpyUkdOK2hvUHgxN2lzMTV6UmpDS21xbmhpeld1aCtIVTZVbVFLbFZl?=
 =?utf-8?B?bnRiQ3dkVEMxK3NYN2ljSzlhZTQwRlRqV2EwaVFvWm1ZeVk5alJyV2tCcmJI?=
 =?utf-8?B?ZGYrYlVTVlM0bGdDcVJmRXNiMjhsQ0sveFVZRk55cCtVdE1BSjk3b0VacTh2?=
 =?utf-8?B?eFdCek0wUllwK3JzQnloVGlWWHM1MnFSRXJTUWVNcHNFRUw2OE1QaURsSkMx?=
 =?utf-8?B?aG92amd0NEp4TXVCNnVSUnpOZGlQdGREbHFETzV1UHVvM3NDUUdscVdCZXFz?=
 =?utf-8?B?MDVmQ2ZVbjBGRWIzUEZjTzc0RVhPazkyWGpkUXUxNmkyWjBGSWR4ZkhjcXdE?=
 =?utf-8?B?cFZlQzRXL2pyUWxQcG13K3Voc0JRaVg5WTlHcGN2WHJKaXRLUmRncXBKbHBp?=
 =?utf-8?B?bTRLcWpzdnRvZmtCdVBLSTRhb2xua0FSa3I2ZTh6alN6QVZ4bzR2ZytSU0l0?=
 =?utf-8?B?SWwzV2FsNWZhb0pTNVlCajVRQThVMFR6L1E4TnNVSS9FM3pyY1hOMmN2RVJT?=
 =?utf-8?B?Y2pLbWNrZ0ZhVFkwMkxUanBVaGl3TGJIRThCTGNRYndlaXI1ZEp5dWJ2amhu?=
 =?utf-8?B?alZYSUNQT2pTdlZRZFBCMEFtWmY0K0NvTm9pbUd0NzNlNjlHUjRuelBhK1B1?=
 =?utf-8?B?V1VJdkQwMENEUTErbzEvNmpqNUxOUFdyc1prZXEzL2lMZTJ4cHdLUHBwbG9G?=
 =?utf-8?B?UjVLRzFoWGlnMUQ4bjNaSENVVnVEZ0tEUU1iQlZtVktQRHh2Y3ptZWpKUnJ2?=
 =?utf-8?B?RU1Wdy9pbnptLzdERFVML1JKYXAzcEJzWldHQk9oYUI1TDhwKzF1dHVYNWcv?=
 =?utf-8?B?bmhnN2lCUER5WnNnUFJGSjErVWlCYVJySEU2SnZRNU9ya0VrZnJGc2VLTkc3?=
 =?utf-8?B?cGlmR3F0YUM1QmxwckpUNndUN1d1OW9EUzRIRVNBbnRiTzdEOUd5bUtBbkNQ?=
 =?utf-8?B?cWFKdHRDQzRMZWhNMzd1R1dWNC90NmhNVHNmdVkvSmsxM0xQK0NlR3FObTR5?=
 =?utf-8?B?dHlRKzVuc0UxSzFaV284NDA3dlhxZ0NKY2NxTGprdjFreXd3bFIwQmsvMVhS?=
 =?utf-8?B?Zk5Pa0VJcFNISVhMV1IzaVNoSjhnRlpRUEQ4RExZMHl2cXZsbis4MU4xSWhX?=
 =?utf-8?B?V1ZadHhsc1lWV0JtZ0p3cjF2V25JVldKQVJYbUc0bkowdVB6emhiVVJFbUlq?=
 =?utf-8?B?b1dHRHNTanRHUEFIK1E0eVhuZ3lDbXVOQWE1N0JqaEVRWVRQM1FKc21OTVND?=
 =?utf-8?B?a2FlYVNEWlpCQ3pnMFhZb2JEbUh3RUhPZ2I2L2hVZTFyWFRPbDVzYjh6NTkz?=
 =?utf-8?B?U2tKSEcxbWRvZW05NmM2RC9BNnF0OVcrYjhHSEFIcTV5MHhoblUxUVVuMEV4?=
 =?utf-8?B?SWFvVnhOWnZsOEp2aTlhTm5qd29ITmtQNUFYNk5GVENhbEdKVXFqOUliUWV1?=
 =?utf-8?B?MUZKMG8za25hYmJIZXFaQ1NFS0Z6dW12c0E2bzhBL0FTOThVS0F4endBU0dF?=
 =?utf-8?B?OGJZKzBZbDRuR1FONWZWWTB0VE1jVGpXa1dKOE90bEZlVFRMVm02VlhIWjMx?=
 =?utf-8?B?TjlzeEczZnlwNmxVdi9lKzNscTN4N28rQ0NwVUNHdXNvd1B2WHRxU2FDakFj?=
 =?utf-8?B?bVF6a1ZNbjJOdjBwZ1kvQ0wzTU9nWCsrSUlzaU5Jbko1ZXFSbmg5bzNReTQ2?=
 =?utf-8?B?aXJnTkpKN0t1ODVDVW5XRCt0U3NYeklvTU1GSUJwZENWc2ZuUEF1amtTRkky?=
 =?utf-8?B?Yk5ld29XdkU2UGZORGZUbFl0RjNlK25ZQXFjYVo3a2IzMmJLVkNKUzdwdUww?=
 =?utf-8?B?enhOcFl5MzJCZEhuVWdVTnRZcmhaN082Z21HbWI5RCtNaE4yYjIvNlBCRURZ?=
 =?utf-8?B?QUJpWTZWdHludExDTEM1ZGhPK0N1dXJSRVg0TDYrRDQ4eStRL0NPdmg4SGJV?=
 =?utf-8?B?eE9YeWhDbXAva2pYOXRPQS9UekRRVnpMN000SCtyMVBlVktNWDZSWFphb244?=
 =?utf-8?Q?3I77jp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjBaZ1hTTVl0a0ZENFlBUmkza1piK1VmY20rU0dpblZ3eUduSmFBWUpTY0Uw?=
 =?utf-8?B?LzV5VlJLaGNwenJXTlYwMkNqTHUvZytRMUhmUFJJYUh5M28wMTAxb0xPeTl3?=
 =?utf-8?B?czhtK3k3T2pDL3FFZHFrYXFHVUJIVHl6Y0s2NjEvUzVLUm02N084SHNSdDAw?=
 =?utf-8?B?ZHRNbnpmV2NqMkpXNTRFRWpJT28vdzg0VnRVUG5kVWZ4ZjV6T2lzendzMUE2?=
 =?utf-8?B?eEJFM0wvODBMM1JuOGRUSUgrMWd5L3g2MHFxZXlVZUNreXFSWkZ5VWEwK2px?=
 =?utf-8?B?WkZRSDF0UjNHTXViOStxS0gwdE9lY0JIRFRQT3VjZXhuU3lHREw1cmNtWHlj?=
 =?utf-8?B?cVZCVC9YVktLYzR0RGwrYThEMEYvK0NGRlpiUVFlVzQza0pyblh4dHY5Yis4?=
 =?utf-8?B?MC9MY2hpT2pQS0hVU3ZrZnhLUGJucDBmMDd5NDZpZWxkL3F4L2xZcnBQSDVP?=
 =?utf-8?B?UWpCWStCQlZKc1JzZVhWRTBGeURuQnNyRGZVbGRUMlJTSWdxallCUTlSTk9j?=
 =?utf-8?B?dDBIei9IVzZISHhianlCU05uQWhpZ01yQTBIdEpXYVRsRmNMSmE4aS9IOUUr?=
 =?utf-8?B?c01wWElyMGVQeW5JMGlEZDR0dVpZMEFrMjNWcWJxcVI1TEVmYzNtQk0rZFFZ?=
 =?utf-8?B?Wm81N3VxeDlaUmppQ1dzcDdCeGpGZ0RpZTVPTUd6ZmJCS0NjVkt2Z3c4UW9a?=
 =?utf-8?B?dE5rVW8yR0hNbFkxdnh1RWRhYmlRQ1kzQzJ4a3NDSC84U0tkVi92NVdkN3ps?=
 =?utf-8?B?ZS9NSVllTW5EY1BMdSswb0p2d0NoVTlwY2VXVW8zbWJZZkJFV2Vwc3RhUEdq?=
 =?utf-8?B?LzBCWHpkbkUvL0M4NkRReFlXQm9JYTZZbS9URnJzaFozOHNaS3NZYTRVREhn?=
 =?utf-8?B?U1RYelZ4QXlvN0JpVjFwYUVIZkhpblArR0N2d3Q1dHdqbEtDaVZDMUF5Sjh4?=
 =?utf-8?B?bk9EOVhhOWdzaUVlZmd4cGZpNm9aNjFobHVVWEJ1dlowVm1PQnVIUGlaaTdq?=
 =?utf-8?B?enJNQ0VUNWhuN1ZWMWd2c2VGTmlCcndjNG95ZUdBM2ZIVkord3ArTmw4YWZH?=
 =?utf-8?B?b0JZZ2FGWW5Ea0puWTZ3clR1YW5TYzBnNDh3dlZJNlNnZDB1ZU8vTkF1Q0h5?=
 =?utf-8?B?KzZiV1NCY3FNbDBQNk5Xa2NUUUs0aXZvQVlGTVEydVYwQkt6V0pWL3E5NS9C?=
 =?utf-8?B?Z3U2MlcvNnF0a0IzUmdnSHlIREMydWMrQ2RiSll0dDVxb1JsMXU2M3VNYnFR?=
 =?utf-8?B?Nko5eGtoK1VPazBqbzNPamdjNmFObEoxWHpxSVpYNXhiUit3UWZWN2VyYVc4?=
 =?utf-8?B?MjBCaUx1MU02bGlGT085TGRML3phdkwrYzBVVlFURFJnTjRiejlSdG4xcXJJ?=
 =?utf-8?B?ZlBiNTROVUpSV1hkT1BJTXFrWjdMeXRYTXhTTkt2REV1MW1MajZpakRPY1hy?=
 =?utf-8?B?V2tjUWdVOHdmWHk3VVkvbEVMVW5lRE5UN0VUWE4wOC92OHNPek45V0xjcWFN?=
 =?utf-8?B?TVlGbVJXOHkvTUo5ak9qbkNZV2Jya0JLaGc1c1ZBbGt3RU9HZUdKSXhIWTVI?=
 =?utf-8?B?UHBkNUhrYW9pZEUvQ0pNUFpaY3FvdTNpS3N1OVNQdmVIaW9PSFpyd0sxNS8z?=
 =?utf-8?B?VUw1NXJGZHl6cTRwOFRLdTArL0lBWGgrSWlrQk9oUnNnd0tpRm41MWFqWlFN?=
 =?utf-8?B?L2N1alNIbmhLQ0xIVlFUMEFRMzhGL1cxTCtVZCs1WGxKalVNVCszMCtLOXl0?=
 =?utf-8?B?Q0h4ZnpES1EzSzZMNlo1UFU5cmNGZzQxbkZjUDFYODhOdWp3UlZsWS9YSU5u?=
 =?utf-8?B?bDNoTG5tKzdFWHVzTE56Y3NHdDVqcUZSSTdtbzlYUFROTzBIOGp1cWN4MytR?=
 =?utf-8?B?V1BCL3gzSjRYVW1DS05PSFVoa2hWUzRBME1SWjdIdEpPdkpmYys1bWgwb0VT?=
 =?utf-8?B?eVhCdWVFNWZvUlB6TXZQS3ZMekEzWW1LZ3BUczhjUEFwa05QRzl5RElIL3Zr?=
 =?utf-8?B?cG5ZNWczY1pMNEMzcU10dzhRMmVPOUlNM3hldzVhdHRIM3B6Rk5YbTZPeVl3?=
 =?utf-8?B?MU1RWUpUc0NVNTI1M3IwQjY3cmM3Y1FTRkgwSS9ndFJmZU5uU0lUc29KeFNv?=
 =?utf-8?B?ZXlIRGJ0NnBpanpOWVlXbG54RzZLOHNjWFJ2Rm1ZS3JiTzRaSGU2QTI2OXdZ?=
 =?utf-8?Q?EIgX92nK3m8OBNZqaf4D1L8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20950E9ABC651948AC749B4D062E1F61@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee3c79e-28d0-4e3f-3a29-08de1c466b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 08:36:30.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDVkv81PnpvOZgCh5nw/wSB51CvFkr36uyPbDDftv08Jo9wzTS3iSLLr6tCXI2dJ6h5xt3DteiZRzApAyqoZzjT0msEN24V62jTXy7KG+UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5368

T24gNS8xMS8yMDI1IDQ6MjMgcG0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFdl
ZCwgTm92IDA1LCAyMDI1IGF0IDEwOjI4OjAxQU0gKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkg
d3JvdGU6DQo+PiBJbiBBZ2lsZXg1LCB0aGUgVEJVIChUcmFuc2xhdGlvbiBCdWZmZXIgVW5pdCkg
Y2FuIG5vdyBvcGVyYXRlIGluIG5vbi1zZWN1cmUNCj4+IG1vZGUsIGVuYWJsaW5nIExpbnV4IHRv
IHV0aWxpemUgaXQgdGhyb3VnaCB0aGUgSU9NTVUgZnJhbWV3b3JrLiBUaGlzIGFsbG93cw0KPj4g
aW1wcm92ZWQgbWVtb3J5IG1hbmFnZW1lbnQgY2FwYWJpbGl0aWVzIGluIG5vbi1zZWN1cmUgZW52
aXJvbm1lbnRzLiBXaXRoDQo+PiBBZ2lsZXg1IGxpZnRpbmcgdGhpcyByZXN0cmljdGlvbiwgd2Ug
YXJlIG5vdyBleHRlbmRpbmcgdGhlIGRldmljZSB0cmVlDQo+PiBiaW5kaW5ncyB0byBzdXBwb3J0
IElPTU1VIGZvciB0aGUgQWdpbGV4NSBTVkMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1
bCBBbnVhciBSb21saSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4gLS0tDQo+
PiBDaGFuZ2VzIGluIHY1Og0KPj4gCS0gVXNlIGNvbnRhaW5zIGVudW0gaW5zdGVhZCBvZiBjb25z
dA0KPj4gQ2hhbmdlcyBpbiB2NDoNCj4+IAktIEZpeCBzeW50YXggLyBzdHlsZSBlcnJvci4NCj4+
IAktIFJlZmFjdG9yIGNvZGUgbm90IHRvIHVzZSBBbGxPZiBidXQgaW5zdGVhZCB1c2UgaWYgZGly
ZWN0bHkuDQo+IA0KPiBXaHk/IEkgd291bGQgZXhwZWN0IHRoZXJlIGFsbE9mLCBzbyB5b3Ugd29u
J3QgcmUtaW5kZW50IHdoZW4gbmV4dA0KPiBpZjp0aGVuOiBjbGF1c2UgY29tZXMuDQo+IA0KU3Vy
ZSwgSSB3aWxsIHB1dCBiYWNrIHRoZSBBbGxPZiBzbyB0aGF0IHRoZSBmdXR1cmUgY2hhbmdlcyB0
aGF0IHJlcXVpcmUgDQpkaWZmZXJlbnQgcHJvcGVydHkgY2FuIGJlIGFkZGVkIHdpdGhpbiB0aGF0
IGJsb2NrLg0KDQo+IEFueXdheSwgc2xvdyBkb3duIHdpdGggeW91ciBwYXRjaGVzIC0gb25lIHBv
c3RpbmcgcGVyIDI0aC4gVGhhdCdzIGxpa2UNCj4gdGhyZWUgdmVyc2lvbnMgd2l0aGluIHRoYXQg
dGltZWZyYW1lLi4uDQoNClN1cmUsIEkgd2lsbCBzbG93IGRvd24gdG8gc2VuZCB0aGUgbmV4dCB2
ZXJzaW9uLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6
dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCkNhbiBJIGFkZCB0aGlzIGluIG15IG5leHQg
dmVyc2lvbj8NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KDQoNCg==

