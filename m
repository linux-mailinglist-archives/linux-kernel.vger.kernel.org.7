Return-Path: <linux-kernel+bounces-784872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E2B342BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CB42040DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32DB288502;
	Mon, 25 Aug 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCY7EQuE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A999274FC1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130579; cv=none; b=X51xReHPRWLj4Wh5+ulgrzA/RUha1cxWZfeveyOuDaCF+JIfPwZTp+YMkocY6s0Xh6lsAWjaS2MWLw1e+czpYR5PKlIWZhlt25ciUyji59LNHipBmJ7UCO8uQIJ1uKtgACmF49ifmlDzuLnqdMx4PIob7u9fU/+uvIf+ywyg9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130579; c=relaxed/simple;
	bh=z0lNAkdycMWr/VBF2cxLpwLcBbkQKrhLX9nJ1Ouwo1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2IlvyvL/9LVYaAy5V7XpoyL7AnCZODDt/Pj4U9U3undmrvrD+vWpFq3baNdg8bK2wWjywjdQsBV/hJov6J+KYMfjOXK3/SDYxm1E7x4X3O5SFYP8uyrGV84V8i3kvlnoTDrjBHT4V9ZnA+7t22wQZSxXmxkrXEJe1xIFmcHDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCY7EQuE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756130576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z0lNAkdycMWr/VBF2cxLpwLcBbkQKrhLX9nJ1Ouwo1w=;
	b=TCY7EQuE4nGozmZ14hVtQeLR/7RK3wdaZShVbc7OvNWceF9zLgfF3unjLITZYsyOW6VJZJ
	WyXRVueeF3miLrOZ6cQq5GredvjpcoV/YINafhywYA34rBYSwWj28i1dsNwIfgUuxkZOhz
	Q5n0/lXhgABVZoHQkCD3DBHvKwVErSs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-FHAGiWmfM46Bxf8aqbEw-w-1; Mon, 25 Aug 2025 10:02:54 -0400
X-MC-Unique: FHAGiWmfM46Bxf8aqbEw-w-1
X-Mimecast-MFC-AGG-ID: FHAGiWmfM46Bxf8aqbEw-w_1756130572
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55f46d2ae2dso650902e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130572; x=1756735372;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0lNAkdycMWr/VBF2cxLpwLcBbkQKrhLX9nJ1Ouwo1w=;
        b=gNI5125x1MOBMaCI5favI3nPl9gjzi97k8S+mqMhUxhUfuYqPJQlFiVGI+uY/PqGtS
         r/EZVZiXJselcWmrs7SAdEYuTc/+0WfBCgunOp7G1JRn+2/izfDOHGpvFhk1iN8gScbQ
         ob6YZohGDkPTUpd6TbrvR71NDDNdjlkd0OX4NEoC2QfAH44VEdNgdWShL3rb3wR4mRJF
         jftfNg9ANRFcTkc/9ISLfw9w5IU8irYUs3pUdhU4DWGhQLZW9z/deuvGrOGCS6CwyBFQ
         HSEjZ3T0n5z2UnddAkc6wbFRsJSKDlDzWrLgDmsCnL3CErjdMEaKxztF/ow8dni9Urvr
         xUUQ==
X-Gm-Message-State: AOJu0Yy5LilqK4Y0Fj15zPJ62Jhjyf48E+zqX8fc4Zu2SK7+uEoOLH22
	Y//oz1OT5SJRVS+auEezLDrL0Mt4RmmrBFm4NlKh3QEM0/I+SVkacL32PAIyxSSqT0BRWPqMDlC
	79oz/xMFJsduEUhth0bzGM4ozeXEb0HmUju97oEOZODDDQGtvBtCv9u2G8urptTXMsg==
X-Gm-Gg: ASbGncuBjKhH+wXg9byJMLmZ0qWPoG0YqPVjh9JMFFR3hwlKLlL0kCWsrf9CGgAjv3U
	3w/ZW3F8GP+/loFCeGjnoUaW5hVmzRpKDrBDZcm6WtOOZjYbhcjkvsiPWcnKKQbHlZ0Fn9BqncX
	reJL/hazi4BJSfGtgin2nKOo8Y6jOyvKJO7p5GsIS+2ao48mv8XGuoqpu5hU49LV+jkJyT09Zw2
	BXDV6KsEEX3dypM5X4VplhmDkUuLcIKTa8QMMUE9PG9kX/eVDthZE7frITdLqKXYglHe+cfyEQA
	35NlUqfqUfh8tppnJTUwGjU78+D2Hmuf/3baSWcYCK7mUXQowLdhk8xZK1PedT/qRA==
X-Received: by 2002:ac2:4e05:0:b0:55f:44b8:1ed8 with SMTP id 2adb3069b0e04-55f44b82332mr1296557e87.57.1756130571751;
        Mon, 25 Aug 2025 07:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyt5bSS1oQEIqYObefsy8rlxTFpq428dUwOG2UZY8ok4fSpnoFwzgLRoQrXqmhna3vwFjpmA==
X-Received: by 2002:ac2:4e05:0:b0:55f:44b8:1ed8 with SMTP id 2adb3069b0e04-55f44b82332mr1296544e87.57.1756130571296;
        Mon, 25 Aug 2025 07:02:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3b946df6sm1381018e87.36.2025.08.25.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:02:50 -0700 (PDT)
Message-ID: <060ae0310f6b3795856d60e36e09b1924d2fa0bc.camel@redhat.com>
Subject: Re: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid
 Automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 16:02:48 +0200
In-Reply-To: <20250825100631.uTAyvLwP@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-11-gmonaco@redhat.com>
	 <20250825100631.uTAyvLwP@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 12:06 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:02PM +0200, Gabriele Monaco wrote:
> > +=C2=A0=C2=A0=C2=A0 def fill_constr_func(self) -> list[str]:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff =3D []
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.constraints:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf=
f.append(
> > +"""/*
> > + * This function is used to validate state transitions.
> > + *
> > + * It is generated by parsing the model, there is usually no need
> > to change it,
> > + * unless conditions were incorrectly specified
>=20
> If the conditions were incorrectly specified, then they should be
> fixed in the automaton, not fixed in this generated C code.

You're right, I should reword or remove that.

> > or too complex for the parser.
>=20
> Do you have examples of these "too complex" cases? Is there a plan to
> handle them?

I wrote this before having the function/macro types, now everything
coming to my mind is covered. Anyway the parser is trying to be smart
but may not catch absolutely everything the user wants to specify.

Now the best thing to do would probably be to strictly define a grammar
and not support what isn't included in there, rather than telling the
user they can kind of tweak the function..

Good points, thanks!
Gabriele


