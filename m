Return-Path: <linux-kernel+bounces-871516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A1AC0D810
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37FA1894FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0823301472;
	Mon, 27 Oct 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gSSita82"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FE2FDC3F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567920; cv=none; b=LhI+gFSf5K6Ujy8QUb+oDMnoRy4gX8TvpfpuaQauVA6fs/C9JCn3kusAf8Htg/2yT+PhYhQrJj9Wk3Va0/4lkSOk0ksPXQy/p7r7ZDl1E2345v029w3IhqS4ruEOZRQ1tpXtUzARcXGdJsOj4GKaBbz1Yp4yk2Mz0NC0K4qzu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567920; c=relaxed/simple;
	bh=26UZxlyut4mA1rih/Y8S/Eh7+roQLu0gdIv1jjO/O6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShNiNFvomKJE1Nwk+qdewPwI/Gutp2o015SDRtQ4/b9vy+m8d8WY6MJZRKlTVto0se0w4zHdLrBRBllY9hUvnLSGNzrEpjQrfQvtb/Opjdp6lTvcRgO5iMBkgfpGgoA5uycJI/cgiihPJG+eUYos6o0AIBE1OUkfG8eySf/duMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gSSita82; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2231065f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761567916; x=1762172716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hScMozm2xpFWOtQ/NDxiZZGnkL7BvFN8k0ETWwiYgCY=;
        b=gSSita82+gaKAjOexx193WD/U8nOD+DS1GK9ulDJsogQPBSg7g4WTqby7GRfYFWTvk
         wibIoQ9A1n59CGCngwbtFty2x/ey4zcB8Jo0DDvsIYlmHLCb12Xs5vukJxEcyV/MxcKR
         MHl37ENR8kETJtCur0W14DA8o0puvqzfncNOZCyRcgYLINohchGpT+YL9zt31PnduFnT
         JiRu+L2EPw69JCEy2O1oustxGolHdm4sDGR53Np80KTRyE78p7jdqjaRlj14fkFLDCy6
         X/mpWrnbwVnLuNfOEaf8CB9dogJTDLHZOZZ1RRnm5gbCeDpgiKl+l26ySyPxdkLxBbzr
         OVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761567916; x=1762172716;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hScMozm2xpFWOtQ/NDxiZZGnkL7BvFN8k0ETWwiYgCY=;
        b=joQHLCdck25OLg3OF2NCR6BMffGEHIQQ5iMQVHoFB1RP1+8DrFhjuyumVkMR8ojYLj
         g4IpgnqQ56jGN43wEjEmIaeb9t91z+rXa5D6S84NZGGWLVHbzwW/D3cMXz1mvyNAR/nM
         UzmjtVp8nuf2v+YEw7wCIkrn2YipkX/Z/EtmvJ4KWBxnidjREqIlO7l909YsJdWSTeK7
         8hBAOOomMrX8HIEzYto7LYaa3kGgBC+Onxknct1Us2QHw0NloeP97GytaTokBQGFIIAj
         96NsW9hEPT7slFc/eRxtDQLUpJ+aBg0zIZSbrvzmOBuHbjdK6aWev6dHl93kD9n/cacf
         BUpg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ig8QW54cKbgNyG8c5MK8GfHCbgCW4fCkNAJYJaPPef7GPBT827G1a2KG9FuFTnQdZJPqYmY3lpxiGhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjyHzm1TDNhj/GY58Winyetce4mjFevGzUF4OJsya1DjNRnG6
	F7YYeZ5zT2pO0Ig+bV4ZHXukspB0RPAfOZN68Bvh6SUm0YdmxkiG1X77Oc8XsOlqayc=
X-Gm-Gg: ASbGncusfAxX/bYpSWy03Ndfaj+5Vuaa+8xfGmg571KeQRvpVZRg5jbU5w361N9dF9a
	uDkvE0eYNymo/ZzfU5nDPuep0XShdoUjhshGFvl7UGma7pX74s/9fP0bJyfsL1KNJHKyrOh3Q9y
	Ax+uSpMOnEA28OoSvKs8CsHjmLfgNzBIgHZYs7CyNVJwoUCSb8p08uFMS+r/8l3FS1cr1+NgqyG
	NpD1UrlgnxogS2O3rHF0fcX1vXCC6GrroxDV7QNR0KT/K3sUi+jp7cF5NglCYAwv6QbEdvfNxIW
	ubX9TgB10wKg+S1hSEHzrZUzDOCR+sZ/qV5K7ozVa4OhBa++8QSNFZnw2H+v5VtAR65lmdvJ0pK
	BIKrfk0DdU/H98gEBOiFQ4pAPTPp2pgTOn3gwI48OrehUaPaFZPXvd/n8ic23V5HdR/Z1kQI8b0
	AjzC3zzjzYhuhSG5vX6L3n1h6e39E=
X-Google-Smtp-Source: AGHT+IF6rcXOIjhkQgctFNVY+ZI5+TFY43u5r6OUBVnUNeSFPvOu2yebi/W+JbeqWT4lVcYouA7pNA==
X-Received: by 2002:a05:6000:2c0b:b0:428:3c9e:491 with SMTP id ffacd0b85a97d-4283c9e065cmr21487646f8f.57.1761567916344;
        Mon, 27 Oct 2025 05:25:16 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7e8sm14337758f8f.19.2025.10.27.05.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:25:15 -0700 (PDT)
Message-ID: <5044f670-2706-4d92-a00e-50c5d60208d1@suse.com>
Date: Mon, 27 Oct 2025 14:25:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 53/56] drivers/cpu: Re-patch mitigations through sysfs
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-54-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251013143444.3999-54-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 17:34, David Kaplan wrote:
> Create a new file at /sys/devices/system/cpu/mitigations that prints the
> current set of mitigation options and can be written to in order to
> re-select mitigations.
> 
> Only options related to mitigations are handled, with the file initially
> returning the relevant options from the command line.  When the file is
> written, any existing selections are discarded and the new options are
> evaluated.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      |   8 ++
>   drivers/base/cpu.c                            | 113 ++++++++++++++++++
>   include/linux/cpu.h                           |   3 +
>   3 files changed, 124 insertions(+)
> 

<snip>

> +
> +ssize_t cpu_show_mitigation_options(struct device *dev, struct device_attribute *attr, char *buf);
> +ssize_t cpu_show_mitigation_options(struct device *dev, struct device_attribute *attr, char *buf)

Make it static

> +{
> +	return sysfs_emit(buf, saved_opts);
> +}
> +
> +ssize_t cpu_write_mitigation_options(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count);
> +
> +void __weak cpu_prepare_repatch_alternatives(void)
> +{
> +}
> +
> +void __weak cpu_update_alternatives(void)
> +{
> +}
> +
> +void __weak cpu_select_mitigations(void)
> +{
> +}
> +
> +ssize_t cpu_write_mitigation_options(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
Ditto

<snip>


