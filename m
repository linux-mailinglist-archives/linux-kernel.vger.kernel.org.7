Return-Path: <linux-kernel+bounces-838081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E14AFBAE631
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EE974E06AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7328137A;
	Tue, 30 Sep 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNlRUwSh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0E27E07A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258792; cv=none; b=DURUoLDV+MuJC60pJsJjth35VKYdmIIOvZ8UwCZIqp4jfRIlb1A1CwiwBv7muFlVUGUvW+VvjeAcx3ML9SLUsnwLOM9DnFAZncbJHyhZgvLczQbuiRwSml6bmaW9WtWozwmhP81RnCPoJOugSwJnqYbcCzR1HvrOO/+l1bwxxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258792; c=relaxed/simple;
	bh=6nTNdN8QgQi439b7lJaE73iUb6WNpc9gie2egShamqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhC8HVO3nHcsnhsuabUeNHpz2V1Zh4czQW/RJmnsOPIArOPw/fihOXV6y9faEEMseM+pJBLD8XDTSKjUb6zRq1UT1+9oV107z6CjsvGLqEvBdRfjFpA2PYZTNaSg8nXIJEwaqyg701CKDuokav0F42Q0kkaiB1FwRgsGv2YH1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNlRUwSh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso2358671fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759258787; x=1759863587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvDjTcYLd2HV1In46+KbPiFTSYwmuM/iqbqpVCZWQpw=;
        b=dNlRUwShbzHApk2XtI2lUe4HiODWT2iw1/vBuWx52K9gqLkVuOv78YYihxG9O32953
         KtjUgqdWpYvPCmEfQrpKCPOVCn2ohYuPI2iDUFN0qEH81BAMx5UCxT3nvIXZlV7e732n
         xyDPv3/+6fD/S9UFm82QPeCanOxCimS5SWSKjP9wSH9yosIjHztUz69S6zh8F6kBofxP
         xqCpzgSIoBa2RKxLiYDifHK57p9TYOfHSzvXWTiVNYh2Ay4LWPXaztGR+vmbQZlC9Tx/
         RLEaRC7nYjKJWATNGucsm4IAgSIJN7W+ZIF/o4j4BJk5dO557lNeLCc+wMqxIumdo8UG
         Didg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258787; x=1759863587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvDjTcYLd2HV1In46+KbPiFTSYwmuM/iqbqpVCZWQpw=;
        b=UU2QxAygWZKLE75UK/wwGj9FsFQ/2ibcJZiokzW/kPEFDZfrmDBcc1FOzqfoUSqHav
         bVacTGx2GDz1K8wMZRP7OsHWEuru+OMt8D18ojvanjKOw2VTLnPjas+nibE+pTS69kxA
         6lwX9774jdPYjEDGdpC2/gtY4/oFCuuB9U7OjLQ1D+SeX21Q9sS9uIhoYt/d7aAsagaA
         FjBhXF8qZAFD/ukqXJm6Cv3umnsBq4IgHz1al2tjqmbv6nm8b2q9L3+e0cv9oPpk3R58
         j1YMAbRp0Kw8HrVR3Fle60v8LmxV25+eY9fyg+efvd6LKQPM6Ii1G90Nr/IsLv9VOCqy
         B4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ0XoXN5B+1xgg+lBkn0DUrGYGcILkudQYMcALKSvQFL0jfzUuIcr4X1oeLlHUeUWQ3ImOzkjlyxegbgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSVS6GCeNVz8VB+JhwjapKF53FX1D9HNxVy1tzCV4weROfLqu
	KUCYhkIOeyaScr9h70pSs74Vm6Kg7US0zW+fkwRDifIcIWrL/jI9V49ox9EWU5V4uCBcW0RwiaP
	Z6X/j4XqaGDgyV8OdP2q6jdvFbQJ2iVdJY3xB2YEiUA==
X-Gm-Gg: ASbGncvlD+yIHTd6ppffJEShP6ZKd8s+Sm6CRuIP0zoJtK1sp2t1+mzM+NkO1P/4sNr
	SHt+vZHumIT1ficGxhnQMO+swwYhP5tfRoZ05MEOkjZtBQQcDDPlAv1KYHf1Xp1WDt/966AFyhD
	dgOWE4sYxkbUKUCKn34FpQAvs4jGxNuCvUB6zbQf7fta5eQiSz7pKMEhmOyIlutHFOQtZ1NvFZ4
	8LjMyxkCrB3fRWMpSjMWDIrG1gZcjHsRkwXWPaDRg==
X-Google-Smtp-Source: AGHT+IF7yHga9ZFNNFlUCnGviYoo6xKxu/Xxa9beEf2FScatMz1T1FuiOO+dTwFx3frzoKVek9xu9weGLn68tdeB/cg=
X-Received: by 2002:a2e:bc86:0:b0:336:ca1d:2289 with SMTP id
 38308e7fff4ca-373a677fdc0mr2955161fa.14.1759258787562; Tue, 30 Sep 2025
 11:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925202738.2202195-1-helgaas@kernel.org>
In-Reply-To: <20250925202738.2202195-1-helgaas@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Sep 2025 20:59:36 +0200
X-Gm-Features: AS18NWC6gpnBlQLHWM2WkfMaHl46t22UwIFLpSG0ECkTHywqRwSwkayxYupfms8
Message-ID: <CACRpkdZFy2Kb0BaEkMiTi3j89H-6G=chuZSijtRRg7QCCktLDA@mail.gmail.com>
Subject: Re: [PATCH] PCI: ixp4xx: Guard ARM32-specific hook_fault_code()
To: Bjorn Helgaas <helgaas@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> hook_fault_code() is an ARM32-specific API.  Guard it and related code wi=
th
> CONFIG_ARM #ifdefs so the driver can be compile tested on other
> architectures.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

It looks OK to me
Acked-by: Linus Walleij <linus.walleij@linar.org>

I see some other ARM32 drivers use it too, but we surely do
not have a arch-agnostic way of handling bus errors so perhaps it
need to be like this.

I think Russell created the fault hooks originally so CC:ing him
in.

Yours,
Linus Walleij

