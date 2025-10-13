Return-Path: <linux-kernel+bounces-850315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A56CBD27C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6246F3A7BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9A2FE587;
	Mon, 13 Oct 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUGnC4X0"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844C2FE06F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350329; cv=none; b=gCJ4Lt2yQxYrI1C45AMXNtRAunJk0WiZSXvx4yxTemypFl+eCOM2xqYTp70G1T+NOikN29UeHz9jLyecvPxHPYv4HE3qPqNg+ml9Gce8g4+xelXJpuuguGg84VKPu+G8Be+fimVz/mtxbRzd3RIJ97PE6LFHBmdcHoR8DX9kWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350329; c=relaxed/simple;
	bh=RdLBpMQJKF/WdkdrgqI4Lr7gfqMU0n7ItqvnZUJi0J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kndVCOi0hYOAAcp0MW1AH05RMtaJkcV1tSRFWEQHa3q6myenDSc5YTyfGFcsXAVRngN7v697PzQ6j6DLu0jjegQhUCWLMrmWMAmDaFWS3J2AoOj5t6pmk7R6D8sXrJf7OUzlkKqdX626/LvniTEXWfARSl1q19wkG0GZ8HS0plo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CUGnC4X0; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so34757041fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760350326; x=1760955126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdLBpMQJKF/WdkdrgqI4Lr7gfqMU0n7ItqvnZUJi0J8=;
        b=CUGnC4X0LsOZkm7rzFvtwdsjj6i83AeVSJNOz5RIM4DJRYN8LBvQ6SY88Ij8C/gf0p
         wfUAFCFvYRNAqdY8D1FMDD2Da6OULjDiInNI1Hz7E/GOqVlmHXinYjYSnx7hKkLjcVRe
         q0dRljoa41khBHal6ntClNRUsFENEfXDE+06lS6I67lPmR40tMtprJbP7wjiiX7/036X
         nW/vuX40nSpbLby9fIhcbx6/frqTlWhnV+V4Lb3fXyShDH7jWw1sEDhUgFeEwhgKl7XG
         QZWB5INAuqWYZLXmhwjZcYMwBQMnzXXKImYY3gXbIJLklDoP0rMsMO/z3YUONCxQRO1f
         +dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350326; x=1760955126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdLBpMQJKF/WdkdrgqI4Lr7gfqMU0n7ItqvnZUJi0J8=;
        b=dQNksSUp6pGOdd5OtPIUb5KTyLCo1SMoMqgzSpWmW2X72FA8T5lxN1NLgG9zyOirrJ
         vaP+ayDXjUK7YUKACkLM+9NMZpMRB2MSNJIS6MAGTqucpDsqjvgO9QsCc9OCWS6Wnc0G
         OGHFB1ksz1m5N965BddbNZPQZEmnlT0PRuqhJCPz/ugctkmk5PiIlQgK/mPB+sLL+VbA
         5CEpw1OgZcRTGhJ5/EDzT8241WTQIf+EEaGyA8/RNq/kK+mciPg6nzVI8jSAALlEXSzL
         IOz8Tbgmm+0wdo0qn5LTk8lSIr34OgjBz5Jo8CGGg5jdImGDxd+ZohKkGs//ulZJJbXs
         g8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5SO3Tgnk2Hf1jTyRT0ED5fA8rMP5SskVqQwr8+9nGwP0+EveYe50b9/A4QIlFJDfKyFNkumcczzjdKvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09tCotYv7PYOAoZt0qj/VK8F1S5X7+fl89dXaFH5fUT0VjLRV
	v09dwlpHzjOnkuLn3Zevu+kNIKs63/OiRiZfN1A00c468SQc06d6f1yHv92sjUmMJZUNx8JLH1X
	+l+KtV01VKcRrs5z/4jHXsj4+mE6LyVWFzaY8vkCVEw==
X-Gm-Gg: ASbGncuUu8TskcOsKI2IMavcnfKigK/LZf/nMegMLdX33TekvzwcNpH/IIP/j3Q/Q4T
	F9YwrGhkgGPexL7JOPVujOUHOl+L31s9IwWrrSQjn0xKVyIoxVHo/dfhig/RfjZc8OaW2V+dhwW
	co4L9JaGHJX3QietZiLuW+7D/+VVqEOD4LR4MR6iPde5PEa4FgLwe1E+8BF0lc7R7iyw+HMrr04
	Xb0fGnZYs+Yum50vP4jOM5e1bsug75IHtY14rEK
X-Google-Smtp-Source: AGHT+IGgRJrGAZEzxavCYvBvMxkV4C3SuTl/tY5kwvQvzOJPw8FV39401eLsZgGg76AQQApcgWo2R0o9i9pCt7zAw68=
X-Received: by 2002:a2e:bea5:0:b0:336:b941:4ab1 with SMTP id
 38308e7fff4ca-37609d788ccmr52889461fa.17.1760350325946; Mon, 13 Oct 2025
 03:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-am62lx-v6-0-29d5a6c60512@ti.com> <20250912-am62lx-v6-2-29d5a6c60512@ti.com>
In-Reply-To: <20250912-am62lx-v6-2-29d5a6c60512@ti.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 12:11:54 +0200
X-Gm-Features: AS18NWCXTgDlcXu1qYOFDjPkHsaBIb9mh58rrY4q-gih-VvDw6C14D0uT1gunyA
Message-ID: <CACRpkdaG02uXd8q5shNJ1LS2R0hV52OcQLY0MmXoihJYU90zWg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] dt-bindings: pinctrl: pinctrl-single: add
 ti,am62l-padconf compatible
To: Bryan Brattlof <bb@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, 
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:40=E2=80=AFPM Bryan Brattlof <bb@ti.com> wrote:

> Add the "ti,am62l-padconf" compatible to allow for some changes in the
> driver in the future when needed.
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

This patch 2/4 applied to the pinctrl tree.

Yours,
Linus Walleij

