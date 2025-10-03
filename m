Return-Path: <linux-kernel+bounces-840899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C77BB5ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A023D19E784E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E573451;
	Fri,  3 Oct 2025 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcORrS37"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9A18B12
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451546; cv=none; b=kxECR+1Ng8RwpE7MResCqrxL7/B5YGrbY35a9RHVTedO3CYAwwDkJPsyLipeDgKfSAbcj/B6yVq9+M8y0hQbnv8oTElENXZUiIiQ0pcvGQQTiqSVSav+XpoKuvUOiKq+kYl1Xnq9KiO7AQ+gMlOAs/UayMFXWyIqJPYxDJUqua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451546; c=relaxed/simple;
	bh=ETlEf66hdPCHHJn1GuWHBeROSwycNJMpRgfr1/FpZG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfFGLSP/KNtVmU40fzcEjQVYPhnBYxvmJ7dTKkevsp8CAt1/O7oBq5HEnA+W4kIeigTRVFUjMp2GNzKWTMGGotcIRvNGQezse6No9S7vuHz7PeMQc82moLe6KSInvEkOt9PGYFm9Lj8P6yFgTts7Oo3JU+QBE2DX72hFkVKPPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcORrS37; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759451539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xaf5RNoemnbQ5bhVRXfDXLq6XKqiACwC+kjxc5U7K8E=;
	b=dcORrS37leWVm4KdpJNUOSvAc4CYYTK3jpbJjqb5xAt4wtttB+ZEjt4PUbwRl6w9jFWqgF
	AG/GoC6OqpioSg+v7OgFwageCiUd4qxkM82cdSc64kIHfigBepNACLamvdOm7xQONHV7sx
	TmkJdof4u0UAJwF8XinDsOYp9spWaXw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-HszvnMsDMfmeXXpi0Ae79A-1; Thu, 02 Oct 2025 20:32:18 -0400
X-MC-Unique: HszvnMsDMfmeXXpi0Ae79A-1
X-Mimecast-MFC-AGG-ID: HszvnMsDMfmeXXpi0Ae79A_1759451538
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so1715676b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759451537; x=1760056337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xaf5RNoemnbQ5bhVRXfDXLq6XKqiACwC+kjxc5U7K8E=;
        b=d9aq7I6gpZ5PI+OvRbl9mnZMTJV0kciFgnbbbM2+d/YUwmGW5DdPZe5z1cJM10yh5E
         ercxKlbETgSpbMyXSDQXuVQDNNmziYpc36C/l/nL3ZTpzz8xKaY50qVpsWz4nBgXFAH4
         A7SgrpbBWF2udH8hJeArgJ3ZcwBOCsRqVuehi7pvY1Xd5WG7AApvaiWQQfgf9wIPguz2
         CeXgP/TZA3j0d4yaH4zTCpmBk94AKb7M3wflj1qwjVenEUh2eTfuuKrv2/4QMQWMuSCt
         eq7WprR95ohBZq6617ARYlm68uapq2eRxMKEU/TEJste8HwWvy0q2Zyd+9QbIlBgYCZK
         9dsw==
X-Forwarded-Encrypted: i=1; AJvYcCW4hjPqCQc8Z7ONvVOYtrpc7Xf/+9qa/XTsUL9AyUTUTKrkHNAxiy6P/dOgXpRVNeDKfdc3D6xm1qE5lhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwyhWdaBWjQyRjEVuyaOuGf8zPJgUiGl6zen78MF91g3Q4jGa
	ZoGk7/S1QtKqFgqgSIUSyHcEO5KMLf+ShnhdQ2jZmfMlWASESN5raacw5DtuGnrAOR398P6Og5w
	lEmc0XquiRuHd/CRt0MKKsza8B0XixghdwbRco+bZspkloClzvHVEvrveNWySuvRdjQ==
X-Gm-Gg: ASbGncu7Sn5Ymm4bSyS8TdJ8/WP0ZJ64LuPNc1PUeiw6ybOIy5l5UZWhCAeVQKKAgcV
	WfFjWOeLDsKq7TPS1u2UGqYxxXHnmXnvO87yL7JM7QGrjdsIjAY9NPhwBNv4x5Kc9NDeNdbFzFt
	Vu8zHIvLdXHOsTqAhr7CWDn8/ULy2MafzOieg7xixa6/ZWvw62friX8MfsjCqbg3D0OZYFNVMfs
	JdyY4DuFJi7aACr9MUAVJe5ZzAIV9q8e3/VUJptKPpDYGmAXixg/AQixxO3gB31WpDIk+V7NRDW
	vxBq5j4UNKOZtaFpTgBz53WigIf1zJMeDYWLZpYbGIRutctX5kKNtfnVw+zOcdWvOKyb2eL0oMx
	47zc09ntE6Q==
X-Received: by 2002:a05:6a00:39a3:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-78c98d2e6aemr1700837b3a.1.1759451537523;
        Thu, 02 Oct 2025 17:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWEEgYNq3YMaGCew9+gs61ruTR+Mw3AELcBoDCygoa6FdJ8RVNCdO/U7t0LGX7nViXA3ZUSQ==
X-Received: by 2002:a05:6a00:39a3:b0:781:1a9f:aeeb with SMTP id d2e1a72fcca58-78c98d2e6aemr1700792b3a.1.1759451537135;
        Thu, 02 Oct 2025 17:32:17 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02074654sm3236692b3a.75.2025.10.02.17.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:32:16 -0700 (PDT)
Message-ID: <ef45ce3a-7a78-45c8-8196-75923af7c6ab@redhat.com>
Date: Fri, 3 Oct 2025 10:32:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/29] arm64: kconfig: Add Kconfig entry for MPAM
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-6-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> The bulk of the MPAM driver lives outside the arch code because it
> largely manages MMIO devices that generate interrupts. The driver
> needs a Kconfig symbol to enable it. As MPAM is only found on arm64
> platforms, the arm64 tree is the most natural home for the Kconfig
> option.
> 
> This Kconfig option will later be used by the arch code to enable
> or disable the MPAM context-switch code, and to register properties
> of CPUs with the MPAM driver.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> CC: Dave Martin <dave.martin@arm.com>
> ---
> Changes since v1:
>   * Help text rewritten by Dave.
> ---
>   arch/arm64/Kconfig | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>




