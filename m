Return-Path: <linux-kernel+bounces-749755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B983DB15283
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0C718A489E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568F298CA2;
	Tue, 29 Jul 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fETmORvG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38720299A9E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812719; cv=none; b=emBl0qJFQ7PAjoE2nbTw7b6Klh5tjx6luPAzavTj7XCvxi2rhKnxEzkc2P+LQ5pE2iR6+ixTj3tIcK20NCeeAIZHfN4br61zGPxiGnB21iJ3uoDy+d1sztxn4/G/X1WaGENnNf+mQfIeQcXUFG3tmI+tDRwrDtsAysMl6GRsfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812719; c=relaxed/simple;
	bh=57u+F6SPbw9ETK1L1hEuDIvslqxqqcWZl/TehcN3dpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWtveJ4sGpGLliS9oG8WQr8PWBsOPwsQl8U9oZEi1BQiiQtVPDL2jUMlY3QcOb1BI9UwonMjTS6Om/DlL7tmH91o9t6FmnrvXLyPeRbDKsef3lwxIGg7jyz8jjYkRgpUrpqoDL0Bkog5uO3vhuLeHiOI0sDy/UoHBiAgTYJthBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fETmORvG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0d7b32322so1001861466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753812715; x=1754417515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwP3dr7YyDibVHyf7li9AJtXWtRFZLZZCBSKzcLCyxA=;
        b=fETmORvGvLrF9SF+7NGxj1pVo+1rwca38MrMy6MY14g5SV06RLZF9D2B7gR6XQmDDC
         1TXlLFazgb0/uSDzFFdeug6sZeeokRXbWnDim6qAqAmyo5pFMOQcqZF681WQZEG4lwC3
         qu9tICqz1M6GoosBnCHcXrHP9I/9U/UgJycxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753812715; x=1754417515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwP3dr7YyDibVHyf7li9AJtXWtRFZLZZCBSKzcLCyxA=;
        b=gjONwaQ3t2N3VL6/BwzOXBPJtzvEaBcLrnYmPReIJ1Ld5VbGQyhDThspZs38EHT71j
         t1lKSvoPvQTQL92Q8AEZPkvqm8a1P4thidFqgLNBIEiNxm4nZy6irMnO+bWWsuuFNPGw
         r1mLxlTO1a1T4pXvQjiHeDppcj20XH02h4nmrfi3KDCTTMM6lomNBxZZCxCRgg3mllDF
         Dc65/ck4HKHWztJjbvDGYBb1omP+yT+Wfrxz1rSl1M14mSAA1p6MNM5CP92p92cG7Lb4
         FK5fGNABMmYp14L4Ho5ot7ewyn2cXwxqCumvqhCvmn2uwoFWpqY/ZQGJNgGeTBXFNRbh
         veRw==
X-Gm-Message-State: AOJu0YwSLOLyNKAVqpE9hVgI3uVbaILhTR5imXmxTFwus44e1lf8C5ws
	W8GpVlz3H4GACN/yAF/bvbp0ke/w5UydrFvbsJrSPAL7atpWrkzSk9t1MKwwNxzdJ2/wZvDdEiq
	2d1YAf4Y=
X-Gm-Gg: ASbGncumdMCUpikvrxFa+Ug17gZpQ3vjnm8Zc7KuORomHXYWwooDWjlrsEPAmtowaJ4
	cAHdOiDHgl18WDDRr61IJDxM2dc70qdKFHN8yLYhTv3mTMBs2g0Iccg35lGdlSmlxon8i7mHQG8
	qOv+CohHIcDp9luGhE2efKBnHj89FMhV2DVfNaS0y3KGekSUDGQl276EolHccJjR0W8ZruX7VIZ
	EZQjJuaoB8c9mlk50/y8e6baL87NZLyoOpP1ufSfji6vDi7ul6R3Z3vtpZ01ocp4UZj+ZLIyTdy
	C3L1rF/BQIlxw6JqTluykeKzgwdGts+TOA179yrdhElCfA0lT2yjTdV/pA0WsAltmv4aVSdH3ji
	C8gIeKAaI6+Bd5RHu0LxqbeX6ySeTR0tjkzIRpldo/zy/9PMOxHPDTawNpiNsYPCgtbwi5tGcs/
	8XbgumH94=
X-Google-Smtp-Source: AGHT+IEpATNnMrkJ4/W3y4kDEeAONy2B/rTTq7CVw564i6gOnAg/tb5vplIzVe/sMQgOyhJQbpJNKA==
X-Received: by 2002:a17:907:3cca:b0:aec:f8bb:abeb with SMTP id a640c23a62f3a-af8fd9a5c45mr52739866b.42.1753812715264;
        Tue, 29 Jul 2025 11:11:55 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635afbd57sm606923766b.134.2025.07.29.11.11.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 11:11:54 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so1039964a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:11:54 -0700 (PDT)
X-Received: by 2002:a05:6402:278d:b0:615:399e:d3ba with SMTP id
 4fb4d7f45d1cf-615872038b7mr479533a12.32.1753812713808; Tue, 29 Jul 2025
 11:11:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com> <cc7b0bd2-53be-4981-bef2-44903b64dd6a@app.fastmail.com>
In-Reply-To: <cc7b0bd2-53be-4981-bef2-44903b64dd6a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 Jul 2025 11:11:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4JiEFZ1ofX5Df5mvhYS4Ob0_JpHGd2VxNzDypWknqXg@mail.gmail.com>
X-Gm-Features: Ac12FXz1Qxn4crxv1oBy3yf37kVc7TYxrFXCgROlz1H2zNpBoR4Q1XkLw2GtmWA
Message-ID: <CAHk-=wi4JiEFZ1ofX5Df5mvhYS4Ob0_JpHGd2VxNzDypWknqXg@mail.gmail.com>
Subject: Re: [GIT PULL 1/5] soc: dt changes for 6.17
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 03:28, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.17

So this caused a trivial conflict with some of the usb additions (in
the freescale s32g2 and s32g3 dt files) I just pulled in through the
usb tree commit d1b07cc0868f ("arm64: dts: s32g: Add USB device tree
information for s32g2/s32g3")

The conflicts are trivial, but I thought I'd mention them just because
they put the DT info out of order wrt the addresses things are mapped
at, and in one case also had some odd whitespace.

I did *not* change either of those in the merge, so the oddities
remain. But I thought I'd mention them in case somebody cares and
wants to fix things up.

                Linus

