Return-Path: <linux-kernel+bounces-892197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D8C44995
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2362D4E44FF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64B26ED28;
	Sun,  9 Nov 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WphjKROj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34BE22157B
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729215; cv=none; b=al5AVWM/N53STr8MI90zClHYBBSaJgTPxsAl15R9qen0FiGVwpuN+fYWDv2gpI/r9jChnbFo4qBTMLeZ1VH63cVZMxEcV7cFhBYAHTukbKJQctCIf9IWp8B4ebkC+gMu6r/QPuNK98n6/Wx9jfkZ7zfbgE6K1cPqWXZ32vYTzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729215; c=relaxed/simple;
	bh=iKc25oQSbZRl7VlctllP5IsEdsg2xNByDusfO0Gzw60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOcM6FvTq1jjsjzpZWcECG/lg2S4l0u70XRMT1w7PjZ9q+tcP2lHJ7LH/GDsowO05YQwHGmkC0vRzD2ThUCSE4UuY1JLkOaRS19+O88E7FBckD+feWLD5EYW0ejiTA6XeQNr33Sz86mZf0RhtQ+0E/xHPEfScZE5MbPSo9EvdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WphjKROj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943d1d6442so2204379e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762729212; x=1763334012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKc25oQSbZRl7VlctllP5IsEdsg2xNByDusfO0Gzw60=;
        b=WphjKROjW0sjOXWleUeLfiRHTRkjfSJxEepHCq2MhCOv0cNvh2KFNW/O25Xgv1S7Kr
         LEKhPHaCHOlNshdpvYhJCOf4GXhYS9wg1JW9rWwlQPWeVvkSz0Vsj/0P95T5IF7ho9ro
         zGuxgn1krhhhDG1orrOPMip0uqijW1gYyEv1VX4sDRqRsC3d33o+f3tYOjJB81isWss/
         Zof/sZzOsVyU130tAeS0z1yOQYVmfXGrfj/0vEXqt8dS4odWleY4pxO5kBlhZsAtYgYJ
         PGr62g0XPg4AN/VvbF9IoL8K5+b0OTxgTZUdIrORCveQovdZ8RTinoIWrJvrrACPlEwd
         DNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729212; x=1763334012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKc25oQSbZRl7VlctllP5IsEdsg2xNByDusfO0Gzw60=;
        b=hW9zQfWyB0+ylO4U4We5XE71FU7ZWEQcp31iV1t55EJRYIeI2heq9h3Q2cgl92oqCR
         0j/Kc0Yw06+tM9ir3dChrnTbCr662S+bGcHZLrMEnheyOaWMhUFCTHw/Gd25YunB/auq
         cmWX/UbSqDrNCItxlQSPP8CfXZytNb6z1Yf/zQpaMKMcDv9SLKTkJfmiuNcHC6hKldRc
         s6P8V9A+vVX+zjjxWWw0VA1D9hX7fLGN7zfjro0DXWBbyHsMqo7y21/aTd9fFV4Uq0u7
         uq0EoWJIwPT5TxTNHEqH/g2gxVwVOwoG0dEzKruiL5SIVTYkwMOquY+aHqLszgh18GsY
         lFpQ==
X-Gm-Message-State: AOJu0YxhwOOOK5bJNxnlAJfjhcpSEcMQwrUPY7HC2xJ7qPl7PsVCeBQI
	XSqQlr54P9JnHhDtU+AmnEB61oMt8dt3ayrnlGLUbsid4qL3AHAzPaEh9b2q1ItB5ngVpM5zND2
	qIGNFyCe36byklrjK77M9VlbaAPwtumOO8NWZEZoSshk573x3yVm3
X-Gm-Gg: ASbGnctfDEy4LXK3sdFgZjMLNqOExkCrowaQpaTcN0SYRGD65dXSTF6QFvLtfqAWfLI
	SCcY2YzbQ0kCpB5GVI+JPVHHtx+osNVuJ2AoH5y5zu7roYrux8OMYur6ujT1uY1KbvlBYbcs30Q
	M88rEHIVhgT8r1gnupb3hcoI+2hIK+VeF9y6ZXm9HwM9vEc/ySwASm00vQThU4x8GALL1u67DAA
	aq0/jcucspVpsLE0rCoe2VZvN8qB307rSLoABYF62jvq5FA/Hd5SgBxpB6w
X-Google-Smtp-Source: AGHT+IGJmOKTnUV+UniqvgrDA0c7KpeZCqg798RQ2zsDdVKtR6JZh2MyHXYjHqCd1zfIhK+2HuNAVW83h+gE7fAqk4w=
X-Received: by 2002:a05:6512:3c96:b0:594:33fc:d52b with SMTP id
 2adb3069b0e04-5945f1d9c97mr1634720e87.36.1762729211729; Sun, 09 Nov 2025
 15:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031111628.143924-1-marco.crivellari@suse.com> <20251031111628.143924-2-marco.crivellari@suse.com>
In-Reply-To: <20251031111628.143924-2-marco.crivellari@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 9 Nov 2025 23:59:59 +0100
X-Gm-Features: AWmQ_bkG8qfTXswmVWDlpz0qlKljyoxRJh0UQhZNWg_36sNiFhAbKQW9SolVsi0
Message-ID: <CACRpkdYkdhp_eHLP688gAwnrJppqkQn=RT_Lg4A+kd0uBqBBcQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: cdev: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:16=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:

> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistency cannot be addressed without refactoring the API.
>
> system_wq should be the per-cpu workqueue, yet in this name nothing makes
> that clear, so replace system_wq with system_percpu_wq.
>
> The old wq (system_wq) will be kept for a few release cycles.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Looked over the similar changes to FS core etc. It makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

