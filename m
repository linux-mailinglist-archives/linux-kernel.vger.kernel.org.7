Return-Path: <linux-kernel+bounces-750233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F5BB158EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EE7AC2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3487B1F1538;
	Wed, 30 Jul 2025 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VYpV/ypU"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012029.outbound.protection.outlook.com [52.101.126.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13072629D;
	Wed, 30 Jul 2025 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856789; cv=fail; b=RGjx8uh07r2vSnWvgxtNsAYF5uotVjEp/kiDQ/21U9IhIBUfreqnNJt7yWLqTzEQ9v+U4jXER5QxaTDElZcYR8lm3oHFNpmJYQz2IUx8l63lqi5zUJfLZJzv3uGbJeFeLwIp4YJC2oF8xM9+9TQPYI9n8C5QGN1HDlaZz2PWMEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856789; c=relaxed/simple;
	bh=pj87yHSDnXNs9yVV58+ya686doQ05227+HN7VkX2+ew=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oy895XykDI5UbmYvNzDphviJ19ra4CKKq3XT77Y0WSFn+dikIvjmeqWvgsha4lIe03cpn0LtMFbIgdcFitPxjIm3TB/l0aT/FDRRKCm27bHWca4FlHTtZ1wW6TgKfsgzaK74Q0hVvGY36fkREqZG7QkGu2gf4vM0HHEYUO3QyuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VYpV/ypU; arc=fail smtp.client-ip=52.101.126.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsPHmSLlQELsS0akzEDS/He/gUazgHNxjaMccpYJfqU7fvfuoTiLGh5hwb1Xe5D14TwLEbAKQnc8voL9jl+CSCkVRqTepgk+5bxBYRidEd5OVVe4G7NgB/kP4ZFvn/WVsHJ3EXuxOmHNwKaF4jfCyKIwOXq/b4A0s9RWbnREI1zWieITnjnABs5/0KEgAklwZvi0+iDb1XleO6ucGciKLff9riU7WIKM2gpJMaYNFb2c7l1GDRossp7o7a48v6MLlDE9P+SMe591KGckhQA7nn01qEZoan7dU6iGRrhEeTlSUcnonfFbwPMcOBqMy2eJJAD/fSwTOmtaEnzFzSP8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMX+Gdgj9V8zP81Fe/QWOtP0Nadi4sDxD5nF9Wex6RI=;
 b=myrF1FsyA/PBnbU3VNnoGs9doptkxv8eo5Fbvxn3b115EMaAyr2dWfb4wLZNm9a11JRIBvcBUOB2ifleuvmK+5oYmIpylg9JAzbP/A0S5CGO8NjQUD8pI0Eky6+2BLUplyErLNVZ90wVEaN+lvSDN3LteavYGfl4lJ4r/8oXgGzR0MLLAXWSBjTCCRhgRUpKabxO/W688y8oF0gKkSypgvG4JJZngaKQJGPgGxqsd1CEeD9eFDEaWJR/AaHSikUPnd8r3TyxbaLfFiUZcdnDjhakSiB64MHT2IAXcUYbC+Agq7GPWW/37jaqvHTzOh9XyH45iKiOv7SyhD56yJW+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMX+Gdgj9V8zP81Fe/QWOtP0Nadi4sDxD5nF9Wex6RI=;
 b=VYpV/ypUWW6oNDKtsydH5UOtPxoOMM/6mHL/vM6/Woj7n8lzMCR7d6MLYh6OEzUPtJql3WRB1bHPqLwgq2NnruBGbJ0Ao8KBPQyRzpx8+D0LXWDvU0YhMScNensF2Qg9xLambyKg/i+VA1IJQFqWYRUwej3VK8jqMnp8TZM5A5fpI4ilykBUuL354hCbY0UdyNi6MQ7LTeS4GjJ45t+J1eOkDBAGVQFYBvDIz4jD9clC42eSd9bZKfMAOSt21aAVS3ekX2ze6ltK0GPib1kVrlhqvLwxH8/PQFyTTZLP+48rGE1+E5QZGMNCw1cWne9dRBbpN/Xz2A/+W7/r0H1IxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com (2603:1096:405:31a::12)
 by SEZPR06MB7292.apcprd06.prod.outlook.com (2603:1096:101:251::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:26:21 +0000
Received: from TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c]) by TYPPR06MB8052.apcprd06.prod.outlook.com
 ([fe80::5cf4:4746:d56a:157c%6]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 06:26:21 +0000
From: Pan Chuang <panchuang@vivo.com>
To: tglx@linutronix.de
Cc: kernel-janitors@vger.kernel.org,
	Markus.Elfring@web.de,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v9 0/1] genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Wed, 30 Jul 2025 14:25:53 +0800
Message-Id: <20250730062554.269151-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0348.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::11) To TYPPR06MB8052.apcprd06.prod.outlook.com
 (2603:1096:405:31a::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYPPR06MB8052:EE_|SEZPR06MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd3998c-8212-43d0-70e7-08ddcf320002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+KjHKzHj3pCG2HG4Qdk3ngjQqNGsMPjJKx80h5MpXr+7w1jE+fdnU1DlHcB?=
 =?us-ascii?Q?w+kETVjvHNDmQ6N311CCc5qr2Zd/hfuvnIOLZjGp2kKDzrDSQh8lN0UcT6J5?=
 =?us-ascii?Q?8lN+DZ9r8YA//l8aY299uk3dkNrZB+i3VTPLsregup6NZQDBVsv4IU85g8yz?=
 =?us-ascii?Q?FFwXED9R8bj5C9wF6mJ88c++jsorNKdO+WIPNqjmF1AsMGHCpmioPI6zw/26?=
 =?us-ascii?Q?bqH0Uc8wfAIWdgFIXzQIe2uevJIsiv+Ig3kZv+3Ap8r2XYqQeqtFnK+YIiWv?=
 =?us-ascii?Q?XilmH1CTM2z15KUwEWdK17UOxFj3UXbYyfJ9fRg32P4WYsUe0EcQusWEo1jg?=
 =?us-ascii?Q?QEyJn0LMpfI5k6QNUsOoZXm3ZxdidmqTqJwN3BsnyhAnOCI4iWD7Ks8lhhmS?=
 =?us-ascii?Q?loFESZxr9fUYH1KacmhUFfdRhffLExshFRwFXehnfQ3xV2E2uXRYLFO1eBr6?=
 =?us-ascii?Q?16ZHq4HTzJSsSIPJlEGm3IYFSNaMHqPUEo3Ayd/BbLfdQ/oS98QdgP8ggR00?=
 =?us-ascii?Q?bNeO894PihEbh9+fAvTsErfEVDDbGsJpUPa9f35Ypgyo1X9RjgFr9gAfIISx?=
 =?us-ascii?Q?M/TyzwWwOOtD+EbmVBmqn6ytsz+WvB3FcSTdulQLUF+VlXiDOGR3Y5nGFQ7E?=
 =?us-ascii?Q?UuGTKl+gAiniwJQV8dDOSTxMgsFXy6uKFOwSCHJ07gMFRUY1WPNldLOOawxV?=
 =?us-ascii?Q?8GDmFf3UEuIpwXv9CtTMWv/uXwfDvylf7LA85ltpwvXoWVTVLHhHduMh+a2j?=
 =?us-ascii?Q?oUCdgPVEo1dPFD2ORTl7/7gqT7Ks8lZP4pYp0xr3fdqZvSyjp6soq435PYr9?=
 =?us-ascii?Q?IE7xKRrsf3mJT+1fiPoBJOZupHdiG+vY+aH2nw6ITKX7H+LOedx1z+qRp21c?=
 =?us-ascii?Q?WVT5LywiwdF3XSmRqEG5U7FjZhXv44f24J9TP5stPjGW4pkr3gK3NeK3uf0W?=
 =?us-ascii?Q?O1cnlKv81CGddVuN22ZQwe8nCvLso/Zl9v79Sif+kvMLeLWGs6662nJ+JprQ?=
 =?us-ascii?Q?aIw9sBte9IZ3Xbq+0gljjGcy+oYD37cmVoaNxBZTMwCT62TocljiAAxAQmM9?=
 =?us-ascii?Q?oh9zYZqnPabn7yrh7Vx9EH33zVvHT9hvK8MpconeSoAZtAnY+QUlubvh6Kha?=
 =?us-ascii?Q?hkUBOi/skx0OhHjtjdnQJLSPYvtqNZwKdzkmTT5YlurAnxm2xHiZey2WSQop?=
 =?us-ascii?Q?vwP0g478yDjdfeQBoxdWn6EALugbIgPaDaP9JiDx779vnF4QffuCBrug7ORt?=
 =?us-ascii?Q?Xaj3gmX1dwzfkMX1KL1YFLAchnXdEFvS9hWO5uljS49bo5feU4sKJxUU0O6V?=
 =?us-ascii?Q?DnXtsJE/lfxwoO+0DWJAi8gZBHphwMvfzki+7i+Sm+PvKgaLxA6cZyMfxGPm?=
 =?us-ascii?Q?qfq9zxi3xDxEy6meH2apsFgFeeeqKnmt2JfK7qGHX67d7EwHgVJLlOz0+OTH?=
 =?us-ascii?Q?hd2yuF2fH5R8NBwWtj1yDcEceGGf8dsxEsoHFVUOyo4G/vbL9/mU8ormutfn?=
 =?us-ascii?Q?BXFGnQRajYkX9YQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR06MB8052.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cx6zcI78yxE3TrmowUa17tykNQSTSOjGVcd/CJ+FczJyfyvvAVSwur1Tx+1Z?=
 =?us-ascii?Q?51TjCHONPmyddedF9STBP7CwF2imNQ60QAQksCOnh2bp75FmCJ1qNgo2Uc/0?=
 =?us-ascii?Q?Bfl9YAHljdvm4BGbOg+8QfKEFc8bdOgIXofihUw6Lu0c+u/fouSNvLDIpHc5?=
 =?us-ascii?Q?GiW4jXabu8eJ02iouWQu9/59oZDWQjK1SD3roM01MUJHlhFQqlPaREUJ+RIw?=
 =?us-ascii?Q?x6oylK+5ooTeCw6navnJWl5HdrNcRbB5eiGtEiku0JHdK+JYdrL3MHRaXmMg?=
 =?us-ascii?Q?6nQr9rtznQICDS6a6uYzzjWsUgxtOx7qEdI8NRDhztd1XUAHg9pEBYMCmif2?=
 =?us-ascii?Q?F7N26fIocHW2vV2OziFjAtukgbFVfd+4ZL2P5LXB3nX0OaxenD57XRaVPtgg?=
 =?us-ascii?Q?W5deSWGvcNGkqAXcCPWd/s1TL0JX5j/W6HPRnIPt42mQaPjl4+xuHBSWQ9jX?=
 =?us-ascii?Q?MYvVVS/jW6vLjQ0Jp/eiIVYqYOcBqSp9JZEDA1AgcfEHawsO3XzNrBINkAaO?=
 =?us-ascii?Q?x8fJG6lzky/L0QbAg00gdQoFeuEv5hMKEjywpn3ucku9iz2pSb/PJxfvTVlW?=
 =?us-ascii?Q?2xnUKjSHIAprvModBNHdnR+ioq05SQ7qMHWP7WZ9TwTZUp/37xKEhXpuEeNw?=
 =?us-ascii?Q?dcX4BcpfpFnS4+4d0uoRCF2e/AWSaVJlMj4quERn1bLE9IHdoGxS762GRnM0?=
 =?us-ascii?Q?rDvYAjLG1HLR2px61BavdutAvt2mHMVgD2xXMrutF07Jr+SM0AZDkxkKBLr9?=
 =?us-ascii?Q?92c4fbGc/zZe2eieuuVQAsM8x+tLVrgy9hm2FKS1ynWJo9gSQb89tigy+pej?=
 =?us-ascii?Q?sgbrreoMWurPjUC9o32R7sWfVSn9qtO0pWiMoQDKMNPby02MlUNu1Mdce/g/?=
 =?us-ascii?Q?FGaP0vbBuQaPKxxQMht39cT69Z4ob34DS6bnOMHTCsFwH+ySE35M6XH5sz2e?=
 =?us-ascii?Q?7zHuGLWf636tsG47DsLZL11QFV4aLBR/0BimCyl8XzG2utpfAYgmmtyjCGrF?=
 =?us-ascii?Q?1TnONd7qyQ0s3BQT4+DXJYTFOq+JI4Mx9TKknLTXvz/Xsaz1PzmerDjb7jxq?=
 =?us-ascii?Q?1usLYiqU4AYoFL56s5v/ttEd2leBYG4fMqRK+zH/L+QZ7gmE1AYx6F9vYzD/?=
 =?us-ascii?Q?nN5QCXFggJqit3yJRT4qSWTp2lWM8zjA36KPD+zbdqVQ8xcHGIyMMaRTBm3U?=
 =?us-ascii?Q?wme46oRnSB87Q2KJ8ZOzFWl1jw+mvXfS4l7a5Z10I1++s6NoIgT7cSLu6nU1?=
 =?us-ascii?Q?NRc8DO67IEUITSB6MHzThkgSTGCzRlyu/wlQhBK4tJ5/xpCEftPh05ROr5WX?=
 =?us-ascii?Q?EZsZJxhBaHbxxxenuPXML1x2+e1sGQsMP2RXrjNv4UkCp1miJi6uktTXHif9?=
 =?us-ascii?Q?ir1KDrgzMagZJ7iKq1EDwG1otuFCfKpVyJW447ZUMwLyME5wn/POYKICTSkK?=
 =?us-ascii?Q?n/uxvoJH+EnYPiXL2nucoPD0zL8oFQ8SCiiNqCC4XV5bbDId6xuNyjbtvbrd?=
 =?us-ascii?Q?hf66wu7GokBsegvIKpbK8tuWflyasgg23YlK1OgCTpY3UcA+x4d+nV4D8vwO?=
 =?us-ascii?Q?fr1cCBPtoWniVACminiySLUxl1vfjV8qi3a2LUgj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd3998c-8212-43d0-70e7-08ddcf320002
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8052.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:26:21.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVruQC1rt+VLwK9WmlwIH/dQA1LmXlNuVURZG8QxRCZ4OdUfel6SI4WDUNA7urfZMT8nCX/mQZXTPOspCDFbjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7292

There are over 700 calls to devm_request_threaded_irq() and more than 1000
calls to devm_request_irq() in the kernel. Currently, most drivers implement
repetitive and inconsistent error handling for these functions:

1. Over 2000 lines of code are dedicated to error messages
2. Analysis shows 519 unique error messages with 323 variants after normalization
3. 186 messages provide no useful debugging information
4. Only a small fraction deliver meaningful error context

As tglx pointed out:
  "It's not a general allocator like kmalloc(). It's specialized and in the
   vast majority of cases failing to request the interrupt causes the device
   probe to fail. So having proper and consistent information why the device
   cannot be used is useful."

This patch implements a standardized error reporting approach[1]:

1. Renames existing functions to __devm_request_threaded_irq() and
   __devm_request_any_context_irq()
2. Creates new devm_request_threaded_irq() and devm_request_any_context_irq()
   that:
   a) Invoke the underscore-prefixed variants
   b) On error, call dev_err_probe() to provide consistent diagnostics

The new error format provides complete debugging context:
  "<device>: error -<errcode>: request_irq(<irq>) <handler> <thread_fn> <devname>"

Example from our QEMU testing:
  test_irq_device: error -EINVAL: request_irq(1001) test_handler [test_irq] test_thread_fn [test_irq] irq-1001-failure

Based on the v7 and v8, standardize coding style without logical change.
https://lore.kernel.org/all/20250728123251.384375-2-panchuang@vivo.com/

[1]https://lore.kernel.org/all/87qzy9tvso.ffs@tglx/

Pan Chuang (1):
  genirq/devres: Add dev_err_probe() in devm_request_threaded_irq() and
    devm_request_any_context_irq()

 kernel/irq/devres.c | 121 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 40 deletions(-)

-- 
2.34.1


