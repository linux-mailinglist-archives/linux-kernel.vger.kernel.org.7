Return-Path: <linux-kernel+bounces-885937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3489AC3452D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF84258A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE02D5938;
	Wed,  5 Nov 2025 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HIj8BbHJ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75C2C3242;
	Wed,  5 Nov 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762328673; cv=fail; b=FGkevHdTRhhl9dtDATQODbOxo1pMI0c52Ln0kqgItB8uh0x8cB/Hh+BjQeZ9zz+15OM9uuvP2NwuZ0ovffbjFokcpSv/mmwImGKJRxjquAu/Rg4JoEi/NLcqX/W5qD+A5AV1EnIxtQegXxszx7S6V+yuY5RVEUNBuD7F2045pTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762328673; c=relaxed/simple;
	bh=3dpELXrDtYNhy99AfI0kMkbitI01sBeFsJJ+iDGHQTI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q1xlNjl0a9IR3P8RNcdoYdJvzacyNflux5omUmSJRPd3gS8KV13nqrkWmlljWaUXrkh0jqrEjIBr4tuGCb8AWbZC1EO9P94iryIwnXl6xooXK9iik5s87GzNzT2LSmlbu5PYHyyoM8qQYnIWxmDVTSuJQAyEvIzZGOPno/eRF1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HIj8BbHJ; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxWnHlTeMKIETc8GYijNLZnO4OCj5p+6W9bi31WMwHGvwcB9phySFWsZd5Sw5nsq6lozfEY0VHr+2a9mMznY8rKE6rKX0i9mWzzCkD51b102Hj7j6GT2Qq6YLuAUA6R1ZriEtWZf9vN7hNVGj3D6kLfexaRy2YfmLROPadUauwfn1pB/KT2UuGya8Mwz4/UhBn19pNrMedp0/eSsvbDTO0jxDPryWZvlrVRkBnvpOxI5dWjVq900QbEmPP+MImLYeGKqaRlfCPgzRyUudmDf4K0tAPO5Paw9iCgnsfpD5ZNadR00jstAqwDxx0kuOxQm9mr0/haDC2M25MJxK0XqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKtNmqLCBWgUOT8P0ViiBEfH9qACi9wouaL9G2KgbMk=;
 b=uz8toArUoBLmgu9E+qP33jApxlpUb0OfOryK/t3dJYhJ5N74EMaFlU9A6wdMOSO+Pg8lIaSte6bjZAJTKgwAlZPTozilCzAMFWhtE/vLn0LTds4zlwvIxcI7OyDcVYxkcdwGA4E+E8ajmIoh1X3w48w+g84IqX1rKku5rdpCsmpjTttxWiRUw3iwztBA/yHC/Q+Pk6bvxhKL7x74JgFVmqfRBWpDSqPYwmIXxafK7QH2Nx+tYzLcdlIMybRwE473daG8zwaJGxv0WApbSG3spTNU6DC4ybv7E2Io4gZrz+94pNbdo71GxTmQc0pqZoPJtF3mbd8oM/UJqClJkM1aNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKtNmqLCBWgUOT8P0ViiBEfH9qACi9wouaL9G2KgbMk=;
 b=HIj8BbHJ4afCGCaJNeq8+/Mv4gRY00vDWPuq6oOO0ZX5QzMRNUTgE1UO0fMd7Igg2bFbLG8zDr8Rn9K5V+oOl+lIA0ds1lUw4ZPTmnTveHIS0POWYv8s+ZBJ7jCWwUCUTCpmNrw1ez4QUZnQXFwd1Yj/fqCSZGWaVrSzwdn59elbqNZfwqR4C4gF7sr6BuCGmwXAMs5wCnltutArA0y7Q3HH4ixYpUJNZp3kuBQZUn21UGdbL75lvaXeO9bssiwWHcrI7tLHm6BPsfQXrCjgLOADFlygdvqzegpeWNoGv5CIj8or56DUEJr8vfIKk+rviQRy0qMoxr6cL9zHMcKUmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DU4PR04MB11079.eurprd04.prod.outlook.com (2603:10a6:10:589::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 07:44:27 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 07:44:27 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	jun.li@nxp.com
Subject: [PATCH 1/2] usb: dwc3: drd: extend dwc3_pre_set_role() to extcon and otg usecase
Date: Wed,  5 Nov 2025 15:45:02 +0800
Message-Id: <20251105074504.1427926-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DU4PR04MB11079:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bc9469-bde1-4799-d475-08de1c3f25b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZT8LXzmO+1fhDEp9hrdijMSOt6b9Ldse7Q788Sefj3Zwsa6xXR16tQfEdxT?=
 =?us-ascii?Q?mKs2p0PR76wMxMYbt/Sz8ocXk6ZkuqNNqUZ0pIXkUTOnzVyfYPP8HeMWSHUw?=
 =?us-ascii?Q?a116E+op9/WVg1/k57E5lMy09/AY9EnfqtPLWY3jSDtUh/Lt0X0iY0sPkHDO?=
 =?us-ascii?Q?1unUBFJoagQsNmK0Wfoozsdq16dyJZSNnI6Bt2HbupvpF7J911MjJG3GGFUt?=
 =?us-ascii?Q?79Wz97D/ATw4zOcNHEdJ8tdo2yxGp46EuRMjHPMWUqxQJf6mQy94Kl4fgSNq?=
 =?us-ascii?Q?7URhjZIjUZHUPz7qlRYwwz8MaxhCjeITFDDPtsbo07sbfVznIB+HK9uWBQUU?=
 =?us-ascii?Q?iNqP3I3L5Bt+xNUK5ZjWJXttkpp3/VJhXbN+PnW2spGSkex/nD8xnRR1ie8N?=
 =?us-ascii?Q?BCu664KNUN0SVizjT4M5H+l3OOSSbIxwyNgYs/OSqWt8cFmrpNivR0jTqUnb?=
 =?us-ascii?Q?wq5TXL3rcSmp0vDDFSrV8AyIQibIHlqIvj4krfr/INiZsQqZUccG02cQT4j0?=
 =?us-ascii?Q?SPsO05vrjEmrPsOBMWsZ4iFeNNVgDi5WYqyCUzgBsTEjuAZ11HM221Qk5M6+?=
 =?us-ascii?Q?KGihf4dFuxmf3UhftvDnC9Oc6ogznU+ZSUUHeWDbXo100U6wTzzPpQzuOJzg?=
 =?us-ascii?Q?NsQo5waNun+KjKH2fmcBdmk4F7a52fv/o+gWDqUDvsQQE1z8N/Z2jbOTH+WR?=
 =?us-ascii?Q?BseUTdoUj2u59Lb0ZCvJ8iug7It/0B1fmDPA7Ceo1H/76JxJU2s2k8sEfqVe?=
 =?us-ascii?Q?0OGWfQ5pUxAC5sHVlwFFGyN1YmQYAJSNuSsmK9l1OdQeeJUM9YrAwHUdcXB6?=
 =?us-ascii?Q?h5H1bL9UqzkMdVDqVdFzAUbYfWarKLWMNYdM+LRJY56eaR/xekNFMyoIk7hY?=
 =?us-ascii?Q?yABX0i3onHBV8Vp06S9fClAsEipesPW3CWWgqwGi3LX5F0FbkpGskxt13xEx?=
 =?us-ascii?Q?03ut26sVpprA23vltI2kz508LqcCu3TwDmOCp/Adi0466mjaFLp4znJwPlaz?=
 =?us-ascii?Q?IBWFYqCniJrBXJL6zeDYaIQH289Dz/+yP4ycLsxFlvQIwsec1ad5mfdlrAIk?=
 =?us-ascii?Q?eBxf0G7h/FJ0LMQ4qpKc5qqVbb7+tFB1cL9SWXr9+eVaC95ycVKEuGChyU5K?=
 =?us-ascii?Q?qMOsbGA8RCFZ6D88guTd7EokCVNy9p2Yv2K/YOLyNa+rzGOhtKXERefF7a3b?=
 =?us-ascii?Q?PFW77+0vWCByO9ntUY8mg3pETByDYgR9gyVYaaTrznvdKE00xM1brXTwD5oO?=
 =?us-ascii?Q?veYoGT84LzBK1o18ONFSOtQF43ZcozUwariD15ZS7jz7SQqUpKy/CJjYE5iB?=
 =?us-ascii?Q?4REXVz/7GBqS07IRCJbsivQxLzb/5k/DIZCkqRks2XXcyRac3pCgLko4KQDA?=
 =?us-ascii?Q?5Jxt7gL2w0dFiEddkQS4r+q1rcb0IzPYAMpfwN5KRyuImB5/wjnzZ2v2l5aY?=
 =?us-ascii?Q?BdeeKg+08VQw3uaSDTt9Tlvvhgpmi2MvtNZ6Dyh3Z4inETKZOB6UWTq1BHHL?=
 =?us-ascii?Q?FDhpN6z8dKHqJoaSqDjla3GccPQZYIbEWe2N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pyAiA6DomQtzn38RXzFi2LXpsCdUg+u34PMLEoLVXtsc3bZZmRQcOacYxnuo?=
 =?us-ascii?Q?B+3HGreawlbLtS83j1Tqqevi1gM2uNqFCIWYv9vp2p/XrnyK0eG9qIr2rMVg?=
 =?us-ascii?Q?F8qSom9tdI9xDi0sIq/yYZXkTn29qJwfiiJkxmRjoUexUrzVSKTV6zb/uJMu?=
 =?us-ascii?Q?fPE6mzHADhHDCl56TTMuXdtVsPk13W2coAHyJJrbhVviSKftmXTdXLKger1B?=
 =?us-ascii?Q?hILyPzg9i5xcY59gAjrjrPZqpHvB/9kHdPbBso56cgskWqokbqizlny9JZbY?=
 =?us-ascii?Q?xiwboHIu1SdMH2/wpYk0wuBMAKxUL+VsBoZzX/9GaY8saAv07v21TZBEZ1Mq?=
 =?us-ascii?Q?m5yW6O7wTl0Pk0hOlYPwZIKFkWrP/yZSxSuvuYxl0yGU6XnK6aq95jZscpYZ?=
 =?us-ascii?Q?bkxm++nqktc/+JuvJskNnQc1n+2KH/hLlbVVqf8AicFWSlUEjdg3Wo5hCvSt?=
 =?us-ascii?Q?neLf+GjudYk+3T4Odd+JfgYUFIGvSyRYxbLb7WphXKwnD6RVcpn4NNDQ9GtE?=
 =?us-ascii?Q?tDZTsIoqELrov8Wly3GsooiPWzaTpMdCEV+db3Hp9tcnUk/KRNCrlkjxF4Iy?=
 =?us-ascii?Q?NDDhkpgoCslML5a11XVCsLrWw4RO4V1kgfEGI/09B+aiwSe//aTg8GREi2/b?=
 =?us-ascii?Q?S7OCRDy+jOAY0Zs2s9qqTBpqPB7qC/kQ7zlfcl6h927ncjwTnQWojELeoSn7?=
 =?us-ascii?Q?vw9UqqBNoAAVwTL/gzlWcIRQ9Pw4lCvSMf1jQ+UoxruJHrdHL7zVqhrIBuOc?=
 =?us-ascii?Q?les0nrBxHBFT9A+7qrMf6SbcDYs4bllgg6xWhnkLJIEw3Ex8S49kfqTkdpFV?=
 =?us-ascii?Q?tSpBSdEpUvhCX/NoMsSWm8DEUQjC13h53ghCR8NqpzjuqYJ0zR4eyJRWDxqK?=
 =?us-ascii?Q?lDZ4kkoisKPtsbJ8G0yo7v42ywcRPo0WTo64fdlLYxdxFxRAusIm0HW3Jbhx?=
 =?us-ascii?Q?mBWQNdp8jT4rlQuMyBduXKXULoAoAUqSESB2a71doe9Cg//sQUBr6EDmJaet?=
 =?us-ascii?Q?OOlmWhuJVtXAYe0rg2mj+s+3KSw4uZIlSmQJ7Wkp4/HuJh09POB5+QeKJI9S?=
 =?us-ascii?Q?1KkUzjarlniOqz2GLHK0IjmmPaCjKNaUtzjLyL8Lc3egUIqyo2LMcGPValWN?=
 =?us-ascii?Q?LyRQkzA72xm74MsfBV/IexhJEdlU6Pft43wDwsNyQmzddk/ZgnOAo3ODhN7V?=
 =?us-ascii?Q?PM1xA49JgfMX5Rb0j8MnQdAPPB6JbvrsVrOnaNU4m+yG4FDjKgVO3S6Wir7W?=
 =?us-ascii?Q?Wz2ynkH3BL2vTwwmTsskiy4qfdCZkrmsdbgiRoDuCOvhX1tE6lSzajNQEw0r?=
 =?us-ascii?Q?WzZvkLUkl84ii/NtTg/yPPDpvbF8zo3jYO4MSGzLZFeADEgJRU8LlpJQrhNP?=
 =?us-ascii?Q?YD5IyZC/wvZSxRmRDyNwiNILLwaeu1SVAb6sbVxT9TeR4eALmsXC5NcjYRLE?=
 =?us-ascii?Q?2nQTYKnGOz2kUqr/Z7/u0NM7aelbcSnZEu1e3E0/XRFBvN0cGjiRKgoPiWdA?=
 =?us-ascii?Q?TNqAiPuCd0lAzBlJtMXoHvUpQL5Cs/p5DW6luhfLDleHJqGyeB5AHjVu428i?=
 =?us-ascii?Q?OYcn7rVa2Xg05PCZDn7um3BNQ2ZwxySpeNQRWLCZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bc9469-bde1-4799-d475-08de1c3f25b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 07:44:27.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uG3qJiwGXe74A+7RpGR4YctedOWQEsQA5bsIwgpkFP+6dnjxxErKqqyKlWpZrotTU6eEVRuMVHs9XgW1jWhIdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11079

Extend dwc3_pre_set_role() to extcon and otg usecase, so that the glue
driver can do proper action in case of role changes.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/dwc3/drd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 589bbeb27454..031cfd12300a 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -381,6 +381,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		dwc3_otgregs_init(dwc);
 		dwc3_otg_host_init(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_pre_set_role(dwc, USB_ROLE_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
@@ -406,6 +407,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
 		if (dwc->usb2_generic_phy[0])
 			phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		dwc3_pre_set_role(dwc, USB_ROLE_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
 			dev_err(dwc->dev, "failed to initialize peripheral\n");
@@ -433,10 +435,12 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 			     unsigned long event, void *ptr)
 {
 	struct dwc3 *dwc = container_of(nb, struct dwc3, edev_nb);
+	u32 mode = event ? DWC3_GCTL_PRTCAP_HOST : DWC3_GCTL_PRTCAP_DEVICE;
+	enum usb_role role = mode == DWC3_GCTL_PRTCAP_HOST ?
+				     USB_ROLE_HOST : USB_ROLE_DEVICE;
 
-	dwc3_set_mode(dwc, event ?
-		      DWC3_GCTL_PRTCAP_HOST :
-		      DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_pre_set_role(dwc, role);
+	dwc3_set_mode(dwc, mode);
 
 	return NOTIFY_DONE;
 }
-- 
2.34.1


