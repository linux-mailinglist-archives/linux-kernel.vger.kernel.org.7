Return-Path: <linux-kernel+bounces-824593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A226B89A34
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74951B22EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE28226D02;
	Fri, 19 Sep 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuRwWgr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A01C862E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287863; cv=none; b=GLjAJwfiAv6EPCa2ydNb7wZHNnffnYZ/PpoWMvJCVBn86Kjk5PL29wMag+tET4NxhRUrsc5Z5aBcMISLFirVj44kBRufaDiKn/KC5WurrJbzYLIk7y7+wGfC8hCZpnNHX/K61KqoXgPuM3XGa+gWGxnQmW3/J97QixUNy4yvbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287863; c=relaxed/simple;
	bh=P+tk1VfFUOofOPLUQsU/UlXgqHr3TVygBRXFlzWo5xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbfiYjdLDuzwW3sV4IvHMHvH/S97DyDo8Zus5H2BGnAKdRNctoZulcaCzViBOD0YWRWz1giGhF6sEiMY2Bmrhl2NS48kp5yRwJY/SLlu6DX05G0PVEaOcJlblUKgmcRYlpOSbWNvDZH1UuRDu7AE8sj7tjQqOF0PjcgA/+C/4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuRwWgr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F5EC4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758287863;
	bh=P+tk1VfFUOofOPLUQsU/UlXgqHr3TVygBRXFlzWo5xw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WuRwWgr5OhXq/DI7H37tILKtu1xg7sB/EO6Yjny2mVVgfLEyLMI62qgnuW7KBbaHC
	 InL2lCbxz7IZgFZQ4yiU7b1GvhowypVCUQ3zMJZkG/2ljsDkLrQSrcUhcz4gfLj0KZ
	 UuAw2BkI9pOnd3YuchbWvuebtBqsir2K4CWrioOHeDStwglbk2VveaBhrXGkbClk6p
	 HMg5lfyIj/5N/hGGJf84ntT9oBqb43X+NDXEunzf0zvzlaOpDA3RZzJ3rNXE4cB2tJ
	 i35sga197zXI/AOoe9NYZePNZEgUC86IS0CcTqWMdTXuXSr4Lxh+w0taGzKZU8ZJay
	 P7tI1DXlWYfsA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336dd55aae1so20433861fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:17:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2jouUdhh8qHq70VRQfMU1KSqdVbEokg3hfLMDN61l4sYzU4a8gqAfnknWNw8Rau7jtbnnL5Pv1CFoNq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnq/sy9ZcNdDsotlhaytjTOIES8WOgKRiGrj+Hmq4tr79vVKn
	mqLIVsqpoH0TlnjDK3oqh4nTUrk7/J/ZoJ+M1RFL7oEdtscgrEufy8P7+Phx4IDKsQPqtb7HuyE
	pDUvknPYZFbdKL7ZM8ivbIDrdxiZU8J4=
X-Google-Smtp-Source: AGHT+IFNLf++kbEIzx0OThSpG6tJqnAviAc6B/6DY8ZrvAETXBFW5NgJWfZTYT0yTkTslywqHEe3WA/DssvPTebSj54=
X-Received: by 2002:a05:651c:435a:10b0:338:735:8a79 with SMTP id
 38308e7fff4ca-36413c2c413mr8029421fa.1.1758287861610; Fri, 19 Sep 2025
 06:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919122321.946462-1-abarnas@google.com>
In-Reply-To: <20250919122321.946462-1-abarnas@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Sep 2025 15:17:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGe=HR7EvMs8D=7Uvr4Vhr7fXp56YQ9A10xdF1V1M71zw@mail.gmail.com>
X-Gm-Features: AS18NWDEaphGD0PnhTnMmMFn4cfpLzT-Is82GGDvSOsC9sPyIGDQ62hIiSlVl0M
Message-ID: <CAMj1kXGe=HR7EvMs8D=7Uvr4Vhr7fXp56YQ9A10xdF1V1M71zw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: modules: Reject loading of malformed modules
To: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Adrian,

On Fri, 19 Sept 2025 at 14:23, Adrian Barna=C5=9B <abarnas@google.com> wrot=
e:
>
> Hi,
>
> Here are a couple of patches to reject the loading of malformed modules
> on arm64 when the SCS patching is only partially applied or we detect
> an alternative callback function used in the module text.
>
> The SCS issue is largely theoretical. The code currently performs
> a "dry-run" (which we remove), and leave module code as-is if failed.
> However the latter issue was reported to crash the kernel at [1].
>

Why are you fixing this largely theoretical issue along with the
callback alternatives patching? The referenced thread only talks about
the latter, right?

