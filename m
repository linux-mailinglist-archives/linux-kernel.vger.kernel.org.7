Return-Path: <linux-kernel+bounces-782639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E4B322F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11DA7B5801
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2966A278E7B;
	Fri, 22 Aug 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsrJbd7G"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BF15E90
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891450; cv=none; b=HQDlwaBuM38w/xR43xAk4AOhC6JXtXkC4xQ+PX2LprPopCOBnJjnHMl5asnDRDAPFogdyQ8dF9xBj4czm6Y4qq+cuQlb84pdo1oe3szQfEN5XMTni6fTUU7dr7ri7ZHIrSdoCjT9kVSnb0v1DFKVjQNx++gg0MeM3UiJ1qt5JXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891450; c=relaxed/simple;
	bh=Tp/e7RnCZ5utCSTvwI/+YYqeFiNEXOdt3Qq8aW1TM0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLPiLr135YaLSnqry20oQrvB/1ZAHSRIWOjwCSzL7d9BZeD2XiV9937h3EmbPoW6TaE/WYtv7SBaQhYi0QuHeuoqe4evYqyG0tLD7xKQJpzroBGbd7jVRCAN2Pb67AG0OG7EIuokQd1hFzEM5sMjjK8p5thGcyn42UzkGa7M0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsrJbd7G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so14835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755891447; x=1756496247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp/e7RnCZ5utCSTvwI/+YYqeFiNEXOdt3Qq8aW1TM0Q=;
        b=JsrJbd7GMSI15hbh7K884l9RzS8sZt41j13uIrRU7Q1EIgyWLg6DhsvxemZmHX4ZN0
         HIBwqiiuYwfk5Lk6bQRVwJuCJC7Kx6bFXNjvdm/s61SGKqtgfL+iHa6CP3fT/NZ57QMH
         mtleSnZ73iTq/zKB1MGt72mk3yRjTzWe/6bZLK1D463av60mS3EweJa9KnYyqownWm7s
         Ph+/+BandfWbl0XdgeV3nnUYsTq7L0oIgo8KkahR3uFeL49kBlLgWq0FEXSrMu2cjXtg
         l2HBsZGqrflZ89BDBBN1KQxI+t13kuxrTy8AeROZKJecs3qgyBizEGDm5abrrwED9sOs
         Fg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891447; x=1756496247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp/e7RnCZ5utCSTvwI/+YYqeFiNEXOdt3Qq8aW1TM0Q=;
        b=dI4qFtmKGlPXYOGOBrV0AXsK7vq+kZeJIHx/BvHUcr+ONC9fX4DGv98/ZZHrrUv0fy
         LqibAIAxFtqh+4zES87B7+hOUaOgfOGLknlcVCLWRF8+UhTSmImStpLJEDzndKLlmh+B
         e87fdKDqHNBjTcuVcdSBaLkGrzIa6Un7suvMmueOn3S+03jxPYMV2nZEetQHFKf/RNLc
         PPOarxjblcfsYCtPPQSX3UKbgCMQ8yxzrstDZdcs6yyJqza4hNXeo9k3ZQFIRgOsQnwS
         nzLu6oRp3+XRyYA8q+pj3VWzOrxykYvLN8mlQnhaiL6rpYICSBHmxo1XUX6zU8Auazhu
         QcCg==
X-Forwarded-Encrypted: i=1; AJvYcCWpx3h4FMCsyrcXWOTFexQPObad7voKmR23dRoucWY2HjAITAonCiUcb/XLafUXgk5MAhnxahE5aGtFvo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyarWAYYRVObAiCvf2IKA7Xp7OyAD4mliWKQym9yyQUWBmkXNqs
	b9Jvvl9AmBPM6OjyKxbs19Ju6OJ1KC2GKVzadmfcwmeSyGPowCyDkWHwR9JiAiJSHIxXBsOUBe/
	YqVg2CIwLI+yxK1U4Mo/X3ddItT1ja5uuTx3NBGEq
X-Gm-Gg: ASbGncuTbsq2WFEveEVviZK4LeRvoL/v/Y++DTEnl+eSxKFNw1lDg0wtGohzAzz69eH
	1VsRvutZL4A9ukR9Fs9Hq3St13g2fahN++1+VBYfSTDpBocf7zvpV3Ldbe6gMVpnt1F5E8bZOOx
	h5jj9HgCEDSA1eil4F/nqD/6eEk1zlwzHbM59SBNAEa++cEgIOjtQFS7WT7O/Ajpuh2ReRMTnq7
	CzD6BVSW7I=
X-Google-Smtp-Source: AGHT+IFM8Qc04SB7n51+lw9eWU3mlfK5MlxysgYm2SUd8YtzaBNBwqQKXqGL1U0gTHjo7ngSKm60iexhv+vmlEaWOuU=
X-Received: by 2002:a05:600c:609a:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45b57d7950fmr162795e9.6.1755891447281; Fri, 22 Aug 2025
 12:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822125454.1287066-1-wangjinchao600@gmail.com> <20250822125454.1287066-2-wangjinchao600@gmail.com>
In-Reply-To: <20250822125454.1287066-2-wangjinchao600@gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 22 Aug 2025 12:36:47 -0700
X-Gm-Features: Ac12FXw3JD5OhMNY1bdXpTG2iWnDIEoV5tjk548--5EgawhWSc6BYxskVA_msPM
Message-ID: <CABCJKucGtbZw_DCpnbUr7cQeU+_DF97YTeDVgPX7tTyPwNabog@mail.gmail.com>
Subject: Re: [PATCH 1/5] module: Fix module_sig_check() for modules with
 ignored modversions/vermagic
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:55=E2=80=AFAM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
>
> The current signature check logic incorrectly fails modules that have
> valid signatures when the caller specifies MODULE_INIT_IGNORE_MODVERSIONS
> or MODULE_INIT_IGNORE_VERMAGIC flags. This happens because the code
> treats these flags as indicating a "mangled module" and skips signature
> verification entirely.
>
> The key insight is that the intent of the caller (to ignore modversions
> or vermagic) should not affect signature verification. A module with
> a valid signature should be verified regardless of whether the caller
> wants to ignore versioning information.

Why would you need to ignore versions when loading signed modules?
Here's the original series that added this check and I feel it's very
much relevant still:

https://lore.kernel.org/lkml/20160423184421.GL3348@decadent.org.uk/

Sami

