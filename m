Return-Path: <linux-kernel+bounces-765383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450CDB2316E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC55516DA32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5122FE583;
	Tue, 12 Aug 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="fe//5ZEr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="cPE7nEfc"
Received: from mx0b-00273201.pphosted.com (mx0b-00273201.pphosted.com [67.231.152.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846111A9F89;
	Tue, 12 Aug 2025 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021672; cv=fail; b=dlr1BBjITZh3mVsDm/WU8bm+BVuIsD75OmYahB7/9ahFBLriMf0AywDBhKu4vV2siMfLgrdcyBdDzhrxuGEGTGY5MbuO6XzXvlw+xSFKFepiRBG8AwVbbVfC8PjcoBAQ91COKTbIb2sgQ6F3JkFWofDaeMhDusqAN182rL6kHzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021672; c=relaxed/simple;
	bh=a4teOHs1PaYKTfNLxQdf7JKe6MPDTE8SzEHRpn0mZ0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7TTjrkUmmqr03FRjzwAcC1rUy+FrdL4u1HnuRAKVgrB3/aHGvtbFtGxNzWnXQzc0+YJvL08EhqNLG28oiUMqUENcZ+g4ug8oS5MBd3D1cu21DGLHu62K4ZkHJI0k8LE95UoFMK7Ek7dPNXllOiyeYxsNuYu3FPOpNI/s2yg9Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=fe//5ZEr; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=cPE7nEfc reason="key not found in DNS"; arc=fail smtp.client-ip=67.231.152.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108160.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFrhMs019656;
	Tue, 12 Aug 2025 11:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS1017; bh=4QZqZBIBI2hH9edMuwhX/2alp5BuDOqudoCOHZ83l9E=; b=fe//
	5ZEr3OqcvUGlLDKDLcXqJsvTdA0bB5x1YGUfAf2cZqi+N7g9S/1r7r48ayaVrlCN
	LlyG8AyWTwv//Q/l1pBXNFWFKFfziHOtIkZ4R3sFwiDZaIljlkAWp9YllPCYtc2a
	V44NbKoAyph3kXvkJhrQmPY2fYrqysVtojZnuSCgejQMeJpzDxb1ay3SRmWDkm5R
	AflsQP4w5cweUfRRYEJxukEf20Z+n6tdfoYbbpSKRGA4qUSa/Pj5J5JGTEyaDNKZ
	u64AF3fpasHugMgeU/tUJkcvSDIsyHwhHK+XgM5Y5Gf63wDRipjEzWOHJLSGJMha
	Qi254aGg0qmOpLzpTQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020106.outbound.protection.outlook.com [52.101.61.106])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48e48cympc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 11:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZPErqeR0IVD1xoa0KoEWlibffKZzlVChqHyIlbWDX3fs+ce9tf4BrvwywTnjlP1nidkIW2IgeVCtYuu7+i/zmGd+k8g8qAm2CYH9nXoJaCNK5OaihYW0j/FMLpvYah9wf5MKqXslwTYjXm2PEOHko0ePvWgL6/Yj1rOvymyCXRodWsSxqUTimmlWiW8ZVEbIxDahopzQE/Uw7I2P5gYairV9Q0NwYErVmUAwludc1BV4eEmiLyiawPe3lM1uLkWbZWPXzUS1rc5+oEXcXvvW2JBUh1aGkgcpkbqQ66RX2rb4svpFXjLIdCqTmnzGDFoztKC0L7FMYzsE3vjkbrxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QZqZBIBI2hH9edMuwhX/2alp5BuDOqudoCOHZ83l9E=;
 b=Upz2ScTh61ro9iyhzlU+bmwn6cUlKr+qptH9/79lRSSbDhNIReCpqSsrkSN+7enSByWei4nO9K1FRlgttdmB4J/qZtsL2d/YlZgmFS7becujVy4bW89NLxMuRZWFRN8UmAgCVGBIPs+6O0fIfqe6fvTt6hZl7Kn4dThCxE4cuSdepmIDI1sSMT+HbYl0Fb+ggs09QZ510xTN1s0gPEtfnSyHM6oLfumtMfF1q7QY1mXX9pkw/ZwTJjwEvHY8ISBv53R8BbTm08dBXT+F9EDH51H6X44J3fQDjgkWrBqJ4uGRH+kKPWsC6JIfAaLA0Heda7x6OOMKcf065OH0hEC1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QZqZBIBI2hH9edMuwhX/2alp5BuDOqudoCOHZ83l9E=;
 b=cPE7nEfcSfVfqsueCFnNvNet7UXCVNmW1EYiQU9eX9s9Io+3/rJS5r8U/fzktoutuQLr0dTBXz3kATIuYwjvOZ9dBydQmxY079mvCIlB4nczMztVgQGtJPhTp0EymV81A4fCW4z8A/Fl1ke5voNIdPyyYLrtOnqpeyxQCJklRMk=
Received: from DS7PR05MB7288.namprd05.prod.outlook.com (2603:10b6:5:2cf::10)
 by CY8PR05MB9961.namprd05.prod.outlook.com (2603:10b6:930:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 18:00:16 +0000
Received: from DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24]) by DS7PR05MB7288.namprd05.prod.outlook.com
 ([fe80::d1a4:ed92:eb4d:8b24%4]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 18:00:15 +0000
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: Alexander Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rob Herring
	<robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "x86@kernel.org"
	<x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Thread-Topic: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Thread-Index: AQHcBk4phVhYdt/4V0qVrvNiicYNsrRfWUCA
Date: Tue, 12 Aug 2025 18:00:15 +0000
Message-ID: <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
References: <20250805211527.122367-1-makb@juniper.net>
In-Reply-To: <20250805211527.122367-1-makb@juniper.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR05MB7288:EE_|CY8PR05MB9961:EE_
x-ms-office365-filtering-correlation-id: c5290b60-8db6-4a91-1faf-08ddd9ca175a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J0Xr20oeakLAM7SaGdq+hR8dW5fkqnzGvcebYDH2qmy2rwrAb9jRhWvTKhLc?=
 =?us-ascii?Q?kjci+CYTt70k1WSfvxwCy8ZNlF8dBzF3OXKNbtqtPLFH6nvvZk/1hEL4sKCi?=
 =?us-ascii?Q?8hwpaGYauuJGHGHTUgWvkkVYgQl3qm0AujMzTqO4nKUkG2mll9rJPADjWPj7?=
 =?us-ascii?Q?B6AplMKQo4iCbtne+16H7bNzxSF3/As+KbZmmCzdYSqI6Wp2It3UTsIRFfzV?=
 =?us-ascii?Q?x4x5RPr0Pw1zzr1DLnOS03RvubxGixYigjVq4/mc3krXwvlyxcf1BQq4hbLV?=
 =?us-ascii?Q?GgSIB7SO4huzN4CBwpbnyrzQMECB/U9tH4ITxTueYS4FTl1F9LzmaWlg4Wx/?=
 =?us-ascii?Q?+1Mm7W0z6pEi4ixaSdsuym5OWg4Pike2RzuYe4egwAK25afv6o2a5XIKAIT3?=
 =?us-ascii?Q?HdQAnfmCFSpEXNijbwyEKSpH/Cv5RWVhh/v9kHPSr2vdUk+jww7V1GcOfByU?=
 =?us-ascii?Q?9IShjKthrXpap2XURzK6DTNvXUw3SCkAuzju9wkVBXiG8Gwi/Bu9D7IMS0oT?=
 =?us-ascii?Q?uinRXf668O/dOOaxBE06h/lz6sS87EMYPFZzvvw+emEGsq4ywMrHriJZ3SDX?=
 =?us-ascii?Q?FVnaWnHcaFs6boLd2PRy01klmtmv9cy6IxB+omQkmpNGe5DnhPkpCJl6hSiv?=
 =?us-ascii?Q?pS4PmY6vPCCqkwzAoUL6UVkzHbhjzV5iNXdDO3fr965kh6MDFAjptbvF8/6C?=
 =?us-ascii?Q?lpPQVi+aAcwn2jEICPYolZjKcEzS6GOBkRA137GC6LEblFxYQ55KUo1TROzJ?=
 =?us-ascii?Q?wOVrVx0P/7LbNLud7dS7aWrDNdNAp8FYn/Odp2PgxdJJqCexlfjOdbbq1RPx?=
 =?us-ascii?Q?wnPcobzoVkELTAwJJnv3BVbX+ZzgqWpbcngjW1QJIO2CSdJn/mENFpQylD93?=
 =?us-ascii?Q?qxotcXgU3jO3JIuLPtX0xTnfzmp0r4MUvkZQhqGOYW46KpeAxtvS34INkdyp?=
 =?us-ascii?Q?ENX5XDmtOub18p2+6TRUb0D9qBv+Kpy65iqK0SsFv+q9ALEQs6tj/oHNwUtx?=
 =?us-ascii?Q?aUE5TmvqAsdpT2B9bPpK7lnLd85AwJbtVsTdcuUj7kmAUt47sBH0JfuWy2OC?=
 =?us-ascii?Q?9/89BQiyOE6zgy8pKE2vnGwEqgPDTK+m+eNL9G9QF3qUNTYCr5cnpGVzuncN?=
 =?us-ascii?Q?cshLLsJhMh4pQagvfHoWvQILn/mqC1EnSIyoJvl62b1CKIWbZyOQsMWFbpNk?=
 =?us-ascii?Q?Ik7uvOPYyl0822han0Xa0TxiCP3cxbKzZWY5tejAAEpcDWDcPtmdlP3GzF45?=
 =?us-ascii?Q?JeMNQLMeYhNIRq115/skkyh7Lv3J6RKbhb8SzoNnOgbPK+Ri+yOHZ2L2ffvB?=
 =?us-ascii?Q?M7ERQoJWDFScSP24v8g4PP/CHRMoX/ar12+4MMVETPUXvGZZL6VLjaZVTfoJ?=
 =?us-ascii?Q?wPcPm/YB23aK1Fk+PsXs8zp2EljnGC4cbtcVndZgQOIshdEiB65WiZmmaxJW?=
 =?us-ascii?Q?hLVGBa+cEyUKvAZYgEH4NnhLxEzQ+1YzH96uULd5vHOalxeYwq07wkjYMDbj?=
 =?us-ascii?Q?oKjwQYHsrefvsX8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR05MB7288.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q0daColVJzH9vP4U52N8f3b1cs15pfItwJCzDZJsb1f16ZDuj/sK2iEyvSLN?=
 =?us-ascii?Q?sguj6x0aYKtTduuAaKhPxYRMBmc7q2bgmrtknP7m6V4R8h3oG8HLW9HcGQuL?=
 =?us-ascii?Q?7B5KO7VWD/R+0SopcFGSupZnaet2x2HPGC8b2nkGJ6bsyH88yB2CJ8D63spa?=
 =?us-ascii?Q?ECtTpkW4fvKwXCEPwto3cFBj81Y5qaLl9hBNfTHjm9yxuId0hrVZ0x/OG3Id?=
 =?us-ascii?Q?nHognPYGkhRujlsRYvzS1RdM83uJEMEC/G5QcT8WMEwm5mtvkmk94dn/BWwi?=
 =?us-ascii?Q?Lfzt80X80QkBUuKg1NRYD63SjKoGlBRIDnuD+S8XcnHXDkLXMIbfi9wejfO4?=
 =?us-ascii?Q?SjAna0gquDS/MeEjTZiM1BSQB4rkw1N9D57oeL8M7pu5KBvooa6Z9t4nHaBM?=
 =?us-ascii?Q?iiEknY3IQkEFGKLV5/E3VRQtujPw2TTT3uQGhlpLq0Uz3DniyBHr+XCX36FG?=
 =?us-ascii?Q?bRDW9C1bR54xtTG9UizoT3DRi1cWBVt2i5d1+RuTWB762wuMLYVgfJu0tCea?=
 =?us-ascii?Q?pGSD0ZGXL/XsfqjPANA9pWkwMnX8CDvY0lBNuC7f806dMzHosR3V5L8qh5IW?=
 =?us-ascii?Q?8edDI6BU1fyieuNVQuE/Fl+ouAKEJiFd2bIi7NCbZ7rpaGyyYZYYAlGGErKS?=
 =?us-ascii?Q?jpn/wLc43in6uyNwahLHwrX7MWlKgzRlKF1XrqTO1CV8sVlddjpzcnDVk4Cu?=
 =?us-ascii?Q?rgtvNUn7SbbZJftpO96F7uKnvOPcfopY5mJ5TOBfiATVH90v4dESRNpVvzNp?=
 =?us-ascii?Q?VB/AnqkUJ92w3/N9ngg++qejeSlSFK+a8T6QbDt+6NfI7MpuCb+qbG86RhBX?=
 =?us-ascii?Q?+5V6XmDqry0hV+FK/oOyTnRY/bCUkzSAnVNL1bLhyMPA89uoRjYAlPZLwkqE?=
 =?us-ascii?Q?K2zZGwpkmoMFuTOkqM+TIGaOgxYxWXlldc3J0PxW/p2uaDwdm9OuwjJ992kw?=
 =?us-ascii?Q?doZMiWK9M37+r4yHhfMHt7h3Jmq6Up2Ze0yc1j4Fe4MBuvDgitadiuyhu6Z1?=
 =?us-ascii?Q?9U002HEel3cA06KCVUlATXptbqP0kf32xxwF+Eo4HNCsgWPUImcCiSk/VY14?=
 =?us-ascii?Q?qC4PD2vv87GFCRCHtow6zJQh6oFfTAMoNK4YOVlY66TRqQ6pZ73Noo+uyco5?=
 =?us-ascii?Q?iYHBM4iiFaI4Lkdsa7Po5mQ0wgOEIqHYkWozHt+VI/gKHmUvNCF0psa7Y/uJ?=
 =?us-ascii?Q?FpnRYPkxbQZDVIqR+R67XSZ1wQ3p3uBYYvT+BJr9XOxE9VN6feS3YU0IltgD?=
 =?us-ascii?Q?BFSRZ003uPzuDBe+9RuyFwVBIgx0gVq1IHXx7BS2LYqUrx2/HDbTb6iLzBNR?=
 =?us-ascii?Q?iJj3hKt2e65Up5YMJQBLy1ujUj1zYk5XvaXmFSQ5cvg/2PXJhf3+s9Kjb93K?=
 =?us-ascii?Q?UD2L8/U6FS/++AwUf5hzDioksCl0q8QPiN1LqYurYgnhTK5yYqua3D2EdtzI?=
 =?us-ascii?Q?Q7/qoRxGgnDabrLCPwrS2nSc6f7kuSjBAQNSr8slrTdDVvk7F9FPK/D4BYy8?=
 =?us-ascii?Q?aJ2/zK09NdS+sbZyrUFjF4ME2NaAGtdu4jDrFjhEITlIQBeRLizRa3M8EUUK?=
 =?us-ascii?Q?V22PRy49JEUjdnwJe7lwg4v3iSQU5kIHbjOEywrN?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F28FB6CCB0CE540B88805EF0D8D8BB4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR05MB7288.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5290b60-8db6-4a91-1faf-08ddd9ca175a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 18:00:15.4728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wa8cTNhXCgW/3sZ0QpySlbUALdBlzRdnxzcVti3QFVU4wzZ45nP1B9GkvC14BdYitAK/VL85vM1TSdYZGB/9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR05MB9961
X-Proofpoint-GUID: wP5G8BtqERkCtaO3xJON7SqWhikpAAGJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDA4MCBTYWx0ZWRfX6JQOIuec78CR
 e9kuENvs56h87uFj9zRN4DonNgLaEdrriCu9C3CLpcB/XugsreVDYhp0fFQbIdFIhY/uFp62naQ
 DTvDqXFpFFIipOaWotzLDvpQyuDjjshUibe62SV8H9NIDNraP3HpXTWJNSoA4p3FftpRLKaCfi2
 bF/GcgvFdhKejrKSFMOGwpyl536T1QAKDb0SDBgXCLSQr7ig+Y4k75Ole7o1THs2zDhKbOPiW6S
 yTOlat7Fn6FBFBIS3Fl3ndtAwSvfZvSkGoO7F0YisZMrBfJaenJPuWO7Lzz5TpercgSwW7AwSvM
 u6M5Vutuf/QZVUhNYvw+QTkT5Gb4RhP4w7xhoyl8iSrcXgUXi/lc9X5JAm96r2ZJ26fNNkvFQEW
 KM3iTSBv
X-Authority-Analysis: v=2.4 cv=OdKYDgTY c=1 sm=1 tr=0 ts=689b8133 cx=c_pps
 a=X0tkg3G9SmSAvlwNIS9bXQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=rhJc5-LppCAA:10 a=OUXY8nFuAAAA:8 a=Kh4T8yyD9uxh7vV9YBYA:9
 a=CjuIK1q_8ugA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: wP5G8BtqERkCtaO3xJON7SqWhikpAAGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508090080

On Aug 5, 2025, at 2:15 PM, Brian Mak <makb@juniper.net> wrote:

> Hi all,
>=20
> Here is v2 with the comments from v1 addressed. I also added a patch to
> the series to add KEXEC_FILE_NO_CMA as a legal flag. I noticed that this
> was missing when I went to add my KEXEC_FILE_FORCE_DTB flag.
>=20
> Thanks,
> Brian
>=20
> Changes in v2:
> - Added a patch to add KEXEC_FILE_NO_CMA as a legal flag
> - Added a KEXEC_FILE_FORCE_DTB flag to enable carrying over the current
>  boot's DTB on x86.
> - Modified the commit message to include more reasoning for the change.
> - Changed a pr_info print to a pr_debug print.
>=20
> Brian Mak (2):
>  kexec: Add KEXEC_FILE_NO_CMA as a legal flag
>  x86/kexec: Carry forward the boot DTB on kexec
>=20
> arch/x86/kernel/kexec-bzimage64.c | 47 +++++++++++++++++++++++++++++--
> include/linux/kexec.h             |  6 +++-
> include/uapi/linux/kexec.h        |  4 +++
> kernel/kexec_file.c               |  1 +
> 4 files changed, 54 insertions(+), 4 deletions(-)
>=20
>=20
> base-commit: 35a813e010b99894bb4706c56c16a580bf7959c2
> --=20
> 2.25.1

I see Andrew has sent these patches to linux-next. Thanks for that,
Andrew!

Dave and Baoquan, have you two had a chance to peek at the updated patch
set yet?

Thanks,
Brian

