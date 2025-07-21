Return-Path: <linux-kernel+bounces-739266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B693B0C416
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3533BFE88
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AFF2D29BA;
	Mon, 21 Jul 2025 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="a8FcZPkg"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524B2D3EC6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100826; cv=none; b=jOF6ryBvz45+nmkVR/qIAtk6PZooFdR1HeGxnJLdcvIMx9/9kqx+XvGZIy6sGBwx3zMyiWeF2sE0/J8gOQYNNtxKsUaOdmhPUuQwnviZOSkKvGiyafTgVvTJEYBYz3Vn5nfq2K5fg8K0S0fbqQmwetfbCs/HxNgKIk9qGHaxevE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100826; c=relaxed/simple;
	bh=S37p+ki1hKdOfBgNLa4sGHFLbLRIOH+ZYzrfDoPofCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJv1vI/E7kEKBP4Zxr9cIbfNxv2d4QJfNOdpAx4K7JR0vCcCNHTZn+Xpu9sW7gS1xdAf6GmhnhNIgjKEdIiuRlnTa730ZYBd9OT7xo3lGZsd/OnOeg1ik2N/UojCyZNK+JPd2bmYYpPW93Xpyewo+lWEbXdj9xsT6/au6uaPprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=a8FcZPkg; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-713fba639f3so34416107b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1753100824; x=1753705624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S37p+ki1hKdOfBgNLa4sGHFLbLRIOH+ZYzrfDoPofCE=;
        b=a8FcZPkgUSjCXtvn75trAIHi9FyklEUxUEsyYKh0TCt0B05woQ/P8QklO+Lg3J2Vug
         ErRAcjyzNuDoSvveYGRPL3DEvCjB6epJkf+sJDsXXDcBLPCz7MRP86ZocX2XEmrUQ+Q/
         t2Qd+xrzJO+HypSL+HHr8REhp96pwi2DMDb/75wj4LAcc2rbjeZShH0H9wtBmji74h1i
         Lkm59mCsooAlUSGdTrynQGhFmIUOWgCvQxXn2j0z0fIpKV52jgFwW1vfQLciXNZGFNP7
         2mVDS+V6MotNZHAKg0Ot+8oZppAG77v26hKCbBh/7DURhIWZceSwPMI/+ARegRN34cmA
         +57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753100824; x=1753705624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S37p+ki1hKdOfBgNLa4sGHFLbLRIOH+ZYzrfDoPofCE=;
        b=X0XN9olvxa5VPEmTpSPepY/Ln3x+8f2bp5kah/evwobW4MgU31z1pl1raHh3guZPlu
         sUVlidiXhLN8jdXa8/XOIKlwcwsYycP3bpuCt7O42P/vXK9+h3sdHa5Vnke0tcFcR0iW
         IPTgnoxzdIpHTwsofhrEXiCtLyi+piS7rVlre422rSmS8SaCurYsx68goP3VZPRcqRqc
         b405NLD4QAYVP8lyaak0WQGX7IAD20VMr1UnFq8mIgy6LYLVW+6eKhLoZxojyXRoyVvJ
         RR9Cue+JyWDnUvOxEjn/sW31yrMfTChNECbK91XCzsLZgKronuR3m72vqhkw8moL6spi
         C/yA==
X-Forwarded-Encrypted: i=1; AJvYcCV9chm6XsycRqmkxp+ndia2Nh+3Db3DA3oAj/FLNvx7Xx/sZnBvsxnK0KrUyh/SAfjBiqnZtLOHso8OosM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxu3tIBIKsHDAEBEGd+tExxE2m4DdsmdG4AviMI4yetXLFauN7
	fWMTKFBDHeJr87KkGZuRaCEJpzgnrVk48OkkCRyGafkKN/wUHo50B+nNR6hfp2BcCSJjJ73DrJa
	qlJWuFCDW/bgqSGjiITOrbwJnzFj4xskmJ6FtZdjX+Q==
X-Gm-Gg: ASbGncu7L9DmVyz0m56hP0kEM8zA5P44XFUpGhhoeXmKrE8UTRNdZLaU3EglmiRs0oz
	1zvJQmC3zpW2WvSiVcWaOjmasif9O9pQ4FP0mTOBDeqXS2syF9PX2Nie4/5qqA0MLUXJ4Mmjsbp
	qQKkyUW/aEiAhfPgLiOBy/s/jZhjfIk/IqghIN14jx9cvQFYJDNvwXxMsdyEuOxb6I0S0W6HazM
	kSAb8oGTssOIIZBpA9MzBtFcb+eKBJ4LOBKQeCfjpVsrYm7FwDJ
X-Google-Smtp-Source: AGHT+IGyzKwa7R7rwYenhb8xAPhroS7OY07UztHqILHpzfiPDYy6DXrcN5pIt7ZXpgtFgcLpZWS9QSKxCRIuIw12Fpw=
X-Received: by 2002:a05:690c:d0d:b0:718:38be:b3e0 with SMTP id
 00721157ae682-718a98230f3mr208870237b3.40.1753100824241; Mon, 21 Jul 2025
 05:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-leds-is31fl3236a-v5-0-264e841f4da9@thegoodpenguin.co.uk>
 <20250721-leds-is31fl3236a-v5-1-264e841f4da9@thegoodpenguin.co.uk> <4f57cca8-49a8-4431-b41c-78097eb11da9@kernel.org>
In-Reply-To: <4f57cca8-49a8-4431-b41c-78097eb11da9@kernel.org>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 21 Jul 2025 13:26:52 +0100
X-Gm-Features: Ac12FXyhi4nQpPpVH43-6Z2QkWFo9ppc1veMmVayv9agkzFpsA9IU2572_o8jFI
Message-ID: <CAA6zWZ+x9cj4kOTepYNZ+9anCruSP+dgdsyux6iVKF+vN1Heaw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: leds: is31fl32xx: convert the binding
 to yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
	Lucca Fachinetti <luccafachinetti@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> This still does not match min/max constraints. You already got the
> comment on this and nothing improved.

It was not clear to me what you are after, so you want the pattern to be:

^led@(?:[1-9a-f]|1[0-9a-f]|2[0-4])$

So the range of the unit@ string is controlled via the pattern
orthogonal to reg,
the range of the reg property explicitly via minimum/maximum which are decimal,
despite the fact that the reg itself can be a hex value, which is
preferred for readability
I suppose.

Kind regards,
Pawel

