Return-Path: <linux-kernel+bounces-892454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FEC45207
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E1C188F2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A282E8DE5;
	Mon, 10 Nov 2025 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Y9zFZpzz"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD52EA481;
	Mon, 10 Nov 2025 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757436; cv=fail; b=mApfG3VsjlWDReHbGfQzfndDuOWlu6cvT7+M5s0M4F6r8HXyJj7aA3LDxcX234G+im1moc8mJ7Ko+0+1Q1hY5igQtgaljrlucsCjSAVs/PN4D8m+eoaPB/1ldDVe8TkUKf/nHQrkslwCEY4t/y7hIulGGTqdgKx3NASahjy9I4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757436; c=relaxed/simple;
	bh=RvdXogCLxu/2FoGDpb0IaLoLYNf5DjM4rdb9Okebm9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oorY8+mB/agxsP8nKQ004VvJim5jr8r765/jmOdqbqlDIO3v+aDOnV1QvqQlI4y/V5Vy4FVjQn15GpPGfecxuPu5+BjrHJppTAuwSXICfjoWGfzwVu5SXKNjfaGRObYG86v/lJxxY9mvdakiWLCNM3Qgl9WEGqvTpdmB/jvbMnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Y9zFZpzz; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmAwW7xtg3te2WvxAmAsbZX2uIyPQVgswvyAKOB+mNwpZsFdTaxHnX1gH/EjBUkVvWiFvEMH5FSkewYDQNHwfXbmnGiFsqjiGnXUvZo1acF+wp6wuBMAd4CQ44h4X9tLpE0BTkwITcuI1UQ9FX+BkdgNMjmsB8XxN0TKcGoSAuXkWcYr0fotLMMNt/IeSGp7IRxxZv2xudR6UvynrE/hoK+w/qTpwDmJ7hzj3IEyPG3QKh11uAiJQ0JZBAgtczwMjM0OiIv6DJddqgM4QEHFWU6U8F2xEaVqer6VJvflcKTAPYkQnsnTvVhC1hRmh0mCQ80XbSV2HWZB7TNXQzvPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvGXj5r9r430etRIt0msVMBnj71IIpQFl44vHNSs5hQ=;
 b=mljcZ9M6mjBzMnFKha8VOBF0TMGnmpeV0fYVl/ZBh3B26n9nYVdSjMbj1MvuH27AZ1/dygOADDqh/mcavCplF5onAGEjfenUMpOv/bYucxc9ocpnRfm65SFG9E7sOTwAoZ1hCVV8M5qXkxa6xHb0vsYy1od9gteArsGqFjNBfshhDvsdGW1iWa0pUP5TZIm0VswAbIIJNaj+t5aDEa8/4EKNwHaCX/ABpIT7Lwf7ivPDLo1+xxXtu2sVhS+OcYlVKx6Z00NN17jTwKVcrQ59WtcQgr2fR4YYGVM7SP7SJypI5SgO33LeJLeL5i97MbbS7wf4D2PfGtKBvhkI6Rstbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvGXj5r9r430etRIt0msVMBnj71IIpQFl44vHNSs5hQ=;
 b=Y9zFZpzzy0+jXvsGzr/U4tws+shxhkqB1rS3PcMQizmQk68YlnZW/0rPVU0FXZzrw6WzSfenIcERfimWBMTqwTS9JmlxUPuHEgmclFGO6zGrOfkJ0cUiwFJrsIPE1fBRH/pxeM7f1kL7ZuJ/X9karihYPEroRJX9WWakgwdHeC3nErsmGhPoi5yBJylvezH9c60Ej13NBLLVWuAeqKxSbbIcpliPLYHqbrbhsphww852Bqc4LHTGMU2ZerhpUeKCvIEXlnARK9PQuhG7ypZ2wE6mvi9zo8o++yCduxVej49gLW6V+EDLUHq0r9hKu8nxuTQTiG4LwmxilviQk7ybvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by SJ0PR03MB6240.namprd03.prod.outlook.com (2603:10b6:a03:3ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:50:32 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:50:32 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 2/2] arm64: dts: socfpga: add Agilex3 board
Date: Mon, 10 Nov 2025 14:47:58 +0800
Message-Id: <aa19e005a2aa2aab63c8fe8cbaee7f59c416690f.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
References: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: 02db3f1e-81a2-425e-8945-08de2025717c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGU3UVpJKzdTZ1d4cUl6cU0rdiszMSsrTDlodUNTbDhYUW9JcmJlT0Yxei8y?=
 =?utf-8?B?Nnp3Zm5kNjRvdU1mVGx4TG5iSUdhazlJMXVBRUYrczhJQUozbVlXSEduSm9J?=
 =?utf-8?B?YTNGQmliZXQyb1dlT1U3OEluVlFKbDNNcTJkMXVXbkFiQ3JhbkNlQkFQQndK?=
 =?utf-8?B?eFlqM05DVXhqS1k3Rm9pM0xDU0Nrb0kzQXRSb2JMcXVNK3BHZjhEZm5qSzBp?=
 =?utf-8?B?RmtyMG05eXZqcXl2dUp2akdKb0t1ZjJlQm12M3N1aGpRVGxOOXhaelJQdE43?=
 =?utf-8?B?VnpBc25SNlBZS1ZtcEVPNDZuTWhQNjlod0lxaFRQa1Nick1XU1FheHJ1eCtW?=
 =?utf-8?B?b1ROQjJ0Y29WSVVuMWVXMnJaSzNmbTRJbnhwU0VtYWRXV2dOY2p2L2JJY2ZJ?=
 =?utf-8?B?WThvVGNod2Nsd3NWUFkrR01VL01DRFB5SWJWeWtzeEVoUThWS0tTR1VxVVp1?=
 =?utf-8?B?VzBGYUp0RkNXakpqVHRMSElEK2ZmazIxaXVDd0lKaVF1aVV0MTA3c0JXZkRu?=
 =?utf-8?B?K2xNcW9Fb0djWVZ0UGYvL1pEQUVPQzNhL2VtVEwxQVkwK2ViK1JpVmdUQ0lp?=
 =?utf-8?B?Mks3YVBXYXVHVVM2aHlDeFpDTEZyRTNYbGRMN1hndUx3YWsxV3FkZVA2Vy9j?=
 =?utf-8?B?dW8rbTlLWjdYV3p2TCtBUDNOUU4weDh3SmpXWWFaWGxGcjFGOGZMNVRBYklS?=
 =?utf-8?B?dmVUTGwxSjFCY1hzdjFnZGRMaEs5dkN5ZDAzSnFoUkNMc3UyZW91dnZVa0lY?=
 =?utf-8?B?Z2VMaEVkTWI1cUFnYTNKTFRMSWt3TXQ2YlBObURGVDF3dHF4d0dWUHQvNysy?=
 =?utf-8?B?RTdpTG5vaDBQTExRQkpoL3VMclhYVU1lYjhlZE9tK1plUnRsTlpJdGxpNCtz?=
 =?utf-8?B?RWNEMGFObXlYY0x5bCtmRFlwY0J2d0pOWmMrWnpxV1NuYmZCWGJhNDJYUzR4?=
 =?utf-8?B?YVFYcFhmc3luUUdyTFh2S1BBUkJ2OWoyVDN3azhGOTBPM0ViL0NSRTdUTDkv?=
 =?utf-8?B?U3FaOXoyWGo2b2ZFbVJBY0xnT0tIV1NORnl5Y2lLN3RjQWtVZHp5aGZGUDZD?=
 =?utf-8?B?UGN3RDdQTStJUlRUaGpYR0NUV0VtQnNwYmJPVDNIbTZzaDh1aXdCYVVWaisv?=
 =?utf-8?B?dEJEOFltRjAvSVFZT3krK3J1Mlg0MytLTG5RYmNJdS9STWFhZ2lON0dBaWdw?=
 =?utf-8?B?ZnRzNk9zeHczRWMxWndScHZrRi9ScmdtWldCemxIVnpuTUJjUE15dTY4MUU5?=
 =?utf-8?B?dDFMU05OUVdIT21ka20rUkV0WmcxaXFNLzVockFLa2ZoQ3lUVE9nWG9xcWJr?=
 =?utf-8?B?SXF6bWFnUTl6aUUzSTZRQVV0YklCVDkyU3REdktBYjBPVEp0LzlINEx3NVVu?=
 =?utf-8?B?RGxsTXdPWDZXYXZVNktCcHBGWVR3MDR2MFk5YXZrMDZsZEgwd3FQV1JUZkRj?=
 =?utf-8?B?MHB6NklQalZwRmozR25Bc1R5ZDlKbjNobm1KN3duVFlOQUJVKzIybmNHTU11?=
 =?utf-8?B?czArSzdyV051dDN2SC9pMzF4Q2IvQ2NuMXBCY2diVUJYdXRKdEZDRU5CNkw1?=
 =?utf-8?B?V2JMY1ZiUnpWYjZNY29Qak93c2NFaEd0SS9iN1kxdGU4OHpRWk1LN0xGVzdD?=
 =?utf-8?B?UVNFQXpQWWNZeGZ6NEF5eFBCdmJoOFNVRVoxQjRqa0J0VmdDZkhzQWtxVEpr?=
 =?utf-8?B?WTVlUVJKQXRXM0twbTJ3VWhpejJYWk9GTDJyRWgrS0hwMVpLN0F6dG5HbElM?=
 =?utf-8?B?ejluMWhDcDJDSnBKQkM5Q3pJOVdwMGR1aG52RHo4ZDFyNVh4ZjJvcWwrOTBP?=
 =?utf-8?B?ejMva01YVW1mUE5Yc1VsOHB0d0FQR3NpY0YxMjF3VXN0QWRYSlVZUitFYW1w?=
 =?utf-8?B?eW5sUEVSclVHelV6Z3VmNXlXZzFCV3EvYldnQm5HclV1NTYydFR6dkdxeEpH?=
 =?utf-8?B?dFlDamF6aXZKYjg5cXZOb0hZYzBmL0FSWXBOdHlFdVBhZHVJZzljbEZCSkpx?=
 =?utf-8?B?UDFaY2VvK3Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3ZjMlZON1hWekVxMzVhb2pZZlJNMEVNSTFtNGpmeFlKNmp3dmdqUzVoNkM0?=
 =?utf-8?B?VTh0UGF3cXg4cEo5eTFCWFEzVlNtcjZmRXFCcGk0YU1XTUVqUHhsM1RJREc2?=
 =?utf-8?B?bVRlbHFXLzlSb0NkdHVMN2wrV284OWVpOHNyVHdvOG4xYkdLU1dxcjhZVExn?=
 =?utf-8?B?d3VCTS9CK3FFNy92Nkk3SEcvalg4YUVuSS9DbjhzTlNQN3E5MlRQM2M1YVZJ?=
 =?utf-8?B?V0Y1QUF0cTJNeG9TTzVSMjdNb0cvMEhuMnNwMDZpNGVGVS9iUnVmL25ZbVdY?=
 =?utf-8?B?blY0V0ZjQVJRdVp5bndOOGVOR2lsWXRsYnFob0hWRXkrVkxzWGM0TWRDcERN?=
 =?utf-8?B?eEI1dVIzYUx2cFJWeHo3N0diQlFMWkhjQ1FjbXNySXArWHo0UGkzYjZCUktm?=
 =?utf-8?B?T3FXZGpFS2N1cmM1aWdkaUtkak5xbFUweWNpMFQwZ1MwTkNERFU4ZXAycDc3?=
 =?utf-8?B?bHF4cmJOOGg5VTV3aWgzZHl2NFdta1VnMU1xTmNIMWJneTZuTzQ3dG1BR0t1?=
 =?utf-8?B?b3NvUDk2dERMbnIzZlFTVlF4UlRsYVNYQjVLdnVyREFsSzZpaE51ZDJRcWJ4?=
 =?utf-8?B?OXNSLzVrRVBJdTdhdVJOY0JoMUd0RVVtQkpYTEhLT2svdFZVNmFwSE1EUyt6?=
 =?utf-8?B?bjB0QnIrQWoybjdIdXh6SFdhT3FJWDlPK3ZPQWNhcDkweDJLaTlkOVZvVity?=
 =?utf-8?B?SFIzZkxVVERmKzUrTEcxSEsyMlF2OVhNZTlzMldjNEVaUFA1aGxvbEtEa0lU?=
 =?utf-8?B?U2o2MkhNKzlFRCtMUWl0Z09PS1pHV1hLL1N6Z242c3hNN2MzTE9LVlhhWlY4?=
 =?utf-8?B?U1ZCMURJVTZGaW5UaGpiYlp4T05KK0dZMEVOZ0NMNk9ZMWEwWE5OR1ErYjJu?=
 =?utf-8?B?eVdlOUl4NjczSmxyQkJRNFRDUWhibHQyWlZURXBIeDJlYlgxT1FzbldqNSsz?=
 =?utf-8?B?cXVRQ0tDWGVDbGpVOXRzZEt5NmpXekJQSm1NZHY2Q2V6d3k1b1AzV3lWMFZx?=
 =?utf-8?B?dzVlc211OFY0bU5aSy9qRUNhRFdtdFhjZXFVVWRUWXVTWUlkTXl5d0lCYUFq?=
 =?utf-8?B?WCszTU1UNldYUmtnV0JwUlF6RUJWeGloL0c0OFlLTnpjUytwenN0QTFuc2RT?=
 =?utf-8?B?Y1F3blkrMjdyS1BUMElIcDE3U3d6bEppQWs4SU16SGNZcXhWdndyR25UeHda?=
 =?utf-8?B?ai9PcFUrTndUWExKam95ZjFldkRXYW5yTUtjdGpTYnczTk1EZmxySDUrNU1t?=
 =?utf-8?B?Z1h6clFKcUFubUJONU53MlFUcXdCOWxwbnF3akM3V3lGUzM0S3pLbHVLZzYy?=
 =?utf-8?B?UHNiZ3BxSTlKSXNheVNWRC9TaW9Gd2IzK3B2cm9KVmxsQjFNNTR0M0JOenY3?=
 =?utf-8?B?bnBqWjNHbi9DcXlWR241Z3hveHVsbXZVbytiMjFmUmVIOThHanBaTGRPdWlU?=
 =?utf-8?B?MjJzenZLWGw0UVFmUlY2Q0thVEpHYU9pWnB0L0hkZTRaSis5MW42R3VPK0dN?=
 =?utf-8?B?bW44TVA1dTJiMkEwOHdqQmVpdW1SUGhoKzViMnRJMmVFcmJlTTlTU0dLVzhX?=
 =?utf-8?B?a0VhSlRqS0RjRnNHcVQ2SDYxYnIwR080K3M3VVNXUGZ6MkY3Z2VvMnZhNG1J?=
 =?utf-8?B?dXFmL2xSYWMveEpreU0xN1hQWHdtaGx2N210UXQ4ei9QYnk0clFMRnpaWllO?=
 =?utf-8?B?VjFzUnV0VmgyVzVpQkQ1WWcyZVRIcndUcnU2OVN5M3MrZms2b1lqbUVLdEdr?=
 =?utf-8?B?bDJQUEJFM1dtWkFSVmtRNHlBUHBMRURxaUU0UnZrY3p0anBPOG1xaGJRVGJT?=
 =?utf-8?B?R0Ruc1g4ZS9SSmsxdXljUm03NXI4UWVxdldIRVZZdS8yQzZ5a3FIS2E5akFV?=
 =?utf-8?B?TENCS3dLdHBCQ3d2dEJKazR6UWV0RlZVcTNrOEd4Ky96em1aZHVXc3pnRldC?=
 =?utf-8?B?ZW9zOWNsZm9ubndLSlYrTkpIbU5wWkhCdDNaUnlPZFVrakUwa1l4LzZLaU9l?=
 =?utf-8?B?WGlnUEtMZE13aVdZU0ZIcmJsL3p2ZHJPU2czd24waGhOeWdDWDcrSjAyRTd0?=
 =?utf-8?B?Z1pWUnZBaFR2RHVCNWRkSXlUSjFnUXpIQWdNdHBuWlFKZTNjdUcyTWNYWGlZ?=
 =?utf-8?B?SGV3a0JlcFk2ZkkwdkQ4bVBSZlM0TnZKRUpXc1J0VDliOStWOVJSMUI1eW13?=
 =?utf-8?Q?z4M52wCBhAQpHnnBYmIDDuA4dMd1df/MqxLEylHdkmXH?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02db3f1e-81a2-425e-8945-08de2025717c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:50:32.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU18Z1d3A4n3suVvYWSl6PLUSF5kt4FD3HGrTClItZ/vfBIdv5XB3RGbyY0GPt8LvQj6zDLZR8X0Xoc2Bo0mI90ZaAQhjnGBRZWLrihiLWErkqgZ5CCdXY1iHWAsJ44R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6240

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex3 SoCFPGA development kit is a small form factor board similar to
Agilex5 013b board.
Agilex3 SoCFPGA is derived from Agilex5 SoCFPGA, with the main difference
of CPU cores — Agilex3 has 2 cores compared to 4 in Agilex5.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
Note:
This patch depends on the series: "Add iommu supports"
https://lore.kernel.org/all/cover.1760486497.git.khairul.anuar.romli@altera.com/

Patch series "Add iommu supports" is applied to socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

 arch/arm64/boot/dts/intel/Makefile            |   1 +
 .../boot/dts/intel/socfpga_agilex3_socdk.dts  | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts

diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 391d5cbe50b3..a117268267ee 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
 				socfpga_agilex_socdk.dtb \
 				socfpga_agilex_socdk_nand.dtb \
+				socfpga_agilex3_socdk.dtb \
 				socfpga_agilex5_socdk.dtb \
 				socfpga_agilex5_socdk_013b.dtb \
 				socfpga_agilex5_socdk_nand.dtb \
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
new file mode 100644
index 000000000000..3280bdd49faa
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex3_socdk.dts
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex3 SoCDK";
+	compatible = "intel,socfpga-agilex3-socdk", "intel,socfpga-agilex5";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "hps_led0";
+			gpios = <&porta 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led1 {
+			label = "hps_led1";
+			gpios = <&porta 12 GPIO_ACTIVE_HIGH>;
+		};
+
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
+
+/delete-node/ &cpu2;
+
+/delete-node/ &cpu3;
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&osc1 {
+	clock-frequency = <25000000>;
+};
+
+&qspi {
+	status = "okay";
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		m25p,fast-read;
+		cdns,read-delay = <2>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00600000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x00600000 0x03a00000>;
+			};
+		};
+	};
+};
+
+&smmu {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.25.1


