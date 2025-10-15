Return-Path: <linux-kernel+bounces-854885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D90BDFADC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE2F3BE8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5D3376B7;
	Wed, 15 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OEIxWQUD"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873782D593B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546103; cv=none; b=ffBwb2A1O546ibfaUuDgVlw+0ZrRGyzU+ko2MKVMNNPmZku9Jq/t1PvjJb9Yxrxi3/yaNKrmPSacaO+cq/DW7dAZ6UxwV0gGQUuy3ePPdRp/3DCX2TfjwMWBRKAmvqoGpnM8l/P6hTdqncr6ICnvNmmHO6l49rdv2hkNJnlrLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546103; c=relaxed/simple;
	bh=L5tvi7+IQDs+VRJpw8WX5BI2YljAtn95hgbTZZTzOw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG3N8YziR4hs6g0D5OhqCwi6eAv3ZT/E1HmVBHo4woFFtavlSkbZq2nNMKFgk2pC/FUdg18LH4fqjnF0OYWXDLnccZ8yiBVuMjfWPAN6omnGhGxlKDf0fHWkpoDiSXXrncq5Kn5T8bYRoRZ354ODiX4PHeWAmmw2doWMy2A95jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OEIxWQUD; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7afbcf24c83so2068996a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760546100; x=1761150900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCDXpcrAleflJDj99gPUKdddGhphTvnCdBCeqIcXopk=;
        b=OEIxWQUDfufj7+a+GjTW2wPBTT7JEkQ2hlz4BTg7PNG9A70Kxidu1TljrkfeNsVTpg
         ZtbPv8iyNY4ppVThOzwGgKCU5XhR3qjmPwKnCwfG8V2FE2IA6HkS0euvaEX8ZDsr84PS
         1yK+63v6KD++Jy/OzwDDPe01jiHjr06KUgP19bla3ZAnVVrgrXFMPuYqBTnxQAK1GcYC
         S3h/DQsOMzGHf2OUil0x/RSGbpW3G8JqrhctiRDsiDNtdr31KarrcjIL48l5zqscVSWJ
         Ctf6FkeZ9YEZkIl4bkgKhSm+xA/O5L6tHmVsmtFG16nmx9RyLrCdoN3PV8g1UtEkWpX2
         EJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546100; x=1761150900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCDXpcrAleflJDj99gPUKdddGhphTvnCdBCeqIcXopk=;
        b=TYdEuFX0AWFGPMeB6yXzh02iRbtuOMmBq/o+wvhlb96+u8w57mBQC0IHtCxCoZ6a3U
         pyzFRmhKBsS1ezCDP0TpFWsjuhit8LebtdBsUOu9hK5KeS0fwOtIzgPGs+XlkWEV7MkC
         8Isrefayh6dG8vZv/HdQrb8dpuvS+RMCwENwl/cMnzB+0NUEcRooKkCVZeZmteTLjiRM
         ykrOOhYLB3pYZvnmX7xTIrpJF+4aqhFZxv9R9jGVfEOQo8TF1/u5j9aH4erMUzIKtFMe
         eV8gBHk+I6KlUjm2nA8hPrTZRfbDWdm03aVnGFYV6aGyc7PE803exma7NWaFqke7v2IK
         mCIg==
X-Forwarded-Encrypted: i=1; AJvYcCXlXrXJ0AdVtRuiumruS1mZAFeAsRdBHb/lwO6m8zo6kuCqWigjME+pl4j9iAXMPMZudgj1GKUQQWHLJOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzEQ9ksf3C6fHHRqgQBK+O0zOEoaSKG1GPp/rPlWFPTg0HxKv
	ia6CvHer7Uo623fw52JCcp7UcGokN6lfJcMSFAMSHleEWxvLQ4+lkcO18hu3uBfqufg=
X-Gm-Gg: ASbGncueuZqaexmkaa5HJ539UXh7/GEvgzZdpXG+NCaguCUZn7aP+hT3aFM6nyQOeph
	mizcd84LibtUfarEVIxs8T+gNJIroKy1Abf4vgmktJqqby1xc4SWf2Ju/UKipX/y1s1u8mDgAvU
	BCaDYBXSX1AgqiiLAQX7lhYFk8WSGRQMbROymq4GcPvUgDOa1jimNZ5Ejz4lE9fvPfyFOxoa2vi
	uWtVjkkh9qaqnAuNw9zqA8ffQzphwK8zGaZgB1iX/1l5SPR9kbckXnVo40kEeKpe58Od/Mm4EL4
	Et3L1WEOYfgjA8elipi8ivp4wTkiqFSiphfq9IGNZtwxLT3XErQTdB7DTo/ll3FNQ3Jgg1Qxvdw
	tls2cL0dGKmmKk4vM0ux65qxRuQ==
X-Google-Smtp-Source: AGHT+IEoFlFxHVOg3TlsEA/EV9K2+7van7rs1mfIHJz6ue9Awll3yFhXypIbfuEYnE5GhO0NQgK8cQ==
X-Received: by 2002:a05:6808:4f14:b0:43f:75f0:3881 with SMTP id 5614622812f47-4417b38b780mr11335099b6e.31.1760546100574;
        Wed, 15 Oct 2025 09:35:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65031fb8ac8sm2365203eaf.20.2025.10.15.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:35:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v94So-0000000HS5J-2mCC;
	Wed, 15 Oct 2025 13:34:58 -0300
Date: Wed, 15 Oct 2025 13:34:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20251015163458.GI3938986@ziepe.ca>
References: <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250730132333.00006fbf@huawei.com>
 <2025073035-bulginess-rematch-b92e@gregkh>
 <b3ec55da-822a-4098-b030-4d76825f358e@arm.com>
 <20251010135922.GC3833649@ziepe.ca>
 <yq5a347kmqzn.fsf@kernel.org>
 <2025101523-evil-dole-66a3@gregkh>
 <20251015115044.GE3938986@ziepe.ca>
 <d5144c99d7c04e4ad09ed9965fa3512c203b5694.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5144c99d7c04e4ad09ed9965fa3512c203b5694.camel@HansenPartnership.com>

On Wed, Oct 15, 2025 at 11:19:41AM -0400, James Bottomley wrote:
> This came up for the SVSM as well: we want to expose things that can be
> virtual devices or other resources that the guest discovers.  Our
> conclusion was we either needed to share one of the virtual busses
> (like virtio) or do our own svsm bus.  The agreement was to implement
> our own bus, but we still haven't got around to it.

I think your own bus only makes sense if there is a structured
general discovery mechanism that can be used to automatically
enumerate the devices to create.

If you are open coding all the discovery via C tests in Linux then aux
bus is probably appropriate..

Jason

