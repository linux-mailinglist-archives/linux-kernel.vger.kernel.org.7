Return-Path: <linux-kernel+bounces-833086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE365BA12D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1449918913B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30A31CA68;
	Thu, 25 Sep 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPKz0rKX"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC551F4625
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828479; cv=none; b=DgMHHhf62KQWRd5RkENzhxpYRfIEWD+tIYC/y7B+JYDL0OKwpKgb3CIkmXiKXR5sEGp3p/G6mXpr+NmJRA4RTuYA73CsJ1TAvVEwWdAhD/feGP+8YUJCa5CXOHiuQYm4dvNGFls5utJje/+Z3xFHQMqz4JZWJurZlXIJV8uECms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828479; c=relaxed/simple;
	bh=FkwVFquael2W5EOhY9Ke8xPw4/ZDH8ASTCboaq/0jHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBXbiN+MeX3VcKP7yQbpV2Dlc7GWXJlUK82On2Cl9yS8/s5ddK3iEFNE0QrgMGOyiCFPr8vn0P0XiN9QsQN2CT6xrCmxV6yCpNUW09Mo1VmnIEn1GzLtj0uru+dZIWP3AdcXUub+hG/X9PRH++E+GbgQc7V52GBRwsyP7hep4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPKz0rKX; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-556f7e21432so935723137.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758828477; x=1759433277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkwVFquael2W5EOhY9Ke8xPw4/ZDH8ASTCboaq/0jHY=;
        b=RPKz0rKXZGAftmJDTX9HSZwBJqcMF67WhKu7f+KlBy2LcY7tXVXcbFniCdDrCuz7s1
         OmPRgFuWHLiR396vEfTQ97MFMo5O40hjEFAciPQ6zhLjQjHZ/UqJve4n1qgxUrZXLM3a
         VkiQSaVKhLPJ/OVt9XIut2AhkMTEG7e/ahjnpfb5oYRu6yMGF2GummzIp+nYEE75zAxu
         4FXOJUSe62UPkdJOTPxEL1dhE/11/d7TfqxR+QyBgmh3uNCm6q5jJ3Qp3Be4E3oYHZws
         7/L8oDdqfAuV2UuMzoWfH3aYvzLSFiyIcLtmjNWaGvG3fbWc1kFcbchGErzaSUYdML6Y
         D+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828477; x=1759433277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkwVFquael2W5EOhY9Ke8xPw4/ZDH8ASTCboaq/0jHY=;
        b=maLtEPSgWtXNmjskSSqyMwuloyE3QbDDeVqRcC/WjVecKvF13xSiOuJ+LmyCqyVblC
         kPtsygNp5QGf50FwtGMB4IYlsdgBPzyRQ1qb+CIHOxrHvcOTqWUg5a4zXjsAc5JUxrWO
         z30QJHSkGd95SRg2puI2qo+uafReD55Hdf7q2TuwV6oNmVQqujH6tgWcFRXaNBOhA8ks
         Jnwq5oA0+IxY8AtBFKCtUtBbNZORiav4GKCvM45oUDXr1j836vU2S/er5haDogVc/GJF
         s4KRVtwElNvfyHUli6PaMKqReSzWi+pky1UtirXEkfByUFiVgcrLGhOfJfa9DTC2z0fj
         7O4g==
X-Forwarded-Encrypted: i=1; AJvYcCX8L0ZZVQgvI81HHmqg13ebCWsnrXVK8npMe+swX8plc/kQXN8jy8R9Eakx+sq7BxACAoMDxBIym2Y/Apk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/FS2XeKz6hF0XJPARnktxBgvvYE6p65Dm8DtcXTrE9bxc/XE
	p/8EslPowhBZ4lbnPIQs9KLn6H/m3dL0DiP1+ydbGuEfb2ew+5h2DyEr+wF9STUhElKOekLZ7xD
	b/5MSc8QuuzNOwLNzgTkB/3WOi4Pos10=
X-Gm-Gg: ASbGncu+8LmXknvE4EbLi0QBZZmcsW7N3jfqv7FU8ce12mgfr5lQ/B/zV//Zc8T70eU
	YN1UGc72BzapA9YtO0Ekb5zCLRa+s+k2g/oE7mc9HS6UhFYeOr4n4ZespywvNgOb6Qfj8xWIotO
	/O8ZGcV2jINxGYMHVtm37qqmbBl+jiTC/CmNfer7aUUQl2SP0UyelLU0DxQ0Vm6fE47WQ1n+csF
	6b7kw==
X-Google-Smtp-Source: AGHT+IH3c2AR5Kqr4M5jAjMB6cQc4XNNuFzi2a1UhG3oHzbXSwTVflCbFjJWk+Yfw0WGiaxCuX58gsj6hLEPPCxLmgs=
X-Received: by 2002:a05:6102:e11:b0:59c:6e9d:23bb with SMTP id
 ada2fe7eead31-5b28b84a9fcmr411890137.17.1758828477203; Thu, 25 Sep 2025
 12:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-starqltechn-correct_max77705_nodes-v3-0-4ce9f694ecd9@gmail.com>
 <20250912-starqltechn-correct_max77705_nodes-v3-1-4ce9f694ecd9@gmail.com>
 <a3ce0aa6-41d3-4ce8-adff-14c767d7f871@oss.qualcomm.com> <CABTCjFAO=iLauq37M7LOXOmrgAnPxh210bcoujUsL4zEC3634A@mail.gmail.com>
 <60d2cfed-5018-4afb-9db2-6bf423defc7d@oss.qualcomm.com>
In-Reply-To: <60d2cfed-5018-4afb-9db2-6bf423defc7d@oss.qualcomm.com>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 25 Sep 2025 22:27:46 +0300
X-Gm-Features: AS18NWCiumK4Gvm4CxsGYtlqIR9SF3-IzwYXTXeUKD57lc6j5siyXPl03AqcLsQ
Message-ID: <CABTCjFBDFuN8Javi1w9nAKLqbHW1CB3vL4EGvfHQ8kCRWZJcmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: max77705: add interrupt-controller node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 25 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 16:1=
1, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>:
>
> >
> > See also [max77705 rework interrupt patches](https://lkml.org/lkml/2025=
/8/31/27)
>
> This would be useful to mention as a dependency..
>
> Perhaps >this< patch should be part of that series you referenced, too
> (or they could come together with this DT change even)
>

Referenced series is already applied, so I'll keep that in mind for later
patches.

--=20
Best regards and thanks for review,
Dzmitry

