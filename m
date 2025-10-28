Return-Path: <linux-kernel+bounces-874595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B0C16A64
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37AD3B7884
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85603350299;
	Tue, 28 Oct 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6nQsGo6"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D89258EF6
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680561; cv=none; b=Q62w1d1NPacmd3SMkJ42p91u42rUIK7iWskyh0eX5UyNrtHKmfYmmnHUUVJzbEDOhKbdeGt/HpWDwJ8GUQk6vt6erGT/MIivua1euRq7QBUo8WiayOzM6pVl7UgdMN0cmbC6uPtmsKhuiFARsiAMuJzpKgcpVmujTfxiM+lciKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680561; c=relaxed/simple;
	bh=SJ0CRbBd4WlB7/tYPTMKkatZHlzIjiiD+n9S27deXj0=;
	h=Mime-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peJon69doSy8Hw+rBzOtKMwoKPzmFwOvw3gpv7DA+jY3teltO7J7lDgtvtdqnPu1oYR2O5dsFUy7vtnPr9J/v4rects9bGthVm5tH89K2qcs4hegJyVaPaPxjufrvf+CsggwPfP1F23LsOxwKoYMOCqlnBvssoUjGmTjS1v5avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6nQsGo6; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso13723782a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761680559; x=1762285359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62vvDBBB/rOaWpDgtEM9Rt/abCOhovCwo7YMTy41U/A=;
        b=U6nQsGo6dEGcNksZPWFWXp0RBNjVysUocQinhGp9i+5pUPKNWt+UUPLBK1qzSi8aqR
         W5CsyiDF2tkoMpKB/jHRCFYHydynSRQ/RY1UMn0KqE/zI7g2GGU5YE+TO83e4TCSkBkF
         yFV9haZllwa+08wNC3kHdthX92CJHIDEMN4MdC1RBiV2ZMsmh3j2Xxj0aZhrVxmhFBWJ
         NfmYGjgjSVgnCM7WaCLR4tDBQz9L4wissVA7NZO3EDT5La3WfJ1wB6X+F8xwol0RWzkR
         al+/9n4bnZHkjv/vQlClGctbGHVoMyiInFAxKEvF7+CZ1CvTcESodGhMQUn/NQWnTAS1
         P/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680559; x=1762285359;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62vvDBBB/rOaWpDgtEM9Rt/abCOhovCwo7YMTy41U/A=;
        b=DIGT8v/oWGVlolMbeUg5Q10l8irWK+R1epyvSvxAuLVFmAJGnINVgs5pnyvYrvfCOx
         BXZcpKvn0XjyL18J5kzecENV+9gGt8j8uJ+/0IJ9ZX21yNW7smXbE49F/Z/zsXxHV83X
         fgQYkOgTLq8WYdH9FXdR+Lmk1GxFwp62diBgNiSn5rjPF/n1Utn25pruAefDS+bwj9UH
         3wXVc/Geux+eXjdCEecQQlY9gj3zwpyL751mlxUeR+HShFzEfuj8mtqo1GrHs5imoMSp
         GZ5WxxDoaS3v+qVaPTZ4T+ZP4fwGxGbQBd0RbAUsUOspy5dU5Ui6Pz3Jed3eC51wnC7L
         tHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj4FZ2flsAVN2psKH5SvbNgLVo2TJF/MHeRVqRW8QjCf/PDzrn7sDRjxm4Rp8LssGP60Nrqph8pKFzWo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzugkCcqmmGv0LJvkP9w8yv62OmEYGmG4p/fbXOQzfRrASw+yhf
	894SOSo9fI8p8WgW1OngrQ0MJatG1V1JJeiHUx9BCHTAFNDZ5JZJCh3cmP3MInZsgs/WSH6xB03
	PBO3dPPT2HeJJwzt09JUTg0GkV2hbxYs=
X-Gm-Gg: ASbGnct7YQTEn+soaYERdKmWqQsP/H4DMdeoympMWQJPEJRvGmHAhPq7/HhkBzQ8+Ig
	iSdqGV1DuWzCcRmJPoW/5eEGDyjL21jUDgJ15E4812+kJTAYMRuGzDRAgDZ3jAHjC6hIc2ZdhO+
	KdxuTstWiKz6dVUbbeyU75O/Ak1Td4b0RZA8ZMaZUEN8KLlgHcthiJHabHI3zDTnvCUnA0oTUQr
	5jh52BkIeA/ZDlrk1OJa3hSkB+aC2dPVwLwNiOa/zCvAhTrPUailu2I85Q=
X-Google-Smtp-Source: AGHT+IGuyzMZMoSUBcdluhWJ8z2U2NKreqWEsNAWWKSsPdZyGxxSF7LB6m8ffRoMaRK71OGRlbTX0MthE+/GR0ExXdY=
X-Received: by 2002:a17:907:9448:b0:b6d:4cdd:e375 with SMTP id
 a640c23a62f3a-b703d2dac74mr22693866b.11.1761680558394; Tue, 28 Oct 2025
 12:42:38 -0700 (PDT)
Received: from 724652696919 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 12:42:36 -0700
Received: from 724652696919 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Oct 2025 12:42:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20251028-haste-amusing-78c28e834b5b@spud>
References: <20251028-haste-amusing-78c28e834b5b@spud>
From: Coia Prant <coiaprant@gmail.com>
Date: Tue, 28 Oct 2025 12:42:36 -0700
X-Gm-Features: AWmQ_blTfxgti-krwDFdX4C-MNUtu-qJWXUIoxjGku4ymfFwik-GWE6bubjvmIA
Message-ID: <CALj3r0haeTdNt7=cMqRa0i3j29P8e2oQ-TzsgZfCCG6cB0q=3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add NineTripod
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

One more thing:
I sent the v4 series of patches.
v3 is now outdated, although [1/3] of the patches are the same as v4 (

https://lore.kernel.org/all/20251026150358.1078453-1-coiaprant@gmail.com/

Thanks :)

2025-10-28 19:35 (GMT+00:00), Conor Dooley <conor@kernel.org> said:
> On Sun, Oct 26, 2025 at 10:36:44PM +0800, Coia Prant wrote:
> Add NineTripod to the vendor prefixes.
>
> Signed-off-by: Coia Prant
> ---
> Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index f1d188200..37687737e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1124,6 +1124,8 @@ patternProperties:
> description: National Instruments
> "^nicera,.*":
> description: Nippon Ceramic Co., Ltd.
> +  "^ninetripod,.*":
> Why ninetripod instead of 9tripod? That's what the company uses and in
> the marketing fluff for the boards.
> +    description: Shenzhen 9Tripod Innovation and Development CO., LTD.
> "^nintendo,.*":
> description: Nintendo
> "^nlt,.*":
> --
> 2.47.3
>

