Return-Path: <linux-kernel+bounces-882510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1E2C2AA07
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971D04ED9BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1782C2E2665;
	Mon,  3 Nov 2025 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hiz08kzm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lsv73VB8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739222D7B0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159586; cv=none; b=c1tC/7ttHGbJOatAGYQZkEl24AkuwihbdUz65ZEBtlJniG+td6TEgGKFG8M74xjtRthXkm49Y50e3Q+4nXfAOnlKGz1y8ulHOcxtNVia1PW6k1ZkfbhbZBLinwQVZXK3oZfLq8oCx1mHs7qyjDWE1jHg0af0SIieKypgQIYmLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159586; c=relaxed/simple;
	bh=y/ELsGoQRx/77hAwju674gD83XjXik4zpyWUo4gyCe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tauN8e2f4mhZCB3tsEEVBSwQiHkbFSS5hclggVAM4CdKaZQ90HhfdCfItInrnAf7RQ5ZyjB5JXpgVWLRyai9dI1yqjdsQWcO7dRNs6ZPJsQrvssyTwdbbB5h7vPCFIA7qnxR8vItg4pABpHv93dfSE468mBo37rqlXqCXOLFAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hiz08kzm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lsv73VB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2MhbE31457857
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 08:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzXaWMKM6uuZrMgRFGjIfcNECUOqpvMFvxCNHdhoY6s=; b=Hiz08kzmEM1kow10
	RHDAms7fgCz/INJ4ZfY754RBanZcKnHOC/qJdICKLQuUsCqvB6H6DskcsyD7lamf
	WrUgK85JfTF/yiFvAOcNR9gnkIubbNceV8d1CpXoCPrpz3v7JKLX2rv6tSNGE6xD
	9RvXkUfvcKAwQF3SfJGqpHdxt+QjjSlKYB6vaQ6NM03d18WqOuburYfAz9CsworB
	nkS086Azg9DPd0TliOgmuQzonUpgZEAC15BnTMaVPpk2kRbI2SVbAcQyCf/2+ucm
	VoMQGe43F5pSvIQuMlwZyeY1/a+bYOwjM3Vs6eWpRhnzTgQFRvgo1cRs7tzLkb4s
	vfoXtg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a57jn45p4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:46:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2952cb6f51bso70385115ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762159581; x=1762764381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzXaWMKM6uuZrMgRFGjIfcNECUOqpvMFvxCNHdhoY6s=;
        b=Lsv73VB86hJDIcze6y08MJy5aSc9NM/A5SCjSp/ckHjMUYrElfaC6SzhqmAtj4NOXV
         /LxXPqH/ugQs24bSQptTW/EoMkar50CmsaVcyxhH15GhJVK2uv82svoH+DegDf/LAVZb
         dd8tbCQGIDzYuFZyaDbepsH3txZqz4wrgIJ9Xn7mcwyK/Sm9MOjg+j5uNWD4FpHUjFWE
         H6sqO8OCIhXSGEvZyWsray8T8g68fLYYZiLYgEJr+bQAQYn++U5ImckhJ7aaCkqKruQt
         h7U4kd2tyJxE4A48HQ8fUscKJdLJUlR20OapBXP5LB8An7r8Zpz0mXJ8tiYqWo0xtwxl
         SX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159581; x=1762764381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzXaWMKM6uuZrMgRFGjIfcNECUOqpvMFvxCNHdhoY6s=;
        b=pFenaD6dyOxRGczRL9s9XJ/SBoXAy1c9K+fxyR9XH+Aybmf+X09HWDuaZjHKNEA7W/
         Rm0IWbm26S81z5ZRHi887IZBv5CIEl5aQWBtbu7qw6OoY3XeD7Og9ihMl9XSkhe26wp2
         IUqdjNVlTzuzr9hMpnQO6wO8pUrzKmjPypEnsGDizYnX0ApG+0VWkpimjDccPF6z5/Ei
         h+VQMS6Ky7NoRb8S0tg6j4rG5nQ+1gbeh+1C6t0hQiPFLbvJG+CfQQR5zoiKQseG/eKY
         L2cVoKNEM4IdgTDUd5i3M5VB+zKslWiaDSTMj7HFGzcoTDgzvI1jI11m9dpiUBGG+vtX
         lyMA==
X-Forwarded-Encrypted: i=1; AJvYcCVTtuocCkeB7jLJc7FvUUV75d7EPYmoiCCyNTsNv9t0rIu8YjvIByCw3f3bCPH+4GG0qOkodXeao0N5Jhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJdeMgFjUwtFWLJ3Y4Oaqb38y9/bBqiCpj1tG9+FcmHj2vs8Y
	qp3uGwLanxpAk4deyI0kVdhpDLubgNWes3uZRy6l/7APZH2DEztdat4Rr1w59epeSdNK9A16eRT
	XdtjeYmVBLdSRcYuhOlT03wMwzlMx+V7ZWnXUWSUVkxWqydcwQ4M+DXl79P6TNV6GhwU=
X-Gm-Gg: ASbGncuYdI5hw5Uo4OgmegsBnaLgWdKcooHk7ED225cXJ0RUe2VkmDp/Ew5O8vCzxkl
	A20LdUxxgwJAX2s47+61nQh0SnX95kPiUvM0nidVzAdvOnXqpX8yyz2NQfaeFxRTF7OjcqlwWN6
	VpBvSxj3tlyJyDyeun44+5X5BW037v8fFqxHxRfnSk7wnnb8+yQD4yZ806Ya/SS0Fek60wAcnWP
	yBK0FbSXsvOMux5ZRFpYi9dPvJP7dc4fZXdph5dFJZ+A3K5lQqZ+W1nFUcoqv9gP6wymT3nyWiO
	/LNIe0plSv22oTTtpJzQJdzgjPe3kL4jNh69CO/3rEG3JSbAsd9cNWbeAJdEp+LsB4ccK0tu3ar
	5x0nZCDy+6cldjNl209+W16Dx0mucQyLxf6GdZHU/did35luvX7hjFNVq5VSdHOBaSIc=
X-Received: by 2002:a17:902:e845:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-2953d5e059emr124468295ad.41.1762159580932;
        Mon, 03 Nov 2025 00:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmiuoA9oItdNbWpsoxdg8TQql7oPA9lHawbw/4Efm2CYdb1fZmLHawrt8VA2IXB/QVz+ha2A==
X-Received: by 2002:a17:902:e845:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-2953d5e059emr124468055ad.41.1762159580401;
        Mon, 03 Nov 2025 00:46:20 -0800 (PST)
Received: from jinlmao-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm203948a91.18.2025.11.03.00.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:46:20 -0800 (PST)
From: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
To: mike.leach@linaro.org
Cc: alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
        james.clark@linaro.org, jinlong.mao@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_yingdeng@quicinc.com,
        suzuki.poulose@arm.com, tingwei.zhang@oss.qualcomm.com,
        yingchao.deng@oss.qualcomm.com
Subject: Re: [PATCH v5 0/2] Add Qualcomm extended CTI support
Date: Mon,  3 Nov 2025 16:46:08 +0800
Message-ID: <20251103084615.3666468-1-yingchao.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJ9a7VjTqBczkdMYXqb1WmDRUYhC--dY6Ky5R=NfUZaYkiWmVw@mail.gmail.com>
References: <CAJ9a7VjTqBczkdMYXqb1WmDRUYhC--dY6Ky5R=NfUZaYkiWmVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=69086bdd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=G5yOyA2rPUBNX_wBb9gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: S0VChSH5h80w6o_8zsPBu2xRwXpD9MlU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3OSBTYWx0ZWRfX9x+l5qALUXL8
 RT48DJivg7aggFJ1AEZRO9XA4TuFlCovPZp8KZGfE+unUIgLOGVAeLa+nBo4n92gr7fpEd2tRa5
 p4GqeaSouy+fDmxCUodoKnWN8v/ooM5zJSJtDaT0A+wBiJubZfiTkz6JUPc75YYKk7QNh8nIeVJ
 luzIPUZSgM8dhx80+GlVHSPc0r0Fo7VAEZvoHPLXXIO+7DnI9CpsRRvKmH4OK/YC6YdqHXGyZU+
 EcSX6ExpiWkA07kcDpR9QCdDPmHROFSZUVI/gQLAIlCRL0nq0kDmQUXJaxMiI4kJqqhoY3GX6AS
 DRMqGH5cPgCYUUbAtZzSNEom+gW1eaCqmvrC+hrjPUXkYnH5uPIaxiLuJXb3gsn6ebdfaITIHHb
 2ImjpPgcQvRRUHYZnGZoti12XHCXYw==
X-Proofpoint-ORIG-GUID: S0VChSH5h80w6o_8zsPBu2xRwXpD9MlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030079

>Hi,
>
>This set is looking good now and appears to be getting close to being ready.
>
>There are a few minor issues in the second patch and a few items that
>need to be confirmed.
>1) I note that you removed the code to prevent calling claim/disclaim.
>Does this mean that you confirm that you have tested the patch update
>for claim tags I posted works on your system?

I just tested this patch, the default value of qcom_cti's CLAIMSET register is 0xf,
and unlike the standard CTI (write 0 is no effect), it can be written with 0. 
So, is it acceptable to write 0 to the claimset register of qcom_cti after reading the
devarch register during the probe phase?

	devarch = readl_relaxed(drvdata->base + CORESIGHT_DEVARCH);
	if (CTI_DEVARCH_ARCHITECT(devarch) == ARCHITECT_QCOM) {
		drvdata->subtype = QCOM_CTI;
		drvdata->offsets = cti_extended_offset;
		writel_relaxed(0, drvdata->base + CORESIGHT_CLAIMSET);
	} else {
		drvdata->subtype = ARM_STD_CTI;
		drvdata->offsets = cti_normal_offset;
	}

>2) In patch 2 I made some comments in regard to ARCH values - please
>confirm that these are accurate and have been tested as working on
>your system

Yes, the bits 31:20 in qcom_cti's DEVARCH register are 0x8EF.

>3) As mentioned in the comments to patch 2 - you need to update the
>docs for the new sysfs selection file you have added

Will update in v6.

Thanks
Yingchao

>
>Thanks and Regards
>
>Mike
>
>On Mon, 20 Oct 2025 at 08:12, Yingchao Deng
><yingchao.deng@oss.qualcomm.com> wrote:
>>
>> The QCOM extended CTI is a heavily parameterized version of ARM’s CSCTI.
>> It allows a debugger to send to trigger events to a processor or to send
>> a trigger event to one or more processors when a trigger event occurs on
>> another processor on the same SoC, or even between SoCs.
>>
>> QCOM extended CTI supports up to 128 triggers. And some of the register
>> offsets are changed.
>>
>> The commands to configure CTI triggers are the same as ARM's CTI.
>>
>> Changes in v5:
>> 1. Move common part in qcom-cti.h to coresight-cti.h.
>> 2. Convert trigger usage fields to dynamic bitmaps and arrays.
>> 3. Fix holes in struct cti_config to save some space.
>> 4. Revert the previous changes related to the claim tag in
>>    cti_enable/disable_hw.
>> Link to v4 - https://lore.kernel.org/linux-arm-msm/20250902-extended_cti-v4-1-7677de04b416@oss.qualcomm.com/
>>
>> Changes in v4:
>> 1. Read the DEVARCH registers to identify Qualcomm CTI.
>> 2. Add a reg_idx node, and refactor the coresight_cti_reg_show() and
>> coresight_cti_reg_store() functions accordingly.
>> 3. The register offsets specific to Qualcomm CTI are moved to qcom_cti.h.
>> Link to v3 - https://lore.kernel.org/linux-arm-msm/20250722081405.2947294-1-quic_jinlmao@quicinc.com/
>>
>> Changes in v3:
>> 1. Rename is_extended_cti() to of_is_extended_cti().
>> 2. Add the missing 'i' when write the CTI trigger registers.
>> 3. Convert the multi-line output in sysfs to single line.
>> 4. Initialize offset arrays using designated initializer.
>> Link to V2 - https://lore.kernel.org/all/20250429071841.1158315-3-quic_jinlmao@quicinc.com/
>>
>> Changes in V2:
>> 1. Add enum for compatible items.
>> 2. Move offset arrays to coresight-cti-core
>>
>> Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
>> Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
>> ---
>> Yingchao Deng (2):
>>       coresight: cti: Convert trigger usage fields to dynamic bitmaps and arrays
>>       coresight: cti: Add Qualcomm extended CTI support
>>
>>  drivers/hwtracing/coresight/coresight-cti-core.c   | 144 +++++++++++++---
>>  .../hwtracing/coresight/coresight-cti-platform.c   |  16 +-
>>  drivers/hwtracing/coresight/coresight-cti-sysfs.c  | 184 +++++++++++++++------
>>  drivers/hwtracing/coresight/coresight-cti.h        |  60 ++++++-
>>  drivers/hwtracing/coresight/qcom-cti.h             |  29 ++++
>>  5 files changed, 346 insertions(+), 87 deletions(-)
>> ---
>> base-commit: 1fdbb3ff1233e204e26f9f6821ae9c125a055229
>> change-id: 20251016-extended_cti-2a426c8894b1
>>
>> Best regards,
>> --
>> Yingchao Deng <yingchao.deng@oss.qualcomm.com>
>>

