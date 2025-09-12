Return-Path: <linux-kernel+bounces-813279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03395B54311
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233761C85C33
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CB284885;
	Fri, 12 Sep 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VP1cqlVM"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E225265CDD;
	Fri, 12 Sep 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659150; cv=fail; b=saUIGvuPeci6dedEl4f1qfy0bRU9CGnfKdKNkkiYSBqzYb+oIOXrMNNNFCkQrj9In92M/00IClPDnUrZj8d4gQOHWWMaQQmAa8cOeawVWV7wCXXIhwfZpkkI3BD6f43kXLzZd8GSqibMhCNnd+x3aCyfiMJh6CvGsJ3gjn2ydOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659150; c=relaxed/simple;
	bh=Fga/YHBLrhjsg9X++q0U2IK5BMyDjDrtqTU4qd/YV14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eobrDPJlFpj0oGYy3P7bKP2TQn7wRlfP1BXiiRU3i5hkRYri1upsCVtx/S3wZWASecuJx1qSH3n35/sPijAFjKgoYHsyLe2gH5r5w9r1E9oM/IoOVFMx9Fa+bDU6xzbuadBoDY1ncNhkavCpkxtGjC6C8+VKPA1a32gDmvZmn2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VP1cqlVM; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2D5Oi43HopUC/sCK+6JXifQbg13ydPrGZq36Ch1PWSJtCHjeX868vo0qFzHXUN4aJ6/7nngf0a54t4SBopznHryFZpMXbvfg6l2lUEESrg2SMM9jTLi3+j13eaaWFYTvqupPGip2qlN5hB41xOVneDbzCptryPtp2Qo9lK3PMJpRy5bVlZLigw/DNnUXUxaaaDrz8D0bgjc9M1k/xgChYR2rAl6WFOq8CI4Y64xb2FjsOsE8kduldJoITL9WiZOOvVkfYvdGQXauAQjDl7J5ES5rNXVeeMnKB4/cceVXKp59lHvqCK2QgPDG2X7qStjTi+QSbdB3tjR76yxo9s1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMmVaqs6yb14ZNsWywBqOF/jZ3k8gC+AeqRjCuP1xn0=;
 b=ZOXXIREdAwpUCpG06U9ddQcexU/zkmWgWLU21a6RgNxQn/BgFq/O7vfcB6iw2+QVchjSFnLiAY7ZqIToqpdE8nli/UyBZbxgbnIM1Wq8T9chJYjJqVS/W5f+DrxgL/galTh6NiPk7bzRwidQ6J7sXh+sGBiPpctdadGWS4jV6R6JocTHyAeezcvXa/J22W9HSp2hfZu+lvjylCPpahliimCmRfFB1PzNJtS9fTxkV8xvfo5+RUVJccAno5E9/yblXOMoPMKasFSm0rnWmkT12w+aTX2bdFVggxd+UTa09AJqI8cvER9Bf2OpSsq+KYZP7tEZXIK+QqAbV8dy5K8JnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMmVaqs6yb14ZNsWywBqOF/jZ3k8gC+AeqRjCuP1xn0=;
 b=VP1cqlVMQ7HjE8QzjoecmOJzm3jiLtFHCgkO9zVbtYL7zbgx/j/vxn2a5b1p5O0o+gd8ghVKFbQysCV5QvoM+ufnDvRgBf5wXs5CebLPJ+1LR/1jazxSd+fPcX27B9Z4OD8mWxAgLA4/Dxaz1S1S5GZmM5KDxJyfJBEYu2yg+aEeyg5YwNh24toqRprgPAQMBbhVPy/UHQJibofdfPKi6bPRTlRBsoGYRMT8XjWwRIWbmoAfQXnyVqjbXjinpm4vnVt4027GwwpJUwrCdNnshtmW+ps72udhFumazJMaq7L+TO/jVav9A7gfiBL0avXkf2lKjXC9EPQUkssHPJDhhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8366.eurprd04.prod.outlook.com (2603:10a6:102:1be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 06:39:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 06:39:04 +0000
Date: Fri, 12 Sep 2025 15:50:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Message-ID: <20250912075032.GB27864@nxa18884-linux.ap.freescale.net>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
 <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
 <aMGYUALGv283tnV7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGYUALGv283tnV7@lizhi-Precision-Tower-5810>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4b7226-746e-4a1c-101e-08ddf1c710aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y64q4Q3pGfYURi6YidKgspa96DpQ9qip3Qd4bTVyqtuWWCcIoEBY8tcUf+E6?=
 =?us-ascii?Q?FHVlhsyY4gwMGEnG4D8ZDev51q8tdjsrT7pa7Nu1vOFk6D8KOeigB97oxT65?=
 =?us-ascii?Q?gxmZnkxExyUmy49SvzDJu8zdtRPWe+aVC2nWJlo22thGX+2RQpkTzAogD6FE?=
 =?us-ascii?Q?YMM9+D2DjwZajpH7ivJZCDe6Qo49KePOg6Z7ZPnYA6en36fOpDYiP2GOOG43?=
 =?us-ascii?Q?/gu2hCeThtw7mXI6s43D4mKyvgj466X9eQP5Ie+cjyp8NXA4xBm42QY7nIdY?=
 =?us-ascii?Q?N+1v6pcy4uwgpeloWWEnuURTPDd0BHhD0A0VIQniUwNiw9b3OZo+gKeaOZnh?=
 =?us-ascii?Q?Z7T+NMf9z/ocwUWh5Y3KpyMclQiTPTrfVYPgT0eMxhZDBKEofF87rFr/wAng?=
 =?us-ascii?Q?Gy8yTVx7828r9YStQBKoN1IlzC5Ja6JQf8JCoQJNvRciM7C44LW67TbHJvi0?=
 =?us-ascii?Q?MZyC03mUEx/MPzVVNWRI6ECaTQc8CCeActOg9WS6TwaoWplyHWsQKCKXY3aO?=
 =?us-ascii?Q?N6aadBVbOyTExbiVVeyRWQvh+3slFy6wnNHDXJBfSB/QYoe21YKj8yx9DvCa?=
 =?us-ascii?Q?WrU6p7J6ZW9LyeLg7OzlNuSiwScvlka6aQSPszHD2KWVxiA5ji2R0LPJtT/s?=
 =?us-ascii?Q?BMeQa/v43W/DOej8bRTTRphLjitDzJ5HgbppNH7YToWoT3RrIfhfARExTUDv?=
 =?us-ascii?Q?yYZ+D4KN+AUs9JC73TwkvifaFiorO9Xafs5QbGTOVXfmJotX4cXymsmhB3g6?=
 =?us-ascii?Q?sKKLWHrxgxhbb2mysVoKieEtvVkNNnSYy3q2OTyDOcsm0GmIDfcEMNRIOMvb?=
 =?us-ascii?Q?GS2tQnaiffxZ7EIrIt2Q1ChQb7vU4wqzGYJo0wvSYrv3jLRu3LEziIu/DN+P?=
 =?us-ascii?Q?aZScJp4xbrqJlQ4uzMnoZFqHTshhjYzJnGT9TJ/sfEInJLrJWZjrrAY02A3h?=
 =?us-ascii?Q?m1rSHoGpfn5Ifzk9bJYX0crKe88TVPzEhNKEeO03UL09lcQp7jb7SlB2BKCh?=
 =?us-ascii?Q?8jpwSLUcBl66JmMoEOsWnaS6FbNPyG6WxpjdxY5kMz0ZMQHVEwR3gdmc6dNb?=
 =?us-ascii?Q?MVsmIEOH9C8Y8eR7v0/FViHvezJThwJlxAaBlqkfJX0NxAb0ofBxsTjDq+q7?=
 =?us-ascii?Q?nTC0ALAxtvZdrOZQ6ewpp5C7IWISHPTxHs1RSIaHpHCNrjBhX9E/Xm1xEFMc?=
 =?us-ascii?Q?gF8GkyUyUYYKjp2NtvaxRLB9MHgRiIU9qc5UpyzGExWxzRc2Rf/PEcf2qOvq?=
 =?us-ascii?Q?+o9AemZ7D2AB0kViWji5D2kPngNW+5SxKew+y07U+io4aRh37U4vp3jrUfin?=
 =?us-ascii?Q?pkaASD/YpQraIHJugRT4/YyrJHWaSE24GEN7owTpQGz9b5tBdYvv/RLiA2A5?=
 =?us-ascii?Q?u3m1t/Ub64qK7UWHxiIVlJ5/HxyPeecTXQAZOWR6MSr6PfrMvKHCDLNx0mCG?=
 =?us-ascii?Q?G3j2BS41Bf3DjAOp1boDxA4EMNhv+YZ7/gDubeaPPqfF9jGuvwALAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/yhwu7MvlQyrEUPuzPymyz+/oLoEQM/CR7AicyV6HFIqjgRNzQghws9BapX?=
 =?us-ascii?Q?6nbOqtMpLeHRuUbtf/CPv4KM0DE0dybNt0TMlEnNccBzCyYW3jwxE+4emSI2?=
 =?us-ascii?Q?E5hiQqx0VZ6VpfUFATqTERUt1GgOO2p+aVdxhEyX54nrCag+LmBJUk6wXiAD?=
 =?us-ascii?Q?nMyWklKXUyoRepnNvYes/XQeiu4OnvSGKf9g6psQzdpLruiv9JWzHuyI/cmm?=
 =?us-ascii?Q?ezNNTfGp3B+RwPCQzysmL/MJfXh204e3eHedqdeDp1a/3dxJkpjLq0rP/hmP?=
 =?us-ascii?Q?l0yueRb3fddHTuH0FPlbBicLyJEbKbzMJIeWfrLIBuSieybg3u8q+sRNVKp+?=
 =?us-ascii?Q?yR6BEpLSx5F/NWFXrgvfFJ0K8m0deq/koMf5CxAUpM4uyYebBlJ2t9RsshlK?=
 =?us-ascii?Q?Ob230SzyFPmGlfybr7bnSV+dhyymxk+vNufYYA4k+gJHNtDsDmbdo23go1Rl?=
 =?us-ascii?Q?SjgmtgXE4cYXAmqNEPw+g1qDXBQuWL5vaOGx1BFr35DkLSht8irwE4lBSOk6?=
 =?us-ascii?Q?DH5x+CPMusHbtesTC3sEPiB1algvlXTurQdjqySUYM1tRCLEGhUBZ3t1L80e?=
 =?us-ascii?Q?zc8A1kCOeuwchQyF01RMqmqLxQxCgwocNNSzjLWCDT3ecciL5FeKTzg63ll/?=
 =?us-ascii?Q?XtlX8zfXaspd2SkDMioKv9j++xpu87JGHXDoY/UHJbvjRxJJZKz88qKMaW9N?=
 =?us-ascii?Q?mc57A6vbt7ywq/a8Lf9+EsnzfrVT40WT/SHKzS0WwBBLIANOpqxuAkfwJMOw?=
 =?us-ascii?Q?3t1wwBhIqxh0/hSo1j1xeflY1R/Dyewk+TXiqSe02DgVb3u8IjfPiOZDyefg?=
 =?us-ascii?Q?ss8OzXhvWLIHpRwwrQEkaAXbHLEAKWjD+5Finm8JMDVDWxaoJIww0Ubrl/Ca?=
 =?us-ascii?Q?UL2bea+7mde33itRGgciTLjV4zu+dgXYEh+Pqt0cZuUZS7/jiUZ0Kq0nkMMG?=
 =?us-ascii?Q?RvKJhBquXJvKGj5+rzb3JvNpqnlSltN2lqfxDwpr73dScI6hHyvObxPno/PH?=
 =?us-ascii?Q?uH3JaKilOSKz5FnqX80HldJV1NQBuhi3eu2Bj+74jyaBsBfRnMrNVwpY24M1?=
 =?us-ascii?Q?MlGwZisFfaaI329ABv9VvNmBLdCDtH++vwEw1xbBOPFD4zx/vBG5B2b7xpt5?=
 =?us-ascii?Q?31yRzvJMmlJJh50hgM3f9frO/kiMI3rYWMwYIT0U1w29YlA1uWVdauG055Ma?=
 =?us-ascii?Q?WpbWaLPG+FivCTeJ934smUGm5SY7Jer1yTO2iGVAKT3Ka9kquL7MJrNcr0L0?=
 =?us-ascii?Q?wM6MOdB7PqtHJNT65HtZsV4TxS3GJ8mWlX8mb+EnFEvyzHHgiXVEpxPMxorK?=
 =?us-ascii?Q?30XiyWXH+I4qk8Zl7dssXlJ5YvdOpm/S1RxJgdl3stlncVlH/w+PmGI2xcmR?=
 =?us-ascii?Q?uTU1GYm7AXktRFUS0ImQtir3Bg0FswZibp1UbGfUTCTx14a/hjWE/vo3y8se?=
 =?us-ascii?Q?FatOXXKHfOy+6R6ryxv9ndfiJRJXfRikbhPbth1M1Suv5CPlyY29zlw4JWPP?=
 =?us-ascii?Q?W7AutkxOvuygoAycsc+nlzsTp4nvWoI+1iIRmIcg1m7Ur1mFDIZ79vzwDDw1?=
 =?us-ascii?Q?i/sw1Nb4lmezxmy8ZUJr57yhI/s+1CxuRhlo+Z21?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4b7226-746e-4a1c-101e-08ddf1c710aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 06:39:03.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+XBclvCN6CUhTN1XvS3HYwJ0sbmKta/uFvrMe9vjcPvbf32yHoawG+tDggmtbMGx9CAB7YXYoQ3iVruqwRs8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8366

Hi Frank,

On Wed, Sep 10, 2025 at 11:25:04AM -0400, Frank Li wrote:
>On Wed, Sep 10, 2025 at 10:28:18PM +0800, Peng Fan wrote:
[...]
>> +static int syslog_show(struct seq_file *file, void *priv)
>> +{
>> +	struct device *dev = file->private;
>> +	/* 4KB is large enough for syslog */
>> +	void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
>> +	/* syslog API use num words, not num bytes */
>> +	u16 size = SZ_4K / 4;
>> +	int ret;
>> +
>> +	if (!ph)
>> +		return -ENODEV;
>> +
>> +	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
>> +	if (ret) {
>> +		if (size > SZ_4K / 4) {
>> +			dev_err(dev, "syslog size is larger than 4KB, please enlarge\n");
>> +			return ret;
>

size could be runtime updated with the returned syslog size.

>suppose it is never happen, you pass down size to misc_syslog, it should
>never write data more than size.

Right. But size could be updated even it not write data more than the input
size.

>
>I am not sure what means of misc_syslog() return value. Generally it should
>be how many data in pointer 'syslog' if return value > 0.
>
>So seq_hex_dump() should use ret value. Then only dump validate data,
>instead of the whole buffer.

size has been updated by misc_syslog, so it is not to dump whole buffer.

Thanks,
Peng

>
>Frank
>
>> +		}
>> +	}
>> +
>> +	seq_hex_dump(file, " ", DUMP_PREFIX_NONE, 16, sizeof(u32), syslog, size * 4, false);
>> +	seq_putc(file, '\n');
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(syslog);
>> +
>> +static void scmi_imx_misc_put(void *p)
>> +{
>> +	debugfs_remove((struct dentry *)p);
>> +}
>> +
>>  static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
>>  {
>>  	const struct scmi_handle *handle = sdev->handle;
>>  	struct device_node *np = sdev->dev.of_node;
>> +	struct dentry *scmi_imx_dentry;
>>  	u32 src_id, flags;
>>  	int ret, i, num;
>>
>> @@ -98,6 +134,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
>>  		}
>>  	}
>>
>> +	scmi_imx_dentry = debugfs_create_dir("scmi_imx", NULL);
>> +	if (!IS_ERR(scmi_imx_dentry))
>> +		debugfs_create_file("syslog", 0444, scmi_imx_dentry, &sdev->dev, &syslog_fops);
>> +
>> +	devm_add_action_or_reset(&sdev->dev, scmi_imx_misc_put, scmi_imx_dentry);
>> +
>>  	return 0;
>>  }
>>
>>
>> --
>> 2.37.1
>>

