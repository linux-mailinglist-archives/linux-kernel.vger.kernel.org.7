Return-Path: <linux-kernel+bounces-848041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D667CBCC560
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56563AAA36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026E26A1AB;
	Fri, 10 Oct 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SBj7Bb1v"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A731D435F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088135; cv=none; b=XZpwPVmaZRf2gonb6WTtenjOgR/CKOkr4Tinb5eLIST7D27qB8X3Zk9aKn8Z98p6A1SAnwIo6rmeNHJt9adp9bSMQ9aldqsN1vIT4ZqYU/o6cPsdSTzojv/oBMqjIUk5XGRRFiHQVPUp/VAEdW9Wz9q0xXQtqJB3rGsXZiwSGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088135; c=relaxed/simple;
	bh=CzvDsWLampg9VAf/LvOkvSrTcQwH28X2GWyg/bdnTyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+4qJ+xLyVCvILESDy0ocjt2zTO3qf3cwTLmzUukehw43CYehxX0xDTZUvaQPjNp0xYd2jo2w81ESsxJ3fe2NBin5YNe2hvjqGZ1g/Msm9lKY9f+soVFuN29TfS/1o7J4h4MG+wn0P8lyoqB/9PpmTJAKg25+1pR9gNUbT9wycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SBj7Bb1v; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a604fecb4so2304568e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760088131; x=1760692931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yA5OiQ4i/rUoM5qYhKKP074hHPjtqMdjdXLHXj7WRdk=;
        b=SBj7Bb1vpiiWYitrZZX8sQehzY8eXcnFeSzlViLqLuaRW96oCRybqGbdHTE1uO12Oj
         Kshjc7OgJlmbGvIRvCgj8El+qiAl5Qh+XmJclok2agMedI+JT9m86Vxl0qUhxvH+XhTL
         Rcoc5pK2EyUbVPaQMIjIkaRm4trd24Z7dGKR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088131; x=1760692931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yA5OiQ4i/rUoM5qYhKKP074hHPjtqMdjdXLHXj7WRdk=;
        b=b+j0grzqvEX1ZhXvY5DAxqX3Lv/MNPcvVDr1UJ3az1NK77hZbavSWdZSWO+S+YFHR7
         0kVO9WI3lX58DAn4lohfPuVLnsKajz7m2AkZzfF8wVZ4jE+pbHiJ1ftyeuZx5E2uB3K3
         S5tnt0+sNFBxniqj93YvGdf4IjnWYBB8FlrYJ1hTuGU8Zds4428XaVnXuTdIUuRXkGzI
         ok71vCzccWIqLDTOz5X+FrXyqeDUZciUvGzqOC5goArhwjCioI4ncMr/KA74GrQRlGTy
         OlGG9cCTNZfKY+CizlWyyf2XFjPyMeoq4m71tmXg7OZEdWtFjs4TaPq/kaL/SQH4Tyt7
         o+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXl6n4LDzOskI9HjDw3kikdtlDtpdzw84VCPJGrN5MMWGJazKood0elZe87RSGUee4gmol0vPpPAx1kGA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTU89X4MiFytkVqSI7z3/kRb5qydV9/zEQmsS2SI4GKZ60VDd/
	I51KU9fEIenqbk3VyVE6VVJtnj0d0aU1mPkVJwTs5cov53wL2vWvpQcXwsvD7VRp27LnTK2Ld9t
	3evM=
X-Gm-Gg: ASbGncs70TCYJiKlGA38hsHPrk9J8PuYYU+ZtVntmhuYYAKjLIqw/5kP+vl9QnDcq7X
	l0wN7h+Yp27AQqbenu74ZP6sWDEfGWBRJfbhDweCWwOKuvf86G7YgC6SzPaMh/8I0FwJWTDo9VY
	ExnoFYVVEVzYep/7AVLNep8UmAh0LJ6coX6SQGN7SWQM42ymCAN+9gzrEjlnDLmrbZmFUZt+Zle
	3pM29H4P97kCF01QqcCZEyzhXHxi5wYPKoGYGlaaStn8pblx4wvo+qg2fqC/hWPuRinECjErwkE
	Oi9Oxd1TSSJS+7SkELfpUR/lQ1jNGDXmot00Lapne2XTYLMc59ieZnTL55NAQp5o6impTLyNW9y
	Px+apcx+f+xe3HcGfUj1mvpqJ8OxuBTjm+dP2A+psYVZl+HHSRAVar0kacpKGuS/TLiBxNrXJDC
	xYLS0=
X-Google-Smtp-Source: AGHT+IE4u5LXNMJSBPonyshZ9UjQdFBjTXilsEzwwL7itUmu6tmqe/tKoBt+MHFZfu4vuH/2oL4dPQ==
X-Received: by 2002:a05:6512:4015:b0:58b:246:7db4 with SMTP id 2adb3069b0e04-5906d8924b6mr3485979e87.17.1760088130807;
        Fri, 10 Oct 2025 02:22:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908857803csm694415e87.108.2025.10.10.02.22.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 02:22:10 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso1949423e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:22:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMOmW3RClCTQd+CblignjywKs1nUsaEQMmoh5TS0lyAjTdzHsKTl4ktae6PwHOGCBP2NVxW+wY7YR8jEQ=@vger.kernel.org
X-Received: by 2002:a05:6512:3f12:b0:576:dc1e:d6c9 with SMTP id
 2adb3069b0e04-5906d87baafmr2977784e87.11.1760088129654; Fri, 10 Oct 2025
 02:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CO1PR18MB463349680603EC2C284B7FEFF71BA@CO1PR18MB4633.namprd18.prod.outlook.com>
 <CANiDSCtwhpCAgQY73phJE0okN+Smv_AbA6Q+w2tuTVW1_qcbDg@mail.gmail.com> <wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn@7jmk66eibia5>
In-Reply-To: <wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn@7jmk66eibia5>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 10 Oct 2025 11:21:56 +0200
X-Gmail-Original-Message-ID: <CANiDSCuwo2NnA_fcVVeTw2hSJn=KfxbuxkwjU7=+uEhasNzpzg@mail.gmail.com>
X-Gm-Features: AS18NWAPzHNRmyOVCv95sZ7F2KHolfcZcGSMyykNA4IF0XlRHqwOJmhypj3CWW4
Message-ID: <CANiDSCuwo2NnA_fcVVeTw2hSJn=KfxbuxkwjU7=+uEhasNzpzg@mail.gmail.com>
Subject: Re: Realsense camera patch
To: =?UTF-8?Q?Wojciech_G=C5=82adysz?= <kontra.wojciech.gladysz@gmail.com>
Cc: Gladysz WojciechX <wojciechx.gladysz@realsenseai.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yogev.modlin@realsenseai.com
Content-Type: text/plain; charset="UTF-8"

Hi Wojciech


Thanks for collecting the lsusb info. Unfortunately neither b4 nor
patchwork seem to understand the patch

ribalda@ribalda:~/work/linux$ b4 shazam
wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn@7jmk66eibia5
Grabbing thread from
lore.kernel.org/all/wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn@7jmk66eibia5/t.mbox.gz
Analyzing 4 messages in the thread
No patches found.

https://patchwork.linuxtv.org/project/linux-media/patch/wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn@7jmk66eibia5/
The page URL requested
(/project/linux-media/patch/wm5gfxhvifqamhatze5pfeyzfm6hnyknd4ww2bf75nwmw3okyn%407jmk66eibia5/)
does not exist.


Maybe you can try one of these two methods:
https://git-send-email.io/
https://b4.docs.kernel.org/en/latest/contributor/overview.html


Thanks :)



-- 
Ricardo Ribalda

