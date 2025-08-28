Return-Path: <linux-kernel+bounces-790552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E723B3AA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B4F7ABBB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BD277008;
	Thu, 28 Aug 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQDqJvLI"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9B176ADB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406358; cv=none; b=ffpjW1dXokOQhHchZvrdnq8j7WDyoZk5fgeEN+0wf3ypgBOT7HSL0PenuOwKWVFHAPr0Z3OYJ/bN55YJTZ4F59ouSvvvALHzz8Gwz8xU1bJvs748RsU1bIYfTv1z5bW6ckOsNtvIVkt/r6m7kx9iDxV3T/G4jSUYtIF9aLOdchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406358; c=relaxed/simple;
	bh=E0ckteGAESBs8jcf8OZOftDZRFDWIXrQjnpmEjqlDzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0SlvTCPt6JaPSXhgYXDCoRS5UrTNPNzE7+T48XWilblGgtlNOjFD0Vd76Yw/ALJRHUapYuuTm/PcZfL3xpMG6RKPUKpXMXWcqQisp4hZo2Kqe2af4JpQc/ZHyG+2jJU8E+ov71Q+0I7MLpi5iMHQgs7FHg2Vd/FON4fBQ9l4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zQDqJvLI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f4cf36c00so1371470e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756406355; x=1757011155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0ckteGAESBs8jcf8OZOftDZRFDWIXrQjnpmEjqlDzI=;
        b=zQDqJvLIKbqGWjUKzrHVrChQY9QXq90cW8vvzTpfc8oTRFLyCDciuRJYg1b7fI6en9
         v8mquGDvp1BHivXI4AYJ7NAyvVWY9ahoZLO8pkbkSfEBZvcJHO5Pxt1ugONIb2DNmKeR
         /OGWmDUvUFDLiJIS5AxyibtUKF5inq50GhmDj3NOYZPDdgt2XYhUyYinQg0UsGQXOku6
         gEZBnCOesbNtEMyrud1AFZLwcNRXVlCqmlS/zceGoTzlk/gwHr4CEspDRdgoJsgkJdPT
         XNvMGxEjLBeekTsYWEpIwLvbwdKUveeP86l3ptC1e80xoK7cxk3yypjMAyovcFWOxzhX
         EjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406355; x=1757011155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0ckteGAESBs8jcf8OZOftDZRFDWIXrQjnpmEjqlDzI=;
        b=EiWDq2BQJDRg9FQ0ofZb7LjvYlDkskvQpaDwdMel8KccZjeLY1p6c+9G4y5Za8nbUZ
         aZSpF1kc6abTPyPO1CKPp4hYl+p6gxj2XsPH6f8ZUFVvni3LnFrN6ahigu5B/w+witE7
         tSxabgBZVfc4iV46PWFZFAh5kRR9triVkZ4SWCDHwj0TpNsRCEsci3y2VfsrsnfWY7IK
         oc8ThBZI8OA13IH3FoweKlXzE2QXEnTbMsJl2w3L7dqPUBz7GmmExG/4YuRZGo2jCKx7
         VW+DSYNoNoaf8FLVcZGOiONkqRmmXiSyB2iWUAG6UIZTOkkPCNILjuHeeOrosE2W1QQD
         oztg==
X-Forwarded-Encrypted: i=1; AJvYcCXcq+WBM5728bwqCcuKPKkJW87HCDGopmky6e10+3VMXCq/hMK7kbDLUyfC0OSwkBU2kCNXZZAvakCFcwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxFOhPdDqDWnesMSKRDCEx3T2xFHiQNjIQ/WjIftkSQYsk45M
	gsIjIB60E4SI7tkxNpj6hsFqgG5paCCooNf4jTNHv4aUcHSwZed+GWHOxdy0F7BFH/rlLjBho1S
	iK7vvm1jRYWL7ttJSeAfa+PXc8cLIL/Isxz/Lv+cDkKs6do/Oe2bK
X-Gm-Gg: ASbGncua9B+RJjrQ+oihDByFwQI8WKL95NozsbDLSeu5UMfLhXGoTtDvl8xqSICzaLr
	k3DYw66aP3HQdMdgmfPgsTzpPa3ntiKPGD0wueRzxmJdiT6cCx/OJsYv+XZafyyIqgl8MGoDCpt
	4ObLnYO27BmQdRM0hnb4g3PG+7mZXfJ87gNtvxbOCIE8waAnO82rqN9q+ho9mCQLH35kbpXIUBk
	m0q2oZwCUR2XHON7w==
X-Google-Smtp-Source: AGHT+IEW/rZTrjCCovtsKbGN3zvurPp8ZHpS2GVDC7ghNOSAMSVHLkB9FDrrp1lAJKfN2C09p5nry2jkSt7wbvI4iYo=
X-Received: by 2002:a05:6512:3b09:b0:55f:4839:d05f with SMTP id
 2adb3069b0e04-55f4839d30amr4000473e87.49.1756406354836; Thu, 28 Aug 2025
 11:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823212732.356620-1-alex.t.tran@gmail.com>
In-Reply-To: <20250823212732.356620-1-alex.t.tran@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 20:39:03 +0200
X-Gm-Features: Ac12FXym_RsvFHR0V-adi-Z38di1fxjCCKa-fkpd5JJ5TmFdT4-cHh1WYo-j-eg
Message-ID: <CACRpkdY4sCFZqK2D+XP7ctK_EJD3aOO4CGh40uQsdACyAUOofg@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/boot/dts/st/ste-ux500-samsung: dts bluetooth
 wakeup interrupt
To: Alex Tran <alex.t.tran@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 11:27=E2=80=AFPM Alex Tran <alex.t.tran@gmail.com> =
wrote:

> Interrupt support on host wakeup gpio for ste-ux500-samsung bluetooth.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

Patch applied!

Yours,
Linus Walleij

