Return-Path: <linux-kernel+bounces-880201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8310C2519A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B921B21655
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4B346FCC;
	Fri, 31 Oct 2025 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbVfHkxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640611F2BAD;
	Fri, 31 Oct 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915016; cv=none; b=jg7fPPlNXaDK1ef5NT0oPT+vVGud/b2R+YQ8XJB2mBvk5xsTtWNrH9GZtb2TgyhWPNVqx+1Jldr6eSpqUJfb7uX/CnNg5nL7Q1SsizhMZ99c1h9tjQNmDvWb79IGnVXbLttilTte2HkxhtbiGKOhy0ScHxCfapYmQ5jYPVbzul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915016; c=relaxed/simple;
	bh=OTjMDonvY6N5Z54OL6u4Od3iceOioJU+g1NjtVl5uFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PkyQDSddzFninmXQMlSb1pM7Zo0QMQqHasdQfxryUblg2cG+ww4xggwdgcinBL6F9FwReAGOjz5JjGaczqfucJveppJw5p/xARO0Czy54iLE1nBu70aWGal+7XMSHuTtpAw/5Q6CTnxItM2fS1tEaupFmFKQS42xPvmRucgw7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbVfHkxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCB5C4CEF8;
	Fri, 31 Oct 2025 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761915015;
	bh=OTjMDonvY6N5Z54OL6u4Od3iceOioJU+g1NjtVl5uFk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=QbVfHkxEsw0CFRDYYeok+4QQje3dJ74Vlb8o0Fti5K+lzLBGo2vAXLWxR4WT7oSU/
	 qOYFddIi1vM7RsQ8eeY6ID7fVTno7+rugujGswtMPmOjwj6OYp6H8olJZqmX8/AJmz
	 pqquFGiN09WPuSQ2OrQpSwoHtSRSIO6PU7JAN6e+0UmPCLf8NuYmuVUVLGjwCEjOAE
	 6FOYBGq2ViCmS3NgRqw5APXzRxIhrVdkdPEdTsZ09hrV95ns8GM1dybmVXqaeNN7gQ
	 ag571KuNbgsnapvispXqXkbpZqdNpDkkWOkP/RRooez9YwZzEgE70GxYtNkClN40qQ
	 LVyf2Qv4sDbSw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Oct 2025 13:50:09 +0100
Message-Id: <DDWIQTE4F3XB.I1ZSB58P7O88@kernel.org>
Subject: Re: [PATCH v3 5/5] sample: rust: pci: add tests for config space
 routines
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030154842.450518-1-zhiw@nvidia.com>
 <20251030154842.450518-6-zhiw@nvidia.com>
In-Reply-To: <20251030154842.450518-6-zhiw@nvidia.com>

On Thu Oct 30, 2025 at 4:48 PM CET, Zhi Wang wrote:
> +    fn config_space(pdev: &pci::Device<Core>) -> Result {
> +        let config =3D pdev.config_space()?;
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space try_read8 rev ID: {:x}\n",
> +            config.try_read8(0x8)?
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space try_read16 vendor ID: {:x}\n",
> +            config.try_read16(0)?
> +        );
> +
> +        dev_info!(
> +            pdev.as_ref(),
> +            "pci-testdev config space try_read32 BAR 0: {:x}\n",
> +            config.try_read32(0x10)?
> +        );
> +
> +        Ok(())
> +    }
>  }

Please use the infallible accessors and add a TODO to use the register!() m=
acro
for defining PCI configuration space registers once it has been move out of
nova-core.

