Return-Path: <linux-kernel+bounces-818018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C692B58BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 193CE4E1A32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A58221F1C;
	Tue, 16 Sep 2025 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/Eq7K3Y"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB7545C0B;
	Tue, 16 Sep 2025 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988351; cv=fail; b=MPSqXYAzIRYVcicZ3uZ2XHLCo0fVwbpEnZM/EmIlvzFzUmCYzvSCeff5YbH72X7mQNOJHBk4oLNpfySTgDym9UVVXF7DO+IPfwa6rnWrAehP0rCAh1gyO1v4MtyS87uwYPDRESvp35eErtkx3AvInjz23EFsMXm3mCD/xUEDRJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988351; c=relaxed/simple;
	bh=0qnJzup2nMUX1PjVVfQbVHrNHVLDrxLmsa1B+DhJ6a0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qtjk+kBZRvskRp4KgQnWHkzXr8/LhEuyMXfj2ZzsWp4MSBTlHHv5XxIrCMlOIFPeWYCxYFiWb7ojCbUgcvW4iHwq5bbcwVF8vm4pULqZvmFV8DTS22FTOYenbYsB50tHJLdcW69uAcykEyA+ovUWNpD4Z3CBYMm7QnkGtCD+Rzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/Eq7K3Y; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axTpB4KoBHnSIhmHbC9mfE4bBpf6RGhxswfyPBBi0DJlFLq+m1LDghG6mzJwTOwteeHRlFr+giIiR9g4rFlShH2zNEPGwXpYANfvxHo3b7Bc90D+Vw/0SHr0fpPbaCuGN6zOxh7x2oQ87OgFK4vBxwBEr34x3kUREu/jdRVQ1faDQPZK8ybxq4+XSih8FOMbpHgx0fKsFFTnYbB+HkTtJfIWiFHwf31eLv+iq1D4nO82bREzgd/1+1wqjgf5rAAFQX/BItTkiFvZl5akGFDUlWoe5tHGOuzB1pHdZIwkg9o0wmNkik9LAjVSlm2QFS1g8XhtWAX+OaRyrXPR5RsPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XSE2KorWSDALZPFTv2muB/KZBiGRmqOXr6tWABOyhs=;
 b=kiExC3MP07g9fFHn/2X4/r2A677aKTJ0WzQA4kokpYuu1kfcwMLeKcd8DCKSsMoT+Xf5ZBaTMjY56NNHYLsDdaTbpG2Bzb8Ym12I4Kli9GhZEYGp1kudlV6Dz19ken8zaWt3YmswaccZvSOEq0fW27iFNzEhbR4tEItM4qhopxb05Gx1T7W6R74jy5aoYWJWafjNbziqF0VkW5Bb8q0ud3q+8n5ycbF7Z5IsfDrSxodRgdHIaM2eUwZoritMCnAXxjpmDEtInB3Urd89ZQ1zRgkr8l9w1R2qnKPLUxRv6y6D46QafLHEa58urF0ltUc8kN8vfyNgwuurn1sdzyRrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XSE2KorWSDALZPFTv2muB/KZBiGRmqOXr6tWABOyhs=;
 b=j/Eq7K3YDJArzwz7dB49ZdsNsQPwACam5//EEqypalq94PoDL/qn2Yjp1hBDiq+t1VjFPToEw1AwkkOldjwPSjMbH6qy0CYohT+FvXX3Vn5L15f9u40SLhCadJW7hys0PtN/Xx1tjANK8aln8E9dWFh9UrwtlOORxAzPV2tU9rviEVhzCqyIstZ9xm/WIAuiOS53WqAKG+ANJzusxN6h1FEcQkF7zQdafrB5ZTE1kJ5qzPlhoLxTgsa0EcBYRZLiIVKzuI7EZNyudh5te5ikGLrObHP4ghv5FEM1+w18VhaRAZfqq3x725RY7pu47oc0n/ES7GdHupaNPZB54M29oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB9365.eurprd04.prod.outlook.com (2603:10a6:102:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Tue, 16 Sep
 2025 02:05:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 02:05:45 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	jun.li@nxp.com
Subject: [PATCH v2] usb: gadget: zero: add function wakeup support
Date: Tue, 16 Sep 2025 10:05:44 +0800
Message-Id: <20250916020544.1301866-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA4PR04MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: 01545345-a50e-4edd-9db0-08ddf4c58c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rHmxaxkAZA8HBL2TQxmkW58clnoRcia+QTJ5EiJAQPEVcJEYRayNM9K0Pmv0?=
 =?us-ascii?Q?PNxwk94BR9w3s8Ds20R7ABgvt+vj1mgiP2oSyaFfZJV/k/5omVATepYXLh7B?=
 =?us-ascii?Q?wXzXpSqZInTo//ZhAz0ETHDVzuQe9itJ2iT9eeCH9Nn5CEFAG34PSOM9gHI9?=
 =?us-ascii?Q?+M5YIQwBD8D4U3BMUvf7DB1eyK6kd5XOolqMVUnSU0O49DZqkS1nMJX8GXDS?=
 =?us-ascii?Q?ZKgQ+0u/9sfkqnAMUTetv2b/vzG39nrwXbdHCt7tfqnO7YwTTVOGOJHM1m/+?=
 =?us-ascii?Q?MBhOIH7c8ibV3gRF2Q31wH4DyG4aAyFigA2DoBE0qDtaWuk12ZJN5/hHthgk?=
 =?us-ascii?Q?j0p7xeuSZcBvK0KraWB0DtNkSINPGL5RBe20IpLX+eQanR6rYvQUIFF9jCw+?=
 =?us-ascii?Q?0Z8AYixehbPKqYzMDWyhr7mUvjf8oKHOJgWVLVnL19C0ALtsGbK5MKvL182r?=
 =?us-ascii?Q?mXLSfYKOD8UWmXa/9tSS0FGlCt3Vk5cClvLdtn+jEWJ5SXHXwVhgli5N34Uk?=
 =?us-ascii?Q?Jshnbg1Z/RGiKamH02hWvnq9AzEI7cNZ9gjESF8mwebWOjIF6pQS4HgZEyrr?=
 =?us-ascii?Q?T5BxKM2n7BKBrzz+/zZE1B+fZdhs7TBgm7aYxTYV80Z+VgcWn5MeqfHGSWE8?=
 =?us-ascii?Q?PbkE2t9PkZ0iKKosj1YLzdzeGgrScOQYOdLFiDQJ3KvR19myi4ohog0NAzj7?=
 =?us-ascii?Q?qxwCBLvTHVt2Jf0FUhqARSV8yqKDjWjzq+W+0xwUur69xMO9UZvsXT/AlLrB?=
 =?us-ascii?Q?VR7eEC+48gfVCDpjxKuTBnIPYRZn2RueqX3JEtS8PmKdJ7bPUPT3xywRicl+?=
 =?us-ascii?Q?tKJRpcQgFpebzVTr0Sbv1humMW1PZqc3hi5oJ0N+WlM6qlY8MGLyOFUBHAVB?=
 =?us-ascii?Q?uTz7xnFerxSsLTZh+TY3zZEXFC3cUvfDBOKeaxByZWJsHN2mkvS8MGLv9yVF?=
 =?us-ascii?Q?bNLfCDXG22hFxSIQv9lOfhLi0fIz1m9nPx8XjkikxF5+5h65euGGhczmB/2K?=
 =?us-ascii?Q?sH4twccWFPDVjcKJf1kW6hl/2ryikmfUjQvmD5BMuVtp4ny0MRMGjrbPLXx4?=
 =?us-ascii?Q?p1qpU2xTvUFPgfxtSc4BukWPXMTOgefC5mBtZ0hORp5uMsBqhWfx9jhFXLnq?=
 =?us-ascii?Q?g8gG5cNBvogl2XTYyLqtebO6s+LjI8NPBmdEyedez/Ez8G8/i7D3r8rO3SEw?=
 =?us-ascii?Q?BUXDhJtaomXcj56fujzxwbzsF3z1orPMJSCKzMIMh02zd4mNK7g9XolMKTJ2?=
 =?us-ascii?Q?Npy426sRtBvUAukT0tl3Enz+QoXk+He0QulQLBWiYR4ztwzZG1U96or8wwR4?=
 =?us-ascii?Q?HXvD/cr/zhNhUncwJ0v/3AWpYIH/uYsUA0ZIuZCcSloyFFQrjX/mgIPYoy1v?=
 =?us-ascii?Q?KnX7JbtEnUw2KBfgi58V2pAhoQveEdlgcdV7v+2LdKNsgwBE0+qSUvqxIisJ?=
 =?us-ascii?Q?WILvRe7NDzH9kRFWLwmHA/YoS7VQrjkzkk8lcl3NB5Qmrp1PmA0zDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEDQ8pN+gxoA8VGK03luoo4CbrB2z4qxxAEgEO+g4aQjLdUeTwknQloI8/wB?=
 =?us-ascii?Q?XXJFo9F9Z7rF6alkIAdOU+4uA7EhBVmgBXbbUYUFOcMOoQBovZ45MMMzttP8?=
 =?us-ascii?Q?7cDexUtoHGJI3p/VmSXyI+T94w3/eG0MqinsLXd/fd/HjpWQH+agLrQL9wtK?=
 =?us-ascii?Q?Kj1xNS9sroVkCoAr9FsMght9et16ciNa7nWIBPE5tfzmHI2+zfXRD4Y1XBVK?=
 =?us-ascii?Q?sK+WMg1YO8enp3VLUBSbVabBUuCIPI/xvol7dMFb+RQCAUQW3sIw/KwRm1dM?=
 =?us-ascii?Q?PoP+k1VpUfUY7KvbgIBBfTEnfSzAA4sXKUqiHSNgdXaah//sqDk8Io/AgVq3?=
 =?us-ascii?Q?ulM+ZleNQUFaa7wma7vewFgqDtH1n9r54AlXaKPWuyVOdB9STMQTpma2D88r?=
 =?us-ascii?Q?ZsyKhv1rb6THyft8TJnx6H01IDQYN2QIsx6CCg/DePILLDMSyLipDMFOfRrV?=
 =?us-ascii?Q?NpQ3Ai7PuhzQ+H2FirvZjQRe7cioKvis/yBxOSUmegjro7jscbJBY7nJuctb?=
 =?us-ascii?Q?26348cxrF5nuhI7U81ekfV6Y61LtD9yvZRfQTvjhmFiJV3al1eniRatsWyP0?=
 =?us-ascii?Q?EH/gG2nYKlt8KKnpTwN8FUmCb1lvZ6zl1WMwkowKYSzpyDeV7WSvmSLADvbR?=
 =?us-ascii?Q?iIZOCXI5stGBkAgpLSdmV/gkEVVfB1g1yBv4WBKFjpbQsyymeHDIk0aCCkzr?=
 =?us-ascii?Q?bsDW5rx4ijplCSUJV3CIg3RCkDTAt9GvjtogWCa17Zm/kir+yDZOVlAngDgY?=
 =?us-ascii?Q?VyfdhtyshV5VdVAW5eMtd3xKI9EnudDKFeqqNAlyzoAXa1Kgzez40MtPfeSA?=
 =?us-ascii?Q?o7Bb9Z+HMwQ3qC8DyG+/+sofSbjjjS0g3EDPvf1Px6uw05chNM8PnPbTmxQB?=
 =?us-ascii?Q?tFlUiQGQC/aFF/fW+jGLaaXClWHowvaWECMEoVwzNMB5aAFBNDDqoAvs+6nU?=
 =?us-ascii?Q?i5ORFj+K41APTMZ/b7GTtYuMG+ac9aMN5GCvyJDh0xwWOQKiO/9uGwJjqBbN?=
 =?us-ascii?Q?kZ6edkDcT4aDldMixaqrNSz8GUgejFRalFwRNrJVJWDOmF2/4WJwfexHnOur?=
 =?us-ascii?Q?gXRja2v1JOuFcFJESCfv3z5EEW9y0eM5O5jIZcjxtZs2u6tvQy8p9/KG/JiQ?=
 =?us-ascii?Q?d8KWRCkZEx/+q/ZCXNG02RO1SHeEuhTpSfA13a7SN9kvQgQfFAXhES8T2Jgu?=
 =?us-ascii?Q?c9plcIWaUktWdTp/X5uqk+gYd+vMJL58+OtCrDhdtG3JKXajF//APYrcjJBx?=
 =?us-ascii?Q?jUFziHCaYfwy8Kh3QloZ2LvGd1EOS72VejnJtn4oyMzKXECSuVtRgwmXckJ8?=
 =?us-ascii?Q?YNIU1f+hh7EojfbFeOkIHfMsTI+Qkp4Xo1OFE/N1GhPNI6D05nS7GkpIOeXw?=
 =?us-ascii?Q?efIqhB1DHti/D3vNgH02Kd7zuH+0YLowiOQbXQq+esW7Fc46ECgjAgM5NzNX?=
 =?us-ascii?Q?GCGGtRfby3BbGT/AkCrY7M7uNa3H8N/mzkZYB9zZ2PvczGwiNF0RP9QvntvU?=
 =?us-ascii?Q?JCoVhpaeqFSIfCj0wsYJJRLUk1u2kJQaV6Q59dUihdWw32oRzE7Ic8DN7MFz?=
 =?us-ascii?Q?5l6fxl3/tVhiHTeWBkE2tOAi0waCaIzvRLTgqqzm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01545345-a50e-4edd-9db0-08ddf4c58c3f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 02:05:45.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpJACQd/lbzIFXoi9F4A4+EMpTaTEAm6KU11GmjAaRvf1ZXTPF8AeT4MfmvufON0te4xBj9zZCFqldtBMfWPgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9365

When the device working at enhanced superspeed, it needs to send function
remote wakeup signal to the host instead of device remote wakeup. Add
function wakeup support for the purpose.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix alignment
---
 drivers/usb/gadget/legacy/zero.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
index a05785bdeb30..08a21bd0c2ba 100644
--- a/drivers/usb/gadget/legacy/zero.c
+++ b/drivers/usb/gadget/legacy/zero.c
@@ -147,6 +147,12 @@ static struct usb_gadget_strings *dev_strings[] = {
 	NULL,
 };
 
+static struct usb_function *func_lb;
+static struct usb_function_instance *func_inst_lb;
+
+static struct usb_function *func_ss;
+static struct usb_function_instance *func_inst_ss;
+
 /*-------------------------------------------------------------------------*/
 
 static struct timer_list	autoresume_timer;
@@ -156,6 +162,7 @@ static void zero_autoresume(struct timer_list *unused)
 {
 	struct usb_composite_dev	*cdev = autoresume_cdev;
 	struct usb_gadget		*g = cdev->gadget;
+	int				status;
 
 	/* unconfigured devices can't issue wakeups */
 	if (!cdev->config)
@@ -165,10 +172,18 @@ static void zero_autoresume(struct timer_list *unused)
 	 * more significant than just a timer firing; likely
 	 * because of some direct user request.
 	 */
-	if (g->speed != USB_SPEED_UNKNOWN) {
-		int status = usb_gadget_wakeup(g);
-		INFO(cdev, "%s --> %d\n", __func__, status);
+	if (g->speed == USB_SPEED_UNKNOWN)
+		return;
+
+	if (g->speed >= USB_SPEED_SUPER) {
+		if (loopdefault)
+			status = usb_func_wakeup(func_lb);
+		else
+			status = usb_func_wakeup(func_ss);
+	} else {
+		status = usb_gadget_wakeup(g);
 	}
+	INFO(cdev, "%s --> %d\n", __func__, status);
 }
 
 static void zero_suspend(struct usb_composite_dev *cdev)
@@ -206,9 +221,6 @@ static struct usb_configuration loopback_driver = {
 	/* .iConfiguration = DYNAMIC */
 };
 
-static struct usb_function *func_ss;
-static struct usb_function_instance *func_inst_ss;
-
 static int ss_config_setup(struct usb_configuration *c,
 		const struct usb_ctrlrequest *ctrl)
 {
@@ -248,9 +260,6 @@ module_param_named(isoc_maxburst, gzero_options.isoc_maxburst, uint,
 		S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(isoc_maxburst, "0 - 15 (ss only)");
 
-static struct usb_function *func_lb;
-static struct usb_function_instance *func_inst_lb;
-
 module_param_named(qlen, gzero_options.qlen, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(qlen, "depth of loopback queue");
 
-- 
2.34.1


