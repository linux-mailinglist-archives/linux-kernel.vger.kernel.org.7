Return-Path: <linux-kernel+bounces-892453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822EC45201
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69964E6F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89167227B9F;
	Mon, 10 Nov 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iKPHRItZ"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3202E9737;
	Mon, 10 Nov 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757431; cv=fail; b=WHui7oW8R6Z6oqU7GPIBwb3YDeV5LIAQd1jv1QleRJhsEM4P4tv1UILekpRcl7ya0I/e2JdDk2EYRszwJCTL+N4PGqWOeiVh0SncSF4b+Xd2DNc2cVuoTJE2w8gBkXxqv9VlsS0hDi7sg8EZa0OvnYqmp16XUhJrL9SA0yt1etw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757431; c=relaxed/simple;
	bh=nsrHgfOJ2E0c7x+s/PiWwLqglJBjY9D9cF5HRjRcQHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tzP7gNelUystK4RS4aKh4T0ml9eqecKbSETP7cjIwOJq9ywX+yiusncD69yFusPW3cB5ojM51h7wGJjrnc/avqJZeYLiDMn5AFQgzRKSm2LNtkX5QFFrCSNs0JNdXCdHFlPEu3+ZrIELHww9H8uKEopMOKPAngJYPYmaMzCC37E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iKPHRItZ; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRHIX4HRhMOAtnPuST7kN8e5weTG9MqbdFwQTVdiMSNGCLMk7W06kc4XCBxGSh06hZ+56OUU6FC0cK5L10IhlLn7Ho2lTGJk6vNhYWsY97yBAMR7utd7BdKX+4jGXcyozCIDyfayERr50IYEr5cUvDolCMKmH3NYbLzgmv5e2qnvD87GpSrH9cIqP9jvMqBd7pQBI+CtHVLQXKtJzSdJRybWYX4B6pCS9b2d4n5AkQtLf8uCKSizstr/ehLpIj6ADIJns5C8pGImybn5iSDV8bh1OauRiJhJzL2AF14EbmxRGP/l6jip8T38y7jk+npqRji2bO1PjlVqNPp5GbOOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neaE+Nidqy+1bB0syCgVxza8a0guh6SaAPyMyljQ/O0=;
 b=ZBqlAyl9MyDk+n1AdyUGLIe3TDVZ3H0HTEm0Zr1kEL8XqkreveMtVvE6uld3c5naz3beby6Mug93sWJDEmjnd9R+3rDlQtNhrly2WMVlyWlRVXdu5A3s8VTmeIQ7JNnkQC3bWmkocXG0LqCeN3VGHEoznn4TOmtBeGT3gLinHJZf0W55ld7IKqvi9ipQVKCXTJ2pwOlEO3ALrUIQSLenBoCAz9EfgPdwZuE3tPnN8OcBNHHffiYciBTnw1PmBgh0hQvRcPRVUPuxdD0UCH2Sq+KDPp7TDlbP19HsYHQwvjWqRJwi6T5E/wzhkK7dxb/0QMyA4eCAIERgZZGwp1x2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neaE+Nidqy+1bB0syCgVxza8a0guh6SaAPyMyljQ/O0=;
 b=iKPHRItZxudP5NS7v0UtI+Y5mG2CH7EBTXNTz6ue8x1Fxk+F2n/jqf0lcuFClCua/guj0OEc9w3Bi3aAVPrycfSwzebOHTgpFn+zVOgKLt7Q8NVzjFR/GzzWPj2C5DT3s1wd9bdtOAckMoF7DkKvYCLeB3IfpZn6QS9HTAkVytXF1W3Xzg5Lq3upgzjG81OYuj4T6X+iIxTU6mqzGDgYfoPs4f7eZ2Hcz2AoF+slT6wTsuPWEK+upNMr3sK7rOD3PnB+69LTWe3O1Vvv1fjAQwY5R8IpgisZvVVnCWFT4/CYGeMWhVeMQCC50CkGeFy2iHWrNdKIXPqizN9EFvO+lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SJ0PR03MB6240.namprd03.prod.outlook.com (2603:10b6:a03:3ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:50:28 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:50:28 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
Date: Mon, 10 Nov 2025 14:47:57 +0800
Message-Id: <51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
References: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::6) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|SJ0PR03MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 362c5044-b6f0-40cb-c549-08de20256ef8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UNMyz6XTFOhyZIEWjWq0FQmL7r+q3jPjm+mV13Xo9So9t63KNC0xRJf8fpoH?=
 =?us-ascii?Q?mBGbQxdUAe6c4ei8ZwRooQuXZfW0mxTPn/nyxfLterL+q2LNboY9u5Icx5lf?=
 =?us-ascii?Q?wmbf5xr6/VLFP457KWur5iL9AHlIHEDUubA0sX0HOQGj+3rEh+sufEVNr7wO?=
 =?us-ascii?Q?5zqbya+D5NnN5w6eB/4k2IktjHYMhtGokfn5p/z3K4nUckpLkXJW91xLe2sA?=
 =?us-ascii?Q?Bamh5+XErx4lLd/I4tcswtdle6NOES0PSzc+RgtZvsfYpq0aVerQXmmOynmO?=
 =?us-ascii?Q?Jx/atpvcGAh6/SbCyfR7Krvhyshs7L+BUh3M39dW/wrJLvaZ4yDZjHpOk+e0?=
 =?us-ascii?Q?Z9cf3KA6qK9KaD5oTBWBuSV6bCZg7vSh1QDWOb2hK+K/T6pFJY6UoUKq7elE?=
 =?us-ascii?Q?1qom/JWC7tJ8iC7vWKrOV4kDKcpiWnxACSkLA9DCPVYG5sMSYwWBqSvKoxE0?=
 =?us-ascii?Q?V9wDKB7Y8eyJHYEAhZSTmibytv8MQdIF83jz+mw01dTlJyY6whBaQzwXYAOK?=
 =?us-ascii?Q?x0SCIls0POA41t4o2fxl2SrEW2mJJYJj1pKeqTnusTLluZ56TN22hTqgYfzq?=
 =?us-ascii?Q?7bqLIPbWei+12IP0zQiHaBuyEuYN16kVw0G4k/1WktjBNjuBQzNVAPiICEjp?=
 =?us-ascii?Q?NYC5IudfwXfQreWPRlcHopO1KLceVaNgfRh8MIacZnh949ZlYQ8IwMZ4xMq0?=
 =?us-ascii?Q?yaFtlxd1WOTWtPXXMEyt4jK2RscuUQdcUITHZTEtiRDcp3KzH5Hj7zU8gdND?=
 =?us-ascii?Q?GtccQmm0VR32/YUXWQSg8A0qpz5wMPSZC3CE+r4H77FNvqEBWpYGer8ttaUu?=
 =?us-ascii?Q?+LaGwfn8TeFivvR7PY2lv2IMgAPYa2kKXmMykLlAJ+iIvze4ZN2eLFSFqRqB?=
 =?us-ascii?Q?ANtmm/ZGVcvFUt3u/lLPJz5KnLVpllCk35du+cZ3ynRyBsrcEApshqJQIaAJ?=
 =?us-ascii?Q?Uf5MpZKdfQPDGeMM7wRhMCmRnzfePro2lz5b2vHVGuIOeiM1wedsWZJrY+PF?=
 =?us-ascii?Q?XEsbpskFFaXUIT3t11W+9W4mrkK/pO6Ycu495KZXLGD1kAujvS/yHh/u69wz?=
 =?us-ascii?Q?0YIS3hnVm75Xzak/g9WiFBUZ1j16G2Uq+rq5EZSexmjf5+NVBdH38Imdcm5z?=
 =?us-ascii?Q?KZN25foBol+Betc1h/zwxkVNUyoc373LYnUWiqmm6SeLlKj02+D+Tqv9h+kR?=
 =?us-ascii?Q?vC+5mHx6F6zxIBlk4OhIWZZ5tdbuV0R0vJDzuuVZGcA79dCtTKxmEjDJKl9t?=
 =?us-ascii?Q?b4qGmnFQPoGYML78y5W34YdAa08a4gQRGCcKV7t6S+HJtyAGYsCFRT1NImzl?=
 =?us-ascii?Q?5+6QLG52yaYykxd6MZpvgxPfoN2EB/GWCumM8k1xNDf++7DwZNmPN+7M7p7r?=
 =?us-ascii?Q?7XtGqVzhiF4NEPi4/Fru+S2YcFpc5UIQIZfGRUHbTnIZjuuOVgteAV96wYRk?=
 =?us-ascii?Q?xYBBPgA5rKwYh8RZ2DXgXGZClBqfV7Kv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TKb0SR7jKmCWP4i8UMPbSuxonwpjWNOwe/toCSHYVP/bZPT1+2xfKvJXknEb?=
 =?us-ascii?Q?3MJics8nIedeogLwOEaG/brndH1V5AigCVPaa0HoFcnQ4mdzT1Pt+eJ1bMO8?=
 =?us-ascii?Q?HtsHxNeAfr56U8JWXOnVkpf/uR/+O8ocVf4s1dWPMQ79eEltlhpCHCi1INmP?=
 =?us-ascii?Q?dwVpX+6EubkNM0fU1zCVIkXWUgx4Gy3WGzhZCFQMm0jV7PsecN7uFJ4H+mqx?=
 =?us-ascii?Q?1lRSULA2rC/K0tR8zVFWwVp266y28r6VxD2m3SESeAKUNg/isRjg274lEf9F?=
 =?us-ascii?Q?z/sPfG89VtGs7259H+hbFZVkvNhjL5nKoVGEqSKZ4ice87pb2saCW7Oc089w?=
 =?us-ascii?Q?q0OTWRlqKF6dvTXT3CcXpjptwh6nBJ68H/SaxkRJgx2LIBpihb/vCkETZInA?=
 =?us-ascii?Q?nalNKgkp60kh1kHNaAM6HS/C8Rr21C9CPg7cGiZCAJlq8Aatd/RCxcEMX1fs?=
 =?us-ascii?Q?7p5PDW7/ZGFAOkCTeQy0lsnCIB0rezgJBFle4ADaHOmo7xkD/3gmg4EXOr8U?=
 =?us-ascii?Q?SnVfWSsOP9pgJm9eNDShBansXq6uBK6GxqOF+ALWKkGrlG3O4uhuEnf09MnW?=
 =?us-ascii?Q?h2cz6YRsUKJMzHu1VZtK4YXFaGLPQaSz4zEDNXUr+HIkKSYOyyxHfhJQXRxe?=
 =?us-ascii?Q?Um9JwAzE9JTGBRqmg6b9vxyKk04x6Yz8xMT+bqpW4utEEEHyNFG9mjuL/De6?=
 =?us-ascii?Q?aPDb670luaY5XYSSirxy6O2d6/bvOwOrfr3u3Z9IIuVu+F5KCfLi3Yfj/rHu?=
 =?us-ascii?Q?8VjA89vpxI/cN4xD0N227WQhJw8oZfONkDzMCecR7n2a1HAVs9BdJBUf4S4u?=
 =?us-ascii?Q?2mghcbr1oTvt1Tz35CQMI24uQgFKYNKlX3nXlbUHxaxJcn1gDQ7PociwqOxa?=
 =?us-ascii?Q?oWORmiy9Wu8Iu0VyclktmAoWtIFwtAyTZAYbm78BEgQVaV5ZE126Gyfk/i9v?=
 =?us-ascii?Q?frS4se1geQNPXZPY+m5iLRz/kuUH5hFcSPeXOsAe50J+7JW/pQT7PWQgHGkE?=
 =?us-ascii?Q?+DHSfzpHUdDVkz3TjT/MxG1HY2wMnJj9/um8WYcotaEGZW+Y3IdYNVBi73bo?=
 =?us-ascii?Q?cyuY2Wvq7IVzaTvFHt6StbCu6r6nD6pJ30+dkfmKVOQScbz5uxygalBOYI1/?=
 =?us-ascii?Q?p9wPwM36Rjc2V8Co7J8Y91VDF6lXw4hJMG/LB6LMqSSeAO7wkacW9YFVFYBZ?=
 =?us-ascii?Q?u532scZkMuIxV4pIih18Wx+E7ULPCkkclQLS+KMKMSz20B09VSq3ug5ea6PJ?=
 =?us-ascii?Q?yNxUVSDE0w8Hlg6vfOitRQf9wjeoqtP5ACh9j0FNhROXvZNW3hiUgJ7YNCfv?=
 =?us-ascii?Q?9YOGPQO5baLpVyBUgRKBQ8JGL2AA/wTe5+oBKdHWTez/fbKWcCw3jm+jG71S?=
 =?us-ascii?Q?yx6VBU6cADGc5Kk7hTcn9uWtFrw1tXCJCzb3NlL94At8TwmtuUpNGiTlQoB5?=
 =?us-ascii?Q?ccijo2PrNQkwKfXsAKrRlmx1J5eZ9RusCI6rz7n9MAA2gEmdxNx2YVdnMRse?=
 =?us-ascii?Q?Zf2nPz0snADrT18stUP5sCdi/oT0A2Y50pKdNSzj/gw+lFfA768fA0hgKEaW?=
 =?us-ascii?Q?Q1XEWvPU0q+ki5cxB9IkLxNIv7A0lb5ukNVvnXJ0qNcdJS/HtwvdUaBQiwpn?=
 =?us-ascii?Q?TLe6pC0OeL+UYZtaFn1uCSbixv71KSSi5vfOI8OAZ/wk?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362c5044-b6f0-40cb-c549-08de20256ef8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:50:28.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHZbW00EFSfkv9jWtTw7iOtPHXTGuM7Ya6yPwwO207WJwcsvjKzroR0p9o2kWGKDSP6g51nsj6kXY798ynYhs8EBQdXwmBgiO2eQj6QGLPMJA1RF8Uh8/07AoZOOEwKV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6240

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add compatible for Agilex3 SoCFPGA board.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
index cf7a91dfec8a..e706c4eff019 100644
--- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
+++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
@@ -21,6 +21,11 @@ properties:
               - intel,socfpga-agilex-n6000
               - intel,socfpga-agilex-socdk
           - const: intel,socfpga-agilex
+      - description: Agilex3 boards
+        items:
+          - enum:
+              - intel,socfpga-agilex3-socdk
+          - const: intel,socfpga-agilex5
       - description: Agilex5 boards
         items:
           - enum:
-- 
2.25.1


