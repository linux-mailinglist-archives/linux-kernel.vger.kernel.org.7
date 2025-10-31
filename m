Return-Path: <linux-kernel+bounces-880984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17DC27208
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08454E4EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0932BF54;
	Fri, 31 Oct 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmqv0t4r"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABE27280B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761949737; cv=none; b=uU4nTn3TXSHaIBbsciNMBpGwAhN5g5JkiXI9Pzcb9XzjYdduR2nhT1i1++mCKV5sb+KDrR9AQUU7eB3Ph71CYu8q72SEpmzFWeuoFegsS/Knl+5819SUUQAls5nUn1PsGbk+Sq2jAw15Sd9JoS6rMPtbMqDKLDFFbv+fH2bTTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761949737; c=relaxed/simple;
	bh=VZXcKlS2NfJQUqJUaLkoMO31MbXfEPxVU5q67dhNYbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su21AXzfPbUlkVt24//319Z670wMTGA/BeawpCPa2FfeNJc3uQmenPwhJLLMFIJ7RvIFkjKbQmCKlrJbTHG32DsieyjUpVE4PYuosuS541ZFkmK0pi9ymv1a0TDboJL2A2fdqFC8FIGJtqY4l1+vAPHbJPCvCl8iBf/qG3S0H6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmqv0t4r; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594236810b5so344480e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761949734; x=1762554534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4VDPOkfEPN3V+mmkEOqmJfTYjVG4ZaMp9wTEce6ggY=;
        b=kmqv0t4rwZ+OooujAZB89C6U1PE4NY/hxG/N3arnBNvt6gcdI5fjWrSGf9YrcyXxKN
         yGg9J1HH/8TDQyiQiH1cwV2QnT74vWm7ZDyzcEYxuprajEkVaX4f/gJzwKnq1HfQ20ZI
         X/H4W9dQ2Sgb7YJMKmtl9Y68AnxuYX3owuhcNhD5/lBrRXvnr8VB6MuiuH4tYrGBphz1
         FtPytlwa3a6X1saOPHQg4ZaGJlMimZNSNYSsVunvrU6M11Y6f++bi+QoWO4mJJIvDi44
         uv6MJFrni1aUExCr/m8s6EQTGCu1qWpjXecUUFYn+kyCivXg8JeMiTaqkLgHZZqwIxn1
         jxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761949734; x=1762554534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4VDPOkfEPN3V+mmkEOqmJfTYjVG4ZaMp9wTEce6ggY=;
        b=MIDChURenMYcX4PVKkbEGRAiL4STny72cIfqBrxDK+FobpjlswebWBbvGnOEWilkA3
         psmtOr+GqoUBjpBrgYKwrLrjo2PWRq1100jgai+3BHfhP7W3n4tN7/0m/KCck9ON3pW8
         n3Xre5QEDgpLI2Y5hOEAOH/nlx0S0jm9otak5k/LGuH9cbGIdeEyNs9+emRFeNmkZZ3c
         Dxiswq+3A/bzvOBT/1K01v8us1faZYl4TsXfCL0dNCKC9h3hWgxbQ+0MINg64OavOodd
         XU+bri7TsHvPTmJhGJzQXdgrOridTbadU7YAcgkWlBN5YvszRHzfvaXLEdk3cBceyAqs
         UqGw==
X-Forwarded-Encrypted: i=1; AJvYcCWxr1hEjBikVkaudy0yGbJYAEtLHfmlTMwV+hFxA6GW3+sGBPRp9hxRlcVkBQI5eLydy2oj/Lh6sq5NzPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZOiBPZ4+Vv2T1AXvpIj9Ny/lZtQx4WsXUNHEbA+0aNNZ8KUpR
	ZjBQ4T5ZE1d6PJeEWyclpTLccRuwVxi2sGI4D8KZJoKTYJv4An9bCRIjIqbJRe6NUoDz91Gs+p/
	QoX5ivLF1jwkfpvL6RZGyiLdkhkv4QYrQi2SaTLOz
X-Gm-Gg: ASbGnctW4Nc+M4dawoYHIeU1YNdlBIW5Wt58JDlCTXnUjhRxIosn6tTr8sDLaH9v2dY
	6gXJ8AAMs1LokRi8Z5v4DmJ2Noul7rX04AN2HgSUTgCbKGCBrfpvHw7Ugb4YtfM+N8/h4vSfJNt
	RhdIAi51KJYUer/Pa1oSdypR7OU88U/E0K7WS64xRCe2txAfMSe4zsNm4acNaI+yXf1m6H+9bYE
	urr2gUz216gJnDy1TRu0jmnCl/R5vX8gvkcLPkyg1K9HTyT2WcAhYSOycFtGUDkPPuCoQU=
X-Google-Smtp-Source: AGHT+IFSwcMwTIDGFtEaqjdkz/AcJl72mmVl0IpQ+J78Aae+a4oANLR7hdtuxWyAxkV1yPdEbNFPfRUD01apBcVpx5M=
X-Received: by 2002:a05:6512:15a1:b0:593:11bd:9af7 with SMTP id
 2adb3069b0e04-5941d5586cemr1780294e87.36.1761949734165; Fri, 31 Oct 2025
 15:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-6-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-6-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 15:28:27 -0700
X-Gm-Features: AWmQ_bkJhwWK8iLPcHy-hUK2RP4WggOSXosGGLXjIhn9TKPWrHQgEkrODFylvq4
Message-ID: <CALzav=f9tjgyF7TBsfjCpmvRezkkgfQY-OXwj+TaebjeffK-0A@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] vfio/pci: Register VFIO live update file
 handler to Live Update Orchestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, pasha.tatashin@soleen.com, jgg@ziepe.ca, 
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org, 
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, 
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
> +static const struct liveupdate_file_ops vfio_pci_luo_fops =3D {
> +       .retrieve =3D vfio_pci_liveupdate_retrieve,
> +       .can_preserve =3D vfio_pci_liveupdate_can_preserve,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static struct liveupdate_file_handler vfio_pci_luo_handler =3D {
> +       .ops =3D &vfio_pci_luo_fops,
> +       .compatible =3D "vfio-v1",
> +};
> +
> +void __init vfio_pci_liveupdate_init(void)
> +{
> +       int err =3D liveupdate_register_file_handler(&vfio_pci_luo_handle=
r);
> +
> +       if (err)
> +               pr_err("VFIO PCI liveupdate file handler register failed,=
 error %d.\n", err);
> +}

Alex and Jason, should this go in the top-level VFIO directory? And
then have all the preservation logic go through vfio_device_ops? That
would make Live Update support for VFIO cdev files extensible to other
drivers in the future.

