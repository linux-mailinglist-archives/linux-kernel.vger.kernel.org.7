Return-Path: <linux-kernel+bounces-775526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B386EB2C028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C11886CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535932A3C8;
	Tue, 19 Aug 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9lRxEtm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138527876E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602520; cv=none; b=aLq0k2sJmWaqhfixLfrCJeyfRcF7IymL88LMjKIWnPjnYa8cantJROTAqKGqlRirYh1Pks07Yg1cUfPqhNhdPUJNJ6xtfCzsj7OQM53xdppdx3JEmxvHWcHgonxJ2aJ3XCzJ8lqXIDocxHUvulkDh/5zffRLCSDVgJ4s1wOn7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602520; c=relaxed/simple;
	bh=IM67WPQOHye2i+1z72epmy92Qmx4agSMBIMH1WeYbtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5aiyTgCT0zrX/inR6QtSlDTrjj1Tm+Z2VrOQYvQWkkUx34E1GStHduaR/g+ObavAmVxRKA+MqBMzjGYE4z3FO0J4XTrR1AxbkE5PPq0oxXFlDdtmKOlLr0JJU+G0emI4ZWNfMryfEhOVAa7EmDOWwAhAeMKiXcaS6nZywtmNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9lRxEtm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce509f80dso5092825e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755602517; x=1756207317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM67WPQOHye2i+1z72epmy92Qmx4agSMBIMH1WeYbtQ=;
        b=S9lRxEtmzA7oK9h9THtttYlUjrd7ofW2ZMrJ9D7pMv1o1fj7mtqKB3E9469Qup5SIk
         7K8HEqNinh7RKpi/f6utKGZmXFVw5jy6cAuQdhin1Fnb6BqyVD8WiAHmW1sTfnP8JjMP
         IVWUspHWPgI6pKJN7PQ6X5Nnftlxg/DC+ON071kiEKByTO3O7YPBJqHYBdTBtYTMu3TY
         X+T0HmuFznKbQc6fRKTpJCGOFQ1KxGEKsBAH5Vmra6jV2RIi67FSosGIbKGa/6L5N4Fz
         HG5iV3N7pwTc3Gk9bZwTLTIvmXe8loJvrjZ8TzKVMQVxqdPG3Et8poiD0YveaARe5euZ
         Escg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602517; x=1756207317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IM67WPQOHye2i+1z72epmy92Qmx4agSMBIMH1WeYbtQ=;
        b=HVN5zfgEaGEPBlIJU4kC9S06Q2Tg35A5DwQzCd7BHdEi1C51OxpmYwuHM6dvTAqs60
         V9VX8lX049gHZIibXv2uLSxj5SMW/63iHVF3GYJOI63FS4qipqNo6X045rMix+Wv/zuG
         SeaRufgs4sTbWP34tJSHUGXH9CSM29efGgSx8UUCNjZYGpXRuzBniGDA49sqlc7HH7vW
         xkD5mWMAIP3trW+yCgFLJU4l/2zChV8z3VOr6zZ5xzZwZxxkXu2m61nkMBPgVJuiD0n7
         nPKk1HGQ+Nann5oq/JaxTrg2cBSIOrIHOuqaRd77inuwgI0WS58ZxiGi/jn6vdb9XS8a
         R4cg==
X-Forwarded-Encrypted: i=1; AJvYcCWlZHm5afdoj//mAzJ2H53IjN+QLID+N2D0SbByb2u267BSESr2PZrH12qd1lNjb7RqVM1LultdP0tGrII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3X7fKw/L76waxXYMen392AQKO2XXOkYnRvhKUOy0e5wCqN3t
	4wMzqmirPkix0wjpnVUqjAhJeOI3D7jPp75O6AcwLDjRBXhVnpMh78EBnNxlu6FVjfp5W9oDI/d
	VW5ax1sjQTNZHzHPuqs3fthzgOR/NQiu17VSJDNVfQg==
X-Gm-Gg: ASbGncvnkavmw4rme6ME7eSSMz48Kv3DYefbpyaz15A730yEBU6yiXDJhW2R3UCP4AR
	0AUh+bwdgV4JifSnXlzq/CrxV4CWFowZ5mo1G2EMKN6V/m5/nwN2L9jUXGCvZwG+LS8ioSbwiR7
	yTysktJa+BvnA3JLrwfdZLN3xendvDt7rrzVv09qzvXvCYDWXPdFfhowvY8xJ8ONmfVtPpgSZDT
	p4k1LA=
X-Google-Smtp-Source: AGHT+IHB9ZE3HHwBP8KRu0As5tM0j3eS8qOs+KX5e0XlvnFV/qrios6LpoJC/eBjHm40/aNMJAbseQeE3Ftd5lSOg8c=
X-Received: by 2002:ac2:4c45:0:b0:55b:8698:6a1d with SMTP id
 2adb3069b0e04-55e0079296fmr723607e87.3.1755602516865; Tue, 19 Aug 2025
 04:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812203348.733749-1-robh@kernel.org>
In-Reply-To: <20250812203348.733749-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 13:21:44 +0200
X-Gm-Features: Ac12FXwBOtQCyCuqh-xFzcRsUI8fbtRh0MGdvIn7jfDa7EoepbxRk616CgxWIGc
Message-ID: <CACRpkdYxFj9ZCdpOpE7G2A8cNTRTWoJatDP7OmCkkH_4eApz6w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Convert brcm,iproc-gpio to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:33=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Convert the Broadcom iProc/Cygnus GPIO/Pinconf binding to DT schema
> format.
>
> The child node structure is based on the example as there's not any
> actual .dts files with child nodes.
>
> The binding wasn't clear that "reg" can be 1 or 2 entries. The number of
> "reg" entries doesn't appear to be based on compatible, so no per
> compatible constraints for it
>
> The "brcm,iproc-stingray-gpio" could possibly be dropped. There are no
> .dts files using it, but the driver uses it.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

