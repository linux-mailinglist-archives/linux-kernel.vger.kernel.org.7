Return-Path: <linux-kernel+bounces-874659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CADC16CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBDBF357267
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5F34C15E;
	Tue, 28 Oct 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RHtI7kSO"
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8522D47F5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683708; cv=none; b=WWPovkGYW5ZWFwC4XtktN+T/5RBNOqPW+DUuHl2gfKtc29ddM9rPxThXarRB4xpC6Fpi03gOYIw4yUMGuWLOpah3nEhil2WMjJhYsedXHggY1zARK0c9/dO/gXbEwuV4keaciVSB45s8srXgoQgBRV1CiF5aL2W1+4Zs2sQLWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683708; c=relaxed/simple;
	bh=qzy4tgUwmu6YlIs5UZ9dfer9rkkU2cDr+iv5TV7wdbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBzpCdvcy1pA5BTFG9nORoKh1rKsqmXd52Uy4o0ZqRGljITLt8/FVgWgTNYqOXBQEKjfXF9fKfQzV/pdSQAFaiTjMoClnWQygHk2BFutKo71BsFO0T0LRWqrzKyL8ORvozTZc+SSPSc3iT6yQu2te9p1Iut9rX6JcD32gC7rfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RHtI7kSO; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3d3116a5a26so2206427fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683702; x=1762288502;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzy4tgUwmu6YlIs5UZ9dfer9rkkU2cDr+iv5TV7wdbg=;
        b=PripQSgbGdi+HerSztfFhtwvOJMlDutyj4fLeF1n0SAksZ9dqT28C7FvlGA6LagxPM
         2MADPib1ZKu4dZyxzoCJox3fgn+2OqP1pjiAz4aJ+ZBRlSApahhSCTA0Y3S91l4GTd5U
         QAS5j0DJcT352bgzoSpMQuvoDzcDfi2XviLU38fOU1+QaqiZCOQz3FvT0Obajsy318LJ
         jaX0qrzigEAcqFUzjiViuuvyjjqcveEa9y/8zeSq8ZihI1p4UH4rL3hUmhkG54yFKIFZ
         U4Qt5TAevt7ffR4nZ0km/fUxajfhJWSlvgKQ32d3IB8/y9+4sbdla5AHE7iD9lkVmmIn
         4+RA==
X-Forwarded-Encrypted: i=1; AJvYcCVIqJhWss2LYuiEalPo6cY3Sl3lvz6lK8hI58ZQlbztg1N9nAI1p+F2x3tu/f9oEHQ9NFgO/r3YXoLxZXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PTADgIlwJ7eOZNEBiM3/voYZ2v7NqUGjHZa5A4Tl8m4xdqiH
	QQeXv35JqATZpV6mO4fV7zUooFQyZDZlwTbLhDMKJg9BVhLsM/t1f4EWaGl7nZMSMsiTsgsle4M
	UeWj/1VcaT2YjAKiCX0VbBdRaK019MFsf7tyFmIkbF12QSq4JpcrUY2ryZly4wfLNRYL52E+v8T
	RU8w4drqvhEl5fh32dWSFcpLrzFisPeNlfnKRUxS+aqjLPsPgde2XuOhBLQfByQd3e3PF1zMIvB
	OPAtH7aAE374TFr/crp
X-Gm-Gg: ASbGncsQ1RIL5YriH+fq/GRLZANSXRZCR/r7Iw18NNs5or/mJ+4FAMhpnaVxJA7tby7
	sOFhI9N5y79uLGZeJYETveW+3AEC6xYrQDjgW0rZ24zSPakunpYcBs2ze+rb8lX65ODzQXYVD+t
	FwOJF5R5AMdJ/jzeIIuvKdnWA3Lm19StjhXSIRlVTeDOYyCWVO8DjDEFofUh65dVlg1bh8Atthi
	QBP1CLCpTJgbGVu/1MmRCjmXX0plLUVl+/mFvNZwl2iRQgkjP41NAuhuyVc4gm/P6EhOEQqpgVd
	V/gpdQ9rXKvAAFsUywu2a/H1KB4evh/WFN7PCwUoi9c7POYhEVZcvdO6T9ECoUSOQbZjvhuCbLl
	4yrTG+9Q96qNOc5l3mlJ3SI5bHQuTzNvLdeexGDJd5H2rLzaj90D7bJPPZxdGrrr/0uf/5htUqr
	g3t46TalazoBS9CrVzUjlpbFuKv8QJ9nGW8L0=
X-Google-Smtp-Source: AGHT+IEDha6R/nSkXTBnsksv6XqvnQVM2QAJOrVmZVIuhK4Lv43TeCGCNsXazb6VVKyhCVBoBfmnz7LPwv5Q
X-Received: by 2002:a05:6870:8e15:b0:3d2:5ad4:4e7 with SMTP id 586e51a60fabf-3d748cd1b51mr405219fac.47.1761683702387;
        Tue, 28 Oct 2025 13:35:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3d1e290e020sm993498fac.7.2025.10.28.13.35.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:35:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf2adbd3bso22902591cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761683701; x=1762288501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qzy4tgUwmu6YlIs5UZ9dfer9rkkU2cDr+iv5TV7wdbg=;
        b=RHtI7kSOLj+djjtMHIFd/GAgbZmOd5bElX+mEe2dO+PHjX7hl5mtRCuCMieQP0q7Om
         iXSEPsmX1eEsFXgwo1Hkk/CyzIsKw4omNOrGMJ4m9zSHphwOSKC8BMsaz0Z1qJHvzXxs
         YvhYlOQl9aEINzYBi0tVxhtCYcXEFr2xPLl5Q=
X-Forwarded-Encrypted: i=1; AJvYcCVNq8C+vpNE5rWe29T9ro9WalBhw+HF7WqgdTGi8iub431/N7RdbRjIrDxrGLhZ19xfzFqNE1P8lzs15C4=@vger.kernel.org
X-Received: by 2002:ac8:58c8:0:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed15b7605dmr7331861cf.34.1761683701333;
        Tue, 28 Oct 2025 13:35:01 -0700 (PDT)
X-Received: by 2002:ac8:58c8:0:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed15b7605dmr7331641cf.34.1761683700947;
        Tue, 28 Oct 2025 13:35:00 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49c5e8esm86789936d6.55.2025.10.28.13.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:35:00 -0700 (PDT)
Message-ID: <78fda7e9-5134-4f75-9ac4-a4918878ad48@broadcom.com>
Date: Tue, 28 Oct 2025 16:34:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v3 2/2] PCI: brcmstb: Add panic/die handler
 to driver
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com,
 jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251003195607.2009785-1-james.quinlan@broadcom.com>
 <20251003195607.2009785-3-james.quinlan@broadcom.com>
 <7efe5f81-aaa7-45b3-97d0-469ffeb35e5f@oracle.com>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <7efe5f81-aaa7-45b3-97d0-469ffeb35e5f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/4/25 01:06, ALOK TIWARI wrote:
>
>
> On 10/4/2025 1:26 AM, Jim Quinlan wrote:
>> +#define PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK        0x20
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK    0x10
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK    0x4
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK    0x2
>> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK    0x1
>
> typo __MASK -> _MASK

ack.


Jim Quinlan

>
>> +#define PCIE_OUTB_ERR_MEM_ADDR_LO            0x6018
>> +#define PCIE_OUTB_ERR_MEM_ADDR_HI            0x601c
>> +#define PCIE_OUTB_ERR_MEM_CAUSE                0x6020
>> +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK        0x40
>
>
> Thanks,
> Alok



