Return-Path: <linux-kernel+bounces-814099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A91BB54F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3E57AF8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCA30DD05;
	Fri, 12 Sep 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaqoIiBN"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7226561D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683127; cv=none; b=OAm6lhOnuj8ZHCk/RXw3araPLqirWZcfZl/byBj+GxZE9jVc0B8ZJShwdoXN+qMsosQTdgL+ZVUbannbqn5ur4Tm0A6Hp0xAQ3m1nnEx1LbuAm1bIHhPPV1Jyhftkp6P6v9otdSL4y6KnFjt2t+JpiPZaSV5AzDaJkZOwM8xkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683127; c=relaxed/simple;
	bh=oeww4Ivx5YThdAfSYdbOCn1Gj1LUFzN/W4lJGwFtW3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgnbKZe6yceD8nRtN0XMcUiAqrVKP2MOtSgRgKTTRnQzmPaMRHYxOZtDtKu5DOK2AWwsIE0wTDrn/tGzdzYtGGmmqKxd57YNvS0vMIRak7qb3Y2ZHaYg8UKFuU8o8XyWZg/mZEajQmZQJ19w3jqLOw8kOpHq3jHgezYmdD6KSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XaqoIiBN; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61e6ee53d2dso413518eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757683125; x=1758287925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oeww4Ivx5YThdAfSYdbOCn1Gj1LUFzN/W4lJGwFtW3A=;
        b=XaqoIiBNSrrR2zrG++Bsaoq01VFgfEBGxJ+ysCJftMjj0hrGwBUazuS8iGMytsu/8+
         lTgSxMhEpFJuwhmEn1BH4LoZXb+4OVkBjrOwayy1oNBLRD3QvKof5X70wP0OE6BjrqAj
         Pyj/o9cUfpERUcSu749OXC2u09WfqzBhvJ8fwOUlATiCOTXxW+yURv9ck5QljCIWUDlT
         awKwsMPlCDb510+qlAr2M0LZepenW4WnUIhkOS2NvH2+pk75XlcNBAMYZYa/bEe7rdFK
         5Tpb8/xdAjXOZg4wYnwQDriqs9vJ9EZVUKb3ZqzkWdffm5cyc3VdJkVI3Ej7E8vDnMw4
         uItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683125; x=1758287925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeww4Ivx5YThdAfSYdbOCn1Gj1LUFzN/W4lJGwFtW3A=;
        b=BWH7MKdRmkdb6YqEFLls8GsUwa9MTBMbbb7KNirLmw4yGbKZxgF7JUFLyepH+BzoAs
         ix8dt4fWdMsfBECXB1N2FNBpgrEQXGm/GHQ/OoXWcukw4CLGzKdhG6XBX6gEZFlSNW3u
         Vcu9EwOYC2EbqKl/HcUxrD/CIvi3zUZDBcPZZo0X9Xftq7QnhkyUoiN+WypBVmTENC8S
         Tbko71BP0bcTHJWNM8mFJnS04dbPId97kMmTxFbCD3mvPw69Zl9ugDAHWHYM2cQtd4JL
         Mb9QnjoDqeaihgvNEoxu1CMCc4eN8+QDoImzmVa/zhiJc4nUTV/Woy0WNukWSJqfufmo
         8/bA==
X-Forwarded-Encrypted: i=1; AJvYcCW0rKcoJbwopG1BigIR0VfPJfi1XHxv7SLq4Znq5iTPTxTTEEncWQyN78vWfLQOuerIO4zvfPJ8RNO49so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7tCmVirS5wg4SWoPILGUZYRMmEIceqU1wLiOalVIC9q0fKkE
	tA5PDTT193qit6mnjZQDXcZ2Y4fM0jtLTWbwecPfuRaq3I62KZoX9pELl/VubFsF75B5G5vqrd1
	w4y7A5HM3vayQruE351Jn9PNt6ITD5pvTccqQfimwqw==
X-Gm-Gg: ASbGncvHtiC0DApndgi9gcD8lB513VFxGl9KZDx7o2l2br72dSTQla42ptDyUzaO5jb
	XtK7NnDbDmHFwAxl0R7DQVfl/u5APi61gmt3I9inQEDgreio4uqxbEIcTSq1y3ubztMjtgF6hiN
	WYwLVbbn0KMd5dR0aL0u+/4G3E6xhwO89bQTlSXa1xXDq0fRtUF2HXg9eWQ+nSJ6zu0UAINp5N/
	UFFMdk=
X-Google-Smtp-Source: AGHT+IGfSaVuijaDjlm+oIKN2iiydfgKjK+5YsMgIZmmXxQ/CONJDi7ONHUL/Qm+aJ4qj0ySkZLSHpb1XTjKs2wTKXo=
X-Received: by 2002:a05:6871:154:b0:322:4639:f3a0 with SMTP id
 586e51a60fabf-32e53e60589mr1203923fac.9.1757683125291; Fri, 12 Sep 2025
 06:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907202752.3613183-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250907202752.3613183-1-alok.a.tiwari@oracle.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 14:18:34 +0100
X-Gm-Features: Ac12FXyFWdruiBB0gYT4kEG-HddeFzWWyfMX32BSCDTTl49jpBagppTHhtL-eME
Message-ID: <CADrjBPoByCUtKLR193QpfMv+1VTspq1s8Mzm4dzLCUai8P30Tg@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: exynos: correct sync pattern mask timing comment
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: alim.akhtar@samsung.com, krzk@kernel.org, martin.petersen@oracle.com, 
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Sept 2025 at 21:27, Alok Tiwari <alok.a.tiwari@oracle.com> wrote:
>
> Fix the comment for SYNC_LEN_G2 in exynos_ufs_config_sync_pattern_mask().
> The actual value is 40us, not 44us, matching the configured mask timing.
> This change improves code clarity and avoids potential confusion for
> readers and maintainers.
>
> No functional changes.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

