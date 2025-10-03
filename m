Return-Path: <linux-kernel+bounces-840935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE7BB5C49
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E0A188485A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1228D850;
	Fri,  3 Oct 2025 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ftbYU2te"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022072.outbound.protection.outlook.com [40.107.75.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD233398A;
	Fri,  3 Oct 2025 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456256; cv=fail; b=gq1P4nkPOffqW13B4AhzX/4MeRM72Jtq33bOHyVwj0nNcLXGPCqFva0Qx5wxzJJXGsG03ojhB3mRhYDQb/8kHt00SUmrzbRcAytfNstqkL4CsUU7oCPDrj4HFDjyKSO54h/adynZDKxT/2I0X7AUQNG+Xh4ljW0FW6/QrH5jOK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456256; c=relaxed/simple;
	bh=+e/60a1qMDwgNAEyksxowcryALUBANaUG+3RR1rSLVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rt8tovxELI29Zfsw5ngnq27c0lrD5lKY4f/L2mlflcbKW3GZTRC02vEaWbKRtxP3oNxEv6+Ocvb4RNArxvWRbqFohW1g6c03/DXVQ2VG14CQu6xJWjp7yKn274Ew63C74GB6WxJ0TQ+XeDY7idwQGMPLWM1GI6ktKckjxde/YZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=ftbYU2te; arc=fail smtp.client-ip=40.107.75.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOedosVROtDZbdFISrTiOuXsH4lkxDb+hS3lKT0yReyAA67i6B/IgqUSphtDMIjbiR7TomQCKfxRHHO44Si02ltDWIlYhY0A4O6bkYrg7dsEqsPXtES/C6MzcZ8MUerM9rY94vfj9zrN6magW9SmkKVkd5Rr3stCRtDfynCDbYAIEOSWAb8USeQpZsLxiDTkBGcIhGvRQpJ4CvpaBtQxApMiJJiaYAh7b/ZFHlDGvpE47YIzkR1MpNZ2ZBQiSq6P0/siFH8PDyvfyfhY0M6QuOzcPriknm0EF/Wie2OZWxRc9u881yWGhvVRGozhBGimOTWt8LZl1nzf0wLuKl/EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eUIU8QddP7U3dbI8j8sqZPz2v0ox91us2uZDLfwpw4=;
 b=siAKq8qmJfX9EpogUggtTC2Dbw1Mc8hSaJbNApPbm4y2V5eRh+VWm3xPX5mXOINHE15hHqithl9pzUPCdEPWl3pFJOLEKRRZI6MaYFt/jlzSUgC/Zvg1+9nYl+Bofsho20JqzTFcAgs8xSOICnH3zxTZWDJFrmrvZJD3Lt0bS05sjolzSx3gyHpD22Nnem+vBV5SJcdRyQ3tguRU8yye52mkk4NERVIWQL7YskeEAl4+99I3NtL4YT3DpOEV7hWroSmLRJkznqu78ID/yYMBNwrXXszjKT3Ht2nroVxNYiO9OTA2PYk4WW/9pEFgdrFzPbYZ4M5MbxgO3GllGrqSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eUIU8QddP7U3dbI8j8sqZPz2v0ox91us2uZDLfwpw4=;
 b=ftbYU2teXVf5H4k8nzAvUoiFJgsIAuOVUk1iqk+LqgLJvuzdh9oJuuTkl2Qe96vByONSA5jw1fq1ZahEME5XT4N1n1flWbXVdjgwgvwNAyBnvR0vin0uFdw17Eq2esiGy3fPFbseia3yDOxvT2bJueO01jESokKd87MfWTXB0el0ksm6TldmTs1u2k5E9uIoHARCOqRq/F9Hb4Cx8H4y48IirlJ+mNLkz27zIV97+hFz+bTM/tldsiSjuj7GwTVbAMuGpNltvys0i93DJLoutnqg2N1UvdluALXq82tPbawJcrjhgJHlMOa4Iu2r4NoU3iLkH8NkEPODksPT88f+jQ==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYZPR06MB6638.apcprd06.prod.outlook.com (2603:1096:400:463::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 01:50:46 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 01:50:46 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Thread-Topic: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Thread-Index: AQHcM8zNOOsbpV3YnE+OmVgympoxjrSvp/gA
Date: Fri, 3 Oct 2025 01:50:46 +0000
Message-ID:
 <TYZPR06MB65687E6795F9C899B3F067CEF1E4A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
 <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
In-Reply-To: <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYZPR06MB6638:EE_
x-ms-office365-filtering-correlation-id: 13448bca-8ce3-4ed5-a089-08de021f4534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NodmLYu9gah0X55bjM4jn7UW6fscvp0Xir9To8SUIFvZ34SFZ3GajCYyfL9f?=
 =?us-ascii?Q?MMfP7RLSfYmjqfuiQBBWiYlFFkP2TZLqmly/gX4ILc9cbnvOEG0YgpnHMJVq?=
 =?us-ascii?Q?Dj9QJN7CGC+rdRpa4vkwDjy0/fo0+Xs7pnnMH7L0LD7dv1rJvc0Rsr8i2gj3?=
 =?us-ascii?Q?zQ9t2jor0q46yARXhpx79/mUGBXS2uctfCzEZC2Qyw9ulsP1YMRS7FgUSpkc?=
 =?us-ascii?Q?YSs7orkj1WXVu1iCEFVvYC/SFX7dhaKK4c7ERoxCqzU9dZXg5Mk17zthW9Cg?=
 =?us-ascii?Q?BSEk920O1JGmCeSzSiAkYOmGOkjtaCRGzQvDPDmYRhC6qbW0uGdHwZFgiksl?=
 =?us-ascii?Q?daHraI8mylg4pCMMDP1W7x+EMVUVFkvh8kwgPfpP+7UlcLsHmHR9kB4XwZl/?=
 =?us-ascii?Q?qpMCpizIq4/1cut7mHUqsyi8hVVeBmE/pAqajyi8OVp2cC73JBayrONU4KSH?=
 =?us-ascii?Q?KShRHC4MLlFLMzb4X7HZrb71u0V7VH1+kMIIhHxZIsvsXPhfKo5qdWhER+1x?=
 =?us-ascii?Q?J5eu9+qd5OMEF/bbxCQVv6r1QgM12SQOEnwum7dLWCxWiFZ+b25ESF9fDmKs?=
 =?us-ascii?Q?saUsDcpESTwdvC2enyiMXA1K3vC1CO29SY6T8ki3UTtTbm1102/g63rJ4sN1?=
 =?us-ascii?Q?+J4k89HO0gezrrThGH+tsvgvLckLJjESvHo7LfmoU0t6/4zyfMe7ginZK8Iv?=
 =?us-ascii?Q?spRPCoyyOIUVlPl/5FrItxOXifdkVjkLivpH9OYA3dj6/2rBScGhT6HYympI?=
 =?us-ascii?Q?8ssBRQ9LOYVbYjcOxgToASlC3ei1xydxZLLcyYLR6tfv/vIoEvpQmi42nkJm?=
 =?us-ascii?Q?MkyFLTR2W9C/Yobifqs46blan/JvXPkZXXSIV1mictTgRnMbIxaobmnu01hA?=
 =?us-ascii?Q?tr/7vm/ggBeCnXJKiOZJ+bb/SPcYzS3dH+MoQvvKouCZAoKXAgxzh0sR/AiE?=
 =?us-ascii?Q?2ZltrLwIR+P+1XTCeFif7fbD/XFkK5oyHPUwChpS/IJ4zoH6gm945X1AAyFL?=
 =?us-ascii?Q?TgoGEsdszI0Wk64Vpvwza10wV86FlctyVz78WtjJIVy7Px+fzm7hog+UpCzG?=
 =?us-ascii?Q?1rYi1TbAM/ISt8iY+NUeloD1P2CE2JC6WAwSlsD3WBsjsqBxxKldMZR5gU2R?=
 =?us-ascii?Q?Fxra7P3ai+CbcnZe/Cy+eJWQ9vapZBiq35h+76eLKW0vgB896Un8hKBRZve6?=
 =?us-ascii?Q?5OEFCKR6vFD5b/OkBmFKQ2AOfzG1+F7lzsnP6mexGybK1vOrIme5b8kUDGJx?=
 =?us-ascii?Q?SXkHh6dNYtqEHdy0MAvMKeZpKtYB900RL6GO6TKcLz9osUzY4UETlUKNERWQ?=
 =?us-ascii?Q?QkkrahGKakunP4nBOeMxCd+MmsSSk7uKSpx44Ea4RnHcRTSLSvsnOaGtT3ST?=
 =?us-ascii?Q?bfVmfqtEmTl5VihSBb9UlHAhQeKYee8mv6b6AFmL2qd1vxnE/9xwkBliSFU3?=
 =?us-ascii?Q?i0KIVAnawJuniCQZq/60ShFt+qSQeJlUqdgDM3nsQTEx/9PTzxsBnwLDR4XF?=
 =?us-ascii?Q?GNzXxkkvXDv8lF2UcYiUbbrrIkq2t3Snv/Lm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tTCznd/P4WS9AlaaGeAkon0ClizXDfidlqNS5zwhO2ji3wb4d5cNQmAZnVxE?=
 =?us-ascii?Q?vr597oSsWHOLcxDvwx/e3UHOFRLn+4dDvP7qeUTYSqNcA85aBYR1Ycz83yAR?=
 =?us-ascii?Q?pdL4RPXiE+jNC2/Bzj+C0lWD4cIGDEx5xWJYboPF+2sXLysk4MW9cts/Eeso?=
 =?us-ascii?Q?BwMuaCopXwTQqLsXDJCplxhKS9xva59GvaD2HGe5W+KrE3D91xvRb51W/jjq?=
 =?us-ascii?Q?g1Z7yDTazukuNs4pbFBtx8pWr+I4L5mBbZss6Mh+6oxTWj9+iuBdghhSUfbU?=
 =?us-ascii?Q?FKyRS2Mygk8ZSaVeXXZ022M5wLu2KEfcZGJ/9Z0v5KGNXOj/FAh8LheLn1qJ?=
 =?us-ascii?Q?V8Mpoo9Ini+fi0W8nE3G0+s9URNu9h+q4RGbQ9rqK4QTyShZYwtwwlc2Lttu?=
 =?us-ascii?Q?xET0WCD/VTD5p3vqOUDztAiSE2fymDH7u8J1THaNH/Zc65XJiFP1uINqJMUJ?=
 =?us-ascii?Q?bQN2vxlgFWlChB0wTuyKUP2mbQn2SQpHVMhEFZnZuuqSpMaq1/jFN7rLB/zD?=
 =?us-ascii?Q?JrTavYZbknvXno1vY9ELcDb3ogsanoJCw1XVOY9EUYnPVB8nDGhAY9Kf4a/U?=
 =?us-ascii?Q?mNDcd/E7nT/6GPP1Z4EbAin5B7s/ZtzdX9UuaibVYslMdjT9ljoT4/nb6BtE?=
 =?us-ascii?Q?092SQGZsMgnHd6JyKtbVtYAdh8Q3VT8XtwRL7+CvYf38eQ1bh2DLB0YyE5Tl?=
 =?us-ascii?Q?CtFji0NQ47xhba8VzyPukx8hm3mCLdr1nsp4GfK28AIkYVU2NP7VF4Z0Rt0O?=
 =?us-ascii?Q?Rq02e2mk5kG+CbyhfVsvPLiNgRO+hfEqBBXyv4nXTqUzlXQbSDGmNGntHl05?=
 =?us-ascii?Q?/Tdoj5c8DViVJ2KTKkN4RI3/+y2J3GnXYhlj+mPD/W5X2jaKY3PqXD8QLRxv?=
 =?us-ascii?Q?Ww3h703VzvedcmjJdn6V/tCF0zwJZMFFVJA9zqtlOEPAA2TgYqLMa2Rt7uXS?=
 =?us-ascii?Q?AwoLsFLgf933aH3bORE/53Pi8WkSIT5M0fwkmyj5x/JGy2sbE9yTycmqASSM?=
 =?us-ascii?Q?VljDVyup2zSPNVDgq3zEOaWYgWHti8dm3yE97nSRFvmRCgZp9qY7GWPvsYpo?=
 =?us-ascii?Q?lwrcHPufj8NL5cbkWAtpAUE+jpIp5DEzKBC/d1+dMYL9xGsiQ7/2IlU/14aK?=
 =?us-ascii?Q?O81J+7GuKpHPTwf/WmIsvUXR7Ux170gWZGiOGHVMU9roZhkyP1SXL0PDjtqy?=
 =?us-ascii?Q?yeUaBLTy9VQZPsKN5VNP/ntjFj23pdmn9IM7kb7oQW3YjN3tXlaCVzDgG7of?=
 =?us-ascii?Q?0gpRg6h/Cqam6Nh1ODCj7Sfk8z8IQk2rRz/xyjMB8qKoBKetbVjkJgg2pUO/?=
 =?us-ascii?Q?A2++Sg3n2tt/8N7ELgDyapsfuaDQnMcZq/omF65GHTaHtQDQliNrm54fsybz?=
 =?us-ascii?Q?KtmRA6NvRrpqYPcTUdzFvIDfhn1/+N0dj0Asj9oMUV/dznJOT8SjbcqJbzfe?=
 =?us-ascii?Q?d0T63CeS2qllTGaCDEhUYWlFzWjeZGEdrBt6oSNGWud3CVfiZmMvxv39q86L?=
 =?us-ascii?Q?fm6rDtyhg6hnayPHI/LtXkynVLuLc+pa7Gx7CuuMPKkhtdZvhOQtr52TpA5g?=
 =?us-ascii?Q?WurmjJGZKAHFtVmKh+NgtYdGZMHEQUuXMUZ1pAxylYayZU7b0a6vqWgLLdG7?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13448bca-8ce3-4ed5-a089-08de021f4534
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 01:50:46.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fi4Z+towlsnIA+mEA7vFuEobgnuJFojNxKiKAQmElCRvUuusifU2IBt4CHvrsgO/fmOO3rHWv4sBWiAnxL7gszV3wpc7lWKoSp4z3xcNPYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6638


> On Thu, Oct 02, 2025 at 05:56:51PM +0800, Jammy Huang wrote:
> > Add VIDEO reset bit definition for AST2500/AST2600.
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> >  include/dt-bindings/clock/aspeed-clock.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/dt-bindings/clock/aspeed-clock.h
> b/include/dt-bindings/clock/aspeed-clock.h
> > index 06d568382c77..421ca577c1b2 100644
> > --- a/include/dt-bindings/clock/aspeed-clock.h
> > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > @@ -53,5 +53,6 @@
> >  #define ASPEED_RESET_AHB		8
> >  #define ASPEED_RESET_CRT1		9
> >  #define ASPEED_RESET_HACE		10
> > +#define ASPEED_RESET_VIDEO		21
>=20
> What's up with the gap here? Are there another 10 resets missing?
Thanks for your review. I find this is just an index of reset map. I will u=
pdate
new patch later.

Regards
Jammy

