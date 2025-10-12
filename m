Return-Path: <linux-kernel+bounces-849629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D902BD08AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2FD3BBF02
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3162EDD7E;
	Sun, 12 Oct 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i10D8LAz"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55501DF252
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290653; cv=none; b=nNhJJgs/vENj/oKDY0tFFcidHySDiZegw5U5SeeHqgV7fRzCRb70oIUmJoAOR1EjyjWQhMR5Q0wqYanmBIdN2l7ATUfSbiMp/9xoNRgRnQq7A4+Np5ASyPwNxzyuBLplQQCEzR33Nmzpfcg/QgbF6YClM1l7YAlDgBN3pyPQqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290653; c=relaxed/simple;
	bh=wQf6CUx6iYNtn0zMxIL285xU6GTttxgQB+eMaEn+Nqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW7jJ/KGEjOxAiQZS4wbPCZCWKYEpbm7icqAZCTarBU/EopW2gAuKth5iOoLb2lE3WnMBUOU3ryDLQM/uOr4AC7EebYVmJuDJ0dL3cBlp4Tt5IA4L+nmDRo66vD3TatWV0mHLZnicE8erejXRQBLPqED1Yci0G6cofL8zL7qU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i10D8LAz; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso7100418a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760290648; x=1760895448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjN46mR7vmbfRcA2+LhyFdkXLDPT8VQfkzRMb9fR+Rg=;
        b=i10D8LAzgSz5tmgbQycsZnksVhgTLRSff7nDR8WEHKl56VqacKuVViXYgHdLGw7qr6
         +WglBTINupcFWC0WNHYED19lDFMXmaB+X06lxi6u6RHVtSNj8KyNUN891znZsT4CPt7r
         6OJiBZnlZ0G9mb2Rg0GavlyAwlnFKpZByhRKxkKgQ3KeSH1iYH9gKD63n4QCcRp9ZZIX
         WZgc1GdfwIJpjhDur22iGOkrpcG2J6z12LIYodqO+4yAx++Y6pOeDVFIF8Ljg3V4eHLn
         1MwT00JzXl0nctbG2/N23Oqp6W7EWp3tcOQ+9IeJdjGn3n/6oFaevGFb7tbsX6r+fI4J
         STTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760290648; x=1760895448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjN46mR7vmbfRcA2+LhyFdkXLDPT8VQfkzRMb9fR+Rg=;
        b=RrZktV6as2kaEp/gXoxHA7KASrAt2z77JrKRirw97MIbCu0MwZEW2gkZugwiaoHFPg
         LTwa1cUUGaQKA5D+bk+tIUdGEl4Rns6amXAWxANqQrUf2agVRYaVw+4vlnI38BkzNmQY
         twFQzbgha8kKkUkDEJ7swZPMf1137WfyLZ9d2w6u2ZPlmX3kGPeMPgnCoGkyqH1QQCmR
         c24FN3qxP5jVyotCz1FoHzH7QH7WsNw8LFFT9gQWK+C+gA59FmKbxH7+q+Ovy0cn6Fsh
         60Gzz1AhkpyjPfu/f3KLVCkJUkbkeVzjLGJqNmYKSt3OsrY7oVhZ06xNY7xZ1/L0TVEL
         uKhA==
X-Forwarded-Encrypted: i=1; AJvYcCXaMJTDcZK3iPaMcUAlHxNpcKsFtCcLQA0M8XXeudvla9buColnGJJNLZe1OBoH0UpX8prSvGN5kS1Xho0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSh0Ub6PlG7F21KR7LyUM3b28EDN/778M0AwFSK2sKz+ZfeBF
	6TCMNjgUrxuraB/lvyJNtL96NWtdu+/jG8jQyF5wrivslKJR0Pvh/ZD0LLpjqHLXD728IhVbJIv
	UfFd9guin6H0TwnAI6rVBPbNNMRS92VA=
X-Gm-Gg: ASbGncv0Xa8lgNWGYNmTd6qIiNEntv+qJ1ANvYhU27MIuYw2MebakR0awY3pEntxHYn
	nRcwDdfWwyhhYc0ihFFfwxQrgo/wVAec1/0himZrDmZElfhlbqetZYHjPynJN/JDInQPGlkP1DS
	U5oHhnx7mU8S1Dz8FXkHLx6HMfo3CLUFRDQcH2EepObbVb+tJYK9Z9H54wKLhWh1x+LHYr6nYeZ
	xGelO5u3ZOBjzJseN9LXKwwBuS1dT2JUoCx
X-Google-Smtp-Source: AGHT+IGFP/EgOGkWxqjUos/OJLXKzFze7OmeAssC7kBZ/7quZxkALgbxBsS2MKonlO9lkxUJo4zvtwxsst0X4NFCXYo=
X-Received: by 2002:a17:906:c143:b0:b40:bdc3:ca04 with SMTP id
 a640c23a62f3a-b50baba84camr2323169866b.0.1760290647947; Sun, 12 Oct 2025
 10:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com> <20251012180644.019616c9@jic23-huawei>
In-Reply-To: <20251012180644.019616c9@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sun, 12 Oct 2025 23:07:16 +0530
X-Gm-Features: AS18NWBpLXveHlQdIhTnFbX7i56JOrqOKowAXbKZ3PnsuA7_QAtU4BLr2PqKRcI
Message-ID: <CAHc1_P4L2oiM09YhewH69GHcVW667b0xW5eeH9+UY0xi2aO28w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 10:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Wed,  8 Oct 2025 08:47:36 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
>
> > The appropriate LED pulse width for the MAX30100 depends on
> > board-specific optical and mechanical design (lens, enclosure,
> > LED-to-sensor distance) and the trade-off between measurement
> > resolution and power consumption. Encoding it in Device Tree
> > documents these platform choices and ensures consistent behavior.
> >
> > Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> >
> > Changes since v1:
> > Add unit suffix.
> > Drop redundant description.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.=
com/
> > ---
> >  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max3010=
0.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > index 967778fb0ce8..5c651a0151cc 100644
> > --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > @@ -27,6 +27,11 @@ properties:
> >        LED current whilst the engine is running. First indexed value is
> >        the configuration for the RED LED, and second value is for the I=
R LED.
> >
> > +  maxim,pulse-width-us:
> > +    maxItems: 1
> > +    description: Pulse width in microseconds
> I continued the discussion on v1 but just to make sure it is not
> missed, add a bit more here briefly touching on factors that govern what
> the right value is here.
I have considered the feedback from v1 and updated the description
with suggested factors. I have shared the v3 patches with updates for your
review.
Thanks and Regards,
Shrikant
>
> > +    enum: [200, 400, 800, 1600]
> > +
> >  additionalProperties: false
> >
> >  required:
> > @@ -44,6 +49,7 @@ examples:
> >              compatible =3D "maxim,max30100";
> >              reg =3D <0x57>;
> >              maxim,led-current-microamp =3D <24000 50000>;
> > +            maxim,pulse-width-us =3D <1600>;
> >              interrupt-parent =3D <&gpio1>;
> >              interrupts =3D <16 2>;
> >          };
>

