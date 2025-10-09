Return-Path: <linux-kernel+bounces-846340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB5BC79D7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 482774F017F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647B2D0610;
	Thu,  9 Oct 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eQ4QEsnH"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19454296BB7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993801; cv=none; b=El+2U4k8UeC7C7prLoztNads9PMu1iMsW8PfFP9oR+sBAkU67Sd4N/RRq3DNpGSA/cWGDFkKD2mrMmR+XdheiHjtMxXCdQOmfOdqlPGP7ejyb+Y+C+zdh6KNuGRXwB+z76sWkl6JVeSLoYrk5sTCVuwE5wZ6dv+EAsq8aEunqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993801; c=relaxed/simple;
	bh=cCLugtlKER5JKVdxfXmIi5m5k7cSqN7AKwCJ9L732vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7rKk1Z4Qiv+mAGMN0SAWwVIgz+6LCLgqNEg77B+wA8oX3fZmKNhRreuxnZIv/jmUvuvyJxkcFTSYiai2AznlkHIA/FMTdp3C9LagWXevo/+qnKBUD6RqqZL2M9wnZIM33xhlAm8jM4G56MHb8tH1h5sIKH3684qfXnF/sqz9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eQ4QEsnH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-373a56498b9so17843891fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759993798; x=1760598598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCLugtlKER5JKVdxfXmIi5m5k7cSqN7AKwCJ9L732vk=;
        b=eQ4QEsnHg0aO8w/ehvMcNELyQkHPCwkdywiG8Kcbf0OBKX/cF5VoknNgYeDJF9SCFY
         3ZEqmodTVzTAWQO2bMqoYMAA4QBsWF7E+Uz0ue+46dE9HQsylYS7s9ZmLZ2i/L9z9nVi
         Q1qIHlttt3YVRuEDp/myrOTeKT0TMV8joEkgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993798; x=1760598598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCLugtlKER5JKVdxfXmIi5m5k7cSqN7AKwCJ9L732vk=;
        b=wGE18nlmXMlUcydY42kTji/mPRUWQoK0TdbDI/TwREM+7/a2sTSDfleAvzhwgpv1xI
         UmmyZS5Ru6V87UmdyLtiJLL1P9VzIQFOj3E1bBq/Ww6x+rmrDXCVijcpjsJ81sX4lOT1
         sTliRhw1oGQU+6XqcuWETv5wlxz6gJI7uvc8TTv0vFWFWGysMbyCg8VJPN80ynG4sbYg
         C4zu4G9oTqo5Pr+mzMqvi2VUiYfCoYCuyr6k4+o1cJ+b0wUdx32k4OSaRDewYMFpyAzz
         vfq1p55HiZtUTJJ1twG6mPRb20EitpKJKKXSLD4oQQdjISCSvShVHIX9mImW6MAhtzjS
         C5tA==
X-Forwarded-Encrypted: i=1; AJvYcCXI1MijpMyw3fynWpNhmCRok0BL4lOtTwUnl/AjlWJeHXXZ/yd4bj+N3T4qNm5ivWqxna0an5oChBDTJD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhqL3GmF0JNoTuASDaakB8yf7PcV8tj0zzIz4xqUTZ0yh9ozZ
	y+auCbPaDmOcBjHgRjNG/vH+bSWz8EF2LyCcA/acr91b2OKcmrkNCeqQgr7FhK9kb0xpsIaUp4o
	T/LQPCIiE9C49V5j2G2xTEdxqFXhhEVNpBkLckHWP
X-Gm-Gg: ASbGncs3ZcS3LFa2YVTfkuYtwgSKWB225pEwYEfqewfatHgu9VbCsDuwPag2zCSMJ/F
	Uy1w68QGf3TpZmkQZV7E6p6ho9q/MgBpCfrx1d8OpD116L7o6gEMCy3fnDmI44Qe97tN6Qrv8ef
	f1cMHR3WqNrrrRvQpkonkiXDWLjijpIXtir2EVNaKl6rheiIzB8HOfGtQe8S+fg23GAloi/liI+
	hPQQU31iEL/QkBfDNvz1nJhMIph+0obBjvAyq3O6jVTAsDMkbJyVB0sKIKW8A==
X-Google-Smtp-Source: AGHT+IEJhbj8B5bmWohXhF9RO2rE1lp3Eq4MRp9b8SXg6OKS6nhaW5FvJnYrKALXjGj9kyLiKxmA5YOScYogDginsYs=
X-Received: by 2002:a2e:be10:0:b0:366:ef7d:bab3 with SMTP id
 38308e7fff4ca-3760a2aec91mr17588391fa.1.1759993798125; Thu, 09 Oct 2025
 00:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com> <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com>
In-Reply-To: <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 15:09:47 +0800
X-Gm-Features: AS18NWBfT_0WimyLL897lV8iBPOUkT6dheJLRJo28H-RJf0AZ4JmglLtj3pPXGo
Message-ID: <CAGXv+5HAvx2uqJM7hWyBpF=wPZLWmCkKDaBnSOsPnU2+YFM0CA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: mediatek: Refactor pll registration to pass device
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:06=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> As it stands, mtk_clk_register_plls takes a struct device_node pointer
> as its first argument. This is a tragic happenstance, as it's trivial to
> get the device_node from a struct device, but the opposite not so much.
> The struct device is a much more useful thing to have passed down.
>
> Refactor mtk_clk_register_plls to take a struct device pointer instead
> of a struct device_node pointer, and fix up all users of this function.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thank you for taking up this task!

