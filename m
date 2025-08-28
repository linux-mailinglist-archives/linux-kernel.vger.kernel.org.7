Return-Path: <linux-kernel+bounces-790538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1564B3AA09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9016417D780
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B45221FBB;
	Thu, 28 Aug 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="AIi/HGMg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99E273D83;
	Thu, 28 Aug 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405691; cv=fail; b=cJmKfAIF32QJ/YCWKYzbnlKK19ALq+pfV5seUupU5S/ltBB3qOhEaOJkqrIcQpHZarNCqkVMTv2gn6yi7lDczi6JiQGT8by8EtUL3LTcDfadHhK3kRLxZAkDxmfg7+gdKDOT+4mLsj2qQmVYxcTegePFTVc7uMSNSV4zsRsyQ+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405691; c=relaxed/simple;
	bh=IVKUlhOkRjcNjSgmz4ZhSExnmqKjWnXAbKSsxIQgonM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iky3aG+QrR+GjvDIcJHJeegHNhZ5GTmAlgYJ25EK6VAGYg5FiuvVoNuigdXPBqmi/oUcqgiG2CGAF1tUrYZ7yJGUf4F9EEczC8eOSI+l+QR/JCvyZJ0vtUoOEUnHwcfrroiK3GmUA4xK+eE+7qTZrRxtSfkfaO8fxWzCrymFfqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=AIi/HGMg; arc=fail smtp.client-ip=40.107.223.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQ4gYezfx4LrcCf8EqDMzRZEApxT0ZOAbUprEw/ip23hwViXIHxgIlBVSkwkquPFiB3sGeF6r1uKBHX4YKho8qwR273kE2fuykVbVfWzRTSIvK8q1xDc7NvJhqWBQX+gHPlqHF0bVV6xJz/TIYMY/9lK6/GoWia551QXzcBjHVuHTIuI5XQ++V6qehrWyf4sPh32jo+4AdBgub+D6Z4MOOoUkmM3V4xt7Gx+CExJEVALY+PVbHooYIpoXdxaiDEbaNahxc951Hihy6I0vC7qKqL6d0ZFQ7WjFeNyXDaS/kZsHDSxEwkY/R3DiGZ7dNXH8TqITNRarR/mKLe0PiSFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgtGp6xwB51XYeRFlMtatE/h7ACYG/gUGnSieq4FwhA=;
 b=U+A8Eeh3a36BhoV5q0QrgRpbfWlm46PGDFryh9wjuqiWSLX0PjACPQtGoNlRBHpRRuhX8+1QS4OPAnUsek+KuTsoxTJrvU5wOu3EaAz/8jqpBqLWSOaO1Ai8lixgdwok1NHA8RXG5+BDpCfa0f7FVO8+bJSepgec2iIod7S+PjGYWds4wi1/2X31jmGlesLM+pIEBNHDcuipjNmc8n2oi8p1j55U5yOJ0fe29H10EkNYf9tK9lggWGM1HlqYnE0H+g/p8YfQGLMreJ7IkK1P70AoTd4z4xENOfu17tRPHtvI8Gp/yhQ5hSP+/rwMe6n2H9FFiC9U84R6JRzREquv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgtGp6xwB51XYeRFlMtatE/h7ACYG/gUGnSieq4FwhA=;
 b=AIi/HGMgjwjjqe+MNfXeWLGaFpKRPVhfVT6EHRF3wobTODk/qRPEwM6/p/U+6kMiMJALDotOR+KoSwbB4f6TLNKsfPUYBDVM0ZnvdZ0qzue3iXH6y3Hx46sHjdFe9KLezx5jsTuOc8ejRNq9ikVa49y+2MsPIIHScs27VgRGNwyR29lYROswtAgj5YpPdIrysG5IT+TbTIjLuzRfFn9mqsN5uxuuZvl12XCCc8W8OsmSFA4gc9IOn8kz2gsINjR8F6gKzMghs7062zSzHSLe/N8kvhQEhaPBatZ4UhdGsxfHv7XMrCKb9XkMmoJPYsVgrdLDUU03Pvo21GxKDS12uw==
Received: from PH8P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::35)
 by SJ0PR18MB4107.namprd18.prod.outlook.com (2603:10b6:a03:2e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 18:28:04 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::45) by PH8P223CA0016.outlook.office365.com
 (2603:10b6:510:2db::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Thu,
 28 Aug 2025 18:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194; helo=[127.0.1.1];
Received: from [127.0.1.1] (50.233.182.194) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Thu, 28 Aug 2025 18:28:02 +0000
From: Harshit Shah <hshah@axiado.com>
Date: Thu, 28 Aug 2025 11:27:49 -0700
Subject: [PATCH v3] arm64: dts: axiado: Add missing UART aliases
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-axiado-ax3000-missing-serial-alias-v3-1-393111f4bd9e@axiado.com>
X-B4-Tracking: v=1; b=H4sIAKSfsGgC/43OQQ7CIBAF0Ks0rMUAQ6W48h7GBS3UTqKtgjaap
 ncXWhM1brqa/Enm/RlIcB5dINtsIN71GLBrY4BVRqrGtEdH0cZMBBM5KzhQ80BjuziAMUbPGAK
 2R5oUc6LmhCZQ0JUsNChWGk0idPGuxsdUsj/M2bvrPXbdPssGw63zz+mRnqftu1PwJZ09p5zmQ
 lmtdAXOsN18tK66M0l+L75NscgUyZQsF1blcqPKPxO+TbnIhGTaUnIJZc0L/WOO4/gCDJExtZI
 BAAA=
X-Change-ID: 20250813-axiado-ax3000-missing-serial-alias-39c489370ba9
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 soc@lists.linux.dev, soc@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Harshit Shah <hshah@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603; i=hshah@axiado.com;
 h=from:subject:message-id; bh=IVKUlhOkRjcNjSgmz4ZhSExnmqKjWnXAbKSsxIQgonM=;
 b=owEB7QES/pANAwAKAfFYcxGhMtX7AcsmYgBosJ+xIh1Be2Ma676rmSE3Y78gLVFuojK1BdWow
 yQEJ8TX7OuJAbMEAAEKAB0WIQRO3pC/7SkLS2viWOvxWHMRoTLV+wUCaLCfsQAKCRDxWHMRoTLV
 +4aLC/9lBNDspmLJ5/OPjzDoUXcH8Yh26YXxpGWjWJO/e9RhTr1Kb+VEHnBpye9idrwSvjRa28d
 czr7KzuW6yqQo1c+hAsI80BzUmS7Cf2qf8cmegUCOx1fEpYUdPxRYrzmY3z1rqbcgWUJD8ZmePN
 Sv7/Sm64F8AjW/WBTcAu/aCeOboSwfj6PaSZetLOlnE48OHnLg+TcPowKLsVz9pGI/2E3BEXCrK
 9zK1t/rlaVRordZO16g2BouAxAkMioEU/Hxmer4D1tIJ7To91rjLjgB75oLCGoM6zd+YokySGiG
 uISTQaEUp7DbcT84q/OQHoo1LHElPNDpFSK0CwLfH37c6VK6t37+MrVVlFS/31uIMenmYnU61zU
 Cd7P1YnfPXM1NiWULVR0elaRKdbXvZAwLLzUpRIcy9LbL6HTvOTffpOPnOmhGQbNNinJ6N/os0A
 L7I6wMRIgxrVHAAm97PRD8Hr7kPuWoZOAiAQ2LmxwbXAFeritWoEunfG0M+M2GysrwM2U=
X-Developer-Key: i=hshah@axiado.com; a=openpgp;
 fpr=4EDE90BFED290B4B6BE258EBF1587311A132D5FB
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ0PR18MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f620188-04e8-48e2-5147-08dde6609f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzJqSTdmMjNkUDRJemo5UnUzZ29NSnIxejhtZmQxbmFjNkpHNEh3K3N6dGFB?=
 =?utf-8?B?MWZLRFJFOVB5RTlKRHUvaDk2dUJQY1R3VzNNd1AyeTM2ejNGazkzRFZseUE3?=
 =?utf-8?B?RkxwZ3EwNmFnZm03M0xnTkhtaDBxcHlGTHZqVElETFRvTXcvQ2NieUxZaGU2?=
 =?utf-8?B?NjFGNTBYaXBDallVR0VaN0RKLzRlSjljblRZQi9zTTV2NjRDVFRUUFhDMGRG?=
 =?utf-8?B?ZnZZUGE5YUtUci9EZ3FEc1NkL3pmS2J2dHJYZXJlaSt1UGp2N2diTGc0QXE3?=
 =?utf-8?B?Tm91dnFzZGFzTHJCSHk3V1JlYnJzelhUOHFkQ3kwVzFaOHd4WUVRSjhWbHN6?=
 =?utf-8?B?Y3ZsZG9NeTBja2NpZU1FT1dUTVBiemtBemlkOHFEdWNENFdybldsQ2p0dXNi?=
 =?utf-8?B?UlpTVjhVMVpyUUJhZ2MyUnlyWXQwcjRBVmRlaUtUbnE1bjVYREQvUWthYVZT?=
 =?utf-8?B?NlVzUGhJTXc5OXVTclUyRkkxaWUwQU1NNUIrbXh3cE9TNnltdVUrSmM4M0g5?=
 =?utf-8?B?ZnBxODZiVGp6MTBWNWdQZVFhOVBhRVd1Si9iZll4bm1HNE5IbFlYamlIYkwx?=
 =?utf-8?B?S0Rxc2VHc1B4VUxsSEdPSjFqSkNGQm44SGx0VXM1RTR4TlgrU2U5c2puZS8z?=
 =?utf-8?B?emtJK0dzMlhmclF1aU5rNXhaZkNMazVGRldrTENBQ3ZEVU1EQUN4eWtQT1BY?=
 =?utf-8?B?M1Z0QU1HQlVodExVOXJNRlZLSmJDVEhOZzczdUFBRXRGWkQvOS9Oc3lGU2xt?=
 =?utf-8?B?TEk5QWx5Y2hJVVNydUNpTUxJWDFackRZZFBDMTBldXZualRIZDNLNmNKemRi?=
 =?utf-8?B?b3ZnOEZRaGRXNy9JNWY3amova3J2MHhQYk4vMkVxOGY2TFladi9UWGFjb1cy?=
 =?utf-8?B?ZkFDSHJTcndkNGZRc3JzWStCQ3Bzd3dxK2FGZ3FNNSt2eGRBcHFEcHFmaFha?=
 =?utf-8?B?S3daM1JkU1Y1VUNVZ3dTSDYyVTNTQi83bU9MRWNxNW5iWWszNVkxV1R4bGhR?=
 =?utf-8?B?M1Rjb01qMVpBdDJqMS9qZzd2WmxhWE9BbFBKVVMzTEc4cXlKOHZyM1F4UzBW?=
 =?utf-8?B?NUMrYlhhbDNtQmZUa2FJZFFMenk3K0dCUTY5MWtuRVRBbHlMU21aTkVjTGda?=
 =?utf-8?B?UFlTSjlVdlUzS0VaaEZtUDh1NTJJYlBHejFneUVOK0M1bmZiLzVONktrWG9n?=
 =?utf-8?B?UmphNDZiSTVmNmhweFVvcEhJRklGcGl4amVuMFdOdDRpOTQwSEh5S1BsR1Bp?=
 =?utf-8?B?a0dVT1BmaWVwa1hjVnI3MDBhM2pTc1AvamM4OHY3WkxqVTRqOFQxYzdHNkI2?=
 =?utf-8?B?YlJ4SG54MG9tTHhGYk41OUpDMHBFaE85aTRvNDZIcUJuWE4yN29zMEh5d2NJ?=
 =?utf-8?B?aWpQd05idVl0THNTM3NLcHExN0lCWWs0ckFuTTc4Vlh4ZmVwaDVaODlldTBM?=
 =?utf-8?B?ZlI5c2c1ODMvNFNVVDV0Qlhjayt1amcrN04zanluSkJqTVlkV1RpMmR2L0k5?=
 =?utf-8?B?L2Y4aGFUaHhDUmNoKzZjR2F3d2JqRkxGZHBOZ21abzMxcUZZZ3R5bDRSRmRM?=
 =?utf-8?B?U1l2MlJmNUtFTEdrK3kweVFaaG1lMVIzNjAvV0VaUXIwVTBuR1NEZW1lWDlB?=
 =?utf-8?B?TzFDV1BPY05jL1RuV1VQd3M4ZVBnUTVTUk1YN3lKV2dQcVQyVnVhUFdRWVRz?=
 =?utf-8?B?c2kzWXJzWkJTeVh5YS9uOW43ZGtMakdmcUY5emVlYlQ3ME1NZjJNWlZLck9l?=
 =?utf-8?B?cHdtV2lVbDF2djFqWDR0aTFFM2JBdW1RNUpGOWFYa3IzaXU1cDNBY3VPTnAr?=
 =?utf-8?B?SmtWOS9oSTRRdVM5QldXRjFEV3dxMFRsaEczVXh0UEE5aHU1VkVXVjBFUXhS?=
 =?utf-8?B?cnZVQmF5UWtXZ2xHRzQ5L1ZQeGR6TDZweW1sZDNNa0dNT2xHeEZsUGRsRThz?=
 =?utf-8?B?dkl4eVlwRWVJTVoxTFVmR3Q5YWxmT09SclRiMzZmSUxBMk45bm1WRVN1Mllz?=
 =?utf-8?B?Q2kycnRTYkxmY3BYM1F5eG5yWDFsSmlmM3RzZnFHOGcvSUxrRTVRZzlSMTZM?=
 =?utf-8?Q?WxG1TA?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:[127.0.1.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:28:02.1271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f620188-04e8-48e2-5147-08dde6609f93
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[[127.0.1.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4107

Axiado AX3000 EVK has total of 4 UART ports. Add missing alias for uart0,
uart1, uart2.

This fixes the probe failures on the remaining UARTs.

Fixes: 1f7055779001 ("arm64: dts: axiado: Add initial support for AX3000 SoC and eval board")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Harshit Shah <hshah@axiado.com>
---
- Run "b4 trailes -u"
- Link to v3: https://lore.kernel.org/r/20250824-axiado-ax3000-missing-serial-alias-v3-1-5db4143bf189@axiado.com

Changes in v3:
- move "Fixes:" tag before Signed-off-by in commit (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20250822-axiado-ax3000-missing-serial-alias-v2-1-54052d75467b@axiado.com

Changes in v2:
- Add missing "Fixes:" tag in commit msg
- Link to v1: https://lore.kernel.org/r/20250821-axiado-ax3000-missing-serial-alias-v1-1-527d979c3ea0@axiado.com
---
 arch/arm64/boot/dts/axiado/ax3000-evk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/axiado/ax3000-evk.dts b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
index 92101c5b534bfac8b463adaa1c4f0d4367d01e21..b86e969625573bf92bdd5e4435ea571dd7500de2 100644
--- a/arch/arm64/boot/dts/axiado/ax3000-evk.dts
+++ b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
@@ -14,6 +14,9 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
 		serial3 = &uart3;
 	};
 

---
base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
change-id: 20250813-axiado-ax3000-missing-serial-alias-39c489370ba9

Best regards,
-- 
Harshit Shah <hshah@axiado.com>


