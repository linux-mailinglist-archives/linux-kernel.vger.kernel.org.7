Return-Path: <linux-kernel+bounces-874622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85626C16B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D2356F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E881E350A2E;
	Tue, 28 Oct 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WXgJ4ngq"
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8E3502A7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681722; cv=none; b=ieHf3KEPW1Zy/Uj/+ChhhNZYVX83GhPqUrd8J+9R0rkriRUnmXJ6x7g1Nj+gYTPnUwkeSvyjlLgPirLNhBjCI4h7XIbj8UTcNDyL3WFjyneTzOP76aUIQCPPc/GiEduAEJWQZV56Fw+8okqTKXACiBHfbSK+aLBAnPqR7RuS8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681722; c=relaxed/simple;
	bh=vy/2BFyxrURtJGpqMFUVBMusirEky6Bfx+SPD0xfX6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cbgi7paQS56+jTbeTS3A190lMpig/cO5PcmzW66JShm9mVvOGbjGVJBLmQvgDYI4x5FIZO3JR4ZddqbQu1g2BWRIqDHK3/NfsXiw+PAJuSq10ji34kEL/QaBIN4q/CHLS3t2EkxkgLFvrNV300oi2mN6bJ0Zsj/1Nqg+jGJQug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WXgJ4ngq; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-71d71bcac45so67224417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681719; x=1762286519;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wwzCwoll9urQFzaJ2w/bQYJFP3bpkFcySIlakUGODA=;
        b=FmTWt7toReobHBXgOy89ImXUuqEwBgOpSBRDgOr2aU4NNjkpv4vwbE+HzVKNcAjKK+
         muAVu8YsxTY7M/hzq6LsF/5wWaKYckgqcYL2ix3N0cfnmalzBkSA6c11cys0+2KMg5Wn
         8xKr6jwj1ir9/ltGtX/cQ2p+9Xqnr3eqw/jLHn3Q6xZiFtA0XqbIKf7OIDgvh/GsG+PA
         mg/rrRAaxqGfEo/jyzSBO8pW7dRegzr4UCWNLDPhRP4RrGIuVIQTsnXuhkfyLCa6xt4a
         3OqkzWG7HgiChZWJimNDFr80O11R1Zydf1oISRl3Bnw5qZOXCo9ehSTPBSJgCbL25NJn
         NKFw==
X-Forwarded-Encrypted: i=1; AJvYcCUYP69650iYQ2ZgXmZY6E/pAgb8o78MQMBALZ04fzu0zC9e/St4jL37JXLx2pagnNPW+B/4+QhCKkOT9V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJl4vrrd1NG3ZBJ5UGHqKOp9YG0WbDTiWS07FOPB3gZSw606Mb
	ub1RVuCRH0QLsjmHIlpDK1IobtZzzYM/5UL38Zt/5/V1augs7JhEUUWcyK79KoFC1txCl2uf2kK
	6kQIotB70tehpuiTUvYLyD79MW6u4AgfaEsUDA3Un1ims500bwzUdEZxqXyaYnEynEEokMieX8i
	dPmVg3fb34k0JK+Hm5McE092ipLdytbmo6E2R3r46y4+VBNy2ZgcPuzbOSuC+RO75T7E8XXPium
	djhecXNLDocXemYUF/J
X-Gm-Gg: ASbGnctBsZzXw40h7CAP2X87aETvdWOe15b5MZKIYVZMaJe2VRBeuD6Ou6C60JTMYSR
	NC6xnlTXDtn+ruQkDi7UMcqyq5d2OhJ8n+A4G/v31gppl/UuuxFOj5eWm1ZM9nymZmLPe+xSStg
	4uEFuIC+BrBRZJdb7QydewiDHkIShftVDgFvmZ4mCtcFQnRUiA23AIOCEDiSLd0CWeLsijRGdX3
	hqHj6ie51iLqzhY8KCX64jz9/o0c6a83m8QLP+AYFOyUTsjA5kb2FrxmGG+FU5OcKENlbSKLwbE
	dZf3Wjy+xWvkBRZw2Lrh0t+MaEc4ZtI4Q1hWSSweVXkxVRSWyWDMlId/cNmsVaPlyiOkzNdKY2U
	zQCOPIRBx4O7JsLyhnxCIq1z4L2Qwt0CjZmoDi0Fs/bEx7Bw/QPx+Vv3oKaMEPdDdh2/+hl9hPE
	OTJLQ+IqUA62cy9ZroENT5t59amGyGLoJier8=
X-Google-Smtp-Source: AGHT+IEUFtQ8SQcbIAdEerMBGlJdrnZAviKG70tL9YfRC3iI4vj6CizCvEvAA04lr2cN5HiyotdNd6ADBrk+
X-Received: by 2002:a53:d008:0:b0:63c:ec55:321c with SMTP id 956f58d0204a3-63f76d51924mr663362d50.26.1761681717410;
        Tue, 28 Oct 2025 13:01:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-63f4c3e2a46sm935041d50.7.2025.10.28.13.01.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:01:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290d860acbcso135592615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761681716; x=1762286516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7wwzCwoll9urQFzaJ2w/bQYJFP3bpkFcySIlakUGODA=;
        b=WXgJ4ngqeL/SWh9dKvB8amlIZUPxvaLrHqjhM8p/Lv3WukQ8Fgad4ifuvaYtR9Nw2Z
         JHYN1QJI/WNwj3iKPiiCNnwV4TSEV6ghSj4HbLesI1/fOOWVFjdgfbl/Y+hvq3qJ0mM+
         0FP0Xox9nZNPCXH+XUxTApx3kdqhoQIOVBWdg=
X-Forwarded-Encrypted: i=1; AJvYcCWXn1m3vJWfe6k8/vTzmNFDeQo3VzJwddM9bhnXjPa7Lmv7ZzF6+gX2w1Z7lgtHGM3R73zPScGWosmppQo=@vger.kernel.org
X-Received: by 2002:a17:902:f681:b0:265:89c:251b with SMTP id d9443c01a7336-294dee98e93mr4778745ad.29.1761681714392;
        Tue, 28 Oct 2025 13:01:54 -0700 (PDT)
X-Received: by 2002:a17:902:f681:b0:265:89c:251b with SMTP id d9443c01a7336-294dee98e93mr4778465ad.29.1761681713837;
        Tue, 28 Oct 2025 13:01:53 -0700 (PDT)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d30030sm124568435ad.65.2025.10.28.13.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:01:53 -0700 (PDT)
Message-ID: <5ca0b4a2-ec3a-4fa5-a691-7e3bab88890a@broadcom.com>
Date: Tue, 28 Oct 2025 16:01:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Fix use of incorrect constant
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251022224553.GA1271981@bhelgaas>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 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
In-Reply-To: <20251022224553.GA1271981@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/22/25 18:45, Bjorn Helgaas wrote:
> On Fri, Oct 03, 2025 at 01:04:36PM -0400, Jim Quinlan wrote:
>> The driver was using the PCIE_LINK_STATE_L1 constant as a field mask for
>> setting the private PCI_EXP_LNKCAP register, but this constant is
>> Linux-created and has nothing to do with the PCIe spec.  Serendipitously,
>> the value of this constant was correct for its usage until after 6.1, when
>> its value changed from BIT(1) to BIT(2);
>> ...
>>   #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
>>   #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
>> -#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
> This all tangential questions for possible future changes, not
> anything for *this* patch.
>
> We have these in include/uapi/linux/pci_regs.h:
>
>    #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */
>    #define  PCI_EXP_LNKCAP_MLW     0x000003f0 /* Maximum Link Width */
>    #define  PCI_EXP_LNKCAP_ASPMS   0x00000c00 /* ASPM Support */
>    #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
>
> Since you're using PCI_EXP_LNKCAP_ASPM_L0S below for writes to
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY, I assume
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY is another name for PCI_EXP_LNKCAP?
yes and no, see below.
>
> If so, it looks like we should also use PCI_EXP_LNKCAP_MLW instead of
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK (although the
> value is different for some reason; maybe 0x1f0 just reflects the
> limits of brcmstb).
>
> It would be nice to have a #define for the base of the PCIe
> Capability so we could use that plus PCI_EXP_LNKCAP instead of
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY.

Hi Bjorn,

I believe this has come up before.  Our "priv" registers should be exact 
mirrors of standard PCI config space registers to allow us to set RO 
fields.  Unfortunately, sometimes the "priv" fields do not exactly match 
the standard version.

As you have noticed, our field for MAX_LINK_WIDTH_MASK is 0x1f0 instead 
of 0x3f0.  The reason for this is not necessarily a BRCM limitation; our 
priv register has a CPM field mask of 0x200 (!) instead of where you 
would expect: 0x40000.  Further, everything in this priv register is 
different from its counterpart from bit 18 and higher.

> But you did something like that already for PCI_EXP_LNKCTL2 using
> BRCM_PCIE_CAP_REGS (0x00ac), which means LNKCTL2 and LNKCAP must be
> at:
>
>    LNKCTL2: 0x00dc (0x00ac + 0x30)
>    LNKCAP:  0x04dc (0x04d0 + 0x0c)
>
> which doesn't look at all like they would both be in the actual PCIe
> Capability format.
>
>>   #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
>>   #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8

Just like the fields of our "priv" registers may be non-standard, so may 
be the addresses of our "priv" registers.  The first few registers are 
in the same order as EXP_CAP, but then the rest are not, so using 
standard offsets does not work.

I don't know why HW did these things.  I can add a comment to the code 
like "priv register addresses and fields may not correspond to standard 
PCI registers".

Regards,

Jim Quinlan

Broadcom STB/CM

>  From its usage to "un-advertise L1 substates",
> PCIE_RC_CFG_PRIV1_ROOT_CAP looks like it might be related to
> PCI_L1SS_CAP, but 0xf8 doesn't really match up to
> PCI_L1SS_CAP_L1_PM_SS (0x10)
>
> If this is really related to PCI_L1SS_CAP, can we use the names from
> pci_regs.h somehow?
>>   	/* Don't advertise L0s capability if 'aspm-no-l0s' */
>> -	aspm_support = PCIE_LINK_STATE_L1;
>> -	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
>> -		aspm_support |= PCIE_LINK_STATE_L0S;
>>   	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>> -	u32p_replace_bits(&tmp, aspm_support,
>> -		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
>> +	if (of_property_read_bool(pcie->np, "aspm-no-l0s"))
>> +		tmp &= ~PCI_EXP_LNKCAP_ASPM_L0S;
>>   	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>>   
>>   	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */



