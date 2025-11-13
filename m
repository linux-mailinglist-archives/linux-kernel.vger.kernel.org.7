Return-Path: <linux-kernel+bounces-899640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63439C58A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820DC50023C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B610834D4D6;
	Thu, 13 Nov 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XWJGNk/j"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B9346FBE;
	Thu, 13 Nov 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047630; cv=fail; b=G/9ysLtseKHRj+ejMDTtdCti9e0HWyDuVHDsI9AD8qOu3eWvxeYft+jKOfzcH6x/FSQFQYnphC0DyiWIszZnyBEoOZ4WC97a1ao3NL0ur/I0dxEnF2SFBTC6WcvdyPpTVWkQRhWQhFthnmmd3thxEW7fTTdHAopE2TYBCGzZ0xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047630; c=relaxed/simple;
	bh=rEHo9Fcr9qHg7JQCwBLga25ZciP5WGkWch0+p4mq0hw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=me8eVlxmr2tiwpHlYpOISothhzKpC4XFnmn2auRrIrjaAjWhcYViWazp4+EEhOq62wtXlVCg4Y0VarhPRP42N5baUtzhl4Gbjt5btwGxFKhT9AjSDHkSH3gm8a3O1S5dN+R/TXZia9kULlcTtVrHVGJRy1neYKkwxOCjWxHvIZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XWJGNk/j; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADFCSbi4001733;
	Thu, 13 Nov 2025 16:13:59 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu5r89-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:13:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM9vgzh9O39IBLCAt4oC/cEnuDr6mjqD++K2oVF9WLFuSJHZrHr0iQ6g8DLHoT4xoALun+cj6mDAhsR8Nd+pMmNai0qq2GgBsIq079su0+lZJ8Iam5Js/7fA5Yv03ITuO70mQxybEppIcHsIQmiwoAunlG7SHTwntuMQVnbo1oFHuC8twew/+LiQMFjsd/wNtWgu0aLw3rXdSwUg/CcSiI+1bMgLq8TwOBlVRzgWL3f3HsbDbvf3Mm52IDh1XQ2DE+mrJtEw+YBx/1t6Es0ulk/h40+3Jb97xoDenqdCDofMd02H8IxB22Iq4zNI1cY7jZvelDSzekGl7rjcMpLiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V01b6T6AlcSHq4fupKdQMfIi3HIUx+LSaOjqeYF+M8=;
 b=pOKXlVgzHHYjZ8TiJaO4qeNxYa4FyWU5tuQcG0+dkYDIpgwGoxZ1WVrsfQt2GTi9lsiwypNq6l0BmfnfzXcBsT+9c0jygKxnZrUYkYcV0W2FjAq34SLOBcmp7NAXm+sM9PkFKVPTAfIoLqWyLYNP0aQrWOy3s70Bn8EI5WrKTA3pJpiFKQEw2k804+eY3mmvO0JBGrfrfkZKS6hUW8Eoe/wYSqLxXQ6EIj4CJKhN1s+6+35qC1u6eRqc2NUccHaEwn4tJqNA/lkkK10MnJpz95CKgyWAwcJofH7GfCedfybXwWMH3aUJBcRafUvOFwKuPwheCsccPo7y4tKysRLlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V01b6T6AlcSHq4fupKdQMfIi3HIUx+LSaOjqeYF+M8=;
 b=XWJGNk/jwtvUuz484hZ9HDtudmiRxBXsBBGIWAs+4Uh+N1C5HS9pPVjC5Zh3W0wQFt5/g//3h8fIaSc7NPozTMb/rLM3iYn7G2mSfiotTSZeUPJl61kD/PJC4CJdZ0Er7nhUJT1ZQDCmxN7wLNq1oC0MwKwg3OzAzg2p5bnpVd844LK6nigE465YPKSM+N29AbaS/ZoQJOm3zGPO0wjE5x49EaqukqFLL/yfAsObx+yRZGie2ks+FWf17uTF9dQWgk518eL42dt6Y8ehV5pcmuBaO73MFAMEqOI/sckVEHbs0JiNWGpJFfBoPm+46NCAQ7Vprjnu9sKgwzhYnPSUmg==
Received: from AM9P193CA0017.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::22)
 by DB4PR10MB7517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:13:56 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::4a) by AM9P193CA0017.outlook.office365.com
 (2603:10a6:20b:21e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 15:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:13:56 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:07 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:55 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 00/16] Led update for STMicrolectronics boards
Date: Thu, 13 Nov 2025 16:13:51 +0100
Message-ID: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK/1FWkC/42NwQqDMBAFf0VybiSb1Fh76n8UkRDXGqhGslFax
 H9v9Nabx3nwZlZGGBwSu2crC7g4cn5MIC8Zs70ZX8hdm5hJIQsAkHyeKAY0QzNPrYnYvLFtRt8
 icSXwZo2qBGhg6T8F7NzncD/rxL2j6MP3SC2wr2esC3DBr1AVthBGayEenSfKKebWD3vmrKPTt
 ixLVQEo++eot237AW02Gh4IAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|DB4PR10MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 838c3029-6c82-4867-cbe7-08de22c743b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjZDUDM5MlFxWTVGbkFRTlJWNlJzWEk2eE5CT1YwVHpaZ2N4V1NsQ2RBSkx0?=
 =?utf-8?B?OFZPRDc5SGl6YTVZWDk3bkZ0bFlZTjZpL1RvaldBc05YMEFMTDBIK3QrVnhL?=
 =?utf-8?B?dkJlSEpna0syeko4dGpEczdxb0xlNGtQSlduU1BhdFk5ZnVCekdaclh4WlZC?=
 =?utf-8?B?WnBjWHZFc2VRQTFhNkkxZGgweTRuTUQvUEVPYU1NOHU0QTRYMkhWdkFUbkdI?=
 =?utf-8?B?bGdSbStOTEtETS9mWFVXa2JsK01aT0duZjlBdSt0NXRLaEhrT0JiRXpjWUlq?=
 =?utf-8?B?RHVxb3l3V2sxQ1hzZnFqZzdvTi80MzNiMU1lVlY4Y2FXd3c4OVBuanJxcm9j?=
 =?utf-8?B?ajNJNmM1ZGlrZDFOT2FBTkRDZmQrUENxQno5RUVxTzJURFVBV3hmQmY3TDF3?=
 =?utf-8?B?dDdJMjdEbmE4WG5Hb1ZFTnNuMzMrNDhIK0c2c2FNTDVsUi8wbTFENzM3aFRj?=
 =?utf-8?B?dy8vRUhBVlZJWWNJY0Z4SHl0Nno1amUzeUJEcXZnWXpsQnVqMkdCVm11ZXA5?=
 =?utf-8?B?ZTVZaExMa2lNRlFCSi93UXBpZ2FTZ0k5ZE1uS2h6ZWR1ZWxOWEZ0bHVMWC95?=
 =?utf-8?B?d1R1ekFQMkQ1L3ZZejhjOWZncXZqcGNEOThFNnFyRFgyVU1CSEZONjg2eWo2?=
 =?utf-8?B?YmJUSWdOMTRTUFhzakt1QlRpSUpDczluR3JFZHd0aUZ4UmpiY1VERXRKRDBl?=
 =?utf-8?B?NU5SYkZoZFVMaXpSM2hEbHRxYXFrZUthU3BrNVFiVmpCODdyaW1YYmhvelNT?=
 =?utf-8?B?akF2SGY5YU1qd0E0QjIrUlZWOHFjR3o3WndVK241cHJtYnNIUHBnQmhjbFZY?=
 =?utf-8?B?ZXZPeDVmRDByUjd2UGdwTXo1REhnRXI2TU9OSCtwQzY0QzR5QjErc1dLUk91?=
 =?utf-8?B?Rmp0aUkycHI4V2Z5K2xGZXVqdFFZVlRGY0l1NVNOcnB5bTlDQ3ZBa3ZIUkoz?=
 =?utf-8?B?YWY5cUZOQlpveHo3TkU2RjhYVlQ5TXJIS242QUkxZUNuc0RXOUZvd3hDWEpV?=
 =?utf-8?B?Um9ZVTMwQTMvZzZrTEZ1cmRSZDFyT3Yyc2ZIdFBZUWdQb045Z1BkV1RnWDd3?=
 =?utf-8?B?VjVUamtkbld6VG1XWFg0NzM2d0hmWk1wOHlZZG9NKzhsMkZGT0c5V0ZLejQv?=
 =?utf-8?B?d1lldndqOUpoRGZNamROaE4zTmxFdGd5UStBTFE2VEVaSllhZ0NtMThHbmhC?=
 =?utf-8?B?ZjJlZjQrL0R6cUtKNmR4Ty9JK1kyUDc0UWwvUDNOT0dNQ0xLZFhEOFNqcXNu?=
 =?utf-8?B?Q2RKUThKb3pWekFCVkp0aVNRdjdMMjlIamUxSGk0ZWJ4NUpRMEMwSG51dm5Q?=
 =?utf-8?B?N0IrZkpXbHkyRk16WkZkZDNIayt5d1Z1ZzA4aTV6YkYzdGpmYzd1NkV1Vm5W?=
 =?utf-8?B?MU1GM1kvUFk5ZW0vMzJUTkhZQUVwR1ZZUkVEM1RoMzBKT1hyTU1pT09DcGtN?=
 =?utf-8?B?NmkvOUpPdExNdjNIb29od1J2UnJVYVVBeUdOVk5TemhsUHpKSUVBbjBUVTFz?=
 =?utf-8?B?WFNrbUtyakdlaXlQNVNENVQ3NjhzdzZxUmxhdlY0SW9mYVZYNjRyWWJNRTVU?=
 =?utf-8?B?VDN6TzRLRnE0Y3Z6TjFGc2hCNUJ5SHNia2lTZjNucUR3czRHYVJ3WWVCZkp4?=
 =?utf-8?B?S29oTk5oODE0aDFvMFFadDFMR1BRemlXUVVCektBbTRNWVZkRlh2Q0JXQURw?=
 =?utf-8?B?bkdLcnJ0cTU2dUxGbzFNMk5BTVpHRFJBaU1ZM0JnUWszcTZlRVZCVXpXYVBQ?=
 =?utf-8?B?dGZodFJpdmlQanJrR0pjYlN6Y3JqeTB4MnJUbkJkeEVNSHoraEJhcXZNM0VZ?=
 =?utf-8?B?UlZEOEFNN0I0VmhDOEZUMXZRWGpmUVJSZkNrSXY0aWMrZmtYWEc3eVY3Mmht?=
 =?utf-8?B?TElTekRiVVYrMS9oN0xKQ0VxczQ1b0ZqWUgzNWlqM0UwQ2RyMW9yZEhTOHdP?=
 =?utf-8?B?NWdDL1J4MjlxaU10T3B2bTJPemxWMFhwMldGWXpaUDNOZldOazVmVUJQNXRM?=
 =?utf-8?B?Q2hBQzc3ZGlHYzVzODREbzNSbzkwQnhmMjU3RGk0WldYQTRNeFBTZ2kwelJM?=
 =?utf-8?B?TlEzTGRuM1ZuTGJXUDJjZ1d2SnJad1pIVU1sTkllN0JFNHdPK2w1UVBrUks3?=
 =?utf-8?Q?xXU8=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:13:56.2290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 838c3029-6c82-4867-cbe7-08de22c743b7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7517
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX5nYIBdC/GXQz
 s0cURX0++fCkf86PdropOEfA9OimffeZeJk59rVGqlSdW6heTpoJTWOi4uHY70DAA2D7HK8AQvL
 yJ3IPaE5TheiLmaMOzm5V2fcuw12nSp9SHu25YgCL+kIloUesBCrcP62H/kX866elBkdajU59Vu
 2XskzWzUlYNrA6Xr4nqQ/CjROnm5LxqV3Z9+f1JWQ6eehIk4hleA3ddFVf0go6KrBCH2AA83YsH
 sQFMkHV8j7QWO0PYywTyxJR+W6AeauyLcizx6OVZwxs9InB+36cLxZW7Lz6mE7dgdTw98XYmbg+
 KGql21aqkpSugTG9pgzuBukn204GXHJuhZepyhn/oI5oHp0TcQDHXIyJE+76kSIezAoRVuq5Lpx
 5UINDf9ME4LgQXF2HRzi+3ep0ndqHg==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=6915f5b7 cx=c_pps
 a=TMP85qg2SDlybNPwPaJQ5w==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=WigURcRRZJDv32fA7DQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 2TJDtdD1WQIRRDO5GAzksrDx0JWN9SRJ
X-Proofpoint-GUID: 2TJDtdD1WQIRRDO5GAzksrDx0JWN9SRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

This series adds/updates LED nodes for STMicroelectronics boards by
adding new LED nodes and function/color properties.

On STM32 MCUs boards (F4/F7 and H7 series) green LED is
used as heartbeat.

On STM32MP1/2, blue LED is used as heartbeat.

On STM32MP1, red LED is used as status LED.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Fix compilation error for arch/arm/boot/dts/st/stm32429i-eval.dts

---
Patrice Chotard (16):
      ARM: dts: stm32: reorder nodes for stm32429i-eval
      ARM: dts: stm32: Update LED nodes for stm32429i-eval
      ARM: dts: stm32: Update LED nodes for stm32f429-disco
      ARM: dts: stm32: Update LED nodes for stm32f469-disco
      ARM: dts: stm32: Update LED node for stm32f746-disco
      ARM: dts: stm32: Update LED nodes for stm32f769-disco
      ARM: dts: stm32: Update LED nodes for stm32746g-eval
      ARM: dts: stm32: Add LED support for stm32h743i-disco
      ARM: dts: stm32: Add LED support for stm32h743i-eval
      ARM: dts: stm32: Update LED nodes for stm32h747i-disco
      ARM: dts: stm32: Add red LED for stm32mp135f-dk board
      ARM: dts: stm32: Add red LED for stm32mp157c-ed1 board
      ARM: dts: stm32: Update LED node for stm32mp15xx-dkx board
      arm64: dts: st: Add green and orange LED for stm32mp235f-dk
      arm64: dts: st: Add green and orange LED for stm32mp257f-dk
      arm64: dts: st: Add green and orange LED for stm32mp235f-dk

 arch/arm/boot/dts/st/stm32429i-eval.dts    | 64 ++++++++++++++++--------------
 arch/arm/boot/dts/st/stm32746g-eval.dts    |  6 +++
 arch/arm/boot/dts/st/stm32f429-disco.dts   |  6 ++-
 arch/arm/boot/dts/st/stm32f469-disco.dts   |  6 +++
 arch/arm/boot/dts/st/stm32f746-disco.dts   |  3 ++
 arch/arm/boot/dts/st/stm32f769-disco.dts   |  5 +++
 arch/arm/boot/dts/st/stm32h743i-disco.dts  | 27 +++++++++++++
 arch/arm/boot/dts/st/stm32h743i-eval.dts   | 18 +++++++++
 arch/arm/boot/dts/st/stm32h747i-disco.dts  |  6 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts    |  6 +++
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts   |  6 +++
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi  | 10 ++++-
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 10 +++++
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 10 +++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 23 +++++++++++
 15 files changed, 175 insertions(+), 31 deletions(-)
---
base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
change-id: 20251112-upstream_update_led_nodes-30e8ca390161

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


