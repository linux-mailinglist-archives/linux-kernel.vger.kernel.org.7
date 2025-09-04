Return-Path: <linux-kernel+bounces-799650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E278FB42E80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A481BC7D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3561198851;
	Thu,  4 Sep 2025 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2gBczkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E914386D;
	Thu,  4 Sep 2025 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947418; cv=none; b=p4AMsUBGZk1/X+zvLCJ+vQ4ZyEZD0tRNkZgl34cREhRpSk8b3WUjswJ8PgdKfVDUjFsIWeXvHP1jKwL+d5orlQZ0IROUEBv/wmNMwJ/YEuoOAdcbbkyznFZrlKbABXhlfDukZyzQKMvHLmUMpQw5V/NuMhAY1xOb1LPETnpSeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947418; c=relaxed/simple;
	bh=MRjllOB5k7do2Mzpzr9ZI39UjtDZA6LgQG4upFSH1zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR51AHUVJchD6lwKoX5dbVVCl9R5eQ5ie6ldtFATTuuOYjIanxcLmS5HEhk795gZqQ5s6yHdkM8amkn0RkBwTxzloyc62Xn1XzJ5OBI6y2W67+hyzwLRCPsC3UxOFGxhJ/xPcWZSzjqdPtyvlX2M9GtrgpxD86FuqkdMeKbXQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2gBczkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922C7C4CEF0;
	Thu,  4 Sep 2025 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756947417;
	bh=MRjllOB5k7do2Mzpzr9ZI39UjtDZA6LgQG4upFSH1zw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z2gBczkQxuTgSy/fBRuCQFkH+UMlEtNg+/4PPnreNwG18y3Q+5/lG+7XMJuYTgCjH
	 zbq08VeoC8Pw0PBCs77B+E2zDsXyIypZMdfEoRPYsbSS1bE6l/LK6plK5kpJAoyu2s
	 XHmAhU8iKlCEnUIq6rcdv0j9t7KZ7yvSnVMYecWsHVGqBLSuO6vh9FaNIggk+89SYE
	 88JW0g3W6a1G2xTOL5x524Y6LugqbU9uK62Z4jI7avrXUblZ8ys79PCBayPdYD3lv0
	 oRWvfprOfElPnIkn1GjsRNyLIZTrjUtKd1wGtEK9Y9/k4fr9BYWItLQvcO4vP6YNdW
	 xDbfrxXO71JcQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aff0365277aso256363866b.1;
        Wed, 03 Sep 2025 17:56:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaB5AAnIpfHtdR76jGdMrZX5dvXDOTVblpInr3Vlfu8/T/5R3kFlypqiAxjFA1F1RIrv37kHQk1+WN@vger.kernel.org, AJvYcCXwEm4gpfkojE8PS8FmMKnaXTW2J1K/DjXiEn6vQXqjlPrPItYthx1N7R7y81rQ9VKswdjP9dl3ffLAwYNO@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ90VHH+yRQ6ECHO1Y5fzDBikPJG12oOejUrEhA/DIk/KnHoqR
	3b8AmItoYscki3QAzQrmVn5/RWFXHx9ZDMJDNBOZRJMzBbYHA3XF7QnCUm3C9tXxPKIwfLpNiX/
	VGTpb5jbypizrdFPiDovMOz2o0+QBFQ==
X-Google-Smtp-Source: AGHT+IGCJNx64Dx0GkinXglHRhl6xJWhxZdgTZF8IvPhJvgB/at5VHwcouVaex4sKP/jiu6EM6MdCf4JWwq2jMCZb8k=
X-Received: by 2002:a17:907:7f1f:b0:afe:94d7:7283 with SMTP id
 a640c23a62f3a-b01083377eamr1542634966b.32.1756947416120; Wed, 03 Sep 2025
 17:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828213028.2266805-1-robh@kernel.org> <769c2a21-15c7-4c6d-84b7-cf1153106dfb@amd.com>
In-Reply-To: <769c2a21-15c7-4c6d-84b7-cf1153106dfb@amd.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Sep 2025 19:56:44 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+N6MvgqRhtoiv7AoP7y0KQr3hkJUEMe1QdsfDrqHVwDg@mail.gmail.com>
X-Gm-Features: Ac12FXwuCcu1Hb0takRvWjUhRdbrcqAmtY4oG2CObO-UzUVulsf6t_4kg0a7Ajw
Message-ID: <CAL_Jsq+N6MvgqRhtoiv7AoP7y0KQr3hkJUEMe1QdsfDrqHVwDg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: xilinx: Drop undocumented "always-on" properties
To: Michal Simek <michal.simek@amd.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Looijmans <mike.looijmans@topic.nl>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:46=E2=80=AFAM Michal Simek <michal.simek@amd.com=
> wrote:
>
> Hi,
>
> On 8/28/25 23:30, Rob Herring (Arm) wrote:
> > The "always-on" properties are not documented for "silabs,si5341"
> > binding nor used by the Linux driver, so drop them.
>
> Binding
> Documentation/devicetree/bindings/clock/silabs,si5341.txt
> doesn't contain it
> but driver drivers/clk/clk-si5341.c is reading it.
>
> 1345                 config[num].always_on =3D
> 1346                         of_property_read_bool(child, "always-on");
>
> It is there from 2019 when driver has been added.

Sigh. I checked and missed that. We should just add it to the binding.

Rob

