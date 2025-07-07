Return-Path: <linux-kernel+bounces-720333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A691AFBA68
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B439A4A5A53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC212641D8;
	Mon,  7 Jul 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fjy2trOS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B703194C96
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911918; cv=none; b=diG13jE3T80G4dp2kENrUGN0/29lyvszkCJla85AYpLgaKwj2N7PwMurldRvtx5z6/S/+CrcnWnnJEmFNpA41vQ/12Wfx0+uGHQTtsnvarLwrNUwzGtQagTC0aK3XR0oUuUFqG9M/fmNw8a/S4aXz66Op+TgbpQU7rrzSNDdydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911918; c=relaxed/simple;
	bh=FeelGp03cD6nLu/ebjrQ7bTkW6++SjPk99pll2SXrOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSVcaJXI7S/NlvBu8Ka5bfOVUnd8FgchfMnFSydFunN9QlI0aI1ayfgMP9ajorQ7b7lSrL4hAvrqdcS1P/Ax4UpvNkleBcVeJ/am4HrSLl9FEndvunAj4sEG0WsEQC80GjW9nTBzhewKR1DClKtu8JZ261Dpt0/E2gcbTaxvZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fjy2trOS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so552658466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1751911915; x=1752516715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeelGp03cD6nLu/ebjrQ7bTkW6++SjPk99pll2SXrOU=;
        b=fjy2trOSvSdioE6gvXfAjOsWeKh4iZVp2tyhGQzz3YBmnT0sgzj0Lc9EVX96ypJyA+
         4hBda97eFh1814NUIkID8HAI3nrJB/mRlqtX4aXcvwEcDrGVqFO5CL991DZvO6Dmp8jj
         1pqDCTsM+IVwP2eN8FOLy3WGQ4tWuumGdyxc8jDk7s4qW/0tos52gxzeO0h2cn75OA40
         nHna2VRY1UeOwuM8jYciRbfZdJl/PdcYJvi86TjAisXIE5vSubk+BJU85SlStFJVYioq
         zbyWPegH8mDxFvlmVKZnyc0OMRd4hZr4ikLLPAaDEpUgY22e5Xwm4AAQ7Rb9V1+P+Ojr
         g4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911915; x=1752516715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeelGp03cD6nLu/ebjrQ7bTkW6++SjPk99pll2SXrOU=;
        b=b+ODBQnG7VB+QDQf5fKNlITlea0CmmIyiMCUXy9B9H88Umpl8HM3u4CO2qqn0Z/lVd
         4ufwJQzxOXEWe808HTQ2jD8la1pYajFllJPlM+pIwpTVlitNGHoJoPDzI+XDio98TbnK
         /Nfbkf1gDMx6bwB8ZTOMFOIKgGyFPS9eUMnPHO0eGwf/lmds9U0EZPhU9a82CVBWdUBF
         L9nFgEMzRjN9LX3QDy3WweEQsHip8GA4FpCze8hMkss1DXeU4R4bQSmAgtjrJYvjVLcE
         3tdqFUSPh+52ZdzhxmRLmBzQnLxIBIq8ntaIzTytRW7E2UwIyc12nVJ3W+TH3hvtUDHp
         NBFg==
X-Forwarded-Encrypted: i=1; AJvYcCXfamYJ4KJ/gTEPm8vTBQceK/o5w1kvH6EImqGmO+vAnr4OToWclUERxMyKGdxyMYFUKHZYNcPmyMkoQlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaclL9SiojvChBB7OQyrTz29qw5HDzLkmV4E43Oh4H/8NktIaj
	7jRkKdK/G5/rmeOrCYskrURw++gLNwt3jl3eY4cJ97ARi1CnpORf9OVhM7F9t366YrlD46kAel5
	t7pq+nKMFzzuyTCDOhdEgXJOmCmTwqex2VcbE4HkrVQ==
X-Gm-Gg: ASbGncvvX55KLP19Yv2zT85WuHC7bRgxGUUxK0ykeZxJouljdaYJ4JeAV4OTxRjatYi
	+AM4mxy/P1aifXWAkfH+xVLMNUycocQk9C/1y/SM2+8Qv4hOypb+88ROZ5m1yhyrAGvDOwVAUjt
	r/2DxrUtfZXKY4bdsK0yjj5mfILgzlCEQaumWIsY2yeQt/x0Wj+7XWEozVSpD/yyJtFy34kvw=
X-Google-Smtp-Source: AGHT+IEZrzrTgSciHz2HqpKMsXdqz6wjFZtv8s3b3A3lB+TjADzu/8zqD3hp7DHb3vKX3ijtpaXqg7Tdj61r1dHnlAU=
X-Received: by 2002:a17:907:7290:b0:ae3:f524:bd2 with SMTP id
 a640c23a62f3a-ae3fe64e7b4mr1172327466b.10.1751911914757; Mon, 07 Jul 2025
 11:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-20-viro@zeniv.linux.org.uk> <CAKPOu+_Ktbp5OMZv77UfLRyRaqmK1kUpNHNd1C=J9ihvjWLDZg@mail.gmail.com>
 <20250707172956.GF1880847@ZenIV> <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV>
In-Reply-To: <20250707180026.GG1880847@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 7 Jul 2025 20:11:43 +0200
X-Gm-Features: Ac12FXz6qldypWeq_Bn-GGOukpKg9f4xiRwm8xS7LHIlbt3qzKLA3vBlj5r4ti0
Message-ID: <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 8:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> Well, it tries to evict all non-busy dentries, along with the ones that
> are only busy due to (non-busy) children, etc.

But why did you add code that keeps looping if a dead/killed dentry
was found, even though there is no code to do anything with such a
dentry?

