Return-Path: <linux-kernel+bounces-736463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7ACB09D32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747DFA84AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79443293B49;
	Fri, 18 Jul 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GMFeRoOj"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A63C29AB13
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825392; cv=none; b=raLxkmM8eaPeFmk7DdL3VsLV52jtbd3NNoTQTlizseCDZI681TGIVeCJlPiac28a8097hymaB6+GsdMPmAAgU8DGJ08dcUk8/8QjiLBh6fdR3k8IGlC03pqf90QVvCNYnQwt4+L0HXuNlipNt9zbiaVeMeWCLb1E5ZuFbkXGsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825392; c=relaxed/simple;
	bh=2zSrbkBN1qgdayu2lKnPKxAZnlK/9cpO6m2rcBz+RfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZezYfK9mQxfPoPQBMiz3VlsoMB+ng3uz9VY5ziF8U53BRlV6FQUcF+lT30d8vGWhsfYkj3l6/XnB/G1RiWIjLprK21VWGCo221BunbtkLaPA2RPjEmoPnMynlHSLz8tqKF3zhRpt+wN/IK/RBgALV1pO93Ekz4bu1LAokASohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GMFeRoOj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1035494f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825389; x=1753430189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKZhnFJ0UZWMgAl5cwKz/S/30VP8TEq2FhHcHdAs4+M=;
        b=GMFeRoOjOvooxJKlZAnUZgzTWlMLaZYoP62GD1e1YrFzgKVMK5/SBcCA7FwCiMTJV0
         2c8ebX9tx0XbHzZgAQMCRYlctxrQrWYKDnxTr5MDRDdFZ/+hlxZbtkP25HMm+HpcTk0k
         8bU763W50m+lfdyAALtK7oLJb5Bq/Zogocc8nDqY4e+Qcd0iBzHokWqs8h+CA7icXhKU
         TLIi9q31oHSmtJnItpgeQHBdJOYtWSMnF8SPDc/QsjG9DTASOnJB6OsH70c3971iSWFX
         8vhFZaxtTkiNeeI+KKVqAV+iuLZsTBZ/SCs5bHf5GOsG03rtBCEW2f8xoDZ0qjqJLM5y
         XfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825389; x=1753430189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKZhnFJ0UZWMgAl5cwKz/S/30VP8TEq2FhHcHdAs4+M=;
        b=f0/l1GHVvSdojm5NC7ozLfzyB/b7GxSQB13osDgQEOJveHKUsDO8tth/HEBhs3lscS
         hE/cF98nbKR3BgKZd0AIKYdVWWecH+bzIO1j6VVECuyUUHrdYT530gNTYJ51ifwb0Wut
         la/KDR9+dWBByemX4F41ZLWt5vIo73GE5uKQzDpChMD4WzFV0CckmikKoPLa+8LGFwR6
         sFHnNonszdcV4YhNS1iSXa3hkFMSVYwpupearoNytuVUDG1Bs3nxrN/wEo7Pbzpdclxc
         9OZCGOxcUwIXKFDRILbEarWHxFuCeGOtvLzgwmBRsBOfoZylMvWXl9sfYRSGd8v+fLDG
         GaMw==
X-Forwarded-Encrypted: i=1; AJvYcCWEpsjSScaaoyTQUiYMca7pjTYbKZIksm26BQl9V5xDzxb76xd0jfTL3TMVXGzZGENgydhajOfx8JkdLtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Z6+DiEydDL4HUCoiRWOwgvY37NrhL9dMu/qCKRYw6BoKdgtW
	oapmHFvIdcMQ86YwEbFARBoptvRYg0+7KO0dSpPIRvRA8eFNQsx0c2Fn0z4C4BZURqg=
X-Gm-Gg: ASbGncv95xjgucnoKMomN9tBNYEH/2twF4PO2u4rlBSi24030DND4WZoS+YgE2iHAbD
	pRGJWqdWxT1UZZmBlsqcdn8ZpA9dnpRdKreMA0FtuVGr2LOcfZsAcZH0zszZKHg4xc4ew566TvC
	1DrC25qR3nN1YtSYtSZfdRQlZ/TtF6Ui8OqJn3/rUlXH6EdaYhHxFVnWoSmJZQdNvWL8ZSeH0lg
	SeDdt/3Y2siQswGLRyaO+E8POgaEt87KMGc9kH8khpK8CgVx3aQeUZfn1Me2NbhCgz/qYrLZlhm
	84Ztz2vj1W73eouaA6T/u91lT6CC+Waxs3p9Ydy8h0AaUjRMYzDOx5kSk7NXFFLCtoEmdhs6nLG
	Opn0iaDEn5WiATStGXOS5JhRFY4ZTCt4=
X-Google-Smtp-Source: AGHT+IGt4Sp/2DbN6c5CNaWJJ3OCnBcFOsqcxfA4oO8tiDItFVCLYx8dWbwX87QOuiDeXXZ5HwvMkw==
X-Received: by 2002:a05:6000:4911:b0:3b6:119d:58a3 with SMTP id ffacd0b85a97d-3b61b0f6a35mr1231316f8f.26.1752825389525;
        Fri, 18 Jul 2025 00:56:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert ti,keystone-dsp-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:58 +0200
Message-ID: <175282531513.45055.12673543088829296239.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202850.3011952-1-robh@kernel.org>
References: <20250714202850.3011952-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:49 -0500, Rob Herring (Arm) wrote:
> Convert the TI Keystone DSP GPIO binding to DT schema format. The
> "ti,syscon-dev" property was wrong and should be "gpio,syscon-dev"
> instead.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert ti,keystone-dsp-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/aff0a1701b020c8e6b172f28828fd4f3e6eed41a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

