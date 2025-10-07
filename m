Return-Path: <linux-kernel+bounces-844736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C441DBC2A18
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9B13C681F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75D23B61B;
	Tue,  7 Oct 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHQtwXtJ"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3421D5ABA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868497; cv=none; b=V0iugeWOza36i46FLTE3JnKr2xbBNGjV46CFl790LYwZkFnQ7eupw/WYWPMRsgefWxIZYF0iyOfIjHZdSka6ZbsBQ4xKENWq+dsV/sUSB4XRNCqYUOqz1fjL+v4r5GlH01Gzkeb/vFQp3qUG8vYP2U4QWfP0b6qzMN6XGm0WY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868497; c=relaxed/simple;
	bh=t4kdCtbMpSolLUWzyca+TrSgBjxKOUaqCLIHEI3NSpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti2cA2KtVACGVfkpPr1rvND612qfXFXWSUbpKawn+2W8MENk87ScTs7pXyRr32pwEJ9mTsFlz5wSBy/xmLDHUHYGgWocO5c1zcLNBoiakrKMcUAznIOHps0eiZiLyu0k99cZBLyr/Ht1GhAHmWkoDN81b6uz1uNjAKE2lte6c+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHQtwXtJ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6456dd98f36so3375942eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868493; x=1760473293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4kdCtbMpSolLUWzyca+TrSgBjxKOUaqCLIHEI3NSpw=;
        b=hHQtwXtJEEpxiy2cS8AfLKG6xMyZxsA6Brt/B7Pz4bW3nn1/UByh/OWZUexJZUnXl5
         sVOrV0aU0jFZyzdZ/QmpdsU3X235GeiZhQ1PXVUBOiwACIDN2S3dzM/gT20qJMyWx+BM
         FNPrOuNYx1x2hUHqJ9Hqz4+ne7g5v/RD8uJJfEftNUbmP/S3jy081s7580w8iYI5KPtI
         FK/lzh2dp4FKJFkf2/eP9CrlWD8k6TzKcNG9Evz5/i9qEsR8ws461flW4ZuGPmnAdtSY
         DxPI2dK/hH4mzJM8pp592lfSbrvolnUZW0PITfFjLfdOVxnaEI5tAC5Qqjjvc0F8jze1
         mVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868493; x=1760473293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4kdCtbMpSolLUWzyca+TrSgBjxKOUaqCLIHEI3NSpw=;
        b=n98sZ4ec6dATgXk1a2YAFVsd5PP/f+AHJNIRO5MLBrQ3uEiIBoV8SpVat5eGfh5TdF
         aTOp52abymEoccWwbBrqWXQ0EySBAGE7eb84CXiMUsWXvQ6ajBP3lhaMMfyyUwlQb6WF
         gfWzLgyOpDkGBYPFbX2W48dGiJPM6Rw9G3RXRdhOUoJ2Ctj2SRTond734r4FGRImCWN6
         lwJlacocazOUccZvHr6KLCfLx98L2UcApvF/BsIYjKI9yTF/IpNBmEtiGX+RFVcI/3AO
         tr47XUltn5wdXsqOqm+2Ue/LB2K5PPtqpV0MLeNb4+nhoNPh7Kob9v+mbY7m/Zsc6SvF
         36BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0j5IPaTWqNbabZFX8VgobeYdcuW/tsBT05X65e1APS00hUHYPpnVp/CuSfHBW3ulQ3h3K0JMe8e5+2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMktu2/d/6j5ZQnaQCVO+Bu47W1TR+hd8BIvbQNecoRM2FyUOt
	Edh2exNhdRJ+sYAUqac0umxf+PqZTx1LB1PzIVMQ+c/gU0lGRmuclqFeTaKq0E8rWa7HuQinsJW
	pquFEaXuDCnJnnFwptT9cy7WfnudlfKnOwcbmNiYdyg==
X-Gm-Gg: ASbGncs1bDM2blvhnNMRwFa8UyZBXinnBt2ZGD4iXNjJwZrHDzU8Cy96b+RdEjoNAcU
	BYsWDQ/FVEIKU8yYskmEMh/loPpCj2qQ0WwGsUBDFNhZt6+a0e282+gHy8EpdG6GSoix+4d8nza
	s1dnqdQSO01RTMX53SgTTxz1rAWANxhCHoQPfWEX5BzqffRVxAKpNYmKnDfoYeU+lfEH7hI4k23
	T11gfeIcKm1jyaJCCHmVngJ32rY7zKFdzRzuQ==
X-Google-Smtp-Source: AGHT+IFpXtTl/XW7xSv6EAre9JtZi5PYEJL3Nxxq8Z5J/VjHzSG4hRXvlO0e3SJ/ojRDNDKk3AnJrSSYwAUNIg/KUXU=
X-Received: by 2002:a05:6808:e8d:b0:437:f364:8361 with SMTP id
 5614622812f47-4417b36da9emr428435b6e.11.1759868493573; Tue, 07 Oct 2025
 13:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-power-domains-clock-google-gs101-clock-v1-1-1ee73c453ba8@linaro.org>
In-Reply-To: <20251007-power-domains-clock-google-gs101-clock-v1-1-1ee73c453ba8@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:21:21 +0100
X-Gm-Features: AS18NWCC9b83T6F2zFo4-esWHDAnbT_8yqAmmeWUhP__nUnwGaXjsaGNRCUZonU
Message-ID: <CADrjBPqAXYBsjPaG0w2tdA7EAW93x=DU_OxrEeyuGKByhyG5vw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: google,gs101-clock: add power-domains
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 at 17:03, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The CMU can be part of a power domain, so we need to allow the relevant
> property 'power-domains'.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

