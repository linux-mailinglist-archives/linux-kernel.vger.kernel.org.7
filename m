Return-Path: <linux-kernel+bounces-775833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21756B2C581
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768A93BAC8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08758343D91;
	Tue, 19 Aug 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="v5ardJpZ"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4B2EB870;
	Tue, 19 Aug 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609621; cv=none; b=JKShK2Ilw27kHBHbybQM2SufcaapZUPOmmthcaPU5fPc3E1AwTtEgYBlXZYbCEitfs8CRHlRTsMLyUq36sJ3pVjFCtmuSxO/hphWT8AYuPNgVZmyIMqW+yKz0QnxERWsrhjMGgKZHNVcMGaEA/SwqGQwMgMJ7nrDTlwj3CifHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609621; c=relaxed/simple;
	bh=uv/4X/cFd8+irEIHWhzikXZzeJv9Ltt2PTJn9rMlmks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ctg/VEH0ty7+BzOkLqe00bDeeitxqHacmSkaBYCI56R50t8WuLLmgQiTv7qEbGC2MPa4ALxN1ftnWrwmiyJWL/jOP54pR6GfRmbah4GS3yuoB+z3PORnZYWhYpR+H94JBAhBU//r/jZkj7O9yCMEDjFEt3i8oeTvz9ReNxJcn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=v5ardJpZ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JC1ZpJ008923;
	Tue, 19 Aug 2025 15:20:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QFvqz+B7siHkzQW6WosQ1OICBHcfdz0CqDSUjuLlYg8=; b=v5ardJpZoJ/NvqNX
	f4jxy8ZwgZYVTCJ1sCgIFZtE7m97VwKq5re3ao20inrRsqD7XZvG+zyXzn6Dz45t
	gb2J10sr4S5W1yKGivcA8affvQLkF08RUucTuB/LR1qX1g+gT0fE38LtsZDZ1m/F
	PKW351mdlAzcllWo5H0ChiXyW910ZnOSJMNdOKR6jzmRCn9m5AaqgPw1s6805YiE
	GuDNNIalignEyZgHlHZCUO2Kzj/Vcsj6MruBIW7UDSNWlTse6eRzvtf6pyHukmWU
	qwOZ0gd+xGksY5DQ9H3jgkYo4oGkVG2LZ7s213qfZk2t2UB5moYa3O/CzKKMwK6+
	kUVxrg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48k4xmrrx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 15:20:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B499040047;
	Tue, 19 Aug 2025 15:18:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C12A772BD5A;
	Tue, 19 Aug 2025 15:17:47 +0200 (CEST)
Received: from [10.130.74.180] (10.130.74.180) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 15:17:47 +0200
Message-ID: <e144225c-e0e6-4d3e-a4d8-e4c48cdef3f6@foss.st.com>
Date: Tue, 19 Aug 2025 15:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] dt-bindings: display: st: add new compatible to
 LTDC device
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Thomas Zimmermann <tzimmermann@suse.de>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>,
        David Airlie <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Simona Vetter <simona@ffwll.ch>,
        "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <devicetree@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
 <20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com>
 <175560127037.3969097.6130940505156039734.robh@kernel.org>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <175560127037.3969097.6130940505156039734.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01



On 8/19/25 13:01, Rob Herring (Arm) wrote:
> On Tue, 19 Aug 2025 11:15:54 +0200, Raphael Gallais-Pou wrote:
>> The new STMicroelectronics SoC features a display controller similar to
>> the one used in previous SoCs.  Because there is additional registers,
>> it is incompatible with existing IPs.
>>
>> Add the new name to the list of compatible string.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>  .../devicetree/bindings/display/st,stm32-ltdc.yaml | 30 ++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)

Hi Rob,

It seems several patches of this series triggered your bot without
warnings/errors messages.

Did I missed something or is it just a glitch in the matrix ? :)

Best regards,
Raphaël
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
>
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-drm-misc-next-v3-1-04153978ebdb@foss.st.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>


