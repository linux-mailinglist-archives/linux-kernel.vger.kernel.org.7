Return-Path: <linux-kernel+bounces-888599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A99C3B463
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE401A448C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161E3328E1;
	Thu,  6 Nov 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RejsDbjP"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8432D0E6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436080; cv=none; b=iK7DQWYN5EbewSqZId0HyIpZal2DFm9krePqMoJj4DLcO1bFCH3XWdOxfIDC8eS4fvuXjtAxt/9tcEKU3h+yIMYn2DEONRV3ILJympMBNiV/U5O6cGurUwSs8gUiZ8kyGG1ajjj06EhBtmyBn6/llMmyRTdCHLwjAC3B1Ez3k2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436080; c=relaxed/simple;
	bh=j9SuhjIVPNBBqJfnVLYcJU6kiIExeCsnHgyWendxW+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdTAXa3ICDUTXc58atUvjMyZEVHy1joqMM2PBCNWoTZOA/bhxYbTfTuZN2vo4sKmHqSfHrGXu/v7O7a1jmj3xhlPDUOWwo8bzXi4+9Xeez1eb3/9AZGD5976Gk9whIRCV/nk7XXZnfG+mVr5fcd4P/vlzctWjo/hFWrEnuWR3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RejsDbjP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29498a10972so1228605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762436079; x=1763040879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAPFc6E2cuOBznS+PFsa8uaGEFuFxns4wE3SuTksKDk=;
        b=RejsDbjP2jbgpCpqsdNG6OMV13aH6dy2qkkZoZiMhJdYvPthSskFOjy1WXWxigrFfT
         x0zrGjVhvmGenH8bAspZjjV6n30oMIHvkpUflefZtXs50vZ6TmG6tE5EpfV83MSevzRu
         /MRSVUH8RVDdhxZF6tkVgGOHj8dKEG+xvhgcu3sgjaCs7FxGjqXu3rW65Fc3DV/8qiLN
         ksxt7atx1AX3oZTtyoEI2WsTP86YA4G1TjOGtdUPw2vAsopxkkDdqpkHD2CKB3vWn/0t
         1eZrI8a/qn9JldEtgP0NGSzIU6nKrrST3EzNlwA4bJ4TIDNqMd5A8JUXHCVa1xGffE/A
         M41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436079; x=1763040879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAPFc6E2cuOBznS+PFsa8uaGEFuFxns4wE3SuTksKDk=;
        b=d3a8WSHa6E+Y5LF3PX8gdZBEH9LB+7FmIxDmsA8r/A1iIFlN/90oeSapdUE3PUcEfh
         RCtnw9u1X0Iz4krZ5SmAEWEKoIPF9u2+qN7e7K9dfwgtt3t3mPWoacvAtAO98Ol0cQgR
         jVItr3K5VO93BM5GE/AfH9Yd56NOwg4ZTAfIVillwoZ/iHQDP2eySy1ACRgB8iArrVmo
         0XU2kSRgIuf/KPXaA791Hb54mXp3Et6KhEy7tf09DjUQVRBWVuW9bHEVqKVUB0TnfBbw
         IE8ppKpbD0NhgMdEIeX3BBDG10SDkXSZ1Njm3eyf4BAl5l/2YXd1Mq9Tec7714+i9pYL
         bdTw==
X-Forwarded-Encrypted: i=1; AJvYcCWkGwmaAYyxzu0l0JjD0dulC6riOoi5gKAUMtBvi5y1MRgOaE8Ek6uK+qCAT5HOBfnWfa/yA+ze4MQhD4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzoEk3Iz0FSO0yV+voHP3KNnBz7SNVQTgb/DOmmvKMUVIQkPc
	9aNOKxOJbFkjgg7AC5n2UKKoKkUI/kJ+TMFrtWl9FkPCRcH4L9r5RuUD/OM3O2qRW9HaA9FYHns
	/+Z+e4TrIZS96eUCflQWLPY7liimiQjQ=
X-Gm-Gg: ASbGncvAhd6QJT7HU04SKnYFv7Uj/+pt2yOiZxjnLmeWnuLvEAaOg0yrVuHxqNAVTam
	10LhOiLDeP7sWpTvY1c/GtOw+sa30e1mJ+jSyTlqH+B8kJ6vFKHBu68QBlLnSixYOLVDXN0Sdw+
	ZqeHObAtorBzCMCJLF2rz0RUfQjdMp1AMNDnYSjO0R9w2ZwI910KgqEQLBTX/Sim93NlUQI8Psw
	ml6z0zqUXx8dVbx8Da9VTwAFA9R1YLBn6WuynQ96tUI4s3Zo/O9KfWx3VFNAkpsQcK1Poha4Qs4
	F2li/7llakK8jGNQRKy64E/4OyRgxfePWjQ8e8a7ZTkwhmcs+xgbvp3MQRz/AVmiZEPaBgOZuHO
	K1Eg=
X-Google-Smtp-Source: AGHT+IFgsu64H5AxVDYQ4VC1AtIntPLrClhNs2DhzecuOxKsWfCafPqovP7OzWqL14ZLgcHX93hNFscreoxfb/7qqJM=
X-Received: by 2002:a17:902:d2c5:b0:290:ad79:c617 with SMTP id
 d9443c01a7336-2962adb0131mr50508655ad.1.1762436078666; Thu, 06 Nov 2025
 05:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106102753.2976-1-zhiw@nvidia.com> <20251106102753.2976-3-zhiw@nvidia.com>
In-Reply-To: <20251106102753.2976-3-zhiw@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Nov 2025 14:34:25 +0100
X-Gm-Features: AWmQ_bkZlBPvsV_cw8dYZQNsheLfRuBL-Y7e_Ty1STSrCFE-bOnmtmTHqEfXIAE
Message-ID: <CANiq72kE9QFdAP2cTjBaxwsQ_H=BmMyabY9vSWUdfj0Ai0QZCA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] rust: devres: style for imports
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com, 
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org, 
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, acourbot@nvidia.com, 
	joelagnelf@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:28=E2=80=AFAM Zhi Wang <zhiw@nvidia.com> wrote:
>
> +///     device::{Bound, Device},

Is this one converted?

> +    /// # use kernel::{
> +    ///     device::Core,

This hides only the first line, which will look quite confusing when
rendered -- please double-check with the `rustdoc` target.

Thanks!

Cheers,
Miguel

