Return-Path: <linux-kernel+bounces-858426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B4BEAA6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406511896785
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4162C08C2;
	Fri, 17 Oct 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="t0ucrUBL"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6062C08A8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718042; cv=none; b=hAKTc8Fe5DpcPFBwzBTo2iN0N2GagfchwrPgllAbxgmPgJhw0x3whnzhOwirMFuz9VW/XrGxgpCNng2cdeXOKrsiR+lD5O2gu+0GuFxl6cWh80xdx8T9W9HAa11fyzK4GPj++ieGEWtonED38eiWZLDnUJ2dkHYRzAfLHk+1MN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718042; c=relaxed/simple;
	bh=gxKOH8Xdwc40yMCcxjDPNybQvl0viUGO00L2ILr5yMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzvosBsqiL3dhJb6kuKL5kq+aaDxsWkLPKjsLSV81uNX8WfYZUXA0FjWObZ67ky9enqXJYlcVh/EvP0fbGsq8SL7rgZfonq+bes6Zdf6SyzFWGD475OU8dOgIN+F0v45M6qkzLVTjKilNWP32jhmKSSOZJRPN4FBo/2H48MFbBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=t0ucrUBL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso18128215ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760718040; x=1761322840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVQ6phuTO84kFBkRt8EnO28DbxtrTEoiT+THIp/h4p4=;
        b=t0ucrUBLoRssJrKtvP3DBh+uDh0k5SGtZBapjoXMoaMf7wd9frsENoYcYCQpU8V71Z
         VAbienV/ZTHNxuCs+GrjYtTpm5ODskSEp5yN3CbbjUvbiwFq4YjKkSZbVz26OJ+x3sLL
         1Y4D8a583G+VJe0QCabnO4va87db47AcNmDrHkSv88DP1ca+FJlPbR5AXuTWj42voQCr
         oxLnLapdNY3Q1OkCs+WmbG9fQXs2Gft53TNQX3xwnPWZBXg02vz5uL/HPVTn6TtAS7tf
         Hw6aHBUJWM+DFqyDyvnU5gUle0/7XcAwmuzhmrRNNLhMw4DQhvTYK2QXIjmkmeS/83Bc
         A2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718040; x=1761322840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVQ6phuTO84kFBkRt8EnO28DbxtrTEoiT+THIp/h4p4=;
        b=NGG8XO0YVvYESqcNZTNpkXKOXRWe7nbOSpjeBllB0azk34X2J6uP2NFaakEL4tGraB
         +bcrLXr02no2YhBK4hdVePbaG7lu85Dt/zX8jzVD6A6K3VfVsSgNdM3Vx2KrVMK0K/6H
         xLVJKpJsOvEhpv7bTH00kHOj3S3T+X3yRyxzjVWftlzHzNnR0TR1jew8Qh+Y6kS3hEKL
         fW+Hr6YY2kHjS5iB8pB27eZhZQJUQltLb76i7OB8ygUfBrlRrFPXM8ikvNPcPJNcILnL
         6iKOyVUlEv282EYUzV5JSh6uQSCUFviNSBrvDZkE5KEM7Ft2LvUKK9YVDtWSevNdAzkb
         Me1A==
X-Forwarded-Encrypted: i=1; AJvYcCWu+HcMfHFGeB9fxqMNSxCTaYZ4gWdlBnUhf/AlokLdgNQMRGDoQDpriz91616eK5IR1RdBywhM8/cf6sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zVxeF3eltcd+M1Ht1QcEjIDMqmBU7SHjPax30C6ORk4300Sv
	A50mWWD2vjDRVdHMoAYNBeXPeOm4E8ruT6FeO0aiBnipSYe/DZEBh2y0tZ8ntTkjDsg=
X-Gm-Gg: ASbGnct/z/1nvxxOZ9+07zsRS/o71QOMGiIzn70Wxu3FWdnlwu9kCD8ASqiF0aLO4eU
	kK5UIKiSFVq/ZtXx1JMou39D1YP6GNhDGNHBWQRvl2SdiUJ+kV0kpNZTf0h04M9vr8fXKoSDlM2
	8RQvSAZvuXUabT6sbtfYbF6S7ZmUf/6Wv7gq/Io1shfo8kKGda5Rm2Ik6D99BHjnhlUxyYlzKjq
	Kq6hRvuEdjquKPOEUqJQk/1r2rRuToQ7OR0em78CsMSW18e24DoLMZagVs+TOt8Gy9NFjunM1g8
	4+//dP2g4ud+8MRXIdaPSEmKR+mtnSe/x3lUZwllLOLnzV4jQ3WqKujPRWMKk1Qqgywv1xj0SFO
	z0YneMuE3x2DXkC/raPqSyhotjIs2F7rCkTBwLT9tFrouNAcksJWo2HiIwWwPS5w/l8PKIbgwLe
	oAmYP1CC9gZAhaVQd+45TBD3mxcm/B7rKA8QfkIxQ=
X-Google-Smtp-Source: AGHT+IHkLguz0srIwb9Y0kZ8Jj/SerEa4TnF03jUDSOPF34f5dBqn26UDMGx8TBiPYMDv2ZC0jD7cw==
X-Received: by 2002:a05:6e02:1d9d:b0:430:a65c:a833 with SMTP id e9e14a558f8ab-430c52ccf5fmr57021215ab.31.1760718039725;
        Fri, 17 Oct 2025 09:20:39 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a97689basm12877173.49.2025.10.17.09.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 09:20:39 -0700 (PDT)
Message-ID: <3ccf196c-aa57-4977-9dea-a54172e427fa@riscstar.com>
Date: Fri, 17 Oct 2025 11:20:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: phy: spacemit: add SpacemiT
 PCIe/combo PHY
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-2-elder@riscstar.com>
 <20251015145217.GA3554740-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251015145217.GA3554740-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 9:52 AM, Rob Herring wrote:
>> +  resets:
>> +    items:
>> +      - description: DWC PCIe Data Bus Interface (DBI) reset
>> +      - description: DWC PCIe application AXI-bus Master interface reset
>> +      - description: DWC PCIe application AXI-bus slave interface reset
>> +      - description: PHY reset; must be deasserted for PHY to function
>> +
>> +  reset-names:
>> +    items:
>> +      - const: dbi
>> +      - const: mstr
>> +      - const: slv
>> +      - const: phy
> I think phy should be first as that's the main one to the phy and the
> others are somewhat questionable. Otherwise,
> 
> Reviewed-by: Rob Herring (Arm)<robh@kernel.org>

OK I'll arrange them that way in v3.  Thank you.	-Alex

