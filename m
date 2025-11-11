Return-Path: <linux-kernel+bounces-896185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697EC4FD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 287FC4F2496
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DED2EA732;
	Tue, 11 Nov 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUcNKuYj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2F27C84B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895870; cv=none; b=Vti7AAyL4dj5uuPxhDo8XTvXkM4MA3Wvx319oGvP7bVfOEDYHDABok7T/rF6d64euce0StXp9p22SRFJBq73/zbzzisUWX7KX0oPgqXRKcVyL1hgnrq8MIYMsA4GrjnrTrwF2rB3K189vni/rLLuI3tQrdpwJkOsTgXx4BCHzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895870; c=relaxed/simple;
	bh=EKUsdAwJdrxz602ZVyGp1qIPiRrAcjyZqiMA4kgBrW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZJW3kta1iT/+GA9lOSzJ0/kO7tiRXPGCw/xNUk+YDJd3RueW0OZccA0PzW+ydf1Mf3AyyNgtw/8YALRmHJSLe20Nsz7xiJUtGGqEftu4cszviyIJlBA/tCHGRE2isssm8y2bOiR7KpxUMF+vIOYFmf3Z1IX+fsvRrx4XUU/7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RUcNKuYj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b70bee93dc4so27281266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762895864; x=1763500664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUTN1IPcVAO8kjorL9CBDMgcIux7FnelwiSriuq3hFI=;
        b=RUcNKuYj+b2zzhU+F1qoYThc1unVCBrNw1UqjkDQbC2Iq5mdIPx73Ir1QrLlQaejh7
         IXMHkDeAzfrBIspn1USkxkiA6CNuU+22KVXZaBX35JyOCpilbkMYSTE4bEea4edVgvtw
         r3+W2IYPgiH+M7xJqXvE4duoJ2mJ9AT1ULHjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762895864; x=1763500664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUTN1IPcVAO8kjorL9CBDMgcIux7FnelwiSriuq3hFI=;
        b=AbV9PnkteWSsPrZ9a7CdX5Mjd437BekUoGjMypUW/+egDUcxMtJCkqWi38vbXE6SKh
         RgmO0s75sJGp5+kbJHv7rkSEfoLsUMy5729zelaj+Sw5ysD3MJsSusEtU6gS857pbeT/
         2ZY90QPfvXwQjyK/FcJHJLsbdrF+NGmlS4Ce1ceutVWZaNvGx63F4RMCWhEHqyMrjrHI
         0Z1C3EfOIPGEpwe5rS0/LBiaSSzFE0J8mOL1Tj/g764CnbqJ3UwaXgRtKQBAx46no70y
         x+34mYA2mBMm4ooYX3PhjUx8EmstuBJvaADjYgFGkTBRb5b/9z8hNaf8xhRbYQFt0Eoq
         JG2w==
X-Forwarded-Encrypted: i=1; AJvYcCVMpuULf6ka9dVSVapVGbU4P+dZ9lnCU74V7bO20GGkjyVm+yxiUlJDUTAgak0hHCRfdCP4HbWbheIWFd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/X0f5rKLDhpNGCp/fgFWq7/yfwS3+6kkVdAfzlsisNw+BGiXH
	DkoyfQmH5Gk9ub+puiQvDv/jMZamvGzKHYi79c9ooy3BpLQJPA6a2VuGZ4yqgqKwSW3kWyzNRH5
	JzCXjog==
X-Gm-Gg: ASbGncsDDo8PMfm+flts8XPu+KmpozA5yfvoCnMvktwEDlnZIihRRjL+IHypVf3EAAR
	FWIgj8B7nD6UJ0OyX2xYxL9WiRA6aV7Tg4QV+6e7HmYSi4wGeOsnAfQSUr5qQYb+9KmgUsVep1g
	S35hOUJR22dgVrmJajxEGj3yy+OyYHpRqkanmucqormbC65rXsr12etmN4zWXt1TKTLSgAmaJah
	q8fpBlszT3RNGmO7l7zjlhkdxMwUDbioSE5Le7IkNJrCsNzTjU2ZRCSn0jojjOE3Abr1qyMiOaq
	fdoNbtibb+T4WZL5M8D90V2beWfbB2yBIwzNKVyM1jkoJk2jsnJvZTi/XL0fHxNj9InyLpXC7+H
	GRpwLwrt2Wh6ByfVbsv9zWbO9n6sbJqX0RQVm5TMyGrMjX9BSaJ0d8PESKu+Xd5i5GWJxWytAbH
	P0HZNLh6EjFYvubms4guqpULSXXWhc5MSqGIns1mc=
X-Google-Smtp-Source: AGHT+IHKx0alXEyZ8Rgn7AcybO95Jeg15QRQ4LHtyjsjk99F8oLnT9M1ThfE6d7aXdq/2xC53lSyMQ==
X-Received: by 2002:a17:907:7f26:b0:b72:9656:f14 with SMTP id a640c23a62f3a-b7331964398mr57289666b.6.1762895864400;
        Tue, 11 Nov 2025 13:17:44 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97ea95sm1444632866b.44.2025.11.11.13.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 13:17:43 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so63574f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:17:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXy2lmq8yo/6XmUmN1J+hB0CORbd05iivJpSSSjUU3TJagSPLmS6UbjDqyNJTLSLtP6Pv4kwWHV0OkwF68=@vger.kernel.org
X-Received: by 2002:a05:6000:3106:b0:42b:4267:83e9 with SMTP id
 ffacd0b85a97d-42b4bb8f146mr449246f8f.2.1762895862835; Tue, 11 Nov 2025
 13:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111093426.1.I76ee34ac45e1469dbeb11de0d1e47d794af7dc88@changeid>
 <20251111093426.2.I47e028c511ad8fc86a44467ae228ba4fc984f7fe@changeid>
In-Reply-To: <20251111093426.2.I47e028c511ad8fc86a44467ae228ba4fc984f7fe@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Nov 2025 13:17:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJ4G=wqiWQNWO+ho1oZ7AUB4k9Z+zuwUqwDS6W2TxwqQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmh-NdLykWBjDO55hn5GSOnuJolW6S6QQ2-UkYlwdUtYFi0NaIrEDSbp0Y
Message-ID: <CAD=FV=XJ4G=wqiWQNWO+ho1oZ7AUB4k9Z+zuwUqwDS6W2TxwqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Add new FocalTech Touchscreen Chip
To: daniel_peng@pegatron.corp-partner.google.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 10, 2025 at 5:35=E2=80=AFPM
<daniel_peng@pegatron.corp-partner.google.com> wrote:
>
> From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
>
> Information for touchscreen model HKO/RB116AS01-2 as below:
> - HID :FTSC1000
> - slave address:0X38
> - Interface:HID over I2C
> - Touch control lC:FT8112
> - I2C ID: PNP0C50
>
> Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> ---
>
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

The subject of your patch should probably be a little less generic and
include the ID of the chip you're adding support for. Like:

HID: i2c-hid: Add Focaltech FT8112

Other than that, this patch looks fine to me assuming the problems
with your bindings patch get worked out. You may also want to consider
using a different email address for sending since your bindings patch
showed up in my spam folder.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

