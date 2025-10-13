Return-Path: <linux-kernel+bounces-850327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31048BD285B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 869104E23ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A372FF14C;
	Mon, 13 Oct 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOYeIodv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8914A8B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350731; cv=none; b=i7Q0sBhbb+FK/mazYJM4JUpEFj4lt5X2DGV6C9ThgJsS9o8DzOjkGxIKBIdghK7Tje7Z4oRDBStl/BAP5MRoz4yHb1t9HDVWs07FAg4+xGuoQ3rGxenJ+1eigTUcd+uQzCRjk5hxit0dQLLLwcVibEPkYk71c6tuPQBFjaoIAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350731; c=relaxed/simple;
	bh=KFlkKhsToSNiIVYTfCINycSlYKnfIJUcU3TZviU7e8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/t2dlZIFm9Yp9+tVpJMBWMyIPEa4TuEvC9bCAFkvB1qBI4uvewupC7ODIapMguxsBDPZyfbbsN9EJlUk3HFoheAL/BrM0Dfu/TMD4CQgPJn3zuCSijb9m4JSRzHaR5xJGNE3m1tLdJOW8Z8HOBLtBWvA1o0nRlpADir0v1Vwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iOYeIodv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso4694731e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760350726; x=1760955526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFlkKhsToSNiIVYTfCINycSlYKnfIJUcU3TZviU7e8s=;
        b=iOYeIodvXtyaDUddlGM3xY01yXtcs4HazKQJXzb7o04o2e+Kpc92Ho1TVxyKcXNhFB
         eOau02nQeA7e1WlcsHmrBVIUA8efKRqzGfzkUjMnPCjv2FBSPWOZyHlGs0bVCVkmg2Mx
         kK7T16uivR7cXXl4Y+H0zQqI0vySyTNuLZAPSNYweaS0MqUkpF6dsCsxFgsRqUKwCWB4
         4zoFW43ef7+wSOMasn8lqZKpeMWZBcx14JRNJoHtt+aUiTSuiVms05MQWNq/AxYQYEyw
         aQ+ft//IRDU2OXVJQd9cHvgmpWMqjEK6b3leILKyem3Rhg57l3ieCIys7lEpeHwQE6FI
         4sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350726; x=1760955526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFlkKhsToSNiIVYTfCINycSlYKnfIJUcU3TZviU7e8s=;
        b=VLCWDt8K91ngQK6iZBWqCEyY8rpQIDJynTDnKqkRyl/LCkE6XlZ/NvJ0yyfQNS0p/N
         dgUe5ndbuY+WaPvSaH/6UrDoEW4IfaYwplgMh+AO6Gj3dmXvIcthRwDnP9FbJZxvLG8r
         C8oYL2rZp3H/vpIwtk66+O/FerExDSOxLyoUsf8N9Iemi70YEr26It3REyziqxtrTLPL
         1NlsUTXl1NwLRamAom5NnelkhqBZ9owMG1TvS5TU+CJy3AcLNDJGVYsCh1TrGxYneAG1
         KghGfSpGrK8//9j05R0KpuXLIcSrSh0rEMkMFTuv8jOKATuIAnoLY9WuBEd9/VLoyK1b
         v+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUMinjAqw1nOF/xj999Jj1eHfy/mEiw2ycSxZ6K78N3b4QTVuY2jQJLcA+rx87RIOjglUuBcqUr5orNLMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUtdpy17pbGdOl35082IFE0PDij/3RBStdSf4DHseJ9dvqbfi
	yHfYb3uPjUPDbIiNHJ99Kn8IC48giVtHusEnNCznbHgqtPOx9kdWlxxNOzQpWYDw6p7Cz0d54hD
	vYHW6eLZfrE8eyiEaQoxWYbAWwyaBCWnyJkXh2QQmbw==
X-Gm-Gg: ASbGncsdZA6tp0WXi7XqSk+alL2LfOtxmr6lklFNMcIDWlkPP/5vkaOUQmdd/2gHLhA
	pujU5ky/lO/5Sw7PHX7rXTMy5CRle81ZK5Vxmlh11oW8iqfzlSp9bZQ1D/uo6+my58s75bmCWgI
	mozDXn6sUJbuSBLQkDwJFXwJLNUTHjY9gs00RG41glW8wFOmbDXSu0d3KmjJmeWdR5sP7iWht9I
	cefO3+4jrfOIbnKg4M6EupWSIKnHoaUp9Du7i1t
X-Google-Smtp-Source: AGHT+IHH9tVr2y31C2s758P1Y1iCzf5CBBO+mUKp+b25MmlZjZZyEk+h30As98u2vagbtvUMjxHrZsPQPtd3jW6D2mg=
X-Received: by 2002:a05:6512:3c87:b0:58b:23e:5ec with SMTP id
 2adb3069b0e04-5906d8e5b43mr5753879e87.26.1760350726407; Mon, 13 Oct 2025
 03:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921-msm8960-sdcard-dtbindings-v1-1-5a2455a30a06@smankusors.com>
In-Reply-To: <20250921-msm8960-sdcard-dtbindings-v1-1-5a2455a30a06@smankusors.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:18:35 +0200
X-Gm-Features: AS18NWAFBvRQlnNgwdeWFM-KX-enH6YfuOQVQqYG2hxpjoeevDbWK0MYvNQNYmo
Message-ID: <CACRpkdYJPjf7VX_b3u74UhNQz-kTzmvEkdo-YWYNn9fF7+T0ZQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom: msm8960: rename msmgpio node
 to tlmm
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
	Max Shevchenko <wctrl@proton.me>, Rudraksha Gupta <guptarud@gmail.com>, Shinjo Park <peremen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 5:26=E2=80=AFAM Antony Kurniawan Soemardi
<linux@smankusors.com> wrote:

> Rename the GPIO controller node from "msmgpio" to "tlmm" to match the
> convention used by other Qualcomm SoCs.
>
> Suggested-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
> This patch was originally part of msm8960 cleanup series [1], but as
> Bjorn pointed out, dt-bindings live in a different subsystem and should
> be submitted independently.

I already applied the other one, but thanks!

Yours,
Linus Walleij

