Return-Path: <linux-kernel+bounces-740452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D5B0D449
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86D76C5144
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F42C326E;
	Tue, 22 Jul 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mGZApaZT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mGZApaZT"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4028937F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172298; cv=fail; b=EXieASEnG+UXp1BC2HYDYwxTHrH5RR34EOd8JtNwkX1R564twr0jTnRKv+/xSCcK+PHzB9p8gOwmHbB9mOr7WlkJsn8+IBf9jfEy4Zs4KUYlw9OBCX6A7lfaRgAjqLmotKM6jwIbse+03KBY4uSzz9gfQ4yE0J2BajCmgXkbEto=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172298; c=relaxed/simple;
	bh=OxdoGajlQ/7KtBM8yTPVSajr2brnjhisMKqAC8so4RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IyjxpciGnKvs05fFehsHzoTq8YofwltyO7JRjS4ALrBE/jPPKrI1knzg98yNh8ZYkj5JDu41VTLPQXz9X57W9jD76dC1YAhiGcgwFHy8y1MXLVjkVLUxO3/a5ljZDCPFW1VrBM7JLCzEeaBQfDUqhsmGc/Zer9bsz2I74Nx2TKw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mGZApaZT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mGZApaZT; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=buxvMXwoIN/8hTLFRUj0GXh6RcF75kX9cl0nmGpvOFINuvP8IOMwLCNWfk9+AliNYmYmiGFE7F0m1560oWG+2P4hD7aDPAIcfNDIZFb2EiRrndXxWWXy1ELvkx2+93I7f1yUXgIlfHrm23CPOYveGXtwhX4GZOnztQSX8F/+7vMt74MVSRKXbhxf5fVKR+cdO6UDDLY2TalsTuJYMP/wwpjUGsO0ScBmiIONO6xTbTE+AU/RdQEKcnXit+jWp1COrZVuAIlTfezL5ERa6SECXxpgymZA+vyIjFm3MHEO01Av0TaMzhu20XF5olLWhY2R16PZUCFicRA57O92O1+yNA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2zT3mfQl3fH2HBgU623RtMScSF41RdNhTUXj7TxYjU=;
 b=Yd1khqQzf9JFQAQuOYSN+5zk4gyxJnkxUO+k5y0qw7PI72HuvPi+bQMpUtZKOJjWSOz/cmR9nzNN3BH3Sqg3HYCz2DJz2OvnujRQPKFsmZ6y9dedMVl2on4D661WtrzHDbcRW9jX7Ab3oNlNZrQ93TDkYSd5qMMMF2kaGOcEu7VYJP6dEOrOpBYoeUOef2E/lJ3u9Q9x1ncy9ftNCKKR5kayk6OVI4LUUEGb7z18lapzyLJflehfHhTM6n+8mqJ+9hOXO6nytU3DUCu9CSjiQSACSuNcnTh4qHleToSPg84SfiiV8lNc+Zu/+a+5QShDaynuW8gp9CBuSiUbffw0ng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2zT3mfQl3fH2HBgU623RtMScSF41RdNhTUXj7TxYjU=;
 b=mGZApaZTAdIs76fhDaOCR9rFZ0/HrfEdJL+NFDRQU5vaiLFh7grZhQmOhJjxCxgBoOGfGG6gvKc2lk2jR80g5XbDfcowzUahR+Yv6RSH0uh1s6QHEFu2NGw/J+HnymtI54csE+3fpDa4yM5Q8YfLeMTaemPqCiIJbFa/sZm1N/M=
Received: from PR1P264CA0137.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::9)
 by AM8PR08MB6530.eurprd08.prod.outlook.com (2603:10a6:20b:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:18:12 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:102:2ce:cafe::ec) by PR1P264CA0137.outlook.office365.com
 (2603:10a6:102:2ce::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 08:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.1 via
 Frontend Transport; Tue, 22 Jul 2025 08:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXgCSA74J1GFj5wNVrD8twAboLkEgLGaPi4s1DZnGgnsPge2jt5tV3na5aMttn7B7s6g3ZASL9vpJ6CWbPhZdBH1Sw77AJLYIiU554ekE07NQdehnAC81UGX873cJYi2jUga38QS6TMxTCu5uhv3qVIK9Z2cX0Nq8YRTUinjxdVUrLbU13YdnnFvs8int2V4b9W8U9Cnp8h9QGIwmhy2nIxkJvUcpenSdk34hKclXMR5uAmwXFEYZPb1R3exxUT4qkVrrg1v7VzYrOqJMM+u3qZ5FReDcdaLTLrkTjpc8tubwxxHuZJKQDURWWSRUnMX+6JUX/2HA4Kfga7C2fl3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2zT3mfQl3fH2HBgU623RtMScSF41RdNhTUXj7TxYjU=;
 b=Fy5lcThwxiR1xbI15YupDsvlRv/hcDruVhvGCrK9uIHK6LZ4NFviIp2A1+YnlrUSJJXLvN5ouVB72ZHUZRMa6xMJHm02KSd0MWyIHV5mRy6g7RxV5jDWPWs2GoD5j7LGlLjDlTUKYE1skWvdle+eUS+P0zt5pzgRHgvgYvFq0Y6rZZllPpuf2Sr/BBcH8t9rQPVTQSo+pG859YrX6A0i8B/lPRqacyoa2H2Pt6q4Z4MJB7nI56CBj12M6ynTHoXdGUaxbAvCGMcPCudfRlSb6qqSKxSD1ODyhL4PF1MN4bphnG3YyK1QS65/lWsyFwZnQU5SQatW34bEUFOlD58dTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2zT3mfQl3fH2HBgU623RtMScSF41RdNhTUXj7TxYjU=;
 b=mGZApaZTAdIs76fhDaOCR9rFZ0/HrfEdJL+NFDRQU5vaiLFh7grZhQmOhJjxCxgBoOGfGG6gvKc2lk2jR80g5XbDfcowzUahR+Yv6RSH0uh1s6QHEFu2NGw/J+HnymtI54csE+3fpDa4yM5Q8YfLeMTaemPqCiIJbFa/sZm1N/M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU4PR08MB11215.eurprd08.prod.outlook.com
 (2603:10a6:10:570::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:17:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:17:38 +0000
Date: Tue, 22 Jul 2025 09:17:35 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, ardb@kernel.org, frederic@kernel.org,
	james.morse@arm.com, joey.gouly@arm.com,
	scott@os.amperecomputing.com, maz@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] arm64/Kconfig: add LSUI Kconfig
Message-ID: <aH9JH6WSTLKNYgXS@e129823.arm.com>
References: <20250721083618.2743569-1-yeoreum.yun@arm.com>
 <20250721083618.2743569-4-yeoreum.yun@arm.com>
 <aH4b4G2DSxG5FnHb@J2N7QTR9R3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH4b4G2DSxG5FnHb@J2N7QTR9R3>
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU4PR08MB11215:EE_|AM4PEPF00025F96:EE_|AM8PR08MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6985cd61-a1b9-4ea9-13ba-08ddc8f84bff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?fyo1pFxjly7B00r6/iPTZ8LcFoyO9UcXUdr4XlRc2UWpefPPTtJ4EOfLulkY?=
 =?us-ascii?Q?703z+T51TBls3nUpJG1rmaWaOMAG0LMg5oEoi3Iu1d3/wqhXlgYh8PO82fIi?=
 =?us-ascii?Q?ezpIyhGbaaCJIKPhorIycEzOp86yTqdd+IU2Gj3Bes1c89irlkNM7dS/cssx?=
 =?us-ascii?Q?EEjW5ajV/tW01eSHnxo4G/NLq0QkBAVqoVgcKbepEahi8OB5WP6/wSfmYZsA?=
 =?us-ascii?Q?yOmQEN8NFsJO4LQHimTBFN5PfJme4l49wnuwO3zSNmoRDnsHQjjvBmNbJMmp?=
 =?us-ascii?Q?xSY+cuJI2QelbW6ouejqS+LNZqaOm5J5ivGsg7Rl0ZxM9+55WXv4q8IM8Ftk?=
 =?us-ascii?Q?jDjcy6C0Pm8IwtTRBXNhPk03trKOKdj7ze79i7n7jfGaPTpiDt7eWr06yy22?=
 =?us-ascii?Q?1ow1I+sqklKojt1j6r/aI/hPcAYvA/dWX4oNJpfz+62WLELQpDKATPViVLy1?=
 =?us-ascii?Q?3zT8prou63sdpJ01iW75wFkI7Z6Aca7E95t4LKTnBytdxa6yOHs439vz5wyM?=
 =?us-ascii?Q?ps247UsGzWyQ5LplORZ/WmZjjKtvU5DNAuJQy2IEysIpnVwxAyTlBBqXxSFw?=
 =?us-ascii?Q?R8bQ34QiuSolJaoR3sAATxN9/KQz0+el6cWtGYgOMm1ab/kwbA1Jo93sqidD?=
 =?us-ascii?Q?vy3mck7HrtPOvwrYwxmDSglbpnT+XsFEdSTd7TIXN0h6J0W24NLSo0vnqqvD?=
 =?us-ascii?Q?0kDNjtC8FddTptNSesDZm1B1i5acUOiIzWWrxE0ibLRanEHwsGaQCexV8i3A?=
 =?us-ascii?Q?p6dFYf59mrGArhrSd+vprCsNiz27EOS7ozpS8OB2YWl2Im/Ux4YNhd+Ttok2?=
 =?us-ascii?Q?EBHaaXWv2D41kCb3F4M+5q1ZslgbSn0JenKm9VND4iO82wzl65KIhc6UhKgU?=
 =?us-ascii?Q?hyrtlZd3saA+oxieGYdiD66anP7+yLGavr7GGFJV+ieFUIUKsomKLgGfJ0UQ?=
 =?us-ascii?Q?OHCGcfp9OwBdX0ZmwVAX1pERo3f+JNDQs4ju8J/j/7l+Qc2yTYWZZuB/XXwN?=
 =?us-ascii?Q?DAe3OQQiGDHv7VohazYbkK6ojadssgHJKiJORJOZhupJfJg+RERBvQHLiOF0?=
 =?us-ascii?Q?Nodd3bhhExAQtpMXFjivvamo4H8th1+N+SIX2Fa+Vd4TVxULvKUf8SEm+seP?=
 =?us-ascii?Q?n0dZFrbW7l7dzjpNPtqhXPv3QWOjui9NHc0xAqnHGB9VEyW8Hyul5mcglaKm?=
 =?us-ascii?Q?Hg+Xkt/gTYNyBbv5VTwMte2c8PLMQYgpsseHpdWwnCiswQNQDIyAyqPO8ZKI?=
 =?us-ascii?Q?pN3kFIWOBjQkrTYUDBlU9rxii8xgYGsSk9ocaO0ZI1ppB3ABGhThXX7xbB+u?=
 =?us-ascii?Q?mdwLcKAx1X3A0Zjb7muhKSlWyyZVa+RqYmqscnS3Wk5R7AnAKKcmC6ZixnwB?=
 =?us-ascii?Q?P3KE+8MY5O38h242r9r+4ywzL0Ju9cVJhKfzt3tZzrBpKF2cK/gpLr5d9rz7?=
 =?us-ascii?Q?PoqgrbDCXvI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11215
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c6d3b6cf-c748-4e51-2479-08ddc8f83875
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|82310400026|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?StW8WfdNPkMVpdW+6QAin0GiRftcTU28Vgq6s+xi9jFriv+dT8WHQiZdzgIh?=
 =?us-ascii?Q?Wl0D/jwd05ddWRUvXvrALkxIVK9hUFCY1PeIZzQx2D3tVr8Kfbi/QqwMjpFz?=
 =?us-ascii?Q?zmENQ7stv0xQ5UdT6/2zlvPteX7E1Ii1kwzrK5iOaIF9/n0Xnscn+tZ8nbfj?=
 =?us-ascii?Q?WG+0/8o5/LThm71byaGEBrXEJ43kteF6//ebRTPIxN4D10l5r8v6jtugOT3l?=
 =?us-ascii?Q?DCTgWcJF03GGiCXb29OGC52lwPaCP17arP5RsknuH+GTAcjnd4JmFq9OheS9?=
 =?us-ascii?Q?A7CE05KKTI8ws2h8k2vOelLpEIxxAB/6C26eNLBcVCvGqmx17D1W6FqW8wwL?=
 =?us-ascii?Q?TQ+ffV2hedc+tIDP+zEWV9deKCeNZwNGLqQbTN88ETRDlAuPbyn69l9TEKfe?=
 =?us-ascii?Q?R0HHxbcopyF5u/7LsD+eJb5SySbdZq5v64RmgFSka3UkfmVqXdH0+d6ayJAQ?=
 =?us-ascii?Q?WV8knjck4ZGt8Q+4lwNtcKR/SaF19qHmCGwMZ4j4htzkZ5rcX0lmpKzrotbt?=
 =?us-ascii?Q?AuuwsuLB94pTi/YsWnOPbiFP15UfjtmkIK4LiGZ/S4L17ztwCSprD+k7LzL8?=
 =?us-ascii?Q?36E7E5jjjg9coR6RFxEATU1jUqdmKwWvvBkrKZwZnAmgKNunJcawu8dlOjbo?=
 =?us-ascii?Q?3y06JjgSU9PshlGjg1BoV9iAt5SvYCD6Q9FYdbnMSCshCKtqnrXPZjLqSSeB?=
 =?us-ascii?Q?6vetT8CfXb8Turl+PwfMwUq5QRMB9T0iT/x87GNxU4BTh8wfpDG/l2yghUMm?=
 =?us-ascii?Q?VMC1tVM4Z87mIh5nCgcG7qYGioX/0z27KGZUos8p2iJWMUQKRyFEncdcumr0?=
 =?us-ascii?Q?0MNTXgrnskFOacET64hP9+Y/ulh/6RVeYttdDDDVWcT4xdBvsIUMPTPV5WhT?=
 =?us-ascii?Q?oiUJyYAKH+s+XwSIX05MaN3kFQZcZkL7/1ikzIkF5viH+JNsX5MX5jpiVXTD?=
 =?us-ascii?Q?TzkKHmy9lIhcoHLwslXhgAizQeVsJ31qBR6PYYcdLODCvGYYuRfP9a7j+zC+?=
 =?us-ascii?Q?hAGpTVqjEgA4AOH7FHwd/c1i4aRbb1bKGLe0Kml4dz8ODqHwa+PQ2Vk3OJhh?=
 =?us-ascii?Q?6EmYDyZ549eeUOvj+9snuGqcJk1phjlHNiPpTUkXlpitMUooMEhKurZkSel4?=
 =?us-ascii?Q?e1qMToSPciV2awI5jzt4q123TIoclhZkEdFq+Tuc33+FlC/jr0+Zc+Awgx7j?=
 =?us-ascii?Q?xZob7SJw9kaJYLupsqwkbO37waWPNIwwq1JBMXGxJV8VmSd+41GUBVUh+ukt?=
 =?us-ascii?Q?U20yViUAmnLWC+nx0+ihvr63S11l5kcmT7KxU/fM/alOk4Ur3r5PJtCUvr8z?=
 =?us-ascii?Q?uIZd5IYME+pnaJR1mcQSwhFVj+Dz9c70aLigHC5s309pIUlj3IU/m1+cZ9/E?=
 =?us-ascii?Q?gmar+QOSn3WCv47imdjGmftCLIz7RPKrMAT2mcjkL47WPkt4HCNNhPrgsEaW?=
 =?us-ascii?Q?hd2XJFWa1ZhYki2nDNYGMQlcMdovI+b4EvLK82/PcSiM5jwrUD8VPcTGe50p?=
 =?us-ascii?Q?RTCCkS/kN6q1YL4ra936Q5A4Dm9RvTMYJKlA?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(82310400026)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:18:10.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6985cd61-a1b9-4ea9-13ba-08ddc8f84bff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6530

Hi Mark,

> On Mon, Jul 21, 2025 at 09:36:14AM +0100, Yeoreum Yun wrote:
> > Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
> > previleged level to access to access user memory without clearing
> > PSTATE.PAN bit.
> > It's enough to add CONFIG_AS_HAS_LSUI only because the code for LUSI uses
>
> Nit: s/LUSI/LSUI/
>
> > indiviual `.arch_extension` entries.
>
> Nit: s/indiviual/individual/

Sorry. I'll change it...


> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 393d71124f5d..c0beb44ed5b8 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -2238,6 +2238,15 @@ config ARM64_GCS
> >
> >  endmenu # "v9.4 architectural features"
> >
> > +config AS_HAS_LSUI
> > +	def_bool $(as-instr,.arch_extension lsui)
> > +	help
> > +	 Unprivileged Load Store is an extension to introduce unprivileged
> > +	 variants of load and store instructions so that clearing PSTATE.PAN
> > +	 is never required in privileged mode.
> > +	 This feature is available with clang version 20 and later and not yet
> > +	 supported by gcc.
>
> I don't think we need to describe the feature in detail for the AS_HAS_*
> config symbol; I think all we need to say is:
>
> 	Supported by LLVM 20 and later, not yet supported by GNU AS.
>

Okay. I'll change it.

> Otherwise this looks fine.

Thanks!

[...]

--
Sincerely,
Yeoreum Yun

