Return-Path: <linux-kernel+bounces-825112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE8B8B025
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54577C7DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D627990B;
	Fri, 19 Sep 2025 18:56:44 +0000 (UTC)
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022080.outbound.protection.outlook.com [40.107.149.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683BC26AA98;
	Fri, 19 Sep 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308203; cv=fail; b=OgM1EaQAgCFr4FoYlpzCGL4RMmelwevIy7f/FpOji4U3cRs7LQk+zcpDkXPscBBSnEOluH8Xm35EG8VtCtt6zB4ZbbddKoEnqSRTf+26Mg72Ers+2dIhv16xKFIXs3azLe9XLgOc1k9+t1rZTsaLsuk/6rGdK+j2LeDTyhIaCOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308203; c=relaxed/simple;
	bh=h5/o1YY+shZRGuoQic3cjbMR0CTdk3MoSOaCfBdgTkI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KhK5aB5L8VyBDWvEfglX3u1QWdhse5wD6crzFE0go0t0JukQsIRDFi6tH9BLauePqCqEt/s3fBEyOFm0BVTTOXYkCm/fGJu2nyxL56oFwJIM8j2TzZ0MDqCh32xGLFWsY9nAoBipXp+lyDlGCk1gVZAdfdtqI8wveDgL/ihnIac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass smtp.mailfrom=siewert.io; arc=fail smtp.client-ip=40.107.149.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siewert.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNQ4pIiTDzpJenqKMsybNCxgIneqrfci1ltbANSRQBeLpGiu8Gjl4c7nLa/xdkoVMiWm2tJ/Oe+rVC29uaDBPvciZuEh1dP6hx1gYB57Xdr/anugOzXAKQdkZva2FS3uaA2lfDZ84YrSUL6rW3ULM1/fzEAFCaOjjMtbLnoBzDJ77firtjM9btNYv2U5IUyPD82AzW8zuEsFdAThDommLokJMyk18HbHlSy5w5rK0T//J1TEgVsQ8eIK0cJncy+V1gAi7ir+c2mKpgNX2excFtg0xfaRnUXoZq2ySYQBMfwh004dIRZLU/+v6xk1FwGNnh10EY87XtH5o97nmaoOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs4Uh4K74TWL8RSETsU76hSV+KEPfMJXMqHwxKo4HP0=;
 b=R3EcZvWg9YGFr2oeP8R/gYGcVKy+vB3Izn0CBluQN7j8oI47y+TJsdXdAB6bD60zJ4qTPU7V1D34dnU5l3LYEUe4fuad24Y6crdiEGntOSAJUbBVCAOtse0q0nnfYWaCxx3ZkvMy4jrKjHLYC831ltUa7FAEjohvdjK+yQTSaTe7cTNYOvTeNNaNCvfV9eVFjOLV+cwL5dk5dHNKs4L3ztoLRvziksaWAyUuX73K0mqHNp4wcKEX1SRTGXh75/Tnv/pgvdhmst4ZiKAONmBEzCvo17SW30GRAyfZ7MqCHpi3ViwFVfe9MuxKSN5eyq/KDSxD7GesyO6s0vuLAyJ7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::4f)
 by BE1PPF39BB4A911.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::62d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 18:56:36 +0000
Received: from FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc7d:1a08:950f:3971]) by FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc7d:1a08:950f:3971%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 18:56:36 +0000
From: Tan Siewert <tan@siewert.io>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: aspeed: ASRock Rack X470D4U BMC support
Date: Fri, 19 Sep 2025 20:56:16 +0200
Message-ID: <20250919185621.6647-1-tan@siewert.io>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::20) To FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::4f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR2PPF7274BE471:EE_|BE1PPF39BB4A911:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8e3ff1-2347-4399-c3ed-08ddf7ae41f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zoEhIQnnOTgPG42Cau/Gb+NG1cqn5CXOO+KOZCfXJ0LRGsRBHY/z0qt+OoXL?=
 =?us-ascii?Q?EGg/DPjS+Ri5uFRDZ6XdN8cinhAr8CShx7f5LMRMlszhNu0fOTBK5sxsorWt?=
 =?us-ascii?Q?5ouMw8NIw3zCwLZkIyFejzTS4haMyXKmYLjh8jfNuBXhSGPkrbXrNKWjZq9I?=
 =?us-ascii?Q?JvWuved9I/YExzSVU8j2vqgAq5enkewQxh7su7w9IKzqmbcc+EMbUlp8XvtV?=
 =?us-ascii?Q?Q3eV2iQEHmtoqyvgjSGxvjdTIzB315G3TCxF/rwOrxkA2tmGvxFtV13k4Hnd?=
 =?us-ascii?Q?IhQLC1cG0QBgnx3q4vW/Njt/NH9U3nsNytfNxk03jCn4Wysq6LzXk28wabni?=
 =?us-ascii?Q?PJEaMEV+V1xWpjfFqItFXurbkvSYw4c7jRWdOwmsNgCrECHMTyjxNBToZmgq?=
 =?us-ascii?Q?cXXrw0YkMrxnUQISXR6d4R/+nivSMbT5kaJbuUB49Xy6LRndx3Ybdp/Tv4bS?=
 =?us-ascii?Q?kxbq2sQbFReoPUbG4IMDIdjjPGt+eNH2By36L3ayOvmwQY9wXbx6/ZnoLejl?=
 =?us-ascii?Q?Z61SpTFOs+G8ys9LX5+rdZkMAr+i2Qlth9bSvN9xPP62t8+i35oIoaihygC4?=
 =?us-ascii?Q?/zykaftCT8z1GPll06yShSOJtwkoNRGg3uwin2cMZ6nmZcIv7bbk7r2Nj44g?=
 =?us-ascii?Q?y4vvIhuo3Nnu79nkWLnXHn7uscjb1Jt78inixtFYv028T9UH6Tcm0ecqd/+6?=
 =?us-ascii?Q?yoEFTZJDBQ8JXwEwtx4huYgFNDc4If9HqjwTRv42yeEB6MmdIabH3n+y/03W?=
 =?us-ascii?Q?OzmdBdhXrJvMdvaE5cWLECo52ffg4ljXpFo4wAmcvZVoe3pOzRoHNM4BhTmD?=
 =?us-ascii?Q?HuyFCIAMNKqEt7jyjdRCFKoE7Jkdnqk74HRrHt8WRP+csX488KHoLtZo1G/9?=
 =?us-ascii?Q?2mfEz0YlOcANeef/pyr2pRQH6Jq7Ug6jELM07796lliMGnZ4eFgiD1Epv1j8?=
 =?us-ascii?Q?hq3zgUUU1LqOUmDR57L7gmlndheYkKVKgQaVpou9m8dBy8om+9bFKE4iSXTm?=
 =?us-ascii?Q?bkh9rKz8cn6vkeuntU/95e1SWWVEgtI8rcxKWr36+HGSYcFMBxJfWhihvEt7?=
 =?us-ascii?Q?UmlEZlqFywQJTOQQ4/qEZ0sWoU/2Le81U2LQsmSRyo7vWdk+IF6vyviTkod+?=
 =?us-ascii?Q?xbXmde/5J/eWMXfTQbDKJjmVmlczpFDjdoZ4PgTvejCutIks3VoT2vaXep3+?=
 =?us-ascii?Q?KtrSgCUmfbY5+WL1wL7P+PLTq+ST2t9OsDCx21fU6C7m5p9jainKXRZ5z+8+?=
 =?us-ascii?Q?7kiLvIEVbzrIUk+ClTHs6GhiZrZc9gE5BjfCIHnSk/1ClhMimYfYS56d6Wo+?=
 =?us-ascii?Q?Lszd4J1c3ufuIJ6zsgq33aCA51km6npxebY8IAxubd1bF+dOmMbStvekcfDi?=
 =?us-ascii?Q?u54mOfXOIgvcNoJoEO9OACPrxtfC5SmnbiHyhgxXXgFkL/JupTFWmG3x1SCB?=
 =?us-ascii?Q?I+1e7lDTgox8oKQYsWvwqU7UXr3Zl7tNjyl9rjJ9iFiBbgHpuri9lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8CrSxf9Fdrg58ZGHUZTziJWvdOPgiA83c5ICgM8JCRvndui0jFeHNUY+/vZ?=
 =?us-ascii?Q?7gBgkCv6EiC6AFc6ZBxwbR/yu76bUQ0GodomLTVgISY53guMVu4zJ7n0PEXR?=
 =?us-ascii?Q?3KRJe1u3w8CRjIr2i4zmzyje0omDKqVYtWnb58x32lu12ht+i+R0MuskxhPA?=
 =?us-ascii?Q?mJ4JB++9Q1oJiK30LtP2mHB+0MQ01GJcjaeQvwZNy4OqEoZuc8V19awKI6MS?=
 =?us-ascii?Q?FPdkjEUX18BuQ2KNyZ30tAf11nAnbHXhae4l2s55+dYCsszrS3N1DeQxXK2h?=
 =?us-ascii?Q?spQk5So2Mr0EZYnc8cm6WYiJtrx39vsh43wxYeyG2AgBGPXT2c5GXQ6OjY8x?=
 =?us-ascii?Q?3g6bHxA18Rml0vmPiq0U6ZGupsyOg4EFspCsYyesDDW34M4BYIX2KQsq2Sii?=
 =?us-ascii?Q?5jrEvXKZsd9LH5AGVIZ11E+Vum6OvK9Xx5uKg6mxBLf0xOUgk3R0AV5kc90q?=
 =?us-ascii?Q?MqW2LlU71eUzlCl9v1rhOYIwBRSJH6G2O4G1o32S01JnjZQKduSM/hitghtf?=
 =?us-ascii?Q?ur8RQ7sAiF6XqoInGHZOcTJ5ay2elFA5WAQ2VwuOOhB4OSG2s2wGMQsfl/bs?=
 =?us-ascii?Q?OfUhATLIcYXN27OkobxvfMQgtSDZ774FSdCFZjeiOeZaVvZHU5/AJYvAxhqM?=
 =?us-ascii?Q?xbs7u38rQY6Tpm5jMgXXXyiT5wOlmzC0kmsKqzQO70J4ZK9RBDW6Y/XTcWp3?=
 =?us-ascii?Q?VvYD42PxnCCeT4ErFbQt/vFhIDSvVMvy0faajdacfA8jM9DG7cjcmVUor/fE?=
 =?us-ascii?Q?PJ4/W430iRvKNfuJzmleV0SyeIYkBzqhSumJGzfWKG5wTgVI8ypHooyTUvR6?=
 =?us-ascii?Q?xJEQLPhy6c3mXVP1wvyDiltawlnTxWXaUg6ZwF1k2lqbswtid0wpbChzPbWm?=
 =?us-ascii?Q?jOQ0ZfHMGRWivh9kbUUYPbLpR4wIMgTZ+Y6ScbCQG5UR81qbZZqa6Qp1+CNU?=
 =?us-ascii?Q?y5annqcSpxdcQVAdbn01E1xvmZ8vhidxacPxNO7WlUR/nNh07d0NlRKCTT9N?=
 =?us-ascii?Q?1j/CbFXnbOSPdzGyIAwfR+W1BfZc6LIlvm5dTlEpqk8WR21U2+KsgaOqjf3Y?=
 =?us-ascii?Q?bqRCNMf+d8E3YjY9UlEEzz4vl0jIbwScXSPz/u+qGy3xuZlcHjRSqMq+8z8x?=
 =?us-ascii?Q?L8nbqkRi4Rk9ftZXww8Gg3RjiWdWJ8O72taCnUwE+RufejW7KwqhP3hYkiAh?=
 =?us-ascii?Q?7jxcJL3B2WEKUULGHWy44uI5qvDug1iu+oN7Mpg0hbCms3VvVTCytCb+1KYC?=
 =?us-ascii?Q?F7w3TGFrA5pUbOohM4oE6CDfhQpNUYrojLG17k7EJGke8LcXf54+lxNf3nJx?=
 =?us-ascii?Q?FUzryeqctF3Du7LD6xB4WQd44n8yaJhRmBTlMsYProOX7Cy2WbrJN4OvwrMl?=
 =?us-ascii?Q?44U1Yx3Whi6nD5MVUFe68rEhYJTPX/k1e6WXZVMAK4hLW7TGzyTseqWEEpSC?=
 =?us-ascii?Q?CmtVPXhV2S9LCMS++3fA8ORPdTdpukgKS/BZO3UOugNWHK/kxW0mocJDPIiF?=
 =?us-ascii?Q?HXKs1wR8u2l8V1XkSMP1dDSX5MlGlyUu4kE4JNQPVrHZnfTRcrzSMy/+qovj?=
 =?us-ascii?Q?JMIPap+XtP0jyUPmtbY=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8e3ff1-2347-4399-c3ed-08ddf7ae41f4
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF7274BE471.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:56:36.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/SSniLkwga1564pauE7qfwXeh4QGA2LXZT9mgGtViHpMkJRx5wLcHDUD7Hsinf+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF39BB4A911

Hi,

This series adds support for the BMC of the ASRock Rack X470D4U mainboard,
which uses an ASPEED AST2500.

The mainboard exists in three known flavors, the "normal" X470D4U, the
X470D4U2-2T (with 2x10G RJ45) and the X470D4U2/1N1 (an ODM version with
2x1G RJ45 that is now available in retail). The 1N1 version also has a 64MB
BMC SPI by default, but they are all swappable.

All flavors will use the 32MB flash layout which should prevent unnecessary
complexity of the device tree.

Please note that this board has been fully reverse-engineered.

Thanks,
Tan

Tan Siewert (2):
  dt-bindings: arm: aspeed: add ASRock X470D4U BMC
  ARM: dts: aspeed: add asrock x470d4u bmc

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 345 ++++++++++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts

-- 
2.50.1


