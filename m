Return-Path: <linux-kernel+bounces-858428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B9BEAD46
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16B895A51D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797A2C3260;
	Fri, 17 Oct 2025 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="IeJ3VWnC"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31A2C11F2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718048; cv=none; b=nVRhPNBB5OSsYHKTTAp4M9shgeMaiLPjjK43t16gUTg5bdgjNfzeE51HeisCXy9t9+1PJpQxB6TGD0zqR1SvZ8lpa2B68TkIbEoRgq1NfU+OPtjPkHQsxb5BBmSgYzNzagYM2qbnJklUWmctUzkcAFpYpSyYhTHG0j0CYZH5Ct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718048; c=relaxed/simple;
	bh=V5+G6D9gYoHyycj/8QJCp/qEQ29MEhUI3xvN2kUgks8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+1Gm/pBLc24xi/IG301kPoCpCQhlsMWS5CToG8fwsUL8zST9fHAI04E9NPDg71F3g9sT4KAUhnT3ZGNGxrqTUA6d1Gj4hX0tPQIEE70swLIGg4OqzAIqA8E8aZW32vpZEiFrX5wh6FFZSztb49eV0PX918mk1QQgSu4I5HrroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=IeJ3VWnC; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so87794039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760718045; x=1761322845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrl9ZQZl0dfsXGeKo4b0s0yUNEi86+tLTNDIOrpaa44=;
        b=IeJ3VWnCWqcMx3x6GNydwUfIGAP29psMhh0YA9KI23ZpTMz0Tp1xk8SNZiWF6JRhym
         ufpT+K+c9IadtxhOLeb1Qvwh6ShO+GxWi/IxiPceCN6+u+WWeawYcfp4crcApVq91ctb
         SgNOTj4pP3fhQ5yNAHN62XTqM7QFKpPJlv97pP5EcFl9s7FIdcIkajaaQdD5IQgFujw+
         ma5j70dntTe+pfZTcXNHM5/rGTGvq87Zd8/RAhQPUxcoz4GqY2bRVwjNrzpVWpUp3zm+
         567vVP7jZIsgdlv/ELgL/p2+ONpHySW0uDtT++wC/TLn+/WLEUiKDdmch6+yQ25Xp27b
         Cajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718045; x=1761322845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrl9ZQZl0dfsXGeKo4b0s0yUNEi86+tLTNDIOrpaa44=;
        b=n0Z8XI8rrh51wW2yusS08f94ObTmLSWmfrkaTTR648+nNbZxpeNlZymmJ7eRkirrC0
         s5tmg9csGxOhyic6MeJ2rLEoCqL4GW1QaUrTI0avm3lnnGbpcbyCh3np9SX1eZWOo05d
         go/r2EsRsdq5huQqFwmFebfzMu9wsZgyL+hCMczsKhoiSYXpmxiAyW81VnW0WCJnejpD
         3gxk6mroM53wf5SB1WfsKm/AjrF9sxGYQ9OC7AETVQQPIn0Sv22KR20JJoMmPo/4Yrlc
         V/KZmeLLeV+Kt2hh+9NPrqEaZEigmJPtpVErRI++ELInGDsdgGZijrd9TD0C9msSxq5Q
         gtOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV822/Mv+GXplRZVFjCVZ6M6OermvBEYIOl7aTQBy4pce4V1Db7M9ofk7pN1aloUwYjDl0r4RjX83pW3qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpImNfbLt+iY2y2pcXdxIrCDcmD6UNeKfphbuYngXOdOg8wYQ
	uW1BPnsCOsE3M4+3yhbNYPZBVwA4yS+YBpzXujrKjH7s8jq3vJjplGKGYampgMRIkvc=
X-Gm-Gg: ASbGncti7UcYl7NMfJRkYVw02yXOXHzOK+hOLaUgqn/rbCw/Jp7rdQANOc4fPcaa3zV
	wTHDQSsTEyW11Vxt+lV9d79vliqVZNDgOYJfBmnghi8fywoL9MfiyKuHRYyJj836IKN7s4+r9wQ
	ZY3z5TFhA5zH33PXJC5MA8evJ/A7NG4Ugg/TtclKEgK/FaQyvuLc+58ijDxfy782mozFQyCgdTh
	kowBjUtgg3l58vf8oBw6wi0PhaGC6+ztAMBvWdVxIF7bai7w4tBxjAOu7ONvEuAQT4bw4nqr4hv
	3yClSKMNzg8oybGm2Zz51oTkUBE31iSeyavkEHLtqDAKErONuM65CNSfiixmkteeFW4Ty26hqP0
	NkFq4VSLO0GdFszw6b6qGKxUTEh60ZsfnjgWvcxNiwRViwwPIKoJ+YPOmkv4kpXWVZ2VlntyTko
	ZS3q4A56Qv5tvdswb1h9d/3LWnMhMeoKSZN3SgQuM=
X-Google-Smtp-Source: AGHT+IF6pUvJ0SrEEfDoT+rWcs5Ssj/49Pi6P7PUBjepw0T+yRtjC6wHKw2821+rzZKRbVJoL68B5Q==
X-Received: by 2002:a05:6e02:19ce:b0:430:bee3:34a with SMTP id e9e14a558f8ab-430c52b5b09mr52484505ab.20.1760718045271;
        Fri, 17 Oct 2025 09:20:45 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97689basm12877173.49.2025.10.17.09.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:20:44 -0700 (PDT)
Message-ID: <e7bbbc92-871e-4155-a1b4-96929199a1dd@riscstar.com>
Date: Fri, 17 Oct 2025 11:20:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: spacemit: introduce PCIe PHY
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: guodong@riscstar.com, bhelgaas@google.com, christian.bruel@foss.st.com,
 krzk+dt@kernel.org, namcao@linutronix.de, aou@eecs.berkeley.edu,
 shradha.t@samsung.com, vkoul@kernel.org, linux-pci@vger.kernel.org,
 dlan@gentoo.org, pjw@kernel.org, linux-phy@lists.infradead.org,
 qiang.yu@oss.qualcomm.com, p.zabel@pengutronix.de,
 linux-riscv@lists.infradead.org, mani@kernel.org, palmer@dabbelt.com,
 kishon@kernel.org, kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
 inochiama@gmail.com, devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 alex@ghiti.fr, krishna.chundru@oss.qualcomm.com, lpieralisi@kernel.org,
 conor+dt@kernel.org, thippeswamy.havalige@amd.com
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-3-elder@riscstar.com>
 <176054651498.4032617.11231316454316691309.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <176054651498.4032617.11231316454316691309.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 11:41 AM, Rob Herring (Arm) wrote:
> 
> On Mon, 13 Oct 2025 10:35:19 -0500, Alex Elder wrote:
>> Add the Device Tree binding for two PCIe PHYs present on the SpacemiT
>> K1 SoC.  These PHYs are dependent on a separate combo PHY, which
>> determines at probe time the calibration values used by the PCIe-only
>> PHYs.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - Added '>' to the description, and reworded it a bit
>>      - Added clocks and clock-names properties
>>      - Dropped the label and status property from the example
>>
>>   .../bindings/phy/spacemit,k1-pcie-phy.yaml    | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
>>
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks.	-Alex

