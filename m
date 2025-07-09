Return-Path: <linux-kernel+bounces-723585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DEEAFE8D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B068D171516
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246B2DAFBA;
	Wed,  9 Jul 2025 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DW5N6x4f"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012008.outbound.protection.outlook.com [52.101.71.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565D2D9EEF;
	Wed,  9 Jul 2025 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063875; cv=fail; b=cgVRAtrwCoTpPAlszTCabJYyOpo7/3wzVeEsqqV/6o+B2LnWcJvff9KL8hYssCnL+ibQ48ifxGlQc8sm6yoW0AuIY80FzzZ09Z8NRt07q7A7nXSyHzK3wbJajXWzKVcerhJDrWjef+OD+PnZNFF9dI9bmC7uRYQFAyYOSYcRRfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063875; c=relaxed/simple;
	bh=kSA92/cEp3p7EmfhmExDvVOkBbDWmNrSeJi7UmqKTNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AP5McipWOus0VbS/3GkUGccNiwssOEzy7aJeJ69HSnlpAYT0Zv2FcG/+fdsw37RGvMcHxZWvtvljIj6RaNMrxqoZtdQvJ7iopYypxi31RUjQjs486UTjUz8md5/cuUCO7B6qnqDF+v9j8o60yl8RES0+Ns3EcUrpZ046+QzdgJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DW5N6x4f; arc=fail smtp.client-ip=52.101.71.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnUARo60/ucrDHRIwZ1xh1elKxzkf608tfXHhrAOQ/8yAP6zuuD/2v6I4fr0clsxBAlGFOvlLlU3gczewP3/FyYwBv9qcXNUWj7O5avwtwYB//qcvyYujN5Ai24N/qU9t6lW/lZ9dXj6wSmMaxb5/8ziG9ZUEIFGkA3EYzc2X3drAgS+dYR3tBeijMlnV319Ml8Uf9edFSU066O+qjRZhMkoeBBc8hkMyUvVO5GO0wabmOTQVbhM/E+oDKEQjKYmnMQzOmAOdOPod2+e9KL2kFGzd0RigqQ58VBWvH2C+M8VF/dQ5tjpw8+0HV2kz3iJPoFGVhvFwvgZBHoTPgusXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKylqW7wEZpSWqMVXawmUHI2JdIi9S7i0zK0e4q71TY=;
 b=KwwW0WDMKOyTALG/zO0Rq0NuEA0QjVyaHYkkZ94QG5+xWZWNf4HWgRee29Ek/rzhQobI6NKJlm9Cbpw0VKKgJ7BLDSPO3gn9PhIGJYFs3W+sbFBL9ZPkrru5uqB8G5mkorel4kQ+C0qjhjevNpn+PCZ2SFopbLeCtTeD2amxd0mre84ATc3UXjyIYN1p+cHjgG5QdDaIBT/QBfmcNG1j+xY4teAS0st8d9yQV3rAa8khujxAsgZt6qtAEw23RMxm5OxZ5EIhzjf+snrPRYWRT9RzOxFbu4mM0i9fk4F2ZDOm+shgTKvSsYvUdeb41vwyUql/YC1CFOj2jj7vvHU/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKylqW7wEZpSWqMVXawmUHI2JdIi9S7i0zK0e4q71TY=;
 b=DW5N6x4fS1GQZAXGfIsbu48vkiiMwMxhW9rKfli3x8nKgUEej9YEdw5Mj12K/jszyoJwrXeRozZM/a2n6nW/8ZaLIStSj57gNMWAIWZPR6BlWOJ2l0NzegV2kSGd9n1JDDdMqzJKDrPnStoBQ6gZ0DT/lT30yoH4FVbVzrCTshT6lRUcw/samrRnaF3K3HCKFMnp2GpbkOH2BQ/jj7wIIEQjAPRt9IYWhzpMQbFjbhJ0JUmp7N0akJTplPpNC6QIBCMOXsK5UOkULH2CtUQaKNuvFT4ZcVjzeS/yg66q8emE2JNvkFBq8m6XuwIjBwn6RrGNrCbfeYsyvYACC1YNjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12)
 by AS5PR04MB9853.eurprd04.prod.outlook.com (2603:10a6:20b:672::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 12:24:29 +0000
Received: from AS4PR04MB9576.eurprd04.prod.outlook.com
 ([fe80::9cf2:8eae:c3d1:2f30]) by AS4PR04MB9576.eurprd04.prod.outlook.com
 ([fe80::9cf2:8eae:c3d1:2f30%4]) with mapi id 15.20.8901.021; Wed, 9 Jul 2025
 12:24:29 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] dt-bindings: display: fsl,ldb: Add binding for i.MX94
Date: Wed,  9 Jul 2025 15:23:21 +0300
Message-Id: <20250709122332.2874632-3-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com>
References: <20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To AS4PR04MB9576.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9576:EE_|AS5PR04MB9853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3513a360-a95f-4519-d6e5-08ddbee38d5b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?NPhLXXCjdfoKbD4RMmMX+Gk+okQfx1kplayWZRr4+s5aOB+vV6BbWKVK6psd?=
 =?us-ascii?Q?FbTlJEXppnxNdrkJy8iapxVUPX00DEEL7LH1Kafx5h2zPTJFhp0HUuo3FRAV?=
 =?us-ascii?Q?8/cfvj8rSd5SAnPWe05P5dtkIR38Ht4Scytuq4WehQK8arPmulc1N7QhSDOv?=
 =?us-ascii?Q?pTsDTir/dn5tBCXYr55WbS3x5HpPc0TVlOKjMmYc7PAonFklfV6gvDtpGPr2?=
 =?us-ascii?Q?sDDa238V4PAN4lcP7qN5GYPlGR/WFV4Gwj2GBsmUHiKzA/NtRVCyc+W8mRey?=
 =?us-ascii?Q?P8REIrPY9LyosO/rqBG1PU8vLqnPD8afM9vjhlS8d+gqBMHDmVYJr3ph8+Vw?=
 =?us-ascii?Q?EgminGmtJwHXRKclCxGN37kBLLlAv1tcjiDNrxzm0KaDUsKDlsInHuiF/7Vo?=
 =?us-ascii?Q?0LAW5qF5T4afy0u/YT6UackqB0Ncziz1kEu/MkP9VEKHQY3xqhIcXV3c/n58?=
 =?us-ascii?Q?vGriLdBod2AVga7hjJywAO4KlnOamgEJbBpeTAOaibbBIPTPtJB0MbQ1aHWw?=
 =?us-ascii?Q?97MhafnRGq7mAzkKYdQC0h1wkvVXzpJKwV4Bgfs6bgQdoNnCjbJavpR45Y4W?=
 =?us-ascii?Q?VJl0gBy7cvxdWm/lU4jGGpnvB5+HQHQi8reKWpAI/kCAUGocdCj4TX26wFem?=
 =?us-ascii?Q?Y9n11Kz9AvSoin5WjN+Y1NDPeQ/mwjYODLHbRNsTujs3+gZPat1MpW4L2yKg?=
 =?us-ascii?Q?pS3bZo5fxAp+IaU9aN+nG5Wvr8h77y8KxnO15+U8AGUclyqYv/4vvZls9nhC?=
 =?us-ascii?Q?0gHwqnvmfrpjUcmWyBVXE3YwTnoF3TqVoK3Wv/tKaJVQfasNvu9Q2EYT68aw?=
 =?us-ascii?Q?ZsqYWw+mflzIUEmn0UsnWW4PbNW/XPyRprmroxS1KlKEYAbTJkRekdUCd6On?=
 =?us-ascii?Q?m/1Zi7GpdVACVyPvjhWU2Gix8601dB4WTqte41pwe/c6tnJt4eiSZgdIH4zo?=
 =?us-ascii?Q?KS1646uv4FPo04HQikf5kgctuOsJgCyS2KO4tkQwyQ1YCMy7GR5O5iqqqNPf?=
 =?us-ascii?Q?2YHt72oU6Qz30sDaMu5Oq+qMGoPPBhbiEFaR8/pf+A28k7kQbNoSM7T1dMMR?=
 =?us-ascii?Q?4fUWgeyLhtrr1kgtM0NWPjha+O/ITkH1FYIngCohab2jTwU8p9znxaNBejov?=
 =?us-ascii?Q?qJibRRCfApjYcm+lMgUbYZ/m0rHUuOERXrbuEa+eqYvZ4wv5QW3b2T2lt4xZ?=
 =?us-ascii?Q?00dQ/AUoHfBs5qJ1DM94X93OhHpsO0DIKCkIbtW2N4hnlmcbtnhfjvF7xh9c?=
 =?us-ascii?Q?pzFU774YMReF6shpDPe3ypbcxy6V+Rl0q27vfgYuiOQUnxpiK4OCznN9SRI+?=
 =?us-ascii?Q?LO1sDK7gWfJwjlZtNgxMd/rH9uYPetXJpm5CvRWp0/uUxYwsBWoL9Hof8kBn?=
 =?us-ascii?Q?ef6YE8Z/+qn6UDN1EqyaLcsoJDLCrWFyWnjGJFwUULMXILfQ1fYUme4/kqA4?=
 =?us-ascii?Q?5wbc3F92pFXkVIR3K8jM9eU7PZ60KZaSQx8b6F75MQPHYw7FIKZR8Q=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9576.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?wvCi8q+2Z1ogNoHQZueRTWTs0Eb81i688U/QbGRGAPfCc7QQOKqaYIgUfYoF?=
 =?us-ascii?Q?b17jWt5QLG7vxzW4xSkPlHoeAB5fDsazkLixjXeW3FQQnlrMxusBJtEqI6gt?=
 =?us-ascii?Q?cEQZxtXtY43VAGVq6PeKbYmvQxg0FCd82Qt1cBGARKNPFDd1DvQCEWy78B/y?=
 =?us-ascii?Q?amOytVNyak8/GmlsYajbeqDi7S5IByI5w14fn/TPRwGab+XwL6CXwX5efCgL?=
 =?us-ascii?Q?LmgxeX9aPS4UNf/1qeUYqycVB6SAOt8LZzPXAO+gy7FwwSfAvB2BwO2ivP/1?=
 =?us-ascii?Q?fwoyJhAqRD7TNehwJrIF/hTzjpA625VcXyjWS8a3IZEk9CAHXAsGt6NmNliK?=
 =?us-ascii?Q?QWGpupAG0361mZrCkMQVArUa03h1rapdDqK7qJGsApSkN7p2lMcOWHQx39q4?=
 =?us-ascii?Q?DQOgwkBQ5P04CSo2gJe1gTYVyNHksRCOSNDqIIPO0HGyyymnWE1aLSnvdUbV?=
 =?us-ascii?Q?NjmOsXzWZZT2x6qLDm+P5UuqhyiifHN60v2he/qJo1FPC09hX/76lRVJ6Rni?=
 =?us-ascii?Q?AcNzGCvv4jaM1FfrZAdfPSa2Iz6MHut0BAoHxDgThXIF/56BxDUY+oKaeQ47?=
 =?us-ascii?Q?AzlnH0I3i9L3JGMZyI6G3SAlRLEYQBpDjCToS+Px04SQY8qDIU5al+xflLWP?=
 =?us-ascii?Q?AHXDmfToYKGkfT+x5zK2AicvOsLT0AHg00FSTlwa+BON04McflRmGsZ/MN3S?=
 =?us-ascii?Q?CKCocPbCUC4yBtBf9YIHynLEIajN/jOtxE3HfiD7B3n5/S16GUOdXVrbkpfK?=
 =?us-ascii?Q?G6kg4UhRVOz9bh0KLOcfQsSlNw8h9juf0z+5/ELTspOoofbdg2u6+QpPlgWg?=
 =?us-ascii?Q?/DI/LUvqSlyg0CdBNNbt+nmqRKGWLJIQmM8yInTJmSW6H4U3x1qENgEag/Pt?=
 =?us-ascii?Q?YOrRceQ38u7D2g3+ZFcNeTB+4gZkQ9CckA/sQr5qOGd5hohQ+lu5fNzBQjRv?=
 =?us-ascii?Q?S4XMIFR6AnVERpCx2voHnJmjxP0zg3tj0cCtgNYvvVgbxL3LV7DvpSDIbCJs?=
 =?us-ascii?Q?OvmAq764m+MntBJVx9hrbkOn2snSwdfHBmm6/E4LuoCuRFZGO7/qCcr/A1id?=
 =?us-ascii?Q?W1dYA0ApBcA8rJGzoeOrsSHm3IZ/wSlK0V9WmVtzQI1scG6zrKmbmGTkueTj?=
 =?us-ascii?Q?YKMUn2L8qV01Yi+ecP3Z9ox0Qnu72HOYVigzN67mxUz3uGqxhLyX2AWsXc7c?=
 =?us-ascii?Q?0qpVVFD8B5eqRPmnlADEGwzXRC64EVTG4OVrm/J6RrmOWENJYTmW0xCzwDWf?=
 =?us-ascii?Q?GxDzEtyz/Nnk789aNlum6QuKqmjvMqQFrpPVbfJqJbMx8gA4SN89neIjfpYe?=
 =?us-ascii?Q?0DLY21QDinx/JOkfs2k+oVdGJo/WCRpt/2CmTNkGTWQSu8Xhpui9uPzLPLBk?=
 =?us-ascii?Q?f6tjNBs4njC8QF/WIhuIoA5re3Xsu5w4V07UxVLzrL5t3LIJ9mcJHitoX4xC?=
 =?us-ascii?Q?9dxU3LGPQH3hHGj4/y4G7zE6hJru8zpuIrlFI94aKPRNJakCjoQUDizfm5Td?=
 =?us-ascii?Q?2G26QjjCYpN5WPk5AM/FjYIBYL8vpCiGjseoTEbzXOQtQOVKo2PGRYt3rq3Z?=
 =?us-ascii?Q?9p4sA8DgDfklhyUGZg4pTKa4vQSIbOSQo/mTOjZJMBh3m9fewQuo6rWPxvad?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3513a360-a95f-4519-d6e5-08ddbee38d5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9576.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:24:29.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D89ZthOeVPycliYPlHTbPv7N8whIKyHZMNrcZYr0OcevwFLkszXaKFcEvgEHnAY+EQfgD70rUkQzsiRPMU3jmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9853

i.MX94 LDB controller is compatible with i.MX93.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
index 07388bf2b90df..a54b8f1478049 100644
--- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
@@ -20,6 +20,7 @@ properties:
       - fsl,imx6sx-ldb
       - fsl,imx8mp-ldb
       - fsl,imx93-ldb
+      - fsl,imx94-ldb
 
   clocks:
     maxItems: 1
@@ -68,6 +69,7 @@ allOf:
             enum:
               - fsl,imx6sx-ldb
               - fsl,imx93-ldb
+              - fsl,imx94-ldb
     then:
       properties:
         ports:
-- 
2.46.1


