Return-Path: <linux-kernel+bounces-844756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5177BC2B04
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 657934E4683
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D56187332;
	Tue,  7 Oct 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUSJO31+"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3C5227
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869986; cv=none; b=Y6b6PBkRKChbu3EpHCquXNtDhMLOrnAh80uHn/RpezbIZMoBmPMwhnypfW2+AIjDDhGRmovNxMLiBFXJK56TSWK4G0xhwSkE1cHDFX36dYAVaNFdC/PBJDLYxgCJDGmOVlb1lk0QF5xb6jv7AP0sxkh3fLrtakLo/Cz9AaM0gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869986; c=relaxed/simple;
	bh=LbdMXV3ozTZmE/S9AboaOaM8iqRjDNxZDvdwE/Es4Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQUjDIQCGsUNMdUYPkQ+vEns5fCdZF/BmZ5FL2HVrcFzaWQDylD2dB/6CFDbGPcKGVko8Yj1cjPAS1xK/kVx6wxF2wDZubz3hhOubv5hJ1vSediveWgFtAaZgMOiFUrGIEpKkMBEQsiZ6gT5PbNahttB2WdUy+Y+LcHAkEHmbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pUSJO31+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7bc626c5461so2235794a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759869983; x=1760474783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbdMXV3ozTZmE/S9AboaOaM8iqRjDNxZDvdwE/Es4Cs=;
        b=pUSJO31+QZeiKVVhaGISvowrx0WkWAOveOLBZf2c9BTC1f4qjkIDLfCyoOnxZ/GdgR
         d85Ln+ToATRTkEyEQQ3/nl/MFf1xK7fXIIJggUBYgQjZTtxlFYwYHKPEJg0HNAbqMHWW
         Fd8J3+YQLo3doOOyx7NK6lOTrlRibz0vQm3jHg4g3cRL6Qeqf497GYo1eXWBlerfk3gO
         2TEhuZiHCiuTYSXYLZzSIPLHxaLMNmbo/xp+Mn0HnadDsYR6JfInomB4EwRUipwCWABL
         joW6AeWpugEWwHxq+fQ3FBr7XhDpdRCnXAKBrrROJxAbQYzf1KfGWRTKiaSB/blCYBUJ
         U9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759869983; x=1760474783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbdMXV3ozTZmE/S9AboaOaM8iqRjDNxZDvdwE/Es4Cs=;
        b=WTPXYof6WFxHmtUYiWWz5QhXwLSStrB0/+hEYzZ8FCKbvjNEe+dFh/k+av6dhJePgF
         YI+T6KO+4kRQt6uxQ+xh9f5IWRktfzWD7Uk2zwO5ZA+pjFhNNalEfEQwwxvePauK/Fwu
         8w2hAs3l7r3q+PIji8SOFQQlO4Jsx89xFCEVndb1Jy34ZjRw7DvKVj3BSvEbBT/HmBUg
         q/drl0J7yDVciW9ACCZND/ji1wIUbFfwlYFlBulDRXvCnbjp8a0FxQvj26gcijuSSssy
         V5SXASORnHTqSE7aLUCseGDUHV6yIEWb0MEgV7uCEwZ/NHNs7yXSgdhKkvAoA9vv9QTH
         o5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVMXRRNAozM7K0FAwoO2my18FmeAGM/10wRsjORDBXw+r0qMYkdvmZwqWxSR0j7mBXXA63DqzegUB5Eclw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54afBCzkLe/IUMGingniGR9WLej42F+wGaczE+KhjdZ1DlPpk
	jjzDUoHCz2Hg60zqKVtBw2XiHicP4zTd4nQdXRiU9lVGlSweViU4dF9JpKhM9nySg1+CDw83PQl
	fiodJ8MMcPv1DNiRxm9c1VkmqNCxvCbIgP/RqEV3Olqe2V+s1GQhbFoY=
X-Gm-Gg: ASbGncv5ZSt0lSMjiqR2rvOQw+R6ErlTmpPfbkX26hEAPKJh+cjZZnDOq/6gQgZcgfP
	T/l6quf8sQnkPTwJYLRMu1JlqLYqTpUD2xCRnrK0oO9sm0KDOrb1iRBWhk7sakuZZf9jVDb84IL
	kPyjI5ZCR4gpR+GU8mQIO0nFFsnool97rkU8fq98ItzNNX392IUE7efzJB2EwjS1YiCAOIIqew/
	kj/zlWhr2fS5HU7G4uwiOSaV9B3ES17vkJuVw==
X-Google-Smtp-Source: AGHT+IGcTMLJLJFMRFfxr35P1VFknbDk8xxpM6Ma7bfAlp8Jh6N302g2i+0XPxTMnwxgopW6JsJbBg7g+qmgQgVNk1I=
X-Received: by 2002:a05:6830:621c:b0:746:dbc7:e3ee with SMTP id
 46e09a7af769-7c0df715858mr633841a34.4.1759869983308; Tue, 07 Oct 2025
 13:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org> <20251006-gs101-pd-v1-1-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-1-f0cb0c01ea7b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:46:12 +0100
X-Gm-Features: AS18NWDxc12ZxAU4LNjeEPKBB8NsjHFZacb56hFZBSRRIbtDZk4xL2W2KL2JXWI
Message-ID: <CADrjBPrT6LVqs2NSu6HMWiQ5Rm59pXcbfcjLc3ZxrVBrMjGQwA@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: power: samsung: add google,gs101-pd
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 17:43, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Add support for the Google gs101 version of the Exynos power domains. A
> new compatible is needed because register fields have changed.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

