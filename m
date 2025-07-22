Return-Path: <linux-kernel+bounces-741564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E112B0E5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B201602DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A232877C5;
	Tue, 22 Jul 2025 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgQxFV3x"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E7286D5B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221484; cv=none; b=Z0hj5d4SewuRXo2kAisL/2+XLfNp+QBcrLZjYVvr+hVVPEwvjGttHscVR1k0YpglN/4R/KXjvA8d3mDjcxvL5QVS40Ogv1ObunCObqYLEfT+vYAvrrAiOhzPVRDkWZatApUwuFQ9tHSzjCV8dshgB271v0KL/0e236kG30HJYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221484; c=relaxed/simple;
	bh=lYiKyYXdjjhyUxtYTcfFpjzBCFZEpw5hRFn/BBVvuuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L22vkyrWYP9n5Zp3DDEOLwhwEIkujT2qgJSwuhxmuHEd4kvWNHN8Hzy48TXCb1pGP++hb9OMTeq/to/9NdjRyiCj4rYX0BE5jc1GYbtJjZ9qxLdJ8gn+9IiTkl7kYdSlI4ulOpYbe75NI7xbq7G4xE7WVP1MnnfR6GLXzkDoSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PgQxFV3x; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so2004a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753221481; x=1753826281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8hcD+fzN/rLyW2ntnhyBmLcEi4uK+H7gUEsQ2j7Juc=;
        b=PgQxFV3xVIYVzvqWxGeXB8OHIHNRoHKHmCv76q4RO7nQqdxZQcLB1ty5/mVtzmWnwG
         CYrnztOoFpxdfzJbLKQ+RtauRKd5aUt8LmxexpNafhIWydzVe1oLnNWOnH7bcJc5Plae
         Phwml768EXjZoAvaIxiXDoeC4RIPomr8tMQlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221481; x=1753826281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8hcD+fzN/rLyW2ntnhyBmLcEi4uK+H7gUEsQ2j7Juc=;
        b=SMYaFr7vvIVTKFOCBCyZjbl7SIYJomyPwbww57iKbk0amoZg68cn7NoJzY0FSO8Dpq
         FmMEicbAN8Wbo5HeIhbit76lX1n3aW2S3tSJR3daydwBgjn9T2Ft64tg8jjZYreC8rZ5
         zDdOkk+NbSslqtm7oCEtpo3IddLhVAo6kXnrAg2eweCH6cFeFAqeavoj/NgyX0KwEcFb
         XQMISb9o+UqbSMHOpQiOmaPtJsy8rIec3UsLneGHUOKDJe6PNBzpAn29V4LDeL6a+uiX
         YB7WghLtvX+7LE99v8Bbp5Bc/H5xNLL/jtR3y+2nAYGGbWhCsfQ+pz97NFnlJQsA7nIS
         IVmw==
X-Forwarded-Encrypted: i=1; AJvYcCV3e9HTb69jwYGxDIPzofbyvwE0JVVX+ePMmw8/MmBCF+8RtBaNmIBKNc7ktZzcdkiiOUOSf8mFfdqGYHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOKNsYW/vyynP/rAGbXML70UszsDbXwQ2Tl6q1stWDqHUJ7Znj
	WfvpTyFH7v6aLbcV69p7SGm1JonrT6y9W1p9knVlXvbhJLDiXlIwSst1bR7T2hLpvguyH41oRZm
	HMe1WdGmFJFMNShSKackGUn/SPxkroBzuSNh8uJE2
X-Gm-Gg: ASbGnctYCkXhNezBu85siJKzfaMMbga+JNMZ0n5S5Q2zDm/CMay4k/+ableqoQ8P3H4
	+jrpRKGJTjrfuHeSah/R5bpJnPlSypOlW+9KJ3SK3G60QFq+9UcH3DLG6v8qpu4z8vfb2VJT/oh
	F+X29GrvII3PuJ4Tw9dJHriuILno1inQLnMQ2YW02sagSk1jTB7wnEs2B7NHlv6wVscNUwoyn/t
	DYayzjApfWQPIYs5qcSYlh+12iTz0Rezg==
X-Google-Smtp-Source: AGHT+IFuRyHVLlTc9+mvjyXn9nDzKUxgSkHkWINR1NMMOVHEBiRhg+HBPAtm00VgI63bbY4a+rdh39BgoHymQ+H8ciM=
X-Received: by 2002:a50:cd42:0:b0:612:ce4f:39c with SMTP id
 4fb4d7f45d1cf-6149a332acamr34752a12.0.1753221481275; Tue, 22 Jul 2025
 14:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com> <20250722-ddrperfm-upstream-v3-6-7b7a4f3dc8a0@foss.st.com>
In-Reply-To: <20250722-ddrperfm-upstream-v3-6-7b7a4f3dc8a0@foss.st.com>
From: Julius Werner <jwerner@chromium.org>
Date: Tue, 22 Jul 2025 14:57:48 -0700
X-Gm-Features: Ac12FXzhD62MTJBHmWXOCNn35YJ884MYdMc4gPYhqJDJjbLE29Cjc-kRxryta0g
Message-ID: <CAODwPW_7aYdEzdUJ7b2nT4-zS9bu_hbNqjc7+_wSHbedXZXJ=Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: introduce DDR4
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Le Goffic <legoffic.clement@gmail.com>, 
	Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +      - pattern: "^ddr4-[0-9a-f]{2},[0-9a-f]{4}$"

This pattern doesn't really make sense when DDR4 doesn't have the same
manufacturer ID / revision ID format as LPDDR. You could either only
leave the fallback constant for now, or define a new auto-generated
format that matches what DDR4 SPD provides (which I believe, if I read
Wikipedia right, is a two byte manufacturer ID and then an up to 20
character ASCII part number string -- so it could be
`^ddr4-[0-9a-f{2},[0-9A-Za-z]{1,20}$`).

