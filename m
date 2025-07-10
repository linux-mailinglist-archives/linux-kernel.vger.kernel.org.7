Return-Path: <linux-kernel+bounces-725976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD3B0062E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3552F3A1B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B42749C8;
	Thu, 10 Jul 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndigital.com header.i=@ndigital.com header.b="ReOGKDmg"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2096.outbound.protection.outlook.com [40.107.115.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8514274670;
	Thu, 10 Jul 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160340; cv=fail; b=Fbff5LDg2n0hhQkcYqA2VBM7idmJnplXmbEPdzmWfJ27+YbQLlp533Y6VZV8Rn+6X/DY3dGBoZPVCP/yoz3qoT2Bfbxekm4nurjvU7j5M5J3nqvw1pN1d+D/CTvWGzGyUh2Pk76nD9SuxEyKQIsnGt6V39GzRRVTtrwfpsgZMbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160340; c=relaxed/simple;
	bh=5DidqyAfCefXktjpPuWWC2L8FoE8i8x1RGTMngiq4fU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KlXzJxoK4i8KNxOe7j3Rum6jAcl5WN8eWSWFoCkujIeqpI6KTrGwzYfe9BW0i8LXKFsxtEWum1RzzXCR/Gm7roswPoITL1wCibsOvwk5voFZAUPAy8Xmtj3JQuenfeUlNCF8GhAMRr0TnqowpvFLB7O7tVf724juqtZ0n2I1YRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ndigital.com; spf=pass smtp.mailfrom=ndigital.com; dkim=pass (2048-bit key) header.d=ndigital.com header.i=@ndigital.com header.b=ReOGKDmg; arc=fail smtp.client-ip=40.107.115.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ndigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndigital.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg05A+ehHT1czLt5quMemOHtjEfKqoN+Ge/gU/ASJl0/N1pgqSDriTUbVcXOujOn2kABnqn1OPuoxmN1TDTrAqvWDffJ2pvFKNi4BE5gsyXyYXUuTArmMxQE091v8dDK/sOR4bSxb1/XH+m2w5q7oCpkAlKnVOR2brt8HKnjTRm73A7OGw19D+h9tF90bPBr2A77DVmtnZYlV4eZIUoI2YAqbePUBW8AXtMgQRLmbYtPMacUt6fzVaBDDuejBy8RQVoVswasPXGL6GT1GQDq0wepJ4xRd9BnubykpZ+vJJgELXxjrz3N9MN1mM+kxqgeEFsyqBM+UO1VsDkHMf7X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gbjmk56525fJbSU+vhO0FnHAKSemeY430GD+7OeQ+4=;
 b=vLhenHEogSkT/9mvbt6Lbnsax5FW5v768bpTxwfpg1kpvNk0TshmENgE4IiLGhWFkzVdpv+ZlHU6/qPTp+sQsiIkJ+kvuPH6dgzZcgckCHbwcDMbLO6JQSWduDtOxmXXINRWzp/O1HA8sYXgA54S+8kXzJZt+8ubR0caIljPTxtGNnpzZFQaMY009Sqh/u1LmpPHHB6fBfEk/o1c7VZ5wXddd1BJewmTYJLkZWKM15qQqz/sAoa1G0gwfqyKnd2PW8zxXRnBAD16JCVTcg4V9hu3XX3sYv7cvftvDhyE2R5oEjPz01WAdooc/cyi81G9DQ0OSPcMSt2fLA2cOnE1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ndigital.com; dmarc=pass action=none header.from=ndigital.com;
 dkim=pass header.d=ndigital.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ndigital.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gbjmk56525fJbSU+vhO0FnHAKSemeY430GD+7OeQ+4=;
 b=ReOGKDmgET3wAwA73d9rZTy8NmoSU2BXk3GdJJWVsrFaTqJkI64wcoRJ6q+NxI5tD/HeHqBjfp2Cn3l+xThkpFzw8aTJLJSqu+B5ykbKz1AL7jKl7K1RdTGD45m9UquFeEzfShL4e5bhCywVSCxrrVyCujHsSaUAdPd787M7uvAaZqoBhqRsNdjEkjcHkXW9msI8K3RWN7omCTFOJYJgs+HZiuyuBikmmUldAmOU9PJt/ivANHzIs5N1hIQs3l7EuF31quENOy3K5AdtgEKKnqmoW59v1ojbFJy6bOoOgS2y+s7oL5v22CF8svP0M/Tjwr2GEIBPnjGfXO1qBiCQfw==
Received: from YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:27::5)
 by YT4PR01MB10550.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.30; Thu, 10 Jul
 2025 15:12:16 +0000
Received: from YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::206e:a5af:7f5f:76a3]) by YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::206e:a5af:7f5f:76a3%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:12:15 +0000
From: Ryan Mann <rmann@ndigital.com>
To: kernel test robot <lkp@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "johan@kernel.org" <johan@kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] NDI FTDI USB driver support
Thread-Topic: [PATCH v5] NDI FTDI USB driver support
Thread-Index: Advw2GRSB9Yv2CEkQnuozIy7DI7+4gAzy7yAAAEwwKA=
Date: Thu, 10 Jul 2025 15:12:15 +0000
Message-ID:
 <YQXPR01MB498771A8FA494019650FDBBFDF48A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
References:
 <YQXPR01MB498735732651163477C995B9DF49A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
 <202507102257.nmqBkGkG-lkp@intel.com>
In-Reply-To: <202507102257.nmqBkGkG-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ndigital.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB4987:EE_|YT4PR01MB10550:EE_
x-ms-office365-filtering-correlation-id: 06aaa721-56d2-4b11-2c9b-08ddbfc4279c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q5BNKC+oHT+pX6bFzGNTwFjq1L7oZIxCHNtDiN9CsA9bDmmlekeJXFc4XxdJ?=
 =?us-ascii?Q?AkEsVIryDskexmxpma1vM1l40XRQHRFeaoqgypitYeR5fQw6/b3UVIB6YqUK?=
 =?us-ascii?Q?JcORG6dyxf/ZBBsMnb2VYR6effW7oQPj4Gq8d6PywxRJ5LPkIZTXb5P4X256?=
 =?us-ascii?Q?YSxSHIW2sbORNPT0hBuuZyDvBt38VdqGholUqEeAOZaWDR9B/9KwqF36sXb4?=
 =?us-ascii?Q?o8iugRnhgduEJPWH1H1qQlvLUBKwO3Ah/uVYnCXHW/MtoiefAZ3HfApJe+bj?=
 =?us-ascii?Q?Alv9ryGmST/v/D/b7n1/sR5OEYxMcd9lkOaEGoaZkxN9hVVbBiYvysPFHvJO?=
 =?us-ascii?Q?mAg0qaEVtCyJOz7CDxPkLIWPNzNny9/4B5teNixFke0gQH1bdWfjSXUBeJQ/?=
 =?us-ascii?Q?bIvPT/Btr7txtoL0hyADTuZa0QEsJIfdcuZcTUW2/pKy8lkGW6v1y+/WQdYI?=
 =?us-ascii?Q?S+LshLNjIS5W9DtyuiiBUTrinldo0bFlKq1djY5qktQWD6jxijG9TgmINuWk?=
 =?us-ascii?Q?RVM8vj8j20Y1i8WX/ydmnE5OVmhvfTKRz2rZZPKvIelBkDXFEhuleQ4av7mF?=
 =?us-ascii?Q?sf0lx9Ucmzpw/P8iyELZuZePFoq5aL2K+wk0M5+yZv/VB1yjgKuto64RpX7L?=
 =?us-ascii?Q?KdmX3FWS5FGPVALXQsmtgIw/QcPQiYJNDsRi+kXF1nCBiHIjKwOLX/UMsyG0?=
 =?us-ascii?Q?Vibfi9ZHkwRu8zJ6z+Xh9NshE0R+47GK7CNQBG9bcAgFBgGQSa82EP3shIAt?=
 =?us-ascii?Q?jZFCgU5QR0cQVTZTvDlq0EjS1CfKlVpLI5VXhYDm6dR2P5EL41qzFc+2nWd0?=
 =?us-ascii?Q?kqBpwrlNGTUeSKPOt8kZC7VbE1lFpIAFrqNLmnIomZ61Qyk1XwEXw6fNF2FQ?=
 =?us-ascii?Q?d68uZSgY86GZtWdFHwY6O2h1jDvzZKytsXhapF5bTGqh0Cq1NH6D/MsvTHkY?=
 =?us-ascii?Q?o1UiIWDU2ojlbQFf370fYgUr7Et4oeIjYKYqZ2vinVMLq4ukoKkKzMXA8Ssr?=
 =?us-ascii?Q?CxVWY/4kd9QyhuNwtvST+zcyrL1vVhuZsoC3Z9UhDzveuLFR38WHIY+Jn7fk?=
 =?us-ascii?Q?+xNlNSGq0xDboJt/C3onxnxBRBUkiUDonzlWbB3VMy3QE0MaftBSVnAPkVlb?=
 =?us-ascii?Q?bY9LajTSY87j/mBHDzzA/NCJiWOBnpPBjyxFjLAObgK0oHV4YAE4MKjcxeSj?=
 =?us-ascii?Q?bEVAHFkEp9FkagHhIlnEP0RwfM02jgxxzU+1hXi3yAp2weiwdEeISMInKDlr?=
 =?us-ascii?Q?+6Q/d37vGX8tDqcNHYpdDO+rzOCSwt2xB6WfiQzNn4a5a8l70yHEEOAtv6R7?=
 =?us-ascii?Q?Ef0DP9Vm3T+ruRvRZc4thWlZt1EQ1Qb57MIqpnBy4eJlxeR6TeoXqAheIRQI?=
 =?us-ascii?Q?08zYREzNl/LN60Dij6V34CkM/BNykaFQjHCFkiw8t+xUpSV1CPQSNpuAuLgH?=
 =?us-ascii?Q?3QI7EI8AUZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nQhUNIDUXTcBBZHKGg15aubAC91JBYFiJJapgVBL0P2JHY6csO1GPMLHv9+E?=
 =?us-ascii?Q?qOkfxjJLkl2mRQxRI43G0CvUyLzZAuDCZNxsWb/93hRJBvTGpY0h2vE1QCwo?=
 =?us-ascii?Q?pcrIS5GEIT7eOEcJ2XuHGifwRT4pjRzLai3PY0oVWHgdNmhivWq8BVIGgM9d?=
 =?us-ascii?Q?IMCwzuGjCKjmMJ9y9W/kVaYInhaz2+Hp/1p5ovPHxVEVbKjV2oXF5DQIIi1A?=
 =?us-ascii?Q?bol9xDBkrwBEWC2hPMtvQk6F3SORD3KiYCUM9ehkLXF5IT01INq3CR9nbPIV?=
 =?us-ascii?Q?sjw8OTXmQ+YUrhF70qtwRLnRIC3PkyXOlkt7GfGdA7e8A0x4NJWipua6CbwZ?=
 =?us-ascii?Q?JojnU8qzNqi3gKDpctx0cJn/RBC/zZBSvwy0i+lyTpuYFAzyah/ED2LQQRFe?=
 =?us-ascii?Q?wQ6b+SBMTu65LJQ3LTZz/e9DTeokv6ttdbrHoXXNQEc5I7MAxuU/jE9VyEGZ?=
 =?us-ascii?Q?r4apVX84gSCHgy9ksc25BPA6LmBCVD0ufROMnqb2zuvxov9To9hfROUHzS9S?=
 =?us-ascii?Q?TMVhc2tf+cRQDLjEKTGC6ul7IcbMBVLSyN1ppu8fzh7MIJ7gNOee7Fgvf9zo?=
 =?us-ascii?Q?BIMAcfhhK3eRTfUbQLrQX+YScnj37ztO2a719IyzSaPJ/uAIykatJK1FKKeD?=
 =?us-ascii?Q?yo2s/Je/gqtEvW+DRW3hOVJQMd6DocwMU5FWKVu9Dw3Gp4V1n4t4ZkFWQR6D?=
 =?us-ascii?Q?8FV1Qak46GbrUCFQJQl8xRvXj71mKUSGVRyPc/0mk4iI8PaC1HaeIo4i3C94?=
 =?us-ascii?Q?ozZiDF+qooUXHLu6lL9b+HxC1K2/2QFIn6KHh/fuXDqCsaCub43RWxBBEQyb?=
 =?us-ascii?Q?fYtpwRoFIQT0wl0jU1Yci0+UtMcto7sxWrpLnlI3djvo2AVSRaYsLhjrDsqt?=
 =?us-ascii?Q?oD9EG1mfFOoSELIn60KU7ut0PHHL2odnoswkAQebDbBunqdKc8mDey8MwP9J?=
 =?us-ascii?Q?It7vo3YM7glrUf3c7uZCzOlFHoaVELBylWfYyEBVo2kgsVzkLzeayfN2so49?=
 =?us-ascii?Q?vDDwohT+5n3C49AXaDZvDvwFRFiY06V3jg5LwlfCWBI63MyA4SvlbTtt22/F?=
 =?us-ascii?Q?dKfqXUfWPgDhMUMlvdy8/40ooZkECyBW3XTLrFEhnom/WOsOSy480xox3sXc?=
 =?us-ascii?Q?ai92T6esaCirtII4BhU5LMghurnK0CT5VwklnbKCb0Y1cLYZmpnIfZ30ksLz?=
 =?us-ascii?Q?EBzhSk94oQy/3wgdbBtJhsS9e1vQ9yEwwT6ZB6Oi1szuwU+lG4MEv4LS8HSC?=
 =?us-ascii?Q?JG9YHaUdvwDnTTi53ZINNUOzvzWYKtitfwzhPkEaTRpm0uYKk+uH6QBGtrr0?=
 =?us-ascii?Q?LtptyAYLoFPeR98nEQZsQBHjdm8Sv/SxDKtnPyZgqwT0tzVLXOk2jSBeigIt?=
 =?us-ascii?Q?eXNBlWLKJ+mT+Wy2AkQiGw0YnMSUC9xcvC/iD+htajzKDCoMGROw7LZ08cD7?=
 =?us-ascii?Q?Ulkpdh8WcZOsM37fFQR/4W9Tf9Ot5R/RCy+bwqqHbVJQBpi8QMH+RbhoaorH?=
 =?us-ascii?Q?gHpgAn4US3X2xhEGSsPvLGFcso3VLIFkQ+sNeItwbd3daI28wPo483TP7Ld9?=
 =?us-ascii?Q?32bn9rOZ8wKdcG9kumxVNjNX2PNHEoJ7iUsHez3n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ndigital.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aaa721-56d2-4b11-2c9b-08ddbfc4279c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 15:12:15.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd6f7980-6d04-4a6f-86bf-8f6d0297dd2f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7hFD/74DdmzttRlWSHBYORLWsrhiJz9YtH17aKq/X4LNfHIDkoZOaFU/cEoTG8UFJ5i3yMPJdoVOM6fHIOw+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10550

> From: kernel test robot <lkp@intel.com>=20
> Sent: Thursday, July 10, 2025 10:33 AM
> To: Ryan Mann <rmann@ndigital.com>; gregkh@linuxfoundation.org; johan@ker=
nel.org
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; linux-usb@vger.k=
ernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5] NDI FTDI USB driver support
>=20
> Hi Ryan,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on johan-usb-serial/usb-next]
> [also build test ERROR on linus/master v6.16-rc5 next-20250710]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Mann/NDI-FTDI=
-USB-driver-support/20250709-215335
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.=
git usb-next
> patch link:    https://lore.kernel.org/r/YQXPR01MB498735732651163477C995B=
9DF49A%40YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
> patch subject: [PATCH v5] NDI FTDI USB driver support
> config: um-randconfig-002-20250710 (https://download.01.org/0day-ci/archi=
ve/20250710/202507102257.nmqBkGkG-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf=
1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250710/202507102257.nmqBkGkG-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507102257.nmqBkGkG-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from drivers/usb/serial/ftdi_sio.c:40:
>    In file included from include/linux/usb.h:16:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/um/include/asm/hardirq.h:5:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:12:
>    In file included from arch/um/include/asm/io.h:24:
>    include/asm-generic/io.h:1175:55: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>                                                      ~~~~~~~~~~ ^
> >> drivers/usb/serial/ftdi_sio.c:806:15: error: use of undeclared identif=
ier 'NDI_VID'
>            { USB_DEVICE(NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
>                         ^
>    1 warning and 1 error generated.

This typo was in version 5 of the patch. NDI_VID was replaced by FTDI_NDI_V=
ID in [PATCH v6] of usb:serial: ftdi_sio: add support for NDI EMGUIDE GEMIN=
I device
Thanks,
Ryan

