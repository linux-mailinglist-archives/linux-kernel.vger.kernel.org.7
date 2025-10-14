Return-Path: <linux-kernel+bounces-853278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D592EBDB180
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDD58500A66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD82F5A2C;
	Tue, 14 Oct 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n8f1OxwT"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791492EA729;
	Tue, 14 Oct 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470757; cv=fail; b=nA9ewnF4O2OGNp1+PYJ2XkRs4ocLvzKS95u4SvTtwbTRO154mIgEZS03Gs3Jl+PSl9Ws4ZtW7UOGb2abo5zAxh0qE1HSQbV0RzSoEQ2lTWnGczc+duw0zl1WTRvluWAS7Drmom86GOkOQzO1IwRY+TSkRxfjuQwk7A/PMAyFFGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470757; c=relaxed/simple;
	bh=pyQD8YyF9CeOnUCkIs4QWTW5456EiPnOKua/sTX9ip0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IaadIqKaNXQHQurpddvWnEt2BJlxfVSxNWkG2lWRN2V/ogMHF9xyEf8QXStMXDAppm/f7wY15mZIkTEJ/DN+SXo193vaaVAq5O1lspvl1XOuAt/gB2oo++1uxiOCBz1JA+XODYDIOS33JOm37N5Vj84CLY8nsQR/d70kDx+NnIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n8f1OxwT; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAcLbBVh2eDvdqG20wI1fZdqNwUMbrM4F/Pun8KAOLaaRcjK09/a8BmQiPYPcix4EO5vE/X/eJub+UQfn3HkDpmjsRbgZv3i0xH6xWFOMUWIN/ybYl0DEvEvEOZt7maInyHh/9E5aznp8m3LqiCBGhqHMuQFIc8e04YjQtf10m7Sv2NYjYq9dbMhv1HjXEHEhXFnVGeVH+63tjWSsl9I71h9G8aefcac894V/NtUo8fjqagsb5gdA85QzXqh1TBhannlJgA9BK8sXpGzdJFuWy5qe0iXEPfFv/BmowDYXaNwT0UvDGyfPT8zxPyyB7JYgXARQ9fEiog7w5R5bYuGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3GUMumh+teZWTZ4vudZ6NTEHXfTx6NCYw/vq349eRA=;
 b=JEzwfGYISVTh9cypHxacjJsgX2oQf5rPQ/3Fey4V/Tle2xdypG3CpAdSq7BGpwR3wvoVUidHWgNLfM7Qnca23fpNw5q+Rpitd8ebCpqbKfRg0cJGiTylku2ebnCPS0X3ljafLXIP4bIGgvaHRoG/eRKHFYtKApx4DENdl2Ow5tdPTZ204NA/BDGFIaTcAiy0HhRNKEfnhoq3yjIH72CHGLcWsKGImOf5qM0Hot1mjyZGBH1vywX7Bmm8AAZ+8Kq9sUx9irerUWqxjG5ZtDIhE3+TKmh5HOtb7k26Nt/uHzDEJVYE0RDckQWdFTBcO6XfJml8lmdJocBvqAuWJMsVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3GUMumh+teZWTZ4vudZ6NTEHXfTx6NCYw/vq349eRA=;
 b=n8f1OxwTvb0Y49jTHAA7cIBIqSRCyoNmJBPlC3oUjU/R1Q5KoMq6Pgecwvqiw8hbsjLEcwIcZrXXvs+H4M1K3S2mAybqzGANqCnc0EoIYbiu70RxZxZmDbVtx0jP5KgFScMV9RxB12qlh1lvLqqQbkrBv77J6d8pzefen2J3XnAPBUa1KL6OgDXYuvIjN/GFFrONel2K5Qezgr6PyScmqGxUa6ZsR0InwVO8XkiXSpQTli2Y43kOekFriSvSYXsoNJ6NwrZ7qk5U2zfSDxn44FNC9gDsOyucBWONGP3Hkg4cn1rMCBySKEQ7PuzCv9DJuzzmKxvvwXsMInnVy0A8FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:39:13 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:39:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:25 -0400
Subject: [PATCH 8/8] ARM: dts: imx7ulp: remove bias-pull-up
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-8-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pyQD8YyF9CeOnUCkIs4QWTW5456EiPnOKua/sTX9ip0=;
 b=dGKpnDuPet8wX/aKTEBDYqOhE0zoLbxi5obT4TRyYZ3ex9lhTEzxap3i/b4uF/Uw8fi52nLox
 ut4kDbR2TS7D783D+HNm1KXjSCaaR9ZC4noULMzamg2IbCGvM2vXugH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 03440679-1145-4c71-90ae-08de0b595a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z292Z09jODVFSHQxRUVzWnE4ckRkYmJ0a0NwdnQ3OWh1VWY3WXRnSkpVaUR5?=
 =?utf-8?B?cVo2NkU1UDFJQTZOa3A3eWhMdUhISi9sM2tKeEhhRjBhVE5tRWdvRzZ4NWJS?=
 =?utf-8?B?VVNsaW4rd0lna0NqcUJWdm45R09FOEZHTHZ5c1p0YzVSTDc0dXlwQnZWM3pE?=
 =?utf-8?B?aDI2YzFtczR1WVJ1SnhYYnByNFNVZnFjcXp3R2JScnZGSGhvMEErUmQ3bllS?=
 =?utf-8?B?SDdReXdYRkZ4Y21LM1hzRUMrR3JlT1JESVJDQXFYQ0xKSW9vUkoxM0Z6YlVi?=
 =?utf-8?B?aHVtR2pySzZVS3pnbVpNbDB5V1Myd0J1RkIycEl3a3llR1lFRVRUTXgyMHly?=
 =?utf-8?B?NWFKRnMvZHk4RnZxUE55OFVCVHErbFluemNXUEVwRnRhRlVLdThZOGNYd1Fu?=
 =?utf-8?B?Wm5YRWhXQVRrMWp4QkdTTGIrbGtxaVI4YVFQMVplZS9EeFdkVFcwNCtpR0x2?=
 =?utf-8?B?NTF0K3JEZ1BCZzlOV2hISmpUWWpLbjU0QldoV0V2UVptZW5zOWp5Zk1ZZnd2?=
 =?utf-8?B?dGo4a3hXbW1OcVlGQnZkK2wvVWplT0V2N29oZWt0Zk44VFVreGtIelRXVExY?=
 =?utf-8?B?K3Z0R0cwZ2xEVjZQU0R1SGVjYUkzNTZMUXpFUjF3c1VtSllLdFc4L2dGNmJJ?=
 =?utf-8?B?VkVrazF0Y2I0dkpxeDdQYUtOd0lQRG5oOFVlR3I5RWEvd3FvVEp4ckRaQVB0?=
 =?utf-8?B?bllRTFkzdzNTWlFWTzBwTkFHQlNiSHRjaVlLUUxDM0lNeG14TXdJU1dSQ2VV?=
 =?utf-8?B?YWNjYkxVQlgyZTY2YjBwcDdGckVaRExieUJVT2VGWk1WT2hJc3REV1BLWnJP?=
 =?utf-8?B?Z2xSZ080VDdUdXVib3FYeCtuUUVIMGFvMXZ6ZmEvRDk2ckUrRFF6RU9lVVpF?=
 =?utf-8?B?WjRBZ3ljbWluUFBtL1V2Z1ZoVm1ydkVTUDQvaFQ5TVI5T2xSSnVJMVdxN1hK?=
 =?utf-8?B?cXlpbERrUHdQWXpMTE0ySmhSeVpkWHBqcGxEZUplN2R6eUtlSEptQnQ2SWRr?=
 =?utf-8?B?M2cyRHVqZ25OUDlVZmZHRmhwamVrQTgzZjJqUmp3ZDZlQy9OcDh5eW0zQ1lU?=
 =?utf-8?B?MTFISUYwQnkwOFVtY3pVaEIvSGY2SHdod1lVaTFUeXVubSsxMVdqUFRxcXRv?=
 =?utf-8?B?M28wSUg2SStVbHZZUTA1NExMalp5MjNDZTNFcXp1dnhlUE5SMGkyUC9vKzJU?=
 =?utf-8?B?N3l5ZGErbk9ZU0o5OXdjSEpadVpKcDFkLzhzT1BPa1hVeDlPMTBZOXIxWkE1?=
 =?utf-8?B?OFYxSDRhM2NTZ2JSeHdGNGl2VStVb1ptUTdJejdpakxzcFVFbEpYVXNDT2FQ?=
 =?utf-8?B?UEUyaE5XcGpIQmNsYUJ1ak5vNHhQaFBRVTkyODBpMXNNQU9ORithOEp3RzEy?=
 =?utf-8?B?a2tDRDFLcHZGb0g2bXRSU0x5K25hVWZlYTA2bHoyUXpybGZtSXhzd2JudE1E?=
 =?utf-8?B?VUJ4Q29uNVY4SkZvYThEbGVJSGJLSXZUaVBiaUhwZkViODhaN0ViRWttNlFJ?=
 =?utf-8?B?bGY2THdiWEJVRGRmbFA4SWJ4dldleHA1NVRqYjNqNXV1cU5Cc1lrVGZoZzFv?=
 =?utf-8?B?NSt0c243Mmk3RnZyMWMweWZSZDVVTkFCTjFka3NyRWluM2xvWldBVXdBUEtB?=
 =?utf-8?B?U0NjL2VsWG1WeTZGcFVHZEJsWkgxMW9zSjZHQXVaUmEyakk3MFFjNGNlUHB6?=
 =?utf-8?B?dWJHS2VyTEg2clNBVUMxOVRYNnBQUjcvVWdOMWsrTFErV1pXYkJkU0NNaTNZ?=
 =?utf-8?B?ZXdKQndpQW8wZTBBR1pmYjdvUmF5SUxLKzhEN0EvU1prTnFLSlJpVkdKc0hE?=
 =?utf-8?B?NXhld1RlVXVFWTdWL01vUUVnQ2x2VkpweVVMYWMwTzVTOW9GRHEvNi8zWFJO?=
 =?utf-8?B?ZVU2TmpCK3R6SmZ4VXN1NFoxSktzOUNQZlJ2cW1Fb1puRGdLQU8zV29MK05p?=
 =?utf-8?B?dXFuWk1CVkY1a3VVTGg4NTE1dHJjTXlMV2VSVDAzUnc2SzhBN3VmVHZtRjhI?=
 =?utf-8?B?TGRzZ01oV21CQ0hYdFRBN3owS21QSWNkK0ZDeDR3dS9EYWJQOEtQbWtXL0p0?=
 =?utf-8?Q?5aOUAQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3NJbGtaRUVGOGZjb0pBaXBTVG5NeUoyKzdKZFIwbDlYRzFTSVdkclpxNktx?=
 =?utf-8?B?WURsNjRDNHk5WTJOWU40QnpqcTNuWlpSSlEwT0ZwN0ZuY1RiQ0lnai9JcTlu?=
 =?utf-8?B?Y1E1clV2YjNJWER6anZSTlJVK0FtTFdEcnVjVlhsR25sQzg2VWxiRFVqSFNO?=
 =?utf-8?B?VVNXVnB1S0U5UlBqOW9MWkFoWUVUZzNhTUpiVFRpMWhIVXUveDF2RU5xcFNh?=
 =?utf-8?B?NzlRVys2bzFpU1krS2RSTGpuTjltNjBIZ3pWNlBmKzkwVVZJUEwrTUtWM2gv?=
 =?utf-8?B?V3pBZ1VnSjdPdEJXdHdwZWNhT3R3bUxMY1VvR2V2NTcza3l0MFZVcEdaT3hX?=
 =?utf-8?B?YStCQW96bkNuU3FuQ00zbVdFVTZkNEdnWml1V0VBdjdkc3UvWncwaUJJeENu?=
 =?utf-8?B?UGtGZXBhZnJjUUt6bXFpcWZtSzhnMm5wMFE2dnZwZzBaZStsLzE2c2cyM28y?=
 =?utf-8?B?WU1YaWZjdkRza3dSSU12d2s0VDBzaWg1SEpUVXJNbkpydlpHNXFTcjkxZXFx?=
 =?utf-8?B?Y0EzWEh6a01BR1R6WXRaaFY4NGhJNkR1NDJKZVN1dXl3bFk5WkQvbDVCdG1a?=
 =?utf-8?B?ZmU3UlVYanFGeCtveDlUTVh2YVBFOGczTnArd205S0k1ZUlVZWpidENyZlJs?=
 =?utf-8?B?eVBpOERRSThwdzhUQjZXMjZYdm9VOTJpcTlyUllFaFhqMnYrQXJ5WVh1SXVN?=
 =?utf-8?B?OXFHMTJPWG5DM3JsQ2lWYXl0enFRQU1OWHdUQTlLa0VPWGxhdzRLYUVpMzFW?=
 =?utf-8?B?L2ZBWm9ENnpwSVdMZkNBNEQxNUFyMUlDQVBrOWluNGZGRVRvMzhoMGNFTEZT?=
 =?utf-8?B?UC9JUTdMckhvaTdRTkhZdjA2eERlZWpPZ2l5cjVtVVZ4K0R4TmtLVyt4TDdS?=
 =?utf-8?B?aDZ2WFY0TjdGdkFvOFB0T0srS09CQ08yZDdrT1I1QTBVdm5TbklLYUZPQ1Qv?=
 =?utf-8?B?MzRjcnByMHF6Zk1odHFUM05FckJLUmI0R0VYVFdzMFYwNDRNaVRyeTNrN29S?=
 =?utf-8?B?enI2V1IvQnR1dnFVRGY4dEVnWkRqMmVJaVB6cmd3a2svM3ZaRmk2cVhXNE50?=
 =?utf-8?B?ZlEza2JkMytZc0JrczQ4d3B4ZCtPN0VzR29WZ0MvQ2ZCYzJRT3FEcWptQmRO?=
 =?utf-8?B?ay9mWmIyMGNpTFU0SUVyV0dVdjlXVDJhbUhzRVVkdVpkMHFiRTdmVzgzSTFt?=
 =?utf-8?B?eUQ5OUxUZ0NQVmJ5YnBsTldyQkdiTHc1ZzhrZlVEZTI3Tk1wWDByOURMd3RU?=
 =?utf-8?B?QTJqajZiTisyZkg1Q2Q3aEdGcE1FZ3lSV2FLVE5qenczNldaekhUMTExT2hL?=
 =?utf-8?B?T3Q3QTl3dUFhK0ZRcXM1SzIwM1N6aWZDNkFYQmZldzhDRUhiVVE1ckJ2RDI0?=
 =?utf-8?B?dCtOLzRaVWF3VDhlOXZjR0pmckViSEFBdDFLN1oxUE5UM1B1bjJXVTJKdStP?=
 =?utf-8?B?Y3FtdExuYUp5YXltakZqSkUzQ2p0OHR3aEZCSHpUSVRsMVNsQm5LMTdYa05k?=
 =?utf-8?B?RFRPS3FzbXZjSHhGNE5pKzFvQjNkSzE3ZzVoRDN3M3ZJWXpzL0RCcGEvdWhm?=
 =?utf-8?B?T0NUL3RUL2tXcWdQc3kzZi8vUHlScGZDQyt2RGgzV010YnVCNWtPZWFRRWEz?=
 =?utf-8?B?enNocnh2MnNzZ21uOXh3SWtYQXFhUm8zNkxHZHlKUitrYW1jak5jVm9mNENF?=
 =?utf-8?B?SkwxbGhsUE5jZ016eE53b1YzWE5qNkJwQTdWd3dtZXRQbnBLeFVpbzVBaE1r?=
 =?utf-8?B?YmNUNzlZSUhxcHRVUTlzT3JFUk0xTWFQUjNkN3g1eWFHb3l2dUpGVGwxaWFK?=
 =?utf-8?B?L2VOSGE3K3dsUEJMM2Rac3lLTWVnRFRCVjJwN3ZRbDJFT0dYaUtsM1hlQVdi?=
 =?utf-8?B?cWRTUmxPMnUvakNlUWhXY3RxNWRKc1RSREswVmVHSURnejhFNEh6SXZ3TCtO?=
 =?utf-8?B?cm50OEduVFV4R05LNlJVWXB6dFMyZWd6eitDenZQRVkzM0dyR0dFOWJ0YmlS?=
 =?utf-8?B?V09kUDZSVlJqZXNFazFmSzBPalJzVCtpYjFMZmVBdmRJWnVIdzJzRUZrZ1ov?=
 =?utf-8?B?NCt1QUt5NTJhSXpBZkxPZ3ZublJlVmExYW9jbDducklJL2tXMW1tQ2NVU2J2?=
 =?utf-8?Q?7j2s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03440679-1145-4c71-90ae-08de0b595a5d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:39:13.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT7fBStllwKXtYRx6CGZHsYUQVyoQ3j+rye/lzWA5zrawfxNAmxUctT97lNZlUxNEXzpRQOFQuYLbD3EMiOr3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

i.MX7ULP pinctrl don't support bias-pull-up property. So remove it to fix
below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dtb: pinctrl@40ac0000 (fsl,imx7ulp-iomuxc1): lpuart4grp: 'bias-pull-up' does not match any of the regexes: '^pinctrl-[0-9]+$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts b/arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts
index eff51e113db4f947b7532e2e1fca538da6d74f6c..88d7dc005fa0ea1d91fa561c0c3e4963c1459481 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts
@@ -92,7 +92,6 @@ pinctrl_lpuart4: lpuart4grp {
 			IMX7ULP_PAD_PTC3__LPUART4_RX	0x3
 			IMX7ULP_PAD_PTC2__LPUART4_TX	0x3
 		>;
-		bias-pull-up;
 	};
 
 	pinctrl_pwm0: pwm0grp {

-- 
2.34.1


