Return-Path: <linux-kernel+bounces-861756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888FFBF39CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3143A4EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91F6322C99;
	Mon, 20 Oct 2025 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTKItf39"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B303019BF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993774; cv=none; b=JCznOJWEKU2VoZzIzFJSh1NEufde+WJM6rlxo98Ql/yqltQRB/bEyp533D1Mdhrk4oSpKsHFQeNE/+5hY8//DBNnyL10jtcaM3Py1MJGvniZ48L4U5Fl5FI6cz8+aLZIPyFEUPCaukENttjLTZRNnhaFnzhm+Ig0VN4Y0wtDAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993774; c=relaxed/simple;
	bh=KPDi/ONzbyezo/404PgKiTkyQluk8DrLj7+zoZTBiI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XesBI8vtcj4ZXlI0/mG0/yPSAqudueEeNqN9j0DKRSvZ8LQv38xOv5KdvQhV7dnt/UUQC2YmljQF+OKxOSEa4CfOG1wIN757pR3OECKsdpFex56thEpn5SfcenOPyScHHJzURphxD+LOWS17wI0orY3kuYbmosGFteU9pTaTswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTKItf39; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso5635468e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760993770; x=1761598570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPDi/ONzbyezo/404PgKiTkyQluk8DrLj7+zoZTBiI4=;
        b=jTKItf39uxktGKGA48RasuDBZo3D50hi/ecIui2L8BEF3zVdiYmOszKTAZ/6eMK9DD
         U1aZuVl/Jg6HwECql6gYQ/ajKMf9pRTfAgwQBJoJDM8+tgDkTJtrqaEz1Qy9ldQfbeOx
         sTUI3sQFDakhojlpIcHywMr14Mpn9QTnoDVQNjtRbptS9rZAJRJdKRNSd/Fi+Tt+Yaue
         lJlXTe/Lxk8coTwutqbUCa0jYIIZJwjZaBXFI+r9j4PQFsXRboFRINUgPazuMpTqkAH5
         jUfc8mgVDibicqzsUEBqA4R+h1qujQSKT/PJznGfRvnwTM4Wgh6Jvjz/tN8dHhOkBVjb
         AXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993770; x=1761598570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPDi/ONzbyezo/404PgKiTkyQluk8DrLj7+zoZTBiI4=;
        b=JsraoSMHNDQkYV8lupSWl7Fp+m/FeNnrFk6MpmMmNSOkuiikaEIn+kEcvBPtaP9ETo
         d+5SoQDDWwasOCgB/P04ryQwgnUVxWUSZL5N+Qb2LMti/BkhzVc+Aw8ipE/ntW2PnsHz
         cFtRauVzLfSWeMYOS+bCiopldgm0O1yCoNjaCm7+b7tPX61nHsdvdMXrsF9bNV2FHaGN
         U1+OPsc3WrNgzWOpCgLoh6BdWLH4wmLoRVjh6DyAlPQRJ6mjSRQf6MupQPwkoNrDxS7i
         Fd14gsI6DD94N7D/xE7U5fKDYZTywi+6xecFgpZLD6/uP7cojjEesDNQUjhcDkM0Adm+
         3LFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR70NTQsUWMljDYcX6O3IoC9ghyoMDAggr1szIrM9sCvfh2jh3WGPiQdR5TK7+vys8shMuQj7z2BTwBUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyIVXvId+W1Oo29HKyazKYLIDNdQsfPjNOK34aP67xNPKs9TU
	0b616qq/0XUntCNy+VQ48y0//mM726EYIas3GWrdDYamoJuWvQkjFxPvEosiqXXvyCrPiHbeojo
	0VQtrj+L2TLkd0n6JZ0DJSYncoXqBmIvIkLBSWgJdng==
X-Gm-Gg: ASbGncsbXP0Ubsmyg71ZmM6iGrmsoeqJsn6ZHyN4pen3ItfSKHTya/Es2LKjiGo4Op6
	OPIMJD+Grds+fx2FVoqphnT0DUgNoQJm9eaqnbTz06xL0HoJdZv0C+zmZq3Cy6SPcEmhmOjQPKd
	JHhnL6mZrH38LvLr9YiYQ4XLvuqm6moAbOOqxWoW2n8yFRPyeVhpRj8OI7Sz2E6VYCbes1iG7RC
	bo1MuNlcvt9uLlm2wJyvUnG6NOtaXzIInCIHuH3K0cis6JJqHjU9WseOiQyCl3USEhIvbI=
X-Google-Smtp-Source: AGHT+IGRBR+snc/mrP1nvrB/wKqtP60la1CSY+obenGlvqYErOCTks8k7mteVD4O1yzHKYMcoV2tSKBToVA+O8Sh4TE=
X-Received: by 2002:a05:651c:12c5:b0:36f:284:56db with SMTP id
 38308e7fff4ca-37797a0e741mr41754291fa.23.1760993769829; Mon, 20 Oct 2025
 13:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013191207.4135075-1-robh@kernel.org>
In-Reply-To: <20251013191207.4135075-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 Oct 2025 22:55:58 +0200
X-Gm-Features: AS18NWCmdoPe9mUqm07LgesYzmI47cpuULBkrErXJf6vFAkis6yJb50IYSgtdOw
Message-ID: <CACRpkdZDM8zMtuPQ6rQQ+TZhz4bAYOepeETVQ34_MfDYx0LMmA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert actions,s700-pinctrl to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:12=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Convert the actions,s700-pinctrl binding to DT schema format. It's a
> straight-forward conversion.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

No comments for a week so patch applied.

Yours,
Linus Walleij

