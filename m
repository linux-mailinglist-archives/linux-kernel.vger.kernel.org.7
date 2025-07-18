Return-Path: <linux-kernel+bounces-736344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6ABB09BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F1D1899D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB220296E;
	Fri, 18 Jul 2025 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="JAGrEzdb"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9F1FF5E3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821465; cv=none; b=o4/qvipWX6PBSWh0/x6zqbgPsKFGp1T3M03/G4wEKbA54kI1XRxU/iDRNl5YSEuIXoknQVWXKUAWmW+Fz/WbL4zOIlJm0XiAyS1DCCWI1MiZWyOyjN5IBkM982uc2pXPk6ZDp/CMUl9oEFBgtjYET4amiHtH3NPH7xryKZfPXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821465; c=relaxed/simple;
	bh=g/bQDA1SnPganh7SgBzzVaHUvhqJSHOBmAGh77R65Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT7MdJFUdltbIladpQhabncUAzqBAXTS0Fu9a5DnBZ1eD+YYoC23P3E57kCFnHD1m+OK8IUhgn1GDmozNEzNI9AOAlkF5muJxkzWvVqOJa6RWeBY3M9e1Yl1FizKAi4O8avLEB+P0CiMG3JdTEmfHkbF73bl3RiuncnRCgVk67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=JAGrEzdb; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-712be7e034cso17813597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1752821463; x=1753426263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/bQDA1SnPganh7SgBzzVaHUvhqJSHOBmAGh77R65Yw=;
        b=JAGrEzdbtOP0h1PRv0Km8fAsJvOctpoYha5dO1N/Tq95l0YwCGsR8vbz4vnI7Lkp/F
         vuSIzqEdp55gI1ifAzcgS7kB9QhS+xw8avwIhZsdQe436XfE2CKQmlkXySKHkBDR2THo
         9Wjp3jjWnlEZOaQuXNkt0Jvqtnq5ABktCQh4644+kc8+LjztsLQsY830rp91i8Dyee6q
         awW/ntnCGPJ9fqwt5t/F16c9ejRrzP/bLHQgohHSF5eLz1HR2Sb0cuw1qegmjqp7nWdb
         mJJmcjVvEIM+IiLJ1YhNItdb+Gh6cUGlS17YwxzBy30ctwCHaHx/ExFg+lve1nlZ0fWY
         JsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752821463; x=1753426263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/bQDA1SnPganh7SgBzzVaHUvhqJSHOBmAGh77R65Yw=;
        b=QDXazbeHXD0UWP9/bQh5ONW4WZnEy4qQl5J+KKB0r9yP01lz/NKD7ReU+MpCoQrTBA
         oEZdR5U0U2wOLZYRW0g7qkV9peyzzjZvEokfo1QdiYkE9gE+mL2FyUTaH8rdgTBJdutW
         7xLN7Cp+aA932CGTYolmdWf/Tp4mtVJHwfwUDyz49RJexy/6p6aP6CKun9JquoF4bz4j
         +xqAowsBwvwl5V/XhkOMmUC0/APJ9iGVTYxf9rvw7pruyDRtkMPlaH+/D+anUgaaV8H6
         fOTHxX/csIrbJ4Lq4Z9UjtW96WrbKr2GP4fPUfotDt35XCgV2osR9uslJjyV7wO8H8HJ
         +CnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIy5XUGcGBRaaD6lCCiY/dnAy3tlx+qoGS4SXNMtu2PhRel9lWW/lSWfka6lhFU1sqS6FM4tCsNtEkUdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGDsZW041zQCmtBk68Pz5R59ao7JEPExBT4bd62IFqfgKDmWW
	TNkJkejAwcO9qRBOKx3vC1C9vLsowtfwQefi1JuZGg8Ef3Dk4iSl8L/SDQc0Jor438rSFeM4aqa
	NkdCZ8xBbTrUOgiQYiDM1QtHzrhs1QSv6nfanToysyg==
X-Gm-Gg: ASbGncuEeVJg6Ueno/a9gWd4CAiZ8OZ9Ls2eaggsNGvQgdG9Glv1+sp/2CQIleXNTDq
	OA1Sxe/fyK9xJuMJmSBd8/uWEQR8SiDbjMl68EoESqg4sKuxjqW7qvol5LhxFGOK1vjttjyM1Fw
	EZIbO18hF33HR4tFtNCuy62YOkVFdlgRO/MNBB2OguNbdBE+/84MmXswmp2bq9rkqzqHiDqllUo
	bTAh+UuzOdqE4ID4Ce0gI5qp+aBl7CtGWVX0W9EWw==
X-Google-Smtp-Source: AGHT+IHB4qPnBvPHuDyr/eRkdonIFJaeMa7b2rimTenEZDBBnypTUT8n4v6UW2cImWERDStmN+Jv4as8F9bxbMRxZ4Q=
X-Received: by 2002:a05:690c:3605:b0:70e:6105:2360 with SMTP id
 00721157ae682-7183747508amr140109917b3.24.1752821462689; Thu, 17 Jul 2025
 23:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-leds-is31fl3236a-v4-0-72ef946bfbc8@thegoodpenguin.co.uk>
 <20250717-leds-is31fl3236a-v4-1-72ef946bfbc8@thegoodpenguin.co.uk> <175277045533.3779995.9523277801474945480.robh@kernel.org>
In-Reply-To: <175277045533.3779995.9523277801474945480.robh@kernel.org>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Fri, 18 Jul 2025 07:50:51 +0100
X-Gm-Features: Ac12FXwhPQLDpkdyogiRsJ5pr_q3LrxdRNUyRuWOgCuv_ynEzoEm_EA_gQ4kNk0
Message-ID: <CAA6zWZLyUt9X4+dAgYBVGqdNchasJorWhNH1O1Ti=UBO-J6q9g@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: leds: is31fl32xx: convert the binding
 to yaml
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Lucca Fachinetti <luccafachinetti@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date

Hmm interesting, I did run it, have yamlint installed and see no
errors. Will upgrade dtschema and try again.

