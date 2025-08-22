Return-Path: <linux-kernel+bounces-781302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E7CB310B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE6604645
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125B2E9EB8;
	Fri, 22 Aug 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEAf/wWt"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAA2E762C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848691; cv=none; b=Zyryl+CRIqwjtcsM6dj0APLHu0wjE0lOrgGNHXOobtNegpFLwq4Lm5ZQxjZ9pdRVw4YgUwOqpKL5IO3K53QY2f9x7e9GDfjJqRcChFeJek0tY4Ma9Qthxr0uPZxfOh4shtbvS0SAYINZQnJZ2kYaQ/j+d0/7OurPSh3j1/feibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848691; c=relaxed/simple;
	bh=faSEfiTpREL/ys4OdLzvhf7bAeARCS9tt3rUMIAif24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3jUdHnEGkF/FlMLk2hkpAVZ7EPNROdsk/1R5XQwi77FrK5ohHWcTT0xypCBxlQO73eiwAFjTjt6oiwL5fKCx9fhiEkTqzuDFjWE/9UFxhLHmgyteW4EyOgPww4r1cH3//Zeji5sWtXqT06RFGINWoVIvl8oMfG9kbJ0wADiReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gEAf/wWt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9dc55d84bso1648730f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755848688; x=1756453488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2G2vICsXO8f0ArDyQQPFAnFMYMmrHOiPk4MQY+POTA=;
        b=gEAf/wWta32pNHA4IE8oJ00dAqxUG/ZYX8oqYITQ/rJmDtVfB+/QzVWStHoch1KGLL
         c4MuTqszr8Zim4FHilnzmT/TpoclBVb9a+MJ1LHPhZ4fQ/ijNPo3DcnjBvK9SjKYQ4FF
         5UeTKO+Eae8qMyHnERnqlRxouJRYjPUt16z2TOWVWHFzTspCKGeeF86ZT9OW9MK9Pql1
         BcfwrdnwcEfX2xz0rQKvkt5OMQVW2pKfE0DcdCBnES+VVRUGO17SV8TDXL/aqdS7NXWD
         GUWjvLU8XNgSl42EL26SU4cNgwBv2aUk+sMh9CCePrTVaBcMIyk9LETgPVAf108Mr722
         9EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848688; x=1756453488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2G2vICsXO8f0ArDyQQPFAnFMYMmrHOiPk4MQY+POTA=;
        b=X3/sGoeE5UmiHmmSuljFsN8XfsYUCNWArHY4PJ3eD85BG2nT7HJGCvDTrzvKgxiRvI
         SHh+tj0JItYqSDM0gvtMODHIWPmzga5X9y0OeAjPpD35knsS9y0kazglhtrj5+bA7/Kr
         2KHMynl7kzS9rDrybJB1aHGkkI3lXq63RX1642IoYGqblWvkz3ESuAfnLATXQJMToHXV
         u/0Fbz2jPUcwvAah0Akky88y9r7oTufNcUalOuK0Gs9DEGP8YD7k+OwMlPXIkaztLuDm
         vQRRaEknJVzcrh/JtUnJXkmQGOkc4rKp0mN7Ax4EOWijgvoQ+l+bNDERx2gYrsDivaPi
         OGoA==
X-Forwarded-Encrypted: i=1; AJvYcCXXddWPRNZN+dDKsX0wEG+5a+AkFXYFxzXXy1gBeTzwXKm/I+UWFNYQo6cJE7YYsw5YRgA+rAGgl/ScLOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycqWuDqT6MqB9Ivw3oh/2hgI4PPdCNUPYZPF/gk+ZVZuCpk7Va
	CmLKUptHvsuG/RYg+FI3xX3qw2P3/lMXfY7FLrPl5+U2mtLMLAigf+nnw9GoEUnLu5b6YIWVgEO
	xM5vptTz72xrhIG9XsrlyW96MzosKk5Qs9zw1fDGV
X-Gm-Gg: ASbGncuK3tIjHCdc2THLTYOz60oYkwWmiD+kf2vey7cuL9NZNVltcIxd8c7XPm7dMXl
	mK1rEkk/jhJpCNsy22yiIiWbRsQhXw2koUjMEa3opMLVUzVVMRCzU2/EO+6PSkX1WxF7x1bE6GI
	ffFiMzflYc7M4AY7d/8r7eSXpxl+6YDJc0CflLIU8N/8T8H9rfvaVDSb+nvDsBaAwvV40VcaGq3
	8SD4HGfc905kfQVRV101CuoMqgfambbFEDvK10c6kxiQQT3yxeQoKaAg5CHmM/GNklx88krDSQV
X-Google-Smtp-Source: AGHT+IEoadB/lkuSJqNlo/SILQdpicC+7QYyIGD5rL1L8rNRHfY2sXck2SdaIgLT0kyeAavUOWBzZ7civMIWG5FymAw=
X-Received: by 2002:a05:6000:420f:b0:3b7:8c98:2f4c with SMTP id
 ffacd0b85a97d-3c5dcdfd718mr1520148f8f.33.1755848688089; Fri, 22 Aug 2025
 00:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041313.1410510-1-apopple@nvidia.com>
In-Reply-To: <20250822041313.1410510-1-apopple@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Aug 2025 09:44:36 +0200
X-Gm-Features: Ac12FXz0SxebOQqcLm-97q0sd3X8rsVm5aDZCUPIyZPEj1aHLk_XWZ8qmb8qzgM
Message-ID: <CAH5fLgiYy-9DfjL+0NoYzwD=8tTSBrFMhJveZktRncJE9czkrA@mail.gmail.com>
Subject: Re: [PATCH] rust: Update PCI resource_start()/len() to return ResourceSize
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:13=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> It's nicer to return native Rust types rather than the FFI bindings to a
> type so update the PCI resource bindings to return ResourceSize.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/pci.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index cae4e274f7766..ef949ff10a10a 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -10,7 +10,7 @@
>      devres::Devres,
>      driver,
>      error::{from_result, to_result, Result},
> -    io::{Io, IoRaw},
> +    io::{resource::ResourceSize, Io, IoRaw},

Maybe we want ResourceSize re-exported from kernel::io to make this simpler=
?

Alice

