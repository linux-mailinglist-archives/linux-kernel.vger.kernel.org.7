Return-Path: <linux-kernel+bounces-741434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29E6B0E40A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BBD6C771D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6694F284B3B;
	Tue, 22 Jul 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IyFNcn2t"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070F727A121;
	Tue, 22 Jul 2025 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212164; cv=none; b=GkSxSDy/FJO6TXdHsJkxOo9UD7DAAePuI9QGHLV0pwsWf9jH4me7JNiuY0kv9P3W8bwLytvZG6YRDzBz7xw0A+A0xNxML18XSembIvjlxLdCvvZbEa5yGlkjFfe+AoSmTN9ipvggL0+UYMMJQH7zyUwn9PY2lLsL5c65QuOW/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212164; c=relaxed/simple;
	bh=UvOZsSrmkVob7mhfqKZDvDapgHkpBjhslNKR9fQd+d4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AsJbHjm97YnbObFnd0LCuHjJtdgPD50I7gn9XGTu5oUIxbK9i7uC6Y880Dq2GBTfpZHYKhsgaBWVRFgVsrLC6y6VNs500e4WHqi0terghho3OIiXtETJhDHQeQgeXgSlHqbC8YCF5YzsbMjIeAQsrvSnzNbxccE2mskAatgLhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IyFNcn2t; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753212159; x=1753816959; i=markus.elfring@web.de;
	bh=TzcPuycKXXgv5EkPLwDQPcA27NtZVKs97QYOqS3tE94=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IyFNcn2tiYJWTID/KX63Hix+/kjy8/oZNeDE6M1MHn3Gzj2oyjUa8jSV+jq89QL9
	 x6EWXg/Z3+jT9JHSIbkxD11OCQa/FWrELXaBmc8S3rKTh4KYgDJUuKz5KC3t7PfLl
	 vm94BMaxMRH0HlWd109q+VJ7vcbJpAN4YcjS2uP1dLeStZ7MeCy4rTl7UeQcFoIUO
	 0emtkXaLO/tjEFMWNsvWd3R7i8f0E80Jzn9fg49/pqDzVjj+9eQe/P+SKQJwQViwD
	 gGuRmPzv2aJBOoPMWWRVz/bFW3v5AfVGFZYHe9r8eHsD3CWXcVGoACiq8lB2r5onT
	 kuNF61xd/vuX5KWuEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mgzeb-1v5PFL46Zh-00jwz2; Tue, 22
 Jul 2025 21:22:39 +0200
Message-ID: <a674f481-f954-4e32-8336-bb3d9ae8c68c@web.de>
Date: Tue, 22 Jul 2025 21:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Takashi Iwai <tiwai@suse.de>, Erick Karanja <karanja99erick@gmail.com>,
 linux-sound@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 LKML <linux-kernel@vger.kernel.org>
References: <87ms8wo991.wl-tiwai@suse.de>
Subject: Re: [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87ms8wo991.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l9saqFgR1gBJoaJD+ChKgnVgwPwGjOfdh4I6Igs/Io1ZzPm0U3Z
 ZF8az8HKMbLOfB7MSZt45t7QdUGg6QDMgjHjusybij0PIRO+ALtjMLZU33SP9GYRoGuPQok
 Qjma4k45PqkM66C/RWiqP9VyoTe+f/Z+FGS2JE7fiDxZl5VcLIG2+6i8EdIf6U063bH8B79
 0RH5TuIzlPCRj+DcIdqhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ku05v4Rbpjg=;V+PLXWuCEjW7AoAM7IezNBvqj6p
 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

=E2=80=A6
> > +++ b/sound/usb/qcom/qc_audio_offload.c
=E2=80=A6
> > @@ -1865,8 +1865,8 @@ static void qc_usb_audio_offload_disconnect(stru=
ct snd_usb_audio *chip)
> > =20
> >  	/* Device has already been cleaned up, or never populated */
> >  	if (!dev->chip) {
> > -		mutex_unlock(&qdev_mutex);
> >  		mutex_unlock(&chip->mutex);
> > +		mutex_unlock(&qdev_mutex);
> >  		return;
> >  	}
> > =20
=E2=80=A6
> In anyway, I applied the patch now.

How do you think about to refine this function implementation another bit
by using an additional label like =E2=80=9Cunlock=E2=80=9D rather than kee=
ping duplicate
source code?


Regards,
Markus

