Return-Path: <linux-kernel+bounces-840163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD83BB3B88
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428F2188EFFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97230F55F;
	Thu,  2 Oct 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ljWtjN4Q"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAF25CC42;
	Thu,  2 Oct 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403473; cv=fail; b=ahQ07cu48ZunRrH69ssoIVKfK0ppPCGHE46YVDYPJc+Zl3MKSDus4yNc4H0wsVXAUPS5F65fkUDF3cuYmBX4l2HOkxMS1BA23GTVwVChUz8ieF+k1dNMxYq1MtuxhBHsbfvEHd47trOprfQO9CRw49spUKvWlWUQIjxpag4hoGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403473; c=relaxed/simple;
	bh=YC+lEaCvD4D/ExRYev0h41KmV9OCajYOqX5VQOEYLvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TboLMOeQCv7sRL3lr/zjsJLaQ+TSMbOrELlpyFkoSR7mAJvBLk6M8EiYFjfjoiWrmTMehlXgdCN6pzk7+ipVo3ulQlDvRp6U8zqcl6NqygnqN+NU+lPjMwc5xml8h6u7agvvjRIctK/UwvrKb6QGUZHOapY/HTlp0nsYaXH49zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ljWtjN4Q reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJNBDJdq6DgfeLuNYYYLG4aIRvxcvEw9kjw39bMISY/Gh8JK1MrCAD68RB5jpvw3lpISX2Fsc8nPop0vypbqotOjB6tzIn/ZsmprHLV8GVvKIakrpSE00HTpRdN8zrNNIujbcakdWvwtAUK81jS1RgiDwto1oV/ZdxK7SYGpIL0LM8AxWik0KapydbM1F/AwOMzBAfcen2oJmT7PsbZ8mNkIyL82dCktbSQlwW1lJ4gHT8KRG3VYzVjxAYK1DTSdopcxvix3XIug99/9dZG6bF/rlvl4yKmUVeikJk+f1IsCVJnFZ6ODjtODRPQW+CmdXxjnC81O7RjgrYiWQCPaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6mbbKgCUZqsR5j3aUqo3vJOZENjXn3oRPuLUJYVhlQ=;
 b=q/Ujf8WBqSL26qXU+StAoppYeoh9dVvAZhaEdn6A9uB58heuzqiCH7LkspJTFRdY/xRK8k3R9niAfPwHm0vxB0ZKFkN0wYBBmRaMNyPqL2QeupYpf/Txfeo5oGlumeLwmz9aRr6u3foDxEHPxnfpNpUq9cW1jYPWCtQ88bh+HNBmBxAYMQloj4d28iBx26GaYmLxlQnssTwXxmwNljDDUS4v6en/JMPNk8kYesO7YbA4JvtA9RFjAvyOeFDqMSd9S7mN193rtz+aIRJFlQwb1fWoG6LcPGE/lDcoDsQSaFa0wPT704vqlXccos+BVT5wWEMUWnu2KHAFA1O6ZF+u1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6mbbKgCUZqsR5j3aUqo3vJOZENjXn3oRPuLUJYVhlQ=;
 b=ljWtjN4QxLLutp3R91/Ajv4CCKL5By9l6wuvQIN5Fai5/q2HrudcMRgZP3LqHavso6BdTqoNc99U4IDSKNJNE6KFGWuQdOMBXrKTelotFqbqQ0HCdFrFXKMEJ5G97/lx7Aw4ElB0eZAs+ehdzeWpBj3h1D8B62G+0YPqT2c+Myu5btXUNrh/dKhtfpJIueIvwIjqXODBhqwNO79mTWeHWU1MhIAowONY/6CQulu2LcFCHxZG+O5KUBYOkaQy/5sZqSggM/u7A4BF73YlkI5EbQAEzaEkPG1x53ne5FdpO3ijrbXRlx6y9eaJy4efZSKhBMx38kN7PUcNbj/nsXJjcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9984.eurprd04.prod.outlook.com (2603:10a6:10:4dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.15; Thu, 2 Oct
 2025 11:11:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9182.013; Thu, 2 Oct 2025
 11:11:01 +0000
Date: Thu, 2 Oct 2025 14:10:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 phy 13/17] phy: lynx-28g: probe on per-SoC and
 per-instance compatible strings
Message-ID: <20251002111058.no6oboayme64azda@skbuf>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
 <20250926180505.760089-14-vladimir.oltean@nxp.com>
 <1ec4002f-6c5a-4f64-8ba7-7f991b0f3f75@solid-run.com>
 <20250926180505.760089-1-vladimir.oltean@nxp.com>
 <20250926180505.760089-14-vladimir.oltean@nxp.com>
 <1ec4002f-6c5a-4f64-8ba7-7f991b0f3f75@solid-run.com>
 <5dd3bbaa-bac2-441b-881d-1a2e0ff0e3db@solid-run.com>
 <5dd3bbaa-bac2-441b-881d-1a2e0ff0e3db@solid-run.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd3bbaa-bac2-441b-881d-1a2e0ff0e3db@solid-run.com>
 <5dd3bbaa-bac2-441b-881d-1a2e0ff0e3db@solid-run.com>
X-ClientProxiedBy: VE1PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f1aa9e-55c5-4064-f451-08de01a45f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?X+V1xKm3oDtT/viGcuPa3pYsoz0M7vCuFukm0zW//Zb6ye+RuX6oGrnDC0?=
 =?iso-8859-1?Q?e4IRXAvvLqlFMYjHAHUwzOW1JDQvMJ+B8ldjm5rfxCV6qauSLF/lnhXHY4?=
 =?iso-8859-1?Q?UGx8DGUZuhYTVXdlboA6JqWDMXz8W8LM9QL6yR6pjoFc8Z+vZvNyKWJ3uY?=
 =?iso-8859-1?Q?j8RyzeBmEIqvSZ086hQ5zEdxP4pvhY7Xfh11P8txfIIhDi/9E2iteb3s7C?=
 =?iso-8859-1?Q?sj5AY7jtPZQIqQ4PM0cDjs12Y2SMRJyTRTIqupsRMRcW0Jrsl6JuKimYgm?=
 =?iso-8859-1?Q?ZQkKC7UaQVkUsiv6poSLQmhu7qoallC0HglzN73/rI4KjbeUT/1P1yIdvE?=
 =?iso-8859-1?Q?XLbyQqxwZrD8aNupFoyBpeEQVcNepBbc2jziSFoidMWh4ehlqOLftKwYXA?=
 =?iso-8859-1?Q?3I+kQUmsrETv6TfYWVAD608CySS6Y1Fh/nD+LTiN2m2TD3OaT88aMYAagh?=
 =?iso-8859-1?Q?QakuAgs1OR3KM0GX2JzIjJr7URrTJ9rEPmZslp5rS6bpoCs0s6mDZkBnc5?=
 =?iso-8859-1?Q?4s32Xa5HgSWUM//0qSXXo1nD29t/JsnJyvaTV1bEZQNJM+ogl0aW5KPDI/?=
 =?iso-8859-1?Q?Z8xpjGksApd4C54pQIytI4FLrJaDqAUqotwisNXCCHpAgTSMrv/MFyMJdu?=
 =?iso-8859-1?Q?8XkwNwvqDTRZ3XwRqw4q9aNDr3wF4iHBX68U8bi0rjZ0XMCtC1jWAaXglg?=
 =?iso-8859-1?Q?j46vexomEhzTuaH9CXO+4LnwTcIeNyUvvPJGvXqXrA74ku6rpVBNFMudnG?=
 =?iso-8859-1?Q?Iv0xR7imJhTwVlOocop1mVWX2EcK2b0wWsvpFYjmLb66tHI94r3X6ykzm9?=
 =?iso-8859-1?Q?yRy++APbujKe8ZG3H7irpHcajL9lGB1CmerxFvNOsWyLB5uRkQFwH+/ZFc?=
 =?iso-8859-1?Q?edRz2EoSQZyMfUntgNRvnGeNH1HoGkAEnWdDZoZQbozLTdNz/mW1r8GHYf?=
 =?iso-8859-1?Q?yg+pPrlMon6gAVUK0wscxJ1+6whafNg/JblUHrZYyJKA1Kffq2EnuaYwBj?=
 =?iso-8859-1?Q?Bhny7dQh8ZyZPhP8xEs6WGMu7CRb+DTSB63PxF4V0nbSOGzkn1PRSokQLr?=
 =?iso-8859-1?Q?JbUArCFl15srAEarz/PSwmvVrvecCyoyFkzt0ncIm+my1Iw1FatDkOczSz?=
 =?iso-8859-1?Q?gnsAA8neezC20qFyw/oHQq54paPL0fCYVpkkZowJwPODvi+zERHL5TDFrK?=
 =?iso-8859-1?Q?ipuj6ssFL2B/hxm+65fcbkmlzo08cZ7sGWYpHoqlgkYVL+Uzs2KASPyaNo?=
 =?iso-8859-1?Q?qtfwObAtZLDpMcuIBAQ+jDuJPBafjmutViUz2v6MFn4w2MItqgjadR3j7M?=
 =?iso-8859-1?Q?xIN5IIbgP6PLooKkpI9IflbD0UH/Kfh6iO+yt0DDwBMcWSE45U8/6aZZLE?=
 =?iso-8859-1?Q?NPY/VHsbqr4kdGUKlvQ2bcNa6kFgrToX27Xow1TSMDq9k3wLe/kUf++hrs?=
 =?iso-8859-1?Q?GPCkZ17Q5lMuGD7KZvdYilU7ayr55Bs0XE/YU1H+MQpHnbk0jjKutzOMuJ?=
 =?iso-8859-1?Q?2od4WHywMMXhfeZBMpi0a+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?tHSK2iQuLHn78CwsLjXuwvXZ5j5e9B/hoFWcTrsGeWM+mk03szNw9/Lv+n?=
 =?iso-8859-1?Q?SDHZ8UY4dtWU7LOUrJoOu+ZEhKClNCx1pZbflPY75JqAEOa+GFLlDw6hlS?=
 =?iso-8859-1?Q?HPPwBkA4oLcOyQ285edU8F7sHVKan5SeLOJ3qjpXECGcdP6BinNrsMhQ42?=
 =?iso-8859-1?Q?Zr9oBqelbMV/kAUr7tQ4KKeAp3wCa+tlYJKQ/V16s5UzzKKh2G0m9qEFDU?=
 =?iso-8859-1?Q?/poRnzIQX0dFwAWw6u9w1etjZnRp2QfU65GlUlTMp4AcaZ/4RGv1M+LV3h?=
 =?iso-8859-1?Q?EgqskMUYiwSPNz+6pTZUFst12hYiTCwWO1NyGPTGxCXNdD0adaI46j17MH?=
 =?iso-8859-1?Q?xM6FMTWluR9232/LksFf/JKPk3ZJP2Yzd4dn2cKjqfSbKqHgyDXyGjoXbk?=
 =?iso-8859-1?Q?N4xPATZPqH4qjoWej16optz8Imh27Z/J4YLjwH+dS9UFq8G9NvrcDSx3Wp?=
 =?iso-8859-1?Q?fvbKNml4XwvMLhTNI0e1YUBcshxn5QBOhhJAYUobwa+rOJs/SYzVn8IgAl?=
 =?iso-8859-1?Q?bmJFOpoN6jSl29XsZY5Ddoyyd2mQLHGruYNPMzpUuuIxd6f3H4HHZyzsFE?=
 =?iso-8859-1?Q?Ukg9pgeEVnfaR2oT4vo1XzWH5coM8p2tW5Xii2ttuGgqtFFSlnrV6i7Qc6?=
 =?iso-8859-1?Q?ZZD5jB6qJctsDzzNw6zVIwWi5fnQmJRdUZI3Ov8BPbuXY/jHSVFFZyfnGr?=
 =?iso-8859-1?Q?aesYpnxOJFOEen5j2QP8Xa+iPr4cicHKwKwl5KEMRUrwo9BUPwg5h+keuu?=
 =?iso-8859-1?Q?DWNJdva7ip16rHAt8SCYLttYvCCEoIi1MlD3WdKAYdXTSbz++M4dN4zOG/?=
 =?iso-8859-1?Q?/sAEcDhTfTE1ZPleCWBk+UXm2HQwvdFyDd+UPeffxO0Ne+Gq3wvi/mzljl?=
 =?iso-8859-1?Q?AKF11kCReJ/Lfk3lWn3ycUrs7GVFXjnPYYYeNQPzy+gvAAMk5VixlAJGh0?=
 =?iso-8859-1?Q?SQsenrONgT0bzML1Sg4GrwSt59ZuVKPaT5ZF2ry8IUADLGQg0LqEswH639?=
 =?iso-8859-1?Q?nQoHHX/CehIW3WsAAZyEtLoQtK2Lv5dfoi+V3dlfgtg9YFs7bzCEwh0EYC?=
 =?iso-8859-1?Q?L0mcolygs6lVZ24hxhFVInVfqdA1egO1f0pkZ3f4SQ4MJW8mVMUTu5H5W3?=
 =?iso-8859-1?Q?C04qbTGhXq5jo6pv/kZZuOD9DYlhQdZ3Jlh1B1E5B4btqcJekVkEn9d6gN?=
 =?iso-8859-1?Q?R6NgrttlcPFhDm2PhiC8sUARRvA7oIq64yf7CDi2bDrexZmpAJzkSkwg/k?=
 =?iso-8859-1?Q?k6y5L95Ymlxa9TpLy+vgNdVt/GZh+lG6FC+bzd00cymeSBd6tFDqpV+cGZ?=
 =?iso-8859-1?Q?8yY6dIiD3+/3A1Gj/G5/WJILQ1nXqc9lnvtC1PKlUFIYZHiJ2XsWw3Hh3P?=
 =?iso-8859-1?Q?o35c/ntuY6Ie+lKf1uX2R3nC1EPHrJOt8ifOR8BLEQtwI2PhAF6abp1BvQ?=
 =?iso-8859-1?Q?dPNEnsfs+iVWVJX/ByQSZe8dHDvEqkP5MpvJ7Cq/dR6PImG1LRXOp4XQxy?=
 =?iso-8859-1?Q?2dzGDj8wLm7dhviYzSp+PA27uijLgeii1XrQluoAyPXmoFS75ObwYHLSBF?=
 =?iso-8859-1?Q?QB5m7eH0Wwf1PqGbrOdXkL3er1i9Fn+74OHooXXUsrWyXHoCdAjXN3O44/?=
 =?iso-8859-1?Q?+9AjPJJ6+5mtG8TXerSY66+1Rsz3lwk6wJpWqBh/p2dYLNVc9L2KDyxxsy?=
 =?iso-8859-1?Q?6MAcAg9edNygdQFMf3HyPQPddXfAHhY5vskXunIGsityEwRe2wuJ4s1rTB?=
 =?iso-8859-1?Q?S5+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f1aa9e-55c5-4064-f451-08de01a45f07
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:11:01.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14qA9RzA/8yoLeultnxeu1FCoe94aovZX48BspAXH7Rf+4IVbzgTKSKKJkU+RNHK4iOmkW0YCWqwbzOoV+QeAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9984

On Thu, Oct 02, 2025 at 10:50:46AM +0000, Josua Mayer wrote:
> FYI as an example please see below how I handled this previously.
> The xlate function below can translate both phandles with 0 and 1 arguments:
> 
> static struct phy *lynx_28g_xlate(struct device *dev,
>                   struct of_phandle_args *args)
> {
>     struct lynx_28g_priv *priv;
>     struct phy *phy;
>     int idx;
> 
>     if (args->args_count == 0) {
>         /* direct look-up */
>         phy = of_phy_simple_xlate(dev, args);
>     } else if (args->args_count == 1) {
>         /* look-up from parent by index */
>         idx = args->args[0];
>         if (WARN_ON(idx >= LYNX_28G_NUM_LANE))
>             return ERR_PTR(-EINVAL);
> 
>         priv = dev_get_drvdata(dev);
>         phy = priv->lane[idx].phy;
>         if (!phy)
>             phy = ERR_PTR(-ENODEV);
>     } else {
>         phy = ERR_PTR(-EINVAL);
>     }
> 
>     return phy;
> }
> 
> While in probe only one phy_provider is registered.

So what is the practical difference, in the #phy-cells = <0> case,
between registering a single phy provider and a custom xlate function
that redirects to of_phy_simple_xlate(), vs registering a phy provider
per lane and passing the of_phy_simple_xlate() function directly?

