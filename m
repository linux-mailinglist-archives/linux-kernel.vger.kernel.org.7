Return-Path: <linux-kernel+bounces-739267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74336B0C41A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F5C163F51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2242D0C8C;
	Mon, 21 Jul 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="sMbipTJR"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684E3C0C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100889; cv=none; b=CbS48T5rt/aW3FJsqTE3zXVWHeH5x0a11PzvJKb6lB/Vn6vxuMxY9hVFGa0KLuuMTtWA+IdtpM2jr70szr7f683y5nPxTgUvVjqgWdfB3suCyzbnk7/tYpkv4bwV784EtDFfb78e9t+pWvb4TSIr5btCB8UN+UbVfVnB/8FEAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100889; c=relaxed/simple;
	bh=2Vn0aaHBna3jhvDqCj6KN/yLEG5ltghGc9j1bu034LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSPGfVewNs1Y2/NOSjlEkfq6ZwVl38gwiUAeJrPgeukT0VjIfnh5nzOPp2qXcaeYOT8/JPHbECcFyMcROyiBHl8bsg5TPfPz1t3GLIdziiPyAG918JznShjmbbqYIaCBI0DKx2Q6ZtBjz4Ip+dsCPKcfTmr1B5v2boGwUuRH1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=sMbipTJR; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e3c6b88dbso29136787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1753100887; x=1753705687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vn0aaHBna3jhvDqCj6KN/yLEG5ltghGc9j1bu034LM=;
        b=sMbipTJRSsUWiUJtdKzXEmHKm2z43bZznA2+7reXOBZ7hWFoTVt4Ozk6EmLY+fSW2L
         QF2SR+Gqt+bgEIlAEuEF7ChjgOLJtlHQ83wGXOcQ2oGG2aWUEGQwNRBimtC/T7WnC9rm
         AHJTRhuah2b0EhzVbN9s4c+yDPfTAp913YF4G/dB/EEoX6/2pllAx8RPzEgKyc7KyTuc
         7o5szQLAJihSK3w6nMNH7yxwFiM45vL/37QkxZOJuyHdEXhxJmdouQNbUG6okdlKN83z
         jjcT2IHN/ulGkIAiiX35TSZLxRlWqcuSD7WyS3z9Y6Wg5bXbA+qnQxQiOlw1mWFgZhs6
         Zxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753100887; x=1753705687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Vn0aaHBna3jhvDqCj6KN/yLEG5ltghGc9j1bu034LM=;
        b=VcxM79+giIWDc5b71VrCGy2m3DEuqyScS4leFab/npnTuq4Mxh62iyGr/C1Nkyj87x
         sflLUi3ZRJZrcIL55Meft6BYM/lh7JyCjw9Et7Pxg9LHNxbCYc2VOYYKQdX/C0DmNADO
         q5TC3O6CSFyb5vZ1ku6OV6eNAEvapILQY3mlKS8RHRS49UfVrCHXw9DW76l1iiWBalOL
         gKwtBtdqGXPqv04Rq1xgRZDL6Kp/o+WXmGY66DY/TBCPeLDOcHuLq3Nvx8qgvIy6ADGb
         fnJnYCbVHUjmOIuTWgU2H1RCd69sxBSLs07GiTVia6gmI4JKCdRiSNp2AXzQQa+uYKA8
         ixtg==
X-Forwarded-Encrypted: i=1; AJvYcCV8pFDAjbrvmwQMU7KgSanAns6IKukJBhWa1cuifevflmN81giljsDdKcNVl7WBLX8bzCvKZBhT0wBEkWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1vA7IvlqYtMD7fcI5Nu88mGXKMGkw1BvXL1JpAYwV458Z+Fh
	BZrauFKxnU5+oNNcKJJqhOzbJum63gqDxhXPPLcue8BxX6qz4UI5bmQsAY5H74EdsG8bJ66M0y9
	RS9upHemS5NQzGJCz17X8AKyc6u7+Y0h09RaC3Il9LA==
X-Gm-Gg: ASbGncvWUfuilKACuD4bH4NKkKljgJ7xxU7wSXPfAhnC4cE3L6p7NLUAeeX07PLqnG3
	ErD1yTNxfMLt6xfQMp3dugUoXHYacXUFAJuOcqSNnzZSB/CUnYBNnhXvcd4bxM2NvPV1XND01Kx
	lt3t4j3pjerzfqPsgtTMWwoP9Ol1xVHU0TufO0C4/9G+1sjDRF5zWVllXgsg3cPFbTViFF7U2fp
	CJXREDhN9Roxy0/daWo2hj3CAmS8XzqAyfdDAktjg==
X-Google-Smtp-Source: AGHT+IHROMVCGTzKbd8DUnRbxTfTlK+MR9JL62BsI9VnekLusb3BHR1u3EIZEbgGayIv2PxqmGUaZG2GMi/i6h3zKV0=
X-Received: by 2002:a05:690c:2501:b0:712:d70b:45eb with SMTP id
 00721157ae682-718a97cf4c7mr209750327b3.31.1753100887052; Mon, 21 Jul 2025
 05:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-leds-is31fl3236a-v5-0-264e841f4da9@thegoodpenguin.co.uk>
 <20250721-leds-is31fl3236a-v5-2-264e841f4da9@thegoodpenguin.co.uk> <c4e4f79b-5b1d-4cab-a8f0-49adbe30f2af@kernel.org>
In-Reply-To: <c4e4f79b-5b1d-4cab-a8f0-49adbe30f2af@kernel.org>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 21 Jul 2025 13:27:56 +0100
X-Gm-Features: Ac12FXwobXHJ83Z0DHw-PuSuMEtx3uNkAZQvuIt_cGjqWBGALi2mwf-OzhJmGjQ
Message-ID: <CAA6zWZKi-UA_=bxKLjYN=HUEue+jXtqP1kTZtGZKwep6GAMuLw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: leds: issi,is31fl3236: add support
 for is31fl3236a
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I never spotted it before, but this should be issi,22khz-pwm. No
> properties use capital letters.

Ah, noted.

