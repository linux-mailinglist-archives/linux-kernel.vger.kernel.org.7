Return-Path: <linux-kernel+bounces-735364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C99B08E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C58C179175
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951C2E9EB8;
	Thu, 17 Jul 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qUywYP61"
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF762E88AF;
	Thu, 17 Jul 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759110; cv=none; b=o2pKMm2/cMzNKPYIIVtv/d3jocvywRwd4r/UydreeeUcK5aKewDKMjLfydxYQlfpBa4b/EK/6ro4ET2hEoVmTwK1GDsXX/zF5MHSlSBcJd4qOOgZYg9qMVH06V0gkirTzXRgNz4n8GnaNAHb5wCCG22mO2Z+yn+Obujg4wKAZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759110; c=relaxed/simple;
	bh=aPEWDW3DKbruNkNr+5qftKrpi1xMqYprC+1aHTuSLYw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMUMTxdQaRTk15f6Tvk3pkntHFrBV6GiBG9N+NWdLXGZxuo4GGL1mrOBM+e5bOE/eADu7BVxL9NGH7qFr8TtFi0eVpK67ZTKHWjs7OvvoXD+z5HaeJnyAeBnykKEphMY2Zg1RZoBRxo4kKe4Ywof1/bBfD+85eZK+GAMUk9Pn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qUywYP61; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1752759105; x=1753018305;
	bh=aPEWDW3DKbruNkNr+5qftKrpi1xMqYprC+1aHTuSLYw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qUywYP613MdGorQ6Skw0P4OHml0OlX7xMq8/HtjRKCM0b4AnphpKQ8UQj05AVyOKq
	 Jvo/77m/3rzY9zTxNRdadHYf9XjSJ29YEs/9JfkAAl6QOpnDiwU01b8vKud06URERr
	 z6DV53QMPqWQSKKHKwiJsuahKpuCzzCcVXnqkoZDi+POZzOdrkPMoYbfadJM15V2Kt
	 8HsLFlM2KSqTviUwbfNyCUm9iFC1OhvF0oNimT4jLkCZZX2jI+834P4C6fi2ienf6d
	 UE4cObV7oUVTBMGyLXdU6HOJ+KLLzKoH85QIQqF1NsDxbsWnwuGzClUkChQdgqHcZf
	 4xQy/wPq/eiHg==
Date: Thu, 17 Jul 2025 13:31:40 +0000
To: Andy Shevchenko <andy.shevchenko@gmail.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
Message-ID: <pf5Z61lF8AhA7lEZ3mew6aSShDnuQUe_da_gGIcw6cftOM0kuxDYHrnIbiOA91kHYw2RCQP4MvqOkubyJisqu8MmfcFI8yB5bXagfEO-U_Y=@protonmail.com>
In-Reply-To: <CAHp75Vf8NzYRMeM=+S4p9LGnOd4iXcdw93hBjd=Rn=LqBXgwgA@mail.gmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com> <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com> <CAHp75Vf8NzYRMeM=+S4p9LGnOd4iXcdw93hBjd=Rn=LqBXgwgA@mail.gmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: c4341d71dd1799d4c6fdd96eeabe45193f82ce56
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, July 10th, 2025 at 9:58 AM, Andy Shevchenko <andy.shevchenko@g=
mail.com> wrote:

> On Thu, Jul 10, 2025 at 11:06=E2=80=AFAM Yassine Oudjana via B4 Relay
> devnull+y.oudjana.protonmail.com@kernel.org wrote:
>=20
> > Add a driver for sensors exposed by the Qualcomm Sensor Manager service=
,
> > which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> > include accelerometers, gyroscopes, pressure sensors, proximity sensors
> > and magnetometers.
>=20
>=20
> First of all it's almost 2kLoCs, it's on the edge of unreviewable
> code. Please, try to make 3+ patches out of this one.
> Second, take your time and check what your code is using from the
> kernel internal libraries and APIs and follow IWYU principle when
> including headers.

I can cleanly split it into 2 patches by putting the QMI components
in a separate patch. Not sure about 3+ patches but will try my best.
Will review includes.


