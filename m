Return-Path: <linux-kernel+bounces-887586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF7C38A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17341887C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8E1EA7CE;
	Thu,  6 Nov 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SjfDmOpI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ade9jkgL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UH1hXhV5"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915D21A421;
	Thu,  6 Nov 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390917; cv=fail; b=jL9uQfKz3+bHN1VLea8HkZX7i/1vsKl5dv4BBwcHtT8AvRWSAukV7evkpDi9z0NM0BmxXYHnM44AGnZ5K1dKkOig/8eB9i4xe08S8VgGdFXoNSnDNJ6XjcYOwGTtRiXzKylasf0bhO7nNYOMrtKFhRFEb6O6eWFN+Tn+ACnyOj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390917; c=relaxed/simple;
	bh=qSJq/8BWxF7N+3LN2PPfMi2Qz8W27SXnXfef8LzJ3D0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=siOwrHCY55jTRJWkp5+6EmQuD7BGNBQq4NqpjmD5CDS8Y1myvnW5Uyrf1DNPeW2ENnFOmbH/SQ0BrKGCqja+dtZmPqteNhMjFTmPdQczuUTaGXnbBZHgtJGBr8RLXsbwKlHBQp2jAvCEpjQtKkqJ4A/vvYHWClX9ZRnVskeCGiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SjfDmOpI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ade9jkgL; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UH1hXhV5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5ISoSN1721052;
	Wed, 5 Nov 2025 17:01:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qSJq/8BWxF7N+3LN2PPfMi2Qz8W27SXnXfef8LzJ3D0=; b=
	SjfDmOpIYEFkoHeI78hc6vnKFCYf19T59D8YbjQFKTFEtvzTdpPPEq7GP75ToO6r
	OAO//k2BpJeVGSgY0zeHeaLkGS1p6lUJE/VYLEikellRK9rq89L2RjqQeGUxW32s
	4IYFXHLQpFHw1LPupuRZ03Nu/E66ghaYbvKemQXuFO5+XMvzeytXARLxoHkqk/ik
	pkW82LVqLf0urlBhsx2vSuKLPgNIVH7aXbphl5gc9JXeIOP3ozYt8tuXMxoGjZdS
	IEfHAIsEZv0AHYAWVaMgoA66sAmHhsrCEG5+mcdjhDyfi9BvyfXFjUDyKg2DLHqc
	IjmtjPRXmc2xchxoe7eQ6g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4a8bw7sr15-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1762390903; bh=qSJq/8BWxF7N+3LN2PPfMi2Qz8W27SXnXfef8LzJ3D0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ade9jkgLqD7UoiPNm9VBZ9DEhWp+HlR89c3U3UhUsn6Cggj2iYw0yj8XlZyC9e8Ag
	 GyjBDlyJkZS7ZL9gcercB/VTqwspSdQkY08KZQVcusMc/Hq5eyyEg1E2+gabBm5SvH
	 HD/UTQVMGSXVIrg6VgeTFt1zd0bASnncXZScs59IoZEtnkCN7DoDG/XhXQimsOx7g4
	 WEA1xAcCCtoL5Q7fae9tJvmj95K4+XB557PQzLoSEaKk+H84XwcdbQxRReYuJIRMmy
	 aoLSbypqlow4T7YJkqZ/qF7czOWpt98mbn6IxA+07YN8NZiv/DX/KoJQUJgx4Zi7UG
	 qBbSIU8wQcCQg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3FADF401EF;
	Thu,  6 Nov 2025 01:01:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A3C1AA0072;
	Thu,  6 Nov 2025 01:01:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UH1hXhV5;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00101.outbound.protection.outlook.com [40.93.14.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 05963220154;
	Thu,  6 Nov 2025 01:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgfEH1tiOy5euoxAbwJvBmFXVUqcreX2OsCVPIvDQy8eqN2mDCe6ZSwL/hx7Uq5LW+Cl6LR/29sB5ib7LOxgvNxNO9yLKvn/qiMl9rEqx2YzBJLahpW3XzM2JACiMFFtLaWL+25ttNf+z1oEyhjWU11ByYT3ui1gJYr/pupcq0ifdz1Uhn5qyFR50rfvS16l3zjB0qx05hnqpF8z8Opt8CdW76UfhJZVdVa7jMe6y43oGvGHxBuDE5+7D5XX8QhsCyGwlK2Zts4AyVZb0r3260OubJhLnVP6QR3rWHSmwXf5x1HwPiy21mguZkRNw2lRYwRq1/SZuYWGlhabH4Jldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSJq/8BWxF7N+3LN2PPfMi2Qz8W27SXnXfef8LzJ3D0=;
 b=TZEZ4Ly75kieF5VaARgpbFT7pbseu8AzyHclMHRB+EUeUPOCLlmzonru+m+o2udKrKPF5M9vu94Kwfx3atQ29L85xoe3cBV974PM7SjXOftKpxC/xi8ZSxPECukfQ0jwaWislhXUiLTcpUDsX8BLF/dR7Du7BnZdQj42FiXziyP5rp+tRgV+N7+3xquFy5c/KipbSNZmp0DIMwY4tPr0sm3sitfXxpiJWfW1P0s1A1Pw/EmbuEYRlo1QSZR5y4EdLno3PohloVnyThvdzzQYm/mkW/+c3xPP/RaOI+k9CMdb45QdgZZthfodguFO7rvIwSwKfNewJRMywfyHg2xCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSJq/8BWxF7N+3LN2PPfMi2Qz8W27SXnXfef8LzJ3D0=;
 b=UH1hXhV5Dd7CjGd6Z+Y6ZJkTFD/+MiVOLNSqeJqJy9IqPj3ALdZYdrc64IONrc0c+c+MDXU8I2wFJmwO5FZrR275B1vVX3oDtgCNvRfitJI/VGWBBt5t45qeu5q5Au+j67lPnK9Qet4Re6hTmuAeiTSo3qM/xI36jvNg+Rw/NsI=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Thu, 6 Nov 2025 01:01:38 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 01:01:38 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jamie Iles <jamie.iles@oss.qualcomm.com>
Subject: Re: [PATCH] drivers/usb/dwc3: fix PCI parent check
Thread-Topic: [PATCH] drivers/usb/dwc3: fix PCI parent check
Thread-Index: AQHcTmShQYDNAvROeUibELkim1NKY7Tk1POA
Date: Thu, 6 Nov 2025 01:01:37 +0000
Message-ID: <20251106010123.mbtqd5epssrpbawv@synopsys.com>
References: <20251105145801.485371-1-punit.agrawal@oss.qualcomm.com>
In-Reply-To: <20251105145801.485371-1-punit.agrawal@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: 89fcd948-87b5-4d26-d344-08de1cd00a1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dW1ZQjBSZmZjUld5Mmx5UU5tM3ZaME1XYTBnOEttY0s5ZWIwUW5rV2x6dTYr?=
 =?utf-8?B?dVhwUVVxOHA5LytyVXZBRnJzL01KZkRUdHl5eklvTzRVZUxCd3VxL3gzamYy?=
 =?utf-8?B?QmNSVEVsa2FWemVjd095dVpreGEwWnNrSTJrMGRNZEhLd2RIcExZQThSYXZQ?=
 =?utf-8?B?MmhsaVNsa0Q1ZldweDhPL3Bvc3NkbnpXbEhtNS9nV1owQWNDREpjS3hRUk9a?=
 =?utf-8?B?T3pSdW9MdThOVFZudHdMd0hSa3B1N3Z2QWhUbkR3bGpwOXUwWTNOeDc4SmtM?=
 =?utf-8?B?cFhwdmFwaHRybUdLUmdnZVRmd2RmaS9aZVhUWktQQXpVTS8zK21DMGdIWWsy?=
 =?utf-8?B?clprNGhsY04xb1dRQmVoQmVMUnVrcFpDSUNjNTBnQmpNNGxEL1BMNDNDM1dj?=
 =?utf-8?B?MW5QRnd5UERXUUZHcnV2LzJrbXp0cklTUTIxeEhqZkZwQUtoU0s0SDk0R3Mv?=
 =?utf-8?B?UW51UFF5L2lhMlNTVnhaS3h4OUdsMU1mQUFlK0FScml1VW1tb1lET0ZRU1Br?=
 =?utf-8?B?OUgwekd3d1M2WjZJOUI4bGJYcEtMQWpFMGpBdnBxTm80WWduWTBrUjhpT09X?=
 =?utf-8?B?a3p4WUVOOTBDZWh2ckgyd05GaytIODNaUW1TUTVSeTZJR0NRd00xTy9WMnJF?=
 =?utf-8?B?M3hRUG5KRlhIUmdraG9aZjFkWmNhU3JJTDlzWHJsaXUzOWJESkJKdUdrby9S?=
 =?utf-8?B?SE9aWjc3UnNXQ2FjOUlTYVVRVlZoNnc2c3lZZS81WURVYlNwcGZidjl1Q0w4?=
 =?utf-8?B?eGgzUnVUS0h4NERYbVlnL2RBRWtNMTNOMndqY1FUMHJPUFVKdFNtUzBPRjBl?=
 =?utf-8?B?Y25mNkJ4c0plSW9ROUw0VDBST0VmcTBHcER6dlh1VUJub2VtMi9XRVozZEJX?=
 =?utf-8?B?VmRQRGg5bXpjTVVBbnFwbzh4N3ZJQVJwcFl2UmVPOU5qQmczYm5mQVhYOU9J?=
 =?utf-8?B?WEJmcHd6MU9WdDcyOUNuSkNDTVJMbFl3cWZNZC9YVE41azV1anJ3cFVpRnVB?=
 =?utf-8?B?TTVuUitzWVJIL2l2Wm9PVDF3UmtFY2JDT01jOXRBditESGdaRjRRTXhFbENp?=
 =?utf-8?B?eUQ4SVB6d0dsU3pBanMvVTcyQW9PK2w2ZXIwOWJYSks0ZDEyRXZiUWQ1NnFT?=
 =?utf-8?B?MDFFUDJNWVhKTEFwSzg2b0s4WngvOHZyN3RNSTI0Y1djcThEWVZoeHpWSmxh?=
 =?utf-8?B?emdpM2NVWHpVbHNueHVuak9tVzVvYUd0akgrUDZOVDhjMWp2VEtITXg2Wngz?=
 =?utf-8?B?NnhZcFBDNkorT0hsRFU3MlhOYTd3ZHFjUnovUFBrY0hYNHc1ZDRia3NxMjR4?=
 =?utf-8?B?NWNMNkZhVjNPYmgrdnBXNm5SYVJtZGI4U0N1dkphL1M2c0x6NTJsVUtUUURx?=
 =?utf-8?B?Rm04RldQUkZub3NtY2V0azFycXJVVC9pQUdzWnhrWitheXpRNHJOZUlkMlh6?=
 =?utf-8?B?QVk0aFRRSEhHeFNnKzNLTGV3VkpUK0U2VzM2M0tjOFdDTm4xUW5rNW9Mci85?=
 =?utf-8?B?R0ZwN0VPd3dZRHNMVTlJcmJJYzBNUitXU0srMGVsclp5L1hGN2N5TDM5NmZE?=
 =?utf-8?B?RG4zdVVzeDZydjhWMk16c00zallCK0xHK0kzRFRQdWUyNVhmUDBpQVdSS2Vo?=
 =?utf-8?B?TmdpNk9wb1ZmekduN2NOYzduNm5mbmlWOFJaRHg3L011TXZDOFptL01DZVMr?=
 =?utf-8?B?M25OUGhRenhSNWR6V1VXZzNTcTduTExybmFOQllLMHZNSGZ0WXNyYTk3Snk2?=
 =?utf-8?B?dXR2Y2hLVjZHVW9sQktSODB6dWpvNXVqclF3L25scUpDMG5sTHVtWC9aanFJ?=
 =?utf-8?B?SUFIM0xpWXpBVVRlYTJHc3lNdVJLL0JKaU9hZHNHTkZoVlQvK3pkK0tsNFhm?=
 =?utf-8?B?eWVaejI2Qy9wZmRva2M1a1h5L3BKREJvc3hJZGdXQnpIRGgrY1o5dSs5eXdi?=
 =?utf-8?B?dXovR0phSHI1WHJyWHRkYjNOR0plKzNsWTJlbDVWbXVkcnVUSFpRVFBDVGFR?=
 =?utf-8?B?cENvM09RaVorNy9SZFdzeVo5VmJsS3BUWFZrZDVQZFE0QjVoWmhIWW9EcjJB?=
 =?utf-8?Q?dzr54S?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjZmQ2M0NncyUGhkUWZrNVlxWGJCVjhtUDlNbHJvZmkyZDdyNWlsSHJzRlR1?=
 =?utf-8?B?Z2Y4dWxaVzl0cm5Lbk9yRXFoQjJNTEVqdWZodmFRTXQwcGZCdm5pUXhFTGh3?=
 =?utf-8?B?MFQwaTBhOHNYVVpJbTE1cmtCQ2xKRS9EemVVTHQ5bGZWOFFDMWVQNUxkT0Uz?=
 =?utf-8?B?UEFrWTZRdld3Wit6dnpwZ0I0Y3JxU3pKU1E5SmhmZjZ3VDJxWkFaS2RkYkVu?=
 =?utf-8?B?eEh4MXU0TzJYc2VpYnJRU2QrY0pJRXA5bjBwNldEQkVUQ1puSitKZEdSbEZB?=
 =?utf-8?B?Nm9LTjJkd1htUlZ2ckk3ZjZsTWw0QmNkNEJ0YmhCU0FoWlgzcVJxNUhiYkh2?=
 =?utf-8?B?RWtXSFMxdEFGV0dUNExzOGVjblVhaC84aWxxWEZqUWk0MWdxTTZSNTQvbkxW?=
 =?utf-8?B?UUl3d20yNnFQYmZ3eUh4bUZXaVBiaDBtakI1dWJSSlRqMmRrNnFMZkN2WGhF?=
 =?utf-8?B?dUJBcWdBZTVZZXZzTWFnM3dSQkFTaGZBZ0N4RVJWZTVaM2daOUUxUitvNkpJ?=
 =?utf-8?B?anFaL0xyTnlhaUtLMnBpTEdQdFU4LzFyc2FRL251bkRtTjlVblRNSzFrTDYv?=
 =?utf-8?B?MmpGMEc1R1FqSEdiOElxaE84dTc2ejJzVUhpV0I4Z3ZWaGNkdE1KbkUxTXJO?=
 =?utf-8?B?MHhGYUtlT2o5WlRVbmdFNnlLK0R2UkpiN0poa0xpRlRoUnl3UUdxN2FhUFFO?=
 =?utf-8?B?RVBvZGhXMmhWcms5bUlKY3Z2REN3dDY3WmpOT043YVdCNmM1SXRwSDVoSUhx?=
 =?utf-8?B?TFVCdytMWWJPSTJhQysxVytwZTh4bGZJakl3V2Z6N2o0alBWYjQ1ZUZvclgw?=
 =?utf-8?B?dVJlVDQwcHI3dFFVSlN2UllKaTQ4QWRFVDluY1NjUWlCNm5VeC9kQXN3S2ls?=
 =?utf-8?B?Ly9YN0pzb1lwaUI1RGhGYW5WdlREK1h0V09Sa0Mrb1JlWVRRV2ljUUsyNmxN?=
 =?utf-8?B?bnNDcHVSMXJCNDhBUVgzdHl3ZDdDcU9SS1FzT2pTTGg5R3NuMEoyTkUzaCsz?=
 =?utf-8?B?eUlMS3A0NjdHbjZ0Z1Nwazlvejc0Y3BxYnAvVE85QStEQ2lhZFFXYzd5ZHZ5?=
 =?utf-8?B?ak40UFlvVXJ1UjRzR3kyNVpMTUZSMXRUQnBQVlB3WGh0MW1jU2ZiZytacGYy?=
 =?utf-8?B?VzJBMU1KQ1RKWU83UXp2cTFJUEp5UWVBdXRpTjdscStMUTRhb0w5VFVTVFY2?=
 =?utf-8?B?WnByQjJnUzNGZ3YyWXgxTU1BMXdRblpZR2hjN0krVmxGSysxTFNXWmo4N0RO?=
 =?utf-8?B?Z0NCV0MyeXVGSWsvYjB0T2lDRFFxaTgzV1o0RDF1S05yakhjc2c2d2Y5elkr?=
 =?utf-8?B?Z1JhbTdsdWJqLzFmTGNCMDU1aDFqemhrUDluZ2tjNDdrUS9FUUhUS0krV3Jr?=
 =?utf-8?B?NkQrMnVRVk5hRGsvLzc3QlcwdmJoSFFxVTRNSnMvZGc0dEEzcTRyUi9uNlQ5?=
 =?utf-8?B?S3djS3lYZTFRRTVBWFJyWjd6YVB0Q0JXTXQrWHBGS3NZUFZOOGFxWURXRy9N?=
 =?utf-8?B?L29zTFlxT2YwSXFTYlltSmtGREFDVk0wcFFWOWxwR0drdk5ETmFIamxjR0NO?=
 =?utf-8?B?S3NzaFA3YzV4UUw0NW1PSFVkUm1jNzhWRVZEZ01vbWRmeC9qelJpTHduTUhP?=
 =?utf-8?B?UExZaEFZVkZSUlBiL3dUbnhtZ1o4NE9CTjlsZFVLYXR6VUhNKzZJUEMxNUdv?=
 =?utf-8?B?SFo5eWNzODNBMnptSml4YjliQ0VqYWdsdWtVa3VSbi83TDRqWkdxY1NPWDha?=
 =?utf-8?B?YTZQdk5BaEcrWXlMV2pObFkySXowZVdDcWRlVnFGdVpNLzRrMklSNU15cTVh?=
 =?utf-8?B?REM1MW9LekwwTGI3aHdlSkp6L05aOEpyNnk1QkVQeHFqMWVKV3ZIcXlLSlcx?=
 =?utf-8?B?S2NkbGVWeEJRZ2RSc0kvYmtQZytwMGZSM08vVE1NRGVua05sejhRRnZweDZp?=
 =?utf-8?B?M29XazAwMkFZUEplY2dWbFV6Z0N4UkdEcGVKU3ZyVDVxZmlKUlAzZk5ybkRM?=
 =?utf-8?B?aXREL0FVSE5Lb3I1bVQ4amw1czJQM3NHV2FnckRrQkVySW91OVZIRTFuN3ZM?=
 =?utf-8?B?c096dzZUaW02Uis2aFVVMno0UndvRGZZOTgvVjk3SU9RNFhqem8rTlo3SW9p?=
 =?utf-8?Q?EzOCEJKIdjAGu+52guBHFzmuX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA856A8A30D084582133880A0ACCFB2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qucJcauVBe5uU0AoKyEM72PrvzIgqrT7ehYe3+np3kozUxSwo6WitR9B5c8txoOGYSfCgYWoGfd6nu6K+R4hcLh51H9qu6VcO9ttDm8r+2/Kc94RZtaIbguqcHxSs4iY497TwMxJjL1jc5BIOpsXx2gmNIOhnUrADtbUuymIjdzsD0PfrELs67rNm0qRRatxd0VDzn7u51QB9oTi9y4wkiIwqobnc4EijJyNFGTR7I+lcw6iAtJD0rzDrRdfgc2r1dx5+WIrUnFw1R3uuo7tuQLz7vD8l+Wnj6dpAnKOD7Ip/6ByiuXJ8VrV7mg8batCD4ca+I5yJMkakffNr+dXXLtBzKnAhekCmWt2Ts1YXRMgzIKF58lEity9gjGiMpCQDJJLQDJfbLclVcDTb6gmcXSUhYsjk/3Ggx05jSZVmuMVZtTLPBhcGm5tQ6VLuHupmCM/6HgD2cnKecxHDjA/W5wN651aVIxkGctyNuWQvVwRDlEZHHhRIw7uwLxQcvGGQwK3dbXqpkB7l7QOo/VQ3ZGzWgfC6pCcx6dwOen/81jRMnUULlHQJhDMHuff2zsk3Cg0kHLPP5HpMrW9CarEr52nkvQNgia/tbfBEo9IzVcub3bWW2SzMEHZqj3gYbSoclj8QBbO4j+aaz2kMSPIIA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fcd948-87b5-4d26-d344-08de1cd00a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 01:01:38.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ys2pmg6OvdkloI6GkBFVdryZ/XYUCcdcPIZsVTU0G6pRvLnvuYE2ala9F8trvIIQuFeHYjgVupewBpLBpV8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
X-Proofpoint-ORIG-GUID: hgXbmXHZV20CdpJW_KZL_nToQ3uNeAE5
X-Authority-Analysis: v=2.4 cv=D8pK6/Rj c=1 sm=1 tr=0 ts=690bf378 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8
 a=rRX8rE5sSMJIN-wnoHAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAwNiBTYWx0ZWRfX/dhyCRYWcHY9
 xjdmeoiwx0igXlEC3ZHKIxWBZBW51/wwEhhyZ56m9GlXStFSUztMqBp0konOcVHHu0QQPsoQAyF
 8hXl/dWyuC5iM2vitHQ35cw2UAQmpNEwkLuPkl6RgrRahM30ehkhocyHe5ovdkZOoPkC9GO1Ynm
 zy8pvk4Bd12C3EzvmGM43Vmb63/rHOEvwcwDpZ6GIDB/HMyeN7TwiVe6cD+PUqKW7E6pWTnAsE1
 HUCe4nGBHCJigoUu4Y///uSjgHQ8bSgYvofOHXtKJvFXpfawalvjYqbS/W/VXF16HI8YW9pbHjy
 DH8pRXpCVddE+qEPHs2CawRnjHxQwNLq30NuWNO5xte4sMdsp0gBnO8xcEtNeOYJn9tgoNPtutg
 JhIgAM2/HSLt3BUZ+WyFFklDF4EBgw==
X-Proofpoint-GUID: hgXbmXHZV20CdpJW_KZL_nToQ3uNeAE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 clxscore=1011
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511060006

T24gV2VkLCBOb3YgMDUsIDIwMjUsIFB1bml0IEFncmF3YWwgd3JvdGU6DQo+IEZyb206IEphbWll
IElsZXMgPGphbWllLmlsZXNAb3NzLnF1YWxjb21tLmNvbT4NCj4gDQo+IFRoZSBzeXNkZXZfaXNf
cGFyZW50IGNoZWNrIHdhcyBiZWluZyB1c2VkIHRvIGluZmVyIFBDSSBkZXZpY2VzIHRoYXQgaGF2
ZQ0KPiB0aGUgRE1BIG1hc2sgc2V0IGZyb20gdGhlIFBDSSBjYXBhYmlsaXRpZXMsIGJ1dCBzeXNk
ZXZfaXNfcGFyZW50IGlzIGFsc28NCj4gdXNlZCBmb3Igbm9uLVBDSSBBQ1BJIGRldmljZXMgaW4g
d2hpY2ggY2FzZSB0aGUgRE1BIG1hc2sgd291bGQgYmUgdGhlDQo+IGJ1cyBkZWZhdWx0IG9yIGFz
IHNldCBieSB0aGUgX0RNQSBtZXRob2QuDQo+IA0KPiBXaXRob3V0IHRoaXMgZml4IHRoZSBETUEg
bWFzayB3b3VsZCBkZWZhdWx0IHRvIDMyLWJpdHMgYW5kIHNvIGFsbG9jYXRpb24NCj4gd291bGQg
ZmFpbCBpZiB0aGVyZSB3YXMgbm8gRFJBTSBiZWxvdyA0R0IuDQo+IA0KPiBGaXhlczogNDdjZTQ1
OTA2Y2E5ICgidXNiOiBkd2MzOiBsZWF2ZSBkZWZhdWx0IERNQSBmb3IgUENJIGRldmljZXMiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBKYW1pZSBJbGVzIDxqYW1pZS5pbGVzQG9zcy5xdWFsY29tbS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFB1bml0IEFncmF3YWwgPHB1bml0LmFncmF3YWxAb3NzLnF1YWxj
b21tLmNvbT4NCg0KV2Ugc2hvdWxkIENjIHN0YWJsZSBhbHNvLg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggYWUxNDBjMzU2Mjk1Li5j
MmNlMmY1ZTYwYTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0yNSw2ICsyNSw3IEBADQo+ICAjaW5j
bHVkZSA8bGludXgvb2YuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGluY3Ry
bC9kZXZpbmZvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gQEAgLTIyNDEsNyAr
MjI0Miw3IEBAIGludCBkd2MzX2NvcmVfcHJvYmUoY29uc3Qgc3RydWN0IGR3YzNfcHJvYmVfZGF0
YSAqZGF0YSkNCj4gIAlkZXZfc2V0X2RydmRhdGEoZGV2LCBkd2MpOw0KPiAgCWR3YzNfY2FjaGVf
aHdwYXJhbXMoZHdjKTsNCj4gIA0KPiAtCWlmICghZHdjLT5zeXNkZXZfaXNfcGFyZW50ICYmDQo+
ICsJaWYgKCFkZXZfaXNfcGNpKGR3Yy0+c3lzZGV2KSAmJg0KPiAgCSAgICBEV0MzX0dIV1BBUkFN
UzBfQVdJRFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKSA9PSA2NCkgew0KPiAgCQlyZXQgPSBk
bWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGR3Yy0+c3lzZGV2LCBETUFfQklUX01BU0soNjQpKTsN
Cj4gIAkJaWYgKHJldCkNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5n
dXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KQlIsDQpUaGluaA==

