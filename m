Return-Path: <linux-kernel+bounces-736455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DFB09D19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD84A81009
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661AA295DAF;
	Fri, 18 Jul 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="je4LupE+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A3294A10
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825382; cv=none; b=ZI1NOF6EgfBHJcXhYnUq38O8Hg2WBmDEb0UF6g942rZ7KeXLOO53EIURBK4S9fCF4VP3Jv6mqJpTBroXxZVAI4Jk3K3MwF9QPkXO6b9ztI4jWfyKNXKv9iUBLAJjP6cVqHADZwDG4mGwyBHuW+Y7fjGSZbJE3PskxSIQe2nKgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825382; c=relaxed/simple;
	bh=alPVexbBxhry3NY0dUuLyiLSWqDYznmgxA4PA0hqC8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo/3bPQfQHwE4bSWY5tTONPWkP83c48KlU6k9mAnq54wEZSWTDnMIsmkViuKdxl3y3QyK0SiCQW7zMSrftMyr+NfMNuuuDB7ZZBxmZtAm9YN/4ljlSZ2o1KTFG58v94PF/7LVgjv7lk4LQIuor+fLlLoy9sflpUaqVzvArLQcBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=je4LupE+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso1070566f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825379; x=1753430179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahNBqCLgi20kpDipeWAA9FM61/0sj5pfbYA2+06aUAo=;
        b=je4LupE+B138ExPFNmZJ3B6BBxAfvbc8+uKQIFyKd1uPr9ZXG5Z11eriUjxDnLF8+/
         otSAv/k0+1a9Q8wKwgY+2BUaE2qAH5RHxwrhOvLnCkqnc7tPHQ94szQio4Bdmg21ESW2
         5dxS+aVE2j5hEcRvJPpNqxP+JC7UCPML4NSVHTed9okUJecffSQSEjnw7Q7RIwFo0eES
         i/3tnPh7J5H8MUFhBrcjt4ogq2E9bdct23UtylCXKM/X74PbVE9SlKxRyof7yFGUfa1T
         qC/3vzaaqznJk7mb/401LI95PYEpXLbUnZ+7zhqsKWS2Bch1/SbAkwihC+/cFIemOjjo
         WJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825379; x=1753430179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahNBqCLgi20kpDipeWAA9FM61/0sj5pfbYA2+06aUAo=;
        b=huuBhvcveWgafpHPJuse6eXBTABoLO6yycYYq5O1luLg26j8JNLQbPPHpJTDpYikIT
         vLNoW57+EbYs9ayYWMxRdMXIBJAq7GHzLC8bBbeBiAzRV09818FG0M950jb+JaRtCCKx
         K8lAKRoKCOdgR73YM7j2WiCVO8FZG7qaLBP7cxSpVyonsvg+90EV3QQCNPh2/c6POvhE
         iqwy5Z2lJG03FtGsSJwq4238oLkXMXdpqgt/6BHo14peviilK8O9Q3Rh7DBpEuw1SCiB
         L31/96Qes7KRKZOoydpZCWHMkZAT22C3Mp1gWX3iuuziwmoLcaTnXfhQsbozvJPLy5JA
         zCPw==
X-Forwarded-Encrypted: i=1; AJvYcCUoyxL/C5lr2F9dxfPaRwwSKk2nI2Ih3uliik4XVoBS/fexGjEsDLtEenX9zyGs2lzIcVucKizWDMwlHWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++Ix0423tGkdhW0bv+i+wTe6To2gbXDfj+oJslC7LDpE6gbbo
	IZZdb8N0kzKu9awnW0Dqj3Z6UfUygqQ4+neIIVVb14UkqBz8F5Mds2O245K3AN9n9Dc=
X-Gm-Gg: ASbGncv7V//oOBK+SQ+fxJRv+G92bYg3TPkDKI+T1cO4s2SJsCLs3/Wj6HSjXRKvZzW
	FSMVEEx7YJEOdknzOTUqrVTz18o3lB1Rtr8gR3irXNrYYtAlO72aNfSSvmSfz1qxsEox+wmxrye
	vwXPrKTXrS4HFkh8fBFLe1GOVQWMPd5uc8p+Cneut9HdZYGZvfwhHhEaP6Khga2tCRfteoKQlbN
	9QzKu7bTGHGESG8rDlSMhA3kCC5sa+Y8hfmgeVVaJ65mxqfSGupOijhLWsGuflbqdmqtT8+l+6f
	PVLpWFxnHVBo2hewp7FeoMDrtoUpePoFH0nzKaQVBYYkjv0GhVQ/YVua2kKSQ5nLqjf+arYNBQk
	FHg0PiU95N3L08AYi7Dr7
X-Google-Smtp-Source: AGHT+IFNTTbzWKYK0ucn/dZcLBK1rm2Jfq9Njsqv0jifRb/BRMEZCeoWnJAL5EROj0k/HrXN7bDTkA==
X-Received: by 2002:a05:6000:178e:b0:3b5:f165:14e1 with SMTP id ffacd0b85a97d-3b613e98294mr4670874f8f.38.1752825379490;
        Fri, 18 Jul 2025 00:56:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert cavium,octeon-3860-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:50 +0200
Message-ID: <175282531512.45055.16195340693528031808.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202927.3012974-1-robh@kernel.org>
References: <20250714202927.3012974-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:29:25 -0500, Rob Herring (Arm) wrote:
> Convert the Cavium Octeon 3860 GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> Looks like Octeon has no maintainers, so Bartosz is listed.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert cavium,octeon-3860-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/5c163c9759605148d0c66acd8d795133c4b48ebb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

