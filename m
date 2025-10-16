Return-Path: <linux-kernel+bounces-856889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5BEBE5569
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D46FF34F435
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B92DC77D;
	Thu, 16 Oct 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sophos.com header.i=@sophos.com header.b="Ea57FN4m";
	dkim=pass (2048-bit key) header.d=mail-dkim-eu-west-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-west-1.prod.hydra.sophos.com header.b="8MAr96DB"
Received: from ix-euw1.prod.hydra.sophos.com (ix-euw1.prod.hydra.sophos.com [198.154.180.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC682DCBFA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.154.180.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645605; cv=fail; b=NLszV3TxrrupSIOVkkyhPDVWNrGMH/Wh+lW2y5ICETJI8Uk358Qs+9uBVvsjwfuTWnYVH6SbdqgNyw3PgmzLsLpws/huwUOhSVs3IfKboYqp+5P9QPVJbmpOZV+BfzBqyIuaH0JGQ2m9BYizFZnnS7ig0xpmUQQa5/PYRS2OpPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645605; c=relaxed/simple;
	bh=8MrXXrNObezfHsLD/3/h9Udr06998BYbHf+B7T0UZzs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cVJeRXZJ9FRzmw4i/VDO/XFyswhvY+b+YhEAJDV1M5HJI8uR5PBqkeqTKWJsDQ989xW4tlPoNGn1DCdleJsvzXhSwbEfkD1G9lEPB43m4UxLbBLX9lnW3Ni0L2JTvJE96Lrvjgv3mMqlQ4fZx6EK6XfUL4l3LAzp8O/LooTBlls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Sophos.com; spf=fail smtp.mailfrom=sophos.com; dkim=pass (2048-bit key) header.d=sophos.com header.i=@sophos.com header.b=Ea57FN4m; dkim=pass (2048-bit key) header.d=mail-dkim-eu-west-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-west-1.prod.hydra.sophos.com header.b=8MAr96DB; arc=fail smtp.client-ip=198.154.180.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Sophos.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sophos.com
Received: from id-euw1.prod.hydra.sophos.com (ip-172-19-0-187.eu-west-1.compute.internal [172.19.0.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ix-euw1.prod.hydra.sophos.com (Postfix) with ESMTPS id 4cndXC0k59z4vS
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:37:47 +0000 (UTC)
Received: from ip-172-19-2-8.eu-west-1.compute.internal (ip-172-19-2-8.eu-west-1.compute.internal [127.0.0.1])
	by id-euw1.prod.hydra.sophos.com (Postfix) with ESMTP id 4cndX40MfMzKm5F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:37:40 +0000 (UTC)
X-Sophos-Product-Type: Gateway
X-Sophos-Email-ID: 1381e34921e742ad833d3b242d1464f7
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11012007.outbound.protection.outlook.com [52.101.96.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by relay-eu-west-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4cndX24vCnznTW9
 for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtbCbJKjy2I86U4dutXjSlKleiEA2MsihpFgfNZp4KyS4dCSDr8uFS5W2v2DgwFJaWfwJIlJtEHpRNpBlwul1Vqvgv1uDVN6kmSk3YAB/eshmL+UKmAQ1n0hLzefUla36sTro8HnQ911A+6uKzhyoSumBNrZ66zfMUg9CCDrQdP3TmbuZ0yv1k3bdEO1o27N/wl4JoeSBCHHp799DESjAqEvTglYyXXHkvp1M0ELw4Tj0w5Nkhk5k+SlUl00muWLnijPBE5ncYi4pW68lrCwqhgCyGuJihUnTuRMw951Vj5Xg23zR+AVimVIf1hn+n3zG0Vt7S7xRIa/kjS8C1rQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHW0pSLbhCBZtCKN03AB/5ABmM8CywF10ilDtRRqCrg=;
 b=qH4zA7fabheVWWs6zBlL3fN4mXnT+mq11WmowoMTuuc2/J+4JXUUHCcmZstCgJgL4RIeGsHa17E1nKzyK5pXl23oufu8qDfHYzcQ8WP3r9H2B4/QobRSN4FMPOsvVYExkVoWhXMd/2UwgsqXUg8byHC9de+r8oqROiT/KDN14WeN3MlQ1DR0+aJoPbHzkxma3lKEuvpuNay8BtS87Z5vDAOt/rxTsxTvfKo9KPLw43ajOolXr/jU9k8dtDjT6HptA9Vvt8B+7xe3kkRJPiTQ3eeNDkxf770vDToqR4LjZhWhJL4FtOmd2qC5i3y7JZxqI5ZgJ8K3sEo3/6hYpJTMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sophos.com; dmarc=pass action=none header.from=sophos.com;
 dkim=pass header.d=sophos.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760643456; 
 s=sophosf69f0521910d49beb03f4ce823e25fdd; d=sophos.com;
 h=Content-Type:Date:Subject:To:From;
 bh=YHW0pSLbhCBZtCKN03AB/5ABmM8CywF10ilDtRRqCrg=;
 b=Ea57FN4mYPkinjNjdxcQGhAjTAiyB8+yUDOry0QlHioXHuXJMFdmGG6LkNF1PiZi
 A+WdpfIyaACvgLevQD8QY1lffSOxbyOXN1BlbcsD+lphjKnxSgyaBuAgaum2bCd1F5G
 IE/J8iaE3JprlpuI4vbrBrMyaIcBohOA0qjev4BxanfwuVygvDu7I0cNJhkngcBSlOQ
 ZhLpo3WYvBCTTsws8/ptjVZc8cqoxnm3MZ2ys8/M4RBryW1Cfd7p7IaHlk7EmJQFAsc
 aKKO1v9qglF+MDS9iPDkhoQuk9Yz82thrug38ojUVUgO59BNiTW5c5mK+JtO6cPJe5k
 sKVC3Vn9Lg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760643456; 
 s=v1; d=mail-dkim-eu-west-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:To:From;
 bh=YHW0pSLbhCBZtCKN03AB/5ABmM8CywF10ilDtRRqCrg=;
 b=8MAr96DB4WLoh3dYIyon0szD19izU3FBNx0SVNLgODBKOWRI4ObcD6bBW2//SKCK
 w2x+eYHLeouA4ZuZqlaZGcrklWuIAkqqyZejLhSYkFbnShR1j3/8z3N9DfJHF2JmYJc
 IrMWmhP4lRHf90YYHcg1nMlaZ1jrEYvpBRICZLI+dW1jMBNj80DvIt21h7MvVsgkYOh
 aGba5M8qdpCQ5D/q0nR2kebi7cK6tFKvAM2I3gNGne/vAKZVpxQjPw64bovfFwrscyT
 ttONrp2SH9lyPlUlbkcV1zHXlHnBDGUkuz4UAhmyys6/36P3UHzMWZOG5GdmBsZ6+dA
 w2kpFSG92w==
Received: from LO4P265MB7392.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:348::7)
 by LO9P265MB7476.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 19:37:36 +0000
Received: from LO4P265MB7392.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7d07:57c3:71:cbea]) by LO4P265MB7392.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7d07:57c3:71:cbea%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 19:37:36 +0000
From: Elison Niven <Elison.Niven@Sophos.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: x86 : Slow read/write from tmpfs after major kernel upgrades
Thread-Topic: x86 : Slow read/write from tmpfs after major kernel upgrades
Thread-Index: AQHcPs1imhZG6/ye/km/VfhWFiSULQ==
Date: Thu, 16 Oct 2025 19:37:36 +0000
Message-ID: <LO4P265MB739293B94D911AE33A496EDFEBE9A@LO4P265MB7392.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sophos.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO4P265MB7392:EE_|LO9P265MB7476:EE_
x-ms-office365-filtering-correlation-id: 2019b1e9-1ca4-49f5-5b22-08de0ceb75ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TSIXXih8TSya73VG3jiFisnDyTzveRU22fA5Zb6ipdc9sUq+FNpvMW2MrU?=
 =?iso-8859-1?Q?Ic4etBbGthVnZ/samMlsakAIad3ijTm37BnOUCBiMnxEEDkm277HxJ0Cyd?=
 =?iso-8859-1?Q?VwP8U/MIuZ84LeDsvpbcn2V75aMosOUI90BLtafnoSxqkQR3+kSho/AaAN?=
 =?iso-8859-1?Q?Bd0Cp7Q1Xkpwkkh78lIzPMNQfwUExDIZ/DwaV2isqJOeU4IiH/ffbZwNL4?=
 =?iso-8859-1?Q?aYo61IkwLrguUwGd2hpC1kgVTeaZjQ4uC0mCjfN10JbDQSecLdqQDDLjHn?=
 =?iso-8859-1?Q?UWpXKQL0W+a5QP8Z8EIv2uRLoyFYfispheOVQ0cmXmsadtXMm5rZcD0UGX?=
 =?iso-8859-1?Q?AAkhTAHmPuWM8MNz+YfaIenxEYRE+Y8v49J2nFRxz6d+NSfrYrW7znUZru?=
 =?iso-8859-1?Q?y2nWjmkZd3Xoc4sXCKxYdaUp40smL8i5Y8uT21WJdL80AlLgOsx5fdZai9?=
 =?iso-8859-1?Q?Ar81bWeKoZv4vg9r5DXbl98RiEh3f9N5J0zNtCo2QHuY6zeOR4SK8ssLEB?=
 =?iso-8859-1?Q?V9/1CqEmbvjiqPHmDidwwmZ9XdbN3gC17j7fD6p46ksUDWp0nY7mnoVD2P?=
 =?iso-8859-1?Q?M3EqtHUW8rklWVlLSCrc6lBTIKwAvuXf4xAT5O8J+u+gzuxTrRTiKUX0HI?=
 =?iso-8859-1?Q?UpeoBA5zWTwVOxGEqT7GKhM9o+hbPwQR71HcPskHIUiJkyGCPHyjM4TLD8?=
 =?iso-8859-1?Q?uyrLozkYJM4y0dLsW5une3eInbq4JJ9wH4pNCJevXTsGE7P2Lm8gg4Qzqe?=
 =?iso-8859-1?Q?a5CleaFMstxuJjsvvJL9BFSAVmmqPkoTntmGpy3bgjFRgTN0MBhjxJdD0F?=
 =?iso-8859-1?Q?vqyReZlWhxKU9hosTay4wK9TybhjaIoXk2cccjDMzbPlZF6AlMC7/qCtlA?=
 =?iso-8859-1?Q?CjfHPUpoRTn0HR7Kn4/DK3VyMA3jkju/dwb6TrhsWTwlxRbrMhClg6Wqgh?=
 =?iso-8859-1?Q?dYcQD9cj2PtK5VnGjiTuumj8A2bLzQrHP7DtPPdlDwlP3AiF8RSHIiYiV4?=
 =?iso-8859-1?Q?ElTvx8ewrtatbB6Gz8emrNO99r/XipbIE6x/UUZZYcXhLljqL1jQZ7pOFK?=
 =?iso-8859-1?Q?QpB2UC9UWz/pqCtMr7VsWkI+dx9FHaJxX79IU13GCAJ4o2fZ9gO7t4Fs3d?=
 =?iso-8859-1?Q?xc+lKKOvrSUCghuJyiSust+OwZbgtikb6QXXWBia3/t8cNZiGRVO2rZM03?=
 =?iso-8859-1?Q?2fWiG05rBE4mwG3+M3ge5hMgtOXl2NhluIRmhXFhPN89VSA/DS6E/8CYuv?=
 =?iso-8859-1?Q?LbV1Rm8pEXa84dh5zV6T+fa1wetffvKMctwcvnC2P+vZIDB9N0YUZoZt9t?=
 =?iso-8859-1?Q?KL3zkYI8POefwxe+M6A1sSDoX9l2af5TSLoF7VKulVbp0RMdrBe13rIpC/?=
 =?iso-8859-1?Q?lPzMeyVxA9VyONCKF2iYw2S6rlJxcmEML9o4G4UzbhvHvttmYIlItuMJQv?=
 =?iso-8859-1?Q?/XNkW87Tqhey3Snwjk3NpdoTxKp/qkbu7tyxsCdpWesG1NFIzyANWUQmP8?=
 =?iso-8859-1?Q?xsd/sNpOpYpegTaRCqyeCAkZU+BKKcAET2Q+u40wGppq52GNElNx34XuPT?=
 =?iso-8859-1?Q?4Bt+l3bzLY7Lma6aY8WA6jVeba8L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO4P265MB7392.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2HeuIjUIWyD+aK5nzmIy9aM+A1LVs2gCmxedNbAq+9iv/MahwzeOM4YLMB?=
 =?iso-8859-1?Q?yIs77zOETFF/2Ekl1rfX5pNYlCUxexj6L1Qq3oJ6paoqLq83Ni6qOpm5PJ?=
 =?iso-8859-1?Q?wmN86tIYt/2hDSB284ffvPoOuunwLvAQJ6VB/jUyVwVSe0Cu/d4ztkN/79?=
 =?iso-8859-1?Q?Ykk8hWB6jDuU0D+8k2NrQdXTkvaF+YlaCjkSpKwg7AAaO9JyjGNH3/njDu?=
 =?iso-8859-1?Q?5E75b8Yt7iVkrOeeksz1O8+W8BcWTOmp7T2umkDuYzt9va38Vh03+gtEuh?=
 =?iso-8859-1?Q?4zz+C9sMXTMM1v3yt88T86fDwTXnOCpnWdrZfLpd35rZ16mxu7fYwISDu6?=
 =?iso-8859-1?Q?gwbEV/hyBTZqH8JJkrQyiGVVTbcmy0Ppc61RuCfF82wqEulDR0/+wCHCnY?=
 =?iso-8859-1?Q?vjGx+FBNnCnXaXPSGZwcFZgrBeVII3Q8aMTrYp5vIAUSaII8foNLjtKpU+?=
 =?iso-8859-1?Q?d7eBPpd+lSQLCA7PeIgg/g1DO8+kCKoIX8uYwkzp7osGyJThX1AHkoytt/?=
 =?iso-8859-1?Q?kP6mQ1roy7x3KpZgR5hdXu+Wn1HSxhnh3goU2E0YWLs/F+eek0xMwPEo9j?=
 =?iso-8859-1?Q?RVcLfTXHMLtMNkI5xen0tt5fYJv7IhMY9IwhSzQdm7/amnNMANKJK9QEKB?=
 =?iso-8859-1?Q?2etH5GCSPVJgdWzLHnyxsWayRsMx2yrrSRAH+obnjtxRy5cAb9d3+yXqDM?=
 =?iso-8859-1?Q?vrKkNePT2M/e4zH/NIOaKQFrGlndDFTM2yxgGw0lnPFbBXy3Z5si8J2Zx0?=
 =?iso-8859-1?Q?RXz5k1Ven6Ix3loi921DfFcjThan2IZ75/yKFELoTSAB5ZrvPAFCZEeKIg?=
 =?iso-8859-1?Q?yjyKMj4aRmrnF9UH3N1HgWgA5RCmRBI62Ccwb3rE5YkYTLomRmvWkfsg9W?=
 =?iso-8859-1?Q?cd4lk4rKKpnEUnlVoAnDvgTiBXZzgN9RCYd3KKDIBebdVkO+JC4w7YyGMK?=
 =?iso-8859-1?Q?8KnWgiCuV6zMTyNmshkAou8Qfbi/TX1JLmH0qiZl56o3XFHmHK2NlHtdUn?=
 =?iso-8859-1?Q?4YCeGnFIAmsPyMgFqJJNfv1WY5dlcE0OnCkfRr+d6ZoTRJa7DONQ1Pytq0?=
 =?iso-8859-1?Q?g0MqeVMHk6cboiINNjsfEgQaJm9YVmZ4L1GheoeLtFQsxsWYx+FZupqeOB?=
 =?iso-8859-1?Q?U94D26FgrXWEz+vyqEy+6VZVYFvcT1vQPAwvLFKSkaTFL7e9HgCli0wNQ6?=
 =?iso-8859-1?Q?iyEE7CS9mrfLPN2z7RP3UwjHMmkZMnuDCSyZtBQDR8btJEMYouyzbX+iYF?=
 =?iso-8859-1?Q?ivEhrDTu3+zMKovZ/CLyEUxEF2rKIC7FunXlOTaakW0jsoZmc2ld2C4tMc?=
 =?iso-8859-1?Q?EUxw9k8w11ZheMwHMi2dyHcOkPujvtN30aai7VYf8d6stSA0U6mCPLvzno?=
 =?iso-8859-1?Q?ww2VEP80vNdvcezmjumICCRjYMB0bE+g6MrgLCiUQynCtvby9l4m59mpzS?=
 =?iso-8859-1?Q?NvhB1+H2U4F2OZS4Qatg1RbBQ4nbH0rqktBtQWBmXOq65HbQS0zps1VSaJ?=
 =?iso-8859-1?Q?GlbA/MUlv8CBOt9Om8NwnIx17R9S8FfHCAkShl+Y4/qYcCdXi79arAvxnY?=
 =?iso-8859-1?Q?+63mdYTUWgfoEBP23dUZfGXP8FNMp7iPMY2Q2WFGoyCccBuGJeD9ArgZ+n?=
 =?iso-8859-1?Q?GEoCka4Fgiu4wtq40t9kHftHoduSnMXSw6vTbhgkhfw5je6tmtkMGKY0aM?=
 =?iso-8859-1?Q?5cOZBrASajppOcXO2vtyRCNX/toOcrNHNo5m18sC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dg2GK10sDRS12InlAL9/y4+GUGbHlmqXzQAvYDOsK5H98zfqnrNKDskYtFbIMfdLUJrRk/fCDa3V6D1NvqUA21yhUe8CxI6//WB/qFJIbttjrJPbdjPAEFDgy+U4hvI260lTAzz/1FGGUsnipnQ/L+g/U2dSaKBaXugx3apI86Vegmxypx3CHaoV+/N1l28SbfKR1W45g20no9+UFK7KcFOvADo82AmAPJRYUKqqxMwCvKvpFVOD3k9XSzRviLw+ZFOr/Ij/qbRi9tWLm1vlej3AN5JdPEssLFIDhsbUrTFWWPnXHOTnUvk+9M23pZld79YvGll4bm1EtQISc1FLwyg4EHjEQiiOQ8eToc0t9W/O5y4J9xfogikpNl+ylEsOoeg4nhYjpLsFuYhAncomYo59WN2QDWh4WEEcjviJixeGXfS2Gmke102piGAF2USncFDBTXSuKY2wYgpVhuNv0Ehf+OJP6ZX8OiBecZQz4FoP4v3KsFV+nZ9NMx9vDOF/IeN9sOUHFRom6YzElbNFKFMoHMpWnxY8JLstQ1U1r5Z2W0iFaTLtz51OEA05iwZlSCzxJGgpb0bB8+TG7+s+nfwPob9RO8neRwGzABmYsUo+99MdmGkgyF/vuQViFzjCf/zEmGq4Hp/N1o65yunjHlAiHtRFe4jwXiWzNQ5IJaXBnKmSMOf6Z27i6W1kl8Oz
X-OriginatorOrg: sophos.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO4P265MB7392.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2019b1e9-1ca4-49f5-5b22-08de0ceb75ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 19:37:36.4192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 358a41ff-46d9-49d3-a297-370d894eae6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aV5UgF2ccHSqyB2a0pz7PgFfuhcd97W35qOMuY1kb5vKlnH9H/xoqwidOLglQxN/3NEZmyqmBySeLLWR5bmWEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7476
X_Sophos_TLS_Connection: OPP_TLS_1_3
X_Sophos_TLS_Delivery: true
X-Sophos-MH-Mail-Info-Key: NGNuZFhDMGs1OXo0dlMtMTcyLjE5LjEuNjc=

We have noticed severe degradation in read/write operations from tmpfs whil=
e upgrading from kernel 4.x.y to kernel 6.6.x on x86 hardware.

To demonstrate this, I built linux kernel with make defconfig ARCH=3Dx86_64=
 and booted it with a minimal busybox based initramfs.

# Mount tmpfs at /tmp :
mount -t tmpfs tmpfs /tmp

# Write a 200KB file using dd with 512 block size :
dd if=3D/dev/zero of=3D/tmp/200k bs=3D512 count=3D400

# Create a 64 MB file in /tmp/ :
dd if=3D/dev/zero of=3D/tmp/test bs=3D4k count=3D16k

# Read the file back
dd if=3D/tmp/test of=3D/dev/zero bs=3D4k

The average write speeds for writing a 200 KB file with bs=3D512 measured o=
n different kernel versions were :

Linux version 4.20.17 : 500 MB/s
Linux version 5.4.300 : 460 MB/s
Linux version 5.19.17 : 380 MB/s
Linux version 6.6.108 : 240 MB/s
Linux version 6.17.2 : 277 MB/s

The average read speeds for reading a 64 MB file with bs=3D4k measured on d=
ifferent kernel versions were :

Linux version 4.20.17 : 4.7 GB/s
Linux version 5.4.300 : 4.5 GB/s
Linux version 5.19.17 :  4.3 GB/s
Linux version 6.6.108 : 2.3 GB/s
Linux version 6.17.2 : 2.5 GB/s

These numbers were taken on a AMD Ryzen Embedded V1780B with 16 GB RAM.
We also noticed the same issue on other AMD and Intel machines.

openwrt[.]org offers kernel images on their website, I have also booted sev=
eral openwrt kernel versions and noticed the same degradation.
I have also confirmed that the same issue occurs when running different ver=
sions of Ubuntu on the same machines.
I do not have the means to test this on ARM/other architectures.

We tried modifying to kernel config to disable CPU mitigations, setting the=
 CPU frequency governor to performance, disabling kernel debugging and many=
 such options etc. after which we noticed a small 3-5% improvement but we c=
an no longer come near the older 4.x performance numbers.

Has anyone else observed similar performance regressions with tmpfs in rece=
nt kernel versions ?
Any pointers, explanations, or patches that could help identify or resolve =
this issue would be greatly appreciated.
I am happy to provide further details, logs, and build/test scripts if need=
ed.

Best Regards,
Elison Niven


________________________________

Sophos Technologies Private Limited Regd. Office: Sophos House, Near Kalgi =
X Rasta, Gujarat College Road, Ellisbridge, Ahmedabad - 380 006, Gujarat, I=
ndia CIN: U72200GJ2006PTC047857

Sophos Ltd, a company registered in England and Wales number 2096520, The P=
entagon, Abingdon Science Park, Abingdon, OX14 3YP, United Kingdom.


