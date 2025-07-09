Return-Path: <linux-kernel+bounces-723512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AFEAFE7D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CE46E0690
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B62D6415;
	Wed,  9 Jul 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4zvvMFw"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CEC2D6635
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060692; cv=none; b=U/KLVRWWE+0xh4jpzrzodox1aSQ/z1Ky9O1aWcr05+0ALSE+4Sh4ruGHvpeo1Y5OaIAmKgZ5YxWetlAn6zgnItp0tgpYqypQxKhZGESQuM/Bn/o3iuRtz1gtEjLSviw9/0/0Q6QtLSApBbaI07wg/vnT06eZgm95JxwGXuWN7yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060692; c=relaxed/simple;
	bh=KC3Z6R9qM6d7cSIbmQ52PjX+ds9juhkme3cOPH/FE0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZ/I4e7kB5UXbXwvNh0Z4Az7RYws83b72hgMzlQVFNT/9URndmytyjrMLpxVXReUB14hCbdLDO6HEaPfl8Ak64Q0D1COedWOCEZNnO1s1Ld3U+3fed/v+0wFCPlW6vAYydNvfCr1EyWRP9fUkdOnY2jnHRztMVoNfCovZIly49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4zvvMFw; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8276224c65so4662394276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060690; x=1752665490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H4qDIkCxD7aqIeJI126uepcAwUwJhAjQhx18iyCLj3I=;
        b=d4zvvMFwQWq5AtwhSFVZlEp2VsvEL4yY6W4uvGlxWtC4VC5WEd916YWS+qtBYC4505
         nJbWun+f95puMGOb8sVtFFdXWhQ+BzYzbxg16VSS8+ZaEfmNWCEwa9GGtOagKTz24KKC
         HsraMdu6Mh4VNXMALvfa0I3NuThWMsEQjdK35pKEmf89rfWM6OphJFs6HVc8zyP7CS04
         FNqUgHOQ6QJ0WG23eVrr6jvL6bYgiTea4NCdQtq6DfUng4s4AjKrhHtDWpjDz7pHZXSr
         P5RiYoAYwNGHLyhWmNOaaNXTNBLu3pYnTovmikJVUehgGPUx8ld4nY8KZfYEnuKEaPgN
         rBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060690; x=1752665490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4qDIkCxD7aqIeJI126uepcAwUwJhAjQhx18iyCLj3I=;
        b=czJsb+7uvPNjXupZ8Ve4wF4g0pqupyWj+sVFAc0MlDG5dWv+xodzNjPE845CBtM86s
         TTl/nAWtVFsv/JHmg5q1kR3LscMkzkNyz1w3kyEvvXrpnN75A+fiuVQv7uTb6We/wWqx
         s3BgfTLDYhvrTxDllKSfuKURQNQgrRV3IJ4IYrAn2Jv8pe7hQV79aME3mxl/t/RpBUmH
         jlVN/M2/zMVnYrkqHkzLTsERKLKrNhmxLQVMMQIJU24IqRpLR3NzCWx1RnHuqwnPiNjx
         mwqmIM8PoACzTwFe2UDjSy0/bXyFDjz0ivSItufQG0FZDEdmTt9eV27zvN36Nr5JF/61
         jfWg==
X-Forwarded-Encrypted: i=1; AJvYcCXTpk56aY/sLNACLe59ApZQJz+tb3RtDkJbt9lzAHihSDEnt5TNDKLQIPm4HSl9ve3ibWz9G3KnarvYGBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4WkZ7JXueYbi0lLbjNhhfkYVe4JvsqrNLxZbQG/urVDFTn35
	lVMGrKTMdo4Z8OOqX9ndTmLnIcIfvqGqzw+4oCxifl7Hs3X7zZ2igHiwxks4yg861uxAhIiDT6/
	2tEJu+CuypCHmvA7643X5xZ0YXbV+4w8/S+ipQ4yFeQ==
X-Gm-Gg: ASbGncs/87M+6EwisOUR/HuSHCUuX1RNyavx26/fac4X3kpy0wT5W0g38YbP/qb3dHF
	dZ2GR0M0AjDHgEutQa0wDRqXUj6CngwCtLi0KpljBpLFUscCa+p72b/dUhGBSDEke2No5JM9/ib
	arFy1oBe2UDuZ2LbnkK1kKeHz+Q5N0fYF1GcNbylqfhF/R
X-Google-Smtp-Source: AGHT+IGEJ4mmuKS7rt1MFlUz2bfdy5YmSqNFhku/Q0Up5ig+Hhd1s6mTWPeVIQL/2Z6ktbTHNLkVtt8rYKM0Ty9sofo=
X-Received: by 2002:a05:690c:34c1:b0:70f:83ef:ddf7 with SMTP id
 00721157ae682-717b1ba3c3emr33058457b3.13.1752060689721; Wed, 09 Jul 2025
 04:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
In-Reply-To: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:52 +0200
X-Gm-Features: Ac12FXxRo-xD5eCPtXLrowuQGz-kjsQVt_Zu_iyEtrGYNOPit2r7unOQDND3zzc
Message-ID: <CAPDyKFonLENQbafjo621hHPkoWjMNoQ5GRNeNndpezMNnM1=sA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add Milos RPMHPD power domains
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 12:18, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Add support for the rpmhpd power domains in the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

The series applied for next (with a minor update to the commit message
for patch1, according to suggestions from Krzysztof), thanks!

Kind regards
Uffe



> ---
> Changes in v2:
> - Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
> - Link to v1: https://lore.kernel.org/r/20250625-sm7635-rpmhpd-v1-0-92d3cb32dd7e@fairphone.com
>
> ---
> Luca Weiss (2):
>       dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Domains
>       pmdomain: qcom: rpmhpd: Add Milos power domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                        | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2
>
> Best regards,
> --
> Luca Weiss <luca.weiss@fairphone.com>
>

